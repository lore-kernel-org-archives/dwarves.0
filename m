Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43C7DA66;
	Fri, 20 Sep 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820311; cv=fail; b=E4uKfF8tynGyFfZORiy9Yi5XcNzQn3LHEpP1QP/GE1oLDuZboWZZCH3qiKdTwGmCrpk5wsKjzzgORza1YtdQ4bJvKtighcmTWrCknL1fQ70LOha4jtEYmgtz5HErsFJiPBuJvXcOuZ3Zaxb0gS5nSo5T0U/s9oOTJ5oAot4BEJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820311; c=relaxed/simple;
	bh=tqQz2XweIFZk/qP/pygzI1XououiC1RE3UTSAVZK6rY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=EPQNuKqtLEZRD1OMpRgunR0FHPwOBX4/r4aQQLVKlAdncJY7ToSLEF83NQioQZT1cQUuAiMkGZPW+DOZ7IehYPr6vBuY4ebStyZSw2plNsi1ihL6cK8ioQO2iYZWeVjLjN/jxNeRgCT1YwxcuEwGEU8sNEQNqCVotrPqIXWZY4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b3orR1MH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PitJOpVL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b3orR1MH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PitJOpVL"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7tcWj019541;
	Fri, 20 Sep 2024 08:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=AjbI0laFwb2DG+
	L2JmSD1x9vU0HAhyseB2jAVPbDbPY=; b=b3orR1MH1QNljcbT3u0NB/kKWhA/Cl
	YnBShWcM3cwB4GqulEK8as9PNBvzw8l/XRojeWSYqMAt8W+xoaqC9qmGM+LZL5Z1
	3D/HJ4gap4DBtPKPFzcJCrNySIVhQ877fX80ilONIGVYpVzfKM8t9m7qYNsMp5OV
	cdjR3A0sBnRszz4bMVZkxG7dBRLQ4KoHrLlQ0bKn1j5nbL6KZUsI/fcTT65t/UpI
	E+3j0nJwaGwdNI/GX1D5vTfwy6gTxJ5YVMwGJMSMTp+wi1QfdofzxT956jbpJwJd
	QFw9hAykrPwtBTVz6NK9pgebRWWcTZKSicjErFm3rmaJAD6r2LsevfDQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdwtbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:18:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7aqN0010478;
	Fri, 20 Sep 2024 08:18:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nybatb7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=th/qmAAFL/blRqnFdY4aN9OaS82YsiwQCBHZJzkOGpGHAj02P1NtcdPpjBcnvkM16f+9Jiq3VXqG03/KeKF/Av8MgYVLAjDRhEf8eGY3HcpgvzEOvvCRGDkSiaLwk5iolvkxcl9gmaCdDitjQoL5XYQwhWAkVN+c+oxpA/vxIK3YVSitPGqZpA/XD4qvrezq1FwIWZNeVkYqZkWXMQvPq7nwp7+dLvxCz3grBysNd2kZYe5hC/+PV9lG++3qTbLTs1irXFRXSQaENgsyBct7raHfFXx41Vxh4A7Hj2MhTvsKtcXU8x0URNLX6X8Mn2BuamR3aLoaky0lcA3SWwSfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjbI0laFwb2DG+L2JmSD1x9vU0HAhyseB2jAVPbDbPY=;
 b=ebwena+/a+MYvsKXLls5kdppP8AZCjP6aqw0rozzqWO985+bqE+amjcfBlxUPEAowaCnt5UjRKJUC477Q1oIGXGXZRKs+LCf1JA4i5UJbzhyO1awKltVXkyC457MVzxmGgyG1rXN6B+Xxm61BluYKd0JVUuQlGzgOVb6TjBqiTpGhVwNZgHAwNMkKTzQxA1J94X+sPoBjhrk8PjmPLpkKvVwLlrtYaMYCR0OOBpU5hKNUSUtm2WcW2EGgY5Y73Ly5+SnxA4DOIFayLJjiI18tDzDXwo0+vZ0GI1fsa9BYWxcgyIgrKbfCnKY3Ab2NiZ0nU/h2bsM83+BEsw0zzOx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjbI0laFwb2DG+L2JmSD1x9vU0HAhyseB2jAVPbDbPY=;
 b=PitJOpVLHDdyfyyidfd+BJRqXgjiMupZgTnbq6ZlR2uoqp0vrDgOsMvy/XfMzJQy//SlD2f4GsHmMxaGTVUlTVy9XhHLYAv23lKTcHkJ4ihKm+ed+SKzLihbLeuQM1zaKof71SEoP7V5TAjqJ2xKPPymF3HnJSY2IxPFY5jteO4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.9; Fri, 20 Sep 2024 08:18:18 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 08:18:18 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves 4/4] btf_encoder: add global_var feature to
 encode globals
In-Reply-To: <491270c5-f756-4c37-957f-5134f1f13bcd@oracle.com>
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
 <20240912190827.230176-5-stephen.s.brennan@oracle.com>
 <491270c5-f756-4c37-957f-5134f1f13bcd@oracle.com>
