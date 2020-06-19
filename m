From: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4] btf_encoder: Teach pahole to store percpu variables in
 vmlinux BTF.
Date: Fri, 19 Jun 2020 13:30:36 -0700
Message-ID: <CA+khW7j3AoW8q+Q30RXG-psw4imkBxNqffObnu2dr2=K=oVBCg@mail.gmail.com>
References: <20200618074853.133675-1-haoluo@google.com> <CAEf4BzbE2K7uyJ-2d3N+NLrV5OKS0HMm5vKuxMz5bfZkE_ANzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEf4BzbE2K7uyJ-2d3N+NLrV5OKS0HMm5vKuxMz5bfZkE_ANzw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexei Starovoitov <alexei.starovoitov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Oleg Rombakh <olegrom-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Martin Lau <kafai-b10kYP2dOMg@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi, Andrii,

I agree that we'd better put a hold on this patch until we find out
the reason for the 'unconventional' symbols. I'll _try_ to figure it
out, but not able to fully commit my time on this patch. I thought I'd
better publish this patch as the DATASEC and VARs are generated
correctly in format, so that anyone can use it to generate the vmlinux
and continue the development on libbpf based on your ksym work (i.e.
typed ksyms).

Hao

On Fri, Jun 19, 2020 at 12:58 PM Andrii Nakryiko
<andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On Thu, Jun 18, 2020 at 12:49 AM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > On SMP systems, the global percpu variables are placed in a special
> > '.data..percpu' section, which is stored in a segment whose initial
> > address is set to 0, the addresses of per-CPU variables are relative
> > positive addresses [1].
> >
> > This patch extracts these variables from vmlinux and places them with
> > their type information in BTF. More specifically, when BTF is encoded,
> > we find the index of the '.data..percpu' section and then traverse
> > the symbol table to find those global objects which are in this section.
> > For each of these objects, we push a BTF_KIND_VAR into the types buffer,
> > and a BTF_VAR_SECINFO into another buffer, percpu_secinfo. When all the
> > CUs have finished processing, we push a BTF_KIND_DATASEC into the
> > btfe->types buffer, followed by the percpu_secinfo's content.
> >
> > In a v5.7-rc7 linux kernel, I was able to extract 291 such variables.
> > The build time overhead is small and the space overhead is also small.
> >
> > Testing:
> >
> > - vmlinux size has increased by ~12kb.
> >   Before:
> >    $ readelf -SW vmlinux | grep BTF
> >    [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2d2bf8 00
> >   After:
> >    $ pahole -J vmlinux
> >    $ readelf -SW vmlinux  | grep BTF
> >    [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2d5bca 00
> >
> > - Common global percpu VARs and DATASEC are found in BTF section.
> >   $ bpftool btf dump file vmlinux | grep runqueues
> >   [14098] VAR 'runqueues' type_id=13725, linkage=global-alloc
> >
> >   $ bpftool btf dump file vmlinux | grep 'cpu_stopper'
> >   [17592] STRUCT 'cpu_stopper' size=72 vlen=5
> >   [17612] VAR 'cpu_stopper' type_id=17592, linkage=static
> >
> >   $ bpftool btf dump file vmlinux | grep ' DATASEC '
> >   [63652] DATASEC '.data..percpu' size=0 vlen=294
>
> probably forgot to update the example, I'd imagine size wouldn't be 0 anymore?
>

Ah, right, I overlooked the example.

> >
> > - Tested bpf selftests.
> >
> > References:
> >  [1] https://lwn.net/Articles/531148/
> > Signed-off-by: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > ---
>
> I'm quite a bit uncomfortable that pahole would just ignore
> non-conformat variables. We should understand why there might even be
> those variables with invalid names, how that can happen in C?
>
>
> > Changelog since v3:
> > - Correct the size of the DATASEC, which was previously 0 and now is
> >   the last var_secinfo's offset + size.
> > - Add several sanity checks on VARs and DATASEC to ensure that the
> >   generated BTF will not be rejected by verifier.
> > - Tested through a set of selftests and bpf_tracing programs.
> >
> > Changelog since v2:
> > - Move finding percpu_shndx and extracting symtab into btfe creation,
> >   so we don't have to allocate a new symtab for each CU.
> > - More debug msg by logging the vars encoded in 'verbose' mode. We
> >   probably don't want to log the symbols that are _not_ encoded,
> >   since that would be too verbose.
> > - Calculate var offsets using 'addr - shdr.sh_addr', so it could be
> >   generalized to other sections in future.
> > - Filter out the symbols that are not STT_OBJECT.
> > - Sort var_secinfos in the DATASEC by their offsets.
> > - Free 'persec_secinfo' buffer and 'symtab' in btfe deletion.
> > - Replace the string ".data..percpu" with a constant PERCPU_SECTION.
> >
> > Changelog since v1:
> > - Add a ".data..percpu" DATASEC that encodes the found VARs.
> > - Use percpu section's shndx to find the symbols that are percpu variables.
> > - Use the correct type to set VAR's linkage.
> >
> >  btf_encoder.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  dwarves.c     |   6 ++
> >  dwarves.h     |   2 +
> >  libbtf.c      | 127 ++++++++++++++++++++++++++++++++++
> >  libbtf.h      |  12 ++++
> >  pahole.c      |   1 +
> >  6 files changed, 333 insertions(+)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index df16ba0..c7401c3 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -16,8 +16,44 @@
> >  #include "elf_symtab.h"
> >  #include "btf_encoder.h"
> >
> > +#include <ctype.h> /* for isalpha() and isalnum() */
> >  #include <inttypes.h>
> >
> > +/*
> > + * This corresponds to the same macro defined in
> > + * include/linux/kallsyms.h
> > + */
> > +#define KSYM_NAME_LEN 128
> > +
> > +static bool btf_name_char_ok(char c, bool first, bool dot_ok)
> > +{
> > +       if ((first ? !isalpha(c) : !isalnum(c)) &&
> > +           c != '_' &&
> > +           ((c == '.' && !dot_ok) || c != '.'))
> > +               return false;
> > +       return true;
> > +}
> > +
> > +/* Check wether the given name is valid in vmlinux btf. */
> > +static bool btf_name_valid(const char *p, bool dot_ok)
>
> dot_ok is always true, you can simplify above function
>
> > +{
> > +       const char *limit;
> > +
> > +       if (!btf_name_char_ok(*p, true, dot_ok))
> > +               return false;
> > +
> > +       /* set a limit on identifier length */
> > +       limit = p + KSYM_NAME_LEN;
> > +       p++;
> > +       while (*p && p < limit) {
> > +               if (!btf_name_char_ok(*p, false, dot_ok))
> > +                       return false;
> > +               p++;
> > +       }
> > +
> > +       return !*p;
> > +}
> > +
>
> [...]
>
> > +       /* search within symtab for percpu variables */
> > +       elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
> > +               uint32_t linkage, type, size, offset;
> > +               int32_t btf_var_id, btf_var_secinfo_id;
> > +               uint64_t addr;
> > +               const char *name;
> > +
> > +               /* compare a symbol's shndx to determine if it's a percpu variable */
> > +               if (elf_sym__section(&sym) != btfe->percpu_shndx)
> > +                       continue;
> > +               if (elf_sym__type(&sym) != STT_OBJECT)
> > +                       continue;
> > +
> > +               addr = elf_sym__value(&sym);
> > +               /*
> > +                * Store only those symbols that have allocated space in the percpu section.
> > +                * This excludes the following three types of symbols:
> > +                *
> > +                *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> > +                *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> > +                *  3. __exitcall(fn), functions which are labeled as exit calls.
> > +                *
> > +                * In addition, the variables defined using DEFINE_PERCPU_FIRST are
> > +                * also not included, which currently includes:
> > +                *
> > +                *  1. fixed_percpu_data
> > +                */
> > +               if (!addr)
> > +                       continue;
> > +               var = hashaddr__find_variable(hash_addr, addr);
> > +               if (var == NULL)
> > +                       continue;
> > +
> > +               /*
> > +                * Valididate the variable's name, the same check is also
> > +                * performed in bpf verifier.
> > +                */
> > +               name = variable__name(var, cu);
> > +               if (!var->name || !btf_name_valid(name, true)) {
>
> It might be ok to filter them out, but I'd rather try to first
> understand why do we get those invalid names in the first place.
> Otherwise we might be just papering over the real bug in how we
> process symbols/variables in DWARF?
>
> > +                       if (verbose)
> > +                               printf("invalid variable name '%s'.\n", name);
> > +                       continue;
> > +               }
> > +
> > +               /*
> > +                * Validate the variable's type, the same check is also
> > +                * performed in bpf verifier.
> > +                */
> > +               type = var->ip.tag.type + type_id_off;
> > +               if (type == 0) {
> > +                       if (verbose)
> > +                               printf("invalid type for variable '%s'.\n", name);
> > +                       continue;
>
> Again, there might be cases which we want to ignore, but we need to
> understand what and why those cases are?
>
> > +               }
> > +
> > +               /*
> > +                * Validate the size of the variable's type, the same check is
> > +                * also performed in bpf verifier.
> > +                */
> > +               size = variable__type_size(var, cu);
> > +               if (size == 0) {
> > +                       if (verbose)
> > +                               printf("invalid type size for variable '%s'.\n", name);
> > +                       continue;
> > +               }
> > +
>
> The goal here is not to satisfy the verifier, but to generate BTF from
> DWARF faithfully. Let's not just ignore "inconvenient" cases and
> instead investigate why such cases happen.
>
> > +               if (verbose)
> > +                       printf("symbol '%s' of address 0x%lx encoded\n",
> > +                              elf_sym__name(&sym, btfe->symtab), addr);
> > +
> > +               /* add a BTF_KIND_VAR in btfe->types */
> > +               linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
> > +               btf_var_id = btf_elf__add_var_type(btfe, type, var->name, linkage);
> > +               if (btf_var_id < 0) {
> > +                       err = -1;
> > +                       printf("error: failed to encode variable '%s'\n", name);
> > +                       break;
> > +               }
> > +
> > +               /*
> > +                * add a BTF_VAR_SECINFO in btfe->percpu_secinfo, which will be added into
> > +                * btfe->types later when we add BTF_VAR_DATASEC.
> > +                */
> > +               type = btf_var_id;
> > +               offset = addr - btfe->percpu_base_addr;
> > +               btf_var_secinfo_id = btf_elf__add_var_secinfo(&btfe->percpu_secinfo,
> > +                                                             type, offset, size);
> > +               if (btf_var_secinfo_id < 0) {
> > +                       err = -1;
> > +                       printf("error: failed to encode var secinfo '%s'\n", name);
> > +                       break;
> > +               }
> > +       }
> > +
> >  out:
> >         if (err)
> >                 btf_elf__delete(btfe);
>
> [...]
