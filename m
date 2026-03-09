Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4613B95E9;
	Mon,  9 Mar 2026 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081600; cv=fail; b=pSfWt3yVei9BC9o15qp8yGAXsixKxf6M2iQx5JolcfoJ82E+GxJf8GMhQd0+NZvsssxHl3gWvnTx4N1KfDhjyin6uRueP8s2So5VbDGhwe8m67TyX7kt32gFqo6S5QYfl0piLdj92l1Ju+Koc7jG9a+zHMlL/jBL65FiKapSfQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081600; c=relaxed/simple;
	bh=Jp9t+CbkSPK4QCJURWZfMgw6GSrpkIBrVR1tGr7ftpo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CkHLeI4/2S2rVQsVXXd5D3FO50S6h97lwCjIbwR9MpnnsTbQV2o6NTeakoTsgaq6Rg9u2bet5ytTE4NyR/8f7U0iBaAS8s/xB2uxQrYOb164+iCJC0DoTLoGEyyQo7hGpy2yaQL91pStGHmel6BXCu0ScKe27y+YGg9yzHgTRW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JDoRG8bk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A652kUbM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JDoRG8bk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A652kUbM"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629IMl9x2581514;
	Mon, 9 Mar 2026 18:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f+OqcXom9H2saYs2ga2yYKzHwy0C3PFaaoPu9M/XmFg=; b=
	JDoRG8bk+GdEkxbHU4BEcG7u9Z8QSxyjN9psFAenz9avGt/DyPZDOwFc/ix3LhUj
	Yqj/hXueaDZgLyoMALcS+RBBH0GwxY154+q3RbRcid+/N2JBvr3pvzi4vsicSfdZ
	L7/kPHhqvVNuOZZsd9U3HgbsoIpI8K5xVwZmfIgCdONi3vmmPPfNedPpJRamqrvD
	5E6ua/5daueYnwET+8vFZ9s/gvuB2NJORO3gvTEASQaL9jy6lJb9Xd1+PVi/oQsJ
	er91DNd0vnTgN7KKSHaQ3em4ULHyPCUHSKeWiqaBCASmmS1bAXJH+m7lani/4UC3
	MX6ZYf/TKwc0QzG886f5pA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csm9cshyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 18:39:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 629Gx8Bc022828;
	Mon, 9 Mar 2026 18:39:45 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf92m9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 18:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdgHg3ZM+NUnhcFA8XTnwizJZTQoGcgIxWMl51nebkhvGm3jp4RXjwpBfkbRLbSihVYExE0dcnWbUPYaI6CRV1ftSy8Bw83yIiqZQojG7bL5c5vWzA01lobMsAc6zIdj8ZcH3pAuBfE8+NzW+egX3Dwok+cCnazDwUfUgiICgKE3shBFDqfAr52FvzBmKoSve4DAhd100F2aGA2QZuSyq6jnBN8A3LCTrHuMI64SoMCroh/m5d/C5DiW94+9KvB4R5UXv6nkICgrBPL6u/chw5Uab2UpJLtKcnM+uVu3kil0y9yrvgQ5KNgtTxQeWPd1WlEJcu74DaBZu6wwB6PNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+OqcXom9H2saYs2ga2yYKzHwy0C3PFaaoPu9M/XmFg=;
 b=c5aSjUZN8iI67op9L2MIKoSEBBgOHr7h24tGQ8fuL9v/hcC86uN6PsX16wmDe/5WZzZuNkIYSUUMawOsxm7tJf8TjzVSmZwhD22EgTmLJ32V7OyyyEjtBCyWnOgZN8mB9cvEjb/pQSgeNhG6se1UhBJcWDTApcAfmt0/3vrWZRv9AZyuWHfD3blRr063WR8xhmhZH/cqpDeuNrb4PIlOg70b7hcxAu1WRcncHzuZv6fNecZFH3j3TkSb44vMcsXxhFnr4nP5NIlGt1q8fzhpsittRqXTSyDvR5sA9uDThySXdsAEwYAn4ZABQYLD3UQlyqoe45gJ/zKuHPWzEPbzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+OqcXom9H2saYs2ga2yYKzHwy0C3PFaaoPu9M/XmFg=;
 b=A652kUbMMHXW3xGFVotzJR+kc42p3GhFcExmXv1YrCS/yYQsSmDE+ZoUvGeZaPIvP31dC7M2RxTBWEHT0bENAlXTUnJ2lWiLisEkarIVSuXJRJpzJlQlZfzXoCbyYzt/GmhiN5tBPIxqEAPAGE2Jw47g+0VZr7NlJPDOLvLx4tE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 18:39:42 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 18:39:40 +0000
