Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA4418030
	for <dwarves@vger.kernel.org>; Mon,  9 Sep 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920367; cv=fail; b=YBPK1wz/KAjQZsb2rK0tObn9Byk3mo1d/DZDSSWgN6BL7q4EpN5dmTkiIhacIb7tHgTKUBWtAhuKqwBqJ+Egye2fV4VzKxlmA3bVWjbTgb6flltKaSRBXPTToQvPh7mX11Uwkpg+Dj+xIRM79yPFsSyeB0s7SHdDqX9A5UId6aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920367; c=relaxed/simple;
	bh=htJUqZmpBdJFxu+ZBwBT7k5D7oHKstMnVSMKrCIbcaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I7xbr7AK/DhEAe6nTJAAHw1qsubjRynyXCIw2EmqT42y7shchzCAly25lGBkjqWm76oiKLb9BWEu+TNeWTjhet77ij5/eeAFxCCmaEkqoQRC3NTsnRAhp72RO/krmeNEqsV4YYJ6hgBSL8Ivgubk3q0tSMKNz8GYInwzNjvq8Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LvU3Xqzn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CSEYDSFQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LvU3Xqzn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CSEYDSFQ"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489LlSuO028782;
	Mon, 9 Sep 2024 22:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=UumALHB2ohPboQmEqXwO6nc9iqfegrqPOjQunCQagAg=; b=
	LvU3XqznR+wwD++UrvJA33JDWp4rOcBRyoGoVzyHW9GSEQF2qj2VKWe3SE5vejuB
	0YEjJ7vFNliHrZktDjAijsyAFnTTMvAg58idV2GBiYNsK9qK5IQf5hbZw4pN6Tm9
	8RwRcGikRARUeYGsUSkp/+13PLRdU21Uf/MAyIAeE4fWs1AIuyY4QX490UxBHALt
	3ynDtXJcKgnExJEfFWoaJK3hNkqPVMXeU1HDkvjb7a8YGtnBbBX2ow+TRkjBKGKw
	oHAmg3cF9Z4cmyQjuQ/uIEzjdIPYyq0EKVRclgXHCaBfCb9C+yCOuEZZ/D1/nIod
	a053cpSE2MTWGcbA0ncKzA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9m58q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 22:19:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 489LKAki006205;
	Mon, 9 Sep 2024 22:19:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd97sxep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 22:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dboR+xB1tvZ/9+yMCdiARvvEyPvD+XQgJtZiLcwl3S2Oixv8RPqTsaVQYYsYwtSZYGesxTFb/xJQqkVEEPIQNsw5YsBYiLpSQZ07q38RD6GOvLCbkFMSZJRCzL1hHPv55G4SV+NUjvfrR9i9ouWllxVzxBbRWPBLvu4tSXF3XZrGlO3A6Ipn8K7SqktP1i7hn/5YVkRg+4+ypJwAWYXJMlqow+JtSjqS9bV32DCbaq5EBPL73nTcK5F1TAcznDCecTzdtCAZq87wnDOIIuX1+ZsmcBGB9RyL0v7IzmWvvQuC9E4qOqLzopp1D+a0HVogXsF2n5/BbylBQ8EvDT8c9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UumALHB2ohPboQmEqXwO6nc9iqfegrqPOjQunCQagAg=;
 b=KwU5od3BFL+8g6w0BJmxe7KlcsU1ytMws3QXfzCsncwc2mgCQlCKz5VUCWeAfxawbcTt1lPRhXjjXpnnlclxq/bZW956Hee6SBmuneNdV46oGj5JmqIou7cQFG8JeNoPV4yaSza3dVQLyPWWjfcSadEtLmZrqrVLsMVvbY+tzZCvL9OpECpJtUYJ5XfZ9E8z+hS2JgX/qq6xlnx5oyRXHdTpWrbA9WTc22cODp/x1d+c2/6QUcVX4r8zUMlrHiD3PBLFZiLOZyxNGlmy1TrHcjkVv6Oze3R26JajOIpYCi2dxnRyapeL5mn/FDeubjDhle5VelK8bWCI58+oD7FuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UumALHB2ohPboQmEqXwO6nc9iqfegrqPOjQunCQagAg=;
 b=CSEYDSFQwNfcIfHgHRPpYCu5RKhyTAyicNZlelt/L9Z9KK976NScaq6RkGK2+VnWZqb2GhfQot5QhY3L7HZLqZgSY8//O64hBPJMwVOjeuM7cpZwChXWsjEEKUup2GqtwnwRFOzrjdbFHC8ko6YMOeF7BnPYpdI6M6aq8kMmAdw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB4957.namprd10.prod.outlook.com (2603:10b6:5:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Mon, 9 Sep
 2024 22:19:13 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:19:10 +0000
