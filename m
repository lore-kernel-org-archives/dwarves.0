Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E7C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue, 11 Oct 2022 05:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJKF5u (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 11 Oct 2022 01:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKF5s (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 11 Oct 2022 01:57:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952882865
        for <dwarves@vger.kernel.org>; Mon, 10 Oct 2022 22:57:47 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ANNRxU004438;
        Mon, 10 Oct 2022 22:57:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=rSxTWXuCRP+ojhqcLM8lXNrk2jPEF1AvXELqSsSSvYw=;
 b=TBSDHLG+mwYnMPv3cOVkPupghC3f2+Z7u3fPu+ExFrKgEegpVO7vI+hCsCxI3YLK+kY8
 o+q7+JwyJzquwBpu2XEUbGV0KR+fVzqMLjPukVPswDNkRvWPNsSlMCj2VF7J07l01hXp
 GPu2GwgFIvgNyrB+vaZdIduX7S2kOrnreFMIqnp4si01F3rd65q0HePeYK6fStOiNh5P
 iChZDD+Z8Tre6Pf4/ZTfcyXSdO576FyBceq3RsmbDcw4iH3s6UEGGstvzj870VzHVfrF
 pGfEcwZsHZsirhAasqt6cdoMIG5k4v1L0KzIefU6BebCVLrnpcKGhQwrWaFebDnIFNP9 5w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k4q5554q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 22:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZoDAbSApxdBkTKY3PoM2W+8QakX9gSyE7EF21gdCAL+qmZehkul8ecsDVAn75pQwLc296FlXoqFkDALZkf3z4emhEBKPsUkfueomb9U53b0L4L7Y1zSzDAIqzz5/teH/wTC9rx2hilEbZqwmr4nZaPyEDlummfSPQKTjoyZ/9jMtH4Q4KyLoQzViMLfw2n8/6N/cTsLtTcmmqVAdiGv4nNANwYIvHUfolYydPeCrcCUNcTSznnHNcTPfxN41cyBw0M+rcxVwM6QLdoPW95ALUc9Gi7m0Qs7AERT2rZYydc/R6omMlbzqMYvGrr8RXjBROfwjncZzho8F7gZSnl0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSxTWXuCRP+ojhqcLM8lXNrk2jPEF1AvXELqSsSSvYw=;
 b=hMZuediFF6yZDiYcpoJIDweKPwNoldjJ3LuJ5KnFMxtJpUQ5oOrUiHDPTWCLd3oq2UDFFPCcY2XLOeVi/ToNtvVQ0hl5B+v3bm+iCsS1ZTnbQQ3O6JcKA3bdG0lQqaYmqiR5/yW5N+kA8YWI6QuqE0kgYPat2Aonjg3NAH0jVSzGrNkrwC9YtSdL2x60aayZ2HIVPDJ9n06E07AXmoVROjvfhTINVz4FQ/+JDWu54Wm8nWoh32c5nBKmkt2vKwKC9i+wP9Ww+ZiLawkOEAXvrfN3y+hjbKWiOltS1LUa/td2Fh6GBgRh5+oM6eYVFnJOVtSlLEWru8iS6f0Gh0sntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH2PR15MB4293.namprd15.prod.outlook.com (2603:10b6:610:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 05:57:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 05:57:28 +0000
Message-ID: <002daef3-ce5e-e6f1-ec12-fe5f64ae2632@meta.com>
Date:   Mon, 10 Oct 2022 22:57:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>
References: <Yz2mNfP2mmqAhkUn@kernel.org>
 <f1eb3b92-c98a-9128-742d-795d8b6846ac@suse.cz> <Yz7bevBJAm0JiLfp@kernel.org>
 <Yz7fdFPTpwALxvak@kernel.org>
 <CAEf4BzaonLxP77zj9ReaEWdZ-Whh4JUts3S5YO8v9vVuCfMdiQ@mail.gmail.com>
 <Yz8PBLflC2VDm9qw@kernel.org> <Y0CKQHhcTSWYqNpj@kernel.org>
 <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com> <Y0QK1nmVjqr95od1@kernel.org>
 <Y0R7uu3s/imnvPzM@kernel.org> <Y0R+U8i8mDPkOAw7@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y0R+U8i8mDPkOAw7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BL1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:256::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH2PR15MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 1022367c-23c8-4853-3567-08daab4d7ac1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roD+4u+AEQ/3M+opK1aNdzgn8RjRz6Ap8HGXi20o2Ar3noOhFumgx4tKDFgCuwPziDYPKS/+4Lrg0SYUtTB1xWKfqkQ2LkXheALY9kfK6VKRhjYVKp+fttaMYTORiVKB8MmluKc3PARKGcqpNED6ZY4bqSxdIGbY6SVp36v5vw7zOOQF/B06ybDSYb2e1WrZcwFOIWIevQkWl+eLY/21UWxlk4zTqxnXw/gn1Tl6vxp6rAqVzKzONFeaar3V8UVS79KssBkvfX6D0m8dIi9Xk2Y36RtA5OAvmrkY1HwCC6szcqCjtwIBuWpRdtwDWsedCMqiGxEFO67U/OtTwY8c8LZcNOuAeB6SFTVaOSQpJxJPe/2wJQx0W/l+SDV+1+gphLuMJlWN6H4oxUKuujOD6fig0Akh/6Dn4Ez3jO+0LlqIOy4Uhlz5ukzDp7MCKt/H+/N/4Ro7KFAvz6vs9AQ0+7xr6uS4Y/ECdmxSNcR3rTyhfD8fxVX0RubICqmxMuUgsgRrck55Z1LpFAUIBokpJfgE8toTXYzbgDKJaziQYmwtXZssbmT/+W9n6ecRCJ+eu0vnYiSUSJ/52MwInFUJaGkJ8GpxyHoKq/Zs0VD8zgDyfsCwLCRnOHWh4fWXtY1NDtBqIa1Xp9kY2hsOINfD7aGW5TJVVVro1czb6Yo3Pqgsa/QLFv9R5aW94si8F+CN7ngHUxbCpGnX1gTts5wKX7FdT30o77PPdJlRoApgWogZN09x2G9UxXYdTBrNTCpfVnLe6f+h9unckZHHkgbpJDUgL7UQ/pa2H+OGv5ktVvk/mLScyKfVYlUCX1zAqJlFJOL2uhjB9cwyAD4fBXH1Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(38100700002)(83380400001)(66574015)(86362001)(31696002)(6916009)(66556008)(8676002)(8936002)(66946007)(4326008)(53546011)(66476007)(316002)(54906003)(5660300002)(966005)(41300700001)(6512007)(2616005)(2906002)(6486002)(478600001)(6506007)(186003)(6666004)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWpCOUxrU2FnSFBGZXhGT1VrcnAyYzh2Q1VMSG5WTW51MnBGak5pT2hxK01L?=
 =?utf-8?B?cVVrWngrU1prZU83NGhkSWhKY24wekZYTlFIZk0yR2k4R2lsZEJMNWRJVEM1?=
 =?utf-8?B?cmpsZGtWOWJXM214UU5YelRVTVZTWjVTTm1hUHdpdG9YSjliOTRuWW9sbXpt?=
 =?utf-8?B?UlBzckN1dWFzQlExL2dLMnBIMHJrSFNUOUp1bzV1cEJ6Tnl0Z1R0aVJITzFK?=
 =?utf-8?B?V3JSQUdYMjNRQ0YyYzdoYnpwM0w4NmJaNzNoRlUrSDBEYVFNSXljN28vSEdm?=
 =?utf-8?B?TXZ6YWE1MUtjUjBaNU5JcVV2VEljdzhsQ1F6MXdYeE5uWG5zdHUvcVA2WXdK?=
 =?utf-8?B?N0hLTXlldFV5Q2Z5MmpHLzd0UzZ0SEhmU2J0dG1hQXJ0b3JLcURzbzI5WmRN?=
 =?utf-8?B?MzM2K2xKWWoxRi9oRXZWbWpFQlJmV2hLaFBSRGF2cWxoTXVFdEtMVlRxN25z?=
 =?utf-8?B?NXNqK3JmYUhRMmtJSGR5R1p5VGtWdXRSazYvV1JsM2NER2RZM1VwblFuU0pS?=
 =?utf-8?B?VjNtcHJtZHp6Z2FUajFDK09UeDlhZ2FUZ2N4WkNoZW1nTDE3Sjg4bnlIUUpG?=
 =?utf-8?B?eUExVngrNVVEa1RRdHI4czNZejBSU1FvcDRJcVJHWHdpOGlodE1TODlmSjIr?=
 =?utf-8?B?ZnVCbUtzN1JzdS9HZWExY3NxTHlaR3F4emNKRUhiQ1VxMVRZVFVaOE85cEJC?=
 =?utf-8?B?TGJMSVU1RnNJTVRHQkgySlZIVDNhTHVoNm5IM0NELzBaUXhaTzVvaDF5TnM0?=
 =?utf-8?B?Nk8wYm9ieXJrZStRVUVpSlI2MjRZajdoTC9ra3VhWjZ6ajFWS2ZkeWo2dzJW?=
 =?utf-8?B?c1Y4T3ZwNVFkZ0FCSE8rYnlTSGpSenF2a04xNjAzOTFtSitXOGZnc05OSTNI?=
 =?utf-8?B?T3dPZ093bkw1cldiOHF2WkEreWIzZnV3elZ6VU4yMEVxNHE2b3N3Y1R5Uy9I?=
 =?utf-8?B?VUtxKzNBK3FlVi9Xb0tadGIyUHlGSWh3bXpQVU5HU3lyT3ZXYWRhTGtiZjFj?=
 =?utf-8?B?Y3piTUlaMHQ3VUpKazJsaFhIMjBtOWl1V0d6MURNNXo4cjc5U3o1UUY0NERH?=
 =?utf-8?B?YVdVeU9XYjcwZ1NpQytBdC81dVg2YWpBWElJOG4rSzFQb2dxMlFTYzlUUW9x?=
 =?utf-8?B?VU5mZnBKWjgvdEkwbThIOElkeGZKQk9NNktRa0JWS2NwWThRRjdwOUVsUFNM?=
 =?utf-8?B?ME9Qam5yZkdiUUErRjg5aHZMVFN3T2x4d0dGYVgzem44UkFPSk1keWFUb0RF?=
 =?utf-8?B?dkxUdkZaL3lYeitNK2lIcm5wNE9IZmdUVHA2d3Z3b1NxVHM4aW4wZ0pzZ0pW?=
 =?utf-8?B?TVQ4NGNjMmZ6WUViZHppOVNEWURWc3BWUDBVWDZSeXdGVWxaN0dkbWtTbzZI?=
 =?utf-8?B?cm9USnRwVWNOMnVsV2xKTFNIK0daVU9kM2JDRG02amtuekxseXNBMWV5eUtZ?=
 =?utf-8?B?VlVhaUU2VEZkRHltcDBhcllmdllaaXNpVHk3OEgrMVZrczdnNE55LytKK1dx?=
 =?utf-8?B?d0VEcnk3d1FQazdzMkd6QjcxUnJPOHJoeVl0NkJiN1JHVHpHTzVmOUE0SGRW?=
 =?utf-8?B?eUpXYVpvVUF3MWhtK2JjWUxteGpueERFV1l3TXJ6Y3laWDNEd0pxWHJyd3ZG?=
 =?utf-8?B?eDVtcVFCUC8zNDc2S2dsdTV1Wkd3enJ1a3o5RUdsanFTQjJ4bys0dXJUckVz?=
 =?utf-8?B?NEV5Tm90M3dyOWZHVGZXVWV4eUZtNjdIUlVJenMvdC9acitZTEdhRW5abjVh?=
 =?utf-8?B?WkJyaDd2RzBpZ09IT2NER1JubHZxSUw5OWJncHcwUzJydHFFYUQxWjA5NURH?=
 =?utf-8?B?TWt2NzhDR0xaeVJzWTRMU2k0MDNTTVRablo0WDJwMXV2ajVVZzRtZzNsMjlz?=
 =?utf-8?B?eHo4c2VMbGwzNVVTR2JKTTJkbURPVExJRWJnTFJWK1kyN1Z6b2tndjBSd0pj?=
 =?utf-8?B?c0RBOFFiWllSMDhGbm1wei9SSGNrZmtSVHl6em5NYXZQVmY0cjhOMWt3SExX?=
 =?utf-8?B?cVR2azRNRVhZRHUxcStkQ256SkdUSjBrS0lVM3hheUdDbk5QeU1samd6UFRC?=
 =?utf-8?B?V1kvbG9VV3AwU1VpZmQ3S2dHdmNIaTNFVHA5QmxreElXQmpxNlN2a25lQVQ0?=
 =?utf-8?Q?Nt/585u2GmI3UJ3WcI2mCy/Zh?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1022367c-23c8-4853-3567-08daab4d7ac1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 05:57:28.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUv4UGek/Kf4+khC+t90C48ZUR3jhd9RfrpJYniQ0eKlHLhFgmlDC7oERAxjzoN/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB4293
X-Proofpoint-GUID: lnGw14SdQAVegU5Ts3Kt2g9xmYVhuq7b
X-Proofpoint-ORIG-GUID: lnGw14SdQAVegU5Ts3Kt2g9xmYVhuq7b
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_03,2022-10-10_02,2022-06-22_01
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On 10/10/22 1:19 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 10, 2022 at 05:08:26PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Oct 10, 2022 at 09:06:46AM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Fri, Oct 07, 2022 at 05:25:21PM -0700, Yonghong Song escreveu:
>>>> For function entry_ibpb, actually the kernel has a prorotype,
>   
>>>> include/asm/nospec-branch.h:extern void entry_ibpb(void);
>   
>>>> But unfortunately since the function is defined in asm code.
>>>> The actual type information is not encoded in dwarf so pahole
>>>> does not have enough info from vmlinux dwarf to get func
>>>> types. The compiler does not generate func types based on
>>>> declarations.
>   
>>> Right
>>
>>>> This may prevent people from tracing functions defined in
>>>> asm code but this should be extremely rare.
>>>> So I agree that BTF type id 0 is probably the best choice.
>>>
>>> Thanks for your comments, that is the way I'll do it.
>>
>> Done, some prep patches then the patch below.
>>
>> If possible, please ack :-)
> 
> Its all now on my 'next' branch at:
> 
> git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> https://github.com/acmel/dwarves.git
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next
>   
>> - Arnaldo
>>
>> commit 3abc72d9d56ec0cbfffc1794d2bf5d527d1e88ba
>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Date:   Mon Oct 10 11:20:07 2022 -0300
>>
>>      btf_encoder: Encode DW_TAG_unspecified_type returning routines as void
>>      
>>      Since we don´t have how to encode this info in BTF, and from what we
>>      saw, at least in this case:
>>      
>>      Built binutils from git://sourceware.org/git/binutils-gdb.git, then used
>>      gcc's -B option to point to the directory with the new as, that is built
>>      as as-new, so make a symlink, ending up with:
>>      
>>        15e20ce2324a:~/git/linux # readelf -wi ./arch/x86/entry/entry.o
>>        Contents of the .debug_info section:
>>      
>>          Compilation Unit @ offset 0:
>>           Length:        0x35 (32-bit)
>>           Version:       5
>>           Unit Type:     DW_UT_compile (1)
>>           Abbrev Offset: 0
>>           Pointer Size:  8
>>         <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
>>            <d>   DW_AT_stmt_list   : 0
>>            <11>   DW_AT_low_pc      : 0
>>            <19>   DW_AT_high_pc     : 19
>>            <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
>>            <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
>>            <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
>>            <26>   DW_AT_language    : 32769  (MIPS assembler)
>>         <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
>>            <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
>>            <2d>   DW_AT_external    : 1
>>            <2d>   DW_AT_type        : <0x37>
>>            <2e>   DW_AT_low_pc      : 0
>>            <36>   DW_AT_high_pc     : 19
>>         <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
>>         <1><38>: Abbrev Number: 0
>>      
>>      So we have that asm label encoded by GNU AS 2.39.50 as a
>>      DW_TAG_subprogram that has as its DW_AT_type the DW_TAG_unspecified_type
>>      0x37 that we convert to 0 (void):
>>      
>>        15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
>>        15e20ce2324a:~/git/linux # pahole -JV ./arch/x86/entry/entry.o
>>        btf_encoder__new: 'entry.o' doesn't have '.data..percpu' section
>>        Found 0 per-CPU variables!
>>        Found 1 functions!
>>        File entry.o:
>>        [1] FUNC_PROTO (anon) return=0 args=(void)
>>        [2] FUNC entry_ibpb type_id=1
>>        15e20ce2324a:~/git/linux # pfunct -F btf ./arch/x86/entry/entry.o
>>        entry_ibpb
>>        15e20ce2324a:~/git/linux # pfunct --proto -F btf ./arch/x86/entry/entry.o
>>        void  entry_ibpb(void);
>>        15e20ce2324a:~/git/linux #
>>      
>>        15e20ce2324a:~/git/linux # tools/bpf/bpftool/bpftool btf dump file ./arch/x86/entry/entry.o format raw
>>        [1] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
>>        [2] FUNC 'entry_ibpb' type_id=1 linkage=static
>>        15e20ce2324a:~/git/linux #
>>      
>>      I think this is what can be done to avoid having to skip ASM DWARF when
>>      gets widely used, i.e. binutils gets updated.
>>      
>>      Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
>>      Cc: Martin Liška <mliska@suse.cz>
>>      Cc: Yonghong Song <yhs@meta.com>
>>      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index fb2ca77e2e9bf144..a5fa04a84ee246ee 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -593,6 +593,19 @@ static int32_t btf_encoder__add_func_param(struct btf_encoder *encoder, const ch
>>   	}
>>   }
>>   
>> +static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
>> +{
>> +	if (tag_type == 0)
>> +		return 0;
>> +
>> +	if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {

Why we need tag_type == encoder->cu->unspecified_type.type?
Should we unconditionally convert an unspecified_type to btf type id 0?

>> +		// No provision for encoding this, turn it into void.
>> +		return 0;
>> +	}
>> +
>> +	return type_id_off + tag_type;
>> +}
>> +
>>   static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, uint32_t type_id_off)
>>   {
>>   	struct btf *btf = encoder->btf;
>> @@ -603,7 +616,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
>>   
>>   	/* add btf_type for func_proto */
>>   	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>> -	type_id = ftype->tag.type == 0 ? 0 : type_id_off + ftype->tag.type;
>> +	type_id = btf_encoder__tag_type(encoder, type_id_off, ftype->tag.type);
>>   
>>   	id = btf__add_func_proto(btf, type_id);
>>   	if (id > 0) {
>> @@ -966,6 +979,15 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>>   		return btf_encoder__add_enum_type(encoder, tag, conf_load);
>>   	case DW_TAG_subroutine_type:
>>   		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
>> +        case DW_TAG_unspecified_type:
>> +		/* Just don't encode this for now, converting anything with this type to void (0) instead.
>> +		 *
>> +		 * If we end up needing to encode this, one possible hack is to do as follows, as "const void".
>> +		 *
>> +		 * Returning zero means we skipped encoding a DWARF type.
>> +		 */
>> +               // btf_encoder__add_ref_type(encoder, BTF_KIND_CONST, 0, NULL, false);
>> +               return 0;
>>   	default:
>>   		fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\n",
>>   			dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
>> @@ -1487,7 +1509,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>   {
>>   	uint32_t type_id_off = btf__type_cnt(encoder->btf) - 1;
>>   	struct llvm_annotation *annot;
>> -	int btf_type_id, tag_type_id;
>> +	int btf_type_id, tag_type_id, skipped_types = 0;
>>   	uint32_t core_id;
>>   	struct function *fn;
>>   	struct tag *pos;
>> @@ -1510,8 +1532,13 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>   	cu__for_each_type(cu, core_id, pos) {
>>   		btf_type_id = btf_encoder__encode_tag(encoder, pos, type_id_off, conf_load);
>>   
>> +		if (btf_type_id == 0) {
>> +			++skipped_types;
>> +			continue;
>> +		}
>> +
>>   		if (btf_type_id < 0 ||
>> -		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
>> +		    tag__check_id_drift(pos, core_id, btf_type_id + skipped_types, type_id_off)) {
>>   			err = -1;
>>   			goto out;
>>   		}
> 
