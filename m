Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136A37C92E
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068260; cv=fail; b=VVGJFNi5ijNcZwRbRdKsa2Il73OOB8Mn0DvJmisiX1PQlQu2/JOcns1cV/4zA0TP/derhfgh9YsmSsoJuVqB8tB2xbD640fs/gisd7WTsLH8fXM3f5sRMflSZbNafNLkVrQ2MJc4DDJmSDqe1TGac/uV7lD0ynG6fhP2mhktIK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068260; c=relaxed/simple;
	bh=PjvobfWBK8+8HRZF7sFnt0hA/ammyf/S7w+ppgZiVIw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SxK6SQEnAheMJdcDqFBPkELCzwbuG34XaWsg5qHAjPZ5uGdJSA/5MIp1DFsmuf5MA0b/MRXdNwjrNITJw3G4y+oHlsjwohb+ESgEbwqS6uZg/0UHIwz//YDzdXenrxhQswjwCRoaflI2czSBsXJzyzcCRyb8X7qxibDKw6JpqEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OFiGH1JQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ojp0P41w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OFiGH1JQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ojp0P41w"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CM43VM783128;
	Mon, 13 Apr 2026 08:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YDTBdfQLxtZR4yYp8XuNQDV1rG2Qd431Bqu1a+qZBY0=; b=
	OFiGH1JQ09legUe5KNFn8wb+CoSnKn9u+NerX9uwt3XT1LgRQ//11bBQEQ16hgAa
	2VX/QVymogETpu6MnDv6VPILDU174JdIHiwkz8bTAxMrAFpYVxoYIv5kK/8+BVie
	Ag4VShgPWelPnAVUZbkHHGd2wNcUv8gKqhnZmw61yhPCQsyox9EBoU9x3WPtidP7
	dv6vKDReBCI9ZJxsGcBrij9JYTyR9eTQ+2V1dUyT3UmiwfDQrRMQlrm06JpJeZVZ
	Wb+XZwyp+nsLB7pm9K5xuW2OWvXxzmBy2Yrt/9zriQsgkscOwj6olautRKVvrDJl
	g0oB9u7g6pDnuzvEaOihBw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dfebdjpkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 08:17:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63D8EKvT011358;
	Mon, 13 Apr 2026 08:17:28 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dgbr7xa6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 08:17:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUVrbA3pIpC3vaZUERznKOdVmIEZrNdcV0StBV7d4PpvSSrTfAU/Ok4t1q80vtVZS2eRSTtWlZAMTLhNWU1R6bxyTW82TDTi7I/q0dwitQztcXn++ZpCvSWFVwJegzDOZEp+AEyqwOR2oE3FncUppYiKpA9RA1oetSoDMvc/QzVI0hZGKxdAGZK7c1a3fOmoMd5Ieve8uhXVGxZSPlNIigNdShK1GBM/9/wrrkCECMvrAgXYtuy5lXk1vuK0yiVIsHsa6XPOKH2XinBGpPiBjQa+2kR9spiYbx1CKQtGcVNUw+o+dAAW9HunFAD/nIBDzdBf5VZwroNXwbg8COgbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDTBdfQLxtZR4yYp8XuNQDV1rG2Qd431Bqu1a+qZBY0=;
 b=ym+6K2MMAF9MDYSYIApmpuLUoTXy+DSwm776HHhGyZpiWfUfiLXCjd2ndtUxZz33Q26cyLBsUitlWlCslLOEFa8Mli5SKhpj02x46EhBQ+bi6g50I0Jph1HZcc6PLypyZ+sU3OaWKuNqGSRVO+h9iNhj1mhLAPXz5wuw05yFGGJzk8hRCCIXDX/RYH+Uf5GLjfzH8zO2tP+E+Sm+tHpBWtg5DMdovgFDBsN2QVEe8LoudUd9cP/u4357mV1WlfJdqFa7PVlv4mtm0WLhpWfxfPm+elm+K4JRLP9PjsBGdlhqJrP6iPrPoqf1RIHOg9LakE11vsqL7xADcK/YOKktmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDTBdfQLxtZR4yYp8XuNQDV1rG2Qd431Bqu1a+qZBY0=;
 b=Ojp0P41wFASEXJak785TViKdk28wInYPCcbzLkVEznkOAWkbQTyBTVoldorIc5eUxP36e5K0yJ4O50Apk9eZSfXd2ZDgLPX3AUdsjZp7ekTDMT4Xbl4khNf7jMZzTp3WsrxC5yBp7PlY5hL88aICn/EblD0VrqHrEzlT/Xu8e18=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA4PR10MB8753.namprd10.prod.outlook.com (2603:10b6:208:55c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.42; Mon, 13 Apr 2026 08:17:25 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:17:24 +0000
Message-ID: <802bfb01-c1ef-4c33-ab46-d52f13ed6fba@oracle.com>
Date: Mon, 13 Apr 2026 09:17:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] man-pages: Fix incorrect command line argument in
 documentation
