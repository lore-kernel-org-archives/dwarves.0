Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1D1386561
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054173; cv=fail; b=H+1W/i2e41B3Wc1NYWLDCdNi3TjOqo92ak34wZa5oa20Fja46tlw+Eg1VC4tT6SwmVQM/qKMOJYnaflpMlJoNfo4BGGfMVnGEXw2n5hd3NYoxlNriHa5BvN0zI4N+NRO7O8JPGUB5km+PVLUxdxVhqZpT+WVI2rDaGF3/jycdow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054173; c=relaxed/simple;
	bh=2wZ4yt5UOIK67Sax7qCz3wdL7Iku1Rjmkb6qGrRs7mM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnCGDGI4JFosVV80CYVtyxyTpgsb33JG3OjWfHRxmIhtGdWDNgUoeNU2FZLQfyKPUwmr97uBTofi3nnIuJwFeF7t/UJ3TIzDlhY8auPCYjWiCmCZxubYLGJAfD1AWnZ+QVkLIQpQJbHZ7GoM0QblFhzxiIEI1f6H1YzySMy9cj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jLO5Zh8T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ydwOG+p8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jLO5Zh8T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ydwOG+p8"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298w9KB1359714
	for <dwarves@vger.kernel.org>; Mon, 9 Mar 2026 11:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oa83dVgxZq20oWReUlY9ZSn749F3qXF+3Vm+LV9g7CU=; b=
	jLO5Zh8TS+HfmVysUSxc/aLijm8j5a34iZzhB1sEivTOik8361DWqTL3Da9FLxt3
	s9i7V1NDOS+lC2wemhq+bJsPUrQRAZX4NQAXu0UfjCbOIbRVkfkAqdZnNAgS3ck3
	1dL5qscRUI3alhMyscoA9iYNJmaCgJRWJZh1DQLU4Fy+zEzSROwrK2eb5nBZCmgM
	U2Wbfd2EDL8+XivZxPSi0EUhtI9Ho60J4UopOhtnIzdLOiHJkA3oTsq+G7QF2bmz
	ZiCThCLVDwBOqUmBxtR4i/DTfZCl2ZOStTNoDPPRjPsoRfs++Q7PO3TyLE9prpcc
	XNI6ujI2PsouVixIGvxDvA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmma8jsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 09 Mar 2026 11:02:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 629AAE3e020291
	for <dwarves@vger.kernel.org>; Mon, 9 Mar 2026 11:02:48 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafchh95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 09 Mar 2026 11:02:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+Pm71uo0wl/6oY+J4eJtOu3bGORaCNQVYuVs2qlR3vY99STLGTKadKJNlVmkFeCNLvSUtYfD+AJpWRIt7r3HoBKI8QOrwj4NBOflfRge/JIGN6PTe89AYkJGlmRD4LME0g/Q31mPgLne84k/jtfmgtbYjvsVe563k9r7PKS9XCuL8btqQ1Cs6o+SdG5EvNRinpK6Xrq6Ns0q0XFvXgIL6t7vtSkF0aUyrEnuGgbdnAKt50NrBcHULen742zuLlmr4yk/zYb5HPN1N7IoBpSaoTQB3sA9ab40SkzINs5ARQbyKbJ+yVPeZzn1nSCBosZNxrBoCsLlytDcPKNe5pUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa83dVgxZq20oWReUlY9ZSn749F3qXF+3Vm+LV9g7CU=;
 b=Os+Uvr4FNpz5EfzBaIIF5sjra3LxYcniDAvBcLB30rcmIyQk/U1yYoHUZbCeGy/WNyiDTuDmp2M43txqhGrzNMRvykzZwcgIiCbAMNBZtHE/S83WxTo1TBvB8hBr1lL2LezDlYL8/T6taTsLHCcBpSPqvXScCJOlXfqFRZvwfLditpMioNAFdbW5LnQmwOR01lZYnRhI4GM5DRnMkwU2t2cUPoKg0T7g+nOxqNhTygtcwA1AeKTsB/XGKiDAp6r4xdqEGyT31eT6IcbexiS3paxQAUXD5gxil0RLP+1SCY8b2pm1dgXD8EqneHHomY0JtbUMozU3HpbC0Y1IqxmdQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa83dVgxZq20oWReUlY9ZSn749F3qXF+3Vm+LV9g7CU=;
 b=ydwOG+p8qgkfwGmI4b6w3WbU0Cwc4ccdaiHX1Adm5D6P/XuH5LVIte8oLTnOxrFC6kPfNmCLC/R0/21p6r4k/g93+PoFkdfb9UGWXBxzSWbqPMdbHWc/c7gik2oZ9bMgUKRWZoKNnS3waDNqVlceil0RjYUXvs19nLLPcbNslV4=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by PH3PPF8F9C59252.namprd10.prod.outlook.com (2603:10b6:518:1::7b7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 11:02:44 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 11:02:44 +0000
Message-ID: <c7dc28a4-847e-49d7-b3fc-04622e3cd0cd@oracle.com>
Date: Mon, 9 Mar 2026 11:02:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves] Refactor selftests
To: Bruce McCulloch <bruce.mcculloch@oracle.com>, dwarves@vger.kernel.org
Cc: elena.zannoni@oracle.com
References: <20260305004846.1369028-2-bruce.mcculloch@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260305004846.1369028-2-bruce.mcculloch@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|PH3PPF8F9C59252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3cf446-001f-4d61-48e9-08de7dcb63db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	ZlhmtI5PSlhiJWwPpegWT87cfScpAO+ONbogEHe/lJLD6NJCmBXME8PECSrTlunZuciCTCGwBkPOidwVMis9OIijX8I8pf0MFVrNQcnnJu3sMUfqs0EkmCPMvoefPqjoxNZjdI7ThvND8R0989IXK6jnHh2huy6cU8mfaoyTZtxHekAh1lGAXDHONIEGcj3axiZLtjIp7CTpDskk8IyyDDj/Qw1EmBYf2zUsI+Nb6Nbi/G0bGG6RDX3z3A3U9aSfUoO2xzLVJMsG3xFdaz7f24Wc35aM6ZNAVTP8OLLe0moiSIPFuu1bA5am/cug3s/pVMbIP1Jdlfx0RPU+/bPyX/u60bfpQLwCc5gl1slYe27HFsaQwZlno5NPnGI7tlRUCxKP52egftrKATA//3lgxsOu52kpzx7TYdGqh9r3AunoRnzlrb+SmijeVmrghweXZ7cIqdba/610Xa0s3PfVPIFlImnNBB8scEhm1S6tpzTTzlOuJ8JgZb15jy/UiZWyMScdB+d9CNhEYbcjLRebNkCP8FaJqbu6tTBN3vHFl47HYkQTtsXSN6OZ0qsr27fd+SLXDMl9i4r+1pkgi3JL3qZCgXKl7BE1s/y/H8zGs6mCrkk2pMHb6ZqqnbCjbPTZQSQEc6xH7L3m8mG9ZLEwyvM3eVXd0iZVFcTUGObYC7QG5Uw4ujN7cnVugYQzN7uQnVVl5zJWVKFasWyI0VJIeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUV1NWk4SjZJTCtmQlVoSk14cGlSMytlS05QU2QxNFFrSnBLTGt3dFQwS1VY?=
 =?utf-8?B?VXVUN0YrcHUrK2ZxakRVSHY3dXQxUEpXV25yMTBLMnRTTkxQVW55cEp5U0gv?=
 =?utf-8?B?a3Fsakh3N0oyQndsZnN4TWJZWnlyNmVsSjNnUVRpbjI1eXRjVGZ6N1FnaUNU?=
 =?utf-8?B?ZXlCRnRJbkZXTUx5TXpMTnlBcG96aGRZeHFEOWdtT0RKSFRvWGs3aGE1dlJr?=
 =?utf-8?B?WGk3RTZtQXpGb2MvbjV5UDBZWWRoNE1yT3gvVXR0aW90dTRmaFhlYnRhZGlh?=
 =?utf-8?B?V0kvK3RZYVh0Wk84eituSXNlQ2EyZXdUcXFuWC8zY1l1alRLb0ozSlA1cEFG?=
 =?utf-8?B?WDJwcy9sOVkyUzRtYytrQU5lNWI4MGJwc0FlOGhNMytERENMR1NVcktxc3E4?=
 =?utf-8?B?ZlhFZlV6bUMwM3UzSVRYMHhsUTluQU05WWxQRXkvMmVtK2R3OW5EQ1FEZzBB?=
 =?utf-8?B?cGo2ZTB1R3RGcGljSGR1R01KMWxGS2kzVTE0cXdYUml3YnMvNkhDUjhwZTdF?=
 =?utf-8?B?NDRMUEdKdXZLNFRMbWJDOVYwODQwM09VbldlN0VEandFNVJ2VTBDcDdJQ1pH?=
 =?utf-8?B?ZnNlR3FTdnJCYzFLbW1hSWpkQnBrR2J0UlRsbWFINkY5amdrc3RzL204RHMz?=
 =?utf-8?B?a01ZZDBaZkZZZExQTVRKZXdtWndNaXUybjV0T1o0Z3NFK0Uzb0ErZjg4cTE1?=
 =?utf-8?B?YVdaM3pXa3RBblc1b3AzTDZRT21TUCtoeDk1b1ZJckllUnY2N0VjclA1MTRl?=
 =?utf-8?B?TUlsQjNrUUFLTFBsVmFnN1l3NUUzanZQa2o1L1lFSTV2VTJEeVdjd2VpdDVS?=
 =?utf-8?B?T2IyTG1GWUtLVko0U3htejZ2bzU3eTJtdTNDUCtVendHaFdtNVdyRDhzWUZD?=
 =?utf-8?B?V3M3K1RVR0Z3TmVYdEpsOUJuTXUreDNpMXZXbWZGY1dFeXhXeXhSOGU0TTh4?=
 =?utf-8?B?Z09EdkdIV0I4cWt5Sit0L0tXVG1Ia0FheHJwK3dRcFlqRXdUY1hRM2pUaVRI?=
 =?utf-8?B?YVVvUENHSjdpb2FFdzk3UzV5a0E2M1RNNlJBL2ZwRUlWSDI0NFB6UHZiRTRP?=
 =?utf-8?B?VmR3Qk0xcnlqZ3VpdjNLMWx2WXRwaktSbXR4aWlha2FSWkYzR05FNUp4M0oz?=
 =?utf-8?B?NlBIMlRHZlNNdU5ZS2d3YWEyNng4Y0RNS3R3YmJacEJlNE5mMUhmdlVEWjFI?=
 =?utf-8?B?NHZoMUYvOVJRKzZJTkIrUyt0N0x3c1lWY3BqUW9scTRmMEM5V0pSZDh2bERB?=
 =?utf-8?B?bmF5dDcyTnViZVVCRGIyVHhUdXNPZk5IdURYREJFVHgvWmhablJ0bEdIdFlF?=
 =?utf-8?B?UFRyZ3I3U1d1ZFBjNWpiVHRCRWxBdG1wUkxUMmNXeFd5VFJyb0Q5K3ZnL1JM?=
 =?utf-8?B?ek96UUJmbWhKR01ZM0x4Y1RLRUYwdzJDK1NuL1hnNHRzSlVJRk4wcTJyWDUy?=
 =?utf-8?B?MURJZ3VPZmNodDBSVjRUNjM0N1pRS1Fyb1hZM0VZYzlVcFprR2xMRnpFd1hL?=
 =?utf-8?B?Z3pEMzhxTkVpbE1kVFJNZlhOSytuL2d2ZytHVzVha0ZLRnF6N282UHdXTHZ5?=
 =?utf-8?B?YytkbWNraHF5VmZMMGxyS1RReVd1OGRqZDM2ZTZxR1kxOWhJZnFaU3dHNmNJ?=
 =?utf-8?B?UGV3bk5NL09VU1ZVQy9ONS83QnpnY3gwdHA2MXp4R0JLZkZKKzZUc0VDRVBL?=
 =?utf-8?B?OUlCMGtRTGZUZkdzaHBYWlZyZ1BMR3VMTi9MTmJHSW9VMGkwMm1VM0JYdHBw?=
 =?utf-8?B?T2pIcjZiLy9iSkFxUUtmeUNNL3llblRCOFpFMU1TY3ZwMGROVEtzL2RMNElt?=
 =?utf-8?B?aGlNdGZ0R2tmZGl3VEFaN0FZSFByZU90SFpHSVBwSy91V0haNm9IZUtZVnJs?=
 =?utf-8?B?b1NKMStzcnl0QVFZMUpnTmN0LzJ1VGJqMDFtYkFwZExsZklpMFd6VUxaRmZ5?=
 =?utf-8?B?dGtnSUdpUkU0cVVYNTVtSFJOR0I5czdWQzhYUnBVSmdMSFVPVTFSNUswTEIx?=
 =?utf-8?B?ZHgrVm9PLzhuZEJLNFIreVFva0hjaGtNemRtWExxSVlzN1RnK2JyNFg2OGll?=
 =?utf-8?B?YjVBT0tvZ05iNmJpZWRRcFhqSkNSMkZVUlN4RVd3ZmJEZytFQzNIOE9aNnBx?=
 =?utf-8?B?c0JrWkhILy80S1o2a1NNQS9keWtDRVVsaUJvb3ZselUyNFhHMmtzcVRSeGdJ?=
 =?utf-8?B?UzBKaFB3K2F1QjQvaXQyTk1wZHVqZ1Y5cWoxYWNDVWwrSWN4RTNlMnJ5R1Ix?=
 =?utf-8?B?ODdhZVdrVnVWQnBIaUVTS0tUek52cVZOc3N4NUVJajBSaFFHSGhiRFhjSDRo?=
 =?utf-8?B?ak40eVNSQjVnc09md244N3NtenFEMWxSTmF5MlZEODVvVW13Wk9HZz09?=
