Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043A158A00
	for <dwarves@vger.kernel.org>; Tue, 16 Jul 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155443; cv=none; b=o9bWtyrwA01viASzT+LC6VCNhehF8xLS6nALE9tAPIZ4wuZrVmmgl+9FC4/dvgMrq1UGM162eDgNy2QGB+YJWafWNz8J2KHkKiJr4g235PjseA/Ul/sMxjC1gKGs1TIqTjTxYRcZRdUjMmqNQzlBaUmraBlajMyhKcnOpdbvlnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155443; c=relaxed/simple;
	bh=n+MRqrx6uATKYYShdW+uv5r6Ud9LgS/aUbPGcBD4FTM=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LZOAeRzB1RN0z55eO2r9wKSXh4Kp2Ca7M2hTQAcql9G/WLhSD+ADyehvlxIOoRGX9oU/yT8ENdouCjeVlUSmnd+NAtfNDKiPLMGo+axJRQ8LeXRucK8envF9MfoxnWr7CWrjeHG5v1UBPRWhh+jsZQnL6b2YabcdGBHQ8Ntwr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph+trt6x; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph+trt6x"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c7b6c6a581so67348eaf.0
        for <dwarves@vger.kernel.org>; Tue, 16 Jul 2024 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721155441; x=1721760241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A1zxHYzSRHpPVYTcGX3J7Rgk0ZGg1jiOKquf1+pLRk=;
        b=Ph+trt6xW83B3nqRykSxi/NqpAhSj4DIZbCpvneCm3osVwIzMiJSpWzC72Rjn79/Gt
         kTEo0Rjw2hYwDpVwwn0m1cUQO1/tYDTW0AOLetWGP+aPD85zc0DVKIB1Ey6AWsKDbI6Z
         8czNl065RBuc5c633A8txjYcLYsMmDZ74rVuak3EkaN3KUo4aS6cUTckAy2R9IT4dRgW
         Bc6WZhAWELsIlGQTSQ95Pom2VieBwRooUd0WbyM6BkFeE5v1AWdgR0a1pRGTPaCHBwMk
         aZ7/KuKwvOGU4mMP8W+8wjyPUpAVTURNviXIfmd11OXY+YPeWztI81gCqDwj7wCZxFOn
         Vecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155441; x=1721760241;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A1zxHYzSRHpPVYTcGX3J7Rgk0ZGg1jiOKquf1+pLRk=;
        b=tIQm5FIRV2UVCCyLwCFzG09Zq+7ayK8MxdvnEGPM5U8r+gcV5jaQ7jY6fpEFvpFdkc
         QKvdDxSyA/P3pW4SQt2rCUKS+kWfEL+BETremVLEbCZQeMW5rukB9Z95rr3AgcYgYDlY
         BV6kLAw4nM3AbKnY1sUCISezH/1xgA4wKnViBkUSICJ2rnrYH/MkVoyzeeLhFQ+e3NoX
         TPVeHmHXXd2gydAfHNXFosyc3X9Cm6m+bwtPm6IcCgH2wwkHJPQ8z8MtWZE7igP0Minn
         /F3QVuI4kRjYcq12psUrmztHVozWmk8OMd+uHhFa5JL9Rs7LPd2kqxRZYwGMf2703F42
         B/nQ==
X-Gm-Message-State: AOJu0YxF/4ISjLzlCC1TrGvymQz/64bdGBaKqEjh2zFB2OxBIo8vBMID
	iMxOboYQ3B1hAxI+Uc4vows/CCHGCb1ep6aboBDeb2hsKTZZNnMgZmsgJA==
X-Google-Smtp-Source: AGHT+IEzNWexTH4gzHCZaXx8iNvr75rY03FMhqOT0wVZ+OIOCw8/Fp9BPWKXUA2Sf6T77pLEtblFqw==
X-Received: by 2002:a05:6358:471b:b0:19f:4967:4e8f with SMTP id e5c5f4694b2df-1ac903df6c6mr349615955d.22.1721155441006;
        Tue, 16 Jul 2024 11:44:01 -0700 (PDT)
