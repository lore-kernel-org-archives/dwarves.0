Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814D3B14C8
	for <dwarves@vger.kernel.org>; Fri, 19 Jun 2026 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882507; cv=fail; b=rQCMfh4qnLRV/+V2FaUG5vSglMNJpWUqj7x56+7/uC9P0+KH+AxHu/WuIGuL3set3spc8kLKlueMdqK6bIy6csjg/88JeBIp8l8y/tHqH3ZnR7R5voDjMJSHRzuHFaqCfqkHyO4+HPtHT/uSw2Cy/BGJ645k+4M1DqrPLn57yLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882507; c=relaxed/simple;
	bh=kyBT8A18VMzvq8HJgFEC93pmplMGSMqvBcmimfmsE6I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DVRJ6hThgLyvg8hV8m/7Lz8sdrs1UHJ2whGyAVVUswLl+MZq0q+naln4ualF1yVfm1SaZ8p+lKV6Q5JSSM83xxtFc9WwOdMkCOWqEcaBBmSZrrmj77d39rGol/1+5PVcmpJQofi8hQeq4o4dT/mxsfmMrzcAymCo6AFhoLSY3yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZKcCtd+Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iIim2Yd4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZKcCtd+Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iIim2Yd4"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J0UWKV1683118;
	Fri, 19 Jun 2026 15:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UIW6j+153llRxU8LcGgKGUpLOicsKFK7xu4qUkiLt3s=; b=
	ZKcCtd+YOQknVfvVTub9M4WBTwtqkd5rctyhnN5oklPqR5Gu0dmgIloJRP84XZuR
	FBAFYRTIy9J1PrU8Y2urTsjdIwZkTJC/h9FstS+ZkSzdTeNZtALd9mWiFIHL3FMy
	Le82xPxPEqGK/FXn48mys6U4gppSCYTrrkESCsLWiJ+cmUZxBdthgB2Frv4pmA6F
	NzMzvbDRR9I/62GDUDc3Z7BF1C8oYPJk+ZBUzFhFKCwMUzMezHVKu14YbfHoVdbR
	zPnPMUXh9bUle4xqJcJ1HTQN/1hZKcE6aiQ5k4DpmQOvWR8F8F+ZCPa5XCxRnfMd
	r9wqN2qnP94mY4H2ddoYsA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4euefy47qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:21:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65JF38SW039180;
	Fri, 19 Jun 2026 15:21:41 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ev14g7yrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:21:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0Cjij+QKqRVgwQmcoS3aTbBJVzyphqdfefRtHKK/k+bsOcc5odnzH+fZHDYRWrKpqArfXXBd2gBr2yJPZGr8KfK2I46SAOawPnBUlRtFjvo6U6QkApY9ZMtcGvj9QaFvowJS7nad8csm550QCGLwUXPZQbUIAdsjWnxk1DN5Da2rPhtx16eF1AnbUocwqjW7we3wga8qFF82jzaeV7CGMIKIGSqTtv7hX+mdQckZBfM+3ZBD1xc4a1bzas4oIMBd+ceJTpbqFsAcXSJyz4BHQFyfEf34ppeYn5TxJIyI9sDhyHDFFxWxsm+7G8FWB8V1V8twL4ksB62XHsIVHCuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIW6j+153llRxU8LcGgKGUpLOicsKFK7xu4qUkiLt3s=;
 b=ku8h/Nxjhab1BG3Q/Cly3q6rSru4s1woQ7qy7no5pjO2v1UhSJooC7d4wL7dwXKlatoh2rksoQKfQK1NqFCgNWmJ7yNCaIMjcR4oqcfUXKFlpPc2tMqGM/EjJr4wiecaVLlPYMlHYPoxjekL+flMWIIcOIs8RY4mNO3K0p5JKaNHt+vsEoasJ+EnXeUkc1fYcrwEWHQXBSWNEMrwB3WDeYwomOazNy2yoJFwEYaWo32QLUheUQwEx31WJQgYWEK03inCkGtYZfAjq1q7BopiTLMmiQ8fosN6AXS1haqq70/ghShji5a6+4GYjwmbHPUC+JWBn2Nkhh05Nn2mGU696Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIW6j+153llRxU8LcGgKGUpLOicsKFK7xu4qUkiLt3s=;
 b=iIim2Yd4AgZ47XjA0TCgPmGLYiDJClrajlSW6JqBXb9jqBfv9JTSng2MAlYKFP03x/qFUaGyigW+CcpAV1CyQL1sF0TbqjpD/yuwXxRTOTz5GR7EKU4NJY8QTNXsRvpXCshFQ9LGvMW3a/sueC7ZV727XFnSQ2Q3e0BVOWVpHKI=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 15:21:38 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 15:21:38 +0000
