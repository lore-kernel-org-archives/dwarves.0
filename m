From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pahole regression: -a no longer works?
Date: Sat, 27 Jun 2009 13:34:39 -0300
Message-ID: <20090627163439.GB3349@ghostprotocols.net>
References: <db65a1cd0906251829p5e10b56fo861728d35ea54fb0@mail.gmail.com> <20090627144405.GE4981@ghostprotocols.net> <87eit5lm0u.wl%naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87eit5lm0u.wl%naesten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Bronson <naesten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves <dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

Em Sat, Jun 27, 2009 at 11:44:01AM -0400, Samuel Bronson escreveu:
> Speaking of the REDHAT/FEDORA conditional,
> 
>   (a) why doesn't it have a comment explaining what it's for? -- that
> is, what is different on redhat/fedora, and what it does to compensate
> for them
> 
>   (b) why is it *after* the check for the "dwfl_module_build_id"
> symbol, so that the REDHAT/FEDORA stuff can't fix up the missing
> variables and allow the symbol check a chance to run?

Just added comments for both cases, please take a look and see if it
makes it clear for you:

commit f96099b4c519e83ab2421c2e7660e132f63ddec7
Author: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Sat Jun 27 13:32:20 2009 -0300

    cmake: Add comments explaining build_id and fedora/rh detection
    
    Suggested-by: Samuel Bronson <naesten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

diff --git a/cmake/modules/FindDWARF.cmake b/cmake/modules/FindDWARF.cmake
index 76cdb3f..f4feec4 100644
--- a/cmake/modules/FindDWARF.cmake
+++ b/cmake/modules/FindDWARF.cmake
@@ -47,6 +47,10 @@ if (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY AN
 	set(DWARF_LIBRARIES ${DWARF_LIBRARY} ${ELF_LIBRARY} ${EBL_LIBRARY})
 
 	set(CMAKE_REQUIRED_LIBRARIES ${DWARF_LIBRARIES})
+	# check if libdw have the dwfl_module_build_id routine, i.e. if it supports the buildid
+	# mechanism to match binaries to detached debug info sections (the -debuginfo packages
+	# in distributions such as fedora). We do it against libelf because, IIRC, some distros
+	# include libdw linked statically into libelf.
 	check_library_exists(elf dwfl_module_build_id "" HAVE_DWFL_MODULE_BUILD_ID)
 else (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY AND EBL_LIBRARY)
 	set(DWARF_FOUND FALSE)
@@ -63,6 +67,9 @@ if (DWARF_FOUND)
 	endif (NOT DWARF_FIND_QUIETLY)
 else (DWARF_FOUND)
 	if (DWARF_FIND_REQUIRED)
+		# Check if we are in a Red Hat (RHEL) or Fedora system to tell
+		# exactly which packages should be installed. Please send
+		# patches for other distributions.
 		find_path(FEDORA fedora-release /etc)
 		find_path(REDHAT redhat-release /etc)
 		if (FEDORA OR REDHAT)
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
