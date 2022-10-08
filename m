Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C6C433F5
	for <linux-dwarves@archiver.kernel.org>; Sat,  8 Oct 2022 00:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJHAZs (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 7 Oct 2022 20:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJHAZr (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 7 Oct 2022 20:25:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC425A894
        for <dwarves@vger.kernel.org>; Fri,  7 Oct 2022 17:25:44 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297NZoSl010159;
        Fri, 7 Oct 2022 17:25:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=AVnjhs660W41X1oSw+SgbJeH5pxVYX/xG6F/wFJxe2k=;
 b=CM6qQPEU7wvOHCza1NktAgfJaoDLqfVL3hieKaAy+YPvgInb2/Dhiby+3VfyEAb/ePBG
 KS0h5XyHTKvl5oEhs2XnE9KtNI8Jw1qcMMMPptpYzJD1WKicJwcCIhFFRfDQx4w6/a2q
 TLnul+KlXjtTWalE7BV701bvbJ4al99S7Q+1isHZp0BtRYEMp9mFY5ynl2rJ+vvWfh+k
 Hs6zIzLsd6vGfrC5ZWvkhvVfzDP/QmUTksPJEFjaziw8eCCUtQdPC4LhONfeNx4gIALx
 1+LSODwRqiRn0bfatk+srcOJYetM9OnY71e1KQnS4y6f0uS5Bv4ZocOXFtYVKfVd+6ll rg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k2mramd55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 17:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT4NIriUeWlsMmsVzDcARn0hBddFl5un/pYspVvJzJ1O4WoRvn61B4Ovx/44Fym9n2uXhpDr97Psj56H1ThbhRQwlbvq5RkarLpRfSdGpdCpo1K6lllPiS/QeyiI8XxZMBNAerW2tBFzeB/UDHtaH2YZlp9+QsRV+Gm3xYUK1MYgYhyNXCw2jcPyfK9IAzBDKqtyYdT+dIaFVpSGWvo+sOynZK5IMBEId3jJRv6Lz+OU1O4ZqIrNQfmLrLTkV2xKTnraxUpfngCvTYKZr0xlfQtmPSEHKNT/5gsVM4JZVN9goM3jeA2qLqRFx1OqKOWpHxd+GRKOBAJad84Fk9YRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVnjhs660W41X1oSw+SgbJeH5pxVYX/xG6F/wFJxe2k=;
 b=RYJFOQ9cPBnVAwqwPsi+eQvtCczaJPRGvGWSybFsGk1JAVxuoiJv3+MPJ4Xft35HMpnnTUgD7npanURI4ZCmvqnGtaliph9BmBufuAD7svP28zWi8OHNmOiBL/k0g2ad0ujV6LvQadMtwjz4DOfo0aLE36BGvz7DKMkAq5Qslucbk73QlXtbPLeeIHrbCl0ZMSc5YY/zAq1hdNN0Nrd5mEBS7ZdiwCdAAUDqkUZJ9FSStJQzgJgmy/JcHuS0mxgoQCKUAXutjwwpkrfhWIyWNknTlIPXkDis6+OYqcxcLYeSiXmsaRbrShSVqpVQDPIxXJ54NXSgL2ZQLcGT7aqHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by CH2PR15MB3669.namprd15.prod.outlook.com (2603:10b6:610:10::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sat, 8 Oct
 2022 00:25:25 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c303:ebfa:f023:f5a6]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c303:ebfa:f023:f5a6%4]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 00:25:24 +0000
Message-ID: <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com>
Date:   Fri, 7 Oct 2022 17:25:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzypIDbTomaZOPOY@kernel.org> <a57a66b1-9457-a84f-6f66-9695aab01b1a@suse.cz>
 <Yz2Wmd0WgiwmPglm@kernel.org> <Yz2mNfP2mmqAhkUn@kernel.org>
 <f1eb3b92-c98a-9128-742d-795d8b6846ac@suse.cz> <Yz7bevBJAm0JiLfp@kernel.org>
 <Yz7fdFPTpwALxvak@kernel.org>
 <CAEf4BzaonLxP77zj9ReaEWdZ-Whh4JUts3S5YO8v9vVuCfMdiQ@mail.gmail.com>
 <Yz8PBLflC2VDm9qw@kernel.org> <Y0CKQHhcTSWYqNpj@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y0CKQHhcTSWYqNpj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:208:23e::11) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2055:EE_|CH2PR15MB3669:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b96d141-0ed2-4982-49a1-08daa8c397ce
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2czvo8jJcRAUmrA8jpfixvsBYdymwLpOU41PZvKJNoAFzdIC+p8Uqj7wTUDMu2KA4tUqjbc1GRgAodQqZBJTnb6cnMQs7mPNHyHy6ZKNkl5uU7/XRQQ2AoZIGkB4R/PWYAIPG4zSx+/qK9xFex46Ltl0o+cVmGqbufrIF193E3elJINtcimZtrnxvvHa9zC+Io5v9xdMpsOEqDGYb34JVvu25JO9o7fkrhvREJknSYFVlvaf4H9iesLe7jjEo2KUAIzXAYnSGwYHSXHEVzbCPPr8HkNUiQ/n1sOxmksW2XmDSPm8mImRgISqDzHL7gX5HcL6KwqJfTeECUk4nY2/ymb64rcM8U5wtHHNHN1AAGuih3LK157LeUkl+3Z4ZOe4vEcN9GM/xT2L44aB007l4IZE/ZKCmOqem/lfqLhSdxamJsz1dedbdjbap0jlDw/JYreuFyMXel4IjOZS/AM2LirvPvLWqkzpZUGVw041EMBENsGkZ2jstg8j67GAX2zarySnShC47aYl/oyH1NCOxA0mOF7ffyXi8yLm1PlZj/PviA0Z3Fshv+NdQnBq41AHBgKYPnpOsUAOiYThdU5G2hAAGom6FOp3WalDSjc5ZwkJAnLaAZL8mHKdFsH+F/AR10K0CU6VGm3FZdi4r69bArS5PYb2GYeVm4hJwVv7vjjmFcuvbp+EhYtJVIKimmiSFwkd8ifYJJWkcnG6itoClhr7gIwCKc4fLiOeSUvj6EWhmVIbBF22QESdF3PSpZj6JwrTWIi6PTwsurDoAA4TTU+1bDYEfK7vGKW9HjjlAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199015)(31686004)(36756003)(41300700001)(6506007)(6512007)(86362001)(38100700002)(8676002)(186003)(2906002)(5660300002)(53546011)(110136005)(8936002)(66574015)(83380400001)(2616005)(66946007)(31696002)(66476007)(316002)(6486002)(6666004)(478600001)(4326008)(66556008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU0zWTdJVyt3WStLMlE0RVRCU0E5QW14UXpUQWYxVVc5TjlqRnFzamlCblR3?=
 =?utf-8?B?UFpYS1RtZHo5SUtGQVNFK3BwZUlKN2tIL0VRVWlTR20xRVZ4WVdWWE5qQWpW?=
 =?utf-8?B?UHc0T3pyUFM1YytBMnEwNHhnOXNFM1JBVUdLQUUzZEVtVTluQ2pmRUxVYVZU?=
 =?utf-8?B?Y01QRHd6Rk9Fakd3Nk5LM0RDdXNkbFNIRklFSS9RZWp0cjVubWFXWXVtWThw?=
 =?utf-8?B?c3dCS0pjdkRVa1ZCT1BnaGdQQkc5cDZoMy9Yc0wvVkRKTjhiZFg5RFJoNW5a?=
 =?utf-8?B?SG1jRTVpbE9rQUJzSHFBZTN6d2I5ZlNWYTNTeit4SzAvb3BkckQrSm5nZEVM?=
 =?utf-8?B?Vk12SG5lZnpVeEs5Rkt5ZzA2MlNZa3dJczkwRnVQUDdJZEE2NFYxdEhjWDFs?=
 =?utf-8?B?eXRHZU00VTBqNVNtemtMRHpIcHFCU2NTQVAxQnUrZ2NMWE1zVExQZXFCOU1n?=
 =?utf-8?B?YU0rNHdMTExYZkcxeFZEdzN5SElDL1JsaXpIZnBwWllqSWZQd1lYa3krQ002?=
 =?utf-8?B?UjVpYVUxVFlyR2hnYm1UU3grSk5QcEZkanFHdFVESUxNVGNuMFIvenpDSnBk?=
 =?utf-8?B?QzJ4cW83TkdJaHN3a2psOE5Od2Q0cFBQZTNpN3dDS3JrZUtMZHFmZ2pPZjNK?=
 =?utf-8?B?cmF3b29LWGpmTC9TMDdOb252NTB3KzA0TWJod0dzZGxITGdLWWpYS3VUV2RR?=
 =?utf-8?B?d2ZHd3o4U2sxVHo0K2FvK0N1MTZNVjV1VmoyTjRVYVZZSGpXT1NxRkVPL0Zy?=
 =?utf-8?B?NmNVdmZHNkRqd29yam9MUlc1VC9WcDRJcytQZ0g0SmF3YzRjYUEzcE4vYlJS?=
 =?utf-8?B?bnJ0MXBXMThDZzA3WW1udXZFT0dZdnFVRkx4VWh1L3dGMmRnaXBoSG9oZ0Q1?=
 =?utf-8?B?aUJ1dFdGeDlQN3doZUtQNFp1azBFZk1LZUk5cW5udmFSQUEvTHpxZjRnYit0?=
 =?utf-8?B?ci9lS1lRQy83cjNLc1AvWVhwZFh0Slhsb2tSSTc2UVArNCs5bEoyenU1ZkVu?=
 =?utf-8?B?YkdxYXRtaHd0U1k4dk9UVmp3R3BWNkNDak5iUlFLNmJ2MzdZT1k2bDdEQXlv?=
 =?utf-8?B?Ym8zVkxuMTNTOHlQRnhxWXJIUHU0RmxITHVVUTV2QmtnWjdLNWZqaVFWRkFU?=
 =?utf-8?B?dm5JdzA2Myt6eHQ5RTJGM0JheHB5L2NCcFo3ek51c01kSnc1MmF3MjZmdFAy?=
 =?utf-8?B?ZkIwK25sQmxxUjljUllHWUs4bkdteXlKY21rRDZSa01PWCtqeDMyUW5Bb0dH?=
 =?utf-8?B?M2lZTmYvR0VSVXFxcEZFZHVVb0lPdXhvUEtoTVd5YlpXdlRkaGpNL3Q1NFBV?=
 =?utf-8?B?ZVc1bWFkR1NvajhJR2lpWnN3K1IrRWdhQ25iZUNaRE53WFRWQzJZMWJQNEU3?=
 =?utf-8?B?QUdmendRaCs4emVvOCtMTExPcmJ4N3FLNEJYOGZPVzk3dktyOVBuNlJiSTU4?=
 =?utf-8?B?SlJzSWJrMDdwUEhXeGhiSHJOOEJycHFtUExjdUNKTitQS25MeGdySFN2cDYx?=
 =?utf-8?B?NzVnMERnYkUrcUNucXFyTlVnYW5kSXczNlNvdXA1dGhaSnVDQkk4OFZuaFBo?=
 =?utf-8?B?SkNXYkY4WEhRYTNWWXJlS0gvMFl4ZmVXUjNiaGtSaGFHNU4yTmtSVVhQRUZt?=
 =?utf-8?B?WUZ5SGorZjNMOWpNYjdHeklvRjJVZ0gwZUpOcFowdkZFR1lrcWdaT050SlhW?=
 =?utf-8?B?SzhzWWpxZkI3NUhvajJFM3B0WE51OENVbzFkQklMekc1UDlzTFRkWk9MYWJ2?=
 =?utf-8?B?MEpzVmlWMGxaTGVzbXN6anJxQWZHMEc3NmVBc2VoeldGYjJKd1NYUE1weE13?=
 =?utf-8?B?OTFlT0dlckJqRy9iQnMwdHV3VXRvdHMwZjdFWXRySXZBNXBnNzI3NHJuWStV?=
 =?utf-8?B?NUdIRVBERjZmbEtsU2JJMWtCaldiOUhtWG0yK250d3c3V0JHVHc0OVNTRFJY?=
 =?utf-8?B?a2RCZWZTV0k0TG42K25uakhHRE80VFhkRHp5VkFMcWdDV3AwdEVSdVJ1UmlW?=
 =?utf-8?B?dFd6Q2FoK3Jvd1UrUEI2aHAyY2NseHB6ZTdockpzNnNmUlV2b0UxZExlaE5U?=
 =?utf-8?B?QnF4VE1GM1o5a2FlT25SeStWUzJMRGNFMmdzTTUvNkpkYmJCa1JlRDRvdk4x?=
 =?utf-8?B?RllseDRLeUpMc2Z5VHVLSTRXZkp1SmVmRFRUc1RJemQrWWdvU3RvS3Z0bmE3?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b96d141-0ed2-4982-49a1-08daa8c397ce
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 00:25:24.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyDQqynpp4oEqCd/q/ueQIm3PsQN2p5GybzUu5k4FMVu1fsDMUrOjs0PE9aFA9Yh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3669
X-Proofpoint-GUID: G3n8GxInkveacaKWM1PPWggAmmg-Qy2e
X-Proofpoint-ORIG-GUID: G3n8GxInkveacaKWM1PPWggAmmg-Qy2e
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On 10/7/22 1:21 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 06, 2022 at 02:23:16PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Oct 06, 2022 at 09:04:58AM -0700, Andrii Nakryiko escreveu:
>>> On Thu, Oct 6, 2022 at 7:00 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
>>>> Em Thu, Oct 06, 2022 at 10:43:22AM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>> 15e20ce2324a:~/git/linux # readelf -wi ./arch/x86/entry/entry.o
>>>>> Contents of the .debug_info section:
>>
>>>>>    Compilation Unit @ offset 0:
>>>>>     Length:        0x35 (32-bit)
>>>>>     Version:       5
>>>>>     Unit Type:     DW_UT_compile (1)
>>>>>     Abbrev Offset: 0
>>>>>     Pointer Size:  8
>>>>>   <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
>>>>>      <d>   DW_AT_stmt_list   : 0
>>>>>      <11>   DW_AT_low_pc      : 0
>>>>>      <19>   DW_AT_high_pc     : 19
>>>>>      <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
>>>>>      <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
>>>>>      <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
>>>>>      <26>   DW_AT_language    : 32769  (MIPS assembler)
>>>>>   <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
>>>>>      <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
>>>>>      <2d>   DW_AT_external    : 1
>>>>>      <2d>   DW_AT_type        : <0x37>
>>>>>      <2e>   DW_AT_low_pc      : 0
>>>>>      <36>   DW_AT_high_pc     : 19
>>>>>   <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
>>>>>   <1><38>: Abbrev Number: 0
>>
>>>>> 15e20ce2324a:~/git/linux #
>>
>>>>> Which pahole -J barfs on:
>>
>>>>> 15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
>>>>> [1] UNKNOWN (anon) Unexpected kind for reference
>>>>> 15e20ce2324a:~/git/linux #
>>
>>>>> But if we ask it to exclude asm CUs (<26>   DW_AT_language    : 32769
>>>>> (MIPS assembler)) then it ignores it, so this is a workaround.
>>
>>>>> 15e20ce2324a:~/git/linux # pahole --lang_exclude asm -V -J ./arch/x86/entry/entry.o
>>>>> 15e20ce2324a:~/git/linux #
>>
>>>>> Now I'm looking at how to get the BTF encoder grokking this.
>>
>>>> This is what I came up with, Andrii, Yonghong, wdyt?
>>   
>>> Does `const void` make sense? Why not just keeping it as "void"?
>>> "const void" might confuse tooling and BTF verifier in kernel, but I
>>> haven't checked. Just trying to understand why we need extra "const".
>>
>> I was trying to have an entry for that DW_TAG_unspecified_type type
>> instead of plain changing the type for entry_ibpb (a DW_TAG_subprogram)
>> straight to 0 (void).
> 
> I think this is the best way forward at the moment, i.e. to just change
> the type for such DW_TAG_subprogram to zero, aka void, losing this
> information by default.
> 
> I'll have a --btf_encode_unspecified_type as this const void trick as an
> opt-in, who knows if this ends up being useful :-)

