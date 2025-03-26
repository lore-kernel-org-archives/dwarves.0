Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0501A3162
	for <dwarves@vger.kernel.org>; Wed, 26 Mar 2025 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022139; cv=none; b=D6DOKMYW+BEXcXmveFvakXSWX4tpiaV0qvtLen3Gx7eb0E3DtcDpzNSwNFGPgZXkAt8dQVg4WWuEcPX+aXGFDfSavo261ngNRWDh8vqnDwpxojSLf7cSA3oMWZdj6q3uaKLM/rotgA3uoqXOydwinQdPrFwdpvo4T0MohN8F//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022139; c=relaxed/simple;
	bh=N5qUsMdnGo88DDwdic8+gXp8TJu6K6Mc6HErbsgcCA4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=bhHaq5+a+IQ4PeQRNKjJXwIKQ8OepscOu133qPdSxiBqIs+NU0fZIGKBEcnTWQGBsjWE436moOr5kzVFiVjecVRKH3jU8xASifX1Ztu3/aaN4t8xO9Re/Tn670jx5YDFPE+7xy0VYOfaEFYfh6sfz2iNivDkrj8tE2oT+NAQSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vWijCsQD; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vWijCsQD"
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743022134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iibeNJoxvhP5emYhzlu+CHNRDe1HSzJL6Z61xVN1Abw=;
	b=vWijCsQDDMJAnPzsDYffymY6JfaX4AW19vuaGP81I15uybRTtnV6bSVtR5YASe1x6i1VrH
	TjqiFSEu7uzlxLxi8F6g18M9lY34Q2ckECRvupVR6PfondTKWlfwZQLn6ltcJyL/6Ltmnt
	wLvIjru4v10gjA+VwLznj6M0n90zCXM=
Date: Wed, 26 Mar 2025 20:48:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <83315e0bce204f7745448fff550574d44b09b4c1@linux.dev>
TLS-Required: No
Subject: Re: parallel pahole hangs while building modules from
 nvidia-open-kernel-dkms
To: "Domenico Andreoli" <domenico.andreoli@linux.com>,
 dwarves@vger.kernel.org
In-Reply-To: <Z-JzFrXaopQCYd6h@localhost>
References: <Z-JzFrXaopQCYd6h@localhost>
X-Migadu-Flow: FLOW_OUT

On 3/25/25 2:10 AM, Domenico Andreoli wrote:
> Hi,
>
>   This a forward of Debian bug report [0] where you can find more
> details. At [1] and [2] you can get the kernel and module to reproduce.
> I could reproduce on both amd64 and arm64 using pahole 1.29.
>
> This is marked as serious severity because it makes the autobuilder han=
g
> as well [3].
>
> Could you please help?
>
> Regards,
> Domenico

Hi Domenico, thanks for the bug report.

I debugged the hanging, and it appears that "abort" handling in case
of a BTF encoding error was overlooked in recent changes to speedup
parallel encoding.

Could you please try the diff below, and check if it resolves the
hanging?


diff --git a/dwarf_loader.c b/dwarf_loader.c
index 84122d0..e1ba7bc 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3459,6 +3459,7 @@ static struct {
 	 */
 	uint32_t next_cu_id;
 	struct list_head jobs;
+	bool abort;
 } cus_processing_queue;
=20
=20enum job_type {
@@ -3479,6 +3480,7 @@ static void cus_queue__init(void)
 	pthread_cond_init(&cus_processing_queue.job_added, NULL);
 	INIT_LIST_HEAD(&cus_processing_queue.jobs);
 	cus_processing_queue.next_cu_id =3D 0;
+	cus_processing_queue.abort =3D false;
 }
=20
=20static void cus_queue__destroy(void)
@@ -3535,8 +3537,9 @@ static struct cu_processing_job *cus_queue__enqdeq_=
job(struct cu_processing_job
 		pthread_cond_signal(&cus_processing_queue.job_added);
 	}
 	for (;;) {
+		bool abort =3D __atomic_load_n(&cus_processing_queue.abort, __ATOMIC_S=
EQ_CST);
 		job =3D cus_queue__try_dequeue();
-		if (job)
+		if (job || abort)
 			break;
 		/* No jobs or only steals out of order */
 		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_que=
ue.mutex);
@@ -3653,6 +3656,9 @@ static void *dwarf_loader__worker_thread(void *arg)
=20
=20	while (!stop) {
 		job =3D cus_queue__enqdeq_job(job);
+		if (!job)
+			goto out_abort;
+
 		switch (job->type) {
=20
=20		case JOB_DECODE:
@@ -3688,6 +3694,8 @@ static void *dwarf_loader__worker_thread(void *arg)
=20
=20	return (void *)DWARF_CB_OK;
 out_abort:
+	__atomic_store_n(&cus_processing_queue.abort, true, __ATOMIC_SEQ_CST);
+	pthread_cond_signal(&cus_processing_queue.job_added);
 	return (void *)DWARF_CB_ABORT;
 }
=20
@@=20-4028,7 +4036,7 @@ static int cus__process_file(struct cus *cus, str=
uct conf_load *conf, int fd,
=20
=20	/* Process the one or more modules gleaned from this file. */
 	int err =3D dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
-	if (err < 0)
+	if (err)
 		return -1;
=20
=20	// We can't call dwfl_end(dwfl) here, as we keep pointers to strings
--=20
2.48.1


>
>
>=20The command to succeed:
>
> This simplified (sequential) command succeeds:
>
> cp nvidia-modeset.base.ko nvidia-modeset.ko
> LLVM_OBJCOPY=3D"x86_64-linux-gnu-objcopy" pahole -J --btf_features=3Den=
code_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_f=
unc,decl_tag_kfuncs --btf_features=3Ddistilled_base --btf_base vmlinux nv=
idia-modeset.ko -j1
> echo $?
>
> producing this output:
> =3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> Unsupported DW_TAG_reference_type(0x10): type: 0x28172
> Error while encoding BTF.
> 0
> =3D=3D=3D=3D=3D >8 =3D=3D=3D=3D=3D
>
>
> While this (parallel) command hangs:
>
> cp nvidia-modeset.base.ko nvidia-modeset.ko
> LLVM_OBJCOPY=3D"x86_64-linux-gnu-objcopy" pahole -J --btf_features=3Den=
code_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_f=
unc,decl_tag_kfuncs --btf_features=3Ddistilled_base --btf_base vmlinux nv=
idia-modeset.ko -j2
> echo $?
>
> producing this output:
> =3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> Unsupported DW_TAG_reference_type(0x10): type: 0x28172
> Error while encoding BTF.
> Terminated
> 143
> =3D=3D=3D=3D=3D >8 =3D=3D=3D=3D=3D

Please note that even though the sequential command succeeds, the BTF
output is going to be incomplete (and potentially invalid). The
underlying issue is that there is an unhandled DW_TAG in the BTF
encoder. The encoding process exits on errors like this.

It would be nice if you provided all the input (base vmlinux and the
module) that led to this error, so we could investigate.

Thank you!

>
>
> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1100503
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D1;bug=3D1100503=
;filename=3Dvmlinux.zst;msg=3D19
> [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D1;bug=3D1100503=
;filename=3Dnvidia-modeset.base.ko.zst;msg=3D12
> [3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1101262
>
