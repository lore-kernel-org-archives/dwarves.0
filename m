Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3588C283FE5
	for <dwarves@vger.kernel.org>; Mon,  2 Mar 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472850; cv=fail; b=iFx0CQMMHl4wo36N0f9W8W/GsPM7WgjLvw9A5v0XwExDMzs0Aqd+EK+W1AfxPlLXuFmL2eS/kwY5Rl5J/uXFaFfzceUJwWK5juSepXhJclBFCiu3KbdG9VPKTY/zwgCjOPsUknUl9BTAPbyvWo3UgkGA3Cb5azsM6B4VbHOvLQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472850; c=relaxed/simple;
	bh=onI1DvnIcTID1p9iZ7KSyRs0UoY69dSEY5vIybeOYmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UJzFtFalUU6Idn/ZkxA1+3pcrxKeULBLBkZQGcImGuUZCN19V1Toh+cFFvIUFjr6bVJ1uXq1ApUuzI1WDRHpZhXj2ZyaDIyTA3uLT0XiDBKTNDKsBQ24tLt1+S+36gA6y3DZzN2sGrQ7Fel/509reEwm6E77b24My8EyaQCFpPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a4AGx2Lj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RZ64zRUx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a4AGx2Lj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RZ64zRUx"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622H19mo2377759
	for <dwarves@vger.kernel.org>; Mon, 2 Mar 2026 17:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=cLpzSraFLtIT9JVN
	I/m4CW2OPu81wFqaCMa3n5/k4Mk=; b=a4AGx2Ljr6GNSLxs8Zv/7g2t8ryrq1q8
	KBSmbPgZ/ghM8R2oviMlxXyNT4abO7gmWZH/1Xvkepr1dP5DAbnj28dQbcjUfJw0
	VVoae1BlgzUyv3cYSG2B+hEUoe/33ms4Jl9urt6rSxywbsf+AKp5hQNJEAF7WhyN
	tLlmwhpJA+F+KlvMYzMTJ9cdQpW+Qg6iv75NpUX4M38JDkuayfPwvXmNg/XyjPQQ
	qdv+DAaZ4Bcnsid2L8T+OBW9LibZH2vODBDcT4iGCYxIQLPmtuRrPRVSdNk/EhG2
	8LUzWf1jAxwbB397NiwpIJr3XU2fHqykpwSXaCP+99dBCS5+x4aHRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnek3g1f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 02 Mar 2026 17:34:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622FZ7Lq023120
	for <dwarves@vger.kernel.org>; Mon, 2 Mar 2026 17:12:41 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdgcmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 02 Mar 2026 17:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdBteB5I3flbp773WxzsX7SG5cYf2ic6evEbKuF22dmU3N2o6VCA0umrF7IblMo4z1IXyCBbjNkhNsIQbIrpCli8cqbtp1U6ZnMLN7ay679lYFrozxKW3evjFNhuDfTvtCVXaNbyuZkTXPy+rHlRcaRFXJF/bBrkmVDrMl2LtUTuTpXuKqaoq6p3fZD1uPkm3Qmbr55rVtc7duDkf0yycYBzMUFVvAACfUjTDe9cHk8+MFN3Z1Gl56Ah2DMcWN2DSyLuM18drfPMs+L8pLrAG5/opzVRgU+hsFTCo/4ZKYVkcF/LCtjpWAQwydhvcEfoxuFgSlM0Q4S7JZU02cpkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLpzSraFLtIT9JVNI/m4CW2OPu81wFqaCMa3n5/k4Mk=;
 b=PCQe8rcd6jzWqPdumVXPFWXCJN2+LlTquF2Y4bGObszCriE8rOinNCPxUAvvTyocjdSJmH4NXUXpJIP6TyG8B74YtTcvKKe7/ExhWU5iYcGq8pygGHytBlU1CdTiSgq/3Rm23enhdVEfDtFTuPdrTHqD8J71kQLCIPg1zuxEeg05bclQqaSPoMgKAvuNFVA7zh3n/his+3qFWJnnxivTdJMSWvoI+c+rb94N+fpHO8xi6sZDwVgvhK0vnZEb1cBKH6xsJIjg+ojOz5PLCSCgbz+bKw3LZg/SxHXhwZJjdeoagVc1r98ovSkh6atuHNOnddIZcJA51FvBgk01N0eqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLpzSraFLtIT9JVNI/m4CW2OPu81wFqaCMa3n5/k4Mk=;
 b=RZ64zRUxzKZygSEjhcrNx95x1lLh8xLA6ybGg+aDR2WM9aC1I1c3Mzy+xO0eboNL/BJ7WJEAEjitmO6nX2GhIJDZ3ALjirvOCFmWBRGCxrgVNmcwuIXhqHOXfaKDlKb1dJ3v+p05saXDBAN5e4fe8p7tZT8VsylD6EF/9e9oPgE=
