Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9361D8DEE
	for <dwarves@vger.kernel.org>; Thu, 17 Oct 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162596; cv=fail; b=Sz4tEypYVxeBoA8QHUD0zDcxkaYRIKnCGJVbF3A2rGEXha4iRjWOyVtzmQQDbA0L+pvK6YPZA2x8CG2sHEsuoxwpeSZsVVEJzsXYQtpB03jSf7oFuZxdqRpkxnWn3nD5sp+b3VR3ws6tplxoD86dDIy2/F1/2WnZXhAlm5pqZjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162596; c=relaxed/simple;
	bh=Nlc3yu2sUwznqf9oRqwkLMfYH3G7utBdL72QwHytWOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iXrXjPFb399Kb1AqdVNaUMM8vZyraJIss4V7bPZu5oFAZxyW4u30tmwAVD2R0Wc4EnQwowfibp735OFhVv5o9TDwsolcWXzShgia3wlCYF4/ea1l8y4V8yNnn58t3C9FgvVgpTkuECFwJrsXx7vpwGgGZclzLWEbOSqgLxIeaGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R5ybiAUZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dV2u3hYn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5ybiAUZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dV2u3hYn"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9Mdn1003337;
	Thu, 17 Oct 2024 10:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XI6O8sAgTLKpklvPkii8wUeWyKC6mmjD0Y/vVZE1quk=; b=
	R5ybiAUZJw1jJ6c5662luf6VSkr01cUO5pKIU/mO84lwsEqH+djNhQU1o4BXU+Lf
	b/VxEeOZVO9xiai/IrrMhdTyXTsZUFi/+X+iFWmk4XNxjNLUklPFA9epn+GjaMPk
	YrAZvpcETduWZWek5a5Xw2WVV4V/rW4VRwOatBoUhg5Dhqcp9CH/TvaPm7xZuAFt
	JJBUpEvlMRANPCZHtYmhbACQx37kHM9+5UWurTUpdpzkLoTb30u4Juj0ic1Ft9lm
	8D5xSYCjmq1x28lvYDwRBK1cZjlVAXJZ2mlKCLCip54jzlX0zTQ7Ml4d6LiAj4nL
	c5XAfIW1xEWOHNuGiuQwsQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnte2gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 10:56:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HAfuc2026220;
	Thu, 17 Oct 2024 10:56:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fja2b17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 10:56:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZNlLeMv7+BQWto2wHeq6v5ZY9OoCncxsAiRe7KIdvkR4gRMWVsEkKtXtvt1Cm/eSIP6R8ZBK2v5z0RBkOH2dHULjdraSWrVqdbZxtJnnBt12qzSC/qVS0sIBs3Trz5sc5s5STz84Zccv15xWtfSQy2b839Ss360fCtx1NtLWWNnz7Co/x1PGG5mKzKVw71iuP0cKlAkxJt1VZKWgM5wv2MwbXm2gZFygscN9G7XWRkC6/eXcre8R0/3arQ0bOtTyX6ryToOu+IF8H+ltvnnYWo7AowxVgzNnUk6f6fFXmfPh4OpdVvVm0PztLTZTjtAAt+b3fqhMG/4xfP3ibC+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI6O8sAgTLKpklvPkii8wUeWyKC6mmjD0Y/vVZE1quk=;
 b=qjGW4JS5lFQclY+V4kSgQ/3zExLDh3gkNAXCfstV96S2aoDZhrVcG7aGKISNIQ+WJ1kP4gGcGtVJS+LGPpsTxtsNmo5bsu9DVEbaDYORAGk12V+tgBf8fJQe3pmRuLDL4cknjIdomZvBEGa/UWpq8BIAXqR19iGwDDxubj73MEDCMXAjK616keFGvXW9fhjDTm8J9YpdvvvnGOipcOHcayx0AhlIST1djWsnMABuHmnor3YUycQpIlh+QPPl9Rf7SrRmbvkkypJBs8SvtBRYMfXyWOp/fI6E2su2YL6Nh4SPOSILEtwR7RDD9BphQjBCqaIFE6x7gxD/5X55hqocSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI6O8sAgTLKpklvPkii8wUeWyKC6mmjD0Y/vVZE1quk=;
 b=dV2u3hYnTNJ3tPf65m9eV4byknyCR2baOtSunElN53XLk800oTSwhJFaNaWSY0+ryVO6c/LLF27wSZlZaH9YEh2P5YEhmW4NTF8srCEI4FRcdvr0G/wkYAzPCEijtN8tkYHA9qVgEIrkx3AOpKbO0ZKFxTs6jMWgr/unYB0VmXI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7134.namprd10.prod.outlook.com (2603:10b6:208:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 10:56:10 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8069.020; Thu, 17 Oct 2024
 10:56:10 +0000
Message-ID: <05bd8cbb-9e6d-479a-abf6-51e7eb5e67f7@oracle.com>
Date: Thu, 17 Oct 2024 11:56:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 3/5] btf_encoder: collect elf_functions in
 btf_encoder__pre_load_module
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, andrii@kernel.org, eddyz87@gmail.com
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
 <20241016001025.857970-4-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241016001025.857970-4-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0551.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::19) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: f383f4f6-2214-4f36-f197-08dcee9a4e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckNDM3VRdFkyV3FkbWRhMTVGK0M1Wk5Td29PSDNqbFlaTVkvSCsxYUlEK3J2?=
 =?utf-8?B?a091VDE5bjlhbU16Si9acFlBM3lJSXl0a0FaMnVwcXJhc3FxeWZlL1hjNGVk?=
 =?utf-8?B?YnhEK0Z0SWczN0dmeUExYzlKYnVNS3pDdG9tZDl3bGdOY2ppeFg0ZkpmMHMv?=
 =?utf-8?B?d2c4cUJnYXRWZnc2K1BHVG9rdzJvOElPbjZtblZ1d0lEbm5yQ25Fekl5S1lZ?=
 =?utf-8?B?RlFZbWhnTG96aCtjQk1qWE5uU3psdzRXTDI5cjNsMkZGZkNSa3NIUWdpUGRK?=
 =?utf-8?B?WEVqWHZlMTl2MzB3RkNGZUovYnczQ2pyOE9XZDRHYlVSNmhlaHNOZ1dDZGRF?=
 =?utf-8?B?SDZEZFlZOEltK1NmUWxHeFpyTmcvVC9WT2I0L2dNeHJJMUpLUUhESW5xdnpn?=
 =?utf-8?B?NWwzcEcyM2g0UW9MY3lpTVN2eDQ3Z1E0dEFPTGlOTHlNL0w1VlR3dUtkWHkz?=
 =?utf-8?B?LzIzeXczampJNjVKZ1MyWmZrb1h4VUlPTGIzdWczNE1zbTU4VHB6ait3bXJY?=
 =?utf-8?B?YXFkREFPaEtRaUd6MXgzYUxOMTFLSXFlVzhHRStEdFpIdnlrc25uMkR2MDk5?=
 =?utf-8?B?L0RGVkMvWE1DZXQzV0NaenI0VEY0Z2ozOWdNTkJCT1I3c3YvWjVOVERWTEF2?=
 =?utf-8?B?aGNQU0gvRUpwYmhqNHpSL2UzRGpxclZrTm8yeXMzYTRlMW9Qalk1NlZXcGR5?=
 =?utf-8?B?WXVuVHdnOTd2K2NpZjQ2ak1WMHZJTnY3TGpkZi9vcmdwMTFxc0U0QzNaYzBs?=
 =?utf-8?B?MjFLMTFWUWQ0anhCc3BwTms4Y2hSRWtDSDlGczBmMWE4YmVEY3liRXJ2WTlt?=
 =?utf-8?B?Z1pFR0JjUWVqZG9BMVlONit1T0hqKzJkaDJDZ2N0MWd3bFNId2hGVlNGWTV5?=
 =?utf-8?B?VmlPV0VrOEljMHc1ZkVweVV2TjdBRGpRZUJPQlFEandsNy9kZ3FtNCtlcmpT?=
 =?utf-8?B?dEFBK2JMTS9LZjgyNmNRMGNrdFdxa0JBM0VHQ3hjck9mSXYrdytjdWx0VFZ1?=
 =?utf-8?B?VkwwK1JmRnE4R0tsK2tZRmtMczBSNUdPZXpoYVZTMDlmZEtyWVovaCsxZGVT?=
 =?utf-8?B?SXBtbGdyenI0NEtEaGs2elRzbmMyMGZBWUxLN3IrckZFU1dvYU9PaGl3Rjl1?=
 =?utf-8?B?Rm4rQS9oeitXTWtNTVFsU1d6VkczL2tTSG9zdTBudVd0VU5Wdmp5TnI3OXl5?=
 =?utf-8?B?N1htdkoyc0pnbGV1YnRiZFJxRkJRWGdzcEFxMWdncVBSeGRzMzhYNWdqZWVY?=
 =?utf-8?B?Um5JaFlFdVIyTnIwWFlWSTNZaHRKampFbDFyTlQwWjhaQi9uanZ6VVk0T1Vy?=
 =?utf-8?B?SU82NXV6QURaMUdLTWsyem01dlczTXQ1MTFMS3MwRGdJd3oyVDExbHNUMmto?=
 =?utf-8?B?dzd4MVRQdGpEaGdqV0ZxQmttMjgwVStHRDl4YlJvcnp0dUcrczE0WlNrRmtO?=
 =?utf-8?B?MEpuMkluenovNWlpU21Yc05kOUpoS2VWNXJMM010QjV4VDY5ZVl3Z2JFM3JT?=
 =?utf-8?B?SU5rTVNrMThFczZQSVVmL2t1Vk9sczZRNytNTGhLdUhqMXJ4b1FDeHJxQnJF?=
 =?utf-8?B?YU5BOStJUzAzY2VpY2x2ZXJPVU9TcnNraXFMdTBKTzdyckZBSW9QWE5xd1ow?=
 =?utf-8?B?OGp2OE5DckhxVDhzTHJsVFF4VFQrMzVFb01tbk83UlZYRGtKc3lVYUZoUk9y?=
 =?utf-8?B?UHhUUUc5cVAzcVVOMG9XWEh0N3k2eHJodS9mbnBqUTJIb2xlRlozOWU3eWc4?=
 =?utf-8?Q?V4sU7a9+j3QzmTqK6TZtsVs7QDz07jIvqffqvkc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjd0MXpxVmY2ZDZCV3VuSjZ2dHRYK1l3TE1JV3FTTkpyTVRIR0c1TXBSWXlx?=
 =?utf-8?B?OEpER3o3d09Oa08zSW0vNUNRa1drbW5xeUczRDE0bUZEeWVjd1JkcjBBbXVM?=
 =?utf-8?B?bkp0NUZ1NStablNOSHlRelJIczREdkxYcGdaM2c4akp3UmpxQVF6SmhSUWNx?=
 =?utf-8?B?NVpKNkhNdExYRDlkR3BtajJuM1FFZlhMVERCNUxuUGR3YllHcWFSbUlWTFNq?=
 =?utf-8?B?VGkvZnR5RURLRWVyb0JhYTkwZ25NVHR4cWVwTXlYVGtzalVKSHN4WkN1M1BM?=
 =?utf-8?B?VVBsQ2IxWDFxcUZlcU5xMXgyNEN5SWpjZTVvL1RsVmJ2YTRidWNoRk1HdVpX?=
 =?utf-8?B?M2o5VC9iaGh5WHlRenRlVjJkcXlwNnZBQjJmb0FmN3lYRnY0a2RkSU1ocHdv?=
 =?utf-8?B?cW9qOXZTT3NHOUJzYVNLeW9JdXNrb2ViNGhUOWE4QmxZV3V6VmtWWC8rUTJr?=
 =?utf-8?B?TnkzZ2lwOXM2Q3JVcGcwNkxSb0lJNFJiQnhPc2dBeGVKK1JBcms4S1NLNFY3?=
 =?utf-8?B?bFZtVHhVdHB4c29zL25zWDFhRVZJWnFDTUhrN1kwQyttOUVNVjc3V2lQcE41?=
 =?utf-8?B?VHJyV3FFWEJNaTBVd3FQNWhZSS9UekwyUWRDSEN2cFVXUWRBYVNTOGhna2V3?=
 =?utf-8?B?OVFMdVdnbU1QSHY5czNrSklmYisyNmpIQmh2RmZSQzViMWNMZjhScTR0RDAv?=
 =?utf-8?B?aEZMYmJ2K0poR2FaK3AzWFdxcVZVRUtKUEFUcU5QaEtHVXdtb3ZXYk5CN29s?=
 =?utf-8?B?NHIwV0FIc0N4c1NrY1BDQXIvQVJ5aFlWSE0xNDlwb1V0MDRPbEd5ZnpvQVli?=
 =?utf-8?B?Y1lXMDVuTnFNUEYxS3FXd3d3UkRXc1dwc0lVcnB4eWZNR2RNMCt2TlI5UHNv?=
 =?utf-8?B?di9EbHlOa2s1K3BHaUtFbWIycmtDZnpRbHhJZ0c0UXBmdjc3VWlpTlp6aW94?=
 =?utf-8?B?dmNZZDFjZUVIeVE4Wmo3aFV5NFI0aU02cXI0bWRxeHo3R3JRT2JtUXlMNUt5?=
 =?utf-8?B?RGd5Q3ZyeTREd1VIVlVOY0hjN1R0SkxRbkxValY4MW9nODhEbHRidXNJdkNz?=
 =?utf-8?B?cDBVVVRLMzRMaHlRRHRrZWtHUXNoUFVpMk90bDJxUlB2azJ4eGdpL0t6VGk1?=
 =?utf-8?B?ejRyZTB3UjQxbk9VRnR2bEdIc0pYV3Y1aGNEVEJHUG1BTVNSTS91RS9nVjdy?=
 =?utf-8?B?U3NBTUR2bVRhaXFrcDM4RHJ0MDByNjdwT3Y5T1JSbUtwTmlCaldqTkgvZElG?=
 =?utf-8?B?bVA5UVJYUEVZR2JpNEdOK2o1dUR4clpIT2kvMDZZYlBYZUtMcVMwUzFrbEJT?=
 =?utf-8?B?dnlWWkoxQlZUR3IxSHJiZ2diMmYxbWxlUVBGZWM3a0V6eklMQVR3SXVHaUMw?=
 =?utf-8?B?VmZyWmVRcHdUUk5UNnkwZHM2a2hKNHB2OUtKVFlFKytwNXh1aERuejVkUDd4?=
 =?utf-8?B?eGpxMGlNR29ITHdIVzBPQk9kZzBXb3RnU0xlSjk4V01DRmxXdTc2eXBPOGdl?=
 =?utf-8?B?UFVyeU5XMmpHUDNjUjB5K1M0QUNiRHkwWWpBSVpxZGNzQzJNOStWSkN5bmU1?=
 =?utf-8?B?UzBDYlZBbFZCQWdoQkcvMy8vY3BhNnZDSk5ZRHFBcTR4RXV6aXBOcGxZK3M0?=
 =?utf-8?B?WUVnVWNBNE1rRER4VUZyRTNLc2RaMS9XQkZaa0YvdVNYOWtvSkpBWGJGVmFY?=
 =?utf-8?B?ZTdLMFdGT2hFc25VTitaTTNYcGtBTE0zaVZ2Y2RSZk9keDkvTzhTVWpUS1hp?=
 =?utf-8?B?RXNua2xGNUl2RmVzL2hNR1ErT0hwdkNWbjkwZXhHWmZJUS9IU3dPNkFUbVMz?=
 =?utf-8?B?MVpPRExxUXBZT3ArazBIajFEMXB0WmlteWxBczhkWjdLeVAvcTM1YkRNTDNH?=
 =?utf-8?B?ZkIzWWJheHNQY2x0VHNnamdPaVZKa01ndnJ6UWFueDNxUDhCdDhGbEdKblMy?=
 =?utf-8?B?Z1JwTVlsQnp6VkRoUFhNbmwwU1ByUHUvc3RVNU1NV0FWMlBNUTJxQllJWTZr?=
 =?utf-8?B?eXNsWXRRM3JzSEdMSHE2R2NoeDhQZDhWUnlpbVZaRWdka1NGT29rZk5TZXJP?=
 =?utf-8?B?RUU5ODJvbWFoSVQvQWlpakM3bXcxcWxnZlVyWkdUcjFhMlZITjd1QmFQWFhK?=
 =?utf-8?B?SzZic2VDL3FNT1VUSFAzWTFiM0NzU05sQkVKaE5qWFB0VFFNVXZNYk0rZ3VW?=
 =?utf-8?Q?2unEf6U83xyUlcXGGw+/uLY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bkVpUhuTro5qQruBG0v/DYzJnYVAgzcbCCaCxdKvE381s9Hh/BOvv/5Buumx35STqq+4imsJmAx0M+VgOiSoNpOgC5g3MCS/1hjcBevF7Q9mAh1aKzuZbJJVBPr39nmQdkaGnOZG94yZt5w5eIfwpC+gBjg+p2Zgq5zUfG3vs7+dKKN9+Kfo+UBSXW3pULP8PYmMZ3XN4bXFDOAj2I1vkMcwgS2anqSewVzIIw5V3ht2gDqtWhmg7YqQq4RIRERiGUwZ3nn7OXrw7t1WC35pi0z0QfrpJpH9m4CvNWVCEW4+evofsYjrQAssqkouslrFgO0J8zQXUcEqEgKaDL7D031XJNevWM3vbHrqcMz26EOPqNIGwdDnJX+RvIgbpF2WeKlfizA0vPiHe1t8HqXJjR4zzSeh8zazxJvOlH1rPGOekK4kpwiurp00AzyTdOemPn68Iit71Wbda+xgyglz80MXv2yPFmYLclTvoR6GykCOdK3FZhZN/F/vnxwVqSS/99z3rUIl9VW8mDrDa95N9lbNMahXz+koeLPEP7CdJrMB8F1wBqyT0COPDb5yfpRvgBfHp1GNczkAeX+6Kc6fEDD3Agr576nPqofYtun8YsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f383f4f6-2214-4f36-f197-08dcee9a4e95
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 10:56:09.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WGu0Kt9UD9T4q4eNHo3bYgmwyK2btOpxYGIM3drRvsrsoyt89kb6M/Zjz+Hu5o84Jbtpgf/LqKmFh0gdkU9ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170074
X-Proofpoint-ORIG-GUID: NiOTE41-A3rgY2dkyqel6SO-QCC2p71t
X-Proofpoint-GUID: NiOTE41-A3rgY2dkyqel6SO-QCC2p71t

