From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
Date: Wed, 24 Jun 2020 14:23:50 -0300
Message-ID: <20200624172350.GB20203@kernel.org>
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <20200624160659.GA20203@kernel.org>
 <CACAyw9-zLLDJ4vXo7jGS_XoYsiiv4c5NmUCjCnAf0eZBXU3dVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACAyw9-zLLDJ4vXo7jGS_XoYsiiv4c5NmUCjCnAf0eZBXU3dVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenz Bauer <lmb-lDpJ742SOEtZroRs9YW3xA@public.gmane.org>
Cc: bpf <bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-team <kernel-team-lDpJ742SOEtZroRs9YW3xA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

Em Wed, Jun 24, 2020 at 05:22:59PM +0100, Lorenz Bauer escreveu:
> On Wed, 24 Jun 2020 at 17:07, Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >
> > Em Wed, Jun 24, 2020 at 12:05:50PM +0100, Lorenz Bauer escreveu:
> > > Hi,
> > >
> > > If pahole -J is used on an ELF that has BTF info from clang, it
> > > produces an invalid
> > > output. This is because pahole rewrites the .BTF section (which
> > > includes a new string
> > > table) but it doesn't touch .BTF.ext at all.
> >
> > > To demonstrate, on a recent check out of bpf-next:
> > >     $ cp connect4_prog.o connect4_pahole.o
> > >     $ pahole -J connect4_pahole.o
> > >     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> > > --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
> > >     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> > > .BTF.ext=btf-ext.bin connect4_prog.o
> > >     $ sha1sum *.bin
> > >     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
> > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
> > >     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
> > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
> > >
> > > This problem crops up when compiling old kernels like 4.19 which have
> > > an extra pahole
> > > build step with clang-10.

> > > I think a possible fix is to strip .BTF.ext if .BTF is rewritten.
> >
> > Agreed.

> > Longer term pahole needs to generate the .BTF.ext from DWARF, but then,
> > if clang is generating it already, why use pahole -J?
 
> Beats me, but then sometimes you don't have control over the workflow, see
> my v4.19 kernel example.
 
> > Does clang do deduplication for multi-object binaries?

> > Also its nice to see that the BTF generated ends up with the same
> > sha1sum, cool :-)
 
> Unfortunately it's the .BTF.ext section that has the same sha1, because
> pahole doesn't touch it ;(

My bad... I guess I saw what I wanted to see... ;-\

- Arnaldo
