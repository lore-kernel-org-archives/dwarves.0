Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10936A377
	for <dwarves@vger.kernel.org>; Fri, 21 Aug 2026 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348129; cv=none; b=gn4UxL3rKLMcnt+eV16KLGg1JbX9FkF5P0UaubYmKlL+6FiQLOEA1ldoxlRzob8q55eFrJF4ys1oSoOzIiqAiG2jtbAdaOwVdxs1W+jbQSqq46IjpKOykdQzLsbkqug6aItRq3XgS0mfdeyNGv4H3lOOEkAVbgElJl5JZkj7/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348129; c=relaxed/simple;
	bh=Yt7f43FkaJFEpa/YielQXJ5PscM0FoNKg+9TNm01F9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAbvkJfvcOvi10MLzwMWrlcoZsdZK+Ho+jHvanZ3pLB90wEePMir/OxxDUlU6qjWjco/dCCwsF2zfYaJrn95ZoHodorpc0mumn6knUmuFO/kvDgQc+Yl5PxwsVKDugc5nmaneC2ckjhV9/p7DQ9GIIG0nxHinuZklmM3OVZqpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIj/L74c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIj/L74c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDC11F00A3A;
	Fri, 21 Aug 2026 21:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348127;
	bh=Yd8ws29sCUNwg2RMHiBwafqCawNR1HFaiF+7Ajnf9hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kIj/L74cLHhuJsQDfFAhVjG3jRkg9BA2BiC5yPO/EPbIxasHyEd9Odg+x0EnExOgu
	 b7TDig9cXkPOmq+57hrewoeiDjeDc3f3+Wt8UohsgVm59URoeDQhxPsUz6Q9ZNZpzl
	 vejonKbVxnhG4o9obYh4+9sge0RFMPmaNYWVzRK+OghCVS0ii5GiwGHOOI5nETffrw
	 +blrNx7DtzqD2Du9Kq3kfJpG0fzWZNgoEIWyHgItaRuw2nMQiOeSWPcXZYezx6yEZk
	 F6SAtiH2xkT8VwBgHkvNb4S8SBvppLXWZnf74OKCpxXhinCohfbrlm8rweBmtArF4f
	 7YJaBxbD3zmhA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 3/9] dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
Date: Fri, 21 Aug 2026 18:35:02 -0300
Message-ID: <20260821213510.22423-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821213510.22423-1-acme@kernel.org>
References: <20260821213510.22423-1-acme@kernel.org>
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

There is a case where this inter CU happens, LTO builds, and so there is
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
  $ pahole --features=force_cu_merging ~/bin/perf > merged.txt
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

This was implemented reusing the --btf_features mechanism that now can
be accessed as well via --features, as this is not strictly a BTF
feature but, as Alan Maguire suggested, it is desirable to ask for that
feature to be enabled when we know it is needed but can't guarantee that
the available pahole version has the feature and not have it fail
because it doesn't implement --force_cu_merging, which the
--btf_features=force_cu_merging, now also available as
--features=force_cu_merging, allows as it ignores unknown features.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c              |  2 +-
 dwarves.h                   |  1 +
 man-pages/pahole.1          | 18 ++++++++++++++++--
 pahole.c                    | 19 ++++++++++++++++++-
 tests/prettify_perf.data.sh |  4 ++--
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index aa584a0939ff842c..a4c54d569e0788cd 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -4586,7 +4586,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 			cus__remove(cus, type_cu);
 	}
 
