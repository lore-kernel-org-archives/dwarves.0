Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB53164AA
	for <dwarves@vger.kernel.org>; Tue,  3 Mar 2026 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529230; cv=fail; b=nA9g8Yo/hR8cu2x43zVDYkt7GSsfQlIyoobPdZf7XKIRQaohGFjKLMjb/ODw7INJbpwbd9ydA8DwbPd/W3SJdsF0MhUGxxwJjoy8geWdBmLvSZyLFgpmPlT21j+JOqAOS1TmZgudRTNIsVOB8FyHcSJeDzRk6UZOxoTXfWudVGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529230; c=relaxed/simple;
	bh=DNcWaQd+5hIi+GUr87IluBTpARaSadK+QzByNqyZTYc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uRK4YYdPQ+//ChAlSgFcVqS1LEDqcG/kwCab5UdmPwG2cNSgERzvP2FDaXduY1gMOCksb3nJEiKo2ACF54HR2i8UbOIFemYkl5IKyak/xwt56ok7q7ESAD6Y6EBTo2gTrSZgufywO8nPrFIAdPmub01Tdc1SrDM46oTmU/wbwpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pAyyvzeT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=STvumHJz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pAyyvzeT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="STvumHJz"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62397PCi3174086
	for <dwarves@vger.kernel.org>; Tue, 3 Mar 2026 09:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UCPrTcJXfccGI6C69ocrZULo5eC6FekedyqFBc3mkCU=; b=
	pAyyvzeTNQdN6MIDUSNzedHc8gygzXuD1IpJDIsdS0AHnBijtFMu64cUzII2HFuO
	pkIU5JyR9zNy3o7ygSP3U6rh7tgH9PlBpH6Ns3ET5HVIYJJrFe6O959iWqXGdPyG
	7krxwTzOIZ3SSRN4qcPR2ZADpWozLUwwFrN0luZIi/nvB27uX8dxqQBKS2KlwHbJ
	EUR3iuW+FuXIsQ2H9I8R4PAR0DZar1C2u8kK/ZrCclVjPB3R5jwJEV1WPXpKqoWC
	jo6rePEMuwpcgq2t0V/9yiK2PYtMhRU9H0tSp4y92wXHlLf/qSDUh86zs/2Uwq5N
	OWvkT0yo980W6aAElksmKQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnvr0g08e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 03 Mar 2026 09:13:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6237cL1e034711
	for <dwarves@vger.kernel.org>; Tue, 3 Mar 2026 09:13:46 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpte39mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 03 Mar 2026 09:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmC7706f6J7HSv/wdPUAcY/XlWh9etaMRtJ1AbrE/FdbqfpeLuPQQrsnrF7efGfP/HB+zFwb2avxKkBrunvplMyqnc9yXyEtszPZamMzbJLS9hcvFaQX2dPWjfMXioUoyl3MiGwE38bXZnJxq9cvQJFdbMJ7pJSgvd7chDjBIsGcQ6+TVmrbEPstHkeTRd+OzcOH30texthp/Po1tF2TH9OdrL4pyYl9begGKFQ0CzX1sdzK6JQDePi2CEQojiYuWuRMKA7Ny3jOPgply1371ftQbR1Jo+DbqO0FLOetkY6wIJH4yJ15u5KJBhu14qQpYbSzaX3HxBkzZ4PPwdKplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCPrTcJXfccGI6C69ocrZULo5eC6FekedyqFBc3mkCU=;
 b=JG/7kMVmFPTz3snV90SPjr6mm0Qw2XeajnlKrLnV2NYQZRtongpq9cQjOOWIIbamB4xfiUFXdZZuanSrVSLY4CZaE07liBBOdi9AGnTIghgQev4nWgn1eQu14z+UQgHC30KJiic3L+r4XexL3HdCNUNZ7fYJU22SREiw2jdRMI2jLhUbIMHS+JNkKlEZCe/PoexCihtn/tFz18DndlDN2Wuml0MWrp1sB2WPiNvD+jX2f0AFG0vqrVc5+7U0ZQ9Dd7qkOJyicSymtewG53GDbC9jOmX3GCznylMNKKaVL6482wA9U1b7lyU26r+2RZAGzvb+gr1FPM5qNR/sIgyfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCPrTcJXfccGI6C69ocrZULo5eC6FekedyqFBc3mkCU=;
 b=STvumHJzwuYY9Qhb2QMqJE6meRvQaEpyS+Aau3VjNhY7SnT8LA0cIAxpM66FYTDrUTjIHHHRuwpaLbDpeHg2PO9tA93t4WOukbacuxW2wzJa4UsZEB9pjuN3xrF0nC7b4RWaSQIivuiJ0EAWiwlWFGd60hXtds6OXgPCRwc+sfM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB6880.namprd10.prod.outlook.com (2603:10b6:208:420::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 09:13:41 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 09:13:40 +0000
Message-ID: <1193aca9-33cc-4772-8b5f-a22a735bdd58@oracle.com>
Date: Tue, 3 Mar 2026 09:13:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Refactor selftests
To: Bruce McCulloch <bruce.mcculloch@oracle.com>, dwarves@vger.kernel.org
References: <20260302171033.1003145-2-bruce.mcculloch@oracle.com>
 <20260302171033.1003145-3-bruce.mcculloch@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260302171033.1003145-3-bruce.mcculloch@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fc0b85-03a8-4819-6c70-08de790528f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	7FAoO24IWkwttmJKRkqeB4hwkC9k5lKEDsYBVwZgj7rWuTeQZDFan2y4I1oibeq2baJnuhsb721/CLvfsjvgDxqvSvfE+NJ2l8fn753Nnhmxa4XCKZM86ie1CYJv3ufwv77iKMSF5SfqGGAWoVcU79fpwJrKMHKyj8+Am/XgCvgfqHU5N1+4djuC8VQJzjFVHDHL6AsQKJE8iAyHoFNGzb+6C3jAtA+Ho3zb7/0fllGElhD2QGIphXWm1yqJH+aT7MbMPh3ku4xKEiRGL8e2acSiRG1xLjmPtU5/sSfL3V0T7uH1uGhvNinek+GKTTIGvVHrAWpDX4xW/S3kYEyV4dNh/ARuqkcZZtgYB9Smz71cbSmAm5UoM1O/liQ+ef74BPvPH2/TTKo88uK3APooc8RLKRiNuVTq2vyHk2BVz6lI4jYR4T99vGZ2nos3HvJj3A5o8Y+R3qlp/a4jzEdlt6BM+xW4mnX+Jx61yl6TXyGehrxB//4wC9hL2Ci3U2E9DoLIhIFMwvWYEKXTyOZw/9n9pOeKk50kEZPcrXK7vB86JXJUP+dHYAJZisURDMlHE02de4slJJEVcd6Nu8tv/Lx32z6Fh1ZUaO2XDFIxKmw5YyBOXvq39mre7waVZ4jxnnMAJIOmjFSvCwqu1phtgBKDXcAFu0XEbUDxRY+bbO1rPe6H/5VvLol5V+qFWCfqNxQ2wK/NlDOhurcUtVauUoqATK0DA07MkB7pVSi8ntjWlMv+8FlRwJEFRDxCIA6L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REI0Q1FPajNaVkY1bGNVU05HSnpNTkt2MmhtRXFsdnUvSDk5WlU5QW5YOUZk?=
 =?utf-8?B?c2Uwb3E1VHBoNWZvMWV5WjJZU2VaL2N2bmFSbUI0YUdhWkFzYmhFQ3lHSlVM?=
 =?utf-8?B?SjV2OVlRMUdEcmFDR09VVVVqUEhQQ3R0YVVFYUU5ekM3cUNUMmMwTzI3bGM4?=
 =?utf-8?B?NVdMR2hSSnNQYUZjWWlHSnJFTEwwdHp1TytINjFYbU5keDFxaUhKSTgvRnlG?=
 =?utf-8?B?RmFZU2Z6OENQUGx4OFh5SExZWUE4bXRBZnc1aEVRSEoxcDhLTmgwS0Y1WDRC?=
 =?utf-8?B?eFhybnBoU0NkL25oQVU4cFM4NUcwYnFCaUdYQ1hHU2ludjdXMHZhN2Q1MC8z?=
 =?utf-8?B?Zmpyb21HbW5JbTc5ekZtTmh4eldRTXFUUVVuWHF5NkdudkFXS1ZsSFdnSlNz?=
 =?utf-8?B?RC9DZkVtaXArRkVhai85Q2xWU2F6eis5dkxkeXdwM1lzVlRsR2NGVmF4K3ow?=
 =?utf-8?B?amJNck9RNGRWb1VGL2ZXVEVKZUIwc0JCM3VjREh5UTFhRmF0YS8vREVESjhn?=
 =?utf-8?B?ZmJVM3NndmNuZDVhY1ZyZWRaWE1UbUZ2bUdHdFVPRjFpRDluZ2ZTeUdsbHdQ?=
 =?utf-8?B?LzVndVBLTFh2THVNZGUxb1BXbmxIY2VFQzk2akZlSGdIQmNlRFI5MlY4TkpK?=
 =?utf-8?B?enpTZmRsVFo2U0xvMDZwWkJpZmpNVTR3RnFPOUF0LzVwSkVOZzFjZkpDTVph?=
 =?utf-8?B?MFF2TklJZmdDOHY0ZkJyd3lxTDVlYzBOVEFVakpUYkJIRk9WMEVMM1NteEZ1?=
 =?utf-8?B?dWYrL2xaU3BPdk1zdmhlZ21lSEU4aG96YUMvQU9hZ0R5Znl1SnVpNDVGcGJy?=
 =?utf-8?B?TGpzTEQ5RVhxcGFHdHpwSXRpSmJ0VDZWVWlVY0l5RHg2Vkl3SzNqRTFseTFs?=
 =?utf-8?B?dW42YzdBSDVhZmRuajZxTHhTNTdubGt0R25UQ3VzWWdTTzJvdTgzRUNvQXNV?=
 =?utf-8?B?bmZhbm1tTnlRQUFBeWd3QjRwYUVPZldTajBUTXJHYVVzSEZGWW1Lem1XUzNQ?=
 =?utf-8?B?dzBxWlYrRXZjT005dVVuNHl4aE5LUWhkanlaMnJjT3owbGpyNG4zMjFPWWJF?=
 =?utf-8?B?bW44UjBiTFZRL2hyakg0czRYbkhUTVA4NlNtaGZ3bnI5bkZuRy9iVVRWS25B?=
 =?utf-8?B?UndnTXVrdFdHd1dUWER2Y1RJU3psaGtMZU9oVjVKSW4vN050em1lZ3FVQU15?=
 =?utf-8?B?dTlXOEJ2RkxGR1c0Z1FYNHMxN3F1eExDRW9EU2NGSkkyMUk5bGQzOWtpMXl6?=
 =?utf-8?B?TUJJclV5dzVPQ0JPZUNrU29LRXVmY2I4emlGM3R3VmRKQVphcGtJS2Z1d1k5?=
 =?utf-8?B?R3FFUDFBSlBEVU1CNldHdzFza1JDcnhNQTZTV3h5THlvYUc5QkpIWE9ucVJK?=
 =?utf-8?B?NkZKeXhkUENoRmd6RDhPREc3MGJGOEtLSkRaQ09qaERESFNXWXg4a0F6M0lJ?=
 =?utf-8?B?WWkrWVBMNTdRSWhaRWt4V3hNZUpGcGszUk9EeWE3dVFtaGxjMTl0OG9hUStt?=
 =?utf-8?B?L3loSmh4U0ZPTUhxejZxVzQrQTE4TjYxaWlqaWx6eHFqZ1pLR1R2SGJ6RTVX?=
 =?utf-8?B?N01FcU9RcUlOMllIdW1tUnNHb1hzaC9Hb2tBengvNFNobVVUdmhobTluZklk?=
 =?utf-8?B?WDZRK3FnTmM0NjRvenJtWlpwNmJ5SXRJc3BCM3dra0NwODFVdXgvVzRwVys1?=
 =?utf-8?B?Q0hkRE1uWFVTVWdqNndkWFlESjlubTJOWjFFVkRjRkpOUXF2MWpFVktmTkhv?=
 =?utf-8?B?UWVjREdCVnBwZzd3NEpxNE5pUElZVGV1TGpROTFsVkY2blVDZEh3UStuZXI0?=
 =?utf-8?B?OW1RQ1B4bXFxQUNvUit6cWFOdjc0ZXRvYi9sZU9pOW1oSEhTbFJKOHdUdlpQ?=
 =?utf-8?B?MU0xeUthUERocElqaVhpRzEwUFlkZ01hWENPN1g5aFZrMy8xYkpkVXFqU01J?=
 =?utf-8?B?K1J6VVh6TlJVWUMrLzEzNEpsVlh3Wnh6eDYvZHZUeVAveWxRVFZsUEt2bjA5?=
 =?utf-8?B?YmpraDFOQzBoTVFXZS92T3RWcDg4TmU4TVF5Y2t0VkkwM05Scjc4KytJUHZJ?=
 =?utf-8?B?V1hFTUNEL2Yzb3RqWlo3U2FzZTlWSkZvd1pIZTJrVXZwWDJwYTl5WEg2NEZB?=
 =?utf-8?B?R2REVmtCWlNTMWttTnZIY2x1dnBKWlU3Ykh2TklZV2NEQXlJY25Galh4NWsv?=
 =?utf-8?B?OHVpanI4aThmZnA2b05LOTF2WnBKMWNPa1krL1FTMFFidklIT095MU5LOHV3?=
 =?utf-8?B?R3M2VFprdGU2bEJnemNOYUpub1R6WktBOUNTWDBqS2k0VmRsbmdwRmRVcVN2?=
 =?utf-8?B?eVpvT3JJTVFyZ21TTll0ZkFZbnRVWEl3cjdyZFhwaGdGekVUZFB0UT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M6Z3yFOoMvbcTSXwCXmcsDchhkDurTQPnUmLV6XbVI6rEycE+xWgmhX4LYzWOYFJ0QeBM6gzgpSyrsN9FLvK58OWn4iJLKvUOTcH6sxVedzhZ/kwCoZFICINw3DiLEjbcrLoKkgJ/GmhiTka6Td/rd4DuMoivvaI5+xRufQYB979KLvDB20Fw+ULI2oOyFi4F1IoVdjiBLurRTQug8ioMkWjV5sVElCKcycayYQ/OMqUUE+hLLBKcZAZfJmbcVdWKWC61pcrvt99mgkFNy3Yg+gL/nCwdEZjEb3CYYiAmLYyQ5bvoqmZWC9qBdxn1ZLRnbL19lg5K5JCF9j+qqgUOQzTXW1XbWKWJ4eM14qvxRGtANaVlbYeVcFIN8DMI7VRP+ImxHQlKYXtL1DFOQxMPouAgCn8KiKefaA9eDeEUBK22njr4FqO/GQ+V1scu52IWfoU6K2ItIDG+UpYpeMIo4K/Dpp6RnRk7IYP/vZkB7izE1KKDwXk7rDWxT5W1yN+zzk5oA37NclgLQFBJtdVwpvcTLfTCNxUy4xZxDg1wBheeqypoqJC5cN9pSBEzgvt0TekNoy17QfcnGEs+HCucNfMxhLvQA7FKXJC/l+Yv2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fc0b85-03a8-4819-6c70-08de790528f4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:13:40.4764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7lp3a1wBqapIPplcik6nd4c4FhVBjrbsTP57ly6eN6gKalbQLNz59mRXKgt8pMQH6ZZAy3ll92JMH7uHiznyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603030068
X-Proofpoint-ORIG-GUID: QXs27oXnv8HAEBdo7vLG4NbW_tjkT2ih
X-Proofpoint-GUID: QXs27oXnv8HAEBdo7vLG4NbW_tjkT2ih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA2NyBTYWx0ZWRfX1Vh4E/OS5knb
 7HfN4/XlSvj+V8wieaWC8eMqDTZMPvYHb38eMp+7vpxVrZjlScPhVtnvL/fkfyx0PF3xiqfeG+J
 rqdpKCaZGiFDGPKtTBxnzLZpQ1PrKoT5vwE7gvZgg+rEz6ptQgfLWvww5xMX7ksTPFikVcBisnw
 gKJkKgAI4RLIsHTJvSoyntnICRXBPwtn5h73jMVe9tNYQg2i2aD6AXbzl2qjWcIYMBrzMbp45Bj
 9k59NcT3N/lYJK3G5ef7yXLR5sSAwRNWga3Rxi4JXTiN+2orUKZFvVaD6Mwvq0m1ihNL6xc+6c9
 mcw4Rq6zEFGEKQAX/3RARsF20JRwgHZqxZjtWGn0OhqDMczbfh6syOST9FwqkYBA1xx4+D+kgO/
 v29FQeT7Ty4g3RTKgX3cFHwljqoOU9i+HegS+7b6xGDuSltf9H0QBrEbnglNL3Du9+JHG6nS6ac
 WvIdYCp+Ucdn4aAKNI8aIop+cnaUhbVpFAI9NDmg=
X-Authority-Analysis: v=2.4 cv=GaUaXAXL c=1 sm=1 tr=0 ts=69a6a64b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=NEAV23lmAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=civBil92aTTDbgVxV2cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12261

On 02/03/2026 17:10, Bruce McCulloch wrote:
> Hello All,
> 
> Here is a small patch to clean up common functions in the testsuite and
> introduce a few quality of life features in a common library. Please let
> me know if you have any concerns or would like to see any additional
> features.
> 
> Bruce

hi Bruce, thanks for the patch! I ran it through dwarves CI and we see
a fatal failure in [1] due the the fact that /usr/bin/perf isn't a
program with DWARF but rather a shell wrapper. That's been a long-standing
issue in the selftests/CI, but was non-fatal previously:

Pretty printing of files using DWARF type information: libbpf: failed to get EHDR from /usr/sbin/perf
pahole: /usr/sbin/perf: Invalid argument
skip: /usr/sbin/perf doesn't have 'struct perf_event_header' type info

If you want to run CI yourself you can clone https://github.com/acmel/dwarves
on github and push a branch; you will see the CI run under the "Actions" tab
of your repo.


[1] https://github.com/alan-maguire/dwarves/actions/runs/22597958001
> ---
> Simple refactoring of the testsuite with the creation of a shared
> library (tests/test_lib.sh).
> Additions include:
> * Getters to find vmlinux.
> * Functions to open tmp dirs and tmp files.
> * Functions to automatically clean tmp dirs and files on pass.
> * On fail, tmp dirs are preserved.
> * Functions to pass/fail/softfail tests (works with CI).
> * Logging functions with varying verbosity levels.
> * Colors.
> 
> Signed-off-by: Bruce McCulloch <bruce.mcculloch@oracle.com>
> ---
>  tests/btf_functions.sh        | 143 +++++++++++-------------------
>  tests/default_vmlinux_btf.sh  |  18 ++--
>  tests/flexible_arrays.sh      |  48 +++++-----
>  tests/pfunct-btf-decl-tags.sh |  34 +++----
>  tests/prettify_perf.data.sh   |  53 ++++++-----
>  tests/reproducible_build.sh   |  47 +++++-----
>  tests/test_lib.sh             | 161 ++++++++++++++++++++++++++++++++++
>  tests/tests                   |  29 +++---
>  8 files changed, 332 insertions(+), 201 deletions(-)
>  create mode 100755 tests/test_lib.sh
> 
> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
> index ee0f9ff..127640e 100755
> --- a/tests/btf_functions.sh
> +++ b/tests/btf_functions.sh
> @@ -8,45 +8,22 @@
>  # also should have been.
>  #
>  
> -outdir=
> -
> -fail()
> -{
> -	# Do not remove test dir; might be useful for analysis
> -	trap - EXIT
> -	if [[ -d "$outdir" ]]; then
> -		echo "Test data is in $outdir"
> -	fi
> -	exit 1
> -}
> -
> -cleanup()
> -{
> -	rm ${outdir}/*
> -	rmdir $outdir
> -}
> -
> -vmlinux=${vmlinux:-$1}
> -
> -if [ -z "$vmlinux" ] ; then
> -	vmlinux=$(pahole --running_kernel_vmlinux)
> -	if [ -z "$vmlinux" ] ; then
> -		echo "Please specify a vmlinux file to operate on"
> -		exit 2
> -	fi
> -fi
> +source test_lib.sh
>  
> -if [ ! -f "$vmlinux" ] ; then
> -	echo "$vmlinux file not available, please specify another"
> -	exit 2
> +vmlinux=$(get_vmlinux $1)
> +if [ $? -ne 0 ] ; then
> +	info_log "$vmlinux"
> +	test_fail
>  fi
>  
> -outdir=$(mktemp -d /tmp/btf_functions.sh.XXXXXX)
> +outdir=$(make_tmpdir)
>  
> +# Comment this out to save test data.
>  trap cleanup EXIT
>  
> -echo -n "Validation of BTF encoding of functions; this may take some time: "
> -test -n "$VERBOSE" && printf "\nEncoding..."
> +title_log "Validation of BTF encoding of functions."
> +info_log "This may take some time."
> +verbose_log "Encoding..."
>  
>  # Here we use both methods so that we test pahole --lang_exclude, that is
>  # used in the Linux kernel BTF encoding phase, and as well to make sure all
> @@ -57,7 +34,7 @@ export PAHOLE_LANG_EXCLUDE=rust
>  pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |\
>  	grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
>  
> -test -n "$VERBOSE" && printf "done.\n"
> +verbose_log "done."
>  
>  funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf 2>/dev/null|sort)
>  
> @@ -87,8 +64,8 @@ while IFS= read -r btf ; do
>  			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
>  				const_insensitive=$((const_insensitive+1))
>  			else
> -				echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> -				fail
> +				error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> +				test_fail
>  			fi
>  		else
>  			inline=$((inline+1))
> @@ -98,13 +75,11 @@ while IFS= read -r btf ; do
>  	fi
>  done < $outdir/btf.funcs
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Matched $exact functions exactly."
> -	echo "Matched $inline functions with inlines."
> -	echo "Matched $const_insensitive functions with multiple const/non-const instances."
> -	echo "Ok"
> -	echo "Validation of skipped function logic..."
> -fi
> +verbose_log "Matched $exact functions exactly."
> +verbose_log "Matched $inline functions with inlines."
> +verbose_log "Matched $const_insensitive functions with multiple const/non-const instances."
> +verbose_log "Ok"
> +verbose_log "Validation of skipped function logic..."
>  
>  skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{ print $1}')
>  
> @@ -113,16 +88,14 @@ for s in $skipped_fns ; do
>  	# Ensure the skipped function are not in BTF
>  	inbtf=$(grep " $s(" $outdir/btf.funcs)
>  	if [[ -n "$inbtf" ]]; then
> -		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> -		fail
> +		error_log "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> +		test_fail
>  	fi
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Skipped encoding $skipped_cnt functions in BTF."
> -	echo "Ok"
> -	echo "Validating skipped functions have incompatible return values..."
> -fi
> +verbose_log "Skipped encoding $skipped_cnt functions in BTF."
> +verbose_log "Ok"
> +verbose_log "Validating skipped functions have incompatible return values..."
>  
>  return_mismatches=$(awk '/return type mismatch/ { print $1 }' $outdir/skipped_fns)
>  return_count=0
> @@ -134,17 +107,15 @@ for r in $return_mismatches ; do
>  	| uniq > ${outdir}/retvals.$r
>  	cnt=$(wc -l ${outdir}/retvals.$r | awk '{ print $1 }')
>  	if [[ $cnt -lt 2 ]]; then
> -		echo "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
> -		fail
> +		error_log "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
> +		test_fail
>  	fi
>  	return_count=$((return_count+1))
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Found $return_count functions with multiple incompatible return values."
> -	echo "Ok"
> -	echo "Validating skipped functions have incompatible params/counts..."
> -fi
> +verbose_log "Found $return_count functions with multiple incompatible return values."
> +verbose_log "Ok"
> +verbose_log "Validating skipped functions have incompatible params/counts..."
>  
>  param_mismatches=$(awk '/due to param / { print $1 }' $outdir/skipped_fns)
>  
> @@ -169,10 +140,8 @@ for p in $param_mismatches ; do
>  		if [[ -n "$inlined" ]]; then
>  			multiple_inline=$((multiple_inline+1))
>  		else
> -			if [[ -n "$VERBOSE" ]]; then
> -				echo "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
> -				echo "Full skip message from pahole: $skipmsg"
> -			fi
> +			verbose_log "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
> +			verbose_log "Full skip message from pahole: $skipmsg"
>  			warnings=$((warnings+1))
>  		fi
>  	else
> @@ -180,24 +149,22 @@ for p in $param_mismatches ; do
>  	fi
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Found $multiple instances with multiple instances with incompatible parameters."
> -	echo "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
> -	echo "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
> -	echo "Found $warnings instances where pfunct did not notice inconsistencies."
> -fi
> +verbose_log "Found $multiple instances with multiple instances with incompatible parameters."
> +verbose_log "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
> +verbose_log "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
> +verbose_log "Found $warnings instances where pfunct did not notice inconsistencies."
>  
>  # Some specific cases can not  be tested directly with a standard kernel.
>  # We can use the small binary in bin/ to test those cases, like packed
>  # structs passed on the stack.
>  
> -test -n "$VERBOSE" && echo -n "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
> +verbose_log "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
>  
> -test -n "$VERBOSE" && printf "\nBuilding test_bin..."
> +verbose_log "Building test_bin..."
>  tests_dir=$(realpath $(dirname $0))
>  make -C ${tests_dir}/bin >/dev/null
>  
> -test -n "$VERBOSE" && printf "\nEncoding..."
> +verbose_log "Encoding..."
>  pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/test_bin.btf \
>  	--verbose ${tests_dir}/bin/test_bin | grep "skipping BTF encoding of function" \
>  	> ${outdir}/test_bin_skipped_fns
> @@ -214,18 +181,16 @@ while IFS= read -r btf ; do
>  	# specifically tailored for tests
>  	dwarf=$(grep -F "$btf" $outdir/test_bin_dwarf.funcs)
>  	if [[ "$btf" != "$dwarf" ]]; then
> -		echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> -		fail
> +		error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> +		test_fail
>  	else
>  		exact=$((exact+1))
>  	fi
>  done < $outdir/test_bin_btf.funcs
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Matched $exact functions exactly."
> -	echo "Ok"
> -	echo "Validation of skipped function logic..."
> -fi
> +verbose_log "Matched $exact functions exactly."
> +verbose_log "Ok"
> +verbose_log "Validation of skipped function logic..."
>  
>  skipped_cnt=$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}')
>  
> @@ -234,16 +199,14 @@ for s in $skipped_fns ; do
>  	# Ensure the skipped function are not in BTF
>  	inbtf=$(grep " $s(" $outdir/test_bin_btf.funcs)
>  	if [[ -n "$inbtf" ]]; then
> -		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> -		fail
> +		error_log "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> +		test_fail
>  	fi
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Skipped encoding $skipped_cnt functions in BTF."
> -	echo "Ok"
> -	echo "Validating skipped functions have uncertain parameter location..."
> -fi
> +verbose_log "Skipped encoding $skipped_cnt functions in BTF."
> +verbose_log "Ok"
> +verbose_log "Validating skipped functions have uncertain parameter location..."
>  
>  uncertain_loc=$(awk '/due to uncertain parameter location/ { print $1 }' $outdir/test_bin_skipped_fns)
>  legitimate_skip=0
> @@ -266,12 +229,10 @@ for f in $uncertain_loc ; do
>  			fi
>  		fi
>  	done
> -	echo "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
> -	fail
> +	error_log "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
> +	test_fail
>  done
>  
> -if [[ -n "$VERBOSE" ]]; then
> -	echo "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
> -fi
> -echo "Ok"
> -exit 0
> +verbose_log "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
> +
> +test_pass
> diff --git a/tests/default_vmlinux_btf.sh b/tests/default_vmlinux_btf.sh
> index a855ca7..496e840 100755
> --- a/tests/default_vmlinux_btf.sh
> +++ b/tests/default_vmlinux_btf.sh
> @@ -1,6 +1,7 @@
>  #!/bin/bash
> +source test_lib.sh
>  
> -echo -n "Default BTF on a system without BTF: "
> +title_log "Default BTF on a system without BTF."
>  
>  ulimit -c 0
>  
> @@ -13,8 +14,7 @@ ulimit -c 0
>  nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole -F btf list_head 2>&1 | wc -l)
>  
>  if [ $nr_lines -eq 0 ] ; then
> -	echo "FAILED"
> -	exit 1
> +	test_softfail
>  fi
>  
>  # There is also the case where no debugging info is available, be it DWARF of
> @@ -22,11 +22,15 @@ fi
>  # that as well
>  #
>  nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole 2>&1 | wc -l)
> +nr_lines=0
>  
>  if [ $nr_lines -eq 0 ] ; then
> -	echo "FAILED"
> -	exit 1
> +	test_softfail
>  fi
>  
> -echo "Ok"
> -exit 0
> +check_softfail
> +if [ $? -eq 2 ] ; then
> +	test_fail
> +else
> +	test_pass
> +fi
> \ No newline at end of file
> diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
> index 59fa38e..4e9e995 100755
> --- a/tests/flexible_arrays.sh
> +++ b/tests/flexible_arrays.sh
> @@ -5,22 +5,23 @@
>  #
>  # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
>  
> -vmlinux=${vmlinux:-$1}
> +source test_lib.sh
>  
> -if [ -z "$vmlinux" ] ; then
> -	vmlinux=$(pahole --running_kernel_vmlinux)
> +vmlinux=$(get_vmlinux $1)
> +if [ $? -ne 0 ] ; then
> +	info_log "$vmlinux"
> +	test_fail
>  fi
>  
> -if [ ! -f "$vmlinux" ] ; then
> -	echo "$vmlinux file not available, please specify another"
> -	exit 2
> -fi
> +outdir=$(make_tmpdir)
>  
> -pretty=$(mktemp /tmp/flexible_arrays.data.sh.XXXXXX.c)
> +# Comment this out to save test data.
> +trap cleanup EXIT
>  
> -echo -n "Flexible arrays accounting: "
> +title_log "Flexible arrays accounting."
>  
>  for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux | cut -f1) ; do
> +	pretty=$(make_tmpsrc)
>  	pahole $struct $vmlinux > $pretty
>  
>  	# We need to check for just one tab before the comment as when expanding unnamed
> @@ -48,30 +49,27 @@ for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux |
>  	[ -z "$stat_nr_flexible_arrays" ] && stat_nr_flexible_arrays=0
>  	stat_nr_embedded_flexible_arrays=$(grep "flexible array members:.*middle:" $pretty | sed -r 's/.*middle: *([[:digit:]]+).*/\1/g')
>  	[ -z "$stat_nr_embedded_flexible_arrays" ] && stat_nr_embedded_flexible_arrays=0
> -	test -n "$VERBOSE" && echo "end: $struct: $nr_flexible_arrays $stat_nr_flexible_arrays"
> -	test -n "$VERBOSE" && echo "middle: $struct: $nr_embedded_flexible_arrays $stat_nr_embedded_flexible_arrays"
> +	verbose_log "end: $struct: $nr_flexible_arrays $stat_nr_flexible_arrays"
> +	verbose_log "middle: $struct: $nr_embedded_flexible_arrays $stat_nr_embedded_flexible_arrays"
>  
>  	if [ "$nr_embedded_flexible_arrays" != "$stat_nr_embedded_flexible_arrays" ] ; then
> -		test -n "$VERBOSE" && printf "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
> +		verbose_log "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
>  			"$struct" "$stat_nr_embedded_flexible_arrays" "$nr_embedded_flexible_arrays"
> -		test -n "$VERBOSE" && pahole $struct $vmlinux
> -		FAILED=1
> +		verbose_log pahole $struct $vmlinux
> +		test_softfail
>  	fi
>  
>  	if [ "$nr_flexible_arrays" != "$stat_nr_flexible_arrays" ] ; then
> -		test -n "$VERBOSE" && printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
> +		verbose_log printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
>  			"$struct" "$stat_nr_flexible_arrays" "$nr_flexible_arrays"
> -		test -n "$VERBOSE" && pahole $struct $vmlinux
> -		FAILED=1
> +		verbose_log pahole $struct $vmlinux
> +		test_softfail
>  	fi
> -
> -	rm -f $pretty
>  done
>  
> -if [ -n "$FAILED" ] ; then
> -	echo "FAILED"
> -	exit 1
> +check_softfail
> +if [ $? -ne 0 ] ; then
> +	test_fail
> +else
> +	test_pass
>  fi
> -
> -echo "Ok"
> -exit 0
> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
> index 69babef..35884b4 100755
> --- a/tests/pfunct-btf-decl-tags.sh
> +++ b/tests/pfunct-btf-decl-tags.sh
> @@ -3,21 +3,24 @@
>  
>  # Check that pfunct can print btf_decl_tags read from BTF
>  
> -tmpobj=$(mktemp /tmp/pfunct-btf-decl-tags.sh.XXXXXX.o)
> +source test_lib.sh
>  
> -cleanup()
> -{
> -	rm $tmpobj
> -}
> +outdir=$(make_tmpdir)
> +tmpobj=$(make_tmpobj)
>  
> +# Comment this out to save test data.
>  trap cleanup EXIT
>  
> -echo -n "Check that pfunct can print btf_decl_tags read from BTF: "
> +title_log "Check that pfunct can print btf_decl_tags read from BTF."
> +
> +# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
> +# in upstream version 16.
> +# UPTODO: add a check here for that.
>  
>  CLANG=${CLANG:-clang}
>  if ! command -v $CLANG > /dev/null; then
> -	echo "Need clang for test $0"
> -	exit 1
> +	error_log "Need clang for test $0"
> +	test_fail
>  fi
>  
>  (cat <<EOF
> @@ -55,13 +58,12 @@ out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
>  d=$(diff -u <(echo "$expected") <(echo "$out"))
>  
>  if [[ "$d" == "" ]]; then
> -	echo "Ok"
> -	exit 0
> +	test_pass
>  else
> -	echo "pfunct output does not match expected:"
> -	echo "$d"
> -	echo
> -	echo "Complete output:"
> -	echo "$out"
> -	exit 1
> +	error_log "pfunct output does not match expected:"
> +	info_log "$d"
> +	info_log
> +	info_log "Complete output:"
> +	info_log "$out"
> +	test_fail
>  fi
> diff --git a/tests/prettify_perf.data.sh b/tests/prettify_perf.data.sh
> index 2d16cf5..06ff523 100755
> --- a/tests/prettify_perf.data.sh
> +++ b/tests/prettify_perf.data.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0-only
>  # Copyright © 2024 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
>  # 
> @@ -7,30 +7,35 @@
>  # Check if the perf binary is available, if it is from a distro, normally it
>  # will get the needed DWARF info using libddebuginfod, we'll check if the
>  # needed types are available, skipping the test and informing the reason.
> +source test_lib.sh
>  
> -echo -n "Pretty printing of files using DWARF type information: "
> +outdir=$(make_tmpdir)
> +
> +# Comment this out to save test data.
> +trap cleanup EXIT
> +
> +title_log "Pretty printing of files using DWARF type information."
>  
>  perf=$(which perf 2> /dev/null)
>  if [ -z "$perf" ] ; then
> -	echo "skip: No 'perf' binary available"
> -	exit 2
> +	info_log "skip: No 'perf' binary available"
> +	test_fail
>  fi
>  
>  perf_lacks_type_info() {
>  	local type_keyword=$1
>  	local type_name=$2
>  	if ! pahole -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
> -		echo "skip: $perf doesn't have '$type_keyword $type_name' type info"
> -		return 1
> +		info_log "skip: $perf doesn't have '$type_keyword $type_name' type info"
> +		test_softfail
>  	fi
> -	return 0
>  }
>  
> -perf_data=$(mktemp /tmp/prettify_perf.data.sh.XXXXXX.perf.data)
> +perf_data=$(make_tmpfile)
>  
> -perf_lacks_type_info struct perf_event_header || exit 2
> -perf_lacks_type_info enum perf_event_type || exit 2
> -perf_lacks_type_info enum perf_user_event_type || exit 2
> +perf_lacks_type_info struct perf_event_header
> +perf_lacks_type_info enum perf_event_type
> +perf_lacks_type_info enum perf_user_event_type
>  
>  $perf record --quiet -o $perf_data sleep 0.00001
>  
> @@ -46,21 +51,23 @@ check_expected_number_of_filtered_perf_record_metadata() {
>  	local nr_records=$(number_of_filtered_perf_record_metadata $metadata_record)
>  
>  	if [ "$nr_records" != "$expected_records" ] ; then
> -		echo "FAIL: expected $expected_records PERF_RECORD_$metadata_record metadata records, got $nr_records"
> -		return 1;
> +		error_log "FAIL: expected $expected_records PERF_RECORD_$metadata_record metadata records, got $nr_records"
> +		test_softfail
>  	fi
> -	return 0
>  }
>  
> -check_expected_number_of_filtered_perf_record_metadata COMM 2 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata EXIT 1 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata TIME_CONV 1 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata THREAD_MAP 1 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata CPU_MAP 1 || exit 1
> -check_expected_number_of_filtered_perf_record_metadata FINISHED_INIT 1 || exit 1
> +check_expected_number_of_filtered_perf_record_metadata COMM 2
> +check_expected_number_of_filtered_perf_record_metadata EXIT 1
> +check_expected_number_of_filtered_perf_record_metadata TIME_CONV 1
> +check_expected_number_of_filtered_perf_record_metadata THREAD_MAP 1
> +check_expected_number_of_filtered_perf_record_metadata CPU_MAP 1
> +check_expected_number_of_filtered_perf_record_metadata FINISHED_INIT 1
>  
>  # XXX write more tests that look at the events contents, not just for the presence of a known number of them
>  
> -echo "Ok"
> -
> -rm -f $perf_data
> +check_softfail
> +if [ $? -ne 0 ] ; then
> +	test_fail
> +else
> +	test_pass
> +fi
> diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
> index a940d93..d8c6507 100755
> --- a/tests/reproducible_build.sh
> +++ b/tests/reproducible_build.sh
> @@ -4,22 +4,22 @@
>  # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
>  # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
>  
> -vmlinux=${vmlinux:-$1}
> +source test_lib.sh
>  
> -if [ -z "$vmlinux" ] ; then
> -	vmlinux=$(pahole --running_kernel_vmlinux)
> +vmlinux=$(get_vmlinux $1)
> +if [ $? -ne 0 ]; then
> +	info_log "$vmlinux"
> +	test_fail
>  fi
>  
> -if [ ! -f "$vmlinux" ] ; then
> -	echo "$vmlinux file not available, please specify another"
> -	exit 2
> -fi
> +outdir=$(make_tmpdir)
>  
> -outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
> +# Comment this out to save test data.
> +trap cleanup EXIT
>  
> -echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
> +title_log "Parallel reproducible DWARF Loading/Serial BTF encoding."
>  
> -test -n "$VERBOSE" && printf "\nserial encoding...\n"
> +verbose_log "Begin serial encoding..."
>  
>  # This will make pahole and pfunct to skip rust CUs
>  export PAHOLE_LANG_EXCLUDE=rust
> @@ -30,37 +30,32 @@ bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinu
>  nr_proc=$(getconf _NPROCESSORS_ONLN)
>  
>  for threads in $(seq $nr_proc) ; do
> -	test -n "$VERBOSE" && echo $threads threads encoding
> +	verbose_log "$threads threads encoding"
>  	pahole -j$threads --btf_features=default,reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
>  	pahole=$!
>  	# HACK: Wait a bit for pahole to start its threads
> -	sleep 0.3s
> +	sleep 1s
>  	# PID part to remove ps output headers
>  	nr_threads_started=$(ps -L -C pahole | grep -v PID | wc -l)
> -        ((nr_threads_started -= 1)) # main thread doesn't count, it waits to join
> +		((nr_threads_started -= 1)) # main thread doesn't count, it waits to join
>  
>  	if [ $threads != $nr_threads_started ] ; then
> -		echo "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
> -		exit 1;
> +		error_log "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
> +		test_fail
>  	fi
>  
>  	# ps -L -C pahole | grep -v PID | nl
> -	test -n "$VERBOSE" && echo $nr_threads_started threads started
> +	verbose_log "$nr_threads_started threads started"
>  	wait $pahole
>  	rm -f $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
>  	bpftool btf dump file $outdir/vmlinux.btf.parallel.reproducible > $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
> -	test -n "$VERBOSE" && echo "diff from serial encoding:"
> +	verbose_log "diff from serial encoding:"
>  	diff -u $outdir/bpftool.output.vmlinux.btf.serial $outdir/bpftool.output.vmlinux.btf.parallel.reproducible > $outdir/diff
>  	if [ -s $outdir/diff ] ; then
> -		echo "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
> -		exit 1
> +		error_log "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
> +		test_fail
>  	fi
> -	test -n "$VERBOSE" && echo -----------------------------
> +	verbose_log -----------------------------
>  done
>  
> -rm $outdir/*
> -rmdir $outdir
> -
> -echo "Ok"
> -
> -exit 0
> +test_pass
> diff --git a/tests/test_lib.sh b/tests/test_lib.sh
> new file mode 100755
> index 0000000..3c84d6e
> --- /dev/null
> +++ b/tests/test_lib.sh
> @@ -0,0 +1,161 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2026, Oracle and/or its affiliates.
> +#
> +# Common helper functions for the testsuite.
> +#
> +
> +if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
> +	echo "This script is meant to be sourced. Please use 'source test_lib.sh'."
> +	exit 1
> +fi
> +
> +check_color_support()
> +{
> +	if [ ! -z "$RED" ] ; then
> +		return 0
> +	else
> +		if tput colors >/dev/null 2>&1; then
> +			num_colors=$(tput colors)
> +			if [ $num_colors -gt 0 ]; then
> +				RED='\033[0;31m'
> +				GREEN='\033[0;32m'
> +				YELLOW='\033[0;33m'
> +				NC='\033[0m'
> +			else
> +				RED=''
> +				GREEN=''
> +				YELLOW=''
> +				NC=''
> +			fi
> +		else
> +			RED=''
> +			GREEN=''
> +			YELLOW=''
> +			NC=''
> +		fi
> +	fi
> +	return 0
> +}
> +
> +get_vmlinux()
> +{
> +	check_color_support
> +	vmlinux=${vmlinux:-$1}
> +
> +	if [ -z "$vmlinux" ] ; then
> +		vmlinux=$(pahole --running_kernel_vmlinux)
> +		if [ -z "$vmlinux" ] ; then
> +			echo -e "${RED}Please specify a vmlinux file to operate on${NC}"
> +			exit 2
> +		fi
> +	fi
> +
> +	if [ ! -f "$vmlinux" ] ; then
> +		echo "${RED}$vmlinux file not available, please specify another${NC}"
> +		exit 2
> +	fi
> +
> +	echo $vmlinux
> +	return 0
> +}
> +
> +make_tmpdir()
> +{
> +	outdir=$(mktemp -d /tmp/$0.XXXXXX)
> +	echo $outdir
> +	return 0
> +}
> +
> +make_tmpobj()
> +{
> +	outobj=$(mktemp $outdir/$0.obj.XXXXXX.o)
> +	echo $outobj
> +	return 0
> +}
> +
> +make_tmpsrc()
> +{
> +	outsrc=$(mktemp $outdir/$0.src.XXXXXX.c)
> +	echo $outsrc
> +	return 0
> +}
> +
> +make_tmpfile()
> +{
> +	outfile=$(mktemp $outdir/$0.data.XXXXXX)
> +	echo $outfile
> +	return 0
> +}
> +
> +info_log()
> +{
> +	printf "   "
> +	echo $1
> +}
> +
> +title_log()
> +{
> +	check_color_support
> +	echo -e "${YELLOW}$1${NC}"
> +}
> +
> +verbose_log()
> +{
> +	if [[ -n "$VERBOSE" ]]; then
> +		printf "   "
> +		echo $1
> +	fi
> +}
> +
> +error_log()
> +{
> +	check_color_support
> +	echo -e "${RED}$1${NC}"
> +}
> +
> +test_softfail()
> +{
> +	if [ -z "$softfail_count" ] ; then
> +		softfail_count=1
> +	else
> +		((softfail_count++))
> +	fi
> +}
> +
> +test_fail()
> +{
> +	trap - EXIT
> +	check_color_support
> +	echo -e "${RED}Test $0 failed${NC}"
> +	if [[ -d "$outdir" ]]; then
> +		echo -e "${RED}Test data is in $outdir${NC}"
> +	fi
> +	exit 1
> +}
> +
> +check_softfail()
> +{
> +	check_color_support
> +	if [ ! -z "$softfail_count" ] ; then
> +		echo -e "${RED}Soft failures: $softfail_count${NC}"
> +		return 1
> +	else
> +		return 0
> +	fi
> +}
> +
> +test_pass()
> +{
> +	check_color_support
> +	echo -e "${GREEN}Test $0 passed${NC}"
> +	exit 0
> +}
> +
> +cleanup()
> +{
> +	rm ${outdir}/*
> +	rmdir $outdir
> +	return 0
> +}
> diff --git a/tests/tests b/tests/tests
> index 11921ad..b37c823 100755
> --- a/tests/tests
> +++ b/tests/tests
> @@ -8,19 +8,22 @@ cd $tests_dir
>  let status=0
>  let nr=1
>  for test in *.sh ; do
> -	printf "%3d: " $nr
> -	./$test
> -	case $? in
> -	0)
> -		;;
> -	2)
> -		echo "skipping..."
> -		;;
> -	*)
> -		status=1
> -		;;
> -	esac
> -	let nr+=1
> +	if [ $test != "test_lib.sh" ]; then
> +		printf "%d: $test\n" $nr
> +		./$test $1
> +		case $? in
> +		0)
> +			;;
> +		2)
> +			echo "skipping..."
> +			;;
> +		*)
> +			status=1
> +			;;
> +		esac
> +		let nr+=1
> +		echo "---"
> +	fi
>  done
>  
>  cd -

