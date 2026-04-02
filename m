Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489A3921F8;
	Thu,  2 Apr 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116906; cv=fail; b=oZjJ/8oWCFPVMSjmua6Mi3dyg72sZBhruOb9uv+WvSsVslkiLHlajH2lM93ysE6NSj3Q/BW5rspdXsNdgl1thFg31aGgJa+hWy1cq97h40khmJO9Njx356PRTC9lhsB9K53SmU9cPr8KGwYsuTLxjIfanRRwiDZASjcYW7Ws6wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116906; c=relaxed/simple;
	bh=sNqK8f1v6ynG2jBPMyyshJN6V0Ly1TrHGIu9yDijeLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qPrzawji1hLIn5PyKcIUQLdS40Z1of/7sDwxssXzHRbM/0/WMTOhen7qnngyARAsTXsNrT5YnHeqXFFLuy3SOJEYvoVCtopfAB5xSfB41LlARJq2dZqg+hbDoS7KMfdjNr3Ey+efqGjVjjZSBH7YCSegah19SlHObLKRj31bkEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n+rM64g/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QKMn+fU+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n+rM64g/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QKMn+fU+"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6323j3Fg1730906;
	Thu, 2 Apr 2026 08:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mphg45HO5wS3rXCkQ03f0KKl0w8vxv8OaLciuY+oIBI=; b=
	n+rM64g/hpqagtdzrydJ6+Zw7xwOM/y5bdPomXmMlJOV5+SX0pN74LS2eGoq37mL
	dzfoit+Oh9KpY1ohQXSAuB5rHBjOd+BVzpF1ZebBcmOOxjojKD2fXPwfxaOyl2ZN
	wjg7kwL4FK9TpNkWPutyFiR+9HvvDIKwfwJx5tR7Fax2jy1Sx+CVpR/DxhUomNQe
	7gf2iYKTNS9WzG3eBfJGhDG6wvoI7MjqlIEdjumA78c2c4+O1e+HP+0YwKI6l1WA
	0KPPnp6i6i/7xryfvi79QprtTtgcST/gwSuB9iAbe0ZPs6XAuwY9mmrzBYfriUVZ
	+8k4GWPlJaD7T2Cl42azYw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65s101qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 08:01:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6326e5kY030311;
	Thu, 2 Apr 2026 08:01:05 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ejqkxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 02 Apr 2026 08:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl4lCtmz0Zs1tlh2fzF4BMZG2iA76xgNl5MTj+DraerxlWUqd6TZBremfs/0Yo8rCxI4ZDCZQZNvCKKk8WtqN3ffJpFtHiBZlt0fR8dIN9HpUArTMqNzThCQF4uDxChjnKldGZoTJiRovpDwNwP5MQGKDvfftU3KiR9VOCOqYYBTYV3s3211U9CjoR14upcpoHlVfCF+sn3hWPWsNz8LWgeG2NoTrB9v5PZc5kJRJJ9acYbOBFveA5wibwrqpBvlQF0/YuC3raGqqEUrgE546idoBLonhzRhky8zunysbBeuYkkwH4+wQzWHUOLHMpkl/p84k3HVUqHLJbn4nuiYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mphg45HO5wS3rXCkQ03f0KKl0w8vxv8OaLciuY+oIBI=;
 b=KX6JWoKMfBCGL8FrKYcbgD08LmoQ5puYc+zUnAfgQbFcYq5zTz/FB4YoBvA28gwDOxP1ibibF0UA755GdecChbJ5Nf3xJC2jUf0TQ/XXBlwgA07P0J4o0gPmONXkugDeOHzg8CdZLRzCJ4wMxNfd7w5tOu2qcyLgYr1kYf+UMndllXApua5ld3JUdqZiGeMaGdEUR7eRcNEwgDVp9G8IdKynQsj5jG2oyhGi4hTuah9tbmZqo79i6SytCKamevk2s1Mc9AcOHMU5pkg3noVP5zx8a7WkqjQWtoMDcBYQQ4NwoyDYTn4qgiyUGTiOxBRrgmgBEMoo9q43yK+hfAeEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mphg45HO5wS3rXCkQ03f0KKl0w8vxv8OaLciuY+oIBI=;
 b=QKMn+fU+kVXlnGH/KsiEOlee/nDQeKiJlGv2WIM6zlJ2weM/Ne8I6tLe3Y2JRkxJOUwtgnileyc32xE7gEKkJzF9vUtKg7oLN4SsvlbttNkwDAPVz+1MJDwgCoEOWbZwM9WSxH+Va4mKLdb9EZgVcw5PGe8WfRGD+EN2eo8zorw=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA3PR10MB8613.namprd10.prod.outlook.com (2603:10b6:208:577::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.28; Thu, 2 Apr 2026 08:01:02 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 08:01:02 +0000
Message-ID: <3da0919f-f8fd-4cc4-8e86-aa55604e923c@oracle.com>
Date: Thu, 2 Apr 2026 09:00:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 0/2] pahole: add BTF layout encoding feature
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260226085240.1908874-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260226085240.1908874-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA3PR10MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7253113f-d3b2-43e8-a743-08de908dfb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OHvF318PytR22B2AnGRJYvV46S9MEoNn04tk/G3lS3XBqvUgfmc7yQY7xYUlAvXbn8vtRAW89Zfr5z0x1x4ih/EF1SxUAxVxvw2NWXCWR308MIIIW1RV/Mo4dlY8fvUzYjS5JwvvkGuSh0ngh7qBebMGmUzCNNBFr9/h57yPonoBEOhgsYoohujYdd6GnW37cqGbsgp0CMvaHOXO7+gO+7SD3hWyGqwBQBK0hWhZoJXrtgqIKs5+fMzVTGStQRU34gAi2HHsyCEMCVH1RTQoZdGOL7plNN6FbKgMgueEIMPytRQTMNdW2jcOIZYsXwJdEhhVnwzulIZZ4iMGterHIvQEzFoqMXxjOAE8IunoUWbb6noN8+yVdo968r2m8j2jCuQap+Td8SqMXcNQuQdi3KQaU3GbSzUucr+GC245DuN9hvN3Doyoq1BQkhsUr7ks93SdDpRsxf6Cazh9UdaPScs1qQ+p5k7Enc6HjZ5vTB2dEy+Qo3pHweAwJ6jFWMyRXGcqUAYB39Dw71XVrxKNqz6Sc7pvtC+ucsTFMwgV1r0AWHscTLJoxs3K4zecsVEhcHdn5uSWrC/qmU/XfbxHLpQe1NLSL98OToMhkTsGxBiYgX2EJPdgv5XmvSUSQ34JHGxp/DPNPnysJyQ5GkPPOkmbyCEz7HJGm8gGshNl3XtfHFXamr+HgJYBJKA/R8AmTTxv8xdNxwIoiASP4kQ77oBM+H905KRMr/5p8x49t6C4T3AcnrRzz4W2n7TNozWk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3Zsa3lwL2hEb25ERTJqRE50SU9tNkd4eko1UTB3NUc5ZUpMZkxZOG9JWUI5?=
 =?utf-8?B?czNIR3FZZ28rRC82cThscjYwUFF2b3RrVUdlTnFlQTJPWjU0R1h5UmttQTZJ?=
 =?utf-8?B?R2RKeW5RRHRoOFBqMlVjUEtrVXZvb3l5ZGhqUGZYUThtUXU0cEs4V3BrUklK?=
 =?utf-8?B?ZlFKT1Z0WnpXMGlsbHFRZXIrbGIweXFqMG1vcVFHWFRGSU9aZVdrRDJhbGlj?=
 =?utf-8?B?Z1N5S3M5VCtYWnhVVHVWOXVwRXhvcllmZDYvKzIrUlBQTGxzNTVkYkhsVW52?=
 =?utf-8?B?Qkc4NWU4VXY0bEhrVU0zS0RsRFNpV3JzbXo0WkVwZEJmVFB6dHNGWTR6R1VC?=
 =?utf-8?B?TlAzYlh6RzhKQlNEYndvWWtIelRIVHRYZzNVZWZtbmpRYjZYREt3KzErVm1m?=
 =?utf-8?B?SEQ3MWFDQWlBVitIWXp4Wm9XZU5SWjhMQzBwZVl1UlVpMnFZVVJlL2dDQUl1?=
 =?utf-8?B?bEFjbVBpajM2U0JxZ1ZNUW9hRGh5SGdRZFRuY1Y1akhkZmdTb3hkbEhTNEFR?=
 =?utf-8?B?amI2NEVSZ2JsLzJqbkt4WWMwdXN2RWNyY2x0U0doVDRpeUErUHhRZ1NWUnF0?=
 =?utf-8?B?ZVhNUXA2OVVDREVtdnVVd2tJM1U3NG1Nd3V6T3JYUXhVQlVuUUVJMmNZZXFT?=
 =?utf-8?B?dkxpdThBTXlidWRzQ0xaOGZ2bG5OOGhKRmV5dVJxUEQyU0N6ZzVndkFPSHcw?=
 =?utf-8?B?U1ZKaUd5NlNQaDB6TUhZU3RydFl4aVRHckpwZ3pHZUk1REJma3JGUEFCalI5?=
 =?utf-8?B?b1J1NDNITytIdzdHRjdvbTRGMmNQZkN2cHYyQ1BlWmtFS01wY1paSGtzQjds?=
 =?utf-8?B?QTVyb05IUk5sRjB2SytmNzhzYXRJS3VTeVRia0Fad2dyZER2YllTTzc2aUF6?=
 =?utf-8?B?SERtWEpCMTNYTDZMNnV4d0hGUDAyNWhRNTZ1Q0pkK2IrcWJ0M0Fia3ZhWFZw?=
 =?utf-8?B?Uko5SFdSc1R3eEl5bkFOSnFENmFoYkg2b0ZsUGJ1Z3pId21hek03d3FjWXVY?=
 =?utf-8?B?cy8vU3R5b0JjVmVHVG1vUUIxWkUvN2VmV3M0OGZJcGhaNmUwTnJsQkNBRFRQ?=
 =?utf-8?B?WVBRTDFYYnY0UEU0VG1DVk54UkxyL25WWXlaVTVVV2dEUVlEeUY3OFVZdW1K?=
 =?utf-8?B?bGgvREw2MVBIYVZrV2N5aUNBSzNuSGZtVEoya1lqckZuY0NQOG0rdkh2NSs1?=
 =?utf-8?B?Sjk3OE8ralZ2YkJYMU5BNHJlUHVqeU5SL1dadi9neHRVU0oxN0tqL3B1NFQ5?=
 =?utf-8?B?OFdmMjgxS2FvK3U5WlJocFRvRUZWMUJkSGdBS2x3RkRlT216VCtVYURreWEy?=
 =?utf-8?B?RDhnZVVNOTJqTE81MjBqUE9RbFRHd1plbXFlSzl5LzNkalFxeDl5NmxyU1Rm?=
 =?utf-8?B?SHl3TTJYTzY1VWRqc0FMZnpkbDBHTWs2NURSbjdFMWRFVUtIeldOa2wvbHdC?=
 =?utf-8?B?andxSzNUSjR2Zk54SjRWR05GU3grUUZHaHhtanhNM0FaY0NFR1A2ekI4MCt5?=
 =?utf-8?B?a1lHcE9JbTZVYisrTllqUnFDZlVMWlMrWUFDc2czbDhmUnk5c2JGR0tvdzhz?=
 =?utf-8?B?bWxkWkxveVU2WlB5YnprQTNRY2MvZXdQRzl3WWhXdFZGK1hpYkVxN3VrWHR1?=
 =?utf-8?B?eEFNdGdSWTJwajJuRStOZEU0TGhJVURnMXFMbDlRRzJsWmpza0FJZVRHQWtI?=
 =?utf-8?B?QXJoUk9CU1ExQWc1UVQzanVDamJkcmM4RHNodm1GNkt6MHZqS0xCak9VYjVJ?=
 =?utf-8?B?SkI5T3gvQzdwSm95U0xSRzFtQnc3VUx5ajBxRW4xRGJudjRSaGx4Tit1aCtl?=
 =?utf-8?B?TVVpL1NjNlRLOVFRVnp0RzQxT0hLRk9jVVhIZjVwNDd3aFBTV1BmbTZDMFdM?=
 =?utf-8?B?T0UyazFKcDhlNjNNQ2FYcUMzREhXWnVlT0VPTG9iZ28vdUJPR05Zelh1VjNa?=
 =?utf-8?B?TXlwaG5Gc0E1TDJtQ3FkeGZjd2o5NTNWT2x5Q2gxWWxjR0k4a0tMck5ySExR?=
 =?utf-8?B?VWhyWDBORVJ1a21FaEZrbDNGeHlJTUFpT1pEQmVBblRlWm14QytlcG5MbytC?=
 =?utf-8?B?V2FBbmNJR3hwdWpzeit1bis5Y0pjcGxQeThhTmNyWVZtcG5hckFXVjExYzI1?=
 =?utf-8?B?YVFRYUdVOXRpMEh2VjJLQUpCOEI1bkFGSElOSFEwOUk4elhRMUFJYmY3ODRW?=
 =?utf-8?B?NndJMUNSY3IrYWtVUGJwSEVQY3Q5cWkzOWlyb0dZL1NMTkhVUkw0b0U1c3R3?=
 =?utf-8?B?MnBNeWVrR2R5M1NNbVkrMHE0OTJQSDlka1NSNTZhR21CRlcvVkVNRXpTZVdS?=
 =?utf-8?B?RFpuQk9CU3I1QkhObmlsb0FSS3FJc29GYTRTVTgvTG5Gc1ZUb2Y0UT09?=
