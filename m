Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795114401;
	b=wdIAirugdZbfH8zqbnZiUHzNQbeN7H541KyC99XD7sWM/bYmqstI3vmmhE4L2ALDPm7Y
	 yn/eXLclAAQ97emEetl+paWT0t/Ir6/UgH7k5OCo3sa+1/pd8N3gVn25wddMRqGsFnZi8
	 4XGmIfLwppGwDA0joH1dg9k51N8RRHaI5vBmWtsUgWkV6QGD79ynXScOwwuK3wOCQSRFL
	 VYnKd2EcgF3TdyuSWtvTOLZU8xr7qcoYoIkMnb34kWKIMe0xL5zFfEdPMK4DimoW5L8jH
	 UgLnZ7nDS9z5ZLCWEJPJsbLbVn26LfvMKP68di2RRpAjFeH0+uIilgnXwaBIMIWWAyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114401;
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc;
	bh=r+coagFAuaifsR9cFMOzNjrBwuUWGqOj0mOBei19fog=;
	b=PXOlAuijFUi3nbb+5Alv4KPvULpnE22LgwupCeRSFdaQe19cLFfle3jUDc642ntLtffK
	 NEC8Gn3vOpZShDEMsUY7X3Vh5ygXQfuNpBer6hEvEbALJIJcK+DKz/tgZUaxCI86UeTbk
	 SacLMD8ki75vTl0YgJMvGvWPqC9cA1HGuMeRGperqf82Es+jdc9D9WAw/3uaZnJMShMSK
	 SAyXB7nd6heUJXVHjRinYUh/gRYDyXH6A/7IsqIQuSfSseKib56n+EqdFR1n9enRrQA+I
	 EDLvKGmnNjAFXcamXRMoock38xNazXP1fpFrUUvm2yHCwS1BCSBaVQ6rZZeR4aC0qkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=LHto0QGz;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=GfxCLdT9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315A606A32A;
	Thu, 19 Nov 2026 18:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0315A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=LHto0QGz;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=GfxCLdT9
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJFK2Dn1842312;
	Thu, 19 Nov 2026 18:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r+coagFAuaifsR9cFMOzNjrBwuUWGqOj0mOBei19fog=; b=
	LHto0QGzUqkHZDzrFa3QmoG4W46KXA8lkg/7k+/Y85nvUdgHTaQIJYTKezlywXRa
	+phgD3rz4QMvkzgBnt7eCKrXtMjArKw9U5x8c9sUaQDXMaYlCEoYiR96TOcIIGk9
	yOustEGeBihI31SIhwrWgyNpvwq9XwWrQWtI3NAhaMqIbI0/hn+k2v51vGX/wcO2
	V36GvaILCeCSeoFjKxZ23Hp0gR5koCtO5Sev1HIRn1CWtYGIUghYDvsJaZSZ/x9P
	oOpGn2PTc5QBSz9sn/3Kk8iELaESPkAOoMzSOm/u2Zlm2vEAWwLOy5Ynb50fIWyS
	0FpcoOQqg305wnV0724+nA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytqbg20-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 18:53:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJHbVE91000242;
	Thu, 19 Nov 2026 18:53:17 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4j25p5b87n-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 18:53:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skjpupJjKs7LMSww3lhXMKjUHJjlSyEyaFneGlqpBMmCYbzICM5vXvkZkPEOBxAO0FS5JZkUhls0L+VyvJODoqzqIwCTBMkQzSuUxFFoawF8GVhDmaFI7oy9dUL9aKfvWpXTIwKK/XkW37mKQ3k0g92+Gt0aQechpMsXcG6PIhlWUb4PHdraHR8JllU0rburUEhtVelmmhNZtW5Gz4D4CSBJtzCZy4h1t7OpZyyKcCZh4f6GQfNuGl+XH0VrQQsJQ1iUShTN179sSOzRQ6bfVt6EU+cWOJ0tCrKOsPxKRtFZnB+fDzPV3qcUetDgsK35Ku3ZqI0lBmpTmKR8p1XhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+coagFAuaifsR9cFMOzNjrBwuUWGqOj0mOBei19fog=;
 b=cFY/LpNCJ11KF8Av0mLd2A+9TmukUJN15y/3v+AWtnTdup+iOhSFXyU+0X1XnOZj/QLYEjexnXy+RzFJiqZW8ii1ieHbvBLIFr7fq2G9TyxwuCUtXcz6g1y1HCNZnbTf+VOs2DSE+sjVDFbXgq23TXKU6o+VyEtUSjBMRPu8yxb2MeHLjzFjutjEmfzWtZqVAlIR7k2Mm/Sp1Qedd18SvPJjEre22tCjeqo9YHK7QQ7calQvAY1B8dfRpbxHtd9Mgl3LNGk93n1M0Vt2bTXIMj7KFRjWnqXeKNb8qmX/lN7zmLlIOX1NdHBBuc78eDfNwtOEo4e9slPrriCOEfp4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+coagFAuaifsR9cFMOzNjrBwuUWGqOj0mOBei19fog=;
 b=GfxCLdT9zdop9fPdUu5315d+cwE9wSuyRVlkS4KYP4JtuGFjza1thVddcxY2u2Ak/2Q1raAAd1DjmCcDTxX8AzTuZJrxljZPktOke9QYu792VxVbUVOduDLDAez7O+mF08ZaxR+voYIUvz58HAvvJDm4aWzZCU4kfkSehRuxXdo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2557.namprd10.prod.outlook.com (2603:10b6:805:3f::22)
 by CH5PR10MB997719.namprd10.prod.outlook.com (2603:10b6:610:2f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 18:52:42 +0000
Received: from SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73]) by SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 18:52:42 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] btf_encoder: fix DATASEC assignment for ET_REL files
Date: Thu, 19 Nov 2026 10:52:34 -0800
Message-ID: <20261119185236.4113166-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119185236.4113166-1-stephen.s.brennan@oracle.com>
References: <20261119185236.4113166-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::16) To SN6PR10MB2557.namprd10.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 1fd75aee-7f11-471b-0ef0-08df466e4a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|6133799003|261009223027099003|3023799007|56012099006|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gnSEU28VUHGWQ7viyCFIX9a/ZEzqOJKBwMyF1b9Kp3eACApsXknrQ6g3oU31FJd10gy9pgezKdTFQNraqjed0iyexW4+YGXe0nxLODnUDOrebEvk92neb1+OsXgTpOPPrE2OtLlYfD+oySuwf1o0jklv9/2LTXsjfYFdb2Wmiqz9er+fuvBRpNZ+BUakOyQ07vpvceUZtjiEJvTOMQ5hKQliiWc/F2xsFkmHa2ibyIjSNoGexHOgXLnxV6RMXSomfkWib/gfGX2BbaTiDX4haPBrvM965JQEeg3PIXzEpHsyU1GHR0RQdfG/AS3pNtS6WiKZC6QM7VPPuMkjAgcstj0mS11jtIicdTLJ7wKiRgPSwfc2rBvkin+mkJgkLokpdygfuLu8QpZJ19vL0Be11BXKVPpYOVwGliH9vOfCEzOImItEatE0j5hWr7FDdnFChG6sSnzzdvYub0nfllaR7HZFgkf7oBAOHPUjUpD9JpkSYHW+H2oV9IhZAVh7WTrAs6cNRIS5TS1YddIOfvABkI3REgOBQjTjYoDUa2kqgaLcCojD4GbrgMnQ5a7r7556KmC8+c9r6itTDKaTFtQPmzz4taF0awY2xom6PZqinmQo8Ci9MxxCXbOzq5cbBTzvnbkGGB4K+M8jscRI8n74wWJMgdbbyJtaLHm+RhbW/TQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2557.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PYBEO4rLrb4l80bDBPXwfyFv6sF6f1fpf8e4/ed4Lng0HJfXDACRvfjainLJ?=
 =?us-ascii?Q?ok16ZqeATFFs+gegGTrelikVN9/CgAeGVza5llslcFpmPUsuwDVX7etu9dn0?=
 =?us-ascii?Q?kQSOVPGe84vwp1EmzovcJqdZWVXtgMELpPaP8OFLz/Ch1HRf3yjWncQvAT4D?=
 =?us-ascii?Q?Gq6JVXrpsJgpfxHrjHBJ2tECWeFt4ILfoNL+PI0dskJeBBiG/I23pRv4rcUu?=
 =?us-ascii?Q?xnO4XD2n3Qho2QVydXJ91Fkqi6RAAPCzWLQhsObm9sqzajLEppfQ6/UPigBh?=
 =?us-ascii?Q?c6if8J4aiX5PfzW675cWTHD0hYUJ4WOBupodudTPUS4xmEbnwTxNJHaojsPh?=
 =?us-ascii?Q?LJq1Ow5HxyqQDhmVfQWM+5E/9hlM3mlG3Si7vqozQ5paVJM57xj0/jqekKnW?=
 =?us-ascii?Q?My+D+9SIE7dDnySOBXjC402ULwnUDUZRN/2BYq78Djsyf8qR5zx6e5qdVwQJ?=
 =?us-ascii?Q?b/lR3gVX8Ftg6BiIZ0zCNKhaDtZIvWPUfEzkQdqH26ASllP3i5EfPZBZ2Dgp?=
 =?us-ascii?Q?SsFZhJrvOMHrfY6BJq8REok1tLsY57C+YN7+IicwM8ANF316LjyPHD0gOGn8?=
 =?us-ascii?Q?+yUI3ILIDRrTguyH533Uh6X8KZM+/eeqkb4leVCtlEhokw5U6Dthb3kzHskm?=
 =?us-ascii?Q?wCOEkiua26z7LNUKe+lVf6OH2geC3JBG13rHCm8ioI710+R2Y02pr4fav4if?=
 =?us-ascii?Q?jKJptAOlTVdjrlz4sEpDUR66a/W610fn+8CZg239QT88r4DUYdST2yinDAHw?=
 =?us-ascii?Q?LnWtKGLWpYmBr51yg3CL1CmyXRBrP196mMX+wuJUxyw2b1cMQ9/5rVb30x62?=
 =?us-ascii?Q?upTCfhbwVEHb6V7oMkrRKUz4Z/jBabBUERv441Rlb4vHDlRWgRn6/wmgMi4S?=
 =?us-ascii?Q?96cYBArYgcBOD6QTjra02K+UfNCfKG/Z77xouFW4sQserygiM7oCL4kIBJYq?=
 =?us-ascii?Q?Im4Gf3pDloCm0PAMU6gOiaPoRswUY9Y95CebBbyL+clXVypUpuEd+9hnBZ7J?=
 =?us-ascii?Q?QzXWNQKrnShMirWldT7Acsi15Ij4snHImM53VWiHEIGG2Jo8aGSWecBjzKAr?=
 =?us-ascii?Q?XTTxXzAeMvvVc+z99fSKX5jGbGcr1EKFfMdk78RkVNu7xR6m62BrV1mMgh2/?=
 =?us-ascii?Q?zLnM6SaeDQ8OM6WOmU645kWxnpJdGiQdTRax56LntNWdQSo7OLSxHUpgeLKV?=
 =?us-ascii?Q?nJh/bRYHqe8vGOUkvHFUxipIzibbex3MPG6dgS2H8Cmpuqc0o+s5/Q3ZkeSv?=
 =?us-ascii?Q?fo/EAD9UnWxSPh5PYMyAOPGkg8ayPTU/uIHG+OTmCsWOe5uOEzfIyX+A49LC?=
 =?us-ascii?Q?BQkKIT8RONDNqWpW6jM/RG+xagAjBDBOFU2kUkhrTrDAHQ7aA3OPyU4kyH9P?=
 =?us-ascii?Q?v/z/IcyX0PWilfBog4GCTFOUauY/XXeOC+nNRbGNRcCis5hww+83+AFov7DL?=
 =?us-ascii?Q?VqKJKwYVmD5rLwlyWXwy7qe4CaW0BWH95mF4BZqacO87nkItsx+YR2CJ2mvP?=
 =?us-ascii?Q?MjGs5OE+2J4tfl5AA3H5qdifYNeKiFLJ9L5fhd51xlcHzGxXtHsNHD4lYTqn?=
 =?us-ascii?Q?eAMipWGYuobkv5YD5VyeULTE+1WvcXTD7NCqBtYjqqZFemkXu9fU5/7Gksgp?=
 =?us-ascii?Q?uYsj1FYIU5HT9d7mC1tyrxvxN3Jk/tACGCHMUZC4K4fdi5SLV5rF6u8CSt/C?=
 =?us-ascii?Q?w+UZabbQGR9OCF+5BcN4xUoi6IIawLOTJzDtIid4YA+JUTPaXRbLnO1NbkDW?=
 =?us-ascii?Q?6EoiS+x85mzpDSmpATRUEKat0VzS7tc=3D?=
