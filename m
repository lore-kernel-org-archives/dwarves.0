Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF630B50A;
	Wed, 11 Mar 2026 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256675; cv=fail; b=HrkCK+PB0P6zIhvQkNoC1TpofiQbZCkAoiVpnS6T4CKZp1SbTe8mK/WZXje8bPU4ED4qU0T0dywwKaio+yAxUR/30ohAacuL5ZpWDD16X/+Uo6lDas9S7y1SSrdFVP9BwWH0WHb+2V56g4DiDCjGFKZ9dOvR/3hcWIubuutlGkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256675; c=relaxed/simple;
	bh=EQFSc+jB3prvIW6Z9TCSR9BghxDxvQsku4p86LudaCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I1q+b8q8FV6QtHI+qTCPw+4ZYDRjPDxpzfyPEePHVcQLeLcvGNGcvtGloPgQvieu7lFy+lAZu+FGElRedH73W38nVXbqnZeXsN6AwIJDRvfeFf4YPye8apB5yJchPZd2xuHtL6k28eYb1wc8RfRkyYdb/47zwDEdXf+FxgdID7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HYk0Y52q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0BUPtor/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HYk0Y52q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0BUPtor/"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BHNBxU2334591;
	Wed, 11 Mar 2026 19:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=43QHOrJa4e37LjsAvIsuJxwaK6qBxll/snTB1gPBc4E=; b=
	HYk0Y52qyhOlDEtaV9SQZb6a7Yv3FBeH0ggBDavVqzVjabYh7jhYsul35FOoqdSo
	7u+a5STdrIvU8ULzMZD5s/BOUi/mRXvvxIntwKqKW/AFVivLJI93fD79rywSWFKi
	HQS8IZRWkzzwKl6dU/WnURreX27u/wOTLqNZlHYHOy6i7xtluj7/C9SC5TZhbQCk
	4iQCVDH2gGC2b8FOo4GQQ5/nGgnp9MBF5Weq5wrK3OPpFlIUNh6FNgbdBEj6a2ld
	gFhYXH5rj70XdHUQa2DniN8Or8sL1OgN1ZVKNocBQYBe9L/RpNlj5XT3TRix5az3
	YvRIITiIE2MCMbok4lfTJg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu4sts3rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 19:17:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62BHPaAJ014806;
	Wed, 11 Mar 2026 19:17:26 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafg7sxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 19:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7wGgpkN3zJu6tOX/VSSnRfVIbbbJokJUXNMHl0SwAty+svnKSNCTO3Wh3fsIt4XXUAXsPq+dZ3XvM1wINIXbvrbue3YOpGy+7oVA+wqEgcdiI2EXbsjVAZiCGwWG3fqOCoD9eoLJAI3ME90pAKQ1lOv0woI2O7OG0rbsEuWhI4ccSu0/aNcqD0n3R/ii5SM91GqRDTIQ+pVAavafRlqasiOyB1XEQZRshVYRnrp82t5a7PnSbAAscwJoHb+N4TvjiLAvDF/+mp9zdrFcOlISocKhLzXMtSgfRlgEDElBU1EnwnfZ9Asuxdx89qOEvwj9z/wk6r1XozDF1L0Fq1ZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43QHOrJa4e37LjsAvIsuJxwaK6qBxll/snTB1gPBc4E=;
 b=spFoU918gbA4Zf+rXMI4DQCg+eecd+nUeOuCoIqqRyPKhC77l91b5q2S2JsrZZk0PlHT6t+mSKvQmhdt09iIigIB1xiQMnb9g4OjM3JBEBSnF3PWB08tNQ2oX4/hX51gOK1Sx8rs+2SHQNJdZgOfFx8Njr3SHLMNMBKdUlOit7pB8mNBtA8MVT/gu5N27c4APOFosj2gjnvCKX5y7WgC8mKQaSFFQyMAbp5zNSGluY52lmZHXx3LLc0gOn0Ylw5P1kgAofOTAv1fWJZJt5c0lO0bp8+az0zuD365Fly+ncThQ41nHurephzA7Z15XbA6NSuUNvA2cNZlvKAFGz0nGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43QHOrJa4e37LjsAvIsuJxwaK6qBxll/snTB1gPBc4E=;
 b=0BUPtor/UUwl9smZRwE+R+ZzYjS/xof6t47y9lhZt3IXToV+zyeIDFojR0Jw6gewlqqZOzI308fyhMbyzNQ83XdM716vNuAPzCCEo0S6YeBXByvEpjgzuC1va5l7P+n6aD/k0SQG2exhtDPtIdFk7+aX7pq6vAYE0zorPDzLJew=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS4PPF0E620229E.namprd10.prod.outlook.com (2603:10b6:f:fc00::d08) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Wed, 11 Mar
 2026 19:17:23 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 19:17:22 +0000
