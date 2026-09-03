Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2050AC0D
	for <dwarves@vger.kernel.org>; Thu,  3 Sep 2026 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469102; cv=none; b=Egi53Gg0ka1ObXtWAxP2Ryj9bO1QYwDLtPstFILn89K/7knuwwZ08CKb9Dl4CN9ykRbbbTCf1FQhnbnrAVuKXsV5v0Yw8zRMoQyUUs62xOET66+jdFKI4sY7nsMyZ+47rGwD95mo32boQgfogqudjRPrG3GW04YJE4lzsHtOQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469102; c=relaxed/simple;
	bh=T430kycV+mAQ8sDc2KHFixf+dRNBn5PZkWRxWklgjjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oiP9hAjOvk6/haDYRSwItMAtSFHy/ZxkqKSH7d3oFT6Y7Fy5D7W94hQOLZZ+xjCh97A/3qbeKvu8TY1jjT6Ijqyxnnfyld03zDAb2+bwcxlhlFw0kiuJJIfoWW342bnVoUFTdGR+ewhqW93JqsJ1jwme4bM0gzLL4CzCNbzSAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnRb5vf6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnRb5vf6"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-395cf2535acso315062a91.1
        for <dwarves@vger.kernel.org>; Thu, 03 Sep 2026 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788469069; x=1789073869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HtC+QBd53HYcUniw5Cllx8g1ml8CEXRFszGKdFROICc=;
        b=TnRb5vf6JDnzwyU81Q1ZeHF44x6LXumviqo5Cx5gpFBOSw+qq9+YL8NfN94CF/qT8D
         CuPmC6vBSbtJEZSparRREGxOcL5QEYu0wM+aqcV5lrfAy2pPY/JzSMJSvS5wPzkmUBcw
         S6S4sqBPnO3OpugLWLPQNSgggndTLhQYeD+6z7612Y7xluTOcfbMeKu82/4DWOLKc0p/
         Z3fRJ62INWN26EJ5iLGPNRvB9MLqzZ5ObQ2E/+p/vfMeFRGxuGZj9NX+OUbcdmHw6izX
         G0f8s5JbWZ6kuFrEbQSLrs9HLf6LTpbcumk4e+mhayMZ19TYHjzAZvNX+RuY3UrWaqxn
         +35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469069; x=1789073869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HtC+QBd53HYcUniw5Cllx8g1ml8CEXRFszGKdFROICc=;
        b=VPrJT7njo7HVgRId6zmmITo6AGhRpuWpoEdG1W53viRFeTcObaA5oLdyckB29nKINK
         SaKa8lwfAWEHg+IK/Wg0Faj+QYj1qste1+1OVdf4FI4CWbASgHevfTvHhDXpNQA+GOor
         ZM10CHUeUXuq58R/blGD88uEHzRVRm9w01GTP/LrIED7XNcmJtWR44hl6QWDvXzpLCSN
         phzDiFwr90H+hC4k8ClhZWWHcl5I2eo7lS9PLPPuBeKoaCmirfnStiOFzfi+SCKvQ1g+
         1zWhDt0a46t/WUae1C/YsHTE54LSC1sfj4mrkvkJPDjCuqqoqDjPwqcdKbue3ZL2VE52
         2nsQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+q61A4dMex3EA72eCdPNpnP3msj9joG1dlPuGmMnhgTJmPfaeBb/DBEgOI5YzhBuPLG6t8DRR@vger.kernel.org
X-Gm-Message-State: AFuF++l7xuT1WfW/RIOTuYUyKOLUgAJOBgU36r+z1P395ztoOM6mIjx0
	bEw1CMDLt7xoW8FCATssDahfUs51GFkD7fYYW0h8sH2Z2pi2nwkpIUzl
X-Gm-Gg: AYBFou3FD7NUNYGqY+BzEA1FKkJB7tEgr4bdww2+zp6RTVMB/Jk3UpZ196IjUW7qRBy
	VK3UR/aQBH4OyszkhoczWy0BmEFAiCZ+XX7pW+RNU5e/QlolYk0NZuVVMEHAJfJXw4PUvQrXA9K
	cihFmwwZBuCuHGtKpPfCKFgk+Qxm2E1U8fLrYb3gFD0TtUrhCajuMmd9RpiULy6rhJ8u0w5G5L0
	YhwTdozpqj9UVD/fpDnUPltSk8uQs4B1M2KOrYgi25ZxzjlIxfS9zr6WynFJ4q9pXFlk5Pief+f
	AjFtaDzf+Fjpqra+5TLPQaG+a3UdGMpuVUHut/erJY/ecEkntz/+w6mTz7N4tGkWh3dCUgqsWVc
	N7pabRmrLEITIhgWz9yvlSf8RocUNEeoxbLRgcSwuxvYv8WfEzYZim24wjRqjWg4sPjfDElzEIC
	yW5i2IfVdE6pRXw3I+5rjwoTaTH1omloA99yAp3CHZx91lF3eblXbgYwg6eICjMPKo9GNlt4cvc
	0/QtKxER8VdNjXg+RNj
X-Received: by 2002:a17:90b:4d91:b0:398:c6e8:3fc2 with SMTP id 98e67ed59e1d1-39b27c42b89mr382952a91.4.1788469068977;
        Thu, 03 Sep 2026 13:57:48 -0700 (PDT)
Received: from pop-os.. ([106.219.234.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm753185a91.4.2026.09.03.13.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:57:48 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] pahole: Fix option name in the -m/-C error message
Date: Fri,  4 Sep 2026 02:26:58 +0530
Message-Id: <20260903205659.1543175-2-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903205659.1543175-1-duttaditya18@gmail.com>
References: <20260903205659.1543175-1-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no '--class' option, the long form of -C is '--class_name'.

Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
 pahole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pahole.c b/pahole.c
index 83ca321..aa04d98 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3662,7 +3662,7 @@ int main(int argc, char *argv[])
 		return rc;
 
 	if (class_name != NULL && stats_formatter == nr_methods_formatter) {
-		fputs("pahole: -m/nr_methods doesn't work with --class/-C, it shows all classes and the number of its methods\n", stderr);
+		fputs("pahole: -m/nr_methods doesn't work with --class_name/-C, it shows all classes and the number of its methods\n", stderr);
 		return rc;
 	}
 
-- 
2.34.1

