Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE01A9FB7
	for <dwarves@vger.kernel.org>; Fri,  2 Jan 2026 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368054; cv=none; b=RDUGgHCFbq7KUUeox9W1Wfp/CqIh8aSykb38dnv2shXtxOtHNxNV/lhKaRuQmGrpvchAjj+pQlwnJj4M4yhaMCpTlK7EX9zEOeau/kiHqi8+NYBkIrYBL8gcppmvqIGX36t6uBOE9ftnU5DOW0+emjfngjExDAcQ1p5a0OWSs/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368054; c=relaxed/simple;
	bh=Lc0Vaiwhg93Kftu6FwUF3q06s2V6DW0Q+a+GiQZrgTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhlbncLx0mp+sv/LabskFo+8C6SxNnNmdlu5OAlX3fcBt9opTkk1PzdKCDaB45i0fkb1X5h5lmCSscSX54EPXGc3uB0ujipJlN6rwx43yXwGwjJiULGmfHS3BwNCJHR7g4dmjP7iqCvr83h2q+D6/Y2WH/ReLH/G+LyaUy+ruA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dE5fKgc0; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dE5fKgc0"
Message-ID: <bcd23277-a18e-4bb5-ba76-3416c84511c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767368038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zq7PL7Unph+1q4/lCVQBzEE0/yE1hCPnq6+DR6Z5GKU=;
	b=dE5fKgc0cUMTP0cxONjiR/QximBbiXME50mdT2bwFrQOfC496bubQDvWMpnI5Jet8TMM1W
	UxABwrcWqNALr/2G6Wv2F51CsQD+eQQ94yi026maOeAAG6HocWMFTGESnlLwDS+x40V5gC
	qmkBlHRftFiIi+Apbkoy+vKzf4AL+44=
Date: Fri, 2 Jan 2026 07:33:50 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, docs: Update pahole to 1.28 for selftests
To: Hemanth Malla <vmalla@linux.microsoft.com>, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, vmalla@microsoft.com,
 corbet@lwn.net, Alan Maguire <alan.maguire@oracle.com>,
 dwarves <dwarves@vger.kernel.org>
References: <1767352415-24862-1-git-send-email-vmalla@linux.microsoft.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <1767352415-24862-1-git-send-email-vmalla@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/2/26 3:13 AM, Hemanth Malla wrote:
> From: Hemanth Malla <vmalla@microsoft.com>
> 
> pahole 1.16 doesn't seem to be to sufficient anymore for running bpf
> selftests.
> 
> Signed-off-by: Hemanth Malla <vmalla@microsoft.com>
> ---
>  Documentation/bpf/bpf_devel_QA.rst | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
> index 0acb4c9b8d90..3a147b6c780e 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -482,7 +482,7 @@ under test should match the config file fragment in
>  tools/testing/selftests/bpf as closely as possible.
>  
>  Finally to ensure support for latest BPF Type Format features -
> -discussed in Documentation/bpf/btf.rst - pahole version 1.16
> +discussed in Documentation/bpf/btf.rst - pahole version 1.28

Hi Hemanth, thanks for the patch.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

1.28 is needed for --distilled_base [1], which is only a requirement
for tests using modules. Many other tests are likely to work with
older versions, but the minimum for the kernel build is 1.22 now [2].

Not sure if it's worth it to add this nuance to the QA doc, although
in general we should recommend people running the selftests to use the
latest pahole release. Maybe add a comment?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/bpf/btf.rst?h=v6.18#n986
[2] https://lore.kernel.org/bpf/20251219181825.1289460-1-ihor.solodrai@linux.dev/

>  is required for kernels built with CONFIG_DEBUG_INFO_BTF=y.
>  pahole is delivered in the dwarves package or can be built
>  from source at
> @@ -502,9 +502,6 @@ codes from
>  
>  https://fedorapeople.org/~acme/dwarves
>  
> -Some distros have pahole version 1.16 packaged already, e.g.
> -Fedora, Gentoo.
> -
>  Q: Which BPF kernel selftests version should I run my kernel against?
>  ---------------------------------------------------------------------
>  A: If you run a kernel ``xyz``, then always run the BPF kernel selftests

