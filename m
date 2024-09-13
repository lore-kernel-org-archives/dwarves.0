Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD4433C8;
	Fri, 13 Sep 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241144; cv=fail; b=r/t82jGIKjsPPV/HkbN9Oh6uGpU3ANUOHanaWEU84KSbNY/2rsGjeDw87rtUmmstxT19UwpZOyGJlyV5poMIEIm+DCnVo2ZA9bQwzdN653qneV7Vo6WhUof2m4kjMZGeijxquajC1Ks4DGDgngrzPtpJ7eBWHBbudlYgjEN6pAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241144; c=relaxed/simple;
	bh=bpd4mhYOhHmLHI8vjoapgOBepAiMnrZstQkEu1/bGzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=acyoAThfRjFe//vfV+/3dC0rMROxfiXYBGvToGYIyDajUwbQ2ZhSt70A6sxMDWb60wGomIXpvgpiJFfzWsePwmX8rlyMrhFFcscRIwLxiefPle1lDat1+ca2Ny2N104yN6HBp0EsBM4rM1KqduDob2qpkqGDtl0AbQ8j8jEEijA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e4Sy6nsU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JV+dSq92; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e4Sy6nsU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JV+dSq92"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YZ6M020212;
	Fri, 13 Sep 2024 15:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=YoIgQC21Yzvdn97MDlKQkkqfhkeQUP8MKr3tj7GA2mI=; b=
	e4Sy6nsUVkJw9vwpIoGUJcr+77IRHg5XkHfjVDeJKkiuZOnRC99V1ySarqHMEUM7
	UCmdvxncXHuWVDCsEsrPHIsQjLb9CdOYjqlUryvUGVZnoZD1L4MftrLFzc4dkpM8
	XiICF3qYEMlbS97bTJ/bLqTbU7KBONTCJjxgW9N9XzJHfHc39I/6DqXYsZpo5qgq
	G5PI4OvymjDyDnmIgAsQr0CJNtXx09K/XVb4f0Iqdp+W8cN5LGXQW/Pll04rzowW
	LU8Bag6z9uf3t4e41EB17FKiJUP4f+TJm6wOuXKF7+uMDsQjVbXlCFV87LOo5PnK
	Q7VfOfoUGqiI+QljM6tI7w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcwyx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 15:25:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DF6B6W006219;
	Fri, 13 Sep 2024 15:25:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9cv1m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 15:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlUJeBPCNwbvnCrOO/b2ZKf5yxii04ON+zYJkNvFkVs3BsUCqEb8JittXmX70dlAwzGKkAEFkjzzcfksuof4vizmxFj2CzY8PPIAXrQ3ADkpvb57hu+mXRnA8misHr+jXkOVhwZHvAzyhsKzkJa3GIDLLnjeUZsCXabguAqbw6tPfpgicrBzp94uEgg9hAShUB8iBEQYKv9vurPs6h+0k+6WxfKauyeL7hWaoUhuC41W9AIX+W6fRFu6M24mG+7kglgr+V7oneNufWWkCSDv3iyyI8SZXq3i+Egx9R8MxM39mK2uzegWIu1T+y2JwCOQGh0UBqkjxJnDdEsMuHpwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoIgQC21Yzvdn97MDlKQkkqfhkeQUP8MKr3tj7GA2mI=;
 b=anNvhFxxA3GM64B8vkqyOmoOF36r8iJeQ83JISM5bBe6kb5L46TgKG9WnPVIveGRWk6Z7XScHPdlCjh1LwtAsIk8ajwrnSF9D0BnAHuDQD2Rf4s5sitHRmSxwsQcloxNafBXBn0sG+W/ZPdidFuyzAlesicTCXaKDM/r2VefbtfPv68qoU0JXoNqN6R4opnyXZPXyPGNUF6l6coQDQYY2KBu7fjMOzqIA6dzoJRvtMW0qz5hgZSm0jmUco4aJ7O3kMGuUtyy/g1+w8wx+wLEnJoPEVHsqXy8KclFo0MSSmuspGlhckUuk9dyKXd/MRNTDewmEEH1i1eF9gHzBWVJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoIgQC21Yzvdn97MDlKQkkqfhkeQUP8MKr3tj7GA2mI=;
 b=JV+dSq92DWkpokSb/yhA6xlyth5U7sNvp2CoKtLYtMe5vVglgpP9AICBdp/prWLPgI6Qab+XooVpAZKnYRGqaqqXR4qHtEamQH/oec+PHsFbBeMWlKGA5C+nB8X6WwO1slDSGWh12SZhfKro/hmas4xmfy1KYCwotrtJkgnNmiM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7563.namprd10.prod.outlook.com (2603:10b6:610:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 15:25:28 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 15:25:28 +0000
Message-ID: <bf2a075b-1f30-475e-9d64-c96bbf646454@oracle.com>
Date: Fri, 13 Sep 2024 16:25:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/4] btf_encoder: cache all ELF section info
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
 <20240912190827.230176-4-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240912190827.230176-4-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0422.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 9222f153-e881-49c9-6783-08dcd4084c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWhMSlBUMDdSQm1xWVE3d01QNzFBSkJ2V0l6WEt3SGRvcUUxanZNcTlNcmlV?=
 =?utf-8?B?VnNhNVJSVmhjc1N0Snd2UE9KQTgvT0hHSmw4NytaUmZqN3hTbFhLSFdJZWFw?=
 =?utf-8?B?bDl0UCtRUTZya0Nkamt0aUY2c21qZ0NLYUEybVVYelhGcmw5dm1JeEk2ZnY2?=
 =?utf-8?B?NjdrN2lwcGVDc3RXRzhGQmRvT3lZVnR4V2t6RnFwSEZJcGdjakpvaU9yRzJu?=
 =?utf-8?B?TmZ5WlVXSVRXbjcxVGdqNFk4djVwYk5QQW40WWREUUViaUNzcG41Qm1rUXR6?=
 =?utf-8?B?Z0NwWjJRb2RLQVc4cW5uSC9MRlJQZ05QVGkra1IyZ2JIcjNjYy9lOGZzZzhP?=
 =?utf-8?B?Y09hSnVGUlovT3l2RmtiWTFMeTFLWENsTnpGTmFXQnZsdEdFNSs2V1BSSDNX?=
 =?utf-8?B?NFJXZzRPaFNZemVvcmNvL2RHOU9BWE03TjJnNzMyUjVXUzBwOVprMTBYdHll?=
 =?utf-8?B?U3A0bG9kWXh4c3p1TmpSNWpTYlV5Y0lCWU9EWHdFL1J6REoxQ0lzVS9xYlY2?=
 =?utf-8?B?QTBzeEozUHhSVmE1U0hhY0JIakh3OGt0WWFyOUUwSzdadXdwMWZBSHlnNmtS?=
 =?utf-8?B?Nk9JWGp1eERSc1A1OEFlUEpob3FkSVc2OG4vRzNJMWxyeWJYNEZtdDlUckoz?=
 =?utf-8?B?T1JoTWFkVHlnS2tkTEpxRWhtQ3k3U3FNNjhXNkZEWjBUd3h5by9tR2RnNlNH?=
 =?utf-8?B?UFJIQWVvWXBaS2JaWUFpemZmTzNIbXVsVDV5YVlXZStyWlVKdXNHUkdTd3Zt?=
 =?utf-8?B?ZXlDUnlYYXVKd29GTW9GQ1J0cDd2SzZEYUFCTkZQNURzV2l1TnNQcml5dit2?=
 =?utf-8?B?TExRcmRJVlV3WUY0QlZKYUtxdGFXcWFtMm5iaEdJbU1QdTMzU2JzWTFHaWNC?=
 =?utf-8?B?UkJyVVNPYkVyV2ZiZFNoV2thSWc4QU52Qk8wVUxGZEVRR2NSMEViWjB0Y2I5?=
 =?utf-8?B?VWk0cFRvZUNrbFlkTVl2aVN2M3RZQTFVQ0VFSFhqbTlCWDBLeEZDcjNiMkJk?=
 =?utf-8?B?eE9YMU5jSktOankwUEZPYzlKTDBRWTdEbFlZemMxRDYra3BPeDdQNHh5clJx?=
 =?utf-8?B?clZSa2RBUEd2Vy9oSjMzYVQ3NVlia1RqdVdUdHJubWJsNEtDT1JKaHIxWGp2?=
 =?utf-8?B?ZGI1VGJNSkwrY1ZoZVhoV0svZXZTNTdqbUo0VUZSS3pCd3RSVXFQc0xrTGxQ?=
 =?utf-8?B?MUlaNm83c2tPc1N0RXpKK21JK1NFRkZ4cGVvL3pxR0praW11T3BpV0pXRklI?=
 =?utf-8?B?Mm96eFhNRXh2dlNnRGZGYXZaajMyaXc1TktkMUNYYWdqVUhwYnBKd05CN2t0?=
 =?utf-8?B?UFRpS1JHN1VhOStGYWQvOXJ4Yzdla0RucDNxcUFiVmpnOGc0MDZ4UVk5eDFh?=
 =?utf-8?B?em55QW5FNllQUms1RkNLbE4zK2xjY0xTOHFiVWhBaEF5SjdkeCtObUJzUDQ5?=
 =?utf-8?B?V0kvRll5RjhwMEp5RXovaVhJNUZJNjZCZ0VVczBUU2ZIMnFhRURZVyt1b3lr?=
 =?utf-8?B?aFdVcGwrU0xkM0V2VGRUL0JMVlJxY2ZJdGc2czhtMVI3OVo4a1RFSFAvSFRK?=
 =?utf-8?B?ekV1RmxkRlFqaHNyN0dmNUF2c3Q0K0I0d25Bb0lSUmZlNkFSdGNKVnRpUjV5?=
 =?utf-8?B?NmZxdjlKOTJLVmlZRERVMDhvK2RnUnpIclBWTUdSYzNRYmcrV1VlQzBqWGNm?=
 =?utf-8?B?SGRzZmhhVUIyVXozbThCZXdDRVRWbUFQcUpWUStJS1JSN1dQWFJ2UU5oeUhs?=
 =?utf-8?B?bFNQRzN6Mm16MEUwd0ZOZ3ZVM1V3QzZzd3NrVWJNWlBUOEVlNnJ5WXM2eWd5?=
 =?utf-8?B?Q0ZraFdaK3pEcC9sVmd3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1SemtWUWd0ZldVYnN0amhaeHA0c0wzREV3MUhaOEZhTktJQ2xIaTRkMXI0?=
 =?utf-8?B?T1diRDR2bERjRGExNXhOWHRySzhIM3Z5OENwbzNES0phNnI3NDlrRVpsMW9q?=
 =?utf-8?B?T1ZxSVRwelJtbHBZNldHTmJoOWdtcGw2VVovUTR6MmFlOXA4NDVlY3VyQkZk?=
 =?utf-8?B?eTBqRFl1dWJoSlN3WlJ3QTJacW05WEpMUmFKNTZRSGs0djRENXp6RXdkQ2Yv?=
 =?utf-8?B?aGRrYzlRU3JZRk9PZ3hlSEV6TklwVVZRMmNtNnRIWkVsbUNybzcwVWJLR3VB?=
 =?utf-8?B?WkRoOFVQbW9DRVZkeTdaWWxEWnc5TFdpdFN1bkE1bXcvd2JFaG9WWGFmcWxi?=
 =?utf-8?B?SnZ2SlVKK1ZNS0FuUFBLOEZrNEhzcXM3Lyt2enBjU2w0UTBFdFhoQU8xZGxt?=
 =?utf-8?B?NXNjMHNyb3hid1RkTEd6WUcvd042ZnNCOTVRNUQwTDZwcS91UjhyajQ2SmFD?=
 =?utf-8?B?OW1FUkZ6N1N6SkR2akVJaVU1M2thcXBhNkZvT2V2TEdpbWVsYTVJd1lISVBt?=
 =?utf-8?B?aGRObjlIdlFwUm9qNElRYXArM1BnclZOSDl5L0plbklGczRrQm92YWtydWdj?=
 =?utf-8?B?Y3dwRExKSkNPdTdYa25PZEY2dFBJZ2dMOThnaE5CakduS3RBMDBpRFNPcHdL?=
 =?utf-8?B?eHc4Q3N2TDVqVHdpM2Z6Q0o4NkxveE1RZWp4VlZBL3l3aFZrU3BLb0VVYmFy?=
 =?utf-8?B?cEdWYWROQUJLa2ZXWlhPenJaRVhhTks1Z2tNL09VYkltaXFONTNmTTJoenU2?=
 =?utf-8?B?YUlKZEFmQ0x4ZTNtc0I2VDFSWnJqN2Z1anNmTGl1T3dqRmNDODVJNExiT3FU?=
 =?utf-8?B?ZWVtNmFDbXppWlZXUTl4dUU2OG0zVlFVbDB3WVBSYW5lYTB1eHIycHJDeGds?=
 =?utf-8?B?dkNQcDR1RHpFTlYybzc4b3Rva0cwRklNSUpOa1B1c1ZuUVpJaDJtNUxQNnUy?=
 =?utf-8?B?dlo4dUZoQmw3MVVjL2JTaXJwZVdYejRxTm9ncFFKMzkycXZud0NxT0ZMTHdE?=
 =?utf-8?B?cHFKSFM4UmY3NTc1c3VUMjFFeFpGeUw1dktaVWlMZ0VHVUo5K2doc2piSTdC?=
 =?utf-8?B?clN5dFY0QzFhZGQ4OTQ5OTd3N2dQUFBtbkVTRUczNXNiZk9QQkw0aURKTUtS?=
 =?utf-8?B?UkEyR0ZlejdQK0txcjBHV0ZOckpTS2MydE0yVnBvNFNYaEltMU1MQnFCaW9C?=
 =?utf-8?B?QTJJenVwUnViOVFjWEIxL0kvVFVBb0x4UUtMMUswak9Mc056NDE0Mng3ZWUw?=
 =?utf-8?B?eEFvbVBodUxDRmhnU0FRL3VQNEcyVHQ5ZHBhNytzNlM5MkQ4NGd4UHdsdVVy?=
 =?utf-8?B?RGt2cWFvWjB2bXkzRkNXcnpmS2tGUTY3Y2F5K1NGVE9KemdmOVJWMWMzTmJl?=
 =?utf-8?B?YndKWFJFVk9uQXRBSHRpcWU1TURYWVJUTFNJRCtDUGI5NG9hblQyNkh3cGpX?=
 =?utf-8?B?R09VRmNXN3ZxUVFoUWlJMmNwUWdCRHpPTEJTVk83MmQxVjFxaEQ0cCtyc0Iv?=
 =?utf-8?B?MXU1VUZWQzRkT3hiYmFjNlhIR2QwbE1qRFZhTEpSdWpVdHJsbE9mNk9IYk51?=
 =?utf-8?B?NUE0ZEtMN0xoREt2NG9ObitaZVZJQURQNk52emdoMUo3dGI5QVUwcmlLS2JO?=
 =?utf-8?B?ek90dU0xeUpDUkVSUENMTno0WXJlVjQwa2NOMFZxcXZSNzRQa05PUzU3eXlT?=
 =?utf-8?B?SFNDNit6MFVVVnl2YmoxdnpjcjFuVVZCc3ZoTW1DL3MrMVd6UStvUW1LTndC?=
 =?utf-8?B?cHdXWFZ4VzVSWGh5SE1kZzZUeXQveE4zZFdKbXFCRDdHaTRaUXpTTlFHME93?=
 =?utf-8?B?SjhHZ3ZXS0RBallpdWp5RXdzWTh5UytBZGtGRVgreTBMN1FEZCthSXV1aVVm?=
 =?utf-8?B?R2dYeVpvMGUrN3ZHVmo0aGRFbFRjNWxmY3NuUjBMdHJqelFDVkdlZXZLK3pB?=
 =?utf-8?B?anhvVTRiUjdNcTZsbXlNUUx5a0J0SmpOcTdYRGo5WEM2enhqOUw3enQ4cDRl?=
 =?utf-8?B?dHVUblVBMUxyRG9vTGJwd1VDSFVITENYUnU4UEQ3d3J5L0ZWYWEzRlZGczA5?=
 =?utf-8?B?NDQ3bDl3cVpxcWhkbTR6ZDZLNmR6VFk5WmxtbXVhV1VrYlYrcS9qMGJWcmdT?=
 =?utf-8?B?U3Z0SCttdmkvemlacGdjWGtqMFVjV2NFYVU4QWFCRDkyUEEvMlhqd3VDaHRH?=
 =?utf-8?Q?fh84BSsrRZL2UOYwwW2HIzE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9CwI/5auEQRuLZkDUk/HirAjZoeqIqSearbv1We9BPmmcwBsCQlvT0O1udcClVLsyX5NGE5PpiIfWVZ7mkFN6UEf9frU+dSBcYEAWHlLhC8bNxfCpv+8y/7q3eMbPoJdq1rh6fSi6vKdsiBSMHjBNXBL/0FB0+EYZZvr0hCrqcZokxWMVKAB02mFB69EGjNByi31ROC5hQR6iItJoANinuMfjZUKV/n0SH6jheW+Es1AryN9wjSkLV+KLg/HZ6rMJPj/jEaG+uHnF130HiFQ5CGR+4FDKsMqwucI+/OMYi0+MiRvlala5/x58PnNSG2NKg5Jt19F6kYzZQkUyv8+W27TvkcJ7QolsRjKJOcdbuCvFIBcXcdqSLcFQL7qGrXo2P29HD47SpBxnRpumG6Xmj84JMDeoTV0Gmt8i6CpmGizD1VMOX3ECFRzHZKyeTUPfilolCvlqjnAIexeAylqXBEuSVlFix2CYY9wIb8iVBwW/9wPo6QVtmkXbeBctYdGnJjTNh92UgfRSEL3eba3cbDKPRCs4f5rJqAAlNwf1YyC1uvNGVwhnLzUml2fmTSk6p89M+7oEAZVlAbcl6u49QvYa9DuJF5KUZUdUQvdV5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9222f153-e881-49c9-6783-08dcd4084c62
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:25:28.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FsgPlbqT3kR+juLn+Ri30G7ilwDavZq5qwJTKa5X2l00HpfM8RvYeQNpzjpg1qELLICBrqSOiQ0U3U/dVc3zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130108
X-Proofpoint-ORIG-GUID: vGzhZY5U1TG9mpkH6BIL4Cxr8anRGr3e
X-Proofpoint-GUID: vGzhZY5U1TG9mpkH6BIL4Cxr8anRGr3e

