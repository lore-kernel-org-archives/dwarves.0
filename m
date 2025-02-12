Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60E20E02A;
	Wed, 12 Feb 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384519; cv=fail; b=QUQA+8j0ur7TOxmLS0cpbPX/OTyOrYIB9YRhAg6qrwv57Nz6GC7qORUVe+wcEtIRMqBVc2epSm+JUUvf0RtBTi5Ug3q0ujr/F9yHxjrBaOi2Mn14y0kWSrFxnVWJL/VwpqW4MFekRiws1Po+dq3FjeGcRRT8NUbjnNn9z/RhtVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384519; c=relaxed/simple;
	bh=IvCT7SvRb+6g4mUaPxMByDgF5Lt4qDdA/AdAilJvqwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=QoE55Dz4Wxt5ZNxXYyMSyE5g3Cq7mz9Ai2h4CfSLhVsw4TPSzebq6ut6r0eXpmXUEoZMLpxhiNNX4TGFJJK1kIQHeYMFAjzMprJjqgTyTbnr0YH8XjEb8+FxfaZkUWsQqhMO4bDjj1i/6V4eO5kdBkCgjKGF6l8F9LHiYR/NVBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TSj1yVL1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j23EX5ng; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TSj1yVL1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j23EX5ng"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEto1s009384;
	Wed, 12 Feb 2025 18:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hVfvRGpmQN/yrC63fF
	P0mRIE4NFNBpjjF8BoOCpS0g8=; b=TSj1yVL1Yx+qWhWndpEVX6Yy14kuaUbwOm
	CRr4NntsFS0YqALUcoRBP13QTui1cgoMbyhj8snFG7Z1QQyGnZSOiTE4BrkaDwG5
	ZmSBgyQhbAH1FmU7fCQeAgiuSYV0bC78h3o+z447I1n83bw0alOwaKRmGDjX41hH
	qmFiHQhlG/akWZPJawTJiqIRkNizKhZZHVW0WetMVzS5XfUjkfhXTd3DzV7xYGaK
	qFVjw3g5RiH5KX0fGrdk7Ll0dp1ivpEXbl5NSKl7apWV8+0xkPWTu9DnzzhiXA0b
	xGAj9h9cx8TFBG3w9bTg3bA4L9kvo5HaS2CzkeQfn7DsQ/Ufl2yQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qafyk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 18:21:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CIBr4i009747;
	Wed, 12 Feb 2025 18:21:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqgy6bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 18:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+sB7uIq5LzDmuq3YlEgi3t+gdGu37cKK6mYiuJw65iEy8yLydbrLZumYMuBPt4n+Qm0sE1Y6ED5xJc3oFxaaZXMglIUb8n4S0dr+KYRJFIKmS9Lyfp43R5p5/AwpyG+JVpAtr6PMNTc8kRAa1gzEvg0YqTQdhvMAxW6/Hf/tQqxu1j9k89X3Z2OLuuaEJEFWxDMdYqCWOfD3qcs47w1HAKjDD6Klzq8ToGb6RXJCrZmrP4LgnnkrhlViDCK04A2h9kwq4NAxPl7UG/uYJy6qkC/qEqrOzcd9Yf+cFAVoXB4vujXayjeSEDzP+ZwnvPuAmWENUON8T8ttsj3subGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVfvRGpmQN/yrC63fFP0mRIE4NFNBpjjF8BoOCpS0g8=;
 b=XvaXfMNQuWy/vpsJeYLovRzsw+ct4edUGheKOn1Ppz9yTGtc6aVPK4kSzFXPiyInLiEYUuftyC5bdbvvtDeYEdaqNmupXf6fs85PyRYhanw7I0tVCMWX72m3jecYyIJx/KmcL5C7gbn0WBxo3ZiFTkY/mGrj6R73LK9KK5bRwo7yanqDRIvEH5xitUGhKx2lfDQbbod8hiDo5jhnXtKV811Wl2Tj5UtnvsqFwyHHNnkQCQb2skunOW9gX8xMuU07xb9dOohT7DY9xp60Bo6JyxLaEdTdKQ/41+xRkajzww5EHFIzEYzSVS3HDxLDn4YToD96zA0PpS6LPPu3SG25TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVfvRGpmQN/yrC63fFP0mRIE4NFNBpjjF8BoOCpS0g8=;
 b=j23EX5ngXIkHIX2pqJlVsOTW1VG+rxIZDX9aD8vKHSGnQ4tN0Ekdxz240uZSCYZIbTNS6vsj8UtdwyXVD3AYBKgI5khCF4yE7Fdad4FHnbDaSkARX4gSCza4LcpIFFZFaEV0mu7k3svog/H8XV0vLhK5rA0Ba28KNdVFhL/3sSU=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by LV3PR10MB8203.namprd10.prod.outlook.com (2603:10b6:408:284::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 18:21:44 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 18:21:43 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH 3/3] btf_encoder: don't encode duplicate variables
