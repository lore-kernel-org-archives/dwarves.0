Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05685207A20;
	Wed, 11 Mar 2026 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257737; cv=fail; b=aIsxoF0Q22VrOw1eP/KqYjzAG/0qTNd0NSEZr59fuYDOov6d8PJl2bp0mCC8siDXQW3qlmx40z2eQ48+SQGegyy0aDidzMVkxGOuHgPJt4lGtTz6HiPjU5WiJ7Mh5yriAxXsAxtMECEhAZGpGQajF2rQZeHyzwxniQX5OCTaTgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257737; c=relaxed/simple;
	bh=Z4k/f8825KgPcwSjpHu7ME79kSvWvWkullALMKcaKcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nMXFDYwiXE853izYhEBLBxo9XwTTN1ntRb7p1fOtN5wXsqnI47z2J3nQgcxd0P8Bu1tjtRjKJ+H/zBvwXLIGixqUOdiuP092X6krKRM9TRKRN3iLGwYjzxkvaXZ0vu9hqp3x0Beh6WtDrto2dWEMTVgwnPBSiEYEpNSXkq+YxYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ESCPLGdE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uq1/R5al; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ESCPLGdE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uq1/R5al"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BHGiQU2234887;
	Wed, 11 Mar 2026 19:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=39Q1KDGM2Knap3bETWvlmnOnxxjiTw/JdmOnUsfaaWQ=; b=
	ESCPLGdEOeANLEpcftpYQHjCgqgqwEat55umaRd/7+RvoYVSHXZz6EX4yaz7dP/B
	r5TC5fRClaWUKHKc1UB7m60qygPwe3IOVyMxI0XgBsBARYZDgHUSPoUARPHAyNtu
	Ox04u5bR/GpMt4dQ7CihJ/hLO3BYc4K8Mf2THCnU57dilaaL30nAaUUeslgM5td/
	3cie9cv9cnmXRROq54H/W1i2ESZRywaI1IHaWjjpaUyyisgqIBryi4H2hVz6nXdE
	K29krue/LjBZcWXZ/2OSKFcjpWW9jzQ3gyY2TnHSB1IqQHRSYjvUWXSMQOWdvdSe
	CbNoW4jo/fte8ZsjOoXqjg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu52d14cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 19:35:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62BICjMA020274;
	Wed, 11 Mar 2026 19:35:10 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafg0vs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 19:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLxLpv8R5wGDCabgOm0BRFqaSN6uzN/xCEHJ0+YJV7JXCzyzgNmO0v31wbIkEA/+EvjIypToNQGt/1ndLjTp154J91sgauvci2y4bNZXNESl55+ZZiCnMRyn/FryOngKoOyQvTM2xQkeelgQYRfV+D1DLEeAMo8viWOYAJSs8hMdCLbpRBtMM8tV0dNKkJUXdMYoh8uTXz0cASB+W9Tn2mNFOWHQ134fBXm+ApT0663jb3a5zwFaMgeHIrFcC3bjD/lpBfoxlGEJBwxqVa7wpLHTt9MJciVOqmYJQHDaPtbkFDF3/beW9gvDaNjdbUj9WjLJgbrxPG8HWlXKZf0nhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39Q1KDGM2Knap3bETWvlmnOnxxjiTw/JdmOnUsfaaWQ=;
 b=aoq1W1hotQ3WLn43ESyjwCCvAjgyT2GlwcBw3GJkQKkn0oSYq6pDg5SoWD1BxoObRUZ2o7Cc+RiFmExzA1jtgGtvx24KFhdW93q9yiL/6e7eOJY0FetNgHBfppNnEhouBpvSq7jmhkkIoImF8P743oK0b5KWO1fr+t/xhxZegh3rarY/kd4FKzYJXfF/yhQBHLom8JgQTdLxoN5/M1eOgjzw84erM8NZ237MoL6kItwbpADsNKurV9+2T+GFwG/uo13E9yuufDdF4axpid11ZXkm+pQmcZ+jerJdC1UUPQCmBHdNwoMu7fo4VrpVxmXSeFTPnZTkVJEq/67C+QtaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39Q1KDGM2Knap3bETWvlmnOnxxjiTw/JdmOnUsfaaWQ=;
 b=Uq1/R5alJmIqXsYnqiIFp2Y69T/ot8HQ/7WN0iAUbGOeJBrYA+o8YHB6jIc1A7FR/r/wEpZbHDwiNkg7sjA7dll3N3hhcQtmKk3hLK8Ij8rLvx/aFL9aM40Tl4p0k8CUr1WlpM5ewhTfy7f9voQuO+txfqVjLrSbB3LoassgRCA=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MW6PR10MB7549.namprd10.prod.outlook.com (2603:10b6:303:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 19:35:05 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 19:35:03 +0000
Message-ID: <8294fca1-4d11-4c91-914a-c83d12f00ecc@oracle.com>
Date: Wed, 11 Mar 2026 19:34:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 bpf-next 2/8] libbpf: Support layout section handling
 in BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
 <20260306113630.1281527-3-alan.maguire@oracle.com>
 <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
 <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com>
 <CAEf4BzZefR6qQwu1jENEMg15UCXXnfqfwHYRV5y4NAXWwuo4zw@mail.gmail.com>
 <50f76d21-ff5c-471d-bb11-208925778d32@oracle.com>
 <CAEf4BzatOXf0YgtQj0X+kQ=NSo_rFLAjQ0BHf-ZegFm+t43J3A@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzatOXf0YgtQj0X+kQ=NSo_rFLAjQ0BHf-ZegFm+t43J3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0030.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MW6PR10MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8f2703-e6e8-4a66-9f29-08de7fa54aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mw78FwhCG1M46bPHv9OfkTZCQpGSz/nUgBs2vmmNJmdIxkwOg8dqD/L77y/x2I3Mtw/fvqvcISF3hMoFgXLSVMgWy9mEQTUWHrKbWfMBWHpGC9xkAn3Qg01TCIolgMafffsIo/ePRxFkTHxeboJwlHDeq8vHxgzDlU6THvNT8SzBaWrWjVziJ2puS7/noa0TwlA48yo/fzH+6wxGXxQTjdCleoiuLZHQhmDvJXZ80IFcDo5k4zfgV+effld6t7TzCdHI88MZDex4wKO3ZWgkNrr+dTC8YWIunvNLXA03K67mm7p8Ad6Cqca4AbeChcpWO6NCF2Qa1Gs6l8ntyouVGV2zVNs2xPqFULY4+nOfzamdv2zkt/8zcAF3M5EidZLRI2s6Gc+W0+D0ikJT1Sw1qQoo2jsjzG5rzope3zTNLgvVuF42sCkLWbMmTgIIlJRfVMouOOjFsaj9yeBRNxF7dT+ZyPDl2FliPEnCsS283seGz6P6/TN/a3JyMaEXNTzT0NOY4W9SOXpD9kbciY06kA/fEqBH1Wo/gv9f6O9padJK0DQFLFhMBHPaAx5swN29ZUhxugc3yjlRTxUdAT3jFlGk4BlTAxk+RTqRZLZEMIRr98mj6quruOeMMRXODTPORAM7Dxm7OoHBurP8KgstJEl2G6oYpot9OTG8ukBeqXP6sOK0dJlmMvx17HQ5KvLKkTeuDWKYsva1zzh8xBZoQE/zWnR0LyBTOuDe9sQbbnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmVDV0RmUlJXQmlwVHlsSmUxWGR5bVgzenU4NVNpVDNQU3pYTkwzTnVZZ0Nr?=
 =?utf-8?B?bStJWlJ4WG9xVWJmbTIzVlMxeXJ1M0dFeisxWW1haTFaRjcvQitBeHAzZW9Y?=
 =?utf-8?B?Njl1SGpRaTlIU2lITTBnZFB2Z3FpOTlBaVBZcjJwVnU2RVNPVTFTcXN1cWU1?=
 =?utf-8?B?NWQ5Nzl4Q25xMHdidGVxRmlMNDFGN043MkVjdEwzeUg1cFc1b0U4b1RLYnkw?=
 =?utf-8?B?YzFGMFdGVHZqR2RpVnZsZkFVd3FqN0IvQzkvN3p6TFBjcWRPMFV1MVN4MTBH?=
 =?utf-8?B?dXY3ZlVlZkJsNnlEcHVHa2FxSU5hT084WkhmaStpQ2lKUldYVkV3aDFUQzBx?=
 =?utf-8?B?bzBuZ1loR2hITkd2OHZIVVNrbVRkOFZDZ1B5bDhNbU85dG8zTXVBejVHS1No?=
 =?utf-8?B?NXRlWWVDZmVEdmNEeDRFdEpqR3BQakFVMkY3aXhObUVLY3FIL1dMRjJIVHlS?=
 =?utf-8?B?OURoaGJxYWc5T3VYZ2VJVHBRcHZKVVc5VXJnQzRhdHhHcmdkYWVsRE9oaDRZ?=
 =?utf-8?B?NHNVejREa2NFSHNFM2NvcnhaVjVJSzUxTHhjM0I5TWhJRDNPbDJVa0pKdXJG?=
 =?utf-8?B?bDhkT1FlYWdWM1lURCtLYkxlUDN1cXQzTTZUY0d2TnppZzZkeUUzMGU0SHd2?=
 =?utf-8?B?N2w3cmxPNkYzZE55QTcrZmVhM3ZseEVxTmcvK1IxaDhYc2JZUHJFTXIrTGsx?=
 =?utf-8?B?NUhEVXJwbWNsMVBhQkNvSDdNTm5RbmlFVmttZWVzcGVrYkNpdDRhQnM5cjVR?=
 =?utf-8?B?ei9sc0kzcjl0T1ZndjE5dlRFUVVVQ2xOSnQ3ZTJ5S2dITDF1dkN4dlRIQmVJ?=
 =?utf-8?B?MmtTMVp0dGI4UUtpK2FaRWNtWUhIWmhBSTZib3dWMXBVRm1ubVU3dWpPRHpj?=
 =?utf-8?B?QmlPZ0ErdjFmeUNUNllHMks5RjhvemJMcXJMeWJ1c0FDczlMTHlnZzFVZTh3?=
 =?utf-8?B?SDJtQWEwR0dUODlZbll1Vml3VFplMVF4S0xsZDBIbnk2dGRxcTI2SjJicUJ6?=
 =?utf-8?B?QlFYbnhiVTBFNk1xVTFtMVk2cENKaGJwU1RJRlpaUGpiZ3V5a2xwRGZDK1J4?=
 =?utf-8?B?OVdJQ3g2c1VocFYvRGZjMWdUaWdpMHpwU1dkWlVvVGdUN0llMldpRU11OWky?=
 =?utf-8?B?QVNGcGkyUC9uVXdlLzZWZUFJTHhYcE9CQ1RXZ3RWMDNNRGJFWUYvNlRKdTdT?=
 =?utf-8?B?MDR2ZDN5dWtxalkyaTUrcHkvSnZYSTd5cUQ4VkppL2xBVTk5NmpITllMR29O?=
 =?utf-8?B?djhmKzdMdHF5bHJFSjB1MTRZeFhlbXF4VmVack5qaXFPb1dxbWJqK2M3MGw5?=
 =?utf-8?B?MkQ4VzQwMFo5SnNMKzZ5eXJ2R21tL0l3UkJkVjNBVk10aFdEaUNPaWwwd3Ay?=
 =?utf-8?B?SXBUZTgrS3AzRDMzUjRSSUpLd05JZVNZQnpXUVB6REgxaGRzSUxFZjR5Y0hX?=
 =?utf-8?B?WUdDQ0M4Z0ZXczVpNWtjcVFFb2xWVU0wWHdzSzV3YTZPVUR6NHoxZlNFZFhL?=
 =?utf-8?B?TWZpM2trRHI2TlNMUXRjbC83aW8wRS8yT29YSU1ONmNHa3EycHlnWVA3OEhD?=
 =?utf-8?B?YkhqaXU5SWk3bUtkVWd0czMwZ3RDa1RvdUg2Nk90WTNheW5kZUFuazkxNnpV?=
 =?utf-8?B?YmtZSnZ4M0I3N2lTNGQrSHJOSklDbUxTdkZiSHlwRTd1RjVmN05Ed1dYWDZD?=
 =?utf-8?B?NmtjaEowYVpiUDhiM2MvTEp2N1ZPUnA2ZEhuTlJzbllnYjdUSW1IcFdzNCtP?=
 =?utf-8?B?Tjg4MHI0c0ZSOTNnSyt6UytpUkR5a1dkaXpQTzZkUExZOEVtZnBKUUlld1NO?=
 =?utf-8?B?djM4NW5yOHZmeGJBbVFDbUtmblI5ZFpKTmxQWFptWFhtQm5KeWMrdHowbnJk?=
 =?utf-8?B?V284WjdUS1YwR2dtdklCdDZUQ2NjYnQzUU4yR2NUOUpuVEZDMU1nNVc2L2Fr?=
 =?utf-8?B?MTMwdWZJSHZTeXVtUTFGbGFiRVNqRDNXY0gxU0lkTytrK1E4blNWL24rVjls?=
 =?utf-8?B?aGtjUjk1NW51eXVYbUtmc3NZZTFtZ0FaSXdLWWV1WHlkTnZSc2xFQmNXSDV6?=
 =?utf-8?B?c0ZkdjlyUlhtSE92R0JpaFdNaHRXRnlGUnZuampIMUJicWNYUEl0Vzd0SmxB?=
 =?utf-8?B?RnMyUmdEeVlRbjVHWlI5cTFIbk1MdWdxcHlVcW1xOWVXOFAzbThURFNTYTVx?=
 =?utf-8?B?K2lyMHJTQ0h1YVU3cHRYd05nb0c5UXEvamFyaUJ3ZGV4V3dISnQzWFFCOThU?=
 =?utf-8?B?bDR3aXB4QmZFdTFRL05sTHRGbnlxbWtlM2R5TmF6VVZaeldITmY1UnlkMnZr?=
 =?utf-8?B?SC81V0xsVU5TT1lQZ2RiV0s5MU9jREkvMW5xblRCM29zUUxvckNMLzRWTUdX?=
 =?utf-8?Q?TFxH3oRj6JHhImS4=3D?=
