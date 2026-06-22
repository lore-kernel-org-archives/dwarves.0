Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41634D3B2
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159914; cv=none; b=ZCm2VqLqpFe6bEcju8qDrJ/zTInIqle3A5sRQg35DDI1sblOHjo1Qx9AUMNInMxbmsJwrX9R0QDzBkiEhWnLr6zDjsIFT0D6m3BM6MNVBnhwnoq9d+WGOTmyctYsvkVEeh4MRemiTIYtDu6vOg1sCoYROAzDNM7B5GvAixsFVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159914; c=relaxed/simple;
	bh=hogWUktB9X+RGxpVDxfmoPVHPW5wT5wvIbNmuVLAx54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ap3IEUStGd1F9YIFlKodlJWC3fhsjf0hyTxHS7++Wm7T8yl70z1O8AbC/OefkuOMgmPHqVaLPAeZ5n9DeL/sWsN2GpbNDWmGAOdXnbXF0NdhYPvRvImdKhxwXUOMehbvw6yuVIcggael5smu/L3aDKtoYMtpeEYFMLbd6lNn7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBdscaCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBdscaCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659381F00A3A;
	Mon, 22 Jun 2026 20:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159913;
	bh=jleYuSRqGvmb5rfJr7vWW34FpS7EMSva05DiusGbbYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBdscaCHjfP3kDopowxakFzoVwK8QsZB+oToNnqfU4uTS2kHs6ZdKIRxqmy8+WlHH
	 Hr0YAVC8jh6yfBfmlFxUpSXxMKommIzxnSu1sfbUB7IxWP1EVbcR3jC8DQuA/CIxhd
	 06WeRXwlTa+MMbTFvRh0+ESZyG4ZTQF3aJZYq7HjYpvXzk7ryD5EIa8VHWchBgzYwO
	 Gn4HakF4U2WQb0DxJ/g966LHpILOP/4uyl0I5oYPpUF/t8IeZ/RkWrg70CEvpIWg3r
	 o0JppY78aP16hYSWIn6KR4Wu5TVjQiCLKURwS7/5hVm4EYS7qNcjmj7+71ZIhsJGc6
	 d2NuD/WdYmQ2g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/16] dwarf_loader: Handle DW_FORM_block in attr_numeric for Rust discriminant values
Date: Mon, 22 Jun 2026 17:24:34 -0300
Message-ID: <20260622202441.14799-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Rust enums with 128-bit discriminant types (i128/u128) encode their
DW_AT_discr_value as a DW_FORM_block1 containing a 16-byte little-endian
integer, rather than using a standard data form like DW_FORM_data*.

Since attr_numeric did not handle DW_FORM_block*, these discriminant
values were not read and produced 311 warnings on a real Rust binary like
sashiko-cli:

  DW_AT_<0x16>=0xa
  DW_AT_<0x16>=0xa
  ...

(0x16 = DW_AT_discr_value, 0xa = DW_FORM_block1)

Add DW_FORM_block1/block2/block4/block to attr_numeric, reading up to 8
bytes from the block into a uint64_t via memcpy and converting from
little-endian with le64toh() so the result is correct on big-endian hosts
as well.  This covers all practical discriminant values.

Before (sashiko-cli):

  $ pahole --btf_encode sashiko-cli 2>&1 | grep -c 'DW_AT_'
  311

After:

  $ pahole --btf_encode sashiko-cli 2>&1 | wc -l
  0

All warnings from Rust DWARF encoding of sashiko-cli are now resolved.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index fc88221ae339e7cd..9f7d2bd23359191b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -7,6 +7,7 @@
 #include <assert.h>
 #include <dirent.h>
 #include <dwarf.h>
+#include <endian.h>
 #include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
 #include <errno.h>
@@ -353,6 +354,19 @@ static uint64_t attr_numeric(Dwarf_Die *die, uint32_t name)
 			return value;
 	}
 		break;
+	case DW_FORM_block1:
+	case DW_FORM_block2:
+	case DW_FORM_block4:
+	case DW_FORM_block: {
+		Dwarf_Block block;
+		if (dwarf_formblock(&attr, &block) == 0 && block.length > 0) {
+			uint64_t value = 0;
+			size_t n = block.length > sizeof(value) ? sizeof(value) : block.length;
+			memcpy(&value, block.data, n);
+			return le64toh(value);
+		}
+	}
+		break;
 	default:
 		fprintf(stderr, "DW_AT_<0x%x>=0x%x\n", name, form);
 		break;
-- 
2.54.0

