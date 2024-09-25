Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9A158DC3
	for <dwarves@vger.kernel.org>; Wed, 25 Sep 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258863; cv=fail; b=LbIxVY6BBkk09q9UsWeKUhoeH7xVHXJ2qQTAvieGtFasBwcS334R58YUhG2NAFhgnWW4D52if8lA0lwpaNBfGf2+5sNBd10lBL1zf+1E05b8qYltUkWNbv1Vka34277Z4eSIqtBsi5Jq8HEuEREQR/trOE2/glGg4Af1k6Nie7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258863; c=relaxed/simple;
	bh=HtGwEB/ywoITsAJtOdTY/G8IKQX0UXhULHZJctWd0/o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ie9Ck+DCR9AUw2yr2Kpb8bMvBDxO5Jni7Go5wiyPPspX+2cV8tR/gpR9szwq1r04yRPpdIz/80E5ACo54Kf6UC9gKgS0DXltd7Vf7//VGW7X9mymTYMZemTkW8+FKwgkLFCxpqCHHT3FiJ9RsaDTIpnOXjDmi8XA+hyE/PBQ7J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kt7WyrUZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kxhOVUau; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kt7WyrUZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kxhOVUau"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1tlMe025371;
	Wed, 25 Sep 2024 10:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ZknAeRcl7LNIfMx3CaVzvzBUhrGQc2sKqy2jOtATH00=; b=
	Kt7WyrUZkBHX7Y7i62NHBGjE/PcZa/SAnRnpwrA+UVUf2JMadf0NNC3gYRQXMxR1
	ohYRReaVD3A4KaUvsiA7JyQyxO3bJqWHL1739Tt8xPNtFgjkAoKAX8MFSIKTWDbJ
	NXyH4MZKNE4j2CZcAMHqktPZRAcrPdpMTJNNlCF2WZ+8+9XYRnPyAqwA7vdJsZGH
	ko8lZeP2CLOF1zPLITRSqjEO8mLIBaJIG+/1nXlRvqNAXQ+tP/AmoFGBrb1jma0I
	SranA3JBEaBexcq1pu/5wUtgDBoRpyOgSwp7e5par8xgTlXokcyK0RcwXCGKPueP
	lvY/6R4U1VGs4haJ5voQCg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6cfg63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 10:07:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48P9V7VE030385;
	Wed, 25 Sep 2024 10:07:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkagm06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 10:07:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liUxUZW9AVzNe2hAFxwUWETJgYxLxgRjyFUp45Q6czAyxJlJvwrPXtHZ3AFri2sTrpuxnr6LiiYmulJrlChKwQre8+SpCmtpMqXgvZM3Zw1FAKW6UmSCD0m/IXsqmUoVsDZr8FUWV0umQTRaMWaKSaxsikpHZ8ElY2QzGFfsEhe+9glER/sOIm7y5Od3fUFLBJY8fi/U5AX52WdvhGENjjNQc9e9pS/p/YwZgpRnVRc9MxwQhl96cseGAMAGRGRQAe/YIP6C+a8eyjJQA6hUOArLzD14JY64Sy/jhw4nl+ez1LWNMzqQdulrNbFqSG74kxlGX4iACSeP4IgAt/lIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZknAeRcl7LNIfMx3CaVzvzBUhrGQc2sKqy2jOtATH00=;
 b=BA83Wz81orVWcoh9ZKqdbJqSKE3+lAXuB7gEefI6rHeJ4H1Bm208QHdnsafxgRWcfLhDHfyTU49LOI22ClknjIRgedUfkbBCDgcv1n7w+rx7YLk3nq1km6qsHIfnNeEwyqbOYAqMnq44pKqZQGAZcSzJuCmr9NzYf8Nbl/O8pvCPwWUVhHOlsR9MV3AmwdV3Gq6EIu5Z7x16XZbBwVUipoeDTRpI+PSN0frEUdC4AvTJly6SDQCCAk+A0CKH1evyFfW3bxqtVqik8ntfiDTf7JVAh5aUOm1VDwngcTjmB7718H07mVtSAREOOxTCt5JbqGAF/ZLQYKET7WDfBhBclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZknAeRcl7LNIfMx3CaVzvzBUhrGQc2sKqy2jOtATH00=;
 b=kxhOVUau8g38GAEe//o+xHNKyCrV3foonrBJgvLyZXTAqQzDZlPeM7ObxCcCglQYZVKX3KIA8j6uZl03MQNYEqtbB2Bb4oaiiEbJ+6SwwMw/fADemkfUKodTUmLd2H/trzFo7HLK3Gk7EHtqRprKGZJ8T3Wm0yTWjSVhmnFDgkM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB5914.namprd10.prod.outlook.com (2603:10b6:930:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Wed, 25 Sep
 2024 10:07:36 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%6]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 10:07:36 +0000
