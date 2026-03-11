Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC64730CD85
	for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235072; cv=fail; b=Nic88gtKByypi4lDIgpKKIHww7SHxP1gJJuuWdXlUqW22BCjVGuqYYf6acEM5eDAmX1aSOU1dFbVeJwlg1DeLhTkySm2PTdOMh0iwQtqWi7haiD6A/vjKOsPvG5dxBE7rIa8fwOsIfOICRJv1ZuKplUnUgwnNOY3SLTM4XAY8Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235072; c=relaxed/simple;
	bh=ewuJJuJvRTkfLd4TCFeiqV07OiO1Guz+MTCUl7vGgmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JoDzP3HxDFca/3HQZFqzb8JnHyzziYyqJ+QhGLn3qm/p1xDuiHW521OiGzDgOva/Z33X1FiuUNw9bmN7CfX/wPx0iE5ptdQ9PDM4N6GaaPg28X73g4R8vGDR+G0/plE3AdzMg29ggdGrLy2j5M4G548HzkyMDbMIaW61WgAmJVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AJ3kflLp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yNhAVYhV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AJ3kflLp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yNhAVYhV"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BDGhRK2558992;
	Wed, 11 Mar 2026 13:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=E6AoqgpR+JGuksVe0mYdtns3bOWII7nO9s68uNPIdLE=; b=
	AJ3kflLpyG1/O9/nMdEoxmosFmV1YLHhHCCucpOKAYdCpAN4ZOusIHAauJtETErF
	RnA1bWNDVRMZdvp8XJycZ6EyL3cGexXmMlFNIfpg0pmAOSKIBCxkJj3kEmnss3Tm
	yk/b8e9JGu56XFYXoAdkoog1K3i+C/lC7zj8O+Nv6TI1B6712uccF6ozgT8T7OI5
	gPBbi7ZLdzoFXeUq8Y5odFzC2YKKfiH1118dyNJfihbLqCoxvAxN5TlZFKwc4Ugf
	F/DsGveWUEDT1q4M6MGolcfzmbrrn6yahMivBlJzohDb7gAC0dBiRdp17Q5Tbc+7
	2ag5EYHf1N4l5MX0zM81rw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csks2n26q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:17:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62BCXcgq020383;
	Wed, 11 Mar 2026 13:17:42 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4craffj8jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlZMb6h5fV5xsXi4lcAaweQdyO3ISWF/oa8CSnAbsh8PLUOHYyCNB9qsctr5c2z8dxKyZwbYPbRkV52PQJLvFkmQdX4mIsDJ98h895a4wWRMBXKifbbWxZrbPMYBtujlF4B4gVazmpbaMqwGGrNA9NunJzbPBEIW1yp+koHaqy9xc1NgQtlf4rtuIIAEs+t0idpzuvbGJhBK+L31xwm77B0GMFC4HuSbsPXlv4CexLOnAyMZQVEYvoCemrh4ntiHvEhQaugzaakamuubv0tUe45JANWdX/FY+/L+LBaDKzPM+FkqXcNSOfHUzx/kCbZlBwsGeS5930YnLm8xpV+9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6AoqgpR+JGuksVe0mYdtns3bOWII7nO9s68uNPIdLE=;
 b=g8Nff22seOPOJFCdZs7iZwaHdkA85S+6ZigsaRKOe2McBLYoz8yFxhAXB4SO1uTXH9KH+HmriSVr7NF2gfz1khnyZf7THj/QlTxdDSfmIwVw2hlWS5IcnPF8NnpABtpRoRzNQDqW3fphghCaQZaFaIz9oEk26bcNM95+dt1QxLnURJzb07vyp3tvtLMEXRIugVl+kk4K47Uw4G4zOoTxRAbOt/OUnRvn6BphzAIDJaeGPWDLDmb8zEwBmJMSi7+CRTeZwBY7t+76/KF0X6H1smEJohQB+ruMLwJnjuQULzK0vdnt3HYXxU+mNL2SmHqTLA6luliuyIUqjoHelIpJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6AoqgpR+JGuksVe0mYdtns3bOWII7nO9s68uNPIdLE=;
 b=yNhAVYhVq/JNdjDPts2PioWUIwpjGwLbTfydEi398fevTDsonLXLsdFQyYYlwI3qFHtLEJ1KA1JK7U3wvaVUf+1C20JFbnzRNjKXwpFVE+YlcvQkw0V5PM/FJISsp+MoL1r8H3pekgc2Ce0T8NkFnunzepstDCvBGXPgUTsl7uo=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS0PR10MB7203.namprd10.prod.outlook.com (2603:10b6:8:f5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Wed, 11 Mar 2026 13:17:36 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 13:17:36 +0000
Message-ID: <42c2bf0f-825c-438b-81f1-fed34f628da9@oracle.com>
Date: Wed, 11 Mar 2026 13:17:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] libbpf: fix discarded-qualifiers for strchr/strstr.
To: "d.hourtoulle" <d.hourtoulle@geoide.fr>
Cc: dwarves@vger.kernel.org, acme@redhat.com,
        Damien Hourtoulle <damien.hourtoulle@gmail.com>
