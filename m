Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266B322533;
	Thu, 19 Mar 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946530; cv=fail; b=JiBSrgML5pYSSsx2AlRtTepfUZbus8+XqpRDnGxHx7LimVz3xWk7LUJJBQfVxexFI/X5an3GzHaaFR6c5SLTa90ToVrN5GVXxg3ZgBOf3jZBVP9F3AXxmKu7fdb572u2SemvEJ3HGCNs8fl4NPqeNZlN+MpqvR2G3sK1rjJjGJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946530; c=relaxed/simple;
	bh=6JOLStcCAgJZCq2i59g5+ER1zPOW4qmTSQzmOL8RsXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AnK2Hftp13c0uaQV0uW2GfyRQotlu/SIX3hE/uOZq/Jruxqn7PDhCxV0SsvxdARmdckNCXSN8OvlI/gvcAs/bwnh52f8BdB/kgb557ZYGAR5QtTHKzMwyTdqhLkAyCPzIDK1y7dLWiGJ3ApMt0HD0/ZRwHs06s1YYWvPAse/U3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hLVacVZJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ztlA2QNW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hLVacVZJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ztlA2QNW"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFsTHS1777874;
	Thu, 19 Mar 2026 18:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iUdcXl9EQFfof0YYlwSyuNMkytdVS1qxowhKOsBXeAQ=; b=
	hLVacVZJjQauyiFmmgkYd8tR2aqUjYaVLvHmtBqmP0elJvdbejGXV9nlr1wSX2AT
	NzPNFyEDvBtZmLDnEwQqEQxZN4Y25x1pU8v1YwkTAnRMt/HZiid54NitCRxXkvF7
	kVfGjl17UK/2Z/CQdBp369WmnquVMMJT631IgimSDN9Q+Lw9GdNz6YvEr0NHFjWL
	0vGyHliPtzxxYgcDEx0H4eAmf0NWogTmE4PpwDLzEH/FATgkOqpgKdue5H/uC/04
	0jr9fYO3gvVWFYSeBy8sJTEsuP9S9sVaxawyJ/+9PTGGmpHphqZHcppm2A4C0RAL
	8gJILSMTLS6jOogTnixMHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8gkph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:55:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JHEoC6002741;
	Thu, 19 Mar 2026 18:55:13 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qjgmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r02pGIVBz8fEkinpHlMjlMX9n2Lup4zreMjxrUDU04TNfgSdxN7LlReG7vsxsLsWmu+DBpB/eGpn3vHvfaP6jaMqfXHstc3Zb7HqBkncvjdsM3KrS/St5uEyOXjFpnoXuHmRZzv1oBCNzuXrBnilUum3tfpEfYYmdYg/Hixjm6Fs8yDqMDuNAPkPyCa77KdAxfMzn4WZuuJtk5rJ5JTSoIoE1hsF9KRBJwM49n5LzuAwPFdfXJd+FtotQ6iZwc47ueYYRvcymYfn5lBIFTAUpZurPFUKrZjFA2JvcBv4DK1sufeZlrO18RZGrUt1+70moWa3v7wPeZGEqvfjGNbSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUdcXl9EQFfof0YYlwSyuNMkytdVS1qxowhKOsBXeAQ=;
 b=ATOy55Uc1Si6UEzAkU5eQjI2rxNxAkhXeqXqP2h+hW3Oua2Q3iBYFCE/mg622Zf98uCDVHa3laoEIFcNsO0N5gC/zPUE53QfHEneZuSFUMFrnCQCPfxEb8K8bnAPCpfim6GokhRtBWpSILdYXeYZDm5+MGFOCDQ2DRVn55S96hCY++tYPufC2CHO3qN42rTKCHn2HcqAawMSpcFtDNfqLRtVSBIJA/L6Bhzug50LfDyeSJKUqO13iJrH4oOvK8iNyE7ZKEO2eAjhM7vvXiDHNWltm9+WekGr4Tx7QPpEkiI9xZNmUbCzLKF1nqLTmD1Qxa3Rmh1308CM/ZU8tlIWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUdcXl9EQFfof0YYlwSyuNMkytdVS1qxowhKOsBXeAQ=;
 b=ztlA2QNWCVbwGcRPeKrGWRZ5iVloZXPs0+DhY2qP+fgz8FWu4pH3/boHBJa33zmApgoTe1zu53oyfrWfgnXrpDw9ej+J6TI1LnYwm23AO8qBOintKQqH08eu8L6+Gz9eVzJ5wGG7PaYMiZnHeJAdoLmKmeOKz05/vrGSYryx4KU=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH7PR10MB6673.namprd10.prod.outlook.com (2603:10b6:510:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 18:55:10 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 18:55:10 +0000
Message-ID: <b20663a4-957d-4bb0-bf2c-4921da446514@oracle.com>
Date: Thu, 19 Mar 2026 18:55:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 2/9] dwarf_loader: Handle signatures with dead
 arguments
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260305225455.1151066-1-yonghong.song@linux.dev>
 <20260305225506.1153181-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260305225506.1153181-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH7PR10MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: d69171f4-872c-4156-30a0-08de85e90b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AMFxBHO02wDKks+HxSM7QuLH9u45Jghonm44GYDuZSE1M5eic/Wvd+8nbbOMluE5knxgcA5Mazeb5GHq6Mbjf+1JOAkRp83MaGMD7enuMwt5oKQANhXSzSBArLuhpk52T2f2jn3Ih5qRzrAo7/xSVkjiJb8HOBpm8Oj/g5NP8z56YtNW68ec/HPwp7f1Y1KD+SrreQhoNHH6fzL3p9D2kiVF1ZdoRaq2m3rX80i/gHOKHwao2qCrNqvTHWUvu4AeCPyYjhdd41B+FKMC6JpAZZnAsH/qd713GjNk0f7YzuAyzcfMUEbHuv5Ul21K9CxreeGCNSFor9JrW/Z/Nt9lv4bb5F6q3lzUs4UX/wMHs3ztMzWmvbG7jm/UCjLMXmPutkh8shkQE50iffhU9cHZNd+Wea8x4V3GNA0r3tngVUKp3V+8NNSftSKQ/8jPA+fcjg0OsvjGgfD0sYbJBrSft4VaCFsiPw/yAhAT2KuYZMWNvYG6wHoUVWQDSY+Llg9zP2Ldytn213+wnScV2UG9CacTHdn5X+LOSe4RVeaA+tRFaoaAuwjB92lPl6x4ufY4Gd13BdDJvrVv8lRTykhAxUBV/nNpH8gRGRwxXELAn9p6RelFKShGfTFvK5mpABKTpbRpJyvBeuDqzKGs3Q7bS+3f6BxfrFQHEKW0GEkAhPQCPM2Zoq9AqKJ0Jq4gb4ItFn05LivBFLK+yWZXt2j/tgYCrW9w83frj+TZvqCaa4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUhTdHlsdmphckg2SVoyalEyeUN4N0pTK3AyaEdmZDAwS1VkVFRFbHNuNXFx?=
 =?utf-8?B?bUI4SEhISGRCMzB1RUpwSGp1UzVSdkFMQ0VYV3d1MEZDbHg4TUFORDVOZU5u?=
 =?utf-8?B?bklLU1laaVloVGR5Rk1LREdpMm9NTG5ON256ZHBLMzVlNldqWTg1bTM5TlpE?=
 =?utf-8?B?b3NhT0ZFbm9JZVRleGd2Vmk2TGdYTWtJME42ZDlWN0xQS2VoLzRKWGdhQnlD?=
 =?utf-8?B?NEZOeGxDVXVVV2NLeE9KZEVOTUNralR4Q1dYN0lQanhkbm80anE2SGhSeVlS?=
 =?utf-8?B?MmMrSkswZkhTbHBteTFPd0NBK2NpRmxNTSs3STUrbjZBUUlOSGRWaFE3Wm1l?=
 =?utf-8?B?WFJpU0Z6eFgzaFJuL0VSbkxNbldZMWFFV1A4cXhtRzk1RkRkY0xjQURaamd0?=
 =?utf-8?B?VGN4VmFINDZSY3NlUmRPcFZqS2pCaTRzdHp1MFJWQU91eXQxYVo4L2VYdVor?=
 =?utf-8?B?eENkWCtVeldtT1MyQmZKdzJBUHFLNXUxc3NIbVpDcEVvT3Y1dVlPMHN4c0VQ?=
 =?utf-8?B?cEFXMTE4TnV5VTB2NmZSclQzY05UbGl4THBxcno5R2lUWkszMG9DakpIMUNT?=
 =?utf-8?B?Q1Z1WW1DcFNvc1dvOTJMbDY4eDFwV0NqR3c3a3p2Y1lzelVweDVOTHBsZlp6?=
 =?utf-8?B?Y1VWN3UrWmc0VUF5Mk0rTzdoZGt3bWErVGNTUHhGdWp0NFZ6U1FhSEtDd1BG?=
 =?utf-8?B?dGQ0MVZ5VDN3Z2NPa20zdjl2RFV5MnNkSlVFbmd3MUJSSzEyMEE2ODVZTDlK?=
 =?utf-8?B?WExYSDE2cm1sSnhCcGxCeEhwUk0wa0FEVG5TSFRkdWFJejd1WEd1Y3pOeWQ3?=
 =?utf-8?B?Ujg4K3VSOWtjM0dEaTJDR3dWRW12bkJIRWx4M1BMSGV3VHYxb256QWxOZ1ZQ?=
 =?utf-8?B?MnhFaUpKc3dlVmY0QmxWOUtJQkozRVZMdjhtK3dTdEhqRjY5UXVveWh1T0tI?=
 =?utf-8?B?Q21IMWxNdFRnRVRZL2hva1lHeTRRRVR2d2RVMm9sc0c3NEJLZ1R2b1FITHgy?=
 =?utf-8?B?eFF1c29FU3VkWGlRTHFzNDY1dmhORER2ams1S3MzVDdlc1N5RUdwR04zdlpv?=
 =?utf-8?B?bUVxQS96SitDMHZDOFBNaDYwUkpvMExiUmFmK0hIcCtTNmRFR0ZvTWtxWEkr?=
 =?utf-8?B?aCt5dGF2YXZ1TTgvR0FickhCVG5NbU01cjlRNUE1NVg5NWI5RjA3QVBCREht?=
 =?utf-8?B?RkpNTW1VVmhSdDdCaEw4Vlp3c3F2VXExYzd5UWFKZSt6ck1hVFRGZ3ptRktC?=
 =?utf-8?B?clA5YmVTNnJDcmZPL3ZpdEJtMTRZdTZNR3dIb1VHanVqTlpnbi9xZVJpVlB3?=
 =?utf-8?B?YmtPLy9qZlJkcVBtSzZUVmNSSUltWjIxV0FHa0l3dEdiTys0N2tMcnk0c29T?=
 =?utf-8?B?ZzF6SE9MSFhmRjN6cWlsSGdZNlBRR25YQ0prRjkybnA1VmJZUmt2RG51ODY5?=
 =?utf-8?B?eUhOdFN4MGU4RkhwaGNpbVdMc01lNWFab1pSNmpzNlhJZ0pSa2Z4MU9MTkdZ?=
 =?utf-8?B?VDRndm9SV0pxRXVudkNJdGVtUVVzQ0JRcXhabVdFREF0cG1ZWFpoS1lWRVA2?=
 =?utf-8?B?YnNMcXhic2RDcnFSSWJ3aDhmYTdpWDlMNkVPcEdRYmd5dGtWRnFoaGRtdFFZ?=
 =?utf-8?B?YTZERXJNMjFaOUd1S1dXNVpyQVVPcnFHNzNsSVNuTnRPcVlhUkMyZlNKRjFk?=
 =?utf-8?B?Zi9icGd0MkVtSjR6eHlJMGViS21jTW9qcFI3WTcwdVNvcDFjaWpEb0JKTnB2?=
 =?utf-8?B?UjlDWTVaSDdkb3AyUWp4Nk5xSit0QThGY0NxaCtwZTRPQ3hmTW5FT3BWWW0w?=
 =?utf-8?B?a3lzczNFUExWTW10VkIraVNIbDB4NXZYZWM5dkExWW5VUW9WajF2Zi9Fd3I1?=
 =?utf-8?B?VzczbDJoUWdRYVQ0SmhrZEphNHFQUWpwUnRmNUIvSW5qeVIzTnN0cFd5Ylc3?=
 =?utf-8?B?elVOUHRjaEpldUQ1cWhld3EyNWtqcC8xSjlkRm9UUUtSSHhwWVovakE5Zm9M?=
 =?utf-8?B?aGdSUWQ4T2ptZ251emRhaUtwcEpVcHl2TjlKeGZsUnBWT1U0WFM2ZG9Ybldm?=
 =?utf-8?B?WGdlMzRjOGtFRTVaNnV0K1puZ2w5TEowRTZGWks1aVE3cXNMSEt6U0FmT2Zl?=
 =?utf-8?B?OE1hNGduWU1VejdTU3J3UnV5MUdSM3FwQk5IZHFGVFM3S2ZDWjhjbGJwVCtP?=
 =?utf-8?B?RldJSHY2Ri9rd1NnKzlqMEk0amp4L1VkcVovZ0NsNnlwQUxVQkRJUnFvUlQ2?=
 =?utf-8?B?Z3RQd3NLUU40VEZYazlaYjcrdXZGNFd2WVdmbGVIc0Z6SXlCY09VbHZFcVp1?=
 =?utf-8?B?cDZJRldXRkc2ajdnV2U1NkpyeW5sbk4wVUhZb2xrVDl2U1l4SlpocEZWOTlp?=
 =?utf-8?Q?nm/O+Hak+WxXjqNQ=3D?=
