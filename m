Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795114402;
	b=Jn0TkU/kSEfSMAWsTrXEr1o7Q9uxflW+2pz98dj9ttWgaxtVuF5G2BwXDnjVHzSMifPz
	 XNBVZWZJfFIcpd+Jt7P7GjHdKFBPeKIqeSmypHvPqcgYSSjs3Bhh88tqWipIFm6RFn0u8
	 aqW1nR1N8XfZN7FRHj0YwKArI9tsTbox7d2zhHx3Ywbe+BqqbtsouFu9O3xJAxQMf/DFE
	 s9nsQvTlLmgkvM5hSJd4qtifpqvsoxdlwy3zQ9DBa4tSJK3yQG+9ThgwJVDzJHTAmyTmM
	 2ld2lOu21Sn58KTLnqrR0d8XjrK35aX0X9z6liVqvoWoRMrckQRUnBNq//SUmRQdhrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114402;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc;
	bh=nHqz2HmPD9jZffoAFZWk+3VPfc8/aTTMHJido9pW6F0=;
	b=UkmSBOuElGfbuwl0p9lHxFQl28+nO1lnk3dAAqLJunnyCpBikHL1/IOhgdzGc1V1iJzi
	 dHbnCinLZhLwOGoHtnjBzP5InerPU0Bjtk6r/yoLO5WoRKFbD+7ZNqwyTjHAskAzEZDAV
	 KKETKmCmekDIxez6qEic2hJ+I1Oy832xXF78idcmOgXttcqHfVfMxXTS7y+JsCoU5fRHa
	 mYNQQMNlX7k+Uh6VTNhAEK+LSfoq0sMVxy7Hl6jgMdnPdYotThxJJaQYieLB/Uhm2dEDl
	 INYVkMpahEqBYSoaTN2Faz7uO4k3lFFR2lSdxFxbiN+IE9rGeMuuzOrEGNKxZWlsTnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=n8Ozi+y4;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=nKVzvcU7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032A1606AA88;
	Thu, 19 Nov 2026 18:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 032A1606AA88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=n8Ozi+y4;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=nKVzvcU7
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJFK5Ex739166;
	Thu, 19 Nov 2026 18:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nHqz2HmPD9jZffoAFZWk+3VPfc8/aTTMHJido9pW6F0=; b=
	n8Ozi+y4JFV4kCHnvIVfJHf89o+6qFAz/wOENXgrTLd8dYgNBJAm3xIzQOcr2WSk
	aHmaXqCI31Gr+OPpRV0GqoRNRfOLFv52wt+0zrVc240fv3rSG6TXBAs+p8QYFJ44
	ZUI8Z8DhcLlQ3tY+hAlWITSOCt7YQKwYSkgIfQfkbXCrKt9jo47g3LF2BNN8bzpK
	yxAW68lj5D+z762QbaxGFNTRKi4YEOrIBQ2qQK8ahNHWPkS4sl2i8OWqMs1/5mF8
	P0y2aSYSbB818iwtmpDRNj5J9YldVF1O7dA42JOuthhfcjbvnYqZwa5UedZs7Rjh
	EC43XHNhE3mObeO/2t9dXg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytq3juc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 18:53:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJHbVE71000242;
	Thu, 19 Nov 2026 18:53:17 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4j25p5b87n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 18:53:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0w2jHsTNh9K5nRhTFYVnVcSkm5kAaHl1ixlwgD0+cg6DVgKS2xlLo8QhX/1UI6QR1Ur6J1ZzJg3lQaatPmcjdjyZQEd9BWG35J2q9utD1YvHTqGYpGQCUqtAyC3feJihdxXZSGllJTzefp9MgHdGSlBelmQ57NAAiq+HLXmsqxUSnYsYZVvQzM7k6W5Mxa9Q5g3E1nGJZNa632jS7Cb1VLqkQaObH9NrV3SX3LPhfaeg4bTuS2LzJsSqL9SlXTc7RIWNUOcLG4utvu9pjU4DxH1Wx1tITTA9jquW0+Lr3M6R0FcRxDcVVzprN6VtC/GupvHuCp4+IJo7lJkapNblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHqz2HmPD9jZffoAFZWk+3VPfc8/aTTMHJido9pW6F0=;
 b=OlcGkg5r3TVBd8SqzJnEXmn5mylyT0eKw1k/+PjvKyji6Utstmb5r2Zc2DnB9V1Q0Rnv8gn7zWonRGM3Gg+w2OaUPIWrnz8AjCgqt+o21BWbdjix+ECxvDMSGkkVwb9vk/HsiLRX3laGjcrypEeUurFgj1g5aZi6OOfhWYaooHaCT7CrLXzrnibbb81OOHSk0rBXbYhXH9Q0GQsWIv6TSmPjJewjF1fJFyxtNCAXKIVa+ziLuSyEqNtYBtAuxVCSrToRYlr9wt/mmyeMUv0wMetbk7Z/qT0+MtvhOGQaEPVjQj1NME/3KW2QUZ9BT4CrQv8Fo+Uqd1xN6FcLNauCag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHqz2HmPD9jZffoAFZWk+3VPfc8/aTTMHJido9pW6F0=;
 b=nKVzvcU7tvJQfoDw+5DnFyyhFCqlnjffjmIm3Eyp3npt9xVBMNp7FJ4qP8iF13HaPBPZG9z0wOOT3d5DdAo82O32NLmwajh1d9fhZ4Qg1mgDGVWIYt9/llMz0pbZInQz2g98Cri+SKZE1zHDQNam3piEHUwfwrQgJPN3srkPPt8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2557.namprd10.prod.outlook.com (2603:10b6:805:3f::22)
 by CH5PR10MB997719.namprd10.prod.outlook.com (2603:10b6:610:2f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 18:52:40 +0000
Received: from SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73]) by SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 18:52:40 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] tests: prep_release: use $VISUAL, not $EDITOR
Date: Thu, 19 Nov 2026 10:52:33 -0800
Message-ID: <20261119185236.4113166-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119185236.4113166-1-stephen.s.brennan@oracle.com>
References: <20261119185236.4113166-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::22) To SN6PR10MB2557.namprd10.prod.outlook.com
 (2603:10b6:805:3f::22)
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2557:EE_|CH5PR10MB997719:EE_
X-MS-Office365-Filtering-Correlation-Id: aeed0443-3439-490c-48fe-08df466e4953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|56012099006|261102130727099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	j9or1hg16/vizBxqGozQCUE3Wr2y5KwNnJg8NdA3DuJSLhqKQGkGnBuNFD37uxORturA15RcBqbSg9qFrEmcbnQNYEVX+nBou4iQ0cfWVoBP2EB6ENg3e8ispDfaoLPAqm8kiRsKzvZItTmxfRw+ZOcFgkjpxBDRtJtTY6ZPoV/Ib6lkudjALicJig9ykIhupnL+YpOPPVHjctime83kSB68aOb5fb0qgQOKI9deG3Z1RbmrjKcW/GwqzG1bh1xz0otdPHkSsao6wKAN87DFBu/g7zdXW7hczz/Y7a7Yah5//vlwS36AcURdlfifN1yjogXgpQvCn7OoTZ2j8/CZfiTRuGHj95eALGyXBryCBll67L+4V3xvJILBuf/Ab7Zw4heEnyVSkBGPteVipI9KW/w53cgwG2LZ9QSYuQ9u6/N1fzJ3Be0oCrQFWES/qZkt+EJT3Ib/EUj3p5oRqjbfPWYmvrK7lwNso0AsvFeYfA9I59dKz5RrI/u+YhpS32RfeT2LoBW/CWYDIs7unHv3/xmkL7voZ/WXMWM6hQhiTujNC0ICmSnlHc6t9NoLsCP/j7H6qi8e3xg2WeuaNT7tRBbwCwv/Y8FZ3jsndcYgVjmAcmISvLw5x7sGLUdb4AxOxlKPQ/h6eJ6jliU6yuWLPkzcRmqtKCzG8zvTQnWrwY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2557.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(261102130727099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1kzPWPb2lwWVWlV4yP1FfsUhf6T0KXz6oH8bGEJGM35JD1lPIqC5QPfcFzC5?=
 =?us-ascii?Q?JNmr2Voc634T0pUYmF+U4UiTjkB/ib2APUDKBjYtAuM13vXavrqelaDeZoq2?=
 =?us-ascii?Q?8l6jLpxWHVv6bgBmpOnMfN5NEqy33WQAlJIepqq3LbL2nB+ObYWV7hNI+4p3?=
 =?us-ascii?Q?dAdS32swoklMgNj60I5oqsY/yPpHteaN0shm1zBMYFyWnl6ODWrJGZnBYyJg?=
 =?us-ascii?Q?JMRi/bSJU5HicGUp2pRxfOwPKsbNX1J1XFj4mJYMUebk3n5/B2ItjSMZ5CK+?=
 =?us-ascii?Q?PULjM6V4LNYakUicO0PIwd5ouReQb0g6mAe+lgYSBAybkjPL9GbCWQD/gt5H?=
 =?us-ascii?Q?xnKUBbrie9vOOWA9dgSklUseVsChQ3fhtYv6Wny3qGuLmaN0LXzvs5cHQrNo?=
 =?us-ascii?Q?rllMkY2waJoo/u8ZOPUjEC/MQ27uNCpv1SLum4gKTfyCoJBFVFGeUh6sr7Mt?=
 =?us-ascii?Q?syB7Uvq0BZX1F5BoYhipHpwo8aBrVGKn6nG2lhsK2kmTyssQLjxkEt1144T2?=
 =?us-ascii?Q?EfobwDOu3obocsngG1nqIrGUubM6aETRGxlVOHzfwfRtxEfMd8l3dCiKCCGN?=
 =?us-ascii?Q?g6sBqO1jYeAN2EQNjRr3hi8VZkahi7ddeEA6WPo/TdVuOmw0qVXlOTeqUysK?=
 =?us-ascii?Q?S+WhrM5GAThp8jfySdOQDPhWsuNyQ6cqj6g6NhvTQ5p4mO81sWw1ZJUVUyMV?=
 =?us-ascii?Q?Gacbcq6lTo02QRahKA4IdCEbnmdn8IIhRPuXVMz8kbb8jSZpddJHwN09dTcq?=
 =?us-ascii?Q?q1nnEIpqDBr1DrgoFGEOADb0Jn/pLwSx5JaNSDF5SznRqj2iA1WCs3K0kqMM?=
 =?us-ascii?Q?17lf97P9dD3rLc5/ppEi5B7IOG3TF4aovfH3zInkN2li4msxoFPfamhJL8eE?=
 =?us-ascii?Q?UpdodqdvsM/4/fa3P7Cq9VBDb3Jnh8qSzXq1HH4q2ABzK38PtYBTboZouE1H?=
 =?us-ascii?Q?UkK8XqPYbHNEPFqk8mStXBAyH8zBfVtzmRJn029XjZ0EQNE+xfO0t0kfjvmJ?=
 =?us-ascii?Q?+PxrLubeZMd2Z2Gulc7sW/8J36Guawv5TwDVXJIpIff93oI3S4PdZhVIiUrZ?=
 =?us-ascii?Q?1rOdOkkheM+t7LI8UpePIyxAO9JRM1fXhyO4LGej9CZwDaQ7VhjTWe19ATVC?=
 =?us-ascii?Q?6Bsu8B0qw6jvLqRfE41PJIn020v45w5NcxAl+B+SE/650ElCu8JY/1vVXcH9?=
 =?us-ascii?Q?iUEaoKtkdFDB0UVa9mzmnhF2GLWWbWpF8vREAfQ8VkyNXMagHZzBIrCO87UB?=
 =?us-ascii?Q?29m1c9t5KsTX86noyRe2PZQnMMV5xEOSkLpWoB5PCQsSkwe2LBdWSaSTmo7Q?=
 =?us-ascii?Q?WJavsBPIMtePpRYNUwBdPEQE8gaPnZNs74/kej+RItGgCKCIoIAH99VevBjb?=
 =?us-ascii?Q?k5ewIthCraWCpQAcTwgGCgBqqKsmBd7VyhfbACYqulm03+JLGBR8wBHKVR4L?=
 =?us-ascii?Q?snD1D+mgZcyrQpDopjZmfnN8kn2qvKPp8UjcLLR7Y+bDc82JiOQQhWJd54a8?=
 =?us-ascii?Q?pbZYidC54+DGYCDQpj2QODyfCi5c5WkaLIv01BgOjv4+4t12tW9iWywd7osr?=
 =?us-ascii?Q?kM6Zx/6hg8UDHYlS7ysITCwCo4HspWfY9vDT8/CNrKp5zttb3f8Rhf5BqDqj?=
 =?us-ascii?Q?DXhb2eCD5wnf1NFwBaaa4ThuAcg6APVRmz8WyUmXowZWA6jEsdONQQADtuF7?=
 =?us-ascii?Q?a/7D6tNswRoZqyQfCkyxWmlU3ND8O2Ufr3eC3BpWaj12Es85ZHs2TCcpdSL7?=
 =?us-ascii?Q?79X3dzI9gBngbTPD5MfPs3z08ign2ak=3D?=
