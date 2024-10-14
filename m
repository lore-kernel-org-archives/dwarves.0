Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1F16DED5
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902023; cv=fail; b=WQJmVB1hsl4m6tx/OhRozjbHTUY5MTNKRnGISZNsJAQ8IGy3+wn9XXyWGjnOJOLhwNE5hDok7HsdEE5gQRamuxZRv3CvCxQviM58hjTVo8ZTRsVTRFnDRngfnTbaOxIDiKZrXnaF6tmPG86npawNNGNGAGEcMPn4DSDMoosO/q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902023; c=relaxed/simple;
	bh=GQnSPF0YS1pgT/EZpyK4YymbE6cwHvJ4EhLouzhnlAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sgRE2Jxenw6F2rCL/P3sIXWHyk2bthNv1MCfyIGUrkJ5+wiU0Syf7i//qugvOJDSmxBDCF1Rviq82jIG+4NjLpvGYfiYt6iL+6TI4/5gDrcg+nD4+whyq6X0ESI9QeUWGzZkIaq22yqzDbr6zi92pwu6Ux1VLcc9F85gJN0tUYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GZot4WlT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V0IVowRv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GZot4WlT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V0IVowRv"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9tanR011641;
	Mon, 14 Oct 2024 10:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/uEXf6DjiKUgHeUr1PjQA/9aSywg8Y/KRM8utrgT9WA=; b=
	GZot4WlTGrZW0MLDLfYe7rpq39+obPT689KdXdrcI6xy6Sz7R/2+1YlSYoF6UaJ+
	7RZ9jb+y0ZOvHWpesGun1aQm8WtXmMAx9nJ/m/PleYL26PX1lxzJT1JtjjSfeUD7
	/99gDBWdTV5Ah94k4/KetHWeQZni9Z9KcgxD3o4rLomLtvi/kYwAk0yxxY6EESUs
	HnCIpkfSywWvxbsEOiRZ19QBgoiu2VXisBqpLAZpK1t60nQfUxfC9ezYvVD6X6ss
	RXoSo+87N23zeuQb02ZLR+KEQImSt4H0+14FpDAC8nDZ3nfqAe4e/lbO65UxNtXj
	qCYy4LUATr865h9SZEpbNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5ce7fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 10:33:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAOqmU027250;
	Mon, 14 Oct 2024 10:33:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjcdxxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 10:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3ifIFqC/ZMCje2PCfk0zmGVb03vDZxMkNLIEBCOCAxxWLyIaFUjg7jQXTPM16cGQf9/tga3+QU9VpHB38eru8+cmgpXP1iDNOYQaWJJGHUt/tFJElIJcXAQw0I7WD1u2eVdt9C1kNTltn1wk66skM0yiTzLTeDBShu1C5HmhyEH+gvXvyCrowSCfhI/Mp5kGgCEf41M9DD5lkCpG+H0WZ73evjCqR6M2LOVsCLx7c1zazfhGwm8nzy1LXHy0Ungn/HQ1zO5EKTlTiuH8lN8k7595bBlet+IrR42vZB3f4qnVjvxonW8JylfsPHFP6+kqNPRLFx9XIEjcC+KqiyHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uEXf6DjiKUgHeUr1PjQA/9aSywg8Y/KRM8utrgT9WA=;
 b=SHUY4Uwh8fLdVAXMqU6ED6VDxLJeQp/c/HlVmiDGGTxTWc+7nc+DDMZQyDGn6RrRVVSsiZSB9O33uqCmuoQXR9WA0M62vzVNASGxUbJ9KMAZ9vHm644s4TaeXZ0H2Qs0ElBvUik1D6UuISk8eptriEdrk1k15ZrH8bN/x4QoCVjNxzJBy2GQPAAHPRu/7DD9JXQutEkbW+hOliMGJW7N0FWeyzqeztAcnhmI31PzBUTrV6SjMddXmefDZxl+QTqZT4J9wfUfUu/XwRNiamzSxqJkRxVy6yPUwJgQZVyuxigV+ejoYM6/UOolN9YXArllALmxy6QH7W/tkxlP0WvPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uEXf6DjiKUgHeUr1PjQA/9aSywg8Y/KRM8utrgT9WA=;
 b=V0IVowRvB3808zNNujBFcmzdpsqtn7NCGyUNHe2P6D5qCNhUwBaAw0mdDd2MZfBBKpqlj687j4fFaF/U9hUOfNtv8z5oagasAywKnALbPytaymAWWSAFsfAQwG3cglM6pz3JuKYw/JLKpJIZ2OvmZqhXxbzh0Dq0J3WA0k4KmY0=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 CY8PR10MB6905.namprd10.prod.outlook.com (2603:10b6:930:84::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Mon, 14 Oct 2024 10:33:29 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378%2]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 10:33:29 +0000
