Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973961917D2
	for <dwarves@vger.kernel.org>; Tue, 30 Jul 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379446; cv=none; b=OksH6ZxE2ZVwJH9SOigQ49AvYRHiaCqXDNN3NRkWcX9B9u+djciVGGPQ/ZPz3sWh0aoP/tN1vxC7UfThQudNdZS8tlNcpIrvIAsudBn1x+ZqRc0ip875/yknQCcn9UjUu2onDXkvLmzAWFKmmeXQ2+vepvetFJx9t3AzIrXKAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379446; c=relaxed/simple;
	bh=TaOuQjCmRa/f2uxkkHdwn9N7dLnJsN/fT8I8JS34eio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sbWbkQoGrV/42bhnO64lCacRTWoxU6PKf6J9QjmDNzpNkfiaxMo0npc3JVQ0yj7q7ia70d9gt24g/JYuS/DZK9VPrn1ZFJVk7w5nAh8vrMAoQ9GSU6IfIEhkFxMESZGoayKWemQ2YIVImhp0J4VZoMmZj3ARIHNZ+J2RoUH9wfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGqHKUu4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGqHKUu4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66628e9ec89so96162797b3.1
        for <dwarves@vger.kernel.org>; Tue, 30 Jul 2024 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722379442; x=1722984242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6rLogURdEUgVuohDxoI/z6kah3N3XGw4tvUvw1JX3Aw=;
        b=hGqHKUu4DhlzNKOt4QElOwBtNHNEEcu8v1WCw/unTr0dnZOsiru52Kwsopo3jMvdMb
         /5Bk6ggTv4Z3hy60UW92YnFsO8rM3V0rbfzp1H+fwjM+Er4JbpSTqfDUsz542TbKbzYv
         j7CT+Dd0ahz0Hl1ccpj7PQuQUKpAuVyQN3g7M5Qjz9yJNtXiPWP7hZPIFcPytLhiVh3d
         AlDMl1YVc+lEzjIM5GZEV9k9IG4nAI6lHpVuUllM4VwzIHDtOiAiO+UnU+tRXrU0mOWW
         IlRRdDqdqZdgA1RYdwybkwxw1gy3BmEvf61Kjeg6LvXiRxjn4llcbmkpJwroI69kjyOh
         RcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379442; x=1722984242;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rLogURdEUgVuohDxoI/z6kah3N3XGw4tvUvw1JX3Aw=;
        b=JPOTev3cLIWp/8oKnhWBe/wP810It0v9Ky/IDbNdLi2tI8I7jXMGmzrX4khNgDWQ3A
         nGSBM1etn1kPT3W06IYImL/V79elcFHGcewbLqbnwmSfmlUHfekPjb6RE0pTgOob3O06
         bztMX9rk9k9J1ddFqA0lSmvnHNBPdGCma9t1bBY0nQ/rMYQSt2VTwCWyAu+qNF4U/ChU
         ckgUmdMjBX4Uef6S9gKjMWZmiosiQD90yq+bsr6JBAMk7sLYTox3VObnvR83yJOuGwVd
         p5JQYY5uGnCE4tDPcKFOtHvOOEE/ruYfNvXuXpkTSdB5VRA9SfSSozVHg22rGQiZXfAm
         C0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVy4phkzTSZWTcR+IpGEFQCXtl1QZh71DqxZl+SiM2OmlcZe6tCMh3LhlQyyFHC8ckWV5W1xAuaBhyImNBNwmuvRZREVqZpnQ==
X-Gm-Message-State: AOJu0YzIYRKfPJCJxoas1zBpGKoalgPLfF5bw+hdlx3CKiMMLGITP6Fk
	AOTtxJo0kBBp5ijvfir9zNlzffmZ9B/mGmbR78OkjS1Jm6AAtbSdLAIOmPut/cWSOMOg378Jy0Q
	2k51w+Q==
X-Google-Smtp-Source: AGHT+IGOvkaxnFruP/oROarFKnoqnlXkVf92ieXY1PpWplaN9r3BDmqn6TBprHl1KdZxogiiCKrITwBcRyre
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a81:b04b:0:b0:65c:4528:d91c with SMTP id
 00721157ae682-67a004a28b7mr1818107b3.0.1722379442636; Tue, 30 Jul 2024
 15:44:02 -0700 (PDT)
Date: Tue, 30 Jul 2024 22:43:50 +0000
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240730224350.4039790-1-mmaurer@google.com>
Subject: [PATCH] pahole: Apply CU-level filters early in loading
From: Matthew Maurer <mmaurer@google.com>
To: acme@kernel.org
Cc: rust-for-linux@vger.kernel.org, dwarves@vger.kernel.org, 
	aliceryhl@google.com, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"

Without this, even with `--lang_exclude=rust` set, running on `vmlinux`
with `CONFIG_RUST` enabled will lead to errors like:
die__process_function: tag not supported 0x2f (template_type_parameter)!
because the filtering doesn't happen until finalization, but unsupported
tags are reported during loading.

As an added bonus, this should speed up processing of large objects with
filtered CUs, as their details will no longer be walked.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 dwarf_loader.c | 10 ++++++++++
 dwarves.h      |  1 +
 pahole.c       |  1 +
 3 files changed, 12 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index b832c93..c48dfef 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2854,6 +2854,16 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 
 	cu->language = attr_numeric(die, DW_AT_language);
 
+	if (conf->early_cu_filter)
+		cu = (conf->early_cu_filter)(cu);
+
+	/*
+	 * If we filtered this CU out, we still want to keep iterating, but
+	 * there's no need to walk the rest of the CU info.
+	 */
+	if (cu == NULL)
+		return DWARF_CB_OK;
+
 	if (dwarf_child(die, &child) == 0) {
 		int err = die__process_unit(&child, cu, conf);
 		if (err)
diff --git a/dwarves.h b/dwarves.h
index f5ae79f..92d102b 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -72,6 +72,7 @@ struct conf_load {
 	enum load_steal_kind	(*steal)(struct cu *cu,
 					 struct conf_load *conf,
 					 void *thr_data);
+	struct cu *		(*early_cu_filter)(struct cu *cu);
 	int			(*thread_exit)(struct conf_load *conf, void *thr_data);
 	void			*cookie;
 	char			*format_path;
diff --git a/pahole.c b/pahole.c
index 954498d..937b0a1 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3765,6 +3765,7 @@ int main(int argc, char *argv[])
 	memset(tab, ' ', sizeof(tab) - 1);
 
 	conf_load.steal = pahole_stealer;
+	conf_load.early_cu_filter = cu__filter;
 	conf_load.thread_exit = pahole_thread_exit;
 
 	if (conf_load.reproducible_build) {
-- 
2.46.0.rc1.232.g9752f9e123-goog

