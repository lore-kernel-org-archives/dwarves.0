Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180B946C;
	Sun, 15 Sep 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726399591; cv=fail; b=YrioXwli3cn9dvhByQgoBH7w1dLuK/tpysVoG75XNovqZek9qrbl+utm025INWrYbj1bD341sw/P9IkebHMd7+t7SENKRQ0xDJnV/jGrqlUg4KjN7BG/4uIKzflL4IcvtI2QpXCa+yTRdFnhD3ynFfuKgIE5RnfOqzMYJQcJZ/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726399591; c=relaxed/simple;
	bh=x2zUgww2ad6AlzSakfPoqyUlKT1NsMSyWelrIVN7eik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nUYs0Rd0DEeFNnU4QtooeCxIBt9EqEIjEtIg01gD+4M/8RL4m1NE5j9tT94V4zy9DBM80vPMOtLg4YI4iUaUVlrdiofBN7apGgkrVIF+apJ0qWScRh0+/tB9/6wcsDDYRHeUe/nngcWJD18ZqdTiNY/hR1gxyIdISeSVjxZNRoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n8m3yTsL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PSkbZoYc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n8m3yTsL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PSkbZoYc"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FBKsda027810;
	Sun, 15 Sep 2024 11:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=sxUUnvORx55EQON8N1x5EyxqzT1ZbmrOmZP0atefp70=; b=
	n8m3yTsL4bX+n3J7FoPqKKemK1MehUWC8SkZtOx+Hks6Fmaxtg3cTDSAfwWTRUWL
	ueWD1iDHRPpA4WwQv1EEREhRLL4AgjdKZI5x1B2laP3BRtxboRwHS6otBi969Vqk
	T3HQd7KbrftZ+sSksgMgMLdq9xAeIF3kRYKFC/dMjm7vOp1wIvJ0TamqTYdC9FpG
	t6zgBg5PxvcCejx8MGf68yH/PhL6HJ5jhA/qRWN0rH/esBP3VCjW+/NDFAnmBTd6
	y/oJF+Y5C+ZTGqnXw7hSarcgPCJKTKUBAa7KsZUnc5KrIIXLhNiGrR4WDIYbEE8w
	N95q/chSy+56XCe/SS17Fg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfhj1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 11:26:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48FBP6Ap019386;
	Sun, 15 Sep 2024 11:26:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6tr2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 11:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQcy7FiFHpnY/uw5QvCc8/Kg0/Tpa0ZgCEo+ornk+8ZfTZzBvpGNlhre+JQtToyzMhTce5OE0+tScqaWoQGwZPb/dX/jZYxcgw+hKHa5AsroFVS14YgX2j+Mg8r+Lv+gaZf9d4t/0BZlTA3+eSEm0nwsef7QfsqomDggp85a660IuadEnJoleUSQx/EysorvMbttpm0+Behe5rqYlHqvV5jBIJNIkTPNjny+LPa8kVw2ATBDAkjR9TBM6tKjXxx4JUmfd+xSG/Sfryhn8hHrIDbarHvB56Ql7DPhJlfLPBKp+OhEwmzb2I0TqJHr1x2bOuqbzdpRC9eaVn/UNXy06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxUUnvORx55EQON8N1x5EyxqzT1ZbmrOmZP0atefp70=;
 b=sAqfpJw5YyPsnuElt4cEzeQPEkmZVNmBWtfMnEvCkY/bFwjvGRAimTLaGOEYahVLIBFdamgC88VYHx16zqz7xV8sCrrR+Q0n6FsveMkbHU//MSUtvkyKETJpY1EqZIJSedZbenJgq1rBsriPIq5K0gW0GXKcFntS9meo9fIc1izLIVQLhipYkrXlDrxq+jqenQaa3pPbnslZ9EcnJfjKgkwj7y0AsM0DRt23X/NIa5S11B0jjH1iQ811OlJDRVUuHBB0GvFgYiBNL/Jz7esHn6sJ0b46yd5Ic3oV/pCxicfg9+giwQ892bxsKe8KdHdbFgQsoGMl/CZgsDNHat0Mrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxUUnvORx55EQON8N1x5EyxqzT1ZbmrOmZP0atefp70=;
 b=PSkbZoYcZoqRW5Q4mIzF+T1ezJJAEk9djZYJbQbk3Hi2C40bU7A8boVA62ER1UaS67LNEEI0OOIrCgEJdnFSddqPNP1t2fjpB4Y2wBXP16DnNmu8jcnEMtGXkoPA5raMphq9kDweeVTmsT06fL1fu1pF0sZIflpYixUH25oSa+s=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6987.namprd10.prod.outlook.com (2603:10b6:510:27b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.11; Sun, 15 Sep
 2024 11:26:11 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7982.011; Sun, 15 Sep 2024
 11:26:09 +0000
Message-ID: <2731e6f3-f53e-49ed-b2fb-ab4873547df6@oracle.com>
Date: Sun, 15 Sep 2024 12:26:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/4] btf_encoder: cache all ELF section info
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
 <20240912190827.230176-4-stephen.s.brennan@oracle.com>
 <bf2a075b-1f30-475e-9d64-c96bbf646454@oracle.com> <87wmjfmqkw.fsf@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <87wmjfmqkw.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: fae086bc-4b4b-4c49-e299-08dcd579329e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmJLdDJzRHZGbURLcUZZOVBhS25xWkpZZU5ZL041dmcyUGlXZGN4WlBVTGJ5?=
 =?utf-8?B?RVk1T2RYVjNkUkVwdVFyWGQzYXVqdUhYdXpLdWhiNk9SWU1QRzJWNUZiVE5C?=
 =?utf-8?B?NkN2aDIyVkJrazl4UjZuMEdpdmNXU0tEVnRWZ20yQkxrbktib0J0VEh5Q0Z6?=
 =?utf-8?B?WnBxUnNZMmJZN0g2aDhYd2k0K2pQMDJPTkdZYzNybGs5OXQwd1VhYUxBMHJN?=
 =?utf-8?B?d3RTL1VnTEIwTjh2OExrc28xdlRXS3YxYjFUSFczYWhFM3FHZktucFNORkl1?=
 =?utf-8?B?Z3MwODRPUFFXTW1HczZHRGJGSEZMSy9QeEJaSG43YXJmejZ6VU9TbHVnNkpY?=
 =?utf-8?B?YVd2YkRQbUZ6R2x1ZnRQSG4xejBydW9PQ1kySExLMzFxcWd6eFFpR3dCU0VV?=
 =?utf-8?B?VmlHRzIwcGhXa0VlUjY0bWRNRGF3UW0zS0lFTEJ1bldKUFRSSC9ORUp0ektx?=
 =?utf-8?B?V1pWN0xmRGhaZ3NzbFlERWdOQk5naUlFdHpQelNIUnBCWDhzenNnR2RPdDho?=
 =?utf-8?B?cDFqeUtCbndKNTlaWCsvZU1BS3NuZUhTQjIzTkl3SDJKdS9MSlpsNk9wYUYv?=
 =?utf-8?B?aFFuams3dmJwVjdRakFWa015cHVJUzgrNjlkQkk2TjBsbDhTK1N5ZEpIZ1g0?=
 =?utf-8?B?Rks0MWE2VlovRHQwZldHNUxTbEYxMWF2VWlhQU5CbVM5SHNKSWZUNlp0UDZL?=
 =?utf-8?B?a0diY1N2VXg1OUEwc3pFcXRLVXcrTGMrKzQ5V3kxR3lzNzRzeEYvc3V6Zm0r?=
 =?utf-8?B?SElzQ3VadEFSbHZKay91aHAvV1pTV2NiYnlOMUtsWVFiOVY5MU12ZnJwVUxQ?=
 =?utf-8?B?VVB2L1JDaXRvVWM3Zmx4MkZOWitMRDhsNGpZZ282dy80TlNneWpPNDZCd1pG?=
 =?utf-8?B?eERveXZxR2RxZW9sOXJjYjBPVS9WQ01FMitsZFlRWTY0YUJWU3BjeHRHQ3c5?=
 =?utf-8?B?Z2V1R25BZkNKMW5jMXlrQWVtRndJZ1BaWHhQb1k3N1J2OTNHb3U1MDJQMTY4?=
 =?utf-8?B?SzZ0NW1TbTEwak9FeXFneXZtM3pSR0duS21kT3ZRR0ptdmk5YTdWUmRsQ25x?=
 =?utf-8?B?MHk2ZDRISXlWSDlNZ3IwZ3dmQk5DMjFYbDJnRWFEamtEdmtKc2ltSFV3WDRX?=
 =?utf-8?B?dUZ4cHVvbXV4TkZ2K0JibzFMdXNNU09INDFTSWhZTC84aytobEkzZFVxWU1X?=
 =?utf-8?B?Z3FmSkcyUkNZM1ExT2NVUndKTHFhRmJxUW9POURuRjc5bjFnQ1UwckRqTU9B?=
 =?utf-8?B?eUZGb21VYVlFSUd3eGE0VjdLem04TXRsOUh6TVo0d1NJQXhMQXdMQkczaFpm?=
 =?utf-8?B?OXA0T1lBblBhTVhCVWhIZjZScmpvSGUxcDhwT3duQkpjTHRWMVFrL2ErMDJH?=
 =?utf-8?B?YjR5emVMVFcyVUk1STFHMDYxY08xUXo0a3RiZDE1WFE0SnJ0VXZ0bzRnNi9D?=
 =?utf-8?B?RXdMeHNVTC9Heng5dXpHekZtdG1kYXBUbkZKb3Z1OEJMNjJhSDBlbUJRREZP?=
 =?utf-8?B?cjNYeVdTbXc5K0xSNklnT2Nvem10N1AySGs0SmM0Ry9CWlN1V0pJTWhYWjI0?=
 =?utf-8?B?cXE3QUx2WTNPU2ducitTQ2ZKUFB3STJGcnYxdE1KNEFTQVlmcjU4RUR5UGtW?=
 =?utf-8?B?TS8ycXRKV092TXllUVRTVWR6cHZlaGtvTUJ0Wi9FVmdtYmNQVmlkaUpHTUVG?=
 =?utf-8?B?Sld5RjVlN0NrWnJPejJyVFBIdmRuTGpEaHBrK2V1dHNOT3Y0dUE0TGZ3SWFq?=
 =?utf-8?B?cXJYNTcxZGZHMXB0Yk9rSHZpWFgwcjBsZ0ZwNDBJUngxaXZ6eHVva050RkQr?=
 =?utf-8?B?WGEzQW9NRFZ4QndPS2NyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVI1bCtHa3RzZTArMEo3RnhIVWdYWmFqSW9ib2lGQ0FuWEdJL3JQSzJIWWU0?=
 =?utf-8?B?NEt6YUtEWVIrcElrcmZ2S3FjZDhHWFVGZVRjMnhMM0Jqd21xWHYxK3ZkMDZO?=
 =?utf-8?B?eHZSNXR4d01sbENJNVZLN3RkZXREaUp6VmV0WExNQnhMMHFTOHAwbXpLcmhq?=
 =?utf-8?B?UW5ZTXRSVWY2M3Foc3JkTU5iYnE5d3RVVkcvL3h2OUZVK1JuQjZadWxnWm93?=
 =?utf-8?B?SGMrenM0VWJOQXVqWHFZenZlU0NiQ2lhV3RFVHB0WXNSZjRoSVFveWxSdlU0?=
 =?utf-8?B?eVYrdWRXMXNCcmZuR0dpQ1E5bm5FNGRQWGN1ZWlnNkhXcDNHWFBGTWc4Mlhk?=
 =?utf-8?B?VllDS3AvT2lvYTZwVnhlNUJUNWwxOXdzMUpwOEtocVlkTTNnWVMvem92WWpu?=
 =?utf-8?B?U1RJSUpBWU5uWUF5cnpCT2dzaTJoRkNEQ2huTWZRUm95QjFpdDlzRmJUemFM?=
 =?utf-8?B?VkU3bEExMkpYYVRCOXBxa1luY3M4RXpqV0dxNVROWm5GS0NXd2VMaXZoaXdu?=
 =?utf-8?B?Y3dFaEpWVzZVdCtyTHgydUI5V2V1NXBYYXVxUEdETzRxR1pOSnNtcjRLR0FD?=
 =?utf-8?B?TDdGNVdhTjRobXRPT2hqYmprb0laanJRbmV1bzNac3dLdUxNYjViM1RaQTBP?=
 =?utf-8?B?SVg1c09xZHF5Zm00Yk1mczZvUEFMamUxUnlKNjhIekkxMjBtQjN1cFdYRkd3?=
 =?utf-8?B?aFh0RldoZnBFckNjVWxaSE1udkRRV2NzaTBPbWJEMGw3ODJITTE4N25kQkNW?=
 =?utf-8?B?R0JZUVprTUxDOS80Q1FZamk5K20zSHFEZTBiTEt6QWpYK0FUVGYwY1g1MFQv?=
 =?utf-8?B?M290NG1INlRDSXVTRHZ3Mmxub1pnRGVTbU9sYWtwOE1FUHNmeHV0V05WNElO?=
 =?utf-8?B?ZGg3SjIzQm8rNTJrRHpaYXdpQmJ4c1JZeHNHRkgyMDJtaXhQQkhiWXhJOHk4?=
 =?utf-8?B?WDVTRmp5Vm5Fb0JFTXJ1STBPa1dMVmY2TE9ybHowQld1UEVselJPZDhKTlM5?=
 =?utf-8?B?Z0JDOEdPQnY5SDZwbFZmZG1WN3RKemhZa29VNjFqYXhpZHJiZUlORmNWb0ZP?=
 =?utf-8?B?WjdmVTl2MTRyTTJNOVRka1A2dEFRS1FjSElZUTc1d0VrcHF5WXNMWm1FK0li?=
 =?utf-8?B?Q1RnR1ZMYjN5T3FwVXRkUGdsYmV5ODRqZUd0Vk5VOVBoaUQ2akVpYStINk5t?=
 =?utf-8?B?cXpJNnFZaEFtNThSbHg5dDlmZ1ZHdENDY3lKc1AvTUJuV0poc0hrMDZvSk9u?=
 =?utf-8?B?WkYwdW5aMzcxRGYyUzdqQXh0VjhIajlnYVlUK0p6Tk1UVm1MQ3RRL3U3NnI1?=
 =?utf-8?B?RTNOVWRlb29kQlVyanhEdkVJN1NQSkpjS21QdGpzVFdCd0tjZGQraWVva3Y3?=
 =?utf-8?B?QWlXeWY4ZGZMc0Vnc1Q3UVFyd3FUaXV3R2VwbzE1Ti9CMHphKzZ5Q0xNZi92?=
 =?utf-8?B?RmFBWGVkSGU4RTkrMDkvSTdYRHJTdmdpWWUrUUt0L01lamVxVDhISDh4OUJU?=
 =?utf-8?B?UHMyVWhhbW5wSGY4aGRXUlZjaDhvWlRkWktkS0xRUk1IaVhpN0FRdXgrU1do?=
 =?utf-8?B?ZEFnSzVDZUo4K0kyaGs4ZWRNREtlU2Z4NmRGZ1F6UlZ1NVREejNaU0MreEFv?=
 =?utf-8?B?bVlWM1lQZlZpcGRqQ2MvSzEvRk0xcHJvcncvMnhvakxYTE85M2k0aWNxVENI?=
 =?utf-8?B?M3R4M1YxQVlUbXdSZkZ0MDU3TzRkZDNaMHhNSHEzSHZCQ1NZSlFOa2JPTmlx?=
 =?utf-8?B?VHkzZ0RhU0R6cGdCcWR5NDNXSXlpTFVmQWtQRkk0REtxQlFjWGM2eHZRYmRY?=
 =?utf-8?B?d0duVUxtcU1VS1AyaWd4ZTRxTnA4dkJKaWYrbm8zdlNvZXlGaWFESDFpUU5h?=
 =?utf-8?B?WDNTWXBaRmg2c21JczNNWnk2d0RJTW5hVDBWak44QVUwOFE3MlVnc0JFaDdv?=
 =?utf-8?B?aCt3eHBuMDNNVXpRVE1WNUNETGE2aDYzWThVRU9lcENXZWNGZlR1NTRhUTlU?=
 =?utf-8?B?dGNUZnRsUnJzRWdtS2VuZ21qK2c0dzhrOElOMGltS1NEMTQrTERsalVKRU1E?=
 =?utf-8?B?SFFRMFhTYUFZL09qWnkxaWRGMmNJNnRlSDAyY3M4VjJMUEl2OGQ1d2YxcW40?=
 =?utf-8?B?V2NIRDU2NUZ0Y2ZadDFyaGlBUUdYZDZqWXR1MkpkNnJORXR0TmVMeHVLcWJn?=
 =?utf-8?Q?XGWD2Ef4LOSzfw6XOQ//Gog=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cE5fYACoBSuKrZSXeNqkzjx6CdDfQ3FvgGRDKiV5PYQQL79hyMXpbD8/Cz2oRu3DgvioszMlvmppECSDOiKDH654LmBZ6a5+vYTBfaJj1aicjXx+4Pnzfa8j56easu78Nzh/nmMEY0OsWR8vZYuES3Aa/Z+HcKPt437jvw5sYMG3BoETppRR1fj42cErUEef7Bi8H2AtABOY+8HfRcvGGBRIBzXnhxduzfrE7LTG71exKUAPeCXp3fbmI1J9UJOeS1tdwq2QA9Y0Zu6nKQtc2CEX5JmUeB2/eBubms/iXzdL4t0W+extVtxniNh7XJ+UIQP4IC5mxbTYSM+yekZgI8V0KgPl5NeKCDjShUsssmXuEQkrwgoZFyqI7sc8aMI4d3tULAPrnAGjbFiofPo13vU2+BRDkkvbDXnG6mDYjvFRkNKE7ycIX8zok4gIBuqOb79Gm+tNvruv0HUtVwtUC8f5a6zmHrXhvfFrJGWTgpGYuSsWVUvkfyEkLD/kjt2C9DcMToPU7+lCk4QeUe7i5BQ/YHZQCJMSTpWt2fjOWZfq0Gc5+qJ9UULr5OVmPaOE5RA5R3C/0VrJpr5cFu67iFcehWMf62QLHOwAiEhKZeA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae086bc-4b4b-4c49-e299-08dcd579329e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 11:26:09.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxR4SRlY9TmM7XfWY8a7dwsAOhise2YiG8cWDL30kwsizacEfRFdSyigDdB/xqVUrStl2MNgNYsjQSp2kgC/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_03,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409150086
