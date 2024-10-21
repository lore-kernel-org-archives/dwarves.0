Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E55028C
	for <dwarves@vger.kernel.org>; Mon, 21 Oct 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533136; cv=fail; b=IlE9JDCjtndhnLrFu+N/EiRBxL/nKcwnYw86CD6WOA2/3wLl0qkBtVk5IGE4QY7ciigRSJauICI8LKHrxtIUhpmjJcHgHDM+zncpDaS4pVVv9kcnz4jm2iHWTnvfRg5PrcrkCY0MPCmIK3gE58ppjqhsjg6aMYAz+eSnKjjpaPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533136; c=relaxed/simple;
	bh=RWKFR+V6YL/eO0IwfAqhWWW5iPzNGqO6A593Y91P/Ak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=McfyT7y+cTBQUb7wzBN4n3XKKUgP1JVjPSFLJNgrrtiIZc+G8Wqz/FW0gm44ia41kKcHEP0KA9ijvX7OO03D0YMqznkiZ5CGTxi079atFFXzY9oU8jUcaDfPaaeuIx5GpB+xOAHkefr+Zc8bbat6f3yrwNW2/oBDriq2st4QXP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I/DpRtzH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vjO8dtkb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/DpRtzH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vjO8dtkb"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LHXcpI004686;
	Mon, 21 Oct 2024 17:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=s6B93325IiXwLs+fQZ9kzHnKAAic0kj3iG8/3xjubhM=; b=
	I/DpRtzHLoATHMEO2B2y6ocJl+TzwH3R+DKbKdllwwYHTIeRHmT9+ZuaeSuuH5Cu
	U+NruYpOkWuoRsEOTwgJbCIghSft6/+HhopDgmxMKwFe/Uv0FOtGvb/b3OFrbcFe
	lQTz1au+Ia/BnGe2nXRL3T4RT+G5Db5XnrEdbgYbTx6T0+Hsc2JUQMaiOVpBJjsL
	7Ql8j10mOH4MITQL/5iqrsCFqmq9Lx8axC6VxleTu8Y+fVbWSYAGpBR3hNJlj5fW
	K6nwIPsTn3RajVCJ5xbcu+GeO304oUWojfbMxW25ZmvQRps7kj8nuoXywbDgWcFc
	ZCenYG54aGw1WRRDEX99Gw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qbqu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:52:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGSqLt007665;
	Mon, 21 Oct 2024 17:51:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376nqj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiP2QLv3x5pkaIlTLutTMsgmzRx17JQhtNqdhan2NOyVdycRrFEaa5IHi+82dLIhSqwLhVCl5czIhdAQkSOETmqs2N8yYQdzmjaDmlcRNmVe8ZX7ccu5cLE8IBxGTUG6ihB+2koextIocnXQ1Fl2f07MAi1/o1P1IeEnt33CkFkaaT4Fek5161stsA/639F270SueBo8OP7m9RlTpDoelNeLtzFvRchL6NbkBV/nQm4laQei7mkjU0hdbADLIw9nNjZUSp0l2IaRc/+210XYDqUBFFm45CXwR8avwXaPICfmYZXWomqoMmJwF3d1ZGmMTFa0gEr1WzMZwuMaHHgCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6B93325IiXwLs+fQZ9kzHnKAAic0kj3iG8/3xjubhM=;
 b=mdSzl/AdnncYn5yQn+CId2ZHMKuwQOLvjbfzsPhL5jbCZfn0V7T5QKoLAKsU+3xfHsx+ULRjfIF23OnbMUTEGBHeX6Kvg/pXVbGQY6pbm1dedQCFergdleU3QVjyZO9BUspLgsE9tlXwVEj4qfh4h9X31kiivu5xhUd3j2H+kzfQjjQb+DCnlyarnGyYIpCH/5ut0Lp1s6cmd3taDlwPT7u1FAelj2rP5856vsF4yEMDbGnTXnxAeHzycmonemsuyz9B9Jsx6A5gkpIMG0PMLSksOANm9OyEK7omCM6g+8cNHBbt3EWjTR9ozwB19a31Y4YUTCkuCU7ECtPwOnDkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6B93325IiXwLs+fQZ9kzHnKAAic0kj3iG8/3xjubhM=;
 b=vjO8dtkbiBtfuGDk0EpjJ63HWGmNtNXZHZPY9MIz1O3UzB+1WEtrTgCqj8f4dHM406+uwxUS5EM+grAC+iaJgGW4+iwXYbJEKxKZmao3QwTD66BwrA7/DwYF5Tm68O2b96zVACy7TC++MYe2f7tQ1U1cHs0S4Afx4PELfpLyiUw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BY5PR10MB4225.namprd10.prod.outlook.com (2603:10b6:a03:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 17:51:51 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:51:51 +0000
Message-ID: <8678ce40-3ce2-4ece-985b-a40427386d57@oracle.com>
Date: Mon, 21 Oct 2024 18:51:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 4/5] btf_encoder: store a list of elf_function
 per function name
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, andrii@kernel.org, eddyz87@gmail.com
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
 <20241016001025.857970-5-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241016001025.857970-5-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0217.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BY5PR10MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: c50343e7-ce47-451e-2c0a-08dcf1f90ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em9ZU2NGbk9wd0tZOVpOZjF5MXdoUFc4bnhWRGo2YndFRlhDWExyTThJRjRq?=
 =?utf-8?B?N3FjMitsRFZtaVNnd0wvVmZFejFOSlkzOFhrblpXQVRoSnVGRURTakZ2OVBr?=
 =?utf-8?B?QTIxQS8vdnhsRFh4TnRZWGJsY3Z3QncwMGh5bFZ0d3pGY2NldloxR0dTeDky?=
 =?utf-8?B?VEE3WnpwZ2JLZjFJT0N1Q2JaLytKTllHRlJyWWRVeTlDc3JzWWFZWDhJRWpJ?=
 =?utf-8?B?U2ZBbTBBT1JSYWoxYnZjTzRLcjNYTGhiaUlYOTFGTUE3MkZOL2JLQTJoTDY4?=
 =?utf-8?B?T3grenZkTGpOYUZ4OVpaRzhPTWdRZzFEVUZqSjFWd2JRVHQ4T1ZST1pUQ0J1?=
 =?utf-8?B?S3l4TDl1d20zckpWNklHd1BLc0ZPYU5Hb0lKVEJyRjhnSExIQXFJT2VyM0FO?=
 =?utf-8?B?Zm9CeDhhTndmU1Q3bDR2d1QwaUU2VWZpTVU4TVVvaHRsZ3JRQUlhRzNnN0dt?=
 =?utf-8?B?dWp3Mmd5MER5TkNlUUVqUW0rS2VHYkJtOUsyQ1Y5R3NXWHRrMDFrRS9uMDlU?=
 =?utf-8?B?YjQ2eWNWSXBWeWtjVkd0Nis2UVJUV1JndGRVVUpIM052dC8xWFdFSytLOWVu?=
 =?utf-8?B?Nmt2RHlVbFh3UktVVG9rZFhjRHdJeG5iOUM4eExoVTNzaTVCUkszU0FZYXE2?=
 =?utf-8?B?MWluTnZkcUU0RzBhcUt1Wm5oMUg5b0JlV2Jycnk5WDN1ZEtnbTNwQUZZaHVo?=
 =?utf-8?B?SXNxZ0FReWErcjFlcytjczBnRU44ZnJkaVBrTmdZZlF6anRldmtpU0FZVG5E?=
 =?utf-8?B?VDF1QzNvK3RuM2RBVXhGQm9VRzlpR0szS0tBOTR0cmVTQVFodmpEQnE3ZlV3?=
 =?utf-8?B?djl0cmV4K20rRFZkQ0xXR1N2WVNTZUszNUdIaDlwRkZNSmw0VHlteThwOVAr?=
 =?utf-8?B?dldmQnJZU2E0Mml2RmhEQ0hNdFRDZGh3QVhhWmkvN1Z1MHZSNlgxcTJUa05k?=
 =?utf-8?B?UWNtUjhGa3ZZSTllMTNXSHpFWGVvanpycE96M3RjV0IweUN4Q21zeGpubG0v?=
 =?utf-8?B?dTZjSHpjSUY4ZXgwdnZKckhPY1A5OG1oUkt2aE12dndpVzdnckcxM3ZwdDhv?=
 =?utf-8?B?TUlNYkVBZzVkUHZLbkZlQzhrc1BBLzFOazdiYTV1Vm85NDhvR3o1aVZ6cmVi?=
 =?utf-8?B?cHV4R3QrbUlCS3UyN2VZeHk5cWcvSVM0QnBGcUFTalVRYVA5UUlOWG1BbEtX?=
 =?utf-8?B?UCt1VWxGNnh2ZEplZEI0VlJSTVh1c28raE01a2FwOUhTTkdBdGllRXBwSnM5?=
 =?utf-8?B?S1hLcDBROXVybC9CMUdWaHRub0ppZjFIRG4xaWpLZ2xxeXBJUkg2Sjk3NS9I?=
 =?utf-8?B?eXVDRVJOR3V0YmoyUHR0YVJGOHI2cytnUVRreTc1SnpYTmhySVpnY2thdmxF?=
 =?utf-8?B?R2lRVXVoSStHYU1DaG5jR1VTSEJYVzkzb2xMSlBoKzQxZmtoMUVRdkRDU3dp?=
 =?utf-8?B?SnlOaG5uWkVLNWltckgvb3d3YXB3VEhlZk5TaDFTUERXeE1STnpuR3MxNmVD?=
 =?utf-8?B?cDdsTmxxNnhkT0Exa0ZLa3dDVERFdGh2NFB1NUJjNHNxOEU5ckJ6VXdyWXo4?=
 =?utf-8?B?eHBBVS8zZzV3dUpHUWl4SXV2M3pEa2wwQmJkZlF5SjZhcko1Y20xQmZtQVl1?=
 =?utf-8?B?QTZnR3ZvYkx5bGozYk5ZSHpKbHkrSWdHd2o5aXMxYUpzSHB1WVNCR2dsTVdx?=
 =?utf-8?B?Qi9wNGRDQVJYQndzdVdRWVg4MmptSjdWczNGcmlmTkhVVWZZdnRLT1pxZ2ZG?=
 =?utf-8?Q?202nf8KklA1IsN0kyX7cnfTxopzingWQI9lG5Ll?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTl0cjR3WXIzTlNKSC9xS2orLzFvM3poK1pUSTVwSGFGcG9TL285QU1uR0xp?=
 =?utf-8?B?cUZ1cUoyTWtkZDA2QXlUbkQ5SzZrTXliQmdPY0hEb3VEMEVTbGJURjI0aE82?=
 =?utf-8?B?MkFBN0UwalZucWRRdW5EeDY2MnAvSlArTjhRa0cxTUpDc1RyeWJ6eG5tTWhQ?=
 =?utf-8?B?Mm8xcE1IeXdUdCs1My95VEZ1SStWbUtxUy90cHRqRU9QTEdtZUhXZFRyZUlU?=
 =?utf-8?B?cTRNRmR5SlFCRWtpTHJrVDRQbC96Qk5IUjNIUVdQRlJET1NVSkx6SzJQeXRE?=
 =?utf-8?B?b0J2c1g3cmtrZFlLZFZzZmJVSWtXU0o5N2ZOeThERmRHczRnRVFHNkZhOVhj?=
 =?utf-8?B?Y0cwWE13dGhDU1ZiRGNwcGw2Skl5NGlrbW1kenIzdndERDIxN29XK3BzNlNh?=
 =?utf-8?B?RmR5T0hjSHl3cSs0cERDTUdwbWlya09FaWhMeFpQOUM3SE5SSzlqT3A5VEhZ?=
 =?utf-8?B?ZlM1L3NzQ1ZSTUtjQmRtWGE2bEoybUlBNTJ3WnYrWU14U1Y3ZXRxR2xLSWla?=
 =?utf-8?B?YW5qbWRCcHMwTkNMZGc1QU83aXhKM2czekM3NFUzQkF1M2ZPQ1lXUzVKTTh0?=
 =?utf-8?B?c0hHeGdBY3FiTmkzWDNlelNQUWlvbmp3SFFhNXVvb2xYNHQvSkxsMmNVMldL?=
 =?utf-8?B?OW53MklPQlkzMW00ZDk5dm8xZTVJY1RqODVSa1B4N2o5RWZ0cHkzdWJJYXly?=
 =?utf-8?B?ZGJBaWF6S1F3bTA5TmhySllsUW5nUkZraHpSUjhQS2s0SFNGZnJhV0owd1Jv?=
 =?utf-8?B?L0xFTnRHTTlJajlFL2hjcGhHd29XaVlxOHJxMU1kYmpualZvOWR1aTc4Nml4?=
 =?utf-8?B?NVBFRGFUNDVBa0d1cjNQV0FKb2FnT2xKdy9sNVI1T1I5b2t1NTN4UXJqS0hK?=
 =?utf-8?B?T1ZrZk9tMWxSMmVPY1V5cmtkYUc1ZmxHSkhFR2g3eWNtWEFXRDhwTVNZdDRH?=
 =?utf-8?B?NS9CeGlFVXJnOHhVbk1PWnBqM0Vyb2QyTTFhYTJQRXd6R083K25uQW5uOExz?=
 =?utf-8?B?Q0ZEOUdCbCt5SkFsYkxPWDNYZjBvMEh5WlBBOVQ4NE9FUkN5RHY1OW9ySEl2?=
 =?utf-8?B?WVZZdThWZ1ZTT1AyVk9abWZlYk5XOGxGeVI0YWJMT3JucHJES0FENUNiYmxk?=
 =?utf-8?B?UkRXMWY0cFBMTTJHOVM1d0tkY2hiL1FyQ3lFcHFjbUFVVVZlTlNzQlpLcEJP?=
 =?utf-8?B?MWgwV0RnYU1jbDkySUhkbDE5N1o4TUs3R3F6dWhzYXVORDF5WUUwNkxVUWZN?=
 =?utf-8?B?bjNJQUxFOHhrQnUzSy92dnFleTNDUS9QcUE3MzBVclVCcDBWbm9ackZyUVoy?=
 =?utf-8?B?UzFtSU5OU0lMRktrR2NQVE9qVThYNGEyMnI1KzdGVDJKRnlsa3ltazVaOHlj?=
 =?utf-8?B?ZkhKMmtrYjJQL1d1dmtScnJpdjNZdS9ZTGE5cXk0T0s0UmxwNHJHUnpRbVF1?=
 =?utf-8?B?SlBxeHRtVzNHV01hZEJEeCtDblF6c2pCV0cyRFI0U0NjNnpzYUVuNHRsVktZ?=
 =?utf-8?B?RGRGQTNxQzV1c3Jremk2bTltUUFmS2NCRHZHbTAzcGVEVncrWCtxNXZxaU95?=
 =?utf-8?B?NWg1TEVXbVBkT3JqMDI5Nnlua3QrVmtJQnZNeVl4NDJiMDJrQ2FzVUN3S1dD?=
 =?utf-8?B?TktacG05K3BodmtSNEEvVUtsaStLUVFoSXY3L1B4RFF6bFVkQVpUQmF4UUpZ?=
 =?utf-8?B?VFJjSDN2cnZKTVVXdDZCQWJidU4xZUpYQlRpV3NoVWN2ZStNdjBxbnBTakd1?=
 =?utf-8?B?c0JiTEJvMDVRY2dvNVJjdDByeG1iMlY1SFNwSXhYQXhVcWpzTFdmaGpMS0Rx?=
 =?utf-8?B?amMxVndWbng1dkd4d1JGbWJCZGY2NVUrM2twWGpmRjhkR0I0MTBCcE02T0No?=
 =?utf-8?B?ZlFmYnMweG1saW9vOHJ6UDlpeVMyaW9tdERGRGMvT3pnVDVDb05RY01QZHcr?=
 =?utf-8?B?eFJSaUFQWjd5VHh6SGNySEwzeTFqWXR6b3JHV0hKNjhaZUpsSkp2UzBXSXRR?=
 =?utf-8?B?T0JHaHJvK1F2ZEd2dkszY1g4UURZM3BObmdEeTdqamJPZnRHbEhLdlhIUk50?=
 =?utf-8?B?SWZ0c2hMdTlBMW8xSUdtZDc5RytuMWVCRmlSZnRraExnTnZDZGhZbUh5aVM2?=
 =?utf-8?B?bjJuY0J3RGQzbUtSWkxGY0tPTkFXRjU5RFZscUlPQVVpM2lTdFQrNmhPMUNZ?=
 =?utf-8?Q?fT73bt44E3pnqSrRS+PPawg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7kPYXx/7CzikKKRCII3pfjdY66KHIkvM3fEmcWavrW2GPRMHqTnVJpbvX2pa5/yBM8bAPJdf3qrVQBBVNCMJ8PWM8StpIrR/MFMqJwWtfrgm5FZcWe+e9z2rlQ37/kcLKw801pKoTSMklRIPEMESnuV930JPN+Vovk9GtUv56i5j8zdgRs4f+XR8ycLED6YPlP2WXu3MW+lX2NgFIpWp7u3VlnzaVJNIgw38ZGBhXHp7wFol8Ism0mbkT8Qiyo2BE6vt2Q62nh2zzAzB1RqD66Lawon54EZ1Flcr5SIDq7bqn4hJhgHygu1dBVwnBN3/sMwZUcIg3UX36qEGSh83tsKdY8F6hXMZZlka0u3PwJJ3Pgzodf6876sjUUyLAEjz4zKqznrJIkcpMmQfXSIawAsU8KUEs66IZPPTiJApDrQW7Kkh5cuf8pg9LaD9rTkB1DH0svYbcCh/gSdQxgt7W7ss5ey6uui3+sCVaoo5n/NSPdmEGfDiI+pPYnM6sz2hSMWOxRwG3BJvKbt1rZ67ZVmzIrVroiDM3I/LwYCkGp+KGCqlXF8kfQ63Ln6Ls/eS5vjS7T9sFpRoDZlIJK9E13Yb1abhpZMQs5bmAb+YL1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50343e7-ce47-451e-2c0a-08dcf1f90ae3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:51:51.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHP0pg+fFhMJVNY7wqGST3pMMXDlFyFT8gTZ8URmXPZPCUPJOFQJdmLcMNzKU/c8LGqPq8jCgArkNYQgWxkCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_16,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210128