X-Exchange-RoutingPolicyChecked:
	0UYkeA+f9YY2m5AZ7OGi61TjR0GMMP4NUIdTcz6McLUJnB929Im4ua3gIKM8+BuNNXePbzSvTg85kY5dyD0c9z9VosTC7oDJ8BSo0tsr173zK6uCktRyccx6VuJ6gisAUneF8xlIKW58IT9dOqr87fgYZRSzDNkzCoTK8JYlzY7fPP8YVewd7D0HKSOElBvQEvoBOGICNwhK96obMj4tcBvsS0XzVQ/npcfZ0xFto/iE2nh9c9xNDij9SSv8WT4jJvbMvnj1nBKKP632uPH6JuCie2u34Qs8MO2zPTMuz3yc7mch6Bis52tlGdOfYZP0ggBFYJDqBB5eh2ww6Zymgg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iYZgErjzTslguWr5ZhikG6cOj1ftwRxluAegr3A7g4cY8Zm2QtzdxZMyMdfPvRT650V3pXX1iKPGP3eXStyjxYEn9N4u4Icpe/PjP/yfxengbN0jDgnFzf5dDxJL/MNzpa8uWtNHfwDqPHKKQLA9He45qn/DE7gDd/i7ALn7wk0DgtsWgNSCutY2BC/UYS8YmlpwlhtRwI6GSVsoc1UcaTy6jMm/Cw144HUgpQhkUpBKYHiM2fyzEgQ9R3xILddpJfuSqujRTZuc1fy4HFPPBDzIrWPirpOaSs1Q4Q/4BJvMWtAsQrqK+Pha/Rg9/Gpsmy3B2oDk9RfGi29eS3NaIrohtrBQhsAvJJcvPgApgx5Q49rTLpJRhWaei1uwBUpA8SE8E8Jqav8gPS5vcaG/T60mrHFFI+yvdYU1h/VoqVqq3HzrdRdF4BwnLYd5CHHv0I/BYABNtuxXX27tVoS1XZOzy5yjyOPX9ojUedWg1Fg+H4Kufz0paEAiN6ewtO0tJF7w0QIMR4E5pw3jOM8UGGqhnCkzXEGBqHIDmegDNZa5bS76+OKR7/M0KVG8HdmBp5GPa47glOyZzWBGDaByNKQe6Mh5SZL+2rwhdKL7mJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd75aee-7f11-471b-0ef0-08df466e4a23
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2557.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 18:52:41.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lInPW7kt6fnVtNqL+qnrAK4kKV57UHf/n3PlISxwo1adkLxOLpnbj40bQZu7r2yCBrRZCGglVeO9NtKrGrB9OMyfUsFa+5G0PGGL08/MuvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611190075
X-Proofpoint-ORIG-GUID: 1cXbOBwRj6UhhsprYh4RTtsws0k9PaRV
X-Authority-Analysis: v=2.4 cv=RNkmjIi+ c=1 sm=1 tr=0 ts=6aff459e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=Be4JWuIhQN1nB96_i5EA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3NSBTYWx0ZWRfX2Dhz4HDFGjHg
 UT+m9eh51up4iIzPuAC46NbgUvD6O3xneKfdirnaprUOKQFizz0PsOd6tmU7CFPHLi4OzR5kE1z
 sWalFIHmh0OJmrthNrJx3flEgDo3rRoz4wrRiS45v7EKUX61NRyX
