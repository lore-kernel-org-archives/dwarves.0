Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35751D2F61
	for <dwarves@vger.kernel.org>; Thu, 17 Oct 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161020; cv=fail; b=AM+RMBasOQ0dnxMYTkLI0LhasspKoWilnYN7P4bZpUwrijJqmXBiNZVuoAQKYu40v4lqQ0GMJUK3h5HSQ9Nelxlq+KEQmVYMTE4tRWwiGvSUcvRkOfmB/XYIlO4lKx7C1omTPPKcDaIMTo6G6Iw4WJ7c/8lfzqkgm7NGvbyaP0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161020; c=relaxed/simple;
	bh=62A5r01HLZxypsfK/kLmmepfXUg8Latm4QLVw1+UhT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dYrRP7dvhKan5FtDhDfzXX7pA4vRfQpDPjN3Hj3gU5Pa91Z2XTgtWxR6+ap/IDD5BAbc5qDaxIkzM3fVoq4otqh6bN7lFouEVLLA4jc5BZDlFjs/h0Svx5gCz7wdcoMZVSi2uC6mZAnOWaZ+Sx0DZy1pRqamhT3ffb8b8I1kDmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OQDfuGcq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ol/8rX+f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OQDfuGcq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ol/8rX+f"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9MbFI017390;
	Thu, 17 Oct 2024 10:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=it/hgknSqZe5y2PVs4UHF0JrWKg75Idzx4CVQHnZHpo=; b=
	OQDfuGcqsrbKeW/TVILHsXU4+PZxCm7Mqu/oqxIJnoNzF7hlZ6grE7m330pHoxvB
	zNZf064IqnC/rALGVdLfEXHWiL6a67+1XB+NsqEQ7FiI3PpKrLcjpZhEgd6nz1tv
	i789Dt8K6JfKLhKX7iVfqo3kS1q73yHdEoFBZO9IjAJ/DBwKhguyLr5fmIWH8/Wd
	bKcal6fVZw9g7MPb8dAWI4WydEp9dLVy50KZbY9eDdI1zV4bV4YeJqNX4+ARe+nK
	wgNlgkM4qc+QHBxbH9PxLtgdsdx8lcJpI7D/wliyM9SyC0y25jiKz40nMrb+8USl
	63TPa1RXt+GIzQcoYpwqXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2p4f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 10:30:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9Sfd2013985;
	Thu, 17 Oct 2024 10:30:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fja0y4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 10:30:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUUAgPlwTm5mc2wzHmFUKhTntLua4nvqAiHiZFcUQqCMoP/GTZhAnZHUSVPI5wgwMKy6rGlafXInhErqqzLrchMEXmAalIwXSg6a8n2t2uccU7lgAOQeQFq3whJbsyoB2xlPJIKims38BB6D8Vn1VJcVAJigTzG/OYe+zO/fLpvoSid655CWLE2LnGkS783yH0d+4ypkY1q10Hm6fsDHfWQWZtQHVJtelQQgr7bOpLRhrJOFjJi3d04X+4+8SKI1Z/XHcwd3I9wtkn3iVBCl8ldJdtqoPkPKa1dLdu4UgZYkgYcXoiPY6ULN0vy4MTjUZAl/zH8D/mGYvH7PleVEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it/hgknSqZe5y2PVs4UHF0JrWKg75Idzx4CVQHnZHpo=;
 b=us9shXD0vPls8lbb7xWZ8GtIanB8sJCwodboYc7ZXqFcbgGUoWuVF9kznFlYYDS9N4UG3BX3iGTfj1UpAeIAi6/AS6QmfH+Oiv077yku4K64e9zl+6wevqzggdHp58z/sf2P8bxYe4rF4VGT3LiWpWaR02yKiZeLIm9dih2bPLpaXkjovaWm2imwDRliczp/jAZEnjmd/tXwBhVlFosUVOs9h7sqHy49Sx8HlVTupysUjb5rV7ZzBlHtYfGKngVC0HNU0oF31NgIEpRoa+iRcJhmIvEHPbDOz0RJDtKJrRIq9d46lkj8CbAbFwRyb9/TjfX4Dzl37MSytCUVBqYNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it/hgknSqZe5y2PVs4UHF0JrWKg75Idzx4CVQHnZHpo=;
 b=Ol/8rX+fvbQlegALHC+VUzCKjY1VxGpiwrXq4IZuwE9toqljGsgWOF5qVqHHXnihHZUS0hd4314mdGzG1eVUbX6XXrsx9+rZna/7LB4iJra0j/N0MWPdNoSV/pnZiW9KVBCcKI9PY8NR3e5R4/XVF5m1pm57nenp+Ne7lJvB3Cg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 10:30:02 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8069.020; Thu, 17 Oct 2024
 10:30:02 +0000