-	if (cus__merging_cu(dw, elf)) {
+	if (conf->force_cu_merging || cus__merging_cu(dw, elf)) {
 		res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
 						build_id, build_id_len,
 						type_cu ? type_dcu : NULL);
diff --git a/dwarves.h b/dwarves.h
index f5368f68c2460488..79b10725fec08a44 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -112,6 +112,7 @@ struct conf_load {
 	const char		*kabi_prefix;
 	struct btf		*base_btf;
 	struct conf_fprintf	*conf_fprintf;
+	bool			force_cu_merging;
 };
 
 /** struct conf_fprintf - hints to the __fprintf routines
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 21378a224847eb45..e3ce737460efec72 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -314,8 +314,10 @@ Generate BTF for functions with optimization-related suffixes (.isra, .constprop
 Allow using all the BTF features supported by pahole.
 
 .TP
-.B \-\-btf_features=FEATURE_LIST
-Encode BTF using the specified feature list, or specify 'default' for all
+.B \-\-features=FEATURE_LIST
+This is also available as \-\-btf_features=FEATURE_LIST, unknown features,
+like those added in newer versions of pahole, are ignored.  BTF encoding
+configuration is the major user. Using 'default' will enable all
 standard features supported.
 This option can be used as an alternative to using multiple BTF-related options,
 and 'default' represents the standard set of BTF features that are in use for
@@ -364,6 +366,18 @@ Supported non-standard features (not enabled for 'default')
 	layout             Encode information about BTF kinds available at encoding     
 	                   time in layout section in BTF.
 
+Non-standard, non-BTF related features:
+
+	force_cu_merging   Force merging all CUs into one. Use when there are
+	                   references across CUs. This happens in some LTO cases
+	                   and was observed with Rust CUs, where types tags
+	                   (function parameters, abstract origins for inlines, etc)
+	                   reference types in another CU.
+	                   For LTO this is being autodetected and the merging of
+	                   cus is done automatically, but for the Rust case, and
+	                   maybe others this is needed with the current DWARF
+	                   loading algorithm.
+
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF
diff --git a/pahole.c b/pahole.c
index 0a7b810568f0dfeb..372b9c3bd78ae227 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1154,6 +1154,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARG_padding		   348
 #define ARGP_with_embedded_flexible_array 349
 #define ARGP_btf_attributes	   350
+#define ARGP_features		   351
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1241,7 +1242,8 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
 				      attributes_check),
 	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
-	BTF_NON_DEFAULT_FEATURE_CHECK(layout, btf_gen_layout, false, layout_check)
+	BTF_NON_DEFAULT_FEATURE_CHECK(layout, btf_gen_layout, false, layout_check),
+	BTF_NON_DEFAULT_FEATURE(force_cu_merging, force_cu_merging, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
@@ -1312,6 +1314,14 @@ static void btf_features__enable_all(void)
 		 * want distilled_base must request it explicitly. */
 		if (btf_features[i].conf_value == &conf_load.btf_gen_distilled_base)
 			continue;
+		/* force_cu_merging forces the serialized, single-threaded
+		 * merged-CU loading path.  Enabling it unconditionally
+		 * with --btf_features=all or --btf_gen_all changes output
+		 * and slows loading for files that don't need CU merging.
+		 * Users who want force_cu_merging must request it
+		 * explicitly. */
+		if (btf_features[i].conf_value == &conf_load.force_cu_merging)
+			continue;
 		enable_btf_feature(&btf_features[i]);
 	}
 }
@@ -1816,6 +1826,12 @@ static const struct argp_option pahole__options[] = {
 		.arg = "FEATURE_LIST",
 		.doc = "Specify supported BTF features in FEATURE_LIST or 'default' for default set of supported features. See the pahole manual page for the list of supported, default features."
 	},
+	{
+		.name = "features",
+		.key = ARGP_features,
+		.arg = "FEATURE_LIST",
+		.doc = "Specify supported features in FEATURE_LIST or 'default' for default set of supported features. See the pahole manual page for the list of supported, default features."
+	},
 	{
 		.name = "supported_btf_features",
 		.key = ARGP_supported_btf_features,
@@ -2028,6 +2044,7 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.reproducible_build = true;	break;
 	case ARGP_running_kernel_vmlinux:
 		show_running_kernel_vmlinux = true;	break;
+	case ARGP_features:
 	case ARGP_btf_features:
 		parse_btf_features(arg, false);		break;
 	case ARGP_supported_btf_features:
diff --git a/tests/prettify_perf.data.sh b/tests/prettify_perf.data.sh
index 1fae95154d710aae..384c250ff4e01a4c 100755
--- a/tests/prettify_perf.data.sh
+++ b/tests/prettify_perf.data.sh
@@ -25,7 +25,7 @@ fi
 perf_lacks_type_info() {
 	local type_keyword=$1
 	local type_name=$2
-	if ! pahole -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
+	if ! pahole --features=force_cu_merging -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
 		info_log "skip: $perf doesn't have '$type_keyword $type_name' type info"
 		test_skip
 	fi
@@ -41,7 +41,7 @@ $perf record --quiet -o $perf_data sleep 0.00001
 
 number_of_filtered_perf_record_metadata() {
 	local metadata_record=$1
-	local count=$(pahole -F dwarf -V $perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C "perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type,filter=type==PERF_RECORD_$metadata_record)" --prettify $perf_data | grep ".type = PERF_RECORD_$metadata_record," | wc -l)
+	local count=$(pahole --features=force_cu_merging -F dwarf -V $perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C "perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type,filter=type==PERF_RECORD_$metadata_record)" --prettify $perf_data | grep ".type = PERF_RECORD_$metadata_record," | wc -l)
 	echo "$count"
 }
 
-- 
2.55.0

