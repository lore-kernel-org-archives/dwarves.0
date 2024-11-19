Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C1199FDD
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732053905; cv=none; b=W5MLunPXXAyb5Wo12uv2wtbt1QhhpN29SjWUSEH7nk+FmjiKQRDt940EtMBiis8kh4C/YnomFBw2TTxFFS4yei3q2gcLz7syBMFPNUtLQdpoSN7FDEG+7DcHWhS3LfbiUWjV1ZqFsKVf24f7a+FJnjA8XRwe1SsTifH1286iRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732053905; c=relaxed/simple;
	bh=bEQSOhSW43jzahuLF6QhZZgW1HCQMyIiTOa8NXtsNGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p/640cHskrwTB8BCFsjoFdsJIz0Ny5uuItUVycRuXB7VflGUi0MI7CLFFp3dt1e2ycaPMwYuuyJvdjx7kgQbFyftjRwrjE9sT0eH5kjqWmB9hujJIUtiwVOjeaIPSj7doHUHXEjdqpO5rmNSPuk9qKZ1YxZmrwrWGowhM5xh54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA7sZxhE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA7sZxhE"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7248c1849bdso3264826b3a.3
        for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 14:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732053904; x=1732658704; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BkrfN/8rKpLBnt7/ut16AtqQsJcgzNhlTUtG22RGASE=;
        b=ZA7sZxhEcdpStUhz9kM6ilz8DqLUKig+2HwCx3VCwLwxPYQJ3rAGQQ4Cu2vzdt9Y85
         4Pqdv8orp0/PvviBj8F7Zv/kcLX9C69amoz9x9tpH3UBATctCYMd7Gtwbod8907Jk3nG
         yHHJnXAr7LGmzNdfBUhdn9qmoizPNBmtKfshtVCmIBEtyk5jKXPIxLtcUFvg7sy5PqNq
         pTJChYyLCTXn8YackzxV7mH1N6DN4/siR8RnuRVDMdy5YYTRViLwE7LsBn/G/ioyK0QI
         TUKsFTfMm0gcV3rEhmlJaqeLB5LwLFig17UKhR3YDtnkpVUqivhhfwPXpQMaJeT8ng50
         i0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732053904; x=1732658704;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkrfN/8rKpLBnt7/ut16AtqQsJcgzNhlTUtG22RGASE=;
        b=Dnhy+iZVnGunN8ZbuoTS2tJ2Q/jHl7y5wnlGl3DW5KTprBPGhi6gtF5y9H1WrKglq8
         WS1OTgpaJSTrPlCJQA8zAawwnf2stup8MLt1ji2wQ/U/gUuuYNx18NGzYwsV8etlKcmw
         0C8KP0crJmDcXsuYoB0GrsTOU9JNZdyoHvKNqoI3B/wgBSiLBKdVMl2KsNA1kjMrwz8E
         +iWlyvd7jr5YPZU8u7Dyf/U+eSSJLoVS/lG9xMP5qLjsK3mmuUcaTfoeO1XYbLhiSs5d
         ms4E7DyookPqUwoXoG+9n0Y5T2i7K6o7RarSWU8gVQ+v81s7vecPMoxtGS95AS9Pqcq+
         3rwg==
X-Forwarded-Encrypted: i=1; AJvYcCUV2VXb2cpqIEYBu96AituluXYOGbfAf47iIuTvUytx8XVNr8kdKEhJJCcC3R25MpJj7qJzGTFO@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGfB7FyKBVbJ3fZ4xXxgJ5B+At5XzX/y2xgjl1++cu1moZeN9
	Ajet8xu2uiHcsKfkYrQW4HoGhZ0B8YtODkdyeQu3+lzO5xYBQjBd
X-Google-Smtp-Source: AGHT+IEXYMmHxoPDhXDfmyMQgBkx+jNcg4Qz6S6ZMDB0IrljVGhmwbjqzqCOybZmMPxMv3pKAtjHig==
X-Received: by 2002:a05:6a00:a8a:b0:724:63e7:209f with SMTP id d2e1a72fcca58-724bec87604mr869292b3a.2.1732053903572;
        Tue, 19 Nov 2024 14:05:03 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beefe891sm186124b3a.65.2024.11.19.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:05:03 -0800 (PST)
Message-ID: <a1366bfad38306b2e7e41549ba1ac2ed217b94ff.camel@gmail.com>
Subject: Re: [PATCH 3/5] pahole: Honour exclusive BTF loading
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alan Maguire
	 <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate
 Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org, Arnaldo Carvalho de
 Melo <acme@redhat.com>,  Matthias Schwarzott <zzam@gentoo.org>, Andrii
 Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>
Date: Tue, 19 Nov 2024 14:04:58 -0800
In-Reply-To: <20241119134032.783215-4-acme@kernel.org>
References: <20241119134032.783215-1-acme@kernel.org>
	 <20241119134032.783215-4-acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-19 at 10:40 -0300, Arnaldo Carvalho de Melo wrote:

[...]

I tried the following test on top of this patch-set:

----- 8< ----------------------------------------
#!/bin/bash

cat <<EOF | clang -o btf-and-dwarf.o -c -x c -g - || exit 1
struct test_val { int i; } g;
EOF
pahole --btf_encode btf-and-dwarf.o || exit 1
# Note: has to be llvm-strip, otherwise --no-strip-all is not available
llvm-strip -o only-dwarf.o    --no-strip-all -R .BTF -R .BTF.ext	btf-and-dw=
arf.o
llvm-strip -o only-btf.o      --no-strip-all --strip-debug 		btf-and-dwarf.=
o

for fmt in none btf dwarf dwarf,btf; do
    for file in no-such-file only-btf.o only-dwarf.o btf-and-dwarf.o; do
        if [ "$fmt" =3D=3D "none" ]; then
            cmd=3D"pahole"
        else
            cmd=3D"pahole -F ${fmt}"
        fi
        printf -- "------ PAHOLE_VMLINUX_BTF_FILENAME=3D%-20s %-20s ------\=
n" "${file}" "${cmd}"
        PAHOLE_VMLINUX_BTF_FILENAME=3D$file $cmd 2>&1 | grep -P '(test_val|=
pahole:)'
    done
done
---------------------------------------- >8 -----

And there are a few surprising (to me) results, namely:

------ PAHOLE_VMLINUX_BTF_FILENAME=3Donly-dwarf.o         pahole           =
    ------
pahole: couldn't find any debug information on this system.
...
------ PAHOLE_VMLINUX_BTF_FILENAME=3Donly-dwarf.o         pahole -F dwarf  =
    ------
pahole: couldn't find any debug information on this system.
...
------ PAHOLE_VMLINUX_BTF_FILENAME=3Dbtf-and-dwarf.o      pahole -F dwarf  =
    ------
pahole: couldn't find any debug information on this system.
...
------ PAHOLE_VMLINUX_BTF_FILENAME=3Donly-dwarf.o         pahole -F dwarf,b=
tf  ------
pahole: couldn't find any debug information on this system.
...

It looks like DWARF is never loaded.
llvm-dwarfdump shows that DWARF is indeed present in only-dwarf.o and
btf-and-dwarf.o. Is this an expected behaviour?


