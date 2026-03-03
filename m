Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD36397685
	for <dwarves@vger.kernel.org>; Tue,  3 Mar 2026 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566582; cv=fail; b=PAphSeYYFAomb6juZPNtM8x9D5P/VoQcxfx48t/RZYcJRXQuiPsIy93LYimTx0Fo/r5lV/iZrNxEfhz7u63iLmvhOst90iw97D7hX3bzMEeHu2tt0A9lOGtgXiuBukHlhgoYZayy33OFOEf4QY0+LGrdLmd7fEaDJ5lrXB+A9hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566582; c=relaxed/simple;
	bh=wkmUrg6upmGq+P4NBM92SmxwZv6QLOF7jZvYBcnUiFI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GdXG5+etZJMdC6hb6tqIhgRxlAsvBjKsWeHE0n3io46OLIACETnl1xJFidjFqRJ+wVpknp02/qYH77kCe0eFdb7iDyuNUKVuIFsvv8sJ6LA/LZOWZofi/DwLS1p+5gkPH0uz43TruIU0fvVDJUOFbKPsBslYCo2TLfCb7OuJSmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nvyIrzSX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O5hoAUO4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nvyIrzSX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O5hoAUO4"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623HmFKC929436
	for <dwarves@vger.kernel.org>; Tue, 3 Mar 2026 19:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Va1M00+X7SIQNbw4DFyStEtrMwcaoWwqL8CaseFVEho=; b=
	nvyIrzSXLWiTS6f31dm1Dcx7UH3FLFZ+l+0dQJB0cULketwGrBCiGL/6zgGqqECk
	2Pl5AkS/b9A90SFwd4YEhBpEmThbsxlGrNS9SRB29jchuZ5oQ07RLvikTMv8e/O3
	RbMUDVtA5h0cHIS88ZJm5ImV8sTr70yHfjoyQ9UVM69+AWk0FqXvBd1EsKi32Sc9
	EUQ9p0OGsEwdZlWGOIjNPcrp+JW59kE0B2sxk9eJLkE4Smp74C87fry2wWLXhSPf
	5NcDuCjR/4VbkIluaawJXoCG9lubyrPq25vdfAe0Wt7iH3EIIUSnnDQI/DaqmdF/
	dqFeTKaHOKYO1UuA2sJbUw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp4c386r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 03 Mar 2026 19:36:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623IYfkj037837
	for <dwarves@vger.kernel.org>; Tue, 3 Mar 2026 19:36:18 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptf2rbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 03 Mar 2026 19:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xx/xvnk8EDofTcp+SODd98udmjZOw4sSED/weE9fXIISp2M9Y2bA2tNQxpdWss7R9bHIOaQkIJs8+Dx9N8+yKUsG+5MWnPYLYfef6TLTAF5Jk5bCFiRgZo0txKLCUN+6HTFiXN5u2tmXwAEilzfCErUbnmZLKkeNX83ufhi/6fHDHD4eSmHTtyYjUXpRMRR4s4IwuH+YQLxdJ3D+fXUfbuIg+JWAPLaX2Jiv/pHdVvDfTpmkk1xi7W8kQhEOEoGsfOV1o74eL+tbEtxQtini04xWt34G8TIGDqEt3faSBuGodNyrcRdGPOtZEDpavwu8jRfr0jg9hRNBFNAQon/V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va1M00+X7SIQNbw4DFyStEtrMwcaoWwqL8CaseFVEho=;
 b=oFBDOAnu5HAEq0+cBFdQJV2luBEuc7POi7lSa8IahGhU+Yr9ke66RlpMGlkLg68fuS01AxNcBnvVCjW/wwXQIgNCA5Rubk56fuCgwh3RTGNOGLoIYXBTnPLWX0DlxhM+9S9hFu3UftLwN/YtGLlolnjmgjleyfQc0rVm8W4WG4P0podF74TWT4r72qt8SWNo/gBjLev8EH3Ej9ATK9Q9hGZsJvSPbbqrqQTmVOZgHYSm6A9VaMOPHMJlkKj7AUj51Ob7/ISNelGhZGQvQ3eudOQptHk7fBKzU2lq9RZtGAiDG22iDxxE4QwkO4MtUnasStHIuqpnNc10bdNfUa1XNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va1M00+X7SIQNbw4DFyStEtrMwcaoWwqL8CaseFVEho=;
 b=O5hoAUO4+YkzuCsh3xBW+TJ4Qs4Zz1qLAPUizmiQGNg01HU/61QM+GGl3s+YrJGIi9FvSYawTNjeObtak2O9lwl5azIr3KReifqAmCq7N82kUSPy9TiyQyeA4lbavgg3GAEZMYZZ3LyAJwMBq7O0R9/ujnVIjni1hXwKwpaLIKE=
Received: from IA3PR10MB8513.namprd10.prod.outlook.com (2603:10b6:208:576::12)
 by PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 3 Mar
 2026 19:36:14 +0000
Received: from IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61]) by IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61%6]) with mapi id 15.20.9632.010; Tue, 3 Mar 2026
 19:36:13 +0000
Message-ID: <f0ad1f47-72d8-41bb-96a2-1607a6682f80@oracle.com>
Date: Tue, 3 Mar 2026 11:36:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Refactor selftests
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
References: <20260302171033.1003145-2-bruce.mcculloch@oracle.com>
 <20260302171033.1003145-3-bruce.mcculloch@oracle.com>
 <1193aca9-33cc-4772-8b5f-a22a735bdd58@oracle.com>