To: Gal Pressman <gal@nvidia.com>, dwarves@vger.kernel.org
References: <20260409144718.1582227-1-gal@nvidia.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260409144718.1582227-1-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0036.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA4PR10MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: de2a7222-65ce-4961-5a67-08de993517ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6iM6EwUcoOMth46lD2+MGNByPCMVHE7akl+SHoc35TjBK1KFevOZLD4mi4eGcvwgkJT+ve8sR4sxviYueJgIvOzyX8+f41FG5parncUvYfmpN14nei5s16zuJm0vEl44N3nIjBynZ4IR6lKuxLADB12JQcaSh6KdPSMGMnHij2DyGVrE2A2rjlo8JB+h1oLS7KQgLvzglaBv4RlJuTd68SzbRcbJloR9XJR/ZaavFZZ2+lg4H2OBgfeBfWtj17SyPNdSVvwGkj4/07xG26miuFBxkyeG2G/q/rqyvEebg/xd82FN9aaLN848lpfk6tskzCge7mEaRy+3nuLmK/58T2fEyF/7a2wb3VSFgIoC/Hfo76QDS6DceTsrlUhg9Vy3DBfvDmzdd5agsm8OCKbanpSvt/LufWD037SPtLldI2WiER/KWO6g5v7lTiiVUAJPnbk2Z7hspALq7Vki58te+efbMcgcwB/13WSqXeI7QpwGUlThjkyPeVCLlzyZ8Wpbao4USTOOd7vFxNsu/OjICdWWaUGY2c5Y3FGs+HorY0AUnCqQN5GM37gaiZMAoo5v/02DH410OIw6x5RSspaQ3qsluikB0S8+GTd8sOwMxwRAI2rpbn8d3q69Gqdmi/qK4oRpQ8ensUarkJsVW+XpZY56CmFYBLs4tqUHuZx8tWDkVHJ+r394lSdER0JhGEwalR8CNi1ee+cb/cvgAxmZSQcbWmYI2RZgHt/rW+SrXto=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzdKeitaWStTYVJCajRGa1JVZEtWU0czTWljZ3N1bUFKdHJTNXB2bmxHREJa?=
 =?utf-8?B?NWtZVVJrdjVNQWpSTmVpWHBnZ2JhK09Qc1p6dkp6WkkxVHFtZVJ0NVMreVox?=
 =?utf-8?B?WW9DUWNBaGJZaGxjYVpnNldVWkM5bndNUW0xN1Y1UzFld3dvUFYwdXRhc1RV?=
 =?utf-8?B?akRLRlI5cmE2MlZudkhhYzRDcXhHZDUvVEg2ZXplK2Vkc2t6YUtrd0VDNFA2?=
 =?utf-8?B?ak9TTGlHNERhc2M5b0FLRUxvbUZyR3laQ1hHMFNOanlaRmNIOUFKUENyOGV6?=
 =?utf-8?B?YVB6N0tvbUtpeGFkS0p4VUlIaFF4U0QreHB1ZzlzTkw5R1JTbXRUWDBQTnUz?=
 =?utf-8?B?MmtJTW4wblRTRDM5NTgrdDhDTndNY052UjFtaFFmb3p6TEJ4UHlDazM5NFRO?=
 =?utf-8?B?M2xYb2FwUk5wZkw3dG9kRUh4U0pqb3J3Vk1pUCtmWHkxSmJLVTN4VEVCUnRH?=
 =?utf-8?B?b3RyQ3BORFJxTVVLS3F4UDBvYzFqWkgwTVorSkx2Uko4TnhCT01HaUxYdmxt?=
 =?utf-8?B?N3piRVhiOHpDMExNcVM1UzJxYlRSclNiL3QxZndvMklHaTgwOFMrdXV6eEUx?=
 =?utf-8?B?YkQzaFlMc3FnSVlvYStIY1A2V2xFMjg2YVNEOUI2Ynl2OWdxajV2WTVzR0pl?=
 =?utf-8?B?b29ncWsvV3pETnFxYWQ1VWhjY1MvbEVweFRYVGlBeWd4aS9zM3pFTTJkU0xs?=
 =?utf-8?B?MEgzSWlyeWFuZTNFczdiWlY3REJMNFl4VkM4ZHZOTUpaaHFraVFZMjVZNUV0?=
 =?utf-8?B?dTlpRktzeENmd2lHMEpIb0R4OUVkWEQzQVJqSHEvVi9waFJ1QjVldUVmclRm?=
 =?utf-8?B?bGUzaFBqd2VvaG1KZnY1Z2pwUGhIamhQSW9JUXloSXlXN3VyVm1WNUJ3SkR1?=
 =?utf-8?B?SDRjODZKaXByYUpFSytzVXJNaTVNNnJhcEp4VnZoUFpucWFZUm5Cb2szemRT?=
 =?utf-8?B?aXJhTklJOHNHNThVWWFtcG9Ydy9tS1dxK3Y2cG0zbGhpN1l6UG45T3o0SmpU?=
 =?utf-8?B?ZVlXUXVnSkxaZnV5SnFKQUZteGt3MFBsTXhBMDJsODdWZ09manBzb0ptRkI1?=
 =?utf-8?B?N2JrMFdFWm9OSU40N3FmSkM3MExTVVpmdVZtQVIyYStQSzBkdXVnRGUxVjU3?=
 =?utf-8?B?azhzNWdEZ0tQL3d6SmRiSUE0dUpFQmxnUEwxazl4dTJZME1FVzllTUJuU05S?=
 =?utf-8?B?Zm9raXlReHh1TDM3c2NzN2dOblIreXU4WDVRdGExajNPRUZ5ZDh5NVA4UEtu?=
 =?utf-8?B?TDlUMHZpaG1WV2NzbzA5VC9KeDN1MzRlam1sL1FhUSsvR2JvOUp5eXhDbGw4?=
 =?utf-8?B?MDlFYXNYNXNmNFA2R1IwK0RaWnIyNDRsaExFV2NQVmZtcGE4Njkvc3RQNlYv?=
 =?utf-8?B?ZUpFMkkydzhoNTVPVlB2ZGM2bjdEMHpSZnZyUFQyRlovdlVZTk5KYmpBSXha?=
 =?utf-8?B?K0gyOC9ySGRlV3hORnljdGZiQU1ocVdxNXhsYVRtSytrNEFZNndmbWd3R0I5?=
 =?utf-8?B?cHNlL3R2NzU0Vnp6RjFTZWVEeVAvQ2NwZEk2TGVYcGJCcW04VFFNNkJ0a0ph?=
 =?utf-8?B?cXFBM3l0djNuQ3JwNC9Ic29Ubm82TEU5c3lGMTU3YzRtL1YwSkdQR0JxMnY2?=
 =?utf-8?B?Y3pyME92dUxBTmtzVDN2aHdza0hweVFUdmlPRGR6aEhMVHFEVG5BVndVRkRn?=
 =?utf-8?B?MkF6OHh3OURYcGEyaVU4L3BDM29SNU9LYVR3Zys5SVV5Y2taZW1KTFpJenFO?=
 =?utf-8?B?NHQ4YmdDZ08yVUpWZ1RXbGhHZmE1V2h6VVNYZHpyelZqbkZVVmZUbG9ROHcw?=
 =?utf-8?B?NkpzRlN0bXRvTTlkMlhhV2dua3dERGlTOGc1V3BSUkV5Y2txbDlIWGdKcktK?=
 =?utf-8?B?eStWcWlVRTBGVjZSbzJLRnBZRUJOVWZnT0pmQ1hmQ3Rlc1plMEFQNjU5akpL?=
 =?utf-8?B?OTEyS09KNUE5anVIYUJGV0JYSUxUajFiNndwTlFNYkwvbU80Q3cxTlJaY2pP?=
 =?utf-8?B?VEJpblpGSlpvbE5EZHNxVlJzckJubVFUNE03VHEyd01WQ0Zpcm4yVVBBVmZi?=
 =?utf-8?B?UkRsZ0hkU20rNmN2MFNqeSsxZFNpWXprT1RxaGJYR3NYOEJGM09RdmFzOUxl?=
 =?utf-8?B?K3BZSnp2UjNDTmoreWJ6TWZyQ1QxNVhJZXF2cXhzMmZ1bG4rS1FDZklJMmV5?=
 =?utf-8?B?S1N6T2pMNkZkYVB1NFp1ZDlZN2Z0RVNVVm52VnB0ek12cVpEZ0dkL2paYkhu?=
 =?utf-8?B?Snl2SG5jYkMzMDZQTFVvNm53ZG1Uc215MnVRUC81ZFJ1QUtoaVBVUDZDeFN0?=
 =?utf-8?B?UDV1dStNRTc5NUFPSmNEazNrVTBxcWIyNWdUMzVHdzAveERMemE1QT09?=
