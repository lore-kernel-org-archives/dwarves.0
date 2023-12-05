Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SSCOtkX1"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1B0109
	for <dwarves@vger.kernel.org>; Tue,  5 Dec 2023 09:43:35 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2106B3F1D9
	for <dwarves@vger.kernel.org>; Tue,  5 Dec 2023 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701798213;
	bh=Q2qZvcO87jIt2PH3ghzwKYovp8rt4knBaBjyzlXZ6yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=SSCOtkX1XOjb4/lkDcE5q0gWru04lNIkkyEGGMKZU2AfbtSosy3PwDNi09g0nFvk1
	 xOIyUqHVHQL785PBfrFlfdCSx18K01W16jqUB20AbTQNnLwaIrD3uc4nOOHt/tWnvd
	 x7S2Q5cZYU/XB9PMXYk3RxqRYtMgR/4EDGdNjc5P1WWphsEHeLQxUkb4BdqoZ0qRov
	 g2ON+SbIVWOEjIi6MmiDHL/rUMWxrhEbOpgmJDi5qgDDii3sx2pXVZ16PR7nsnyaur
	 52Jg8v+oBBuRRMp7qycecTH3IKReNmX4pPT/g5Ck8pQg4PI/wo3dkibZakuMVk6LR+
	 uKkPtwKHLy/Fw==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-333405020afso2466549f8f.3
        for <dwarves@vger.kernel.org>; Tue, 05 Dec 2023 09:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798212; x=1702403012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2qZvcO87jIt2PH3ghzwKYovp8rt4knBaBjyzlXZ6yg=;
        b=HZWErGn5Ks99dVPmzOpd4QVqu8h5hYToazCPm9wk6u6eLfcLNPK3+pBnrJP5TENXMq
         4QFsZSUZujw7QSHm/X/bHzV3/f6Tz7uCfQtCbjBWNmgv1Lz2t1jA/go4Nbc/vnN/r6C6
         uvjto7nY0asAdSJTrsNZQhE3W6j3CW/gf31UjncmiluCekvNSi46UQp4R6bP0BR6uqdp
         XZywiIA3HARqqtgjuGVWEMxdJCNWly8xynj8OISWI0P8/aX0JM4mLLycrxvBrM2KOF5+
         xzBnVP6BcmoikYQh/PKp8vUkmyfKb1CxAjcr/N7tjhJWSx2FAs/YTaKlGWfr/HAnCBFU
         bChg==
X-Gm-Message-State: AOJu0YyfMTQcC6yUiFsODOJljgVWL5o5VDftFYb01rGcIq4IMx/Jab4l
	cYaeyh/q2cYQhqdzll8Ri1kwDuxncG88Uoe9TJBgFEtQECLY3MqBL1KD4gLtPJI+WC2qdLsj3Zk
	DfMxUHWLK3Mbpd6OGqR3JgR/3eWOAV+KOJ/lQ2gOHu2Y=
X-Received: by 2002:a5d:630e:0:b0:333:39a8:bddd with SMTP id i14-20020a5d630e000000b0033339a8bdddmr3285906wru.117.1701798212000;
        Tue, 05 Dec 2023 09:43:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJeryvxr1msa/6KxStX4mXvjQQ2t6kOANUqFaCq+an3p8zAT6fNwIU+TP7bKiAx2uIECPRWA==
X-Received: by 2002:a5d:630e:0:b0:333:39a8:bddd with SMTP id i14-20020a5d630e000000b0033339a8bdddmr3285897wru.117.1701798211656;
        Tue, 05 Dec 2023 09:43:31 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id b4-20020a5d4b84000000b003333c9ad4d6sm9180050wrt.116.2023.12.05.09.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:43:31 -0800 (PST)
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To: dwarves@vger.kernel.org
Cc: acme@kernel.org,
	mark@klomp.org
Subject: [PATCH] HACK: port dwarf_loader to dwarf_get_units
Date: Tue,  5 Dec 2023 17:43:11 +0000
Message-Id: <20231205174311.1019872-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADWks+bxFgT0e8vA0MaX2aXsLDzawU2kyhiOXBm_bP3UOxw_dA@mail.gmail.com>
References: <CADWks+bxFgT0e8vA0MaX2aXsLDzawU2kyhiOXBm_bP3UOxw_dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a trivial sample to demonstrate that loading dwarf-4, dwarf-5,
with and without split-dwarf works.

Observe that before this patch there are valgrind leaks.
Obverse that there are even more valgrind leaks after this patch.

But it does make things load all 4 sample builds, and present the same
sample pahole output for all of them.

Abosolutely no idea what pointer_size variable is, or what it was in
dwarf_next_unit() or what it is in dwarf_cu_die(), or if that's what
cu__new() needs.

Separtely if one compiles linux kernel with dwarf-5 and split-dwarf,
and tries to run this build of pahole, even on like a trivial kernel
module it segfaults eventually when trying to
ftype__recode_dwarf_types, because eventually pos becomes NULL and
NULL dereference happens. So something about the created cus is not
quite right. Strongly suspecting that pointer_size actually matters
and possibly loaidng subdie needs to be properly accounted for.

