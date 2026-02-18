Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABD258ED4;
	Wed, 18 Feb 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437281; cv=fail; b=B/BLj2aKkjn+f3jty6YzdpSEcPh58KVNuXms2MJeZtuOcqPhXSDQMBpG8CJeG5K9AYkQfSsiegPJGJFL+grLv95nAiy2+WSyq4ipzR+FuKn/ejl0MzJWU0qb1HmGDCJ0KBJs9IRUZ8xnddKdPXtGrJM9tUMOUKNulvm9KA0QmWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437281; c=relaxed/simple;
	bh=4+1l5ZyG6yJpWiJ6R1kgXj5ZWjQw3yANhg/mz3Ez3VM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZeQNBErWUs01Jx1dRpHM4OUO3E0S3v/+W9twyAHNTIGBTmahpeQV7ToAvBdaI030EBNBCfn0ZQOQAl/Qua/c6biiqJ02IyL2GMlrOM+qNyu5tlS9RWYmcua5dOm3eeKuvpb0LeJz4zMwiuZdX6vMqxhWhJuly3oWJBkqMsrSEng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d4qhcPlJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lrQBDhBM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d4qhcPlJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lrQBDhBM"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IGsA7F066196;
	Wed, 18 Feb 2026 17:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tTkThYm+DJaMIOhcHZ+5G3iNbYwZ5hEH3cfHYP51CPU=; b=
	d4qhcPlJLyseLd/PSrxhqP7NULuzv8IaloWOK9hJewPicwUs2qCCNrsgx5R8wKmj
	xD/IAK+GB4l9wSDK8sqjDSG+J9p93s1bYXplCFzQA653vthHXFZjj3J1Z05HLVVZ
	nQ0Yp5dYB2HyV0fCXdrL0NBQnUBrUPOu7uLffVRD/RdX38v62FUfsg9ZemsAKoa4
	8TqPcdj29sHRX0wlwdM8LPiP2TPOeMOV3cVOk89kHVRA0pc0bK/xHDcj/H3TvvK+
	X5F/27MxPwdk5AspAaMBJg5UjMWu26G20DioHCGe6UaJ8geyhtlLgBt5BWvcwHa1
	f4zuR3/cENkWVs2/cGkNlA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj04607w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 17:54:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61IHSJq9022917;
	Wed, 18 Feb 2026 17:54:26 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2dw0y0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 17:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6KuWtgGZISitpzg31qoBKdbo44jmFDrNZnVmsvvepUt2VWgVUM9yA3nhuZNebh3RkqjBYSOauGAiVtW/ZKvRAR4ww66xtU8JCrIR6cU8NjR6Ee39KfWq/+bbGM4ul4DGnNXHUFImNimdhszJRw9Cg5c2EFr6l0ZjZ3aPaPvjTSc3o2KbIEbSB4+cFOz5G+BpWK39Q88NRYG4c73hRcoFus2uVFN03N6e+IuVRYyrOQpQDyan2I8+8YPkMlQHcovjphpIEGqPcIMlP6QIcVvKZEw2J0FV13SgQWJ7ZwrPHeL5WAeS4NYlpXvcLQuTUg9S1dXR5dV+2lGbkuGRuzz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTkThYm+DJaMIOhcHZ+5G3iNbYwZ5hEH3cfHYP51CPU=;
 b=UR1RM0/5z4xrS5ORytnyQm1PNkLA99rDzhV2dRpy8wIFnrENzlKOdIWPol7A64Ww1QodHMIsZArND2cevfACBnPQvCbxRMiV+tdkzVGb07vGJXCxLXwqTFTzbJCOPYfsarIGh6pUNj7MBIleYLlIKRyo5mQiiMGG2hiisI87+IFVEbX1KGaEmIIpRnupSz8T8bIY3+jfTrAbFKaCglJf48c/ZniAe/EFQiSbQBthx3CR8e0HhuVDWa156qUKL1SsNwkhxMjEAIBlTLTLpVE6M5ehYRwRuURfGVyygLkUi2C0aZYgas2oKzYeL+41r1URXSTEF5x3RE2Nag2yaQT1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTkThYm+DJaMIOhcHZ+5G3iNbYwZ5hEH3cfHYP51CPU=;
 b=lrQBDhBM+pNMUZe2TvuWyQ+Cae5peyjUlQhyCZ9v8Xj1Srp2UaCbPbOSDopavx9tdoxmIitPYNXB+nJ6YIZ9d33sk8el1lckno4i9+aBGMWL+RQGX9g3i+UjO+Svd/VHbSXscqs2RvSfhSn047cALwM3Jdeuu+F/vsWHiU/woEM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 17:54:20 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 17:54:20 +0000