X-Exchange-RoutingPolicyChecked:
	UyfhTaMvXLXunQbQVYfzvi228rhPW7djcj4+FsxtQjkGpg0yqQQbAmUmo/S0AbvKayUeFIWKLoW2c/cwZeVzeMlXtwKNzcnskfepHooWnQdM/R3rqdsojyNfMDNI514J6CV2yZXNyxSWv/T/7nV10cGBP46wEbC7o4mGIyf9usbbFfci4R9EHxG0p9Gxt5LlDTbE7FK68frwx2lA5Quza69uY2w0MnrLHO7ccxFhppsbqhHUe75Y5wvK2Xqffjx26xWw49XuxuvqXrTdq+RIHVeUBOcfQ5sRlQy3tAkBXfGUqFJ6gRIwzv5UYil7l9AlzgaPJiJuK5bPd1Y9Xz+wEA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xQgyGbhnMTRxuRfMIUlfSFA7gwAusbQxX4JoZuisyGbznDE4jKaaEuqD56oTOpyopxLjuzdf0PiFhrMOR0BIXLo5fjO7IpsTf5bYvaazGg/r6+ZyX9QNuHwm9r8DukXfTO4BmSfBa+xGAVJPxnj+r0A1HUpPwxbISYFOZmhgUlIO3blrZnokY0EE66Fi0xoMZ5NPFvFo49JolvgjuxllCAjovZKZvMKTimM96jSZfYNfKokcwFF1yDy18EF9kY3PAgfdoS/H+bYe+E4e6JiQfdWm9A3m67fAmUWzsHmkahrW85lgLPbT9ebXqM1M7da1t2S2MW+tOxDQon2Bf+3bREOChxsbIUM7JMdCGkTvfE4CSdirG4tu+aBVUjqLnh6wwgNx1+FPAlhVP/+uM+XykyMRWS8OXwplcuqwfUq4DwcOWMZ5Ef5FyP/dHoB//If+BsX4B2fu/t8MsywKu3OoIuBYKlL1aBwY21ekl0rvtbL3ndjOkHH556bRS4z5Mc93q/9QlmtinwRj0NT8I1zAoCz3nhUG9nH4J6SmdRcknfYf7Rg9wRUZzFIPONFjanWEnXyd4a1Q+4z4XLb+jwdXAxSHPZ24ulOLO6/PvYb+V+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3cf446-001f-4d61-48e9-08de7dcb63db
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 11:02:44.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LossRR9mjmV648RSFTXSMav2ecQHNCdzWwghATwrQUTZ0IBYj2EDTlbLFnKCVsKX1wd2zpOZVCmgFvPZpCiHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8F9C59252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090101
X-Proofpoint-GUID: EaxwR5wXrjryhjHrZyKsK9OUEw7UlwLt
X-Proofpoint-ORIG-GUID: EaxwR5wXrjryhjHrZyKsK9OUEw7UlwLt
X-Authority-Analysis: v=2.4 cv=U5efzOru c=1 sm=1 tr=0 ts=69aea8da b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=05qCKGapzYylp2sgVB8A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12266
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEwMiBTYWx0ZWRfX7RE3O1xp5JCx
 JCMuKXluFgZFd+p6L2R/xJ7OlK3WaF24gUfe5PP1s+otyVpuMH+LDtX0JvclXuW2j9ePZ0X1xz0
 YfKKDtgQJWSRaHpZYHLCxTvOr7300ULnFzRxqU5OnqJcv0hzTXFGHVXtQron0Qg529Z9+CLdT2V
 ST6bGnYtML3cSs+6mUVO3eJAjvZYanfWgeZaxypnoZYr56VxQJzw6pm1KC+KLH9c07OwG1n2+7L
 GZEe9cvmm132bCQoOQr4tseMiagTjfqSzxuwqkdQFJHVfxZD3SmWZuZkR6LqqQr19CIfcVbyUYl
 l+q0NxDAwOPUGYQqK6PBfUIhawe8NiNGAzZanQnZAfU25CTXch1YUDom1dkiSK4VoEWV+dBUFML
 4xOVACGnuCYpSHqTsm3fqTWu4x7ZNEEA4Hwt+3AA6MrGEmcwp4u59YsdAtD5ygxzwOXLOBZLPtm
 b2MUsmYqvcvG1tUtJcwCn5ailDtfAaPtg8gsOPZA=

