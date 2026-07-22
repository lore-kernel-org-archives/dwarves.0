Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86924BBF0;
	Wed, 22 Jul 2026 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722865; cv=fail; b=JaVnATtXOYBo37tGXfBL05dDXRWf8HzLQKtAx3cZ/isHxGDxyRF/CzjVX9ZoiN4gd2CNPwIBl5Rb1qG3A5ykdewaDh/JJZCzm0qj/R6iNyvVBkBr50KIibqquINY1Tmb6hGj5ZM5iUhharwxouThZs9m/45gixectIXDsxBvQow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722865; c=relaxed/simple;
	bh=VLrZjdvkyCH1Epovctad/FyjSCCdPX5O7RzP9sNeS+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTgjJmtospdOvzlTMdacne39ch9ynB+CJK6YP0z10lRtSuPcAnScabx+FR1qagHT0VotEYRlF+ZiUNLFHJVgXsI4BktJFd9sg2jOdIGatL4z+AdWC+Q73pJpU52m9mWwL8niRcbycOTG7BIaawBUhLdkQfmtqgmcdKLB/RAJCNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rJ4PwTqQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FNY6XCmy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rJ4PwTqQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FNY6XCmy"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M4RXVm314262;
	Wed, 22 Jul 2026 12:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SAqnszDKWWOMOzuFJMHWug6r0trBH993RaLhZ0IYiEo=; b=
	rJ4PwTqQ6/TvTBPJiBApw42qxKUvI9cpQlidvpyXNxHs4Ib5gXd9kpw7O8C3Azw3
	Wyax3cT9YAtpTPLNXMFHb3SF40NNn84fsd884jSmcSgdunzwOpRh8NLrlSSBRYHy
	SVSLdaC69lEm0hohnvKzsb2FVbartM9aHolUaHucGnQ8JIuR6K2dWL7am4Y2oU7d
	IH14Vo0dDoa1lWpSUBAue/6BEWOm/vtey/Fw/tnOac4/EAArPPBH8pGM58YNRJwF
	QVWEyrrWDAYjNFW1nWjWrx5I2cJ2tjasBFoL1s5ai93qxkwAKXE0TVhSsTUxpxdS
	7nTfVjWc9MBZVu4gs9iZsg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1mv53fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 12:20:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66MCDdRQ037837;
	Wed, 22 Jul 2026 12:20:58 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxqvush-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 12:20:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvQPFhOFoaxelQBMj2ByV9TmWl8+9iMS4VnXaveELG8aX01FLD5NS0A/gD+sMs7TuJtfwjGeYoQYG/EERZc+PW9ipa7/axF/Xt05cK7bsn8vDTZYMO7zyk4uPIkYW/APniWsNHEhBCb1uVO9zRkK8xTBkyQW5Khu6XtJZn9vwQj3UDem+Y7C7fvMlRwy8wuV6xas32n7GcDnQKIATP417TpWm13rYASEJ2UkMtm/LLe4AZq6lbFE0orRHv7RlJjBwTdij8inBxryNXICG1z0HkroHZqelVn20G674srKzYe4a2Fpwk7KZcoBqudE5619VmGrbR/gP4bik5VzZ2fJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAqnszDKWWOMOzuFJMHWug6r0trBH993RaLhZ0IYiEo=;
 b=V0LAMXJ1DjqYgM7/TIbEuE94EL251MCGzPxrNruH84jm/iXyc0sHHsNNmfBofX7dRbsVfjhGfX8CPi3jfX4TSfdw6t1h/bX4r9i6OvnaIQ0GWo9pRli+UCC5HhySfLGnYbirDMiHsQUdEG00eZRFDQ2TCPKVGuFY0BcMgHXUnoWqQSpknxrcb6lO4REsxFbbMj5y86NBjLS2oWXdZM/NE43Oba9UBs8TXbJ5HUGISd2j3ofDWrecBVApTHkswkAboFRANktLtcssMNCOP7RrqNVJN+QVH1pnLtpD4JtvGtN4MxYHhLMyv5ekVvQb3UnAEtX+DX8WpNe44vdhADQJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAqnszDKWWOMOzuFJMHWug6r0trBH993RaLhZ0IYiEo=;
 b=FNY6XCmymzUDFwG5A9HJNIAYX+P0Tap2K4oZXu6YrHy/+js//P09eew9N2BMFzbrdhSWn62QC1XA8LHHOIbdJvjT1ftqK9Pp2vNhaVQn3Yg8IucHtRdw9zyozq5G+gDxROVS75hZh/We9meyO5kjtAmBkH7QQ8eSlBeDGtI644c=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CY8PR10MB6539.namprd10.prod.outlook.com (2603:10b6:930:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:20:50 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 12:20:50 +0000