Date: Fri, 20 Sep 2024 01:18:14 -0700
Message-ID: <87jzf6ybzt.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM4PR10MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ea1244-5b7c-4d36-f9b8-08dcd94cc81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6I+J0UJ0a62Vo+MUVVNk5AXqlDSYYcmkO/NHlz0CSxBNZVXA3vjovAy3EIot?=
 =?us-ascii?Q?htWoH+aD1mChT1pp2hK3eCrWSABpLAx1Buz2SJpvNnXinw74h1h4KmTb2DY6?=
 =?us-ascii?Q?8wSg5ukZs82/yK+VjQ/naLoPq/r5BahbNRSIj2o63lfrwaoo+wwTi9fTBcwd?=
 =?us-ascii?Q?h9awsGi6eGqlCbe3Q2/Nc59tvCqrXg0eMNxBZT1XDj51gOetFI8hSm0HW/16?=
 =?us-ascii?Q?/CgdnAZ5D+MsD1Kh2LC2nkFvwaX0DhUz1yLwFr2vfMTbMVuy5+ctUw9KFMnp?=
 =?us-ascii?Q?F+9u3ZiGTmxY3tPQ4Gm/NDBJbbNx2F1bdotoF9Q1hD1+XG4A9TFZQCajVYVq?=
 =?us-ascii?Q?fDpa5VOKn3pzVugCbcTFry2Jh2TB06XwOACCS5tmSLHuMiahyKs2TuThLDCk?=
 =?us-ascii?Q?thIqYn2Y+z6Rymf0NDsn4C0/ZpZqLQ7o3z57fsulSFP9Df2D+mo+wF+4Xagd?=
 =?us-ascii?Q?FrEYE3Apjkc5Y5l8TpYjOfD1ZHZcKhaJUC3NL+vq95hZWwADit6Akys6QIYy?=
 =?us-ascii?Q?FrWJSKw22BvaI9Hq808rbGrEGTqP28LF6GTzJPdKH559fMaGJnMXGKc3KKSB?=
 =?us-ascii?Q?2thBiHHbiI5Pbn4HyJS4VRMYjLoSiU+8oz03A+HNXgazELT9J/lh82rQTBYh?=
 =?us-ascii?Q?oxqFs7DNb2qxkJjTwYk1Pa1SSUuNUSqEy0A5FAk7mXDgsmyjuiT7ejqjaXsz?=
 =?us-ascii?Q?caWJS15LZsgO5JIKflhvqR06oJMXFBKOqE1RblioIwPRcGHi3WAGHiPM9YlU?=
 =?us-ascii?Q?yDfcV5swvt0zj1Afw4S0/tAi7tqMRYL7Lwl2UAWTzblXzcJWFZj7NhiE38IT?=
 =?us-ascii?Q?DZ+AqLh3J+vIetGRMJu3sdASouZ44oSuuq81jj9wAkb+NH4FR28+w8d+jnBY?=
 =?us-ascii?Q?3BKMG2QVTWuBdEHY3JTmE65kkz5GaGBJlxgKHuD54g8tgiK1VMwinRP3+tUC?=
 =?us-ascii?Q?haKsuAeBFwzN/rhEFfPGGlj/HJR1sFqz/Hi9KDUTc+yMOyqwhHzgTgfMSAB/?=
 =?us-ascii?Q?LAq8ZG6YCbgWSTIFVS2I2r+P5oXCguYyoDucFtTddf6y6kk38Y7R0nZ9cBn0?=
 =?us-ascii?Q?2gs5iO0kM+5lpTlyPFCVNE9zieR8VxQFR10zNEOwM7knzKycFeaejC4nZ+VE?=
 =?us-ascii?Q?QHzUJhdfpFAfUAZgW65S4T1jUEU8hbV6t4uxG42HrDYEg7vJm9KKl7X323JS?=
 =?us-ascii?Q?NVyt5BnHxopD3DDb0PA+3UQUsix4AMuOHmEbvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jJgRRhZHGIFiXRKVEASGe/chaNSpfYg2KS2herBZYG4jUYSlDIEW8Eg/qfre?=
 =?us-ascii?Q?HAxb/Y2KnDkLMeCTl3Pm3R12pHCJgnjqUpq75XiyoqK+8zr5FRk6P6S21cio?=
 =?us-ascii?Q?zqpEMu/LIQoDJ2+WHPlLx5MFN6mJwVm/mq3ma7JnW9Z/TqAnKCm6otdBM6Hv?=
 =?us-ascii?Q?qgQpGbh81obsrI3EiK8CNLknm5fD8zUyEUkkZ86QrBkjZXtZPqzaLw18kgum?=
 =?us-ascii?Q?z/YbimJJU+RR7EyhE49dwsOq4llqfjecX1WgIzK8gL8jVQMzO9g1z7SZA0qR?=
 =?us-ascii?Q?gF3P+63NFZ5H8jOrkRg0P0lX/iKg5KD87cnJn4NdSpm7m0XQ81BFWmPhAE67?=
 =?us-ascii?Q?ZAgxgNvXu0778/vQy3bmXoLCxkmngr2XPXzrzJ6KPlkCmR0RrRE7v+BoOga6?=
 =?us-ascii?Q?C4B5vlWW3MOjaWLOrN2wQLgMUVHwns1mBv5o0xMqKdJDVjlr8jOGE/E3GXf8?=
 =?us-ascii?Q?apUyab90RsZg8tTP3ed6l6YvUn/qIP/ZlSUpvxUj8Is/3DJRahK/qrocxorm?=
 =?us-ascii?Q?Pwkerli3gK8AD8sFRf/c0YhDLVdz5by3rBMAMsKyGmBU8myUE6kjGzgu2ewZ?=
 =?us-ascii?Q?tQbZU9Cl0TykWnmc2VUvvTLn6XRXr2declq9Ntx5ghRliiijVOud43FMCQto?=
 =?us-ascii?Q?z5Egj5E88Ku1HKGaBzJTw0tV+52wMR2Xs7aY9K6k7LsIV/o92utKkgCbsdXl?=
 =?us-ascii?Q?NlIwNfQ6wpg5FPy2wBUGAh9esWpQ/z2w/AEcGBqEkTdhYjqR9A+CZ47kPxXY?=
 =?us-ascii?Q?2Y5KAnqfK1GV5h++O9W8GbDipRMv5XooSFlSDnWWvFeTk7BwSRytf+PYNa53?=
 =?us-ascii?Q?2NE1TYauTTG4Ewmnp7rnKraErqqLluCEHDbwhBnPcqTGf4C9ChTcKY7Ve6oT?=
 =?us-ascii?Q?BK5XFHvy6+cxaUQrFLEluEQpva8asu5jRfrRryST7V3nX4cM9aPDtws17UmN?=
 =?us-ascii?Q?uv37K7qxCuU/UoH8A8X8+B5FEK368bcjUOjrBH20g6q9d2fij+JVMDVVHkur?=
 =?us-ascii?Q?/f5bYtVVdFVxS2LMvfzzwwQw8qzG4SaWzIiKlBVYKte1bovQX01qXE4gBrgV?=
 =?us-ascii?Q?/VPxR4S9cXZTJFsNiZTkC1Qm5J9A0QOREiWXjIK2njr4dy2zs2g4wFsyn818?=
 =?us-ascii?Q?KLZFPXKBxEVnYLJTD3Aa3ILHd+KSeLn2AM2ugogjEWQPY4inBffz7uppu7N8?=
 =?us-ascii?Q?poBjTeVL/yZcaQ+Dd+SSICztuOXfUtP8Oz/EC1f0Sa4o+c0445EKm/5AANzQ?=
 =?us-ascii?Q?v+5rVQi2oMvrwbECvMZLgulhxjPuIJG5tjMPFmL3zZv9u5pqiXd71ET7rfLn?=
 =?us-ascii?Q?xxitJX7Tc27wwNM6i0OfCEkxrg8DHEAzWYTPtK/MOzztuqrojGjV90yhrs6J?=
 =?us-ascii?Q?X7nkuOs2fIrJYnq2dnYIumkZQgbSIjq2PFMBCvdPQsg4gyhwI8ELT9wjXl+A?=
 =?us-ascii?Q?CnLh5nXnlJmE7DBL2ecpJ14vrRjvrnEjsVg8/1gu25DnqOBjJDc6ojFTj1xN?=
 =?us-ascii?Q?8y4Gi57LV85At4ms2Fpa0/revuaTp4Lp6z3/iNpk+xHApafoHtRYCKx+z6Cu?=
 =?us-ascii?Q?sPOdrNmpTYKWHwnJZS8ACGgVN6LSZNAJq79deTlx22vd0Jd1np3Ig1qjtJ+l?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o9K7WwR0rDHtiA/glRpbOSIXdixpCT4f6uThtQtLRBZ5z5pf+a2BziBJbeQj+qJTdpogQDrB7coA5c0W/xyj/J4AgZeWIw8cLCjvH7H6HKCsihjeBQte8IegXw8Hfo92xrozyvbADjreS29vh5o+5m27z6aUpRhLBoFL35CoNPGxLMz5ngeUodSsCBl4W/m2WsKpA0DifEGAlTQ9zz8kc9eu4ZSGFDu0h0YyTAmCURs24H8KJ8stobO8xQFa3bosdWoBCKaIInEyzan6YZ0beS4WsU4poWgrhXllZkh0hUBekp0gxNgEMNl02AX1fVQV1rroR9VYLHBQ7nenLSmOrE9koYlet0j7xUIPs6tISWK8CiLR+kN+4mxKnPDqXJEw3qNDvTlFpQFbCjdU/q06atIwi6a7MCQmFoAx5RP3xj0Et+lLSxuw0rnFCRlp8YLOwErli+ZfpKV079+CYBsXolQw8VN3K1m9TcuEE4pjWM8b6o4GAEJOlKAIcEX8weeRAAINRsiiVh+xOfirdA/ZbDZrpTSP6bl9tb2uIhpcp0yTHgnPUhG2cwzcYfLbjWnnOac46iqjr6OMuBpQZ4vWRszmii3IhCMzFJ+xrsBFzHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ea1244-5b7c-4d36-f9b8-08dcd94cc81b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:18:18.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccfrbqjr9GLfwbK6R6KvSMbTKTpgWgnRigXXU1RcbrJJple9y+ijN0ocEZBeL/c/YL6eWr26qNkAFee/ydVB0T0IO5O4Kb+/PsgGM4dNS/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200058
