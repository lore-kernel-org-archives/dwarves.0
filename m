Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F33769EA
	for <dwarves@vger.kernel.org>; Sat, 26 Sep 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790408709; cv=none; b=qWBpIfRxu3pPC9pUniNcUktmDdcgKnsX/+f6C2zV20fWucsGVrQ6tR4DfCVuwwlTnUyA8rn+9uRVXXvlrSFvMvkS2sKwLZtlFSDDiBsPiuV+L6QQTILzbgosKMgxwFk/+Vdq3oK/YBRZd4Tnfh1DQC80E7itKpsM+dYw+kbfWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790408709; c=relaxed/simple;
	bh=ABbBkCwR1L/1FDbrX2Y39wbgpE5rQTRqAmD8tEgS8EM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=iVsNWqHBi8bDO55jHRwLbZSXMXBWnZWwqrVDYy0wGiUhwRpqd5hZSDzt+hSguC2vC6h8pImkJBO2qvrY1A8xkzHm+u5WXQvmbhAVxIxpV2GDfT//VWOQRZaZPwu6U95dI9XgAuXdrq+Nq8aKXO+IAm7nHWU1TPmQZwkOV4vutkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdJXl6Lq; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdJXl6Lq"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so952566a91.1
        for <dwarves@vger.kernel.org>; Sat, 26 Sep 2026 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790408707; x=1791013507; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LCtZEcIvPL3Lbhp/UPKAeuQpnUZP+5WCOvYmqhIHVAE=;
        b=bdJXl6Lqu8/jJCbTAR8TIuq6Mm9idIyDw6zmpRlxvfOMiQfpm8dKXh1ezzbcvYuYAr
         HRQqN3Y+jVWbQhsbKfm+rJ9R55hObUw90kvF6vT6rjhjtbhzs4m0/qlTuGKNS2PDG1UR
         JMnHgBQ8Pzx3V1hwSzTAiMSoaFyZeWBVfkQazxaHOEL0A3yYJnCnyaQlJlYwawIOVhov
         W/uVHUJoVHUMs/ZsUPqwcLDA2WIFv4gFA+wzMx2sn8xP72V9GIAXBds/YNNsrRVpnwQR
         +BMHhppQ4fCT7Y5RHgXQZtc9zyEwb3eV32bjSfjB5TJ1iwaK+kvGWGOo0Go5EL7rW8Ej
         Tmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790408707; x=1791013507;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCtZEcIvPL3Lbhp/UPKAeuQpnUZP+5WCOvYmqhIHVAE=;
        b=i3Qv2jcRf21m/USNXh1ehCDuhb0AU8WL9sHbJDbKLc0XqZ0p8HvQA0M1GQX+tlIj8I
         OhRbtBxknWEcV0cdUhiXv/74jcmYK8EJMj+7nbjTGxVUS9vDo0sebmw9++Tf6y+Lkq4O
         6A3tKnRKEYaatIZCv2t7lmBCKxl+HqTnHNotqoKYAx/pZBdl5prBLYJaXA1Mi0BoIbvs
         ClFQanDtqqy8gzo/WUaTxMcl4qZUFWZnAShYrY9Zso21m3ktMNA8aoHIwFv2xXyjqedd
         AHTxR5KFdczUjvoW3Vsj6EfNK3Pv2HeD4DGcMtuOi70VVBrjoBfxGBh/Ya9clU5T3hjd
         A/3Q==
X-Forwarded-Encrypted: i=1; AKwUvBx45jbvSUZKqf38vIJ6UmXYivCbH4Uyy1cr6TVAtlHSy37ZBcJIRpNQBkBERdO8kRyS3nPk0r5B@vger.kernel.org
X-Gm-Message-State: AFq9FYLVnIdwRhrBwX5OR3cjvC1NqDB+p1mFKD7L4ybMuhx6BCed5dgA
	MyVRTsXcoLI2fsGCPrjNVRCByxSAbIIsh4yBNFk14z21EKvnl8syQzbsCyV9gZ67JHw=