X-Exchange-RoutingPolicyChecked:
	eRl3ep7NqwDDvRZS73CZgn8xfpTeyV/2ghP5J5w1HgdUIo0F1pJFYfLn1m9rCy3FO7yMR4zhn2t7EN9rQnueQIyWgMNuC8B3BWPdIIyaEHyEoPPdNY3bFy2q8zE8ddrZPsVxXNcVj3uJ9h9+7gR2g5VJpMnyjVSPpJ4l4Wh8z0sQC1HZq8KL92kSBqF0ro7GMp69ktd5JBBtdcSxR2b/O5/B8Oo6vEQqXBimjLpDOlL3iAY5qc4EwcbQ3o1j8XpwCnNkpC1PA8gP/OtAhCesEhV99RwxYozIv4PZ4NJd+Fn2RsQIG3pr4oswFupcrvhb69Cq4jaso1IXom6b3IXlYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JMxeZlTHHLppJp4uC/GfeFAt9YNUbZBmeHQ3VX2VzfudrSyLecYNA6/3L0GGr7dJ/uOP9fOZRXS34rzFVxqLZGG8FNVkYOLh3Wk9QS6y8h5giFjylwyhsXyRMICEmsTqytD9PTGdVwY+s7jgD/ye08CzBC8zwY8IigQ/EgJVvs5TY6O44wfMYlYDrhNc8KrapiDU1B5+9UeH3+880s+qVYygSSaVxhkB8V8tX9FNl4QQuFNI+XcSpZ8qZsSo3SJhKqV3XwulBrX/9dq/diaCN0w1Ws3+f3KT6FrSfUm8KT8UmaHOBEBw2CikGTwrW1V0Z8PC0ut83yTV3UeZ2hwh5dzDiTeYpgwa+jF3yVg0GO+JeTc1w7aPriBUTGPrRSzZdT63H8L0VjclvAxUsMFgLDO1vlGACGhAIFPHVQBoh0AdusRmtLBbOUriNhCAYMHMCW0QIvkFlH1CTf4MqYRCTQI6ETAxJyTkrI4hm4qQ9+nUWSVA0Tkq3nowQ89GrDUMd0k7Za/une7D7fpeDHrycL0krQPgO3/9iMBLZArCemR3E5MiGt1C/qODTg4ooWsBkNGr75zRqbonWs6gRUrvvbryliG/tkuqpha0iEUAmGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69171f4-872c-4156-30a0-08de85e90b6d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:55:10.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I65sJ2D8kpaN+bQjxt1+IMjdi4xVrwO5pEx7+M/Y7LSFa/g6mrS5A3/3P74zHVeso0RVYrK51X2tU1E9wTnjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603190151
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MSBTYWx0ZWRfX1hHaesDoCGLW
 q7LohgISpDyDjJX9Lf3VbzOZvwap/gxdbmfEMzTNfxJ+VquEsHkh+x+hqbAT1EC85gGGnZfmMuB
 6qGAKCzK6G/lEO/hkN60zmU4Qud6Oz84E78ZRN2aqAzu1/Rm2XANneE9wswUE36fNJkpa+HzEqq
 kckQVPCYYqy3Xag2XSQk3QoQHXYJfqRUiVxRmTk/SG69zurFyNZ+48b1DezpDGzrxpajHRr9s4D
 chINQsL56nznaM8/nXAm3KBY690eN0qxUPoaUswgGvBCbO7GGW6vjxYbozNOLlZTNHQCFCYTTxq
 8oSp38+Ax+VvSqCnK3Gq5+AGDmB4yko0V7+pPQGzT/QJFMdXUkE8SHB1TNaxL3SKJNmHPOZsLLD
 wCXUgmpt31CDgYnZ9fAVgTCfLP5+JtDlTYQZFgmDqmE7swVvkWBoZptCODdsc/UsUAJ0kpwOjOq
 SOP44X6FN5+4p3Q7znaycjrFl79Gkc2cZXnpwio4=
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bc4692 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=FBXINYwjiA8RWq8bD8sA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12272
X-Proofpoint-GUID: 9YfpQ6Ogp3QMhCzf66TQdSJ9GS0m2r5X
X-Proofpoint-ORIG-GUID: 9YfpQ6Ogp3QMhCzf66TQdSJ9GS0m2r5X

