Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F049AA24;
	Fri,  2 Oct 2026 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962904; cv=none; b=jnNt2chW1LZhnVtGJ13gHCAPJKHY7HGyhX1x5tTvRjfqKHv+urH4EtUFKS7e6T8B88LcbyNnFxUmhQd6Dh/zzx3745qWAqUuz0VNcEsgZy0oKJLF9LR0yYBMzINXruuWncytK/OGYnM7cmbfWdDiU43gh5Yt9d54z99PQgjcIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962904; c=relaxed/simple;
	bh=gislmCUAdqMprkrwAswoACTj4wr4MtHzSCHs8oQf3dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTqxWzHu30METvTylvA4MbHCSjRXqUSbk0twrS8n7+51QcIvWUvbc9W2qhUcPQx4afp7XcrnIIgsjwcmD3FEREVnCnuTomlu/mPHf7FssGRF++WXGHKN+89YOmxtZDOLMoMm89/NgCu3A0bNI2df12G3K8NNMzcwLhGvloKA+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZYWJkavW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZYWJkavW"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692EbeDB1541590;
	Fri, 2 Oct 2026 17:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rSG8/
	Wxg5KOp6RfQgBIELvwIfgRuT/6JLzz3sBUt/IU=; b=ZYWJkavWCysRA55lcGfjC
	Nc9reOUmBrPUZySmLs7dunrDyNmn7b0TRWuiYtShpJWqZc0Z7JG5e2kfXYTFmbOx
	qJAvlykovY4DK9jUqmT2IzbeVCIzwvZ0G6IIaQbPCGvdqY3bRG6KqJe632ZW4GGb
	I3foq4Pj7IIag0upD7B5G4KIjmIxc4cm/TfpMpjBh8B0iBQTK5h4LVptU99gFWIG
	4jZiqrrbhOTLqLI55CpTFHU0roEFAvNvJ+kFTz3Ze4ZPVISonJgod9UuDzD8Gijg
	d1IREYCduQWc0MQS6GXpxwuoXQbV3RzTXu9AQxFSGG6Tnz3O6wnW8MVrzjrlzN7f
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4mymmvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692HZToF014465;
	Fri, 2 Oct 2026 17:41:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtqu55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:10 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 692Heked030471;
	Fri, 2 Oct 2026 17:41:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-232.vpn.oracle.com [10.154.83.232])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gx4gtqtes-9;
	Fri, 02 Oct 2026 17:41:09 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 dwarves 08/10] pfunct: Print inline site information
Date: Fri,  2 Oct 2026 18:40:36 +0100
Message-ID: <20261002174043.3823987-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261002174043.3823987-1-alan.maguire@oracle.com>
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020070
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX7LT8swhfGe02
 9YMzs+nJWnHYWHpfGdrqs8NNdaVnrqwy72qudu1lZ6KHYeC48EHTkgO3Xwpa2B9xPAVzd2yUcFg
 fdEtutYxWU66rwz80Daub3zPAQaQgqdhOeGIQnTPhQuUK7LoSnnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfXwtGRKwX/487Q
 dehpxkCoSoFqsyCt3kXmdRfl8jloDUE82Wdz6rmRTwPsTGW4kgtO8hR9UKF0ayCBHv+/zczX2Kq
 e6JwqgdzaV8nvRAofmTFXxpBXdJooqr3DE7ERrxBGfIzmd4YNsN9IYpvMJh7mOlWZ/1VmPeKj8g
 LNJVmKURanUlSEZkI9ppmMlmnII4qYBCYY0Az2j/I4BmQ7tFj/KujEt29B04BjQtL54h27r0tcz
 MZIt97jjzf8Pu1p21ijOc4jJWZcgG2jMc7fj09C0GxLd7MOrtORFmyWxQCVTlGOSXXLcykVHmIS
 NtQjb99cxJ2C+uJtL9aXtrh3hFDj1Kj0UtJ0jVUy/HpPqrpl8hTVFcIvZrdwS/vN2d186bmuELF
 50SCPathZbSXPYLuYL+Pakm3/TaVs5kiaDOEjYvfr+MxM17YEgyyDDZxHpVELrcxvdxg1DyKka7
 iXoG3sh4j/aci1/cNB0Hm/lTRrbyzu/7c4elQhW4=
X-Proofpoint-GUID: cG-Ku_KsaCo79JuXvknP_1OMruzvNp3E
X-Authority-Analysis: v=2.4 cv=DZmCOftW c=1 sm=1 tr=0 ts=6abfecb7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=WOXjmAGuJwSPRfIxSJAA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-ORIG-GUID: cG-Ku_KsaCo79JuXvknP_1OMruzvNp3E

Print information about inline sites using the --inline_sites
option, BTF only for now.  Dumps list of form

