Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3E23ED5E
	for <dwarves@vger.kernel.org>; Wed, 23 Jul 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265078; cv=fail; b=qs5/MoP6Ot1vETMoQkDXO23+JZ7zmmooDlzSWTtmN0h5rtjYJX9ib8mS/MJmppA8YyPRDpwQkRguo6j42w0DPuiAUKxarBAf+XKmP68axd9krhpnGzRZhARBg5QTedErzVcOGQyQHNUW5zJpXYsCcivSg9iKdpjCjGwmWEkl/zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265078; c=relaxed/simple;
	bh=dY054Xe3p/izRZhhwGnqNaqNge4M4RR+a5rKHiMqZCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6viBXMxqMp/WJFY4Dl/daS+NX/yR6UgkUyrgvU66u610UuaKRoGN9FppHSJO57ysLPIi5/fpRcb5V0InnnCb8DxjA1SghUZ+57mY01mt+kKkZ2BAKE2I6EJ7Hs/RG5ga9v1hg3efcx72FCQOIhRNQqPQ5ujAA6Bh5eMDiP7HAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L37XK4UA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PnRpbZ5I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L37XK4UA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PnRpbZ5I"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8NLLt023512;
	Wed, 23 Jul 2025 10:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lRlQtcWb2Ss0irx0OcVQJN34Idy0KE3fJPxgGcJRdFk=; b=
	L37XK4UATuh1jhGe1oO55VQwfrtT3O7q/CY8rfr5xXuRtSbRDosI2EMgf8b+24rO
	fjNGhEiylAJ1im2Dso1TA353sK8A7g0MvhKiOgvOdTvdZSfytEr2C1IKJpMZM7Xg
	RiRbA/qjqSJ/dUFov2g1ynlvDC4lVdL0C4VL480CHUxQG+VUhIMfNbYlrmSSzkUf
	1j+aC6z0LXpLHQMllVKw7VLk+c7SvGGnf1dFFGS7ctTMx5U+gFid25McWKREVNwa
	o1YHBQj4isu8d/8NUGTjsFVxbsndTpKnjG3GE3z2CV5v01XCbzTfC1MUKWkI/imH
	vejNXcLA2tXcgizlKiNxAw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9q95m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 10:03:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N81XP0014611;
	Wed, 23 Jul 2025 10:03:45 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tgq9nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 10:03:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myyjuutM6rVJs6xmJ4oRq8EBlarFmlZBM6LPNYW+ZZ0zFBawNN8SiW/NQFb4qtXEDKs9vZ7Yz7m6xL9ebC3NF0pnVH30NBddZXLVV2S7ugJXAcwalNnVQ9JfEISEgBY8g1VvD5zZd8zhp9owRWrru0FPmPpfkJE+xUOrJUMgksdI1lacUkUYiNfgMBuF58e9mVVJZlb3K8ALokLInWicVlKxS4TS40lX+H28wijOi0LYu4ebRYPieSi4SdibG4MgTbm/LEErbfft7CvvcsQtN032Deiq92X+uZ/jR8E1E4er3wZw9cP/RX1NQz7m+vEI0Eoy+6FseST1eAmvhTMHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRlQtcWb2Ss0irx0OcVQJN34Idy0KE3fJPxgGcJRdFk=;
 b=Gq7gMXOKClY92voES3C+RCx+QWgg7mNZ/fuW6QgIzpv8Ulphci53cl220BiZK6P78KLw/sstjzO7wkKbuQ0pZzkcrTWuJVdj+pS7nsG2gz1BDO8s9gxcVK72PqN8Lhd0eDPLc14ZYo7UaSsIl2JhRPzL20efLEmBDTBKtFhQDc8wJ0w8taIui0L7akqLuFDGRv01MC8pZJFkblMXPAzZtitDCCRByo534m4iBXtMohqO/odqR+KY8ZZW/r9QTKsDw1gMAZwhGsD/FMf91r9cDb5WD2Sc7VlAISkJcA+MOE26rOdjoBBPB5aL81TSjZC5FUzB/4laJHgEr2IgR7ViOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRlQtcWb2Ss0irx0OcVQJN34Idy0KE3fJPxgGcJRdFk=;
 b=PnRpbZ5INSJJZDN8qfnQDs9lXIkXrjIw5F6nVCUPSNea6Im99W5bWbKEWlnBSHYUPAFSBALV5jcmLtgeKaM2Sybi+gmgDVmAe0+IB4MQU2Ii30Z5z6zxeevIfKL8K9+aFH5Ir2DIXBiar8zymsHty+/hQs5uU8xSCcAauoQWaDk=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by CH3PR10MB7415.namprd10.prod.outlook.com (2603:10b6:610:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 10:03:42 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::4a7d:7fe5:63c2:445]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::4a7d:7fe5:63c2:445%4]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 10:03:42 +0000
