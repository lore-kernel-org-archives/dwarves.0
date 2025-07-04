Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372FE2D838D
	for <dwarves@vger.kernel.org>; Fri,  4 Jul 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647251; cv=fail; b=WTM34DQdqO5T7b2OtwfAt3dtPVUSI3vfhkoes41OQdgSGnPPGrkYRgJyPTXEYEJMuVQ9seSqI1+HGTJOOVGmsMFF5I6rbOF40TJv84MdgWaCX1Rm82HIGIfVnIoTXROhxoRe0U04Mq6Rq+pPcy5PCNf1iZ1iYX54w8gX+TgEtmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647251; c=relaxed/simple;
	bh=DS+BSH3bhoYjTxqjPTds4PxXuj/xjowM5tXWeqriMUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m546FbjGM+FtP+wF59D0R1AdZDQNKTkvBDK5FfVccvmOfp4EBraJkJ31w5P7yNA5/BhOBgUEtfPMExKwVeBi6PD+wVKTH7vI53uya4+FxcKVL0/ZA2SaqcEhIHVMvsX1EqXqwOEZPN4HaS3/LdRlPncE5ypzR0zTn3y17AiOQi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bvE3Wv6/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TARki757; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bvE3Wv6/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TARki757"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649YvRd032659;
	Fri, 4 Jul 2025 16:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zwvoBtsgiX/6wGayYqOGcrTe2fucjJMJMGL1ZlscYGQ=; b=
	bvE3Wv6/YOjMRvh//Yz0iBzXQfFyJjfwozUowNx+0x5Yxrw5nWDx1dhE72krs5jb
	T1usgrn5giVDXFtr5JwR9gwrJ8IpKoxxKa1i+xfLxQnug72uqOecip/OoSnvPa9A
	B/2+MyINVEbf+ar3m0ApPaSrfHzmV1X+sUZrPWzvnaP4fvBCWy1Bvocu69JFC221
	7UCvNEVsbuP/Qklxv1kPzQFm8d613ZefxnW3XJI4IkoTITx1JrMCJQkwYWXvN6AK
	A1eCYGDENdpYu4slSsqAIlBpWQ74sEG+czKE9S9dy6G3Ytvhc92lxZIRCg+tp52M
	kMGviQXjPglrpyk+Z4XHXQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7afb1cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 16:40:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 564EA84e032507;
	Fri, 4 Jul 2025 16:40:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6un8m5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 16:40:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPs/NG9UueVocAhOVYmNh6/Ytl8Mv7YjArk/V4uxwuEEBEPcMdsXthkWEEbCnhhlIIbG3EjvkW4qQ5Ve6rXSj05bKPhbvfODnRspMWpd7NZTGtdRh0TDWOwBIWMYfdqYt6oE092hay4pjIsgc3kIaUXjwSyXWhjEQykXohAw0guu0YzwU5T6e3eiS0aukgqqLXcvhpuQ7+cRFiaVUGf9Vjv3lM9McogX8tH8qsUDOzZYGPxKd4grQkacA82B5lg0uOT46Kx+1UuicvWjAPQIbgEhsJSzRZV2aEy+4guOYe4o/Js7+MMCn+Ist2mJMdDhlyuPtB1Mc6VKASTrIYisAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwvoBtsgiX/6wGayYqOGcrTe2fucjJMJMGL1ZlscYGQ=;
 b=SEWUsUyjv125a2U9eR31JDF4NCw7GtKMP8A4b3u4M7RmmvxVa27PAUgKDXePWfYA5wM6lF8F+zNzLnKEum4mqTM25ltETNB83bN4TQd6j/QfZhF3UqXFKEuUTDd4SQ6zUDweqfXYIjgr4hvJhcJMCu/51nQuh5AZmkwBwnww9+Rrpm/3f9XWqWsSEL5un2hxzvn/1LNnddD14andKXXBpS5LmdDYR26u7WpcanW6eNhUD6gWRk2Gp34/PGE/Y7UOGCt4dE8pv4HPGkOkrAo9OhW14hFum00K0ojv0rCXbh8DRHcD7DeJ3O4SFYPTBOIL8bxArpyKANmGsFiwC66QoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwvoBtsgiX/6wGayYqOGcrTe2fucjJMJMGL1ZlscYGQ=;
 b=TARki757NLaXFfSqgkqblvhdKQgLt3mHJGnx6MB6TvObR8bKP9Z2i4ebMUlrjF52yCgYDf3qJ6Nk/6i3g5VWpqooHkIYRAxgidVRkoQlC7h5CYAllcrOYWzuXYHa7R4yFrUXl7I9ozMHD8vc3x5UFvaisV1yO/JqWrwzvEPupcY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ5PPFCAF322559.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 4 Jul
 2025 16:40:40 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 16:40:40 +0000
