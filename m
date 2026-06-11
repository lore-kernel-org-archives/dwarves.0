Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A036404B;
	Thu, 11 Jun 2026 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169374; cv=fail; b=rQek7tnsRPTXES0xNpHv4Y/cEwei/NHV2kBIidE3i7bMfSSPLQXICdHnrfe71CsgBuggXR4L6d5kZ7IBoT7+ZFYS62caWCiuN968LnJXQjtsiDqdpR6HlwCyylSvtD15SadX0K67sUGR+wwFImCkxfhWUp1jz9oQ04PZTPFlqME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169374; c=relaxed/simple;
	bh=cbG4Je0EMVVsmGwMre5b8F39056VEfh9aTt1B98qMtM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mNPYdK4rr4Rq6CCA1HJkMUv+0c7F+MbVKqS6srDknjgVeRzeUZVrghyb9i0++L0Fo41V1jc3yjgIXxFLG4bR1QOibGL3TiMZRg/h1cm3t5OKAETaBS4s7JlO9WjtbO9BSSSPO2VHqx0u8CW5HYD0ls15FgmJ/4e/ApqWx2QigYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pRB/FZYT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jjttQqQn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pRB/FZYT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jjttQqQn"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B8w84p3839579;
	Thu, 11 Jun 2026 09:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aC2cd74ZxGLnIfCq4IgzuEDNVYIao/Kfh0FCCWKEGkw=; b=
	pRB/FZYT8EJATyykA1LimjFPnVW1LWXwkUf/zD2KXl6rtwfi2ZRLkn2R8qV/tHaL
	zp01bcCKdESjmP6nNXF4XP/7WNT+VWrmCSFZZAOHEgn/y/BAuZ7T5CUJ8wufEwtk
	8dShWZZtSoYlCyFw7EsgEXATqzteqXxm9d7i7nwwPSPmeQlTvhcmEoFKr3CTaYzz
	07e7NCr8qRBnP2z6kzDNHuIJBrED6Mq+0bZZpWJdpbhMivWYf6ElyEYYFKRww5F1
	k/3gJuDsyCZAkCIwDsRvOTh091Hs+zoqNp4dOBVHAPmQR+hE4dOZ35jOHgqy/MPi
	kYqYRQxToNrL1VwByri+OA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eqe6urwax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 09:15:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65B9DKcZ029973;
	Thu, 11 Jun 2026 09:15:56 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eqjtveynw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 09:15:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6Hd4UiSCIrhkGiB2YqbZqhYGjyLgJdfAna9xsh6N2qx+eq2EPiZJqUyLSqQnubWBRMVHFeJk3OswjS8mT/BAgtXf67lIa2g6cKlADBl9iNCj8srKX9Uys8NA7JxmJyKIcXCa6NU61OGd+Zp98iWEzklCG+9jR6RXYnrba2TyUqeWm7a0QSNgJ+pC9GVoCfq1pkpmOs3MBMqXRFfAm1goDQYqgf1J/899yWQIQW1HwxnaMVsUTGfnBqWiNSoe5sgQIB0X8gi5zh41KmTVxlcsnMfSpLkfjz1Y3+MObM18JG5cNPoDaodB/d4voclIufhN9YzuDMUWZppk1HD2trJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC2cd74ZxGLnIfCq4IgzuEDNVYIao/Kfh0FCCWKEGkw=;
 b=vF8z8EpDgh7O6cyN21WEy3AYZQqdNbSdLLBj+q2IR3b93dLXMuThmLJsn7l0BEUq10o4f+oSpvvOQvbc0FjykmFhQTaLaSEVCjkLtWhb6OeKo2WreiR8+MsTgK+xFazaKLSFxVD4XVPu132z5LniILM7G6/H9WtR0q9d1bZT4vvUeFKt2BBcbbEI5z0qcAHGtCC8cAaRtJquatvP6L9bsieaoZWv/cRYd8OTf5v5Eu8JckG4iBfuc5vFzGWEBApdmOH73P5ojuQCjP+UsoTLgnTLFgjXzTIlGmHLYfd4LAFcTLZUAhNxWCHzQlobNGxwfsNua7siehSKgPzviLt/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC2cd74ZxGLnIfCq4IgzuEDNVYIao/Kfh0FCCWKEGkw=;
 b=jjttQqQnX/VJe/MeJi7ylDPpuicmjqAoaN1it6ldca1f45If/WXTgTadc7lbrdpYlkBReMeaqC06BlLiIT0a61b2xdz467tfLHddAP1f88rysoxtuvRD3nr8xQuPGimQstF6aqX1dzqWfBYY1x2on9Z3WasJ8WEJDTnffo7rgnk=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by PH7PR10MB6033.namprd10.prod.outlook.com (2603:10b6:510:1ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 09:15:50 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 09:15:50 +0000
Message-ID: <1d6db802-3871-4590-b4f2-68a146099404@oracle.com>
Date: Thu, 11 Jun 2026 10:15:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v5 01/11] dwarf_loader: Reduce parameter checking
 with clang DW_AT_calling_convention attr
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260523165712.1225231-1-yonghong.song@linux.dev>
 <20260523165717.1225535-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260523165717.1225535-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|PH7PR10MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 414a5f7e-513a-435f-cde9-08dec799ff1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|3023799007|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O874rlbLhWpotyFtWdLtMXelXIFJHsnYOYW+HXYGBn2IU70vZSy8A94j3amAYlnAdH184HrF7LRrIPaCIGve2WRmhUvlm7pjcx1zSXuDCPqxNzNYcKe91VY0jLwwZ+WOQ1HriC40ENJczxJHSg2s7YIYm5sBwV9q7mQHXN2K6xSkaN5LEaRqjGEYGcMddU0wZXEYNqEVpfz2o2FpM8w4gz6wfb1ZvkRrLF8TGs78eNKOLL751EQCt8Q6VzoQilRloJnNcBHR/w3WHlhZpLiw1w3cH8M79fTPHYWNjMiKv0RkIcff7py1l37Ya92fM+KbjgQ++oKR+txYrUpkWP0BTZkVHwHVX2KugVxYggBAgUspHsYjEJ/k7p40Zhmlr+c6euYiGs4/UPwI1Q9H9PhIN6+VYKHMvKtiZynHswl4j5bvlMsHmWUuSlTrY2BYlNUvYLjzaE+O6g99fIxKiiL4XV5QNc14Vod2nsjllu3srhfLOg7u4FGVarXOhCUcYsTdOYKjPGvu97cyWgiTyLruufAcqljGGvnZa8T8rLUSax99455XXW1aQoARRy79tA4J+E1YmxpNNwKGP7s85MVlD6Kp/mPvguSEAiawKAU8mLHYTnz7GFy5ofcD6xFBtfW82MOCgOU2ZP8nZ09FspgsfyxCOXafbJTqW/9m3fQ6RwX/jvo/SwTxYJPrv3c6rR5Qxo1A2VJYtFbz8ODRLtgt2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(3023799007)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1BEeDRldDcyVytNR1E3OER4OVhMRVdJS1g3MzdOR1M4UTV3MVdYTWx1N1Nj?=
 =?utf-8?B?b1B0Y2wvcENGMmpWTnFoY29lT1ZucUJIWVBqK2d0dUMySTVsUWVtTlJoMlda?=
 =?utf-8?B?eWR6RUpOWTlxR0J4d0hqeHFJc1hoRjB6dHdxbDgvSVRhT2VkY080OS9nWStZ?=
 =?utf-8?B?T0FKTm10dk04SGdjcmJrbjVQOUNjODh4NGNzZ3VpYVIzODJ6YjU0ZEIwQlZp?=
 =?utf-8?B?UUgvUDRSMXlHeksyTjFIRmp2M1JGVHYybEVockh1OUN4Z0wxWWM3dWZFUXRZ?=
 =?utf-8?B?bll4aUd4QThQR1p3L2hsVjZTNmN1OFd6TjZVdDQwWDhJU2x4dW5pWlJiTjFn?=
 =?utf-8?B?a3NRN2t1YkNGWlV2M2pFNzRVbkpOQzdFTkRzOTVkWFBvQ1RuTVdJaVRDeWU4?=
 =?utf-8?B?d1BjUWd0UWtlNEdxdDZkZzliaDgwWEZRQ1Evc211RnJGdGlUMllLMWRHYU13?=
 =?utf-8?B?RUVXdS83b01jUGgzRTRRb2lyTUNFdXJNOHFZSkxkL0VManlGL3liUlJBeEQ3?=
 =?utf-8?B?d2lxWU1IS0I3SE5ldFVxNVVYY1J2QzAzK09ZTEdENEJmeVNxdWF5M05sd0RV?=
 =?utf-8?B?YWYrSTd1akRVQmlIaTUvU05tRkxnMnJWaFdmc2xzY1ZuT3c3dmNDZHBTb1NI?=
 =?utf-8?B?UXNWb1JMTEQ0cjkwMlU5TGRxa25GZXZMS0ZVZGdnN01wVElKVjh3VHJSb29v?=
 =?utf-8?B?WjloK29kUlRoMS9YbTAxcnloN084S0VjRHlQa3U1Ykh4VW9oUmkvNVEvektY?=
 =?utf-8?B?MXkvSURZdWJoamkzVXVLbFNwNFlxblZ3QzB3K2U5dW9sQjRyVVhIYUlCaUNJ?=
 =?utf-8?B?RCtBMjd4S29VMmdnamIvZmh3OGpxSkhlM052OGdvTFNrSDNnbmNLRjBzVGl3?=
 =?utf-8?B?VmpBellnMVMzM2NsclJKVklJNkE0bExqVmVXWG9jRjJ4MFdCVDljNFdlZUg5?=
 =?utf-8?B?enByRVI2N2hBQkRvQmdud2MvR3lMY3NiZ3V3eWRkaHRaK0k1WGpCZzY4NUY3?=
 =?utf-8?B?K2N3NVZjN1Z3UnhROEhvZjd2WHdiZkZsS1kvalFZNmZLMjhHaVRlODgxVDUz?=
 =?utf-8?B?UGF0YS81NTJWQkZrVWQ4STZFTytUSlh0QjJEekw2UXY4VWVrYTRRenhNUG9Q?=
 =?utf-8?B?RUNGbVVtSThwNzVUMmZ3ZWVNcWN3TTBBUXVSYnBZckZmUjJtMkdLTEQvMWVB?=
 =?utf-8?B?L3ppUi9tVndWSWcvaFJpV2h1K21iYk9rVzY5VlhGU0QwY0l4TlNyVzZiVDgw?=
 =?utf-8?B?UzdRb1NHS205WVJLMEk1MG1sTU11bDNIL2k4akRiSm9zSzdmQWlQVFcxYTFx?=
 =?utf-8?B?NkF3ZVRnL1FRL05kSW4weE9raE8vKytiRFBmV280eUtHSmNXVkh5bHdTRFU4?=
 =?utf-8?B?ejNudzFkU0xma1l4d3dINlYySnYyRGd3MVRTdWxGS05peVZ6ejlPNzhmdlRZ?=
 =?utf-8?B?M29mV0E5YjNIdFhWb2Rsc0N0RDdMT3JILzFITmhPL0hrREJ5SnRYU3k1bEhq?=
 =?utf-8?B?eEF3RnNJWFNDb050cXZWQ3dQakNGcFJ3cSs3bUdZOGZBb2luTG5PZjVBM0RO?=
 =?utf-8?B?YkZ1bDQ1cEVxNmhUdlZUVzI5aGxUNlc0Z0Y2clZ6VUxlUzhFUDBIOGFLc3JJ?=
 =?utf-8?B?cjlHMWVLV1JUaHIyUndOb3V0ZmY1R2Nlakt3YUVialpzNi9udGg1cWVzMWZr?=
 =?utf-8?B?dHNmMk4wdDkrQ0VaTm9oTVFQb2RZU1Frc0ZoenlhMmlZblNvTnBvbVZQZ0wv?=
 =?utf-8?B?azlBc1BBRU9UUHFkYTVkWWdxNWxaWDc5b2liYmJ1UE5yZEhRRW1wSzFHK1dr?=
 =?utf-8?B?M3ZPTUlSSStxNkNDaS9keXptRkxZS2ZUajFqdDdXZnZ1N2IyTUxuczAwcTRL?=
 =?utf-8?B?dmpOcnlmUkV0bm8zTjUxTjBqc241MGlDQnVobUdtbzFZZUJGREJrMVltN091?=
 =?utf-8?B?OStNVkMrR21FQzMvVkd2ZW5QY3NSYWJNM2laZXdKUU9PbHlDUHFwdmRZNUZP?=
 =?utf-8?B?Wlg5WStaVXhYbFo5bThNZjF5c2lTcDJXTE4vQTNXbGl0T0JBQ29RS0ZCbHFQ?=
 =?utf-8?B?R2I3SnY0MU42eGpwbytJY1h1TEZoeHU2cndrNmxCaVhJZU5oc25ZdVVmeDZl?=
 =?utf-8?B?d1BmSXZhTnk2ZDJ6TDRDVWR0QVJTeFJpUEZha0VOb2dOVUEvdzZJNnBRSmdh?=
 =?utf-8?B?eUNuMVRRZFIyMDZzU3JIcXo3VmZLYjBic2RDeDNmUjRCWXB3RzZrbnZhVldl?=
 =?utf-8?B?bE9TazJmSW1QTkhsd0R0dE8yK2l6OWdxazNKYnh1MUdCZ2pId2gva1ByOGVk?=
 =?utf-8?B?Ly9kQklDNkR3bmlsQjluQno3bERINFQzVGE3RzRWYyt5VGdkRk1Xdz09?=
