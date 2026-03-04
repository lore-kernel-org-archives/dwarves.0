Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB3358385
	for <dwarves@vger.kernel.org>; Wed,  4 Mar 2026 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593595; cv=pass; b=R0+WUljpY8jz/Kp1Cpy/KbLLyFbw0dxvgTbZSXEcM9gNwpXmbmP2thX2h03d2r6qD7qht9Tw1E4GeIbzplqfSbhb2muvn7JL+vP4+0LR9Bx9HeZElKeJp2GJOJQMQSaPJD2w+s0vLKwLFBD0y0egmLzvNiBrD2Y598LjdM/P4Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593595; c=relaxed/simple;
	bh=NI8qkBZxjWyDoWuhweUhNhnNGPodfdIkiJD6L1lY5Zo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dGgGTe7Rbf5s/mw1xS8ERxjQm+7EU9lNC3QvTcrvnvkQlQuK79mQr3YRvnkgh0L0P8eU7nSSgUTE1rsPi46BOKceZkAMoJO2d+ACpX68O30GvAmu0MpZtSmMBw959ORrHMYuY7LDbouLwCe7r+Htwv6vDTSpBUsgqJgtLcb3SH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz3R+4y+; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz3R+4y+"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64cb577e79cso6532462d50.0
        for <dwarves@vger.kernel.org>; Tue, 03 Mar 2026 19:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772593593; cv=none;
        d=google.com; s=arc-20240605;
        b=dXO84j+lP2IUkAV9aIfx7wXAt0t5/4Ifah3mELdISQZk6TZFecdCbEjF7twJFK15Ca
         xOCT4xvQxof+0Yau8kJi3MIOH2myH1qA+DqZ3E5cLDUlur3jVWkpD2Nb7T1ZkzfuOIWi
         O3rSuu4Tc0OVoObR+NMsW8CLrBpg+rdAcCRwARJDYHTkQVpMnYnqmijrAxV/ao3KOeWP
         pBKPCe9EjZ1xHIhUlWuVLf1anmOSblBLPzQY6FPufxGwihsntYThYsPvjUshMwqxe/cq
         AbxXYmdXbggygJPjFM6DFzwRglZbuFcMhxyGJNien3NNlguIs8zWK7EAEnBvjEjQxNzO
         QhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XpFaWz1aAmgEm/hyiWdomGIFA9K1JU/B8VZ8jgq2kAg=;
        fh=Ex8Gzi9l5Gspr/cHrlAuo8LwC0oUW7+CZIkbR+5dHrc=;
        b=ZgRnrkBkFuP5tajxIuLpm/+KBPPY69DcLSn5wMKq2cvForJzuiu6UwCzQUmU9v7CNj
         kpYdqt3TrBA7ZbKYa3pFKRK1OQMJPu/N3+sJdXsTVdyBNL3lIccxdQqclSC3ZcTHGan9
         t67sYbLzW+HDX/gDH/ODPgq31bEsSVfW8/4PSkQru02dVw9NJPRVklFDJqyZwoVEflvF
         POGPqzegRmwplBK+ASgv/Q9e3d7hOmwBcjI1Vw9M/tjNCxHT1m8kc+NQs95ZbhAFEzrC
         m9QVwL7SBN1NKxOZtpQa381tF2MdcLSeEkLWwt5nbyVlcuqsitsFia38ZM7GIPc8YQ8z
         llXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772593593; x=1773198393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XpFaWz1aAmgEm/hyiWdomGIFA9K1JU/B8VZ8jgq2kAg=;
        b=jz3R+4y++i6XPGEzW7bj5PRQF0Gvue150nKVtYidJrd1yCHqlLmujMSw1vOTv29U+k
         UXNCR9NkOso5GayMuKo/juHI4c1WOa14/hhR5iG3w+u+zXtjeshOkg+jzlHFgALirpQD
         H4/ht9VTlEeHb6Ka0mUXWkTkXUISHtHJY8eszNU9Zrs6AWVlF1tmjVw/VZK8TSYvCJc4
         oXtgb/rZ5w6YXUTkJf3jfKctT/kw7b7JILsKrAL3hAK6ctEnPW81J8mJHpqMhdSVStyA
         jNKv9HIHERmHFBJxNL4t5kuqgnvAGMrjv2kjssVssenQiDTigWCsmC3WAaplx/K8ymXA
         CoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772593593; x=1773198393;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpFaWz1aAmgEm/hyiWdomGIFA9K1JU/B8VZ8jgq2kAg=;
        b=HaYA3joI6L3f5evfr1WRUDE6Yyuk5j883XeupKfIBN0CHdXYG6MyDxHF5ba+xWAB2l
         cmS5URZz5h2EOrEEvmSGG97cCasuPdL60IJDqhUn/fulipgnZ/REDdwpP2LYT7DAX/qX
         RIv7NfOeNT8HbIsKotwDhnskldm3jskYchCoKQYaWictsQtTX2UlsMqsRXBtE4UIVJf+
         t1BMkEsFe2b039XFDCuwl42zL3TGLlSp9vDkSGmMaWDWzN0MB5ZJ2/qM0DvtRTjkQv1P
         XvBvL9h8ima2BQ4B5+Vm6mmNWIR5DiQjout5C9nivYcxrCwTtiw397wYN3J74Z9np16e
         AfxQ==
X-Gm-Message-State: AOJu0YyNuEBbc+J6JmcinpT2mP2QUeKvW/NX6aFNeQCxlE8i71yC146D
	IdlYGvvfSnPMrtnctIyXT4DkQrVoFjS7cftXcU2jLBseBUGkvSOFEzRlARgh412AuClqaaxkZSO
	xXI9tqj3SYOZQItvjcOe90coGnPM+zAM=
