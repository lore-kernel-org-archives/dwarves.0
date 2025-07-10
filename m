Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082F1DFE1
	for <dwarves@vger.kernel.org>; Thu, 10 Jul 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176651; cv=fail; b=i87htqqJmMcbaSUR7OPTO9Eau/Js1B4xyQFM8P3CaJPFHo3BFlQUMFs0yHONDcce6AFEw72IM5n7Yv03WhHnE1nqp7wwxk3DAdRrYligE+7XHidnTQNAHtpehuJCd4UDHtnnYewuDJyd9KtOcb5hhXorZjFxKFsVIX1HA6FwrJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176651; c=relaxed/simple;
	bh=hlxovGb058WTxJ/GWgq8ESi8ofVY4PDZi1NFgomybxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A8M/OnQOAxf+Ip56My3E8C17DXLrJaGIzIArDrlPA4ho1uJobzr6Jx/0ZSShmv67glq2GWmPl5QMW0FrmI/UGAKAOfNUbZvpQx5kdCZbGZFCbovF9AGV51gps1DbfoVUutNMXcW2EuZlWAtZDjXHERrcaXlilXmhu3O56r5yDP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mdW6jeII; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d5tVHhfQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mdW6jeII";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d5tVHhfQ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJMa0e015093;
	Thu, 10 Jul 2025 19:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3fi3+i+PpX85ZBG+2jbfzpDZcwASRiejIL1Qq3pby5o=; b=
	mdW6jeIIDB8HBL2mQG80J9VViReuvOJSyi+P9QEubwBFrdjkguRj9vnJGEjYxjMt
	015NOQZ8AHLm2r77H7UWIAvV0si5wgI6FsaFg+Jk7Pq4gs3ken44m9EmhvbI/fhA
	D9teSlJJI/ZYxz0CPzSiNJwM0cWzcvTbQve/v2p2MfOjtEyeM/9t5tmx9aC9iZJf
	+8RtwVIMf3jr8ukcRT6967rWTBbbKHL+yyzonOfRztWUNDw0ay2ScXq+0CHeEhy+
	lXjCGhYlTcDUInEuAfW2CQzQ3jPPF2W29rsOdaeLngyqK83Sw457zl/Re3IylEZE
	hx7godUFnBUajmSJrln5Qg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tkkv81cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 19:44:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJfA97021542;
	Thu, 10 Jul 2025 19:44:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcpsbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 19:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCBXN/xlirpsjmUlB6DK3WKKPjAY3hQgOZzKlrdtbybgGNA4JZ/UB75X/AvqlIdV5IiKr12l2ajQwg9rxq3dhYwN0U/qMd8afYHq4vyVC5wncuTqTfq2Yge/ocLbX5vDP9oumUK8O84yRmRPwzS9OWBaCL2ZlGjka1IZjDYKjmB+qouOoBka1HmurwRaneVGhn/6JQHZuXOJ2AloJClJntNEQVtcGQbQVnGFiFvLU1c1l6HzkAwTVFSTcvN21+QCqR6KHedqvhzHrMXf/ZsR6IIY/FGauY7CBtuT9nC4emUslHLcmu/1dFQabAWWR3SZerA1nvVN+oOw0xa9C/sI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fi3+i+PpX85ZBG+2jbfzpDZcwASRiejIL1Qq3pby5o=;
 b=V4n9T/5OODJbv2AgfOQ2xnhUjXYSP5Xity5Ey9cNvxXVx/YZBDUoUgl6jlHoq+o3MxkAM+EB0LA2GeRsYPRlosXXteGWpwA82Sv+ZvKdreuxckToOMrf4wp2TuQNx1pfRK5qEFknu1awQDPTD/c4eRs74qpTPPZj/u9lpfqMvsUHzZWXx9BvsS39ew75wY4+XWXRSOEupAHC5AILvT4bWn9zTIMJ6XZ3woLCXY7MM6rsOqrlCO+CGpv67xO7nrzNaEzAb0QB8e33cYGcIT9jKX5Y3YKk1nOzngH5hdSioOC3ZbS36ksX4qWIvGOhaYNI+L0Ly0l57InCWQ+b+NTywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fi3+i+PpX85ZBG+2jbfzpDZcwASRiejIL1Qq3pby5o=;
 b=d5tVHhfQuslvmyeJ9IEojCu7y63FMjNIR1KkTt8UAAOeQxOWw1PlADT7npP+r605gFEj7p1WO3Hg+GQzWbQx6qNGrwNJoCdfcoLr5kimq5LwTkE/QemyKjMxQmOPjx7vaHV52ZhaFMbjieWev9rSGnibbVLX1xJZtK1i9a/qkeM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 LV3PR10MB7771.namprd10.prod.outlook.com (2603:10b6:408:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 19:43:59 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 19:43:59 +0000
Message-ID: <cb7c9a54-3d8c-473d-87be-44b2a754c599@oracle.com>
Date: Thu, 10 Jul 2025 20:43:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] pahole: BTF alignment inference improvements
To: Antoine Tenart <atenart@kernel.org>, dwarves@vger.kernel.org
Cc: pvalerio@redhat.com
References: <20250708140856.311717-1-atenart@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250708140856.311717-1-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0005.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::17) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|LV3PR10MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f3e7ae-da3e-4609-80ef-08ddbfea1d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3FYZi9FTFVscHVYSUUxYTdMVC85b2phVHpBd1ZmeXAvN1lXYWp4N2VvRDJl?=
 =?utf-8?B?eFRwdGJLYXNqZXdnc1BLcHEwenpBQ2I5c09DdzhqMTVVblAxa3FIRGFCbXpu?=
 =?utf-8?B?aklXQ2tSaS9MYU04RGZ5b2p5VkVDeDBWUnpjNEY4ai9lejRyR1dGVTdSNEYz?=
 =?utf-8?B?bFRQY21DNktZN0VqdmZ2eEYvVHhURmhxQmFSaUR4SUJ3ZHlwam1JMktIbVlt?=
 =?utf-8?B?ODJWMXcwNjFTZzJUc2pxTlJOYm5nMlF0L0tUbDVWMlpRSjZOVGFDalMvbUJO?=
 =?utf-8?B?UWVGMVZIanlIMWtXdWovNi9STmUxV2szSUNESDFvQmQ0aTRueHYyRytURkEw?=
 =?utf-8?B?ZVI0RHpGdHd0bFZSdWFMdm5EMTNJWmVkN1hRWTVnNjR4YWE4Qy9vMXVGT1Ny?=
 =?utf-8?B?T3JhWHUxbWl6aTNhZmNrOHBVWHpSTDFhZDFkSHovWEdrM3VMZ2FWc3Z4NThQ?=
 =?utf-8?B?UHlsTHRUU0VEUm5Ca1lyOWJNWTg5MjhLa3haM0RXL2JGNEY0U1FrVXhkQ3pz?=
 =?utf-8?B?RThKNEptTDVJSUY4Ly9Xb1RGbmoxdVp4Skl0SG1mVVBiYTZDYllDYTkwVTZt?=
 =?utf-8?B?S2p3Ymd6Z1I5MjBxTUNucXNwbkdYU3ZIdE95VXcvUDdtY2lIYUZWMi90NVV5?=
 =?utf-8?B?NjdxQjRQZ1hWa3U1RENVd1JWVUVRUWhBV09iSTh2MG5LaGdFemlHSFhmM0Vi?=
 =?utf-8?B?VXBHbHF3azVOMUlxYzdXSnppM1Fab0xLRFUyVThWMHlhYnBScWJ6Y2cvS3I2?=
 =?utf-8?B?S0MvdVpvUnlLMlRuYjJuOEFySEh1N09XMXBzVUpoY05UeVc0aW14eXZ4U1FE?=
 =?utf-8?B?aGZCbW1vZHhiMzhPM2ZBNjRRb3l4N3l3VkMyYjhJajFaRGlsTlJTSEUzSE11?=
 =?utf-8?B?SnFlenVhc1FYUDErZGhwNDFmbVNLU0ZoNmtKcTJjV2NjdkNjcFNiR3BGMXBa?=
 =?utf-8?B?OVkydjRsaEZUWTJ1YkdYQTZ2VkVxbk95VXNLTHI1Q3NQcUxMQjlza3ZST29X?=
 =?utf-8?B?V0MxNGpmeFZSWjJ5OHdaL3RlMWxhaVA5U3dTTnplM1hQRllmR0hyaXp5UlBh?=
 =?utf-8?B?TzdKSWdaakl2dGlwNlBPTXpQZkl1Qzkwemg2UVB0ZGsxTU93YzBhN1hWcDdq?=
 =?utf-8?B?R3RCc1d6WkYxSi9oa1U5VkVObnRCVkJVdWM4TkNtbHRqc0N5aWM1YzlraGpp?=
 =?utf-8?B?WURReFVTTGRlbEE2M1FySGZiNHZOd2NTR0ljWU5FSDVqQ0RDdU9Bc3NLTHNx?=
 =?utf-8?B?V280Mk1Ccm14eG9wSUY4dlhFRm8vY2w5Z3dnOW96enRVSlh4Z2JhWW53eCs5?=
 =?utf-8?B?aERBZUp4Vkx2MTc2cTJrNFRqZnVYTnlmTDJFZFI1VU5FK3RBS1QxSHVoZllq?=
 =?utf-8?B?KzYzNjVGTUpwV2NoL3MxMFZKZ21ucmhRbmJoMEoxUitsQ0pQRS83dTlOYXlD?=
 =?utf-8?B?WGY3bktKdmFFeFpWeGNmemdZNEVYN1B1UkUxNkM3STlnYVRoTzFIakxGOG9T?=
 =?utf-8?B?STRYcW5wRy9jM1R1eVdqUWMrWC84aXoxMU5RVzFRczJZQTFna0tyTkc4cHJF?=
 =?utf-8?B?aGFkMDRKSjNrSis1ZHdYNWNVV0laclNRMWVOMGlmcnkrb1ExVk1wRjdKM0lk?=
 =?utf-8?B?NGI4dERFZllyYnRwWWxRT09TcUlzYlFEOEIrc1AwcENDWlFTQTYybGRtY0wr?=
 =?utf-8?B?T3NRZEtRZnJtclhRVkdneWJBZStMQmV4N1NFZ2Z3aGRwTWwyUWZqVmovWHRq?=
 =?utf-8?B?NXBVbWgxRDdnRTJWOWF5RktLck1CMFN4N1NGTEFTdDIxOFV4blVXczJxclJD?=
 =?utf-8?B?OFdOUGUwSm1tdHdSd2R6WjBmVHNCblZPcHFYSGEyZzExMW5CRE85aHdCdzRB?=
 =?utf-8?B?U29aZWEzLzQ4RFBTK3pwZ2FSekxCaGlBcC8xN3FJVGZ5ZGlaWWxXbWxBS2Jr?=
 =?utf-8?Q?sOogxOteXeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0c5L0pvdWF5VDJqN29oQ2xWQUN5YzZqT0FtL3NqRGdYcnNscDdod1RTZjZB?=
 =?utf-8?B?VHUzSUhPTXpIUWkrbmx4L1doVlFldWNocjM3OWFSOGdTVTVHZUxOV3JvY3Rx?=
 =?utf-8?B?YnE2ZzRzaE52U2p4b0xnRzIrRjg1b255RitQRUswWUh4bkh1R1NGSGFxSmpa?=
 =?utf-8?B?dG05RVJmZDZJbVk4NVB4NVdpbnlGS0EzL2dPL0RvRGJFL2JoRDdsZWVHOGtD?=
 =?utf-8?B?SC9wMitpZXdITHdqOWYvbnJWeWZ5b0RMbHVZTWc5cldUUlBHSzFGNUF6NXpY?=
 =?utf-8?B?TkgrdXgwUGo1MDFZQ1p6TnhDaWY5ZnJQbk9sUTZwbmhpT0RHdzFKdlNOc1BB?=
 =?utf-8?B?UzE4c3ZIVFN0ZjRHR0R4YUFFSGw5UnNObW84aVJOcXRGeFNRUXFobHA5aDUv?=
 =?utf-8?B?Z2xaak5wa3BaZndVVGNDUXI0eTdpbHdMaTFFdnN2SUZ4MXFzN0xFMGxocFY2?=
 =?utf-8?B?NFRROXhCYk1jeWVvMVVoSi9wRm5nM3g1Skh1cXZYL3Zkd3paK2JHTXlOWlJm?=
 =?utf-8?B?U0lPQktjYWJMU2U2VDhPdVBQUnZXc3ZvVEoyWnZKMDV3bDAxdFdxaWdkT0ZZ?=
 =?utf-8?B?bHllT2Q4djlzNE9FRGw0R1dYeEVhR01sbEtHUUU2bEpmcVRzc1hFOGdTaVdu?=
 =?utf-8?B?ajhSUW1sQ01hZmdTYjA5aGRNMmZ6VVgrVURFaTBrZFhUUUFybVhuSTNneGRq?=
 =?utf-8?B?L0Z1Y3l2MjRpVVFReGNCVEZRK3hIZnQzV253TkdKNFdiVVFpeTArUTF3NThS?=
 =?utf-8?B?UXFhYis3anVLZnBxRU8yTzZ3QVlKR1RlRWp0ell2RWR5WGlXYUlnaktaU1Jh?=
 =?utf-8?B?ejNrVWdUNnBmUXhqdU9tSkdXVjl4RU5PVjRXSlZtR2xkdzRiMHpTK1JEUnhI?=
 =?utf-8?B?VWRtZXFIMXYycmdBcVk4dWZmbDFoMy9ZNWhIT3VlVDc5dndjNGlGZHY2Ung0?=
 =?utf-8?B?U3ovcnJ0R1Z4bTgrV3I2RGRWRDVoODNDTGZ2VEpWSVQ0eFNydDJIQWR3dkRr?=
 =?utf-8?B?bHhwajl3K09Ddmp1dzhsd2l4MzFyNUUxRjF4NnUwTFlRVnQvVXpKam1ielo4?=
 =?utf-8?B?ZHhWS1NjdUROSE96aDljclA2NnA2dzNvWWtrcGMydU1kRWcySGNqUFNpeGt0?=
 =?utf-8?B?SjJFaDJUN3dNU2QzZXYxU0tYMnYzZndaWTlUNFFYejRxVnhJTzArbWpkcllP?=
 =?utf-8?B?MmZGWThVc3pLVDZIZzdXSjVxaFJoNElGYkFJenFzcXBZL0dYU3FhNFlsRlIz?=
 =?utf-8?B?ZDRMTTNKazlQSkk4SzgwbkJnZUZxK1dUa2R4a0l6M1BEWEx2cnFUUWN0YW0x?=
 =?utf-8?B?cTN5SDRUY2Z4NEZyKzF1SXpKaVl2NSs1TGRhcnhGSTg1SGl4SjA2Zklwdlpk?=
 =?utf-8?B?SHJzcCtVYkErZStpa0V4cHFJNWhVa094dnNqV1BHemEzL0VnR001TXRhMUp2?=
 =?utf-8?B?aHp2ZGlqa3VsNzlHTkVjNlY5cnUweURUNzlVRGx5WFdmRjJFaFVIWGY0clpW?=
 =?utf-8?B?WjAxQlM2aHJiU0N0aUd4TVFNenErdWpOd1RTK003RkFCczlFREM5RHo3QmFJ?=
 =?utf-8?B?ZzlFbHI1ZUo2VXByeWlIN1JwVVlZdURlN3ovakdyMlNSVjd6SHpLL0lMR2ww?=
 =?utf-8?B?dVhFd0FzaVdxQlZ2WVNOVWlwYWlIcVVCMUxKeUR6eHd4dzBvUFNseGFncHhm?=
 =?utf-8?B?ck1qTE9adlJ0T0o5c09TZ3FMaWdmUHYxT3hFQmlxT1BNUVdnb0RBdXdFVXYx?=
 =?utf-8?B?NU8rL0c3c01nNUtNV2hnd3JabStEazFpNFZzWVo1cGdVeEtaZ3BnMHhYUlho?=
 =?utf-8?B?Z1pjZFJIODI4TVprK0JYTW92ak53cHpITTJBai9jSmJzQXdOZXlQRVZvckVj?=
 =?utf-8?B?dFFWRFA0WFc0amgzQXhzblhteUl5MlFqdmdsb0I5OXRSVkpyNEFkT1l6NFpv?=
 =?utf-8?B?V1gxbnRxdWhRY1R4aTgvaE40S3ZOcVBxMjdJanBaanF0YnR3RUd2S2NPR0E4?=
 =?utf-8?B?NWtOTnJWOFhvWWNPaTVNbm1Vai9oL0NIWWYxRStHSkVrMnJ0ejlrYkFUbTlR?=
 =?utf-8?B?NUtFUFd1NmV2Y0M4c3hWRlJFZm1qMHJYRC9tS3NlSVZhT2ZkUjc2Sm5qTVcv?=
 =?utf-8?B?enZuN01EeVB5OE9SVVV1b0hBbkgrenNrZlhyNCtMQmlQNjRQOHJYWFlqaDQv?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eyfW6OSZ4Wudy2drDOGo629wOVin+MwdDw/zkAQoYGs2/ceUc15NK49wFlze/f0EAQ90xKx5XIStexNbq0iPsTV87XwdWwOYL21GO4aqYYENF8RxG8m0+NyX1bEoScGyFDXavNPExFGlQR+xND48zDU/uGzBa7og5roWoI/Q6kWQtaomD81yEsv8qtYfv8W6y1BfDfzBmSyZVur400iYd/RXdGtwqIitDNV+mUMhKOcM1gXN6QfL3xxN37/C5rZwo1qPyMQGSxRKLtV0l3gACo/i4rC40q7z9J+u7BbOhUq+MpHFuWnuOt77W76rGQpSAYvalxkG0uQJfyM4I3bMoQAASc0+kB7ZX7IdvPLZ6fxGvKj1RN5pQtC2Vq3rbpIAsXs3g3jPDpc7obtibS/ZDOVF+aP4m0uBSJNB93/Y033WBVjVl/Up0gCsYm5cU0J/UXUWGfHYwa4gIfJrrgT6Jh0CT36HWtlYNTsQjXQfZuFgPS1Wgu1qnIJUde8W9BceYk/AG3FblQYIfnVeuYX39o2t7MvnE1TrBbJ//TnF/e5NNMpFgwYis2+FNnYUCkEopRhyizhTEDOktq3F0ctmWu7txDkNb7tNpcjdIHvJLvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f3e7ae-da3e-4609-80ef-08ddbfea1d1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 19:43:59.0936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVuk5J/Siom7+cTRXNZP2a8SB9Zfb8OxA06vGwj8NipPiNK+dOZM+jOZWlOU2eoWmYJ1QZY4X/is+ZCLpCZnaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100167