X-Exchange-RoutingPolicyChecked:
	smy2bCDXCxvICK/FGz0d1xPdylI1AY1xkt+CCoMbvQGb1HLRoHXyOBGRvnJe+J+BYhwG1DROKrnnToYXEnWysUwx08rYfYnnl73ZP2N3wtTsGeNiZ0Bo9WBExGfeViTbvj/vxWtQK0/H1fVURcaJga1SPyDt/tU+Pbc/fmc7fqeK0IW2WasPTad2Z/QoQuXqLX4EIo74klIYjyZUyRTJM8Cx/FZ7Hi8zWGrfcGTmRMU5RKJNHU9kTeRkwlIWt5xKTbCJ2MOL14plOIzIKiIYWM78wvBLxrVSfcvBSchGh2b4lRMyc/zIYMKG+uc1xgwAv0vbOtUBEmHn20PHHHn+dw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jvYVviop4Z06sGgo1jwqw4OqDP18zN6sL2qbBDVJhcNSnGhobHtTvgBxZHE1jk8N3Uv4UWhAokEm1qsNoNpptQiLIT+j0QBLMh2L89WWPagKS9wdCh/Jfq5kFeaF+IVZtAGYMtstu9D2eROdZwGP231cXYM/FC6PtbTxQyG8QR9+WyKASv/HUy+ZPJKK6OyatL3tSCrnu7nObec0qbFYfbEtDzVrb2JC57AG6vIoLalj7iP5s+bYunQlK7993p8z0PNYifhOfOsQcFjIAdhj+XR8PuLbIvwOcsg5mcM9EKpeHuSabQ+xc/+XABnUfVCFAWg2couUGsCbyteMumAtr1gZ1EoUiAB3g+pbHnsCoW59lZ1QIguJjIeBHn+n4uYUFVydXbrEiyWKiXoWHdEG5qg9Q8afHwIkjWldqN915hbuM+4+HgKIczgIS9YadB5/GDYUj26jJSTiRlGA6EdAn5DeF5kNZ4slonSm0JKaJKVpbFTaopkNWKw/0JNlH6Km8hKMHUKBqVbHA2CVTyVSfhfSSRmAD4Ze98dgdvyWQaSriuynoR6fIvCpuegSZ65jMqfnmk4PExYT4MuylyfA8Fze8BZpAqvIcV5niDzWCIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414a5f7e-513a-435f-cde9-08dec799ff1e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:15:50.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 628DfA6gtXl/j5abk8ODi89LtlpMSN3YvWY1vV6EO9ci/OAVvskqBZ+zgCkqX2Vhkt7JQIM1h/7DdKs6q58fWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606040000 definitions=main-2606110091