Message-ID: <dd7e384a-2af7-4fd2-8cd6-02d3dc0e5ebc@oracle.com>
Date: Thu, 17 Oct 2024 11:29:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 2/5] btf_encoder: introduce elf_functions
 struct type
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, andrii@kernel.org, eddyz87@gmail.com
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
 <20241016001025.857970-3-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241016001025.857970-3-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0673.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cbc702-22c2-4647-7790-08dcee96a8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVBodjNaQjVFTElycEU2aFVzV2JER05nejI5OWNQQ2RUQzRraEpldXRESUxV?=
 =?utf-8?B?MDhONnN1d09WaXBzazhMZGx1cFh1UFplMnBTQW5OTFV4bFVPdFhwRW5SVkEv?=
 =?utf-8?B?SWQvejVGZ044RStjd3Z3ZSt0Q0pTVUFSak43SnVwa1dkWVJ5ZzltWUZpcU9y?=
 =?utf-8?B?R0F0N0Z0aHg5eEY2WUpiOFo5TnU2UDVHMHhMVHBvaXFEQ2NVZXIyRHlZRTZF?=
 =?utf-8?B?aDNsVzNBQ3ZlYjUxTFlCeG84bUwzSXFqRzhMOFZEdm1ydUl4cWJHeEhCdXlY?=
 =?utf-8?B?NGRVelFGZlE0RjZIcmNEVmlReFJDOXkzRG9VYndEdDFnSmpVMmNJS0M3dDRV?=
 =?utf-8?B?NmRYMk1PUGhRV3NRaDFlNFVuTUEzS2VJKzd0clVPWTVTeThLV2M4YnJjeVcv?=
 =?utf-8?B?eHRQOWtZc3VMYXhSTUhzYmtDVmE3ZXNicVI5R1pWUkV3ejFvTHVjcVJ6N2xU?=
 =?utf-8?B?K3g0RDhaLzVUYnMvdGFWaHFqU0pybXhTcHRvNzdBV1pqMUZjN2tPQWVUSEI3?=
 =?utf-8?B?YVlGZ3I3ejZocXF2MS90dHhRUEQ3T3lLOTBMMDcwNlc1eXFJKzFuVlN6Um8x?=
 =?utf-8?B?VGM4MU40ekpGQjRlcHZBZkRaVC9wUGdlUjllTXN0YzdDczBwQ0xXR2trR1VZ?=
 =?utf-8?B?Um13bUVYcTlxdUU3ZlVFYzR6aTQ5cEMzbXBmWTBwTER1Z212TmwxYzRHL0xl?=
 =?utf-8?B?b28xQ2hNVXEwcFdaMHY1b0xLNVNuZ0ZvWnIrc2pxdlBHNFpoNW91N0hxcmpQ?=
 =?utf-8?B?UFRseDdQdkR4S3U5aXo1MlVNOXpPUmRkZ0FWWERpRUtlVWtZNVNoTnM5WFl4?=
 =?utf-8?B?U0E2QU5kSzhTN09XOFdUZkhiZWZ4dkdGZVI5aFZKZUE5L3hrOTlMY3EzK3pR?=
 =?utf-8?B?T2MxRUZjWEswbHkxdE00NTc5UDN4L3Q5d0ZjSTNvM1p2ejRUemY5YWpSSVAz?=
 =?utf-8?B?MHZrdW5CbUc1ZVAvRGk2WWJaOVBXVVk2SERMV2I3YzFlSzlnQStiQXhMRk9q?=
 =?utf-8?B?NDlRcTZMd3c2OUM5ZFB6aUVjSHZ6eTkxZlJ0cTM2MlBLZ0Iyb2djTFB6NlNK?=
 =?utf-8?B?Wk0wdTNCTjlFTmNvYiszNTlOTGpCS0FJMWVRVHkrOGFFeFNSdU9jbldrVVcw?=
 =?utf-8?B?K1ZrK0RoQUUwRjl2eUZ3SUF6OWFmanlWTWRzdzVYeUxjMHJVVHVDM1NYaTJ6?=
 =?utf-8?B?Zlh1L2tudGJnVm1HVGV5R2I3YzFqckRRSGpCZFczc2FsY2Y1NHcySmNTbmFj?=
 =?utf-8?B?NHcrR1hYc0Q1Qk9Ob1pUTXFOcUxqaWorYU5nVDNacnhqbzRxTXhtK2gvMHp0?=
 =?utf-8?B?ajZUdUE4Vk12V2NWTkgrYzZvRUMyclFnVXdzSDlWb0x2MXoyT0RTTzUzMEJv?=
 =?utf-8?B?Y3JNVWJVYytxR0dRUlNqTDR6VmRsYkpOZU9NbTNZT0J0K0VBK0tQZjdkNVV4?=
 =?utf-8?B?dkJlVTJUcHQzSjdDYUJEenNXaitYekp2YVhxUXlLSldYRHRXMVh3alJCb250?=
 =?utf-8?B?bTZQWXJwcDVYeFAxbkszNHR3NjdVQ3c4bmVwYzhrWTU1NlNUSDFteDQra1ZR?=
 =?utf-8?B?SmRNV2UrN0F3M3h4UnFNWjdBeVVERUlmQzlLRkhlSlhDVHBaSFdGVE5Mc3d2?=
 =?utf-8?B?eFQ0elFGRVR0d2dPVnhTTDdnZEVBM2Y3ajh2VEl5YWcvM3N1SUNub1FPaUtI?=
 =?utf-8?B?NGt3blhNUlRZMExBK0F4cS8zLytnRWQ0QkoyVUk0SVRiQ3RMbXFPZFNnR0VT?=
 =?utf-8?Q?b5QwNRXfSZJtzT+DbjStoAlz6orV6RbB8MUGgTi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnlpRkxvaDdHWlFITEROa3Z2TEFLODNJVzhmQ0s1L3FXMHhWK0hkRWI2S3V0?=
 =?utf-8?B?dGMyYnNJS0VyeHlmTSttMjFXeFdid1p3YXNyeWJJNDFxVjNTZVJ2WGtEU00x?=
 =?utf-8?B?Yk9sajVWYUdINjdDZGdVYlE2TWdsTFVvNmxKd3BkSENXT08xdjRZWmJFTDU5?=
 =?utf-8?B?a0FUcGFNeDhNbEU2MVNTektBSTJxek5wRTdPc1lLekd6dDhHMkV5Tm5IeVFG?=
 =?utf-8?B?RUFtRXozWDJUeEtoVVVTSUhpOE1EdFpFQ05CS1JlNnI1Vm1NQmZTY2ZoclZa?=
 =?utf-8?B?ejFURjVYNFpVT2V1dEtOTWNBVW5qNHVkblJSZHNiNU5FUGt1OU9ZOUdsV0dv?=
 =?utf-8?B?aHVTSGhId2YzaFJkNlVmUEc5WEo3cHNORmpyM3hXNExqR3lad1kzbUhYempO?=
 =?utf-8?B?b0ZiMUllWm15QzRKTGs1M2p0V1lKWjBPbG92eG1GSzJ0bEY1dGlxcTh5Q0JT?=
 =?utf-8?B?dXB6N0x3NzhJVHN4a1kzZk1WcEwzK1V5Ynk0S2M0c3VhdExRTkF6SWFFOUVS?=
 =?utf-8?B?R3BkcEhkY1VyeDlORkFBK01JaHlzQ0ZZSUdoOTlkMllUbWRaL090b3RnZmR6?=
 =?utf-8?B?ckFxZzVONldGOEU1MEFzdmJMRWZRYllVMTZ4RVV3MTJmOGhlUTl4bFBDdkRO?=
 =?utf-8?B?QTRIZTBjNUNmUFJTaHBnTnZVNDhoS1c4MjEyYkp0bmhpVVZISDlyYmJURlpm?=
 =?utf-8?B?eGE5VnNRKzN0czZ0NVpZV2s1cWtzWXMvVjF5clNmY3c2cWhYZ3BocXhZUXdS?=
 =?utf-8?B?MytwekhqUFFGM1QvZ2ZjS2xERHB0K3VySGI2VzNINUMzRzU0TjdLRGx5UDR3?=
 =?utf-8?B?UHlNaVZvZXNLOVhSV0JOb3huR1lDbzMwTWZleHZhRGNNRnJZS0JkOHBjcEY3?=
 =?utf-8?B?K0tvN1g1MHBIUytmdEFwbWFDTzhvSHdIREJjazZsTE41OU8raGsySUJPMmd5?=
 =?utf-8?B?VDFnSmFyTWVtU0ZUQlVCaFFJT3BwYTkwdEpYTndCeUtKa3Y1TmR0Z0Q4aFE2?=
 =?utf-8?B?ZzBScTV0MkMwTXpXME1MZndUM2dlaXo4THd2b2FFUUI3RTNFeHVRWEZIN20w?=
 =?utf-8?B?QmcrWXR6QmxOd3lsNys1WEFReTdwSlUyYmdIZmRSMVFrdEFzbGZ2ME0zakMv?=
 =?utf-8?B?RVM0bmQ4bWJkUEpDdG5pMFhHemlNZ3BHK3hzMi9vRWlEQmo2Tm9ydG9GMUkz?=
 =?utf-8?B?SFFQT21ieXI2em1Dby9TZ1p6SGRtY1NiamlSdEpZNGhDdGs0WWNEczRka08r?=
 =?utf-8?B?UytQaGJ4bm5BYlBvQ3JzTkVNQ3Q3TXBubUtBQnZjd1NpVFdPMDRuMytqbWp5?=
 =?utf-8?B?M05BWmF2dEFXaEVvTHlTeUJlb2pXbG83ZWdYbVJ2UHVicFllc21WZURUVk5O?=
 =?utf-8?B?dmpJYk10cUtLQnJQcjJhYVdSYWgydEtJL3dkRlV1d2NlbEFVQ2dWYWpvRE44?=
 =?utf-8?B?ZGsxQlhyQjV5TUJxaEFoYW1OZ3VjOXg2N3d3aWJrZ0p4MU9pT0QrbmRJS1JE?=
 =?utf-8?B?RmloWnJQMW42REtQcEozRzdIb2dRQjlqTzlCcW9LR0xxMHVMS3ZQdVhTcnRE?=
 =?utf-8?B?Ni9FS3pqVlZDWHZJSW82ZitINUgwNGtrYVVTaGJ0bkp6bjIwTGgwaTNxaW1U?=
 =?utf-8?B?OUYxS1Ivc3lLMitpUm9PcGw3bjQyVC9BUzdTQnhoTWFMeFNpN1h5clNNNmJ2?=
 =?utf-8?B?ZnhLVVlqelhZbGlSTk1WVVh1ZWVpT0xmQW8xTFVJQWZZenlwdEgxYjFsWEFn?=
 =?utf-8?B?Qk9vTUdoanRUZjV5cTNGOHpkV0pHVU53WVFjWTNGVThGRGptTURSMGFENUZv?=
 =?utf-8?B?cUU1ZGU1RmpyVEo4UWI0VkdTWDJzNUNNc3U3S0hCaHd2KzJLM3ljYS9JYmZw?=
 =?utf-8?B?azYvbXVqRHRrRlNBUmhFcUw2MjVhdzJvdm5Ld2NkbDdETTN0M0YwN2I5RGJI?=
 =?utf-8?B?OUVZL2FHNnJaWlVZa1kvejVHUEVIY3hZdmZPeFhpZ2lMbEJyczlvMjltOW1n?=
 =?utf-8?B?Y1k3SmhPdUMzdWhGWWcvT05uM05aOExkQzMyVHY5aUEzUExlSDhUdmx6YWhC?=
 =?utf-8?B?b21IbHJlNXo0akNWSjFBV2hlNDlOUXp3WGRVeDQxU0Y1WDNXbXVhY1lZU0dJ?=
 =?utf-8?B?SEo1RmxQeWpLMGQ0WUk2WmlOMFhJcks4YUM4QWpIWG4zTjNZYTUxZFhydU0z?=
 =?utf-8?Q?a9d4dcI7HOZM4QL2JhTkxfg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rt3V1vmgy+S95lrreDTUUfW+Z6wqNX6JcC9qD09ZavXrBRNWZpHibCNqfqIZ3IMuVy5zAaQq6Dv8F9Rq8w6xU8Orxd/3oVRxe27bOMBlUWtNV4t9C1sWyAqOZpRMozEj+Ey0QkMMAAdtQjvv8xRaVF+QbYKarzjY7IDhcGC3Sfr72QkrYvkC/ipaiCLhXsOE6bnHDU1l/+D5IPgjA5HzWkv5oZhLu6x/mmHXfvRNF7MijdimiOjbmX0btd4WivwWTaakjJaxeYUoT+wnczy+I4XP97i9defYXI/5r/rlGqd0efa2AB7lVVOuIJXZrdyw69donm3ASdCZCI5pNV7nEiz+NbN0+6fqkEXfyZAyWfirzWZJKcpSTMl5Y3vCusTDcLY5AEdg0O3hyBOVo+ZA5zyzIg1jheElPkeUY4AWl82i01fjZas88giBmo8VILB586Zaqt7qE+wjeKchOCzf11i8jadnHzF2R8gZ+yirAs44SdGd3rJVpKnac/U+9/9aEy0drnPQhXXlZMRcRJ0UViH/g4BE+UgPQmunoRd+0jkaQAaYJYWEIzk0aSAhqNQ5a3DkbD+9VFmygez2U2DVT/jgDavrRtsLx+bebUza65w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cbc702-22c2-4647-7790-08dcee96a8e1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 10:30:02.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVvIO25s7VIn/lcLspf4tvC7+57p9QR5ebQfvCqGWHXzeLL+UMYauoASVWU7UL4uPJcoJMft3th2LuaMXKrIFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170071
