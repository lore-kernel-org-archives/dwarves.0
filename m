Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72921E3BB
	for <dwarves@vger.kernel.org>; Thu, 17 Oct 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161863; cv=fail; b=XuKJABpgxO6V7Q43vuQJ6ocGX2KjsrDGDpOa3SaRA4ISAvgMnQpoIM+8UwdkZrpwyJoP6ExmnwgFvB2p/+bU3H+tHuPpoLKVOXWRQTpvbgCeD6CCzOctCT1LUU5503P4E6eEnoMGEUHkEuYGMdxgOIpfrp1qN9b3VltNBWTB/yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161863; c=relaxed/simple;
	bh=oIcA1MKMa3Oqd0NgoU5FVZxEIA/hiAUrgqcM4M/5+V0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uki2nRm2/QIYnLOiyHey8Ipngb+LfZeEO1Fo/E0xAP8cfTkBkIxePfllCfGWzYiUZLwG7BVhv99HY1WUoWw4Gohd8XPntjb7EcOq93r73ErBePaBKN4/ZM8wMT0STzlllvhURGPWKVe84/nfbtAJcFgQI3hQTpwWbDzSxrybJi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZmMJDUo/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b0JP8hUu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZmMJDUo/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b0JP8hUu"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9MctE014211;
	Thu, 17 Oct 2024 10:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/pGncrSDPioUFsiL4KG0G3lTyjRBeU3aCBPvmTYwsmQ=; b=
	ZmMJDUo/1I0ZMcV6T4IEY0nfT7wR/fgyTZkWQ+7nysTgP3ULQNSdVFf2Lv3cgS5e
	T/+E34/HS4/SpIhSKREOCHNU0GtDgKt6yq6yQNXum/+yt4j2kbHvHdcpkAR3nzgV
	BpmwykMrMuMtwl4LS1Vvyue0dnWh+3xNrQ8024t9F/4PxufptSOXxwCpSplaJRLU
	dSw5fPuaoJvDLhB2buvaCMHHQhIHKS46wxnTdEttK6yGgRlY0p4P9iSvlPCjE/0F
	YBau4SsfpA6o5R4L4lZpVVm4v+NlNQsrdskKKGwHz461iG+XmFL+jHuEm5+pdD/+
	QmxAmQlwl7aPmk/rlc3gqw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt6121-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 10:44:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9c15u019909;
	Thu, 17 Oct 2024 10:44:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fja1xbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 10:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZKy6Ha0Fmw3qt7ZCfphn8FT1Ngw7IKy4QD0kByHWKuQ32bpAQH9KPmDvsqrLjoSdZiuHdfv3kU18PsCiPvnL17L/IHzQGcIpV/+pIjaVpddeaJroEQTYL22wURz9lN588ev/zNPW2wKYUpH7W+vmpl+Dq5UZEZwVwqjNkjEZoiq3U7j03hRUI8BrFmUu30INU4LXpkv6GbJhYZFZ1N1iLQFHcLMwxJ/Dgv/wfmJCoSuxF5l2JZfH/Rf9ZdTlaRolhd3fSWndRv9WYOwd1F1eDTHOfE7qrNRKh7RqK32/Y+0AhtaJbyyIbBRl8CLnuxuxaKMnsd1Dzd4QnWnlfoQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pGncrSDPioUFsiL4KG0G3lTyjRBeU3aCBPvmTYwsmQ=;
 b=hoXsFzDGjHM7sR/mReZTJ0MK+hph+r8EL/wZKrSABMVjz5xMKAAAk8t2sDBYpaPNlL9j4gP/HBsaeuRx8Dlj60CgLv2+Invc6lW2HDx+3IxmLeR7sHMzZJz+o6gjWWsjxsnogbq05PXQ6L5NfY0ZrF/GdvAPW6pTqHxzFAvtWkyR+EzLfREWf9vEyX0kzhSTlyiKtO3v0ThNfTyLbi7og2xC4yaC9Nwccxidf6CPs1XTVKLE0q5Z0SG3/njHhyUONAsjFbpOB25F23coVUGIGFyOT7viw7QoQ9d2YBMx9ii1yH6r6yYgQ8k6kbM4PO45BKBS/J6W24FwQuSZ1yw8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pGncrSDPioUFsiL4KG0G3lTyjRBeU3aCBPvmTYwsmQ=;
 b=b0JP8hUu5dfKDFSx/PxTaD9/QTAsM5lV4FrkroslsTzpHXrIkCAPOJwCZIZJrdGUh8xD8v241Iv8JBXDEOha3DCqDQlltTn/RTeNUf8FTY2p5LXwA1o5BNdKyv//RsO8Jy0f6V0qGmRIEdmOgK9yU4eFH7pvXcWhwn9Y2uOPn4Q=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4799.namprd10.prod.outlook.com (2603:10b6:a03:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 10:44:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8069.020; Thu, 17 Oct 2024
 10:44:06 +0000
