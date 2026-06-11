Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBD285CB9;
	Thu, 11 Jun 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168958; cv=fail; b=gXGm8yuJAbL54uPZDm+6FdlKWNbkExwMIOBdLX5zkcGrvkgt5yAAsvDnPOnQ79cSfN0tHPeip/WNad6WmK1G3L34C/Hbqf24kyzPZd4b9WoArCxMnwmiUcJcptByUkaiQh1th7hYW9oZnbHTPdNMFoElQSz8KaWAOO5Y5A+mHTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168958; c=relaxed/simple;
	bh=EjkWw0lL9tGNJdxuSrZgF8m3q719kMhS+1qh+eko/RU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eT6/7BC+NRFtgU9HjGP/jaMZ5Duf+vVTqjSU180WlkkQgcqMt3oimU1YAswBdWNhjV2t+AuOpJwDhqPNoFGb3/qZeikK2Cpn7sac4KHD0Ps5DE7y+AXncE2dajiJLVjzlQyXH8et6g3hGjiv1NDLCyMxqmneY9Bkqtz9z3kz67g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Whho3Nd9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xtog68To; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Whho3Nd9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xtog68To"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B8x6w23841612;
	Thu, 11 Jun 2026 09:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/aHSFYh6k2BKgB9D0diFXtpemsOjBdjjU4DPdS27zvE=; b=
	Whho3Nd9ODnnsYEo3ny8fJhOtDklyERoW5Axd4b2n1c9/Lhi3fI9W+mVmHLN162p
	td4EEgZ1uQvNUuHaN6EMNNUKFTshpeLIXAqmeJsRg8Sp/4oYAiLwnexy6n0iXroE
	owKSAGT4nYwTFuk0AqFUthKqcOcZJkteOaa0QpbubefVclYauIP6wHv8G88sF7fq
	AldyrIekqnj4sY7v9LzeRanNSIILdGwfBQLGcXDeMQYoTmaCs7m+RP+WfskO42Gg
	ekkOrDXn4iThkXo1zQQTcz7GfPyvH4M/v+oFQTuK5TOlL0fInHSKwwFVCaV9xWin
	1AyV8bwMk38VwuZR0837Dw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eqe6urw14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 09:08:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65B98bJY030377;
	Thu, 11 Jun 2026 09:08:37 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eqjyxe7a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 09:08:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BA+AWRjWhACjGWmGjKMmqks+/QzRd19mhggU4tbfHvDtSPwhDlcN2FNwyHdFnlhkgUbC1JGseHyDt0TIuuPYry63nGnkDCBmNlvEsqNGy/ZkPbLWJ+iYpNy8jMqoXAaKoGJK8v+wI2DQyRLh5xThRns05iEK5cpaJKbgtXBdOIKQNCGyVEZUMwPAZcC4C9f9xAU3B7F35rWozT/xk4oWpQjiIkuWnWeyLhdrRYRd7p3M/gO8rvZyUp4nJwD2/I8Le5LZTLZ7XD2ymwwRPUuMkG8TSwycLhWUJN97lmiV6f04aG7ez5TnF2s0KGvu7ddW/yUz2sZa25Zvnf5ei95O9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aHSFYh6k2BKgB9D0diFXtpemsOjBdjjU4DPdS27zvE=;
 b=oEHmXYnxen11Etcc2Q9jktf2w6ZKpvA3fxEc0rgaK6WHeXpFqZhI0pfc55bkSnqZxGLRTy25ZKn27VGPTipAvqsuxvhrMZHfgQ2/RS+1hkp8fXcLAaxQ/S83GQCWPmfEbGFsDZVU7t7zLGZ+p+q4IJ6w1AYeL4ZCOFAvj2C8wuSwNk9ADzjfY7b2hbCEyi1DNpq/cyFayMHr2tRvY2SjKEyUbsSgA9B97hDb3gdhFDfiG+Cvp1urlIpCcDx0/apbrQoyK0Z/3dhbY94jHv7M6fULWBHpy0B7rJKa7hAeyXBw3PLEo+a0pCpwFMK60X/5r24oMh4IKdV9KeK9VpLLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aHSFYh6k2BKgB9D0diFXtpemsOjBdjjU4DPdS27zvE=;
 b=Xtog68To5we7J/FXJGWYEmPzYMh+Zt8bQmu2xFEFJ7673nRH60u3KGe2FgcETpP+w13E9yGaS59YiAbgmVCtcNCNK1tyiOUcTHFFwd4k9gldm1T1iOFCfgGiYlTdZ0Y5bAHBipVgIlw5bZT79GrLgK7vveuJOsTlqWog/qrWLpA=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by PH7PR10MB6033.namprd10.prod.outlook.com (2603:10b6:510:1ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 09:08:11 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 09:08:11 +0000
Message-ID: <56c71c42-4c2a-4dcb-b335-6fc8f391ea70@oracle.com>
Date: Thu, 11 Jun 2026 10:08:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v5 10/11] btf_encoder: Handle optimized parameter
 properly
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260523165712.1225231-1-yonghong.song@linux.dev>
 <20260523165827.1232923-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260523165827.1232923-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0097.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::12) To DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|PH7PR10MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: e10f1aa3-b7bf-44b2-803b-08dec798f607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|4143699003|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B7rAoOzi6VYl/ou7pr0eonKvQiErugG9IuQdixu1y18UkjaE7SQd235cxfTjyO5efZtyZsH+pVHYL6xJf3jH3ItQIyt84xmkc2MI6P25s2ikIWuyhOhkBXHL0F9+0iavAlwuWmDEob9xSTtpHRmOgJaRzsLUr5XTE2pv+UGdmYVhUY/j8wy67Iq7H+RqSoFJi9/0bi19HJqTDk4CILpKXRQKAbqInaIhaasCHwTEvxPQeFTG9dDIulYilaoSdGz5jemDvf9t+IgkGl0HE0XfVD3nN0krOmoLexILDmTqJ492BOUyUGZktAo3Yn4sumx22pmh7UaHmmS0jISlcffUpBZFZuPhCFxibsRP7Q/W4N1NAmmYhgS1oQU7oMkz8F3RSdt7tdX2tYz6ww4sI5p1JAUiqkRbGlVdMMzFdV85wDExs3xGpsAFzQzHkBXQYLauGGNrkMzB06Vanv3yT3vL7VuYmnptsNIjOIOmfaqw9Acu5U7/iP94k3IkkeuwdN3z7vJPhb+oYQCQU1bYWnLumPsOaiXuajGft3qsJfnXhX3nulqTLDvC5FezXbY0YIy3PusZOTdsugcfh8Pm/tBiooGcuI/pvzULNRUJOxxtgRc2uy6B9ojS7iyGlzzm6k7XDAcRKGNnp5ps1yGFiP1ZM/VWI4XDaQT9SX3h2uNrg0AByxhZr8EM0b4J3mWlIUT3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXEvMTdYclNnM2hlcWN1Q1FNS3NqQW5QYkpxN0xLSlJOYjNzZ2lQcjhCRkdx?=
 =?utf-8?B?NUJQUk4rd2V0VTdsZUwwTUkzdFZuVkpZZGNSV1JURWdkWUtEblN4YThiTjdv?=
 =?utf-8?B?MnRyc1VjZGFFb2lnRjJWdVJsYmdnUzJ4Yk96Z0gwYjUrRzNnTmNuZUc4MEJN?=
 =?utf-8?B?a09OeUhQeFljODZ3eFVUU0FIajl1WXJEV0N1ZVkxZFhJeGVNZFBwVlZWMlVM?=
 =?utf-8?B?eThvNDZKSWc3WkZFMjJWS2Zyb0EwYmRPODFxZ2tkbmxJQlREU2pnZkNaUHBR?=
 =?utf-8?B?T1pSS0VDalNZejZiaVlFNFlIVlhiQy9RSUlpQVkvdFBmWnFHOWNad0s4Wk95?=
 =?utf-8?B?V3BxYktMSUN6Uk92Z2lEZjVFRWNwQzZFcTV3WTd0OUxmbXl4YnFzWXZYTG1x?=
 =?utf-8?B?NXpFUEdNcGxKd1ZGaEhDZ3FCcEdUcThGeHorSmZqUjVpQjZhS1hqRDIrQVFG?=
 =?utf-8?B?MGd3UmN1VEo2OFdMUUl4a01QcGpZaFdIVGkvVFkvZjlVY3h4L3BEMnlrRjNt?=
 =?utf-8?B?VWpiV3dmSUl2c3dYbUxBazFucWdEVVhET094QWlzMm03Y0JORHNCS3VSbGl1?=
 =?utf-8?B?M0QxQ3A2UGRRcUFnQmVmbE5ZWXlHNkg0SFVJbWdDdnp2NUIzM1pIVFlVRm1m?=
 =?utf-8?B?ekZpU3FPVUhMTkRXQmxyNWJETmFuYUpNcHp0dktqaUlma1hKSDFGYXp1V3VF?=
 =?utf-8?B?dDFDcXdOT20xbWxLT0hocXlUQ2pDWnNNOEtrblVKMVZJd3hFZS9vUmRXUXF2?=
 =?utf-8?B?Nm9uUFRBcVErTUtLSE5JenBNLzdReTFLdlYzYkp5ZXQ1bitUd1VVdmNjTkR4?=
 =?utf-8?B?WldVUGw2OWpmR3Z4U1RqN3Z3SXo1STQzWHBhK1Y3TW92eWRRRFk4TGhtUkNp?=
 =?utf-8?B?alo2ckt6Rmp4M215NEJhN0pMNThuNGVOREhvcWVCYVI3WWdGRWhmWSsxS0RR?=
 =?utf-8?B?cU90L2wzbC91N2VpTm9KU05aL2JhbXRXYU1lYVNmUEhVSWZiVnRVbVg3MU1U?=
 =?utf-8?B?aW1NZ3J4dWY5ZjRNODl4eDBzd1luUTZkNU4yMERTZ3NTeThxNTRtUXNQWWNh?=
 =?utf-8?B?bTVjRnVPdG5jVlhNYmZzMEdZU3dDL0F1V0tZVkdjeWo3aCtFckFLLzNmdHVo?=
 =?utf-8?B?aGh2a1o4WEdaTGtJYURsS05HSmNXM0Y3NEM1c003dnZBeUNNalA3WXM0THFZ?=
 =?utf-8?B?REs3em5STmU0TUcxWk5kR2pOVzU2RUU5RmpHTDZ2Z3FZMkg1Smd4SGNZUEpx?=
 =?utf-8?B?SmNYQXVEakVua3NyYjNIRE9FbTNyZGFnUzJlNlZFRmpyZm5CTzBqeGkvL0Zx?=
 =?utf-8?B?bTlkcC8rejJFK21GaDB6SlRZZWpiVGMxaURaOXR4MWFZWmNUemJjNUpWb3Z6?=
 =?utf-8?B?Wm1XRHlSdXU1Z3A2Q1Z5dVBKSi9rRmNWV3oySE9SR2ZDRHljSTcvSVZ6Mk1Y?=
 =?utf-8?B?SnlPazYwTmVmZjlsYUlnUmZyQlNISXB3Wm52RXl1bnpkQmU4ODZ2N21oMTFQ?=
 =?utf-8?B?NWwrSjVtazdpQk5FMStOdStBNEU0eWlqR3kzUjEzWkxqYU9jWnVDZEpLK0ls?=
 =?utf-8?B?Z0FQU01ZOExkbzFkV0NIL0ZiZGhlSzNXaDZ1K3ZOMzFxR2Z0ZFI3LzFDaHZU?=
 =?utf-8?B?eW5CV2d5MHR5S3JBRlVjUFJwV0NUT3QxR2NadmxCRVRwODZmRkpwNTF1amtF?=
 =?utf-8?B?cnNpYkZtNmRrZGRzU0d6ZllRZHRoR1hINHRIMVVuODlNOWhBRWRxRFdIZlpP?=
 =?utf-8?B?WUhUdWlKRnREaHlsczRSRTFCL0kwMEdmSmI3VlZGTjVZKzdHcFJpS1puZ09t?=
 =?utf-8?B?Y2lBdWdxcVFRMFAzdWVRQkFRREF2QWo0b3hTVGJLYUphWGsxeHk3REkwNVFX?=
 =?utf-8?B?ZTBvQXJZNTNxdjdyM2NnRi9DQlNRSTFTRjRmdDNUM1h5cHAxdDVxYUJGK1JO?=
 =?utf-8?B?TUhIemhnd09nU09BVmZ2ckxaWHdSZnEvMWF1RnZTSnJaZy9GR0ltWENZNUlE?=
 =?utf-8?B?K1FGK3NmdDBBRTFTRHloQ3FXVTd2dCtkcHVTTTFjZnJyYXY0K2N0Nm16ZjlL?=
 =?utf-8?B?ZGpTSk1YY053SkZ1VnBjcFc1OWlnenZtY1pDNGE4TFg0dy9hTEF5MkZRVGF2?=
 =?utf-8?B?N1NaRE5DMklmWDFxZitucmZCNjFPQi9CZjQxRFl3MURQYWRLSVh1cEVVdXRB?=
 =?utf-8?B?NnNzL1ZRdFBPcGJSYjFqV0xpbXp5dHF5aU0yTzdUM2Z6ZktRb2dlRGNZS3Vw?=
 =?utf-8?B?TmRTR3NWT0dPemZsV1BZTDJlSnpuSkpvMUN0aGpLUEhNR0FFM1Rtd3A2YkNO?=
 =?utf-8?B?TDBxcHRUNmpWcHN1Nk8vSFF0MnJieHUxaEFtMVg0aElRYTJMeGs0dz09?=
