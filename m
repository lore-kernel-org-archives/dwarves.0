Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88F22D794
	for <dwarves@vger.kernel.org>; Tue, 20 May 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747621; cv=fail; b=WH4LUdIpQZWKRzM4Nrw2qZ4wJ7uTSlL/giIqitjDBUtB+c5LP08tnpJlhSpYM5wuCRNqI9PQFxxZXLPROjPrkjIaY3tv7nEOvks8Oh7/07I2wzAqpZyaNWjvjbQDKbIjZX1voHNGwjmPAOP8LaHUtxbqYq4R20hiiiwwQ8ZwxQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747621; c=relaxed/simple;
	bh=LA5jeVvWmDa+UYaGq4XMng+G2/dIY9+dF2sUG1QUIfo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O88rEjl5dVw3HLE8bxWoppCj7nHYUGJeCv1d1gDg/Yyoft2AKXglKTMY5whsvzIo9YC44Y5HFtBaMVYa1LpMUoegIJLwTgxJExT2Re+stM8QvjdVp8KTMvwFmBW+8v+ILeOZulV1JE1Ff4gbpvw7ExRJg+nZMep7zfzFMRw/S/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gr9B7XJ+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fdJ1mNYj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gr9B7XJ+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fdJ1mNYj"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCtsfK014929;
	Tue, 20 May 2025 13:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Sd5m6eeqHskZO32h1xmPseh9ToV/2yqKsNGeTjThlBU=; b=
	gr9B7XJ+SZ4k5ImdPs6fYHdg6ZJ+7LV3+BumpVeABMsfVc2qm8kXMwR09dqy89gP
	J2UWZf0B9QSIIITPhX7CBptRUGf/jVjTeGSrRcKXnTzFwMmrhEmZRpV72hMZ/gu6
	j73A2x6WMaktfaxjfRHozyuymobhKoVLxFd8/A4jS45kMUWRUrMKZOnCyCX238Oe
	rCg9UTcPBO+PGkzN2flmRnCenz20p60tLRtUwjAD5yCy2zsH5yeWQPgrXr/DAttW
	KZb1a5v8XO/u/Z9FviZTOhnDrNfnsvKlbfXUznzJlLof3A3hUSmHe2xYaDKiVBbs
	k+YKVwzSuGmw8jifN6fHiQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rshtg4qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:26:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCYoZR017447;
	Tue, 20 May 2025 13:26:43 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw88d9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:26:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2/an7wQpJuqGThhykGTtnM3VLwrBImiJLoVcskd1pHToVFcHY4H3mshWSaSuJT9LKn2Of6VJSCICEQNZD02qwt1cCHGRh9NOqyvTF8lYAtF5ARD1fZxPBOv0AK2Vl+0zzRqf2u6bxIjg5ygclPMYMtflIyIT95Gka6M7FC/kRbYIAQ2AiGkF8o4kDkHWTdyg/SVv7Xlmf87sQ47Fx6mLBqXvP00/PIOzgpcq8b4/3UvWaMUCsQhtvj9npRSUzxY6/bVPmgASd9OYpJWRXrbspaKZCzEIgTdw3znHtL80IHrzdIYjhaI78U77J6fWTloEfQYwJxH8AL+8lKVLOeWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd5m6eeqHskZO32h1xmPseh9ToV/2yqKsNGeTjThlBU=;
 b=qizEE4QR2iuw0PquKaKIW14tkjSzR+k+vO+6TNNjwMujFGdWYzv3AYXX1zltFuFmUB4gQ2OesiIJs+8k9iF9lhz/cXsWJnHHyOcp9aHQ4EYArJc0RDTcXdTNYCKTgQiQblaiGsjpOvIeUSl8wAKt0+mvd+ayeq20MOgJToStdBV6sp5oFxt65yBfCf2JvdInGiE5HKVvOJmBwOMLVzRsn9ZCHVX7cM0Wl6KqeEzXe2zno0xkMHZDdgfIIGSK46Y1lPKhdAQJ8uCNkMdXRTCLpkOvTK+22pUCoVsDuN251x47WnhjoTb8UjAAU2ZvREzWdmCAzYxRC3EjFTwnGd+dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd5m6eeqHskZO32h1xmPseh9ToV/2yqKsNGeTjThlBU=;
 b=fdJ1mNYjxkOn+ZzPVmP4craOv4u03FTx0Wbdkp62AD/LtQH/gtx8sxuelxgPgLd3aUVM5xzVsvG+iS31XLFsLRaBSBJs2g6c5DO96jDHjYMzyiZPVOw4H/7d+BBSEF72EtTj0bg+LQxFNg5Lk8D6tOkwW9JMnGGnbcsIWX7M5Jc=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 BN0PR10MB5160.namprd10.prod.outlook.com (2603:10b6:408:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 13:26:40 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378%3]) with mapi id 15.20.8699.022; Tue, 20 May 2025
 13:26:39 +0000
