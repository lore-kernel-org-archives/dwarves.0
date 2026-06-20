Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFDB3403FC;
	Sat, 20 Jun 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945223; cv=fail; b=b+dYGRpIFGmhZ2qJYHZwxwqSUS4/CD4mySWBb3JdWjpzGOwikXVdWM+ucr9nCAGo6PJPfZhrNVi6LGDPCcic8sDJT29HOHH5an5PQ5nzae0y4M2dRVeUAjGLDPJKDPLfI703Lt8y3n81iBWFRUVR7p19ARHs1b7UiP5my1LTvh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945223; c=relaxed/simple;
	bh=5I8PsPlnlnRkrcBosbqvgbnr5AtokmfOqAJ4uq87Rmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KyWXcKsXf5DloEIncQOMges9WVmGwFTYIAIWrBFQcS00ZKY+AVM1a6cMZcP7j1dxpbG6SZdOCl1qyQ4KKqJ5PKuMp5IYvE6Rpv53e8hSPDCxtDVZaNVdLiBP9C8oVK7eBdnIWfVL1WmUseKJDxJHmnsaN/TIwNrJIB/CRmrRhuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GzzzQZnV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u/UBmhrd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GzzzQZnV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u/UBmhrd"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65K8CrgO664385;
	Sat, 20 Jun 2026 08:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d4KzLY2JxWrdQdcXag+hi0sHdpFxH2WulH4rE6uKkd0=; b=
	GzzzQZnVCo5b4P7Tgbnd+WfTnXQhzOxVFMucG3ZZq7GRu21QKnHCFAoRRGxJ07VS
	UHQ504rPA9J0NfgwOl92kCjvzlhj7ynmBCJmrWPymhAj3DR6nZspxaTliqB77k1s
	msx6Mik0u/kEOuc687IA0aIlwRM3HbCypngIJtFkzRObYgFED0EGi3Cg3CnAwqBo
	xeRPsbsBbrfx0N7it2Q0ttuZCBsG+8YMkdjrqa8ykbI2eX8vD001kAn+HY5NENFV
	ffncWYc5jLZKnQ4oKEqaxU4HKAfJi7ae82EznFjazkY6cFfwutq25rbixfimjOwc
	yTrtlZpSMw7yLsP29tM1aw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhf1g4xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jun 2026 08:46:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65K8hVF1026059;
	Sat, 20 Jun 2026 08:46:53 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewham6cqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jun 2026 08:46:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6J9dpIWBuaosLhxgWSlxc9f1+cpFLOwog5F96DsuyNhAJv4X4Fd+NMmhARn5HUb/RHIXECGaNL+JZUnmbL4V1uLDl2KT4z5m0v5ePLB1LvM1BiqNbM9MKu2jNvCkOSXnrhBpRu8vi6ifm1/zkFGRXHBKxbz1P/mynp2xiQroTf6wHd66hK2tE4qkFI5yKoryAI1eDxPrJxICsq/ha8KbuERzJO//hGs/l37GKE7/EL5pftr5bHmqNyYaU9m6Fx69fJz8MXIIsgoJaxQL/fKJX77NwN9gwdFzkRpCSUXKB5yGidex8q16t0GoqPmYiojrrWNAkcngWyxVyfTi+WF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4KzLY2JxWrdQdcXag+hi0sHdpFxH2WulH4rE6uKkd0=;
 b=WxcLj/aHv9Aa/wHmt+hmlCFA8m6tUAvwRsBjCPla63nmj+H1eSykjSubFWNxT1IGpK/RTQ51B4iklih18L+p/YCyya+vIpaYCg2D1W8SjPqjQIX1wR2u61oF3QkhHrJ4Jg1sxb7n1BBjVGq/jIKrQuIRmBp7FfE+xnTYRwmGEKp84x/YCDHv2g3eORc2/l3Xz3YPsMfo34Rc9mhbgzzZtbPbTXj7CwhcPK1aC1pYROCdezpb+waBi5HT5ZqALNvhb7HPmS4E6hCMbak6hIDzGyNasPajNx6mbiUzf5s5tf36oMfvvzbdUXWm30jzMetf+BR4mDPnU1n3uCiS0GrlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4KzLY2JxWrdQdcXag+hi0sHdpFxH2WulH4rE6uKkd0=;
 b=u/UBmhrdP9PxbkUli+eivfvN3uWxxbxmgAx5ql8o/lMNHPSw3Wat6i3wYRuHmEix+85ZGFwnq+hfuq+NwGezOG6b0+zrcQ86sTTpytgnq9QFwFt/v03QSeymu86e5eITQojHJHGXyTkoSfq8NNOVC2YDeoK4Hv66xp4EvE3xcIQ=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ2PR10MB7735.namprd10.prod.outlook.com (2603:10b6:a03:578::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 08:46:49 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0113.015; Sat, 20 Jun 2026
 08:46:49 +0000
Message-ID: <675af05f-6f76-4a37-9619-5275fb941263@oracle.com>
Date: Sat, 20 Jun 2026 09:46:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v6 0/5] pahole: Encode true signatures in kernel
 BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260618011358.632394-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260618011358.632394-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0105.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::16) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ2PR10MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: d4497714-0a7c-40f0-e328-08decea877ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	CvKyskvrtoXLg3UpoyiZHIeJd0DEJ1SEqmxce0Y+7pgxvu+zcP6GXGZ9FZxkka09DatvWsn0Axm3ecb2HHQew9gvemfsa3TKoIuvGl5nlZdrQgKB8wumnTMx6fNbpJ7ERbEjFho6IKjJBeqxfHX83wGQXn9/JhxrxSpyVROn9G+/tHi+rkSPr+bpZtSPbBKT28Ix0BVHBbr8qMcUhPLB0hGh+BA6ew+vlYJ3ahbLfXD21igY7mqutogBYniCo9K9zNQ1obOE8hfN583NHHbuLCF0O7/V+t/BmEqpiNVu8qPvO86WejAWIwxJV55MPZaKEQbqbQuP4OxsM8g4rP7uM8y6ZtzyHXc3seGBnT8Tx0KnOnz8qdNcGN4YJYBjNrygVkAlwso9bd/myyxJvA4OkZd2a1f2hV80b3RFgOLK2CPARyTiS0yQtN+9Ep199bd9ntPhuDA5DgHXjcENQaSgLhhYBj4Uoj7zJBi1jjSAlm7XXQP7hzry61bnYXCuYDq1ld0EfmLYCdp5lq3GotipYrN2lhlaHtn59W5Ncv1HT+w5EEAdaJ8yiavacAK4dLvRvGc3zhzN1Czx1Q7yhIC0VK/0kkS1gD1uYGoIY0PPG7CRHB1SWLpWkvpTp5viROqeR+96hp1gA844BYimdV6WogdKzVQSuBG6YtEPqQMH36E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0FlMm1vc1BVQjlub0dUd2hRUkhUMitNeXRHa1NGZGU4eTBkRGNUL1krZGln?=
 =?utf-8?B?RytBUXJwMHZ3M3hLOHFEcFd6S3VQL3pwRFI3b3BReWZNL0kyZkRtVytuMElX?=
 =?utf-8?B?SThvY3hYT1FXV3ZlZzFYR3BnbGZ6YktEVjBURHhOY0xJcytaMGhObVNOeThN?=
 =?utf-8?B?WEduOHBrdVcxRUxuOE93T20wbytPcGk1LzBVMDZoaUxNOW5mYXlsWEwzUmVi?=
 =?utf-8?B?TXU2TU9maG44aXlNejBndGgxNXA0WmlVVzBjSmd2NHYyZ29pVFRSdFl1NEM2?=
 =?utf-8?B?NlBnMmRLRDBRdkpxVVRxU0FrMWxPL01MUlVMb1VSdlNzWDJaYTB6MEM0WG5P?=
 =?utf-8?B?ZXNOY05yZUFEQUEwVFhBSEZhQXRlVXpDUlJBZ0pzR2pZZXhzV2kzRzhLTWJu?=
 =?utf-8?B?TWQvTEJxL2g3S28zTnprOU9PVHNkUzhjbGxkR0pReEs1QmFKeThOUk1jOUEw?=
 =?utf-8?B?VHdNVkVTcUpCbTBqaTFieVdLNXBJRzlkaE5oWE8wNHNNbTZ6Q0NmVWwvR2o1?=
 =?utf-8?B?ajB5a0Q2dnZDeXNkZHR2L3dWSFZTdC9XamtZb0M3clMwZTlZdktNM1NiV2xR?=
 =?utf-8?B?S0NlYXRKZDBPeWtlUU93emhzMGxnL2QxUTJUNC9LczR2WE1LZ3pib21qNkpN?=
 =?utf-8?B?WUhQTDVOK1RDMTBFbkZ1eHB5bjlwNTdsNkxkc2hqRUVXVXFBemd1YXA3U2VF?=
 =?utf-8?B?TENkMWhabVh3Vy92MHdUN2pHTzg2MVgyak5wZXlITkNWM2pYa3FLYmt3bVZp?=
 =?utf-8?B?ZkxmZ3FsQ3djK3FZSng5aGtLZExObm5rM0YwK0dMOXd0WnB3b2dkL3FnSUJM?=
 =?utf-8?B?dFkxSjJ0ZzIwV0JqWkxqbFZja1ZEY1lldHBISzBPTWxqOE5vR1dMSFRMTVNB?=
 =?utf-8?B?WWNjT3JqRmRtWFRwTTBBZWRRdlBubm43aXk4amhERjRwQzZsNEdpOSs5eE5w?=
 =?utf-8?B?bWE2RzNZdmVHY3NjSDhsL0l1SmZsVjlBK1FzSHg0Tkg4eDFpV0FxZDBiOUNl?=
 =?utf-8?B?SGVxVVZlemVDWmJrMDlPY3lLWno0SWhncXd4UHJMZVBmSjdpYlk4aGlUQmJW?=
 =?utf-8?B?ZDNzRDUrSDlUbzRlMVYwdkYyM1picEVpT0g5L0ZaMXEvMnN6V3VXSTNRRTRu?=
 =?utf-8?B?bXZ0VmY2VHJMY3A2ekRaeXczK3dpQ2JDRnNrSWlmcWZzckw3dnJ4YTlUZjZI?=
 =?utf-8?B?Q3dqc1RLNkZtTFIydnNCV282RjNWWHIvWVAzdDg4OU1NNko4R1NqSlVxb1lV?=
 =?utf-8?B?V1Zxd1g1Tmd6YUJWQnN6QkhXbmkxdUZ3TmZHZDg5Q2FUNUtKOGJMbjNEdjdZ?=
 =?utf-8?B?d2RPTlUzZEc3amIvZTNYUnFtZ0VTUE4xLzU4TWRRdnlEVjVIODk5cGtRSHFI?=
 =?utf-8?B?M1FkMm5hVDlBRnRFUDBScStCQzdBK0dWK2VuRmw2aUtTSnRBMjFKYy8vZ2l0?=
 =?utf-8?B?QTdrZVFXS1p1UzBaY0ZEdkhJTWlYcVJNbkFkakxoelVmQnMydml6Z1BJS0VN?=
 =?utf-8?B?aDFzUHVGSFZYZkR5bXlHRm1nMzVEbWlGTXVsQjhqb2JKWm9pdndXUHExVlM4?=
 =?utf-8?B?RVpSckhuNVFINFJLVFZPNlhwMFphdXV5N1VHZ3c1Z2Y0VzJMWmE4Um1uREpK?=
 =?utf-8?B?cDdVRVpuVkRQK2NSRGpYOERvcE1QRUJDRlVjQ0EzMWh4QklER2RTaWJDcVpn?=
 =?utf-8?B?R3I1UWgrenNIckptOFNtdUEwaWsyRjZhV3YycHJyZ2k1RGNtNW0vZG5LZTVE?=
 =?utf-8?B?MWg5dk1jNGQzMGFaQ2l5N0ZuZmVXQ01PRWw0L1A3TkJYZnVtcDgxdFhVVHNm?=
 =?utf-8?B?blBuVjdtWTMrKzdJK0l2b1I4aVVKNmUrKzgvSWFJMU5LRE53eVVndWlQWWtO?=
 =?utf-8?B?R3h2dFZveW41aU9WVHRuNk0yd2ZFWjN4YW01YUtRS2lKcUw3NlF1SmNqRTBR?=
 =?utf-8?B?UGZqdzdyU1huTWdWMG9RN25aMVdkczAwei9Ibis4WWF3bmR3U1M3UkhvajFr?=
 =?utf-8?B?aTZOc3pwMDc0NkgvWmc4OTVPWWduRFpaSzU5VEhKNnhuTTFaT0pQWkZMWEV6?=
 =?utf-8?B?UTZkdm1ZUEllUFZTWUtNcjlUK1RoMVdSVUsyZjlFdHh2VG5XS2hOVmFyZVF2?=
 =?utf-8?B?TFdmWXJzakVITyt3QmwrR1RXWmU5dUpyU3k3TWhIdlJZbmxYUXdaNzkrcVkx?=
 =?utf-8?B?SHVPWDdDNlZoNkpaT3V3bExabU5MQmcza2s3STBIM0pYYmZKV2x2ek1sU0R6?=
 =?utf-8?B?Vnc5NUlTVndiRkljZE9hb0dDTUkxeUhDT0ZnQzJpRytEdHJzZWRieDhLaTJ2?=
 =?utf-8?B?ZXQ0dkZKRHBlNWtwYU9mdEFqNGV4SW9pV0EvK3hpaUtVZGdYbDY3dz09?=
