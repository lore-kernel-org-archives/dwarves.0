Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58811BDC3
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918415; cv=fail; b=F8iz28Vfa8df0hwm7Kw6SRzTW2sTDPAxAcTF7iPsgujQoOVScKVogl6sqnNTnM6/k0j89wIOztVdl0uSPYGUfDIvMgjPv1IHLWhk6QyuxGBq1J91HZKv8ckpR+GbhIC1vAnj4u7P4xDQLdak11VGU0IXRhrFFUoYwt1L7l25V8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918415; c=relaxed/simple;
	bh=s3fc56shl1Zr1iyFRa4t+Xr1n4sEx3kjgzU+FXt6eoo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oU2skVXnTocKnGJlnd+NKZyay0AmCxVbVQCs81y5hlEV4VHimIADq6y8Md2BTVQ5uO6stss4ICi0NX/lgOPJZKRs69od+VvEJ2BdaEQBf/cR87qWgkQDzVMmxVG8zchT7NjeNfpsss0S/PKBHz9iP8sjF41MLGu8oSf5Ly06C6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WCS4wl7x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t7BP7bAo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WCS4wl7x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t7BP7bAo"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEfhY9012622;
	Mon, 14 Oct 2024 15:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MJtqWFyILDvN606b6U8hmLM/ApqM027UnWYwxm+f8mo=; b=
	WCS4wl7xf0TgZ4bhzzhVjsA3O9SkJDDqOhK/ePqdotpIHKf/qISfZ7ji84ZHQHcR
	HvNpr4swYnDiYQZm6cFiBKYA6PITg3dP11vfrjdVgILoj6VDQa7Wn5N8HfM2P1Rt
	fZ5pIjIgYNRWIZWxQbMIxkadhmzBdn0lqHTsFth9Q3QnGvhw+SrUdYu0gPr+Lyzv
	iHDD7JNwtULIyTbzQ5n1Gkxjtth9NujavwKMCFeIsRsMOVrAwiL1qe5RaqSK4M4m
	hN0FdYmIMx6SK8yT042RAP+3icp6zXhcWbXcxwMg4sXMu91UILwnlLOjrQEyYnd8
	foIeK1GbAjgjdsPC89x1qA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09e77p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 15:06:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EENxXq011105;
	Mon, 14 Oct 2024 15:06:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjcfug8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 15:06:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOSovPXiN+Ut6o25s8+gScXdz2nOVr17h5RMiLJzAUg1FWfuQKqw4J0jptGGLYlNwbYmjnC/2ibuRv9QPFio43pH0/n2uGuVOTOS0bg5XWEPJMAEdCJzLmONf3FX4bdeDD3xWhRrNHJn7vbAcu45KeP6DFdeyDhl5uvw3bPa2q1rfEq4GhB57wVC0S2se3ZG62+Fx9+g4CaCrctfu8oNbXcOE1NAiK7Fb3s/1Dg2NpPTRhA22MqXyF5XCuggkwvKZ+Kxy2AeIH4ordEWRdLwoWwRQTjC2sDO/Az62SJHZ0CzaItc76ffC8qLjA2LiiB/5GdaNPmeA1xnetenDxbHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJtqWFyILDvN606b6U8hmLM/ApqM027UnWYwxm+f8mo=;
 b=fOhxIZDB/U3JWQ8IMm5Fq/5+n1j/nnkxiiehHjIIQnPdDMTTg0yGDLEc1WLa573IQZW8/fa8JdeDtAEsjElxLJ864dIubRjD7Pv4O2cKaSH8Nc4MqKUZjhFWJpyzzCYlVimzPeA5jdsxvdp3SewFilMDyHGmLlXbpwR6LPXWQ6HVdp0hiePSVt2kwV9z2QFSnpMfJ7Fg5ovM6VUaR6gH//1O6AWcuYQ6DhGO88TOpsnUsFhNy/dkh+Fio6RQ/sbaCtMF0VXMPA1Gse5viLHhrYJUB91e8nnX2fZCVJM15wjrLtAvRu1FhOvsD4t5q5qbnpuZGWHKF4KMcPDCxuupnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJtqWFyILDvN606b6U8hmLM/ApqM027UnWYwxm+f8mo=;
 b=t7BP7bAopqdjjhZ9SkGPBCQoXZZYe5K6Df1zShbeAI6TXrCjVI0IApT0NPFmwYyvDQBmNLIOKDGeADbJSfttOX5o8RurEAO7obBGkZdeg+96+/LsKV99fDVsezm00KwJGQ1i5S6GYko/mPLqn5nHLoWEkaDtSWTdUVigRP7KIRw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6581.namprd10.prod.outlook.com (2603:10b6:303:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 15:06:40 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:06:40 +0000
Message-ID: <9d3071a1-83fc-4c57-999c-d95f71555dfd@oracle.com>
Date: Mon, 14 Oct 2024 16:06:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared
 elf_functions table
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
        acme@kernel.org, andrii@kernel.org
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
 <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com>
 <4C0idzPIUJesSQi12dB1SgeTQlGl13N2CCsvjPfdLbvTEemTJoQZ4P-LJcOQqRyM69ZLKVv4mIKDQJvfMYMV2oITse1_uS_m_SjVigh8bL0=@pm.me>
 <af7ca712-7798-4204-9e15-fa2065154699@oracle.com>
 <52889283-56c4-4cf6-aad6-b0fbea9e58fb@oracle.com>
 <m_fH6Yg0CAytjEUTxfZPpbMVGqGQWhuep4D--XMNrOZJh6MUWlIozEXiCC6ulW4FK6UFvCFlZC_sF0oNsAW3sftTvfPBjpz5AN3MdnxfhB4=@pm.me>
 <CjP57PbrCPwA8EsOHPQuoZ9YnU1UE0mzeYqoqI4gQHTxIVUgXoEmGS-4R2g1gkf1RMPFVlTSE253f49mPUvqHUiuUw4wxwJXBH3Pv5GPwOg=@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CjP57PbrCPwA8EsOHPQuoZ9YnU1UE0mzeYqoqI4gQHTxIVUgXoEmGS-4R2g1gkf1RMPFVlTSE253f49mPUvqHUiuUw4wxwJXBH3Pv5GPwOg=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:208:1::29) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb54988-05a7-4ec2-783f-08dcec61ced9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnFhMUpyQ29VVGcyaVZxYkhnZVpJRmUvWTVMeXIzQndDdFpBb250K2NsdlVJ?=
 =?utf-8?B?bFBYRWNWTWZKOElzOFgxVkhUREhpanFHdGZ0d1IrUEVqYUNWZVlKbEhnbEdl?=
 =?utf-8?B?ak5IdlV1dEIySGdpclB4T3o2VUViZG1vaHluL2drVWU1SFQxa3ZJaWppUXZN?=
 =?utf-8?B?UzVoRDFpRmt4NWo3QU5WRllaemtUb2NGSkkwYnR6bWdMVlZXVEZ3YkJ4aG13?=
 =?utf-8?B?Z3lxK1RHdDh4ZjJ1SDAxZHFEamhSVW9KTzdXVzh2UmNERWFiYUsyRzBLSlEz?=
 =?utf-8?B?ZVhrV09jYzJaTEtObnZtUktQRUQyemkvZU1uNzRyVWRWbk1qSVB0VzlOeCtu?=
 =?utf-8?B?dW9SR1hJSnMzLzU2UGNTWUswYi91Q2J6S2oxUCtZTzRxVVl2Z2I3c3U4WUxo?=
 =?utf-8?B?S1doalJHR3M4RTJZZzZYdFRzcEU3bWlXTENJMmdzUmN0Tkt1UFFqT2pPOWdF?=
 =?utf-8?B?MitQeWNyZlNtNUFybUJXN1hCaE1JZ2dlUjRlQU5OQldiQkEvcm9pTFBaNjR2?=
 =?utf-8?B?VnVnenhWYnordUcwQnpWSHNEMExTL0xHN2FIaFJScTFTK2F1WjVuR2twanRw?=
 =?utf-8?B?aU9ETkloTmVrUlE1VGpOcWpBbS9FODFpMSt3bW51OEhQdkRVSS9VYmV5TkJo?=
 =?utf-8?B?aVVjblVKN09XYTNKNHdIc1dIYTFsRTlOcUF3WVdIbEZXdkR2VTdXV0RydkIw?=
 =?utf-8?B?Tkl1TzkvRnQrMWNjaUgxRGJqRzJzRVdKRTZUWXYvWERPMTc5RlVySitaQ1Vr?=
 =?utf-8?B?c0hGbzZNTmFIQkpyV1RnWUdVRUd4Tmx2THhjOWJ0OXMrRktvczFMNnh1bmFs?=
 =?utf-8?B?UVpTcFBEU1ZvN0tnU2JrZS8zdWp6RzRGV3BJbXJmYUUwcXU0ZWRldDVCZ0Uw?=
 =?utf-8?B?ZTZXU0I0dmFIVWdRa3htL3JCSGlCY1RxaXZJWkN1UE53NTE1dG4vV1FMeGQz?=
 =?utf-8?B?WTFrb3FpdG1UUDd0bGhma2w2THgvbnlvWjRRMlpDMWpVcW9MT3VGN1p0cnhM?=
 =?utf-8?B?WnZJek96U25WNHlCVDBMbkxkUW11V0hlaHg0TlVFRmhWbXBlNWdzT0lCZ1pU?=
 =?utf-8?B?YURnOE8vK3hreFhWS1VrZStFb1pwNGVMbGZjZVJ4UVJ2M0c0Zm1ra0lWM0ZB?=
 =?utf-8?B?Z1hDdFZvMWdaL1NJZTNRTjRzVHRyS3NrT2JpSnV6OWlJUHJGaE9GNUZNcWd2?=
 =?utf-8?B?Qmd5V3l4cS9HbTcxUGZJSTlqSmN0ald6dTkxOTlkWkhwYytKMFJBQ2UyU0JB?=
 =?utf-8?B?VCtCS2RrNDlqNDUrMHJqRTBzQVY5ckRZWkFKSlN6eDViMVlWYWFSSTJPU2l0?=
 =?utf-8?B?QktxWUtIcEhoOWxQNVYybktvNmpWUFJEMHZJdjU0bFdRRWU1OFYwUmh0NVF3?=
 =?utf-8?B?dEthSU9sSW1jdXNTNW5lWjgrZi8yYVFBa0FPS01xSkEzaVhTR3QzeUxXeWQz?=
 =?utf-8?B?VWJLTFFOVFR4ZlFFSmwwM3MvMG1waUltWG1sY0VJQzdqYWR6aTRKVm9kRzdL?=
 =?utf-8?B?S0VkaEFnNysrWFg0bWZhbkoyQ0JBRldnZDZqUTVNVWNxZk9VaU5CeWdPSFZI?=
 =?utf-8?B?U2FKczN5TmdyTlZuejIzU3Q3TjhVZ2J2SHRyeWtkaUp0WDZnNlpFL3VsbG5o?=
 =?utf-8?Q?I6dUV3tFe3sGGoDJ1lXEXCcQiflRl0wPFXswRGPvx564=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3JvcmNGRVQvQ1B1cTN4VlJyYjBkUjZBVlg4ZnUyRVZCa2pwVVdSWm04VWZh?=
 =?utf-8?B?dGdBRXVQUnZtYWNyZ0F6OFNlWEJsNStIMGZtNXBIenAvMStCNFRHZ1F3Z3p6?=
 =?utf-8?B?TXVPaVVValFkOHlXS0VZV3F4dHZVampWejNTMHVyQWFYRjhTQ1FJc1d1UzZC?=
 =?utf-8?B?YTVBWGhOR3RTcGQzNkdYbVJlTWUybFMwMG9uYTVVOSthTmI2SHlpZ05HN0F6?=
 =?utf-8?B?bDU0ZkhQaE9QNGVVN0UxMU5WRTl0NE0wRUdWNDlTcUFVc2hSbVBVbGpLdHgr?=
 =?utf-8?B?OVhhMk1qZ2VaSXczbUg0T1g1Y0tsQ1Vac1gzRitLRmRkQkFobVNLYjFCaXIz?=
 =?utf-8?B?Tk9wNi9qQzRha2QwTVI5UlNFL2hoa1RRRGJ0WlZGUEZtS055eXM4aDJjV0Rk?=
 =?utf-8?B?TlpYL0NZaXB5Tll2UnhRTUt3eTkvUFFnSjlkaGpaY0lzc0JUQisxcHJ5V3BB?=
 =?utf-8?B?eWEvMnFHeG9TSDdFazJsbHIydFJKRm9YOE4zM3p4RDk5OHl4bE9FVDhJQ0dH?=
 =?utf-8?B?cTFrTFNFc1ZpVzdNZWd6bU1NL1kwbmJQalc5WFpqUVM5YW9mb0R3NnFXbWRX?=
 =?utf-8?B?WFE5TzVZVXpnUnJESzFhZDZZZjNDNGJadk12bjY1L1kzMC9zUlZUaXRmL1dp?=
 =?utf-8?B?YitqbnV3Y2ZIQ0h5UFNFcUpzWGNFTkMvdXZtdjVKdEEveXJMOXNMM1BNOGtB?=
 =?utf-8?B?a3oveFRKZzlqVlpDNWtxQmFyU1JBMTZUcENKMUFpaFViSlluSFgrdVZvRXN0?=
 =?utf-8?B?NmxYSDQyM2ZsQ1JpeGhabnNwNm5sV2J3VDl5UU9DanZvbWhoWFpzdEdiWFkx?=
 =?utf-8?B?MWNOcFF0Z201d0Y4Y3d5UUpDRGpHdlc1OVp2WG1pOENNZzN5Tk5BWWtqZFIv?=
 =?utf-8?B?TmZDSy9BT3hQR0ZxY0VMWW0vaGFIVlFWRlhKbWFrV1BsOEZ5SklEQ2NsUUha?=
 =?utf-8?B?bzdyVlRaWEpVbldKQ1duUnMzLzdJWVpReTBDRU8rdmMrWWdlWllJRkptQlBz?=
 =?utf-8?B?OWhhM1ZienkySzRHSEgzU0V4ZmNKOHRBVElOaVpaWDJrRmRQVDNTUldzNlU4?=
 =?utf-8?B?UXVQOXpJL2R6VnJtZWZpUXFZQ2dlK2VZcnBlbUhMY0lXUHpVbmJGVHNabHBB?=
 =?utf-8?B?YVYxamYrVS9JU2VMRjV1dHVWZGlJYjVtZlRhNnd4Z3RKWStJeDE3QVBUcVVD?=
 =?utf-8?B?RmlYQTk4R3E3UmQxdVBXd1V5T0o2TlR0Z2FxbGp2YVg2MGdONlc1T0t1UE54?=
 =?utf-8?B?YnM5ZFJEY1NaMU9mbVh1MWNEaWJrUEYwS0h4QThHZjFVUHU5eW1WN0haeXhB?=
 =?utf-8?B?Nm00eGQ0Vkl6REgzTnVEK3lUZ0pOUmE0N3dLU2lybXBBTmFwdWFKNGNWcmZy?=
 =?utf-8?B?bzB6bTRDQ2Zjd3h6K2p1cyt3RkQwWmcxSElGZFhUbGUwWjNhSVM3TzFXNjBD?=
 =?utf-8?B?TlZzYytGaFgvaEVzZko2ekw4a3NnY1FHWFZrc1pmc0JuYzFsd2N5TlA3UG5y?=
 =?utf-8?B?clljSVN1dXlyS241RFhyMFZmQkJyUmR5VXF1TUFwSlhYVHEyemg3OFl6OHFH?=
 =?utf-8?B?TjFEUGpyLzU0MC9nNkdCSW42YVRndWFGVWNGMy9BOTM4YTljQzJVWjV3WC9T?=
 =?utf-8?B?QjVmTlRJdjhORWRMM1dNR2MreVQ1M1hITkJ6RWJqakhRYzVUWW4yM0hXcEpC?=
 =?utf-8?B?SUxEamZOdExTNnoya3YzcUp3bkxWYjV2RkE5REYvOTczdHVmY3VNS3FnaXds?=
 =?utf-8?B?OFdnS3lnYTBXN1FsSXU1ckRyTTJwTjZUQWFCc1BSdUFJdmsrM2VsUy9ITktO?=
 =?utf-8?B?d0JUM0RhUjJJdUZxL205ZUp5N01DWkYzMjhnaG5EOFVwcFM5OHJnZWVUbm5I?=
 =?utf-8?B?aGNvUjNyV3d5ZHQxRXltM3pHTVFiaVhSM09IdEJjb0FkSzNUMjBxQ2JVbFY0?=
 =?utf-8?B?ZmRSV1dra1IvcWpRQUFVZ2QxNlFUczN6UzlvWWlBUlBIM0prT1hNbjAyUUJR?=
 =?utf-8?B?ZTduN2FaSmZzZVl1b29nWGVaQkJndkRGSWEyamhSeFNqdFViTGRSL1BJZVBH?=
 =?utf-8?B?aG8reDVoYmxSeHZKZFhrTFJ2S0g1Q1puSDRLYzU0emF5OUVBOE5WaklwckZ0?=
 =?utf-8?B?VmQ3aml0aXR5R2FTd3VyZVNRM2xoOXdubHB4RGg4cE1jeFJicE9hWkUyZDBk?=
 =?utf-8?Q?BQyCUqklhMguW9KVvy4fJxQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iOmxyVi1ueAt28z9Ogl+1fGOzoatIAkpeznZH1MbygfAINsBrkPqT++BpNSIpY7hgyF2ohDPBmUBS5c7iG4+i9+mP0P6N28rpbwbLr1+BVNg9yGIU9eqCkL+YthVMYEhoMEhgCBgrh2Sl+3c1LraavMt91ds1BfYXq1pgfvmksmt8tX7yBcLOo/YrRegON8KBeagWoSgPK+49oH6CRqwA094KLToeliZMZqlEoE1WWlzXcQQX2gCXU0tia+fCLigYfI9CqrB4HPCXWwfRsB6ZdAriXiXAtt9W4+yZVE4n2h3U+wom1ZZxCcYO0RMxvOukR5nA0IOR0ELtc6F3t6SprQKr8CBldult6yKJ6rMx7kqXFlL+sXf3vgHuVGaTsRzkBivDqLTnUzHVo5KCOgcvAcG+1v6JJr2V8en3rhmRgrZYIw0D4mJqd75glKPYbmE1gNzHL/rCFtLryVnjHyX05N3XbQg4OgEslxDm8EvHM3dcgeDRiREys3ofKhzHrD0s8NVkmyCFObLTSUNk5p8QAteX/QpRJt5L6DhzWAJQm9ZI1Cjn9VNeOszeKjtKsXWRqyX+/1swLu1Ct7u8RLSfSypN2/Q31R/m9buUfyj07U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb54988-05a7-4ec2-783f-08dcec61ced9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:06:40.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nu8fn3lzxxJh/MstDbvzIjJ7kL8Z6izQ7BVbjjL/VasfiIhTC9SFypN9CpzJMnbG86U8w3OMUIgH5CD0QO8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140110