Message-ID: <5c26452e-a550-4b4f-8be2-3f1556052d94@oracle.com>
Date: Thu, 17 Oct 2024 11:44:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 1/5] dwarf_loader: introduce pre_load_module
 hook to conf_load
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, andrii@kernel.org, eddyz87@gmail.com
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
 <20241016001025.857970-2-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241016001025.857970-2-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0408.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::36) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: dcff45cf-2c07-47cf-9afc-08dcee989fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlVCZWlSeEN2TzQ1cnJPdzZLV1FONWxsYmdRWFd4YWdkTDhVU2Q3THRQSzdw?=
 =?utf-8?B?Y3NGVUFPNmZhWXhTcUtjWWxKM2F4bDlmUWVqN3oxam1mVHhhWkNkVjZzNWZy?=
 =?utf-8?B?UEgwc0ZFSWs0elpzSXpIV0N5Smhqa3dPOC80UUIrbjdXdFV4ZGprbktncEVL?=
 =?utf-8?B?VFBYeHl1SHZnZy9Ubk5hZGtmL0xtN0xFN2R2bTkyYm1qNG9NNXZWbWNxblJR?=
 =?utf-8?B?VDBvemZjMjVsb0lZaWJ4ZXlXTFA3ZStTVGhXd3kzOFRVOVAyVkg0dEhrK0VN?=
 =?utf-8?B?RXl4OXFpTlBYWTBPNVZndmtYVnpOdW04cGFQTmRTVHdBemkzOXRLdHB5cCs5?=
 =?utf-8?B?ZVJER004OW5wZ0w5VTNFQzFGdmFGL1htTFZxdFBHZjVENHkwb2dsV1VRZzRa?=
 =?utf-8?B?ZFFHenpsWitrNkVLUlNYTTMzUmYzc2pNZFVqNlo2R0NZTkFhNDkrZWI4dFJX?=
 =?utf-8?B?ZGlCRVFyYTFIUHJoYjZOUWlFQ09iR2xFdkhKVkwrSW5qL2lkU0RKenJuQmJj?=
 =?utf-8?B?N1p6Q2Fld2JrRUJHTUF0K0ZIMnUwRmpBWGlTd2ppZDA2ZDJ2dnJ0bnV0WGdp?=
 =?utf-8?B?UWMvU3ZXcDl2VFkyR2ZZTW14KzhoejZiOGFCam13Z1hhcW1WMjBQVUUwUGVG?=
 =?utf-8?B?Y0FHSkhzR1ptdjZhcVZaRGZzaTY5bzFzS1I0ZDVDTHVMWG02ZGw1S3UxYytw?=
 =?utf-8?B?N21JaUc3MW5pWWdyckEwNHlsdWZhcjhNb29aclY5U3dmdU95YWlaSTFTYS8y?=
 =?utf-8?B?MG9xMXBoVDlGRkFEaUp5cCtPd2tEVlFPZ1luNk9ocStVR2xybmRGeEl4UjFu?=
 =?utf-8?B?WEVXa2dzcGxYYVZnVVRRNXJVdlN1UmlVR0JxUVZFWGN6a2ZDbTdlb2paaUxN?=
 =?utf-8?B?MHJ0Q2VIamZBcGtnZ29ya2NEbnRqMVlDOFdEUTk1dFg1Z0xDWkFZa25OVk9y?=
 =?utf-8?B?ODRUVkE1R3lSZU9CcjV6bHRrWk1Cb2xLS3IrYjJ1eWMvUEJ6aG5Ud0w4MkFS?=
 =?utf-8?B?aGFsbW9RNnRWNTEzYmxZbG9wenpQc1FQbXBrbTRPMkxKalZlTHNycVhmaGx3?=
 =?utf-8?B?bS9jQ0pNa0F1QWNVYWpRVXgrenYyK0Q2NEhBYUFMUDlqbW55UWc1YTJJTmh3?=
 =?utf-8?B?SStmbGZTbzFHUkF5cjh0Q09sVFN5RFNBVFJ5MnduZVBoTWhKaU9MUTUvdFNy?=
 =?utf-8?B?NC83RXYydUVYbmxRU2hhc0t0b0poV05PVkN6Zk9manFJcEI5RnpEUG42V05i?=
 =?utf-8?B?T05NcU82RHJ3SUVnS0oxL1JBSW5TbWF1UlpqY1pkd1BNUEtuenN6MlBKaDBw?=
 =?utf-8?B?bnBrV0tzNXdaM3ZvY3lQMVRLenczVzZPbW9xckRnOTErSDZVdFFaR2ljWnlq?=
 =?utf-8?B?TDdpcHZMTTltclVqMjBWaFNsaTNTV2hpdCtlYmcvTWYyMDRSR1RiWVZab2ht?=
 =?utf-8?B?TmZrdjUzK09nNjhON0dSKzhRektmWktSMGtBZVB0VkVYdXNDWHExSjlMcW1k?=
 =?utf-8?B?VmZKcHRYU1ZReUxKME8raEI0a2FMUmg5T291b2dtNTd6bysyV0FRWW1OU0FG?=
 =?utf-8?B?M2g3a2oyVDgrMkFmZUFSNW9rejZKazU3UkdGa1dwZ3dPK1VZWU14ODhuSktJ?=
 =?utf-8?B?Rklvd1gyaUxBbWp1ZXk1LzlRQWFXZExPbnhwOFc1NU42SmJ0NlorWlJkUUhE?=
 =?utf-8?B?YlRnS3FaTjdmM2Q5cXdReW5NSW1RUXJuR0FKZHhDMEZoNHpUNkYvNkdyZm5M?=
 =?utf-8?Q?RD0hRX1cMUKTI0VXt8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDZlSnhHSGJValNjZEUwdzdndDlUZE9ZUytNREtnbkU4ZWhLeStodU10bHZW?=
 =?utf-8?B?NWdxd3RhT1ZsamYxWGR4MnpGRnFQMEU0SmRURHF5L285M29qN1JqNjlZUXhC?=
 =?utf-8?B?MlRwSXEwaXVSMEhnRjBrekJGQzZESUUva1JYZnFzaEdXTE9BK1B6UEtHYndT?=
 =?utf-8?B?Um5adnJsUldWRVdFdzBxVmx1djNuVkhsZzlVVFZoUVpyWThNK1A2VGFnaVFq?=
 =?utf-8?B?cDFJM0crYmtBUFcyeHl4dlFqNVhZWDl2RzFEN213MTZLWXozZVdhZGUvZ2NY?=
 =?utf-8?B?UVozSFF4QTRxSlRjQTliM2tES2JkV3NaNVJGSmdMTFFZVEliZXUzRUdmQzRJ?=
 =?utf-8?B?NVFuUzh3bUk3NjZaeUtLczZxUGhnNEN3UzRIN1lXVnJOd2oxQjMyMGtmVTF5?=
 =?utf-8?B?M2MrUGRVeHBsRXhpYll3YW5SOURsTHVtOEZhQlNuN09FbGtFL3REL1ZNNDhX?=
 =?utf-8?B?aE54VXFqWVg5aUJqbTRQT2dEdVJZdld5cVU4WUQ3Ri9KWXJoVFNOVzAvejV4?=
 =?utf-8?B?YkFNN0hZQ0o1YWxZWldWY3pkcVVCQW50VjlSejRULzN2KzVXMGxwTDN4d2xs?=
 =?utf-8?B?WXlPS2tVU0pVOW1wTVlwdnRKeWVqTUUrY1Z0VnpuUnNiM2pTdjZHbU1xa2dF?=
 =?utf-8?B?N25XWjhuT2FzZjdYUzdKQ1E3ajVpRTFJZ3N0RWdXUkN1dnV3VnpobFVKVzR6?=
 =?utf-8?B?Q2dacW1QVE1wV1pvMk5mSEpkS2tEcEhMcmJLeW5GL2V4NVZQd1FTR0d5a3FH?=
 =?utf-8?B?SHloZENGZENKMFdHUUU2aXBSVzBYTERWS1hmd0NVT2hoMlpNZ3VRWXBpVVdy?=
 =?utf-8?B?bGJPSkxMbFY3TlZwRm1hY3dmbHcwMWNTbFV4RGZtM3Nia1AxSHVxMTdaeFJm?=
 =?utf-8?B?cTJzV0puOU93T0RYQXBnVnQ2blBoWENOWlY3VEdhM3hLbXBFR2Mrc3kvd0VR?=
 =?utf-8?B?bm9EQ0orZ0ZCd1N5RlRwRE45YWp5NnJ6YkhLa01LL2FDU09HaDlwak5iMHE1?=
 =?utf-8?B?WjRVdmN3Q0FYSmNNSndpVlRGWmpQbWJJZEEybFAyTGpKT204ODliblpwb09G?=
 =?utf-8?B?aEF5NUxkMUR5M3NYalpQVnhmcFVSNG11TXp0UGdaSXE4Q0pWRGtBN3J4Q3FQ?=
 =?utf-8?B?Q1ZzQStkMFloNFp5YmNyRGVIeHRTbXoxbFV3RTNROHN5VVRNRWlNajB5K29i?=
 =?utf-8?B?QVVkTUI2RUFXcTQ5T3VkaE14WGRTQSs1ZEFxTmVyS2Z1N2NNdEF6WkNQV2Jq?=
 =?utf-8?B?YTV5R00vUzJhWnNieGFaR0k1cUFQMUFTb0wxRHpwdUNNWjFwSHpYSHFVcFdP?=
 =?utf-8?B?Sy9qdzRNWk1sazkwTEtsdXNpU1pRaDBkRkROZ2lKQm55WmFkRUVxcG9zR2po?=
 =?utf-8?B?R0s0UlN4RU5Dc0xsWTNyb1BNT1ZKdk8ybnd2N2RTNWZvbk0rSmk0YzVaT1Jp?=
 =?utf-8?B?RTljS2lBL2xhakowZ1hxUG5JekF4ZklJZnd4SmdmTWd4MjhYUVhlelB2Vno2?=
 =?utf-8?B?Tm9qYUZ3TGU0Ymp2NmNDeGQzWk9mSUZNdGtoSVZGb3B1L2JjNTJ5eUo2Vmh4?=
 =?utf-8?B?allEYkJUbUpyOUpvcHcwSjFlQXh6ak92YUUzd0VqQUsvaVdHbDRtRjZxVG9I?=
 =?utf-8?B?aDV0OWVzanhWM2FNMm1IbW10OXB0VC82N2hmRmFoTEZORnZxdVFINkJBd0Jz?=
 =?utf-8?B?L1YwV2Zjb0JoSFJDenFvQnBBSUFvemROby9sMFNUbVdLY2wzUlY2WXd4bjVU?=
 =?utf-8?B?eW5mQXFOQTI3SEkycFp3V1lTOXJpU3RkK2s2dDAyVXNmajlGRnJWaUR6Nnlj?=
 =?utf-8?B?Y0Ewb0tiZ1NDbW5NTnFwYTNWT1FvTDRTZHdBenBOK1IxQjdCc0VsdzRFZ1Jy?=
 =?utf-8?B?YmJPNy9FZC9iYmhUZ1BubTIvOHI5TTlxZ2Q2WGdhc1dONURZTGxJTHhiMnZI?=
 =?utf-8?B?WlZydFl6dDJPREFjbFZEUEdyNkZoSGUxcGpWbGFObFZ0TjB6MG1wbTh4MVJz?=
 =?utf-8?B?a2lHUUVraGwreE1YeGc2WEhHK1pvT0hxRUV6eGhUZjNWZDZudWJDd3pXV0Fu?=
 =?utf-8?B?Vi9EWExGb3JjTjdveXpVVXJDMXUrcDdHOU9WTWtlRWs0dGF4ejNaV3V2ZDJs?=
 =?utf-8?B?b3RFWHlHVlFpcWxPSmxZZWxqZUQrSHVKN3FrWjV0UnovVGNWSDdBQ2tRRm44?=
 =?utf-8?Q?ebu4NuJq40rxS8w6pN4+n80=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TriiJvwNsfrslSugddXnFJHoUUvuJ+/TgyE09o8b/zenQNUOEbaUUXeShOOTwf922ZqvF0IHYzCj38+x51U77KBzs8ufW5J5ynHe1ABOrL+uL4OkOqpsbDmMrd+BgfE1G6FWyNncjh67sgZoQamaikCTzUIdMAyOtTJmGFYGjilI4HwGqYjRB3q0axN+8yAEm7+TD95egj5rZ94Km7jqu1yTZUl7Ucr3dv9oVR1aPqbtt/Llt34851rB1nVvzB75ozGbh/9ucy7Dq2RrTly/XJtQRc3c7sYt//E1AJq+DsbzZtqezKzt90+i5/M2utvGn86lzy5X1MqBHbwPpV523PD2oQu7GHX1s8dgqlFCkIxoWSofUgSrYqs4haOYG1cEqba4JloOWocYBf2B5Usoo8iRTYLqp0dMMxHGogErTetKmK4OVpE3vOm3uOvl0OXYMed+mqiqtxTjzg4ZtCqTiCT0YQhRUe5EJvQQGagDh1otDnVmoTJP1k074w8bu0hRdsYbr+3FfJqawJ6c5PfmauJ0FZ0ZYk3ki5btTdEgflk0L81q0YhNyDrWccW7urcDVqe6JVOYQOS9OKASoiZGL2K1M59qXeI56dwJ/6sKZRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcff45cf-2c07-47cf-9afc-08dcee989fc0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 10:44:06.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wm59szrjRNb1WZ7nTbQHhHYluq2xv15HxOONdX6IscntR92fIOgaEDwE9UIqwU6gyuzzznio+mzxm+A/BpnsAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170073
