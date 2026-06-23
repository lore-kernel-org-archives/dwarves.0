Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8A30567E;
	Tue, 23 Jun 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230609; cv=fail; b=iJKKnfFuLZP3dGzR1+we7dZM14gp5ZKidOCWNioq5nJT0SwgDiBDA7EdacrcCz6/uCudp3I0DNunpdiKxORAOS7q/GC5ll/eDN3Bpm/qljm9g+N4ELZ1fWOUcagc/WtPVQTEZQllCV0v4oLtBSCRL2riJ4mjXpxboUQK2ihdohg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230609; c=relaxed/simple;
	bh=T7SyqWHIdVVXlnaATUA1HXTpFa3YwTwB8USClbMZRRw=;
	h=Content-Type:Message-ID:Date:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=XO798Z7MCGs4jOiAd5CNNd4YQYXI8nhfYdFE0wo9C9wNDykFqgvK2pttFSYD3BhtE281ndkhIK8RYxqFE1/rkX1ytn/At/Hq4oCL57y2yKc6uZVCrrkeV/bgry6w5BOsCFh0xDc+nFX6UFOX5xaG2IKz8beT2XwiNu+ktLC0AnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X4kghvdv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iBhFG4+l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X4kghvdv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iBhFG4+l"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NEBfac061008;
	Tue, 23 Jun 2026 16:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DgWs1+8FFOlQN3qmfF
	DvabLtxUZDCU3WI2jgcFBPJmU=; b=X4kghvdvBkPO3eogHNDDDWjjaIG8l/jrwA
	OMh7GBwuAvF0NA78woFnPRGXaWWvJ2L6fDGJD1bkmPYNqU4ts9rvrGcyAhM0ap58
	9PMBKLAVoMibRdrxYfW35dULEO31aB9bKiacQm09wANRoPZXf77WpgBeWcmUikIs
	cKDBPFmZFEgDEGsq6vPjScq/2hfWXxjYCqXfCnNHfRP8WIs30LyCNWwcXxFhDrx/
	adQcTerQSVVayHnmbPtHz+ewQsBoRE5a0MlrIyYemsqsF2xS6iOhaaAMjkKgDfRA
	HyLrVWdR1qb3ZaJDDQSpjKfZ0DZrd0BOe6lLfp2kFun3hCjyPZTQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjfubw9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 16:03:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65NG3ANH030615;
	Tue, 23 Jun 2026 16:03:17 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhaccpy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 16:03:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDIbKrqT4WqJO9W4UrcURJ2RfbtkwWAhQqva4UZ3WhfNJH8PXmQePavODh+SLxyH0q23qqYgg94cIkkjgABThFuZdA3sZrEyMeRxPRAjBty48ZUNd1cTewtJqfh7GPeUg/81PG5wo9xS36i0FMecefNJmveUjzCytAbFo6dZkHz8KTFD6q6LgeJLjxH1FPRlfxm+oUZ4JL7MfIk6cBXfRzhYVaZtY7BlXC0bloGe7vCEm4nAgjOEhPPizU5xt92CkZOrM/5aC17gCrXWzeABLh2HySSjbmAc2FtJby4dvi7UoZ37XCQfGZgw2LaT/gcil4ryShIIjFywQ3OC6+RYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgWs1+8FFOlQN3qmfFDvabLtxUZDCU3WI2jgcFBPJmU=;
 b=IKyzb9PYNBz57+49/ePNOxjYm7smlCYFN+7XDfHnw1w5bN1LMtltMwaWsKC25gXp3yDtHHz7u4MfRwDRWhoHPoL+eALCJtE7IOZ3utfJO34Aoe5qDBBMiRgnYwVjniLpolCy2skWLCuOQkBAsx1WAt82TtXe+f8KQJaKepln8c2yeOjDyUAnBU36Ve88vvSwaWRFKipJM+Pv2ULVKL3BPm0SwMwq5lK0cfCMPr3W2fWjIAIf0hY0L7RPys8slH7xPH14oeA5L4/U8jPP6WNO+kEPHjPkR6MQy0npxLOtKUAla5+8xQC42x8wCQ0pDjlvy5502/TQEfe2B4CS+MqjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgWs1+8FFOlQN3qmfFDvabLtxUZDCU3WI2jgcFBPJmU=;
 b=iBhFG4+lQWV0TRFXaY4ixiTuNzUAayHG3ChajeDYL1UJaTCsvqMvQ76X5ZJDlWb7Qfl/orxqGpQyMZ+S1yBCOq7Q4KQSk/0TlQckOnByQX5qppt6P0wAt++xWFTaMdBO5ZAVjUlmX5rIkrVjZmbJnh5D4v1X6Lel9KQjzhvtK74=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CH3PR10MB7282.namprd10.prod.outlook.com (2603:10b6:610:12c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 16:02:35 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 16:02:35 +0000
Content-Type: multipart/mixed; boundary="------------L0j1o4UK70snuZDFSplKcf2Z"
Message-ID: <b1b73cef-f25a-443d-8557-4cfe92938b46@oracle.com>
Date: Tue, 23 Jun 2026 17:02:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v7 0/5] pahole: Encode true signatures in kernel
 BTF
