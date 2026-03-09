Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0272D061B
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069568; cv=fail; b=fVTsUe6XIN1EjinNrdRbeMPzkwkG3nCTI1jFHMfpfIF5iV0a4B4Ek/e4M3h/v8F3SzBGk1k8oiSVdFjdzhmRFkAKVvGLWwIwQNqEFPEm43+jB24ED9H+E1Y4XaU2pPwGXbeuY1iOBNQG5Sh9AgSb7QhA7Q2Ldw6W2fNUrcg5opg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069568; c=relaxed/simple;
	bh=O2i31sQbxQGRYfXSAB8GMyYU3F2eyPTMMJAm8QlzyDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QdqptzdVj/LR0JytVcHSr3CaylorXA6LLA/RpG32hmB+5AL7sf3TvY4OXJy9SJAOTH0tvEEGBM/BJSA3slIZ9KpM5T5bPC8uy2k3Q69y7fN4Tcuuo1W4LXXyx+5CB5XHX2XGgymYqSu+5vU6AausaIcvhE02yxVeVMG+BrtRJBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MaPeypG1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oa9SOMgX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MaPeypG1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oa9SOMgX"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629Etq3K1358627;
	Mon, 9 Mar 2026 15:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yeCAFM8HvbH+M+LOezi38HvpDJtfYUVWZG1iZFutCCA=; b=
	MaPeypG1FHz7LWg4EzDHsD6HfYzHZTFLCVGKkheAAFs0TzrRU7laAiZ9tdVdhGq7
	ZSazmvjbiguI/qBoIhE4COuV7DAmcT1Jb6PMXQJGSzcRqNp4UBYYwdV9TVdLEJsj
	0av+wnb5aIzqc/j30Legc1i6/GrN8ITSNwRRpaE1+R+1LihMlPigYkSMtrF9xggr
	o8LByhkZQa3NPe9o1OUiK20Yl7Mn61F+K9QUOk3cpngs3ps70JQJKFT3V/ueWOIJ
	Tmg9TZni5k7ydIecnsHjlu7ZQK4iGEUVSTFdandj+CagR5zioWVloPbr707ihyKi
	BMYC/Hgp+4Ia/NZ6dTofvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmma93nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 15:19:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 629EqkUR007955;
	Mon, 9 Mar 2026 15:19:22 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf8t2u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 15:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sz8ZeoNvRQXSRsK3uAIKyhL9/gYEiNpCITpNM7IhLGWxxAloTtj8FWPxr552ghLfOIbsTZzc2HoczvM9i0wPoALD724fnXmaYGl9atrAFT1s7tH+gXcT5PhcJbTT3PyKQmVwVUTghrDwhHDTerAJgVbIpC7sM1n62n+ApO2BO+nF94yezywx1apHXzRtWE9q5GCZDRzaD5xGDu7MT3kMTKQ8c6jayqv+5qtYbh6rzvhm2fYlgRbAKa27pXOT85jyqar0f88GE0K8V0+gWcTLQllfF6iDh1WoNQRynEnGI8sNeY7UTNtFOvVi+U3AEwOVKzIjdzxF9bs+lmGibfXQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeCAFM8HvbH+M+LOezi38HvpDJtfYUVWZG1iZFutCCA=;
 b=tqEk9frUluw7NJ3KYcJ3bq5WJzqLGK/UIeGEjiUTjZprbf5IOJjjQqhqaATXGMN13G+u3dy5f1ByyAP3oy0Vd7oDRxaxmjJ2LQxkKaopDjtMg8Jwe1jBA9ZjJCgCJhJNsay3hib/CQsAgUOWCBGUyCBKPzs5mygoDh//uKB/A5MzpAXElahl5e0ye+N8RFRUwv0QjAHH8i0gTmqLErdwkF0i6xkESapluxhzZCcQsgBm3Wskb30ieeBegHbivTRVbvEan6F15rdA94QUVrnalqCAi/ivfpxBpz8VrikPXEtWRlMgLJXn++kWyn/nmqanguFC4HEICvLDBH2xAl8eXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeCAFM8HvbH+M+LOezi38HvpDJtfYUVWZG1iZFutCCA=;
 b=oa9SOMgXg5M1IhaDJnGUxfTcvhcf5okzMT3ZZopHdfo5zGMmtnYP28OpdhPIOXFEIOhGVydVE0Fu9Aq6g/ybSuY6aOc6T2wQrRCo7Zt4Si8i0vzWNVyZHWrY6iOvy00j4FwssSCb3NDXEaKxBF8znn30RLHi1RMFfi3m//AHKtA=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB5869.namprd10.prod.outlook.com (2603:10b6:510:14b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.20; Mon, 9 Mar 2026 15:19:17 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 15:19:17 +0000
