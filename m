Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3A1E531
	for <dwarves@vger.kernel.org>; Thu,  5 Mar 2026 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672055; cv=fail; b=afUD4QvtPIFZfsGiAiaXNFJfC6q1rvYgxkToj/Zfu7j6bkAiOZfRNSw5iNLpvRzTx8vTWOFMlWonICcJcr+faa9GjG2Nr7jsAbu1XCzgUPaNgo6M1CyXWe4H1JmhTvFtLB7pDZu7YhNVFDQsqjwlll5CXEtuy9P1m9fXE3V1ZPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672055; c=relaxed/simple;
	bh=RlWgjpkpJuosfH3WhNBPM3E8RMwfTjU7kHomXWs835o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GW93jYxh8olgMetfIYftKirkhjvlL+dx2hG+LzfUeFX+bw30D4rQaXD0Cu851oVa9NedvnRwWxRFi/3g/YQamjVWPrrEpQZcrHY5DuGas+mHdrfBN00vMbqlk6XynbIDxxQ9w+1jGszJnJTs/TTIWuycMLZjH9xAubZjaj4fURQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cr/JRGvS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zk1TghE6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cr/JRGvS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zk1TghE6"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6250WHJN2864649
	for <dwarves@vger.kernel.org>; Thu, 5 Mar 2026 00:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=WGQa4OB0K8YOpjHM
	eln78bHJpUXfiU8PicetvyBLI70=; b=cr/JRGvShHtXPXP7X3HoLyJXtE48BqQJ
	RC47SfJ+K4YOxfgqNFPnR4kDegvvtdx5Bde8tAG/pnbx3xMRKi3ZhNMHzgGAP7IJ
	8HLeS16JI4Hre7b3e7g57Z3kk8e4TQWB5tObAhUlDgesE3JXqxAUwCbYSGzPwLty
	EI5TNVA1EcwEP18gGy78NggNXsoIR5f4srKe7iTCU3xXLbgJCArG1lA5b8UyOzK2
	1/cAcwlFylhX3XrHsAwJankqsghluvQz9xOcLiqFv78fuahCIE4+APn3znvFkz3u
	J/U7nIJZC1KQLz10oO/RYQkzEyq8OjcY0wERRGF4B5Wqxehtvd9ZDQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpychr0hn-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Thu, 05 Mar 2026 00:54:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624NIh0O023120
	for <dwarves@vger.kernel.org>; Thu, 5 Mar 2026 00:51:58 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptgu49w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Thu, 05 Mar 2026 00:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKExtcPhfKLdVWGfzfh8etrMXpkcJrGF5MueghNJEDwGnqBrdeiACLoOPlnfX6ni1S1n/z2vO+U78f8GR0CpVM6pR/jcOeNYr0Llc/atwL7k3DdixK5W4RSW57BpLzaXUyy39wMUas9aeq8k6Lk8cw8pH9FgElSjzqVNras9IFji9vOLpx7h8lVedHxMWy/KTDuQPBymayRtez7/vg1IsM7tHYduIgWQHjlV4BuYmVCN9PcnG1qvyVaBEnrQvXVTIF8+GirFkQvXwyhqRLoLNbQiDA/O6mhkuuDmvF262JkFEeBSgKzyKSYPGPBw7YBLIIknAeLKQiFos2N70UyBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGQa4OB0K8YOpjHMeln78bHJpUXfiU8PicetvyBLI70=;
 b=FfYLMjATrOMGYlj14VZCIVAB/QPkD+I0l56lbHFg0G/70wBVtHnYhWD7JpN3tCjLDRty8FqyR/YEWT70ef1MOhBf6ym6Cu60EKOZ/ZqW8zgX0pDJj373NYHHfj7pwRvVyMq5nOawMd84SG+cS0ln68cSTzc+pKErZGsWKFo/3bnQCDZpUabH3bjRP+XOLV6RiqC2j36OeJOkWiES2/uvD7D4jtOrEaF3F1a32fp0eIlHnEUEH78NkG8Grbx0KLn8qYlKqy9SUC8OCXfiQnlX5UkvJJn4fIrEZLgM3Zs0eqHR/DUu/FmqqOfLe1k072oh6Qwn0s6S8O14ybT+XLxjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGQa4OB0K8YOpjHMeln78bHJpUXfiU8PicetvyBLI70=;
 b=zk1TghE6bVeXj9hUL7JOXeDr/SL6pWl2Sq3jpwEGNhIuoVvVlx6IFqMwgMVFQ1hf7ipHqC1/dyEO3llit7nZBGUu1KSmIVoX284r68cmnhJm6b3uQYJwq5xsASlFNZoqpuA5OIVkXGAALpWnuyog5/scAK0L5BKRGMmUWqprxqg=
