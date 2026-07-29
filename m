Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23CA463B84;
	Wed, 29 Jul 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352105; cv=none; b=TKFtwnLAndA457gbGEl7Qswv+07KT2MmeMq68wM2tdnCT5byW88Zef5brMRFfA44afeqhhfquG8NmkbS9dOgS/ZsLyrh+ir5gIP77AOgfGzt4C/Wy1h3mlKKs6XQNIBg1wS8teCT06WOspsDgm9ceudm+boD2S1+YF8AJXx60uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352105; c=relaxed/simple;
	bh=uQtKjPhaGJtswv2Xpw/2oqueAJmSInxHbi6toyumHq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVi0FxfK4mDUkVyuNcVdV0ttoh2qZ/Yn6nHhwHqaNCsljtCWUKtx30KXcRm53cCDiGrYkmE4VkR0OwB9Cn66zF4gkr+2vBfOqTyHTNgqu8U/FiJE2LEVVjhCD789HwQGk80xuLTl+NPUmbk0dfnW/W8di/1gUvxlfCDc6Dx/8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrLiRLUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrLiRLUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD01E1F00A3A;
	Wed, 29 Jul 2026 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352104;
	bh=MCoqUPNW7qzL8cj5sk7MYjGaONfwe+i4v2FJ9t3iLdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mrLiRLUJbegoeEOhaoMmFQuYFzXVX1ZtE30znVgziDXfVyY0lhaxZrGqMDeizIYg9
	 VLhQX/ZS2hSijki/7VV0smJoXNNBaFT2+1dTKzkMb+Bii+IlNL1xPD0DABL1FsBl/J
	 +3BdjqhlQQrF1p5SlCc5Aq6nVUwhMs8K20xK4i41eYF+O7oGSdd64XjDZU3zU2vil3
	 YGZPfUyy5JNmJ7UIua4y26ppiDEYeurpXPUqcQt5ECxqmhG9EsHsJ+9QwRySgZMdDk
	 7eHiR1Pt+c6bryIN1lW6R/RcMhaErrUgt4ly0EsNd5UltomT28w3m14kb0Je3QZAoP
	 LgwgmMNOx+IpA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/31] dutil: Add exec_objcopy() shell-injection-safe helper
Date: Wed, 29 Jul 2026 16:07:20 -0300
Message-ID: <20260729190733.72876-21-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add exec_objcopy() that runs objcopy via posix_spawnp() instead of
system(), eliminating shell injection risk from filenames containing
shell metacharacters.

Signal handling follows POSIX system() semantics: SIGINT/SIGQUIT
ignored in parent during wait, SIGCHLD blocked, default dispositions
restored in child.

No callers yet — the next commit converts btf_encoder and libctf.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dutil.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dutil.h |  3 +++
 2 files changed, 75 insertions(+)

diff --git a/dutil.c b/dutil.c
index 14f134016add1f0c..38101f184faf58ee 100644
--- a/dutil.c
+++ b/dutil.c
@@ -9,9 +9,15 @@
 
 #include <ctype.h>
 #include <errno.h>
+#include <signal.h>
+#include <spawn.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+extern char **environ;
 
 void *zalloc(size_t size)
 {
@@ -234,3 +240,69 @@ char *strlwr(char *s)
 
 	return s;
 }
+
+int exec_objcopy(const char *objcopy, const char *add_section,
+		 const char *filename)
+{
+	sigset_t mask, orig;
+	struct sigaction ign, old_int, old_quit;
+	posix_spawnattr_t attr;
+	sigset_t child_default;
+	pid_t pid;
+	int rc;
+
+	char *argv[] = {
+		(char *)objcopy,
+		"--add-section", (char *)add_section,
+		"--", (char *)filename,
+		NULL
+	};
+
+	/* Ignore SIGINT/SIGQUIT in parent while waiting, per POSIX system() */
+	ign.sa_handler = SIG_IGN;
+	sigemptyset(&ign.sa_mask);
+	ign.sa_flags = 0;
+	sigaction(SIGINT, &ign, &old_int);
+	sigaction(SIGQUIT, &ign, &old_quit);
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGCHLD);
+	pthread_sigmask(SIG_BLOCK, &mask, &orig);
+
+	posix_spawnattr_init(&attr);
+	/* Restore default signal disposition and mask in child */
+	sigemptyset(&child_default);
+	sigaddset(&child_default, SIGINT);
+	sigaddset(&child_default, SIGQUIT);
+	posix_spawnattr_setsigdefault(&attr, &child_default);
+	posix_spawnattr_setsigmask(&attr, &orig);
+	posix_spawnattr_setflags(&attr,
+				 POSIX_SPAWN_SETSIGDEF | POSIX_SPAWN_SETSIGMASK);
+
+	rc = posix_spawnp(&pid, objcopy, NULL, &attr, argv, environ);
+	posix_spawnattr_destroy(&attr);
+
+	if (rc != 0) {
+		sigaction(SIGINT, &old_int, NULL);
+		sigaction(SIGQUIT, &old_quit, NULL);
+		pthread_sigmask(SIG_SETMASK, &orig, NULL);
+		return rc == ENOENT ? -ENOENT : -1;
+	}
+
+	int status;
+
+	while (waitpid(pid, &status, 0) == -1) {
+		if (errno != EINTR) {
+			status = -1;
+			break;
+		}
+	}
+
+	sigaction(SIGINT, &old_int, NULL);
+	sigaction(SIGQUIT, &old_quit, NULL);
+	pthread_sigmask(SIG_SETMASK, &orig, NULL);
+
+	if (status == -1 || !WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status) == 0 ? 0 : -1;
+}
diff --git a/dutil.h b/dutil.h
index be02c68cf4a7ff22..603556fa03085abf 100644
--- a/dutil.h
+++ b/dutil.h
@@ -351,6 +351,9 @@ static inline int elf_getshdrstrndx(Elf *elf, size_t *dst)
 
 char *strlwr(char *s);
 
+int exec_objcopy(const char *objcopy, const char *add_section,
+		 const char *filename);
+
 void __zfree(void **ptr);
 
 #define zfree(ptr) __zfree((void **)(ptr))
-- 
2.55.0