X-Proofpoint-GUID: 1cXbOBwRj6UhhsprYh4RTtsws0k9PaRV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3NSBTYWx0ZWRfX1BhyvYZjs+Vw
 evmyhM/HFXkyrMnwbYOg9yO0LgDnLtIHBklAt/DN2odsGi0HmIQuXpInalBnZZJSi/HrkPcAYLc
 3IlUlII+pperYGo9A529KVG6Re1jhGGAUjzpmswT+lkyRelgP3mcHNH3cVCj3jcukSv4UikUp5T
 3VHfMUBKBcxADoZS/LH/24aSttQbECH14Z7PYcaYKgZ0A9tnQ5julWisMXS8FWrrgSxw4nOma7D
 li44jElyoF3fFEeOG5T1g4ojRq8koHWd3LkwId7n4qis/yvv6JLNx5W/nGI9DxjiTV0zSxkKa3y
 ARq4uyAGG0tXfg8VWvFLBxQrBln9OT10YrvB3vVmOWiF+5z3uKTFhhzpK2woBF/NrdPSYr+ZUvV
 CY2aJkWtzoqq1ijKQZaCEH7j0XI/qQYd8EZQrVJEpoT2tCCFhZvjVBz+L/49QNQDiBvX/lTkjpT
 S4U3yuu/WPz6xFpFeay2ci/1RiQa2N427EZpEu/c=