In-Reply-To: <dd0c1d4f-73ff-4da0-9b5c-43b0aa982729@oracle.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
 <20250212005003.1413091-4-stephen.s.brennan@oracle.com>
 <dd0c1d4f-73ff-4da0-9b5c-43b0aa982729@oracle.com>
Date: Wed, 12 Feb 2025 10:21:42 -0800
Message-ID: <874j0zgh1l.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|LV3PR10MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e46a234-df4c-437e-17c1-08dd4b921a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FVHZzrGO7W4TcFMff8YXRPAWqq3J82mzQ6HhlWyqhRqMwmYaTVNJUb+VYVdJ?=
 =?us-ascii?Q?7+6nHoo4IX/9ctQlACAx439YRfOmXCic6GOwJ0w/YH4bOs86fkhnk5VdyIXE?=
 =?us-ascii?Q?hZ2U5Jsi+vXSbA8pDS1q1Z4xKMGhNFVjjCffcMdQDkmVGEotaYtdf6CKgF8U?=
 =?us-ascii?Q?mRFCy3g8TpjEjf2y1MT11ChndWmB76efCwKWyKaZl4a7sBzMhqymXkZ4D0eR?=
 =?us-ascii?Q?ltsvI+3biVoGSaSQFB/S0WJRMPoZ8vtxcym+lNsLZu0y4fC+59GrEPTXXMuU?=
 =?us-ascii?Q?KXqefYvUVcjnxOBGIg9VcMtuJ0mPcbiXPXam/f/nWWrzx1dx6HiY8dndQsd+?=
 =?us-ascii?Q?DLZpPYRx3iFHfvvUhCvwnk1X8Cr4Dl/Z+8GOlQ/I/EjBaD4lydy+vyKQf61q?=
 =?us-ascii?Q?S7A9aV0gCAK8+CmVwmSA1anfeKD88XI79pfLNw6qFF3+upgVwmdnrjxGYeb+?=
 =?us-ascii?Q?ex6Vuu+cNx98fGAWLvpAb9j5bNcB80PiATY7LWMiTlc0a3nrm6CK0kxt+/sV?=
 =?us-ascii?Q?ilXLLNMEXs5gDFLT5/TjQ6OrAvEyhgIkz9bD85ZDE6U0I3k0hyRPjZBM5T3b?=
 =?us-ascii?Q?ODEiz7+t/dogru70EP78Vq8ZpCy3xalD8LG5OprlX1vdiI7QsEZfxZjoVlRx?=
 =?us-ascii?Q?Xndm5mJbYsDFzAJP99nna68RTifxXG4iCxcuCGfMb8ILcXqnT+TWJkXTKxVN?=
 =?us-ascii?Q?PpebFfT9xuu86uSybFd+I+uaMmnk6B+/B9ykZraRmrmyeabIWa8JkORqteDy?=
 =?us-ascii?Q?fFR0b/mqlih/9NZfAbGB7a8jzMn4NX83xxzbg40dBDKLZXnF1Z9P8/6X9/cU?=
 =?us-ascii?Q?ct6Ti+CVAGbQcb19H7FZv6xgM3FIHjl6HBc6lTSjrVTKgSJGsuJWDg2sx4qi?=
 =?us-ascii?Q?Q9NfdfEy7OAG6Td5fEXMVYfemc8E9ASKIFF99n8bo0CFRVFR2bpOzPB1MGu4?=
 =?us-ascii?Q?jleq6YEkxgWkvbtuHXpCtVRWn2cbR3gNC1mwkAx/3y0p7dcFwUfc6HpXVH2I?=
 =?us-ascii?Q?awwr9qjenbiT9aVi9sN9sOJCaaeIIWcwUtIZuJ6KmIaxjUaoFjhvNUOZtegv?=
 =?us-ascii?Q?FfMdeCc8NSFZmNiOOUvr8powCPFze/PqroerYeGL2cWTb0LaPJYb86ds81en?=
 =?us-ascii?Q?SXG3apEh0VqqbHepnw5lXihyuthf7OwHq6j9tRXkKin+l5IQZMjfhPCjsk7Z?=
 =?us-ascii?Q?b58Ph6BwlnHLJcLdoV2r2AUgrujE4NF1TxpSopO9fgG0d/MGSX66sesqAjoV?=
 =?us-ascii?Q?ADprYicEjLSAECoqgoa+8how7f/SrBaEeFlSZEO6Dkjo9zjsWYsAxd+dusd9?=
 =?us-ascii?Q?T5HVkbmzdoICh6FULdurpwSE4xHZ7cNQoTZ3q4vXcf96oIflUiNERdgH2wL6?=
 =?us-ascii?Q?bCPZ2mjJEJP3KOhOfawwhZA8lm33?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nkQq6nDwzCfxb2aKVY6jzS7fhdqcfiPPn3l0rHwq7WztTHTAsavYH0KNMom2?=
 =?us-ascii?Q?IK8kI8nOmmKxQEy7i8xwBMZrounZm8S0Zj8AbRQbDRxc8SnmidsLnzsoeIJF?=
 =?us-ascii?Q?kAeJqn5HJcc2nQQe43pyn+4PMgVVOUeT/84nss0WXg8o1F5TbKK2XKgddIa1?=
 =?us-ascii?Q?i1rNctqHRcu68geWENO3raqvnkIlMXBlJQZVFCBX3OWskKu4Zausq6AlZtZC?=
 =?us-ascii?Q?LJOfpSNnQCZXPlUjlolFIxQrLdh1TnLXxu6tK3SN1/w02Q9hauBhvpBeeoDp?=
 =?us-ascii?Q?a9E4CsPN8GlGpUxH29SzpxmlwuPR6JEA28V61Pg/jSwlsz/fNg62w9a8jdQc?=
 =?us-ascii?Q?Hal8FAq03fNeKj+LOmQc4ERLuY+t8wP/rz4aTp5ywNjb5+/1vgC/IHkVwLbe?=
 =?us-ascii?Q?ZnfVCn3sQcu5d6pNejWm9hF6ujsj7+KS2m7ut/xz9uUWkggd8blGQj7iwb9v?=
 =?us-ascii?Q?pG0um+MT1DUESYjSlu1UhZPETzw3k9gh/cqmYCGRzp9F3ZWNbEWKZDS7Xxqk?=
 =?us-ascii?Q?H61mcpN/dC/QToDdPP0aIiaoIgnObiEGV1FlfptGK9GEoPon4CtD95OkNqBz?=
 =?us-ascii?Q?VtZGF34V6NCn4TfF2V2YJXzhMVjkuTdT7bczmmd3BxMa+MDZj/mmAfSD5JcF?=
 =?us-ascii?Q?in4TJT22uWpJv6lhqKETu0paaqvLBfMGwmqYs7aDEXdgQ1rMDJ6plEtsNYa0?=
 =?us-ascii?Q?tbya9cmN4OvSIC2ftwSI1o8Ay6ZohI8M2obI6CQEjTWbhLQ2Oyv2iJLzLGHW?=
 =?us-ascii?Q?Epb0fIZ+W2ymGX3TzOFckXfwRTh22GQTZWyYa7B1eef8SBUHF1ohDoS17z9O?=
 =?us-ascii?Q?OWEHjbFEnfYxJ3d1gYeeuMUjgFOQriUnO1cwS6tYY6iuN4v53zAJDXoosMiM?=
 =?us-ascii?Q?EhqpotvBm0Uy+XFr1YToBZm3Ol4muKtp+wsJifsameSzQwhYABWLQnA5M9YH?=
 =?us-ascii?Q?ThKaGY9lCR72WLlCrotlnWVO9BbWoQvg2dMgpRPqlDERN4qebYz2g5WpjnnQ?=
 =?us-ascii?Q?n5+5CnApCJYSAePRN56hASnQINPignHoENvYGWO3gs1EnrN1iej+GtihJxhY?=
 =?us-ascii?Q?qf+YTUUf1XKUYi1CsXOy4iCV8LlRdWm4lyu5BT1gGgJEDrfHO7PKPHQZvkCH?=
 =?us-ascii?Q?sG5ukSv0CtZFb60i4MxiJwF8/YZVf13srFpx2Y9+MgbnVhH06itQyfUcnnnM?=
 =?us-ascii?Q?yfr+YuUXUxb0BPzGg48wKryiB5NHG0vVDLDiT57av8pgEZczYnqoy1/oy8UM?=
 =?us-ascii?Q?jaNYjprvRg3L4AoSNJlwG0F8uQiuvZJ5tGf+kIQ60/tY+anK752jX4+PCV8L?=
 =?us-ascii?Q?RdPan4uuvzlLGRqo1jpw0q58PO9AS193gGK074w62UatRDhITiIWNZjFzmru?=
 =?us-ascii?Q?A+aB4ts0O5kz9UeuRY6En5GSlAhER3mNJbmtkB+QXwNndAGzuPRVwULt3nGz?=
 =?us-ascii?Q?z7OX775BS4DRRXSYcVXMyJ/DyIslEc4e6NmWkat7cC2Xzz/Pqjs8MH+iHlOC?=
 =?us-ascii?Q?A243DGiQwusldVbuTM+eqkN5m/fZVr5jXnIRhOpddoJPY0BEDfKK7MnP8avX?=
 =?us-ascii?Q?vgsnPKwPApwaGvQj0nrqo0BawBtlbzDaCfx0YviWFwdptSI85EFBvUA4/nAP?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+1oBcRtvlF7frhl8WGgj5F/2KoVtP+aL4+caIkbUSP2WHzP0wbjnAsPVntT2cBq8SFMgzSweTSnR10Avo2gAnpzHgfc4Is7f5CS697HgqQI1dUXUTXbsTqLWN5ok1EOTs/G04VM+XBV/jZCMYVaB32bUIODHCguwfIztG2goLkB7De0zpCyWqx1voZzEefayhAVlX4o00da8bhADqPF8oj9PLoz15BxHReQl1RJgcAGFpaJS6UsxTrfzav9DGTQMre9YuD7UE3kZ9Immu97A88kDDcPiTGtSHKlbQ9d5hFOE34CIeWVH9Z42N8xPlSXI+LGycp5U74sPw2GlojIU27DE2IrgB4h4Z+o7wSCi2qW52B8larhVJUZEboUOVOqnYHyXpPtE1m5erwR++gHxTBFJLYin2RKV3xroKwvTmUlOVSTFc1f8KfQT/8jMa6UmK1mYNaGsQwUyHuDT0PTgT107wYF00Jn2Y4/qmHcBEg+No1ZLWKeWPbdWPSJwYNGan5BpS0A+qWEF58SQ76UF6cap8ZNpBHPztqlHIO91GVbbrgXZDUNPrLhMLpZ1BYmqheE5zRRBPx78QSkakLFQifjwrgT6wunIKBtL6E+yS0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e46a234-df4c-437e-17c1-08dd4b921a38
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 18:21:43.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOXlkMJB4iw9DbvAR/gijO4iVS9nS/fCpAoEbbiRiAW2Iq0etMj/s88G4LZcPCHDm/pjMSz/xnli0cWCC5Q4XpLXhRZdyZeC7ZVO0TEr++w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120132
X-Proofpoint-GUID: lhues-9SP_vwber6RyaYLS_JprTakopz
X-Proofpoint-ORIG-GUID: lhues-9SP_vwber6RyaYLS_JprTakopz

