Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CC52957AD
	for <dwarves@vger.kernel.org>; Wed, 30 Jul 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753889204; cv=none; b=PD/3bGwB55ch9i9d7ruBPsYrLg0BxAq8DqC+zHuMl6sPZ/A1BzedZdSCV6kV1xsu+zuuqEDoyIovN5diwoiCc4jycEbEe2/rk5l3B/JGUd0FEOCSAnlK9PGgH2sQ5yX/iDCa3wFEJWEsM/UaOBqHqMMmEIv4d1v3bf8h9VDxrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753889204; c=relaxed/simple;
	bh=+peGhC/D7bZ5Wp0FFtID/kCBa4ld78nepxLM1KxYrQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HKtrrDBCv3I0yukf3pdShwQLTURVhn4mFmQmGDykhylW+ffV6oSq4IVPDLCQCRpn+QUBdYgZDgo5XmEIWlmXjaN+9uSUPx36T32QvzRk57gOcx+popRkyV9ej56Ggt+JBfJNmGYgR+72ygj2hfQTNozys0njusEPlh/On8cXERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WV/6K5eo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WV/6K5eo"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AE624442D;
	Wed, 30 Jul 2025 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753889197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5lZSq8I6noaYFWDZjsIjoANGVIVgFxq7kPpA+ios6oc=;
	b=WV/6K5eoNaFpxz5TAxo+Ml5l8JugBeRXycqigATyNDnp43j+kCuSt/b53yJNJ12cWym9GQ
	WnAX5LjxLfsh4S7RQE9Bw0ejaUAMyIee/FXlwK1YmHiqFtx2sNqfQHBRIbWcbc+UpXhJ/2
	BVacnlHXm11sDRiAD/9XHxWlNzUDM+vSD2aBSFvZYZ9XNVa4Ag5eQtNPwTZntVKWU9BlxB
	3u3Fe6u5gIzFHtrhDue61pudURrh1BNp1H3iEx7LvqmrZGV19dxgt8CWtAUDFkTkk/x/6A
	WsfMR0nf76PWKPImmnLyj3QW6dPzljTnU2nOr7/0bJ85+69SBp6IzsW+CWO+Lw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 30 Jul 2025 17:26:30 +0200
Subject: [PATCH v2] pahole: do not return an error when printing only a
 specific class
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250730-lsk__abort-v2-1-fcec3172a878@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKU5imgC/23MSw7CIBSF4a00dywGMDzqqPswTUNbsDdWMEAaT
 cPexY4d/ic53w7JRrQJrs0O0W6YMPga/NTAtBh/twTn2sApF1QxSdb0GAYzhpgJHwVTWlLjuIZ
 6eEXr8H1gt772gimH+Dnsjf3Wv8zGCCNCS3dhpp1bNXdjCHlFf57CE/pSyheoO/dWpgAAAA==
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefghfeiudduffetfeehueduffdtteeigeehvdeludetueffvedvfedttdekieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegvsghpfheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhop
 egrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghvpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrtghmvgesrhgvughhrghtrdgtohhm
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

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
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
 dwarf_loader.c | 19 ++++++++++++++-----
 dwarves.h      |  1 +
 pahole.c       | 21 +++++++++++----------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ef00cdf308166732fc0938f2eecd56d314d3354f..1b44327c0b9ef9f4d9ae120e2b6d57b531c65277 100644
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
@@ -3657,6 +3660,7 @@ static void *dwarf_loader__worker_thread(void *arg)
 	struct dwarf_cus *dcus = arg;
 	bool stop = false;
 	struct cu *cu;
+	int ret;
 
 	while (!stop) {
 		job = cus_queue__enqdeq_job(job);
@@ -3679,8 +3683,11 @@ static void *dwarf_loader__worker_thread(void *arg)
 			break;
 
 		case JOB_STEAL:
-			if (cus__steal_now(dcus->cus, job->cu, dcus->conf) == LSK__STOP_LOADING)
+			ret = cus__steal_now(dcus->cus, job->cu, dcus->conf);
+			if (ret == LSK__ABORT || ret == LSK__STOP_LOADING) {
+				dcus->lsk_status = ret;
 				goto out_abort;
+			}
 			cus_queue__inc_next_cu_id();
 			/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
 			job->type = JOB_DECODE;
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

