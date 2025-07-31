Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141017C224
	for <dwarves@vger.kernel.org>; Thu, 31 Jul 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980198; cv=none; b=QOxbvMj6JxDAUd9/2ZHzqB7xnTOZeq+ChOiWQuBVODFfl4AwjdF+xbfn9om1lIxYqwa4d3S3V1DUcnfgNEAMICzlF/XYUGx+PmUVIPA+xYdzU7qk6VPULNTzLTBDby4g2CfL+pGwpaElpq3BWrOxgM1lQs4HKjFLqRRngC5J/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980198; c=relaxed/simple;
	bh=UT7GrQLeXGduFhcN0j/tlhXYxeMmbqmz5sMCbAGVPA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hR3w8uyqqsA1zCsXn3d6QkxNyAkSikFxL6w6NxG6vIcSgU+//WfEEoDeseAM+1NjgRFJbbJLr/3N5Rba4h5yEuEVoSL3c2v40bfIrA/vanFM0hmQWyxOViNZMBgzBdiAcv57lN72eb9MtRtAayYpU/tcFmef17Fn7CKvYNvC1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JYdR8Xp3; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JYdR8Xp3"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 55DE658052F
	for <dwarves@vger.kernel.org>; Thu, 31 Jul 2025 16:16:45 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3602244356;
	Thu, 31 Jul 2025 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753978603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2uFHO9FxkuaaEdOk4V6ePd6UYkmFfjzNbLs1YocRldo=;
	b=JYdR8Xp3jolZP7YDRcvqwmPBrL/ueaIyqnlJbuR0yKzYYIVY2ZYRJPJkzoEU+3HleF8thr
	4a+ykofnWnSFFjNz9XKIKs5yZkbRCqsr2ttYhcyBC35iTOR4BSJQhMWuewvUOVqX5ShJ5g
	0UqrI94tImLNYpPS1Zo+h1cCxmikzgLtYR76LBIaXa4Lk4S+2pSsQbhXcPTGlC6d88ms16
	tNcaIADb/8cKTKyDOcdIesBYTlmzdk3I4wg7JK02jvPRSMlFBywmH2hMmVSe155eO14QyS
	s1Yee419Om/uiIidm+b8D5ctHgAfrBLACPSHzLankqVr7adUFlc/uhMXitpVYA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 31 Jul 2025 18:16:32 +0200
Subject: [PATCH v3] pahole: do not return an error when printing only a
 specific class
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-lsk__abort-v3-1-40f79e168198@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAN+Wi2gC/23M0QqDIBiG4VsJj+fQX0rbUfcxRpjp+lnLoSEb0
 b3POlqww++D511ItAFtJJdiIcEmjOinPMSpIGbQ091S7PMmwKBkkld0jI+21Z0PM4Wu5FJVTDt
 QJINXsA7fe+x6y3vAOPvw2duJb+/fTOKU01JVTnBd97Xsm877ecTpbPyTbKEEP1iwA4aMnbFGc
 AlaSXXE67p+AWC5tvrjAAAA
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhorucdlvgeurffhucfhohhunhgurghtihhonhdmuceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejgffhieduudffteefheeuudfftdetieeghedvleduteeuffevvdeftddtkeeiveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrtghmvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvggsphhfsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrl
 hgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepihhhohhrrdhsohhlohgurhgriheslhhinhhugidruggvvhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

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
faulty cases. Still let DWARF_CB_ABORT value propagate when the stealer
returns either LSK__ABORT or LSK__STOP_LOADING (so that any other
running worker is properly asked to stop, thanks to
cus_processsing_queue.abort), but also propagate the LSK status, and
return an error on DWARF_CB_ABORT only if the status is LSK__ABORT.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- renamed out_abort to out_early in dwarf_loader__worker_thread as well
- replaced goto dump_and_abort with early returns in pahole_stealer to
  simplify the final return block
- collected Alan's R-b
- Link to v2: https://lore.kernel.org/r/20250730-lsk__abort-v2-1-fcec3172a878@bootlin.com

Changes in v2:
- rename out_error to out_early in dwarf_loader__worker_thread
- Introduced lsk_status in struct_dwarf_cus, which hold a worker LSK
  return status
- keep returning DWARF_CB_ABORT if worker returns LSK__STOP_LOADING
- in cus__load_module, do not return an error is lsk_status is different
  from LSK__ABORT
- Link to v1: https://lore.kernel.org/r/20250716-lsk__abort-v1-1-586f31a9d97d@bootlin.com
---
See [1] for original discussions about the issue

[1] https://lore.kernel.org/dwarves/DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com/
---
 dwarf_loader.c | 29 +++++++++++++++++++----------
 dwarves.h      |  1 +
 pahole.c       | 18 ++++++++----------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ef00cdf308166732fc0938f2eecd56d314d3354f..ea692b295ab6340897ac16466fbe6776724c6186 100644
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
@@ -3439,6 +3441,7 @@ struct dwarf_cus {
 	const unsigned char *build_id;
 	int		    build_id_len;
 	int		    error;
+	int		    lsk_status;
 	struct dwarf_cu	    *type_dcu;
 	uint32_t	nr_cus_created;
 };
