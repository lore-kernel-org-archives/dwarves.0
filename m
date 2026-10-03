Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9190395DAA;
	Sat,  3 Oct 2026 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016478; cv=fail; b=uuJJMOeBVC5hV+5ppV/eGmhZHatpZZYT/Du4QitFf9LYttPUh1PzNu/OBoZrQe77Qjzweet4foj+U6Mk0+qqGRvMVqLqGdfCmTPewbp3LhpkbujNQpR1yzSI8U/H7wj0mqX1kfOCRUN1YLCzsNoMt8hDDZ72tr773m0WCMg84a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016478; c=relaxed/simple;
	bh=8r0aVvGsICNfZ/4UdvvAIXn5BvVEJXyeBjSTgHaxMcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cYzR03W9ddUaFU6o7OgwFmMcYhQJGj9KGroBAEBm3E7fwNlHAbcecnhgfdDuCNl21WRYWxZ3eDFKolPcwCTYNiIG6mdU/dBuf1+sP08mCgfSIg0Le6s5hinVkOFPPeX8GJaO38SmFcVV7bbpcthpfIKkFpXy/fHd3UkBnnZcVek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YmG5hsd1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jeT+MEwX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YmG5hsd1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jeT+MEwX"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6934icHT485313;
	Sat, 3 Oct 2026 08:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zuoJ6ybzXrozzSWitM6BR1LADkMCqij6ymT6PYRKm7c=; b=
	YmG5hsd1MQNHCO269CWZPL8oEhfJ99tHArOnFPheQnlP9/Bsxd/dMIb/6XEeL5Bj
	oK68Di7YY7J2XNW4XhJSoAwwPORRvLpfUvq2bVirBwAZJQy+BVAvmhoK/yOjPeFQ
	MgW1obpI2OwHJEjgljFeelghtZ3+IwLmyXZaktck1S3Pv7V8HGaAdlfvC9udajOY
	XKuozA7DNnc7Ui3afau0Fl9Liu8Wu6AvV1S3aei0xw6Ma4h93ATnahdGCCZdGe5H
	zXFp++mgu/jMwPNCu3eNgb+A6isMsG8jXDGUfzxHZW7tbxO/p787FE3pvgB1pbSW
	EiOwu8pMwwiw2IkRcTDaEg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2rg1r4up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 08:34:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6938K8rV011220;
	Sat, 3 Oct 2026 08:34:08 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r58pbyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 03 Oct 2026 08:34:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hebdERHZMvY6OhaIKDc+U7jyuU0pjH/VrYsWzolq6jEZZ3RLTnB0TPR3ilDxS+ynxo6cfCVOE8B55Bl7nGEArx+25zdcsgd8jRyrWWugUu17WgGKGiA1ye+oheoPMxq1FJPryBC8XiZh26bykNczhOcPsuXl/GClNpwn1/6+DMbtryIpFmduMf0AxeG3rmTrING/bAPZJg6344r5cv9pKMlsTBrSJeau7EeX+cIbq2Gab0zE4cSq1HwVWTQLWI850NoB45lH+g8Ngc0lLRuBWIpSVwgwy17lylvJww5dJYWv+GZfdrbSYFDHwUsF8pm0+GrQgzch/qE0i/JDPXSgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuoJ6ybzXrozzSWitM6BR1LADkMCqij6ymT6PYRKm7c=;
 b=EPs3mc8J8AnZMnzkFSPX/pXbpKH4FO5hcSxL7L92C7oOy0yrLALTyg0Yybezz456rUvXbVk5MZJ2cW5k5amRzjzynJXLxJ658AQbaJPssr/bK4xDQSVHpQVOOKpIiJCw/F9wqBFH6HHT9XDao4mEtLEMsGEMcFEsevsEG90VJCY+r94I1yRHPpO1Cj0vCS7lSqfgmEyDa39HHJSN1Bz+2YbqfuCkYXFCAlqDMQcKjha0u4jhkj1YuZ/CptoaDy4yF4KXI3E+xEjxqtY5N4/3So8jXXtBRCaqEepNAcWCYw6f6A4RmOBtUYtCy67cInvRKtJIyHSDqRAjW/6geXSLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuoJ6ybzXrozzSWitM6BR1LADkMCqij6ymT6PYRKm7c=;
 b=jeT+MEwXUvwkYmxDoLVM3k5MzOsE5yzWBRV6Vl1SujNcZQpigcHRqmzZJLySpoHpBhLi66mq8QkydmrpNn3owsuMT3lVkMMVHLtptINnI6UrnOk2xPvWFCmh0bWWpZInVQWgXusG48mAKGwQ5KJ2pOq7M6FIli7WwLduZRuqlqQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DM3PPF334FD9217.namprd10.prod.outlook.com (2603:10b6:f:fc00::c19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sat, 3 Oct
 2026 08:34:05 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Sat, 3 Oct 2026
 08:34:05 +0000
Message-ID: <9b8b38fd-8f6c-4d2a-a6c1-0886c3a7de24@oracle.com>
Date: Sat, 3 Oct 2026 09:33:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Many instances of "no BTF func for kfunc ..." and "unresolved
 symbol ..." from resolve_btfids after pahole 1.32 upgrade
To: Nathan Chancellor <nathan@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
References: <20261001224346.GA576434@ax162>
 <efa1ae47-3ccf-4689-9fde-a0294985ccfb@linux.dev>
 <20261002162558.GB288990@ax162>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20261002162558.GB288990@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::12) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DM3PPF334FD9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ed551b-296a-4afc-7d20-08df212915c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	V30SabgLPiq+FvSS3HdmU8aeViGMt9iSUFlTS810qyjK5EVy9n7JfaKJSa36KAJt13hHndh5Jd9agKrp5cVUpzLzicvW9zX1ELh35d0OJa5/4K+iBVuAixjK9FI7RyOs50S/oXQ7Dkg8djGRm1JgyEYWGli+pm9cETmVGsIlkJidPDm3UwXAYt0s0bJawnQVgme7iQoeLU+3cqz5PuXWglGptTcgIY1kS1L/A9ZvVN4K3tBbamCo4d/kXuax4yZFU9G+AGBUpcg33FVCZTH7ctTzLfkcibDSepVL7pCmc1NEX8smXHuDwhebyGGRSp4yFCQSbMK2/mkTtuvUxgjNyEBu57yxvUAIyjkX++M/tSdrWfOPSCcsHek3fhT/jeIJsPg22OW0+XJShAzj1niKIEnwxuwz6KuH7UvbmzAMn/WE1bvSLQMHnZVlw6ZC1p8t4aqyQQSlYtK4SX1jbY8BK0uSS89WDsPodmmIwT0Xy8xElLcp9yoqOKjDSxwKteOGtx3ABnZLP8xpFFEhdFU8agpHPtU3YjrD3psHZ2XpmQB33LVpR3LFl5phpX1P1Rgkyad7iC4NaNL4ofXCrDrF8yS/by75RqxqxEQxun9hqJhzeck2QJ0hzPw5tBFE40GSDUtUNZUdbxclKX+Y43bQtKRfPBH6Gg8Wdvx3axWT0vY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1E0WC9jK0hxeUVuYnBSelhrTjB0OWJGVCszYTZsUlgxdVJiSDYzQUFFd0ZD?=
 =?utf-8?B?cE9GeVNTbUdQWi8yWGk2ZWJoTHJtdWdRNHNWT3Z1VU1oZXF3MzZYUHAwMGd5?=
 =?utf-8?B?Z0dMR2tiamw1bHZjS0g4bjJSTnhGWENQM3FhaS9aOE0vdDFDWkV6Z0pKTDNJ?=
 =?utf-8?B?UlhhSk91ckhZOFhDbGZvSnNLMUxaWEhnNnNab3ovRXFiSFZxaDAxZkF4V0Q5?=
 =?utf-8?B?SmU3MFFtSk1PRDZKdGNFMWxMWXJDcElnMlRFVCtjOU9iK2E1NE9nNmNJKzVl?=
 =?utf-8?B?MGtrOXpvYUthNlJSM3hQUDJxcFRaZ3pXNWREWUtyQTVTZmROTFdWbzh4L0Iw?=
 =?utf-8?B?cUh1d2pwNStCZmlCTWsrNVFvY2Z2M2NxWENpaTByMG42LzJmQnJFclVHazJu?=
 =?utf-8?B?NFJiUmhGUkFRZ0Z2WjJPbE91aWEvR1B6dSs3d2F5S1ZzeWZqNURZR0Z2aFFx?=
 =?utf-8?B?bzkybllmcnAwaXZuNVFMR0FBTU52a09TU05JdHZnRnJLNEJhZFB2NmQvQkxm?=
 =?utf-8?B?dHM5WnVHNzJZV3B2RmRGc1Z6Zy9pZXhjWE5kL1MyTTkwNjJDcFB6bzhzdCt6?=
 =?utf-8?B?QmZBTkdTcWtYN01sMFFYUW5UNlpSSHFrL1lOUTdUc0tST29HempoQVRrL1Fx?=
 =?utf-8?B?THFSZjRNQVpCSU1DUlhaYnV0YitKdFlxMmJsa1QxY1lXK29EUHAyeFpzREth?=
 =?utf-8?B?MzhUMnhCUk5NQno4dkF6bkxDZXRVRE9aV3R4cVA4UkJ5Qm54RXBLbWpxeUVI?=
 =?utf-8?B?cDlPSThOZVAxTDVSNmRKby9POUZkMS9iaUFCVkwwakhQdmY2RTF2R2hyRi92?=
 =?utf-8?B?RUFUUDhjdFRxT2pkN1ZHNjV1T1ZaZWJDZlpXTnhlL2xVZ3Y3Y1FkMmN5SW11?=
 =?utf-8?B?bjFISGJmQzZnYjg5eVFqQUFLdUx1d0ZacTVGdUVDdlc3a3JRS2RyaXFIYy81?=
 =?utf-8?B?Ykc0Y1VUVFQwMEd5V0VDc3VTM21acGVOUXNVUFFCYUlPK2t1UUg5NFllaXNp?=
 =?utf-8?B?cmdBd0JsV09aWmFrWWRyamNlQ1FpR2FkTHpTdGd2ZzZkZ0ZYYjNwaVgyQVBG?=
 =?utf-8?B?RXlkUmtNa0RrMWFPT1JLeVJ4Zk00WVJFVm1pcDJQUytiT0F2b2N4dTRqcEln?=
 =?utf-8?B?RGNpKzN5N0FFZTZsQkR2eTJiMkNrM3V0M3BWdFl1QThrcWo5ZldsdSttU3lN?=
 =?utf-8?B?czcydWNmdVk5RGlYTk91TW85M05hZHM4ZmNlNlhzZTMvK3l4aGcxQ3ZJSk1a?=
 =?utf-8?B?dzdBaysyc3RaaDlSc054OGdzM0RhM2E4TTM2czQ4Y0dQcmFpQVRIVC81UmVB?=
 =?utf-8?B?RTBlS0NIanowR2pUUmUzS2FyQjBnaTVIcHpiVHRYbG8xeFUvdktkdjU3VXZu?=
 =?utf-8?B?MXJtSmltVWRIRy9keE5RcGl4YVFJMlkyN3k4dmJvbXBSbm5kSWJSUk51RXZr?=
 =?utf-8?B?RmV4NDRQL25CLzlkZC8xREJOeTd3eWtjSVFmZlJJTHdpZW1QQWVtbWJDY0Fq?=
 =?utf-8?B?aHJhUW5OaVVpWDU2NXZYT1IvaHNoZVFKNjY0eFp5em5rZEp6WWhEb3doVllQ?=
 =?utf-8?B?SmdwZXpFVFdHUW4vVCtmS3dJejd1TEZGcWVkaXlDajk0SWgwUm1rcHMwMDVC?=
 =?utf-8?B?UWcya1ZuQWR2N2IxekE4NWtEdjBsL1g0M0lkc2xLdXk5QUNheVl6Y1NRSmts?=
 =?utf-8?B?REJpUU1LdVcxUytoRHphczkxSTRkVWVkbFNVL0gweVFIYXNTQXkzYkdCSWQw?=
 =?utf-8?B?cGNncFRVWVM1VUUvUURZdjhkVGVaTkxNVzFPQjZNS2FQVDNlUXE2N0tIYTBh?=
 =?utf-8?B?MDRSS3U4K0tucjRtdEg4aDc4d0hWV1oyRzBhT25lOVhPRDNzZTk4TkwzclpY?=
 =?utf-8?B?dEhlcHpQc2FQVVhOYis2WnE2cjhHbXUxN0hoZE54MnB5VjFkZXNGN1FrZkVK?=
 =?utf-8?B?NDFBTDRZZVVHVnU4a2ZUU05nbmd5WW4vZ2g0MVVNQ2dpeGhmZ0hDR0tlMjJN?=
 =?utf-8?B?cngzV0pjL2lsNmt3UVcxL2daSExpdHoveFlLTVFaYUxveDFFd0pXN1dSWVYy?=
 =?utf-8?B?M01MY2FoRDBtZ1lRSlFwS2J1ZU9qRFNOUlRyR2dNR0VzaW1iV24wTEJVNXJN?=
 =?utf-8?B?Vk44RXAzR2cwcTNDTm8yUG12MEFWUWhkQVZJQjY5ODRhVytqZkUvR1VVMi9F?=
 =?utf-8?B?RFZ2SllGL2RTYnhseHY4d3QyUWxNTGo1Z3Qvam8xMXhwUjhZUVpNYnRYeGRP?=
 =?utf-8?B?cUVpY1F6dUlmNWtTWnRMWEtvUUJiNTduQ0FTYkw4QmhDV0xjUkNpTFF2YTNS?=
 =?utf-8?B?U1dtb0t2SVlpZ2xrU3VDVHhDRDdjTERhZko5MjduY29KMUcyY0tzdz09?=