X-Exchange-RoutingPolicyChecked:
	Fg76IWfYOn1H/lDIUI/pF67/xeCEYrvF+a+/ehS9olV6J9jM2A+fs1mVBPkE24R/lK9uVQhbPv5vr/ainme21chCuP46nk6ljp+4BDSL7ecqyCo9nbxjxIJZRVuG5+/iZh6vmUrnnm4ISBs2ubJZB3vUmbpZy2FEPSSHG1hW1mjlBod6pbM12oTtj0zpZVJasANnba3xrlQHNy1Gd3usrZBgyjny4W5TVBkQydb0KdCTetNFf6BZWFCxWnfRJTbNeN0whL1zRkn0UO0VFmyumSHf+AkMNLAGL5/yJOHXJOFwDLh/9FzNhesTnmPOGpFqXDhGDKChepgdI/XH3Hkk9A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D8Ctf3zNdIIy4z8Q2AV3YDgn94kyrGGL/ZxFYzyg0emQpy/52pZoBs9DztbdhFJ/48mzUKqEI4wTfDTihSysEFrqmu1Epl5c1OWaO2vkmII06oI//voQFfRe2L0YzahOlVM91r2tgKfcDg9Q39mHJgGAz/+KiWJevJTOLVqLN8AkvbDg3lSv8cxOrRVFGY0NEzmaY7dYBGlHcEDlbKmDMffEXwzTykfi31L1soKwBA3r50RvZlRTcTxHG9QPOeBxm/HR8ZpLuiJ2BfdRxm6eQG+xhkzycoTOpMEII4APBW6TDZsQlZIiWat1PxHPHPDgQU5DCT7Ak6X/lLTu8jIwEhQMGfzQy48gPrfX/rks/u8g1EGaNLzbM5/Cy+vuYjzuqS1mqEL2iXiBtj7yplMJZYKq2+2j8k7vp7f8crNbmkbyjbc14t5SUoVBEVBoa7hYbSl1xAzaQmQVQiJVI2EID/LhlVxkine9aCSCIv3bg7mKNPiVdLIadBPUblQ9QVLM+GD8615yt3cndCx49cWGR6yuazjBbhaYGwqzWhTdDkayWiM813wuiRGYqejZTS85R5X5sFgMJd6G2URlCQG1FYGqQ9hqRhMh+j+R8OckxmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10f1aa3-b7bf-44b2-803b-08dec798f607
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4909.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:08:11.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v1wCt/AKRlsAd2tMX5NG/GNFlP1cH9x3hVXpjfFMD1aej2SUQZiHH3xbkwBfHVmCQU7/+L0KHPb6pf5xUt+rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606040000 definitions=main-2606110090
X-Proofpoint-GUID: d-VNzKXyb0IBqyitraq9NNfsmRIJqkzt
X-Proofpoint-ORIG-GUID: d-VNzKXyb0IBqyitraq9NNfsmRIJqkzt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA5MCBTYWx0ZWRfX6MI5DYRwqILu
 DcrES6aefxUjsn1ZyoG496NMQ9Y6wbMRnLshKEOLA5mh6p0KJFJchXGYb4wGjW2FTzmJVVJXYgc
 eamSx0R1865iGCus+sNLIsGm8YQaGOty6Lqld5m5TQF0sMgx6zhr
