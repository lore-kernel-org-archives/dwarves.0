Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9893194C6E;
	Fri,  9 Aug 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211469; cv=none; b=pMI/oujZbuyxwez8N9EjWI+7jJJpiWZCVUkVlDq6scrIraTF84qjGcwKlKs35RcnLUqlq0I/RRe0LQW0sPCMRP7oGHAUVO3z7MmPy7hMLifcNAPNOVvrPWzTRFDam4P4QY3Q5Lc4QUe053m8KBC9jPRTlfwTcaHOZ0auUOuxYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211469; c=relaxed/simple;
	bh=CyjY19UrCD8k4E/bhM/4gegyA6UyPxmNSklMb+WYJSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9SOjbMbfj5YncGC8s4ZUH6OPTHRiv4BwR06jGQ+EJRELI5r49m0fRmzy7RaIPwdyTKXfBRRC8UfMy0p9dPFE6CXA92OZ7UeO2B0wlaB/5PkH2BOCAdAR/HR6C3uaigVVXIW7Hqs4T/1hwAY69dxsm5YVaZ0mZkvKJbu+9YWv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTh0VkYT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTh0VkYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F45C32782;
	Fri,  9 Aug 2024 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723211469;
	bh=CyjY19UrCD8k4E/bhM/4gegyA6UyPxmNSklMb+WYJSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTh0VkYTqNSZZ3O5zLfZ8B8VcjHtcabsC4npYBY6ZBic3Drpdi/54GyxERCoLNxgG
	 Ii+W7e69bMVHMl2SIIzRypRx932o2WFBlPgEw9ITD6WJaZ9BJvQ7iJJzV+Cu5a9yWW
	 Yoj9Arq5b5kGyTW1t7OcP7DZUCZHEp+o0oCv1RvLRUFqDB6Gi6B619/g0mo+yYkZp5
	 Z5vwb7KT8AvQxIm3290fSJL4chKmECFUR8mqTjjZiDTdXaQrcRD7HcDYBFJiOMZNfD
	 MflZMWzIeNy2Py6L8VUOUqFYkaK3LUwwXQCjIr4gfur8Lfg9EfpzFuTNMufCP6JeYI
	 kk2dm591yCXbQ==
Date: Fri, 9 Aug 2024 10:51:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org,
	dwarves@vger.kernel.org, aliceryhl@google.com
Subject: Re: [PATCH v2] pahole: Apply CU-level filters early in loading
Message-ID: <ZrYeyjyuHiJyj7Xf@x1>
References: <20240801185054.2518383-1-mmaurer@google.com>
 <25bc65c9-e28e-48cd-b5a9-f603d846ae51@oracle.com>
 <ZrYPVQwJePB-nyO2@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrYPVQwJePB-nyO2@x1>

On Fri, Aug 09, 2024 at 09:45:13AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Aug 06, 2024 at 01:10:03PM +0100, Alan Maguire wrote:
> > On 01/08/2024 19:50, Matthew Maurer wrote:
> > > Without this, even with `--lang_exclude=rust` set, running on `vmlinux`
> > > with `CONFIG_RUST` enabled will lead to errors like:
> > > die__process_function: tag not supported 0x2f (template_type_parameter)!
> > > because the filtering doesn't happen until finalization, but unsupported
> > > tags are reported during loading.
> > > 
> > > As an added bonus, this should speed up processing of large objects with
> > > filtered CUs, as their details will no longer be walked.
> > > 
> > > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > 
> > LGTM, thanks!
> > 
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Thanks, I just split it into two patches, one adding the new early
> filtering facility and with the second making then use of this new
> facility in pahole:
> 
> ⬢[acme@toolbox pahole]$ git log --oneline -5
> fbcca0f6c2fbeb52 (HEAD -> master) pahole: Do --languages_exclude CU filtering earlier
> 1f8d83d16d6d6dfa dwarf_loader: Allow filtering CUs  early in loading

Tested building a kernel with CONFIG_RUST, no warnings (that
template_type_param wouldn't appear anyway as I added initial support
for it, at least for creating some structs out of its DWARF info, so no
more warnings), but:

⬢[acme@toolbox linux]$ pahole -C '<kernel::str::RawFormatter as core::fmt::Write>::{vtable_type}' ../build/rust-kernel/rust/kernel.o 
die__process_class: tag not supported 0x33 (variant_part) at <14f43>!
struct <kernel::str::RawFormatter as core::fmt::Write>::{vtable_type} {
	() *                       drop_in_place __attribute__((__aligned__(8))); /*     0     8 */
	usize                      size __attribute__((__aligned__(8))); /*     8     8 */
	usize                      align __attribute__((__aligned__(8))); /*    16     8 */
	() *                       __method3 __attribute__((__aligned__(8))); /*    24     8 */
	() *                       __method4 __attribute__((__aligned__(8))); /*    32     8 */
	() *                       __method5 __attribute__((__aligned__(8))); /*    40     8 */

	/* size: 48, cachelines: 1, members: 6 */
	/* forced alignments: 6 */
	/* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));

⬢[acme@toolbox linux]$

That DW_TAG_variant_part warning would show up without this series, so
seems to be working as expected :-)

- Arnaldo
