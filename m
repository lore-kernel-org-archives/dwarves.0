Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C55188010
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570324; cv=fail; b=HBk5LMp17NppiGBoemBAEP5TNDV19OPzwhyGTGrdyiztvrioG/LGfR+yCz8O/cBLOMjN5C6HmM3XSI7FKEt3H0AIxm2ii+gQkefS4VQSTUlfzvVa7Xw9eIIIBfiRAi9ulAG+ZmnrwwpD+g7URY5fRA0CYcK67hulsxQZf3qnCdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570324; c=relaxed/simple;
	bh=iQC6zYWf+0b4JpcovqWB0sqzX1J7HBBY+UcvYcGacs4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gfhzE478UunBQfFkPulOBc/Djwe/fea4h/equzqMFYCKHxxqt+bf2gcTUmClDG+psB7lr69pW2R52xX4A8YOclVlMqkC364ffooKx0xON/sOjkobXZ+fY9SO5FEMAzIi6vw3wh4AS7oPqwPd9lwZJqKBPfYI64v5sDX7BohmUxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B/vRL6jn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i1vd5at1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B/vRL6jn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i1vd5at1"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHXXSX000714;
	Mon, 25 Nov 2024 21:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=a7/4UbrfnQIbZtcPQGgXhiN9YZUcmduB2Z5n0XMFvXg=; b=
	B/vRL6jngoGy/SPYdxyiL38VIKQZ5BQWqIoDe0x3qIjmuwLxhR1a98HtPkj4qi9O
	jm921670PyBRdBfa0yYLN142Q6DeClGaYRX2ofu1o6bCXktivd4i0q67ussoX3WS
	ATD1zlv8V49FOaC6JK4lawgVXMYCWGg6QKyHVqs7aBsAjw/beCovZLnPZsZX6VDO
	8PwNEMGTWnxp6teVDY7ApXycYj5JgjgI4C5JkE4M7nsUczU45Ryr7G7vqpdbG6Uu
	zJzGX9ewJqY9xIzV54W9uJDx5OIrqBOT6xq8M00ZKvvI7kAkY/Mlj6YTgfdQyJxf
	50ekxkwGNfaOnz55eB+fMw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384av666-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 21:31:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APLSWLF019306;
	Mon, 25 Nov 2024 21:31:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335gek5bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 21:31:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFhF5Ztbq6IXscpoXMNomxSfIONjbZoMysmq0rnvq6yuBqNKI8d5zFoABNt1Z1a1jld4vVMf6yF6j0otbFaF9vhMuce73hMaD2TOf/7I4v9tg+H8RW58AK2COByU+VL2pb9vIgpOwvQlqoGVVgolvDsKHbHtys8uBL7d8XjwtTGlsK3gKtg9jyvijGnk7Xh0cUub4N3knoQ+39N9zXnBfEaD2wb79OR5wujwMOAUHgeYeXj4X7TkelYh9aY+nJn3VZSFUZ71F8YH9zOXta07g/swsfFFKGV1cxMe0yvSgGjjcVDZejgs7T6+ZjbWxR4cZxJ5ugXM9TmaBqE27ZSF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7/4UbrfnQIbZtcPQGgXhiN9YZUcmduB2Z5n0XMFvXg=;
 b=jWez+1+IwamqxaUHFT5qaphJBsIDljnjCMEoIvAj8WYdHhS6mi596ffFcommNYYWHeZ1J8HsNIPry7Q5+043g0t8tG/5pf1hfAnn9dRtFgv/h+Ux+ZD/uBlLtBwoXYNeTprE/x1Y04U9exoU6obUKBHU/WpV81d+3yw3GbdSNEC1vY8QCmkE/ZDVjtDX99VZCm9NXQnwxAqAQ9uc3h7dw8LOKlxiURBmFeR9zA/1ZteKqaF/QEXomsszoH+AqBAxVzYC/0SBVgoHf+Srkk5/EeH9NCmQzLBlnO1C+/fgv7K7r93QzbTScVIzVC7kmCHwYgQr4Q5gVpfD04EgOupmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7/4UbrfnQIbZtcPQGgXhiN9YZUcmduB2Z5n0XMFvXg=;
 b=i1vd5at1yhyzYyqJI9xvivZGz+gkOErhv6VINFCb3Rh2ht+1VE64sQlSyT65tE+awXC+XHz5YwqZZWnXHFC5oGJ9h3PzISofIbkiEzQpi5KtZ0yfxRJhAg0rXUCzeQbkKf/YCRikZu5UUbXXEETMNNPEo+t7p20SdOxHG6dYD64=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB4851.namprd10.prod.outlook.com (2603:10b6:208:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 21:31:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 21:31:41 +0000
Message-ID: <3e7a5089-f483-45e8-b53d-e2d3bb719835@oracle.com>
Date: Mon, 25 Nov 2024 21:31:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3] Respect CMAKE_INSTALL_LIBDIR
To: Ben Olson <matthew.olson@intel.com>, dwarves@vger.kernel.org
Cc: acme@kernel.org, brandon.kammerdiener@intel.com
References: <Z0TefTqE9Xqx0Gz0@bolson-desk>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z0TefTqE9Xqx0Gz0@bolson-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f59a478-d42e-4600-18ab-08dd0d988d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzNveThtTG5pRElkUk5LWXV2QTZqU1E4SVNBM3VIZURmK0hCTjVWQTlualZV?=
 =?utf-8?B?M1ZBN0dHMnhwRllzdGtVVVZHRy85VDArNU9UNDR0TnlkeWJ4bHZ3UmM1YmdR?=
 =?utf-8?B?VkJxNzFDVTdzckhkQmZ2LzFFcFFYQS9uelNqU3VuSFo1djhhWUtpbHJtSjR4?=
 =?utf-8?B?dzJ0eHM0Y1Q1eTI4TDV1b2lUR0xZMlBRT01DYm83cHo5Mi9KRS8rVGgrbWpZ?=
 =?utf-8?B?S1d5aHNuZ1JhdUgyQmdka0I3RUVxb09UNmx0SzNMb29GaFl6Q2QrN01lUDM5?=
 =?utf-8?B?bS95Q29mTTBZQmx4bE4zTlgwejlvbXhLNloxcitVODU4VnkycXdOOXpYaFlk?=
 =?utf-8?B?Rk5sR2R2dGRtUURUTEtGWTQ0R25nMFJhditKVjlUSU8yQ3Fzd3lOY0FoWEZv?=
 =?utf-8?B?N05rci95ZzBCbjNPNDNzeVZBWE9uWU9OMm0xOGRFbjlpa1pHUUxNT0xYcmJ6?=
 =?utf-8?B?aDN4ajZ2dUh6MXFQSlFza1MvV0ZuMTBzSUIwdXlmUmxPNkdteHQxVFF5Tmts?=
 =?utf-8?B?cHV5SUxQMGRvZE9GZUZjb2VmV3BtMXVUcW0rTVphNDd1MXVVN3o4MnE4Y2lC?=
 =?utf-8?B?VmlGVS91S2pNbVZwTGRpOGF3dmZDemx5bHdydWU0SHhlWEFGTnBCQUlTL1Rh?=
 =?utf-8?B?dkRwWGcxdVFZdFVtWVlYTUdIUkN2UlRLN2FWWVZxS2VJWXBwKzlPM0s0ckFZ?=
 =?utf-8?B?bWQwaGI0bm9DMThuQVhCaUt1dllIcUk2dUF1L2hjMkpGNnh4VExwSzlmREt5?=
 =?utf-8?B?Vk1jMVJRR1FBZzJqWng1Ri9FUG9pQXhCd3dMcG1ybDZyZ1RJN1IyY3JEcnlh?=
 =?utf-8?B?djMyVm5JMGpzTGVCYXduTzdxNko3RFhJcnU3bjFNYjNDblpaMzhKM2V0WTVO?=
 =?utf-8?B?SzdsRFp1cDFzeE1GSC8wZDNGa1FGNFFtMVpUZEx5NW1VMll2WXZBMFhlc1ox?=
 =?utf-8?B?dHNZOU1EUlEvZUNlUHFsazV6NjVFaGdlWi9zT1lRc2lHeVd1UXpTRzNXYWhB?=
 =?utf-8?B?QlE3VVJQUEZveW01Q2VRb3Z5M1dIc0JIRE1zelZyUFlWTENiTTZTcjdtY0VN?=
 =?utf-8?B?MHVwdlNseEM1VDdkQXp2QWhkRHJyNUY4aXdqR00zUE0yRkFhUmVTUWZ2TCti?=
 =?utf-8?B?MUIrZTJWa2NBdDdYL0hYOEF1NDJwRVNaSGxndjhMSW1kSC90ZjdRY3RQWGVz?=
 =?utf-8?B?Z0xLQ3ZaT0pHRXVaTDRVMFk3WGlvRjNqZDc4b3pkK202dkl0NXhWWE9EZ0Jt?=
 =?utf-8?B?Z25jSE1CeWFFQ2ljUkZucTBYeHJFMUlIa3hQcFVzMk0xT3BTMnFwQi9HM2d6?=
 =?utf-8?B?MjQrelF6SGZYUTgweVJ5QU91T1dZVWJLME4rcnZQNEZ3Y1BBRnJUeld5RDZJ?=
 =?utf-8?B?ejhSbndYRmIybHgzWlpubnBhNm43dkVUeUE1UFVGZ3RxVU56UzkzbWVDcmlz?=
 =?utf-8?B?VjZ4YUNMN3BKbjY0YlAxdm5rdTNyb2lTbXZDWElIcWh2Zjd4ZlBNSUF0RG00?=
 =?utf-8?B?ekFSREd5NEFIMXRPOTlXNnhSb2FnODhBSXlMS3l4OVF0cmxUMzlhbmlnNHRm?=
 =?utf-8?B?SEMyZjdDTEhHR08xTXlFSjRrWE02L0dSUDkzYjE1QzVCb1pYNFh0NVpiQVRh?=
 =?utf-8?B?Sm5rS2ZpSVZvWlNLUWlycVh6SnBib2MyYVM0ckJGbjhsVGNUcHZyQy82eHZj?=
 =?utf-8?B?NXBDRVFuUjM4dnh2T0t3QThxbEdSbmRYY3dsNlc2aEFQTlpDTUxNcFUwU0pP?=
 =?utf-8?B?VzJkZkFOWFZqLzVMbWpTaHl3dmdycVpsTndqYnU4amRtM3JiUkR0eGtrQVJL?=
 =?utf-8?B?S0pPNUxWVFRteEhFdnBMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRsaU5vQkY2Y0ZlNzJUbVRuMk40Q093bGxWc1hwWjBCUnVTSjVxMFpEa3pa?=
 =?utf-8?B?eEp6YlpRVWNGR3lvUjR4bi9LT3pZSEdnbDYvQlA3UjhIWENYbXZsVU9CNGhH?=
 =?utf-8?B?di84NmdsSzZhMmxNaWE0RER5dUlwbTNFbzJvQThNUTZQY2pzVEJvZlo1RVBa?=
 =?utf-8?B?ajhFcS9XZlJnRlhzS3Y3cDVyZnhqQkp1cHVUSGJXVW1sR0hNVkE4L2ptR2Yx?=
 =?utf-8?B?MlUwMEFiUzJyRFFPV21SNnRIR09DZm1uYWZZS0Fhc3ZlemJ5QklkOUF2UzQ4?=
 =?utf-8?B?U0J4MUkrRUJ6bGZoU0FzRkhQTjB3WFJaRTNaWS9ZbVJReDdmK2xzeEJzMVZC?=
 =?utf-8?B?clBlb2t1WFhDYWt6aklmNlliaFlnS0hHQ3ZDZmhYYzM5ZmNLUFF3WVhpRlpC?=
 =?utf-8?B?YVpzcU5CcE91NDA1RU9NemNObXRKTzFJTDRpNEx0RDc2WWVpc2pBUy9NdGJk?=
 =?utf-8?B?QUJPV282MktacFBWMVdyOHBoWXhJQXpYRkFaYXdzUTNuUzFBV3B5TVQ0clIy?=
 =?utf-8?B?eW1RNzdLcEpGSEw0OTJFSG9WeUVqTzMybTNFU0JwdW5mUlk3SjdnVzJUdlhy?=
 =?utf-8?B?Yk45cjlNcHFFRWMycUlhTkRPSFdtU2VCSE10Z3BNZzhXVEliNlNJZGZEc2Vx?=
 =?utf-8?B?cHFaMnRLR1U1dWhTK1FVcHVpYnM0TDE1dTBGYmsweEEwNkU3eEpxQmFBOHB2?=
 =?utf-8?B?ZHNOaDJIcmFLRUw1RXZYeHFJM0tjN2hQaUd2TnpXSWFwZUxTdmhobzc3ZjQr?=
 =?utf-8?B?Y0lLMUQ3YVMreEMvc2JyckRjNm1pSmJUZ29XYkgyakR5cWlObE5hMWhaTHNl?=
 =?utf-8?B?YUE1N2RFVndiTWZybURhZ1hNRTE5NTQ5Z0VUNnZ2WWdrMjZGTmxEbEF2ZGQw?=
 =?utf-8?B?RGlHM0RIT0JoVHlSL1JwZHQ4aVdwL2dsWG5kVTJwRU9LWWlqUUl1TXFtREdJ?=
 =?utf-8?B?OTVDakt3NDhHVUtzaWd4VEJpQkQzRkJhOWlhRDZJZTNHekRyYzN5cTlNV0Jh?=
 =?utf-8?B?YUpNNm5rTkE2UkhKMXJxNjF6eGtTKzhCa2Z1L1ZBUDUwSnZLdjRXTjBYYVNi?=
 =?utf-8?B?ZHB5L1hVK1FyV2RMY3pQRDJVaUp0dzRWUDk4MXpPWDg0c1dqZlhMajlHY2or?=
 =?utf-8?B?MWcyNlAxN0JxMEgrbGFPZHBuZGJtcGhtamV4UmdwOGJvL3Z2UGxXZW5GUlQ1?=
 =?utf-8?B?MXdBQ3AwR21VOU5uK0ZGM3VYNk9IM011YmlBcHM4elAwbllIeUcvazZ6UVpN?=
 =?utf-8?B?bWJXcCtxS3RYUWJtVkdzaEMrdHI3TDlqc1NCWVdnZ1hYZWxrajdqNkxUd3ZO?=
 =?utf-8?B?emtDRUxpNGFMSSsyRWIzOXhsUnNpenFPZEhmM0xuZVhIZExBRW9tM1piK1oy?=
 =?utf-8?B?OHAwY0ozcUtjcmtpWjFPcTNyd3l1REM4SUN1OWdFcGl5TFJTeHB1SzFISnlC?=
 =?utf-8?B?YkR1akYvZytSTWhDb0JDMHZHbkpZUlh0NGtWVTdZNEdrZ0dMNmRKanc0aGRm?=
 =?utf-8?B?dWYvQUx5cTdjWktMZ0lva25DeUNkaUwxeUlVakppbGtuZGtrYkViek9vRmJC?=
 =?utf-8?B?RTBsM0RUdGlMdThkNlM3V0tUdVBPZDU1MWllUWVXMG1mbXY1L0xTdHowenlz?=
 =?utf-8?B?a0FqMW9sY1dvVTRHM09EUm8ySm9jZ2FGUHJoRFVONFlUazJ0amhTc2NwQ1dp?=
 =?utf-8?B?QnR3d2NSL01MUDY4bVg1b3BObE55cnR5bzBDeHFzMXVYRUk5amp0aENadE5K?=
 =?utf-8?B?NmtuQnI4MUdkdDVGMHI0SnhabXFBUXRBd3lHT3JvVDJXNzN2STVEYnVyR0pL?=
 =?utf-8?B?TGZ4cG9adHNrcWVDOGJoUGJST0VTQVZZZWFsbjIwczM2OFRuS1JtNVp2Z3h0?=
 =?utf-8?B?MFowZTIxSjNiNXZkblFDKzdyVVBDdVgzYXVzK2RKb3FaM1A1eDNtRTF4KzRy?=
 =?utf-8?B?TUlHZTlybEpnNVc0dm93NnZlckRNNllybDcrVkY4bjFJRDlqdU9xQnhKdDZY?=
 =?utf-8?B?RE9mVTV5aFFjd3hCWTFOZ2VjS0h3aVdWZ3dGN1FOaTVGSXB6MmZNL1ZCVGRB?=
 =?utf-8?B?K2xjVUMvbW1KdDJqVU1qcy9BOHcxOENoQVJQQjhKRm5QNVE2bXBVVFg5MXBw?=
 =?utf-8?B?Q0ZvUHIzcDA2dHBER3ZLaFg4dEdjYUxxOFJZencxVXdodmp0T1YrK2I4N1pu?=
 =?utf-8?Q?JnKRFi/LeYAaCEzUCm5qifY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RCUj8QT0wz8G7YoxIVMN10HAUeqLtzsoy/QoVFHskYZIU0Ed77ssPYCjDirEDUspPMMtK6+aAVt+dxfhHWZPzjprfj0QewaVziyGmbEdjNak9qNB89qumdov6io6qol10yrx+R3RdqZlo/Kzx/OZV09sii/hFuT1HrNomEC/hzgLfuJadl68O3p3CTrpFz0YlifE/LfDPUOF5D69NFV0ahML1BHbEOgNkmLI9crgtkXF+twZyAjSXaJoH2cryabPD8W2x4ZJAt2lhtq1xMooBNmBSLp3Vfs9tu3YsUVKszrvTc+0C8xzf6mwO5+4OqJLxM9PzajLgwTe9Nm8A48cMluYI56WC8buIl1ha32/Hd2xgJ7HYslNLwjJ7jCZGOWJybA+3z0UojcHtYROVjE6p7wrUkXEWIc49uGXC2wkdm+Sl869SAxEAnLBwBw12sywZtYyjxIE89sWK7M87qumQ4QKvZLpIqyLPsCcu15HUSP4TWObL7v0MW/Afgk1eKB5S+rnO7UPlTv07cyM8wXV2X9zfJBJVWUFQbePUt+h8emFx47taLe0E3hED5iSbrv6VblbdiHX6Id0+AFfRvgVpAjnb5UPdtU2t5KI54Nhkb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f59a478-d42e-4600-18ab-08dd0d988d27
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 21:31:41.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QO35Fht/GdNdvXKne8JNQLVESNABiPntk7I/g5OLTNPDae0ueW2Qe7wRTKdDG0Utuz1XhgBFYLmAXCd8SmNyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_13,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250179
X-Proofpoint-ORIG-GUID: aQfgJ6zTC3fpIaWf1lzCZvdYTPiikQiO
X-Proofpoint-GUID: aQfgJ6zTC3fpIaWf1lzCZvdYTPiikQiO