Content-Language: en-US
From: Bruce McCulloch <bruce.mcculloch@oracle.com>
In-Reply-To: <1193aca9-33cc-4772-8b5f-a22a735bdd58@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::22) To IA3PR10MB8513.namprd10.prod.outlook.com
 (2603:10b6:208:576::12)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR10MB8513:EE_|PH7PR10MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 784b1a68-e711-4b6e-65ed-08de795c2152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	3Xd3clDMJ9Wir183nG2cmpRpKxNoYNQRgoAD0YtLjLpRc3TwweEgjf5TN7lOKSK185wqRV9/Q4weUbqvFELeIo/gmKUZkdc1sNh9x10WjGBLCjuCVzk/ZcLWk/OztiQWKw+370sye+ObxcxRNYqQ/lVWUOp0Hc279tdXMwMF1n87+bd5B+10syn+V/Q4VC8sDmWA++KI9D/FDEqlE0SLx41xVMm24Mt2qI5c4SspmGs8pqIOtGbn+mPDRkgAnLuKsnhk6s8W/N1hAgktJuXqbL42jjTD65JEOUGHAkX27RzTpQZY4VbXLANpI4SCq3qS56H+563P1XoD1sjH6eKD0WuQaOSm3TFM7tYIpaw333mzaOK8AyPjnHe5x2507sSL10SKVAFokb/FND4RNFaNkQfeXlRfRhHby9s/nHuWiQWd57CxbIDSGANeicjDnVKiNIXozddRlz9/GJ1LN2RLZIUXuCGqh5lZKNQ4FK39Dl1AQmYmmpIwAtbCTXvz+Jxb3RvSraflDbZS/SibjH3C+7YpOzBOYv9hwJcAMPsw+GFRZy3iVhIFdaCBou05Yv9WSqF+fo0yExncQrbWydW7pAYItxxzVEmXGhuIpb22YbMagU8vmm/LbXuXTU+5wBx9smo243KJZ2KeaylOSJ6JD3V+HH/wMUNxiJHAQ6Uyc8yVuhMt64TJ8CU0Ip8qYNPajctWWs7F5M7ET/0fblZvQr29QSnZzD3m/7vVA1RofhiHPZWGE782895N5Y1dqyI5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR10MB8513.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3diOFFNR3JaNFhNTzJxNEpUSjZVb3V3OU84R1RoTzk2VDJkdlIxaHVTN1dl?=
 =?utf-8?B?Q1BFWFd6U3ZOQmNQLzBPdDNFYld2NksvVm95RWtITDVtT3FCcWZzTVM1blJs?=
 =?utf-8?B?VFlYNVY1S29TYWxLV2NFYXlOaTRlM0M5UDQ4MDhLTnRPTUVENmdZL0hJMW5T?=
 =?utf-8?B?dkJWQ1VWMld1cWtFZ0p3eVdrVUVjZklscHE4bGt5NzdyaFh1QXVYRFlTaDBu?=
 =?utf-8?B?a0YrZnlxUEVSSmNkVEFkZ0pKSWtjUnBRUU92bHNQSjQ4bURmOHlpOFVrY292?=
 =?utf-8?B?bUowSGd6MExhY0xaVUQ3bmVNcEdUNndMbHE2aXBGTnFrLzlFcDhnRHFuNEhW?=
 =?utf-8?B?cGlMTG1GYkpqeVlVLzYwaXFlSUF3ZHJ5R0NyTm0wVDJqMHkvcU1McW5FMG53?=
 =?utf-8?B?TlFuOEZLRlh3b2Fkbk9STS9Gckcyd1BlUmtwcDBrL1dPNnhvTTBYVUJaWXZ4?=
 =?utf-8?B?aUtDbVVnbzY2NDl4U2Z2blhJRXd0a3N6NFRJekRTVnVoYmIvNTNjekRCcXl2?=
 =?utf-8?B?VUc4WDFGMkJsc2NvbUZjNkZPQzZHRCtqc29Ub1hJZGpiUno1ZHVKZmlJTkJL?=
 =?utf-8?B?cFllbmNmS0ZrQXorSDNRS2RBSURhdmFNNTVmaFVJazh0OU1kdEhMbmJPcGc0?=
 =?utf-8?B?cmRvZkFOQys3dnZFMVdsMUFZOTRBSW5Sa3paRGFOQjlWY0dmMGRJRys2cVdO?=
 =?utf-8?B?aWpsQmNjVWVJVE5RRnNaY3lKNlhaM2V6VDU1UHRDckcwZ1lZRDNVSU4xQTYr?=
 =?utf-8?B?Ymh5T1F5NTZYNHc3ZERDeTUzOW1DcEFiVTJTWS94bWt2bU9xRmhQbnAwaENJ?=
 =?utf-8?B?L2VCdHY5QmFPNmJ6L1NPYjZYdTVyeDBaQXdBZXdHdnhRWDVhZWtyVGdKc3lv?=
 =?utf-8?B?Q0c3QnpWR0VJd3lHVnFoeXpVMmF3RFNYQ3A1Z2dZT0wzMHc4eDBVeWx2R0dC?=
 =?utf-8?B?c05wQ1pRblo4M2hzVkRpTXNtTFBxSFRJd2JhM084ZldVUmwwK2lJa3E4bk5p?=
 =?utf-8?B?VE83LzdFRzU2bGhyT1hsOWhNNUpQT2g4cEx4VWpMWHQ0SGRUYlJUOU9Ec1JN?=
 =?utf-8?B?MFhBUUtlVHVoZ0dOeFFGOXU5NFFka1NVRG11MllRMktnYXBVaDdLemc2bGd2?=
 =?utf-8?B?TWhua1NjMlVhME1YTlZwMmxSRU01MXZyWTNnQ0c5MnhjNWZ1TmFlWGl3ZGtW?=
 =?utf-8?B?ZE5xRUovZ1hiSGp2OVNlMHJHK1dHaUpyUXlIekdFK2ViY3JUa3dOYzVEZ1pU?=
 =?utf-8?B?SndMQkdyOU9KYWsyWEtBTHJ6WDVTbUpaV1YyZGFsai9yQy85QjRiZy9oNnhD?=
 =?utf-8?B?Rkw3algwSFdNRlB2QXpkSzJCZi8xWlNBNXFFRlJtU0pYYjltWmpXRVdkZDhp?=
 =?utf-8?B?ZzFXaGhFemUwMmE4T3Y1L09XOElUUGNsLytiUHN1SU53Q1lvaWlDazhIeklj?=
 =?utf-8?B?di9WazEvaXl4Nkladjd5QlJQc2lSQUI1eEt4SXAzMHdGbE9sNmE2TTNScXMr?=
 =?utf-8?B?dytlK2p1VC93QXBqeW51KytOTHVTU3IxWTlQQW1PampSa2FLSzJmajdrS0Vq?=
 =?utf-8?B?STkxbTlXOVhWeCs2UWNhQ1YwUEEwY3Fvd2dFcGhTMlJGRis5eVluMmdMNWJt?=
 =?utf-8?B?VEIyaFU0U3NzSkhCVHcyR29wS1ROTnZlUytzeWJnaFJUN2lrVFdiaFVxTDBM?=
 =?utf-8?B?V3lZallSUnRQSmE4TkxsY2dGWndLVm1KVE9Pa3Nlem91ZHhmVnE5bFZBQUpz?=
 =?utf-8?B?MTE5N0xjMzkyK3JhSmgrY0VJOTQ2SjY3NmNIT3JCOVpXdENmQUdwUFlDTDJS?=
 =?utf-8?B?QjBWUVoyRjJoMjRaQU1LbEVxcWhyclpSMlo2SHhKNDBGYjNGK1BNSFAwR3J1?=
 =?utf-8?B?SlQyRlNXQTZ2alU4SUQ3NEd1VjNUVVhHanU2KzlEdnVHR2VrUnJLckMxUHJh?=
 =?utf-8?B?Tis0SUM5a3ZCVitocTJOVjB2RG91WEtQQlZSRlNjUXliZjFoR29qcy9VREdz?=
 =?utf-8?B?NVRoTXBRanpwdU5aWFVNMGtQS3BYN3lzNUxrR25LcVRSVWE4TWpLUEp5YXlx?=
 =?utf-8?B?TVF1bG9FZDJyNU44WGtQRnUyNVMyY2hzTnNZaTBBUlVHK1hEampqNWVkckFi?=
 =?utf-8?B?bCtxRXc2WmRCUTNZTG1kdUJXcThwMHZyc0ZJNWZOR1pIRHphUm1xc3pjUERU?=
 =?utf-8?B?RUxHWkI2MHp1TTJaNDZ6M2l1bUlKK1ZLQ1hxZEIrYVFGTldaaERQV3JUYlgz?=
 =?utf-8?B?MjhrL0FWaFQwS3puNzIrVklHRW5aNEltSHVNWEpsZ3BZMjgraERxNXdIMEJa?=
 =?utf-8?B?RUhMS3NVS2c5dG10K1lQaUJnajljZnkvWlkzTzJSdGJJdUorTDFpWjhrdWhN?=
 =?utf-8?Q?mlbVN8VzlcTM/8rM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/i3HVAWFUAj7Hy3ETXfXFlvoog4bFWV2tXX8FFEvYmIv50eNClVsSLGyTeLSJjGkTbWgARDGgagmpN0XIIn6AJxknRYAjzV675AzaroffdVitC3wlTbtRXSzWnKfRNz1AH9PrA5ViNNM3JAtjJ14dlAS4PKpCi70aBIRayMizsgI+YWXI5l59D0OI+xAWkDj4wuMQLgtB8p1VY/Z652fk+6ORoVSRBw+Atpb0jhcz8Nm58vOg5CPSeV2w7sjrUOY0aQBHwdGwBhWEC+PHmhmjN9lbrCsMwrKnVP1nQOLqX5yQKCDAOA4ckxW3pPwkm7yPdNVxAhSLl2DP/VaeQfeXGWch/rxpj0Qk4cfq07iG4Alq69mXWUHrWQt566oROTk3qCVv/s5AL4tdZZXIzFNdWVjeIQLXwnTl70BBx35foWmsITAIJZxYqlQceNkby2tglNGdJhNqNwl9gz6dFaP+GgXhNZ9yJTvPJ2YUf+6U/ALrPofs5Ei+FYtPARM2bOKdlAQXYKKMB6ewhpIz9iISAO6ZUS3aJb73ivbZHZoyuNbqApLfMlyA/2Mj2kZzVallZk7Ob711Qd6id32py28dxoTNmgpKdEAWI7dmup4xRE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784b1a68-e711-4b6e-65ed-08de795c2152