Received: from IA3PR10MB8513.namprd10.prod.outlook.com (2603:10b6:208:576::12)
 by DS7PR10MB4862.namprd10.prod.outlook.com (2603:10b6:5:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 00:51:53 +0000
Received: from IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61]) by IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 00:51:51 +0000
From: Bruce McCulloch <bruce.mcculloch@oracle.com>
To: dwarves@vger.kernel.org
Cc: elena.zannoni@oracle.com, Bruce McCulloch <bruce.mcculloch@oracle.com>
Subject: [PATCH v2 dwarves] Refactor selftests
Date: Wed,  4 Mar 2026 16:48:47 -0800
Message-ID: <20260305004846.1369028-2-bruce.mcculloch@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:a03:114::20) To IA3PR10MB8513.namprd10.prod.outlook.com
 (2603:10b6:208:576::12)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR10MB8513:EE_|DS7PR10MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc2168d-58fe-48ee-0adb-08de7a516385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	lKBmSWk7kkJywXedla6ecQTcGmCvvtTJm/K4iiVkik/7jer8wtIlX/0+IgIGbXsFRJt6Qu3b2BfSnEZ2xwMRHX9pdjEZxrTUBHZs5IhVtxcntE2Y9Vs9AGTmKdWF37oIswRC7y5vZNw8XS3WxDK2VDCkgDCs+enFKq9gz5BCU/flFtQPKpvqxCTUAGf6HpXp7QpXFMDU/aE9TlYcFo9c+pCyFVO6Eq0kwTQ7/q3x0WzFurAdDRe3jC5NlUBTBY/NMyWnmq6mvh47X9Xz/RBfUBy8I2+ImhlEkkGmpqbatb0jV477tUCigxhbxqeH+xeGLQ2rkUMKvxEDTa7xqBytPTgjH8+AC+3LVaih0tLJf4/jNRqJig2QcxfDdRBQ8xqmXlZvBKjYWg5q7v8l3I8qgToDmt4Evgr+Sr1wwdwHBd1subnAHQ9htlx4QdPgmbSnZ0NCCgKj9iQ0ooUDk1COa1gWO6rRJIdEnKvm48Z5mR5VnL0VEePxYu5yxKS3+yQv6JnEEi9t25EaAlOSGpkByttFGPRgxxfgRUXxg9cdZytS+8dkLAc8haUOU5f6AGV+I6uT2QqjSkowjtXGb65pLtw5bOes8Lx2KBDj2BlGJz678mK0DAOnKP7Zpz1PsZxo1Hlv1iLS9d6hJUpOPkHRW0vqi7WhcuC0R1mY+Gl8qpGkIgggRmfVXKxeRaNxcyn6EFpLp+TTDGPMNFLItkRmaOuK0kP7jFJ8xuv+tyrkGUE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR10MB8513.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D4ojMTFDLayVIaDcbzq6sQDeaWukTIWGW3p1UKcXYMzL+G/A9kD7FzVul0W6?=
 =?us-ascii?Q?CLLWcK7irxdLGGZj53cQCak9BTgIrX2jiB++FhZBEk7b0UuUJZexAhwfMPI3?=
 =?us-ascii?Q?31uP1cx6OUT3KdLzdPI7MqeXXIEGlYKbinI19CDLDUpsRNZywtOQDtdgpqta?=
 =?us-ascii?Q?73lU787idT8RfJvIJPe1zFX447p8zaqJbUIuu8LCVNFE8FqoWZ0HMb1LkEZU?=
 =?us-ascii?Q?D1X/bggHBX7sD8OvA9ijMGa747wfUBWxNGdf3j0RCOp0KMoyHA03txd5rkRr?=
 =?us-ascii?Q?zi9J+Sztac7gHouFxaZhvsOzxlRTyLJodWyFt0oYeOFQJY4nOZ3nsavHrMyT?=
 =?us-ascii?Q?6OWkd5z+EKJjAUlEp8C7KXebqFVgTaczUvbrtJsxtBSxAfMb6j58EfEoRpWq?=
 =?us-ascii?Q?Js8JC9+ZxY97SV81Mi7V02SAGubK2Vm6mA9jGuqwEqYgA/iRtbKsdm2EBsWE?=
 =?us-ascii?Q?lr7+8O/oC5o3nwX45HhXWhoVB4NX+0nDn4S9WkTsE4nHQTqjQKpFwLem5Meh?=
 =?us-ascii?Q?sMDoyGh8fSkgDhGXKlMlU9olETcNt7UcZxGc9zVJ5I9LXzXhtoTvc3m6U3zq?=
 =?us-ascii?Q?1i0QQahhprkmfApZ8TK185+mN0B/LIJ9naURoIvkun1atFnKClHWJKEr+zv+?=
 =?us-ascii?Q?NrZeI2Cc2rP44lfYQPAeU5wEDoAECLoNnX565ooVHeOP/OIwAZXscbxg4nCA?=
 =?us-ascii?Q?BhNN8xP3SC6EYWEbQ5pqPcZ7Jk9b2OHnyT0D1233rsOO5yoOLpUtkaewNkzq?=
 =?us-ascii?Q?UJ3dL2O+xXHsUNoxuQci2zqJDdD1hksnfSKJ4onMtPmQO7D6cZO58B5Cn1FG?=
 =?us-ascii?Q?p4W64/7Ea3fCygTCOrYI11FAoTum8hek75C1W4pKIdMTcfPjut5AAQDRzYYS?=
 =?us-ascii?Q?v6jByTNYKUc/IaDlXuS6Lr6pVpEsBqBC4AChkgu1Uu7rHaTLVO1Hj8g7dcUl?=
 =?us-ascii?Q?M2u3q1uCAtQeIjjZ5+PKX03hGMuGJYK+KUK6DqA7+WKM5cpL7WfvLbIq7JFC?=
 =?us-ascii?Q?kxOAA4lCpaypMyut4Z/+Ko8wJ9J9TgJ8eobvtr6i/5Ewg0axtWG+45e3BrRd?=
 =?us-ascii?Q?5hELyLiJi/kGqNAgfiWl1FJEOkQFcdmJQ3ryeRNk+VY6KtlYZDwmnWQC5/uU?=
 =?us-ascii?Q?MPyr6MMhV7z1uYuF+i6it/UXnknyIUP9NqQnBWPOTpnvaXze+ClBmahsL4lr?=
 =?us-ascii?Q?FoCyQxkBTs5FVcm2KgS/sXABUAzBNXf6OFzUdUKrtn1JWwy35nUgbsB5uAdW?=
 =?us-ascii?Q?gRf8CfWgYP55NxDJoBaDGHhjY/Blp2rMmROPVBx6fnwuur9fkBacRqE/1fBP?=
 =?us-ascii?Q?m7bxVfGDq/q2PUUalPZN8ycMxZZg57dJ3BcLWYEXW10ULDOIcKG8ndZKcRjy?=
 =?us-ascii?Q?qdt6KZnK23IUfEo+0Q9j+52tWI+sPeScQWvd3vckmhH2QED0oaL8/JK89UKh?=
 =?us-ascii?Q?8HrIyz49n1xaeCMCfkQBXLgZwRSJqjn0NtMldHIPQ14ENPVf2f5H8HC2ybie?=
 =?us-ascii?Q?/XvuBZKI5/j0iUNLmycpbradTxCOqQNXfZDmuIsd6db7/q95+Aeu94AI1rqc?=
 =?us-ascii?Q?rir1F/1numQtff7HNESbM2x9+YfmGrfz6ONO+E/yvYjtnAIE/kcyRejNrlMn?=
 =?us-ascii?Q?hEt/PpX+YykBeYxGzL+CA8an7DyVlDhjpDIGEmcA+LDPVMPmXOsAoRr1SNWF?=
 =?us-ascii?Q?V6JY7ZBHnpbHs4vaOuj6lgD5emtHcfsDIvvz9DbpGwBtcCFKnJcj/tKkb6kF?=
 =?us-ascii?Q?ek6BwCfl+1U0SJHAPWoZRApdVG3zo27JTWohL7AWF9eOYBGLRk0j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EElC/AUlSvCti1kIuCiu2IMWVjZoiEIW+8Te2/EgK9Db3J1XSP0Vw5YdDb4nHSk12EKPbiVbjEQ/GFr+ecbxxM+rD1hHRmUjvGKyXjdZ54bJ5680zs9DyPY0PfVlTtD/SeRKuIINnwheX8l0oh0SXH1EL1YpIB6yiRmd884fhcQIxr3LBYicYney07VRfrTX2ePOnxfHTpYIyY/8c/JUxDGq7y6ar0QiBId+cuvf5PlKYpmvPVShqugQGgWeiDw7uJxnUY2d2fkfMD971rwwgEuYiAUbKA3ZfSNv/xLevMXcBRPz2y8UfQHQllhSSBt3huTm2E2UPQauQXJSc+Dt/Q6R2gcj86UTXFU3WPtWZIcjOF4OKek0n1ujq/stpIx40XiYEkp7nfSoroa5I4bLyZIsv7zH4aM1eb34d3gSo+o0+dbeJkCeOzoETBPt4BoY+AuhpLe+ExPp+wn2A1JbLDd25MHZFDqbp0twQlbNjqYBikd29NiTfdBIyjGnMeNY8u+cwFctFHMJ0Nsm225qpOdPt1S4OcJAjAeH3epUjd9Us7JXkSmXiuJD6SFiYjyTEwk4czQIFkUhdqfyK/5XC5rw9YXYwKi/KYaYnA2mMEQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc2168d-58fe-48ee-0adb-08de7a516385