0x392c50 [.text +0x392c50] cpumask_test_cpu(int cpu [*(fbreg-40)], const struct cpumask  * cpumask [unavailable])

The address is either absolute (where address info is available
and we can compute it) or relative via BTF location info.
Following is the annotated function signature (excluding return
value since these are inline entry points).  Unavailable parameters
are marked as such.

Where ELF info is available, arch-specific registers are used, otherwise
we fall back to register numbers (reg0, reg1, ...).

Supports specifying a function name via -f, i.e.

$ pfunct --inline_sites -f ip_send_skb /sys/kernel/btf/vmlinux.inline
0x11a86bc [.text +0x11a86bc] ip_send_skb(struct net * net [reg3], struct sk_buff * skb [reg0])

If ELF info is available, it is used to show containing function;
it can also be supplied by --elf path2elf if BTF is raw as in
/sys/kernel/btf . If available, relative addresses are converted
to absolute from section base, registers are ABI-specific and containing
function displayed:

$ pfunct --inline_sites -f ip_send_skb --elf vmlinux /sys/kernel/btf/vmlinux.inline
0xffffffff821a86bc [ip_push_pending_frames+0x2c, .text +0x11a86bc] ip_send_skb(struct net * net [%rbx], struct sk_buff * skb [%rax])

We can also use the running kernel to derive current base/section addresses;
using --running [optional_module_name].  However, it is necessary
to run via sudo if kptr_restrict is set if absolute addresses and
containing functions are needed, otherwise addresses in /proc/kallsyms
are zeroed and not available:

$ pfunct --inline_sites -f ip_send_skb --running /sys/kernel/btf/vmlinux.inline
0x11a86bc [.text +0x11a86bc] ip_send_skb(struct net * net [%rbx], struct sk_buff * skb [%rax])
$ sudo pfunct --inline_sites -f ip_send_skb --running /sys/kernel/btf/vmlinux.inline
0xffffffffa9da86bc [ip_push_pending_frames+0x2c, .text +0x11a86bc] ip_send_skb(struct net * net [%rbx], struct sk_buff * skb [%rax])

The --running representation will account for kASLR, where the base
address is shifted with respect to the ELF-reported address; contrast
the --running reported address above and that reported with the --elf
option.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: Codex (GPT 5.6)
---
 pfunct.c | 718 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 689 insertions(+), 29 deletions(-)

diff --git a/pfunct.c b/pfunct.c
index 1dc88a5..b86fa97 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -7,6 +7,8 @@
 */
 
 #include <argp.h>
+#include <dirent.h>
+#include <limits.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -39,15 +41,446 @@ static uint64_t addr;
 static char *class_name;
 static char *function_name;
 static const char *base_btf_file;
+static const char *elf_filename;
+static const char *running_object;
+static bool show_inline_sites;
 
 static struct conf_fprintf conf;
 
+#define BTF_LOC_PARAM_SIGNED	0x1
+#define BTF_LOC_PARAM_CONST	0x2
+#define BTF_LOC_PARAM_ADDR	0x4
+#define BTF_LOC_PARAM_REG	0x8
+#define BTF_LOC_PARAM_DEREF	0x10
+#define BTF_LOC_PARAM_OFFSET	0x20
+#define BTF_LOC_PARAM_FBREG	0xffffffffU
+
 static struct conf_load conf_load = {
 	.conf_fprintf = &conf,
 };
 
 static struct languages languages;
 
