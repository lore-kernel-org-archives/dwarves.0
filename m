Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9C36BCC5
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089908; cv=fail; b=fD3pPh0ZdNgrNtRaoZpRlSpU39InVLHnEU/MBdm0j2NN9IQ5BsbrlspiwwPvELSgi1jdQWqL0y6eUeRF8xEKt+CGBNOdrUdCEpxi0GdpGN2b8oOlnWLWfr9wXaDADmsXSuFdojR+oSLqDU2RIiDfJ8UW1ORoGU+CZs6iFs2MKDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089908; c=relaxed/simple;
	bh=R1zCzQMUpzLRoUiqPmJdousrSKggdnaAIqbnl9ao1N0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YK0S0exN3flnUh8WqJMosOZOXlCjyPrKlU/ap+PDFe8K3kaZJBZf6fvy3koeVQDGAgS7CePnC8BdJbtRL2BrkMwpc1uq40rW1HKpoWl2RUUkHZekqFfQPV1SqZag5lLXuz5ehwdGeL90WHGjWufgA53BevTyoyumxPlRneJZLME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LZ7gCGEc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=swtyIWfl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LZ7gCGEc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="swtyIWfl"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629IMkre2773105
	for <dwarves@vger.kernel.org>; Mon, 9 Mar 2026 20:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Snuywye6XXerZMcc
	NiezKm+OWVGO5X5iDLxpeH1y7rU=; b=LZ7gCGEceVL1lNFHelChvN5FEgDltgQu
	TWSnAk5MYv4I6lgnx5wKXoDtP9Hwfd59YXYYeqyzGVSA3tTERAflq3BkykMiN3Up
	aWAW06ZK724Yt+vLwCDIwTap/axrNL8gWkHcyDO6lSA9h33uDkpr1/f9bmOx1/Hw
	p/RFwsXV+NzlRzEZUFZruhAcDD0KPbtNuc2ut4fLhbqpbDS298KJk53vC+z9WZ1s
	fplOP/M8Kyq70rU27bduKH/tIGzsCgWMRbLanccD2rQd8ZORS9rWSLsJeboAqiI1
	YLghIA2bSLTbxeBVYWWRzEp2x0JVlhQCA1gSL5jHBmokLdIqPZzYIw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csjnuht26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 09 Mar 2026 20:58:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 629J4qgI022688
	for <dwarves@vger.kernel.org>; Mon, 9 Mar 2026 20:58:23 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf97acc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 09 Mar 2026 20:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rk3Ks5RcvsF84VhG2p+UJkh82+3742yyrbWoccGpo6s0yjPs6tUZToCzW4RhmyfD6kfp8V3GpKWxuXECi9LLO8Fpb+Ib2NytorXGt4/UckWNso/C4VkE40hCYMOUZGX8xoIDR4tR+3xdT0p16/Bgd03I7gE0bSrkt0i35yNTd7K0Jn4fhDOf988JTgAnh+6MlMCxwhAKOESQ6kqt2fMVdfqZzgXXYw3xAl2oQt3Og2+5M3aVLJAoGznptnYhLyV5ci8Gys5hHhnjni3WKedYU5Hof26t/P8cZ2NVyu2P81tszrHcc/aklgDyT2FzR9Jg2smoInl94OuTfq9wRUhYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Snuywye6XXerZMccNiezKm+OWVGO5X5iDLxpeH1y7rU=;
 b=M28P+S5BCxj4WAIw7GIH+8QGJXZQN2TUimcn6wWqAPyEq9WQNyBdHx7ZPLBun3OVhNmKKjSqcu4tYcXyKIiPfJAI3mMq1XUjjH0DY+Sa8546mC6QHaVb3jdjEd2WtqD+h1xwnhw5XzfGn4MgYTKC8L+k24ZvNM1ZKDNL0VCGtURMPIHSWxc+gmHBL1QGzLeX3WmePNvucIqvN9D/nz1MZTZe6rCqYH/mRZCXzw1rJGX3Yyh6TyLICguxSEGniU9YEyzD8SjPiVJN9AETRCuePkS/4NcmtYlOyUR+iWHgDwiowDD7WjbeDGS7AylcWI5AhS1WEKTJ6r1mgQC8Rr1IDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Snuywye6XXerZMccNiezKm+OWVGO5X5iDLxpeH1y7rU=;
 b=swtyIWflDCIkSQjg5T9hyQeSREl8BZh05qLUW2m32leZisVdetyXpioPMBZ6jgiH4+85V84veX7Dh0nvbqibTiTcrEkLorepAAJgONnhaaYAehnXjATBWPoefLnrh+/zoQF7yZNmnShXKAS+Y3scbFzwsRDUGqO/oMwhlBbaYvU=
