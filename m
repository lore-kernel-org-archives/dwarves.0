Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A33B8921
	for <dwarves@vger.kernel.org>; Wed, 26 Aug 2026 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744606; cv=fail; b=HVxgbtICcaTwUAWNatva6qYuuo8oWpH66j8wMLnvwOrZp1uWIDwiyEFUrYz6kcBRZJkBHcUeRL4SRP0oPpdvAONzmumIgC1NxLU9ailm4Y3jc+ik3uHbVxM9+rDmAEVVcnYbDBMMDQlhiWadIiUzWjb3rqNB0uUg5v81a2HFk0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744606; c=relaxed/simple;
	bh=S0SWhqqYLfy4pDoUTnAEGeBO21qeZHgEctm5pJn55S4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NmjHLUjoyaPBI3C20uTO/qecy3cg57/IbdUvsMPXfRjX579lF7jk9l/45qiuNOY+Idl2csYHmKOuJdZAPEY9CVNQF0EKZ1fCu6/cksgl6tmIKX2bny+W6yFv8mS8wNPJDie0jIBmx4nyqiKbH1F/2mNpRvyhEFUbtxZAlWpFvto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TL6aUH8X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0IWCjsqW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TL6aUH8X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0IWCjsqW"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q8wLGt332076;
	Wed, 26 Aug 2026 11:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fPBbJp0+rphaPDrqYwfMoNUx6YWyqzhVagO7Bvhq7Wk=; b=
	TL6aUH8XGPyZt0E4sut7r67lLOt4IYkVAzx++0v7K3zA0lG/wnhMqivxnPFyuMKe
	Q992WMNqAIZALr3cA6ir0j/vqF2Gul7BxcoSc18ZCBjPns45PpOjxUWptqVMo15N
	jWxt7huszHLDXk0JuFyAL4U4dZf+tWCC3XkeD7zOCtyvc02lsarOP/tqrvI1Yy1L
	kl1cLjJu9JnBmKIvXR7m2dxsBwLCWuZrEyt21xnVQ+0kmqOxPBE4K7J/hXGDoHmo
	aYRXFctHeiD+1STJy8u/A6bHDrk3U+zCm2E/bI9Z3iZRNOt/gWHcwmglofYm8wKR
	dgCxrmFVvRxSWLh2STbwvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72p9wu7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 11:43:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67QBUl0E004974;
	Wed, 26 Aug 2026 11:43:20 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g846ekbwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Aug 2026 11:43:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xB9B7jEU3nniKONrY1B8zPBFQE8dkTA/XBe9W5TMqxbOZxha1ubi9MrpTXSCIiyCL7dval2L8XkRJksiqo03ZSWqwEZWZhsEO6UTw6+cyC9CO5biWsKLP0hXW2jzySiEtFb1ujZ/lL9EX8gCVfI5ezdmBx7QssXV0CpVIncm22csXConcrddpNrbx0hpDqgxxBYPAa9gDMdZOVUeATp2WHWhanNSrqHgvYUp0/fFYWz4nxdQUdqmLdr2GddRXGGaQlwoChDtZRzy2D13XNiiIyw7URMadenhuh+ZsfOaAoT5ZmNtvzIinee6+1f4MtY67/1pM537HF4bjfa/OAZ+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPBbJp0+rphaPDrqYwfMoNUx6YWyqzhVagO7Bvhq7Wk=;
 b=UnnohGq2koqRDWJfJyrh9gmtSI7ziDKR0Mk890BZd5aqda3NkLgegq9eL5XPjfghQYycraYzwT0N/18bhunwVwEMmDlCadF7VlKybFvao6Dh8AdG55pOcGq94B/sY7lMmZ9OO7J+9MdBd0HHRtjuKu5qFpQFbuQ0lIIjk5UbkbOvvqs9TPXlag/xIZcxAf2dy0RTqh4i5r/xCS9eNXWSmB0RFUQ9Z3a/UV0DF81mHv7U7IYj/r7sJdH+zSAL5d3oMwcxs0K/41XsfbdIow6A3wY/ExBWhImpuPo/+sNtEtHftNg+e3hjhY884tAz5BOZdoDLdRmEE6xzkp0eCqW7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPBbJp0+rphaPDrqYwfMoNUx6YWyqzhVagO7Bvhq7Wk=;
 b=0IWCjsqWNy1uFTt1TbicoXIF80SVbc3Hunz3tAYeuFUVEIU5OZW52hBn4pSdTgyz1Qr3qThrDqWIQX5ktyHy1iJpaQUu64UIi7OJETm6AcLaONEJwUbFoUkGMS05vcNHcpsY/RNSKs2w+XxSgY2qBDuK63+c0JifrOQWGf9dwbg=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DS0PR10MB7902.namprd10.prod.outlook.com (2603:10b6:8:1aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Wed, 26 Aug
 2026 11:43:14 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 11:43:14 +0000
Message-ID: <d85a69a5-b08a-4ec8-b09c-4e45b7c1f712@oracle.com>
Date: Wed, 26 Aug 2026 12:43:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] pahole: Support cross-CU type references and dwz
 alternate debug files
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20260821213510.22423-1-acme@kernel.org> <ao442rldWrCNG3zC@x2>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ao442rldWrCNG3zC@x2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0287.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::22) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DS0PR10MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: a018b681-a66a-4ec7-f979-08df036736ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	mNk2Y5aHGd9M201a6Wauaso865Z1uvMg4hYGrApkuRkSfCdsCI78H2eCl6X5vwyfqxd6AIBS+87NfRnNlJXhVHAuecVLTF7iokWl1/hIG3EKFoMivK6IAsxq2D2XXnb+hU5rItf6da4c4qxfsVjCe5S3SBf1qqdsanj790MP/XN5hCbmw/lQpFFMTecGbB1fpbLZkPXR45PvttMo0fL2cSaeVbXjrgwjDEFgH1a+Gmk0eeME2hvQ/YxuWO8Q37RvHYpBjOQoWYf7Z9IP+DZ0LSBFnyi9Th7hsOy0rmsR5V9Bsl0n8gj+FLL7ETw90CU8feAQzcJvS7+aqLJMFK3PI2RiXvelxeurdESDIybK7jOhaQ1YbsAFYbBz+pOOAzd+63Ge16kFXLasfEidbPwEtjCClVNESyGQ62LlpOjWyokW6REqJtQ6cMphFDqLHwBubAhMI6KFzSPm6csquTNipw4UPt0jgImmvDrss7hNfN1koR656Th5jzUYoVLP32DbRzGZBHGJ0EKvNjYygd1jyaSg9pv6qkrBOuHZi4X0skw/LZCEtMTduZ9sbe6j4uvsEzADFQRJK/ekUNVsadM7pO5TCpE6AH9HARdYpty988O5fkQQhsnBPCvK96bQojdG85RLZcrLs2c7UyyI0s/xsT1desOB0k4KQCUtTQ6kzYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWppOU9nUlJMWVZraXhBSENadURzYjFmNTBRaC9TQ0R5UHY3UGdEdU56Vk90?=
 =?utf-8?B?eHNCWmhVVmxQM1ZEZCtvUUhEY0R0VXRNNDJDOTBJakhpN1pyYTFsaXYrQk1X?=
 =?utf-8?B?Mk5CR2NzTlQvclNabW1tT2JOMTNxVGl4Y0RwVk93WTVuZnR5Z1JhNHptVjZ6?=
 =?utf-8?B?RkEwNUxNZVd6eFIzVFVsK3hZQnIwWEJWTHR6OWIrbFpNK2FqS3pwVXk5Rlg4?=
 =?utf-8?B?dEdxaExMU2h0cFFGZ1VrTHUvbk5nWU8yWGxpNC9kZUZRd1F4bXR2bHFqakY5?=
 =?utf-8?B?OVVmZ1VySEZTR1N0RVBiZTRyelMwSWZ1c0dTVGNLcGJuR3F6T0ZGenJ6T0xN?=
 =?utf-8?B?WktHSGRycGVwVGlJQ2RHL0hheXZZcEp2UzZTNnJ6ZlV5dHJiY2wxd1ltMHBx?=
 =?utf-8?B?QWtpYXJoVGd0V0xmUDh2NDRWWjdCNEdyelo3aUlxVFdDQ0xzbDNxU1hYTEo1?=
 =?utf-8?B?dDRueWgvOC9lc1gzelp1OUF5UWJjbnlkVjF4d3JQOFYxWjhQbTBmaDA2Q3ZH?=
 =?utf-8?B?ZWdIUk5paE04ZUJuSVNUZ1poTm5OSnp6RitjQXp0OVNHTW1WZjFVK0Q2Ymkx?=
 =?utf-8?B?eWRmMXpOR1NURjE4dGZ5WEhJQUNVYk80ZzdJQlB2YzdzdTdIVXpJampJZ09V?=
 =?utf-8?B?QmgzUUFRTmpqYlVNbytiUThDYlkrd3NsdFR2QUswcXhOZk5ud2hhTlI3TmZQ?=
 =?utf-8?B?Q2FLL2xLNG54UzNYeERoWHBFU2FnZUs2RjdWcmJjUlVzRUJjVzV1bHNOdW1I?=
 =?utf-8?B?RXNmM2NVMHhUNmRKeXdUTXduZkNod0JpTGpuR0NkSTlhb1pLVzA4U1pROXcz?=
 =?utf-8?B?NVdiRno4aXp2eTVORmh4djJ0N1NGNmlIUXdMckFhTkxMVU43MjNMdE5PRFpz?=
 =?utf-8?B?M2wrMnBza2RjSUh0RmFWbGRseGNLcHhKVytGcnZrTlZ0YUxYa3o1L1dNNmt5?=
 =?utf-8?B?cmtMY3c2UEVvTjVoZXJudkxrcU15ZXVJNTJ5eFBsVnAzMjJoRDdFemcvSFhz?=
 =?utf-8?B?LzdxRXBzZ2FXVWtHS3FTTWUxKzlwdmdqSERHYkVMYk5xK1FBbjQ0eklDNm5z?=
 =?utf-8?B?eURuZitFZzJYc3pDSjJxbnRTc295ajFkVHR0Vk9xU3RkNFo0QjRZbVJDU2FM?=
 =?utf-8?B?RkxHdFRPWWcvRHoxakFTM05nTWphYlJnYkJoNVdmQmI3dmYzWlU3cWdOV1N2?=
 =?utf-8?B?NDJWaHVuWnZKTXgrbkdsM211d1BqTVJucCtsNlNHMStmUzVGQUlGMHZqU3FC?=
 =?utf-8?B?UTBMdkh1a1pMcGNGWGxpM2NJdFBNeUZhYzEydTlGRCtIQ0JoUC9Lc3NEOTRW?=
 =?utf-8?B?QzZXS00yS2ROSG12QlFlM3hGUmNQY1BCZzdpSGFFUDVPclczL3piL3VBeFMv?=
 =?utf-8?B?NWoxZUhFMDRpV2dRWkM1TURpNURJc3lBQ2pteGpDS080bkdpcitlMDJyalJK?=
 =?utf-8?B?cXAvN0VpdDFlSlVlNThNZE9xYlBObzUwbWxCQXZXZG1HK2VSOHJ0ZmJQb1VD?=
 =?utf-8?B?SlAyN3BRNlE0NDVodDBBMk9mWXc0bEdRbjJHTi9ZUzZlYVZ2TTRVblFFRGdM?=
 =?utf-8?B?ZmRObjBiaHVyTTRCZVpPMmVNRjduRS85bTlIeTJ6b3NSbk0xZjIxd2gvWEl5?=
 =?utf-8?B?dGFvaUd0N3RiVXltOGh4V3VMVmZqb0crRk42NktGYlcxVUF5dWVZZlNtUldW?=
 =?utf-8?B?VkJpNjl3OC9FQUZMeTJVZzlhV1pCdnV4anJOK2FiQzZMSVluRkJ0bXVqL1dl?=
 =?utf-8?B?TnpvaXFXRXRCWDdBdTNMc0QweUMyK2ZJVzNrVkIxbUZoN29NTVhFeWE1QStK?=
 =?utf-8?B?Nmh1TTRFb0czdHYvR3JMR0VXODJjcGV3elpBbTdXTlB6bG9oK21SMHljY2Mv?=
 =?utf-8?B?TGE3dGNCR1p2MGtiSDk3akdaYy95bFFpYWl2TWg2K0ZFL1VwYzRVUEhhMU1a?=
 =?utf-8?B?a0JoNG1IaFdxZnROU3A1d0JFR1Bha1VqUUdweWVaK3c2LzBNdEhibXJRR0FI?=
 =?utf-8?B?MkFNYU04TDhjZ0MzKzduanlxL2pLd3YyM0VEajl2S1B6U2xySGozMk5QcnJU?=
 =?utf-8?B?cDRvSG93TU1LeTZRbWxiTUFZMDlwaU1QbDFWelQ5U2N4YU9RVW9QaWRLeGdw?=
 =?utf-8?B?MFh4U2pGZ1N5M2ZXYXlUNm5lT2ZHUUVabnFnQW04Uk8wVmlqZVZDblVGd1Ru?=
 =?utf-8?B?ZDNjNWpWQklPd21qRHNaazNrZGdZQzZNYmF1Mi9WVlBPNEd3RVl0L0dqek5j?=
 =?utf-8?B?V3RYWm1PSWNIVHd5dXV3aVVoQUpXN0NaaUlyZm82QVo1aWxxQjVaU1N5NHQ4?=
 =?utf-8?B?ZndpaHJORXg4RmJsdVA5aWxOSmVDYzFkSy9BQXNDWno1bExHUzdDUT09?=