Message-ID: <ad0188aa-6b6b-44f0-b335-5cbb6d0be1f3@oracle.com>
Date: Mon, 14 Oct 2024 11:33:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared
 elf_functions table
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
        acme@kernel.org, andrii@kernel.org
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
 <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com>
 <4C0idzPIUJesSQi12dB1SgeTQlGl13N2CCsvjPfdLbvTEemTJoQZ4P-LJcOQqRyM69ZLKVv4mIKDQJvfMYMV2oITse1_uS_m_SjVigh8bL0=@pm.me>
 <af7ca712-7798-4204-9e15-fa2065154699@oracle.com>
 <52889283-56c4-4cf6-aad6-b0fbea9e58fb@oracle.com>
 <m_fH6Yg0CAytjEUTxfZPpbMVGqGQWhuep4D--XMNrOZJh6MUWlIozEXiCC6ulW4FK6UFvCFlZC_sF0oNsAW3sftTvfPBjpz5AN3MdnxfhB4=@pm.me>
 <CjP57PbrCPwA8EsOHPQuoZ9YnU1UE0mzeYqoqI4gQHTxIVUgXoEmGS-4R2g1gkf1RMPFVlTSE253f49mPUvqHUiuUw4wxwJXBH3Pv5GPwOg=@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CjP57PbrCPwA8EsOHPQuoZ9YnU1UE0mzeYqoqI4gQHTxIVUgXoEmGS-4R2g1gkf1RMPFVlTSE253f49mPUvqHUiuUw4wxwJXBH3Pv5GPwOg=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0411.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::15) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|CY8PR10MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e44bda-de6c-480a-b70c-08dcec3ba4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVBxbWFHeU1sSFZiYndOakpnOHEvaFB2YzJSWVg4cHRKblhVMUkxUEFHc0d0?=
 =?utf-8?B?eXFhSml3ZEpVUklpV29RWm02NzhqMnozSlNkZDFkRXZWSEdPM0ZadXRSYjZP?=
 =?utf-8?B?UHZGc2hZYlYranZTSkJ0alJBcG9XYmhtaXNCckhkclY0WGxHR0tJRjVWYVJE?=
 =?utf-8?B?NWJ1L3hvemw2TzJvaEI3Tk9TMHR4elZ5bjZlMUczb0pxVGtyT2ZFWjdXWnJR?=
 =?utf-8?B?Nm1JN0h2K2JYUlVLNHZrdDRoRThaYkRiUnlsc0lRdkp3V0FOaXV6UmVsMXdo?=
 =?utf-8?B?VHd0VXdkemNzeTA1MG1ZUk9Ja0hFMDdzeWJENnFGeWR0MHl3NTM4c3JYY2xu?=
 =?utf-8?B?SWFjNk8wK3VhMGhjYWZmZUxjcE5hRXEyQmQyUXVZZXZQZi8xSDNteFJ0L0kw?=
 =?utf-8?B?ckRMWHJERDJlYy9nOEI5MnFyQjhYM2RqZ055ZCtCM1BLNzFTWWhuWS9yd2ti?=
 =?utf-8?B?b1NUWFdjdlhvZTlPR05qMzV0cnBkSm94Tm1jWXAvdjNkOWVBU05LWXJ1Y3pw?=
 =?utf-8?B?M3RUYU9FTVhqZ2F2dTNJeGd4QnM5TDFZQjQrRk9vMlFxd3RLMWZUSE8vOGgx?=
 =?utf-8?B?MGVYOXB4d2swb2lNRlM5OFRqSndPZkZaOHF3czcwd0dUNStncDRVdy9hcjlp?=
 =?utf-8?B?dzVSWXhOKy9pVk1BaDMwS0Zma2ZYbkl5R3plQkhYZVZ6bWZLSE1HOHAzelk4?=
 =?utf-8?B?Qi9BTU0xZlhEYnMvMnFBVzZSQ3phSXlsY1ZxeHpHZG54djNKQ0tXWW40UDFM?=
 =?utf-8?B?WkhlN1pWWTVlbmkybngzeVN4T0ZMbitMQXZKL2NFSkhrbVlkOWtlQUtUUTJp?=
 =?utf-8?B?d1pGMlVyZ3h6dncvVUhLREt2dEF3aEVHdU1teGxqOC9BaHhsUDMrem4vRWJ4?=
 =?utf-8?B?VHF1T2FNNmFFbW9CckhFYTNNczN1a2RpS3VoQTlJNVh1UnAvaThKOERsV1Rq?=
 =?utf-8?B?TE5HUTBRSkZzejhYVUtHOE4yT29wWFB4OE5XNXBINm5KUGUxbzJ0ZVQ5Y1BM?=
 =?utf-8?B?SU9YYWI1RzlNeVVXRGhkZENicWhvR2JtV1FlRHVOVFN1NXpZQ2Q5d0duY1NM?=
 =?utf-8?B?b05ITmJ4SjdUcVRaUzZoWWZ5dmpyaGdtVXpKMUk3SGtYMWVaQUhhM0ZCck0w?=
 =?utf-8?B?VDJyU1oremhQQjRLQkxlNWI5ZDZFS2ZCMWtIajNzTFZIQlFtOE5KbW1VSFhk?=
 =?utf-8?B?QlZaY2hZRWY2cUc2M0pUWjNGaTI3TjRPQ3BxaHhFV0UranNKWm5iYVYvcUR3?=
 =?utf-8?B?K1Z4VFFkK0Z5SU1KaUw5OTZFajhzRUo5ZVc2cmp2cGFPdlhxRW1FWitlRUdB?=
 =?utf-8?B?c1ZibDdncVUxSGtQNWZ4YTNtRzYvTTBGRGMxM3dlanJrUmordW1mSXEzVVdM?=
 =?utf-8?B?WElTdTJXNEJ6VEdMZEN2Q2xmTkJ6bE01MDBWQnlnMHViczhBb0pXajd4aVdm?=
 =?utf-8?B?YlBmejI4SVp5TTdJNkI4NnQ2dG5aT29aT2xua0hyckJqenJKTFNscmkzNGVS?=
 =?utf-8?B?V1RFQ2xFVCtrYXRWUExBMytnVkdFR3ladCtCYnhNNVZrNE1BZStUUVVFTHlx?=
 =?utf-8?B?RzhZTi9XQ0s1UDdIa2h5RXRUMWJ4bE82QksyRHNUUk9DUEVjaTg2TTMzMHR2?=
 =?utf-8?Q?LMH7ulO/onoVEa91BsWCE1i4auq0jB+2pn1x72czHmBU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDRzY0tDSitHOU5obDZ4Znl3bmtqZWU2aWFnNkhNNjVWOTdjSlB3Q0dRMHB3?=
 =?utf-8?B?L1RwTDgrQzFJb0hUTTcyWlprQXQ2K1NOS0FIeXhYZVNOSDFtdHUxNXdEVWk1?=
 =?utf-8?B?VHBqOVp5N29pTERuL1JVWkJVMGh6T2tLN2VRT2ZXSUtIc3Byc1BBTlNzbFEr?=
 =?utf-8?B?NTc5MVh2L1I2eTIzTW9OUmJlRnhmZTVodGsyRERWeHVaNEs3NWN4RkgwdmtE?=
 =?utf-8?B?RDdlSldrK3ViNU10Mm9CY3ordG1ndFhOWllyelVqbjdZamJJY0JzdGlacmcv?=
 =?utf-8?B?S1JJREhaVE85OG1zdWJ0R25Zc096cmk4YVo3NG5OZ2MyMHVTbEJyWnBzSitn?=
 =?utf-8?B?a3VtclBic1lJUFZ4RzNPK2JYNnAyV0JsdEVqdzNIZGtBeStHRXhMZFZkNjc2?=
 =?utf-8?B?L1NGTjlHOTA0TGZZN0NRd3NwZ25PcVB6ZnBhL0JBZWl1a3YzNzlVYWR4czFH?=
 =?utf-8?B?U011MDJtZE03QVdZSUJvV0NMaUhIanVqU1FMS0wxYmh6Z0dJYkhaNk5DSHJ1?=
 =?utf-8?B?OVowbTc4YzhtWC9lYlhkYWIzSDBkczBmUWJkeE9MN1RUWkRmTlk5YzZIZHJN?=
 =?utf-8?B?dkpJVnk3UHV5ZElNUW1Bbm9wZGZvSi9IS0FNQi9LcDNGWTNpajhOYWd1QkNl?=
 =?utf-8?B?L2tJUDNRUTN1enNxamlzYm1iN0RLZmlTRW9LM3l4RW05QWw3WTV1TmtnTkh5?=
 =?utf-8?B?V0NCKzlybi9wckthWSsyZTJ0a0xuQjFDOW5BazBpNWhzVnFJR2R2YzRucWZy?=
 =?utf-8?B?bWVCLytEWEl1VjNSTjJERVFqcHIvcU0rOXRNUHRRSW9rWVpuTVRGNmFTOTNH?=
 =?utf-8?B?bEhhSXVmSVNXUGxiL0tsRHFFeU1PODBKU2UzdDYxazRMVTRoS2pQTmI5MlZK?=
 =?utf-8?B?dm5mUGc3QVRnaGlFaVFLSFJCdzl2TVV4UHZRdWI3MVNNVzU1SkVhWmYrU0x1?=
 =?utf-8?B?UmNHWWtTTUlVdlhVOHJzbkRyNUIwcWlNUDZSY05sbHBBczlOc2xET1Vqcmp3?=
 =?utf-8?B?b3FPM3hhUHY4RzlSL3JqUGVQcE9DRC9XeXdvS1d1b2F2M3pvNUhIU0d2d1hI?=
 =?utf-8?B?MHJmZURkZndGYU9Xc2JkR0RVd2N5R0tKd2JWY3YwVGdwOUd1dGVLM0o5eWoy?=
 =?utf-8?B?dml4RDdVaDAzZStTWTNTeXhqSG1TUUIxcVFkcGJwUmExeWE2SWhTSytlbVlk?=
 =?utf-8?B?Q2NSbGQ2SXdtV3BXVGRyWHhIL3RzUHU5MGZEd3pTMlNuVk93Y0VuRTdLQWlP?=
 =?utf-8?B?MHhVanB1aE0vLy91bk5ybU82V1dESXJjQjFEOHJ3UWFrSTl3bXlOYzJWNWNH?=
 =?utf-8?B?Snhtam8wV21MQUw3M05FRGJZYmw5cTZxeHIzWUc1L0o3d09wUDRTN2RwVmJW?=
 =?utf-8?B?eS9Pekxta29yWWdvbnRxUksxSkcveU42dzhYRGswaE1reHRidjJ2L3JFQ0tG?=
 =?utf-8?B?Z0Vvc1FVUC9PY2JLU1BtYkYwVnZCY0NuSE5KNnNhbUluRm5ndVluVm5vOXcw?=
 =?utf-8?B?aFRYRDJ5RnI3UTY4RkhSZ0w5S2RwcmthY0QvWVpRK0xVaWgvYTlZZlh0NGdJ?=
 =?utf-8?B?RlVsamJEYUVsUE1KRWVpeVVTWUxjL1J6SExnSWx2Z1ovVFZUNEladFM0R2pE?=
 =?utf-8?B?a1g4c3JXQUo2dU92MGRzb2x4enFEdXJwa1d2UGp0RjBpdkxtWW1ZNEpFelM3?=
 =?utf-8?B?MVpDemMzRjFXb0k1NkZKT2JwejRVY1J2Q25jZms0U3hETXFXcjVoR08vSTZM?=
 =?utf-8?B?YzZvSVRZTENVR3QvUzhjRWY2Zy9nWlJNWUlsNDg3eHlwNy84VitBYXRKTENU?=
 =?utf-8?B?c1FjUzZBcFpPS1pJTXpZc2xVYjFWUGlJT0FuNkttU2ZyS2t4NUlDRVRmWXYv?=
 =?utf-8?B?S0I4QTFLNk1TVk52akRaN05UL2pSVTRCM280TURuSFoyOEFGYnRONGlKQ25P?=
 =?utf-8?B?eWwvVzFqbW1WZ2hhMjZzM0NuT2dBbXgzc3JHekw5bkh6M2w5ck8wZVF2ZDNZ?=
 =?utf-8?B?R1VWSkIwWmIxRWJGREFxNDVvVmQ2c0xMNThyK0ZrY2JHYW9KbWExZnlaYnBt?=
 =?utf-8?B?VFdYMGhtbzduN3J6U3d6cktMLzhVY3Jaa2dwdlFIZWYvTDFMS1RCZk1XZC9O?=
 =?utf-8?B?NTk0TmZSUndodWpaQ2t1cUppdHd5L2Y2UUQwSXRXcHJOVkU2bmFvZUNib2lG?=
 =?utf-8?Q?XjQW8KUoI2UnaNorsTPkmQ8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZFU5zsmHR3jcl+TZOc/4RzChXZuhlPSlgo/EcYPnkYzXoFmCfT/EIV0vFCOWw9c6Gc5qLMiNa8aBXld5ijMT0fclIfP08yDQIm/R24+r5/XxAIV40DJBeZHbBCyKEwCSRxMe0t8B8Jh7sQkmrB9UlgOBVobNL+SKbJOlb9DdfqihslEhD6xa3AAIDDpD64dzmD9TslwZivQWY03we64iHURtZXaaiiVRtfDiP61y3fC8N/88Vg6uHC+pAkyZJQy00obsBaWEgBQi1O5Q7oFZngz1QBID7yJhcUx4JjTHbdoJHNKu2RWUBj6C2sCmaeA1GBOVOCPZ5y3NkIHE1XJGhgADXRYb15DYfXDuO8Wj2nWMc5tjIETV7OgOsSTfdfESbrnE72gZhsZYCPSlOx+GJcGzit2WzbD4WV9LHGEmqbkJBnLqs18OjZhL1m1oKyEcYBpVt4U1qajT9+Rhme0bjGECB6jN2F5C7aS6GoteYG7YG+m6lm2XhOlk3FLwCfRaZYIt9rD1DNG8kxlYV3xG0OGWK3TGZ+Ewb6RzxjOyvRP1A3f9hFbuoDHsta/lMzK2XdkrfCIAb9JwiGQgzSAjCtr3jM3jHDcVbmMnGfyxZf0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e44bda-de6c-480a-b70c-08dcec3ba4b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 10:33:29.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj4b31FgCerW0oRvT2dG7LQMWKb6qUPllAnAfLzGt9EMjFXbG7+wHNBu3W3cFdoI4Kd7ECOHdQJTcDz/g/iO/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140076