X-MS-Exchange-CrossTenant-AuthSource: IA3PR10MB8513.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:36:13.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j++saib7rDdM3ZJmTkmtLOoOqnWHp9YvnaA7/SF1TaOMc+vKesXG4rcRM+vJJ6OAnpnXVk7LmhagvJeiUp5lRrvrWzQp12HzAfImPokOYKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030159
X-Proofpoint-GUID: 4752Fgly2JY-Db4i6cCA1cky3PCT4iiH
X-Authority-Analysis: v=2.4 cv=VZH6/Vp9 c=1 sm=1 tr=0 ts=69a73832 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=NEAV23lmAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Z-sZjryct7jrt36-3eQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13812
X-Proofpoint-ORIG-GUID: 4752Fgly2JY-Db4i6cCA1cky3PCT4iiH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE1OSBTYWx0ZWRfXxgXNRlRTDIll
 dKiX6iTwVif2d6r5rylsiCrqcOPqnq5frgMrLxZa9fWyKb3dN6UqMHQUWY6vlHKYdfEabWrsaD6
 ulf2BQVfB5eySrHO5ZyX23FA1mqhUcZvTXqk21rnn5XhPFrr+XYT/sk2pFxvg9bnAEeQ8PTw9dj
 iZiEYlIevB++Bx+uzs8uLnvKpC0aUsZYWtxASI5owFeShmH5WLKKgYMI6lwtm9s4QE5dM6Q/Wo+
 FE/pNw92iADeM80UxTgv3+Gn+TRyaOEWVFvFegkEKrhz5wPvdpSlpQ/Qckz/Dve6NTyhBPp90xy
 Cp237LVAN9nbBwtL9fa82A572ju4NUu3POa/6FotCbVZSVWVEVlN4HKM+OVmav+MUg6UzbBoTrJ
 1+zU4j9qi183TFekE71dLllUMgAryxX1d1c2lBPcGuroPQVu1omJ+vKhxWZTUkL7UUc13fWRfhb
 iZjpluo5M06nrwoJIFFPFesJydNrXtPaizejA3LI=



On 3/3/26 1:13 AM, Alan Maguire wrote:
> On 02/03/2026 17:10, Bruce McCulloch wrote:
>> Hello All,
>>
>> Here is a small patch to clean up common functions in the testsuite and
>> introduce a few quality of life features in a common library. Please let
>> me know if you have any concerns or would like to see any additional
>> features.
>>
>> Bruce
> hi Bruce, thanks for the patch! I ran it through dwarves CI and we see
> a fatal failure in [1] due the the fact that /usr/bin/perf isn't a
> program with DWARF but rather a shell wrapper. That's been a long-standing
> issue in the selftests/CI, but was non-fatal previously:
>
> Pretty printing of files using DWARF type information: libbpf: failed to get EHDR from /usr/sbin/perf
> pahole: /usr/sbin/perf: Invalid argument
> skip: /usr/sbin/perf doesn't have 'struct perf_event_header' type info
>
> If you want to run CI yourself you can clone https://github.com/acmel/dwarves
> on github and push a branch; you will see the CI run under the "Actions" tab
> of your repo.
>
>
> [1] https://github.com/alan-maguire/dwarves/actions/runs/22597958001
Hi Alan,

