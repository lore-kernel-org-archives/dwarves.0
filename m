Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C7517B50F;
	Sun, 30 Aug 2026 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788109752; cv=fail; b=b9aGpCiaIUgpivCk1aN0OeVkqMO8QgnMRHKqZABsjdWohUhcdvxXqtfej1TLRk30zRwzAfRj/FDqNNX1LYJBjdwsZuhyOZZR0a6IjGTSt0eDkluNVQdUET9Ek0EayBGEEYWX+GRHz53nGucRBMhphc7+KQNUYwcmKkNKYb3aYtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788109752; c=relaxed/simple;
	bh=SjZN0SVpnZQpFBxJgdk1/jQ6z20v5s42h7wcgeNLzbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUUhLPde4CwBNy2sr48d2z5CORARpsMz/B/eD/48DtpgJWUmOIpb3DplKWMOLchnC2pMxdRABfuSUK7chSPLab359xBGGbWrhEPpkkAC+J75O0c5J1e76QluzZX/i0CVXVQLs0gIrkwtIB8dldSCiDc/Eg9cDxyXPSE7c0e0R5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JoWSpEFY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YwUTs9ce; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JoWSpEFY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YwUTs9ce"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67UGmKxu770698;
	Sun, 30 Aug 2026 17:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n70uyhA7CHssuZtpSCXn2nnMUld80/j4zMM/Vc3IYnc=; b=
	JoWSpEFY0Ik6Ni4FUvCaZWdiNRgLsLNna8l0e/ao1WGIT5D3Nv3mLCB7oGEFQfG7
	Fft/Ya0DZ7+yhq7ioORK391xnHe5HPgd6RN+qRq0gDf6hWiH5ntkt9qeBWtH2wvm
	M44B+T/Yupns1Ml1b/aBzA0e1Yu+mt8oEVkyj7NbkhUy4YUJ/RdDYRyoxBzL8H+I
	U9SdS62V14BjyJj+S0eMOwSyMFw5VBMRB1nRv468l7IdIcF1QyTSdnO9FBAErVnF
	Z6GtxIasTK2cOd+ypU49F9k7a5tHfpM/3DBkChUPkevXSO4Mf8kU1p7xmzjoLdIM
	Hzx6t80rr7m6n+X2/Na2Zg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqfc1gtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Aug 2026 17:09:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67UH5ueM032242;
	Sun, 30 Aug 2026 17:09:00 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvndnxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 30 Aug 2026 17:09:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJAE1M59potr4iD9Ra3yGuEp5GtV3RLZ++wgGG6VJOx+4wuSwW3brXlD8Hxj+Kp4Y2i6XJ1t8wD9QvicDP9f/6Oh+2QOWUss+Y8N55O8dAXrh/y6IISRG7hi2BYaarHpzZLRmyDAda83VxQ3FD3gcp2OhlTLBvJxcUVsDO/kmFgwGZdXzSGn0/yTgYZg4FYvCE9rAd1VobVLqdb/8aMmzi2enaN4W5+fFFtyWG042vUt2z5ONLbag9TJKDae/1Qf3qgK2ui8PCoGeZLD7L2mMOWWrD+GbsRHVwGCGywludDFQajJz/VnZkiv7IHFtAMLEpK1F2v68n19h29imRVEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n70uyhA7CHssuZtpSCXn2nnMUld80/j4zMM/Vc3IYnc=;
 b=vd1qx0DqAeDdDhzZF5squRBFiEEJoj4VV7Ss2y5bXqyVZAxK7TdUWDOpha34+R7sQkt1pZUvysN6DLX+/Ju2CxY9Ao6aLoCseYRqTiVy69HSxqffvOGkCnrlIlEOtxPEiEQ7qUTfD6AsVl8geP50Jn1WNQMO9oqngadjEk80rMkfyHBqK06Uv9p5Mn8Hpd9/+3+1iR6hLNm92yAtNjEShaO18g/SXfzYgfkTkm7xW2VQtqZlOvnCOplvOkGFXqfUZE5eV4RL/Y7wuEo+VzFwSHCNsPwUtrQgqmqReypp2tJsMIWursAK8Ey3yh+VChBciRyaRaWt+ow+AGLg99/S3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n70uyhA7CHssuZtpSCXn2nnMUld80/j4zMM/Vc3IYnc=;
 b=YwUTs9ceAIoHKMJTmZQ+H08Nqm4dalXDHpJQ0ewh/H+aghQwOxZbckrhiz0jRO/77H1v4+cHmFIACBxlnZqq5Erq0NgWg6tEMKrlpkLAiXwZ6R9AKd6WcYjHpaJOJ13RGTWg28C8dNsmTwL7RmURm7B9VRq+ITqk9X1SiJwoVU0=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CYYPR10MB7676.namprd10.prod.outlook.com (2603:10b6:930:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sun, 30 Aug
 2026 17:08:57 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0382.007; Sun, 30 Aug 2026
 17:08:56 +0000
Message-ID: <5e3b9e48-00f5-43d1-a383-2b1c59342e87@oracle.com>
Date: Sun, 30 Aug 2026 18:08:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: RFT: coverage analysis and lots more regression tests in the
 'next' branch. Was: Re: [PATCH v2 0/9] pahole: Support cross-CU type
 references and dwz alternate debug files
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20260821213510.22423-1-acme@kernel.org> <ao442rldWrCNG3zC@x2>
 <d85a69a5-b08a-4ec8-b09c-4e45b7c1f712@oracle.com> <ao7lqxytDiHmVmkk@x2>
 <0e1c3820-c16b-4266-bde4-655b760b3db4@oracle.com> <apISzIQ-gjPB8Xqw@x2>
 <apM_W9ld8Bj3q5Vk@x2>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <apM_W9ld8Bj3q5Vk@x2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0499.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CYYPR10MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 818eb50f-7017-49a7-c9b1-08df06b9606d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|13003099007|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BniBIbW2671OxuXWOTgSifV1rycB39php5QQkpdi3vaCNKtC05cUdQgobRLdnOTNoWVTSmKRM2fESh2wdFLm/SsCfy0uJJffDuCi/ihuKu8t8JIrHbWFHxmw8xYjY1Y+yNnTvmRTquZrgkEqxrrVwyuiiySy2cEkL8s/DpxHrAyRbIs4TBK8YAdAAjMTd10iAsJ/jXoKRhx3x0Ox4GeUfwFGufLCM3apbhj69xTLb5k9yPLG9vU/M1rpxmhf4i0Ee46Px5K1FVjVM8Q04PN2fL3Pw18szcYQHFa9HAKWo6bmFZCNCkFyne2UnkAH5Hs1bpItGGlAoKJqPnxPA3To9fGdruI3IeZmWOixmz8JtxEdcleT7nFKfHfBXt1OA2/Tki7JqUqhzcjwHdrHxN1VcBuYFn/9DjDC8vj/+CtN6VJa4I5jmwXB34BblS2wI53P+M+feW+Y1BVf/XfF/MMiUddAnOxqui8hFwftzTuyhZJVd346w/IeClZm+iHoAO7inJ39SUqpSYsbnOx5ftwRaEZx2hkLlzoKYFSD2Nfdtw4uEKTY2vJQXPbF3Tx3Uq42GZPU5P3upbkGHuZGPn9lf2VyVep5BExHq/7yPJNToBY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(13003099007)(3023799007)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alExK3pqUUlUdFhkanZQU0V6L2xSN3RQS3JQL2JxaW16KzJhOFI3aGRLQ3Nj?=
 =?utf-8?B?WVowR0tsVWtPOWJRNDJVdE8yTnBLaHV0VTVxcHM5bTY1eGgzcW8rOVora3Qy?=
 =?utf-8?B?cUNmYnFOOXVHc05KRkU4SUhTaTZRYjE0eWVLcFlCcDJDZUYyVXMwUllOcEta?=
 =?utf-8?B?VWZDd2FWWmd0ZU93SkV1cnJGelZDTlZ2bHZhcmZjNGxicW5FZm8zRmtlZytl?=
 =?utf-8?B?U3BOcVRuNjgyZm1wTS9PQ1J6Snhjd1M3bEJZdGpSRU9lZ05hSlMzVjY1Qk1m?=
 =?utf-8?B?TTgrSjZqMVNHSHpUVmcrTGhxaFo3eDhwcnc0VjZ2c0FHU1BRMDRhSzEzck43?=
 =?utf-8?B?ckxRaTEveVhGczUzS3A3RFBzQm5XZHVOODRzZVcxZ2Q3RTZtT3U3NklzR3NL?=
 =?utf-8?B?M3hENWlKdHhxdVJjWHBFS2dUbUFPaS9BVVVNeW1EZ0QwcnJBV1FDNTNwOVF2?=
 =?utf-8?B?OGFqaG9rdmpJTGhuM0dEZVRMUjRIWlFXb2plYWVjcnJTdG9sdW9HRTQzYmZU?=
 =?utf-8?B?b05uRFlYSnNVQ2lCVTF1ME9EbHI2dlQ1U3BUYnF5Q2dBM0ZkQ3N0cGJzY3JO?=
 =?utf-8?B?THZIcXFSUW9kblJjUVo4WmNkV1FETHgzb2t1TWtSN2t5ZnY2VFFudm53NHNM?=
 =?utf-8?B?dnlnWXE4NGl1RDNpMStEVmNFdnlRbEU2MngwTndHUU9WVExRYjRpb0VsNzVp?=
 =?utf-8?B?UmJqQ1c3bTlsTjQ5S3R3cWs0ZUUvbUtpMEg4MmVleEZqVC9aNEFFU2NoOXpI?=
 =?utf-8?B?dmFlcklCWENBOW5MR0RtOURjU1RKZFV0VDViWXFhaXhRZnRUOGFRTlF1UWpH?=
 =?utf-8?B?QUJRTmF6bS9MeWlieDRENDhmK0ZLKzVGMXNHVlZWY3lpc2ZheFo1YUlwWStL?=
 =?utf-8?B?djZWM1BndnVKMTYyU2g3SDVFT3pISWlxYTd4SmFWMzkyb0tVcStWVmlUNi94?=
 =?utf-8?B?LzFaaC9YdVZmN1VyUEk0cDhEQ2ZOUFU5RERBU3NYS3lURk51QjJ0YmxRZm9R?=
 =?utf-8?B?eHN4d1k3YjZLTGhUYkNidjJ4aGZmSVVpaFNwN1NvOW1NdUEyN0lSSmRVYnlD?=
 =?utf-8?B?d2E0a2tJMHRrR1QyRGZDZ2lFUDVBNEltM0kwdWdHYXBjMVRJSUY2eFFMNG5T?=
 =?utf-8?B?Y0xpcFd5UFVWcWE3NFBvcGhMMXhFV2lEamh2azBzYU1PY2FpTExsQmQ3Wkth?=
 =?utf-8?B?SW14YjVybDAwS2xrUm5SSXk0bmVXdHN2WTRITTdiVHdTdGsyNmRWaWtOVjJS?=
 =?utf-8?B?TVdFdXRsU2grVEZOdVdZcVd3ZlQ5SGVMMFNCcG54UThtbVBOQk5jWlRUOGxG?=
 =?utf-8?B?a0doNE1GbnpzV1VaYlJpMGt6ZTJQSCtkV1NFT0NQdFhmbmEvKzBrMng5Q0Rz?=
 =?utf-8?B?ZkFpa1NpZXNwU2cxUnZ1czdzT1Jpdkd5NTcvTlZtRENwM1R6ZmtVaEg3YlRB?=
 =?utf-8?B?OGtzK2o3T0hlbmNYWW9VTDVaQXcrem5UMVNKenZMUy84Q0dqRkIxcUUyVzRy?=
 =?utf-8?B?REg4MlBGa0ZJU1lPUlpiZlRPcm1zZTFqV21LUHdtdjFRN2FWbmwrYnhJUGhJ?=
 =?utf-8?B?VEJSeWg2YVJXVUV4Y1p2NGlYaTdLNWN1SjlBOVpVUFhzaDZXTlBTN1hrdHZt?=
 =?utf-8?B?MHFOZkJuRVgyUFZJMU9HRmNTV1lDL2Iwdy80b1JpZDRGb3A4ejk2YUh3OUtt?=
 =?utf-8?B?UlRKcVBOUGxuVXgrSWQyOGc0L1FhQ1VUTXFGSU1DcGpvbk5UckhoanJsUUhR?=
 =?utf-8?B?bk4vLytEZzZ3V3lCVWhwdU93ZGxRMG5QVVk1TnlJSXlxT0Zjb0o2N2hlZk9l?=
 =?utf-8?B?b0FGcXBIZTZOdENsMmFiTHJ2bmhzcHhEV3o4YVVqbmFpOUJlWnZzMDRPTi9s?=
 =?utf-8?B?THNRZkMyL1FQVW1Xc2RURklzVFNGWkZKVzRaOFZGWHUzb0xWaHdObm9aWmlL?=
 =?utf-8?B?TXgyaUFmeHZvcGE0ZXA4RWducUV5WDFaZTBTaVVZeG9Xd2FyaU9qbmVIWG0x?=
 =?utf-8?B?K2dkMzlSL1FxQ3JVWDRueTdwMGUyOEpVaWFTRUtuWDlCRTFEOU1kSmNNNUhG?=
 =?utf-8?B?N3R2Z21lZzhscytBR1huY21yaWt5ZHNjWkhCamxCbUlvb29hMVVaQVp6UzdZ?=
 =?utf-8?B?YnI4enNDMUlodExSN0JrY29PcTJQaDZwNitJU1dPdS95TGJYSzNIRHNJUEJL?=
 =?utf-8?B?TFVlM3ZkdGdmRGU1MUlxTkVkcktHZUFxMldYdjh6ZDlrdTlSNDVvWjlSOTR0?=
 =?utf-8?B?RS82Y01HTCtvWlg1aEM0U0lrQklQU0IzbXJqUWVtWWZlQlhJZVBmS2h6bUdY?=
 =?utf-8?B?b3cvOU9ZTDhlQnhGc1pwQnhJSW9iSmFEV3lic0tkbXNQUytIL2Qwdz09?=
X-Exchange-RoutingPolicyChecked:
	l6DnTVnw3EOSpaZvtzJaQaPyWVqHpIX0fc8Es02v4tKJZf6e1InMY6iP9cAfoXE/8JqGE2Iug51bbNP4H9CSxTTFv1Ti+nsCd9hGB2MkybBA0r11nzkDjQHAaPCwUiH7ip8UIUo8Aq9cWwoNAEKIMKxsVvcNwnACV5MUZXImQ+YKdquSzqmR2C1ZQI7wMTtndeBySDU23mU7EIkFtUJU+lxwkGx9X2hx70vergUjaNrYO+fxM1AR5rfsHXdbcwagyFwq30hAZ+SxNVYwbR6jibtrtVLa6mKS9NPlSGnZUWbWMV77m7dmghRE24Ml6IO1319qr1FWNlWn1ag4dNCpAA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HggKJqR2nfE0SfQiSTv8Zs+vlV2cAl/89XLmGGWhimxLthQ6hLDKK1OutTK5dsAD5CDkgjaSluneEYrK6XfClmqmV4xXl2ivzGcWkNC6hnvH7c0BmE8mSOBjBJBo09WkJekqdvlMqHvJ+G1qKUioC1xEWhmwBUwV6WottG2WCDPQ3br2wg5HxtK8t/n5tsOvJdK8NR5t8UgqoB4dlux/Wch7jUi8nB1H7mHGXe4aqhTnQM6mvUQOPqJyYLapK3YD0geX2ntGlhdjn/S6hetjOt5wlYevugez4Z50DAXGiWU4kSv+/Kk+rTtrKXhQAol4E3UaNpLl2DsC5CLP6LSIPmUoxQ6ljwFauqYk2Xef9fqEihe3ndYtsJrLE19B8O85YG/AuEhlmF2/GzdyqyLegEeQvc+tiNHBwiBbXuPZbW5PwFtuEd74NW/wLssRDVNVDM7gDMYMyOCO3wRwHhv6rksb6I2umHe2CPQkhCm7Mx5s9wK0xxRupgOUXawZcpmS7LPOMH5mvx8JwoKDQzUUc/75DmeD+ccVS+b+cFCy3Qk6k4nSJmn/fMZUPLyNdnuQNELCUANas+wjVLRx/T7mJ430QkKDKtLV1wkfKI8HVGI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818eb50f-7017-49a7-c9b1-08df06b9606d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 17:08:56.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1w2LNxOntvPMe9sMOTs1UOUG69nYXuy4JnzkeUVOxtQ6LpfNiINvQRfTM67l95blFuhDkR4S6eE+LE4QeZVIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608300149
X-Proofpoint-GUID: oOKrlKIFXUui_C0kZUoLCKTk0tLsF0l7
X-Proofpoint-ORIG-GUID: oOKrlKIFXUui_C0kZUoLCKTk0tLsF0l7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDE0OSBTYWx0ZWRfX3bSBn8x3s2cK
 yVTGgnF2N0URKSoEVrS5KWiXaxpXN6EZLIga1ytIsZMJ719J1LpoR5Lf225NtEj76m5st/Vg+FI
 Zc9A8KkouLshfe7KcMkLnyEi4GrAwFw8m2XbKQO5JZqIOI37lwhY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDE0OSBTYWx0ZWRfX2ERfdHEH2q1g
 PctgGQUtg3c52g8EUwmH/gPgS+sg8dfyMdOyh9embhx5ZxzrbDINgwfDXhF0juQCxCdGw/kcqUq
 c0X/L7awEKske/nDEfzB0FLr0A4pJYlI8AfGvIJ6mw2evm/bWqyayEaAEBN2iPFSdeUnYM3S2+R
 zbmENJifOAa2GLXnnj6cvOwY+hTYCGNF9tcQfO/eEO2XRLFKAQwX5pBBCEb4vCM8W6BSO4X1eWF
 OLIBPP0qM8gxCctgaQLW/R/J+OUorlciyZR0PueL8lwRkH0QIjfT1+/59t2BfjSq/xPFYrg7uMo
 SEfQsOi93WJJLh8keNn9Q5Gr5ik229me+jIOZFuJ3XOBvvFNlvwJdXxHsLeyXVPASMC7KZVBB+H
 7mTISV2uguk4sh8wlkqntLOy9PHvChs4WIdqdBczBnJLp4PEPlSMmFr4nlnnPf0+Xzn2PTevCfO
 1FLRxLCikXFaIwyXP9a1QNU170gJXTpN8ENRmMD0=
X-Authority-Analysis: v=2.4 cv=a9gAM0SF c=1 sm=1 tr=0 ts=6a9463ad b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=4sTS_6pONLzcBzzJ:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=NEAV23lmAAAA:8 a=6Y5Apc9KAAAA:8 a=20KFwNOVAAAA:8 a=G7c0JD5yuJu32okDAlMA:9
 a=tj-7Utz4YL5RH8b1:21 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=LYiVte_mdfbVfDfKkWfN:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12102

On 29/08/2026 21:21, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 28, 2026 at 07:59:24PM -0300, Arnaldo Carvalho de Melo wrote:
>> I'm now in the process of cherry picking non-Rust related patches,
>> things that don't touch the .c files in the tree, just adding coverage
>> analysis, tons of tests and scripts for helping us do bisection tests,
>> etc.
> =20
>> I just pushed out the first batch to the next branch, I invite people to
>> try it and report results, it should help us to catch problems sooner by
>> testing most of the paths in the codebase, which is super important
>> these days where we are having (or will have) tons of patches being
>> submitted.
>=20
> Got all of the coverage analysis and new regression tests on the next
> branch, and run the 'build-and-test.sh' script on my set of containers,
> where all the test ran on:

This looks fantastic! I ran it thru CI:=20

https://github.com/alan-maguire/dwarves/actions/runs/33255515875

Let's get the coverage report enabled as part of CI too..

>=20
> toolsbuilder@five:~$ cat dm.log/summary
> Subject: tools build test for http://192.168.86.5/pahole/dwarves-1.31.tar=
.xz build-and-test-cmd.sh
>=20
>    1    78.93 almalinux:8                   : Ok   gcc (GCC) 8.5.0 202105=
14 (Red Hat 8.5.0-28) , clang version 21.1.8 ( 21.1.8-1.module_el8.10.0+417=
2+b6b13d75) flex 2.6.1
>    2   158.15 almalinux:9                   : Ok   gcc (GCC) 11.5.0 20240=
719 (Red Hat 11.5.0-14) , clang version 21.1.8 (AlmaLinux OS Foundation 21.=
1.8-2.el9) flex 2.6.4
>    3    36.95 almalinux:9-i386              : Ok   gcc (GCC) 11.5.0 20240=
719 (Red Hat 11.5.0-14) , clang version 21.1.8 (AlmaLinux OS Foundation 21.=
1.8-2.el9) flex 2.6.4
>    4   167.45 almalinux:10                  : Ok   gcc (GCC) 14.3.1 20251=
022 (Red Hat 14.3.1-4) , clang version 21.1.8 (AlmaLinux OS Foundation 21.1=
.8-1.el10.alma.1) flex 2.6.4
>    5   293.08 alpine:3.22                   : Ok   gcc (Alpine 14.2.0) 14=
.2.0 , Alpine clang version 20.1.8 flex 2.6.4
>    6   289.06 alpine:3.23                   : Ok   gcc (Alpine 15.2.0) 15=
.2.0 , Alpine clang version 21.1.2 flex 2.6.4
>    7   255.51 alpine:3.24                   : Ok   gcc (Alpine 15.2.0) 15=
.2.0 , Alpine clang version 22.1.3 flex 2.6.4
>    8   262.55 alpine:edge                   : Ok   gcc (Alpine 15.2.0) 15=
.2.0 , Alpine clang version 22.1.8 flex 2.6.4
>    9   152.16 amazonlinux:2023              : Ok   gcc (GCC) 11.5.0 20240=
719 (Red Hat 11.5.0-5) , clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4) f=
lex 2.6.4
>   10   152.38 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221=
121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn20=
23.0.2) flex 2.6.4
>   11   171.22 archlinux:base                : Ok   gcc (GCC) 16.2.1 20260=
810 , clang version 22.1.8 flex 2.6.4
>   12   160.21 centos:stream                 : Ok   gcc (GCC) 14.4.1 20260=
724 (Red Hat 14.4.1-2) , clang version 22.1.8 (CentOS 22.1.8-1.el10) flex 2=
.6.4
>   13    77.34 debian:11                     : Ok   gcc (Debian 10.2.1-6) =
10.2.1 20210110 , Debian clang version 13.0.1-6~deb11u1 flex 2.6.4
>   14   154.23 debian:12                     : Ok   gcc (Debian 12.2.0-14+=
deb12u1) 12.2.0 , Debian clang version 14.0.6 flex 2.6.4
>   15   157.32 debian:13                     : Ok   gcc (Debian 14.2.0-19)=
 14.2.0 , Debian clang version 19.1.7 (3+b1) flex 2.6.4