Message-ID: <23d10309-7778-4d5a-a654-9d266be93736@oracle.com>
Date: Wed, 22 Jul 2026 13:20:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 1/2] btf_encoder: Only skip optimized parms when
 ABI changed
To: Jiri Olsa <olsajiri@gmail.com>
Cc: yonghong.song@linux.dev, arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
References: <20260714135035.814273-1-alan.maguire@oracle.com>
 <20260714135035.814273-2-alan.maguire@oracle.com> <al92oCDv0htfTJmd@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <al92oCDv0htfTJmd@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::10) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CY8PR10MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 72425274-483c-463b-cf84-08dee7ebaa8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|3023799007|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5Jw3uj3UZ8QtV0xWpkiM73lhx+o3jxZvTsA6q9gKU1MCkNcgwfuG2AzLv0IQslL0G0ndRtLGf+QG+Lo/WXVJeUIb+tnU6DquZl6lrFvPYtGNgCxlHMR4qFh8tT30CVbPB3hsr/fXh6a/ROW1DU8UZqgzCIgmByZnd9xULDyA2L3vnEM6mvWtrUqDw6/+vxoIK4yRCN+IAcN+OSRFdEfaqc5t4sQjw1TQlWgkNDMJocKZ8dLVAR5DnxZuE8+qgkRR0HsO6eAksrs44hWiHuKub9Lbc1dGBwKLPoc01f4tPPFVq7DchMYpHCh5qVkSwIfK7A8Ip5L5W1uXSQM+T0EMpQN2CEyL9unRFVqKDisGbSqruVIeut5siRNy6sg8HHCnR1DsMEUGbIj+naDafEXMVnkxANpWwBOdWp/JMnh5x3I6wMhDCNkR7mwWgUcUjKYdAY4Dsa4rItbaZu6LD3YfV4dsqh2xfxj9gLrAuxL7q+QIjK7OAdo1PcdV6h3uFU95f0TyF8hWgioCONjSpzBxEoOWOum272aU5u4rdzE4UZQCf8MuvMXhqdaIzb/rXxfZxDk0ZhZ3Q81YvAB5SBlWS8gahPjstqWekZoAJ/WlJ3qFZYWgMwdwn2pRo3F7i1m8op3phU6e34hv9f4uRizO7+zLYvnMqgYTi8uSTXGm3eU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(3023799007)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ymk1OWRvTjB3VEpodVJRbWVxeWZyVWZFVmEvay82YUZ2TjFJTmV2ZW9UWTVB?=
 =?utf-8?B?bEx5Y3pXTFdsa3FWSjY3Mk5uazBncW5zVW14NkRnTUZHR0VjOEJKM2JZUmJT?=
 =?utf-8?B?Tnl1aXJKUVlkMEUxMTRqZno1MDhFZWZFall0eHh6aC9QY2FSVDdReDBoZEti?=
 =?utf-8?B?c1BWSDl1K1F5cmdoeGFFWmJqd0t5dzZTM2tIM2FsczA5YTZWTytHR29JWnE2?=
 =?utf-8?B?T1N6dUxWUEVQOTRPOTRVR3FseVZMOHZ5YVg2cnF6OExRYVZoTUNqd2FLZkxW?=
 =?utf-8?B?eVZ6ckxUckR0MUVWUjRWazRWSFFvTHptRXpSaXdTOTZCSmdaWTlSU3ZUTUJT?=
 =?utf-8?B?OVRUcm5BQjRuMnJsVHdNb1drOXk1bllncFhHa3RaRTZJbUVzQy9BZG91b20w?=
 =?utf-8?B?TGNTdndtYnBlWVNNaERONlh5UG9ycGwyQnJXdms4aThiUkhmNDNmUjNHZldX?=
 =?utf-8?B?WWRhWEdpbDRkcWNRalU1RWRyQjBuaXlQY3hXVWMxcFp0N0x1VFBUWFNQVVpy?=
 =?utf-8?B?VEUxR2lGUUcyR0FnbTBSWHN0dEFFRmpPRnVaeVhLMy9HWHFsSGFvcGpZWWZ4?=
 =?utf-8?B?MklqWmJQY3RTZnFqQ2FqcnEremNrZjN4NEtVNXU3N3pWRmtZU3RoYitoVVMz?=
 =?utf-8?B?cXJRTUorUDF4M3RBTXpvSjZheENhOTBRcFR0eG1IWTJPVFdIR0k0RnltdG5D?=
 =?utf-8?B?NmNYcmM4VlV6bVR0TCt5SXlvbzI1SkJEVlVQWUxFYUdDbkdrZ3JKWWZJZGF4?=
 =?utf-8?B?WGU4bW1kSWRSRXlPUG42cUwwK1daek5NYnpnNHRZN1haeCswY1daalhNYzNV?=
 =?utf-8?B?ZVhrZzBZUGwvK3B3cmpJTy9yWXJYTUNJT3FVcVgraWIzV3FnOWFGd2NkODlV?=
 =?utf-8?B?Q3QrbnI3K2szb1hQanNnVmJrWlNUU1pwSllUN3RubTAzTTJhRDE5ZnUrL3g1?=
 =?utf-8?B?aFBNdHB0NTA2aitUUmw4dlZhNDVqWEhNb3MxRktjVnY4WXlLMERXZmxIVmU3?=
 =?utf-8?B?bkZtc2x6SHU5OS9OVHUrQStjNWgrcXh3VE1HeG1TL0lWczNtRzA2YlRXRWg4?=
 =?utf-8?B?eWRWSkl3OW4vQzRzWjV3V05tOGxBTmlVa0Nyb0hVZlBXNWxkcUM4bWZvVTd0?=
 =?utf-8?B?eXlSVkFpTW0raTVQMThLaWlQcXJIcTNTTlJPdjZtQ2Jtd1hOWENtczNSWlNw?=
 =?utf-8?B?alV0SlYreFF0V2c5SG5KWU43MHozdlN2MExTdE9RN1diVmx3dHBlYzRjN29n?=
 =?utf-8?B?eHpPN1ZBRjAxNEQwRFdEamh4anU1RTJUVHBVd0gxcHdZOGxjUXp5MVZYeGVB?=
 =?utf-8?B?eDJmM2p4WTZ0MHJBamdDdTVPRUlHNmVic05KVnVLREZxVDB0eFVIWlNoMyti?=
 =?utf-8?B?T0M2QTMzQXZINUxONFF2ZzFpVjNVMHR1MWlYT1ZmUUJiOWRTNHU1VEJ5N1dr?=
 =?utf-8?B?YUZXcUhrZjJncjZwWE1GbStvT3pFWEh1Um5rUGlsQ1BKdFZIaDlSeDBHZmlh?=
 =?utf-8?B?bnQrakl1ZnVqUzVkQ29sR1l4VWVER0t0YlB1Um0wN1VHQ0VXbUh4QWhnYmdJ?=
 =?utf-8?B?ZG51SG8xS0R5RVlGTmtpNURSdkhnUllIN2I3NVVvdlpFR1NhWFJOYkF4Z01M?=
 =?utf-8?B?ekNQTG1lU0hWZXM2bkRwSTNhR3c2bTBUVVg4NTduT1FwUzdWSGNhcTlmWmZh?=
 =?utf-8?B?Ymt6Kzdtb0xmOFdneldkYnBkb3Nza2ViMDhRSUNJVVNwaFhKZVlvTDhXN0ZN?=
 =?utf-8?B?UWROaFg0N2FGMHc0cDlDWjRUUkcvYk9Rcm15dGw0OUlJVzJJaUJ2RzhYMFBC?=
 =?utf-8?B?ODZBNEZ1YWloSXJma3M1emVMWnZDNFNRY0sxdSttYkVrSlMwaU1iTFAyN1g5?=
 =?utf-8?B?dys5T3ZCeDNIRWg3MFhOSUlla0pFUWZDRVlzY09DcXRLRDdjTHFRQk41WkZN?=
 =?utf-8?B?ZGlHS01OcEg5NkNPaktJZjNZeGhmUlFjdWFOeEJxUGdNdlZ5dGg2OGJydGtr?=
 =?utf-8?B?TUhmOE4wNjdySDhJTERJZHBSVU1SSExkVmx2T0ZjTmtPQXhmYit6TXNHWTFU?=
 =?utf-8?B?ZFMwNzVEa2xNUyt1VmJqN0ExKzB4TlhHVmRQNEI0bzd2YmN5REhwNHpyVGFw?=
 =?utf-8?B?dnJXWUZ6L2hyNU1uWnBjWTZwQWdBWCtlZXdwQUlJSytGckMyVjhDd2hicnFT?=
 =?utf-8?B?aVJzSXVNM2d2TGljN2RGYWMxVGFSRFdqa00zbW92Wk5ESy9mbjZoVUxubTBo?=
 =?utf-8?B?SDdzblRRd1J3WTRncnNxRXF0elZBbWdzeU53emxSa3JWSzZudjZoK1BUL1Va?=
 =?utf-8?B?U25KOHFaeS9VMms1SmIxRUdFVlp5eHR1MzVRbk96bStkRVhkTlUvQT09?=