Message-ID: <ebbc869c-db37-479c-9479-fe5fe3c4a1c8@oracle.com>
Date: Fri, 19 Jun 2026 16:21:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves] github CI: build/install bpftool from kernel
 tree
To: dwarves@vger.kernel.org
Cc: vineet.gupta@linux.dev, yonghong.song@linux.dev, emil@etsalapatis.com
References: <20260619073358.1605594-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260619073358.1605594-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CO1PR10MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cb1df2-a83f-4dda-0c16-08dece167513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8aP9UKJGzaKpr2fJi8wIyBW2zMdEJPsufm1OjT+iMRbHXTDArC+NqGkDxJWyxxOPJ69VYbrFTKyZJKrDDgnJHA4LBVqPAYmo7FDJpTfZ0bGR+EcbwXTKRF7TxLAVMTB/tMFoB6hDBbiRqCGg8ipNYMIEtb04C2gLf/66ZCz4F7Cq+uYRN8qp1mrXAFAPswOiZPT5/qIAkdzVBQLABJwCcCVTKJW0Eg7V4aqX37zBlocgCFDEKqBO6CgVuZgpUrCUgu53npzk/LQpkG6lGykuxbROoVxF/u84xx94FaIRt5l+tDyo7l7Uh+hrXsjfnRtkv9YzAgs/lR/BmJp7CRhA1qfwRuwtmqbsEEdoSzOvUCHZtxVrB1NLMKekAC8NH0hpgbW+CWMzNSYg+73JMADyznesQebi5lPi6tG3IiiGEv6v+AzZVK2Hu0i88dypcI0sMY7n93buo3ZqGGOCuapm5uX5z4FyX6zrzIw5vjNW6ktZrHSrYW45syOpgn1UA8Q3MsCR9DdzYCSE7tIKpZQ1XMWywysxYl3RR38higv4diqHo7hfMMhlgaNZIUigtd9QhdhfClr36F33EBCkaYB+orvjYtX4UVLFe/mY5PtFkXySRf0fnmPDs9sul+50S+PINAMVRuBSdClq8kMSjr7mbcT9ybivzpiWevCtsjVG088=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDNrSE5Cc3c4eFB4TkQ4cWFvNGhzeFU2Qkpnem9kMG94Unpjak55UnJnNGpI?=
 =?utf-8?B?cTRuWFkyYml5KyszdkxOS3BHc1ZjU1lMYjRnY3Zob1NTUjVhRmVQa2VzTGp4?=
 =?utf-8?B?c2p2cGtYMUFTYUhSWms5bm5GS3N0aEIrMHp6RXNXb1JJWXRxUjAvU09vMnRL?=
 =?utf-8?B?OHhURVIweVpQKzRzYm0zdCtaRVdYc1BFWXQ1aGFSNE5na29tczhYUGpRLytR?=
 =?utf-8?B?ZGdhOWZpcW1EUGxBT0l6K2o2aC96bnlIZm4yTjdHSE55UllWYU1NR1Y2ekJH?=
 =?utf-8?B?UHNrdnNIcXV6UWJ4TUhSZ1BUb3FYbWIyTFRld3ZpQnNmYUZLV2ZseTVTNXRB?=
 =?utf-8?B?ZVg1R1lwaXFKRFNnajdMN1pmNFN1UysrNnQyTnZiVUFmQXM2RGRxQ2gydjNo?=
 =?utf-8?B?R0tOelJIMlR4QmU1b2NoRVR5Y3c5ek9sbEQ3cFpJZlprUTJIcTR2bGtlZ0Vs?=
 =?utf-8?B?SDZxaUJVQW9uREVuVmMrNzQ2M1dnbGVGRkpka0JBenNTemxOYW9oMHRiQ1hF?=
 =?utf-8?B?WE9ia0xmNWpNb25vQlIxNHpzTWVwZ2U3VHNUcG5wNnJGTFNmbFAveWlUWndy?=
 =?utf-8?B?TlRGVDYvODQzNC9obTBxRC95Z2JabXo0M042T2tBMlI2K29DZ1ljaXVUdDEx?=
 =?utf-8?B?RWRLbjhRL2ZIVDlYQ1RXNU1WWnlKZ3VUa3UzWm5LSmpVWVVOcmlpa1FsbUVL?=
 =?utf-8?B?ZjZrazRBU0xBRmFWNDVpNzZydzU0Rk1oT0ovRnVpTUlhR1JBV2RmNVluQUU5?=
 =?utf-8?B?WXFaSGhab1krQlpyUkZXVE55eXBvVllpc3VBS2FWaTRtUXBLZHpiejB5RXpo?=
 =?utf-8?B?bFl1cHVYMWlSTlJ4dHE4d25Ld1pHc09MQUlCRTV2WHYvcmhoZ2E5UlhWYWM3?=
 =?utf-8?B?Mmo4RU1PZmdyL2RFYTZRV0RXZVZ1U0l2czdOd1k1SUxHV0lGQUFpblJGVzgr?=
 =?utf-8?B?MkpUeUlqZFFzaVF2QmRLVW5zSWcwc3ZJcHFVSS9za0ZIbHB1bVJZYUNWTFhy?=
 =?utf-8?B?RUR1QUdWL1VIbVFMNkpaR0NMOW1rZFJIcHdobENrR3VnczdaY3dYQm1JMUEy?=
 =?utf-8?B?NkRrdWlpTFFZdHl1VkxRaFMwSGVlZStOcFcxRmZrdUFjTGxmaWF5NTJXMlFH?=
 =?utf-8?B?U3Z1UzJLblNPaU12MHFncVNYdWd4NThMVHR2L3ZhRzhWTVBZbjVESnpDK3FC?=
 =?utf-8?B?YWNBc2c3SVZZemE4RFRxeWVtaVVEbk16TkhoNENhSU85ZGhyVzc1clVsSnd6?=
 =?utf-8?B?bXZjd2kwV0J6d2w4YjBqM2dHQ1NYeU1KNFRxZkNlV1lnMWN1bHF0OGVFMktt?=
 =?utf-8?B?UThPNHhPbTFEMFNSZ1hldDg4OFJBZEh3YTVHMlJhNmVnSEdCVlJaVWcxclh4?=
 =?utf-8?B?QWEybWlxY21GamRiM1hIVjg2NkhRVGU4T1ZqUDMzajlNQVV1a2UrQ2JScVRC?=
 =?utf-8?B?ZndZanQrNnNobkdSbkZrSzlodFRjbXR5Mk9Tb2FlU0xsMGh3Sm9kYzhLM0RJ?=
 =?utf-8?B?NjdZaHRyV05LajlKUmJpRS8zbXFDcDdGL1hsNjMzeFZPY0svZklIVi9xZFlS?=
 =?utf-8?B?Tk1PM3ZjNlRIUTBQcVlhZEVoSGNUUkxuWVgyR2gxOWsrS3lxWmZYdEMwaFhI?=
 =?utf-8?B?SGFVdm1Gc2NKT1Y3N05TOGlTNmZqVkFlNlMxWHg4ZnRVMktpdmVIVjdvYWp6?=
 =?utf-8?B?QUZPZC9EcUU2NFBFK0ZDTG5XK2dCcmY1VnFpSFZSZ3p5ZTRHMk43TkZsYTU0?=
 =?utf-8?B?d3BQbGpIOCtLSm1IZG5wWmJRalVkZ29wM2gxYjZ0bXRJTERleE1yZTVDTzhM?=
 =?utf-8?B?Z0ZuZjJOTFRIblcxMnZHemFXbnIrUElzVXJNMkk3djdnVjd2Ymwyd0FJTCtC?=
 =?utf-8?B?Ykhvdk1YaEpRSGt0NThhSFVzS0ZzWEpWa0I2cXR4ekxlanQrb2lmM05nWDA4?=
 =?utf-8?B?aGkrdVhOUmdpWGRTbGhsVTZJMkRCR2l2c29ldEV4V3BDZGoyK2Z2anlRWTZH?=
 =?utf-8?B?MWY4M2gzUDFjM0N4ODhUdzE3RkFoTHpxZHRra25sdlRSUDFRa3ZTcTVyQ3NW?=
 =?utf-8?B?bmNRVFQ1QTBwbEkyQnBISHBNM1Iybm4wMUlESnowSC9CUWdTYjh5UmplOHdw?=
 =?utf-8?B?Qk9DU09ZaDF5ZzRlOFgvZUQrbys5cndpR3RXTUtFeE1YckR0WTNIWldDNUZx?=
 =?utf-8?B?TS95TlNIUGh0dk9jOE1Lcy8xTkU0WUt0dUhpYVdST0dpSThxODBYNU5YL012?=
 =?utf-8?B?dU9oSXhvMi9tUHNYWUkzM2pkZmxycWEyck1yOVNrWVJTOUltaXl4bFB4TURt?=
 =?utf-8?B?L213Y2Y0VFg3TW92L3oxZy80a295eVNDZW1EMGV2SzN6MkhBd2lyQT09?=
