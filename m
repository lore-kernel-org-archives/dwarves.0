Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CD1DFCB
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812656; cv=fail; b=AIrr9rtbSZHO/iEanS6qh/AeJw3AH0gerxUH1mnNlwtFe6gxXtps0zdSrpwLqRj2vAwnMsAO/MWTIIdyZu3t9qRa/p57w44wgjrJ4nhldwjDa0XjUhJ2tC8kwYjppmag8t5J4qvse/+debHNEno3vZAL52p5xpZm1X7D3G8RgZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812656; c=relaxed/simple;
	bh=o6FU+ZzwchBRT46ApofB7wmxeutTwOwWBkqMDaTXxcQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MNTpM6FDHaEOZvjEHoF9tO+QhKatW6lBwU7rjb63nQHc77J0i6/tz0p1to4eJbrSJEVna5+J5v6LG7uVZrnAXnWkHqNiQwTXmwvJpzXK74nKhVXKZC4eT81CMrMklrvreJHOvzF7jhHe9aRPctWWUQT9oFMMSteFdq2xTzcZfQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VQskacf1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tVyRJ5il; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQskacf1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tVyRJ5il"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491Ifsha029558;
	Tue, 1 Oct 2024 19:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=NXglqUsFemCODG3tA1KIYBro5u14C6//zE8IQpT2YGo=; b=
	VQskacf1oi4uC8xuPQ7L+Ci/9p4peRKUNxPNvXsgfGZxZsVMbCiHyMad+ES0u2Ps
	boNXRrCOOVQO2TEAxocIg5ZR3ZawUltJvI0YagaNYIn9cEVV41MWv30W4MG8cvnY
	zgEEanzEZGwEz4+WeVIXn8dfKc8EmSt4uDxH5W1e4E8iFrcd+hhbSwrwFlAhRyyM
	CfM99Q77jWjOU5Po5jlDILl0MaFxwRgFBKyeQ7kRLlhZyUphZcLwgVmt1H9nRCsT
	yKrvPT4vd9LksdrJwaVRp/hTj1QTih2DJ5Jxedw/lutInCfVt44p+RkdHpjjLX6u
	OtqWnzg8jrTv2EIdU0TP7w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9ucqbae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 19:57:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491JqNL2026418;
	Tue, 1 Oct 2024 19:57:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x8882dmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 19:57:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVveKBjk2B4mfCRRionsMAID9yvPRamwkTWVTJ+xvmcIiVWDQAHyr1Kp3soP11Jkikh4uErYBJ0wiph1BpmQX/W+ZuwZhXNlr1L+UZjyI7BOhdcyTzHKOzbvV+ZA6fYMOVg5FO+cuLTiMC0aH00ojgl7byR54s0piZeuCxTQod9G9kub8Jg9hEFNrzIKW8Xv5rOdv44MozvGlCphaPydwiukCctKFjWAcsAMM8qAYT6FV0meM6WAyenCM7Zc0fMtAvf7Xwa7zz0fXDQwg9zdzRd6jq4eaDns6w9FHasf8r5osGfNJKSevbxGHK5cXFnFg1lUeJowByNALvrE80DXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXglqUsFemCODG3tA1KIYBro5u14C6//zE8IQpT2YGo=;
 b=GRr+BwNWBVR5b5tUzBxdzIRUNu14K04v17G9ToTjl18FUj02YQGsHf9krRB7jA1b1anC4qpCwdwk0lCzjCfviUHjM1qALvrcnXC0L0SWRUo0gezoRariDiNKQiisaEUDd0Sm9mb7CgDi+nE3o1/nX1Iw3BiDzHgtMLSVAERxaQ8cvvqBvqs1tLZvhw2qtG92tTDbBOqIr9RslI4AuIPnwOkqpKjl1s0BBX3kdKpxzzn+gdjlGgjA37c83K3zoAP9NAzPeSXdsUXZGf7mcHMGaCT5OD2R0ZvjcyQWR0ck2GESkDdPPsuDVzel+1Cxsdl9P2jK0Sc7p2/RdgMpKqEYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXglqUsFemCODG3tA1KIYBro5u14C6//zE8IQpT2YGo=;
 b=tVyRJ5ilQ+l6MiX/flWJkFjQqdmY17EMlFG1oytNEh57cL6v05PPtYyCwSAO7t6mFhK1a9b93K89EWXFb2kRexyPw2jjLKNodf/LT/L5sl5ZA0wHbrCyx1pN2+u8C70lI1pitzlkdSvenJwmSqzDDSt4XV7Qfkcm5InwrfBz9BQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB7193.namprd10.prod.outlook.com (2603:10b6:930:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 19:57:24 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 19:57:24 +0000
Message-ID: <3dbb7240-4476-4740-aef1-c026231b1b7b@oracle.com>
Date: Tue, 1 Oct 2024 20:57:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] tests reproducible_build.sh: Try first to find a
 vmlinux using pahole --running_kernel_vmlinux
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
References: <ZvxP0n0W5b-5rxA_@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZvxP0n0W5b-5rxA_@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 54713346-9690-448d-bf2c-08dce25344c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1Q4Q05oT3hsTVcxU2dIOWJ2TWJ4YjdwVS92ZUpsbDlFaG1EQkpxUG0rcVQx?=
 =?utf-8?B?RlAya0ZzTkkxV0I2QjlwMW5tMTJWdzJOSlAyR0E4bHVJUDYya1BOTjN5djB2?=
 =?utf-8?B?UVppT3hDWHdaVS80MVlXTHlyRFlwTTdqV3Y1NmM0bWlRSk1ldFRhYmRwVDRN?=
 =?utf-8?B?UCtSQmhtRjQ1ckNocGtTbndpK3VuNjhXb3ZpQk50V1FzUGpjUkxweDkrODEw?=
 =?utf-8?B?ZG1FRzJnbkxJMUE3UDk1OTRzSEJyMkZjOSt3Y2xLMjh4UXYwRTdteFoyeFRH?=
 =?utf-8?B?SXZnOTc5bGRtY3ZYWTZhV2pja3krKzNzbVo4WjlLbWsxaEdBUUFaK1FlcUVE?=
 =?utf-8?B?SDJsTk5wNy9hdkFudTFYZ0JPelZvWlRPc1Q4RXdmaW5TdEJ5cGxlU1RhWFlS?=
 =?utf-8?B?R1NwVDBRdTR1U3NlNGU1RGVNYm1oWXdObTMvdkE2d2VWcENicERFZTJCOWZk?=
 =?utf-8?B?UTV2SXRIVGFzd0VmT0kzTnRVUVZNbm9PRzFWMGxYWHVaZnNzb1pGMDNtQnM2?=
 =?utf-8?B?N2RFekpuOEVxWDI0QlZ1clZtZWE1bGwzcnNTOXZqbXl6ejlIeXZnVjFWS3du?=
 =?utf-8?B?Q3RQaFdZdVJYd0dsZjA0cEhTMnRXU3o4eXQ0UzltVFQyT0xMOXRmd0lJaGRN?=
 =?utf-8?B?cXZXWGw5WnIzNm5SbWo1Z2NMbWxmY3Y0ZkNHQ2c1cEczN0xENFdiMlJpOUFK?=
 =?utf-8?B?SkJnbzFkbENVNEhScXJMR3RWc0thQWtVOFA4YjJNM3NsMFpBejRqZXdRNk9h?=
 =?utf-8?B?Sm1pbXBFUnh2WmM3Rm9WOGlHVk5uSExyaG0wMEh3VW9oTmhVV3VlTzgvZ0lv?=
 =?utf-8?B?cFVzTnNibG5Gb1FZL3pHY2NQOTFxdlRGdEplaUI5WnRTUTNwcENXVU5MQ1Vj?=
 =?utf-8?B?OWt5bG9kU1Fxb3RybTlXTjRFOTM0WVBTdk9GT3YrTXQwOTRFa3kycDhhUkd2?=
 =?utf-8?B?R3h5eEl4cC81Vm0zVEY4dVlFNmdva3ZJWVc5aEVyck9YMytia1MrYXNkZnZ5?=
 =?utf-8?B?ZkY5QlVpTXorYWFXR24xeHRDdnMzZWVCcmhGYzROb25qVFBlRmRoYXE5dEJ5?=
 =?utf-8?B?MzNKZDBxUTFrd3VnWUJpV2dMdUlYYmdUSGp3Q2drQ0Z5ek9FKy9LWkNWNUE3?=
 =?utf-8?B?K3I0cjhja1JOYitod2Q1RWZiaWpGYkg2cGU0eFJCdGtPei9EVmx0TGFzVVEy?=
 =?utf-8?B?ZExXWXR2bGROMDV5b2hqM3RrWnZscVI3STFiREYza0ZYUGxjb3g2d0IzRW5w?=
 =?utf-8?B?R1M3OXJmNGgxZW8vVVNidnhsWnFhMWJOamliK2J6T1llTHNGY3pibzl4d0Rn?=
 =?utf-8?B?dFpkbjFUdWE0N2ZIOHZSZHNKOGZGRWJjc2toUGI0bElhTmVMMWRYVlFUUnVB?=
 =?utf-8?B?ZmRCM3ZnbkNyaUMxdlh4Y2ZqZkovUWxWUS9hMG1kalp3N25pTjc1cUN5TG5h?=
 =?utf-8?B?bFpWZ1k0bkxCYnU3cWcxWjFCTnA5bnJkcVQvRHV1aVBBRzJoK0RkbWtYRVpx?=
 =?utf-8?B?ckVzWlNWdjR2eS82T2FETUNSZmV2OHMxc3RsenA4a25LZlZEODl4MTNvajZu?=
 =?utf-8?B?YWgwN1ZPOVl3ay9BdEJqUUJRaWhCd2dJSE5sN2hjUWNONHlrZkMxclVTWTFu?=
 =?utf-8?B?Y28yTHFOZjh2SlJQcDBNeGtCRFdqOW1SS1IwYy9QRStWV24zSDRocGdGckla?=
 =?utf-8?B?bFZObVNGSmZySUtIM2lSYUIvR2ZwVlBZYjFob3hhUm1pbnAwME50eVE3YVFB?=
 =?utf-8?B?ZndTWkRZSWwxeXFwNDNGa09ncEFxWFJ6QXZnd3NuTXkrb3R4MUdmWjBoaXBv?=
 =?utf-8?B?QXhvK0hKSllQWVFzdWdPdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVRnd1JaeWpPNXhsWWlYMm00VHVzTDlCRy8yZjhYREg3Q2d2SFhzRVo0WUhw?=
 =?utf-8?B?SEFRc0lRSkpMbE5PUVZzSVpIWGEvbGsvZHQvbS9keFFNSmtBQUsvS2tGSGEy?=
 =?utf-8?B?ZjFjN1k2elpNRG5lSUhTZ1FiWU4xUjF3ZXZLeEpoR3Q2azRDSFlPWW1tYnB3?=
 =?utf-8?B?SHBkZWNkYzBTbUN1YmxTY2x0aEdCbDV6NGNTZDE4eHdtMERqcGFCdWdkMUZO?=
 =?utf-8?B?Vkovb2dIYXVEcTNoR2E5RWhXeHhOenphTTNlc2xtMkt1K1hjZlE4UGVpanB4?=
 =?utf-8?B?aUpldmlMdmtIWjlGdERoUXBObjlXN1RlRUZYWUEycE8waUdYUHpUS2w1cXVN?=
 =?utf-8?B?SlhVYU5aNnRpaWcvbGpDdWcxOHE1RGVqSDR4cEZrMmgwNy9oWWJPeFNPcGdJ?=
 =?utf-8?B?d0V4VDhiVytiTDJsOTFsZHBYSmd0L1hha0VWWEFjQ3NTSGlBeUVKcy9Sc0h3?=
 =?utf-8?B?MmxuSzVvLzREcENFR3A4M3RVd1BHWUt1MUE3cTdSSmYrNzdyTGp3RThESVJZ?=
 =?utf-8?B?ZzUzcHNXaTUxaml3VlJVVEhWbFFEVzhITDFHNWZLOXcxcnhiZUN2V2hIZmtL?=
 =?utf-8?B?eElhakV6ZmFrd3JaQU03UVZCTCtUeFZnQzNuakMxVzJKWFFscDJLL2xkcUc4?=
 =?utf-8?B?MlIxYitmaUtiK0tFMDhZQlVncC9mVmw0amJ4SjdkdWJ6b01QeXpYeUxyUTdr?=
 =?utf-8?B?Z2RJalpNODdldUJ4NURBZEZpeFc3dVIranQ0V2NwWTRzaDN3SEdaVnpyU1Ri?=
 =?utf-8?B?dHJ4MG5jSkVIcTdBU0xBV0hlRmk1eW9uMHhMUERaczJ3eUEyeWxNV2h2WVVB?=
 =?utf-8?B?c0djb3kxK3V4Z0RycUplM0xJVTRyZXZ1VVVIUE0rbXJaVzhFLyszdGFKSmFl?=
 =?utf-8?B?NnJiZnZOT0lxdCtWeFZjSit5WTdGem1vNy90SjFhNVcrMjJ6UXRWRE9SL1gr?=
 =?utf-8?B?KzhPMjkwQStKdjNhZG9GajZpUDV2YUs1UllwWk41QTlmeHBKMmlJRmJCM2hW?=
 =?utf-8?B?MGRQbHhUZHNjeXFPS1BmN3RnRk5LdCtsb20xckVrcFBqTzdlaE9FbUttZmVD?=
 =?utf-8?B?QnRSMGdDSnBaK3U3S3dtTVpyY0dSNytNd2VyN1BmL3A5ZXpuWHpqZGV0VDBv?=
 =?utf-8?B?VnNWVjUyeVNNQWJvMFpxNCtlRE5WWmVUTzdTNDFvUmRKKytEdG1jc0UxSmNF?=
 =?utf-8?B?Nnc2REtWODJNbW80WCtxT3NYWVZ6emp6c1kxYnlPaDVZTFhlVjIyVmkyWjZL?=
 =?utf-8?B?MDJBZUpzVGJUZnNIN1k5N0ZSZnU4Rko1enlya2J3UW9aM3JPang1dFcyS01R?=
 =?utf-8?B?WnlzRk9qUlhIN2NXYWhjOEs2Q3lPQmsyVGlTN1QvNm9vOXVnL3RkVjhGN1RN?=
 =?utf-8?B?WlhZU2dQNmlDTmtobWFzY2FIaHFmeHNHRUNGVVhaZzEzWDNoOXJpTk9OTHFk?=
 =?utf-8?B?TGc2SW5ET0djVlpPcnV4WUU0S0JsSXZCN0xIbVh5MXFDWkszZFVnUlVuMkFv?=
 =?utf-8?B?QkF4SmVydzh1T3htaU5JLzlhZXR0dFhNOEZjb2dId2liZXREWk5nK0dBdi9p?=
 =?utf-8?B?d2p0QXpXN2hQV0d1U0FDdGR6K1FJd1JYRFRrRG5FbHh0Zko2OWRndmlCTHlo?=
 =?utf-8?B?OEVyOUdoQklYdzUvM1dxUVhYWE52RUpTb21LeDJSUk9NSVpMaS9veDNsWHVF?=
 =?utf-8?B?MFRhcHB4N21ySmJqeEpPTWFFOTUvZHZrcEhYK2JvKzZ3Tml4eTVPYTdLMnNM?=
 =?utf-8?B?RXJ5d1cxVytjYUg1YXMrSzdGdVZQYVdxb1pETUZ3TjZBWlk0bzZCT0dvNzlT?=
 =?utf-8?B?d05RSERDbXpRUGxibEpSOHpYa0IxVzNzOUF6bUUwWXgvbmJ2R0wzZnhLL2tv?=
 =?utf-8?B?OE9USjZZOWN0aGl5bmcwU1Mwb015SmZCTWRKYTI5UVFDSENlYjVudEFUcWtC?=
 =?utf-8?B?VHdiWXNMTGZIbW1TTTBIZEtDZTdmQlRhOTlkMUVRc3gxYjJzRURocWQreUE2?=
 =?utf-8?B?ZURsd3FHSVZGVFQzRUdwdUNZOVBNS21JNG53eWR1Q2RMcFpOeWNOV3N5M0lV?=
 =?utf-8?B?a3gxeURrRWdLbmFXVVdydEY1Z0xNUndPTGI1WDNLWk9qd0RhWGJrMzlmOWpI?=
 =?utf-8?B?YlZ4MDRMSHQ3bEU1YTlXMnArUGg2bU8rdUpXVjZJUTNQNHE1eE1oem0ra1B3?=
 =?utf-8?Q?bRBuanrQQJ31qTNvvCME0F4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DgdyzGjseusMGrMQys29aHES9TVr9K98gWWEEMBLKsI50bGXfzHIw5OYYdSkUKwM4+C5D3ridI3NSZeV3N7J6VVLmI4vnfboKZ3F5OaQOm/ltVkaVRAWBu3MvcBlfD303+a3tEt1q1HgqnR5hLejwgefgPfitNp+Hhjeccop/DC1LnPW5XbSSZfdPt0TSOei6ffqJwa/mPchYCf44F0nfUKC5fiTb0lf/c1kLStZ/9O0iYqXqun6DMhyPT8mx+iFAol53S65CqWSTVi84f7ibbykZxBSmXSG1CMS9OzszkM/LciODUAt9e6caXUCy/HCAbsJSVVCP0X50nOo+IQXG2oAiLUCdCfPpNRJaprtv8G56cbo7mJ0kZ4G+aWkiQXTpOCaPcu+JjW/nmGYmgcNZyucbOLSf3BgOwdLWDVIrX8obL29aOVtl5FY3XFdybYS/yi/jUIH+O3Cc+2SHUmxwAohLjxZdj+V/GRwJ4F0GDge4E4o6GII/upojmNazyiiQOeLZGDnvEs+GUomSamr3mcY9zOfrbVXtHu7e0/sZ7MqdCb3XxfnaGnhoA3QuHSy5jJAp21iWwBLctCqacgYZCak+mgiZ7/N1jVguGrrNew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54713346-9690-448d-bf2c-08dce25344c8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:57:24.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScHuXtGZfWtYuoSyFDPL4G4T0VxwkLFFcX2yC57A4Ebdce7letk70SBPEDXh86oFO+SnyH8Z5EDsNl9IrGeK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010130
X-Proofpoint-GUID: HYXkpjccXMSN7viSs_Oli3D_BDQlYNgq
X-Proofpoint-ORIG-GUID: HYXkpjccXMSN7viSs_Oli3D_BDQlYNgq

On 01/10/2024 20:38, Arnaldo Carvalho de Melo wrote:
> Otherwise it stops working when called directly.
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tests/reproducible_build.sh | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
> index a3603798a26de94c..19ef22708bbc969f 100755
> --- a/tests/reproducible_build.sh
> +++ b/tests/reproducible_build.sh
> @@ -4,16 +4,12 @@
>  # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
>  # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
>  
> -vmlinux=${vmlinux:-1}

sorry, my bad; this line should be

vmlinux=${vmlinux:-$1}


> -
>  if [ -z "$vmlinux" ] ; then
>  	vmlinux=$(pahole --running_kernel_vmlinux)
> -	if [ -z "$vmlinux" ] ; then
> -		echo "Please specify a vmlinux file to operate on"
> -		exit 2
> -	fi
>  fi
>  
> +vmlinux=${vmlinux:-1}
> +
>  if [ ! -f "$vmlinux" ] ; then
>  	echo "$vmlinux file not available, please specify another"
>  	exit 2