X-Proofpoint-GUID: Ga0s7lXFHrJwNtfWrg7ZZwn7vfcRapva
X-Proofpoint-ORIG-GUID: Ga0s7lXFHrJwNtfWrg7ZZwn7vfcRapva

Alan Maguire <alan.maguire@oracle.com> writes:

> On 12/09/2024 20:08, Stephen Brennan wrote:
>> Currently the "var" feature only encodes percpu variables. Add the
>> ability to encode all global variables.
>> 
>> This also drops the use of the symbol table to find variable names and
>> compare them against DWARF names. We simply rely on the DWARF
>> information to give us all the variables.
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>
> Tried this out on x86_64/aarch64, got multiple DATASECs and ~28000
> variables. All worked nicely!
>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>
> more below, mostly small things though.
>
>> ---
>>  btf_encoder.c      | 345 ++++++++++++++++++++-------------------------
>>  btf_encoder.h      |   8 ++
>>  dwarves.h          |   1 +
>>  man-pages/pahole.1 |   8 +-
>>  pahole.c           |  11 +-
>>  5 files changed, 181 insertions(+), 192 deletions(-)
>>
>
> What's really impressive here is that you've deleted more code than
> you've added while also adding valuable functionality; that's a rare
> thing so didn't want to leave it unremarked!