Message-ID: <ff86ecdc-0cd4-4b9a-8a7b-5fd2b082bde9@oracle.com>
Date: Mon, 9 Sep 2024 23:19:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC dwarves] btf_encoder: record BTF-centric function state
 instead of DWARF-centric
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, dwarves@vger.kernel.org, eddyz87@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org
References: <20240909155031.1596249-1-alan.maguire@oracle.com>
 <Zt9UKWn2u6ovBI4o@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zt9UKWn2u6ovBI4o@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0472.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 623efa08-7541-43ee-9ca0-08dcd11d6d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzEzMHlKMGc5NTdCb0NCQ1oyTElSZU1oM2JxeXRTemNHOTZybDk1dkN1R21p?=
 =?utf-8?B?Wkh4UjBhUjdiS0tPT3M4TTVPWE03RDg2SlBCQjdzemt1ajlkd0NMYnZWTlJW?=
 =?utf-8?B?emY5SVAySmRYRHZmdFo5allmZ081UXlTZFppNDNqUHN2S2J2a2pTTDZmb2Za?=
 =?utf-8?B?bjNUMVBmSUtFcHZRaEhCcGZiMWM1WWdncGx6elc1dVVrbk5XZmlvREhyMGov?=
 =?utf-8?B?KzV1U2luVHdPUEdhUHdEaWpoblBjRkE5VjVXcFRyOEo2UzRuaWVTbktPTlM5?=
 =?utf-8?B?RXhxNkJXczEwZjJxbjl4eFJ0MzNJZytBeDVPOW41dk8vdzlOUmtWU0tDeGNR?=
 =?utf-8?B?SXZzejBiY2lwSE5Wek9LaGtLSFRUMElSR2xlQmpZMENGWlZNbXlTbFJrZEF2?=
 =?utf-8?B?SXY3eFJKMDFuUVJka21udytydW92ckFmUWlKVDRTM3FWZGtlOEFyQTVwTWgz?=
 =?utf-8?B?R2h0T1Q4YjV2cXJnT2M2NjYzdk50MXJadkFDRjVPTmdrbnZRYUhzdldXTXl6?=
 =?utf-8?B?eE56YmZobTY5dmU4bDZ4QlhiOTFjRE5CNjN1ZzRjVktrN2gvUS8zSUhvZ3cx?=
 =?utf-8?B?dUZzVXRFT0w2SXdtRXBzMm5qMjZRR3YrV3ZwWWlxdFdrUGhPVmJlSzA3bkRW?=
 =?utf-8?B?UTR0ZkVSYTh0WlpDRjNpMlhjQ3RhRk9GSU13TjFCMEZ4cm1JVmJCam12VmFh?=
 =?utf-8?B?TFRGQ0NybDlkSFRhNmZNbnZUcnpGQ0sxc1o4eU9jUGg3cFVsS21aVlJOZVRW?=
 =?utf-8?B?cmVtSC82SW0wRmdDTTEzK1BzSmRQLzFsZjlYRGNuQit1SXNMRUxxUmlqeWl3?=
 =?utf-8?B?QS9KR0VZZEU3N1ZxNVBSSDhjVU5TaW9wTDVpR3hIdjNFc0lLLytKZGZ0c2Uw?=
 =?utf-8?B?TTQ4d0YvVm9QWmJFeklTN0ZvN1JCZGZyUTN2aVE5Ykd4MWwwNk0ybUtWZmYr?=
 =?utf-8?B?QlRLQW1xQlZ3T0V4UEVGUGVyUnMveVN6R3JuU2xWeUticldUNFpVNG84Zmxm?=
 =?utf-8?B?NkVoZTVPdzhSTTNyQ0VpdHlQOTc5UGg3ZXRmU2kvVG5Pekk2V1NVOGtaVWVh?=
 =?utf-8?B?LzBMNHJnREZsMjZLZmVYYUo5NWhicjVGM3B3NStORkEyNzZReE1JbERDUFZN?=
 =?utf-8?B?SlFndXc3RzJoSmhSenMxd3lYZW5pNG5MY21nVVA0T2ZoelQ4QTE2azlLeU4r?=
 =?utf-8?B?b2hMc0h0VnkvZVc5Zy8zbW9HYitkbU5iUlBXQUVuWWV6RWp4L09qNHBYSnRX?=
 =?utf-8?B?MFBGaThvaWVGWDVjRktTWnJ0TTBMcnZoSnJlbXZld3huaGxmQVIzNGkxZ2g2?=
 =?utf-8?B?OVNtdzMzblp5RVE3VzE3Q0ZhMmsxTDh5ekxLUFNnUHNMam0vUlI2dDFCU2R5?=
 =?utf-8?B?ZXA1emladjNBQjRweW5Zajl3WjgzN00wZ3JOMloyVkVtbm1tRkFVV09EMmNr?=
 =?utf-8?B?MitRRWNGaHZWY2lRQ01sZHVnYTdSWnhQVUZ2akkxSTlWeWFTekF0Wk5DNklQ?=
 =?utf-8?B?SFV2ckI4ZHQ4UHdjU3poaGNBS0ZQcmh1UWwrZVR2L0ZoNmFMdlBiVnNvU0o1?=
 =?utf-8?B?eWY2ME1ZT3ZCYmErU2lyL2R2OTZTOTVSOS9kY3lpaUZLWXFTRjdhb1VLOWVP?=
 =?utf-8?B?U2EzT25BSHp1T3hRQnQ0WjBnbEMrUnhmVEFOUWorRjMveFdFMS9xMTBXc2ti?=
 =?utf-8?B?YkxuQWpzVXp6VXo0ZndlekxFQSszLzA3UDVDQk1JR0xSa3Y1dE5OSHErRFhz?=
 =?utf-8?B?amx0bGw0ZmdwRDg2ZEJHWWFyQk1HV05QaWg4Wnp3QW1XWUttemNaZG5WYmhJ?=
 =?utf-8?B?SkpoNXg5QUVBUFkrRm9uZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3NUZWJEemJId1dRd1RLUTBKV3FBUkRFdDhUV2VrbFEvcWpiVWRIWXc2ZmxF?=
 =?utf-8?B?WmZpTGkzdWlhWGR4cmloei8vL2ZyMkp6UDI1RENBNVpGYjlRejBqOVFrTW81?=
 =?utf-8?B?N2x2Um81WEZ4bGwzSjVNSEUzWTk5UmpvUSt6OEhuamxuNGovRVRrdkhySExC?=
 =?utf-8?B?T0cwV2Jra2xnVlMyOURHNm1RZm9oMWJsc1dkZEdxdTZRdExEbHJPUVZtRnov?=
 =?utf-8?B?Ym41ZWFyVFJUN0lKWjZzYWIrRW1SRVg5TXVjTEk2aDhua20weThFN1o3TnJH?=
 =?utf-8?B?ZlRYdFA1K1lROWp0REk3eDBmdjZlYXAraVdMSXh2LzRzWGU3eDlvQmVrZEZW?=
 =?utf-8?B?dHhrd05LNU9OTFd0QjBCcW5yV0NDQXZkNnliSGlrcDRNQzYraDFONHIvc0t5?=
 =?utf-8?B?emdsaWRlNHdvWFE1SEx4VnU2SFhVSis4cm1ocHVnODExcUZjNVpnbjNBaFBE?=
 =?utf-8?B?bEFRc01WS1N3cUpOcUtPSndKRm4rZTJwL3cxZnM4Vkk1T0hHY0dycU9qMmpV?=
 =?utf-8?B?VkJGR0xISW9Bd0JxZER6OVhEQXg0V2IvTGQ2YlNhdUNzQjArVG04U3FKK21k?=
 =?utf-8?B?bVlVM1V5dHI0eFZ3TVNOc2drREx0YjVyVTUwVlYreDdPeTVFU3cycGQ5QWY4?=
 =?utf-8?B?dGxRMWVXalpsUzBHdkZZdEZHd25OeW5XVERaYXB6WUxFdWVIb0xnRjZEN2cw?=
 =?utf-8?B?NUFJak55cVlTK0tJNjg0K1lONHBza2J6YmRmbldYcHVsNFhZSjZRVVJ2ZENF?=
 =?utf-8?B?MlptekpkUENBeC9CZGQxQnhLOGR6c2trVndMdnRLMEJiRWVpTjQxdHQyZzha?=
 =?utf-8?B?TWZRQ1FlM2lyL2NHdlB3Z0F5aFpTOStDbWE4SlluUHlsTkVJUGxTc0lEcVl5?=
 =?utf-8?B?V1FWV0Zhcmh6aHBIR3pHQi93M2ZDeVpXYUhHRi9FV1E2ZDhnK0NPZVNISEsv?=
 =?utf-8?B?emdDcDNacGhtVE44T1BibDdTdWF1VDlLUnR1ODFNWXdMczFXVGJDN1hhV0pK?=
 =?utf-8?B?QWRnc1ZKdkpkZjRmNWVOZ3NrK21lbUlLNW92OEhNbG85eExBV3JiY0ZSNFF3?=
 =?utf-8?B?ZXRkRWp4NVJDMno1RGxlYm95VlRWazJzdE1NMW40b2Nvdldtakh2Rk1PbTZz?=
 =?utf-8?B?bWhYZldhV05tVkVILzBVTS9UU0VWRFByNG9WOUV1N2NoYjgrN3lVeVJTdGFp?=
 =?utf-8?B?Lys5aXhNR2w0YlNXZ2Q5Tks2TTYrK3R6ZVQ0d0Y3Nk1MVngxb05TYW13dTNV?=
 =?utf-8?B?L1UwUVA1emVBYkxXZm9WUnNLUytTdExDZ08rbjRxZ0lzQ0RxQ2F6WmIvbVZk?=
 =?utf-8?B?WW80enVJYWtPTjFLanp0a0dPNUtDc28wYjhqWjZCR3ZoTkVBVnpWeDZrZ3A5?=
 =?utf-8?B?QzlCM05RcWpwVkVIdWs2WHBkS29zOHRRckZxeGZhbFpHb0d5UFZEbHlCUC9i?=
 =?utf-8?B?Nmx6bmdYdHFObUE3ekcvdVJsK1U3K3l3SGVpZWN5cE8zSS9kSmgrUkxqbkFq?=
 =?utf-8?B?eHlyb3ppeGxPUjRUUkFwUjJHWmgrRzNrTlY2QUJkWnROeFY4OUU2VnVxT3Jh?=
 =?utf-8?B?MlZkWHJneXd5dC9OZWNLSTE4bXJCREdrR25BaG8yNlFGeXNvcktQMGtraWVq?=
 =?utf-8?B?R1lTVXIxWGp0dzBQZUM3RUNCVE4yTlN2djNwOUtRTEl6Y0VNZThzSkdkZU8r?=
 =?utf-8?B?c1VnSlluY1Y1Ujc5VGg0SDJjSDI4R29vTVdnTjZ5NnRyUUc5aVNCTGZSZEJn?=
 =?utf-8?B?SUZtZFdrKzRXaG1hMTJ3SENaTS9GbG1YOEUzcDJabnQxa2hRdzYxNDZ6TXBm?=
 =?utf-8?B?YnpQN1lwUmJ1UWljb2xXVkRpbk1ueTNzYUlVc04xekNiR2RpUE1vZXJtV0FY?=
 =?utf-8?B?eUZ0OUx0ZlFNelk1Rm1rY2gwZ0FjWUJ1c2lLY2RrUHhWSk0vbHBBKzlSbk1v?=
 =?utf-8?B?dTJYOEJ0bmV4NlpKOXUyM0tKZ1Z0SXVGWFhmQnB3WWpVT2syaUlWU2RjVHZ2?=
 =?utf-8?B?c0F1NkFHcURtdkdMNWRGUXJOOGJ4UGo0Y25aUlJzMGtBZ0ZrcTV2b3FKUkpu?=
 =?utf-8?B?RTR1VWE1WHFtRjJHY3JMWkNyakhKNUpXTFh1bUhySzU4WW5seVRCWFFnb0Zo?=
 =?utf-8?B?NmVleTliUEhUdG9USTNwQzVwNDJrMktWdjlRS1BRZ280aWJ4NHlHVXNiYUEr?=
 =?utf-8?Q?NUulNSzDjpeWXqoshSnNTI8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VRmhC678R0XvxOnMTAgvo+xjJWEL4C1fEVMWrE1SnQ1U7f0qztLKnwXNF11LDUnIJo2OOSS77IiN4wkSOpK/ksKJqD1RMv7o15vrW/AZW1I5O1IyDwP/XAv5tB9KEfbWBFTHwNaJ7siTwv7QkpnRAjEOMHrTeqHrbTWK1UAvopxLuiflhVgFaryVRcNKZlIsjXORLRrJgtymWoVXwa38Bfs6yA0SI2qbtqsUV7FrFz65P2pam7WfSn4f/0eIcevvpel7IP5u19OAelBvZFle/MPu1cHsAbSKcr0wwH8QcccmAO97w5S1bI+ZYWoV/HHirUHQ7v+iXl7osEY71A6otLZR4hKXfI/e3NV5JHHoilEgRWN7s1VCx06zOZ+QeKVxbjcu1063yAsbq340QT9C2kVMuHEXkMVutYdtncBHqOZdDSVZDJwp89tsU7tnP+Og0U729Jihhx2mfeClV3r4E6+n8p8YnzPZvIEszn6YexB6Zjb3ycicqs2mnpPCreMhYS0OIddlzwpMdO77+C+fO0s0Ti0NLdbfMaD+4h57airNQZHB5AfC4MD/FK0Pw5oGa21szYOXd73ZqAwqhZfl4KmF9eo9+uxxKxBXzVxp+Vo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623efa08-7541-43ee-9ca0-08dcd11d6d9f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:19:10.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBliXlx2/Q0m9Al7we6Pj/6lcLuT6tJjNrgPdSYUC/ylX9j4rP3BH8OvQtx/KI7vCpUhBGEdw5WfTNM+5+waqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_10,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090175
