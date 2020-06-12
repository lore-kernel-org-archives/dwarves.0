From: Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] btf_encoder: Teach pahole to store percpu variables in
 vmlinux BTF.
Date: Fri, 12 Jun 2020 15:01:10 -0700
Message-ID: <CAEf4BzbJYJxJq3+KcMndMvO-QzGBVjAxQEN1gRqoYrqpHdx-6w@mail.gmail.com>
References: <20200608173403.151706-1-haoluo@google.com> <20200609142940.GA24868@kernel.org>
 <20200609145820.GB24868@kernel.org> <CA+khW7j_bBNNepxyk4pZQLMS3CxA4CKQ-9cSSub-hTDQW5xZVQ@mail.gmail.com>
 <CA+khW7iBAFELfYmJDQK5eQ-Q+bCg7Hv3WAYPLz6iPXOO6+TQHw@mail.gmail.com> <CA+khW7iEMXgtauLikO3YwUZus7hsdQti_KjZXk7uoCdPUBc=qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+khW7iEMXgtauLikO3YwUZus7hsdQti_KjZXk7uoCdPUBc=qw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexei Starovoitov <alexei.starovoitov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Oleg Rombakh <olegrom-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Martin KaFai Lau <kafai-b10kYP2dOMg@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Fri, Jun 12, 2020 at 2:54 PM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>
> Further updates:
>
> Previously the in-kernel bpf verifier rejected the enhanced vmlinux becau=
se I set the "size" field of datasec to 0, which is obviously forbidden by =
the bpf kernel verifier. After I adjusted it to the last var_secinfo's offs=
et + size, it got loaded successfully. In addition, there are a few more sa=
nity checks in the verifier on DATASEC and VAR's meta format (e.g. type siz=
e, variable name, etc.), which I am going to port into btf_encoder to be 10=
0% safe. With these checks, the "(anon)" vars seen by Arnaldo should be gon=
e. I am currently running through a set of tp_btf, fentry and fexit program=
s on the enhanced vmlinux and they are looking good so far. I hope to uploa=
d these changes in the next iteration next week.

Do you know where those (anon) vars are coming from?

>
> Thanks,
> Hao
>
> On Thu, Jun 11, 2020 at 2:41 PM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> I am finally able to get a tp_btf program compiled and tested against th=
e generated vmlinux. Unfortunately, the bpf verifier seemed to have rejecte=
d the vmlinux. I got an error message "in-kernel BTF is malformed". I have =
to work on the bpf verifier first to make it compatible with the newly adde=
d VARs.
>>
>> Hao
>>
>> On Thu, Jun 11, 2020 at 10:59 AM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>>>
>>> Hi Arnaldo,
>>>
>>> Sorry for the late reply, I was tied to other stuff on my other work in=
 the last couple of days. I am going to take a closer look today and tomorr=