Message-ID: <976a9e56-a221-4f63-8f10-caf2a3c8fa4f@oracle.com>
Date: Mon, 9 Mar 2026 18:39:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2 0/9] pahole: Encode true signatures in kernel
 BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260309153215.1917033-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260309153215.1917033-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0375.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::10) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BL4PR10MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7cc10a-500e-4564-b2e8-08de7e0b38c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	2Fbw8no0d12dLn2XwxfdjYuXr4NEwZvy1yJBzhmQFxHoR4WSkRFLxDTO/w3+kdGs+l9tSvTh/H2ozy9jvPYYPYq1h+kzhSDn+taGBqPAxDDDJdKW/KnUMvxE/ID/cfpGTSoZuMsocmI6Wsjzg0PTDm6ZUdFRDG8gx3VkkMsdMLAJROmAtAqIcm2L7PsMCXWyaGkc5+xiuBWjU/C3W6pxjaxE7ZmC801xxPWuo/AxBcsA48w/xi+PoLOh0r3wHPQ9PHoSgO13MYa+0gx5Akx3fIGr3HKNyqRyNajr1/G/ZR9DSoHsTLEnQVpUIliMmkS+AqefQL1Yv9l6Ukn/vUeJ0GCDWesX0WdDv1l1BGHuHhQrd2kB0uSj9BO5nUAbx1FM91Kc6o+llzhxKuICguVeyLg6ouREL4S4mrkBl79IVWume8OVnlvYICJIW4tTVgwT+XXRLd3+jX4CSTgiuQqLB9+pqtPrQBu/2gYXbvxIgQM02q41MpzB4Ke/viESEtUprz7vCb2qOSJhwhpVHfbns7yk4OqLN9GVnrbpQc+tBvvGBtPwGIT2G67oDlqFHJxhaQuknIGA/Ry3J54+95WprI9ZpMjJIP0SA9zy9qNSXkPLhb/zWHQ89fl5xRrx9RWTFOSP8EmuVV6jlyD7yuDh2TcdWutjsJM2oWGzrLKHbZ3D2YBBlVhb2ZRdYsQQWpX46aaq/2/RWNkvwo5uBsXen1Lo8DIugj/2dynPIYggl6I/F8wheV4BNLbrz6oNmlTg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlJwRDNsZURKYWY3WXFPQTZ3b2JxT3FBWDg4REJpa3djR0VTZ1NmdUpsb2w3?=
 =?utf-8?B?RVgxbTliVGhNSUN0S0hLZU0vblBDL0NSVlFOTDRsUkVEWWtXdHlvWkYvQy9B?=
 =?utf-8?B?cklzcmhZM2VoSmY4ZTA5OGdSQ05paktyNnhEZXkrNEhDVWU1NFJiOENQYVJi?=
 =?utf-8?B?eWx5N0RKOUV4cGxMVmtLZytlNHg0c1UxNisvV1VvSjYzVlVmeTlpSFJQZzZk?=
 =?utf-8?B?TitrT21WYzdISUlOZXZHeGZvZjREdktFMkpMN3hnb1dxZjZpOUJPMXVvTm5j?=
 =?utf-8?B?dkg4WkdlQWxOUmVKaEtzZDdlblhBNUZlYmFha2VhMlZUREVyZmZLZ0dpTXRR?=
 =?utf-8?B?eFJJZnFLRkFLeVBiajRkYWFBOWtuR2dUQnZvUzFjcW1sdWxmVnhtSE9iT3VF?=
 =?utf-8?B?Yjh2V3ZTeTMzaEh5K0gyV0RnZHlvemRtQlJhbXJCNUJxS2hUVmc1dEh2YWNM?=
 =?utf-8?B?UE10ZVlBM3hTby8yTzI5RGlJL3FLMjRYK1IzTTdvdmdwRnJFVkFQK2l1NXZT?=
 =?utf-8?B?ekIrcnhvMDJUbVk4NXdXZUVvWWRjcWNxa05SSjNjYis3NXh1M25KSVB2Q0d3?=
 =?utf-8?B?Y2VDeHErbXhDVVduM3NzL2dHRVgrS1dJcFlGYXNDM0UyNThZaEtMck9USFFG?=
 =?utf-8?B?OHd6VmlvNndZT1dMd3FSVkRoVGFRa1FyN0NSYmc3OENpRUdzcUtlY0RvbnRO?=
 =?utf-8?B?UHZQYi9hTzFRTWdSUyt0V3ZpUFFEK1BRbHlmeXc4Z0JnQnllYzd5VHc1WFJQ?=
 =?utf-8?B?dWlGMWZFVG5hVjgwdDRRY21uOWlkOWk1eU9JM0FrODU5NzFrb3hTUHVmMGRL?=
 =?utf-8?B?SGMrSFZrY2FjSTZnZjZBNDNKTEZPOXZOUXdZK3g2ZXliSG12Q1ZuczEyejlp?=
 =?utf-8?B?dlJ0emhySjlMZmFwVk8xK2lLTWlEbjFzeERJSmlpelovcVI3QXhnOWJNa012?=
 =?utf-8?B?SGlvMDNkYVVLbEZmSVFONEx3ODYxOUNLT2VNSUIxanRtS01QdVRreGZBZzcw?=
 =?utf-8?B?NzhOdkVYWFQrelNpVXNONjZpeWFGMjdCeFJPOXZMcnQwTStBUUVUc0pVdmhB?=
 =?utf-8?B?bDliaXZENUZGUWhVaFZYRWt4ZWxSajJweDNFellJWEFKTU82SzRhSFgzc0JN?=
 =?utf-8?B?YUt1NFNvZWI0ek82SHJhOElyek1vSlVRTkdkQ0RLZnZhS0dzNWZ6QjcvSDNn?=
 =?utf-8?B?YTVVS3o2anBac29zVzhOMWJvYTlKMHFuNnNZdng2cUJkN2p0Wm5MUE1RdFVS?=
 =?utf-8?B?R1Jwb3ZIODJJdDJRVFFoSVg2YmJRMHdDQWNQVXBvaGdsczQrbFlsb0pUaDVV?=
 =?utf-8?B?RmFkUmVJbkhzdjRMQ2Zya1JLYlRVTlVRQnhvcXNxbjFlNzZFdXVrZ2hXRHIy?=
 =?utf-8?B?QW91bDR3QjFmcUxVa0d6T0lxNDJ4cWxteUJQT3BVc2FudUdjdlpPQmFBQVFo?=
 =?utf-8?B?bndGSXNaUkZVK092Und4dkVQWlN1QUhIMlJ5TzUrUkxwQTJSNU0zRkVjbUhC?=
 =?utf-8?B?cjRaVG1pL0l6YTVENXA5cnQ4ZFBuWHJVUkpnVVpFTlQrT200WUIvTWhuZzVi?=
 =?utf-8?B?VUJGVmpqaHBTQWRzMWlEWUVyNG9OWWdMZWFuTHRESXNiTHhKNjgvdXl3Vmwy?=
 =?utf-8?B?QUF5bXZFUGYrU0xkUEQrY3dRbXptZm1BaXd5dGcwSGpIYksyNWxHWGtzbG9S?=
 =?utf-8?B?YXBxT3JsN0xzMzJKaWpKT2VmcThrdkx6MWVNQ1k3bURraW5MZ1NiMVFub1Js?=
 =?utf-8?B?U3QrRFZ3d0IyejMxaGI4NWRDM2NTdUJuVFpnRkdkK0VVdGdpUGFQSWF1QkFp?=
 =?utf-8?B?Y2JBcXZsbXJUaklSc0EyTGpISFBEcGg2MDVHRGx6Um0zS1ZYczBEa016TURv?=
 =?utf-8?B?eEU5L0pwcWZReG92amI1UWp5cEpwbWxyd0pidWxtTU94K3BSbVd3RHZhK1U5?=
 =?utf-8?B?eTArZ2ZQbXAvQ1RMWnZITXQweGZad2RSZEdhMW5Vam42VXAwUFJTOTZLLytJ?=
 =?utf-8?B?V3ZhUTdKQ1cxMi95YUhFR2ZpTHNRdllvU2k1c1N4TmlzS1oxcm4rNTVjejN0?=
 =?utf-8?B?YnJnTUYwMjBLSjI1OCtnM2xlMHhjK3RvOXc1WUlablFVa3pFKzBDaFJiNEpu?=
 =?utf-8?B?MlJJVThZUGU5ek0vTzNpOFNxT1Z2ZWtVYk8zZU5RbGN0SStVZmJmNHhmbllN?=
 =?utf-8?B?dC9kOG95M2NkdDFtOHo5RjUxdXFReFpZYTEySFlmRGQwRjVPQjEwaEh3L1pP?=
 =?utf-8?B?S3hSenhsVzRzNU1LZmw4QXdHZ0FYVWQybjBGVzZwREdubVd3dW1odHl0QWhw?=
 =?utf-8?B?U1JhWVMrOHJ1c3hVU2RHTDk2OXBlVDFJb2s4bXBUY01CNllWRytHdz09?=