X-MS-Exchange-CrossTenant-AuthSource: IA3PR10MB8513.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 00:51:51.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbozRfKunxRaZ6SYNVRsA3mYypgPIWYGcPzG9roi8gkQqMhHmyconl+EmYbkQuG7UcEiD4CHB0C87K2BxowqBdZ2aMsCMSc1a5Ux0Hx4fJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603050005
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDAwNSBTYWx0ZWRfXzjh+ee5ec/zp
 WyVfU96AaWl68Thqb7QeUj1z1VC89AcqFtPcPfRPQJDN3sNS1qNqeovVf4NNkG9WSvmRcyQm+Ha
 cGqRikZhYRPy/r6tDmgNb3ILjl/9kGHQCEiQZJdL2mPpVJiHhSaQvaP555nFruaGcS3RT1hS2xE
 yYg1MtTdFcfj2bhE+FD6FqnlNfkHyaXk4J8AMN6qPQjn0XjVbClONZKwyphhVBMMCdC9sxp8b8+
 FaPVVrEfyKcj2ETX2sYqjlXSTFlofdZziAeb7tUY8k/LotPbZw7sJkJV8w0z6SUH0a1xFqqlatp
 WLBjMqwst9qPbGSO+Zs/tex7Vy/KbYig4CW9rb0c+z9ZunljiYhurx4xi20P5KLUSIbTh6NX5Ei
 U4i3C9IXE93DJLcrLpqO3xAMbhLspS5yl1EXbqbN2IbCBhk6H5g4nXEZepmXx+R2EVMbqngcxyP
 LybrbPtVD2GQWVVQ2YpMEnZwcQ8Fc8nRcEvHsWKk=
X-Proofpoint-ORIG-GUID: wXCly8sDVnARkhmGWw3PQ04oNuRZweIP
X-Proofpoint-GUID: wXCly8sDVnARkhmGWw3PQ04oNuRZweIP
X-Authority-Analysis: v=2.4 cv=ZpXg6t7G c=1 sm=1 tr=0 ts=69a8d434 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=K9Bnybq7SwU28GRxuWIA:9 cc=ntf awl=host:12267

Hello,