X-Exchange-RoutingPolicyChecked:
	lP5mDllyAeL54u+59NWD5LiD8RvyjNwHUygmtQGQ9GaAygkc2pH+NNXkpUtD7NLCKP3we8JYtm999PAeA0PY83tgQcBrKTDWzvYhYkULKnYEMBOMtgIPjxwMwio3s5bkyzWZgflpFDMNmMn2Z8JFPMFboN1u5OA7vKMV0pc3/Ajoa8PetwCmukKlQ6c04I/2pWeciaQYJrc9U/vzWXcSaBvYKVpho7ydAf5hwmYSFls1QmfF4mQb64ynX1Ejl0MVRujt4A5tzIZ6/27HvhkOxK+04MkqEGAeptJCYDCagvR0aFSfY0242ccw3jCUk/bkg23cEeKK86b+OMxwSyUdJw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LSsoAeBzUx3g2DJNnRUKvXqjFImmfu3vk1v+Pl/Rp2IohOHn+Qt665szWaM/dEXMSfPcP9B7/EpOHvoLy7GNMZBe8lrEmxQkDSOzhKmQcyWKP+3ckTkCcdAPB+9VUxvCkUOo9L8K6BwJeLgzozQ1IsFXtvobBxsuCNCJsfGmflPeFAIXBwaMhEigtX0JQAQDO8I/a78K9NO9rAPCx3VHlrQ4z6LMj9kEF8fWHefM7XB6QcMfUYx4wJ2+dyqBshHJCIlEASCFKaMeLZDBjraR6XYQQP7RXXAKvETBHg+4OW9TT9mDqLrryIrqMQBTYEHrIMDUwy609gzaQ2J/Ozz0oJlFLtHS2bTK1qQCB8qXhCbC2bbevLvQscq1/4tt87DovDaNVfhhxFb+JiGqPcAswK1iX4yZImWizzjf1bZ9w2RQbgNJwpw+X7hfxjugBkyDsWZbiVLRoaI+H/WkOQTLGEjhU6jpLn/5/zJi/6WQIJMDhRPkmb3ImKppY0GTsHyg7/rkuJ5AQt7rlTk2sQ56A08+bl21/M9Tyrm/53xIH8RDdO6nzjD4v5U392LQzR1EfZ01J0fUCm27OvWyhvKp/S+22FM8ARSlhCuJebBzKEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4497714-0a7c-40f0-e328-08decea877ac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 08:46:49.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHYraDE0XIJixfJoP0x9c9NTVAyvnOuJzNBSmr/8rEcx8qvxGJY1IFmt/O4C6/CFHTYLDjdadrnAa6TPP34E3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606200084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDA4NCBTYWx0ZWRfX/DI1tPiR/PpS
 b4iRv5J8pvDbrf8E+EtnJt8AC6wgPctKul7NqxWFXVwytRHwT45H7Q9eHFRO7B/bkh57J8EqLvZ
 xdsvIyscXNqquzFzZC8Ig+qnwDs2+t6xmUs/aYFBaZrhxZioregDN1sUXe4XeNA/MJev+lYOZUE
 O0e3qDv16ILskwDRujQvCiy2+3Fo0SIGyCt0oJAS7X5KHdh+upiDv3qH+R0D46GCUXdAckZh+tT
 qqb7p5aeRDrEqO6gk68qhYdGZ3ucHLCYcJQSwHIXjN5jC86qwFrUSlcMRC2wG5hFWah5OkAezbz
 HbUUH0oHzSUp/rK7lPSTx3nIH9l0FODIByzLSsVyuZ4PQ3gpUFnisbvxkvMd482m3T3wGK1DuK0
 cp5plMjT2xVIer3EW1AUN2he/9ZZaEDWqbBm6Tvv4yAqd3NyLbBySfaP5bP1D7yZWpm/pHeAsUt
 MULBSuPZqZdXsbQItCSro0x4SqPczMjVxyEB8vRg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDA4NCBTYWx0ZWRfX0yBJqPxd9CCX
 2Tb2PCJ2a427wAQrVRinIi08CNmP/83JI5sowbOZRgk/xmsWKmUar8nHyNUSuqiXMIMnoOeybHN
 pwj3iFLXFHU2FUOKJ8TchO6kZAFekduP700cRxpzAtqbY9918s2g
