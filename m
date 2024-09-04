Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C21DC07B
	for <dwarves@vger.kernel.org>; Wed,  4 Sep 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468116; cv=none; b=C2EuYVRTwB9Oyo1a9Ald0K/Y08edp/8T7td1yV49ph9EP7GiHfnA3IEffVoLwv6IghRihV3UfKYAg6T/llA8CsbVIFOD4Dm6d2PuvivCLsdlDj9Ef5FDt5YlJH+/ELu8+VG9CZeMTcUbjmYd2PujZTt9jq1ixX7N6ZG2eelXWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468116; c=relaxed/simple;
	bh=IdqXE+OObA8xY9HQvTcv89ZkdjotwVkwmL9ex5EM55o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbcuDXEz9pnxq6K+SOS4JyQZNDfLeZWplh79sV/pgSHZjJ4xwDFYq28GG4BcDi5QuvTYH4K5HrdvsjE0BpwbhRcdwi0PoB+bWWZgTFPVAaRqFHwaYRP3AWKnBgOGgeV5gEG0VELxaWxd3ja8ZLq+pEg7SsmKB8i87CGh+sV+DTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=LzqExZ4S; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="LzqExZ4S"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39f4827a07aso18421295ab.1
        for <dwarves@vger.kernel.org>; Wed, 04 Sep 2024 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1725468113; x=1726072913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xEsvtZEMgE4lO7gsmLlKxe/sQGWpPyzc43ilyok8yM=;
        b=LzqExZ4SnJzTH6WlA5lH7iyUS4IpoWQJqfjhRy6JuOC3xkQMsoGVhcI7J7OLKut4z+
         NeW/OyXU0Gg8cVEngF4B+wLe+vMZzxVQ3shrKbFok9PqKvhm9n4YChGYUlRHi7X8oP3L
         bnnSqEMj4JHqSVP1s/8aYobZc+evtqc4/BKAcFlHXYYIeDh6pTQrpl6aZ6xDckF6CQg7
         Bmlfl0yUObvPDu0eKSxkxt66fgNoDLJ5A4D/sEIhTq08iL4IMzlQnJuAGh637QEKYICm
         oN85o+q+jipG5x+ZDe9CYaNuOSshanbUwGlJGDrdJCvf1VnvPEkWYk8jLfC2nQCH5lzZ
         tf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468113; x=1726072913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xEsvtZEMgE4lO7gsmLlKxe/sQGWpPyzc43ilyok8yM=;
        b=DgtlcMm9Zh7JLnIMCODsliTnkMHV2no06iXQUMBYsQeMdG7RtbzMl2Ec7K6EfoFgGu
         tgv+epmx2mMmtPh3j/uTPhMu9xB3VyVk52dtKZ+IVe3czgGLK7yGO9PLXUarUUABqFEJ
         /FQyjcRdBRvrdFSpnT85xp5fsthE3LYWmgjqjkRtqRFOpsOsEmztqHn9VWY5CVmtlVsY
         6GI4dbsCKf0G8mtD06992n0es4ibugqOiSO4Jh/8pXXu6Jh00g1/kSQ7D2ELpYa+abYN
         +AyjoyupleQqDRJJkrfg8hJBexn9x1nllaUxg6+cXyDMLkCN2e6+l3hBK2K+WwlYa/CG
         nMfw==
X-Gm-Message-State: AOJu0YwBbH7JmcjiYqgy45AkjuzpKKgvGn0T1bPyHalRWkyPwlMIezIL
	r4MDxjmFKk8RHE/r1LD6vHpSvgcil0vzbk9HQhWZOLumMg7wlaOqcXz2CA51Zt3r37sC460TqD/
	w
X-Google-Smtp-Source: AGHT+IGf7I+CERXHEju/Bp2okIgEQ/xGmQwLYtqWyMIn49JzOLeXk0g4sZ/fdu6j0DgIGsFKVKQisw==
X-Received: by 2002:a05:6e02:1fe6:b0:39d:3043:1f2f with SMTP id e9e14a558f8ab-39f4f697b3bmr181854325ab.14.1725468113217;
        Wed, 04 Sep 2024 09:41:53 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e17ba7sm3164954173.77.2024.09.04.09.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:41:52 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: dwarves@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 0/1] Handle printing pointer modifiers correctly
