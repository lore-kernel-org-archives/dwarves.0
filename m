Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491682;
	b=K2lyiW7iKkf0uUMdidDN3x8S1jXswzfNr233pmHs3mwGVau0ZqXK6upeUVgmiQkU5ess
	 +LPOYH3UyD574kmSNmIpgX0ZUkFK6xks7WvHfpCHtO0ftO/z6UwDbeywtOwhRHCFrw1YA
	 S9qX000eu8DF3OswCCSLswS2IxcOga526rLGnpgrHu9LkRnCoDbR4cgfAP/PNHasOmUlz
	 v7PdtQ1PwyKKnfFUYufpHa5K4Vklwv6S0nvQ0A+9jXeaoz3Xz2G9lr+DtidlzFV1tiOQd
	 2C6n8WDcH85RFBfidFGqRZ7+Divg02OHxrwcdkl3Mnzdro+qdgjrGwx7+fR1xm7BIHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491682;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=GJzpU18PpbltGnIbSo/mDFrOgiPvvS/9/MBenbJHib4=;
	b=0YvgAur63IGZ+FGcagrWF8hmrVDuKs4pHGaDN31KCkXlej1tg9C1EkbpA0lxvFtf6uTH
	 GSOO6gCzKz/Atz7to+wivHwF0wWpmvfISUMdHRCfWbfpn2w5WNyTU1KDcmFG5LrsrEqaq
	 BTk2xWh0YbA7zY3dM0jElseEuRa9OLOchqb6h3L1cplIOUvYNMdF624FWxLiSs0PEf8Ub
	 /SUs9NJ3Bk3aLN3E+L6EiA992NAh95anVn8vwsWsWkXbFazfB3qBUydjImDPYuRhww92a
	 lVN7gQeQS3BLlHExAEbRPUskdHgXcBgoPmFBo2E9ksxNgAfmGgGEv1fOPRJGWbnWMgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F53606A339
	for <dwarves@vger.kernel.org>; Thu, 12 Nov 2026 13:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F53606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b350d5fe3aso7707567b3.1
        for <dwarves@vger.kernel.org>; Thu, 12 Nov 2026 05:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491681; x=1795096481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJzpU18PpbltGnIbSo/mDFrOgiPvvS/9/MBenbJHib4=;
        b=RIorMcmYKSFf6usd3YXIyq7SzVtzdybdWvG+BCO7Bat/sPWED+1/LL7zTS3ju/74/f
         oBGQP8dpkPkCZ4Tt5qd9zEP0qe4HltprL9zVqu9IWSh+e+RHlX+yZvjSdmlzhL0EMaPT
         Oez/25Y5P084pSaPAP3JcRX5XDwqsUgUQgzf2OoZs11DY5Gbufr6dyL1ZZ1nafG75xml
         EwhvzaUI5NaYyVytTW6wdCigIjwcRwUjndAwuHZUL2MHmtgHUbYp4hzZbsp+6WBj7BZe
         pb9kp57eA+kEuvlo8cN5FDJIo1ETNOh4wTCln3g1lUkJ++TsiBgTRoLp4FoeRLI8ziEv
         RMvA==
X-Forwarded-Encrypted: i=1; AL+hErHH0NGIAKwsQyRxa38YbyJIxCgvd91yNw8M8prMpqxlt2ynkuqy+5BHL3q80rFqNik5lURgBMjw@vger.kernel.org
X-Gm-Message-State: APuU4Z+LCo4QZsuv5HWEwoSU4ZFCbHdHG52nU5Si/5m6UxIrieslJE2A
	Slnc/yaG2r9tsZrkbTC0vmKZi7ElfWvmU/eNyl3lj23EGiKiAFM85wf+
X-Gm-Gg: AYBFou3t+iJ36dLQ/zMeNZJ2YdpAGB+ufyV8zjs6qsEpAWVXt8apMoLH0iuD6wyLrpf
	gQF3AqykY0wS8OCE5pQGIGwWVk3GNMU6tFEP9T/go0sbinucqU5cEqqTkBr/tJr/Ut5CSNC9CBX
	6dC3K1unvZfirTC1lYBQLYrMPSqmxomsuu5ofUTqNb7IPBLX/yTRu5PbYnqraswVG18hCiL3zxs
	muexbQFvyTVfuSfkZft6YWy+ePh+TtiNL57eQLqbcW1CPN1CXb8iUGhXuRNibbR4spYNbu2XvVc
	/OitH1s27bjBagISNtZYbu7ghzk8yQJcyikuAXl6GjOb5Wvf8iPzattfcRYjAa9MgD7K0HeKLdn
	VubsZXl/6hETD8FiPE/HXMqPamMHkJ75SwkfzRRqo9bGqHcC4yiDcw7sJUk9TfXi/CIZVkGaJ8o
	sPFrwvQPHW+bmF2IH8yvr6grA5lRVBTdau9Tv+H8I5QjMjVvOUlGuWclaU1oOoUxSs+lju4hbac
	I3TbZruk/NQWkW1DqPf5i++HFG+SFS6b2mqxulLC686hN8R9ifTWapEoUpMJDQWVbIvA/uHrocH
	lpT8RXJzUYvsiJdSucqA
X-Received: by 2002:a05:690c:c4e6:b0:87e:645c:182b with SMTP id 00721157ae682-8b3baf09b42mr17315587b3.26.1794491681204;
        Thu, 12 Nov 2026 05:54:41 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933e0d01sm70407067b3.22.2026.11.12.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:54:40 -0800 (PST)
Date: Thu, 12 Nov 2026 05:54:38 -0800
From: Breno Leitao <leitao@debian.org>
To: Alan Maguire <almagui@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves] btf_encoder: Keep the source prototype of kfuncs
Message-ID: <avXE70_JpiqemxzV@gmail.com>
References: <20261111222447.322978-1-yonghong.song@linux.dev>
 <ffd8e847-6a3f-4403-a33c-1b3804e1c039@kernel.org>
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd8e847-6a3f-4403-a33c-1b3804e1c039@kernel.org>

Hello Alan,

On Thu, Nov 12, 2026 at 12:36:29PM +0000, Alan Maguire wrote:
> > Reported-by: Breno Leitao <leitao@debian.org>
> 
> I'm having trouble reproducing the original failure; would you mind sharing
> the config that reproduces it? I tried with clang 22, but no luck so far.

This reproduces it on x86_64, with next-20261111, clang 22.1.3 and
pahole master (9eb594d):

    # make LLVM=1 x86_64_defconfig
    # ./scripts/config -e BPF_SYSCALL -e BPF_JIT -e CGROUP_BPF \
            -d DEBUG_INFO_NONE -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
            -e DEBUG_INFO_BTF -e KCSAN -e UBSAN -e WERROR
    # make LLVM=1 olddefconfig
    # make LLVM=1 -j$(nproc) vmlinux
    [...]
      BTF     .tmp_vmlinux1
    WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
    WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
    Failed to generate BTF for vmlinux

let me know if you are not able to, and I will send you my full .config

Thanks,
--breno