X-Proofpoint-GUID: 3ryQybjs6W5mv08BV51HIxunf8Vo2DOI
X-Proofpoint-ORIG-GUID: 3ryQybjs6W5mv08BV51HIxunf8Vo2DOI

On 16/10/2024 01:10, Ihor Solodrai wrote:
> Add a function pointer to conf_load, which is called immediately after
> Elf is extracted from Dwfl_Module in cus__proces_dwflmod.
> 
> This is a preparation for making elf_functions table shared between
> encoders. Shared table can be built as soon as the relevant Elf is
> available.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

looks good to me

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  dwarf_loader.c | 14 +++++++-------
>  dwarves.h      | 11 +++++++++--
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index e54a16c..83a7f54 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3723,13 +3723,6 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>  	return DWARF_CB_OK;
>  }
>  
> -struct process_dwflmod_parms {
> -	struct cus	 *cus;
> -	struct conf_load *conf;
> -	const char	 *filename;
> -	uint32_t	 nr_dwarf_sections_found;
> -};
> -
>  static int cus__process_dwflmod(Dwfl_Module *dwflmod,
>  				void **userdata __maybe_unused,
>  				const char *name __maybe_unused,
> @@ -3753,11 +3746,18 @@ static int cus__process_dwflmod(Dwfl_Module *dwflmod,
>  	Dwarf *dw = dwfl_module_getdwarf(dwflmod, &dwbias);
>  
>  	int err = DWARF_CB_OK;
> +	if (parms->conf->pre_load_module) {
> +		err = parms->conf->pre_load_module(dwflmod, elf);
> +		if (err)
> +			return DWARF_CB_ABORT;
> +	}
> +
>  	if (dw != NULL) {
>  		++parms->nr_dwarf_sections_found;
>  		err = cus__load_module(cus, parms->conf, dwflmod, dw, elf,
>  				       parms->filename);
>  	}
> +
>  	/*
>  	 * XXX We will fall back to try finding other debugging
>  	 * formats (CTF), so no point in telling this to the user
> diff --git a/dwarves.h b/dwarves.h
> index f147b2b..eb3be6e 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -36,6 +36,7 @@
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>  
>  struct cu;
> +struct cus;
>  
>  enum load_steal_kind {
>  	LSK__KEEPIT,
> @@ -58,6 +59,13 @@ typedef uint32_t type_id_t;
>  struct btf;
>  struct conf_fprintf;
>  
> +struct process_dwflmod_parms {
> +	struct cus	 *cus;
> +	struct conf_load *conf;
> +	const char	 *filename;
> +	uint32_t	 nr_dwarf_sections_found;
> +};
> +
>  /** struct conf_load - load configuration
>   * @thread_exit - called at the end of a thread, 1st user: BTF encoder dedup
>   * @extra_dbg_info - keep original debugging format extra info
> @@ -106,6 +114,7 @@ struct conf_load {
>  	struct conf_fprintf	*conf_fprintf;
>  	int			(*threads_prepare)(struct conf_load *conf, int nr_threads, void **thr_data);
>  	int			(*threads_collect)(struct conf_load *conf, int nr_threads, void **thr_data, int error);
> +	int			(*pre_load_module)(Dwfl_Module *mod, Elf *elf);
>  };
>  
>  /** struct conf_fprintf - hints to the __fprintf routines
> @@ -167,8 +176,6 @@ struct conf_fprintf {
>  	uint8_t    skip_emitting_modifier:1;
>  };
>  
> -struct cus;
> -
>  struct cus *cus__new(void);
>  void cus__delete(struct cus *cus);
>  