X-Gm-Gg: ATEYQzz6Zmtf1UlrDEkqC0kD7r4D2iAsSxa3vSVsySitQ0WaE3oHy5BgOC1jAAnquo2
	/FR1cudra+nUAtMJyVlwm6rLXWX6zs7rCUMTexH2R5o+CufoTnRusNUJGEuoDMBzDTCO948l4JZ
	nFkWz1dBLeYDTMbtv3Oing4I0HGKWmY7tU+JAqkilGUSZ+2+ysFqNKMXP8lC/0rz07XuSuHXc+T
	BZ9NJ/lZd+ehbgJ5Bkp9mepdg8vsSPFd5K3JgwEi0+mCqVgHe8YOiB0xHC7uCsFoZ2fNvraiP71
	SN/H6pt+tARnCHWrjFVreNvhQdyEjcbKZ+11PzQSxqnV8lOMFLc=
X-Received: by 2002:a53:ee55:0:b0:64c:a9dc:ce88 with SMTP id
 956f58d0204a3-64cfa054eb5mr492153d50.80.1772593593000; Tue, 03 Mar 2026
 19:06:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: damien hourtoulle <damien.hourtoulle@gmail.com>
Date: Wed, 4 Mar 2026 04:06:22 +0100
X-Gm-Features: AaiRm50Tn8KylhfH9N9s0dsZi4966w041zvauNuAkcQQ6Ds4P28hUL8JrrB1G24
Message-ID: <CALi0rFv2a-AjG2vaMV83yg2mDKeU1x6=tRJjWhw+DZd4w=AFsw@mail.gmail.com>
Subject: [PATCH] pahole: fix discarded-qualifiers for strchr/strstr
To: acme@redhat.com
Cc: dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From fa4866e368f5131ddcf6fddccc13203fab88d00d Mon Sep 17 00:00:00 2001
From: Damien Hourtoulle <damien.hourtoulle@gmail.com>
Date: Wed, 4 Mar 2026 03:30:31 +0100
Subject: [PATCH] pahole: fix discarded-qualifiers for strchr/strstr.

Glibc 2.43 added C23 const-preserving overloads :
https://sourceware.org/glibc/wiki/Release/2.43.

For the function prototype__new, fix local variable declaration to use
the correct const char* type instead of char*, removing the need to
discard
the const qualifier.

Signed-off-by: Damien Hourtoulle <damien.hourtoulle@gmail.com>
---
 btf_encoder.c |  2 +-
 pahole.c      | 19 +++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index aa7cd1c..d36984a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1218,7 +1218,7 @@ static bool str_contains_non_fn_suffix(const char *str) {
                ".cold",
                ".part"
        };
-       char *suffix = strchr(str, '.');
+       const char *suffix = strchr(str, '.');
        int i;

        if (!suffix)
diff --git a/pahole.c b/pahole.c
index 02a0d19..4184703 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2483,7 +2483,7 @@ static int64_t type_instance__int_value(struct
type_instance *instance, const ch
        int byte_offset = 0;

        if (!member) {
-               char *sep = strchr(member_name_orig, '.');
+               const char *sep = strchr(member_name_orig, '.');

                if (!sep)
                        return -1;
@@ -2496,8 +2496,8 @@ static int64_t type_instance__int_value(struct
type_instance *instance, const ch
                char *member_name = member_name_alloc;
                struct type *type = instance->type;

-               sep = member_name_alloc + (sep - member_name_orig);
-               *sep = 0;
+               char *sep_mutable = member_name_alloc + (sep -
member_name_orig);  // sep mutable for the copy
+               *sep_mutable = 0;

                while (1) {
                        member = type__find_member_by_name(type, member_name);
@@ -2510,7 +2510,7 @@ out_free_member_name:
                        type = tag__type(cu__type(cu, member->tag.type));
                        if (type == NULL)
                                goto out_free_member_name;
-                       member_name = sep + 1;
+                       member_name = sep_mutable + 1;
                        sep = strchr(member_name, '.');
                        if (!sep)
                                break;
@@ -2950,7 +2950,7 @@ static struct prototype *prototype__new(const
char *expression)

        strcpy(prototype->name, expression);

-       const char *name = prototype->name;
+       char *name = prototype->name;

        prototype->nr_args = 0;

@@ -2964,10 +2964,9 @@ static struct prototype *prototype__new(const
char *expression)
        if (args_close == NULL)
                goto out_no_closing_parens;

+       *args_open++ = *args_close = '\0';
        char *args = args_open;

-       *args++ = *args_close = '\0';
-
        while (isspace(*args))
                ++args;

@@ -3114,7 +3113,7 @@ static int type__find_type_enum(struct type
*type, struct cu *cu, const char *ty
                return type__add_type_enum(type, te, cu);

        // Now look at a 'virtual enum', i.e. the concatenation of
multiple enums
-       char *sep = strchr(type_enum, '+');
+       const char *sep = strchr(type_enum, '+');

        if (!sep)
                return -1;
@@ -3126,10 +3125,10 @@ static int type__find_type_enum(struct type
*type, struct cu *cu, const char *ty

        int ret = -1;

-       sep = type_enums + (sep - type_enum);
+       char *sep_mutable = type_enums + (sep - type_enum);

        type_enum = type_enums;
-       *sep = '\0';
+       *sep_mutable = '\0';

        while (1) {
                te = cu__find_enumeration_by_name(cu, type_enum, NULL);
-- 
2.53.0
