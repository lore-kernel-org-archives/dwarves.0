Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LONGWORDS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD56C47094
	for <linux-dwarves@archiver.kernel.org>; Thu, 10 Jun 2021 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DB7601FD
	for <linux-dwarves@archiver.kernel.org>; Thu, 10 Jun 2021 17:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJRdd (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhFJRdc (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 10 Jun 2021 13:33:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E15C61285;
        Thu, 10 Jun 2021 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623346296;
        bh=Gy5dJqguFkTMhV1XMAiNKbnLz2COq7I2yZs/Xpl47zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2/1+6IHXUAw6RQ+YK3DzPzm91zs4VJ9NRL+lZQ3Zt3zBvglsUxSg/uBhMUhDNP9d
         PjrWRg1ov4oyg8xST7/2k/hJdIHbEjrP3Q16wD6Z27IHyQpoXrveWZbJw9aVUch23S
         QLHnd9lSohfk+9KblhhIGUQreLOUrAbutq0fUJyK4jOQy//lD6pl+/ECRHWsBs9eys
         VVqfjFQQ74CkjONCgkQkcjY9bLAmQ4wNcxJ1mTrZ9IF6tSy0xl8TpFq7W9/MNsYRoQ
         5hM2foDBpraTYlaR9CoC7c2fZFDFgryvqVw5SJJHW+Xr/Xn2s6TJTR1KQQXZUz/Nn0
         kZ0PRaoUubMpg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E8E740B1A; Thu, 10 Jun 2021 14:31:33 -0300 (-03)
Date:   Thu, 10 Jun 2021 14:31:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Cc:     dwarves@vger.kernel.org, qais.yousef@arm.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib
 creation
Message-ID: <YMJMdQvCWHd5J0M1@kernel.org>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
 <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Jun 08, 2021 at 12:50:13AM +0530, Deepak Kumar Mishra escreveu:
> CMakeLists.txt does not allow creation of static library and link applications
> accordingly.
> 
> Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_LIBS
> If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets it to ON.
> 
> Ex:
> cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
> cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..

Had to do some fixups due to a previous patch touching CMakeLists.txt,
please check below.

I tested it and added some performance notes.

Thanks!

- Arnaldo

commit aa2027708659f172780f85698f14303c7de6a1d2
Author: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Date:   Tue Jun 8 00:50:13 2021 +0530

    CMakeLists.txt: Enable SHARED and STATIC lib creation
    
    CMakeLists.txt does not allow creation of static library and link applications
    accordingly.
    
    Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_LIBS
    If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets it to ON.
    
    Ex:
    
      $ cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
      $ cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..
    
    Committer testing:
    
    I had to fixup it a bit due to changes related to allowing building with
    libbpf-devel, test resuts:
    
    With the default, i.e. creating libdwarves.so and using it:
    
      ⬢[acme@toolbox pahole]$ rm -f vmlinux.btf ; perf stat -r5 pahole -j vmlinux.btf vmlinux && perf stat -r5 btfdiff vmlinux vmlinux.btf
    
       Performance counter stats for 'pahole -j vmlinux.btf vmlinux' (5 runs):
    
                8,612.69 msec task-clock:u              #    1.014 CPUs utilized            ( +-  0.68% )
                       0      context-switches:u        #    0.000 /sec
                       0      cpu-migrations:u          #    0.000 /sec
                 775,702      page-faults:u             #   91.330 K/sec                    ( +-  0.00% )
          33,720,048,514      cycles:u                  #    3.970 GHz                      ( +-  0.38% )  (83.33%)
             689,752,139      stalled-cycles-frontend:u #    2.05% frontend cycles idle     ( +-  2.57% )  (83.33%)
           5,070,723,369      stalled-cycles-backend:u  #   15.04% backend cycles idle      ( +-  1.20% )  (83.34%)
          77,270,640,084      instructions:u            #    2.29  insn per cycle
                                                        #    0.07  stalled cycles per insn  ( +-  0.01% )  (83.34%)
          18,164,028,242      branches:u                #    2.139 G/sec                    ( +-  0.04% )  (83.33%)
             150,194,338      branch-misses:u           #    0.83% of all branches          ( +-  0.17% )  (83.32%)
    
                  8.4979 +- 0.0590 seconds time elapsed  ( +-  0.69% )
    
       Performance counter stats for 'btfdiff vmlinux vmlinux.btf' (5 runs):
    
                7,001.79 msec task-clock:u              #    1.006 CPUs utilized            ( +-  1.02% )
                       0      context-switches:u        #    0.000 /sec
                       0      cpu-migrations:u          #    0.000 /sec
                 727,980      page-faults:u             #  104.736 K/sec                    ( +-  0.00% )
          26,912,307,448      cycles:u                  #    3.872 GHz                      ( +-  0.31% )  (83.33%)
             509,467,882      stalled-cycles-frontend:u #    1.90% frontend cycles idle     ( +-  2.44% )  (83.33%)
           3,602,777,263      stalled-cycles-backend:u  #   13.43% backend cycles idle      ( +-  1.34% )  (83.32%)
          66,192,815,701      instructions:u            #    2.47  insn per cycle
                                                        #    0.06  stalled cycles per insn  ( +-  0.01% )  (83.35%)
          15,753,663,095      branches:u                #    2.267 G/sec                    ( +-  0.02% )  (83.35%)
              98,345,696      branch-misses:u           #    0.62% of all branches          ( +-  0.14% )  (83.34%)
    
                  6.9586 +- 0.0720 seconds time elapsed  ( +-  1.03% )
    
      ⬢[acme@toolbox pahole]$
    
    Then building with:
    
      ⬢[acme@toolbox pahole]$ rm -rf build ; mkdir build ; cd build ; cmake -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release .. ; cd .. ; make -C build
      ⬢[acme@toolbox pahole]$ ldd build/pahole
            linux-vdso.so.1 (0x00007ffff0172000)
            libdw.so.1 => /lib64/libdw.so.1 (0x00007fdd3905d000)
            libelf.so.1 => /lib64/libelf.so.1 (0x00007fdd39042000)
            libz.so.1 => /lib64/libz.so.1 (0x00007fdd39028000)
            libc.so.6 => /lib64/libc.so.6 (0x00007fdd38e59000)
            libdl.so.2 => /lib64/libdl.so.2 (0x00007fdd38e52000)
            libzstd.so.1 => /lib64/libzstd.so.1 (0x00007fdd38d5c000)
            liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fdd38d2e000)
            libbz2.so.1 => /lib64/libbz2.so.1 (0x00007fdd38d1b000)
            libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fdd38cfa000)
            /lib64/ld-linux-x86-64.so.2 (0x00007fdd390ff000)
      ⬢[acme@toolbox pahole]$
    
    We get some performance improvement:
    
    - First is encoding detached BTF, i.e. read DWARF, generate BTF.
    - Second is about loading both DWARF and BTF, producing output for both, that must match.
    
      ⬢[acme@toolbox pahole]$ rm -f vmlinux.btf ; perf stat -r5 pahole -j vmlinux.btf vmlinux && perf stat -r5 btfdiff vmlinux vmlinux.btf
    
       Performance counter stats for 'pahole -j vmlinux.btf vmlinux' (5 runs):
    
                8,566.34 msec task-clock:u              #    1.025 CPUs utilized            ( +-  0.85% )
                       0      context-switches:u        #    0.000 /sec
                       0      cpu-migrations:u          #    0.000 /sec
                 775,685      page-faults:u             #   92.865 K/sec                    ( +-  0.00% )
          33,333,991,512      cycles:u                  #    3.991 GHz                      ( +-  0.23% )  (83.34%)
             799,187,919      stalled-cycles-frontend:u #    2.42% frontend cycles idle     ( +-  1.95% )  (83.33%)
           5,157,722,792      stalled-cycles-backend:u  #   15.61% backend cycles idle      ( +-  1.25% )  (83.33%)
          76,273,972,066      instructions:u            #    2.31  insn per cycle
                                                        #    0.07  stalled cycles per insn  ( +-  0.03% )  (83.33%)
          17,843,388,470      branches:u                #    2.136 G/sec                    ( +-  0.05% )  (83.33%)
             150,507,690      branch-misses:u           #    0.84% of all branches          ( +-  0.46% )  (83.33%)
    
                  8.3561 +- 0.0729 seconds time elapsed  ( +-  0.87% )
    
       Performance counter stats for 'btfdiff vmlinux vmlinux.btf' (5 runs):
    
                6,685.39 msec task-clock:u              #    0.986 CPUs utilized            ( +-  0.54% )
                       0      context-switches:u        #    0.000 /sec
                       0      cpu-migrations:u          #    0.000 /sec
                 727,931      page-faults:u             #  107.475 K/sec                    ( +-  0.00% )
          26,149,371,139      cycles:u                  #    3.861 GHz                      ( +-  0.15% )  (83.36%)
             525,918,808      stalled-cycles-frontend:u #    2.00% frontend cycles idle     ( +-  2.96% )  (83.33%)
           3,547,589,546      stalled-cycles-backend:u  #   13.51% backend cycles idle      ( +-  1.28% )  (83.35%)
          65,389,507,702      instructions:u            #    2.49  insn per cycle
                                                        #    0.06  stalled cycles per insn  ( +-  0.03% )  (83.29%)
          15,553,175,605      branches:u                #    2.296 G/sec                    ( +-  0.02% )  (83.34%)
              97,812,971      branch-misses:u           #    0.63% of all branches          ( +-  0.23% )  (83.34%)
    
                  6.7784 +- 0.0359 seconds time elapsed  ( +-  0.53% )
    
      ⬢[acme@toolbox pahole]$
    
    Signed-off-by: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Qais Yousef <qais.yousef@arm.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/CMakeLists.txt b/CMakeLists.txt