Received: from IA3PR10MB8513.namprd10.prod.outlook.com (2603:10b6:208:576::12)
 by DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 20:58:18 +0000
Received: from IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61]) by IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61%6]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 20:58:18 +0000
From: Bruce McCulloch <bruce.mcculloch@oracle.com>
To: dwarves@vger.kernel.org
Cc: elena.zannoni@oracle.com, Bruce McCulloch <bruce.mcculloch@oracle.com>
Subject: [PATCHv3 dwarves] Refactor selftests
Date: Mon,  9 Mar 2026 13:56:44 -0700
Message-ID: <20260309205643.1985134-2-bruce.mcculloch@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:303:8d::19) To IA3PR10MB8513.namprd10.prod.outlook.com
 (2603:10b6:208:576::12)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR10MB8513:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5651d9-2cf3-478f-8819-08de7e1e9726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	0JbO/HFnptMxWPxkF40Pd3IW90HBd95jyzL6WZ5GdobrfxWNoG5Vsc5LwExk0fusDqCHaYp+kQVkzumpD3zprUo82GBypHMl/X7UWX+K4GEnJt8N5bCiKe/YOlJKqGHpZif72iPd6DRX17Lw6uFQJfh8Hj0B5ZhhtirYE8CIhr9qfo3yAP1uptGQBd6AS247oIsxeIzAN94YI1T48N8JEHHgjDyPOic8atiEOmtllEaRQJhfnJA9kvZrRUjunfnSKwFlXHJ4tz90kt3yrphczXrCfEsSaHGtIQeowcV93f7GapCyzgJCBOy1mZQV9E8ueNiDkl7sltM/S9KGVpg+E+FCzNMi+DB13RMpE2PToOnMX4BeAKEarnhipXNzYbPxPoCjgPsDobN6HtRzijFoejGf6t+37DdlCNc3cvN4glXg9Lm3lXNt+9mzO2SxYo2sojTa+gtY4VXGuPbjLeKVEt2O/uEHVBnap6rPE6YPrS7tYcLJP2qqiwIIq46BdgjdZBCmSHmHBupncGOqb0bJrIkYbYLOSAl8EMQG/u39Adm60PBNFo2hNl0zPT2yqveEaHeOBq6kMALjMg8oPYwKSpSLXmNV0jfoMuURakmtoUaX6aW+eKrzh5tLZxaphN8rxn85wuBqaEbMbI3Hiey5RtBoeSS05ymLZ6m2c7/nti+bdbiPGuZ4eZkpQtzHEiqxqotxYChJ0YQcRlJrylGHbyi2UUsDnwLEtIyFQ3gQGRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR10MB8513.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KPpUhJ7wsn1baEt12hxKrnvEgj+kd6iPm71//iwdTE5jXeO3KDd+5gdFrBUr?=
 =?us-ascii?Q?UNnnFwjcWrTHomk+OXTs/Bp3Sp33e1no1Py+0cxM6JoHSSBKDeVbOqq0u/ag?=
 =?us-ascii?Q?C8hiZr/gS24lOfOoBfuXYoDwLEQo/lFEDVpRLj2hXgrH7NWDASXzzHl3hG4u?=
 =?us-ascii?Q?af7ugno2Zv/PjMqXIMKw+cPe8PBcEAWXiKX4t4wFFT1hg0QanYf9m2uzhIeI?=
 =?us-ascii?Q?0lXqaWv2prOg+UJwrBE5HuTw6b4ozrf5060/RlXFjjsuJMoH1PMQtKM9w5V6?=
 =?us-ascii?Q?lZ47ulg4I4NU4tOHO9+R1rpo744VZcnL8a2b4/1XtNZ5xLi20bmc5jD1EVeu?=
 =?us-ascii?Q?DX4cmInVk0jGwWDf8dsJoW4AuMSdYRZ95mderW8XD6QgeVpFQEDlaUUP38sV?=
 =?us-ascii?Q?iW9skMPSxN+la60Mjkiq+JGpV1idmCNyyK4XVkuelNbpyhZj6L/DsN6yVndS?=
 =?us-ascii?Q?4gWuFsCoHLtS1PZWY9nAkcP04cnoyFnZRuiRXfB27sxymmhbWtoeC/FEF8Wm?=
 =?us-ascii?Q?PIArBnjZF/z2E+WJ3BaWU2bos8LImNmyor54MH61kXEWADhyyuSOGUPV30+J?=
 =?us-ascii?Q?QDsq40CLUWZQZAhhPdiLarGETeR9/5pF94+4h6wcfjj4AhK8MxF4lKc9VbtU?=
 =?us-ascii?Q?4hOnyLc0Lpm3eteAiQ8IY2doROhS7W4PgCRzjhWFD04IkpgL+iLNchGc/qoa?=
 =?us-ascii?Q?7MAuBCbjlVMG0/7G2Jtt2hpBMw579Dc78rsPxtr0/FXhbLjtlULIaoUFyERd?=
 =?us-ascii?Q?kRB6mYdrK+iKsdcyj/MjNTnlq2qYjHqma9P6sMBiMeYnbW6KyGflYa4ordB+?=
 =?us-ascii?Q?WnO7CRv+5qmaGPQ6K2XGxIoB8dkMht5/hipcjogdkbbTriSUW+dzTit2LoKy?=
 =?us-ascii?Q?MHmi75Y3VIloE4NBuVFYXM6VG/Oclk05zyTWiufh4R+Q/SUhU5XDDOUBVLQm?=
 =?us-ascii?Q?NWuA7elLkp88AS5NTpcGJDjrBayB51Kwj2bfAbTEnPVJhPPwg4vuRybKVi5l?=
 =?us-ascii?Q?L6+DvrLSyxpXP7YVCfSS4KiQNcC41m2uY6Lq7WozMNvqTq4Qggia+vuWYaKj?=
 =?us-ascii?Q?Lt5iVL0m3tVr4E546EEtIpzpNTFBZhZdjkydi9uh/7bo+6xZran8RlX1bPOJ?=
 =?us-ascii?Q?0rq/+EqwJB7dkTtR8hLgTa5eiIxHC8I8gIxlpwfKBbu36PBzjT8c610ygWQL?=
 =?us-ascii?Q?qe7iqhvBGMrnIE63zY0R4eDAPDb7kxdV+5+SduPbf/Y6wFWdtEdZ8BIHDCaX?=
 =?us-ascii?Q?uXD4Fpx0knhRzFY/U5ily/9o78OCXvCVZ9hZ3LWLo2v9ILeHMpL8Zrp7YmUN?=
 =?us-ascii?Q?NoD+71gNYNJFHAyrTNvNiyiqGqDO5lkB3LtpgT6dB+7e3qyJBVmlbuUEahoQ?=
 =?us-ascii?Q?l+u7Bq3pYVlH8Yc7mV7TSCt6QrNy1L3Z+i2vcHkuPnTE1y351/n41cQIx4dM?=
 =?us-ascii?Q?UqM9z7o5hP7C922H/Fq8z+I+glAqZ91n+Nq2T8uqRCqRsQ8TwoC+CN3SF/qY?=
 =?us-ascii?Q?8CTxqAIhnbg497SCzCOZwPh2rUQKyDigjiJ9oqpEQn/HZsOSktDigKMKGFh+?=
 =?us-ascii?Q?QC6edX3dTLyrKO0c7nvanAClP+dTwzHA+bPD2WUSxgMqmu6eMLnNlU4M8MhZ?=
 =?us-ascii?Q?DaYhOMun3mbllk8UxARYb9SIKCrXI3xkVFBadH0i3NYAOHVp05TuoKFUPTsC?=
 =?us-ascii?Q?s4w4+6W+CldKJvYgVq7wHezDqHywL9qMgZQLap30IRx+Z1SlC3fnfEHkVDG/?=
 =?us-ascii?Q?5iWcXsJejoZP4wcwetiVEBo+Qz+EJ62AMtdpMr50IzZ9kSxpw4q/?=