X-Exchange-RoutingPolicyChecked:
	XLdiUiVWve4PPPPHZNwoXCggp4PcXIP3Pfz9umU/dKz/UpA//uR5RyUhsQSXxiApOPgfPcTotArPrciQoSwKaPCBsjjGaqtEBKHPfsZ/swhRf4TBHEMaTg3Llao5Pd396EuISxZNFvNnzcZvtMXwnC5f1kwIUAXR8pMMe0pmYgLDKA8V7bK+NdNNZus+93zjifP4JkJ9b2NCKrmBNr7a16hhWLg2yzrcl6PwAC6v6ISa5WI2h6zXxHXUuYDmZ/HnKKPe3FmjR1h6Lp5DSX5pIehT9dJOyCeGdbIRK4mNYXNJjgQxc25WNxM8xkSMWeWggEpIgKJAK6q5YXr2fIcoLQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZQmRJD+GB2cIvX2mV2BjeHgIBSk2r4sAPtl0LunzO0Ib8McPxiT+VjIN8tmJGgiZp90h12kPWUTWNW1Xe6avZyqh8rLfTVcpXoLIgBpbDkYdQkYpbSG05Yjdwk9l0SInk73P9VYGR8G7Mdtwv2nCpQ/EdliN9PY467epww0dU2Dv0U6FIprRr1MXbHzEaKDzUek5/Oqr60mT0wJoFN+NUd9wQdR79XXa20Jf1pk/A0hL97/40UHTb6WrurFKKkGB0M/slbGKF/njoOv5gIPml9yT4oWQjH80WXZsPaSs6RmwaDKCSrh2C82jIm9i4cYfoSIkMAJ3CqibmBpZBjyn+0Q98ss0nQcEuKzdz+TZffy3/ABJiDFzszbXTAZA+pC4vKO5DyhdlPtVrYu6MRzq6ZluCoW7w64nmuix8xdLeiXcohSjFblVWk+p67z8IQshTdoSdl3RWMqT0JOb/MpBwN06HVm/MSXe5yQg2v2LT9dKzEUc0ptg/wYm5iGH9G7sHmM13AJ54HFSvimFUXFhEZ1gRbXPvULR2+WylCGQN5BeynYbi92qLiaJYDBrB9EOL/+EdNrl3L5zNu0mNgJxgqEVDeF5wkJ01wjhMK0vn1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7cc10a-500e-4564-b2e8-08de7e0b38c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 18:39:40.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NNtjdwFM/eAvgT1gllbWN8P5MjxZx/3pYvPtkqQGSePrWyZGRFhboKTLjSGxbmHLF/YaY+qvhunVggVnNvxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR10MB8229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090166
