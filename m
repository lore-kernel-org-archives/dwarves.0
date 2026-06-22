Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2219D092;
	Mon, 22 Jun 2026 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155019; cv=fail; b=uS95XULMwqJmBMPqOBhAjFatkP+iwDOoxuJO7TfIYZyXrq5PQRW3BzgzusYkaLbGhHDgWNAr2VEi6O6zGgpSjcMmJ6AKel5v9osHkLAgY3cZ4eW93rgpLpedwF8QoclzZsvYxEtF3hFsytVbrgYe/lPnkoCqJUEus91Cya67k9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155019; c=relaxed/simple;
	bh=HLVpqIKu6Suwb3lnpoepwiBF9mwxkGZ2hb93IoVUFtE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FvFx/Bu7SXBahGfFhxjiDl9h/i53QVeUILydHtDILuZZP6M8mBybJVeztNVchxHE45IbsBvEF/SGSCCHhSdo0iPDSR91P9k8ILx0SkC7EzPFV9TbMcIrlpE/v5pOEmHTCsSD1u8t8DPtvVlaWr+FYBB4yUD8C9uZhK0ypSd2myA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U/4OXIy6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PaLQ2heA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U/4OXIy6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PaLQ2heA"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MEKFoB1827094;
	Mon, 22 Jun 2026 19:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AJ65hy6HVoqkp+veDCJ3Id8IaMPcMfU4VO70eq7exJY=; b=
	U/4OXIy69/+3x8/bEAQvIqipiY4jpiQQGAzGrTe+IAQdiK9lDNrG9U/ly3Mu5N+Z
	XFL0yytIu90hqw4k0sTfNp2dMUM6EBOCBS5KApJuQ+HX8OpkIyQgNfNoDtvzkUqv
	BSDMgm+rdl08mcXMElUkddRDnwT6WUiKqTDI4TQWC3wQyyqDKQcVHCXBZ37vS7WG
	H7pjdRj3o0m6OUPkkdV+HUsCf5z7LrbjYD76cJTN62E7peDygXxWf3YdXLDtn+Nh
	zix33x6gr5mgI6KQBlSQC117Xpk7rmbmxn6hidv8BMKQZJ+B8Ah5U7K+VI4xNyao
	9FU5QCpNs6UXll0qpIElQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhf1jkk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 19:03:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65MIwXw2026206;
	Mon, 22 Jun 2026 19:03:31 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhap37h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 19:03:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHV+g23+2gDF64uaazV2NQl7ZlX1Y3N71Bn5pk2JIFCUUE0otGAVs+jPKzcJvP1ht8c9m9n3kTjau3OmnybdPNM0jUQbdQBYG7caHBb7f1aIJRPXnZ2IjS7EeasIemCdtKpgZZzm2uvNwQBwN8fxPVLXyAwAHcvsnT3emJ40bDckY+1uv0OFhPCR+m0VNlSKl8eUq4XyI9KQsPiI7heRlE2jOb6cXzNRylHiI+3ns0yD3n3F4P3+TVlso7bgibyEELqLR3bQkEunnu4jEvzLJ0/lojrWpl+JgYhZ4+oavqiRnMsblM5Mgw0h8VrJ1XQ7hxHP1OT0bsBzGKuS8TkJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ65hy6HVoqkp+veDCJ3Id8IaMPcMfU4VO70eq7exJY=;
 b=nEokRUX7m1ldx1DgpGGHo5dVUgaiPKeBq8VoroCepHkaJ9aC+bmGQT76emcZdDKVNMr95Aiir2gyj5d89wLZySE/sMuf5mcfofk4lCU6Tw7dplMk1znvIiNNSF2z3YbtwB+8rDqMqXqnplQ35oRwMPVs4b5/+V0/salxTzvPxLeYOgkaCn/2t8DnIERdDpn3HJp8IF5X/5TnKP8UiUVsY1UenRXPEcPkK5AM29GI7UR0yd9IfdIvdcxuRGBbnjX/AMIQOOR/CROVGV40c50kRVu2JttZr+PFwB46gZB8Y7B6HMON0l1JTMra1/Jrt30RU3XDNqM2itKrX+YXJQDqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ65hy6HVoqkp+veDCJ3Id8IaMPcMfU4VO70eq7exJY=;
 b=PaLQ2heAerie7goEtWXU4340ru4KQEG7mETIqH3HOmBRFG9zEi7anBpSUACagvcF894Ssp/bDEalTgtNqjsANMrDRtDkqSisEYS01+oyc2LavWiDyqYZmpH+ctDbHO9FwxzhKoCuOYhdCgplX9KxAcx/qcdp3qUVhCNdF5cu61w=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ0PR10MB4735.namprd10.prod.outlook.com (2603:10b6:a03:2d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 19:03:28 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 19:03:28 +0000
Message-ID: <ab92c03c-f0af-45fb-8334-b156644056c1@oracle.com>
Date: Mon, 22 Jun 2026 20:03:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PAHOLE v5 0/5] support for DW_TAG_GNU_annotation and fixes
To: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, acme@kernel.org,
        Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
        David Faust <david.faust@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <663c926a-09f2-4239-bbe9-078bbf900822@oracle.com>
 <ee92e842-85d8-4b1a-a741-4b6067895223@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ee92e842-85d8-4b1a-a741-4b6067895223@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0281.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::14) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ0PR10MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b20a83-8ba2-4982-0752-08ded090f179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IVU73SwQJ5Xjkcjnjn5ElfuDMOcWVYQXjsk3Odu8Ugv/A/iBvQEMDkDNLTU/LprIPPRo5GiAUPZOZdh2Gs6m81K1PYOE9SZVTBc2An3IzEImVT8dNnAzzU/TS10CFttljNvNukiIbop9dyti901AkSBK0Cpz4jpUoWyMsIo5eTRpFFwfQb10dgxIjGaCJwtqX63wRZD2o0QpWu1wv/JKl+DbA8EDbVFRKgJ5QuT65JiQZ7Brf1nBPhldfR0RJBtujgOii09VdPKsjme+Z0SYFJ72adQ28KwNmCuOXNigro01YOv8+3k7jxQgFmlZE/dLmBabyAqHFoJuHaLX+zrl3FsNAevwxw2Yhk2C4MqUhnmeL8gLniq2/PBCOLG30CRIB7yntXVsE6p3R6wOej+/XGtXSMsVgerxsH0nbOSbGhbgSgTHzZsUSbKipNYPeHpXtrn71qwLndjSIhFcVCEKB6xfgUJ9sUZnxGPI1LLu9mPziyjSVqOM8sAAEH4XcvOQfP769Wb2obcu7VMLCQxSedVHUgj3bm6HjRhJQQf+GsOyJm/RogaPMqSyRnY0/1THF9GDvBlFDfOmL+O3/JdjFSLr/TfzMn6nrzrdkewIOw4Q3E640X3TYvaCN5jUxqZ9XsK6K4UtFs62vZKsUQVW+CXE33QBgWsQ+AHEmzBlmFw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC8veVR3a3FYZFBmTForOG05TWtwOStHR3dLYlhwY3I2MUptSmoyZFRJVVRS?=
 =?utf-8?B?cGJBazNCNDMrVHhGb3hPeUdjQ2hYdFFNcWdHSTBxbmt5RVhqQ0JNeVo2WGVL?=
 =?utf-8?B?RlNGMEZhZGdEWkNLNlZZVE12dFRlT1NJY1lHYWRBR1ZsSFErK3l6K3c2TUFM?=
 =?utf-8?B?U2J2RjBmMFZjRHA5TUhKNDJjaERiRXJGaGV4QWxOMlhqc1lWZmx1RGN5Y2pF?=
 =?utf-8?B?cDhkUXhpOERvWmZoekltSzFIMGZEam4wU2hiTForOXFTaEpTMkY5T3BBV0Iw?=
 =?utf-8?B?dHBseW9MUkp6VDk0VXU3WldjN3JWNVdRVFRBUUt0Rjd0NUc5aVhaS2lVbEty?=
 =?utf-8?B?L3lWQTRnVDA0QTBMUFlDSU9LVUUvc2FSZFhQRFdQZGxHV2U0SUF1N3hvRzlL?=
 =?utf-8?B?a0EwZzBMRFY5ODlFbHpMRUZodFVZU2x1N1UvV3NzRDJyWDFwVkdUQ2twRi9v?=
 =?utf-8?B?TDcrdFgyREp0dDFoeGF0UkpuSGdFMmlZektUc1gvR01EOGw5blp0RmUxenhG?=
 =?utf-8?B?eHJJNlUyM3dBeWExTFlhcit5ckdZeHVvOUZoV1BWb2NMQmFnbmtMamRrQ1Fu?=
 =?utf-8?B?Rm9ZMXI3Zm9Cazh2a1pvMVcxaSticmRsenZhU25RWlkwd2JJQUZod1dRa3hI?=
 =?utf-8?B?MkE1aHB5S0J0amxoYXR4bjNpS0RtUW82Uk5xa3FHVlVnM2o0ZkZkc25QYUx3?=
 =?utf-8?B?TzIwVDErWHVtSGlsL3A2ZllyVmtVRDUvSi92Qis5NjBlN3U4SE9uVjVnSkRx?=
 =?utf-8?B?SjhJWVVmNy9ZNXVkNWswZEdlMzJqbkxsRmFSUm0vODRaNjdITk9MNU1wc1dC?=
 =?utf-8?B?SHJpZkJlM0hpK3NJclRLUk85SmpvbXhwdkR6ZFBvL3FjZ0VBc1F6U1VzRHFr?=
 =?utf-8?B?RGM3Z2R6UG84Y2wxbkhRalBQZW1JRWJDeCtmUWFVdTVXMEwxejQvZXlneFRz?=
 =?utf-8?B?bHRibm9GYXFnK0FEZ0tJYjRQSlp3czJtTDJxMjhvbEIwM0JVTU94bjVCNDhZ?=
 =?utf-8?B?VlJqcStYTm5YMEl4UmpwQ1VQQmRZTitSeUR2ZlZOa0liZDVxWHZ2c3RMY1pp?=
 =?utf-8?B?dXJLbk9ONDNkb0pueFRFNVFld3NuTHFYeWJwMHJwOXNCN3RKOGdLK0hhUTVu?=
 =?utf-8?B?bzdKOWVUU1V0d3JGelNxVHpHUWs4NGRuTHFWMlllMVpzTldabFlXUmo5L0RW?=
 =?utf-8?B?N3M5MmFkTlNLOTJHYkVhNEJqTXBHQkhtdzIzd2JHTXJLbmlrYUZLeTNjM1Ax?=
 =?utf-8?B?d0ZaSDBkaHNOUFp4UXdyRUo4N0kvVzhsUWZKUjZTVzIvWWwzZ2VjRU9tYUJN?=
 =?utf-8?B?aG1tUzBud0RKcXg3RnBCZ1JxZlVQdVpnZGh0RHlER3prWGdnK3NtYjY1ZUlr?=
 =?utf-8?B?d0llcTFSZjQzNFpXSFBQU3g0RnQ5UHpXR2JEY1pkeU0wTGQwaDdRaFRESUUy?=
 =?utf-8?B?YzNuYjMzZzI1L0sybUp4cjFrQUx4U2xqdjFDbjd5dDNpS1BhM3k2eHBlajgz?=
 =?utf-8?B?QUppUExNRnpDTlJuY3UrRmxLOHhYaXBsNVVFcHNxSzg1Y2krMDQ0SXpBTVNj?=
 =?utf-8?B?aWY0TEY1T1JyMEI3TXdoRnl5dUJQbzJ5VTFoQ2MzdDZIVnl5OFc4aThrTEQx?=
 =?utf-8?B?SlBNNkdWLzhza3VUK0EwWU9tSVFZWDdhdHVlNzVINk82S0U1ZThnS0xGc3B2?=
 =?utf-8?B?bzBDazlKcDVzRlowcEZVM1pKcGJQVVlIQlFJbEV0ZXFkVDZ5U2k0bGRVdzMv?=
 =?utf-8?B?bmpsK3pkcmhzR1RVa3o4WTZFNlRsMzgyaUM0ZmFFOUJLOFRUMjVVbk9BYzhq?=
 =?utf-8?B?S1FYalBlZmVUbkQ2S1g4ZndmTDFSZFNCcVAyMERpSWlVWGNvWTZYZFd5NVl2?=
 =?utf-8?B?clNHd2toMGl0OHdYc2llZGppQ0V3K3dyY0FnSnZWMy9HQVlWaEpqemcvSFFQ?=
 =?utf-8?B?NGlJdVY2SGIzMTBCU2JYZEp6UVpWWXV0MnF1cGM0UzI4eFBGaHBkWkY1YUNr?=
 =?utf-8?B?Y0lnd2ZmS1g5bzdpTE1ZaDI4SDJFdVhpMmNUeCt5VTFYL21NU0NRSG5CTDBO?=
 =?utf-8?B?MVZrTnJJMEdOR1Y5T1ZhQlBmZWhYRFZRKzRGK0F1dTBOYXVFaTlkL2g3UGt4?=
 =?utf-8?B?YnNyTi9ENjYzRjlUQVhCL0I2cVNmdk12eEI4VDRMVStsV3VWVDJpUENzd2ps?=
 =?utf-8?B?ak95aVZ4bWkwbzFqWW4zOEVwcW4zUURIOCtOOUJxL2NBbmNzb2hxM09QNFJJ?=
 =?utf-8?B?MWZBUUxaRWVmTEVwakl2eDJxQzNEQTNTdVBpNU13L1pVMHlNeTRJczJEZyt2?=
 =?utf-8?B?dmtJUFA4cXM5cUUzcG1Wc05iYnJUa3ZMeVhRWjVzTTVhR2FDUnBmUT09?=
