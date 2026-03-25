Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80B40243E;
	Wed, 25 Mar 2026 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460421; cv=fail; b=ZAKXUZHVhY7ndnD6vgsGzumj+gyRJtA5NYnvuSKkdb/b+KaEc7JRti5e3O759YkZT5bu8AD9cQMNnaC7c0mX/yt1GVd794Jte6K75mE2i/h9Watwf821cKZY2o+6IDN8HAHnWe4fl6hjfybwrkdM0hOdAehp2vpEh2YT5gaB2D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460421; c=relaxed/simple;
	bh=LD3QRkVbbhPLc09VOlmZNrIaijeo6XLYWauFn/wO34w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sw7kjvTOxo+iyIj/SPs24D143VKOhi6dlXZx/StkzNkzXj92+HS9SgvruSxX2r1OkKUW7u7sWRGaKU6aeA5a7GOUoXz5/Ytyb5IRltx1MBOlZDmTIQVI/wjVGXo028+zks8OZCdpkPZ9xqu33uIjXauQ0YL3y5CnrinbcF8PYrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZgU5fob2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K92fbUgB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZgU5fob2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K92fbUgB"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFtwnP3464240;
	Wed, 25 Mar 2026 17:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eSv/wiBWk31ROWx/hW1ahezgm3sytpN42WDG3y4M9KI=; b=
	ZgU5fob2rNPqgzb6AdWdEN5CVHVH5U0rNlcSw5ij3Inj6tzMdU6gD96ArgSk8W4b
	p4EndrEXSPPc0sUqqDukgE0R2tEYrPR+VHVd4XIRtfjOV4EUSfs01bSrk80Pvj5O
	0pf4YWQQYqQ+bsjM3RKnPiiKylB+FO4vXcEf82Riu1lTZxkMaNmzolhIUAwp3QDC
	wy1gBD1vQLeQwyworHyvefarJ9+2d8hGTmdbz8hQBOQGPVq2Yx8FJ8MiYMpP6T+M
	QgIQz7wvkQVCK6cVdREatmjNExpX2YunLuyahUZKFQc66XYZKMGndoh0NRVitG6p
	sPn9dLgrP2S2GVVrs2saZw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf6xsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:39:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62PHaVgt004844;
	Wed, 25 Mar 2026 17:39:47 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsbstk5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzNIJxEV4aKTLMPwkE+tn+wVa3liPZvNq/AmEODtWU3m/pVCZ20/m0Z9eQd7sNmijyoY7NtQzSO+3rc6wtW/R/r7ZsVlu46+Q+ZrQ76RZUerKhxGCqSp9KTTpPFAbwE52vxi0Aq/XCFzVccREh0BQhO5C0YeJsPotj4l1c3MhdhFyU/32VMTvLZurMoiSAY9UhKkOFPfBCTdT717JUg1eLOO3CLV3aEjgHCYfXgNHU98hE5sBs0nYJUUNR0kep3G/TSxT2vnbg+8wdhoYHItuG8R2eKej8x8WSDCwGQEk1LGM2MTRF0eHXjx7M840HrhavgtYnp6maOX23ksjuDEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSv/wiBWk31ROWx/hW1ahezgm3sytpN42WDG3y4M9KI=;
 b=RVNAO1xirpSRZmkQwqc+u3em2hIY6oEGMRonZwtpA+hX96DLYrbPILC435Tv98pJSDU7MhgXn/UDQyyP/h+aOs2WV3JjxPBZiTavy9EG48F/Oomyq5Q6RViMJHxyGmr6BQyjmpWtwCgyxrCYUgqH7WW5bS+rOKs1i+RMn7d4I8IdhBEO8bQIcKB7i1CN9YDcr63T65nskL6AWHuags7Ni9nwdo+299ToGUGMsIdkCN5w1VWMg2trZo8hwBKIds0usg4VlTs9TmBM5CFjWJbaW7ms7+o4EsCN++q98jwaU14TpIT8PzAV5/limRzVJ7vMRukoNsgkG/pFdLRglqYOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSv/wiBWk31ROWx/hW1ahezgm3sytpN42WDG3y4M9KI=;
 b=K92fbUgBaB84k/10tINIuIoFaq9GvSml95f4+YcCPv3QBbdCBzoU7JGkfjM6EEjkvyX6OyNPjSGVW338gUBKSkEOBG9TlOvIp+rZ9URubYKUK0j0h4zoc8wnLRx7PDn31VgC2Bj57SKPJHpKLg5X+bNlboroHdrteq8E17LaBR4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA4PR10MB8304.namprd10.prod.outlook.com (2603:10b6:208:566::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 17:39:41 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 17:39:41 +0000
Message-ID: <1cb3278e-90a0-48d3-91c6-4b7c552b96b0@oracle.com>
Date: Wed, 25 Mar 2026 17:39:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 bpf-next 6/9] libbpf: Support sanitization of BTF
 layout for older kernels
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, martin.lau@kernel.org,
        clm@meta.com