X-Proofpoint-ORIG-GUID: 1l6HRLkSje1xD7p74cKdzaKjHMvRuMR9
X-Proofpoint-GUID: 1l6HRLkSje1xD7p74cKdzaKjHMvRuMR9

On 09/09/2024 21:01, Jiri Olsa wrote:
> On Mon, Sep 09, 2024 at 04:50:31PM +0100, Alan Maguire wrote:
>> When recording function information for later comparison (as we
>> do when skipping inconsistent function descriptions), we utilize
>> DWARF-based representations because we do not want to jump the
>> gun and add BTF representations for functions that have inconsistent
>> representations across CUs (and across encoders in parallel mode).
>>
>> So to handle this, we save info about functions, and we can then add
>> them later once we have ensured their various representations are
>> in fact consistent.  However to ensure that the function info
>> is still valid, we need to specify LSK__KEEPIT for CUs, which
>> bloats memory usage (in some cases to ~4Gb).  This is not a good
>> approach, mea culpa.
>>
>> Instead, store a BTF-centric representation where we
>>
>> - store the number of parameters
>> - store the BTF ids of return type and parameters
>> - store the name of the parameters where present
>> - store any LLVM annotation values, component idxs if present
>>
>> So in summary, store everything we need to add the BTF_KIND_FUNC
>> and BTF_KIND_FUNC_PROTO and any associated annotations.  This will
>> allow us to free CUs as we go but make it possible to add functions
>> later.
>>
>> For name storage we can take advantage of the fact that
>> BTF will avoid re-adding a name string so we btf__add_str()
>> to add the parameter name and store the string offset instead;
>> this prevents duplicate name storage while ensuring the parameter
>> name is in BTF.
>>
>> When we cross-compare functions for consistency, do a shallow
>> analysis akin to what was done with DWARF prototype comparisons;
>> compare base types by name, reference types by target type,
>> match loosely between fwds, structs and unions etc.
>>
>> When this is done, memory consumption peaks at 1Gb rather than
>> ~4Gb for vmlinux generation.  Time taken appears to be approximately
>> the same for -j1, but slightly faster for multiple threads;
>> for example:
> 
> nice! did not realize LSK__KEEPIT was that bad..
>

