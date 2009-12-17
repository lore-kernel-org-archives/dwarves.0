From: Herton Ronaldo Krzesinski <herton-4qZELD6Fgxg39yzSjRtAkw@public.gmane.org>
Subject: Avoid uneeded linking/unused libraries in some dwarves libraries and executables
Date: Thu, 17 Dec 2009 14:32:33 -0200
Message-ID: <200912171432.33181.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi,

currently mandriva has a packaging script which checks for uneeded linking in
package built files. For dwarves, it displays:

Warning: unused libraries in /usr/lib64/libdwarves_reorganize.so.1.0.0: libdw.so.1
 libelf.so.1
 libz.so.1

Warning: unused libraries in /usr/lib64/libdwarves_emit.so.1.0.0: libdw.so.1
 libelf.so.1
 libz.so.1

Warning: unused libraries in /usr/bin/ctracer: libz.so.1
 libdw.so.1

Warning: unused libraries in /usr/bin/syscse: libdw.so.1
 libelf.so.1
 libz.so.1

Warning: unused libraries in /usr/bin/pglobal: libdw.so.1
 libelf.so.1
 libz.so.1

Warning: unused libraries in /usr/bin/pdwtags: libdw.so.1
 libelf.so.1
 libz.so.1

Warning: unused libraries in /usr/bin/prefcnt: libdw.so.1
 libelf.so.1
 libz.so.1

Warning: unused libraries in /usr/bin/pfunct: libz.so.1
 libdw.so.1

Warning: unused libraries in /usr/bin/pahole: libz.so.1
 libdw.so.1
 libelf.so.1

Warning: unused libraries in /usr/bin/dtagnames: libdw.so.1
 libelf.so.1
 libz.so.1

Warning: unused libraries in /usr/bin/codiff: libdw.so.1
 libelf.so.1
 libz.so.1

The patch below fixes the issue (removing uneeded specified libraries and using
LINK_INTERFACE_LIBRARIES property, see
http://www.cmake.org/Wiki/CMake_FAQ#Why_are_libraries_linked_to_my_shared_library_included_when_something_links_to_it.3F)

Signed-off-by: Herton Ronaldo Krzesinski <herton-4qZELD6Fgxg39yzSjRtAkw@public.gmane.org>

diff -p -up dwarves-1.8/CMakeLists.txt.orig dwarves-1.8/CMakeLists.txt
--- dwarves-1.8/CMakeLists.txt.orig	2009-06-17 13:05:08.000000000 -0300
+++ dwarves-1.8/CMakeLists.txt	2009-12-17 14:07:19.034269772 -0200
@@ -38,17 +38,18 @@ set(dwarves_LIB_SRCS dwarves.c dwarves_f
 		     dutil.c elf_symtab.c rbtree.c)
 add_library(dwarves SHARED ${dwarves_LIB_SRCS})
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
+set_target_properties(dwarves PROPERTIES LINK_INTERFACE_LIBRARIES "")
 target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES})
 
 set(dwarves_emit_LIB_SRCS dwarves_emit.c)
 add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
 set_target_properties(dwarves_emit PROPERTIES VERSION 1.0.0 SOVERSION 1)
-target_link_libraries(dwarves_emit ${DWARF_LIBRARIES} dwarves)
+target_link_libraries(dwarves_emit dwarves)
 
 set(dwarves_reorganize_LIB_SRCS dwarves_reorganize.c)
 add_library(dwarves_reorganize SHARED ${dwarves_reorganize_LIB_SRCS})
 set_target_properties(dwarves_reorganize PROPERTIES VERSION 1.0.0 SOVERSION 1)
-target_link_libraries(dwarves_reorganize ${DWARF_LIBRARIES} dwarves)
+target_link_libraries(dwarves_reorganize dwarves)
 
 set(codiff_SRCS codiff.c)
 add_executable(codiff ${codiff_SRCS})


--
[]'s
Herton
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
