From: Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] btf_encoder: Teach pahole to store percpu variables in
 vmlinux BTF.
Date: Fri, 5 Jun 2020 13:49:40 -0700
Message-ID: <CAEf4BzbjE4jo-fRYTf6ith-5Rz+OSXCDKtu+XO8U3YVZZ=ZNcA@mail.gmail.com>
References: <20200603172244.100562-1-haoluo@google.com> <CAEf4BzYFTn-WYPs-W7UYeyph4n8y20rtXx11GDO4J7V5h2ChSA@mail.gmail.com>
 <CA+khW7iBTxjAMbbTNk6XyTJzuBK5C-VQ6Z6cz_2nHSn5+D2-MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+khW7iBTxjAMbbTNk6XyTJzuBK5C-VQ6Z6cz_2nHSn5+D2-MQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexei Starovoitov <alexei.starovoitov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Oleg Rombakh <olegrom-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Martin Lau <kafai-b10kYP2dOMg@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Fri, Jun 5, 2020 at 11:01 AM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>
>
>
> On Wed, Jun 3, 2020 at 9:04 PM Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
>>
>> On Wed, Jun 3, 2020 at 10:23 AM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>> >
>> > On SMP systems, the global percpu variables are placed in a speical
>> > '.data..percpu' section, which is stored in a segment whose initial
>> > address is set to 0, the addresses of per-CPU variables are relative
>> > positive addresses [1].
>> >
>> > This patch extracts these variables from vmlinux and places them with
>> > their type information in BTF. More specifically, when we encode BTF,
>> > we find the shndx of the '.data..percpu' section and then traverse
>> > the symbol table to find those global objects which are in this sectio=
n.
>> > For each of these objects, we push a BTF_KIND_VAR into the types buffe=
r,
>> > and a BTF_VAR_SECINFO into another buffer, percpu_secinfo. When all th=
e
>> > CUs have finished processing, we push a BTF_KIND_DATASEC into the
>> > types buffer, followed by the percpu_secinfo's content, that is, an
>> > array of BTF_VAR_SECINFOs.
>> >
>> > In a v5.7-rc7 linux kernel, I was able to extract 294 such variables.
>> > The space overhead is small.
>> >
>> > Testing:
>> >
>> > Before:
>> >  $ readelf -SW vmlinux | grep BTF
>> >  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2d2bf=
8 00   A  0   0  1
>> >
>> > After:
>> >  $ pahole -J vmlinux
>> >  $ readelf -SW vmlinux  | grep BTF
>> >  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2d5bc=
a 00   A  0   0  1
>> >
>> > Common percpu vars can be found in the BTF section.
>> >
>> >  $ bpftool btf dump file vmlinux | grep runqueues
>> >  [14098] VAR 'runqueues' type_id=3D13725, linkage=3Dglobal-alloc
>> >
>> >  $ bpftool btf dump file vmlinux | grep 'cpu_stopper'
>> >  [17592] STRUCT 'cpu_stopper' size=3D72 vlen=3D5
>> >  [17612] VAR 'cpu_stopper' type_id=3D17592, linkage=3Dstatic
>> >
>> >  $ bpftool btf dump file vmlinux | grep ' DATASEC '
>> >  [63652] DATASEC '.data..percpu' size=3D0 vlen=3D294
>> >
>> > References:
>> >  [1] https://lwn.net/Articles/531148/
>> > Signed-off-by: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> > ---
>>
>> It all looks good to me, very minor things below only.
>>
>> Few questions for you:
>> 1. Have you tried building kernel with these global variables and
>> checking that kernel can self-validate it correctly?
>
>
> Do you mean running selftests? I haven't run selftests but do have built =
and booted, it looked good.

Well yeah, anything that relies on kernel to recognize its own BTF
properly (so tp_btf or fentry/fexit programs, for instance).

>
>>
>> 2. It's not explicitly stated, but right now within struct and
>> datasec, all offsets are in a sorted order by offset, can you please
>> check that this is preserved for per-cpu variables withing
>> .data..percpu data section?
>
>
> No problem, I can add a qsort before copying all var_secinfos. Right now =
it seems it doesn't follow any particular order.

Sounds good, thanks.

>
>>
>> 3. As an experiment, can you please try to estimate how much data
>> would be to encode all of the variables, not just per-cpu ones? E.g.,
>> you can do it very hacky by appending them to single percpu datasec,
>> but for all variables across all data sections. That would give us a
>> good idea if it's feasible to have all kernel global variables
>> available eventually.
>
>
> I tried encoding all the global object-type symbols (including static var=
s and globally allocated vars). There are a total of 27516 such symbols. Th=
e .BTF size is 0x41499e, in comparison, it was 0x2d2c10. The space increase=
 is around 1.3Mb. The build time is roughly the same. So I think this is to=
tally affordable.

I see, that's quite a bump, but not unreasonable. Let's add it later
as needed, though.