X-Exchange-RoutingPolicyChecked:
	V4gS+REz0B9SP7/ZrFpxt2yJhxTX6KyxfeIPj8fu68gvVyEiw46zK6AyDuPDugjhaqpRvpPEwja7sgPdfbOtAYuBtknoqhapRdmPCu4ZWEXJma1x4G5nuBH2E9b0WyzC/yrNcoYakFU/FLOMbVEkZymd+9bSFMnEHDJiAw05b5zXHBmWdr1ZtzelPeK6W7Kg2fgRtxjWNF+78AMYytjaXOsscHTdOh8max7MdoM3ez5CqY97gBhFng2u3o7GYoythA2xRkxENCrx6mJibouMpf5aJxyEK6CYlhEiB4hosZEdmHYjkAZh6NJw63JjgggVGQJV0p5QX3fEw/EQy2imQQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nFPp7QbBz8LC4I/Q2iUtM3obeR4HEyPqhpGzDDiJ+Ok6tvzKdNwGR2WJLNRFZZw5cj6i7e7SdcqsvwiIsbQTSwIYAVUTDxNifc0gi8MEAsJqSWH1mOqVaIqbRyQTst03NtuSDEOR5CHq+1xo3X0Sv1AIbldZlcW4gC5FsFnstOelVdG8ofOcxJ9y6wvj6Vy+5dptnGw11rDtGe15JkErZ1HVmse4obwT7r+csT9pLEhFYClNmnPDfEbUUV8k7k51aoy5dNaU+wvXD8/Gz7uwc7LhyJPvxm6fr5+b6hXEJ9S7RJZTEnFBX7O0/BGYgkFhkRzfUbKX4iDWy9wCLMt1JzmX3v14RT62MkKkUsN5afJpHhCb4HjTiwpY/FQ7S5YS3LO86yp1EjV0I6Q1QBYAFRg2u9CtuhefZdjehq2qiSIkiREufRcnyVzyoH25r4Q4NwTFkZDSINvoUHTkOxHgJTEOGWTKUc4pCl+JOTcZy2N8FSfiACbqK8IV9zvAIC9I8lRUOmNs1SqdIHuB+8Vrll+Jc3entlGhfguDYkOvZMCvnljIvuypvyRzHFo7tdX2+h1ipvW7RVHQk3+cVhrnknWI4puM0N/zJwi63MXslsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b20a83-8ba2-4982-0752-08ded090f179
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:03:27.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocrdw7s4EMgByRTYNc6lLhI/MSE0RAzDywLHFN9UC/pDqyA+7+QW2d/zI2RDPp4ulTT2o2npZmyiDIz/VbaZmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606220185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4NSBTYWx0ZWRfX66hjSnquo08V
 u0cphl/JA8thR4E8jX+HeHgdfqrYkezmtN1py/0tM3j85xTQC/jIsnSzLEVFQA7xhuwE26tB9aF
 gdIoDQgCghAZyxUHhNXIYkF758IviaVDxp43kaK1rUCNkWWm4MjLwP0G5Qpvu1ayLNgpNUTGfTY
 mGNEo8NDhJRI/H/Xy8Jwz3eQfVL2DqDzq1fy04RQFP12OfS6lZNmztBx44r2BAgUq18FA6CGTO6
 +pkCu6mtaXSSPRrQRdiE2u0Tnq/xFVezu0ZCVljUUCPMeQv9z81XfT5G2KXB5kDaeI2NQnkAcO/
 xt17vntYwnS4IG41T0ejElT76ntSwz0IG3GnQ7CwTiBGGoOXj+vDC9NZSFEQzxktiIjLiVO/wtd
 avEp0hWNvGnmTs/hjNU27B0fmhfu4UmjTn03/mHkWAk7A68YnZscOtFo5zYqLgG/6aQouVJt96o
 G4LxZXWz+TAXE2pz1SsHl2RBhA9h+fLNvBFO+VBE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4NSBTYWx0ZWRfX+c8uKYnF/vl4
 fXjGmler4Q6F8Jug2jcF+mv5L8nHUkSV0aUUgldXLv54uf1IHpF2n+YQYkKJHWxK0Y3OXLXWroY
 mJb+FXfa0RtFatiSXgdXfT3D1ALlBNyQyBEhbY4bSmvDnzKJwBGt
