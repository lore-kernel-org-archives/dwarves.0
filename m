Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C7221FDE;
	Mon, 26 Jan 2026 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424595; cv=fail; b=RBg73HNyFa7igAq082v9t/1uj+JR9SvS+hU4I35EBY6ES3OfF1pYuAHd9zUub0Vg1vI/7RYtSLUrROc3h1umKQtxLDOfupEk+hkhMKqImySzpMNrA468h+k65cpLoSP1fKBqEbOUZw1YYc4SeaYWMwwk47EDTAKxjQSy7yLWW0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424595; c=relaxed/simple;
	bh=MGmES6+atZknEg1B2JOeCWMO4APsr5dP232cIvMsG4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fDQlQ00CnDhgr4NJ5nWmbo6/H4Sf9QIUO/Klith0u0aqT3J+xX07NXQXLfui/E1o/ptGAd20bkq0F/ozbSF4DTUTaaZ8pVdus3UVNQ5mQjka6MQ4DsLcWGgU4G+mZkSLpFxK2dMRAfXp8QGrWBAKRDgKHybugyhuJRQs3w+C8uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c/V/Z/f2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I22fgbjV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c/V/Z/f2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I22fgbjV"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q1h5gD502192;
	Mon, 26 Jan 2026 10:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e+prlG/tKpvQp+sWqvLsoyZ0SCTm+K0oz9xICAwQK4s=; b=
	c/V/Z/f2bdBVR/ny5r7zmp18A6bI2T9mAoAL60TAr4ebVRM/twdZ2eMgCsSK43tq
	WMDWzWTADXwAkkqg5tBvVF48P67MW/TIe2bOsBQqZSRnIX1ipEv5TBlxNwJhYVS1
	nV/7iodhQiclo4HpS8p4cjZSnVR/+DgdXC5fOheXmPwzboQFbvWV0m8LBaIY3fKA
	Cn2o8aeaRQo1hX+vbca9PlkGkYlIGpA6L0G35vDuuxBm+1OWIRIBJw6+1MrGIFcI
	NbUF+pKtL8yRFuM6B/qcoajGasU7G1Xadi9/4d07Ns0hJ82rRhcZJBiXJskn512o
	INJeuQo/uwJiALIIoCGH5g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmv2snw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 10:49:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60Q9BcG9010533;
	Mon, 26 Jan 2026 10:49:40 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh7tr38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 10:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvKwUJTKDoI18lRGmw3nS+wlVTM2tBgA5wA+Zy6eGFKc1p1VSEfcQlUcRwEwJseSOGX1v6K1nKtfnG2T0R8pCwFCOq5pOKyAI7Otlsq5Mbm8Hr2BOWyxtK/r97DJRYMcOiPO6ziE0FjjeWCzVItGvk2Nhdt+SphU3ke3C/pHAiD33C+xebmCmqV6LU4E6OjXDhsZ6m5if/gGC0KjWMr8Y7qdFnnyxmEZtLX91gS2RwoEQ1+IxM1vJDCNYg9OYAP6ftbxMDLqrjT+szS7iso0aXLE/wJRo68ERCxchJyHqZvaRwx6nj/Pz6zUAv1QsYKysaZtDEOF9RTFgMNSzyWREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+prlG/tKpvQp+sWqvLsoyZ0SCTm+K0oz9xICAwQK4s=;
 b=tJ91lUw9sNDQvYiNQOAWqwXWDvEQrzX2Use3DUtD10YLRVr2mGj6L/Nb6FQHcm3nJXMBGgHZUcFDTIi7hXBWyUoWQ1C46LED4pDcu55bAG1fSQ3rRluzRMZ/LnIh2+vSsFQ9kFPHVIwBfMJsx8f3zhPa38a2SqoeddEqoSNfYDqre83/tziKHabFmaULX0t4D8KcIT2CvR6cmT0I16z4nA3ysmUeCzBFieEDNA4b9H0mYuYt4VsHDU6lbzq3NTmnx5+cCYGl5/pZIr47YhZdOhyBpdzRkkwvKPU/uSBYoBO5ZFfkuWJ/9LWvseH+ZJ6KSYhK111B196+M3wlV/n+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+prlG/tKpvQp+sWqvLsoyZ0SCTm+K0oz9xICAwQK4s=;
 b=I22fgbjVbwwXl2C967ggixWlQNR4VsWTusfv/TrXXGpZu4Pbvqt40k5A9Dp4fbajSZljeFCarSmbiaOJhCJylz9OIzhdXZRswOvXQkkvWwpnwjI7i6UIkvCnuiFnvsg31SI3+fOIT2dsapq5Pz2UYu3c7pl3Z1R25+PDIAaDqFA=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by PH7PR10MB6458.namprd10.prod.outlook.com (2603:10b6:510:1ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:49:30 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:49:30 +0000
Message-ID: <e25e9c26-933e-4aa3-822c-9e1181b0118a@oracle.com>
Date: Mon, 26 Jan 2026 10:49:00 +0000
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
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aXc5XXZvgJAHMf6v@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0025.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::30) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|PH7PR10MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d2051f-832b-42fc-78ad-08de5cc88d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTFDdVhWdGxEbmFLTUgxNzlwNDkvQ3RtOUoxcnBGQ1RRSURZZUpQN2xJQjZF?=
 =?utf-8?B?UDM0MXRlYnBwK0hhSTcwRXNOdk1TQzgxenBtMGRseldGMm9wRzhVZ3I0VjE0?=
 =?utf-8?B?WS9KT2VSS0M3dmR3L3pWSmZ6YytJVmx2ajhteGhzc1hZWWFpdi8vOVBJV0hJ?=
 =?utf-8?B?Q1RKYnpwNkVRVnZYbVo1RXVSSGtmalNZeEVtZHdMNFplbUxJQWxGNHdwbE1N?=
 =?utf-8?B?Umx6TWZka2dsWTBLTDNIMC9oVTd1WWVyczZEUXdIV0ZLUUtVMWZac1BjSzRQ?=
 =?utf-8?B?QXlyQVhjenNzTkpzOFFhQ1ZEWGJPQ09mT25yYjVaRXF2UExrMnpqdEtJcEhT?=
 =?utf-8?B?WEdWY3E5bmxZNXNISWMyUk1KajVTbkNacFVTLytST3E4Nk9hVE9zZW1GU1lH?=
 =?utf-8?B?eVdXZFVreHE3WWpFL1g0ZDlrb1RzZTZnS21xSE1KVEY0L1Z6bzc3VlROcVZP?=
 =?utf-8?B?Qnlsa2JjbHF0Si9OZGN6YXM1alJpaFBUWVMrL3N1dlpQZk1JNzAxc1BReGln?=
 =?utf-8?B?Nmh6MkVYbTBrVmJFQmdZY211ajZMQU9sNU40WWhIZXVMVFVKSVB0VVVvQlBY?=
 =?utf-8?B?K09VUXFEdURObXdETlpYSUFheklWT1dZaWFtcjRFb3ppWDNDREhKOUt0L3hp?=
 =?utf-8?B?SkdzT3MxeW13dlhrY3lZam9jK25HNDlGZlkxeFJtVDVPU3FBN3Nzc25BTnpH?=
 =?utf-8?B?NHIvNG1rZmhIb2Q2cm8yYjZJSUk1cDY0bzZPcTBmRUhnUmhnZ3NxUFdibWly?=
 =?utf-8?B?ZForUGViMnM1Wng4WllQQ1U1Rzd2WXB0NW5iNGxTejNXOU5aaFpEVWZQaGha?=
 =?utf-8?B?a1htRnNuV1FLQUhpQVc5bVB0TE5YeWJzSnRJTTkzRkhEN0FaTU5vUk9MMzh3?=
 =?utf-8?B?UFQzaGFXQUhKUkVucTAycHlqUWlhNkhqV2dEWWxaYWdHMG9WcjNieUJ6WEcx?=
 =?utf-8?B?VnJIU0l1anlocGNTVVJQRTdxNXB4NFRhaExsQUQ5b29qQ2R6ZVlTektiakJv?=
 =?utf-8?B?TnQ4T1VQRjJGa3ZtSUhSS0QyL0NvMDhZUVVIUDhVMmNBRGk4TDN6ZTlDVmZq?=
 =?utf-8?B?QlpJMVFIYWx6dUl2VFUvUmpjV3BRblY0QmExUGEwZmVpVHppK2UrUFZ5YUhV?=
 =?utf-8?B?NHJ4Qi9iNW1HWmhFTWIyMzN6M1RXZXBiS2hFaEVQc1F0QkpCSzZPV3BTL0l0?=
 =?utf-8?B?WkJQYUY5QW5kUXNWcEpNeE9DV2RaOVd1MHBRcDh2Y2pnejcwNnV1bS9pb0xO?=
 =?utf-8?B?ZWxMWEZxUDRyazF3YU95SGQzV1Iwbmw4QUhTbXladEFLZnE2a0k1SXAxeFcw?=
 =?utf-8?B?R21PYU90RERRblY0SFU3WkpFR3Zvb0xhWEc3MGhHRlp6WmlqV1o4bzRURmpG?=
 =?utf-8?B?Y1BRWWVJK0UxSzVwNTJLQjE4VEVZQzBIZzJWN3pBYVYrN3d6Smg1T2svNDBx?=
 =?utf-8?B?ZG1WTFNOcDZpa0ZQazlMWklyN00xa0tXejhKQXVvS096alpkNU1pb3VzdlZq?=
 =?utf-8?B?WjdYMGZRTTdOaTRDdEZrdkVycUpMVXh4c283TUtqZDRiSEFVTmRXM1lVWEV4?=
 =?utf-8?B?UXVGYnFVYkNrVVlXdng4Wlg0ZllGZmtKV1pmY2crRHNjWWt2T2U5UnU3YXJC?=
 =?utf-8?B?a3J4L1NMOVl1RGZoVXZyYldxbXJ4dkhYUGtSdXkvdzJpb0FwZW9GUW01cTJl?=
 =?utf-8?B?Mm5tdWsrRFljb1B4cVpoUlZZTWlmb3llNkRJK2hNSm1CQ3NLWHlDTFNEejEx?=
 =?utf-8?B?b05DSVl5bnFEcm1uc09LNTJib1lCSUIvbGZZa2tweHBlNStkTjNzYU84N3k3?=
 =?utf-8?B?bFJNOFVyeVp6cVNVUFB0TUhiSVMrTWZnMUxNYktvQis1cHUzaTc0MWlEbENB?=
 =?utf-8?B?Rkh3dUdpTlZ3UnVwbjZsUW5iNkxLQTV2ZUdSNDJNVTl5ZXg0ZFpRU1Z1NCt4?=
 =?utf-8?B?a3VqZDdHaDJxRlNQd2s2Wm5WYXY2Vy9JSG1CY2l4UG1STGlrQXdiTzNldGtl?=
 =?utf-8?B?WERoUHYrR1ZqazVDcmU3RkdLTm9kcnlJUHp5aWRvSWsrdm5YSXdxNklGSEpU?=
 =?utf-8?B?QVllN1dvRERoQkNrb3pmTktyQWs1VHhSNEVGaGRmSDVyempoZ3YvNVREai8r?=
 =?utf-8?Q?sF24=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2RlbDUrMG00NCsrbVpsUjM1SkJQbWVJc25YTnFaVFVMVzV6V0o2NjVsbEF4?=
 =?utf-8?B?N2VpaFU4a09TRjdPNExKVW5FNWdka2pObjJ3SXZXTzAwK1MyNTZqOFFvZ0E3?=
 =?utf-8?B?VGIzSmhBWGJhbC9MSVVnY2ovZlc0Q1B1Mzh3aUNFblZxYXZrOUtFRGh6UXM5?=
 =?utf-8?B?aVZVZE9YMlI4TVhoTHcrZk5RaVdCZ2lIb0FQTHpSc0xhQm1tSkR3czkrSFQ2?=
 =?utf-8?B?c2IveW40OUJudFhSbTR6ckdqeDNpeklVNHlyUnVoSXVMQVp5N1k3WXZ2d2p2?=
 =?utf-8?B?WUZSVytCWWdNcUN0YVBSU0FVb012Ym1SRkpzUVNCQUxtRzZnaWVqMGRQUE1S?=
 =?utf-8?B?K3A4YkFPeTVMTmkwb3I1WXV0Q0xhTUVXM0QvY3drUDA5UHFlNGhBUGNvd3JO?=
 =?utf-8?B?TnJBQUJMbnZ3VUFyZmlZMGhsSEpFaTE4cFVVaFFNR3ZoeHhVcGJNL2tTd3ZX?=
 =?utf-8?B?K1NMSHJQbWpIbGdjbGM2ZW5jaTFJWDR6NUNGaThWWlZ2YklWTldwT0VXNk1B?=
 =?utf-8?B?dW5JMUdENk5oVmZtNTFOMUI1TG9ocS9KODFJQnBaM0hKSUtlS2FCSU04Nkhn?=
 =?utf-8?B?ckhhUWlCV2dDeG1MWTRaclQ3Vmc1VWlvUjR6VnFad1UyMEFucVVUL2l3QUli?=
 =?utf-8?B?N2dGNVRFRFo3Zy9nVEtrNzV6a2p0YWRscTQ5NkFqQTJud3VWNGo3Q0FOdGRZ?=
 =?utf-8?B?RHE2SUdMemphYzMxb3BEaHR1U0tXQThiZXQ3TFU3K0VRY0FWSWkwUHdtRGg3?=
 =?utf-8?B?UElScWpiYzY3b1cyL2pYTTBRWHJqdzBoZ3VkS2p1NVBrd3BWV1ZSR3ZUMzd4?=
 =?utf-8?B?SUdiOGhHQ3lJMk5RbEdNTkVkbFFFUmt1Zm10U1NtVkJQbEw2UGwvcmhaYkY3?=
 =?utf-8?B?dkRHSWk3cW9xQ1VUckl6MnpHM3F0dkJscHRFQnp0eUlHWlpkd1BPSERKL2Ji?=
 =?utf-8?B?TSt3M0U4K2hKV1JieWxRUXcyNWtrOHU2UDRGTkdVSVJRaTU2eEJjTXdSTlM4?=
 =?utf-8?B?cGpGdW1obndaTEZlejZ4czlJczc2ek5TYzVpMGNjSGZDejVNYW1wVDMzSUpp?=
 =?utf-8?B?TjBhcjJEOHpXYy9VVUZMQ3RXckZOZzdvS3YxMEhpdW9LREV6Y3RXS3BYRGda?=
 =?utf-8?B?T2FxSzR0clZhVlNEa0RmaU1VMlE0SjFUc2xOZm1mTmRjV0U1cFlxYncweVlJ?=
 =?utf-8?B?UlQ3bGZqT2c0RVVOVnFtaUpPSzFmYzh4NHNjajRtWHVvK0VxRjQvMVp4S0RX?=
 =?utf-8?B?Um1PVHZTQzNFemtqYjdoUjdkSldyaVpNdkx1dldpWG5TUlBwNE96cnZJc25Z?=
 =?utf-8?B?QkZOZElBUUUxRm9JMzJlRVhnZEo4bFM5KzFDcTFJWjg0eWtlcHhYaFpnU1Js?=
 =?utf-8?B?WnUvRnlLMlg3Y1Jrb1p4cExtVUk4RkQ2MXk1SGVmaTIzbXVUeE1CUXNxSC9s?=
 =?utf-8?B?eWNLcU5VSTY2NGtlcVI2bDJUOTcwbUdvdkludkhkdVlkTXZlNE1iem9XYWRP?=
 =?utf-8?B?VHBPVHdvYWtQRUVlS1JBZk9Hd2R4SC9SUkFFZnlrM2xoemRTeFY1MmRCQ1lL?=
 =?utf-8?B?d1F2TzhsS1N0L2p3NHh1VGQ4Z0lSUXh2SHpyVkFqNndXZXYzbnprTlFzR3NB?=
 =?utf-8?B?VjY2NUFmdUxKejBXQi9oZzcxZlV0MFdEeHdjbUtadEVKbVpjN09PSUg2cXFp?=
 =?utf-8?B?bEIwNUJKRXJwdGJ1TWRZREV3alpUU1BpeFlpZlh4Z293N09WUzFpcit6UGNS?=
 =?utf-8?B?SHpOUVdia2JZNXlvbzU3TEtEQldqdEN4VkpLeFMyQjdOYmJPa2tYc2FGbWdI?=
 =?utf-8?B?YTRmLzFiSkozMWJsMGh2bVYxYUloT2F5b2FDblNUSHB3WStZV1VHbEdqZFV4?=
 =?utf-8?B?ZGRJeEdQbFRESGh1SGg5SmZlQU9mUTNpTStvcWhMSG1sVjJiVjlkVWZaaWFD?=
 =?utf-8?B?ZGg2T2pZekNDRE84UnJ2QURnUUpZRGUzcm5uKzU2QXFML1h5ZzdZc0RvdDhX?=
 =?utf-8?B?bEpCM0I2cmorQUNEY29WcUNHL3N5NGlFaXZvUVJsTGdUaG5mMjdsL2I5Vm1m?=
 =?utf-8?B?Y09nR1BNUWk4R0t0c3JMSkh0cy92Unp4d3VvZ3pYb091SFpIOERpOUlpRWo5?=
 =?utf-8?B?M3FCRHhuNXBuN0cxa0hmZytqaVIrSXltOExZNlhEUFBYZEwrckRBdUUxTko3?=
 =?utf-8?B?TDl3OWExMEZsSjdVZmlUV0RYNXk4OENvTW9RelVsSzZRd2RzOGdLa0gzNmRT?=
 =?utf-8?B?UEtZRGxMMlZGNkJRY2h6Z3JWZzU0V0NJaTRZZ0N2ZW9JWXNmMjlFcGpSMm92?=
 =?utf-8?B?a1J4U0dxem1LeUVYR25IWkovaElZL1BqV3R6cjNnZDFsaXBJN01tQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HsOlV/F/a7+F6DjEs2x1W/BC2fYRtoIEh1oTFzGAS1YMFFC90+M1FDIMI+S2g+aJdi+A/GI3v2bXQBDLlbCCsJ2KPgzkmFyRdqeSvdjCFzZIBSn+G7cSfx45wZ2YegGdIdB0OFv7r0LGv4GWFBIJDdTYrL157Z57Am07dgFeIDzT2PzPGnhcTLBts2wB+Z7Kf4ZJyhwKxWvyWjG/RMi73hx5kUElbrdfu1BqPb1u6AJhNYnGjM/l+/5YM37rbVuHjvHK16483U4MxMa34laVjAFby2Abe2PsV+bUxiPUTx1G2f4Fac05vqyUb+M+4H9EC0+lKZLXgli7U49f1rTn9rrYL45p/6CFWRZBpBJxI/M3xmBGRL4XKRAXsv9K2A3yQ8tPRcSR7XhGIKYxppnGss2L+uaY8tTR8zWOcC4zGXcJwcmQY5k1yu6C2vzmX6hPk0mlb4lFpbva/v4/tm5nSE0IUAZv/oPQwn7G+RrguUcb8RCF77dx0/Zi+PTaqbLb1HOfioPnrWCQANaWMSihCjo5g6MKP2zJX7CV6xXuAJLvNhXqoBvDJ+TD/YctjUU5j6L8cniestRuCCwh1/v95gWXweyfk2bEwDH8Rz/h7eA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d2051f-832b-42fc-78ad-08de5cc88d1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:49:30.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgTLq713+jjeXQojFrmzdh3RkSZ6Hehrgsd6+IgzzBQbmrAvws/r8LwQDD5EbyFgfNhkGZjvsgcVgi+Y7Z+6mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260092
