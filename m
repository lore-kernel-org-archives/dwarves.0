Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E140926C
	for <dwarves@vger.kernel.org>; Tue, 29 Sep 2026 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662308; cv=none; b=DxKiVC4sme+NSbApr20L7VtU18BhpSBeOIVC8chWW1/XHxbVCkGfSfQIrQ9BvG7halNk4FIIiwDx8mC1GAWmX2c6t515mgywuj8Yv/uzz3O5fc5T+cL1wutas3QZT6uyNqXTXzJpVYk+t+65GQExwoONdoXw7d4YXbC3OWNrgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662308; c=relaxed/simple;
	bh=//UIWI6EBSx9Oag+8dQ5laZGpmh3mMNe3zb67AuJvD8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=Z/0jqmOdSkvm0ssnvVa+sVCifD/D6/N7YcaZ+AcciZ6LyXKvLG9bjvUSb/bUBXKzsE2eFE1qFl/omUaf3Oy470jaDq/VeA5qjN9jqEQM+SixavGAA8wMkyaRlpvhvSwt96Ai71vVzqPx3a6dovfCJ8k6nA8vfwcsb2D4NFPS1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRmVdTQm; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRmVdTQm"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso2772722a91.1
        for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 23:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790662307; x=1791267107; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBoCCGhRsJHq8tUovZJTNZLbswHaHS+w9f7EhlXZncE=;
        b=pRmVdTQmMnsn/Qu/OgOH3jKTZZLHXAU093PKquBGsFQkPjHnkz9gLUoGhfwNOnp16h
         wzcgONRaktsmhlBodCt5z/iuw1ruNiF2Bw5TG7X6d1tOMBfNjafRbOS0/psPq3zokksu
         zSSgh5C8WiEoaXM20/Lpfrm/3oCZPtg1PxRXcMElMSARclcwFtFVkUpXl4lT4oJnBNEp
         ArNR0UHRFctzsWsOoTWuolc07wdO59pS7zt+QsM3wNy/PZmDp7qIjYskMCQXC+R/amhy
         PEsHOPVnCgNc2CKpf8CXwZDaIGxilKiqz0FWNI5K6X4no3m9NoL3dq2DEIguQLdYZoVD
         HiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790662307; x=1791267107;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBoCCGhRsJHq8tUovZJTNZLbswHaHS+w9f7EhlXZncE=;
        b=USxthl8HZWBWCv+GC5zEhuKGfE8PxVVqAMYqg8OADBzVhK0O6EdUdudgp/mifkg4WS
         YSaPM4PR9ZjM819c9tXy/tUnMpOGc3vijROxtSgW9lJ+cbuYK8EnVeb52EY/TTKWzQGb
         cl5WJxtU9TKhjqQZjBf+CPWE4EeGuWCjLA05qMJh01kFSNYZoR6pAW8FtRC3CR2D5EyH
         E9FaQ73ujAGIS7wI+dyGVSm7j/5wnHXp6Uu4D53mQcqr9bJdOkTCeYCbSmsHF2O6Rjhz
         Mdl4GlVrde9Z6+58XzULoaPJe724h6KPWS3G4lLTmmRy8zmgeZoeClXsTLeQwsu76YtJ
         +7+A==
X-Forwarded-Encrypted: i=1; AKwUvBybj6k+XZWPMCYCLU12a1MtOrcB/RagN+JyKnlYaq0AmLPgQ10ggiOrFs2cSiDVP6bmuojHV0bP@vger.kernel.org
X-Gm-Message-State: AFq9FYJLG+tGTj2j4aqV432Hh0yWMHbTISykcFtesU0HV6xEDd97unzL
	sItCJa4eJFbHQD2s6sGkm9iwMQbskm1mx/97huSBQaC36VaUvZ1+kTTl
X-Gm-Gg: AYBFou3Wlhp2rKuhTVZQa2OJXqBiGRwlyl3Jlsh5XF12aIgmO54pmT+qkyFaqnq4qBu
	1ikRRjWcoz+FKJOCX8VAR5J6MlPRdtFRIXopDN6QHuF6q2yEcr1QTYb1FbRcVePLyCqNDV5PVSY
	WwqTg9CzV0H/RNHGbwBYi8eMgsoNibiYBy2YyL72Q83BFhOah0uRvfz4CpOXd9pxiOhanIa96af
	rAkZ0s75h3jPtu37dSVNfBmOpGw9VsadDrOKiyWBPYWCCn0lZ8gvEUrQ+Y5RrV2e3dRblTZeIbg
	cFGWc6G06F3c2ktFde8vn6bCzALVuuM1HCbQXMqki8egvtOIRYrO/7Hj8ZKuTueqTClRqLuPCIG
	02F1nvlt16TUnHTeuSKPEPYOtBZUFHltpfmTs8ZpdhMhSZDrzHLVNfCA3l5CM2oBIlbKnrEPcem
	sAgmM/HDzsxDhcMT+bC3Tio2DniX9+FgypN5xwT8eylAjV6KrjlZZ/if2Wo4NGkmfPanB89FPa2
	XVpULvNPtFaHG7uwEFK5o27/b3mIbY2gXqa2UI1O5/FH/ouZO2UAKtZLAKOzf8pi8EoBrFfcTO0
	QJaI
X-Received: by 2002:a17:90b:2d81:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3a0bb552feamr10274508a91.9.1790662306492;
        Mon, 28 Sep 2026 23:11:46 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4985fb0b3sm3308212a91.10.2026.09.28.23.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 23:11:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 06:11:43 +0000
Message-Id: <DLRKT5MG6W2P.2V1P0QD4GQEKY@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <kernel-team@fb.com>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: Trust the entry value
 register over the first location entry
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, "Alan Maguire"
 <alan.maguire@oracle.com>, "Arnaldo Carvalho de Melo"
 <arnaldo.melo@gmail.com>, <dwarves@vger.kernel.org>
In-Reply-To: <e3f30691-a5d8-41b8-a075-10cf8cf4bd95@linux.dev>
References: <20260925213619.2187751-1-yonghong.song@linux.dev> <DLP2WZASF7LP.18SWCONJDR4LV@gmail.com> <e3f30691-a5d8-41b8-a075-10cf8cf4bd95@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 26, 2026 at 10:49 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> Maybe we need to poke into locations to get precise parameter register.
> For example, for argument 'b', we have
> 	[0x0000000000000000, 0x0000000000000000): DW_OP_reg4 RSI
> 	...
> 	[0x0000000000000008, 0x0000000000000015): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
> RSI has location starts from 0x0, RDI starts from 0x8 although it has DW_OP_entry_value.
>
> But this makes things complicated, and there is no garantee across different compilers due to
> code gen.

I don't think it has to be complicated.
In your gcc 14 dump the first entry of 'b' starts at low_pc and it's RSI.
In scx_bpf_task_set_lazy_resched() low_pc is ...d70 and the first entry
of 'lazy' starts at ...d8b. RBP there says nothing about the register
'lazy' was passed in.
parameter__decode_location() already has 'start' of every entry.
Can it take the register of the first entry only when that entry
starts at low_pc and use the entry value otherwise?

There is no guarantee, right, but when the guess is wrong the function
is dropped. It's not encoded with a wrong signature.

> One possible workaround is change 'lazy' type from 'bool' to say 'int'.
> As Alexei mentioned in the above, clang didn't handle 'bool' well
> in debug info.

That works for this kfunc and for pahole that is already released,
but every other function with a bool arg is still dropped.
Can clang be fixed to keep the entry range?
