Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444622F8BD3;
	Thu, 19 Mar 2026 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946133; cv=fail; b=jjoSg0CzOe8Md3Y9FQpeV9Ghrc8Qvonj0Ce1wRb7thbcvKClS3fELHRqZukzr0j9fKlT2KtHuGQC0ADIuLuWUV6TyDMqsHFd/JfyT/MGYeACtk9ObCeAvF6f82UGLcAMdOYKCB7UVn3DhmS0EQpH43kq4z5Izf8nNfSLyWSEP/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946133; c=relaxed/simple;
	bh=sDiMdcYRpOdSYgAaoTW+gj69mEN0oljNyiauzwwL1gg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mNEKiuX5IDFdNseMG7pTLq2GuU12+nj7PqXV22C8L/xBzyUOMJu3MqpUIrCTPuTWuPu9Y10qI4B25OyC1+7Gu48ALwqyENp6J1D220iaWJi9F+Zy/GTfqTTAUTmF2nM8CXUoEl5pD1IQ0OnwwA3HSNvmxaeJ2baqzj8FC4tHSpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V7DsKDeQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=somIbsWf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V7DsKDeQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="somIbsWf"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JHUGZO2707460;
	Thu, 19 Mar 2026 18:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/V3ZSYJXwCidiIBZPO9naz+6/G7dhH/UkbtTqDZsO0E=; b=
	V7DsKDeQN2DHzg5kgyS3uWKIGUR5XHCKed2EYKAfVMefr5maY9lvlDTNXgo4Fgdh
	lrZKOrdWHGyejwKVhqLnMI2zwF4LP0X82/jbWCtCvHe65zPOlCBoOJr3M3GnFavM
	DALIyimtd5vHDLIUEoOP7q3FCzY9zHJmaLi45zubCx46We5Olq7CAMU45j3hQYVB
	NxeZDYbUAmMZgfcJHayXqcMbxsyy+Ro7CuP7ijgdD8I1BjqqQdc7vfEi8+mm1uLw
	MWg5DDhCodqhYRhLxYRSGBjYp/3mLuFs4ribrQlvdy+djvpJS5JhSVJ1L2wzz6uZ
	QcWBhLOInFay0bnAwgZe4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf48d5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:48:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JHNKNJ003617;
	Thu, 19 Mar 2026 18:48:44 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4d9sx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie6G0YnqtPfOZeulFe2aoJJAuOgRYhN8Fbasg0uiOwdZ4sLj9DrwpU+JAx1jshivuyjyRYvMYCHk6v3iMdNEjCBWMGB0Nxsqv9Y+wzLkeXK3HsVKuXNt8DByb+qTUlwH5FxCfYV+M7y1LBLap/Mxq/cKa9CsiPQc2JyUBkS0B4Tm2NMYlFcsXDR2vxzvyxnW/WwGW9bx156/sG1/+pZVCeEqt1gk9dBqAtYwqiYhQ6TowQdASRjJ/bD1vdgAOH/GjW0D487djWjLJAifw096OIIDKvPFciKK8cqo7nHEIbJWeykI5mu6sQzpAjTXEVHQXbABEsrpAFanldR/qXA/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V3ZSYJXwCidiIBZPO9naz+6/G7dhH/UkbtTqDZsO0E=;
 b=KZhGXPzT7gcrbw/SXBopuFL3vCt9rpPSqF8pyzfylln9ruKvNqvgiej6XidIVbZeyfYmquQoBIa3Wb+Q/Mpeg645wh7vISwJinGqlPD8SO2mYK+hjUfxn4r9+tUwzkxNuSaNe8DWfoHOXZdsLLNkhzkxOFFUHGeGOjwKdQLl4wpwo46+hIrvmL5INHBpVbOqhV5QFV3zBRMzkSp8VNIACgTbhMdkeHEEYP4ceVJty9UBhR/3ZvYqcTxWtG2NtjxMnU0iG1H4fDZIkRyIX+aNo0kuRWh/oWKLY+at8qfkYc+RxQ0NnUfHJFPBaoQkLKiC+0egYEhNqJCaLr8Ir7Yl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V3ZSYJXwCidiIBZPO9naz+6/G7dhH/UkbtTqDZsO0E=;
 b=somIbsWfeKJ5IIrEWq8lvJbgrPIdeH2d5bh67mL0H52m7HWOwRtYfw7NnaE3WGpfJduT+hHlXTKZQ+2Jo4K+G7AqtWemRhy0xqPCMg/nuRpB5UbbS/GmBp2cyq+E8PjCdKMIdvCRBqbv+6X0UwST6P2mkxuQQV0peX9jNDPSDeY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB5092.namprd10.prod.outlook.com (2603:10b6:208:326::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Thu, 19 Mar
 2026 18:48:41 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 18:48:40 +0000
Message-ID: <e2096d0a-5c78-496e-a269-1daf2a3784b5@oracle.com>
Date: Thu, 19 Mar 2026 18:48:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 9/9] tests: Add a few clang true signature tests
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260305225455.1151066-1-yonghong.song@linux.dev>
 <20260305225542.1158464-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260305225542.1158464-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0404.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: ed71af0b-3b1e-4175-465d-08de85e8233a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x8xzU//KVw3D5W7/wq1GrMTH2L+YvUmqzDAUcebEYCJ4+Qed4Yrda2n0oAsMC9SMxwZSo70PMb7W1J2QbWOzUvgaNBATUr7/DFa15J320E4GnpMuMLwYK31eff5hLhND8RBpt/2h5eV4MDSL9HHU0aWnt92029o1TApNWe9Sz9n4EBGdg5Hl1sZ4v37qzs8IBQqpgX3WkQoN8jsDoYLNIL6WQoHcnE0n5aJPGb9Yla1C+0noO6Lgp2BtqdB6EPr8Q7mnnmPwCQ3lUQ/uRlSOOpsRwzlNmJypBW1bHgeMXBYIFJ8eLTpL0D1Rm41momfYwF0ep7XQH7q7QcJgxWWCpgLDeflmsBH+gurgEjo50f3dX9jWYR8omTPZ4RYYn8HnAx/2MKgIjlVcbs08KnLAfFUAlE1cl2W2X3OQav1ZOfbipy+LQ9WeqiMraa2h1IQzfxfeoEJZilon9NCHdtLJEa9k0y55YS39Iw9Z82ki/8yTh2zcEroMWK1XntUOx9p5zrQc05+h4MQQzhiqrR/ywAdGuCL/2cZgIQfjI78ntPsfDVNILfUnfx8nGkz9B414Tk3FWlD8nwYoFF0p+6dLPfYJtaA/QRM0/BzHmUDR7nczT54KOQZmWi1Z9/rW5c4TjRkzYHNc/fTajCJaftj10nNheCTgYwnTywuTAsE9UeO8x//wRXX4RxUwe05Edaxv1Bw1GNtiDSE4yAuXYSEiKjr58wT3sd8tKamVrs3cp7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFUxeXZ3SUNqK1JsZnJaSG80NkUvVWZaKzk5YWZrMzRaaHRERS9RSDdKVFRN?=
 =?utf-8?B?UjErMGc3azEwSmkyTzZRc2Y1MlA1dkdtWEU0d0hwNlhrVjF0ZzEwVEt0a2RE?=
 =?utf-8?B?c1hRQnZIVTlkaVpxTVpndWhLNlVHQ2h1SGlqcVoxdTVYWWdaN1VjZWptcjZ5?=
 =?utf-8?B?dDZRRStVVzFDK3VYeFhUVVRlei92cml3WDNOZEwxTUZXbWpIRkovY0pidVFl?=
 =?utf-8?B?dERMc1hpR1RjS29Zakxad0JKNWZPWjJKVmJzcVpLU2ZuejliNkNPMXN1VnNU?=
 =?utf-8?B?Z25UQXg3YUV3SWk3VDRSdG5lVm1mTk9zUUI1UElYQURvdmdrNnMyYWtyN1Q5?=
 =?utf-8?B?RHA1V00yTXFaSkNFaU9kUkN2OUFvYVdaaWpPTkszMHZHRlhsYWx2SUdLYVE2?=
 =?utf-8?B?TlBndGxkelNkNkNDTHpIYURYSDAyZlRKOTZkRFJjN2x2M0hyVnBjZExWUHgw?=
 =?utf-8?B?QUZ3UE1WV0xTclJ5Y0F0TXFRbmlOVWNIMG8zelRmTlhvYnp2SVJITkwxM1Bt?=
 =?utf-8?B?UWs4Y1lJVlQ4cTFHcHJuNmx6MElTZm9UVUpWNG4vaXltSXdleGxrYm84MWth?=
 =?utf-8?B?K0VxMXNqYkxid2JITHp3a0krd2liaUZTejlGVlEyUFU3WUl0cXVJRENoUVJq?=
 =?utf-8?B?UW9pZ1RhODVVeWFBUytwb1BQWUswYUZHMzA0UkgraDViNDBpcVV2VDIvcks2?=
 =?utf-8?B?Uk1yVkRwYlJlQWpwVFFQTiticXVjY3BScmhaUm1COVhTRU9QaG5DRjdUWW5n?=
 =?utf-8?B?cVlRdzZIbGhNSmlSdm13UFRwT3JtUUJNUjRJYWg1bHl5UXRyK0VwQ1haNEFF?=
 =?utf-8?B?a21WWnlaOEJ2elBNWDRMdHRNMFRla0FSaFgxMlZySW84RnZyVEg4a0Jlaksz?=
 =?utf-8?B?cUQrcm5lL0IrbVN0dFMzaGVsRGlPZGdjbWRpVFFVc2lXYTc2WWlGSUhaMlBx?=
 =?utf-8?B?Q1ZIWW1rNnVydkVTQ3dubFZHR2lZR2FsOWtkbHZXdEsyaFRmS0gxemkrMk0v?=
 =?utf-8?B?USs1RzhHYXZ1NTdIczRqSGEyZGNHN3ZxcnF2VlJFRjlXU05BL3VSU2RQbFJM?=
 =?utf-8?B?ejg1bkJXK3JoT25IWUdWY2dncVJvTXZyTnpySnBEUEkvMlRlVXdnUDdEeVU5?=
 =?utf-8?B?WkF1WnhjWEhlZ2p3d09DYjFVODNqSUNWaGIvalNzc1N1blZTbEhCQm8rdzRX?=
 =?utf-8?B?c3FFMFA2SFduVkttd2xVZFRvYnBNYlFaT3cxYlhxOFk4YkZTcjBKWGlVdFFp?=
 =?utf-8?B?N3NxVVBjcE1FNzBlUStxbXhDRFY0VzdQKzZ2U3Q3OWFwMnV4SzRHSVRGT3Rk?=
 =?utf-8?B?UWxwd0paS2s4OWozZ0UrcXJTVy84MkRGYlNpTzA3bVhocGMyV0JMYVBjRVl2?=
 =?utf-8?B?N3A0anphNTB0L1JqQlhaOTVqZDlaVkVWclYxMGVmMWVteiszUSsreFpGUWdL?=
 =?utf-8?B?U3BodUhPQ3VBWnJSNUV6OTlINm1xZ29nQzNmV3kvTnpsMi9HdkdBNXJMa3lU?=
 =?utf-8?B?VXNjVVVPdkNVek95ZnZxNW9vd292RUpGMzBqS3Z2UFc1c0l3ZlUyRk1DUXIv?=
 =?utf-8?B?WnZ5NWRYTSsrdGh0SmR0blp6VmwySGFjcU5obmQwSC9ueWNwZzhzRWdxdmVj?=
 =?utf-8?B?RHYvVXlwTm40Nnc2REVhZ09KQ1BESDZPTENrZzFLYXYzeUh5eGtBUWFyY3dq?=
 =?utf-8?B?cDFhMk5HczVjMDJRWFhxcUtOQWIxOHhKMEdERFdVRzRYb2JQcXorS3FtU3c5?=
 =?utf-8?B?c1BHSUZGNkJSTXNtVlJBYThpN1l3aW1qeGZ5WUdOSnVHcmhJTWJhVytWM1g5?=
 =?utf-8?B?ZS9YeUJJSlU0bUM0VkFiWGQ5RWNEK0ViYW94WTViMjBCMWJLUlZSQ0p3Ulpl?=
 =?utf-8?B?Y1JTdC80WXdXNndqQzR6czNvSXh4ZWNVelRTUG44SzRrNWRTMktkNkgwZ1BH?=
 =?utf-8?B?Q2FlY0VvTlRvU1NhNFJ1eTgyUWdGL2lGTHZON0tqQmRnSldRbDlkYjhBaXdl?=
 =?utf-8?B?L2NQeTV0cmtpR0FTaDhkakR2THd3d1ZNc0hqQTdKanlhSnYwdWhaemtyU1Br?=
 =?utf-8?B?K3hBenRVdTJGTVduVEpiWTE5R0NuWW96Vmp4aGh2Wm5LMmVNSi9FN0tFK2Z1?=
 =?utf-8?B?d3RGZm1DVjBib1h1MmRQeUJjUENyMGFLK3Z5VnFOR1NkS0hPbzBHV2QzYTRX?=
 =?utf-8?B?TDRlYSsvRXhOQjBTcmNWRUNXN05CeGNYZE44c2ZSVytuVFZGSFhVMDIvU2pq?=
 =?utf-8?B?NHFOd25QSEU3MEFSZGpzOEI0SVNOVXF4OWRJYXYwTHluWENTbmE2RXphTXM4?=
 =?utf-8?B?RFg3RTZHaTJWeHZ2UmV1TkhVeklWZld1dHhLNWtKQXF5c3lzR055T2JKLytL?=
 =?utf-8?Q?ujyCy6EPx+ybneEc=3D?=
