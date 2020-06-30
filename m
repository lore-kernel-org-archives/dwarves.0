From: Arnaldo Carvalho de Melo <arnaldo.melo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.
Date: Mon, 29 Jun 2020 22:02:31 -0300
Message-ID: <5839EE93-F4F3-4210-9095-13CADC1822E8@gmail.com>
References: <20200618074853.133675-1-haoluo@google.com> <CAEf4BzbE2K7uyJ-2d3N+NLrV5OKS0HMm5vKuxMz5bfZkE_ANzw@mail.gmail.com> <CA+khW7j3AoW8q+Q30RXG-psw4imkBxNqffObnu2dr2=K=oVBCg@mail.gmail.com> <CAEf4Bza20kx3d+84Fg+UKXFYb2vforj55g0zO92Hpz+cM49LQA@mail.gmail.com> <CA+khW7hqX9fJd2G8-Kze9pMR4hUKV5ROxn1vKYy82+PCzDeCDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+khW7hqX9fJd2G8-Kze9pMR4hUKV5ROxn1vKYy82+PCzDeCDQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexei Starovoitov <alexei.starovoitov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Oleg Rombakh <olegrom-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Martin Lau <kafai-b10kYP2dOMg@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org



On June 29, 2020 6:13:20 PM GMT-03:00, Hao Luo <haoluo@google=2Ecom> wrote=
:
>Hi Andrii,
>
>Thanks for taking a look! I can post a v5 based on your thorough and
>detailed analysis this week=2E Some of my other work on sched consumed
>most of my bandwidth last week and I very appreciate your help! I
>apologize if it is felt I dropped this patch and will follow up within
>this week=2E

I'll also try and look at this tomorrow=2E

- Arnaldo

>
>Hao
>
>On Mon, Jun 29, 2020 at 1:26 PM Andrii Nakryiko
><andrii=2Enakryiko@gmail=2Ecom> wrote:
>>
>> On Fri, Jun 19, 2020 at 1:30 PM Hao Luo <haoluo@google=2Ecom> wrote:
>> >
>> > Hi, Andrii,
>> >
>> > I agree that we'd better put a hold on this patch until we find out
>> > the reason for the 'unconventional' symbols=2E I'll _try_ to figure
>it
>> > out, but not able to fully commit my time on this patch=2E I thought
>I'd
>> > better publish this patch as the DATASEC and VARs are generated
>> > correctly in format, so that anyone can use it to generate the
>vmlinux
>> > and continue the development on libbpf based on your ksym work
>(i=2Ee=2E
>> > typed ksyms)=2E
>> >
>>
>> Hey Hao,
>>
>> It's a pity that you are willing to drop this while being half-step
>> away from doing this properly=2E See my other reply, there is something
>> fishy with variable__name() and variable__type_size() and how it
>> calculates/caches values=2E ELF itself has all the data (based ELF
>> symbol data) and it seems to be correct=2E And I was correct to be
>> suspicious about just filtering out such variables, because in my
>case
>> you'd filter out a good chunk of variables for no good reason: 74
>> variables, which is a 26% of all per-CPU variables in my kernel=2E
>>
>> It's up to you, of course, but it would be nice to fix it up (just
>> switching to elf_sym__size() and elf_sym__name() would be fine, you'd
>> just need to make sure to add elf_sym_name() result into a string
>> buffer; unless Arnaldo has some better alternatives) and publish
>> complete v5, that would get merged into pahole=2E After that, building
>> on my =2Eksym work in libbpf should get you to what you need from BPF
>> pretty quickly (plus some kernel-side logic to recognize these
>per-CPU
>> variables)=2E
>>
>> > Hao
>> >
>> > On Fri, Jun 19, 2020 at 12:58 PM Andrii Nakryiko
>> > <andrii=2Enakryiko@gmail=2Ecom> wrote:
>> > >
>> > > On Thu, Jun 18, 2020 at 12:49 AM Hao Luo <haoluo@google=2Ecom>
>wrote:
>> > > >
>> > > > On SMP systems, the global percpu variables are placed in a
>special
>> > > > '=2Edata=2E=2Epercpu' section, which is stored in a segment whose
>initial
>> > > > address is set to 0, the addresses of per-CPU variables are
>relative
>> > > > positive addresses [1]=2E
>> > > >
>> > > > This patch extracts these variables from vmlinux and places
>them with
>> > > > their type information in BTF=2E More specifically, when BTF is
>encoded,
>> > > > we find the index of the '=2Edata=2E=2Epercpu' section and then
>traverse
>> > > > the symbol table to find those global objects which are in this
>section=2E
>> > > > For each of these objects, we push a BTF_KIND_VAR into the
>types buffer,
>> > > > and a BTF_VAR_SECINFO into another buffer, percpu_secinfo=2E When
>all the
>> > > > CUs have finished processing, we push a BTF_KIND_DATASEC into
>the
>> > > > btfe->types buffer, followed by the percpu_secinfo's content=2E
>> > > >
>> > > > In a v5=2E7-rc7 linux kernel, I was able to extract 291 such
>variables=2E
>> > > > The build time overhead is small and the space overhead is also
>small=2E
>> > > >
>> > > > Testing:
>> > > >
>> > > > - vmlinux size has increased by ~12kb=2E
>> > > >   Before:
>> > > >    $ readelf -SW vmlinux | grep BTF
>> > > >    [25] =2EBTF              PROGBITS        ffffffff821a905c
>13a905c 2d2bf8 00
>> > > >   After:
>> > > >    $ pahole -J vmlinux
>> > > >    $ readelf -SW vmlinux  | grep BTF
>> > > >    [25] =2EBTF              PROGBITS        ffffffff821a905c
>13a905c 2d5bca 00
>> > > >
>> > > > - Common global percpu VARs and DATASEC are found in BTF
>section=2E
>> > > >   $ bpftool btf dump file vmlinux | grep runqueues
>> > > >   [14098] VAR 'runqueues' type_id=3D13725, linkage=3Dglobal-alloc
>> > > >
>> > > >   $ bpftool btf dump file vmlinux | grep 'cpu_stopper'
>> > > >   [17592] STRUCT 'cpu_stopper' size=3D72 vlen=3D5
>> > > >   [17612] VAR 'cpu_stopper' type_id=3D17592, linkage=3Dstatic
>> > > >
>> > > >   $ bpftool btf dump file vmlinux | grep ' DATASEC '
>> > > >   [63652] DATASEC '=2Edata=2E=2Epercpu' size=3D0 vlen=3D294
>> > >
>> > > probably forgot to update the example, I'd imagine size wouldn't
>be 0 anymore?
>> > >
>>
>> [=2E=2E=2E]

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
