Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95A14B97E
	for <dwarves@vger.kernel.org>; Tue, 22 Oct 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635440; cv=fail; b=hGZCu02xF7Id0bITlbOBwWA5QFfW2I2miHW8M05qFw+7s4P4qP5Pj5nLLd1D0kpzmhb1RBnF+HSfP09uRJVl9UV8LhWqGi2ilKug/lMR9T+nujA+q02yelm8XVCCXwuuM6RN7bdLd5LqiqOs42J1OPH9+aDEXv58MTHLeex4MEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635440; c=relaxed/simple;
	bh=GuDHu5NgSpCztR2RPBjd0G9CHcTjPeg4dV7i5UwFgEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=YqRkEqC0W1XacBF+ruUo5piuWlC+b+4olqCyoGZd8Xheb1hiWQ2uxXPgfTLmAuN2CAI2b3qTAr0Na6KXnUu0ttp62Zn8AMQChvx+NLqK1YMjTIlMVB/cu45cG5fLRveX3qCBmQbnkblnpMrXUWZCHh933rIHdgduzQk3ZFych+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gq/4RgUN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ekou+RYU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gq/4RgUN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ekou+RYU"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLQdH5016626;
	Tue, 22 Oct 2024 22:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dN9cMC/3gKZNAXrOas
	R67svYfvUq+mlraTuxEHtO2Ag=; b=gq/4RgUNG6yscQ+KRkwnowvJYneaculOZO
	54l1TnuzUJTwpx+9rVXFEEz1rvTwplG/TLbOn91OrSF000UETmqO5pXZF/6LPMjg
	Vovi2gAZx/nng9I5jLRfIWnHF2kY/xlfNtva7z33g1FFmHsGiAKmriADNhYdcQOf
	Wwv0+eYQ+CUtUz/pRpuDjzUjs05jpi9s0kSf3Eq7L1Btid79hBeReYF6RfgP999N
	/Z00w1tUHM6p9GF9zI96tHqY3DrPUN4sSSV1L32NP6V8kf2oScx3hsTqZNNyrkX2
	dNn2hHwK35GOK9kDBPv2bBeHoR/KIB8WsWofSjjC4+0NNEWNFhZA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3dy1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 22:17:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MM41QF035989;
	Tue, 22 Oct 2024 22:17:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh1ravm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 22:17:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyvvleZ1+lIMJQoT1jxH5oVwHOFqzP0IUkeGMW16nk+s1v3cFRlWpVxQD9xyXTGZuqGOWEtlNTx92ExUe1q26RSPd7iAH07oiGWExE0e1Pn3PeX/jxYCS6hAIgHHj8Wnp8YKFgXqS4EJuPFm7GcmMctsPbFwYjgJQJr7Yiewuiayb8/tC7Yu1UVLqYSugcFCohaI3iMXN0aGXtQYPLjpv/kXxv6M9bAWm89X3iUix6sApRYORdcuhs1T7iEfnu7szReRb6cIRulyBXfKRTfJNamE0bPP8ZtYXLNSgjcz+VJ7biUMIozUe2lFzVxHrcsUnUOQFEM8wwTNNGeRqOwBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN9cMC/3gKZNAXrOasR67svYfvUq+mlraTuxEHtO2Ag=;
 b=HDYuLdNWVbYxEdlgYb98PjM7q4Q0O4Xq/ntanz78qSbwy+9hmT9whn1tr4uXtG6w5tNE3ZF1Z7JlwTIMbL+mbRCY5ZKnYRTSAIbuZO1gPbTeEzNtlVnsLjRtPfJFMAfIrGxjgRNKdAwQIbMIaHBta4n8ZWFAlPkUXOI8a2YWJ6Ko4ZqP6uSVYuvQvGtaS7JWGxHpXHOY1Hil3vG3oUQzS7QqzTjUUfkoLiD/do5SotqddfAX6mGgEPyEnmKMxKKQAGfNN4uCT6hoH7Bm3g0T7QRyojy72QU/OMza0oZbscMSzPeOEvfhk60nqyEVA54zoJQ5RCwrpjvi9V9wi58YIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN9cMC/3gKZNAXrOasR67svYfvUq+mlraTuxEHtO2Ag=;
 b=Ekou+RYUxfZPgIimrEh5GQ9vVyHk4Dqtmc5cZCZCmr81P+F1hHIim/tCwsxbz36TxpN2Wy4EpCM84+dQcWejb7P0J1WEER07T7fXsduywD7RxVyhG/aTEy8zt2tNnDHyTOUI+tr1Ve/1Y/smVsjhhk5WULOy5FQ2/b4iFp5UI2U=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SN7PR10MB6332.namprd10.prod.outlook.com (2603:10b6:806:270::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 22:17:11 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 22:17:11 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: ojeda@kernel.org, andrii.nakryiko@gmail.com, jolsa@kernel.org,
        dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves] btf_encoder: filter var names before btf name
 check
