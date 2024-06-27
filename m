Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90819A2BD
	for <dwarves@vger.kernel.org>; Thu, 27 Jun 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509198; cv=fail; b=NeZvgR5r9BLE6MGTH/hoMldsIIu5Pi3fgJ8qSIOUYqBeceepySjaMynDybRqIO+2Q/IGuZuCvs+hu66WmoGL6uszxuBtKPektROK+lJeBSmeu/+qSnvJUsJf+cUCGwPvi7MRpdfbLUNa14jaxWOAwYMADWCAOxqwFzWPR47bYQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509198; c=relaxed/simple;
	bh=HPl703V385u43U5wAYhVNZzrixOZJTepZ6I3PUScLYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BI8Sv/BCOukmhyuZMZT5AcElnFcdtUNNesTMo+gD2BxLvqve0apbEDlVZ8/r97SLy7KPuDaGhfI5Uars3OSdsie18Tlk6J+LjOnaq+4WxsO4WzBgSxp+hGAQOfZc3qv5NJgpi7sNXYhYFfobPCHIuXBpFshCr2lFLmoUfYrfYMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=boYQMeOD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v0r4nj5p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="boYQMeOD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v0r4nj5p"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtVcK018022;
	Thu, 27 Jun 2024 17:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=bnDn/NRl0LERoHAIQj/sRnmKzB3ztFeCk/ZAZlnk1DI=; b=
	boYQMeODe+o0a8TV/CHEYLqaqHHelVtLU2SnWdQZIthRexi30fgviWatQj40mr4B
	DR0fykiVgtNF0hL0+rIJPnPlge5UAzks6Wn9wnQ85ocp/G+Kc46jRF5WnYv5QhSl
	zbGam/kMvd9fWt3Bl/fzI+XphvkeF2JLs5YWUNbmfc0Buza6OeSLykYzOXunx4e/
	fhK3XNeEq6WMGmmU494wNKfdczpVbOlK5PkgCTllehsvi2SaOhbuHADTTTb8nbHP
	xTCS7mZ/+doQXpfsFqP5p0KaQLBxOOfwnh3d5yH2V8xeCaWQ9/cBPWTuA8pSaLbY
	vduttpRau3yGCXrIWJ1CYQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn70ekfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:26:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RGPhLX017804;
	Thu, 27 Jun 2024 17:26:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2anabb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:26:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jC1vAdtEWj8vcdbFN5hkCwN3jfFqRGUZStxzNpRYcP5O/kbvN4J8Td/FQrwavcIxZVE/0LVLTcfzWbKmKMWsU8OPM9Fjb/f9+CNh302MIxVGJE9LUAOy5Ymeho4+gPtcGFXHu0lNSUE5OzqiYSjk/k9cGMzNCDsBKiy5cw7aRKq6CSBJpSy5Mj+owGJtk15ERJZOd7tX/dxAHETJsjk8tSiYc7g6f5ZnZtQnAebwcQjMMYnhaw2TORu+p0M/3ljbytbi82jv3CSjCPxXe3vYy5Z2x+l1Nhkoe79NsJGrcqx11bxDSc1OTzfiIyC1leDAJp/GPNiU3XcfudmN/mGKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnDn/NRl0LERoHAIQj/sRnmKzB3ztFeCk/ZAZlnk1DI=;
 b=bpxlAd9XofbLNXhJ/XdPyL6mEHweagadPLanUAzO9mVlxzpMgTHyjOH49OXq9/sgoLOkp5Mv/E3hPxKmWxAG9Ye1U4jzZEOBe9ergJrs4spI2imJPYIKmYoKFQb5ICp9SVr6cRFMUiVdsb8KmY4TreJCft/U+5OD/4nW8hSJI6XHbB31YChrFIBCSpMiiEKIeqbUSyydJxd97JUHgzYiKVvvk0Edg1HQrwPJOLauQxS/YKBNMwTK4sA1yG9U/lIS3bMthkUnvHiBLS8XkN4CspQHNebIfdL48fbsjLX4KKBc+9o+ILTQbPaLbTAvQoNvwCXOMGPw7YEQNdTj1ny6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnDn/NRl0LERoHAIQj/sRnmKzB3ztFeCk/ZAZlnk1DI=;
 b=v0r4nj5p231kpHTamyyk+DhO4B8WF8fpehcjOTeMpXHfp1uEZuruRfuuGL5bUySustN2YHAGirz5t/Q+wqufVtAJZW1uFjClDdrvifGOs5Njx3byOI9OBhmNOnSp3IU80vYG26xzHpX6UFqUKqLg7yx5UeXjtOVpnLgKa/ONdDA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4442.namprd10.prod.outlook.com (2603:10b6:806:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 17:25:57 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 17:25:57 +0000
Message-ID: <fc0bff28-eb41-401b-95d4-49fd4b72e5c7@oracle.com>
Date: Thu, 27 Jun 2024 18:25:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, dwarves@vger.kernel.org,
        jolsa@kernel.org, williams@redhat.com, kcarcia@redhat.com,
        dxu@dxuuu.xyz, eddyz87@gmail.com
References: <20240626032253.3406460-1-asmadeus@codewreck.org>
 <c1414fb5-f7a8-4cb4-9c27-9c0c9b431f28@oracle.com>
 <ZnydwHhgCbUbkm44@codewreck.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZnydwHhgCbUbkm44@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0494.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: f60998f4-6431-469d-639e-08dc96ce34ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWlQd0JpUVJZMTRTMWFPbTE5eWhIU2JZaUl6K2NIR09iL3Z4OTdjRVl5c3Vh?=
 =?utf-8?B?NmZ6WHNna1F5NzBqc1hTbEl0VWhKTDFuZGtBeThxakVVL1BIc3VSemgrMjdZ?=
 =?utf-8?B?RVZDZjcweUdSaG1IVU9xeHgvdFVrN0hVTFJpb05QTFBkQjlYLzNyN3ZSVGRm?=
 =?utf-8?B?b2poejBKYythcUJYM3NVdlFrc2JtSU02QlRyRmt6U0wwU1pKNVU3VWF3QlFl?=
 =?utf-8?B?VUNnbFZiREs1ckp1QlAyWlpFMVo3dkJqYVRyVnJWMUNNSjk2dXVBc00vb1dr?=
 =?utf-8?B?TmFWQ2pNRm9jdEQ3ZGduNkNBSnR2Skw3SVdhc3o4Y0hmc0R1aktRNFRkTWpD?=
 =?utf-8?B?V0tsWFVHdERDNityQjVtdEtHMVVzS2EzOG01SGJrbjY0V2M0NjZzUVFWNXNh?=
 =?utf-8?B?bUtXV1hNSkhqU3RxRm1xVUliT1VFR3U1bDlmTE03TnhIc3VRY0phVGx4ZkJn?=
 =?utf-8?B?RHl1U01PZThaV1hsTDhNbmRGNzAzMFdmaVVMTXp6cjNuWm8yTEQzNEJQVnhq?=
 =?utf-8?B?ZjQwWDlZVFpHYi9Kclgwa0lzK0FxSUNiMDFiYVJBMDJUbk1uOFgzNGdXSmIy?=
 =?utf-8?B?WnQ4K1VrUktCanZSNFdHU1JTU2c0RmliWkk5Ymt4KzlGM0w3REpHMGtXOU1C?=
 =?utf-8?B?Yk12S1pYa2x6T0ZEMFpleDIwQnVTQkJEK3ZkR3dYNUZpMjd6ekpEMG1seEJX?=
 =?utf-8?B?dGhXd09hZ3FwOUJ1UTVHdUlhSURENkdsVS9OM1dTZ3AyOUVDUnl5Z2FzNEhS?=
 =?utf-8?B?dkNueStyRWtrYi9TRllFMHVud2FyZlYvRlNXeVBaLzVoaVYxMnNRb3hib1Ir?=
 =?utf-8?B?S3pIN0daTzRXMkxOK0NGWkV1c2ZWMUd1cmhnYUlSZVVhV2lSOCtmVG5ZcXlD?=
 =?utf-8?B?b1FMWlJQV3NpbnpNTVpEK05HQk9ETHo0b1pZaEhidG5xbVJnQXB4TXN1dnI5?=
 =?utf-8?B?aTdSME9KQjV4ejIyeXRkYmRXK1pnL1JTOEttbGVvNk1WWDB3T1NYUy9xSElO?=
 =?utf-8?B?Y25lWU04M1dqbGdQRXE5UUhvRW1jQW84YzJLeFg5c3pNZGJjSWUrKzZmajRq?=
 =?utf-8?B?OUVqcHZ6ZXE4Q3g4M2JZV2k3UXA1Sm1td3k2azBrbmJ5QXltV0pTaWFFbTdC?=
 =?utf-8?B?ZGNBOGw0N1hnV21JSGVVUUk1TVIzaDdRY2VtTmNTb2NqaDRjUlloM0VyWXBR?=
 =?utf-8?B?aFZuY0NQOVM5eFFSRzR3M3hlQVgwczh1UzdRZGJOaGFYREFWTGhNNkUvcmkw?=
 =?utf-8?B?Yi9TL3lZcm5pM1U2QTZWcHNUSmo1QjlCTkZTWEVYbjFTRGJIbTN6QjJKelRu?=
 =?utf-8?B?VzlsOXBPNXFMdHg2M0JyY0pieWx3L0trRXV3eXN5RTFVSGwrWU9TNVNiSXBz?=
 =?utf-8?B?cmpwYkozM3B3NmlXajBTbmtNUXdZbEprYjYvZXRxaU1jNElrZ01kbml3dW54?=
 =?utf-8?B?R0o5T2w4eUVuTkoyVG1xV1RvS05VTmZRaGVaQzVTZU1HcG9Nb05WUUtlMkFy?=
 =?utf-8?B?MmFCeVpZdnlzODdEMDM2V1BmUW1hUTk3QVBJaU1sM2NIYzVCM1dxaXFtNlNK?=
 =?utf-8?B?SXViYXdoT29tOXJHTEloRFpkODRRdUduS3IvWndDeGlFZGwwSWI1Q0hXRi9N?=
 =?utf-8?B?Z2Z3alJ6UUFVVytCbEZ0RTl3b1RWUHhjQ0w3NnF6NXFKN1RwajFkZEtvYTht?=
 =?utf-8?B?R2VqQlNvT2tIRGJTekhSUk4zbEZnUUJKVWVETGhmVlNwb21aVXQ3Nlg1K1A4?=
 =?utf-8?Q?+nlaTqgerlNbgcAqM0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z2lpSFdlcTkvTE5FRDZ5bFdOZ1lYbDMxcHQ3ZjJlRGx5UVlYRW1OQlBQUmlS?=
 =?utf-8?B?V1plNWY0YUt1RkQ0RG1WaXJpMzBESzEvcG5PNG92K0N2SUtIK3hxYWx5cUNO?=
 =?utf-8?B?SFBkRm1JNkpUbU5lbHhBVFRmZkwrSFEvRWwvOHBQSGl0MGJNUmVnbHE4WGxi?=
 =?utf-8?B?VENxQWlVUEZIcTl4b2IvRTJ4dE9VL2JyUUY4SUYyK1FaVDZTV1Bkc0ZpUDdL?=
 =?utf-8?B?ZDJoaEdIL2oyRHBEc2dvajBPTThJQWZBOWc5TjJmWVlNN0xXMlRZaVVPRmFn?=
 =?utf-8?B?Tzd6M2FjMVVZSEh2WkNONEpGV3hnbllOOEZLb1g2MnV0SDllK25PaDB5dVds?=
 =?utf-8?B?UU0zbHF6ZjhvZmdwODJRc2xwNGg5RWZUdTRaZVVtSjNLb2pVUDNVUUJsUkFn?=
 =?utf-8?B?NTBJVExwMXNLVkltRVJwM25ibUo1Wi91RlFkMlUzdy9DbXZwVm1sVjhIVkpr?=
 =?utf-8?B?allMYk15Q3pmTHBFOXZ2dUpUR0VxZDdkS25EaDcwMXpCTDl1RXpKQ2FBa0lh?=
 =?utf-8?B?UGJmWHY3TnJzQU1rOHVYRlp3cWZVSXR2UHREYm5vSFhPcG1CY2ltaHpVY3VO?=
 =?utf-8?B?VkdlUlk4dGF1alJlNWNLYzJuL1pSaCtzOEEwbTNoL2ZEZys2ZmF1SnN6TmE1?=
 =?utf-8?B?SUM3TjczY0tpVXVLdXEzUTNDNjNocGhHZkFIeFo2anZMSklnVzNmdi9aS3JK?=
 =?utf-8?B?Y1A4K29QMjFXWDNwcUFVTDNPekd1TUxXQ1dCQXZNSzR4RmNnbUExRXJJMzdQ?=
 =?utf-8?B?V1FoWDJkdm5YSWk2Rm53VHV3dlFId2Q1QzRJQSsvOU9UTHB5ZTJxVjJKQnVD?=
 =?utf-8?B?Uy9rZ1g2eWJRWExac0RTTU05Sk04R2RIb3NOUlYvSnAvLzk3V2FkUmRjYk43?=
 =?utf-8?B?d0J1V2E4Nm8yQTBucEx0dXVBa1RpbGhBWnJVZWp6dGRzUmdNUmVqcHFNdWRF?=
 =?utf-8?B?TkphTno3bURhY1RTWEY0WW9nek1iQW5ldlhHdHdOZFJRTmloaXduMW1sTEFK?=
 =?utf-8?B?S2RVbDJBR3dhMHdUcWxKTzY0T0tqdTVQNm9yR0wxZmU4MS9kdzUrN2FOTkd1?=
 =?utf-8?B?bFZUcVJSbUhjL1U4ZGZyOU1ON2NnQmRZREJxcVVObTBnTGdHOGFHeEZsSm5W?=
 =?utf-8?B?bzRobzd2bGxlekJtalYzYjFiaVA1VmxHcUc4WlNnTis5WnV6SXpCWjgxbHg5?=
 =?utf-8?B?ZXdQSjBxbTI3NitLRlA1cUNCVnVGRGp2aWZZWmpuK0wvYVdJMjZ6aEhsVDlU?=
 =?utf-8?B?aTBZVktFZXJpOHV4KzVWaVNsSUNNRUpmaGlpT3R5RFFnajFrZjQrcE5TWjk4?=
 =?utf-8?B?YitwTHZ1c3d1NnZBd1hkeWFnMnFIejAvSGhCNGF4UFNDdlpnR1Q2c3Nmc21S?=
 =?utf-8?B?cGNlTVJ0MHRnU1FkZmpNNFNiQzIrdVNkNVhrY2NhT2l0MTZZMTNYU29McFFX?=
 =?utf-8?B?WCtGWC9iZlY3QlNQTXdvWmFPWGlvTTVUSzZJU3pzRlNMMkNHU3hic3lnOFBN?=
 =?utf-8?B?WXJOeGhEVmtjK0JQajUybWl6clBjNFlTYTZWSTQ4V2lZL0xTT0ErblhaRTJJ?=
 =?utf-8?B?NmI3ajU4eDRoTU5VVDdSWXphcTZjT2xhWHZkc09hM0JOM2dnSFcweUc2Zy9p?=
 =?utf-8?B?NWZYVlFrSmdSUzV2eGcrdjdMVGtyd1Z4OWl5NktYTjNYVmhudGk0TnUvYURh?=
 =?utf-8?B?eXV2b0VHN3FIRFZXSHNNazg4MlFueEloWmhLNC81NFYzZHE4UDhXMnYwR3oy?=
 =?utf-8?B?TnloVGVpcUxOdzFZT1h3MENlRHEzSlRVT29vdnJQelJXS1BQYlY1T0NRWm1s?=
 =?utf-8?B?T2J6VFZMeTA4RWhZbFBuMGpBckJXaGJEN3ZUdWZTc1hZRXpmU1VwTmNpMDBh?=
 =?utf-8?B?MFdqMEQ4S2kxQkN0SFphSFJmUXF5WmgyYy9iZlVNeFQ5aHFJNmtZS1JUbHdY?=
 =?utf-8?B?WXF5dVVSVlY1UGJuS1UrN1VqSmNwWkZrbXc5amRNWVg3TFk2UitlN3NQemU5?=
 =?utf-8?B?cGl6SEw0eHd2dXNyYnE1VkVmbWdydTJYT204L2F0MExrTG9pRUpZTEtXZVUr?=
 =?utf-8?B?c2JvRGoyUGhsMmVPQWpzM01vb3VtM0dlUzNQSTlqUVo4ei9acFMyRHp5ZFdJ?=
 =?utf-8?B?RTY1ZUxldHB5M3ZUN3dtcnYyK1U5M011MU11L0h0SnBhTkhBMmhuM1QrZTY5?=
 =?utf-8?Q?nxQ24GT72cjxjwUtSGV5bv0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OHUqvdPOlsfyvr5T0jAXPzfw2OXbATAQiaJGZ0mfJ65dD433q4H1bDXT4CAKlGwUBExEk4oAA51TTcPOZpf56e20WDP0/dEM0Io6/TLADGYGR0DEIlYn8waPfFoKLx3sWmbrTnndM9nQfvmZEizhpoJzEmOy3sJkIHVIJ6GiblHdZJf6v+1wxvVhXpCNvIF0dJ50LrFrC19csNZs2Sci0UdAomjhLxSGjz53YnsO8l7wbsz+7LlqXWbWuQzr2ar3iLUsvh2EMZ2PYoP16VWjjQIMnqyjZJ7IHaRbzlGBD43MCA7rrL0+BBH3hbviNARdnCPu+ioN4nKT7wKgSqvgjV6hqa90c/KaO8O/T3aMgUP8Xo5iwLH3LBua9AL8Di+zc3yGUXRmX6EvW5g2NmQ3itTYIDDnfU9UXFmhxhphEnxhbxP1jLrCFH6H4I+ciGv+rsjQoSO/DMV8y7SNqazMOAQE3YKmhyOsUFsStsQxs5p/x1puRSlIS17V4Nz6W7YL3TLqez98pnejxa0uD9RqpgjutZuqSSBzHr1KB6oYCYMRJOEQ5yLvyppdYhFZJt4zHi8F3XLwT+v3Qyy6MLf63bPJF+mpqFB+Okg4i7s5U0I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60998f4-6431-469d-639e-08dc96ce34ca
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 17:25:57.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKSrV8DmKSQKOAtKl3miPsDrBenxUzIWXfx/Y7CHLUYUNHw1whgmz0N+El2uZx+eCCIAmmFbPEqZS2806OS+mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_13,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270132
X-Proofpoint-ORIG-GUID: w1lW4UHR1AFt8S9J1zTPKT7Y4sbH45L_
X-Proofpoint-GUID: w1lW4UHR1AFt8S9J1zTPKT7Y4sbH45L_

On 27/06/2024 00:01, Dominique Martinet wrote:
> Thanks for the reply!
> 
> Alan Maguire wrote on Wed, Jun 26, 2024 at 03:29:37PM +0100:
>> On 26/06/2024 04:22, Dominique Martinet wrote:
>>> The SOURCE_DATE_EPOCH environment variable is used in reproducible
>>> builds to set build timestamps and is generally synonymous with
>>> reproducible builds: instead of making users figure out how to pass
>>> pahole flags (e.g. explicitly setting PAHOLE_FLAGS in linux) just assume
>>> that the user wants a reproducible build if this variable is set.
>>
>> From the kernel perspective it looks like as a result of [1]
>> [1] https://patchwork.kernel.org/project/linux-kbuild/patch/1443741332.2730.75.camel@decadent.org.ukOB/
>> the setting of SOURCE_DATE_EPOCH will be converted into
>> KBUILD_BUILD_TIMESTAMP; I thought the plan was to add the
>> BTF feature flag explicitly if KBUILD_BUILD_TIMESTAMP was set?
> 
> Hmm, that patch (2015) never got in apparently?...
> And I don't see anythiing that'd make pahole output reproducible if
> either variables are set in the kernel either right now; we still build

I can send a patch for this to bpf-next if it's needed. But it'd be good
to figure out the right approach first, more below...

> plenty of older kernels so even if such a patch gets in I'd rather this
> is checked in pahole than kbuild.
>

I'm not sure that's the right answer though - there's a bunch of
existing infrastructure in the kernel tree that relies on
KBUILD_BUILD_TIMESTAMP, so to integrate properly with the existing
kbuild infrastructure around reproducible builds feels like the right
direction to me. It's a bit more work, but not too much. Arnaldo may
disagree of course, and he's the maintainer so it's his decision - this
is just my personal take.

We've tried to explicitly enable flags in pahole Makefile.btf so that
it's obvious from pahole invocations which features are wanted, and to
get that support on older kernels it would just be a matter of
backporting the

if > 1.26
	use --btf_features

...patch, and a patch for adding the reproducible build option to stable
kernels. Similar has been done in the past for other pahole features.

All that's needed here for bpf-next tree is I think is the below 3-line
addition:

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index b75f09f3f424..40bb72662967 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -21,6 +21,10 @@ else
 # Switch to using --btf_features for v1.26 and later.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j
--btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs

+ifneq ($(KBUILD_BUILD_TIMESTAMP),)
+pahole-flags-$(call test-ge, $(pahole-ver), 126) +=
--btf_features=reproducible_build
+endif
+
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=
--btf_features=distilled_base
 endif


Can you test at your end if that does the right thing? Thanks!

Alan