X-Exchange-RoutingPolicyChecked:
	PXgvBtzRVEtMRQoxZef1hV1Q3FGDH9axkTWfDUSbs34GdNTBidbrD3QkN0YtOFa7aYTYkwbz2+JYVXDg1cqg9K6LWUYo9Gmv7J98cX0fMTyXBeQPyAejWjrHXVazHOQzNMUElgXKQZitziL1j4nt5jS3TwwBp8fUiYvCYQqcP9TbH9rZcAlyjQHsoW51RP1vRcr20a431wRgAdbd95JT89cXGIOG1ZwzsH8Vd0aXQhETWVjIRKasl6IECGtm8A77GQ/k/o+4kYFmjYViFfrhRED/qPbB1UJt6b6UIjTRMmPb9a6DjITB8o5Su9BoAboSPDzZMtxyRZx9R+YLKjeUkw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v+2CIqzqC3fFdAVKmq+fEpGsLXhn4xA+QZS+ENG6CCz2vy3BW2ObkJlXHwFh+dhiYwTdmn4ymjqFD82qKegu2PDs6z+MK0ksscsVHrZbMd/u9jmY9g/eAIcVIzgIPUkzib1FTyfnzFnQdLeudnuYLHdlHU6jxfAowLraA4jc1ZVLrvdjcY/jGijB3GvowzOFJAgwUTGYuSCYzp4wLqD0+DRvrxyJd7dmn105oevkSPxMC9JIWPkFDLzViNHXkiwAKk5FOd9N9Ro56r+AlzI1Zr5jvMwprgeGiL1DcFASH5ZBDHMuQdPVRHzcu/ag99j9KKRuxALjgwVd7fEMnwIjoQVmoQ1nEIr6xBNXQRc8BCDNjVd67NOjYDWj1pjDBkL1xnk5S/iEiPNJYacq0iL8+kj28q1WAPESvbHWnayNqZRpcBGfYjc4f6lRjRwVJ3DsxU7ih4rxyLucoWfeb6SdqVShHvT+RVOnXriCSChtQeywfPklESSxOLQVVcabDw7G9Uqv4bIKH1OgLuUo3AN8Vf3cZeLbTFcOdY0T5dLKk+MVp7963iuHjrSRfxDyI4cFYpNki4fXFUzk7hrWwIOtUnpvjc7poiox6egoMlJ6MyA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5651d9-2cf3-478f-8819-08de7e1e9726