>
> I think 4 sections are of interest: .data..percpu, .data, .rodata and .bs=
s. I can encode the rest of the sections the same way as .data..percpu. But=
, compared to .data..percpu, the other three contain a lot more unconventio=
nal symbols mixed with some useful variables.
>
> Maybe, add them in future patches upon request, if this change looks good=
? Any comments?
>
>>
>>
>> Thanks!
>>
>> >  btf_encoder.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++=
+
>> >  dwarves.c     |   6 +++
>> >  dwarves.h     |   2 +
>> >  libbtf.c      |  86 ++++++++++++++++++++++++++++++++++
>> >  libbtf.h      |   7 +++
>> >  pahole.c      |   1 +
>> >  6 files changed, 227 insertions(+)
>> >
>>
>> [...]
>>
>> > +       cu__for_each_variable(cu, core_id, pos) {
>> > +               var =3D tag__variable(pos);
>> > +               if (var->declaration)
>> > +                       continue;
>> > +               /* percpu variables are allocated in global space */
>> > +               if (variable__scope(var) !=3D VSCOPE_GLOBAL)
>> > +                       continue;
>> > +               has_global_var =3D true;
>> > +               struct hlist_head *head =3D &hash_addr[hashaddr__fn(va=
r->ip.addr)];
>>
>> variable declarations in C89 should be at the top of the block,
>> separate from statements.
>
>
> Ack. Will fix.
>
>>
>>
>> > +               hlist_add_head(&var->tool_hnode, head);
>> > +       }
>> > +       if (!has_global_var)
>> > +               goto out;
>> > +
>> > +       /* search within symtab for percpu variables */
>> > +       symtab =3D elf_symtab__new(NULL, btfe->elf, &btfe->ehdr);
>> > +       if (!symtab)
>> > +               goto out;
>> > +
>> > +       elf_symtab__for_each_symbol(symtab, core_id, sym) {
>> > +               uint32_t linkage, type, size, offset;
>> > +               int32_t btf_var_id, btf_var_secinfo_id;
>> > +               uint64_t addr;
>> > +
>> > +               /* compare a symbol's shndx to determine if it's a per=
cpu variable */
>> > +               if (elf_sym__section(&sym) !=3D percpu_ndx)
>> > +                       continue;
>> > +
>> > +               addr =3D elf_sym__value(&sym);
>> > +               /*
>> > +                * Store only those symbols that have allocated space =
in the percpu section.
>> > +                * This excludes the following three types of symbols:
>> > +                *
>> > +                *  1. __ADDRESSABLE(sym), which are forcely emitted a=
s symbols.
>> > +                *  2. __UNIQUE_ID(prefix), which are introduced to ge=
nerate unique ids.
>> > +                *  3. __exitcall(fn), functions which are labeled as =
exit calls.
>> > +                *
>> > +                * In addition, the variables defined using DEFINE_PER=
CPU_FIRST are
>> > +                * also not included, which currently includes:
>> > +                *
>> > +                *  1. fixed_percpu_data
>> > +                */
>> > +               if (!addr)
>> > +                       continue;
>>
>> offset =3D=3D 0 is always invalid for per-cpu variables?
>
>
> On x86_64, the first area is always for irq_stack. On other architectures=
, this seems not necessary as I didn't see anywhere used DEFINE_PERCPU_FIRS=
T like x86_64. But I don't have a non-x86 64 machine to check right now.

I was asking because it seemed arbitrary to ignore one symbol that
happened to be at offset 0.

>
>>
>>
>> > +               var =3D hashaddr__find_variable(hash_addr, addr);
>> > +               if (var =3D=3D NULL)
>> > +                       continue;
>> > +
>> > +               /* add a BTF_KIND_VAR in btfe->types */
>> > +               linkage =3D var->external ? BTF_VAR_GLOBAL_ALLOCATED :=
 BTF_VAR_STATIC;
>> > +               type =3D var->ip.tag.type + type_id_off;
>> > +               btf_var_id =3D btf_elf__add_var_type(btfe, type, var->=
name, linkage);
>> > +               if (btf_var_id < 0) {
>> > +                       err =3D -1;
>> > +                       printf("error: failed to encode variable '%s'\=
n",
>> > +                              variable__name(var, cu));
>> > +                       break;
>> > +               }
>> > +
>> > +               /*
>>
>> [...]
>>
>> >  static int btf_elf__write(const char *filename, struct btf *btf)
>> >  {
>> >         GElf_Shdr shdr_mem, *shdr;
>> > @@ -727,6 +810,9 @@ int btf_elf__encode(struct btf_elf *btfe, uint8_t =
flags)
>> >         if (gobuffer__size(&btfe->types) =3D=3D 0)
>> >                 return 0;
>> >
>> > +       if (gobuffer__size(&btfe->percpu_secinfo) !=3D 0)
>> > +               btf_elf__add_datasec_type(btfe, ".data..percpu", &btfe=
->percpu_secinfo);
>>
>> would probably be better to extract ".data..percpu" into a constant
>> and use it everywhere
>
>
> Indeed. I'll add that.
>
>>
>>
>> > +
>> >         btfe->size =3D sizeof(*hdr) + (gobuffer__size(&btfe->types) + =
gobuffer__size(btfe->strings));
>> >         btfe->data =3D zalloc(btfe->size);
>> >
>>
>> [...]