References: <20260324174450.1570809-7-alan.maguire@oracle.com>
 <ef3fe9d80d24f7498410bffe938da1882448e5b6012fcc3ca97fff5645018ba8@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ef3fe9d80d24f7498410bffe938da1882448e5b6012fcc3ca97fff5645018ba8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0003.eurprd08.prod.outlook.com (2603:10a6:8::16)
 To DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA4PR10MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d775ba-95a6-4d46-c422-08de8a957e6d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 U9GEp1qJC9PM0rMOOJRrUkhS9YV88Zg2KFsgHPmWam17sRIflez6+AzmCf7UsA+6Sa19DI1NiTvhjuROk1wWa0zCgOjQi0VdkTCLCpOjFuxxXmcQV0P0y0r5gjw9Jfo7TNvpFbylDhaAtCPs1J8T8WQLVYG5jcCHfLJ9dtroZoE8DjAE9v6gLPSyiufh3xPpiqld1abbd1U/nsS7y8gyUqpv0iceYikZn7lWA7wXS19AaZ5izsmZ/yw3vD1db4IsTS8/yb/4PxNLCzmmYO+K+jdS+TTt/xGORGCs59vcJPFCq/jJGbRDUuFrDkRx1EdI1KVHC7gx/4Hg9X7fIW8g3b8aL5giP6Cot3k5EI867RSTLE28gZWgMNldF6zBi8chmaqwvITZA7zoQikq06BzFTEqBqFfnVHm+Qpv1+hwfD6c3Nf4gKgfrxu5HXKIaQSxCRW5Gev1KP26+hR2zy0+vrNK9V9BhD0waXnQdxX2WfaD+u8PpE8onhyKlu0swLhzpK84xroH7BhFGJUN7cTNwPo8w5fMbvj5bdSHM/wCGCi8b365RGp50ldR4l/VWYE3FMisjNts95cvahUh/UoIvIWljWa7Ei7zFg8xbB7zdIntCVERHXBay754KVrrmcOPtlE2BpatdEQnAofGgywNML0qPEphko7z1pSFkYZJY6jySc3xpkndcOBz72NrDVdo
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RzN1VEJxaWNOSzVYeHo3L2N4K0VHN3g4S0M4dzR4R1MvblhURmlsUll4VjJ6?=
 =?utf-8?B?YndnaHdjcjQ1blVFeGNzeldzL2VEUlQ1dnNXck1Gc3dINHlwSFgrRDA4MTM2?=
 =?utf-8?B?a1BrSHh2NlhFdFQ2NHZOTHY4SFB3Q25oZUxGT2xpbW1OeGx4RGVmVmZYSlkw?=
 =?utf-8?B?WVhRRGRHWXhyZnAzS21zWGc0UDRhL28vQUQ3SHNNTTBVa3NYbmxTbHdvamZk?=
 =?utf-8?B?VFRMWXZEdjBkZ2YyQjQxRG1yNkZPTEFhMUtrZHM0ZmFuM0VZVERJT0kyTUVF?=
 =?utf-8?B?YnFIZ29UREdYZk1nQmp1R3hac05JMmg0SUZTVXpKN0dZTFlGVDhYUDZqWDM3?=
 =?utf-8?B?eWhySUxneGlSOUNtV0ttaStmdE1LZ3J0aXFQbURiVjY5QmIzQmNDUzE3Z1Vm?=
 =?utf-8?B?OFdaZVY3MFU0Z29LRGFPNHRQT2hYOUxKcUdNc3VpeCtmNnJsVkY0ald3N3h3?=
 =?utf-8?B?STVmK3luSzNXTkRObGNuS2JiekYzejZndEpGNE5mb2ZhTWNwRGMrL1R3YkF2?=
 =?utf-8?B?N3AxWEZxUVpES0gvM3gvekc4S2NwT1hQS2sxTHdqZWUxSklEelkva2ltbHoy?=
 =?utf-8?B?TWFLSTlGRmFHVnNDWmQ5TEQ5L1BPSjNxVkMrS2lZdmNZMkNpRUJpdFY5YWFm?=
 =?utf-8?B?a3BHSTl5L2tRbEI5QnZBNEt5WlBFY1lwd3hHMjgvNFJ0L3BOQmRwdmNSdWRu?=
 =?utf-8?B?QWozQ1BRTmtwM3JBNmkrN2FHZUM1WUxIRWdOUlA1ZHpiaWR2RG8rRnUwZlor?=
 =?utf-8?B?VFV3OEkxSjNaNmxJcGp6RGlDOFh6VnBBVUUySDlVSDgyZ3J1T1YzbHh2VHg2?=
 =?utf-8?B?dDJhcGpERmxVN2RuSmhzSWhvUVd2N1NsSnRHb0NzaDJYMTBtcXJBM1lJOE1B?=
 =?utf-8?B?YW5PdTFTTnljTkJCVTNoR1l6ajF1b3hZTm9aMFhQSjYrK1Fhc2QvOUxBVktQ?=
 =?utf-8?B?SWpydjhhb01Oa1A2MU9LY085WnV5M0ZyT3RmOHdSV1hIY0NmS1pwS1g5b2tt?=
 =?utf-8?B?WE9mTUlHSzJ2SGgwU2puUDZmOXN5b2JLa1p2bjJDd2FEVXFhb2lNYjlWcURn?=
 =?utf-8?B?UW1TRSs4WHRVOENQbXMxZnZJS2ZRcHpOMG9UVHJsNFF3SFRFK1JSY2JHVDBX?=
 =?utf-8?B?ejY3TE9KM3EzWjBTYmJXTytrT2xHL1pxMlNBUGFGZmY5aEpnSDVuZlhIeVBT?=
 =?utf-8?B?MFlJbEdHYXlSRDVMTjArWWM5ZDRPb3dGVVkyTEtSdm9DR2ZJakdCNWdnZk5z?=
 =?utf-8?B?cFd4aDE0V0dnN3dJZWMvVjJobE42UXNhd1FxN3g2bDFHdk5ZaUN4UmthZ1Vt?=
 =?utf-8?B?TUdDaFRwaFlNY2dIVFU2VW05QzF6K3FZblYwb3NRdktKb0xhM3hXRGZNQjhL?=
 =?utf-8?B?QlMwS1lrdHBkVnE0cnpjNXZMbEJuZU1ia3hOVk40MGlEUkQvalRFKzdnY1A2?=
 =?utf-8?B?eURzNVNvV1JIVnVuVUorbG9hdWM0aDRVaWgyMnFEN09LMEpaU3FWVEJGWm5T?=
 =?utf-8?B?d3dhZ1pTQUFERy9aSjB3K0JQTVdhUzZxbWY1OUo5bmc5cEJUM3ZSWDJhR1dI?=
 =?utf-8?B?N3pXWFVWcGNWRWhlVTZQdUNScUl0UmgvSnExUFE5ZXVYYThlbGxMSzU3Nkwr?=
 =?utf-8?B?ZzErcTU4b3U2c0NOdGVjKzEzczRiWjdLZmhOKy9YczBIWnFkckgyK1l3bis1?=
 =?utf-8?B?ZHBHVE9WRWZlSUhsOFJiSmtER2VDSk04aHdUb09XcUJrYUk0QkRLUTBnVUhk?=
 =?utf-8?B?S3Z1eGNjMC9Oc2w4bm5PZTFsQUpNb0VvS3lOeGFoNFhYOUo4cnN0eXdlVlJs?=
 =?utf-8?B?TmRDQmhsNkpmMHJUZmdkRzNOVnVkaytsYVRmZTVOU2wvbHRmSWdqeXpaejQ1?=
 =?utf-8?B?c1pnUXRpZUhDNE5jejUyRHh2b2ZOWUsyNGx3YlRUblRLeUhvTnJBWnhvZlFF?=
 =?utf-8?B?WmpQekJhY1dUNEduSjNzcjFXM1VsUEFKSVFOM2o3WEtJVWdzZkh0aFA4ZkNv?=
 =?utf-8?B?VUJqWWw0MGRFUlN1R2pIdkx5MVlpeGxuVUMwdk9XUTZ1VnpjeXhNTGgxWTdo?=
 =?utf-8?B?eFlUWHpwUlRBRStJOG5vZFUvU3RkZUh2cFFSbTF4Zkl2cWFHak03TXdxZXk4?=
 =?utf-8?B?TFJ4MFdIQXVKWDg4UnRobEtuQW4yQnpBekppNHNDeVkzVlM0U3BpUnEyblNI?=
 =?utf-8?B?WWkrNGZWV1EwRFFPSnlaRCtRNE1qNUUvam5YekVscUQ0VFg5cTVuWWluMVJa?=
 =?utf-8?B?RDRvUHc0RW5LM0ZkSU81aERnaXdkdnZPNWxid2ZvNGd5M0JNMTN6bjZPbTVx?=
 =?utf-8?B?SHFsK3Flc2dKM3FEMkpyak1KREpxd0U5NU9OWG5SMWFrWS9lK2FWQT09?=