On 25/11/2024 20:30, Ben Olson wrote:
> This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
> and use either `lib` or `lib64` by default so that installations match the
> conventional placement of libraries.
> For example, it will now install `libdwarves.so` into `${PREFIX}/lib` or
> `${PREFIX}/lib64`, depending on the distribution.
> 
> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> Signed-off-by: Ben Olson <matthew.olson@intel.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>

feel free to retain reviewed-by/tested-by for small changes - I noticed
one problem below..


> ---
> 
> Changes in v3:
>   - Added additional change in README
>   
> Changes in v2:
>   - Included the proper built-in CMake module
>   - Made commit message distro-agnostic
> 
> 
>  CMakeLists.txt | 19 ++++++-------------
>  README         |  5 ++---
>  2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 8ca1bf2..1d0dadf 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -21,18 +21,9 @@ else()
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
> +# Use the standard library installation directory
> +include(GNUInstallDirs)
> +set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
>  
>  # where to look first for cmake modules,
>  # before ${CMAKE_ROOT}/Modules/ is checked
> @@ -84,7 +75,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
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
> index f9aeef7..e9f860a 100644
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

Last thing I promise! This should instead be

4. cmake ..
5. make install

i.e. we still want the cmake line, just not to include the -D__LIB=lib


>  cmake Options:
>    -DBUILD_SHARED_LIBS
> @@ -12,7 +11,7 @@ cmake Options:
>      Use -DBUILD_SHARED_LIBS=OFF while invoking cmake to create STATIC libraries
>      and link applications to it.
>  
> -    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
> +    Ex. cmake -DBUILD_SHARED_LIBS=OFF ..
>  
>    -DCMAKE_INSTALL_PREFIX
>      Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=

