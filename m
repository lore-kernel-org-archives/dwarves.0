Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFD1B85EC
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570686; cv=none; b=HEzMVSBkIo1RrCDMrz0kK6d+AwQqwWd51LEsrlw+xuIwL4RYPZ9qQ81PhTDhMlLpxLoy/+O8OHkV+YHnBWVhWfkMdP+otagszJoKIOWdw6bnaas/QypmEDczBXXo9x+kgUXZxFeDx3/9Dtg248ahhowIsLlGAnxStSpyK8wdfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570686; c=relaxed/simple;
	bh=GVLwdXKus3yQzMXzgdlCLmAMTyG4HBeClQPDWMer9T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBn4jxLSNtZN4KiMyhIByfUwk/uKYNtN1rq2kKX4Cw2KJtxID7F55okjwZ19BXDMH7wKHf16WqEEAlO0ldDD3/VCaWUZAG4phWe+n0jX7mjVqV5Ujdejwvm32TnFXowfWZp2ftoRSKtppcKRi42Lozu05CgbKAcq5k5OKtC0uHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpIAQecz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpIAQecz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5931C4CECE;
	Mon, 25 Nov 2024 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732570686;
	bh=GVLwdXKus3yQzMXzgdlCLmAMTyG4HBeClQPDWMer9T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpIAQeczxT1eK4ggOdqROSmffcaQO9aSSiwbq+rOYgbaZPwI4U9OM3eEfsxdf/lLA
	 8J4C93qjHtyKj0Gr64H8TMhP/LURbc4hiBK6yGqRfMOrx/vCDqCPizAPY5vVDO4Eyb
	 fFF5vKSiJvtg5ZrBGApcRf5aRRekZiJj0eOiieEW1WckWQqTLukhrLRE4Zrrtjmxm1
	 0n7OaRE4l8n1hImp+nspcMYFWy1ISBdWEznEFp86B0eVFlMnMzX7F0KwlHhc+5LCBU
	 S76BhCl/hTDH9BTWYgB/y8pLDznFlr7RbJck4oTGZfwSbADU85Bf7RvTCwy8L+pbCS
	 /x3TvQsufuTuA==
Date: Mon, 25 Nov 2024 18:38:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ben Olson <matthew.olson@intel.com>
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com,
	brandon.kammerdiener@intel.com
Subject: Re: [PATCH dwarves v3] Respect CMAKE_INSTALL_LIBDIR
Message-ID: <Z0TuO4iXUK-kgTqb@x1>
References: <Z0TefTqE9Xqx0Gz0@bolson-desk>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0TefTqE9Xqx0Gz0@bolson-desk>

On Mon, Nov 25, 2024 at 02:30:53PM -0600, Ben Olson wrote:
> This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
> and use either `lib` or `lib64` by default so that installations match the
> conventional placement of libraries.
> For example, it will now install `libdwarves.so` into `${PREFIX}/lib` or
> `${PREFIX}/lib64`, depending on the distribution.
> 
> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> Signed-off-by: Ben Olson <matthew.olson@intel.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>

Alan, can I keep your tags?

- Arnaldo

> ---
> 
> Changes in v3:
>   - Added additional change in README
>   
> Changes in v2:
>   - Included the proper built-in CMake module
>   - Made commit message distro-agnostic
> 
> 
>  CMakeLists.txt | 19 ++++++-------------
>  README         |  5 ++---
>  2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 8ca1bf2..1d0dadf 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -21,18 +21,9 @@ else()
>  	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
>  endif()
>  
> -# Try to parse this later, Helio just showed me a KDE4 example to support
> -# x86-64 builds.
> -# the following are directories where stuff will be installed to
> -set(__LIB "" CACHE STRING "Define suffix of directory name (32/64)" )
> -
> -macro(_set_fancy _var _value _comment)
> -	if (NOT DEFINED ${_var})
> -		set(${_var} ${_value})
> -	else (NOT DEFINED ${_var})
> -		set(${_var} "${${_var}}" CACHE PATH "${_comment}")
> -	endif (NOT DEFINED ${_var})
> -endmacro(_set_fancy)
> +# Use the standard library installation directory
> +include(GNUInstallDirs)
> +set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
>  
>  # where to look first for cmake modules,
>  # before ${CMAKE_ROOT}/Modules/ is checked
> @@ -84,7 +75,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
>  	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
>  endif()
>  
> -_set_fancy(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${__LIB}" "libdir")
> +if (NOT DEFINED LIB_INSTALL_DIR)
> +    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
> +endif()
>  
>  # libbpf uses reallocarray, which is not available in all versions of glibc
>  # libbpf's include/tools/libc_compat.h provides implementation, but needs
> diff --git a/README b/README
> index f9aeef7..e9f860a 100644
> --- a/README
> +++ b/README
> @@ -3,8 +3,7 @@ Build instructions:
>  1. install cmake
>  2. mkdir build
>  3. cd build
> -4. cmake -D__LIB=lib ..
> -5. make install
> +4. make install
>  
>  cmake Options:
>    -DBUILD_SHARED_LIBS
> @@ -12,7 +11,7 @@ cmake Options:
>      Use -DBUILD_SHARED_LIBS=OFF while invoking cmake to create STATIC libraries
>      and link applications to it.
>  
> -    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
> +    Ex. cmake -DBUILD_SHARED_LIBS=OFF ..
>  
>    -DCMAKE_INSTALL_PREFIX
>      Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
> -- 
> 2.47.0
