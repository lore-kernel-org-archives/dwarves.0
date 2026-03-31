Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC6B3D890A;
	Tue, 31 Mar 2026 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944319; cv=fail; b=GksoORMLmpd1ZLQR2Kq89CQEmW40EeMwURkPwFr/odaTO73ixF8djCktcpTpr2wLvYlBEakEi8rFN6A2aRiFjlp4EOcxrLUGZ5A2CtyVrvdHMyVW7+uOD2szWugivqV7Q2+m+EW+XVCeGJ6lI2jnlhuFshHosPXikHUGce4ohZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944319; c=relaxed/simple;
	bh=6q0PwDUEFS194zvFgWsoyNz40zFZ2CaKf7UblofuU6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P7H1Eb8mLSBNI45iom16gFlDJKYkJyCMmx+K2N/F92QqS4xKfKCNslM5c0nGfBwR7tGP0cxsqCic/Rt8vUW5A0/1FVMnYUxZiutAlCpJMd6EREcpCb5UmMqK8qVLr+p3h5mP9x6GirE/lijSB8wpVPns5XGoBSbE7LnaOzZoY4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ne0A689/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qXxF6PYt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ne0A689/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qXxF6PYt"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V1tSpJ489897;
	Tue, 31 Mar 2026 08:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3KzjpAtIi6WogR83SlhN+Z54uf15CLScyPEqq+BOhac=; b=
	ne0A689/zlT4DsGtcrH6x90BDxJPZSX0pVOU3uQJvOX+6maEge9itk2NeEgiBHgJ
	UY/ydmJOcoiAPnJcnnFSok2iD5rCf1ncxEV2c5WJPPt3aoUQhbjOIhaOEOL6Pbs+
	f7DKy0Z9WKloGAHpPqS+TA9/4ddF13xVnaBo8cpZQT2RIdpsUiwAbTlp2BzSgs9w
	mW6xw1jmhioCi5nVtj3I42xj1NplvQpiWosa2bQkJ6Pwv65MmppinoCQJt7vGB5Q
	ZB845RtKL8AuDKw1ZE/fM6euQX3qHRkf3kDebCWlIavX6ATnM4JPTxRevrNuSKDb
	WRxAMqOGhjXb9bLagRtOSQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d66kquna4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 08:04:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62V65pMt022347;
	Tue, 31 Mar 2026 08:04:47 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65efvmdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 08:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeK/zkX956NB3hKQPFnYXDht0or9KDBmjZGW1r3HU3D2vpFpBEDLnWDlKFzLVaKHFvNo9JFxk7gjLwcOEEr4npCFqOVZ+kgcKCsCcBmTsa33GRqezuj/YNOJcUKZQCCBpSbxwV4Hy2KTex0778zJYUpUvWeOH1tK6Z3iZHI+yyIIcfOYQeQc8YSrqOaeY1VB1r/jRI+LwWLhppXLJYe3Gb0B3O/2d8WzsYbcPo2IkfSc4xx/d45Jau7tVondHyitFJh/GKlHUi6o8wapPyOzsGZbgVeMfeATq0PrGPY0t9zH8nPX69M1RHsC9KHaWU1WlvT6H8ItQrWjIRx6tQP5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KzjpAtIi6WogR83SlhN+Z54uf15CLScyPEqq+BOhac=;
 b=D5qiyayCqm3+0jqN2AoqZavV3XBBcU9bMU7xKykotCBWT8GefQUKPZfJ4WKKfxplYMuXfPRtdA2A2BsGcH95qIYomwPClqWo3iRVdbP1C/v09wDKa+omHl/xrE0N1Vax9yd8mUhOM4jsQXCmxd36QC5VeuJryHc6b8W2DxLoJmvnvAwa7wIAmPKEVOHdgLhSpf1WVbspyJsGOH3b1LigzxurhXRd6Yk8yBPdlJuC0ZIADMEwB7gfLvjJIbBoEjVuoPCSRmtqMDkN6MMy1miDtR5PEKv9aRueHabBnFfzL+p9+IK6Z2pLyxAik9V5F33nvQ6lTKlH7ZgPcfI7/dxRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KzjpAtIi6WogR83SlhN+Z54uf15CLScyPEqq+BOhac=;
 b=qXxF6PYtToqLCdQumPAIRCzSEClnzp21MzUZCsT71VrZR3/Vsl2/HszctjQUSXGgrnelbBplqa6okNJI1SorYLr6Hz/NYpEYI/qu5KeeEDkvx1y2ansuKCTu3k10XxTyUMiDl6cEHGe2qk+dqjAYLhEHQcRDF4gGihWSSL6GbHo=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BL3PR10MB6139.namprd10.prod.outlook.com (2603:10b6:208:3ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:04:44 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 08:04:43 +0000
Message-ID: <d8eec3f5-6d6d-4fb7-8a51-c0732b9d880a@oracle.com>
Date: Tue, 31 Mar 2026 09:04:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 09/11] dwarf_loader: Handle expression lists
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
 <20260326013307.2907768-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260326013307.2907768-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0089.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5d::13) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BL3PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d0fb59-9db5-442f-4e9d-08de8efc2abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6EQd6jUO4B0fDnGBCY7ziWbtbqdZV/jAHpXXyTpxsfDCCgnqJAOOJOESc+++8jyzZh0EedjfWjlVZiSq/2OYl647aOZndOv1hjxg45CJKZmQ+8QHFc4OOUeMe/NC7jx3NYsQf9FlDyo+P+WOBe0vFFee4scd8nDIXz39Qi+sK3RVInq3l9530i5bLTNqfLV7P4U92sdcKIfOvZmyL12VF5E9LQ2kjpioCKIJT08MDX37vRvoSZU4v3OwXezslUwhDUAZe/KrmrGKaxS/1wdcJo7w9vF63nxaKKp97D22a6qLVMFt9GTQVW6/WBA1DXyfVsKIYaLXE1NCtZb+cDOOvCfK7gOhqAY+zMtQ8jGvvoLail1zxdu8tVNZwQSPdKIxIc6So+YDZ9Ny2uVbHu1rH8FZ7mQgw+rQhbYHYPrqxW6LH59tO5DQzfuq9Kso4hBBpJcOac/exDDlTWSuTRhWnLApwxlk1yrDKBM1Y0Yh8rycaNs6vhVJeKuOINBhRYyb6WdEnAQtydT1GkbqZ1nFJtgbJ0LM4UsDfhfKyhUecDpDQbJtrvzMVJVUtxTba+yYs3QL2F4c+ssWbzMSmoL/T5HXS3nxSti32GNhUCtfWsUfoXemmtuX6+Q6RK6d4r3s49uUNMLbwWMwxj2VkjcqfU2gTHkDKE61CO9hV2LddWsg9AtC/hd8TyqBgmz8Jhyhynr6ZajKMmlYqcgg/UPst4Cqh0JgJcRd7QVcgoe1x2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzFhRzQwMzVGbUhDRnBIcDhIMkNUd0RGbzcxQmRqa3NLQkhyVmROMW1QdThJ?=
 =?utf-8?B?ejNMTVpwcE1QdGwxY3VSUVJiMVNtT3NHOXBSdnp5d3dGaXREaUdIZ1NoMFlt?=
 =?utf-8?B?MkRuNmkwTUg1OEJVbWcxaDRDdm02dHlkM1JXbEZTemgzNnVrc2ZuQ3MvWm9h?=
 =?utf-8?B?UmVEQzVtcGxLMTFCSGl3Rmt3UTNUTmRNbW8yUnBkb1RsVW10QXRiSVovbWl0?=
 =?utf-8?B?bkZKbVhUZ2xQNFVSTFowT21Dc1Z0S01wMzZuaUM1RFgwNkMzcXAzeFVTTml6?=
 =?utf-8?B?aFFkbWdsMlQxcitxMlBIeFVNcEVYeFJGaG5vWnRwQ2t2eTR5aVpqVFJvSElL?=
 =?utf-8?B?cThrY3htdk9TWGRzMHpuU2E4OEZXWVpGQnBTWUt4bC9GdE85TEJyUENhWG0y?=
 =?utf-8?B?OWRCb3lGYW5XNk5UNjlycUNrUTN6Y2RmV2tNMGNJaUtyRzF6ZmtHaE03NnJs?=
 =?utf-8?B?aTBoc0VsMFVmWmxoNkE3ZjBVZENObGVnY29jS05ZZnFUUVEvaWg5clVtYlhQ?=
 =?utf-8?B?czJOcXhLNXFuRHlSYmxxdWV2RUhBb3dTOEdxVmRoSWNSYjIwZlVrNXB0RFMr?=
 =?utf-8?B?Q0d0Y3pWM0I2THAyRS90ekYwK2s1SmpDamJXSnJ0R2VWeld2cExhQTlxcnNE?=
 =?utf-8?B?VWN3K3pQWHgxMitVcUFxYkx3Uks3WHRlQWZKT0pjWXEvU0ZwYjdjVHZCNGgw?=
 =?utf-8?B?V3A1N0t1RUswRW8vRWNHajVZa3pjWHZBaGdkc1NXeDlvWFR2dlF3KzdZQXNL?=
 =?utf-8?B?T2g3cHFRTHA0SFdQOUxmWDVHK3RPS1dnVFExQk04ekRxMEc4OWJ3akpXSEpp?=
 =?utf-8?B?Z2g1WEZhOS95ZUZLZ2UyZUNwWDNXbnhyV3dKWVl6USt6SEp0UXJLbkNhQ215?=
 =?utf-8?B?SitWb0lzbmRmOFk5K2l4RG1rUzRQYTNnSFBwLytPUERXdUZJQ1JsTi96dUc1?=
 =?utf-8?B?L0gzejhoZ2h1bmlwRDJKSmxSN0E5WlQ5OHZSTkowZ3lCRzl5c0paQWRtVFUw?=
 =?utf-8?B?QmFGdE5tNS9kODBpN2c1VTBNSUNXWG03MnhlRUZDQjM5RitoQ1E1M0tPNWZu?=
 =?utf-8?B?cDVMSjdTcjg0OU13YTFzVUV5SGd2YXFrOWNuUXR4cWU1UmJmdUhjakp1R29x?=
 =?utf-8?B?UUFETWRRWUQrenVhOFJhU0FvSDRndURMbmZvMW9YVjJ3VDM5TVlOTERLNVVw?=
 =?utf-8?B?ZHFOOVNnczJaZlZWNUpHQnM1ZW1TQXp6dWJSRWlhTndYRnYvZGE4UnJ3MEZo?=
 =?utf-8?B?ejFBWWRFRVk5RnVqaHNxRlo0M3pXKzk2REU4NlhCcW9WZEQyNC80aDQxY2o4?=
 =?utf-8?B?dmNCcmhrOWZiZ1ozRzNXUFBvbHJMdldnRFVvejE4L2xXcTAreGl3b3BuWjlE?=
 =?utf-8?B?KzQ4WGpnTVpQbTY5dDlGY09uYkZJalV4TWNYdGQ4ZkI3UEpPV3ZZeGc0SC9i?=
 =?utf-8?B?anc1WnI0Q2FEK1UvZUt0RXNyQkZTelFmeExsNkpTRmkvTDcrMVhRUjFKSmc1?=
 =?utf-8?B?UjhwZFZpeVBRWGVMMEtPd1FPZm1GYVpaYnlSMGZOSStuR0FYVlRVVU9aZnlp?=
 =?utf-8?B?SG1YRmhwYWVXK2xtNnFQMU5MYTdYcXFabjY2bXpCSzhEUnEzYUlyV0gxWmxp?=
 =?utf-8?B?YXQ0TmFEMkdDUFdoTyswZEpTbDJGZStMZkx2c1lIaUkrUmZydTlNbDdOS1hh?=
 =?utf-8?B?c0hDUkp5cTcraUljby9wVXVjcXdPZVlNS3NSNldsTU93MENYdnFUTTJhWEZD?=
 =?utf-8?B?Z2RZQVZOM2trNUxCNFFmQThDcDRmbkZtK1RYcVlPNitTTEdtUXZBb3BuVFZI?=
 =?utf-8?B?QzJnZ2RBZFAyRHRiemwvdFR0MDhkdVpwNjExRDFtOHZQZ0VMT0NWNm5RWlly?=
 =?utf-8?B?V3ppM2pUOWNCV3NER3JCdnRNZ2NncG03TERRWVZwVExZV2VnZFJTSFBNU0JJ?=
 =?utf-8?B?S0NQdmRrT2J0cXl1QVJkMHBBYWFHdUxuVmxaVmlJbzVGV201OEVuMlUyQ29V?=
 =?utf-8?B?bmFNV1RVZjJacTBZTnhxYVhpemN0Y3JKWEkyRlRDazdpY01xV2xzNzlybGs0?=
 =?utf-8?B?UFpZYmNKMUJycE9lL3VtaFJrWlJ3dFUzUXBlMlFaNyt5NkRyMUF4V2xYRHI5?=
 =?utf-8?B?cWdDcWQ4SXd6ZzU2WTBDdmNRZVEzU3ZCRXdKWDJyNng1aVhYT2NiNHFucWwr?=
 =?utf-8?B?Q3c4R1c5aGhhTzJQK29jRC9vQWZiZk5rc3NZRmp1YmhsYW5sNWFQbVdhaXlo?=
 =?utf-8?B?aUFKSk9IKzBZdkJjQVlRUnNVT0pSMERCVDJLSjhrNUoyQmhKdWdpU3FNaElG?=
 =?utf-8?B?WFlNdHBtOW5FbWVsSDdTWGNCNG03SC9LbzY3NFVXcmd3WnJqL3VsUT09?=