X-Proofpoint-ORIG-GUID: Ywm9EvecnvaN2MHyQGPG2_Q5NcEMaWCV
X-Proofpoint-GUID: Ywm9EvecnvaN2MHyQGPG2_Q5NcEMaWCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA5MiBTYWx0ZWRfXzSySVzvtVLtM
 plPySfBu0FqlFFJuTD2QT1dz4INCj9dix9503+707bSy65VxHx4gCmX47BAGnOTCMHESlMYm0On
 0lHhcpjIhzTBHzUOyiZezjkbgGzl3J0xZX5q9ks1SsNsoNhi3J8VSFArw3hVL3uCSxs6MZzySiL
 ev4i2quZnx3/chxJxyQJUzGs7CT7YCWsgKBLbCAy1t1q/yq6H+DO6/MM3B67vyH9lBBDdDmld8B
 MBP4s82i3pKTWKup0SMBESBOTv02TTjXNApvjoQv99XAsb/E9zQuswMpqWa82OzEKZUUN9uSxNM
 cB2t9ZF0WibssnLL4EKN3jBsptXn3qYAzviAIcHTXVk80htWeVCaawxDRilC32jKGEu9lVnhoJ2
 7awZ1HZb8h97WWvJ89wSkCy21CZTXJoZ1NxXcJmoSeiQSiyQqMJMqPz29hbjuLSsS3YeuTYv1NQ
 xtRHuh+t+2+QXKNqEBw==
