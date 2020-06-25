From: Lorenz Bauer <lmb-lDpJ742SOEtZroRs9YW3xA@public.gmane.org>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
Date: Thu, 25 Jun 2020 10:25:08 +0100
Message-ID: <CACAyw98ojwGjQm+Xk+_-B8Ah-hEt-Tgv_LQ1BdH4yBLYgVwpiA@mail.gmail.com>
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <CAEf4BzbSc-wykq1_62CQwtszO+76rkudz_B=GkzE6ZheMUAusw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEf4BzbSc-wykq1_62CQwtszO+76rkudz_B=GkzE6ZheMUAusw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: bpf <bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-team <kernel-team-lDpJ742SOEtZroRs9YW3xA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

On Wed, 24 Jun 2020 at 18:41, Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On Wed, Jun 24, 2020 at 4:07 AM Lorenz Bauer <lmb-lDpJ742SOEtZroRs9YW3xA@public.gmane.org> wrote:
> >
> > Hi,
> >
> > If pahole -J is used on an ELF that has BTF info from clang, it
> > produces an invalid
> > output. This is because pahole rewrites the .BTF section (which
> > includes a new string
> > table) but it doesn't touch .BTF.ext at all.
>
> Why do you run `pahole -J` on BPF .o file? Clang already generates
> .BTF (and .BTF.ext, of course) for you.

You're missing the point. The kernel build system does it. Try the following:

* Get the v4.19 sources
* Make sure that clang --version is 10
* Make sure you have pahole (I used v1.17)
* Build selftests

The resulting object files will have bogus .BTF.ext sections due the
bug I have described. Does it make sense to run pahole -J on these?
No, but it still happens.

I think it's reasonable to expect to get valid BPF ELFs out of this process.

>
> pahole -J is supposed to be used for vmlinux, not for clang-compiled
> -target BPF object files.
>
> >
> > To demonstrate, on a recent check out of bpf-next:
> >     $ cp connect4_prog.o connect4_pahole.o
> >     $ pahole -J connect4_pahole.o
> >     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> > --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
> >     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> > .BTF.ext=btf-ext.bin connect4_prog.o
> >     $ sha1sum *.bin
> >     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
> >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
> >     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
> >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
> >
> > This problem crops up when compiling old kernels like 4.19 which have
> > an extra pahole
> > build step with clang-10.
>
> I was under impression that clang generates .BTF and .BTF.ext only for
> -target BPF. In this case, kernel is compiled for "real" target arch,
> so there shouldn't be .BTF.ext in the first place? If that's not the
> case, then I guess it's a bug in Clang.

connect4_prog.o is BPF:

$ readelf -h connect4_prog.o | grep BPF
  Machine:                           Linux BPF

Maybe I misunderstand what you're trying to say.

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
