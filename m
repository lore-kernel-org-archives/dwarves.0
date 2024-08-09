Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838511922C7;
	Fri,  9 Aug 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207513; cv=none; b=kzkp0TwxGXTLviE+nPSgYq5ij7BhW3ug9ek61S5+YU6+TurxdDUVVdYTHgGyTeD2Yj34Qi+S6dUJtTzIvF86t6x4+UGIoxbceWG5W/Cpu4v2SYjizle5EMoa6SDmIeVfATtg0uZ1eE2hafWrq0RC/TdRdi1q9OtB416DFzBKi0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207513; c=relaxed/simple;
	bh=oZkRrJzKxfQUn1quAHgpuD1t0d2KjrkwCBHzaDvkW2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdNlKIjlxaFthK3BWeabvEKQ6eZv9TSk/Sj8RZ/ugAQcAEj/VFsVMv9pZ/Yk8gbQunl7Gde+BnRINpofFzP0u96d1hKRp0wlwnPtu2ke2eUhLE2t/49cU+X1XNk1RlGYRVmIcZ0DDUKirjoplxkSbFgoccb9KPcTFyMhhQAugI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmI+pXAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmI+pXAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71072C32782;
	Fri,  9 Aug 2024 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723207513;
	bh=oZkRrJzKxfQUn1quAHgpuD1t0d2KjrkwCBHzaDvkW2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmI+pXAJdwNQ6kkDzC1cR6xrM1Ynq6CqTuzweBscKlC3rOl5cevscMNndRSD0e856
	 KzzveKpQUkjF4QACEQzo4o5PxB4aY8QU1XIMRJivO0sS+/LA5VA0Zpilo1Gq5WHAED
	 bPiXbj/MtyjH4ZQLjupYSbhqNvCKBqXIEb2hR4lYQqJMrD497fMeRcNOTY8elE+Pwh
	 4+t8/CWY5drxV1iv3ekNAWbgNK8EaZsAzZzyZoWuE9nObXOC354pMLSzC6ysWT/enO
	 93P0skTGPTGLKMe5OPozkWXdDyXtn5P4CoDfDSwigmg1Ja1yF/J0ozffD8IIsrTaB/
	 UGME9rSc2ulgg==
Date: Fri, 9 Aug 2024 09:45:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org,
	dwarves@vger.kernel.org, aliceryhl@google.com
Subject: Re: [PATCH v2] pahole: Apply CU-level filters early in loading
Message-ID: <ZrYPVQwJePB-nyO2@x1>
References: <20240801185054.2518383-1-mmaurer@google.com>
 <25bc65c9-e28e-48cd-b5a9-f603d846ae51@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25bc65c9-e28e-48cd-b5a9-f603d846ae51@oracle.com>

On Tue, Aug 06, 2024 at 01:10:03PM +0100, Alan Maguire wrote:
> On 01/08/2024 19:50, Matthew Maurer wrote:
> > Without this, even with `--lang_exclude=rust` set, running on `vmlinux`
> > with `CONFIG_RUST` enabled will lead to errors like:
> > die__process_function: tag not supported 0x2f (template_type_parameter)!
> > because the filtering doesn't happen until finalization, but unsupported
> > tags are reported during loading.
> > 
> > As an added bonus, this should speed up processing of large objects with
> > filtered CUs, as their details will no longer be walked.
> > 
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> 
> LGTM, thanks!
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks, I just split it into two patches, one adding the new early
filtering facility and with the second making then use of this new
facility in pahole:

⬢[acme@toolbox pahole]$ git log --oneline -5
fbcca0f6c2fbeb52 (HEAD -> master) pahole: Do --languages_exclude CU filtering earlier
1f8d83d16d6d6dfa dwarf_loader: Allow filtering CUs  early in loading
14be4e3d3fe56ce9 pahole: Only warn about multithreading not being available with older versions of elfutils in verbose mode
ee933f35484ac934 dwarf_loader: Simplify the tag__alloc() routine
cbecc3785266f0c5 (x1/master) dwarf_loader: Do just one alloc for 'struct dwarf_tag + struct tag'
⬢[acme@toolbox pahole]$ git show
commit fbcca0f6c2fbeb52349e28f03093a7efafb040ea (HEAD -> master)
Author: Matthew Maurer <mmaurer@google.com>
Date:   Thu Aug 1 18:50:54 2024 +0000

    pahole: Do --languages_exclude CU filtering earlier
    
    With this, we can avoid warnings for unsupported DWARF tags like:
    
      die__process_function: tag not supported 0x2f (template_type_parameter)!
    
    when processing object files generated from languages such as Rust, for
    instance when building the Linux kernel with `CONFIG_RUST`, after
    appltying the next patch in this series.
    
    As an added bonus, this should speed up processing of large objects with
    filtered CUs, as their details will no longer be walked.
    
    Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
    Signed-off-by: Matthew Maurer <mmaurer@google.com>
    Tested-by: Alan Maguire <alan.maguire@oracle.com>
    Cc: Alice Ryhl <aliceryhl@google.com>
    Cc: rust-for-linux@vger.kernel.org
    Link: https://lore.kernel.org/r/20240801185054.2518383-1-mmaurer@google.com
    [ Split from a larger patch ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/pahole.c b/pahole.c
index 4db51071b97d5f09..42ef6c262384a8e0 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3766,6 +3766,10 @@ int main(int argc, char *argv[])
        memset(tab, ' ', sizeof(tab) - 1);
 
        conf_load.steal = pahole_stealer;
+
+       if (languages.exclude)
+               conf_load.early_cu_filter = cu__filter;
+
        conf_load.thread_exit = pahole_thread_exit;
 
        if (conf_load.reproducible_build) {
⬢[acme@toolbox pahole]$