X-Proofpoint-GUID: G7JxazJhUuSCfG09t0ZY4Jy5aV5ZpIWG
X-Proofpoint-ORIG-GUID: G7JxazJhUuSCfG09t0ZY4Jy5aV5ZpIWG

On 11/10/2024 23:55, Ihor Solodrai wrote:
> On Friday, October 11th, 2024 at 9:52 AM, Ihor Solodrai <ihor.solodrai@pm.me> wrote:
> 
> [...]
> 
>> Hi Alan. Thank you for testing!
>>
>> I was going to run a couple more experiments today and respond, but
>> you beat me to it.
>>
>> I am curious about the memory usage too. I'll try measuring how much
>> is used by btf_encoders and the elf_functions specifically, similar to
>> how I found the table was big before the function representation
>> changes [1]. I'll share if I find anything interesting.
>>
>> [1] https://lore.kernel.org/dwarves/aQtEzThpIhRiwQpkgeZepPGr5Mt_zuGfPbxQxZgS6SSoPYoqM1afjDqEmIZkdH3YzvhWmWwqCS_8ZvFTcSZHvpkAeBpLRTAZEmrOhq0svfo=@pm.me/
> 
> Alan,
> 
> A heads up: there will definitely be a v3.
> 
> Eduard discovered a bug when building kernel using pahole with this
> patch. I already debugged it and made a fix.
> 
> TL;DR there might be fewer encoders than threads, which I didn't take
> into account here:
> 
> diff --git a/pahole.c b/pahole.c
> index a45aa7a..90f712d 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3257,29 +3257,34 @@ static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void *
>  {
>         struct thread_data **threads = (struct thread_data **)thr_data;
>         struct btf_encoder *encoders[nr_threads];
> -       int i;
> +       int nr_encoders = 0;
>         int err = 0;
> +       int i;
>  
>         if (error)
>                 goto out;
>  
> -       for (i = 0; i < nr_threads; i++)
> -               encoders[i] = threads[i]->encoder;
> +       for (i = 0; i < nr_threads; i++) {
> +               if (threads[i]->encoder) {
> +                       encoders[nr_encoders] = threads[i]->encoder;
> +                       nr_encoders++;
> +               }
> +       }
>

I tried the above, but still saw segmentation faults; the following was
needed at my end to get module BTF working:

iff --git a/pahole.c b/pahole.c
index a45aa7a..bb17aec 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3257,20 +3257,25 @@ static int pahole_threads_collect(struct
conf_load *conf, int nr_threads, void *
 {
        struct thread_data **threads = (struct thread_data **)thr_data;
        struct btf_encoder *encoders[nr_threads];
-       int i;
+       int nr_encoders = 0;
        int err = 0;
+       int i;

        if (error)
                goto out;

-       for (i = 0; i < nr_threads; i++)
-               encoders[i] = threads[i]->encoder;
+       for (i = 0; i < nr_threads; i++) {
+               if (threads[i]->encoder && threads[i]->encoder !=
btf_encoder) {
+                       encoders[nr_encoders] = threads[i]->encoder;
+                       nr_encoders++;
+               }
+       }

        /*
         * Merge content of the btf instances of worker threads to the btf
         * instance of the primary btf_encoder.
         */
-       err = btf_encoder__merge_encoders(btf_encoder, encoders,
nr_threads);
+       err = btf_encoder__merge_encoders(btf_encoder, encoders,
nr_encoders);
        if (err < 0)
                goto out;
        err = 0;

In particular, nr_encoders must be used at btf_encoder__merge_encoders().

With this in place, I hit another segmentation fault, due this time to
the fact that we need to handle the case where there are no ELF
functions (this occurs for one module when building the kernel). Fix is
below:

diff --git a/btf_encoder.c b/btf_encoder.c
index 07d2031..b61a89c 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2274,6 +2274,8 @@ static int elf_functions__collect(struct
elf_functions *functions)
                      functions->cnt,
                      sizeof(functions->entries[0]),
                      functions_cmp);
+       else
+               return 0;

        // Reallocate to the exact size
        functions->entries = realloc(functions->entries, functions->cnt
* sizeof(struct elf_function));



> 
> Regarding memory usage, I tried instrumenting with prints of rusage,
> but that got too inconvenient quickly.
> 
> So I ended up making flamegraphs [1] for:
> 
>   perf record -F max -e page-faults -g --
>    ./pahole -J -j8 \
>             --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs \
>             --btf_encode_detached=/dev/null \
>             --lang_exclude=rust \
>             ~/repo/bpf-dev-docker/linux/.tmp_vmlinux1
> 
> And compared between next (91bcd1d) and this patchset.
> 
> If you check the number of samples of 
>     btf_encoder__collect_symbols() - that's a table per thread
> vs 
>     elf_functions__collect() - a shared table
> 
> the results are what you might expect: for -j8 shared table is about
> 6x smaller.
> 
> However, even the duplicated tables have relatively small memory
> footprint: ~4-5% of the page faults.
> 
> The biggest memory eater is elf_getdata() called from
> btf_encoder__tag_kfuncs(): more than 60%. Maybe that's expected, I
> don't know. Certainly worth looking into.
> 
> Of course, these are page-faults not a direct memory measurement.
> If anyone has suggestion how to get something better, please share.
> 
> [1]: https://gist.github.com/theihor/64bd4460073724a53d26009e7a474b64
> 