NACKed-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 dwarf_loader.c | 31 ++++++++++++-------------------
 dwarves.c      |  8 ++++++++
 sample.c       | 10 ++++++++++
 sample.sh      | 18 ++++++++++++++++++
 4 files changed, 48 insertions(+), 19 deletions(-)
 create mode 100644 sample.c
 create mode 100755 sample.sh

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ccf31943bb..84aebed7c5 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2823,13 +2823,6 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 	const uint16_t tag = dwarf_tag(die);
 
 	if (tag == DW_TAG_skeleton_unit) {
-		static bool warned;
-
-		if (!warned) {
-			fprintf(stderr, "WARNING: DW_TAG_skeleton_unit used, please look for a .dwo file and use it instead.\n"
-					"         A future version of pahole will support do this automagically.\n");
-			warned = true;
-		}
 		return 0; // so that other units can be processed
 	}
 
@@ -3068,20 +3061,22 @@ static int __cus__load_debug_types(struct conf_load *conf, Dwfl_Module *mod, Dwa
 				   const char *filename, const unsigned char *build_id,
 				   int build_id_len, struct cu **cup, struct dwarf_cu *dcup)
 {
-	Dwarf_Off off = 0, noff, type_off;
-	size_t cuhl;
 	uint8_t pointer_size, offset_size;
-	uint64_t signature;
+
+	Dwarf_CU *dgu_cu = NULL;
+	Dwarf_Die result;
+	Dwarf_Die cudie;
+	Dwarf_Die subdie;
 
 	*cup = NULL;
 
-	while (dwarf_next_unit(dw, off, &noff, &cuhl, NULL, NULL, &pointer_size,
-			       &offset_size, &signature, &type_off)
-		== 0) {
+	while (dwarf_get_units(dw,dgu_cu,&dgu_cu,NULL,NULL,&cudie,&subdie)==0) {
 
 		if (*cup == NULL) {
 			struct cu *cu;
 
+			dwarf_cu_die (dgu_cu, &result, NULL, NULL, &pointer_size, NULL, NULL, NULL);
+
 			cu = cu__new("", pointer_size, build_id,
 				     build_id_len, filename, conf->use_obstack);
 			if (cu == NULL ||
@@ -3100,14 +3095,12 @@ static int __cus__load_debug_types(struct conf_load *conf, Dwfl_Module *mod, Dwa
 			*cup = cu;
 		}
 
-		Dwarf_Die die_mem;
-		Dwarf_Die *cu_die = dwarf_offdie_types(dw, off + cuhl,
-						       &die_mem);
-
-		if (die__process(cu_die, *cup, conf) != 0)
+		if (die__process(&cudie, *cup, conf) != 0)
 			return DWARF_CB_ABORT;
+		if (dwarf_tag(&subdie) != DW_TAG_invalid)
+			if (die__process(&subdie, *cup, conf) != 0)
+				return DWARF_CB_ABORT;
 
-		off = noff;
 	}
 
 	if (*cup != NULL && cu__recode_dwarf_types(*cup) != 0)
diff --git a/dwarves.c b/dwarves.c
index 9f97edaea2..2abab727fc 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -62,6 +62,10 @@ void *cu__malloc(struct cu *cu, size_t size)
 
 void cu__free(struct cu *cu, void *ptr)
 {
+	// FIXME it seems like loading split dwarf, causes multiple
+	// references to the same thing, and thus current clean up &
+	// free code aborts on double free's
+	return;
 	if (!cu->use_obstack)
 		free(ptr);
 
@@ -711,6 +715,10 @@ out_free:
 
 void cu__delete(struct cu *cu)
 {
+	// FIXME it seems like loading split dwarf, causes multiple
+	// references to the same thing, and thus current clean up &
+	// free code aborts on double free's
+	return;
 	if (cu == NULL)
 		return;
 
diff --git a/sample.c b/sample.c
new file mode 100644
index 0000000000..bff48d3139
--- /dev/null
+++ b/sample.c
@@ -0,0 +1,10 @@
+#include <stdio.h>
+struct Sample {
+  char sample_string[50];
+  int  sample_integer;
+  float sample_float;
+};
+void main() {
+	struct Sample sample = {.sample_integer = 3};
+	printf("%i\n", sample.sample_integer);
+}
diff --git a/sample.sh b/sample.sh
new file mode 100755
index 0000000000..241d4adec8
--- /dev/null
+++ b/sample.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+set -x
+rc=0
+gcc -gdwarf-5 -gsplit-dwarf ./sample.c
+valgrind ./pahole ./a.out
+rc=$((rc + $?))
+gcc -gdwarf-4 -gsplit-dwarf ./sample.c
+valgrind ./pahole ./a.out
+rc=$((rc + $?))
+gcc -gdwarf-5 ./sample.c
+valgrind ./pahole ./a.out
+rc=$((rc + $?))
+gcc -gdwarf-4 ./sample.c
+valgrind ./pahole ./a.out
+rc=$((rc + $?))
+rm -f a.out
+exit $rc
+
-- 
2.34.1

