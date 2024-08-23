Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676E80C02
	for <dwarves@vger.kernel.org>; Fri, 23 Aug 2024 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448522; cv=none; b=jj7wKPKwcgJo4b5MCTLvUZ2qg+OGa6KfFgl5WmfVjjMUvt07MdokhlUKCrenZGX/3ssxrbZkEUvHWA3J6T53fNmzwJC1x0iIjXTsrtzox3GoDjeRSNoqLOXtYFhSc2h1wzzhqW90ScTUjNaAOzyhrH3YovnHAwLjJlqP9sEUfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448522; c=relaxed/simple;
	bh=NfsxLQcVeMS6U0wUco8ofo6M4HMEL2Q4s4SN/0fOtdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVRft4hWQI8e3UWenueRgaBNOVtgZfSBpreXihE/lzQHKKv07jnOozVNoq9jHC59/JzjpfkGm9h30SwBKL6+lECS6rISeNPjEMdtUu4XlsvHcGiDmnkWNbIlno6Rlhm3VGbXpFg4IxBGpIb7s63zMtUjOB0JwrUeS4KYoBA+tY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=s5QfDd9v; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="s5QfDd9v"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70e00cb1ee7so1785519a34.1
        for <dwarves@vger.kernel.org>; Fri, 23 Aug 2024 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724448520; x=1725053320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oej+lrTyjB8ipsbaQA7JAkzh2MNOWtjI07nwe8Kzt+w=;
        b=s5QfDd9vl16crz4AIeh9Fj9rL3W5u4aY/+MFi/lZAZqQUZ8t7KLGkMG5reiPzcd0Xr
         vZU9rwEDPivCt6bU/1rZRhALEA4MvYvsbZqcpzRkfBovU7lm2VKGGrUNzcUwLDXYEGpU
         o//MIIK6UVMnWDVovqvInHnOPhnQEOX01Qp6p9LBeM5x/EbNqoTEjED5z5xsPg8Lmjkw
         AtT3SwUlUJISWNZQNNiSCbm84Vn5MUkGap8fwwp10J30gcVtepMITjDDMQBCjXbGAxu3
         MbWyYEYkKcXvo8uFCSgIiqL/EMik1sBHt4DjeUz+0vug6qDM5QC9BmC6vGR5j/gcaYi8
         r+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724448520; x=1725053320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oej+lrTyjB8ipsbaQA7JAkzh2MNOWtjI07nwe8Kzt+w=;
        b=N1nFf7Prl3oqt/Yua2DMFp+v9hiUicvZY74UvsTsV5xqJkT71AqWOBHoRa1Au86mPW
         /xoDZma7Yn47p0ND7PodUIFCrMvDdOdGzPVfeedAMvJxQbKnEH/m3dQ3heKscwuC36yh
         QczfGr3YRlLLrJXHYCB2CcSUnFirboUa2swS87XIroSv/hn9/9McRt7y2iKglk9pVmVU
         nMvTqP2WfkLvzGuHKq4XsmJJsj55io0Hqwr1LfJa4qwy/7/MGCYN6iR2QaMBbfMjyF1x
         zgXB6GK4zG6uQlyB5QDadUNqgoRXCESBRJGjpnrhrkGlWX246oif44Jvm8RtQ+MghHwE
         W4OQ==
X-Gm-Message-State: AOJu0YzTwkT8DA9UKC47WCs3lmXIgWQIoF4qm46S6AmlsfcPZ/KdJcoT
	iNy3pYrYHWOe1FlpdM3uthmex02l3vRBSfcFw9fs/9UoeuWP1pesdKzCa6sMH3bEiSlrjwe7Qa1
	E
X-Google-Smtp-Source: AGHT+IEzjx1LOdbbE5ST6v7q4+DN+N78xPMrWpCdKccTojhEX2TEPxAo8l964sdpPSX3gH/se9uwig==
X-Received: by 2002:a05:6830:6f8a:b0:709:3b70:3bb6 with SMTP id 46e09a7af769-70e0ec0e6f6mr4667477a34.28.1724448519927;
        Fri, 23 Aug 2024 14:28:39 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce710bb1c9sm1114893173.129.2024.08.23.14.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 14:28:39 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: dwarves@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 1/1] btf_loader: Support linkages for BTF subprograms
Date: Fri, 23 Aug 2024 17:28:31 -0400
Message-ID: <20240823212835.1078351-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823212835.1078351-1-hawkinsw@obs.cr>
References: <20240823212835.1078351-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle static and external linkage for BTF subprograms (functions).

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 btf_loader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/btf_loader.c b/btf_loader.c
index e0d029a..488c757 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -30,6 +30,9 @@
 #include "dutil.h"
 #include "dwarves.h"
 
+static char btf_linkage_name_static[] = "static";
+static char btf_linkage_name_extern[] = "extern";
+
 static const char *cu__btf_str(struct cu *cu, uint32_t offset)
 {
 	return offset ? btf__str_by_offset(cu->priv, offset) : NULL;
@@ -87,6 +90,11 @@ static int create_new_function(struct cu *cu, const struct btf_type *tp, uint32_
 	// for BTF this is not really the type of the return of the function,
 	// but the prototype, the return type is the one in type_id
 	func->btf = 1;
+	if (BTF_INFO_VLEN(tp->info) == BTF_FUNC_STATIC)
+		func->linkage_name =  btf_linkage_name_static;
+	else if (BTF_INFO_VLEN(tp->info) == BTF_FUNC_EXTERN)
+		func->linkage_name =  btf_linkage_name_extern;
+	func->external = BTF_INFO_VLEN(tp->info) == BTF_FUNC_EXTERN;
 	func->proto.tag.tag = DW_TAG_subprogram;
 	func->proto.tag.type = tp->type;
 	func->name = cu__btf_str(cu, tp->name_off);
-- 
2.45.2

