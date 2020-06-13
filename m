From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] btf_encoder: Teach pahole to store percpu variables
 in vmlinux BTF.
Date: Sat, 13 Jun 2020 19:12:44 -0300
Message-ID: <20200613221244.GA7488@kernel.org>
References: <20200608173403.151706-1-haoluo@google.com>
 <20200609142940.GA24868@kernel.org>
 <20200609145820.GB24868@kernel.org>
 <CA+khW7j_bBNNepxyk4pZQLMS3CxA4CKQ-9cSSub-hTDQW5xZVQ@mail.gmail.com>
 <CA+khW7iBAFELfYmJDQK5eQ-Q+bCg7Hv3WAYPLz6iPXOO6+TQHw@mail.gmail.com>
 <CA+khW7iEMXgtauLikO3YwUZus7hsdQti_KjZXk7uoCdPUBc=qw@mail.gmail.com>
 <CAEf4BzbJYJxJq3+KcMndMvO-QzGBVjAxQEN1gRqoYrqpHdx-6w@mail.gmail.com>
 <CA+khW7h1O+7XFuS-T-=3MUjr6qhbEE+tUyLbbHoSn6fWzN+xTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+khW7h1O+7XFuS-T-=3MUjr6qhbEE+tUyLbbHoSn6fWzN+xTg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexei Starovoitov <alexei.starovoitov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Oleg Rombakh <olegrom-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Martin KaFai Lau <kafai-b10kYP2dOMg@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Fri, Jun 12, 2020 at 03:16:46PM -0700, Hao Luo escreveu:
> On Fri, Jun 12, 2020 at 3:01 PM Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> 
> > On Fri, Jun 12, 2020 at 2:54 PM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> > >
> > > Further updates:
> > >
> > > Previously the in-kernel bpf verifier rejected the enhanced vmlinux
> > because I set the "size" field of datasec to 0, which is obviously
> > forbidden by the bpf kernel verifier. After I adjusted it to the last
> > var_secinfo's offset + size, it got loaded successfully. In addition, there
> > are a few more sanity checks in the verifier on DATASEC and VAR's meta
> > format (e.g. type size, variable name, etc.), which I am going to port into
> > btf_encoder to be 100% safe. With these checks, the "(anon)" vars seen by
> > Arnaldo should be gone. I am currently running through a set of tp_btf,
> > fentry and fexit programs on the enhanced vmlinux and they are looking good
> > so far. I hope to upload these changes in the next iteration next week.
> >
> > Do you know where those (anon) vars are coming from?
> >
> 
> Nah, I am curious too but can't reproduce on my side. It would be helpful
> if Arnaldo could enable the debug msg I put in the patch and let me know
> which cu generates those (anon) vars.

I'll try and send it, maybe tomorrow (Sunday).
 
