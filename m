Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E31258CE5
	for <dwarves@vger.kernel.org>; Mon, 23 Mar 2026 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300552; cv=none; b=qEurBwMk696Fv6JQ0kQwXHmOR4eRCeA+IatRrzDzuH7U7qPrE7nsdLcidtkWvHtnyk1Qp8Cg+gJBlgw3TXM/0z5JfCKLs80QijUheMSvp0qUW3+GLyCMEVFfMxFkthP75AhCVrJiw6JOiEB+G9XvgC7g2MmWpnpKD2sBP2dwORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300552; c=relaxed/simple;
	bh=vGNkAbchgayH7ELPf2+nQPCGAiOtei0GiJ8KdICzGOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAIDJ7knbzs7W4w0pYPmvpnwywX41YticnHiHtVOeu3CaqhjL+TOzS/3YL7tJwBCsqYMtwkQzmdcaZPecPLT1Ux0i6m2YCYiyBPYGJNUHZ/8vXBP+fBjVACoOBfInF1Dm1FA4FDsV8Cv2ZY4eSpwFrUsREF9rHpt5NCS1LOABys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfDvLbgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfDvLbgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9A0C2BC87;
	Mon, 23 Mar 2026 21:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774300552;
	bh=vGNkAbchgayH7ELPf2+nQPCGAiOtei0GiJ8KdICzGOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfDvLbgDf6y1z/jUFrv7XNPk51uFVNs9wuoWSNxVX3LkruwFsQiOGki7Xqmpyn2um
	 WOz8KwqeJ6MGcwtyx6VcjzyUCCjdlg5Fw1LVXj4sLCGhn1MXbWr8V4ZLcEe+5rS20Y
	 r0Uozbxn33GsJRTt8pjm407447aKNjjkLRmbypZPQ/AyVlA/zfBEh8HjJzY0mDCxUe
	 DRtqEiSLW4sG+KscAwrzwwzdQ8IZ4U/gXW01+FiPhuESzERJPrUL2R6paJKCItbwC0
	 AQq/49TADxSrjqMQ7skPHV9sUfDge3QOrKvUzlaRVLvw1nJSptx5EZIwxjDNkYmTHa
	 AbXB4d8XRFGVw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/3] dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
Date: Mon, 23 Mar 2026 18:15:33 -0300
Message-ID: <20260323211533.1909029-4-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323211533.1909029-1-acme@kernel.org>
References: <20260323211533.1909029-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The Linux perf tool now includes some Rust code that then gets linked
into perf and comes with its DWARF that has tags referencing tags in
different CUs, and as the current DWARF loading algorithm uses
parallelization and recodes the big DWARF types (DWARF_off, usually
64-bit) into smaller ones as a step into converting to CTF (initially)
and later BTF, the resolution fails.

There is a case whe this inter CU happens, LTO builds, and so there is
an alternative algorithm for that case, that serializes DWARF CU loading
and merges all the CUs into just one meta/mega-CU, which then has all
the types and thus doesn't have a problem with inter CU references, as
the recoding into smaller ids is done only after all CUs are loaded.

So while we don't refactor the loading in a way that allows for inter CU
while allowing parallelization, maybe by doing the recoding just at the
end of parallel loading, add minimal code to force this CU merging for
experimentation in such cases, getting back the regression test
prettify_perf.data.sh to work, making it force CU merging.

  $ pahole ~/bin/perf > unmerged.txt
  <Suppress lots of warnings when recoding DWARF types.>
  $ pahole --force_cu_merging ~/bin/perf > merged.txt
  $

With the current set of Rust types that are representable with the
pahole data structures and then pretty printed as if they were C we see
12 differences:

  $ diff -u unmerged.txt merged.txt | grep ^@@ | wc -l
  12
  $ diff -u unmerged.txt merged.txt | wc -l
  198

Of this kind, due to some types not being resolved as tags are
referencing tags in other CUs.

  $ diff -u unmerged.txt merged.txt | head
  --- unmerged.txt	2026-03-23 17:56:54.971785023 -0300
  +++ merged.txt	2026-03-23 17:56:59.826872178 -0300
  @@ -9643,10 +9643,11 @@
   	u64                        __0 __attribute__((__aligned__(8))); /*     0     8 */
   	struct Abbreviation        __1 __attribute__((__aligned__(8))); /*     8   112 */

  -	/* XXX last struct has 5 bytes of padding */
  +	/* XXX last struct has 16 bytes of padding, 1 hole */

   	/* size: 120, cachelines: 2, members: 2 */
  $

