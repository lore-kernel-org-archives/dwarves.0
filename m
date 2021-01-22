Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B780DC10DC1
	for <linux-dwarves@archiver.kernel.org>; Fri, 22 Jan 2021 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9370C23ABA
	for <linux-dwarves@archiver.kernel.org>; Fri, 22 Jan 2021 17:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbhAVQs6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:48:58 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:34629 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728828AbhAVQlC (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 22 Jan 2021 11:41:02 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-N9qlE5usPrW3BIiYOoXJhw-1; Fri, 22 Jan 2021 11:39:36 -0500
X-MC-Unique: N9qlE5usPrW3BIiYOoXJhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 674FC107AD26;
        Fri, 22 Jan 2021 16:39:34 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C3855C5E0;
        Fri, 22 Jan 2021 16:39:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     dwarves@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCH 1/2] elf_symtab: Add support for SHN_XINDEX index to elf_section_by_name
Date:   Fri, 22 Jan 2021 17:39:19 +0100
Message-Id: <20210122163920.59177-2-jolsa@kernel.org>
In-Reply-To: <20210122163920.59177-1-jolsa@kernel.org>
References: <20210122163920.59177-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

In case the elf's header e_shstrndx contains SHN_XINDEX,
we need to call elf_getshdrstrndx to get the proper
string table index.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 dutil.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/dutil.c b/dutil.c
index 7b667647420f..11fb7202049c 100644
--- a/dutil.c
+++ b/dutil.c
@@ -179,12 +179,18 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 {
 	Elf_Scn *sec = NULL;
 	size_t cnt = 1;
+	size_t str_idx;
+
+	if (elf_getshdrstrndx(elf, &str_idx))
+		return NULL;
 
 	while ((sec = elf_nextscn(elf, sec)) != NULL) {
 		char *str;
 
 		gelf_getshdr(sec, shp);
-		str = elf_strptr(elf, ep->e_shstrndx, shp->sh_name);
+		str = elf_strptr(elf, str_idx, shp->sh_name);
+		if (!str)
+			return NULL;
 		if (!strcmp(name, str)) {
 			if (index)
 				*index = cnt;
-- 
2.26.2

