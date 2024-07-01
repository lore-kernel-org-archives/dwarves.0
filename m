Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842616DC15
	for <dwarves@vger.kernel.org>; Mon,  1 Jul 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852278; cv=fail; b=LAd/DrwiqJ/6hDBgeUuQ5S6FonUsjjIsU9PC3kbtXu+KzwTHX9s0bRXwmE2LE8NSNAAi/NeqPGt6RMHXIN36GuDRtenssXVnslcjbVxHh9kDTJ941fYE3wehZa5f3ikUoWV9UWgmKaYzQEufxj/llulthuknYQ8Bw9HfteMXtBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852278; c=relaxed/simple;
	bh=ySH3fYnJ9csItcbT8WhKgFZg9bo8cgQzE1X3YMNvrig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eCXRvvZbQ/dikth+w1Evj/bzuDmhR8N2FDiF2nEHUy0ogXgXImAHovQicaGiiN8tDJJH2BQwyQ++zrWlsGjW0dvHZBt/ppGm2jt1HfLoPMmYbXm3Z4/VwB2IWnoJbCUdO0YXdibYim1N6U99tziXHGXLAvqb8d1pRvgo860zBnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rne8B+GK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BeL3yN4P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rne8B+GK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BeL3yN4P"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461FvfaD003747;
	Mon, 1 Jul 2024 16:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=FoHCF9d8LqJKvDzR4p/tDUvCERQUEz5zIZXC5einBN0=; b=
	Rne8B+GKNnX9j2KUi7sPbDyitdm2aNwamTmdMcv9mzP4lExSOTyCtRm+GL1uMcYb
	U2XATTFJ2GJPLwcnW1BWlKbZximZM50JICFce6umoSAp4YS9xrXZJMM7YLRNLrPR
	FPc5A1Rwg2Hwl6OqPAFawhyJX1a5CelJivbVeOEIHbQYt9G0zNQtBjtgoSTIMJ96
	nt+UEDI+j2M2YSp8xFnZRJoNAYorNKnzs0kqh3d6KcA/MVFo/nuPwKn0jaJMHiLt
	jpTGwB+duMj2m+M6l34WsPGi4Rrz+Ntc3QStRP7Jo4Br7+a60uq3WeKpkyCnXR3a
	z09NsPyxPXnUQDR/qmnTGQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a593yrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 16:44:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 461Ff4tH009913;
	Mon, 1 Jul 2024 16:44:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q6sa7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 16:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN0AHC2EpXuMi+jawwkkucU+RxUJ1PChKR/cJGhB29KRlC2CnHYFtc8fwgQ/KKUCstfBKPgit6VL54cQb1yC5Nb+w9eBRWPAFlnfHPpT6Zw0ImpxeeF4AxmkMECQIBeWvRTvkv6obKPG2gqTX/i7SOeN6Yq6yoy/JztHjdcyMlQn34jF064GZIQ5zZ30zZF6rzvkSYu21PUBNe/ZIEGY8sHGP/GNezrZGq6yYGXJE8Wwk0HCXci+fO1GTQ5eZkRGtTPHHFI0nfSDEAg+KwpygcQKvsZMmXuXfQiekuVtsHKFih2DqRxXbYVgO29L3m/DJFRwWgzhSaf2hnfvVJKp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoHCF9d8LqJKvDzR4p/tDUvCERQUEz5zIZXC5einBN0=;
 b=mMUaD8n5b5F5xeY0aBEwxQcJ91+pyqzg/0klwkGwbxdfykrPop4Bulo3KRfnZVlwNo0bKemARhCuGuhfLF5zWtA4ze+mflmnHDTJ7kaRA5+aetRe4YHh75DG1xgKHpr4s63sqgED7a5jfgJAYNLZn3SUrclfQjIcj0VxqGsXmS5rBWaOMgmkFH5moHI2eiz6XexPIbAeY65V/txn2HmSGCeZ2DrrLCroDDhSonEwIJFltg0lAZ/0HKwfz9XLQqkKHf9hw0u635uC51A+rHrLRU7D1kjS9j8hlDKsREgBcyFZOHsBEKs7adJGoTrHkEvjujG/L+pt7qHNfRZYkoCqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoHCF9d8LqJKvDzR4p/tDUvCERQUEz5zIZXC5einBN0=;
 b=BeL3yN4PwTtaY5lHVnxWDUlvloVnJ0pSGIxRLmortSCKDFypgqjFF3ne+rfiRl8Ja0wV5y3jPuJrtdZmc1uKyk0Q5YFGG0NFgSDKZvkrF7cxNhI4mW7YqiKa/BeerK9j7BjqOL7WyBw4H652ISQTuvHzKxD4xZkpwNNFbj9mQCY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 16:44:20 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 16:44:20 +0000