X-Proofpoint-GUID: Y5ZBCFtOR8DMXpVGdlhxk6hJQohdNrQr
X-Proofpoint-ORIG-GUID: Y5ZBCFtOR8DMXpVGdlhxk6hJQohdNrQr

On 16/10/2024 01:10, Ihor Solodrai wrote:
> Extract elf_functions struct type from btf_encoder.
> 
> Replace methods operating functions table in btf_encoder by methods
> operating on elf_functions:
> - btf_encoder__collect_function -> elf_functions__collect_function
> - btf_encoder__collect_symbols -> elf_functions__collect
> 
> Now these functions do not depend on btf_encoder being passed to them
> as a parameter.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

a few small things, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 122 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 66 insertions(+), 56 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 5954238..9c840fa 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -102,6 +102,13 @@ struct elf_secinfo {
>  	struct gobuffer secinfo;
>  };
>  
> +struct elf_functions {
> +	struct elf_symtab *symtab;
> +	struct elf_function *entries;
> +	int cnt;
> +	int suffix_cnt; /* number of .isra, .part etc */
> +};
> +
>  /*
>   * cu: cu being processed.
>   */
> @@ -126,12 +133,7 @@ struct btf_encoder {
>  	struct elf_secinfo *secinfo;
>  	size_t             seccnt;
>  	int                encode_vars;
> -	struct {
> -		struct elf_function *entries;
> -		int		    allocated;
> -		int		    cnt;
> -		int		    suffix_cnt; /* number of .isra, .part etc */
> -	} functions;
> +	struct elf_functions functions;
>  };
>  
>  struct btf_func {
> @@ -1299,55 +1301,28 @@ static int functions_cmp(const void *_a, const void *_b)
>  	return strcmp(a->name, b->name);
>  }
>  
> -#ifndef max
> -#define max(x, y) ((x) < (y) ? (y) : (x))
> -#endif
> -
> -static void *reallocarray_grow(void *ptr, int *nmemb, size_t size)
> -{
> -	int new_nmemb = max(1000, *nmemb * 3 / 2);
> -	void *new = realloc(ptr, new_nmemb * size);
> -
> -	if (new)
> -		*nmemb = new_nmemb;
> -	return new;
> -}
> -
> -static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *sym)
> +static int elf_functions__collect_function(struct elf_functions *functions, GElf_Sym *sym)
>  {
> -	struct elf_function *new;
> +	struct elf_function *func;
>  	const char *name;
>  
>  	if (elf_sym__type(sym) != STT_FUNC)
>  		return 0;
> -	name = elf_sym__name(sym, encoder->symtab);
> +
> +	name = elf_sym__name(sym, functions->symtab);
>  	if (!name)
>  		return 0;
>  
> -	if (encoder->functions.cnt == encoder->functions.allocated) {
> -		new = reallocarray_grow(encoder->functions.entries,
> -					&encoder->functions.allocated,
> -					sizeof(*encoder->functions.entries));
> -		if (!new) {
> -			/*
> -			 * The cleanup - delete_functions is called
> -			 * in btf_encoder__encode_cu error path.
> -			 */
> -			return -1;
> -		}
> -		encoder->functions.entries = new;
> -	}
> -
> -	memset(&encoder->functions.entries[encoder->functions.cnt], 0,
> -	       sizeof(*new));
> -	encoder->functions.entries[encoder->functions.cnt].name = name;
> +	func = &functions->entries[functions->cnt];
> +	func->name = name;
>  	if (strchr(name, '.')) {
>  		const char *suffix = strchr(name, '.');
> -
> -		encoder->functions.suffix_cnt++;
> -		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
> +		functions->suffix_cnt++;
> +		func->prefixlen = suffix - name;
>  	}
> -	encoder->functions.cnt++;
> +
> +	functions->cnt++;
> +
>  	return 0;
>  }
>  
> @@ -2099,26 +2074,60 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	return err;
>  }
>  
> -
> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
> +static int elf_functions__collect(struct elf_functions *functions)
>  {
> -	uint32_t sym_sec_idx;
> +	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
> +	struct elf_function *tmp;
> +	Elf32_Word sym_sec_idx;
>  	uint32_t core_id;
>  	GElf_Sym sym;
> +	int err;
>  
> -	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
> -		if (btf_encoder__collect_function(encoder, &sym))
> -			return -1;
> +	/* We know that number of functions is less than number of symbols,
> +	 * so we can overallocate temporarily.
> +	 */
> +	functions->entries = calloc(nr_symbols, sizeof(struct elf_function));

So in testing  we hit a case (a module) with no functions, I presume a
case with zero symbols is extremely unlikely, but maybe just in case,

if (nr_symbols == 0)
	goto out_free;

(we should probably just initialize int err = 0; above)

> +	if (!functions->entries) {
> +		fprintf(stderr, "could not allocate memory for elf_functions table\n");
> +		err = -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	functions->cnt = 0;
> +	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_sec_idx) {
> +		if (elf_functions__collect_function(functions, &sym)) {
> +			err = -1;
> +			goto out_free;
> +		}
>  	}
>  
> -	if (encoder->functions.cnt) {
> -		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
> +	if (functions->cnt) {
> +		qsort(functions->entries,
> +		      functions->cnt,
> +		      sizeof(functions->entries[0]),
>  		      functions_cmp);
> -		if (encoder->verbose)
> -			printf("Found %d functions!\n", encoder->functions.cnt);
> +	} else {
> +		err = 0;

nit: as noted above start with err = 0 and we can just goto out_free.

> +		goto out_free;
> +	}
> +
> +	/* Reallocate to the exact size */
> +	tmp = realloc(functions->entries, functions->cnt * sizeof(struct elf_function));
> +	if (tmp) {
> +		functions->entries = tmp;
> +	} else {
> +		fprintf(stderr, "could not reallocate memory for elf_functions table\n");
> +		err = -ENOMEM;
> +		goto out_free;
>  	}
>  
>  	return 0;
> +
> +out_free:
> +	free(functions->entries);
> +	functions->entries = NULL;
> +	functions->cnt = 0;
> +	return err;
>  }
>  
>  static bool ftype__has_arg_names(const struct ftype *ftype)
> @@ -2377,6 +2386,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  				printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filename);
>  			goto out;
>  		}
> +		encoder->functions.symtab = encoder->symtab;
>  

nit: unless there's a reason otherwise, this assignment seems to more
naturally belong in elf_functions__collect().

>  		/* index the ELF sections for later lookup */
>  
> @@ -2415,7 +2425,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		if (!found_percpu && encoder->verbose)
>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>  
> -		if (btf_encoder__collect_symbols(encoder))
> +		if (elf_functions__collect(&encoder->functions))
>  			goto out_delete;
>  
>  		if (encoder->verbose)
> @@ -2456,7 +2466,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  
>  	for (i = 0; i < encoder->functions.cnt; i++)
>  		btf_encoder__delete_func(&encoder->functions.entries[i]);
> -	encoder->functions.allocated = encoder->functions.cnt = 0;
> +	encoder->functions.cnt = 0;
>  	free(encoder->functions.entries);
>  	encoder->functions.entries = NULL;
>  