X-Proofpoint-GUID: E5-JIo8NxHcLNoAYRBapq6jgpFqvpR-b
X-Proofpoint-ORIG-GUID: E5-JIo8NxHcLNoAYRBapq6jgpFqvpR-b
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA5MCBTYWx0ZWRfX28KN1mxJvFQ4
 5QPnHwBKYPNWWIlRzvrvqGb8fqjZpuSK0OWVmcseyY3QV/ATQe+FxwdFuiD/OhEs5Z0X21mmxSi
 MfdWnDZdb6NqHNw2HhBPb9YGjb2vzWT7qwl2zwplSZ8ZBCXJfpdJ
X-Authority-Analysis: v=2.4 cv=edINubEH c=1 sm=1 tr=0 ts=6a2a7cce b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=NEAV23lmAAAA:8
 a=_s1Dj3tck1VQEgHFaeUA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA5MCBTYWx0ZWRfXwUZCgvdIHDmB
 5+RXt0tGJn2h7Xyd8vyPR6+kCnKoQV4IIW/s9ZG41H4Xkbus846tiHE60lLJtnyKQPvLOjnUHlA
 AjXjEhmVlJ7GF9AiQ/R3Qc0s7sSKDjMZT40FUEG9RUvaU8XqIZcxnFuuEbMRY0yh7zggLavoOSy
 P+Fe/JxgcM2B26ShXFE1JpjZKaR0QLGVzPrAQuODc5i8V/4ltoKvP3zG8anW0E4DWQYtfL489zP
 cawUbuFasUjxH2dNlPTMjxY5fe2P6PUZEJdZ76ZUkfNEp6OsblN74zNbNYUSF0zMJjPp9TtnZ4M
 /nZGZKWWfDZjb5SQEXNyyjIV/YP72WxtgG8jNidaqZBsXmuMVPYjtcf+YaJ7FyBMjypZBWWmDSL
 DWDW6y3yo4YqcbwzuvwTYfGACDuTqsc1D5S0nrLBcaOyGKMBHzFu6UJHQghDgaXR3FwzXPufC+y
 TgVINWXmTgxXY9fFFLg==

