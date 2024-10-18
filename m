Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394518872A
	for <dwarves@vger.kernel.org>; Fri, 18 Oct 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244868; cv=fail; b=BEru1hcQjUSfFxtBGjn98asHhlpfcP3fFpm4yF4GXcIhaHp4bufyyEgfiObqxCs4BJPmMjVwKxxsczFdf1kX0czSChMN0tu4aE1Ic3t272dr74J4sviK3B8mLTmbYwxPD8Ri/zXT0B7MpuZV5/fAgDBi++ov91xW1VsHypSDPgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244868; c=relaxed/simple;
	bh=nMXzLNi/N/dLHbFehkqsmbTBRHf7goWPOzle6YtULsA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rUbrQGo0aSuyFf/gzrgzdIiwyCDv0Ud9T7TbeKo+aMxKLsgt3gT7aVTCCXxB+6FP3BdfWgrNbyqCaOL38HCAOaOAntmw5EjdBF5/SQCR/R9zqyCo1FIeBYuHhI9Ghfkp7qKbx/oIsuZeiElQtUUGCKl5pIIt+wP9rP9FOcVvnz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M+ahpmKB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pSq3QHn2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+ahpmKB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pSq3QHn2"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9ixtX007914;
	Fri, 18 Oct 2024 09:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DUA75dWi8pWGROyBfRNDbEJTy6KmTRPS6VaJa3HVywc=; b=
	M+ahpmKBJCHTNrBKSrdKTc6YBds7cPMuWBruHn60FHFTtZ0+S37nvhIg+BDtP8jI
	dMRJScw/7+FDBHVq2Th82Lgwbne8czNbD40ke51pVIUfU/wrUaSfyQUH/yZGyX2x
	IOyRcPQMOYegQHQf2Fjao1qn+K+qKvVMoF/Aifv8OOCdWKdUupYGh7LthfvQXWnY
	PEfPW8KQTBsSY6gxJVOacML6RPNkR4E/2ycxfemIF2B9+VVSStGXbc3SC6Nl0F54
	jHJXaQen2szIGV+OhEmEcClfNuZ3EEgf2M91pYzlHvCPieOWps8aMYmTxkdzDxEe
	IEHorqdezmnmwn/YBAMcaw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntgc8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:47:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9Hnjo026284;
	Fri, 18 Oct 2024 09:47:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbd3k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:47:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8ll8kvRXmlQ2HSkrl98PyRL+gmMh7OnCgo5sWKTPqWxDgh000HpKHICm7kU8QRN6cika0Kf6IiugdxOMGfO7dNLu8O9beYBvLC7h4wMO64hDHuUrf0f4jCl53hS3a6slmlQN4ZNnzA9AYeMeEYWi5+tWJ+oOwdaO/qa+bp/VHaxAzDvLGzv7MJbvCyH3NP/DZjOJmWkC6kCUesX2yMJVQR7WeB/jN5Q4EVq0jfg9Yo8szM9hCECRd5qOEX4JXo2SY0kaCwQ0paXbsMFdPAYayWMklfvo+AEaqIwjycCGCARjSUWFozfNzKrJwNakehX1pR9JEenciSQ00khCIA5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUA75dWi8pWGROyBfRNDbEJTy6KmTRPS6VaJa3HVywc=;
 b=QI6EsLRbVjemfuL8oSpy2i+vSZb/zmXVj6GAAiBznvHS0oe0E9DhQJx0PLXO0SakQuaLi6YztZFeC1eLVCHH7ZAhBwDswAmI9xPgcAxXekQRwbEJQRNlirjPuJeWbqfK6Qb59z877g+5bis+UBqpqW+k6Wc4O589/UioCkoxNj7c91ASI2j6U7Gj8M4Ez3n8IClguHrFfwVcBXsgraxSXQlK0f3TgbgnawDL/dlGqPmzXAqYt+StML2uJ7K1rqieOLEgnI4Kcgxyc0QbSv/JtK0Btta34Qv182hnGe1L3W4lY3rrvqnrI+zz2+EHfmzyICNPbzAq2LhrgOfkSpFg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUA75dWi8pWGROyBfRNDbEJTy6KmTRPS6VaJa3HVywc=;
 b=pSq3QHn2TlevfOMAAMU1HxGDyvsX9ChvbJzGkj2bZyEisy3BZztNWT2+kuPgFKxZFafyVZeDlsSUHka5mb4fLBGuNQJe6DvfJQTKZ9MNYgxUJP/P5dgvVu2wFOofhfN10WGo6mfEv2dnI2X4MJZEWHcpdkB6UfuFspLIqkns/U4=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 SA1PR10MB7790.namprd10.prod.outlook.com (2603:10b6:806:3b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.19; Fri, 18 Oct 2024 09:47:38 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 09:47:38 +0000
Message-ID: <38ceba63-719b-4312-a028-14957e4ccb32@oracle.com>
Date: Fri, 18 Oct 2024 10:47:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Fedora kernel enabling Rust
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa
 <jolsa@kernel.org>,
        dwarves@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
References: <ZxGJruLvv9NRUT19@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZxGJruLvv9NRUT19@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0352.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::28) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|SA1PR10MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 160da32f-0bc9-4de5-3901-08dcef59e635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2VBeFVuNHd0WCtxOUZRTlUrVDVobkxaaDFsS3FMNm5Ka3pXV1VuT0NJMVYv?=
 =?utf-8?B?VWxsTGFxT3FrQjNDbzJhRk1nTFBOUm9ERitKNmRnby8yMnRxS3hjSjlkc2gv?=
 =?utf-8?B?dGJNdDdPVkhHekVCOEdNRjdJZVB1dWhyNVBVQnVSeTBQTnVER3ZveUp2N0t3?=
 =?utf-8?B?MDhYVDZvUjJxQ1huUjUrZlp5ZVFXM0htbldrMTU5SVExcjBSR1VBbmorZVNF?=
 =?utf-8?B?NHdzOExoTzJnemJRQ2l0NHpyL251blk0V2RqWTRNZ3ZWY0hTSzFBN0trUGJK?=
 =?utf-8?B?TFYxVUx3aDdZSFAyK05hb0FkYURBNWFmeDQ4NjJzbDVoTHJocUJGRFBrNGtj?=
 =?utf-8?B?RnI2cW81OXUwbVRxZnlrQmVLZzNyajFrYjF6TDQydDJ2ZXNKd1RENzZJbkM2?=
 =?utf-8?B?S3c1UjlmM1NVL0w3Szh2K3YxNVJ6OHh5c2l6YzlCdjR0ZE9CODM2ZUl2L3cy?=
 =?utf-8?B?WDlMd1pjSG0zOFhPNC9HYUVkRDhnNk5Sd1I2WnZkTEdLK0pCVDVXVFdNdjFn?=
 =?utf-8?B?UThSRjlKL0plK0N5V3RTRmVUUzVWWWtvMC9HNG5mSXdrVzNUdzhWbDJWZGRZ?=
 =?utf-8?B?WGx3dlFrYnN5dXRvL0svSFVxT1BndEpOSFB2a0dZRTJydWxWZTBVVG5EcGpk?=
 =?utf-8?B?MkE2ejQrUm9YTXRxUHlXS0NoNVpzNmQ2UkRRT3dIL3RDMGV1V2lJdXdBUlJv?=
 =?utf-8?B?VVhVbDhHdjVnN0JKOWRYS3QvT1RNSU5VWHpvR0FNTS92Z3ZZR2hOZGRsS3Fp?=
 =?utf-8?B?T3ptSDRRTmllQTN0Lzgyb2xuckxxdHlpYk81RXYxeTNQRFdqMlJCREVtK2dw?=
 =?utf-8?B?Tzh5VjhoMjExdTJaOWFESUtmVXhVc1dSWWJvZTFjQUNiWVFiRjFlZzd0NFZM?=
 =?utf-8?B?Z05pZXFUS1grOXM1U1NLUzVHb3hPYTN2WXVSVDladUJIU2JBMjhOWUJUMVRm?=
 =?utf-8?B?RUxNeDFibU8yMkpEczZGUnpMSEJjeU54NWlhWlp1VlRCdFZCd0FQbkowUVRj?=
 =?utf-8?B?TFdmelFzQjcxbkV6d3dadjZUSWJjUFpVaTQyMnk3Rmc0dHc4OU1pbmdvcFNm?=
 =?utf-8?B?S2NaV2c4bjhQa3Zoc2hHNVlYK0IraW9mWE1KYVY5eHVjeEZUV29jcUtIdUVH?=
 =?utf-8?B?OElrZXNiNjM5SkpDRGxkWEJFY3dUak9zd0tZcnQrWmxZZzFpeStXQndWMmZh?=
 =?utf-8?B?Ky96Vm9yRmNZZEQ0OEozMm5WWDN2V1RmQitWbHNBaWlRc2FGcFhuK0R5Nzgy?=
 =?utf-8?B?TnY2Rkpmek1sSk9RWmlRNjJNOFVZS2U0N1gybXluRFJ3dGVJMVc5YlBmQXFI?=
 =?utf-8?B?elhjMFFyd29Xemt2dDBGcldtcG1KL29JaTlCL2hoSHdYME9JT0laVFVNTUVK?=
 =?utf-8?B?MHBrNVFEVi8zK3RGeGFsbmN2dmV1WExWYTI2R0x3MStLVW5DeTRzZUhyVlpk?=
 =?utf-8?B?Mno3bFRqcmNMRjZ1WFl4Rnl0R1JUR0Z3L0YxK0M0cEFuOW1qNDdCc3k2Yysw?=
 =?utf-8?B?MGpLNUNOeXdpSTU5b3MxUnhOZkhYV3Y1RG45UHdHZkhmby9SSVhNOGlFbm90?=
 =?utf-8?B?M1NWVW5ZVFNHYTN5a2xGMmU0ZVhnNnpvQ1pobTNHQTlPSFZsMGJIR0ozWC9v?=
 =?utf-8?B?eVZINDZ3UEpjams0eDZXeDF0TDNza1dRdlNxdml6QjIwejUwODhtaFY2cDkw?=
 =?utf-8?B?eGVZWFpJVDdNQ3A2LzEreGhPb1JYQUtaWC9sbnN1OEU4MjZaMWxzNmlVTW9q?=
 =?utf-8?Q?/e1Ym8QuwSi4MFgQiMkCwxwKJWvCQgwkaYc4Gie?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkcvS1ZQSmdPRXVCSmNLcDJXK2QwZjYyNEdPdW5SaXdzS0NOWDcvcXhGbmg0?=
 =?utf-8?B?YjdCTjc0WDlZeTZhWmVBditzTGVIcW1paDU4OWFVZmlDK2lKMm9PNWtpVVRu?=
 =?utf-8?B?VXlQc3BzTSsxN1gwVHc2aHlUUUdvSXd4NnRxMmxySjVqbGhMcDl3WkxVOU00?=
 =?utf-8?B?MjBrdk9lUnZjRTdoK0lSaU5Pa0g1RGdSdUJ0OXpXOGlMb1A4OTY3eWh2SDhp?=
 =?utf-8?B?YUxkZUt4dGQyU1pTOFdzVUtQQit5L3JKcmtZTi9uNGhWOFp2b1ZTOTFRTEJG?=
 =?utf-8?B?dGUxQXRnNnE0Z0xYblFJbittZXNMVkh2cllVNkZGY2ZmeDhMWTZCQ1hLOFg3?=
 =?utf-8?B?RVRvNGIraU5IUTBvaFdtazBJLzVqSlRCY1JlV1JlTk1pK3JpemZ4Q2lBZTc0?=
 =?utf-8?B?dVRyS2o3T2VibHYxUFFwMUozVHh2cVZIQS93Z2htVXRVQkdrb0FPSjZWY2ww?=
 =?utf-8?B?UXFlVTY1dCtUcWRpd1MzaGQ4ZGhiQlhZR0lxaDFGdDh0SzBTenZMcFRXR0xn?=
 =?utf-8?B?ZWVWRzVaRm9vbCtFZUplWDlwb3daTjZCL3Nsajcwc2xYelFxTlg3WHFzY2lK?=
 =?utf-8?B?YTdHRmdnckYwazM5UkRkMXRjcG9URjhlU3h1STErdndkQ2xwRnFOMnc0TUpv?=
 =?utf-8?B?TllZVlkxUW5yVyt3WWlwZ3pWMTk5OTBSVlZmNjJ0aThHUGJhRnYyZkNWa01L?=
 =?utf-8?B?V08xZFJacWc3VWdDaXZGbnZxdjcvSHdic3BTQ2U4UzY2WDRKV2RPRzRIbGVB?=
 =?utf-8?B?akpIdDM2UVVSdnkzV1lwWjVTd09OZUlzSEoxb3JnVmgxOThvMlZzd1dhM2dm?=
 =?utf-8?B?Z3VZMHJ3dDcrbCtEcGdaRGJ2akJ2K1IyMUFqck9sSHBwQXZyK1RYREsrQ29S?=
 =?utf-8?B?QWNCVTh1V0hRYVFRdXZ4Y1c3WTRha2xLSm1UQzdjb01oTThoV2FZRS9nVkZU?=
 =?utf-8?B?V0MxSGM5SlRDQzR4T1ZER3MvQTlLUGRycjdzZTBIMzBnZHpNbHFNTkJ1NFg4?=
 =?utf-8?B?M0pQMHdBUWJVZEo3aVlNY2V6TnRoWHNuV3o5R2NxQS9kRWpuckU2T0xHNzB3?=
 =?utf-8?B?dW5iZHh3WTN4VC9xVktiVk1UZWpRSVBFdEg2WGwwL01VbU5wMTZseGJRZ3NH?=
 =?utf-8?B?SCtZSWRVVDZMbkw0ZXQ5blo5YXN2UlpnL052VWtpY0NrTlljbXBrcTRmZWlN?=
 =?utf-8?B?Qmk5S2FPS0pMVFpWenNhNFlEMm5iMlNmVXVZVHVLU0I5MytpVGxqcHBYRUdW?=
 =?utf-8?B?WHdFOHlmeE1jQlYxN1dpK2dzcVlYUG02Z0x6bnVScE9wWEVkWHJiTUJaN1FN?=
 =?utf-8?B?ZXcvS1dwNzM0eTV3RytMYVg4cllaU04yUUVYa3ZSaFgzOXp2eWw4eENBMjFz?=
 =?utf-8?B?SjQwOHFhY3NrYjZIUm5zMEVUdzhUbnUrUVc2MEd0K1hlN2ljS29IM3d2bjdk?=
 =?utf-8?B?dHA4N1d5dm52a0ZGUkVZZS9pTEMxYkkyQzBDSTlTaEtjMDFZb0JkeFVvRWsy?=
 =?utf-8?B?VUNUUjR2Mmx6NlJZeEpxUmZYMENia2NyZC9tdWdGSmcycnN1eXBXdzdVUGZC?=
 =?utf-8?B?NkZ2K0NMY2hMTDRUUG5BT2xkaHgzYm5UMEsrdFVTRVNOM2RjTmkzNzgyalR2?=
 =?utf-8?B?cWRMbkNReEllQXZ1YnpVSE5xbDlaU0Eva082MlpLRGdPTEkreWNwVGtEeHhW?=
 =?utf-8?B?OFFFVW95a1JzZFk5eEdORjk5UVNqYTljdGlwV1dYaDg1YXVDb1pUZFNnWkVq?=
 =?utf-8?B?TGpNU2NZMXpzNzlFaExCTXVkL2RMZS8zNFhKMjBDa3I4dkJIbUNvSzhrNXRQ?=
 =?utf-8?B?NDhBTXZqdTl1RVNtMFM2Smdtd2lXMGIrL1RUSWhNZjhaTDVSWXVVV1JwQ29w?=
 =?utf-8?B?U0F0WHREM3NkeldlTlNMZ1grWWNkbjEyeWZ6RXdNenVuWGpDL3RQVFI5SjJL?=
 =?utf-8?B?Z2FwRTFHOS9JTUw1WjcrWHNiWktBb2V6UHZYWGdMZnl2UXV1RkhGSzhoODVJ?=
 =?utf-8?B?NUsyMG1pVWZXVGtMR3p0V1dPZVhWNktsU1JRSS9hd0VBbU1YZjJuWlpoc1dJ?=
 =?utf-8?B?dXFhMGtMY1NFTk1kWTZxckxlaHhleHRLNGJUSHNhdmw2VlZvMUxYcmw2eW1T?=
 =?utf-8?B?RjFQd1JGTWMwSWZnWm9CeTBIRkxwSWU4b3RDVW4vMENnQlBZUXRENGpuRFhl?=
 =?utf-8?Q?6Ro2XRHmXAIzNnsMit4boYg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	16D8n2lT1kTkgrRdZK3zguwAMOvVisM6HFVnPt7sgS8o18S1ak1opS0N6fFwCHm43lcBb05FNlWtK7YNICt4lCeSd1KQP01Q+lZtuEEvHS3dZVyT5NON85YjjR6f944CYDZ4MfoUAUQ9Cf9wU7YJOkxREIf7VZbgXlPo+9RJALLRg0YqSb3uuee23t/0Y+haJY7Gp/iqwZqEXzXpXCOT7ztlQyuG44dYfEeoJQelFPvdwsGnOxsz0nNHchU8Ooa7ttb5yVkmj0RgAyRw3MaHUaqANSu8Ln/uq5LM7/GNO5m8p7ohGdjiHCVn46G1/pQJcixa523h6xf9TUm87ItcCIWKyvKzOKbv32jKhMQydKC1Akaj0jL4hCwksKLFxWR8Sib8k9YUShE1bAq4HHm1h3V53oEKogHgGDBCJ8ThIjrP76Eza63aUUnDxFv4lbsSwvMmdgjCfCEYgCFIOXEJyF2yJEFphFzmcRLF9bIPL/HRB3AbgLdc8iJsNiI1RI0UJhUvvB2iebhgjKabV7vSyj/ZU9KUKJqDbIlPuBAUiSFRTH0YCIQALe9ZL04Er6YTl73giMGE/cmNLl1broUQbJ+z8bOLKbQ4ohXOpEHwCwk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160da32f-0bc9-4de5-3901-08dcef59e635
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:47:38.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsH9gQKWVWBbvPvzL7yQaTWQG+eWeuMo6dItQd8Owkn97+fg/o1bBj2MVWTi+ODWv1wZepqkchvah7B6aysnSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_05,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180061
X-Proofpoint-ORIG-GUID: lAVy0na7hMpaAbLE3snCU1MoLRfqxEry
X-Proofpoint-GUID: lAVy0na7hMpaAbLE3snCU1MoLRfqxEry

