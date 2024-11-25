Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF262F2D
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732562410; cv=fail; b=ZcHdEavjxrYODPNXjy7sR1CYFI/DzCYXM4oEbAi2OtF2+yIFD6CMjL8FpQwFZH96Hprf3sgfT4Nkhf3VHzE7PCk2khkmogb5U/aWVyfY7A6lqd6B9jP4z9+FC2/Y3dd4ev82Pda4mKez5So3tMgDOk/Ek5OXoqiRwCu4giXOfDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732562410; c=relaxed/simple;
	bh=PK0WZfs6sq6eWKh7cU+IQtAT+N6/mQdVMJdCYs+W8Yc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=En+lYgE1cuQNbORr1ZPpI8DFQJzsdFG/XbZ83Y+aJLqWE9/H4LHuTlWdvHPFIpI56yvFlZefmW6sVyHVNtYXbNQPmiHW1NC/JCeeUaf0Y5F7aYylmuTMZ/fiFPnDkBooZrnWRuusmABGWmf58jSMpBLSP3eluu9TGdis6Vp7hPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UGANiXzl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FRkCw2Kw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UGANiXzl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FRkCw2Kw"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHXWVV000603;
	Mon, 25 Nov 2024 19:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=C3J1sTC1zhtM8yx+bb57pIDyfF/F9eksgpEbG3LkBY0=; b=
	UGANiXzliyJ32E1isLQxwzz3pAaKO6KHaZRApRXAp0lJV2kUdSHbEi/YT2OEuHFM
	go10E6t1Zz/bGm26qp4Vw/fUb3Ow0QBXBy0lQ92UlVU6g9P6tj+dS1RRlK7WS09N
	rkpgPgkT9yxq/uTUSL/ZZat6nElY6HRZG1jcZn33J7LA12AUwOG48tAoNhe0Gp0n
	Jhv0nVYNsXRvw1duPqz1dStl12H0ZjUIaRuDbnF5InamXlvjnCCbo1tPlcSOfxJm
	TS7jk2GLgNeBOdgtps8VqYS2UncS4bZ/RlmblIyewdX7EoE2VVjigxkrG/gRZwJc
	/qZlsmr5J9ShjlxTdB8ZRg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384auwvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 19:20:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APIwat0019176;
	Mon, 25 Nov 2024 19:20:02 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335geejy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 19:20:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mULK/dZnLLddIdjbHXPWK91SYIsXrkwlNtWoifv10Gbe2F3/n95eunDDjTF7jPz25RmIZ2TVEqIf9xiHyL5aFU8oeKud6V0PkBq/QTwwnBT/msZbuXk3ncCQ7gJ/Lk7z9ZX5bqJR9CYNa4Gpb6lKLI63TkEnLgLh+ZGm0c5UqYNh333jvHnlSpCO5zWpgXphqzpU+RQcfVhX0oa9wtqZyljJmMuXUcygp5q/BtgFxqnq6SoG2Ft75v+qVOgjW9Sei91ekbBWOi1vg5BD+joTPtrrMSe/eSGBZSUsS4FxZBZAp4Bg+rbJxsganHIKLvE9PwiFl/6fpfjZAXL5z4PpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3J1sTC1zhtM8yx+bb57pIDyfF/F9eksgpEbG3LkBY0=;
 b=hiPxTmJEpuLBSorYlmZNOy0f4tzwXO9NomOxw9FkYxmCIQA5BEsC9QcwpxxFkTxmzz9FrE7Hlx/0O2jZ4bgjDhj3UaqFmjOzZIs2EceMADb4bqPA608rjPacQGUv5BUuUSF+WDa7guPRY2O8J6FWNnD/0yHHssMe3oAyrQGG0+efHf1EO6rs0ytSt6lLPnjh0h4UzkZxiNFdxqAagkR3qLM7bpN4HA2yyvpZ/8C5qpSlgxZlpzD4EP2IxjvPKFJ3jHT8TNaccB+nb/BGxwmmhcMkZ4hlCMflbuctdALcelIObpK4yZ4F8xPO7PQ4/Rw+tDhkHHtHl9qSlQvvAe5wIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3J1sTC1zhtM8yx+bb57pIDyfF/F9eksgpEbG3LkBY0=;
 b=FRkCw2Kwkdfyuh06xepIio92wSW6UKXAL2K81CJaI8zbGx/1Xpw6SkMeWfxO4ZttWl2p8dzsMMQ6QjXATqROkKZxNqfT4AfuOiuLVsJ67mSTzTopWwQyGhDv+fuGVC7LwHlNyzHEUxtYN1hVg5iioMQFCQBnYeK6/0uziX0eHys=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO6PR10MB5555.namprd10.prod.outlook.com (2603:10b6:303:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 19:19:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 19:19:59 +0000
Message-ID: <7b845bdc-6374-4c95-bc71-353f69f785b8@oracle.com>
Date: Mon, 25 Nov 2024 19:19:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] Respect CMAKE_INSTALL_LIBDIR
To: Ben Olson <matthew.olson@intel.com>, dwarves@vger.kernel.org
Cc: acme@kernel.org
References: <Z0TGPw6P8y3c1lKO@bolson-desk>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z0TGPw6P8y3c1lKO@bolson-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0351.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO6PR10MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: 4160c337-615a-4673-3754-08dd0d862766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU5nakdGTDVyK25Pa1RTRkd0SHpOU2hzNnNDa2hhREdYNExnNjFuK0RzMmdJ?=
 =?utf-8?B?Vk5WNmNJMG5YZmtNWldhNmd0N2FscVFjb1lNTGk2VGlYRlBjMUZrRWNBaVNr?=
 =?utf-8?B?eGZJbFZINTR1eWdOYlVaQm5ncmI4QzU0MXN2YU1aQXc0V0kxS29TSUpkS3dH?=
 =?utf-8?B?cDNpcmdwMWJIYUZFYU92MDk2TWVjM2FQWEdzbktuV3ZNQ2xodlJaR2FMSkVV?=
 =?utf-8?B?TUM4Tm5kOVpPK0FSSThYREozU2RhRVFoVmVhRlVwQmZLUDcweTQxbUdwVG1l?=
 =?utf-8?B?QWNvTmhZcWw5TWNBQ0RrQjl2cGhkZlhHaGZSOFphVHk5b1pnNlNYcmdpekF5?=
 =?utf-8?B?OFlOOWQ4aUtucnVXNFBYU09MaHk1NjF1S2U3ZkxuU1lFZWVXbjNVTzhFeGlG?=
 =?utf-8?B?d2F0TVhJcHZjNW8zNEczRTJ4YW1LM1hKaHp5b1lPMjBWNTFiM1NvWFpOVzFu?=
 =?utf-8?B?Y3lZcDVJV3llQVdLK2RXTHIxNHZFZk5PYkFtV0JwQVNEMWxuUTB3N2tUV1lZ?=
 =?utf-8?B?ckN6V1ltSTl1dHlWRHpsb3B1YW15T0h0NGdwUDJJeGV3RnZvWmJwQzJuK1Rz?=
 =?utf-8?B?VUJ4cnk3NEdEOU1OT1l5WUF4bFZ2TnBSbDZBWFJ5S1d4aE5jTy9aemQrZmR3?=
 =?utf-8?B?anZLb2NqWXE3N1JYOGJkMVVQR3E3d0hCQ2FDR1BmNXFPclBXTXJGM01GRkJP?=
 =?utf-8?B?eThxZCt6TmJrNnE1Q0M4czBWR2F5Z0dqaTRYbWVnMm9WYzdrWmVQZE5hQXJu?=
 =?utf-8?B?NXVIV1plVmhhbVhSZDdNV1kzSHNtaXNzOWNNRCtUMm5ELzZFaVcyaEpjaEtM?=
 =?utf-8?B?QThKMFJORGZFcTc0bzRKMXZaMjJHem5NdnArUlF3T0xjd1dUUFEzOW0rNGIw?=
 =?utf-8?B?cHZsTVJpOXJvUHRnS21lQnBBYTd0eWVIcjJhYXZTK2R4WDhTcWY4ZXF5MGFk?=
 =?utf-8?B?RGxjb2ROT3BrQ09vd0hKVWRIQ2ZmU1IzSUdCTXQveUhpdlBoVWIyMkYwRVQv?=
 =?utf-8?B?Szg2MFFDZDZiZE9sUGNhbndOWnhwRE1nNWJ5aVZHVFM1Qm9VcUdnK0FZMENB?=
 =?utf-8?B?Tmw1OXJ0SEpucitIbVJwUGxjSHg3L0VKd0J5VmxGZ0FDN1YxYVhQdFBqUGFu?=
 =?utf-8?B?UjZFUG9NVTNYME8wV2t5YVFsQnRlZUlxMVFRMVVxNkF2UGhOZnRFM1NqYklp?=
 =?utf-8?B?bkhQbTRYQmY4aThsbTlSSnMyOXFLcGVrY0tyQkdpOXFRNFpFVlBIY2pnU0FP?=
 =?utf-8?B?TGh3c3dkYyt4LzN3R0xnaFNGT3dJcWFIak5BMFBEZmRlNDB1SEtrOUQwdEhD?=
 =?utf-8?B?bytoTUNZWnBsK2tsaVlxUEt4SHBzcXhtTkZXZjN3TmdQeXAyd055MlBoblpV?=
 =?utf-8?B?d2dSQWd0OERNQkxkZzZ1Q1VMVkNLK21Yb1R0d2pUUWlpRjkvaTRhNmZlM2dZ?=
 =?utf-8?B?ekVqYVhncHQ0N1ZBTmFKWUdrckVvUTF5b3dISXVJY1J5TVBnTVBmVzJGNmhL?=
 =?utf-8?B?ME9aRmZWUjdaMHUwanhvekg2NExuV08vazljNzNwREdRbEJEcFkvaHFKdDM3?=
 =?utf-8?B?bHZWR1N4QU1BQnhFcFVCTGM3blBmMFh6MzkwaDBnYlMyWmdzcmZaSS90ZHNO?=
 =?utf-8?B?c0wyUlJqVUNMR0lZVE5USVA0SEFhOXVaUUYzYlNDckNxTDh0WjIzbmtTWHFV?=
 =?utf-8?B?UXdlNFlFL09COS94RW4wenRZZ3N2WmZpSmdjcTIvaFB5YW9XMnc2dGxXdnZT?=
 =?utf-8?B?a0NWZHp3T29CTm1kampmSEZmVjNQZmgwUmlvbVo2OWJMRTlyVmU5dlJWWUR6?=
 =?utf-8?B?enlOMURXMjhZcU42RXp2QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0xyTmtEYzRRazI1MnlDMlN5RkEwSGZ4MTQ2Y1FVZGxVb3NVK3dHa2lEQ29p?=
 =?utf-8?B?VmZpSlQ0T1lUYnJWUWx1TmJ4TjA4bWU4aWptejhCSnZCWGRuM1RJeFhUc1FB?=
 =?utf-8?B?eVdXeHRyZVhVYUtoVW5YT1NWdjlwZTVZVXlYOFJzM0RUNyszSngxUThYMXBq?=
 =?utf-8?B?OVE2emcxOVJwL3B3NmFlWVNMaFFBWFBCNVl6NHZKaDRvY0hmRlhxQ2Q4Wjhp?=
 =?utf-8?B?dnRGeGJDdUFIUFljbXRUMEpXUUl6L25wZ3hDdzB6UWU1bmpETC9wMUh1T25n?=
 =?utf-8?B?NklobXZGNXFRbUVUS1pNc2JvVG45ZzRKTElSMzVXd1czeWJpVjNRZld3N2lL?=
 =?utf-8?B?QTRIUzdiRjhZSG13am9QcURPSEFNWkVxOTNlamNydjc0MDkwYllqTGphTWh3?=
 =?utf-8?B?aThoRTVPallQQTUxNXUwVzN3QmNTaUMwemdaN1Bib2tKdmwyd3JjS2lLOXUw?=
 =?utf-8?B?MjZVeHhidCswUEZrL2ZiNFdvcWRuOVk4V2daVzcrUi9ReHRTUzJPb2IxSWt4?=
 =?utf-8?B?cVRUVWV4NUNHeEF0RGxLSHl0UHlpN2pXaTluaVZOV0NDOERUNkJ0TlloMm1H?=
 =?utf-8?B?TEpMclpvcWRYUGxLN2pVbExoaGJ6V3pBanZTdTBGWFVlSXQrcGRISFd4SzRq?=
 =?utf-8?B?WVZoTG1BeEFHV1FKU2VGKzFvbmI0aWo2QVhCU1dpak5lWkQ3ZVhCeitLZ1VB?=
 =?utf-8?B?VHhJTzRGbEVsWlFGcy9CN28wa3ZHUzBWaUpHK01XYXkrOUQ0c0FZdHlTaHJj?=
 =?utf-8?B?Zzd4b0liRXpIK3FyR2FHS0FEVW9hdUE1YjhiSUFDdUZNQnhKY2JBVFV3NEZG?=
 =?utf-8?B?ZERPTWwwVkw1anlHRndrRFpFK0loVmw1RmZlMElTbTRwZFpiRjh0Qm5wd3Uz?=
 =?utf-8?B?bFFHZ0tBY2FkSlZ2UzNJMnFZMkJsV3NTVmFsNDVyaHRPWEUzM0JOVkUwUlNB?=
 =?utf-8?B?cC9jaDd2RDNyL1kwaUpRajJXOVJDWmpuZi81VjQyc21MS3JZczd3ZmNXeHcv?=
 =?utf-8?B?VWtub29Zb1VIU2N0U0M2K2VkUzRBQkh3d2ZkR2ZTNkF5c1N3WVM3Ykt4UmlR?=
 =?utf-8?B?Y3ZSSC84VkdIbmFaSEFySVRla2FYWDE4YmNYdngrb2dYbzRHc2J6VUNmSmdI?=
 =?utf-8?B?Y1RiSTRRK1JEeVg1WWpUSFBQN2JyOHBYeTdyOEphSDdxdUg5cVhadzNHbHRP?=
 =?utf-8?B?ZnJzbkplRk9LZWc5VEdWRGFFam83c1hUUWVONTUyeWs2QTRKUVNmSDRjdUFl?=
 =?utf-8?B?TU5iSnhSOHpBblFnd1ArTnlKMVc5b3VncjZncFNrOXhhOExXc3QrTHhNcnRW?=
 =?utf-8?B?YkIxc0FQTElsazlaWFUvWDAwdXA4RGVIdWJwWTFHU3VGZkNlNVlCYm1DSlZq?=
 =?utf-8?B?Zlh5N2hNOCtBYmE0di9PM21DOFRrVE5oeVZBRm9NSGMvaHpLQU1iT01uekhY?=
 =?utf-8?B?Y3IvdEZldXRyOFJiWVorLy9Odno4WG0zRzY2R3F6eU81bmxuelJuc3cwSGFJ?=
 =?utf-8?B?cXRhYUJ5ZXFxWm5IUERBRjFuQmxVNVU1MWNHMmlIemZPZWxvUlZTM3hXNTN2?=
 =?utf-8?B?VFVaeDZhK1hIaldlbGdjZmtWYWV2WnJUdllYU3hTVGNubVVWajllelZLNlhN?=
 =?utf-8?B?UEd3V0VjR1g4V2huelZuSkxVKzhFTlo0NGcyRjU2ZjB3UXQ2Z2dPdS9nZ3Js?=
 =?utf-8?B?QVB3M29DUVFGVThxVENTSWRpRjE3ek0rWjBrbDNjNXZKL1BqL1Q3WTVFblYz?=
 =?utf-8?B?clQ5Rk9va0ZiSzdITk9oRUFtZWFZMFhvWXNqMDBvT0VQUGdIYXBMVjg4TDd5?=
 =?utf-8?B?Sy9qTUJDMnBCbHpRcDk1R01zbnAwc2xjMUdubzk2M1NPYUVjcnVkd0NLQVZY?=
 =?utf-8?B?aDl4UEZPMFhDNmJSTno4V1AySXR0eGxGbTRyTFZvdkY2WG5MNVNjRlFsZUpm?=
 =?utf-8?B?a2UyTXZ2a3VrQVBKalF5MzZXYnhCZERmQk9kUkFQN1ZoMWU2ekEyYldDVytJ?=
 =?utf-8?B?TW9JL2JhVEVkdGN4VmU3eDlJdTFzdWxscWoyK1V5blJncWdvRkpqVkIxYVR1?=
 =?utf-8?B?UmNRa2xnbGs5dnBEMHBqM29RY2RPVE5NTmtoeWVUbzJ6d00vbkRqcGMreXVU?=
 =?utf-8?B?cTVuZFFuSndIRHhnTkNTOVJhYUpBM3phV1czZjg4bUc1dG8xdTd3RkJ2UWNk?=
 =?utf-8?Q?b4qmM+/PVQKvcmKhEpNJAR8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1sXaZ9n+gXpFF0T25bJMgRYX+bmX4ZCIBeBxPWokhMUvgrXeJacbCJCBcqC0HDLawm4taUvttTVEZd18DkhIHNWgNbPLR/VzYKQrVjf6BLivICpp65ess+h+9irCwdvshMDXJ7shqqX0Ea5TkjDiPVSYSGF2vdH2BTObpduzqOUZEFfw/EPiDR9Hq3QG03fi49fjNhC340DqkpD7LcL/0w5s5NbMPQ5v50KayEWEFz7U6LiJmMK4QknbXHbTvM3TmLRjYRvUZp2IamzAfApO4MppanOtSO5ySB657pe5LpGiQg+T8RcnfQ7ZLCypUtksfSY9u0cYLlsFKyT5hen1dzAA4h9hU1AJE+9ju3olcHXsQp5Ko3VSlnpmoRYHZu9FayRiGq9VHGg1ltKYk41QG8EpxjdEsZkzqs3kpZdOe293YkW0bOLYLxezAWz2WiBI0tRT6071NpgUd255tb0r+gIA9yAFS0CjgMdV9PrID7AuyyStt2A3x+kaFXM/hOsh6M2O+AY9ByGIPPZ5irxmcKAnBZsjjWB9GY/SmBQODMa6Oy5DGhLC5HslLvLfPaxd1yHn+fxFXm9ulR/38maUOSL3/uN8147FXF75c6EfA/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160c337-615a-4673-3754-08dd0d862766
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:19:59.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2sCx4HH9U16frxqZgrWFQXwkaXtgzCVMBPDcfX4U4j6rSsocJ9lASUeDUUrniAa2oPggXwwssVmU8c9H+WzxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_12,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250160
X-Proofpoint-ORIG-GUID: yaMI8q-9TujJemCOqj1e7s66ezwhxTRO
X-Proofpoint-GUID: yaMI8q-9TujJemCOqj1e7s66ezwhxTRO