When building a kernel with the global_var feature, I encountered some
kernel modules whose BTF encoded a DATASEC named ".debug_info" and
assigned some variables, such as "__this_module" to this section.

For ET_REL files, libdwfl assigns a synthetic address to allocated
sections, starting at around 0x10000. Non-allocated sections, like
.debug_info, start at address 0. If large enough, a non-allocated
section's address range can extend past 0x10000, into the synthetic
address range of an allocated section. This can happen with Linux kernel
modules, resulting in the above behavior.

Pahole iterates the sections in order, so if a variable's address falls
into the overlapping range, and the non-allocated section appears first,
pahole assigns it to the non-allocated section.

Currently, get_elf_section() has logic to filter which sections are
actually considered for variables. It uses a cached value of sh_type,
but we have no cached sh_flags. Rather than cache more data, we can just
filter out ineligible sections when we initialize the secinfo array,
allowing us to remove cached sh_type altogether. This keeps the
eligibility logic in one place, and removes the need to cache a field.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c        | 13 +++++-----
 tests/btf_datasec.sh | 56 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d6b9be6..8907b25 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -116,7 +116,6 @@ struct elf_secinfo {
 	uint64_t    addr;
 	const char *name;
 	uint64_t    sz;
-	uint32_t    type;
 	bool        include;
 	struct gobuffer secinfo;
 };
