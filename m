Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE74256C98
	for <dwarves@vger.kernel.org>; Wed, 19 Feb 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001330; cv=none; b=BqhrAebf92qLy99nYfkIXWVg3934o+g/2P2ctREoDZqaaJZSY2TVX7LbUf1OGSETT2vNm1nrJ7jRfRzQ+vS9p7b1HJwHXQPwp3VadOMeorMwD9twcS3hgwA80f1rNE4V4HbiY6u5bUb6R6Og2iZTaX4V+esE84JVDOJ33O/h6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001330; c=relaxed/simple;
	bh=KvzdbWYnu2chtTnLzLTllw0jpbhUGMOQ6Si9OC9REVk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=J05/ae4EgVawa5udC0Ujwquvs+x12lnIP8tfJ/dpespuzunDzmNToU6Gk7nz1SQ/1TQnd/h+MDZkmrVFsVoXii0SAOGJv2AF/w4XtjzbUR7yhPBSQHYgY/oZRIPurqiN7RCAgom/yu09SVcDrakj1mT6KF0X3/6fxAFezmvCRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cPrtQNYB; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cPrtQNYB"
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740001324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvzdbWYnu2chtTnLzLTllw0jpbhUGMOQ6Si9OC9REVk=;
	b=cPrtQNYBbcITs2jsmt6+j/pEQfk2XGkz30gBsyltAqB0nmLMcqK/qEk/sxTW5MY0kwTZ/+
	XMfSWkihRxTQ8BjqGJJAJkHj8uTCyNKNVnA+VnjgmS+yAPXgnUHuYpvPP4yyxcBRCqMOp9
	dnuPx6skfx7N6D1YmHSkviX2qxTbLtE=
Date: Wed, 19 Feb 2025 21:42:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <959439509729b0d29c3ab48997bb8956c329f2e1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 0/4] btf_encoder: emit type tags for
 bpf_arena pointers
To: alan.maguire@oracle.com, acme@kernel.org
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
In-Reply-To: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 2/19/25 1:05 PM, Ihor Solodrai wrote:
> This patch series implements emitting appropriate BTF type tags for
> argument and return types of kfuncs marked with KF_ARENA_* flags.

Alan, Arnaldo,

I accidentally put "bpf-next" tag in the subject instead of "dwarves".
Please let me know if I should resend.

> [...]