yeah, it was when it appeared we ran out of address space on 32-bit (!)
that I started digging; I'm not sure why I didn't catch this earlier
when I made this change. Moving to using a shared ELF function table
will likely ease the pain further too I suspect. Thanks for testing!
More replies below...

>>
>> Baseline
>>
>> $ time pahole -J vmlinux -j1 --btf_features=default
>>
>> real	0m17.268s
>> user	0m15.808s
>> sys	0m1.415s
>>
>> $ time pahole -J vmlinux -j8 --btf_features=default
>>
>> real	0m10.768s
>> user	0m30.793s
>> sys	0m4.199s
>>
>> With these changes:
>>
>> $ time pahole -J vmlinux -j1 --btf_features=default
>>
>> real	0m16.564s
>> user	0m16.029s
>> sys	0m0.492s
>>
>> $ time pahole -J vmlinux -j8 --btf_features=default
>>
>> real	0m8.332s
>> user	0m30.627s
>> sys	0m0.714s
>>
>> In terms of functions encoded, 360 fewer functions make it into
> 
> on my setup I'm getting 386 fewer fcuntions
> 
>> BTF due to the different approach in consistency checking, but after
>> examining these cases, they do appear to be legitimately inconsistent
>> functions where the optimized versions have parameter mismatches
>> with the non-optimized expectations.
> 
> I checked on one case and it seems like obvious inconsistency:
>
>   static void io_serial_out(unsigned long addr, int offset, int value)
>   static void io_serial_out(struct uart_port *p, int offset, int value)
> 
> not sure how we could missed that before
> 

