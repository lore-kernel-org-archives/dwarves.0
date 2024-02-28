Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5A158D60
	for <dwarves@vger.kernel.org>; Wed, 28 Feb 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128499; cv=fail; b=reRsmhu829H7VQgGVsi9ak2KbghiVrtYjj/wCGrNaiqSBJkxobzenKy3QUioYFyzqwEcedn4T69mE8lpAOt3R1vV9ipwEcN3aRM6qCxOOJUwEpgBEouYKTBWQIliy5Bjo/6uYoxuxdGG+Kci13upTvrXl1FxHp32IKGG8n3S6ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128499; c=relaxed/simple;
	bh=2bIJAmUAkWCjWavc9srUUqdYNi/KA80eZVyD+L4HBtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gB93eZYQwXh6RhclC1icFAjO5sDDLEt1OiOg/qN5aBqiLftHoIvLWZZgR6HsDVn1nN7hYyG9KObidocyEeoEPufiId00H9HVfYKozlcCXbdKEhHSk63ZrWVNKTLfa3F2I5pnT+b3OA4T0i097vmhXTZpZKmYwN8mSX7f9uDhTIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JbnS1AL5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=omZ2Xc5S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JbnS1AL5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="omZ2Xc5S"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S6kDKL017470;
	Wed, 28 Feb 2024 13:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8lZl3OwDnT6+AWp18RQweYrxmLOsXPOHhRriQogy84Y=;
 b=JbnS1AL58YR5pHCp8MWaHOXZfnhsok88TEWnFfHkBDilumyaoRlBg8xyfokw2YHNzqt9
 WbJJGmfRjTEbLf0eElOifwadnrnAt7i9ryGcGvXDbSVUs4T0PhzSK/W72rkTieBSYmxF
 sgePvQ3LoEdI79ZiS0GXoGrJ3P3dUI7KBYab+3YuwA63M+POlenpgSFg8aqL1rrYr2dX
 4v6GDgzAtbt4pDDRsK6lTaNS/Or7Y5fVJVjTgGVbsMXNOewGgAjwf1DzvLyG0LPkcjoC
 OJotNnlC6jP2kfOFeIdWOCxtmrK3ERZDXPykB3rDFksGhXQwNxEweZOQERdvc3Xzm5v7 aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccjb97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 13:54:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SDBSE1019133;
	Wed, 28 Feb 2024 13:54:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdmrnr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 13:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH1QPJ2AZd8maQVp/hQwPNNf48Lps7hUBZlSPmiBEHoJ07Puro8StHWkwIlFLRs8myl4HwgFJzjXcXo4YuuT8RlF4X50P1FAFUPxfx6d7CDLk05FQDOiEU7FlrxosW9Pa9dZU+5jDjbpmy68B+G2BbEN5qY8gqNLhzSnsxwnpVMCnyyH7qIx7fmI5Chg/QILGeV25ut+nE2QOywKL9lO0LeVv3GULRLFOP0IMQJ0oj+NJNu270sOHcTBOOBO0f1Xs+b7pv7pkAdYbRuwbELaTdkyaJfIEXCTSWT+cVB/l1c7N43GRwZFhYukDvDwtTgS5aHe60vy97Nd2icc0S02Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lZl3OwDnT6+AWp18RQweYrxmLOsXPOHhRriQogy84Y=;
 b=nbJwYIb+xNIKKXFx2zM4I4SZakgyqi5iAhFMYBCYYEduno6N96pkQVQPD5L08OUuBWe6oQYZtFYp3cEHu7kJyBdi00BIjqvOR9bkn/tr+oeo0I1MbvU1283hWm9MO/cAgMY0xd0T9k5/8PBJFGh6m/TKipGXK1ZfkHyuTtWsp5ax84ErpwbevUkpPMziUx+Pp7GfxfFZcHZQJYZOXHBYQGP6lII36jjnbzTg2L4N7OiUFbJYp7+FxJT2KUXzhLx/203iEmf3nDHCzMDIkn8a5tvhb4Qrj9cHh3tw/Od3z+cZ+o1erDL74HbiVZ0wU9QlfZ4R3GLN++a3C+ah4VpIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lZl3OwDnT6+AWp18RQweYrxmLOsXPOHhRriQogy84Y=;
 b=omZ2Xc5SlysPJT07tgXdad4ZWh3J26X7rHZotBLKgn7QzxIAfNoi7bYDkr9skBEjlWvfOLo0szD5E2gZeB7RGfiJORODU2EDj6oIP1iOB1YxCQ8wPaQFrdO6I8ehW4HOkQ4i1AAkuEJcRrut7udPSx+8O4D1NJy9FYYIdOxWp/s=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 13:54:32 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 13:54:32 +0000