@@ -2658,11 +2657,6 @@ static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
 {
 	/* Start at index 1 to ignore initial SHT_NULL section */
 	for (size_t i = 1; i < encoder->seccnt; i++) {
-		/* Variables are only present in PROGBITS or NOBITS (.bss) */
-		if (!(encoder->secinfo[i].type == SHT_PROGBITS ||
-		     encoder->secinfo[i].type == SHT_NOBITS))
-			continue;
-
 		if (encoder->secinfo[i].addr <= addr &&
 		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
 			return i;
@@ -2977,10 +2971,15 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
 			if (!sec)
 				goto out_delete;
+			/* Variables are only present in PROGBITS or NOBITS (.bss) */
+			if (!(shdr.sh_type == SHT_PROGBITS || shdr.sh_type == SHT_NOBITS))
+				continue;
+			/* Variables are only present in runtime allocated sections. */
+			if (!(shdr.sh_flags & SHF_ALLOC))
+				continue;
 			encoder->secinfo[shndx].addr = shdr.sh_addr;
 			encoder->secinfo[shndx].sz = shdr.sh_size;
 			encoder->secinfo[shndx].name = secname;
-			encoder->secinfo[shndx].type = shdr.sh_type;
 
 			if (encoder->encode_vars & BTF_VAR_GLOBAL)
 				encoder->secinfo[shndx].include = true;
diff --git a/tests/btf_datasec.sh b/tests/btf_datasec.sh
index 470c7f2..31d590f 100755
--- a/tests/btf_datasec.sh
+++ b/tests/btf_datasec.sh
@@ -4,7 +4,8 @@
 #
 # Test BTF VAR and DATASEC encoding for global variables via
 # btf_encoder__add_var() and btf_encoder__add_datasec() in btf_encoder.c,
-# exercised through --btf_features=global_var on a small linked binary.
+# exercised through --btf_features=global_var on a small linked binary
+# and a relocatable object with overlapping non-allocated sections.
 #
 # External globals and statics must each produce a BTF_KIND_VAR entry with
 # the correct linkage, and their ELF section must appear as a
@@ -119,4 +120,57 @@ else
 	info_log "DATASEC VAR references: skipped (old bpftool format)"
 fi
 
+# For ET_REL files, libdwfl assigns synthetic addresses starting at 0x10000
+# to allocated sections. Non-allocated sections retain address zero, so a
+# sufficiently large one appears to overlap the variables' addresses.
+# Put one before .late_data to catch lookups that ignore SHF_ALLOC.
+cat > "$src" << 'EOF'
+asm(".pushsection .debug_padding, \"\"\n"
+    ".zero 0x20000\n"
+    ".popsection\n");
+int late_first __attribute__((section(".late_data"))) = 1;
+int late_second __attribute__((section(".late_data"))) = 2;
+EOF
+
+obj="$outdir/btf_datasec.o"
+btf="$outdir/btf_datasec_rel.btf"
+if ! $CC -g -O0 -c -o "$obj" "$src" 2>/dev/null; then
+	error_log "FAIL: relocatable object compilation failed"
+	test_fail
+fi
+
+if ! pahole --btf_features=global_var --btf_encode_detached="$btf" "$obj" 2>/dev/null; then
+	error_log "FAIL: relocatable object BTF encoding failed"
+	test_fail
+fi
+
+dump=$(bpftool btf dump file "$btf" 2>/dev/null)
+if ! echo "$dump" | grep -q "DATASEC '\.late_data' size=8 vlen=2"; then
+	error_log "FAIL: expected two variables in .late_data DATASEC"
+	test_fail
+fi
+if echo "$dump" | grep -q "DATASEC '\.debug_padding'"; then
+	error_log "FAIL: non-allocated .debug_padding encoded as a DATASEC"
+	test_fail
+fi
+
+for var in late_first late_second; do
+	if ! echo "$dump" | grep -q "VAR '$var'"; then
+		error_log "FAIL: BTF_KIND_VAR '$var' not found"
+		test_fail
+	fi
+done
+
+if echo "$dump" | grep -q "(VAR '"; then
+	for var in late_first late_second; do
+		if ! echo "$dump" | grep -q "(VAR '$var')"; then
+			error_log "FAIL: no DATASEC references VAR '$var'"
+			test_fail
+		fi
+	done
+else
+	info_log "DATASEC VAR references: skipped (old bpftool format)"
+fi
+info_log "Relocatable object ignores non-allocated sections: ok"
+
 test_pass
-- 
2.52.0

