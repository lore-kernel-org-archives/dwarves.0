Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6932A3C2
	for <dwarves@vger.kernel.org>; Mon, 18 Aug 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525413; cv=fail; b=Xhih52otvkijLu6ap2niAIG7NwiXsg2yu5E/wMIcG7E/f+TbjG8NKVQwp5JPGXxu8nTxZX0+kyHgVJ1SiiWvuQSr8DCEuVtRRuO9Eu96gS9w+2uiJlF6OV2hvPXiia++Fuq4fBidZAmOCj42P6fLkqws4efdesU1QA4uxmd9Jhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525413; c=relaxed/simple;
	bh=0Yg43t25+46xbVbq4rv2HiBL211HNvh7Xf3ie/3oZzY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N2LwfqaqrDKec8D+Z4sgMT3DLkCV5kZo63OzeIPlXDY+RryAqJRaTpdnFrSlwfK7ZVX+i1nTWv+Qh7sDfW+pSNoyedckD8dxQ9y7e3oICGgSNQv8Vkd6lt1K2/p/skPVHXLFzt/9coKMCwVbFjovi2bghqtJEw+4/CIgB/j+Vw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oP5fpr5S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IC+oTAeL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oP5fpr5S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IC+oTAeL"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I9esmB018391;
	Mon, 18 Aug 2025 13:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1HAIIvj7aO93d8+FdAq5RKsDoNrXcCN38Xq2YSHZnh8=; b=
	oP5fpr5SRnVymIt2g7wYvZZtWGmTUmTI5QbZ0whXbQVMHvMkY3hhtUc+gNVj9ysF
	iLCX6ODilulLfRyNsySZq2svfpzmTiY1GcGNvMWB+23L11li0E2wzYc5Yn5o2R1c
	tPArFHNmWVuqBiYJA1IG7sfbxwZF7dir5QyYd6lEoPt8FETFx0JK1jIQ4+zm/rO6
	2JvM5h8Zvu/WaL8Gxt6S5R7iSvfWKbsKcvvWS1eptxUKXNtGQRiDj4R7rN6Jxtd2
	G4LVi5UieYimFi31aMM2NH+fO1cik7MLdowJ/tb3TEb8Vx0RiyvitTSKXLTBUK+W
	ngXm6IOBdQtSV530pAf4LQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48m0ybrn0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 13:56:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IDLlLA011418;
	Mon, 18 Aug 2025 13:56:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge99qp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 13:56:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB8w6kNjyfnbJqJ/SLdD8joEHmr4GByHDi0ex2oo2cOOaIFk9sOBlPy6q9qv8KQ6P3H9SKJOvQ2Qn1kiRAyEr8RZaznm5sLRwrk4Y1XbIUapqNtkSAZoqJ3PlT2iPuqWdoI9xoYQWEf7vhp0sFzlkPo+sXmyLBAjHH93bEfJlTFvIOeDwV8YfZUT/x6LXjFFWbAnIZdkUtbUNac1wqkOATWFMpchalTWSM1RXUNIgGu+wMjo0iy/Uj8gqBn8dRfhrhScrXEO0W0gXWULPvQhqi5MU89+O7IAzGtfcEBA3Mzg6YKDqKxCLIyjToiNlx8W3noz457aOjH/IgZQZq1VgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HAIIvj7aO93d8+FdAq5RKsDoNrXcCN38Xq2YSHZnh8=;
 b=WhIaFD9c8WQ/cw3vrvTteqZ+4Ycmzwr8OidR1M/hgkEKUDdmzKju7WnbHfCbiCtt9Xskvq3agNpB1JsYPiaAR5ptSXoeLpkEaLeYQxoERi6aB8TZUyGg/gxa++z79mCNAVfgcDuSWunF7LQltoKXzDCm4Z+kXk5k4aU3rPBCYpDywN6kyRT9mNaZCvmgTGHOu5LcU54OWUznEe4PdyFynXIe0uUUgV7o887gGCbIxssjwQSfOfGUWOFJ8QOd/Xitjc5GQZRNuVL1uys/OFk+3F3lTwHFf0uEOvPlkzxMFIKLmen5JSuJqukF4BwUu/b0Qa9wVTeb65Snd2hHX7giZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HAIIvj7aO93d8+FdAq5RKsDoNrXcCN38Xq2YSHZnh8=;
 b=IC+oTAeLLTwDRdO5pcAxE4zzKM44TYyn95twZ6vIhqdzEGL38lDGryBAzRvPLRBoEMvqPLe3WBt0h9ejS3NmSgWcENwPQq/9Pc8PoHy8aeLwRC1QD/0komyQiqcF0zluxqgveVqOaALnLKfn0DZuFBWSpOMpd8nkWCy5BaabW34=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.21; Mon, 18 Aug 2025 13:56:42 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 13:56:42 +0000
