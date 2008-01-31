From: Felipe Kellermann <felipek-F9QBgdt/En2RpAAqCnN02g@public.gmane.org>
Subject: [PATCH] Fixes a FIXME relating to a missing elf (libdw) symbol check.
Date: Thu, 31 Jan 2008 20:34:40 -0200
Message-ID: <901b45bab1fabf9082744903cb68686d@socksarmor.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: multipart/mixed; boundary=Apple-Mail-1-173381414
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org


--Apple-Mail-1-173381414
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hello,

I was trying to build pahole using git HEAD using the latest Ubuntu 
(7.10) and noticied that there is a missing check of a symbol and a 
FIXME tag pointing that.  The attached patch adds a cmake configure 
(config.h) file and checks the symbol (dwfl_module_build_id).



--Apple-Mail-1-173381414
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="dwarves-dwfl_module_build_id-cmake-check.patch"
Content-Disposition: attachment;
	filename=dwarves-dwfl_module_build_id-cmake-check.patch

commit b83136498ac3511f1b014527d3f0fc9c50fad8ea
Author: Felipe Kellermann <felipek-F9QBgdt/En2RpAAqCnN02g@public.gmane.org>
Date:   Thu Jan 31 20:18:52 2008 -0200

    [DWARVES] Fixes a FIXME relating to a missing elf (libdw) symbol check.
    
    Signed-off-by: Felipe Kellermann <felipek-F9QBgdt/En2RpAAqCnN02g@public.gmane.org>

diff --git a/cmake/modules/FindDWARF.cmake b/cmake/modules/FindDWARF.cmake
index c72026c..17adc7e 100644
--- a/cmake/modules/FindDWARF.cmake
+++ b/cmake/modules/FindDWARF.cmake
@@ -5,6 +5,7 @@
 #  DWARF_LIBRARIES   - List of libraries when using elf utils.
 #  DWARF_FOUND       - True if fdo found.
 
+INCLUDE(CheckLibraryExists)
 
 if (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY)
 	# Already in cache, be silent
@@ -42,6 +43,9 @@ find_library(EBL_LIBRARY
 if (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY AND EBL_LIBRARY)
 	set(DWARF_FOUND TRUE)
 	set(DWARF_LIBRARIES ${DWARF_LIBRARY} ${ELF_LIBRARY} ${EBL_LIBRARY})
+
+	set(CMAKE_REQUIRED_LIBRARIES ${DWARF_LIBRARIES})
+	check_library_exists(elf dwfl_module_build_id "" HAVE_DWFL_MODULE_BUILD_ID)
 else (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY AND EBL_LIBRARY)
 	set(DWARF_FOUND FALSE)
 	set(DWARF_LIBRARIES)
@@ -77,3 +81,4 @@ endif (DWARF_FOUND)
 
 mark_as_advanced(DWARF_INCLUDE_DIR LIBDW_INCLUDE_DIR DWARF_LIBRARY ELF_LIBRARY EBL_LIBRARY)
 include_directories(${DWARF_INCLUDE_DIR} ${LIBDW_INCLUDE_DIR})
+configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_SOURCE_DIR}/config.h)
diff --git a/config.h.cmake b/config.h.cmake
new file mode 100644
index 0000000..1b57acd
--- /dev/null
+++ b/config.h.cmake
@@ -0,0 +1,9 @@
+/*
+  Copyright (C) 2007 Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms of version 2 of the GNU General Public License as
+  published by the Free Software Foundation.
+*/
+
+#cmakedefine HAVE_DWFL_MODULE_BUILD_ID
diff --git a/dwarves.c b/dwarves.c
index 9a21795..51f23df 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -24,6 +24,7 @@
 #include <string.h>
 #include <unistd.h>
 
+#include "config.h"
 #include "list.h"
 #include "dwarves.h"
 #include "dutil.h"
@@ -3486,11 +3487,8 @@ static int cus__load_module(Dwfl_Module *mod, void **userdata __unused,
 	size_t cuhl;
 	GElf_Addr vaddr;
 	const unsigned char *build_id = NULL;
-	/*
-	 * FIXME: check how to do this properly using cmake to test for
-	 * the existence of dwfl_module_build_id in the elfutils libraries.
-	 */
-#if 1
+
+#if HAVE_DWFL_MODULE_BUILD_ID
 	int build_id_len = dwfl_module_build_id(mod, &build_id, &vaddr);
 #else
 	int build_id_len = 0;

--Apple-Mail-1-173381414
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




-- 
Felipe "FK" Kellermann
felipek-F9QBgdt/En2RpAAqCnN02g@public.gmane.org
--Apple-Mail-1-173381414--