Message-ID: <b43d65f8-e6ad-4f21-997a-8de802523a6f@oracle.com>
Date: Mon, 9 Mar 2026 15:19:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pahole: fix discarded-qualifiers for strchr/strstr
To: damien hourtoulle <damien.hourtoulle@gmail.com>, acme@redhat.com
Cc: dwarves@vger.kernel.org
References: <CALi0rFv2a-AjG2vaMV83yg2mDKeU1x6=tRJjWhw+DZd4w=AFsw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CALi0rFv2a-AjG2vaMV83yg2mDKeU1x6=tRJjWhw+DZd4w=AFsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e59e045-4011-4c0b-43fa-08de7def3a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	M3h45koXSX/yzV3avO6II8d6Bu6cGn7rsczM7NpHAkUUXbjOwkxf0+Qg3xiv1DlftBBTxE46U0Ilxv3JzxHrznmE5D8mNFRbpzcW5Zho6J9I6ZLO1bVmMgaX7Vt4SqoNZFFiGwsnmItva688z8YExcb4aQYnyd1F/DThp/GO77vOP4pbkQNswiL90ILqXy7Bp31l/jT/4VCXKVEQxaNowlcKdbHnWcUJhwerR2dPzjUkRvk6nx8AWafc7wsdlrDsvZke3cHafrbwh2LVV7dJTl66QoQVwD7P7BnyW0xjIPxnzewHjvVDjgpQPR2YaVIyGhTdQM5kW2K+FM72vliqhxnYP9McUh3H4VUPTOSxEkFSqcr2VJY9DNUI4S2XVQYjgsl50pkJxkqzcOj9b+UJaAPbZv9k1hhE8T8ElSBuFbrgcYGNO5WiPpHmvgP3xLbBi3dqA19ZISNMjyO6cBKta5bB9Pxb9oTTcnp0+Z98vf2bVqHgKzQtl1RgyQ3ftig/I4kPjTxMOidsisZ8b/cYQ7J751sdCchJNT5aDnFlQKyAApiQe4iNod+Lkay6jUu5pFOBnK+Mddv0NvRYMV3rZs9Dgw1zbXHfgQPpmsmrtUl3cCBqrD6F/ZD7t00I0nH51O2iwG+vcbT+Rb2wGTx9ZnlJQ7t9BjwNxgLyRtLZHh/DA3/ei1V5GR5Lwk1sqoS06/CBvhAkUqZjTmwMzYhiVMu0aJY4bEyHoPR6Cy7gtDE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjM2RHdnSkxpMllBWndjZ2hiVkc3clNBR2NqSm44SGNvSVkyR2ZYYStpQVdv?=
 =?utf-8?B?dTFJV09OdEdDTjliL1RnTnBHdXVLU2dUTWtwWUZEYk56azN5ZkdaS0FzWWVk?=
 =?utf-8?B?QWdabmdwcFdkZWZ5bVQ5ZzA1NVV0bFhZOWF3cDdnYTFlNERCMk1hdXUwNUo4?=
 =?utf-8?B?NWNzTllmbERjYWVhWFZTcWdzc1RJRFBCZjA0NVZMT0lHMlI5bFN0clNGMVNJ?=
 =?utf-8?B?bVJpYUsrY1JOQnhYNmhJSHhHdHlsOEtLMGkyc1I2UFJuSC9IdHZ4RHh4MzZa?=
 =?utf-8?B?a200emlHMTkvemJvbHVsaUlzRjNFVC9SSEhudE5jVnpzK1BSUjNFVVBzMC9E?=
 =?utf-8?B?Qm53ZFc2Wno0ZWcybW5HUVVOKzBNdnMvNkhsckY0TG1pT1o3a051TnBWVHNH?=
 =?utf-8?B?MkFqN0g0d2wvYUxrQmVya0Fuc1QzcXhGb3EvWkIwd3FVYytoQTRENzh5ZHBO?=
 =?utf-8?B?VTdTRnFYa3UxYnRlVzl6eGJiemxmanoxc1hNSVVYRWdLeXU2NlBkeDhucVM5?=
 =?utf-8?B?TFVrbE96Vk9iS3p0Q1hLdE5ZWnZJYXhzNVJWNzcwSWFQRXR4bXBVeHNZa083?=
 =?utf-8?B?dGhvRDA0MnFicDV3VXo4S2oxWDNCVUFpS0xjU1JCT3RNQm10SFl1cktYbDZS?=
 =?utf-8?B?ZklEV3VxYW9VVUFpZ3ZCV1lGOTI4Y1crZFdydjRxNGhjMGNha1d2c3liUGoz?=
 =?utf-8?B?c05tbS9XMk1GTXRCZ29sREJ2R2lPS2grZnViTzVsRi9iOCtZVTBjYUh2UFE2?=
 =?utf-8?B?K2dnNWhhYkZoV0xzK2NlSkp4OVByU2htc2pScHN2T3IxMVlISVhpSWZkbFlW?=
 =?utf-8?B?NU8ybnpvRWoweE9tTWx3VTk0RXZTcjdwaC9iMzVVUHM3T0MrZ1Z1aGdpYlFV?=
 =?utf-8?B?T3I1S3Jld2YyRElGL3NWdGtXL2NRajRtcEpQRjFvK3BhQTVSOTl4c2k0Ty9N?=
 =?utf-8?B?dWtEekN4azVkN2FHMENDY3p0U3hqSnVka3l0OFdiWUI4aHUrcG56cnhuY3Uv?=
 =?utf-8?B?aTcxbkpUMDBEVFprWjlPMWlCZVJzUWRRSURLNVJKZ0NZeFQwRyt1Q096WkNu?=
 =?utf-8?B?cWVaNnVwOHZJQlg3ZEFiaEY1bG5RN3NMVWRmSURlTGhTTWZ1cWdxYTJ4aEVm?=
 =?utf-8?B?eW5mMzJHdTVIa293VytpYUVBYlp3VHphencrZFdhOVZPbldnaHJ6QmhvOGNK?=
 =?utf-8?B?SE9xMXQrVXZwOWhzTDF4NzI3b2JjdG5YN1VxcFB4Ym9lM1V6UjdadC9WODV6?=
 =?utf-8?B?UjJwTXNrRlAyNkFTOXQyNEtuWEcwSWZVcEVnbC9KUElYZFY2QmVvcjFFSXd2?=
 =?utf-8?B?WUdBY1U5UXMzbVA0ODhQQmNuZ0g2ZlcwWVZ1dDFNN1lmTFlvdVVKT3dCeHVk?=
 =?utf-8?B?em1JczhpQXkrMTE1dFdlMUFYclZRRXpqVEpvUlhJV2x0TEhzMmdmeWl2Ynow?=
 =?utf-8?B?OUpQSk5Ia0VvR2NDdUVMLzlhU2FVa3ZNV1JxOGEzTHppMlI5U0d5TnN0UjF1?=
 =?utf-8?B?MEdtdm9CRXlYT0xObllOME9JeVkrUXJNUXFSREJYZTIwUnY4bE5sQVFxaVFH?=
 =?utf-8?B?S3RkMjZVaXJnL012MTM5ZVp6aFZKSDBwUHZPcHllbHhLOWxpKzNTaTNVZG91?=
 =?utf-8?B?NXhMc0JCVU9BV25RTDEyeHpWU3hRR0NIMWl5TTg5OTNHUThKMkdQc1IzY1RY?=
 =?utf-8?B?N0pNT3gwVExkeXZWZ3FTZDRxTnlBQXNSeklIV1RQdk03VzVyNVcyT1lYQ2Zr?=
 =?utf-8?B?eTdyMUMvb3YwVVdNSU8rQWJFcDNHSWxDbFo2a0NqdmNpQUZNQlptTlh5TUdQ?=
 =?utf-8?B?a1FZbGg5QW5hMDF4QlFqbkx2eHNiNjJUTGxjaWtvbkxQR0wzUUloUDJZdHR4?=
 =?utf-8?B?YmlQZW5JWS90OXBBT2Q2c1RZR2laRTlRKzZhWlRadDFmRVUzcFhiTXJEQ2lz?=
 =?utf-8?B?TUZnT21hTlpDOUlPMUpXUlVXcmZMUFhZRUY4ejA1a041Q3ZjblhkaGw5RXpq?=
 =?utf-8?B?a3VKWC9mdG5IdDVUU1NWUUVsQ0xibTFjMFBWZ2ZXS2dCMzhjbW8wZnFQa0tE?=
 =?utf-8?B?MmRZK2IzOTRjNzFKckVNTjZNY2ErVnpLK3k1aTZpdXI3SU1MZ2VRa2czdkZp?=
 =?utf-8?B?a2VSZnMveUk1OERhQ0hHcklsY1ovdnM3QUIrelhQSWFUMnViTW8yM2gzaW1H?=
 =?utf-8?B?T0xZdmduNnAxMFpNcXo5UmJrbHZPRFJMaWFNYThkOEdxRE5aT29NbHlqeFZF?=
 =?utf-8?B?SXNJbnRzYndhWFNrSnhVK3N1cWt0Y3B6Z0Vxdk8vdlhKdVVqU25sZHFOKzhO?=
 =?utf-8?B?VWNDMTl4NWFseTlPVXVRcnQrSmZ0ckxRcVBzRU1STVZqY3kwdG4yUT09?=
