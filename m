Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C71C696
	for <dwarves@vger.kernel.org>; Mon, 26 Feb 2024 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934987; cv=none; b=kGihyDN8CtMQOSzJFDaC8mG1HQY++WdJxSpJuwuVpNA6zl+YgputgXBes/lZMmospQvVG6LvK9KLayL51+km9aMOHO9dWvXkTX+Dr7JV3fwZBbK3cUPs7KJgAncWzcnaJbjvgNM1ZLursd77cbGit7GVshgU+Nh9GRNstEXxSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934987; c=relaxed/simple;
	bh=zsvSxrfMhuZuIZUfwx8LClLSr4WC+V6TmYFB+ajGkPs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JWnqSr14Dddz2WsNwXivM5JUpznzVH/LiUXJ3yzeyJvACLFMW402VniGRaZKKdwzfMPTxqGbkTT5/ghQv0er6FVDzgjjhQeh9cSjhBYc7Mgp8OmMQfHP1LyZW+RfRZWPZy74t7m3x+wnn+xI5r0aS64KVR4ofOkwiA45h/eDN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG9MlAxF; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG9MlAxF"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68ffddd89d1so2135736d6.0
        for <dwarves@vger.kernel.org>; Mon, 26 Feb 2024 00:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708934985; x=1709539785; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wFJGbuu7sPx9Al86Gx6ZFS9hXmDyOkGwcAEZh+I22Ig=;
        b=VG9MlAxF7Vgg/8PGgCeOYrvgt4/p2cmuWvU90S0Dh0Gyn8ONb3s2MOfYpvFYovn/h3
         Kd0y1secWEeZ7Ej10FIEoFIYU4MLcy84VBNlTHJWi8hFug0W3ZmMsE0GfZ1ipxDxVWS5
         Q8Y/kXSjSD6djdR/PGlW1+hl67QEpQ0myqiIMIn7F3ea5Qkp0uj/pU18EmwzCmAU3zlX
         qVIndUH4ql9h/Y08cxwffbwzCAEZSSXmnhG6VDmYAILdNw8PiT+jhuoMnfRyXzBIDaJE
         t4crpIi/211Hfhw+wPyR29u1RFIjmosQ2SDmXJR4DsE2oEgT33XbE7za81WsRX7vbVWT
         Wwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708934985; x=1709539785;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFJGbuu7sPx9Al86Gx6ZFS9hXmDyOkGwcAEZh+I22Ig=;
        b=Ddccys/6yPu8g6ixx+N7vIBPh606TAyFg+ql49ss3dTNepGTL5aeBZH8wJ0fQogXZ1
         nBOXPOqkYgik54UtfxsH0nh48j5OegUZRerWKRTreYqw6+Wyr/iFB8fLSodH+pf4fKu9
         h/PEvYGyAduqiQRLXBdyCioL3KzaG5uuUCim3wP3s6WuOYU7P6voYoXN6oxPexsB6jYR
         oTu1NreAfKXahufuHU1LYh6YPiRGgac0uDKU7KazCMPTTlZAmjbBHaLdDTb/hwfGoHle
         ZAaa9VSsVlnsoS7a2CkApzW+w2sNXcdo6K1gfbxttFp0DtnC0WrRMLv5/KYRrkV30q1A
         19ng==
X-Gm-Message-State: AOJu0YyHErvZ7TtLi7Y8dE+V4fa4P+6GFiuJWNrs+WtClIK+dtoCJr+6
	NnO07WQjQBN9s7M+X6UJjsRwWypZuYr0AzwHmQZ7+NL4aowp5Y2IMyU+d3ob+ZLctxKfZpc1goc
	Z76A+5uVCg0xVwYrWgs59vHUKiTduzM57Uvc=
X-Google-Smtp-Source: AGHT+IFqskH78OO4mAjgzabeTU3USck4EFc8v4VMTRopoNe109DeIhK+wyu6y3rZH2IxhktRTR9W3kn0SNn5GjKJaxw=
X-Received: by 2002:a0c:ae8a:0:b0:68f:d52d:c7b with SMTP id
 j10-20020a0cae8a000000b0068fd52d0c7bmr7337295qvd.59.1708934985093; Mon, 26
 Feb 2024 00:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: J B <jb.1234abcd@gmail.com>
Date: Mon, 26 Feb 2024 09:09:34 +0100
Message-ID: <CAJXMFhFbv5MccigKvmQt9MhYwKv2iyigEG3Bhs64BZ=PMWc0WQ@mail.gmail.com>
Subject: pahole Version 1.25-4 dumps
To: dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

H,i
some random tests:

$ ls test.txt
/usr/bin/ls: cannot access 'test.txt': No such file or directory
$ syscse test.txt
Segmentation fault (core dumped)
$ coredumpctl info
       Signal: 11 (SEGV)
                Stack trace of thread 48074:
                #0  0x00007624fb32430b n/a (libdwarves.so.1 + 0x5b30b)
                #1  0x00007624fb30b2ff cus__load_file (libdwarves.so.1 + 0x422f>
                #2  0x00007624fb312af9 cus__load_files (libdwarves.so.1 + 0x49a>
                #3  0x000063ada590a093 main (syscse + 0x1093)
                #4  0x00007624fb10ccd0 n/a (libc.so.6 + 0x25cd0)
                #5  0x00007624fb10cd8a __libc_start_main (libc.so.6 + 0x25d8a)
                #6  0x000063ada590a165 _start (syscse + 0x1165)
                ELF object binary architecture: AMD x86-64
$ touch test.txt
$ syscse test.txt
Segmentation fault (core dumped)
$ <as above>
$ syscse /boot/vmlinuz-linux
Segmentation fault (core dumped)
$ <as above>

jb