X-Proofpoint-ORIG-GUID: DlhFaTFgT08Pc6hYqWAeupR51ZqhrhYG
X-Proofpoint-GUID: DlhFaTFgT08Pc6hYqWAeupR51ZqhrhYG
X-Authority-Analysis: v=2.4 cv=c+urQQ9l c=1 sm=1 tr=0 ts=68701803 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=wI98qHxUyl7LJHTUfOMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE2NyBTYWx0ZWRfX/g9tzLzvY8lD D1WJGOXQ+CtxDq1LMgqW60MArVu19fJWdVDTNOjuwVLWcpD+29NOkQ+HA2zk6Y6c8V2Cl93cSIu rxO3xorsGelCSYfZJgClihyn9Ta0GCwopMhXw+RDJcMJXdTUlSjDOcL14snVZXBTrafbA292aZ/
 UTUlb1RttnuEH8FKnyyFYRdKaP3u0HC2QZMAnjQQDbJ6uvqmKBo0uoECRhI41n//7Ipr3Bx7wlY zpSLkyX9u2P3bCFEOM++3dXszbGMpwbRWVC3n6VjX0n+oXeydV0zorBVHY3p3zroS+flXWGo/gn r+pAn7LEtSVVMQ1ZP/Ioa+KVtZBk8lzxdk5460QTcxB9PsxY59N8TNZWkpEQX8xuh9Lm52XZ5gk
 1WjFYIU9Rv8lDYR+Zjfx3SUNyUXqW9UuZBA23X7qmFKA1Wc8EjEO/3H3njFWc+kx+bBJtYkB

On 08/07/2025 15:08, Antoine Tenart wrote:
> Hello,
> 
> While generating C code using pahole we noticed alignment issues in rare
> cases: when having variable size and 0-length arrays, and when a hole
> follows a bitfield. It's worth noticing alignment is inferred when using
> BTF as a source as the format does not contain such information. As such
> the logic is tricky.
> 
> The first patch fixes alignment inference for zero-length and variable
> length arrays. The second patch fixes alignment when a hole follows a
> bitfield.
> 
> I generated a full vmlinux.h using `pahole --compile` before and after
> the changes, the differences looked reasonable to me. I've also ran the
> project's tests using GH actions.
> 
> Thanks,
> Antoine
> 
> Since v1:
> - Added comments in both patches to help future readers.
> 
> Antoine Tenart (2):
>   btf_loader: infer alignment for zero-length arrays
>   btf_loader: fix smallest offset in case of bitfields
> 
>  btf_loader.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 

Series applied to "next" branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

thank you!

Alan
