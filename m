Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634D154BE2;
	Thu, 26 Feb 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117272; cv=fail; b=GlPlH1ZTEIozKWz3vMF2PN4vHwdWN6JzDSqpiS/NN2CxCjH/C0zCb6RBfMk6bILAMOJ3PldN93DajkIUNaL4GVMu7w7tH4dUFd3fxdF8CtPhXQ3yVdofyILLWWmI7jzpEgzWSnPmAZqcX/NqhzF3HSsdOMMW2KmHIJVwRYCSqfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117272; c=relaxed/simple;
	bh=L0LJL9k1to9ob30+kBO7fpZCW0mNAUTPC/ucyj+BGuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WFOpkqAhUvPf3Zfb4oq8bK3mG6LbOlyU/k74nGMP3hUFfJFV7bkaHjSvMrkHNweUBkWufV7aXnJlxS3ZBK5EZYjUM9f8gxKQMmsZDTowZiBrm8jxXXjHAS4TZTC2Z83K3jRDbTI/mkA8YkttG0g3TIT5XSzDd66Vf7oHrvWR39w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y19qKJQ3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G++Oh3V0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y19qKJQ3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G++Oh3V0"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNGiD193486;
	Thu, 26 Feb 2026 14:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bS7gDw1r/FVrxPYCN2G2gJRGKODU3uSmMS3dSahR064=; b=
	Y19qKJQ3CG9jp31QmrDf4/2uM+R93Y0MAqQMrh2cd5dMnxUzIZO7d/TeXx5ojfu3
	JjQ90sPnmjDUonu4+4/gfNiAd8np8DpV4MAf/Lys5bSLcAtPlvjY+abtT3s1IRL5
	jMxLCNGR8D13vYdKk5JnN10R2Q4XwLcuXjRL/V+xbyI/70fnrLD+luUOzIT98vbL
	ZyRkY6YxpLT7kh1mCYm4rcGgBw8B/FXsTW0qBp6RYNnm5Hs1+jJNQJRPcj9ln/Im
	s1fOfYW1ebd0CF5/17Mbkj7gqJJ0vHbW/VtdyYd9JzQH2YS+kDtrqDHcHHK8TR+T
	P6Y/Z1su2Y0T6pihG8CSOQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgg3rp8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 14:47:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QEBUNN006264;
	Thu, 26 Feb 2026 14:47:12 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35ctq0n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 14:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu/GcK+yzZMDNCPNhjmXO64eUePmjt6K+3OqMxxeq9CIyToS2qmlUnHXrx80Wym97X4YV4m8voZoa4M4piQtJaaOt/3Hr2CrUxwWpVGP4uk9lE6V2KSdzN7ATC30WcaTPW0fx1AnxYq1GwVlE5g9clKQjY51KbqL9xbWHaFGfha2+6gXjHKgmQX91yi3Ncx2JaGvCFumdO11bxu7yaW7D9uRGEAEIy88kbledwPjF+brBekEnK1LgXJtwRHbQ2scr3am8r6dixfyISeu6eqXx8jMYEymm3BI4lTJVzpjFG8klFRCZvLT9FUI8hZoqimbUOu0RPz6UDBgaDqaVMFYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS7gDw1r/FVrxPYCN2G2gJRGKODU3uSmMS3dSahR064=;
 b=mzNCbDChMakWAR5vfpzoHQSvxHs1zh7j1/U8HqtZtjo9kthfcYZAZUSJ4wdWjT6ALEfKmzUESP8CWLF+USZm2RMSh/+8GxNwXm2YK+AbTUNUStOThzNPmslwTrbEXSecOsj++RVe/fd5ODgfbXHllaRWqI0QH5buyVVoBnO21JWvy365A9qDH7ScYl7Zhd8XOAFS/XulQ9+9tSFwNdG2UeXNgM8fVWvpZnjfz16h0V7iUbFoa3LXBjEDv+uy/dzsNO/BsmCHB3EoOgoA64WlpwB0tM/Ig9EbjAX6PrIFgtmfCMtH5Wefj0LrAWdQd8gqXFofip3gAgU6oLJCHVjMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS7gDw1r/FVrxPYCN2G2gJRGKODU3uSmMS3dSahR064=;
 b=G++Oh3V0i6pqjtR26CRLZgOzjen5ZNtexI84pHawXcNPwfDW524684J0Lel8s2yN++a0zM9YdTsYkQAVl9/nA1sLxEn92EhZPV5zshh4EOR1ftMKIf5EQwEQd03erCFhF2T22VEG6YCJIw6FGqBbzYaxJ1moARhzBogrOmdqa8Q=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS0PR10MB6270.namprd10.prod.outlook.com (2603:10b6:8:d2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Thu, 26 Feb 2026 14:47:06 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 14:47:06 +0000
Message-ID: <f05c3ca7-3e84-40a5-82d5-d09301865090@oracle.com>
Date: Thu, 26 Feb 2026 14:46:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 bpf-next 04/10] libbpf: Add layout encoding support
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260226085624.1909682-5-alan.maguire@oracle.com>
 <6c47d067a977a179a9c4e888efc97ba8521749688c591e1da34a2b33d1abf343@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <6c47d067a977a179a9c4e888efc97ba8521749688c591e1da34a2b33d1abf343@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0271.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::27) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS0PR10MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdbd030-6382-425d-f9ae-08de7545e947
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 XnSvtaxJ6scVj3iB2ObVNM2WA33tDzLo1GcQL69Ory+x/tV752VLLclXr8rQD5tWF/j7PwFm1q3aX/y1vltAW0/GNx7LGxzw0b6duJT1UmieybgjoYta9IHma0kNsHt0WTDxgPvRWdybzBx5+hVQsdBlDVvR2td9E1bxeZtqIMO5hDe076ig8lmihHfjO/FXtko+y+jmS5EUDqEUReIu0vomx8femX6j7zIJPT6iu7Y7fibyjkIrlhKwrxBjsOuvP7iWJsy2D7Q6mT2OemH5U+LStvd7FQEfmQZ3VjO0O/m3rOYvwNin6vwLMuhB7d2Cix8n+EC/Tfhc9MkMswEGkbUPFa48ioxZo72G9xVoVLY+TD+1imPRIMufS7Mg2pyqF4bCgAyl4OIyUaYfajKXFsvNlf1D1YhMCWpYHho0dfjdd+j6SyMmqNkgxn9kIuuNxEJIHtVLptOw/PZDu47EMKj78y8BgNWqu7uh68TfxdoAuUUhatArItAA8mgmcfWzOxpaGuaULi85zz1VsG/f6nx7RJlNNw2hHSdl5b/62jbFxwryOS5ACgA/GPJpyXubDx7nPz5OeHRHdBgIJyVYLRdwRIMM9mkE3FETqXADgdkGWzQc9XYpvc9vi5f3KbprkxCb3wUZgu00wLJDU5+cQ+aK3kpjmqRBM0d9m+r2DUXmwMx1vfvscQkDf8nfXoSe
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YklTOFVJV2NsV2dCcjJha3pOVSs1bnlHeHIwdHRYZ28rNFkxQnN1dHJiVkhN?=
 =?utf-8?B?Z0J3WXo4RmZDL0lkSzV4TjBTaVp4a2xTMGVzVmpUVDU3ZXI1eWJ4TW4rbXhN?=
 =?utf-8?B?K2diVm5XYmFEUkE5Q3dHb2t1S1FVZ05UZ3RINFlES1hyeWZuK0NjOGI2aU5i?=
 =?utf-8?B?eG13OU1PWHY0ckVqSm9YTmxlZEM1bWhRbzhodFUxWXIrRDNnZUxRNmVVWHRl?=
 =?utf-8?B?T1JlanoyTnV5MGVoVkdkSi8xd3dhcnllaktSZHAwSTcySFBLeFhTNGFGZUNC?=
 =?utf-8?B?c0Qya0pwRDBRUFMvRDV3cFpld0N6Mlp0YW9ndWdpRHE1akE0eEt0T3dueis1?=
 =?utf-8?B?U0dkYUtHczdRMUdoeTdSVnBEVmpqMEVrT3lyY0VIQms3RFFpZ1AwL1hZUHRF?=
 =?utf-8?B?eHVZbHl5WjFraEROL1RRdE1kMVIxcHppSnVrcDFHTC9ZRFdjK1pBQ05OM3ZO?=
 =?utf-8?B?enE0cWVwTmpWOUxGLzJGbWh5eW16ekJTaitzRnBQbHpCUDU1N0Qrc0NKUGRE?=
 =?utf-8?B?Vk5MM2tqOVFyZTE4VG1yOXJlSXhxaWpnRmF1ZUYxU01XM3VRRzF4RGdQNkk0?=
 =?utf-8?B?ajlzdE02aXdlRjh3NjJ4d2hQWWg3R0lnd1hkSDZlNmxhOU1ZSGlpbjQyTFMw?=
 =?utf-8?B?UnA5S3VZM0ord2NUNEJoSlkwSGZrOUlJMlZrSkFvc1NjN3RDNVhtSHhxWU5n?=
 =?utf-8?B?MzNDbEFJWUZQL2ZZQmdkK0t3Qk5idXVXT1I2Z1R4RmF3dWJTMFRIZlJDZldI?=
 =?utf-8?B?M0RrWFNCbzBCWDBwaHZJVndUN3dTa0JvTkxVdnVmZjNWM0xGZWpWZ0huVGtM?=
 =?utf-8?B?dHkwMVNseVRGZkJiN3g3UGpaOGk3dWJJTFBYQXkvd2YxSXFrRGtUbmxjLzFz?=
 =?utf-8?B?ZDY0RUI5TTJOejVhVEhsWldId2NMczkvM3M1aXlGbDlGbHY2RXE0TWx4a0Jt?=
 =?utf-8?B?dEh1SThza2w4QXgyOXQ5blFBWFgxU0lhM0J2aGl6eE02cCtRS3ZFRGhyUTBV?=
 =?utf-8?B?SzllSVp1czVXNjZXTHJUbTFJTnhwTHJDNU5IclkyQ0pTcjQ3bDdWTlNtcGNp?=
 =?utf-8?B?QXU1TE9Heng3cVNIb0dFVE95eHNPOW5ZemNHSzNwMm5TQnpuM1RpdXd2ZEJM?=
 =?utf-8?B?NFdlL2NRVVZydHhpSkhIK0Q4eHFQL0lUVVBka20xb3d1aFA2dFJsYmlwWmFx?=
 =?utf-8?B?YzhZRVRscmpaV0NJaEdWcVR4M2J3MnkzMnhSdGlxenpCYmNJQVI4anltd2pm?=
 =?utf-8?B?SzAzWVlaY1FHRit2T0I3M0YvRmNpcCtZYVBTQllXSUNxc0FoVnNScnIyMzU2?=
 =?utf-8?B?RTBUZFBWNTVNcWw4Z24rMjVsZTZPTHViY3FKYm1PNUxhVXQ0MC9wQmRFTTJY?=
 =?utf-8?B?YnZiY3NMOThFZFA5aGxKTFRkTWtFVjk1c0RpTlEyZ2pMa2hQcEVpSjVCOHdS?=
 =?utf-8?B?Q3pPekVQNWRVVnFzdDJQYkJRYVBtZzdvY0F6VGN6UmxNZUJZQnZmTWs1ZFVO?=
 =?utf-8?B?TVo2THZTVGtvZnRzUkpqMS81TjZjOW5qdzNKZ2VQd1MrTDYvNkphTUFLdm1Y?=
 =?utf-8?B?RHFqcW02ZlN1QkhQOER1cTR0enY2T1F4S2VaN29BOWNNdDA0ek5iMERHYjVp?=
 =?utf-8?B?MFFCSnNGckpnZld5VXVObitXbTNFTVpNMGNpWHhsRHczallWMEdyK1ZCZEhl?=
 =?utf-8?B?WUV5R2pidGc5V01GRzNqVm9nSDZGZFk3d2gzYlBmWGdZQTRETlBpMkdoeUVi?=
 =?utf-8?B?NlpiTXdxTktBTW5nMWN3a0RIcEg0N2lIdUVDSU11UW81TlZBS1VrYnFRUllq?=
 =?utf-8?B?RS90S2luMFFXUFdDZmdsS05CTDN2QTMzSEg0VWZ4Q2xVTnpqdmM4aUlWTito?=
 =?utf-8?B?b1hSa28xMm5SaXBrbk1hNXJNMytFWTFiMktRWDAxM3Z2cmt1U2creW4xUEQy?=
 =?utf-8?B?NDJ6MlhJaC8wVnA5OVJvL2I3NXBoSFVlV0RKVSs1M0VRK240WlRVZHk5VE9B?=
 =?utf-8?B?Y0RFZDFIM0JBK2ViMHpuaFBLaDU5SFp4TnFVYjJXb1NzYTRoOWVvNjJBaVZ1?=
 =?utf-8?B?eXNrcHZYdXZFWUdwMkFsd2kybXhmb2NmYlNIdXpuVE9PRnJoMHhxSWpLSzU5?=
 =?utf-8?B?VWUvK3ExNDc5bDBreVVaSjRJZzZ1WWpUTkc4YW9ieFpheC9PM1VDMDF3RnYw?=
 =?utf-8?B?R1VVa2V6YUxPMjVScjVzTTdOdkZicXFjY0h6TVY5cnEza2ZmRVlDUEpyY1Vh?=
 =?utf-8?B?NE1KdWJIQmFQMDE5SW5JdnZVU0U0TDJ1SzhDS3lHVkFTbmdYWFVjMnA4bFRj?=
 =?utf-8?B?THBLUlpMTWs3ZFcyTkhoY21vOE91YndnYnZLbEhuNlhVdW9LZzdaZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wJc1HRkU0NZ4PfvDEytXFcXfi6OB9tdfYx6Nbjkn9/SPRPx+D1BSLPactHHBJqjDTZzU/Wb2QZTgO+c5r/3jEdFUnkuuFPEMJ+kkyB5Xk1p/pEt+BsJgsLULWFjNPd8BlXsb+yfAvzsLX96WOMND5WXIGjyaPZM/aKNxqvjJzLctzTrTZhIc0hI+Md9Q9T0EodwTfFpKP1Zcz8lWVR7aaQvkt9PNSncihKxdiKkC/aRRLAxCbg50NY/A9Zk7w+8wZ3WLzI5cZHYavHEDqyj2eUMgwNZAp3u5WchtNjFMlo8/01cW+Lo9MnFWRkUmDg701Fat5iDOFZQCJunr0pNMza7LjIGnkAwaZZ6bAjj4s9lfMUUrbhQUxClsln3psKWofEPpgKAUEKbCkR6ziUaecX+yF1wRu6RLeMp80Im8TZ9fXP0/3TusLTgE7NGktwyd7yIDm3NplW9JpV1a0yVHGiaJEr9c06IXcvGhHxD4MiZZFCxsDWChUvTYJYJ79QpUNdaXDTR7m1obd2MEGwGzhCKTvlunitWwzzYil0BqhiOJTmMXLmAtwznYAK0DpE2UoKSd4XSbJKjrK4REpdausRhcXM/0OYXJGGa/vtIDCfI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdbd030-6382-425d-f9ae-08de7545e947
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 14:47:06.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGHH3NPq6Ix72LIV22dIXhktajhxxuBUG7W9tNesgV35Q1vJ9YNU6H62fcFGtyW7IGYJrK2hA3w2CxS1Nf6IOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260133
X-Authority-Analysis: v=2.4 cv=XZqEDY55 c=1 sm=1 tr=0 ts=69a05cf1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=YP3uXTgvvn9VsTlf1AkA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 4YdsrvjLOZ9kqUf56pm6Gymbx3AyGPh1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEzMyBTYWx0ZWRfX1BKuS8aElWAr
 tYrJD8z0oX8GR8YayyB/gRjfDDF+DWpRl6KY4S+GB5Qw4yJG3FaCP2nmnhX5hsKQyvRtvmjTXFw
 qyjGebHZN3VA5SWVEolKz+NQ3M1EpmyWXd8K0jRsG6qZlPXWpbr3p+r545euZQ3Z+O8lGhA0u6b
 dPsmC3xTO67sHJYqr3of2vANXt2YklKfcKqcMyRMhvWQ4WSM1HUid6Y90VMCd4FzXdNvkYioieU
 4+i8iXEiOeJzt+B7aZWmTs1tikXqe5PcEOIOebbZHHnWIpNihYjrURzG1C8i2KHUQAWB42f3oLj
 Tb2AGIHs9lXFeLzP+4HaIHras9EvcHgDHUZmO5OfSK5tKWesDdegyx5NVCYjXufwbccPpmflSJ6
 fKekZue8C+Dwtf01dvhQEREMUDeOlcyCwJIdT5J+a4v4ejHrtYlcWB0ZhAsttSV49jhjFB1xR0e
 1i4dz4ZL7ebbHCnUOBg==