Message-ID: <b8eee8a2-943d-4724-b9b4-f4816b8aea85@oracle.com>
Date: Wed, 23 Jul 2025 11:03:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pahole: do not return an error when printing only a
 specific class
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, ebpf@linuxfoundation.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20250716-lsk__abort-v1-1-586f31a9d97d@bootlin.com>
 <e1afba7b-93f9-4ed3-9cd5-ef4ff4bebb70@linux.dev>
 <DBJASAZ3SGNN.364AZ1P0QK6G6@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DBJASAZ3SGNN.364AZ1P0QK6G6@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0041.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::11) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|CH3PR10MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: db32792f-362b-4eda-7def-08ddc9d03456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDFkTDZyZklQQ2dQejBrdFArL3AzOEhyTFExRnAzc29CT3B2V3Z5VGE2OXJV?=
 =?utf-8?B?L2hEcEdLdFhDNVdUV3lNMkw3amtxUlgvNFZYMzN6ODFzdXZEVTZtK3RMa0lR?=
 =?utf-8?B?VjN4UjM1cVE4eXJyUU5ybjNLM2VqbWJKY2lSSC9GdkJ1T0Y3V3EreEtBS01t?=
 =?utf-8?B?S0JFb2JHRkY3TkFPK1J2QVNocVBwVnpUay9IdzU3NGx0eTNKcFBJZGYzU2xV?=
 =?utf-8?B?MnpkMUl5bTVGL1JCUlM5UEVMbHVYTXk5S2RBVVpWSlJqWW5kTUZBdW1CMlcr?=
 =?utf-8?B?TzNTaTdPeGJRRjBDSkRLZmtOZGlQTVR6cjhVOFVsdi9iSjFhbXE3N1ROTlBo?=
 =?utf-8?B?WlVCUWRVaFpNZGx5TlNwZXJDOVFyZVk5Y3FXWUlPaStWRGdmVVRNMzQ1bkpX?=
 =?utf-8?B?bWEwZ3l3bDRaL2p6aFlQRXM0N3JYakhBczlpWFlHMVU5MEF0WXp3Z3B1Z1JF?=
 =?utf-8?B?MUtlUjF1Z1BZUzl3OGxCSVlGbkpsQ3pzMzVoVGxBTHpwMmdUdXhOaDBWRytS?=
 =?utf-8?B?QXN3aW43bGNMVHNoNVFaYlBIOGptcTFrcGhCOGN0N0w1OW1pK0hwUTBQK1NQ?=
 =?utf-8?B?MnZqWW1CaURLRk5XVktmb3hMMFRmZDY5SVJQNlpwblIrV3gxb3VpMnRBQStU?=
 =?utf-8?B?NEQxZ3llNlZEYndpdGRtL1BEb01Bdk5rRElxSytUb1UzTktRTnpXU0FBQk9p?=
 =?utf-8?B?WHNXSnFxZ3RkWTRJVmZGekNVRFNiSUUwemFteGtKUmE4UHUyZnVYUWRVVDU3?=
 =?utf-8?B?Ry9iREZ1ZGFNS2d5cVpJSC9vb0FSckZsTUpYcjdCbEkvZzhGMzhmN29xY1lp?=
 =?utf-8?B?d2dINjgzUEUvQmp4RWtQVEpwOGFKWTlnTi9pdk9hM3V5cVlsMGozT01lVWx0?=
 =?utf-8?B?bkxDY2FoT1lEQzFTb3hUR2x6TWMxUkhlOEM5dHBKdzNCMDcwWmVvY3JobDlF?=
 =?utf-8?B?UVQxUXAranhJYkU1dE8wWFV4UDVqMWUzR1IvMEREWld0Y0RPY3M2OEpmM1A1?=
 =?utf-8?B?K1A0czRtVzh6VE5MWE9KUkErMUtIR2xIUXk0T0U2K3gwaExHbG1rUzBmdGFD?=
 =?utf-8?B?dm5JckV6TGVuTENObzBsMGRjOVVNY1A1NmtaSjgrdUhYR09wdWFBN1daSmd5?=
 =?utf-8?B?VG8vZ2ZIYWpzNGdxT0d1UWZsSkN1Y2x0OC8rQVFOVnRYcjd1cm5Fajd3VHRp?=
 =?utf-8?B?bDQxanZSM0VMU20vWTVlUzFHb0JvZlo4VnNtU2Vka3JHb1Q5YS9WL0FNVnlF?=
 =?utf-8?B?RW1WUjZGMTV1bXdTTDdwVlUrNDZqTjdOZ0NqL0hKbHpZT21iV0tiZTkzYjZU?=
 =?utf-8?B?NExCVDJHVjVneXFSZStLWFlNMXJiUGZmbXM4QkJUa0VENFZvcHRkbUlVanpR?=
 =?utf-8?B?OW9CSkxpakZpcjFFWWFHOHBSeWE0YlR4Nmw1dFpCcU56WUhvaXJFYlJEVEVY?=
 =?utf-8?B?MjFvVmRvTkkvekRjckRSUUk3cmM3bUlVWHNjWHVPU2tkOUdHZFU1U3RtUTBm?=
 =?utf-8?B?NXlwb0RZekJTVFZQajBxOGlwWEo1ZlJVMGlrTGhRY2NnejE4QWMvdVJjU1RD?=
 =?utf-8?B?VVdBNEFqRE56Rk4yNGFiT0ZSSEMzek9GeWJ5Zkw0QTJCeUFuU3kxaUNKVytv?=
 =?utf-8?B?Ym1aZStERkh5cXAyWnFFNUZUWHpyOXJLdWMrSEtwRlQ4TkptUmNJRlh6NlVC?=
 =?utf-8?B?L1V2ekk2NERZM1NUcS9vY0FjT0ZFMlRJWStUQUxTS0VKOG9oVzcxcGNIaUd4?=
 =?utf-8?B?bk5YSVVPQkRxdUwrcHVpYTB3blpJdFBGTXRoaUlUZm9SNHNmUklBcEhUYitQ?=
 =?utf-8?B?ZktPODV1TkhPWTdITXVOajRMbGIyMTFiN3BuL2JXMTNQVmc5NHBrTlJpREVF?=
 =?utf-8?B?QUYwSVhXclZmbmo2TVNiMWJTOWtVMzJlUlEraS9oZ2xUZ3pQSlMzdmtlb1Ba?=
 =?utf-8?Q?aDPW9JmZpOk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVFLYjI4Rjh3OVlDMUVQdFgxbWk4K3dlcTJMaHVQN24wWWVwRjZTMlFPNVp0?=
 =?utf-8?B?UngwWUZXRDF6ajNnbVBoSDk2OUtheW5jd2IxeWNuUjRkUWs5NmdWM2RkcU0z?=
 =?utf-8?B?eU80N3F5SUhia2d2ZlphK1Exak9KYWZuckZ5eXRNWm1oeVU2OHp1SkhuaVM1?=
 =?utf-8?B?OFZ4Q2dndWtlNzR1V1F0UHV3SWIzM2JTWGF2L0NOSCtvZjAwNCtQUTV0NjlW?=
 =?utf-8?B?d3VSbEpvVVhtVTkvd0ZiYjdFYk12a0lqOHJpS3dvQUJiNGNFNE5TZDYvR2FB?=
 =?utf-8?B?Y2lqNnZRcGRYNk1DUzFhNlZWdUQzMlNRSDh3Yy8wenBwcUE5SW9RaG9pY0pP?=
 =?utf-8?B?UStOTVh2VUNzN3lDbW1oYXp3ZFVYY2c1V25ESC8wUHdWS29GNHNNeU0xdUJj?=
 =?utf-8?B?b0NtaUtQQmlkYnVMWEk3bFlCd1FhK29sVk9kdzdrbU53bkVvdDJ6R3A1b3dV?=
 =?utf-8?B?MU0vcTMrWWt0Y3k1MFQyMFc2S2lSTUkxUG1JL1puTHErejJzZ0ZnZVQxQWU2?=
 =?utf-8?B?a3NWL1hZemhOMjZPcThNNnhOWCtKc05HNmRHaVRZNFZndHJWMkgvRUNTZ2Mx?=
 =?utf-8?B?VytWV1RUV0t0RmVzS2Q1U3Njbk14SlJReEp6Wjg0R09tNnRZc1dnN2hyczB6?=
 =?utf-8?B?NDE1MWpXam8vOVJURTAvMzBKK05UMGVEU1JlWTlFd28wdWYzSmx6OHpWZ3N2?=
 =?utf-8?B?ZXlrNzZ3RmN4eGJmWm51cnlmbE5WMk5HcmpJZS9SSzRvZy9LTkg2MGx1LzBm?=
 =?utf-8?B?WXdEZEJBQ2JvMjNTVEc2L1M3V2h0NmtKcHVzTDJCc3N5U3NpNk90MkkxY2dh?=
 =?utf-8?B?MVVrT3l3ZFpCOGpHQXZMcGxLSTRRN2M4T1pNazFEamhZcldRWTk4Y1pNUmVT?=
 =?utf-8?B?OEw2VUova2hDQUh6ZzJPMzJyQlZ5K3lZSTlxR01nbGg2QmFqUlZxYXFZQTJY?=
 =?utf-8?B?STAzRng0dzR3dE1NVnFWb1RzTURTNS9PZVlNT0JMZXBSNVUxYkhia3BZak95?=
 =?utf-8?B?ZjV0ZWNHYnRwMlMrbjlCNERFSU9HZGQ4aE1kck1zbitMazVLLy9ZVGs0THhG?=
 =?utf-8?B?bnpzb1RteTduU2tGdlZJZkV5a0lNRDVSWk5VU0lhdGZuNDg4SVUwR080QWdh?=
 =?utf-8?B?eVhTUElrYjBJSmdpTGdtSDRQSVY2bUlndTZsS244WE4yUkRzYkVqb2RCNFY1?=
 =?utf-8?B?YXlGNW1qQi92Nm11UW4xN2x5K1ROZmEwZm9haE8xdzlMU0RUbUsxVzdaWW5z?=
 =?utf-8?B?eXllTEZnMGFlOGdpOXdWaU1ReUdaclBnRytKQVFVZjA0aVI3L1JqNnVUK2Zk?=
 =?utf-8?B?Qmt6ZnZFSXNnYkRDQ2M4SHdBNnN3K3A4eGJBZmViTnQ2Rlg3U2lJY2NzbVVQ?=
 =?utf-8?B?VzZGWnZHYWlsc2NvUDRlamE5QnR4dTV5cmUzVUF5bWZuSStJOHZyZHZtdXF6?=
 =?utf-8?B?QXhUUjd1VVF4WmRteG9vQTRDWk5wKzhXc3Y4WTNWdmVkZzVvT1U4QUVvaWNO?=
 =?utf-8?B?ZktKRUVTWlFHYi9ZZEFzN1BjTXFFMVJpd3hnOEF0V25KOWdqZGZwUTQycFhX?=
 =?utf-8?B?UURkME5kQUZHSTM5UVovMWtBY0ZMRzhWajhkSFQrK295U0QrYThiai9nOFJv?=
 =?utf-8?B?VnB0emFwbGxPU3pyRmdZNVpLOXJTYjViQWVPYWQ2MmR4Z1ludDhkSXBQdjg3?=
 =?utf-8?B?d3RBYVlhRlJKaFVBM2NHbWRPcVd3dVltS3k1aXN6MGY3NmxlblB1bitKRHpW?=
 =?utf-8?B?ZVNlUDV4OURpRTllVGJHMFZYWm1IMzhBaDBKYkxRUmFKajdMTEd6N3hsc1do?=
 =?utf-8?B?ZS90Z1o3bE5hV2xZMEQ3MEZaQkxWV21Vb0pRNUdXK095L0psTHZDckZIZFVE?=
 =?utf-8?B?K0kvRitIWmtLR3RodlVKaURZenVySTc3S1RLMUxFSUlBYUJSZVlwRnAvNlZ0?=
 =?utf-8?B?cjJjei9TVkdkV2VIMFA4aG40V3V5WVFlZHZYL2lIaEdteEMyU2c2Rkg3cjF4?=
 =?utf-8?B?MDVwL3pZejNoUXNOVk1xWmtCWjNlSlBBS0JoUVNMY2MwWWU2d3VmQUg1Smxv?=
 =?utf-8?B?bVJZaG1XeloyVFAvbVVJcG15cnpvN3FBSStKeFJLWDM3UkFwWmFYNVNFdFVv?=
 =?utf-8?B?TTUwZEpxRzBmK2tQVERJa2wwUXAwZ0EyZVZjb296RU1GR0Q0anhiQWxFSkZD?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PKyUhrlwyN3Zi8Ne8DRtESn9gy9yzefTTvQpxTPy/gVNKGuyv9/44CH7brM9gJK4AD0ik7kH5AITSEHEgohcG0a9TvxYfhQf12T8use1sUlf+eDLoB3d/1n+QemwDp7nXDAN907xQ49LnWXtReYJDPrebX25B/j/bci6I2epzds5ZHuiXJ+betNjbVd1tDcXMW9aeetABEOxnEwgqWgPZCaJWLpVlrF+3B3uYDq7Cj4NECrn8mjfOeHQOvMi+SSMzb8lvtwnVId6M5M0a9k+wDfPPnInJh2DVfU6tOBYCDIOO5pRUG3cGGarA5C+W8GQKWPHLqBYWTkrCGzwDJ+KjuBVeo2u0eGpYfaFieJBnopSAGU9nAciP3yFhUMXGjWrIuikBkQwE8qrKWFqX+Fn386v71+dqJ1ZjgTBUBcXIud2UzX9PS2JMRLAhQUy//8XzNMnOCk1SQBtvLUShgGO0PekNa0mJXj1oLsE1PX0VIokAe+cEXdE5P5NVnSQ9h15EGkeXS02UI4DfEB4FJJ6zoDbo1iBjUS09+LfqHozBmOWcnb/h1ccDukmzwEso9MqS6UgGBJlxzqpW+9M149VdK6Uzo65YvoNktux7XNXiK0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db32792f-362b-4eda-7def-08ddc9d03456
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:03:42.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ+pe1XYA1WKto9yMVOb0VSILIK3eYnb/V2/HgELRc1urAItxBCAYOFrTA1/Rl17IiuhmyT6kxAkzv0N34EbAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7415
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230084
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=6880b383 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=kljl6ElNen18G7mm:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=_Wu1Epeo615sodgjbvIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: ST3iFxiyjSFoqC3eN3I4n8hpRBroD5Pd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4NCBTYWx0ZWRfX5OX0xoNxbFwF
 wSNptjOiU0QHFcpf1ccyMVdh19udqKnaFzPDEFz18Tm/NuI7NQypPfaUQMlUI+A2EfGTWQwv2V6
 4t7tWXvx6k/+Kke0jwYIY4lXIcNbeLICw7whrkeZacBHBVC5UBWET7gkjjZl6WV8chUQx7x0G3d
 ds/y5RCUKcuy71riL9CGbD7dn/q8re7prqpBEsCEaNAwYzkRNSTzQyFRp7UbIhFh/PS/TciRNlv
 DBJK6ajwfqPN0F/CVg9Q2Mtg1vDCtNlJMa9IHYqSYp3tXyG1aRUJPf9mxEnh1NOYR2E8m82SYlf
 WgMV/FQc8DhRPDTD7EpTaqMG2Fj2TGCaZD8Tw1n+71MhRwmw3BPHin0pQpYvmqUqkeZ9o1e2e05
 bGrRgbRRMounldOtIZMFaJIQBLvT7py6lRoVL+YMOodY67qUnxA3Bzty4Xr226RT6SHjihUG
