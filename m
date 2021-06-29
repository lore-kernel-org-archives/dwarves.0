Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288EBC11F66
	for <linux-dwarves@archiver.kernel.org>; Tue, 29 Jun 2021 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0358261DC2
	for <linux-dwarves@archiver.kernel.org>; Tue, 29 Jun 2021 08:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhF2IQA (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhF2IP7 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 29 Jun 2021 04:15:59 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38608C061574
        for <dwarves@vger.kernel.org>; Tue, 29 Jun 2021 01:13:33 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id k184so16206948ybf.12
        for <dwarves@vger.kernel.org>; Tue, 29 Jun 2021 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HSRkwcfpxM1IZpmCbQHGkcLOYXhFHTSaRUmoqTURhyk=;
        b=FSN/GihMSrMt2wuccpI75xOKIdmM3okwZIujQujERo2K8MCGafTp7K1iZfkB1mP/KW
         jBlw9hMxio00lXjI6a2hzeTNGPWgSzWnuT6IM4ANXBJwDgvjBFDE7ebQA2/6t494TXL5
         67erkoDJx2aeAG8AuLn9I+ay3A/YlLKnO8Oz4BCXXcqug7v2YJO3ZPp7y3BWkh3t7mGN
         eHGJVUYjjmyFYeSZ3JOjAD40nn5mJsvZQ02x7oCwc5Bf9pASEPMBmyRf6nY16YHRFV4x
         ZLB+gvBXebEmRxlX2qCroaolr6wf2ogpbspvVug4wNFodV0xRyb0mhmfofDxXjyzDcIE
         9X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HSRkwcfpxM1IZpmCbQHGkcLOYXhFHTSaRUmoqTURhyk=;
        b=hEKhTHJNNQboABi7jzAtzddzPBjCeOb7cGJRm+oowP5f6JaXwFLZVD3yvKt0Digrlq
         5NIvBqCgor8qx18Lv8JKlnTmHf7CHjayOTMxSbXn6b2QTwDxLG2A76Dvbq3hTrpRah+G
         GzSbxbYWmwTx6LOOaO1Meuuj6Nas6HOyhNKBgRVmnZDHTss0yCVTbDPhmhQv0s0gb67A
         lewgk0LFMf310AEG0vI/Mqo/2zK8PLzYgQhqnGQami/tyFsSqHB5fJgTEK6eO2ybmbxG
         2TiLfSof3zn9fFGWK+oGmhHPXrFf7Ltkz50w46wkccsX8YDEqgsSKIe7DHA0yuCHbMgu
         hKVg==
X-Gm-Message-State: AOAM531OeYPxi5d7cJmNCtPv0NRyNjrofkS9dJaMIbtX+ojR/0VtkgPW
        vW8CxLpzNvRq3UPwn4UDum/jhcvucNZgOYVxy7Ym7M0yZpE=
X-Google-Smtp-Source: ABdhPJwsbXAfU1Siq35ZGnJjCPTJHsLRcfIArX9Xwax/4UlSLVVAP0dblY8foDaQnQ4qAZzaPenCkWrpqJ1q3wbz0kM=
X-Received: by 2002:a25:b2a7:: with SMTP id k39mr9379631ybj.146.1624954412408;
 Tue, 29 Jun 2021 01:13:32 -0700 (PDT)
MIME-Version: 1.0
From:   Bernd Buschinski <b.buschinski@googlemail.com>
Date:   Tue, 29 Jun 2021 10:13:38 +0200
Message-ID: <CACN-hLVoz2tWrtgDLabOv6S1-H_8RD2fh8SV6EnADF1ikMxrmw@mail.gmail.com>
Subject: pahole vs isatty
To:     dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hello,

I am using pahole 1.21 and I recently noticed that I no longer have
any pahole output in several scripts.


Using (on the command line):

$ pahole -V -E -C my_struct /path/to/my/debug.o

works fine and gives the expected output.


But

$ parallel -j 1 pahole -V -E -C my_struct ::: /path/to/my/debug.o

gives nothing, no stderr, no stdout and ret code 0.

After testing some versions, it works fine in 1.17 and no longer works in 1.18.

-> Git Bisect
$ git bisect start
$ git bisect good v1.17
$ git bisect bad v1.18
Bisecting: 54 revisions left to test after this (roughly 6 steps)
[0a97d6c143fcc92a335e532a991e1e1c62c9bd3e] pahole: Factor out parsing
class prototypes
$ git bisect bad
Bisecting: 26 revisions left to test after this (roughly 5 steps)
[a5bb31b86fbe53624165ecdf1bd18a19ac224b7c] pahole: Fix --skip for
variable sized records
$ git bisect bad
Bisecting: 13 revisions left to test after this (roughly 4 steps)
[fe284221448c950d2ba17bce91d19c484d6580a0] pahole: Introduce --seek_bytes
$ git bisect bad
Bisecting: 6 revisions left to test after this (roughly 3 steps)
[a231d00f8d08825ea1c9937cf5c932883ad28ecc] pahole: Print comma at the
end of field name + field value
$ git bisect bad
Bisecting: 2 revisions left to test after this (roughly 2 steps)
[cc65946e3068f7b68a0aa437261c748c20445986] dwarves: Adopt
tag__is_base_type() from ctrace.c
$ git bisect bad
Bisecting: 0 revisions left to test after this (roughly 1 step)
[d8079c6d373a5754164ecd784844ce2622d782b8] pahole: Hex dump a type
from stdio when it isn't a tty
$ git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[38109ab45fe0307dd21b96a866c1f9b62df64fd4] spec: Fix date
$ git bisect good
d8079c6d373a5754164ecd784844ce2622d782b8 is the first bad commit
commit d8079c6d373a5754164ecd784844ce2622d782b8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Jun 24 09:08:17 2020 -0300

    pahole: Hex dump a type from stdio when it isn't a tty

    For now the only aspect of the type that is considered is its size, so
    one line each sizeof(type) will be hex dumped, e.g.:

      $ objcopy -O binary --only-section=.altinstructions
~/git/build/v5.7-rc2+/vmlinux .altinstructions
      $ ls -la .altinstructions
      -rwxrwxr-x. 1 acme acme 18551 Jun 24 09:09 .altinstructions
      $ pahole -C alt_instr ~/git/build/v5.7-rc2+/vmlinux
      struct alt_instr {
            s32                        instr_offset;         /*     0     4 */
            s32                        repl_offset;          /*     4     4 */
            u16                        cpuid;                /*     8     2 */
            u8                         instrlen;             /*    10     1 */
            u8                         replacementlen;       /*    11     1 */
            u8                         padlen;               /*    12     1 */

            /* size: 13, cachelines: 1, members: 6 */
            /* last cacheline: 13 bytes */
      } __attribute__((__packed__));
      $ pahole -C alt_instr ~/git/build/v5.7-rc2+/vmlinux <
.altinstructions  | head
      0x90 0xe6 0xe0 0xff 0x73 0x48 0x00 0x00 0x70 0x00 0x05 0x05 0x00,
      0x83 0xe6 0xe0 0xff 0x6b 0x48 0x00 0x00 0x29 0x01 0x05 0x05 0x00,
      0x2a 0x72 0xc5 0xfe 0x63 0x48 0x00 0x00 0xeb 0x00 0x02 0x00 0x00,
      0x22 0x72 0xc5 0xfe 0x56 0x48 0x00 0x00 0x91 0x00 0x05 0x05 0x05,
      0x0c 0x73 0xc5 0xfe 0x4e 0x48 0x00 0x00 0xeb 0x00 0x02 0x00 0x00,
      0x04 0x73 0xc5 0xfe 0x41 0x48 0x00 0x00 0x91 0x00 0x02 0x00 0x00,
      0x72 0x73 0xc5 0xfe 0x34 0x48 0x00 0x00 0xf3 0x00 0x2b 0x2b 0x29,
      0xca 0x73 0xc5 0xfe 0x52 0x48 0x00 0x00 0xec 0x00 0x18 0x18 0x16,
      0xbd 0x73 0xc5 0xfe 0x5d 0x48 0x00 0x00 0xed 0x00 0x18 0x05 0x16,
      0xd3 0x7a 0xc5 0xfe 0x55 0x48 0x00 0x00 0x34 0x01 0x03 0x03 0x03,
      $

    Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 pahole.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)



It seems the output is now only available if it is a real tty, which
doesn't work for my scripts.
So, just as a question: Is this change really intentional?
Is there any easy way to restore the old behavior?

FYI: my scripts are using perl and python, I do no really favor
changing them, but if there is no other way.. I will do it :)

-- Bernd