From: Alan Maguire <alan.maguire@oracle.com>
To: Jiri Olsa <olsajiri@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20260623040704.2732530-1-yonghong.song@linux.dev>
 <ajp70MRjHvCJNeyv@krava> <d270a215-264f-4c5c-9d7f-0b1568815e31@oracle.com>
Content-Language: en-GB
In-Reply-To: <d270a215-264f-4c5c-9d7f-0b1568815e31@oracle.com>
X-ClientProxiedBy: LO4P123CA0482.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::19) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CH3PR10MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 0929018a-49b1-49c6-c575-08ded140d6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|6049299003|366016|1800799024|23010399003|376014|22082099003|4053099003|6133799003|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	LX+o+/hj3kQX+Cq5z5UtNK4cM11gwL/JivYBvBzf+S98s3uVYftyxxUe6CA4MH60KRRobeJ56KikEO3y2bAjgTaTjMnVtsPP50TS77ble0QdTTUJ5Mav6t6G9E0gaDZs7sL6lvQGg5vpsvNPBi3m3jGiazEs92VyPJ0BXZPOxHW0yFASBzIcZE34V98FHwR1aJnEGXDYeqRu5uHhowbH8fqBgVySLiLVb1jNrThk1pbLWgg8TIrNtiOciELrKXi8XjAA8xbWzxp4AMdc67sTzvFLynqO901YhxfpMrp8T9uZDU/RMW6b9WpnbrTmXu1y1r7DlWFQxWNjjrilDlAjCewrfc2pulEFtkBwnB8Y/KTKNdkdjg96/+Dt+Mkj1Eu8uax5MktFUGlOOpUYG6nRjVNsemckznixHPjuz9WR6oYs1Bw22iyPlelsRDdvS8YzCejwm/6g+Q2a7UNpsuMS0kCHloH+by+778yGgp2javMoMmvX0/BkBtSzbVuRbvNclqwL5gFVNzbP0zWsF1lbZBqVQcZbTP+vwXEkzZDrS9Fz3+/058BAu9rrUuFkv/JAxtWSdt8oOisoIs3qX0eaGfycNZq7QgWyxHYR8hOuzyn3DFMmgebpiFG04DN9me7FA5ZWtIjYWjNtwq6GQ7P0j5vdJ8QEdxDjVx1Jn+j+Jxo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(1800799024)(23010399003)(376014)(22082099003)(4053099003)(6133799003)(4143699003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS9ZNEZZNytJMjkxTVJuSi9MbHRLT2xpQVVvU2NPVkxyalhGZjN0RndROTdZ?=
 =?utf-8?B?VFdYdndjTGVXem1UYWlQSURnSDlqYXRwQXdjSmc5OUphcVQ5SUxhQU82dkZ3?=
 =?utf-8?B?Vi9XNUJxSHJ6cjZNYjluWmxDMmR5ZXRldnZyVnZuZXVFTzJXSVBadzhUbVBD?=
 =?utf-8?B?S1FRWElaU2FhSFVoM3BGVjhzYXlpTEk0SnNnK1J6ZVFIRnBHZUtpMWh5ZWVN?=
 =?utf-8?B?QnVhak9MTHZtMDZXNXdDYzZrWmYwVGJ1aFFwR0k0YUxaU20wOUg4Zm5DWUJm?=
 =?utf-8?B?ZG55MlZUbW5PUGRBQzFFV3hjeGVQRHRwRmZpTXZ6TnJSdmtMcE9TZ2NnRkYz?=
 =?utf-8?B?NjNFc25RTm1kKzF2cXpWVFhKK0lSc3o0VHJCK0piaGM2Z0xwM0lkSWR2WlhF?=
 =?utf-8?B?MVhLall2ZHdhYnhsMnBXQmY3MEd4aWNib2Q5a1AyZjN0b011ZDlwMVZjMEU5?=
 =?utf-8?B?eWkyajlaTTBoZW1SOFRFelNMNXlyTS9oUHE2VmNKU1orYmdQRkg1ZVlVNzcz?=
 =?utf-8?B?NkhNT0lhMDNvaEtubGVhT0ozTDluSUFORmgwS2VQM2d6Q0ozWWE2TGgvVXMz?=
 =?utf-8?B?Nk9tODRTR2F1ZEJkcHA4ck9Nd0JGZEpqT21MSkRNbmF1eDZ2MjVxREdsYjEy?=
 =?utf-8?B?R0Z1QkV5MklmMXQvTWpGelFjbzdUMEV2ejZWZncyY3kxRXlkK283N2xCSFh1?=
 =?utf-8?B?aDEySmowVVQwNm4rR1dlZ3JGZTZZV2FIVEp3cjlBMkpkZ05oOWZRS0xXS2xy?=
 =?utf-8?B?MnlDa1ZoSWowRWxBVEhzbXkraXpqRDc5TWE2NVc1aDMwOUFGTXg0eHBnNjdl?=
 =?utf-8?B?NmQ3aHFoek1pSHYvdVZNMVJ2OEppVjJESml4T2k3am50S0Y2cmdveGhPSm5p?=
 =?utf-8?B?eHI0WDVFOXQyOWQyQ1hBME53NlFmS0IzWGZaSWgrMFh4WW1Fc1M4NHFIL01E?=
 =?utf-8?B?a05BalNXQW9iTTF0RmJsdU9rOEx2OEx1MkNrTVJ5aURZQU1CZjRyTmdrUUdW?=
 =?utf-8?B?Tyt6UWlieGkzVTFlWXhzSTJKZXRyaXo5eDl4emNMR2ZuRFp5SUY4UGtBVXNt?=
 =?utf-8?B?T0tMVjFoV1FPWXdra2FSWVZQbFZLRTdOcWlUT2E5N3hyWTI4RjlmUTYyOE15?=
 =?utf-8?B?ZGFhZE1ibFVDQW5sMk5tekhpMlZYVnVZb2pXM2xNOXZlSjBMSXVKQy9sbFVQ?=
 =?utf-8?B?QlFTT08vQWFjVzRaSlB3YWoyaTllbU9JY0l3NVpUY2xQbHZnL3ptcWlqVDNJ?=
 =?utf-8?B?bmJKMHMzREVYMStPU0N3QU5ybHlKQnRTVVBOc0o2MWdwWnNrekhwMjVrRjhq?=
 =?utf-8?B?TkRFL3lORUczRTFONjZjenJMNktrbXVCY0dsbmdDdUxnVDdPNEQ5K2hRUDhJ?=
 =?utf-8?B?Z0tKZzU2Skp3N01yMHRyV25XT2FDOGxqRDdQaGhEQWl6bEdsQ3U0Qk5RdktO?=
 =?utf-8?B?UlRFQXZlMWU1L3l3eHFDeTNKYi9TK0FVOEs3VktGdkwrZWZtL25hQTFzWHJY?=
 =?utf-8?B?TG9MeFJtTkZ6cHU5VE5SOGZUNitwTVJjaytBOW9qUlBYNHovL2ZhSUtwU1dX?=
 =?utf-8?B?c25tbUlpa2UvSWFscWlHSFhZNU1jbGhucWlBUSt6ZDdBbFNhaDVlMGZ5N0xz?=
 =?utf-8?B?dTNnb3BuQW9oMk5wS205aFBwY0F4Rk5TbWU4TG5DNWZQMGNQMDA4dFRML1lO?=
 =?utf-8?B?U3JmTUluaDIwUnRobHFzTmJZMDRKKytlbVNxUTFmR0lpZmZmemIzb1JXbEVP?=
 =?utf-8?B?OUVsU0ZkbFd1Qzl3VmRPWkEwZEZjUFd1U2dhTlc3eVQyZEtBMXQ1d0t0QkQ0?=
 =?utf-8?B?K0tTR0dqNS9ZQzFhTUVSM245ZGVtYS9qd0tGWm9MWjBTSlhIRHFaWmMvV0Fx?=
 =?utf-8?B?YVEzc2kwVmRFaUdHUjF1WGs1bmFSZVkveEdkVjc0UDNhc1J1UVdCbGQvV0RM?=
 =?utf-8?B?Y2t4TCtFU0RrNkQ1UU9VTGpBM0Zob1crOThUWGE3Z2Q4SHgxOHE2YmViR1pL?=
 =?utf-8?B?eWxNbTBlOHl0MmQ1ejFxaTVGVlExN3h5amEvQzdxa0JaZkdGc3RwV2hnZTdM?=
 =?utf-8?B?Ukk2NUFBaWY2QWY2NkNTd2tjKzlIUitUdWw0dm53QWhTOTdZcERCLytqejFy?=
 =?utf-8?B?VG1UUkdSUFA2bEJJKy95di9STDhaaUgxTlhISk5KZVJjc1ZQRklkdzc3OC8v?=
 =?utf-8?B?RVZXNElBMkV5WUhiaXAxNFdsNFN1OUtYUjEvMXcra1F2M2x0UTFuNU5nTnVK?=
 =?utf-8?B?WjdFd3ZSRWN3cjhvSi9PYXJ0OWhTeCs1aDV1TnZwalVGWUFFbkdzc2JHd2RN?=
 =?utf-8?B?Z1dFOUp2V1ZBWXdmZlE5aC8vZlZUWlQyQk9WLzB2L0FlQVN1RyswZz09?=
X-Exchange-RoutingPolicyChecked:
	lqURhuqi5dRZBA64olZ8KJyl3XZqbECZIxzN4L0EOzB3uZHVgSTjX60WzZ9W4LMZqOG6lR7AJaE3R1PkdcTs2pbBNLtc1d7ISs0IVxyqe2xD5YLW7cyzwOc/BNNuESWl15EArX7xd2IoumXUJHgZyvqx9wykv51HDELWDNsCu5Y2ZziInCBA7j/6yEtAs+CCHnGO2tgDetQSnFXUENR0hZgstqcUxKNIM+T7u4WoZExullMi/NObmZW8TF+xf06vQBDauhwrInX6jLgCQNcw3pa8iQJ+Ui2lg2e4v+IGKQR64EUrTS2eSttaRA5s+4L3DrdgipovRR2XKY9CHaF+xw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yUyvDs0d2qHcB1PttR2zM/fES4tGiNnMfLFsuCtN3M/9OJy6vVG1EgxcMCgM5TNsnYQ4Acx2TICfjcfKoe6Oqigtn/+dBez8eZCIf7d0SdkIN/q8P4H8hvXCzTbrrRdAVJcM8kp7f0bF3YapKF1Qn0SX8NN6KM1pBPmCsQUnBMW2e8livHc8gfI8cIKHad06r5klAcXh+uSSkKjgXIzsN9W3ItpJQcSYx4alQxgZetF0tjgrAXwwJ268fdZbsXldvdhOF4Wd5KUYRwaAW5QkvXqkU8c+tWDhggkrWv/4bJLdNBUGpJauhgsWQwWnDNHcIADvVm5jZR7NQGFJyz7W1AjICLZX3oHRKYTsKtydO8Ml47i0BLI1Q0fakoxUGIHtLAplN0Rlu05fAN672/ShyvKkrP0JjNtZnfOD58UjkLSxH4qfKyf5Nm8osLi+bRJasO9AKmja9i5aJSVBGBcrCMgqXUztWSkKjBy+KS/c7VvsNbOEp89bn+utiyrTs9CcEV9znJaihUT/wPqlGCHvDQ5WrXyuajPyXD6AjIRq8ERuX/BWiIJJHxOsJ6J1bJdmOWQgO0CH91zOj+cdu26G/cC1+7HbnvTL7wGG8dIUgxo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0929018a-49b1-49c6-c575-08ded140d6ef
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:02:34.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0zGiG5DTe+lvK16F6hUt37tKqV6rXrqxnDVNbx+Q4nx3kbYGgq67MaqWPbnyxGII/M95M9Jn0iWBw2F3U04BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606230132
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzMiBTYWx0ZWRfX30nxmVmCQiWm
 H2C6Jv0TXFM9uBSpIZ62YGBAD8J5t9eZCgi2OV6sSRWHV9YTrg81ytJ8J73+HwUt5NiEyjIWYF5
 oxO2i3zsWXq+gy5jxTASJ/U4UCwDzSBOlsf7xUCd4PXnrGKfiMUk
X-Authority-Analysis: v=2.4 cv=FtI1OWrq c=1 sm=1 tr=0 ts=6a3aae46 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=Bn3qKxIngaO6q4ikhYcA:9 a=QEXdDO2ut3YA:10
 a=FZ5g4QXCJRZk64tHQk4A:9 a=B2y7HmGcmWMA:10
X-Proofpoint-ORIG-GUID: BIyBoqqGnDfyynJp1RVxpHXX7-vYByAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzMiBTYWx0ZWRfX+BEAJKvPEvPP
 y5DzbjqpOIq3yN0MCMqscqqKxdfnll8Y3xzQkuhJy/vBmcLple75GBan15kM5FBZEwcXoGLGHPJ
 G9vLKDMHhKdbXuR2QU3waExKAxRqqqeewtuzIRjE1YCkzpIal5MV5QrxA4/hgDP9ZYH3VUz1DGr
 v9kQpM8EW7XWA2N0OyQAiWsGvZLGo7DQ+nZa/qXnbf1tzSvXbd7iUmJPv8lWHeoukA8/+yn/Z3d
 IJIimE4qu3U4dZ6s43BFTM9iuQoFcaqRI7v6iCVI68FDZRNhaieodanf4dVM8+2gPHiSaL58lHI
 haqWpL3CTxvwitbds0rxKOzsBN2TOnr0elS5CfX8Wxo8/++i2W7tRqKQiUYxb+VOAa3n6dCJzfT
 T6aW59CQWdnxqPa+lD2y983+Gx0qMPuH+viR6yEdevx3MiHKl/jUw881YBrC/4L21cZX5ZElm9/
 Hl4qoCMd8rZCztttOcg==
X-Proofpoint-GUID: BIyBoqqGnDfyynJp1RVxpHXX7-vYByAJ

--------------L0j1o4UK70snuZDFSplKcf2Z
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/06/2026 14:11, Alan Maguire wrote:
> On 23/06/2026 13:28, Jiri Olsa wrote:
>> On Mon, Jun 22, 2026 at 09:07:04PM -0700, Yonghong Song wrote:
>>> Current vmlinux BTF encoding is based on the source level signatures.
>>> But the compiler may do some optimization and changed the signature.
>>> If the user tried with source level signature, their initial implementation
>>> may have wrong results and then the user need to check what is the
>>> problem and work around it, e.g. through kprobe since kprobe does not
>>> need vmlinux BTF.
>>>
>>> Majority of changed signatures are due to dead argument elimination.
>>> The following is a more complex one. The original source signature:
>>>   typedef struct {
>>>         union {
>>>                 void            *kernel;
>>>                 void __user     *user;
>>>         };
>>>         bool            is_kernel : 1;
>>>   } sockptr_t;
>>>   typedef sockptr_t bpfptr_t;
>>>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>>> After compiler optimization, the signature becomes:
>>>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
>>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
>>> This makes it easier for developers to understand what changed.
>>>
>>> The new signature needs to properly follow ABI specification based on
>>> locations. Otherwise, that signature should be discarded. For example,
>>>
>>>     0x0242f1f7:   DW_TAG_subprogram
>>>                     DW_AT_name      ("memblock_find_in_range")
>>>                     DW_AT_calling_convention        (DW_CC_nocall)
>>>                     DW_AT_type      (0x0242decc "phys_addr_t")
>>>                     ...
>>>     0x0242f22e:     DW_TAG_formal_parameter
>>>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>>>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>>>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>>>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>>>                       DW_AT_name    ("start")
>>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>>                       ...
>>>     0x0242f239:     DW_TAG_formal_parameter
>>>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>>>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>>>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>>>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>>>                       DW_AT_name    ("end")
>>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>>                       ...
>>>     0x0242f245:     DW_TAG_formal_parameter
>>>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>>>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>>>                       DW_AT_name    ("size")
>>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>>                       ...
>>>     0x0242f250:     DW_TAG_formal_parameter
>>>                       DW_AT_const_value     (4096)
>>>                       DW_AT_name    ("align")
>>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>>                       ...
>>>
>>> The third argument should correspond to RDX for x86_64. But the location suggests that
>>> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
>>> the parameter value is stored in RDX or not. So we have to discard this funciton in
>>> vmlinux BTF to avoid incorrect true signatures.
>>>
>>> For llvm, any function having
>>>   DW_AT_calling_convention        (DW_CC_nocall)
>>> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
>>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>>> and 875 kernel functions having signature changed. A series of patches are intended
>>> to ensure true signatures are properly represented. Eventually, only 20 functions
>>> cannot have true signatures due to locations.
>>
>> hi,
>> I tried to get the numbers from my setup and noticed that some new
>> functions were included in BTF compared to the current version
>> (functions diff attached below)
>>
>> like for "arp_process" function the current pahole gives me:
>>
>>   arp_process : skipping BTF encoding of function due to unexpected register usage for parameter
>>
>> but it's included in BTF generated with the new pahole.
>>
>> in addition to your explanation above also one of the commit says:
>>
>>      - a parameter with no location, a constant value, or (for non-clang) no
>>        register found is marked optimized out
>>
>> please check below, it seems like 2nd argument of arp_process has no location,
>> so iiuc it should not be included in BTF, right?
>>
>> thanks,
>> jirka
>>
>>
> 
> thanks for catching this; it looks like we return a bit early before detecting
> missing locations in the non-true-signature code. If you get a chance, would you 
> mind trying the attached patch to see if it fixes the problem?
> 
> If the fix works and Yonghong is happy with it we can add it as a followup
> and land the true signature series to save another round.

actually sorry that patch leaked true signature partial names for gcc; updated
patch attached.
--------------L0j1o4UK70snuZDFSplKcf2Z
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-dwarf_loader-Keep-clang-parameter-location-checks-wi.patch"
Content-Disposition: attachment;
 filename*0="0001-dwarf_loader-Keep-clang-parameter-location-checks-wi.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1YTk1ODk4MDRmYjNjODA5NWRhZTc5MWY4ZTQ5MTVhY2VjYzAzNWU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGFuIE1hZ3VpcmUgPGFsYW4ubWFndWlyZUBvcmFjbGUuY29t
PgpEYXRlOiBUdWUsIDIzIEp1biAyMDI2IDE0OjA4OjIxICswMTAwClN1YmplY3Q6IFtQQVRDSCBk
d2FydmVzXSBkd2FyZl9sb2FkZXI6IEtlZXAgY2xhbmcgcGFyYW1ldGVyIGxvY2F0aW9uIGNoZWNr
cwogd2l0aG91dCB0cnVlX3NpZ25hdHVyZQoKVGhlIHRydWVfc2lnbmF0dXJlIHNlcmllcyBza2lw
cGVkIGNsYW5nIHBhcmFtZXRlciBsb2NhdGlvbiBhbmFseXNpcyB1bmxlc3MKdHJ1ZV9zaWduYXR1
cmUgd2FzIGVuYWJsZWQgZm9yIGEgZnVuY3Rpb24gd2hvc2Ugc2lnbmF0dXJlIGNoYW5nZWQuICBU
aGF0CmFsc28gZGlzYWJsZWQgdGhlIGV4aXN0aW5nIHNhZmV0eSBjaGVjayB0aGF0IHJlamVjdHMg
ZnVuY3Rpb25zIHdob3NlIERXQVJGCnNvdXJjZSBwcm90b3R5cGUgbm8gbG9uZ2VyIG1hdGNoZXMg
dGhlIEFCSSByZWdpc3RlciBsYXlvdXQuCgpGb3IgZXhhbXBsZSwgY2xhbmcgY2FuIGVtaXQgYSBE
V19DQ19ub2NhbGwgZnVuY3Rpb24gbGlrZToKCiAgICBhcnBfcHJvY2VzcyhuZXQsIHNrLCBza2Ip
Cgp3aGVyZSBzayBoYXMgbm8gbG9jYXRpb24gYW5kIHNrYiBpcyBhY3R1YWxseSBwYXNzZWQgaW4g
UlNJLCB0aGUgc2xvdAp0aGF0IHRoZSBzb3VyY2UgcHJvdG90eXBlIHdvdWxkIGFzc2lnbiB0byBz
ay4gIFdpdGggbG9jYXRpb24gYW5hbHlzaXMKZGlzYWJsZWQsIG5vcm1hbCBCVEYgZW5jb2Rpbmcg
Y291bGQgZW1pdCB0aGUgbWlzbGVhZGluZyBzb3VyY2Ugc2lnbmF0dXJlCndoZW4gdHJ1ZV9zaWdu
YXR1cmUgd2FzIG9mZi4KCkFsd2F5cyBkZWNvZGUgcGFyYW1ldGVyIGxvY2F0aW9ucywgYnV0IG9u
bHkgcnVuIHRoZSByZWdpc3Rlci9vcHRpbWl6ZWQKcGFyYW1ldGVyIGFuYWx5c2lzIGZvciB0aGUg
Y2FzZXMgdGhhdCBuZWVkIGl0OiBub24tY2xhbmcgQ1VzLCBvciBjbGFuZwpmdW5jdGlvbnMgbWFy
a2VkIGFzIHNpZ25hdHVyZS1jaGFuZ2VkLiAgVGhpcyBwcmVzZXJ2ZXMgdGhlIGxlZ2FjeQp1bmV4
cGVjdGVkLXJlZ2lzdGVyIHNraXAgcGF0aCBmb3IgY2xhbmcgRFdfQ0Nfbm9jYWxsIGZ1bmN0aW9u
cyB3aXRob3V0CnBvaXNvbmluZyBvcmRpbmFyeSBjbGFuZyBmdW5jdGlvbnMgd2l0aCBzcGVjdWxh
dGl2ZSBsb2NhdGlvbiBhbmFseXNpcy4KCkFsc28gaW5pdGlhbGl6ZSBsb2NfcmVnIGJlZm9yZSBl
YXJseSByZXR1cm5zIHNvIG1pc3NpbmcgYW5hbHlzaXMgY2Fubm90IGJlCmNvbmZ1c2VkIHdpdGgg
RFdfT1BfcmVnMC9SQVguCgpTaWduZWQtb2ZmLWJ5OiBBbGFuIE1hZ3VpcmUgPGFsYW4ubWFndWly
ZUBvcmFjbGUuY29tPgotLS0KIGJ0Zl9lbmNvZGVyLmMgIHwgIDQgKysrLQogZHdhcmZfbG9hZGVy
LmMgfCAxNiArKystLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnRmX2VuY29kZXIuYyBiL2J0Zl9lbmNv
ZGVyLmMKaW5kZXggNzlkNmQ5Ni4uMzg0NTVhNCAxMDA2NDQKLS0tIGEvYnRmX2VuY29kZXIuYwor
KysgYi9idGZfZW5jb2Rlci5jCkBAIC0xMzEyLDcgKzEzMTIsOSBAQCBzdGF0aWMgaW50MzJfdCBi
dGZfZW5jb2Rlcl9fc2F2ZV9mdW5jKHN0cnVjdCBidGZfZW5jb2RlciAqZW5jb2Rlciwgc3RydWN0
IGZ1bmN0aQogCQluYW1lID0gcGFyYW1ldGVyX19uYW1lKHBhcmFtKTsKIAkJaWYgKCFuYW1lKSB7
CiAJCQluYW1lID0gIiI7Ci0JCX0gZWxzZSBpZiAocGFyYW0tPnRydWVfc2lnX21lbWJlcl9uYW1l
KSB7CisJCX0gZWxzZSBpZiAoZW5jb2Rlci0+dHJ1ZV9zaWduYXR1cmUgJiYKKwkJCSAgIGZ0eXBl
LT5zaWduYXR1cmVfY2hhbmdlZCAmJgorCQkJICAgcGFyYW0tPnRydWVfc2lnX21lbWJlcl9uYW1l
KSB7CiAJCQkvKiBOb24tbnVsbCBwYXJhbS0+dHJ1ZV9zaWdfbWVtYmVyX25hbWUgaW5kaWNhdGVz
IHRoYXQgdGhlIHBhcmFtZXRlcgogCQkJICogbmFtZSBpcyA8cGFyYW1ldGVyX25hbWU+X188Zmll
bGRfbmFtZT4uCiAJCQkgKi8KZGlmZiAtLWdpdCBhL2R3YXJmX2xvYWRlci5jIGIvZHdhcmZfbG9h
ZGVyLmMKaW5kZXggOWQ1MWZmNy4uZTA0OGI4NSAxMDA2NDQKLS0tIGEvZHdhcmZfbG9hZGVyLmMK
KysrIGIvZHdhcmZfbG9hZGVyLmMKQEAgLTE1MjAsMTQgKzE1MjAsNiBAQCBzdGF0aWMgdm9pZCBw
YXJhbWV0ZXJfX2RlY29kZV9sb2NhdGlvbihEd2FyZl9BdHRyaWJ1dGUgKmF0dHIsIHN0cnVjdCBj
b25mX2xvYWQgKgogCXBhcmFtZXRlcl9fZmluaXNoX3BpZWNlX2RlY29kZShwYXJtLCBkaWUsIGNv
bmYsIGN1KTsKIH0KIAotc3RhdGljIGJvb2wgZnR5cGVfX2FuYWx5emVfbG9jYXRpb25zKGNvbnN0
IHN0cnVjdCBmdHlwZSAqZnR5cGUsIGNvbnN0IHN0cnVjdCBjdSAqY3UsCi0JCQkJICAgICBjb25z
dCBzdHJ1Y3QgY29uZl9sb2FkICpjb25mKQotewotCWJvb2wgdHJ1ZV9zaWdfZW5hYmxlZCA9IGNv
bmYtPnRydWVfc2lnbmF0dXJlICYmIGZ0eXBlLT5zaWduYXR1cmVfY2hhbmdlZDsKLQotCXJldHVy
biAhY3UtPnByb2R1Y2VyX2NsYW5nIHx8IHRydWVfc2lnX2VuYWJsZWQ7Ci19Ci0KIHN0YXRpYyBz
dHJ1Y3QgcGFyYW1ldGVyICpwYXJhbWV0ZXJfX25ldyhEd2FyZl9EaWUgKmRpZSwgc3RydWN0IGN1
ICpjdSwgc3RydWN0IGNvbmZfbG9hZCAqY29uZiwKIAkJCQkJc3RydWN0IGZ0eXBlICpmdHlwZSwg
aW50IHBhcmFtX2lkeCkKIHsKQEAgLTE1MzksMTMgKzE1MzEsMTAgQEAgc3RhdGljIHN0cnVjdCBw
YXJhbWV0ZXIgKnBhcmFtZXRlcl9fbmV3KER3YXJmX0RpZSAqZGllLCBzdHJ1Y3QgY3UgKmN1LCBz
dHJ1Y3QgY28KIAkJdGFnX19pbml0KCZwYXJtLT50YWcsIGN1LCBkaWUpOwogCQlwYXJtLT5uYW1l
ID0gYXR0cl9zdHJpbmcoZGllLCBEV19BVF9uYW1lLCBjb25mKTsKIAkJcGFybS0+aWR4ID0gcGFy
YW1faWR4OworCQlwYXJtLT5sb2NfcmVnID0gUEFSQU1FVEVSX1VOS05PV05fUkVHOwogCQlpZiAo
IWZ0eXBlKQogCQkJcmV0dXJuIHBhcm07CiAKLQkJaWYgKCFmdHlwZV9fYW5hbHl6ZV9sb2NhdGlv
bnMoZnR5cGUsIGN1LCBjb25mKSkKLQkJCXJldHVybiBwYXJtOwotCi0JCXBhcm0tPmxvY19yZWcg
PSBQQVJBTUVURVJfVU5LTk9XTl9SRUc7CiAJCXBhcm0tPnR5cGVfYnl0ZV9zaXplID0gZ2V0X3R5
cGVfYnl0ZV9zaXplKGRpZSwgY3UpOwogCQlwYXJtLT5wYXNzZWRfaW5fbWVtb3J5ID0gcGFybS0+
dHlwZV9ieXRlX3NpemUgPgogCQkJKGN1LT5hZ2dfdXNlX3R3b19yZWdzID8gMiAqIGN1LT5hZGRy
X3NpemUgOiBjdS0+YWRkcl9zaXplKTsKQEAgLTMxMjAsOSArMzEwOSwxMCBAQCBzdGF0aWMgdm9p
ZCBmdW5jdGlvbl9fYW5hbHl6ZV9wYXJhbWV0ZXJfbG9jYXRpb25zKHN0cnVjdCBmdW5jdGlvbiAq
Zm4sIHN0cnVjdCBjdQogCXN0cnVjdCBmdHlwZSAqZnR5cGUgPSAmZm4tPnByb3RvOwogCXN0cnVj
dCBwYXJhbWV0ZXIgKnBvczsKIAlib29sIHRydWVfc2lnX2VuYWJsZWQgPSBjb25mLT50cnVlX3Np
Z25hdHVyZSAmJiBmdHlwZS0+c2lnbmF0dXJlX2NoYW5nZWQ7CisJYm9vbCBjaGVja19sb2NhdGlv
bnMgPSAhY3UtPnByb2R1Y2VyX2NsYW5nIHx8IGZ0eXBlLT5zaWduYXR1cmVfY2hhbmdlZDsKIAlp
bnQgcmVnX2lkeCA9IDA7CiAKLQlpZiAoIWZ0eXBlX19hbmFseXplX2xvY2F0aW9ucyhmdHlwZSwg
Y3UsIGNvbmYpKQorCWlmICghY2hlY2tfbG9jYXRpb25zKQogCQlyZXR1cm47CiAKIAlmdHlwZV9f
Zm9yX2VhY2hfcGFyYW1ldGVyKGZ0eXBlLCBwb3MpIHsKLS0gCjIuNDMuNQoK

--------------L0j1o4UK70snuZDFSplKcf2Z--