Message-ID: <fde12a46-2e23-4de4-970c-d272b3bd02bf@oracle.com>
Date: Fri, 4 Jul 2025 17:40:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btf_loader: fix smallest offset in case of bitfields
To: Antoine Tenart <atenart@kernel.org>, dwarves@vger.kernel.org
Cc: pvalerio@redhat.com
References: <20250625152329.28601-1-atenart@kernel.org>
 <20250625152329.28601-3-atenart@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250625152329.28601-3-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::16) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ5PPFCAF322559:EE_
X-MS-Office365-Filtering-Correlation-Id: 281e5601-fb82-437f-3c08-08ddbb198330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWdHdTN3SzV3UHVDVTVWWUw1cG5Kd0kyZFFZNkZkY3dPSEVjOWo1cldhQzVw?=
 =?utf-8?B?bXFuMFltN0NJSXhTSnV3aWxBcjdhUVJ0MmlENkR3WXZJdDFXdlRMSUJ1aTFa?=
 =?utf-8?B?ZGkvSGdWUVhZWC9ETmJYdk1QRlZjSHg2WCtpQnFJYnBKVTVVNU9DRVpKdHQw?=
 =?utf-8?B?Y1pqVXcxOWR3ei9GczFFY2NKVExNdFowWCtwTkc1UzZpSkxDK2M1Zlc2RW0y?=
 =?utf-8?B?ckVWempTTHJVeDFubUZCWlhjWXkxMmtVYU1ZSkkvaTF2QmR6RERabHRzN2Q5?=
 =?utf-8?B?RW5MYUlYNnkvQVdQL29YeEphcCtCYnNqN2ErZ0t6eVBYWlVRMUQ1eHZIMGNN?=
 =?utf-8?B?U3lzc2pmME1KVGtzUGtiWTJkRk85K01Sam9SWWZWUjh1Y044aTg1eWkrYkJD?=
 =?utf-8?B?a3ZJTzBJdVRJdGJxQ29CaWVwWlJjeEJhbHJRVFBHZWNaRFFlNTdiWEZPUU9B?=
 =?utf-8?B?VWV4aXppUkJicDI5Sytta0lPU1kwQncraTFSSUJyTEdBWEVua0FmNEU4K3Zo?=
 =?utf-8?B?OGtKZ2pDM3FiS2tmcWxoa2xTM1AzTFUzWkxJU2ZqNW5JVC9mUnJtd3VaSHhK?=
 =?utf-8?B?bjQwSmpSQi95VC9oeVZyV093d2o3SVJDZ2ZOU2laSnNwajNyUXV3MjhWWllU?=
 =?utf-8?B?NFVBRk5GNUlwemhaT29VdHJZS1d3UHNrSmRoeDNuUTVFZm9SMVBKcFNXa1JT?=
 =?utf-8?B?TitQL1E0M20xUEZuS0JRWnJtRzROemVBQ2ViekZ5Q2MvNnBOclhIbjhiWEJZ?=
 =?utf-8?B?UFJoR0hVK3BaSHZhd2N4Y0FCVDBmTDgvRG8yZHpwNlNIdmM3MUUwU21IR3BE?=
 =?utf-8?B?UUJmWFJXeVhxaTNJRERXUTZVR1RONGNhREoyb3d5cGgxSm9aMFdOcmIyMmVs?=
 =?utf-8?B?eG9DQm5mNE1zSDBla2dzRXdJSkorNzY1dWk4NmpsWFI4eGtVU3Y0WHJpNnFm?=
 =?utf-8?B?ZnVuWmdKTGpkWEt3SlZKU1BiS2sxTElPblpaWk1GRGx2aTdLemJacGRrbS9D?=
 =?utf-8?B?NXZhQ1hZWFY4dkU1d01nVnBjRDdwRzJLY2lHTGdOemlJZ1dWd2NtUTRSVEZk?=
 =?utf-8?B?bExIT0pLTHNRRy9DdGlhck9Uemo3Q3Y3NXdjcUhPOWQxWGE1Vlhvd1lHKzNz?=
 =?utf-8?B?c3R4dkZVRGVZOW11SDlzRUxpV3ErMkVPOXRNSjhUaUZ0RHp4d2EvMHhBRlFy?=
 =?utf-8?B?RHBsams4SW5Md3hmdTlncktlaWNMS0FGRFQvZGtzRTNxN2o4a2pWODNjSlZO?=
 =?utf-8?B?aHZsUjJ3dU1yZlZHa0tRSDZEa0NOaUZ2WlU2REVtWFdRTy9JZkpyVkI3SkVu?=
 =?utf-8?B?cWJ1bnJQVnlVcFpVSXkvWjBsTWxtSU9QZVZWSExOWkZ5eFladlhJbFIwQ05k?=
 =?utf-8?B?UVFudVZ1a1ZFc1Fqc0s1a1hFWjJ1anJNZ29wb3huOXVxa2wwdDR2MGlNa0tY?=
 =?utf-8?B?VVYyVWFTOGpxeGJLaFIrb2ZPSnIzQ3Bmck03T1gvTFJkNk5QMkMrQWMvMjAx?=
 =?utf-8?B?SVhMd0dTTVFncTZuYUdCRGU4RHl2eUJ3YkFEVThoTFJrQ2UvUUtFVWVyemZz?=
 =?utf-8?B?RXhLbnI3QUFTbUhsQVZNNC92SGFmZEFXWUhMaU5uYnNCOUZ4UFEyY1hPN0x3?=
 =?utf-8?B?UHBRenMyeC9sWHlUaGlUdTBUc1JNb29wekpmK1A1MkRVOHc2SlY4VTFWMi9p?=
 =?utf-8?B?c2Y1OVBLSWpEMzRTSWQ4cFFQOGtNUGtVMU5Wa3pVSytRUXJ4emxVcElkSVR4?=
 =?utf-8?B?UUpLQU4xZVpTejY3NWx0VEFWemNpeFp3SURyb2xOdWtxQ1F0Z3R2a0pEdUwv?=
 =?utf-8?B?ZW9RZDVmSnVDdGRQeW15Qzd5aTBLMzB3R04wejZqcWFDaWJ2a3VOTjZHQXly?=
 =?utf-8?B?K2Fhd3J4bkFoZVc3U3puTFovL0ZKeU5UQ1B6QWUyVm1kVUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWY5QlZ3N3o2dFArYUExdGphNDVLYjlybHpDREpmV05NNlgwSlZtemk5MmQw?=
 =?utf-8?B?TEF3RTZZRkR6YkQvdEN0YUozYUVzNS96aGlMRGVMZE5XM054QXVPQ2Y0dStt?=
 =?utf-8?B?SkptTkg1Q0QvU3FOZ3kzdjVTOVBwTmpmYlJXN0JwOVFKSkFGa1ArRU93dUVi?=
 =?utf-8?B?UC9DR1FjSmxhQmFqbWpEb2RPbG5rL2VTaUhneThWeWQvRU5xSEdCSjhJYlZy?=
 =?utf-8?B?MklIRmZrQlF4c1Z6N3NxUVlTMlBBVGE2SE9HMEh3Q0FuZ3NiNkFqMmExdHNY?=
 =?utf-8?B?UVZLSndROEpVaU9FU2tlTVgvTFExazJGRUc2ZjlPdXJpWlYyOTROb1dRVFEr?=
 =?utf-8?B?TlNXbExwNUdYT1NqbXJmWWhnelFYY2NsTWJyV0prUjI0aHFCNlFLL3VHZnhW?=
 =?utf-8?B?NTVIMDFPQ3B4YW84dE5KNDIxKzBqUlFrVkViRkJaTG1uTUxpMkhCWHdiazY5?=
 =?utf-8?B?TTdqYm9ETVdLWFovRjUyY2tGNTNMVG5WazZZRlArNmlVUk1jOGtYeUd6VzFE?=
 =?utf-8?B?UHZRZ0NTeDBtNjIrUWJnN0lVRHh0RUlqWmdsdVh4RXFUODlNUzdzNzJUOHVo?=
 =?utf-8?B?L0h5SGJTdXZNdEpIbVBWb2dSbEFqSzZ4Tlo1WGsyK0VxZFhjRU93YkxoNVlP?=
 =?utf-8?B?ZCthb1g0L2JtRU5FUExhcm1vUjZDWlR1a3hNZmppZGZhMDF2Z0c2aFI3VG5Y?=
 =?utf-8?B?V0t6VzV5VWkxcVQ0bVFkZExGQVJpc0JhcFF2L2FCTmtPUHlQaHRjMVE3VEta?=
 =?utf-8?B?aTZKd24zRmo5Y2xXZ2EwWUY0bGpINzNaK2RzdW91eCtXYStMb3c4eGJucW5a?=
 =?utf-8?B?dks1em04aXhEanJWTVNGYkQ2RVB1MFJTbDc5eGx5OUplWTFZaTg2SC9DSjZ2?=
 =?utf-8?B?L0pBZlU1MWtFWHozOWVrT3grNE9RY0VsbkVpNHpuNVFvMHNwZVpCMUpickl2?=
 =?utf-8?B?MnZsY2YvWkpzWjFkQUJlN2lMZmtaT3dZNTFmMkNhZktLZnFzc1VIRGxlRnZz?=
 =?utf-8?B?dUtZV0xCdUgyaEVlN0tIbnEzSGZqdjE4TWN1a3RNTmRxLzhTdUlWQlFYMmh5?=
 =?utf-8?B?ZlVrY0pDdmRnMG1idjF3MHZkVzU0MUFvVm93bWRCMWFGZWZocityZ3gzMUU2?=
 =?utf-8?B?dG1xaDdTN2FlTnQ3dHlTOVFDSDhFQU5rQ1c4THVFaHRNSGtjUUpuQU5tV3Vy?=
 =?utf-8?B?ZU4zSTVLaklydWlFSFk4SnlVV2pzL25lclhpY2VMcXNQNDdsdHZZQUdwaGww?=
 =?utf-8?B?YjMrQkFBQWx2NE5ZeEdidXNXWEdBUmI2NFJEUWMrS29rQXhBZUUvL2NzZDZW?=
 =?utf-8?B?cmdjZU5FLzM4aGtsTWdUbkI4SkZ6YlhOZjN4Q2tsUTVsd1JMWXdmVm51UmFx?=
 =?utf-8?B?ZFRmVElkT3pqa2ZFVFhqd3A0amtWWExaelcvSDRTb25relc2cjgwajJGZUVR?=
 =?utf-8?B?bnRRRGZqbXpnWC9WMDJuVFZhU0hneFVZUzJyL0JoSUhVOEdwWDNlSUFvSVBz?=
 =?utf-8?B?V1Q4alIyQVZyNkhnQlgvSThNZi9UcUZSL2orRlNEOUMwM2R6RWd2dGlpdndC?=
 =?utf-8?B?aU9nR0t3cmdPTmo4TDNjRWt5U3BabDVKSVVUaWVUZk5RWWJkdzlZa040c0ZW?=
 =?utf-8?B?RFNrOTh4VXl6SVVNcFJ2VTU0R1QveEtpSS91REZVRCtBZUFzNXRVZ1NsemNU?=
 =?utf-8?B?SE42ZU9BVGhYVlpmK1REWTF6MTU5eFRkWVFPNU5hNXl2UENtNU50TkJHaHFo?=
 =?utf-8?B?Qk90NnkreVpMcSthRWNXb2Q1QjhXY1BucjZPS2N4RFc2OGFFS1R6MXg1MWQz?=
 =?utf-8?B?U05qVDlTaDVvblVMWHhDY2RLR2VwNjFJNWw5RWltMkdvZC84S0oyZlAyY2Vu?=
 =?utf-8?B?bXpPTWxlL2FwZWVObFM0a0h4TnJMY3BoeEpCWTN4UVdidGhHUVI3NWFCRm9C?=
 =?utf-8?B?L0hmc3dXYWJVc2tnZEMyb29yM3VTRFFpY1RaRkJEUHBVV3hMRndCT2kxOFUr?=
 =?utf-8?B?cUZtSDBHL0dsaDdiMk5JU1dlUEFaaldDWDExRjZ0OGlIdHFFWlZZV0JrR0ZE?=
 =?utf-8?B?NElLVUVIUmRHRVZCdzFMNGk4ZndSK2U2NEp6VlBVSlk1SGtQL1ZsRXhDZ3BW?=
 =?utf-8?B?ckJFMUdmTDE2QVA5K1N6U1dweE8xVDE2azVGYWxPSU5Tc0FqYlJydG9TVmow?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7/th1zSeIJzmFkJ6QbIgaiPbHgd6BCYtvXEz4eBA5P0zWdegt4g+ps+AF4V2DtcGI1nRF9hNaGt3N7xv+tenaEcs6QQI7gT6eVzNsGArEG4juOXunX0Ewgj13k4lRSox5lxjCoddN2ZCgPx7gcfEVXS6ivj0LtSM17M52lfkgR0F5jymNVRricCnBLp6rUn0O93ttb31EiYGYtDP3OD1fc2n0BO3avvl+uBJioO8AR9aXjNYEwa9+tUyq0usj1OK5jX5Ud9cXO/J0ZJyCOyNj6Odt6u1i04Se/LCGt+Rc6k/aWnkcM5Io2ezGz59G4CsNmWiE8f+twVqsjGLoUyjLJP18ThxjRUHcWIEb5qkboNuv0NlYi91sSTge5b/0JbgIOA8WqzF7DaYyUzhs3AkwYvnw8GunxAv37IVRMm9kijiR6VUeTMZvL2DUDyxImZYDXHG0D5m3YJLAgMiXn5wXnofAalS+ZeiUcf1w3NY7PIVxvjeqcnboOX5isJEYh+Kv8UX0qmat/kT3hWgCh3sYMMW/CltbGPVErDY8SIEU1KalEqzrhEMergH7EOfTELBohNXHNifgLTZRZy4t8Ey/vvAPR9u+HJo2i3EXGL8dBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281e5601-fb82-437f-3c08-08ddbb198330
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 16:40:40.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckZftuTsEntDzFBdHfmwuBIW6Ke0KVecAKh/2xskpYsZsIGbQBu2lh/ksUuOUXQd1JQfbhguXXTfDjmy6FSieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCAF322559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507040126
X-Proofpoint-ORIG-GUID: H_p927nZXiTCWTJzctRm1uEzket4QEDG
X-Proofpoint-GUID: H_p927nZXiTCWTJzctRm1uEzket4QEDG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfX8o7bqVBahd8K c58XxdVBDLqNuyfoH7cSa1sYscPmCUJ7IpHpWd5FYxsN6tRenzrV3jpB8kIqP5caBesC1PRiGFP JfiddSiKd4dXGcvT8DfUGNyqQ4RwGSMHZndrR+HgiJctedfgKVeJkcKH4UM0BZmCp6/p6mNR+9i
 D1ElyhgV/9TiTZ4S4cwt0to1P0GNgM3BCNlFBl0yELEyWEPTKFe2T48Jwz56h44lL92pvn8TW4z mfyOhHtGoAJv32H+NW+b71O5taPm5qd1eY/QOLSDDtgqC2ePWieFbsRFBjg1L+PoTCtY3oDvpVw GTBb3eyBMoRWQxbhJtzo+7wunxaYjTj8awxiQ4ZFos/dOBoyX5+7MEVtcdT+4awrvxt/2Vtxw1w
 //BpezS9dKtKDMhCR1s8CXvWxzzmyO6UdGQNK59KVBK+V8fcgwyEipAIZDlYX8C4Clz/w5yi
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6868040d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=rfTbxAI769rN06FQV2UA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12057

