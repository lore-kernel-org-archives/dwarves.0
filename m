Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031A3D96B;
	Thu,  4 Apr 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221109; cv=fail; b=po6U08UOowcNczey/JEXn3c33hrzK3ion9dt80KPolchOrCX1f6Gy5jruqgFDH04fdcjcgGPkvjZhyI3Wiz8dKp9XKq7SPDm1UFrRk08qGS2IV1oKJfO8KFRXFgjiwZa39xIyFRxjxBeziuaq1qGrCkoc9mMzfyJPnDf7dWcSvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221109; c=relaxed/simple;
	bh=aB48HkxppCflrReZyV8o4LQ/3kgSAMOgeop3UvIP2NY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hRSs1WQN/GAqVyNEeDVy84Ui1qkuTM/gBuACIwdCBGWDShehxwb91gEJxfc+ziYfB0BbCwq1V80MCxIhAUrGxz522cTxJ93H8e4rd7acMP0X535yLA2VP0zmdBgi4IUT66c9EAJcfVZEI2TPDAevb8fIrPqjlSylPMqM4Fha5k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A2+l/4jm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uIEllP6o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A2+l/4jm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uIEllP6o"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4348iorX023780;
	Thu, 4 Apr 2024 08:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=AXIlUpkW/LZyOrXqHaUmMTz5CvWZpcu6kJlGl95vhp8=;
 b=A2+l/4jmf2CuEKDIeuv1BHBHw+Be4d6D/8rBFTlXvCeAGGJ5p0ZAVRalvcMlIglpxBBJ
 M9u7tMyyOUJk9TnvWrXEws+BRXEa3McFz0G44dW9ciih0pXXBf6ifqIlcG9k7iILGtRT
 W5Uf7nPBAc5krGokhbEyddI3HDmRG+FuoktosKRUHhL2LVx7M6nZUXmy9bh3DUyRNyyM
 QpqEzRc1IEQnoIJrSlSODwtBroljBSkhQpEPJByO6NX03cYovw2ESr18kw3Z4B7iXiGs
 LdV1jWe54wBGNrskH1V9csHxDB+6mfSlbEjUZEgcMwJb/Ekvili+dX484peUIKPF7cgc zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9evyrs67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 08:58:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4347n7Q8009241;
	Thu, 4 Apr 2024 08:58:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emkdkaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 08:58:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxzadvNirdzWDfyS7jydvw1jSvSmknPq+2IuuImz7Hle2VXZpXK1r9OJUvIQ2hId/HLghBf2Th0DPPnDvtu2cx4Aie2dN8IP6Z8GRbdpfQIZf65fvbXr7M3PHXh4ruph6DD5xN97CGyCluMakMS6YZE09eovAg0OoJBSuA/kTz1cGeMTw0sk39OhtQNWypkQUKtshH64FE5J1QXvvXgLyFsw8gqxmzZSqPYXJC0SJ9L/9Pa2j/syqkgl1Qk54D+XiegmZYlt5k7F6flcebG8rrKfZgzRV1mxweFVFXL5gCcXJHKLVi/LrvGp+OQWNhZuqbbuRB+QpIiBaEDsia4/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXIlUpkW/LZyOrXqHaUmMTz5CvWZpcu6kJlGl95vhp8=;
 b=UumEtxuS2g6qWpusQGYHBRqjYr4pWvlczlN/VKlF2papcc/cMB+9fkVw4uXaBRB8k7egUJc/AsxBxJM0oQ9yovDoHIzSZIjIBfwnJCMT/h3GgHrVKW2Zm0lv6NtWHrsv10kQz1v1R9dESbjrgbvYB1YlAQcaWl12Rof/uTSYGI3JgpsUgv0+vM9DFr5UUokDxjxiEd8EpFOhF089x3p2fZaERYDAPVUvfg185wnRZk+S4w1SU92ZNPpxswNKNXMyZWCjg/X4vwbKR3TvnbAmFLUhAHOL9+BS6W+npzHNYJYFoZa12hPzsx5UtRBpIRvcpU4FDzslc+Oc/03zAofnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXIlUpkW/LZyOrXqHaUmMTz5CvWZpcu6kJlGl95vhp8=;
 b=uIEllP6o+5xI7XRIfT96atAlfnVe5amhJ5inuRpulbthr9tc0oo+/OpP+EVrrJGiwj1SOqNmtRQk0Dnvax6EONsL23vzonohHxUj+BP80EC0hugqgR50Ht9HWuGOir/1DQSoXRTJO5XGM22SJ14kHg2Cyuic9q+kLao9OuZFAfA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7319.namprd10.prod.outlook.com (2603:10b6:8:fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 08:58:17 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 08:58:17 +0000
Message-ID: <d9ebf954-bfac-4819-993b-bbf59c69285a@oracle.com>
Date: Thu, 4 Apr 2024 09:58:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
        Kui-Feng Lee <kuifeng@fb.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
References: <20240402193945.17327-1-acme@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240402193945.17327-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:208:be::38) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7319:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ctPSGM8KamLBnkaNBPBbSTx6crkpcw+jJCn2rnqejuDnBJETEc+Tv3kKDP4QzY1TDK2vVa7m6lmPTxK1rMSupOUEF03aT/xGzyEP58BLfFAipprFlgV69KvNhfB1XF8qmy3lISfNyZesr2uhbB05d7pjcAIJ8zErn3RShuwMhp41VDvSW2i1S3Ng46KeTbjnh8dt1Orh9JcBVF3UOCIFucvJf2S7YYZHsGbZhKPlioXDWV+hEjKdPQZ190eDph491/2PRWtT/gzdvgpUW7DdKBFFDtd6uLBxaAwtwbPRgE32adLYjq7KAGl7jqJ/iaoCpT1JOiYFwD32sFFw43DmAi4p/3DtEdydVJHK1g/KWha6KY/Ux/5l7DHRV5CEKblVkYBTDirhHR20Ue2ktfbAL9zWL69EAaNn7Hw44+KPQ5FJu6NUF2gEueCmt2HzJPs+zOVhNS+/PHgG2jJN9dQQl/XLnacwsJdrmXPTphwCftW+iM5O1XZmAd48nZ7R5+B7qDpWsamtm/Q4/k602v4bqyx6GmX42rk4gpIJSpzAdApvxJ1DgfUOe2BXmFkBjDysRyEZdeZYTUqX3oX514OEj1Mdwrq2q5DtZsOPDjqqMXoJabZDS5mA3s3MRRhIMw4k
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tm1VaGhITktrK1R3bFVTcldEMUZQaHp4elJ6dWpONnV3dTcrZ29nNEN5VkRV?=
 =?utf-8?B?SDBPTFBOWmVPMG11U0xBYk5nK0M5eitKTDBlYW4wRTJpV2IrdVhmelZ6ZTdw?=
 =?utf-8?B?MmU2REZnN2U3bFFJZGo0allwRHVnRFJTaXNZTGoyNDhMTk92RWJkblhXSnRH?=
 =?utf-8?B?SUJHUlZxUENuQWo1OTFKeXd4YmErNy9FMzYzWTJqUElZN0VjOTEzdXNqUUhI?=
 =?utf-8?B?Y2htY29aaG9GblZ2S0d6ZWdvYWp4L0kxenVrcEs5ZFZuTFVxb2Y5RUtUNUZh?=
 =?utf-8?B?M3BUNE5GMFgrRU14QWdhcTdOVGpMc2FUMS83aW9QU0ZuUG91aGdUUkh5ZkpB?=
 =?utf-8?B?dHZTVlBlSFYrRTAwSVdXalZJclZxWnRaMFl1dm1UemFtckVNdGdjSFNUZk9o?=
 =?utf-8?B?SFZqVm44cHlncG82T0JreE55K3lNVXFmcS9JYzBhZ0tuck5YYVpOS1BHbGd5?=
 =?utf-8?B?eGt3SFAyelRIOWZCM3JOZUZUSkxTZUdLRTJvSmtaeHhJbmpiS0kwNTlKUkJ0?=
 =?utf-8?B?MmRmTlNhcytEMVJuMStFTzU1NG91WjFqTlRaaHVTWGVwWDBWQ21qQmZ3UXhU?=
 =?utf-8?B?dGd5Y2xtNTRUcHY0ZzhKS2crMXNyVFNhdkkwV0lDczdpKzdTOTI2M2NuL3U1?=
 =?utf-8?B?ZTBVOUJjVnlobUJiMlJXWmE1V1FtQzRjUWJTU25lZW5lSTZ6Qng5cUQ3MHEy?=
 =?utf-8?B?cjlkd0srMG1xVlUyMGdZT3JlS3dVeDFkQzlSU1Z0MSt3Y3YyNkdsVkN6bnRH?=
 =?utf-8?B?U0xmbFpocy85dzVRSkhaenJ6RENtTStpTVZkMG5aenA0eXBWaEpMckFkNVo0?=
 =?utf-8?B?eWtZNGloOU9tT1U5WlZOTmZLLzVTRkFCMGRuWFpHZ0VQMkFhYytxM0FxTFVQ?=
 =?utf-8?B?VE5BRVc0disvdEhIZEJsd054ZDlKVHRYblFXMUk5akRUOWlGcUFmT1kydjF4?=
 =?utf-8?B?VFZrUnFnT1VWcVNkbTdDYU5BdElqcTQ2cDljWjNmRkQvK0xpOXJxR2ZEMHFq?=
 =?utf-8?B?M0NaYm9QaXJxNmtpc29TcU1IN0JDKy9sWW1sRFJDak9DZ08wdEFyKzloT2F2?=
 =?utf-8?B?YlRBeWc4ckM3RjN1WlBwSENhZGhpN2hJQkppRjE2ZjJHR2hEVFlMV2ZaeTFZ?=
 =?utf-8?B?WHNaa1JmR1VoY0dpUEozVXdlMkFLcFVCcHNtOHZhc29jY1VHOGJ6RjVjcmdM?=
 =?utf-8?B?TThqSXFOdUtrd3MvajNHSlR4aStLU3FMNHlxcDBKL294dUU5T1pBQ2k5SHl0?=
 =?utf-8?B?cXpvM0R3eDZBV2ZRVmN5YWZmL0NkVW42a0ZxTEU3VlZEQng0TzZ4UFhtQ1BX?=
 =?utf-8?B?Rm1hUEtTbHZjZXpOSEhMVE1KcmduM29VWDZGL3Z2Y2pPMGdtUW1CQTZtemov?=
 =?utf-8?B?UG9PcjJIMHdSejUvUnlVVjBFVEJ1aGk0MVJ4dXJZRGpyYXByWlJDem04Zk9C?=
 =?utf-8?B?d085Zy9TS2Z4b283R2ZqQ1hYRFRDUFFta2lFaGhWQjM3SnI1RCtkL3VPdkhS?=
 =?utf-8?B?bnQ5bW9DUHF0a3I3eTZ6Q2pDdXh1SytLUnFFYVlFZldocW1OZ3Z4Z0JFRTda?=
 =?utf-8?B?eWQyREZyeXdiVkR5UHhpTFlQb2VySjBtaEtra3Vkcm1aTzh3OFpYMFRKcG11?=
 =?utf-8?B?eHhyZ3JQdlY0Q0tKUHZ1Kzk0K29OdlZpYWI4ZWZEclVqZExkK0JKSTVKUU9Y?=
 =?utf-8?B?eDFzanpGSzZoYWl5K08zN3h1bzV2ZEZ6K0pqTjVBdmcvNWJYR2NOZmt4dlNT?=
 =?utf-8?B?eVFwcFBkMlBUTy9uOVFFRFo0RGt6b1dabjFuNUFFRWlQZXozZk5hWGY5SUFE?=
 =?utf-8?B?QWhrL3BpTDV6QXF6VjJFNUdZMUtKeVZoTUlTQmpmZHFtakp5UVdjMHBkVFo0?=
 =?utf-8?B?UStTd2hjMXdnK0NTYmZIQXlvRlRWa1ZVVFBnRFRWbXhNM1B2U09wbGRRZTJN?=
 =?utf-8?B?ZGcyeCtHK3dMd0R3WWFDVTBPaHp5Vk1vM3VFZHI5Z25vQUMyWmtVbjJNY1g1?=
 =?utf-8?B?aXNQZVlKQTRucE53M3VGWkRkNEU0dC9tU0cxZmRheFRHN0x5WUVqeUdvU2Jo?=
 =?utf-8?B?ZVVJd0Z6UE5iYjBPMDYzRlFTT0p4S203aTVPOHNQUm83ZlNiVUFqNk45SkdL?=
 =?utf-8?B?VEdMSWlWNGM1allVS3h4SmdaeGJ5ai9NQURhWFRRY21vT05jWFFUK2kxdmRx?=
 =?utf-8?Q?fsy9tmEGZKxzXOEQPP7zLdQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FtRVF/mKP1KVwQzrmNM5p3hwBqIwsxVFVRp3nal6Ceo/XmcSMu03DYG1fIG/YQIZBem3F65A/7iqoKKM7ozDQ6z6/araSWAfv6Zz7K1mYaSaAGMtWB8ff8OEYybP2HFSedO1FAk+jjozNjB6PpDRMKzrlCUlNsfm/6NxtLRYZYdFQuHvImHJ4bxuG1rVk6SzuyP4n7ymahPkTH621XsjgsFjxtl5X/4kT5T3nbyWN6EyY7Q7vSnAF3CejwkfXv0tQ7TioMpoFSJw6X5owGbcQFhl5Yql2lDM77hRdORIAtBcIPj7P3/MO7y6WxxcfoQRoRI46TvvZQiR5QOmnxsWQ0L5vuA225PBWPjmre/mtQdi0XZVzURIxEhMS8/zq/y/6E+CcLVZmo57jXGMS2C1ZToNJnUjwN/EY3BO3GaZaPz6QlNXzNMb+aP+EiEG4Ksp6+54TTfqGhxaqp9/Bl41FFAm7/y1b3BOtPp83UYEhZCAWVei9zt2YgCDUfK0grIv2H4i+3COhD+DRx93r0lr4xIuB194fB/RjAl+Z8Wi8IJ4uyPUogD5k+xkhbYIFgAMNM36UJVdHoBb4oKxOCmrnMvQ+fs8XcJe8cW/KJEn3qs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787b61d4-8f9f-405e-6ea3-08dc54855e84
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 08:58:17.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He4pQ1EiFyFWRJ/M6b1TlwYf49FilhUYB2nYBEqVzBoktL8u0D3NbhM6oBjhWpID7tft1cn92xO+mO++N14few==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_05,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040059
X-Proofpoint-GUID: sL2kyqxVr1g3pTODznrGSk5TqPW2r4jR
X-Proofpoint-ORIG-GUID: sL2kyqxVr1g3pTODznrGSk5TqPW2r4jR