Message-ID: <f66e0667-37d8-40e7-9642-fc3bfa9ce678@oracle.com>
Date: Wed, 25 Sep 2024 11:07:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 v2] dwarves_fprintf: Handle pointer qualifiers
 correctly
To: Will Hawkins <hawkinsw@obs.cr>, dwarves@vger.kernel.org
References: <4f09aa78-8a42-44dd-a685-37d6b9db7415@oracle.com>
 <20240919033057.2658569-2-hawkinsw@obs.cr>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240919033057.2658569-2-hawkinsw@obs.cr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 860ef064-cd4e-44c9-f225-08dcdd49e178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3pTVG56M2k2cjdCYmJtSS8vR0ovWlh0WkFWWUpiS0ljNVlDRlE2VkFnYUpo?=
 =?utf-8?B?MWJaMmNpbDVRQ1NCM1cvSi96ZXhpb0NHcjRpc29yTzBxWlpuZ2NMYzVKU3Bx?=
 =?utf-8?B?bStzQys5WFVLKzVuQlVpMW1hT3RrVkJlL0M3eGR4K1R1TExxcWlaSGc4WUJW?=
 =?utf-8?B?SElMSk9FQTFTNVpaVVgyRG9jUmd2Y21VZWpSTHAwbi80MDF5UTRpekZHb2pV?=
 =?utf-8?B?dXdOS1pHY3NpbjZKeEVXa05nN2lJQnlQOU5NSVJxRU9JN3duMHBSS2JqOUx4?=
 =?utf-8?B?M0Y1WDRTcHpJOUhNVTRaTDFSa1RPZGt3VjhINEdOSXpsTUJHeVpkOFdVN3pW?=
 =?utf-8?B?aFZaalhzbzZ6Zks2OWoweFBSeFZIblJxMXhmZVhoV3pXOUhGOHc2YUlUNjNX?=
 =?utf-8?B?cnRtaVhUSEpQc3o0U1VCLys3eCtPc2Vwc3RXVzkzN21MNUQyeCs2aVBvdEl6?=
 =?utf-8?B?Q0FtTnYzN1dieGJvWlF6WGl5SVVvQysvRkpNZC9lN0RVSWlSTHlaOERSVkNk?=
 =?utf-8?B?RUxjeFpUZytiQ0dJSFJ3UnkwNWd4bW5Qa1NDQlBwZUQ0aHhIYjJTSVhtZ0dB?=
 =?utf-8?B?UzFrWTUycCtSaURhd0ZHV2RIVGlJK05BNFBvTEhGYWt2WCswZkFhR2VHa3lD?=
 =?utf-8?B?ODQ3Ym52SHRhWUk3d2RUTndlNUhPK3crWDJoTXRyS2xjdzVPMThueGFiVzFK?=
 =?utf-8?B?cHdNTzhUeWFwcUxPUmJKK1RsK0RIWkFwaXpGbnRnNSthMXhxdGdhc0s4R3kr?=
 =?utf-8?B?aW9zR2lMSUtnQXFZM1grN0JhbEpNMFFWdlVkaFdlMHh0Y3JTbktOblBScEs5?=
 =?utf-8?B?ZmN5cXFLMXdVY1J2S2pRbVE0Z0tkQkpydzIySi9tc1pOUWhDbzBZYkNnenIz?=
 =?utf-8?B?ZDlTZVMwVVYvU09maW9aT1V2Wm9KVy9QWjdjTWl3TlB3Mk1XMC82Zjltdy92?=
 =?utf-8?B?TU5qcm1rSnczdEpIN3k0T1VxbXZvdmFPOWFuSGpCYjB5MENPQWRSZGJzUFJZ?=
 =?utf-8?B?bS9vdDEzZFVSWEhNcnZCYXo1Ukh5T1RGYk1pVkpoS0srMlplaDJWWUl5Umw1?=
 =?utf-8?B?VGRBUld4WXM1NnVCblBCMlZaRDI1cWZBTitMNHg3ZG93NG1iUWJYVjNQUWpT?=
 =?utf-8?B?UHErQXNVdjZHaCt3MUhyWXVZclhTK3NNRjgxYzVGbEJHSVJOWHE5SnF6OHBu?=
 =?utf-8?B?bWp6NG5uU1VsNEpsM0lFeHU4ZVZTdXN3Z1o1Y0JvK2dtemNyT3c4VXlVWkRE?=
 =?utf-8?B?UmFIU2RqOWhoQ1FwRjZaWFllNFZhOXVrb1RoYk9tOFM3dXRGUTRtczM4RG9a?=
 =?utf-8?B?MjUweXNnRDE2OW4zTkZuV0NkQ3hvRnBIeEhMY29KOG9MR0ZEanF3VUtBTTEz?=
 =?utf-8?B?dVdXd2J1dVo3bkRzcm1Ob0xrS1JYWUJUZXRvbklpQkQwbmN1TFVpWklja08w?=
 =?utf-8?B?a0R6TmJTb1ppWk1Ud29sMTJCZ1VqRmdwR1Q1Sk44c1lKcEQ4elVaZVdnamkw?=
 =?utf-8?B?K0o2YXhOVzhWZGhnanBvS05QMW5WSHZzclkxbkNIUEo3MktxQUlxZG52RG1a?=
 =?utf-8?B?eFlUbStINUZGSXJjcWhZQTFQYXMxTG51MnhvS2Q0UVlCbWxlak95WnNvUHJW?=
 =?utf-8?B?a1ZWSTNBaDZJRVV5TnhvQWcyV0FUL0NocHNteVQ4dGFQcm9ob29mUnRuOEpi?=
 =?utf-8?B?MGZIRFh6TWFvaTAyb01paUZGK0xWZkhRMDcwY1ZTR2hBNWlMeXBEZzRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVB6UkRGMk91Qk5xeVp4M1loY09vZGNJdzZLZEg5RTVwdWRHNmZuUXppRitt?=
 =?utf-8?B?L3A2SzNRY2lIOFk4MVA4dTg4NXRhaHJJNnVUWHNVeEkvZnNqRUFPcWZGY0pC?=
 =?utf-8?B?THh4Rm8zeUVZOFJkeWM2UjE2UVNFVHlNTDVibHZvUXBSemxEMmt6SDVYcWJH?=
 =?utf-8?B?T1VEa1ArQzBEVzA1ZHZNaXV1bDZoenAzSDNWWTg5Z1ZqZzdJWXczNVhIWE5G?=
 =?utf-8?B?VkM2ZnhPSlJRMGFWMU5UeGpIUEJUZTBaYUhSWVhJMFV2R2RkTUdvN0RpNWNL?=
 =?utf-8?B?TEhmT1BndmlZbkNISXhTblBJTjFSVzR2Z3ZleGhHM0lCL2RxL1ZTUGFWb2lZ?=
 =?utf-8?B?cmJkMEtvcnZDc3BKY0VsYmJxVjJVZmFyVGc3Tkxod3J5ZXd6cmtwbjNYSGR4?=
 =?utf-8?B?OTdDMTgxSGkyNGM0NlpUc3JBN3hVTlpIcmVKY29XbmxxNGxWV1RyTHVnd2Fh?=
 =?utf-8?B?eWpNT1g5aG5XVkJjUytSbHA2eEdtUUNYbHpIeXYxVUIvVUJyN3JWVlpPdFV3?=
 =?utf-8?B?MXlRc2tDRzFJQzcwMmF2bHFTWjdpQWkrMDBHc3lUaXkrcDN5ck1zOWRsVDlm?=
 =?utf-8?B?T2Y0eVkxQStjV3EyM1gyb2RNRlAzMXRyTVBvalRxRUFFSlBvRkx1REtZQ29j?=
 =?utf-8?B?YmtuTC9lMXI5VFJQYWRNM3NseUg5Y0QwZHh1MGwrMWMyWVkvd2pQaSs0MVFY?=
 =?utf-8?B?cU9sT2luZGlWMjBYaElvV05Dd3IvOUxqT1R3ZXE0b01WWGtGT0JUamRJb25w?=
 =?utf-8?B?OWFCV3J5dHBnRWJWbzNPUVlZalJPT1B5eThQRlZyQTdRa05kdkN6aVRrR2Iw?=
 =?utf-8?B?SkVuYWt0b3RkZmNzNzJJTVNwTW11aExtbTRhcEhxV1BRekdJbFR4MWFLZ0Ry?=
 =?utf-8?B?Ty9zMWlWbkZ0ckZQRXpiWFdCQWhpNXdrZ0RhMjRFUWFpdWRCd2tLUEJtZXVi?=
 =?utf-8?B?WGRJVTFKVmt6akNsZ0lPeTROaEZPbVM0Ym95SE1Bd21zcFdRS3VsSXBBQXJ2?=
 =?utf-8?B?SW1WSHdXVE1TNlIwRlRCYVpScWtQSGNOa0ZUN0RWdmJ2V0dlc1hMTnJaZXdz?=
 =?utf-8?B?UXU5THE3UU1CZDZ2T2RwZDhyanFWQWMvOEZlcFlPejVvTzFXL0pkd1kwTVlm?=
 =?utf-8?B?dkZ5OTlqb1RJcjJ6RHlEdHpVQVJRU241emdkTHprQnBIM1F1Z2RsRzBQaTdi?=
 =?utf-8?B?cSt0My9Yd3NNZDV3ZnY1UHcvOE1UZ3FzS0xEcDMwdHJLZ1FGMlV1Z0VpbUNk?=
 =?utf-8?B?RUZGM0Z1NEt2MFBZYWJtSzNFTFIvdUJrdnZmTWs5ekdTZ2szTWc3aksyVklO?=
 =?utf-8?B?dy9ES0FNUFhoNUlQSFVaNmZ2QzZveEkzQTBQSVhQbXJGU0NqN2VSRFZjVS9G?=
 =?utf-8?B?aDhNZ2lQMVRlMXBySmVSSlZPaTRMZ3l1RDB0Mjl2QWoxZm1PTnBUU3hDRTQy?=
 =?utf-8?B?ZkRXazJkOWV6cDA3ckZxWmJTTkFnSFZFdDdCTitsY1V5YUwxOWdBWmFXOGhJ?=
 =?utf-8?B?RWIwaFVMQ2YzeVhvYm9OMHhQR3BGSGFmK3BPeXcvQm5teTBEejhYYUxTcUhr?=
 =?utf-8?B?RkpheUlNVGNHYVlvdzZ3aGhiL1BwYkc3TjhnRDV4b2l4T0E3TFNHbXVDcnM1?=
 =?utf-8?B?LzVueCtiTnRrL1dhSkJDRllZcFNORWVKZWdPaFRkRXhFaFZPMSt2RmRXVUZT?=
 =?utf-8?B?TGdFVlNnQ2MyNDFlTDFiYndVL2xRYXBaRWNjZ1U1Tmdub0p3OXY1aUZ4Smdp?=
 =?utf-8?B?cGdMQnQ2cGdWRytvT0Rna1FyRXduNDQ0MmRaSmVMNElCbkdFKzZ4MnAzb3VC?=
 =?utf-8?B?dUo3K0VkcFF2djNUL0dTU0JwOUF6OGt5WFVLdTVZVjZJZHJkRko5MDNDUjFt?=
 =?utf-8?B?eDBVLzZ5dlpyRklRL29Zc3lrR2hwcU5ZTEt6WjVnTjVsbDh2N2VjTUtnN09U?=
 =?utf-8?B?aFl1YUthbEJOZUgwWTE2bkE2US95SURaNDNUbExoUWw0bjhLUC9RY0srTWNt?=
 =?utf-8?B?dzFEdlhqWDlBL1gvL2I1bnBhWjM4UVFaMzRqQnh0V2w4RHR0emhrWlR3V2lp?=
 =?utf-8?B?cWZnYWhmeTYvMlBMS01HanR5RzdnaGFmRWJtdnVJdFhEYTlRQ1p4SlJZMGl0?=
 =?utf-8?B?N0hRRlEzK3o0UWVaZXJ3MUMwOFE5alJiN3hvUDRScnV3US9MeWVzR0s2M3pC?=
 =?utf-8?Q?JH+QmqNok5OaAAY/bRyFU0s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SgKGuCaAfdIZgGxJpVEPnumjA20s3M4BfP/725Mk2RDW08E2dZIUdgAHFC7QloueV96piqMBzRHwB0CpCCKWxa8MD2cJqKSVfN8/7V/LyUDwU1lmEKrja9Cb16qyMsp1nOnghgGKpwfl7+T7yQ9/FNpkA5kQUO8T6wsYEkdp32x2vDcN3t85nZp0cojikgVEsGpATgqTWvZBi+JdgshNksRTF3estFojSexTQtwfPnsAUf8t/GsVS4E2IvcN1Ub7HYkHadYUCybQMfZntgT/1gVhd0SR1LvpCqS57Jlak3Ye/TULbfGiR25/Oqgnd6pJYEzw+F/mfP82zVD2EN2XC2yXZfbc6cLiiFtFStDVfdfTNJ3i0lzWrTF2XqGFU7i7noofg/wT7fiapRyrBVa758eABIxxQueSaShzNBHfbHWV+Jmot1KCB8ogqUov9eUQR4RbEr8LUm+5xgWCA30tHAGe8/1U49b3Eg8RoDQWu+090V2k/gE/NUMKYxGIWPYZTyOxBSwTXlp7sUToL5Gg+y8fqm3xVOvc6nbofRrgCrTchTljlpyeRMdFF4un/Z1ciNbOZV74CsoJETji/EQFgnz8oEfpQMdmL3M60gO+p/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860ef064-cd4e-44c9-f225-08dcdd49e178
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 10:07:36.6301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdg4zhxJbyR+/rGpqEhk22VlDH0h76HfWKpJ2kkEU1KBuCGDkFs2EElIV0VNYC9tqrmmw7WzVeJr5TUJJKVXQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-25_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409250068
X-Proofpoint-GUID: kCWL1fXY4ULkIn6lZ0elPoGToJJpTn58
X-Proofpoint-ORIG-GUID: kCWL1fXY4ULkIn6lZ0elPoGToJJpTn58