References: <20260310132837.129665-2-d.hourtoulle@geoide.fr>
 <20260310132837.129665-4-d.hourtoulle@geoide.fr>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260310132837.129665-4-d.hourtoulle@geoide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0488.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::13) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS0PR10MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: b639ca35-c521-44e5-2bc3-08de7f708fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vNjDTk02lehrhay232+Ng9/RU6JY52J8Wcd2GnODqeQIVIdK4vOoeAZ1rRIsGZg3r5NpjvZBZVP8C95RjkZk7ySg9zkRLs5LoOWN5zgu0JZgm7cBFJqSyZYkDpa01NssMdTDZFiSJEkK8I4tISEvC3UzpctQmclDMCeQlkAtXktWqrhqHtHEQLLEmgKRWx003swwiembZGQbD52+8/SxeXp+cZu2ZOzoIITWcPSi1YPd6QsrNa65mlz4Fn6VQ0enfVEK9z3XZ2X0CdcXHNbjydtRpHNYiewYCSQ9Bs9qPQkKRRPnmEJcBFQWDxb7ogw6sz41YeSaj4PrN1ivTyj+PUhfwarvl72nR3AOc2Pmet5fp5ZIOfz26+lYKsjbbw6AetWDk3oVVB8VtmDpKc2wpjFK6gurR0lrOSImjZ60Y1BkV1N6x1NLFogAypVDRte/Lw/NTeMTR73W0Qey1YdPI7PuyBK7mnw4zlhNWBEotGj9D/jXDNOQk07gF/qARd37Il+e5Cl7CeP0zwtlk/jsD6NLclIpyDxZx/FLS9kDFqJBXT2XQU5Pik9Vz8nWVsFIjJOZRWqgu5pEPHWLitcXgFJp/yejLwX8bwoy//Px8RbS5MaRizvlpZdCpJFI67l2RotV6T4lcscbjF4ryRnGuNBGgfLG/SphKFP7FsGaN8hEJXlr3El5dtX8lmWow7jhHT0kjjm5yswT1cZLUm51R0srCxMvZFUXLTZbktRJKCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Smo4Nk45alBUSHgxT3VleUZ3TGNTRDVpZmV0ZTJmQ2ZwdjBlTkpzZ1c0MGJs?=
 =?utf-8?B?UTUzZnl2V1c0V1R6bzFNRWMxRThvMFA1bmoxUWJNaG9tVVYwU3hQUWxTd1U2?=
 =?utf-8?B?ZkJYSDdsOUd3a1QxdFBUWCt4bEFwVHB6SEozZFpsUFAxcE1jZ0tLNEJyMjl3?=
 =?utf-8?B?Y05RTHpjaE5sdDBCZzloZ21HN0hNa1pHazNDT1JoRWlnSzJBY0FDRWtid2hv?=
 =?utf-8?B?ek04MDBvTWRzU2tVWUNaMFJobUlaSVcxMUxUckRsOWtqbzFoc0o5N2Ywa091?=
 =?utf-8?B?TkUwbUJBTVd5a2JPZkJ0WVY5UDlYbUs3eS9CMEgxNGJOeWxJSjU0USs1dWNu?=
 =?utf-8?B?Z0NoejVmcWZBUTBVNVBQdjk5bFo5MmM4N3JPbDR0L3NMaktLaU9pbmI1S25r?=
 =?utf-8?B?MU5rbmYyb0ljK29hZE0rZmZueWdmU25aV2FXOHI1c2ZjTzhQb1ZYdnJtc3dm?=
 =?utf-8?B?cEh0WHlBc2VtTk5WTkF4REgyNHNYZ1BaN0pYbFRva1RiYm1kUHdKQ0huZDR3?=
 =?utf-8?B?aXpjd2d2MVFISUlmeFpRTDBFZHZ6YkwzUzg0MnVKM0sxenRWSmFhSWFJVVJt?=
 =?utf-8?B?dE4rMXFscFgyMHJtUUpsMDRJZWlHaGZKblZQYlZacXR5SU16eDFHNGZHdnFT?=
 =?utf-8?B?ek9mMjN2djg3VHVaOWJ6VkNRV280SWFESnlMSGJsT1VrRDFnYTJkc3dNUHlF?=
 =?utf-8?B?RDZhZGxLbmlJRXJ0WFpjWmFMQzRUR2xLeE5qNGo0Ykp3cFZ2MWVjUXBlYllR?=
 =?utf-8?B?WDlmUERwcHk0UjNlZEFiM0pZWFdBbWxPb3lxcjQzVjAybXg0bEZCMnRKNWc1?=
 =?utf-8?B?dXgyV3BJNm5tSzhKdEFFL2JMQnlUeGE4bnNRTUR2Wi9OVGR5ckxvV2I4NkVp?=
 =?utf-8?B?Q3I5a3VGOURPM2J0VUJpSUdWWTRzUkNnRmZxQk1kL3R6d2RaNVZhUGpDUWFh?=
 =?utf-8?B?Rzc4bWNVODF0NU5JSGJQWTh5NENIdm5YSDBlTGpPNDY2VEdkbkU4QklZcnYw?=
 =?utf-8?B?YUdmaTQxWVRmOVZ4RDJRTzdhWHRqNlVrVkFDcVJMbHk2Q2hnN1IvNDRxSXZG?=
 =?utf-8?B?UHhDZkhjTWV5dS85Y2t2dnZiZFNMOTVneU5DVmhMay8yQmdDWTlSWWNCZkZw?=
 =?utf-8?B?NUNtNlg4ZW53bjJZbzlOYjBseDJxV09SQjhjREFMNGMvVE0zVUdUU1pGZXJW?=
 =?utf-8?B?UjZqMmtHM2xhajJoclZsejNZaXdVbDYyQVdSS0pDY3A4bklLSnFOVXNacWxN?=
 =?utf-8?B?a2UvekFhZWNzd0hEdnBkM1dic0NvbzEwbnVlUHRYd2MxSUo1MzNmSndaSS9F?=
 =?utf-8?B?V0dGN2JCTWZPVzIxSDlmajdYVzUyWGdZU0NrUUZubWdqbGJoMTdwbG9iWTl4?=
 =?utf-8?B?V3NNN2V1NjlNWGdRcUJRZkpKNEJpK3V5SjNWVnlwNFlET09hSXlkR0VoVmY3?=
 =?utf-8?B?ZDFHd2twaXhUdk00NzZMcDIzV0Q0NmFSOGQxRDQyS0FHQlpzK3dxU0xZRktl?=
 =?utf-8?B?c05jRE1wQy9rRGxrVjA0R0Z5OTFkcEhseHVOOXF6ZGFLa2swQzhDcHR6Uk1O?=
 =?utf-8?B?NVhKRjV4dDV3Nk9Ma0RlTWY4eDRjRzdWSC9LUzdYc3BqSW01U0tQK0FvM25l?=
 =?utf-8?B?UXI3T3RrMnpWcW40Sm5NMmZxZHpXKzg2bXY2QzZFUFg2czZHWUh0dDlqWS9G?=
 =?utf-8?B?NStPOWxOZ0hLOUw0dTh2WTl3V3hVKzRNb1pYMWdvZU9pMVIzU2FEcDNFRC9s?=
 =?utf-8?B?TEVOWXdGQks1QitqSmZUZzFUYWF6MFc1eVNlU2t2amhLak1WbnZRbG1vUlVn?=
 =?utf-8?B?SFFXY05Ga3pNbmxmZEUzTHRSRHNGMDVRVzRnNWVabDc1OU5OTkl4YkxCdUdm?=
 =?utf-8?B?Z2J6Y3JPWnBJdU1SSWFDOUw2cUVhSjA2bDd2MFlFWXZkUUZFd0IyZ1EwTlcv?=
 =?utf-8?B?ZlVhRnVWWWhHK0dUSCthZWtFMXRMVzJRdlR4bUk5MkdQUDgyblpJbTZybndC?=
 =?utf-8?B?UkxFQVl5ZjNCWnJqMHVmQ3RrT1Q5MHo0cG5vcFNFUjgrejdwUVBoK2dtNTgr?=
 =?utf-8?B?MG5QTmk3MHJvaXl1REhyRThGelNOMG5IMnF4VEt6RGkrSk1XY1ptZ0dVQUEv?=
 =?utf-8?B?ZzBoc0o3QmI5OXBjOU5lb3p3Q2tYSU9vK3BJSkpUOWlVNytMdW4yemxVQTcz?=
 =?utf-8?B?TCtSd1E1eHZRMWQyMkdyM20zdC9XQ2lpd0QxYWVwQjVMNXpiMXAzbG9HK0JQ?=
 =?utf-8?B?d21wQ1RlS0RKL3pNUmVyKzRMNmxCWHdWMGFnaDkwbWU3UTFFeGdONnZIMWg3?=
 =?utf-8?B?bDlPRVVLQnk2QkpwbGZIM09EMVdTenY4MGxaOW5OT2VyWDJQdXhkZnFXdVdu?=
 =?utf-8?Q?FgdYuSY5ua9iwVas=3D?=
