Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3642848C
	for <dwarves@vger.kernel.org>; Mon,  2 Mar 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471580; cv=fail; b=b/gbl1hHOaU/f/uqjjwMIcD0XhcOqHQUtFcs9ZdhTyznej/SP8B4/8odIMgZz7ekx+ej7zMMfDtWqetny4P2CXEEe1cCbzQq8VCaBx/aegvuX15sMZ3pCZLXJJV5mA4Ce43KoES+1v7IJciXxlz9Jk8k2GRJRc4KfW+fukQgHdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471580; c=relaxed/simple;
	bh=onI1DvnIcTID1p9iZ7KSyRs0UoY69dSEY5vIybeOYmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6byBn2vjkAxr0nsMdhTdlb3osH3NZeRz450JPMWcP6kSm7hLVEhc/Qj8HThIhBhakHbq3IIWBnAni9shHE7+/kKSlOx8hxgsfx8WUjM7bAlz6r0vZ/PsCQvt3sYuv77b+X5osn1luoaF46XnRyOw5iFU9xqmBbsW7Xyjq8m0W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SONw35Vv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YhRPjacR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SONw35Vv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YhRPjacR"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622GuQeU2546760
	for <dwarves@vger.kernel.org>; Mon, 2 Mar 2026 17:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cLpzSraFLtIT9JVNI/m4CW2OPu81wFqaCMa3n5/k4Mk=; b=
	SONw35VvdEbBDwrRpY2YjXUPZLTO1rEWlOxRMwaTrJDS3IGNCwt8g3s9zs0XwF1K
	9Xt5VhHYYJJpS6bmXbDcQ77vagsRIq627lAxBPY89kiHQyt365wqFDi8UAyMttFF
	2nGU0YspPaxH+KSG3fc+hX9xSaifL3T6LGQnSRPLFvnIFbj3zACZcHUo3fMEsniF
	n8XEzFX6W85Vq54VM6Um1BnTcbDOgfOPCpWnIJC0Px34M2Pw+H3TQVSJhCblCk/o
	yPGWFM5U/BHFV1v26zlM3unvlZ17zGKbGp62dvBMQi17224AT419P7ASaqSIne+d
	+v20f/EGX8OjVEZeYh5ABw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnegr80wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 02 Mar 2026 17:12:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622Fi5Yb023091
	for <dwarves@vger.kernel.org>; Mon, 2 Mar 2026 17:12:56 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdgcv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 02 Mar 2026 17:12:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XahNYaZBseRxD0BBWnRz9PtGuR6XNItSe2/uMQ1erFBY0rVGTxCd6CDI1n6NwNAWKjDq9dQaD0MqZjmqW5yDRvJLacBssQ73DpKw3EpcDhICPzJriGTxRUgkHfDj8zH0exjJ7WxYWGbtkHB/9VA/7midO2OHDT4UCiwfmZakS2H4S2m4Y9gH6fUdx2NNTODyph+By4Yy5Dpl0UUcYTirwAP/4jxos2Y8NwkGPXlSxdJfA9eD6eo8tC/olECf4mW2QlX5Mcy806N1MwgZtZdShTdoYlck0yMETwWbGaj4WpFg8I/pMs6AuiI4mgpdFQBM2BUjunzVOrAoXwzXCNwiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLpzSraFLtIT9JVNI/m4CW2OPu81wFqaCMa3n5/k4Mk=;
 b=kG1tHQUREq9pI/PRY60sp1dSro0enDo1P1dsA85Bvt/N9K6wrfOPo9laKzfN1BlDXGtcOgZGXm92E1wmV0fbVbXnlpR/uTYANQl8jmOE4Y2p9Atrz5bFgHta3EvwPh2tdPudVlUy4nQHUhEhz8RkTakzbBT6rxU7cVx8cs/rvbU88Heu2THQE6Oxn97Y6PsofQsdcU+1PxHlBxyODxmvqekTDmUvz/vQGCnH1IEXjyTsqBnS6z66Ob0C34IdFd3RkXhKVoNKia1ShfysMmS2aHhQscJUBIaOHRxvc7VnBOnlnNBH2Rvni3C0UVKzj/In9fPQ8H+LvfCX4sA+ShtfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLpzSraFLtIT9JVNI/m4CW2OPu81wFqaCMa3n5/k4Mk=;
 b=YhRPjacRQbkmm9SqpdOeW2yMKeq097+3KJQ5ZGAPRlXv60ReVeT8pODWF9ahm5/x48GLgqrWdn6i7MooOzTizh+9XupBGljYnemsjlMEnJH49yNgW+6HLBBcmYzVBzFg4rThGzzLAgNl5yx8zJCrrQ8kp77d6y6tOrjT4dbbmzQ=
