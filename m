Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858837189B
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115626; cv=fail; b=mcMHYlAeP5m8BwN5wBWyKxOkhfZmJoDavfxm4/iIvISjfb2aznwJKOf9Cqbqfc5qum9DBFtQtGzj+uL68ZGBKGGjYAZAJ/h6N+3THMI4HG77pIUyXDM7P87kNwr0f1UW+GjhY/Hw0RTT8nxv0JaV1P4I9vdOiBMLHFlGcb7eQN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115626; c=relaxed/simple;
	bh=VHIT3XAzsnIlkLdviSqoTwd+xWygE4KmA3MpixPn6Nc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J7cqNZGlpVy+RcHnoGosKsd3QZNoUt3lORr+9jR2m3vEkAWcacfT3jhywmLtFF9tBKeQiSWF+FvxymBClYBSF+/HuGW8tZFsRQu+Wt4nr2dtqSAcyVNcJjRMGOgLJoTxrclYnugsEBRjHkr1sBrvH2LIiBQdNbsxj2wEuV/rmpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=odiaYu0r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PVb9kNQ3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="odiaYu0r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PVb9kNQ3"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M4J1dO758641;
	Mon, 22 Jun 2026 08:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u16zH8+5e1FSrknYv88EDYVxnkjyIHtg4mKSnG/XkhU=; b=
	odiaYu0rINb3tnxKwH/VeiuEj3lqkBhN7Jx3BG8Zct1gkViqq8qKjhILNdqiSzed
	FDk5xnrWNz0PNCmlTUh0yws9TJdrsCTPB5L5u8q6EYW1e0zsuzc0JSpamM4H99Vh
	gh+pUB3UEFvX2nk9d2up/3LskbtkwwqmEnmd/7FIRRFbGb5p8A09kJywyP3A7KJ8
	6pHGl/h1T3nDQUXL0bEtz5qUuFyINVcAHRVJ9yHxjb0kA5lUND2KXU4YWw2FhyPB
	OIhOdE6L77ur6CbRNQMSkUTJZnu2AwywQBQkjnpXPQhIoC1N2inH8DKh+U2XLfhs
	uP5fHUmmNAL99FuUu6NcZA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewke5hg8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 08:07:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65M83Oaq039621;
	Mon, 22 Jun 2026 08:07:00 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhaafj6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 08:07:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9xjpJy2JcvrFWNY2t/lKUGj0izBdM8kARuDlcdQQyt8Bwazzm23vASo73A2MjC5oF0XP6NL/OeouNXm6xUe6XAD9Fm/56nuk+NM2LeSCzkIC44qzpJE6vtDOQiRpdDMjh8FTo8Ey9C/cX1W99FTfbdHkaSefqa0EfzrsJ7Lgzphm3IyHRfprwLlE9xFkuSoG0LMwuz5/IALPQVburF+1lyur9KdVqNTKFK5zUlIyvfeVQ+3HjYmi2pyFt1PHRj4SN4iISmoZ7eFoyIGEjT6KsoPuuveu7X2dRtw+glyV+lPyZzlYfX9rhR5wAaoktZfhf9FQtVkEQzC+wlQgfA4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u16zH8+5e1FSrknYv88EDYVxnkjyIHtg4mKSnG/XkhU=;
 b=aPinkpBzlY+QntQLnArKAIzQYaJPQ5XeinufOkYZhihbO/iGmGh85DYVLK/yhi65gL9wJLmezRbOlA34JY7M7Fd19ykTNP3yVTm1Q/7mr9NAkayrGQgZ8A9n3WvtJ8W42vwX6jv2FpZoHQR/7HEKe4lq/9vwyyOY7CPPHTygvLOmFj4XssDCGfpa1c9byyY07b4Wz5U7xFD+R5USs5MVEVoHB42K4RLpamgQvsiXoDfm6ECLp3zZAGZ0PQkXHPEFcX60Pp1CmJIQZMrtoxgGdeoZ/NwaSXKNxqInObtN5B0Qa2obi6mBNOV5r3JXwrcZrDAJ7vn6SV0u01j3tFBN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u16zH8+5e1FSrknYv88EDYVxnkjyIHtg4mKSnG/XkhU=;
 b=PVb9kNQ3um5RzIyioT/qLPTgdT29H2IRrzWpwGzkYKiwp03sOLclLeW7wQBSpRxYyIfvPjgGC+TmpbmRVfxG/nsYg/dqFQuNnoVfGVnpKdis9jWvcXdAubkQDh0nVBo/8klPR5SLUDLTRAqmsEFqamo6RPk1M/k7s2Ixvso/8yE=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH8PR10MB6599.namprd10.prod.outlook.com (2603:10b6:510:224::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:06:56 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 08:06:56 +0000
Message-ID: <c5c17d9e-585a-4a9b-8f00-56e4b4b224b2@oracle.com>
Date: Mon, 22 Jun 2026 09:06:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] CI: Update llvm version to 22
To: Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
References: <20260621125745.34985-1-alan.maguire@oracle.com>
 <28a9a5cb-4f0f-4586-9547-e35e4731c70c@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <28a9a5cb-4f0f-4586-9547-e35e4731c70c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::20) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH8PR10MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 806e09e9-1d64-46b8-9f42-08ded0353a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lG/yTH3vOfk+h9SD+SAS4ZXeoezJ8oeu+6sxiMCfSoKWPTSg3uhu89v8mqrXFkmogQ2HtqwxypyP8GNazWfCG6BccIKnbmzwdjdGHBLQE/Xxu4zGwjGP91Pqa46pQbGOU9KChdP5JbgF+yW1F0Ei8RduV+kRJWzeCvrBjPt9veIYiQy8IZCY8XwkvJKE4IODDkjf2tjxpyJmvrXptaKSE6qY2BueYKQQFSRPLe1MfNA+WcgkzMukG1t0ISOdzmN+4RVJXHkCCsWMh7uJ2sLM6y1qZ2ouJ8WiWznR7zDt3ED0GnYbVSFwOk+XPKPCm34aVob69j/8vqOwY3ap3GxTO6vG7KZDxI0k3mhYAPcvONSm8wsX6u8V1M/kTBwnhbaeSHNUe93N7Mpbfj2UinvWxIUAaLbcZfoHguP0Hl9ZEqPbbBvtIqYrHAuBX/JW5y9XI2iE8TcSS9FQHYCt004tBjTWLI0botH5VMIQ+FAC9DksRDjBYiOdA+JPz0WOfcKa8UskK/689CJ0920HF1mn3M5lam+sK3Taen4TJyS0apGwyqpcQ3sqKgITG4eSjTg+Er51Wh09WHo4b66H9Q0gWr5OQQ2BplsjjaYY0oD/eTBPjC5xBKbIL7UyFscyGCNUENUrJ1ETjSUNi2CtV8wML05pIaQRDcOGK8oQX1anJLA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzJadnpHNjJPQ2xzZ0FZUXFpNG9QZlJPb3p6RDVTOFBUeERGMk1hTVdYWWll?=
 =?utf-8?B?STQ4S2ZSdko2blo0WDhXZkFCWVpDbXRwYWtuVW0yc240THNpc1Z2M0NmeHYr?=
 =?utf-8?B?QTh2MWtwdlhrSU1laWZLcFo5Z2Vjc1preFZrWXp0M01mYmc1RlgzOGl0Y1lv?=
 =?utf-8?B?Y3hCWkhkOFhpUDdUREpvTEQra1VOb1k4NWNuNnpqT05IcWg5SUZyKytzSitM?=
 =?utf-8?B?ZDl5aHpPK1I5ZnFSYW1WMkl2YmxKS054OGhwOUEyV1NOQS93ZmVaMFBpc3Ux?=
 =?utf-8?B?TEwrOHZnNUUySmxPRG9BYUdTWWY1Z3ZyNFZHV3JycmRnL21tbUhOa3VhaGhK?=
 =?utf-8?B?SXhKYnhHcjA4bGxGRTdSVGNRYk52NllBSjJOSW9wMTV2R2prM2hSNFMzWkto?=
 =?utf-8?B?dEdrTWxNTjh6dDZZak1xRmF2c1YvOHVmWmVDT2RzdzVqQ3kxNUJEWFptcWRs?=
 =?utf-8?B?L1lLZldyNFpFRytjZDJEUE5FUDlodTVhaXFCK0ZRSWpHSHY3aEVCMzZ1NUxs?=
 =?utf-8?B?VURLZjBmb1FQdkpRWk8rYXdpSXIwNWYzb0R5OWlRMStYL2hBOUgrazI4RVlk?=
 =?utf-8?B?cXdHUkROeEY3aS9Vc2ZCOEozYXBhZmNBSFRjNnZGV3FGMTlzK3oyb1NRQkc1?=
 =?utf-8?B?VXAvcVF2cmd0cWVZc0lkSUF3cEpoUlMrblJhcXV2THJjekoyUktNdUc0SlMy?=
 =?utf-8?B?czhneWw0STRjaEZ2NGg4Smh3a2VsMUVuckU5VWE2cy9hQ1lCYUl5RWtOcUVr?=
 =?utf-8?B?RDZUckUzb2ZXOVl2WUJScGV3cEZVVDBOQmhMRTJZUmhqd2k3dUc5NDlCMzlk?=
 =?utf-8?B?QTRoOERKTWVxYVViK2xEeDlCUFo0WkFlMEtmUnZiQkxKRXgyTHE1R3lTTlFv?=
 =?utf-8?B?QTBpRE8xY21XZWxOYmxpRzdpRThMamIyaTNVcy9IM1I4YXVBRFlsUDB1ZSsy?=
 =?utf-8?B?b0lXWGtyenFkMXBLbXBiS2xFZDA3eWRXeW1HMDJzcGJhaDFIVzhWMnl4eW8z?=
 =?utf-8?B?T0FrcDd2eHJqZ2lFWlBnMTdKUWdBTFVxVExCcnpMUmR4OXRXZ2swV1N1dFNs?=
 =?utf-8?B?STcxY3Y3MjE1VHU2cTJ4OFdXZEVMZEM4VFFrY3ZQcXlkNXNaRG12eVhScksx?=
 =?utf-8?B?TTRvUFp0OHlFcXg3SURnZDFpZnp6NmhNb3JPM214NkpWZGthbmJJWWEvWnUz?=
 =?utf-8?B?eWhDbXZ1WnUrS1gxaFRLdFl0aU96TUt5MUZqbVRLSzVoRzE1L0I2MmdwNWJD?=
 =?utf-8?B?SXJSc3lqS0dlbEtVK2JFTlg4WTBSRk05MWNKdVpGRjdLdDBlajg5QlIrM0I1?=
 =?utf-8?B?cEJPUys0WmRRR1RWaTUzNml2VXQwM1lXM1Y1QU5DRmhmYTdmTnVsVlVIN3B3?=
 =?utf-8?B?NE9LVUIxVWM2TGZ4WjczSS83aUhEcFhoeWphNGRmVVBXcjJPanhvUDJWTUxH?=
 =?utf-8?B?Z2ZtWVJaOWNkeXZKblZsZHI5Q3hidm1wWVlBcGJxT01wUG82eUhCNFNzZW1X?=
 =?utf-8?B?ZHRoeWZOY2NsbVVJSm16WHY0UjZkZWJ0a3RlWVRZK1ZOelIyVGVVYncvT0hZ?=
 =?utf-8?B?dHh6bEk1Ri80L2cxcEhJSXBPUC9leEhJckZSOXZUWlhNNmZVRWxJTmtOR1Zq?=
 =?utf-8?B?VmgwOGo0ZkozT3h2UW9ZNm9sbHYzRUY1Slp2MSt5Skg2WW5zY01mM3ZjQUFU?=
 =?utf-8?B?THdlSEFGamgrYXlJbVJGalBSNU9ndWxUVjVVajFQdnhpUDUrNlo1Q29aeVpK?=
 =?utf-8?B?cm5iZll3cGhsd2JXWXc3bG9NUnpPVGlOcTBuUWEzVWhxa3BaZjd1TS9uSTZj?=
 =?utf-8?B?ZGFReUFRamVxbFBpVVRyTElMTVdwb08rbGdydmYwNUFqb1VsWFdrT2RDVjdZ?=
 =?utf-8?B?WG5CZDRlZng2OUhGeFlUemE4SXJKQmdodDlLbVVHTHl2QkxjcW8waW82UUJp?=
 =?utf-8?B?b3BVRkhIc3Q0RGJSblFQc1NRQ0NDZWR6eDZxNThTbU1Vczh3M09sS0d5UndN?=
 =?utf-8?B?RXhvRG51bDhNUmIrb1ZnbldySkhRT3BjczlBVVNFMHB5Y0J2cXpWMkJDOFRU?=
 =?utf-8?B?NWlnZWVWL3VIN3JtNzQ2NHdXK0NNaFZ1MlEvZXprSkcwNkNscnVXVGc5bFpJ?=
 =?utf-8?B?WnMwaHk0Z3EvenMrN0ZrZEs3TlJIcmxwVzhwdDc1M0VqTmxIY1hQUzZvSzhH?=
 =?utf-8?B?MEV3Y012WWdYQzRFVkpxNjZkZlJiUUMwOXhVSGtqMUpGYmVkT3JIbVk1VjRY?=
 =?utf-8?B?QVdWZ0xsaXJaMGE5UVFyV3IwWURtbS8rRGVBcUhQVC96NEFtcVZLQzFnM05Z?=
 =?utf-8?B?N3FseHMza3RrNEo5QUNQZU8rRDVtWER3VDdac0Q3L2dvRVo4bENnZz09?=