X-Exchange-RoutingPolicyChecked:
	XGaYq4UJwcwatCEkotD95EKGp9jm8+7z50jjxz0omkw4io2dYJAZQkTbOa/qQYSmxTLwkiWgXLsIxE3CqmWxZi/BpNkt6RKY+l8wskzn3VyLnDzacN+3T6lO3Lv+K2G8+hDNs3Pkxd6XRG2JilPDzTnLS/lCCLyINY+22+HW62iWD39bXd8OO/zdPhc4dWFfoBC0+jwHpIR30MmEhvn8x5yRM2uLRbjUtvv+b6ln2hFgLq25HmtyRoc4iH/T8YjGSltfB11XVPJZpal667QqTmYe9mlCImf7dPpqcDRUAvgGPUGkSPth5LEwp8IyEWw1prJ0qd1J6UqVGWtd8rDXkw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rTfWk/AzDfjurVHuQ26e9ZJUJ6cZZzuya/Gqw1UPe8IQDqnYfauRRR3GUOhuvtIYooR377tmpO592Jw22hVpCDVZ0jCajFMsZmpO6PA9gJGpnNQuygCclHaTSKoNCTu5k2zw9HM8ffhAdpAB+xJenNsxJs0mbEsHgEwUvs13glwwbxDigq+F8IhqiHcRVxObQVa/ynhPtBn05Mc9kT/9+wPjWVO/t+TL3o6UwDdcz9DTr/dMeV2okbjK8n6SuqB9LgRBhgtJA17DesN3I2fXVyxBjkfLr1FzPIRJEzsKGKArtkBvTGDMUAd4dOdf5OtsnbE8b/SAVlWNBUVhTSlAF5kxMNYccwN+zONN2mIBB3XhUHddnIh69m5NT9fz2FlfeA/IvWUhPvXn/Ur0w+EJc0oY921faqMfRQFFGytffX1XlsMnCEx27YWqp9PCbA1Eo7ksHAIVtk/iV1nOx922bYe3W8XVtIPKGOH4YsMIigMfdWLAz4wNbj9zQie3WVWKBUjeePSfTj8vB7KFSBX0f092uF36TbrvoPNRgsX+PPQwtqsMdhZGkOZ82mFCNmZIpmx1go4OqUlXYQ1EDmgWacOrGSg1pKWDJA+25qyOM9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e59e045-4011-4c0b-43fa-08de7def3a81
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 15:19:16.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YD6hukqd2supyawlUQFoEF73i1jFGM2b4qQn11qsIthG7rH4HQ2BO0asR2nOIAj4G+M3Is51B46V22oJz5sCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090138
X-Proofpoint-GUID: Mtphb7Aq1caqUKBDbzao2agOC-TFytzv
X-Proofpoint-ORIG-GUID: Mtphb7Aq1caqUKBDbzao2agOC-TFytzv
X-Authority-Analysis: v=2.4 cv=U5efzOru c=1 sm=1 tr=0 ts=69aee4fb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=CCpqsmhAAAAA:8
 a=pGLkceISAAAA:8 a=CDVGjZOeyIou98oqDdkA:9 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzOCBTYWx0ZWRfX7R52hFDATAKQ
 u3ahYzfWvr+9Jj3cvwHqcSMLCp8+4z0DwkWYFQf9k76ZWEY8C0pVjk4W3iqmJ8L95vjCs6Q7b8t
 KexIuW8tA7FAsCFOpNza/BKiR2f84DDR299DLGruwxTGNK7sBNupkD8w9XS1qRlYXHHST3p5V0H
 94tT6mKKzioVJVqCfJhceSjZs9MGIlHg00OYMBKd8UWaRulXNPuFJlkjOnJ0AwranqdQZByE7Bl
 8RUtSJ8hASQ5wRncR2n7LWibMm+ikIc3ZR9YW/aEzDZZLxgd4RAR9vQVkoQrxzlLAcWLFU5gIdK
 GOynRtJ/c+9H4i7PTFNpLry2pXx6pG/oYNKDLDZKI2Vvy6s2w9BwmMeUgmRYeQvOmYxVy7BEftp
 KqpN4zL+rLzAa7Ft9YEWGcJOMVSn/QjzY5ksoBHazRi2wtNHue/+K4LxJcbHmU0X6Uua1I8pHi+
 5rJM8/4cpaZC5Tuw9Sw==