X-Exchange-RoutingPolicyChecked:
	blsqILcD/iTmhlVqzZdX1ypSPETnuzOhbwnDdSTuS/5A67+yPCRUfI8fPfhKr97Zx0+zL39AZJQxksSp4HoPY1YmKzBCkDjeDob1dDNAJwPP2VrqBjeTF+5YjEJ06+TiURsmibvLsxvKHHMMua85AGYNL9NENrDOlPYs7paIKLVgp71QgLGcOq5WB9oTv1KgvhfO0Rdtz76oi2BFYlcu1Ki2l6+yJJD7BUkbWPM7HvUoKDpdIHxDpsgnuCOHiQ/IyWVFx/A8CdhbtVNIx6XD58ZzyC/Jg/W1t8/8iwMIrKd7IX1IxhKVMwFYE/LrTk70r4e1dEzPjclckSZeJcErxQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T4N3EZ0D5Wa/sutViVd7w+r7RYc3wy1OJhzBjQnIENpAuk0a7yZL6anB6NTwOatP1NG3MJCNj55qx6hR3hvrcIivO4PhGtxZeUh+CvkVQ/XFktVuVTsXVeobNUuydco+ii5Ii6VytIEKFgvhumV5wI5Z8Amu5MCW1DO4Zh9B6pioIDctO/Iui4+zdDVGfbZFTWKwCEYTL61qVGtzPzVoaJ6Xb3MVTTXGrbT+lYQ9WT+CT25lUz5jEcgtjUXrBl1MooJWPVJKFdFdMfpXyiMPM8lYTUrvEsFsgTLzRL8FYtJnvE/UaaUJtNrADWVxo/bXYINeAcun5fkdRUo6vnbJxm9102HjFctmQPXbHah7gLmZI7mTynDdHuhScDgZ3QwH7CYFf95aXnJt9g3mu/Xuz1MNLlIj9yt3EG3pFT8/NFIHHRBAjCzKrdWObSISSSjKBFl2Gt6ohYnxEnOqUpthnPCCooQlVh+8ueQEZDt7odzlnavYWtvmQ3/QPK0q3eVCtH9vmpbsSZBlXF+QTzDNA3labvkQGbmZ3rp+Kr9QkQbfACv0BXb/F2hrPOj+QNQmyKEFN/QS6Nyy+zB33YIpuJfYXlySPKF3mDKYbZR5QIk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2a7222-65ce-4961-5a67-08de993517ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:17:24.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwpy5S+1Wu9Xv0lRpZqN0WGDAvYlxGzCf6X0WNip4e24zw3l0rjZmWNa4ycj/I165STizuOI8v7DQJbyjUMYaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604010000 definitions=main-2604130079
