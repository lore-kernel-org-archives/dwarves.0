Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D956C433EF
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Oct 2021 09:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F181660F11
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Oct 2021 09:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhJRJ7z (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:59:55 -0400
Received: from mail-db8eur05on2055.outbound.protection.outlook.com ([40.107.20.55]:25568
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229473AbhJRJ7z (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 18 Oct 2021 05:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0aZ+wDRiIkiU04C7m+CVp4ZL5sP7MEUnHN2GIMz07A=;
 b=Duxy96QjUPvILBQg/oyD4m3PCeUFpf1NNL2TxxTbbZiowLS0flTUuxWbEz5J7VCQcPR8Cy5gd+3+yMV24hUc6wh21nXgfM8D3d5cPYmOL2FdbJ6Ae4jrKGygyeGhgZa7O2XGqB3Bzr9EMzgpjd5br8LZHyl/yoGKeJkRJ14q+d4=
Received: from DB6PR07CA0185.eurprd07.prod.outlook.com (2603:10a6:6:42::15) by
 AM6PR08MB4424.eurprd08.prod.outlook.com (2603:10a6:20b:73::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Mon, 18 Oct 2021 09:57:38 +0000
Received: from DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:42:cafe::7d) by DB6PR07CA0185.outlook.office365.com
 (2603:10a6:6:42::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.9 via Frontend
 Transport; Mon, 18 Oct 2021 09:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT060.mail.protection.outlook.com (10.152.21.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 09:57:38 +0000
Received: ("Tessian outbound 2e7020cc8961:v103"); Mon, 18 Oct 2021 09:57:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 86c317e03b1ac0a8
X-CR-MTA-TID: 64aa7808
Received: from d5f0186ab1f4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A1CF5861-B651-48B5-8754-BF004B889AB4.1;
        Mon, 18 Oct 2021 09:57:32 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d5f0186ab1f4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 18 Oct 2021 09:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQeoABsw5xStY0AOMQldZgwsaz5jQzdiCO1QFQR+qYJohSRLg6ubl+6US5qENUFH5I4ye+tzgqdKXN9wuHqngX/zhm8ba0o37lXHhTSmVowgXTs6JXzmAaYF7SUMjTZWH4bL/NOkDn3KWEzDs+jTkECm8mMZ9WLol/iH68mZFXYa2GC6x9uTAzjq7vl3AjF5oij9EaB8UhfA4sTO6hP3/BLNAJlVYTGawwJZBkNqZgjn0UXjx4vB0ItxyhW/s+4HzMWWxOklUKUgNbuKRsIf7egb04WRYFkNcLqCnTCujW0iAyHfsaCJjjy7d0wCNWJe7Q4/8s1yCMvOYCVaWeAAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0aZ+wDRiIkiU04C7m+CVp4ZL5sP7MEUnHN2GIMz07A=;
 b=OfT2PJOCr+372ebVpdF36eq/az6KEKswUah1aPfOwGbaOQE7Hx2aQ7rQ5WRzrJFKg91Qz4Ww7tFn2HBW3tdzYNYc170kTegf9qLGHuXtYo7442tsyIzAGtI2MjslvBCNk72p3yx2AZ9vgaAIOuizULybGaUwt+DnM0uLISGt7pnKnduJOBPNro4KW+TbzqJQbGFHP8ccJaJMxfnsKkFn4R6QdtMLB/PSaJUqC1S0iUtPfFysjzzVmTqik0FNH7Wtg0/Kt6Aq+56N3wuzfohYIijxPxhDyD1PTGtMi6wqOplPqpw7nqUrEf+WeJb2jQoeAAXRjC7k9iqemofi9q5uDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0aZ+wDRiIkiU04C7m+CVp4ZL5sP7MEUnHN2GIMz07A=;
 b=Duxy96QjUPvILBQg/oyD4m3PCeUFpf1NNL2TxxTbbZiowLS0flTUuxWbEz5J7VCQcPR8Cy5gd+3+yMV24hUc6wh21nXgfM8D3d5cPYmOL2FdbJ6Ae4jrKGygyeGhgZa7O2XGqB3Bzr9EMzgpjd5br8LZHyl/yoGKeJkRJ14q+d4=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received: from DB9PR08MB6714.eurprd08.prod.outlook.com (2603:10a6:10:2a4::18)
 by DB9PR08MB6924.eurprd08.prod.outlook.com (2603:10a6:10:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 09:57:30 +0000
Received: from DB9PR08MB6714.eurprd08.prod.outlook.com
 ([fe80::348b:9e53:4b70:c27d]) by DB9PR08MB6714.eurprd08.prod.outlook.com
 ([fe80::348b:9e53:4b70:c27d%8]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 09:57:30 +0000
Subject: Re: [PATCH] CMakeLists.txt: Add STATIC_LINK option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
References: <20211015101008.486302-1-douglas.raillard@arm.com>
 <YWl/sfJLWEHGdJwV@kernel.org> <YWmAo8Xv5YZBlL41@kernel.org>
 <YWmOOP0/fF2BEd/s@kernel.org>
From:   Douglas Raillard <douglas.raillard@arm.com>
Message-ID: <7718fdaa-a8ec-c86d-e5e6-149db8659529@arm.com>
Date:   Mon, 18 Oct 2021 10:57:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YWmOOP0/fF2BEd/s@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0268.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::21) To DB9PR08MB6714.eurprd08.prod.outlook.com
 (2603:10a6:10:2a4::18)
MIME-Version: 1.0
Received: from [192.168.89.251] (86.160.239.34) by LO4P123CA0268.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Mon, 18 Oct 2021 09:57:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c6b1994-88cb-4270-93b7-08d9921db7e8
X-MS-TrafficTypeDiagnostic: DB9PR08MB6924:|AM6PR08MB4424:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4424EF38198CD85DB55795CE8FBC9@AM6PR08MB4424.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /PpXTlvElFkfBndEKa5VyVlEqco64g9RN334ruWRW3Ty8Sd5ftK7jwUqMa40LO2ZlA1CMCwmYdpvLyU8us6mpqF1QuytOq7EFdP1R/VW1bINLHwwDbyfKvB9/gh+0cxlowir++q4W7GALvKVDIkTjilistz55S+k6670A8FW8LUa2pLbTGLt2U61cHAexo9Qrbenk+26gsoQVJp1R4CPo942a6wO6so2+QhifhfQRu+QFKWn6UH5mTMKnb/RIxUXqTPRe30jEYXPy9gNeJkY6tFTD4QFIm11EDXU/RzRt9a1ZQnoeRx3rH1iAsYCe8pmpN/7tfTJ2hHStqK3aYfLj44N91uO+k1CB+J7G2O+ooai7BVPpGTSDw1Wyvri5HFd2V5PfhDWLSDWN7uLYiCE2hcNY+lbKS0uCQJhRJ4XTLFp9CFpbm1+wA3AVi66S/uYhr794c5JB7kGrZvbmHlvqdvSDVn2RfsfN8ton7p4ukI/pIhdSaPKUafmE868BYHOu9Whw8mWLDTNJ4PMs6yDIkrn5Yx9QhX9X/bgWz/kSDhuK7b0omr1TyVEWENOCpZ8TH28zZfHaI718eNlmMsIHmyYOl/zZZqk3DEOh0DvPsvQGeNTwaVKnMt+AhHT7Yhf4NcoTNoFm+xPbRCJdxH0kzN1vxEr8O9XNG9e9bO0nHEYeIar6b4H96s+OCXzccGmxpfpx0yhl3TIPRKBJBAn3MkdtW4Sgt4ACX2OZY7y2QPkaOECmawYXxZa8R8K4/r8ySE4uY4l5bQqT4DzGb0E8j3iZgYNPVNv3a8WOBBYGDouzVIFK2SenOsH0mOLNeVyPnh1WOqlI1jKM0CGXeQEtVRVdWQGiGXmkRu9XDRYz2w=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6714.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6666004)(16576012)(66556008)(6486002)(86362001)(508600001)(66946007)(66476007)(316002)(83380400001)(6916009)(31686004)(26005)(4326008)(2616005)(53546011)(31696002)(38100700002)(8676002)(956004)(2906002)(966005)(8936002)(44832011)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6924
Original-Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8757a1c4-24f0-4031-8dde-08d9921db295
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AR/v3MIpCteWdlaxrC/IFXNTgmsNBtis1cmDU8vjcWF98R0+G0xKsuFASOuh/hGFByLZroUsuDc0/mFe/usKoNipWuVWFU6MMRztUJOx8k2BfwIjeBcWccrlEIKLvLufOnKVy8alDjmsSCZP6/Tle4o5u9eZgE7kLQaRcwENtREQtcwaKZqrNpF0xizTtbwH9Clvw65oSLxKX4trSVxXf4tc8+8VCTe+YcfrJ6eJCChmqIW8ePamibjpwSbBKqKCIA/sKZJIfdQfIHI6rnSQ5cwijBsZfV6vh1oZzMHcnpMJgI71oNiTgPADgDCdjqBhUIl2k+UAn27FLY+aC1O2igfOFF8Vjfbsfl3mqMK8yBIFo7kRpqvOqllTfmAk7/NPQ+rT+5qQkKCAT1zGVs71IitmKzlARmKSkhHnYCo5jQ4QCsYBMFqHVrRHXlm3vqztmLd8HGeTg+hirdkVFaNQWS+HpPBTF503+m1Bmp0z6nF9bVFbrxuSG3nsxYWEfN4teGiPAS1hMadsRZELTVE+/BooSGQOdIpGmHwpT5ow9WFPrJWoRPuvhnprbQ6v8rpr/3lZ5uk4iWWsaePDdO04zUd9hxFxF3/N6wlu7lO++3ZZlpB0LnyRn79Y0rWLPhe+lpSvqe1nm2WlzDTByanGlqxfeEt6A6UkUgGoyqYPFcmFPn28tD0F4puIAOckrD5oiErGiJYDu7vcuzIo0yJ9aHaabkMBRJGzSNI7yAW/0ychvv1KVKt3utgdkA4haRkQB/4l6lNogwf7ZcVY43X+JpMc8AnZfWRIBLguXkBDXlP3Gc/irG48KWEU2jveMFTxIOUKZjbGf8ikMdEmlgr3nSX8ATh05ZNr9OBjT3c9qc=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6486002)(336012)(966005)(508600001)(6666004)(956004)(2616005)(70586007)(83380400001)(53546011)(4326008)(186003)(70206006)(47076005)(8936002)(36756003)(31686004)(26005)(36860700001)(2906002)(82310400003)(16576012)(81166007)(5660300002)(8676002)(44832011)(316002)(31696002)(86362001)(6862004)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 09:57:38.6745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6b1994-88cb-4270-93b7-08d9921db7e8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4424
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 10/15/21 3:20 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 15, 2021 at 10:22:43AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Fri, Oct 15, 2021 at 10:18:41AM -0300, Arnaldo Carvalho de Melo escre=
veu:
>> CMake Error at cmake/modules/FindDWARF.cmake:103 (message):
>>    Could NOT find some ELF and DWARF libraries, please install the missi=
ng
>>    packages
>> Call Stack (most recent call first):
>>    CMakeLists.txt:64 (find_package)
>>
>>
>> -- Configuring incomplete, errors occurred!
>> See also "/var/home/acme/git/pahole/build/CMakeFiles/CMakeOutput.log".
>> =E2=AC=A2[acme@toolbox build]$
>>
>> Which means I don't have those static library files, will try installing
>> them.
>
> I'm trying with the latest fedora that comes with static libraries,
> fedora:32, and there I noticed that we need to look for libzstd as well,
> I added it manually to:
>
> target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBB=
PF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBR=
ARY} -lzstd)
>
> [root@cc85f3a7b96f dwarves-1.22]# rpm -qa | grep -- -static
> zlib-static-1.2.11-21.fc32.x86_64
> glibc-static-2.31-6.fc32.x86_64
> elfutils-devel-static-0.183-1.fc32.x86_64
> xz-static-5.2.5-1.fc32.x86_64
> libxcrypt-static-4.4.20-2.fc32.x86_64
> libzstd-static-1.4.9-1.fc32.x86_64
> elfutils-libelf-devel-static-0.183-1.fc32.x86_64
> bzip2-static-1.0.8-2.fc32.x86_64
> [root@cc85f3a7b96f dwarves-1.22]# cat /etc/fedora-release
> Fedora release 32 (Thirty Two)
> [root@cc85f3a7b96f dwarves-1.22]#
>
> now I'm at:
>
> /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/10/../../../../lib64/libdw.=
a(debuginfod-client.o): in function `__libdwfl_debuginfod_init':
> (.text.startup[.text.startup.group]+0x1b): undefined reference to `dlopen=
'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0x36): undefined referen=
ce to `dlsym'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0x4f): undefined referen=
ce to `dlsym'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0x68): undefined referen=
ce to `dlsym'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0x81): undefined referen=
ce to `dlsym'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0xe0): undefined referen=
ce to `dlclose'
>
> that needs some more magic that I already forgot :-\

When trying on Ubuntu it also appeared that find_library() for libebl
was also needed, but not on Alpine Linux so I did not include it, as it
does not seem necessary on Alpine. I'm not sure how we want to go about
these:
1) Take the union of all the dependencies that seem to be necessary and
deal gracefully in CMakeLists.txt with failure to find a lib. This will
result in linker error if a lib is actually necessary and not found.
2) Select a blessed distro for static building and only maintain that
3) Find some cmake builtin "magic" so that the user can point at
existing lib that seem to not be detected on their distro. I'm quite
rusty in cmake so maybe there is a better way than sprinkling
find_library() everywhere.

So far I opted for approach 2) with Alpine, as building on e.g. Ubuntu
will not work in any case, because glibc does not support static linking
(it kind of does until it does not anymore). Alpine uses the musl libc
which supports static linking.

As for the dlopen/dlsym/dlclose issue I'm not sure. Maybe these symbols
are just not present in static glibc ? The binary I produced on Alpine
did not seem to segfault [1]. If you want to give it a go, this scripts
set it up in ~20s:
https://github.com/alpinelinux/alpine-chroot-install

Packages: bash gcc git make cmake musl-dev zlib-static bzip2-static
libelf-static libbpf-dev musl-obstack-dev argp-standalone linux-headers


[1] pahole static binaries:
https://github.com/ARM-software/lisa/pull/1740/files
>
> But now out to lunch.
>
> - Arnaldo
>
Cheer,
Douglas
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
