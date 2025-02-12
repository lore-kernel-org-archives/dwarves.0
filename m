Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54165219ED;
	Wed, 12 Feb 2025 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321417; cv=fail; b=T2SpHjhHhMKsOZAzpF+/HJVWphwn1CwHpKy9DN9H6GTa4xmlt36+Np0hMHxIsZJ77CPq7vAUXfBcXWghpp1Sxkfa59GjR5E7QI3ameIyMM0oxEXjhnMWkwEhltcJiy2+9no82XIvdBqnUZ2gnqmsry/mW/fkCbtxzzFm1Ak1nbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321417; c=relaxed/simple;
	bh=qdeB4wMPnArTa6gWsIOovT+81bZGSgZML/m2JGVTR4E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YRtskerCZYqpgQoxBsPGjHmsK9IDEe29MTDfR+ImwQmU3/bwYgJzsQpY/LJ826jIcZqJLywoQWteDcPOFclYgfJZbXM/Czl2oU8PfNP3rhfjR4l7Ku3YS+1tR6XRe2O7sECAM1JVyZsN39Ojo10q4RUg0caSxPlarKBwjSxK7cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZHI5Qiu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YQxJBV4I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZHI5Qiu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YQxJBV4I"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLff3a013192;
	Wed, 12 Feb 2025 00:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=1X/ISbuMvyVSA6fJ
	BRzEScixhA2IrLn6ZSJd4oWhd0c=; b=BZHI5QiunCGF2JPC8oX+s01dyZtX5+E5
	ItGhJXD5xlnTb+yrAPUWkd1hU7EL0jU8W++VTCjiqrDYxS9NgF/94Xe4KeiIUzb5
	Jm9scy9vAIfB72jRpnRr6fU4okAr/NwCvZEW0sOLxuHKwikpeBLzUyQBooiG6Dwc
	xBM/Qj3w9TTyIi/2s+IsSprx594VAQWPgLO2lARzgb3NNvn3/Etf0ZE0NmYQIneM
	7xl/CwV7s8GcZOuw5kbea/VjDJlMUHwuUUW83tvvKrc6YxH6RL1AgGkOrdueIdUe
	7ZD2EBA1UuZwCUg+SFWGwWG1oPVraEwFhal52Kjm+8PG928VQcGkgA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn6cbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:50:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0D5cu030521;
	Wed, 12 Feb 2025 00:50:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p6301eqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjs1CVP/pESqQE8wJZfu366+w2GN2qbgloIto5K0Q+rsTLMqvnLYqB8Uz15RqSEJdMNu5iG8XniVG7Ec6NIYH6S3VO2gh2RhGdEM+dxCdqzz36p/L5bwmCL/RBep4B/gqh/bNAA5NuYqaqIElAuT6+5neLDSxh0ZVnq4nWnf37lb1evusf58wEc54FsR6zoccaE9OjOM8V08+4bIBRNR+lNotJh7KcHafuA6nFpNopvz4y19uH1Mvz+HLW4B/j6gZckwr+lYs36+c4tq3w1RUGvmMgTUKK2drJX3Bc2e9N9EeFmG1MCGhms7jmpjfWWA83gjxSA6ySfDwoo+3H8xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X/ISbuMvyVSA6fJBRzEScixhA2IrLn6ZSJd4oWhd0c=;
 b=j0KsEtL/X31TaEMVQCCwNr5CZLVMt39DAXux71W06sT1PhRBqTs8/GCOdbN7zJ/tgYwkpAmmClWqNY3x0ovsp2Z4M37U5WX0cHqACIhtFpiGuT9hEbZiyexwsXEEPOoRUMx+BU5CfSqJaNQ8IE/D4drsFgDd2cOD5VPf5vyRXOGI6LJzUgNZpGaw6ovN67hEOtZh3LeCcC3MGhLhR1tZwfrbREPfZ5HaYe8oiRCcOoB2vgDbJk/khKC9M3pHXRWcXx7O2WcrGoT6/HAUECpWonZTuZpqwc9tA/EsJurV7Fw7YXla6Y4HMJTLABr1LKWzgUpNBYpF61LbgDvHvNi6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X/ISbuMvyVSA6fJBRzEScixhA2IrLn6ZSJd4oWhd0c=;
 b=YQxJBV4IdH68n36e2NBUeQ79GpYisPfrIa88tpjlLFTQrrG2Qu8NJdz/miXBLr4j2pf0lHjM1fa7+fXNGjF47G7j8WgDuSNlK1gxDjm/B7X1Dx0cbK4aAmhJDMD72T4oZLglKbJ5am590bt8OFqCcnLqPQlKUiNJRiF3jVfbyE0=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 00:50:05 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 00:50:05 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 0/3] Fix duplicated VAR and secinfo