Message-ID: <50f76d21-ff5c-471d-bb11-208925778d32@oracle.com>
Date: Wed, 11 Mar 2026 19:17:15 +0000
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
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZefR6qQwu1jENEMg15UCXXnfqfwHYRV5y4NAXWwuo4zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS4PPF0E620229E:EE_
X-MS-Office365-Filtering-Correlation-Id: 208b2cf7-d744-47dd-f872-08de7fa2d27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vVNcwuNZvl/PnxsIErm2e4OkdlYrnJha4JZaomBkcWzMi7ytHBa/H78XW8a//KkaNosHQon7wLmnzvtWroTRExuVTPzpmJYYiW3kjoDNEVzEyacjdX6/U0aP2/sTU0TJLIBaRTC/cPBTao79aoA85rd4jhcVMtw8lyuEaiXZCuFu+vNZtxl7fzC+Fhkn/hro+tCD2kf6w2nFBQ0l3nIhuCAzzWdjpwI9JDDpkENg0cHnLWsv9YmMlc8lR7Y6xxr6GFzoL8xZnG8A1AOJ8PWInfA+Tf417TMMgZnG579pvhZcHE23PnNgo1lOKgs5gXDghlEnUdnHW0osnLUU/eHwZnQ9ei/ACap+Q6C6p1gsYTypYB0bg3WIlOOCrz/qI2AFKHT8YGdtCBLteSFyCHJdsrVWjhQ/rZ/E8aQYieZ3Cny84HXYLOZzH2RGLKJ4084xo6yQY2eya6ZTppYZ7qe6SGZbuN6Ve4lF3CshXGC2Y17zErkIOeanUbjsqYP209qV91o/ziVksgY1NSNoVucgo8G+sJiqeVKsgwSahiRWYI7dnVHnhoy5H5V4bG0UB0YNzP6VUVg6IMketY+VsKhIQIt7UVwxlzJV1CaXySmMtpMZChWNhBB5zmCQBd/kttVyghEeYf4pDv5qkeqi7RU8PZYSgUu4QIBADjYbJKxub7UvwOzSHUOwk0bdxrCr+R8sS+Tau5DM3DecjE3Hdcdt7/kPmspEREky6ZzextAs0Pg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk1NSTF2UjNtL2hqVlFNN1NobGdrWXY4bHNBT0hZWHhGZEVRVGw4VnhGMzRs?=
 =?utf-8?B?c0d2R2RDdXpQeHA0NnJJRkhnNTRWU2pITDdLZjZHMnQwcFQwckh5ajA3emhZ?=
 =?utf-8?B?YWZvcnVMbnpYTVVUNS9tRHp2ZFdlQTdQaktvV0xERWFKUERBcVY0N2ZDZVhn?=
 =?utf-8?B?cFBTRXZlMG1kSWlZeHltSDE4QVVSenJ4aE9vN3ZlbnpJLys1bzdMbzY1UXQ3?=
 =?utf-8?B?RUtBbnBWb0FueGRvWGNHcHdUZ25FdDB5V01zZTdDZEJQaDduR2w0ZDBYQklz?=
 =?utf-8?B?Wm1mMmM4bzFTRHJzZkxzd3NPN3dxd2xQNHVxMlRBTmhGVDAzRWJjcU9IdUE1?=
 =?utf-8?B?N2ttUzN0Ujg5b0M3RUp4cXpIY3cvVzl6UmZhOUdmeEt4ZkMxcHNBYjJTdjBm?=
 =?utf-8?B?SEdkUVNILzM4dmlYTnBUODZRVGNRT1liNU5Xb2w0OUhSRHlTdEllUm11ZXNl?=
 =?utf-8?B?ODFOMUZUWklyTFY3ZXE1MWxEYm9IRXgvRnd0amtEOStmeGZnY2FiNVpyTXRL?=
 =?utf-8?B?M3pEbW5Sa2VhVGFCWDNhMWVCaU9MWW5pNnc2aUlEUDZobk43ejNjZ2E3Uk1Z?=
 =?utf-8?B?REI3U05uTWpaZ0srSDNRUUl2bnAraWYzYjIvTVRQL3hKTUpCUTBUdy9QMzhY?=
 =?utf-8?B?aHVXMDdZMDl6cWJDd3p6dEcvVTBlUUZaUnlDb2FyejRSU0prOGxra1A4Y21U?=
 =?utf-8?B?UXV5TFA0TWt4alF5QTdRSVdiSWNVVitia1hTTUZzR1AxWms3RUJoWjlGeWsr?=
 =?utf-8?B?cnVpNGUyb0ZIYklkOWZGNjMrSmVXK05jV1RGQ3dtSFQydlpIRkNtV243STNJ?=
 =?utf-8?B?WmlNaHFOUXRuYk9nUlh1Y0JlOTNYT09GSThaZW1LazRvSHZSZ2g5c3VPTmJ4?=
 =?utf-8?B?ZjlwTHRzaHdtWTI3NXJDWkF3UUdoWURzQi9sY3BsaHllMFJRd1ByTVFMazA5?=
 =?utf-8?B?V2tEcWYvU0hIQy9rQkZxV1RuaDVkM3pKWUVDaHdVZHdpdDVHU1hXUGRyMHEy?=
 =?utf-8?B?eEprZGpPK2ZxT3g3RTBjaHpHbTBrSFVEanhvUHhUTW13NGRHM2x2UmFLQTRH?=
 =?utf-8?B?KzRjbHZqUldxSTlpcXc0QXpvc1RiQkZkdy9EWGdtdjVPdFFlNURzQXdHRWFw?=
 =?utf-8?B?c3RwZmdDMkhpMDlKVDRyL3hCSC9sZURwaXdwdEdUZllHZCt3Rk1icTFtRjUz?=
 =?utf-8?B?b0JlY1Ixamg0em1zODBVbWg5RWd0S21PV0x5MWhVTy9XcnJGVzd1SnFuU1lD?=
 =?utf-8?B?SkJvNlM1UW5maktRb0hSN1ZjRE1pTUgxYnM1bm5Iejk4NnRpZnpiN21NdXNR?=
 =?utf-8?B?N2RWd1oyTTc4V1FzU1BGS3k5MkRBUWcvYm1RZ2dBZzRadVl4N0xXa2wwNW04?=
 =?utf-8?B?R3hSSkRVREZmU0xDOUhOU3BqblVnUU1oMlZnbGdiMGsxNm8va0xQMmVPRVpW?=
 =?utf-8?B?ZlNvWUVhU3hzeStaODd2cG40RDNiUXdtMlhTNG5scVlQODV1VG5KMnQwSWY2?=
 =?utf-8?B?Z3pUMVdDcHhrLzMrZFc1QTN4RHdkWlhmVWVqRTVocUFhNW41QllFbFNURUxq?=
 =?utf-8?B?WndDaWJsSi8ybUdXRFJlS3l3a1NnMWUzZTJYRE1MeVpMa2JPSGZTZm5aeWRT?=
 =?utf-8?B?R21hcC80aWtLM1ppdHR6Y0YxZlkrcG1iRGpodVpuTExneUlwSTRUN3BaakY5?=
 =?utf-8?B?Z0JSYWRZM1ZFZGZYY3JJaVhmSXA4KzhhTWVuVTB5dlQ5U2NtVno5blFVWTRS?=
 =?utf-8?B?U0c3SGRCaVcwM2Y4S2pZVjNCZXZEbkY2NkFicjBXakFyLzZoWHZoRWxQOGZu?=
 =?utf-8?B?b01pMzA2RkZmZS8yMmlBMTV4TlA4N21XK29XK2FLLy9oNEs3WWNBNDN6UFhG?=
 =?utf-8?B?dFFiU1QrOHgrbEhLMVBSa00zNEhDYjFWdUxaM3VBbXZXMy9tWHI0VWRpMFhp?=
 =?utf-8?B?b2dBc1REaE9zd0FRMk1PV2h2NjZsSXZyMlMrQ0oyMnFRZWpGT1VKSE9WNmN1?=
 =?utf-8?B?cGEzQUptYk4wYkdUNk9JWHdicVVTUmdnSm5UOWVuOHJoY3kweVR3RFJheXBZ?=
 =?utf-8?B?VWptSVU1dkRDMnZ0bVNUQTlJN1RWZGQyRlNET3Z4M0cyakswRkhSeU1GMU12?=
 =?utf-8?B?L1NUeCtybk9yWkF1aURXY2FOL0NmRkxVd1pnWE9BMTl3NHJKQ2owTXdoY1hZ?=
 =?utf-8?B?c3J0bHNLdHBpVmhYWW9YZ1RJVlovV3U2MlA5enV1Rm5wWGx5OGRVTHRsUzYy?=
 =?utf-8?B?ODREY1dDOTRJME9WMnBIaGJsNitZK3MxSVl5Z3NNZ1ZTeCtGQWI3N0RWdVJo?=
 =?utf-8?B?VEVyVW4wY2lZRkIyYUFDQ1E0K0NvVEpIV0lvOUluaC9RMkFEUnhBY1pNSi81?=
 =?utf-8?Q?023wfFlokVPUi/s8=3D?=