X-Proofpoint-ORIG-GUID: ST3iFxiyjSFoqC3eN3I4n8hpRBroD5Pd

On 23/07/2025 09:39, Alexis Lothoré wrote:
> Hi Ihor,
> 
> On Wed Jul 23, 2025 at 1:42 AM CEST, Ihor Solodrai wrote:
>> On 7/16/25 2:04 AM, Alexis Lothoré (eBPF Foundation) wrote:
> 
> [...]
> 
>>>   	cu__finalize(cu, cus, conf);
>>> -	if (cus__steal_now(cus, cu, conf) == LSK__STOP_LOADING)
>>> +	if (cus__steal_now(cus, cu, conf) == LSK__ABORT)
>>>   		goto out_abort;
>>
>> I think we should handle both LSK__STOP_LOADING and LSK__ABORT here,
>> otherwise the worker will keep loading DWARF (which is most of the
>> pahole's work) and passing cu-s to the stealer function.
>>
>> I guess in many cases it'll complete without errors, but it's just
>> unnecessary work.
>>
>> Maybe add a check for LSK__STOP_LOADING here with goto_ok?
> 
> Hmmm, I am not sure how to follow you here. Even if cus__steal_now returns
> LSK__STOP_LOADING, I need to return DWARF_CB_OK from
> cus__merge_and_process_cu, otherwise it will be processed as an error
> again. Or are you suggesting just make sure to delete current cu but still
> return DWARF_CB_OK when getting LSK__STOP_LOADING, as done below ?
> 
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3796,6 +3796,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>         Dwarf_Off off = 0, noff;
>         struct cu *cu = NULL;
>         size_t cuhl;
> +       int res;
> 
>         while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
>                             &offset_size) == 0) {
> @@ -3874,7 +3875,8 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>                 goto out_abort;
> 
>         cu__finalize(cu, cus, conf);
> -       if (cus__steal_now(cus, cu, conf) == LSK__ABORT)
> +       res = cus__steal_now(cus, cu, conf);
> +       if (res == LSK__STOP_LOADING || res == LSK__ABORT)
>                 goto out_abort;
> 
>         return 0;
> @@ -3882,7 +3884,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>  out_abort:
>         dwarf_cu__delete(cu);
>         cu__delete(cu);
> -       return DWARF_CB_ABORT;
> +       return res == LSK__STOP_LOADING ? DWARF_CB_OK : DWARF_CB_ABORT;
>  }
> 
> 
> Thanks,
> 
> Alexis
> 
> 

Good point; I think ideally we'd like to stop processing in either case
but still distinguish error from early exit. We could perhaps set the
appropriate LSK_ value in dcus (dcus->lsk_status?) to make the
distinction and use it in cus__load_module(), renaming out_error in
dwarf_cus__process_cu()  to out_early or something to underline the fact
that it's an early exit not necessarily a failure. So we preserve the
return of CB_ABORT for both failure and early exit, but can still tell
these apart using dcus->lsk_status. Would that work?
