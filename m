Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E235DA69;
	Fri, 25 Sep 2026 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319600; cv=fail; b=hQ9wpz5MV3gQ85PMNtszwgd2p7e30F7tMpIXKLNK7vFes6PF0R3D5Dg5SaZQF9M78F3q4usfQn9GK7RBXg2/DgwLx65F3B7H4VMSMWTaPE9cChbR6GqLlzyzTPOvCjtsG+HpBJVXY/ycDK26KZ2gD1PZq8npcnigUtda82ixnmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319600; c=relaxed/simple;
	bh=o8uJ6axGr8QNKNWKhk7PZJF8sPlGUA/K0hfDE2CFpAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0Mk4eN9iLmcvOrh4PIVoceTgZ88uCoT8dAwiHQvlqj80D0f+5jC77QhfZSWoOnG/CjhHV6+JNt0Mrox8SYr+c6RdYExN/ex1cdensXgLiE4X6Rqjd+M6uIFFzFOHtmpYnxs93lZBD538/uss4mDKul2K0k7jBIQv1vsiHx5njY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VHaoryzN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c+E4O4ZK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VHaoryzN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c+E4O4ZK"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OLMsSZ2150487;
	Fri, 25 Sep 2026 06:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4DL7Dz5G3ZotnJv0xwbhpsNYyzRBZPSBXJGn3PPTwhY=; b=
	VHaoryzNN0kmbY/KEGCi1Msv2BUVxiuby4Nmzcs5Z4jGf4zh7ViGSsMzbEhvV+Ts
	yKs0wyPLdlfAniSUUYkrxpvleo2NJOBG8aIOtQmEXK+aPenZsSgYYN4oQPgfbtOu
	SIWDDbwubLx5L92Qtfa9tRet1QUn9v+S9S0KNSU1Tbq9POawljDy1h4hia50pKbA
	+5W2PK/d4v2Tk+z90h9okXdOl9543pV6sxFUbHCcWK+xIgBQ0UudyFYXnc6Hzrpp
	KJSvZwi+1/bw+BYmh2XW2PKOoqzG4ftmfaq6tOf/pa+inLXUoa0ZelMItwnaBugc
	K4AasIA9DBL8RUSYSDMmlA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qgxmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:59:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68P6oN56017276;
	Fri, 25 Sep 2026 06:59:51 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf129pdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Sep 2026 06:59:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXqh58TvupRsL7gUzzLaE8cMB6z0hn51U2O2oBnuMzN9XIJyi6FvpRtPLRIKR9/84UFnISf8EigA1n515xVmCCqqNRUlOD9vzh1i5xyaSxE3SsJStkvhLG/hu2kNvhf349WM5O/9zVS7fZNPcdJQ0XxaTVZ/VL7lQwSIxlnT605Al0wsHW9KEC237vQIj/SoA0r3iF5ed3cO7lHbfoyNLw3VIpMwou2Uo9uVKnRfm9Tkq6JJyzW8KPJc9yOMo6FrFQe/cFkXnQbodnAot46xxZ4JY2CYpTfLDiZNfJNetovleClbYcgUf5ASB+J1p/m+4ZyDysUY0PAqE15OHcMctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DL7Dz5G3ZotnJv0xwbhpsNYyzRBZPSBXJGn3PPTwhY=;
 b=V9C76mVfiadw7rFj58JZ/6Qs/uYtoLmuP0O8jKwGrNvg4qIQdX1hdFzrokdwUzSH/3QOtHvkBzk6npV3qxcErc/bG1SHQ+jn9dzmdXgbhs+gXKxEwn8NMxKOg02SO3Vgv3ZTVrAUgUiw+F4Dtas1IBvqvWgdgT2JTNABlK2jH32uF2mLuHZIG+xfhn6X5fr0Ii86uVqSzZe7tIoXjLCXXaZucxPi9sVYumbH2f43LHOFF+s+kuTJHNVh5pAj1JEt1KupqtobIVBCa4ZnWrpAoyM22qQq2MzKLOaBiga8+ENcIjGr9aAQhx/r6X2WqZ/O3mUyJ7XNnumhGWwSDjUb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DL7Dz5G3ZotnJv0xwbhpsNYyzRBZPSBXJGn3PPTwhY=;
 b=c+E4O4ZKH5H5U6RSDF/o/71aq59taZOurUASUjB2SPz4hI4N+GOac5y+PyrhbwfKsOuiA9C2o5SxdVbc2iF9ri9fQfXqpipSt9JV8d5sOaq0dISh0SZqz7nuzs6ctGjBETIc6dHkCE9GK7WZQ4tKH5zPbNGyJ9QMyiiIPD1CuFM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH7PR10MB6108.namprd10.prod.outlook.com (2603:10b6:510:1f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Fri, 25 Sep
 2026 06:59:46 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0472.005; Fri, 25 Sep 2026
 06:59:46 +0000
Message-ID: <d6828cbe-462b-4af1-b68d-651a76f24fe5@oracle.com>
Date: Fri, 25 Sep 2026 07:59:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2 0/3] pahole: Fix arm64 argument register
 allocation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260917164038.1576763-1-yonghong.song@linux.dev>
 <09dbfeea-a4d1-4b7a-b92e-bcf8c4cdabb4@oracle.com>
 <DLNOMA3RI740.18YZJ9G0HDKDQ@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DLNOMA3RI740.18YZJ9G0HDKDQ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0223.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH7PR10MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: cd01dee1-0c63-4be4-ea75-08df1ad29545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SIdAB3K/vgDkSb7IKtOjpTCL3BReHYXFMfr+nX6OSy071nVbN1/AGnrj0yeUJzq6Cu4r8z085YhT/PovGxEjhnmeISMAc8He0Y0+1sgVSjlEQaEuevvz2zvaIgqrosDjtzZR0aKtiUhXp9XI7mtTOP/N8vkwdYdnvvLedlFL1gbfWqZvG3QDtV+Egv9oEgetogTFRLoMUkDuYVhuZKenoAFOjf4tWEbyEif5c1Du14qWfqHXnJw+rJTMkkjr8/wWAbxf8clehTaF5QWAHm3PWgl6x4NiIE7XCwGKCJ1cGS0wF3N2Rgs3X3M4eHK9RQDspr92Wb5xF7RIS0D3LxUumci+lvSpiWPiQ4lIEht30xOPBunMpGBipw5ysyp+IGFqgPcj1pGMURsMi8vEu816YwETrs4AluCv9PjwszFcr93uY0cIz21SVjEM5gk4zf0qipTcFTzvLyfznGPcYI54N7YuMcf7pYRbuqJGa9TWPqZOORIIKtQnAKiwRdz5LSnF4hsGUF9jLSPcRtVIMtfcahp08Xd5SsV09OejpChfCyCYp/c31Sc4kvOro+a2zP7HkOWYT2yCLDOYMYCWYRWe5Cq4G2GvL1v3Ehu5O/rqkPGPoln/aKwIAZUrikZtVlj/T6/UtGZPdqtnJaOnOWL1qAFStvMt9QZ+UafgWckrurQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU5ZZ2RNSGRXRlBKcnRTeThKVk5kbWVpaHFHK1NIeEdoT2Z2Z1ZWK2JqOFlB?=
 =?utf-8?B?QVdycFZQcTJxbUVSRHJHMUNmWk1MeEdBZ0VHekZ5YUsrQWlOVng1MTEvL2xZ?=
 =?utf-8?B?NUpRR2V6Q1M2SWJpUzdVVVBZQXl5S3JWak5SS2dzRWI3YzJSSTBtM0k4MXhu?=
 =?utf-8?B?aU9obGZ4TFFQL2VnOWtMdktvVkJ3UExnZXlTbGlPR01ld0IyUGZnR0V5dHY1?=
 =?utf-8?B?ME1PaXBaZDFqS1B4Z3VKRHd3Y1dISjF5eXlWN3BBSmV1MWxlaUNLYlZXeEdN?=
 =?utf-8?B?OXF4eU1HQlVUYmlKZ0U1RnJVSjd4bVo2T0htbmZsYndDNXFNSU1aMG1SbEpk?=
 =?utf-8?B?L280R1NkNHl6S1dyYUxxRy9jQ2s3VDU3b3c3UUs1NnhWclFKL3FLclRKY1RI?=
 =?utf-8?B?eTdnKzkwS1RWWnB2OXp5Qml4ZUQvcGNtVUw5clNxZEdDZG8yb1ZaeDJKcCth?=
 =?utf-8?B?V00zL2hZa0huOUw4T3J0KzE0dFl1cURZVUpPakNCUG9Da3IrajNZbzJSb3M2?=
 =?utf-8?B?MkpkZ2JWTGtDUmhBQmxrY3dBMWM4bVUwUUFHMlgwWXZoTHU0NytmejZmdFF4?=
 =?utf-8?B?VEl5Y1J0N0ZwdEhnSVNsazhLSzdKanloTy9FVnBoR09tSzB6Q3IxWGtyakcz?=
 =?utf-8?B?UEtLdk80SEVIQ0Nlc0J2aDNkTjdsYmE1WU5DWWNkZG5XRVk1WCtjTEFWWi9T?=
 =?utf-8?B?L00vRjEybDkybHJJcy9KaWluM1N3b1RPT3NkZ2J6NHRZSXdIK2tPNFBOUjNj?=
 =?utf-8?B?aXVGa2VqVzE1cjUySWI5N29tWmg0S3pHUmlzT3lOVXZJdUp4VVJ4bGRjRTRs?=
 =?utf-8?B?MlFOTHk1Ky90NHEwcFFFaDV5R3lVSlBwaEQydU5LcU1MTVdRSkxOMjZzaXZ1?=
 =?utf-8?B?YkdaOXFKNGY5bFhXN3cram15Mkk3ZlNHT3NEbEhDbEplb0RpZ3BuUmVZT25S?=
 =?utf-8?B?VmlkTVNLd1RHM3JhckVQYTUwSEdYN2ZRVW5PTkdLVlBRcmtzcEp0TmxRNnQr?=
 =?utf-8?B?V2g5MXNHQ2ZGU1ZLZkVYN0Q1MVFYdkFtYnozL0pBVHQ5VFFqQVhHMmdqYXQ0?=
 =?utf-8?B?L1NkaEFHVFJsNlMzRFpvZmZVdmlXNnd1aTdxNzhoaXJ4Tk9ZRFIvd1hobVBm?=
 =?utf-8?B?MGN5OWo5RUUxYXU4cytRc3lyOVZDQVJtNVB2Ni83YjRwaWFLbWdRYXlFb3F5?=
 =?utf-8?B?dDBPaHpZVkczZmkwUGNnVnM5QnMrb2NPM3MwZGFzclpkVmFEa08wVndoSndh?=
 =?utf-8?B?UWNvU0lwS3dLSzFTZmIwenRVM3hEYXFWWjZnOVA2T3djcFFOQ0FRMVEvMWZ1?=
 =?utf-8?B?SkNJbjA2MU02am5udkIveUU0ck1HMW5nUmZsMEFDMzI5NEpCU2hoRGwwWk52?=
 =?utf-8?B?UjRRdFlGL1VrMTdOeTdzSGhzc05ubjY1aEliaGNXMkxhVUpaRXpIWmp5UFlh?=
 =?utf-8?B?dVFNTCt3aG9sWlJKdmlCYmgyRFRML2puU213VEVheTIxRVUveTZqUnVPQjB5?=
 =?utf-8?B?MHhyV1hYN0hLcXBCNkxIR0FpSmorMGQzdmhyTUo5ZUtvdG9LZ3JIWjRDM29K?=
 =?utf-8?B?SmpieHVFbjM5cU53YTlVY3kwQm5xejJYeDdqKzhGdWxxRjdlamZLSXN6VWJ2?=
 =?utf-8?B?OFJyQ2VGbEU1YmkyQlRYaHpvM1JDbVYxZStyZVNncUtmL095dUhaR2dtVDFp?=
 =?utf-8?B?UnVSSzhqRWJHWHBHTVZxWGxMRDhtSXNYT3RFbDFZZ1ZrWDRwQjFka0tXWUhx?=
 =?utf-8?B?VnFsbXJ3WFh6SmV6dmJScU5hUWR2cW1BRU1ocnhiQ2QyWFBUdjBxaDNzZVU2?=
 =?utf-8?B?Z0dwVFF5VFdjdndjOStXT2FGV0FhejloeGZ3QjVEeHlZU05JSmt4Q0pUNnAw?=
 =?utf-8?B?aTUrUXFXUWd6THFBQzNOTzVOc1ppK01QVS9yZ1B5aEh5MWkxTlJXTk92dU41?=
 =?utf-8?B?WVRuMHRzOWROZlJTZVRPeXZvOGVsUWNEcTZPcVdoSVNzWWJPclJFWFc3QkdN?=
 =?utf-8?B?ZTBjYWlVWFFrTkR3VFhRVGtuZHJMWHFHZE5yb0VMcWJxNHpMemhuenhYdFEr?=
 =?utf-8?B?a1prNGgzTVo2Rm90eklwWlE1U01iYjQ2dlBTc1plQUEzTzNtVzVjcXR2Q3N3?=
 =?utf-8?B?b3o2RXEyK0sxTWx1a0c2aE1PYlJpWnI3MlE0aUlrd3MwYTZ6WDFaSkpsTUZk?=
 =?utf-8?B?UnhwaTBQNFQxTjNEMGRvS0p0YUxrTnhIMW50cWlMUjZwMCtUSWpTdkpwM2xL?=
 =?utf-8?B?VlBzTjZGb0VrV3BEZXZHM0FCR2h1MG9PaEN1cnVsem9ndEpaWU8zRnV5WVpV?=
 =?utf-8?B?WERjdzRmcDhZR2x5aE45b25NUlJSaXpEZDhCaVVQcjRSOFdVTGE3Zz09?=