X-Proofpoint-ORIG-GUID: XHnU-hbCn-a10_lcYC7HfNCBOskmYFMP
X-Proofpoint-GUID: XHnU-hbCn-a10_lcYC7HfNCBOskmYFMP

On 11/10/2024 23:55, Ihor Solodrai wrote:
> On Friday, October 11th, 2024 at 9:52 AM, Ihor Solodrai <ihor.solodrai@pm.me> wrote:
> 
> [...]
> 
>> Hi Alan. Thank you for testing!
>>
>> I was going to run a couple more experiments today and respond, but
>> you beat me to it.
>>
>> I am curious about the memory usage too. I'll try measuring how much
>> is used by btf_encoders and the elf_functions specifically, similar to
>> how I found the table was big before the function representation
>> changes [1]. I'll share if I find anything interesting.
>>
>> [1] https://lore.kernel.org/dwarves/aQtEzThpIhRiwQpkgeZepPGr5Mt_zuGfPbxQxZgS6SSoPYoqM1afjDqEmIZkdH3YzvhWmWwqCS_8ZvFTcSZHvpkAeBpLRTAZEmrOhq0svfo=@pm.me/
> 
> Alan,
> 
> A heads up: there will definitely be a v3.
> 
> Eduard discovered a bug when building kernel using pahole with this
> patch. I already debugged it and made a fix.
> 
> TL;DR there might be fewer encoders than threads, which I didn't take
> into account here:
> 
> diff --git a/pahole.c b/pahole.c
> index a45aa7a..90f712d 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3257,29 +3257,34 @@ static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void *
>  {
>         struct thread_data **threads = (struct thread_data **)thr_data;
>         struct btf_encoder *encoders[nr_threads];
> -       int i;
> +       int nr_encoders = 0;
>         int err = 0;
> +       int i;
>  
>         if (error)
>                 goto out;
>  
> -       for (i = 0; i < nr_threads; i++)
> -               encoders[i] = threads[i]->encoder;
> +       for (i = 0; i < nr_threads; i++) {
> +               if (threads[i]->encoder) {
> +                       encoders[nr_encoders] = threads[i]->encoder;
> +                       nr_encoders++;
> +               }
> +       }
> 
> 
> Regarding memory usage, I tried instrumenting with prints of rusage,
> but that got too inconvenient quickly.
> 
> So I ended up making flamegraphs [1] for:
> 
>   perf record -F max -e page-faults -g --
>    ./pahole -J -j8 \
>             --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs \
>             --btf_encode_detached=/dev/null \
>             --lang_exclude=rust \
>             ~/repo/bpf-dev-docker/linux/.tmp_vmlinux1
> 
> And compared between next (91bcd1d) and this patchset.
> 
> If you check the number of samples of 
>     btf_encoder__collect_symbols() - that's a table per thread
> vs 
>     elf_functions__collect() - a shared table
> 
> the results are what you might expect: for -j8 shared table is about
> 6x smaller.
> 
> However, even the duplicated tables have relatively small memory
> footprint: ~4-5% of the page faults.
> 
> The biggest memory eater is elf_getdata() called from
> btf_encoder__tag_kfuncs(): more than 60%. Maybe that's expected, I
> don't know. Certainly worth looking into.
>

Thanks for this analysis! I'll dig into it a bit more, but one saving we
can make is use ELF_C_READ_MMAP here; in my measurements it saves
between 10-30% in peak memory utilization during vmlinux BTF encoding by
mmap()ing rather than pre-malloc()ing memory for the ELF sections. I've
posted a patch with that [1]; maybe it will help us see the benefits of
your series more clearly.

[1]
https://lore.kernel.org/dwarves/20241014103142.2280044-1-alan.maguire@oracle.com/

> Of course, these are page-faults not a direct memory measurement.
> If anyone has suggestion how to get something better, please share.
> 
> [1]: https://gist.github.com/theihor/64bd4460073724a53d26009e7a474b64
> 