On 17/10/2024 23:03, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	While testing the latest patches on a fedora 40 system I
> noticed:
> 
>   Compilation Unit @ offset 0x77fda3d:
>    Length:        0xd527 (32-bit)
>    Version:       5
>    Unit Type:     DW_UT_compile (1)
>    Abbrev Offset: 0x38012d
>    Pointer Size:  8
>  <0><77fda49>: Abbrev Number: 6 (DW_TAG_compile_unit)
>     <77fda4a>   DW_AT_producer    : (indirect string, offset: 0x4ec527): GNU C11 14.2.1 20240912 (Red Hat 14.2.1-3) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret
> -in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mindirect-branch-cs-prefix -mfunc
> tion-return=thunk-extern -mharden-sls=all -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu11 -p -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fcf-protection=b
> ranch -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fpatchable-function-entry=16,16 -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-pro
> tector-strong -ftrivial-auto-var-init=zero -fno-stack-clash-protection -fmin-function-alignment=16 -fstrict-flex-arrays=3 -fno-strict-overflow -fstack-check=no -fconserve-stack -fsanitize=bou
> nds-strict -fsanitize=shift
>     <77fda4e>   DW_AT_language    : 29  (C11)
>     <77fda4f>   DW_AT_name        : (indirect line string, offset: 0xfa3e): rust/exports.c
>     <77fda53>   DW_AT_comp_dir    : (indirect line string, offset: 0x4db): /usr/src/debug/kernel-6.11.3/linux-6.11.3-200.fc40.x86_64
> <SNIP>
>     <78078ce>   DW_AT_name        : (indirect string, offset: 0x5310d): __UNIQUE_ID___addressable__RNvXshK_NtCshatLywNUlpX_8bindings12bindings_rawNtB6_28mei_connect_client_data_vtagNtNtCs2vSfyxKMEZc_4core7default7Default7default1222
>     <78078d2>   DW_AT_decl_file   : 4
>     <78078d3>   DW_AT_decl_line   : 740
>     <78078d5>   DW_AT_decl_column : 1
>     <78078d5>   DW_AT_type        : <0x77fdac9>
>     <78078d9>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0     (DW_OP_addr: 0)
>  <1><78078e3>: Abbrev Number: 1 (DW_TAG_variable)
>     <78078e4>   DW_AT_name        : (indirect string, offset: 0x51af69): _RNvXshL_NtCshatLywNUlpX_8bindings12bindings_rawNtB6_13hda_device_idNtNtCs2vSfyxKMEZc_4core7default7Default7default
>     <78078e8>   DW_AT_decl_file   : 4
>     <78078e9>   DW_AT_decl_line   : 741
>     <78078eb>   DW_AT_decl_column : 1
>     <78078eb>   DW_AT_type        : <0x77fda8c>
>     <78078ef>   DW_AT_external    : 1
>     <78078ef>   DW_AT_declaration : 1
>  <1><78078ef>: Abbrev Number: 2 (DW_TAG_variable)
>     <78078f0>   DW_AT_name        : (indirect string, offset: 0x83a79): __UNIQUE_ID___addressable__RNvXshL_NtCshatLywNUlpX_8bindings12bindings_rawNtB6_13hda_device_idNtNtCs2vSfyxKMEZc_4core7default7Default7default1223
> 
> That caused:
> 
> acme@number:~/git/pahole$ tests/btf_functions.sh 
> Validation of BTF encoding of functions; this may take some time: PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsa_NtCs2vSfyxKMEZc_4core4charNtB5_11EscapeDebugNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator3len57').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator4next59').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator9size_hint60').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator5count61').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator4last62').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator10advance_by63').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsf_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits12double_ended19DoubleEndedIterator9next_back64').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsf_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits12double_ended19DoubleEndedIterator15advance_back_by65').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsg_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator3len66').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsg_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator8is_empty67').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXs0_NtNtCs2vSfyxKMEZc_4core3net6parserNtNtB7_7ip_addr6IpAddrNtNtNtB9_3str6traits7FromStr8from_str95').
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXs2_NtNtCs2vSfyxKMEZc_4core3net6parserNtNtB7_7ip_addr8Ipv4AddrNtNtNtB9_3str6traits7FromStr8from_str97').
> 
> 
> At first I thought that was from Rust source code, but nope, its things
> in C to connect to Rust, have you guys thought about this? The warning
> is not that good, invalid why? Lenght of the symbol name?
> 
> Its the end of my work day, so I have yet to think this through, so just
> reporting it here to initiate a discussion.
> 
> acme@number:~/git/pahole$ grep RUST /boot/config-6.11.3-200.fc40.x86_64 
> CONFIG_RUST_IS_AVAILABLE=y
> CONFIG_RUST=y
> CONFIG_RUSTC_VERSION_TEXT="rustc 1.81.0 (eeb90cda1 2024-09-04) (Fedora 1.81.0-1.fc40)"
> CONFIG_HAVE_RUST=y
> CONFIG_RUST_FW_LOADER_ABSTRACTIONS=y
> CONFIG_BLK_DEV_RUST_NULL=m
> CONFIG_RUST_PHYLIB_ABSTRACTIONS=y
> CONFIG_AX88796B_RUST_PHY=y
> CONFIG_HID_THRUSTMASTER=m
> CONFIG_THRUSTMASTER_FF=y
> CONFIG_TRUSTED_KEYS=y
> CONFIG_HAVE_TRUSTED_KEYS=y
> CONFIG_TRUSTED_KEYS_TPM=y
> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> # CONFIG_SYSTEM_TRUSTED_KEYS="certs/rhel.pem"
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> # CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN is not set
> # CONFIG_RUST_DEBUG_ASSERTIONS is not set
> CONFIG_RUST_OVERFLOW_CHECKS=y
> # CONFIG_RUST_BUILD_ASSERT_ALLOW is not set
> acme@number:~/git/pahole$
>

hi Arnaldo,

thanks for the report! This is as you suspected due to the name being
longer than KSYM_NAME_LEN as checked by btf_name_valid(), but we should
skip it anyway as __UNIQUE_ID is one of the filter prefixes we skip in
encoding. If we just reorder the checks we can avoid these warnings I
think. I've sent a patch for that [1]; if you could test it (or can
point me at a vmlinux with the symbols I can do so) that would be great.
Thanks!

Alan

[1]
https://lore.kernel.org/dwarves/20241018094301.1550149-1-alan.maguire@oracle.com/