On 05/03/2026 22:55, Yonghong Song wrote:
> For llvm dwarf, the dead argument may be in the middle of
> DW_TAG_subprogram. So we introduce skip_idx in order to
> match expected registers properly.
> 
> For example:
>   0x00042897:   DW_TAG_subprogram
>                   DW_AT_name      ("create_dev")
>                   DW_AT_calling_convention        (DW_CC_nocall)
>                   DW_AT_type      (0x0002429a "int")
>                   ...
> 
>   0x000428ab:     DW_TAG_formal_parameter
>                     DW_AT_name    ("name")
>                     DW_AT_type    (0x000242ed "char *")
>                     ...
> 
>   0x000428b5:     DW_TAG_formal_parameter
>                     DW_AT_location        (indexed (0x3f) loclist = 0x000027f8:
>                        [0xffffffff87681370, 0xffffffff8768137a): DW_OP_reg5 RDI
>                        [0xffffffff8768137a, 0xffffffff87681392): DW_OP_reg3 RBX
>                        [0xffffffff87681392, 0xffffffff876813ae): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>                     DW_AT_name    ("dev")
>                     DW_AT_type    (0x00026859 "dev_t")
>                     ...
> 
> With skip_idx, we can identify that the second original argument
> 'dev' becomes the first one after optimization.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 610b69e..1ced5e2 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1192,6 +1192,7 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>  
>  struct func_info {
>  	bool signature_changed;
> +	int skip_idx;
>  };
>  
>  /* For DW_AT_location 'attr':
> @@ -1264,13 +1265,28 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  	if (parm != NULL) {
>  		bool has_const_value;
>  		Dwarf_Attribute attr;
> +		int reg_idx;
>  
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
>  		parm->idx = param_idx;
> -		if (param_idx >= cu->nr_register_params || param_idx < 0)
> +		if (param_idx < 0)
>  			return parm;
> -		if (cu->producer_clang && !info->signature_changed)
> +		if (!cu->producer_clang && param_idx >= cu->nr_register_params)
> +			return parm;
> +		if (cu->producer_clang) {
> +			if (!info->signature_changed)
> +				return parm;
> +			/* if true_signature is not enabled, mark parameter as
> +			 * unexpected_reg since there is a skipped parameter before.
> +			 */
> +			if (!conf->true_signature && info->skip_idx) {
> +				parm->unexpected_reg = 1;
> +				return parm;
> +			}
> +		}
> +		reg_idx = param_idx - info->skip_idx;
> +		if (reg_idx >= cu->nr_register_params)
>  			return parm;
>  		/* Parameters which use DW_AT_abstract_origin to point at
>  		 * the original parameter definition (with no name in the DIE)
> @@ -1309,7 +1325,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
>  
>  		if (parm->has_loc) {
> -			int expected_reg = cu->register_params[param_idx];
> +			int expected_reg = cu->register_params[reg_idx];
>  			int actual_reg = parameter__reg(&attr, expected_reg);
>  
>  			if (actual_reg < 0)
> @@ -1322,8 +1338,11 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  				 * contents.
>  				 */
>  				parm->unexpected_reg = 1;
> -		} else if (has_const_value) {
> +		} else if (!cu->producer_clang && has_const_value) {
> +			parm->optimized = 1;
> +		} else if (cu->producer_clang) {
>  			parm->optimized = 1;
> +			info->skip_idx++;
>  		}
>  	}
>  

In [1]  (dwarf_loader/btf_encoder: Detect reordered parameters)

we detect reordered/missing parameters for gcc by comparing abstract origin to concrete representation
and mark any such functions by setting the reordered_parm bitfield in the encoder func state. In this
approach reordered encompasses both missing and actual reordering; in practice it's always the former, but
the DWARF representation was confusing because it had the actually-used parameters (with location info)
followed by the unused ones (without location info). Before the above commit we were treating these
function signatures incorrectly as valid leading to wrong functions signatures.

All of this is to say: should we mark with reordered_parm instead? The reason I suggest this is that
btf_encoder__save_func() has handling for skipping functions without locations with reordered_parm set;
maybe we could find a way to unify that across clang/gcc cases?

Now in the clang case, I guess reordered is a poor description; for gcc it really means "reordered as
compared to abstract origin". If we could find a better way to describe/encompass both cases that would
be ideal I think. The terminology used in the gcc true signature code isn't great today.

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=109e5e4554f663e5f12fb634bc54cceb710aec61
