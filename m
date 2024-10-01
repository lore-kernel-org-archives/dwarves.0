Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E319FA9D
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811542; cv=none; b=GAUDbKKz38NFcQXilfirrE4ccxKvVTX5j6lIWIJqptCtq2qetQUwkCZtlulZw5Vcu3igyVIN0FXibr5nGsGQIoaqJUb857CYTnXrfl/TQqAjfU+aoKZoSFqqaWS/Iszwdn5OvtoMu36m9mjV6Qh4odzjVNsgjYgRvP3F3VUGRI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811542; c=relaxed/simple;
	bh=Ch035NfsQR8adp5YM64MstPzAtgHvOPu0XaNE/j9P1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IWfZN2mKpilyy2RXhjRdF41w5Zin4UVgKaT8hRgA5D+Um62kkJdUxvjGQHM4ttzm1btSmBWMNVPZ89nsrK63PpHxEYVx6KmQ2DA56Z186e0P+WCC8onoaXzGx31hLqi68mxz6RMOIo/ljy923X8OPcFmTUZg8uw4XJuZUQIB/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtB+CSdS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtB+CSdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A0EC4CEC6;
	Tue,  1 Oct 2024 19:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727811542;
	bh=Ch035NfsQR8adp5YM64MstPzAtgHvOPu0XaNE/j9P1Y=;
	h=Date:From:To:Cc:Subject:From;
	b=YtB+CSdSSh4DWoURbZ8T1PbcXN7jtJkFsYgBOJobhvP13q2LJe0rPuYskAnjvc3bC
	 Gr7yd7a+mf9rK969KujJ9N4PX4Z2m4eZeezNSMPHTn+ApLDjuCILWr9LSMpNOSHUV+
	 d6DTycEnykeIZ+9islzPixnEUJDify8QcyB9kbkGkpJXycM7MWgMqC7AagdkhSrqqB
	 NGaJEG8hWRe0OUZHUp1Do1zccKj3+3fXUlpc3exNHPczCBwJ8nxE3KXK9sKno7DVEG
	 65VZgjl1OzXinkxE0zZbTRE9Er+ua/HESEuEIGJc0MLAwDrMoIQygtgNOTjMyU00l/
	 /lu88TLJAoBGA==
Date: Tue, 1 Oct 2024 16:38:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Subject: [PATCH v2 1/1] tests reproducible_build.sh: Try first to find a
 vmlinux using pahole --running_kernel_vmlinux
Message-ID: <ZvxP0n0W5b-5rxA_@x1>
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
 tests/reproducible_build.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index a3603798a26de94c..19ef22708bbc969f 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -4,16 +4,12 @@
 # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
 # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
 
-vmlinux=${vmlinux:-1}
-
 if [ -z "$vmlinux" ] ; then
 	vmlinux=$(pahole --running_kernel_vmlinux)
-	if [ -z "$vmlinux" ] ; then
-		echo "Please specify a vmlinux file to operate on"
-		exit 2
-	fi
 fi
 
+vmlinux=${vmlinux:-1}
+
 if [ ! -f "$vmlinux" ] ; then
 	echo "$vmlinux file not available, please specify another"
 	exit 2
-- 
2.46.2