X-Exchange-RoutingPolicyChecked:
	WawHChGju3ZwI39Z2aUxtCVn1EncJ1FbCbvz60rHNAn/IskAuU/p8N/T1tqa/oL4gsM7o5k1wsShB8JTfGR+wOwpGVMa3Fe5u6dg13Z9TTVcd0pS5ieGezClezBcjpD+bdN2Gzpq8IGxFRmYTNaIu0W8QvUTsu4db0aVWm9NMwSGd0QOgjd036pOGqVmpgSuUtgp4D/VVVq9uqquFsINPO0plt8GlU+lz9Fum0aiTJeBCWpg3pP6aBEZtVWFFBhQQYDAQXqu5b+l/5FnbTD0ZWOTOLfkC1TZuFVFkzcSr1dNNK9zmV2kzUCvbGDGb2jadUYlKawjPFWYB3+HYOegOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wmCRrQ1IW5EshBh0ks2ctBFt0O19Um9//4U8EjkDcyI/pTM7+/IzEqYp37Xkj0UTGajT5FxJVGqAfduCXJwIHOwoxT+BNCex8WkU//ZfVK7JHPPv5OCuXYGCVunR//7nSOz/zo3daSKw9AfM/uhFn3mkCCyCnpOM8F1n3YjvJ9tShcaC/992+Qk6e7iXDVGU5mXne+WcEZI/qZELWTmuVq+0FRuYRZKi+Tge6HASIy3ntB7rC3CYv5TVf2aiHiBM+xZ3vpJNYIKFEqctPw8nVeK1q032WMlLwHkIhJtFoJtFnjdOOhMg2zdih8HePuEJyOuTrWqSB+sBlRp3hLFHbtkeyFgf2cVvDsUQWIt/npnVzZZJkiemBbioTCfy43sXWQi6nTcx9494FraOIhQx43fJVktPEZQ96GbTe5zHZRypI1nmsmIC//SSKHDC5YI3nykFHwarhSmHvD5+KZ2VMYBwaS4a3uJqOltJsQqX9q4shk7gI3vZt4CIPGiOmxRoDurRNly5M4dva79y54WARHuVaGkC+2m/31leUiyw63keOFpKEyRtuAidBNWPxTYfLVW/wHcoOii26aUbvp+GukyNZDDRcuKsA/5EN2RjSL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b639ca35-c521-44e5-2bc3-08de7f708fe2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:17:36.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ByL4YOQ3fAhprJg2PV0fu19MCv+JAFAZsKH8DlARB2TgIzZf446/X+u22fEs4U5vUJdjnHFgiRUuxKvJFjFyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110112