I didn't even notice myself :)

>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index e3384e5..1872a35 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -67,16 +67,13 @@ struct elf_function {
>>  
>>  #define MAX_ELF_SEC_CNT    128
>>  
>> -struct var_info {
>> -	uint64_t    addr;
>> -	const char *name;
>> -	uint32_t    sz;
>> -};
>> -
>>  struct elf_secinfo {
>>  	uint64_t    addr;
>>  	const char *name;
>>  	uint64_t    sz;
>> +	bool        include;
>> +	uint32_t    type;
>> +	struct gobuffer secinfo;
>>  };
>>  
>>  /*
>> @@ -86,31 +83,24 @@ struct btf_encoder {
>>  	struct list_head  node;
>>  	struct btf        *btf;
>>  	struct cu         *cu;
>> -	struct gobuffer   percpu_secinfo;
>>  	const char	  *source_filename;
>>  	const char	  *filename;
>>  	struct elf_symtab *symtab;
>>  	uint32_t	  type_id_off;
>>  	bool		  has_index_type,
>>  			  need_index_type,
>> -			  skip_encoding_vars,
>>  			  raw_output,
>>  			  verbose,
>>  			  force,
>>  			  gen_floats,
>>  			  skip_encoding_decl_tag,
>>  			  tag_kfuncs,
>> -			  is_rel,
>>  			  gen_distilled_base;
>>  	uint32_t	  array_index_id;
>>  	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
>>  	size_t             seccnt;
>> -	struct {
>> -		struct var_info *vars;
>> -		int		var_cnt;
>> -		int		allocated;
>> -		uint32_t	shndx;
>> -	} percpu;
>> +	int                encode_vars;
>> +	uint32_t           percpu_shndx;
>>  	struct {
>>  		struct elf_function *entries;
>>  		int		    allocated;
>> @@ -737,46 +727,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
>>  	return id;
>>  }
>>  
>> -static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
>> -				     uint32_t offset, uint32_t size)
>> +static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, int shndx,
>> +					    uint32_t type, unsigned long addr, uint32_t size)
>>  {
>>  	struct btf_var_secinfo si = {
>>  		.type = type,
>> -		.offset = offset,
>> +		.offset = addr,
>>  		.size = size,
>>  	};
>> -	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
>> +	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
>>  }
>>  
>>  int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
>>  {
>> -	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
>> -	size_t sz = gobuffer__size(var_secinfo_buf);
>> -	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> -	uint32_t type_id;
>> -	uint32_t next_type_id = btf__type_cnt(encoder->btf);
>> -	int32_t i, id;
>> -	struct btf_var_secinfo *vsi;
>> -
>> +	int shndx;
>>  	if (encoder == other)
>>  		return 0;
>>  
>>  	btf_encoder__add_saved_funcs(other);
>>  
>> -	for (i = 0; i < nr_var_secinfo; i++) {
>> -		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
>> -		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
>> -		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
>> -		if (id < 0)
>> -			return id;
>> +	for (shndx = 0; shndx < other->seccnt; shndx++) {
>> +		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
>> +		size_t sz = gobuffer__size(var_secinfo_buf);
>> +		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> +		uint32_t type_id;
>> +		uint32_t next_type_id = btf__type_cnt(encoder->btf);
>> +		int32_t i, id;
>> +		struct btf_var_secinfo *vsi;
>> +
>> +		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
>> +			fprintf(stderr, "mismatched ELF sections at index %d: \"%s\", \"%s\"\n",
>> +				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
>> +			return -1;
>> +		}
>> +
>> +		for (i = 0; i < nr_var_secinfo; i++) {
>> +			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
>> +			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
>> +			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
>> +			if (id < 0)
>> +				return id;
>> +		}
>>  	}
>>  
>>  	return btf__add_btf(encoder->btf, other->btf);
>>  }
>>  
>> -static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
>> +static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, int shndx)
>>  {
>> -	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
>> +	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
>> +	const char *section_name = encoder->secinfo[shndx].name;
>>  	struct btf *btf = encoder->btf;
>>  	size_t sz = gobuffer__size(var_secinfo_buf);
>>  	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> @@ -1743,13 +1743,14 @@ out:
>>  int btf_encoder__encode(struct btf_encoder *encoder)
>>  {
>>  	bool should_tag_kfuncs;
>> -	int err;
>> +	int err, shndx;
>>  
>>  	/* for single-threaded case, saved funcs are added here */
>>  	btf_encoder__add_saved_funcs(encoder);
>>  
>> -	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
>> -		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
>> +	for (shndx = 0; shndx < encoder->seccnt; shndx++)
>> +		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
>> +			btf_encoder__add_datasec(encoder, shndx);
>>  
>>  	/* Empty file, nothing to do, so... done! */
>>  	if (btf__type_cnt(encoder->btf) == 1)
>> @@ -1799,111 +1800,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>>  	return err;
>>  }
>>  
>> -static int percpu_var_cmp(const void *_a, const void *_b)
>> -{
>> -	const struct var_info *a = _a;
>> -	const struct var_info *b = _b;
>> -
>> -	if (a->addr == b->addr)
>> -		return 0;
>> -	return a->addr < b->addr ? -1 : 1;
>> -}
>> -
>> -static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
>> -{
>> -	struct var_info key = { .addr = addr };
>> -	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
>> -					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
>> -	if (!p)
>> -		return false;
>> -
>> -	*sz = p->sz;
>> -	*name = p->name;
>> -	return true;
>> -}
>> -
>> -static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
>> -{
>> -	const char *sym_name;
>> -	uint64_t addr;
>> -	uint32_t size;
>> -
>> -	/* compare a symbol's shndx to determine if it's a percpu variable */
>> -	if (sym_sec_idx != encoder->percpu.shndx)
>> -		return 0;
>> -	if (elf_sym__type(sym) != STT_OBJECT)
>> -		return 0;
>> -
>> -	addr = elf_sym__value(sym);
>> -
>> -	size = elf_sym__size(sym);
>> -	if (!size)
>> -		return 0; /* ignore zero-sized symbols */
>> -
>> -	sym_name = elf_sym__name(sym, encoder->symtab);
>> -	if (!btf_name_valid(sym_name)) {
>> -		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
>> -				    sym_name, encoder->verbose, encoder->force);
>> -		if (encoder->force)
>> -			return 0;
>> -		return -1;
>> -	}
>> -
>> -	if (encoder->verbose)
>> -		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
>> -
>> -	/* Make sure addr is section-relative. For kernel modules (which are
>> -	 * ET_REL files) this is already the case. For vmlinux (which is an
>> -	 * ET_EXEC file) we need to subtract the section address.
>> -	 */
>> -	if (!encoder->is_rel)
>> -		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
>> -
>> -	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
>> -		struct var_info *new;
>> -
>> -		new = reallocarray_grow(encoder->percpu.vars,
>> -					&encoder->percpu.allocated,
>> -					sizeof(*encoder->percpu.vars));
>> -		if (!new) {
>> -			fprintf(stderr, "Failed to allocate memory for variables\n");
>> -			return -1;
>> -		}
>> -		encoder->percpu.vars = new;
>> -	}
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
>> -	encoder->percpu.var_cnt++;
>> -
>> -	return 0;
>> -}
>>  
>> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
>> +static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
>>  {
>> -	Elf32_Word sym_sec_idx;
>> +	uint32_t sym_sec_idx;
>>  	uint32_t core_id;
>>  	GElf_Sym sym;
>>  
>> -	/* cache variables' addresses, preparing for searching in symtab. */
>> -	encoder->percpu.var_cnt = 0;
>> -
>> -	/* search within symtab for percpu variables */
>>  	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
>> -		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
>> -			return -1;
>>  		if (btf_encoder__collect_function(encoder, &sym))
>>  			return -1;
>>  	}
>>  
>> -	if (collect_percpu_vars) {
>> -		if (encoder->percpu.var_cnt)
>> -			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
>> -
>> -		if (encoder->verbose)
>> -			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
>> -	}
>> -
>>  	if (encoder->functions.cnt) {
>>  		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
>>  		      functions_cmp);
>> @@ -1925,75 +1833,126 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
>>  	return true;
>>  }
>>  
>> +static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
>> +{
>> +	for (int i = 1; i < encoder->seccnt; i++)
>> +		/* Variables are only present in PROGBITS or NOBITS (.bss) */
>> +		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
>> +		     encoder->secinfo[i].type == SHT_NOBITS) &&
>> +		    encoder->secinfo[i].addr <= addr &&
>> +		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
>> +			return i;
>> +	return 0;
>> +}
>
> what if our variables were in shndx 0, probably unlikely but not sure if
> it's possible? What about making it return -ENOENT here if no section
> matches?

