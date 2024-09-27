Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012961FD8
	for <dwarves@vger.kernel.org>; Fri, 27 Sep 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463632; cv=none; b=Ll2/RKOFD57ERokovRmeuKUcDkHxyo9eoaGNBmZcCBA6Ulyup1yjaX01v/Y7JMIZOrft+MBQfkgEqtvU/E2A7yuwSe+R4kbAOgvx3M/Z9o0OOaPch9y1zibR/1YRXSJcE4ywjWaGJjUgjp2GLcf9EO8jEN8aeLnuxNMcGK8mMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463632; c=relaxed/simple;
	bh=Ia7peuJJhVoy5V/3edfS8aVnlJIX31Ssgo/GnQSCf3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4EJf8fV3OhSmbZ+P5rCD7VQUfbGwJ7SN7aohyDJOKE7EGZifXlJI8L3a0DDG/CIZul42FFNMd4ICweL4IJP0EjpgY01l6rsfbkR/hv+7p+VCaQcYPDEob8vC3FStV9tqyEC3cxBpjpgd9dIF4TB20nYa504n85C5F1PSeUAr64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaC8Qqhm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaC8Qqhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6C5C4CEC4;
	Fri, 27 Sep 2024 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727463630;
	bh=Ia7peuJJhVoy5V/3edfS8aVnlJIX31Ssgo/GnQSCf3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaC8QqhmDk7cuzaAXlnE0/h44x4Ppqe+sFMp/PZrhordFX6siDf1JA8WGEVbv0M2X
	 8R1lysbOHTfYLODJKpaCMsXbnzkStFi2wb0J+iq/7sNvgZNjAfzl3RgP+JPtxBxITn
	 3MHsBMFykVEATGuFgm55mVuu3DzciOJp/5kh6eSLY3csZ1qBRyWkw2cuezSX4E1i9j
	 qf6vzSPG9+IaKH14o1HSXraBI2pY8gPSKny8+DREKSuPGCXSQRTxufA+hOD96whqXw
	 KWL9jO/ajsfzxAa5KE3tZSuePG2QHmk1AAq8GKJM+1h4N0j14uGu1em+FaH+ObdiGa
	 EuZz4KDwVF1MA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/2] pahole: Add --padding_ge N to show only structs with at least N bytes of padding at its end
Date: Fri, 27 Sep 2024 15:59:57 -0300
Message-ID: <20240927185958.37310-2-acme@kernel.org>
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

  $ pahole --padding_ge 4 --with_flexible_array
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

One can combine with -x/--exclude to remove from the output common
patterns such as 'struct trace_event_' structs:

  $ pahole --with_flexible_array --padding_ge 4 --exclude trace_event_ | grep ^struct
  struct rseq {
  struct mem_cgroup {
  struct netprio_map {
  struct qdisc_size_table {
  struct sysinfo {
  struct ethtool_rxnfc {
  struct ioam6_schema {
  struct poll_list {
  struct posix_acl {
  struct proc_dir_entry {
  struct scsi_vpd {
  struct xsk_buff_pool {
  struct ieee80211_regdomain {
  struct watch_filter {
  struct landlock_rule {
  struct ghes_vendor_record_entry {
  struct packet_fanout {
  struct name_cache_entry {
  struct workqueue_struct {
  struct svc_deferred_req {
  struct cis_cache_entry {
  struct sem_undo {
  struct sidtab_str_cache {
  struct pcpu_chunk {
  struct pericom8250 {
  struct dm_name_list {
  struct linux_dirent64 {
  struct old_linux_dirent {
  struct linux_dirent {
  $

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 man-pages/pahole.1 |  4 ++++
 pahole.c           | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 0a9d8ac49fbf94d5..840f8e13807ba1be 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -223,6 +223,10 @@ Find pointers to CLASS_NAME.
 .B \-H, \-\-holes=NR_HOLES
 Show only structs with at least NR_HOLES holes.
 
+.TP
+.B \-\-padding_ge=SIZE_PADDING
+Show only structs with at least SIZE_PADDING bytes of padding at its end.
+
 .TP
 .B \-I, \-\-show_decl_info
 Show the file and line number where the tags were defined, if available in
diff --git a/pahole.c b/pahole.c
index a33490d698ead7d5..56b0ca0c55993100 100644
--- a/pahole.c
+++ b/pahole.c
@@ -60,6 +60,7 @@ static char *decl_exclude_prefix;
 static size_t decl_exclude_prefix_len;
 
 static uint16_t nr_holes;
+static uint16_t end_padding_ge;
 static uint16_t nr_bit_holes;
 static uint16_t hole_size_ge;
 static uint8_t show_packable;
@@ -824,12 +825,13 @@ static struct class *class__filter(struct class *class, struct cu *cu,
 	 * that need finding holes, like --packable, --nr_holes, etc
 	 */
 	if (!tag__is_struct(tag))
-		return (just_structs || show_packable || nr_holes || nr_bit_holes || hole_size_ge) ? NULL : class;
+		return (just_structs || show_packable || nr_holes || nr_bit_holes || hole_size_ge || end_padding_ge) ? NULL : class;
 
 	if (tag->top_level)
 		class__find_holes(class);
 
 	if (class->nr_holes < nr_holes ||
+	    class->padding < end_padding_ge ||
 	    class->nr_bit_holes < nr_bit_holes ||
 	    (hole_size_ge != 0 && !class__has_hole_ge(class, hole_size_ge)))
 		return NULL;
@@ -1239,6 +1241,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_contains_enumerator 344
 #define ARGP_reproducible_build 345
 #define ARGP_running_kernel_vmlinux 346
+#define ARG_PADDING_GE		   347
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1494,6 +1497,12 @@ static const struct argp_option pahole__options[] = {
 		.arg  = "NR_HOLES",
 		.doc  = "show only structs with at least NR_HOLES holes",
 	},
+	{
+		.name = "padding_ge",
+		.key  = ARG_PADDING_GE,
+		.arg  = "SIZE_PADDING",
+		.doc  = "show only structs with at least SIZE_PADDING bytes padding at its end",
+	},
 	{
 		.name = "hole_size_ge",
 		.key  = 'z',
@@ -1885,6 +1894,7 @@ static error_t pahole__options_parser(int key, char *arg,
 		  class_name = arg;			break;
 	case 'F': conf_load.format_path = arg;		break;
 	case 'H': nr_holes = atoi(arg);			break;
+	case ARG_PADDING_GE: end_padding_ge = atoi(arg); break;
 	case 'I': conf.show_decl_info = 1;
 		  conf_load.extra_dbg_info = 1;		break;
 	case 'i': find_containers = 1;
-- 
2.46.0

