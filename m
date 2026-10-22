Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792641376;
	b=TMYMeKuO03xQDeLjlJ3rvkpxX9eLQtvUaQcdUuj3xfOMg+/wJEVm5QZDNsVWjD8IizxT
	 t6LfxBDQrdJzndsdo2sxN+GF2am1SQl0LsofUx4/njqktK70rmmVFhA5qbvDOLnnH5L5P
	 K61sSEO6vQEag6e/BDfH7PxU56DJFTEU1LDVvp2W/8CYW0By7xWuW1v5wXQ8H0KIcoGPh
	 XrLtR/YiefiyqXhXTN0hoafVKEOA5In5waWGUTcNTcdN1zv+ndx+ZFXxzLAmxZOtzZui4
	 H1e4YhGHLSraU25bgT69HXbIOmGwjI6V5xnyiA3xZV+Dnufy7DSvLcYsyrFtP9kFfdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641376;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=arJS5zNxUZ/NsGOvG25bBRIXPW4pIJreaSXkDHOo//Y=;
	b=Jgl3RtTsZqiYsbGMrEuA+OtWrOSjMKgxdBdXBOmqxgPfi54D0IkYjFc8Chu3BbdBOE+z
	 lbHrVRXvbnh4oJc5H7BjDKTzBBzYGBoGADPHJaxGGlE8Cc8aX19Xjv22PHyzFMHIL5j+T
	 JHNErv3FayuT3VsJs6r93GCPQeWkuD0m1s/umd/nfoz8gZVP8+bThxd+yzCBbHecRQwtx
	 PqORREd63qWXzzgEvMlo02QY3VorR9cw5VzX3yQWLG89b4kts9sk9fN79nU1bSzTafb79
	 JRqsPiE6Fi/KwBiY6QMvteRP6yc2Kyodb373QmnT5XPzMqufdtS3/sV9sCf8kgPCJ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LeQUsW40;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FiEQZqdn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9173606A31A
	for <dwarves@vger.kernel.org>; Thu, 22 Oct 2026 03:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9173606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LeQUsW40;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FiEQZqdn
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M3jA1N2293482
	for <dwarves@vger.kernel.org>; Thu, 22 Oct 2026 03:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=arJS5zNxUZ/NsGOvG25bBRIXPW4pIJreaSX
	kDHOo//Y=; b=LeQUsW40ies3oRJ6NXI5D45tXsY8K8JK+TzsTv+jloVMPQ3qzkc
	u711Sd+tNWvFJFgvP9yCrZj/jA89v5B/1MVk4fKqmTBVbq738WZnF7UMSuP7KjBK
	eXKGG74ilVaQ/lkdpNxJyEQ1TnoNTzPhqw+A/HwqxSSYksaj5ITK8tPzB+z2tOg+
	mvbAeZj0uVw73fMr4jzFLCKb3ZyFktXd7P3tATriigQrNRr2nL7g6xPR4BelDw/9
	Nt9Az2vP65mqRV1tKzVa5ZqI+GQyvhyQ+cqEKPT6EVI5ssPQjJGJXsTJjivC5VTN
	S8e/HM1wsP6bGC9Cs+vQ4CtlfF5NjDZQCRA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93brj58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dwarves@vger.kernel.org>; Thu, 22 Oct 2026 03:56:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac450b74b0so2516022a91.0
        for <dwarves@vger.kernel.org>; Wed, 21 Oct 2026 20:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792641374; x=1793246174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=arJS5zNxUZ/NsGOvG25bBRIXPW4pIJreaSXkDHOo//Y=;
        b=FiEQZqdnLY8Mc6vN3JBfnRCPESuT4rgZyMh9ZQZTIpkxSR7GmvwPndOAM/U/ec+tDF
         v/ON8vfBr5/gskK6GFIWSrFXSHv32EGxeKTt4WLTwB91kVHQj5EDV1IKuu+dwnv+KM+A
         Jl7Vj3h7qSWzEOaEQgMZTFgu0BtcK2xk9/O6LJPANhj+U3d9UT4cQSJ37dQkGLwyfosc
         qwXkGhGEO1F1YMgUssmjDJSqs2Vs34wSEaOasXkNyOW6vJmnvJ+MvDTArfZZu9QAnV60
         LZcw418Egsy49mWbJ4qCZgf7G+vwmXF7skWxmFdv43/Pke7MjQylpn+fKHyred/gG41D
         k5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792641374; x=1793246174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=arJS5zNxUZ/NsGOvG25bBRIXPW4pIJreaSXkDHOo//Y=;
        b=qVZtruA36iuaIifBQ6oCAc94Dq513AF0FAg0iwnWKfRDELyBxhfCifgYJvZUwYZeoA
         Xnizr/RY23/9qGDaVmi83fROzOPho3V4IN3FqNyCbDlHfrBSOHYq+ztEXUH4jahB/5ZE
         Pf3gchsIf380LJ2cHopgwmQKid8JYZ7cJwZMM3C0ANdHfHt66xH07l/PUm2+SH8og9tn
         1Mz/+Co8cphi5AMQOzTFIxXDCMvBt4WX+9i9el4GMJLf8xJ/QCrAwisvS5uJyn/fr7Xg
         dKl1tdxxeBaPSyami/TvgVSVcu+soEgsIbO9CNvSxu9LVdYiMz/8ds7Icnj/woEi0Y9f
         603Q==
