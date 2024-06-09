Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299EA3F
	for <dwarves@vger.kernel.org>; Sun,  9 Jun 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717924253; cv=fail; b=Z0+RJo+rAlt8VHzSm0D7xuzllHky2YZKEXSWn1QpoF5TdEVgDy8VK0MVhx7zElGNW4DVTBew0Z7CTjSXiMrHw9DQpg58AzTi05RbbsSH3pl1wKAD0mQwiVFAjqSwrePOFaJkyxQl10ebHmA+WtEYnH/360W+4IxtPm4tFOd5IYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717924253; c=relaxed/simple;
	bh=n5SF/bGVPg+0z8sAAHJKNVef/FOExW6W0/zmWgIboHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGAT2n8ESxjOayYRZCyRTIwKQiwBITAT2tZRVRLMmQT1GXXlG7IUv6hGJL4x0iChJG8MreIdbTBThdOdJdutVNBHLnkQl0DnOicnfbmGw0qsNpD2feiNaxMO/N6tQNonFGX0u3PI7iL+DXF5vTQNuzrvls5BC0OZEccUGlcg2Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dLInX7m7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a1ORXh7t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dLInX7m7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a1ORXh7t"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4594xHle007794;
	Sun, 9 Jun 2024 09:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=6qQCi8lY9C+uTPO2VFZmF9bw9g5n+s6nsbuFBsLYwoA=; b=
	dLInX7m7AYGPvWrdF7lWSV1RKtVh5hiUvK3hXYfZ8RO7eRtlcxSEY1fK+KKrkIF8
	GrG+zDcSdUcTGZT1JFZ1zpMkqS7w1o7sSa+PgbSAz2Hj1+kho0LSrZ/XsZ3lCkBl
	GVaQsM1gsB9G+aDjz+3/idiGKWJtF9P1pFglisrPkMq3yGm6+frFpje/lAyKfUjb
	8zWAqbhXtgTnEMnPXkp3QoRkMO5cW4zEDi/Q/L+1DcYQCX3hl1lGbAMDkGnsUuEx
	egPTVh0Tdi4WIObuuBCL7FjGr17gs13EcWP5XmniMdkbA44o17+k4GfjUKCneDLl
	XFNgd1HyaSaaNNg7kLcQBg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhf191mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 09:10:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4598YnVs027302;
	Sun, 9 Jun 2024 09:10:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ymdr5fn0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 09:10:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DezTd4l3beWAsjONU8njYfVgHoBc5EYKRvTzv/Duq6zrhsVjPKWRa1KrRA6XNiFo5SvyUGV/+vzo7SwKhsTexKnO3s3WCIxk4ZGBV1w2nqUoKIxBINobcVacpq1skrXdByrjVyMTN62HiA2KtA2HxI5Zl+iUSqsVSuW28/Xpq5kJMQCbOa/o0HckKWDWx3LPc4GadPNgpaGOqOPujQ1OV2VV3FoIC6SV46Lv/+ocu9EpiYHqGTJZuT2vNMUjnFO94nJqEkJvQv96QONeBLn2nfnkggmYmZ6UX9beMC6M+P0vPJytdmCsopbwAe5Y28qseepxoyTrIg9iZLpBZZfXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qQCi8lY9C+uTPO2VFZmF9bw9g5n+s6nsbuFBsLYwoA=;
 b=jemTQ/Z+Uunz+F4NTk66kLvAoH4Yoh1soLK/hHmo8pAF46KW0ziWuVylFGUN3XBpcICIXuqgD0oR0425nMQWrxMKzS0RLIvahIhr9O1TKV3LHGvDf8+k7K1nDibG+wJ+6wh8gxFUn+LNXJBdDQ9PHlNXxuNKh9/XSdBArQrFxfcRL7CacUtnaZzjgNw67WaKOFzoum/kIQxULL4LRF+5TnkUaw8eyMPro0OTILi14C762vMzPiy7B+m5Hv6RgwdwLEVjBlf2miqGDYJuZLdwG1xJAtakXeaA8ROa8cE4Y+/npBF9Cwhb+Xco3ydP9fVDmXK2tlsA4bkigiFArcbfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qQCi8lY9C+uTPO2VFZmF9bw9g5n+s6nsbuFBsLYwoA=;
 b=a1ORXh7t1PCgvJoOdDJL066zmf0EDVuovXeZFnweKMoWopiYYIpFBE5dn8d0tUbbw8mzfIoty2rvKKz5LuDMEF3p5EqT4X8nUBMddG9J8HZqGuNREqu86+njfc1xD2tpFRQoIJR/anqS1jijTx790eV2UK2UjhuQ0ocAaV9OlFA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB7783.namprd10.prod.outlook.com (2603:10b6:510:2ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sun, 9 Jun
 2024 09:10:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 09:10:23 +0000
Message-ID: <ebd66c51-b851-4108-87b8-9856283f13ac@oracle.com>
Date: Sun, 9 Jun 2024 10:10:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: RFT: Prepping up pahole 1.27
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Matthias Schwarzott <zzam@gentoo.org>
References: <ZmIXxgbfIJGWmXer@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZmIXxgbfIJGWmXer@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0295.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::30) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4285f3ef-c7ba-4ac3-5a57-08dc8863fe05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UHhRUlpzY3BhQWR5VVNWZ0VQNGhKMk4zbnVYVGI5ZWZGelZQSHA2dFdtT242?=
 =?utf-8?B?dnR0TWRsSUNaUlRjUGEyc1o2U29RTkFiUmM0dktoMkNYMWltcFZCODlaelln?=
 =?utf-8?B?b3ZkdVVJK0VwZmRmME1Mc3VvYkpqRzlIeXM5Q1RKSjF5Tk8xRi9DOWQzMGRk?=
 =?utf-8?B?NHRWVGNNZ0U1dmdRODM5ZVlhSmV4YkcxdHZ6by9OTDFJb1ZXNXlyYVduRzNP?=
 =?utf-8?B?YnhCY3JpVGMvWmFGbXRzZWhRRFVXc3dUdVMwamVFYm9EZU5TUnJZQzB1ZXh2?=
 =?utf-8?B?Y3JhUS8vMDRmVVdhRDhhejI1WVlydjRSRGN6VVF4UytBWWRsTGNVbTdBOU05?=
 =?utf-8?B?aGZIVjhPTnA1UmllMGdkb3pkQml3SGJTek5BQWRKekc3cFhzSkpOT3ZWckE2?=
 =?utf-8?B?V2QrdCs1bUNBRGpkdmtYZjYvcmJObTFRUmFsQjZlNTUyUnRvQXM1L3hwRWl1?=
 =?utf-8?B?SWRMamJKcmkyNG04bkZ6MWd1WDEvRjNzMWZaZ1dJclplbXYyVmlQbFBDRDVZ?=
 =?utf-8?B?RzgzMUthbklTUDZpQ0ZLRm9sNmdNWElIU1JHT1kvRUJlZDdXckpPaWpnbnlG?=
 =?utf-8?B?dForL3JuMmJPd1E1a3RPY2NRUHJ5dllnOVJWVkgrejJSOEloRjZ2eUN6dGM5?=
 =?utf-8?B?V2JzR3ErekVRN2VUWTVMWWtsWEhqdXVvSklySURpTVBkNkF4eUcwZkp5Zk85?=
 =?utf-8?B?QlBOZlc4NVZ5VHhhQko4R3pVTVYyeEo1NEF4d24xR3RCU1lXUDIwYVI1MkZ2?=
 =?utf-8?B?b0UvdzB5VDNtWWgrSFBpTE93ZUR5QmNNYkxjTkRFbzU0ZVJPdHl1MlFmOWEr?=
 =?utf-8?B?MkUyNk9LVEVvaFZtQ1I1U1FXMHY1R0JFSU96TXFXTDlJRnQ5bk4wRDhBd3JY?=
 =?utf-8?B?WEhxSEZNcDBCdmFJZ3UxV2tTSUhSWFhZZkZXOCtKR3JQTE80RjFkNm1yRG55?=
 =?utf-8?B?OGVQNldJUm8yeVEydGRyZE5vVFVXTml2a0h0Z0tXa3JqMGh4ckppSUxEeDUy?=
 =?utf-8?B?dE8yYlV4ZVRadXFraXVrQXNPQy9velFDbTk5Z01kVUVibUZXWWg1aDV1eU1s?=
 =?utf-8?B?QjFzRHM2ZzZIU2xPeEF5YkVVY01lMkRQYUQ2blp4WnJHN2xiS2Y0QTJyenpM?=
 =?utf-8?B?cDY1UUhzcURYWVlORkZ4VG1KUmJNK0lrTEErQmR6ajIwNlJFV0hOWnhkV0RR?=
 =?utf-8?B?S1d3VW1FeEo2STRFOG5OK0daMEN6dFdmbUVnQU1xem9lclpwZDVaSjBXWGNX?=
 =?utf-8?B?SFJxQmJoQUVTSU5DRm5SY2RyMVdqNDBibGZIUU5CLzZzNDhIVGQzMjBZVFJv?=
 =?utf-8?B?b0pWaXF0NGxPRmhSTGF2VVM4R25WeUJ5WWo3Z1VNamdSVzZPV24vdWlvenE3?=
 =?utf-8?B?NGorSWhCUUlyb3E4N1FRbmhnTjY5UmZlTnZLSnZvaDU2MW03aDhTOTQwM0V0?=
 =?utf-8?B?NFlRM2gwTWkyWHZpZ0dDY21zZHFKQUV2RzVydjR5ekdsZUREK1JiTU5QWDRy?=
 =?utf-8?B?T0NlWXI5UHplZUhqa1djNmxsYjZoek1xRHVtcHh4NFQrYlFpRnVsRlNaZ2Yr?=
 =?utf-8?B?RElHMVFOY0JqMGkwU1pEZ29hS0JlQTdDcDBUSFlKdmkwYnJFVE82cDlwMm1i?=
 =?utf-8?B?R3FHRFBEOVZPaExzbTlIOFN0cW1SdlNSTTRvcE1UWlp0NHdaY1VVN29jM0pH?=
 =?utf-8?B?YWpZNnBuMzRrblZiUDlXaU5KNGo0MmtzNmhMT2xoQkpndE05amVFSG9Ca1lV?=
 =?utf-8?Q?u60UNkNK5XXfpkC6BFYNDjGUxEoVal/00h7pf0b?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTdaeTJOOUZ6cTN3U0pXUGdnUFhzdTVIWW9mbjcxRFJaZHE2dng2YngzWTZj?=
 =?utf-8?B?enl1UXoyYzdYTEptaXZ5N2ZmOFZGbTVXTHNLUzE5NWpuRkV4QUxVVlpHTUFl?=
 =?utf-8?B?QWhDVWhuUDJnZEUxU0J2ZmpsaHdvVVNtK1V1NGJWWDZwdUVzalhISmVSSW5L?=
 =?utf-8?B?WHdYaWxPcHdmTlQwSFZrQkFOQ3FjNVhrRHgzbnN6aFF2VnM0Y2prTkF0aGp0?=
 =?utf-8?B?TStxKzBKa01UV0hrTUhRSnUyNmtIN3d2b1VhS3orK000bDVrdmI3NXBDSVNh?=
 =?utf-8?B?RitTejRSMVRaU0Qvb0c0T2NmNmhyeXZrL3IrNTRIK0cwR21YcE1hT3RSeFhl?=
 =?utf-8?B?MllyRkdJTTA0Zk9iaVNkUFNxN21DckNsT2VZZnR2TXA2WWJkRThBV3MwUGFM?=
 =?utf-8?B?LzVCU0t5b01zQjEveThsd21sTHBTVTJCbVN5MmNJd3BIZ3Q3ejB2U0ttcVZ3?=
 =?utf-8?B?ZEx6czlZclFEbHQveW03bXZwUmRaN1F1WURRR1hhYWdlWlhqcUNUNkdzSHV2?=
 =?utf-8?B?RTNzQTlsVHN2dmxzOGJTMWZqVmlLRGE4RE1HSU4vU1k1VlJ5L1FhUlVDc045?=
 =?utf-8?B?cE5tek9JNFFCTHNabk1GSlk5ZDBiUC9qczJoVEpCejBjcmcwbjNUQjlqcFZU?=
 =?utf-8?B?L3NZKzhncEVtYlNGMkMyaWJqR3RQc0F0MHdvNkwyWGRiNFgwZEZsYU0xUCtJ?=
 =?utf-8?B?V1FtVUFDZXZucVkrQnBxT3IzRGlpMTV0YWJJcHRJTm1lK3B3RG9mSG5BamZl?=
 =?utf-8?B?YmQycUFGTFlMckIza1NtZWZqazZJNWE4cEowRTFFcEtJK2FzQ29CbFJkZEJT?=
 =?utf-8?B?R1FwRFgyR2tCRzQ3T25QZWZlNXU5NDA0Sk00MGR3MTNIS0J5eHBnS28wN0Mz?=
 =?utf-8?B?c1FhQXNSM2JDRWNkdDBHejE2SzZvblpBajlxWlhpVkxQR3RycUk2WTJqMjNY?=
 =?utf-8?B?dFVMbTlUODQxN2JCNk9pRlJEakNjMUJnVWl2MWFTR0w1NDByVVBnbkQ2UjNY?=
 =?utf-8?B?d3NwT0M0bWN5d1BhbHlvMjY2SjhFaWVXVnB5T0VLOStwOXZ3VENZZU1CK3ZM?=
 =?utf-8?B?TmZCRFF3YUsxMWZOdk1kT0xJOHFjZGhvZTRYUXYzWGExQ05Yak4wOU5QcnFt?=
 =?utf-8?B?bi9zb2M0aCtDa0twL05kaFA5YXpaUkFuMVphM2xWOWpPS3dUVUdtUlo1aWZG?=
 =?utf-8?B?R1B1eEkvdXZhTFBRTzZSY2dKSDRmQ0FiQ3QwNkdSUjNkREl1L3B1MWg0a3VP?=
 =?utf-8?B?eFpSejBCcHBJWnVYMGcxRE9sOURoczhzMTJadUowcmZudlZ6L0FmZGNxY1k4?=
 =?utf-8?B?cm5GZzkrYVVYY1NDenZtaE13T2hSV1EyazlLVC9MTDBBOUM2dTUybjZCTThZ?=
 =?utf-8?B?OHdCZzN6a1U0clVNYkk3VkNKWHppZG1BQ3I4YjA3aUlmdmdsVzRXVWd4bG1W?=
 =?utf-8?B?cGtRbnc0ckFsYTdUMGNlSE92R3lkV0FYckdON2kxL014VHpHSXRHTVRVbm5q?=
 =?utf-8?B?eDVPWmhzUWRqcEsrMnpFMXpUZ2xGYmFKcHpFYURCRW1rbGJVUTg3VGlOampU?=
 =?utf-8?B?TkZtb2t5OU9HVFptbm9HT1RYTFkxdmNZZ2ZOOWx4cHEvUExmajRzTzk2UWcv?=
 =?utf-8?B?eDgvTWprRzFkTWNKTnQ2Q3l4QkNYR2p5QTdrQklzVUQxSHd5ajFyYlFYa3JF?=
 =?utf-8?B?WXgyUkpKQ3c5bHNyU2F4Z0YwV2tpNXBHYmJ6Y0R4M1FFWXB1Z0pGSzMwc1M0?=
 =?utf-8?B?RFFKcFJTanJSc1dNUm9vSCtrd09SVWxlanZnTGo0VmFScklDNGx1YlZIL0Zm?=
 =?utf-8?B?R0s1b3BaQ0VRdkdJWEdxYzZ3Qy9oVmRCVmxlQVVxM2lnMGdudmhHUHVZYU1P?=
 =?utf-8?B?K1NLZm16U0VNWGxDRGxjdTNaRjFBV2g1VDJOUzZDQ3BHM1Vlc1crTkViWkk5?=
 =?utf-8?B?R2t2ejFnS0M0L2xFUU1sazBYMkJjMU1TK1QrSmFyRnhTNis1NW9xRndKbXhx?=
 =?utf-8?B?M1hmVlhrbUxoZjhJekt4NDRaTmFnUkxQQVFZOFBaVnA0OVhubTg0czJCM1Ux?=
 =?utf-8?B?cUNNR094OEhvTFZOVnRrRXd2ZUZ5cVJRM2NNWlB0MUhQc2FleFhaV3dnRmp4?=
 =?utf-8?B?dE9xZGpQNWxSWlJnR2NXU0k2NnhDbmxlWHNXaUhQUEU3R0VDWHNvVXlxeDBH?=
 =?utf-8?B?UGNFRWFoVDZ0UGdLV0krWUg1cTAyN3JBKzF5TzZ5TStkd3czTzcvWnBuZ2Ex?=
 =?utf-8?B?UHl1ajdHZ29SSzlaZXBpMGE3Wjd3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MkRgD5OnVngnxwMSiOAW3+i1jOKICW/I2Bl7Vennu6vwo7l7X7HtvEytO3Skqe4gCCvlUl8/l88B3FbEmbe8pvN0F+wdfvCya/3sSKA3jFk6ZRv8JEKQ5AE0T1oIcXOujC6k9nH8JNV0wImjzGWj69smL4doBKkFG+xQkYfQ9SkTgdhJS4MXe6obvH6IatNei5kB/BllSFc4zdj+Xv2ji9MYvWgZHbM0Zoi7hBexlfnGpw7kk+zRjRxV6NTMiviwELwy0aijP3m6IvGhVbr0nMruelFiVQf063TlGu/2noMrxaAMmlNxKBw7YXzCwjVdpu4MTi752tbtN8CQ1yTvot9ri6bKiJJ1evGYVw6n/qecOeAVu9KkDj3DVcYwyH7G/JDhPZlZ7uP4Qs++scSAIFvljATSdQNeGXTGbV+v+9ttm91jMFUd+SgB37zTWgCPhETK9+9M17bRyQ/kNpI7xrbi1e+f/znyg2PvqPekRw9JJ3Ks3beVmCq0Bjg+LcMv6McOatVOakTPRUsiEajUqxlH2iMHJs+TmLMUpngf6BRxF2dSLQ1HRLjsGe8Uk5NRVCHenpTG1RQhH0W2ldpnSDkcm38V98PQ75n5Cpd5+UY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4285f3ef-c7ba-4ac3-5a57-08dc8863fe05
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2024 09:10:22.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImAZ3lOlayLEwscdeQEsiHpQvcJE0Kdre+GGCeZJ/w5/fhcPQ24d4nknbPa6m50mW2/T5SQDsT4Ye4kBMIWQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_05,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406090071
X-Proofpoint-ORIG-GUID: m9cLTsGWtDWbx9gjLH0Q0PNzNH-Pm4yr
X-Proofpoint-GUID: m9cLTsGWtDWbx9gjLH0Q0PNzNH-Pm4yr

On 06/06/2024 21:10, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	I just pushed what will be in v1.27 to the 'next' branch at:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git next
> 
> 	The changes file for what will be in this release, mostly
> reproducible builds and tags for kfuncs:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/changes-v1.27?h=next
> 
> 	I plan to move it to 'master' and release it later today, so if
> anyone could please do some more testing on it, that would be awesome,
> 
> Thanks!
>

thanks Arnaldo, all looks good from my side. Tested using bpf-next
kernel, adding decl_tag_kfuncs to BTF features in scripts/Makefile.btf,
all looks good. Great idea to add extra DIE offset debugging info!

If you need it somewhere,

Tested-by: Alan Maguire <alan.maguire@oracle.com>

Alan

> - Arnaldo