X-Exchange-RoutingPolicyChecked:
	lUT/Eq00P1xamGLvY6uMBv8LALT3n8zVi5yKXzT8LRL64HALrt4NurcwCs7AcrYzlt9ws8EsbVUA4+yr8qxZOcgXxJM8VOX7I0XGMw6yGdlC29LmGtjm180hM4jmpxFzIZy6Jm8tF0zWJhgF6S9UL7hfbPp6eo9kKx1r31IHL6KFN+iWdGL7rN4PQElhfreEeHzqX2A5hBpGHolH23BvzdlIlzgK3OV3F/O23p8p3/W+1tqb2DHYks32GBSZ4BmGWntl2GqeOtvv2QLu77uCdiZ/QDwXozvRS9NvocMlPI2eeZ//WdaWQZebU14wZ6gVbIp8HYoHVssTuhwqt6VWpw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jyaMiq6nyyz7kWIAtpzGd2i9cg7H5xSYyt5qAnC0qPHjtSvjosNnYuhecE9OV3Di/EsMpd49EuIJGGrF3YPR0kVd3wUEIearZXuaSKyjNZ+S9mPpY4b4i1WN1t2VFbjsxqDwuJRpWEiim1kExYIy0LI4CxXnWSeEcO7lmR0roXeYAPWs16+T4aHZVpx6L2DjKS3d7RvXAf/X+SmmhoDGz0JWXREELs967RKbYBJMI6iYnW/owj9MzhP6C31O0Qk7IfDUtBs/yYGGSIg3BG888zCgHdDxSs4u7CRXg/xsI9/Tmn42iAiZuhw7YHgpcW60vTNrDHAP0ZsCf1SJBngl453U5dCh+5tJv+ll2agDq/OVkdiZM7LHaEfE00YwiljOM/fyRZZ81hjOOI0Ksj7TGqWDlHEZoPZ3ZZyzAeahfEmZ4W3n+vtSZlcatqTRHVSEO6f7fq8XXwu7kYQjxlq+ZCCn0vGdb74aN0Xzf43y3dppRfTPcy97ua7WvuNcNLE7lJaulHZvUiHPrqlLBpEeDMJDG6eL75wYKBRRN7Louoy2qgjHLmN3ZMcUyQXa0SZjsxfQCL1ueDkkXSpU1UCPlnyIR+5sw4xq6sCjBF/LspE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72425274-483c-463b-cf84-08dee7ebaa8b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:20:49.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZr0ghyTFR/Rmn2ZZDxFB3ojpLaVm2/5QZzuxlhkf+zCJV7Mlji/30z1B+saC/QlSDgxGaJSgnjQlSVsbCb9ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607220119