On 16/10/2024 01:10, Ihor Solodrai wrote:
> Introduce a global elf_functions_list variable in btf_encoder.c that
> contains an elf_functions per ELF.
>

Arnaldo can help provide context here, but at least notionally I think
the idea of maintaining libdwarves as a library has value. In that
context, avoiding global lists where possible is a good thing I think,
since if it was used as a library, multiple invokations could confuse
the elf_functions list. To that end, can we make the elf_functions_list
a field in the conf_load perhaps? It already contains base_btf so there
is a precedent for storing data relevant to all encoders there, and
btf_encoder__new() has conf_load as a parameter, so the elf functions
list can still always be retrieved on encoder creation. In addition the
parameter to cus__process_dwflmod() has the parms structure which
contains the conf_load; you'd just need to pass that through to your
pre_load_module() callback I think.

It shouldn't be a massive change but I think it would be worthwhile.

Thanks!

> An elf_functions structure is allocated and filled out by
> btf_encoder__pre_load_module() hook, and the list is cleared after
> btf_encoder__encode() is done.
> 
> At this point btf_encoders don't use shared elf_functions yet (each
> maintains their own copy as before), but it is built before encoders
> are initialized.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  btf_encoder.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  btf_encoder.h |  2 ++
>  pahole.c      |  3 +++
>  3 files changed, 71 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 9c840fa..8e8fd05 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -103,6 +103,8 @@ struct elf_secinfo {
>  };
>  
>  struct elf_functions {
> +	struct list_head node; /* for elf_functions_list */
> +	Elf *elf; /* source ELF */
>  	struct elf_symtab *symtab;
>  	struct elf_function *entries;
>  	int cnt;
> @@ -147,6 +149,67 @@ struct btf_kfunc_set_range {
>  	uint64_t end;
>  };
>  
> +
> +/* In principle, multiple ELFs can be processed in one pahole run,
> + * so we have to store elf_functions table per ELF.
> + * An element is added to the list on btf_encoder__pre_load_module,
> + * and removed after btf_encoder__encode is done.
> + */
> +static LIST_HEAD(elf_functions_list);
> +
> +static inline void elf_functions__delete(struct elf_functions *funcs)
> +{
> +	free(funcs->entries);
> +	elf_symtab__delete(funcs->symtab);
> +	list_del(&funcs->node);
> +	free(funcs);
> +}
> +
> +static inline void elf_functions__delete_all(void)
> +{
> +	struct list_head *pos, *tmp;
> +
> +	list_for_each_safe(pos, tmp, &elf_functions_list) {
> +		struct elf_functions *funcs = list_entry(pos, struct elf_functions, node);
> +
> +		elf_functions__delete(funcs);
> +	}
> +}
> +
> +static int elf_functions__collect(struct elf_functions *functions);
> +
> +int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf)
> +{
> +	struct elf_functions *funcs;
> +	int err;
> +
> +	funcs = calloc(1, sizeof(*funcs));
> +	if (!funcs) {
> +		err = -ENOMEM;
> +		goto out_delete;
> +	}
> +
> +	funcs->symtab = elf_symtab__new(NULL, elf);
> +	if (!funcs->symtab) {
> +		err = -1;
> +		goto out_delete;
> +	}
> +
> +	funcs->elf = elf;
> +	err = elf_functions__collect(funcs);
> +	if (err)
> +		goto out_delete;
> +
> +	list_add_tail(&funcs->node, &elf_functions_list);
> +
> +	return 0;
> +
> +out_delete:
> +	elf_functions__delete(funcs);
> +	return err;
> +}
> +
> +
>  static LIST_HEAD(encoders);
>  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
>  
> @@ -2071,6 +2134,8 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  #endif
>  		err = btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
>  	}
> +
> +	elf_functions__delete_all();
>  	return err;
>  }
>  
> @@ -2387,6 +2452,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			goto out;
>  		}
>  		encoder->functions.symtab = encoder->symtab;
> +		encoder->functions.elf = cu->elf;
>  
>  		/* index the ELF sections for later lookup */
>  
> diff --git a/btf_encoder.h b/btf_encoder.h
> index 824963b..7debd67 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -34,4 +34,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder);
>  
>  int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other);
>  
> +int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf);
> +
>  #endif /* _BTF_ENCODER_H_ */
> diff --git a/pahole.c b/pahole.c
> index b9e97ef..891af3a 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3814,6 +3814,9 @@ int main(int argc, char *argv[])
>  		conf_load.threads_collect = pahole_threads_collect;
>  	}
>  
> +	if (btf_encode)
> +		conf_load.pre_load_module = btf_encoder__pre_load_module;
> +
>  	// Make 'pahole --header type < file' a shorter form of 'pahole -C type --count 1 < file'
>  	if (conf.header_type && !class_name && prettify_input) {
>  		conf.count = 1;

