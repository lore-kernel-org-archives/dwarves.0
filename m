Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A1EAF6
	for <dwarves@vger.kernel.org>; Tue, 27 Aug 2024 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731755; cv=none; b=KNz7TG8VeFoqZzkNeWg43fDWa+ad92leANIIHT0CavThF0/+x3VyZjJCGA8PqyIyheb0Asq9iKq43+yYBNwhWa6ZYNh4GPQe/Oym+KWYcmC2MZVFckJbBCkl/XcObcFpsm5JgGBS3sPjEbEgmWZuSy2MI7c8oTA8GOhUcHr0UNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731755; c=relaxed/simple;
	bh=4nx2xjDZvp2EfelSCfq2Bl/6OmdqJrnkluY/MdKqT1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuQmtr5Ez4fu+J8vJdlji7eIafSCIDcwThF+qfAYjcaa0rSRWbLbyJQuThOzzAykzs7JUGmvOqtVXlKrfXtiQ777U8LEkqbu5pj2P2J9GDblxGdWSlVc8WJ9ajTKp52UJ6caWdZhtVmdgxmjChQIKBpWYhhYiWIJDQd1uVbjnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=175I6+ck; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="175I6+ck"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d4161c398so20956115ab.3
        for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724731752; x=1725336552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJ6G9Z6I07/fuFXuKk9Txy3UVlHSSJPPrd2txn/9xIg=;
        b=175I6+cku8Uc4aUtAWlyeObW9LjFlEHElKzmml96SBTX4Qxl+FStWlZ9DPG9Riw7sh
         0JzG1VFwSVe12i+ZvCpDBJJV5llYCYPhmzWlgpgprROCqcUx6mOIAhhPuKQgjGAIws2o
         05QtHqDxdYDHQsY7no4eqH+qsKT7n9v/MTU2HIcG6aYMlRlUehf9DO6KjQiotDxf5+8P
         qZcSAGPFw0yHJDU2bVJLGk4Hfha9DWh3ZZ118d34NZ+FaOEEdwCux86tu0UT2iABU1ZM
         63iA6pi/Q7/D3sRo0yv0YR5PoiLp86UtJWZwNA9egNui4GLCDgKNSHXZV7riwwlMoo/1
         eVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724731752; x=1725336552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJ6G9Z6I07/fuFXuKk9Txy3UVlHSSJPPrd2txn/9xIg=;
        b=Uik8+4i06dJyogqVBfiNIrXsTRevU/zFUHhqJpgR46FP3/j6ORlQEJ4+tNCzXhb6uY
         iml7Q9D+GcQX5my3/wRNcuwqtumrGtMzbzsjkAWrTe0T7PD+6fH6pi6I7BMmJASy0FXV
         aaOxnCnacoZea6kpCLEngPD1sH18qjMboPFsY4ZMMhe/EzbgSc9qGnHhiTIWA5PefzLU
         i9Ye4MyMLS92vXAYjRgMXMeZPBKj9BwNDesNOqzRXoWwY0tjxgNJg0uGDTSx56ZQ+oVF
         pJ+gIornfWqRC6qykXYM0Yc0f5b66nYG5aVp5oPrHz3+e4cH7f8yNXCVZGCANrhn/Q9k
         upYQ==
X-Gm-Message-State: AOJu0Yycr/EZcscPRYE+C8SoyN+lrrsETJVNs92voHhFM6sJqd6Zhz6k
	AvmKBVmifZlUupbdchQfjzzL5UFP21y1NuI7JHUJQs9zv3FKgYFfKCMB+fFrKMpYVzRuxOLB0Uf
	e
X-Google-Smtp-Source: AGHT+IEY5/WWHRdjhxCzp8MZ+KsK2cedtYeJdWZRtBaZck+1JSUMbqSnRIcV6WIRTsXa0Y1bG3vHyA==
X-Received: by 2002:a92:c54f:0:b0:39a:e8cf:80d0 with SMTP id e9e14a558f8ab-39e63e3a07dmr19510115ab.14.1724731752045;
        Mon, 26 Aug 2024 21:09:12 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d73e68e55sm37262255ab.6.2024.08.26.21.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 21:09:11 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: dwarves@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH v2 0/1] btf_loader support for subprogram linkage
Date: Tue, 27 Aug 2024 00:09:07 -0400
Message-ID: <20240827040909.1358861-1-hawkinsw@obs.cr>
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

Thank you for the feedback on my first attempt. I believe that this
attempt is better. Given the feedback, I

0. Removed the incorrect use of linkage_name field;
1. Tried to maintain the semantics of DWARF as much as possible;
2. Reworked how BTF information is loaded into a new function based on
my understanding of the semantics of BTF_FUNC_STATIC, BTF_FUNC_GLOBAL,
and BTF_FUNC_EXTERN; and
3. Modified (slightly) the way functions are printed in pfunc to show
linkage where appropriate (based, in particular, on 
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=45153#c6.

I saw that Arnaldo and Namhyung have made similar changes to the
printing code so I hope that I am not stepping on their work (sorry if I
am!).

Again, I appreciate the feedback and hope that I was able to address it
with this v2.

Sincerely,

Will

Will Hawkins (1):
  btf_loader: Support linkages for BTF subprograms

 btf_loader.c |  4 +++-
 dwarves.h    |  2 +-
 pfunct.c     | 15 ++++++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.45.2