On 04/03/2026 03:06, damien hourtoulle wrote:
> From fa4866e368f5131ddcf6fddccc13203fab88d00d Mon Sep 17 00:00:00 2001
> From: Damien Hourtoulle <damien.hourtoulle@gmail.com>
> Date: Wed, 4 Mar 2026 03:30:31 +0100
> Subject: [PATCH] pahole: fix discarded-qualifiers for strchr/strstr.
> 
> Glibc 2.43 added C23 const-preserving overloads :
> https://sourceware.org/glibc/wiki/Release/2.43.
> 
> For the function prototype__new, fix local variable declaration to use
> the correct const char* type instead of char*, removing the need to
> discard
> the const qualifier.
> 
> Signed-off-by: Damien Hourtoulle <damien.hourtoulle@gmail.com>

hi, there are a few issues below I think..

> ---
>  btf_encoder.c |  2 +-
>  pahole.c      | 19 +++++++++----------
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index aa7cd1c..d36984a 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1218,7 +1218,7 @@ static bool str_contains_non_fn_suffix(const char *str) {
>                 ".cold",
>                 ".part"
>         };
> -       char *suffix = strchr(str, '.');
> +       const char *suffix = strchr(str, '.');
>         int i;
> 
>         if (!suffix)
> diff --git a/pahole.c b/pahole.c
> index 02a0d19..4184703 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2483,7 +2483,7 @@ static int64_t type_instance__int_value(struct
> type_instance *instance, const ch
>         int byte_offset = 0;
> 
>         if (!member) {
> -               char *sep = strchr(member_name_orig, '.');
> +               const char *sep = strchr(member_name_orig, '.');
> 
>                 if (!sep)
>                         return -1;
> @@ -2496,8 +2496,8 @@ static int64_t type_instance__int_value(struct
> type_instance *instance, const ch
>                 char *member_name = member_name_alloc;
>                 struct type *type = instance->type;
> 
> -               sep = member_name_alloc + (sep - member_name_orig);
> -               *sep = 0;
> +               char *sep_mutable = member_name_alloc + (sep -
> member_name_orig);  // sep mutable for the copy
> +               *sep_mutable = 0;
> 
>                 while (1) {
>                         member = type__find_member_by_name(type, member_name);
> @@ -2510,7 +2510,7 @@ out_free_member_name:
>                         type = tag__type(cu__type(cu, member->tag.type));
>                         if (type == NULL)
>                                 goto out_free_member_name;
> -                       member_name = sep + 1;
> +                       member_name = sep_mutable + 1;
>                         sep = strchr(member_name, '.');

I think this should be

sep_mutable = strchr(member_name, '.');


>                         if (!sep)
>                                 break;
> @@ -2950,7 +2950,7 @@ static struct prototype *prototype__new(const
> char *expression)
> 
>         strcpy(prototype->name, expression);
> 
> -       const char *name = prototype->name;
> +       char *name = prototype->name;
> 
>         prototype->nr_args = 0;
> 
> @@ -2964,10 +2964,9 @@ static struct prototype *prototype__new(const
> char *expression)
>         if (args_close == NULL)
>                 goto out_no_closing_parens;
> 
> +       *args_open++ = *args_close = '\0';
>         char *args = args_open;
> 
> -       *args++ = *args_close = '\0';
> -
>         while (isspace(*args))
>                 ++args;
> 
> @@ -3114,7 +3113,7 @@ static int type__find_type_enum(struct type
> *type, struct cu *cu, const char *ty
>                 return type__add_type_enum(type, te, cu);
> 
>         // Now look at a 'virtual enum', i.e. the concatenation of
> multiple enums
> -       char *sep = strchr(type_enum, '+');
> +       const char *sep = strchr(type_enum, '+');
> 
>         if (!sep)
>                 return -1;
> @@ -3126,10 +3125,10 @@ static int type__find_type_enum(struct type
> *type, struct cu *cu, const char *ty
> 
>         int ret = -1;
> 
> -       sep = type_enums + (sep - type_enum);
> +       char *sep_mutable = type_enums + (sep - type_enum);
> 
>         type_enum = type_enums;
> -       *sep = '\0';
> +       *sep_mutable = '\0';
> 
>         while (1) {
>                 te = cu__find_enumeration_by_name(cu, type_enum, NULL);


there's a similar issue in the loop here not visible in patch diffs I think;
the loop now updates sep whereas it should update sep_mutable.
