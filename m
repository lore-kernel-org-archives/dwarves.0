Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70863C56201
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 22:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE8E2087C
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 22:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603751798;
	bh=YGTrKAvrKgvLKW2syXrqsjE1ZsaljoBhL+m6ildXhts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RSGCUOmMlkJZ1+RfHaslRNT9aGYQTUnXGMHePwMehZOaDRmWYZtFPWOV1MTKFkBnh
	 Ofr2W7E4mKnXK9eM25QN3CwsBSvKdFj7TtgYiGbdKidWujl70FaSx6FerZJdD0Lhu8
	 XAYgs6R9rYjr95w3w8wg3xvg6OV/CmsnKuvzLD7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394547AbgJZWgh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:36:37 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:50147 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390190AbgJZWgh (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 18:36:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-KcDETLriNFeTwvBQM1NVYg-1; Mon, 26 Oct 2020 18:36:32 -0400
X-MC-Unique: KcDETLriNFeTwvBQM1NVYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BD7D64089;
        Mon, 26 Oct 2020 22:36:31 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1689A6EF50;
        Mon, 26 Oct 2020 22:36:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCH 3/3] btf_encoder: Include static functions to BTF data
Date:   Mon, 26 Oct 2020 23:36:17 +0100
Message-Id: <20201026223617.2868431-4-jolsa@kernel.org>
In-Reply-To: <20201026223617.2868431-1-jolsa@kernel.org>
References: <20201026223617.2868431-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Removing the condition to skip static functions.

Getting extra 23k functions on my kernel .config:

           nr     .BTF size (bytes)
  before:  23291  3342279
   after:  46606  4361045

The BTF section size increased of about 1MB.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 99b9abe36993..03a4bef11947 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -485,9 +485,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		int btf_fnproto_id, btf_fn_id;
 		const char *name;
 
-		if (!fn->external)
-			continue;
-
 		/*
 		 * We need to generate just single BTF instance for the
 		 * function, while DWARF data contains multiple instances
-- 
2.26.2

