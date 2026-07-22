Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A3439F70;
	Wed, 22 Jul 2026 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735708; cv=fail; b=i9Hu4RqkXk0ZGXVV0b9CKXzqubo0ODdTxFrmXQlFXhlbDQL1k5DIzcBZ301USx/4OihzvzJpX//L5R4rqyK2NjRg8n9qekEzI3dC0jxxdsZc7jjPy62NXAzirs/s4OSeBey7V5Uh2/BwK4KBeCQ75JRzEbcGhBiQYHc6pi5fcIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735708; c=relaxed/simple;
	bh=dvIiJ0k7KWyTANmloSZi7W0ocgHz3ML/d0cwZXi2F6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=It/LvBVWKmpmCdjIFDS90Z1UXok93TV+4Ym322bsmFeN565jMALPV1xBAlphNM81m18ljN5JlhNo4rMG5JFcsQ6nJ3WFedrTPBT1u0PX9sxMJpaivDKiq9tezxDH9tx2bTk+KnYwyaxIyBTp+ZiyPK7Lh+fwymgJLVobnvuF7Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JKWX8ght; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wuY4bJ6Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKWX8ght";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wuY4bJ6Q"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MCwViY2613189;
	Wed, 22 Jul 2026 15:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YQ7zqGSR5lsKef91aHcepwkGARyqot+ReFOggu0myGw=; b=
	JKWX8ghtcsacBRurWWum/QscfFujbQFqd1rlCcs8nIHdFklzirdWshOeRiWoMJvE
	gILwnGrd1a5iiMAbCd06zM401f+L0zcsNukQh9lHY+V0N/DzsRzYD433gguPUlbb
	Jchay3lrpwWJJT+jZEaesJneguGNcERfMn/1yLZF44soKoL3kKMAgnPPTw0nHYr8
	Z3SgJg5EB5aFL6HmBwvgJOqsHHXO7vpUwl1UGxVzNbKNXGD0qOnIMvZj/R/8Y+hC
	y2BWOtiVsBEitMLX+xInSGFH2D6Lm63b59WNcBIR03i76tXmlUs7kKsfMBuO/2Jo
	U3huTcVOPKObxvFvZWvQHw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1mv5f10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 15:54:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66MFsZu4005768;
	Wed, 22 Jul 2026 15:54:57 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxr3mp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 15:54:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wfz9AEY5C85wrnnMPf0AMaDPhf8orOsgOAu+A+eWIsHLhC6pp5gZEAaTHLWgEFTAf18veJ1ZjIJb2p9lZXpU1a3JINmQk84pD7JAt6+xKgxN7OLgaXeokxqXTEMguhtqgn6x1C5dHTnO4CO6RUyPIiPTSrH8rg1MgEQ/ZoL90Ji0rLYZOAKGMz3bCLI5h9rAjXJyU7PZsOo+lHDu7hyiJrXCdeap01dVaPjHGcdkTBwNKlf1XHU1Dz2cxy8j0WLWaqowD5IxBd/DhoXQ+aAE4ATCFuHFZPL3icQq1XdYoiPfHQ7SSaQOghXeDOVShEPp7gMty0ZrtlrrlFS9mKDKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ7zqGSR5lsKef91aHcepwkGARyqot+ReFOggu0myGw=;
 b=G1JkV77M7RYEkAfego0aSjLc/5wPpcKIy8uKnFz5ybZP1PDIuREJ8vnTkh8Kxf5MydLDVpZUBkCGUEXu1K12Hlk/7OXhvlQmVbHz2FRXidMUkfb+/S09C+FseXibtyCaDWOalBz1CidpZlrF/lpCplMq0PAF4pYLgambudtw/OKOZBf5iZz5prC+p0ufETbmH1SrIJmOGTHWk6wwQ6T+bShVP0jPrQFOqfX7cQIk+/Uk8Ft11qJR3F3zQ2nohyKcQBpminAL3HdjrNjdMFPdqC0A0qqxJIl8zurb+vCPL36fYTsmOh13qAq5LlJyRkGELLMv50neenMzsaG4EIsyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ7zqGSR5lsKef91aHcepwkGARyqot+ReFOggu0myGw=;
 b=wuY4bJ6QNll6sZGjbG2TKOVWeNBiKAJxL4a9Nw+K6D3Rfz24kHiCiXUifJSYyB1qPbL0KFP5/6+6v9HkUotSnBzm2nCFFx8NSozHt9Fp65lTnHcQcngxj3f+DJ5BBcbtxYTxqfmY+AEf2vEotF8rC7BrWQm7DDvmVbxEMCeMmI4=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:53:46 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:53:46 +0000
