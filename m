Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IARL9T6K"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A206124
	for <dwarves@vger.kernel.org>; Tue,  5 Dec 2023 05:03:40 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 887FB3F1C7
	for <dwarves@vger.kernel.org>; Tue,  5 Dec 2023 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701781418;
	bh=wnb/uRdYFxom4ilycPNrybV6F6Z0kayOYpRfLT64jFM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
	b=IARL9T6KSM9iHBzF5Tsfuauwx8EN2gTs2TcNePF/VjJLzzTojcNSrCfv4RIT+hHk+
	 mZ+llSHhlaLWaFJF0uyyqPub7z1MMb0ng7lB9d6VRybIoLytV1AlQAt+0x3MV5SPNN
	 UBwMQGl25gjJAj+gZZglky3h5/wLFz72MtucP2FA6/JLnHyoblO6bTqOAs+0QqRhhV
	 xPpcmWUsg5k2L5EZGf9O8Y4ZkmTTBR+2JQekxojHIdmUFLbq3bymba82a7yq/ADXQ6
	 clQwuKtRzR8g07IcqIwTkMABeDdeqGclou0TxrZeXTzOjUTZbfGH9aDPZMPOr0lKdf
	 kZSl3LY572kvw==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332ee20a40fso4339762f8f.3
        for <dwarves@vger.kernel.org>; Tue, 05 Dec 2023 05:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701781418; x=1702386218;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnb/uRdYFxom4ilycPNrybV6F6Z0kayOYpRfLT64jFM=;
        b=Tz24mhjtfuTbOOstMNfRBC87QExhWBkhLyS57ltu6dtc0Y7F7U1PF7tt+eht3saMxF
         Nw0ecppsrg7d47zmTl3cWK/gPmjclR59/9v1mTHnRRPJfCVf0eyjoC5ZcZaVLGK5tUJ3
         eq9cy1ZB807GNHT53aidQ+FWIoByLV5JgsRj7hcKcmMhAvpHpPH6T6Q5uYkeIwcJ5ha8
         PwDYrf8zSW0y4xeH2NzP6G4Zf5DPfaEPgmMlv9kf3JO/8laWBYrxZA5TNu/2GZoF3KyU
         CTWogF7JJ6PRdBygt01oatFTY9plNtAGaWrGbxTpxps3op6I6DlEnUxCH9TTAqpI4d/z
         Mjdg==
X-Gm-Message-State: AOJu0YzvFui7gcbHocR0IPl5qNKSm0QwA3Hb3QzFeU9fQRaZ/ZtNqWA6
	uaNX8P6bEbmnAqD06+DLGFvXrsEjGzVxsAt22GiqCGqYJUl3eCfTrP31k3fomXxY1XY6Xn2EUG9
	JiplHMXny/UYQm1tz5TzdeK8AWMd9IDP2UPV9DnmZpSdqu7FBleioo9Wy3QNT8A==
X-Received: by 2002:a5d:6d8b:0:b0:333:5d14:458 with SMTP id l11-20020a5d6d8b000000b003335d140458mr423153wrs.86.1701781417945;
        Tue, 05 Dec 2023 05:03:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwR8qKiFRJ5j68sXaNAqDWE0Tp4HRHbEcLXXEU+atj8b2+34QhgBeqXF3aGn1HiyAi3IIDFPuSYsBOfYT05HQ=
X-Received: by 2002:a5d:6d8b:0:b0:333:5d14:458 with SMTP id
 l11-20020a5d6d8b000000b003335d140458mr423146wrs.86.1701781417628; Tue, 05 Dec
 2023 05:03:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Tue, 5 Dec 2023 13:03:01 +0000
Message-ID: <CADWks+b06hpoBJpVdtd4HXdC0w24hObq0WOGCdfMGkpC7k=2vQ@mail.gmail.com>
Subject: Porting pahole from dwarf_next_unit() to dwarf_get_units()
To: dwarves@vger.kernel.org, elfutils-devel@sourceware.org
Cc: acme@kernel.org, mark@klomp.org
Content-Type: text/plain; charset="UTF-8"

Currently pahole warns and does nothing upon hitting
DW_TAG_skeleton_unit as implemented at
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf

In elfutils, a while back a new API got added that aids with discovery
and processing of such tags -
https://sourceware.org/git/?p=elfutils.git;a=commitdiff;h=79f0e623dcde4b042bb72f636a2211d67d5c0ade

It seems to me if pahole is ported from using dwarf_next_unit() to
instead use dwarf_get_units() native support can be added for
split-dwarf (dwo) files.

I am trying to write such a port, but it is proving to be very
difficult. I am entirely unfamiliar with neither pahole nor libdw nor
the dwarf file format. Thus it is very confusing when both pahole and
dwarf library use very similar type names and structs. For example
libdw has struct Dwarf_CU and pahole has unrelated dwarf_cu struct.

What are the differences between dwarf_nextcu(), dwarf_next_unit(),
dwarf_get_units() and when should one use each one of them? (or nest
them?)

Is a port of https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/dwarf_loader.c?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
to use dwarf_get_units() a right approach and would be welcomed?

Is anyone else interested in providing any help, or guidance?

-- 
Dimitri
