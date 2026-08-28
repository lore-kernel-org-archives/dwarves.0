Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70B367B6D
	for <dwarves@vger.kernel.org>; Fri, 28 Aug 2026 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929428; cv=fail; b=swhlrwr0ZN0faYReoXMn7GrMkKHId5NBgd5rSsHb+puoiBX/jvW0s4iqezWxeWsE8Ow5GZPP2exhFF9sOh28qnZY+9u5DKdhRd69HuXr10GZhENfhPui6pYIoE9ARqMi+iRPSBL74fNNZ82hsGmo715tGgK1RTT23dI7rB7bd8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929428; c=relaxed/simple;
	bh=5ulZcokpvDR/Y0lmwl651W6khyzXIUoXSnSeYertzLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N9CqhRL83w66Lls/UoOkMQdtG6m0jSVXCxB1nZv5iBE8AGWa/22j6zMoueHets1dnIg0acXZOwHClaHAsi9iJHPoe1U5dv1Qu/8DgFutEGcCp2wMTs4k3j1xD1vspqayb9JffWQJxW1vl7FT0p0/B/hNRXfyfSrJ9L2xZ6Dtsqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r9OrNOvw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gJZmqMU7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r9OrNOvw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gJZmqMU7"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDsFjq2788990;
	Fri, 28 Aug 2026 14:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ack6t5Q/P2c/iaZq0Xvaq7fNywjeH3alx4Ii4yNmZak=; b=
	r9OrNOvwJpEOn8X0D6tDwtp/1aY4oaaUZ7QAfhcfqg8hJEEWGNDXbJKFAyB6Euty
	5dGQyKu6/8J2Bg22B7j5UmtbZzGte27y5Lgi/PA9S0YshM5oC3S4ebgJJRShsGyg
	4xHsnkNG+HlcHl52C4MuX4F+Lk8sNwQplLNhlRACut8+PByHvRFxDzzgWecAd2O/
	E74C+4cBpLk4Oh+Gr/Pa12alq6S7g0cF4FZYVmfYrz5BLXbkxWwAhYIvhJlbj7u+
	KA5D2dnFaacT6MQwUZR/zXrvLLEzjfoJ3/5hKiwrEyzbe3VuqZnMjjabSMRO+xQc
	xim03eT3g5WCKtXIsAwx9Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72j220ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 14:05:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67SE562Y009613;
	Fri, 28 Aug 2026 14:05:22 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g850yn8yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 14:05:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpgznZ/6wlwpLidVQokTIxYIq23u+5kOUm2bSpdhn/pmjvVNH2Ln7ZYQdiwTVLjevKkPqUyiMCG6ODCWFTFzqWGWEyBMiJ0lsEI6wkbFAJYnxE3liL2zUqpsgrNuHJAQjsxsNk3BkXDuSCquNbiu2lHB3UI2MGo06MPcOG//+qmlwOMhJ4fTrWs8CxZCbTiFl0jyeIhHVKIF5L/8VYOKJk0bDmXpjcUDwbxofzkU4NcbkYrBX7Nea0d3ZMTEHY6eb7g7KhOS+ZcQCw6akbgZpnrnqgBB68ZZfSZI54dQPygeEWE9lSdh5vYFuLd5wgS8BDRxX/75eGyn30QhBBoYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ack6t5Q/P2c/iaZq0Xvaq7fNywjeH3alx4Ii4yNmZak=;
 b=Sp52QOpdHY1y1amcOKfsbSeWKnY23+5s1mzKxyhABW9IuOQ5AtB29FSo6y4Oaoa/uHbtLNCyWT8Xt/eTnDZv/SDBOz1tnnXNZeEXhoj9O8oN1GEvgIaleKB1Zp41lYSFpG3EZM8SDxfNnIKi112DVHtpway3tK4fuJP5ZEMUd1xdvTyy86RNlw3jDhGoPkE9njw3XSxx9J26gmeNbvkGP3JCjHK5SdS7XgEmiRsZlPCOGEUXqlIiKO0VVnXKEs7BAxfy1wwskBQ0d76i8B5pkGM04HezHBE7PLQjHeO22dhlRIQhZ65f0V8yfWMRIWnPEJjAhOjDNQmk/fQmFv+Hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ack6t5Q/P2c/iaZq0Xvaq7fNywjeH3alx4Ii4yNmZak=;
 b=gJZmqMU7/qmAX+q+1NJSpex5zc/dB420/VLwWExgxzC7DPZR3IgCL0zisStUSwfTWpiJjQ3lhydHGeCBFrCAD8i+qiRn/gXIE8OEMvzB23lfkii6IcK0dTicWSIz6cLU9zA2viMxHW3+IDfeYTv9QnCOPOZRzFK6xwlXu7/TimM=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MN6PR10MB7466.namprd10.prod.outlook.com (2603:10b6:208:477::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Fri, 28 Aug
 2026 14:05:11 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0382.007; Fri, 28 Aug 2026
 14:05:10 +0000
Message-ID: <0e1c3820-c16b-4266-bde4-655b760b3db4@oracle.com>
Date: Fri, 28 Aug 2026 15:05:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] pahole: Support cross-CU type references and dwz
 alternate debug files
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20260821213510.22423-1-acme@kernel.org> <ao442rldWrCNG3zC@x2>
 <d85a69a5-b08a-4ec8-b09c-4e45b7c1f712@oracle.com> <ao7lqxytDiHmVmkk@x2>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ao7lqxytDiHmVmkk@x2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::12) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MN6PR10MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 546af85a-db0f-47c5-1f40-08df050d5e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0+b1XQHviXEuS5pdz19pQx6Q34Ig/XYAOWnrS5UFGWH04/s9dRDAK1I0PgSz0YHNzYNDQ6OPTZSSiDO1tNBBVrX9cJI5kyKj2jh+D227X4Z8AR4MGK8GcupMwwSMlEuj2AvfExl5xNbG/OjRNgEUhZZ1CbM4SOOkulhUnDSOgkwKa/yqVhv1OKDq2PQAuEld0I/fV02JxZThhAVbTuMuIYOwmBWUqX3RZAQSnMmXE6eRErMdxvsNXytTBtX4lRstEkaeiNMGQnTJvEpJ7xfEBrL6VG7uRs+Rafb7PW9845SibrT/Lf7ELwGIlcyx8yPuKSYpr5bsgrd74w7+OfquRr5WtpyuUYE2POulFY8B7QRA255W3lRZuhVly4UZw3fD/zlQ7i2EMAl4jsiPDG2kqaRNSlcj+ljeMECT6+vCMuJevbHxicTIk56ekjcbZHeOYCuUcvuWt98/3pYK0dtP74vVj/OWu9vZCL6O17Ug7fZn98n248cLQwsXttgRORkNJD1xOdDZa+dBxGwEL1MW1+uPDZA+EAW5kzC6f8O70uEI1e3mwDYVw0kAT48FhMREMxdC9Zy+M3X8bFgu0hQNJfvXrCagEUNXK3Da9xYZENX52Gg/vUaGf+Hvt6Wv108oLOCEOo5Ybax6NxhTvdvXqQAYRJN6w8Ih/CpO3aAdBOw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzVaYU1rQlF6S0E2MHZkamh3YWhCaE55SnBaTGFURXNaUnllQXpVNkk0NWk1?=
 =?utf-8?B?U1FpZktnRGRkVlFJYkpDTDBRL2EwM2w2bEJ6TGFhRDJwSHhmQUtWSzlST3R3?=
 =?utf-8?B?YXgvNkJMMEgySDZFZ1Q4Z0RjQXhLV0t0bDMvNml1TWdjSXBveE9tTzNFRnBk?=
 =?utf-8?B?L0g4eW5ENnIvNUUrL0w5bTNtaDJPWFVFeTZsNVZGZzhsRXNtOEFwSWU4UkxN?=
 =?utf-8?B?T1FWTmFtcnlwMWZTUFpCejFuS05lUzFZYjYyZzdRcUlabWVxc3hWRE5GVGl1?=
 =?utf-8?B?WFZNdHpnVVlBSmtsZHI2RmdHZjk4bkxZT1E3MHkzR3RaMHROQ3pGVlVBbzIx?=
 =?utf-8?B?S0QyNFNWRURVVU9JcFIzOHRYS3ZEZ0t1SXNVV3lwSjR1SUwzdnFCQ1VxTytK?=
 =?utf-8?B?amQrUXVSbUtJNEhOOVF0bWlTa2hlWWJtVjZ4dFVDcStWQmNuWXBzdGhmVHli?=
 =?utf-8?B?UnBWK09DaElycW1XeUtpM0tpeU5ZVWdBZlhORkF1aWtMSXF1ZytkZXlmOGZ0?=
 =?utf-8?B?d1pDWDN0emxDWXRQQkNvdTE4MlpOZ25TMHd6OWdiZmx0azRRbk5XSDhjL0dw?=
 =?utf-8?B?TnJFQ2dKUEJLY3RQMHA0TUFzUVV5RFhxVTNsYVdnRmZCaVJOSEE1MnUwUU00?=
 =?utf-8?B?RWNMMU9IY084dEVCS1B5REYySEt0bEZUbXJLSkhsNFJCa25vOVlkd1hzakx5?=
 =?utf-8?B?UzJuVUxkOXUwVS9EVVk3TWF2OVJCUjlQT0UyMzlpNHVkTEF5enJrZERjMkFP?=
 =?utf-8?B?NXR4NlBHZ3dBM1lmOThoUE1uOXowL0djUnBEaHlYUHJCU3NPVkl5aWlsQUpM?=
 =?utf-8?B?WkVOOFZnYko3OWhXZ3JTMElDRDg3WkRnZm9GNTVaL3ZtV2IzaWpQOHdGWlRZ?=
 =?utf-8?B?L1d2QUFaemhlZWFHK1d0Z0lUdFA1all0dVp6SjZtOTF6VXN6QmJ5RkFqcW03?=
 =?utf-8?B?M0FLWFJNSENNNUk0RU8zN29JVjBCSFpsQmtNa2hERGVON2JtT00ySWlnYmRF?=
 =?utf-8?B?VGE4bDNGZFdWYWo2VzhMUzl1akFIbWNnMm9KalNJandVeGZzWVMvRG9pTkcr?=
 =?utf-8?B?Q3BVWitxZzNvVEMwWVdERXVVRHFiK3NIWDRTU3NZZWZNTVcyNkFBbzlCVGVj?=
 =?utf-8?B?ZXZGQklSQmZWSm13ODYzMzBMc284eUhZWkZERW90c0puT20zYUllZFlZWnZE?=
 =?utf-8?B?Tm05cE5Lc1dRSFJ6b1NkWnVHbGhKOE00QmF4QzZHaUlIN255QitsRW5WM1VT?=
 =?utf-8?B?UURRZjM1WVhvdG0yMDdHTzhuL0NnVSt6bnBJeFBqQmpJS0xZbGFGYjZ2YkJv?=
 =?utf-8?B?KzA3dzRZSXhPNUVHMWlaeXRXb3hweitHOWgwY2lXUUJRa3BlQ0xvS1ZBZWh1?=
 =?utf-8?B?QWhidUJYTENVZjhETjJUM21md3JZczhDUFZDa2N5T3dzZGFFbEVZL2lNRXNk?=
 =?utf-8?B?OGd0b2VzTlJSUnVsYXV0S3BzNXZibmFJZlRTNUdFS3pUTGsyTGpxZ0gwNGpv?=
 =?utf-8?B?TTY2UnRQWFEzV1p6ZFJieU9QVERNUXRjVTZjSC9Ccy9RY2llV3cvMlJhTjJC?=
 =?utf-8?B?U2ZuS1g4K1JjNUlyYVg0c1BVUTZMV0M0eW11bVNFVEV1Q2VPeExDeHRDd0Y4?=
 =?utf-8?B?QndRRituSlY0N29SeG4vSnhRRVFzOG9sNEx6N1NKb3F0VTFtTkY2M2orNWpP?=
 =?utf-8?B?L2hKVnR4WG5MZ0lTMG9IaGEzTVd5YzkzRTB1aU9JME85dXlWOGhjU2lxRXg2?=
 =?utf-8?B?Yjhhd29KaTlKZjROMmptV05yQlR4YWc1V3lTK1k1ZGhQbVRUVFlnSW4wNURS?=
 =?utf-8?B?Sk1ZbFdTbGtpRTVlcmE1NGE0SlF6cWlRVkFScmlXTTZyajYzT0EvbmZxOHZZ?=
 =?utf-8?B?djhQU2o5MVF1S3lHbFg1VSsrM2tsM096RmxrVzZGVmN4RjExcnZsT0NiWms2?=
 =?utf-8?B?Qjc3UDZxejhucE5wejNaWklZcTdQd0xzNVk5SStBS0NOK1h6am03Z2k3bG5Y?=
 =?utf-8?B?d1hKeEVTbHYxUTlabUpFcTZlV1ZlNC81dE91Ry9ydS9RTTlSd3VFbnpYWmJ6?=
 =?utf-8?B?WWg5UmFQZE0xMWdTSHM3dUROdW1aS2p5eE9TUEphWCt6Ri9pbGlDdzRiS29v?=
 =?utf-8?B?R1NBS0E4NlQ3bXcrRXh6ZjU1ajhiaXVQblBOWjZtQjg2ZzhEUTRxUUVOZDVL?=
 =?utf-8?B?eTJGYm1jbk1IVy9RUllnek5VQTRYNm0rV0NZeEFVaWNZR2tETTNEa2g1VGIw?=
 =?utf-8?B?cFM2TURLL3BXbStQOFBpSFFaZ3JSUUxRQk9TMG5Md1M2UUFmRUdzWjJNZWly?=
 =?utf-8?B?eklwbmt0RkRLVzEwcnBIME1XSE9qZlNURS9PRzhoYnMwQlVOeW5xQT09?=