X-Exchange-RoutingPolicyChecked:
	M30VtrQTvDDTXvUdqB3nb8GOCuf68ga/dwRnrTQif7iOvIDO72I+JYAFiollezpYtW6kZHb8NTHmXz27j8uqVzr1oP2CJJp40PeZn4oR0vLcxnLXKE2hIlCOz1Y8CWkknSMkCFgY+ye5BgQWUobYqneGmSwJewzU5aJ0ToDvB+qGEBH2iiDMYhyZMFwSkDicZT16n7ufp59FrZ696ZP8YYjlzdE5unUYRJy4uq13A+71awNjJOLDskmwfIQNuIWL15wnru8W3tEDJ9EnJsqVobnjcL5q95PmhljnuEGDjkeGhrgTCjsQQZxmvL1rfJa3IZTJgpFSw1oEKam5TzoA2w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9tj2lK6txUFlTTDpr/qSxRjhPsRMfu2osrI/OqIf03Y+HUt5cTUbnoWTAAJhqBHP3GDXmIpiMPRg7/m9NJz9HAMriOIYeVAwwGhzQR4TqeQMS72RhTvOc/XVosAXpwKybmsasgzaWZHPGDmYDj7sdGP9PH7PD/K68jkJCSLQ6sLh2yysmZ4IlOlnBdvquhpM40Lx1LqeyEhNfjQQecGs6f6ygtFPOA/gXBdcaZLHfffY8YG/La3E9z9f0WnsJ/GQ8anexwLviShwPtsZn+PjpcR/1J8s1TCDyNREY/Vihtm8uGpR45UPQpTB6ihIJI/WexgJ9iGA092p55LLxtqaVfpv0KpFm3a/O07f396KMomVbFJwrRalJDT0722nKfXnhN6WrAGqxydJOhZaW/qkDhsJBV//9zM4MKQu722VT130Pmr28GuwaeeBy0gp9n0E61WaPOCDJMdQAg4U3YO98eyGAVCYYwvGUiGjzOcBQcKeOC4L2gvCY+Z4o+h5SCIfl7jOR6uTihxL4PQUZig2ycHKl56M9cVxMfHw/TPjRS4Ds3dmXHu69ftOvjQ1mu3iohxl0umyfLCFlUtLbZVaMFHO1yun+GO3XLne0kdjc0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8f2703-e6e8-4a66-9f29-08de7fa54aa5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 19:35:03.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cT7gpD2MYXSc+mDgPtIrTVoBNYel/FXs3ITqem7lSvp++iO3/oU/5FRSPt9NQxw2MbziLwT6GhvqgSNBIWCWow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110166
