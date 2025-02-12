Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D025A622;
	Wed, 12 Feb 2025 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383054; cv=fail; b=BIZGu1/f0dcRGNzi35ujeU4T0bRMIPoIsftcMjKFztCIDhz4MqBg3Hmatj0pRAWTbUP/XIOECRtxE2Wtfq1FuyrkMgSgR2H585Ud6uJCoPxKSEzvV4tdLUe5hsS1z8pamII7/IpRiRVmhPlAwb23/Ha6hUieR5rAXu5uM7xZxUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383054; c=relaxed/simple;
	bh=9a6Hbkavlbr4TFc+BmjcOZgjHAV5mM7TOgatahttwv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pCW9gvrYeNrvYjB6X+OFUjczExfTmDqFm24kw2On9R2H/rUjkoI6aSbAqOydaFAbZtl4B2bK7xQt9plyPTE2KDPo++b2EzDZooNMt0e0BVApD61wFwoLiNHeqABCjqO/a0072rl6hwULBboXwYpufA8JWCc5DDw0ghwiFWYAbis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YZGAiOVc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CDPhyxrO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZGAiOVc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CDPhyxrO"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEtaQL008437;
	Wed, 12 Feb 2025 17:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rAh0wcYaaC5bph9BO+tPjIQ0mR/siaGbhg2phFZryIs=; b=
	YZGAiOVcy+ab6ycV4g5LaAZZfyPMniPx133hxEpk5Jv6XbWRZhL/NPuw6xVKZ0Yp
	JpI8yq9uLkuVD9mnX7p7yFDDHQrcOcmXBjrU3MglEJcQwrSBv0zq8whyP1DuL71I
	5+Xne/kdAL/sGmQf4APMTLGtv6EvLArQSe9/SprDqyxiHIm/qvJ9Jms2z7Ulpgqf
	SRC34GkmTBYyeXZJkfN0m3pZU1/sA9H6FDRMz30zbh1tveOIzn0mfbW0GYREO+3c
	IYwgNLBjdr6O1FlnW3D41QNx5ShMfQ50Hbj8Ic47C5TWYgBfTUtBxlWgUgfUJ/3A
	muYoDLuR+3cysZu7j1wscw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t47x8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 17:57:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CGqcck002296;
	Wed, 12 Feb 2025 17:57:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqh5exa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 17:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmalNTnblDUVfznrl9QwSGLdEnUwAX7jsO4PyiAjEpvJ6td/MhJkZF7VytVF1wZCUzlRTpULEfy6lJVnsC1RdUTazjSYc+HYpntZyjVg9mf20/Xpk4G3u5vl4w2KYUWO37eWOWQvCQwEQGcnkETADYoXTV7v80ETf6z6KtJfIGFyBylJHNSnmbSaKo/kmQc1TtiBx1PzXAh1AEqh+xm43OycB3vXKzK+EijUroKlowRKRRRQfvk2GydWc0Td0ObU0DKo1t+poIWh/zj5zWb4kCHyGOEp9q0STQlZxwl6URTstnWI5L7DqKCjHnGflfL997s5fHuzjXMtM0HLMGbYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAh0wcYaaC5bph9BO+tPjIQ0mR/siaGbhg2phFZryIs=;
 b=oLiFM1Gfck0DaeelKBL7WSzmD9DolpYOg0n9/nk8s/zeockwJURTGo8AVrv76K7qAQARlX5bE/X3YCLbSKXJkYLNn2JWuJ2zd5VcQ9174THlMoHxlH9wDS1ckGpxYLUXYnRmpoPuKmP+OMMj9lDfmLZXU8mTTEGMl3DLLd1HprOWhwfqA7rOIIRcA28NyRqo4Pw3e4JlFtD6UoTgCWrfOdH/PzAWcvnxkag/iR9Dkvm4QiOpv7mTTSZeIENQXwRpO/MiyEvDAgwC8t45JWxZNRPJ9SfGPpCeZlh5ltWm8MBvDikO6UZuDrwSOAm6RH6Cl1pxbHBSnwfycrw/+6fRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAh0wcYaaC5bph9BO+tPjIQ0mR/siaGbhg2phFZryIs=;
 b=CDPhyxrOaPwjvzjs1Zthf+CYzLpHa4J9A9VrKR1KEwxmpuRYxzF2uekba+68jLAdJlSD5VsK9kVgNiQPVBHDOKCEFYsLOcNJwrDM6CR3EhMxXtE2DagDuyg7+zkFUdFPe8GymDo6P1Q8CjbL6ErTLkx0l4y5P0mFk41vyJ3FEpQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB6745.namprd10.prod.outlook.com (2603:10b6:208:43f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 17:57:24 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 17:57:24 +0000
Message-ID: <dd0c1d4f-73ff-4da0-9b5c-43b0aa982729@oracle.com>
Date: Wed, 12 Feb 2025 17:57:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btf_encoder: don't encode duplicate variables
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
 <20250212005003.1413091-4-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250212005003.1413091-4-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0018.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: e91df100-680f-4236-76a0-08dd4b8eb4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVVuMlZidnRQV1hpNDNkcUcxWmc2bzVJdW9UM2g0RUNlYlNaa0tTTVdyZEJ5?=
 =?utf-8?B?K0NEOUtoS3ViK2NuRFlFUllXQ2txYjhVY1VnZnJVcDA0cVI4czIxeVI3OW9k?=
 =?utf-8?B?c0JyYmlVM3pvUkJpd0ZNTTRnM2Nheklua0VSL293dlZLZThvV2t3SVpDMmlk?=
 =?utf-8?B?VTNxS0g3dUxKNmJRTkFoSHExOEs0R3FTWnpUWk01ZisreDEwdEJ4WVYvTVhS?=
 =?utf-8?B?OUtIdVhDMnFKa08xVkJPcC9yVWIyQUxBaDE5aVJCUFIrSFMxeENLWUR6NXJD?=
 =?utf-8?B?ZUJTRGk1MEw5NGpJd1RKMFY3R0VTaEV2TzF4ZkVuRGJwbzBYVWc5b1pNZlJB?=
 =?utf-8?B?cTNZTDduRHk3TkQvNzY2RVlVUUxWUFg5clA5SzF2Sm12dkhjVnVJUW4vRFQy?=
 =?utf-8?B?V2t2TGtxdWlPTEk4NlFKM0U3Z1ZBZTFGNWcrR2VQUkZlSUYxRzZnZXFSalJL?=
 =?utf-8?B?VEsxbGdWRXVPcmUxMWttQkdxNVg0UFB2SVFacnlNQVpGM0x3T1lvYkdqcnBR?=
 =?utf-8?B?akFBU1p4M2NpNm1RaFgxT2tnUXk4bUFLUmdoTWRMdlZrLzVZV0dYaytDUEY3?=
 =?utf-8?B?NnoxbVlPaGpqaXluQTNiTHdHY2R0Y1Y5YVpaamd6M3J6RGpLbFFacjVoWjJG?=
 =?utf-8?B?VW9ZeGpNc1VtTDcxWUFaN0drVC9NOVV2TThWTmFFcWNCeVpsQVVXNldBaXRC?=
 =?utf-8?B?TUVOUVJKbVdkL3hsdW9ISjZxWmxYcitsTldjU01GODRNa2NrZzl5UldraVlk?=
 =?utf-8?B?UFZEa2swaEk2T0kxQ1crRGNoYmNxbjFJdkk2UnJHMFJCUGEvS2JSdEQxc25S?=
 =?utf-8?B?THFuMDZSbUc2WnBPQlJRMDVWZ2NFZnhUT25qY25ETWdnOWRYQ0pUYU5jWUR6?=
 =?utf-8?B?dEcyc3VHQXhpN05TSWc1Sm13a0dackQ3azZlM3gvVjIvZmNTRFVmUEdVYnRk?=
 =?utf-8?B?NlFHY3FuSG5sbjJDNjU3R2E1Rkc1bHZ3NTVjcmRsMDUvaGxnbTRETG8rcFVV?=
 =?utf-8?B?am90bHJXcWloUjVIZjFpTTkrdWdFZ3pPZG5ZVnpiQkRnbTVhVGR6VExjYlZV?=
 =?utf-8?B?Nkh1S2JodXk0UmpJTXNBbDR1QUNLbENpTmhaaERaN1FGcjNVblZnYWhmU2FR?=
 =?utf-8?B?b0Z5QSsrbUdON25pR0F3LzJ6NVhIdzM4K2pQWGVoWUhlT3RkZXF4UlZvY0Mr?=
 =?utf-8?B?d05CZHUyZXBOYnJrSmFiUVhXZzhpYWd2UE1uNTR2K25GdEZvV2lpYkpSbW52?=
 =?utf-8?B?OElXT0pySVpGS2J2b2VPVCtaQVkwY3dyd3ZTTGdsK3paK0hhdVB0ZDVERVJR?=
 =?utf-8?B?T29nWldDaGJpTDhIbjg3dVdObmZ2Sjk0TjZxYkJtVEQ5YStKZ1kzdXdUNUVk?=
 =?utf-8?B?TG8xZ2NRWkM4S3JIT0QveHFFWnBzMnRUaXo0VVdLdWt4Tnlma2xTeVU2RzJH?=
 =?utf-8?B?U3ZBd2l0K0FtUkh6Z0haKzBZc01JU0wwNnErN2J1aWJqcFBma2JadjVOQkx6?=
 =?utf-8?B?Q2FGckxudzVXVS9KckszMkR2T0Z4SHRNWTZNRHgzY3hReTBpVUNDM3BtTGF1?=
 =?utf-8?B?RUFnVFF2cGpLUDlqUnBBV2FSV0U0eHBIRHdvZmMvcW9ubTYzcjBONlBuWEZK?=
 =?utf-8?B?c0lGWjZ3OXZxTnlJUXczUjI1WWlsVXdtMlM4MCsyL1VxYmpOcmQ3ak0xRkFm?=
 =?utf-8?B?WkU1QVNWd0pyL1ZDai9rMlNDZ1p4VEpzNzBjWm0yUmxBYkNDL2ljbUlvckk4?=
 =?utf-8?B?MGRYU2ZRM2lLb1R3aTZMOTd5ajJpYVBmVlRrbDdCRGExcXdUelBOdWp1Mmhy?=
 =?utf-8?B?UFVRNExza3FjalAra2ZZVVVDeWZwRmF0YkE4bmVnaWtXSS9MK1JRNkI2ZUEy?=
 =?utf-8?Q?O4jvRvAjKp5CK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmtaWGd1WnZPTWZkbHBUM3RKZHJxRXozeGw4M1M0YzlUUXZ6eVhiK1F6MUdP?=
 =?utf-8?B?dS9Ya05vVEU3V0N3ZUtBYllJcTNnVWdqalFxbkdsYTd0UGRWcUd0RnBCUjAz?=
 =?utf-8?B?TlBzWE5ZN2xWYktyQ3E1WXNIU05VOWRZV05FUDhsaGdNSUJaUDhrKzFEV0JP?=
 =?utf-8?B?KzhHRXhYZzI0WGFmMWkwczV1cUYxTXV4Ylo4QlEvRDJIcGErQ3d4Z0k4TkNm?=
 =?utf-8?B?aytXYWVQUjdPaVYvMVBreWM1dFdvcEhHaVdDdnIzZVc0ekVGQWxnRVY5WGp3?=
 =?utf-8?B?OUlmOXJvUncyYTdJTHZBWC90eWlDQlB6N3dtT1hkWFdnMzZLVE9KV1hqWTBJ?=
 =?utf-8?B?a2x2T2pNNU5pT080aWFqUHNNaS8rdkFDc3hZL2VTWW95d1FlTjNCcmxYK1N3?=
 =?utf-8?B?c2FRSFdMK0VablQxMFMxUmNkVXBsU0pBOG8rc3BjdW9CbkdTZVo4SDhvM1hR?=
 =?utf-8?B?NVlmZURqSXlvUk1ld1VFa0RrYjlFU1pVcDVjUGZMN0lyOWV0b0tMelZ0c1la?=
 =?utf-8?B?SlhLTU5JWXJYWVJ2OWR0c3ZFTGdUUjJxZm5VbFg4bzVtbVZZVDlpWTdhc1Ns?=
 =?utf-8?B?T2lhUHhaN2RoazNYY09BUWw1Nmo4N2xBbFRzS283WDdhdkZCQ2NycFNROEZU?=
 =?utf-8?B?N1I3NHdONGg0WkQ4bTYxdGZ2WUZEZ0MwMDFaQSs2YVdScjNxOXcxMlRPcjZO?=
 =?utf-8?B?bGNnSVpwamt0Zk1QcytCYXd6NlhlbzJQRTlYUzN6VXJyeUtod0Q2UElvUGJT?=
 =?utf-8?B?dVE0NzN2ZDNiaXB2N01rS08xRnRHdHphRk0xS1lyQmltcHRxK3grUVN5cEF0?=
 =?utf-8?B?RUV0WjdoU05NaVY3VzJiUmo1WFVDS243NS9raHBBQVJhbUZzQ3d1Wm96U0Mw?=
 =?utf-8?B?VjZ2T3RHd1BxdWdZYU1abTMvZklCaHlnc0FhWUwxTWgvdFE5SXcxMUtjY2FZ?=
 =?utf-8?B?N0d4bmRRalYxZUJHKzQybnRtcDdGMWtOblp0Nk9BTjRNYVNjbVF5MVorKzky?=
 =?utf-8?B?NnRHa0QwVDlNZDNWWnZnRDdQeFB2cG5ucjFib0pvUnViYjVhNjZJdy8vQVRQ?=
 =?utf-8?B?N0ZRR0JVOTE4UFFQMVRiY2ZvNk5ZLzV2N0tCMUJ0Rm1OeGgvNkUrU0tKcVBm?=
 =?utf-8?B?UDhzWTBUNGs5MnM5TlJsN29ranA0MkVGc2VFZkkzUko4dDJiR2hUVnVmU3Az?=
 =?utf-8?B?aXBxcDNtaUJwUDhhR0RVdWl6SG9oOFpPakVXM28yc01weHpUTjBSNEZmMjBD?=
 =?utf-8?B?Zi8zTHpXRHBmTklTOFY4WmVic1FwSkpwTWV0RW1QRExvK1hneXcwZXI1RmRG?=
 =?utf-8?B?MU9iQ0lMOTZSRDZrQ1ZUK0VaYXZGbnZqMlhwVUd6NzRQOHgyUThINnJVVmNB?=
 =?utf-8?B?bTlyVHdTd1pWaGNlTW9DZkFFV1dqN1N0aURrUm1yMXdMVVhxUzdZdDZ2UCsw?=
 =?utf-8?B?dW9xVTBhS2VscDBMZ2h1L2JJbm12d1U2MGtqa1Y2UlFLWTZ3dGRqeG5Ydldh?=
 =?utf-8?B?QjFKN0ttLy9nNEhNZmNOYWZUVjNVNWFJTFNjN0F4NmhjSG9iSWhtbk9BYXNl?=
 =?utf-8?B?UjFWK3NOaVNNazl0NENnWGxxTUhLUmI3ajFvRCttY0g1TFd4SjJTdHVoQ1JF?=
 =?utf-8?B?T3BPMk1FVmJrcGpaQUltRGg0c0FHSHBPRXBqL1pzZ2t5b3pScCtPOTgrL2Iy?=
 =?utf-8?B?T3ZBbVNsbkFtenNDbWJWa2s0WG43M0IxRW1GeFpPK0pjL1JBQkZkOE1OSUNJ?=
 =?utf-8?B?RU5BUkd3d3FsYXp0RTFsMDVuR1J0b1NnT1Q2djNrK0NNVm9LdzBqLy8rVmlv?=
 =?utf-8?B?aGg1cFl1d2JkWVBvQW9Gd0xndDM2OW5RZnhaazA0WTY2enVNWnBIWGMvWEZx?=
 =?utf-8?B?Zmc4WWdva01VT3JVakNpRjBQT1dyYzR6bDhlZVJuTm1IbFFHdk4wSDh5S2dQ?=
 =?utf-8?B?YzhRSzcvUTIrLy92bUltMkR3OHljUHVZUmNMbXdjR20wM2JZTDBwYkUyQThp?=
 =?utf-8?B?U0s5dW51OXZOb3U5N0VGWXd4QStHNzVoVlQxczZZMG90dTRyVlNCWWxsSDEx?=
 =?utf-8?B?dk8vcXVTR2FoMHZ4bWNFWUZqd2lhaDE4MlF5NG1ZOTB2aG9UVEJoMmVkczFo?=
 =?utf-8?B?ZzdTRyt5L2FhTUIrSnhtamR5THNTU0thVHRaT2RVN1ByTEtCelZXanU4Qk5C?=
 =?utf-8?B?Y2czSjcrTHNKNTEvYllZY2F1djhlL1Y1TUFqRXJQT3NYZzVnUlYzMHZWeG5R?=
 =?utf-8?B?cjZJczJlWGUxOUVlSDJmNWZ6dDRnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zmIxHDPRh+BaUMQQRfHTaJBxoTHE6IzSNTVxr6ceoGJF9dimNUQZ2hb4jFyBjgOWG1TPBGJVm1krDvw0Xghkp5Dl1K/pR7gOoo+e8YW03rYbeXniz7vb5gQEjbBe+IMo6UczHfXqbg1sUvbkvoJIM/ZHjNVBx1FJwSsa2zZZ5z8UskIEIb5P4Lpq8JNPwq7hBQb1S8c5YSGHJIUMZc1XbDmpvV2hTcaj+BUN3tZA3LR49hSYPd3f8DydF/NqMYnQpb7i7Qqzd2AeP4tZ3N/1+t6uxGm9JLlH4DUgOYa4SOCVMIAKJLK98fAHCcyoByPUfweXji3Z+rP4cZSEaX0PvxQWFQ/vrzmAmLxsze0OQn+eA9kyD9ZmkVJn+AiMMMakp0X737CoswLXa421e5mNCi3K6ZT13xntLvLNx+oLZagFTz0eKetw3p0t95g1XRpMtxgcSFjwyvvcm6Nz4NGCK7bMuJVOYUjK23Vyw6D9UH+2iDko+IwcrZISmU85RGXtgo3/Qcr23YbwL40bkeBu61D7vXTIi3UPjHYZR2u/cEYHyAc8FmpbWZ9o5XE2bcfse4RHSRRTG4WOOUnOooJHmoLtOCaV6tJADmaj9amp2Ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91df100-680f-4236-76a0-08dd4b8eb4a1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 17:57:24.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1rWq0mMFqeD9hKGeTLnWf1XaMDqFv812iIizif83edSPy7gkBcsAXorXkUwh0rY3oGywl+2qIIozhBlhl21Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120130
X-Proofpoint-ORIG-GUID: pIpqSFoc-eG5z8dxLxQ_K3dHFMOOnHev
X-Proofpoint-GUID: pIpqSFoc-eG5z8dxLxQ_K3dHFMOOnHev

On 12/02/2025 00:49, Stephen Brennan wrote:
> btf__dedup() does not deduplicate variables, nor the contents of the
> DATASEC. This is reasonable, because there could very well be multiple
> variables of the same name & type from different CUs, but with different
> tags or DATASEC offsets. So it is up to us to ensure we don't provide
> duplicate variables to libbpf.
> 
> Unfortunately, there are some cases where variables are declared
> "__weak" in the source code, resulting in the same variable, with the
> same name & type, at the same offset, being encoded twice. The DWARF
> information does not encode any difference between the "__weak" symbol
> and the overriding symbol. And even if it did, we couldn't filter out
> "__weak" symbols, because they aren't always overridden. So, we must
> deduplicate them.
> 
> We can't guarantee that the types are identical prior to deduplication,
> but we can at least verify the offsets & names are identical. If this
> happens, simply skip the duplicate copy (or copies) of the variable.
>

hi Stephen, quick question; could we do without patch 2, and if we get
an offset match, then just look up the names of the offset-matching
variables in the code directly to see if they refer to the same
variable? that way we would only incur costs for the rare cases where we
get an  offset match. You could use the names__match() function to help
with that I think too. Would that be simpler maybe?

> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  btf_encoder.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d989fbd..29b2054 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -869,8 +869,36 @@ static int32_t btf_encoder__encode_stored_vars(struct btf_encoder *encoder,
>  					       struct saved_var *var, uint16_t nr)
>  {
>  	int i, id, annot_idx;
> +	int prev = 0;
>  
>  	for (i = 0; i < nr; i++) {
> +		if (i && var[i].offset == var[prev].offset) {
> +			/* The offset of this var is the same as the previous.
> +			 * This can happen when a variable is declared in one CU
> +			 * as "__weak", and then overridden in another CU. There
> +			 * is no indication in the DWARF which symbol is weak,
> +			 * so we need to deduplicate. If the duplicate is the
> +			 * same name, this is expected, and we can just drop the
> +			 * second instance. Otherwise, we need to raise an
> +			 * error.
> +			 *
> +			 * Ideally, we would like to verify that the types of
> +			 * the duplicated variables are the same type as well.
> +			 * However, there's no way to do this without
> +			 * deduplicating the BTF, but at that point, our type
> +			 * IDs won't be valid.
> +			 */
> +			if (strcmp(var[i].name, var[prev].name) == 0) {
> +				var[i].type = 0; /* Don't encode corresponding secinfo */
> +				continue;
> +			} else {
> +				fprintf(stderr,
> +					"error: encountered variable '%s' (type %x) at  offset 0x%x which duplicates variable '%s' at the same offset\n",
> +					var[i].name, var[i].type, var[i].offset, var[prev].name);
> +				return -1;
> +			}
> +		}
> +
>  		id = btf_encoder__add_var(encoder, var[i].type,
>  					  var[i].name, var[i].linkage);
>  		if (id < 0) {
> @@ -894,6 +922,7 @@ static int32_t btf_encoder__encode_stored_vars(struct btf_encoder *encoder,
>  		free(var->annots);
>  		var->annots = NULL;
>  
> +		prev = i;
>  		var[i].type = id;
>  	}
>  	return 0;

