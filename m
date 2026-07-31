Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F9328267;
	Fri, 31 Jul 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526286; cv=none; b=IdZHZv4vVJYsoXDrBrU0e4GnBOdEKH910z1E3tmWMZxJHsiyuvs/s09bJ7V9Bb0wRnecC1HOgszuLBnPV1QBP/pAybK/8x1nxxU8G3wI3NyuHZaCldYxLgKbqoTT/R5j0RH5mwEhOTT+NumiVGPEcabQvWCmzhH/LpxWIqHdObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526286; c=relaxed/simple;
	bh=3i4d1TRbg3UAVuCD4zXFFY+zMNwwcv6+7YZwjOImLNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDgZMDNy9Cirr6EkkiJ9q6remuIAnE7DbuLEafAuaLtc42uMPbg+wHpn8yY9OFawVGWEn2mjlpUdw1FuczNzMZNWpFYW3sKfV5HuAbW+YNO2TRO9ovtSreSHRt+l9A9TcG1aQ1+RuwBf9OTCBkbycW0YULB/YcABc/n7C6cmDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDd2IEhD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDd2IEhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7690E1F00AC4;
	Fri, 31 Jul 2026 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526284;
	bh=VC1UaqAJpAzhj+Vig/jQDZjAnmdNTsyrKcEjklmAJt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDd2IEhDNcPpQTIs7sAeWHo2QUqTHK/e1hWF1lDMHjgDCwRC+RgJP8QpXiIUjdAi8
	 Go3At9It9qhIIgDhDmT1Ich/Etdc8j1BEFrC5mHfgwjqKUjs4IgHEDgQZ+mnAZQ5JD
	 9CxbRFy5dOfaW9hFRUsBuu6JwzisApWY73y+q/5AMQB+FFQ2chQahzSW2B8sGmkmI1
	 903pV7sv+SFeCOYXEpPV/JK60Z1k7AY4pDM/jFvEQz1b56O0GhK9FJIlypopL7L9Ue
	 9k4Kv3riG83CDIriTghLF8oy2rSbgvMER7ejzWvTDChHgaqLhYbwApzpL6WoXhAzhO
	 p0CFVohXbkjSA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mark Wieelard <mjw@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/12] dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
Date: Fri, 31 Jul 2026 16:30:54 -0300
Message-ID: <20260731193102.110693-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731193102.110693-1-acme@kernel.org>
References: <20260731193102.110693-1-acme@kernel.org>
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
feature to be enabled when we know it is needed bug can't guarantee that
the available pahole version has the feature and not have it fail
because it doesn't implement --force_cu_merging, which the
--btf_features=force_cu_merging, now also avaialbe as
--features=force_cu_merging, allows as it ignores unknown features.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c              |  2 +-
 dwarves.h                   |  1 +
 man-pages/pahole.1          | 18 ++++++++++++++++--
 pahole.c                    | 11 ++++++++++-
 tests/prettify_perf.data.sh |  4 ++--
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 934d410b2f983828..99bc121a377fbd8b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -4693,7 +4693,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 			cus__remove(cus, type_cu);
 	}
 
-	if (cus__merging_cu(dw, elf)) {
+	if (conf->force_cu_merging || cus__merging_cu(dw, elf)) {
 		res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
 						build_id, build_id_len,
 						type_cu ? type_dcu : NULL);
diff --git a/dwarves.h b/dwarves.h
index dd9aa332e61c77f0..38fec59ca78990df 100644
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
index 0a7b810568f0dfeb..b7559a124a86d722 100644
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
@@ -1816,6 +1818,12 @@ static const struct argp_option pahole__options[] = {
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
@@ -2028,6 +2036,7 @@ static error_t pahole__options_parser(int key, char *arg,
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