ow. It seems I had difficulty reproducing in my local environment, maybe du=
e to differences in compiler flags or kconfigs. Could you help me by enabli=
ng verbose to see which CU generated those symbols? In the patch I have add=
ed debug messages reporting the current CU and symbols that got encoded.
>>>
>>> Thanks,
>>> Hao
>>>
>>>
>>> On Tue, Jun 9, 2020 at 7:58 AM Arnaldo Carvalho de Melo <acme-DgEjT+Ai2yhQFI55V6+gNQ@public.gmane.org=
g> wrote:
>>>>
>>>> Em Tue, Jun 09, 2020 at 11:29:40AM -0300, Arnaldo Carvalho de Melo esc=
reveu:
>>>> > Em Mon, Jun 08, 2020 at 10:34:03AM -0700, Hao Luo escreveu:
>>>> > > On SMP systems, the global percpu variables are placed in a specia=
l
>>>> > > '.data..percpu' section, which is stored in a segment whose initia=
l
>>>> > > address is set to 0, the addresses of per-CPU variables are relati=
ve
>>>> > > positive addresses [1].
>>>> > >
>>>> > > This patch extracts these variables from vmlinux and places them w=
ith
>>>> > > their type information in BTF. More specifically, when BTF is enco=
ded,
>>>> > > we find the index of the '.data..percpu' section and then traverse
>>>> > > the symbol table to find those global objects which are in this se=
ction.
>>>> > > For each of these objects, we push a BTF_KIND_VAR into the types b=
uffer,
>>>> > > and a BTF_VAR_SECINFO into another buffer, percpu_secinfo. When al=
l the
>>>> > > CUs have finished processing, we push a BTF_KIND_DATASEC into the
>>>> > > btfe->types buffer, followed by the percpu_secinfo's content.
>>>> > >
>>>> > > In a v5.7-rc7 linux kernel, I was able to extract 291 such variabl=
es.
>>>> > > The build time overhead is small and the space overhead is also sm=
all.
>>>> >
>>>> > Looks good, I'm doing some testing on it now, Andrii, can you provid=
e an
>>>> > Acked-by or Reviewed-by?
>>>>
>>>> So, I see these (anon) variables, what are these? for an 5.7 vmlinux:
>>>>
>>>> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w VAR | tail
>>>> [67381] VAR '(anon)' type_id=3D67175, linkage=3Dstatic
>>>> [67495] VAR 'rt_cache_stat' type_id=3D67417, linkage=3Dstatic
>>>> [67496] VAR 'rt_uncached_list' type_id=3D67416, linkage=3Dstatic
>>>> [67857] VAR 'tcp_md5sig_pool' type_id=3D67788, linkage=3Dstatic
>>>> [67993] VAR 'tsq_tasklet' type_id=3D67927, linkage=3Dstatic
>>>> [69524] VAR 'xfrm_trans_tasklet' type_id=3D69502, linkage=3Dstatic
>>>> [70055] VAR 'rt6_uncached_list' type_id=3D67416, linkage=3Dstatic
>>>> [70609] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [70634] VAR 'hmac_ring' type_id=3D1909, linkage=3Dstatic
>>>> [71591] VAR 'xskmap_flush_list' type_id=3D85, linkage=3Dstatic
>>>> [acme@five pahole]$
>>>>
>>>> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w 1713
>>>> [1713] FUNC 'memset' type_id=3D1712
>>>> [7235] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [7236] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [8832] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [14346] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [14347] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [14348] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [14349] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [14350] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [14351] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [14352] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [18903] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [18904] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [23180] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [44605] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [60638] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [60639] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [63869] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [70609] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [acme@five pahole]$
>>>>
>>>> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -m1 -w 1713 -=
B9
>>>> [1710] FUNC_PROTO '(anon)' ret_type_id=3D96 vlen=3D3
>>>>         'p' type_id=3D96
>>>>         'q' type_id=3D97
>>>>         'size' type_id=3D49
>>>> [1711] FUNC 'memcpy' type_id=3D1710
>>>> [1712] FUNC_PROTO '(anon)' ret_type_id=3D96 vlen=3D3
>>>>         'p' type_id=3D96
>>>>         'c' type_id=3D22
>>>>         'size' type_id=3D49
>>>> [1713] FUNC 'memset' type_id=3D1712
>>>> [acme@five pahole]$
>>>>
>>>> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -m10 -w 7235 =
-B5 -A5
>>>>         'prec' type_id=3D22
>>>> [7232] FUNC 'arch_show_interrupts' type_id=3D7231
>>>> [7233] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D1
>>>>         'irq' type_id=3D10
>>>> [7234] FUNC 'ack_bad_irq' type_id=3D7233
>>>> [7235] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [7236] VAR '(anon)' type_id=3D1713, linkage=3Dstatic
>>>> [7237] ARRAY '(anon)' type_id=3D233 index_type_id=3D1 nr_elems=3D4
>>>> [7238] FUNC 'irq_init_percpu_irqstack' type_id=3D6732
>>>> [7239] VAR 'irq_stack_backing_store' type_id=3D412, linkage=3Dglobal-a=
lloc
>>>> [7240] STRUCT 'estack_pages' size=3D8 vlen=3D3
>>>> --
>>>>         type_id=3D6739 offset=3D98096 size=3D16
>>>>         type_id=3D6737 offset=3D98112 size=3D16
>>>>         type_id=3D6736 offset=3D98128 size=3D16
>>>>         type_id=3D6764 offset=3D98144 size=3D16
>>>>         type_id=3D6763 offset=3D98160 size=3D16
>>>>         type_id=3D7235 offset=3D98176 size=3D0
>>>>         type_id=3D7330 offset=3D98192 size=3D4
>>>>         type_id=3D7329 offset=3D98200 size=3D8
>>>>         type_id=3D7328 offset=3D98208 size=3D4
>>>>         type_id=3D7325 offset=3D98216 size=3D8
>>>>         type_id=3D7327 offset=3D98224 size=3D1
>>>> [acme@five pahole]$
>>>>
>>>> [acme@five pahole]$ readelf  -wi vmlinux  | grep -m 2 DW_AT_producer
>>>>     <1c>   DW_AT_producer    : (indirect string, offset: 0x49): GNU AS=
 2.32