X-Exchange-RoutingPolicyChecked:
	gJWsK6h+wsqF7w8oBgaeFzLsyOpkWriKIyJ5BCyuoiQflja4H88GJa4a8X/q8OZHMU2fKtmWODELhVTPnJLcygp8cNKdQJoQ/Nn8tOSHH1TpG4O02TV1IuUwGjPURJsCSlwPXTcKPug60ghVxy4rU3iSKpXkxvlOvDE82CpYHk7of/TVa/L/zcb04PeyrWW/72wnodJvNfWjaJufNNdwamCoh4+kSxIB7lvznBhZm5bvDHFs4Ts9ZR9tLgT5pS+YVp/C8oqWqLsRQkhYQsNakGK2kxVyOYyoiwaiDX/i1uTSOYm+V/FcDvQxsLQGwweD129wyhQKbFvCMAVDsq3u+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2rPsB30baFa6Dk752fbzgtNaD7+os6fyh1YMW32sFi7k/okeJpCVpSjngUdGBTUfMDENp1+RZgwxn3liwwUqXRlD+o6zyajbmUn17wxFLGqZc8CD6T700YfUETQUe1ZGD6m2T/uLU5FEGP5MwxiedEvG/sT2QOkFHGLV8p1n0J1q9TCZFrJhQc1QP4L8f1Q957nhgrl4tUVpZhC4bn39iq6yDoxExiL7GXNI8QENitUmcmTu0kb4VqEOvz6tlXF7IwYTk8wjLcspgunklsDnK0RD0JkVqHMzyokQHf3Gi5bJwMOdSlwl8Ggga6Y10pxEL/+hSwBnf60iUpPieANKjCX4DUNChl9jYZYBdsuGDaAyS7rgnsSCDgg46XXtz3DAzXtbiHe5EJqKnyLVrMZR9Xg9jj/H23bzXuOLllQSaiK2h1lMXrAAqaUqw3hxjiyRu4oajrj44y3pseBB2vWteOa1OndIwy6xBLEFAHqqJGB392bblnuFAJjDy3bigd9ScZyEBlhgNWAD3j8aAXmGM0JpfBlCtKKItEfu9xJOE0GtMu260qsPCRSH44qvRhyg/rb3ID1OhFhzcOVEnbwPOKPGiadNd0dmKKUbDH8QN9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7253113f-d3b2-43e8-a743-08de908dfb96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 08:01:02.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9niY+NwCCX7xFdKXmNR17NbjWdos+gmM57k5Rzj1RlQgUN12vcGGHQGvN61DOT4YpDIdabdthDzO+ZdojGP0mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2604020070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3MCBTYWx0ZWRfX3AcKeVAV0okw
 Gq7gLnr3dsJ68CzPZud3dBmBMxKsb1mzW5vDuIA+KkBe7jX53F4Ytba0yEYXbjQi6+FJj+QDsTh
 s64NsRnXBVzVFa2Fn/YCWBmnlP/z2jQuByBm8MaUmqsUNLFBT8HegaX5BrlFfIM+wClhYavlNxK
 haNQGpE+z3ICDSn0etTx8ppXWG8W4irtJHMkAewEwrQtvHqcCFmcEbkyUj+bgsCx8RUT31SwTN7
 yYirFMpXeQ7EY7x1yQ14GeNyu6xdgf4nPIUfocFi1kl5Ni8WVVaBY/FoZ+IL8dzJtMsPbz8b06e
 wnXSerK6qNUd9jUS+CixGjGnb/eOTyCby1292cxn9MPJJb99e1wUz8Gq1iUOVRZqsyTdTWVDA6h
 xmHOZBsWdz4dP3YsXAgO7L7VSxHicHsrScIDGZ/mwjBf0bj57K/8p5xCqMgjwPQKz/vQ3xyuM80
 fEgdNG7i2V4NrIb3dCarGmXpDXnKt+yoG0EB6pqE=