On 19/09/2024 04:30, Will Hawkins wrote:
> In certain cases, type qualifiers were attached to the wrong part
> of a type.
> 
> In C-like languages, a basic variable declaration can be augmented
> with certain _qualifiers_. Qualifiers are used in declarations by the
> programmer to specify additional properties about the type being
> declared. When it comes to applying qualifiers to pointer types,
> placement can sometimes be tricky.
> 
> Because of the hierarchical nature of type encoding in both BTF and
> DWARF, the representation of such confusing types is more natural.
> 
> For example
> volatile -> ptr -> const -> int
> is the "chained" list of types that will exist (with a few minor
> differences between the formats) for BTF and DWARF to encode a
> volatile pointer to a constant int.
> 
> To display types like these correctly, the modifier that applies
> to the pointer must be a suffix modifier printed after the pointer,
> and the modifier that applies to the pointer target must be printed
> before the pointer.
> 
> This patch teaches the dwarves family of programs to print qualified
> pointer types correctly.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

Looks great, thanks for adding these valuable descriptions!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Future work for us as a community in general is to improve automated
testing ; in the case of functionality like this, we could perhaps look
at adding some simple programs that exercise complex type relationships
and verify that everything is printed as expected. If you wanted to add
a test in this area, your example from the v1 cover letter would be a
great addition. We've started populating the tests/ directory, but more
contributions in that area would be really valuable. Thanks again!