On 23/05/2026 17:57, Yonghong Song wrote:
> Currently every function is checked for its parameters to identify whether
> the signature changed or not. If signature indeed changed, pahole may do
> some adjustment for parameters for true signatures.
> 
> In clang, any function with the following attribute
>       DW_AT_calling_convention        (DW_CC_nocall)
> indicates this function having signature changed.
> pahole can take advantage of this to avoid parameter checking if
> DW_AT_calling_convention is not DW_CC_nocall.
> 
> But more importantly, DW_CC_nocall can identify signature-changed functions
> and parameters can be checked one-after-another to create the true
> signatures. Otherwise, it takes more effort to identify whether a
> function has signature changed or not. For example, for funciton
>   __bpf_kfunc static void bbr_main(struct sock *sk, u32 ack, int flag,
>      const struct rate_sample *rs) { ... }
> and bbr_main() is a callback function in
>   .cong_control   = bbr_main
> in 'struct tcp_congestion_ops tcp_bbr_cong_ops'.
> In the above bbr_main(...), parameter 'ack' and 'flag' are not used.
> The following are some details:
> 
> 0x0a713b8d:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x28) loclist = 0x0166d452:
>                      [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg5 RDI
>                      ...
>                   DW_AT_name    ("sk")
>                   DW_AT_type    (0x0a6f5b2b "sock *")
>                   ...
> 
> 0x0a713b98:     DW_TAG_formal_parameter
>                   DW_AT_name    ("ack")
>                   DW_AT_type    (0x0a6f58fd "u32")
>                   ...
> 
> 0x0a713ba2:     DW_TAG_formal_parameter
>                   DW_AT_name    ("flag")
>                   DW_AT_type    (0x0a6f57d1 "int")
>                   ...
> 
> 0x0a713bac:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x29) loclist = 0x0166d4a8:
>                      [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg2 RCX
>                      ...
>                   DW_AT_name    ("rs")
>                   DW_AT_type    (0x0a710da5 "const rate_sample *")
> 
> Some analysis for the above dwarf can conclude that the 'ark' and 'flag'
> may be related to RSI and RDX, considering the last one is RCX. Basically this
> requires all parameters are available to collectively decide whether the
> true signature can be found or not. In such case, DW_CC_nocall can make things
> easier as parameter can be checked one after another.
> 
> For a clang built bpf-next kernel with x86_64, in non-LTO setup,
> the number of kernel functions is 69103 and the number of signature changed
> functions is 875, based on
>       DW_AT_calling_convention        (DW_CC_nocall)
> indication.
> 
> Among 875 signature changed functions, after this patch, 343 functions
> can have proper true signatures, mostly due to simple dead argument
> elimination. The number of remaining functions, which cannot get the
> true signature, is 532 due to dead or additional-checked parameters.
> 
> They will be addressed in the subsequent commits.
> 
> In llvm23, I implemented [1] which added DW_CC_nocall for ArgumentPromotion pass.
> This compiler pass can add additional DW_CC_nocall cases for the following
> compilation:
>       - Flag -O3 or FullLTO
> So once llvm23 available, we may have more DW_CC_nocall cases, hence more
> potential true signatures if the kernel is built with -O3 or
> with FullLTO (CONFIG_LTO_CLANG_FULL).
> 
>   [1] https://github.com/llvm/llvm-project/pull/178973
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 86 ++++++++++++++++++++++++++++++++++++++++++--------
>  dwarves.h      |  1 +
>  2 files changed, 73 insertions(+), 14 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 16fb7be..0bc4fc4 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1190,6 +1190,10 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>  	return ret;
>  }
>  
> +struct func_info {
> +	bool signature_changed;
> +};