Message-ID: <a3027b36-39f5-4e30-be26-8d87bb54d4ee@oracle.com>
Date: Wed, 22 Jul 2026 16:53:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v10 0/5] pahole: Encode true signatures in kernel
 BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260625020148.1883082-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260625020148.1883082-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CO1PR10MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: ea43f20f-163d-4d12-713a-08dee8096a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZdRASHWdlZPQs/4eeLYnpxJZdIV0FklR/xKWIMr3T5UYCcDp5PJm1xkk8Ok91xIqqoIHPwRbYrLjoUuLdA3OwwqpBK7n1mM8x91vOj16GWjFpH3n2JaGx6lhnKLWTj6QzxBP0tvGWpOEbYSBUYfcLMGvp0fct8Z6WIKmXyS/f40tJrpTBlDbE7HydQyrhR5XMDKiRhZQC2VR2Ilgu23M1iylXdxgnlsA/3VLSMieM/4bdB5xoNAn7FAGqL4UV8NuajdPQNSdcdWl70qnSgHAgh/SMH3NBmBtkVlMtJuXYIFumd3Ft2LwjwNf3OkwHs5dCUdwqn22Cmemw47MO2n7GsvuAyXhbYAYOUQKdu8PTxt0S5mu/71ff256o1KYKMFpYRs66ni4+SGgYEn3KNCJylUmI064E90jzOOFxdFK82rBvu11KLuUtOcEQM0MDuMVyHrqq0t8NFOfdUsOKDwF6+ilBf+Zt083vsza+cO0qSOxlzSHU2cRaVNHmwnGYVQ5rd9FJuN3WjgrIgYFgwc3UfIg+qkZPEU7EkANdBa/ayPFAFmGKxQUsPIcsRhp/Pa/9KvevbcR517ACXCCS/NS1K8uCMSxk5gjX8nDnlGUvEj4do/MYy+hBY66y9gu+46jbNPgDfQeAqck1eC1k+EMp9xvCdQwcxkTS83+zJ5gWQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVd2TVdpam1MeEJRZklxai9FWXF2MDBwL3h3dTFIMnNwdmFhb3lVK3ZaMHQ2?=
 =?utf-8?B?RUJIc2dnS1M3a0x1VXBpcStzVTg0bElFSERIU05BM0YvVzBwdi9haWtIN20r?=
 =?utf-8?B?SEZodVFZV1gvQVRRY05WTUk3M3cxU0NQaHJHQnRNQktaQ2ZUNWJJd0V3Qlk3?=
 =?utf-8?B?b1kveC9QMWVPaHRPNDRWbHRRZmluQXl0WkRSUDJVczlma0doQWlnN3JMUy9V?=
 =?utf-8?B?SXVFS3I1aC9OakNJMU5acXJvSmxxNXFPdk15cnhrQUM4eWJ4VGlHNlhKRzFU?=
 =?utf-8?B?dHM4ako5dnQyd0RVMnJpTm80Y1dxNVFKaDZSY1duWWVsMkpHa21vamZCM05R?=
 =?utf-8?B?bWpBdURTdXFydnpYbm5Sck9SUlk1NndvbDdKYytnM0JZVGFjcFBkNTZVb3Fa?=
 =?utf-8?B?RWk3SHZpQlIxZkVTSUNyMEZoYmwxM1RwTE0vY3IyaXdISTRiSTExSHM0UjBU?=
 =?utf-8?B?czNCWjRtWDRmNXFVTmFnNUZ6cU1BSnFLcUFzR0VTN0FwSDRJeU1oYndielFJ?=
 =?utf-8?B?aGtKdENJZ01RTVVXWExsbUljS3hNQU1mMWJzL1FFSXpGcFlkeUJIMGZBYVY3?=
 =?utf-8?B?Z2RpUUtyVHFIVjVwbUVZN0trYVVpajByRVczUlJuRjdQaGNTVVpITlVJb0JI?=
 =?utf-8?B?UDg2S3JNNWlkRm5SZ0kvN1RERlN5UmFrLzYrQ3VWWjlLQk1VdlpmMU05UEUw?=
 =?utf-8?B?cis4bGpvR1lrK1R1a1NtTVEyd2w5SFl2NlkzR3VXaGwvdytuK0VCMWpSOW9k?=
 =?utf-8?B?M0M0T0cvUzU0amFFb2g4d1o5Y1BNdW9sclIwOVZDdG5aamZhSDJ3cm1PUGIw?=
 =?utf-8?B?aFZEUzhnVnM3L2tsOHI3b2VPU3NVblFLNkl3TTZoS01YaUhqVlQwVitQbVRo?=
 =?utf-8?B?d0RqSTFhWG55V0htZ3AzZ2JHb0dTdDJIaTdLZ0xvWHc2SFREbWtjbkU5dndT?=
 =?utf-8?B?TUxQeVU5VFJrUEJFY0s5L2h2VGZWWmttL25UendEZTdtbXhoSitweDVoRG9l?=
 =?utf-8?B?ZW1nUzIrQllZV1kwVnFmajlUWjczaXNTMVFuMmJYTWJlNFEwUUdoRVlSMXlI?=
 =?utf-8?B?YXpSeXBLSG9ialJaVFB3TXNjeXB0dWx0blk0aWxDelpONm9Rb2ZwbC81RWQ3?=
 =?utf-8?B?Zk5vQjhjNU1CV3pEYk9sbWpRT3hVektaMER5WllQdU9PSk14SXROS0crdzY5?=
 =?utf-8?B?cFpMRTgwRjVNVWNpcC81MUp2dkRYNnNOUFRUMnpVbHhsOFdLY1ZpdTJ6c081?=
 =?utf-8?B?ZjlobXFSME40ZjM4Z1A0ZCtTSk1ndG92R0s5OWdSZmpYWms0TWE4YzZIWGZJ?=
 =?utf-8?B?aThldXNqM3FRRzRYclpKcUlhRnQ0L0hyOEpBaHVOOFh6VlJRUFFBcXM3Zzh6?=
 =?utf-8?B?ZWFocEhMT2hkM3pBRlZMSFhJUVVEdUtOR1JzMjNHRkVLR3U4bTFOTko2T00x?=
 =?utf-8?B?cis1RXJ0cG11WWsvV1hZdTZyYWNLT0VSOWR3SFZtOGV5T1BONG5MZjFjayt6?=
 =?utf-8?B?eHNzcVltellrWkFnbDY0aklhbXNwcE1rUDdDSFQ5Q3ZDNCtmb1FTWVhhTzh6?=
 =?utf-8?B?M3JYODR3bkNWSDhGUjJEVjNZbEw3R0o4WE5YVUtPTnhBWFZsdTdsZmZZOE16?=
 =?utf-8?B?RGFlZStsVnVBQ3lKbXRmU2Z2cEkvR01iT0tORGhrSXprK0tEZzVWYXg5Mnhz?=
 =?utf-8?B?aHNuN3ovblhiT0NVQ29VVWROYzF3bnN5RXlzdkFPVUlqOFZVSG5CaWUweGVo?=
 =?utf-8?B?R2NHNm5hMnBRendsRFByM1pteHJhVzBHanlSalZUNmFLSkpqRTAycmt2TXJX?=
 =?utf-8?B?UVI4SEVpaWNZSVdVZ0hjQ0E1NHE1OFZLTXZtVEdiQnI5OGs0bXdOcElXbXY5?=
 =?utf-8?B?NWdwVkc0MzNtTTFGZFBCelpxK29FZlVQSDN1SDZWNm5yb0hEMDNxUkFkUktU?=
 =?utf-8?B?clJabE8wSjYwZHU0SnpDaUVqRmFpdGIzNEtqcThRVit1aXJvRzdJelJIc1VT?=
 =?utf-8?B?TzUxMmpyR3cwMG55dmpGcFZ3YXJWNVlBYUlaQW44djU0VDJLWTFEOFlWdjlT?=
 =?utf-8?B?WWQxekc1YVlzVThCeFlUbkVLZnhMRCtja2gzcmpIblRFUXYrdWdHM2VFT1Bx?=
 =?utf-8?B?S2Y2SVd4VmNwQzRiRzl3SlNtNm9TY3pjOWQrWHF4YkhyVitEaDFCTFZQUVA1?=
 =?utf-8?B?YUQwSnE2VElUUURXM1MzQyttYWpwaFNpUzBHVmpsd0drUG95dDFCeXAzS2Vl?=
 =?utf-8?B?cU5OS2F6alhQcnB3Ykw0NUFIRm1uekl2a0ZVTWU1QlFjSU1PRThDOTBPdFlk?=
 =?utf-8?B?MGlzc0VRL2FSWXUzczc4Y0VWTTBsK1FXMmtRSzVCL1RsTy90NVJWQT09?=