X-Exchange-RoutingPolicyChecked:
	JZhCp7vELA8iAtU0C0Gk+/QP6z5/Z976uh3tEJFLhr0eefMKWO3tvjPaowcePw2mBxAMDix4Vlb8xTZCvPRlHk7yTqaZrezCzKl3hCBUzDmLVyy9SHLMg8UbGq24dfjLq4NoQ0SSgh0yYhme2324WRREl1/pnTphoQvbXo6YdyNl/euaNqf4R1KL55spmJiDZUVrF5TP1w/bCGb9p4jQd0FF9G36C4+zEXub8YGeUN3RbrdUQ0nRYZ51ZaA/G7+IXCqCTTNj5tanLl6fAmKw4ZHBgJaMXg2zAsZmW+1J7oWhh4r7mb66uVO06eSQZlTn3lbZFl4ifmqlhLdvSXDOAA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BqVRQE4fokaq7sxJnT4wZJu00aDp22WCW1seIZFJ+JymlyzOe7wSv6alvUOKccxEMDshLXe91TSMm4XGEk9RxNA3XtsehhYzwIiWA/dqEgIiuIjwji9EhVCJdxkgSNhmTsW2TTR7wO+E7EacaYLJCL7/Oyt/nDhxeBkasZXuece35IeuW6dgIgtf4ZX3K5GXek78igJrc8PDvB+OObVH8hWuYUbL8uZypIomgcwcunCgLgK61905Uz6g7TdZMIpa00b3dbakxvwSFqCqi4rMDRROPaGGOXoCCuCAme1HJfFcQP8Y5Hv7+W2wzgAbzQLRoSAKrMMaTV0Bq/TVzqsokLmJKTTdW4r6IGXvHAgiddG5wPbE0UfWKV43velX1qpM3lkTV5AmaqBEoy8HXDpbNavf8ve8tg1cE00BLnmE+c3zuWt04un5g4yyvV0jl9rqoURVwctEsZmvz+8dCzBeYUitQGWZiD4s8cyCg6tZgBGIzlO5+EpqehsP0htLd6lVAK93yZPiGUyqWLTIPWl6BXiplwRIvkiac18mkLrgNv/QSxKzBmT5CPQQVBwqAYW2T6HzOgrE8909fRN4wppN1IEopjEsKh7qUE5nvcLePIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd01dee1-0c63-4be4-ea75-08df1ad29545
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:59:46.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmBkAw/b/eg8IUVXC0MIYsg/+IuvFrG53L7e8hgUlihH/64wIwbke1lgaVFgTKON4S+5AXOQ+lOdpbq60lu/tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=610 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609250027
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfX+bkZ18vg1d3G
 QfyTx8UKSZRfUOD53k0JZgFp1SguVtuFIba9nz4xSGqnYtOLF39xXWI5MJ5a9lhFKnGVQATJJpY
 Q49qppAInn7FOqKCnCmku9ZfUNmAMPfew/1r5WR7V2ljYV9mxpsv