Here is a v2 of the patch I sent the other day that corrects the issues
with exit codes as well as allowing the new test_lib.sh to run with
non-bash interpreters. I have tested this with the github CI and it
works as expected. Please let me know if there is anything else that
needs to change.

Bruce

---

Simple refactoring of the testsuite with the creation of a shared
library (tests/test_lib.sh).
Additions include:
* Getters to find vmlinux.
* Functions to open tmp dirs and tmp files.
* Functions to automatically clean tmp dirs and files on pass.
* On fail, tmp dirs are preserved.
* Functions to pass/fail/skip/softfail tests (works with CI).
* Logging functions with varying verbosity levels.
* Compatible with non-bash interpreters (for perf tests).
* Colors.

Signed-off-by: Bruce McCulloch <bruce.mcculloch@oracle.com>
---
 tests/btf_functions.sh        | 143 ++++++++++-----------------
 tests/default_vmlinux_btf.sh  |  18 ++--
 tests/flexible_arrays.sh      |  48 +++++-----
 tests/pfunct-btf-decl-tags.sh |  34 +++----
 tests/prettify_perf.data.sh   |  51 +++++-----
 tests/reproducible_build.sh   |  47 ++++-----
 tests/test_lib.sh             | 176 ++++++++++++++++++++++++++++++++++
 tests/tests                   |  28 +++---
 8 files changed, 345 insertions(+), 200 deletions(-)
 create mode 100755 tests/test_lib.sh

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index ee0f9ff..127640e 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -8,45 +8,22 @@
 # also should have been.
 #
 