Alan Maguire <alan.maguire@oracle.com> writes:
> On 12/02/2025 00:49, Stephen Brennan wrote:
>> btf__dedup() does not deduplicate variables, nor the contents of the
>> DATASEC. This is reasonable, because there could very well be multiple
>> variables of the same name & type from different CUs, but with different
>> tags or DATASEC offsets. So it is up to us to ensure we don't provide
>> duplicate variables to libbpf.
>> 
>> Unfortunately, there are some cases where variables are declared
>> "__weak" in the source code, resulting in the same variable, with the
>> same name & type, at the same offset, being encoded twice. The DWARF
>> information does not encode any difference between the "__weak" symbol
>> and the overriding symbol. And even if it did, we couldn't filter out
>> "__weak" symbols, because they aren't always overridden. So, we must
>> deduplicate them.
>> 
>> We can't guarantee that the types are identical prior to deduplication,
>> but we can at least verify the offsets & names are identical. If this
>> happens, simply skip the duplicate copy (or copies) of the variable.
>>
>
> hi Stephen, quick question; could we do without patch 2, and if we get
> an offset match, then just look up the names of the offset-matching
> variables in the code directly to see if they refer to the same
> variable? that way we would only incur costs for the rare cases where we
> get an  offset match. You could use the names__match() function to help
> with that I think too. Would that be simpler maybe?