X-Proofpoint-ORIG-GUID: cBXNILCEPHhiDlgzVRmlmohNV4i7UZqa
X-Proofpoint-GUID: cBXNILCEPHhiDlgzVRmlmohNV4i7UZqa
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab61be8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yqyM56n57-rvtKM_PqcA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfX6rUx25Gh5NDp
 1GDdpalpjLwLKTLWElfbPypaTOZ4XxIaKH6qIgyr8tXfNOJLechXGDpi9EiWcXeInB6qpPJKXLR
 yR1etDpg1ViLRSxZV83te1vB7tjj0xSw/q8bOB4k0c5Z06vLTXUZlBqeLuADP5IjAKmd4+cwnfW
 7uDCD/BZf8vW1hW2TyQOjm8bL3Pb7NA6SxqMGQTQGxkElWDM4aAG2FdxiCIV3EBbQtWsrtma5rF
 pY8mbD4hp82DaDw9sBEXbAynFjtgzc+Wf8KGMz3L0mOzDS3iTwmfOD4JToTIbn1Oh+8O6BmpvXg
 gwgANO4jpqL4dtVRUwla6JopdzXY4JWjwuxt3RaGBWjbgw0mA4phTp19nrMdJtKIpW6BxXSXIOI
 YV2ynbhwoPu9Lqk/xlfGrajJWNlwSZg3ZYqlLDMVF+ljXxth+u9CutjxxICOP740wBiEFg/UI/N
 GByTKbT5pB0DfNofvotPScQEq/68jV2qlrjS7MZQ=