Alan

> ---
> 
> Notes:
>             v1 -> v2:
>                     Add additional comments inline.
>                     Properly format comments using /**/.
>                     Be more verbose in the commit message.
> 
>  dwarves_fprintf.c | 90 ++++++++++++++++++++++++++---------------------
>  1 file changed, 50 insertions(+), 40 deletions(-)
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 54d2fc2..2c53638 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -542,16 +542,6 @@ static const char *tag__ptr_name(const struct tag *tag, const struct cu *cu,
>  			char tmpbf[1024];
>  			const char *const_pointer = "";
>  
> -			if (tag__is_const(type)) {
> -				struct tag *next_type = cu__type(cu, type->type);
> -
> -				if (next_type && tag__is_pointer(next_type)) {
> -					if (!(conf && conf->skip_emitting_modifier))
> -						const_pointer = "const ";
> -					type = next_type;
> -				}
> -			}
> -
>  			snprintf(bf, len, "%s %s%s",
>  				 __tag__name(type, cu,
>  					     tmpbf, sizeof(tmpbf), conf),
> @@ -612,25 +602,68 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>  	case DW_TAG_restrict_type:
>  	case DW_TAG_atomic_type:
>  	case DW_TAG_unspecified_type:
> +		/*
> +		* In C-like languages, a basic variable declaration can be augmented
> +		* with certain _qualifiers_. In C++, the standard refers to them as
> +		* cv-qualifiers (decl.type.cv). In C, the standard refers to them as
> +		* type qualifiers (6.7.3). Qualifiers are used in declarations by the
> +		* programmer to specify additional properties about the type being
> +		* declared. When it comes to applying qualifiers to pointer types,
> +		* placement can sometimes be tricky.
> +		* Example 1: "const int * foo": The target of the pointer is const.
> +		* Example 2: "const int * volatile foo" means that the target of the
> +		* pointer is const * ("const int *") _and_ the pointer itself (volatile
> +		* foo) is volatile.
> +		* Example 3: "volatile int * volatile foo" means that both the target
> +		* of foo _and_ the pointer itself are volatile.
> +		*
> +		* Note: cdecl(1) is a fun command-line tool for helping decode the
> +		* meaning of these complicated type signatures.
> +		*
> +		* Because of the hierarchical nature of type encoding in both BTF and
> +		* DWARF, the representation of such confusing types is more natural.
> +		* For example
> +		*
> +		* volatile -> ptr -> const -> int
> +		*
> +		* is the "chained" list of types that will exist (with a few minor
> +		* differences between the formats) for BTF and DWARF to encode a
> +		* volatile pointer to a constant int. To display types like these
> +		* correctly, the modifier that applies to the pointer must be a
> +		* suffix modifier printed after the pointer, and the modifier that
> +		* applies to the pointer target must be printed before the pointer.
> +		*/
>  		type = cu__type(cu, tag->type);
>  		if (type == NULL && tag->type != 0)
>  			tag__id_not_found_snprintf(bf, len, tag->type);
>  		else if (!tag__has_type_loop(tag, type, bf, len, NULL)) {
>  			char tmpbf[128];
> -			const char *prefix = "", *suffix = "",
> +			const char *prefix_modifier = NULL, *suffix_modifier = NULL,
>  				   *type_str = __tag__name(type, cu, tmpbf,
>  							   sizeof(tmpbf),
>  							   pconf);
>  			if (!pconf->skip_emitting_modifier) {
> +				const char **modifier = &prefix_modifier;
> +
> +				/* If the modifier is addressing a pointer, then we will need
> +				 * put it after the type that is being printed.
> +				 */
> +				if (tag__is_pointer(type))
> +					modifier = &suffix_modifier;
> +
>  				switch (tag->tag) {
> -				case DW_TAG_volatile_type: prefix = "volatile "; break;
> -				case DW_TAG_const_type: prefix = "const "; break;
> -				case DW_TAG_restrict_type: suffix = " restrict"; break;
> -				case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
> +				case DW_TAG_volatile_type: *modifier = "volatile"; break;
> +				case DW_TAG_const_type: *modifier = "const"; break;
> +				case DW_TAG_restrict_type: suffix_modifier = " restrict"; break;
> +				case DW_TAG_atomic_type:   *modifier = "_Atomic";  break;
>  				}
>  			}
> -			snprintf(bf, len, "%s%s%s%s", prefix, type_str, suffix,
> -				 pconf->no_parm_names ? "" : " ");
> +			snprintf(bf, len, "%s%s%s%s%s%s", prefix_modifier ? prefix_modifier : "",
> +											  prefix_modifier ? " " : "",
> +											  type_str,
> +											  suffix_modifier ? " " : "",
> +											  suffix_modifier ? suffix_modifier : "",
> +											  pconf->no_parm_names ? "" : " ");
>  		}
>  		break;
>  	case DW_TAG_array_type:
> @@ -833,8 +866,6 @@ inner_struct:
>  		tconf.suppress_offset_comment = suppress_offset_comment;
>  	}
>  
> -	const char *modifier;
> -
>  next_type:
>  	switch (type->tag) {
>  	case DW_TAG_pointer_type: {
> @@ -870,7 +901,6 @@ next_type:
>  		/* Fall Thru */
>  	}
>  	default:
> -print_default:
>  		printed += fprintf(fp, "%-*s %s", tconf.type_spacing,
>  				   tag__name(type, cu, tbf, sizeof(tbf), &tconf),
>  				   name);
> @@ -879,26 +909,6 @@ print_default:
>  		printed += ftype__fprintf(tag__ftype(type), cu, name, 0, 0,
>  					  tconf.type_spacing, true, &tconf, fp);
>  		break;
> -	case DW_TAG_atomic_type:
> -		modifier = "_Atomic";
> -		goto print_modifier;
> -	case DW_TAG_const_type:
> -		modifier = "const";
> -print_modifier: {
> -		if (!conf->skip_emitting_modifier) {
> -			size_t modifier_printed = fprintf(fp, "%s ", modifier);
> -			tconf.type_spacing -= modifier_printed;
> -			printed		   += modifier_printed;
> -		}
> -
> -		struct tag *ttype = cu__type(cu, type->type);
> -		if (ttype) {
> -			type = ttype;
> -			goto next_type;
> -		}
> -	}
> -		goto print_default;
> -
>  	case DW_TAG_array_type:
>  		printed += array_type__fprintf(type, cu, name, &tconf, fp);
>  		break;

