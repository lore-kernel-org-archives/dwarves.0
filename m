Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F923659FB
	for <dwarves@vger.kernel.org>; Sun, 21 Jun 2026 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046279; cv=fail; b=V55tFw5eNlQ+0JL9lsYQSPjfw1/tif/U6yTzi8ieGC+oTBN4eG95oFTo6gb7thE6RUPAbkNnsVvGCFMyi5QsXL0RShWBit/oZGGBcV+bHAuPnYVSMBvtywiDWxcx/k7DFvBe1SSBt9fpxdnAhdX967wodWtz9XEa33qo7c3zKNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046279; c=relaxed/simple;
	bh=a/U/MqcQIRf+sWjmBOqSYfj/aF+iJKv3HvbCmuC1LiI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gtuNLK3eXH4XSLVDhsqNw23WmTBeUMGQjaVfmlBXEcH7YNphr28R0hD5JdtDlBHtWvZuFnti+QQJOb7tI7W+Xey+GQBlTra2xude7hq8LKIyn9ZH1fE8IJEL1S8DQLJJH2TR4He3DyL2J2YOE9hd3HEeqblTLtoyCFGaCeG3bDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e887pnrv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kWXo0oWR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e887pnrv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kWXo0oWR"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65LBt2wW3376865;
	Sun, 21 Jun 2026 12:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5YEghjqrUtSaKYGWsYpRPMUKCpQ09Y5QVwu2JG3kmQ4=; b=
	e887pnrvUTG+htQ1Id/gYuBNzxKwccySRdauD1wrsgDvPgVjxqZgllar4fX6Or0L
	0yFmxZ36xmFQJBzr09owFFI3huT8O1/lLfXHzPiEzxBI9rOwplDWJxEcWoJM6HZu
	b4vjUFrOysCueWRvHk49tX9sLUwu3mccfyifXUx7kVCAKvvx9yOjy5i4MuWvjCE7
	4nle8N7IYbVZjoiwSg2gMC18RPr+cTVWDinnnJw5HgqsNEI7tJxZ7w1tzatmQvkp
	v5W89fLWwrZ7UbK0XGX2GaQcr+c+YKQ1BT5Cb/ilZZ1e0Is5WUZqNSym1dmsGb+z
	uEgqkjP4yCgIVLq07txdmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhf1gvcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jun 2026 12:51:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65LCX6RV015799;
	Sun, 21 Jun 2026 12:51:13 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ewha9uv8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jun 2026 12:51:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4C+cZgr4aqNF05oPRtrRg8s1pTL/mGuSto2Pw2TDCUM3dIf+/MvYoqXLXLlQOKvsZ4JiNeu1YfyW+0oa5f1d704yUyVFEJLsvGFWq3tY3lFMLo1AQdUT9qCZDuH6GD08bzr04/SD/ULvi0IKyzsucgvrsmxC1IHZvfx/uWJc3KQl7YklmM2M3HZTIWRA8z1nxHCsbtTwmc1NV2Wq8N5E6UMVEAB+Al+BUeBPz/xWHzGGm+k4XIgo6ivwEK0EB0uiWN9ksVduB437kXpPSqO0/fA9nnTFqPOt+H2YqImRKHKXqMsD5/FcOdr6Id88ELYDn9qmjROEKGnjQYiSbwOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YEghjqrUtSaKYGWsYpRPMUKCpQ09Y5QVwu2JG3kmQ4=;
 b=cxuGfxAWqNTPZJ4bLPbqibZ8zM615fGDP31mIayI1Sr+WWZxmaR/HJbU0E8jjRAGP7fo6cyBxvF6dBmBrAuWa5ojq7zUdGWtCIQ8gKCvKYU7GolRWuZ2WnK5ipN7wCwBGjFLv06iudUL0H4gNa4lB3Gp0b5VYsEYGB4VX6Sx4W9dWzBz+jJwuI/bG1Aergz75nMgw7A5HQy2IUPkzBFQfsRL3PGiYI25K9FDVK4DCvqZ8RQN/OhL5NTTMQPe3v23KkxvVKcDdbubyHaO41RwE62q8Rx96ezLM2d7/84wPZ4pKHFdXV/Jh3xZUOKC7AaRUPezEvXNYqqz4xoXtCw3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YEghjqrUtSaKYGWsYpRPMUKCpQ09Y5QVwu2JG3kmQ4=;
 b=kWXo0oWRhUtAF1qnco/Xaxp1IQCW9H1ZqNQoG0aNq6dj4pWCDHRjHP7elSEF7zR+6MDfru5uxR1Gw4MwtYGcVp33ry/8tQNGvGdsTXqiI2clP56AC/5/kcsciYUoeHjVXpbJaj7+MTxhUBB4hjLGIIttAOTyWVeI4Onavzqn2X8=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ0PR10MB5581.namprd10.prod.outlook.com (2603:10b6:a03:3d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 12:51:10 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0113.015; Sun, 21 Jun 2026
 12:51:10 +0000
Message-ID: <a362a83d-c75e-45a0-b626-d046dcec3739@oracle.com>
Date: Sun, 21 Jun 2026 13:51:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] CI: add clang+aarch64 to matrix
To: Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
References: <20260620083056.361658-1-alan.maguire@oracle.com>
 <d9e0f529-7b42-4b97-abb0-ca54beb3a25c@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d9e0f529-7b42-4b97-abb0-ca54beb3a25c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::14) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ0PR10MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dac1910-fca9-4837-9caa-08decf93c4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	sBp4daKyMOl8YB1GUtcDcfhej22Rnrh4qxojAWsl5XR/0mehxXnrFyPTXuKrXOfqQIXSeua7Bd6lC54h46wKX4jda7p7lRibY3gyFjF31Ww9ciq3ItrlgVon6swV0SBDYjwHyZKYrcg/jtobdV1JDbpvRZNx/nbTgbDMTDR0JllQKKWlK9Nf0kMCOpCZQufthbMrcyb8wDkEUAlCOJhvS/vNMAuWXu45/zPCbqX9jyhI0Du95go7J404o28i05rvTTt1YN50rkS2hTEwFaJMuhrRqCUcX+O/mTt06Z7JYg4mAB29zrEnE9Mkamq0FTzA9MLYiHJMVldirHazKiRXyQop0spQ0wbG1lhPy4F/5Vxn5oQhP6mzTxy0CdjM0bmuLiq48c+0ff3sGghrOIgl3xcywF9jvwvqEwsn0HnuLTmfwDoGjluVSfEDcsYxQKvdr1way7mZfVj7vgn06OMYd87yIGlCkqOgjuf1fGp40kj/NVg6Ohp8Xyz8eW3jQGQbDJKD6Ix64lk8P3D7oiMCUioC9l+UKF/34dvN6kKGUC8aDNe73+Mzr7MEeDVS0IoM1X2L8AU/d0A3nH3MXb8bZbZPFfup7VS1A8enDhzUP6YuCYdRZbPEs5yCD+CZi7li/uN+Wq76SfnQsjqNrxYlr6i8NsKbqxmg/3/eEsJ1woQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEhjTkg5MTZaWWFHQW0vdy9lajFIeEo4Sm9ISGdQRm9xTWlhMTcwbVBWRUVp?=
 =?utf-8?B?bjNsUktHVFNRMXMvdFNSdmo0MGMzaUxaeUZXWER6UjBlVTliZHN1WDFsSnlR?=
 =?utf-8?B?VjdGY0RRaVdMZkhXZGxYRWo5UjFNcVI1UnArRDBtcVZIUS9MZHJHeTByLy92?=
 =?utf-8?B?YnRsazV4ZW1nR0xuMG13S2RKN2JmNGErNFMrZ0hrTzZSMEI5SFBUc2ZzeEJK?=
 =?utf-8?B?VTFLeW1mTFZtWEJwTVlWZDNnVHNobk55U0NvZldDVm1KcktmUHJJZHFIZXI3?=
 =?utf-8?B?enN2YXdhdERGaUVHdUpGUFB3NnBEd2hQSVN3QmF2SUhySXErS3ZBOUwwQWc2?=
 =?utf-8?B?UHo5RUs0ZkJBVlhZUFdoTUsxL2JrVWhvRGl2L1ErcC9XLzk3ZWpEajB6TTlZ?=
 =?utf-8?B?RWhhcDdlU3RFUmlyb2FDUzRZLzZ5TnZLSDFNaDZ1N1FpVTc1Q3h1QmE1Y1dV?=
 =?utf-8?B?NFpoaDFDdlFSbTFidGtZZ0RoaGcxS08wekxlMHhsR3NJTlFxb2ZmeVBnSXQx?=
 =?utf-8?B?TjlsVXU1THlxVDNYVXh0ejVvdkFsbTFFVkdHaTZJcU92Mk9nNGRXUUxUME1R?=
 =?utf-8?B?bTFEa1Z1RThabFRuZnFYRTBGVUZqalJlNW5tQ2xuWUROd3MvLzFrNVFqVnZF?=
 =?utf-8?B?ejBHZUNCU0l5NE5IRmFyZUEwQktJVFlVcnRKdTl6WFgyK2lGbWZucHBiR09U?=
 =?utf-8?B?aHN4ajJqQ05NYThGMmU0QTBlYzdqY0d1MFJnMEdwN085d1NJWjh1d1lVenhr?=
 =?utf-8?B?MkVkYzJJUGRabU9OMnlEdE9rQzEvdnlWaWNtc09mNkJDK0ZEYXM1RXJHVjdX?=
 =?utf-8?B?b0hzc0Z6T0FhbEJYMWJMR0pMeUZnTHBaUHYxYUFlbVJ6RnlNUklPcjB1a3Zo?=
 =?utf-8?B?RnFWZzdVN05SaDFUTHhsczhJR1FYNXd3UnRuRm13TnhobzgrN09xd0I1M3BW?=
 =?utf-8?B?Kyt6d1ZrY2FzQ2JlY29HdkpMbjRkUHdvbXBxRnd0eFRHVFRnY1F5cUY0b0Jk?=
 =?utf-8?B?U3V6NlBFRE1xOTJvN1F4TEUzR1c2YnRGV0V1ekEwMzBZNERJdHgvSXQ0djhj?=
 =?utf-8?B?bWVYTVZFbUR1SkYyemw3RGIwU3Yzd1M5UWh2OTA1R1pUV0hxeHN0QWVocTBZ?=
 =?utf-8?B?Um5LTGJOSUU4ZS85UmNCTFFaWGQvTGJyY1F6NlgrZFBKaTZMTDJ1b0szYnox?=
 =?utf-8?B?TFNTeS9WWUF4TXo5dmJsL0FDZkwzekpFd3cxQlpkVngxOUdrRVhhSlJndkJ3?=
 =?utf-8?B?SHd3QXRmYm91YVN1M3pZOWE4N082ejV3ZlNRU0JsODErR0VQY2VvQnY2RUdF?=
 =?utf-8?B?V3A1cnNmbEh5NzFJNDBXc2FRZG0vTzVERWxIMlNibkxobWIrYXBwVUMrR1py?=
 =?utf-8?B?YXdKQkdaVzFaMkRwNmpwcTV0UFE4UWNENmNiR0FYUnVzdWdFS0ZUa1dSZjA2?=
 =?utf-8?B?dEhKcUY1R2kzS29NWmgraTlNNno2QnVQSGM0c0ZZUjBJcGJadjRxOHF5d2RY?=
 =?utf-8?B?VVNuQWdzVFU4OVB4R2dJTVRobC9md3pMUysxTGsySDZmWnBVVCs4VzYrcUNF?=
 =?utf-8?B?WFpnM04vcmE2d2x0bVVTbUNpUnVYSTduWm9BUTZ4Q0ZvY2RoREVEWmxyZm0r?=
 =?utf-8?B?bkdpczN0SXhQSDBuMzBGL25uQkhKSEVpbmluTUYvK0kySVJZY3pEUWtNQUdU?=
 =?utf-8?B?RGtkNFRqcm1NQ1c0UHF3NmYwcGZpR1llbWgyRUo0aDduMHNWSHdaUEdJWkV3?=
 =?utf-8?B?QktRajFrUDVpZ1A0ckxiUS9WK3BaNUNZbERobGhMcTczT1dOQ3FvbGpsUVZk?=
 =?utf-8?B?UCthaWpjRGdrQjVabEpDQ1VzSnMyYWw4K05OMy9mKy85eGJoMmRMUW5uSHl1?=
 =?utf-8?B?RElEeU1YNWtJWW9oY2svQ0g3V3d3ZW9XZFBlT21hRCtqclN6aXU0bjlZOGRG?=
 =?utf-8?B?azBXVUNVWmdxalhXNHdJKzZRekIwV0lpKzZhWWhtTW5HRE5qdjJFRC9KV3l0?=
 =?utf-8?B?YjBhK081a2hYYnFzcDdyODJHN0FKeGltRm9iL0pQQnF5aEl2VTZDUDNDT2NM?=
 =?utf-8?B?MW5aalVCKzdTMGlTTE9US1VXRXB5VEU3dGpSajZQbFNqQXVEc3lWWkYrYkZl?=
 =?utf-8?B?RFFRdWpERHRCY0FYa3BnNHlVRXA4OEdPOW55L3RPbC94TFR4eHV6WHBWVDBZ?=
 =?utf-8?B?aXhvNGhQV0xTck1meTU5N3QwSDVjWmY4T2FJam8wUVk5YitKZjFLYUlDTG1M?=
 =?utf-8?B?Nk41SUUyMUtlaHMwQXRja2NqNFVFTWxPZEJ4UTFIMzd1ZDcyUU1BSUU4aWx6?=
 =?utf-8?B?VExoMVRXMC9NWGYrVDl1dHNCc2JpakpSRkdLSm80SERVbHd2aUdOdz09?=
