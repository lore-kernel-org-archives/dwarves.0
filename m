Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1F48662D;
	Wed, 29 Jul 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352097; cv=none; b=ZdcGWgeMA1udfZ5rIXsWfkC4e2rb9IBcGKPl+v8UHJnYDfSm19fUBwZU3FvyVQxi619uDKDleTnhabZYqJ7rUUFUWA9vtARJjbRDOsyVJN+3+x+xR0XoIfS/D8s8thZNsQ3agpwfQy3vTWxathycKFXaNguXTTfQNcemb1/ESt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352097; c=relaxed/simple;
	bh=VFv1u3keSboumjxS7gktPabvQOLMOcIyGDDGRMZpDHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc2L5IriaQeoFawq6iLD3mahz6378FZoDVfFfm6RRKC98VfckLjfLDcFqmqM5tkpnO5bOENKkK2H4t6oVfB2r6UuYk0B1AQeFkjpWk1rH+hzH4xAcr6uRz+sOvq03hKrZ2iTvADRe+bqSNIyheMZweern9IMMLkrDdwTHhQH3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsHZiVMB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsHZiVMB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806651F00A3D;
	Wed, 29 Jul 2026 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352095;
	bh=6XYtWMKFjZguAWHBnpy8AI+KEhl7SYuqNBkcHccipNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsHZiVMBPuYjneROEEkCHGt4PwlHvfDHWcqMp0zBM0eH4O5+zTQjA8inBeRxWK2I8
	 PXrMEz1TJff+c8PxCy4TFR5lnAXNMfxCDavhuAQxcRiWjwXcmd0ILvRQnqfdBASKvA
	 80Rxaz47R5JIx7NbPiZ3vYi9fengbDodEfzsIguWbYZeMacDbddgfzR12D6A4BycWq
	 exqM0OARNtnYBEuMDH4NC8Uqo5ar1aTsaGNHLlceHYcIlafWDS9Y0Z4GVZkCWXNqvL
	 YIrk2Meer5boFxCcYTyNk2xnw4ocUbSqj9LYOwMuneEpWzQqZG321WdQXg3FunXoLy
	 b3CpY9hrzJPJA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Aaron Merey <amerey@redhat.com>
Subject: [PATCH 16/31] dwarf_loader: Skip libdw__lock when elfutils is built thread-safe
Date: Wed, 29 Jul 2026 16:07:16 -0300
Message-ID: <20260729190733.72876-17-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

pahole serializes dwarf_getlocation(), dwarf_decl_file(), and
__dwarf_getlocations() calls behind libdw__lock because libdw's
internal caches (tsearch trees) are not thread-safe by default.

This mutex was added in commits 1caed1c443d4 ("Add a lock around
dwarf_decl_file() and dwarf_decl_line() calls") and 65b7fd68ccbb
("Use libdw__lock for dwarf_getlocation(s)") to work around
concurrency bugs in libdw.

Since then, elfutils has fixed the underlying issues:
  - 0.194: eu_tsearch with proper locking (ec21fbb47)
  - 0.194: rwlock replaced with __atomic builtins (680eb3021)
  - 0.195: additional last_abbrev_offset protection (8fa2cd1d3)

When elfutils is compiled with --enable-thread-safety it defines
_ELFUTILS_THREAD_SAFE in <elfutils/version.h>.  Use this to skip
the pahole-side mutex entirely, eliminating the serialization
overhead.

Profiling shows pthread_rwlock_tryrdlock + unlock from libdw's
internal locking accounts for ~15.6% of serial encoding time.
That overhead also disappears when elfutils is built thread-safe
(rwlock replaced with lock-free atomics in 0.194).

Before (serial, elfutils without --enable-thread-safety):
  15.6% in pthread_rwlock_{tryrdlock,unlock} (libdw internal)
  Plus serialization from pahole's libdw__lock mutex

After (serial, elfutils with --enable-thread-safety):
  Both overheads eliminated

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Aaron Merey <amerey@redhat.com>
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ce0bead0e76e1876..759883cad3fce693 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -57,7 +57,25 @@
 #define EM_RISCV	243
 #endif
 
+/*
+ * libdw internal caches (tsearch trees for locations, decl file/line, etc.)
+ * are not thread-safe unless elfutils was compiled with --enable-thread-safety.
+ * When that option is active, elfutils >= 0.194 uses eu_tsearch with proper
+ * locking and >= 0.194 also replaces the abbrev rwlock with __atomic builtins,
+ * eliminating the overhead that rwlock_tryrdlock imposed even in serial mode.
+ *
+ * _ELFUTILS_THREAD_SAFE is defined in <elfutils/version.h> when the library
+ * was built thread-safe.  When present we skip our own mutex; when absent we
+ * serialize the racy calls ourselves.
+ */
+#ifdef _ELFUTILS_THREAD_SAFE
+static inline void libdw__lock_lock(void)   { }
+static inline void libdw__lock_unlock(void) { }
+#else
 static pthread_mutex_t libdw__lock = PTHREAD_MUTEX_INITIALIZER;
+static inline void libdw__lock_lock(void)   { pthread_mutex_lock(&libdw__lock); }
+static inline void libdw__lock_unlock(void) { pthread_mutex_unlock(&libdw__lock); }
+#endif
 
 static uint32_t hashtags__bits = 12;
 static uint32_t max_hashtags__bits = 21;
@@ -453,11 +471,7 @@ static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
 	int ret = 1;
 
 	if (dwarf_attr(die, DW_AT_location, &attr) != NULL) {
-		/* use libdw__lock as dwarf_getlocation(s) has concurrency
-		 * issues when libdw is not compiled with experimental
-		 * --enable-thread-safety
-		 */
-		pthread_mutex_lock(&libdw__lock);
+		libdw__lock_lock();
 		if (dwarf_getlocation(&attr, expr, exprlen) == 0) {
 			/* DW_OP_addrx needs additional lookup for real addr. */
 			if (*exprlen != 0 && expr[0]->atom == DW_OP_addrx) {
@@ -471,7 +485,7 @@ static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
 			}
 			ret = 0;
 		}
-		pthread_mutex_unlock(&libdw__lock);
+		libdw__lock_unlock();
 	}
 
 	return ret;
@@ -516,7 +530,7 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 	tag->attributes = NULL;
 
 	if (cu->extra_dbg_info) {
-		pthread_mutex_lock(&libdw__lock);
+		libdw__lock_lock();
 
 		int32_t decl_line;
 		const char *decl_file = dwarf_decl_file(die);
@@ -531,7 +545,7 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 		dwarf_decl_line(die, &decl_line);
 		dtag->decl_line = decl_line;
 
-		pthread_mutex_unlock(&libdw__lock);
+		libdw__lock_unlock();
 	}
 
 	INIT_LIST_HEAD(&tag->node);
@@ -1470,7 +1484,7 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 	ptrdiff_t offset = 0;
 	int loc_num = -1;
 
-	pthread_mutex_lock(&libdw__lock);
+	libdw__lock_lock();
 	while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
 		bool had_stack_value;
 
@@ -1515,7 +1529,7 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 			break;
 		}
 	}
-	pthread_mutex_unlock(&libdw__lock);
+	libdw__lock_unlock();
 
 	parameter__finish_piece_decode(parm, die, conf, cu);
 }
-- 
2.55.0