X-Exchange-RoutingPolicyChecked:
	DcuiAT9Rm0j67CPWK5Rc9tiiyjmh16hDzBWYj+tT07jkLhBhwKeQOglINB6wk/O8OD76qtQsO921xfhHMT/1VAwwAjBepYbUpIEUliTIqR1XxrIyMR6TfFDvc2S5KUp0WorNFO0ldie/bdy482YST4pN/cWAuwU41n7Ifijq+f4+MiDbYyGFJtCNuWq6Yn4ZChOwwaHClUHOoI9mnX3MVS4E3BiKRDekL+igmgmbHlbn6ByGA5oMQrGgjSphDJOMIssaxpJoVjpHrpttY2Aeg/QEeK0NT9t1F63rIc41reakRU2nLzYcM8+YKBRirTlkLLjIQygIy0mCXVjc1Y7FVg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KGVQTEAcTlwog0neCG16QhS76pCC97AM17qVf1zMZIRmwshX0ZT7cUzgF6fiqyk8/sHsWLV9+J8D9Bj2TR84cvj7qlwZQ6MDuoIIpTxTFt/6P8LaVIQT0OsmqkNWWiEFgtGgE5ZpNekWo4zJs4Q91WDFgCutzr5a9BiUZS1q0zHlopySgkPKjvQdwyoI7uMejYGtU5hkaExTOTP45oalNM0Asabp1eTl3AmQYq+7nmAPHjgD+S8uwkIePmUmaHt3Wx+gcNuvdawSR3JFYO2FH8RpENV3m4G2FzKudN/1TXojYwavamGJcnuPxeTIFTvVrCrNrmPfsObUQR6yCDyUMlb+VO8rECR7yEg5ouVCW0cOUEaf+NYHgXV2YAyb1xSRP4oNxZFoY2s8ijbj1xH5Z0U2qdb/zXT+RE4MROXO+NMnhmDtUrBdRE1P12dMRtG2TOjaRGNNA/g85pSL7Tk0yQIdgFV9KYl9qnx06c7edCXOFTUe1fAh3gCz9i9x0JJtq7UlwdFRE+YojNCapKNdyN/Rxizk1hahbGsth0HyrppXRSe7U5/VquJ2sAnjdJ++JRSdmfjOEPr5TxpHw3XZ96Ep8PRiefkLklkHL/3+6qQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d775ba-95a6-4d46-c422-08de8a957e6d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 17:39:41.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMf+2mQ2T5yfA/e5fKCVyc2lD83VYz6kDUl4afmbr3PZN8BQC8rp+W5+lLwnr9WNQX71COPJ2B47gU6Sg9IK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603250127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyOCBTYWx0ZWRfX/qI6CyNXLWfQ
 5sQjnRdx+Da0fzXtTTvjSm6QEZPAbFRjL6u2fmUlZksrRrH0EeIgWj+0kKe6Xuvxf+2vm29Kv/N
 5qCBxSO/Qm0OcHWf5+xUQjK69kGPzcPkg4DIWUaEpU36BHp6Qibaum2H9FiAm8SA8OMKYkISkU/
 oL/MGYcj5qHNg8qK42uox1SzMzB7u15NE2/xg5F2rtI5QLIApRseuzmv9i3HkAuAwmqtIXY/fwU
 fcT3Lpb2fAa+U863qlpRiQFVXu2nUI5AQLsJGwi3eDBRgNuYcIsyT7VMhLLabWINOxuRDaG6wsv
 5PQ9aA5w6V+cxoVTPUu7+5uhJHkIbAiiTcfBKBlMPoP4CkKEdpomihHNBoNat544bu+P8XnhcKA
 W+bmIMQSXCVGKaItvOb0/qD4cMXS5s51zg1aHwD/EWYHMFi0w4/Be2av+2n61ZPGK5xPwBxk9Ov
 0xH4GuKvMEYmn4UAkpw==
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69c41de3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=c92rfblmAAAA:8
 a=yPCof4ZbAAAA:8 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=qY765iNadHMuxjdIrtcA:9 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: YtiNhRCuYu5txNwCwk1d4jzcsvSoEfY3