X-Exchange-RoutingPolicyChecked:
	V23JiQJ36p9MRBEDTKscFiA+Qxgv8MZbdqGcAnraTnXxbKWVlRb+abmtUhUnOJVz8FfUDTewRSPOGIu4aM3is0iCsshwGOu9OSPqhZk1ifJRZvEvmbuk25k/i1+DFYWwUQgXI01vtK6rQ/En0FgN/fzrxGnbALFP0/7b5l+bdEg9qCTYbJJWQBUlqnthIjsumKN39pWqG5+IMmjVgrPjYK5lqghLuiRT+kVRqD3dZjQrLiTOplKNNhmTlJv52UsaujmdmfgvBK4keZcxqRYtwWfYtVZLV9u1mnyyGnm+6OSe0aB9gZO/5XqGcSqRXQ4UA3g2QQcg/q6wUXEBMW/2BQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	amBGmjR53JLPytR36H622PIH5FwUeEjpuwLqE8UGUJ1ll2jJkQe41sA6rOZoXOdCema4CascmRfdJ1nS5ebGdRPDvxuccywdm0T0atFvPa2ItuOW/iu6piKKNhwewQWLAu7Z0xBz/HUxaIAiNkxhvLrRHtfaTOE4TLHx8VO3cqpjSvNYg5VosgWZKc55AnpgxSu6StUfffi/7zQELxzKTArbz6IsEtB0/JOweLBnVTMVhyRRcrBNfe9OVoO8aduJ8uncducukwJrWVwpQSyZxxLJqA64RPutwIfaQYBavIX8DhK7ejQoFTWmUkNTpRAP1UHdT/BoPoMK2NDFHdsI1QGIkQJ+/lIrA+hdbZxBUMKBP9aHhFY4yEyq53M3t+JKAc6+zzBf68hDzd8Y6zcVdnSVfxVa8ais8n8UgX9fhdHmN/InYBOnhEe/Y00LQa5b2JsNqdq5BNmgwbtssoHkEmbKiC0B+iyp8SGYwHEfHSFylv1LlxhJga7trw3baGMyE3E38TxZsNUTKbc7dZ/LPxELoj/tMkZI5WRC+e7Ie2Vd+L2wL60LqUPiLu29aS4JoYyj1y7nX/4x10nSv9h/WM/QXjTULCaW5CTipMkC3BY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d0fb59-9db5-442f-4e9d-08de8efc2abc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:04:43.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JLvl2QtYUr9lz6tNq9BovZvheyA60yUTlpiY7QfTQ8f4O++xHnhpDXV24F1jNUJ4BAI3+pw1JDQUkMusGtP8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603310076