index df16b8ec3031f3e6..669ea59167c7ef65 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -47,6 +47,11 @@ endif (NOT CMAKE_BUILD_TYPE)
 set(CMAKE_C_FLAGS_DEBUG "-Wall -Werror -ggdb -O0")
 set(CMAKE_C_FLAGS_RELEASE "-Wall -O2")
 
+if (NOT DEFINED BUILD_SHARED_LIBS)
+	set (BUILD_SHARED_LIBS ON)
+	message(STATUS "Setting BUILD_SHARED_LIBS = ${BUILD_SHARED_LIBS}")
+endif (NOT DEFINED BUILD_SHARED_LIBS)
+
 # Just for grepping, DWARVES_VERSION isn't used anywhere anymore
 # add_definitions(-D_GNU_SOURCE -DDWARVES_VERSION="v1.21")
 add_definitions(-D_GNU_SOURCE -DDWARVES_MAJOR_VERSION=1)
@@ -111,18 +116,18 @@ set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer.c strings.c
 if (NOT LIBBPF_FOUND)
 	list(APPEND dwarves_LIB_SRCS $<TARGET_OBJECTS:bpf>)
 endif()
-add_library(dwarves SHARED ${dwarves_LIB_SRCS})
+add_library(dwarves ${dwarves_LIB_SRCS})
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
 set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
 target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES})
 
 set(dwarves_emit_LIB_SRCS dwarves_emit.c)