X-Exchange-RoutingPolicyChecked:
	awZ1uYcPcXu6lKvu8CkJK6V6ugBoF+M7hFjcjgFE6l4tz5fAz1xDLwY4girdpfRigZxcwK2HLoQlhZcfBo78BjRJT816bI2HaHKr/pBhXlXOXqrlA/KZed532XoAr+hdytRjwWqdR/cfzHDX1PHcNooWTGs9JDI6DUBWsLG64BBUI3yWeMKytP6S/ixW5O76a885/18sbSOZcZnxUMcqYpR8PXz8Fi6WE8fzIpb2ctf3OKPMi/xSLM/yUZ0AE9EVX4KAJoYMO2ICKunROI82yLxSLQsgvEhhUFc/1JHyA8tPaftaCcZBd41yVhn+8ZWIvhZYWRuIZB5V/daiEfW/zw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	krOvquGSp925AgUkGxksAmh+X2fxRNzXQJTclcTBcf5J6iWfhHkFjEvg3kTi7QvURZAwr/7eWp0A3+D46g7hwvnvf4ztYv1JVqiTUvhDeBDFDlh2W+6XATRc12JPSaqAKtBXLAXJqf4EXYBIA9pVI5gzIn1oINWWcxp+vvJKWpMBOKnqbVCjRwJNCNnJKJ6hECif7wjp6qwyDQoC7ulyRAz6Mfr7F5anJlaPR7aYtR9DyD2AsyOnE2sEnStKr/9oXrWxRvJYZBn1+DDI5mBflG0iQxeVqqRM1gZaIB887T28yIgGvekN/gfLM+T6jeFLMvFX1jSNl4ihCinoHrS2+zhRgs9eu6txzlkFr1QxBRvcbGywXY/HTnyPFaTm79LGP2X66y3Ahc+AdsfouYW0XOSVOle/YcPhKx6+TM2pMZH30xkPxZREraGb6/YuGpMzfTooOMCMEobJRksm3vtVxXkHAFs8CDGt4QNAmJaCt1VPHLQEca4Xkxx4cLtHDrOhInnQNBq4h/f7s88V8OjMI+oEy0aaY3tomWDJfQ8OoR3ZFLr3QeQPupT6C51Q2GD1rUTSquObXw4gVKBWzJHsFUvQedRZzbWXaCh7Xu4YHMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dac1910-fca9-4837-9caa-08decf93c4bf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 12:51:10.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxgioJasJrOUagpX8O/YdtRPjzUWOLINjsEzmZ/IOG3ddWjKFTCMWLSFXTu53ucQ086pwrjM+ZZiJUki/Xlw/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606210127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDEzMCBTYWx0ZWRfX7EBRm7mT8ofv
 xxhKF8kmEJ2PuMLlA3L4oRTQHubXesw8xkRfygL6RNLsYeotbOnsMt63FNqMxObpkLZoE/y04Rd
 hUdBUuoRz7OBBjCNlcs9nAmWPwQzMKMt6UceeywGuW0mAlAkbcXsRkIAQuP2rNRThuXx2jVngDF
 d2QQZKDYPyDI0JNQbgd2Fc6nnWNWX98DuE2/XGGEa3AvOh/SFddM/iXzoaXsXMvQVou3w9zgeaU
 RFmoBINOtS3/SMnV8mhV4ZnjZAtn6Iopzsktd8fCI/1YfSuBvIgsdI9NsNxN/Uw2H9NmLbeJBRx
 yUKDU6ecPwodECgauPn7guD8nOBFro8wIEYiGL0JcT9vJdCleq5BdSGpFwCEpkc9oZtB/D75rhd
 VA7SAeqo4ZBO1VpYLcunDpFh+VPGfDz7Z+bCeJ6mDOEd9+y660+tg+qYsxDbC9wSy8pCoNBV//U
 WNeiBy9qhxy6C4OKy/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDEzMCBTYWx0ZWRfX8qM5LNixu8jx
 N/YUOGqBFF5SQOFqi3Kg5qUA8W4MqkyuZhx+t95bRQdGqcnMu7yU5GLC2MaNSBhP8cYZCu1Hxrf
 wLxUJ9jbLDsHNRf6kZYBuu4OZCjwsd7yBR//W5MSelXuuGhRWJr2
