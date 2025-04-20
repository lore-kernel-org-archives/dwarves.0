Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC3258A
	for <dwarves@vger.kernel.org>; Sun, 20 Apr 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745131439; cv=none; b=UEsFkJq+Yn6lAWmnuUvRpbjqrmAqSNh5wOKqhl4T6CTIAMdPHh5/e0/i4I5PBsr2zPMk7qUwdoqWdHmQLQ6AtU+tFh6WGYnVNDoqZ4qDnQk0kZT6xSRowX73epS/l/wm/tf53qDdAkFQAB5txpQWzdr6hdc0CYxhE4EdaNi4IHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745131439; c=relaxed/simple;
	bh=WtIq5WYaSqVZsei48eeO4dMLmizL39eRLX303y98Mc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bjk99gyh478KQoujfAxWFn8KjGkDS0tSbH4Nyq7fqbY8W0MvengLRIeF2DiKuwmBA4sjV8i2hiYB3G1ii/rWhURAe98O0s2/M0Ha+usGAjSE4P3xdm9Yo5u0jcKNRiAftIQL7eaMNhQE0bdraKhlbuZPPnbvofdzfcFUK9sQvIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.fritz.box (i538705F6.versanet.de [83.135.5.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 74EE761E6478F;
	Sun, 20 Apr 2025 08:43:12 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: dwarves@vger.kernel.org
Cc: Ben Olson <matthew.olson@intel.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Brandon Kammerdiener <brandon.kammerdiener@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] CMakeLists.txt: Remove custom `LIB_INSTALL_DIR` handling
Date: Sun, 20 Apr 2025 08:42:21 +0200
Message-ID: <20250420064220.81114-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is no need to explicitly set `LIB_INSTALL_DIR`, as CMake’s module
GNUInstallDirs sets it itself from `CMAKE_INSTALL_LIBDIR`, and takes
care of everything, so the line below is enough.

    cmake -DLIBBPF_EMBEDDED=OFF -DCMAKE_INSTALL_LIBDIR=lib ..

Note, it’s common to set it to a relative path, but absolute paths are
allowed too.

    cmake -DLIBBPF_EMBEDDED=OFF -DCMAKE_INSTALL_LIBDIR=/opt/usr/lib64 ..

From the [CMake documentation][1]:

> CMAKE_INSTALL_<dir>
>
> Destination for files of a given type. This value may be passed to the
> DESTINATION options of install() commands for the corresponding file type.
> It should be a path relative to the installation prefix so that it can be
> converted to an absolute path in a relocatable way.
>
> While absolute paths are allowed, they are not recommended as they do not
> work with the cmake --install command's --prefix option, or with the cpack
> installer generators. In particular, there is no need to make paths
> absolute by prepending CMAKE_INSTALL_PREFIX; this prefix is used by
> default if the DESTINATION is a relative path.

So, remove the custom handling from `CMakeLists.txt`. Also, update
`README` and mention the option.

[1]: https://cmake.org/cmake/help/v3.31/module/GNUInstallDirs.html

Link: https://lore.kernel.org/all/9fb4f7ba-0de1-4f75-9bd2-66212ca8cd86@molgen.mpg.de/
Fixes: a2abd9482162 ("CMakeList.txt: Respect CMAKE_INSTALL_LIBDIR")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 CMakeLists.txt | 5 -----
 README         | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index eb87300..844ab61 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -23,7 +23,6 @@ endif()
 
 # Use the standard library installation directory
 include(GNUInstallDirs)
-set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
 
 # where to look first for cmake modules,
 # before ${CMAKE_ROOT}/Modules/ is checked
@@ -75,10 +74,6 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
 	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
 endif()
 
-if (NOT DEFINED LIB_INSTALL_DIR)
-    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
-endif()
-
 # libbpf uses reallocarray, which is not available in all versions of glibc
 # libbpf's include/tools/libc_compat.h provides implementation, but needs
 # COMPACT_NEED_REALLOCARRAY to be set
diff --git a/README b/README
index a938266..fb92d68 100644
--- a/README
+++ b/README
@@ -18,6 +18,10 @@ cmake Options:
     Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
     when invoking cmake to specify another install location.
 
+  -DCMAKE_INSTALL_LIBDIR
+    Default is to install to lib or lib64, use -DCMAKE_INSTALL_LIBDIR=
+    when invoking cmake to specify another install location.
+
 You may need to update the libbpf git submodule:
 
 git submodule update --init --recursive
-- 
2.49.0