X-Authority-Analysis: v=2.4 cv=edINubEH c=1 sm=1 tr=0 ts=6a2a7b16 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=InrOidjOQ_H1nO9_BRkA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12312
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA5MCBTYWx0ZWRfXz8iVjWnKbldI
 yHEtdSuKLp6RP+S/N/qMxIuMlPWhBDohCTXhnuNyx9AzbdNe6/3QDTrFra35qo1Ex4EZP2s4ZgM
 lONMj+G1VFae21lLuEmZBfjI+lrvHWnsliVbRsj+ALon3dZ3LGAI/A/mjZAOKSV05WxjXqsMUG3
 3mncJke5J4Ex4b7EQY6wtZEZ2kgQ6qsikHj8Ftkhx4su92uqyMEzqFJHQSgET7OAmh0y1D7PQdo
 QKXzzupXQQpLMIhlzqZ9iB2m1ePhJQnrgR2QkaRiWf+nw8vorKrCW2pvFLaxrl5ImN+f+XPqCPB
 dF3HnN8B9Ggf55h9d0sdRGoBIo6JxnhjrG+MENqjRHvKHAu0f7LGDgXViyFMPWt1Z11sVtl5wyM
 qX5KTP8vjBwslnuZ2GCWbtOvFnqEpqX4gWEwAo6gMa/fXGFFZjKabCUC65cC2df4X35GXhIfPbX
 yfRpkMXArXfNa/C/5dvXr/nRqqmUjxyjUoZbVTlo=