On 05/03/2026 00:48, Bruce McCulloch wrote:
> Hello,
> 
> Here is a v2 of the patch I sent the other day that corrects the issues
> with exit codes as well as allowing the new test_lib.sh to run with
> non-bash interpreters. I have tested this with the github CI and it
> works as expected. Please let me know if there is anything else that
> needs to change.
>

sorry, missed something last time. Running the tests I see inconsistent
output for test 4:

...
2: default_vmlinux_btf.sh
Default BTF on a system without BTF.
Soft failures: 1
Test ./default_vmlinux_btf.sh passed
---
3: flexible_arrays.sh
Flexible arrays accounting.
Test ./flexible_arrays.sh passed
---
4: gcc_true_signatures.sh
Validation of BTF encoding of true_signatures: Ok
---
5: pfunct-btf-decl-tags.sh
Check that pfunct can print btf_decl_tags read from BTF.
Test ./pfunct-btf-decl-tags.sh passed
---



I think we need to update


tests/gcc_true_signatures.sh

The github.com/acmel/dwarves repo has not yet been synced with the
official repo at

https://git.kernel.org/pub/scm/devel/pahole/pahole.git

so you may not have seen that file as a result.

If you could resync with the master branch of pahole.git and
apply the refactoring to gcc_true_signatures.sh that would
be great. Thanks!


