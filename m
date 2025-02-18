Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1222D4C9
	for <dwarves@vger.kernel.org>; Tue, 18 Feb 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876229; cv=fail; b=b/pYREhQ02VrsnYcLU2hUXsjHd11Px/H4qIJdTobLRSw6VJFoLQk4i27lKbSrh+TgH7YTpo5USnQYDnb7WzFVGes32gYgKQHMlEPjWuI43ItLNxxWBuWrPOc13zSV1F9aqLKcu0PILiJVEO1TQdcSQMffZRtzm5a0meLTl9K0w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876229; c=relaxed/simple;
	bh=z3/aYIrgDSkJdYAZBqMkdM0ZfgUnvakwlEHAWRaYTK8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eObLHJA4wFwXjUr/FLlrzPVHjKF1n9mnBF+FM0EQnLdkXqB6ZnkXb0b7u/x0x5LT7renREL3XJi9v5MGX2Ith2m2Lbhz4CIZxDUExSlVT4WA2BOE3YwfKv5hCR/MA/IHgJBypbeq5tQTXh33yl9oRIj2ZsNRG7PgGoesR4Rcitc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mRU1Vktx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TFdriFIs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mRU1Vktx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TFdriFIs"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I7MYsm014501;
	Tue, 18 Feb 2025 10:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3e4kwuj642Ls1zdYErZWPEXd0oPvAni8EV0XoBptVj0=; b=
	mRU1VktxuqtJ0zguieQeHZqM/v7OU5+Qp4S4uoriE3H4s885x2zl+cd6N39CpV1o
	mshLD6sMyjerOKnjYlIJ1uzhVUgw15783erLojbZFrl2si8Zm60TFxDTsKq1jEry
	9c4xHi7lafP3XhIn6BSXw0P0rlccj8CVQP/TXq8yxaeuZdSua6xMFPGtsvOgyRpb
	+NEceibz89jzct0wv7CqhXkI2xb7WBm9LwOALwsIL7cHsFd7IGtgFs44PLKL38BP
	POPOWy+u1/BxEl+eax21KEDeuPvor3Nef6Fy06RNVGypjdu3fDY2mpBYwlUwHaYu
	RM61WJCBsqHovlyTOtkfbw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjhse7sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 10:57:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51I95KNZ002066;
	Tue, 18 Feb 2025 10:57:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thcf5waa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 10:57:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXOGXtGrSYXCD00P3I/MXjc9MGdAqtyLPfaG3skTJzj0nvWcpvRyGt0u7Wb0/KJYnhrK+wrb5k/hlGGr8JpWpEjcMo6Bf8kxqSd43hmrpEfLWxheTEDsTUQFMKrWZIteYlGapN2xst+lTM9WwZaKxdTZSG8P/DzOVavoScCPOcuvXx2Eohy8/LmfqYPf7RxsWmej5rwFmaRk5N93eHGpyWEf32ur57jRQsNmGwoNP4tR7EDZG1PVTryXvjKNNQ66U70UR82uwzUIbiXTLOcvNCRBxlm6X/ZA53lC3cLrR6X/qARq5LzyhZ9GvNOrvIYSJ06FonbUHw0/Na4gYb+Qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e4kwuj642Ls1zdYErZWPEXd0oPvAni8EV0XoBptVj0=;
 b=ct8ylcPOn62SWSDHUyowRgdViiT5yzlWe7GE3CCD7s81awy0jrj0C6oLzv666DeTeKLmWZpviG/1y1+3MNBxhsQ7R3VbI9sERy/Qf1WoFGxOG/WELzODN5/85k92sUEN1guyQY04us02rHW+FpK/938Ly1txlZ5YUEEXlQedPD3Z7uWzCAAmNqtH19bxKfRt7MVsy4L2BOa0uPnl4NlpCa2j/0+4ZIsCpFRlPkMvIyE/61dZNkJutus2jXb7layZ1XVG1r9zu+BDDt69mCjR3r1gniEOKS2/4l8QJ1bQO9QADjEjEqECytw1yaJLZIk0AUQgE3LM/kPk7SfAzpRJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e4kwuj642Ls1zdYErZWPEXd0oPvAni8EV0XoBptVj0=;
 b=TFdriFIsyxMr24Dz1MDGGXjX+2TAmhES2pI09RBFsE5ijTJDD66j0bMWp676Bb0gqroMnGnRV1u914Fxgm9EROO2mxNQpGl6I3Lr1L/JwgbbVjIwNh7lcegWaXClFHDnFWu/qoA09KKBoRxf8cmAYlYmoaX5GphJX4mXfRtR3Sw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6459.namprd10.prod.outlook.com (2603:10b6:510:1ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 10:57:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 10:57:03 +0000
Message-ID: <f000e43c-d81b-4ee2-938e-e1b4acbdcb1b@oracle.com>
Date: Tue, 18 Feb 2025 10:52:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Alignment information
To: Andrew Cooper <andrew.cooper3@citrix.com>, dwarves@vger.kernel.org
References: <07381c66-f102-44ea-8966-9a49222847b8@citrix.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <07381c66-f102-44ea-8966-9a49222847b8@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::21) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 635a88e0-d67f-41ce-a514-08dd500afa10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWFTYUJaK0NvQXFyUHZDQUhldmJVZVNmYmQyMmJRVVorbVhuYmFMYnpubXpJ?=
 =?utf-8?B?ZzN3dU5mMDhnalNNQWM2R296QlU4YUhvTXhETEJaWDFtMUVKNGF4WG9vS0Nh?=
 =?utf-8?B?bmFBQlhWeHhQMDlDRk10dE5nVE5XcGYrUDlNRDRMR3g3QXh0VElBZTJ2OG1z?=
 =?utf-8?B?ejIzZnhHSEtBVndJbVJzcUtDd1g0NU02R2ZJcDU1V2ZmbE9NR1FXQ0MwWDAy?=
 =?utf-8?B?WEFrRlFILy96cCt4UVBHZ1Jkak1tSzAxZ0ZMVmQ0N3IvakVraGM4TlJFd3Vt?=
 =?utf-8?B?K3FpZ3JUZU9NdE02NEFMeFpKY3VJRTZydTEyUUNDZTBNMjRtWjZFQ21NQ2o3?=
 =?utf-8?B?MmV2TlF3Z1N6NGkxZENNWThDdXlSMHhuK1hVdEJjcXBpbkNvZ2F1MkMrVlRq?=
 =?utf-8?B?VldhM1ptREJnemgyaktpYWs5SCtWSS9UOVhLb3QwcTFGMC9DejJYKzcxQnhQ?=
 =?utf-8?B?bHpkaEhtY1FhVDFhckt3UUNFeVBScjhERnJMSnkxeDByNWVpbGo4VXpLSDBw?=
 =?utf-8?B?a2RhaUNkQ0VKcXc3N0p5YUhIb0U2VUd1UVVlbnIwMmpscXBBTm15RGZXWXF6?=
 =?utf-8?B?ZFFHd3ZPTlRDcnR6V3laTW1FMU93Q2NPb08xVDE0bWw4M1JTNWtkN3c0dmg1?=
 =?utf-8?B?WTNLZVozL2lnSlBBbnErWlFOUmNvQk91WHpBMW82eFloa295aVVLWEpwaVZB?=
 =?utf-8?B?RU9YZm1US0pmWGRabUNib1NSR2tqcHF3b2h5MTJXOWRZNGVzckZnZktSdWFl?=
 =?utf-8?B?YXUwbWZnc1VtaS9aSlNlcmxQbVpKeTIwZFZXUmtpMTVjUjN0MzNHbEJzN0RP?=
 =?utf-8?B?M2phNTM1d281R3g1ZHpxYnYvWkxLbDhRTmJGd2xCYTZHNHFWSE5jbTd1eG12?=
 =?utf-8?B?TE0zcTd4Y3BJT2VaQkZ0WDMrdTMrVVhPblIreTIrWS96TnNqdlcxeGdEMTIx?=
 =?utf-8?B?Uk1OL0dicHE0WEUyUyt0ZmR3ZThzVmtmVzd1SXJQdzRPdTBSQ09vb2F1c1p1?=
 =?utf-8?B?MGM5WURMMmZBN0JHdzdWQTBkSUVTalAwd2FpREZqZUJNMGlMM08xMzNoSWNB?=
 =?utf-8?B?Umt5OHQvSXNxUUw5djVsZkNOTTNVNmdHcDc1ZElNMVlEcWJ5YzBzWmJzT0lT?=
 =?utf-8?B?REpVemc0VDM1QkUycmh5UlU1WXFQeHNsbXR2UFdJM0FVamN4bXdiVFM0dkNr?=
 =?utf-8?B?SzZvRG9EdDk0K2w4YWtyVThybThiNGYrcC9PSC94TEwvbHZ2aU1USVJzS0ow?=
 =?utf-8?B?R1pYelFRU3lkNEJqaG5uR2tMZGpDaWYrTnIzTWxnc1F4KzM0di95aUVHdlZR?=
 =?utf-8?B?a2ZCN3lyZW9WYTcvb0lwdXRyc3hDc2ZTcm50TnVIekpUMndsaUJadVprNldO?=
 =?utf-8?B?aHlNbXJPeXpnM21UL3cycGR3NG40UEZzbFZiL1BzaTlDN0ZmUGRhOWduTitu?=
 =?utf-8?B?NHFzNXdUVmZIanM4QmRjQXhCU1ZkQ2p0Q0VzRXNiZzNXNnczUXFjSFpkK2Va?=
 =?utf-8?B?T3ZHZHNtSUp6RFRTckxNbDc1REIyeUNKbjZKUnRjczRFR1NLZmtRd0o1M0Rh?=
 =?utf-8?B?Vi9ZcDNyMHFZbXZXdElhT2dwaUs1NmZWU1FWTzhjeHc3SmRrZ2FVNHBmSlVY?=
 =?utf-8?B?NkRJVkR0WWVYRzMrU3dPMkNYR2RJZFJWOThiM0pQTHN3NzdCZ0JuV2U4NVZz?=
 =?utf-8?B?RGxOaGpXMWJPVndjUUVBRG5kblZmNE9lYWk1VEtWVXRZUUxzUVB6YUkvTFpG?=
 =?utf-8?B?VENJdzRIbDVRWDFwQy9IWlh2cVlOdzRMMGxVeXFPczBTMmZJS1NyakEyZWQ5?=
 =?utf-8?B?Snl4VWpsNDQrcStOTllDeHlQbkFQc1pHOWNmMEZ0YlZ6Y3NmWW5PdzkxMisx?=
 =?utf-8?Q?8t5N/lVqvH4mi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SElXakVvZUhNQmdTWU8vL0FrTHFOUi9iMTFBckVxY3hrV1FqK0RzcWZkM0VG?=
 =?utf-8?B?Nm9OSHYyVEpueVplUTlKRnYrTDg3dGNNeUV2eXkwYjU5ejJYM01qam9YZWg3?=
 =?utf-8?B?Q1dlWTRYTnpoOUpXMEhGSVJyZlNKdjZlalVRbUpPaUJ1dnZ6em9qZ2JweUJs?=
 =?utf-8?B?UGNtU2c4RXlJbXYvcFZIUzQ2OGVqOCtyLzBnaElJb3lWUElHNUhZWFJhZUZs?=
 =?utf-8?B?VnFNRkp3bW5nNDFzQ3EzT0dIcUFXSUxEVGVkZVdIMnM4LzIvUjYvcW54ZjFE?=
 =?utf-8?B?VGl2N0I2S2JlSnJPRXk0TlkyYkRKKzJvbER6K1RVcU1WUGQzcnNOM09UMVA1?=
 =?utf-8?B?VHlPQ2tPWlFzbDRVNVNHcHh5TTJXUFM5aTlOUHY2Z3M0NlVzWkU1T0RKd0tv?=
 =?utf-8?B?YlVsRGRBNi9raGNGWXZ1US8xSDNEd3VEai9xcTJtK1JGTU5FR2p1T0ppNG0w?=
 =?utf-8?B?WEpxakEwM2c0MkJac2krdTYrWUE4MXBjcTdTNDV5RmVlNWM4Z0JVZC9uMGU4?=
 =?utf-8?B?dUtLbzhmaTI5UnQ2OHZla3IvUlJxN09CR0ROdXgrREcyNjZMckdhSTRmQlBa?=
 =?utf-8?B?TDEzYnBuRXNFVzJBKzF3d1ZUckg3S0Q5TnZJdHFyNGJ3S01MSlRWWnJRY2Zo?=
 =?utf-8?B?cFRsenArUkpreERaRDZPc1pLbG5EaS9qRFd6VmQ5Y1VlNm1wU2VaYXFuRDM4?=
 =?utf-8?B?K0QyR1RNM2VjVlcvdm1kTDFCbjVNYml3ejgwOFpjWTVTLy9qVnB3SGVVT3Na?=
 =?utf-8?B?ejZlbnNBelNlL1VGYTJtejRoYi8ramhvSHZnc3JiNXFCMjV4Q3l2TUZjRlFV?=
 =?utf-8?B?cGpjNm5mTnNEeG8rZUNtcmMyMG1mT3Q5RXpIdlNuV1I2T0QxcFcxdVQ3ODlE?=
 =?utf-8?B?OUpKb3hkb2h3WWUrRzhWdkNNQ1dIeWovejAwR2o4VTZoOUF6VkRoZTFkdWFo?=
 =?utf-8?B?TEhYOTllblBJWmxDbmxXNHJMbXV4cVBQZEFXOVppd3FMSHJpNzZxZHE4bnBO?=
 =?utf-8?B?MHV3Qkk4YjBHd20zdUV0emZxRk9Jald0cGxCTDZyQTB2amRacHB5czBlZmJF?=
 =?utf-8?B?Z1RTZVBwQVZBazRLZWRrVklSeEJwMW9VTjVDa3plOEhtenV3eUEyMzdBcjhs?=
 =?utf-8?B?cWo0c3F0VzJuZk1VOWxLa2JnaitqemthUm43S3pFUDB1WldFbDd0Rll5Ukdr?=
 =?utf-8?B?YXdueXZGWTdaUEJhcDVqak5YZkt2UW9hdE4zMzVFRjM1ZkpMWHdtMGxlWnlV?=
 =?utf-8?B?VGZVM09xK2liVTUwcEpVVUdSd3g4OFNMUi9TRDRQUkJkRXFiZDg0TFcvVnV0?=
 =?utf-8?B?TjFWZGFWc2hpQzdURk5wdTNxRDFmUkVyWDJxUlpWcmk3T2NRODNOSHNHSVZP?=
 =?utf-8?B?U2N3NEFJNnM3RzJ6VVd5Nzhwb3pvTjhvQldYNmp5MDR2UGttZDE1Qk0xU0Rp?=
 =?utf-8?B?YWZmd2ZCaUx0TlE0Ky9pWUVDZE94WXEzOGRHcS92Tm0yNlBISFJZakRydElh?=
 =?utf-8?B?dXdidStkVHo0MkNUbUVSdnlGcnpzNnFjd0NxcFZuOHRFcGQ5RVpLTmxlaE40?=
 =?utf-8?B?anVHc1RVREdzcjdoS1FLeTROWlYwZnVIRWFLVXk4c3p6NFZHZzhBelIrS0pU?=
 =?utf-8?B?RGtDeU8wR0FwMHZWNVVRMEFhdTE1WVgzazIwSzhiNDRYOW16d1ZWeXR5VXFv?=
 =?utf-8?B?eDRrQk1BK3lzN2RRSDFYd0Q5ZUMrSW1nMkFFNFhRZ3g3c2t6WThsM3RBeVpC?=
 =?utf-8?B?bzNsOTVzTGl2V0tIQlZyK2prS2tNQWJMWVJES2lQSW5IOU1Yck5qbjB6dGNo?=
 =?utf-8?B?YVpzUi9ubHhUR0NhYWt1WHd1N1VhTEpsTlZzaThlV29icVVHYzYrZmhXeThO?=
 =?utf-8?B?ZHBDcTFtZUE4dWIwNGpHYVFnNW1meGdtdTU1N0xaeXVSL2V4bUZrRUJPUzRP?=
 =?utf-8?B?bW1iZHhlUjhsMk1ubms2TlVhRGE4bnByWE8vcTlpTzEyb2NJMStPbDBFeXJF?=
 =?utf-8?B?Rng1SW5kc1RCRXV0Wk1VWVV0Mnd5YkZ5RFh3VG5xdHFvZzhrdk1nTFU4Smo0?=
 =?utf-8?B?YWMybkRONWNUYzlIM3VGZjJYVEl0cnlBTTlNa2dtaEZ1Nm9SUHNkT1ZPZFlI?=
 =?utf-8?B?cU52NG1iTjU4d3BiZEFEcTFRekdITVAzaGxOY2tkUXhDQUc1cE1hVnRBR1Fi?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LLai8TWq6jML44m+AnagGWwIx0kdcs4dR4XelEAdLaPq0+cgde5YUlMayPIzEpaI/3oXNKAtDzorPVkI5sCQHVaGCQbOzAfewR6ASYMvg1HbD01x02daCXE7eLQwIR45cJxbbVRxPt5dOo1/bMbhXogyCqIh1kC+eO59kJcFpxleyCs2/kohGygCretM3mUECbrLY+xbThSsgUJJvYXDH8hbl0H70dKYvq55pIgSF5yt2hnxX37QsJ4CSwYsUK50YCW42VZ+vN5u1QFHxrrFnsPqKsZwJn6S+TKhakxJpreHs2wUJ1zBSR/DYs8WQQm3xRdXCORQ1N0AhxoYiaYkzZZs903mmfgs4YnDHA5wNnIMjif+ln3Mk7HHaaifEeCo6T1q2Gj3hzMzFHgulaepjnEB88C4A9ZrF38gBU1FD/feCfz7hY44j9SeZTFZGfbJQNCM+3GuJ8XIxQlSIhvQ59r17WDCJ2aZt3dTfMLmHegOIh3xKe2NlDjZUlUB8Cm+nB1S3BSn8Vxxl9FFbJwUc9Ylflm0pDmzmImPuGP+YyQMMdWTv13Js0k2zh0b+oRwUtXgXD2kZAvYyB54Ful+XlsnROB2zI7O3Vw2b/fOHEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635a88e0-d67f-41ce-a514-08dd500afa10
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:57:03.3446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmeL78sNMWRn4zkeJRoNhQD/uqJjiVXNHHDk5G+ng+iue3TB0TjaUqpyv8WmZaHTvf9d8UFDm71O+CPX6eLEfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180085
X-Proofpoint-GUID: SWszGq60BPj-6wCC03n6SYTTZubxKKls
X-Proofpoint-ORIG-GUID: SWszGq60BPj-6wCC03n6SYTTZubxKKls

