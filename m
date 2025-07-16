Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4128A1C8
	for <dwarves@vger.kernel.org>; Wed, 16 Jul 2025 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656883; cv=none; b=R4r2rQChsWBUy7/yAFCUBT5Q/ZbHkKzmjYXKJtrt9NjzyZs8OLj/stIfUUK48uSJskEkKfX8skf4JFA1s3vM43690URwNVrjwruYsKyguT79UWNGTelXYk7Ncxj9t0UtsvvwrZcMX70b0BDYUa8UlG87kA5LDSxEsdjgbFh8edI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656883; c=relaxed/simple;
	bh=HjJiZp1zDuf/7/OZMxr1R2hc+xKRIQl6wY/HZgYkSDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Cu7ZBmDJ9vrz5Vv0Ffn3XRrUQNtnRBC0UAJwIe+mIJ/vrZIncFI8u6qikbN5ZwCzZTlWIszqfRHLvuycHD3z0SRQMh8ZxbSG4RBxfwgXNhpClSyDP0EiRRdqG/uun+OgeUFAS2vmQVqUNgSdhEaFv1EiRzHktg3YrOA1jpJSdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a1mqfUQT; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a1mqfUQT"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AD0843896;
	Wed, 16 Jul 2025 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752656872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PtdmW5pd8gySUFwg053b6FakSc6F/jwGLa6JKxIJueU=;
	b=a1mqfUQTqMMQ7m3xL90vBDDH0i21NqZp7krkEujY0qMarpBwxBSLTRdZCSYHJtcEgHM7L7
	DrUykiZ/Bs/B/0AVvxc5UgKK+l/uSpjJGCLRENaWqjrPZeKN5xZDE/zzqOJ5BrV+qXrRNP
	5FWY3+ElJf+XDYikJ3TFSnYk1bYs1yB4p8SOtuLDV/Gq2trhWw/7Z28dVnOULhyFGCXv+5
	JlbPVk7xRgfTSNynp1nKmhdahOmWT2+Lk5mN4RJZX3rEweD+x6PHegDIzMfHPGwVbVJzwh
	JGqMkIsg4rRVsQQ9iqF6/ClJbwV+vU3WZYKcapG1Pqo7pL2qNTEZ2U+imAWudA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 16 Jul 2025 11:04:31 +0200
Subject: [PATCH] pahole: do not return an error when printing only a
 specific class
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250716-lsk__abort-v1-1-586f31a9d97d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAB5rd2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Mz3Zzi7Pj4xKT8ohJdoyRTQ3MLM4PENCMLJaCGgqLUtMwKsGHRsbW
 1AKRpb2hcAAAA
X-Change-ID: 20250716-lsk__abort-2b517860af28
To: dwarves@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alan Maguire <alan.maguire@oracle.com>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefghfeiudduffetfeehueduffdtteeigeehvdeludetueffvedvfedttdekieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprggtmhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghpfheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghv

When trying to print a specific class layout with recent pahole
versions, we get an error right after the expected class print:

  $ ./build/pahole -C test_bin_struct_packed -F dwarf tests/bin/test_bin
  struct test_bin_struct_packed {
          char                       a;                    /*     0     1 */
          short int                  b;                    /*     1     2 */
          int                        c;                    /*     3     4 */
          long long unsigned int     d;                    /*     7     8 */

          /* size: 15, cachelines: 1, members: 4 */
          /* last cacheline: 15 bytes */
  } __attribute__((__packed__));

  pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument

This error is due to pahole_stealer returning LSK__STOP_LOADING when
dealing with a single class and when it is done. This LSK__STOP_LOADING
is then propagated to dwarf_loader__worker_thread and interpreted as an
error (and turned into a DWARF_CB_ABORT). The main issue is that this
LSK__STOP_LOADING value is sometimes generated by actual issues during
pahole stealing, sometimes by "nominal" execution.

Add a new LSK__ABORT status to distinguish between those nominal and
faulty cases. Return an error only when pahole_stealer returns
LSK__ABORT.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
See [1] for original discussions about the issue

[1] https://lore.kernel.org/dwarves/DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com/
---
 dwarf_loader.c |  6 ++++--
 dwarves.h      |  1 +
 pahole.c       | 21 +++++++++++----------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ef00cdf308166732fc0938f2eecd56d314d3354f..4e1e19c9d828e111d78012feda4c8baa0d716378 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3277,6 +3277,8 @@ static int cus__steal_now(struct cus *cus, struct cu *cu, struct conf_load *conf
 		break;
 	case LSK__KEEPIT:
 		break;
+	case LSK__ABORT:
+		break;
 	}
 	return lsk;
 }