X-Gm-Message-State: AFq9FYJACw4111xh0LRJKgwDpS34CBJaa4CL6m/AVkHBdD+rkMqksc/A
	UCeWC6lAImLWcj+EO2oflcEs+danr/eRiDiDQujZjlSFHSmyaLCltdAYLufz8y/FtLly7N0Y9j+
	3/tc6KiFT5qoZIDhaJ3+fBPRHGqyfbxuDlRJHQWrnZakv0hHLq9ykSI625JT5UKNLLCTLWKk=
X-Gm-Gg: AYBFou2JpUokHSNlnPBlJzY1EQo4QRUAGbsWS/mfuKKNRzwZ4sU689KMCC45NzHEVqO
	K4TjQBat1q8nKxi8k898Q8fD/CyG1yYLr+6hlgy+WBrwQdQ0FlGmVzAv16AgvML0yO/b4+4gazS
	Iaqwap5HxHCzYsTiG82tP+8Xkw7D70tC5tyDJkz4Zik4kKZFH3ToYfllmwfsPJsxWsOwsgqup/x
	h1AP0koKhl05QqGZS6Dda8c5nEXJKSvxK2Ffl4Sroj7KDgDFVlqh2aI4TzUv81nA740JXtExN9R
	BZBmilD7c0jlV3GohJfdggh8guNC8d8h96g55c6lgvNoSUKOxOdnWvyD2O8pm6M4FQIB2MqmJzN
	e8fijBLGE3wCackzizPRaULXD6br/dRHuz4xVc8FwazKBI5vQR4jMJjFr22aw/7nYxS1cHvV/7T
	vfUFSCjAQnnanQOxRQvG6q/JJ+EszaDIy6ih+mYA==
X-Received: by 2002:a17:90b:3b90:b0:3ac:8527:3fc5 with SMTP id 98e67ed59e1d1-3ad86afbde1mr3512809a91.3.1792641373556;
        Wed, 21 Oct 2026 20:56:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3b90:b0:3ac:8527:3fc5 with SMTP id 98e67ed59e1d1-3ad86afbde1mr3512795a91.3.1792641372929;
        Wed, 21 Oct 2026 20:56:12 -0700 (PDT)