X-Proofpoint-ORIG-GUID: FKEkH8j70nax1bJrKdHJZ6MsrqzbxcLZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMiBTYWx0ZWRfX6QxO2WLrBXfx
 h1Mc6+sIEnFu7xchER0RuT1KETCMX9JzgTwAj0SDklYccSy/tBBYOTtlxK8wbMCs/NF3rhba8gE
 hFM+LmaSO18E7IVVl0/3sgOmxVcBHs7TOFWPoGYwZ6NQbLQ4oQrABJv0Nm8+rANuK0U7bjnwAhU
 AseVXT9aJn4pzMWPpgaZMinLgwbdKGaHf6BsVes8mr3Kl2O27l6Z4YfXuBrUB2F28C1RUISQ2lI
 10iR+6BoeiIRTlcn/C6erfp3jzUdEvICWFqBlRJFs+erIXUjvCAnBZpkfmOmNpvJ2fWtsOElnU/
 8U0dCgx+xfcOtoM/QkxL4TLja76DfOiWNsg8x3Kc/nmNUg5HVPiDAFLkvCyOTtMNH38xX8nO2vu
 2AMroWkcPMHz48+w336BZxC5IQzluSdGgKnOoLKrcdDyMw5syuyCYhK6v1cgFiI/dFysRHKWbMf
 uf141o883zdfSnGPMt3CemIwIVRsxtlvXv/Ab+Lk=
