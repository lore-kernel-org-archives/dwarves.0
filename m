Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48199C4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98E1207F7
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 19:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603742314;
	bh=G1c/GHL7ZmHdF2Og/fIW0LcbCQmVoyx4HU9WroQTTsI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qbC9kXvrd09k9o+W6Q6NF085CaqEaMpkoAngpOSdwjWPF1MrmAWb2Sgw5L7m6ears
	 3jV6hoEy6+kkcGClO7+y3Ja37RwlnUfyIXGVkjIaH5TLcjtDQl9lY0UYOn9rdprA5X
	 4rz2IyViQ5le8U/Djiacuua60UKNuu7zWq3bALfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgJZT6d (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbgJZT6d (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 26 Oct 2020 15:58:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EEB20795;
        Mon, 26 Oct 2020 19:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603742312;
        bh=G1c/GHL7ZmHdF2Og/fIW0LcbCQmVoyx4HU9WroQTTsI=;
        h=Date:From:To:Cc:Subject:From;
        b=ID59FThQR/pLcMIQ7KZ6F+2ZCm9P25wENBwluQBpyc5wNmPr8jbYjRMcSy1xRqkQY
         mTjLL+1TFXq4z8DX7vS+JsE8mppZjoAvM7a8DLpzl0SBoSZU1bhekCqViUpU5T44y4
         I0ee2FO/hlxnBowOQAjKcBHsaKfxm60BVlev3mUs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4D9D0403C2; Mon, 26 Oct 2020 16:58:30 -0300 (-03)
Date:   Mon, 26 Oct 2020 16:58:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>
Cc:     dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers
Message-ID: <20201026195830.GD2449445@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi guys,

	I just stumbled on this, investigating... This is with what is
in the tmp branch at
git://git.kernel.org/pub/scm/devel/pahole/pahole.git.

error: found variable in CU '/home/acme/git/linux/security/selinux/hooks.c' that has void type
Encountered error while encoding BTF.
  LD      .tmp_vmlinux.kallsyms1
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  BTFIDS  vmlinux
FAILED: load BTF from vmlinux: Unknown error -2make[1]: *** [/home/acme/git/linux/Makefile:1164: vmlinux] Error 255
make[1]: Leaving directory '/home/acme/git/build/v5.10.0-rc1+'
make: *** [Makefile:185: __sub-make] Error 2

- Arnaldo
