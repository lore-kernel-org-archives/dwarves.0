Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1730B3A6F1C
	for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621214; cv=none; b=l3+67LzO9pj76Q8dRcqIdO1fbbnxPusBkXh6M/WhcyL0WXgDrHcGlvdQ6Z2lCWdHBcYip5meMn8yJIZ4+KcKXXFHBeLyYTllfKPGrg2hmrP2y0sxY48Nbxt7sYZgYqvgfBRGPa0dgdEuObZFyOWk7utmPGofiH0hU8f9+QrKJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621214; c=relaxed/simple;
	bh=0suFFG1nCFh0txE8yvFIWQJyzGrcuQI5YA1e2nhZFJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rd6ji39TPrYCes+z4ro9HbR3OWIu0XqJy/ivkl0u4UjKprsVLOWxlG1S2EoQHP2BWvxncjKRvfIoBDrSYlYp5rDrYuklQf1qZYUTWESwjsBhxoE3CBmxwUPAA7i+mISpnpEI/SfQbxTgm3ErG/84P0J4BQo8XQTuRvsQ795xCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPMPhGt9; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPMPhGt9"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2afb4e9977so377560266b.1
        for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621211; x=1791226011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3OUv1dxQvXW8Pyct7DwfGZU42lVuL0uJ4iGzdOpbUhM=;
        b=PPMPhGt9IzqAwn94sXJ3/jkqG3FTmJdgOsEwe6/x7jdjYX+zMNduVKLhUhDeYnTYmW
         qOLo2Otcq389Yfk8L+JTkjKj3Y54Nbc78vRs+3HYmc0hAuKuRWvYSXat7JqEoQOa/pGP
         5SXLJsSAYld80wQDY0DlIQPiadIxKySLEkVHtv2Dr7nr5xJOwPSE9tD12pfxe61zVB7v
         2rq/AYylrzH4UzUu9A3OQMGtska+9Ikc2TAMkjuMQGihyYwMfuzewXSNlVg8mVux/XUM
         Ni52Z8PNANw+Ym0JrB8JGTlh4V/+8wyCTcTZ/598aYzKJ8gUHiE9EaPrRNDHwNxPFp2p
         F2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621211; x=1791226011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3OUv1dxQvXW8Pyct7DwfGZU42lVuL0uJ4iGzdOpbUhM=;
        b=VDFMdYgo2jc28ao65cf/yfNMA2MRRZRt6HyUpcZw4VbWfGEgtDBF8TNgCO4VT+37OP
         A6esr/cFA/wsOShYaiDLAGHyZaN0PFYaJMKtKtKx4yALBDljZM6xUCpNgF2nJEUa8kFF
         3snYueniy1m3vJbZjvemXaBNSkx1DV4JOCrvFVjbDOf8wUFAcFuBRADtCtP4xpbwxtFb
         TpFc/BV4rzb6+CQ73NKiRhlYuJXh2bxmzaykiSEAFjsx0a3TLJErlL7NsSc/EcJ8cDec
         iBKvpY2VkTSSokXdsAMVIrWnXOQwBsKUIChS9LRZNtD1KZHIc/jGBTvhoebEgGddTKKT
         hmMg==
X-Gm-Message-State: AFuF++kVXJbsaweYTJHXOZBCc7n4IX7PPgGEmKFI1AR4L+5c77Y0t/ej
	0EDEInOQ3yDMWWhCW2R24Zj56q3Ddeyecb6x/Tf7dZeshphLVX4J8vcu
X-Gm-Gg: AYBFou1F6HyiYbp8pNh3iCwq3wNaYK9qYLIII+fBydkoZ+DLSxmjdovQLm9bcdMWdK8
	kkuhs1r4x8sN/cCqPeeJ9rAiF2WUhokk4gmfsmmI/Brll0TDBVM6CN0d9x1jlgQVbKXQYoxZrTm
	dA5DfE2zt0u03XvsBbsgehQVzySqmmOUWwtqNStspFqbX6/DxF5toHYJikJsSNdoDDCqn/5gcRL
	/sw7QvjiaLCVUWLav//1oRGXff6wZ9zLBJEFOVn+g3E77603ghl0LIb9vZz6DrSeMtSi/lVxS9s
	uyaG1hNYQbHK1Kv6+3MMHLR5I5O7LKcRUfzoei1mQc2gaSN55oUyqQq+rAins7nNXLhC7wY/+ui
	hmyidVmevO3stUdPmVc23gbtLBs5+rO8L1ozPyPATt4SfVgAUxcoIjHLshVDmiSUo+Yj/+h9zUi
	j0eWaF5iOGJK5En7lwkjJ5x4cQYMEZzEU043o0mOuDfQsBJSVmD7MuHMsFoBuT3WE3zl0y/yBlE
	gFNh/eVl9IEylWlUvMF0OEe1MeRN4LeYRkpdL/kHT7p1XIU7Bj3xzIOws+Swfrg
