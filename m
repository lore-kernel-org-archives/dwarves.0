Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27A3A6B77
	for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621212; cv=none; b=T7ixo5P6NYKIGSEocPJlHitlnxDeNbkYSVMTomBEvt7eE79BldJzwY731txyw0HiaPQGubBEbZdnKkbgXcO0QISw6y9A+C8oc9ebP4RYTkCz7t3dkQwB6H4rO+NB5f3GBuuCpLJPNUqnvZ/6Y8i7SqryRj0NVSbu6r63wDTv5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621212; c=relaxed/simple;
	bh=4X1/12IcGUKpHwOnsE//Ikkb3wvoB6CMiu8hCswgRXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVRSGftbx5t4gXYPuzXMJz0wJt11sRfikO+SW9RY5wqcyRge0vz+dz+zsmKLlAc1f61YgQ+SckdYETq2SRdGwdULxqOV3oB+aIgJINg+arwZ8DfjIKImCpBhGWdBoo62hELe0WtY/o5TR3f/nMKeGasbP6zAbZ5TnlHN7nbxdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URhlNmIQ; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URhlNmIQ"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2bf3cc16baso306287066b.0
        for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621209; x=1791226009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e0XLtg/YAbFQrTSiCQ8vkBvWvCJVdJvEd7VkNiwi3wg=;
        b=URhlNmIQpwiBqZxXLdIZQ8Utrk71LquVXtQjx1BR4bsV7N90C2+Va73JHFbKdO9OJa
         YmQH9QMXoVyALCfvbGRA9ympXUVVikGJ0wA4wBIjf/OOCGWc8ylKKiPgOKARg+n2Ujhm
         mopU5dv5D+KbuvaiNqbgZr+dOzvEL1RlYRddO45+hec2myUaFeBWdoqmnKzQZFe1Hx8C
         W+YWgQTFpKgEaUhBknfy/UhCfzYsZT03pDCpKZT7M2sEYUEpQZhQ17IYvcc6EceugTGz
         DtZXE5mVxtthHrjsy/TiI1YE55bw2A0fUjTIQkOJFFx1T9bJphk55cGSGgcp7XyxQomK
         pjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621209; x=1791226009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e0XLtg/YAbFQrTSiCQ8vkBvWvCJVdJvEd7VkNiwi3wg=;
        b=B3lpEgEWcz4JcyG4tYnV8hZPx8Yf9lsIOCRxY5MncxROA8aW5Lj95KKpXGGeDMLdfz
         vYE/fwwtE7tFQRDRdH6Ab39iEdBYWLAvmJ+fNUni+WO4E/p2TjYo3vCNPVlf81wJfCrA
         dMpmjLwH1Wl3lPiFG052N/TDuSZXBBnrQyTlJ1hZxi1ZdIxLObjMdBExQUl710ADDVlh
         q8Ivm3oIoLQj0KiPakAibbI1XzEceGFA4JlRDWW3B9TyKZDeMqdq1KyTc4s0SMOsVuiU
         tmVIzHT2TzEupTkbjfN5/luw74oUT/0fSPec/GqMgmv1FGYo3eKkDM4+ePHXB+HcPgls
         6QwQ==
X-Gm-Message-State: AFuF++k7VjyPSWrmw/mlRy8l8sPfy3NvBgFnZAsvyyBx1cKQf/I+LA8B
	mfi/8CcP03e+29OfOccDaqRSkDVmhL4IKkmZKgCePa18qawczhIr16sF
X-Gm-Gg: AYBFou2zjNeBkLiI2/6ffJKgQKhdSSDB0XJp4x+PoqgmGyCtLeysR256aGZXaiGA5yL
	bMItYZRm1mvUjTJJ6qDDFk7qjNaV7niIssHsmMx7EbCAH9hBWRFDgiZ+pGsXa43wsj5TgDeijOR
	5IMJYNEfk7yF6aK5zlWOoMJOX0SD1s+0WB9yx6fd0sgCEitJ+gZayahtyNrGX6ZUr65ltC5B6XL
	QKcWmrNyUdJhogtpLpWrKtzgqB7w67Mbtn9ztDcz0ouD+uVixzAwYY6ZKXxbzwM5FUCrGNMi/xT
	Sw7WAU2GmtVSywc4IOHUoBM0Uah5MHzi2hECFHskYhAr2bDK9XVexZh6QYTy5j/bTI79L0qIvaK
	vGvkF2vsm6y9gTv2F/TB+EEyxzplTRUrNRH+Hr2VJYgnJECt1+oRQDfJsNsPptsD5hlXahDFR5U
	fUDy9RkVM5qjriYkIztMizdBmzOnmu472/xI/VL3w6WAuznkoZiSfeUNB1l53Erz/bIEUBcYR8B
	65Q1ylrMSeeG3cFGffGLEOMzrNHe7Apete0diSn00V3lI3Vv8Kxgy2PY3H0MjfC
X-Received: by 2002:a17:907:86a2:b0:c29:f0a4:a4f8 with SMTP id a640c23a62f3a-c2ac50972c2mr1139895566b.0.1790621209414;
        Mon, 28 Sep 2026 11:46:49 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-12-36-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.36.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc3e12208sm301760966b.42.2026.09.28.11.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:46:49 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	ElXreno <elxreno@gmail.com>
Subject: [PATCH dwarves 0/2] dwarf_loader: Merged CU hash table fix and sizing
Date: Mon, 28 Sep 2026 21:45:49 +0300
Message-ID: <20260928184551.1311109-1-elxreno@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes an out-of-bounds read when a merged CU looks up
.debug_types, and stops the merged table size from leaking into the
CUs loaded after it. Patch 2 sizes the merged CU tables from
.debug_info, which makes BTF encoding of a ThinLTO vmlinux 17% faster.

tests/ gives the same per-test results with and without the series
here (75 tests: 52 ok, 16 failed, 7 skipped); the failures happen on
master as well. inter_cu_refs.sh and dwz_alt_file.sh, which skip here
for lack of a perf with DWARF and of dwz, pass when run with both.

ElXreno (2):
  dwarf_loader: Keep the hash table size in struct dwarf_cu
  dwarf_loader: Size merged CU hash tables from the amount of DWARF

 dwarf_loader.c     | 70 +++++++++++++++++++++++++++++-----------------
 man-pages/pahole.1 |  4 +--
 2 files changed, 47 insertions(+), 27 deletions(-)


base-commit: c23e8b30c6dee2f7fd8aa07e9c49e8e4f31bc16c
-- 
2.55.0