X-Exchange-RoutingPolicyChecked:
	MYIdaXJ35W8jH0hLGZfKPMeoZjnXb3dtlxVeP2Gzld5HBMJmxjkK+aavtObcUwqnOvuKQxlj3cU/UaEarDuaqcli0kCuzKjPpn8oilnMZm8iT7A5LpmiewTNy6P9yCaf9EwKDvKA1AfC4g6PxWkx8qwPS/ORR2CgQ/CIjNNR2GNFOpTXRk/xPhP2eM+DyttgSNWQcW7znlrR8ZmsVfKk+66iW5IKf4rlFe7z3kFwXhHG97nJlQkI1wslYhKXl4J5PLUjwq9bGAL5PkHVALO2ILbJyt+822SuVW68LX/3/4o6kIbzkYoNblcTkun9O/hgpRoSN5ij3b5BJoWhR7U3Jw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UeDGToZXGNO03Bg6Nf1I/ap4qxZ0TRcYZHgx2qj6LSlz3HXMG3AaezNl8ny218nMgxxdvA2bV4l8lDrE/JXXXEVZ9qZUJLGVrv2MUxamm0PnDwVqIdy4zPrzIT9kLM9Zo0YPqTazaBhI6Qc7D/pFdPgGpbL8IYdVMPDKMTqj2AF546AxDKAmmG4AlGfCt3pISkugp4IFaE7VfD3xTQfgwDdeWcHlF8JBm6L7aHmssMOCUkePkriuoCLNtu18Ew6u/AxKPEo6yG2l/cZTGxKbK1n9UypzxdrorAEoyP2lOgOkFiQ8yHjfTV0/Hgh0jeG46wha9keLefj0j3DkDErTsLoeCp3dZB+SHwJRGzsnF98PbFEYQtGLmXNmt2+w0/FgYGYq9lr7GxN7Q+OTUvyyiD9Wpcn1RbptCFNML21jdsNud0xb0MlhK5B2Hy2/ohLhy1O6NHwB5eyZlnQ0xHmSGF+tJF5iwcOOO9CuzSzES4DYwQLXcFzMSI7O4yTvmqGpPkVxPDvjboPFupd0VrrXP3BpkY8RIIDZGP4iSHaHmyjaNDF0gU2S9AZoSz/c7boaXhNSQDsfRdbUHXHmM5s9sC8xTYlkj0P4xXF4EbiFATw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208b2cf7-d744-47dd-f872-08de7fa2d27e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 19:17:22.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ci+95mBDsAAKllPjKqtB+aKalTcd4kgUDTjGkvdCP7yJCnMgY8sb9b2oZIct4blUD2mqHv1Kr3ERTHNRQxooWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0E620229E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110163
