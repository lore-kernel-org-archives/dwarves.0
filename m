From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] Add scncopy - like object copy but tries not to change section content
Date: Mon, 11 Jan 2010 15:50:30 -0500
Message-ID: <1263243031-19401-1-git-send-email-pjones@redhat.com>
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

This adds scncopy, which is like objcopy with some differences:
- it doesn't try to update section contents, but does try to
  update program headers and such to correctly reflect the section
  contents.
- it doesn't necessarily try to create a binary eu-elflint will like.
  If you don't copy a required section, it won't make it for you.

TODO:
- Make it possible to copy sections to an already existant binary.
- Make phdrs only copy if they're needed, and/or modify old phdrs to
  point to new sections
- Make sure nothing is missing from fixup_dynamic()
---
 elfcreator.c |  297 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 elfcreator.h |   20 ++++
 scncopy.c    |  125 ++++++++++++++++++++++++
 3 files changed, 442 insertions(+), 0 deletions(-)
 create mode 100644 elfcreator.c
 create mode 100644 elfcreator.h
 create mode 100644 scncopy.c

diff --git a/elfcreator.c b/elfcreator.c
new file mode 100644
index 0000000..c284b52
--- /dev/null
+++ b/elfcreator.c
@@ -0,0 +1,297 @@
+/*
+ * Copyright 2009 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * Author: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ */
+#include <dlfcn.h>
+#include <gelf.h>
+#include <stdio.h>
+#include <strings.h>
+#include <string.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <assert.h>
+
+#include "elfcreator.h"
+
+struct elf_creator {
+	const char *path;
+	int fd;
+
+	Elf *elf;
+	GElf_Ehdr *ehdr, ehdr_mem;
+
+	Elf *oldelf;
+	/* just because we have to look this up /so/ often... */
+	Elf_Scn *dynscn;
+	GElf_Shdr *dynshdr, dynshdr_mem;
+	Elf_Data *dyndata;
+};
+
+static void clear(ElfCreator *ctor, int do_unlink)
+{
+	if (do_unlink) {
+		if (ctor->elf)
+			elf_end(ctor->elf);
+		if (ctor->fd >= 0)
+			close(ctor->fd);
+		if (ctor->path)
+			unlink(ctor->path);
+	} else {
+		if (ctor->elf) {
+			elf_update(ctor->elf, ELF_C_WRITE_MMAP);
+			elf_end(ctor->elf);
+		}
+		if (ctor->fd >= 0)
+			close(ctor->fd);
+	}
+	memset(ctor, '\0', sizeof(*ctor));
+}
+
+ElfCreator *elfcreator_begin(char *path, Elf *elf) {
+	ElfCreator *ctor = NULL;
+	GElf_Ehdr ehdr_mem, *ehdr;
+	GElf_Half machine;
+
+	if (!(ctor = calloc(1, sizeof(*ctor))))
+		return NULL;
+
+	clear(ctor, 0);
+
+	ctor->path = path;
+	ctor->oldelf = elf;
+
+	ehdr = gelf_getehdr(elf, &ehdr_mem);
+	machine = ehdr->e_machine;
+
+	if ((ctor->fd = open(path, O_RDWR|O_CREAT|O_TRUNC, 0755)) < 0) {
+err:
+		clear(ctor, 1);
+		free(ctor);
+		return NULL;
+	}
+
+	if (!(ctor->elf = elf_begin(ctor->fd, ELF_C_WRITE_MMAP, elf)))
+		goto err;
+
+	gelf_newehdr(ctor->elf, gelf_getclass(elf));
+	gelf_update_ehdr(ctor->elf, ehdr);
+
+	if (!(ctor->ehdr = gelf_getehdr(ctor->elf, &ctor->ehdr_mem)))
+		goto err;
+
+	return ctor;
+}
+
+static Elf_Scn *get_scn_by_type(ElfCreator *ctor, Elf64_Word sh_type)
+{
+	Elf_Scn *scn = NULL;
+
+	while ((scn = elf_nextscn(ctor->elf, scn)) != NULL) {
+		GElf_Shdr *shdr, shdr_mem;
+
+		shdr = gelf_getshdr(scn, &shdr_mem);
+		if (shdr->sh_type == sh_type)
+			return scn;
+	}
+	return NULL;
+}
+
+static void update_dyn_cache(ElfCreator *ctor)
+{
+	ctor->dynscn = get_scn_by_type(ctor, SHT_DYNAMIC);
+	if (ctor->dynscn == NULL)
+		return;
+
+	ctor->dynshdr = gelf_getshdr(ctor->dynscn, &ctor->dynshdr_mem);
+	ctor->dyndata = elf_getdata(ctor->dynscn, NULL);
+}
+
+void elfcreator_copy_scn(ElfCreator *ctor, Elf *src, Elf_Scn *scn)
+{
+	Elf_Scn *newscn;
+	Elf_Data *indata, *outdata;
+	GElf_Shdr *oldshdr, oldshdr_mem;
+	GElf_Shdr *newshdr, newshdr_mem;
+
+	newscn = elf_newscn(ctor->elf);
+	newshdr = gelf_getshdr(newscn, &newshdr_mem);
+
+	oldshdr = gelf_getshdr(scn, &oldshdr_mem);
+
+	memmove(newshdr, oldshdr, sizeof(*newshdr));
+	gelf_update_shdr(newscn, newshdr);
+
+	indata = NULL;
+	while ((indata = elf_getdata(scn, indata)) != NULL) {
+		outdata = elf_newdata(newscn);
+		*outdata = *indata;
+	}
+	if (newshdr->sh_type == SHT_DYNAMIC)
+		update_dyn_cache(ctor);
+}
+
+static GElf_Dyn *get_dyn_by_tag(ElfCreator *ctor, Elf64_Sxword d_tag,
+				GElf_Dyn *mem, size_t *idx)
+{
+	size_t cnt;
+
+	if (!ctor->dyndata)
+		return NULL;
+
+	for (cnt = 1; cnt < ctor->dynshdr->sh_size / ctor->dynshdr->sh_entsize;
+			cnt++) {
+		GElf_Dyn *dyn;
+
+		if ((dyn = gelf_getdyn(ctor->dyndata, cnt, mem)) == NULL)
+			break;
+
+		if (dyn->d_tag == d_tag) {
+			*idx = cnt;
+			return dyn;
+		}
+	}
+	return NULL;
+}
+
+static void remove_dyn(ElfCreator *ctor, size_t idx)
+{
+	size_t cnt;
+
+	for (cnt = idx; cnt < ctor->dynshdr->sh_size/ctor->dynshdr->sh_entsize;
+			cnt++) {
+		GElf_Dyn *dyn, dyn_mem;
+
+		if (cnt+1 == ctor->dynshdr->sh_size/ctor->dynshdr->sh_entsize) {
+			memset(&dyn_mem, '\0', sizeof(dyn_mem));
+			gelf_update_dyn(ctor->dyndata, cnt, &dyn_mem);
+			break;
+		}
+
+		dyn = gelf_getdyn(ctor->dyndata, cnt+1, &dyn_mem);
+		gelf_update_dyn(ctor->dyndata, cnt, dyn);
+	}
+	ctor->dynshdr->sh_size--;
+	gelf_update_shdr(ctor->dynscn, ctor->dynshdr);
+	update_dyn_cache(ctor);
+}
+
+typedef void (*dyn_fixup_fn)(ElfCreator *ctor, Elf64_Sxword d_tag, Elf_Scn *scn);
+
+static void generic_dyn_fixup_fn(ElfCreator *ctor, Elf64_Sxword d_tag, Elf_Scn *scn)
+{
+	GElf_Shdr *shdr, shdr_mem;
+	GElf_Dyn *dyn, dyn_mem;
+	size_t idx;
+
+	dyn = get_dyn_by_tag(ctor, d_tag, &dyn_mem, &idx);
+	shdr = gelf_getshdr(scn, &shdr_mem);
+	if (shdr) {
+		dyn->d_un.d_ptr = shdr->sh_addr;
+		gelf_update_dyn(ctor->dyndata, idx, dyn);
+	} else {
+		remove_dyn(ctor, idx);
+	}
+}
+
+static void rela_dyn_fixup_fn(ElfCreator *ctor, Elf64_Sxword d_tag, Elf_Scn *scn)
+{
+	GElf_Shdr *shdr, shdr_mem;
+	GElf_Dyn *dyn, dyn_mem;
+	size_t idx;
+
+	dyn = get_dyn_by_tag(ctor, d_tag, &dyn_mem, &idx);
+	shdr = gelf_getshdr(scn, &shdr_mem);
+	if (shdr) {
+		dyn->d_un.d_ptr = shdr->sh_addr;
+		gelf_update_dyn(ctor->dyndata, idx, dyn);
+	} else {
+		remove_dyn(ctor, idx);
+		dyn = get_dyn_by_tag(ctor, DT_RELASZ, &dyn_mem, &idx);
+		if (dyn) {
+			dyn->d_un.d_val = 0;
+			gelf_update_dyn(ctor->dyndata, idx, dyn);
+		}
+	}
+}
+
+static void rel_dyn_fixup_fn(ElfCreator *ctor, Elf64_Sxword d_tag, Elf_Scn *scn)
+{
+	GElf_Shdr *shdr, shdr_mem;
+	GElf_Dyn *dyn, dyn_mem;
+	size_t idx;
+
+	dyn = get_dyn_by_tag(ctor, d_tag, &dyn_mem, &idx);
+	shdr = gelf_getshdr(scn, &shdr_mem);
+	if (shdr) {
+		dyn->d_un.d_ptr = shdr->sh_addr;
+		gelf_update_dyn(ctor->dyndata, idx, dyn);
+	} else {
+		remove_dyn(ctor, idx);
+		dyn = get_dyn_by_tag(ctor, DT_RELSZ, &dyn_mem, &idx);
+		if (dyn) {
+			dyn->d_un.d_val = 0;
+			gelf_update_dyn(ctor->dyndata, idx, dyn);
+		}
+	}
+}
+
+static void fixup_dynamic(ElfCreator *ctor)
+{
+	struct {
+		Elf64_Sxword d_tag;
+		Elf64_Word sh_type;
+		dyn_fixup_fn fn;
+	} fixups[] = {
+		{ DT_HASH, SHT_HASH, NULL },
+		{ DT_STRTAB, SHT_STRTAB, NULL },
+		{ DT_SYMTAB, SHT_SYMTAB, NULL },
+		{ DT_RELA, SHT_RELA, rela_dyn_fixup_fn},
+		{ DT_REL, SHT_REL, rel_dyn_fixup_fn},
+		{ DT_GNU_HASH, SHT_GNU_HASH, NULL },
+		{ DT_NULL, SHT_NULL, NULL }
+	};
+	int i;
+
+	for (i = 0; fixups[i].d_tag != DT_NULL; i++) {
+		Elf_Scn *scn;
+
+		scn = get_scn_by_type(ctor, fixups[i].sh_type);
+		if (fixups[i].fn)
+			fixups[i].fn(ctor, fixups[i].d_tag, scn);
+		else
+			generic_dyn_fixup_fn(ctor, fixups[i].d_tag, scn);
+	}
+}
+
+void elfcreator_end(ElfCreator *ctor)
+{
+	GElf_Phdr phdr_mem, *phdr;
+	int m,n;
+
+	for (m = 0; (phdr = gelf_getphdr(ctor->oldelf, m, &phdr_mem)) != NULL; m++)
+		/* XXX this should check if an entry is needed */;
+
+	gelf_newphdr(ctor->elf, m);
+	elf_update(ctor->elf, ELF_C_NULL);
+	update_dyn_cache(ctor);
+
+	for (n = 0; n < m; n++) {
+		/* XXX this should check if an entry is needed */
+		phdr = gelf_getphdr(ctor->oldelf, n, &phdr_mem);
+		if (ctor->dynshdr && phdr->p_type == PT_DYNAMIC)
+			phdr->p_offset = ctor->dynshdr->sh_offset;
+
+		gelf_update_phdr(ctor->elf, n, phdr);
+	}
+
+	fixup_dynamic(ctor);
+
+	clear(ctor, 0);
+	free(ctor);
+}
diff --git a/elfcreator.h b/elfcreator.h
new file mode 100644
index 0000000..7de1a98
--- /dev/null
+++ b/elfcreator.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright 2009 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * Author: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ */
+#ifndef ELFCREATOR_H
+#define ELFCREATOR_H 1
+
+#include <gelf.h>
+
+typedef struct elf_creator ElfCreator;
+extern ElfCreator *elfcreator_begin(char *path, Elf *elf);
+extern void elfcreator_copy_scn(ElfCreator *ctor, Elf *src, Elf_Scn *scn);
+extern void elfcreator_end(ElfCreator *ctor);
+
+#endif /* ELFCREATOR_H */
diff --git a/scncopy.c b/scncopy.c
new file mode 100644
index 0000000..38aaa9a
--- /dev/null
+++ b/scncopy.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright 2009 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * Author: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ */
+#include <gelf.h>
+#include <stdio.h>
+#include <strings.h>
+#include <string.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "elfcreator.h"
+#include "dutil.h"
+
+static int should_copy_scn(Elf *elf, GElf_Shdr *shdr, struct strlist *scns)
+{
+	char *name;
+	size_t shstrndx;
+
+	if (elf_getshdrstrndx(elf, &shstrndx) < 0)
+		return 0;
+	name = elf_strptr(elf, shstrndx, shdr->sh_name);
+	if (name == NULL)
+		return 0;
+
+	if (strlist__has_entry(scns, name))
+		return 1;
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int n;
+	struct strlist *sections;
+	char *infile = NULL, *outfile = NULL;
+	int fd;
+	Elf *elf;
+	Elf_Scn *scn;
+	int copy_all_sections = 0;
+	ElfCreator *ctor;
+
+	sections = strlist__new(false);
+	for (n = 1; n < argc; n++) {
+		if (!strcmp(argv[n], "-a")) {
+			copy_all_sections = 1;
+		} else if (!strcmp(argv[n], "-s")) {
+			if (n == argc-1) {
+				fprintf(stderr, "Missing argument to -s\n");
+				return -1;
+			}
+			n++;
+			strlist__add(sections, argv[n]);
+			continue;
+		} else if (!strcmp(argv[n], "-o")) {
+			if (n == argc-1) {
+				fprintf(stderr, "Missing argument to -o\n");
+				return -1;
+			}
+			n++;
+			outfile = argv[n];
+			continue;
+		} else if (!strcmp(argv[n], "-?") || !strcmp(argv[n],"--usage")) {
+			printf("usage: pjoc -s section 0 [[-s section1] ... -s sectionN] -o outfile infile\n");
+			return 0;
+		} else if (n == argc-1) {
+			infile = argv[n];
+		} else {
+			fprintf(stderr, "usage: pjoc -s section 0 [[-s section1] ... -s sectionN] -o outfile infile\n");
+			return 1;
+		}
+	}
+	if (!infile || !outfile) {
+		fprintf(stderr, "usage: pjoc -s section 0 [[-s section1] ... -s sectionN] -o outfile infile\n");
+		return 1;
+	}
+
+	if (!(fd = open(infile, O_RDONLY))) {
+		fprintf(stderr, "Could not open \"%s\" for reading: %m\n", infile);
+		return 1;
+	}
+
+	elf_version(EV_CURRENT);
+
+	if ((elf = elf_begin(fd, ELF_C_READ_MMAP_PRIVATE, NULL)) == NULL) {
+		fprintf(stderr, "cannot get elf descriptor for \"%s\": %s\n",
+				infile, elf_errmsg(-1));
+		close(fd);
+		return 1;
+	}
+
+	if (elf_kind(elf) != ELF_K_ELF) {
+		fprintf(stderr, "\"%s\" is not an ELF file\n", infile);
+err:
+		elf_end(elf);
+		close(fd);
+		return 1;
+	}
+
+	if ((ctor = elfcreator_begin(outfile, elf)) == NULL) {
+		fprintf(stderr, "could not initialize ELF creator\n");
+		goto err;
+	}
+
+	scn = NULL;
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		GElf_Shdr shdr_mem, *shdr;
+
+		shdr = gelf_getshdr(scn, &shdr_mem);
+		if (shdr == NULL)
+			continue;
+
+		if (!should_copy_scn(elf, shdr, sections) && !copy_all_sections)
+			continue;
+
+		elfcreator_copy_scn(ctor, elf, scn);
+	}
+	elfcreator_end(ctor);
+	return 0;
+}
-- 
1.6.5.2

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