Now the pretty printing perf.data test case passes:

  ⬢ [acme@toolbx tests]$ ./prettify_perf.data.sh
  Pretty printing of files using DWARF type information.
  Test ./prettify_perf.data.sh passed
  ⬢ [acme@toolbx tests]$

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c              |  2 +-
 dwarves.h                   |  1 +
 man-pages/pahole.1          | 12 ++++++++++++
 pahole.c                    |  8 ++++++++
 tests/prettify_perf.data.sh |  4 ++--
 5 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index b5a92160ecf82f74..de2e9b70c32f85de 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3967,7 +3967,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 		}
 	}
 
-	if (cus__merging_cu(dw, elf)) {
+	if (conf->force_cu_merging || cus__merging_cu(dw, elf)) {
 		res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
 						build_id, build_id_len,
 						type_cu ? &type_dcu : NULL);
diff --git a/dwarves.h b/dwarves.h
index 95d84b8ce3a6e95d..7887af93693ebad5 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -102,6 +102,7 @@ struct conf_load {
 	bool			btf_gen_distilled_base;
 	bool			btf_attributes;
 	bool			true_signature;
+	bool			force_cu_merging;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 90a8f4566de621d3..39bb53816f4fac9f 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -515,6 +515,18 @@ This is useful for scripts where it provides a way to ask for that exclusion
 for pahole and pfunct, no need to use --lang_exclude in all calls to those
 tools, just set that environment variable.
 
+.TP
+.B \-\-force_cu_merging
+Force merging all CUs into one. Use when there are references across CUs.
+
+This happens in some LTO cases and was observed with Rust CUs, where types
+of tags (function parameters, abstract origins for inlines, etc) reference
+types in another CU.
+
+For LTO this is being autodetected and the merging of cus is done
+automatically, but for the Rust case, and maybe others this is needed with the
+current DWARF loading algorithm.
+
 .TP
 .B \-y, \-\-prefix_filter=PREFIX
 Include PREFIXed classes.
diff --git a/pahole.c b/pahole.c
index e4bfb69de56ada59..05e61b61dddad8ea 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1153,6 +1153,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARG_padding		   348
 #define ARGP_with_embedded_flexible_array 349
 #define ARGP_btf_attributes	   350
+#define ARGP_force_cu_merging	   351
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1818,6 +1819,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_btf_attributes,
 		.doc  = "Allow generation of attributes in BTF. Attributes are the type tags and decl tags with the kind_flag set to 1.",
 	},
+	{
+		.name = "force_cu_merging",
+		.key  = ARGP_force_cu_merging,
+		.doc  = "Force merging all CUs into one. Use when there are references across CUs.",
+	},
 	{
 		.name = NULL,
 	}
@@ -2014,6 +2020,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		parse_btf_features(arg, true);		break;
 	case ARGP_btf_attributes:
 		conf_load.btf_attributes = true;	break;
+	case ARGP_force_cu_merging:
+		conf_load.force_cu_merging = true;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
diff --git a/tests/prettify_perf.data.sh b/tests/prettify_perf.data.sh
index 1fae95154d710aae..3b903e32da24b489 100755
--- a/tests/prettify_perf.data.sh
+++ b/tests/prettify_perf.data.sh
@@ -25,7 +25,7 @@ fi
 perf_lacks_type_info() {
 	local type_keyword=$1
 	local type_name=$2
-	if ! pahole -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
+	if ! pahole --force_cu_merging -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
 		info_log "skip: $perf doesn't have '$type_keyword $type_name' type info"
 		test_skip
 	fi
@@ -41,7 +41,7 @@ $perf record --quiet -o $perf_data sleep 0.00001
 
 number_of_filtered_perf_record_metadata() {
 	local metadata_record=$1
-	local count=$(pahole -F dwarf -V $perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C "perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type,filter=type==PERF_RECORD_$metadata_record)" --prettify $perf_data | grep ".type = PERF_RECORD_$metadata_record," | wc -l)
+	local count=$(pahole --force_cu_merging -F dwarf -V $perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C "perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type,filter=type==PERF_RECORD_$metadata_record)" --prettify $perf_data | grep ".type = PERF_RECORD_$metadata_record," | wc -l)
 	echo "$count"
 }
 
-- 
2.53.0