> 
> >
> > >
> > > Thanks,
> > > Hao
> > >
> > > On Thu, Jun 11, 2020 at 2:41 PM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> > >>
> > >> I am finally able to get a tp_btf program compiled and tested against
> > the generated vmlinux. Unfortunately, the bpf verifier seemed to have
> > rejected the vmlinux. I got an error message "in-kernel BTF is malformed".
> > I have to work on the bpf verifier first to make it compatible with the
> > newly added VARs.
> > >>
> > >> Hao
> > >>
> > >> On Thu, Jun 11, 2020 at 10:59 AM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> > >>>
> > >>> Hi Arnaldo,
> > >>>
> > >>> Sorry for the late reply, I was tied to other stuff on my other work
> > in the last couple of days. I am going to take a closer look today and
> > tomorrow. It seems I had difficulty reproducing in my local environment,
> > maybe due to differences in compiler flags or kconfigs. Could you help me
> > by enabling verbose to see which CU generated those symbols? In the patch I
> > have added debug messages reporting the current CU and symbols that got
> > encoded.
> > >>>
> > >>> Thanks,
> > >>> Hao
> > >>>
> > >>>
> > >>> On Tue, Jun 9, 2020 at 7:58 AM Arnaldo Carvalho de Melo <
> > acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > >>>>
> > >>>> Em Tue, Jun 09, 2020 at 11:29:40AM -0300, Arnaldo Carvalho de Melo
> > escreveu:
> > >>>> > Em Mon, Jun 08, 2020 at 10:34:03AM -0700, Hao Luo escreveu:
> > >>>> > > On SMP systems, the global percpu variables are placed in a
> > special
> > >>>> > > '.data..percpu' section, which is stored in a segment whose
> > initial
> > >>>> > > address is set to 0, the addresses of per-CPU variables are
> > relative
> > >>>> > > positive addresses [1].
> > >>>> > >
> > >>>> > > This patch extracts these variables from vmlinux and places them
> > with
> > >>>> > > their type information in BTF. More specifically, when BTF is
> > encoded,
> > >>>> > > we find the index of the '.data..percpu' section and then traverse
> > >>>> > > the symbol table to find those global objects which are in this
> > section.
> > >>>> > > For each of these objects, we push a BTF_KIND_VAR into the types
> > buffer,
> > >>>> > > and a BTF_VAR_SECINFO into another buffer, percpu_secinfo. When
> > all the
> > >>>> > > CUs have finished processing, we push a BTF_KIND_DATASEC into the
> > >>>> > > btfe->types buffer, followed by the percpu_secinfo's content.
> > >>>> > >
> > >>>> > > In a v5.7-rc7 linux kernel, I was able to extract 291 such
> > variables.
> > >>>> > > The build time overhead is small and the space overhead is also
> > small.
> > >>>> >
> > >>>> > Looks good, I'm doing some testing on it now, Andrii, can you
> > provide an
> > >>>> > Acked-by or Reviewed-by?
> > >>>>
> > >>>> So, I see these (anon) variables, what are these? for an 5.7 vmlinux:
> > >>>>
> > >>>> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w VAR |
> > tail
> > >>>> [67381] VAR '(anon)' type_id=67175, linkage=static
> > >>>> [67495] VAR 'rt_cache_stat' type_id=67417, linkage=static
> > >>>> [67496] VAR 'rt_uncached_list' type_id=67416, linkage=static
> > >>>> [67857] VAR 'tcp_md5sig_pool' type_id=67788, linkage=static
> > >>>> [67993] VAR 'tsq_tasklet' type_id=67927, linkage=static
> > >>>> [69524] VAR 'xfrm_trans_tasklet' type_id=69502, linkage=static
> > >>>> [70055] VAR 'rt6_uncached_list' type_id=67416, linkage=static
> > >>>> [70609] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [70634] VAR 'hmac_ring' type_id=1909, linkage=static
> > >>>> [71591] VAR 'xskmap_flush_list' type_id=85, linkage=static
> > >>>> [acme@five pahole]$
> > >>>>
> > >>>> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w 1713
> > >>>> [1713] FUNC 'memset' type_id=1712
> > >>>> [7235] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [7236] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [8832] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [14346] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [14347] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [14348] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [14349] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [14350] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [14351] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [14352] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [18903] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [18904] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [23180] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [44605] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [60638] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [60639] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [63869] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [70609] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [acme@five pahole]$
> > >>>>
> > >>>> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -m1 -w 1713
> > -B9
> > >>>> [1710] FUNC_PROTO '(anon)' ret_type_id=96 vlen=3
> > >>>>         'p' type_id=96
> > >>>>         'q' type_id=97
> > >>>>         'size' type_id=49
> > >>>> [1711] FUNC 'memcpy' type_id=1710
> > >>>> [1712] FUNC_PROTO '(anon)' ret_type_id=96 vlen=3
> > >>>>         'p' type_id=96
> > >>>>         'c' type_id=22
> > >>>>         'size' type_id=49
> > >>>> [1713] FUNC 'memset' type_id=1712
> > >>>> [acme@five pahole]$
> > >>>>
> > >>>> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -m10 -w
> > 7235 -B5 -A5
> > >>>>         'prec' type_id=22
> > >>>> [7232] FUNC 'arch_show_interrupts' type_id=7231
> > >>>> [7233] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
> > >>>>         'irq' type_id=10
> > >>>> [7234] FUNC 'ack_bad_irq' type_id=7233
> > >>>> [7235] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [7236] VAR '(anon)' type_id=1713, linkage=static
> > >>>> [7237] ARRAY '(anon)' type_id=233 index_type_id=1 nr_elems=4
> > >>>> [7238] FUNC 'irq_init_percpu_irqstack' type_id=6732
> > >>>> [7239] VAR 'irq_stack_backing_store' type_id=412, linkage=global-alloc
> > >>>> [7240] STRUCT 'estack_pages' size=8 vlen=3
> > >>>> --
> > >>>>         type_id=6739 offset=98096 size=16
> > >>>>         type_id=6737 offset=98112 size=16
> > >>>>         type_id=6736 offset=98128 size=16
> > >>>>         type_id=6764 offset=98144 size=16
> > >>>>         type_id=6763 offset=98160 size=16
> > >>>>         type_id=7235 offset=98176 size=0
> > >>>>         type_id=7330 offset=98192 size=4
> > >>>>         type_id=7329 offset=98200 size=8
> > >>>>         type_id=7328 offset=98208 size=4
> > >>>>         type_id=7325 offset=98216 size=8
> > >>>>         type_id=7327 offset=98224 size=1
> > >>>> [acme@five pahole]$
> > >>>>
> > >>>> [acme@five pahole]$ readelf  -wi vmlinux  | grep -m 2 DW_AT_producer
> > >>>>     <1c>   DW_AT_producer    : (indirect string, offset: 0x49): GNU
> > AS 2.32
> > >>>>     <2e>   DW_AT_producer    : (indirect string, offset: 0x1358): GNU
> > C89 9.3.1 20200408 (Red Hat 9.3.1-2) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
> > -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3
> > -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel
> > -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount
> > -mfentry -march=x86-64 -g -O2 -std=gnu90 -fno-strict-aliasing -fno-common
> > -fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1
> > -fno-asynchronous-unwind-tables -fno-jump-tables
> > -fno-delete-null-pointer-checks -fstack-protector-strong
> > -fno-var-tracking-assignments -fno-strict-overflow -fno-merge-all-constants
> > -fmerge-constants -fstack-check=no -fconserve-stack -fcf-protection=none
> > --param allow-store-data-races=0
> > >>>> [acme@five pahole]$
> > >>>>
> > >>>> > Thanks,
> > >>>> >
> > >>>> > - Arnaldo
> > >>>> >
> > >>>> > > Testing:
> > >>>> > >
> > >>>> > > Before:
> > >>>> > >  $ readelf -SW vmlinux | grep BTF
> > >>>> > >  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c
> > 2d2bf8 00   A  0   0  1
> > >>>> > >
> > >>>> > > After:
> > >>>> > >  $ pahole -J vmlinux
> > >>>> > >  $ readelf -SW vmlinux  | grep BTF
> > >>>> > >  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c
> > 2d5bca 00   A  0   0  1
> > >>>> > >
> > >>>> > > Common percpu vars can be found in the BTF section.
> > >>>> > >
> > >>>> > >  $ bpftool btf dump file vmlinux | grep runqueues
> > >>>> > >  [14098] VAR 'runqueues' type_id=13725, linkage=global-alloc
> > >>>> > >
> > >>>> > >  $ bpftool btf dump file vmlinux | grep 'cpu_stopper'
> > >>>> > >  [17592] STRUCT 'cpu_stopper' size=72 vlen=5
> > >>>> > >  [17612] VAR 'cpu_stopper' type_id=17592, linkage=static
> > >>>> > >
> > >>>> > >  $ bpftool btf dump file vmlinux | grep ' DATASEC '
> > >>>> > >  [63652] DATASEC '.data..percpu' size=0 vlen=294
> > >>>> > >
> > >>>> > > References:
> > >>>> > >  [1] https://lwn.net/Articles/531148/
> > >>>> > > Signed-off-by: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > >>>> > > ---
> > >>>> > > Changelog since v2:
> > >>>> > > - Move finding percpu_shndx and extracting symtab into btfe
> > creation,
> > >>>> > >   so we don't have to allocate a new symtab for each CU.
> > >>>> > > - More debug msg by logging the vars encoded in 'verbose' mode. We
> > >>>> > >   probably don't want to log the symbols that are _not_ encoded,
> > >>>> > >   since that would be too verbose.
> > >>>> > > - Calculate var offsets using 'addr - shdr.sh_addr', so it could
> > be
> > >>>> > >   generalized to other sections in future.
> > >>>> > > - Filter out the symbols that are not STT_OBJECT.
> > >>>> > > - Sort var_secinfos in the DATASEC by their offsets.
> > >>>> > > - Free 'persec_secinfo' buffer and 'symtab' in btfe deletion.
> > >>>> > > - Replace the string ".data..percpu" with a constant
> > PERCPU_SECTION.
> > >>>> > >
> > >>>> > > Changelog since v1:
> > >>>> > > - Add a ".data..percpu" DATASEC that encodes the found VARs.
> > >>>> > > - Use percpu section's shndx to find the symbols that are percpu
> > variables.
> > >>>> > > - Use the correct type to set VAR's linkage.
> > >>>> > >
> > >>>> > >  btf_encoder.c | 119
> > ++++++++++++++++++++++++++++++++++++++++++++++++
> > >>>> > >  dwarves.c     |   6 +++
> > >>>> > >  dwarves.h     |   2 +
> > >>>> > >  libbtf.c      | 123
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >>>> > >  libbtf.h      |  12 +++++
> > >>>> > >  pahole.c      |   1 +
> > >>>> > >  6 files changed, 263 insertions(+)
> > >>>> > >
> >
> > [...]
> >

-- 

- Arnaldo
