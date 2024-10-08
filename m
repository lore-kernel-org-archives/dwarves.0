Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657C212D3E
	for <dwarves@vger.kernel.org>; Tue,  8 Oct 2024 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417151; cv=none; b=oV4IQgb1G3pEDpNWp3va9zn5wtnEJhTQcVXIhlXoZjbjOHU8QOSgcvk1a+RKYXatGRwIK/zoy+cSor6UczbCGm8lYqVNvaMh/ScWlNhqF6ozFwPyeOmZYRZ1CMgq1goQtluLwe6FwbmPnqSexN+9JMmybV10ogMyYq5dlPeqhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417151; c=relaxed/simple;
	bh=lqdcyeNUo45/5nIZUfXnW9RMZK3K14fTDzkTSc7anes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C34u0D9X9WqdruqprKaFSWMrO9Gb85qY6DK4LzgmtAacYO6MmDIeql+F95W+gXr+2a7WpI9VnBPNNzXTUtp7ypnWdJkTVWNndI099OPil2HAm+P+X21UzxJbPG2JU9cq9QRr9X09jYBFg/fbzKxiWYuygSrMqqcGTGAsNBV5D9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3CXroTY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3CXroTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D05BC4CEC7;
	Tue,  8 Oct 2024 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728417151;
	bh=lqdcyeNUo45/5nIZUfXnW9RMZK3K14fTDzkTSc7anes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3CXroTYPTJFF6uQQMNCgQMeJYBUEhSeBiBWt8KRKYje5RR19MwEBj9nQ9S7kX45X
	 i8SCKcVJIRVLAuyqDr21iusdCdTSU3f+fmyMC17oh0yf+Q6smzWXiX2BHqV/9i8K9P
	 /soYuMaozqsMSEKtUkXeiFT6Ti9Jd5nRaeRy1XxCVq91gLbrD3BNG5eAkRbLlJcXQJ
	 QCURe9vbWZ/AgMWKzEZ2PJ1Wyy3S1uS4wOYFdCmsNO3ofGVi/SQE5pl6JpDcv6zeMs
	 CN5X7BkHotkizY4NlmdziyNlzWtAeoxJC2fkpWHtsDsrrONx6fzhYHWDpXSovLqdWp
	 UjrfxktlUmxBg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/3] fprintf: Show statistics about members with flexible arrays
Date: Tue,  8 Oct 2024 16:52:08 -0300
Message-ID: <20241008195209.1094299-3-acme@kernel.org>
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

For instance, this one has embedded flexible arrays:

  $ pahole lirc_fh
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
  	/* flexible array members: end: 2 */
  	/* last cacheline: 48 bytes */
  };
  $

'end' means that the members with flexible arrays have them in the
"classical" sense, i.e. the last member of those member types is a []
member.

When 'middle' appears it means another level, just like the above
'struct lirc_fh' has multiple members in its midle that are flexible
arrays.

If we use 'pahole --with_embedded_flexible_array' we'll see quite a few
in the Linux kernel (using BTF info from /sys/kernel/btf/vmlinux, mostly
available in most kernels these days), using --sizes so that we get just
one line per Linux kernel struct that have embedded flexible arrays (and
its sizes and number of alignment holes, as bonuses):

  $ pahole --sizes --with_embedded_flexible_array | head
  mem_cgroup	2240	10
  pglist_data	175424	7
  zone	1728	5
  cgroup	1984	3
  cgroup_root	6272	1
  page_counter	192	1
  cpu_hw_events	5200	6
  crypto_shash	40	1
  crypto_aead	40	0
  crypto_ahash	48	2
  $

  $ pahole crypto_shash
  struct crypto_shash {
  	unsigned int               descsize;             /*     0     4 */

  	/* XXX 4 bytes hole, try to pack */

  	struct crypto_tfm          base;                 /*     8    32 */

  	/* XXX last struct has a flexible array, 1 hole */

  	/* size: 40, cachelines: 1, members: 2 */
  	/* sum members: 36, holes: 1, sum holes: 4 */
  	/* member types with holes: 1, total: 1 */
  	/* flexible array members: end: 1 */
  	/* last cacheline: 40 bytes */
  };
  $