X-MS-Exchange-CrossTenant-AuthSource: IA3PR10MB8513.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:58:18.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kRyUQxBdXZT31YG3AEPzfi1jpuwwGYsjrjpahcNZ/v5PlrH0XWjHuEtlN0GXKlnL7zHxKVUuVOmznTIG/wDcAfsD4VK/fw71DIj5Yfzx+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090186
X-Proofpoint-GUID: YPGH0fG6TbyD9KcaBKnezntxnKfl0ZwN
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=69af3470 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=6QGHibFnLBKk5hm-_UYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4NiBTYWx0ZWRfXx+pCKnY+DpTu
 e8y6iRCXm9vCjLzfp2SGrVmAYP++BlPbCDD0JoMfvxfUijURMkGKsE2VimCLk4YuiaZ4pr1G0wf
 17NCMHvvvZIje0qE3TEKQ8HYTvEhqQn1VwsTJzO4QnsR7/JJWo/rOvVHDx3pgGbx6eWaDOwDoGC
 DdcdHjsxK/mS7tIzPCzqM94N3zRP4Gch3KRy/KStNvRWWza9v0Vi7i98jZW4J7qPhRgZncNGs64
 R380iI8/6gd3Jg8WrZaobVXA8Arzc9ZMlGujQsXYICO/wl+pfY53oGqtdQXswYyiZBTbaT1tCSr
 j6nsKWA3S/WoD0FPyAT0FHSfEyk6G4l80Sz+mVXICQthoRyPixGLDHXJkSS2h0wT4Jj6eZ5Mo5g
 5OAhabh1qHyPgx1FR3IuyF1uRzYw0ownQ0pYdYdZLVvgNokRQLqEgYN7rOMuwpHHOX9MPLq3B0U
 nxFexOEto4fJx3hu3iw==