>   16   156.96 debian:experimental           : Ok   gcc (Debian 16.1.0-3) =
16.1.0 , Debian clang version 21.1.8 (10) flex 2.6.4
>   17   157.12 fedora:40                     : Ok   gcc (GCC) 14.2.1 20240=
912 (Red Hat 14.2.1-3) , clang version 18.1.8 (Fedora 18.1.8-2.fc40) flex 2=
.6.4
>   18   158.62 fedora:41                     : Ok   gcc (GCC) 14.3.1 20251=
022 (Red Hat 14.3.1-4) , clang version 19.1.7 (Fedora 19.1.7-5.fc41) flex 2=
.6.4
>   19   161.74 fedora:42                     : Ok   gcc (GCC) 15.2.1 20260=
123 (Red Hat 15.2.1-7) , clang version 20.1.8 (Fedora 20.1.8-4.fc42) flex 2=
.6.4
>   20   160.37 fedora:43                     : Ok   gcc (GCC) 15.3.1 20260=
722 (Red Hat 15.3.1-1) , clang version 21.1.8 (Fedora 21.1.8-6.fc43) flex 2=
.6.4
>   21   239.67 fedora:44                     : Ok   gcc (GCC) 16.2.1 20260=
819 (Red Hat 16.2.1-2) , clang version 22.1.8 (Fedora 22.1.8-4.fc44) flex 2=
.6.4
>   22   238.08 fedora:45                     : Ok   gcc (GCC) 16.2.1 20260=
819 (Red Hat 16.2.1-2) , clang version 22.1.8 (Fedora 22.1.8-20.fc45) flex =
2.6.4
>   23   170.21 fedora:rawhide                : Ok   gcc (GCC) 16.1.1 20260=
703 (Red Hat 16.1.1-4) , clang version 22.1.8 (Fedora 22.1.8-20.fc45) flex =
2.6.4
>   24    89.22 gentoo:stage3                 : Ok   gcc (Gentoo 15.3.0 p8)=
 15.3.0  flex 2.6.4