X-Proofpoint-ORIG-GUID: 2_YavkMtOsvJSyjYPiCxCHsw2OHBqaDK
X-Proofpoint-GUID: 2_YavkMtOsvJSyjYPiCxCHsw2OHBqaDK

hi Ihor

On 16/10/2024 01:10, Ihor Solodrai wrote:
> btf_encoder__save_func() accumulates observations of DWARF functions,
> maintaining an elf_function per function name.
> 

I've been struggling with the latter few patches in this series, and I
think that's in part due to the fact that you have to deal with some
(what I _think_ are) unnecessary complications in the existing code.

It should be easier to share ELF representations, but the situation
you've inherited is we mix immutable (ELF representation) and mutable
(function state information saved) representations, leading to
complications that require synchronization across threads.

Stepping back, I think with a few simplifications, we can lay a better
foundation for your work, and BTF encoding in general. Specifically if we

- always save and later add functions; currently we only save if we want
  to avoid inconsistencies, but this means having to maintain two
  codepaths for function addition which is messy. It is simpler to
  always save and later see if we want to add functions.
- fully separate ELF representation (immutable) from saved function
  represention (mutable). this will enable ELF sharing, and saved
  functions state can simply point back at the appropriate ELF function
- For each encoder, we just save all function state representations in a
  simple list; no merging is done at this point
