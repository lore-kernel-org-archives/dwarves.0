Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFA183CB7;
	Thu,  1 Aug 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504019; cv=fail; b=OWoTQkUZAjamYB4wOLP67q/Wj/Dz0nf/U4Mrf+an0Igkdaz82bAZP44W+ePu0x+AkY4QWaZw11J1uvVqcO+3DLZ0Vx/wF4+hUMM/7yZeK4PxlXgGtqP3d3gj8l3f03SiQlUGy6+02Q8lwj8I+YjEVNfUjOl2TwL13mwrIweXYnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504019; c=relaxed/simple;
	bh=9LITEzjVZ6Fn7HwWhIn5y4iZTa7F0dETxjd0oRoz/X0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+rMHfNiK2/74Ci5DMl9IHVQbFvxcqG9D4RUuPyoRXGhQ2orv1hl7Z7ZP1XgDRkjQ3NriQO3Go7T1UWOttMuH1BZRONYNXD+bSQ8y6BvVNqTyBgM6uI7cdS1V+2R4ToVBJTql/8ZOimcD4/1ZoGFQmBKU4DWQfM/EtjGDnt7rbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=latKkjFU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FI9/7BsD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="latKkjFU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FI9/7BsD"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717tWdq026222;
	Thu, 1 Aug 2024 09:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=QFm/OfMSZn7h026LbokYr4es2kmFWL7HfUz5vFdUkew=; b=
	latKkjFUShmfv2dz7H8JIzglVoCtNCh4WeaDJUtpyv5J9YxoUYJTxHA6Is3+35oi
	vPwM7kFh5l1jKHuZziXKP0Uc1hHdLM/YV31tl3R6NtHPSdUmkk8ZdfehxEQK0l5K
	ApQbdvFi+RT5qMwoFA7UvXaoW9SizVptwGmYtOYgxiXFdXLKAg0KwgQafpFT2k8D
	lf/fgH7tF9g9EDnpI7nBW0boCecXz8tt/pdWcEGFedLtJI+sgo49xzNVGdKNg4Kf
	BL8XsZz3DHjikG+IOLpvzXtmG2DKzAplMqFJbJElqRIpygiIOJKzksWZnjHTxbeQ
	yjRtwC6PDFPRxeeYdoWZDw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyhags-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 09:20:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47183xt3036233;
	Thu, 1 Aug 2024 09:20:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvnywwfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 09:20:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9oWaRT2+ZaN1F6yI55weAKN1kYGc4CiZfwpfjZfCNpCM1Wy3uKJugOqLogwuZX/XKHoHbJzrACzD4nTV+bMbgiRkPxQPN91F6BflIzg5z9rgPuaobVqFQSCgRas+NTXuuHLjGZhnb8APNaoQsCT5JXWpjXBXGUSJasQLrOxHidioWEMQPIzbhP9XegEv0JsXrZsqV+KYFCCMgQDoQTd8PILifUMJ4CjIM3M0AtFZ/lD75kib1zE40bw0SuXuyCAhvo2tLlIInL8IPdVMYDwSoBuJ0572e1Vmz1G38KsE7LFv905XRMr6Y8C+jE+bPZKTHlIkYjXG+PrBYuWZ4880g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFm/OfMSZn7h026LbokYr4es2kmFWL7HfUz5vFdUkew=;
 b=wpX9r5Tw9qK+NEHiIVNGxfPeyN01MRJzp9+F3bnfYKpR8wxgCWK6pbSFfRqfsZPySRx2WiI4CQ67NpadXPynrj5nNwZxJwkGZOVP/ChX5GmQkSGUb65ih6MgoNE9mybdxD1nX3Wq6NdhiCOpjQmR/94ZfmxaqNuIeQyKMP1ZfrFxsAn7qL4qCqMZaExadaikXYIOL6VxTl0UerKAzmAcGtabb4EARMtNUyqCF6NPZfGzJVzEZVDGuKwsgFNCs056cdxNHl1EYbIQK9eNEq+GSZvl1/EiMv0oXzxH7srI6yVRyMs8M2v2TLjZF+BSx91Jp1uUUWWAd9n5/G4WhMSXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFm/OfMSZn7h026LbokYr4es2kmFWL7HfUz5vFdUkew=;
 b=FI9/7BsDlEmV813RH/sCY5kshmGJzI2iDqQew1ZD2evQ6gM0klV5ezrzCezrKsU72UnJEVxKpFo8mmz2QTjYFlkEWnRDckzXURdCHZ+I9rtH5jOA+Ln+LlqUueE87slGJkaKbrAvKobtuD6z1innfyE4fHsnYrrlWoV3hVj7xBY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV8PR10MB7869.namprd10.prod.outlook.com (2603:10b6:408:1e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 09:20:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 09:20:06 +0000
Message-ID: <db2a5178-2df3-4caf-955b-525cdbae7002@oracle.com>
Date: Thu, 1 Aug 2024 10:20:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pahole: Apply CU-level filters early in loading
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org,
        dwarves@vger.kernel.org, aliceryhl@google.com
References: <20240730224350.4039790-1-mmaurer@google.com>
 <0c0031f6-7f5b-4ec2-9804-c9d576c8302b@oracle.com> <Zqo7mW3brA09hA8b@x1>
 <d4152b9d-2bc4-4458-a1a2-71ebb5932d9c@oracle.com> <Zqp-cqZcOOCzQMEg@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zqp-cqZcOOCzQMEg@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV8PR10MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b9c95e-a778-42c4-0854-08dcb20b21e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjlZcmN1UFdFdjRqUkYrVlBKUUI3ZlhnK1RNNDd0V0hFLzhlMUNYOUZ2V1Nm?=
 =?utf-8?B?MVBKU0hJRTlJMXNxTlgxdlU2STB1LzdQalMxRW5iY0RjaW53WG9jcXZ6UmhT?=
 =?utf-8?B?ZzkrOWNySVlxK2ZFaDhvL3VFRmoyVGVYK1hhMUN2dUVBWXJLSm1lZ2RYVzBs?=
 =?utf-8?B?RlVCMXM1SS81TEFWQmRGcWZiOHRKaUtQSEVHSHpDSFFGbk1NWk1zaktyZFhO?=
 =?utf-8?B?R0dHNmhTSUt1R0I5Sk9sY1oyQS9zb1JyY3hETjdxemF1VVBWOW8zN1lva21K?=
 =?utf-8?B?Q3B1L3lnTzVBSHMwQ2hrc2QxWEFja0RoNitDK1A1YVNUMEtSRTV5VU9PdjFh?=
 =?utf-8?B?WHErSnRKVC9TTHMxdFlWYW5LOGx5TzVKNTA0eWI5b1JRYUpQdTA4N0MwaElx?=
 =?utf-8?B?ODVJL2IvUTIwRjFUZWpjK1JDcFZ3N0xUeDFmYVBnbEE2aE5md3lWUWE2Wkto?=
 =?utf-8?B?alJTMWtVZm1zSVVIWmhJckpNN3lMZGNSaTNXRk9vbnlWekJ3c2FoKy9XRnp5?=
 =?utf-8?B?V2w3OVEvV1ZsazI0Njl6c0M2MlFYeEU1OXIyY3pvd01JeHM5bDBuMkwxcGs1?=
 =?utf-8?B?OTlUandnaHVzakVBejVNQ2psWGMrNUFtTktRNHY0S3JBeDIzaHlqT1F1blZ0?=
 =?utf-8?B?UWxSbzMvZUFKbGIzYTVFZk9iY0xQVkgydUhLazhta2tmM1BibFV6Uk9la3cx?=
 =?utf-8?B?QmJYRHBVN0JVZTNzcWhZa2tXK2VPQmV6bTFZcWI5dVNCSUV0KzhJSTBKYmF2?=
 =?utf-8?B?YlVMbnFsck9WM0Uxd0RjeXgvWUpYR0FaOVJxdmo0b1BIWVNlamw3YUo4NUh0?=
 =?utf-8?B?MXJ0YlVtUUs5bDJGT2RkSU96T1krWmpEQjhsZWJvdkl2UVlucjVSOWpTL2ty?=
 =?utf-8?B?Y1NPR0tmb0NudmM1OUJHVFJVWmRCcVJ1b1VBZDQ3V3Axc3V4MnFwNmhkVzZK?=
 =?utf-8?B?QUQ2UjJhNU1FajZwSzdaUUhRU1VzQ0RaY08vSUxtckdqQmxWTzhPdkJGTDJn?=
 =?utf-8?B?d2ZIdHFiTWpvcnNiN3pOYlMxU0ZLR0psSmpvTGkvWGtuUUo5ZjZuMkh3bGRB?=
 =?utf-8?B?Y2pDN2syc3Z2S3RkVlJiZUwxeHJHNEFtY0h2OGZBalBzVVB2bTVtdm9ucERH?=
 =?utf-8?B?ZjZzKzhtejA4SzBIZEhraWJOME9WNEswVm1uQ0JnK2VCU3VFZGhqdFBvSlly?=
 =?utf-8?B?Z2ROQ1NvQjhoMmVCVUMveGlzQ3Jkdlc1Z09CazZHd20zTmVucUpvcmNGNlFR?=
 =?utf-8?B?WERnb0dYV1pSZVpvMm1IdGNrQk9nSXBaM1RTdUhkeGxiZFpnQUJ4Ukg3ZERP?=
 =?utf-8?B?eTRMeEVxc0JwOEJuSndSSEV3WlVaQW5tQnVnTlNLN3pEZkxwOUxrRCtORmpz?=
 =?utf-8?B?MHlOLytKVHN1T3d3Z0FaL0RaMGFsem5JTXNybTlYaHpRWHA5cUhRRlgvazI4?=
 =?utf-8?B?ZUFzWU9BVjlvNVdUeFBEWnhZRTlLYmFVa3lLY1lmUlp6UXZTUE9qN2tMaUpP?=
 =?utf-8?B?WlBpNFRMaXZKMmVUL1N4bi9IdWhSY0xsMU5ZalEwRHFYVGRzUWNJZHQ1ZGRp?=
 =?utf-8?B?ZFY3QVp4Rm1UdnV1WkpiS3U4NnpibFN3bGxiSko1VWVQWnpTbDhOWVFrd0Rz?=
 =?utf-8?B?MVowTTljQy9KMjg5Wkp3aHIzZEZydkZXajFvV24zZ0VZTTVVckowMG9zZDRj?=
 =?utf-8?B?K0JzQjBZL2lRaTJCUGxVb2JkTFg0TjhjcHFrUHdhL1ZIV1NuaUg0OCtpRXBL?=
 =?utf-8?B?bklWRkZpajI1aGdRc2wrc20yQmpSYlJFQWFSZlFTT3Nvbm5VdVpYYm1lcFRn?=
 =?utf-8?B?dFhEdVBTNENmZHZFVW5zUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDNhYytvYktGSXB0cklUSW9ZU25zY3U4WCtCdGprWjNTZUgwZlc0RkhmbkRq?=
 =?utf-8?B?Y1hrb1A4MDdQUGtyOHdxSmQzMlhxY0NhajVqYm9ZcVE0TlE2RXUwTU9hNndC?=
 =?utf-8?B?QXpiT1ZGNFdJbnd1RFdtZ2lyYzl6b2tvQkRmcElJWGhDTXhUcWhKbGF4WlF1?=
 =?utf-8?B?ZEpVbjkvQ01aemxTNFNxcVVIMmN1ZE54bXRoUlRHQ0UrMW5WbGFTb2REQXRz?=
 =?utf-8?B?N3ZjY1pCaVJkSlpVeW9RREw2UmpEeStwd2dHOFdKUVdCUlNuOXhrdUYwZEwx?=
 =?utf-8?B?dVBQMnVoZ3ZTeU4zeE9NaFh0RlNvZTF4TTYwbmR5M1JFUFpZdDJWUXNkVTBV?=
 =?utf-8?B?SUpqL1ptS3ZlNUJWYjZDRXUxaUtNcDNETVhWZDlZTzdCSjFnanZja1FhV0lN?=
 =?utf-8?B?dlU2bHlKajlCRFNtL1B0QTJHT1V3Sjh5dGVNRDJvSk5tQnc4c0VrTVF1ajBL?=
 =?utf-8?B?WlphaTVBUGNQVTV1N3FWSGRuZzVoU2IvemcvdVVKc3J5UUJnbTRFK2x3U0FD?=
 =?utf-8?B?c2VxdVo2Z3lQRWNzWFNqSzkrQ1pGMEJoVE1PY0Frei9GeCtRNkFRVHRsaDc1?=
 =?utf-8?B?dis1K2QzQ1lUMG9DSlgwVTQ0OHVoaG9pN1NBemY0N21HUE1zK0p3MFNFV05I?=
 =?utf-8?B?S3lVb2FkdTJNelhRRWhXWm1VMzF2S1BXWHBUNkU4T1VoTVRHNFMvY0RZVTYr?=
 =?utf-8?B?VzY5bWpndXJOeXJpcHA3OWxLVjJ1U0RyelN6V2MyYlNyMElzVzdKSmt0Q1pH?=
 =?utf-8?B?enpWY0xHc3BiMXo4MGhQQTlGK3YzbldJYVM4MDNySXltb2hIM00xYzdwZ0Zv?=
 =?utf-8?B?M0UyejlodlkrS2t2MG9rZ1JnY3Q0YlVBTFRTTFcxNGhJdzBadi84VXdrdmU2?=
 =?utf-8?B?a2lmclFsUTZrSU5QdVVMSDk0clFMRWRiMUhWZThPK2I2NWVMMzZjd2pINk1s?=
 =?utf-8?B?eU1pMUx2U1BQNHZiMnhXYjZUc2NZSVpacEg0T3RndGdkNk5ZUkcxWUR1c0oz?=
 =?utf-8?B?TCsrRGgxUHVLbDRWcHNZWDFxVHBkOG5yM2Y2b3F2eERNMTRHY1VqNmgvdXBH?=
 =?utf-8?B?NkFodHB4Z001M3l4NDZ4dk9LZlJHTHV4dDFYTjBiTjdKSDd3bzE1ZmdqN1Mx?=
 =?utf-8?B?VEt6bDBRcGZxUUdUVGNsVStCVys4U2RlRkFGbzdYNHZIL29jbWp2cUZ3cTNZ?=
 =?utf-8?B?eEtBWmhsaVJrcmdFKzhLN2J6VlFZN2cxNytyM1VhTzZOekI2bXE5djdTUGkv?=
 =?utf-8?B?T09zeVN5elhZdkpxYWRwbHFKK1l4UGhGK2hsMGpCSllBdkU5dFVpTzdWTnlw?=
 =?utf-8?B?bTdBYmpORVB6ZjFpQzF3M29Pa2RJYklqWGd3KzZkbkIzaGVYaVVuNi9IRTJr?=
 =?utf-8?B?T3VhM2VaVTR2bnJsTW80MzdxNERXSmJhQ0pxTEh6M1pnNzNXQXdiZWh3TGhF?=
 =?utf-8?B?NmFiSk5rZnBGblNoVHVoSzRZVVpRZzd0cDJ4TVJ1NFlsRURTbGdMMWdhN0Qw?=
 =?utf-8?B?SXJETElMMUNITUpMMEVzNVhGYkxMM0FyVzhWWmJUY3FnSXBOOVluKzFDbTdv?=
 =?utf-8?B?cGkvUVJudERSNm5aVVJwZ1doWlRGTEp5dXNTY0x4WnVEZ0FWWkdhL0dYVU55?=
 =?utf-8?B?VE5Tb1NZY1JwWjllbGZWbnhEaDVpRUNmOFh6VFRQOVcrMzJmQUNFdVZGKzM4?=
 =?utf-8?B?OWduZ0VsSFdlY2JUbk5LdlgzMTFtQUZOV1c5TC9VQzZ6Z2toSzFLR3pZQ085?=
 =?utf-8?B?aGhXUnF1QnpGNTNjRko4NDBFckkrSWEyODFSSnc3d0g1TkZPL2gxR25WSUc3?=
 =?utf-8?B?N3l2TzFKR0YvU213Z2NiVThYbDJzWXFOU3hZUnBkVmZRZFdvWXMxY3d4TURw?=
 =?utf-8?B?VjhyTkFQd0ZqNWtzSlFVWFdnTmNzb0IyYWVOaTBpeVNtNndncmpWRC9TeXV5?=
 =?utf-8?B?VFlyTWNiU2xQcVNtcVBSaWhQWlczU0xoRFN6UjM3N1BUUmgzWURWa0FZQU94?=
 =?utf-8?B?RGczUW1PUm1QMlNDbWphZXM5RTBRRFVHaHQwR2xwcHMxMmxqcWdjc2ZnbjFB?=
 =?utf-8?B?V3RyWDRwTS8zTktkWmRDcmRPMzRGV1pPUEx5UFd3VEdZajliTmVFRVFJWUZr?=
 =?utf-8?B?ZlZiMVJiUDU2dnVsNlJBUThVR0h3MnkzRWZLdW9Va0I0MGVCM0FPckJTS3p1?=
 =?utf-8?Q?5Scmjn14A35EkzEH25FvL6s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vR09UXThzrwHWYCOn8I5imk8Ej1k+kZ0q73hiVtZg7r0RNrLunSsyU2qITmz3tsqNsPuMKLG8Jm7Dz7RF5TDe7I8ok+fAWJG4vW9phIfsUVMaDiCMfw8zgJTaAf1w56b3MaUkukVE07pcD4SQj60JPYMqlgN3qx9BVPXFKbhXtTO7kocKx/w8NWdHZLokSSReHvUI5cN8DleI7QMLxIHj6lYggM6T+jQ0bl0cSyVIG0JHUPtmpl05Ajci7idZDlQOwfM/UIZAi+idfIFeUriHBhPD/WDUP/0uBUUJb58aevg1Wi2/GCy5Qd71uLlTB0Z71z1zU+Xs8xUa5YcC61Wr3aKjjoSetu0IRs4BqqPgM4bMaFzG18UiLXS7P+HBf/61TDcvz0G5F+1LKowILCTFEe/n5vJs53yBfdudg4ZLx0ennNHWnllT9rL/XVwA21uvIzz7q6EObsRMmXKjsb3uO01FKiVlBJ96EvPyUnb0+nEJblSTyNadJL9I0fYx4MNaFWxg3fl2ndrMhHeCCmJt2sZz/fEw4A/KzbQO9cKupX3lsEB5ka3piPI4W8gn9/GZjhyAqGwGlm/Tu3GAJBJYng8EX+oeCzkBgxzpRIOaCs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b9c95e-a778-42c4-0854-08dcb20b21e3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:20:06.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5Ny/sWY6QcswNwWEO5jIWI0R52K+TQBR0EmqzPAECSJt+eZbZJb263mDpCJr8Y5rycZ6KPSqr/1DCTtXSYSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010057
X-Proofpoint-GUID: pK88-r3XG5EAOBX2rEycnps94wye14yo
X-Proofpoint-ORIG-GUID: pK88-r3XG5EAOBX2rEycnps94wye14yo



On 31/07/2024 19:12, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 31, 2024 at 06:43:51PM +0100, Alan Maguire wrote:
>>
>>
>> On 31/07/2024 14:26, Arnaldo Carvalho de Melo wrote:
>>> On Wed, Jul 31, 2024 at 09:57:25AM +0100, Alan Maguire wrote:
>>>> On 30/07/2024 23:43, Matthew Maurer wrote:
>>>>> Without this, even with `--lang_exclude=rust` set, running on `vmlinux`
>>>>> with `CONFIG_RUST` enabled will lead to errors like:
>>>>> die__process_function: tag not supported 0x2f (template_type_parameter)!
>>>>> because the filtering doesn't happen until finalization, but unsupported
>>>>> tags are reported during loading.
>>>>>
>>>>> As an added bonus, this should speed up processing of large objects with
>>>>> filtered CUs, as their details will no longer be walked.
>>>>>
>>>>
>>>> One question on this; if we are always doing early filtering like this,
>>>> should the explicit cu__filter() call be removed from pahole_stealer()?
>>>
>>> When I saw the introduction of an extra callback to be used inside the
>>> dwarf_loader I thought that it would be used only for this specific
>>> language filtering feature, i.e. a defensive approach at implementing
>>> this to avoid unintended side effects of doing all filtering at that
>>> point, maybe some other feature somehow depends on the cu__filter()
>>> being called where it was so far.
>>>
>>> But then it is being used for all filtering, so it seems just a way to
>>> reduce the patch size...
>>>
>>> So I'd keep the cu->early_cu_filter() but would use it only for the
>>> language filtering feature, wdyt?
>>
>> So if I understand correctly,
>>
>> 	if (languages.exclude)
>> 		conf_load.early_cu_filter = cu__filter;
>>
>> ? Seems reasonable to me. Thanks!
> 
> yeah, you got it. So this new early filtering is done for the feature we
> have at hand and if other uses of cu__filter() already in place need, we
> can transition to this new mechanism that reuses the cu__filter()
> function signature/semantics.
>

Sounds good! Matthew, can you send a v2 with the above change? It should
still cover us for BTF generation in the kernel case since we always
--lang_exclude rust as long as pahole is recent enough.