X-Proofpoint-ORIG-GUID: 4YdsrvjLOZ9kqUf56pm6Gymbx3AyGPh1

On 26/02/2026 10:05, bot+bpf-ci@kernel.org wrote:
>> Layout information is maintained in btf.c in the layouts[] array;
>> when BTF is created with the add_layout option in represents the
>> current view of supported BTF kinds.
> 
> There is a typo in the commit message: "in represents" should be
> "it represents".
> 
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index b30008c267c0..a1f8deca2603 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
> 
> [ ... ]
> 
>> +struct btf_new_opts {
>> +	size_t sz;
>> +	struct btf *base_btf;	/* optional base BTF */
>> +	bool add_layout;	/* add BTF layout information */
>> +	size_t:0;
>> +};
> 
> In v8, Andrii Nakryiko asked why this is an option rather than
> always emitting layout unconditionally:
> 
> https://lore.kernel.org/bpf/CAEf4BzZuFB6zvMjdqKDumUAT4vr5MeA3LBqTh5xRZmAQ5KC10g@mail.gmail.com/
> 
> Was there a reason the suggestion to always emit layout and
> sanitize it for older kernels was not followed?
>

There was a reason; how would this sanitization happen for kernel BTF?
Program BTF can be sanitized in userspace prior to loading, but kernel BTF 
cannot unless we stable-backported a kernel change that could handle presence of kind 
layout. That was rejected as an approach last time, so I can't see a way to do this.
So given that pahole can be used on older kernels to generate their BTF, we need to 
use an option here as we do for many other BTF features like enum64, variables etc.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22436234361
> 
> AI-authorship-score: low
> AI-authorship-explanation: Long lore history (v3-v9 spanning 2023-2026), iterative reviewer feedback, human-style typo in commit message, and consistent with author's established BPF contributions.
> issues-found: 2
> issue-severity-score: low
> issue-severity-explanation: A commit message typo and an unaddressed maintainer design request about always emitting layout rather than making it optional; no functional bugs found.

