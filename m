Received: from smtp01.hmg9.webhuset.no (smtp01.hmg9.webhuset.no [46.226.9.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E30370AE2
	for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.9.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620290; cv=none; b=b1GqtWIfkvlA0C8j0ln78LDRhPAZ2n0siDFRAuBgFGkGBEQzjacsxNIQriou5Ednx8e8VMs45ruCZfBpKfxd2vgz12un7LVMetRLqVwWv5sqtz3lBpvVioMVBUS92ygJJBu/CGfrOo0NqGLn+U2c0ZaXIgVHHJOe2MRcD6vMdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620290; c=relaxed/simple;
	bh=l2dYTJBMOvX6jHIfSxbMOkEPRayW22aosIdRZ0+A1RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcYBYpZDGimhfJVbhjnWNzp0ndHup9xGkif4uN5pGihZhF9SuxpkJIHLH2fbxZdiovU7Th1BvOB+GI5ku8AwhAhTu19olpEVXXcb/qa/8M6gS7h4C5Iju0CLq487QfEcB2YYhQPTpbEYELVxtowKsXPWuZuXd4RcyKljalthcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pfft.no; spf=pass smtp.mailfrom=pfft.no; arc=none smtp.client-ip=46.226.9.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pfft.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfft.no
Received: from mail.pfft.no (unknown [109.247.74.5])
	by smtp01.hmg9.webhuset.no (Postfix) with ESMTPA id 94900815D2
	for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 20:23:15 +0200 (CEST)
From: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
To: dwarves@vger.kernel.org
Cc: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
Subject: [PATCH 1/1] prefcnt: guard against NULL function parameters
Date: Mon, 28 Sep 2026 20:21:46 +0200
Message-ID: <20260928182217.301003-2-havard.f.aasen@pfft.no>
In-Reply-To: <20260928182217.301003-1-havard.f.aasen@pfft.no>
References: <20260928182217.301003-1-havard.f.aasen@pfft.no>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When prefcnt is started without an input file, it loads the running
kernel's debugging information through the existing vmlinux/BTF/ELF
loading path. While walking the functions in the resulting
compilation units, some function parameter entries can be represented
by a NULL pointer.

refcnt_function() passes each entry from function->proto.parms to
refcnt_parameter(). refcnt_parameter() dereferences the entry when it
checks parameter->tag.type, causing prefcnt to terminate with a
segmentation fault if the entry is NULL.

For example, the failure is visible in the following backtrace:

  #0  0x0000555555555670 in refcnt_function (function=0x5555563e7a40, cu=0x555555559070)
    at /srv/git/dwarves/prefcnt.c:113
        __mptr = 0x555555559070
        parameter = 0x0
  #1  0x00005555555556fe in cu_refcnt_iterator (cu=0x555555559070, cookie=0x0) at /srv/git/dwarves/prefcnt.c:125
        pos = 0x5555563e7a40
        id = 55272
  #2  0x00007ffff7f079a6 in cus__for_each_cu (cus=0x555555559010, iterator=0x5555555556aa <cu_refcnt_iterator>,
    cookie=0x0, filter=0x0) at /srv/git/dwarves/dwarves.c:2094
        cu = 0x555555559070
        pos = 0x555555559070
  #3  0x000055555555588d in main (argc=1, argv=0x7fffffffde78) at /srv/git/dwarves/prefcnt.c:162
        err = 0
        cus = 0x555555559010

Treat a NULL parameter entry as an absent parameter and return before
accessing its members. This allows us to continue processing the
remaining debug information.

Signed-off-by: Håvard F. Aasen <havard.f.aasen@pfft.no>
---
 prefcnt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/prefcnt.c b/prefcnt.c
index 37ca18f..b027f4d 100644
--- a/prefcnt.c
+++ b/prefcnt.c
@@ -37,6 +37,10 @@ static void refcnt_member(struct class_member *member, const struct cu *cu)
 static void refcnt_parameter(const struct parameter *parameter,
 			     const struct cu *cu)
 {
+	if (parameter == NULL) {
+		return;
+	}
+
 	if (parameter->tag.type != 0) { /* if not void */
 		struct tag *type = cu__type(cu, parameter->tag.type);
 		if (type != NULL)
-- 
2.53.0

