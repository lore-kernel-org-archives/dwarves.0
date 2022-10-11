Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16724C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue, 11 Oct 2022 15:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJKPpO (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJKPow (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 11 Oct 2022 11:44:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659E223BC9
        for <dwarves@vger.kernel.org>; Tue, 11 Oct 2022 08:34:51 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B9LOHV013550;
        Tue, 11 Oct 2022 08:33:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=0TTYKVHEI41f+Qg3Ska2FrRYRITP6E+cibYFjKi1spE=;
 b=ldhGID5m9L7m8ObLEr6yeRWMGUveK16DK2Mo3UugLqngF7+aWOqMgZeROBhUlGg11oiD
 GJ1yfFs6UXTsw7cymcN3xcNt4JLYC11FhMxrIhBA7+WRl7EvLkrcis8IMen78S4ytYCn
 cngT4OVQ4uKliSaJJzTm6miWz5CG/CDtB7CzwclkffErDv2JDntVk/U55/ve7dRAMqr/
 Ld/OTC0z0eKj79twFH/zJ/UfpdQw9D6P1keGRIKDnfQheWM9rfagg+Q1+HFXOMg1TBuM
 RODSr7o4QXo/JGcHn3kGfe/n3swRgQfcvAjyDZHAo5Laq8z+x6sesZa+6ejZ5b2BZUfh sg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k55sgjeaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 08:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVPYtsSfW7iIAtoAfhBo7uebzZ+DZxBaFKaZb+4npQ7flAk9U1nY9X6wwlsS4MhFNoUWsRDx9Fif8fAq4dm+/zp4StXjc7ncdeirKE6XcRlcDTxTofgmJt6c5GMbqQY/5dGO4iYM4GVLHhUTc+aDDOreEz6BvJmtgzP+vLGYH3212dIuZ+50Rp5dL8Eh+5ciX280wVhQFJ/hFzzNYnNWqzs0TFvDFroVcJFa5h1Hr9ShvPgGrEstm/hajmW/sLUYLO4PrPdO7YWEWPWxEZPKYHvm+telK8IpOrAF27OYBZsWHG8zc+7Fb6m4AI52KaO8rUY0z6ylJt3hw2xmSxfnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TTYKVHEI41f+Qg3Ska2FrRYRITP6E+cibYFjKi1spE=;
 b=WHSXiuHnyGufgRrAusveKzI2qRYnvugbGcPBsT+htLDhFjGxusAb4/NioOJc618uaG4GMIQZhLd/x4AhqIF7tvskPJ19B44x3oz6GFBWQzD3AVZvUDgdiCyZ4XaSbRsvKA1B8mB2FO8fsQY/s3848DCZUnsFi16wspqg6+KfnR5kfsivjI2poqQ6YHS2pOSlOeAZClnpjh9CmvOOKJadWNKgjL8ZdtNNpxtFSMdp8T28vg7yGq5sKueXXmuuKnhv+LOhhabYaFmrBTvavytQT2obmh1GThfpH/uXwFedEMx7DM6L5fqwL8EncwdAGuF1lAA2gjfngKvSpuYfL6cMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3899.namprd15.prod.outlook.com (2603:10b6:303:45::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 11 Oct
 2022 15:33:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 15:33:38 +0000
Message-ID: <ee52054a-bd76-2817-33c4-ffae00e72fb9@meta.com>
Date:   Tue, 11 Oct 2022 08:33:34 -0700
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
References: <Yz7bevBJAm0JiLfp@kernel.org> <Yz7fdFPTpwALxvak@kernel.org>
 <CAEf4BzaonLxP77zj9ReaEWdZ-Whh4JUts3S5YO8v9vVuCfMdiQ@mail.gmail.com>
 <Yz8PBLflC2VDm9qw@kernel.org> <Y0CKQHhcTSWYqNpj@kernel.org>
 <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com> <Y0QK1nmVjqr95od1@kernel.org>
 <Y0R7uu3s/imnvPzM@kernel.org> <Y0R+U8i8mDPkOAw7@kernel.org>
 <002daef3-ce5e-e6f1-ec12-fe5f64ae2632@meta.com> <Y0VzbkffTg2TJ5i3@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y0VzbkffTg2TJ5i3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:208:178::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB3899:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b69989-2381-433e-74cd-08daab9df809
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imtRrJP4v7XB00BfhxP9dZRKbvQ81/BkrCxM3O9W3wBA1ZrLs/VsSoev35ggOHdFbOOhON66GhNMWVTdgl7+njHQCIAP0tsI/Cd/Ch1obpkW2JANwqRhoJ1WOw1qHkPw4sfp6995yOin8YY2nIydVDQL11JBzZem2sDaCqZRLuHfK07cge2g5yrEyHX7bma8LH6EsRdabQ1IBsbMqNdW6auAL8UnptL7ceMVvqfOTK1sHMDNjGzRLh1t/LqWjZJsjop23tjSEkVUaj7H0SceDsAM+pR/BRzKeEbm3uoQgsPHOhXF/y3bSiXWXUH0WJkm1gwcmgRgIGdofBTeXGzhGjsEckN4ucHsXGIf3eA/P6ZULlP0bfcUviLqkIP3EU9vRpSlAp9N+5nz3mbpjuKlPXUpS4T2cTQoMgMHVNAJlEOqgSvoQtEZ5K1VR9+ZVlH3xXj0t8bxb774wOPlFmvjGql+0yGSYyhCfwYlcCF7BdwpldH9cyqgFW/L3MoKSwV740zIdxLqjL36/70MCteyi4iKJzH5n1pTWSpLK6UACjZ2YFZumIxtLcHoLHl0r9my8AaWNCMtUnKbunCtqBYO7T/N3X98t16FLy3o846wkZOdUDgzYkL2TSqRKo2i3N+3igClh911uyKkNyt2/VXwKvZKdlyRmHqR5JkznEfo1nNPqnkfvwMcQ5fGppYfnTqijGOvmKi5kxIK85jxghFzUx8I1bBHCEjesk1RIQScGU1A5SBEwE4SsK0KKLxIw7opQIc+lh9f1JXhQfGY3hy0YxVOzfEUEUAadb4AaZ/IKUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199015)(66946007)(478600001)(6486002)(186003)(2616005)(31686004)(54906003)(36756003)(8936002)(66556008)(2906002)(6916009)(53546011)(66476007)(6506007)(6666004)(316002)(4326008)(38100700002)(86362001)(31696002)(6512007)(8676002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtLQ29Xa1BnRkY3cTFiUXBtaWZ2NE9FdS9xQzFuc3hQN05wa0hHNC9ONEl4?=
 =?utf-8?B?SVFKcXcyalphbHByc21QZitpalQ2WDNDVW9RNWNiUGg3VnFhWC93bmVsdVVE?=
 =?utf-8?B?eVBQM1l0NVp5YW4yMFVaY2wzWEg1NnduR1c1d1pFT2l6MHFmYWJ5TnJ4YjJ5?=
 =?utf-8?B?Q2VxaUdZT2lCbS9wUThtV0h6UjJOQUdBc0RNOGsxZ1FzbXNpR0MyMmQrQ24w?=
 =?utf-8?B?d1drTXlPYWxLeFpiWUc1Sys0QlZhV0ljVUFQNnFqU0Nkdi9qV0ZRVVJyY1ZM?=
 =?utf-8?B?a1NCdDBBakxwcy9INWhTWmJQZXhIWEtXK0tGMXp2Y1FLMWR1R2tYb2ZPbkF2?=
 =?utf-8?B?RXZlVmVySk9ibk5IakFMYTdWVmVJckowcDZ2YU9OY1E4RVZvYVpoRkRaUkZE?=
 =?utf-8?B?ZVBubGJjalc4MlVZN3I4eE5odDl5UTRnSzVTRjNESDQ5aks1U1VwQ1pXZE03?=
 =?utf-8?B?c2ttOThTMkFSd05ISzZncm5STTZsSWl0aHhnNWt6TkYrUjVQQzhqRmc0S2sz?=
 =?utf-8?B?QWg4SDR4bFQ4S0FMR09LZmpKMlgyUW0yTmZvUVg2U1c3a0taL0p1SG93MW9Y?=
 =?utf-8?B?cXlDQll3T2xqTmJKbUNhUGI4RmRpR1BoRXV2SWZtcU9GVDVmdWd4NjZOeEVO?=
 =?utf-8?B?UTlZbFJZajkyajR5OWpvL2ZPYVJYcmExcVgzdW5wU2JDMXczM0JDQkZUK2lk?=
 =?utf-8?B?cDZkbGdXMzJQTXkvV3FJOGVjanVnNmFNSGpXV0VsNmxHb0ZnU0pmaVdCTDhw?=
 =?utf-8?B?clEyRTk2eWxEY3MwYkZlaUVEVkRGYjlGeGxNMWNLNStWYjE0L2tzMVBPMmx5?=
 =?utf-8?B?a25qV08rdVRZUDZRTjl0WDlaSW5HdGtJdHdvcjgvMGxQM3RTL3I5L2JFeERh?=
 =?utf-8?B?YTdGMU5zSThqeVdtdWl5Wjd1R2RpZjh3Y01uQnpZdUdXV1VIN21rYjBWUmw5?=
 =?utf-8?B?V1I0SFRMR1JaZi9qbWttZklvVGhoYm82RGxjcUE2NGFZbVZ0Vk9GQU1ScHBl?=
 =?utf-8?B?RWZsMUpzdWNjSGVPQlV0aEg1T2Z5TkJTSWxVcVYrazg1TkdSRHVSdVdGV2JP?=
 =?utf-8?B?RDE3RDdTTm1CUlUzN1ZjSFZWd1JrVGl3ek9FU3dDSmhpN3h5WFk2N3hPQldv?=
 =?utf-8?B?MG03Slo1elBhd3BoR0NCaU9BdEkxVmRKN3RERXNwVWJjZGxIcENNVm8zQlpY?=
 =?utf-8?B?NjdhRVdZTkhpQW80SGlTMitSRlFwZytYQkdndVcrU21JU1ZEdVFoVXBnZUow?=
 =?utf-8?B?QU93c3oyOGc0Q1hWdDFSTmNRZnBPQkJNTWRQaTEwTW83eVJ2dHhPOStGaXBr?=
 =?utf-8?B?OHhSVGI4WElqZW9Ob3B4SVhSZkorQzFMSXNPYitHQUg0MlFheTdRWjNxWDhD?=
 =?utf-8?B?THVaekRUekJCTVM1QkdaOVVxNDFwUWp1d3pNcy9icGVrMDRFUTAvK25ldjZw?=
 =?utf-8?B?Y2dXdm9xUkNpUm5UaEk4MHpNZlp2aGNnSEprN1NiMkoyUTRFbUZQcVRtc0tN?=
 =?utf-8?B?OHRHeUpiN0V6bCsrbWtsTEtHWWVSMmtnVG1FUEpzTVV5UFVPWXhZL1pFNmNS?=
 =?utf-8?B?Q1lBU1h3L0NhTUw5WEYveWU2WXFsU3NKRnVXeXQyMzNZZ3JTVUI0a2JlWDBm?=
 =?utf-8?B?RkFnM2VIYXRna3FKSVFJSnZ0SkswdkVlYXg1Wlp6Z20wR2E3TE56cGpzNWpG?=
 =?utf-8?B?SFVkb1RzNlFwWDNSc0EwL0d3amptTkhmWm94UW0xTGNCZW1OTkd3V2QwdzNJ?=
 =?utf-8?B?UHRYbGw0d2hPYm9iSisyWDY2WGpUN2xGVUlheWRFb2JPU1pMTHBRK1hqRFJ6?=
 =?utf-8?B?SjdpQzMzY2pQQ2ZlNGF2Q3pLMUFIM0NRQThMMXlkZUc0ZVZJb1JxVWgxQUNZ?=
 =?utf-8?B?Q0lJK0ZwY1FmK3d5TVdkdkpOaHFGTjhZcngwSGd1Wit3dWkzYU5ETlhCdXR2?=
 =?utf-8?B?QWlSV3l1YkxjbGs3VG94cUNmc1NFbFZmUXhMbEhpbWZMUmoyU3o3b2xFQnh1?=
 =?utf-8?B?VG9wdWtDY1JNKzVXamgvRXJhZE9VYXZaSVVxT29neXo2RWdPWGpmQ2ZlTDZa?=
 =?utf-8?B?WlpDODBkMkJWd3JMRk9xT0N0Z2x0MUQ1TW42eENqaUtyaGVPeHB2cEMwcEVu?=
 =?utf-8?Q?pm0ihhHwBJa8VQEYrH+P61utT?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b69989-2381-433e-74cd-08daab9df809
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:33:38.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YCsHTeW4jb+/nybpfDAMJHfYL3Bzh1AxLnykLK3WHnxWfrPZphH69QyevV19Cy4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3899
X-Proofpoint-GUID: TqGHxaQlNtalQrJ3tS6X1c7sH49cRyhm
X-Proofpoint-ORIG-GUID: TqGHxaQlNtalQrJ3tS6X1c7sH49cRyhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On 10/11/22 6:45 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 10, 2022 at 10:57:24PM -0700, Yonghong Song escreveu:
>> On 10/10/22 1:19 PM, Arnaldo Carvalho de Melo wrote:
>>>> +++ b/btf_encoder.c
>>>> @@ -593,6 +593,19 @@ static int32_t btf_encoder__add_func_param(struct btf_encoder *encoder, const ch
>>>>    	}
>>>>    }
>>>> +static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
>>>> +{
>>>> +	if (tag_type == 0)
>>>> +		return 0;
>>>> +
>>>> +	if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
>>
>> Why we need tag_type == encoder->cu->unspecified_type.type?
>> Should we unconditionally convert an unspecified_type to btf type id 0?
> 
> right, that is what is being done on that line, see,
> DW_TAG_unspecified_type isn't some constant, what we have as the type in
> functions in DWARF is the ID for that DW_TAG_unspecified_type for that
> specific CU, see:
> 
>           <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
>              <d>   DW_AT_stmt_list   : 0
>              <11>   DW_AT_low_pc      : 0
>              <19>   DW_AT_high_pc     : 19
>              <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
>              <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
>              <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
>              <26>   DW_AT_language    : 32769  (MIPS assembler)
>           <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
>              <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
>              <2d>   DW_AT_external    : 1
>              <2d>   DW_AT_type        : <0x37>
>              <2e>   DW_AT_low_pc      : 0
>              <36>   DW_AT_high_pc     : 19
>           <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
>           <1><38>: Abbrev Number: 0
> 
> Look at the info for entry_ibpb, there is no DW_TAG_unspecified_type
> there, what it has is 0x37 as its type. We have to go see what that type
> is, it could be DW_TAG_pointer_type with a DW_AT_type pointing to the
> real type (or a series of references via DW_TAG_const_type,
> DW_TAG_volatile_type, etc).
> 
> So in the DWARF loader we record if we have a DW_TAG_unspecified_type in
> the current CU and what is its "small id", which won't be 0x37, as we
> use an array for types, to compress the ID space.
> 
> Then, at the btf_encoding phase we look at functions type, and if it
> matches the DW_TAG_unspecified_type type for that specific CU, then we
> convert it to void.

Thanks for explanation. Now I understand.

encoder->cu->unspecified_type.tag indicates that at cu level, we have an
unspecified type.

encoder->cu->unspecified_type.type records the unspecified_type 
small_id. I assume this should be okay since compiler did dedup
within the cu so we should have only one unspecified type per cu.

tag_type == encoder->cu->unspecified_type.type ensures the
current btf type should expect the unspecified type before it
can be considered as an unspecified type.

Acked-by: Yonghong Song <yhs@fb.com>

> 
> - Arnaldo
>   
>>>> +		// No provision for encoding this, turn it into void.
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	return type_id_off + tag_type;
>>>> +}
>>>> +
>>>>    static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, uint32_t type_id_off)
>>>>    {
>>>>    	struct btf *btf = encoder->btf;
>>>> @@ -603,7 +616,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
>>>>    	/* add btf_type for func_proto */
>>>>    	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>>>> -	type_id = ftype->tag.type == 0 ? 0 : type_id_off + ftype->tag.type;
>>>> +	type_id = btf_encoder__tag_type(encoder, type_id_off, ftype->tag.type);
>>>>    	id = btf__add_func_proto(btf, type_id);
>>>>    	if (id > 0) {
>>>> @@ -966,6 +979,15 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>>>>    		return btf_encoder__add_enum_type(encoder, tag, conf_load);
>>>>    	case DW_TAG_subroutine_type:
>>>>    		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
>>>> +        case DW_TAG_unspecified_type:
>>>> +		/* Just don't encode this for now, converting anything with this type to void (0) instead.
>>>> +		 *
>>>> +		 * If we end up needing to encode this, one possible hack is to do as follows, as "const void".
>>>> +		 *
>>>> +		 * Returning zero means we skipped encoding a DWARF type.
>>>> +		 */
>>>> +               // btf_encoder__add_ref_type(encoder, BTF_KIND_CONST, 0, NULL, false);
>>>> +               return 0;
>>>>    	default:
>>>>    		fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\n",
>>>>    			dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
>>>> @@ -1487,7 +1509,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>>>    {
>>>>    	uint32_t type_id_off = btf__type_cnt(encoder->btf) - 1;
>>>>    	struct llvm_annotation *annot;
>>>> -	int btf_type_id, tag_type_id;
>>>> +	int btf_type_id, tag_type_id, skipped_types = 0;
>>>>    	uint32_t core_id;
>>>>    	struct function *fn;
>>>>    	struct tag *pos;
>>>> @@ -1510,8 +1532,13 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>>>    	cu__for_each_type(cu, core_id, pos) {
>>>>    		btf_type_id = btf_encoder__encode_tag(encoder, pos, type_id_off, conf_load);
>>>> +		if (btf_type_id == 0) {
>>>> +			++skipped_types;
>>>> +			continue;
>>>> +		}
>>>> +
>>>>    		if (btf_type_id < 0 ||
>>>> -		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
>>>> +		    tag__check_id_drift(pos, core_id, btf_type_id + skipped_types, type_id_off)) {
>>>>    			err = -1;
>>>>    			goto out;
>>>>    		}
>>>
> 