In-Reply-To: <20241018094301.1550149-1-alan.maguire@oracle.com>
References: <20241018094301.1550149-1-alan.maguire@oracle.com>
Date: Tue, 22 Oct 2024 15:17:09 -0700
Message-ID: <87v7xjrdei.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::19) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SN7PR10MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1568faeb-9d07-45ae-ce2a-08dcf2e74632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bHzYQe50QbNygj4uzgje7zYGCZPtDPBSZygyA73Vwbm0/pt68vviWivLcGa6?=
 =?us-ascii?Q?SPPmC2pUOgtil5TuT2e++WKUVQEZN+oU/KKvhtIeNZBwJHEXIljqh5VjjxhK?=
 =?us-ascii?Q?yRD7m01DcVBPku/dqlGd4eVv8EhVlGIraEonLfBJbZLVbgL4vaZDxZ1v4iN3?=
 =?us-ascii?Q?TT3de0tPmAkZepM2cpJKQJ+01cssyQtniPGeXjsQ5e1BI+poqakdzgUKZ57z?=
 =?us-ascii?Q?/7ZN49GU9lE2jTj+NdtnHtimj8e6RLd8VWcmmo6l3mfobf+aZWsT5tM8sZoN?=
 =?us-ascii?Q?NH1PnxJc7sgv5Mw525iUZUxV2kbxqOyQvpNpXI2rHxBzluoMpkHeDBbHjT/h?=
 =?us-ascii?Q?+ppPGaCmoirRsCuvxGnk1gPgJrv5dAOpDG4i1FOqN0PvOy7J7lteVVSEh3CO?=
 =?us-ascii?Q?dnHB1eocPYCfgMe9jl+o2cVONVRhPWhyoXDx7905nKK8SFXtaZFMAnfDUfXX?=
 =?us-ascii?Q?1zGi5tipJVhIc5v/joxv6qbC9Gm7WSv6q0ON5slrWeQYcFkjYPHQUAfZqu89?=
 =?us-ascii?Q?5xd35U/ZzRRVcWDZ7EY6hoQe/DctYXoMHgdz4tedrkNTt8xKSvACsfihfao/?=
 =?us-ascii?Q?AANdq2WbuGO0jSv65NYr2ddF9bqAQLP63pPxZXwKlAVD4DAQpfAhJxguBSdp?=
 =?us-ascii?Q?hNdYtMGJSoEDx753iNI5Dz9BWEkDLhAVtvE87UwxrihZ7lTfIqcUNTYiiDqU?=
 =?us-ascii?Q?Epmc8v3Zb61e0VeU0JZLG1xqTBO3t3uwO96HDRQIBgGQ3klcXXRvMdnHFxRL?=
 =?us-ascii?Q?b3GQF8zVPz4UjmuiZIZYykhoKtvlyU2w3w/DfqZ1xNW6XJRDaJX6o90U1RCV?=
 =?us-ascii?Q?gQRPsNKcvRBGjn9+TIvOUbyJyOfcVAh4dgBONZLwg7JDixjnAtBssOMuIj5B?=
 =?us-ascii?Q?DtHCvNHI5O5o3wev4F2pZw8bz3XNzg6ijkADINKwkmYNI2j29x6KeawZoc6p?=
 =?us-ascii?Q?zhfyHA74Cp2kNBUIfrNvAdnxpzP9LkoxuxKpXMJPwJZJ+J9wNalJwZ9K8+TY?=
 =?us-ascii?Q?55vaDvzQEO2Xb5zB4y6lyEuHAPePtBnfuUhCl0fjJYOOQc4XVRL+FSlpHzVk?=
 =?us-ascii?Q?wzwL5hWzKmnPB3aPgoV1gu+BRWDCC8tcCplBMlDAUs9wJGgP+xfARCZvmf6c?=
 =?us-ascii?Q?kk7SzGdb0IKfsTtv7lXbjvf6MjOPKl11aNc7J3G0+InYpP6tsFaoXf+nDY+r?=
 =?us-ascii?Q?QfGeYVxY9AB1ZpuP5n4K22rBsVTuJxM003JotJvQ0+DM6KTqPsxU/SgZM0Cu?=
 =?us-ascii?Q?0HQyWz55jr4tz1wQi289LCo1qMf8ur9WMK1wRwLbmQwtH+yaXisrPhTV7xbX?=
 =?us-ascii?Q?tOq4PuQRYXpi4Cgegpbwhr6o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Pl8md5EydC1CwnAxXKANW537HWgUDqb2Vs7HttaLZICulYpr6npAa0+ZrVb?=
 =?us-ascii?Q?0/ES6uocmtj7AcIbhrUW+4Om81T9Ak3Ckk+vWGHBbw0BovGhRV1eKfwh+GvB?=
 =?us-ascii?Q?iNaf+qLW3oOvJ2yYlo5VwrLrt8r1Gf/RW42od1tQs/jXXcqvYTgSMRMh48MT?=
 =?us-ascii?Q?WMOYGq0OIQisMOtRLrvGXOpMg8cQb/efzi8b8yxw8TRs2NtZyxObO4SbiG0p?=
 =?us-ascii?Q?KAc7MqPkRosE+l1lDMTbdSfmpl733KCAYv95pSksBYm8eY498naCyTq6YW9Q?=
 =?us-ascii?Q?ZGfg75MG8ntA2dAgGJynGiLK2YK1rhVfLrDWY2p3xlMd4ym3e7Hp5VZCdUFH?=
 =?us-ascii?Q?miRlAhRVjaGAgs5f5LDYuuSTZPC3dGxcgmQM/Kg5/XBUmssMOJIXdZiY2+JK?=
 =?us-ascii?Q?w9uDljzJN9IqTq+f+9W09/B/RUa2qnoVIvtKJ93GvRb/ksjeIhSSnTUmbuwp?=
 =?us-ascii?Q?DNU4Zxwih9Uj0Kp/w9Xa4+jD3/wE4ulfPjlyNGzL6c6zTSrFiFxdq+axrkTK?=
 =?us-ascii?Q?V+v4qIkCKLIhYK6KijGkW5JeHZ3Nq1aGJ9d547IBYToxsPdnAGRVio2EK8ZP?=
 =?us-ascii?Q?WCj5kR7ft3pRGwuprhIb8JMLN0Xjapw7Uwzt4b+eJRajPfJ5Qpt1zBA61r9y?=
 =?us-ascii?Q?lkt+cf3SMadZJOK1Tb86vFinnOK+STYeQft7y5753SmUw7MDjBrtJd5+4AaQ?=
 =?us-ascii?Q?1ZvJAKGz0i+nbcmueZkqtR0HLxiQHuFO6Ev6tqFNe/tl+4fUAzNfYeQz0R2v?=
 =?us-ascii?Q?fbmu33ZJakjJX/WkU/DBXU1FgT5S3ZO363s6IlFDrhtb+3KefKy4tHBGDzbp?=
 =?us-ascii?Q?SRmuowUgqzyPk4vOipm4MlhBDedKjB0KnSqMBq1WHaUOCRnQt9qCc6ECj4tV?=
 =?us-ascii?Q?9/L4BiG8upILtfZmnD45RrxbEMAAXIMEnHXQXjXY96VWe8T8kztREQl/VwFg?=
 =?us-ascii?Q?5SHS8YWlJB7VXHTQHY7ZD6HE1CiKqxezzbS6bm1Zn4w+nuAmnlr7T+F67U3z?=
 =?us-ascii?Q?rZBVz7zhHA4qI4B8N1bTkmek/i8H3CA2uC8xPdULvJWnfgNJrYgSGWNRoY1F?=
 =?us-ascii?Q?0JYkS4+nBHCDgg/HNQOziYTJh4+pNlQnJeEJc+YLihmZB1GXCYwhPjM8yX7V?=
 =?us-ascii?Q?RI+kE4psYceNuTargCOBgD7pJYNTKUkY2GzihcUsosmSvD9lNTyvbD5D2jV7?=
 =?us-ascii?Q?A8+oY32+kvy+KWAeJ4N/QkkAj8dgndZcleVSqGRlsxQTLZ7geddklGx4vjHK?=
 =?us-ascii?Q?zPs22n1AXiMj+cMWHjdhVJo4EZxe0p8/QqRE8Ua7ZMdBu8ig2ZMncb9L+VJ3?=
 =?us-ascii?Q?k9y8UZRfCC5fG8BBXACkFEMSy72NlD/VucRvjFigknp9PWsItmDWu+POf+sX?=
 =?us-ascii?Q?mkTHYYRMBFat/RAWtBwYSRmbp72ipG5pwtMeRK0rDJBiuDxHoJwRKgSE92iz?=
 =?us-ascii?Q?djoK2gvz9jilk4AQfYkF6KEUzNmCyEOB9AFVQMA5Iwu0L8nr3oGgnvi0U7or?=
 =?us-ascii?Q?I2XkUV/QHqLPApS55lwG7auua6BYrKiGK7WF2sXL/2Zq2bhOwEJFlQPmkmFk?=
 =?us-ascii?Q?/w6hpgcAldf77Oj8Ebzv2kM/aSHE8QR3Wq/HvlwaM+fSOgGdol80MNsqYbg6?=
 =?us-ascii?Q?j02dtwmgEsJIxU/40lqGaDFBxguZ8Q8sLEWrS+MAETQW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vs+y6fYEdHj5u8s5GqT8ACy8oolKRtQ+rK3In9O74B96IgIP0r123UKoSxDSMPJ3AiQWNBdCtouuOaWoebio/RI/KazLnS/AidSPxMGRqU1OuZMg7WhiSaC+F7GvzXpeg9piDOKw8fmDTwlD0pT6n3J21yYHlsvqs07VkznzufcNntmv264HzVQT7J71/GH6wbDhEH7eqf4T3Ed+vKEknmf61cZBFk6j01Ero6HLDC7NOFRV5AFYJnVkuofuz8SjMmCfS/yLajGLNuvvabf0KbUTuPPTtEQd0SKK7LGoJmG1kr/f9ILRNykxlXEQ5ybvupBBaDx0MAkfwQ4K7s0lHXm6+EhCI6vCKqR9VYKtBpP235OHyICGIMzfRMWZADY1isnuMROL/witiRZNb7o6Ync0yezbwDWZBUxBBrvrY2vvg+EM5QsCCUFCH65MP790VMFH/Ebz4LhNgKpNSv48oX10aTVVWKJd4+E+cPWtNoccbpM8BMAZ0NMr++Zjozl0QHfjUSNJ3MKNyKI8WGu2kYF4nTcckJvGmFfZ4s259Z+nMwLT7Ovdsxqn4vWh+IB/sisPhipRlm+tQYkMsrT5m4H2CcmgvZ0z6g3iy76HfwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1568faeb-9d07-45ae-ce2a-08dcf2e74632
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 22:17:11.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gINQjAHWYjcRvMCYo2uh73Vyhu88IMsC7jzXCAylJC0ZUDjvCgLVNRYxY/iNEBOdq27QEf/PbUn3QRUlp/OrYiG3h+U0EYSMBXfCrdgPbSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_23,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220144
X-Proofpoint-ORIG-GUID: g4vBHvU8UPkVueU7l3lwkosL8ndsqC-a
X-Proofpoint-GUID: g4vBHvU8UPkVueU7l3lwkosL8ndsqC-a

Alan Maguire <alan.maguire@oracle.com> writes:
> ...as this means we avoid seeing multiple messages of the form
>
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsa_NtCs2vSfyxKMEZc_4core4charNtB5_11EscapeDebugNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator3len57').

a beautiful variable name :P

> Such symbols are filtered anyway due to the __UNIQUE_ID prefix, so
> warning about them is not necessary; simply reordering the checks
> should ensure we will not see these warnings.
>
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Sorry I'm late to review. This is a good catch and is clearly correct
to me.

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

> ---
>  btf_encoder.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 5954238..e507e60 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2241,6 +2241,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		if (!name)
>  			continue;
>  
> +		if (filter_variable_name(name))
> +			continue;
> +
>  		/* Check for invalid BTF names */
>  		if (!btf_name_valid(name)) {
>  			dump_invalid_symbol("Found invalid variable name when encoding btf",
> @@ -2251,9 +2254,6 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  				return -1;
>  		}
>  
> -		if (filter_variable_name(name))
> -			continue;
> -
>  		if (var->ip.tag.type == 0) {
>  			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
>  				name, cu->name);
> -- 
> 2.43.5
