Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C97DA92
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724715099; cv=none; b=arQq7opAgCBdqOIqq5g6ZYDr9f3uftZXL8Ed0ZEQCCzMObdDDQfkwfScYPToSh8MCJ2fpT/0nNqOVf0MkvzEV3Z0jQnkahC7HymDqJPOlnGN/n/+fOem7moivoUPya+4RKJd+60AfRKD5kibxyXqo9JXr/GYrKwM77rrc5bioDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724715099; c=relaxed/simple;
	bh=hTbGVLGP9Ym/O7GLSuwUN/A/J45Vx6m7K+R6pmAzmdE=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jqQYW2W5bi7DMheSHEayYBDyUbJaw6plvOqa3MX1rJH0BIGrUred+PDxMaaUow44MB9qWTikG+DecJIMQ2gC/LtzgdBRsivYUtSt9lc71VPpYBWP2POqAkOfnykz4MVN/wYxSnGns9Ldu5lRffeZfBBqVZ2p49xYfiSYOODUCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw/lvLyB; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw/lvLyB"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-27022a3536dso3734503fac.2
        for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724715096; x=1725319896; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqpIKb0LfeXEdTFL1g0Qu896N5CjS8S322LXjnAAP+M=;
        b=mw/lvLyB7uydwlTiI+HP0UUKHyiru6RwQjJ440PhnpczQicgacOb68wsuCghL24qqI
         yXlYn+Vhc670xj2NAV0OoShBmRkaJWXAPpnVsYx5twKgpxDMHkqe/7P0bXaEVnsI6DW7
         Qa0YbUrNriZ8obYVgbuSKbHHiVGffiG2Xw9XtEk3FbKaa+jd6ULbxATTn2wZ98TPmDuU
         Fjh+BLyQSxP4Wn+uPcNcwsJAbLn+u/AICC/WrGlCyHZDtCfvdiUb3ypPgdf/WRAqQTSb
         /iI6ZtP2XPzUdGXRQFwmFB1pKrXrjcCNYTfDSo5WKCB/lFPitCHJRF+wMs8nb2b4P/4l
         T7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724715096; x=1725319896;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqpIKb0LfeXEdTFL1g0Qu896N5CjS8S322LXjnAAP+M=;
        b=HuHq0gDXwYTxRgvXy2BgwuVu9UBHfRRyGS9KT3lV3GXv5r4WEkrr6twsSzHxcQrm0Q
         hWX+dzgfHO5rWP7GOLQV+eKHszJoi+zy/SIPpvZS9dJFvx7Omzmfha4ZFM34oDpsI5s5
         7OKgy3KMQqztC3mqGuvw6mWKG+c0c2UdGCm2NL31C42v9SIDnE2guRgVe6A5a0ysugZS
         zfT1w0THHOmZyvejZQrjNLS4d+heWzD7Csba2/mMAFxuXp49Opl9cnNLXY3dbCUGMYdw
         Z0V3GARXBJt9mJFQQnRi0oscX1VDArP7bdQiTxc6g4L9AUxCNJHEu8YX86L4FFesEL47
         anGg==
X-Forwarded-Encrypted: i=1; AJvYcCXse/scwy+LrF6R/aWSMDOPEJOk0hvyhKUKbOTucxI8JAF64xWK4AFar4NBw4SJ99Xu1C029Y0G@vger.kernel.org
X-Gm-Message-State: AOJu0YyCYlAjH7ulJIZ9P0juqYz1v52MT/uZMIc+ctj8kr6Us9XqWvnI
	lMCNC6hmzviChrs5ZmqgVTP2Yk5sw/ec4GHS5FyJ9X232epU4Xn5Lcj9KEEr
X-Google-Smtp-Source: AGHT+IEp8GKXJ3lWVSiPOb0xY57VR5v7YmEPGufLWgRVaVpF0R2b/lJPp1+5zyFOjIZnbinUh5SW8A==
X-Received: by 2002:a05:6870:648d:b0:260:ffaf:811a with SMTP id 586e51a60fabf-273e63ec243mr13015740fac.8.1724715096085;
        Mon, 26 Aug 2024 16:31:36 -0700 (PDT)
Received: from localhost ([138.0.199.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acabac9sm7022384a12.28.2024.08.26.16.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 16:31:35 -0700 (PDT)
From: arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Mon, 26 Aug 2024 20:31:33 -0300
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
	dwarves@vger.kernel.org
Subject: [PATCH 1/1] pfunct: Print DW_AT_external=1 functions once
Message-ID: <Zs0QVVZZfN9H7wQC@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Namhyung mentioned that 'set_task_cpu' wasn't being printed with pfunct,
that was because those functions (with DW_AT_external=1) were not being
printed at all, out of some wrong expectations, this was added to avoid
printing it multiple times to allow for things like --compile to work,
but that was too much of a big hammer.

So add fn_stats->printed and use it to determine if functions were
already printed.

Also don't print definitions for functions marked as declarations, as it
clashes with the ones in system headers, like __builtin_memcpy, etc.

This all needs a more thorough love and care, but at least for now
--compile works with 'fullcircle tcp.o' (generating the functions and
the types it uses and then compiling it to get the original types and
functions and prints the external functions:

  $ pfunct -F dwarf -f set_task_cpu vmlinux
  void set_task_cpu(struct task_struct * p, unsigned int new_cpu);
  $ pfunct -F btf -f set_task_cpu vmlinux
  void set_task_cpu(struct task_struct * p, unsigned int new_cpu);
  $

Reported-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pfunct.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/pfunct.c b/pfunct.c
index 938dd724e44a9416..bc3026b384284cb4 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -49,6 +49,7 @@ struct fn_stats {
 	uint32_t	 nr_expansions;
 	uint32_t	 size_expansions;
 	uint32_t	 nr_files;
+	bool		 printed;
 };
 
 static struct fn_stats *fn_stats__new(struct tag *tag, const struct cu *cu)
@@ -95,11 +96,13 @@ static void fn_stats__delete_list(void)
 	}
 }
 
-static void fn_stats__add(struct tag *tag, const struct cu *cu)
+static struct fn_stats *fn_stats__add(struct tag *tag, const struct cu *cu)
 {
 	struct fn_stats *fns = fn_stats__new(tag, cu);
 	if (fns != NULL)
 		list_add(&fns->node, &fn_stats__list);
+
+	return fns;
 }
 
 static void fn_stats_inline_exps_fmtr(const struct fn_stats *stats)
@@ -366,7 +369,12 @@ static void function__show(struct function *func, struct cu *cu)
 {
 	struct tag *tag = function__tag(func);
 
-	if (func->abstract_origin || func->external)
+	if (func->abstract_origin || func->declaration)
+		return;
+
+	struct fn_stats *fstats = fn_stats__find(func->name);
+
+	if (fstats && fstats->printed)
 		return;
 
 	if (expand_types)
@@ -393,6 +401,11 @@ static void function__show(struct function *func, struct cu *cu)
 	putchar('\n');
 	if (show_variables || show_inline_expansions)
 		function__fprintf_stats(tag, cu, &conf, stdout);
+
+	if (!fstats)
+		fstats = fn_stats__add(tag, cu);
+	if (fstats)
+		fstats->printed = true;
 }
 
 static int cu_function_iterator(struct cu *cu, void *cookie)
-- 
2.46.0

