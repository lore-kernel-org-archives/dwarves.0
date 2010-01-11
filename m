From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] Add scncopy to CMakeLists.txt
Date: Mon, 11 Jan 2010 15:50:31 -0500
Message-ID: <1263243031-19401-2-git-send-email-pjones@redhat.com>
References: <1263243031-19401-1-git-send-email-pjones@redhat.com>
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1263243031-19401-1-git-send-email-pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

Add scncopy to the build.
---
 CMakeLists.txt         |    6 +++++-
 MANIFEST               |    3 +++
 rpm/SPECS/dwarves.spec |    1 +
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 60e5d1b..3eea4fa 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -83,12 +83,16 @@ set(prefcnt_SRCS prefcnt.c)
 add_executable(prefcnt ${prefcnt_SRCS})
 target_link_libraries(prefcnt dwarves)
 
+set(scncopy_SRCS scncopy.c elfcreator.c)
+add_executable(scncopy ${scncopy_SRCS})
+target_link_libraries(scncopy dwarves)
+
 set(syscse_SRCS syscse.c)
 add_executable(syscse ${syscse_SRCS})
 target_link_libraries(syscse dwarves)
 
 install(TARGETS codiff ctracer dtagnames pahole pdwtags
-		pfunct pglobal prefcnt syscse RUNTIME DESTINATION
+		pfunct pglobal prefcnt scncopy syscse RUNTIME DESTINATION
 		${CMAKE_INSTALL_PREFIX}/bin)
 install(TARGETS dwarves LIBRARY DESTINATION ${LIB_INSTALL_DIR})
 install(TARGETS dwarves dwarves_emit dwarves_reorganize LIBRARY DESTINATION ${LIB_INSTALL_DIR})
diff --git a/MANIFEST b/MANIFEST
index 736c9ff..25037eb 100644
--- a/MANIFEST
+++ b/MANIFEST
@@ -15,6 +15,8 @@ CMakeLists.txt
 codiff.c
 ctracer.c
 dtagnames.c
+elfcreator.c
+elfcreator.h
 elf_symtab.c
 elf_symtab.h
 gobuffer.c
@@ -30,6 +32,7 @@ pglobal.c
 prefcnt.c
 rbtree.c
 rbtree.h
+scncopy.c
 syscse.c
 strings.c
 strings.h
diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
index 94cc0d6..909abee 100644
--- a/rpm/SPECS/dwarves.spec
+++ b/rpm/SPECS/dwarves.spec
@@ -77,6 +77,7 @@ rm -rf %{buildroot}
 %{_bindir}/pfunct
 %{_bindir}/pglobal
 %{_bindir}/prefcnt
+%{_bindir}/scncopy
 %{_bindir}/syscse
 %{_bindir}/ostra-cg
 %dir %{_datadir}/dwarves/
-- 
1.6.5.2

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