Date: Tue, 11 Feb 2025 16:49:55 -0800
Message-ID: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 7263b6b0-8bb3-48a0-7f56-08dd4aff30e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vAMx8LTuDxQE9SV3/cXSKMERx7d7P/xvLtp4PHxRDno3AQSEt71krdFUUtse?=
 =?us-ascii?Q?o1Urrnq50XPldD/VajD7r0S35JVIta6ngrPcY/n4gRS9XYW2mlSOsMxUXR/t?=
 =?us-ascii?Q?ea9V/VLL3MD+fDmkrlAyy75JIq/Doc351sx1+eTPQkG7Ph+2kDzoywtSmxPp?=
 =?us-ascii?Q?2UA5NEZ1cj3uD9PkNLxWpHhFf41UlEeR/ryA1veXAvdf4mSUGSJWL4L8lZed?=
 =?us-ascii?Q?bdzWXuSYMH3UBpuZ+f5XXv84IaZtL+voW9ywwuVopEk78z5CNe/eDnntgM2M?=
 =?us-ascii?Q?ZYJdmSY0FOWUz65mFoLwjjtuZuwiqS+ExbCBe11o6GvCD1pwU2d9IqcgnpVF?=
 =?us-ascii?Q?g1ZtS9IS9RM2QJYlKWlDBqm+j9CYc0v4hpN6f3SVRsW9cQzXGmb0OrAmRN53?=
 =?us-ascii?Q?0gZzAyoDszdoZ/5shDjtgKLXXp/cWIjb9F4JRbMNQPUpz57ppE+ngKaFvORk?=
 =?us-ascii?Q?sdyiVku0oM0wJD3KrfNZtY8UjM5p2a50Oe76PERCBZ1mUSoIOW+Mgrqdvrt6?=
 =?us-ascii?Q?D87tvMoB5dARLqvcglTSVVM0ew9siZdq7h1kzgg5tbfbjv/cTEWKtqk5nNPM?=
 =?us-ascii?Q?J2+GfQ7u0KW5NLiobEk22S6aNvdVxW04r8RnsxEhtW8YCLDY8WDAzNO9pJLo?=
 =?us-ascii?Q?Skoa/CY8VOBE4bbCEFKcGlIwKaljhMAV7vjQ+eYUQJv89KFVoEfa0uKIchS0?=
 =?us-ascii?Q?/vyv7Po07E8ruylfnqTrCuLtLuv2jIhZ6A/ovNOPdwQXfx+Fbn5P+gLOAzRn?=
 =?us-ascii?Q?/XZ7El6e4dbGzDXV1cH7b7wSu3hlP332KvtczzsE2JZhskoJLBe22Vl98hsJ?=
 =?us-ascii?Q?cvMY+/HLsUB0ZjI8H1ZuVckmNvlCJBOSf6Iggfq9OuDz8irPAG0YHvkdtTFu?=
 =?us-ascii?Q?dRrQvHrr+PqVvslwv5dIur80VqaF6r9bKdOfZq54UcKx0JxyiGYeWMAiZHWM?=
 =?us-ascii?Q?qL0XzfAaN9I4qoGgLqZmodMyO7U+ckAqzqudfBb9TqKmXJ4BSQk+y9C3zKpF?=
 =?us-ascii?Q?qvnldHXztXMfMS3YRRP9RFnuVumU/KWeREm2HODDczGES/DXu+2wBrUtt3yn?=
 =?us-ascii?Q?V3rOvYBSX/0yswkuwbRHH9N0mw+nywPBOWnWnoCbW5Gjr76YprtC/QNt64WP?=
 =?us-ascii?Q?jjHqBkyk1cntVurSJlL6Qrf1AyVvULyA3aLociFqsgMc3xEsxo01L6ksWXG7?=
 =?us-ascii?Q?7i6HDdTzFfvbg2U2L1KZUMnfMAkS5+mn395uTRuYLJOVtk8t4eZ+gqAha1X2?=
 =?us-ascii?Q?020+d+g+5VQCdS1DV87lVL+3Wj5+tXwgl/PykH0mlfkmK8piqdXRF08HLSyv?=
 =?us-ascii?Q?BJ7zSqjLTfcgi5MCVy4KrmHtm+lYxw51uotjCCfgyDaOCXWwe78597kvhuuy?=
 =?us-ascii?Q?CvcPVnY0+QdHnl+dTYEyvMZuw/TKFAgNUONvqyWfSy0ZSEgwvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7N4iEmptC87LWfNUNwKmuVEuhQ47oWFPOO+VoBC1G3R8/AzezH9Jhk5FBmg2?=
 =?us-ascii?Q?YAOli+jh1gYq4AVOBsxoHbBafUJMGWjkTm5QoHLnhTKaR5Eu4+PtVXlzT92H?=
 =?us-ascii?Q?oNKcrLuxsrfGZL20rr5PRTucYwl365BvZyGgQVFYE0vfm1+jszd8/tAynH55?=
 =?us-ascii?Q?vdo8fOtnvmYPCHsNmy/KJM7lBJWHEm0wyY2739H9oGoGcy/VU7NvsaETPqPK?=
 =?us-ascii?Q?DvLSmS3OaDHxRn6Lm2wEFO/OVbS7dWWqNJacopD30IAqgxPmbCoiBtiPu52h?=
 =?us-ascii?Q?tvsFrFsnxdnlMpTeTh7XwFvCtwOhfT3XWA4AOQAz83k0fO/VlGfgYIFhGSsu?=
 =?us-ascii?Q?RGgIEHfyjw+fMdr7aFZGQm8GCkD7k7VQGGAC2n1VXTTtCyfuSvLu0J0dANPL?=
 =?us-ascii?Q?qoxglq1MX3OAfh63geyHEZpx0RotXVVtDqZKdMT3R43o64Eh+j/7UbPPwxky?=
 =?us-ascii?Q?fVIH+gRPSP0gVZQS/QsE6Pu/1wcVVx1cIaKFNQ1DylCZcrlOxmoRsXSDsKgo?=
 =?us-ascii?Q?9k3XY/Nfc/RVxy5Yc8WEiUm7RfeeaQhgtKxCtm9fiyk7wr9H0aGli2tKkhUx?=
 =?us-ascii?Q?v6Y1nCjX1FKkn7EqKzkt406kwdsEFq7RPaDqfaXvRRH95jc9UloePrBUnJNt?=
 =?us-ascii?Q?eDs5jHXl3tjLQXdkNmAfvjGZl/xH8yz/uvjxxBVrb96w9jdyDI19287TlsT3?=
 =?us-ascii?Q?gpOlL2pqoxtU89SZ6iC0QuHkNJKogP54uuXF0yL8G45HieVF2QF19mtMVuvf?=
 =?us-ascii?Q?jKlw8BKTIUG8XUxgpuZJYMzJ8hS5gMipeoeXK340EtlKjukjfW1NU+h2FlLC?=
 =?us-ascii?Q?TiXNkJIi1KdqaiXyMhPj/rqEf+VgaQsdTxQ5+LUWfEmREsfJF9+E1U/JPbIe?=
 =?us-ascii?Q?f2PvQ30AAZ2u/kwcJ2C/j8CTDrHPKqo1BoOfbnKgFkgb+KWiuKsvXpJa81ae?=
 =?us-ascii?Q?nCA6S3UWWk0lsMkMrQsME+POlNg3CUnWKFTGNVnOjC3YU+etwo1T7FtDuJW1?=
 =?us-ascii?Q?bhaD9Ay/IM8eHR859oqqsv5zy/nPUNJmNKqdxKTT6obxeyVW6nR1Io77aKic?=
 =?us-ascii?Q?++bMXv0lk1KWgzCfglp+scjlBK+gDqO0REf4qmtImPDo5vZ0ig8Nw+vWbNnt?=
 =?us-ascii?Q?I8lI1kyksvGJL1Vu56QScASbWLhrCUvfS/Ep4qNlVcRvUR//r/W6gI4w15be?=
 =?us-ascii?Q?pk11Mp2T/egoa4JGNMa2dNPiJOWpHxUcAYDz8sq7wbJnHaRtQQ2GFi3NYf6P?=
 =?us-ascii?Q?JOiiuuYxS8wgLQZQHSesixYcqK0YKFtl5UYMyYmejOQbn7gsvHBA5uX+j25J?=
 =?us-ascii?Q?TyahYSgBKcXGmNni+rkf+sVsiaLJRNMiSbhOZ6QOrJ5TjATa9Tnb9nsOew1N?=
 =?us-ascii?Q?MNYsQXCENkBAJN/IuqScpiqpA1rHUsO+Is7Gyj/9eACzPW+2NyFrz1zCP3YA?=
 =?us-ascii?Q?a/ekl0Zx0QUnKAlinS8wGI82V7s2MIbUlT9VSKZXh0mL2CSdspyl8QLwNHnE?=
 =?us-ascii?Q?c5gfrREbcjxsMd12cvqCzJ2l0p1+2SK/I8SKJqzflvBEiklir62L+W2o8cM6?=
 =?us-ascii?Q?Arb3kL23zxn78lwxLiHN1Zbr8ooYor2qeTVgvJvT0XZs7WEXX5hL0CaEcV8y?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6rXn5TONZieUPXYeMZMeNzqQGPhu5x92dKsPpEaPL8+DYHwpOBFOi5a8tb0dj8U+kzxwzXCDxCskqIVV8sNUMpvJBVX1yMc5S6wX0UpaF9BtSmq8TRqPx1SkgL5CB5iT3rgL3Tjlg+ms3N7aVyzF1e3XdlAfIAK3Mgfd8azAk3HXMBTucWUj2bEuOtwW7d0IYC+WrzL8nexZ8mqVnKp9Ey8FcuyZZBFAZZEyzXYBsNZ+UPRvi4lCX8P01xy85I2+p7SpyTqf4uGqyFMUiQrGY5BvF0yaqm+MIk3mrrVdoxguwIlMhC2OtyW1Goh9O80U8Yr8zYZfNmO3QrsEWeET2P6k1FbQ0eLjb42i02K1b3w3f3xYfEWiag7GgJm0aE7NLMiLauB4P7qHm7lSLrumbIBjdr/tyo1/pEJ62eVu+FnbUenkPnH1pg1Imfps9hZMQoBSZRmcaPelrwnwXao4apU2smr8Ne0Cje9WhkNZMO55FtmrPzZ7dLs6yuLKWYH0KSu7TjnuP/5rJurO8gRh7EZmzPWZ0m7+CuGjSQ8J6qJQwXB3wOlzGj9WV95pef0R6ICUOEc7Qm4VpQlNbinHtOkExOtI7tPdzXz8ZkWuFmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7263b6b0-8bb3-48a0-7f56-08dd4aff30e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 00:50:05.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vM7rPdAsCpblRch9EO/bqwCiJOuHz/GlHNod05cjKikepYqyfnfIge/w2C4BnPe/1Nk9DCAJX3A/Q2hvlyFBrEa4WkzeBS6hIlgg5Rhtzmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120005