Message-ID: <149bf9d7-3ac4-43d0-ae73-28f685807c68@oracle.com>
Date: Mon, 1 Jul 2024 17:44:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, dwarves@vger.kernel.org,
        jolsa@kernel.org, williams@redhat.com, kcarcia@redhat.com,
        dxu@dxuuu.xyz, eddyz87@gmail.com
References: <20240626032253.3406460-1-asmadeus@codewreck.org>
 <c1414fb5-f7a8-4cb4-9c27-9c0c9b431f28@oracle.com>
 <ZnydwHhgCbUbkm44@codewreck.org>
 <fc0bff28-eb41-401b-95d4-49fd4b72e5c7@oracle.com>
 <1213004a-c75a-4882-bd51-47d458c67e04@oracle.com>
 <Zn8SsFuSAG2qPgzC@codewreck.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zn8SsFuSAG2qPgzC@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: df2579b9-8a4c-4cd9-97fa-08dc99ed0e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aHIvU0VJQzBOZ25LNmxZRXZ2S25GMlRRZkNSM1dFUUFKTnlrMnMxZW8zT0pY?=
 =?utf-8?B?bjJFTWU0SnlmY21rWXBrS3UwdVJ4Z0V2M3dVWkxsdSt0cWpFRzQ4NDZmcitT?=
 =?utf-8?B?bEQ0R2hYQzYyNTRCd0lqUis4aTltRHRJWHFmQmNBZ2xNcmVPQ3pvREZ6eWxx?=
 =?utf-8?B?aWNMeUNiS0hoTi9HaTJ2SUo0cE5PM0IzajlXWU0rOEEyV3Y0dFB4Q0lhVnYr?=
 =?utf-8?B?QnBWUUxSWGJGbGp1QWZneVB6akExazJDTmprZUp4ZXpEeXJxbm1wdzRjYlhw?=
 =?utf-8?B?MG9CcHZKd3diMUtRSzFua0Vzalp3ZEdKa1VjQXI4ZngrZ0VNYUl1MGpndklZ?=
 =?utf-8?B?aU5PL1dCZC9pWDdGY040cm91bS9NRHdNN21aNGcyeDVuQlhFcDdKUXgyZTJR?=
 =?utf-8?B?UkVwdUswVHM1Wms1RktINkhVUFdWMXV4WUFHSFZJVEpLYnNZV2FQVHljZHIr?=
 =?utf-8?B?alJDVFlrVm9odFNUYVdSMTMveUQ4ZjAybXBwQXIyaE5xMzhXSDg3RXhVaWRT?=
 =?utf-8?B?RWRyYms5RmRJRjN0ZFNubTBhdysxMzBSQkJFS0lxU0h6dmpDWm5aRTJkVVZ5?=
 =?utf-8?B?NFJuenJndHRvYTY4ellKYWtEeTlrSXl4QWppK2ZRZ2lkMytBL0ZvelZoU1R4?=
 =?utf-8?B?UDNScmhPbWtGVlh1eVlUTGhBTGNRbHlLTDZ1M0tqZDQwRDBXL1pHdm83YmQv?=
 =?utf-8?B?TFhWVUs0U2tNMlIxZzNldW4yV1ZXMkR0L1RlTGhGSFRmZW1VNVhadmswSGE4?=
 =?utf-8?B?bmJLT1FtZnZMT28yVXVjM1gzUlB5bHcvR290STlGMkJYMXYzTHdkbEZmVFRo?=
 =?utf-8?B?T0lNSkFRUXF5N3dSeU1JTnFqMnZ6YWdyOXdSN1RVL2hDczhqWlR0TzI1eFcv?=
 =?utf-8?B?Z0daSGsrV0orVDBoNExBMzhIS05POC9uZU9qb0ZzZkd4UDRZTjVUUk9uTGl3?=
 =?utf-8?B?MmdoL3RzZWZqbkdLdXZOWjZQSTMyZVJXTjFZWGVCRDVXR2ZlaW1qekRSaUNr?=
 =?utf-8?B?ejl1Y2IwYjl5VC9nT290Y2dCNEJNaG50c1pDcXQ3Z1JCZTJ3SmZKSnNnalBV?=
 =?utf-8?B?OHVGQTBVZXdBemE1cC9JK2RBais2ZkQ5VkdXU0wyM2N2NnU3bFVNaDVUZGNV?=
 =?utf-8?B?ZERwUXBEaHdkeFRiMkltLzBOL0VCVU1OeUlpMEYwaTlrTTNzYVZ6TStzQm9v?=
 =?utf-8?B?YkJjSWhUV0VrUTZPMzNhd0d5THJUd1B4dUtEQXhoTHpQQ0ZYWGtrSGcxMWor?=
 =?utf-8?B?UDY0UmpSY05wRlRNdXppbmhxY3Qzb2V3OExlblNERVJxcU5lMW54Nkxlc21w?=
 =?utf-8?B?RG9nSkhQbkZURlRrUDNETFptQzhMQkx1eitNS1N6QlNxVnFDdTdxOXJOdmR3?=
 =?utf-8?B?WHVSOUU1N1BYY0cxZ2NoUjVxVytJcXlSMlAvUU5TTlhxelpaWENka01yRzd3?=
 =?utf-8?B?Z1NPNExTMUpOZ3dNOVF6RWpiejlpT2o1Lys1MURMWnpIYnRZSjVBWGtqbFhH?=
 =?utf-8?B?dnFBbjBNR3U2SzlaNExMK2RiS2VndUlGb2dLc1hEWWVUNjh6Smt3OHJFcldB?=
 =?utf-8?B?YU1DdnNOSFFhMGlJejJ5T0VQQ1RZQlpDRjJJYm9Ra2NZUGlJNmw2aE4xRUF5?=
 =?utf-8?B?SDZNZlo0K1J6RWZPM0JDanZvU0xUWmU1Q2ZXTUc0V2VLZGdKcWJFTkFzM3VO?=
 =?utf-8?B?VDhnZVAybXVzbUVQa2NqaFNVRmlkR1RhQW1HbUFhS1lkWjRhd0U4ZFFtRGRV?=
 =?utf-8?Q?AQ8SOHaMy0KTDqz8kQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QTVzckJXYXdBTkJPbnJQUTVraUZGOFVlemtBTHFYUWhXTWhMNjF1ZHVUV3E4?=
 =?utf-8?B?ZU1WSCs5OFYzRFVjS1ZRMWVxSFBNNTJSOEtlUG5TL1FIdEp0ZEZ6VlUyYkZE?=
 =?utf-8?B?VldMSTBmSnpsY0lyblZscHpzOC9jOWk5dTlTbENHK1RkclBIQTVkcm1CMDJZ?=
 =?utf-8?B?UmZTTFRkMWpwOUxJbWpKNllRZC9ZUFZtZmphOEdmQU5RYXM5NkVqZDRNQ3Zs?=
 =?utf-8?B?RmlSNExDS3l0YXY2eitQQkE4NlA0VjhzMU1PLzEvZk5Id0hkSUptUFJYa290?=
 =?utf-8?B?dERDQ0hWa0liYkpiUFRUeGdMOVM2a1pyamU4Z2xXNTNXVVZmZkR0NmErWENt?=
 =?utf-8?B?OGhWd0htRVBGY0JSRy9OU0FSeDZhSC9IUjlUc05nbFRyRS82cnNvNk45RjBw?=
 =?utf-8?B?c2NCWElXdkZmVERvMW9YVm5wVkd2STJhYmtoWkJ1WllyUzVOMUJNTWpxdjY4?=
 =?utf-8?B?c2JuYytTUDdlZ1lpSzRJYmNSelMyZXNISXlUR2FOcXY3VVVGUW8zVlU3a2RI?=
 =?utf-8?B?N0dTOUNhQmJNYjJzcHIxY0xpd0RCWC96Y2laNDFtWlgxbWFiUGVKQ3hzYVJl?=
 =?utf-8?B?T3prNmJhUy9hdXFRTTlTbjR3VW4zTTlaUUtoYVl2T0lkVXFsNnFaTUkxU1Uv?=
 =?utf-8?B?QnhWSWppSUZzLzdwZ2svRktlYk13RGJpWjBlS01qcy9mcVhpbzNpNkUyNnY4?=
 =?utf-8?B?dnFCeDJCcG9PcW1tYlFnYUV0MGFudEcwWFV4YU0yZDFtWkV4elB4YWVLRlF2?=
 =?utf-8?B?dG5Rc0RxNGxCWEZlRFRPNVdYemd4LythNUN1ZUhBa1IwcUFqcWJ3OHg0dWFY?=
 =?utf-8?B?elMya083Nk1NY0hZN043QkViQ2FVc2Fmdld2SW54eEt1bE1NVnp1aHpxTHhF?=
 =?utf-8?B?MjdwRU4yQmVsZnpQYmk0cCtsNXl3QzJyL211QXcrMEc3SFhWSHdBVEFSYkJk?=
 =?utf-8?B?WE5pR2EzWDNvVzBhMDNweER0MTA0U0RlTGtWTW9QS295ZU42RWdzSEJXZm0w?=
 =?utf-8?B?TTZPbTcyK1MzRlh3MTNreHRaM2JaeXJNU0swNFZOb0NnY2pVTHJkUWd4ZWxD?=
 =?utf-8?B?OS9XWUZYTkxwYmxPUkJ1MEtJVkpyL2g1dnlTQWI1TXF3SjFaVW9lTytnYndB?=
 =?utf-8?B?MGpaY1ZhUGMzZldoKzNWVnVoeFZZS2VzRnVYVFB5MTJUeS91bFIwbjNtMWdN?=
 =?utf-8?B?ZmNYV1ZHaDZNUUxTLzBxWklLY0publJrRmJzb3Z0dmJsTjhrMElzUWJneUYr?=
 =?utf-8?B?dGxENTNOWFdrTU9JM3gweE9uZ3l1OXBxV24wNG9PNXhGZXNpemFEMHhhd2J6?=
 =?utf-8?B?WUJ3eFdDekw2eWx6c3NwMVpkd2ZVWEp6UDRmMy9NSzdpTXN2b2x0cWEwWVFx?=
 =?utf-8?B?Ui9td05RTmFHeVJQeFZ3Z2p5bjB0NisyNVVjVDFiR2ZvQTkwTUZldXZiN1lz?=
 =?utf-8?B?YStUT0s0UkhYREZlODhMYWc5amFaVXY1TVQvWE9RZVpDS3cvdnZLcnVSWGYr?=
 =?utf-8?B?UzJudWs0MUFRa3RyeklORkZ5VGt4cjE3RlViVVBXdjRqUWZpMHdjZmZSYlAr?=
 =?utf-8?B?eEVQVkZrTTdoNVhOUHluSDB0UW9Hc1BOU1FnNU1odWhUSkNlMDFndzFaWGNQ?=
 =?utf-8?B?THBSZWVoNjVEYjVtL3VIYzNtTGtCb21yRU5hUUE3WWhhNFhsR3pwOWZkWmdx?=
 =?utf-8?B?U29JNHpsVEx2dkhqR05OTDZjS3pKTE1IMjluRlVrRWx0bnBIbFRZeG40VS9m?=
 =?utf-8?B?cmhad2J0d25ORTZxVmxsdURjWDlTNHYvWWxyN1dSNllud3gycWpUbFd5eVV6?=
 =?utf-8?B?YU5Iazh1d1JRWVZzRXdnUmJuYW5RaVpVYllrTm1lVkd3YU01eVFTcEZBV09X?=
 =?utf-8?B?dUFDbGpyVkFjOFlHNzVWcGIycXpURFdUMm94K25DUTRPL3AvUFp3K3Z4Mk4x?=
 =?utf-8?B?bmhBcE5NRkFNZEpxV0swMWRidUcwaC91RkcrcFFVVzVUamNBeSt3VXl0c3Iy?=
 =?utf-8?B?NTFzT3ZlZ0Q2SlZtdnNmT1RUdWp2aEdaNERSb2ZJUGxKbnFKRGdBYkJHRXEz?=
 =?utf-8?B?U1VTeXV2OGY5VklGY1BOS2Voa2hNcGVSR05TZU9KTmF0bGV4YkszSHNBaXRq?=
 =?utf-8?B?NDk0ckZyMkJvT1FzMXQzSm5qY1JyQ3NzMGxCMis3VEF6R3FyeUpNVXhkWnl0?=
 =?utf-8?Q?R/MLmZPd3uk22MHO7fakqYU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GwMJ0Um7MKqGg9tsW/0MJG/s8wLWLuMWUWZHB1rKUPqDWco+BGGkGssAgbx3X9GixD84p3Ll+ZVCzUE3tzARWs5rkzI+UhDpAMUqUtWX60FSxR0rrcfhAmpwanKF84Z2fHhDIURHZYeUYq/krdBqalTKM3mt7mUxSgyqG+TnHCXMLG1NEXQqhvy76d2Flvc6s8b6e6FdCElfRf+9TUsNK7TqqD1kXXUkL4DQieUVxVHSCzNbP8m844FLf4NzoJH+PvquHwIYGYiaLIWVcNcb2tqR85qEPeoVGz6yFDB7XyQRyyJAF+sPALA+UZsveUKciZzEPFDEVeIndwJAJty/MLHA8WXMoDmqCXSGPb7ZQMhCPVrG+vuV/xqcH39a9O8NxQ6W1j4mcKLd3Gr9E+cp+CR+hkDwobUMHR9l7kqM8G3RpcLTBmt3ri6L6vvNhxCJosRA0JYr2OuJqSbIcCmGgc03RunYTmIkZ0pyMbmxk5d3EWEzVu9dXvXERoOMDQswE+77WRAY93GaXmshsabua0OmtBikXIWzNNRjDn88fDcl4yf6+oCySgTSeuCiKRMqaO9ksfr5oG+/rSZa8zj/iy7wsTJ3G0bZ2hxXdwf9n9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2579b9-8a4c-4cd9-97fa-08dc99ed0e40
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:44:20.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQ0XMmjv+ApeDgKaiN6/FGcmDB4uBur8ypDak4ql451oa9mzEt5GWvqAZ8xd6qn0e+iYUNNrlFAxzPeaOCw0yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_16,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010126
X-Proofpoint-GUID: eA3s-OwyYywR6vdAKZ3KJ-pAV_vtTZGy
X-Proofpoint-ORIG-GUID: eA3s-OwyYywR6vdAKZ3KJ-pAV_vtTZGy