On 25/06/2025 16:23, Antoine Tenart wrote:
> In case the member is a bitfield, using pos->byte_size can be misleading
> as it can be larger than the actual size. In such case we could miss an
> actual hole in the struct and not infer the alignment as expected.
> 
> Before this patch we can see:
> 
>   $ pahole nf_tables.btf -C nft_rule_dp
>   struct nft_rule_dp {
>   	u64                        is_last:1;            /*     0: 0  8 */
>   	u64                        dlen:12;              /*     0: 1  8 */
>   	u64                        handle:42;            /*     0:13  8 */
> 
>   	/* XXX 9 bits hole, try to pack */
> 
>   	unsigned char              data[];               /*     8     0 */
> 
>   	/* size: 8, cachelines: 1, members: 4 */
>   	/* sum bitfield members: 55 bits, bit holes: 1, sum bit holes: 9 bits */
>   	/* last cacheline: 8 bytes */
>   };
> 
>   offsetof(struct nft_rule_dp, data) returns 7.
> 
> Where `data` won't be aligned as expected, as the first member fits on
> the byte left after the bitfield.
> 
> After this patch we get:
> 
>   $ pahole nf_tables.btf -C nft_rule_dp
>   struct nft_rule_dp {
>   	u64                        is_last:1;            /*     0: 0  8 */
>   	u64                        dlen:12;              /*     0: 1  8 */
>   	u64                        handle:42;            /*     0:13  8 */
> 
>   	/* XXX 9 bits hole, try to pack */
> 
>   	unsigned char              data[] __attribute__((__aligned__(2))); /*     8     0 */
> 
>   	/* size: 8, cachelines: 1, members: 4 */
>   	/* sum bitfield members: 55 bits, bit holes: 1, sum bit holes: 9 bits */
>   	/* forced alignments: 1 */
>   	/* last cacheline: 8 bytes */
>   };
> 
>   offsetof(struct nft_rule_dp, data) returns 8.
> 
> Thanks to Paolo Valerio for helping, including narrowing down where the
> issue was (BTF decoder).
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_loader.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index 76771afedd95..3beb5bba5f94 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -676,7 +676,10 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
>  							pos->byte_offset,
>  							tag__natural_alignment(type, cu),
>  							smallest_offset);
> -		smallest_offset = pos->byte_offset + pos->byte_size;
> +		smallest_offset = pos->byte_offset;
> +		smallest_offset += pos->bitfield_size ?
> +			(pos->bitfield_offset + pos->bitfield_size + 7) / 8 :
> +			pos->byte_size;


would be good to have a comment here explaining the situation too; it's
quite a subtle problem so anything that helps explain things would be
great. Thanks for tracking this down!

>  	}
>  
>  	tag_type->alignment = class__infer_alignment(conf,

