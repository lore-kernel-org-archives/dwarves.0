Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF62E3385
	for <dwarves@vger.kernel.org>; Wed,  2 Apr 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626125; cv=none; b=XKQjDlXMuiNofN4lUi0qVn4vkxQaGfPf9xF7W52yIJrvhyG6ybxqQPW/0xpqIoNVQKxZiyk9AnxBRTr9WHhVJG3Grtnv1zh0eYQcS1pt22EIPVG7thssNL+Po/6+bHO3nn5mZquzxh0r3mST1kuz5krexLVmoanZs114sx6ANic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626125; c=relaxed/simple;
	bh=m5LNP9B6RCAZCKYlbRCXLdluhOr5pRK1jQDqw6j/5o8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YdFePRDqW7bC4qKiIRx1SJgnuiUACkk+lwSvLVYBuNpkNF7laRW4fdO4TRNqxFWBB+sGAth08SPhUA5gNi4YeXQUlJ07lH2c6JBI94nEUiDwe74yWGJqFAODP1Xq2s+OBp/vdj7ovAp3s6XJi6l4hP0ZrXn8G0Wlz8TWLvgcJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOiCfHJG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOiCfHJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3794FC4CEDD;
	Wed,  2 Apr 2025 20:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743626125;
	bh=m5LNP9B6RCAZCKYlbRCXLdluhOr5pRK1jQDqw6j/5o8=;
	h=Date:From:To:Cc:Subject:From;
	b=dOiCfHJGyKFQEwFcLfN6UIvz/PdkFLER+cxxodKYl17uHeNQzX+ugdxQB7RaJVgvo
	 foJN9dY56hew+lTazkIK9WVuKCp0r9FTrJcryh1PJs67Y3XG31yHPkvFrqtZod3hv+
	 I2xky6eP5K9gN9bJG/exBB46hjS7hWumFKHv3FY326HXXafYyLXaDbKcbzpm4wuB/o
	 kmUaNv9qSGtm3QI4eFDCXeltZofWNQ919sGe5pckTcKQQAcYUmZWJzIXC173/Nl+40
	 q+lyu0NC28KxHibekWc6ozhMhd41OvaVnbyjXhUsSHmQeL7iShyg1WPpGGwhRGtXY4
	 OiEr/sMzbcxEA==
Date: Wed, 2 Apr 2025 17:35:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Subject: [PATCH 1/1] pahole: When trying to encode BTF avoid DWARF less files
Message-ID: <Z-2fij_hUUFYF-YQ@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Make sure only DWARF is expected when encoding BTF. In time BTF will
also be accepted, to fixup or augment info produced by some producer, be
it gcc, clang, pahole or some other tool, for now, avoid trying to use
BTF when DWARF isn't available.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/pahole.c b/pahole.c
index af3e1cfe224dd14a..f247ff5e88feeb95 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3493,6 +3493,14 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	// Right now encoding BTF has to be from DWARF, so enforce that, otherwise
+	// the loading process can fall back to other formats, BTF being the case
+	// and as this is at this point unintended, avoid that.
+	// Next we need to just skip object files that don't have the format we
+	// expect as the source for BTF encoding, i.e. no DWARF, no BTF, no problema.
+	if (btf_encode && conf_load.format_path == NULL)
+		conf_load.format_path = "dwarf";
+
 	if (show_running_kernel_vmlinux) {
 		const char *vmlinux = vmlinux_path__find_running_kernel();
 
-- 
2.49.0