On 02/04/2024 20:39, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	This allows us to have reproducible builds while keeping the
> DWARF loading phase in parallel, achieving a noticeable speedup as
> showed in the commit log messages:
> 
> On a:
> 
>   model name    : Intel(R) Core(TM) i7-14700K
> 
>   8 performance cores (16 threads), 12 efficiency cores.
> 
> Serial encoding:
> 
>   $ perf stat -e cycles -r5 pahole --btf_encode_detached=vmlinux.btf.serial vmlinux
>              5.18276 +- 0.00952 seconds time elapsed  ( +-  0.18% )
> 
> Parallel, but non-reproducible:
> 
>   $ perf stat -e cycles -r5 pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux
>               1.8529 +- 0.0159 seconds time elapsed  ( +-  0.86% )
> 
> reproducible build done using parallel DWARF loading + CUs-ordered-as-in-vmlinux serial BTF encoding:
> 
>   $ perf stat -e cycles -r5 pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux
>               2.3632 +- 0.0164 seconds time elapsed  ( +-  0.69% )
> 
> Please take a look, its in the 'next' branch at:
> 
>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git
>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next
> 
> There is a new tool to do regression testing on this feature:
> 
>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=c751214c19bf8591bf8e4abdc677cbadee08f630
>   
> And here a more detailed set of tests using it:
> 
>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=4451467ca16a6e31834f6f98661c63587ce556f7
> 
> Working on libbpf to allow for parallel reproducible BTF encoding is the
> next step.
> 
> Thanks a lot,
> 