X-Authority-Analysis: v=2.4 cv=aIjAb79m c=1 sm=1 tr=0 ts=69dca699 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=Ikd4Dj_1AAAA:8
 a=ET8UCdRpZzU4Fg_K3HEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA3OSBTYWx0ZWRfX/YjrxTN62b/4
 /+OYH2YlCKjpZKPFlUUdhGMHgALVlWTgwAJWJG38mhg1DAGqcfsypsLphpgvwHcRNeCPPg+jtl4
 ijxrxYLjr/Unr1WsMDsh8XC5zeRaIprG704mV2CKzJpx2GvYlG7D/1P5h+tAPlOtZ5pzGpNBU0o
 KePGcKY1pJ6bPr8EYCQ7p6wBgxLBOpQd2UO3aMfiq4GMq42aDG09TdsE0MYO4Zz0vJYbalNKwll
 QZ703QYN4aIWjiN3l0qLyO6lrlDVgoH/k3/dEalwWJfI0Vi4O8kkg2SnL09cp04wuBBudZzaCg+
 iMIrvmMpmUQ+XXH0t6G9j6ZcSD35xBVFo/Afp1F0Ywi7FwKqJ94F4f4KE1DuQAUxTnY6gCqrAKm
 40hw+u8zTyQG1AlKTd9uk5oaYHEHq5QkZHrvyP9SmU7MRmDXSKCBHVrupM+TLo1VdGWlX+Auhna
 YpFEAVJmv/6ilrpne2w==