@@ -3679,7 +3681,7 @@ static void *dwarf_loader__worker_thread(void *arg)
 			break;
 
 		case JOB_STEAL:
-			if (cus__steal_now(dcus->cus, job->cu, dcus->conf) == LSK__STOP_LOADING)
+			if (cus__steal_now(dcus->cus, job->cu, dcus->conf) == LSK__ABORT)
 				goto out_abort;
 			cus_queue__inc_next_cu_id();
 			/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
@@ -3872,7 +3874,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 		goto out_abort;
 
 	cu__finalize(cu, cus, conf);
-	if (cus__steal_now(cus, cu, conf) == LSK__STOP_LOADING)
+	if (cus__steal_now(cus, cu, conf) == LSK__ABORT)
 		goto out_abort;
 
 	return 0;
diff --git a/dwarves.h b/dwarves.h
index 883852f4b60a36d73bce4568cbacd8ef3cff97ea..5df1cdad9be36212bd6548e86180860daffa3f63 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -43,6 +43,7 @@ enum load_steal_kind {
 	LSK__KEEPIT,
 	LSK__DELETE,
 	LSK__STOP_LOADING,
+	LSK__ABORT,
 };
 
 /*
diff --git a/pahole.c b/pahole.c
index 333e71ab65924d2c64771be7d40f768f02e9a0f0..66448fc430c19e5137a8467026d35d2ba3125e4c 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3165,13 +3165,13 @@ static enum load_steal_kind pahole_stealer__btf_encode(struct cu *cu, struct con
 
 	if (!btf_encoder) {
 		fprintf(stderr, "Error creating BTF encoder.\n");
-		return LSK__STOP_LOADING;
+		return LSK__ABORT;
 	}
 
 	err = btf_encoder__encode_cu(btf_encoder, cu, conf_load);
 	if (err < 0) {
 		fprintf(stderr, "Error while encoding BTF.\n");
-		return LSK__STOP_LOADING;
+		return LSK__ABORT;
 	}
 
 	return LSK__DELETE;
@@ -3230,7 +3230,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 		 *
 		 * FIXME: Disabled, should use Oracle's libctf
 		 */
-		goto dump_and_stop;
+		goto dump_and_abort;
 	}
 #endif
 	if (class_name == NULL) {
@@ -3281,7 +3281,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 
 		if (prototype->nr_args != 0 && !tag__is_struct(class)) {
 			fprintf(stderr, "pahole: attributes are only supported with 'class' and 'struct' types\n");
-			goto dump_and_stop;
+			goto dump_and_abort;
 		}
 
 		struct type *type = tag__type(class);
@@ -3291,7 +3291,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 			if (type->sizeof_member == NULL) {
 				fprintf(stderr, "pahole: the sizeof member '%s' wasn't found in the '%s' type\n",
 					prototype->size, prototype->name);
-				goto dump_and_stop;
+				goto dump_and_abort;
 			}
 		}
 
@@ -3300,7 +3300,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 			if (type->type_member == NULL) {
 				fprintf(stderr, "pahole: the type member '%s' wasn't found in the '%s' type\n",
 					prototype->type, prototype->name);
-				goto dump_and_stop;
+				goto dump_and_abort;
 			}
 		}
 
@@ -3315,7 +3315,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 			if (type->filter == NULL) {
 				fprintf(stderr, "pahole: invalid filter '%s' for '%s'\n",
 					prototype->filter, prototype->name);
-				goto dump_and_stop;
+				goto dump_and_abort;
 			}
 		}
 
@@ -3386,15 +3386,16 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 	/*
 	 * If we found all the entries in --class_name, stop
 	 */
-	if (list_empty(&class_names)) {
-dump_and_stop:
+	if (list_empty(&class_names))
 		ret = LSK__STOP_LOADING;
-	}
 dump_it:
 	if (first_obj_only)
 		ret = LSK__STOP_LOADING;
 filter_it:
 	return ret;
+dump_and_abort:
+	ret = LSK__ABORT;
+	return ret;
 }
 
 static int prototypes__add(struct list_head *prototypes, const char *entry)

---
base-commit: 9845339bd09f9889dd741ed94f71eb92008dcdfc
change-id: 20250716-lsk__abort-2b517860af28

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

