Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF213B2BF
	for <dwarves@vger.kernel.org>; Wed, 24 Apr 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998153; cv=none; b=LDL+OK4m6WMROggh4ku6qrPmut76l3LmUZJonns60MMqlitvLCDh3bMfKP8So7ZesLPgm7fNaEegwU5/FlA2E8Q/arycq4WFe/X0c9vznhC8Ec3k+dq0K/LdHvPhhjVg5cufvkzYpxQ02E96WoEWzx6NRRo6JjxVdXGTT4+HCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998153; c=relaxed/simple;
	bh=eEBV1vuNFlLQkvjxmToNQpnyFyd8I66s8AOZen6ncJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qm5AI2+xupp5YilrOwdTK5wCGyyAlKzGvd5jFbLp2p9/90fsFVSMXI83sZO8ql8O0q5Z5Ez9eoQZ+d8K5LcMiFOFBL4licvBBDBhttpEiGz6INhawQHwnc7oaab1KrEUDPcgUKnxvp4EQAxwXIXjiWZIODahBNAUVOcx6v9yDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2104D367AE08; Wed, 24 Apr 2024 15:35:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Nick Desaulniers <ndesaulniers@google.com>,
	Xin Liu <liuxin350@huawei.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] btf_encoder: Fix dwarf int type with greater-than-16 byte issue
Date: Wed, 24 Apr 2024 15:35:38 -0700
Message-ID: <20240424223538.2682496-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Nick Desaulniers and Xin Liu separately reported that int type might
have greater-than-16 byte size ([1] and [2]). More specifically, the
reported int type sizes are 1024 and 64 bytes.

The libbpf and bpf program does not really support any int type greater
than 16 bytes. Therefore, with current pahole, btf encoding will fail
with greater-than-16 byte int types.

Since for now bpf does not support '> 16' bytes int type, the simplest
way is to sanitize such types, similar to existing conditions like
'!byte_sz' and 'byte_sz & (byte_sz - 1)'. This way, pahole won't
call libbpf with an unsupported int type size. The patch [3] was
proposed before. Now I resubmitted this patch as there are another
failure due to the same issue.

  [1] https://github.com/libbpf/libbpf/pull/680
  [2] https://lore.kernel.org/bpf/20240422144538.351722-1-liuxin350@huawe=
i.com/
  [3] https://lore.kernel.org/bpf/20230426055030.3743074-1-yhs@fb.com/

Cc: Xin Liu <liuxin350@huawei.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e1e3529..19e9d90 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -393,7 +393,7 @@ static int32_t btf_encoder__add_base_type(struct btf_=
encoder *encoder, const str
 	 * these non-regular int types to avoid libbpf/kernel complaints.
 	 */
 	byte_sz =3D BITS_ROUNDUP_BYTES(bt->bit_size);
-	if (!byte_sz || (byte_sz & (byte_sz - 1))) {
+	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16) {
 		name =3D "__SANITIZED_FAKE_INT__";
 		byte_sz =3D 4;
 	}
--=20
2.43.0