X-Exchange-RoutingPolicyChecked:
	DiSyhvvrB2M5NjM/OVsnw6Xa7SRWfjFJmRaSplDI1+qBHRfY/EW50eLv+3AT8hz5+kcylyJ4z5sVeHeJVFDDcZMtRFvGZm1anrz0xleSfsBlelHfy8etwtRNT2mO27svSdh6juB9M+pQZl422oQ+1ALjeUsoN3FUzkKN+XOwFfhOWoa2hmr6Bv9ZOYLsr8p2jzFKcKUWyrPrI6rD1CRKm1QbqdrUoCMtK8wpRskIocvvsMPkaKA3OqfMxHYDrqgWzW0Z5OLwJcKEtJJ/i8uCwto8+nkPpm3A2ohnPx8kdnbqBH1xv06nzVw2XMazhmbqDeBlmIxaVYFoFSG2/DxobA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gnLhtp6uxN3BX9c7PSh8KcDm6EEwaZIwHQ0q0TiBMb7OZdrQotYNejnj5H8x1apeK2Dg+bKrKE+S/9AOHTLaYFeSyqLAFQGTwiUba8JrU5Vv6gBvpKnCaNLvRl3goncohoCe1MYNIrre7UYY6JKjBex+BwiPnFmj6QewqPa68o3ocvoZID4hPqU2jiqz1NgmjligPCyF3WAn4pLyaP/WLHxCoDxWHkJQlalOF6kpBMcS7tVCa0SMggAsgn0hveIKoEOG1AXqRWsQSwHgmAarmPNvy3eaai2dage9XFhM3UDDh6BsWGszKL5ziqXduBG4nWLE60QIr3WZToy3eIq2uTVcvIOqSqeGVv20Q6FthEqT7iJnlDANYa5UokGKAvV73+DVRJM3i21es/0c9hIESu39wADvE0un1yscA6NSEP6M5HtoQuhN+Y0p+Dn13kyvAb4SYj+YE0EdUENsArjr0pIqEIkz9NbRwKBz039kJ4d75j6f84nFXVPuSm3G1fP6iqaSJLNmi+ql6SZxtE8tYAHAM5zQg0aHgXu8USQAO55gCFr7bZOqiKxjGb/FReMyljiYBjE7iocCBEI7OBYOcXBleNnCQywKAs5BaLVG+c4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed71af0b-3b1e-4175-465d-08de85e8233a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:48:40.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqT1y4VT55whAiqU8mar6gt9EDZCH74950c/KajLTzEjllJysqtjhJ2iq29A3Y1zYlOge9w11W0yZMb5UlAocw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190150
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69bc450d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=cYklClEZ4PKKequIaEMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ph9NuYwLUkljZ6nXtCR0CiCN5BCyOWPZ
X-Proofpoint-ORIG-GUID: Ph9NuYwLUkljZ6nXtCR0CiCN5BCyOWPZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MCBTYWx0ZWRfX4QvHwulDXB/9
 EIK0RQAb1vcE4UbCyGeboYEJ7vHv4FAL5Hj638zn1IOxKqP+Hfp0DJhTxGYf379ctpy19POeFIu
 V2Solot5mLjgr+54uIDIq5OGtEOUFApEIe2ltgIHz/SELprflFphH4PSnV2a7wZPZd/5NvQCDdj
 jHTa6q9qrt0+fjWIvY+BVRFFCSo4tc+nMQrT30tbBSa1+x1G1jVS2T22lGd0qVnxPHt9HcSYNuz
 DtlYSzimf+xAMpd6FDah3LcZvEt8BT8CUF5t7XAvnvoUPE1AUbYzUba7WqnXpEbEOVrAPkUi+qn
 kO52RS1e/hksj+ipE65GfP9y1orl2SlkCXAUPzFBQfplCr2nciuBsP2NzX0hZmll2tNJs9GK77J
 kfmviAsl+QjITZ2r1V5xzSqW4jnWpilhQ3PZcdvJd26z/jb5t6UZf5Z3spqAFtEoU7ESL5zoddo
 cEcAV9wavaf3lVEvNQw==

