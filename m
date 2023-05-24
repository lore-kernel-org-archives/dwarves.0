Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C74C77B75
	for <linux-dwarves@archiver.kernel.org>; Wed, 24 May 2023 00:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbjEXATO (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 23 May 2023 20:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239002AbjEXATN (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 23 May 2023 20:19:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3BB5;
        Tue, 23 May 2023 17:19:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f3a99b9177so158674e87.1;
        Tue, 23 May 2023 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684887550; x=1687479550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX78X+TocVn/zKt9C0hLkh5a3KlpHhV1wjnJY0oQNcU=;
        b=VcMTV56TxhaDiAy+XfQOVGaVC2ecPB089tEVv5Webj7fvrCQdLf1WX2+taZx0GDYDO
         5D/EDZ5kzRM/fqbl4pkO3mkedsvzYNa9JLrOxKMzsV/DkHq1whsgyYdsSnrpdmojJEH0
         mJJAo/QV/yvLdZD1tR0p6TyF28+dLV4VvsLbiFzaulc6I+BKAR8tDQ+k6/lyfDXrbrru
         5a8zXRASziyBiXUf7IjwKe3BZmZk96/mgLVDiKSM1G19uOgYmz1bn0j6nRpFJ7efRXYx
         T23P80mebfcz62vUMvVDy1XG9K/EoPo9m/9WR4OvIRaW4MMc/HoN94SPR0QOLCqposXv
         X2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887550; x=1687479550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX78X+TocVn/zKt9C0hLkh5a3KlpHhV1wjnJY0oQNcU=;
        b=MCG5s5UCHizdsVmSryyW7T+c2Q9BmdVjELt95C5LJS/SfXb9WRdIhbKi4eM2KHSZrr
         DitvTF8nUgh1W4Dppru/H/JHC3m8ZkO30EtiXe3iMlGqK6Jeb1uBwsJtIpkMuxUExj26
         N/AlD2ETwN4dPugn6GjqslMw1WxhwFw1r7kCyC/29i8/6v5G7WSEfR/xdQwWxWbZ+DOY
         +3HTVWDaWsuK6LQHsnMExXXZHLq4PWTlxvi3RkX0ib7Tp5tw6rwo2mlFMm6JoGgdGkns
         oqG6CkfCtnz5i+uKv0emstDOB3nHD2gHkqMinWXXd6awQ94hliYW7EqzM/gpIOoly6Da
         RfIg==
X-Gm-Message-State: AC+VfDxL0nx0vqii7i3CYhoMJ1EglmB5180ZPKUjCSkOJ1kDrfScoQlk
        D/K7/SzU6VVgZ/R1lGHRWO07vRFyN/4P8A==
X-Google-Smtp-Source: ACHHUZ6LuhtMEw/3uPPEIKlbWU4HOVK9LhHK8L1EbRnC5vt5v0bDC2nF2DtLG9o+A9kghwkFbfkMyA==
X-Received: by 2002:a05:6512:3902:b0:4ef:ef11:e29d with SMTP id a2-20020a056512390200b004efef11e29dmr4226394lfu.68.1684887550051;
        Tue, 23 May 2023 17:19:10 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w7-20020a19c507000000b004f138ab93c7sm1487305lfe.264.2023.05.23.17.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:19:09 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jemarch@gnu.org, david.faust@oracle.com, mykolal@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 dwarves 6/6] btf_encoder: skip type tags for VAR entry types
Date:   Wed, 24 May 2023 03:18:25 +0300
Message-Id: <20230524001825.2688661-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524001825.2688661-1-eddyz87@gmail.com>
References: <20230524001825.2688661-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Kernel does not expect VAR entries to have types starting from
BTF_TYPE_TAG. Specifically, the code like below will be rejected:

  struct rq __percpu runqueues;
  ...
  rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, cpu);
  ... rq->cpu ...     // rq type is now PTR_TO_BTF_ID

The access to 'rq->cpu' would be checked by a call to
kernel/bpf/btf.c:btf_struct_access() which invokes btf_struct_walk(),
using rq's type as a starting point. The btf_struct_walk() wants the
first type in a chain to be STRUCT or UNION and does not skip modifiers.

Before introduction of support for 'btf:type_tag' such situations were
not possible, as TYPE_TAG entries were always preceded by PTR entries.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 65f6e71..300d9c2 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1498,6 +1498,19 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
 	return true;
 }
 
+static type_id_t skip_btf_type_tags(struct cu *cu, type_id_t id)
+{
+	for (;;) {
+		struct tag *tag = cu__type(cu, id);
+
+		if (tag == NULL || tag->tag != DW_TAG_LLVM_annotation)
+			break;
+		id = tag->type;
+	}
+
+	return id;
+}
+
 static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 {
 	struct cu *cu = encoder->cu;
@@ -1583,7 +1596,22 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 			continue;
 		}
 
-		type = var->ip.tag.type + encoder->type_id_off;
+		/* Kernel does not expect VAR entries to have types starting from BTF_TYPE_TAG.
+		 * Specifically, the code like below will be rejected:
+		 *
+		 *   struct rq __percpu runqueues;
+		 *   ...
+		 *   rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, cpu);
+		 *   ... rq->cpu ...     // rq type is now PTR_TO_BTF_ID
+		 *
+		 * The access to 'rq->cpu' would be checked by a call to
+		 * kernel/bpf/btf.c:btf_struct_access() which invokes btf_struct_walk(),
+		 * using rq's type as a starting point. The btf_struct_walk() wants the
+		 * first type in a chain to be STRUCT or UNION and does not skip modifiers.
+		 *
+		 * Thus, call skip_btf_type_tags() here.
+		 */
+		type = skip_btf_type_tags(cu, var->ip.tag.type) + encoder->type_id_off;
 		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
 
 		if (encoder->verbose) {
-- 
2.40.1