X-Exchange-RoutingPolicyChecked:
	UDBRBPv1Nl+sImvwOuE9PLIhH8TKg6ruGbuIgrkArU4gOQoFyh3+MXQtzF4Y0zQObAq0hVhqiLY8mpfK23yQExfzaqcMcqxU1yG70sd44zrUgW3C39I93TY1WTISdXX370iJJ1rkE+8goMvjk+QqDvkWXDGigpy4l6GoAa06vo8ucgjKPN+BrFwCvKRQh7XQkoo7lX1C9roes8HQvGt5n3P12tU5Elz5SqXkFSX7J9pHnRc9WyszbYhBMFvrDOyJFsD1EjJGozlkeBTMy8XpWcAkYafI6rDUNZDL/zTo2ee3kff60C/pF5wi9G3EMmbca3mEIMBcP8cv2OZzUlXh5g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2rKSe6lEChwEJxxURU/iurB+NImUTgqK6s8xgW4hJF2oQQIrV5BS5BaBWyh09DUpc0Rq3z8+Ph8dIacGMotFSLBHkQSDrLEgccMXIEgG3Q4gwXLXvHxt6tJRt8He0Oh7D8AG1zrzFuFimw1uKAxKmOGZs02b+dWu/H85ovcZfLpAg7MO4W/sbzOYf61XN4CpE+R7Z20BqrYwudoh3EaNfQ5cSqSfMaOyEfmGBaTFHrDPY58DOKyW3QavJak7ev1BbV53Wav//02R/tp6UzVHX09vsDjx0uP0dWBeBnCqQsK56qf7yQzbBZz92IkH36AcXE4v3ySM+z1QbkDAMJfWmga+5zql0AJ+v+omBOwUgnkVT5y+ObgzjDJc6bHbHyCsfxhsM1mwqKQ2tSGi12kDdILdNtWVQ7XUHRRTIZchikdzbMmymjunf+77pa+/0DUBILPLKkD7SLiPnFtiu3rMLZv9uS0PU9KY+3a0lw/YA2r59HY2cUDVUUDjP2ICE9hQxHuw8yL1j+iAT8xYdnP88Er1m0ilqt6aAPFngolB+rKIZIcLyhaXfQrCVdtSPlP/hzY/wIin6N7O3G71GKiq9Jub/Vp/Q7cGbFefBJiqXzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cb1df2-a83f-4dda-0c16-08dece167513
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 15:21:38.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gW+bqohXulW2BkuIYATqAZaNaJrf8TL5CJXcjn4Hg8t1ZMO5ENj+UtqqrTu1LeHNMQjktai/6YiYY+iH+akdkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606190143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE0NSBTYWx0ZWRfX9IaNJi0NigmC
 +utovR8Z6Jq+BPqF9WW6SlbY+b1r8K7migvauiMDtgS5gQBRx6bTWN1rv/AmjOeIfJhYFcFTpg2
 XXG+OFeXl+nYvrvAT2oxsNNJ2204BtJHjD+bB9IVSgMHP/LfsN91+cXxxMVoRbOvc87jkTaGzEY
 PF1588FVYlcYd0bueZvHPbFRIyqCOZDCvvLF5yc1wNX0nFxFNd8Uh23NrK1LLy8h37nuZsX60ms
 2MZbDaPHjlihvXn2bBJp/V8uWj3wun74eoSAo6blDrig350OoRjs4kRHenE6jU9Ch9FNMmzqUNb
 a4MjHte/j+RIeptXg0FN3PJX1a09bWIsgElZi/BAAd9B26nyfnf937F0vmHbXb9H5RndyWSyU6l
 fSIhCmdoW/8DrcoVaKvmIJ7TKI1ApWmosM+ZI7j0F65xyhbD89/oBFqg7b7kipAu9Ap3udzvUQ6
 iqBMX7SWDxZOQMPwJFw==