On 28/06/2024 20:44, Dominique Martinet wrote:
> Alan Maguire wrote on Fri, Jun 28, 2024 at 09:31:17AM +0100:
>> FWIW I verified that with the above change, and
>>
>> export KBUILD_BUILD_TIMESTAMP=$(date -I)
>>
>> ...the feature flag is added to pahole and as a result we get
>> reproducible BTF in vmlinux; .btf.vmlinux.bin.o is identical across
>> multiple kernel builds.
> 
> Sorry for the lack of reply, I didn't have time to test until now, and I
> have no idea how to override the kernel config in nixos so the checking
> build through nix build took all night.
> I've now also confirmed this works including for modules BTF & linux
> "package" build on nixos on master.
> 
> However from there I built a random kernel module and have also
> confirmed they don't set KBUILD_BUILD_TIMESTAMP for external modules --
> from a quick look it's not part of the default flags defined as
> buildFlags here[1] because each modules' SOURCE_DATE_EPOCH isn't
> available at this level (and I have no idea how to call a command at
> this level), the configurePhase where it's set only applies to the
> kernel itself and not the gazillion of modules.
> [1] https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/kernel/manual-config.nix
> 
> Add to that that nixos is supporting a dozen of kernels -- all mainlines
> stable versions but also a dozen of variants (rt, whatever xanmod and
> zen are, and if you look for things like mobile-nixos you'll also get
> much older and not update sunxi and other embedded trees) I definitely
> won't put the effort to backport equivalent patches to all these kernels
> 
> 
> I wanted the patch for alpine as well but I honestly don't have the time
> to do the same confirmation work there; if they have any external
> modules I don't see the flag being set either, at least they don't have
> so many kernels.
> (but unlike nixos the kernel build "framework" code isn't shared and I
> know of at least one out of tree embedded kernel that doesn't set
> KBUILD_BUILD_TIMESTAMP and only has SOURCE_DATE_EPOCH...)
> 
> 
> So:
>  - in theory, sure; this patch works. I say we can do this independantly
> of any other effort. The propere way of setting reproducible build in
> the kernel is not SOURCE_DATE_EPOCH but KBUILD_BUILD_TIMESTAMP and
> handling it at kernel makefile level is sound.

Okay, so I propose we try and get the KBUILD_BUILD_TIMESTAMP-based
change upstream. I'll send that later today. That doesn't mean we can't
add the envvar-based method too, it just means we have something
upstream that handles reproducible builds more explicitly.

>  - in practice, (nixos hat) some modules won't set it but will only have
> SOURCE_DATE_EPOCH available, and there are trees that won't be updated
> for years (and that's being optimistic), so our local patch in pahole is
> here to stay for a while and the benefits far outweight the rebasing
> work.
>  - (alpine hat) alpine doesn't seem to care as much about
> reproducibility (the nixos patch wasn't in and nobody complained so far),
> undecided at this point. Makefile.btf patch is probably good enough, but
> since I'm maintaining the patch anyway it's no extra work to add it
> there, undecided at this point.
> 
>

One thing I think would be worth doing in your patch would be adding
debug logging (if in verbose mode) that we are enabling reproducible
builds due to the presence of the SOURCE_DATE_EPOCH envvar. I don't
think we can do this in the non-debug case because build logs would just
be flooded with a few thousand of these messages for each module we add
BTF to using pahole. With that small addition I'd be happy with the
change. Can you send a v2 with that added? Thanks!

Alan

> Thanks,