-outdir=
-
-fail()
-{
-	# Do not remove test dir; might be useful for analysis
-	trap - EXIT
-	if [[ -d "$outdir" ]]; then
-		echo "Test data is in $outdir"
-	fi
-	exit 1
-}
-
-cleanup()
-{
-	rm ${outdir}/*
-	rmdir $outdir
-}
-
-vmlinux=${vmlinux:-$1}
-
-if [ -z "$vmlinux" ] ; then
-	vmlinux=$(pahole --running_kernel_vmlinux)
-	if [ -z "$vmlinux" ] ; then
-		echo "Please specify a vmlinux file to operate on"
-		exit 2
-	fi
-fi
+source test_lib.sh
 
-if [ ! -f "$vmlinux" ] ; then
-	echo "$vmlinux file not available, please specify another"
-	exit 2
+vmlinux=$(get_vmlinux $1)
+if [ $? -ne 0 ] ; then
+	info_log "$vmlinux"
+	test_fail
 fi
 
-outdir=$(mktemp -d /tmp/btf_functions.sh.XXXXXX)
+outdir=$(make_tmpdir)
 
+# Comment this out to save test data.
 trap cleanup EXIT
 
-echo -n "Validation of BTF encoding of functions; this may take some time: "
-test -n "$VERBOSE" && printf "\nEncoding..."
+title_log "Validation of BTF encoding of functions."
+info_log "This may take some time."
+verbose_log "Encoding..."
 
 # Here we use both methods so that we test pahole --lang_exclude, that is
 # used in the Linux kernel BTF encoding phase, and as well to make sure all
@@ -57,7 +34,7 @@ export PAHOLE_LANG_EXCLUDE=rust
 pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |\
 	grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
 
-test -n "$VERBOSE" && printf "done.\n"
+verbose_log "done."
 
 funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf 2>/dev/null|sort)
 
@@ -87,8 +64,8 @@ while IFS= read -r btf ; do
 			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
 				const_insensitive=$((const_insensitive+1))
 			else
-				echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
-				fail
+				error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
+				test_fail
 			fi
 		else
 			inline=$((inline+1))
@@ -98,13 +75,11 @@ while IFS= read -r btf ; do
 	fi
 done < $outdir/btf.funcs
 
-if [[ -n "$VERBOSE" ]]; then
-	echo "Matched $exact functions exactly."
-	echo "Matched $inline functions with inlines."
-	echo "Matched $const_insensitive functions with multiple const/non-const instances."
-	echo "Ok"
-	echo "Validation of skipped function logic..."
-fi
+verbose_log "Matched $exact functions exactly."
+verbose_log "Matched $inline functions with inlines."
+verbose_log "Matched $const_insensitive functions with multiple const/non-const instances."
+verbose_log "Ok"
+verbose_log "Validation of skipped function logic..."
 
 skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{ print $1}')
 
@@ -113,16 +88,14 @@ for s in $skipped_fns ; do
 	# Ensure the skipped function are not in BTF
 	inbtf=$(grep " $s(" $outdir/btf.funcs)
 	if [[ -n "$inbtf" ]]; then
-		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
-		fail
+		error_log "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
+		test_fail
 	fi
 done
 
-if [[ -n "$VERBOSE" ]]; then
-	echo "Skipped encoding $skipped_cnt functions in BTF."
-	echo "Ok"
-	echo "Validating skipped functions have incompatible return values..."
-fi
+verbose_log "Skipped encoding $skipped_cnt functions in BTF."
+verbose_log "Ok"
+verbose_log "Validating skipped functions have incompatible return values..."
 
 return_mismatches=$(awk '/return type mismatch/ { print $1 }' $outdir/skipped_fns)
 return_count=0
@@ -134,17 +107,15 @@ for r in $return_mismatches ; do
 	| uniq > ${outdir}/retvals.$r
 	cnt=$(wc -l ${outdir}/retvals.$r | awk '{ print $1 }')
 	if [[ $cnt -lt 2 ]]; then
-		echo "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
-		fail
+		error_log "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
+		test_fail
 	fi
 	return_count=$((return_count+1))
 done
 
-if [[ -n "$VERBOSE" ]]; then
-	echo "Found $return_count functions with multiple incompatible return values."
-	echo "Ok"
-	echo "Validating skipped functions have incompatible params/counts..."
-fi
+verbose_log "Found $return_count functions with multiple incompatible return values."
+verbose_log "Ok"
+verbose_log "Validating skipped functions have incompatible params/counts..."
 
 param_mismatches=$(awk '/due to param / { print $1 }' $outdir/skipped_fns)
 
@@ -169,10 +140,8 @@ for p in $param_mismatches ; do
 		if [[ -n "$inlined" ]]; then
 			multiple_inline=$((multiple_inline+1))
 		else
-			if [[ -n "$VERBOSE" ]]; then
-				echo "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
-				echo "Full skip message from pahole: $skipmsg"
-			fi
+			verbose_log "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
+			verbose_log "Full skip message from pahole: $skipmsg"
 			warnings=$((warnings+1))
 		fi
 	else
@@ -180,24 +149,22 @@ for p in $param_mismatches ; do
 	fi
 done
 
-if [[ -n "$VERBOSE" ]]; then
-	echo "Found $multiple instances with multiple instances with incompatible parameters."
-	echo "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
-	echo "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
-	echo "Found $warnings instances where pfunct did not notice inconsistencies."
-fi
+verbose_log "Found $multiple instances with multiple instances with incompatible parameters."
+verbose_log "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
+verbose_log "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
+verbose_log "Found $warnings instances where pfunct did not notice inconsistencies."
 
 # Some specific cases can not  be tested directly with a standard kernel.
 # We can use the small binary in bin/ to test those cases, like packed
 # structs passed on the stack.
 
-test -n "$VERBOSE" && echo -n "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
+verbose_log "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
 
-test -n "$VERBOSE" && printf "\nBuilding test_bin..."
+verbose_log "Building test_bin..."
 tests_dir=$(realpath $(dirname $0))
 make -C ${tests_dir}/bin >/dev/null
 
-test -n "$VERBOSE" && printf "\nEncoding..."
+verbose_log "Encoding..."
 pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/test_bin.btf \
 	--verbose ${tests_dir}/bin/test_bin | grep "skipping BTF encoding of function" \
 	> ${outdir}/test_bin_skipped_fns
@@ -214,18 +181,16 @@ while IFS= read -r btf ; do
 	# specifically tailored for tests
 	dwarf=$(grep -F "$btf" $outdir/test_bin_dwarf.funcs)
 	if [[ "$btf" != "$dwarf" ]]; then
-		echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
-		fail
+		error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
+		test_fail
 	else
 		exact=$((exact+1))
 	fi
 done < $outdir/test_bin_btf.funcs
 
-if [[ -n "$VERBOSE" ]]; then
-	echo "Matched $exact functions exactly."
-	echo "Ok"
-	echo "Validation of skipped function logic..."
-fi
+verbose_log "Matched $exact functions exactly."
+verbose_log "Ok"
+verbose_log "Validation of skipped function logic..."
 
 skipped_cnt=$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}')
 
@@ -234,16 +199,14 @@ for s in $skipped_fns ; do
 	# Ensure the skipped function are not in BTF
 	inbtf=$(grep " $s(" $outdir/test_bin_btf.funcs)
 	if [[ -n "$inbtf" ]]; then
-		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
-		fail
+		error_log "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
+		test_fail
 	fi
 done
 
-if [[ -n "$VERBOSE" ]]; then
-	echo "Skipped encoding $skipped_cnt functions in BTF."
-	echo "Ok"
-	echo "Validating skipped functions have uncertain parameter location..."
-fi
+verbose_log "Skipped encoding $skipped_cnt functions in BTF."
+verbose_log "Ok"
+verbose_log "Validating skipped functions have uncertain parameter location..."
 
 uncertain_loc=$(awk '/due to uncertain parameter location/ { print $1 }' $outdir/test_bin_skipped_fns)
 legitimate_skip=0
@@ -266,12 +229,10 @@ for f in $uncertain_loc ; do
 			fi
 		fi
 	done
-	echo "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
-	fail
+	error_log "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
+	test_fail
 done
 
-if [[ -n "$VERBOSE" ]]; then
-	echo "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
-fi
-echo "Ok"
-exit 0
+verbose_log "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
+
+test_pass
diff --git a/tests/default_vmlinux_btf.sh b/tests/default_vmlinux_btf.sh
index a855ca7..496e840 100755
--- a/tests/default_vmlinux_btf.sh
+++ b/tests/default_vmlinux_btf.sh
@@ -1,6 +1,7 @@
 #!/bin/bash
+source test_lib.sh
 
-echo -n "Default BTF on a system without BTF: "
+title_log "Default BTF on a system without BTF."
 
 ulimit -c 0
 
@@ -13,8 +14,7 @@ ulimit -c 0
 nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole -F btf list_head 2>&1 | wc -l)
 
 if [ $nr_lines -eq 0 ] ; then
-	echo "FAILED"
-	exit 1
+	test_softfail
 fi
 
 # There is also the case where no debugging info is available, be it DWARF of
@@ -22,11 +22,15 @@ fi
 # that as well
 #
 nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole 2>&1 | wc -l)
+nr_lines=0
 
 if [ $nr_lines -eq 0 ] ; then
-	echo "FAILED"
-	exit 1
+	test_softfail
 fi
 
-echo "Ok"
-exit 0
+check_softfail
+if [ $? -eq 2 ] ; then
+	test_fail
+else
+	test_pass
+fi
\ No newline at end of file
diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
index 59fa38e..4e9e995 100755
--- a/tests/flexible_arrays.sh
+++ b/tests/flexible_arrays.sh
@@ -5,22 +5,23 @@
 #
 # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
 
-vmlinux=${vmlinux:-$1}
+source test_lib.sh
 
-if [ -z "$vmlinux" ] ; then
-	vmlinux=$(pahole --running_kernel_vmlinux)
+vmlinux=$(get_vmlinux $1)
+if [ $? -ne 0 ] ; then
+	info_log "$vmlinux"
+	test_fail
 fi
 
-if [ ! -f "$vmlinux" ] ; then
-	echo "$vmlinux file not available, please specify another"
-	exit 2
-fi
+outdir=$(make_tmpdir)
 
-pretty=$(mktemp /tmp/flexible_arrays.data.sh.XXXXXX.c)
+# Comment this out to save test data.
+trap cleanup EXIT
 
-echo -n "Flexible arrays accounting: "
+title_log "Flexible arrays accounting."
 
 for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux | cut -f1) ; do
+	pretty=$(make_tmpsrc)
 	pahole $struct $vmlinux > $pretty
 
 	# We need to check for just one tab before the comment as when expanding unnamed
@@ -48,30 +49,27 @@ for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux |
 	[ -z "$stat_nr_flexible_arrays" ] && stat_nr_flexible_arrays=0
 	stat_nr_embedded_flexible_arrays=$(grep "flexible array members:.*middle:" $pretty | sed -r 's/.*middle: *([[:digit:]]+).*/\1/g')
 	[ -z "$stat_nr_embedded_flexible_arrays" ] && stat_nr_embedded_flexible_arrays=0
-	test -n "$VERBOSE" && echo "end: $struct: $nr_flexible_arrays $stat_nr_flexible_arrays"
-	test -n "$VERBOSE" && echo "middle: $struct: $nr_embedded_flexible_arrays $stat_nr_embedded_flexible_arrays"
+	verbose_log "end: $struct: $nr_flexible_arrays $stat_nr_flexible_arrays"
+	verbose_log "middle: $struct: $nr_embedded_flexible_arrays $stat_nr_embedded_flexible_arrays"
 
 	if [ "$nr_embedded_flexible_arrays" != "$stat_nr_embedded_flexible_arrays" ] ; then
-		test -n "$VERBOSE" && printf "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
+		verbose_log "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
 			"$struct" "$stat_nr_embedded_flexible_arrays" "$nr_embedded_flexible_arrays"
-		test -n "$VERBOSE" && pahole $struct $vmlinux
-		FAILED=1
+		verbose_log pahole $struct $vmlinux
+		test_softfail
 	fi
 
 	if [ "$nr_flexible_arrays" != "$stat_nr_flexible_arrays" ] ; then
-		test -n "$VERBOSE" && printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
+		verbose_log printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
 			"$struct" "$stat_nr_flexible_arrays" "$nr_flexible_arrays"
-		test -n "$VERBOSE" && pahole $struct $vmlinux
-		FAILED=1
+		verbose_log pahole $struct $vmlinux
+		test_softfail
 	fi
-
-	rm -f $pretty
 done
 
-if [ -n "$FAILED" ] ; then
-	echo "FAILED"
-	exit 1
+check_softfail
+if [ $? -ne 0 ] ; then
+	test_fail
+else
+	test_pass
 fi
-
-echo "Ok"
-exit 0
diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
index 69babef..35884b4 100755
--- a/tests/pfunct-btf-decl-tags.sh
+++ b/tests/pfunct-btf-decl-tags.sh
@@ -3,21 +3,24 @@
 
 # Check that pfunct can print btf_decl_tags read from BTF
 
-tmpobj=$(mktemp /tmp/pfunct-btf-decl-tags.sh.XXXXXX.o)
+source test_lib.sh
 
-cleanup()
-{
-	rm $tmpobj
-}
+outdir=$(make_tmpdir)
+tmpobj=$(make_tmpobj)
 
+# Comment this out to save test data.
 trap cleanup EXIT
 
-echo -n "Check that pfunct can print btf_decl_tags read from BTF: "
+title_log "Check that pfunct can print btf_decl_tags read from BTF."
+
+# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
+# in upstream version 16.
+# UPTODO: add a check here for that.
 
 CLANG=${CLANG:-clang}
 if ! command -v $CLANG > /dev/null; then
-	echo "Need clang for test $0"
-	exit 1
+	error_log "Need clang for test $0"
+	test_fail
 fi
 
 (cat <<EOF
@@ -55,13 +58,12 @@ out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
 d=$(diff -u <(echo "$expected") <(echo "$out"))
 
 if [[ "$d" == "" ]]; then
-	echo "Ok"
-	exit 0
+	test_pass
 else
-	echo "pfunct output does not match expected:"
-	echo "$d"
-	echo
-	echo "Complete output:"
-	echo "$out"
-	exit 1
+	error_log "pfunct output does not match expected:"
+	info_log "$d"
+	info_log
+	info_log "Complete output:"
+	info_log "$out"
+	test_fail
 fi
diff --git a/tests/prettify_perf.data.sh b/tests/prettify_perf.data.sh
index 2d16cf5..1fae951 100755
--- a/tests/prettify_perf.data.sh
+++ b/tests/prettify_perf.data.sh
@@ -7,30 +7,35 @@
 # Check if the perf binary is available, if it is from a distro, normally it
 # will get the needed DWARF info using libddebuginfod, we'll check if the
 # needed types are available, skipping the test and informing the reason.
+. ./test_lib.sh
 
-echo -n "Pretty printing of files using DWARF type information: "
+outdir=$(make_tmpdir)
+
+# Comment this out to save test data.
+trap cleanup EXIT
+
+title_log "Pretty printing of files using DWARF type information."
 
 perf=$(which perf 2> /dev/null)
 if [ -z "$perf" ] ; then
-	echo "skip: No 'perf' binary available"
-	exit 2
+	info_log "skip: No 'perf' binary available"
+	test_skip
 fi
 
 perf_lacks_type_info() {
 	local type_keyword=$1
 	local type_name=$2
 	if ! pahole -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
-		echo "skip: $perf doesn't have '$type_keyword $type_name' type info"
-		return 1
+		info_log "skip: $perf doesn't have '$type_keyword $type_name' type info"
+		test_skip
 	fi
-	return 0
 }
 
-perf_data=$(mktemp /tmp/prettify_perf.data.sh.XXXXXX.perf.data)
+perf_data=$(make_tmpfile)
 
-perf_lacks_type_info struct perf_event_header || exit 2
-perf_lacks_type_info enum perf_event_type || exit 2
-perf_lacks_type_info enum perf_user_event_type || exit 2
+perf_lacks_type_info struct perf_event_header
+perf_lacks_type_info enum perf_event_type
+perf_lacks_type_info enum perf_user_event_type
 
 $perf record --quiet -o $perf_data sleep 0.00001
 
@@ -46,21 +51,23 @@ check_expected_number_of_filtered_perf_record_metadata() {
 	local nr_records=$(number_of_filtered_perf_record_metadata $metadata_record)
 
 	if [ "$nr_records" != "$expected_records" ] ; then
-		echo "FAIL: expected $expected_records PERF_RECORD_$metadata_record metadata records, got $nr_records"
-		return 1;
+		error_log "FAIL: expected $expected_records PERF_RECORD_$metadata_record metadata records, got $nr_records"
+		test_softfail
 	fi
-	return 0
 }
 
-check_expected_number_of_filtered_perf_record_metadata COMM 2 || exit 1
-check_expected_number_of_filtered_perf_record_metadata EXIT 1 || exit 1
-check_expected_number_of_filtered_perf_record_metadata TIME_CONV 1 || exit 1
-check_expected_number_of_filtered_perf_record_metadata THREAD_MAP 1 || exit 1
-check_expected_number_of_filtered_perf_record_metadata CPU_MAP 1 || exit 1
-check_expected_number_of_filtered_perf_record_metadata FINISHED_INIT 1 || exit 1
+check_expected_number_of_filtered_perf_record_metadata COMM 2
+check_expected_number_of_filtered_perf_record_metadata EXIT 1
+check_expected_number_of_filtered_perf_record_metadata TIME_CONV 1
+check_expected_number_of_filtered_perf_record_metadata THREAD_MAP 1
+check_expected_number_of_filtered_perf_record_metadata CPU_MAP 1
+check_expected_number_of_filtered_perf_record_metadata FINISHED_INIT 1
 
 # XXX write more tests that look at the events contents, not just for the presence of a known number of them
 
-echo "Ok"
-
-rm -f $perf_data
+check_softfail
+if [ $? -ne 0 ] ; then
+	test_fail
+else
+	test_pass
+fi
diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index a940d93..d8c6507 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -4,22 +4,22 @@
 # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
 # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
 
-vmlinux=${vmlinux:-$1}
+source test_lib.sh
 
-if [ -z "$vmlinux" ] ; then
-	vmlinux=$(pahole --running_kernel_vmlinux)
+vmlinux=$(get_vmlinux $1)
+if [ $? -ne 0 ]; then
+	info_log "$vmlinux"
+	test_fail
 fi
 
-if [ ! -f "$vmlinux" ] ; then
-	echo "$vmlinux file not available, please specify another"
-	exit 2
-fi
+outdir=$(make_tmpdir)
 
-outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
+# Comment this out to save test data.
+trap cleanup EXIT
 
-echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
+title_log "Parallel reproducible DWARF Loading/Serial BTF encoding."
 
-test -n "$VERBOSE" && printf "\nserial encoding...\n"
+verbose_log "Begin serial encoding..."
 
 # This will make pahole and pfunct to skip rust CUs
 export PAHOLE_LANG_EXCLUDE=rust
@@ -30,37 +30,32 @@ bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinu
 nr_proc=$(getconf _NPROCESSORS_ONLN)
 
 for threads in $(seq $nr_proc) ; do
-	test -n "$VERBOSE" && echo $threads threads encoding
+	verbose_log "$threads threads encoding"
 	pahole -j$threads --btf_features=default,reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
 	pahole=$!
 	# HACK: Wait a bit for pahole to start its threads
-	sleep 0.3s
+	sleep 1s
 	# PID part to remove ps output headers
 	nr_threads_started=$(ps -L -C pahole | grep -v PID | wc -l)
-        ((nr_threads_started -= 1)) # main thread doesn't count, it waits to join
+		((nr_threads_started -= 1)) # main thread doesn't count, it waits to join
 
 	if [ $threads != $nr_threads_started ] ; then
-		echo "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
-		exit 1;
+		error_log "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
+		test_fail
 	fi
 
 	# ps -L -C pahole | grep -v PID | nl
-	test -n "$VERBOSE" && echo $nr_threads_started threads started
+	verbose_log "$nr_threads_started threads started"
 	wait $pahole
 	rm -f $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
 	bpftool btf dump file $outdir/vmlinux.btf.parallel.reproducible > $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
-	test -n "$VERBOSE" && echo "diff from serial encoding:"
+	verbose_log "diff from serial encoding:"
 	diff -u $outdir/bpftool.output.vmlinux.btf.serial $outdir/bpftool.output.vmlinux.btf.parallel.reproducible > $outdir/diff
 	if [ -s $outdir/diff ] ; then
-		echo "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
-		exit 1
+		error_log "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
+		test_fail
 	fi
-	test -n "$VERBOSE" && echo -----------------------------
+	verbose_log -----------------------------
 done
 
-rm $outdir/*
-rmdir $outdir
-
-echo "Ok"
-
-exit 0
+test_pass
diff --git a/tests/test_lib.sh b/tests/test_lib.sh
new file mode 100755
index 0000000..8c235da
--- /dev/null
+++ b/tests/test_lib.sh
@@ -0,0 +1,176 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2026, Oracle and/or its affiliates.
+#
+# Common helper functions for the testsuite.
+#
+
+# if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
+# 	echo "This script is meant to be sourced. Please use 'source test_lib.sh'."
+# 	exit 1
+# fi
+
+check_color_support()
+{
+	if [ ! -z "$color_support" ] ; then
+		return $color_support
+	else
+		if tput colors >/dev/null 2>&1; then
+			num_colors=$(tput colors)
+			if [ $num_colors -gt 0 ] && [ -n "$BASH_VERSION" ] ; then
+				RED='\033[0;31m'
+				GREEN='\033[0;32m'
+				YELLOW='\033[0;33m'
+				NC='\033[0m'
+				color_support=1
+			else
+				RED=''
+				GREEN=''
+				YELLOW=''
+				NC=''
+				color_support=0
+			fi
+		else
+			RED=''
+			GREEN=''
+			YELLOW=''
+			NC=''
+			color_support=0
+		fi
+	fi
+	return $color_support
+}
+
+color_print()
+{
+	check_color_support
+	if [ $? -eq 1 ] ; then
+		echo -e "$1$2${NC}"
+	else
+		echo $1
+	fi
+}
+
+get_vmlinux()
+{
+	
+	vmlinux=${vmlinux:-$1}
+
+	if [ -z "$vmlinux" ] ; then
+		vmlinux=$(pahole --running_kernel_vmlinux)
+		if [ -z "$vmlinux" ] ; then
+			color_print ${RED} "Please specify a vmlinux file to operate on"
+			exit 2
+		fi
+	fi
+
+	if [ ! -f "$vmlinux" ] ; then
+		echo ${RED} "$vmlinux file not available, please specify another"
+		exit 2
+	fi
+
+	echo $vmlinux
+	return 0
+}
+
+make_tmpdir()
+{
+	outdir=$(mktemp -d /tmp/$(basename "$0").XXXXXX)
+	echo $outdir
+	return 0
+}
+
+make_tmpobj()
+{
+	outobj=$(mktemp $outdir/$0.obj.XXXXXX.o)
+	echo $outobj
+	return 0
+}
+
+make_tmpsrc()
+{
+	outsrc=$(mktemp $outdir/$0.src.XXXXXX.c)
+	echo $outsrc
+	return 0
+}
+
+make_tmpfile()
+{
+	outfile=$(mktemp $outdir/$0.data.XXXXXX)
+	echo $outfile
+	return 0
+}
+
+info_log()
+{
+	printf "   "
+	echo $1
+}
+
+title_log()
+{
+	color_print ${YELLOW} "$1"
+}
+
+verbose_log()
+{
+	if [[ -n "$VERBOSE" ]]; then
+		printf "   "
+		echo $1
+	fi
+}
+
+error_log()
+{
+	printf "   "
+	color_print $RED "${1}"
+}
+
+test_softfail()
+{
+	if [ -z "$softfail_count" ] ; then
+		softfail_count=1
+	else
+		softfail_count=$((softfail_count + 1))
+	fi
+}
+
+test_fail()
+{
+	trap - EXIT
+	color_print ${RED} "Test $0 failed"
+	if [ -d "$outdir" ]; then
+		color_print ${RED} "Test data is in $outdir"
+	fi
+	exit 1
+}
+
+check_softfail()
+{
+	if [ ! -z "$softfail_count" ] ; then
+		color_print ${RED} "Soft failures: $softfail_count"
+		return 1
+	else
+		return 0
+	fi
+}
+
+test_pass()
+{
+	color_print ${GREEN} "Test $0 passed"
+	exit 0
+}
+
+test_skip()
+{
+	color_print ${YELLOW} "Skipping test ..."
+	exit 2
+}
+
+cleanup()
+{
+	rm ${outdir}/*
+	rmdir $outdir
+	return 0
+}
diff --git a/tests/tests b/tests/tests
index 11921ad..b4116ce 100755
--- a/tests/tests
+++ b/tests/tests
@@ -8,19 +8,21 @@ cd $tests_dir
 let status=0
 let nr=1
 for test in *.sh ; do
-	printf "%3d: " $nr
-	./$test
-	case $? in
-	0)
-		;;
-	2)
-		echo "skipping..."
-		;;
-	*)
-		status=1
-		;;
-	esac
-	let nr+=1
+	if [ $test != "test_lib.sh" ]; then
+		printf "%d: $test\n" $nr
+		./$test $1
+		case $? in
+		0)
+			;;
+		2)
+			;;
+		*)
+			status=1
+			;;
+		esac
+		let nr+=1
+		echo "---"
+	fi
 done
 
 cd -
-- 
2.47.3

