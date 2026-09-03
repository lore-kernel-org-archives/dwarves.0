Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522A43C045
	for <dwarves@vger.kernel.org>; Thu,  3 Sep 2026 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469102; cv=none; b=ZLkhBMolS6Rz4Sc+t+tQZmL0TZKVZ7+B3i8PSkPLBNTjVwtdNxSVB6y4hBEaCP9MQK7NGdKW+QTluZ4/b/lRVlUSuT99888TlSBlYDiC02QoK6rhvhMimSqLEMsGmjrMI3D+Ye8jx+xWJd7V1X7qPSoRUdP7scF3DWNFqgmDsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469102; c=relaxed/simple;
	bh=6af2QYHekk1eXi+1jcY6pOCuVb5uhiITXQfyNMcUyUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DH+W620BmwiEAOrTNXRaY68QI9PkoCq3joKD/l/3mrtSovzemSO07+mD/NEFIVm+F2Ib+kUDi10REN2VSO9U/m5yCy/fBByjyzpdOmxUTbfN/J7lIZMM+qeQJUTmQHJGFtlC2AsVLKcyxiXkIvmjxbn7lhxFSNlTgMmOREnKLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6T0N6wA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6T0N6wA"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso326273a91.0
        for <dwarves@vger.kernel.org>; Thu, 03 Sep 2026 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788469077; x=1789073877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rIHTL3Id3rn/gxF+dJN8upkPqgpCVh+Snl9sn1Kib7g=;
        b=U6T0N6wA67ZerWCSBRtQk8VB9ZM3qWPNM1gvMcOOARJ7nhLxnfvyB07rlzPznz1/xZ
         9ulUkZt6KWXfgQnc4hnL+l7nHdW/QjsHxsBqee0U7HnNTS7mEwn6kvaeGTBEzJyu80v2
         XIzP/PwB+Lm2h3jiusDBrV+kp7u1h00NCU2dy4UIbznwGr1AY4MYl1ywHSxQY170Xj2a
         XHUyUhm7hzpSDHGM2PSO3UL1shgLdW4rbdVDILdM/XXr5RSj2Q/2YvyVYXl0ua5Ke3Wh
         h1UV3/5cons1mzVMO9hEM5jZkI+mkI/MwDjES69QmEPSheACceytvZKuv39NbiSHQ243
         KtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469077; x=1789073877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rIHTL3Id3rn/gxF+dJN8upkPqgpCVh+Snl9sn1Kib7g=;
        b=S7c/aEIXFfw23jmPQqZ5Mw5lxYOlTontbllVLUhfF8ehANw++YhSU153vz5sQn4mZR
         VIFWHBXAwY7DayJvq4JEv/c19ez3dzZdHRQ7CumC21tFL+EHJO+wNGsi8iEJCPXO855S
         uBtqKfvVYO3Uefr8yD0K+w+r8FKrWv5SiZNmxJ9qgKd0suTQ2G2OVhOMqYELMkRG9KxQ
         UI/bn720K0lY4Qs4V9MPyFP+4XKXDz/+2YPQ8WUUa3vF8w7fHXmO/I0OKlQnw8tOJ5OF
         +bEqjZRU7J6ZUlxFJ5LVyG6D9nojrEkWvqomMCO5bv68q/+wAu3Dz0CWNU3dq3MP34fm
         IliQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo33cXXB6Ex6bHyUfqixj0TsgSaG3ZRfH+vxM/5V+jCrInFzfTHSBhd60TZptfRwuEqZtCR69n@vger.kernel.org
X-Gm-Message-State: AFuF++lbfr3Oi3gNP2p1g8BJvtB8O0GBFP78DfYilRp3uwIxdA4UsEbX
	pI+5VjBPP28ohyhAFWoXpj35fecxpXk3td4QW809PEUHh3+klFzBY3Bq
X-Gm-Gg: AYBFou1dfmdpLYMOecyo+NDtM895nilMoql3trFnR3AEKMxtcGCIxuxcM+L+F/yoJ5g
	7lCV+OCeRS2dbCL/1ICdcHz+gtSj4O1PiYdH6Wt93+hDaz21VvF9cHmfy9r9TKuNGVGCYNeijaJ
	6OtxMbJto0pm1xnuFIrczVy/qFtGuC+0l8bmuXbUIW0vb32uk1/b0y8/3eMxoTxYfadxCF6eKd0
	pEje1PD6mNbFQQk2Tph65Jah/JjdAnth1kkvZdN680IkFoq2KiURzzYWXa7yUfS7Lnk9jl80UiN
	eExR4E3V7wj/53I75qY6HjDbu+oMF54XXHs1VUKcXKPF3qtbyWukC1SoYvHZJdM64N7Pnub/M3G
	Fd9iybeyOIO/kkKVjoh5ntLze7O0AEQHrcEZekQCGgTvgnu8uj8oGwD+NcKNZtv5nTiZEAc7ocz
	AJYUDD9mA9EqIJAzMCN7dKBic5/s/U8kP0lRLKRkElKxluxKY9LoUq06b3XVtFnoBiwaZadH59P
	KztEm3JCNnxzYgHFmim
X-Received: by 2002:a17:90b:5790:b0:398:9bd5:4910 with SMTP id 98e67ed59e1d1-39b2624f0ffmr2083798a91.23.1788469076685;
        Thu, 03 Sep 2026 13:57:56 -0700 (PDT)
Received: from pop-os.. ([106.219.234.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm753185a91.4.2026.09.03.13.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:57:56 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] pahole: Fix -C -T segfault
Date: Fri,  4 Sep 2026 02:26:59 +0530
Message-Id: <20260903205659.1543175-3-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903205659.1543175-1-duttaditya18@gmail.com>
References: <20260903205659.1543175-1-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-T/--nr_definitions sets stats_formatter and sets formatter to NULL.
print_classes() checks for that before calling it.
The -C code path does not which results in a segfault.

Before:
  $ cat m.c
  struct named { int a; char b; };
  union u_named { int a; long b; };
  struct holey { char a; int b; };
  struct named s; union u_named u; struct holey h;

  $ pahole -C named -T m.o
  Segmentation fault (core dumped)

Reject the combination, similar to '-m -C'.

After:
  $ pahole -C named -T m.o
  pahole: -T/nr_definitions doesn't work with --class_name/-C, it shows all classes and the number of times they are defined
  $ echo $?
  1

  $ pahole -T m.o # unchanged
  named   1
  u_named 1
  holey   1

Fixes: f5857bd34b220a64 ("pahole: Honour --compile when -C is used")
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
 pahole.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pahole.c b/pahole.c
index aa04d98..b2047c1 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3461,7 +3461,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 			print_containers(cu, class_id, 0);
 		else if (find_pointers_in_structs)
 			print_structs_with_pointer_to(cu, class_id);
-		else if (class) {
+		else if (class && formatter != NULL) {
 			/*
 			 * We don't need to print it for every compile unit
 			 * but the previous options need
@@ -3666,6 +3666,11 @@ int main(int argc, char *argv[])
 		return rc;
 	}
 
+	if (class_name != NULL && stats_formatter == nr_definitions_formatter) {
+		fputs("pahole: -T/nr_definitions doesn't work with --class_name/-C, it shows all classes and the number of times they are defined\n", stderr);
+		return rc;
+	}
+
 	if (print_numeric_version) {
 		dwarves_print_numeric_version(stdout);
 		return 0;
-- 
2.34.1