Received: from ip-172-31-25-255.us-west-2.compute.internal (ec2-35-83-207-173.us-west-2.compute.amazonaws.com. [35.83.207.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad82f10c0asm3577100a91.0.2026.10.21.20.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 20:56:12 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, bpf@vger.kernel.org
Subject: [PATCH] dutil: Split the objcopy command into words in exec_objcopy()
Date: Thu, 22 Oct 2026 03:56:04 +0000
Message-ID: <20261022035604.3183589-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EhTQWd9k2nAuo0iFpaDqIrjSlvaGG4Bd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAxNSBTYWx0ZWRfX/hgH2p/MPQ0j
 OOPhDZOsMIl9G5kqprezLDzxapDUXR/Ri91+6P47vqXTC5Xre9KzoMljfNFjFOaZkGTGLOV+YAL
 p3yAvHslZmJ7MZb3Qla239JjdLvHr6gpDiRXWzlx6Ec6UdRtTut+MO3FUTSFtWke/fRZM2cnC26
 zv20SQ6sfIFH24GLBvvgjvclNqcsEeSp2IR6Xj76wojyV6BAhdBEOt+8ZcbDq4Map6g+p/ePbBK
 TQotCdnZttpP+Qw6+Hp/v7nK8KWH44d8aISZwz9jevo0PgTNaRFVMpMyJ/XRr8+0A7CCDa1aKq2
 qA8nlOAJJ/HT6QzOo6bwQ4I5dHvbYGe1dS2OusDrs5Y7No9sOv85d+Zd5frv7TD6ooWM9bFIzRq
 FMm/aIdrfZ/5XTUJOv4cHtkLdgxOks/PaD01guYQzcRq+2uJtuMNg/FzzOEMdmGQrPyIVoLRCR8
 XWe8mBE/Btm339ksTpw==
X-Authority-Analysis: v=2.4 cv=HJxWhYtv c=1 sm=1 tr=0 ts=6ad9895e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=P2/bgbqRawb6I1+7fxbs5g==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=UMD6BtbPmZM_AR24lCYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAxNSBTYWx0ZWRfX+QVGX2clXFkf
 Tb9MTnA90gSo8xze83lKnz3VNxb9nh0HwpJF+FVsVU8uwa1r9jzW/9Sx/ZWriEhfZ4VTBXQTdEH
 bV/SDS85OcISMya0hL0LR9sNsqWG2FM=
X-Proofpoint-ORIG-GUID: EhTQWd9k2nAuo0iFpaDqIrjSlvaGG4Bd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220015

pahole 1.31 ran objcopy through system(), so LLVM_OBJCOPY was a command
line that could carry options, like the $(OBJCOPY) make variable the
kernel build sets it from. Since the switch to exec_objcopy() the whole
value of LLVM_OBJCOPY or OBJCOPY is passed to posix_spawnp() as the
program name, so a value such as "objcopy --some-option", or one with a
trailing blank, fails with ENOENT.

Kernel builds up to v6.19, including the LTS branches, run
LLVM_OBJCOPY="${OBJCOPY}" pahole -J from link-vmlinux.sh and use
${OBJCOPY} unquoted for their own objcopy calls in the same script, so
an OBJCOPY that works for the rest of the build now stops the link with:

  btf_encoder__write_elf: failed to add .BTF section to '.tmp_vmlinux1'

This breaks OpenEmbedded kernel builds, where OBJCOPY carries the
machine's objcopy options and ends with a blank when there are none.

Split the command on blanks, like the shell's word splitting did with
system(), for OBJCOPY as well. Quotes are not interpreted, so a path
containing blanks can no longer be used, either quoted as with system()
or as is as with v1.32. Name the file as both input and output, so that
a stray word in the command makes objcopy fail instead of being taken
as its input file and replacing the target.

Extend btf_write_elf.sh to check that options in LLVM_OBJCOPY reach
objcopy.

Fixes: 6789ef8a16d5 ("btf_encoder: Fall back to objcopy when llvm-objcopy is not available")
Assisted-by: Claude Code:claude-opus-5-5
Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 dutil.c                | 55 +++++++++++++++++++++++++++++++++---------
 tests/btf_write_elf.sh | 34 ++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/dutil.c b/dutil.c
index 38101f1..d333d41 100644
--- a/dutil.c
+++ b/dutil.c
@@ -248,15 +248,43 @@ int exec_objcopy(const char *objcopy, const char *add_section,
 	struct sigaction ign, old_int, old_quit;
 	posix_spawnattr_t attr;
 	sigset_t child_default;
+	char *cmd, *word, *saveptr, **argv;
+	int argc = 0;
 	pid_t pid;
 	int rc;
 
-	char *argv[] = {
-		(char *)objcopy,
-		"--add-section", (char *)add_section,
-		"--", (char *)filename,
-		NULL
-	};
+	/*
+	 * objcopy may come from $LLVM_OBJCOPY or $OBJCOPY, which the kernel
+	 * build sets from its $(OBJCOPY) make variable, a command line that
+	 * can carry options, so split it into words on blanks, as the shell
+	 * did with system(), but without interpreting quotes or escapes.
+	 * A string of n characters has at most (n + 1) / 2 words.
+	 */
+	cmd = strdup(objcopy);
+	argv = calloc((strlen(objcopy) + 1) / 2 + 6, sizeof(*argv));
+	if (cmd == NULL || argv == NULL) {
+		rc = -1;
+		goto out_free;
+	}
+
+	for (word = strtok_r(cmd, " \t\n", &saveptr); word != NULL;
+	     word = strtok_r(NULL, " \t\n", &saveptr))
+		argv[argc++] = word;
+
+	if (argc == 0) {
+		rc = -ENOENT;
+		goto out_free;
+	}
+
+	argv[argc++] = "--add-section";
+	argv[argc++] = (char *)add_section;
+	/*
+	 * Name the output file too, so that a stray word in the command
+	 * makes objcopy fail instead of becoming its input file.
+	 */
+	argv[argc++] = "--";
+	argv[argc++] = (char *)filename;
+	argv[argc++] = (char *)filename;
 
 	/* Ignore SIGINT/SIGQUIT in parent while waiting, per POSIX system() */
 	ign.sa_handler = SIG_IGN;
@@ -278,14 +306,15 @@ int exec_objcopy(const char *objcopy, const char *add_section,
 	posix_spawnattr_setflags(&attr,
 				 POSIX_SPAWN_SETSIGDEF | POSIX_SPAWN_SETSIGMASK);
 
-	rc = posix_spawnp(&pid, objcopy, NULL, &attr, argv, environ);
+	rc = posix_spawnp(&pid, argv[0], NULL, &attr, argv, environ);
 	posix_spawnattr_destroy(&attr);
 
 	if (rc != 0) {
 		sigaction(SIGINT, &old_int, NULL);
 		sigaction(SIGQUIT, &old_quit, NULL);
 		pthread_sigmask(SIG_SETMASK, &orig, NULL);
-		return rc == ENOENT ? -ENOENT : -1;
+		rc = rc == ENOENT ? -ENOENT : -1;
+		goto out_free;
 	}
 
 	int status;
@@ -302,7 +331,11 @@ int exec_objcopy(const char *objcopy, const char *add_section,
 	pthread_sigmask(SIG_SETMASK, &orig, NULL);
 
 	if (status == -1 || !WIFEXITED(status))
-		return -1;
-
-	return WEXITSTATUS(status) == 0 ? 0 : -1;
+		rc = -1;
+	else
+		rc = WEXITSTATUS(status) == 0 ? 0 : -1;
+out_free:
+	free(argv);
+	free(cmd);
+	return rc;
 }
diff --git a/tests/btf_write_elf.sh b/tests/btf_write_elf.sh
index 64ce128..dc512e0 100755
--- a/tests/btf_write_elf.sh
+++ b/tests/btf_write_elf.sh
@@ -14,6 +14,9 @@
 #   exists from the first encode.  pahole opens the ELF with ELF_C_RDWR,
 #   overwrites the Elf_Data buffer in place, and calls elf_update() --
 #   no objcopy needed.  This is the "Existing .BTF section found" path.
+#
+# Path 1 is run again with options in LLVM_OBJCOPY, as kernel builds up to
+# v6.19 pass their $(OBJCOPY) command line there.
 
 . "$(dirname "$0")/test_lib.sh"
 outdir=$(make_tmpdir)
@@ -115,4 +118,35 @@ if [ "$has_bpftool" -eq 1 ]; then
 	info_log "BTF content valid after overwrite (elf_test found): ok"
 fi
 
+# --- Path 1 with options in LLVM_OBJCOPY ---
+# Kernel builds up to v6.19 run LLVM_OBJCOPY="${OBJCOPY}" pahole -J, and
+# $(OBJCOPY) is a command line that may carry options or trailing whitespace.
+# --preserve-dates keeps the old timestamp only if the option reaches objcopy.
+
+objcopy=${LLVM_OBJCOPY:-$OBJCOPY}
+if [ -z "$objcopy" ]; then
+	objcopy=objcopy
+	command -v llvm-objcopy > /dev/null 2>&1 && objcopy=llvm-objcopy
+fi
+args_obj="$outdir/write_elf_args_test.o"
+args_ref="$outdir/write_elf_args_test.ref"
+cp "$obj" "$args_obj"
+touch -t 200001010000 "$args_obj" "$args_ref"
+
+if ! LLVM_OBJCOPY="$objcopy --preserve-dates " pahole -J "$args_obj" 2>/dev/null; then
+	error_log "FAIL: pahole -J with options in LLVM_OBJCOPY failed (exit code != 0)"
+	test_fail
+fi
+
+if ! readelf -S "$args_obj" 2>/dev/null | grep -q '\.BTF[[:space:]]'; then
+	error_log "FAIL: .BTF section not found with options in LLVM_OBJCOPY"
+	test_fail
+fi
+
+if [ -n "$(find "$args_obj" -newer "$args_ref")" ]; then
+	error_log "FAIL: options in LLVM_OBJCOPY did not reach objcopy"
+	test_fail
+fi
+info_log "pahole -J with options in LLVM_OBJCOPY: ok"
+
 test_pass
-- 
2.43.0