X-Proofpoint-ORIG-GUID: 96GY0dJyV80ShtgokHXbaj9Nlh2T8dJQ
X-Proofpoint-GUID: 96GY0dJyV80ShtgokHXbaj9Nlh2T8dJQ
X-Authority-Analysis: v=2.4 cv=LeYxKzfi c=1 sm=1 tr=0 ts=69af13f2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=0hdsdqj5Zu-4kJKbtfsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE2NiBTYWx0ZWRfXyi5mPugmqJOU
 QisCuxtcr8QdCQY99euK6Im1X0JDQnkestDTdWCE6fNY53+c8bJMXVvxcdqvsJyewKHvJ2mS9mC
 qXgKOaTudSGqHrB7iH7XMbbg2w0Sz25luEl4n1mEPTfbf+6SOBQpqOdSmjH8uMjVSZvo9pYIm2S
 G7fAS3iDFEYWNEKENnj4YXBlnrl9FM0I6gpRI1/LXltbA7NbszqNK7xGhgsxu6bzP1YNHY+KTpS
 LQY2XfoHGPBVr6mxqIgA8TV5d4BCZvwGoIo7HASNwEBGTsUvcPUITjY7w3YowV6/dJ9pjwD/DgB
 il5DKS8UAtYn6kYb46oV+7/HPVqzm9bxdlte4JVKUFiEeRI9mmeklpCKi4Gi7J5/qC36Cl1tKKC
 MgoU/QdtutMXYjlSKn4Lf83w0PLrXXkvcES76iw+pwABA4hMQH9qjgGYG5S5K+IJOyjStfqm6u0
 l3pq6HLqPz9UBT/WOvg==