I _think_ I know why; there was a bug in prototype comparison where we
were returning success early if prototype return values matched; in
funcs__match() we saw:

	if (f1->proto.tag.type == f2->proto.tag.type)
                return true;

This was meant to be a fastpath for matching tags, but this is just the
return value type (which matches in the above case you found). The BTF
matching doesn't have this issue, so that likely explains why we're
being a bit fussier and matching fewer functions.

>>
>> Mileage may vary of course, and any testing folks could do would
>> be greatly appreciated!
> 
> would be nice to have some test for before/after vmlinux images,
> that would compare generated BTF functions
> 

Yeah, and also ideally keep an eye on peak memory utilization during BTF
generation. Arnaldo has added a few tests, I'll see if I can come up
with something in this area too.


> thanks,
> jirka
> 
> 
> SNIP
> 
>>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>>  {
>> -	fn->priv = encoder->cu;
>> -	if (func->function) {
>> -		struct function *existing = func->function;
>> +	struct btf_encoder_func_state *state = zalloc(sizeof(*state));
>> +	struct ftype *ftype = &fn->proto;
>> +	struct btf *btf = encoder->btf;
>> +	struct llvm_annotation *annot;
>> +	struct parameter *param;
>> +	uint8_t param_idx = 0;
>> +
>> +	if (!state)
>> +		return -ENOMEM;
>> +	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>> +	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
>> +	if (state->nr_parms > 0) {
>> +		state->parms = zalloc(state->nr_parms * sizeof(*state->parms));
>> +		if (!state->parms)
>> +			return -ENOMEM;
>> +	}
>> +	state->inconsistent_proto = ftype->inconsistent_proto;
>> +	state->unexpected_reg = ftype->unexpected_reg;
>> +	state->optimized_parms = ftype->optimized_parms;
>> +	ftype__for_each_parameter(ftype, param) {
>> +		const char *name = parameter__name(param) ?: "";
>> +
>> +		state->parms[param_idx].name_off = btf__add_str(btf, name);
>> +		if (state->parms[param_idx].name_off < 0)
>> +			return state->parms[param_idx].name_off;
>> +		state->parms[param_idx].type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
> 
> so IIUC because functions are added as last we're sure all the used types
> for arguments are stored in encoder's BTF already.. for funcs__match later ?
>

Exactly. We add functions last, so their parameters and return values
are already assigned BTF types.  The only thing that _may_ be missing
(apart from the FUNC and FUNC_PROTO themselves) is the names of the
parameters; we can efficiently add them while saving function info
because libbpf is clever enough to dedup strings when added.  This is
the thing I'd missed before; as long as we can compare the return value
+ parameter types (which we can), we can do our function equivalence
comparisons in BTF. In some cases (same encoder) we will be comparing
within the same BTF, while after thread completion, we need to compare
across encoders to catch inconsistencies.

>> +		param_idx++;
>> +	}
>> +	if (ftype->unspec_parms)
>> +		state->parms[param_idx].type_id = 0;
>> +
>> +	list_for_each_entry(annot, &fn->annots, node)
>> +		state->nr_annots++;
>> +	if (state->nr_annots) {
>> +		uint8_t idx = 0;
>> +
>> +		state->annots = zalloc(sizeof(*state->annots));
> 
> zalloc needs sizeof(..) * state->nr_annots ?
> 

oops, thanks for catching that!

>> +		if (!state->annots)
>> +			return -ENOMEM;
>> +		list_for_each_entry(annot, &fn->annots, node) {
>> +			state->annots[idx].value = btf__add_str(encoder->btf, annot->value);
>> +			if (state->annots[idx].value < 0)
>> +				return state->annots[idx].value;
>> +			state->annots[idx].component_idx = annot->component_idx;
>> +			idx++;
>> +		}
>> +	}
>> +
>> +	if (func->state) {
>> +		struct btf_encoder_func_state *existing = func->state;
>>  
>>  		/* If saving and we find an existing entry, we want to merge
>>  		 * observations across both functions, checking that the
>> @@ -899,98 +1097,136 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>  		 * to add the local function later (encoder + type_id_off)
>>  		 * such that we can add the function later.
>>  		 */
>> -		existing->proto.optimized_parms |= fn->proto.optimized_parms;
>> -		existing->proto.unexpected_reg |= fn->proto.unexpected_reg;
>> -		if (!existing->proto.unexpected_reg && !existing->proto.inconsistent_proto &&
>> -		     !funcs__match(encoder, func, fn))
>> -			existing->proto.inconsistent_proto = 1;
>> +		existing->optimized_parms |= state->optimized_parms;
>> +		existing->unexpected_reg |= state->unexpected_reg;
>> +		if (!existing->unexpected_reg && !state->inconsistent_proto &&
>> +		     !funcs__match(encoder, func, encoder->btf, state,
>> +				   encoder->btf, existing))
>> +			existing->inconsistent_proto = 1;
>> +		zfree(&state->annots);
>> +		zfree(&state->parms);
>> +		free(state);
> 
> some error returns above are missing whole state cleanup
>

yep, will rework to ensure we free in error case.


>>  	} else {
>> -		func->state.type_id_off = encoder->type_id_off;
>> -		func->function = fn;
>> -		encoder->cu->functions_saved++;
>> +		func->state = state;
>>  	}
>>  	return 0;
>>  }
>>  
> 
> SNIP

thanks again for looking at this and trying it out!

Alan
