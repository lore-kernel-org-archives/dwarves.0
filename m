Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E799FC433F5
	for <linux-dwarves@archiver.kernel.org>; Wed,  5 Oct 2022 14:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJEOhT (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJEOhS (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 5 Oct 2022 10:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA48481ED
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 07:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B3A66171A
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 14:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B342C433D6;
        Wed,  5 Oct 2022 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664980636;
        bh=U61fBKZoo64I2JOJBpuIgynw3GeJns4T+QKA3ReFKhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzqN0V7b6bn5BVFPXgBpCuI0ih0SnAzOPzPKKU8gO2zWhYXFlVtIfsBbaSNPaTPkn
         HAXcfjY0tGl4OwE590JRXTyntt3HpvQUFfj689mOYv2l01MICjCorUjbmXb1e2eXOD
         I2nkGdsQTdGKxnW2DhkllM60Ym+D4TNrrYYtkuZ0CZ9fUzjbuYmRS+X7cCDriPO+2C
         ecA6K6LpZ1YSqkcU/Agxu/TTkAr673PI+4kk2Y1y36QO7+aZ9113a8u77PvRhw7LYf
         Na/iGpD4YYknlpEwKT7W1X5fTzWDE7HMcAVYZIGF9Fyuz2uLz7nyzjwi6yskY4826g
         O2BBh3vnnljzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1AEC4062C; Wed,  5 Oct 2022 11:37:13 -0300 (-03)
Date:   Wed, 5 Oct 2022 11:37:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Yz2Wmd0WgiwmPglm@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzypIDbTomaZOPOY@kernel.org>
 <a57a66b1-9457-a84f-6f66-9695aab01b1a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a57a66b1-9457-a84f-6f66-9695aab01b1a@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Oct 05, 2022 at 09:23:32AM +0200, Martin Liška escreveu:
> On 10/4/22 23:44, Arnaldo Carvalho de Melo wrote:
> > I assume "binutils master" means:
> > 
> > git://sourceware.org/git/binutils-gdb.git master?
> 
> Yes.

Taking notes:

Using what is in opensuse:tumbleweed it works:

15e20ce2324a:~/git/linux # ls -la ../build/v6.0.0+/vmlinux
-rwxr-xr-x. 1 root root 674990096 Oct  5 14:30 ../build/v6.0.0+/vmlinux
15e20ce2324a:~/git/linux # pahole ../build/v6.0.0+/vmlinux > /dev/null
15e20ce2324a:~/git/linux # time pahole ../build/v6.0.0+/vmlinux > /dev/null

real	0m5.155s
user	0m4.518s
sys	0m0.608s
15e20ce2324a:~/git/linux # time pahole -F dwarf ../build/v6.0.0+/vmlinux > /dev/null

real	0m5.184s
user	0m4.504s
sys	0m0.662s
15e20ce2324a:~/git/linux # time pahole -F btf ../build/v6.0.0+/vmlinux > /dev/null

real	0m0.077s
user	0m0.057s
sys	0m0.020s
15e20ce2324a:~/git/linux # btfdiff ../build/v6.0.0+/vmlinux
15e20ce2324a:~/git/linux # pahole -F btf -C spinlock_t ../build/v6.0.0+/vmlinux > /dev/null
15e20ce2324a:~/git/linux # pahole -F btf -C spinlock_t ../build/v6.0.0+/vmlinux
typedef struct spinlock spinlock_t;
15e20ce2324a:~/git/linux # pahole -EF btf -C spinlock_t ../build/v6.0.0+/vmlinux
typedef struct spinlock spinlock_t;
15e20ce2324a:~/git/linux # pahole -F btf -C spinlock ../build/v6.0.0+/vmlinux
struct spinlock {
	union {
		struct raw_spinlock rlock;               /*     0     4 */
	};                                               /*     0     4 */

	/* size: 4, cachelines: 1, members: 1 */
	/* last cacheline: 4 bytes */
};
15e20ce2324a:~/git/linux # pahole -EF btf -C spinlock ../build/v6.0.0+/vmlinux
struct spinlock {
	union {
		struct raw_spinlock {
			/* typedef arch_spinlock_t */ struct qspinlock {
				union {
					/* typedef atomic_t */ struct {
						int            counter;                  /*     0     4 */
					} val; /*     0     4 */
					struct {
						/* typedef u8 -> __u8 */ unsigned char  locked; /*     0     1 */
						/* typedef u8 -> __u8 */ unsigned char  pending; /*     1     1 */
					};                                               /*     0     2 */
					struct {
						/* typedef u16 -> __u16 */ short unsigned int locked_pending; /*     0     2 */
						/* typedef u16 -> __u16 */ short unsigned int tail; /*     2     2 */
					};                                               /*     0     4 */
				};                                                       /*     0     4 */
			} raw_lock; /*     0     4 */
		} rlock; /*     0     4 */
	};                                                                               /*     0     4 */

	/* size: 4, cachelines: 1, members: 1 */
	/* last cacheline: 4 bytes */
};
15e20ce2324a:~/git/linux # pahole --version
v1.22
15e20ce2324a:~/git/linux #
15e20ce2324a:~/git/linux # rpm -q binutils
binutils-2.38-6.2.x86_64
15e20ce2324a:~/git/linux #

Now to update binutils.

- Arnaldo
