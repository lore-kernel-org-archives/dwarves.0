Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314B61FD8
	for <dwarves@vger.kernel.org>; Fri, 27 Sep 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463635; cv=none; b=l16wS/WNns38Tf7VWHWMJKF7anlLMapVCLXPt+nqyi3WYo0qrNG3fS30TuezYDTnpxhGIuFaZYDSk86vqSgdlWz/OlVZdYmMFI5KDZPg17L6Rtaz5CS8P5PNO+NLPa+R45/RmgnKWZTxF6u4VOgkFvVIj8BnI0P7zZmmJBwbIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463635; c=relaxed/simple;
	bh=1CHGN3e5WLkn6jVRGtM/iurWqfmNLK8qDE9aNEjom6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+4y7b3eOxoQ53kgpGAjJ6My3tgdjknrRUUacE1uAMWdpv17k+VU+mU2dh+8j83fQj5qEi53QCvgTi/2NB/jt9bBGedZT0SjEODgQLy9o+Jv9/Xg+3pru+BGCdPahGjJNkuS7xqqXdUcly+JlD0HeMMW/oh8ohWfBRXfhmgI/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI09a2x5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI09a2x5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CA4C4CEC9;
	Fri, 27 Sep 2024 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727463635;
	bh=1CHGN3e5WLkn6jVRGtM/iurWqfmNLK8qDE9aNEjom6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pI09a2x5gPDDV+X4GLXCjf5QXV4m+tcf1jv/jIskCln+V/UrPmdhuRH3t2UN3jO+a
	 obEAs3H1lljtsaSi3FettgPryt+Gk4l7WnT0Lo4Nk4kyjkba7yT53ncVaYpYY52koR
	 HdHmdgLlj5voAvQZ8g7PZsks1ao3EXv9DBLcAQvEHtVqrDIfLrTJti/p9alUYEQi3G
	 gTeGGHza0Po6/hUgQomhA1xKaON34h8LbR551QwC525Y8rKjrDSPqPStu33W+i6LUd
	 vs/w2IHPTrWqOVjfihGEmP9UQvbydhLSnPaRncazse6/DF7gMCzY9cpg6MytxjkJaJ
	 3ftTc0Ec5yWKg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/2] pahole: Add --padding N to show only structs with N bytes of padding at its end
Date: Fri, 27 Sep 2024 15:59:58 -0300
Message-ID: <20240927185958.37310-3-acme@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240927185958.37310-1-acme@kernel.org>
References: <20240927185958.37310-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Example usage:

  $ pahole --padding 4 --with_flexible_array
  <SNIP>
  struct netprio_map {
          struct callback_head       rcu;                  /*     0    16 */
          u32                        priomap_len;          /*    16     4 */
          u32                        priomap[];            /*    20     0 */

          /* size: 24, cachelines: 1, members: 3 */
          /* padding: 4 */
          /* last cacheline: 24 bytes */
  };
  <SNIP>

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 man-pages/pahole.1 | 4 ++++
 pahole.c           | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 840f8e13807ba1be..b3e6632bdbf6b561 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -223,6 +223,10 @@ Find pointers to CLASS_NAME.
 .B \-H, \-\-holes=NR_HOLES
 Show only structs with at least NR_HOLES holes.
 
+.TP
+.B \-\-padding=SIZE_PADDING
+Show only structs with SIZE_PADDING bytes of padding at its end.
+
 .TP
 .B \-\-padding_ge=SIZE_PADDING
 Show only structs with at least SIZE_PADDING bytes of padding at its end.
diff --git a/pahole.c b/pahole.c
index 56b0ca0c55993100..780f0c4eacfe2ee8 100644
--- a/pahole.c
+++ b/pahole.c
@@ -60,6 +60,7 @@ static char *decl_exclude_prefix;
 static size_t decl_exclude_prefix_len;
 
 static uint16_t nr_holes;
+static uint16_t end_padding;
 static uint16_t end_padding_ge;
 static uint16_t nr_bit_holes;
 static uint16_t hole_size_ge;
@@ -825,7 +826,8 @@ static struct class *class__filter(struct class *class, struct cu *cu,
 	 * that need finding holes, like --packable, --nr_holes, etc
 	 */
 	if (!tag__is_struct(tag))
-		return (just_structs || show_packable || nr_holes || nr_bit_holes || hole_size_ge || end_padding_ge) ? NULL : class;
+		return (just_structs || show_packable || nr_holes || nr_bit_holes || hole_size_ge ||
+			end_padding_ge || end_padding) ? NULL : class;
 
 	if (tag->top_level)
 		class__find_holes(class);
@@ -833,6 +835,7 @@ static struct class *class__filter(struct class *class, struct cu *cu,
 	if (class->nr_holes < nr_holes ||
 	    class->padding < end_padding_ge ||
 	    class->nr_bit_holes < nr_bit_holes ||
+	    (end_padding != 0 && class->padding != end_padding) ||
 	    (hole_size_ge != 0 && !class__has_hole_ge(class, hole_size_ge)))
 		return NULL;
 
@@ -1242,6 +1245,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_reproducible_build 345
 #define ARGP_running_kernel_vmlinux 346
 #define ARG_PADDING_GE		   347
+#define ARG_PADDING		   348
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1894,6 +1898,7 @@ static error_t pahole__options_parser(int key, char *arg,
 		  class_name = arg;			break;
 	case 'F': conf_load.format_path = arg;		break;
 	case 'H': nr_holes = atoi(arg);			break;
+	case ARG_PADDING: end_padding = atoi(arg);	break;
 	case ARG_PADDING_GE: end_padding_ge = atoi(arg); break;
 	case 'I': conf.show_decl_info = 1;
 		  conf_load.extra_dbg_info = 1;		break;
-- 
2.46.0