On 24/09/2026 17:20, Alexei Starovoitov wrote:
> 
> On Thu Sep 24, 2026 at 4:15 PM UTC, Alan Maguire wrote:
>> On 17/09/2026 17:40, Yonghong Song wrote:
>>> 
>>> The arm64 ABI starts an argument twice the register size on an even-numbered
>>> argument register, leaving a hole when the next free register is an odd one:
>>> 
>>>   u64 f(u64 a, __int128 v, u64 b);
>>> 
>>> passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.  pahole did not
>>> model the hole, so b looked like it was in an unexpected register and the
>>> whole function was dropped from BTF.  Patch 1 skips the register the ABI
>>> leaves behind, patch 3 adds a test for it.  Only arm64 has this rule; the
>>> other architectures are unaffected.
>>> 
>>> Patch 2 is a small follow-up.  Floating point and vector arguments are
>>> allocated from a register bank of their own -- v0-v7 on arm64, xmm0-xmm7 on
>>> x86-64 -- so a wide one never occupies a general purpose register pair and
>>> must not trigger the even-register rule either.  It does not change the BTF
>>> emitted today, because such an argument still advances the general purpose
>>> register index by its own size, so it comes with no test of its own; it
>>> keeps the alignment rule scoped to the bank it applies to.
>>>
>>
>> one small issue here; we record alignment for structs from DW_AT_align
>> in associated tags; we should ensure that we utilize that alignment
>> where available. However it's a bit broken in that we don't appear
>> to record alignment for typedefs, just structs.
>>
>> I think we can tackle that with a followup though; unless anyone objects I'll
>> land these patches later today.
> 
> Pls go ahead.
> Also pls land LOC* things too, so you can post the rest of LOC* kernel bits.
> So that everything lands and ready for the merge window in a couple weeks.
> 
> People will be traveling soon, so the sooner the better.
> 

Sure; this series is applied; location patches will go out shortly. We will need a
libbpf sync commit with latest libbpf for pahole too; Andrii would you mind doing
that when you get a chance? (The pahole stuff will still build without latest libbpf
but the inline feature will not work without the APIs to add location data).
