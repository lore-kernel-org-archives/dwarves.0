From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] btf_encoder: Teach pahole to store percpu variables
 in vmlinux BTF.
Date: Wed, 3 Jun 2020 20:23:11 -0300
Message-ID: <20200603232311.GC18375@kernel.org>
References: <20200603172244.100562-1-haoluo@google.com>
 <20200603185831.GA18375@kernel.org>
 <CA+khW7jkjaf0xjU5CYt3AXSNKkwKVNz5=cz=3kpWLuFMBS+ZaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+khW7jkjaf0xjU5CYt3AXSNKkwKVNz5=cz=3kpWLuFMBS+ZaA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexei Starovoitov <alexei.starovoitov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Oleg Rombakh <olegrom-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Martin KaFai Lau <kafai-b10kYP2dOMg@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, Jun 03, 2020 at 01:02:26PM -0700, Hao Luo escreveu:
> On Wed, Jun 3, 2020 at 11:58 AM Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> wrote:
> 
> > Em Wed, Jun 03, 2020 at 10:22:44AM -0700, Hao Luo escreveu:
> > > On SMP systems, the global percpu variables are placed in a speical
> > > '.data..percpu' section, which is stored in a segment whose initial
> > > address is set to 0, the addresses of per-CPU variables are relative
> > > positive addresses [1].
> > >
> > > This patch extracts these variables from vmlinux and places them with
> > > their type information in BTF. More specifically, when we encode BTF,
> > > we find the shndx of the '.data..percpu' section and then traverse
> > > the symbol table to find those global objects which are in this section.
> > > For each of these objects, we push a BTF_KIND_VAR into the types buffer,
> > > and a BTF_VAR_SECINFO into another buffer, percpu_secinfo. When all the
> > > CUs have finished processing, we push a BTF_KIND_DATASEC into the
> > > types buffer, followed by the percpu_secinfo's content, that is, an
> > > array of BTF_VAR_SECINFOs.
> > >
> > > In a v5.7-rc7 linux kernel, I was able to extract 294 such variables.
> > > The space overhead is small.
> > >
> > > Testing:
> > >
> > > Before:
> > >  $ readelf -SW vmlinux | grep BTF
> > >  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2d2bf8
> > 00   A  0   0  1
> > >
> > > After:
> > >  $ pahole -J vmlinux
> > >  $ readelf -SW vmlinux  | grep BTF
> > >  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2d5bca
> > 00   A  0   0  1
> > >
> > > Common percpu vars can be found in the BTF section.
> > >
> > >  $ bpftool btf dump file vmlinux | grep runqueues
> > >  [14098] VAR 'runqueues' type_id=13725, linkage=global-alloc
> > >
> > >  $ bpftool btf dump file vmlinux | grep 'cpu_stopper'
> > >  [17592] STRUCT 'cpu_stopper' size=72 vlen=5
> > >  [17612] VAR 'cpu_stopper' type_id=17592, linkage=static
> > >
> > >  $ bpftool btf dump file vmlinux | grep ' DATASEC '
> > >  [63652] DATASEC '.data..percpu' size=0 vlen=294
> > >
> > > References:
> > >  [1] https://lwn.net/Articles/531148/
> > > Signed-off-by: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  btf_encoder.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  dwarves.c     |   6 +++
> > >  dwarves.h     |   2 +
> > >  libbtf.c      |  86 ++++++++++++++++++++++++++++++++++
> > >  libbtf.h      |   7 +++
> > >  pahole.c      |   1 +
> > >  6 files changed, 227 insertions(+)
> > >
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index df16ba0..92d73be 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -168,6 +168,27 @@ int btf_encoder__encode()
> > >       return err;
> > >  }
> > >
> > > +
> > > +#define HASHADDR__BITS 8
> > > +#define HASHADDR__SIZE (1UL << HASHADDR__BITS)
> > > +#define hashaddr__fn(key) hash_64(key, HASHADDR__BITS)
> >
> > Yeah, that is in the ctf_encoder.c, I have to move them to a central
> > location, so its fair you, for the sake of doing it as fast as possible,
> > do it locally.
> >
> 
> Arnaldo, could you advise on where is the best place to put these macros? I
> can do it as a preparatory patch in the next iteration. Thanks!