X-Proofpoint-ORIG-GUID: YbwJrYpRzw93A967JLpmUlOuTtZWQpq-
X-Proofpoint-GUID: YbwJrYpRzw93A967JLpmUlOuTtZWQpq-
X-Authority-Analysis: v=2.4 cv=A+lc+aWG c=1 sm=1 tr=0 ts=6a37de42 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=NEAV23lmAAAA:8
 a=yPCof4ZbAAAA:8 a=Ye3t3m6HV7oa57SaTi0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On 20/06/2026 22:01, Yonghong Song wrote:
> 
> 
> On 6/20/26 1:30 AM, Alan Maguire wrote:
>> Need to test full matrix of gcc/clang + x86_64/aarch64.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
> looks like we are still using llvm version 18, could you
> increase llvm version to 21 or 22? Or ubuntu-24 only
> supports llvm 18?
>

good idea; I just checked, and the latest supported version
is LLVM 22 [1]; I'll send a patch with your Suggested-by:
and land it shortly so we're testing the full matrix with
recent LLVM.

Thanks!

Alan
 
[1] https://github.com/alan-maguire/dwarves/actions/runs/27901540634

>> ---
>>   .github/workflows/test.yml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
>> index f47cc4a..a81aa55 100644
>> --- a/.github/workflows/test.yml
>> +++ b/.github/workflows/test.yml
>> @@ -34,6 +34,12 @@ jobs:
>>               llvm-version: '18'
>>               pahole: 'none'
>>               cc: 'gcc'
>> +          - kernel: 'LATEST'
>> +            runs_on: 'ubuntu-24.04-arm'
>> +            arch: 'aarch64'
>> +            llvm-version: '18'
>> +            pahole: 'none'
>> +            cc: 'clang'
>>       name: Linux ${{ matrix.kernel }}
>>       uses: ./.github/workflows/vmtest.yml
>>       with:
> 

