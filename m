Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A5213ED4
	for <dwarves@vger.kernel.org>; Tue,  8 Oct 2024 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417145; cv=none; b=fXOoCXC/hsC8qySt2s3sTbTZcl7A033NO5UFeVfxxDdlse+bElGDDBcr7JFi3j5M7og0cS3vXZWa2ls9HY7+qY9Q3zQ6g6bMRyTILWl56APRCcruavx4f9T9cnfxQ51CuSE2AwhQl+t/6XFN5ywIFebnF9h8277kbvfXIoGTrgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417145; c=relaxed/simple;
	bh=JgPG3iXHVIa0Xfay0yLBm3IXiQ3V0Sms6Yy3gp8258w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO8Y0A/5MZ5D/dgAznZs6/A4dCCRiTHPymJ26/H38GWOad2oC6YygDQ0S4il7Qzd6WAQBcGMjOhdv47Mbm1K2ljLYCSs0OlecgPvF0qZzsPQqHZQ1AgmOz8Pt1DzDwvXbfAX4ndVQK4n0Doqj2DgjgrjlzdcIfBqpCkB66MkG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGwkAoDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGwkAoDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EE7C4CEC7;
	Tue,  8 Oct 2024 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728417145;
	bh=JgPG3iXHVIa0Xfay0yLBm3IXiQ3V0Sms6Yy3gp8258w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGwkAoDBF6tyGJ8vVE6qC/V9duiG+K6G7wWu0eDocrxJYWQQ4/Lxs7ylduRuDtaNd
	 4TEFVs5iYsguapMvUjg+BVGeyOPFEGp1Il7ZRyXbdc/2Zv029hN2lHAS/ClDYgrl4+
	 hK/lETEXU5qiB87GM8FRtXahIwDg4eaVwY8kHXrJIEQC72kvx01Z7N8H+gwdGhPON8
	 gFv2HVL7Bl2PLual8E3/GZ432SPJoWdR20kMwmM7Se6AKIZF78XDHgkhKc5tm870rP
	 OteQoI0Z0boDaUB3lz6tVB97SWp0NPpZkV0/e2bVnMW36TiATysMJudXU3+HEqLJTh
	 zzGTmyp4J5xfA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/3] fprintf: Differentiate embedded flexible arrays from flexible arrays
Date: Tue,  8 Oct 2024 16:52:07 -0300
Message-ID: <20241008195209.1094299-2-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008195209.1094299-1-acme@kernel.org>
References: <20241008195209.1094299-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Se one case where a struct has embedded flexible arrays, that was not
being notified as comments following those members:

  acme@x1:~/git/pahole$ pahole lirc_fh
  struct lirc_fh {
  	struct list_head           list;                 /*     0    16 */
  	struct rc_dev *            rc;                   /*    16     8 */
  	int                        carrier_low;          /*    24     4 */

  	/* XXX 4 bytes hole, try to pack */

  	struct {
  		union {
  			struct __kfifo kfifo;            /*    32    24 */
  			unsigned int * type;             /*    32     8 */
  			const unsigned int  * const_type; /*    32     8 */
  			char *     rectype;              /*    32     8 */
  			unsigned int * ptr;              /*    32     8 */
  			const unsigned int  * ptr_const; /*    32     8 */
  		};                                       /*    32    24 */
  		unsigned int       buf[];                /*    56     0 */
  	} rawir;                                         /*    32    24 */

  	/* XXX last struct has a flexible array */

  	struct {
  		union {
  			struct __kfifo kfifo;            /*    56    24 */
  			struct lirc_scancode * type;     /*    56     8 */
  			const struct lirc_scancode  * const_type; /*    56     8 */
  			char *     rectype;              /*    56     8 */
  			struct lirc_scancode * ptr;      /*    56     8 */
  			const struct lirc_scancode  * ptr_const; /*    56     8 */
  		};                                       /*    56    24 */
  		/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
  		struct lirc_scancode buf[];              /*    80     0 */
  	} scancodes;                                     /*    56    24 */

  	/* XXX last struct has a flexible array */

  	wait_queue_head_t          wait_poll;            /*    80    24 */
  	u8                         send_mode;            /*   104     1 */
  	u8                         rec_mode;             /*   105     1 */

  	/* size: 112, cachelines: 2, members: 8 */
  	/* sum members: 102, holes: 1, sum holes: 4 */
  	/* padding: 6 */
  	/* last cacheline: 48 bytes */
  };

Now we need to count how many embedded flexible arrays are in a struct
to print at the end stats, right before that "last cacheline:" comment
line.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves_fprintf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 94a152183b0725cf..0d642a318fd836ef 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1513,7 +1513,7 @@ static size_t class__fprintf_member_type_holes(struct class *class, const struct
 	size_t printed = 0;
 	uint16_t padding;
 	uint8_t nr_holes, nr_bit_holes, bit_padding;
-	bool first = true, has_embedded_flexible_array;
+	bool first = true, has_embedded_flexible_array, has_flexible_array;
 	/*
 	 * We may not yet have looked for holes and paddings in this member's
 	 * struct type.
@@ -1525,9 +1525,10 @@ static size_t class__fprintf_member_type_holes(struct class *class, const struct
 	bit_padding = class->bit_padding;
 	nr_holes = class->nr_holes;
 	nr_bit_holes = class->nr_bit_holes;
+	has_flexible_array = class__has_flexible_array(class, cu);
 	has_embedded_flexible_array = class__has_embedded_flexible_array(class, cu);
 
-	if (!padding && !bit_padding && !nr_holes && !nr_bit_holes && !has_embedded_flexible_array)
+	if (!padding && !bit_padding && !nr_holes && !nr_bit_holes && !has_flexible_array && !has_embedded_flexible_array)
 		return 0;
 
 	if (!(*newline)++) {
@@ -1537,11 +1538,16 @@ static size_t class__fprintf_member_type_holes(struct class *class, const struct
 
 	printed += fprintf(fp, "\n%.*s/* XXX last struct has", conf->indent, tabs);
 
-	if (has_embedded_flexible_array) {
+	if (has_flexible_array) {
 		printed += fprintf(fp, " a flexible array");
 		first = false;
 	}
 
+	if (has_embedded_flexible_array) {
+		printed += fprintf(fp, "%s embedded flexible array(s)", first ? "" : ",");
+		first = false;
+	}
+
 	if (padding) {
 		++holes->nr_paddings;
 		holes->sum_paddings += padding;
-- 
2.46.0