> Bruce
> 
> ---
> 
> Simple refactoring of the testsuite with the creation of a shared
> library (tests/test_lib.sh).
> Additions include:
> * Getters to find vmlinux.
> * Functions to open tmp dirs and tmp files.
> * Functions to automatically clean tmp dirs and files on pass.
> * On fail, tmp dirs are preserved.
> * Functions to pass/fail/skip/softfail tests (works with CI).
> * Logging functions with varying verbosity levels.
> * Compatible with non-bash interpreters (for perf tests).
> * Colors.
> 
> Signed-off-by: Bruce McCulloch <bruce.mcculloch@oracle.com>
> ---
>  tests/btf_functions.sh        | 143 ++++++++++-----------------
>  tests/default_vmlinux_btf.sh  |  18 ++--
>  tests/flexible_arrays.sh      |  48 +++++-----
>  tests/pfunct-btf-decl-tags.sh |  34 +++----
>  tests/prettify_perf.data.sh   |  51 +++++-----
>  tests/reproducible_build.sh   |  47 ++++-----
>  tests/test_lib.sh             | 176 ++++++++++++++++++++++++++++++++++
>  tests/tests                   |  28 +++---
>  8 files changed, 345 insertions(+), 200 deletions(-)
>  create mode 100755 tests/test_lib.sh
> 
> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
> index ee0f9ff..127640e 100755
> --- a/tests/btf_functions.sh
> +++ b/tests/btf_functions.sh
> @@ -8,45 +8,22 @@
>  # also should have been.
>  #
>  
> -outdir=
> -
> -fail()
> -{
> -	# Do not remove test dir; might be useful for analysis
> -	trap - EXIT
> -	if [[ -d "$outdir" ]]; then
> -		echo "Test data is in $outdir"
> -	fi
> -	exit 1
> -}
> -
> -cleanup()
> -{
> -	rm ${outdir}/*
> -	rmdir $outdir
> -}
> -
> -vmlinux=${vmlinux:-$1}
> -
> -if [ -z "$vmlinux" ] ; then
> -	vmlinux=$(pahole --running_kernel_vmlinux)
> -	if [ -z "$vmlinux" ] ; then
> -		echo "Please specify a vmlinux file to operate on"
> -		exit 2
> -	fi
> -fi
> +source test_lib.sh
>  
> -if [ ! -f "$vmlinux" ] ; then
> -	echo "$vmlinux file not available, please specify another"
> -	exit 2
> +vmlinux=$(get_vmlinux $1)
> +if [ $? -ne 0 ] ; then
> +	info_log "$vmlinux"
> +	test_fail
>  fi
>  
> -outdir=$(mktemp -d /tmp/btf_functions.sh.XXXXXX)
> +outdir=$(make_tmpdir)
>  
> +# Comment this out to save test data.
>  trap cleanup EXIT
>  
> -echo -n "Validation of BTF encoding of functions; this may take some time: "
> -test -n "$VERBOSE" && printf "\nEncoding..."
> +title_log "Validation of BTF encoding of functions."
> +info_log "This may take some time."
> +verbose_log "Encoding..."
>  
>  # Here we use both methods so that we test pahole --lang_exclude, that is
>  # used in the Linux kernel BTF encoding phase, and as well to make sure all
> @@ -57,7 +34,7 @@ export PAHOLE_LANG_EXCLUDE=rust
>  pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |\
>  	grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
>  
> -test -n "$VERBOSE" && printf "done.\n"
> +verbose_log "done."
>  
>  funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf 2>/dev/null|sort)
>  
> @@ -87,8 +64,8 @@ while IFS= read -r btf ; do
>  			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
>  				const_insensitive=$((const_insensitive+1))
>  			else
> -				echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> -				fail
> +				error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> +				test_fail
>  			fi
>  		else
>  			inline=$((inline+1))
> @@ -98,13 +75,11 @@ while IFS= read -r btf ; do
>  	fi
>  done < $outdir/btf.funcs
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Matched $exact functions exactly."
> -	echo "Matched $inline functions with inlines."
> -	echo "Matched $const_insensitive functions with multiple const/non-const instances."
> -	echo "Ok"
> -	echo "Validation of skipped function logic..."
> -fi
> +verbose_log "Matched $exact functions exactly."
> +verbose_log "Matched $inline functions with inlines."
> +verbose_log "Matched $const_insensitive functions with multiple const/non-const instances."
> +verbose_log "Ok"
> +verbose_log "Validation of skipped function logic..."
>  
>  skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{ print $1}')
>  
> @@ -113,16 +88,14 @@ for s in $skipped_fns ; do
>  	# Ensure the skipped function are not in BTF
>  	inbtf=$(grep " $s(" $outdir/btf.funcs)
>  	if [[ -n "$inbtf" ]]; then
> -		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> -		fail
> +		error_log "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> +		test_fail
>  	fi
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Skipped encoding $skipped_cnt functions in BTF."
> -	echo "Ok"
> -	echo "Validating skipped functions have incompatible return values..."
> -fi
> +verbose_log "Skipped encoding $skipped_cnt functions in BTF."
> +verbose_log "Ok"
> +verbose_log "Validating skipped functions have incompatible return values..."
>  
>  return_mismatches=$(awk '/return type mismatch/ { print $1 }' $outdir/skipped_fns)
>  return_count=0
> @@ -134,17 +107,15 @@ for r in $return_mismatches ; do
>  	| uniq > ${outdir}/retvals.$r
>  	cnt=$(wc -l ${outdir}/retvals.$r | awk '{ print $1 }')
>  	if [[ $cnt -lt 2 ]]; then
> -		echo "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
> -		fail
> +		error_log "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
> +		test_fail
>  	fi
>  	return_count=$((return_count+1))
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Found $return_count functions with multiple incompatible return values."
> -	echo "Ok"
> -	echo "Validating skipped functions have incompatible params/counts..."
> -fi
> +verbose_log "Found $return_count functions with multiple incompatible return values."
> +verbose_log "Ok"
> +verbose_log "Validating skipped functions have incompatible params/counts..."
>  
>  param_mismatches=$(awk '/due to param / { print $1 }' $outdir/skipped_fns)
>  
> @@ -169,10 +140,8 @@ for p in $param_mismatches ; do
>  		if [[ -n "$inlined" ]]; then
>  			multiple_inline=$((multiple_inline+1))
>  		else
> -			if [[ -n "$VERBOSE" ]]; then
> -				echo "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
> -				echo "Full skip message from pahole: $skipmsg"
> -			fi
> +			verbose_log "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
> +			verbose_log "Full skip message from pahole: $skipmsg"
>  			warnings=$((warnings+1))
>  		fi
>  	else
> @@ -180,24 +149,22 @@ for p in $param_mismatches ; do
>  	fi
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Found $multiple instances with multiple instances with incompatible parameters."
> -	echo "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
> -	echo "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
> -	echo "Found $warnings instances where pfunct did not notice inconsistencies."
> -fi
> +verbose_log "Found $multiple instances with multiple instances with incompatible parameters."
> +verbose_log "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
> +verbose_log "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
> +verbose_log "Found $warnings instances where pfunct did not notice inconsistencies."
>  
>  # Some specific cases can not  be tested directly with a standard kernel.
>  # We can use the small binary in bin/ to test those cases, like packed
>  # structs passed on the stack.
>  
> -test -n "$VERBOSE" && echo -n "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
> +verbose_log "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
>  
> -test -n "$VERBOSE" && printf "\nBuilding test_bin..."
> +verbose_log "Building test_bin..."
>  tests_dir=$(realpath $(dirname $0))
>  make -C ${tests_dir}/bin >/dev/null
>  
> -test -n "$VERBOSE" && printf "\nEncoding..."
> +verbose_log "Encoding..."
>  pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/test_bin.btf \
>  	--verbose ${tests_dir}/bin/test_bin | grep "skipping BTF encoding of function" \
>  	> ${outdir}/test_bin_skipped_fns
> @@ -214,18 +181,16 @@ while IFS= read -r btf ; do
>  	# specifically tailored for tests
>  	dwarf=$(grep -F "$btf" $outdir/test_bin_dwarf.funcs)
>  	if [[ "$btf" != "$dwarf" ]]; then
> -		echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> -		fail
> +		error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> +		test_fail
>  	else
>  		exact=$((exact+1))
>  	fi
>  done < $outdir/test_bin_btf.funcs
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Matched $exact functions exactly."
> -	echo "Ok"
> -	echo "Validation of skipped function logic..."
> -fi
> +verbose_log "Matched $exact functions exactly."
> +verbose_log "Ok"
> +verbose_log "Validation of skipped function logic..."
>  
>  skipped_cnt=$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}')
>  
> @@ -234,16 +199,14 @@ for s in $skipped_fns ; do
>  	# Ensure the skipped function are not in BTF
>  	inbtf=$(grep " $s(" $outdir/test_bin_btf.funcs)
>  	if [[ -n "$inbtf" ]]; then
> -		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> -		fail
> +		error_log "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> +		test_fail
>  	fi
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Skipped encoding $skipped_cnt functions in BTF."
> -	echo "Ok"
> -	echo "Validating skipped functions have uncertain parameter location..."
> -fi
> +verbose_log "Skipped encoding $skipped_cnt functions in BTF."
> +verbose_log "Ok"
> +verbose_log "Validating skipped functions have uncertain parameter location..."
>  
>  uncertain_loc=$(awk '/due to uncertain parameter location/ { print $1 }' $outdir/test_bin_skipped_fns)
>  legitimate_skip=0
> @@ -266,12 +229,10 @@ for f in $uncertain_loc ; do
>  			fi
>  		fi
>  	done
> -	echo "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
> -	fail
> +	error_log "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
> +	test_fail
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
> -fi
> -echo "Ok"
> -exit 0
> +verbose_log "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
> +
> +test_pass
> diff --git a/tests/default_vmlinux_btf.sh b/tests/default_vmlinux_btf.sh
> index a855ca7..496e840 100755
> --- a/tests/default_vmlinux_btf.sh
> +++ b/tests/default_vmlinux_btf.sh
> @@ -1,6 +1,7 @@
>  #!/bin/bash
> +source test_lib.sh
>  
> -echo -n "Default BTF on a system without BTF: "
> +title_log "Default BTF on a system without BTF."
>  
>  ulimit -c 0
>  
> @@ -13,8 +14,7 @@ ulimit -c 0
>  nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole -F btf list_head 2>&1 | wc -l)
>  
>  if [ $nr_lines -eq 0 ] ; then
> -	echo "FAILED"
> -	exit 1
> +	test_softfail
>  fi
>  
>  # There is also the case where no debugging info is available, be it DWARF of
> @@ -22,11 +22,15 @@ fi
>  # that as well
>  #
>  nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole 2>&1 | wc -l)
> +nr_lines=0
>  
>  if [ $nr_lines -eq 0 ] ; then
> -	echo "FAILED"
> -	exit 1
> +	test_softfail
>  fi
>  
> -echo "Ok"
> -exit 0
> +check_softfail
> +if [ $? -eq 2 ] ; then
> +	test_fail
> +else
> +	test_pass
> +fi
> \ No newline at end of file
> diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
> index 59fa38e..4e9e995 100755
> --- a/tests/flexible_arrays.sh
> +++ b/tests/flexible_arrays.sh
> @@ -5,22 +5,23 @@
>  #
>  # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
>  
> -vmlinux=${vmlinux:-$1}
> +source test_lib.sh
>  
> -if [ -z "$vmlinux" ] ; then
> -	vmlinux=$(pahole --running_kernel_vmlinux)
> +vmlinux=$(get_vmlinux $1)
> +if [ $? -ne 0 ] ; then
> +	info_log "$vmlinux"
> +	test_fail
>  fi
>  
> -if [ ! -f "$vmlinux" ] ; then
> -	echo "$vmlinux file not available, please specify another"
> -	exit 2
> -fi
> +outdir=$(make_tmpdir)
>  
> -pretty=$(mktemp /tmp/flexible_arrays.data.sh.XXXXXX.c)
> +# Comment this out to save test data.
> +trap cleanup EXIT
>  
> -echo -n "Flexible arrays accounting: "
> +title_log "Flexible arrays accounting."
>  
>  for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux | cut -f1) ; do
> +	pretty=$(make_tmpsrc)
>  	pahole $struct $vmlinux > $pretty
>  
>  	# We need to check for just one tab before the comment as when expanding unnamed
> @@ -48,30 +49,27 @@ for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux |
>  	[ -z "$stat_nr_flexible_arrays" ] && stat_nr_flexible_arrays=0
>  	stat_nr_embedded_flexible_arrays=$(grep "flexible array members:.*middle:" $pretty | sed -r 's/.*middle: *([[:digit:]]+).*/\1/g')
>  	[ -z "$stat_nr_embedded_flexible_arrays" ] && stat_nr_embedded_flexible_arrays=0
> -	test -n "$VERBOSE" && echo "end: $struct: $nr_flexible_arrays $stat_nr_flexible_arrays"
> -	test -n "$VERBOSE" && echo "middle: $struct: $nr_embedded_flexible_arrays $stat_nr_embedded_flexible_arrays"
> +	verbose_log "end: $struct: $nr_flexible_arrays $stat_nr_flexible_arrays"
> +	verbose_log "middle: $struct: $nr_embedded_flexible_arrays $stat_nr_embedded_flexible_arrays"
>  
>  	if [ "$nr_embedded_flexible_arrays" != "$stat_nr_embedded_flexible_arrays" ] ; then
> -		test -n "$VERBOSE" && printf "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
> +		verbose_log "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
>  			"$struct" "$stat_nr_embedded_flexible_arrays" "$nr_embedded_flexible_arrays"
> -		test -n "$VERBOSE" && pahole $struct $vmlinux
> -		FAILED=1
> +		verbose_log pahole $struct $vmlinux
> +		test_softfail
>  	fi
>  
>  	if [ "$nr_flexible_arrays" != "$stat_nr_flexible_arrays" ] ; then
> -		test -n "$VERBOSE" && printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
> +		verbose_log printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
>  			"$struct" "$stat_nr_flexible_arrays" "$nr_flexible_arrays"
> -		test -n "$VERBOSE" && pahole $struct $vmlinux
> -		FAILED=1
> +		verbose_log pahole $struct $vmlinux
> +		test_softfail
>  	fi
> -
> -	rm -f $pretty
>  done
>  
> -if [ -n "$FAILED" ] ; then
> -	echo "FAILED"
> -	exit 1
> +check_softfail
> +if [ $? -ne 0 ] ; then
> +	test_fail
> +else
> +	test_pass
>  fi
> -
> -echo "Ok"
> -exit 0
> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
> index 69babef..35884b4 100755
> --- a/tests/pfunct-btf-decl-tags.sh
> +++ b/tests/pfunct-btf-decl-tags.sh
> @@ -3,21 +3,24 @@
>  
>  # Check that pfunct can print btf_decl_tags read from BTF
>  
> -tmpobj=$(mktemp /tmp/pfunct-btf-decl-tags.sh.XXXXXX.o)
> +source test_lib.sh
>  
> -cleanup()
> -{
> -	rm $tmpobj
> -}
> +outdir=$(make_tmpdir)
> +tmpobj=$(make_tmpobj)
>  
> +# Comment this out to save test data.
>  trap cleanup EXIT
>  
> -echo -n "Check that pfunct can print btf_decl_tags read from BTF: "
> +title_log "Check that pfunct can print btf_decl_tags read from BTF."
> +
> +# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
> +# in upstream version 16.
> +# UPTODO: add a check here for that.
>  
>  CLANG=${CLANG:-clang}
>  if ! command -v $CLANG > /dev/null; then
> -	echo "Need clang for test $0"
> -	exit 1
> +	error_log "Need clang for test $0"
> +	test_fail
>  fi
>  
>  (cat <<EOF
> @@ -55,13 +58,12 @@ out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
>  d=$(diff -u <(echo "$expected") <(echo "$out"))
>  
>  if [[ "$d" == "" ]]; then
> -	echo "Ok"
> -	exit 0
> +	test_pass
>  else
> -	echo "pfunct output does not match expected:"
> -	echo "$d"
> -	echo
> -	echo "Complete output:"
> -	echo "$out"
> -	exit 1
> +	error_log "pfunct output does not match expected:"
> +	info_log "$d"
> +	info_log
> +	info_log "Complete output:"
> +	info_log "$out"
> +	test_fail
>  fi
> diff --git a/tests/prettify_perf.data.sh b/tests/prettify_perf.data.sh
> index 2d16cf5..1fae951 100755
> --- a/tests/prettify_perf.data.sh
> +++ b/tests/prettify_perf.data.sh
> @@ -7,30 +7,35 @@
>  # Check if the perf binary is available, if it is from a distro, normally it
>  # will get the needed DWARF info using libddebuginfod, we'll check if the
>  # needed types are available, skipping the test and informing the reason.
> +. ./test_lib.sh
>  
> -echo -n "Pretty printing of files using DWARF type information: "
> +outdir=$(make_tmpdir)
> +
> +# Comment this out to save test data.
> +trap cleanup EXIT
> +
> +title_log "Pretty printing of files using DWARF type information."
>  
>  perf=$(which perf 2> /dev/null)
>  if [ -z "$perf" ] ; then
> -	echo "skip: No 'perf' binary available"
> -	exit 2
> +	info_log "skip: No 'perf' binary available"
> +	test_skip
>  fi
>  
>  perf_lacks_type_info() {
>  	local type_keyword=$1
>  	local type_name=$2
>  	if ! pahole -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
> -		echo "skip: $perf doesn't have '$type_keyword $type_name' type info"
> -		return 1
> +		info_log "skip: $perf doesn't have '$type_keyword $type_name' type info"
> +		test_skip
>  	fi
> -	return 0
>  }
>  
> -perf_data=$(mktemp /tmp/prettify_perf.data.sh.XXXXXX.perf.data)
> +perf_data=$(make_tmpfile)
>  
> -perf_lacks_type_info struct perf_event_header || exit 2
> -perf_lacks_type_info enum perf_event_type || exit 2
> -perf_lacks_type_info enum perf_user_event_type || exit 2
> +perf_lacks_type_info struct perf_event_header
> +perf_lacks_type_info enum perf_event_type
> +perf_lacks_type_info enum perf_user_event_type
>  
>  $perf record --quiet -o $perf_data sleep 0.00001
>  
> @@ -46,21 +51,23 @@ check_expected_number_of_filtered_perf_record_metadata() {
>  	local nr_records=$(number_of_filtered_perf_record_metadata $metadata_record)
>  
>  	if [ "$nr_records" != "$expected_records" ] ; then
> -		echo "FAIL: expected $expected_records PERF_RECORD_$metadata_record metadata records, got $nr_records"
> -		return 1;
> +		error_log "FAIL: expected $expected_records PERF_RECORD_$metadata_record metadata records, got $nr_records"
> +		test_softfail
>  	fi
> -	return 0
>  }
>  
> -check_expected_number_of_filtered_perf_record_metadata COMM 2 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata EXIT 1 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata TIME_CONV 1 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata THREAD_MAP 1 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata CPU_MAP 1 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata FINISHED_INIT 1 || exit 1
> +check_expected_number_of_filtered_perf_record_metadata COMM 2
> +check_expected_number_of_filtered_perf_record_metadata EXIT 1
> +check_expected_number_of_filtered_perf_record_metadata TIME_CONV 1
> +check_expected_number_of_filtered_perf_record_metadata THREAD_MAP 1
> +check_expected_number_of_filtered_perf_record_metadata CPU_MAP 1
> +check_expected_number_of_filtered_perf_record_metadata FINISHED_INIT 1
>  
>  # XXX write more tests that look at the events contents, not just for the presence of a known number of them
>  
> -echo "Ok"
> -
> -rm -f $perf_data
> +check_softfail
> +if [ $? -ne 0 ] ; then
> +	test_fail
> +else
> +	test_pass
> +fi
> diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
> index a940d93..d8c6507 100755
> --- a/tests/reproducible_build.sh
> +++ b/tests/reproducible_build.sh
> @@ -4,22 +4,22 @@
>  # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
>  # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
>  
> -vmlinux=${vmlinux:-$1}
> +source test_lib.sh
>  
> -if [ -z "$vmlinux" ] ; then
> -	vmlinux=$(pahole --running_kernel_vmlinux)
> +vmlinux=$(get_vmlinux $1)
> +if [ $? -ne 0 ]; then
> +	info_log "$vmlinux"
> +	test_fail
>  fi
>  
> -if [ ! -f "$vmlinux" ] ; then
> -	echo "$vmlinux file not available, please specify another"
> -	exit 2
> -fi
> +outdir=$(make_tmpdir)
>  
> -outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
> +# Comment this out to save test data.
> +trap cleanup EXIT
>  
> -echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
> +title_log "Parallel reproducible DWARF Loading/Serial BTF encoding."
>  
> -test -n "$VERBOSE" && printf "\nserial encoding...\n"
> +verbose_log "Begin serial encoding..."
>  
>  # This will make pahole and pfunct to skip rust CUs
>  export PAHOLE_LANG_EXCLUDE=rust
> @@ -30,37 +30,32 @@ bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinu
>  nr_proc=$(getconf _NPROCESSORS_ONLN)
>  
>  for threads in $(seq $nr_proc) ; do
> -	test -n "$VERBOSE" && echo $threads threads encoding
> +	verbose_log "$threads threads encoding"
>  	pahole -j$threads --btf_features=default,reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
>  	pahole=$!
>  	# HACK: Wait a bit for pahole to start its threads
> -	sleep 0.3s
> +	sleep 1s
>  	# PID part to remove ps output headers
>  	nr_threads_started=$(ps -L -C pahole | grep -v PID | wc -l)
> -        ((nr_threads_started -= 1)) # main thread doesn't count, it waits to join
> +		((nr_threads_started -= 1)) # main thread doesn't count, it waits to join
>  
>  	if [ $threads != $nr_threads_started ] ; then
> -		echo "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
> -		exit 1;
> +		error_log "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
> +		test_fail
>  	fi
>  
>  	# ps -L -C pahole | grep -v PID | nl
> -	test -n "$VERBOSE" && echo $nr_threads_started threads started
> +	verbose_log "$nr_threads_started threads started"
>  	wait $pahole
>  	rm -f $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
>  	bpftool btf dump file $outdir/vmlinux.btf.parallel.reproducible > $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
> -	test -n "$VERBOSE" && echo "diff from serial encoding:"
> +	verbose_log "diff from serial encoding:"
>  	diff -u $outdir/bpftool.output.vmlinux.btf.serial $outdir/bpftool.output.vmlinux.btf.parallel.reproducible > $outdir/diff
>  	if [ -s $outdir/diff ] ; then
> -		echo "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
> -		exit 1
> +		error_log "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
> +		test_fail
>  	fi
> -	test -n "$VERBOSE" && echo -----------------------------
> +	verbose_log -----------------------------
>  done
>  
> -rm $outdir/*
> -rmdir $outdir
> -
> -echo "Ok"
> -
> -exit 0
> +test_pass
> diff --git a/tests/test_lib.sh b/tests/test_lib.sh
> new file mode 100755
> index 0000000..8c235da
> --- /dev/null
> +++ b/tests/test_lib.sh
> @@ -0,0 +1,176 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2026, Oracle and/or its affiliates.
> +#
> +# Common helper functions for the testsuite.
> +#
> +
> +# if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
> +# 	echo "This script is meant to be sourced. Please use 'source test_lib.sh'."
> +# 	exit 1
> +# fi
> +
> +check_color_support()
> +{
> +	if [ ! -z "$color_support" ] ; then
> +		return $color_support
> +	else
> +		if tput colors >/dev/null 2>&1; then
> +			num_colors=$(tput colors)
> +			if [ $num_colors -gt 0 ] && [ -n "$BASH_VERSION" ] ; then
> +				RED='\033[0;31m'
> +				GREEN='\033[0;32m'
> +				YELLOW='\033[0;33m'
> +				NC='\033[0m'
> +				color_support=1
> +			else
> +				RED=''
> +				GREEN=''
> +				YELLOW=''
> +				NC=''
> +				color_support=0
> +			fi
> +		else
> +			RED=''
> +			GREEN=''
> +			YELLOW=''
> +			NC=''
> +			color_support=0
> +		fi
> +	fi
> +	return $color_support
> +}
> +
> +color_print()
> +{
> +	check_color_support
> +	if [ $? -eq 1 ] ; then
> +		echo -e "$1$2${NC}"
> +	else
> +		echo $1
> +	fi
> +}
> +
> +get_vmlinux()
> +{
> +	
> +	vmlinux=${vmlinux:-$1}
> +
> +	if [ -z "$vmlinux" ] ; then
> +		vmlinux=$(pahole --running_kernel_vmlinux)
> +		if [ -z "$vmlinux" ] ; then
> +			color_print ${RED} "Please specify a vmlinux file to operate on"
> +			exit 2
> +		fi
> +	fi
> +
> +	if [ ! -f "$vmlinux" ] ; then
> +		echo ${RED} "$vmlinux file not available, please specify another"
> +		exit 2
> +	fi
> +
> +	echo $vmlinux
> +	return 0
> +}
> +
> +make_tmpdir()
> +{
> +	outdir=$(mktemp -d /tmp/$(basename "$0").XXXXXX)
> +	echo $outdir
> +	return 0
> +}
> +
> +make_tmpobj()
> +{
> +	outobj=$(mktemp $outdir/$0.obj.XXXXXX.o)
> +	echo $outobj
> +	return 0
> +}
> +
> +make_tmpsrc()
> +{
> +	outsrc=$(mktemp $outdir/$0.src.XXXXXX.c)
> +	echo $outsrc
> +	return 0
> +}
> +
> +make_tmpfile()
> +{
> +	outfile=$(mktemp $outdir/$0.data.XXXXXX)
> +	echo $outfile
> +	return 0
> +}
> +
> +info_log()
> +{
> +	printf "   "
> +	echo $1
> +}
> +
> +title_log()
> +{
> +	color_print ${YELLOW} "$1"
> +}
> +
> +verbose_log()
> +{
> +	if [[ -n "$VERBOSE" ]]; then
> +		printf "   "
> +		echo $1
> +	fi
> +}
> +
> +error_log()
> +{
> +	printf "   "
> +	color_print $RED "${1}"
> +}
> +
> +test_softfail()
> +{
> +	if [ -z "$softfail_count" ] ; then
> +		softfail_count=1
> +	else
> +		softfail_count=$((softfail_count + 1))
> +	fi
> +}
> +
> +test_fail()
> +{
> +	trap - EXIT
> +	color_print ${RED} "Test $0 failed"
> +	if [ -d "$outdir" ]; then
> +		color_print ${RED} "Test data is in $outdir"
> +	fi
> +	exit 1
> +}
> +
> +check_softfail()
> +{
> +	if [ ! -z "$softfail_count" ] ; then
> +		color_print ${RED} "Soft failures: $softfail_count"
> +		return 1
> +	else
> +		return 0
> +	fi
> +}
> +
> +test_pass()
> +{
> +	color_print ${GREEN} "Test $0 passed"
> +	exit 0
> +}
> +
> +test_skip()
> +{
> +	color_print ${YELLOW} "Skipping test ..."
> +	exit 2
> +}
> +
> +cleanup()
> +{
> +	rm ${outdir}/*
> +	rmdir $outdir
> +	return 0
> +}
> diff --git a/tests/tests b/tests/tests
> index 11921ad..b4116ce 100755
> --- a/tests/tests
> +++ b/tests/tests
> @@ -8,19 +8,21 @@ cd $tests_dir
>  let status=0
>  let nr=1
>  for test in *.sh ; do
> -	printf "%3d: " $nr
> -	./$test
> -	case $? in
> -	0)
> -		;;
> -	2)
> -		echo "skipping..."
> -		;;
> -	*)
> -		status=1
> -		;;
> -	esac
> -	let nr+=1
> +	if [ $test != "test_lib.sh" ]; then
> +		printf "%d: $test\n" $nr
> +		./$test $1
> +		case $? in
> +		0)
> +			;;
> +		2)
> +			;;
> +		*)
> +			status=1
> +			;;
> +		esac
> +		let nr+=1
> +		echo "---"
> +	fi
>  done
>  
>  cd -