X-Proofpoint-ORIG-GUID: JiT6HRpnwDehTpPMpiyw4cdFoY37QXYB
X-Proofpoint-GUID: JiT6HRpnwDehTpPMpiyw4cdFoY37QXYB
X-Authority-Analysis: v=2.4 cv=A+lc+aWG c=1 sm=1 tr=0 ts=6a36537e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=eEJmrmIP_k1uEPnyfaQA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313

On 18/06/2026 02:13, Yonghong Song wrote:
> Current vmlinux BTF encoding is based on the source level signatures.
> But the compiler may do some optimization and changed the signature.
> If the user tried with source level signature, their initial implementation
> may have wrong results and then the user need to check what is the
> problem and work around it, e.g. through kprobe since kprobe does not
> need vmlinux BTF.
> 
> Majority of changed signatures are due to dead argument elimination.
> The following is a more complex one. The original source signature:
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   typedef sockptr_t bpfptr_t;
>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> After compiler optimization, the signature becomes:
>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
> This makes it easier for developers to understand what changed.
> 
> The new signature needs to properly follow ABI specification based on
> locations. Otherwise, that signature should be discarded. For example,
> 
>     0x0242f1f7:   DW_TAG_subprogram
>                     DW_AT_name      ("memblock_find_in_range")
>                     DW_AT_calling_convention        (DW_CC_nocall)
>                     DW_AT_type      (0x0242decc "phys_addr_t")
>                     ...
>     0x0242f22e:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>                       DW_AT_name    ("start")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f239:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>                       DW_AT_name    ("end")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f245:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>                       DW_AT_name    ("size")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f250:     DW_TAG_formal_parameter
>                       DW_AT_const_value     (4096)
>                       DW_AT_name    ("align")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
> 
> The third argument should correspond to RDX for x86_64. But the location suggests that
> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
> the parameter value is stored in RDX or not. So we have to discard this funciton in
> vmlinux BTF to avoid incorrect true signatures.
> 
> For llvm, any function having
>   DW_AT_calling_convention        (DW_CC_nocall)
> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
> and 875 kernel functions having signature changed. A series of patches are intended
> to ensure true signatures are properly represented. Eventually, only 20 functions
> cannot have true signatures due to locations.
> 
> For arm64, there are 863 kernel functions having signature changed, and
> 108 functions cannot have true signatures due to locations. I checked those
> functions and look like llvm arm64 backend more relaxed to compute parameter
> values.
> 
> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>   -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>   +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
> 
> See individual patches for details.
>