That was my initial thoughts, after looking at this a bit I'm not
convinced this should be made common amongst the encoders, so I'd say
nevermind, lets continue with how you patch uses it, sorry for the
disturbance.

Just address the debug messages suggestions you acked, and lets wait for
Andrii's comments.

- Arnaldo

> > > +static struct variable *hashaddr__find_variable(const struct hlist_head
> > hashtable[],
> > > +                                             const uint64_t addr)
> > > +{
> > > +     struct variable *variable;
> > > +     struct hlist_node *pos;
> > > +     uint16_t bucket = hashaddr__fn(addr);
> > > +     const struct hlist_head *head = &hashtable[bucket];
> > > +
> > > +     hlist_for_each_entry(variable, pos, head, tool_hnode) {
> > > +             if (variable->ip.addr == addr)
> > > +                     return variable;
> > > +     }
> > > +
> > > +     return NULL;
> > > +}
> > > +
> > >  int cu__encode_btf(struct cu *cu, int verbose)
> > >  {
> > >       bool add_index_type = false;
> > > @@ -176,6 +197,13 @@ int cu__encode_btf(struct cu *cu, int verbose)
> > >       struct function *fn;
> > >       struct tag *pos;
> > >       int err = 0;
> > > +     GElf_Shdr shdr;
> > > +     uint32_t percpu_ndx;
> > > +     struct hlist_head hash_addr[HASHADDR__SIZE];
> > > +     struct variable *var;
> > > +     bool has_global_var = false;
> > > +     struct elf_symtab *symtab;
> > > +     GElf_Sym sym;
> > >
> > >       if (btfe && strcmp(btfe->filename, cu->filename)) {
> > >               err = btf_encoder__encode();
> > > @@ -241,6 +269,103 @@ int cu__encode_btf(struct cu *cu, int verbose)
> > >               }
> > >       }
> > >
> > > +     /* find ".data..percpu" section's ndx */
> > > +     Elf_Scn *percpu_sec = elf_section_by_name(btfe->elf, &btfe->ehdr,
> > &shdr,
> > > +                                               ".data..percpu", NULL);
> > > +     if (percpu_sec == NULL)
> > > +             goto out;
> > > +
> > > +     percpu_ndx = elf_ndxscn(percpu_sec);
> > > +     if (percpu_ndx == 0)
> > > +             goto out;
> > > +
> > > +     /* cache variables' addresses, preparing for searching in symtab.
> > */
> > > +     for (core_id = 0; core_id < HASHADDR__SIZE; ++core_id)
> > > +             INIT_HLIST_HEAD(&hash_addr[core_id]);
> > > +
> > > +     cu__for_each_variable(cu, core_id, pos) {
> > > +             var = tag__variable(pos);
> > > +             if (var->declaration)
> > > +                     continue;
> > > +             /* percpu variables are allocated in global space */
> > > +             if (variable__scope(var) != VSCOPE_GLOBAL)
> > > +                     continue;
> > > +             has_global_var = true;
> > > +             struct hlist_head *head =
> > &hash_addr[hashaddr__fn(var->ip.addr)];
> > > +             hlist_add_head(&var->tool_hnode, head);
> > > +     }
> > > +     if (!has_global_var)
> > > +             goto out;
> > > +
> > > +     /* search within symtab for percpu variables */
> > > +     symtab = elf_symtab__new(NULL, btfe->elf, &btfe->ehdr);
> > > +     if (!symtab)
> >
> > Some error message is in need here?
> >
> 
> Ack. Will do.
> 
> 
> >
> > > +             goto out;
> > > +
> > > +     elf_symtab__for_each_symbol(symtab, core_id, sym) {
> > > +             uint32_t linkage, type, size, offset;
> > > +             int32_t btf_var_id, btf_var_secinfo_id;
> > > +             uint64_t addr;
> > > +
> > > +             /* compare a symbol's shndx to determine if it's a percpu
> > variable */
> > > +             if (elf_sym__section(&sym) != percpu_ndx)
> > > +                     continue;
> > > +
> > > +             addr = elf_sym__value(&sym);
> > > +             /*
> > > +              * Store only those symbols that have allocated space in
> > the percpu section.
> > > +              * This excludes the following three types of symbols:
> > > +              *
> > > +              *  1. __ADDRESSABLE(sym), which are forcely emitted as
> > symbols.
> > > +              *  2. __UNIQUE_ID(prefix), which are introduced to
> > generate unique ids.
> > > +              *  3. __exitcall(fn), functions which are labeled as exit
> > calls.
> > > +              *
> > > +              * In addition, the variables defined using
> > DEFINE_PERCPU_FIRST are
> > > +              * also not included, which currently includes:
> > > +              *
> > > +              *  1. fixed_percpu_data
> > > +              */
> > > +             if (!addr)
> > > +                     continue;
> >
> > Perhaps some more verbose debug message here so that we can debug what
> > is not being added and why?
> >
> 
> Ack.
> 
> 
> >
> > > +             var = hashaddr__find_variable(hash_addr, addr);
> > > +             if (var == NULL)
> >
> > Debug message
> >
> 
> Ack.
> 
> 
> >
> > > +                     continue;
> > > +
> > > +             /* add a BTF_KIND_VAR in btfe->types */
> > > +             linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED :
> > BTF_VAR_STATIC;
> > > +             type = var->ip.tag.type + type_id_off;
> > > +             btf_var_id = btf_elf__add_var_type(btfe, type, var->name,
> > linkage);
> > > +             if (btf_var_id < 0) {
> > > +                     err = -1;
> > > +                     printf("error: failed to encode variable '%s'\n",
> > > +                            variable__name(var, cu));
> > > +                     break;
> > > +             }
> > > +
> > > +             /*
> > > +              * add a BTF_VAR_SECINFO in btfe->percpu_secinfo, which
> > will be added into
> > > +              * btfe->types later when we add BTF_VAR_DATASEC.
> > > +              */
> > > +             size = variable__type_size(var, cu);
> > > +             type = btf_var_id;
> > > +             /*
> > > +              * Percpu variables are stored in a segment whose initial
> > address is set to
> > > +              * 0, so their addresses are also offsets.
> > > +              *
> > > +              * See https://lwn.net/Articles/531148/
> > > +              */
> > > +             offset = addr;
> > > +             btf_var_secinfo_id =
> > btf_elf__add_var_secinfo(&btfe->percpu_secinfo,
> > > +                                                           type,
> > offset, size);
> > > +             if (btf_var_secinfo_id < 0) {
> > > +                     err = -1;
> > > +                     printf("error: failed to encode var secinfo
> > '%s'\n",
> > > +                            variable__name(var, cu));
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     elf_symtab__delete(symtab);
> > >  out:
> > >       if (err)
> > >               btf_elf__delete(btfe);
> > > diff --git a/dwarves.c b/dwarves.c
> > > index eb7885f..141f688 100644
> > > --- a/dwarves.c
> > > +++ b/dwarves.c
> > > @@ -978,6 +978,12 @@ const char *variable__type_name(const struct
> > variable *var,
> > >       return tag != NULL ? tag__name(tag, cu, bf, len, NULL) : NULL;
> > >  }
> > >
> > > +uint32_t variable__type_size(const struct variable *var, const struct
> > cu *cu)
> > > +{
> > > +     const struct tag *tag = cu__type(cu, var->ip.tag.type);
> > > +     return tag != NULL ? tag__size(tag, cu) : 0;
> > > +}
> > > +
> > >  void class_member__delete(struct class_member *member, struct cu *cu)
> > >  {
> > >       obstack_free(&cu->obstack, member);
> > > diff --git a/dwarves.h b/dwarves.h
> > > index a772e57..e4b0255 100644
> > > --- a/dwarves.h
> > > +++ b/dwarves.h
> > > @@ -672,6 +672,8 @@ const char *variable__name(const struct variable
> > *var, const struct cu *cu);
> > >  const char *variable__type_name(const struct variable *var,
> > >                               const struct cu *cu, char *bf, size_t len);
> > >
> > > +uint32_t variable__type_size(const struct variable *var, const struct
> > cu *cu);
> > > +
> > >  struct lexblock {
> > >       struct ip_tag    ip;
> > >       struct list_head tags;
> > > diff --git a/libbtf.c b/libbtf.c
> > > index 2fbce40..63c8e08 100644
> > > --- a/libbtf.c
> > > +++ b/libbtf.c
> > > @@ -46,6 +46,11 @@ struct btf_array_type {
> > >       struct btf_array array;
> > >  };
> > >
> > > +struct btf_var_type {
> > > +     struct btf_type type;
> > > +     struct btf_var var;
> > > +};
> > > +
> > >  uint8_t btf_elf__verbose;
> > >
> > >  uint32_t btf_elf__get32(struct btf_elf *btfe, uint32_t *p)
> > > @@ -613,6 +618,84 @@ int32_t btf_elf__add_func_proto(struct btf_elf
> > *btfe, struct ftype *ftype, uint3
> > >       return type_id;
> > >  }
> > >
> > > +int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type,
> > uint32_t name_off,
> > > +                              uint32_t linkage)
> > > +{
> > > +     struct btf_var_type t;
> > > +
> > > +     t.type.name_off = name_off;
> > > +     t.type.info = BTF_INFO_ENCODE(BTF_KIND_VAR, 0, 0);
> > > +     t.type.type = type;
> > > +
> > > +     t.var.linkage = linkage;
> > > +
> > > +     ++btfe->type_index;
> > > +     if (gobuffer__add(&btfe->types, &t.type, sizeof(t)) < 0) {
> > > +             btf_elf__log_type(btfe, &t.type, true, true,
> > > +                               "type=%u name=%s Error in adding
> > gobuffer",
> > > +                               t.type.type,
> > btf_elf__name_in_gobuf(btfe, t.type.name_off));
> > > +             return -1;
> > > +     }
> > > +
> > > +     btf_elf__log_type(btfe, &t.type, false, false, "type=%u name=%s",
> > > +                       t.type.type, btf_elf__name_in_gobuf(btfe,
> > t.type.name_off));
> > > +
> > > +     return btfe->type_index;
> > > +}
> > > +
> > > +int32_t btf_elf__add_var_secinfo(struct gobuffer *buf, uint32_t type,
> > > +                                 uint32_t offset, uint32_t size)
> > > +{
> > > +     struct btf_var_secinfo si = {
> > > +             .type = type,
> > > +             .offset = offset,
> > > +             .size = size,
> > > +     };
> > > +     return gobuffer__add(buf, &si, sizeof(si));
> > > +}
> > > +
> > > +extern struct strings *strings;
> > > +
> > > +int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char
> > *section_name,
> > > +                                  struct gobuffer *var_secinfo_buf)
> > > +{
> > > +     struct btf_type type;
> > > +     size_t sz = gobuffer__size(var_secinfo_buf);
> > > +     uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> > > +     uint32_t name_off;
> > > +
> > > +     /*
> > > +      * dwarves doesn't store section names in its string table,
> > > +      * so we have to add it by ourselves.
> > > +      */
> > > +     name_off = strings__add(strings, section_name);
> > > +
> > > +     type.name_off = name_off;
> > > +     type.info = BTF_INFO_ENCODE(BTF_KIND_DATASEC, 0, nr_var_secinfo);
> > > +     type.size = 0;
> > > +
> > > +     ++btfe->type_index;
> > > +     if (gobuffer__add(&btfe->types, &type, sizeof(type)) < 0) {
> > > +             btf_elf__log_type(btfe, &type, true, true,
> > > +                               "name=%s vlen=%u Error in adding
> > datasec",
> > > +                               btf_elf__name_in_gobuf(btfe,
> > type.name_off),
> > > +                               nr_var_secinfo);
> > > +             return -1;
> > > +     }
> > > +     if (gobuffer__add(&btfe->types, var_secinfo_buf->entries, sz) < 0)
> > {
> > > +             btf_elf__log_type(btfe, &type, true, true,
> > > +                               "name=%s vlen=%u Error in adding
> > var_secinfo",
> > > +                               btf_elf__name_in_gobuf(btfe,
> > type.name_off),
> > > +                               nr_var_secinfo);
> > > +             return -1;
> > > +     }
> > > +
> > > +     btf_elf__log_type(btfe, &type, false, false, "type=datasec
> > name=%s",
> > > +                       btf_elf__name_in_gobuf(btfe, type.name_off));
> > > +
> > > +     return btfe->type_index;
> > > +}
> > > +
> > >  static int btf_elf__write(const char *filename, struct btf *btf)
> > >  {
> > >       GElf_Shdr shdr_mem, *shdr;
> > > @@ -727,6 +810,9 @@ int btf_elf__encode(struct btf_elf *btfe, uint8_t
> > flags)
> > >       if (gobuffer__size(&btfe->types) == 0)
> > >               return 0;
> > >
> > > +     if (gobuffer__size(&btfe->percpu_secinfo) != 0)
> > > +             btf_elf__add_datasec_type(btfe, ".data..percpu",
> > &btfe->percpu_secinfo);
> > > +
> > >       btfe->size = sizeof(*hdr) + (gobuffer__size(&btfe->types) +
> > gobuffer__size(btfe->strings));
> > >       btfe->data = zalloc(btfe->size);
> > >
> > > diff --git a/libbtf.h b/libbtf.h
> > > index f3c8500..ad0b330 100644
> > > --- a/libbtf.h
> > > +++ b/libbtf.h
> > > @@ -22,6 +22,7 @@ struct btf_elf {
> > >       GElf_Ehdr         ehdr;
> > >       struct gobuffer   types;
> > >       struct gobuffer   *strings;
> > > +     struct gobuffer   percpu_secinfo;
> > >       char              *filename;
> > >       size_t            size;
> > >       int               swapped;
> > > @@ -55,6 +56,12 @@ int32_t btf_elf__add_enum(struct btf_elf *btf,
> > uint32_t name, uint32_t size,
> > >  int btf_elf__add_enum_val(struct btf_elf *btf, uint32_t name, int32_t
> > value);
> > >  int32_t btf_elf__add_func_proto(struct btf_elf *btf, struct ftype
> > *ftype,
> > >                               uint32_t type_id_off);
> > > +int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type,
> > uint32_t name_off,
> > > +                           uint32_t linkage);
> > > +int32_t btf_elf__add_var_secinfo(struct gobuffer *buf, uint32_t type,
> > > +                              uint32_t offset, uint32_t size);
> > > +int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *
> > section_name,
> > > +                               struct gobuffer *var_secinfo_buf);
> > >  void btf_elf__set_strings(struct btf_elf *btf, struct gobuffer
> > *strings);
> > >  int  btf_elf__encode(struct btf_elf *btf, uint8_t flags);
> > >
> > > diff --git a/pahole.c b/pahole.c
> > > index e2a081b..8407db9 100644
> > > --- a/pahole.c
> > > +++ b/pahole.c
> > > @@ -1084,6 +1084,7 @@ static error_t pahole__options_parser(int key,
> > char *arg,
> > >       case 'i': find_containers = 1;
> > >                 class_name = arg;                     break;
> > >       case 'J': btf_encode = 1;
> > > +               conf_load.get_addr_info = true;
> > >                 no_bitfield_type_recode = true;       break;
> > >       case 'l': conf.show_first_biggest_size_base_type_member = 1;
> > break;
> > >       case 'M': conf.show_only_data_members = 1;      break;
> > > --
> > > 2.27.0.rc2.251.g90737beb825-goog
> > >
> >
> > --
> >
> > - Arnaldo
> >

-- 

- Arnaldo