X-Received: by 2002:a17:906:f588:b0:c29:f5d8:9c72 with SMTP id a640c23a62f3a-c2ac226d3ffmr1166741066b.33.1790621211314;
        Mon, 28 Sep 2026 11:46:51 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-12-36-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.36.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc3e12208sm301760966b.42.2026.09.28.11.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:46:51 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	ElXreno <elxreno@gmail.com>
Subject: [PATCH dwarves 2/2] dwarf_loader: Size merged CU hash tables from the amount of DWARF
Date: Mon, 28 Sep 2026 21:45:51 +0300
Message-ID: <20260928184551.1311109-3-elxreno@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928184551.1311109-1-elxreno@gmail.com>
References: <20260928184551.1311109-1-elxreno@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merged CUs always start at 2^21 buckets per hash table, whatever the
object size: too few for a ThinLTO vmlinux with 551 MB of .debug_info,
far too many for a module.

Size the tables at one bucket per 32 bytes of .debug_info, clamped to
[hashtags__bits, max_hashtags__bits], and raise the max to 26. The
tables of a dwz alternate file are sized from its own .debug_info.

clang 21 ThinLTO 7.2.7 kernel, 5855 modules, BTF byte-identical:

  vmlinux, perf stat -r5:   39.92 s -> 32.93 s, +- 0.2%
                            max RSS 10.7 GiB -> 11.2 GiB
  modules, 16 in parallel:  85.4 s -> 76.7 s wall, 212 s -> 137 s sys

Assisted-by: LLM
Signed-off-by: ElXreno <elxreno@gmail.com>
---
 dwarf_loader.c     | 25 +++++++++++++++++++++----
 man-pages/pahole.1 |  4 ++--
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 53047f8..aa129b3 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -78,7 +78,7 @@ static inline void libdw__lock_unlock(void) { pthread_mutex_unlock(&libdw__lock)
 #endif
 
 static uint32_t hashtags__bits = 12;
-static uint32_t max_hashtags__bits = 21;
+static uint32_t max_hashtags__bits = 26;
 
 static uint32_t hashtags__fn(Dwarf_Off key, uint32_t hash_bits)
 {
@@ -5048,6 +5048,22 @@ out_early:
 	return dcus->error;
 }
 
+static uint32_t dwarf__hash_bits(Dwarf *dw)
+{
+	Dwarf_Off off = 0, noff;
+	size_t cuhl;
+	uint32_t bits;
+
+	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, NULL, NULL) == 0)
+		off = noff;
+
+	bits = fls64(off / 32);
+	if (bits < hashtags__bits)
+		return hashtags__bits;
+
+	return bits < max_hashtags__bits ? bits : max_hashtags__bits;
+}
+
 static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 				     Dwfl_Module *mod, Dwarf *dw, Elf *elf,
 				     const char *filename,
@@ -5080,12 +5096,12 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 				goto out_abort;
 
 			/* Merged cu tends to need a lot more memory.
-			 * Let us start with max_hashtags__bits and
+			 * Size the hash tables from the amount of DWARF and
 			 * go down to find a proper hashtag bit value.
 			 */
 			uint32_t hash_bits;
 
-			for (hash_bits = max_hashtags__bits;
+			for (hash_bits = dwarf__hash_bits(dw);
 			     hash_bits >= hashtags__bits;
 			     hash_bits--) {
 				if (dwarf_cu__init(dcu, cu, hash_bits) == 0)
@@ -5119,7 +5135,8 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 			Dwarf *alt_dw = dwarf_getalt(dw);
 
 			if (alt_dw != NULL) {
-				struct dwarf_cu *alt_dcu = dwarf_cu__new(cu, dcu->hash_bits);
+				struct dwarf_cu *alt_dcu =
+					dwarf_cu__new(cu, dwarf__hash_bits(alt_dw));
 
 				if (alt_dcu == NULL)
 					goto out_abort;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 35ea9f4..24c7d31 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -162,8 +162,8 @@ The default format path used is equivalent to "-F dwarf,btf,ctf".
 .TP
 .B \-\-hashbits=BITS
 Allows specifying the number of bits for the debugging format loader to use.
-The only one affected so far is the "dwarf" one, its default now is 15, the
-maximum for it is now 21 bits.
+The only one affected so far is the "dwarf" one, its default now is 12, the
+maximum for it is now 26 bits.
 Tweak it to see if it improves performance as the kernel evolves and more
 types and functions have to be loaded.
 
-- 
2.55.0