X-Authority-Analysis: v=2.4 cv=Fv8IPmrq c=1 sm=1 tr=0 ts=69b1bfc7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=x1oP_qd43ejLgLEq0m0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12271
X-Proofpoint-GUID: ZNCAnfwuOyhF6pX0BSXCuijZPQAitpOh
X-Proofpoint-ORIG-GUID: ZNCAnfwuOyhF6pX0BSXCuijZPQAitpOh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE2MyBTYWx0ZWRfX8OPm3XHr1U+d
 VSAbTcDJxG7lE9o1tB1oveoUdEpHRkTSNNHe45HVaiWqTj0i8nyHnJYaLzijlt7ExDds3BqGCQC
 u5Dwwnvxgy7XrnB6TxtAkm/S5NsjxwM7xzuDVjagLQhLsF52hoHs4ygDx1A8XzI+8gZyjPGiNzZ
 1vTXSVTu2+HbLWprkg/ga3PBmigH0Hu7oCcw7iPqjniyoK53fi1VnwsVKqp6cCpURZO25hA4txy
 VyCC9jZXmKEtMzzKCTiaaGlFT5rGxHfF3xfK+OZ4yMhBVxqELXhBtUPO4BoiONxB4AUW9DhlL/5
 lly7FbuVsU+7MQ0h+VJYvg9S4dUrfzOKkSUt6dfahZNw//PfPSd+5zXmXwvFNRLM/0+bP63L0qT
 1n63pAIcC3RrGyt3/cJFLLFx8SfLsnLf0Rw0HZ66CdwDGPc09kMY6y3zd9b/SsGYnaZU+7Y2v8r
 EEBRTnIQ4pM8lUfjZIUENmGV6Bykta2czv6xHfnc=

