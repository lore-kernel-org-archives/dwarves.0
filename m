Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0C20C029;
	Wed, 11 Mar 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250547; cv=fail; b=mgRy+1M1QcQCvIOhLc0RESI8CqvX8xvyIETk3MKm1d4gl6D2JJo3LxXn/nTVUJF1XQtp83Gr4o8x/06W2d9pAEJl2L50zE9VQAmIVb6Q7wwycilUHYEGVmrRhFjMcd49AZZOYSzRFdKYuyzpWjS1sS1tlpXvTEeJCVpUjBqvTIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250547; c=relaxed/simple;
	bh=5ztKS+N4VP2iEtpKcD2g6xWOkZV1zC5LBL/VzSUJTu4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FJNVPk4oGXSMlrqM9+yI5Ra5+YpRgM812UC9eZ6Q5PHHsQGMdLCDAjXnkqM3J52+IcY1Ug9bz1sGTMCBgDKUbEHwuROxf75OIioGay9r1ylhEerJ3ScqE3AJ8cevvQbLVezdHyfEiWYDUoPvlpRLoV1lI2hxb/XfqIne6M0LkBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SjBneTZv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nMx+BvzK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SjBneTZv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nMx+BvzK"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BHHLJL3507818;
	Wed, 11 Mar 2026 17:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VhEpQ4BgQbnpm+eb3WqFO3BCvBWYsNH41LlixgCuVzY=; b=
	SjBneTZvWzMRoqiyiBBkUe8ohRsz9Zfro0DzTchNwjmPn6c+T65Z1f2KqU2FBwFL
	00/ZQkEeRhpggJhs70Af1OXbsVTF8DcOIjNQ/F8q/luMd0eQmWg2sGbIc6poNTyc
	0wg1X5/ZsGjgsEx+T8j61dv5MUD7cUnd4lY361a+uYOfmXGtoVnb0+wIbIns5bzx
	9OWjx6m5EPnEbNdFxJraA2vFKS0FAedv2gEHaNA4Qxe0bueA/yphWt5zO7v3Bbl8
	vMwj1UVYqUeMqxiGEEQOBkNBLXSROKj9rgmfeFyLJ656dvjcZZv+G0Xmi3pUTFDT
	AMiv3X9a354d6WCHA2AK5g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu58x0vuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 17:35:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62BHIQ2v020591;
	Wed, 11 Mar 2026 17:35:22 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4craffvpt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 17:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMOSvILH03NUtGRCoOqky5+99HF+0mkaK9VD9KMNKTGT5UGiKLfaovthdAGMwIrdH3AoZVn7P+rD+gZL5uFmetZZfoBz6gz7+ifxCS0c/08LLpgE5oZp76DJPIAiSb0JkMAKf+67+QII/V7B3hWUBvylEIu1+xW8lSFIukW6b0pxASXu5YSOowE3dFa3GUhIPctVci9EKh+rDoaHBGbzUCTFkYKSJPkQZyxbVGEfRdnVnZ/FFd/2Ypi+7gEWKAFs+ZPG1F0UD81v0zysRBq2afyfneKqjjpAx9g3GiA5x3Kf1iPytJzpZ7OLETZXFWhdc1LgpchzlQRMytS9mHi3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhEpQ4BgQbnpm+eb3WqFO3BCvBWYsNH41LlixgCuVzY=;
 b=IhqAG7vsJ7NfVpkKMjYP/a6FtTbHCz1AThI1EOqHp7kyu//xjmWftmVX/j8IXpVStsO1w49hdRnvziBunRJx1Ga3Wf/C/Rt8lTYR9PyteCvjA/eZUE2PXK4tWyt+ACXu/AZbJmkl+wdcVkSUTpHZfthFip2g4z/72dil0HQEkP+ep5yR+dGU0ss9hPFwA+flqvNVeLBLCwHRaBpVEhwUU/JvLinYNpSyjpRASDzEs+LeH/C5xk0DoB4pp5vZRakmw3qrQsA3gbeMC5E/giVglWu9PLKsCs34/4dtkW9PH9ot/R/F8Q+5/150oxKIN+KwcXpe3LR+KUKjaNlnYqsOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhEpQ4BgQbnpm+eb3WqFO3BCvBWYsNH41LlixgCuVzY=;
 b=nMx+BvzK1W7oY5TQAH0vLYVgyl3cxfXrD4FPqTsDTj5EjbwLHq9vIJlSfT9BeUzgsJdNu2jIlA730WAPNjG9fl00HQ9yL3QpSVM8pYcXVPfVTtqk+UxDjZQFMX8PLW8NUB58YpIgq+HaiZ4WvXeso4GQ/6VmCCGubNoOPKGF3Fc=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA2PR10MB4489.namprd10.prod.outlook.com (2603:10b6:806:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 17:35:19 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:35:18 +0000
Message-ID: <b8ec9336-5204-4b1f-a7bf-995858b22b18@oracle.com>
Date: Wed, 11 Mar 2026 17:35:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 bpf-next 0/8] Add BTF layout to BTF
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260306113630.1281527-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA2PR10MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe5268a-d440-450d-a42d-08de7f949050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	MDXYbP71r37AcG6VKbsHmsWpf0kJiVGvoOe4WGMQF5NTKZ+tH31sox3GC2yQ7ZKe6y5Z87h24y4gMaw4AUFQuISdhA+4G+9lmoTPV22kvrou4hDtl2jJf57vSkdUX8Q/o3kn3tWf4VHGVYZs6yHlTLcXPXIY21Ie0UDnIml06h4vykwj2hv8OuFf71EknNHU1h5GqXSbJDqac/oH44od6bXKB/stSqq/bQ5oOnb9nJ40ZFXf59zoiZuZ+1C84UvZ7drGiO0nmCkLmnkPPxCzT9WPPR/kK9WmHHGetrrg6IZ+UOEO6Cq71vg0cCP/G1Xv9WtmAHfo6O9dxG4r7b073A7IQ2X8QCqdbEsZ6Dp2oeod3Uox+eY38PKwI1FaLJYuFvqZc+OvsM3FQQJy0OdUnixYwZYIp/bYAmBbXQR/NmitYuzvmAV4i4o9ue0VzdzOj97bVi928HTUFizJC0P3CEklW2+l0lHRBUdvYPcqrAXXVjEZa43Aq/tDZrwpcOrjLMy5vQNoAj+J8dcgcYrQUK3oqrd5AUTZ9M8pidQEO/MpFiFtfNE6NgvUstUBlaSD4ruLAGL7vp3fFAjwjtpj10ulFRQfXiwUbLOqn0tAKlpXAMGt9TT/PjvyeQQ9zWlYovZ8hCqy3uSiRiGBcKByrX74nCanX6KPQBjIoemrcTkr+csudaU3QtUqgDkXdrb1UmQVxInn0pcY5WOzgBRnxQqoKy6+/bb/BBk5cdU0kbfakJ0zHvLJa4NQ0IeJ74wG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJ5UytGVE5VRTlVL2dxY1dLTDBaQm9mR05xb2RSODJhTmlib3AzMG1IY2FT?=
 =?utf-8?B?VVNLeS9XallGSGV5S3dRMC9zRHo3V1Vwa01kdkhyQnF1elI0M200Z2VCcGQ0?=
 =?utf-8?B?RTBpdmhIUC8vMExYT3RJRFJDRlA0V0xSUUNhM1RKTmFBYTVwU0JVdy9HWjR4?=
 =?utf-8?B?S2ZrcFdhd0JMYjI1Q2t4NEI4bHM2eUhKYmc1aWtVVlBMZzM0Yk1GM00yNHZv?=
 =?utf-8?B?NERxTFRoM0pXaEQrR1Y1UXoyaVN0alQ1bEtUUE9YaGFRUGRTcXBGbEF5Z29k?=
 =?utf-8?B?SHhmRjRyb2h2U2ZFMGRoakRRS0pZUzJEYXNsN2JYRnljb3lJR1NlNGM4aS8w?=
 =?utf-8?B?WWwvTHllayt6R2sxdlNTdnNud0ZkNUEwS1hDRlcvZEZQRk9SQVlxTmJlNmwx?=
 =?utf-8?B?NTFMSkpsaDFWYkVTZG9CODNIdFFQSXk3YUhYeUNBTWdVb1o5UFBiemRiTngr?=
 =?utf-8?B?ZHVkTG8xUHpVWkNyb2VrS3RPWU1JaGdpLytLdWFzM1ZJTm1NNWIvYzZ1NytE?=
 =?utf-8?B?MGVRUjN0K1lUMXhTcjhiSXgzMDd2RFB5YXY2YTNRdnBpSjJ0MmZqOGF0d2hx?=
 =?utf-8?B?cDVVTUxyZk1hTzhnT1dLYXBlL0FsL21xam02MVVDSmpKYWJsQk5VR2ZNbk9E?=
 =?utf-8?B?ZnVzNHVrck1nTkp1anp0Z3YxWlNyK3VjZWJkdm1RMjJzVHl4R2tnQWJjcEJV?=
 =?utf-8?B?R3hWOENib0NLQlljV0NUcjN2Q0l5ZGlTVDRRM1F4ODhlaC82VVpUZjBFSFdp?=
 =?utf-8?B?VU5jSUtoNnFRa3NDRGJFNTRHdjRwTGFMZE9WTUIyaUc4K3ZOZlczVWpCbHBh?=
 =?utf-8?B?ZDdTWDBhU3RTUk9zSWpLV0dqclBTQ3dwS0Jab0hKR2N4cTl1SWYzTlF4Rko5?=
 =?utf-8?B?a1NsbFNYbncwSXNXeDdReGFoclZOYXlrWW91c1F5cmxYTWEweG1MMHV5VVVz?=
 =?utf-8?B?V21BTXg2VEpsZTFBUUpKSWx2WGE3MmJEQkRCeVFoRTVZbzllNzN1NVNIZ1ZL?=
 =?utf-8?B?dXV3V0dKUE96bGt3REd4QUk4QTlIblBvUithTWx5RmxnYzY2NTRyTXR3M1pw?=
 =?utf-8?B?VE8wTGI0QzBuTmxVcXIzWDVldk9Oa3dMVlQyY1ZYM2ZaOTNUd0ZKM2pwa2Ft?=
 =?utf-8?B?Q1Bvc005UHB6dVMwcSt2Wm9JR0QvVkM5M3RIR2pxczQyVVdLbGRvdEhCTWwr?=
 =?utf-8?B?T0NoUERCVllxMUoxeWQwWjg1WE1EOUVhOElkbjNUbkpUbm45Zkp4bUxRalBj?=
 =?utf-8?B?Sm5CVWl0R3pjMFcwbDFmUFk1Vm1TMkpsK2JTVUozSDQ3WlJ1cjdUQzNBc2RV?=
 =?utf-8?B?RzNnOElUNTJqakhTTkNQSzRER2ZDL0JDMHpYTWxiSEl1cXFIWEtGNnQwanBl?=
 =?utf-8?B?aVBPSVBXV0NCNlYvcFBFeVIrRmU1R05ZbVdXQUVrUXZWcVFtZC9zelJUajh3?=
 =?utf-8?B?cmgrb1RpanB3NWxleDdPL296SFhYSi8rMlNQTkNuaHByVk8wa3B0R1JyZUJz?=
 =?utf-8?B?ZDZrWSt3SHlPaUNtY2ZYbWVnU0UyLzFTVFR5dHY3R0NJYVFvQ0ZFdjgzQ3ha?=
 =?utf-8?B?enh0OFF4eFhpV1lOTXVDL25lYXE5V1hWVG94bVlHNzFHalJKOXlJVFJzRjY1?=
 =?utf-8?B?Y2dQSGdUQjI4VGtlRnh2TElFeUdDT0NhUWwvdDVtSEY2ZGNpVGVsdDBRU2ZD?=
 =?utf-8?B?VEhVYVA3NW9tU0R0cm0xZmM2YWplZW9STXFqTTRIb2M4czgwSjRDRzJrZEFk?=
 =?utf-8?B?SmRRK3huNGdzbGRCNGlrWGRJaHEzSTFtR0ZINTlPWG1tQTdnck9mcytmbmZF?=
 =?utf-8?B?SWxVbDNITU9uL0NZbW5nZ2UxSFkwWG4rbXJiRVZmeEVZdjY5bW5PUWZ1WEpB?=
 =?utf-8?B?T2pCL2p4Rmx5UXJoM09YckwzYUFxYWhYdVRJSThDKzdJZWcwOEZBYVdXSzcx?=
 =?utf-8?B?VHQ0dWdwaWszVmZhOS9GSkY2dFR2Njk3UVJyZVhwM1c3ZGQ1dEh6U1ZqcFRF?=
 =?utf-8?B?NldFQi9nOVBwZzhwNldGMzJZT0M0ODgvbjBaQk0wQWtRMUczRWt2NjIrUkZJ?=
 =?utf-8?B?Yi9MZUp3dG4xVTlCSkFNTVlvU0xQOFJROTYyK3lscEJBUWhNWTRaWk1iL0Jv?=
 =?utf-8?B?dm1wU0Z5dGhuTkZIc0twL1ExeWNocTcxejhDSmtXeTJJYXJXbDh0b1dpcVZZ?=
 =?utf-8?B?S0ZUUXBqWVNSRVEwU3FMWXlLY2dFbmFhejZxRi90QWpacnJvQmZKaU9iM0xK?=
 =?utf-8?B?ZzdBRkF1aGpNSmkydzFiaVVQMi9SVGRUZThQZnZVQ1JBUEVxN2ZHeUJScjh1?=
 =?utf-8?B?b012Nk1tV0E4QStEc1pmMHBnZmpCaG5KSkdua1dRSUNZY2hnZHlzVXFDNXJz?=
 =?utf-8?Q?fdZjgPw8SyK8+Qe0=3D?=
