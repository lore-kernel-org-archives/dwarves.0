Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2179271453
	for <dwarves@vger.kernel.org>; Thu,  7 Aug 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591168; cv=none; b=GIDYPQBw6AynAiYfD6cgAWcu3LtXWNcH3GXxe5cgVmyMh9x7eVxr0kq4kzsHNdYbfYg6vOgVgOeMstRMilbg9DnZR9AyhyP1ZPBwy2wd3gpvAg2RZ8n/zN1jBv6crZjC5VdDZdnvxqyLLG4UpWpfr1OToRx08Mu9Ba0X/blmcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591168; c=relaxed/simple;
	bh=NT9pT3FVP2q6RAKEtFcWYaBBOjpAv4+ger9VhP22x9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJ9hYWsl2wS7EzXZQSRRR318j8/9OvJV6iW3i+Q+sPgBuNTKsB83nyrLehbDbjlzSHEFXQFtGRHezowbVochsF10hlnGXiiLTSZrdgOS8rFjgx1ypewtbe7nm7cPe61JWhjGqVhdXtnM9EpND71cegFH/95PmKLD92NIlUdanUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJyOzzgM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJyOzzgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A953DC4CEEB;
	Thu,  7 Aug 2025 18:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754591167;
	bh=NT9pT3FVP2q6RAKEtFcWYaBBOjpAv4+ger9VhP22x9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJyOzzgMl4xyZtlO65JN7IdhVqYMHE/4/JKVvJjiC6Wl59taXEa053E2pv5tcTdiv
	 fkda7N+T8lnzLBkrGT1dNjlPEQJ7QBig/xlLfKJdKdbINIgdQOjtHpFHHHkNXRje/7
	 hXp8nuGWltchMGGDYqgW3wNimWlcVUDMZ6YEHMHrDFF7OnHlotDe8kged44Hc4jUja
	 /h1hzAWN9QNKnqT9BYPhfS4P+XKkse/VyihMYV6LUSmBCvMEfn79MoJwWinuGknBIB
	 XPmUvuE707D3B4JRGU+h5Lxyb1cJogtfW8zzfLZY4w5peOVHwWAFjsKmA9SO6HugAq
	 ILGbrgpyGa5DA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Nick Alcock <nick.alcock@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH 4/4] libbpf: Check if an ELF .BTF section is an archive and combine/dedup
Date: Thu,  7 Aug 2025 15:25:38 -0300
Message-ID: <20250807182538.136498-5-acme@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807182538.136498-1-acme@kernel.org>
References: <20250807182538.136498-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we don't have some sort of btf_opts to influence that and having
an ELF archive is more likely at this point in an ELF section,
vmlinux's, lets do it in btf_parse_elf() so that we can demonstrate the
concept.