X-Proofpoint-ORIG-GUID: Fp9KbAfD4zQ5kyFxpX20wtsxSpraVD1w
X-Proofpoint-GUID: Fp9KbAfD4zQ5kyFxpX20wtsxSpraVD1w

On 09/04/2026 15:47, Gal Pressman wrote:
> The --with_flexible_array and --with_embedded_flexible_array arguments
> were wrongly documented with the short argument '-P' (copy-paste mistake
> from previous argument), remove it.
> 
> Fixes: 7eea706c1499 ("pahole: Introduce --with_flexible_array option to show just types ending in a flexible array")
> Fixes: 446c28d118b9 ("pahole: Introduce --with_embedded_flexible_array")
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  man-pages/pahole.1 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 90a8f4566de6..19067f4fef03 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -404,11 +404,11 @@ Show only structs that has holes that can be packed if members are reorganized,
>  for instance when using the \fB\-\-reorganize\fR option.
>  
>  .TP
> -.B \-P, \-\-with_flexible_array
> +.B     \-\-with_flexible_array
>  Show only structs that have a flexible array.
>  
>  .TP
> -.B \-P, \-\-with_embedded_flexible_array
> +.B     \-\-with_embedded_flexible_array
>  Show only structs that have an embedded flexible array, i.e. a contained struct that has flexible arrays, a flexible array "in the middle".
>  
>  .TP

applied, thanks!

Alan
