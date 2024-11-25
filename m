Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AD1E48A
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554307; cv=fail; b=r+zOPcKfgVgAkb6QMB49Ay19/nkkYyznLqsBYT3EPaajrNZCpBnfWysuQhfWY3KNPXCGi+AQ8TmHzty6/UOxnWpYMPLNlemd+pAamZFRsqB2drys1R7kJc7AMxpC8da0hYV/yg/P2PBLwbtgPQhNdEfUHCY1ZXILXc4IAvHGqJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554307; c=relaxed/simple;
	bh=1N4sxvcLDXemfmJWC7xLAqiu0Map0ZquWSWQ5OGf2ao=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnI4+dKCqwuAH3p8jo7rIRX5OeOaW5i2Lfu7nGPeBXuzhLXZLl7JnHZztOpFwy3hFai1ZaY53U/SF8wvUgFujQoJw70J3tQpQQKylJ8oHOMOmk/T0zIIiqNC/gOJSzSS9WvaadL7ai0IMppYwv/c6/aVCrD5We287WrCBWMUES4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ft3dfGcK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GvUYRMfr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ft3dfGcK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GvUYRMfr"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APFLqjg032609;
	Mon, 25 Nov 2024 17:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HeUyiI7ImKe+B8TYUYRyEHwyLL4b2Kn9ex8OiE3S+Y8=; b=
	ft3dfGcKpzkVfz2YJyb5aEFrsA1543jts8Uyd6xTONkhLXaQhfi8kHlPQdUqIJRl
	ryOETPOSsdsaOfcqj80Q9zYt9VyOs2hXpNTDUWDG1oQpZMUgiQ9OCcL3U5iTKr+s
	s4xmtCGVvvp1p4XzuKi1DFjjfTwX9WyY70phnG8uaiQqLpZ7cf4ZXaCbdxROwnnr
	evkATz4mnCp2cTwbR2EEuat93j2oSL9LlIkc2RGtiBvU4tlkAaL34JlP3vzwcfKG
	oncprldbKWA7SCWvafo/DXjubtv0Y6CDeOsVv4h0PQCuUOrZLwroOqhPgq8X2f1Y
	CNpgF//YYm3CEyfgT6fikA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433838kp08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 17:05:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APFP6Bo019476;
	Mon, 25 Nov 2024 17:04:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335ge9c2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 17:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ56EhXcEzPQF/acDjZV6grLvwuwa3RBESZBAtOSd0K8p7eUv62KKZEM5VVpejjAY6Oufp7rnjWR9VDVLRRz6dB6XjLrNo6g4m3hFcCsY1v9w98FzrDHdArSZjAX2B/LmYGqCc7/c1vNQwnDOkRn7m/tyI3sO6fLF7N5tHVv65W60heQ4TBW7/Z2tb8tdiYITbINNroq1RGRYetX6m0aZLeWW8ToDmkLS6hjFlrrMRYZHOtNPDOiTYo/Htk1JUlvRF7w4BpaCCKh4Wk4LikPcWhg7HSi/eekSbaV8MsHFl58/O7t4sK3Z0fIv+AqwlAYsm9qw+Ow1lkxa9Hyj14mQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeUyiI7ImKe+B8TYUYRyEHwyLL4b2Kn9ex8OiE3S+Y8=;
 b=pOyqmAAcaQvpk6vPGa8Moo0Uptj+HGw79GH+6R4SNeBrFfc+OClsWyR9LRtwjypcBfgTCmGZgH3NwPFS4orNyxaa5oY1Jibu5O1Vr/wRhTgGd+ALmB0cax2c8nzuwLkrjLMHgi9VO6SxcIOrQ4l/AioMfbNyBuBiHCDNVAfCGLgLDfBJmYsFlnI5vtd6HFfI5z3ZfpmLnXln4mu544gknYU1IeTXFlC5P26Mcf92smZ31ascxblHA97Qi2zNpSVVFSbZqslCqQNcl1ICbsz4Wt9uA3f5SvIeccKAIm41CE/Iuc5PxZYBjsKAjiyP1p4+GrBxWZj4kRc3C3G/TMJ38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeUyiI7ImKe+B8TYUYRyEHwyLL4b2Kn9ex8OiE3S+Y8=;
 b=GvUYRMfrEG0xVu6uvQkB2cXeWbxMhly2IbxcSR/a/QsxKwEDxYOw/NY2TTkXsN36g4NXxkbHi1KN+Qw5wTbe5uCtryeU1Ta4viqfRNSVGCIj+qKGicFKYe/NV1QO39ncKIY/r3jZn+N4tYvYqVGo7EzW0YYnQ5NC3gIL7CJaHBY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB5100.namprd10.prod.outlook.com (2603:10b6:610:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:04:57 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:04:57 +0000
Message-ID: <f52e76e5-457f-45e7-b9e3-77ed273cae3e@oracle.com>
Date: Mon, 25 Nov 2024 17:04:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] Respect CMAKE_INSTALL_LIBDIR
To: Ben Olson <matthew.olson@intel.com>, dwarves@vger.kernel.org
Cc: acme@kernel.org
References: <Z0SdF3u92HMAu96S@bolson-desk>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z0SdF3u92HMAu96S@bolson-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0056.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: ab83e297-50f8-4067-71e9-08dd0d734a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXg2Zjhpa0N4Zm82UjdjbW5mNE9zYTZrd2dxKzJxdm5FTk52WlF2VkR1dGMw?=
 =?utf-8?B?M3UrcGwyTWQ3Y1FVbmJJcS9KMG1jdGJVLzhHU3ErQzVScHBFcGhKbytxaEZh?=
 =?utf-8?B?TUc4NG1rREp5b0gwSmJjR1lzSWlySStTTUJSRjYzYzhMenpUdGNOejRCV0Zp?=
 =?utf-8?B?YjBoQStsS1MwSUZoRnZNUkhQdGxrNHhiZzNRL2JvL2Voa29GSjR6QURpNzgw?=
 =?utf-8?B?eGhjdnZMLzNwbmM0TjFKanlBV2I4bG9tUDM0TTVpY2pBbkZ2cUVGRmlEQWpE?=
 =?utf-8?B?ZzhMZ1ZqZ3NJbEtydldwa2JqbmFWUVBCaEp3VENiZFJyTTJiTFhlNENyWnpU?=
 =?utf-8?B?a3pzekZBTTB2U1NmR0NhZm9naUdWY2hXNEdVa0VqV2djdXB5MkM4SkJRNG03?=
 =?utf-8?B?V01CSHFrR1J4aE9qUTFCMjB3RnYvZ29NREhrcXZmWkx0TGRENW9YaWU5N1Fh?=
 =?utf-8?B?RVRrSThaU3N3Y3VLZzArMWxCM0tpbzZzdzkxcWpvOEc1cHBnOEJDM3pWNWd1?=
 =?utf-8?B?VndlbmhlOG1PeHZXcEdkZXkvdUpwQnZBdGRIZzMyZDNMVXc4QXVna0E1L01I?=
 =?utf-8?B?ZW8wUGUrZEJTYVJjeFVaSXg5bEE5WTZXNzhib2dmSzJpbldCb0lkRlEraGNM?=
 =?utf-8?B?RnpTMXhBSDI3Zm5Ic28zNytUOTNocm41TTU5ZlVPcWNWNGt2dGdoTEx3VjZD?=
 =?utf-8?B?eUo4a3RyQlF1NmhSNGdGT1lRZ2M3ZVlvSENaaGlnZklMUER6cThHOWZoc2pZ?=
 =?utf-8?B?cTY1N0R6a05VbGRHcURWRUFIZjl4UDZ5SjBGcUIzYm1raW1qTVNWSDE1cUZt?=
 =?utf-8?B?Mjcxams5SjhEa3NOMElQeWJQS2Q4NlJMZ0FMZUl1NjNRcyttdzBPRlVlQWFT?=
 =?utf-8?B?RGVoR1pLb21XQ0xSZ2Q0SnkyMzZza3lWNHFQYVdDbFBRNTNENHNMN3A4bnBo?=
 =?utf-8?B?aDBMWFo3bGhVVzdyNlIwbU1DVStSWllpdUZ3NHROT3ZrYkd2NlNYSEh5eFhU?=
 =?utf-8?B?dk9qZFNGKzBmUGpKRVN1VzdNN3R5ZC9iQW5Ib3YxNG9JajBtT0VteWk1TUFY?=
 =?utf-8?B?NWd2WDIzOGdZSnhZS2NCQm1yR2FDU29nTWdkTVZ1L3RBZnNLd3Z3S28xajJl?=
 =?utf-8?B?bFJxcTRHNFpZV3h3b29DejNGTjBWTlJEdjhSY1BMRlN5T0lUbU5Kbi9zeDM3?=
 =?utf-8?B?ZCtyR0paUHc1eGhqNldHaWUwZVhFbVdmMHRqcTRmb2JtVzdaQmk0cHh2MFBk?=
 =?utf-8?B?bUNIZWRWeDVNOTJJQ1lqRHdqb2dFQ2JQcmtmbXEzMTZHaE41YVhUZmlYcHdF?=
 =?utf-8?B?M0dsMmZrN0krMWN3eVZRWm5xMUJWQ2pnbTRMT1grTFBacmQ0K3cvZmFwSjY0?=
 =?utf-8?B?ZDV4SndsVEYzK3RjVllEOU1tdjhDQW5MM1FnMGZvOERKZ1hWSEl3NTRqUm5p?=
 =?utf-8?B?OXZUTDdkdjVadkd4M3pIMTFOa3dUUlFWT1ZIWGdyeGp0aGFSM3lKUHFaeEpM?=
 =?utf-8?B?V09PVExUZ1RuYzBudVZJb0s2SGdTYWg2YVZucGJ4c3dHRXFmUlAxR2NRRGFq?=
 =?utf-8?B?WWQxWlVEcDRtU1lBdFRacnRyVHZXeVpvdmcwcUVlN1ZyZUNXbnBZMzlvK1NF?=
 =?utf-8?B?VEY4SGc4eUZ3NUNMK3Q0cWEwdkJ6dnJDd0ZwWTNMVzAxZnBRNkFydTk2bEpv?=
 =?utf-8?B?VGlaZFlLSC9XQ2k4WTJJekNHbVlPYkxIYmIyYmVNd2t5cVM3Nmo2cmVaWVBo?=
 =?utf-8?B?ZHFaQk11L05LR0wraXFWRmFCcXlKam91em9tdXZkNW94d0JEMUtkaDk0KzM0?=
 =?utf-8?Q?29k8n0ooK5b8I7HONiwOYGUbTeQQETj+iTcwo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTFYY0hMUDVlRlBKNEVCWHNJRnY2ZFZxQTBEZEpuSWJncVR0cDBXTHltMnFT?=
 =?utf-8?B?MWV4VlVXYmtFVmFPaUJzWmNYNDhEd2oxZlJnT0VpRFRHM0M0Ly9Id0Q4dkkw?=
 =?utf-8?B?VUxicWRicmpMQkYzT2xWUnJFR09JWlBRMXFDdlJ2aGpmdGxOdWpIRUxIY3Ba?=
 =?utf-8?B?VzZZTFhTanYxQ2VMdWFubVArdEIyZ2VoMU95VWdQcWdjNEkyT1ZWWjlrQTBL?=
 =?utf-8?B?cDlER05LenhmNUxuMmhHcS9HWHpKc04zRURYNDhHUzVETGJacXhPcEZobDBl?=
 =?utf-8?B?TmpBdEtCVk9kK1BkR0pZcnNvRUZPeWZ6a1V3OFlwTnNwRjZjUWljY0swc1Mx?=
 =?utf-8?B?RktMemJjalV5VEJSRlZKRituWG15U0tjeDJnaHFIVkZZaGlrUzhVWmk4NS8r?=
 =?utf-8?B?SWNvWXFENjVRTFE5MXQvK25ROXdXMjZJbFdlQXcxYW1VNjlDZ0dodk5RU0l0?=
 =?utf-8?B?RjJCZTVNcDNEQUtaODVJdTYrUXJveS9wcGU0ZlJ6S3NqOGJ6SmJpNG82Nm5v?=
 =?utf-8?B?aEdBclZVUk5FOXJ3V2pCR3VxZ0o5WTM0aGNtM2Z6RGgwZkpRN1ByU1VUWmdB?=
 =?utf-8?B?amtkaThrbktSbXJ4OEkzV1dTRGhLTzRUNUJ4emVsdEM4QkozSnFUamRKbGZi?=
 =?utf-8?B?UmlQMXVrUGVIeEQwMFdRR0RDTzlvR2dxYk9MWHVDWkx6SVZQVjBCdm13cjRm?=
 =?utf-8?B?NHJjeHk2SU5yeCs3aVBaVi9URjkyamI3cVFGL0Q1MC9nK296L2J0ZnZGdEQ5?=
 =?utf-8?B?U0FRUGlQOTgrbjhCMjNtbmtRVDZOR21tVmQrSEdEWmR4andDckpsQmtPVzBi?=
 =?utf-8?B?NGZuNlhHaDJtb3VSQU0zczBYQ29vZ3I4TXhHTXdiSmEwVFpxSXVXenhzRWo5?=
 =?utf-8?B?ekFSODI0dVFNaG0yN2lRZHdoV1FuYUtNekVDMncxVm1KMmhZcll6VVhGZ0RE?=
 =?utf-8?B?SnNoRndjbGdyM0YydGxQblE2bkhldVFkdGs0dkEyTC9JelRrWERnQldOdk1i?=
 =?utf-8?B?VVh3UW9LY2JLRXNocUtCSVFjVEhrWm9veVlFWnBOU3FOT0h5OXJnUVk3VTNF?=
 =?utf-8?B?OHlIZ3Y4SkJrS0huY0p0U3pZUjV0TFlFS2lvQ01HSm9zL3ZuM3NCbnIvL0E2?=
 =?utf-8?B?eWhpMEpMYitaSk1GYnRTd3Z5TGh0cFRyN3pyOEQxam84Z2MxbVRrbWgzcVlC?=
 =?utf-8?B?MGlJZTF2QXV0Y2lkRWpNQS9IRUIxYzF3dWNUUWltekV0M2dONVhSdXBKNmNx?=
 =?utf-8?B?WC9tY05EZFI0YkU5QWtUZmsxZGpFU3lGWlNuSDQ1cVFqZzJnOStKUmVUWlI3?=
 =?utf-8?B?V09xby8zVXlCUko5R0I1aXlMdXI2SWRiV2w5cldCdmVkUG1WKzNicEpQSDZ6?=
 =?utf-8?B?aHlrcTVzeHU2Y1JycTNBMXFKOGFHakRXVUg2WVcxVjUxZDBkY2Y4cjFsTWdr?=
 =?utf-8?B?VWtiSldFd0UvdHFMTlpsd0E4bm1IOWxXMFRTeUtpaTI3N1F0bDRxNFZFT2NY?=
 =?utf-8?B?LzRLME9mZ0hTMnF1Y2cvTEdqRkN6czk0UlBQRmlvM3RBQ0ZFT2JjWlBpcktK?=
 =?utf-8?B?QjJOT0hVUUFJb2VDRXZocUZrWkExSERNd1ZnRThtZWRxRXQzYjEvY3F6YUFS?=
 =?utf-8?B?T3dNVkR1T3kzWVcwMjBFWi9YZlpQYzVnckFtVUprKzBpNnhqTFVBN2Q0SFlx?=
 =?utf-8?B?Wi9FbWpqZlBLZmhZQnlRenBiajVmcEY5eVBOcklVajdpcFcwT01WeTM3N0xh?=
 =?utf-8?B?UjZLbDd5YVY3SnZCdFUrVEhNb0ZlMVFWNE42RTM4bGhEbS9RcG9BZWFUbzl6?=
 =?utf-8?B?ZWI2UWZpUzJIby81emo1MXlreGJWbmFCV1krQnMxZjhxRmM0bEZpYUszaVli?=
 =?utf-8?B?T2t0WHcvcXJjaGR3QnZPMUNsUjZFZ0FTRnNpMzVZZVZOM2dXTGoxTkRCSWhr?=
 =?utf-8?B?K1E3NjhKd0QvRUMzRFlUVzR0dnE0bXdvcTAyM1luUmdIS2R3T0Q5eDNCMDRi?=
 =?utf-8?B?NTlZTjJ3MG1mdG9KUS9senRhN2FZRkdTald1YWNFM2ZTNUU0UzFOajhoNGQ2?=
 =?utf-8?B?MDVnckU3aU5LaXNNTTlDWXZ2N1dJczNLdVNjN3pxbEZwTlkxbmRRV1h6L3M2?=
 =?utf-8?B?QzB3cXFyZEtmSEpHL3dFWnFuUjVMZHYwTm9uUno1VkVyLzRzazFUNCtBSzdS?=
 =?utf-8?Q?nlzckdWfpT5ADWDOX66knII=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nPzPcLrditM8KV7NHTAAvuzWMj7RlmRhth+C+dgzXD0jo83u5BEB+MbTqOV97ynY8jiCaHIuzvyhN2J97dlTkJWaV++PQ5x6B3QqDaCox8GGKyu7I/mL8/IPvACI10dwcld/utMm5p4GZfWVgb5mVW6OtpwVodqI20v7CPiw2tTF4zlxkvSibag0ItiZ56pfSN69sfo7jJZiYFrUb0At6pHraUoXcyG2YX06sgthbKqOoovXUL+0tg9HitZlF/ARmipZlwyMrMRpxku2eAfg/+Eym8vbrroxeonLjhg4cQs5JLnnGdKpW7gZC4cUMsvgiAIAqIcrDeRm0zkMU4WfsFp/sPdFBiDVubUu8s8GsltnI7zk/k/1tkjQgC4Iukut8oPWp8W9qMMxMAuKW7jbyhkP+BTZEjfgb5mxes4T7hvcQOihXzKWd4Nv98OzsmwNGRAQPKXDWsZLT+mWEYDnNgy7u5tD6VMd4VEQAof+A0TA6UYgODSXu3wg2v1YEJYv/Qxu/F+hS3ec2kzg1NGoy+WjIZlwtjvXfjdHYHwx7Y9iVQ+IxlBAgMLRiZ2Xc38j/rq/5H20SjMhKwyPgimOBsmhB6v1jXSET/xZLPmRScQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab83e297-50f8-4067-71e9-08dd0d734a55
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:04:57.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dB5kXQgoUxV2k8FF/9d6J7Xp8pfXEn4KCp0wAL0Xl3YmQ5NjSw6iDIqqqZPQUcixlUmg6mW8jP/uq8samaYznQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_10,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250143
X-Proofpoint-ORIG-GUID: 5u4gm6cMl-h4ASynunDF4kszdB4Jdwaq
X-Proofpoint-GUID: 5u4gm6cMl-h4ASynunDF4kszdB4Jdwaq