X-Exchange-RoutingPolicyChecked:
	myNQHNaCxhxPmofmaYmFkKTFIWGSlr/Wb8eXS7JRp4dqcY8BjMwn8ejjzOlIj39V0q4IG5oZRq82A9c/6zlGhMcpKGXryYn1N/7tn3t24r9XCXPPABCnbFp/xXRHQaxMhZ7dOdG92ein5SBmPzqn1FSNbYVoV3/8Uz1tbKb7ouxmCveO14OB/PY5uw+OwxUtXHZY0qYpBhL1Cf5cUpPyodb/lF06uPxmZVZxzBSZgs5uj8dROK859lVLY+J8h74lsC9KSsnm0jGmM01GUvJQoWkbzkfLFoDqXwStqqkkeyaqmu5x3WJuNSUEyHMWXtmHkWXM4F964XkXgM310xDwQQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VydxbHojlm+tR82ntyF6eEtAoV/zSz2tY2HA33pqVEG8WZ1/IRWZd00MemHcoNCyBdY+HWX55M6u+3otDJWwDbBin6inm2EGLJL7kwMznSZRtW0Cib1u8J8bGKJbs96vUCHPy7PLNvHJ/dccw8XNgt4qUiZzx4aDGpGhgZElSBapENQcOasJJh/Kagtvy1y/FX+C6R6tC+AR8eJixxpupVSJhRmIk16uO3wHy2wbfUo9O8PNK/2EKGqXcHNELliCZTBpa89A6cpo0zCVTFbsqWqa1Wzzulfo4GRHp6lqPwJmdvFNPHvq5q+3psLWD4hUX6FBLAODv4rIm2pNow7WOeFfVxK/GsnyZe4GLqImHQcYb9WgnZYfvm7l+fpSPSFZmod4j6lrA4ZWzTm1611JaRAp1ma01xR4+JzHduxZN38mfmBgxwV5zVwgXLDcWgEUaHoBq/Q+K56Gh7idrVw59YNbFG4JgnAlzSt2vGB4whu7UosDLHt+Njc8rZ8yxtnhiTgf4XtKqcEqdeEbWv+owtTnH3MxiqmS2J83MKdv3AUt/5K0MmM3Kj+C18zPLMwKIs0oL6UsZLGTuxONvK4Rqm+4ARIYiBChp7KXFjBqCoA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea43f20f-163d-4d12-713a-08dee8096a03
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:53:46.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oElEhwsvPsgsxxOpUTfXR7JqEvSJkGNB0B/vkgFwUrmKwUCLjMwhx/jv5QUNg/x2DxQMTFIBMj+BYNw4yd6P7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607220156
X-Proofpoint-GUID: q2k2DgGAci5T80ZLE6CNvZM6crUQiT-r
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1NiBTYWx0ZWRfX0DaE3l/fkONl
 5KsQmvXbChqZdjH9/ybHmKAWXJdXUHUdTuHxwCQvgY7RlnTScs5zB71DzM7FFp4JuHLt4pD26xx
 8FNgBScheUuZcSGS+ZVNSnu81rrkrNWY59quxBqgYVyHnA4omQmt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1NiBTYWx0ZWRfX2gYLJWrWkX9K
 ojcOzJ4ILvFHabqX4QLjAMUNmijO0qG0VJwFiF9+l4PyVgISt7zUr0fwI8gwK9rmcBgiKnwE8zw
 MuBup3vy1tU40zu5A21BTji29zfH4r2tUE8nxhWy0p+pWuo6W7imndxcVEI4aqoj42jGHUj+5HQ
 r49NjloOiEEj8f7zMc/3NXQJEVmBTwYsj3dG9B/df+OMJbvHDQuWKaFgOuSs7wW6tPLe9KkQXC5
 mndtsrQk3CKo8qPshMahIKp76FntL2ekNxG0TnTQmu4afy3BWkyd29N8a4cgvSjf97Tz4bekaP6
 qM4XDOoIeIRI2ca4MEgyTR8aqqJd3MeqPnpoNjAuoVejDgdI0s9sVOr6SlpxXvpa6REt1PqnCyM
 oBjlnoI1p6FXrItymDC1vS5qarnaFiFljhZ+7fxo/H9m8oU6uUv+luw7USAGZbdoIY/EmpA4U3Y
 mklUs7Gu9d3ZN/8Dywi5HrDQLZKvu5yYbY0K0VpM=