X-Exchange-RoutingPolicyChecked:
	MfW2Ut3jqPl0GXbdNH+aATL063Rx8CeOr3qfEL0sIZi1syhN8+u6eZeZCxZI3z6hIZotig38RwV+TDMHByF/9TNcjktuPqYYL1DsfKl+SUbC5609gjDs/0IZmnUvgTgL921TGxGeyGDZkrhmg4uaESTR1FVjcA6KLqa7hNuu7q/6KXVZC1iAxJqwc3w1Yf9Fdu2wbW4cBBeDs2SRJiiCMUQnfCMmDSfig+DBjX3mUt9Mq5jW4I/ZdrWX12jzEx8RxnEmv9x/siaOwHF9oehSFTkrOJ9cdP7zAUzmSS9ZY30r2JYvSM3nTxyg5vv0g2zwE47R1W+A4IW4JlqLTzq7Ew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Si3ntSE/gcqKPCABdPvPH9P2pPBhjqdAUpSTwpRKadgzJGP0AiijmnZexbkC6nKT2byZhO03fS771+53W5V8Ml7l8puzh9JRAL+B2eHbMkm376/wNvfIvM8hff1hy1fb6XIH5Fr2SgulpN9LjSngHdA1OezUUsiHwUw+yEN600/4T3dTtRGGrTZJ8r9SPlOQB+rTpONiOuAYY3Yfn6v2F9vFVEpLkgvTrDfdjPy+2jjGUEsxDhRGGADeDZkB0hQpOo0vvt3o+NmbaGV1HWmn9csz2dxMlPG04glIEnSlbzCE7ZazrT+qh+V+T9kYyNQ2Ahh0oem+jamKrhgd1Ry+0Z0QSBJhdx+PaPxBz+EN+g0QduPdUKvRrfIcvlcfAMGKDh0sIiNj/sIRA+PYwj0X6dHAoRfjkDDI3fP6bAiHSjw8UkCi1hRghoNTICJ4rwD4sL0sDQ4AszUco8cvxU2hoeVwkpS/71baqJoO636xrSMB04FrqSW+9YW30cyw7l6Loq3HbW9gkgkmU7U6UwxoU9vxkTTbDBKlCx+6ZmJx1cdDyOwh6NcoiYI/egEh3MpPWu11AF1FiSTtFvN/Z441OUb3lvGcf984+lSMbkx12nE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a018b681-a66a-4ec7-f979-08df036736ba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:43:14.7083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTqrNUtkBHkXRzV7ELlR/n0YeJKjGfwgxWkrDX972cQF/JQgQJtMZBWMS5bATXuL9DHdV22ShtGntm0AHiWtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608260096
