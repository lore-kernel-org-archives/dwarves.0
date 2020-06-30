From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] btf_encoder: Teach pahole to store percpu variables
 in vmlinux BTF.
Date: Tue, 30 Jun 2020 08:59:27 -0300
Message-ID: <20200630115927.GL29008@kernel.org>
References: <20200618074853.133675-1-haoluo@google.com>
 <CAEf4BzbE2K7uyJ-2d3N+NLrV5OKS0HMm5vKuxMz5bfZkE_ANzw@mail.gmail.com>
 <CAEf4Bzbiu8G5UK9TDBRFYGwVk4A4QWoLurZsFKhs439gBXaDCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbiu8G5UK9TDBRFYGwVk4A4QWoLurZsFKhs439gBXaDCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnaldo Carvalho de Melo <arnaldo.melo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexei Starovoitov <alexei.starovoitov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Oleg Rombakh <olegrom-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Martin Lau <kafai-b10kYP2dOMg@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Jun 29, 2020 at 01:20:02PM -0700, Andrii Nakryiko escreveu:
> On Fri, Jun 19, 2020 at 12:58 PM Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > On Thu, Jun 18, 2020 at 12:49 AM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> > > +               if (!addr)
> > > +                       continue;
> > > +               var = hashaddr__find_variable(hash_addr, addr);
> > > +               if (var == NULL)
> > > +                       continue;
> > > +
> > > +               /*
> > > +                * Valididate the variable's name, the same check is also
> > > +                * performed in bpf verifier.
> > > +                */
> > > +               name = variable__name(var, cu);
> > > +               if (!var->name || !btf_name_valid(name, true)) {
> >
> > It might be ok to filter them out, but I'd rather try to first
> > understand why do we get those invalid names in the first place.
> > Otherwise we might be just papering over the real bug in how we
> > process symbols/variables in DWARF?
> 
> Ok, so I played with it a bit locally. Those variables with empty name
> or 0 size seem to be due to some bugs in variable__name() and
> variable__type_size() implementations. If you stick to ELF symbol's
> elf_sym__name() and elf_sym__size(), you'll get valid sizes.
> 
> Arnaldo, could you please take a look at why variable__xxx() impls
> don't work for some variables? I can repro it locally, e.g.:

I'm looking at it, I think this is that maybe not all variables that are
in the elf symbol table are encoded in DWARF (maybe some declared in asm
files?) and thus we will not find its name in the .debug_str.

ctf_loader.c, that was used as the model for btf_loader.c has this:

static const char *ctf__variable_name(const struct variable *var,
                                      const struct cu *cu)
{
        struct ctf *ctf = cu->priv;

        return ctf->symtab->symstrs->d_buf + var->name;
}

struct debug_fmt_ops ctf__ops = {
        .name           = "ctf",
        .function__name = ctf__function_name,
        .load_file      = ctf__load_file,
        .variable__name = ctf__variable_name,
        .strings__ptr   = ctf__strings_ptr,
        .cu__delete     = ctf__cu_delete,
};

And then

const char *variable__name(const struct variable *var, const struct cu *cu)
{
        if (cu->dfops && cu->dfops->variable__name)
                return cu->dfops->variable__name(var, cu);
        return s(cu, var->name);
}

I.e. btf_loader.c and dwarf_loader.c are using the fallback return that
assumes all strings are in a single table, the CTF one gets variable
names from the ELF symtab, as you seem to be doing by using
elf_sym__name() directly.

I'm reading Hao's patch to see how the variables are being created as
they are loaded from DWARF, to check this hunch.

- Arnaldo
 
> ELF SYM kstat == <empty>, SZ 48 == 0
> invalid type size for variable '(null)'.
> invalid variable name '(null)'.
> 
> kstat and 48 come from ELF symbol, <empty> and 0 are from
> variabel__xxx(). And that happens for quite a few variables, actually.
> 
> With those fixes, my kernel can be successfully BTF-generated. The
> number of per-cpu variables jump from 213 with all this filtering to
> 287 proper variables while using elf_sym__xxx() functions.
> 
> >
> > > +                       if (verbose)
> > > +                               printf("invalid variable name '%s'.\n", name);
> > > +                       continue;
> > > +               }
> > > +
> > > +               /*
> > > +                * Validate the variable's type, the same check is also
> > > +                * performed in bpf verifier.
> > > +                */
> > > +               type = var->ip.tag.type + type_id_off;
> > > +               if (type == 0) {
> > > +                       if (verbose)
> > > +                               printf("invalid type for variable '%s'.\n", name);
> > > +                       continue;
> >
> > Again, there might be cases which we want to ignore, but we need to
> > understand what and why those cases are?
> >
> > > +               }
> > > +
> > > +               /*
> > > +                * Validate the size of the variable's type, the same check is
> > > +                * also performed in bpf verifier.
> > > +                */
> > > +               size = variable__type_size(var, cu);
> > > +               if (size == 0) {
> > > +                       if (verbose)
> > > +                               printf("invalid type size for variable '%s'.\n", name);
> > > +                       continue;
> > > +               }
> > > +
> >
> > The goal here is not to satisfy the verifier, but to generate BTF from
> > DWARF faithfully. Let's not just ignore "inconvenient" cases and
> > instead investigate why such cases happen.
> >
> > > +               if (verbose)
> > > +                       printf("symbol '%s' of address 0x%lx encoded\n",
> > > +                              elf_sym__name(&sym, btfe->symtab), addr);
> > > +
> > > +               /* add a BTF_KIND_VAR in btfe->types */
> > > +               linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
> > > +               btf_var_id = btf_elf__add_var_type(btfe, type, var->name, linkage);
> > > +               if (btf_var_id < 0) {
> > > +                       err = -1;
> > > +                       printf("error: failed to encode variable '%s'\n", name);
> > > +                       break;
> > > +               }
> > > +
> > > +               /*
> > > +                * add a BTF_VAR_SECINFO in btfe->percpu_secinfo, which will be added into
> > > +                * btfe->types later when we add BTF_VAR_DATASEC.
> > > +                */
> > > +               type = btf_var_id;
> > > +               offset = addr - btfe->percpu_base_addr;
> > > +               btf_var_secinfo_id = btf_elf__add_var_secinfo(&btfe->percpu_secinfo,
> > > +                                                             type, offset, size);
> > > +               if (btf_var_secinfo_id < 0) {
> > > +                       err = -1;
> > > +                       printf("error: failed to encode var secinfo '%s'\n", name);
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > >  out:
> > >         if (err)
> > >                 btf_elf__delete(btfe);
> >
> > [...]

-- 

- Arnaldo