Message-ID: <7b071d63-71db-49d4-ab03-2dd7072a28aa@oracle.com>
Date: Mon, 18 Aug 2025 14:56:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: "Segmentation fault" of pahole
To: Changqing Li <changqing.li@windriver.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, acme@kernel.org,
        dwarves@vger.kernel.org
References: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
 <37030a9d-28d8-4871-8acb-b26c59240710@linux.dev>
 <f1e2dc2b-a88b-4342-8e94-65481ae0cb4f@windriver.com>
 <ec72bbb8-b74d-49d1-bb42-5343feab8e5b@windriver.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ec72bbb8-b74d-49d1-bb42-5343feab8e5b@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: a055df2a-e13f-4be9-c6de-08ddde5f0f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHFLNzNxVU13TDI0U2JIeVdxSFBBamxWczYzTHdKQmwxUVJTVXZHaGt6Vkpi?=
 =?utf-8?B?SUFld01GVVZTYUcxTFpPOGhWeFdIdlM1YTJDbjZTVW43RXNKK2FzZk9leGV2?=
 =?utf-8?B?bDNNdi9xbjduWXFhSjBhOGZsb2FCa0V6dWpLSGV6dWd2R3lzSTFIMUxrVm12?=
 =?utf-8?B?b1lWcHR0cElueFI5TVY1YStZQUE4SWFGWUlFSWtCZWJ6b1FxMlNyYUpGWVNh?=
 =?utf-8?B?cE9ZZmVpbU5ldVNkMmhjNWJGRUFtczd2YmJoQlU2NzMxMXFIOUtIWWpTZE5j?=
 =?utf-8?B?aHNNNFk1bmhkZjh1b1hnUEx4aXViTG5nVWxOUkVzMzEvejViNzh6dURrM2pR?=
 =?utf-8?B?YU9HdTU5ZjJoMlhQZjh1RjYvTmJpeEdSZ2krczE0U1hBa2ZhYzZyd2tkWTZ4?=
 =?utf-8?B?ZlRCb1Mra2dQWXJQUmpOdTZHZmRCenZRVG9yZm13N2ZBUXhIc1BQQXB2dW9G?=
 =?utf-8?B?NjBHT1d6T0dnYkdMYndkbUdlSDJJWlRidmZTTnZFcERZbVVQSGhPM25Oa0Jw?=
 =?utf-8?B?NTZKTElkRnBmbzlrQktlbjZiSGpIL2paY1l1cUVFYUh0NFFDK0NMdGhqU3BO?=
 =?utf-8?B?NDZ0Q0lKd3pwSndiNzdNK3JvUUZiZjkvbXBwT1pobmNIYVQrRXY3TjNNLytO?=
 =?utf-8?B?d1l5SjJrQmRuVTV5SGFwQkxqY1JER2NveHlZN0hFSXBDakRMcGt3U2pVbkZT?=
 =?utf-8?B?eE1ENVlsVnk2U0xybHlURTRPRFlVZFZOdENSdTR4eG5hZUNFbmhjWDBudVVN?=
 =?utf-8?B?QnlZL2V6MWZOd0M4V0M3dUNtYWcwMUVGQkhaeFZYV0pmVXcycVRjWk1HVTB6?=
 =?utf-8?B?SnBYM3lVWVI2NjFKWTRRM045alJvYmMrNUt0KzVVeTNFTkgwK0NoaTh5M2N6?=
 =?utf-8?B?OWowSDcyaHdpSzFXcUUvdDRMUkxzQU5xa011T3VZVEhYdDZ2SnVYdVVybHpY?=
 =?utf-8?B?ZjMrbUtRMDJ6aUwyUVJIMEZlTTRNdGpPVzBEZkJvejhldGxNMzlUaGZ4SkpI?=
 =?utf-8?B?SzNpK0FET0Z1d3prWXNXUExWQUI2MlZRY09uR3dFYXI2U0FuaFZxZ3N5cklM?=
 =?utf-8?B?WnZ3SXRSbER5QkJwNEVIcFRVaTZwelR6K0FqZ1kvNWNVeVJoeTFXbjBCN3Bp?=
 =?utf-8?B?Q0JFejJJb0dHQ2k0UUpJNm9sdk9vVU81MjhVa0FNMTM4K1F2V0dUdHh4MVdI?=
 =?utf-8?B?MnpXMnZ5cVhXalh5cjFnMUlhTE9MOTNSM2FRY3lCUkFPRTRiMmhKN0JUaVYz?=
 =?utf-8?B?bmxtQXhuTlhzUXU1THZNbDN3dStraGp2U2pmYk54dDA2RlNMWDBQM0swZkow?=
 =?utf-8?B?ejZOY2dLQXoxeGNYYkxkaTdBNk0yTWpqeVJSQWFYTmZnRFJhTXJiWmgrVEZK?=
 =?utf-8?B?NDhlZEpKcFdBVUdLNEg0LzFxSUJ2anJBSFhDUGlTNWk4NUVWZVlCNFpJNkF3?=
 =?utf-8?B?eFQ1cG9NOXdGelo2cUZEOHE5bW8vaTlROWxWN09MVlZaRFdQVzhvZHpaWEdR?=
 =?utf-8?B?QTNmNXpyUTBtUUNLbFBTRk5OWXM4bDlSTTNBRUVwS0psSUZUUWc2OGhzeU1D?=
 =?utf-8?B?Z2grYmkzek5ndEVpMEVYc0o4WWVaMnhJV2c3NTFXbnRndW95MjZVTFY2dGRZ?=
 =?utf-8?B?a09GTXFOeXV5bGw0UzZEWlI3bXJrSEc3NENUOWtsYkhrQU5UR3BnYjc4RWp2?=
 =?utf-8?B?THlGMDdUMm9OR2duMUk0ZkNPVkNrRm05VkpmeUJwdGdqZE9wdXFQT2hNS1Br?=
 =?utf-8?B?UUtjbmFZVVhyUTY5ZGpPLzJHMzJ6TDBlVFlvcjR3Mkl6c1pPZ3RTMko1YXpD?=
 =?utf-8?B?bUpQTGE2ZTcrUEtLU1pjbjV3RHliemRDR2lhbmo1dFZ1SGl4b0txL3BOeDJC?=
 =?utf-8?B?dmV5ZFM2TkgwV3RYbW9Fa1pRWHZPbXNUOUxJV0swT0JEWTFhUzdzUU1TZmZY?=
 =?utf-8?Q?ViHWkC/Xc0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkhYM0dwWXU0cXY4N0ZHODk3WnpoNVl4Zkt6UmV0aU5JWUFpNG0xVzVWNlNY?=
 =?utf-8?B?ZWwzUTJ3V3VodWI0ZXNtbzdqYm9CcXF2OTZqd0tPRnVQNXJuSzhxM2xQQXMx?=
 =?utf-8?B?ZHgzZmhMdG4wRFpLMXRjTVdlVlhDdVVRUExpQ1FCcGxYb3l2Tm9QRUtMbmMy?=
 =?utf-8?B?aTl4c0tod3p1K2kwWWVodlE2aHN0VElDdm14c2JZL0sxMGRjNllXWXdwblF1?=
 =?utf-8?B?cGtDNkQvMHhFNjd0TE5GQk8zZ2ZFQlZvTmh1YXduOUtvaE0vQ0dzZ3RoTTlm?=
 =?utf-8?B?Vks1Zk5xM3BsZThwM2lCL1hLRVdyRElHSFV1T2psUldiMDloS0VJWTQ0Y3JL?=
 =?utf-8?B?eG1lMlpVVVlKNVRpdnpMU2JPR0pWbTNSeWxBQmRYdkhrbVJzUnhRTkxQWURW?=
 =?utf-8?B?UGswamVOYnVkSzE0N1ZDYlQwbCswNWNuTTlaRnNkWXRJaVdzVmRpVGs3WE5Q?=
 =?utf-8?B?SE9BcE9aQk0rQjh1VFN3bWJ4OTlldkFvYklqamEzQ0NYaDZORTBNTVRDN0ZN?=
 =?utf-8?B?Y1IyK0tsd3dTSU1ibDc2QTExZTdnMmJGVWxmWUg2Nmg0L1hnNFR3Q01Uc0gy?=
 =?utf-8?B?NlI2REFla2g5eDJ5eHZNWExDOWxvUDIrck5NbjRwSmlVdVZxUVNGdmN0Qi9D?=
 =?utf-8?B?WmhHQ2lnelR2TjJxRDErMEFxbFVjZ0ZnL2x5bFhRaDlmc0Fhc09Vb3FpSUgy?=
 =?utf-8?B?eVJmY21EU2NoT1ZXaSs3VlZPSU5OaWZuOVdHL0h0aEtLK2cyRUNyenpzOHow?=
 =?utf-8?B?Qi8rUmVROHN6OG12a3Y3SzNHc1JwVlQvT0JZZXdEdWNEczV2eTV1TjZpQTNt?=
 =?utf-8?B?amZZNDNGUzVmeXAvSFBCSzVEODNPNHRaL0dodGVQRkFCR0hBeDBTenRTc09n?=
 =?utf-8?B?T1I2YmM1MlBDdkIvVkUySzdGT1lTajNvYjZZMlRBU1VPMzRYbGY3SCtRQXNy?=
 =?utf-8?B?STNxeEJxRHR3OHNmb2FvVmd2QlMzbjBrV0xXR2dwRW9HM3YzYjVtYXhRU0Fx?=
 =?utf-8?B?STNKYlNpOW1mWW9QcDhRbzIzMGMzTkRSc2JYbXZDL2ZCQTRBMVZIeXRaY25l?=
 =?utf-8?B?MjVFUG1nOFAxMUFERnd3OTlHYm5QaExHZTBkRGtYM1Y1dnZYczZNM3lDRXNx?=
 =?utf-8?B?RDFLSjZQSWhMd1p4SmFUVlErVGlnL21WZUZoY2FLQ0V6dkpJd0hHUkJEOG9y?=
 =?utf-8?B?M0NmQmo0OG16TXNpRElvTUhkWGgyOXFaei9wWmdoZDZJdDI3bEJuN0xxTzBp?=
 =?utf-8?B?S1VreHh5ZUpUZmMySHVlNjJkRmNzNnJ0cFJUSUxXcng2WDBzNStFUTduVlZu?=
 =?utf-8?B?eWZ6NHNYK2crbkU0TTdGMEUwUWJ0MEg5WmR6Njg0bTlBdmVIckVuR3MvTEhU?=
 =?utf-8?B?Z09ST01UUEYzMmpiOVhUWTU3YUVxQjNrdXpibmpYT0JWN1p6aXEvYVduT0t1?=
 =?utf-8?B?aU8zRjJ1TmVWVGFScmVtM2h3ajh0Vk1pc0lUZDVxYmUvME5KcTBTUE9vNVFK?=
 =?utf-8?B?NEVYV2x6TVQwY3B5Z1p5eTZPcVpoaVhTUVBJelNJQnNZVU5XdFhMTE12STlw?=
 =?utf-8?B?cFY4azdUZFo4NGwrYU8zT2U1MUZjM3k4bXRYM3o3VHdzQ1gwc09vVktTeWM1?=
 =?utf-8?B?ZlJ6Z2RIWnNRdFlUMUY3NjlsZ3NyUExaNFpwbXNNWWxHN1V0cmoyQ0dReUZH?=
 =?utf-8?B?d0Q3b2s0dHBkcDNmc3RmWHJjWUdrTEZvZ3dNai9adUpmTnlqaWtyMkl6L0Ji?=
 =?utf-8?B?dVh6bitmVEZDRnJVQzg1c0w2VVJkdHc4a00xcU1VbWJvT25UbWJ1a29oN2RE?=
 =?utf-8?B?MUt2NGluMWNHK2hjM0J2eDNvQnJjRWxTOVBiZS91eFhKUlJZcDlWZGM3UHhi?=
 =?utf-8?B?cW9Kc015d1RoNE1LN21Bc1hqK2dCNC9uaytPeVZYT3dEcjFFNk5UajJPU2JC?=
 =?utf-8?B?aG9ZbFI3aDJpTWwvdUJhbUpleHYwNVlVVDVDM2VpUzB1YlprVDBlTUNYNzFl?=
 =?utf-8?B?SnRvUmZtK3NuWXJJUkN4dmpyeXF2WS8zUnhGT0ZRYUszSDVhcU1wQlVpcDZw?=
 =?utf-8?B?VG9wdFlwWHVYdkdBZnJOR25QeE5yRWsyeWRIQXNNcG50dlh0MVJCS3puTWxm?=
 =?utf-8?B?OXZrcldOZ3lCVTNLYVRYTjhEMUtYTWRDUWUxbkZMM2tUMkdJR1dmR2VIbHcx?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U/cCbaxfG8Oi8TtB1a6sv9vWEl2Ujv4orpQTwRKhwUXSGlgqWtbeMIZywDKE01/xwVchEPEnOyVsTiBMtj0JDWvHavAN6EWoOUUMtf3i796OfViH+NKh0vrTC1l/EmVTz0IogE+zCiwMqtXhXuxi5dWw/kYArOEZe2R1LZA0Sz7Vw5df33eYhWTCDyTCPUHVRRU2HnHU8BY2NQaF7XOVo3uZxk+MjGjDFLFuqMddxd4ncbuOcbOQWV6bZvyhE4qV1isnF6EYExgYOHR3tSt5MOmqxcucR2CJjXmXW+DI6ZNXc+/TiYNwoakY4LAA7dfHsLQUfFyZ1UXrajBJ4HTog/9k2kSW0UdWmX7NI1UbQGwLoVV0w3fJc0o5SrSyt5f+yeDyJ+9tDY4ZKMZ4Ui9i35Ix2vzUaZR8UeomUNIxwdkDSNEPT9Mhcq97sen6mdcUSwXdiXBH4c6m2RtRsXiD3JJ7587M2acB6M0Q4JMHwAcGgf15a7K8bWUpAFlWnJyNScCbk9i7Ac6JLeglnOmMarUcQgj+8zh1wr5yvugCzkx7D6h4Gx3K4RHz/2myMy6tHaSDfyw5/005Y0pVptpUO5Mg9ae+npnKKgpJZ9vvxxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a055df2a-e13f-4be9-c6de-08ddde5f0f91
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 13:56:42.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymcpHBV4XFs6pC+WhHjp1tdtOCMpdL7OdvzR9Dau8IzT+3QdhpRcaszv1Ed8EibbLX6zll+w0ZhKjZgIN64qcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508180133
X-Authority-Analysis: v=2.4 cv=fcOty1QF c=1 sm=1 tr=0 ts=68a3311e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=_3LlO853D_h4DPy1K14A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: LYApMmkQ1pQ-XDfv6v3GeXjD9MhnXXuU
X-Proofpoint-ORIG-GUID: LYApMmkQ1pQ-XDfv6v3GeXjD9MhnXXuU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzNCBTYWx0ZWRfXxVcHrNpNXbID
 Nu6q9be0BUwrMR7/8hXEAe5A13F0N7rOFeWzrViJbCZ0JiVWDth9tBeHMAbwUbjOv3T0Rx8if0s
 PX3jpA16aH41N0gMaNL5a9VnVStSCmyR9HkHZ0/jySij1XUFTKN+wkvXwbOdrpV9pcT5okYvwhu
 D1ATS2bUh97bD24NMVZjuArB0DQPWh6WSPM/ZCc7jcrxknwfYVF4u++ZA1wdPdXhGLXy6WUG33s
 LNZRJP+U3GYXKeyR2xskQjj21jS/7XGKBEdOk0SSj8rSGLryAbLZzcNLzxdAzz+SYqh/ZPQlFoZ
 ZZWuvFGdv/D8XPcJFAWBzICg8IVWK2y9Tfor3TuSeMbx7XNHhBrvwC1VvXuudSV2iaORx8783rn
 JSoTQ6ZRVzDU21hh9rx1JproW+/sOybw0ZJoxO9vNPISlg26nEC4X1rYYRMFHpNgIOF+bbj2