If we expand it all:

  $ pahole -E crypto_shash
  struct crypto_shash {
  	unsigned int               descsize;                                             /*     0     4 */

  	/* XXX 4 bytes hole, try to pack */

  	struct crypto_tfm {
  		/* typedef refcount_t */ struct refcount_struct {
  			/* typedef atomic_t */ struct {
  				int counter;                                             /*     8     4 */
  			} refs; /*     8     4 */
  		} refcnt; /*     8     4 */
  		/* typedef u32 -> __u32 */ unsigned int       crt_flags;                 /*    12     4 */
  		int                node;                                                 /*    16     4 */

  		/* XXX 4 bytes hole, try to pack */

  		void               (*exit)(struct crypto_tfm *);                         /*    24     8 */
  		struct crypto_alg * __crt_alg;                                           /*    32     8 */
  		void *             __crt_ctx[];                                          /*    40     0 */
  	} base; /*     8    32 */

  	/* XXX last struct has a flexible array, 1 hole */

  	/* size: 40, cachelines: 1, members: 2 */
  	/* sum members: 36, holes: 1, sum holes: 4 */
  	/* member types with holes: 1, total: 1 */
  	/* flexible array members: end: 1 */
  	/* last cacheline: 40 bytes */
  };
  $

Interesting, but we don't see the "middle" case...

Maybe 'struct cgroup'?

  $ pahole cgroup | tail
  	struct cgroup *            ancestors[];          /*  1984     0 */

  	/* size: 1984, cachelines: 31, members: 42 */
  	/* sum members: 1952, holes: 3, sum holes: 32 */
  	/* member types with holes: 3, total: 3 */
  	/* paddings: 1, sum paddings: 4 */
  	/* forced alignments: 1 */
  	/* flexible array members: end: 1 */
  };

  $

Humm, maybe some data structure embeds 'struct cgroup'? Lets see with:

  $ pahole --contains cgroup
  cgroup_root
  $

A-ha, finally that 'middle' stat:

  $ pahole cgroup_root
  struct cgroup_root {
  	struct kernfs_root *       kf_root;              /*     0     8 */
  	unsigned int               subsys_mask;          /*     8     4 */
  	int                        hierarchy_id;         /*    12     4 */
  	struct list_head           root_list;            /*    16    16 */
  	struct callback_head       rcu;                  /*    32    16 */

  	/* XXX 16 bytes hole, try to pack */

  	/* --- cacheline 1 boundary (64 bytes) --- */
  	struct cgroup              cgrp __attribute__((__aligned__(64))); /*    64  1984 */

  	/* XXX last struct has a flexible array, embedded flexible array(s), 3 holes */

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
  	/* flexible array members: end: 1, middle: 1 */
  } __attribute__((__aligned__(64)));
  $

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves_fprintf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 0d642a318fd836ef..e16a6b4da65ed2cd 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1502,6 +1502,8 @@ struct member_types_holes {
 	uint16_t nr_with_bit_holes;
 	uint16_t total_nr_holes;
 	uint16_t total_nr_bit_holes;
+	uint16_t nr_flexible_array_members;
+	uint16_t nr_embedded_flexible_array_members;
 	uint32_t sum_paddings;
 	uint32_t sum_bit_paddings;
 };
@@ -1540,11 +1542,13 @@ static size_t class__fprintf_member_type_holes(struct class *class, const struct
 
 	if (has_flexible_array) {
 		printed += fprintf(fp, " a flexible array");
+		++holes->nr_flexible_array_members;
 		first = false;
 	}
 
 	if (has_embedded_flexible_array) {
 		printed += fprintf(fp, "%s embedded flexible array(s)", first ? "" : ",");
+		++holes->nr_embedded_flexible_array_members;
 		first = false;
 	}
 
@@ -1985,6 +1989,22 @@ next_member:
 		}
 		printed += fprintf(fp, " */\n");
 	}
+	if (member_types_holes.nr_flexible_array_members > 0 ||
+	    member_types_holes.nr_embedded_flexible_array_members > 0) {
+		printed += fprintf(fp, "%.*s/* flexible array members: ",
+				   cconf.indent, tabs);
+
+		if (member_types_holes.nr_flexible_array_members > 0)
+			printed += fprintf(fp, "end: %u", member_types_holes.nr_flexible_array_members);
+
+		if (member_types_holes.nr_embedded_flexible_array_members > 0) {
+			printed += fprintf(fp, "%smiddle: %u",
+					   member_types_holes.nr_flexible_array_members ? ", " : "",
+					   member_types_holes.nr_embedded_flexible_array_members);
+		}
+
+		printed += fprintf(fp, " */\n");
+	}
 	cacheline = (cconf.base_offset + type->size) % conf_fprintf__cacheline_size(conf);
 	if (cacheline != 0)
 		printed += fprintf(fp, "%.*s/* last cacheline: %u bytes */\n",
-- 
2.46.0