hi Yonghong, changes look good but we do hit a CI issue; specifically
in run_selftests in [1] for gcc+aarch64:

3: clang_parm_aggregate.sh
Validation of BTF encoding of true_signatures.
   On arm64, BTF and DWARF signatures should be the same but they are not: BTF: long foo(struct t a__f1, struct t b, int i); ; DWARF long foo(struct t a, struct t b, int i);
Test ./clang_parm_aggregate.sh failed
Test data is in /tmp/clang_parm_aggregate.sh.NH5a6D

I think the problem is that as well as creating aggregate parameter names we
need to decide whether they should actually be used; in this case it looks like
we hit a function using aggregates, but without DW_CC_nocall. Perhaps the
reason is that the calling conventions are preserved while we only get a piece
of the "struct t a" argument? Something like [2] seems to resolve the problem,
please take a look and feel free to roll the fix into one of the patches if it makes
sense. You might find it convenient to use the merges of your series at [3]; they 
merge your work with Vineet's tag changes now that they have landed (just patch 1 
required merging IIRC).

I also think it would be better to add clang+aarch64 to the CI matrix in light of
your changes, since it will give us test coverage for changed functions for clang
for both x86_64 and aarch64; I've sent [4] to do that.

[1] https://github.com/alan-maguire/dwarves/actions/runs/27839367799/job/82394707921#step:7:24
[2] https://github.com/acmel/dwarves/commit/22d0512680d2ff5b6dd4d1e34ae603efe0f2d098
[3] https://github.com/alan-maguire/dwarves/commits/dwarves-true-sig-v6/
[4] https://lore.kernel.org/dwarves/20260620083056.361658-1-alan.maguire@oracle.com/