X-Authority-Analysis: v=2.4 cv=PqaergM3 c=1 sm=1 tr=0 ts=69cb801f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=v2rLsulvD5OSOzwUggIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12275
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3NiBTYWx0ZWRfX7v9GfnssDVrG
 AgtuzqVIHJ6sBh6xsMQIR6gT6RPVxRzNH/emV6uCodi7tx8FsDEYI+13qffKN20yTtRXh28q+Z7
 qfMGZW0lUXthVIejt/Y/vOF2ZedyQNRL+9KlXRJnsEWTt22VyZ2B9uz+lhx8iBEi9I+QRGgBiaq
 aUYhgkpDS49jRw7NA0qumDakNwV71H0JSQMwJKVDPMcsoDkrAUTUtY7pPmhbFMMda6y4rjN11OI
 FRPPw5rXjxaua7uM2l0uuFq6LrODfCpHXQyiCaqop2ftyQrNNK8KJelHNb2Ex6QWW1z68sP2Iwq
 En9PtWBbcPH1w0rQovt1uBLsOMDxuX5OunCkZ0hCPwLhhDZS/r/3JECHsMGFoS2+oBYo8qNTcRM
 +PN9T3IA9S5Dtprpc3qi0v0x4qhCmcRUEk8rkrcMzjOpECg8Ig45+CweXGuBHdkuGV3GeQYltdU
 izMYm7sYOhO1ziybkgXMjuzzcgNsOriILiGUx9QE=
