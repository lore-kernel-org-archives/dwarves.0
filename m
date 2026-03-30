Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F9382383
	for <dwarves@vger.kernel.org>; Mon, 30 Mar 2026 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861112; cv=fail; b=K+itedn66AVNVoFKJTp/lmrEiAM8mvcePqKrlXzljZHLkGGPc59vCiYUFcyDA5ztzaCIQq4BxHHNWxapWoywV5a0P3AMOFz+8iG3ewQrG6QNebA3wqzGMuD5Z1uPZUS61bk1pD+VWP77WuUgn/QLWBHaReeF0PUazq7Zt7fz2mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861112; c=relaxed/simple;
	bh=oabPtncTGK9unbyUsJ7yiL5JuD19AkLJXQakgIbrNf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LGaiZ++JCnv76p4jTqHGb3FRjC5YCqbGEfH+YZ/NSjeTmKkKlA4UU+LzCUL8B7cIj+4ycOkllD9NyKcEPKol+RXE0jyTp7TBoCWAEUk0K/vtLyK55riHR5ni8LQUjQE2pEAklRpa7g/HGrbQNiAIm8Iz/x3YCQSLDuzPftZnds8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bU9SzUJi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f7NpnrM2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bU9SzUJi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f7NpnrM2"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U0N2PZ514361;
	Mon, 30 Mar 2026 08:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hk6t+dlUiLKLIA2U/d7DdC6bkXGAAPEwCBqcNMR2000=; b=
	bU9SzUJiqypQ/EcWuXeABPmn1FZMZjIjeydoshu6pU1MYSXOwI+Dm2hP0Uni7uWI
	4lW+RzRfRdSl1fdPWfMp9w2nF+vuWll09x6a1+WqFGP4u2F7H+xjS5iih+rIUc3h
	z8T4kZwYvdCGF/lSnx0IGYK8zW0MlUvYrxbTPkEZ3eF2YDaqU8VfgCn8htIFFLzz
	1RBjJ/E7FmN7BnJ9zPgmcTsTTjpCgLeSiO+lkQM2JQ/m5xbXCNWSsi5ff95j87oP
	I1ZTtYYkSBp0vQXZ2B1u26DOmXdhR6EDad5gejE7xw/lfYNQRn5zl2GRpC4eDVuk
	GB1hiAVnIHVUM0AcmH5L6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d67hq9qx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 08:58:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62U8JmNi019356;
	Mon, 30 Mar 2026 08:58:25 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65e8f7m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 08:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgoL6FtXBxX4w0PcZjHe5oU8wGnGTMRG5s0Z11KtL/I4Yhb/h4V42Qou0RkH+HyVy3QKzibV79XvFIQd3V+tM0Mx+u/ifPtLJCEAKRS5i0E3zsuNOabMwq2hpIdUB37atw2ru0ve4uPIiVVLvBWy2s6YdSzdp8zvABfoKfy8hD8E6glNvK5KtgxNzCsnr1tfs5F80i2M5Bj6/1o4pJ465Bac75kANc2lteQDhTRIh4RwJfhkiwopkkKaP4uIyoDwLS7wHjJpUx1/slt6Hha79QbggSSnNxTyygpy/YoJUYw4laO/xnQ8x2eaIs1+NaD9Ch9MJrfUF6rdFnDESV58kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk6t+dlUiLKLIA2U/d7DdC6bkXGAAPEwCBqcNMR2000=;
 b=MfAWtNUD6q/3qiKM/9s3zL4HuVT8QO4AUMAswmEtzPgQYvQnNXccmbwzE3RJKNjjxE+Sg+MR62ixJKMpcToMKSO5HvkeRtrM11mSBqZbEjwFsCzyF/opuNhXbj8KtZUJWX/z2lGN+cLWiNv0eBQs31K59prmWXw24XPlNUmPP9P1zDSp1qj8n5eXEEqvf27X5wCVVZtsWKEQjxNwSeHG5YSQ0tmsHmJ4gmK5i6Ezi3W0gAkXFEcbXpgDBUfwablu3LjWf6BV4dARzmMB+1KkwjNLRxjjvSaQN+YQfzbnBR7944v1/0W5ShBkS5tgYjeIgIrrkM5AVdb1eiPUmmymkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk6t+dlUiLKLIA2U/d7DdC6bkXGAAPEwCBqcNMR2000=;
 b=f7NpnrM2HKr1tRaTt+4mJEMLO8AafwB2VPz1EGAEVtoml8f+BDucVNE3V3TfPDXVHx8w/b6vW/rLYpi7tThQSQXc9gAj5b6Rar+bdFeMJwUMOz1x7yFAyO2pZ00c2MvqWc0mCBHkiFQsUaDRxPcFHrAA1u/c67vLEKrO21QariM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB6170.namprd10.prod.outlook.com (2603:10b6:208:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 08:58:22 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 08:58:22 +0000
Message-ID: <9bc30199-be51-4825-82de-4ac28a1f9e97@oracle.com>
Date: Mon, 30 Mar 2026 09:58:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dwarf_loader: Allow forcing the merge of CUs for
 solving inter CU tag references
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20260323211533.1909029-1-acme@kernel.org>
 <20260323211533.1909029-4-acme@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260323211533.1909029-4-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR06CA0052.eurprd06.prod.outlook.com
 (2603:10a6:10:120::26) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfa7e39-267c-4026-7077-08de8e3a7ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rtiwbF9FN2eHkew7/0fdFf9AZW+Yih6xrkeYdnyi2udYiEdFfB9FvK8t1rXQTb2NPV0rxWlxBA2j9nV8caRPzX5Z7otxohwsk4tkJgMhySQ3pVU5RlcF4J8d7NdbJUH6jP6jP2s61OVJ9Ka3NoUAIlq+sMyKL2D1nLMGXb0PBIFICfVzfG28L5sW02JKPePq4jedaZx5AcxD+8M71MrI/+muVFm29Lu8207KvSHSasQsiK4hgxKyb/Daih77B8m5DpNf5zI5XKGePLuL5KvXifGGUmSzhr6J1HCymUt/WdTKjRaYFc6xFYRoh1r4O3m/dUiKbTL+aFWvLaUPXZoodLuyNuB9fAE63Ce/cmzWSOrvBytU7Vt8PY2eVxihm75PFqi+XYj0NxI/qAjY7UB6tVmPB1+iVwAk87xo3NPiunO8JG00+rGCmJtvZ1ivMpTMRsE1rJug54WxyKzewQjI75uT6zmEPwhODA4/YepRXL0wX17rcVypRM3gONeUFxhfN664/dZE2nhK0aBOiCG/gg0AyZP/n1nENiJabCi5TKDyyhGnLbWwkRZ8QDkC7BxzvHa5RHN6ADmOM2iQst/M1QnehVm8ESTQtOB2y8Lyup67lrBkXXgTaSGMiXfrhfpA2oOBa8GhgujdY3kvTS2rTl7Lytc5/28l3rCF7pm2Hm2uWzFdqvC+/AE3bodlk7+UJNzHPkHVmdwW77ujpMBlzHrCkKSJCD6L6Ms0TL6h91w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qys4M2JkS0VaYlpKam5LMCtsa05nT1pCRk9VUEFJZ3M2dkJWOGk1dXpHSmxu?=
 =?utf-8?B?WjRTU0w5bUpQOE5tckdBTG9Qa1lGTUg1UkxmRGtoK1JkSTZRSnY5MlIxV3dh?=
 =?utf-8?B?ZXROL3hxZlpuZ0JNZmVOS3FTNEc4OXBvbEY4VnN2TzMzQkM4aWhtTmNOcWow?=
 =?utf-8?B?S3J0VC9Sd3NUMjVzREdlZmJrRncyb2VFWWtKdDFldVdPeDUyT0pkRXRXejhj?=
 =?utf-8?B?SnZKSW5La29vTHlyUDJla0F6ZGdOSGIyWlpxSHdJQnorcVhXWjhEZW1mZlhm?=
 =?utf-8?B?Nko0emNJR05UOGxyU2U4MzF3cUtmd0JaQUE0VzVBOVBhVEp6cFY4c2hYemtJ?=
 =?utf-8?B?RzRJSzBWb1ZIRXlhVldSU09wNm5Ca3BaMzY4a1E4b1F6d2hxM1pQS0JNb1g2?=
 =?utf-8?B?QmxTa1VWQkE0aHg4amF6K2dYalFSWFZpQXJod3pHQzZNdXoybEYwTG1kMlda?=
 =?utf-8?B?TGtrSjEzZ1kyakpoeXQvRFlRNXFaeUlvSkpZVUgyQVhYNXBIcWVmQWtQZXF1?=
 =?utf-8?B?bFB2RGxCNUNyL1NKenRUa28yZXZYNFRXZmErOVAzNlo0TkkvVlBKTElFb2d6?=
 =?utf-8?B?WjluSG1VUVdDb3JmTHhDV015S252a1VKNG0wd3gwQWUweWFXTCtTV0tHQUQz?=
 =?utf-8?B?SVlUOXg2RXBwc05uSlUvN1BPY1NYbHVJYnU0V0lqV2tWR0VuKzZVNm0vUUZL?=
 =?utf-8?B?am9BYXlIRy9Uc0p3b1RuQU1wVldsY0dwMitBY2FHZ1krc0oraDdURVRLZnpt?=
 =?utf-8?B?L0lHTXNBYVVSNC9WZ2pEcGlacW4zS2RKQU0rZnBkQWpadzVnM3V1bXNaRXJO?=
 =?utf-8?B?SGZTVHBEbXZwckl0MUpWU2x3NXhNZ2dQbXlJRjVBYml0Mm1oS1BqTzNGWDBx?=
 =?utf-8?B?SHlHR1B0Y2NVanNEM3RoQ2MvRFFMdGpsbUNrd0RjNm9va2R6Vkg3N1JYMjNq?=
 =?utf-8?B?Z3pVUVNUc0ZaMy9lR0FPc1dzeUlwdld6bGR5VWZOVXJIOWdteXZSM3RBR2l1?=
 =?utf-8?B?MUpqeWtKU3k0cUlFSklxK1c1NGhvaW52QXNyVHhPNW5vNDJ5eHJMNHZVNDBK?=
 =?utf-8?B?MEhGYVVMNkxxVzdLWTFSRzRYN1dzZTA2MlRwOHpNRGljTlVrdU1CRGhDZXBp?=
 =?utf-8?B?ZnUyWmxJRHZjUTJNVEo4YlFyM2hwUWVxSmdaMjgya2pkUEU1SE5iV1I4b0pi?=
 =?utf-8?B?OU5WOURzUFhELzIzZ1F3YTllUE5PVThVVVlSenNzNERVcC85RzN4UzVDazN4?=
 =?utf-8?B?MHFGRFpqRkZnaTZDYnVhNkJXZVFPME5PUStzOVY5MWc0YzM5QS8ybDl6M0Ix?=
 =?utf-8?B?OXNzTFpsSW0vcUZPT0lkNFlUYm9JRlNSTVcyTUpTNkhia205ZzV5TTJLeTVl?=
 =?utf-8?B?UlJ5NENJT0hIUkkvQ3ZSWFRoVko0VTYveFRqUnFTc1dBeVVPZGpxM2QzbFJl?=
 =?utf-8?B?R1g4T3hKNStITS9OKzR4YzBGUDgxbloyTmV4ZTA2Y1kySS9VQ2hkQnY2Nkta?=
 =?utf-8?B?VHozQ01SQXZ6dFNFeFVLb2RzbERBaUdTVzVGMVdXK1kvT1Y1MWc0NEZiUHpn?=
 =?utf-8?B?LzRtL1NCMjVyZUpJTEtKa1BJYzhKYUx4T05YcENER1VIZ3RSNjB0U3I1cTcr?=
 =?utf-8?B?b0EzNmh2NlhXd2dkaVdIL21kZDZ3cWpRVlRlZzZvRkpaZUJHdXQ4RHhab0tx?=
 =?utf-8?B?VC85RHVnNkhYUDV5SkpuTWU5UlFid0VQM0x5V25lWC8zZHpZTU82dGRzZ1JU?=
 =?utf-8?B?RGpGMGZMRGlNdTNBVDRSd1pHZlZoSVNDUWExeU9wQTFFSVdwa0h5OERvSmxS?=
 =?utf-8?B?dy9ISWZ5aXlvVjV6clJRVG92SEllSDRiUkh5dHJtdmsxRnZSL1dBUk1VaEtn?=
 =?utf-8?B?S0kyTGM0QldzWmExSVRmWGtqM2V3aFkrakw3cHNuS2NiUE9mU3F3WW1aamJD?=
 =?utf-8?B?MnRhS0pYWUM2RmU4aVRnT29BMHM2NnVOYUhGSkFTd3NZb1ZFVXJ5N0tpcjZh?=
 =?utf-8?B?WFY1cWRDdzZsNkcrMmF6Z0dLOVZheWNDaDIzekcxUFUzZXJEejRqSCtDQXZv?=
 =?utf-8?B?YVVuL3NFeldHRGRwNENRN0lWK0xFNHY5c2FkMFpBZ2VCMWhBbWRTNHlUdE9K?=
 =?utf-8?B?cURLbUFwbzJsNWQ4dlJLamN0dW14bUhGdGhXYWYrc0ZVOVEwSzhGL3Y3a2l4?=
 =?utf-8?B?UHUranh5WFB5aitUZU8rdXA0MFRWM1FqTmp0bVVUN1Fad2tzcGhKdUIyYlBh?=
 =?utf-8?B?bXBHUVRwS09ORm14cWxZS0ZLTTM3cHZZMG4yK0EyeWZwVmtYN0gzOTQ3R29X?=
 =?utf-8?B?OG5xVXNLVm1VZmR4YTY5amNDSDVTbk5FZEl0OWdBV0VyZ2FqTmVlUT09?=
X-Exchange-RoutingPolicyChecked:
	j1ll6rdOaAKDV5Etp9s61HPuUBB/JBYM+ngglszYPjKarduwDokSaVruRD/S7f6b+30OpPWkXbBi4NOi0vHHOkbt2Z0OB6jQGuPpwbC/yurUynWJsN26tVbR+24aa8rI+b2e/XNUmrZvp8SB6n2c9vK9rocxWktDyAP1iGYIXPdjiAvSZyZdX1kfsb1nOaQHa8nSJy2Soc8H6f1uaARXHdNlf+GlBaODCvGY25YpmOvCLP7CwIAdY13ilKRKuQt45I2rWKNAdYd9ALuUWl3ZZposAooPYQu/zwdDUv5rizAU4EbvH2zrx/7GwWRStgYC2rSOtlhMewnOtVfmHL4DSg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TlDE3tVYFkXQb4vQc2xpUGD9T+ulgFr5QMUqrk+9d4Kp5OA3WrCVfRvhDW9qvnL0TwGOc7VFN6FnQOqGFEuCxNymxRAF1H9a0jKGeGIsi0ZG0AUWooppUVerq8/ivuOr2nxBVrW7X4Vi2wc3YZ7CaRinco+CD5vw5p5BEUOMjeQvrtwhuP4pFxCnAWXTgjBTwfdgcj21vuX37d0fCuNa4FdI3Dj/hvBjogoHB5tghvCX2YEdtZxTr5ZZCshmapPcLlSvGwq2IT9JsFUC+TEONZjq4KmNpFQqGoYskxy3n8gliB0/nh77WaqpHNG3ZB+4nQ2BlkXFj3GqlIBcGXuYhlncvF+fdix6dX+afozwB/TagjkcvjQU2cpX4A7k2T8oXgk07gEKJh7YSB7LstU1JzMBNBl5TgjJSPwOMd3nHZ5tyy8LxqdnLKBP/1IyKUdSt8eiE1+lHfZqhM0FJedaWfEM6KHMFGluWVblTcF8i9erbC2TVgEfVM4EHDmslrRm9lf+uerGH7E6ftWcqb/Y7u4QmTqkWiBQSV0y4/y0PdqYKu5Je6AwxXEpskiI1lwMt/iZ/0N+u8SSV5zm9zh1tTVRPToMJAqGnS4vr+axk2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfa7e39-267c-4026-7077-08de8e3a7ec0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:58:22.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH1htXLURwwYbU4AM/OE+A1G02i+v6kddWHnkt0mR/DzrlA3V0P3PEZKF80GFreSzgCmuJD1ePdQn8N/NI8/Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603300069
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=69ca3b32 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=20KFwNOVAAAA:8
 a=Dgq0LjIVMPeLjEr8LP8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A9Z-rOkqc6LXo1Uj4fVaix8MEpI0tZCq
X-Proofpoint-GUID: A9Z-rOkqc6LXo1Uj4fVaix8MEpI0tZCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2OSBTYWx0ZWRfX5Gh/qWgxgBle
 zLb7goFI4ZPyMSLtw1v+exxkWyfNfKl2Wn8J53CI9feWcZthW2diEkrt0iMR0mUrdEUj7d+tYbh
 L5OHaqN1HD5ZRp25Qr2WRHwkeMyIT/C36fnwE+G4e4K9kDIv2o+kZ/RlmoNEVc+FJs5hqJ+Weag
 ZnfjaP7abSYxTPLZka1u708cB7KxZn2Gg4CeXOsEJZYKikH0MNnv2G7qAU5rFNW2Jv/+uLuzv/j
 nRHewnirQ+axr9qfmUoqHQaqWJSA/cQYA3a4HpAwck0JAmtRX2SwFhRvcdONJk/LLFQzgWYZE+O
 su29n/2JwOOvRqP7pbHLy8F9e9458tvz37o4E6N1qC2/6hYXUpI4oF2+gYwuYyrhq8pB0bOjBXX
 mYZ6o7bRn8Ny5szAhS8FG2FFpEE7cPC/XAUVDhE4gQelp6u2Mu6tpWvQV7tMgmeGLHHX5+EAygm
 ajBWuE8p8dxRttRwjBQ==

On 23/03/2026 21:15, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The Linux perf tool now includes some Rust code that then gets linked
> into perf and comes with its DWARF that has tags referencing tags in
> different CUs, and as the current DWARF loading algorithm uses
> parallelization and recodes the big DWARF types (DWARF_off, usually
> 64-bit) into smaller ones as a step into converting to CTF (initially)
> and later BTF, the resolution fails.
> 
> There is a case whe this inter CU happens, LTO builds, and so there is
> an alternative algorithm for that case, that serializes DWARF CU loading
> and merges all the CUs into just one meta/mega-CU, which then has all
> the types and thus doesn't have a problem with inter CU references, as
> the recoding into smaller ids is done only after all CUs are loaded.
> 
> So while we don't refactor the loading in a way that allows for inter CU
> while allowing parallelization, maybe by doing the recoding just at the
> end of parallel loading, add minimal code to force this CU merging for
> experimentation in such cases, getting back the regression test
> prettify_perf.data.sh to work, making it force CU merging.
> 
>   $ pahole ~/bin/perf > unmerged.txt
>   <Suppress lots of warnings when recoding DWARF types.>
>   $ pahole --force_cu_merging ~/bin/perf > merged.txt
>   $
>

Is there then a case for adding this as a pahole flag automatically if we are doing
an LTO build? If so, it might make sense to rework this into a btf_feature since they
have a better compatibility story; if --btf_features=force_cu_merging is unknown, pahole
encoding will continue. I realize it's not strictly a BTF feature but given that
defining it as such will reduce pahole compatibility pain it might be worth doing it
that way.
 
> With the current set of Rust types that are representable with the
> pahole data structures and then pretty printed as if they were C we see
> 12 differences:
> 
>   $ diff -u unmerged.txt merged.txt | grep ^@@ | wc -l
>   12
>   $ diff -u unmerged.txt merged.txt | wc -l
>   198
> 
> Of this kind, due to some types not being resolved as tags are
> referencing tags in other CUs.
> 
>   $ diff -u unmerged.txt merged.txt | head
>   --- unmerged.txt	2026-03-23 17:56:54.971785023 -0300
>   +++ merged.txt	2026-03-23 17:56:59.826872178 -0300
>   @@ -9643,10 +9643,11 @@
>    	u64                        __0 __attribute__((__aligned__(8))); /*     0     8 */
>    	struct Abbreviation        __1 __attribute__((__aligned__(8))); /*     8   112 */
> 
>   -	/* XXX last struct has 5 bytes of padding */
>   +	/* XXX last struct has 16 bytes of padding, 1 hole */
> 
>    	/* size: 120, cachelines: 2, members: 2 */
>   $
> 
> Now the pretty printing perf.data test case passes:
> 
>   ⬢ [acme@toolbx tests]$ ./prettify_perf.data.sh
>   Pretty printing of files using DWARF type information.
>   Test ./prettify_perf.data.sh passed
>   ⬢ [acme@toolbx tests]$
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  dwarf_loader.c              |  2 +-
>  dwarves.h                   |  1 +
>  man-pages/pahole.1          | 12 ++++++++++++
>  pahole.c                    |  8 ++++++++
>  tests/prettify_perf.data.sh |  4 ++--
>  5 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index b5a92160ecf82f74..de2e9b70c32f85de 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3967,7 +3967,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>  		}
>  	}
>  
> -	if (cus__merging_cu(dw, elf)) {
> +	if (conf->force_cu_merging || cus__merging_cu(dw, elf)) {
>  		res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
>  						build_id, build_id_len,
>  						type_cu ? &type_dcu : NULL);
> diff --git a/dwarves.h b/dwarves.h
> index 95d84b8ce3a6e95d..7887af93693ebad5 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -102,6 +102,7 @@ struct conf_load {
>  	bool			btf_gen_distilled_base;
>  	bool			btf_attributes;
>  	bool			true_signature;
> +	bool			force_cu_merging;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 90a8f4566de621d3..39bb53816f4fac9f 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -515,6 +515,18 @@ This is useful for scripts where it provides a way to ask for that exclusion
>  for pahole and pfunct, no need to use --lang_exclude in all calls to those
>  tools, just set that environment variable.
>  
> +.TP
> +.B \-\-force_cu_merging
> +Force merging all CUs into one. Use when there are references across CUs.
> +
> +This happens in some LTO cases and was observed with Rust CUs, where types
> +of tags (function parameters, abstract origins for inlines, etc) reference
> +types in another CU.
> +
> +For LTO this is being autodetected and the merging of cus is done
> +automatically, but for the Rust case, and maybe others this is needed with the
> +current DWARF loading algorithm.
> +
>  .TP
>  .B \-y, \-\-prefix_filter=PREFIX
>  Include PREFIXed classes.
> diff --git a/pahole.c b/pahole.c
> index e4bfb69de56ada59..05e61b61dddad8ea 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1153,6 +1153,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARG_padding		   348
>  #define ARGP_with_embedded_flexible_array 349
>  #define ARGP_btf_attributes	   350
> +#define ARGP_force_cu_merging	   351
>  
>  /* --btf_features=feature1[,feature2,..] allows us to specify
>   * a list of requested BTF features or "default" to enable all default
> @@ -1818,6 +1819,11 @@ static const struct argp_option pahole__options[] = {
>  		.key  = ARGP_btf_attributes,
>  		.doc  = "Allow generation of attributes in BTF. Attributes are the type tags and decl tags with the kind_flag set to 1.",
>  	},
> +	{
> +		.name = "force_cu_merging",
> +		.key  = ARGP_force_cu_merging,
> +		.doc  = "Force merging all CUs into one. Use when there are references across CUs.",
> +	},
>  	{
>  		.name = NULL,
>  	}
> @@ -2014,6 +2020,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		parse_btf_features(arg, true);		break;
>  	case ARGP_btf_attributes:
>  		conf_load.btf_attributes = true;	break;
> +	case ARGP_force_cu_merging:
> +		conf_load.force_cu_merging = true;	break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
> diff --git a/tests/prettify_perf.data.sh b/tests/prettify_perf.data.sh
> index 1fae95154d710aae..3b903e32da24b489 100755
> --- a/tests/prettify_perf.data.sh
> +++ b/tests/prettify_perf.data.sh
> @@ -25,7 +25,7 @@ fi
>  perf_lacks_type_info() {
>  	local type_keyword=$1
>  	local type_name=$2
> -	if ! pahole -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
> +	if ! pahole --force_cu_merging -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
>  		info_log "skip: $perf doesn't have '$type_keyword $type_name' type info"
>  		test_skip
>  	fi
> @@ -41,7 +41,7 @@ $perf record --quiet -o $perf_data sleep 0.00001
>  
>  number_of_filtered_perf_record_metadata() {
>  	local metadata_record=$1
> -	local count=$(pahole -F dwarf -V $perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C "perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type,filter=type==PERF_RECORD_$metadata_record)" --prettify $perf_data | grep ".type = PERF_RECORD_$metadata_record," | wc -l)
> +	local count=$(pahole --force_cu_merging -F dwarf -V $perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C "perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type,filter=type==PERF_RECORD_$metadata_record)" --prettify $perf_data | grep ".type = PERF_RECORD_$metadata_record," | wc -l)
>  	echo "$count"
>  }
>  