X-Exchange-RoutingPolicyChecked:
	GVOWS/NZgsYCvIwVFmVrr+Mqofnyohfhuhix2cQzfYCnkJhJp14OD1AZt67bkeFZzjFyhoEDKLSkKoAaK4cNNNKpnWMd65sWw9L1WmhdtL2CD2JdaSpoDSVyf51P05WI8sy+7R6254wYmBKnC9dn2qqgvzpqDRQcFwbmZJEyFK0a6tbWPP9Fb745V23kLxH/7qJ7J8EC4ayr0cIWcMtSCtWXAE9Ow5prcUfbS+vOYKnFZ8kFQ55j0F0PEbxF9jZPlgeswiGBc3AxoqRbc9TlbU+rIy9EiIUb6ZGcIy8ST0ArPhEvmwQzhvjxX7J1drSI9ZwjBDUpCvv2lkRfX8B9FQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G82tMa7sf7rK5wELRmNtMxV3Infs3yR40pJLmH6tayPT8DNUSqT1dN81udkCVfd4xMeLZZGb/1tvkwSlIW7Zw+37tPNuX8NrtKxH9W7ZthYLMFc9Frsm2eYo87FOltY5QBR8Y89Bz72ORDsgQ1C9/J/XSbHBgLODK600DPdnUg+OC4sRgI1PzGVz33S5Pka4DhFehw6n8ZOD+yG/4ACfTxPVpcZxj4MJbcD4FGMYAKHgoI0Nw8M4+rVqMfOAmGtHvT9jrdYPsCqpHa+q+HQjJ6cFbyTgiFo399wf10o0DX/idbaG8YerqJVe0gsVQr56THzrqJJngciXW2tHkNhmg4jsjpbFXQluN/dVX5V8CgJP5vSNnLOazICvjEiJJIaWCCaqgJhAWPnWSa0oMo+ttxa536e8+p0zW7LrkX7kEgZvVTPPQf8ivI+pos7jg5+Wo/ijtQn/4IC52Y+nMjHzrkK8X8H3OXOlHfDdGSlqYjo7R3QXJdmQlsVx8g9QsjgdLQ6O9P9oZsX9Uyyfe3uc9+ipv8E5AEgSPEsOek3KsE4/izJDHxFtJA/Sf1edK0cZDi9VYSOm+llqcKaQUCeBdUxSClbLrh+OJO6LssiMglc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ed551b-296a-4afc-7d20-08df212915c5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 08:34:05.5163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNoQos0J9Ur9YaU2d2N8VEumLhpQ4KIPiaTAdl7OyY/1/rwtbVQDSKrMe3CCUyMrzjwTOoQuQV9ws6q/GKudzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF334FD9217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030033
