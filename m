Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443C346E75;
	Tue, 27 Jan 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516396; cv=fail; b=C1HKyp4v70E4mEbB14VE6BHd3WJ9KpMbqvtafjGvMuLOo1XQrDlVzajSjZmQNr1GQRYoRjaO4ickJZ75Ti/spUtcZKC0vAI7StBw65q0/BpLTX64i+69E8LaIx6uLk/i4NZantWsF/MgKc5Mvder5LJQC2jxRRdIHWvXlt4s+oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516396; c=relaxed/simple;
	bh=MLvNgJWiIr2XU6eOFha7nyyR6trwYobg7WJ7iUzx9bQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qClW7iSpm7GxbLoasYQphjgnXYJRjpfYHIASROFqcjDKSRtzAcf/x8T3viwl3ZzoX06GSOr3UT1/+H3VHagBMw5rZzOkaKc8wcZxHmzvBnVXpvT7ljEma3f8oOHuIeQ3AfGTLfYNFZcgIiz6hLCSi9Qp9JuOXL/bPvet9cyiB9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CHlem7SB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YzsZQ0pH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CHlem7SB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YzsZQ0pH"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEIQW454942;
	Tue, 27 Jan 2026 12:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PfBJ4AQK4O3jYim2yEz/gZc3YnMT/TThFGlthXoSkT8=; b=
	CHlem7SBGl7JRIRuKrDrtgB/VIg+OCF6KkivSKJZcqok1zyJHzTX3+9Ng4FPLKAx
	lrqpEKcBx1uNcUVQSb7d+c34i0Ubq/xuFKhVNUjP2HnJSIgpAMjw0LI1Pg/k+Gu8
	pNxJiPRmBCZjDtxkgogdFqLQLsJtTbiqRJ1jMDNe/phtWC7zNxAk6TOgMp6OhT5/
	bvo5Zvi1WOPcroUW575vAO8KY+TtQYVpxh7F+/Vgi/fm78nLgANaReXXgveaylcC
	Y3Q6sMgcxXo2zAl8aEbECVZifU0gXhveTzMwtCN9pFD4IryP1UXEvFflJhXUTWim
	CgqQNq+4w7Uoadk+TicMkQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvp4buxe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 12:18:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RAjHdA010467;
	Tue, 27 Jan 2026 12:18:37 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9brhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 12:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npxT8zkchGC2V5K5iueKkd/IiUPyM2nHVTtHyXdZcx39QI62yTKIyxt43HTg7I8u6u/DQ358pkTIXVZNIRyMNOz8zavAx3NpcCAGI7UdP0Clm2ZC+RT8proxqQmUobw1GkRRvRKE7at+4gvpavwYuiPYN8aRIrnZzpsdnhaE58Q4VQoJPGLIs+Tm4rCFNMUVTd5mDyQ+GgE4RsxoNtSAWCZMLiNdfJ1lh6J2/5vODFHU/auPUlTjn+LOMyekSs9xpVYS3XmAkxwTz0hqyVZgajShbZSD5XT0Ex5gDQAZX2Ow/resC7KWiLZ+qccp0TjCLOOa5LlaExoT3piFPheIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfBJ4AQK4O3jYim2yEz/gZc3YnMT/TThFGlthXoSkT8=;
 b=YeLZNHntbJhUQbSM2q4HhkqHYZdZyQ79zOpnkXmRNfPdRF878JFsg0W3wfgnB49t0YM+XHRnuEVJmn+bNJuEoMQccL54NBjVe8a9MQEpRt76NuGPKVemlVmmjZFd3BgHT8aTyPbLa/CixHg/zt02/8o4TMnIlv0zMJlLgmsobDsfslOwKoLuFv+gqv4yLkBU09tK96Fjs6SulUWpqvtchu2ZZLFQQgLOIYZtJNvhp4ZK87B3sGsvlJ8+V20bGAjRBPOtJfnGC/4JSYamu7cZtJ9EtM8iCrOn1SQZ6zJjWnbv3DiycK8FnxCvSfvLjbFcGRNDIhSjZCcV12pNukW/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfBJ4AQK4O3jYim2yEz/gZc3YnMT/TThFGlthXoSkT8=;
 b=YzsZQ0pHP/RDm/d7fDoPIu67i6OaF0QcePsdlUr2UAlTWBkKiHjSegOycbLwIvY+rHP03LLMb+2iSYHyyibPLU09xhbDiz7nWuJk5i6Al9WngfmMezY0Id/RodFjcBELUsWjWTjEEoE5ErlhhsPPMy6Vll+ZOCscmJOyQFkGHDI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ5PPF0AE915473.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::789) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 12:18:34 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 12:18:33 +0000