For function entry_ibpb, actually the kernel has a prorotype,

include/asm/nospec-branch.h:extern void entry_ibpb(void);

But unfortunately since the function is defined in asm code.
The actual type information is not encoded in dwarf so pahole
does not have enough info from vmlinux dwarf to get func
types. The compiler does not generate func types based on
declarations.

This may prevent people from tracing functions defined in
asm code but this should be extremely rare.
So I agree that BTF type id 0 is probably the best choice.

> 
> - Arnaldo
>   
>> I.e. we wouldn't lose that info that the return type for that "function"
>> (it was encoded as a DW_TAG_subprogram) isn't defined. Using straight
>> void would state that it doesn't return anything.
>>
>> I couldn't find a way to use KCFLAGS to ask Kbuild to pass that -B flag
>> to gcc so that I could rebuild the whole kernel with it to check if the
>> build goes thru and then try booting with such BTF info.
>>
>> - Arnaldo
>>   
>>>> As an additional info clang 14 (haven't tested with other versions)
>>>> encodes such ASM Labels as DW_TAG_label and this thus isn't an issue
>>>> there.
>>>>
>>>> - Arnaldo
>>>>
>>>> commit 15ec614672da043008df31aa6ee85ebc5105d4fd
>>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>> Date:   Tue Oct 4 18:22:53 2022 -0300
>>>>
>>>>      btf_encoder: Encode DW_TAG_unspecified_type as BTF_KIND_CONST
>>>>
>>>>      This first appeared for assembler files in the Linux kernel with recent
>>>>      GNU compilers, we don't have anything in BTF, AFAIK, to properly
>>>>      represent that, so, for now, lets go with BTF_KIND_CONST.
>>>>
>>>>      Testing it:
>>>>
>>>>      Built binutils from git://sourceware.org/git/binutils-gdb.git, then used
>>>>      gcc's -B option to point to the directory with the new as, that is built
>>>>      as as-new, so make a symlink, ending up with:
>>>>
>>>>        15e20ce2324a:~/git/linux # readelf -wi ./arch/x86/entry/entry.o
>>>>        Contents of the .debug_info section:
>>>>
>>>>          Compilation Unit @ offset 0:
>>>>           Length:        0x35 (32-bit)
>>>>           Version:       5
>>>>           Unit Type:     DW_UT_compile (1)
>>>>           Abbrev Offset: 0
>>>>           Pointer Size:  8
>>>>         <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
>>>>            <d>   DW_AT_stmt_list   : 0
>>>>            <11>   DW_AT_low_pc      : 0
>>>>            <19>   DW_AT_high_pc     : 19
>>>>            <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
>>>>            <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
>>>>            <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
>>>>            <26>   DW_AT_language    : 32769  (MIPS assembler)
>>>>         <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
>>>>            <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
>>>>            <2d>   DW_AT_external    : 1
>>>>            <2d>   DW_AT_type        : <0x37>
>>>>            <2e>   DW_AT_low_pc      : 0
>>>>            <36>   DW_AT_high_pc     : 19
>>>>         <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
>>>>         <1><38>: Abbrev Number: 0
>>>>
>>>>      So we have that asm label encoded by GNU AS 2.39.50 as a
>>>>      DW_TAG_subprogram that has as its DW_AT_type the DW_TAG_unspecified_type
>>>>      0x37 that we encode as a BTF_KIND_CONST pointing to 0 (void):
>>>>
>>>>        15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
>>>>        15e20ce2324a:~/git/linux # pahole -JV ./arch/x86/entry/entry.o
>>>>        btf_encoder__new: './arch/x86/entry/entry.o' doesn't have '.data..percpu' section
>>>>        Found 0 per-CPU variables!
>>>>        Found 1 functions!
>>>>        File ./arch/x86/entry/entry.o:
>>>>        [1] CONST (anon) type_id=0
>>>>        [2] FUNC_PROTO (anon) return=1 args=(void)
>>>>        [3] FUNC entry_ibpb type_id=2
>>>>        15e20ce2324a:~/git/linux # pfunct -F btf ./arch/x86/entry/entry.o
>>>>        entry_ibpb
>>>>        15e20ce2324a:~/git/linux # pfunct --proto -F btf ./arch/x86/entry/entry.o
>>>>        const void  entry_ibpb(void);
>>>>        15e20ce2324a:~/git/linux #
>>>>
>>>>        15e20ce2324a:~/git/linux # tools/bpf/bpftool/bpftool btf dump file ./arch/x86/entry/entry.o format raw
>>>>        [1] CONST '(anon)' type_id=0
>>>>        [2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=0
>>>>        [3] FUNC 'entry_ibpb' type_id=2 linkage=static
>>>>        15e20ce2324a:~/git/linux #
>>>>
>>>>      I think this is what can be done to avoid having to skip ASM DWARF when
>>>>      gets widely used, i.e. binutils gets updated.
>>>>
>>>>      Reported-by: Martin Liška <mliska@suse.cz>
>>>>      Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>>>      Cc: Yonghong Song <yhs@fb.com>
>>>>      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>>
>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>> index 7ad3f29ef153d8d6..7e50ba711ccc14d6 100644
>>>> --- a/btf_encoder.c
>>>> +++ b/btf_encoder.c
>>>> @@ -962,6 +962,8 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>>>>                  return btf_encoder__add_enum_type(encoder, tag, conf_load);
>>>>          case DW_TAG_subroutine_type:
>>>>                  return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
>>>> +       case DW_TAG_unspecified_type:
>>>> +               return btf_encoder__add_ref_type(encoder, BTF_KIND_CONST, 0, NULL, false);
>>>>          default:
>>>>                  fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\n",
>>>>                          dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
>>
>> -- 
>>
>> - Arnaldo
> 