X-Proofpoint-GUID: -rh2IPA3A7xzV1HBIYEELRHZFOoK733N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEyMCBTYWx0ZWRfXxN12qRCwvlfc
 oS+IhIDnP4QtqYosCGsRIM3+/U8NMMnt328AlWmpQP/QKV8zE/hhrmxapeTqOuhT0w1Yipxhgsm
 NS1I45Vhazg2aUgUmHDLqOlPEYeyHYfHNnRUEzMTZl/8ig6ABGbc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEyMCBTYWx0ZWRfX/12B87L1/jXa
 Rdg7GBibHyb2xZegeC7f3QEjdCP5hlmACIF3TVWVpUQlZZpx1a1FQidoHqUTViOVWS9ZU1FJj7D
 H3kuUdiJI2RuaJbVoFmqfkenSe5M4dhTjVPPj0pzFsN3N6klFql5tZhAWKBSSs2ZMtoK4+njdzw
 AV14hABOj/ndc3D4SlRd6BS2esb4O+/mBEAs/gTQKBjOyjXtTKAaZfyyk1rpTP/iIpYjjnejYdI
 oxnQMUnmJKuNd/BQcFrdQdREXGjXiFja3nz5CfOr2LKTPQeR8mqmy3bbyU8S0Tuy/y2LCCauhlJ
 YavuNGulCi1DPiQdL+MZo7mB976fDHIW8p6QXQNSJb7KKji12OggfwBI60BHkBcCVxMuk7SbsqX
 Pzoox+cwLmHV4IxxiiM1CTnX7JpPcpTYZFAYcyWTEAsCELEXBENXbXwiJKAla89vSFI35iA833Y
 wwcBdNmDsPvc6/2TajqFx+V/EEF1T5ZlhJQX27Pg=