I'm intentionally starting the loop at 1 to ignore the null section at
index 0. According to the ELF standard index 0 should always be
SHT_NULL, see Figure 1-10 in the linked doc:

https://refspecs.linuxfoundation.org/elf/elf.pdf

That said... clearer return values good, and this index 0 business is
heavily implicit, so I'll adjust the return value all the same, and add
a comment about index 0.

>> +
>> +/*
>> + * Filter out variables / symbol names with common prefixes and no useful
>> + * values. Prefixes should be added sparingly, and it should be objectively
>> + * obvious that they are not useful.
>> + */
>> +static bool filter_variable_name(const char *name)
>> +{
>> +	static const struct { char *s; size_t len; } skip[] = {
>> +		#define X(str) {str, sizeof(str) - 1}
>> +		X("__UNIQUE_ID"),
>> +		X("__tpstrtab_"),
>> +		X("__exitcall_"),
>> +		X("__func_stack_frame_non_standard_")
>> +		#undef X
>> +	};
>> +	int i;
>> +
>> +	if (*name != '_')
>> +		return false;
>> +
>> +	for (i = 0; i < sizeof(skip) / sizeof(skip[0]); i++)
>
> nit we have ARRAY_SIZE() in dwarves.h, ARRAY_SIZE(skip) could be used
> here; i'd also add brackets for the for() loop body even tho not
> strictly required.

Thanks!

>> +		if (strncmp(name, skip[i].s, skip[i].len) == 0)
>> +			return true;
>> +	return false;
>> +}
>> +
>>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  {
>>  	struct cu *cu = encoder->cu;
>>  	uint32_t core_id;
>>  	struct tag *pos;
>>  	int err = -1;
>> -	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>>  
>> -	if (encoder->percpu.shndx == 0 || !encoder->symtab)
>> +	if (!encoder->symtab)
>>  		return 0;
>>  
>>  	if (encoder->verbose)
>> -		printf("search cu '%s' for percpu global variables.\n", cu->name);
>> +		printf("search cu '%s' for global variables.\n", cu->name);
>>  
>>  	cu__for_each_variable(cu, core_id, pos) {
>>  		struct variable *var = tag__variable(pos);
>> -		uint32_t size, type, linkage;
>> -		const char *name, *dwarf_name;
>> +		uint32_t type, linkage;
>> +		const char *name;
>>  		struct llvm_annotation *annot;
>>  		const struct tag *tag;
>> +		int shndx;
>> +		struct elf_secinfo *sec = NULL;
>>  		uint64_t addr;
>>  		int id;
>> +		unsigned long size;
>>  
>> +		/* Skip incomplete (non-defining) declarations */
>>  		if (var->declaration && !var->spec)
>>  			continue;
>>  
>> -		/* percpu variables are allocated in global space */
>> -		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
>> +		/*
>> +		 * top_level: indicates that the variable is declared at the top
>> +		 *   level of the CU, and thus it is globally scoped.
>> +		 * artificial: indicates that the variable is a compiler-generated
>> +		 *   "fake" variable that doesn't appear in the source.
>> +		 * scope: set by pahole to indicate the type of storage the
>> +		 *   variable has. GLOBAL indicates it is stored in static
>> +		 *   memory (as opposed to a stack variable or register)
>> +		 *
>> +		 * Some variables are "top_level" but not GLOBAL:
>> +		 *   e.g. current_stack_pointer, which is a register variable,
>> +		 *   despite having global CU-declarations. We don't want that,
>> +		 *   since no code could actually find this variable.
>> +		 * Some variables are GLOBAL but not top_level:
>> +		 *   e.g. function static variables
>> +		 */
>> +		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
>>  			continue;
>>  
>>  		/* addr has to be recorded before we follow spec */
>>  		addr = var->ip.addr;
>> -		dwarf_name = variable__name(var);
>>  
>> -		/* Make sure addr is section-relative. DWARF, unlike ELF,
>> -		 * always contains virtual symbol addresses, so subtract
>> -		 * the section address unconditionally.
>> -		 */
>> -		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
>> +		/* Get the ELF section info for the variable */
>> +		shndx = get_elf_section(encoder, addr);
>> +		if (shndx && shndx < encoder->seccnt)
>> +			sec = &encoder->secinfo[shndx];
>> +		if (!sec || !sec->include)
>>  			continue;
>> -		addr -= pcpu_scn->addr;
>>  
>> -		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
>> -			continue; /* not a per-CPU variable */
>> +		/* Convert addr to section relative */
>> +		addr -= sec->addr;
>>  
>> -		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
>> -		 * have addr == 0, which is the same as, say, valid
>> -		 * fixed_percpu_data per-CPU variable. To distinguish between
>> -		 * them, additionally compare DWARF and ELF symbol names. If
>> -		 * DWARF doesn't provide proper name, pessimistically assume
>> -		 * bad variable.
>> -		 *
>> -		 * Examples of such special variables are:
>> -		 *
>> -		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
>> -		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
>> -		 *  3. __exitcall(fn), functions which are labeled as exit calls.
>> -		 *
>> -		 *  This is relevant only for vmlinux image, as for kernel
>> -		 *  modules per-CPU data section has non-zero offset so all
>> -		 *  per-CPU symbols have non-zero values.
>> -		 */
>> -		if (var->ip.addr == 0) {
>> -			if (!dwarf_name || strcmp(dwarf_name, name))
>> +		/* DWARF specification reference should be followed, because
>> +		 * information like the name & type may not be present on var */
>> +		if (var->spec)
>> +			var = var->spec;
>> +
>> +		name = variable__name(var);
>> +		if (!name)
>> +			continue;
>> +
>> +		/* Check for invalid BTF names */
>> +		if (!btf_name_valid(name)) {
>> +			dump_invalid_symbol("Found invalid variable name when encoding btf",
>> +					    name, encoder->verbose, encoder->force);
>> +			if (encoder->force)
>>  				continue;
>> +			else
>> +				return -1;
>>  		}
>>  
>> -		if (var->spec)
>> -			var = var->spec;
>> +		if (filter_variable_name(name))
>> +			continue;
>>  
>>  		if (var->ip.tag.type == 0) {
>>  			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
>> @@ -2005,9 +1964,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		}
>>  
>>  		tag = cu__type(cu, var->ip.tag.type);
>> -		if (tag__size(tag, cu) == 0) {
>> +		size = tag__size(tag, cu);
>> +		if (size == 0) {
>>  			if (encoder->verbose)
>> -				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
>> +				fprintf(stderr, "Ignoring zero-sized variable '%s'...\n", name ?: "<missing name>");
>>  			continue;
>>  		}
>>  
>> @@ -2037,13 +1997,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		}
>>  
>>  		/*
>> -		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
>> -		 * encoder->types later when we add BTF_VAR_DATASEC.
>> +		 * Add the variable to the secinfo for the section it appears in.
>> +		 * Later we will generate a BTF_VAR_DATASEC for all any section with
>> +		 * an encoded variable.
>>  		 */
>> -		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
>> +		id = btf_encoder__add_var_secinfo(encoder, shndx, id, addr, size);
>>  		if (id < 0) {
>>  			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
>> -			        name, addr);
>> +				name, addr);
>>  			goto out;
>>  		}
>>  	}
>> @@ -2070,7 +2031,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  
>>  		encoder->force		 = conf_load->btf_encode_force;
>>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>> -		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
>>  		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>> @@ -2078,6 +2038,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  		encoder->has_index_type  = false;
>>  		encoder->need_index_type = false;
>>  		encoder->array_index_id  = 0;
>> +		encoder->encode_vars = 0;
>> +		if (!conf_load->skip_encoding_btf_vars)
>> +			encoder->encode_vars |= BTF_VAR_PERCPU;
>> +		if (conf_load->encode_btf_global_vars)
>> +			encoder->encode_vars |= BTF_VAR_GLOBAL;
>>  
>>  		GElf_Ehdr ehdr;
>>  
>> @@ -2087,8 +2052,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			goto out_delete;
>>  		}
>>  
>> -		encoder->is_rel = ehdr.e_type == ET_REL;
>> -
>>  		switch (ehdr.e_ident[EI_DATA]) {
>>  		case ELFDATA2LSB:
>>  			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
>> @@ -2127,15 +2090,21 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			encoder->secinfo[shndx].addr = shdr.sh_addr;
>>  			encoder->secinfo[shndx].sz = shdr.sh_size;
>>  			encoder->secinfo[shndx].name = secname;
>> -
>> -			if (strcmp(secname, PERCPU_SECTION) == 0)
>> -				encoder->percpu.shndx = shndx;
>> +			encoder->secinfo[shndx].type = shdr.sh_type;
>> +			if (encoder->encode_vars & BTF_VAR_GLOBAL)
>> +				encoder->secinfo[shndx].include = true;
>> +
>> +			if (strcmp(secname, PERCPU_SECTION) == 0) {
>> +				encoder->percpu_shndx = shndx;
>> +				if (encoder->encode_vars & BTF_VAR_PERCPU)
>> +					encoder->secinfo[shndx].include = true;
>> +			}
>>  		}
>>  
>> -		if (!encoder->percpu.shndx && encoder->verbose)
>> +		if (!encoder->percpu_shndx && encoder->verbose)
>>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>>  
>> -		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
>> +		if (btf_encoder__collect_symbols(encoder))
>>  			goto out_delete;
>>  
>>  		if (encoder->verbose)
>> @@ -2156,7 +2125,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>>  		return;
>>  
>>  	btf_encoders__delete(encoder);
>> -	__gobuffer__delete(&encoder->percpu_secinfo);
>> +	for (int i = 0; i < encoder->seccnt; i++)
>> +		__gobuffer__delete(&encoder->secinfo[i].secinfo);
>>  	zfree(&encoder->filename);
>>  	zfree(&encoder->source_filename);
>>  	btf__free(encoder->btf);
>> @@ -2166,9 +2136,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>>  	free(encoder->functions.entries);
>>  	encoder->functions.entries = NULL;
>> -	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
>> -	free(encoder->percpu.vars);
>> -	encoder->percpu.vars = NULL;
>>  
>>  	free(encoder);
>>  }
>> @@ -2321,7 +2288,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  			goto out;
>>  	}
>>  
>> -	if (!encoder->skip_encoding_vars)
>> +	if (encoder->encode_vars)
>>  		err = btf_encoder__encode_cu_variables(encoder);
>>  
>>  	/* It is only safe to delete this CU if we have not stashed any static
>> diff --git a/btf_encoder.h b/btf_encoder.h
>> index f54c95a..c5424db 100644
>> --- a/btf_encoder.h
>> +++ b/btf_encoder.h
>> @@ -16,7 +16,15 @@ struct btf;
>>  struct cu;
>>  struct list_head;
>>  
>> +enum btf_var_option {
>> +	BTF_VAR_NONE = 0,
>> +	BTF_VAR_PERCPU = 1,
>> +	BTF_VAR_GLOBAL = 2,
>> +};
>> +#define BTF_VAR_ALL (BTF_VAR_PERCPU | BTF_VAR_GLOBAL)
>> +
>
> Could also just do
>
> enum btf_var_option {
> 	BTF_VAR_NONE = 0,
> 	BTF_VAR_PERCPU = 1,
> 	BTF_VAR_GLOBAL = 2,
> 	BTF_VAR_ALL = BTF_VAR_PERCPU | BTF_VAR_GLOBAL,
> };
> Either way, BTF_VAR_ALL doesn't seem to be used.

Yeah, its main purpose is to illustrate that these are flags, not
constants. I'll just put that into a comment and delete BTF_VAR_ALL.

>>  struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
>> +
>>  void btf_encoder__delete(struct btf_encoder *encoder);
>>  
>>  int btf_encoder__encode(struct btf_encoder *encoder);
>> diff --git a/dwarves.h b/dwarves.h
>> index 0fede91..fef881f 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -92,6 +92,7 @@ struct conf_load {
>>  	bool			btf_gen_optimized;
>>  	bool			skip_encoding_btf_inconsistent_proto;
>>  	bool			skip_encoding_btf_vars;
>> +	bool			encode_btf_global_vars;
>>  	bool			btf_gen_floats;
>>  	bool			btf_encode_force;
>>  	bool			reproducible_build;
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index 0a9d8ac..4bc2d03 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -230,7 +230,10 @@ the debugging information.
>>  
>>  .TP
>>  .B \-\-skip_encoding_btf_vars
>> -Do not encode VARs in BTF.
>> +.TQ
>> +.B \-\-encode_btf_global_vars
>> +By default, VARs are encoded only for percpu variables. These options allow
>> +to skip encoding them, or alternatively to encode all global variables too.
>>  
>>  .TP
>>  .B \-\-skip_encoding_btf_decl_tag
>> @@ -296,7 +299,8 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
>>  	encode_force       Ignore invalid symbols when encoding BTF; for example
>>  	                   if a symbol has an invalid name, it will be ignored
>>  	                   and BTF encoding will continue.
>> -	var                Encode variables using BTF_KIND_VAR in BTF.
>> +	var                Encode percpu variables using BTF_KIND_VAR in BTF.
>> +	global_var         Encode all global variables in the same way.
>>  	float              Encode floating-point types in BTF.
>>  	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
>>  	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
>> diff --git a/pahole.c b/pahole.c
>> index a33490d..27b7a7e 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1239,6 +1239,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>>  #define ARGP_contains_enumerator 344
>>  #define ARGP_reproducible_build 345
>>  #define ARGP_running_kernel_vmlinux 346
>> +#define ARGP_encode_btf_global_vars 347
>>  
>>  /* --btf_features=feature1[,feature2,..] allows us to specify
>>   * a list of requested BTF features or "default" to enable all default
>> @@ -1285,6 +1286,7 @@ struct btf_feature {
>>  } btf_features[] = {
>>  	BTF_DEFAULT_FEATURE(encode_force, btf_encode_force, false),
>>  	BTF_DEFAULT_FEATURE(var, skip_encoding_btf_vars, true),
>> +	BTF_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>>  	BTF_DEFAULT_FEATURE(float, btf_gen_floats, false),
>>  	BTF_DEFAULT_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
>>  	BTF_DEFAULT_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
>> @@ -1720,7 +1722,12 @@ static const struct argp_option pahole__options[] = {
>>  	{
>>  		.name = "skip_encoding_btf_vars",
>>  		.key  = ARGP_skip_encoding_btf_vars,
>> -		.doc  = "Do not encode VARs in BTF."
>> +		.doc  = "Do not encode VARs in BTF (default: percpu only)."
>> +	},
>
> you've inherited this, but the double negatives here are really
> confusing; in brackets would it be clearer to say "If this option is not
> specified, per-cpu variables are encoded only.  To encode all global
> variables, --encode_btf_global_vars must be specified too". Or something
> similar.

I've done my best to improve the help text for v2!

Thanks,
Stephen

>> +	{
>> +		.name = "encode_btf_global_vars",
>> +		.key  = ARGP_skip_encoding_btf_vars,
>> +		.doc  = "Encode all global VARs in BTF (default: percpu only)."
>>  	},
>>  	{
>>  		.name = "btf_encode_force",
>> @@ -2047,6 +2054,8 @@ static error_t pahole__options_parser(int key, char *arg,
>>  		show_supported_btf_features(stdout);	exit(0);
>>  	case ARGP_btf_features_strict:
>>  		parse_btf_features(arg, true);		break;
>> +	case ARGP_encode_btf_global_vars:
>> +		conf_load.encode_btf_global_vars = true;	break;
>>  	default:
>>  		return ARGP_ERR_UNKNOWN;
>>  	}