Thanks for the heads up, I'll make the change and re-submit after testing.

Bruce
>> ---
>> Simple refactoring of the testsuite with the creation of a shared
>> library (tests/test_lib.sh).
>> Additions include:
>> * Getters to find vmlinux.
>> * Functions to open tmp dirs and tmp files.
>> * Functions to automatically clean tmp dirs and files on pass.
>> * On fail, tmp dirs are preserved.
>> * Functions to pass/fail/softfail tests (works with CI).
>> * Logging functions with varying verbosity levels.
>> * Colors.
>>
>> Signed-off-by: Bruce McCulloch <bruce.mcculloch@oracle.com>
>> ---
>>   tests/btf_functions.sh        | 143 +++++++++++-------------------
>>   tests/default_vmlinux_btf.sh  |  18 ++--
>>   tests/flexible_arrays.sh      |  48 +++++-----
>>   tests/pfunct-btf-decl-tags.sh |  34 +++----
>>   tests/prettify_perf.data.sh   |  53 ++++++-----
>>   tests/reproducible_build.sh   |  47 +++++-----
>>   tests/test_lib.sh             | 161 ++++++++++++++++++++++++++++++++++
>>   tests/tests                   |  29 +++---
>>   8 files changed, 332 insertions(+), 201 deletions(-)
>>   create mode 100755 tests/test_lib.sh
>>
>> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
>> index ee0f9ff..127640e 100755
>> --- a/tests/btf_functions.sh
>> +++ b/tests/btf_functions.sh
>> @@ -8,45 +8,22 @@
>>   # also should have been.
>>   #
>>   
>> -outdir=
>> -
>> -fail()
>> -{
>> -	# Do not remove test dir; might be useful for analysis
>> -	trap - EXIT
>> -	if [[ -d "$outdir" ]]; then
>> -		echo "Test data is in $outdir"
>> -	fi
>> -	exit 1
>> -}
>> -
>> -cleanup()
>> -{
>> -	rm ${outdir}/*
>> -	rmdir $outdir
>> -}
>> -
>> -vmlinux=${vmlinux:-$1}
>> -
>> -if [ -z "$vmlinux" ] ; then
>> -	vmlinux=$(pahole --running_kernel_vmlinux)
>> -	if [ -z "$vmlinux" ] ; then
>> -		echo "Please specify a vmlinux file to operate on"
>> -		exit 2
>> -	fi
>> -fi
>> +source test_lib.sh
>>   
>> -if [ ! -f "$vmlinux" ] ; then
>> -	echo "$vmlinux file not available, please specify another"
>> -	exit 2
>> +vmlinux=$(get_vmlinux $1)
>> +if [ $? -ne 0 ] ; then
>> +	info_log "$vmlinux"
>> +	test_fail
>>   fi
>>   
>> -outdir=$(mktemp -d /tmp/btf_functions.sh.XXXXXX)
>> +outdir=$(make_tmpdir)
>>   
>> +# Comment this out to save test data.
>>   trap cleanup EXIT
>>   
>> -echo -n "Validation of BTF encoding of functions; this may take some time: "
>> -test -n "$VERBOSE" && printf "\nEncoding..."
>> +title_log "Validation of BTF encoding of functions."
>> +info_log "This may take some time."
>> +verbose_log "Encoding..."
>>   
>>   # Here we use both methods so that we test pahole --lang_exclude, that is
>>   # used in the Linux kernel BTF encoding phase, and as well to make sure all
>> @@ -57,7 +34,7 @@ export PAHOLE_LANG_EXCLUDE=rust
>>   pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |\
>>   	grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
>>   
>> -test -n "$VERBOSE" && printf "done.\n"
>> +verbose_log "done."
>>   
>>   funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf 2>/dev/null|sort)
>>   
>> @@ -87,8 +64,8 @@ while IFS= read -r btf ; do
>>   			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
>>   				const_insensitive=$((const_insensitive+1))
>>   			else
>> -				echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
>> -				fail
>> +				error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
>> +				test_fail
>>   			fi
>>   		else
>>   			inline=$((inline+1))
>> @@ -98,13 +75,11 @@ while IFS= read -r btf ; do
>>   	fi
>>   done < $outdir/btf.funcs
>>   
>> -if [[ -n "$VERBOSE" ]]; then
>> -	echo "Matched $exact functions exactly."
>> -	echo "Matched $inline functions with inlines."
>> -	echo "Matched $const_insensitive functions with multiple const/non-const instances."
>> -	echo "Ok"
>> -	echo "Validation of skipped function logic..."
>> -fi
>> +verbose_log "Matched $exact functions exactly."
>> +verbose_log "Matched $inline functions with inlines."
>> +verbose_log "Matched $const_insensitive functions with multiple const/non-const instances."
>> +verbose_log "Ok"
>> +verbose_log "Validation of skipped function logic..."
>>   
>>   skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{ print $1}')
>>   
>> @@ -113,16 +88,14 @@ for s in $skipped_fns ; do
>>   	# Ensure the skipped function are not in BTF
>>   	inbtf=$(grep " $s(" $outdir/btf.funcs)
>>   	if [[ -n "$inbtf" ]]; then
>> -		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
>> -		fail
>> +		error_log "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
>> +		test_fail
>>   	fi
>>   done
>>   
>> -if [[ -n "$VERBOSE" ]]; then
>> -	echo "Skipped encoding $skipped_cnt functions in BTF."
>> -	echo "Ok"
>> -	echo "Validating skipped functions have incompatible return values..."
>> -fi
>> +verbose_log "Skipped encoding $skipped_cnt functions in BTF."
>> +verbose_log "Ok"
>> +verbose_log "Validating skipped functions have incompatible return values..."
>>   
>>   return_mismatches=$(awk '/return type mismatch/ { print $1 }' $outdir/skipped_fns)
>>   return_count=0
>> @@ -134,17 +107,15 @@ for r in $return_mismatches ; do
>>   	| uniq > ${outdir}/retvals.$r
>>   	cnt=$(wc -l ${outdir}/retvals.$r | awk '{ print $1 }')
>>   	if [[ $cnt -lt 2 ]]; then
>> -		echo "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
>> -		fail
>> +		error_log "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
>> +		test_fail
>>   	fi
>>   	return_count=$((return_count+1))
>>   done
>>   
>> -if [[ -n "$VERBOSE" ]]; then
>> -	echo "Found $return_count functions with multiple incompatible return values."
>> -	echo "Ok"
>> -	echo "Validating skipped functions have incompatible params/counts..."
>> -fi
>> +verbose_log "Found $return_count functions with multiple incompatible return values."
>> +verbose_log "Ok"
>> +verbose_log "Validating skipped functions have incompatible params/counts..."
>>   
>>   param_mismatches=$(awk '/due to param / { print $1 }' $outdir/skipped_fns)
>>   
>> @@ -169,10 +140,8 @@ for p in $param_mismatches ; do
>>   		if [[ -n "$inlined" ]]; then
>>   			multiple_inline=$((multiple_inline+1))
>>   		else
>> -			if [[ -n "$VERBOSE" ]]; then
>> -				echo "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
>> -				echo "Full skip message from pahole: $skipmsg"
>> -			fi
>> +			verbose_log "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
>> +			verbose_log "Full skip message from pahole: $skipmsg"
>>   			warnings=$((warnings+1))
>>   		fi
>>   	else
>> @@ -180,24 +149,22 @@ for p in $param_mismatches ; do
>>   	fi
>>   done
>>   
>> -if [[ -n "$VERBOSE" ]]; then
>> -	echo "Found $multiple instances with multiple instances with incompatible parameters."
>> -	echo "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
>> -	echo "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
>> -	echo "Found $warnings instances where pfunct did not notice inconsistencies."
>> -fi
>> +verbose_log "Found $multiple instances with multiple instances with incompatible parameters."
>> +verbose_log "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
>> +verbose_log "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
>> +verbose_log "Found $warnings instances where pfunct did not notice inconsistencies."
>>   
>>   # Some specific cases can not  be tested directly with a standard kernel.
>>   # We can use the small binary in bin/ to test those cases, like packed
>>   # structs passed on the stack.
>>   
>> -test -n "$VERBOSE" && echo -n "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
>> +verbose_log "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
>>   
>> -test -n "$VERBOSE" && printf "\nBuilding test_bin..."
>> +verbose_log "Building test_bin..."
>>   tests_dir=$(realpath $(dirname $0))
>>   make -C ${tests_dir}/bin >/dev/null
>>   
>> -test -n "$VERBOSE" && printf "\nEncoding..."
>> +verbose_log "Encoding..."
>>   pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/test_bin.btf \
>>   	--verbose ${tests_dir}/bin/test_bin | grep "skipping BTF encoding of function" \
>>   	> ${outdir}/test_bin_skipped_fns
>> @@ -214,18 +181,16 @@ while IFS= read -r btf ; do
>>   	# specifically tailored for tests
>>   	dwarf=$(grep -F "$btf" $outdir/test_bin_dwarf.funcs)
>>   	if [[ "$btf" != "$dwarf" ]]; then
>> -		echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
>> -		fail
>> +		error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
>> +		test_fail
>>   	else
>>   		exact=$((exact+1))
>>   	fi
>>   done < $outdir/test_bin_btf.funcs
>>   
>> -if [[ -n "$VERBOSE" ]]; then
>> -	echo "Matched $exact functions exactly."
>> -	echo "Ok"
>> -	echo "Validation of skipped function logic..."
>> -fi
>> +verbose_log "Matched $exact functions exactly."
>> +verbose_log "Ok"
>> +verbose_log "Validation of skipped function logic..."
>>   
>>   skipped_cnt=$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}')
>>   
>> @@ -234,16 +199,14 @@ for s in $skipped_fns ; do
>>   	# Ensure the skipped function are not in BTF
>>   	inbtf=$(grep " $s(" $outdir/test_bin_btf.funcs)
>>   	if [[ -n "$inbtf" ]]; then
>> -		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
>> -		fail
>> +		error_log "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
>> +		test_fail
>>   	fi
>>   done
>>   
>> -if [[ -n "$VERBOSE" ]]; then
>> -	echo "Skipped encoding $skipped_cnt functions in BTF."
>> -	echo "Ok"
>> -	echo "Validating skipped functions have uncertain parameter location..."
>> -fi
>> +verbose_log "Skipped encoding $skipped_cnt functions in BTF."
>> +verbose_log "Ok"
>> +verbose_log "Validating skipped functions have uncertain parameter location..."
>>   
>>   uncertain_loc=$(awk '/due to uncertain parameter location/ { print $1 }' $outdir/test_bin_skipped_fns)
>>   legitimate_skip=0
>> @@ -266,12 +229,10 @@ for f in $uncertain_loc ; do
>>   			fi
>>   		fi
>>   	done
>> -	echo "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
>> -	fail
>> +	error_log "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
>> +	test_fail
>>   done
>>   
>> -if [[ -n "$VERBOSE" ]]; then
>> -	echo "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
>> -fi
>> -echo "Ok"
>> -exit 0
>> +verbose_log "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
>> +
>> +test_pass
>> diff --git a/tests/default_vmlinux_btf.sh b/tests/default_vmlinux_btf.sh
>> index a855ca7..496e840 100755
>> --- a/tests/default_vmlinux_btf.sh
>> +++ b/tests/default_vmlinux_btf.sh
>> @@ -1,6 +1,7 @@
>>   #!/bin/bash
>> +source test_lib.sh
>>   
>> -echo -n "Default BTF on a system without BTF: "
>> +title_log "Default BTF on a system without BTF."
>>   
>>   ulimit -c 0
>>   
>> @@ -13,8 +14,7 @@ ulimit -c 0
>>   nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole -F btf list_head 2>&1 | wc -l)
>>   
>>   if [ $nr_lines -eq 0 ] ; then
>> -	echo "FAILED"
>> -	exit 1
>> +	test_softfail
>>   fi
>>   
>>   # There is also the case where no debugging info is available, be it DWARF of
>> @@ -22,11 +22,15 @@ fi
>>   # that as well
>>   #
>>   nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole 2>&1 | wc -l)
>> +nr_lines=0
>>   
>>   if [ $nr_lines -eq 0 ] ; then
>> -	echo "FAILED"
>> -	exit 1
>> +	test_softfail
>>   fi
>>   
>> -echo "Ok"
>> -exit 0
>> +check_softfail
>> +if [ $? -eq 2 ] ; then
>> +	test_fail
>> +else
>> +	test_pass
>> +fi
>> \ No newline at end of file
>> diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
>> index 59fa38e..4e9e995 100755
>> --- a/tests/flexible_arrays.sh
>> +++ b/tests/flexible_arrays.sh
>> @@ -5,22 +5,23 @@
>>   #
>>   # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
>>   
>> -vmlinux=${vmlinux:-$1}
>> +source test_lib.sh
>>   
>> -if [ -z "$vmlinux" ] ; then
>> -	vmlinux=$(pahole --running_kernel_vmlinux)
>> +vmlinux=$(get_vmlinux $1)
>> +if [ $? -ne 0 ] ; then
>> +	info_log "$vmlinux"
>> +	test_fail
>>   fi
>>   
>> -if [ ! -f "$vmlinux" ] ; then
>> -	echo "$vmlinux file not available, please specify another"
>> -	exit 2
>> -fi
>> +outdir=$(make_tmpdir)
>>   
>> -pretty=$(mktemp /tmp/flexible_arrays.data.sh.XXXXXX.c)
>> +# Comment this out to save test data.
>> +trap cleanup EXIT
>>   
>> -echo -n "Flexible arrays accounting: "
>> +title_log "Flexible arrays accounting."
>>   
>>   for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux | cut -f1) ; do
>> +	pretty=$(make_tmpsrc)
>>   	pahole $struct $vmlinux > $pretty
>>   
>>   	# We need to check for just one tab before the comment as when expanding unnamed
>> @@ -48,30 +49,27 @@ for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux |
>>   	[ -z "$stat_nr_flexible_arrays" ] && stat_nr_flexible_arrays=0
>>   	stat_nr_embedded_flexible_arrays=$(grep "flexible array members:.*middle:" $pretty | sed -r 's/.*middle: *([[:digit:]]+).*/\1/g')
>>   	[ -z "$stat_nr_embedded_flexible_arrays" ] && stat_nr_embedded_flexible_arrays=0
>> -	test -n "$VERBOSE" && echo "end: $struct: $nr_flexible_arrays $stat_nr_flexible_arrays"
>> -	test -n "$VERBOSE" && echo "middle: $struct: $nr_embedded_flexible_arrays $stat_nr_embedded_flexible_arrays"
>> +	verbose_log "end: $struct: $nr_flexible_arrays $stat_nr_flexible_arrays"
>> +	verbose_log "middle: $struct: $nr_embedded_flexible_arrays $stat_nr_embedded_flexible_arrays"
>>   
>>   	if [ "$nr_embedded_flexible_arrays" != "$stat_nr_embedded_flexible_arrays" ] ; then
>> -		test -n "$VERBOSE" && printf "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
>> +		verbose_log "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
>>   			"$struct" "$stat_nr_embedded_flexible_arrays" "$nr_embedded_flexible_arrays"
>> -		test -n "$VERBOSE" && pahole $struct $vmlinux
>> -		FAILED=1
>> +		verbose_log pahole $struct $vmlinux
>> +		test_softfail
>>   	fi
>>   
>>   	if [ "$nr_flexible_arrays" != "$stat_nr_flexible_arrays" ] ; then
>> -		test -n "$VERBOSE" && printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
>> +		verbose_log printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
>>   			"$struct" "$stat_nr_flexible_arrays" "$nr_flexible_arrays"
>> -		test -n "$VERBOSE" && pahole $struct $vmlinux
>> -		FAILED=1
>> +		verbose_log pahole $struct $vmlinux
>> +		test_softfail
>>   	fi
>> -
>> -	rm -f $pretty
>>   done
>>   
>> -if [ -n "$FAILED" ] ; then
>> -	echo "FAILED"
>> -	exit 1
>> +check_softfail
>> +if [ $? -ne 0 ] ; then
>> +	test_fail
>> +else
>> +	test_pass
>>   fi
>> -
>> -echo "Ok"
>> -exit 0
>> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
>> index 69babef..35884b4 100755
>> --- a/tests/pfunct-btf-decl-tags.sh
>> +++ b/tests/pfunct-btf-decl-tags.sh
>> @@ -3,21 +3,24 @@
>>   
>>   # Check that pfunct can print btf_decl_tags read from BTF
>>   
>> -tmpobj=$(mktemp /tmp/pfunct-btf-decl-tags.sh.XXXXXX.o)
>> +source test_lib.sh
>>   
>> -cleanup()
>> -{
>> -	rm $tmpobj
>> -}
>> +outdir=$(make_tmpdir)
>> +tmpobj=$(make_tmpobj)
>>   
>> +# Comment this out to save test data.
>>   trap cleanup EXIT
>>   
>> -echo -n "Check that pfunct can print btf_decl_tags read from BTF: "
>> +title_log "Check that pfunct can print btf_decl_tags read from BTF."
>> +
>> +# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
>> +# in upstream version 16.
>> +# UPTODO: add a check here for that.
>>   
>>   CLANG=${CLANG:-clang}
>>   if ! command -v $CLANG > /dev/null; then
>> -	echo "Need clang for test $0"
>> -	exit 1
>> +	error_log "Need clang for test $0"
>> +	test_fail
>>   fi
>>   
>>   (cat <<EOF
>> @@ -55,13 +58,12 @@ out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
>>   d=$(diff -u <(echo "$expected") <(echo "$out"))
>>   
>>   if [[ "$d" == "" ]]; then
>> -	echo "Ok"
>> -	exit 0
>> +	test_pass
>>   else
>> -	echo "pfunct output does not match expected:"
>> -	echo "$d"
>> -	echo
>> -	echo "Complete output:"
>> -	echo "$out"
>> -	exit 1
>> +	error_log "pfunct output does not match expected:"
>> +	info_log "$d"
>> +	info_log
>> +	info_log "Complete output:"
>> +	info_log "$out"
>> +	test_fail
>>   fi
>> diff --git a/tests/prettify_perf.data.sh b/tests/prettify_perf.data.sh
>> index 2d16cf5..06ff523 100755
>> --- a/tests/prettify_perf.data.sh
>> +++ b/tests/prettify_perf.data.sh
>> @@ -1,4 +1,4 @@
>> -#!/bin/sh
>> +#!/bin/bash
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   # Copyright © 2024 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
>>   #
>> @@ -7,30 +7,35 @@
>>   # Check if the perf binary is available, if it is from a distro, normally it
>>   # will get the needed DWARF info using libddebuginfod, we'll check if the
>>   # needed types are available, skipping the test and informing the reason.
>> +source test_lib.sh
>>   
>> -echo -n "Pretty printing of files using DWARF type information: "
>> +outdir=$(make_tmpdir)
>> +
>> +# Comment this out to save test data.
>> +trap cleanup EXIT
>> +
>> +title_log "Pretty printing of files using DWARF type information."
>>   
>>   perf=$(which perf 2> /dev/null)
>>   if [ -z "$perf" ] ; then
>> -	echo "skip: No 'perf' binary available"
>> -	exit 2
>> +	info_log "skip: No 'perf' binary available"
>> +	test_fail
>>   fi
>>   
>>   perf_lacks_type_info() {
>>   	local type_keyword=$1
>>   	local type_name=$2
>>   	if ! pahole -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
>> -		echo "skip: $perf doesn't have '$type_keyword $type_name' type info"
>> -		return 1
>> +		info_log "skip: $perf doesn't have '$type_keyword $type_name' type info"
>> +		test_softfail
>>   	fi
>> -	return 0
>>   }
>>   
>> -perf_data=$(mktemp /tmp/prettify_perf.data.sh.XXXXXX.perf.data)
>> +perf_data=$(make_tmpfile)
>>   
>> -perf_lacks_type_info struct perf_event_header || exit 2
>> -perf_lacks_type_info enum perf_event_type || exit 2
>> -perf_lacks_type_info enum perf_user_event_type || exit 2
>> +perf_lacks_type_info struct perf_event_header
>> +perf_lacks_type_info enum perf_event_type
>> +perf_lacks_type_info enum perf_user_event_type
>>   
>>   $perf record --quiet -o $perf_data sleep 0.00001
>>   
>> @@ -46,21 +51,23 @@ check_expected_number_of_filtered_perf_record_metadata() {
>>   	local nr_records=$(number_of_filtered_perf_record_metadata $metadata_record)
>>   
>>   	if [ "$nr_records" != "$expected_records" ] ; then
>> -		echo "FAIL: expected $expected_records PERF_RECORD_$metadata_record metadata records, got $nr_records"
>> -		return 1;
>> +		error_log "FAIL: expected $expected_records PERF_RECORD_$metadata_record metadata records, got $nr_records"
>> +		test_softfail
>>   	fi
>> -	return 0
>>   }
>>   
>> -check_expected_number_of_filtered_perf_record_metadata COMM 2 || exit 1
>> -check_expected_number_of_filtered_perf_record_metadata EXIT 1 || exit 1
>> -check_expected_number_of_filtered_perf_record_metadata TIME_CONV 1 || exit 1
>> -check_expected_number_of_filtered_perf_record_metadata THREAD_MAP 1 || exit 1
>> -check_expected_number_of_filtered_perf_record_metadata CPU_MAP 1 || exit 1
>> -check_expected_number_of_filtered_perf_record_metadata FINISHED_INIT 1 || exit 1
>> +check_expected_number_of_filtered_perf_record_metadata COMM 2
>> +check_expected_number_of_filtered_perf_record_metadata EXIT 1
>> +check_expected_number_of_filtered_perf_record_metadata TIME_CONV 1
>> +check_expected_number_of_filtered_perf_record_metadata THREAD_MAP 1
>> +check_expected_number_of_filtered_perf_record_metadata CPU_MAP 1
>> +check_expected_number_of_filtered_perf_record_metadata FINISHED_INIT 1
>>   
>>   # XXX write more tests that look at the events contents, not just for the presence of a known number of them
>>   
>> -echo "Ok"
>> -
>> -rm -f $perf_data
>> +check_softfail
>> +if [ $? -ne 0 ] ; then
>> +	test_fail
>> +else
>> +	test_pass
>> +fi
>> diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
>> index a940d93..d8c6507 100755
>> --- a/tests/reproducible_build.sh
>> +++ b/tests/reproducible_build.sh
>> @@ -4,22 +4,22 @@
>>   # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
>>   # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
>>   
>> -vmlinux=${vmlinux:-$1}
>> +source test_lib.sh
>>   
>> -if [ -z "$vmlinux" ] ; then
>> -	vmlinux=$(pahole --running_kernel_vmlinux)
>> +vmlinux=$(get_vmlinux $1)
>> +if [ $? -ne 0 ]; then
>> +	info_log "$vmlinux"
>> +	test_fail
>>   fi
>>   
>> -if [ ! -f "$vmlinux" ] ; then
>> -	echo "$vmlinux file not available, please specify another"
>> -	exit 2
>> -fi
>> +outdir=$(make_tmpdir)
>>   
>> -outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
>> +# Comment this out to save test data.
>> +trap cleanup EXIT
>>   
>> -echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
>> +title_log "Parallel reproducible DWARF Loading/Serial BTF encoding."
>>   
>> -test -n "$VERBOSE" && printf "\nserial encoding...\n"
>> +verbose_log "Begin serial encoding..."
>>   
>>   # This will make pahole and pfunct to skip rust CUs
>>   export PAHOLE_LANG_EXCLUDE=rust
>> @@ -30,37 +30,32 @@ bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinu
>>   nr_proc=$(getconf _NPROCESSORS_ONLN)
>>   
>>   for threads in $(seq $nr_proc) ; do
>> -	test -n "$VERBOSE" && echo $threads threads encoding
>> +	verbose_log "$threads threads encoding"
>>   	pahole -j$threads --btf_features=default,reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
>>   	pahole=$!
>>   	# HACK: Wait a bit for pahole to start its threads
>> -	sleep 0.3s
>> +	sleep 1s
>>   	# PID part to remove ps output headers
>>   	nr_threads_started=$(ps -L -C pahole | grep -v PID | wc -l)
>> -        ((nr_threads_started -= 1)) # main thread doesn't count, it waits to join
>> +		((nr_threads_started -= 1)) # main thread doesn't count, it waits to join
>>   
>>   	if [ $threads != $nr_threads_started ] ; then
>> -		echo "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
>> -		exit 1;
>> +		error_log "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
>> +		test_fail
>>   	fi
>>   
>>   	# ps -L -C pahole | grep -v PID | nl
>> -	test -n "$VERBOSE" && echo $nr_threads_started threads started
>> +	verbose_log "$nr_threads_started threads started"
>>   	wait $pahole
>>   	rm -f $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
>>   	bpftool btf dump file $outdir/vmlinux.btf.parallel.reproducible > $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
>> -	test -n "$VERBOSE" && echo "diff from serial encoding:"
>> +	verbose_log "diff from serial encoding:"
>>   	diff -u $outdir/bpftool.output.vmlinux.btf.serial $outdir/bpftool.output.vmlinux.btf.parallel.reproducible > $outdir/diff
>>   	if [ -s $outdir/diff ] ; then
>> -		echo "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
>> -		exit 1
>> +		error_log "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
>> +		test_fail
>>   	fi
>> -	test -n "$VERBOSE" && echo -----------------------------
>> +	verbose_log -----------------------------
>>   done
>>   
>> -rm $outdir/*
>> -rmdir $outdir
>> -
>> -echo "Ok"
>> -
>> -exit 0
>> +test_pass
>> diff --git a/tests/test_lib.sh b/tests/test_lib.sh
>> new file mode 100755
>> index 0000000..3c84d6e
>> --- /dev/null
>> +++ b/tests/test_lib.sh
>> @@ -0,0 +1,161 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Copyright (c) 2026, Oracle and/or its affiliates.
>> +#
>> +# Common helper functions for the testsuite.
>> +#
>> +
>> +if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
>> +	echo "This script is meant to be sourced. Please use 'source test_lib.sh'."
>> +	exit 1
>> +fi
>> +
>> +check_color_support()
>> +{
>> +	if [ ! -z "$RED" ] ; then
>> +		return 0
>> +	else
>> +		if tput colors >/dev/null 2>&1; then
>> +			num_colors=$(tput colors)
>> +			if [ $num_colors -gt 0 ]; then
>> +				RED='\033[0;31m'
>> +				GREEN='\033[0;32m'
>> +				YELLOW='\033[0;33m'
>> +				NC='\033[0m'
>> +			else
>> +				RED=''
>> +				GREEN=''
>> +				YELLOW=''
>> +				NC=''
>> +			fi
>> +		else
>> +			RED=''
>> +			GREEN=''
>> +			YELLOW=''
>> +			NC=''
>> +		fi
>> +	fi
>> +	return 0
>> +}
>> +
>> +get_vmlinux()
>> +{
>> +	check_color_support
>> +	vmlinux=${vmlinux:-$1}
>> +
>> +	if [ -z "$vmlinux" ] ; then
>> +		vmlinux=$(pahole --running_kernel_vmlinux)
>> +		if [ -z "$vmlinux" ] ; then
>> +			echo -e "${RED}Please specify a vmlinux file to operate on${NC}"
>> +			exit 2
>> +		fi
>> +	fi
>> +
>> +	if [ ! -f "$vmlinux" ] ; then
>> +		echo "${RED}$vmlinux file not available, please specify another${NC}"
>> +		exit 2
>> +	fi
>> +
>> +	echo $vmlinux
>> +	return 0
>> +}
>> +
>> +make_tmpdir()
>> +{
>> +	outdir=$(mktemp -d /tmp/$0.XXXXXX)
>> +	echo $outdir
>> +	return 0
>> +}
>> +
>> +make_tmpobj()
>> +{
>> +	outobj=$(mktemp $outdir/$0.obj.XXXXXX.o)
>> +	echo $outobj
>> +	return 0
>> +}
>> +
>> +make_tmpsrc()
>> +{
>> +	outsrc=$(mktemp $outdir/$0.src.XXXXXX.c)
>> +	echo $outsrc
>> +	return 0
>> +}
>> +
>> +make_tmpfile()
>> +{
>> +	outfile=$(mktemp $outdir/$0.data.XXXXXX)
>> +	echo $outfile
>> +	return 0
>> +}
>> +
>> +info_log()
>> +{
>> +	printf "   "
>> +	echo $1
>> +}
>> +
>> +title_log()
>> +{
>> +	check_color_support
>> +	echo -e "${YELLOW}$1${NC}"
>> +}
>> +
>> +verbose_log()
>> +{
>> +	if [[ -n "$VERBOSE" ]]; then
>> +		printf "   "
>> +		echo $1
>> +	fi
>> +}
>> +
>> +error_log()
>> +{
>> +	check_color_support
>> +	echo -e "${RED}$1${NC}"
>> +}
>> +
>> +test_softfail()
>> +{
>> +	if [ -z "$softfail_count" ] ; then
>> +		softfail_count=1
>> +	else
>> +		((softfail_count++))
>> +	fi
>> +}
>> +
>> +test_fail()
>> +{
>> +	trap - EXIT
>> +	check_color_support
>> +	echo -e "${RED}Test $0 failed${NC}"
>> +	if [[ -d "$outdir" ]]; then
>> +		echo -e "${RED}Test data is in $outdir${NC}"
>> +	fi
>> +	exit 1
>> +}
>> +
>> +check_softfail()
>> +{
>> +	check_color_support
>> +	if [ ! -z "$softfail_count" ] ; then
>> +		echo -e "${RED}Soft failures: $softfail_count${NC}"
>> +		return 1
>> +	else
>> +		return 0
>> +	fi
>> +}
>> +
>> +test_pass()
>> +{
>> +	check_color_support
>> +	echo -e "${GREEN}Test $0 passed${NC}"
>> +	exit 0
>> +}
>> +
>> +cleanup()
>> +{
>> +	rm ${outdir}/*
>> +	rmdir $outdir
>> +	return 0
>> +}
>> diff --git a/tests/tests b/tests/tests
>> index 11921ad..b37c823 100755
>> --- a/tests/tests
>> +++ b/tests/tests
>> @@ -8,19 +8,22 @@ cd $tests_dir
>>   let status=0
>>   let nr=1
>>   for test in *.sh ; do
>> -	printf "%3d: " $nr
>> -	./$test
>> -	case $? in
>> -	0)
>> -		;;
>> -	2)
>> -		echo "skipping..."
>> -		;;
>> -	*)
>> -		status=1
>> -		;;
>> -	esac
>> -	let nr+=1
>> +	if [ $test != "test_lib.sh" ]; then
>> +		printf "%d: $test\n" $nr
>> +		./$test $1
>> +		case $? in
>> +		0)
>> +			;;
>> +		2)
>> +			echo "skipping..."
>> +			;;
>> +		*)
>> +			status=1
>> +			;;
>> +		esac
>> +		let nr+=1
>> +		echo "---"
>> +	fi
>>   done
>>   
>>   cd -

