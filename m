Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE392D5A11
	for <dwarves@vger.kernel.org>; Mon, 21 Jul 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097764; cv=fail; b=AaUAYv88xkXzYAl5saBQDGIyIJ0R3feoRVogDUKZTShHRqIg6rldz6CNV1fDBhVY1mPYj+C2+8+4RfONzgvyQPRLhTzI3tZ16oHz9OsA90MZCpOPC01Jn0z9GeCOXGDpbqow+epX6ysxMXsCL5p0y6ROlisFQlhJaxymEcpoBOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097764; c=relaxed/simple;
	bh=KNLJzxtCtvtwfEvinrdp98RaVg2BO+4cXiwXfLSI5aE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ctGqIpq/+1l8sPf5R4JlnaqDM7VdR387UXfZHKW/VRyLisNo41pXJi7WQmN0KuTeQ6uwqHLEztGxOouEtccBVYWrqP8OQ9nJfmJEYSRloaJamUVESPstov14Cp8nlnbVR255LPOqBEABT/4qBIkvMOhs+So6VAbu2Wr5/ABkGlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PQk9nAst; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dN82H5uM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PQk9nAst";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dN82H5uM"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBBrHW014493;
	Mon, 21 Jul 2025 11:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wUeC9B/9juLTcjVZFEy4+IqSzHLcHRqW++eMsgZajLI=; b=
	PQk9nAstQmJaIm25M1bJhkwXQ+Zg/uVGs0g34mN5hVBkVTrdK9METH/CWE9LDaYD
	KAf91f4Ci7pR0rlk7n3do5gTjhCd5TbblOaSbSYi+WlX1ilmznHxe6f2AUP1DgsP
	Hiy71ryyrHGqt2EbFmfXy9BLeRPIiWP8EgRKXhlKAG7jF8An04KiBHENlrRHahFb
	kQDnKz/XnqyE5ycm2vpHcBE+5Vh2xHGzJtY639rH6pFG3Lmd/S0rfFCNeqmSEKhj
	V0brcKJukVxCuBnEqzZm7iFze5TzhJXKN2GcCGV4yUOYZMdHz9VJUMHG78EPtFp8
	G9i+66EZR1UtqC5H4QGzCw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9jdvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 11:35:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56L9rE3V010365;
	Mon, 21 Jul 2025 11:35:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t7xprs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 11:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3gocb4+CZVe5a1JGPOhb5FNKRHcaRrWDl+Td8ytg5xdaoPC79h3VoRui9qDpvldqHgYwW13AGWmrRAaqR0HsEUNfl6aeLDXISVPwUgaofmzECeujwU+EOq5W/NIsKEZJoz8VRQMMEs6x7Iwki8Dy0lQbwK+kEgrabJsfwOrKVRSGZVahyqSju631nO0Q6aZClAqzqPl3Y3NmuW/317Qb82d8Vrg9Y0MZtp75GTGSKKphPojz/lYc1J9Dw6fwzdUcPCqmZR8R7ExMDJZDDXthqe8ylBgpY05HfOhhTgBzPPt9sc5jP+rzHjr0Yr5V6LxDsd5zzGH7m0POsZ2WqduMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUeC9B/9juLTcjVZFEy4+IqSzHLcHRqW++eMsgZajLI=;
 b=fzitHRH2W9rSlB47fiZVD8w4g0bKdeaRVTMLO8yHcX2WK8WKcnMmNtc8zme+FZuMfLV9JTKzyLK8HqyoPLcphFKBHHNeTPOPtBGpYsLK5m/wuYYL8P9ZjUfrJwb4ZlKc40je8X4jFSMyqbMcyt3wBmw+xW4Ij0OjfVFtcVVYKgke3Kdi7DYMQhMRwt2zoNL8HUVqD9OXiIjZKWgPNGrF+fV/69bXClK8Mr8R2qsFJ5TWP5C+3FdJrVQKhgxFFPXcg5v0zGD9mq31Ellrh1OYO20bXA1FG33hhyRpjBRZ/DmXSiR6teWQplJhlGsaoFtDKTTQhxjrGkYrO7DU6dTNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUeC9B/9juLTcjVZFEy4+IqSzHLcHRqW++eMsgZajLI=;
 b=dN82H5uMfIG37EAK4QSxZuoTeuegDL8w5ba0gN1Av2cmubq0zqlyQ82Nunqq6Eh1B3rHpUoWNV5bedeAlpOPwmOdd0KZinGTPG68smXK8XpadjfJJV9Y7XcXlvUh3syxQlaVHz0fsczOdeZgHxU2FOkfeCNZX8cuGcG5JmxuqMY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB4424.namprd10.prod.outlook.com (2603:10b6:510:41::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Mon, 21 Jul 2025 11:35:44 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8922.037; Mon, 21 Jul 2025
 11:35:43 +0000
Message-ID: <28282ea8-6097-4c47-9bcf-d324b55b8e8a@oracle.com>
Date: Mon, 21 Jul 2025 12:35:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 0/2] Add function list comparison to github CI
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org
References: <20250710161632.191304-1-alan.maguire@oracle.com>
 <10fb86ef-8e1e-47a0-a553-e900af1d8c9c@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <10fb86ef-8e1e-47a0-a553-e900af1d8c9c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::36) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: ae767239-a678-4923-e97e-08ddc84aba4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDNxekw4UE1iQmdUUHFlVkxETmtPVHViTkhORldIb2JHRjRGWlE3b3ZJY1Zo?=
 =?utf-8?B?cG9DRnp1NlA3VlVuZHFFdEVBend0WWZsQ3puSXZUSTV4a0lZUVhDSGdmc2hO?=
 =?utf-8?B?dVJjRXRMQUxSVThsbUNaTS9jUjRPVXZPc0lBVWpYRUowQnpEZm1MdVYvN2dO?=
 =?utf-8?B?ZzZmd3k5T1VXa2swbFJ3MVp0dUJxOXdBNEVwYmlrQ0V6MUpzT3JzUyt5L0V2?=
 =?utf-8?B?MXUvSTd0ZzlJVjJyK2VRQUJZYzRzQk12WlYwYWc0dzd4OFF6TGZWbk5pUlJF?=
 =?utf-8?B?emdjVVNMdGxoZ2xjUVdONzBpeWl5TE9TNzdMT3VRTTB4VFZXSi9Ya0dSTVJq?=
 =?utf-8?B?NlBsSHR6OTVDZm5kUFM1Ri82WmVKU1VnSUVZeTkyZFZSc2dYZ2RnNXhiY0FY?=
 =?utf-8?B?QXoydDNPR2dRdGV0ZHlCdVFQd3k5ZlhodEd1UWRjN0lKSXpOK3RDYk0zTHU2?=
 =?utf-8?B?NDdDaktwc1hCb3ZUaDJxRDc0M2UvOVY2WGxlWHVETU9zOVA5UlErc2lSa0J0?=
 =?utf-8?B?UUw2eHNwTEd4YnpEN0owbzdPVkx5MzVTcU0vQXh0QzhKbTFlekszbnJIa3J3?=
 =?utf-8?B?bWhVVVhOUW9VT0FTT3dtaFpSK1NVYjh2RzZFNExmUE5oTmZwQmdMZUg1anNF?=
 =?utf-8?B?VmJXZWZDVzZKSENjRFJNblE3VDRMdFVLWXdRN2pqZ05PMjluVmxOWWVieXdj?=
 =?utf-8?B?ZU82MUgxZnc3RG5nNS9nc0FmKzZBK0k4aW9BL0pmaVdXNERxQUhRNW5ZWklw?=
 =?utf-8?B?ejNRejFGNmRDbXFScUtwMTJoZUI2U2dwQzlMTTZLaVJBWTVWYlZkUlV4QzJi?=
 =?utf-8?B?NmppYWNacUFDL0x6Q2s4cVQwcjM3UWpERVN1MDd6Ym5nK1lCVWx4ZUo3Ni9z?=
 =?utf-8?B?TCtVK2tXaHE2VGxBaUxJZklDQU9VYmxjMlVrdjdMdlJYREdpR0NrbUwwdlpt?=
 =?utf-8?B?QzRDNi9CTFlYdVVLY3U3Nk9GYllDWmFmRXBvQlc4eFdudlNxMnBIZENKOExD?=
 =?utf-8?B?TkVoS2MzSFZOMjVvSUU5RDdtYzRxS1FCSGM0RkorTjAwSnMramkyYjhHVnB0?=
 =?utf-8?B?RTRXNFd2dmt5Qm9uRHFYZDBVSDFRbTlubEFRdHZOZ1R4QThFbmhmVlg1TGlG?=
 =?utf-8?B?REdBZFhNSjIxZ0RVTmhadW5PZUlkVHAwNVhYaFBINStVQXh1UVNCam0yMDUr?=
 =?utf-8?B?QjVKS3UwTGcvbkYyeitDNGJ3cmduUTQ3QUJOeThnbjBZeDlRbkxqNlBibnRl?=
 =?utf-8?B?d0x6UVRDM3RjOHF1KytWL1V1cUxiUSsraHFCN09vRXFpR2R3VVJDSkMxSzd1?=
 =?utf-8?B?VjIxaGd6c3JuOFBTdFFhUUF1TGJwU3NuK2NwYzlBVS90KzNZL1VOcm4vQzV1?=
 =?utf-8?B?b254WVVPUlBqZmtEaDNvR2EyR3IzUDV2WEpCOXY5Vm1SSFIrUmFRVHNwM2p5?=
 =?utf-8?B?ZUJ5WVVobW1JaHoxZ3REWjljbFl3QVFlR1JVSkVtYThVMGhucUNjM3NSNlV5?=
 =?utf-8?B?eVdjMmNrQm1CVGRtMUVhK2l2MkJMeVB0aGhDQ3Z3enZGUU5teWQ5QWFpWG1Q?=
 =?utf-8?B?YkFLSFFJUlZudzI4b05XWkttWEl3UWRsRVdSSFRpcGpLN282SlFJVkRXTFVh?=
 =?utf-8?B?MjZsWWdSRUU2SklHRU13RUFTamJGUFdVbklKaWdiOHNaRDdKSVUzZFh5Wm9R?=
 =?utf-8?B?OTR6MDRHZlpUazdjMmFBeDlBVk1BZ2RVR0NKek1iTVpLUXhnRGtLcGZDYUxG?=
 =?utf-8?B?REEwVUg5ejFVZTlRUHdoUEJEWlN4Rjl4ZTBKaXhZajJ5a0dqSFVvdzM5dS9I?=
 =?utf-8?B?TG1MNitsakN2WkYwYzYxWG9QaDA5OXRreWtzQWpyaXlBY3RtUjB5Q2tPd2Q1?=
 =?utf-8?B?U2xCR2RidzJQSDJBNmJOR01uRXFiZ1FjeHFGZUphT3h1YnBUeklHTnJhOFdI?=
 =?utf-8?Q?34DiWKSP+no=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFg3M1gvTTNzWGx4Z0hMQUJhN0RRcVRBZDJab3FsKzMySFhyMHdHV1BjeXZu?=
 =?utf-8?B?djN1RjhWNU5IZG9kSlBvQ3BnR1g4YzhNTTgvdkpHZkU4eHpvKzlSUkU3U0J6?=
 =?utf-8?B?MXpSWldrN2MvbHluMkRRSFVpRVBlSGplK212OVNWMnJWV3lScG5IeVlweHRm?=
 =?utf-8?B?YUF5K2dpcFdPSHJVUnhPa25xTVVycVNRelBhdVVoRFloWEdINkgwOHhnM205?=
 =?utf-8?B?aEJHVy96Rmt0ZElkcDJoc2MrL1pzNnhEY21uNlJJM25xSDVmaHVUWG9McXhH?=
 =?utf-8?B?ZERTU21Dd0J6NHU2TEl4dTBaaHBFREtZNjMxamVoa09PMzM4V0dPZGd4T3Ev?=
 =?utf-8?B?aHhtaC9UTzd1SnQ1SUIwL3Zxd3U1bm0xRGNBeWY2UmY0SE5rZjlHeUVIdGlv?=
 =?utf-8?B?RXp6cGRBQjBsZEk0Z3VYYzE4T3NIL1RIcm44SGtROGhLdTNNeE4ySmppUWhj?=
 =?utf-8?B?S0JNbDIzZUROV050WjlNeVFBZXpNZDUyOEJEU3VYZS93d2Rpai9Za2RTRXBi?=
 =?utf-8?B?aElTSnJ4UFdHclNJZkxuWE5BWUVMT0FtR2U0YnhnQUN2L2Zsc25VQWRaWENB?=
 =?utf-8?B?ckJrbUMvZUdLQ0ZCT1pVUG5MTkVGQTMyOGV1ZG1aTU9taU52MUZNZDF6YldS?=
 =?utf-8?B?cnRrM2JCdzBJSTdCNWJIaFdUMm5PZVp5MWFtTFR0azVHTEF1UEZkamg4NmND?=
 =?utf-8?B?V1ptODZrYlhmUkpZa0tOVkc3UDlaZUI0YUJlaW5peVQ2UFRhb3Zac1A5NDU2?=
 =?utf-8?B?dGMza0g2MHMwWU9KQk5NMHZqd2tnK1Z3VHBrRmlDWnEwV01FdS9tSlZoSmg5?=
 =?utf-8?B?enh0ZFdHdjUrV0RuUUhjamZnRWgvUnlleE92d3RSWXdkTGE5Rzk3WER0eG1n?=
 =?utf-8?B?QWp3a0UzUkRmUGwxZEQ1Z2xNZ3Jtb3ZTQmYrcVB4VmlkZjdld1p0Q3cwNGcz?=
 =?utf-8?B?UlphZ1prdGxQZTFXU25VQ3pGa3dnRWRBVGFIMW9TZExOOWxDSFNNMmhDWXNh?=
 =?utf-8?B?T3gxSzNmdlRiS0RlOHBNUEJFd05SS0ZWVGZYLzlGQ2k5aXc2dGZDSXhsNjJt?=
 =?utf-8?B?ZG0xd3RJK3Awd3RTREhNWndrTEpHZHk4T3ZlR0lSekFGTE5xMlpQV3VoOTds?=
 =?utf-8?B?LzRUangwY3JpLzN5ZDk2UVIrY3N2S3loTU9LcnB6UzMyMW13TWlxaTB2QW54?=
 =?utf-8?B?ZmpNREZ5NS9IZVUvbTJxOWMrYzIrNFBnOXJqM21xR0VvOTVJMnBXbzFEME9E?=
 =?utf-8?B?MU9TNXBpTTRvc3NVRzlSdTRJaVBmOElYRnlwWHFYa29KUUpFZlFmL2plNEJp?=
 =?utf-8?B?ajk1aUNEcTlBaG53ejdoTkhhVHgvaCt1Y2w2ZnVvZ2JGZ0E0cmZxMm5KTFlL?=
 =?utf-8?B?UFRrMk1vQ0VpdzVWOVBtWjkrUUJETmNNUFE1RFZtKzl4bHlUbVRXeFkxWWdl?=
 =?utf-8?B?QmlWOXpGZGxwWm5YSnVOSHU5N1NmcDJvRlFBckZzRUN6QjdNUWhqNkN2NEdx?=
 =?utf-8?B?dGJDNVhzOFl4SGpUWkRDU3IzM1BERnFIdWNKVVJWbElMbkx4d3BDdmNrT0h5?=
 =?utf-8?B?WDBJZFRRVU03Z09TMEt3dGQxSGVnZC9CTmUvN2lRL09RTVdvWjV4dkFRRmM5?=
 =?utf-8?B?NGs1MU5zWHNOVHpuQnA0dk1aNUVNRVBMa2ozZ2k3QmdTdW9tcGtienlGbVBk?=
 =?utf-8?B?QVpvSTR3K1BVTlVUMnNxK3NvRXAxY1d4REZURDVXSDNLWkEyYXlsbkowZ2xh?=
 =?utf-8?B?azFiVXlMeVExakJobzh4RWlIWGtGbWtnQ1UyOWE1ZDBLWTBuWUhkd21mNjRP?=
 =?utf-8?B?clVIK2c4TnV3Slg5WlVkMjJDRHlUMkdVdXJ3ZmVick1VUjlIdklwRGNPWkto?=
 =?utf-8?B?amgyZjd0VktFZWF5Q3NiM1NVRFFGNWVUVFJ4Zzh5Y3FwZTJsNmdtTU9UM2Vz?=
 =?utf-8?B?SXkzSnMzVUlkL1lxRFEwQnlHNjJxRUliY3J2amNIZWR4cWROTnNGby84aHhY?=
 =?utf-8?B?VW1KRlNtZXZINy80TlVtSExOM0Z2Y3JMSFQ4S3pZRG83QzVHZVpxZ3d2b05J?=
 =?utf-8?B?UHE2bnlvTVd3V2hhSHV0TWxiTWdGd3habjk5Y3E0SVNqUnUvZVV3eXZIaDVC?=
 =?utf-8?Q?4xxKQIxOG9+XFNx5FQ7ziWSfA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9mkCTmDTDre1dmRkMbuInIwnvdLrugEWZe2CCjRT+IYg/aMxLBjdYolXiZj+mpy8VvqWTpE+jYrUchXw4FHhaAXCYON3NSMzBifPgcRvV0QeI4J3IwFScfC7u7pube3d2MNpE0a2pf4ezoy3A/qsrLcz40jS/k6vPiy2Daxlg+SVW30l2s9+Syp6tIjdyQtZ/PM9Auz8dBxWgh1fr4b0GMUD4Ai5QDmc013RWnZDyn10xRH0ppzWfEBA+hpOxxjzq2G0WiYOkZBePmxOBsAOwRECbNbjYXmg/68vqLBb3PVx5ODonAmYRe729ZDrHEWRNt6jIJSFoBfL0oa41WmXMcVirIrQ3yqHidR35vYjqqemW1Xbb4Eww8bCJRMajtTjvFCOqXabE/y7nvLqsL0FUzslmLN/giwOnuL6b86PfBSW1rp2VCLhu9YTXuPsmx/q9KW06av/n9rcTyoAq0XTKzt6DVjwIwSO+U/5Jgd8LxLOcZr2su2Mxxzm2BgH0VLN+8TRTRsFQzSEFyE8T6NQJIEJd2T4rvLC5iKQnrlHbi+HCDI5R/WAasWy0SGVHDJQia7UdDRzJlsVvzKFUt7AOXgEY+hoSMBaJROJyuedAvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae767239-a678-4923-e97e-08ddc84aba4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:35:43.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAL1+vED9CDVLh8/JWBbRkbJhslemCPQISHzF7yivt4qlPFc4qKRt2HFZHk56UJYfJvlwi7ZHDOh8Acol/g2/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507210103
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=687e2614 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=VEYJbVRdx1HACFgLdIUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RPUljAMg873s7w3WBiDPIbrs41bNr4hb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEwMyBTYWx0ZWRfX9b004HLsMYwF
 nw1W7BJp8OnwkVQagiXhWrVxg3+aP6imlsN5h8jK+NEcKwXsHga42x7e1skagAHKw+u5Pnq9Inq
 df7LyLP7dDWo1gGomqxJ8l1aaymehhJf0g6FSo2prCj5LDdm7iggLsx7+CPo5pM9p+tVtAAPhvF
 qWpgxdDcFXeyF5V/EIDNnue9by4qg8JBmYfeR0k9Zr7YLbUXWm0jL1BSkXDE8sJy0EMfNh8jBwF
 oelt0oHSn8unQ3kjopptfcFl9ucZF/Mah4t/YELz8JRMifY8OdGfvvDXdTIU5aGl1VT/E15iRDw
 ZkcpYJ4duaMpQXCZ+xQaSEMIeBSLnda3DFYMnsFWQJDRcpcpjpJKFK2eezRJk+6Yh4b/Rp7yOh4
 bBmEnG19Lb6XP4hvWhSe9ZTby3y5husxEN2OPju7MJuZel0ZlHvVtBKpvaZVmvLf4bBzCLMi