-add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
+add_library(dwarves_emit ${dwarves_emit_LIB_SRCS})
 set_target_properties(dwarves_emit PROPERTIES VERSION 1.0.0 SOVERSION 1)
 target_link_libraries(dwarves_emit dwarves)
 
 set(dwarves_reorganize_LIB_SRCS dwarves_reorganize.c)
-add_library(dwarves_reorganize SHARED ${dwarves_reorganize_LIB_SRCS})
+add_library(dwarves_reorganize ${dwarves_reorganize_LIB_SRCS})
 set_target_properties(dwarves_reorganize PROPERTIES VERSION 1.0.0 SOVERSION 1)
 target_link_libraries(dwarves_reorganize dwarves)
 
@@ -169,8 +174,8 @@ target_link_libraries(syscse dwarves)
 install(TARGETS codiff ctracer dtagnames pahole pdwtags
 		pfunct pglobal prefcnt scncopy syscse RUNTIME DESTINATION
 		${CMAKE_INSTALL_PREFIX}/bin)
-install(TARGETS dwarves LIBRARY DESTINATION ${LIB_INSTALL_DIR})
-install(TARGETS dwarves dwarves_emit dwarves_reorganize LIBRARY DESTINATION ${LIB_INSTALL_DIR})
+install(TARGETS dwarves LIBRARY DESTINATION ${LIB_INSTALL_DIR} ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
+install(TARGETS dwarves dwarves_emit dwarves_reorganize LIBRARY DESTINATION ${LIB_INSTALL_DIR} ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
 install(FILES dwarves.h dwarves_emit.h dwarves_reorganize.h
 	      dutil.h gobuffer.h list.h rbtree.h pahole_strings.h
 	      btf_encoder.h config.h ctf_encoder.h ctf.h