X-Proofpoint-ORIG-GUID: xaiBwJ5iMzDMSvUGuX04c2wikfCMimnd
X-Authority-Analysis: v=2.4 cv=N8Uk1m9B c=1 sm=1 tr=0 ts=69b1c3f0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=r0P8DBUAH6dnA6nevfQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12270
X-Proofpoint-GUID: xaiBwJ5iMzDMSvUGuX04c2wikfCMimnd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE2NSBTYWx0ZWRfXzL5pfK3YCwSm
 FXsQV7vP8VIQIpIlrYcqEgUOkq35TwbrZAYmV+YDn5JXXesk7RhcVbrmdQtM2jY2bgxrz6ciQ1Q
 Ig/LhwK/yX6BdPz6jna9MDAoAeJKKYgJHYjeGDi+Ax6Fr5IEH8bofj0nvhe/D4qTnlsmORl7GKi
 NMZusPgczqAfxwW20ekKxb7XTmmYBQWaH2cxW4c5cDNT0sV+qYF0K6BvomLw3A+b3IooQcsLPPw
 Ix6eqWcPy/vbLJEfqKu9fxTQyjOxTTqsY4juW8FVgnSCK1RA26DrIeCyadJKwzcJIuaHtmOs/MK
 rKyR30V67smyPpVra4BWWIYmRMFFQHmhGah1gOLk3CetOKbdt8GGlWfmPm/iv1ykhT5G7E7sc5f
 vGcvToiGZSMW5Yjb+1AxsR1sh1t2X8my13Ye+P05/MJ+oSDEkhYpvua+7NzVc8nEkPZWTctGdoy
 6tk0hNn6CPe7kVBUqV66g7nkM7+DMM/t4+Qno8YU=

