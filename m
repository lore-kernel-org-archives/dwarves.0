Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01619DF48
	for <dwarves@vger.kernel.org>; Tue, 25 Mar 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893853; cv=none; b=rYgH+Qn8cAUXcnRVXXIbRH6cFIdh8S34Z/wo8XSJXgR5TM6gVCKAzKvgyZmfmupzxdXHRm/UDzlBfBD/d0gZRi+CIiLrfp9bajqx2iM3d9OdxWklDno4Rd+yPMpFfwQFfh1LMyKa5XgzT4fkwi8GjkOcH9NqDWwm8vTT2dfy4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893853; c=relaxed/simple;
	bh=ouqDfxoTkI2QerAKY8/t5pXVjyqs8McnlFEtsFbOwtU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cHVxf1txLF3hJYiwwkK/B2EcQtRgQyZHNN/7ONwWY2UoFip5+sSqV9PJWHdlyUBp+H3yRLbAj1i6C5bCH1lgKTK+K80nRI8++9SyZjdeQykOF7ZfSbhxCN3R0jvZmboYSnO2gUCSoP/QkjcUDl9jwDpjIKFxCx9CDayZOmJXbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnATQGqE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnATQGqE"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so10308722a12.1
        for <dwarves@vger.kernel.org>; Tue, 25 Mar 2025 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742893849; x=1743498649; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7nbZ+IPZEFh41DTAu5rgapra7M3E69ff9ZCDeE3OIek=;
        b=VnATQGqEBaRvdZ/OdP4jfts6hInhKuQCvs3wJPlpU5vatw8GM7LFAiPeXbg46dqDrB
         sCUgLqlt3alJXD5/OnQZOLCB3AVKog+elnz358s7C+tpHw6+tnejZgZUmfo4a/Mvin8e
         G8pKm1IkuhiiBoT8WnGgcuNUHM8DAYM9eJB3IexdvZoXz2oNO2ICCFMbXBCIcG/Ghx2Z
         lL/zBnVyp3HzduSmZ6MePYvMk6L2is1rSizXPhdty8nM9YEdb2YBsOtXCPf/i1KHTyMu
         Tk1MlbkvKi75dS1CFeJpLVUKcjZ87YbWk2S+ZFJjv/dw+mOnHNFwjWTr3yuBsUpsQZTE
         T62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742893849; x=1743498649;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nbZ+IPZEFh41DTAu5rgapra7M3E69ff9ZCDeE3OIek=;
        b=AGVRtDaoPKQ9sbQdM1N5Lyd3t1zdhy98jFJ7pXXD/0H14UoNhDNAGwoN72iR3EwmzG
         xvgyaCb3Q2gva40efmRwVbsfVdBFt2X1vLQwqn6F70Vj5Pu3R8r+BKQz3LKte3bxxIdZ
         SQZ2xVuIaFJtkuP5/eGvGBt+xBLilws5RobjX42o/H6Ea7R390hX2PwEPPfF05qsootF
         1PCcMczKu7Kktb+OacovN/4CncaA6ppFO3olx9EKWZdMD6pIBlpyNBtbmLC/JCuFBn+H
         UCAjOJJxa1BT0wqA4jh88ODAdFqcii1CMDT9IxDQcsXnhWH/RMomcj1PnrGFs6BDF4AS
         dWUA==
X-Gm-Message-State: AOJu0YyTF+xl0oFtFha45NQ7THPJ4xtzBavcvVOdxO9fkQrQx1E36tss
	nNLByqvgvebWKbmIJNkfujro597JD13O6cUp4HHkhj8NNjaUhu9TY6eOQPRaPaXmyQ==
X-Gm-Gg: ASbGnctEvy9HLFs4aqD3ilBeVxFxow39FqDFHOYwi+Cse9knoFCPgGkNiKOFW7WpKb1
	pmWlgDgsCkdLWyr3EMoqpqHGNMScyaD/8+OfXK5NDftTKBZ5Z2DAlkoRS8xQoPk/zbBwRWcuvVW
	0nvspTYf9r1KHBbkjqTqNd7C1N2AVebZXrDhQ3pAqzuTf4JmWwVpgIsq/KNi3NuUMLFpdAzBoGy
	zM6v98nDax9HsSKbzskaBjn8HiBB6DdagjwhqYDdfe7T4WqbuQNg2ZZbocSWuGEmg5uxQQ6MQcO
	7FarQnRI+r0bPlMIMBz6hgbUk645nluDL+JPFFk=
X-Google-Smtp-Source: AGHT+IFLW5yLzvWUDX4/J+nIPoW1zUaywZ6xcTCaJASGHEtX+YVXpio2Zf86/oCkoU/H8YvRD8gSWQ==
X-Received: by 2002:a05:6402:51ce:b0:5e5:bb58:d6bd with SMTP id 4fb4d7f45d1cf-5ebcd431464mr12252810a12.10.1742893849031;
        Tue, 25 Mar 2025 02:10:49 -0700 (PDT)
Received: from m4.lan (tor-exit-36.for-privacy.net. [2a0b:f4c2:2::36])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf85845sm7497580a12.21.2025.03.25.02.10.48
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 02:10:48 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1tx0J5-0003os-07
	for dwarves@vger.kernel.org;
	Tue, 25 Mar 2025 10:10:47 +0100
Date: Tue, 25 Mar 2025 10:10:46 +0100
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: dwarves@vger.kernel.org
Subject: parallel pahole hangs while building modules from
 nvidia-open-kernel-dkms
Message-ID: <Z-JzFrXaopQCYd6h@localhost>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

  This a forward of Debian bug report [0] where you can find more
details. At [1] and [2] you can get the kernel and module to reproduce.
I could reproduce on both amd64 and arm64 using pahole 1.29.

This is marked as serious severity because it makes the autobuilder hang
as well [3].

Could you please help?

Regards,
Domenico


The command to succeed:

This simplified (sequential) command succeeds:

cp nvidia-modeset.base.ko nvidia-modeset.ko
LLVM_OBJCOPY="x86_64-linux-gnu-objcopy" pahole -J --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_features=distilled_base --btf_base vmlinux nvidia-modeset.ko -j1
echo $?

producing this output:
===== 8< =====
dwarf_expr: unhandled 0x12 DW_OP_ operation
Unsupported DW_TAG_reference_type(0x10): type: 0x28172
Error while encoding BTF.
0
===== >8 =====


While this (parallel) command hangs:

cp nvidia-modeset.base.ko nvidia-modeset.ko
LLVM_OBJCOPY="x86_64-linux-gnu-objcopy" pahole -J --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_features=distilled_base --btf_base vmlinux nvidia-modeset.ko -j2
echo $?

producing this output:
===== 8< =====
dwarf_expr: unhandled 0x12 DW_OP_ operation
dwarf_expr: unhandled 0x12 DW_OP_ operation
dwarf_expr: unhandled 0x12 DW_OP_ operation
dwarf_expr: unhandled 0x12 DW_OP_ operation
Unsupported DW_TAG_reference_type(0x10): type: 0x28172
Error while encoding BTF.
Terminated
143
===== >8 =====


[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1100503
[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1100503;filename=vmlinux.zst;msg=19
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1100503;filename=nvidia-modeset.base.ko.zst;msg=12
[3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1101262

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
