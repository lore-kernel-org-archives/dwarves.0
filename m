Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C8267723
	for <dwarves@vger.kernel.org>; Tue,  8 Apr 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107277; cv=fail; b=HQqhg0B5PNwMWbh3i341U/0bkIDOEr1IpS8w0fepsENENFSO5Xu/+jr8bYslZkHtNjH0wG9DJHtDjguzSDXf7MjBOoaJw7USfZrnPqF6HTTvxuuUw9u9Gh/nFK0tIVe0+FrfKIJCrxL6xIhQHMj85qCkOcaD4xY8x38d5MlFzP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107277; c=relaxed/simple;
	bh=Y5H9QTNzzpWDVKKATI2epMPm8cAECCmS3Vp62Eu63Ys=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rkro9VudgfmsVXzd7Sd8a4pHsxvllaXK2uJ9ClTKw+AoC3/5RYhM0+pJupa48xEuu1m6jk9EAaO4/uSGIgADS6RcIlkJ9iBrqFAc99aAwiIBrTQEhl6WXML0zaaJIT05OF7o/XPnPws1KX749CiLGemuZSAG7L82d86MudX48mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AHyyHsQ6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CrCFjhXg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AHyyHsQ6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CrCFjhXg"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u4ZQ025619;
	Tue, 8 Apr 2025 10:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=t/tXqAbgMQ8hAMs5qpugPijxtEgniv2XB3n1dOJgFIw=; b=
	AHyyHsQ6oTL2DtuvYpbgfWxW6etB006zE+2ex1vb7Piz01T4ExOJKn/MHoYTrCLz
	1FbLneP5JcMXvJsrSQFghWJrBGVbZtwT/NX/gTHadVUjvGtOORLM/f2tGWZ0pm9s
	p7+SiXl3YVJjGoC8hW1eZjCtaCbH8XPtvMz9trO5a516sBaOI54H/AkMe4ncJCIV
	2nVHTij4bEFmIqL0xrbjMQeS/e6yOaIwQh2qaInrH1t8gO/bw/kpjwq2Trl4Jkgh
	LhZ+nzqiQzWJk/cgBOj/019+VSj9GxnnxpEMt/vZS1IpanVQFjdULXfVDQB9WLRz
	x41JYsnQCkLerbhRe4cIUg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tme0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:14:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538A5B1d020992;
	Tue, 8 Apr 2025 10:14:30 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010021.outbound.protection.outlook.com [40.93.12.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyfbpfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6l3n3qnVwg6St5QL4sQqtJq7TIm6cdOwlmIfRWNEuyfXo1jXenQuUmhtQZpWb+3tsRi019vR5T6N0POcUc42DG3g3biQIKP00xl2rFXBe1pZ/YI00yOKCPisQY4OluxXf4W6CDiVdssd1+5aRS5aHDk7gIqq3kyL1GawEBDCvumjyPYL1/Rhqgx35gwkBHIvg+jouku5keyk+sl/BGCD4c2mFXPW6CAHbZfwzWtOMVBuvhHWPwF9nKXugU7ExGg4mhLSoTYhpGYpELaGxYPu6gZ9psECeid0VensbpO+jL/zfgYZiUY9JN2HMS3LSG1emszEVGz+hVeFpvekoCO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/tXqAbgMQ8hAMs5qpugPijxtEgniv2XB3n1dOJgFIw=;
 b=wiU7FJhwJkIbo0NsubVVkFbLTDlQN39u4SihZO1tqIlIDINMtdSyGzavyiNLWLAj36npMdq0IkFfC0DKNNOUkNAqvd6fU89kDXNhpBxV7V4+YIXAEMJTHOjmDCwe7CDRHbWtzfA4vKciWzdMGoULbcgNpeosLtLundPk4V5N3CXN1cqgFw4d2rTylAVQwrXXMVXJXfg+btJo5CxIoATvJ1L0eqpmcy+wNTrzclbKO46B4yGSxpg/dWzs7b9Jm7PtxcDLcYEa4VRzDhtYLkS1Pdi38hrU6W6XlRwoXJVpR9Zw3baUXN2lATI4GwM11uvyA/WWNKtFs73GX6mDRyMGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/tXqAbgMQ8hAMs5qpugPijxtEgniv2XB3n1dOJgFIw=;
 b=CrCFjhXgtBTca9JB8C5hkCdqckdBv0rjc1rRGNotqqxXN5uMc2CSpkvdqass1Z5FcWqC3nk+tS9lPxY6XQiQ8cKINSpCE/dTW8yi7cJBN0azlO5L+2qNWml2hZWRkFwePfqzhYHES1JsI+14NI+WEeFqb5NjHy6Vf8pE/TMtX50=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB7915.namprd10.prod.outlook.com (2603:10b6:408:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 10:14:29 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 10:14:29 +0000
Message-ID: <c784d7c1-431e-4c43-95ac-ab6869c1d7da@oracle.com>
Date: Tue, 8 Apr 2025 11:14:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pahole: When trying to encode BTF avoid DWARF less
 files
From: Alan Maguire <alan.maguire@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
References: <Z-2fij_hUUFYF-YQ@x1>
 <a86ffc25-fdbc-4f6a-9579-aff59400d677@oracle.com>
Content-Language: en-GB
In-Reply-To: <a86ffc25-fdbc-4f6a-9579-aff59400d677@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0097.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d1f68e-27bd-422d-fc13-08dd768625f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjJWKzAvWlZqVzFDaS9rVWoyZXpyVUphVC9qNjViZGY1SnlQOUpKcHBLNTFq?=
 =?utf-8?B?ank1M3FzVzhJNW5jQUJscXNNaUx0TXBsY0laL0lNbjc5RzR4anlNUzYraUtM?=
 =?utf-8?B?ZW9mSDBDeTZSd0RzM1hCRFpSY0J4SDdRYWtNVUtTTXp3WWdzd0hsR0NPN2t0?=
 =?utf-8?B?dHNhNG11VFZaYzR1Ymk0akV3UXpWQUdVUDl3ZndzSm4wd1l3TEFCemluM0l5?=
 =?utf-8?B?em0wOGRQNVVPYXVUbUZ1QmVKUzhINUpvWUlheS9uR0FQbHc4eldCd2o3QjRs?=
 =?utf-8?B?L0RwQ2l3OW44QnMrcXFiNk9kNjF4b09scHJ5ZHZ1S1JpQmJBaUVIeXhJZUxw?=
 =?utf-8?B?QVM2elNpcldwc3VjQVhBZHBNN28yZU1lNkhpMVhVVUwwN2swQUlVTjMwY2Zx?=
 =?utf-8?B?SEE4SVJBRm03a2ptUi9XMmZqZnpUak9PdVpVZ3laZDVGUHNQNzNQandNVVJr?=
 =?utf-8?B?LzcvZWFSR0kraVZLanFzcnh6UTlpZmZYTDV1cWZqTlRVL0dDYkwvelYyVXgw?=
 =?utf-8?B?Q05wSVNXT0wrUHZrczBQM1RZRUh5V3BtYnJJU3RNaEgxUjA3K2R0YkJqRXRk?=
 =?utf-8?B?dDFock56TkIyY1pMK1lQeXJEZEQrTkdFdXo2eGMxckVpTU5odVBFQVNMT3lT?=
 =?utf-8?B?a04vUWJiT1N3dUxnYWhLeXlwaXVvU2lKN0p3T2RxTjlzeWU5ejd3RURBTmJT?=
 =?utf-8?B?N3k0RzV3dWpVeU5leCtHQUl6dnhkR1pUZGk3UVNDS3hpRzZvbGRIbG83dVZ4?=
 =?utf-8?B?UHdtbnpkWE1KZk5oanRONE0zYWtsRThIK0RYVEpQam44NTZXaVpyTG40ekxp?=
 =?utf-8?B?Z0ZrZ1l5QlBVaXBxU3NrL1FMak1EY2VTdzh5WWl1ekhNL0o0S3ZWRWxhWWl4?=
 =?utf-8?B?VFN4b0RoTjdlOVJOZzRiLzNCYXFxWnJnSlUvVHd3VzJaT1pmZG1LYUprVy92?=
 =?utf-8?B?MmRucWhjOGVPcm03ZXU1VFhWRUs3eTRjK0R5bUNURUtjYURZYlJHa0s2ekZy?=
 =?utf-8?B?TG03M0lPQUpzWENKSWpNdVh2emN4MkNib05JRVllcTNjVEhzUXNtM2dESFNI?=
 =?utf-8?B?MGpGS2E2L2szZnZHK2QrNE9OVTRhRmc2OUQyakErVGxwQzJqSEE3cG9hVHl4?=
 =?utf-8?B?bW5jdTdtSWF5NlVXTitqRjdCb2xBTm16M1RJYTFJazdjdWZDbXpMQWtta0RX?=
 =?utf-8?B?d2N1cVdiTVVHZ3dZTS9SRzJ3QW1GOVZGTVh2QlpxbmpiYUpEcndGaUxaaU9Q?=
 =?utf-8?B?Mk1OY2FscEZ6akwxRzRURVl2cHQvMUlEaUk3ZDY2UDlwNTBpTWxUdU42VFRn?=
 =?utf-8?B?cE9CeDZvUG92YWE5T3pobzNkMVZuSGdUVlRjeHB1djg1RVhrTkpCVmk4NnB4?=
 =?utf-8?B?cGwvTDh4bGhlOTFlbE5jV01JeDdZTi9qYnBQaC9leXpST1owYy84cGorNFN2?=
 =?utf-8?B?dStwOVRldWVmWXRZSEE3SVFHazBCZ1ZYeUFXei9GZEVlN1l4R3VCeFRSTWpT?=
 =?utf-8?B?MVBpZGg1OVFyTXFpWW9UQ3RDQ1NIYXIzUDkzQm0yMlkwZWYvT0hDbmVBQ3pk?=
 =?utf-8?B?TnFZaS9HVWdVUmRsUEthTXNUYU1ZdGtyMDc0SXhGc1Z6d21PUW9xR0pFdnNO?=
 =?utf-8?B?OGJLTHZ3RTJtVSs4K0NCUUtsaE9HTHo5b2VQNXNtLzN1cDIyZCtwSEJZMWxw?=
 =?utf-8?B?dU1iLzlzOWZsZGdYT1M5MFNVVkRjN09FMGFNUGlnZWVVOU1NTVptTFJUVy9n?=
 =?utf-8?B?ZTZvZUtMb0lpeXZqZFk4UzFSUEdZY0dSVGVQZ004MkExWklJRnh6M25Ycmsv?=
 =?utf-8?B?eWJzN29SWVZlYlc2d0JIVjk5OFJoalZwM0h2b2FheW9BaVVhMHRnUmFaSS90?=
 =?utf-8?B?dFpFaFA5SHVIaEFwTFY2TWtYNkVSZmVQMExPRkE0dCtKb2UyOGhwQXlEaVV5?=
 =?utf-8?Q?TOMEgtJmPsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3IrZUR4VnBHakc1bVQyaDdpM0JMTFhqeDQxdHk3NXF0Q09mN3ZxTE5PMmZT?=
 =?utf-8?B?NU1OWXQwQjZ3K3h0bS9KbHRXRlp2R2pxZm43NEJRaVBtWEZoc2N5dzhiK3g3?=
 =?utf-8?B?SlNlb1ZtMmhrczd5TkNTMURyVndpN2o0dGV6RnRCNVNsVTJONy85bE9sZ1Bk?=
 =?utf-8?B?aEZwaTBpYkdvc1VNbGg4L0hOSGhsUzdwcGFuZnhFbmdRK2g4RnJrVkhBNWtR?=
 =?utf-8?B?WUh6c20zQnhyOW5TMzZRTE05TjFYMldtSmd3bW9VSW9EaEdqVlphS2lWa3VT?=
 =?utf-8?B?MC9xTkU0MnF3UFJ3dlBpWkZwMlBlYldrbkVQQ08xbnBOT3pwbFEzV3l1d1dx?=
 =?utf-8?B?ZjNyYVFXNitCVy9oYTAyQ2NlYjFRMzM4Rms5Ynh5RWIyS2o4RG5qQ2xFeXZJ?=
 =?utf-8?B?TnV6a25EbWRNKzdONWlvL1M0RUt1K0drTUhGbmZGZzdnMldxb2sydCtta2dI?=
 =?utf-8?B?MGVRUmNQZ3g0RWR0dUdxb1FobE9ObitUTy9OZEFFeU52U1lEQzRaOTFSai9l?=
 =?utf-8?B?WHErYW92MUdhWExWK2dTZ09KS2hkZVNEMEpzenRKbW1KNWZOVkRWZkpUQWRY?=
 =?utf-8?B?MXduRHNBQVRZelBjcGhRMmFaSXU0OXpNdVJsbEVvSjVQNitqWkZhZmtUQjJ3?=
 =?utf-8?B?MGwzT055WStISlhiQjNoeGFvK2VsSnQ3dTNUNmN2TTFCTmxzQXN5ZG5NQS9G?=
 =?utf-8?B?REEyOGJnQ04xcjBHNG1zSWlzWEVDRng2WnhQb2xENTRHaVA3LzlYdW5LTHZV?=
 =?utf-8?B?Q1YwMXlXbitJTGRpT21pMm8vRlRzbHR0YlNvK3NuRlkyRXdqWjJmOEMvUjNv?=
 =?utf-8?B?WUxhQTVveENjWXNveWh6NUxiMkE5S2t3VWw3QXlwcHA0QTJlWmY1aXBaTnFR?=
 =?utf-8?B?a1pMcmhnbkdHbjRzRDJnUE9TYnJVQXI5NHRlS0tvbHFjRHlJNVVvRldyM0xG?=
 =?utf-8?B?c0tFMUtLR3VqSTA0dmV3U1FkNldUM3J5N0d3TmlvOUpqZFRPQnliY2J2QytV?=
 =?utf-8?B?UVZmUnIrOU9Odmh1dkhTZExPZWFvdTB4QzdrOHlFTjFKRm93T1JMYkthMTdC?=
 =?utf-8?B?aTNqUzhqYjFTSzVaSmcyQnl0OTZ1NXJlTEdPcGJGRGhxUy9Ob1BVc05uU1VN?=
 =?utf-8?B?Wlp0NkRZcEIxZmlyZU41andRTnBZVVJ5eHZHaE42TC96ZGpVcnk0MlJ1N0lS?=
 =?utf-8?B?QVZFemQ3alJVUUJXby9GcXdNUUx3OFNWZmZYaHFBRjkrakJMbWpGQlRRQzM4?=
 =?utf-8?B?Sk90d1J1b1I2d28xdXZCRGU1Skt3VFczU21uc0pmRCtTbFF6OGJkdE1GS3Rl?=
 =?utf-8?B?QVYySTdJamVQdHE2UU1idFB2Vk10M1FNRXN2OG9yZ3oxSjNrMVhLY3V0OTQw?=
 =?utf-8?B?dGJTYjJZNSt5cmcyUm1JQTFpYTZZamRnTGQySXFYZmN2ajAwV1ZEOUJNWnE4?=
 =?utf-8?B?ZkRZTUdwWFlQM0RRd0xNeHF2cFhweVQzSDQ3NHd4bFkveTk5L25DRUFDM0N2?=
 =?utf-8?B?R3cxektQRktlVDFpaFp2SFdwNE1HTDBrRXZJTE9IK3JTODNKNFFmWU5tQW0w?=
 =?utf-8?B?NmhXc2hrTUlweUQwaWpnY3h3SUR6Lzdya3JjMEdMeHJJTWF0dHRiQkVYWEh5?=
 =?utf-8?B?MUVENEp1UnZIWmpOL2xKb1dXTHZ6d21PTkpBTWE4RmdmTzlHc1FNZ0tHSmNF?=
 =?utf-8?B?QmFNSWdDalNSaEhzWGVjeGFGWDZlc0wybWUxTzJJZ0VYRW5jODBKbTcrdVJN?=
 =?utf-8?B?S2hnODV5QUVsd28wVUJ5VXdCRzdjenQwaU1VdEdxVlpmQUxMdGJxY2ZRUFpH?=
 =?utf-8?B?RFdYeVJpSlY1TzV0b2Zxa1BrdjMxQjF6WmJwQlpqOVRneXd2TDd5bXV6U04w?=
 =?utf-8?B?aUt1UzFJcDJuVWN6UU56ZVFhaEVDSlMrYXQ3RDExWDBWc2g1dTlkZU10Vy83?=
 =?utf-8?B?QXJ2MnJOTEVpdWkwUTZhOUpPN3BJQTZiZWd1OS9RRytObEpDSnFhNGpkYkpv?=
 =?utf-8?B?VFZRTjQ4YitYN0RxTW5tSGVNR3Z2a0RGYUxLL1ZLOEo4N1JDbmR3eHZSaVJD?=
 =?utf-8?B?WnkvWTllTzlSVnljUnFLZE56c09VNHFXOXNuN1hhdjBRNzJscDM5UTZoRXdQ?=
 =?utf-8?B?VksyOURpY0FHUGJpbUZwS095WFgxR3hDblkwLy9BekRkYnZ3RmIwYXN4VkZ6?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m+1PO7cmD5ydgB6AIMLzflHt1FiHECjKMDKOYoOL8ZJrbP9FIHgVCTt2Zcv9mzp+3mmH56q+tpo0j4Blw/FYwmOxEt/1sGzJIRvYbeb03lUSu8c/uo9324Fl5sW2SAo8GFiPCz+k2Jgng3uTL7bn2LvqQVaX/PXekQtO7r3c2NEvpvuo0a8F/BS2oIpTmZl6O6Px29WXDPlOLoW/TJdvEOn2IWnpdkGKuw32oYdEkTWXoiinNZlOhA25cWaxFOzXKHrUN+rHDr+5d520OO7JFMcCA6LgDeZQf+IMTqTb0zBWQKhJNlOZ9oLV4fimgEfdD4SIOnlLDCdZFKu7w4vD9mV1m8sMRfblxUxTnR8iWzpv5zFsM6+WsdvMXfMEECnElM/2YvwhpPm/RwOHDYjNW6ITt/h9VgZ0fxshk9Dngj4jNCU8A5sMA5jBP31frQzlYmAsgHpXgVdGph5KPa0iEtIV4MNz5MzbaylVSKG92se6Y0EkwEWSNJtP6n9UXqnCOqXrV2c5DT6+xHQuELb1W2GRvuBFhQSerjHX156F3GknxsRylCydRBGxEA7TiD/s//5NWlqHxqd5G2GPLv/ypndtlat2gWjoEbkTJplyAwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d1f68e-27bd-422d-fc13-08dd768625f1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:14:29.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZm4Bk2ZmnJQd5AhPgugU2RBIGn/vRrz83vi5Y+1k7IN1HnqEFpz2Rw2R6zDt32cxh125nUDgC1vm8rpyuzeMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080073
X-Proofpoint-ORIG-GUID: sdJzL3eoZg7FfQV0DZktsqJI79QtEMjD
X-Proofpoint-GUID: sdJzL3eoZg7FfQV0DZktsqJI79QtEMjD

On 03/04/2025 19:40, Alan Maguire wrote:
> On 02/04/2025 21:35, Arnaldo Carvalho de Melo wrote:
>> Make sure only DWARF is expected when encoding BTF. In time BTF will
>> also be accepted, to fixup or augment info produced by some producer, be
>> it gcc, clang, pahole or some other tool, for now, avoid trying to use
>> BTF when DWARF isn't available.
>>
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> ---
>>  pahole.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/pahole.c b/pahole.c
>> index af3e1cfe224dd14a..f247ff5e88feeb95 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -3493,6 +3493,14 @@ int main(int argc, char *argv[])
>>  		goto out;
>>  	}
>>  
>> +	// Right now encoding BTF has to be from DWARF, so enforce that, otherwise
>> +	// the loading process can fall back to other formats, BTF being the case
>> +	// and as this is at this point unintended, avoid that.
>> +	// Next we need to just skip object files that don't have the format we
>> +	// expect as the source for BTF encoding, i.e. no DWARF, no BTF, no problema.
>> +	if (btf_encode && conf_load.format_path == NULL)
>> +		conf_load.format_path = "dwarf";
>> +
>>  	if (show_running_kernel_vmlinux) {
>>  		const char *vmlinux = vmlinux_path__find_running_kernel();
>>  
> 
> LGTM
> 
> Acked-by: Alan Maguire <alan.maguire@oracle.com>
> 

applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

thanks!

Alan