Looking at the code, I wonder if we could simplify by passing in the ftype instead.

parameter__new() is called via

formal_paramater_pack__new
	formal_parameter_pack__load_params

and 

die__create_new_parameter

In both cases we can access the ftype (though in the case of the formal parameter
codepath we'd need to pass it through formal_parameter__pack_new()). If feels like
it might be a cleaner design to do that and set a signature_changed bitfield for
the ftype, since that's where we usually set attributes that apply the to signature,
what do you think?

The other aspects added in later patches I think would work there too. For example
the accumulation of parameters would likely be a bit easier as we could better
handle the skip_idx logic which is tricky. On that topic could we just add a
next_reg_idx directly to the ftype (or the func_info if we keep it) as the goal
of the skip_idx seems to be to figure out what the next expected reg idx from
the calling conventions should be. 
> +
>  /* For DW_AT_location 'attr':
>   * - if first location is DW_OP_regXX with expected number, return the register;
>   *   otherwise save the register for later return
> @@ -1252,7 +1256,8 @@ out:
>  }
>  
>  static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> -					struct conf_load *conf, int param_idx)
> +					struct conf_load *conf, int param_idx,
> +					struct func_info *info)
>  {
>  	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>  
> @@ -1263,8 +1268,15 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
>  		parm->idx = param_idx;
> -		if (param_idx >= cu->nr_register_params || param_idx < 0)
> +		if (param_idx < 0)
>  			return parm;
> +		if (!info->signature_changed) {
> +			if (cu->producer_clang || param_idx >= cu->nr_register_params)
> +				return parm;
> +		} else if (param_idx >= cu->nr_register_params) {
> +			return parm;
> +		}
> +
>  		/* Parameters which use DW_AT_abstract_origin to point at
>  		 * the original parameter definition (with no name in the DIE)
>  		 * are the result of later DWARF generation during compilation
> @@ -1337,7 +1349,7 @@ static int formal_parameter_pack__load_params(struct formal_parameter_pack *pack
>  			continue;
>  		}
>  
> -		struct parameter *param = parameter__new(die, cu, conf, -1);
> +		struct parameter *param = parameter__new(die, cu, conf, -1, NULL);
>  
>  		if (param == NULL)
>  			return -1;
> @@ -1502,6 +1514,29 @@ static struct ftype *ftype__new(Dwarf_Die *die, struct cu *cu)
>  	return ftype;
>  }
>  
> +static bool function__signature_changed(struct function *func, Dwarf_Die *die)
> +{
> +	/* The inlined DW_TAG_subprogram typically has the original source type for
> +	 * abstract origin of a concrete function with address range, inlined subroutine,
> +	 * or call site.
> +	 */
> +	if (func->inlined)
> +		return false;
> +
> +	if (!func->abstract_origin)
> +		return attr_numeric(die, DW_AT_calling_convention) == DW_CC_nocall;
> +
> +	Dwarf_Attribute attr;
> +	if (dwarf_attr(die, DW_AT_abstract_origin, &attr)) {
> +		Dwarf_Die origin;
> +		if (dwarf_formref_die(&attr, &origin))
> +			return attr_numeric(&origin, DW_AT_calling_convention) == DW_CC_nocall;
> +	}
> +
> +	/* This should not happen */
> +	return false;
> +}
> +
>  static struct function *function__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  {
>  	struct function *func = tag__alloc(cu, sizeof(*func));
> @@ -1800,9 +1835,9 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
>  					     struct ftype *ftype,
>  					     struct lexblock *lexblock,
>  					     struct cu *cu, struct conf_load *conf,
> -					     int param_idx)
> +					     int param_idx, struct func_info *info)
>  {
> -	struct parameter *parm = parameter__new(die, cu, conf, param_idx);
> +	struct parameter *parm = parameter__new(die, cu, conf, param_idx, info);
>  
>  	if (parm == NULL)
>  		return NULL;
> @@ -1889,7 +1924,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
>  			tag__print_not_supported(die);
>  			continue;
>  		case DW_TAG_formal_parameter:
> -			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
> +			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1, NULL);
>  			break;
>  		case DW_TAG_unspecified_parameters:
>  			ftype->unspec_parms = 1;
> @@ -2118,7 +2153,8 @@ out_enomem:
>  }
>  
>  static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
> -				  struct lexblock *lexblock, struct cu *cu, struct conf_load *conf);
> +				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf,
> +				 struct func_info *info);
>  
>  static int die__create_new_lexblock(Dwarf_Die *die,
>  				    struct cu *cu, struct lexblock *father, struct conf_load *conf)
> @@ -2126,7 +2162,7 @@ static int die__create_new_lexblock(Dwarf_Die *die,
>  	struct lexblock *lexblock = lexblock__new(die, cu);
>  
>  	if (lexblock != NULL) {
> -		if (die__process_function(die, NULL, lexblock, cu, conf) != 0)
> +		if (die__process_function(die, NULL, lexblock, cu, conf, NULL) != 0)
>  			goto out_delete;
>  	}
>  	if (father != NULL)
> @@ -2246,7 +2282,8 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
>  }
>  
>  static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
> -				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
> +				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf,
> +				 struct func_info *info)
>  {
>  	int param_idx = 0;
>  	Dwarf_Die child;
> @@ -2320,7 +2357,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  			continue;
>  		}
>  		case DW_TAG_formal_parameter:
> -			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
> +			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++, info);
>  			break;
>  		case DW_TAG_variable:
>  			tag = die__create_new_variable(die, cu, conf, 0);
> @@ -2391,11 +2428,19 @@ out_enomem:
>  static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  {
>  	struct function *function = function__new(die, cu, conf);
> +	struct func_info info = {};
>  
> -	if (function != NULL &&
> -	    die__process_function(die, &function->proto, &function->lexblock, cu, conf) != 0) {
> -		function__delete(function, cu);
> -		function = NULL;
> +	if (function != NULL) {
> +		/* For clang, we determine if function signature changes via DW_AT_calling_convention
> +		 * set to DW_CC_nocall.
> +		 */
> +		if (cu->producer_clang)
> +			info.signature_changed = function__signature_changed(function, die);
> +
> +		if (die__process_function(die, &function->proto, &function->lexblock, cu, conf, &info) != 0) {
> +			function__delete(function, cu);
> +			function = NULL;
> +		}
>  	}
>  
>  	return function ? &function->proto.tag : NULL;
> @@ -3045,6 +3090,17 @@ static unsigned long long dwarf_tag__orig_id(const struct tag *tag,
>  	return cu->extra_dbg_info ? dtag->id : 0;
>  }
>  
> +static bool attr_producer_clang(Dwarf_Die *die)
> +{
> +	const char *producer;
> +
> +	producer = attr_string(die, DW_AT_producer, NULL);
> +	if (!producer)
> +		return false;
> +
> +	return !!strstr(producer, "clang");
> +}
> +
>  struct debug_fmt_ops dwarf__ops;
>  
>  static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> @@ -3082,6 +3138,7 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  	}
>  
>  	cu->language = attr_numeric(die, DW_AT_language);
> +	cu->producer_clang = attr_producer_clang(die);
>  
>  	if (conf->early_cu_filter)
>  		cu = conf->early_cu_filter(cu);
> @@ -3841,6 +3898,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>  			cu->priv = dcu;
>  			cu->dfops = &dwarf__ops;
>  			cu->language = attr_numeric(cu_die, DW_AT_language);
> +			cu->producer_clang = attr_producer_clang(cu_die);
>  			cus__add(cus, cu);
>  		}
>  
> diff --git a/dwarves.h b/dwarves.h
> index 5ec16e7..b49e651 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -306,6 +306,7 @@ struct cu {
>  	uint8_t		 has_addr_info:1;
>  	uint8_t		 uses_global_strings:1;
>  	uint8_t		 little_endian:1;
> +	uint8_t		 producer_clang:1;
>  	uint8_t		 nr_register_params;
>  	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
>  	int		 functions_saved;