Message-ID: <93346800-cdb3-4fed-ac35-ed00830bb362@oracle.com>
Date: Tue, 27 Jan 2026 12:18:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 2/5] btf_encoder: Add true_signature feature
 support for "."-suffixed functions
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: yonghong.song@linux.dev, ihor.solodrai@linux.dev, eddyz87@gmail.com,
        jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
        david.faust@oracle.com, dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-3-alan.maguire@oracle.com>
 <aXc5XXZvgJAHMf6v@google.com>
 <e25e9c26-933e-4aa3-822c-9e1181b0118a@oracle.com>
 <aXdNkRerXTKAX3Ds@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aXdNkRerXTKAX3Ds@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::23) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ5PPF0AE915473:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ce8724-eed9-4c71-19ab-08de5d9e308e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWhtOWttM2RQQnVXcWIrRUo4NVk0Q0kwZ2RBSkdjR3dYZXNuVnRWbFFRaHJV?=
 =?utf-8?B?ayt1Y2g1ZlAxU0RzVzF4bjhXbG5tTk4yWlREbmNVTjB3R3JNZFZVR0hiSmNT?=
 =?utf-8?B?bEJ2RFRQY2M1REJPaU1IZzVDL1poRU9SNUttZHVNMkpFdEE1aEZQMytzb1Zo?=
 =?utf-8?B?YlFlSm9sOW5ZMWxWVHlPc3JyY2Zsam5xV3RsdVJsNTYwcGJQVmJaRHIyMGZr?=
 =?utf-8?B?dncxZXNUQzBmdHl2QUxBY0RJZGc4L2EzZkhoaWhKdHMybWZOT24rZUVkZ1FM?=
 =?utf-8?B?YkltdzFhQ2Zya3FhVGpTVUdMTTdJV3gvRjVKY1JxUTcwUG5RSzQ1MXlSSWU1?=
 =?utf-8?B?VlZ6ZlVjSXFGaVlMRVhFT2xTTzlqL2NLM1hSbHhoMm10Ty93bll5QVhXNnVS?=
 =?utf-8?B?K1lYaHNFUnZiekdsU2VJZmFKR1FkcnpOenZxMCtiUEVzaFV4OVNVbDhOZmRU?=
 =?utf-8?B?WTZhc2Vld21CNjdCSkZjWU1EZjVhN0tVTWtPQ0lkQkp3czhWK2pOeDFVekE1?=
 =?utf-8?B?MWQ1Zk41YzNMeVZrT05jMWNkZVp2ellSTExMcS9PWFd0cGpmbi96VklXb1Y1?=
 =?utf-8?B?aWMybmlYa3hSaWpma2xpdWNqakhBLzcwdURiSWRjeFdaS21oVXg0WGFldXRo?=
 =?utf-8?B?MFRxazRmcktxeVN4a1Z0SlZ6Z2hEeDlZVXI2dm5BbEZxYmd1M2tpemdRalZy?=
 =?utf-8?B?RFJkYm5mdWVZN1hFOENPamhWZ1llSkVOQlI0QW56ai9nU2djNGw3aVZndHRI?=
 =?utf-8?B?aE4rMVVRQ0V1UjFxQ1l6c2t3SG1Tbk1yK0NxR2FDU1RmTGc3OVRiOEtFVmp1?=
 =?utf-8?B?NXBpT3d0THdpN3h3Skl0VHc4eG9aMlBMTmhCNU9kaUxKV1ltUEdnTHVFMTRS?=
 =?utf-8?B?cWY5Rk95MDJlVWhUOVhEQVFodG1MbnRDRk9obnM5SzJrY3czait0bENkT2JD?=
 =?utf-8?B?RUR6V3AyMVVhN3dNZVo2TXI1eWpxTnlMSWxCZmMxWGozSE9pRm9ZNW9pSk5n?=
 =?utf-8?B?ME5zZC9KSS90SGdCa0FwRGJwaE4zNDdOMUpiK3E1MHkxR2lSREx6cXJsZWtu?=
 =?utf-8?B?enBOSlpxb3hsWEdSNHZrekhDQW1tZWVURDN3TVhaL2tsc1J3bFMrMkdyUU9n?=
 =?utf-8?B?SnJtT3lZNGFvclZ1OXNNaTdlQ3FQTmlZbGFiOHdNOHV1aGc4NGF3c0NsVlUw?=
 =?utf-8?B?TVpRZ0R4S2MycG5uTk50VWFhTjFNc0JBNHY5V3JmL2hYUUtFeTNPd1RsejYr?=
 =?utf-8?B?ZUlPRHVSekZhRDlwNGxqRFNibGgzRkhyakNXSEl1SC94dVRLR29xQmNuQ1Z3?=
 =?utf-8?B?SU9DNW1TeXI3alEwNzlNdTlxNEpqQTJYK3dIR0M5V1A4KzhGSzhYeDdueDNH?=
 =?utf-8?B?OVk2a1Z5RkhBdjg5bWpjbFVNcWxxTDQ0VlBFdzE2ZUhUOG8xSTMwYTN5MjJS?=
 =?utf-8?B?bEhCM0VZbk82TlZ3djNmRzBOVXBKaE9OUUVTVWc2WFJWa0ZCOE5pazgwTXZv?=
 =?utf-8?B?MHFVTzc5blBLT0k1TkpOSXpvTSs1UWZ2M2JiWW9PQzBYdElBcTlkNjV4SVhU?=
 =?utf-8?B?ZDdLUHJQNnBpelNHMC9FUjF1c0E2M0dVR3hJaEx1RVplUnQ4ekNPVkNxcWNs?=
 =?utf-8?B?bWt0Mm9qZFBOZzBjSVVkM3FFTjhsb0FRS3YyYnMvdXY5S3RVRHNvZndLQUky?=
 =?utf-8?B?SEpJVWphSE1uSmFnZXdVb1RDNTVYSi9JRmFManpuUHZCbUpHK2FGNWFyMm5t?=
 =?utf-8?B?dUJFSStyV3Vvb2xHYjAzMGdwMUNzUHhvZCtlN1NOM2RYc2hIY2dEaXFqQlQ1?=
 =?utf-8?B?UkdYTTJCSnVYMEpTQW5QM3BkdUtOaFJUUWdmck1ocE1IM1Y5MEFQemxacW02?=
 =?utf-8?B?K2pacUxkeTh5YXR0N1VlVk1uUmtmamx4T1FtOHNYcExBbHVVOUNTdHNkdUNO?=
 =?utf-8?B?bXcwRk5vRGwzdzNOaXNMR2l2N01xNEtHa3JLZjhrNlRCYVkxOEh3Z3VYMWdW?=
 =?utf-8?B?OW02RmREVkhZa1l5aklGRjNCdEZVdmE5T09vRUpRV05GMFZaWlJYU1MxbzdR?=
 =?utf-8?B?VGpCdnVWL3Z6RmhUbWdQZy92ci91R2UwUDlGVXpHaUUyaFl6cmhRbUFNaDZ1?=
 =?utf-8?Q?T0Zg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0tMVGJnQ1I0RlN6QldWMnBPMnc1aUk4b3VQbmJuMjY4ZERZT2FHdmsxZkdw?=
 =?utf-8?B?VG1JWlM4WlZsZFc0WUQ2MExDZFlOL0M2cUorOUZrVEdkaHBlbUs5SG1XZjdy?=
 =?utf-8?B?M0QzLzhoYVJaOEJvMDVMclFqY29EOEIxSkc2ekoyOThqYStmNkRvV0xnUnNi?=
 =?utf-8?B?WVZ3VE9UcU1Jamg1eDdza25vTUF5eHJuTkU1RVhOM3prZUdsSW1KL2J1dGRK?=
 =?utf-8?B?eTlFTEtuVThIeWI4eFZROTFPdjB1RFNVWHpHd0VVVVhHM1krQkZlZEwzM3A1?=
 =?utf-8?B?M0c0eGZUQ1Y3dEkzRnpWMzZnZjJ5TFBmeER4TUl4TEk2akc2ek4vT2t4bFpW?=
 =?utf-8?B?VlBBT0hJOHdkUmFmUVJ3RnBvUjJ5b1FQOGRDY0Z0eXZFejBOWktFblBkTThs?=
 =?utf-8?B?MWpTbU1MMUh5UDVqRXRLV3hweTNYU0MzRVAwYXdrM1lDckd6dDd0eWNybHpF?=
 =?utf-8?B?UkgrOEtpakdKZlVORG01RURSNHlKaHNjM3dFVEFwN1YzeGJMSGs3Sm1lNDFT?=
 =?utf-8?B?Wmk1K1VoUmk2My9NV1Uwb0E5VlYwdll0bW1ONGdNKytpZHQ1U3dYWGlTUWlC?=
 =?utf-8?B?R01aNWFhWGZZWXpZdW5SL0hxSndqRjlGM2hZOE1UWms2ZU82SUptZUtxVWcw?=
 =?utf-8?B?aUlzOGdtK3JORlFvNHRLbkhCSGJpZnhJaGkza1Ayb3ZKQjRKOVBSNVdwZVBz?=
 =?utf-8?B?T1NYWWFhbUtQNDl2Y0ZaL010TncwenFMSjk0UVp5Z1pHUkp2dDR4U29oRlRr?=
 =?utf-8?B?clk3djgxRnFYU21uMnNidThUT3FSd1plNWRid2Izb3ZTQ2FFd3pCaDF1b3RR?=
 =?utf-8?B?QVVXR21wTkdEbFNPR0pYMDJ0QmV5M3F2dHIrV1ZTVGpsMlB2aHJDdWthbkVo?=
 =?utf-8?B?NC9JTS85SGY1eVdMMklZcHdVVXlybWVYQnp4SVF0RXVSMWZGblZtZGIrVEYw?=
 =?utf-8?B?QW50NmdMeG5MV3JuTHUyMHY5ZnVtNi96cUYxbW1XOGFtSW0yWml0MWxCbllU?=
 =?utf-8?B?RkcrZysxV0JTeko3QnY3SnNDdlRLY1lLalhjVWFCekpEUWx1bWxnenRqamYr?=
 =?utf-8?B?dy83RHcyZTYveGhsckNHaWFjUnJCUDBmc3pQbVJIQ2lyaTZrZGpRNDc1cE40?=
 =?utf-8?B?MWUzUXpvZGJHWVUyMXRGWEhlbnM2a01jYUdlNDEvUlBESVFMMTFEQlEwd0xV?=
 =?utf-8?B?WjIvcExkWkVGU3drekp1SUVPOFIyMjh4OVdRdmtFOVp2eEJvdGxlL3dVUTJX?=
 =?utf-8?B?by9IQmNYUE1acS9kUEd4d1ZLdXVOYTJFM1RhNFI3YjB0SkhHUjdONFB1WkZR?=
 =?utf-8?B?Yjh1ZStsNmlaRm9iMUhIY0tGUVlkREh4UFFSdlNjMGNJSzM3dnJ1ZFQ4Tm9Z?=
 =?utf-8?B?ZjdRNTZ5aldLK2ZDcjFiRWFncVlscUdxTHF0SmgvckJuZDh6Rm40d295bTBs?=
 =?utf-8?B?NHNQRUVPQlpnVkZiNFRsRlQ0Y2FqRFh6UFMveGFQdXRhMFBSTk84VUlVUGxK?=
 =?utf-8?B?U3pqRElpWUJ0dDlvZUxQR2VQbVVqdkErY1JPUFNpSHo0ZnNBTUREeWxsNiti?=
 =?utf-8?B?alNiT3lGbDFqajFtNVQrSDRUZjBVRGYxR1F6VjQ5MW9JZ3RYYklrbG1HS0g0?=
 =?utf-8?B?YitTMnlqN1dwS3RqZlpyVDl6aGdlRGxhOG82ck00Rm1sWkRKcXJaUmp6Mi9D?=
 =?utf-8?B?TGJSU0RweFI0RHJBUllabFppWXpzTTFjYVdObFFwa29taFZTSXIrQW5WVjE0?=
 =?utf-8?B?QzFrUGM2QStXSnBUQWpEdFZuWHdYNGpNRXhLd0RTZGd0YVVXNTNuYks0N0Q0?=
 =?utf-8?B?a1dXMFZnVTRLVEVKM09XZzh3SWJOUnorTGZDVk5URE1yRFNNV3BHZ1YyWlRN?=
 =?utf-8?B?UzREeXQ3eUp5ZTRlcy9CVGg3c2lzd3J2MGtGcktZbFlLVGt0RHMwVkJVSytT?=
 =?utf-8?B?ZWVvZWNMSzhlWldrak80VnZZYTRpQXRRZXRkNjJpWnlGRGR3bkVuc1B4SkZI?=
 =?utf-8?B?MTBvVGNSdUNXak12WndDVVIvNE16d1oreTBxS0dCNytCZWhUZGE4Vm1hSVBQ?=
 =?utf-8?B?akF4bmY2MzNZMnY5QU9mR3lvckdHOG5DdFRFNWZIbVNxeWlnL011R2k0MEFt?=
 =?utf-8?B?NWRWTFRPTERXeit3RDdqQjZHaU1QVThJc3F5V1VSSlREamY5Y2xSdVJQYWo0?=
 =?utf-8?B?N2taRnZXY0FwR09Uc3hQb05RUzVKZkRnUGJyYTVUU2FLdnRpRUViTG5vZnV2?=
 =?utf-8?B?V3Mzbmw0VXhMaUxjODhwOUM0dkFWVVN5T2NOMnk2T0hUdGI3akgxbkVYeWMx?=
 =?utf-8?B?L3VpMmhFYlB3amhyZFc0WG1oZTNpeTI4bG9vQ3BiaHVXNGNrUjBNQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ohwCh8WBEw8mH2+XPl7gM67CLqIPqTsJXaan/otSQCfrPdn5T381TWXrNHqfusVHUS44ckdmsbA09HkDgkxfUTWomoZQimd2oXlczMT3vOAa/f7EGLGLvgUy4fFRRIjxRqCzd03m+u+JZ6kETv+bk95uPaA8ay6O6TjJpXWD7LpxG6z7kPdToDo5Q4+u4y/HjYYLlZSB44T+bO/HCw/WKmXDFoxgsxdP8RmvNo3rvwRV1un3MWJuKQwUtJhsfAbc0V2GWNlFT/aKeYfs0sqOvEgF8zwXcgnf2xZsY7MxPoz1QW/tJNmfDBv302gOkzNdVmUjcCh/i9cKSIQODW9icsefh4L+z1mhuVPMCs0b3rtfAC0pZXlI0F8QorzULHIVu3LKXn80bTyigqvR5iAaHf1GmcqiXbIJtUyhbOHs4QgLfSUJ3qKn9rxKYunZK8iR3lYs5mGXHHuMTqETOQFextzFbqlWKZcXiATbWsltjfs/JSbKjqgM1EM6vkyD+rxcXd5lv+DtG9oyxip0usijJs2JC/9zDzAYbHt5LINI4TjkHnvWj8He9UQka/tHrkqusZMT1/lBz8mUtLYOJpNjfH7QmCSz6ZCUoVZL7NHXRmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ce8724-eed9-4c71-19ab-08de5d9e308e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 12:18:33.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcIU9fve4/DSQ4iqNq+WN2lAZqiAzFp9qK7fqe6Li/Uh43DdCNAF8dTCjqaoqFzF7RPR4QutuvFkmcubB39NQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AE915473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270100