- when adding saved functions, we combine lists from all encoders, merge
  findings on inconsistent representations where required, and add all
  functions without inconsistent representations.

This will mean no concurrency issues, and we end up with a simpler
representation which I think should make ELF sharing much easier. I've
got a rough prototype of 3 prerequisite patches doing the above at
https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:elf-prep

The changes are contained in the last 3 patches there if you want to
take a look.

> Part of this routine is a funcs_match() call, which requires access to
> BTF implicitly referenced by btf_encoder_func_state.  In case when
> elf_functions table is maintained by each btf_encoder this is not an
> issue, because every btf_encoder_func_state available to this encoder
> can only reference its own BTF. However if elf_functions table becomes
> shared then existing elf_function/btf_encoder_function_state structs
> can be produced by other encoders referring to their own BTFs. In this
> case funcs_match() can not be called unless BTFs are available and
> writes to them are synchronized in some manner (which is not
> desirable).
> 
> Accumulated states are later merged between encoders in
> btf_encoder__add_saved_funcs(). To enable sharing of the elf_functions
> table between encoders, two members are introduced to struct
> elf_function:
>   - elf_function *next - to enable linked-list
>   - btf_encoder *encoder - to find elf_function corresponding to a
>     particular encoder in a list
> 
> Each element of elf_functions->entries is a head of a list that stores
> elf_function structs, one for each encoder that searched for this
> function name at least once.
> 
> btf_encoder__find_function() is modified to perform the search on
> shared elf_functions table, and atomically update a corresponding list
> as necessary.
> 
> At this point each btf_encoder is still maintaining it's own
> elf_functions table, but the updated implementation is used.
> 
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  btf_encoder.c | 122 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 96 insertions(+), 26 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 8e8fd05..002358c 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -30,6 +30,7 @@
>  
>  #include <assert.h>
>  #include <errno.h>
> +#include <stdatomic.h>
>  #include <stdint.h>
>  #include <search.h> /* for tsearch(), tfind() and tdestroy() */
>  #include <pthread.h>
> @@ -86,10 +87,15 @@ struct btf_encoder_func_state {
>  };
>  
>  struct elf_function {
> +	/* bsearch key */
>  	const char	*name;
> -	char		*alias;
> -	bool		 generated;
> -	size_t		prefixlen;
> +	size_t		 prefixlen;
> +	/* for list search */
> +	_Atomic(struct elf_function *) next;
> +	_Atomic(struct btf_encoder *) encoder;
> +	/* encoder-specific state */
> +	char *alias;
> +	bool generated;
>  	struct btf_encoder_func_state state;
>  };
>  
> @@ -106,7 +112,7 @@ struct elf_functions {
>  	struct list_head node; /* for elf_functions_list */
>  	Elf *elf; /* source ELF */
>  	struct elf_symtab *symtab;
> -	struct elf_function *entries;
> +	struct elf_function *entries; /* an array, each element is a head of a list */
>  	int cnt;
>  	int suffix_cnt; /* number of .isra, .part etc */
>  };
> @@ -157,10 +163,29 @@ struct btf_kfunc_set_range {
>   */
>  static LIST_HEAD(elf_functions_list);
>  
> -static inline void elf_functions__delete(struct elf_functions *funcs)
> +static void __elf_functions__delete(struct elf_functions *funcs)
>  {
> +	struct elf_function *func, *next;
> +
> +	for (int i = 0; i < funcs->cnt; i++) {
> +		/* free all list elements except the head */
> +		func = funcs->entries[i].next;
> +		while (func) {
> +			next = func->next;
> +			free(func->alias);
> +			zfree(&func->state.annots);
> +			zfree(&func->state.parms);
> +			free(func);
> +			func = next;
> +		}
> +	}
>  	free(funcs->entries);
>  	elf_symtab__delete(funcs->symtab);
> +}
> +
> +static inline void elf_functions__delete(struct elf_functions *funcs)
> +{
> +	__elf_functions__delete(funcs);
>  	list_del(&funcs->node);
>  	free(funcs);
>  }
> @@ -1296,12 +1321,30 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
>  	return 0;
>  }
>  
> +#define for_each_elf_function(func, head) \
> +	for (struct elf_function *func = head; func; func = func->next)
> +
> +static inline struct elf_function *find_elf_function(struct elf_function *list_head,
> +						     const struct btf_encoder *encoder)
> +{
> +	for_each_elf_function(f, list_head) {
> +		if (f->encoder == encoder)
> +			return f;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
>  {
>  	int i;
>  
>  	for (i = 0; i < encoder->functions.cnt; i++) {
> -		struct elf_function *func = &encoder->functions.entries[i];
> +		struct elf_function *func = find_elf_function(&encoder->functions.entries[i], encoder);
> +
> +		if (!func)
> +			continue;
> +
>  		struct btf_encoder_func_state *state = &func->state;
>  		struct btf_encoder *other_encoder = NULL;
>  
> @@ -1315,11 +1358,11 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
>  			struct elf_function *other_func;
>  			struct btf_encoder_func_state *other_state;
>  			uint8_t optimized, unexpected, inconsistent;
> +			other_func = find_elf_function(&other_encoder->functions.entries[i], other_encoder);
>  
> -			if (other_encoder == encoder)
> +			if (other_encoder == encoder || !other_func)
>  				continue;
>  
> -			other_func = &other_encoder->functions.entries[i];
>  			other_state = &other_func->state;
>  			if (!other_state->initialized)
>  				continue;
> @@ -1389,12 +1432,53 @@ static int elf_functions__collect_function(struct elf_functions *functions, GElf
>  	return 0;
>  }
>  
> -static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
> -						       const char *name, size_t prefixlen)
> +static struct elf_function *btf_encoder__find_function(struct btf_encoder *encoder,
> +						       const char *name,
> +						       size_t prefixlen)
>  {
>  	struct elf_function key = { .name = name, .prefixlen = prefixlen };
> +	struct elf_function *func, *head, *tmp;
> +
> +	head = bsearch(&key,
> +		       encoder->functions.entries,
> +		       encoder->functions.cnt,
> +		       sizeof(key),
> +		       functions_cmp);
> +
> +	/* If head is NULL, then there was no such function name in Elf */
> +	if (!head)
> +		return NULL;
>  
> -	return bsearch(&key, encoder->functions.entries, encoder->functions.cnt, sizeof(key), functions_cmp);
> +	/* If head->encoder is NULL, then calling btf_encoder is the
> +	 * first one to encounter this function name.  In this case
> +	 * try to claim the head.
> +	 */
> +	tmp = NULL;
> +	if (atomic_compare_exchange_strong(&head->encoder, &tmp, encoder))
> +		return head;
> +
> +	/* If the head is already claimed (or if current claim attempt
> +	 * failed), search through the list, and add new elf_function
> +	 * for this encoder if not found.
> +	 */
> +	func = find_elf_function(head, encoder);
> +	if (!func) {
> +		func = zalloc(sizeof(*func));
> +		func->name = head->name;
> +		func->prefixlen = head->prefixlen;
> +		/* Whenever btf_encoder allocates a new elf_function, it sets
> +		 * itself as its encoder. So if the first search through the list
> +		 * didn't find an elf_function, we can be sure no other
> +		 * encoder would add it.  Therefore we only have to ensure
> +		 * that the head->next is updated atomically.
> +		 */
> +		func->encoder = encoder;
> +		do {
> +			func->next = head->next;
> +		} while (!atomic_compare_exchange_weak(&head->next, &func->next, func));
> +	}
> +
> +	return func;
>  }
>  
>  static bool btf_name_char_ok(char c, bool first)
> @@ -2506,18 +2590,9 @@ out_delete:
>  	return NULL;
>  }
>  
> -void btf_encoder__delete_func(struct elf_function *func)
> -{
> -	free(func->alias);
> -	zfree(&func->state.annots);
> -	zfree(&func->state.parms);
> -}
> -
>  void btf_encoder__delete(struct btf_encoder *encoder)
>  {
> -	int i;
>  	size_t shndx;
> -
>  	if (encoder == NULL)
>  		return;
>  
> @@ -2528,13 +2603,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	zfree(&encoder->source_filename);
>  	btf__free(encoder->btf);
>  	encoder->btf = NULL;
> -	elf_symtab__delete(encoder->symtab);
>  
> -	for (i = 0; i < encoder->functions.cnt; i++)
> -		btf_encoder__delete_func(&encoder->functions.entries[i]);
> -	encoder->functions.cnt = 0;
> -	free(encoder->functions.entries);
> -	encoder->functions.entries = NULL;
> +	__elf_functions__delete(&encoder->functions);
>  
>  	free(encoder);
>  }