Hey Arnaldo

In testing this series I've hit a segmentation fault:

Using host libthread_db library "/usr/lib64/libthread_db.so.1".
Core was generated by `pahole -J --btf_features=all --reproducible_build
-j vmlinux'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x00007f8c8260a58c in ptr_table__entry (pt=0x7f8c60001e70, id=77)
    at /home/almagui/src/dwarves/dwarves.c:612
612		return id >= pt->nr_entries ? NULL : pt->entries[id];
[Current thread is 1 (Thread 0x7f8c65400700 (LWP 624441))]
(gdb) bt
#0  0x00007f8c8260a58c in ptr_table__entry (pt=0x7f8c60001e70, id=77)
    at /home/almagui/src/dwarves/dwarves.c:612
#1  0x00007f8c8260ada2 in cu__type (cu=0x7f8c60001e40, id=77)
    at /home/almagui/src/dwarves/dwarves.c:806
#2  0x00007f8c8261342c in ftype__fprintf (ftype=0x7f8c60272f30,
    cu=0x7f8c60001e40, name=0x0, inlined=0, is_pointer=0, type_spacing=0,
    is_prototype=true, conf=0x7f8c653ff930, fp=0x7f8c3804bc90)
    at /home/almagui/src/dwarves/dwarves_fprintf.c:1388
#3  0x00007f8c8261289d in function__prototype_conf (func=0x7f8c60272f30,
    cu=0x7f8c60001e40, conf=0x7f8c653ff930, bf=0x7f8c27225dad "", len=512)
    at /home/almagui/src/dwarves/dwarves_fprintf.c:1183
#4  0x00007f8c8261b52b in proto__get (func=0x7f8c60272f30,
    proto=0x7f8c27225dad "", len=512)
    at /home/almagui/src/dwarves/btf_encoder.c:811
#5  0x00007f8c8261b665 in funcs__match (encoder=0x7f8c28023220,
    func=0x7f8c27225d88, f2=0x7f8c5805c560)
    at /home/almagui/src/dwarves/btf_encoder.c:839
#6  0x00007f8c8261b7fc in btf_encoder__save_func (encoder=0x7f8c28023220,
    fn=0x7f8c5805c560, func=0x7f8c27225d88)
    at /home/almagui/src/dwarves/btf_encoder.c:871
#7  0x00007f8c8261e361 in btf_encoder__encode_cu (encoder=0x7f8c28023220,
    cu=0x7f8c58001e20, conf_load=0x412400 <conf_load>)
    at /home/almagui/src/dwarves/btf_encoder.c:1888
#8  0x000000000040a36c in pahole_stealer (cu=0x7f8c58001e20,
    conf_load=0x412400 <conf_load>, thr_data=0x0)
    at /home/almagui/src/dwarves/pahole.c:3342
#9  0x00007f8c8262672c in cu__finalize (cu=0x7f8c38001e20, cus=0x21412a0,
    conf=0x412400 <conf_load>, thr_data=0x0)
    at /home/almagui/src/dwarves/dwarf_loader.c:3029
#10 0x00007f8c82626765 in cus__finalize (cus=0x21412a0, cu=0x7f8c38001e20,
    conf=0x412400 <conf_load>, thr_data=0x0)
    at /home/almagui/src/dwarves/dwarf_loader.c:3036
#11 0x00007f8c82626e9b in dwarf_cus__process_cu (dcus=0x7ffd71eaf0d0,
    cu_die=0x7f8c653ffeb0, cu=0x7f8c38001e20, thr_data=0x0)
    at /home/almagui/src/dwarves/dwarf_loader.c:3243
#12 0x00007f8c826270d2 in dwarf_cus__process_cu_thread (arg=0x7ffd71eaef50)
    at /home/almagui/src/dwarves/dwarf_loader.c:3313
#13 0x00007f8c816081da in start_thread () from /usr/lib64/libpthread.so.0
#14 0x00007f8c81239e73 in clone () from /usr/lib64/libc.so.6

So for conf_load->skip_encoding_btf_inconsistent_proto (enabled as part
of "all" and enabled for vmlinux/module BTF), we use dwarves_fprintf()
to write prototypes to check for inconsistent definitions.

Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x00007f8c8260a58c in ptr_table__entry (pt=0x7f8c60001e70, id=77)
    at /home/almagui/src/dwarves/dwarves.c:612
612		return id >= pt->nr_entries ? NULL : pt->entries[id];
[Current thread is 1 (Thread 0x7f8c65400700 (LWP 624441))]
(gdb) print *(struct ptr_table *)0x7f8c60001e70
$1 = {entries = 0x0, nr_entries = 2979, allocated_entries = 4096}
(gdb)

So it looks like the ptr_table has 2979 entries but entries is NULL;
could there be an issue where CU initialization is not yet complete
for some threads (it also happens very early in processing)? Can you
reproduce this failure at your end? Thanks!

Alan

> - Arnaldo
> 
> Arnaldo Carvalho de Melo (12):
>   core: Allow asking for a reproducible build
>   pahole: Disable BTF multithreaded encoded when doing reproducible builds
>   dwarf_loader: Separate creating the cu/dcu pair from processing it
>   dwarf_loader: Introduce dwarf_cus__process_cu()
>   dwarf_loader: Create the cu/dcu pair in dwarf_cus__nextcu()
>   dwarf_loader: Remove unused 'thr_data' arg from dwarf_cus__create_and_process_cu()
>   core: Add unlocked cus__add() variant
>   core: Add cus__remove(), counterpart of cus__add()
>   dwarf_loader: Add the cu to the cus list early, remove on LSK_DELETE
>   core/dwarf_loader: Add functions to set state of CU processing
>   pahole: Encode BTF serially in a reproducible build
>   tests: Add a BTF reproducible generation test
> 
>  dwarf_loader.c              | 73 +++++++++++++++++++++++---------
>  dwarves.c                   | 58 ++++++++++++++++++++++++-
>  dwarves.h                   | 17 ++++++++
>  pahole.c                    | 84 +++++++++++++++++++++++++++++++++++--
>  tests/reproducible_build.sh | 56 +++++++++++++++++++++++++
>  5 files changed, 264 insertions(+), 24 deletions(-)
>  create mode 100755 tests/reproducible_build.sh
> 