Received: from IA3PR10MB8513.namprd10.prod.outlook.com (2603:10b6:208:576::12)
 by PH7PR10MB6180.namprd10.prod.outlook.com (2603:10b6:510:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 17:12:51 +0000
Received: from IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61]) by IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61%6]) with mapi id 15.20.9632.010; Mon, 2 Mar 2026
 17:12:51 +0000
From: Bruce McCulloch <bruce.mcculloch@oracle.com>
To: dwarves@vger.kernel.org
Cc: Bruce McCulloch <bruce.mcculloch@oracle.com>
Subject: [PATCH] Refactor selftests
Date: Mon,  2 Mar 2026 09:10:32 -0800
Message-ID: <20260302171033.1003145-3-bruce.mcculloch@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302171033.1003145-2-bruce.mcculloch@oracle.com>
References: <20260302171033.1003145-2-bruce.mcculloch@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To IA3PR10MB8513.namprd10.prod.outlook.com
 (2603:10b6:208:576::12)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR10MB8513:EE_|PH7PR10MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d669b3-393c-40ff-bc56-08de787eef53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	hjowBhEJB11g/+KrPUnV0UQf7TpHvQJs8i0afL4/5C2dL9cz3eI99I3YRgkfPHyNt3fHt5h3z+v3JLPoNf7zFluLNZhkdt78t/o04Gw/gElP5NJzTVPixJL1/MqndS8vp+gtTDRJSSrKp1dDKOCa7uJAtaF4yytjIlXUOLVmIaR/SD5HKJ7ZH8qPYvZ/7wd288Sx8Uf6LMNtLbY+iIAHqJW3ThmKNt9IL4k934iS8YqAbfZnvj9Nl5ECo/5DqrCl8HjknbZG7f7RhHZPEFMmGO/YP6DVdd+uBZr7bcF3cBk8OHSaFWeX2rZnGYdjfkrSSfn/O4/KouGGgHpewWIqA+moChWTYyA7A+SqL2c6s3jPfEMmBubCyFT3GQOSGZzkSzvKRykHls1mOWZotR0xDfz71kUOybX9YvOTQnlboviE+Ul3olW6rkzP8vHlte7LvqwB2dYfLE8ZzqywRyQzA5yUP31O0Qck7nrkDtd/DivMkhR+2hz97bcy6WVVttzCz0Y5c0qIdJoxRGVocEpsj3A2gWvjlywntuPlfc2bTw8CG/o2xe7OaCE8HNIlg9u+M7zI/opiFry7594a9oKMABwdPPaq7Xu4pLshQhFNWIWqrVGPo2IxkDs5yOIuSYVpGlgK7j6auQxrmO1lz1dJnmxYlmTQ3J+NjjBcJpGwMqhzMQvj+gn76i9b5Ma1nmTZppvKPel9qsEk9vj6yOw2NVxfqX0ard4wdrZYRxt1Pa8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR10MB8513.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUVJSXZBaE1rSXBzN3Z0TU05cFIrMzVWaHNSbEo0UHcvUHdlZ3FmWnVlUk1R?=
 =?utf-8?B?RzNrUDhpZ3VKcWJsZHUrMC84dUk2V2ZSa3BZTjkrR1crczdqRktWcWxEYTlp?=
 =?utf-8?B?dDlGTjYyRFNQTk1rVm9VVFhkQ3RKUGdhVUxadkZsWm91NDdpVUVIZWtZem1N?=
 =?utf-8?B?QlhWbWhrNFp2eDhtM2l4c3M2dkZwdVJnSXV4YUtUMUlEemlYYmM5MWVXcEg2?=
 =?utf-8?B?NWZNNmt0Q3Q2YUh6R1pjV3RqVUlOVnN6ZzhTbDVHZkprMzA5ckEwOFk4dXRN?=
 =?utf-8?B?aTNzaU04VnVRcUlkR3RuSGx2WFY4Z25VUGk2VHFPRkswYVQwcHprOFJZcU5m?=
 =?utf-8?B?T3Z6NnZoS0pJUm4rRm5ZOXVndVdxUXJzdVJDZ0FSQ1h2UmduNEMvWXJjY01K?=
 =?utf-8?B?SUxFdnVidXR2RXNoc2tmRUw5TnFzVVoyTlZJaTdJZDk2U1E5ODVpL1dlMkZU?=
 =?utf-8?B?RUR5Uit6T2NsN3dXQUw3T1JnNE9tc2xobzIxUjE1OVFOaHJ5SHpCSWMrSDNH?=
 =?utf-8?B?L2lNUkpjMTdUS0dkMEJZV0FiOWo2YWFpN205YkVFM1lXZmtHSU1CdWpobnNz?=
 =?utf-8?B?QXhOYlJ6cVJxUFE4WEpvM05CUHNHeWxRZzAvVC9nZXpmQjNTNGlCYTVsV09Y?=
 =?utf-8?B?TzJIdVZWYXE3czZvelQwTmlJbXZqcVE4NWJtRzhWMEtvcXpiNGNtWXc5aFI0?=
 =?utf-8?B?akN5NmlHOTVQUDcyWnhiSWpjblVpNGhSV1p4U0tZNnBybG12UC9EMi9CcG9P?=
 =?utf-8?B?cVIvd1VLelQ5SEJqM3R5VHpnVmExVGJnSjdOVGJHZWtkdEhyeGdCUG1TUUNk?=
 =?utf-8?B?cE5iUitvcGFhNU95bjBZSHdZMXFFRFlwdUtwSlQyUXBLTDV1bnVqdnprcmdk?=
 =?utf-8?B?TGdvRE5Ea1RwaGJKdEJvRTVqVWJDSVh0S2FhekllbUtKaTYrMGljUWdxc0N1?=
 =?utf-8?B?bXMxNWFlZG9BTDRzb2F5RFV3OWEwUFZYTEdiYU9BN3dxdVRocXRmdWNsVUkr?=
 =?utf-8?B?ckwzWkZ0WXI0S0tOY2Q2ZEhrb25zdFM2cHNnT1hsUUt0YUZEN0VWd00xVnBz?=
 =?utf-8?B?Zk5HMjNicERkT3pqTTM2MEpvbGoyUVNRamg2MGxHTTRTbXVKWGlwQjhUYW95?=
 =?utf-8?B?c2JobW1INnhHYjB0YnM1MWZ6b0w2Z3ZWL3NQZlFaMGg2QnI3VDArNEZvWDZQ?=
 =?utf-8?B?Mm1GbW1aaEhoY2J6TkcyUkY0Y2lxUnhsNlY3RitKYVdjYlZISmdGeXlKczNm?=
 =?utf-8?B?TjNYcmdwcmx2YS9zVHltanM2S0Zwa1l4UlZZRFBVaitoUW9uNGt4bjN1ZkRs?=
 =?utf-8?B?aW9qc1V5Y09kTnJhMjNoeTFYTzdJdUgvNkFYdEo4VTdJY2VnZlZQYjJzZVR5?=
 =?utf-8?B?Yys5YmovcjEvU3NGcEI2NHNyTFcrTXNyTFpPcDdxTU1qTmpxb2xHWlZNbU85?=
 =?utf-8?B?OVpidEJXOEpLc2JqQ2h4QW9vRmYrZUV6M3oxeFk0aDFPeEw3TWJqRGoxOWJN?=
 =?utf-8?B?aW13Wm9YUnVidWVkOTdWelkwUzMrV0w0OGJid05zNFpzMVFJaW1PM3hlQWtP?=
 =?utf-8?B?ZWhmUU1Lbkt4Q2tqNEFFZENNY0JteVpoTnloSlVGSTcrelN3L3lJTDYrYk13?=
 =?utf-8?B?bmhNNG9VYkh1a0NsU2kxcUhBTis3ODVYTmpRM3BRMXFtODlsTWJ1ejg2bEMx?=
 =?utf-8?B?S21wLzdWd0REQmg5cmt1eVRjWWVWQ0tmbWVFdHJPYTNzM25qSGdhcGE3Nndk?=
 =?utf-8?B?c0RXSHozRzVRQ2QwLzdBUXd2dVdJdUpscUhhcit2bmluZmwwbi9GTmxPNW5U?=
 =?utf-8?B?dlN2eEduUVY5N2RrZEZrUkM0Zml0VjFPNVhlNW5MdjBVb21idEp4MkZ6T0hR?=
 =?utf-8?B?dDlhdUtjTlErQlpuS3BQbkRRbG5WZTVVY1IxT2RZUXdpOUE4MmRzWkVFNU1J?=
 =?utf-8?B?NzJWM2QvWjdueDJWUWVERWN0Z1Bwekh2K3dqV0VCVUFDVHlVU3l0YVZ5UW9O?=
 =?utf-8?B?d2tsMzMrRkNXM25ZQ2hvRDh1eVVRVHN6YWljMjd5aGlaZU9LazF6dUpHTTBO?=
 =?utf-8?B?UGl2b0VsRi9DNThnOVMrQmVGdTNIVGdpY3VyaUs0VE1HYTJJUG9wcnlLUDYv?=
 =?utf-8?B?MksvMFBwcllWbHFiMkZjRENvQ0FPUk9jWS9qdldEUHNwNWNlcHNFWlpjYktG?=
 =?utf-8?B?TXFjQ0E1YlE0a3BzRUFkb2lUdVhMOEtsVmpjWGgrNXJveUxjNXNxbmh5VmU5?=
 =?utf-8?B?T242Q2lqSlJCK0hoMngySXpMVFIrYTRVRUFCVGUyRmt3alhhdjV4K21zdml0?=
 =?utf-8?B?bEEyMXRQOEp1K2VXTitBb0VsbnN0MlVuOVB6STJtYmIvK2dNbkV6ak1wRVFi?=
 =?utf-8?Q?86/Stn6L7fC1HpcM+iWdDnDQvLy271Lui6x27?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F5pplrSZ3N/Y1LeWmxQa1M+3H2zanTkq9AHA+sK/JgO6GTAvlW2ESFYglaLDIpS7gAQ9y/dObUQS30QQd3ek/pZzRSyw1n84dJMSR9psNm2F2c2zear0G5+UStRIvd1MbvqtoHY4zuVKAhPHNIaV0tw1TE2l23DURF0rm/AkRNDtINxkXIWHeYvzeDxtGbZBMKIeICWscyub66+zY+daetlb2LxSz+60n7u+wFhp04de7Os4EAcIrUJEqevrRTcyUMDWa5QlLQ74ReMHSWEzdPkWpU30ufjg36w8SEN/yBeubBd59x03EC5o77zbwoFVcRSM2Lp9rFYMaw6JQzBUe8EDIbGcgQjfgiUQGTU1jKCqFnB6eiTlgEtL3rbk6ZKqmfAGO/i2dmFOoVdDgD0sKlBhI+2yMxEPFdryIS+Us3eBss+mPY2ylVs9tahRo09XxioqDwDN8nYnaefPBgs8FTTTdQdnVELLlbE0+Q7wuxNgObKWYOv4shWKjM482crcfa+tnp9vW2aMEkXogzLPtiNpl1wA8lejuZMWRgh7cpclaKUxKEDea956Z/QpT5PApb32eOFyP9s2CXWA4ncE0SkbPIfFvdt8iB7VO4E7wHE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d669b3-393c-40ff-bc56-08de787eef53