So, if we use an unmodified bpftool with a vmlinux generated with an
unmodified pahole and toolchain (compiler and linker):

  $ cat cmd_pahole_btf_o.patch
  diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
  index 4d543054f72356a4..02a595b82b299151 100644
  --- a/scripts/Makefile.lib
  +++ b/scripts/Makefile.lib
  @@ -313,7 +313,7 @@ cmd_ld_single = $(if $(objtool-enabled)$(is-single-obj-m), ; $(LD) $(ld_flags) -
   endif

   quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
  -      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< \
  +      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< && ${PAHOLE} --btf_encode ${PAHOLE_FLAGS} $@ \
                $(cmd_ld_single) \
                $(cmd_objtool)

  $

We get this:

  $ bpftool btf dump file ~/vmlinux.btf_archive > dedup_combined_btf_archive
  $ wc -l dedup_combined_btf_archive
  12084 dedup_combined_btf_archive
  $ head dedup_combined_btf_archive
  [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
  [2] CONST '(anon)' type_id=1
  [3] VOLATILE '(anon)' type_id=2
  [4] ARRAY '(anon)' type_id=1 index_type_id=21 nr_elems=2
  [5] PTR '(anon)' type_id=8
  [6] CONST '(anon)' type_id=5
  [7] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
  [8] CONST '(anon)' type_id=7
  [9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
  [10] CONST '(anon)' type_id=9
  $

While with one that detects it is a BTF archive (multiple .o .BTF ELF
sections concatenated into the .BTF ELF section for vmlinux):

  $ tools/bpf/bpftool/bpftool btf dump file ~/vmlinux.btf_archive > dedup_combined_btf_archive
  $ wc -l dedup_combined_btf_archive
  358141 dedup_combined_btf_archive
  $ head dedup_combined_btf_archive
  [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
  [2] CONST '(anon)' type_id=1
  [3] VOLATILE '(anon)' type_id=2
  [4] ARRAY '(anon)' type_id=1 index_type_id=21 nr_elems=2
  [5] PTR '(anon)' type_id=8
  [6] CONST '(anon)' type_id=5
  [7] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
  [8] CONST '(anon)' type_id=7
  [9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
  [10] CONST '(anon)' type_id=9
  $

Which is in the same ballpark number of lines for BTF in a distro
kernel:

  $ tools/bpf/bpftool/bpftool btf dump file /sys/kernel/btf/vmlinux | wc -l
  355944
  $

Doing a fresh build with the above cmd_cc_o_c that generates BTF from
DWARF for every .o file, still not stripping the DWARF after that:

  $ bpftool btf dump file ../build/v6.16.0+/vmlinux | wc -l
  11927
  $ ../bpf-next/tools/bpf/bpftool/bpftool btf dump file ../build/v6.16.0+/vmlinux | wc -l
  360016
  $ ../bpf-next/tools/bpf/bpftool/bpftool btf dump file ../build/v6.16.0+/init/main.o | wc -l
  11927
  $ #bpftool btf dump file ../build/v6.16.0+/vmlinux | wc -l
  $ bpftool btf dump file ../build/v6.16.0+/vmlinux > just_first_entry_in_the_archive_using_old_non_btf_archive_aware_bpftool
  $ bpftool btf dump file ../build/v6.16.0+/init/main.o > first_CU_BTF_using_old_non_btf_archive_aware_bpftool
  $ diff -u just_first_entry_in_the_archive_using_old_non_btf_archive_aware_bpftool first_CU_BTF_using_old_non_btf_archive_aware_bpftool

Ok, now lets save that vmlinux with .BTF in all its .o files:

  $ cp ../build/v6.16.0+/vmlinux ~/vmlinux-v6.16.0+.btf_archive

And remove that per .o BTF encoding so that the end result isn't a BTF
archive:

  $ patch -p1 -R < cmd_cc_encode_btf_per_o.patch
  patching file scripts/Makefile.lib
  $

Lets rebuild it with that and make sure the end result doesn't have any
.BTF per .o:

  $ readelf -SW ../build/v6.16.0+/init/main.o  | grep BTF
  $ bpftool btf dump file ../build/v6.16.0+/init/main.o
  libbpf: failed to find '.BTF' ELF section in ../build/v6.16.0+/init/main.o
  Error: failed to load BTF from ../build/v6.16.0+/init/main.o: No data available
  $

So with an old bpftool we should get the same number of lines and the
same result when dumping from the .BTF dumped from the new bpftool for
both the BTF archive and the one generated from DWARF only at the last
minute, from DWARF:

  $ bpftool btf dump file ../build/v6.16.0+/vmlinux | wc -l
  357654
  $
  $ ../bpf-next/tools/bpf/bpftool/bpftool btf dump file ../build/v6.16.0+/vmlinux | wc -l
  357654
  $

So there is a difference, which one?

  $ bpftool btf dump file ../build/v6.16.0+/vmlinux > DWARF-to-BTF-after+vmlinux
  $ ../bpf-next/tools/bpf/bpftool/bpftool btf dump file ~/vmlinux-v6.16.0+.btf_archive > DWARF-to-BTF-from-btf_archive

It starts with anon types like:

  --- DWARF-to-BTF-after+vmlinux  2025-08-06 13:31:02.814268740 -0300
  +++ DWARF-to-BTF-from-btf_archive       2025-08-06 13:31:27.818597644 -0300
  @@ -499,7 +499,7 @@
          'target' type_id=34 bits_offset=32
          'key' type_id=44 bits_offset=64
   [155] PTR '(anon)' type_id=154
  -[156] PTR '(anon)' type_id=16561
  +[156] PTR '(anon)' type_id=41426
   [157] STRUCT 'static_key' size=16 vlen=2
          'enabled' type_id=91 bits_offset=0
          '(anon)' type_id=153 bits_offset=64
  ...
  +[16561] FUNC 'alloc_rmp_segment_table' type_id=858 linkage=static
  -[16561] STRUCT 'static_key_mod' size=24 vlen=3
  ...
  +[41426] STRUCT 'static_key_mod' size=24 vlen=3
          'next' type_id=156 bits_offset=0
          'entries' type_id=155 bits_offset=64
          'mod' type_id=166 bits_offset=128
  ...
  -[41426] STRUCT 'ohci_hcd' size=1160 vlen=34

So there is some drift, is it coming from btf__add_btf()? This one isn't
used in pahole... Maybe this is something Alan addressed in his series
he pointed to me? Time to relook...

But, as explained in the cover letter of this series, the vmlinux.h
produced by 'bpftool bpf dump file vmlinux format c" with/without this
series matches, its just something that btf__add_btf() does that is
slightly different from what is done by pahole when converting from
DWARF to BTF, not using btf__add_btf() but each of the tags converted
from DWARF -> internal pahole representation-> libbpf -> BTF.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Alcock <nick.alcock@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/btf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 73a6d94eeda125e1..df6810ad83ecff85 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1302,6 +1302,13 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 		err = PTR_ERR(btf);
 		goto done;
 	}
+
+	if (btf__is_archive(btf)) {
+		err = btf__dedup_archive(btf, secs.btf_data->d_buf, secs.btf_data->d_size, NULL);
+		if (err)
+			goto done;
+	}
+
 	if (dist_base_btf && base_btf) {
 		err = btf__relocate(btf, base_btf);
 		if (err)
-- 
2.50.1