>>>>     <2e>   DW_AT_producer    : (indirect string, offset: 0x1358): GNU =
C89 9.3.1 20200408 (Red Hat 9.3.1-2) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow=
 -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3D3=
 -mskip-rax-setup -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -mindire=
ct-branch=3Dthunk-extern -mindirect-branch-register -mrecord-mcount -mfentr=
y -march=3Dx86-64 -g -O2 -std=3Dgnu90 -fno-strict-aliasing -fno-common -fsh=
ort-wchar -fno-PIE -falign-jumps=3D1 -falign-loops=3D1 -fno-asynchronous-un=
wind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fstack-protec=
tor-strong -fno-var-tracking-assignments -fno-strict-overflow -fno-merge-al=
l-constants -fmerge-constants -fstack-check=3Dno -fconserve-stack -fcf-prot=
ection=3Dnone --param allow-store-data-races=3D0
>>>> [acme@five pahole]$
>>>>
>>>> > Thanks,
>>>> >
>>>> > - Arnaldo
>>>> >
>>>> > > Testing:
>>>> > >
>>>> > > Before:
>>>> > >  $ readelf -SW vmlinux | grep BTF
>>>> > >  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2=
d2bf8 00   A  0   0  1
>>>> > >
>>>> > > After:
>>>> > >  $ pahole -J vmlinux
>>>> > >  $ readelf -SW vmlinux  | grep BTF
>>>> > >  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2=
d5bca 00   A  0   0  1
>>>> > >
>>>> > > Common percpu vars can be found in the BTF section.
>>>> > >
>>>> > >  $ bpftool btf dump file vmlinux | grep runqueues
>>>> > >  [14098] VAR 'runqueues' type_id=3D13725, linkage=3Dglobal-alloc
>>>> > >
>>>> > >  $ bpftool btf dump file vmlinux | grep 'cpu_stopper'
>>>> > >  [17592] STRUCT 'cpu_stopper' size=3D72 vlen=3D5
>>>> > >  [17612] VAR 'cpu_stopper' type_id=3D17592, linkage=3Dstatic
>>>> > >
>>>> > >  $ bpftool btf dump file vmlinux | grep ' DATASEC '
>>>> > >  [63652] DATASEC '.data..percpu' size=3D0 vlen=3D294
>>>> > >
>>>> > > References:
>>>> > >  [1] https://lwn.net/Articles/531148/
>>>> > > Signed-off-by: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>>>> > > ---
>>>> > > Changelog since v2:
>>>> > > - Move finding percpu_shndx and extracting symtab into btfe creati=
on,
>>>> > >   so we don't have to allocate a new symtab for each CU.
>>>> > > - More debug msg by logging the vars encoded in 'verbose' mode. We
>>>> > >   probably don't want to log the symbols that are _not_ encoded,
>>>> > >   since that would be too verbose.
>>>> > > - Calculate var offsets using 'addr - shdr.sh_addr', so it could b=
e
>>>> > >   generalized to other sections in future.
>>>> > > - Filter out the symbols that are not STT_OBJECT.
>>>> > > - Sort var_secinfos in the DATASEC by their offsets.
>>>> > > - Free 'persec_secinfo' buffer and 'symtab' in btfe deletion.
>>>> > > - Replace the string ".data..percpu" with a constant PERCPU_SECTIO=
N.
>>>> > >
>>>> > > Changelog since v1:
>>>> > > - Add a ".data..percpu" DATASEC that encodes the found VARs.
>>>> > > - Use percpu section's shndx to find the symbols that are percpu v=
ariables.
>>>> > > - Use the correct type to set VAR's linkage.
>>>> > >
>>>> > >  btf_encoder.c | 119 +++++++++++++++++++++++++++++++++++++++++++++=
+++
>>>> > >  dwarves.c     |   6 +++
>>>> > >  dwarves.h     |   2 +
>>>> > >  libbtf.c      | 123 +++++++++++++++++++++++++++++++++++++++++++++=
+++++
>>>> > >  libbtf.h      |  12 +++++
>>>> > >  pahole.c      |   1 +
>>>> > >  6 files changed, 263 insertions(+)
>>>> > >

[...]
