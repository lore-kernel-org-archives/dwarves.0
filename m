Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4240C433FE
	for <linux-dwarves@archiver.kernel.org>; Wed,  5 Oct 2022 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJESbb (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiJESb3 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 5 Oct 2022 14:31:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCAB7F117
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 11:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C7BFB81DE0
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 18:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B6C433D6;
        Wed,  5 Oct 2022 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664994681;
        bh=NKF90/itu0lmVh6vD7I9k52YZxVpocXZicBcq+9HoSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPS0mkFKqmLK0Sm2AdrQLybCYJdoYejm4Q9OO6Spajq0M+an2vITLA1DS1Y3GFOsu
         zbgup6x1240JZpYWDwxlH/2ymKdEDZY0XtTHjNbYp6h52iFPu30uVYMz5NaIm1QCYM
         REyqCaCH/6FMYqtF/y7iDpbq8m5BY+ir8FDFrGX7JX2fUlns3KwEh8S7CBL1AOdjIJ
         cfje+uF2fUGE6cpwfIxxMI4fMQFzmBgq0OQpTv7I8HVeCqr+B+YMOEsrO7W0YIfGpX
         p5WOKj3YHMZaZB6mzaRnbI0t6RWvNxebNE9g/k3/GZK+MzN6rXc6RnO2TkxAfjuoJf
         iGt8OIV1h2ZFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D1C94062C; Wed,  5 Oct 2022 15:31:19 -0300 (-03)
Date:   Wed, 5 Oct 2022 15:31:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bitweasil <bitweasil@cryptohaze.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: Ubuntu kernels and die__process: DW_TAG ... got INVALID!
Message-ID: <Yz3NdwxFYQkIAmCC@kernel.org>
References: <17a34291-e28c-b08d-cfec-d455c72c4c54@cryptohaze.com>
 <Yz12qzXbbGPzH2Bl@kernel.org>
 <202acb12-2e38-1ba1-500a-ae9827fecf61@cryptohaze.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202acb12-2e38-1ba1-500a-ae9827fecf61@cryptohaze.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Oct 05, 2022 at 10:59:10AM -0600, Bitweasil escreveu:
> 
> On 10/5/22 06:20, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 04, 2022 at 03:10:06PM -0600, Bitweasil escreveu:
> > > When trying to extract the layout of kernel structures that should exist on
> > > recent kernels from the Ubuntu debug kernel repo, I get the following error:
> > > 
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit or DW_TAG_partial_unit
> > > expected got INVALID!
> > > pahole: type 'mount' not found
> > > 
> > > As far as I can tell, 'struct mount' should still exist - and I can pull
> > > other structures out without trouble.  The issue starts appearing somewhere
> > > in the 5.15 kernel version - earlier kernels work exactly as expected and I
> > > can extract the full offsets.
> > > 
> > > https://elixir.bootlin.com/linux/v5.15.48/source/fs/mount.h indicates that
> > > 'struct mount' still exists in the source, and it remains present into the
> > > 6.0 kernel with no substantial changes. I can also produce the same response
> > > with some of the other structures in that file - mountpoint, mnt_namespace,
> > > and mnt_pcp all lead to the same error message.
> > > 
> > > I've tried building pahole from head (Oct 4, 2022, e819d737) without any
> > > changes to the behavior, and v1.21 and 1.24 both lead to the same results.
> > Are you sure? The error message should be this in 1.24:
> > 
> > because:
> > 
> >          if (tag == DW_TAG_skeleton_unit) {
> >                  static bool warned;
> > 
> >                  if (!warned) {
> >                          fprintf(stderr, "WARNING: DW_TAG_skeleton_unit used, please look for a .dwo file and use it instead.\n"
> >                                          "         A future version of pahole will support do this automagically.\n");
> >                          warned = true;
> >                  }
> >                  return 0; // so that other units can be processed
> >          }
> > 
> >          if (tag == DW_TAG_partial_unit) {
> >                  static bool warned;
> > 
> >                  if (!warned) {
> >                          fprintf(stderr, "WARNING: DW_TAG_partial_unit used, some types will not be considered!\n"
> >                                          "         Probably this was optimized using a tool like 'dwz'\n"
> >                                          "         A future version of pahole will support this.\n");
> >                          warned = true;
> >                  }
> >                  return 0; // so that other units can be processed
> >          }
> > 
> >          if (tag != DW_TAG_compile_unit && tag != DW_TAG_type_unit) {
> >                  fprintf(stderr, "%s: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got %s (0x%x)!\n",
> >                          __FUNCTION__, dwarf_tag_name(tag), tag);
> >                  return -EINVAL;
> >          }
> 
> Yes, I recognize the error text is slightly different in 1.24, but it was
> the same error with either version.
> 
> However, seeing that it worked for your system led to some experimentation,
> and I believe the issue is one of either libdw or libelf versions.  I did my
> initial testing on Ubuntu 20.04, which has libdw/libelf 0.176-1.1build1 -
> and building 1.24 and head from source fail on that.

Humm, does it?

I just tried building it on an ubuntu 20.04 container and it seems to
work:

root@0ed09bb9df94:~# cat /etc/os-release
NAME="Ubuntu"
VERSION="20.04.5 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.5 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
root@0ed09bb9df94:~# cd /tmp
root@0ed09bb9df94:/tmp# git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git
Cloning into 'pahole'...
remote: Enumerating objects: 11, done.
remote: Counting objects: 100% (11/11), done.
remote: Compressing objects: 100% (10/10), done.
remote: Total 8364 (delta 3), reused 0 (delta 0), pack-reused 8353
Receiving objects: 100% (8364/8364), 2.08 MiB | 1.53 MiB/s, done.
Resolving deltas: 100% (6025/6025), done.
root@0ed09bb9df94:/tmp# cd pahole/
root@0ed09bb9df94:/tmp/pahole# mkdir build
root@0ed09bb9df94:/tmp/pahole# cd build
root@0ed09bb9df94:/tmp/pahole/build# cmake ..
-- The C compiler identification is GNU 9.4.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Setting BUILD_SHARED_LIBS = ON
-- Checking availability of DWARF and ELF development libraries
-- Looking for dwfl_module_build_id in elf
-- Looking for dwfl_module_build_id in elf - found
-- Found dwarf.h header: /usr/include
-- Found elfutils/libdw.h header: /usr/include
-- Found libdw library: /usr/lib/x86_64-linux-gnu/libdw.so
-- Found libelf library: /usr/lib/x86_64-linux-gnu/libelf.so
-- Checking availability of DWARF and ELF development libraries - done
-- Found ZLIB: /usr/lib/x86_64-linux-gnu/libz.so (found version "1.2.11")
-- Checking availability of argp library
-- Assuming argp is in libc
-- Checking availability of argp library - done
-- Checking availability of obstack library
-- Assuming obstack is in libc
-- Checking availability of obstack library - done
-- Submodule update
Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered for path 'lib/bpf'
Cloning into '/tmp/pahole/lib/bpf'...
Submodule path 'lib/bpf': checked out '645500dd7d2d6b5bb76e4c0375d597d4f0c4814e'
-- Submodule update - done
-- Performing Test HAVE_REALLOCARRAY_SUPPORT
-- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
-- Configuring done
-- Generating done
-- Build files have been written to: /tmp/pahole/build
root@0ed09bb9df94:/tmp/pahole/build# cd ..
root@0ed09bb9df94:/tmp/pahole# make -C build
make: Entering directory '/tmp/pahole/build'
make[1]: Entering directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target bpf
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
[  3%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.o
[  5%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
[  7%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
[  9%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/gen_loader.c.o
[ 10%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
[ 12%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
[ 14%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_errno.c.o
[ 16%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
[ 18%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/linker.c.o
[ 20%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
[ 21%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
[ 23%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/relo_core.c.o
[ 25%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
[ 27%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/str_error.c.o
[ 29%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/strset.c.o
[ 30%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/usdt.c.o
[ 32%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/xsk.c.o
make[2]: Leaving directory '/tmp/pahole/build'
[ 32%] Built target bpf
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target dwarves
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 34%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 38%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 40%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 41%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 43%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 45%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 47%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 49%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 50%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
[ 52%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
[ 54%] Linking C shared library libdwarves.so
make[2]: Leaving directory '/tmp/pahole/build'
[ 54%] Built target dwarves
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target syscse
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 56%] Building C object CMakeFiles/syscse.dir/syscse.c.o
[ 58%] Linking C executable syscse
make[2]: Leaving directory '/tmp/pahole/build'
[ 58%] Built target syscse
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target codiff
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 60%] Building C object CMakeFiles/codiff.dir/codiff.c.o
[ 61%] Linking C executable codiff
make[2]: Leaving directory '/tmp/pahole/build'
[ 61%] Built target codiff
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target dtagnames
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 63%] Building C object CMakeFiles/dtagnames.dir/dtagnames.c.o
[ 65%] Linking C executable dtagnames
make[2]: Leaving directory '/tmp/pahole/build'
[ 65%] Built target dtagnames
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target scncopy
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 67%] Building C object CMakeFiles/scncopy.dir/scncopy.c.o
[ 69%] Building C object CMakeFiles/scncopy.dir/elfcreator.c.o
[ 70%] Linking C executable scncopy
make[2]: Leaving directory '/tmp/pahole/build'
[ 70%] Built target scncopy
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target dwarves_emit
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 72%] Building C object CMakeFiles/dwarves_emit.dir/dwarves_emit.c.o
[ 74%] Linking C shared library libdwarves_emit.so
make[2]: Leaving directory '/tmp/pahole/build'
[ 74%] Built target dwarves_emit
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target dwarves_reorganize
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 76%] Building C object CMakeFiles/dwarves_reorganize.dir/dwarves_reorganize.c.o
[ 78%] Linking C shared library libdwarves_reorganize.so
make[2]: Leaving directory '/tmp/pahole/build'
[ 78%] Built target dwarves_reorganize
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target ctracer
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 80%] Building C object CMakeFiles/ctracer.dir/ctracer.c.o
[ 81%] Linking C executable ctracer
make[2]: Leaving directory '/tmp/pahole/build'
[ 81%] Built target ctracer
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target pdwtags
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 83%] Building C object CMakeFiles/pdwtags.dir/pdwtags.c.o
[ 85%] Linking C executable pdwtags
make[2]: Leaving directory '/tmp/pahole/build'
[ 85%] Built target pdwtags
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target pahole
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 87%] Building C object CMakeFiles/pahole.dir/pahole.c.o
[ 89%] Linking C executable pahole
make[2]: Leaving directory '/tmp/pahole/build'
[ 89%] Built target pahole
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target pfunct
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 90%] Building C object CMakeFiles/pfunct.dir/pfunct.c.o
[ 92%] Linking C executable pfunct
make[2]: Leaving directory '/tmp/pahole/build'
[ 92%] Built target pfunct
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target pglobal
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 94%] Building C object CMakeFiles/pglobal.dir/pglobal.c.o
[ 96%] Linking C executable pglobal
make[2]: Leaving directory '/tmp/pahole/build'
[ 96%] Built target pglobal
make[2]: Entering directory '/tmp/pahole/build'
Scanning dependencies of target prefcnt
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 98%] Building C object CMakeFiles/prefcnt.dir/prefcnt.c.o
[100%] Linking C executable prefcnt
make[2]: Leaving directory '/tmp/pahole/build'
[100%] Built target prefcnt
make[1]: Leaving directory '/tmp/pahole/build'
make: Leaving directory '/tmp/pahole/build'
root@0ed09bb9df94:/tmp/pahole# build/pahole --version
v1.24
root@0ed09bb9df94:/tmp/pahole# git log --oneline -5
e819d73 (HEAD -> master, origin/master, origin/HEAD) pahole: Add "btf" to the format-path option man page
f01e5f3 dwarf_loader: Support DW_TAG_label outside DW_TAG_lexblock
b841207 pahole: Allow --compile to work with DWARF in addition to with BTF
6fdb014 dwarves: support DW_TAG_atomic_type
d750714 (origin/nex) emit: Don't mark a enum with nr_members == 0 as printed, its just a fwd decl
root@0ed09bb9df94:/tmp/pahole#
root@0ed09bb9df94:/tmp/pahole# dpkg -l | egrep libdw\|elf     
ii  libdw-dev:amd64                    0.176-1.1build1                   amd64        libdw1 development libraries and header files
ii  libdw1:amd64                       0.176-1.1build1                   amd64        library that provides access to the DWARF debug information
ii  libelf-dev:amd64                   0.176-1.1build1                   amd64        libelf1 development libraries and header files
ii  libelf1:amd64                      0.176-1.1build1                   amd64        library to read and write ELF files
root@0ed09bb9df94:/tmp/pahole#

- Arnaldo
 
> If I add the "-F btf" flag, v1.21 on 20.04 is able to get the structure.

Cool.
 
> However, on Ubuntu 22.04, with libdw/libelf 0.186-1build1, I get the
> expected results without "-F btf", even with pahole v1.22.

Sure, there it manages to get it from DWARF, no need to get it from BTF,
albeit the later is much faster to process.
 
> This gives me several options that resolve the issue usefully - thank you
> for your prompt response and testing!

No problem, thanks for the report.
 
> -Bit
> 
> > But its strange, there are no units other than DW_TAG_compile_unit in
> > that vmlinux file:
> > 
> > ⬢[acme@toolbox boot]$ readelf -wi vmlinux-5.15.0-48-generic | grep 'DW_TAG_.*_unit' | grep -v DW_TAG_compile_unit
> > ⬢[acme@toolbox boot]$
> > > Steps to reproduce (warning, will take ~10GB - the unzipped kernel debug
> > > symbols are rather large):
> > > cd /tmp
> > > wget http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> > > ar x linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> > > tar -xf data.tar.xz
> > > cd usr/lib/debug/boot
> > > pahole -C mount vmlinux-5.15.0-48-generic
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit or DW_TAG_partial_unit
> > > expected got INVALID!
> > > pahole: type 'mount' not found
> > > Any suggestions on how to resolve this?  I'm not familiar enough with the
> > > various debug formats to know how to troubleshoot beyond this point right
> > > now.
> > Works for me:
> > 
> > ⬢[acme@toolbox pahole]$ wget http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> > --2022-10-05 09:11:56--  http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> > Resolving ddebs.ubuntu.com (ddebs.ubuntu.com)... 185.125.190.17, 91.189.91.48, 91.189.91.49, ...
> > Connecting to ddebs.ubuntu.com (ddebs.ubuntu.com)|185.125.190.17|:80... connected.
> > HTTP request sent, awaiting response... 200 OK
> > Length: 1055842672 (1007M) [application/vnd.debian.binary-package]
> > Saving to: ‘linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb’
> > 
> > linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.dde 100%[===================================================================================================================================================================>]   1007M  13.3MB/s    in 74s
> > 
> > 2022-10-05 09:13:11 (13.5 MB/s) - ‘linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb’ saved [1055842672/1055842672]
> > 
> > ⬢[acme@toolbox pahole]$ mkdir ubuntu-kernel
> > ⬢[acme@toolbox pahole]$ mv linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb ubuntu-kernel
> > ⬢[acme@toolbox pahole]$ cd ubuntu-kernel
> > ⬢[acme@toolbox ubuntu-kernel]$ ls -la
> > total 1031148
> > drwxr-xr-x. 1 acme acme        138 Oct  5 09:13 .
> > drwxrwxr-x. 1 acme acme       5074 Oct  5 09:13 ..
> > -rw-r--r--. 1 acme acme 1055842672 Aug 31 08:39 linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> > ⬢[acme@toolbox ubuntu-kernel]$ ar x linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> > ⬢[acme@toolbox ubuntu-kernel]$ ls -la
> > total 2062252
> > drwxr-xr-x. 1 acme acme        214 Oct  5 09:13 .
> > drwxrwxr-x. 1 acme acme       5074 Oct  5 09:13 ..
> > -rw-r--r--. 1 acme acme     155352 Oct  5 09:13 control.tar.xz
> > -rw-r--r--. 1 acme acme 1055687128 Oct  5 09:13 data.tar.xz
> > -rw-r--r--. 1 acme acme          4 Oct  5 09:13 debian-binary
> > -rw-r--r--. 1 acme acme 1055842672 Aug 31 08:39 linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> > ⬢[acme@toolbox ubuntu-kernel]$ tar -xf data.tar.xz
> > ⬢[acme@toolbox ubuntu-kernel]$ cd usr/lib/debug/boot
> > ⬢[acme@toolbox boot]$ ls -la
> > total 719136
> > drwxr-xr-x. 1 acme acme        50 Aug 26 06:12 .
> > drwxr-xr-x. 1 acme acme        14 Oct  5 09:13 ..
> > -rw-r--r--. 1 acme acme 736393784 Aug 26 06:12 vmlinux-5.15.0-48-generic
> > ⬢[acme@toolbox boot]$ ls -la
> > total 719136
> > drwxr-xr-x. 1 acme acme        50 Aug 26 06:12 .
> > drwxr-xr-x. 1 acme acme        14 Oct  5 09:13 ..
> > -rw-r--r--. 1 acme acme 736393784 Aug 26 06:12 vmlinux-5.15.0-48-generic
> > ⬢[acme@toolbox boot]$ pahole -C mount vmlinux-5.15.0-48-generic
> > struct mount {
> > 	struct hlist_node          mnt_hash;             /*     0    16 */
> > 	struct mount *             mnt_parent;           /*    16     8 */
> > 	struct dentry *            mnt_mountpoint;       /*    24     8 */
> > 	struct vfsmount            mnt;                  /*    32    32 */
> > 	/* --- cacheline 1 boundary (64 bytes) --- */
> > 	union {
> > 		struct callback_head mnt_rcu __attribute__((__aligned__(8))); /*    64    16 */
> > 		struct llist_node  mnt_llist;            /*    64     8 */
> > 	} __attribute__((__aligned__(8)));               /*    64    16 */
> > 	struct mnt_pcp *           mnt_pcp;              /*    80     8 */
> > 	struct list_head           mnt_mounts;           /*    88    16 */
> > 	struct list_head           mnt_child;            /*   104    16 */
> > 	struct list_head           mnt_instance;         /*   120    16 */
> > 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> > 	const char  *              mnt_devname;          /*   136     8 */
> > 	struct list_head           mnt_list;             /*   144    16 */
> > 	struct list_head           mnt_expire;           /*   160    16 */
> > 	struct list_head           mnt_share;            /*   176    16 */
> > 	/* --- cacheline 3 boundary (192 bytes) --- */
> > 	struct list_head           mnt_slave_list;       /*   192    16 */
> > 	struct list_head           mnt_slave;            /*   208    16 */
> > 	struct mount *             mnt_master;           /*   224     8 */
> > 	struct mnt_namespace *     mnt_ns;               /*   232     8 */
> > 	struct mountpoint *        mnt_mp;               /*   240     8 */
> > 	union {
> > 		struct hlist_node  mnt_mp_list;          /*   248    16 */
> > 		struct hlist_node  mnt_umount;           /*   248    16 */
> > 	};                                               /*   248    16 */
> > 	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
> > 	struct list_head           mnt_umounting;        /*   264    16 */
> > 	struct fsnotify_mark_connector * mnt_fsnotify_marks; /*   280     8 */
> > 	__u32                      mnt_fsnotify_mask;    /*   288     4 */
> > 	int                        mnt_id;               /*   292     4 */
> > 	int                        mnt_group_id;         /*   296     4 */
> > 	int                        mnt_expiry_mark;      /*   300     4 */
> > 	struct hlist_head          mnt_pins;             /*   304     8 */
> > 	struct hlist_head          mnt_stuck_children;   /*   312     8 */
> > 
> > 	/* size: 320, cachelines: 5, members: 27 */
> > 	/* forced alignments: 1 */
> > } __attribute__((__aligned__(8)));
> > 
> > ⬢[acme@toolbox boot]$ pahole --version
> > v1.24
> > ⬢[acme@toolbox boot]$
> > 
> > And it even has BTF info, which makes processing much faster but without
> > some attributes:
> > 
> > ⬢[acme@toolbox boot]$ readelf -SW vmlinux-5.15.0-48-generic | grep -i btf
> >    [28] .BTF              PROGBITS        ffffffff8279d1e0 199d1e0 4ef6b2 00   A  0   0  1
> >    [29] .BTF_ids          PROGBITS        ffffffff82c8c894 1e8c894 0005e8 00   A  0   0  1
> > ⬢[acme@toolbox boot]$
> > 
> > ⬢[acme@toolbox boot]$ pahole -F btf -C mount vmlinux-5.15.0-48-generic
> > struct mount {
> > 	struct hlist_node          mnt_hash;             /*     0    16 */
> > 	struct mount *             mnt_parent;           /*    16     8 */
> > 	struct dentry *            mnt_mountpoint;       /*    24     8 */
> > 	struct vfsmount            mnt;                  /*    32    32 */
> > 	/* --- cacheline 1 boundary (64 bytes) --- */
> > 	union {
> > 		struct callback_head mnt_rcu;            /*    64    16 */
> > 		struct llist_node  mnt_llist;            /*    64     8 */
> > 	};                                               /*    64    16 */
> > 	struct mnt_pcp *           mnt_pcp;              /*    80     8 */
> > 	struct list_head           mnt_mounts;           /*    88    16 */
> > 	struct list_head           mnt_child;            /*   104    16 */
> > 	struct list_head           mnt_instance;         /*   120    16 */
> > 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> > 	const char  *              mnt_devname;          /*   136     8 */
> > 	struct list_head           mnt_list;             /*   144    16 */
> > 	struct list_head           mnt_expire;           /*   160    16 */
> > 	struct list_head           mnt_share;            /*   176    16 */
> > 	/* --- cacheline 3 boundary (192 bytes) --- */
> > 	struct list_head           mnt_slave_list;       /*   192    16 */
> > 	struct list_head           mnt_slave;            /*   208    16 */
> > 	struct mount *             mnt_master;           /*   224     8 */
> > 	struct mnt_namespace *     mnt_ns;               /*   232     8 */
> > 	struct mountpoint *        mnt_mp;               /*   240     8 */
> > 	union {
> > 		struct hlist_node  mnt_mp_list;          /*   248    16 */
> > 		struct hlist_node  mnt_umount;           /*   248    16 */
> > 	};                                               /*   248    16 */
> > 	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
> > 	struct list_head           mnt_umounting;        /*   264    16 */
> > 	struct fsnotify_mark_connector * mnt_fsnotify_marks; /*   280     8 */
> > 	__u32                      mnt_fsnotify_mask;    /*   288     4 */
> > 	int                        mnt_id;               /*   292     4 */
> > 	int                        mnt_group_id;         /*   296     4 */
> > 	int                        mnt_expiry_mark;      /*   300     4 */
> > 	struct hlist_head          mnt_pins;             /*   304     8 */
> > 	struct hlist_head          mnt_stuck_children;   /*   312     8 */
> > 
> > 	/* size: 320, cachelines: 5, members: 27 */
> > };
> > 
> > ⬢[acme@toolbox boot]$

-- 

- Arnaldo
