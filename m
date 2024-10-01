Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2F19FA9D
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811394; cv=none; b=jkoF8RKW1I4+C9m79PQq7vcOpbJlxr+xujOgTpf8rEfrsR58Xd9rzZ8Y1+P2/xA81D0uDvinoD21MNQ7W5Y2i8sXNffsu6iQHsWD8ce4gTMhcOQfdaTH9Vii2xziBVxGS3uscDAbtXZCfqRnkclasLzcrtfpMrDha3Uf/WeZVPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811394; c=relaxed/simple;
	bh=mlKXRpzSsYKBTlC4p+tQKjrJb0Ka1gWR95ogjGiFzos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cixuiwprJ9nj3wKzidVhL/b8cSFiMKgfywgJ2Oj7HlwwLIBqtTCFIg+zpewCLoJQxb1N6VCuPpy7hKY8VheeB9dcKH7kYw9XuhrhVwcJMWF62dyJ99MqmFsDTFAO/NgglgBFKUbITjgun8A5dRH670v0/gniwaKn4m5JRdWCOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETz4aCL+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETz4aCL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D25C4CEC6;
	Tue,  1 Oct 2024 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727811394;
	bh=mlKXRpzSsYKBTlC4p+tQKjrJb0Ka1gWR95ogjGiFzos=;
	h=Date:From:To:Cc:Subject:From;
	b=ETz4aCL++bjhHedA+BQ1fYgTW19Vu0foVuR9UEwTrq25CXXj7bxG6icxZUp/e6kQH
	 YpXU+f1n1ITLtaf84dHh/qBEFVJlyPIotJHUp50EEpcZyL/S+Ggd+pAmIxrv2cxrXU
	 ppGCQYyW/E6UvXLV7iDojXrp1wClChVU2uGUcm6YRtb/InXx0cIqSjNU1FGF+7PFTO
	 K1n76e4Xpc2KbmLtlvpW28JLwXeCnKZ9Lwn3y/6Fn7clUbIvIqXQGaCMREtIdivIlN
	 XyWCYhfWkcs7s4EI2QoOuGEFcS46G3ARJpCmVL6DOgIy5fOKcvbgErj92xsVi5N7gH
	 rRTwXpi0z5W6g==
Date: Tue, 1 Oct 2024 16:36:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Subject: [PATCH 1/1] tests reproducible_build.sh: Try first to find a vmlinux
 using pahole --running_kernel_vmlinux
Message-ID: <ZvxPPsyEccL5DmD6@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Otherwise it stops working when called directly.

Cc: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/reproducible_build.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index a3603798a26de94c..b2e4d7af8e9ce35b 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -4,8 +4,6 @@
 # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
 # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
 
-vmlinux=${vmlinux:-1}
-
 if [ -z "$vmlinux" ] ; then
 	vmlinux=$(pahole --running_kernel_vmlinux)
 	if [ -z "$vmlinux" ] ; then
@@ -14,6 +12,8 @@ if [ -z "$vmlinux" ] ; then
 	fi
 fi
 
+vmlinux=${vmlinux:-1}
+
 if [ ! -f "$vmlinux" ] ; then
 	echo "$vmlinux file not available, please specify another"
 	exit 2
-- 
2.46.2

