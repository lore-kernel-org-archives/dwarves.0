Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662EF9C0
	for <dwarves@vger.kernel.org>; Sat, 21 Dec 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734750298; cv=none; b=cu1MurPgwp2kCzG2+f/3zW9qzJDX7+d6BMzl9GCi6hRExlN10JOfkr+OgnDw4vPpM3dOlZB7W1nrYMegc6ItsxKwHfCjze6rgSLu5jw2g29DTPx5JC05Mo+jdhJO64h0S/jW4F39rbnQMqNM5VFMuIEFgfs/iuu4zSMy5pxXiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734750298; c=relaxed/simple;
	bh=f7mxEJMuDZhJYYAZt04r8b9yaqQpGWnqJqfJ7129Bss=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o9C92gYtAb/bvmeFKt5rI1I4TN2jziA1GfFWMQ8+nQ1K0Saavm7B8KZPNozSBJM2K1+R1yIOC3Fn0gBMoK39jzwN73kablcJ1ECRKr4V1en3IXmrL2ZQQGvZgjjlWV/v4N6Nj8UsIxEPiHmfQefoTf4H/wlsgh4dLVY4OEPbfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=bfD6Mqrk; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="bfD6Mqrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734750294; x=1735009494;
	bh=KusglO7TLaKunfjZqFDKYN9++amcAH11/c3x7jHa4BY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=bfD6MqrkhTwOm8gTHARTJezVEKApk4yogeE3rri0t9CN+e4C+IacG+qRQWO91ya6S
	 X2dJIyVnjA4lZf7OroYrceUNZS6W+bhxDRfAEEZxczMEx6iU9lj7AN29tl+3YhyQcH
	 /ALEHBZzOHRf20WplCzJ6KC6b6uvpRoXHI3cO5OUWj+9SzUpAao65IGbIQU7ZKf0HF
	 5nWeEaW04vEPad53b6V/q97tkay2yRmBeF7j+IdDwSoT3PavNW5INkzG2fypMAEYO0
	 y2cPW7BDUwaI5kfczzRjAXZgkIXPRjCuh3HpXaWNOkNSABymUXp3iBIlhuHPQY8BRr
	 xwgO3SqBYfijw==
Date: Sat, 21 Dec 2024 03:04:50 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves] dwarves: set cu->obstack chunk size to 128Kb
Message-ID: <20241221030445.33907-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 0cb0b0036d1b71c54cf946a1a0251b1dc0221fbd
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In dwarf_loader with growing nr_jobs the wall-clock time of BTF
encoding starts worsening after a certain point [1].

While some overhead of additional threads is expected, it's not
supposed to be noticeable unless nr_jobs is set to an unreasonably big
value.

It turns out when there are "too many" threads decoding DWARF, they
start competing for memory allocation: significant number of cycles is
spent in osq_lock - in the depth of malloc called within
cu__zalloc. Which suggests that many threads are trying to allocate
memory at the same time.

See an example on a perf flamegraph for run with -j240 [2]. This is
12-core machine, so the effect is small. On machines with more cores
this problem is worse.

Increasing the chunk size of obstacks associated with CUs helps to
reduce the performance penalty caused by this race condition.

[1] https://lore.kernel.org/dwarves/C82bYTvJaV4bfT15o25EsBiUvFsj5eTlm17933H=
vva76CXjIcu3gvpaOCWPgeZ8g3cZ-RMa8Vp0y1o_QMR2LhPB-LEUYfZCGuCfR_HvkIP8=3D@pm.=
me/
[2] https://gist.github.com/theihor/926af22417a78605fec8d85e1338920e

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 dwarves.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dwarves.c b/dwarves.c
index 7c3e878..105f81a 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -722,6 +722,8 @@ int cu__fprintf_ptr_table_stats_csv(struct cu *cu, FILE=
 *fp)
 =09return printed;
 }
=20
+#define OBSTACK_CHUNK_SIZE (128*1024)
+
 struct cu *cu__new(const char *name, uint8_t addr_size,
 =09=09   const unsigned char *build_id, int build_id_len,
 =09=09   const char *filename, bool use_obstack)
@@ -733,7 +735,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
=20
 =09=09cu->use_obstack =3D use_obstack;
 =09=09if (cu->use_obstack)
-=09=09=09obstack_init(&cu->obstack);
+=09=09=09obstack_begin(&cu->obstack, OBSTACK_CHUNK_SIZE);
=20
 =09=09if (name =3D=3D NULL || filename =3D=3D NULL)
 =09=09=09goto out_free;
--=20
2.47.1


