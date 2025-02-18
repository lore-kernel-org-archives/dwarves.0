Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CCB174EE4;
	Tue, 18 Feb 2025 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875302; cv=fail; b=TlVJLK+gR299VNY6TpZruonNFQskUAD4YAUU+PSWrkQlai/8Cx7EyDT19nb3llZhHaBuPgdLVDHx8VCvA8KEvAE3MHuO6kb4kkLwksNEzn3NfTT/pHfPUUNiDD0YXFTWf3JCseLE59LHvAXSOyCp0jyA3l5iJ2Ed3Y+26gQ3YXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875302; c=relaxed/simple;
	bh=irPFyBq2Hi0nGFt5nZG9ux6ZF6gMntReKteALJ5sx7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=guwEbYWVfvfSebqpJm46LepHbOhkua6jeouf5ZThWG/kQ2wW+OmxRqNhAaq1ERm3sS3Rl6PYXiplEG/8ZsqkWDd0+VqIwIQWoZz5K6eWfTLN/PhbKsSrYhEwgFFwCDDuJscKKLniaykiRO7Pl+Psb+elYdd6elulu7vPZams5pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g0FpvbF7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BLfWgZFm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g0FpvbF7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BLfWgZFm"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I7MY2N014947;
	Tue, 18 Feb 2025 10:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bNiEDuezWgdAz2P/RQkeWxUXco46VbKIQ757LJVEOmI=; b=
	g0FpvbF7m33pbrRdyNkBDSQSj1zs/+YmadQV8vckUwDNSR8W/sxiHF6RH2Vl0Mm6
	8j0ADWJkaOfYeF4vLmzvTY1zCYdl9OBsrE56QE+T+T+0VuBVaablWoHY6P2tai1R
	bBUwMahpUefEA15EhuFmyQckCTYwL+DUbtwducHI0Im8mi9FRRVBCsIBHvFKhtMP
	GLAhY10utb/ZUldxIAJweoWzUTcgdBTaKcluf+GhOs2TMB2i6KHlvuSiDhGM7C5/
	2Gp+loAl4Ms+LRsUqf63SCzugpQC5KPa5+ayDfUIEgMZn+1F+k/d+QVtONDej3dW
	wUiJECt1CHWEGRio0l6ewg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjybxeuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 10:41:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51I9Ksra038898;
	Tue, 18 Feb 2025 10:41:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thca55sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 10:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9KPYU/2IuGclzeQEnXOtyV9CsFTPSz1rcFxZRC9Jxa+GAJjIlTo5vIEOYQgHVgFdYnOXXS0SfbLKeqBvXlfq1PiaC89GDaFnv+qCO7b0i1iTYVvTzRPgQFpAhioWE9BEtDsYCDfF4P4W7FDWMMGTwqinpJtrOeWZPj7vKErYbVtpEBO3w/O/GiTsc05/isOePFMyLf3HIaKrItChBZHQ3Si3B+a6h7DlidiqpVXl5grDtuIfb3VU+mZ4f69wNJhqiE8lVG/UDv/YI6UNZKEvzSrF43Cy8du40JW/nctSiot/5kp/OPhhV3uew4Pf+JIZv/hAqHILCyj4uwXN3zSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNiEDuezWgdAz2P/RQkeWxUXco46VbKIQ757LJVEOmI=;
 b=CdlpDVXnxw6bia2I9SugqccU/p59PV+3M8qFSUDlT5qdNKSp4dIUIBk8lp7se6rWz9pH4ppRe/KnoWNKDdgYdveGAD0dLGQf2i6ZSYbWlFPYS5En2DxntRHdqD8O1pt+vsI5sDZqNhwIg/5wfGouAK1BcE0Vop2OSDcdR9R1JGZcxnWWwmNgn3ZaPeFG1jdGj+0a5f2N2KOIXOR46ngRD68lV4ALbEfOZYwFt7S8y+UCSpsWc2iHaetxggtvtCXznnlRti384nTzor3o7w3eL0oCKV97oMNwtSNn1uUXk75EHrQqcOwphrlQViBWU6NlZeXSzA7U7yUVkKTlk/iJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNiEDuezWgdAz2P/RQkeWxUXco46VbKIQ757LJVEOmI=;
 b=BLfWgZFmmADb5ZjsqIvmuuMq7ByRyJMgRI+6RvrEcegAJtpftSRRdWv0K9/b3iSjlaFyVytIz73RVXl78g9QtcjmP4eRFpSWaQMcU7QKqRRxVaP60TOikNUuvaVpRvFvCgISYW+O9EETYyUWBvl/klbyjOi9nNuHCcMC0obK+Kg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5038.namprd10.prod.outlook.com (2603:10b6:5:38c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 10:41:34 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 10:41:34 +0000
Message-ID: <377e9ec2-35fe-440d-923c-8918756fc635@oracle.com>
Date: Tue, 18 Feb 2025 10:36:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix duplicated VAR and secinfo
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: dbee9cf0-d659-4552-0203-08dd5008cffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R281OXdZWlllTjBRRjVRYUJYZUR5WTR4NUM0RllsdTFzM0dVbk9ZN25vWkV5?=
 =?utf-8?B?UWh4VkJRWHhUaVZDNGkyK1hNNjVCaHljbUgxK1RNaFV1RlVycnFWRVlYb1I1?=
 =?utf-8?B?Z0NOdVdwYUpYNVRFcHM4Tko2Qy9PaWI4NWdvUElUREVBamhaMERGWXpaZUg1?=
 =?utf-8?B?NnVuWTlLaENXK0ZodTR2VXZuT3JtUkNBVWFLU3hPN25wOUVxd25tYUpuSHNO?=
 =?utf-8?B?TmJDMzB6NzlUK3l1OE9Qd1M2NURSNXN0ZUl6bGw2dW5odGIwNlZYQUVycG9x?=
 =?utf-8?B?Rks5eCtZVVppd2lpTHBOYnYvNkgyRzVWT1dUNzA4cmpUWE1BeXJtNmVmL3VW?=
 =?utf-8?B?VklzMlpMVi9Ua2QzTW9DZGNTYjM2bXZlRHNBcFNrd2xtNG1BdTh3YUpNVzNl?=
 =?utf-8?B?TktUQlFYTWF6bXlmbENUbVoyQ0YwNlZNTWFJM0IxYWpGOFRWVzk1QmpOb0F6?=
 =?utf-8?B?YlczR0Q1QkRxUFpzdE9MUmg3WTBGOWNIS1BWWStrUGI1SXhkSjNUdjBJT1Zl?=
 =?utf-8?B?TmJXZHFheFk0c2VzZXNWMktxd1IxV3RvNzQxVDJnS2NuVUFSKzhHSFVWTUpi?=
 =?utf-8?B?Wm53L2hNYU9sQkdZV2VWS2R2K2kzcDQyZjgwMnJlZ1FsZ0V3MlFxRDVQdjR5?=
 =?utf-8?B?Z201QS9iVFZjcUlpMmpiVU9oMmVCWmlXR2dxS3c2Z0RFc1QzTlhnUFR1ZjhS?=
 =?utf-8?B?elRpZ0NQWjhOcHdEOHVSOUpIOEFSSE1XOW9Td0luU2c3eWt1a2M0SFAzMC9V?=
 =?utf-8?B?ZFBaOEFTcGZiaDQvL01TUWNWM3BQOWNtbjJvU0l0cGdENVg4ZFdMcmJ1Q0NO?=
 =?utf-8?B?MStma0Z4SjlEVUJtMWwzVlUzUXZhekFnbHUvWFRQdFAxRllzQjhNS1VpMndJ?=
 =?utf-8?B?czNScmRZUWk3OE5NZmNwVnJmeUxueXhka3J0TStWeGMwaDIvT3BlK0Jpc0d2?=
 =?utf-8?B?M3NKWFlNNG0vQjdDOE9sZmhBZnE3NlpDUFhuNnhrNERvenZla1ROQVRwcjNF?=
 =?utf-8?B?bDBQaHpwSGpFSFJBSHN4RGVWZzM4NE5CUE9IbW54VHEwMUh5QmxpS3Fib3lh?=
 =?utf-8?B?aEtDVFVjR1ByVTA0Sm9VTkJwbzZkVkpzYkNoNW8wODFaNTJjZVFmN0t1RUVt?=
 =?utf-8?B?aCtqclJVOVBWc2p2VnJqKzlYQ0p0WDl6N01MWjFyUVZTSDkrY01UMVdZeWx5?=
 =?utf-8?B?Z29uVXhBRTB4QjlmRGVaQ25QZ1pUdEkvY1ZiNUpySTg2ZWRxYUFxU2RnaGhr?=
 =?utf-8?B?VWtxemM3bjBZZ3J6emlrekU2TmJ5cFNUWnZ2bWN1NElHa2s5bVBlWjc1RnRm?=
 =?utf-8?B?anB5aEl1VUxPcDhVdmdnYm9SWm1QanZzMlk4VXM2SnJUVkV6Nk5paDg4bE5L?=
 =?utf-8?B?SXc1T1FHWnJhZHV0S3p0UFVQcTcxSEJYQVZzalRXeHRXYVVEUzNqTVYvNmg1?=
 =?utf-8?B?YU5nTkRzTWtWekMvYWZJWURWOUxOajRmT0VHNTB3RWRkT0xQYnljMjZaUnkw?=
 =?utf-8?B?T3NsYkFqRVlpR0NxUUd0RDZ3YnN2Z0VpVGtyRVo4YWtOT3dnNW9POHd4bHZ6?=
 =?utf-8?B?bGRndStPWDZEOW13WlEyWnJkYW00VGJleWdRY1hEN1IrbERWdTR3dTZpWXBh?=
 =?utf-8?B?a3FKajk5OVltT3FOVE5hNlNVcGxBeWhnNTlTeXRWMXdSTlZaMnljcmdlOTlS?=
 =?utf-8?B?NHZWWENyVVk1KzJURFR2K0dpM1VScWozTGplS3hmYkJSengvaTV2UkdWcVJC?=
 =?utf-8?B?RGRwOHlBbERBWndkb0lsN2QrN2VjdHpYZUlWSjRLbmUrN3gvOU4vV25tR2w4?=
 =?utf-8?B?ME1UM3ZmQ2hOVUZrazVlOHpFQ0RPa0Q2RUZSL1RzYXVvTStGdGJIcVQ1bDB0?=
 =?utf-8?B?K0trUkhRT3pJS1FiaGt6OXV3T2F2Snc0WmNKK3NDbTF1V1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R05OTjRHNUlzOGJRM0pJV0ZtMHhHQWtTWFVINHNnMjMyYzlDeWt0a3hxRVVt?=
 =?utf-8?B?QjFxS0pwRW9JL2g5Qk9oM3RMbXcvM29iR3NpeW5yVlVjbjNpQyt0eS9xQzVi?=
 =?utf-8?B?bnQxOFhOWVFwNE9FUHRHekVqUDFZa2t1dDdiL3pqNGZDKzV3R3N3OU5PZ1VM?=
 =?utf-8?B?R28ydkY5enU3WFhUalNwSzFpQnBaenFYMVFzVitqZUQyZEVtQ01jai9GZVhR?=
 =?utf-8?B?SVVyK09HSHVJQlIzYVV3YlJka3lIZEVCVUFQUnRtUjdZWjZyTGNxd2g3akZl?=
 =?utf-8?B?UkRZWmdYakthTTg5MC8vTDR6MnRhZnZPSStzbStrMG9Ra1M4UTM2ZSsrZTNX?=
 =?utf-8?B?ci9QLzJTcnU4VGhXSmc4QlpkcVpnbW9WUXYwK1BmT3BVSmoyOUlIUVJmMEhO?=
 =?utf-8?B?OHUrcU01a2t4UlViMk9pRjZqM0E3a0dLSUJkQjZZcUdLT0JUMElPa1FHV1F1?=
 =?utf-8?B?QXNRRkNYOFRzejJ1QS9SVGRnMUNBMWZrcGpOL2dyNVJPWVJnVFdHbjFHcmZy?=
 =?utf-8?B?VGdNaXZmM2o0bmNiK21TZEcyYjB1ZFltQzBTc3hzKzdJa0VkZUZoRitVVzNm?=
 =?utf-8?B?bm1JNEl6NE9TWGlrZjFodWppQ05aSnU1QWc3dGRKVlIrODhtQS9NNWQ5ZUtD?=
 =?utf-8?B?STVzWk81bi9XSTg1a05KZ09QUWdnREhuWGdvSXpMU0pMcHVRbzEyZjdXQ081?=
 =?utf-8?B?UDVTT3Bzem9uN2tuYmhnMFlvYUJQWWdoYmVYbDhTNDhGMDdPZ2w3N2tXcCt0?=
 =?utf-8?B?NXZVUzU3ZkdqL2dXM1JNemE3ZWpWdXdTWXNCZWoyTk9obDJYQ3B2V3RsSnVO?=
 =?utf-8?B?ejhwTjJJWkIyVWhJbURlOVRuM2hnR093UU9xay8rK3ZUcW56M0hHUnArT2VS?=
 =?utf-8?B?aWkzSjE5OTVXQlA5V1ZlUXlqajF5cjluQzhoYk1Ea0Z0M2dRbnhhNHdWcGhV?=
 =?utf-8?B?TWd6NlVRZ1VmUm0wanBpZ0poVkYvbHNrQnJ1RTZsVHZBSTZwUFRib1p5R3ZR?=
 =?utf-8?B?VXNaYlNzaDI0Vk55UWRMRTl6VWFPMThjTTZIdUY3UmxvNUt1K0U0L0pxaGFp?=
 =?utf-8?B?bWlraGt5TFJrc1I2bEZ2RFBmaHk5TkdJb1d6T0k3R3NUeXZSUWNsdkMzM2J5?=
 =?utf-8?B?QkV0aC9xa0JmY0pVVDlubTZtblk5R0dEaWNOb0s3MHNkN1BDenZ5M3JLVDJh?=
 =?utf-8?B?aW1UWi9MTnFYamtveFI1TEdwSjRDcTN4dEdxV2xUNkN2Zm5vd0pvYUVEVDhx?=
 =?utf-8?B?aXJaZUYxQWE2ZkJPMTNNY0M1ZVdOM25iT1lWV3llcmN4VHFZVC81bFJuS2Jk?=
 =?utf-8?B?a0tQTjUzWkxoSFlRczh0UWdiVFJNZ1AvSDBVc2hacG96WXFnREs1UzBWRWxw?=
 =?utf-8?B?M3JyWVptdlBGd05mMlVwaDR3eWtUdUZEcFhSdERRWXJ5UzJqMlhQYThpZ1lo?=
 =?utf-8?B?OExRWEIyY1oxZExaYlYwSWFNVUo3Y3N2eFlCc2RVb1ZGVlBJRGVXUDdtR1FB?=
 =?utf-8?B?NFhxcU0wOTJVS0VCdnAvczRmTVN1cUFodC81QWZpaFVKb21TOFBEVHVCWU9v?=
 =?utf-8?B?c1p6TnNsRHBsSVRHYVFKRDcyVnBrTlU0ampZcU05UWpVelgwdXNSZm5CSnZs?=
 =?utf-8?B?aEhvZXpYcFJqSERtT0xIU1dzTlNtS0Z0a3pLanl3NStYZ3g2QVRiT3UxODUy?=
 =?utf-8?B?ZHZsOC95RSs2ZnE3QjdxMjREZHQyc1JnVFh4bGVQeG9PblJETENBeVZFdmxT?=
 =?utf-8?B?ajhjUDE4MGdNck1NeC8welJpeGRONkNJR3ZlY1BvNUNobFlxd0RuTTcxQjU4?=
 =?utf-8?B?UlpVNU4rS2NzWjg1alV1amJ2OVpWektQalg2dWtsRHhEaXg2UlVXdjlKQ1N1?=
 =?utf-8?B?WFFXUlNNdjFJb3VTcjFqSlVoQjFIT3JSbi9SVXVRYzE0Y1hvSXJ2cFVYc1FD?=
 =?utf-8?B?U3RyWmtRZmszZkdZcEJyTEZxSTVaNXF1K3FBUDhnQWgrZEhTSmxYc09WaGhB?=
 =?utf-8?B?V01ZMkM5eGs1VlNFNzlyMDB4aGFuREt6QUVXUVFkWFFFZWJBM1VrczEzSFNV?=
 =?utf-8?B?SFA1Yy96QnF0a29XaEZBWUo4NWFRdHJNY2JPbGppcGFxSXFpYnlqRmowM2N1?=
 =?utf-8?B?K09Hdjg5NlpwUUVmcUo5bndrMDdZZVVtSFo3UElwcWx6R1VKU3FVdlZLbzNN?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kpcNcx5ZuLLjfVl0GpdpvgU9DLaYY3H4ifwGSzpTygx0ClDZyc+LZhS3uGGaguttiwpG/x0f6LZRMyoCd3gprUJvocIwMVkN7lCIs7sp9LwcUX0iVqes6Sc4xvHat5qwJoI42KnkwI2FrgaNJ28pzs2pqFcLuL68xljsmsnIiABLB9HFK86Q2ij2uq+MuBeq8iE/xfSG6DOcR27iB72MF5rtrmqqPclBry46j/bujL/D62LXSqxpmw5DGArrJVmMN52qWTQnPRqXzchUV7dz9XljEd9oEAV895iZQTs3LlHtPetGRdMKRrVfU26KogjYiE588F/3A/9HEiDT2tFoH/bu1WQyf3LMtL5PPPorHtY19tSao/Kaqx+5GXEFQMRds+/YcCYv7Sy9+/Qd/3cbeoGz16IF3swQkYdZA6rV2tUeXf8K1lSv3shp17ZC/OHbi4tzyDtYmeOkYdg4t7Uq1y6uZB+GuqqwOlcDnLK2jY92MKOrKGwzlt+7kee10tsErHCvJ/OX/Wkt3zOOWJPdSnJL08j7O9fYvvloTFez3Mqlr81X14SrJMwRLSX7RyBWlcyr9dt4MWjrasruPSa4WTo1Q8tKIwcjzHsbEZdlTks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbee9cf0-d659-4552-0203-08dd5008cffa
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:41:33.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQaeMOhC/IYE7YjTi+1gC8ma3ivc91fdlOHFee22gWA0DaFtw4ew0S8592QmaeyTBei5AHyNJlJ8a5k+5u0m9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180083
X-Proofpoint-GUID: E2fHuG0lJyKJ2kN0EID9LFDW3nfbnGdx
X-Proofpoint-ORIG-GUID: E2fHuG0lJyKJ2kN0EID9LFDW3nfbnGdx

On 12/02/2025 00:49, Stephen Brennan wrote:
> Hello all,
> 
> I was recently able to clear up some issues related to the interaction
> between kallsyms generation and BTF generation, which was interfering with
> using BTF with global variables in the kernel. I sent some patches[1] to
> the kernel to enable global_var. After further testing, I see that enabling
> global_var results in the following validation errors:
> 
>     BPF: #011 type_id=23691 offset=435904 size=96
>     fbcon: Taking over console
>     BPF:
>     BPF: Invalid offset
>     BPF:
> 
> Thanks to Alan Maguire's quick debugging, we were able to find the root
> cause. It turned out that several btf_var_secinfo entries had the exact
> same offset (and name) as their predecessors. The reason was that these
> entries corresponded to some variables are declared as "__weak" and then
> overridden. For example:
> 
>    // kernel/bpf/helpers.c
>    const struct bpf_func_proto bpf_get_current_task_proto __weak;
>    // kernel/trace/bpf_trace.c
>    const struct bpf_func_proto bpf_get_current_task_proto = {...
> 
> Both declarations appear in the DWARF as variable declarations, but it
> seems that there is no way to find out which one of the declarations is
> "__weak". (I checked this via llvm-dwarfdump). Overall, in a simple kernel
> configuration, I found 47 btf_var_secinfo which had duplicated offsets. In
> each case, both secinfos referred to distinct VARs, which had identical
> names and types. All were due to the "__weak" symbol. We need to eliminate
> these duplicates in order for the BTF to be validated by the kernel.
> 
> This patch series does the deduplication of the VAR and SECINFO in pahole,
> by collecting the lists of variables for each ELF section, and then
> outputting them all once the list is sorted by offset and duplicates are
> identified. The libbpf btf__dedup() function does not deduplicate DATASEC
> or VAR. It would probably be possible to implement this there, and I'm open
> to feedback or suggestions regarding this. I implemented it in pahole
> because I'm most familiar with that code, and because it seems to me like
> it's reasonable for libbpf to expect that the input variable information is
> already deduplicated.
> 

I've been thinking about whether core BTF deduplication should handle
this case - I'll try and lay out the process and maybe we can think
about whether it's better to solve in core dedup or within pahole.

The deduplication of VARs should be straightforward - they are
considered reference types and since in cases like this they share a
name and refer to the same type, the reference type deduplication could
be extended to cover them.  However, the DATASEC references to such
variables are a bit trickier.

As seen above, the kernel currently disallows DATASEC btf_var_secinfo
references that are overlapping, i.e. if I have

[123520] DATASEC '.data..percpu' size=229632 vlen=392
	type_id=7708 offset=0 size=48 (VAR 'fixed_percpu_data')
	type_id=5559 offset=4096 size=4096 (VAR 'cpu_debug_store')
	type_id=7060 offset=8192 size=16384 (VAR 'irq_stack_backing_store')


..the kernel enforces that irq_stack_backing_store starts at >= the
offset of the previous var (cpu_debug_store) + its size (4096+4096 in
this case). This is why the kernel rejects BTF with multiple instances
of the same variable, since they overlap.

So if we consider the case of deduplicating variables; before dedup we
would have something like this in the DATASEC

	type_id=8188 offset=256 size=48 (VAR 'foo')
	type_id=9190 offset=256 size=48 (VAR 'foo')


...and after dedup + remapping it would be:

	type_id=8188 offset=256 size=48 (VAR 'foo')
	type_id=8188 offset=256 size=48 (VAR 'foo')

This still violates the overlap check. So there are a few options here:

- change the kernel to relax overlap check when multiple references have
same type id/offset/size; i.e. they refer to the same variable
- have pahole weed out such occurrences
- something else?

Ideally we don't want to have to resize DATASECs with such duplicate
entries as that would add more complexity to dedup.

Anyway I'd be interested to hear what others think about whether solving
this in BTF dedup itself or pahole makes most sense. Thanks!

Alan

> I've gone ahead and tested this by building & booting a kernel with these
> changes, and the kernel patch series at [1]. The result exhibited no BPF
> varidation errors, and the drgn BTF branch[2] is working perfectly with it!
> 
> Thanks,
> Stephen
> 
> [1]: https://lore.kernel.org/bpf/20250207012045.2129841-1-stephen.s.brennan@oracle.com/
> [2]: https://github.com/brenns10/drgn/commits/btf_2024
> 
> Stephen Brennan (3):
>   btf_encoder: move btf_encoder__add_decl_tag()
>   btf_encoder: postpone VARs until encoding DATASEC
>   btf_encoder: don't encode duplicate variables
> 
>  btf_encoder.c | 234 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 168 insertions(+), 66 deletions(-)
> 

