From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH pahole] cmake: libebl was merged into libdw
Date: Mon, 3 Feb 2020 06:30:06 -0300
Message-ID: <20200203093006.GC2325@redhat.com>
References: <20191216210646.721790-1-Jason@zx2c4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191216210646.721790-1-Jason-OnJsPKxuuEcAvxtiuMwx3w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jason A. Donenfeld" <Jason-OnJsPKxuuEcAvxtiuMwx3w@public.gmane.org>
Cc: Mark Wielaard <mark-S8vpcOIGcCXYtjvyW6yDsg@public.gmane.org>, Jiri Olsa <jolsa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Dec 16, 2019 at 10:06:46PM +0100, Jason A. Donenfeld escreveu:
> Since elfutils 178, libebl is now part of libdw, so searching for libebl
> always fails. Simply remove it from the search.
> 
> Signed-off-by: Jason A. Donenfeld <Jason-OnJsPKxuuEcAvxtiuMwx3w@public.gmane.org>

Thanks, applied and pushed out, will be in the 1.16 rpm for fedora 31
and also in the upcoming 1.17 release.

Mark Wieelard tested it with older elfutils versions and provided his
reviewed-by tag.

Sorry for taking too long to process this, my system was still with a
older elfutils version so this ended up falling thru the cracks :-\

- Arnaldo

> ---
>  cmake/modules/FindDWARF.cmake | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/cmake/modules/FindDWARF.cmake b/cmake/modules/FindDWARF.cmake
> index f4feec4..027d06e 100644
> --- a/cmake/modules/FindDWARF.cmake
> +++ b/cmake/modules/FindDWARF.cmake
> @@ -37,14 +37,9 @@ find_library(ELF_LIBRARY
>  	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
>  )
>  
> -find_library(EBL_LIBRARY
> -	NAMES ebl
> -	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
> -)
> -
> -if (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY AND EBL_LIBRARY)
> +if (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY)
>  	set(DWARF_FOUND TRUE)
> -	set(DWARF_LIBRARIES ${DWARF_LIBRARY} ${ELF_LIBRARY} ${EBL_LIBRARY})
> +	set(DWARF_LIBRARIES ${DWARF_LIBRARY} ${ELF_LIBRARY})
>  
>  	set(CMAKE_REQUIRED_LIBRARIES ${DWARF_LIBRARIES})
>  	# check if libdw have the dwfl_module_build_id routine, i.e. if it supports the buildid
> @@ -52,10 +47,10 @@ if (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY AN
>  	# in distributions such as fedora). We do it against libelf because, IIRC, some distros
>  	# include libdw linked statically into libelf.
>  	check_library_exists(elf dwfl_module_build_id "" HAVE_DWFL_MODULE_BUILD_ID)
> -else (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY AND EBL_LIBRARY)
> +else (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY)
>  	set(DWARF_FOUND FALSE)
>  	set(DWARF_LIBRARIES)
> -endif (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY AND EBL_LIBRARY)
> +endif (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY)
>  
>  if (DWARF_FOUND)
>  	if (NOT DWARF_FIND_QUIETLY)
> @@ -63,7 +58,6 @@ if (DWARF_FOUND)
>  		message(STATUS "Found elfutils/libdw.h header: ${LIBDW_INCLUDE_DIR}")
>  		message(STATUS "Found libdw library: ${DWARF_LIBRARY}")
>  		message(STATUS "Found libelf library: ${ELF_LIBRARY}")
> -		message(STATUS "Found libebl library: ${EBL_LIBRARY}")
>  	endif (NOT DWARF_FIND_QUIETLY)
>  else (DWARF_FOUND)
>  	if (DWARF_FIND_REQUIRED)
> @@ -73,9 +67,9 @@ else (DWARF_FOUND)
>  		find_path(FEDORA fedora-release /etc)
>  		find_path(REDHAT redhat-release /etc)
>  		if (FEDORA OR REDHAT)
> -			if (NOT DWARF_INCLUDE_DIR OR NOT LIBDW_INCLUDE_DIR OR NOT EBL_LIBRARY)
> +			if (NOT DWARF_INCLUDE_DIR OR NOT LIBDW_INCLUDE_DIR)
>  				message(STATUS "Please install the elfutils-devel package")
> -			endif (NOT DWARF_INCLUDE_DIR OR NOT LIBDW_INCLUDE_DIR OR NOT EBL_LIBRARY)
> +			endif (NOT DWARF_INCLUDE_DIR OR NOT LIBDW_INCLUDE_DIR)
>  			if (NOT DWARF_LIBRARY)
>  				message(STATUS "Please install the elfutils-libs package")
>  			endif (NOT DWARF_LIBRARY)
> @@ -89,9 +83,6 @@ else (DWARF_FOUND)
>  			if (NOT LIBDW_INCLUDE_DIR)
>  				message(STATUS "Could NOT find libdw include dir")
>  			endif (NOT LIBDW_INCLUDE_DIR)
> -			if (NOT EBL_LIBRARY)
> -				message(STATUS "Could NOT find libebl library")
> -			endif (NOT EBL_LIBRARY)
>  			if (NOT DWARF_LIBRARY)
>  				message(STATUS "Could NOT find libdw library")
>  			endif (NOT DWARF_LIBRARY)
> @@ -103,7 +94,7 @@ else (DWARF_FOUND)
>  	endif (DWARF_FIND_REQUIRED)
>  endif (DWARF_FOUND)
>  
> -mark_as_advanced(DWARF_INCLUDE_DIR LIBDW_INCLUDE_DIR DWARF_LIBRARY ELF_LIBRARY EBL_LIBRARY)
> +mark_as_advanced(DWARF_INCLUDE_DIR LIBDW_INCLUDE_DIR DWARF_LIBRARY ELF_LIBRARY)
>  include_directories(${DWARF_INCLUDE_DIR} ${LIBDW_INCLUDE_DIR})
>  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_SOURCE_DIR}/config.h)
>  
> -- 
> 2.24.1
