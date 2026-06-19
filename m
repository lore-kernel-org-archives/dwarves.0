Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A42641C6;
	Fri, 19 Jun 2026 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897447; cv=none; b=Jyb1C39xqA0yByJRVGNFjgh9jNOePboegFDZZ/th1HNEQ1brUrDYJDO0nguGmZb95DG7W4k1TOKZ445uWv0FFxA4xdScwU3qbMU01hpO+hN6KqU3Uq7giplvOv3J0zjo+4NbWTzZvjJJqfUlDkgbkGM6S2KzJ6vKYl8rwBISc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897447; c=relaxed/simple;
	bh=M3vrH3gkJtdM0rEFzwBoBbl4W6M2qL3FjTW3Gv05Tjs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=boNHMU1NDTMUIJhqoepzqZpGIYdkkZY2DuRKblcjE9QaB1p7KGMfBtvMJpOGhWWI9jGud+ryDxzgxyfKQYnr2vLQ1SlobijQTY4tFZYniZs0BelrP7SWyobDqYVfdcTmLZlZSrrvhVAF1tRvlDDD7G3SfE2CeCXfVIf8Df1RE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkLrVk5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkLrVk5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1731F000E9;
	Fri, 19 Jun 2026 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897446;
	bh=c1bAS+CIsSi7f3lR/4NLuM9vXMm5BPWJ8vt5jfRI5rw=;
	h=Date:From:To:Cc:Subject;
	b=mkLrVk5BVlOdZVno1X9TUTgrk2wyr1Qu7zI4ftwmnVVvlfDmkc9eTQ1bYLfV3+Vn3
	 Kfv+hA3jqPnsWY8T5MvfB4undOD4HYOcSgKsPvjFv8NTcBGYmydLdwfoDn4LgeNz0f
	 M1i3gZ72RKA+d8SnzZWBkzthwyKBhpXk9eYlm3JV9/dgVsAD3KnrrXq7QLBKwIrD/P
	 iMr1rmSV5qH6t76UropyhdYv0+ofYXuIqxTD5Iy0qIgBfcohAEGQx9GWXEmDep+ubN
	 Kmpl3nyYQ/27GBE7lRxzSrbSXmiVWPlFZRglCPas/LXXD7B7DS07KWGv/5Kgfdug1I
	 rN084O8yzXJjw==
Date: Fri, 19 Jun 2026 16:30:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, sashiko@lists.linux.dev,
	dwarves@vger.kernel.org
Subject: Sashiko reviews for pahole: missing custom_remotes
Message-ID: <ajWY48GyZXw0aMDx@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Roman,

	The dwarves@vger.kernel.org mailing list is being tracked:

https://sashiko.dev/#/?list=org.kernel.vger.dwarves

	But all the patches for pahole are failing to apply, I think we
need to have the second hunk applied, the first should be there as it is
being tracked, can you please take a look and fix this?

Thanks,

- Arnaldo

diff --git a/Settings.toml b/Settings.toml
index 61978b51f89a0d86..666b4e8f1b7a76f3 100644
--- a/Settings.toml
+++ b/Settings.toml
@@ -5,7 +5,7 @@ url = "sashiko.db"
 token = ""
 
 [mailing_lists]
-track = ["linux-kernel"]
+track = ["linux-kernel", "dwarves"]
 
 [nntp]
 server = "nntp.lore.kernel.org"
@@ -104,6 +104,12 @@ port = 8080
 repository_path = "third_party/linux"
 
 # Track custom remotes and attempt to apply patches on their branches
+[[git.custom_remotes]]
+name = "pahole"
+url = "git://git.kernel.org/pub/scm/devel/pahole/pahole.git"
+check_all_branches = false
+only_branches = ["next", "master"]
+
 # [[git.custom_remotes]]
 # name = "remote-name"
 # url = "git://my-custom.com/remote"