X-Gm-Gg: AYBFou1jnMOKfuSX67KyLOU3y47dxec4VHK76H+1AxwQI4LAE5yJbh6CumDq7yrom1m
	dXjYYBRB/8cBy2yP5ifxNcQP6kqooh4wgdjSEDRGohC/Zz2WMsVspk8NgYLRV/OA01D8CB5o09g
	XT/vKGFfirnoryZY2bG2lSrHmZyoOIaKGYlrP9Pd122tug0UDr3gJcsHCdnvAXRE9up+oAuPdm5
	0++NkFtobxl0/B5gZ2csc3Gfawu3WYSecE29YF1PVRn6l8DxX9psUkig4dY0n1endQlo3S1Hx4F
	WeOVsQAYGjRkEhsACb+rUX6SWPpRGGL4Ly/XKPrBJHY4zCQdrMkFrUTpfPfic/n3MHnuyn6nIF3
	YWunlq7jLyWpXkARTfREd7+eJ7HBygVf75Fqm9fY+ie1s4rj7REI2FPnZmn6R6ni1ozZe45F2GJ
	cO3XufQXlifBt2Yr6cYNXas3F1KT068vd7vw099Mr4/YXhXX/tEmunNoHjRwAGWcM3b2qJSF3Ic
	eU1519uuwStf8ngGPhHCn8oa1BYPtmYD2bDGqcvt1A8WfyRibNDotEHEVruiXmU94CP8/eJT2Dc
	ArAkH6SXiy+tp4s=
X-Received: by 2002:a17:90a:c08:b0:3a0:b3f3:a2df with SMTP id 98e67ed59e1d1-3a0b3f3a396mr2867019a91.13.1790408706906;
        Sat, 26 Sep 2026 00:45:06 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589bbfsm8695818a91.9.2026.09.26.00.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 00:45:04 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 07:45:02 +0000
Message-Id: <DLP2WZASF7LP.18SWCONJDR4LV@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, "Alan Maguire"
 <alan.maguire@oracle.com>, "Arnaldo Carvalho de Melo"
 <arnaldo.melo@gmail.com>, <dwarves@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <kernel-team@fb.com>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: Trust the entry value
 register over the first location entry
In-Reply-To: <20260925213619.2187751-1-yonghong.song@linux.dev>
References: <20260925213619.2187751-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 02:36 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> DW_OP_entry_value(DW_OP_regN) says the parameter still holds the value regN
> had on entry to the function, so regN is by definition the register the
> parameter was passed in.  That is better evidence than the first location
> list entry, so prefer it.

my bot is saying that this is not quite the case.

gcc 13 -O2 for

long f6(long a, long b)
{
	b = a;
	ext();
	ext();
	return 0;
}

describes 'b' as:
  [0x40, 0x44): DW_OP_reg4 RSI
  [0x44, 0x4c): DW_OP_reg5 RDI
  [0x4c, 0x59): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value

pahole encodes f6() today. With this patch loc_reg of 'b' becomes RDI,
RSI is expected, and f6() is dropped.

> +	if (entry_value_reg != PARAMETER_UNKNOWN_REG && !parameter__has_piece_info(parm))
> +		parm->loc_reg = entry_value_reg;

This fixes only the functions where clang happened to emit
an entry value. clang -O2 for

bool g_lazy(struct task *p, bool lazy)
{
	rcu_lock();
	__atomic_store_n(&p->lazy, lazy, __ATOMIC_RELAXED);
	rcu_unlock();
	return lazy;
}

describes 'lazy' as:
  [0x09, 0x1e): DW_OP_reg3 RBX
  [0x1e, 0x21): DW_OP_reg0 RAX

low_pc is 0. There is no entry value, so g_lazy() is still dropped.
With 'int lazy' the list starts at low_pc with RSI.
Looks like clang loses the entry range for every bool arg.