X-Proofpoint-ORIG-GUID: jLEULYe5KJaee2iINmj6iZ_EZd5xFUGS
X-Proofpoint-GUID: jLEULYe5KJaee2iINmj6iZ_EZd5xFUGS

On 26/03/2026 01:32, Yonghong Song wrote:
> Location lists having more than one op's are checked.
> If the parameter size is less or equal to size of long,
> the argument should match the corresponding ABI register.
> For example:
> 
> 0x0aba0808:   DW_TAG_subprogram
>                 DW_AT_name      ("addrconf_ifdown")
>                 DW_AT_calling_convention        (DW_CC_nocall)
>                 DW_AT_type      (0x0ab7d8e9 "int")
> 		...
> 
> 0x0aba082b:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x32b) loclist = 0x016eabcd:
>                      [0xffffffff83f6fef9, 0xffffffff83f6ff98): DW_OP_reg5 RDI
>                      [0xffffffff83f6ff98, 0xffffffff83f70080): DW_OP_reg12 R12
>                      [0xffffffff83f70080, 0xffffffff83f70111): DW_OP_breg7 RSP+112
>                      [0xffffffff83f70111, 0xffffffff83f7014f): DW_OP_reg12 R12
>                      [0xffffffff83f7014f, 0xffffffff83f7123c): DW_OP_breg7 RSP+112
>                      [0xffffffff83f7123c, 0xffffffff83f7128c): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff83f7128c, 0xffffffff83f712a9): DW_OP_reg12 R12
>                      [0xffffffff83f712a9, 0xffffffff83f712cd): DW_OP_breg7 RSP+112
>                      [0xffffffff83f712cd, 0xffffffff83f712d2): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff83f712d2, 0xffffffff83f713dd): DW_OP_breg7 RSP+112)
>                   DW_AT_name    ("dev")
>                   DW_AT_type    (0x0ab7cb7d "net_device *")
> 		  ...
> 
> 0x0aba0836:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x32c) loclist = 0x016eac39:
>                      [0xffffffff83f6fef9, 0xffffffff83f6ff15): DW_OP_breg4 RSI+0, DW_OP_constu 0xffffffff, DW_OP_and, DW_OP_convert (0x0ab7b571) "DW_ATE_unsigned_1", DW_OP_convert (0x0ab7b576) "DW_ATE_unsigned_8", DW_OP_stack_value
>                      [0xffffffff83f6ff15, 0xffffffff83f7127c): DW_OP_breg7 RSP+36, DW_OP_deref_size 0x4, DW_OP_convert (0x0ab7b571) "DW_ATE_unsigned_1", DW_OP_convert (0x0ab7b576) "DW_ATE_unsigned_8", DW_OP_stack_value
>                      [0xffffffff83f7128c, 0xffffffff83f713dd): DW_OP_breg7 RSP+36, DW_OP_deref_size 0x4, DW_OP_convert (0x0ab7b571) "DW_ATE_unsigned_1", DW_OP_convert (0x0ab7b576) "DW_ATE_unsigned_8", DW_OP_stack_value)
>                   DW_AT_name    ("unregister")
>                   DW_AT_type    (0x0ab7c933 "bool")
> 		  ...
> 
> The parameter 'unregister' is the second argument which matches ABI register RSI.
> So the function "addrconf_ifdown" signature is valid.
> 
> If the parameter size is '2 x size_of_long', more handling is necessary, e.g., below:
> 
> 0x0a01e174:   DW_TAG_subprogram
>                 DW_AT_name      ("check_zeroed_sockptr")
>                 DW_AT_calling_convention        (DW_CC_nocall)
>                 DW_AT_type      (0x09fead35 "int")
> 		...
> 
> 0x0a01e187:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x5b6) loclist = 0x0157f03f:
>                      [0xffffffff83c941c0, 0xffffffff83c941c4): DW_OP_reg5 RDI, DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
>                      [0xffffffff83c941c4, 0xffffffff83c941cc): DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
>                      [0xffffffff83c941e1, 0xffffffff83c941e4): DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1)
>                   DW_AT_name    ("src")
>                   DW_AT_type    (0x09ff832d "sockptr_t")
> 		  ...
> 
> 0x0a01e193:     DW_TAG_formal_parameter
>                   DW_AT_const_value     (64)
>                   DW_AT_name    ("offset")
>                   DW_AT_type    (0x09fee984 "size_t")
> 		  ...
> 
> 0x0a01e19e:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x5b7) loclist = 0x0157f06b:
>                      [0xffffffff83c941c0, 0xffffffff83c941d1): DW_OP_reg1 RDX
>                      [0xffffffff83c941d1, 0xffffffff83c941e1): DW_OP_entry_value(DW_OP_reg1 RDX), DW_OP_stack_value
>                      [0xffffffff83c941e1, 0xffffffff83c941e9): DW_OP_reg1 RDX)
>                   DW_AT_name    ("size")
>                   DW_AT_type    (0x09fee984 "size_t")
> 		  ...
> 
> The first parameter 'src' will take two ABI registers. This patch correctly detects such a pattern
> to construct the true signature.
> 
> However, it is possible that only one 'size_of_long' is used from '2 x size_of_long'. For example
> 
> 0x019520c6:   DW_TAG_subprogram
>                 DW_AT_name      ("map_create")
>                 DW_AT_calling_convention        (DW_CC_nocall)
>                 DW_AT_type      (0x01934b29 "int")
> 		...
> 
> 0x01952111:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x31b) loclist = 0x0034fa0f:
>                      [0xffffffff81892345, 0xffffffff8189237c): DW_OP_reg5 RDI
>                      [0xffffffff8189237c, 0xffffffff818923bd): DW_OP_reg3 RBX
>                      [0xffffffff818923bd, 0xffffffff818923d4): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff818923d4, 0xffffffff81892dcb): DW_OP_reg3 RBX
>                      [0xffffffff81892df3, 0xffffffff81892e01): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff81892e01, 0xffffffff818932a9): DW_OP_reg3 RBX)
>                   DW_AT_name    ("attr")
>                   DW_AT_type    (0x01934d17 "bpf_attr *")
> 		  ...
> 
> 0x0195211d:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x31a) loclist = 0x0034f9dc:
>                      [0xffffffff81892345, 0xffffffff81892357): DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
>                      [0xffffffff81892357, 0xffffffff81892f02): DW_OP_piece 0x8, DW_OP_breg7 RSP+20, DW_OP_deref_size 0x4, DW_OP_stack_value, DW_OP_piece 0x1
>                      [0xffffffff81892f07, 0xffffffff818932a9): DW_OP_piece 0x8, DW_OP_breg7 RSP+20, DW_OP_deref_size 0x4, DW_OP_stack_value, DW_OP_piece 0x1)
>                   DW_AT_name    ("uattr")
>                   DW_AT_type    (0x019512ab "bpfptr_t")
> 		  ...
> 
> For parameter 'uattr', only second half of parameter is used. For such cases,
> the name and the type is changed in pahole and eventually going to vmlinux btf.
>   [55697] FUNC_PROTO '(anon)' ret_type_id=106780 vlen=2
>           'attr' type_id=455
>           'uattr__is_kernel' type_id=82014
>   [82014] TYPEDEF 'bool' type_id=67434
>   [113251] FUNC 'map_create' type_id=55697 linkage=static
> You can see the new parameter name is 'uattr__is_kernel' and the type is 'bool'.
> 
> With this patch, the number of invalid true signatures is reduced from 83 to 18.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 239 +++++++++++++++++++++++++++++++++++++++++++++++--
>  dwarves.h      |   1 +
>  2 files changed, 233 insertions(+), 7 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index d538e97..4e6e042 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1204,6 +1204,8 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>  #define	PARM_UNEXPECTED		-2
>  #define	PARM_OPTIMIZED_OUT	-3
>  #define	PARM_CONTINUE		-4
> +#define	PARM_TWO_ADDR_LEN	-5
> +#define	PARM_TO_BE_IMPROVED	-6
>  
>  /* Max 20 register parameters, considering some parameters may be optimized out.  */
>  #define	MAX_PRESCAN_PARAMS	20
> @@ -1291,7 +1293,47 @@ static int parameter__peek_first_reg(Dwarf_Die *die)
>  	return -1;
>  }
>  
> -static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num)
> +/* Traverse the parameter type until finding the member type which has expected
> + * struct type offset.
> + */
> +static Dwarf_Die *get_member_with_offset(Dwarf_Die *die, int offset, Dwarf_Die *member_die)
> +{
> +	Dwarf_Attribute attr;
> +	if (dwarf_attr(die, DW_AT_type, &attr) == NULL)
> +		return NULL;
> +
> +	Dwarf_Die type_die;
> +	if (dwarf_formref_die(&attr, &type_die) == NULL)
> +		return NULL;
> +
> +	uint64_t bsize = attr_numeric(&type_die, DW_AT_byte_size);
> +	if (bsize == 0)
> +		return get_member_with_offset(&type_die, offset, member_die);
> +
> +	if (dwarf_tag(&type_die) != DW_TAG_structure_type)
> +		return NULL;
> +
> +	if (!dwarf_haschildren(&type_die) || dwarf_child(&type_die, member_die) != 0)
> +		return NULL;
> +	do {
> +		if (dwarf_tag(member_die) != DW_TAG_member)
> +			continue;
> +
> +		int off = attr_numeric(member_die, DW_AT_data_bit_offset);
> +		if (off == offset * 8)
> +			return member_die;
> +	} while (dwarf_siblingof(member_die, member_die) == 0);
> +
> +	return NULL;
> +}
> +
> +/* For two address length case, first_half and second_half represents the parameter.
> + * The first_half and second_half accumulates field information across possible multiple
> + * location lists.
> + */
> +static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu, size_t exprlen,
> +				  Dwarf_Die *die, int expected_reg, int byte_size,
> +				  unsigned long *first_half, unsigned long *second_half, int *ret)
>  {
>  	switch (expr[0].atom) {
>  	case DW_OP_lit0 ... DW_OP_lit31:
> @@ -1302,9 +1344,169 @@ static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num)
>  		return PARM_OPTIMIZED_OUT;
>  	}
>  
> +	if (byte_size <= cu->addr_size || !cu->agg_use_two_regs) {
> +		/* parameter_size <= cu->addr_size */
> +		switch (expr[0].atom) {
> +		case DW_OP_reg0 ... DW_OP_reg31:
> +			if (loc_num != 0)
> +				break;
> +			*ret = expr[0].atom;
> +			if (*ret == expected_reg)
> +				return *ret;
> +			break;
> +		case DW_OP_breg0 ... DW_OP_breg31:
> +			if (loc_num != 0)
> +				break;
> +			bool has_op_stack_value = false;
> +			for (int i = 1; i < exprlen; i++) {
> +				if (expr[i].atom == DW_OP_stack_value) {
> +					has_op_stack_value = true;
> +					break;
> +				}
> +			}
> +			if (!has_op_stack_value)
> +				break;
> +			/* The existence of DW_OP_stack_value means that
> +			 * DW_OP_bregX register is used as value.
> +			 */
> +			*ret = expr[0].atom - DW_OP_breg0 + DW_OP_reg0;
> +			if (*ret == expected_reg)
> +				return *ret;
> +		}
> +	} else {
> +		/* cu->addr < parameter_size <= cu->addr * 2
> +		 * first_half encodes field starts for the first register.
> +		 * second_half encodes field starts for the second register.
> +		 *
> +		 * For example:
> +		 *   loclist 1: DW_OP_reg5 RDI, DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
> +		 *   loclist 2: DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
> +		 *   loclist 3: DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1)
> +		 *
> +		 * After iterating all the above three location lists (see PARM_CONTINUE below),
> +		 * first_half encodes as 0x1 and second_half encodes as 0x1. The 'ret' value will
> +		 * encode the first used register which is RDI. Each bit in first_half/second_half
> +		 * represents a member field.
> +		 *
> +		 * Another example:
> +		 *   loclist 1: DW_OP_reg5 RDI, DW_OP_piece 0x4
> +		 *   loclist 2: DW_OP_piece 0x4, DW_OP_reg4 RDI, DW_OP_piece 0x4
> +		 *
> +		 * After iterating all the above two location lists, first_half encodes 0x11.
> +		 * After loclist 1, first_half encoding is 0x1. After loclist 2, first_half encoding is 0x11.
> +		 * second_half is 0. The 'ret' value is RDI.
> +		 */
> +		int off = 0;
> +		for (int i = 0; i < exprlen; i++) {
> +			if (expr[i].atom == DW_OP_piece) {
> +				int num = expr[i].number;
> +				if (i == 0) {
> +					off = num;
> +					continue;
> +				}
> +				if (off < cu->addr_size) (*first_half) |= (1 << off);
> +				else (*second_half) |= (1 << (off - cu->addr_size));
> +				off += num;
> +			} else if (expr[i].atom >= DW_OP_reg0 && expr[i].atom <= DW_OP_reg31) {
> +				if (off < cu->addr_size)
> +					*ret = expr[i].atom;
> +				else if (*ret < 0)
> +					*ret = expr[i].atom;
> +			}
> +			/* FIXME: not handling DW_OP_bregX yet since we do not have
> +			 * a use case for it yet for linux kernel.
> +			 */
> +		}
> +	}
> +
>  	return PARM_CONTINUE;
>  }
>  
> +/* The first_half and second_half, computed in parameter__multi_exprs(), are handled here. */
> +static int parameter__handle_two_addr_len(int expected_reg, unsigned long first_half, unsigned long second_half,
> +					  int ret, Dwarf_Die *die, struct conf_load *conf, struct cu *cu,
> +					  struct parameter *parm, int param_idx, int reg_idx, int byte_size,
> +					  struct func_info *info)
> +{
> +	if (!first_half && !second_half)
> +		return ret;
> +
> +	if (ret != expected_reg)
> +		return ret;
> +
> +	if (!conf->true_signature)
> +		return PARM_DEFAULT_FAIL;
> +
> +	/* Both halves are used based on dwarf */
> +	if (first_half && second_half)
> +		return PARM_TWO_ADDR_LEN;
> +
> +	/* Only one half is used. Check if the next parameter's starting register
> +	 * indicates the ABI still reserves the full register space for this
> +	 * parameter. If so, the compiler only eliminated the dead half but the
> +	 * register layout is preserved — keep the original source type.
> +	 *
> +	 * Use register_params[] array for the expected next register since
> +	 * DW_OP_reg numbers are not necessarily sequential across architectures.
> +	 */
> +	if (param_idx + 1 < info->nr_params) {
> +		int next_start = info->param_start_regs[param_idx + 1];
> +
> +		if (next_start >= 0) {
> +			int num_regs = (byte_size + cu->addr_size - 1) / cu->addr_size;
> +			int next_reg_idx = reg_idx + num_regs;
> +
> +			if (next_reg_idx < cu->nr_register_params &&
> +			    next_start == cu->register_params[next_reg_idx])
> +				return PARM_TWO_ADDR_LEN;
> +		}
> +	}
> +
> +	/* FIXME: parm->name may be NULL due to abstract origin. We do not want to
> +	 * update abstract origin as the type in abstract origin may be used
> +	 * in some other places. We could remove abstract origin in this parameter
> +	 * and add name and type in parameter itself. Right now, for current bpf-next
> +	 * repo, we do not have instances below where parm->name is NULL for x86_64 arch.
> +	 */
> +	if (!parm->name)
> +		return PARM_TO_BE_IMPROVED;
> +
> +	/* FIXME: Only support single field now so we can have a good parameter name and
> +	 * type for it. For more than one field, another option could be named as
> +	 * <parameter_name>__first_half or <parameter_name>__second_half, but it is not
> +	 * that intuitive.
> +	 */
> +	if (__builtin_popcountll(first_half) >= 2 || __builtin_popcountll(second_half) >= 2)
> +		return PARM_TO_BE_IMPROVED;
> +
> +	int field_offset;
> +	if (__builtin_popcountll(first_half) == 1)
> +		field_offset = __builtin_ctzll(first_half);
> +	else
> +		field_offset = cu->addr_size + __builtin_ctzll(second_half);
> +
> +	/* FIXME: Only struct type is supported. */
> +	Dwarf_Die member_die;
> +	if (!get_member_with_offset(die, field_offset, &member_die))
> +		return PARM_TO_BE_IMPROVED;
> +
> +	/* FIXME: cannot get a proper member_name, e.g. if the member type is a union. */
> +	const char *member_name = attr_string(&member_die, DW_AT_name, conf);
> +	if (!member_name)
> +		return PARM_TO_BE_IMPROVED;
> +
> +	/* true_sig_member_name is the member name which will be used for later btf name
> +	 * like <parameter_name>__<member_name>.
> +	 */
> +	parm->true_sig_member_name = member_name;
> +
> +	struct tag *tag = &parm->tag;
> +	struct dwarf_tag *dtag = tag__dwarf(tag);
> +	dwarf_tag__set_attr_type(dtag, type, &member_die, DW_AT_type);
> +
> +	return ret;
> +}
> +
>  /* For DW_AT_location 'attr':
>   * - if first location is DW_OP_regXX with expected number, return the register;
>   *   otherwise save the register for later return
> @@ -1313,15 +1515,18 @@ static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num)
>   * - otherwise if no register was found for locations, return PARM_DEFAULT_FAIL.
>   */
>  static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struct conf_load *conf,
> -			  struct func_info *info)
> +			  struct func_info *info, struct cu *cu, Dwarf_Die *die,
> +			  struct parameter *parm, int param_idx, int reg_idx)
>  {
>  	Dwarf_Addr base, start, end;
>  	Dwarf_Op *expr, *entry_ops;
>  	Dwarf_Attribute entry_attr;
>  	size_t exprlen, entry_len;
>  	ptrdiff_t offset = 0;
> +	int byte_size = 0;
>  	int loc_num = -1;
>  	int ret = PARM_DEFAULT_FAIL;
> +	unsigned long first_half = 0, second_half = 0;
>  
>  	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
>  	 * when libdw is not compiled with experimental --enable-thread-safety
> @@ -1341,8 +1546,17 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struct conf_l
>  			if (!info->signature_changed || !conf->true_signature)
>  				continue;
>  
> +			if (!byte_size)
> +				byte_size = get_type_byte_size(die, cu);
> +			/* This should not happen. */
> +			if (!byte_size) {
> +				ret = PARM_UNEXPECTED;
> +				goto out;
> +			}
> +
>  			int res;
> -			res = parameter__multi_exprs(expr, loc_num);
> +			res = parameter__multi_exprs(expr, loc_num, cu, exprlen, die, expected_reg,
> +						     byte_size, &first_half, &second_half, &ret);
>  			if (res == PARM_CONTINUE)
>  				continue;
>  			ret = res;
> @@ -1391,6 +1605,11 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struct conf_l
>  			break;
>  		}
>  	}
> +
> +	ret = parameter__handle_two_addr_len(expected_reg, first_half, second_half,
> +					     ret, die, conf, cu, parm, param_idx, reg_idx,
> +					     byte_size, info);
> +
>  out:
>  	pthread_mutex_unlock(&libdw__lock);
>  	return ret;
> @@ -1417,8 +1636,6 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  				return parm;
>  		} else {
>  			reg_idx = param_idx - info->skip_idx;
> -			if (reg_idx >= cu->nr_register_params)
> -				return parm;
>  		}
>  
>  		/* Parameters which use DW_AT_abstract_origin to point at
> @@ -1459,15 +1676,23 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		true_sig_enabled = conf->true_signature && info->signature_changed;
>  
>  		if (parm->has_loc) {
> +			if (reg_idx >= cu->nr_register_params)

it looks like we only assign reg_idx in the else (signature_changed) branch above; 
we should make sure we don't wind up using an uninitialized value here


> +				return parm;
> +
>  			int expected_reg = cu->register_params[reg_idx];
> -			int actual_reg = parameter__reg(&attr, expected_reg, conf, info);
> +			int actual_reg = parameter__reg(&attr, expected_reg, conf, info, cu, die,
> +							parm, param_idx, reg_idx);
>  
>  			if (actual_reg == PARM_DEFAULT_FAIL) {
>  				parm->optimized = 1;
>  			} else if (actual_reg == PARM_OPTIMIZED_OUT) {
>  				parm->optimized = 1;
>  				info->skip_idx++;
> -			} else if (actual_reg == PARM_UNEXPECTED || (expected_reg >= 0 && expected_reg != actual_reg)) {
> +			} else if (actual_reg == PARM_TWO_ADDR_LEN) {
> +				/* account for parameter with two registers */
> +				info->skip_idx--;
> +			} else if (actual_reg == PARM_UNEXPECTED || actual_reg == PARM_TO_BE_IMPROVED ||
> +				   (expected_reg >= 0 && expected_reg != actual_reg)) {
>  				/* mark parameters that use an unexpected
>  				 * register to hold a parameter; these will
>  				 * be problematic for users of BTF as they
> diff --git a/dwarves.h b/dwarves.h
> index 164bd3b..7f818d8 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -944,6 +944,7 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
>  struct parameter {
>  	struct tag tag;
>  	const char *name;
> +	const char *true_sig_member_name;
>  	uint8_t optimized:1;
>  	uint8_t unexpected_reg:1;
>  	uint8_t has_loc:1;