X-Authority-Analysis: v=2.4 cv=S4vUAYsP c=1 sm=1 tr=0 ts=69b16b78 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=CCpqsmhAAAAA:8
 a=pGLkceISAAAA:8 a=1lxU_i1pMqVcs-XzXbUA:9 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22 cc=ntf awl=host:12272
X-Proofpoint-GUID: FKEkH8j70nax1bJrKdHJZ6MsrqzbxcLZ

On 10/03/2026 13:28, d.hourtoulle wrote:
> From: Damien Hourtoulle <damien.hourtoulle@gmail.com>
> 
> Glibc 2.43 added C23 const-preserving overloads:
> https://sourceware.org/glibc/wiki/Release/2.43.
> 
> Fix three local variable declarations to use const char* instead of
> char*, removing the need to discard the const qualifier returned by
> strstr/strchr.
> 
> Signed-off-by: Damien Hourtoulle <damien.hourtoulle@gmail.com>

libbpf in pahole is a git submodule mirror of the kernel tree (bpf-next)
tools/lib/bpf; changes to libbpf should be submitted there. Thanks.

> ---
>  lib/bpf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Submodule lib/bpf 374f780..6bba5da:
> diff --git a/lib/bpf/src/libbpf.c b/lib/bpf/src/libbpf.c
> index 617cfb9..9e88156 100644
> --- a/lib/bpf/src/libbpf.c
> +++ b/lib/bpf/src/libbpf.c
> @@ -8179,7 +8179,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
>  	struct bpf_object *obj = ctx;
>  	const struct btf_type *t;
>  	struct extern_desc *ext;
> -	char *res;
> +	const char *res;
>  
>  	res = strstr(sym_name, ".llvm.");
>  	if (sym_type == 'd' && res)
> @@ -11482,8 +11482,8 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
>  		 *
>  		 *   [0] fb6a421fb615 ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
>  		 */
> -		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
> -
> +		char sym_trim[256], *psym_trim = sym_trim;
> +		const char *sym_sfx;
>  		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
>  			return 0;
>  
> @@ -12067,7 +12067,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
>  		if (!search_paths[i])
>  			continue;
>  		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
> -			char *next_path;
> +			const char *next_path;
>  			int seg_len;
>  
>  			if (s[0] == ':')