Message-ID: <9dda7127-cceb-4324-b65e-32df3dab66ab@oracle.com>
Date: Wed, 18 Feb 2026 17:54:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 0/5] Improve BTF concrete function accuracy
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260127172041.1558244-1-alan.maguire@oracle.com>
 <36dd0074-040c-4c69-aa0c-99d8ff5edbbf@oracle.com>
Content-Language: en-GB
In-Reply-To: <36dd0074-040c-4c69-aa0c-99d8ff5edbbf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: e79438ee-53ba-4e13-ad9f-08de6f16bde1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1lyN3gwQWhUV1BFSENkakpqNE5nQ0ZEZzdHcG42UUV1S0dubTNNbHlZQmgr?=
 =?utf-8?B?Zkc5Y01MQ0RFTlhlMk1lWFNGTU0rN2ZaNVB2T0UrUUJ5Mjc4Wk5rbG1xaHph?=
 =?utf-8?B?YVBJNGw4S1V0NVFITnhndlhDdXNaNnY5UUZpQW5heVF6QmswRDB3Mi9zekFn?=
 =?utf-8?B?aDcrSGJxQnFoMC91SVk5TEhCWDRWSVgxMDc3Wlh6WXIyb1NnblpWTHZ2L2Mx?=
 =?utf-8?B?NzFENWVUUUsxNVJqV1lVZ01wN1RSOHB4R0VJWjZneFRXelJQaHcwaTFtbmRm?=
 =?utf-8?B?YlhvSmM0c1R6NHp4blE1V1kyMjhtMDlqNmRha0FIc2VCUXZrU0FBSUJLUkNP?=
 =?utf-8?B?M2lVaktKS3Y5RmxkOHMrdkpWK09MZjlCRlFIV3VySWtpMFROMEFBZkh2VDJr?=
 =?utf-8?B?MHJCdzgrMXloa2ZoZnRwUFM5SktjTHUzeURkb1paanYwMXBybUtEeUdWa05t?=
 =?utf-8?B?V1Q4KzRXSzM0dGc4VnZGK1Z3bjljN3pwUG15RWlISUxqeWVaMjhQdmdMbjZN?=
 =?utf-8?B?UmlvcFpQU0x3L1V4ZHlCRTFDV2o1eG91djI2YW9Zc0xma2orZFpqSzJTUzFO?=
 =?utf-8?B?QWx0UGJtTjNVWklJa1VNbUxxVGU4eFQ0bXd6YytHM1NZWkVWQjZRZ0pndE5q?=
 =?utf-8?B?U2xJcDRYb1RaV0Q5SFArV05WdGpFYmJ5bnptNGs4WkVaSkhyQ3NUZ2FmeXhG?=
 =?utf-8?B?cFM0OTIvSEovc3ViMFd6KzBibzI2NS9UanRGOHh2a0pHMWI0NzZEM25jN0pl?=
 =?utf-8?B?YVBzbkZUTGd3WW15Zkk4eU80QU1KZXZHMnp5L2o2TVJBM0Y2QmVwUVdBUTVn?=
 =?utf-8?B?OENsRnQvY1FMTFJPekdDQUg3WFBaOEJmYkZIRVo4OU80VFNSWm1sdHFKd2Jp?=
 =?utf-8?B?eERPakpmKzZsUXlTSm52cTU4U2w2N1Nqb1U0YmVPck1UOXFDaktSQ0xaTDV2?=
 =?utf-8?B?Zk1xamdZeXVQeG5CWE05TnJxSUlCRk1SQlB3UFBBY0tUVXdvQ2pwb0lzc2dv?=
 =?utf-8?B?OTlobTBLeGQ4a284OTViT2RNalQxQXVkQytNSHBkOGxhRW1pYUdEbkF1czBB?=
 =?utf-8?B?QmN4MVdpZFJSRlp3UGJxWnQ1VVJnUmFwN0JHb1FxZFBVOWI4MXlud1dnY1VP?=
 =?utf-8?B?S2NMVDA4eUNFa2g5N0VLTDc5ZDQyV1B1UC9sTzZtelB6Y1JkR1Z2UzZGMUZH?=
 =?utf-8?B?TEJ0UndiajU1VWR0ZXZYQkZxUW1UYU5YT09kOExrNmpGTFNxcTRTMTd3a05w?=
 =?utf-8?B?NSthbXJHazFuQmNqOXJDNCt5d2trT2FiSisvdm1YbVVjbnRGYVRmMkNWVm0y?=
 =?utf-8?B?VUZDN25CVWZPYWh0dzMrK3ZOcERmbmpmajNjenZaT1J6SGhiTGxjZVRrMlBY?=
 =?utf-8?B?dWV0ZXFNRE5sbVNuMFlQSGlGMXRFT0J2UlBIaXEzSW5jd2Fyc0pHaUhjaWps?=
 =?utf-8?B?QlZkV0xsSURid1JoK2NLdTlaSFFpWHJnQlNvQ0R1REJ3Sm9JMERiLzRkaFJ1?=
 =?utf-8?B?WFhUNFJxdFdkOGJOb20vbWhUekFoUU56c2hqeGdjeDlCanZqS0RocUVJSk94?=
 =?utf-8?B?QTRQcEwrRFVCZU9uaWtrQmQyNmFjdXdHMjdiQStnWnhNUnVsbFY2YWtUU2xq?=
 =?utf-8?B?V1FTMEREUGpOQjBuS0V3UzV3Kzh5M1dBVVNJUEUraXZUTVpRQ0JCR285QWVp?=
 =?utf-8?B?MkVBK21GUER0QnZqU29yeGJHQVUwQ093bEZGTzh6OTBPQVVoaVI5M213MGMx?=
 =?utf-8?B?YTdVZXc1WkZiaVVQbGlpQVRhM295ZVg1czBuZkZGb3RNdnI2OXVQeDM3UEp2?=
 =?utf-8?B?T3FYeUJXUU80N2dGeGhyTVE3dXpmVGtuWE5zdWg1Zjk3cWJ0T2x5bkxKVmtn?=
 =?utf-8?B?YkNmdzRBVHROMUNORHFuclFRNGh4aFpZNXA4cE1oV3gyOVN4eHE4Z2hYNmhj?=
 =?utf-8?B?S2trcFI0MFRBUVJrb0xYdVdpTHBnYXgzTU1yOUdVWTN4LzNEa01YM3YvY2Nu?=
 =?utf-8?B?SXU0dy9GbTNKeCtjdUo4M2tZeWZIUW5VNmo0MFNQQTcvK1VTUHZGTnVlaEFW?=
 =?utf-8?B?WXJzelZnaTRDU0NzSGtRWmkwVHl5SVQ5U1YyaFdHYytldVNzaVcxYTJ5ellq?=
 =?utf-8?Q?TsQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yi96NWhOcWIzRGZkYmlGSEpyMG82OTEzWEsweXJQUmdyMU45V1YyRGJzbTZZ?=
 =?utf-8?B?UkJhYlcyaklsS21uR2VVd0trazdEcjI0Zi82NEVzSUQ5NTRQZUhkZ1BjUkFN?=
 =?utf-8?B?VXNWMDNkNTJDRWxiZ01qRUJCM25TdkpBZEpXZU8yc0dxY3RNUHkvRVA5c3ND?=
 =?utf-8?B?cEFQZDdxdDA1eUtxeEVQQWIvMHlVUkl0MGlWeE5BTExDZTRvTHVBQzZuMndT?=
 =?utf-8?B?aTZFL0M5R09vOFY1UXVUVU9DditYVGtiaXE2NE11d25jN3pLenJqc3B0U1RT?=
 =?utf-8?B?OU04MVhRamcxQnlrcmFoanY1RExsMW1RQUorb2h6NWE2R2l6MHFNNWV1akNX?=
 =?utf-8?B?dmQ3STVLMUlONWFEeVpNUERKNEQ5aGRucnZ3U2hkTURUUmdlVDJ6UGtHYld1?=
 =?utf-8?B?cVZGWVRacXdQSUpmN0tNYjN6cmNndWhRVHY3bnZuVEE2OTdQTithZDBUYzEy?=
 =?utf-8?B?TDJMTi8vZlJqWlhWTEswU20yTTFuSStwNXFVS0Iwa3RNT0ZpczU5c1ArdVNI?=
 =?utf-8?B?aW5DMDFDNHRKS3pBWnkyRmlmK04wbkIyOXVjMWo3VnN5VEZFVmFSZ2g1WVY2?=
 =?utf-8?B?ZU85NUJSTCs5TmtKVWhlbkc5L0VsRHAxdXMvUEdSdHRBeG1FQ3dqeGxsRWpR?=
 =?utf-8?B?NEQzcU1hNzVxSFhCZVNtdnF4M2IzTmF5cURnQXRuSnNGZzNZVjV6Ri82d2RM?=
 =?utf-8?B?Yy9YdXA4Z3YyQUdqaWFBODh6ZVdGa0thMytvVGh1TDRCU2k5QndqK0xDaHpu?=
 =?utf-8?B?WmxUVXVUazFSQ0hRZGZHS2RXYjMrdXlDS0x0UDUrWjVCNWxLaFRoTmU2WHFZ?=
 =?utf-8?B?eE8rUHBIeGZXcnNmV3p1TVRMUkxPVmJJR1BCM0RqOExHaVN5cXNtZDVXSjZq?=
 =?utf-8?B?amlKcEx3WjJIRWZvZ3d2cENlRjZvaE1HQ29oR3FMQ3VyOE5MaFRRZEV3aDVK?=
 =?utf-8?B?MDR5c0MvS3RlT2tsVnE2UlNZKzVva0V4MWI3ZEhHVDRkYjlWSzZNbUVjNWM1?=
 =?utf-8?B?aWZyTlhCYzVRdlJaV1QvQzZ4NFgvNGJsT2tUY3VXZ25KME9pVERZTHA0bmNq?=
 =?utf-8?B?UkpMSlkwME1DZjNwKzRxNU83bC9hNjlmY1l3K2hIb0V0RU1la0plOStuSDdM?=
 =?utf-8?B?THg0WEtoUHhFampndllIM2JUeDNxVHJibUYwWFJqZ2ZiNmJXSzFEQmc3RlFK?=
 =?utf-8?B?VlpLNm1TYzNrYkxxYUZzNk5Dak1wNnQ0ZXpUUmxVMHUxRVJVajRqR1N0Tzkz?=
 =?utf-8?B?UnVHVGxzMStsTkU4dE5XSHZRcUxrczJQRjdaZkhXek5kS3F1WUhsTEdxSXgv?=
 =?utf-8?B?emZGMmhJMWFTUGErS3hrMUpNOFFBYTJWSGJYRjV1MVJmODV6cDVsZTFnbFJV?=
 =?utf-8?B?MjZwZGsvZ04xQnF0SmV1Vmkxb0o5Umg2cGNDYU1NNWhFV1lINEEwMy9zSGhr?=
 =?utf-8?B?UnRZUE1QZjdxNkZhV3hqaE40b0JEUWwyaG9IUWgvZWduRmdxWXVLY2hqMVdH?=
 =?utf-8?B?WHFZaWRRdFVGS201RjFCb3VhVk9iOWYwdnF4OExlZFU0RDBLa0hvV0tXblFp?=
 =?utf-8?B?ZytXaHFFRkZSclFHNUsyMEVQRytWU2tQWVhmY1BHZWx3d1BDeksyb2Y4TGpC?=
 =?utf-8?B?bjFzWExSWVpNWmhmaXdtQStCdWVrMEFnOEpUZmFMa3FJMHlveXp4aW8yTDl0?=
 =?utf-8?B?b211WlNXSHRXak5WV3h0Y2ZjaGR6aHRjT0ZzZUw5NDJLdlI5dkI1ckUweHFO?=
 =?utf-8?B?U1AxenJCQ095Smc0Ry84UDI4SGlsNTdZMzU1UW95TFcrNUFqTTVMd3U2YWZC?=
 =?utf-8?B?M2NYTjF4bEMxWTJwV05CQm9ZRlVsT1lNN0lHK3Npc2pHMWFJby9BT2hacE91?=
 =?utf-8?B?eVZBRUM2VWJ3Ukk4MmZqd3YvM05RRHN2NG95S0t0bXgxRTQzSHRaKzdYWm8r?=
 =?utf-8?B?amNOUWJuQjhEQmNaQ1lkYTVHZVQ0U2NpaVUxNTVVZ21iSFNSWUtXOHY3VHlC?=
 =?utf-8?B?K3BhWTBteFpuUG16dU9tRXBoeCtMdEpNS2YrT29WNTdiTC9MU0c2UkE1TGJS?=
 =?utf-8?B?eHUwZjRESnhtd0phWDNBV2VmMmp6cHk3YUpIb0JLMk8vcWU5TVM0Zm96cCt5?=
 =?utf-8?B?ZE5Dd2hyZUVKNDdnVmQwcytoUFBaMTlIVXNEWVZRa2ppQ0ZJZHFWb3I3OFFo?=
 =?utf-8?B?d3FQZ25zbGVLRnJsNHpiWUZZQ01ZK0JzN08rWXY0dWhpOE1VRityV282TFhz?=
 =?utf-8?B?eURHVWVnMkpRdDlVNzBJN3lXMzFkWS85WU9YRDlxU2JlenhNYXhPSDdLTWNN?=
 =?utf-8?B?TDlERlVqZlBHdE1nTlBtaXJzRnRGcjVoOXZITUc1QXM1d3FOYXA0UT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yc5/idJM7hqw9p2NDny11wJqFE6WIKtBYAzJmwItkhsLy3yCnsLQ5wEe1/ZU2sl8OB/katDe6Y3EkI2Mr/QeLe+UwALCd2tnfnPTg6FeVYiGND9JR74oMKzlzLnywNXLF+lXktHh3DRUkx3GBuva8Py5px4ngJi2Xjouk+2gD3kdiGBmLxPCIFujzShgKnTu0M4KFNvRJk6XGKtv8jyBBOfGTVBXcKXaVkZ+eUI7jZ3lhdg5JxmhlDM3HqTDyZOSLUJ7UvDequOer5SDX9l5090gQXHkzTvsZ4u33svmP4sX9mUnR5uR33nPY2Qj/hDBroBxF2QHCw1rNv+jjG5KB7JxXJNXjauHL0DQhHG2cYT6pAmhWB++Uyo2IxLLm9X3oMRn9tjltMnIepnYzbhF08sKAPc7xK689R5wi9Ctltts0Pg9ryRRV6XdoYgH103SxL8KDEpatIIYLAvxaFXU49wq+o9NIvAkPj0+yweV4Bx9I80At7mwjLmHqGA3h7UuSJIMwmxFlb9IHRa9U/uqPHLghxRluVkx4QIQqu3BgDMrhzTkQhY8VdHr8gCg17lYU3g8rO1lNDC6+k+BJ6ylpowV3vdzqc9KrLPGa8J0468=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79438ee-53ba-4e13-ad9f-08de6f16bde1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 17:54:20.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSAq0kvq02/5cqkmtjagKAt08e5W9yO8ofdT4Z4MCW1G0Ewtj8RXuY2QXOiku1IgpU9dFgVPpdQOAaGfMgq8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=656 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE1MyBTYWx0ZWRfX/T1j67x7/rYB
 D/Nlvwd0uGH/pvJcXKIU6EVkwtbHQ5olH4uXsd8oSvNMPHeqtHJdUwluTl5b5VTZK+Pu/7PCLg3
 dwEN5crNWxAFTDp70mFtNRwWbYUUahEpQZL0aPFLZ8yOy6ts6bTWf2oC5YfEQ0TeMJ6gaHFQjmP
 qRpv9mDMrKBjXv3z9A+g1QLrWD2kIQcEtJ0EF8bNl5WrQ3U6gai1kY+A+AwcigqMad6RC18boaZ
 aiQvZ5hNz0YA3ff2yqm+EkY+gXbzSlXm5eSW8CRSe/6nQE5K4K0YeTSzjjCm5Ja1jnQ4qd5MY5O
 GARllePnklZCxeq2JtTHvTYdUri9zWHHK0WcW/rl94yL+gHDj7CbFDOeuIf8WwKiHWDFxeQwtXu
 PcXVBmGqs4NJR436QY9UsxVSF5uV1be3OAjQHYi2OgF81tuPkzo0iiBvr622T48KaCKfa2v/gb1
 KRm99QFTbQrsI7oh237oCtzCQx/1R9UOXJ6KeLPg=
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=6995fcd3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=UZJuxTk3215VcPhn4eUA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12254
X-Proofpoint-GUID: idiwFgdSm7EpTG3f73RqJitQZFSbbRR-
X-Proofpoint-ORIG-GUID: idiwFgdSm7EpTG3f73RqJitQZFSbbRR-

