Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA8C433B4
	for <linux-dwarves@archiver.kernel.org>; Tue,  6 Apr 2021 18:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5871A613B8
	for <linux-dwarves@archiver.kernel.org>; Tue,  6 Apr 2021 18:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbhDFSks (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbhDFSja (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 6 Apr 2021 14:39:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DAAC06174A
        for <dwarves@vger.kernel.org>; Tue,  6 Apr 2021 11:39:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w28so24278382lfn.2
        for <dwarves@vger.kernel.org>; Tue, 06 Apr 2021 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQMr+myNry7kMYJRVZWeSVgVa7oM6pbfeSZSl/6u29k=;
        b=Pejc/BsA8L+TrZPdOwGHEPycuL6xNz5a8xRww8TuUSCgKj81lbNaCMvZ5AezmAQOo3
         iHffyxnvTmFH7xH1zeco1pel6rsL9/SLE7+vYfV8Q2byaIXSP/WyDIdz4/JhkoV6E8ao
         C196PK+sW2SGOEDgD4CihqKsl+i2l6NvINN+hzneYJZhSlabo9suuKlOcZ/teKY+epXk
         kIrWCtpa0jSvxVILeR85ZnCyHpvG4AZhXKnFjw+GO3gN/C1spLIA7WFl6kUWAMxToRRh
         SaeHhHZntayiEUo9dRoaT4nPrF2Hy/fyJdSa6aJCTo3TUuTtNphN9MjO2NCNY3GDLRf8
         vZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQMr+myNry7kMYJRVZWeSVgVa7oM6pbfeSZSl/6u29k=;
        b=jUaWtobJJ37+sybOxQ0bryKwljUiHUOJpb8JoE8dEm+TEKp4CUGUlymE7s7EE1eSO3
         KFExXagIx/pxdtBjvX6GTCNPwuJbuYOha0LnLe+YZDGvRihurXr1WxHrZ1eSpdZzOXNm
         v+Ss6a1/0H8kNmXC8OQstPJK1kVpjw4P6cXpd3iGjRl+A8WQ4JcLEJ4VCSsUna48bH4x
         tgkfSh+jRPmmMl8r/9/eGu6WfMA34c8DrYhI92HjwqrK28j/2mPdKftfUuqP9tB3EOHH
         eefrmaBNoJlsCwfu2pgNh0Ram4QWOOAQZgrz+Dg04BdQGJtD4KeXxzCFSB8LAsflirUF
         OnCw==
X-Gm-Message-State: AOAM533eX3tOoVZZL8TkXGO6mK7xGEHW8EX3Kzp8z5JCrrzWtXKJOxI7
        QkllWY1FSqNJboeBflGMuQOpfXKV8Ydi97yvtTDOXw==
X-Google-Smtp-Source: ABdhPJwfF8QTg6t910CMAqJ9lPp1gWVxBDXydZblUn3PzjSJ4R76U4j8NWJdIQODLYvQGTNNGH20bVl5J4NuLLVRId0=
X-Received: by 2002:a19:8c19:: with SMTP id o25mr22129544lfd.547.1617734360307;
 Tue, 06 Apr 2021 11:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <CA+icZUVxpkCJVnibqm3+OYdfdh5U=eU_u7pPKUZMoPm3XzZWPQ@mail.gmail.com>
In-Reply-To: <CA+icZUVxpkCJVnibqm3+OYdfdh5U=eU_u7pPKUZMoPm3XzZWPQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Apr 2021 11:39:09 -0700
Message-ID: <CAKwvOdn+ScOD=LyU+4CxL6AOpfjXuzzQD-=TuM9ER-Q8Wposuw@mail.gmail.com>
Subject: Re: Usage of CXX in tools directory
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, kernel-team@fb.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Sun, Apr 4, 2021 at 8:00 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> [ Please CC me I am not subscribed to all mailing-lists ]
> [ Please CC some more folks if you like ]
>
> Hi,
>
> when dealing/experimenting with BPF together with pahole/dwarves and
> dwarf-v5 and clang-lto I fell over that there is usage of CXX in tools
> directory.
> Especially,  I wanted to build and run test_progs from BPF selftests.
> One BPF selftest called "test_cpp" used GNU/g++ (and even /usr/bin/ld)
> and NOT LLVM/clang++.
>
> For details see the linux-bpf/dwarves thread "[PATCH dwarves]
> dwarf_loader: handle DWARF5 DW_OP_addrx properly" in [1].
>
> Lemme check:
>
> $ git grep CXX tools/
> tools/build/Build.include:cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@
> $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXXFLAGS_$(basetarget).o)
> $(CXXFLAGS_$(obj))
> tools/build/Makefile.build:quiet_cmd_cxx_o_c = CXX      $@
> tools/build/Makefile.build:      cmd_cxx_o_c = $(CXX) $(cxx_flags) -c -o $@ $<
> tools/build/Makefile.feature:  feature-$(1) := $(shell $(MAKE)
> OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)"
> CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))"
> CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))"
> LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir)
> $(OUTPUT_FEATURES)test-$1.bin >/dev/nu
> ll 2>/dev/null && echo 1 || echo 0)
> tools/build/feature/Makefile:__BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall
> -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
> ...
> tools/perf/Makefile.config:USE_CXX = 0
> tools/perf/Makefile.config:        CXXFLAGS +=
> -DHAVE_LIBCLANGLLVM_SUPPORT -I$(shell $(LLVM_CONFIG) --includedir)
> tools/perf/Makefile.config:        $(call detected,CONFIG_CXX)
> tools/perf/Makefile.config:     USE_CXX = 1
> tools/perf/Makefile.perf:export srctree OUTPUT RM CC CXX LD AR CFLAGS
> CXXFLAGS V BISON FLEX AWK
> tools/perf/Makefile.perf:ifeq ($(USE_CXX), 1)
> tools/perf/util/Build:perf-$(CONFIG_CXX) += c++/
> ...
> tools/scripts/Makefile.include:$(call allow-override,CXX,$(CROSS_COMPILE)g++)
> ...
> tools/testing/selftests/bpf/Makefile:CXX ?= $(CROSS_COMPILE)g++
> tools/testing/selftests/bpf/Makefile:   $(call msg,CXX,,$@)
> tools/testing/selftests/bpf/Makefile:   $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
>
> The problem is if you pass LLVM=1 there is no clang(++) assigned to
> CXX automagically.
>
> [2] says:
>
> LLVM has substitutes for GNU binutils utilities. Kbuild supports
> LLVM=1 to enable them.
>
> make LLVM=1
> They can be enabled individually. The full list of the parameters:
>
> make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
>   OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
>   HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
>
> [ EndOfQuote  ]
>
> So you need to pass CXX=clang++ manually when playing in tools directory:

Yes, CXX is not set by LLVM=1 in the top level Makefile.  CXX is not
exported by the top level Makefile.  I suspect that
tools/scripts/Mafefile.include (and possible
testing/selftests/bpf/Makefile) needs to check for LLVM=1 and set
CXX=clang++ explicitly.

>
> MAKE="make V=1
> MAKE_OPTS="HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
> CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1"
> MAKE_OPTS="MAKE_OPTS $PAHOLE=/opt/pahole/bin/pahole"
>
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ clean
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/
>
> Unsure, if tools needs a special treatment in things of CXX or LLVM=1
> needs to be enhanced with CCX=clang++.
> If we have HOSTCXX why not have a CXX in toplevel Makefile?
>
> In "tools: Factor Clang, LLC and LLVM utils definitions" (see [3]) I
> did some factor-ing.
>
> For the records: Here Linus Git is my base.
>
> Ideas?
>
> Thanks.
>
> Regards,
> - Sedat -
>
> P.S.: Just a small note: I know there is less usage of CXX code in the
> linux-kernel.
>
> [1] https://lore.kernel.org/bpf/CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com/T/#m22907f838d2d27be24e8959a53473a62f21cecea
> [2] https://www.kernel.org/doc/html/latest/kbuild/llvm.html#llvm-utilities
> [3] https://git.kernel.org/linus/211a741cd3e124bffdc13ee82e7e65f204e53f60



-- 
Thanks,
~Nick Desaulniers