Date: Wed,  4 Sep 2024 12:41:44 -0400
Message-ID: <20240904164148.1735624-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As I said in previous messages, I have become a huge fan of pahole. I've
been working with it rather closely and noticed some, well, oddities in
how pointer modifiers are printed and wanted to help by attempting to
provide a fix. 

Assume that we have a C (named, say, modifier.c) with the contents:

struct S {
  volatile int * volatile W;
  const int * const X;
  const int * volatile Y;
  volatile int * const Z;
  int ** const A;
  int * const * B;
  int * volatile * C;
  const int * volatile * D;
};

struct S global_s;

int main() {
	return 0;
}

If we compile it with
gcc -gbtf -g -O0 -o modifier modifier.c

... we can ask what gdb thinks about the types:

$ gdb modifier
(gdb) ptype global_s
type = struct S {
    volatile int * volatile W;
    const int * const X;
    const int * volatile Y;
    volatile int * const Z;
    int ** const A;
    int * const *B;
    int * volatile *C;
    const int * volatile *D;
}

With pahole (compiled from master), we get the following output:
$ ../build/pahole -F btf --compile modifier
struct S {
	volatile volatile int  *   W;                    /*     0     8 */
	const const int  *         X;                    /*     8     8 */
	volatile const int  *      Y;                    /*    16     8 */
	const volatile int  *      Z;                    /*    24     8 */
	const int * *              A;                    /*    32     8 */
	int * const *              B;                    /*    40     8 */
	volatile int *  *          C;                    /*    48     8 */
	volatile const int  *  *   D;                    /*    56     8 */

	/* size: 64, cachelines: 1, members: 8 */
};

$ ../build/pahole -F dwarf --compile modifier
struct S {
	volatile volatile int  *   W;                    /*     0     8 */
	const const int  *         X;                    /*     8     8 */
	volatile const int  *      Y;                    /*    16     8 */
	const volatile int  *      Z;                    /*    24     8 */
	const int * *              A;                    /*    32     8 */
	int * const *              B;                    /*    40     8 */
	volatile int *  *          C;                    /*    48     8 */
	volatile const int  *  *   D;                    /*    56     8 */

	/* size: 64, cachelines: 1, members: 8 */
};

This is not quite right. With the fix (attached) applied, we instead get
output that looks arguably correct:

$ ../build/pahole -F btf --compile modifier
struct S {
	volatile int  * volatile   W;                    /*     0     8 */
	const int  * const         X;                    /*     8     8 */
	const int  * volatile      Y;                    /*    16     8 */
	volatile int  * const      Z;                    /*    24     8 */
	int * * const              A;                    /*    32     8 */
	int * const  *             B;                    /*    40     8 */
	int * volatile  *          C;                    /*    48     8 */
	const int  * volatile  *   D;                    /*    56     8 */

	/* size: 64, cachelines: 1, members: 8 */
};

$ ../build/pahole -F dwarf --compile modifierstruct S {
	volatile int  * volatile   W;                    /*     0     8 */
	const int  * const         X;                    /*     8     8 */
	const int  * volatile      Y;                    /*    16     8 */
	volatile int  * const      Z;                    /*    24     8 */
	int * * const              A;                    /*    32     8 */
	int * const  *             B;                    /*    40     8 */
	int * volatile  *          C;                    /*    48     8 */
	const int  * volatile  *   D;                    /*    56     8 */

	/* size: 64, cachelines: 1, members: 8 */
};

I hope that this is helpful.

If the patch is useful but needs changes, please let me know! I would be
glad to make any changes to fit the codebase.

Thank you for all that you do to keep pahole going!

Will


Will Hawkins (1):
  dwarves_fprintf: Handle pointer modifiers correctly

 dwarves_fprintf.c | 57 ++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

-- 
2.45.2