X-Exchange-RoutingPolicyChecked:
	03VlRoHjkktWV+g1cxFSrCUgYeo1x8c3rH8jZcJy9LPUbQUG3oLPKoDNlu3uNpRlQmcExllAOl8NdCd9kuUAzxgwhrCRTR4Pyg3F1U+oh//05/LBBoT21/rSQ3XUsMxfNVnFcJg9MqMVgQHRgC73IJnT4TQT4deGPDbbCmL0cwsiOGzU+tHo138vOHFpWnzd06Snt3TTpwLoRSSaPLB5E6q1JtNtJQw658TUDuX8gWZKhOGhyXgV3HmMhtjRnaW11IfqViVcd5oj90W+nQGMdRnZcET/XPs0ifRCezR0UsZocaJMdJi3AwVGTu4DWZhi53MMiwLTKiyGCIi/RcTaMA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mFlva+xMcatyWwSyWvRqKF+OjpdKD6/SaAtIbLKQiWPwnCSm3oHL7WhM49k6uZVSsIsxXkm6nwBz8jxye9QMmU9faVbF08tBS5v+xX6Qxrw7pck50wwNpHReccVlNETkg51Q/IztzzVwJq6DXSdBHvhdPNG7sJyZj4QjnpzAWNxNYrPO44V2zqnV1QkbG7e3MiHPMB56dgLCrpM583EQf7DN/3tHZ6uxCrMliyYoO7Vc7hjTPHZePIFz3c446neoh4gFkmBWUw9P17QaajnHX0mPmV+MoXVqtoMuDliHJG0wIYn1uk1WQOaooCapsSNltvtNfvuuhosDHiLYHIB341VWJNhFn9/Tjt2M5NWmVzHcCgkimmJmsxxi67UaI/ayCLbqPCiae9XsLiZPcDd03XCmwmTGjlmJ6VsCPhV0G00hH2Bi7HVHDtneXIoRcDLOzIhLE+bvtX6j1or/JRtVcoBIaRQjJdvlSNLpnRSLwQkNvGoKWPeo+HEbnr6MD0pFAkxQcL1Qa5qGPyBhagDiyuCQnXzCvdw8CPYYJQ30W4zFcl9C71aFz1ld7SdWRFqENL0pR04lqJki7AY0MwrRCuLwYalqW3Oep5nCK8CYJus=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeed0443-3439-490c-48fe-08df466e4953
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2557.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 18:52:40.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VysS08DfHvMm8pF2k+iIkgqiGNxRGPjruAb4pcLqXz3QZG0h0BGXzrmK5GAernFuBca7SEMQt3QBwxlxgHsEGKs+3Z0/L+xPdM/Tb0QjVcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611190075
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3NSBTYWx0ZWRfX0uhNXhlcYuDd
 hSJ9GE35xHuDR8VmXOUHQ1BCBwHhW6EOKume8W9XUegAYNF5AijH/tV9PhN9ZaLEAXs49Hd/7/C
 vqRjQ4MTdRogoJWPBSE+5Q5ub7vr0hbLvsqWsoO/4b2BLxxZror4