X-Exchange-RoutingPolicyChecked:
	U/ey6b9ubV404XODip41GPFv1fgyzsv7694PFnXDEn7R5UECGkcfQm29lJCeljwRhSc9haSdiirrddjpQiTECqcfK4OEi14hxbt/zukmJh1+NWeEw6Vl2eyJJR6rjOuPv67n3QBif2dBsq8gDmg7iE4hgY2jLfMXOBBDejk8R2vgdVztXlxU2fy61iUiz0ALS8PUwPSkOfhmgosm6f7uRteW8aL50d02tqhrcqq/92PLxtsAfMEq+J8E7Im+TBy6EdBkWab80ytir9hDCqbftDa3aP81w3/qyodEBcB6jzUeVP9dDL+hUe+lb5buPwcsENq37lG074LYoQmmb3O7eQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R0Muzb1FxXCu/jLC+/EsKNuza1jLR4/OmHwopu8gtyT4RtwT2xG33FTWiyHGrTzoOVzWAuxTbgPZEGPpf+XyIAnpGYLKcqPC4TnlIqwB98j/TMJvw9vLB+bHPEzL+WprwSR25dEEm+Wqa5NPHENguDtLGP8S5+sA1MYDJLvCS6MOHUcn5G8pOb2ocMG+75+VbyhE0A3xl5D0iIPF5S+wTrUZwRrnbM/tOTeIkuxIynG34hf/M6CgoOIUrIks+atjuFI9ki1KWwM84r4GXg6/gQslMEjyYjkzCHnRj3WMff18aQIv6g8A8v7V6DY/n2T1Iv5W5EGLsUULVo7vCi0MlNGqknu8ocJv6dU+zP/i1uZZZSR16NfVZDXv8kZ7B70kILvFhsSrfl4G3S/z3OV6bnEeX0vCi84XStpTDXC8aTTUaYnyiy3uao1RIWEB8km83oaAk0HxAdw1DRxHK3Baz5GvDXAe2ooiwBONN5UQwljp8zAHCPIIUDK2U8K/jjtSu8FzF29kFZLgWu8UADsrpp0K7l1oZPTmNcODMO8cMN1X9woSc34Mm75HBWsuSJJKkM8+pHxT/ay9CHHsGy+9xC1M9jIzzwWALZ3CjVabBUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe5268a-d440-450d-a42d-08de7f949050
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:35:18.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCowut8Nujb5z+TVGmbTOj7eWGOQLxY78b7JnUWkI4u0gEoAnH5fq/KjCHhLaMTS6V25iryJqKo84v20B+XXLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE0OCBTYWx0ZWRfX+PnSzqjQMnVu
 B0RQrnZ9tGjwCB5rV3qyB0x+BopJJpVB7udrSaksimkIxxtyaYfo1A/jY7OqCxW05KcBdB1T2Dc
 NPGdZgLPKpxhMFh+brXe3vbhR/FbfDBflLpqxEET7L3hiQ5iPAjw4SsZ3TNQTMRSIpeiFCHGbqk
 E23H6kXMr1FKg0kyXc2gmYzYIoSzCD8FkcjwQ8GDgE8vyvXr7K9Kajy6AdXYYH+K26nKZvzPhEI
 LmovBa2FMgiKjAVeaeFX+e7pjJqxD+Fb9AO/uc6ZB4J8xFoVuFhbV+EZv8bwqpzB6W7K/8NqE0s
 E45ZsuwYyY4xfYCeHhVHmiU/g0jExPpP7L+VeHFsEHJnShnO4JOyag1uoIuoWaygSdz+o1Ue9iP
 81kHwoB/VSH3xQafQ3m/Q481hF1kDkPONjDbD0PrOBy9zAzYXTgSo8iLkRA5mWTjVHyL57J9eoy
 63XxFQQi99mE0SfMNVC4YeXU1R2XnDjJyz/bDZiE=
X-Authority-Analysis: v=2.4 cv=f+RFxeyM c=1 sm=1 tr=0 ts=69b1a7db b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=MgbP2ctMBkrPzgifgroA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12270
X-Proofpoint-GUID: X_9LEyIWVxaZPpItcJQE7ovRHjb7GOo7
X-Proofpoint-ORIG-GUID: X_9LEyIWVxaZPpItcJQE7ovRHjb7GOo7

On 06/03/2026 11:36, Alan Maguire wrote:
> Update struct btf_header to add a new "layout" section containing
> a description of how to parse the BTF kinds known about at BTF
> encoding time.  This provides the opportunity for tools that might
> not know all of these kinds - as is the case when older tools run
> on more newly-generated BTF - to still parse the BTF provided,
> even if it cannot all be used.
>

looks like patch 2 needs a resync with bpf-next [1]; let me know if there's
any additional feedback and I can roll it into an updated revision if needed.

Thanks!

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20260306113630.1281527-9-alan.maguire@oracle.com/