On 25/11/2024 15:51, Ben Olson wrote:
> This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
> and use `lib` by default so that installations match the conventional placement
> of libraries. For example, it will now install `libdwarves.so` into
>  `/usr/local/lib` instead of `/usr/local` directly.
> 

What about distros that use /usr/[local/]/lib64 for 64-bit libraries? It
seems like CMAKE_INSTALL_LIBDIR does the right thing there also by
default, can you confirm? If that is indeed the case, it would be good
to amend the commit description to not be "lib"-specific, and say
something like "CMAKE_INSTALL_LIBDIR ensures installations match the
conventional placement of libraries - /usr/local/lib on some systems,
/usr/local/li64 on others. Otherwise folks might think they need to
override this when they probably don't. Thanks!

Alan

> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> Signed-off-by: Ben Olson <matthew.olson@intel.com>
> ---
> 
> This patch addresses this issue: https://github.com/acmel/dwarves/issues/48
> 
>  CMakeLists.txt | 17 ++++-------------
>  README         |  3 +--
>  2 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 8ca1bf2..b2c8057 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -21,18 +21,7 @@ else()
>  	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
>  endif()
>  
> -# Try to parse this later, Helio just showed me a KDE4 example to support
> -# x86-64 builds.
> -# the following are directories where stuff will be installed to
> -set(__LIB "" CACHE STRING "Define suffix of directory name (32/64)" )
> -
> -macro(_set_fancy _var _value _comment)
> -	if (NOT DEFINED ${_var})
> -		set(${_var} ${_value})
> -	else (NOT DEFINED ${_var})
> -		set(${_var} "${${_var}}" CACHE PATH "${_comment}")
> -	endif (NOT DEFINED ${_var})
> -endmacro(_set_fancy)
> +set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
>  
>  # where to look first for cmake modules,
>  # before ${CMAKE_ROOT}/Modules/ is checked
> @@ -84,7 +73,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
>  	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
>  endif()
>  
> -_set_fancy(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${__LIB}" "libdir")
> +if (NOT DEFINED LIB_INSTALL_DIR)
> +    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
> +endif()
>  
>  # libbpf uses reallocarray, which is not available in all versions of glibc
>  # libbpf's include/tools/libc_compat.h provides implementation, but needs
> diff --git a/README b/README
> index f9aeef7..0627872 100644
> --- a/README
> +++ b/README
> @@ -3,8 +3,7 @@ Build instructions:
>  1. install cmake
>  2. mkdir build
>  3. cd build
> -4. cmake -D__LIB=lib ..
> -5. make install
> +4. make install
>  
>  cmake Options:
>    -DBUILD_SHARED_LIBS