@@ -3657,11 +3660,12 @@ static void *dwarf_loader__worker_thread(void *arg)
 	struct dwarf_cus *dcus = arg;
 	bool stop = false;
 	struct cu *cu;
+	int ret;
 
 	while (!stop) {
 		job = cus_queue__enqdeq_job(job);
 		if (!job)
-			goto out_abort;
+			goto out_early;
 
 		switch (job->type) {
 
@@ -3679,8 +3683,11 @@ static void *dwarf_loader__worker_thread(void *arg)
 			break;
 
 		case JOB_STEAL:
-			if (cus__steal_now(dcus->cus, job->cu, dcus->conf) == LSK__STOP_LOADING)
-				goto out_abort;
+			ret = cus__steal_now(dcus->cus, job->cu, dcus->conf);
+			if (ret == LSK__ABORT || ret == LSK__STOP_LOADING) {
+				dcus->lsk_status = ret;
+				goto out_early;
+			}
 			cus_queue__inc_next_cu_id();
 			/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
 			job->type = JOB_DECODE;
@@ -3689,15 +3696,15 @@ static void *dwarf_loader__worker_thread(void *arg)
 
 		default:
 			fprintf(stderr, "Unknown dwarf_loader job type %d\n", job->type);
-			goto out_abort;
+			goto out_early;
 		}
 	}
 
 	if (dcus->error)
-		goto out_abort;
+		goto out_early;
 
 	return (void *)DWARF_CB_OK;
-out_abort:
+out_early:
 	__atomic_store_n(&cus_processing_queue.abort, true, __ATOMIC_SEQ_CST);
 	pthread_cond_signal(&cus_processing_queue.job_added);
 	return (void *)DWARF_CB_ABORT;
@@ -3750,7 +3757,7 @@ static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
 		job = calloc(1, sizeof(*job));
 		if (!job) {
 			dcus->error = -ENOMEM;
-			goto out_error;
+			goto out_early;
 		}
 		job->type = JOB_DECODE;
 		/* no need for locks, workers were not started yet */
@@ -3776,7 +3783,7 @@ out_join:
 			dcus->error = (long)res;
 	}
 
-out_error:
+out_early:
 	cus_queue__destroy();
 
 	return dcus->error;
@@ -3872,7 +3879,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 		goto out_abort;
 
 	cu__finalize(cu, cus, conf);
-	if (cus__steal_now(cus, cu, conf) == LSK__STOP_LOADING)
+	if (cus__steal_now(cus, cu, conf) == LSK__ABORT)
 		goto out_abort;
 
 	return 0;
@@ -3897,6 +3904,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 	struct cu *type_cu;
 	struct dwarf_cu type_dcu;
 	int type_lsk = LSK__KEEPIT;
+	int lsk_worker_status = LSK__ABORT;
 
 	int res = __cus__load_debug_types(cus, conf, mod, dw, elf, filename, build_id, build_id_len, &type_cu, &type_dcu);
 	if (res != 0) {
@@ -3930,9 +3938,10 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 			.nr_cus_created = 0,
 		};
 		res = dwarf_cus__process_cus(&dcus);
+		lsk_worker_status = dcus.lsk_status;
 	}
 
-	if (res)
+	if (res && lsk_worker_status == LSK__ABORT)
 		return res;
 
 	if (type_lsk == LSK__DELETE)
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
index 333e71ab65924d2c64771be7d40f768f02e9a0f0..92b7c5d1da188a2e5fcf07df637bd6a3b92babb5 100644
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
+		return LSK__ABORT;
 	}
 #endif
 	if (class_name == NULL) {
@@ -3281,7 +3281,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 
 		if (prototype->nr_args != 0 && !tag__is_struct(class)) {
 			fprintf(stderr, "pahole: attributes are only supported with 'class' and 'struct' types\n");
-			goto dump_and_stop;
+			return LSK__ABORT;
 		}
 
 		struct type *type = tag__type(class);
@@ -3291,7 +3291,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 			if (type->sizeof_member == NULL) {
 				fprintf(stderr, "pahole: the sizeof member '%s' wasn't found in the '%s' type\n",
 					prototype->size, prototype->name);
-				goto dump_and_stop;
+				return LSK__ABORT;
 			}
 		}
 
@@ -3300,7 +3300,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 			if (type->type_member == NULL) {
 				fprintf(stderr, "pahole: the type member '%s' wasn't found in the '%s' type\n",
 					prototype->type, prototype->name);
-				goto dump_and_stop;
+				return LSK__ABORT;
 			}
 		}
 
@@ -3315,7 +3315,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 			if (type->filter == NULL) {
 				fprintf(stderr, "pahole: invalid filter '%s' for '%s'\n",
 					prototype->filter, prototype->name);
-				goto dump_and_stop;
+				return LSK__ABORT;
 			}
 		}
 
@@ -3386,10 +3386,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
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

---
base-commit: 9845339bd09f9889dd741ed94f71eb92008dcdfc
change-id: 20250716-lsk__abort-2b517860af28

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