X-Proofpoint-ORIG-GUID: R6I5DHC-nEP_CG2PI8yvvo6IRaHKxw7k
X-Authority-Analysis: v=2.4 cv=BvOQAIX5 c=1 sm=1 tr=0 ts=69ce2242 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=77dUg0uYUTY_-1i6vt8A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12291
X-Proofpoint-GUID: R6I5DHC-nEP_CG2PI8yvvo6IRaHKxw7k

On 26/02/2026 08:52, Alan Maguire wrote:
> A soon-to-arrive v9 series will add support to add BTF layout
> information to BTF; this describes the BTF kinds known about at
> time of encoding in order to support parsing even in cases where
> the kinds are not known to the parser; the layout relates a
> BTF kind to the amount of space it consumes via an optional single
> element following the BTF type or a set of vlen-specified objects.
> 
> This series implements the support for the BTF "layout" feature
> but does not require the libbpf changes to support it; the feature
> test uses a weak declaration of btf__new_empty_opts() to handle the
> unsupported case.
> 
> To test pahole with this feature, the following approach can be used;
> 
> 1. Specify -DLIBBPF_EMBEDDED=OFF option to cmake
> 2. Install latest libbpf with associated patch series with layout support
> 
> Alternatively with embedded libbpf the changes can be applied to
> the embedded libbpf in lib/bpf/src.
> 
> Changes since v2 [1]:
> 
> - Resynced, renamed kind_layout -> layout
> - Avoid encoding layout info in split BTF since it is a waste of space
> 
> Changes since v1 [2]:
> 
>  - Resynced with latest pahole
> 
> [1] https://lore.kernel.org/dwarves/20251210202752.813919-1-alan.maguire@oracle.com/
> [2] https://lore.kernel.org/dwarves/20250528095349.788793-1-alan.maguire@oracle.com/
>

Now that the kernel/libbpf side has landed, I'm aiming to land the pahole side shortly.
We'll need to resync with libbpf when it is synced on github too, but for now it would
be good to get these patches in; unless anyone objects I'll do this today. Thanks!
 
> Alan Maguire (2):
>   pahole: Add "layout" BTF encoding feature
>   man-pages: describe layout BTF feature
> 
>  btf_encoder.c      | 21 ++++++++++++++++++++-
>  dwarves.h          |  4 ++++
>  man-pages/pahole.1 |  2 ++
>  pahole.c           |  6 ++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
> 