On 09/03/2026 15:32, Yonghong Song wrote:
> Current vmlinux BTF encoding is based on the source level signatures.
> But the compiler may do some optimization and changed the signature.
> If the user tried with source level signature, their initial implementation
> may have wrong results and then the user need to check what is the
> problem and work around it, e.g. through kprobe since kprobe does not
> need vmlinux BTF.
> 
> Majority of changed signatures are due to dead argument elimination.
> The following is a more complex one. The original source signature:
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   typedef sockptr_t bpfptr_t;
>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> After compiler optimization, the signature becomes:
>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
> This makes it easier for developers to understand what changed.
> 
> The new signature needs to properly follow ABI specification based on
> locations. Otherwise, that signature should be discarded. For example,
> 
>     0x0242f1f7:   DW_TAG_subprogram
>                     DW_AT_name      ("memblock_find_in_range")
>                     DW_AT_calling_convention        (DW_CC_nocall)
>                     DW_AT_type      (0x0242decc "phys_addr_t")
>                     ...
>     0x0242f22e:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>                       DW_AT_name    ("start")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f239:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>                       DW_AT_name    ("end")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f245:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>                       DW_AT_name    ("size")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f250:     DW_TAG_formal_parameter
>                       DW_AT_const_value     (4096)
>                       DW_AT_name    ("align")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
> 
> The third argument should correspond to RDX for x86_64. But the location suggests that
> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
> the parameter value is stored in RDX or not. So we have to discard this funciton in
> vmlinux BTF to avoid incorrect true signatures.
> 
> For llvm, any function having
>   DW_AT_calling_convention        (DW_CC_nocall)
> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
> and 875 kernel functions having signature changed. A series of patches are intended
> to ensure true signatures are properly represented. Eventually, only 17 functions
> cannot have true signatures due to locations.
>

hi Yonghong, one high-level question before I start digging into this further.
Are there any minimum requirements on LLVM/clang version for this support? Thanks!

Alan
 
> For arm64, there are 863 kernel functions having signature changed, and
> 79 functions cannot have true signatures due to locations. I checked those
> functions and look like llvm arm64 backend more relaxed to compute parameter
> values.
> 
> For the patch set, Patch 1 introduced usage of DW_AT_calling_convention, which
> can precisely identify which function has signature changed. This can filter
> majority of functions where their signature won't change.
> Patches 2 to 7 tried to find functions with true signature.
> Patch 8 enables to btf encoder to properly generate BTF.
> Patch 9 includes a few tests.
> 
> Changelog:
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20260305225455.1151066-1-yonghong.song@linux.dev/
>     - Added producer_clang guarding in btf_encoder. Otherwise, gcc kernel build
>       will crash pahole.
>     - Fix an early return in parameter__reg() which didn't do pthread_mutex_unlock()
>       which caused the deadlock for arm64.
>     - Add a few more places to guard with producer_clang and conf->true_signature
>       to maintain the previous behavior if not clang or conf->true_signature is false.
> 
> Yonghong Song (9):
>   dwarf_loader: Reduce parameter checking with clang
>     DW_AT_calling_convention attr
>   dwarf_loader: Handle signatures with dead arguments
>   dwarf_loader: Refactor initial ret -1 to be macro PARM_DEFAULT_FAIL
>   dwarf_laoder: Handle locations with DW_OP_fbreg
>   dwarf_loader: Change exprlen checking condition in parameter__reg()
>   dwarf_loader: Detect optimized parameters with locations having
>     constant values
>   dwarf_loader: Handle expression lists
>   btf_encoder: Handle optimized parameter properly
>   tests: Add a few clang true signature tests
> 
>  btf_encoder.c                                 |  13 +-
>  dwarf_loader.c                                | 397 +++++++++++++++++-
>  dwarves.h                                     |   3 +
>  tests/true_signatures/clang_parm_aggregate.sh |  83 ++++
>  tests/true_signatures/clang_parm_optimized.sh |  95 +++++
>  .../clang_parm_optimized_stack.sh             |  95 +++++
>  .../gcc_true_signatures.sh                    |   0
>  7 files changed, 662 insertions(+), 24 deletions(-)
>  create mode 100755 tests/true_signatures/clang_parm_aggregate.sh
>  create mode 100755 tests/true_signatures/clang_parm_optimized.sh
>  create mode 100755 tests/true_signatures/clang_parm_optimized_stack.sh
>  rename tests/{ => true_signatures}/gcc_true_signatures.sh (100%)
> 