On 05/03/2026 22:55, Yonghong Song wrote:
> Three tests are added.
> 
> Test 1: clang_parm_optimized.sh
>   BTF:   char * foo(struct t * a, struct t * d);
>   DWARF: char * foo(struct t * a, int b, struct t * d);
> where parameber 'b' is unused.
> 
> Test 2: clang_parm_optimized_stack.sh
>   BTF:   char * foo(struct t * a, struct t * d);
>   DWARF: char * foo(struct t * a, int b1, int b2, int b3, int b4, int b5, int b6, struct t * d);
> where parameters 'b1' to 'b6' are unused.
> 
> Test 3: clang_parm_aggregate.sh
>   BTF:   long foo(long a__f1, struct t b, int i);
>   DWARF: long foo(struct t a, struct t b, int i);
> where the 'struct t' definition is 'struct t { long f1; long f2; };', and
> a.f2 is not used in the function.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

tests look good but we need to ensure they are run by the ./tests script
so that they will be run in CI. also take a look at Bruce's work to
add common test functions [1], will probably simplify aspects of the tests.

Thanks!

Alan

[1] https://lore.kernel.org/dwarves/20260309205643.1985134-2-bruce.mcculloch@oracle.com/

> ---
>  tests/true_signatures/clang_parm_aggregate.sh | 83 ++++++++++++++++
>  tests/true_signatures/clang_parm_optimized.sh | 95 +++++++++++++++++++
>  .../clang_parm_optimized_stack.sh             | 95 +++++++++++++++++++
>  .../gcc_true_signatures.sh                    |  0
>  4 files changed, 273 insertions(+)
>  create mode 100755 tests/true_signatures/clang_parm_aggregate.sh
>  create mode 100755 tests/true_signatures/clang_parm_optimized.sh
>  create mode 100755 tests/true_signatures/clang_parm_optimized_stack.sh
>  rename tests/{ => true_signatures}/gcc_true_signatures.sh (100%)
> 
> diff --git a/tests/true_signatures/clang_parm_aggregate.sh b/tests/true_signatures/clang_parm_aggregate.sh
> new file mode 100755
> index 0000000..6d92701
> --- /dev/null
> +++ b/tests/true_signatures/clang_parm_aggregate.sh
> @@ -0,0 +1,83 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +outdir=
> +
> +fail()
> +{
> +	# Do not remove test dir; might be useful for analysis
> +	trap - EXIT
> +	if [[ -d "$outdir" ]]; then
> +		echo "Test data is in $outdir"
> +	fi
> +	exit 1
> +}
> +
> +cleanup()
> +{
> +	rm ${outdir}/*
> +	rmdir $outdir
> +}
> +
> +outdir=$(mktemp -d /tmp/clang_true.sh.XXXXXX)
> +
> +trap cleanup EXIT
> +
> +echo -n "Validation of BTF encoding of true_signatures: "
> +
> +clang_true="${outdir}/clang_true"
> +CC=$(which clang 2>/dev/null)
> +
> +if [[ -z "$CC" ]]; then
> +	echo "skip: clang not available"
> +	exit 2
> +fi
> +
> +cat > ${clang_true}.c << EOF
> +struct t { long f1; long f2; };
> +__attribute__((noinline)) static long foo(struct t a, struct t b, int i)
> +{
> +        return a.f1 + b.f1 + b.f2 + i;
> +}
> +
> +struct t p1, p2;
> +int i;
> +int main()
> +{
> +        return (int)foo(p1, p2, i);
> +}
> +EOF
> +
> +CFLAGS="$CFLAGS -g -O2"
> +${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
> +if [[ $? -ne 0 ]]; then
> +	echo "Could not compile ${clang_true}.c" >& 2
> +	exit 1
> +fi
> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
> +if [[ $? -ne 0 ]]; then
> +	echo "Could not encode BTF for $clang_true"
> +	exit 1
> +fi
> +
> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
> +if [[ -z "$btf_optimized" ]]; then
> +	echo "skip: no optimizations applied."
> +	exit 2
> +fi
> +
> +btf_cmp=$btf_optimized
> +dwarf=$(pfunct --all $clang_true |grep "foo")
> +
> +test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
> +
> +if [[ "$btf_cmp" == "$dwarf" ]]; then
> +	echo "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
> +	exit 1
> +else
> +        echo ""
> +        echo "  BTF:   $btf_optimized"
> +        echo "  DWARF: $dwarf"
> +fi
> +echo "Ok"
> +exit 0
> diff --git a/tests/true_signatures/clang_parm_optimized.sh b/tests/true_signatures/clang_parm_optimized.sh
> new file mode 100755
> index 0000000..3022e2b
> --- /dev/null
> +++ b/tests/true_signatures/clang_parm_optimized.sh
> @@ -0,0 +1,95 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +outdir=
> +
> +fail()
> +{
> +	# Do not remove test dir; might be useful for analysis
> +	trap - EXIT
> +	if [[ -d "$outdir" ]]; then
> +		echo "Test data is in $outdir"
> +	fi
> +	exit 1
> +}
> +
> +cleanup()
> +{
> +	rm ${outdir}/*
> +	rmdir $outdir
> +}
> +
> +outdir=$(mktemp -d /tmp/clang_true.sh.XXXXXX)
> +
> +trap cleanup EXIT
> +
> +echo -n "Validation of BTF encoding of true_signatures: "
> +
> +clang_true="${outdir}/clang_true"
> +CC=$(which clang 2>/dev/null)
> +
> +if [[ -z "$CC" ]]; then
> +	echo "skip: clang not available"
> +	exit 2
> +fi
> +
> +cat > ${clang_true}.c << EOF
> +struct t { int a; };
> +__attribute__((noinline)) char *tar(struct t *a, struct t *d)
> +{
> +	if (a->a == d->a)
> +		return (char *)10;
> +	else
> +		return (char *)0;
> +}
> +
> +__attribute__((noinline)) static char * foo(struct t *a, int b, struct t *d)
> +{
> +	return tar(a, d);
> +}
> +
> +__attribute__((noinline)) char *bar(struct t *a, struct t *d)
> +{
> +	return foo(a, 1, d);
> +}
> +
> +struct t p1, p2;
> +int main()
> +{
> +	return !!bar(&p1, &p2);
> +}
> +EOF
> +
> +CFLAGS="$CFLAGS -g -O2"
> +${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
> +if [[ $? -ne 0 ]]; then
> +	echo "Could not compile ${clang_true}.c" >& 2
> +	exit 1
> +fi
> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
> +if [[ $? -ne 0 ]]; then
> +	echo "Could not encode BTF for $clang_true"
> +	exit 1
> +fi
> +
> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
> +if [[ -z "$btf_optimized" ]]; then
> +	echo "skip: no optimizations applied."
> +	exit 2
> +fi
> +
> +btf_cmp=$btf_optimized
> +dwarf=$(pfunct --all $clang_true |grep "foo")
> +
> +test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
> +
> +if [[ "$btf_cmp" == "$dwarf" ]]; then
> +	echo "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
> +	exit 1
> +else
> +        echo ""
> +        echo "  BTF:   $btf_optimized"
> +        echo "  DWARF: $dwarf"
> +fi
> +echo "Ok"
> +exit 0
> diff --git a/tests/true_signatures/clang_parm_optimized_stack.sh b/tests/true_signatures/clang_parm_optimized_stack.sh
> new file mode 100755
> index 0000000..1abb96d
> --- /dev/null
> +++ b/tests/true_signatures/clang_parm_optimized_stack.sh
> @@ -0,0 +1,95 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +outdir=
> +
> +fail()
> +{
> +	# Do not remove test dir; might be useful for analysis
> +	trap - EXIT
> +	if [[ -d "$outdir" ]]; then
> +		echo "Test data is in $outdir"
> +	fi
> +	exit 1
> +}
> +
> +cleanup()
> +{
> +	rm ${outdir}/*
> +	rmdir $outdir
> +}
> +
> +outdir=$(mktemp -d /tmp/clang_true.sh.XXXXXX)
> +
> +trap cleanup EXIT
> +
> +echo -n "Validation of BTF encoding of true_signatures: "
> +
> +clang_true="${outdir}/clang_true"
> +CC=$(which clang 2>/dev/null)
> +
> +if [[ -z "$CC" ]]; then
> +	echo "skip: clang not available"
> +	exit 2
> +fi
> +
> +cat > ${clang_true}.c << EOF
> +struct t { int a; };
> +__attribute__((noinline)) char *tar(struct t *a, struct t *d)
> +{
> +        if (a->a == d->a)
> +                return (char *)10;
> +        else
> +                return (char *)0;
> +}
> +
> +__attribute__((noinline)) static char * foo(struct t *a, int b1, int b2, int b3, int b4, int b5, int b6, struct t *d)
> +{
> +        return tar(a, d);
> +}
> +
> +__attribute__((noinline)) char *bar(struct t *a, struct t *d)
> +{
> +        return foo(a, 1, 2, 3, 4, 5, 6, d);
> +}
> +
> +struct t p1, p2;
> +int main()
> +{
> +        return !!bar(&p1, &p2);
> +}
> +EOF
> +
> +CFLAGS="$CFLAGS -g -O2"
> +${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
> +if [[ $? -ne 0 ]]; then
> +	echo "Could not compile ${clang_true}.c" >& 2
> +	exit 1
> +fi
> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
> +if [[ $? -ne 0 ]]; then
> +	echo "Could not encode BTF for $clang_true"
> +	exit 1
> +fi
> +
> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
> +if [[ -z "$btf_optimized" ]]; then
> +	echo "skip: no optimizations applied."
> +	exit 2
> +fi
> +
> +btf_cmp=$btf_optimized
> +dwarf=$(pfunct --all $clang_true |grep "foo")
> +
> +test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
> +
> +if [[ "$btf_cmp" == "$dwarf" ]]; then
> +	echo "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
> +	exit 1
> +else
> +        echo ""
> +        echo "  BTF:   $btf_optimized"
> +        echo "  DWARF: $dwarf"
> +fi
> +echo "Ok"
> +exit 0
> diff --git a/tests/gcc_true_signatures.sh b/tests/true_signatures/gcc_true_signatures.sh
> similarity index 100%
> rename from tests/gcc_true_signatures.sh
> rename to tests/true_signatures/gcc_true_signatures.sh

