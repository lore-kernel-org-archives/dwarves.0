Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDC2D8376
	for <dwarves@vger.kernel.org>; Tue,  8 Jul 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983741; cv=none; b=Sya+YfnDbBYbHK1yiAYBl+bPbrQegtMm+u+ULsujR2SEYLSsnid8buiPC7I1mudbql6Vskh3yiQ2pVK2hLd+6EwPZ80RvlkeNO3h3OVEYPwxv54iwS0uP1v1TsvLkoNeHQ2IOqCUqHMTHRzKw/cmIjEGb5JAAJL5u6OybWC6cjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983741; c=relaxed/simple;
	bh=m0J+pyQMbKJmVW8zUayyqu/w2xTQX7YlkMznfDf5w2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBkLnOfCeoR4Fx07C7EY4PoKtR63q1cbhsZ8GX3zSUSUKUE6URkQGXzAp+Ye9L8zE7vL8unj5fOETIeCOetGxN5h/yipc2JCYSjFtbzkTr+oaQfClYyZxHtq1vZqWeTZtldBluF+VIOjGokXD2si8VesFNbEsJLbtQNDHnHoz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgwyBIDi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgwyBIDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1FFC4CEED;
	Tue,  8 Jul 2025 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751983740;
	bh=m0J+pyQMbKJmVW8zUayyqu/w2xTQX7YlkMznfDf5w2s=;
	h=From:To:Cc:Subject:Date:From;
	b=AgwyBIDildYpGgalWBXk1YP7rX6+1Tl7RYceXcK7BPpwm4lInMj++n8rnWUNyvYv8
	 zuBZ+Ynfaldm83qydw7fxKN/VRDlnwRfuUEXq1WKKgaSBCqF5HEmnXFfTn6dFkmKTV
	 1Jn0gejcSdeoXVLE4sbmzPHlxHJCYr+k6Mhu3/sl2TdGdaV3c5Ehi6fcwZb7yfmxdI
	 K0deqjkbv3aaRo0wd+gxfAJ6U0OJn8VUYU5MqrVkFypq9hCTSEQf/2jNQ/0Ah/ZEtC
	 ccGKbYqlIdNfx90Xx+sF4+aIbftJzA+Bp8mn0vZ6lxRnIn/yH1tMlKKt99dNZsmf/W
	 e+lVbXZ/bVRuQ==
From: Antoine Tenart <atenart@kernel.org>
To: dwarves@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	pvalerio@redhat.com,
	alan.maguire@oracle.com
Subject: [PATCH v2 0/2] pahole: BTF alignment inference improvements
Date: Tue,  8 Jul 2025 16:08:53 +0200
Message-ID: <20250708140856.311717-1-atenart@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While generating C code using pahole we noticed alignment issues in rare
cases: when having variable size and 0-length arrays, and when a hole
follows a bitfield. It's worth noticing alignment is inferred when using
BTF as a source as the format does not contain such information. As such
the logic is tricky.

The first patch fixes alignment inference for zero-length and variable
length arrays. The second patch fixes alignment when a hole follows a
bitfield.

I generated a full vmlinux.h using `pahole --compile` before and after
the changes, the differences looked reasonable to me. I've also ran the
project's tests using GH actions.

Thanks,
Antoine

Since v1:
- Added comments in both patches to help future readers.

Antoine Tenart (2):
  btf_loader: infer alignment for zero-length arrays
  btf_loader: fix smallest offset in case of bitfields

 btf_loader.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.50.0