X-Proofpoint-ORIG-GUID: 9NmCWbz4RaUlBCJpy3tzwkitsma0wYpl
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=6978ad1e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=twB2v72KjqrEOxruYYYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9NmCWbz4RaUlBCJpy3tzwkitsma0wYpl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwMCBTYWx0ZWRfX644stkFwDjSa
 3D8ZORU72RYN2L6Xl5D0ceCoSySmhuehNEOyqZ5NfgOIgg5ELw9N3y/gh1xxdIXGOIJXhNN2uTn
 XATpbEN4R4OWWa9VMAr2z/15uTfQlh2YDFVXLDL/JsLSiv0vObLY5Ng3BMDv4jQJtgLvmYrHcQa
 RxK+JFx4GtPdv7Zv/K2xcs8h5h58XlAA4Ti6IUMuz/4cgyPjhQZPuOgqVyUpe9gnyZd06j/Xegd
 yoL12k0c0vPsz5NJ0DrkrW+4A+8zKNZVy4VjeNMldpXmuzPZ+UNX08j9h7b+LQWrfH2zj+2PQsE
 FhYyCoZEBVwosR24edQTseCGFr+H8pVZGzK4K3U58ZxHfqWBHIX/7d1AFVmlJ4aCRXDRzsjzecw
 Qpy9zpW9yfcNpwLfc+1C/lC422Hv2L3LM27HisvzJJLnJFd45719mRgKoPfhvDxwcBPB8nidr+N
 /ssGfBGSStS6rmK3bPA==