X-Proofpoint-GUID: -D-3uTWHTr9o-zrWiAGWZrJVBOx7Irzw
X-Proofpoint-ORIG-GUID: -D-3uTWHTr9o-zrWiAGWZrJVBOx7Irzw

On 13/09/2024 18:05, Stephen Brennan wrote:
> Alan Maguire <alan.maguire@oracle.com> writes:
>> On 12/09/2024 20:08, Stephen Brennan wrote:
>>> To handle outputting all variables generally, we'll need to store more
>>> section data. Create a table of ELF sections so we can refer to all the
>>> cached data, not just the percpu section.
>>>
>>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>>> ---
>>>  btf_encoder.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>>>  1 file changed, 36 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 8a2d92e..e3384e5 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -65,12 +65,20 @@ struct elf_function {
>>>  	struct btf_encoder_state state;
>>>  };
>>>  
>>> +#define MAX_ELF_SEC_CNT    128
>>> +
>>>  struct var_info {
>>>  	uint64_t    addr;
>>>  	const char *name;
>>>  	uint32_t    sz;
>>>  };
>>>  
>>> +struct elf_secinfo {
>>> +	uint64_t    addr;
>>> +	const char *name;
>>> +	uint64_t    sz;
>>> +};
>>> +
>>
>> One thing we've run into before is hardcoded limits get exceeded on
>> systems, and while it seems unlikely for 128 ELF sections, I think it'd
>> be better to make this dynamic just in case. Also for parallel mode we
>> have N encoders so it might same some memory (which we're pretty
>> profligate with in other areas). I'd suggest using reallocarray_grow()
>> as we do for functions. One thing we may want to tweak is that
>> reallocarray_grow() will grow by 1000 or 1.5 x the current size;
>> starting with 1000 ELF sections is a bit much.  We could perhaps
>> tweak reallocarray_grow() to have a min_growth parameter to control this
>> and set it to something smaller for ELF sections, what do you think?
> 
> I agree that the static allocation doesn't make a ton of sense. To be
> quite honest, I was lazy during the initial implementation and intended
> to come back around to make this dynamically allocated.
> 
> I think the answer is to simply use elf_getshdrnum and directly allocate
> the array to the size we need. I'll definitely do that in the next
> version.
> 