X-MS-Exchange-CrossTenant-AuthSource: IA3PR10MB8513.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 17:12:51.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLpZRJygVNbUY+hH58Yq5eBlCMvtqpW9JTQ7uWpDmGWlCyQe2mM/6LX7maWKsfCXG8uK5OwLqFtuheoZnBGliI1QPNGggWm2aI5NgrXMQr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020140
X-Proofpoint-GUID: DG_pI1qJCJlmqlyNsGVmyO8HX5GWWh7X
X-Authority-Analysis: v=2.4 cv=DrZbOW/+ c=1 sm=1 tr=0 ts=69a5c518 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=K9Bnybq7SwU28GRxuWIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12262
X-Proofpoint-ORIG-GUID: DG_pI1qJCJlmqlyNsGVmyO8HX5GWWh7X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0MCBTYWx0ZWRfX93pGnXMDNVAz
 2ZdlzSz0WXefdYGUI6NcbuicWcoqYxbApS9jjb+AI+HWSfalukMUWmCOj9j0GuzSaXCL+wYpVWB
 geToGLOP9T64GKekGltEke64dlvSfoTGy2mdd+laXFIkkoO5sGtjAdIp9MSgjDk6L6x1AZaWPvO
 wVnqtfg2Gi0LKKf1S9/7DtvH8aGTX/HmjeUY7ZT5kFZCJRyPYqOm9YP4ySfWEulUPwHN5mBSOfW
 CleH/k47IaYDe2XRXXBVtdSo1K/kM4dYaFuDxLBXu1iUQsN8kvoLQsxhsrMQxuCI3d6O7JMRDJ1
 C8OBDQiutd0Dj6z6gPgFDUNw99SkxSAd7SLK861Gv4nN2c7Re+/F7R7isHS84ZFtaSWJf9inS9O
 y5hqCZ1PVFPZVNciwCqoUPWjJaqiV1KPc6CyGW3YOMvPuv0lbstrN1LuWdjm7VDeiJZSy/RPnY6
 GyOhYdd7QdX04d4KSepiKvFRo8hDFo91VkmYJI1Q=