X-Exchange-RoutingPolicyChecked:
	kJXFeMO/CrB5JwkX5sAEMGyiCplNmjnWqENYr4KREOoqn0cjPTO8jQPsP8OO0MbeyGUuLVEMibUBwRtXCfWu8RvBLXRjS9SyM+DacQTSaRdkI9iij+OKHuWyjBCWRQntImQ/6fcGHVyhMX7OqDQvTozHojYSb9e29deYRC6bEStWl6jkI121kSbjH19wlug3IluGCBO3XdrVEXJDLSRnlj0sun7OXxDcgjSY1w3trE3Y/M2pHu1DcIp9NIeuX3Ws/0957V5a1Z6kwgLSYqpExYOeIrw0Up5wJZmpDhQFsjrDJ10rdWV8HnrykONE2bM32kiuaWqn4rkDZSXLrIsTwg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SEOKgKlRjYSmQzoFCmV3jYBzH+LOQ1W0qdaNJUUSCNaon6zqy9HLbOww5yheX+zVuk21+ivtoL2PBlCYiHjqnptxZN1Jn9/cWYwqKfVYs7vLI5PhbAaLGk/GINKZMbfUzRqs6uE3ZEJ+8ls2aCV2phrYqEVyyHeBY2xUwK4i+sd9UMYayI0pMYuPFRZr3N/noBXdqFbflW7e7Thym66n70PAReZT/4CUAnES+A2vp4yK26kn01YiLkES4IeXHNiKiUKeeirw8kqfhPabaddO3WBzDnDa6DMMBW0oK2mrhHQ5JPpEyZEScBXhhS34tyQ87nM+l8sXEWJs2rX+UKjF+B6cmclOmFCcH+0TGV6P1P3MDDz/RHyigLdKryNubhCu/Ob5Iq439A/05Sl4s21mkFBX01zGe258DXDLDrH9ZaqeZevA/ah51mD93v1kbSVzvmDkg8EBbuef8phvI8RJLggzLraz6BP3eeL8hi+0v7a9oMmLqy3xfskTL8SFJmbOg72DP1BNt1iplQ7rqb3T2MoBpEvoGxCSV5Ggb0/DEijMZutjVqHfAqua0amxG8gUUi28MPlp+1tFIvyPnKE70DDQXPP/obmX6HQRLNNExL8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806e09e9-1d64-46b8-9f42-08ded0353a20
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:06:56.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuUJtOUQj2bJDu+hm4I2X3xVWvuVXqwQ6k3ivFEmk0M3jOv8t/VH9ONwEYX6k5/CFrkCUxLOGGu2uu4pqVf0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606220078
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OSBTYWx0ZWRfX27MAO3S4W+ky
 6TY6Hjw3OW2FUCaRFkkNgmDg5nH7SFgqVvlx8Jh9GGQVnTazOoDxmAI5KBYd+nt4RFOJNOyHzIg
 lXFxcsaPzQBbtQ4umm/lDrIhXO1ZQSS68rtZQT17Di6AJ96Q7O4/
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OSBTYWx0ZWRfX5l/zOnKN0+At
 NJBKOoyc5vFlALB0mAGbzA6A9NoDqr6JBSlpNdA8fmINryzRnudexMTXRiuOL6VcZbtdIBvjmG2
 1DIJbJ3mTghh1g7VIaFfxpTrWuo5UihNgbKWTANwl0PKaC1He3xnMWQxl7HzpswGvcxqQ47/F6h
 Of++7boMLuqUSTOspLReIFsJh+whGJj11RFRFW/97VznJFX1skO9/H/m3nFBDhEXXY85U0Be7bg
 ZF6a1ABtfznpdAe/pDcPkFNd5wW3wd3xjAQGkU1BX3qs2532SAX0u5E8w3ssn4h2eMmFc/zcAWn
 uT4tTK4MugFyJZO/6QtayM3K6I9G2ySvRIcgs1ozOOGZm8PGZ0zl9wnfM4BvJlxmF6+tz9j7diJ
 /VolGKhDtzZjoFDHcAePyDBeqMaPTUF4QcnQAHM/ytqm7w0Lmq+0ISLQ/9XpRDXL+Xva0UNzXw2
 DXvDR7dfzdrG8H7zNeQ==
X-Authority-Analysis: v=2.4 cv=U/+iy+ru c=1 sm=1 tr=0 ts=6a38ed25 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=4SeO1k3cJa-gRxriW_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uie-ss1WXASb__gJGxL2LS9RY9lL4AdH
X-Proofpoint-ORIG-GUID: uie-ss1WXASb__gJGxL2LS9RY9lL4AdH

On 21/06/2026 17:26, Yonghong Song wrote:
> 
> 
> On 6/21/26 5:57 AM, Alan Maguire wrote:
>> Best to test with most recent available version.
>>
>> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Thanks for using latest llvm22. LGTM.

Applied.