On 25/11/2024 18:47, Ben Olson wrote:
> This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
> and use either `lib` or `lib64` by default so that installations match the
> conventional placement of libraries.
> For example, it will now install `libdwarves.so` into `${PREFIX}/lib` or
> `${PREFIX}/lib64`, depending on the distribution.
> 
> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> Signed-off-by: Ben Olson <matthew.olson@intel.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

(tested on Oracle Linux which uses lib64 for libraries; specifying cmake
with no arguments did the right thing and "make install" installed into
/usr/local/lib64 as expected; nice!)

One small nit I noticed, sorry missed this last time - the README
has another reference to -D__LIB:

"    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF .."

I think we should probably remove that reference also, right?

> ---
> 
> Changes in v2:
>   - Included the proper built-in CMake module
>   - Made commit message distro-agnostic
> 
>  CMakeLists.txt | 19 ++++++-------------
>  README         |  3 +--
>  2 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 8ca1bf2..1d0dadf 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -21,18 +21,9 @@ else()
>  	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
>  endif()
>  
> -# Try to parse this later, Helio just showed me a KDE4 example to support
> -# x86-64 builds.
> -# the following are directories where stuff will be installed to
> -set(__LIB "" CACHE STRING "Define suffix of directory name (32/64)" )
> -
> -macro(_set_fancy _var _value _comment)
> -	if (NOT DEFINED ${_var})
> -		set(${_var} ${_value})
> -	else (NOT DEFINED ${_var})
> -		set(${_var} "${${_var}}" CACHE PATH "${_comment}")
> -	endif (NOT DEFINED ${_var})
> -endmacro(_set_fancy)
> +# Use the standard library installation directory
> +include(GNUInstallDirs)
> +set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
>  
>  # where to look first for cmake modules,
>  # before ${CMAKE_ROOT}/Modules/ is checked
> @@ -84,7 +75,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
>  	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
>  endif()
>  
> -_set_fancy(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${__LIB}" "libdir")
> +if (NOT DEFINED LIB_INSTALL_DIR)
> +    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
> +endif()
>  
>  # libbpf uses reallocarray, which is not available in all versions of glibc
>  # libbpf's include/tools/libc_compat.h provides implementation, but needs
> diff --git a/README b/README
> index f9aeef7..0627872 100644
> --- a/README
> +++ b/README
> @@ -3,8 +3,7 @@ Build instructions:
>  1. install cmake
>  2. mkdir build
>  3. cd build
> -4. cmake -D__LIB=lib ..
> -5. make install
> +4. make install
>  
>  cmake Options:
>    -DBUILD_SHARED_LIBS