X-Authority-Analysis: v=2.4 cv=afj0Dhot c=1 sm=1 tr=0 ts=6ac0be02 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=Zmrh2Q6xAOpAHthzdeUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAzMyBTYWx0ZWRfX7pfax6d6bb3I
 cyUBfBU4RkXkkvBuKITTULJTHsEiBE2jpugtOSoGocmYZCa9PtBitPt8rvNPH0962yEBH1Hnlcg
 XoycCkOKQeRYEUAjscxsy2tb/yyTnO2TAYzY1j/zYHkgJT7y/yCaoRaN9ZkXSSU2m2TektaiAEd
 9wIQvFmoBHNy4saC4WTWv74pSoLaz8ytqrBPpXFsCKUmt7g+icMMKYJvJI+/4Qx+x3uTVTF3XBG
 /Y8yHEcm73oZoZtJSvFE6l2nF4SGXrYPopUn7PP7w6VorvVF+b/e0KkrdrmViNPPBQR7TOU9ues
 eceMjBq3a4YfmbBWUQ+2a6YP35BgMXzP5LB9zYQBYYCuRhNj9VOZcb8KxqDowACxB63GwqXcj8Q
 UQhpZrYpVO7vpvYr/smRy4ZkINoR2whTgFsCVtLqbl2yl4wqIh8UouNGdWCRD0c0gl9xZLT8MV4
 LCSWptPrhDU1WS8G8Iw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAzMyBTYWx0ZWRfXxq6SoYrkLDTF
 mfzIwpQqo+aygtc3tttaDMZ91gjUCpB7a6wpcdU7NQF9COan50skTYD+TQak06K3wyBJvWbfUI0
 ahJWkVM+Aa70utoFbzVdViTrqyoun9Lt/LVO9FdBEXzKPjhh3NSS