X-Proofpoint-ORIG-GUID: RPUljAMg873s7w3WBiDPIbrs41bNr4hb

On 15/07/2025 16:41, Ihor Solodrai wrote:
> On 7/10/25 9:16 AM, Alan Maguire wrote:
>> As changes to pahole can generate different sets of functions for
>> vmlinux BTF, automate comparison between next branch and the series
>> CI is testing.  Build baseline (default 'next' branch) as part of
>> build-pahole.sh and build kernel with both test and baseline pahole,
>> using pfunct to generate function lists for comparison.
>> Example job here [1].
>>
>> Patch 1 ensures that the baseline pahole is not built as part of
>> setup; patch 2 adds the baseline build and compare-functions job to
>> the dwarves-ci pipeline.
>>
>> Changes since v2:
>>
>> - altered patch 1 to not build pahole (pahole: 'none') during setup
>>    (Ihor, patch 1)
>> - do baseline build when building pahole via script, add compare
>>    functions to summary (Ihor, patch 2)
> 
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> Thanks!
>

Applied the series to the "next" branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Thank you!

Alan

>>
>> Changes since v1:
>>
>> - fix rebuild to actually rebuild with baseline pahole (patch 2)
>>
>> [1] https://github.com/alan-maguire/dwarves/actions/runs/16192185959
>>
>> Alan Maguire (2):
>>    github CI: Do not build pahole as part of dwarves-ci setup
>>    github CI: Add comparison of generated BTF functions between baseline,
>>      change
>>
>>   .github/scripts/build-pahole.sh      | 23 +++++++++++++++++++++
>>   .github/scripts/compare-functions.sh | 30 ++++++++++++++++++++++++++++
>>   .github/workflows/test.yml           |  4 ++--
>>   .github/workflows/vmtest.yml         |  4 ++++
>>   4 files changed, 59 insertions(+), 2 deletions(-)
>>   create mode 100755 .github/scripts/compare-functions.sh
>>
> 