On 14/02/2025 16:34, Andrew Cooper wrote:
> Hello,
> 
> I think this is a new feature request.
> 
> I'm tracking down a UBSAN failure (only shows up on one arch, and it's
> in a list_for_each() so there's loads of container_of() going on too).
> 
> Newer versions of pahole have the overall structure alignment given the
> end, but I can't seem to persuade it to give the the alignment of each
> field.
> 
> More concretely, I'm looking at a structure which is nearly 4k in size,
> differs per arch and has an overall alignment of 128, but I can't find
> which sub-struct within it is causing such an alignment requirement.
> 
> Would it be possible to also print the alignment information in the
> comments that exist already?  i.e., instead of:
> 
> /* $offset    $size */
> 
> could we have
> 
> /* $offset    $size $align */
> 
> ?
>

hi Andrew, I might be missing something but I think "pahole -E
<struct_name>" should give what you're looking for.  This should show
any nested structs which have alignment attributes associated.  For
example with "pahole -E task_struct" I see the a few substructures
tagged with alignment attributes:

$ pahole -E task_struct|grep align
		} avg __attribute__((__aligned__(64))); /*   320    64 */
	} __attribute__((__aligned__(64))) stats
__attribute__((__aligned__(64))); /*   960   256 */
	/* Force alignment to the next boundary: */
				} regs __attribute__((__aligned__(64))); /*  6016  4096 */
		} fpu __attribute__((__aligned__(64))); /*  5888  4224 */
	} thread __attribute__((__aligned__(64))); /*  5696  4416 */
	/* forced alignments: 2, forced holes: 2, sum forced holes: 88 */

It's possible there are bugs that mean this doesn't always work
correctly of course; it would be worth trying if that helps and if you
run into any issues let us know. Thanks!

Alan