Message-ID: <39f96bb5-5285-418f-a2b3-0142ffbea23a@oracle.com>
Date: Wed, 28 Feb 2024 13:54:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: HEADS UP: pahole 1.26 to be released soon
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Viktor Malik <vmalik@redhat.com>,
        dwarves@vger.kernel.org
References: <Zd3cooJ1HgnuC1aV@x1> <Zd7vJyjGjzmXW4R0@krava>
 <Zd8oR11yexremMWp@x1>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zd8oR11yexremMWp@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0445.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 35931619-5b54-40e8-afd7-08dc3864ca60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oCXozcY0nE6kp/dL5OtRc+Ta4KTkMF5l3dsCMldF95nwpnT2EL1pk4tXoZCRqNDqmDaGVgQDo/xvtsd1yXk7cIggREdHwNGZy+FHVO/TpEdQSnfMyFNQlcYzg+MvCdQfZp5AlkxHZ2dag6eiFyCq8whPbGiLfntzjCvgLgZEcXDCKCSOZ4mwC08ATHzGELCg06rOZAF6Wsl3CNpAOQ3MXIZI2aMbKvGuX4Wt7jBGt6CeLms6smS7ymfqPciRzrg9+jr1ewZuYhKEOfgh3vWyh05kKID7MiEUkiOZKRG4tD/dtJvAzir6gu/CI8lzKJO9tK7dTxKMmmYvldjxYygMfBRE0SzBzCV0zEZlA/W2iKEBfRe/N4DKdrgaDIMWWv1UMxdlhFaoaNg4QSp/dJ+d3HNFN22My41xyV12IU5vkmabcJ3IA0I6hGIISZ/jrnUocY8P128yCcGKvZUxQ0Bc2ght6we7otrhMfiAAEU5OMhpZ6hgXrrFdpv9vzz49hkfeckvYg7izYkkD70l3irrlcab1YVMziAYD5nKsZxktN0XpKOxrlSoDLdnCfHJlG7uh0dCLRy2VtBp6c0CUrWHwA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlE0a3hnL25BNTAvV0w4cEZDSk85Q0ZNZ2hZUGZCQlZHU1ZGbzFqOWkwNXR1?=
 =?utf-8?B?WFZCKzlmM3N1elBxOHB5UnJIbUo1MERrTmVLUzF6K04xRkVHc3h6RXdZWlBo?=
 =?utf-8?B?UkZiNjJ4TDVBN1hOMDBhWkhtOHV0ckkzZ1BCQ3plSnh5SEVBTWZGUEh4cGJ6?=
 =?utf-8?B?SGljanpvVzJrT0NNalE0MnBkZkdqN1BnZmlOTUF1cmdTOGRJU2ZtRUFPUUpy?=
 =?utf-8?B?aHFBa2swaE5ob0xFZFF0cjdiNGRyNmtSYkI2M2ZNM3hsKzlpQnJTYjU0UFQ2?=
 =?utf-8?B?M1U1RWw5VlhkUXErVzRTZVNWZ0NncHFUNmhKZFdHVXd2eVFmdCt4WHhJaVha?=
 =?utf-8?B?OE1RcHZVWUZxVm8yazFuQkZoRGxmOXlzWDYyb0xnMy9sRmY0RDd2ZklPdmZv?=
 =?utf-8?B?NGZydmFKcUQvS3dtMW93TjBEcFpFTzdEVnAvVWwzcFZtbkM1NzVsdERZaUQw?=
 =?utf-8?B?dXhlc2s5bXlFMk44VFdQMTlFZ3phZzEvU3d1c0NDRXlHNEEzSEhudWJVWWxy?=
 =?utf-8?B?NjlGRHVrRmEwK0RqTW9SL3NGZEU4SStFNnRERHFsZUdpOWMzbjRsSUhkdGtv?=
 =?utf-8?B?dU41YUpsdkE5bHFBQ1MxZnhMZld2dyttY2Q1Vmh6aThiRStvaUhzWTZPU29K?=
 =?utf-8?B?SmVuWE5VNGNBa2VpVUc1aXp2bW5LUzFBcEJlY21GTmZwbGM4VVNRMmZUb3Z5?=
 =?utf-8?B?TnpUV1AyMzZGeGpLdXZpbzlFTzJwRkNYYXNJbnNmeWllTWovZ1pPcTJ0UEtW?=
 =?utf-8?B?R3lzRzh5MnVndkhOeDcrNUVBS3R3M2gzaHpwMmNaYk5PZDVvZzF4NGlPMDJ5?=
 =?utf-8?B?WW9YN29yVlU3eGdubVpFZFcwK2xxcnJwdURWUmM2SGJZNjEyUmVaTTd0aFM0?=
 =?utf-8?B?cHZ3akNFMUU3QXB2bHJ5SlVTM1loUkUzOVBySHNlSnFsWEJCZlV5c1p1OE1B?=
 =?utf-8?B?SWptS1ZvYngvbUExNElPWGlhclYwSTY3cjhETkxXSjdSWDB2MjVoaEVkeTRD?=
 =?utf-8?B?T2xYWmQzbTZrZk5PQ0Z2U05GYVdPeExjZUJ2eVFveGtsMFZxV3ovN09DY2Fr?=
 =?utf-8?B?Vy96K1Z4VVZVMlZoN0VWc05SR2ZrN2lGMjlpaWV4eHdyc0lUcVArZm9lbHBs?=
 =?utf-8?B?Y0dyWDJqVDFLeVV2OHlMMnZDTlp3NE5CSkpuZVJFRTNCM0FJQ2d3RXdoZzJM?=
 =?utf-8?B?S3VrV3h6SlBxZG93OUpIV3ozVE80d0VkcVFQcW5XbThmN2hCUFM0Y3FZVzdu?=
 =?utf-8?B?S2lpS2NhZVNxeWV6R1A0TW9qaGxoWHVKVEE4d3Iwa1JjaWUrRmpxS1NyYk0r?=
 =?utf-8?B?WXVSTE5tNm1mektEWk1QM1VmbkwrSnoyV0QvajdXdmhmVXBMamJ3YzkzenZo?=
 =?utf-8?B?bWZsMDVjTnZvc0JOSVZrOHRUbEtodzJIcDYvdk5HNFBFNW1Oa1pYd05tazFB?=
 =?utf-8?B?WWRFNVVUT2U2RjE5M2NCdnhJSTZJYm8wb2NtbWFOZGt2NXVXV2F0dGQ1dmEy?=
 =?utf-8?B?eWpiQXF6NkZ5U2NNZDY4OGZzU2hIa2x3ZVBPc21KVXowTTVybU9wY2RWc1Mx?=
 =?utf-8?B?SWFRSUtERDRVeElVUFBJZURFVkdwUy8zSFlIZGxpZE1BTWwyMTR4ajJRVkkw?=
 =?utf-8?B?Z0tlUS91Z0MyTU9OUEE3TGd6VXZvNkVOM0xGMHJEYUpabTdGbkRtNkphS0hR?=
 =?utf-8?B?WEZtZFlKcGRYQmxIQ2hCSUlVWURIVGNicmt5VVJBS0dEbzlSU3FEdElHdi9u?=
 =?utf-8?B?N3o5WHp0RG5BMjZWL1VqV0djcjFVTDBxTUdQdlV5My9XRmRpQnk4eUw4NndE?=
 =?utf-8?B?dStPWjJMMGVCZ2d0LytOaFp5QkdiRGJZbjdoMzBXT0tUNU9sV2QwaXkyN3V0?=
 =?utf-8?B?eHlxYzNBSFV6TWE4dkk0TzVCWTEyUUhDVC9aeVJsS01MVW53dlNUL1YwWTNm?=
 =?utf-8?B?SWljeTd2VlpYOHpGT1IzZXpJakdXTlIzcWJla2tRYmJVd2JEbGhVYmJ2cW5h?=
 =?utf-8?B?N2Z1Z1hZaThkTzIwTzNhNTc4UmE3d243WDhVNlQwRjhzN2NRalNMVmNtZk1Z?=
 =?utf-8?B?MDVsUWt2N1QxVTd4eStka01iVGlIb0RtbXBYanJ2WUw3L0tQZUVybHRjMHBw?=
 =?utf-8?B?VDF5M0E1UGFsbXd6U1ZBMFIrcHVQRXEva25RU2ZmeHg4K1U4Qm1hSkFZY3RB?=
 =?utf-8?Q?WpqClAvJG1XqV/G3iIPE7l0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	e5w/GhO6w37jOeoUvx164Of47BDZb4MPuoOzYHe0Ntgf5fHIMa+LJIiUaN5iFIQBxx7G4fwS3a4QmRLs9qQdzr7fdg/zO0XyZGPTqqd+ZRsPoSQykwgzu7TOr2MwEm31kRWp57oBjnzH8EO4QjUBxvD+RVvlSO7W0yOiKmaIAF3TpjfwjJPP8h1FGIuOyapj7pWTFN4VC5ycnrcF3gqtmUX1SF6Ckqg0eO0M+8lcHoeTBB5x2i85EMfAhURYpbAt037EzB4ITmTRzd4bdkqP2SoSXyHFT1eqq5CkTl12OBo4aAmt8u/WulIypoZ29TOrldArsH7kVXHEvBMDaz5T3Vpk2Xfljdir0bJDuoVZscyoAQZQd9zRx1rK9hijeYvCfZ7YrW39ULRTulH7bfvNlq7+MRSVP1pVkDtlzZZqfy/kGd+EZ+9qTiRSvMxxpBNfMIH6Im2lVnKZ/RJxhAezWakdWqJEROS9qETNEaVGnAdkWVSOxqAAmkb4iE3lH+iDUBU0pJQ0d73PCjkicvJc+KHmTy03HNcR15//YGpRo0hAdhO5dtwrxhLbiLDsmrDoVL/HXM5bN0ibzicoNTi31CSzPq/1yywnv0h4qRU3QHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35931619-5b54-40e8-afd7-08dc3864ca60
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:54:32.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2prW2iIMkaUWznyubfOeFt2vb1GqO6VJgivaeWTih8PvyURJfipUojXiPH92AFCyx9Re5zMURJ58W7Bw21tB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280110
X-Proofpoint-ORIG-GUID: f4kZJ9nLZmiap2xg0H9-LAcHjhcsKC-4
X-Proofpoint-GUID: f4kZJ9nLZmiap2xg0H9-LAcHjhcsKC-4