X-Proofpoint-ORIG-GUID: -uJS-AxPRbk2F45JYnIXziS7kXJy9Ux3
X-Proofpoint-GUID: -uJS-AxPRbk2F45JYnIXziS7kXJy9Ux3
X-Authority-Analysis: v=2.4 cv=A+lc+aWG c=1 sm=1 tr=0 ts=6a398704 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=g3PmuT7LnmilZ1xaMz4A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313

On 20/06/2026 00:18, Vineet Gupta wrote:
> Hi Alan,
> 
> On 6/19/26 05:17, Alan Maguire wrote:
>> On 18/06/2026 01:57, Vineet Gupta wrote:
>>> Hi,
>>>
>>> This series handles gcc generated DW_TAG_GNU_annotation with the end
>>> goal to finally enable CONFIG_PAHOLE_HAS_BTF_TAG for gcc kerenel builds.
>>>
>>> Patches 1/5 and 5/5 are newly introduced in v5 per Alan's ask.
>>>
>>> P.S.: I've optimistically included Reviewed-by/Acked-by from Emil and
>>> Yonghong respectively on v4 [4] but those were before additional changes
>>> in v5 from Alan for a few things. Please let me know if that's no longer
>>> true.
>>>
>>> [4] https://lore.kernel.org/bpf/20260602195512.1511013-1-vineet.gupta@linux.dev/
>>>
>> series applied, along with CI change to support [1]. Thank you!
> 
> Thanks for quickly merging this. I now need to plumb this thru on the kernel side to essentially enable CONFIG_PAHOLE_HAS_BTF_TAG for gcc but that would need to be keyed off of a pahole release version. Is pahole due for a release (cadence and/or this changeset). If not I can speculative use the next version whenever that happens. There are other things in flight as well (gcc fix after 16.1) so this is not super urgent but will be good to get out of the way.
> 

hi Vineet, we will likely spin a 1.32 soon. I'm hoping to get Yonghong's true signature work
in, and my inline stuff is close (but is now rebuilt to use some of the true signature changes
so is gated on it), but we don't strictly need to wait on the inline work landing.

Given PTO etc I would say we could aim for a 1.32 release in mid-July; does that work from your
side? Thanks!

Alan
