Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D9CC433C1
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 11:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4AF61919
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 11:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhC3LGS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 30 Mar 2021 07:06:18 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33726 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhC3LGN (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 30 Mar 2021 07:06:13 -0400
Received: by mail-wr1-f53.google.com with SMTP id o16so15872275wrn.0
        for <dwarves@vger.kernel.org>; Tue, 30 Mar 2021 04:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=hLZKmJ3Zcs/w4mkkN/WE4ND53CKfEcgXjLablaQD+sE=;
        b=mPdzsO+gBZ/eCZ3hP8Fzu43DsmaL4F+XcEsvoC4i7vZA4lY9I6mH8Byak4zO6H/s7w
         8gqmbCuiYKW4l9HNgg6WtIras/38kPqUei6/8+624jUxPUTdGxc6ccbTtgLOJCcamc13
         2vHre/rDCe73hfNGzpPA2afoZ2lfJaND82pIXeW0YeB+m/u6mEykCMDvHdU+0vRcSZrp
         jF74QoF/FsuHcsGHq5rMHgQfQbWvAR9mU2OnZDFjy5TMj5fKV0pQgwY0SRgdKKADmheL
         klEFBfrfQwvl4OK42rsecqPEE3uYkbNdSykjTElYaZy01UbEoxNOYlcrfiFvTnvhNYyr
         qExg==
X-Gm-Message-State: AOAM530b9yP1Ff3vWULJOj1mwub9AxJvvSzULDMMJdYOl1ZCS0BpDWwd
        flkpr1Wg9Lax4S/X1Fesln8=
X-Google-Smtp-Source: ABdhPJw/dLaOtYpDvwZ4U6V1zxSbMl7WQvAFZXpJZp+jlsGzTKxilUXmqjtHQI8k2lgfWNTqe5nzXw==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr33588667wrd.132.1617102371899;
        Tue, 30 Mar 2021 04:06:11 -0700 (PDT)
Received: from localhost ([88.98.246.218])
        by smtp.gmail.com with ESMTPSA id j123sm3034672wmb.1.2021.03.30.04.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:06:11 -0700 (PDT)
Message-ID: <1ba2e8cdb496248b02fa31ddcccb06c1e4ca3cca.camel@debian.org>
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue, 30 Mar 2021 12:06:09 +0100
In-Reply-To: <8cefd2c1cf59c1618365a738677afcb2ab6acd01.camel@debian.org>
References: <YGKtSXsLg4HV7eHL@codewreck.org>
         <8cefd2c1cf59c1618365a738677afcb2ab6acd01.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-RkAJuVL9tp5MLgfnS4oZ"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-RkAJuVL9tp5MLgfnS4oZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-03-30 at 11:50 +0100, Luca Boccassi wrote:
> On Tue, 2021-03-30 at 13:47 +0900, Dominique Martinet wrote:
> > Hi,
> >=20
> > I see this commit has been reverted just before the 1.20 release in Feb=
:
> > ---
> > Revert "libbpf: allow to use packaged version"
> >=20
> > This reverts commit 82749180b23d3c9c060108bc290ae26507fc324e.
> >=20
> > Getting in the way of releasing 1.20, breaking the build of a dwarves
> > rpm when a libbpf package is installed in a fedora 33 system:
> >=20
> > In file included from /home/acme/rpmbuild/BUILD/dwarves-1.20/strings.c:=
7:
> > /home/acme/rpmbuild/BUILD/dwarves-1.20/pahole_strings.h:9:10: fatal err=
or: bpf/btf.h: No such file or directory
> >     9 | #include <bpf/btf.h>
> >       |          ^~~~~~~~~~~
> >=20
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >=20
> > I can understand reverting due to other pressure to get a release out
> > but most distros (including fedora) frown upon vendoring code so I thin=
k
> > it would be good to have back ultimately.
> >=20
> > Did you or someone else (Luca?) ever take the time to look at it?
> >=20
> > I don't see what would be so different with fedora to make this
> > unfixable, I'd be happy taking a look if nobody has so far.
> > Would you take the patch back in if I somehow fix rpmbuild with a libbp=
f
> > package installed on fedora33?
> >=20
> >=20
> > Thanks,
>=20
> Hi,
>=20
> I did not realise it was reverted (if I was pinged and I missed it:
> sorry about that) - what was the issue precisely? This has been used on
> Ubuntu and Debian for a few months now, no problems reported.
> Happy to have a look too if needed.

As far as I can see, on Fedora 33 the only CMake option used is '-
DCMAKE_BUILD_TYPE=3DRelease':

https://src.fedoraproject.org/rpms/dwarves/blob/f33/f/dwarves.spec

On my Debian system, with libbpf-dev installed and after re-instating
the patch on an up-to-date master branch of pahole.git, this builds
just fine:

$ git clone https://git.kernel.org/pub/scm/devel/pahole/pahole.git
Cloning into 'pahole'...
remote: Enumerating objects: 6367, done.
remote: Total 6367 (delta 0), reused 0 (delta 0), pack-reused 6367
Receiving objects: 100% (6367/6367), 1.59 MiB | 11.49 MiB/s, done.
Resolving deltas: 100% (4450/4450), done.
$ cd pahole/
$ git revert 7943374
Auto-merging pahole.c
Auto-merging libbtf.h
Auto-merging libbtf.c
Auto-merging btf_loader.c
Auto-merging btf_encoder.c
Auto-merging CMakeLists.txt
[master 44b9227] Revert "Revert "libbpf: allow to use packaged version""
 9 files changed, 41 insertions(+), 24 deletions(-)
 create mode 120000 lib/include/bpf
$ mkdir b
$ cd b
$ cmake .. -DCMAKE_BUILD_TYPE=3DRelease
-- The C compiler identification is GNU 8.3.0
-- Check for working C compiler: /usr/bin/ccache
-- Check for working C compiler: /usr/bin/ccache -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Checking availability of DWARF and ELF development libraries
-- Looking for dwfl_module_build_id in elf
-- Looking for dwfl_module_build_id in elf - found
-- Found dwarf.h header: /usr/include
-- Found elfutils/libdw.h header: /usr/include
-- Found libdw library: /usr/lib/x86_64-linux-gnu/libdw.so
-- Found libelf library: /usr/lib/x86_64-linux-gnu/libelf.so
-- Checking availability of DWARF and ELF development libraries - done
-- Found ZLIB: /usr/lib/x86_64-linux-gnu/libz.so (found version "1.2.11")=
=20
-- Submodule update
Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered for path =
'lib/bpf'
Cloning into '/home/bluca/git/pahole/lib/bpf'...
Submodule path 'lib/bpf': checked out '986962fade5dfa89c2890f3854eb040d2a64=
ab38'
-- Submodule update - done
-- Performing Test HAVE_REALLOCARRAY_SUPPORT
-- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
-- Configuring done
-- Generating done
-- Build files have been written to: /home/bluca/git/pahole/b
$ make -j5
Scanning dependencies of target bpf
[  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
[  5%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
[  5%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
[  7%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.o
[  9%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
[ 11%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
[ 13%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
[ 15%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_errno.c.o
[ 16%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
[ 18%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
[ 20%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/str_error.c.o
[ 22%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
[ 24%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/xsk.c.o
[ 24%] Built target bpf
Scanning dependencies of target dwarves
[ 28%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[ 28%] Building C object CMakeFiles/dwarves.dir/strings.c.o
[ 30%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 32%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 33%] Building C object CMakeFiles/dwarves.dir/ctf_encoder.c.o
[ 35%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 37%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 39%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 41%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 43%] Building C object CMakeFiles/dwarves.dir/libbtf.c.o
[ 47%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 47%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 49%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
[ 50%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
[ 52%] Linking C shared library libdwarves.so
[ 52%] Built target dwarves
Scanning dependencies of target pglobal
Scanning dependencies of target dwarves_emit
Scanning dependencies of target codiff
Scanning dependencies of target dwarves_reorganize
Scanning dependencies of target dtagnames
[ 54%] Building C object CMakeFiles/pglobal.dir/pglobal.c.o
[ 56%] Building C object CMakeFiles/dwarves_emit.dir/dwarves_emit.c.o
[ 58%] Building C object CMakeFiles/codiff.dir/codiff.c.o
[ 60%] Building C object CMakeFiles/dwarves_reorganize.dir/dwarves_reorgani=
ze.c.o
[ 62%] Building C object CMakeFiles/dtagnames.dir/dtagnames.c.o
[ 64%] Linking C executable pglobal
[ 66%] Linking C shared library libdwarves_emit.so
[ 67%] Linking C executable codiff
[ 69%] Linking C shared library libdwarves_reorganize.so
[ 71%] Linking C executable dtagnames
[ 71%] Built target pglobal
[ 71%] Built target codiff
[ 71%] Built target dtagnames
Scanning dependencies of target prefcnt
[ 71%] Built target dwarves_emit
Scanning dependencies of target scncopy
Scanning dependencies of target syscse
[ 71%] Built target dwarves_reorganize
[ 73%] Building C object CMakeFiles/prefcnt.dir/prefcnt.c.o
Scanning dependencies of target pdwtags
[ 75%] Building C object CMakeFiles/scncopy.dir/scncopy.c.o
[ 77%] Building C object CMakeFiles/syscse.dir/syscse.c.o
[ 79%] Building C object CMakeFiles/scncopy.dir/elfcreator.c.o
[ 81%] Linking C executable prefcnt
[ 83%] Building C object CMakeFiles/pdwtags.dir/pdwtags.c.o
Scanning dependencies of target ctracer
[ 86%] Linking C executable scncopy
[ 86%] Linking C executable syscse
[ 88%] Linking C executable pdwtags
[ 90%] Building C object CMakeFiles/ctracer.dir/ctracer.c.o
[ 92%] Linking C executable ctracer
[ 92%] Built target prefcnt
[ 92%] Built target syscse
[ 92%] Built target scncopy
Scanning dependencies of target pfunct
Scanning dependencies of target pahole
[ 92%] Built target pdwtags
[ 94%] Building C object CMakeFiles/pfunct.dir/pfunct.c.o
[ 96%] Building C object CMakeFiles/pahole.dir/pahole.c.o
[ 96%] Built target ctracer
[ 98%] Linking C executable pfunct
[100%] Linking C executable pahole
[100%] Built target pahole
[100%] Built target pfunct

Is there anything else/some other steps that I am missing?

--=20
Kind regards,
Luca Boccassi

--=-RkAJuVL9tp5MLgfnS4oZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmBjBiEACgkQKGv37813
JB4laRAArwAe4SU9/4cNrxeFuXjTUZnMTFt2AGbtePiNhYumnwafnj4bxRQJTRm/
k6WT6eLMsCU1iJ/cxBYGG6y6P6YMrRYWe3EOXSLCG6xluFqjqW4y7jXdgwifE7oJ
WuVq6SrLmQEplHgYjGTOQU7Av4qmVitXmh/knPM3bD54uqmd/QPwQiANneLjgxfe
6+yANI2kT8WYWB63fHB0NhcBVx4mdn+MS1DwHjfKH67UOoZICUDoRBl2h+dGurPD
yFv1MVUXlGD1EoJbqXCIDF8Zb8aS2TpzJXS+3OtoREnrK1vHi+0paEGT2usA3C8c
ulaZw3qFiwDjCbrFGjlg729fnWuHo2k2cSu7YM/B/WdalED5D/Aw6GkPbHrLaVvu
cR6GHIdjhfNlKuPgaElJ42ijLMEaX0R2lB4a0gTmMEdrfgDCcakvnfodfjdHTHaO
ck7T98M/3qOw00OXjk3E8YkFy3YWts7vdcBnYVvr5srt2ANbYeLhEJ3KE8BZ/I1g
hadh9+0u1wJQE5jMBG3UeipAH9zgsl4ipZ1YHy1mhdSDT1DcnmbJecY8wbHYfrS3
Dt6/x5vrUkayo7/NV5IIUGMpCkYkR+SXaOaveuugVYS6Coh1nbD4VGnvev8FlGeN
wR9YbexNol1hx3h0aYac62mVor/lJt97Nm8kyG4HtU6/ksOSXcI=
=lrca
-----END PGP SIGNATURE-----

--=-RkAJuVL9tp5MLgfnS4oZ--
