Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59433546E9
	for <dwarves@vger.kernel.org>; Fri, 16 Oct 2026 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169166; cv=none; b=oh9Eqyd8f5s3xOeqG7Os0Ok9E9wTbhhp9UGXFjHlBcjTGD+0X2hvYvvTuLGLgJ4BtacGdHSSuFeTRVI1sc9rxpdHmaGnBc/4iPmdEe9j9uD7YpvnR5ok4H/I2kq0sowjKh6c8JgJ0CNUode+XCaTG5l91U98vTD0dcu41kIiHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169166; c=relaxed/simple;
	bh=AEAKmFCDMoCqQoYjzm7hsAzaMTn/Uzui+pf6B0Og7TE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kHCpLMlopBSrjBHbF1VJagC6KRcdU9OWACvXKR2x3si54LDpejbp36cuRDjXwovTE1iuCDDHWitIpl/CXmjDjcBZrZocJWgD3Cosz/CGOG2t9J4+wK1Ye7mZz1vrrSiYSY5ZhK75RP9F00gCLHx1wW+WZJlBkPeYQPQ/ESST51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWL8O8Qn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWL8O8Qn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F301F000C4;
	Fri, 16 Oct 2026 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169165;
	bh=em7hFx3uWX/FZyUVR4tyRRN6nJoF+NZpaQqQCBhx/e4=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To;
	b=dWL8O8QnMal/M4fmBTDuENVkskVv18lAsTejSWnUykBkXV69kSfl7VgzxNpDo4eqo
	 RPJBEIcJQVaslPE7LbJTwx2Awu3Y6gqcD0vWktmpCFyXJRLBA6jFszU954MwTEXX9x
	 MK6ujXZIdHr8TQcXtd1kIfG52cdvTII1CADfLCb8rjjGVulUmQcqb1OzeEO8rm+NMW
	 cVKxwdwYQ3dgF3AErUnUeLaypeokwCKWF7DqU6T1UTBj44xr2QFZnGNHUabvxRN8Mk
	 h3vt3+/ev39RhFANwxa7Z/cAa/5r8nksP5u3+5hBrH5TU0jtyc2tgqIH+m+Z5ACVbF
	 JwjkxMtYe/3tA==
Message-ID: <7c184732-82fb-4ea0-982d-79bb40cd27c6@kernel.org>
Date: Fri, 16 Oct 2026 17:46:02 +0100
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: havard.f.aasen@pfft.no
Cc: dwarves@vger.kernel.org
References: <20260928182217.301003-2-havard.f.aasen@pfft.no>
Subject: Re: [PATCH 1/1] prefcnt: guard against NULL function parameters
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20260928182217.301003-2-havard.f.aasen@pfft.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> When prefcnt is started without an input file, it loads the running
> kernel's debugging information through the existing vmlinux/BTF/ELF
> loading path. While walking the functions in the resulting
> compilation units, some function parameter entries can be represented
> by a NULL pointer.
> 
> refcnt_function() passes each entry from function->proto.parms to
> refcnt_parameter(). refcnt_parameter() dereferences the entry when it
> checks parameter->tag.type, causing prefcnt to terminate with a
> segmentation fault if the entry is NULL.

I still see a segmentation fault when running prefcnt on /sys/kernel/btf/vmlinux
with this change; I think the right answer here is to fix the caller by
using function__for_each_parameter() which will correctly use the ftype
to get parameters for BTF, i.e.

diff --git a/prefcnt.c b/prefcnt.c
index 37ca18f..86fceba 100644
--- a/prefcnt.c
+++ b/prefcnt.c
@@ -106,7 +106,7 @@ static void refcnt_function(struct function *function, const struct cu *cu)
                        refcnt_tag(type, cu);
        }

-       list_for_each_entry(parameter, &function->proto.parms, tag.node)
+       function__for_each_parameter(function, cu, parameter)
                refcnt_parameter(parameter, cu);

        refcnt_lexblock(&function->lexblock, cu);


Can you send a v2? Thanks!