> Changelog:
>   v5 -> v6:
>     - v5: https://lore.kernel.org/bpf/20260523165712.1225231-1-yonghong.song@linux.dev/
>     - The previous change relies on parameter__new() to collect and analyze each
>       parameter to decide true signatures. The new one separates collecting and
>       analyzing phase from Alan. This two-phase makes logic easy to understand.
>     - In btf_encoder.c, remove usage of skip_idx to simplify the code.
>   v4 -> v5:
>     - v4: https://lore.kernel.org/bpf/20260326013144.2901265-1-yonghong.song@linux.dev/
>     - Check info.signature_changed only under clang.
>     - Fix an uninitialized varable issue (var reg_dix) for gcc.
>   v3 -> v4:
>     - v3: https://lore.kernel.org/bpf/20260320190917.1970524-1-yonghong.song@linux.dev/
>     - Add simple prescan of parameter registers in order to get true signatures
>       for those functions where optimization could happen but compiler didn't do it.
>     - Do not create a new name (e.g. "uattr__is_kernel") with malloc at parameter_reg()
>       stage. Instead remember both "uattr" and "is_kernel" and later generate the
>       name "uattr_is_kernel" in btf encoder.
>     - Add comments to explain how to handle parameters which may take two registers.
>     - Fix some test failures on aarch64.
>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20260309153215.1917033-1-yonghong.song@linux.dev/
>     - Change tests by using newly added test_lib.sh.
>     - Simplify to get bool variable producer_clang.
>     - Try to avoid producer_clang appearance in dwarf_loader.c in order to avoid
>       clear separation between clang and gcc.
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20260305225455.1151066-1-yonghong.song@linux.dev/
>     - Added producer_clang guarding in btf_encoder. Otherwise, gcc kernel build
>       will crash pahole.
>     - Fix an early return in parameter__reg() which didn't do pthread_mutex_unlock()
>       which caused the deadlock for arm64.
>     - Add a few more places to guard with producer_clang and conf->true_signature
>       to maintain the previous behavior if not clang or conf->true_signature is false.
> 
> Yonghong Song (5):
>   dwarf_loader: Detect aggregate ABI register usage and signature
>     changes
>   dwarf_loader: Collect per-parameter information
>   dwarf_loader: Analyze per-parameter information for true signatures
>   btf_encoder: Emit true function signatures
>   tests: add BTF true_signature encoding tests
> 
>  btf_encoder.c                       |  24 +-
>  dwarf_loader.c                      | 548 ++++++++++++++++++++++++----
>  dwarves.h                           |  14 +
>  tests/clang_parm_aggregate.sh       |  85 +++++
>  tests/clang_parm_memory.sh          |  77 ++++
>  tests/clang_parm_optimized.sh       |  63 ++++
>  tests/clang_parm_optimized_stack.sh |  63 ++++
>  7 files changed, 812 insertions(+), 62 deletions(-)
>  create mode 100755 tests/clang_parm_aggregate.sh
>  create mode 100755 tests/clang_parm_memory.sh
>  create mode 100755 tests/clang_parm_optimized.sh
>  create mode 100755 tests/clang_parm_optimized_stack.sh
> 