X-Authority-Analysis: v=2.4 cv=ZpPd7d7G c=1 sm=1 tr=0 ts=6a60e7d1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=7BJqr6Hxt4E3RnydPUgA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-ORIG-GUID: q2k2DgGAci5T80ZLE6CNvZM6crUQiT-r

On 25/06/2026 03:01, Yonghong Song wrote:
> Current vmlinux BTF encoding is based on the source level signatures.
> But the compiler may do some optimization and changed the signature.
> If the user tried with source level signature, their initial implementation
> may have wrong results and then the user need to check what is the
> problem and work around it, e.g. through kprobe since kprobe does not
> need vmlinux BTF.
> 
> Majority of changed signatures are due to dead argument elimination.
> The following is a more complex one. The original source signature:
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   typedef sockptr_t bpfptr_t;
>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> After compiler optimization, the signature becomes:
>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
> This makes it easier for developers to understand what changed.
> 
> The new signature needs to properly follow ABI specification based on
> locations. Otherwise, that signature should be discarded. For example,
> 
>     0x0242f1f7:   DW_TAG_subprogram
>                     DW_AT_name      ("memblock_find_in_range")
>                     DW_AT_calling_convention        (DW_CC_nocall)
>                     DW_AT_type      (0x0242decc "phys_addr_t")
>                     ...
>     0x0242f22e:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>                       DW_AT_name    ("start")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f239:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>                       DW_AT_name    ("end")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f245:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>                       DW_AT_name    ("size")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f250:     DW_TAG_formal_parameter
>                       DW_AT_const_value     (4096)
>                       DW_AT_name    ("align")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
> 
> The third argument should correspond to RDX for x86_64. But the location suggests that
> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
> the parameter value is stored in RDX or not. So we have to discard this funciton in
> vmlinux BTF to avoid incorrect true signatures.
> 
> For llvm, any function having
>   DW_AT_calling_convention        (DW_CC_nocall)
> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
> But for non DW_CC_nocall functions, it is possible that true signature still not
> available due to locations. So every functions will be checked.
> 
> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
> and 875 kernel functions having signature changed. A series of patches are intended
> to ensure true signatures are properly represented. Eventually, only 20 functions
> cannot have true signatures due to locations.
> 
> For arm64, there are 863 kernel functions having signature changed, and
> 108 functions cannot have true signatures due to locations. I checked those
> functions and look like llvm arm64 backend more relaxed to compute parameter
> values.
> 
> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>   -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>   +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
> 
> See individual patches for details.
> 
> Changelog:
>   v9 -> v10:
>     - v9: https://lore.kernel.org/bpf/20260624052553.3139112-1-yonghong.song@linux.dev/
>     - Remove patch 'btf_encoder: Avoid comparing inlined and out-of-line function prototypes'
>       as it caused btf_functions.sh failure.
>   v8 -> v9:
>     - v8: https://lore.kernel.org/bpf/20260623222850.3290612-1-yonghong.song@linux.dev/
>     - v8 made a mistake where all functions go through main loop in
>       function__analyze_parameter_locations(). This is not correct as it includes functions
>       whose signature is not changed. See function
>       function__match_clang_parameter_locations().
>     - Add a change in btf_encoder to avoid comparing inlined and out-of-line function prototypes.
>       This allows some functions to be in btf.
>     - Add one more test, clang_parm_optimized_stack_2, where a global function, with
>       many unused parameters, gets properly handling in location checking.
>   v7 -> v8:
>     - v7: https://lore.kernel.org/bpf/20260623040704.2732530-1-yonghong.song@linux.dev/
>     - Both Check and Analyze phases go through all functions.
>     - Require true_signature in btf_encoder to have name like <paramName>__<field>.
>     - Remove signature_changed (from nocall). It is possible that function signatures
>       are not changed but the location reigsters do not match.
>   v6 -> v7:
>     - v6: https://lore.kernel.org/bpf/20260618011358.632394-1-yonghong.song@linux.dev/
>     - Ensure that 'collect' and 'analyze' have the same location checking.
>     - In 'analyze' stage, undo true_sig_member_name if the next expected register
>       matches the previous source type although the previous parameter may
>       only use half of the value.
>   v5 -> v6:
>     - v5: https://lore.kernel.org/bpf/20260523165712.1225231-1-yonghong.song@linux.dev/
>     - The previous change relies on parameter__new() to collect and analyze each
>       parameter to decide true signatures. The new one separates collecting and
>       analyzing phase from Alan. This two-phase makes logic easy to understand.
>     - In btf_encoder.c, remove usage of skip_idx to simplify the code.
>   v4 -> v5:
>     - v4: https://lore.kernel.org/bpf/20260326013144.2901265-1-yonghong.song@linux.dev/
>     - Check info.signature_changed only under clang.
>     - Fix an uninitialized varable issue (var reg_dix) for gcc.
>   v3 -> v4:
>     - v3: https://lore.kernel.org/bpf/20260320190917.1970524-1-yonghong.song@linux.dev/
>     - Add simple prescan of parameter registers in order to get true signatures
>       for those functions where optimization could happen but compiler didn't do it.
>     - Do not create a new name (e.g. "uattr__is_kernel") with malloc at parameter_reg()
>       stage. Instead remember both "uattr" and "is_kernel" and later generate the
>       name "uattr_is_kernel" in btf encoder.
>     - Add comments to explain how to handle parameters which may take two registers.
>     - Fix some test failures on aarch64.
>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20260309153215.1917033-1-yonghong.song@linux.dev/
>     - Change tests by using newly added test_lib.sh.
>     - Simplify to get bool variable producer_clang.
>     - Try to avoid producer_clang appearance in dwarf_loader.c in order to avoid
>       clear separation between clang and gcc.
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20260305225455.1151066-1-yonghong.song@linux.dev/
>     - Added producer_clang guarding in btf_encoder. Otherwise, gcc kernel build
>       will crash pahole.
>     - Fix an early return in parameter__reg() which didn't do pthread_mutex_unlock()
>       which caused the deadlock for arm64.
>     - Add a few more places to guard with producer_clang and conf->true_signature
>       to maintain the previous behavior if not clang or conf->true_signature is false.
> 