+struct elf_register_names {
+	Dwfl			 *dwfl;
+	Dwfl_Module		 *dwfl_module;
+	char			 *names[32];
+};
+
+struct elf_symtab_ctx {
+	int			 fd;
+	Elf			 *elf;
+	struct elf_symtab	 *symtab;
+	struct elf_register_names regs;
+};
+
+struct elf_function {
+	const char	*name;
+	uint64_t	 addr;
+	uint64_t	 size;
+};
+
+struct elf_functions {
+	struct elf_function	*entries;
+	uint32_t		 nr_entries;
+	bool			 owns_names;
+};
+
+struct running_section {
+	char		*name;
+	uint64_t	 addr;
+};
+
+struct running_object_ctx {
+	bool			vmlinux;
+	uint64_t		addr_base;
+	struct running_section	*sections;
+	uint32_t		nr_sections;
+	struct elf_functions	functions;
+	struct elf_register_names regs;
+};
+
+static int elf_register_names__cache_name(void *arg, int regno,
+					 const char *setname __maybe_unused,
+					 const char *prefix,
+					 const char *regname,
+					 int bits __maybe_unused,
+					 int type __maybe_unused)
+{
+	struct elf_register_names *regs = arg;
+
+	if (regno < 0 || regno >= (int)ARRAY_SIZE(regs->names) || !regname)
+		return DWARF_CB_OK;
+	if (asprintf(&regs->names[regno], "%s%s", prefix ?: "", regname) < 0)
+		return DWARF_CB_ABORT;
+	return DWARF_CB_OK;
+}
+
+static void elf_register_names__init(struct elf_register_names *regs,
+					     const char *filename)
+{
+	static const Dwfl_Callbacks callbacks = {
+		.section_address = dwfl_offline_section_address,
+	};
+	int fd;
+
+	regs->dwfl = dwfl_begin(&callbacks);
+	if (!regs->dwfl)
+		return;
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		goto out_dwfl_end;
+	regs->dwfl_module = dwfl_report_offline(regs->dwfl, filename, filename, fd);
+	if (!regs->dwfl_module)
+		goto out_dwfl_end;
+	if (dwfl_report_end(regs->dwfl, NULL, NULL))
+		goto out_dwfl_end;
+	dwfl_module_register_names(regs->dwfl_module, elf_register_names__cache_name, regs);
+	return;
+
+out_dwfl_end:
+	dwfl_end(regs->dwfl);
+	regs->dwfl = NULL;
+	regs->dwfl_module = NULL;
+}
+
+static void elf_register_names__exit(struct elf_register_names *regs)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(regs->names); i++)
+		free(regs->names[i]);
+	if (regs->dwfl)
+		dwfl_end(regs->dwfl);
+}
+
+static uint64_t elf__addr_base(Elf *elf)
+{
+	Elf_Scn *scn = NULL;
+	GElf_Shdr shdr;
+	uint64_t addr_base = UINT64_MAX;
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		if (!gelf_getshdr(scn, &shdr))
+			continue;
+		if ((shdr.sh_flags & SHF_ALLOC) && shdr.sh_addr < addr_base)
+			addr_base = shdr.sh_addr;
+	}
+
+	return addr_base;
+}
+
+static int elf_symtab__init(struct elf_symtab_ctx *ctx, const char *filename)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->fd = -1;
+	ctx->elf = NULL;
+	ctx->symtab = NULL;
+	ctx->fd = open(filename, O_RDONLY);
+	if (ctx->fd < 0)
+		return -1;
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		fprintf(stderr, "%s: cannot set libelf version.\n", __func__);
+		goto out_close;
+	}
+	ctx->elf = elf_begin(ctx->fd, ELF_C_READ_MMAP, NULL);
+	if (!ctx->elf) {
+		fprintf(stderr, "%s: cannot read %s ELF file.\n", __func__, filename);
+		goto out_close;
+	}
+	ctx->symtab = elf_symtab__new(symtab_name, ctx->elf);
+	elf_register_names__init(&ctx->regs, filename);
+	return 0;
+
+	elf_end(ctx->elf);
+	ctx->elf = NULL;
+out_close:
+	close(ctx->fd);
+	ctx->fd = -1;
+	return -1;
+}
+
+static void elf_symtab__exit(struct elf_symtab_ctx *ctx)
+{
+	elf_register_names__exit(&ctx->regs);
+	elf_symtab__delete(ctx->symtab);
+	if (ctx->elf)
+		elf_end(ctx->elf);
+	if (ctx->fd >= 0)
+		close(ctx->fd);
+}
+
+static int elf_function__cmp(const void *a, const void *b)
+{
+	const struct elf_function *fa = a, *fb = b;
+
+	if (fa->addr != fb->addr)
+		return fa->addr < fb->addr ? -1 : 1;
+	if (fa->size != fb->size)
+		return fa->size < fb->size ? -1 : 1;
+	return strcmp(fa->name, fb->name);
+}
+
+static int elf_functions__collect(struct elf_functions *functions,
+				  const struct elf_symtab *symtab)
+{
+	uint32_t index;
+	GElf_Sym sym;
+
+	functions->entries = calloc(elf_symtab__nr_symbols(symtab),
+				   sizeof(*functions->entries));
+	if (!functions->entries && elf_symtab__nr_symbols(symtab))
+		return -1;
+	elf_symtab__for_each_symbol(symtab, index, sym) {
+		struct elf_function *function;
+
+		if (elf_sym__type(&sym) != STT_FUNC || !elf_sym__size(&sym) ||
+		    elf_sym__section(&sym) == SHN_UNDEF || !*elf_sym__name(&sym, symtab))
+			continue;
+		function = &functions->entries[functions->nr_entries++];
+		function->name = elf_sym__name(&sym, symtab);
+		function->addr = elf_sym__value(&sym);
+		function->size = elf_sym__size(&sym);
+	}
+	qsort(functions->entries, functions->nr_entries,
+	      sizeof(*functions->entries), elf_function__cmp);
+	return 0;
+}
+
+static void elf_functions__exit(struct elf_functions *functions)
+{
+	if (functions->owns_names)
+		for (uint32_t i = 0; i < functions->nr_entries; i++)
+			free((char *)functions->entries[i].name);
+	free(functions->entries);
+}
+
+static const struct elf_function *
+elf_functions__find(const struct elf_functions *functions, uint64_t addr)
+{
+	const struct elf_function *best = NULL;
+	uint64_t start_addr;
+	uint32_t left = 0, right = functions->nr_entries;
+
+	while (left < right) {
+		uint32_t mid = left + (right - left) / 2;
+
+		if (functions->entries[mid].addr <= addr)
+			left = mid + 1;
+		else
+			right = mid;
+	}
+	if (left == 0)
+		return NULL;
+	--left;
+	while (left > 0 && functions->entries[left - 1].addr == functions->entries[left].addr)
+		--left;
+	start_addr = functions->entries[left].addr;
+	for (; left < functions->nr_entries &&
+	       functions->entries[left].addr == start_addr; left++) {
+		const struct elf_function *function = &functions->entries[left];
+
+		if (addr - function->addr < function->size &&
+		    (!best || function->size < best->size))
+			best = function;
+		if (left + 1 == functions->nr_entries || functions->entries[left + 1].addr > addr)
+			break;
+	}
+	return best;
+}
+
+static int running_object__collect_functions(struct running_object_ctx *ctx,
+					     const char *module)
+{
+	struct elf_functions *functions = &ctx->functions;
+	FILE *fp;
+	char line[512], name[256], module_name[256], type;
+	unsigned long long addr;
+
+	fp = fopen("/proc/kallsyms", "r");
+	if (!fp)
+		return -1;
+	while (fgets(line, sizeof(line), fp)) {
+		struct elf_function *function;
+		int fields;
+
+		module_name[0] = '\0';
+		fields = sscanf(line, "%llx %c %255s %255s", &addr, &type, name,
+				module_name);
+		if (fields < 3 || !addr || !strchr("TtWw", type))
+			continue;
+		if (module) {
+			size_t len = strlen(module_name);
+
+			if (fields != 4 || len < 3 || module_name[0] != '[' ||
+			    module_name[len - 1] != ']' ||
+			    strncmp(module_name + 1, module, len - 2) != 0 ||
+			    module[len - 2] != '\0')
+				continue;
+		} else if (fields == 4) {
+			continue;
+		}
+		function = realloc(functions->entries,
+				   (functions->nr_entries + 1) * sizeof(*functions->entries));
+		if (!function)
+			goto out_err;
+		functions->entries = function;
+		function = &functions->entries[functions->nr_entries];
+		function->name = strdup(name);
+		if (!function->name)
+			goto out_err;
+		function->addr = addr;
+		function->size = 0;
+		functions->nr_entries++;
+	}
+	fclose(fp);
+	functions->owns_names = true;
+	qsort(functions->entries, functions->nr_entries,
+	      sizeof(*functions->entries), elf_function__cmp);
+	for (uint32_t i = 0; i < functions->nr_entries;) {
+		uint32_t next = i + 1;
+
+		while (next < functions->nr_entries &&
+		       functions->entries[next].addr == functions->entries[i].addr)
+			next++;
+		if (next < functions->nr_entries)
+			for (uint32_t j = i; j < next; j++)
+				functions->entries[j].size =
+					functions->entries[next].addr - functions->entries[j].addr;
+		i = next;
+	}
+	return 0;
+
+out_err:
+	fclose(fp);
+	functions->owns_names = true;
+	elf_functions__exit(functions);
+	return -1;
+}
+
+static void running_object__exit(struct running_object_ctx *ctx)
+{
+	elf_functions__exit(&ctx->functions);
+	elf_register_names__exit(&ctx->regs);
+	for (uint32_t i = 0; i < ctx->nr_sections; i++)
+		free(ctx->sections[i].name);
+	free(ctx->sections);
+}
+
+static uint64_t running_object__section_addr(const struct running_object_ctx *ctx,
+					      const char *name)
+{
+	if (ctx->vmlinux)
+		return strcmp(name, ".text") == 0 ? ctx->addr_base : 0;
+	for (uint32_t i = 0; i < ctx->nr_sections; i++)
+		if (strcmp(ctx->sections[i].name, name) == 0)
+			return ctx->sections[i].addr;
+	return 0;
+}
+
+static int running_object__init_vmlinux(struct running_object_ctx *ctx)
+{
+	FILE *fp;
+	char line[512], name[256], type;
+	unsigned long long addr;
+
+	fp = fopen("/proc/kallsyms", "r");
+	if (!fp)
+		return -1;
+	while (fgets(line, sizeof(line), fp)) {
+		if (sscanf(line, "%llx %c %255s", &addr, &type, name) != 3)
+			continue;
+		if (strcmp(name, "_stext") == 0) {
+			ctx->vmlinux = true;
+			ctx->addr_base = addr;
+			fclose(fp);
+			/* kptr_restrict may be active */
+			if (addr == 0)
+				return 0;
+			return running_object__collect_functions(ctx, NULL);
+		}
+	}
+	fclose(fp);
+	return -1;
+}
+
+static int running_object__init_module(struct running_object_ctx *ctx, const char *module)
+{
+	char path[PATH_MAX];
+	struct dirent *entry;
+	DIR *dir;
+
+	if (strchr(module, '/'))
+		return -1;
+	if (snprintf(path, sizeof(path), "/sys/module/%s/sections",
+		     module) >= (int)sizeof(path))
+		return -1;
+	dir = opendir(path);
+	if (!dir)
+		return -1;
+	while ((entry = readdir(dir)) != NULL) {
+		struct running_section *section;
+		FILE *fp;
+		unsigned long long addr;
+
+		if (strcmp(entry->d_name, ".") == 0 ||
+		    strcmp(entry->d_name, "..") == 0)
+			continue;
+		if (snprintf(path, sizeof(path), "/sys/module/%s/sections/%s", module,
+				     entry->d_name) >= (int)sizeof(path))
+			continue;
+		fp = fopen(path, "r");
+		if (!fp)
+			continue;
+		if (fscanf(fp, "%llx", &addr) != 1) {
+			fclose(fp);
+			continue;
+		}
+		fclose(fp);
+		/* kptr_restrict */
+		if (addr == 0) {
+			closedir(dir);
+			return 0;
+		}
+		section = realloc(ctx->sections,
+				  (ctx->nr_sections + 1) * sizeof(*ctx->sections));
+		if (!section)
+			goto out_err;
+		ctx->sections = section;
+		section = &ctx->sections[ctx->nr_sections];
+		section->name = strdup(entry->d_name);
+		if (!section->name)
+			goto out_err;
+		section->addr = addr;
+		if (!ctx->addr_base || addr < ctx->addr_base)
+			ctx->addr_base = addr;
+		ctx->nr_sections++;
+	}
+	closedir(dir);
+	if (!ctx->nr_sections)
+		return -1;
+	return running_object__collect_functions(ctx, module);
+
+out_err:
+	closedir(dir);
+	running_object__exit(ctx);
+	return -1;
+}
+
+static int running_object__init(struct running_object_ctx *ctx, const char *object)
+{
+	int err;
+
+	memset(ctx, 0, sizeof(*ctx));
+	if (strcmp(object, "vmlinux") == 0)
+		err = running_object__init_vmlinux(ctx);
+	else
+		err = running_object__init_module(ctx, object);
+	if (!err) {
+		/* For --running, we can use pfunct ELF itself. */
+		elf_register_names__init(&ctx->regs, "/proc/self/exe");
+	}
+	return err;
+}
+
 struct fn_stats {
 	struct list_head node;
 	struct tag	 *tag;
@@ -429,33 +862,186 @@ static int cu_function_iterator(struct cu *cu, void *cookie __maybe_unused)
 	return 0;
 }
 
