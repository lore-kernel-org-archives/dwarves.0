Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3AC433E6
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B141D23A5A
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 20:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbhAUUXi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:23:38 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:20202 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727182AbhAUUXT (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Jan 2021 15:23:19 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-4_XDGo4CMdyMym3QPv1B7A-1; Thu, 21 Jan 2021 15:22:21 -0500
X-MC-Unique: 4_XDGo4CMdyMym3QPv1B7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DF0259;
        Thu, 21 Jan 2021 20:22:19 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77D4B5D765;
        Thu, 21 Jan 2021 20:22:04 +0000 (UTC)
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
Subject: [PATCHv2 0/3] dwarves,libbpf: Add support to use optional extended section index table
Date:   Thu, 21 Jan 2021 21:22:00 +0100
Message-Id: <20210121202203.9346-1-jolsa@kernel.org>
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
kpatch guys hit an issue with pahole over their vmlinux, which
contains many (over 100000) sections, pahole crashes.

With so many sections, ELF is using extended section index table,
which is used to hold values for some of the indexes and extra
code is needed to retrieve them.

This patchset adds the support for pahole to properly read string
table index and symbol's section index, which are used in btf_encoder.

This patchset also adds support for libbpf to properly parse .BTF
section on such object.

This patchset is based on previously posted fix [1].

v2 changes:
  - many variables renames [Andrii]
  - use elf_getshdrstrndx() unconditionally [Andrii]
  - add elf_symtab__for_each_symbol_index macro [Andrii]
  - add more comments [Andrii]
  - verify that extended symtab section type is SHT_SYMTAB_SHNDX [Andrii]
  - fix Joe's crash in dwarves build, wrong sym.st_shndx assignment

thanks,
jirka


[1] https://lore.kernel.org/bpf/20210113102509.1338601-1-jolsa@kernel.org/
---
dwarves:

Jiri Olsa (2):
      elf_symtab: Add support for SHN_XINDEX index to elf_section_by_name
      bpf_encoder: Translate SHN_XINDEX in symbol's st_shndx values

 btf_encoder.c | 36 ++++++++++++++++++++++++++++++++----
 dutil.c       |  8 ++++++--
 elf_symtab.c  | 39 ++++++++++++++++++++++++++++++++++++++-
 elf_symtab.h  |  2 ++
 4 files changed, 78 insertions(+), 7 deletions(-)


libbpf:

Jiri Olsa (1):
      libbpf: Use string table index from index table if needed

 tools/lib/bpf/btf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

