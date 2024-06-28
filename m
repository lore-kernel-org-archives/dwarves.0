Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79B1465A1
	for <dwarves@vger.kernel.org>; Fri, 28 Jun 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563511; cv=fail; b=EywwuNIz+CibvfA4mlhsomjTnXxBRE5XxTiWpZvCtc3FLyzpMXdh09WaUYiWzFv1+8CuaUcmywx84yixyHhgMK9ju7JNbcuiqP7R3o9Ys0TkIaf+DFO7yBCbIaXaa3E9JGrkZwBDJKdPQva8XmgfnDudp2X7TWFTBw3ItwZnQd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563511; c=relaxed/simple;
	bh=2XfrFJGKsL8Dh2AsqZnRrJ2jJJ1/LivRjCoX7pIqOBM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q2PL/T8iHR8m6HqrkXYZCj6ke9E7PWYYoBwk1UtldGFy8rYYczL9W3e+E0baexDE12tXe1uQcr6ZhEZhWa59mqCOKGdIwf5SPofPUs3FPVMHSX7OpJZy3iwrd7/d5rRuig16DMXBZ8XIaa/h4HUy2a5H5nRZZPpNMQuOQIBG6GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gku1EmIY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tq16MNul; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gku1EmIY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tq16MNul"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8NGmU000769;
	Fri, 28 Jun 2024 08:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=wHukYujYJ65sOdXTFCsS9ODKT3cIGBvi1KJKDgPpRlA=; b=
	gku1EmIYe9a8biAQLi5klCUWtgrXcIWXlrzODm1S3JFg+vqIOcUSj2WvWyxqaW39
	v/zcDi5Yg4Ai20pWsqLswdajRvGuenUv3NjUKjVG8meB17SLRxdbq0YAVVSvSXeL
	TdfE5hlrmn30kpAvowwORfFwXMV7T8yDl8X6vA2J2AwVU042UfCfPEu+GbKn6h9A
	DSF1XxCMCgRUTrasl1DtKSkMTF68FdbLnoquFxjmUZqW+oljUqwM1RybbOexCZwo
	3Za5VdieYVuE077p1Pi0PMxm6+uGHmdkvQRj+TBIZFCaA2g1KcYhOW93/HQG9ooT
	vT5+BnJqmyJvNFRjeLQL6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d7fw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 08:31:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45S7U7Qb001339;
	Fri, 28 Jun 2024 08:31:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2c7312-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 08:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbCW1I4KBnUq++x6YdT5rEtNzink0cSrVt+FLXw9QXqv+75UBn/psy1v6iijegdCtZ7QgWlMD4frtA6UXlHt3qlmpzyqkutK2/NKlgP6OqYPP2uq34Gvibw8DZ2UZ1XSoDqfZ3vv4x3TgKc55d0hB+lFigqpbmg5tJS2GUdlPWGgLU7zwO49U8GyxDcXlsL8E7H9NEMDDx7oaGZfJUtFu5Y1TISupLzrc2W0HyZltM9E/RHSuMQiL2M+JL9lECaj8xTt/rssFByHOHMsttoSh/1Qk56mV0T2wqyaPIQ6OJJZlWM7lPn/mvfODRtgfJhk7MnvqJDIhw6BRsiFNnlt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHukYujYJ65sOdXTFCsS9ODKT3cIGBvi1KJKDgPpRlA=;
 b=abwSJpw3HOh7vxLaNCok6UMBYO6TnQZSp/ms+o9qPgbajUMc03dkVtw7MI1K0INTr75nZmWF/dkKM+vTVPe+AMG9wNz89Ge2bVovb1Jk+nCnlt5t5zjkuRwxc1G1R7niJcSz563LqYyQoKpaJQ+na3u8/IdQLUeX4kQ8PzMPH5CEIYxBWJ58fSA0cduuG+q804co8OORe+GNkJc/hPCmL4Ws/wdSs+bGB8St8Q+EysptyHsi/0TLj+LqLP9wpxKSQQ07vQSbH7iiSfxh7tw1t93cHz0hHiLfljcMuHVtsMtv+SdzVOXykUeYOKo/w7R4hn/xScEvKyVk92bMCu1Vpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHukYujYJ65sOdXTFCsS9ODKT3cIGBvi1KJKDgPpRlA=;
 b=Tq16MNulsHwkENWQVt/IpiAbXt6+XZeX8Odox7jMzcr/kuG4KYpZmrlUkMIRFloA2ZZ6RnH4Dd3F4m1NfmMhr2pPJk9d5SaTtn65PK8hYKdo4g8OalslURhRKJNmShimhtzJPyrjJhhjuQaKfyU0jj8sTsxihlKtRSTrq1OuVFQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB7219.namprd10.prod.outlook.com (2603:10b6:930:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 08:31:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 08:31:25 +0000
Message-ID: <1213004a-c75a-4882-bd51-47d458c67e04@oracle.com>
Date: Fri, 28 Jun 2024 09:31:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
From: Alan Maguire <alan.maguire@oracle.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, dwarves@vger.kernel.org,
        jolsa@kernel.org, williams@redhat.com, kcarcia@redhat.com,
        dxu@dxuuu.xyz, eddyz87@gmail.com
References: <20240626032253.3406460-1-asmadeus@codewreck.org>
 <c1414fb5-f7a8-4cb4-9c27-9c0c9b431f28@oracle.com>
 <ZnydwHhgCbUbkm44@codewreck.org>
 <fc0bff28-eb41-401b-95d4-49fd4b72e5c7@oracle.com>
Content-Language: en-GB
In-Reply-To: <fc0bff28-eb41-401b-95d4-49fd4b72e5c7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af63420-9c94-4baf-e1f5-08dc974cb2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TUVwUWxPZ21scG1DUUlvbDNueHJiUHdTSDduQWRZa3pGdGZQR1RveUUxV1dU?=
 =?utf-8?B?aHF6S0ppTGtIQ05nTDAvcEd0TFpmRC9vNHUxRjV6SjhtQWZuLzZsZmZGT1Z5?=
 =?utf-8?B?WldNdFQ3MUFEVUloSGlrQTEyZ0U4OG9aVml2NGU2cm9vN0pxcERWTkVTRjVW?=
 =?utf-8?B?bUdmQVE1aHV2eXdUVnM4dkYyeEo1dHU3YXhWVHgxbUFheXJaVlE5Q0dWbUVm?=
 =?utf-8?B?Smp6U2hYYmh5aUFRS3plRUZvN3RqMWxwbEZ6YS92Zk0xeDN3T0RMZUNPRjdI?=
 =?utf-8?B?amRKQVdEeUNDTUxBYm1WOGtDbnVUeHlPdDZwYnA0RjZrYTBuZ2MrSDZpRC9Q?=
 =?utf-8?B?bVdSVnIzQUcrcTFDd3N3OGQyckRDclhVZDNIbktFS3NoaVd0VWFma05SQlIz?=
 =?utf-8?B?NGJWSTFGblVhU3p3TUlIK3ZWUkFBaHd4RUFvYU9tVmh1Y3BtQW9VTytWSm85?=
 =?utf-8?B?VGtaNGYrV3ZHM2twY290TGxMdm83OCsxQlNDaXV1QTlHbGxjcHY0Y1EyV1dT?=
 =?utf-8?B?c3J1Sk1rektaVGFzWlhJZ2sxTmtIcHV4R3N5cVdMK3d3TUZlZG15V1dSYXhG?=
 =?utf-8?B?MXBQRFM3RWU0eHJLYk8rQksxeUREZW9rV1d6OHRlaHlzalQ2YjVBNDh0L2t1?=
 =?utf-8?B?M2JwZzRGbENGNzcraDhRZ2pMQTR3dVUzUktxb3JNWFdLajlrMkp4MWFmUHA5?=
 =?utf-8?B?SkZQcmJHbVc0cVNISFBZVWI3bUtvOVpaMDRVODdWRlJrRHpvUnJkNnlwbjE3?=
 =?utf-8?B?amhDY3V1Y1hQWFlpdnNWQUcybk91QlBuT211TWdtSW5mb2FrTm84ZExjWmZr?=
 =?utf-8?B?QnZ3M2FlTVpZeG9lS01sZTdyRDhRQWRkVmhsUXU5VjV6ZldsTHB1a210S2VW?=
 =?utf-8?B?MUFLa1Bhakw5SFAwL1EwWDU5T1RtTkkxem9td01GNDRwK2dHVnhobmFGOUQv?=
 =?utf-8?B?bW81a0xDdWZhSkFrdDhuTnNySFljZVkrQitpVlR4QUY5TW9PVXRGcERMY2ti?=
 =?utf-8?B?bUtpWE1YalNWa3g4VTJYU3R5UE9wUHY0ZWU1V2s0WTNWMWhHNFk2WEZVR1B1?=
 =?utf-8?B?SjIwUEx6dXhrUERRMFhIeU0rYjB3d2lTZ05kWE9uOENKYVlYTnBla1hQeUtz?=
 =?utf-8?B?aDR3NE5heSs1a2NWeWJKMmdEUlhCbWc3WE5RaWhpYXpFeUVDb0hOamFGYVMx?=
 =?utf-8?B?eTBhRHIvdXVqUy9PWDY4QUtDeU1laWQ0anNCNzQ1NllUbmxJWHc5UTZTQVd4?=
 =?utf-8?B?YmtJR1R1VzlXblovNmIvU2tnZ3Q2aUIxTXRJVHk0UTV4a3BXd2tFTnZHemxu?=
 =?utf-8?B?Z1hud2luZDVVUU5HSUl3QXQ2YkhhaDhZYWUwWjAzeXp6czRwNHo1WFlNWHhl?=
 =?utf-8?B?RU1nZ2VhR1NnYjdMVldZSzVqRTZYTzByVnduN3lLVnJOOWNGNjhwcXV4eUtp?=
 =?utf-8?B?VllKb2toMDMwcWx4YVowQmpSNThwWG91ektDbmdXVGY2Mi9WOEVLbmczVmJj?=
 =?utf-8?B?RDRIdnVWM050ZkFNMDJ3ZC9iL2ZUY242ZFRsVWwzcjlWaEdDa3BFZzZCS0Z5?=
 =?utf-8?B?WVloSmFMbDNOZHorelg1cXJuM1BKV0hTZlVvd1lDMEtwYlBrQk5YSHFsUjZS?=
 =?utf-8?B?TDZRUlBDSFc0UEZZK0hZWGlFWDR0SFRKbGJGWWRFMkczUzV4NVJWVGNCcnRJ?=
 =?utf-8?B?Um5UcEpCQVNsdmdXVnp1SWlHMFZqcEJuTDZ5ZndDenIzdUs2WjJNUnpXa3h3?=
 =?utf-8?Q?H8ciGLPb7VmS7U6vp8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHphZnNybHFPQ2p1a2VMSXRpRVFrQW1jMVpXaTRzRjJVb3Nzd0FiRlhza2JO?=
 =?utf-8?B?b3IxaDFlSWFRNTQzMVp5T2lyMlY0ZGpJcDFrOHlkM1M0RTBrTy9rcHp6aXBq?=
 =?utf-8?B?Z29VSHlibWlkcEVvQlVzQ3haNVJqeWljU2M2ZUJkWjk1WERoV1VNb21qQ0w1?=
 =?utf-8?B?bGNiSWJkMFgvL0RRem9qNW8rcGdpVjFITExYMmFpTEp4bXJEWFZlbEs3K3Zm?=
 =?utf-8?B?U2Q4TlZHRnJDMXp4QUZHOFFtK0lId1haaG9NaFdaVjlCdm1uYng4M2ZFc2Ew?=
 =?utf-8?B?K0JUaEs0eVZGbHJuaUhKUjNyWkNmUFo2S1lrYjJlSWpMMXBzZGJLS0h5bElX?=
 =?utf-8?B?ZVJNRDlFem1vbzQ3em9LUytKalR4Z3ZVUXljMGhIZDV3djUraDhoRTR0TVJK?=
 =?utf-8?B?YWF2dGdwMGQyTExLai9ScGhZckNsNGlyNStPcWpNRW1xVUl5czNGWEI0MlhH?=
 =?utf-8?B?ZnhFUEpXZ1FTd21aNWU2MEVHaTFuZmIvYmI2cytnbDhBaERBVWNLRngwYW4v?=
 =?utf-8?B?U2JJMlFTYUxUTW1tZ0dVYkVIcERUK2hLc3A0V3Q5czlXZXl6L1g5c3BBMUls?=
 =?utf-8?B?bzhiejNIazZQOGNNVENLTXVKN09Fa3ZUdDVRV2tOelpOMWtXUFBRcVFxbkpQ?=
 =?utf-8?B?MkJoWTF5YnlOUk40bk9QU0xNZ3pIU3JkMzNmb3ZwZzhsa2NLcEM2NzIvNlJB?=
 =?utf-8?B?dUg3aVc5RVFlZjYzNUNycU1TQndaUlJkRWxneTgwK0Y2Y1dNd01tOUJSZmR0?=
 =?utf-8?B?RkVuTUhtcEZrNVFxanU0dHFzbVp4QlRIWFoydTloVXpXVTdZOTk2bFhWL003?=
 =?utf-8?B?c3djVm5KUXZyREYxN1RKRkp4ZVIrcjhCdllUcWdqNTRCd2NMNktjSG5wS0Zr?=
 =?utf-8?B?dm5kV0VWWGVKZlgzU3g2TFlvZDIyR01FM2FzeUxUN2lGaFE3VDRjTk1oM0Vm?=
 =?utf-8?B?dnBjbmlDR1lmU0F5TzJraVhjSklxV0JEaTArSjUxZnJRQ0RSNUJTQ1VZdXJM?=
 =?utf-8?B?a1hHZVZ2UCtET09ITHFRTjRvT3RvbU9UemtLaXVENHdDOGhVOGZ3cDNaZkpQ?=
 =?utf-8?B?MHdQVm1KbWU3MFlsTklhTGxLQUJrdllpU0JNNDBQcU5XaHcvMEFTS2xFRnVw?=
 =?utf-8?B?WVQ0NExsb0JOZVpRQXc4cTBCNkZ3QVZoMUc3N3J0UDZvL0pGUEkwMDExeUlx?=
 =?utf-8?B?VU14OTlLTGZmbGxPclVTQ1RnQ0Z2Z0VDY3cvK2p3KzQveDRZWFpHY3UzeVVX?=
 =?utf-8?B?QkphMzdYMTJQOXRRei8zNk84Wll6ZU9FZVJkSHhQV2NJdFlZQWlyWU5pUnVI?=
 =?utf-8?B?TU5BL0dzaElSMWNocDZucHc4cWN3RjRnS2FYb1p6NmFnU0RvYmdSaXBpWlg5?=
 =?utf-8?B?U1pJNklZVUV2aVVWM09HajlQN1VsZStKMG5RZm1rcjVtSlAxQzlhNlp6Yk1z?=
 =?utf-8?B?MzFOajFsQ0xmSUkzOENHWGVQd0lLdUtwZUZGeTFSa3VCTC9mb2pOSjFvRlpu?=
 =?utf-8?B?cXpJMnJVWnUvek5QNCszQ1BpMzVURHJFTy96blhmcHo2VFplZWNsMWl2Mm9O?=
 =?utf-8?B?dGVwODZnbEJhMWhFRFlQVm51b054SUZGeXlWbUx0c25kb0E4K28zZStNY1lF?=
 =?utf-8?B?dWxuOGVpcEFRTmExZHJNcFg3UHExQXBCMytqS0tpUVh0WE5VVzRtcWE0bVI1?=
 =?utf-8?B?NWlUSjNzTmhTb2N5cU5jWVhYWCtLSTh2VDVwZXRXR1BhSFZ1STlhT2d5UXVx?=
 =?utf-8?B?SHVvTG8rL053RU9FcHZFNWJxczA3QVJXNWlhUkVCaDVWVnFxZkEyWVdSV1JF?=
 =?utf-8?B?Q1dUUHJZL0NXV3lkZmwxcElnNUVTR0Z6TENYSk5lU2dLTHBiRGJJbmltMGY2?=
 =?utf-8?B?Tjc5OFozZ3pRMmNVQ2l0aEhCbmVrbFExZHNsUlZ0NzZmc21RTWI1VExhWXFt?=
 =?utf-8?B?QUhyUkZpWEVRSTN6UUgvNWo0SXphR09lbVNoM3plU1h4d1pJU1p4djJDVGhM?=
 =?utf-8?B?SUFFVUZXQXlkcThMZTA2bGFGa2N0WHR0cndQSDcvQTRKN0g4eXdSSkRpWWwv?=
 =?utf-8?B?WlBiMlo4ZVUzbXhvTldCUEowTFBTYWpVUG9Ta1AvS1J5QlgxQTRENDc5QzFy?=
 =?utf-8?B?SGdwZmllSVVacnExVjZrbnJjamhIM1JIWkhoRGRmVkZvL3ovVmFsQ1ZrSmVp?=
 =?utf-8?Q?pbIfhKccMDDnx2S1y3X7XFs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jk7UYXIdPZtoGaj3Wt+d2T9KG/paLzbdJBTzsinVe/AGhxV2kNlWRhdN7wED+VeHHyoDh0Au3EtXHIADZE2hhi8RKxhfRL/AHaLLSdVz1O1v73HXN4rM7PdqDf6Rt1BOV+ahPZ8DVFXV4HTPOmqnLfuBQc21DOmT3wwD7xCoRUhaZpzIAf8O408IMT6nrKYqtvkhbcjkHPmzz2n6Xonfl0aaMiw0m1KFZZb9zxLa25OwUVuPvzIEjld4pH40i36e27mp/EZYooTbFBopZoQP1bM08PdIdnoiBB4P7aea7XADWYFWTOquqJsW5n22k818TmgkFeI/gXiWULV7LYvbeE+qHnlUexdc7rV6XjYlJc5A3VCGmZtanL0/c69t0FEu0ovoDUNsvhowGbfL4YQoE+/vLX9Nnlqn3Wpg8lU14YVM/zR/GshgOJZBGjNI2g8VwMgOPcwDq82bU/rfdr2qHqjpAUjpv5Qdd5obIITJHW7/wf3ffyP0PQOl5P9n8QiovqsVsrS8dVKtBy7smobLq04y6N1KejaLvUlfcl2OyTPWjJPIuy3E5l9Ox9iepP+WmqsPm4QUZ2OXKXNlGqsVrQo5nT8tLqYDQ5vhC9O2lt8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af63420-9c94-4baf-e1f5-08dc974cb2d9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 08:31:25.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+SD2OCX+MX6kZ3zMSjilbbPoj1b6okyryz+L54nicRegIPE8rz9+QB/bO4lo0SoM9bsIW2vI0gNKC7dYQ7zGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_04,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406280062
X-Proofpoint-GUID: besEP3YCfmrHKX49I7YI3o-7WnV3evDg
X-Proofpoint-ORIG-GUID: besEP3YCfmrHKX49I7YI3o-7WnV3evDg

On 27/06/2024 18:25, Alan Maguire wrote:
> On 27/06/2024 00:01, Dominique Martinet wrote:
>> Thanks for the reply!
>>
>> Alan Maguire wrote on Wed, Jun 26, 2024 at 03:29:37PM +0100:
>>> On 26/06/2024 04:22, Dominique Martinet wrote:
>>>> The SOURCE_DATE_EPOCH environment variable is used in reproducible
>>>> builds to set build timestamps and is generally synonymous with
>>>> reproducible builds: instead of making users figure out how to pass
>>>> pahole flags (e.g. explicitly setting PAHOLE_FLAGS in linux) just assume
>>>> that the user wants a reproducible build if this variable is set.
>>>
>>> From the kernel perspective it looks like as a result of [1]
>>> [1] https://patchwork.kernel.org/project/linux-kbuild/patch/1443741332.2730.75.camel@decadent.org.ukOB/
>>> the setting of SOURCE_DATE_EPOCH will be converted into
>>> KBUILD_BUILD_TIMESTAMP; I thought the plan was to add the
>>> BTF feature flag explicitly if KBUILD_BUILD_TIMESTAMP was set?
>>
>> Hmm, that patch (2015) never got in apparently?...
>> And I don't see anythiing that'd make pahole output reproducible if
>> either variables are set in the kernel either right now; we still build
> 
> I can send a patch for this to bpf-next if it's needed. But it'd be good
> to figure out the right approach first, more below...
> 
>> plenty of older kernels so even if such a patch gets in I'd rather this
>> is checked in pahole than kbuild.
>>
> 
> I'm not sure that's the right answer though - there's a bunch of
> existing infrastructure in the kernel tree that relies on
> KBUILD_BUILD_TIMESTAMP, so to integrate properly with the existing
> kbuild infrastructure around reproducible builds feels like the right
> direction to me. It's a bit more work, but not too much. Arnaldo may
> disagree of course, and he's the maintainer so it's his decision - this
> is just my personal take.
> 
> We've tried to explicitly enable flags in pahole Makefile.btf so that
> it's obvious from pahole invocations which features are wanted, and to
> get that support on older kernels it would just be a matter of
> backporting the
> 
> if > 1.26
> 	use --btf_features
> 
> ...patch, and a patch for adding the reproducible build option to stable
> kernels. Similar has been done in the past for other pahole features.
> 
> All that's needed here for bpf-next tree is I think is the below 3-line
> addition:
> 
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index b75f09f3f424..40bb72662967 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -21,6 +21,10 @@ else
>  # Switch to using --btf_features for v1.26 and later.
>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j
> --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> 
> +ifneq ($(KBUILD_BUILD_TIMESTAMP),)
> +pahole-flags-$(call test-ge, $(pahole-ver), 126) +=
> --btf_features=reproducible_build
> +endif
> +
>  ifneq ($(KBUILD_EXTMOD),)
>  module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=
> --btf_features=distilled_base
>  endif
> 
> 
> Can you test at your end if that does the right thing? Thanks!
> 
> Alan
> 

FWIW I verified that with the above change, and

export KBUILD_BUILD_TIMESTAMP=$(date -I)

...the feature flag is added to pahole and as a result we get
reproducible BTF in vmlinux; .btf.vmlinux.bin.o is identical across
multiple kernel builds.