Without patch 2, we would have already emitted the VAR and DECL_TAG
types. We can still skip emitting the var_secinfo which avoids the
validation error, but it feels a bit messy to leave around the extra
VARs that aren't covered by any var_secinfo. You could probably say with
more confidence whether that's an actual problem.

But as far as the costs incurred by this & patch 2, I _think_
there's not really much extra: yes, we have to store a bit more data
into the buffer for each ELF section, so there is that. (I can probably
reduce some of that in v2, some of the stuff I did is a bit silly in
hindsight.) Mostly we just rearrange the order of when we add the VAR
and DATASEC, and we only check for name matches when we have an offset
match anyway. I do concede that prior to patch 2, VARs may be created in
parallel, and now, they are created in serial, so for parallel BTF that
may be a small regression. Ultimately, I haven't benchmarked and can try
that as well if you'd like.

Let me know how you feel about the extra VARs & the performance!

Thanks,
Stephen

>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>  btf_encoder.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>> 
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index d989fbd..29b2054 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -869,8 +869,36 @@ static int32_t btf_encoder__encode_stored_vars(struct btf_encoder *encoder,
>>  					       struct saved_var *var, uint16_t nr)
>>  {
>>  	int i, id, annot_idx;
>> +	int prev = 0;
>>  
>>  	for (i = 0; i < nr; i++) {
>> +		if (i && var[i].offset == var[prev].offset) {
>> +			/* The offset of this var is the same as the previous.
>> +			 * This can happen when a variable is declared in one CU
>> +			 * as "__weak", and then overridden in another CU. There
>> +			 * is no indication in the DWARF which symbol is weak,
>> +			 * so we need to deduplicate. If the duplicate is the
>> +			 * same name, this is expected, and we can just drop the
>> +			 * second instance. Otherwise, we need to raise an
>> +			 * error.
>> +			 *
>> +			 * Ideally, we would like to verify that the types of
>> +			 * the duplicated variables are the same type as well.
>> +			 * However, there's no way to do this without
>> +			 * deduplicating the BTF, but at that point, our type
>> +			 * IDs won't be valid.
>> +			 */
>> +			if (strcmp(var[i].name, var[prev].name) == 0) {
>> +				var[i].type = 0; /* Don't encode corresponding secinfo */
>> +				continue;
>> +			} else {
>> +				fprintf(stderr,
>> +					"error: encountered variable '%s' (type %x) at  offset 0x%x which duplicates variable '%s' at the same offset\n",
>> +					var[i].name, var[i].type, var[i].offset, var[prev].name);
>> +				return -1;
>> +			}
>> +		}
>> +
>>  		id = btf_encoder__add_var(encoder, var[i].type,
>>  					  var[i].name, var[i].linkage);
>>  		if (id < 0) {
>> @@ -894,6 +922,7 @@ static int32_t btf_encoder__encode_stored_vars(struct btf_encoder *encoder,
>>  		free(var->annots);
>>  		var->annots = NULL;
>>  
>> +		prev = i;
>>  		var[i].type = id;
>>  	}
>>  	return 0;
