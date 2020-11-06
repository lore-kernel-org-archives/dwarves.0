Return-Path: <SRS0=X0E1=EM=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A1EC2D0A3
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Nov 2020 22:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBEC20882
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Nov 2020 22:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604701527;
	bh=I73ZrT37HDnrjljWnll65t/Qsa2uBRE/Obd92cnS/0o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VgHxhyVlORcJ6a8551jq2gVc7OnD7JElIrbaUpjgMQVO0gNxRmtIhX/y8YnUdJsaY
	 bJsjXjW1fL7EIbvXLstJIlTAAqIwP9p76iftACbE/MAyZBGQ8PYLTnZN2kbUh2gnrt
	 iINPmVA3K4GjJxQF+oCs/TFHE7RsPEGBZn/0fLr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgKFWZ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:25:26 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:46718 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbgKFWZ0 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 6 Nov 2020 17:25:26 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-Q_SoPDJHOBqUc9-tpeBnnQ-1; Fri, 06 Nov 2020 17:25:22 -0500
X-MC-Unique: Q_SoPDJHOBqUc9-tpeBnnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 832B080364C;
        Fri,  6 Nov 2020 22:25:19 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 133BE5578B;
        Fri,  6 Nov 2020 22:25:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCHv4 0/3] pahole/kernel: Workaround dwarf bug for function encoding
Date:   Fri,  6 Nov 2020 23:25:09 +0100
Message-Id: <20201106222512.52454-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

hi,
because of gcc bug [1] we can no longer rely on DW_AT_declaration
attribute to filter out declarations and end up with just
one copy of the function in the BTF data.

It seems this bug is not easy to fix, but regardless if the
it's coming soon, it's probably good idea not to depend so
much only on dwarf data and make some extra checks.

Thus for function encoding we are now doing following checks:
  - argument names are defined for the function
  - there's symbol and address defined for the function
  - function address belongs to ftrace locations (new in v2)
  - function is generated only once

v4 changes:
  - added acks
  - renames and change functions_valid to be local var [Andrii]
  - fixed error path (return err) of collect_symbols

v3 changes:
  - added Hao's ack for patch 1
  - fixed realloc memory leak [Andrii]
  - fixed addrs_cmp function [Andrii]
  - removed SET_SYMBOL macro [Andrii]
  - fixed the 'valid' function logic
  - added .init.bpf.preserve_type check
  - added iterator functions to new kernel section
    .init.bpf.preserve_type [Yonghong]

v2 changes:
  - add check ensuring functions belong to ftrace's mcount
    locations, this way we ensure to have in BTF only
    functions available for ftrace - patch 2 changelog
    describes all details
  - use collect* function names [Andrii]
  - use conventional size increase in realloc [Andrii]
  - drop elf_sym__is_function check
  - drop patch 3, it's not needed, because we follow ftrace
    locations

thanks,
jirka


[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060