X-Authority-Analysis: v=2.4 cv=cPLtc1eN c=1 sm=1 tr=0 ts=697746c5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=w9X9ZNF3lKEskhIts6QA:9 a=QEXdDO2ut3YA:10

On 26/01/2026 09:52, Matt Bobrowski wrote:
> On Fri, Jan 23, 2026 at 05:26:47PM +0000, Alan Maguire wrote:
>> Currently we collate function information by name and add functions
>> provided there are no inconsistencies across various representations.
>>
>> For true_signature support - where we wish to add the real signature
>> of a function even if it differs from source level - we need to do
>> a few things:
>>
>> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
>>    we can do this via the address associated with the function.
>>    In doing this, we can then be confident that the debug info
>>    for foo.isra.0 is the right info for the function at that
>>    address.
>>
>> 2. When adding saved functions we need to look for such cases
>>    and provided they do not violate other constraints around BTF
>>    representation - unexpected reg usage for function, uncertain
>>    parameter location or ambiguous address - we add them with
>>    their "."-suffixed name.  The latter can be used as a signal
>>    that the function is transformed from the original.
>>
>> Doing this adds 500 functions to BTF.  These are traceable with
>> their "."-suffix names and because we have excluded ambiguous
>> address cases we know exactly which function address they refer
>> to.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Some minor nits, but apart from that it looks OK to me.
> 
> Acked-by: Matt Bobrowski <mattbobrowski@google.com>
> 
>> ---
>>  btf_encoder.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>  dwarves.h     |  1 +
>>  pahole.c      |  1 +
>>  3 files changed, 71 insertions(+), 7 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 9a567e4..c1002c3 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
>>  	int16_t component_idx;
>>  };
>>  
>> +struct elf_function_sym {
>> +	const char *name;
>> +	uint64_t addr;
>> +};
>> +
>>  /* state used to do later encoding of saved functions */
>>  struct btf_encoder_func_state {
>>  	struct elf_function *elf;
>> +	struct elf_function_sym *sym;
>> +	uint64_t addr;
>   		 ^
> 		 This appears to have leaked into wrong commit?
> 		 This member should've been introduced within patch
> 		 5/5.
>

It's used here too though; specifically in btf_encoder__save_func()
below. We need to use addresses to map between a DWARF representation
and the associated ELF function to ensure we're using debug info
for the correct "."-suffixed function. We need to do this because
the late DWARF generated after optimizations are applied uses
the original name ("foo" rather than "foo.isra.0"). 
 		 
>>  	uint32_t type_id_off;
>>  	uint16_t nr_parms;
>>  	uint16_t nr_annots;
>> @@ -94,11 +101,6 @@ struct btf_encoder_func_state {
>>  	struct btf_encoder_func_annot *annots;
>>  };
>>  
>> -struct elf_function_sym {
>> -	const char *name;
>> -	uint64_t addr;
>> -};
>> -
>>  struct elf_function {
>>  	char		*name;
>>  	struct elf_function_sym *syms;
>> @@ -145,7 +147,8 @@ struct btf_encoder {
>>  			  skip_encoding_decl_tag,
>>  			  tag_kfuncs,
>>  			  gen_distilled_base,
>> -			  encode_attributes;
>> +			  encode_attributes,
>> +			  true_signature;
>>  	uint32_t	  array_index_id;
>>  	struct elf_secinfo *secinfo;
>>  	size_t             seccnt;
>> @@ -1270,14 +1273,36 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>  			goto out;
>>  		}
>>  	}
>> +	if (encoder->true_signature && fn->lexblock.ip.addr) {
>> +		int i;
>> +
>> +		for (i = 0; i < func->sym_cnt; i++) {
>> +			if (fn->lexblock.ip.addr != func->syms[i].addr)
>> +				continue;
>> +			/* Only need to record address for '.'-suffixed
>> +			 * functions, since we only currently need true
>> +			 * signatures for them.
>> +			 */
>> +			if (!strchr(func->syms[i].name, '.'))
>> +				continue;
>> +			state->sym = &func->syms[i];
>> +			break;
>> +		}
>> +	}
>>  	state->inconsistent_proto = ftype->inconsistent_proto;
>>  	state->unexpected_reg = ftype->unexpected_reg;
>>  	state->optimized_parms = ftype->optimized_parms;
>>  	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>>  	state->reordered_parm = ftype->reordered_parm;
>>  	ftype__for_each_parameter(ftype, param) {
>> -		const char *name = parameter__name(param) ?: "";
>> +		const char *name;
>>  
>> +		/* No location info/optimized + reordered means optimized out. */
>> +		if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
>> +			state->nr_parms--;
>> +			continue;
>> +		}
>> +		name = parameter__name(param) ?: "";
>>  		str_off = btf__add_str(btf, name);
>>  		if (str_off < 0) {
>>  			err = str_off;
>> @@ -1366,6 +1391,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>  
>>  	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
>>  	name = func->name;
>> +	if (encoder->true_signature && state->sym)
>> +		name = state->sym->name;
>> +
>>  	if (btf_fnproto_id >= 0)
>>  		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>>  						      name, false);
>> @@ -1508,6 +1536,39 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>  		while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
>>  			j++;
>>  
>> +		/* Add true signatures for case where we have an exact
>> +		 * symbol match by address from DWARF->ELF and have a
>> +		 * "." suffixed name.
>> +		 */
>> +		if (encoder->true_signature) {
>> +			bool true_added = false;
>> +			int k;
>> +
>> +			for (k = i; k < nr_saved_fns; k++) {
>> +				struct btf_encoder_func_state *true_state = &saved_fns[k];
>> +
>> +				if (state->elf != true_state->elf)
>> +					break;
>> +				if (!true_state->sym)
>> +					continue;
>> +				/* Unexpected reg, uncertain parm loc and
>> +				 * ambiguous address mean we cannot trust fentry.
>> +				 */
>> +				if (true_state->unexpected_reg ||
>> +				    true_state->uncertain_parm_loc ||
>> +				    true_state->ambiguous_addr)
>> +					continue;
>> +				err = btf_encoder__add_func(encoder, true_state);
>> +				if (err < 0)
>> +					goto out;
>> +				true_added = true;
>> +				break;
>> +			}
>> +			/* If true symbol was added, skip the below. */
>> +			if (true_added)
>> +				continue;
>> +		}
>> +
> 
> I think this hunk should be factored out into a
> helper. btf_encoder__add_saved_funcs() is starting to get hairy IMO.
> 

Yeah, I think that's reasonable. The combination of loops within loops,
breaks and continues is getting hard to follow. I'll respin with a
btf_encoder__add_true_signature() function replicating this logic.


>>  		/* do not exclude functions with optimized-out parameters; they
>>  		 * may still be _called_ with the right parameter values, they
>>  		 * just do not _use_ them.  Only exclude functions with
>> @@ -2584,6 +2645,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>>  		encoder->encode_attributes = conf_load->btf_attributes;
>> +		encoder->true_signature = conf_load->true_signature;
>>  		encoder->verbose	 = verbose;
>>  		encoder->has_index_type  = false;
>>  		encoder->need_index_type = false;
>> diff --git a/dwarves.h b/dwarves.h
>> index 78bedf5..d7c6474 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -101,6 +101,7 @@ struct conf_load {
>>  	bool			btf_decl_tag_kfuncs;
>>  	bool			btf_gen_distilled_base;
>>  	bool			btf_attributes;
>> +	bool			true_signature;
>>  	uint8_t			hashtable_bits;
>>  	uint8_t			max_hashtable_bits;
>>  	uint16_t		kabi_prefix_len;
>> diff --git a/pahole.c b/pahole.c
>> index ef01e58..02a0d19 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1234,6 +1234,7 @@ struct btf_feature {
>>  	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>>  	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
>>  				      attributes_check),
>> +	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
>>  };
>>  
>>  #define BTF_MAX_FEATURE_STR	1024
>> -- 
>> 2.43.5
>>

