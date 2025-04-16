Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5D239595
	for <dwarves@vger.kernel.org>; Wed, 16 Apr 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800025; cv=none; b=Jdz9SOmqrc9PQh3pKbCU2U0sY4rOorvEWD2NGrCcZf29JF6eHXuOKJ8JYBXoJEgbp1Ocm/B7rpw8Hgtrx+YvLVleAEaGsPkXP1OKw8IG2Vz4boNocVHamXTM6jXqSBrgWtjZncQPp6zHTW4iEyqt8G6vyu9IF2X1wfcnA5UM9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800025; c=relaxed/simple;
	bh=KhURPgbRhsHWZOrEmFZdb0BaENGVc1IcK3QUm7YB1Q0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fT377kcCDJQBCKpYHu//exCloG9r/9hSlOYbIPu73MW3Gq/tlQv/QoVL9qoA7R8Ox+cermMNlkpPniZkyWALOdbl3rQArxHgyV/uqQLj18vYInNbtD/9jmHV914O1QEuY2sQg2nUmpu7NR4+nugmOEo5MCILqfpCaD4bU/bTha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.43] (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 79AA761E647A8;
	Wed, 16 Apr 2025 12:39:57 +0200 (CEST)
Message-ID: <9fb4f7ba-0de1-4f75-9bd2-66212ca8cd86@molgen.mpg.de>
Date: Wed, 16 Apr 2025 12:39:57 +0200
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dwarves@vger.kernel.org
Cc: Ben Olson <matthew.olson@intel.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 it+dwarves~vger.kernel.org@molgen.mpg.de
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Despite `-DCMAKE_INSTALL_LIBDIR=/usr/lib` libraries installed to
 `/usr/usr/lib`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Ben, +Alan]

Dear pahole folks,


To build pahole 1.30, I configure it with CMake 3.25.2

     cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=/usr/lib 
-DCMAKE_COLOR_MAKEFILE=OFF -DCMAKE_VERBOSE_MAKEFILE=ON 
-DCMAKE_BUILD_TYPE=RelWithDebInfo -DLIBBPF_EMBEDDED=OFF 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/source

and then build it with

     make -j300

and install it with

     make -j300 install 
DESTDIR=/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image

Unfortunately, the shared libraries are installed int `/usr` as the 
prefix seems to be prepended despite LIBDIR containing the full path:

     -- Installing: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves.so.1.0.0
     -- Installing: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves.so.1
     -- Installing: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves.so
     -- Up-to-date: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves.so.1.0.0
     -- Up-to-date: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves.so.1
     -- Up-to-date: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves.so
     -- Installing: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves_emit.so.1.0.0
     -- Installing: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves_emit.so.1
     -- Set runtime path of 
"/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves_emit.so.1.0.0" 
to ""
     -- Installing: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves_emit.so
     -- Installing: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves_reorganize.so.1.0.0
     -- Installing: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves_reorganize.so.1
     -- Set runtime path of 
"/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves_reorganize.so.1.0.0" 
to ""
     -- Installing: 
/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/usr/lib/libdwarves_reorganize.so

Looking quickly into `CMakeLists.txt` there is

     […]
     # Use the standard library installation directory
     include(GNUInstallDirs)
     set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
     […]
     if (NOT DEFINED LIB_INSTALL_DIR)
         set(LIB_INSTALL_DIR 
"${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
     endif()
     […]
     install(TARGETS codiff ctracer dtagnames pahole pdwtags
                 pfunct pglobal prefcnt scncopy syscse RUNTIME DESTINATION
                     ${CMAKE_INSTALL_PREFIX}/bin)
     install(TARGETS dwarves LIBRARY DESTINATION ${LIB_INSTALL_DIR} 
ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
     install(TARGETS dwarves dwarves_emit dwarves_reorganize LIBRARY 
DESTINATION ${LIB_INSTALL_DIR} ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
     install(FILES dwarves.h dwarves_emit.h dwarves_reorganize.h
                   dutil.h gobuffer.h list.h rbtree.h
                   btf_encoder.h config.h ctf.h
                   elfcreator.h elf_symtab.h hash.h libctf.h
             DESTINATION ${CMAKE_INSTALL_PREFIX}/include/dwarves/)
     install(FILES man-pages/pahole.1 DESTINATION 
${CMAKE_INSTALL_PREFIX}/share/man/man1/)

Passing `-DLIB_INSTALL_DIR=/usr/lib` to `cmake` works around this. It 
looks like it was supposed to be fixed by Ben’s commit a2abd9482162 
(CMakeList.txt: Respect CMAKE_INSTALL_LIBDIR) [1], but it doesn’t work 
for me.


Kind regards,

Paul


[1]: https://lore.kernel.org/r/Z0TtnS-0iXq1Bc-0@bolson-desk
