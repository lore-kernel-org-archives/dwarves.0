Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CDEC433FE
	for <linux-dwarves@archiver.kernel.org>; Thu, 29 Sep 2022 19:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiI2Td0 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiI2TdZ (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 29 Sep 2022 15:33:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC513571F
        for <dwarves@vger.kernel.org>; Thu, 29 Sep 2022 12:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A348B8267A
        for <dwarves@vger.kernel.org>; Thu, 29 Sep 2022 19:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DCEC433D6;
        Thu, 29 Sep 2022 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664480000;
        bh=Gqk6mkG07MRkaEibbAqYt/HrTW67QOd61oH6wR8xIkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9HdWQg/Q0Ta9SRyfuor7UzCFDIDJRjxrkloLcS8Kh3hW2KhKjwUAAVl6xGNxNB7W
         +cxRJnZjDTl6lsImGKVh2NassxV7aBc4iNzKmHF2afKD4rRBrC5lsDW2Ydpz8amAsV
         9kaY2spyWnTzmtWlXeog7TikoMmNxnQHLfFwHnGQHKPp/fWc6VxUpLf0WVxLbh3B5E
         /W0Uu0E97FxciOiyhktNculPX5nPPSmiNOGmWb05GpzF7eNSB39SLBxQADffVCYouj
         zQQib3bXpkS1VSDx2qBzO/ik97Hx63BBRwlWMVIxMTqqC0hsaH4XgBrChnbUa1N2b8
         TaTW1yvA0PbMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 329F84062C; Thu, 29 Sep 2022 16:33:17 -0300 (-03)
Date:   Thu, 29 Sep 2022 16:33:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>, Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dwarves@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: BTF: A fix and more work to do :Re: die__process_unit:
 DW_TAG_label (0xa) @ <0x7b> not handled!
Message-ID: <YzXy/birngORHLEd@kernel.org>
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
 <YzNKEhM+H/X0xUK3@kernel.org>
 <YzNWBxJTKDRBNNDa@dev-arch.thelio-3990X>
 <YzRPXVUfjcyQ4Utz@kernel.org>
 <YzRnfz0sVpX8CzeL@dev-arch.thelio-3990X>
 <YzWSzXKcm6rSWOC5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzWSzXKcm6rSWOC5@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Sep 29, 2022 at 09:42:53AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Sep 28, 2022 at 08:25:51AM -0700, Nathan Chancellor escreveu:
> > On Wed, Sep 28, 2022 at 10:42:53AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Can you please provide the vmlinux file where this takes place?
> > 
> > Sure thing, it is compressed to save some bandwidth while downloading:
> > 
> > https://1drv.ms/u/s!AsQNYeB-IEbqnnzsULjM1pXmOlI5?e=qHKjuW
> 
> So, fixed the case reported, DW_TAG_label outside a DW_TAG_lexblock, on
> asm DW_TAG_compile_unit DWARF containers, now I noticed that pahole
> suports encoding BTF_KIND_TAG (18) but not _decoding_ those, so off I go
> to work on it on btf_loader.c, looking at what btf_encoder.c does.
> 
> Good that you got me this vmlinux built by clang 15 :-)
> 
> Now we can BTF encode a vmlinux (-J) using all the CPUs in the system
> (-j), and then we end up with a kernel with BTF_KIND_TAG that can't be
> properly grokked by pahole when loading from BTF:
> 
> ⬢[acme@toolbox pahole]$ pahole -j -J vmlinux-pahole-warnings
> ⬢[acme@toolbox pahole]$ pahole -F btf vmlinux-pahole-warnings  > pahole-pretty-printed-from-btf
> BTF: idx: 277, Unknown kind 18
> BTF: idx: 281, Unknown kind 18
> BTF: idx: 331, Unknown kind 18
> BTF: idx: 689, Unknown kind 18
> BTF: idx: 692, Unknown kind 18
> 
> For instance:
> 
> ⬢[acme@toolbox pahole]$ pahole -C __sifields -F btf vmlinux-pahole-warnings
> BTF: idx: 277, Unknown kind 18
> BTF: idx: 281, Unknown kind 18
> BTF: idx: 331, Unknown kind 18
> BTF: idx: 689, Unknown kind 18
> <BIG SNIP>
> BTF: idx: 128403, Unknown kind 18
> BTF: idx: 128409, Unknown kind 18
> union __sifields {
> 	struct {
> 		__kernel_pid_t     _pid;               /*     0     4 */
> 		__kernel_uid32_t   _uid;               /*     4     4 */
> 	} _kill;                                       /*     0     8 */
> 	struct {
> 		__kernel_timer_t   _tid;               /*     0     4 */
> 		int                _overrun;           /*     4     4 */
> 		sigval_t           _sigval;            /*     8     8 */
> 		int                _sys_private;       /*    16     4 */
> 	} _timer;                                      /*     0    24 */
> 	struct {
> 		__kernel_pid_t     _pid;               /*     0     4 */
> 		__kernel_uid32_t   _uid;               /*     4     4 */
> 		sigval_t           _sigval;            /*     8     8 */
> 	} _rt;                                         /*     0    16 */
> 	struct {
> 		__kernel_pid_t     _pid;               /*     0     4 */
> 		__kernel_uid32_t   _uid;               /*     4     4 */
> 		int                _status;            /*     8     4 */
> 
> 		/* XXX 4 bytes hole, try to pack */
> 
> 		__kernel_clock_t   _utime;             /*    16     8 */
> 		__kernel_clock_t   _stime;             /*    24     8 */
> 	} _sigchld;                                    /*     0    32 */
> 	struct {
> 		<ERROR            > _addr;             /*     0     8 */

So this shares a type with several other fields/variables/whatever and
then:

 [  cb57]      member               abbrev: 6
               name                 (strx2) "sival_ptr"
               type                 (ref4) [  cb62]
               decl_file            (data1) siginfo.h (153)
               decl_line            (data1) 10
               data_member_location (data1) 0
 [  cb62]    pointer_type         abbrev: 80
 [  cb63]      lo_user+0x1f80       abbrev: 51
               name                 (strx1) "btf_type_tag"
               const_value          (strx1) "user"


This is with eu-readelf from elfutils, binutils readelf gets confused,
unsure about the equivalent for llvm, lets see:

llvm-dwarfdump gets:

0x0000cb57:     DW_TAG_member
                  DW_AT_name    ("sival_ptr")
                  DW_AT_type    (0x0000cb62 "void *")
                  DW_AT_decl_file       ("/home/nathan/cbl/src/linux/./include/uapi/asm-generic/siginfo.h")
                  DW_AT_decl_line       (10)
                  DW_AT_data_member_location    (0x00)

looks saner, a void pointer, probably with an attribute of btf_type_tag
(DW_TAG_llvm-something, IIRC):

0x0000cb62:   DW_TAG_pointer_type

0x0000cb63:     DW_TAG_LLVM_annotation
                  DW_AT_name    ("btf_type_tag")
                  DW_AT_const_value     ("user")

0x0000cb66:     NULL

None of these tools seem to be grokking this nicely, Yonghong?

⬢[acme@toolbox pahole]$ llvm-dwarfdump --version
LLVM (http://llvm.org/):
  LLVM version 14.0.0git
  Optimized build.
  Default target: x86_64-unknown-linux-gnu
  Host CPU: znver3
⬢[acme@toolbox pahole]$ cat /etc/fedora-release
Fedora release 36 (Thirty Six)
⬢[acme@toolbox pahole]$


I.e. sival_ptr is a:

typedef union sigval {
        int sival_int;
        void __user *sival_ptr;
} sigval_t;

So I would expect that sival_ptr pointed to a void * with an
intermediate DW_TAG_LLVM_annotation? What is the semantics? How all
these tools need to grok this?

- Arnaldo
