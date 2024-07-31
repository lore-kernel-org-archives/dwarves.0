Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC191A8C03;
	Wed, 31 Jul 2024 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416264; cv=fail; b=Bg6KPcNtiYgFX8XffyGj4D+VJMcMLv4DTQHCC2zc5t5QkBLw5aJSWVeDJFnOfoKhj17ahPLU2d9CXy4shnen89ZcdY6l9hwxWAZhhdL6eXCUY3onOp7i26WFmu+bJnjLUhW0ZJMY+h6OvljPTtr9gR+LeRnwh4wcqu687+KA+j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416264; c=relaxed/simple;
	bh=16XJ7U4rvJOZMcqgjbMsIjAJ40A39IOS3cKP+7n9qMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZz20BIAHuXw9StqtOEZ1j038QswggprP8zjJ7a+cnpksCBepnEZLPhEhAUoe5OP2jYps91tYm91L8OxyYibrBNlux3zs4Fl94O0MP/vljBmeSFGzoagMCOphsao0rlA51hVyV1R+vwK6mhriik1nrq9Adn2lKX8pGcO8vwAn6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FujVi1Hr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zszeQfzY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FujVi1Hr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zszeQfzY"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V7tc4C024418;
	Wed, 31 Jul 2024 08:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=yAa+zrBPwsuZ8zdSs1gfK+B9D301dkeCDLeu2afeJUs=; b=
	FujVi1HrAF2vr0HkoiaAXq/wCTQQw4G7mTg+tWshOosPWXFkE6Trl4Qo/L7KR6Gn
	B+n9q7hkOJ+9wT0cz9GhhfHTZUwFnPhu1oPzQLmD6jUCvn8VqhmD3VFYqWnegKDQ
	2YX8G66n69AbMfiX35hB26Sxet69ZX9Z5sKE5qV/KhHx0ujpcCTSQ2WbDBxyxY7Q
	1Bboy694Gk03OveLFQ9l178oG8WKlrB7YEB6WkEwwHwINS3n9ezIfUwfSiNXdX11
	Km+YRWZy/dbYWfeSlRGzrzsD6wc60COU8TZtz08C7KCEQPV0OUpqpPRXp2p1g8uZ
	/J7cQ1vgeFX0NfmuD+PiiA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgs6vdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 08:57:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46V7FY7J005956;
	Wed, 31 Jul 2024 08:57:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4c172u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 08:57:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD9EPfe0m7GxF9a2/NlojosOYD0ybbvRA0XDq9Obzdy3iyizLNvUTbo3cG0lK3lhc15G1xwnt9xPppYdkxWTgwrklbIQnr+SehuQEyEhvh0j1l7rAFkgyQKJ3zc24oOfJU0xJ51lrLWOCiqWAEquIcE2nLv1Ayb8EBJJZHnr9TAFUK8Ru77UWbNL/4r/rw8aYQdyKMTIfivSz9OPFHiyo8ujMsDJtrznS3fC9+38kINKcLRPYBGHGBgxpWXifmvW05YGzsRS42SikrczyT3jciHfD5xpITGQqZe9sXdy9j7Or6DuI6J1C5XI+flgoCLZXhSKfoatt+GweWX1TbuWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAa+zrBPwsuZ8zdSs1gfK+B9D301dkeCDLeu2afeJUs=;
 b=AdcJzYKORQFsc2EQ41dJKbeLzZSH5mM8ylIXGb/bVDJaZ7V6FKi7EFtAr/X1XsXlR4WFNy/ibQMS7+JVabHKx+rIZQbmcc9HRXHeDz8K5izUdK3xh9LxkoQUvYn4tv8vzH54TQf7Es4rRtlH/stMduWXaQ96BBXPMT0ut8uDc6E/CawCzZQ65jzAYod7sWG48sFjEfmnJ4L7/tf0wIjq4KvBtVTXwJBExkIcpHMzTD0j6CXNYL0YWR1lIeLGyWon3BOtFIkXh330x4vGFlLLj+KCLobPaY8wZmA/IDoTPwN70iG9z6s38RcrQPxekecn0vDdYyzq05ZPP1esQSSzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAa+zrBPwsuZ8zdSs1gfK+B9D301dkeCDLeu2afeJUs=;
 b=zszeQfzYRMVfRBE9flH/pv3g8z2uViQ327Kg/AYahnZ+nLtN+qhb9xKotK9k8cYFGCZOD3OkPDyruOB8f02B4CP81Zbj07iEXGtafsG1cTPBBD9kivSVjj0Q4pa8u0oFVd0Cu7JgEML/xRntnfd4RDqgwX4cwWDJdTDdoASdy58=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6083.namprd10.prod.outlook.com (2603:10b6:510:1f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:57:32 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7807.030; Wed, 31 Jul 2024
 08:57:32 +0000
Message-ID: <0c0031f6-7f5b-4ec2-9804-c9d576c8302b@oracle.com>
Date: Wed, 31 Jul 2024 09:57:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pahole: Apply CU-level filters early in loading
To: Matthew Maurer <mmaurer@google.com>, acme@kernel.org
Cc: rust-for-linux@vger.kernel.org, dwarves@vger.kernel.org,
        aliceryhl@google.com
References: <20240730224350.4039790-1-mmaurer@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240730224350.4039790-1-mmaurer@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0064.eurprd03.prod.outlook.com (2603:10a6:208::41)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9a5824-6b58-4471-f68f-08dcb13ed040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlZhaWV5RTJQemlkek1wV1RtQ0R6V3dpMmpadXBOOXZXTlVjQ1BIemxDWENI?=
 =?utf-8?B?aDB5T01RRHE5WCtIbElRTGhxcCs1UHJoTzRsR0xjNGYxSGhKWTE2UEhNeVdV?=
 =?utf-8?B?Z1ZXZk42b0ROdUZGdXVEL3hTcTJGUW14WnhaSWRnL1VMdkQydzRoVG1Jd1Bw?=
 =?utf-8?B?VTlBSlRaYjJ0MGFxcFlJN3pDVkVFaUtyVTYvK0V1UW50TG55dUxCR0Uvcncr?=
 =?utf-8?B?SFg3TGdlbWh4Wnp5UFZzMGVHc0tFeU90Y2ZHNWtnbm9JcHJQbFBQUk8wQ2lM?=
 =?utf-8?B?bjNIQjFoM3FDVzIxWDYwRDdrLzdYZU82clBuTzZidmlncFdUZmxNYnRWQ3Rt?=
 =?utf-8?B?Y0JvY05FVHFRWWkrWGJUSmVJd0l1cEd6NUJHa2FSejNlOEIvL2N5a3BHYVZ5?=
 =?utf-8?B?T0RNaEo1MThpcitlVWdYb3htSE11TzQ0WUhhY1V0MmJYd2VLcGhJaitZREVE?=
 =?utf-8?B?bEVQdlhKVU9VZ2h1K1NzY3BUd1JkMW1mRnNpVmRVTUtEREt2N09MZDZ3UlF4?=
 =?utf-8?B?RlJGaDl3TXVGZEhlSHhnSldOVFFTblhod0pMU0RSbVUzRjEwcXJtRTFmU3h1?=
 =?utf-8?B?UGVHQ2pBWUEwenVpenNNYUJUcVl1V0pwdm9lSWZwVkFzSkdwSFZHYnRjWU1m?=
 =?utf-8?B?ZDJWRmdkcW5CQk1ONlphdkMxRUI5WVh0N3ViMFNIRWw1VVB5YXUxZlZ0MEVh?=
 =?utf-8?B?NzgzZFh0L3JydDVJTXMzc29HQnRrajVnTHhLV2hKRGlZRmFQcWZRYU9YODVI?=
 =?utf-8?B?T2VCaU4rbHZ0NndvaVJGcUpER0JKUC93aFh0TVNEYmxNQVBudUtSK1pKRjBi?=
 =?utf-8?B?SW5oOFdVdUlQQzVrdklLZmNkSFcrU2grY1hEOVl3OCtEeDNDT3Nqc1B6TzE0?=
 =?utf-8?B?aDhzaHBnVmYyNGVHcmpWSWZwM05rODQ4OVlzS2JxaUg1S1VLMXJOQkRJR1dt?=
 =?utf-8?B?emhJenh6VXpid3ljdjFFeVdoVEZSQnRkUUhOd2paU0pmUWZ4bjRaVk5xOSt3?=
 =?utf-8?B?VUVBcHJlVERKMkZDcHN1MCt4U3ZBTHFIbGpETTJQMllsWU5KcWR6dWxXMGRq?=
 =?utf-8?B?M0lpQU5TMWR6VkVObDhRTjlKYzNzYWc1TkJQa2hTQUJjdWZBQk5zeVoxMWkv?=
 =?utf-8?B?TWpFRVozcjkxOWh5dW5aSDc3QWEybnZlbkJteTBBbEs0VzVtVTZ2MEYyOEN1?=
 =?utf-8?B?dHE4d1NkOVFQUk9FMFJZZGNhbDZqLzBKNUpXdU1ob0xnWmNtbm1VdVdUMjN0?=
 =?utf-8?B?RHU3eUpTSUhDK1VSbVVoWGQ5aWUrVkhuZmdSOVU0eUU1YjdpZG95THpxS244?=
 =?utf-8?B?VkxlTU1qYmhnYlpPTk5aRFgyaU85WkJYdkgrQTJWM01aMHNTMHpQN1I1cnFx?=
 =?utf-8?B?Qk55U2g5NC96ZEs1NUZOU3JMbjhrSXVpRmVnUGxzZUs1cG5udUM0QURiU1pi?=
 =?utf-8?B?VzlyeS9jM3Axenp1MjJMdUtJZEowc0xHUmdOQ0FKT3dLck1XNkI1dFlkTWY5?=
 =?utf-8?B?K3FoVkJ3a05PQTdFaWQvZkFScWR5N21kUit2RjBRVGFaZzhSblBLN1pqcVF4?=
 =?utf-8?B?YXlyQm9ReTVKNit1cFhsM29PU1FVb3N6OEFUbTFJVmdBWlM5Ym4vcWRJcmcr?=
 =?utf-8?B?bkxGRlFNa0k2bS9lNkZSbmd1Zmx2a1dDSVdOenovMm4vSVdabHNFOWw0aFcz?=
 =?utf-8?B?K0JEaGJJZkFhNXNGaElTRWxVZ1hJZTBONGJlQVZnejc3Y1VhTTBuQS95dXZw?=
 =?utf-8?B?OUp4NUExSVlMTkZBQlp3OEFCQlZIZmdaeDdSM0o4Nm8yOTVBNFJMQlVTNnRB?=
 =?utf-8?B?K2pPR3lOeFZ6VGNDa21tUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NoVEVLQ2p1b1hZM1hCcm54R1RFZFczT2xMTzhxUVpTR25od2pjQ29teExY?=
 =?utf-8?B?QVEwbjdMa0tZT2E3R1dxZjd2aGZKUkRMMHNUdXlZUUVpS3R5WHZUSG96Yklv?=
 =?utf-8?B?VzhBQU1PUk5WVjN6RmNjUlRrTlVnVDNyVFBsRnNYM3J6QXFnSTg3RnV3UVJD?=
 =?utf-8?B?RFROMkNWU2c4UjNHMXM4OGxUc2JvbXMxT2piRHMxL1dxSEVRamxZaUhHYTdo?=
 =?utf-8?B?czJ0QjFnNVJTVkMvMDhGWDEzdisxLzY1VG9IMnlPSkFrS09OZWhvYkpucjlY?=
 =?utf-8?B?VDhwUDhlMm1MWkxpZTB3eHZCZUd0SEtMWFpPd1p4Skh1ZmJ3NEwvZHdtTDBs?=
 =?utf-8?B?Rk1KUTZiS3hwT21RTjY5WktVdGRiSnk1RUVDNmtZNWVRYVFoeG84NWtHZ0tz?=
 =?utf-8?B?aWl3RlJFVlpYL3ZLQ2FnMXdHVEloU1k4ZDd1SXplb0Q2YXVWMUJMRHVmNHUy?=
 =?utf-8?B?TExTbVkzYnBQY0hYeXlEU1NDYnR6M1FKc0xUWnJiQXRxa1NGQTRUVHh2NVlT?=
 =?utf-8?B?dXZROXJwaXFLc3BhblFtVzB3UVFSb3dOZTk4ZjY5ekI5UllrNmdDNmV3T2RQ?=
 =?utf-8?B?WThvaDU2b2UyZlM0ZGFhOVVXdS9HcHhHMkVzN0FCejdQS1p5OUVNdDVZY3ho?=
 =?utf-8?B?TGhGWDR1eEE2NlFpcWpHdS9qOWFKWXhmL2NRWFptNHE5RTVLVWhTK1E4OXVJ?=
 =?utf-8?B?WGZ4dG92cVVVYmxpZmZ1ZFIxdVZ1TGpaZmVmTEJpY20rbTJKYjNQdXdxRmNs?=
 =?utf-8?B?ZVZUYng0THhYQVF5eFZQTlpYRzF2RVQxdmx3ODdYRE1xOTdTV0piWFZZZmwy?=
 =?utf-8?B?T25YOVhZeDJLV2xzRWdBSWVHVDN2UFRvbndRdTFaMmtaS3g3L0E0b0VKL3pY?=
 =?utf-8?B?K1RkcHdTZnBXQUZpT3FmaEdwRXo4Uy85NkZOUUNPc1U2QWF2bVpqd1NSMmJG?=
 =?utf-8?B?UVVVS3pNdk4vUHVHeDlMdlBkc1VOc0RqbGtoSmZFTFBLVWVmNFZzbTk4VCs0?=
 =?utf-8?B?OHFudU80MmdneC9WdmhZa2gwTElsM1NRU0ZxRHZCQUtlSjk5ZXh4bGZYeDIv?=
 =?utf-8?B?THRMc0xhQkx2UXFnZ3RpbG5NVXpvT3l2Um9YOUpnRHpTSExPNGxQbVVxZCtz?=
 =?utf-8?B?cGY1ZzVOZnk2VSt4dmRUZUxZbFMwc3ZjYVBHNHl5TXB0TFJhYVVoU3V5YXNo?=
 =?utf-8?B?THFxSFpLV0cxOEVVUkVobUEvWlNQek5GYUR1QXlmSHVqdXRnaWlSeE9yZE45?=
 =?utf-8?B?Tmd4ZWpBOFpzS0s0M0h6d3Zub3dCbnlMN3psR0w4c2VnVndyMWwrdFpzTjNo?=
 =?utf-8?B?WmZuM3FtN0E0RmpmRjdSYTRHVnBrdVU5c0F5VlJuZWNaSFR2Wnd2Qko1TlB4?=
 =?utf-8?B?WXIvclZUSXhnMVlwZFphUjVMWkhvNFVObUV1S0RDengyUUJPekpFTUM2WFBO?=
 =?utf-8?B?UG9Ud2xRRkkxdm1LZUo2WWtDY1pzdDZ6emdQSjJLVlJzcHRJbW5HQnZ6clg3?=
 =?utf-8?B?SEl4OHNNbzE2NVdJUkpML1AxY3dnb1JBM09CTFdFOXhMV2o5ZkU0RWpSM0dU?=
 =?utf-8?B?ZWI3MXdwL1RWSTV3V09qT0cxTmxjU0lVY01qazZ0M1pwRGFPWU0vVTR6aEht?=
 =?utf-8?B?Tis3aXlmRUdZelk2UDd1dGREM3R0NWtkZERnTzFKOE9LT1lodDZrNGFoTlFr?=
 =?utf-8?B?MElDbzBRYWRGN0tBYW1kWmpvczZUMEh1dFlDS3MrdWhRN1dIT1grdmlwZGcv?=
 =?utf-8?B?OElUck8rMkVsKzVsRGpieTJLL2V3aENZWmF2MENnU1JRK1FST2xKcTRsNjZi?=
 =?utf-8?B?WnhTY0pQVDlVTmJVWGYxTWZaRVVsZDcxMWVwMk9hMW5CWmwzVWV3OGZ4WXNx?=
 =?utf-8?B?bVdoaTJKYmJtZ0dHV2FZbVRlNGplRzB6aG5sSXZaWER5M1pLcW9lb2E3UURJ?=
 =?utf-8?B?TUtNaVFVd2s0SXllN0JaeUl4NXo3YllwWEllSlVpMWtGajlFNndPazFJL0t0?=
 =?utf-8?B?emVFNTRudnRHYnlmNVpnc280bGRQUHQvRWFLZ0d6aXh3Rk91dlFDWEw2Ty9r?=
 =?utf-8?B?L2tBSytxSXJhV3N3TEF1Wkpjb1pCOVc0NGlqdXVRNnB0TEtkVGVQSzMyVlJP?=
 =?utf-8?B?cll4NmZoTEl1T3Z3ZmFkcktJYVBGV21uOFFnK2hzSXBqc1FyUWIwd3Y0Z3hn?=
 =?utf-8?Q?bzIy0x88UB489zQ69Lcocqg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0LzeKPoRfKsWULjeS7dvM1XATiZjnkyYAPQGwIHb9n0ZuDYLGzZl0Iv07cem4U2amhCGGPCOwoKO6rMmscoxMpVFzROJM6j9cyTz7U/KKBQj8iJ0rdGPgK8Ruj0F1nTMA5ekXCGoQqfTypS3r0hopKw53hKwuMhr9d0yPdMkAAfw6jFTtfGOlMbKOWIpsMLoTRQntfFcU0+084+7be//1NzeE52CDn7kG6yyR3qhdQsMxN0EmTU4SFv934ylnymeaujak1jh521MtynCro5tU0W/dlQhuwBI4iOxwwgidGamFr5uYEn91S20jyV9NT8sAQC2NbY3yYmVj2idMQbRKerU1ohek+ZYurIzXhcImORvnVETHJIDEafhJJuZlf7wJCQ3M+nuJiJbjati1W/9hoGVArzXUBxOaY7d04k7u8DpG/OEwy1ZF88BZEO3AlPH1DXtFgTOtb4B1K8sw8cnlRl2oURdpHSwxD7Y5VDhPrWXeVwFz2nloXuPImVjiHcnpU92vXBb7T8ZgBLtzGltFZTlMyyR7ix4MJYYsXDMrP5ol9rj0TKYMZktwG6lTcZJMj47t8/8LfOIntee5RyL24EYx3s3bUMaEBN1XDfWnQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9a5824-6b58-4471-f68f-08dcb13ed040
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:57:32.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGFxZY8voWEcpiukHaQ0Tj5CAWLx4NzBKEuo6OmfF7eTYn7vm7npnLgdDv4r5ihDPgD3JsFTz0CiY/hoP3clSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6083
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_06,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407310066
X-Proofpoint-GUID: zW86aEodAVOPHClUZ2CWKjy4NsRqiwIK
X-Proofpoint-ORIG-GUID: zW86aEodAVOPHClUZ2CWKjy4NsRqiwIK

On 30/07/2024 23:43, Matthew Maurer wrote:
> Without this, even with `--lang_exclude=rust` set, running on `vmlinux`
> with `CONFIG_RUST` enabled will lead to errors like:
> die__process_function: tag not supported 0x2f (template_type_parameter)!
> because the filtering doesn't happen until finalization, but unsupported
> tags are reported during loading.
> 
> As an added bonus, this should speed up processing of large objects with
> filtered CUs, as their details will no longer be walked.
>

One question on this; if we are always doing early filtering like this,
should the explicit cu__filter() call be removed from pahole_stealer()?

> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  dwarf_loader.c | 10 ++++++++++
>  dwarves.h      |  1 +
>  pahole.c       |  1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index b832c93..c48dfef 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2854,6 +2854,16 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  
>  	cu->language = attr_numeric(die, DW_AT_language);
>  
> +	if (conf->early_cu_filter)
> +		cu = (conf->early_cu_filter)(cu);
> +
> +	/*
> +	 * If we filtered this CU out, we still want to keep iterating, but
> +	 * there's no need to walk the rest of the CU info.
> +	 */
> +	if (cu == NULL)
> +		return DWARF_CB_OK;
> +
>  	if (dwarf_child(die, &child) == 0) {
>  		int err = die__process_unit(&child, cu, conf);
>  		if (err)
> diff --git a/dwarves.h b/dwarves.h
> index f5ae79f..92d102b 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -72,6 +72,7 @@ struct conf_load {
>  	enum load_steal_kind	(*steal)(struct cu *cu,
>  					 struct conf_load *conf,
>  					 void *thr_data);
> +	struct cu *		(*early_cu_filter)(struct cu *cu);
>  	int			(*thread_exit)(struct conf_load *conf, void *thr_data);
>  	void			*cookie;
>  	char			*format_path;
> diff --git a/pahole.c b/pahole.c
> index 954498d..937b0a1 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3765,6 +3765,7 @@ int main(int argc, char *argv[])
>  	memset(tab, ' ', sizeof(tab) - 1);
>  
>  	conf_load.steal = pahole_stealer;
> +	conf_load.early_cu_filter = cu__filter;
>  	conf_load.thread_exit = pahole_thread_exit;
>  
>  	if (conf_load.reproducible_build) {