-static int elf_symtab__show(char *filename)
+static const char *btf_reg_name(uint32_t reg, const struct elf_register_names *regs,
+				char *buf, size_t len)
 {
-	int fd = open(filename, O_RDONLY), err = -1;
-	if (fd < 0)
-		return -1;
+	if (reg == BTF_LOC_PARAM_FBREG)
+		return "fbreg";
+	if (regs && reg < ARRAY_SIZE(regs->names) && regs->names[reg])
+		return regs->names[reg];
+	snprintf(buf, len, "reg%u", reg);
+	return buf;
+}
 
-	if (elf_version(EV_CURRENT) == EV_NONE) {
-		fprintf(stderr, "%s: cannot set libelf version.\n", __func__);
-		goto out_close;
+static bool btf_inline_site__fprintf_loc(const struct btf_type *type,
+					 const struct btf_inline_site *site,
+					 uint64_t object_addr_base,
+					 const struct elf_register_names *regs, FILE *fp)
+{
+	const uint32_t *values = (const uint32_t *)(type + 1);
+	uint32_t flags = *values++;
+	uint64_t value;
+	char regbuf[16];
+	char regbuf2[16];
+	const char *reg;
+
+	if (flags & BTF_LOC_PARAM_CONST) {
+		value = values[0];
+		if (type->size > sizeof(values[0]))
+			value |= (uint64_t)values[1] << 32;
+		if (flags & BTF_LOC_PARAM_ADDR) {
+			fputs("addr ", fp);
+			if (object_addr_base != UINT64_MAX)
+				fprintf(fp, "%#llx",
+					(unsigned long long)(object_addr_base + value));
+			else
+				fprintf(fp, "%s+%#llx", site->section_name,
+					(unsigned long long)value);
+			return true;
+		}
+		fputs("const ", fp);
+		if (flags & BTF_LOC_PARAM_SIGNED) {
+			if (type->size && type->size < sizeof(value)) {
+				unsigned int bits = type->size * 8;
+
+				if (value & (1ULL << (bits - 1)))
+					value |= ~0ULL << bits;
+			}
+			fprintf(fp, "%lld", (long long)value);
+		} else
+			fprintf(fp, "%#llx", (unsigned long long)value);
+		return true;
 	}
+	if (!(flags & BTF_LOC_PARAM_REG))
+		return false;
+	reg = btf_reg_name(values[0], regs, regbuf, sizeof(regbuf));
+	if (flags & BTF_LOC_PARAM_DEREF)
+		fprintf(fp, "*(%s", reg);
+	else
+		fputs(reg, fp);
+	if (flags & BTF_LOC_PARAM_OFFSET)
+		fprintf(fp, "%+d", (int32_t)values[1]);
+	else if (flags == BTF_LOC_PARAM_REG && btf_vlen(type) == 2)
+		fprintf(fp, ", %s", btf_reg_name(values[1], regs, regbuf2, sizeof(regbuf2)));
+	if (flags & BTF_LOC_PARAM_DEREF)
+		fputc(')', fp);
+	return true;
+}
 
-	Elf *elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
-	if (elf == NULL) {
-		fprintf(stderr, "%s: cannot read %s ELF file.\n",
-			__func__, filename);
-		goto out_close;
+static void btf_inline_site__fprintf(const struct btf_inline_site *site,
+				     const struct cu *cu,
+				     const struct elf_symtab_ctx *elf_symtab,
+				     const struct elf_register_names *regs,
+				     const struct elf_functions *elf_functions,
+				     const struct running_object_ctx *running, FILE *fp)
+{
+	const struct btf_type *proto;
+	const uint32_t *param_ids;
+	struct ftype *ftype;
+	struct parameter *param;
+	uint16_t i = 0;
+	uint64_t section_addr = 0;
+	uint64_t object_addr_base = UINT64_MAX;
+	const struct elf_function *containing_function = NULL;
+
+	if (!site->function)
+		return;
+	proto = btf__type_by_id(cu->priv, site->loc_proto);
+	ftype = tag__ftype(cu__type(cu, site->function->proto.tag.type));
+	if (!proto || btf_kind(proto) != BTF_KIND_LOC_PROTO || !ftype)
+		return;
+	param_ids = (const uint32_t *)(proto + 1);
+	if (running) {
+		section_addr = running_object__section_addr(running, site->section_name);
+		if (section_addr)
+			object_addr_base = running->addr_base;
 	}
+	if (elf_symtab) {
+		GElf_Shdr shdr;
+		size_t index;
 
-	GElf_Ehdr ehdr;
-	if (gelf_getehdr(elf, &ehdr) == NULL) {
-		fprintf(stderr, "%s: cannot get elf header.\n", __func__);
-		goto out_elf_end;
+		if (elf_section_by_name(elf_symtab->elf, &shdr, site->section_name, &index))
+			section_addr = shdr.sh_addr;
+		object_addr_base = elf__addr_base(elf_symtab->elf);
+	}
+	if (elf_functions && section_addr)
+		containing_function = elf_functions__find(elf_functions,
+							  section_addr + site->section_offset);
+	/* Raw or detached BTF has no ELF section VMA; its LOCSEC offset is
+	 * still useful and is the best address available in that case.
+	 */
+	fprintf(fp, "%#llx [",
+		(unsigned long long)(section_addr ?
+			 section_addr + site->section_offset : site->section_offset));
+	if (containing_function)
+		fprintf(fp, "%s+0x%llx, ", containing_function->name,
+			(unsigned long long)(section_addr + site->section_offset -
+					     containing_function->addr));
+	fprintf(fp, "%s +%#x] %s(", site->section_name, site->section_offset,
+		function__name(site->function));
+	ftype__for_each_parameter(ftype, param) {
+		struct tag *type = cu__type(cu, param->tag.type);
+		const struct btf_type *location = NULL;
+		char typebuf[128];
+
+		if (i)
+			fputs(", ", fp);
+		fputs(tag__name(type, cu, typebuf, sizeof(typebuf), &conf), fp);
+		if (!conf.no_parm_names && parameter__name(param))
+			fprintf(fp, " %s", parameter__name(param));
+		if (i < btf_vlen(proto))
+			location = btf__type_by_id(cu->priv, param_ids[i]);
+		fputs(" [", fp);
+		if (!location || btf_kind(location) != BTF_KIND_LOC_PARAM ||
+		    !btf_inline_site__fprintf_loc(location, site, object_addr_base,
+						 regs, fp))
+			fputs("unavailable", fp);
+		fputc(']', fp);
+		++i;
 	}
+	if (ftype->unspec_parms) {
+		if (i)
+			fputs(", ", fp);
+		fputs("...", fp);
+	} else if (i == 0) {
+		fputs("void", fp);
+	}
+	fputs(")\n", fp);
+}
+
+struct btf_inline_sites {
+	const struct elf_symtab_ctx *elf_symtab;
+	const struct elf_register_names *regs;
+	const struct elf_functions  *elf_functions;
+	const struct running_object_ctx *running;
+};
+
+static int cu_btf_inline_sites_iterator(struct cu *cu, void *cookie)
+{
+	struct btf_inline_site *site;
+	const struct btf_inline_sites *inline_sites = cookie;
+
+	list_for_each_entry(site, &cu->btf_inline_sites, node)
+		if (!function_name ||
+		    strcmp(function__name(site->function), function_name) == 0)
+			btf_inline_site__fprintf(site, cu, inline_sites->elf_symtab,
+						 inline_sites->regs,
+						 inline_sites->elf_functions, inline_sites->running,
+						 stdout);
+	return 0;
+}
+
+static int elf_symtab__show(char *filename)
+{
+	struct elf_symtab_ctx ctx;
+	struct elf_symtab *symtab;
+	int err = -1;
 
-	struct elf_symtab *symtab = elf_symtab__new(symtab_name, elf);
-	if (symtab == NULL)
-		goto out_elf_end;
+	if (elf_symtab__init(&ctx, filename) || !ctx.symtab) {
+		elf_symtab__exit(&ctx);
+		return -1;
+	}
+	symtab = ctx.symtab;
 
 	GElf_Sym sym;
 	uint32_t index;
@@ -488,12 +1074,8 @@ static int elf_symtab__show(char *filename)
 		       elf_sym__size(&sym));
 	}
 
-	elf_symtab__delete(symtab);
 	err = 0;
-out_elf_end:
-	elf_end(elf);
-out_close:
-	close(fd);
+	elf_symtab__exit(&ctx);
 	return err;
 }
 
@@ -548,6 +1130,8 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_compile		302
 #define ARGP_devel_version	303
 #define ARGP_btf_base		304
+#define ARGP_elf		305
+#define ARGP_running		306
 
 static const struct argp_option pfunct__options[] = {
 	{
@@ -595,6 +1179,19 @@ static const struct argp_option pfunct__options[] = {
 		.arg  = "PATH",
 		.doc  = "Path to the base BTF file for split BTF input",
 	},
+	{
+		.name = "elf",
+		.key  = ARGP_elf,
+		.arg  = "PATH",
+		.doc  = "ELF file used to resolve BTF inline-site addresses and containers",
+	},
+	{
+		.name  = "running",
+		.key   = ARGP_running,
+		.arg   = "OBJECT",
+		.flags = OPTION_ARG_OPTIONAL,
+		.doc   = "Resolve inline sites against running vmlinux or module OBJECT (Default vmlinux)",
+	},
 	{
 		.key  = 'g',
 		.name = "goto_labels",
@@ -615,6 +1212,11 @@ static const struct argp_option pfunct__options[] = {
 		.name = "inline_expansions",
 		.doc  = "show inline expansions",
 	},
+	{
+		.key  = 'j',
+		.name = "inline_sites",
+		.doc  = "show BTF inline sites and parameter locations",
+	},
 	{
 		.key  = 'I',
 		.name = "inline_expansions_stats",
@@ -725,6 +1327,10 @@ static error_t pfunct__options_parser(int key, char *arg,
 	case 'i': show_inline_expansions = verbose = 1;
 		  conf_load.extra_dbg_info = true;
 		  conf_load.get_addr_info = true;	 break;
+	case 'j': show_inline_sites = true;
+		  if (conf_load.format_path == NULL)
+			  conf_load.format_path = "btf";
+		  break;
 	case 'I': formatter = fn_stats_inline_exps_fmtr;
 		  conf_load.get_addr_info = true;	 break;
 	case 'l': conf.show_decl_info = 1;
@@ -738,6 +1344,8 @@ static error_t pfunct__options_parser(int key, char *arg,
 		  conf_load.get_addr_info = true;	 break;
 	case ARGP_symtab: symtab_name = arg ?: ".symtab";  break;
 	case ARGP_btf_base: base_btf_file = arg;             break;
+	case ARGP_elf: elf_filename = arg;                   break;
+	case ARGP_running: running_object = arg ?: "vmlinux"; break;
 	case ARGP_no_parm_names: conf.no_parm_names = 1; break;
 	case ARGP_compile:
 		  expand_types = true;
@@ -768,6 +1376,12 @@ static struct argp pfunct__argp = {
 int main(int argc, char *argv[])
 {
 	int err, remaining, rc = EXIT_FAILURE;
+	struct elf_symtab_ctx elf_symtab;
+	struct elf_functions elf_functions = {};
+	struct btf_inline_sites inline_sites = {};
+	struct running_object_ctx running = {};
+	bool have_inline_elf = false;
+	bool have_running = false;
 
 	if (argp_parse(&pfunct__argp, argc, argv, 0, &remaining, NULL) ||
 	    (remaining == argc && class_name == NULL && function_name == NULL)) {
@@ -788,6 +1402,11 @@ int main(int argc, char *argv[])
 		fputs("pfunct: insufficient memory\n", stderr);
 		goto out;
 	}
+	if (running_object && (elf_filename || !show_inline_sites)) {
+		fputs("pfunct: --running is only supported with --inline_sites and without --elf\n",
+		      stderr);
+		goto out_dwarves_exit;
+	}
 
 	dwarves__resolve_cacheline_size(&conf_load, 0);
 
@@ -795,9 +1414,8 @@ int main(int argc, char *argv[])
 	if (base_btf_file == NULL) {
 		const char *filename = argv[remaining];
 
-		if (filename &&
-		    strstarts(filename, "/sys/kernel/btf/") &&
-		    strstr(filename, "/vmlinux") == NULL)
+		if (filename && strstarts(filename, "/sys/kernel/btf/") &&
+		    strcmp(filename, vmlinux_path__btf_filename()) != 0)
 			base_btf_file = vmlinux_path__btf_filename();
 	}
 
@@ -820,7 +1438,8 @@ int main(int argc, char *argv[])
 		goto out_dwarves_exit;
 	}
 
-	if (function_name || (!function_name && show_all_matches) || class_name)
+	if ((function_name && !show_inline_sites) ||
+	    (!function_name && show_all_matches) || class_name)
 		conf_load.steal = pfunct_stealer;
 
 try_sole_arg_as_function_name:
@@ -844,6 +1463,38 @@ try_sole_arg_as_function_name:
 
 	bool is_btf = conf_load.format_path && strcasecmp(conf_load.format_path, "btf") == 0;
 	cus__for_each_cu(cus, cu_unique_iterator, is_btf ? (void *)1 : NULL, NULL);
+	if (running_object) {
+		if (running_object__init(&running, running_object)) {
+			fprintf(stderr, "pfunct: cannot resolve running object '%s'\n",
+				running_object);
+			goto out_elf_symtab_exit;
+		}
+		have_running = true;
+		inline_sites.running = &running;
+		inline_sites.regs = &running.regs;
+		inline_sites.elf_functions = &running.functions;
+	} else if (show_inline_sites && (elf_filename || argv[remaining])) {
+		const char *inline_elf_filename = elf_filename ?: argv[remaining];
+
+		if (elf_symtab__init(&elf_symtab, inline_elf_filename)) {
+			if (!elf_filename)
+				goto no_inline_elf;
+			elf_functions__exit(&elf_functions);
+			elf_symtab__exit(&elf_symtab);
+			goto out_cus_delete;
+		}
+		have_inline_elf = true;
+		if (elf_symtab.symtab &&
+		    elf_functions__collect(&elf_functions, elf_symtab.symtab)) {
+			elf_functions__exit(&elf_functions);
+			elf_symtab__exit(&elf_symtab);
+			goto out_cus_delete;
+		}
+		inline_sites.elf_symtab = &elf_symtab;
+		inline_sites.regs = &elf_symtab.regs;
+		inline_sites.elf_functions = &elf_functions;
+	}
+no_inline_elf:
 
 	if (addr) {
 		struct cu *cu;
@@ -852,17 +1503,26 @@ try_sole_arg_as_function_name:
 		if (f == NULL) {
 			fprintf(stderr, "pfunct: No function found at %#llx!\n",
 				(unsigned long long)addr);
-			goto out_cus_delete;
+			goto out_elf_symtab_exit;
 		}
 		function__show(f, cu);
 	} else if (show_total_inline_expansion_stats)
 		print_total_inline_stats();
+	else if (show_inline_sites)
+		cus__for_each_cu(cus, cu_btf_inline_sites_iterator, &inline_sites, NULL);
 	else if (expand_types)
 		cus__for_each_cu(cus, cu_function_iterator, NULL, NULL);
 	else if (function_name == NULL)
 		print_fn_stats(formatter);
 
 	rc = EXIT_SUCCESS;
+out_elf_symtab_exit:
+	if (have_running)
+		running_object__exit(&running);
+	if (have_inline_elf) {
+		elf_functions__exit(&elf_functions);
+		elf_symtab__exit(&elf_symtab);
+	}
 out_cus_delete:
 	cus__delete(cus);
 	fn_stats__delete_list();
-- 
2.43.5