On 12/09/2024 20:08, Stephen Brennan wrote:
> To handle outputting all variables generally, we'll need to store more
> section data. Create a table of ELF sections so we can refer to all the
> cached data, not just the percpu section.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  btf_encoder.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 8a2d92e..e3384e5 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -65,12 +65,20 @@ struct elf_function {
>  	struct btf_encoder_state state;
>  };
>  
> +#define MAX_ELF_SEC_CNT    128
> +
>  struct var_info {
>  	uint64_t    addr;
>  	const char *name;
>  	uint32_t    sz;
>  };
>  
> +struct elf_secinfo {
> +	uint64_t    addr;
> +	const char *name;
> +	uint64_t    sz;
> +};
> +

One thing we've run into before is hardcoded limits get exceeded on
systems, and while it seems unlikely for 128 ELF sections, I think it'd
be better to make this dynamic just in case. Also for parallel mode we
have N encoders so it might same some memory (which we're pretty
profligate with in other areas). I'd suggest using reallocarray_grow()
as we do for functions. One thing we may want to tweak is that
reallocarray_grow() will grow by 1000 or 1.5 x the current size;
starting with 1000 ELF sections is a bit much.  We could perhaps
tweak reallocarray_grow() to have a min_growth parameter to control this
and set it to something smaller for ELF sections, what do you think?