X-Proofpoint-GUID: FlgV8gkMXGrH2r4C6aHaW_XE3mM9K_zf
X-Proofpoint-ORIG-GUID: FlgV8gkMXGrH2r4C6aHaW_XE3mM9K_zf

On 02/10/2026 17:25, Nathan Chancellor wrote:
> Hi Yonghong,
> 
> On Fri, Oct 02, 2026 at 10:40:12AM +0100, Yonghong Song wrote:
>> Could you try the following patch to see whether it solved the issue.
>> I didn't have environment to test arm, powerpc, riscv, etc.
> 
> Yes, I had to manually apply it but it does appear to resolve this
> issue. I'll put it through my full build matrix soon but should you send
> it formally, feel free to add
> 
>   Tested-by: Nathan Chancellor <nathan@kernel.org> # build
>

thanks for doing that. If all looks good on your end with the build matrix
let me know and we can land it asap. Thanks also for the quick turnaround
Yonghong!
 
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index d6b9be6..2f137ee 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -2913,7 +2913,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>                 encoder->tag_kfuncs      = conf_load->btf_decl_tag_kfuncs;
>>                 encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>>                 encoder->encode_attributes = conf_load->btf_attributes;
>> -               encoder->true_signature = conf_load->true_signature;
>> +               encoder->true_signature = conf_load->true_signature && cu->param_loc_supported;
>>                 encoder->verbose         = verbose;
>>                 encoder->has_index_type  = false;
>>                 encoder->need_index_type = false;
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 1e5363a..9f9b9c9 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1518,6 +1518,22 @@ static bool arch__arg_align_two_regs(const GElf_Ehdr *ehdr)
>>         }
>>  }
>> +/*
>> + * Architectures whose argument register mapping has been validated for
>> + * matching clang parameter locations and reconstructing true signatures.
>> + * Other architectures keep only the basic optimized-out detection.
>> + */
>> +static bool arch__param_loc_supported(const GElf_Ehdr *ehdr)
>> +{
>> +       switch (ehdr->e_machine) {
>> +       case EM_X86_64:
>> +       case EM_AARCH64:
>> +               return true;
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
>>  static struct template_type_param *template_type_param__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>>  {
>>         struct template_type_param *ttparm = tag__alloc(cu, sizeof(*ttparm));
>> @@ -3777,7 +3793,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>>  {
>>         struct ftype *ftype = &fn->proto;
>>         struct parameter *pos;
>> -       bool true_sig_enabled = conf->true_signature && ftype->signature_changed;
>> +       bool true_sig_enabled = cu->param_loc_supported && conf->true_signature &&
>> +                               ftype->signature_changed;
>>         bool check_locations = !cu->producer_clang || ftype->signature_changed;
>>         int reg_idx = 0;
>> @@ -3785,7 +3802,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>>                 /* Producer is clang and the signature was not changed: match
>>                  * each parameter against its expected ABI argument register.
>>                  */
>> -               function__match_clang_parameter_locations(ftype, cu);
>> +               if (cu->param_loc_supported)
>> +                       function__match_clang_parameter_locations(ftype, cu);
>>                 return;
>>         }
>> @@ -4533,6 +4551,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
>>         cu->nr_register_params = arch__nr_register_params(&ehdr);
>>         cu->agg_use_two_regs = arch__agg_use_two_regs(&ehdr);
>>         cu->arg_align_two_regs = arch__arg_align_two_regs(&ehdr);
>> +       cu->param_loc_supported = arch__param_loc_supported(&ehdr);
>>         arch__set_register_params(&ehdr, cu);
>>         return 0;
>>  }
>> diff --git a/dwarves.h b/dwarves.h
>> index f3453ed..6b75ece 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -305,6 +305,7 @@ struct cu {
>>         uint8_t          producer_clang:1;
>>         uint8_t          agg_use_two_regs:1;    /* An aggregate like {long a; long b;} */
>>         uint8_t          arg_align_two_regs:1;  /* An over-aligned arg starts on an even register */
>> +       uint8_t          param_loc_supported:1; /* Parameter location analysis is validated for this arch */
>>         uint8_t          nr_register_params;
>>         int              register_params[ARCH_MAX_REGISTER_PARAMS];
>>         int              functions_saved;
>>
> 