X-Proofpoint-ORIG-GUID: A9c5MB4-5uIjmgFPukgnnEKjwYDShI1c
X-Authority-Analysis: v=2.4 cv=EqfiaycA c=1 sm=1 tr=0 ts=6a8ed158 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=20KFwNOVAAAA:8
 a=JNxzeD69O9GTizkgLJ8A:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: A9c5MB4-5uIjmgFPukgnnEKjwYDShI1c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5OCBTYWx0ZWRfX2KJP2JcaNcYT
 Fhg22BRYu62HZReyWFJDFUOO5fPe2wikQDL/E8AunyHhhDKUhrzYi682Mf4A4f17w89CW9qgMdR
 P3T9DHMooYaXcW5P73nrGwkFZaVSGdEhhen8c1bhK3sOefXeD2nyz7osK1D+z32OWLYF29rMSB0
 zEdl/JvJxGIh9TgmbZ46pbdFvwcXS5Kb176ks8I1Mby70UqMlXo1uJg/JAK68BBVYgrXhQoLyuc
 if1l13QNCuLm45xouMR1KKe/mHZQdOb3BB78vfD5DLeZO7Kda4JQcYrsCEhx5QymIo9H3Mz/8WS
 Rl6KvWY+xi4nuTYt4K94PJ0hRN5wVpnJYube4hhtbQdW/YD4WQ1AqUFvwF9lLpkPun7p6XfhoTT
 JvvaDhsq8KENDoH8iinKMw0JZGrnrc6CSd+NEqNnJVCMYRoy89kfJK8pxDX7rJcs3EVd/lYbwo1
 wG/kAM2v75JwY7CW2eQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5OCBTYWx0ZWRfX2FjgBu4ify8O
 xqWUNLD9iiaqG1D/M5rzHhzyuVf1p+hIw3ggvFsNaMs4piLLZm22umFxwf7zDZ0N4PVDj0actUF
 qf096qx9P2cwmDruKNZ0GvzOBsQuyEuxCp3yuDQm1eXQZVDjrSfQ