X-Exchange-RoutingPolicyChecked:
	OUm8SQJ+dvjnLKnsQFLKg0E9WscW/joC09Z8691j9UbqjarQns/cPSlHC7oDz6l6OPJyfqODYeyt08ey6QcrbxH+bJwNbhbxBZeaudmkGqoMIKmdiuyhF8F0t0DTB/TIMcWNZgUaaq25wxIVZfaJ5ZWWDTD6ubddsEPUEHtV6Womsp5+xlDa9GRUNkS2IDZLdXpF6HRQ3yvi0Z8axgUaJXv1Jn0SmtW1uRGL7W5RLOPd+6v+fJnpQT3Qeu4hzV0WWwaQaeSM5CSJGQDFXWTm0twmnUZY7VUl9z025e2CZCUOh7I7MP/WBHjw0C6nWIUxl/scYhh/epZhV/IK4i36tA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6GY4fAI8sTHeG1UeWqYqsTuveFYnIIjhWeN5DPyFcDytqlSQ/8sWfuroeR6a6cS0GJZCESn4AA83CSP7l03Fvjm7S/fpUFkje5NUWSJJybZ2nqUGG/7ubCumZEAJaQlyYXGHAgJpPMpAkCUWaWE8OwIC9NakEdjiDuICCcgTO5jqm5agInTvKnoIIpyyI717y9vUCb4tXiPoou/jXRnsh99QLf6hogK7MraIOokTr84KHirPe7ZyPE8C8SAsxTthQEsd/ip0zwC9BMIWwoRGaRL1oIeCbORPE+BYWDE9SLZbEaA4OydojEEqOZEWslhsCa+Mreh2xKQsMIs1LJ9R575/vyqV3BgdhoF9tB9DAqkDVbLrpN7LxYG+KDExqJWFr4wroyZ9tXCQPETvdFJlF94P3sn+BdgNqvIriizBkhl/cZ8+KB3R89Klwo38Mf49IcZJ2XnuktPpMiPKldz3ikpIqPRgnXaScSZ/xhY4EmmuCYWp58tCFJEv9szRut0gcNXGIGE+nisIaKMgjRvOqh0hr1Dx7MXJlF4oBadjb3Dr/FhoZ1K1YoAw6iOJu/TNAIpTmYbTp5dZVnur4q172WzLZxFK7KoTVHjoP8Ub/CA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546af85a-db0f-47c5-1f40-08df050d5e45
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:05:10.8905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCtXGKWeJIdYFzMsZtLD43vWromMu8dgooOQ5Rt6mlrrokNJTUKXYu0Iv5Kg5FFi4F5RkDDw1MMS2Q48DtITPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608280122
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX9jOhocPXYPS6
 9FLba6bKeZ4N17SYySkCd30s/NRL5SMD83lps2YawBA7C4x2mc8qeb17zLQZqRBWoyO0lIXrgEF
 sJ5Z1DWsF7u/g6ykV86QzIYOHLG9DrppbVzBQsVUFN+D/co+hUvu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX8ldvO+qXdxTt
 fWY0DMCXKACCd7dgb6ux7dh+4cJmJOzWaoSVDFN1sfPqs/UfOd1fUy+GXtqR3+KzQi71ZlkCViC
 jxHrA0hQv0F1ohzc70QWohSU+ZUmVZ2DLMmV4FWOU1S4+JGzWPvIqV40mrpypUcvdNKwc8Bhc7B
 j8+LRg8kMcGcJKTK155awLP9iRaw06l5cMJn5prKPmftNx1lJiDtu1/GlaonGTr8r+XP75Jgvxd
 X1SIX4E/xUyIy6DnlUVIObxXptKTyEykmN5qLKcyeGnwAVtU5Bh3DJVpRzcLZRHLegj1D0aC2VO
 5gSNWMyyneJZ7vD3e1zkjiGV45P2BexoiJMKh7dYhJmkoQoUpe1nzVwmLfm1QARRfjE15W4SqxB
 E3C1BsMZqDQJMt60HJ0vKGTN6BZVgRgW1aHRDiYJ8GIuVzNHl9+EGWbfslt0n2e6uIbduK7pmEp
 BLbzeBTaIujM2wThIZA==