On 26/01/2026 11:18, Matt Bobrowski wrote:
> On Mon, Jan 26, 2026 at 10:49:00AM +0000, Alan Maguire wrote:
>> On 26/01/2026 09:52, Matt Bobrowski wrote:
>>> On Fri, Jan 23, 2026 at 05:26:47PM +0000, Alan Maguire wrote:
>>>> Currently we collate function information by name and add functions
>>>> provided there are no inconsistencies across various representations.
>>>>
>>>> For true_signature support - where we wish to add the real signature
>>>> of a function even if it differs from source level - we need to do
>>>> a few things:
>>>>
>>>> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
>>>>    we can do this via the address associated with the function.
>>>>    In doing this, we can then be confident that the debug info
>>>>    for foo.isra.0 is the right info for the function at that
>>>>    address.
>>>>
>>>> 2. When adding saved functions we need to look for such cases
>>>>    and provided they do not violate other constraints around BTF
>>>>    representation - unexpected reg usage for function, uncertain
>>>>    parameter location or ambiguous address - we add them with
>>>>    their "."-suffixed name.  The latter can be used as a signal
>>>>    that the function is transformed from the original.
>>>>
>>>> Doing this adds 500 functions to BTF.  These are traceable with
>>>> their "."-suffix names and because we have excluded ambiguous
>>>> address cases we know exactly which function address they refer
>>>> to.
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>
>>> Some minor nits, but apart from that it looks OK to me.
>>>
>>> Acked-by: Matt Bobrowski <mattbobrowski@google.com>
>>>
>>>> ---
>>>>  btf_encoder.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>>>  dwarves.h     |  1 +
>>>>  pahole.c      |  1 +
>>>>  3 files changed, 71 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>> index 9a567e4..c1002c3 100644
>>>> --- a/btf_encoder.c
>>>> +++ b/btf_encoder.c
>>>> @@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
>>>>  	int16_t component_idx;
>>>>  };
>>>>  
>>>> +struct elf_function_sym {
>>>> +	const char *name;
>>>> +	uint64_t addr;
>>>> +};
>>>> +
>>>>  /* state used to do later encoding of saved functions */
>>>>  struct btf_encoder_func_state {
>>>>  	struct elf_function *elf;
>>>> +	struct elf_function_sym *sym;
>>>> +	uint64_t addr;
>>>   		 ^
>>> 		 This appears to have leaked into wrong commit?
>>> 		 This member should've been introduced within patch
>>> 		 5/5.
>>>
>>
>> It's used here too though; specifically in btf_encoder__save_func()
>> below. We need to use addresses to map between a DWARF representation
>> and the associated ELF function to ensure we're using debug info
>> for the correct "."-suffixed function. We need to do this because
>> the late DWARF generated after optimizations are applied uses
>> the original name ("foo" rather than "foo.isra.0").
> 
> Sorry, I thought I only saw usage of member "addr" within
> btf_encoder__save_func() against fn->lenblock.ip.addr which maps to
> member "addr" within struct ip_tag and func->syms[i].addr which maps
> to member "addr" within struct elf_function_sym. Member "addr" within
> struct btf_encoder_func_state remains unused until patch 5/5 where we
> assign it the value returned from function__addr().
> 
> With that said, within btf_encoder__save_func() why don't you do the
> following instead:
> 
> state->addr = function__addr(fn);
> 
> ...
> 
> if (encoder->true_signature && state->addr) {
> 	if (state->addr != func->syms[i].addr) {
> 		...
> 	}
> }
> 
> There's no need to open code fn->lexblock.ip.addr everywhere as it
> deminishes readability.
>

yep, good suggestion, will do this for v3 which should be ready shortly..