>   25   166.60 manjaro:base                  : Ok   gcc (GCC) 16.1.1 20260=
625 , clang version 22.1.6 flex 2.6.4
>   26   172.84 opensuse:16.0                 : Ok   gcc (SUSE Linux) 15.3.=
0 , clang version 19.1.7 flex 2.6.4
>   27   166.50 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 15.3.=
0 , clang version 22.1.8 flex 2.6.4
>   28    80.73 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 202105=
14 (Red Hat 8.5.0-28.0.1) , clang version 21.1.8 ( 21.1.8-1.module+el8.10.0=
+90887+a5269809) flex 2.6.1
>   29   162.06 oraclelinux:9                 : Ok   gcc (GCC) 11.5.0 20240=
719 (Red Hat 11.5.0-14.0.1) , clang version 21.1.8 ( 21.1.8-2.el9) flex 2.6=
.4
>   30   164.88 oraclelinux:10                : Ok   gcc (GCC) 14.3.1 20251=
022 (Red Hat 14.3.1-4.0.1) , clang version 21.1.8 (Oracle America 21.1.8-1.=
el10) flex 2.6.4
>   31    82.10 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 202105=
14 (Red Hat 8.5.0-28) , clang version 21.1.8 (RESF 21.1.8-1.module+el8.10.0=
+40180+8e26bdb3) flex 2.6.1
>   32   162.01 rockylinux:9                  : Ok   gcc (GCC) 11.5.0 20240=
719 (Red Hat 11.5.0-14) , clang version 21.1.8 (RESF 21.1.8-2.el9) flex 2.6=
.4
>   33   166.23 rockylinux:10                 : Ok   gcc (GCC) 14.3.1 20251=
022 (Red Hat 14.3.1-4) , clang version 21.1.8 (RESF 21.1.8-1.el10) flex 2.6=
.4
>   34   169.75 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.4.0-1ub=
untu1~22.04.3) 11.4.0 , Ubuntu clang version 14.0.0-1ubuntu1.1 flex 2.6.4
>   35   162.24 ubuntu:24.04                  : Ok   gcc (Ubuntu 13.3.0-6ub=
untu2~24.04.1) 13.3.0 , Ubuntu clang version 18.1.3 (1ubuntu1) flex 2.6.4
>   36   162.16 ubuntu:25.04                  : Ok   gcc (Ubuntu 14.2.0-19u=
buntu2) 14.2.0 , Ubuntu clang version 20.1.2 (0ubuntu1) flex 2.6.4
>   37   161.96 ubuntu:25.10                  : Ok   gcc (Ubuntu 15.2.0-4ub=
untu4) 15.2.0 , Ubuntu clang version 20.1.8 (0ubuntu4) flex 2.6.4
>   38   163.52 ubuntu:26.04                  : Ok   gcc (Ubuntu 15.2.0-16u=
buntu1) 15.2.0 , Ubuntu clang version 21.1.8 (6ubuntu1) flex 2.6.4
> BUILD_TARBALL_HEAD=3Deeb6956261d2fbe71715f0633a68fdc840b5f5ce
> 39 6242.1
> toolsbuilder@five:~$
>=20
> For instance:
>=20
> toolsbuilder@five:~$ cat dm.log/fedora\:rawhide=20
> fedora:rawhide
> Downloading http://192.168.86.5/pahole/dwarves-1.31.tar.xz...
>   % Total    % Received % Xferd  Average Speed  Time    Time    Time   Cu=
rrent
>                                  Dload  Upload  Total   Spent   Left   Sp=
eed
> 100  2.34M 100  2.34M   0      0 530.8M      0                           =
   0