Message-ID: <1c4babdd-9df3-476e-9f54-628b23556585@oracle.com>
Date: Tue, 20 May 2025 14:26:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix pahole segfault with --show_reorg_steps option
To: mail@pfrost.me, dwarves@vger.kernel.org
References: <c2308f16f78150e43529fd5ecc58bcfb@pfrost.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <c2308f16f78150e43529fd5ecc58bcfb@pfrost.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0291.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::26) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|BN0PR10MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: bedf676f-8c6e-4a71-ae54-08dd97a1eab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OURwZ3ZJa1NZY3NrSS85aHIrTFBJS3VScFdra0tlRlJRVXp2amFIQy9wSktj?=
 =?utf-8?B?Rml6d1pxRTNrb0tPVXhVc2JGSnFscDIxRzQ3SVVFc25rdTF3UlBoRktyMHV6?=
 =?utf-8?B?VDRKQjZlWXUybWpGUlhLUThHRGVyc3lwQ1lhdDRQSXpFK2RGVHpHa2VxRjlq?=
 =?utf-8?B?bklaM1ZDakpsSW4vc1AwZG1lQzZnTG42Y29heHNacnZneU1oM0kwUzFvcUQr?=
 =?utf-8?B?dVZIV0RjNWxJTTB3QlpZSkI4eEVzRmV6TkNsWFI3VTJBWUd6dXlZVlZLalVB?=
 =?utf-8?B?MzV5QllPam5CbEwwUGl4VEwrT2dGVjIyUGl2ekgyaVk5U1pHZTdkTmZvSllk?=
 =?utf-8?B?RmpWS1hnSkg0YnVwODVBVVlTU1duNUJZL0VuZnpGTisra1NtaFg5SDFtZ3Uw?=
 =?utf-8?B?SmtRUHZ5ZFBXTzQyZyszRE5CbGJ6NEFkdHJJdGQxQkEvVWh3RTUrTEhiQWM3?=
 =?utf-8?B?SFBJSWloTjUwUm05bDdJbmoxVDZnV0hGV2NUVFBlOFpSaXo5M21tUGFGODBD?=
 =?utf-8?B?NTlvekh3RFl1dWhPOWJJbTJ1YUZCZ2JWanUwT1E5Z1pxc0FQbnNlL200emR5?=
 =?utf-8?B?bTNIMmZzTndwYWN5bmw3dVA2M3AvTCtTd0EzVi8rcTZSbTZDekdXdm1PQnZ0?=
 =?utf-8?B?b09Zb3laMzdYaGVSK0FlakZKM3ZTK09Oa1BEU0srY0xBNTE4S1FGTWhORmZW?=
 =?utf-8?B?RSsrTWJFUU5HRVZITXVJZlRydTdVZWQ5WlliMytiR0FwQU56RTNjU0VCeVpi?=
 =?utf-8?B?UG44SEhtMzFMTFk2bHRJRUhyMUd3dkoxTzJWU01vQUhOSGd1Y2g3QURWY1dH?=
 =?utf-8?B?MkVlMmhHQkhHRExzc3Zxb0prdDZKTjBDWEhlcEp1dHRPL3MxdHFGYUdrRVI0?=
 =?utf-8?B?dTh3YWc3T1hXemZPeDVZTWlEaVlpWU1vMFNtdUxBb0k4aDdpRlg1T3RiMkZs?=
 =?utf-8?B?WUNVbWdXN1dGR0ZhSWViTklDMWkvaFlyQVBpREhlUXVpemtaZjhYMUt3UnVU?=
 =?utf-8?B?bXlVRWpoZ1NkN3UxVElyaUJJaTc0REFvLzJTZmRIV09rK0tVTFpnTGpnUWVo?=
 =?utf-8?B?UHZFcjBVL21KTXAvUDRROXpHVXNlbHE2UnkwYTRvb1hqd2t6OWpLakhSS1JW?=
 =?utf-8?B?NTdjNFltczNQSE93QnA2OXVsUzRiSnZFbm8xcWlFbEdjZGlQN04wNmZ5SGN0?=
 =?utf-8?B?eUMvMHVURHErdGIrWEpncTRDMzNYNnJQUDdVajFPTEVCTU5EVml1Qko0Ylcv?=
 =?utf-8?B?bCs5alJWYUtMMnNuc0k2Mk5hc01zb1JBdVhSNmZKa2ZYTUZlWElIaUZObUJv?=
 =?utf-8?B?V2JKWDdSaDVwMWNrdEliTjA4OXpablRlY0pXQTNhYldpYnhSS1dYWXA5d29k?=
 =?utf-8?B?UUpyRnI1WWhZdlI5aVZwZHVCTWM2NjZZbUZ6V2FTckZaRnd2d3VnVzRqZjNZ?=
 =?utf-8?B?dzY5RDdRUFZCa3lGTWtiYUxuM0VNa1Z3SHRyVmNJVXorWFRmMFhNWitFK2Fm?=
 =?utf-8?B?RHMxNy9mNmorTEtzbjFSS1psc0hUOHFjdmNFV3JNUzB4Z3RSL1lPeTZ6REVF?=
 =?utf-8?B?VGF4SXE1WDBRYjQwdXZrWXJuMDFRQlVTM1JpSlF3YnI2Q1BSTVJVYm5BS0FC?=
 =?utf-8?B?Z2FvT0pVNFB5V0pEWlpHWTBXelVoQ1RYcjNkQWw5em1kckZ5NzdBenJDS0Jo?=
 =?utf-8?B?c3FyQkg5M1ZBVTVLWlBSTHZBOWVwWnlPMVR5QjVXOWdibmN1MEVnMlBLUFRQ?=
 =?utf-8?B?WDFHNklwbVlGODFhUnJmbEluT05udmtHZmpIMDlLWFNxUHpZWlJXWW5EeFJE?=
 =?utf-8?B?UndoNTlBdndob1E0REJ0OFRFdmloVnUyQkZIUjhENG0vT3pRbk1IWWVabG5F?=
 =?utf-8?Q?eQbggW3ryPWhg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEZHU0sybUliZER3MDRRWW4vWEovd3RPWlhIL0QzYnBwVW9raE9HWS9pUEs3?=
 =?utf-8?B?eXR3ZlpzM3RtRSt0ZndkcTZKbmFRS05OSUFaRldaY2NLUG5uNFZLNnAvakwr?=
 =?utf-8?B?OW1oVHdBVGZYaERCb2J5YXp1YWJDenpTUldBTGUvc3FmL3QwdWsxQzdWTnFj?=
 =?utf-8?B?UkNsenB5VjU1Y0Q1VkpHMCtTTFNodXd3UUFTYXhMazBzYlN2WmxwbFlMZE1P?=
 =?utf-8?B?ZENzQTVhNWlBQUk4dkRZWHB5UjArNWZ4QlBHeWhtZWdhNjZtS3FBR0FqRCtj?=
 =?utf-8?B?aytFdm1hNVRQQXFFbCtDd1p0Qi81dm9NL0pyVkNkM0VLdW1jWUY2bUN1WHRC?=
 =?utf-8?B?ZFNxYmlwamQ3aTYxazRwaEl1cW54clFyZDF5RnFSa0pkclY0V05FeHVEV1VC?=
 =?utf-8?B?bGd6QmVCbTJTWS9qRGpTQnVKUG1jRXR6Vk91TUJXZ0pRd2pDdkRPT2FicWpl?=
 =?utf-8?B?MjNORndsak82TnFEaGZCUUpYZW52Tmd2TEhkeDRubGtqUVl0MUIza01wU0Vx?=
 =?utf-8?B?N2FHdFZBekpQRkt1YXIrdjR1cGJRUFdhbVZ0dmdMK0gwem5DR1hPbFUvMXNL?=
 =?utf-8?B?eFV6L0NvVEhSVEJubUQwZFNZbDkvRFdiNkMreVJOOStORjI4K1J2QisvMFhM?=
 =?utf-8?B?MEo3L1hzdVJUeFM4SFRtVUpQTlZJLyt5Mi85S3hoQ3RWQjRjOEdiK1J5ZkZ2?=
 =?utf-8?B?NytkR0NvYmlzOFZyVmptTnVGM3BVMFEyOGIyN0RMZnZRZUxOWkplWmFReXpu?=
 =?utf-8?B?OTdYOFJqTVJaM2RBTDczNE1zdXNLd1JlOXkxdFJhRHhaL0NvU3lpL1pRZURr?=
 =?utf-8?B?a0tmbWVoK0d6YWhNSkdYZjBrVS9OWmFkTURpN0gvMzJRYlgzaTdWVVBpSGZW?=
 =?utf-8?B?ZjdvdDJ1T0RoUUpoL2VZVjdYcEcyWStDdzdJSDNkLzE5Q0szand0cmlqalJP?=
 =?utf-8?B?a01XNkJrNE0vSkJWQmt1QXlrNjZ5N3pKY0xVdldqT2s1YlVkMVJKY28xNDZs?=
 =?utf-8?B?L3ptRDBCd281eG5qTVROTnRoM2hjZktVTzc2WTZxajdXZ3VhUFd3eVVaLzN2?=
 =?utf-8?B?dGlFZ3ZnWXYwRFpBaHdYeFhKcmVrKy9WcWtDeXMvQ09vclZ0cCtEWlVMUm9Q?=
 =?utf-8?B?cVVHZCtNazRSQ3ZtdEpQMFczaHhlbGRNVkkxOHhDY1B1QzFWbnJEQk1SbGxy?=
 =?utf-8?B?VjNXQkZJVHZnOTk0ZzBRNGpLNDhOTmh1ZkVZdmdtKzRiTHdsdmhub3ljUGZz?=
 =?utf-8?B?MHUrRjIzQWtEL0t6UEpxQXFvZTNQaWZkQ0FGMFcwM290WTlWZ2NIcVdWVVM5?=
 =?utf-8?B?VEpxT05YZzJOYVpuUWJZQXZxN2x5VStxbTg0RTBDMzNNN0FTK3dPK2dzV1Bm?=
 =?utf-8?B?b2ZJc0diaERzNzFpNjlqSy9RVzJSbFlCZCtDTThwdE1hN2gxU29rM2J0NDFi?=
 =?utf-8?B?amFnQ0ZFc1RBK2poWXpQbURsMkNmVVhpeWp2RmJJdnI3SFpFWlprNU5nSjJ3?=
 =?utf-8?B?WUZKUkFXWHBMZjZ0R3N3T3hkc3hZNjI5Z2hkNTBBckNTWWw5MmlvRktyTEl1?=
 =?utf-8?B?Z2V6TEZxdE5HSk5DU3YzYXVaTDZaL2d3SDVDSWtLWTkzM21Ob0FoRmlnWnNw?=
 =?utf-8?B?alJ2b3dRVTVib3VYWkkwek1YMFdCWG02VEFSVzFDM3hWOVUydUFtb0lVdnpS?=
 =?utf-8?B?cVNPUWZ1V2JTOE5QemRFZ1QyUzhldXd1d0k2TDQ3VWJGMzAzbHNzR1lmcXRx?=
 =?utf-8?B?YkkyNDhyVmZZeEtpK2V6aDBSQStZaklUWDZyemtWeE1pQW5NVTA3dndodjQ5?=
 =?utf-8?B?UFFLdUZxVjlnMU9wY2lOc0JXNnM0dVJoSG8xK2ltOC8rSFNLdnRkUTFoSnhL?=
 =?utf-8?B?VytkZGFLR3Jta0VhTjl2SDExMWpZQitrbysxRGIyNTdCdnFNWmpvK0k1bmUv?=
 =?utf-8?B?OThhS0ljdHBTNndBbHNoWHZCUjZ3NStBS0FsNGVNWUVYaERYYkI2YnFJK05a?=
 =?utf-8?B?N3J6SzZlQnRkUGNxaFpHMURjYlQ1dWJVanJ6cXhzdDY4QkQyYVV5ZUc0SDZO?=
 =?utf-8?B?anVNQmdreXBMelVVZHdDUDRpc0pHRTdmT0F5QTFLSmExU1pXcHZnQjRIdlZw?=
 =?utf-8?B?Zlg2U1NFL3UyTHE3UWYzMEJYQnExbVFRMkdFNjA5bzFXY1BBL1VBYVVWcUFa?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O85FMXARH8PIdQkMBLTzKSeBjNqYGMMBYU/PJ5aNlk4A0cCzlUn5KyC1r0ykxKY3wEXekW+LQD+IqS47fF72nwIp8Y+g/QBJy4kjZ7Z5OkSNQ4FF7xYtPWPJcZPytTR4Zp/0jHP3pjcKEDjY+AsWNLmVG7Vqi7jJs4CcX+72/+fXuBm/9XOJJu5RdvDwRonfzHWJJY0PC5TXoza9kfhxF/Hidf4K5TubMLsXPWdX3gfgqKR2nvqVm+f95Vv+mG90NUWnT2J4XKYRAXihOax71TWwhbau2+HwnQeZ3hICbXKD/guJfTkNmLjChsXJm/eQ99P+jqNXWuq8Ikn+GtXyokKHr1BmlDbROjqpD0yrrQgprSAMA4WaULsGFXPh+90eyfibIsI1WlVu/OmZ6NKckrRFC3hN8Wb3jGx38WmVW5m3aBo/1318CIb5kxuZ5+wj4LJomNkHcRCSPTANsiLLh4Z7xo0DbPU0/VZbIaSxI2wG7fR4g91aU3pmTm+apU/Esu/I7B+gctu7yYAw2Rarw/hcyMwpfPwtE86XmHKDdpIZK93mo8J2q1UHCgcddImKRG8vQ4tCeHm98WEKSpy09tPmDfRgD9pT8+6Yu2DXPbg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedf676f-8c6e-4a71-ae54-08dd97a1eab9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:26:39.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed+KGGfrcLZFJlaqRH+rBWkem7oT/gTCQttXqstYj4m5wla77hO5hy8zf3ht6u3C4wNk9Z0cNJmS9dHbYW65Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=990
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200107
X-Proofpoint-ORIG-GUID: 69pLXL83BPvg00RV-JLiFPvYKitZXZP8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwOCBTYWx0ZWRfX5X/HLrsckRri 2Xg1GSMW6kVuAzk+ymU5ojlMzhVYpDTzDO58Dfv36O5wgCJePHtGX3b1zUjaFrV6s8WALUG75+W wOzRSi+yVpf7d5a+zhYp4kkBzhYCSrMcsKNGCLX2rqnbQsDYUv7lESK4C3C1XT1KwTIC/2lysQ3
 1BUJ/KlqP5NdpvPVkeugUIgtuox6aoYjgBMdjHzgMg4qTVmelvv5ssXu+DdemLIFJf+OmfbbNtx HlSp1IeOgbTBwdhANf89G/Y7+cGtDcFwa/JzLVztsAWkIqs7KHYdTEAjdjXMIU/JDQqjweov3MY Ce//JuOourUFN2Gw74jfTj4uI6wJuIwIAz7wJ9pGsGF3AariOrw9TkoJ8WRwt8NSbqYrsMB+FO3
 bjCKrgs/Y2qL+cdHJST9MzPTKfQKXek6TqJoNX/9L3sNba42Wth1DzSxc4uphseZeEsW5yjh
X-Proofpoint-GUID: 69pLXL83BPvg00RV-JLiFPvYKitZXZP8
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=682c8320 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=dd-_rrlivDkwxfMpUPkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185

On 20/05/2025 11:13, mail@pfrost.me wrote:
> This function call seems to mistakenly use conf directly rather than
> cconf which protects against conf being null
> 
> This makes pahole segfault seemingly whenever --show_reorg_steps is
> used, for example: ./pahole -R -S -C task_struct
> 
> Signed-off-by: Peter Frost <mail@pfrost.me>

Applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Thank you!

> ---
>  dwarves_fprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 4407fd1..1ec478c 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -2007,7 +2007,7 @@ next_member:
> 
>          printed += fprintf(fp, " */\n");
>      }
> -    cacheline = (cconf.base_offset + type->size) %
> conf_fprintf__cacheline_size(conf);
> +    cacheline = (cconf.base_offset + type->size) %
> conf_fprintf__cacheline_size(&cconf);
>      if (cacheline != 0)
>          printed += fprintf(fp, "%.*s/* last cacheline: %u bytes */\n",
>                     cconf.indent, tabs,