Hello All,

Here is a small patch to clean up common functions in the testsuite and
introduce a few quality of life features in a common library. Please let
me know if you have any concerns or would like to see any additional
features.

Bruce
---
Simple refactoring of the testsuite with the creation of a shared
library (tests/test_lib.sh).
Additions include:
* Getters to find vmlinux.
* Functions to open tmp dirs and tmp files.
* Functions to automatically clean tmp dirs and files on pass.
* On fail, tmp dirs are preserved.
* Functions to pass/fail/softfail tests (works with CI).
* Logging functions with varying verbosity levels.
* Colors.

Signed-off-by: Bruce McCulloch <bruce.mcculloch@oracle.com>
---
 tests/btf_functions.sh        | 143 +++++++++++-------------------
 tests/default_vmlinux_btf.sh  |  18 ++--
 tests/flexible_arrays.sh      |  48 +++++-----
 tests/pfunct-btf-decl-tags.sh |  34 +++----
 tests/prettify_perf.data.sh   |  53 ++++++-----
 tests/reproducible_build.sh   |  47 +++++-----
 tests/test_lib.sh             | 161 ++++++++++++++++++++++++++++++++++
 tests/tests                   |  29 +++---
 8 files changed, 332 insertions(+), 201 deletions(-)
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
index 2d16cf5..06ff523 100755
--- a/tests/prettify_perf.data.sh
+++ b/tests/prettify_perf.data.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0-only
 # Copyright © 2024 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 # 