X-Proofpoint-GUID: ax2QZwxJNbtydBpb-bp1Ynjboucb2OvT
X-Authority-Analysis: v=2.4 cv=Wek8rUhX c=1 sm=1 tr=0 ts=6a9195a3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=iT7Ebfg4wq2R-qLmzZsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ax2QZwxJNbtydBpb-bp1Ynjboucb2OvT

On 26/08/2026 14:10, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 26, 2026 at 12:43:09PM +0100, Alan Maguire wrote:
>> On 26/08/2026 01:52, Arnaldo Carvalho de Melo wrote:
>>> On Fri, Aug 21, 2026 at 06:34:59PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> Add support for cross-CU type references and dwz alternate debug
>>>> files so pahole can process binaries (e.g. a perf binary with rust
>>>> objects, or Firefox) that use DW_FORM_ref_addr inter-CU references or
>>>> dwz-compressed .dwz alternate debug files.
> 
>>>> Cross-CU type references:
> 
>>>   Force-merge CUs that contain inter-CU references (DW_FORM_ref_addr)
>>>>   so type lookups resolve correctly.  Handle same-file partial units
>>>>   where types are shared across CUs via DW_TAG_imported_unit.  Fix
>>>>   cus__merging_cu failing to detect DW_FORM_ref_addr when
>>>>   DW_FORM_implicit_const causes dwarf_getabbrevattr() to fail.
> 
>>> I did a lot of test runs, and with the patches that are waiting for this
>>> series to be landed that stress even more this series, so I'll merge
>>> this tomorrow unless anybody have anything against it.
>  
>>> And then as a followup I'll land a series of test patches that don't
>>> affect the functioning of these tools, just do coverage analysis and add
>>> lots more tests for its features.
>  
>>> We need to release a new version as there are people asking for features
>>> developed and not yet released, so I'll make sure we get the goodies in
>>> and the release out ASAP,
>  
>> Changes look good CI-wise, one issue that we see (not just for this series)
>> is that perf on some systems is a shell script that selects the kernel-version-specific
>> binary, so the result is tests relying on perf being a binary get skipped.
>> Not a big deal now but maybe we could come up with variants in the future that
>> generate inter-cu references reliably locally.
> 
> So, one of the patches in one of the test series is:
> 
> commit b7938d358c59c279a33a2c4de8943e5469a659bf
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue Aug 4 11:07:38 2026 -0300
> 
>     tests: Add automatic perf building for cross-distro compatibility
> 
>     Make perf-dependent tests work across all distributions by building
>     perf from source when the system version lacks debug info. Previously
>     tests failed or skipped on Alpine, Debian without -dbgsym packages,
>     and other environments lacking perf debug packages.
> 
>     Add get_perf_with_debug() helper to test_lib.sh that:
>     - Checks if system perf has debug info (file command, "not stripped")
>     - Downloads perf-specific tarball (~3MB) and builds with DEBUG=1
>     - Caches build in /tmp/pahole-test-perf-cache for reuse
>     - Supports wget and curl for download (Alpine compatibility)
>     - Skips gracefully if build fails
> 
>     Uses kernel.org's perf-specific tarballs (HOWTO.build.perf) rather
>     than cloning the full kernel tree (~200MB+) for efficiency.
> 
>     Before: 3 tests (inter_cu_refs, prettify_perf.data, prototypes) skip
>             on Alpine 3.20 and other distros without perf debug packages
> 
>     After:  Tests auto-download perf tarball and build from source
>             (one-time ~2min setup), then pass on all distros including
>             Alpine/musl systems
> 
>     Update 3 tests to use get_perf_with_debug() instead of checking for
>     system perf.
> 
>     Tested: All tests pass on Fedora with system perf, build-from-source
>             path exercises on systems without perf debug info.
> 
>     Assisted-by: Claude:claude-sonnet-4-5
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
>> I tried a few other approaches where we handle inter-cu references, but all seemed
>> like they were a bit too complex or involved multiple traversals of the CU set and
>> were too expensive time-wise.
>  
>> I can land these if you'd prefer, whatever works. Thanks!
> 
> Please do it, I think its better so that we try to have multiple people
> involved in landing features that touch the code code like in this case.
> 
> I'll then land the testing infra that doesn't touch the code code and is
> less risky.
> 
> Thanks!
> 
> - Arnaldo

series applied, thanks!

Alan