Series applied, thanks for sticking with this, and thanks to Jiri and others for testing!

Alan

> Yonghong Song (5):
>   dwarf_loader: Detect aggregate ABI register usage and signature
>     changes
>   dwarf_loader: Collect per-parameter information
>   dwarf_loader: Analyze per-parameter information for true signatures
>   btf_encoder: Emit true function signatures
>   tests: Add BTF true_signature encoding tests
> 
>  btf_encoder.c                         |  26 +-
>  dwarf_loader.c                        | 603 +++++++++++++++++++++++---
>  dwarves.h                             |  14 +
>  tests/clang_parm_aggregate_1.sh       |  85 ++++
>  tests/clang_parm_aggregate_2.sh       |  88 ++++
>  tests/clang_parm_memory.sh            |  77 ++++
>  tests/clang_parm_optimized.sh         |  63 +++
>  tests/clang_parm_optimized_stack_1.sh |  63 +++
>  tests/clang_parm_optimized_stack_2.sh |  63 +++
>  9 files changed, 1017 insertions(+), 65 deletions(-)
>  create mode 100755 tests/clang_parm_aggregate_1.sh
>  create mode 100755 tests/clang_parm_aggregate_2.sh
>  create mode 100755 tests/clang_parm_memory.sh
>  create mode 100755 tests/clang_parm_optimized.sh
>  create mode 100755 tests/clang_parm_optimized_stack_1.sh
>  create mode 100755 tests/clang_parm_optimized_stack_2.sh
> 