X-Proofpoint-ORIG-GUID: YPGH0fG6TbyD9KcaBKnezntxnKfl0ZwN

Hello,
Here is a rebased version of the patch that is in line with upstream,
and contains gcc_true_signatures,sh. Sorry about the mixup on this one,
someone should probably sync the github sometime soon :-).

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
 tests/btf_functions.sh        | 143 ++++++++++----------------
 tests/default_vmlinux_btf.sh  |  18 ++--
 tests/flexible_arrays.sh      |  48 +++++----
 tests/gcc_true_signatures.sh  |  48 +++------
 tests/pfunct-btf-decl-tags.sh |  34 ++++---
 tests/prettify_perf.data.sh   |  51 ++++++----
 tests/reproducible_build.sh   |  47 ++++-----
 tests/test_lib.sh             | 182 ++++++++++++++++++++++++++++++++++
 tests/tests                   |  28 +++---
 9 files changed, 367 insertions(+), 232 deletions(-)
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
diff --git a/tests/gcc_true_signatures.sh b/tests/gcc_true_signatures.sh
index 57cbe3f..9ebe1fa 100755
--- a/tests/gcc_true_signatures.sh
+++ b/tests/gcc_true_signatures.sh
@@ -1,36 +1,21 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0-only
 
-outdir=
+source test_lib.sh
 
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
-outdir=$(mktemp -d /tmp/gcc_true.sh.XXXXXX)
+outdir=$(make_tmpdir)
 
+# Comment this out to save test data.
 trap cleanup EXIT
 
-echo -n "Validation of BTF encoding of true_signatures: "
+title_log "Validation of BTF encoding of true_signatures."
 
 gcc_true="${outdir}/gcc_true"
 CC=$(which gcc 2>/dev/null)
 
 if [[ -z "$CC" ]]; then
-	echo "skip: gcc not available"
-	exit 2
+	info_log "skip: gcc not available"
+	test_skip
 fi
 
 cat > ${gcc_true}.c << EOF
@@ -63,30 +48,29 @@ EOF
 CFLAGS="$CFLAGS -g -O2"
 ${CC} ${CFLAGS} -o $gcc_true ${gcc_true}.c
 if [[ $? -ne 0 ]]; then
-	echo "Could not compile ${gcc_true}.c" >& 2
-	exit 1
+	error_log "Could not compile ${gcc_true}.c"
+	test_fail
 fi
 LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $gcc_true
 if [[ $? -ne 0 ]]; then
-	echo "Could not encode BTF for $gcc_true"
-	exit 1
+	error_log "Could not encode BTF for $gcc_true"
+	test_fail
 fi
 
 btf_optimized=$(pfunct --all --format_path=btf $gcc_true |grep "foo\.")
 if [[ -z "$btf_optimized" ]]; then
-	echo "skip: no optimizations applied."
-	exit 2
+	info_log "skip: no optimizations applied."
+	test_skip
 fi
 # Convert foo.[constprop|isra].0 to foo to allow comparison.
 btf_cmp="$(echo $btf_optimized \
 	awk '/foo/ {sub(/\.constprop.0/,""); sub(/\.isra.0/,""); print $0 }')"
 dwarf=$(pfunct --all $gcc_true |grep "foo")
 
-test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
+verbose_log "BTF: $btf_optimized  DWARF: $dwarf"
 
 if [[ "$btf_cmp" == "$dwarf" ]]; then
-	echo "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
-	exit 1
+	error_log "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
+	test_fail
 fi
-echo "Ok"
-exit 0
+test_pass
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
index 0000000..fb72432
--- /dev/null
+++ b/tests/test_lib.sh
@@ -0,0 +1,182 @@
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
+	if [ $color_support -eq 1 ] ; then
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
+			check_color_support
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
+	check_color_support
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
+	check_color_support
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
+	check_color_support
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
+		check_color_support
+		color_print ${RED} "Soft failures: $softfail_count"
+		return 1
+	else
+		return 0
+	fi
+}
+
+test_pass()
+{
+	check_color_support
+	color_print ${GREEN} "Test $0 passed"
+	exit 0
+}
+
+test_skip()
+{
+	check_color_support
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