>  /*
>   * cu: cu being processed.
>   */
> @@ -95,13 +103,13 @@ struct btf_encoder {
>  			  is_rel,
>  			  gen_distilled_base;
>  	uint32_t	  array_index_id;
> +	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];

...so here we'd have a substructure like this

	struct {
		int	allocated;
		int	sec_cnt;
		struct elf_secinfo *sections;
	} elf_sections;

> +	size_t             seccnt;
>  	struct {
>  		struct var_info *vars;
>  		int		var_cnt;
>  		int		allocated;
>  		uint32_t	shndx;
> -		uint64_t	base_addr;
> -		uint64_t	sec_sz;
>  	} percpu;
>  	struct {
>  		struct elf_function *entries;
> @@ -1849,7 +1857,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
>  	 * ET_EXEC file) we need to subtract the section address.
>  	 */
>  	if (!encoder->is_rel)
> -		addr -= encoder->percpu.base_addr;
> +		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
>
We will need some of these mechanics later when we encode function
addresses; great to have this!

>  	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
>  		struct var_info *new;
> @@ -1923,6 +1931,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  	uint32_t core_id;
>  	struct tag *pos;
>  	int err = -1;
> +	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>  
>  	if (encoder->percpu.shndx == 0 || !encoder->symtab)
>  		return 0;
> @@ -1954,9 +1963,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		 * always contains virtual symbol addresses, so subtract
>  		 * the section address unconditionally.
>  		 */
> -		if (addr < encoder->percpu.base_addr || addr >= encoder->percpu.base_addr + encoder->percpu.sec_sz)
> +		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
>  			continue;
> -		addr -= encoder->percpu.base_addr;
> +		addr -= pcpu_scn->addr;
>  
>  		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
>  			continue; /* not a per-CPU variable */
> @@ -2099,20 +2108,33 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			goto out;
>  		}
>  
> -		/* find percpu section's shndx */
> +		/* index the ELF sections for later lookup */
>  
>  		GElf_Shdr shdr;
> -		Elf_Scn *sec = elf_section_by_name(cu->elf, &shdr, PERCPU_SECTION, NULL);
> +		size_t shndx;
> +		if (elf_getshdrnum(cu->elf, &encoder->seccnt))
> +			goto out_delete;
> +		if (encoder->seccnt >= MAX_ELF_SEC_CNT) {
> +			fprintf(stderr, "%s: reached limit of ELF sections\n", __func__);
> +			goto out_delete;
> +		}
>  
as above we should just reallocarray_grow() more space.

> -		if (!sec) {
> -			if (encoder->verbose)
> -				printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
> -		} else {
> -			encoder->percpu.shndx	  = elf_ndxscn(sec);
> -			encoder->percpu.base_addr = shdr.sh_addr;
> -			encoder->percpu.sec_sz	  = shdr.sh_size;
> +		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
> +			const char *secname = NULL;
> +			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
> +			if (!sec)
> +				goto out_delete;
> +			encoder->secinfo[shndx].addr = shdr.sh_addr;
> +			encoder->secinfo[shndx].sz = shdr.sh_size;
> +			encoder->secinfo[shndx].name = secname;
> +
> +			if (strcmp(secname, PERCPU_SECTION) == 0)
> +				encoder->percpu.shndx = shndx;
>  		}
>  
> +		if (!encoder->percpu.shndx && encoder->verbose)
> +			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
> +
>  		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
>  			goto out_delete;
>  