On 23/05/2026 17:58, Yonghong Song wrote:
> Ensure to skip optimized parameter so btf can generate
> proper true signatures.
> 
> In the first patch of the patch set, with DW_CC_nocall filtering, 875 functions
> have signature changed. With a series of improvement, eventually only 18 functions
> remain and unfortunately these functions cannot be converted to true signatures
> due to locations. For example,
> 
> 0x0242f1f7:   DW_TAG_subprogram
>                 DW_AT_name      ("memblock_find_in_range")
>                 DW_AT_calling_convention        (DW_CC_nocall)
>                 DW_AT_type      (0x0242decc "phys_addr_t")
>                 ...
> 
> 0x0242f22e:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>                      [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>                      [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>                      [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>                   DW_AT_name    ("start")
>                   DW_AT_type    (0x0242decc "phys_addr_t")
>                   ...
> 
> 0x0242f239:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>                      [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>                      [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>                      [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                      [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>                   DW_AT_name    ("end")
>                   DW_AT_type    (0x0242decc "phys_addr_t")
>                   ...
> 
> 0x0242f245:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>                      [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>                   DW_AT_name    ("size")
>                   DW_AT_type    (0x0242decc "phys_addr_t")
>                   ...
> 
> 0x0242f250:     DW_TAG_formal_parameter
>                   DW_AT_const_value     (4096)
>                   DW_AT_name    ("align")
>                   DW_AT_type    (0x0242decc "phys_addr_t")
>                   ...
> 
> The third parameter 'size' is not from RDX. Hence, true signature is not possible for this function.
> 
> I also did some experiments on arm64. The number of signature-changed funcitons
> is 863 and finally there are 70 functions cannot be converted to true signatures.
> Through dwarf comparison of x86_64 vs. arm64, llvm arm64 backend looks like having
> more relaxation to compute parameter values for those signature-changed functions.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  btf_encoder.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 633bc61..26be31d 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1257,15 +1257,21 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  	struct btf *btf = encoder->btf;
>  	struct llvm_annotation *annot;
>  	struct parameter *param;
> -	uint8_t param_idx = 0;
> +	uint8_t param_idx = 0, skip_idx = 0;
>  	int str_off, err = 0;
>  
>  	if (!state)
>  		return -ENOMEM;
>  
> +	if (encoder->true_signature && encoder->cu->producer_clang) {
> +		ftype__for_each_parameter(ftype, param) {
> +			if (param->optimized) skip_idx++;
> +		}
> +	}
> +

the logic here is a bit confusing (to me at least). Later on in the loop below
we subtract out param->optimized parameters from the state->nr_parms count for 
the ftype->reordered_parm case. Why not just do the same for the clang optimized
out case below, i.e.
 
>  	state->addr = function__addr(fn);
>  	state->elf = func;
> -	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> +	state->nr_parms = ftype->nr_parms - skip_idx + (ftype->unspec_parms ? 1 : 0);
>  	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
>  	if (state->nr_parms > 0) {
>  		state->parms = zalloc(state->nr_parms * sizeof(*state->parms));
> @@ -1297,14 +1303,34 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  	state->reordered_parm = ftype->reordered_parm;
>  	ftype__for_each_parameter(ftype, param) {
>  		const char *name;
> +		char *final_name = NULL;
>  
>  		/* No location info/optimized + reordered means optimized out. */
>  		if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
>  			state->nr_parms--;
>  			continue;
>  		}
> -		name = parameter__name(param) ?: "";
> +		if (encoder->true_signature && encoder->cu->producer_clang && param->optimized)

just add a "state->nr_parms--;" here and get rid of skip_idx.

> +			continue;
> +
> +		name = parameter__name(param);
> +		if (!name) {
> +			name = "";
do we see more parameter DIEs without parameter names for the nocall cases?


> +		} else if (param->true_sig_member_name) {
> +			/* Non-null param->true_sig_member_name indicates that the parameter
> +			 * name is <parameter_name>__<field_name>.
> +			 */
> +			if (asprintf(&final_name, "%s__%s", name, param->true_sig_member_name) == -1) {
> +				err = -ENOMEM;
> +				goto out;
> +			}
> +			name = final_name;
> +		}
> +
>  		str_off = btf__add_str(btf, name);
> +		if (final_name)
> +			free(final_name);
> +
>  		if (str_off < 0) {
>  			err = str_off;
>  			goto out;