On 28/02/2024 12:34, Arnaldo Carvalho de Melo wrote:
> On Wed, Feb 28, 2024 at 09:30:31AM +0100, Jiri Olsa wrote:
>> On Tue, Feb 27, 2024 at 09:59:14AM -0300, Arnaldo Carvalho de Melo wrote:
>>> 	If you have time, please do some tests and report results.
>>> 	You can find it in the usual places:
>>> git://git.kernel.org/pub/scm/devel/pahole/pahole.git
>>> https://github.com/acmel/dwarves.git
>>> 	In the master branch.
>  
>> hi,
>> tested on top of my setup and it looks good
> 
> Thanks!
>  

Ditto here; tested on x86_64 and aarch64, all looks good.

>> I hoped the kfuncs decl tag would get in, but AFAICS there was
>> no new version of the patches.. I'll ping Daniel about that
> 
> There is this global variables case that is being discussed, the kfuncs
> and I hope to do some work on .dwz, merging what I have at:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=alt_dwarf
> 
> So I think I'll go ahead and release 1.26 today and work on merging
> these other features to have 1.27 in the near future.
> 

Sounds great, thanks! I've been looking into reducing the memory
footprint during pahole operation, but don't have anything ready yet I'm
afraid. I can post a bpf-next patch to switch to using --btf_features
for v1.26 and later; might make Daniel's job a bit easier when adding
the kfunc stuff.

Alan
> - Arnaldo
> 