On 26/08/2026 01:52, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 21, 2026 at 06:34:59PM -0300, Arnaldo Carvalho de Melo wrote:
>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> Add support for cross-CU type references and dwz alternate debug
>> files so pahole can process binaries (e.g. a perf binary with rust
>> objects, or Firefox) that use DW_FORM_ref_addr inter-CU references or
>> dwz-compressed .dwz alternate debug files.
>>
>> Cross-CU type references:
>>
>>   Force-merge CUs that contain inter-CU references (DW_FORM_ref_addr)
>>   so type lookups resolve correctly.  Handle same-file partial units
>>   where types are shared across CUs via DW_TAG_imported_unit.  Fix
>>   cus__merging_cu failing to detect DW_FORM_ref_addr when
>>   DW_FORM_implicit_const causes dwarf_getabbrevattr() to fail.
> 
> I did a lot of test runs, and with the patches that are waiting for this
> series to be landed that stress even more this series, so I'll merge
> this tomorrow unless anybody have anything against it.
> 
> And then as a followup I'll land a series of test patches that don't
> affect the functioning of these tools, just do coverage analysis and add
> lots more tests for its features.
> 
> We need to release a new version as there are people asking for features
> developed and not yet released, so I'll make sure we get the goodies in
> and the release out ASAP,
> 
> Best regards,
> 
> - Arnaldo

Changes look good CI-wise, one issue that we see (not just for this series)
is that perf on some systems is a shell script that selects the kernel-version-specific
binary, so the result is tests relying on perf being a binary get skipped.
Not a big deal now but maybe we could come up with variants in the future that
generate inter-cu references reliably locally.

I tried a few other approaches where we handle inter-cu references, but all seemed
like they were a bit too complex or involved multiple traversals of the CU set and
were too expensive time-wise.

I can land these if you'd prefer, whatever works. Thanks!

Alan