X-Proofpoint-ORIG-GUID: 55zvvzpSKaSLubnFu4O-O0Tyj--Lfxzn
X-Authority-Analysis: v=2.4 cv=WsK+otfv c=1 sm=1 tr=0 ts=6aff459d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=u_f4Ek3x0INR4CqL5uIA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-GUID: 55zvvzpSKaSLubnFu4O-O0Tyj--Lfxzn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3NSBTYWx0ZWRfX1GWlPrhad0XG
 vlzUOM27rQ60ztfMYF/DpIUlKYQWwxVdPlIQNk1rN0qH6TLLC0/lMMXXm4gl2hGNifUwRDL3YNL
 Cc1xyg+XiuDOHioaItmfCG9mJBlzcYAXLA9gzAZjQsK/zDR433whPIULCaSPYLT/ynx07whvJxV
 kF+SyedywsQjNkmRYOSMXEZmzxQNFTkyokGCZSvQlEldvwtDWOzLkLrI2IXf9fd1uMv2sZ8lw/T
 Dvh7WlvCrY/XEuiOthkjbLIxaOoLvq0eLpuZ+y8+N93tUsw0yfwxZijI75lqZOE3nhnNcc3VWmp
 /GXovqUhsHnRHw/I7HZXZEJjx/HesGxaeRlBYNlwtiyR8txt25uatxXwz8Pwfiv+2PrW7GdVR41
 hA23tdt0UAsLE/QQS+R0FDSxwTcEnx7uknk04VegnOMC72rbz2ma9ld0tItnXOQMZEW2sPHva1f
 qTtw03RybRoJb+DrmQqZiVWLCAjVO4uxpCh3H3bQ=

The script uses $VISUAL and only falls back to $EDITOR. Systems with
$VISUAL set will open the editor during tests, which is not what we
want.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tests/prep_release.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/prep_release.sh b/tests/prep_release.sh
index f8b86ff..62728ec 100755
--- a/tests/prep_release.sh
+++ b/tests/prep_release.sh
@@ -642,7 +642,7 @@ esac
 exit 0
 EOF
 chmod +x "$outdir/mark-editor"
-export EDITOR="sh $outdir/mark-editor"
+export VISUAL="sh $outdir/mark-editor"
 if ! bash "$script" --yes --no-commit --no-tarball \
 		--no-build-check --no-tag > "$outdir/run.log" 2>&1; then
 	error_log "FAIL: prep-release.sh exited with an error:"
-- 
2.52.0