@@ -7,30 +7,35 @@
 # Check if the perf binary is available, if it is from a distro, normally it
 # will get the needed DWARF info using libddebuginfod, we'll check if the
 # needed types are available, skipping the test and informing the reason.
+source test_lib.sh
 
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
+	test_fail
 fi
 
 perf_lacks_type_info() {
 	local type_keyword=$1
 	local type_name=$2
 	if ! pahole -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
-		echo "skip: $perf doesn't have '$type_keyword $type_name' type info"
-		return 1
+		info_log "skip: $perf doesn't have '$type_keyword $type_name' type info"
+		test_softfail
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
index 0000000..3c84d6e
--- /dev/null
+++ b/tests/test_lib.sh
@@ -0,0 +1,161 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2026, Oracle and/or its affiliates.
+#
+# Common helper functions for the testsuite.
+#
+
+if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
+	echo "This script is meant to be sourced. Please use 'source test_lib.sh'."
+	exit 1
+fi
+
+check_color_support()
+{
+	if [ ! -z "$RED" ] ; then
+		return 0
+	else
+		if tput colors >/dev/null 2>&1; then
+			num_colors=$(tput colors)
+			if [ $num_colors -gt 0 ]; then
+				RED='\033[0;31m'
+				GREEN='\033[0;32m'
+				YELLOW='\033[0;33m'
+				NC='\033[0m'
+			else
+				RED=''
+				GREEN=''
+				YELLOW=''
+				NC=''
+			fi
+		else
+			RED=''
+			GREEN=''
+			YELLOW=''
+			NC=''
+		fi
+	fi
+	return 0
+}
+
+get_vmlinux()
+{
+	check_color_support
+	vmlinux=${vmlinux:-$1}
+
+	if [ -z "$vmlinux" ] ; then
+		vmlinux=$(pahole --running_kernel_vmlinux)
+		if [ -z "$vmlinux" ] ; then
+			echo -e "${RED}Please specify a vmlinux file to operate on${NC}"
+			exit 2
+		fi
+	fi
+
+	if [ ! -f "$vmlinux" ] ; then
+		echo "${RED}$vmlinux file not available, please specify another${NC}"
+		exit 2
+	fi
+
+	echo $vmlinux
+	return 0
+}
+
+make_tmpdir()
+{
+	outdir=$(mktemp -d /tmp/$0.XXXXXX)
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
+	check_color_support
+	echo -e "${YELLOW}$1${NC}"
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
+	check_color_support
+	echo -e "${RED}$1${NC}"
+}
+
+test_softfail()
+{
+	if [ -z "$softfail_count" ] ; then
+		softfail_count=1
+	else
+		((softfail_count++))
+	fi
+}
+
+test_fail()
+{
+	trap - EXIT
+	check_color_support
+	echo -e "${RED}Test $0 failed${NC}"
+	if [[ -d "$outdir" ]]; then
+		echo -e "${RED}Test data is in $outdir${NC}"
+	fi
+	exit 1
+}
+
+check_softfail()
+{
+	check_color_support
+	if [ ! -z "$softfail_count" ] ; then
+		echo -e "${RED}Soft failures: $softfail_count${NC}"
+		return 1
+	else
+		return 0
+	fi
+}
+
+test_pass()
+{
+	check_color_support
+	echo -e "${GREEN}Test $0 passed${NC}"
+	exit 0
+}
+
+cleanup()
+{
+	rm ${outdir}/*
+	rmdir $outdir
+	return 0
+}
diff --git a/tests/tests b/tests/tests
index 11921ad..b37c823 100755
--- a/tests/tests
+++ b/tests/tests
@@ -8,19 +8,22 @@ cd $tests_dir
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
+			echo "skipping..."
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