X-Authority-Analysis: v=2.4 cv=Xt7K/1F9 c=1 sm=1 tr=0 ts=6a355e86 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=NEAV23lmAAAA:8
 a=yPCof4ZbAAAA:8 a=nlVVsCJvXrESJ1fBKQMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE0NSBTYWx0ZWRfX+hAE3vuZFoih
 pXCwXMSd9hMZO/vsZD84Ea63wcdXtzui6oCrkzgTCVnrxaET5PyhG2J2D7lxguaMd0RgnhBeoBD
 5ZLcChQdKMsLEVFPF0UVURQkaBbUMxTJMrS5oDZiZWgqINnJb3ti
X-Proofpoint-GUID: dwj8sQcZy3iRQocxBkmmhzqqE7iUHOCe
X-Proofpoint-ORIG-GUID: dwj8sQcZy3iRQocxBkmmhzqqE7iUHOCe

On 19/06/2026 08:33, Alan Maguire wrote:
> It will be useful for selftests.  With this change on top
> of the v5 gcc BTF tag series [1], CI runs succeed where
> they previously failed due to absence of bpftool.
> 
> Changes since v1:
> 
> - need to specify LLVM_OBJCOPY env var for pahole invokations
> in pfunct-btf-decl-tag.sh to succeed.
> 
> [1] https://github.com/alan-maguire/dwarves/actions/runs/27790591177/job/82238306741
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

applied.

