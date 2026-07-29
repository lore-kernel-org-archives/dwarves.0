Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA424CA268;
	Wed, 29 Jul 2026 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352131; cv=none; b=YN4ee1Q6ySN7Gg34zn/PBvDFQ4AJxrfPSC6t5sku02ubJQPp+85BsaDoF5Tok/RLe3h0c4YVeZLuc7wjcbteIFgVKt2Mb93E0eSu5NvapnvzA4prx0OZ8zVWXgjBem/wBY4gMd6lVhCvpMqQdCyWmp7CD+TnXGzVhVCCOdip2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352131; c=relaxed/simple;
	bh=XhxIdW7ncde0VW5Jy9AeCUnaZqs9npZ16fn+lQYSM5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4QdAJFxUaMItK3x9K580malkCJ6CdzIc9Ibp0Dd4EFWaupb4rMUBimzK/O2YFfFCWC/zU3WLGAGEtabIlfODcd0grXnAtgs0CxxCdNuOQ8kF6Rw/nv2i3572/0LuR7cb9OHlVvnvB9acBzQUalKl2Oky9WB+Us71dAL7TZxt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Q4lUou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Q4lUou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DC81F000E9;
	Wed, 29 Jul 2026 19:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352129;
	bh=XFCWmyqIWAGykDNUXm0CQFfJFXF2fQD0o8SGN8+eKPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o2Q4lUouvjDi6hm8SHv+/vVN5or/ROFT97jEII+IwcWPGo0ZQauOvZNwzmPWv4f7e
	 cf5BxViM6QGdssgUMbWkG4xLDKfRrc7FQxVRUC4fXUIPoPDvaMHJjT/sZChYgO8sxo
	 lXK8/omtkmGQt1VoReWXulUCRHfBAPOoOkIhsAf/Ij+OvQuSsBe4l4hcKdoYhzWCr9
	 ID9E03Qxy9GDD0En0BpSlyks0/xWIrrRNe/728VnSt2l7vFczM/VBRCSh+qdY4mN2F
	 HDxWrEC2Xdl0K0X/BNDe8GPxSVtg8v87OyoLK2Z1A7UrMjsL+l7wGBSSoBmSsOc/TL
	 oImbE/chOpzQA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/31] btfdiff: Remove --flat_arrays now that pahole encodes multi dim arrays in  BTF
Date: Wed, 29 Jul 2026 16:07:31 -0300
Message-ID: <20260729190733.72876-32-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With it, i.e. flattening DWARF arrays we get:

acme@number:~/git/build/v7.2-rc3+$ btfdiff vmlinux
--- /tmp/btfdiff.dwarf.sXVla7	2026-07-16 18:53:09.744346444 -0300
+++ /tmp/btfdiff.btf.uzBSIz	2026-07-16 18:53:04.975270734 -0300
@@ -21905,7 +21905,7 @@ struct amd_iommu {

 	/* typedef u32 -> __u32 */ unsigned int               stored_addr_lo;            /*   336     4 */
 	/* typedef u32 -> __u32 */ unsigned int               stored_addr_hi;            /*   340     4 */
-	/* typedef u32 -> __u32 */ unsigned int               stored_l1[108];            /*   344   432 */
+	/* typedef u32 -> __u32 */ unsigned int               stored_l1[6][18];          /*   344   432 */
 	/* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
 	/* typedef u32 -> __u32 */ unsigned int               stored_l2[131];            /*   776   524 */
 	/* --- cacheline 20 boundary (1280 bytes) was 20 bytes ago --- */
@@ -22489,7 +22489,7 @@ struct amd_mdb_pcie {
 			/* --- cacheline 6 boundary (384 bytes) --- */
 			struct pci_eq_presets {
 				/* typedef u16 -> __u16 */ short unsigned int eq_presets_8gts[16]; /*   384    32 */
-				/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[48]; /*   416    48 */
+				/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[3][16]; /*   416    48 */
 			} presets; /*   384    80 */
 			/* --- cacheline 7 boundary (448 bytes) was 16 bytes ago --- */
 			struct pci_config_window * cfg;                                  /*   464     8 */
@@ -29007,7 +29007,7 @@ struct audit_aux_data_pids {
 		} bpf; /*   296     4 */
 	} target_ref[16]; /*   272   512 */
 	/* --- cacheline 12 boundary (768 bytes) was 16 bytes ago --- */
-	char                       target_comm[256];                                     /*   784   256 */
+	char                       target_comm[16][16];                                  /*   784   256 */
 	/* --- cacheline 16 boundary (1024 bytes) was 16 bytes ago --- */
 	int                        pid_count;                                            /*  1040     4 */

@@ -30613,7 +30613,7 @@ struct automaton_nomiss {
 	char *                     event_names[7];                                       /*    40    56 */
 	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
 	char *                     env_names[3];                                         /*    96    24 */
-	unsigned char              function[35];                                         /*   120    35 */
+	unsigned char              function[5][7];                                       /*   120    35 */
 	/* --- cacheline 2 boundary (128 bytes) was 27 bytes ago --- */
 	unsigned char              initial_state;                                        /*   155     1 */
 	/* typedef bool */ _Bool                      final_states[5];                   /*   156     5 */
@@ -30627,7 +30627,7 @@ struct automaton_stall {
 	char *                     event_names[4];                                       /*    24    32 */
 	char *                     env_names[1];                                         /*    56     8 */
 	/* --- cacheline 1 boundary (64 bytes) --- */
-	unsigned char              function[12];                                         /*    64    12 */
+	unsigned char              function[3][4];                                       /*    64    12 */
 	unsigned char              initial_state;                                        /*    76     1 */
 	/* typedef bool */ _Bool                      final_states[3];                   /*    77     3 */

@@ -30637,7 +30637,7 @@ struct automaton_stall {
 struct automaton_wip {
 	char *                     state_names[2];                                       /*     0    16 */
 	char *                     event_names[3];                                       /*    16    24 */
-	unsigned char              function[6];                                          /*    40     6 */
+	unsigned char              function[2][3];                                       /*    40     6 */
 	unsigned char              initial_state;                                        /*    46     1 */
 	/* typedef bool */ _Bool                      final_states[2];                   /*    47     2 */

@@ -30648,7 +30648,7 @@ struct automaton_wip {
 struct automaton_wwnr {
 	char *                     state_names[2];                                       /*     0    16 */
 	char *                     event_names[3];                                       /*    16    24 */
-	unsigned char              function[6];                                          /*    40     6 */
+	unsigned char              function[2][3];                                       /*    40     6 */
 	unsigned char              initial_state;                                        /*    46     1 */
 	/* typedef bool */ _Bool                      final_states[2];                   /*    47     2 */

@@ -136221,7 +136221,7 @@ struct dw_pcie {
 		/* --- cacheline 6 boundary (384 bytes) --- */
 		struct pci_eq_presets {
 			/* typedef u16 -> __u16 */ short unsigned int eq_presets_8gts[16]; /*   384    32 */
-			/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[48];      /*   416    48 */
+			/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[3][16];   /*   416    48 */
 		} presets; /*   384    80 */
 		/* --- cacheline 7 boundary (448 bytes) was 16 bytes ago --- */
 		struct pci_config_window * cfg;                                          /*   464     8 */
@@ -136582,7 +136582,7 @@ struct dw_pcie_rp {
 	struct pci_eq_presets {
 		/* typedef u16 -> __u16 */ short unsigned int eq_presets_8gts[16];       /*   288    32 */
 		/* --- cacheline 5 boundary (320 bytes) --- */
-		/* typedef u8 -> __u8 */ unsigned char      eq_presets_Ngts[48];         /*   320    48 */
+		/* typedef u8 -> __u8 */ unsigned char      eq_presets_Ngts[3][16];      /*   320    48 */
 	} presets; /*   288    80 */
 	struct pci_config_window * cfg;                                                  /*   368     8 */
 	/* typedef bool */ _Bool                      ecam_enabled;                      /*   376     1 */
@@ -173280,7 +173280,7 @@ struct fu740_pcie {
 			/* --- cacheline 6 boundary (384 bytes) --- */
 			struct pci_eq_presets {
 				/* typedef u16 -> __u16 */ short unsigned int eq_presets_8gts[16]; /*   384    32 */
-				/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[48]; /*   416    48 */
+				/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[3][16]; /*   416    48 */
 			} presets; /*   384    80 */
 			/* --- cacheline 7 boundary (448 bytes) was 16 bytes ago --- */
 			struct pci_config_window * cfg;                                  /*   464     8 */
@@ -191392,10 +191392,10 @@ struct hugetlb_cgroup {
 	/* --- cacheline 832 boundary (53248 bytes) --- */
 	/* typedef atomic_long_t -> atomic64_t */ struct {
 		/* typedef s64 -> __s64 */ long long int      counter;                   /* 53248     8 */
-	} events[2]; /* 53248    16 */
+	} events[2][1]; /* 53248    16 */
 	/* typedef atomic_long_t -> atomic64_t */ struct {
 		/* typedef s64 -> __s64 */ long long int      counter;                   /* 53264     8 */
-	} events_local[2]; /* 53264    16 */
+	} events_local[2][1]; /* 53264    16 */
 	struct cgroup_file {
 		struct kernfs_node * kn;                                                 /* 53280     8 */
 		long unsigned int  notified_at;                                          /* 53288     8 */
@@ -234492,7 +234492,7 @@ struct intel_pcie {
 			/* --- cacheline 6 boundary (384 bytes) --- */
 			struct pci_eq_presets {
 				/* typedef u16 -> __u16 */ short unsigned int eq_presets_8gts[16]; /*   384    32 */
-				/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[48]; /*   416    48 */
+				/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[3][16]; /*   416    48 */
 			} presets; /*   384    80 */
 			/* --- cacheline 7 boundary (448 bytes) was 16 bytes ago --- */
 			struct pci_config_window * cfg;                                  /*   464     8 */
@@ -263257,7 +263257,7 @@ struct keembay_pcie {
 			/* --- cacheline 6 boundary (384 bytes) --- */
 			struct pci_eq_presets {
 				/* typedef u16 -> __u16 */ short unsigned int eq_presets_8gts[16]; /*   384    32 */
-				/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[48]; /*   416    48 */
+				/* typedef u8 -> __u8 */ unsigned char eq_presets_Ngts[3][16]; /*   416    48 */
 			} presets; /*   384    80 */
 			/* --- cacheline 7 boundary (448 bytes) was 16 bytes ago --- */
 			struct pci_config_window * cfg;                                  /*   464     8 */
<Big SNIP>
@@ -617956,14 +617956,14 @@ struct xz_dec_microlzma {
 			struct lzma_len_dec {
 				/* typedef uint16_t -> u16 -> __u16 */ short unsigned int choice; /*  2824     2 */
 				/* typedef uint16_t -> u16 -> __u16 */ short unsigned int choice2; /*  2826     2 */
-				/* typedef uint16_t -> u16 -> __u16 */ short unsigned int low[128]; /*  2828   256 */
+				/* typedef uint16_t -> u16 -> __u16 */ short unsigned int low[16][8]; /*  2828   256 */
 				/* --- cacheline 48 boundary (3072 bytes) was 12 bytes ago --- */
-				/* typedef uint16_t -> u16 -> __u16 */ short unsigned int mid[128]; /*  3084   256 */
+				/* typedef uint16_t -> u16 -> __u16 */ short unsigned int mid[16][8]; /*  3084   256 */
 				/* --- cacheline 52 boundary (3328 bytes) was 12 bytes ago --- */
 				/* typedef uint16_t -> u16 -> __u16 */ short unsigned int high[256]; /*  3340   512 */
 			} rep_len_dec; /*  2824  1028 */
 			/* --- cacheline 60 boundary (3840 bytes) was 12 bytes ago --- */
-			/* typedef uint16_t -> u16 -> __u16 */ short unsigned int literal[12288]; /*  3852 24576 */
+			/* typedef uint16_t -> u16 -> __u16 */ short unsigned int literal[16][768]; /*  3852 24576 */
 		} lzma; /*   124 28304 */
 		/* --- cacheline 444 boundary (28416 bytes) was 12 bytes ago --- */
 		struct {

Now, removing --flat_arrays makes it clean, meaning both DWARF and BTF
loaders support multi dimensional arrays and so does the BTF encoder.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btfdiff | 1 -
 1 file changed, 1 deletion(-)

diff --git a/btfdiff b/btfdiff
index 46348f46a08c50ab..18794dfd3e1562d4 100755
--- a/btfdiff
+++ b/btfdiff
@@ -24,7 +24,6 @@ dwarf_output=$(mktemp /tmp/btfdiff.dwarf.XXXXXX)
 pahole_bin=${PAHOLE-"pahole"}
 
 ${pahole_bin} -E -F dwarf \
-	      --flat_arrays \
 	      --sort \
 	      --jobs \
 	      --suppress_aligned_attribute \
-- 
2.55.0

