Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9823AD
	for <dwarves@vger.kernel.org>; Fri,  1 Aug 2025 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066626; cv=fail; b=DjFmjQDA8iMBcpp3Y7tHfpvvB61c19S3XYAac/DWJ0frzhX9pWp+sCMN1b33WKDTSPEe/z6I96qcX0Ac75cplndDyKzMgnfYMj1mBGYxyIy21hgw0tfBmWnGp/a1MdfMRAkD4J1YsB3pzR3BsxuPKp+MBDRtPPBwaV74EgkB1vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066626; c=relaxed/simple;
	bh=XNd0GNek4vcLTLQsqKlLiHM0RGRxcqnvjK5vupCRVVU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B9BNIDarwVYYf8JICkdgV7oclUYZsp2LzHeOTjItBVU7GeO1MMPmJ3mi+WOx0PaWgbiEc0xhslMcIOm235NJzdRBap6B0cKniNM5KyE9idxYDjredK7CG2UTb9rZL4E+RplCGn3tkZv0mtAxSRRSwU37sVLAJk7zpkLFVFo/y+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lREMgC2b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U4QoIw1c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lREMgC2b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U4QoIw1c"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571En0R1014387;
	Fri, 1 Aug 2025 16:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rYQCLPH6IJJmhNuu8j7bfvYPCl6LwOKtYguYjJsHwvs=; b=
	lREMgC2bee2m8NhL9nq/vCdchJQO52DhmRvAzd4tQ/JOn3WcshAdx9OylcVzJJhA
	1UqbyGrrgEK3y8iokqzHMSV074AHDvcihqRb4PBYY7lvyL4ffJkaW/ffAwQ6lWpu
	7B3tR1sHuqLbo04ZHB+Yxmf+NeCpgGJpO1brInflBS/ov9mqAWh8LDPPC4UKskg9
	n2hyQZIzGsrPoQKwHJmOBBI3sgy8x6zc7+wK++enZMZHHB6IGQj5lAEc9J+8uhJK
	DTlmaUoEuG/dek3kbFeUEozosv6Lbkk6OyHRy5sqt9vRKyDN6kzed+MiQqqx9PZN
	LumtOT1kt8ByLv6SZ4YsOw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x6f7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 16:43:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 571Eu69v010411;
	Fri, 1 Aug 2025 16:43:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfdwhfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 16:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5YYJIp7aD7AmEscj/KpUpQmMRhPqKTuHDqcbDHUrHX6iGEVwOOq77OmFipfalIHfb0zCmDUlA6uE78T8s+BT9reBWF1ElmbYV1JCG4u7TD5Xr/XgIPam/N/P1wMqtcLzJgWyIg+wInjtUfysA9derjcwO7ZBIwpXUqO8bHgbEW6Ddp/5HEIpRWyC40dm2Yv+KWFmv70kNNEf5LjbyYA1xr/bzV+7R3OkRbo1LToMN9JWA4QmJeJ9hmCFU3iU7p4C9PqnldeGfxPgx6YiPyPFxN3iiOnS5fq4/yrwMwtF7Ylo+W3TioSlyo9UR7Ax5xbEXXIdDSJUVI3BCoOt/NWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYQCLPH6IJJmhNuu8j7bfvYPCl6LwOKtYguYjJsHwvs=;
 b=bfuZ+fMKoxhzw+ED51klLPIakueMgQ9UZoeYXzF0qfv+IVFW+2B0IFX0+4Hd92Y0exSaCf47VPVMfMZ5VAT0+MGkunneN/JVMpBU16zJHsrKb1d1JwW/m9dXCQEdmX/Aw1t0cNzVZS1rq2dJ/yh+dfDD9BJHQ6WhlIlpbDtzq/r+4RXWaRw+1MajI6l89C419gpmCWuzVtnCtf58sNiJCK0t54/MS3XwfVv8hZ2wI3FBXgnpzH8TdsWnny7MYjXX3hdk+oVD0eIP0eTpWFjftaNuGyOjt4XIw2nseU/OTKiequ5IKlOouT7nAZQKNTWUcTaZ7wtwfYY9nWRBeNvl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYQCLPH6IJJmhNuu8j7bfvYPCl6LwOKtYguYjJsHwvs=;
 b=U4QoIw1cAZnnKBzeKvdn72qk/qERYUi3EpGV0e+HRK9k3pHNHvK5lbT2nu02cnke+xu7xFmnrPHlfhfI48FL49hyZeXSB+W1QYT8Au8JI/yyztaw0tmFoUQmYdkTTVV6+sOOyGH+hzP01angwwE8hppBqyz5UQ3eVVS5yAecviU=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH3PR10MB7575.namprd10.prod.outlook.com (2603:10b6:610:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 1 Aug
 2025 16:43:24 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8989.017; Fri, 1 Aug 2025
 16:43:23 +0000
Message-ID: <12c4c7e6-8d8b-4edd-b32e-92a0f1e56e87@oracle.com>
Date: Fri, 1 Aug 2025 17:43:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pahole: do not return an error when printing only a
 specific class
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        dwarves@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, ebpf@linuxfoundation.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20250731-lsk__abort-v3-1-40f79e168198@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250731-lsk__abort-v3-1-40f79e168198@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH3PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 74246081-585e-4065-ab60-08ddd11a87a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkFWb2VZcVZyTjlNemxMcXZuQ1R1cWNuOVlpYXltU0xRNVpRSi9ua3JZeWRO?=
 =?utf-8?B?MHA1ZnM5MUdWMXhVMUtxQXlIdXVNc05FQVM0UnZ2M2NiZVphTlNvakp0UUhy?=
 =?utf-8?B?N1l5YWwxQmRORHVtaGhEWkJyajdUcVBleWUvSitCRlN3WVE0K0ppeW5xMTJm?=
 =?utf-8?B?V0Q5bmo1OHQrZDgyVjF0RytNVGxIVUhOVnp3U2x3ZThabzNYbTArSldidVdV?=
 =?utf-8?B?MEx4eWlZM1Y4c1B2WWc0UjVndFJaN1lObTg3UzMvTitFelIvNkxiVCtLdE9L?=
 =?utf-8?B?N3JYUndFR3U4NGNjMVdQci96RlBHMk0vVURIb09iRitkQlkzWmpTMEpYUkI2?=
 =?utf-8?B?MFlqZHQwU1ZMa1BYZ3R2WFBSUzFhakVWWG0rdUFoQnNtOUNGUk5YdTA4MlQ4?=
 =?utf-8?B?SnNCUGVld3dENzVoU2xjMlQ2VmNNWFZGdEU3VXJLVXdrQk5uR3BIeTBoRThR?=
 =?utf-8?B?azJsZWFYZUFqbE1KWGtZYlNXVzdWeXIrSHdUOVBobEVtZFUvblN1dGFqMGtB?=
 =?utf-8?B?OG1VT3JIcXcyMVVFTXpUNURoWm5aL0MxcmxRTm9rQ3d0NGlHdWcrMFZnTFlo?=
 =?utf-8?B?c3I5cGdJaTRlU1cvQ0I0QVpYZG9DT2pWUjlINlIxQWhRRldZc3lkSHNoOVMx?=
 =?utf-8?B?bE9pSVlPcG1XQmtJVVV0dWcyQWFpTHdJeis0Snc3cmltZDZqSDRUQUszYmdM?=
 =?utf-8?B?VXdPMEM1SEhoZ1R2cXZvM2thbG1Rd1QvT0E5NVdOazErcjZxSEppOXFRMTdV?=
 =?utf-8?B?WVQ3SGxGTForcEZRclY4QnZsRnh5Z2tuZCtwVUk0WmlRYXZucXpIa2d2YWFI?=
 =?utf-8?B?WEUzTVFqVFRsMWU5VkdpMXZBKyszb2lrZlh2TURWZkMyYUpYVGwvU2ErN0tN?=
 =?utf-8?B?cGthUWtFMWFkLyt2T05FeHM3Z0ticStDR29IQVkyT3hRRXdXeHcrTnZZbWQ3?=
 =?utf-8?B?Vk5pTEJOME9GUVd3cjRDbWlCSUJ6c1BGRE44TDdhNlFZY0pWTEhiWE03T2Zr?=
 =?utf-8?B?eE5mOFJCeDdMeXcyUUZFNlpydHI4cGpMRGQxdk9BSG9CaG41RVZmTGdUMkdS?=
 =?utf-8?B?WDFwYXpZbjN1TlBJMk81d3IzMytPZ0lldVdMcDlLTk5Fc1FSWlA1NlYzV21T?=
 =?utf-8?B?eWpUMU9uTGxhVUVKZHZSWGpYblZ1Z2tNcWFvcGdmMWJSeGxqbmlpY0lscklo?=
 =?utf-8?B?QndUSDgzd0tVT21ONy8vZ21rUCtNTHFZdGY2UFJuczEyWmpwcDZSeUJxOHZY?=
 =?utf-8?B?VjhrN3VPK01oOGRtbTlCSWN5L3RWWWpIMlV0Q25zQVA1TWdXK2F2Umt6aXFk?=
 =?utf-8?B?YXFyNngrOUQ3S2NOM2M2enlYMVpWYlBZK1NEcmZRbjJaQzdrZjdpb2pKVC94?=
 =?utf-8?B?T1FXK25HQVVvQnNJSmxkdVh4b0ZOZ25ZMTN4MWRFZnYyRDdxQnViYVJzemh3?=
 =?utf-8?B?Q0tkYmg4eEI1WVdDcGdnYnplZS9MQ1BiOTBWNFhIMzNLd0syaXE5QjZyenhO?=
 =?utf-8?B?UW9IbVlnZkFHQ25lWTE5STFkQzVKNyttOG03UTNtOWpKcVBYQ1ZSbkRURHA2?=
 =?utf-8?B?YmtRZ3JEN0FIdncwRFMrSmczKzh0Unp2dCtCcjBZbTFxMzRpNUFTVkdCbkdF?=
 =?utf-8?B?S1pJeHhPdnFtUVhBNzFLbUY3VmFRN1FaNUdEbWxJZmVjVDEyODluTnUvc1ZJ?=
 =?utf-8?B?WTVJci9WZGVWaEp3TFJBbk1DWGFHdmRBMVhxRmhuRG95NXI1cWFkTHdVQW5Y?=
 =?utf-8?B?TnRrcjJoYXFNVGxUMkFzaFVpU3lKWFVVV0JMOFBFVlYyWlZJS2pMZTVFU2lm?=
 =?utf-8?B?ZDVvN044Ly9qQXViS0M1Y2t0NjgzSHNSQTVwek94REhTVG00WndHRGxlem5N?=
 =?utf-8?B?U0kvZEY3cnNHQTVWUVhOUUs5SFhMZnRuOTFvaHh4a2dQZ3RjTzBGa0wyaktz?=
 =?utf-8?Q?jwNl8uQUExQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVhDbkM0cXBUTDhjWmg2MkZINTEyTUZscXFndkplUURpbjRmaDZzb2IvbWJv?=
 =?utf-8?B?Z05uRE1Rb0psTDBSSVM1N2hYZFQ3akI1bUZoZ2d0bXhraGJuUFkvVWRlbTZn?=
 =?utf-8?B?RC9PbDBZLzlwYnB5K0M4a2ZaRldhb0JPMVZkeGJ6L051ZlZmYmNrQ3ptS1lM?=
 =?utf-8?B?NytRZWJwUUVVMjhnVmx3YVYwNy9MMmNnOUdXUEFINDMvNHprTW5aOWYydnQw?=
 =?utf-8?B?cEp5YnFzQlZiTWs4VWEyZ1NmZC80WFJIZmd5aENhMmplQ1AyWTZxWitCM1NH?=
 =?utf-8?B?T3hNZ3V1Q3B5aGFjNm5qQW5SM1MyNU1VcEJJUzFzMzB4SG1sRHI0Qm03QXE1?=
 =?utf-8?B?ZDVQbWdFaU9HdHVUSHFSRzQxb2lFbDNCRXJMQ0sycG1NSWR0MUt0TUZvSEpD?=
 =?utf-8?B?RzZqRnhkVFF4emxGNVZ1WHQ5K1JQZUJkaFBrNUZMSDUyTHVuaE5RRWtKeDBK?=
 =?utf-8?B?NGR5NE82TW5GSHVkckFkMHBXSzNYUzdBWmo4TTJING5kRWxKbEx0RVdCZGFZ?=
 =?utf-8?B?YlYyMTU3SGUzQXpJMW04ZEtURFBWcmg1US9GODM3ZnN1ZHF0bFJqSVFLZ3d0?=
 =?utf-8?B?eW53ZUxmcC8zaTBnK0ZPbEIyVHpnaGxIV3JyeWdXdTJKRlhWZGg4ZCtDK3Vw?=
 =?utf-8?B?azZ6eStxall0QlhLcWlHcmpUNnFLY0g0QjA3SHBIemcxKzVXUU4xQWVyczN1?=
 =?utf-8?B?SmF6c3VaTUFncmJ5dTZTVmRzeElXWWFERWV3K1p2VHFYVHk0Y1R0aGphTW1m?=
 =?utf-8?B?RDVVbUpMS0o3dHIxS21pWXI1UEtKQ09PSjdTVWJrN09aWW5GOUF3d29vVUI3?=
 =?utf-8?B?d3VnSHdIa0kwQmNPUUxTV0tRQXJ0ZEFqVy9DZUptcXdyLyt6ZEdpRGpCMzZE?=
 =?utf-8?B?WHloQitTdWZoNEw3amRoazdHN2xwSWQyZWlpdG9kRGJJc3VtNEF4akRSMnJj?=
 =?utf-8?B?dDZHeXh1SFJ6SmhZTnRpU2pobHF6WEU0bklqQ2tzdE1jWnpzdEJ2NVdiMTZO?=
 =?utf-8?B?dTdzV2VBditXdDFuUFY2VC9qUTV5Q01kRlBOc3NSLzJIYnJIdEpwWkJkTnJM?=
 =?utf-8?B?MUlvTUt4MUxOM3lKdTBrZzVyY3dJMnRIYkpkaGxYeXh6bDFBRVNIY2pvQjUw?=
 =?utf-8?B?Q1JVZk1SU2wrbkpYMStWbDZsUlFxeHJNSFR6c05tMEdmVnNRakN2YUFncmpH?=
 =?utf-8?B?eUErZ3Jkc05XdzJtOHZsckk3OUtFendkQlN2T09mVkNSN3RsSVc1QjFEVWlx?=
 =?utf-8?B?WDI2czdITjBPR3EzNWpoM3d0Y2tuRWdGc2h4emZ2MEJCOVVxdnZVNzlpVkhR?=
 =?utf-8?B?dDhXK3U4cG1mbDNHUGRBbEZMaFlxYWlQc3ZHT29zaUdVTlppcWE1T05QclRU?=
 =?utf-8?B?VUlvWjJab1FqNlhJcCtQZ3Q3bTQzU3ZtSUNlZ3BTTlZhL0hWZnV5UU5lYTZK?=
 =?utf-8?B?SWRScmgwT3JWVDZBQTE1ditOTTFTMTRBeUxLRWNlcGQxNWpJU2Q4ZExSY1Av?=
 =?utf-8?B?VTB0V2xoL01TS2xmOWZIYlJCN2Q1bEE2YTZvVnJENFdOMFZRMksxT0FpcVNR?=
 =?utf-8?B?T3NwUGU5OWoyN2FTMStOSFM5M3RwbHRFbHpzS2ZQR1lsek11WlBHbHMzQjMw?=
 =?utf-8?B?aUtGZzVuL2U4YythUXR2UjhXaGV2c0pRSjlEN1BSS1Y2eFRsVFgvc2V1emIv?=
 =?utf-8?B?ZDUyZ1c0cEZkKzV4KzBRM1ZPSHpCb2psNzhzbGVhTVV3REZDVWp3YWt0WmV5?=
 =?utf-8?B?bVowczQ0R0JtR3ZWS1orZnlZcU9LUkU2OURGRWUweFExZ3E0WDNyNndwT2Fm?=
 =?utf-8?B?M1NZWkxZVVJ2Yk9TUkJ5dXEzOVZ5WnJnbWNyVWQwenJaNWZSNm00bmprbmRs?=
 =?utf-8?B?QjY4SEp1VXRpc01uZjBDbUpEeGNGdk9jM0FpN1dVMVhMajgvWW5UR1Rvdi9F?=
 =?utf-8?B?QnlzMTJ5c3V2UzVaMkQ0SUU5WUZHWGdzSnVnRHJrWjc4anQrWHFSZDU0MVpo?=
 =?utf-8?B?NHE5QlRTVU9nZnlPQ2ZPNExiVGE1cVpjUitRTXVhUWlsMy9RVTIwalEzVTJ1?=
 =?utf-8?B?bFUvdEtXTDZVa0VGTDlsT2lpaklaU04rbEFNVXRiWkVEQVdmd2ZaSE9VNkEv?=
 =?utf-8?B?VjdCNTR0KzZVc2RBWk1YOFdtVmV5UDVyUHBaeTl1VXlTM3BWbFhBeDNLYS8y?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PvMHiuigzM7T3qgIP6oKvR/3Dysf6Ys48j28uzwoNOFa31gfU6PU+L7ItlQfUZfaStAf3ol2cR72sLEjSS4sO/0Ttfq3rcnUxZvqt5Zed0mC57XuluXYoOz1k+lHqVXfUXGbF7IWmIey1gr5DACEFYWJei9NcEU7lQ4TAITQqG56C3GUFrBt3xRGLO8VTVvVOBv0YzcsZIBqBbjfiTYgSPSQLxwMo1Qp1cqrAV64SCu2KBUIiU7kRBqvYD8rkUOMPdbyT3HmvTP1dLOLIm+kV073/nO5NeI9FzY5RjB87uYo4gS94tXREy2hyOTdGEkCsNmYzh5nb2Mzckq/XwA0at3rsifJEyS5nNvPSdrXwSmLiY9g1aS0j9dpaA9SLS3jJWWTStlWb9S9bz8XdA28CaeV8mMr8HM+Dsojlqe0B5zbgs0gw2kaR3xGfRPwXhNvsXSOlcca72M4xSF/0DyFHdt85QaL9JJaNWumSonKaej8LYivNlNvtQGQRKZ30Ypj2wKAFi4uHHE2jvAX27o/HMUjszqdfMl71saYWjdg4AOesncswh2ff6osm5WUTYl1eWsKMaBIz6ke/AoXg1Vjl7bqMu0ViguGhnGpyDko9Sw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74246081-585e-4065-ab60-08ddd11a87a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 16:43:23.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yk9ikRlHoy56iOJ/NruygU6Ycu07z2CG67wRUT0oZZR5t9/4ZzzwEQy6/I4orDGAqEsvk1Cs+I2FnNIU+ghbbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_05,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508010130
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688ceeb0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kljl6ElNen18G7mm:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=P-IC7800AAAA:8 a=JD6Ss9TC1_LalzuFVNwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 cc=ntf awl=host:13596
X-Proofpoint-GUID: Xo5Kc8Nysb4ZYo5W6EOnIvVi_nUe2w5U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEyOSBTYWx0ZWRfXyRfu5QJHMP3E
 WHjtQQg0hcAZsfdHWQkkNhnQZn7w1akQ0Bcb54X8sF5GMbXXK1Dx7L5kMTUmutzVeFO/DGY31Ly
 d0xNBG45+9N4nlKBXchWuwdcRQQhVZdMKk58fyKrPl8sBoKroBW7vEuHWTnv0gqMebDqc2ah/53
 7gJEYQF3tDUNPgnDxgAeOCPL1Yd9aTfIWqFe870rT3i8nCVCx1NtqkfjjS8CKB0tpkiiy4gpRTw
 pui2CUB07p+Tdg2xC7vYz10QoB9whC/UyRuXVbP9sY+nZ2YKu7eizgqSipkmk+yB9vFpicMLv/W
 bUHFNYbwOQc2U7WwQ/97GokXtmE1QHxx9vyjWU5kaZ0YtcJYYcDaRup7502gB9obzdYig8VIgGt
 +k+hvq2BFd9f7tVUzC5tGhWaKj7qA+5/UVQ97mgH+NMm1BmQ0IRIbvTfBOLxus5spOIsE1WR
X-Proofpoint-ORIG-GUID: Xo5Kc8Nysb4ZYo5W6EOnIvVi_nUe2w5U

On 31/07/2025 17:16, Alexis Lothoré (eBPF Foundation) wrote:
> When trying to print a specific class layout with recent pahole
> versions, we get an error right after the expected class print:
> 
>   $ ./build/pahole -C test_bin_struct_packed -F dwarf tests/bin/test_bin
>   struct test_bin_struct_packed {
>           char                       a;                    /*     0     1 */
>           short int                  b;                    /*     1     2 */
>           int                        c;                    /*     3     4 */
>           long long unsigned int     d;                    /*     7     8 */
> 
>           /* size: 15, cachelines: 1, members: 4 */
>           /* last cacheline: 15 bytes */
>   } __attribute__((__packed__));
> 
>   pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument
> 
> This error is due to pahole_stealer returning LSK__STOP_LOADING when
> dealing with a single class and when it is done. This LSK__STOP_LOADING
> is then propagated to dwarf_loader__worker_thread and interpreted as an
> error (and turned into a DWARF_CB_ABORT). The main issue is that this
> LSK__STOP_LOADING value is sometimes generated by actual issues during
> pahole stealing, sometimes by "nominal" execution.
> 
> Add a new LSK__ABORT status to distinguish between those nominal and
> faulty cases. Still let DWARF_CB_ABORT value propagate when the stealer
> returns either LSK__ABORT or LSK__STOP_LOADING (so that any other
> running worker is properly asked to stop, thanks to
> cus_processsing_queue.abort), but also propagate the LSK status, and
> return an error on DWARF_CB_ABORT only if the status is LSK__ABORT.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Thanks!

Alan