On 14/08/2025 10:42, Changqing Li wrote:
> 
> On 8/14/25 17:20, Changqing Li wrote:
>>
>> On 8/14/25 07:45, Ihor Solodrai wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the
>>> sender and know the content is safe.
>>>
>>> On 8/10/25 6:18 PM, Changqing Li wrote:
>>>> Hi,  Dear maintainers
>>>>
>>>> I met a "Segmentation fault" error of pahole.   It happened when I
>>>> passed an ELF file without .symtab section.
>>>> Maybe I passed an  unsupport file, but I think it should not segfault,
>>>> maybe  a warnning or error message is better.
>>>>
>>>>
>>>> Here is the detailed info:
>>>> Pahole version:
>>>> # pahole --version
>>>> v1.29
>>>>
>>>> Reproduce Command:
>>>> root@intel-x86-64:/~# pahole --btf_features=default -J /boot/
>>>> vmlinux-6.12.40-yocto-standard
>>>> pahole[599]: segfault at 8 ip 00007f7c92d819e2 sp 00007f7c799febe0
>>>> error
>>>> 6 in libdwarves.so.1.0.0[189e2,7f7c92d72000+1c000] likely on CPU 0
>>>> (core
>>>> 0, socket 0)
>>>> Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24 18
>>>> e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42
>>>> 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
>>>> Segmentation fault (core dumped)
>>>>
>>>> root@intel-x86-64:~# file /boot/vmlinux-6.12.40-yocto-standard
>>>> /boot/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable,
>>>> x86-64,
>>>> version 1 (SYSV), statically linked,
>>>> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, stripped
>>>>
>>>> root@intel-x86-64:/usr/bin# readelf -S /boot/vmlinux-6.12.40-yocto-
>>>> standard | grep .symtab
>>>>    [ 4] __ksymtab         PROGBITS         ffffffff82c11e00 01e11e00
>>>>    [ 5] __ksymtab_gpl     PROGBITS         ffffffff82c24730 01e24730
>>>>    [ 6] __ksymtab_strings PROGBITS         ffffffff82c397f0 01e397f0
>>>>
>>>>
>>>> (gdb) bt
>>>> #0  elf_functions__new (elf=<optimized out>) at /usr/src/debug/
>>>> pahole/1.29/btf_encoder.c:196
>>>> #1  0x00007ffff7f92a7d in btf_encoder__elf_functions
>>>> (encoder=encoder@entry=0x7fffd8008dc0) at /usr/src/debug/pahole/1.29/
>>>> btf_encoder.c:1374
>>>> #2  0x00007ffff7f94489 in btf_encoder__new (cu=cu@entry=0x7fffd8001e50,
>>>> detached_filename=<optimized out>, warning: could not convert 'btf'
>>>> from
>>>> the host encoding (ANSI_X3.4-1968) to UTF-32.
>>>> This normally should not happen, please file a bug report.
>>>> base_btf=0x0,
>>>>      verbose=<optimized out>, conf_load=conf_load@entry=0x555555565280
>>>> <conf_load>) at /usr/src/debug/pahole/1.29/btf_encoder.c:2431
>>>> #3  0x000055555555db49 in pahole_stealer__btf_encode
>>>> (cu=0x7fffd8001e50,
>>>> conf_load=0x555555565280 <conf_load>)
>>>>      at /usr/src/debug/pahole/1.29/pahole.c:3126
>>>> #4  pahole_stealer (cu=0x7fffd8001e50, conf_load=0x555555565280
>>>> <conf_load>) at /usr/src/debug/pahole/1.29/pahole.c:3187
>>>> #5  0x00007ffff7f9d023 in cus__steal_now (cus=<optimized out>,
>>>> cu=<optimized out>, conf=<optimized out>)
>>>>      at /usr/src/debug/pahole/1.29/dwarf_loader.c:3266
>>>> #6  dwarf_loader__worker_thread (arg=0x7fffffffe700) at /usr/src/debug/
>>>> pahole/1.29/dwarf_loader.c:3672
>>>> #7  0x00007ffff7dbe722 in start_thread (arg=<optimized out>) at
>>>> pthread_create.c:448
>>>> #8  0x00007ffff7e314fc in __GI___clone3 () at ../sysdeps/unix/sysv/
>>>> linux/x86_64/clone3.S:78
>>>> (gdb)
>>>>
>>>>
>>>> Command  "pahole --btf_features=default -J /boot/.debug/
>>>> vmlinux-6.12.40-
>>>> yocto-standard " works well since /boot/.debug/vmlinux-6.12.40-yocto-
>>>> standard has  .symtab section.
>>>> root@intel-x86-64:/usr/bin# file /boot/.debug/vmlinux-6.12.40-yocto-
>>>> standard
>>>> /boot/.debug/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable,
>>>> x86-64, version 1 (SYSV), statically linked,
>>>> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, with
>>>> debug_info,
>>>> not stripped
>>>>
>>>> root@intel-x86-64:/usr/bin# readelf -S /boot/.debug/vmlinux-6.12.40-
>>>> yocto-standard | grep .symtab
>>>>    [ 4] __ksymtab         NOBITS           ffffffff82c11e00 00001000
>>>>    [ 5] __ksymtab_gpl     NOBITS           ffffffff82c24730 00001000
>>>>    [ 6] __ksymtab_strings NOBITS           ffffffff82c397f0 00001000
>>>>    [49] .symtab           SYMTAB           0000000000000000 154cf200
>>>>
>>>
>>> Hi Changqing Li, thanks for the bug report.
>>>
>>> I couldn't reproduce this error with a stripped vmlinux:
>>>
>>> $ objcopy --strip-all ~/kernels/bpf-next/.tmp_vmlinux1 vmlinux-strip-all
>>>
>>> v1.29 fails with:
>>> $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
>>> Error creating BTF encoder.
>>>
>>> v1.30 fails with:
>>> $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
>>> pahole: /home/isolodrai/pahole/vmlinux-strip-all: Invalid argument
>>>
>>> Different errors are not nice, but at least no segfault.
>>>
>>> Could you please share the vmlinux binary that causes the error?
>>> And also check if you get a segfault on v1.30 too?
>>>
>>> Thanks.
>>>
>> Hi, Ihor
>> Thanks for checking this. Here is my retest result:
>> On version 1.29:
>> root@intel-x86-64:~# pahole --btf_features=default -J /boot/
>> vmlinux-6.12.40-yocto-standard
>> pahole[333]: segfault at 8 ip 00007fd5025179e2 sp 00007fd4e73febe0
>> error 6 in libdwarves.so.1.0.0[189e2,7fd502508000+1c000] likely on CPU
>> 0 (core 0, socket 0)
>> Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24
>> 18 e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89
>> 42 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
>> Segmentation fault (core dumped)
>> root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
>> root@intel-x86-64:~# pahole --btf_features=default -J /root/
>> vmlinux-6.12.40-yocto-standard
>> Error creating BTF encoder.
>>
>> We can see that the same vmlinux-6.12.40-yocto-standard have different
>> result. After do some debugging,  I found that
>> /boot/vmlinux-6.12.40-yocto-standard segfault since it has debuginfo
>> file /boot/.debug/vmlinux-6.12.40-yocto-standard.
>> after I move .debug to .xxx, it will not segfault.
>> root@intel-x86-64:/boot# mv .debug/ .xxx
>> root@intel-x86-64:/boot# pahole --btf_features=default -J /boot/
>> vmlinux-6.12.40-yocto-standard
>> Error creating BTF encoder.
>>
>> dwfl_module_getdwarf in cus__process_dwflmod return different when
>> with or without debug,  without .debug, dw=NULL,
>> with .debug, dw will have a value, then causes the different process.
>>
>> On version 1.30
>> root@intel-x86-64:~# pahole --version
>> v1.30
>> root@intel-x86-64:~# pahole --btf_features=default -J /boot/
>> vmlinux-6.12.40-yocto-standard
>> pahole[314]: segfault at 8 ip 00007f2b0b6b2bf3 sp 00007f2af05feb20
>> error 6 in libdwarves.so.1.0.0[18bf3,7f2b0b6a3000+1c000] likely on CPU
>> 0 (core 0, socket 0)
>> Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24
>> 18 e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89
>> 42 08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff
>> Segmentation fault (core dumped)
>> root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
>> root@intel-x86-64:~#  pahole --btf_features=default -J /root/
>> vmlinux-6.12.40-yocto-standard
>> pahole: /root/vmlinux-6.12.40-yocto-standard: Invalid argument
>> root@intel-x86-64:~# cd /root
>> root@intel-x86-64:~# mkdir .debug
>> root@intel-x86-64:~# cp /boot/.debug/vmlinux-6.12.40-yocto-
>> standard .debug/
>> root@intel-x86-64:~# pahole --btf_features=default -J /root/
>> vmlinux-6.12.40-yocto-standard
>> pahole[441]: segfault at 8 ip 00007f64a9032bf3 sp 00007f648dffeb20
>> error 6 in libdwarves.so.1.0.0[18bf3,7f64a9023000+1c000] likely on CPU
>> 0 (core 0, socket 0)
>> Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24
>> 18 e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89
>> 42 08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff
>>
>> Segmentation fault (core dumped) 
> 
> I think this " Invalid argument " change  is caused by this commit:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?
> id=b4a071d99bb9e7c0d3c6ea7a6835389a4d350ed4
> 
> encode BTF with DWARF less files is not support for v1.30, so, since  /
> boot/vmlinux-6.12.40-yocto-standard without debuginfo, it taken as in
> invalid argument,
> 
> I think it is  ok,  but maybe more clear reason is better.
> 

Thanks for the report!

With latest pahole (next branch of
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/ ) including
Arnaldo's change

commit 97bf0a0b0572ec023761da9226b068b59b471de0
Author: Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Tue Jul 22 11:22:27 2025 -0300

    pahole: Don't fail when encoding BTF on an object with no DWARF info


I see the following pahole results against a stripped vmlinux:

$ pahole --btf_features=default -J vmlinux.stripped
$ echo $?
0

Can you reproduce the segmentation fault with the above pahole? If you
can provide a way to get a stripped pahole like the above for me to test
with, or provide the kernel .config used to build it, that would be
great. Thanks!

Alan
