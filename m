Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2A1DE4DC
	for <dwarves@vger.kernel.org>; Mon,  7 Oct 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332751; cv=none; b=EikXvFS705DglZC0PIQT8pKFIuw0I2YutY4WEBTHwSJrrI/uREf/uvE+iniXx1tD+QoFkEMkGZMyUU31OkWXsEFzUzMUdfAlC43y/39Mnae2wxi7sgI8wbOR+1j8l3D8O5DDOGp+BsDjUIK2k615E35txvL0KmgvEYdYuFbIZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332751; c=relaxed/simple;
	bh=XZtDtusuGMrzoKQnJsc1GBaYFSNKYbU6iMboVgSD1Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMS9W7IQV7xGsswrPUVzk6oxDUuUtimNytH+AuJTK9fde5/z+B/ccJze9oUTLbMuK94tJRFIzRnVD2gefdQ7sBc9j6/TVvpNVFBhU5ixoVCRGzvLQnb/uKWSYpt8KATZW5rz1n0EbPRQG934pZBKrM9uI9ROBTMomccJ/e8Z7+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieU/h9WU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieU/h9WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F65C4CECD;
	Mon,  7 Oct 2024 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332750;
	bh=XZtDtusuGMrzoKQnJsc1GBaYFSNKYbU6iMboVgSD1Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieU/h9WUBDMXEwBRyoqCkq2UNibwvuouuO72JZ/nGGpuPbmvh4JZ2rhOlUCQ0Ig9H
	 T3yMIabbJWOZl5U7t/Y+PNxdbmOWFmex1DJUe5MT++cw2t9AoHLNAHslFUnYZ67GBx
	 ooRSLFP8e9kGddrO6sipxaXKYKU1s4vTQVZmUlYi8zztEyT6mG61a8XeSXa/RnVOQ9
	 6PjNEBo6QnGch+jBMPUDU2b5UC3+Zfk0/W23qk2rT6eIZUv1YQ+3VawhATA4zWF17M
	 XhhE1xqGQLaz+PgQpllooMi4Xaaym2sFcIWnorx+Flzxl/Vy6Nb1IMng2CiXHF8Gli
	 csg0BNyAyEwzQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 4/5] fprintf: Add a comment if a member type has an embedded flexible array
Date: Mon,  7 Oct 2024 17:25:30 -0300
Message-ID: <20241007202531.942648-5-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007202531.942648-1-acme@kernel.org>
References: <20241007202531.942648-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For instance:

  acme@x1:~/git/pahole$ pahole cgroup_root
  struct cgroup_root {
          struct kernfs_root *       kf_root;              /*     0     8 */
          unsigned int               subsys_mask;          /*     8     4 */
          int                        hierarchy_id;         /*    12     4 */
          struct list_head           root_list;            /*    16    16 */
          struct callback_head       rcu;                  /*    32    16 */

          /* XXX 16 bytes hole, try to pack */

          /* --- cacheline 1 boundary (64 bytes) --- */
          struct cgroup              cgrp __attribute__((__aligned__(64))); /*    64  1984 */

          /* XXX last struct has a flexible array, 3 holes */

          /* --- cacheline 32 boundary (2048 bytes) --- */
          struct cgroup *            cgrp_ancestor_storage; /*  2048     8 */
          atomic_t                   nr_cgrps;             /*  2056     4 */
          unsigned int               flags;                /*  2060     4 */
          char                       release_agent_path[4096]; /*  2064  4096 */
          /* --- cacheline 96 boundary (6144 bytes) was 16 bytes ago --- */
          char                       name[64];             /*  6160    64 */

          /* size: 6272, cachelines: 98, members: 11 */
          /* sum members: 6208, holes: 1, sum holes: 16 */
          /* padding: 48 */
          /* member types with holes: 1, total: 3 */
          /* forced alignments: 1, forced holes: 1, sum forced holes: 16 */
  } __attribute__((__aligned__(64)));
  acme@x1:~/git/pahole$

And then:

  acme@x1:~/git/pahole$ pahole cgroup | tail -20
  	/* XXX last struct has 1 hole */

  	/* --- cacheline 30 boundary (1920 bytes) was 32 bytes ago --- */
  	atomic_t                   congestion_count;     /*  1952     4 */
  	struct cgroup_freezer_state freezer;             /*  1956    16 */

  	/* XXX last struct has 1 hole */
  	/* XXX 4 bytes hole, try to pack */

  	struct bpf_local_storage * bpf_cgrp_storage;     /*  1976     8 */
  	/* --- cacheline 31 boundary (1984 bytes) --- */
  	struct cgroup *            ancestors[];          /*  1984     0 */

  	/* size: 1984, cachelines: 31, members: 42 */
  	/* sum members: 1952, holes: 3, sum holes: 32 */
  	/* member types with holes: 3, total: 3 */
  	/* paddings: 1, sum paddings: 4 */
  	/* forced alignments: 1 */
  };

  acme@x1:~/git/pahole$

Care must be taken on how to use that cgroup->ancestors field since
cgroup_root->cgrp is in the middle of 'struct cgroup_root', so accesses
to cgroup->ancestors[1] would be accessing other fields of cgroup_root
after cgrp, i.e. further analysis and checks in the code handling those
structs is needed.

This comes from discussions with Willy Tarreau after Gustavo A. R.
Silva's presentation at Kernel Recipes'2024:

  https://speakerdeck.com/ennael/enhancing-spatial-safety-fixing-thousands-of-wflex-array-member-not-at-end-warnings?slide=11

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves_fprintf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index ffbe6fbd3f5c405a..94a152183b0725cf 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1513,7 +1513,7 @@ static size_t class__fprintf_member_type_holes(struct class *class, const struct
 	size_t printed = 0;
 	uint16_t padding;
 	uint8_t nr_holes, nr_bit_holes, bit_padding;
-	bool first = true;
+	bool first = true, has_embedded_flexible_array;
 	/*
 	 * We may not yet have looked for holes and paddings in this member's
 	 * struct type.
@@ -1525,8 +1525,9 @@ static size_t class__fprintf_member_type_holes(struct class *class, const struct
 	bit_padding = class->bit_padding;
 	nr_holes = class->nr_holes;
 	nr_bit_holes = class->nr_bit_holes;
+	has_embedded_flexible_array = class__has_embedded_flexible_array(class, cu);
 
-	if (!padding && !bit_padding && !nr_holes && !nr_bit_holes)
+	if (!padding && !bit_padding && !nr_holes && !nr_bit_holes && !has_embedded_flexible_array)
 		return 0;
 
 	if (!(*newline)++) {
@@ -1536,11 +1537,16 @@ static size_t class__fprintf_member_type_holes(struct class *class, const struct
 
 	printed += fprintf(fp, "\n%.*s/* XXX last struct has", conf->indent, tabs);
 
+	if (has_embedded_flexible_array) {
+		printed += fprintf(fp, " a flexible array");
+		first = false;
+	}
+
 	if (padding) {
 		++holes->nr_paddings;
 		holes->sum_paddings += padding;
 
-		printed += fprintf(fp, " %d byte%s of padding", padding, padding != 1 ? "s" : "");
+		printed += fprintf(fp, "%s %d byte%s of padding", first ? "" : ",", padding, padding != 1 ? "s" : "");
 		first = false;
 	}
 
-- 
2.46.2