On 11/03/2026 18:16, Andrii Nakryiko wrote:
> On Wed, Mar 11, 2026 at 11:10 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 11/03/2026 17:46, Andrii Nakryiko wrote:
>>> On Fri, Mar 6, 2026 at 3:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> Support reading in layout fixing endian issues on reading;
>>>> also support writing layout section to raw BTF object.
>>>> There is not yet an API to populate the layout with meaningful
>>>> information.
>>>>
>>>> As part of this, we need to consider multiple valid BTF header
>>>> sizes; the original or the layout-extended headers.
>>>> So to support this, the "struct btf" representation is modified
>>>> to contain a "struct btf_header" and we copy the valid
>>>> portion from the raw data to it; this means we can always safely
>>>> check fields like btf->hdr.layout_len
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++----------------
>>>>  1 file changed, 200 insertions(+), 109 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>>
>>>> -       memcpy(p, hdr, hdr->hdr_len);
>>>> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_len));
>>>
>>> in all these cases where we have sizeof(struct btf_header), this
>>> smells like a potential issue, tbh. We are silently truncating the
>>> original header here, potentially. Which is ok for read-only case, but
>>> do we error out if someone is trying to modify/write such BTF where we
>>> don't really understand all of it? Should we?
>>>
>>
>> The kernel enforces that any additional data in the header beyond fields
>> we know how to deal with is zero. We don't enforce this here, but we
>> get a similar effect since we only copy the fields we care about. In effect
>> we wind up removing the aspects of the BTF we don't know about, so if we
>> read in such BTF, writing it out would not preserve any additional header
>> information (say a new section offset/length) beyond the current size of
>> struct btf_header. So writing such BTF after reading it in converts it to
>> the BTF representation libbpf knows about (header fields + sections).
> 
> I don't think we should be doing this. Let's error out when someone
> tries to modify BTF where we don't understand *all* aspects of it.
>

ok, so to do this I think we'd need to set a never_modifiable flag or similar 
on parsing when we find non-zero unknown header data, and then fail 
btf_ensure_modifiable().
 
> And also you hinted at another missing part: BTF layout info
> "sanitization". Check bpf_object__sanitize_btf(), I think that one has
> to drop layout information if kernel doesn't support it (unless kernel
> will ignore layout info).
> 
> Either way, can you please manually check that BPF object having BTF
> with kind layout can be successfully loaded on old kernel that doesn't
> yet know about BTF layout?
> 

Good catch, we'll need to do this sanitization since older kernels will
reject layout info in the header for program BTF that contains layout info. 
I'll add a patch to the series to handle this (not needed today but good
to have if/when program BTF adds layout info).

>>
>> That seems ok to me, but I guess the user might want to at least know this
>> was happening; would a warning or similar when encountering additional
>> non-zero fields be helpful maybe?
>>
>>
>>
>>>>         if (swap_endian)
>>>> -               btf_bswap_hdr(p);
>>>> +               btf_bswap_hdr(p, hdr->hdr_len);
>>>>         p += hdr->hdr_len;
>>>>
>>>>         memcpy(p, btf->types_data, hdr->type_len);
>>>
>>> [..]
>>