X-Authority-Analysis: v=2.4 cv=ZpPd7d7G c=1 sm=1 tr=0 ts=6a60b5ab b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=KHn_xgrHUyl9AOzVi5YA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-ORIG-GUID: -rh2IPA3A7xzV1HBIYEELRHZFOoK733N

On 21/07/2026 14:39, Jiri Olsa wrote:
> On Tue, Jul 14, 2026 at 02:50:34PM +0100, Alan Maguire wrote:
>> The true-signature series made optimized-parameter state more visible to
>> the BTF encoder.  Skipping every function with optimized parameters is too
>> broad, though: an unused parameter can still be part of the real calling
>> ABI, so default BTF should continue to encode that function.
>> 
>> Limit the optimized-parameter skip to cases where default BTF cannot
>> represent the concrete ABI safely:
>>  - clang functions marked as signature-changed via DW_CC_nocall
>>  - GCC optimized clones with ELF suffixes such as .isra or .constprop
>> 
>> When multiple saved states share the same base ELF function, prefer a
>> canonical state that does not require this optimized-parameter skip, so a
>> usable concrete instance is not dropped just because another optimized clone
>> exists.
>> 
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  btf_encoder.c | 97 ++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 73 insertions(+), 24 deletions(-)
>> 
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 38455a4..2e6eab0 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -95,6 +95,8 @@ struct btf_encoder_func_state {
>>  	uint8_t inconsistent_proto:1;
>>  	uint8_t uncertain_parm_loc:1;
>>  	uint8_t reordered_parm:1;
>> +	uint8_t signature_changed:1;
>> +	uint8_t optimized_symbol:1;
>>  	uint8_t ambiguous_addr:1;
>>  	int ret_type_id;
>>  	struct btf_encoder_func_parm *parms;
>> @@ -1209,27 +1211,44 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
>>  	return state;
>>  }
>>  
>> -/* some "." suffixes do not correspond to real functions;
>> - * - .part for partial inline
>> - * - .cold for rarely-used codepath extracted for better code locality
>> - */
>> -static bool str_contains_non_fn_suffix(const char *str) {
>> -	static const char *skip[] = {
>> -		".cold",
>> -		".part"
>> -	};
>> +static bool str_contains_suffix(const char *str, const char * const *suffixes, int nr_suffixes)
>> +{
>>  	const char *suffix = strchr(str, '.');
>>  	int i;
>>  
>>  	if (!suffix)
>>  		return false;
>> -	for (i = 0; i < ARRAY_SIZE(skip); i++) {
>> -		if (strstr(suffix, skip[i]))
>> +	for (i = 0; i < nr_suffixes; i++) {
>> +		if (strstr(suffix, suffixes[i]))
>>  			return true;
>>  	}
>>  	return false;
>>  }
>>  
>> +/* some "." suffixes do not correspond to real functions;
>> + * - .part for partial inline
>> + * - .cold for rarely-used codepath extracted for better code locality
>> + */
>> +static bool str_contains_non_fn_suffix(const char *str)
>> +{
>> +	static const char * const skip[] = {
>> +		".cold",
>> +		".part"
>> +	};
>> +
>> +	return str_contains_suffix(str, skip, ARRAY_SIZE(skip));
>> +}
>> +
>> +static bool str_contains_optimized_fn_suffix(const char *str)
>> +{
>> +	static const char * const suffixes[] = {
>> +		".constprop",
>> +		".isra",
>> +	};
>> +
>> +	return str_contains_suffix(str, suffixes, ARRAY_SIZE(suffixes));
>> +}
>> +
>>  static bool elf_function__has_ambiguous_address(struct elf_function *func)
>>  {
>>  	struct elf_function_sym *sym;
>> @@ -1295,6 +1314,17 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>  	state->optimized_parms = ftype->optimized_parms;
>>  	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>>  	state->reordered_parm = ftype->reordered_parm;
>> +	state->signature_changed = ftype->signature_changed;
>> +	if (state->addr) {
>> +		for (int i = 0; i < func->sym_cnt; i++) {
>> +			if (state->addr != func->syms[i].addr)
>> +				continue;
>> +			if (str_contains_optimized_fn_suffix(func->syms[i].name)) {
>> +				state->optimized_symbol = 1;
>> +				break;
>> +			}
>> +		}
>> +	}
>>  	ftype__for_each_parameter(ftype, param) {
>>  		const char *name;
>>  		char *final_name = NULL;
>> @@ -1497,19 +1527,17 @@ static int saved_functions_combine(struct btf_encoder *encoder,
>>  				   struct btf_encoder_func_state *a,
>>  				   struct btf_encoder_func_state *b)
>>  {
>> -	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc, reordered_parm;
>> +	uint8_t unexpected, inconsistent, uncertain_parm_loc, reordered_parm;
>>  
>>  	if (a->elf != b->elf)
>>  		return 1;
>>  
>> -	optimized = a->optimized_parms | b->optimized_parms;
>>  	unexpected = a->unexpected_reg | b->unexpected_reg;
>>  	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
>>  	uncertain_parm_loc = a->uncertain_parm_loc | b->uncertain_parm_loc;
>>  	reordered_parm = a->reordered_parm | b->reordered_parm;
>>  	if (!unexpected && !inconsistent && !reordered_parm && !funcs__match(encoder, a, b))
>>  		inconsistent = 1;
>> -	a->optimized_parms = b->optimized_parms = optimized;
>>  	a->unexpected_reg = b->unexpected_reg = unexpected;
>>  	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
>>  	a->uncertain_parm_loc = b->uncertain_parm_loc = uncertain_parm_loc;
>> @@ -1574,7 +1602,16 @@ static int btf_encoder__add_true_signature(struct btf_encoder *encoder,
>>  	return 0;
>>  }
>>  
>> -static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
>> +static bool btf_encoder_func_state__skip_optimized_parms(struct btf_encoder *encoder,
>> +							 struct btf_encoder_func_state *state)
>> +{
>> +	return !encoder->true_signature &&
>> +	       state->optimized_parms &&
>> +	       (state->signature_changed || state->optimized_symbol);
>> +}
> 
> so this take effect only when true_signatues are disabled?
> 

Yep; when true signature is enabled we are basically saying "give me
the actual representation even if it doesn't match source-level expectations";
this includes clang nocall and dot-suffixed gcc-optimized functions. With true 
signature disabled we skip such cases.

> ---
> 
> hi,
> sorry for delay, I checked this patchset on top of your pahole branch: 
>   alan-maguire/dwarves-inline-on-true-sig-v10
> 
> true signatues in that branch gives me different stats (than before)
> in generated functions:
> 
>    279 added, 94 removed (diff attached below)
> 

Ah, sorry that's the wrong branch; that has the work-in-progress v2 BTF inline 
stuff on top rather than just Yonghong's patches. Probably not a huge amount
of change in this area though, so I think the testing should still be valid
(those changes would have simply added inline encoding if the APIs were available
in libbpf which they weren't). Thanks for testing!

Alan