X-Proofpoint-GUID: YtiNhRCuYu5txNwCwk1d4jzcsvSoEfY3

On 24/03/2026 18:55, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 1eaa7527d4dab..e32b42ef9be84 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> +	/* btf_header() gives us endian-safe header info */
>> +	hdr = btf_header(orig_btf);
>> +
>> +	if (!has_layout && hdr->hdr_len >= sizeof(struct btf_header) &&
>> +	    (hdr->layout_len != 0 || hdr->layout_off != 0)) {
>> +		const struct btf_header *old_hdr = raw_data;
>> +		struct btf_header *new_hdr;
>> +		void *new_raw_data;
>> +		__u32 new_str_off;
>> +
>> +		/*
>> +		 * Need to rewrite BTF to exclude layout information and
>> +		 * move string section to immediately after types.
>> +		 */
>> +		new_raw_data = malloc(sz);
>> +		if (!new_raw_data)
>> +			return ERR_PTR(-ENOMEM);
>> +
>> +		memcpy(new_raw_data, raw_data, sz);
>> +		new_hdr = new_raw_data;
>> +		new_hdr->layout_off = 0;
>> +		new_hdr->layout_len = 0;
>> +		new_str_off = hdr->type_off + hdr->type_len;
>> +		/* Handle swapped endian case */
>> +		if (old_hdr->str_off != hdr->str_off)
>> +			new_hdr->str_off = bswap_32(new_str_off);
>> +		else
>> +			new_hdr->str_off = new_str_off;
>> +
>> +		memmove(new_raw_data + hdr->hdr_len + new_hdr->str_off,
>> +			new_raw_data + hdr->hdr_len + hdr->str_off,
>> +			hdr->str_len);
> 
> In the swapped-endian case, new_hdr->str_off holds the byte-swapped
> (file-endian) value after the bswap_32() above.  When that value is
> used here as a host memory offset for the memmove destination, it
> produces a nonsensical address.
> 
> For example, if new_str_off is 24 (0x00000018), then bswap_32 gives
> 0x18000000, which is ~400 MB past the buffer.  This would overflow
> the malloc'd new_raw_data buffer.
> 
> Should the memmove destination use new_str_off (the host-endian
> offset) instead of new_hdr->str_off?  Something like:
> 
>     memmove(new_raw_data + hdr->hdr_len + new_str_off,
>             new_raw_data + hdr->hdr_len + hdr->str_off,
>             hdr->str_len);
>

yep, this is a legit issue and the fix makes sense. sashiko.dev [1] also
pointed out it would be better to use hdr->magic for endian comparison. 
It also suggested doing endian swaps for layout info despite the only 
endian-impacted field being the unused flags, and given that this will avoid 
future issues if/when flags starts being used I think that makes sense too.

I'll wait a few days for additional feedback if any and roll v16..

[1] https://sashiko.dev/#/patchset/20260324174450.1570809-1-alan.maguire%40oracle.com
 
>> +		sz = hdr->hdr_len + hdr->type_off + hdr->type_len + hdr->str_len;
>> +		btf = btf__new(new_raw_data, sz);
>> +		free(new_raw_data);
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23504838405