On 11/03/2026 19:21, Andrii Nakryiko wrote:
> On Wed, Mar 11, 2026 at 12:17 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 11/03/2026 18:16, Andrii Nakryiko wrote:
>>> On Wed, Mar 11, 2026 at 11:10 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 11/03/2026 17:46, Andrii Nakryiko wrote:
>>>>> On Fri, Mar 6, 2026 at 3:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>
>>>>>> Support reading in layout fixing endian issues on reading;
>>>>>> also support writing layout section to raw BTF object.
>>>>>> There is not yet an API to populate the layout with meaningful
>>>>>> information.
>>>>>>
>>>>>> As part of this, we need to consider multiple valid BTF header
>>>>>> sizes; the original or the layout-extended headers.
>>>>>> So to support this, the "struct btf" representation is modified
>>>>>> to contain a "struct btf_header" and we copy the valid
>>>>>> portion from the raw data to it; this means we can always safely
>>>>>> check fields like btf->hdr.layout_len
>>>>>>
>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>>> ---
>>>>>>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++----------------
>>>>>>  1 file changed, 200 insertions(+), 109 deletions(-)
>>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>>
>>>>>> -       memcpy(p, hdr, hdr->hdr_len);
>>>>>> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_len));
>>>>>
>>>>> in all these cases where we have sizeof(struct btf_header), this
>>>>> smells like a potential issue, tbh. We are silently truncating the
>>>>> original header here, potentially. Which is ok for read-only case, but
>>>>> do we error out if someone is trying to modify/write such BTF where we
>>>>> don't really understand all of it? Should we?
>>>>>
>>>>
>>>> The kernel enforces that any additional data in the header beyond fields
>>>> we know how to deal with is zero. We don't enforce this here, but we
>>>> get a similar effect since we only copy the fields we care about. In effect
>>>> we wind up removing the aspects of the BTF we don't know about, so if we
>>>> read in such BTF, writing it out would not preserve any additional header
>>>> information (say a new section offset/length) beyond the current size of
>>>> struct btf_header. So writing such BTF after reading it in converts it to
>>>> the BTF representation libbpf knows about (header fields + sections).
>>>
>>> I don't think we should be doing this. Let's error out when someone
>>> tries to modify BTF where we don't understand *all* aspects of it.
>>>
>>
>> ok, so to do this I think we'd need to set a never_modifiable flag or similar
>> on parsing when we find non-zero unknown header data, and then fail
>> btf_ensure_modifiable().
> 
> yep, I'd like some better name that would mean "there are extra btf
> bits we don't understand", but I can't come up with a better name :)
> if you can, prefer that over not very semantically meaningful "never
> modifiable"
> 

would btf->unknown_hdr_data work?