Received: from localhost ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e32b6bbdasm4279861a12.19.2024.07.16.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:44:00 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 16 Jul 2024 15:43:57 -0300
To: Matthias Schwarzott <zzam@gentoo.org>
Cc: dwarves@vger.kernel.org
Subject: [PATCH 1/1] dwarf_loader: Hash DW_TAG_enumerator entries
Message-ID: <Zpa_bfGXfR1rFV2e@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

As they are referenced by DW_TAG_imported_declaration, as we can see
from these warnings:

  ⬢[acme@toolbox zzam@gentoo.org]$ pdwtags popup.cpp.o > /dev/null
  die__process_class: tag not supported 0x2f (template_type_parameter)!
  die__process_class: tag not supported 0x30 (template_value_parameter)!
  die__process_class: tag not supported 0x4107 (GNU_template_parameter_pack)!
  die__process_function: tag not supported 0x4108 (GNU_formal_parameter_pack)!
  tag__recode_dwarf_type: couldn't find 0x5706e type for 0xedb9 (imported_declaration)!
  tag__recode_dwarf_type: couldn't find 0x57074 type for 0xedc1 (imported_declaration)!
  tag__recode_dwarf_type: couldn't find 0x5707a type for 0xedc9 (imported_declaration)!
  namespace__recode_dwarf_types: couldn't find 0x5706e type for 0xedb9 (imported_declaration)!
  namespace__recode_dwarf_types: couldn't find 0x57074 type for 0xedc1 (imported_declaration)!
  namespace__recode_dwarf_types: couldn't find 0x5707a type for 0xedc9 (imported_declaration)!
  ⬢[acme@toolbox zzam@gentoo.org]$

Looking at the DWARF info for one of those types not found:

  ⬢[acme@toolbox zzam@gentoo.org]$ readelf -wi popup.cpp.o | grep -w edb9 -A5
   <2><edb9>: Abbrev Number: 14 (DW_TAG_imported_declaration)
      <edba>   DW_AT_decl_file   : 64
      <edbb>   DW_AT_decl_line   : 100
      <edbc>   DW_AT_decl_column : 20
      <edbd>   DW_AT_import      : <0x5706e>	[Abbrev Number: 51 (DW_TAG_enumerator)]
   <2><edc1>: Abbrev Number: 14 (DW_TAG_imported_declaration)
  ⬢[acme@toolbox zzam@gentoo.org]$

And then:

  ⬢[acme@toolbox zzam@gentoo.org]$ readelf -wi popup.cpp.o | grep -w 5706e -A3
   <3><5706e>: Abbrev Number: 51 (DW_TAG_enumerator)
      <5706f>   DW_AT_name        : (indirect string, offset: 0xaec05): _S_single
      <57073>   DW_AT_const_value : 0
   <3><57074>: Abbrev Number: 51 (DW_TAG_enumerator)
  ⬢[acme@toolbox zzam@gentoo.org]$

So we need to hash those DW_TAG_enumerator and not just the
DW_TAG_enumerator_type containing them.

This way tag__recode_dwarf_type() and namespace__recode_dwarf_types()
will find them when looking them up using dwarf_cu__find_type_by_ref().

This was found first on the stratagus codebase (C++) at
https://github.com/Wargus/stratagus.git.

This didn't generate any difference in output from pahole, not
influenced BTF generation as tested using tests/reproducible_build.sh.

Reported-by: Matthias Schwarzott <zzam@gentoo.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 2d49960120b56f78..d914b91c1f375f7f 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1776,6 +1776,7 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
 			goto out_delete;
 
 		enumeration__add(enumeration, enumerator);
+		cu__hash(cu, &enumerator->tag);
 	} while (dwarf_siblingof(die, die) == 0);
 out:
 	return &enumeration->namespace.tag;
-- 
2.45.0