X-Proofpoint-GUID: SM_JE3TDqNR4SzuGLHqW-2aN2geA77D-
X-Proofpoint-ORIG-GUID: SM_JE3TDqNR4SzuGLHqW-2aN2geA77D-

Hello all,

I was recently able to clear up some issues related to the interaction
between kallsyms generation and BTF generation, which was interfering with
using BTF with global variables in the kernel. I sent some patches[1] to
the kernel to enable global_var. After further testing, I see that enabling
global_var results in the following validation errors:

    BPF: #011 type_id=23691 offset=435904 size=96
    fbcon: Taking over console
    BPF:
    BPF: Invalid offset
    BPF:

Thanks to Alan Maguire's quick debugging, we were able to find the root
cause. It turned out that several btf_var_secinfo entries had the exact
same offset (and name) as their predecessors. The reason was that these
entries corresponded to some variables are declared as "__weak" and then
overridden. For example:

   // kernel/bpf/helpers.c
   const struct bpf_func_proto bpf_get_current_task_proto __weak;
   // kernel/trace/bpf_trace.c
   const struct bpf_func_proto bpf_get_current_task_proto = {...

Both declarations appear in the DWARF as variable declarations, but it
seems that there is no way to find out which one of the declarations is
"__weak". (I checked this via llvm-dwarfdump). Overall, in a simple kernel
configuration, I found 47 btf_var_secinfo which had duplicated offsets. In
each case, both secinfos referred to distinct VARs, which had identical
names and types. All were due to the "__weak" symbol. We need to eliminate
these duplicates in order for the BTF to be validated by the kernel.

This patch series does the deduplication of the VAR and SECINFO in pahole,
by collecting the lists of variables for each ELF section, and then
outputting them all once the list is sorted by offset and duplicates are
identified. The libbpf btf__dedup() function does not deduplicate DATASEC
or VAR. It would probably be possible to implement this there, and I'm open
to feedback or suggestions regarding this. I implemented it in pahole
because I'm most familiar with that code, and because it seems to me like
it's reasonable for libbpf to expect that the input variable information is
already deduplicated.

I've gone ahead and tested this by building & booting a kernel with these
changes, and the kernel patch series at [1]. The result exhibited no BPF
varidation errors, and the drgn BTF branch[2] is working perfectly with it!

Thanks,
Stephen

[1]: https://lore.kernel.org/bpf/20250207012045.2129841-1-stephen.s.brennan@oracle.com/
[2]: https://github.com/brenns10/drgn/commits/btf_2024

Stephen Brennan (3):
  btf_encoder: move btf_encoder__add_decl_tag()
  btf_encoder: postpone VARs until encoding DATASEC
  btf_encoder: don't encode duplicate variables

 btf_encoder.c | 234 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 168 insertions(+), 66 deletions(-)

-- 
2.43.5