> dwarves-1.31/config.h.cmake
> dwarves-1.31/btfdiff
> <SNIP>
> dwarves-1.31/tests/typedef_chain.sh
> dwarves-1.31/tests/.test-times.seed
> dwarves-1.31/HEAD
> BUILD_TARBALL_HEAD=3Deeb6956261d2fbe71715f0633a68fdc840b5f5ce
> Using built-in specs.
> COLLECT_GCC=3Dgcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/16/lto-wrapper
> OFFLOAD_TARGET_NAMES=3Dnvptx-none:amdgcn-amdhsa
> OFFLOAD_TARGET_DEFAULT=3D1
> Target: x86_64-redhat-linux
> Configured with: ../configure --enable-bootstrap --enable-languages=3Dc,c=
++,fortran,objc,obj-c++,ada,go,d,m2,cobol,algol68,lto --prefix=3D/usr --man=
dir=3D/usr/share/man --infodir=3D/usr/share/info --with-bugurl=3Dhttps://bu=
gzilla.redhat.com/ --enable-shared --enable-threads=3Dposix --enable-checki=
ng=3Drelease --enable-multilib --with-system-zlib --enable-__cxa_atexit --d=
isable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-buil=
d-id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-libs=
tdcxx-zoneinfo=3D/usr/share/zoneinfo --with-linker-hash-style=3Dgnu --enabl=
e-plugin --enable-initfini-array --with-isl=3D/builddir/build/BUILD/gcc-16.=
1.1-build/gcc-16.1.1-20260703/obj-x86_64-redhat-linux/isl-install --enable-=
offload-targets=3Dnvptx-none,amdgcn-amdhsa --enable-offload-defaulted --wit=
hout-cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=3D=
generic --with-tls=3Dgnu2 --with-arch_32=3Di686 --build=3Dx86_64-redhat-lin=
ux --with-build-config=3Dbootstrap-lto --enable-link-serialization=3D1 --di=
sable-libssp
> Thread model: posix
> Supported LTO compression algorithms: zlib zstd
> gcc version 16.1.1 20260703 (Red Hat 16.1.1-4) (GCC)=20
> -- The C compiler identification is GNU 16.1.1
> -- Detecting C compiler ABI info
> -- Detecting C compiler ABI info - done
> -- Check for working C compiler: /usr/bin/cc - skipped
> -- Detecting C compile features
> -- Detecting C compile features - done
> -- Setting BUILD_SHARED_LIBS =3D ON
> -- Checking availability of DWARF and ELF development libraries
> -- Looking for dwfl_module_build_id in elf
> -- Looking for dwfl_module_build_id in elf - found
> -- Found dwarf.h header: /usr/include
> -- Found elfutils/libdw.h header: /usr/include
> -- Found libdw library: /usr/lib64/libdw.so
> -- Found libelf library: /usr/lib64/libelf.so
> -- Checking availability of DWARF and ELF development libraries - done
> -- Found ZLIB: /usr/lib64/libz.so (found version "1.3.1")
> -- Checking availability of argp library
> -- Assuming argp is in libc
> -- Checking availability of argp library - done
> -- Checking availability of obstack library
> -- Assuming obstack is in libc
> -- Checking availability of obstack library - done
> -- Version: v1.31-tarball-g416753b4ba90 (from HEAD file)
> -- Performing Test HAVE_REALLOCARRAY_SUPPORT
> -- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
> -- Configuring done (0.6s)
> -- Generating done (0.0s)
> -- Build files have been written to: /git/dwarves-1.31/build
> make: Entering directory '/git/dwarves-1.31/build'
> [  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
> [  3%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/features.c.o
> [  5%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
> [  8%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_relocate.c.o
> [  8%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
> [ 10%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
> [ 13%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.=
o
> [ 13%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
> [ 15%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
> [ 18%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_utils.c.o
> [ 20%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/linker.c.o
> [ 20%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_iter.c.o
> [ 22%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/elf.c.o
> [ 24%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/gen_loader.c.o
> [ 25%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
> [ 27%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
> [ 29%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
> [ 31%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/relo_core.c.o
> [ 32%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/usdt.c.o
> [ 36%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/strset.c.o
> [ 36%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/zip.c.o
> [ 36%] Built target bpf
> [ 39%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
> [ 39%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
> [ 43%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
> [ 43%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
> [ 46%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
> [ 48%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
> [ 51%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
> [ 51%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
> [ 48%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
> [ 53%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
> [ 55%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
> [ 56%] Linking C shared library libdwarves.so
> [ 56%] Built target dwarves
> [ 60%] Building C object CMakeFiles/syscse.dir/syscse.c.o
> [ 62%] Building C object CMakeFiles/dtagnames.dir/dtagnames.c.o
> [ 65%] Building C object CMakeFiles/prefcnt.dir/prefcnt.c.o
> [ 65%] Building C object CMakeFiles/dwarves_emit.dir/dwarves_emit.c.o
> [ 72%] Building C object CMakeFiles/scncopy.dir/scncopy.c.o
> [ 68%] Building C object CMakeFiles/pglobal.dir/pglobal.c.o
> [ 62%] Building C object CMakeFiles/pdwtags.dir/pdwtags.c.o
> [ 72%] Building C object CMakeFiles/dwarves_reorganize.dir/dwarves_reorga=
nize.c.o
> [ 68%] Building C object CMakeFiles/codiff.dir/codiff.c.o
> [ 74%] Building C object CMakeFiles/scncopy.dir/elfcreator.c.o
> [ 75%] Linking C executable dtagnames
> [ 79%] Linking C executable pdwtags
> [ 81%] Linking C executable syscse
> [ 81%] Linking C executable prefcnt
> [ 82%] Linking C executable pglobal
> [ 84%] Linking C executable scncopy
> [ 86%] Linking C shared library libdwarves_reorganize.so
> [ 86%] Built target dtagnames
> [ 86%] Built target pdwtags
> [ 86%] Built target pglobal
> [ 86%] Built target prefcnt
> [ 86%] Built target syscse
> [ 87%] Linking C shared library libdwarves_emit.so
> [ 87%] Built target scncopy
> [ 87%] Built target dwarves_reorganize
> [ 87%] Built target dwarves_emit
> [ 89%] Linking C executable codiff
> [ 91%] Building C object CMakeFiles/pahole.dir/pahole.c.o
> [ 93%] Building C object CMakeFiles/ctracer.dir/ctracer.c.o
> [ 94%] Building C object CMakeFiles/pfunct.dir/pfunct.c.o
> [ 94%] Built target codiff
> [ 98%] Linking C executable ctracer
> [ 98%] Linking C executable pfunct
> [ 98%] Built target pfunct
> [ 98%] Built target ctracer
> [100%] Linking C executable pahole
> [100%] Built target pahole
> make: Leaving directory '/git/dwarves-1.31/build'
> Testing pahole version:
>   v1.31-tarball-g416753b4ba90
>=20
> Verbose mode enabled - showing diagnostic information:
>   Architecture: x86_64
>   CPUs: 32
>   Memory: 62.7 GB
>   Swap: 8.0 GB
>   Parallelism: unlimited (all tests run in parallel)
>     Tip: On low-memory systems, use -j to limit parallelism (e.g., -j 4 o=
r -j 1)
>   Test artifacts: /tmp/pahole-tests/
>   Compiler: gcc (GCC) 16.1.1 20260703 (Red Hat 16.1.1-4)
>   libc: ldd (GNU libc) 2.44
>   bpftool: bpftool v7.7.0
>   VMLINUX: /tmp/vmlinux
>   PERF_BIN: not set
>   PERF_SRC_DIR: not set
>=20
>   1: dwarves_emit.c: _Atomic type compile emission.                     :=
 Ok
>   2: _Atomic type display and --skip_emitting_atomic_typedefs.          :=
 Ok
>   3: Auxiliary tools: pglobal, prefcnt, dtagnames.                      :=
 Ok
>   4: Bitfield layout and data member filtering.                         :=
 Ok
>   5: dwarf_loader coverage: bitfields, templates, enums, inlines.       :=
 Ok
>   6: Bitfield typedef recoding (tag__recode_dwarf_bitfield).            :=
 Ok
>   7: BTF arena type tag encoding for kfuncs.                            :=
 Ok
>   8: BTF multi-dimensional array encoding and round-trip.               :=
 Ok
>   9: BTF bitfield encoding and loading round-trip.                      :=
 Ok
>  10: BTF VAR and DATASEC encoding for global variables.                 :=
 Ok
>  11: BTF deduplication of array types across CUs.                       :=
 Ok
>  12: Distilled base BTF generation.                                     :=
 Ok
>  13: BTF encoding options.                                              :=
 Ok
>  14: BTF encoder coverage.                                              :=
 Ok
>  15: Validation of BTF encoding of functions.                           :=
 Ok
>  16: BTF_KIND_FWD encoding and loading round-trip.                      :=
 Ok
>  17: BTF encoding with invalid symbol names.                            :=
 Ok
>  18: Split BTF encoding (vmlinux base + kernel module).                 :=
 Skip (no loaded module with debuginfod-available debuginfo found)
>  19: Check BTF type tag order.                                          :=
 Ok
>  20: BTF FLOAT and ENUM64 type encoding.                                :=
 Ok
>  21: BTF encoder verbose logging coverage.                              :=
 Ok
>  23: BTF encoding into ELF via pahole -J (btf_encoder__write_elf).      :=
 Ok
>  24: BTF true_signature: clang optimized aggregate parameters (2 structs:=
 Ok
>  25: BTF true_signature: clang optimized aggregate parameters (2 structs:=
 Ok
>  26: BTF true_signature: clang optimized with large union parameter     :=
 Ok
>  27: BTF true_signature: clang optimized parameters (scalar)            :=
 Ok
>  28: BTF true_signature: clang optimized with stack parameters (9 params:=
 Ok
>  29: BTF true_signature: clang optimized with stack parameters (non-stat:=
 Ok
>  30: Class name list from file.                                         :=
 Ok
>  31: CLI display and filtering options.                                 :=
 Ok
>  32: codiff struct comparison.                                          :=
 Ok
>  33: codiff coverage: terse, functions, verbose, multi-CU.              :=
 Ok
>  34: codiff member change coverage.                                     :=
 Ok
>  35: codiff multi-CU: __cus__find_cu_by_name coverage.                  :=
 Ok
>  36: Compilable output and type filtering.                              :=
 Ok
>  37: Type containment and pointer search.                               :=
 Ok
>  38: C++ namespace and using-declaration display.                       :=
 Ok
>  39: C++ variadic template parameter pack handling.                     :=
 Ok
>  40: Class name filtering.                                              :=
 Ok
>  41: Default BTF on a system without BTF.                               :=
 Ok
>  42: Display format options.                                            :=
 Ok
>  43: dwarf_loader.c edge cases: bitfield recode, inlining, call sites.  :=
 Ok
>  44: dwarves.c core API coverage.                                       :=
 Ok
>  45: DWZ alternate debug file type resolution.                          :=
 Ok
>  46: Atomic typedef emission.                                           :=
 Ok
>  47: Legacy atomic_ base type emission via --compile (hand-crafted DWARF:=
 Ok
>  48: dwarves_emit.c / dwarves_reorganize.c coverage.                    :=
 Ok
>  49: Enumerator search.                                                 :=
 Ok
>  50: Expand pointers option.                                            :=
 Ok
>  51: Type expansion and anonymous struct options.                       :=
 Ok
>  52: Flexible arrays accounting.                                        :=
 Ok
>  53: Validation of GCC optimized parameters in default BTF.             :=
 Ok
>  54: Validation of BTF encoding of true_signatures.                     :=
 Skip (no optimizations applied.)
>  56: Multi-file loading (cus__load_files).                              :=
 Ok
>  57: Version output.                                                    :=
 Ok
>  58: Header, range and seek_bytes prettify paths.                       :=
 Ok
>  59: pahole.c scattered option paths.                                   :=
 Ok
>  60: pdwtags DWARF tag display.                                         :=
 Ok
>  61: Check that pfunct can print btf_decl_tags read from BTF.           :=
 Ok
>  62: pfunct coverage: symtab, class, expand_types, compile.             :=
 Ok
>  63: pfunct function statistics.                                        :=
 Ok
>  64: pglobal basic: variables, functions, static exclusion.             :=
 Ok
>  65: prefcnt.c: reference counting coverage.                            :=
 Ok
>  68: Cacheline boundary display with large structs.                     :=
 Ok
>  70: Sizes and holes display.                                           :=
 Ok
>  71: Small files coverage: elf_symtab, gobuffer, dutil, pglobal.        :=
 Ok
>  72: Sort output and separator.                                         :=
 Ok
>  73: Typedef chain display.                                             :=
 Ok
>  55: Compare parallel vs merged CU loading for inter-CU type references.:=
 Ok   =20
>  66: Pretty printing of files using DWARF type information.             :=
 Ok   =20
>  67: Prototype expression parsing and prettify.                         :=
 Ok
>  69: Parallel reproducible DWARF Loading/Serial BTF encoding.           :=
 Ok   =20
>  22: BTF encoding on vmlinux.                                           :=
 Ok   =20
> Saved timing data to .test-times (73 tests)
>=20
> + '[' ']'
> + set +o xtrace
> clang version 22.1.8 (Fedora 22.1.8-20.fc45)
> Target: x86_64-redhat-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg
> System configuration file directory: /etc/clang/
> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux=
/16
> Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/16
> Candidate multilib: .;@m64
> Candidate multilib: 32;@m32
> Selected multilib: .;@m64
> mkdir: cannot create directory 'build': File exists
> -- Setting BUILD_SHARED_LIBS =3D ON
> -- Checking availability of DWARF and ELF development libraries
> -- Checking availability of DWARF and ELF development libraries - done
> -- Checking availability of argp library
> -- Assuming argp is in libc
> -- Checking availability of argp library - done
> -- Checking availability of obstack library
> -- Assuming obstack is in libc
> -- Checking availability of obstack library - done
> -- Version: v1.31-tarball-g416753b4ba90 (from HEAD file)
> -- Configuring done (0.1s)
> -- Generating done (0.0s)
> -- Build files have been written to: /git/dwarves-1.31/build
> make: Entering directory '/git/dwarves-1.31/build'
> [ 36%] Built target bpf
> [ 56%] Built target dwarves
> [ 65%] Built target dwarves_reorganize
> [ 67%] Built target dwarves_emit
> [ 67%] Built target dtagnames
> [ 70%] Built target codiff
> [ 74%] Built target pdwtags
> [ 77%] Built target pglobal
> [ 82%] Built target scncopy
> [ 86%] Built target syscse
> [ 89%] Built target prefcnt
> [ 93%] Built target ctracer
> [ 96%] Built target pfunct
> [100%] Built target pahole
> make: Leaving directory '/git/dwarves-1.31/build'
> Testing pahole version:
>   v1.31-tarball-g416753b4ba90
>=20
> Verbose mode enabled - showing diagnostic information:
>   Architecture: x86_64
>   CPUs: 32
>   Memory: 62.7 GB
>   Swap: 8.0 GB
>   Parallelism: unlimited (all tests run in parallel)
>     Tip: On low-memory systems, use -j to limit parallelism (e.g., -j 4 o=
r -j 1)
>   Test artifacts: /tmp/pahole-tests/
>   Compiler: clang version 22.1.8 (Fedora 22.1.8-20.fc45)
>   libc: ldd (GNU libc) 2.44
>   bpftool: bpftool v7.7.0
>   VMLINUX: /tmp/vmlinux
>   PERF_BIN: not set
>   PERF_SRC_DIR: not set
>=20
>   1: dwarves_emit.c: _Atomic type compile emission.                     :=
 Ok
>   2: _Atomic type display and --skip_emitting_atomic_typedefs.          :=
 Ok
>   3: Auxiliary tools: pglobal, prefcnt, dtagnames.                      :=
 Ok
>   4: Bitfield layout and data member filtering.                         :=
 Ok
>   5: dwarf_loader coverage: bitfields, templates, enums, inlines.       :=
 Ok
>   6: Bitfield typedef recoding (tag__recode_dwarf_bitfield).            :=
 Ok
>   7: BTF arena type tag encoding for kfuncs.                            :=
 Ok
>   8: BTF multi-dimensional array encoding and round-trip.               :=
 Ok
>   9: BTF bitfield encoding and loading round-trip.                      :=
 Ok
>  10: BTF VAR and DATASEC encoding for global variables.                 :=
 Ok
>  11: BTF deduplication of array types across CUs.                       :=
 Ok
>  12: Distilled base BTF generation.                                     :=
 Ok
>  13: BTF encoding options.                                              :=
 Ok
>  14: BTF encoder coverage.                                              :=
 Ok
>  15: Validation of BTF encoding of functions.                           :=
 Ok
>  16: BTF_KIND_FWD encoding and loading round-trip.                      :=
 Ok
>  17: BTF encoding with invalid symbol names.                            :=
 Ok
>  18: Split BTF encoding (vmlinux base + kernel module).                 :=
 Skip (no loaded module with debuginfod-available debuginfo found)
>  19: Check BTF type tag order.                                          :=
 Ok
>  20: BTF FLOAT and ENUM64 type encoding.                                :=
 Ok
>  21: BTF encoder verbose logging coverage.                              :=
 Ok
>  22: BTF encoding into ELF via pahole -J (btf_encoder__write_elf).      :=
 Ok
>  23: BTF true_signature: clang optimized aggregate parameters (2 structs:=
 Ok
>  24: BTF true_signature: clang optimized aggregate parameters (2 structs:=
 Ok
>  25: BTF true_signature: clang optimized with large union parameter     :=
 Ok
>  26: BTF true_signature: clang optimized parameters (scalar)            :=
 Ok
>  27: BTF true_signature: clang optimized with stack parameters (9 params:=
 Ok
>  28: BTF true_signature: clang optimized with stack parameters (non-stat:=
 Ok
>  29: Class name list from file.                                         :=
 Ok
>  30: CLI display and filtering options.                                 :=
 Ok
>  31: codiff struct comparison.                                          :=
 Ok
>  32: codiff coverage: terse, functions, verbose, multi-CU.              :=
 Ok
>  33: codiff member change coverage.                                     :=
 Ok
>  34: codiff multi-CU: __cus__find_cu_by_name coverage.                  :=
 Ok
>  35: Compilable output and type filtering.                              :=
 Ok
>  36: Type containment and pointer search.                               :=
 Ok
>  37: C++ namespace and using-declaration display.                       :=
 Ok
>  38: C++ variadic template parameter pack handling.                     :=
 Ok
>  39: Class name filtering.                                              :=
 Ok
>  40: Default BTF on a system without BTF.                               :=
 Ok
>  41: Display format options.                                            :=
 Ok
>  42: dwarf_loader.c edge cases: bitfield recode, inlining, call sites.  :=
 Ok
>  43: dwarves.c core API coverage.                                       :=
 Ok
>  44: DWZ alternate debug file type resolution.                          :=
 Ok
>  45: Atomic typedef emission.                                           :=
 Ok
>  46: Legacy atomic_ base type emission via --compile (hand-crafted DWARF:=
 Ok
>  47: dwarves_emit.c / dwarves_reorganize.c coverage.                    :=
 Ok
>  48: Enumerator search.                                                 :=
 Ok
>  49: Expand pointers option.                                            :=
 Ok
>  50: Type expansion and anonymous struct options.                       :=
 Ok
>  51: Flexible arrays accounting.                                        :=
 Ok
>  52: Validation of GCC optimized parameters in default BTF.             :=
 Ok
>  53: Validation of BTF encoding of true_signatures.                     :=
 Skip (no optimizations applied.)
>  54: Multi-file loading (cus__load_files).                              :=
 Ok
>  55: Version output.                                                    :=
 Ok
>  56: Header, range and seek_bytes prettify paths.                       :=
 Ok
>  57: pahole.c scattered option paths.                                   :=
 Ok
>  58: pdwtags DWARF tag display.                                         :=
 Ok
>  59: Check that pfunct can print btf_decl_tags read from BTF.           :=
 Ok
>  60: pfunct coverage: symtab, class, expand_types, compile.             :=
 Ok
>  61: pfunct function statistics.                                        :=
 Ok
>  62: pglobal basic: variables, functions, static exclusion.             :=
 Ok
>  63: prefcnt.c: reference counting coverage.                            :=
 Ok
>  64: Cacheline boundary display with large structs.                     :=
 Ok
>  65: Sizes and holes display.                                           :=
 Ok
>  66: Small files coverage: elf_symtab, gobuffer, dutil, pglobal.        :=
 Ok
>  67: Sort output and separator.                                         :=
 Ok
>  68: Typedef chain display.                                             :=
 Ok
>  70: Compare parallel vs merged CU loading for inter-CU type references.:=
 Ok
>  71: Pretty printing of files using DWARF type information.             :=
 Ok
>  72: Prototype expression parsing and prettify.                         :=
 Ok
>  73: Parallel reproducible DWARF Loading/Serial BTF encoding.           :=
 Ok   =20
>  69: BTF encoding on vmlinux.                                           :=
 Ok   =20
> Saved timing data to .test-times (73 tests)
>=20
> toolsbuilder@five:~$=20
>=20
>=20