Received: from IA3PR10MB8513.namprd10.prod.outlook.com (2603:10b6:208:576::12)
 by PH7PR10MB6180.namprd10.prod.outlook.com (2603:10b6:510:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 17:12:36 +0000
Received: from IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61]) by IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::9aa9:1581:c85d:cb61%6]) with mapi id 15.20.9632.010; Mon, 2 Mar 2026
 17:12:36 +0000
From: Bruce McCulloch <bruce.mcculloch@oracle.com>
To: dwarves@vger.kernel.org
Cc: Bruce McCulloch <bruce.mcculloch@oracle.com>
Subject: [PATCH] Refactor selftests
Date: Mon,  2 Mar 2026 09:10:31 -0800
Message-ID: <20260302171033.1003145-2-bruce.mcculloch@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To IA3PR10MB8513.namprd10.prod.outlook.com
 (2603:10b6:208:576::12)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR10MB8513:EE_|PH7PR10MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fcf53c-d2f4-4413-cb0a-08de787ee69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	AQfdwrSlws3P9JPHi6Oeb69VXxUqOeGgfOoKyT+PFPitnM7mk0ZdIfQZxLtAzhMbyATpi4tx14rRdDqDhFZX7p9Pky9lRimqxtwnwTbJMLSiGC92C60sARtKPxWS1XBrIOJ9CPscfIgbOANCR3o1VEjY1Qj+PgRyzPx6X2+epBmvt/2/c6209zWYEorr/xlF1FHfgUpN7cHOPV8PmNe4NGfzkcfEam40GeYxGDN/GBUK1cKBK9Ucr+iZmwlE6K2esm33kyzoQN7NN1Ef79ttKsyryLkjknLwLZaODoHP/+5VcbNy/2fxt+GskT8kphfJwKBGWnaADi/AZKaoR2LNmhUkujPp0u/avarllXtH86m5wundqzjZHgC4x+CcZYPqgHvRz9iEeHNEliHZ6G6BjOh+9s8oZIzrQ/0X4J8RDzv3GbQtqB+bLoLteUwACZNtJsg4Fr2QYcpWntLhHNcyB/LdV302jKcy7neHcY4Yy5exba5wh4KOrbblWkTiDvpB4kK1c4qAN6kFd4GNzOfzQO/35rOtqr9ibrOn4K3sITF8I1VfLjoPaWn7cpoxpumh25LAkXpVTsRtO1cucY3mN7yucrqgZHyWLvfeimGFS+x92tfvPK1J/U5lmZ2KkpshWwEKjUnsk4fF5ni7pTMFN39Zyio6PW2PR13glNVvPujeS4wYcwjDANs8MNivG68PY3+/Zv+K83fOJKkbMUQV+66jdpPjpnWsGAav3P1Yr0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR10MB8513.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGoyVlZ3YTMvTVB6Q0o4TkpZVkxLV1RZUjVhaGRhQzN4Q0JmcndkQlFwS0Vh?=
 =?utf-8?B?Y2VUaDZ1M2JPejE3alBhTXJUVHI5NUl0RXV1K2tkakFhbklNaEU2blNOalVK?=
 =?utf-8?B?c2hINC9LZ2NMWXpYa05UTitlSFFTS2dwOEIxdUFmSDZpaGgzVzZBS3NjQmhV?=
 =?utf-8?B?UzIwUlRrcWtMWDdDVU1SRURLWjBpeVdtUzRDaGtFZGhtWkpsV05OaEpWbWVj?=
 =?utf-8?B?MWVrb1RNdVNsWUJPTzBnZklIazNIeURGVUhPODBwTENQSlA5eGlmQzF2RU1P?=
 =?utf-8?B?VXlEMHQzektTTHBqUnY1VTRwUENWeXBiV3NvRGhBb0hoUlpla01ZRmYrUkJC?=
 =?utf-8?B?VzJsK0pHbXVEVnJQOWJWZHl5KzZsRXd4RThBTWxQUE1NVUlJZ3lZdlpPN0Jk?=
 =?utf-8?B?QjIrUUtUeVBiUXU3aU50b3VmaG92ZXJiZDhCeWNzaTZtMURETlN4ejZKTk5s?=
 =?utf-8?B?bGlRMVFROVV0UFFPR3FzVFhNUUVPL3pTeStOd2Y4YUVnZWdMcjNKSkdIQWJi?=
 =?utf-8?B?NFJaWHRXNlRJa2oyMit0N1VwY3orOTdWYXVhUVVidzIyMkhXOE9hYzJ1YXBN?=
 =?utf-8?B?OVhoeHNwK09ES0FOK2pHTi9oUlRrVHVGNWNwakVkeUtNS054cFVHUUI3emc2?=
 =?utf-8?B?YmpQRHlVL296aitEN3hzMDZFUnFKc2hZd0owRU8zWWVnSThsbjNMd0pGR2E3?=
 =?utf-8?B?V2hNSzNkb2Jpd1FtYTBUWS9DM3NSdnBSOE1zUjNoMkVLaEV2SmhobkhCRS84?=
 =?utf-8?B?bmJlZHplYkJiWU9mVXNHd2x0eHBaWUlZSEdTWldRbEphQk5xRjVueExEbFgz?=
 =?utf-8?B?OVlhNnlZQW9zdWtLNHJjTkp1azUvb0tpaURRMGwrdXp3ZFptekVIOUdSZE9L?=
 =?utf-8?B?K0lxQ3k5Y1R4elcvVTY3ZTNjSk1XMjJBTFFJejFmT1NtakVRWEZZSU45LzVM?=
 =?utf-8?B?L1JDcVpVdHgyUnAwOHFSOHpvMm56WDNvRWtqcE5xcVg3bU1xQnd2QlR0Smps?=
 =?utf-8?B?aGhFb0d2cVpKMWpKbDJ1eFNwcXlRbUYrS3ZxdUEwN3JPTlc4NFFtaU9qWXpp?=
 =?utf-8?B?UkJUbFFJMDEvd3RtZ05QMjFSQTMvQURLK2ZUNEpLWGZ5OEIvUWU1WllkTmlK?=
 =?utf-8?B?eFkra2c5b25meHFKUHFGMkdNS09uMlF3OFNOMlBlYVdLOVJhSEZIR0RyanJQ?=
 =?utf-8?B?eWw0VlZqdUNZYzQwazZLd0g4M1Q1VHJUWjlQZTk1Q2h0cjJTZUtoTjJQdlZu?=
 =?utf-8?B?RmVVdjdud1dCYnJsWHR5amxpQXlVYktHMUowNUxqendmaHo0OGYzV0pjRUpO?=
 =?utf-8?B?V1h0YVJQb1VmL2hiMWNIblc3dWxQeERuMkFrUEE5ZHZDZzM4VUN4OVNySHBo?=
 =?utf-8?B?L0k2bUVma0V6RzZLb3U4U0VUdG5GNVdLY094bXBQd3d5KzMrV0FDZldvNVJm?=
 =?utf-8?B?VGp3V2lHbHZXL0UvS2dFb2NlZ3pJRUV3QVZKcGFPcDE2VXFDQjRFd2hhQ1U0?=
 =?utf-8?B?MzhmN2VUTEs1eXFUbnBRVklkL2pQTzRqNEVyNUNLZmlpNkZMN0Y1N0wzOUxF?=
 =?utf-8?B?NktoeG5YT1ArOUUyMU1NOE90eFNZSE1xMy9rSEg1VXFsbG5nTUVodG9jQ0tC?=
 =?utf-8?B?VStlWGtuSjRyU3dZZERISEFlcjBZZXE4VW54Q0VvcmdCeDFadGdVbHpUQ202?=
 =?utf-8?B?YkRWWlZxUUVtRUZHbGpXY3U3RU15M1pNNDVUc0RUU3BKeG5wck15aXkyM3l1?=
 =?utf-8?B?WG50OXl2ZWVKMit4d05TMkZCejFMQkg0QXBpTkxlajNBT3FIQ3RSY0o5V3o4?=
 =?utf-8?B?Z1VQMzNmclhXLysrMEM2Nm9XT2lkVmhDbHdDYlpyVGE1M2cyWlBLQmpTN0Vj?=
 =?utf-8?B?MXhuMjJicTJML0hrd3BVUFhIV0NiaWhUOXY2d2tuV2lHTFQrNG9tangzOFNU?=
 =?utf-8?B?eVl6UkVUZzhoN0VrS3NVakdXVURlRzVUNDhxcTYreHFRamozYjBJN3JpaTAv?=
 =?utf-8?B?SUkzMGRuSkJDaVpuUml5MmxPdVFKRE5DZ1J4cnErRC9XRVpERWs2SVc2NEpO?=
 =?utf-8?B?bVJXV0phQnVCamRiYklyMnRaRUtBbDRwd01LbGZUVFhrWUN2aGNQMXIyQjdv?=
 =?utf-8?B?dWNVc2VBbFkyM0o3Z2Y4NThacE92YlB0Uk13UkloR3VrZmlQcGVlZzhwRWxR?=
 =?utf-8?B?Vkh1dm0yUENTN1RWSmk2eGREK1ArUHQ0RGVKbkhNS2I1UXFKWTNUN1IxN1Bk?=
 =?utf-8?B?ZjFLeTkyR0VHQXBzWWV3TWhRTGRhVEhHckY5cTlzQWVoMEVoMWx0Q3RvRU1L?=
 =?utf-8?B?QWc0L1IvWXBXVFFPQk1IeDVtWE9nNmF6WDZrd2o5N29VN3RBMFJWSzd5cGRI?=
 =?utf-8?Q?x1DG6krk8CZ8+5AA+BPxTZ+SfEPs5xsseDQtk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x1F6sZehSIQ/MJutveFQMtG6YeCiEpiquGpZTHvqWkCjzGqkGDGWr0dW4bVUqbyH2bLEMwbRLxaWD/DIZeCsgvo4jkJbSOagu96+hgoHUotuNRebAub8KHwFjyKENjb7SJrFqH6WBH5lp13jDlzW+p1ou8fnCLjKGIaZIckZULydVgFtnuvbcllCPH30XsV3Hh1klb6ZVY5ysmFbKH9fseJP1WQPRPhCYwL0AxsrGpaqIc1UL+uyPl0H0ZKO/W7kbli8fe+tfAzUornTk0iWNNDoX/s/3HqxNKvAkTho2GZT3u5WV74ZNRNmkWM/7InVmooxe8S6ZK7VjQ/7IDyUpyU6pqhRMe9B/OqR7AvYb3+CnM1MRLPTROFDyZ7C5sOsJqVPjCavN3wR5aGOK1jHkvXAEDT351ymyZqfven7lh+bkfCepmYvh/5MD3AlSprxmYlCMcbyCvalTk+6HiFIA7QLzE1o6VMhJQgdM7x/SzwBZShD0ATswJd5So7m7EMFzwMFzJdJQmVuudMwjpt9BMlxfrEN/+j4NYy0XinzlUdAzrbG6ffiK5fNZG6QW1axu73XCpw0heuW52/L+HiVtsUVrOKHb+syYpphNHFss40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fcf53c-d2f4-4413-cb0a-08de787ee69b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR10MB8513.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 17:12:36.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGWHExKic+xrKTkimWQg9F3A6wf8y+mdnqPSm5PACgEuSs46587UnXXh0E1MOLTfZrITa37OrQWcCbv+Dl5/ggnzLvggVoZuFjjlqpthvJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0MiBTYWx0ZWRfX2vXnKvbPJIOm
 26OCgiB/wzwlh2ec1z/RINSkuEKBnkRJG2JZ9zSdW0+RNOfYW9OHHubUhFM9Rl4Sj34GYdkVcfO
 qJfY6tyJWF4HgAeE9T7TDEYuPHaSH4Et2l7kpHnQDxVrTI2bne0t7dRsnIKHO9Rt/gyy8KIxiae
 e24ySsC/gjavtH8PRrg80mVjRzdM1AGtjiX+6wAWhv+GLtrH0c86Ul0StrTqsvJAJ8KzhV0no/b
 P9j1B9fiM3ancPoIjFHONqYPNPVy7CFitZrPva+Qbzggm4Z9XxC+TbrHClsHqCJ4x8WwP82jREh
 ix4hJ0GELudQonCj52x3/JOtonD0Ia8uX6K+bxS7M1hXEZSy9QPSj8hGEy29c7NPW58lnDGVYEH
 1yIOYIZRLYBCZjqE3H2TQbV7Z92hTr3vl/NMtLI2IMW2RRJt82vLutP8XebloINPPRKSaFlYbqd
 Iz5I04xwLCjf4SVQX1U7saRGLOGG9rz0QH4y8Q/U=
X-Proofpoint-ORIG-GUID: DbafDlTb62FGxERaAKtuC7LjkEeEKFBR
X-Authority-Analysis: v=2.4 cv=DsJbOW/+ c=1 sm=1 tr=0 ts=69a5ca0f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=K9Bnybq7SwU28GRxuWIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12262
X-Proofpoint-GUID: DbafDlTb62FGxERaAKtuC7LjkEeEKFBR

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