On 10/02/2026 19:57, Alan Maguire wrote:
> On 27/01/2026 17:20, Alan Maguire wrote:
>> This series brings together a few solutions to issues we have
>> with accuracy of BTF function representation at the binary level.
>>
>> The first patch detects mismatches between concrete (binary)
>> and abstract (source-level) function signatures as a means
>> of either excluding them or providing a "true" function signature.
>>
>> Patch 2 adds GCC true function signature support for optimized
>> functions; with that support, we use binary-level signatures
>> for .isra.0, .constprop.0 functions and represent them with
>> their "." suffixes as BTF_KIND_FUNC names.
>>
>> This allows for fentry attach to such functions, and
>> the "." suffix is an indicator of signature modification.
>> The feature is guarded by a default-off BTF feature because
>> older kernels did not support a "." in a function name.
>>
>> Patch 3 uses Yonghong's example program as a test; compiling
>> with -O2 we expect a parameter to "foo" to be optimized
>> out and the true function signature should reflect that.
>>
>> Patch 4 documents the non-default "true_signature" feature.
>>
>> Patch 5 is Matt's patch to favour the strong function
>> over the associated weak declaration.  The other patches
>> are important prerequisites for this as the patch selects
>> the binary-level function (with a lowpc value), and in
>> the case of optimized functions we were often selecting
>> the .isra function with optimized-out parameters.  Because
>> pahole did not previously detect this correctly we ended
>> up with functions with signatures having reordered parameters.
>>
>> Patches 1-2 help avoid this by better detecting optimized-out
>> function parameters.
>>
>> With these patches in place, ~20 functions are omitted from
>> vmlinux BTF; all these are "."-suffixed functions which
>> we were not noticing had optimized-out parameters.
>>
>> Experimenting with adding true_signature to BTF features
>> we end up adding approximately 500 .isra and .constprop
>> functions to vmlinux BTF.
>>
>> The true function signature support here will also hopefully
>> help pave the way for Yonghong's work on the LLVM side.
>>
> 
> I'm planning on landing this series shortly, so if anyone has
> any additional feedback/objections do let me know. Thanks!
>

series applied. Thanks.

Alan
