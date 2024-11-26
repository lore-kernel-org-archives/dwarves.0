Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3D1D63F6
	for <dwarves@vger.kernel.org>; Tue, 26 Nov 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637506; cv=none; b=eFlbGYt1WUej+mIj0AvdjZpcQ79xt7tvukcQp2N84r9II4bz0nvFT45g2bBuadDnoKWJ9RHVMEZhCoOI2exqJmPcBS+qomeqMZJySwi3yDYYv3z1BqsJVztVHZsBJGzUy4F0vsMMYikx5u5XrIhrxwJY7vtls13A/B92km6VypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637506; c=relaxed/simple;
	bh=7wykG+7xnL2C4SuC8/Iliu1zht0GrVhwZhlPNNEQXsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo42G+eRFLSfU6b+3vyrziE5MCKAnpdIuFet5oPd/DxQzSYQ1q3v/HatLHQN9Dh/+tqqY/SnvcbtYzMjUKJ6q9Fx5asRNdzTYmxVOPBPT9jR9dzIKUxVY/r32WN8oRR3dG0I695EzAWirOQGSK5qdSg57s1uLu+8fE5XfTqm6q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOPcK8FL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOPcK8FL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858F0C4CECF;
	Tue, 26 Nov 2024 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732637505;
	bh=7wykG+7xnL2C4SuC8/Iliu1zht0GrVhwZhlPNNEQXsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOPcK8FLs44oN5qdNm+T8WpMcv0l3VOqhFzr6UwExxj3pcvnftjgKKn3JE1d8RhUa
	 UbMXi/94cMg1t3sTxPDd+CUL04fab78ojkl6wkhwepvEv/uIZOmB0z99jprkCcIkh8
	 DTwd+4lPVbmMJaqSFTCK048zRfsck34bl/l72V4EZE7CZlWiCNpZlIpY8O07f2OMhp
	 oyuxS0wPm0qYRahhtEBpVYUEJvpXkXEvfWQGB6A2WxYLcXH32NRw139s9/cGlKMsWk
	 o82FSY1cn7M3eu8uKSR9vmTwXn/NfZAaCbRKmK7h7rY55G42EqifTWXkdFiWZoSB5H
	 WuohQTpsla4Rw==
Date: Tue, 26 Nov 2024 13:11:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ben Olson <matthew.olson@intel.com>
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com,
	brandon.kammerdiener@intel.com
Subject: Re: [PATCH dwarves v4] Respect CMAKE_INSTALL_LIBDIR
Message-ID: <Z0XzPy6TxMWg7gwd@x1>
References: <Z0TtnS-0iXq1Bc-0@bolson-desk>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0TtnS-0iXq1Bc-0@bolson-desk>

On Mon, Nov 25, 2024 at 03:35:25PM -0600, Ben Olson wrote:
> This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
> and use either `lib` or `lib64` by default so that installations match the
> conventional placement of libraries.
> For example, it will now install `libdwarves.so` into `${PREFIX}/lib` or
> `${PREFIX}/lib64`, depending on the distribution.
> 
> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> Signed-off-by: Ben Olson <matthew.olson@intel.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks, applied.

- Arnaldo

> ---
>  CMakeLists.txt | 19 ++++++-------------
>  README         |  4 ++--
>  2 files changed, 8 insertions(+), 15 deletions(-)
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
> index f9aeef7..7ee3b87 100644
> --- a/README
> +++ b/README
> @@ -3,7 +3,7 @@ Build instructions:
>  1. install cmake
>  2. mkdir build
>  3. cd build
> -4. cmake -D__LIB=lib ..
> +4. cmake ..
>  5. make install
>  
>  cmake Options:
> @@ -12,7 +12,7 @@ cmake Options:
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