You're right; since we know in advance how many sections we need we can
just calloc() to get zeroed memory.

>>>  /*
>>>   * cu: cu being processed.
>>>   */
>>> @@ -95,13 +103,13 @@ struct btf_encoder {
>>>  			  is_rel,
>>>  			  gen_distilled_base;
>>>  	uint32_t	  array_index_id;
>>> +	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
>>
>> ...so here we'd have a substructure like this
>>
>> 	struct {
>> 		int	allocated;
>> 		int	sec_cnt;
>> 		struct elf_secinfo *sections;
>> 	} elf_sections;
>>
>>> +	size_t             seccnt;
>>>  	struct {
>>>  		struct var_info *vars;
>>>  		int		var_cnt;
>>>  		int		allocated;
>>>  		uint32_t	shndx;
>>> -		uint64_t	base_addr;
>>> -		uint64_t	sec_sz;
>>>  	} percpu;
>>>  	struct {
>>>  		struct elf_function *entries;
>>> @@ -1849,7 +1857,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
>>>  	 * ET_EXEC file) we need to subtract the section address.
>>>  	 */
>>>  	if (!encoder->is_rel)
>>> -		addr -= encoder->percpu.base_addr;
>>> +		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
>>>
>> We will need some of these mechanics later when we encode function
>> addresses; great to have this!
> 
> Ironically enough, this code (and especially, the is_rel field referred
> to here) gets deleted in patch 4. Maybe I should have left is_rel if you
> think we're going to need function addresses from the symbol table.
> 

No need to leave it in; if there's reason to delete it for your changes,
please go ahead. We can resurrect code for functions if needed, but no
need for you to worry about potential future changes like that!

> But patch 4 fully embraces simply using DWARF to get the variable
> addresses, and it stops using the ELF symbol table for variables. The
> DWARF addresses are always absolute. I couldn't really find a good
> reason for using the symbol table, except maybe as a decent way to
> filter out bogus variables that didn't actually become real data. For
> example, the x86_64 percpu region starts at address 0, and many bogus
> DWARF variables have address 0, so  making sure the variable matched the
> symbol at address 0 was a good way to filter bogus variables.
> 
> I didn't think it was a big deal that I removed this behavior, because
> with improved variable filtering, this code continues to produce nearly
> identical percpu DATASECs, with the only difference being that we now
> (correctly) include the fixed_percpu_data variable for x86_64, which was
> omitted before. So there's no regression in functionality.
> 

FWIW I think it's much better the way you're doing things; the situation
with functions is unfortunately messier, and we need to do comparisons
across function declarations to probe for inconsistencies.  I'm hoping
we can start to move in this direction with the function code too
though, especially if we add address info for functions too (which we're
hoping to).  Thanks!

Alan

> Stephen
> 
>>>  	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
>>>  		struct var_info *new;
>>> @@ -1923,6 +1931,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>>  	uint32_t core_id;
>>>  	struct tag *pos;
>>>  	int err = -1;
>>> +	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>>>  
>>>  	if (encoder->percpu.shndx == 0 || !encoder->symtab)
>>>  		return 0;
>>> @@ -1954,9 +1963,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>>  		 * always contains virtual symbol addresses, so subtract
>>>  		 * the section address unconditionally.
>>>  		 */
>>> -		if (addr < encoder->percpu.base_addr || addr >= encoder->percpu.base_addr + encoder->percpu.sec_sz)
>>> +		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
>>>  			continue;
>>> -		addr -= encoder->percpu.base_addr;
>>> +		addr -= pcpu_scn->addr;
>>>  
>>>  		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
>>>  			continue; /* not a per-CPU variable */
>>> @@ -2099,20 +2108,33 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>>  			goto out;
>>>  		}
>>>  
>>> -		/* find percpu section's shndx */
>>> +		/* index the ELF sections for later lookup */
>>>  
>>>  		GElf_Shdr shdr;
>>> -		Elf_Scn *sec = elf_section_by_name(cu->elf, &shdr, PERCPU_SECTION, NULL);
>>> +		size_t shndx;
>>> +		if (elf_getshdrnum(cu->elf, &encoder->seccnt))
>>> +			goto out_delete;
>>> +		if (encoder->seccnt >= MAX_ELF_SEC_CNT) {
>>> +			fprintf(stderr, "%s: reached limit of ELF sections\n", __func__);
>>> +			goto out_delete;
>>> +		}
>>>  
>> as above we should just reallocarray_grow() more space.
>>
>>> -		if (!sec) {
>>> -			if (encoder->verbose)
>>> -				printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>>> -		} else {
>>> -			encoder->percpu.shndx	  = elf_ndxscn(sec);
>>> -			encoder->percpu.base_addr = shdr.sh_addr;
>>> -			encoder->percpu.sec_sz	  = shdr.sh_size;
>>> +		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
>>> +			const char *secname = NULL;
>>> +			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
>>> +			if (!sec)
>>> +				goto out_delete;
>>> +			encoder->secinfo[shndx].addr = shdr.sh_addr;
>>> +			encoder->secinfo[shndx].sz = shdr.sh_size;
>>> +			encoder->secinfo[shndx].name = secname;
>>> +
>>> +			if (strcmp(secname, PERCPU_SECTION) == 0)
>>> +				encoder->percpu.shndx = shndx;
>>>  		}
>>>  
>>> +		if (!encoder->percpu.shndx && encoder->verbose)
>>> +			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>>> +
>>>  		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
>>>  			goto out_delete;
>>>  
