Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3B17F4F6
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561953; cv=fail; b=XkGMTbuq/Vp/3V+SQ9ji1mSpra9G0YsvX6PlAUuZkU4OHi76j1VS876lrhV0PNpV0yBrG4OMQ9xHkVpdmex9EM2aqkvRjS3XU25FYx+WpXx5NpApIq1rRZjWJj2pPN4h7/pET11EfWF42RBxdNo+ekmTxhoVDvOxJLDfujxQsHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561953; c=relaxed/simple;
	bh=wbXK5WNTX93V71T6B5I8iNo75oziY+eWZ8aXwkqzR9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I549RztGpn7EusmyMlC7wfIloi3a6jEQMpTi1KWZiHrQgYWxEp2BoB3TeXwUBjzVCpwSB/tifNhiVEI9qYF1pus7s51omm5lFWlQWxt8WbZP5uorG6/ly7v0ILknOm0IxfHyBGqXy6S2TUoFKBFVWxuNWxHtfQiPtP2rm8c7tAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZHl3o3Q/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M15dVSyF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZHl3o3Q/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M15dVSyF"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHXYsi006797;
	Mon, 25 Nov 2024 19:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2OEcnI/4jf3AY7lGrt5q1eLC/xKtwGR8dFO9BMW9gPs=; b=
	ZHl3o3Q/zFgUth8JasM6fPgrc8YJnPH2P2kOtR9ne/lX9AUPqyVPl05FphAFX1Rb
	/orQ1e3GPrjw4lotREdfRjBsjXaO0SPgkj6Nv9u1Ay9qRHMqjgahjZF1L5tlBB+1
	uJEV1OPzfIcEVq6Op4qeXFL/h8+jYAwa4yja8G1UeFkEppmLy4ACvKroUZfvf8Ti
	OEY620Xs18K6Gw1n0V0lyhQZc8Q0/Lb6opn0FyfcWURftRKg50w9xGkpWOYmT2la
	r927IQVJSDlzgk5pqypRuZaMZVbuhTnVUhqtd94qlM0w+tarxKoI4iASudC6loDA
	1b0Kyqkgenwl94w1ANRQXg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43385ukw5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 19:12:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHam92002672;
	Mon, 25 Nov 2024 19:12:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g85bjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 19:12:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m97lCb7tUSfCWPTop9X/Waudl5qwhnAMLlswXjgZqb738i4PvU8gwgOwN300MMTJizxwD3gVAIR7R3ShuxNdgj6HBwmidhbKmRivgDZKeZzJ1fkD1cfjt6SvlZv0Sl3jo3pRy9YsV5HVCAuSjww+KltSijKwKeIsg3usZKQJh/HF7Q20TNBqspttL7riXe6qI+uEECztdPzcB63bvglLXYi24ZLLy7LARjm7YqVAzHU1t+MdQa2ktvPcI+WBeoTeNn0FHiouWvUX9nBPgXro7X54ugICKPsVWadcH9NYmDiniP1tivox09FsC9OX9RFHpUzuME6bUqjpsIgejaMfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OEcnI/4jf3AY7lGrt5q1eLC/xKtwGR8dFO9BMW9gPs=;
 b=pTvwoJSZHS1nTa7O0EBiLetiPK3c2ygvyc8988A9mYyVn6X4iKkxMoHy08oSZ+FAzSrtzr67QSx7OSFjuDN7LKYQjNMZzm6+M1gGzHtuOALQFcjNeD6W7v4JIALVy/7kuC7LKj7EOobf7zdfNa08nSGFCveGIE3f9ADDovkhgVJQqTZ8QgENhGR+t50EkeGLIg29Mtm86jnZcV6yDSuFK6x6+0f7vNa4aDhK3BFVRnW4A8bvHYn6Xr3KRbuqiZ/R1FeIin6ldik/MLvScIBK8B88PHqQjTescdIKrmJ6OLs4AObZ0mcY5QCGcTGZ20Q2ILZtTeobOJjiAWDWCmKoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OEcnI/4jf3AY7lGrt5q1eLC/xKtwGR8dFO9BMW9gPs=;
 b=M15dVSyFPA1ONNqhU51q7/XZauSyQiYeGjksLOk/5dsfYo07M5gQnyzM8xynSv0KffQYvXMWnEifAvQzfPKUy62wo4hsMA6fC77gKhp5ocyGbDRmTnXP18YgSC7ex7zvHlMavMKudfP8RCBkRKp35WhDgCS+/nIFU6xo0O2wqCg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4350.namprd10.prod.outlook.com (2603:10b6:208:1da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 19:12:24 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 19:12:24 +0000
Message-ID: <7c3d6ae4-8f0e-4b41-a532-bc30c2ea30f0@oracle.com>
Date: Mon, 25 Nov 2024 19:12:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] Respect CMAKE_INSTALL_LIBDIR
To: "Olson, Matthew" <matthew.olson@intel.com>
Cc: dwarves@vger.kernel.org, acme@kernel.org
References: <Z0SdF3u92HMAu96S@bolson-desk>
 <f52e76e5-457f-45e7-b9e3-77ed273cae3e@oracle.com>
 <Z0TFksQxRUvEucrF@bolson-desk>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z0TFksQxRUvEucrF@bolson-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0211.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: 02237e67-cb4a-4cb3-6279-08dd0d8517df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTIvcm9BbE9BNWtDdVZIU3hBanA0TTNxTWVESkg2ZlBrZFpQQnIwd0xEcXhJ?=
 =?utf-8?B?RE9KZHlYUFpiMmZ2SVJTb2pmQ0RsNUJ2VnBHZHROcmdOYjMrVlcyY1BncGZD?=
 =?utf-8?B?dmwyd2p4RHFXazFzek9RQk5wUUgvZkxYV29XUzJRQ1hpcWNJZFZaamllTXNs?=
 =?utf-8?B?Vjc2Z0R6NnZrVzh0YjNUSlZBOEFwN1dpcXhWVDJkQjhpcG1EMzNsQVhRc2VO?=
 =?utf-8?B?NVZ6K1U2UjRwdnJSSnorYVl6TWI2RHBPS0p4Z3VWMDhQeTBGeDZQZmNwWjZx?=
 =?utf-8?B?aWFXcXFtZDgxUFR0Q2RMcllMTENMSUhjRk0xYkx0bFlWTWUxYm5vZ29CemIv?=
 =?utf-8?B?UG5kSEdVZE9aaWRFdTFiaVZhODVUdDRibWhET0tOalN5Zm5RSkRpOUxyem1C?=
 =?utf-8?B?Myt0ODlYdWFiSlUxNzBXM3MvK1hZNnRFMGxhRGd3V01wVWs4RnNHeUZMUExa?=
 =?utf-8?B?Q2dLQ0JraVdJbG1XV1Z4TWt0UEJRMUtUTG1CRlhwUTVzZm44dnJSU3VZa1B6?=
 =?utf-8?B?QjN6eENzVm1SamZja29pd3V0TWtQenNDQkliZlA3VHNoVGJkQXgwSjYzQUd3?=
 =?utf-8?B?MGNqWm9VUmNXb3kwQlpjeGVOMW5XTXRHUElsTzU2aU9SOGd0SDNDd3dINUVt?=
 =?utf-8?B?b3F2b3JUajNqNVdjSndPem9ZVURHV3V2V3NCQmNWUGNxcldRMzMycUdEb1Z2?=
 =?utf-8?B?OFdHcCtEMEFWU1E3NmJuUGtLTjhkVVN4WVg2TXdvMTBsV3lsdFo3dlM0dVRi?=
 =?utf-8?B?NndkdFNUUHJSbVRscTFYakExcDk4L1ozS0VqZXdoa3Q4L2FGQ0E0RHo2Q05o?=
 =?utf-8?B?NkJ6cjR0M1NQcndxZVVPaWtGd2ExckNtOEI4Y0pPWFJwSFNtVjE3aHdxUnJL?=
 =?utf-8?B?WldjQ1JFcjVGQkJPanR6ME4zNjgxdHI1TjB2OS82NkpERk1NYUJpNmtWYkNE?=
 =?utf-8?B?R3BrT1dUQzN2bHIzZmhGbEQrQXhDejFPQnBMVy8zK1l6UVErMm5XUy9KSXFU?=
 =?utf-8?B?VHUrb0tlWDJHbE1FMmRGMkNCSmdSZlVXM1Q1MCtySTdKMStqMnRSUEVrMy9k?=
 =?utf-8?B?RjJ5dmJ1LzJiN1o4WnJDQ2RRQ01XYVFlbXBJaGFhd3NaM084cCtMWTB6SUts?=
 =?utf-8?B?WFQrSWxjMm1KdGxNWXNWQjJJZ2lHYm9XbDZsK2ZHOU1qeTgvK1dpNlQ4ZUVa?=
 =?utf-8?B?ZVhGdnprcmxRZUV0WFZxbCtBcXl2VTRueER1U2cwTjdYMWdFUCs4VkNiSms3?=
 =?utf-8?B?MmtjWiszZCs1ZDZJbW4vQmI4QXhIYUQ1VkxYQ1FrUDBuUENWenV0UTJTbjlE?=
 =?utf-8?B?SVpPSEVQa210SjZseEVzQjVRL0FPUHNkYndsS0RUVHBibDR2RktkbjdsR0lS?=
 =?utf-8?B?SHphR3U5ODlZaW5kQ216VENCWXplZ1Y1dnNCUmZKV3VGdVl2QlZiK28zT2tO?=
 =?utf-8?B?ckQ1ajg4OER3NU5Eck9panZEbVROS28xZElUMFVGbU1xY3pjNW8wdytEaTVH?=
 =?utf-8?B?VC9JWS9xMmZCSzV6Y1R0ZlllVzRUc2Z1TzdCS2hnMVAxdUl1M1Uxd3ZaMkNT?=
 =?utf-8?B?Z0hqMUlSRUx5UFZIbmxkeWw2cE5haDNQYjRZU2FVV2o3Ym9oQXNzekl3cVFN?=
 =?utf-8?B?OUZ0enFNc3dwc2xkek9TV3FvN3VZd25uYVBRbGVRNnRhNTQ2L21ZYWxTbW9a?=
 =?utf-8?B?Y3FXT2kyQVFEc2hheE5RVzZQWXlLRHM1UXowSEVDeUNyM2h3OCs4ekx6SXht?=
 =?utf-8?B?Q2dENzdMVEthd2ZFU2MyWGZPOTdMRS9yM2NuYUsySzlkdmJEYURDa2kwOUQ2?=
 =?utf-8?Q?8CR3bCJVXrob5tWqTclVNp4O1dYRHjmwchC3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU5OVWNlc0FOd3VicndGaU9KaFZFTDQ1SytiTFJVcXpmVmZGa0tjY29Ubmpp?=
 =?utf-8?B?Q3ZWaUxGOEVDenZVRXczZ2g1cTN2YkNyUnVOb0RXSFpaYnRaTXFNRVFsSHJp?=
 =?utf-8?B?THUzOE5Wb1gvdU93aWNWdW9kdTZadDVWdVRUamhFa0tyQ2hqWVJ4VlJlc28x?=
 =?utf-8?B?NEYxbmJDTXNibktmRHBGYllOVEpZM3VTeGJnT3BzdFFRWE5VY1kzc0lPVnVR?=
 =?utf-8?B?VnBEVkUyeDZ2NmJKNTNUOHhxKzlFS1BITGVZSWVWUXlibEV3eDdZcmpSaHNV?=
 =?utf-8?B?SzNpNXIyQ21HUFBJM3d2bUYrVGI0ZEZYdUwvYUhDczVEeW9ua3hTWmFpcW9G?=
 =?utf-8?B?YmxiNnlVamY5M2FkWU12Zyt4TmM2a0NraEFKVzJwUUw1c08wVXREUEtHd0lS?=
 =?utf-8?B?N0hrLzJTTkZ6bzh4ZGYwZTZWaUxLNkorRmNmNDRzQ1QrRi9zMFlFREpxanZ4?=
 =?utf-8?B?cDY0MVhNUGRSK0w4SytKR0JQRnJpNjBmSUg2UVIvcklsaldINmVpd21LQzlC?=
 =?utf-8?B?V04wTThGRUI3MytqRjJmMXBBU1MwMkhCU2NYQTU3Q1IxU0NtNHV1TXgyOG9L?=
 =?utf-8?B?RjhtWXkwR0FXR2RERWd2dnBld0xCTFV4UjdFY2l0YWRwRGRwd01qUUlyanhT?=
 =?utf-8?B?V0VzTDFTQi9DMjBtTkJPM0Y1RHU3eTFDdk5qdmJWNjJESXRiVS9VT1B6VnBG?=
 =?utf-8?B?MVRhb1BqOHhnK2V3MUZGbFZ5UHhXVGFBK0IwcnBBckt6QXZXMGpPTU93S0lV?=
 =?utf-8?B?Z2NQMVpsQUNLS2VHVUFmT09kSTNJSlpDejVwamV0ejBFczRXYzYzTlVodlNY?=
 =?utf-8?B?ZFB4RWdXV3I5QU9NUUJyRUNPVHBaamgvOUFCUGRIQkVaR25HRUtSWnJoVEto?=
 =?utf-8?B?ekIvdTVZREZ6cDAwZkdLODljbWxiTExtd3gwREdORXVCbGVwdHF6b05SNnBv?=
 =?utf-8?B?WXdMZUZySXBFTkQ5YWsrcEJjM3cxajVFK0gzMGh5NG12N2JUWUljRUVuOWZs?=
 =?utf-8?B?Y0dqZFlOYXEybjdiTEw0QmlicjNtQkgvYjlXMWxONDc1MXIraXorL3BVK3dv?=
 =?utf-8?B?WmpjQVZYMHIyTGFBNUw0TFhwSE1ic25FMDRLRG5vVk9PQmwzNHdpRjNtMFN5?=
 =?utf-8?B?Y1d1a1c0b1dvbzh3OUVBTFFqLzgxQmtVdURZRWllQWFrSFJDN3R4eWdKd1pF?=
 =?utf-8?B?N29hd2dWSzFqeU5OWEkyOVdPMHF1MWJWVHVlR0xvR1lzbGE3Z3hhSXgvRW9B?=
 =?utf-8?B?Q1hLY2xlaHRJQlZFUTNtQzRseUFaYWh5WmxDSTI3bzUzdHkwQ0poN0NHSlRN?=
 =?utf-8?B?aXB5bENBTVdiZ0xGdlBtZnFyNWUxYXZaeG5KaTB0ZjFRM2xqaVROQzZ1UHhp?=
 =?utf-8?B?WHFhd0F3a3pvWFJvMS9uUHRsZi82VkNpM2M5dm1wbXppNjdHUDJKT2JGbGJ0?=
 =?utf-8?B?RWZURUR6emY4S2crR29sSWhkcDV2Zk5WQmxHNjNkNXd2WGpLV25RenV5cUEr?=
 =?utf-8?B?QjNzTWJlVTVzVFN2R2xEbmNyTmlaWlJNOFZDbEpFWVc5QWYxMUFJcHZXb1My?=
 =?utf-8?B?MnJlOWpvMWZIRFFQUXNoUzJHTmFIdnpyTm05THRaY0lEWGFpVm4zYjBLdDVP?=
 =?utf-8?B?ekhtcU55cDlHL2IzMjNWMXo5OWRlTDFIekdFQXBFUHk5c3RET1JSUjJoZTJH?=
 =?utf-8?B?MnpkcDR5UlVTb1Y2SW9nWTRDTlE0b2JPYkpoYUo2TFRuZTE4YWhuVUNZcG9w?=
 =?utf-8?B?djZZQ0xvRlN2SWVFaTdld3FMN255UXVjMzlhcGVxOWg2bWd2S280NHQ4bHM4?=
 =?utf-8?B?ekFwZ044VlZSMnpYQ0lyNkVBNTBmUW5qeFFnM0t3MnI1TXIzVXJGWlcwM2lI?=
 =?utf-8?B?c1pldVowSEI3YWR0SkIyOThKcE00bnpVbS9UOEd3K0RjdENVaTVRR1RHdkp3?=
 =?utf-8?B?NlVnNGxZTHpVdlFLcXBYSVBhcDNiRlc2NHNJTGdFZlA4ZTAzbFhsNGNYRWhI?=
 =?utf-8?B?bmkvZ00xRHU0SHBNNTMzSG1pcE5DREZYTFl1d1c0R2szVEl4QitJT281N3Mz?=
 =?utf-8?B?dTRjZ3YwcXN6Nm5weWJIMjdCMk0wcGd4TSs3MFZJMHF1Nk1MWFEvTDJWZTRP?=
 =?utf-8?B?V2dXTDJUanp2MXVVa0xtanh5QWhROVNZQmoreVFkVmtvSXhYazhxRjNub21H?=
 =?utf-8?Q?WGZxJWdL6UmI64q77EwuOEI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N8RF+uyWsDxraqzBosgkJ5G3GCB8lTBMAlTgR4KXbCEk0K6Rh2hDr/ufSodenE2Dit4i5VxDog3WQz0L48frFErN+LOdtNbfnqZtaWhINltH142//DXCyuRGEa06BmHOv4PYw8RvOiq6ugJ17n9dGGREei63PgfacBjtIlLiLofmg5DbLI0+qtwNLubShV37mvlpB+cSKF9QFL+lQLHgdnjmHOqakpRPZPwLJm+0/UADUfNwSbtcahjIfyk/kQnm7Wtfh+fmX534UbJouSG8+adYU9EApiXwvgwnHiFxfvqv1q2ci9ebbITkKA6e5wMQgxuuUJ1dm5BQ2h4s71Gy3wUC65eFAaDU8KrwE7NzFkAahrX9Q0rtv4HIa6V0PN3cq8Gcm67oDfJ3NAcPIqotVQSYOiJRyOGRRWwonOwo+ahtFsUIvD6qd2FsaHM5ayjUzyCeZqrxfu2DSqZ7s0S8tzAL8dPr5ZWs0/9z3ExxntK7at/gntP7hzSnKVn/gHNLZmzIB00iol7pC+wLZWBGLsVeWpJbGRUTbeefTWJ9eKtCHdpvNj9J8kB/jHZR7d7roaE692VizzMDgJc2ins2XC8GnRn6GG5gvYxDM6zJ/uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02237e67-cb4a-4cb3-6279-08dd0d8517df
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:12:24.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPKeCRISlEmZb6I7EjyNpTp0NoSKVIrqiKZ9uX9cAQCEKJAx/9h92MjVtAcWjeDp9nU1sOP87MnjVq2g1daziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_11,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411250159
X-Proofpoint-GUID: T_BQaxQ3FG2IolpjAlRz09Gdfm3Mu2Su
X-Proofpoint-ORIG-GUID: T_BQaxQ3FG2IolpjAlRz09Gdfm3Mu2Su

On 25/11/2024 18:44, Olson, Matthew wrote:
> On Mon, Nov 25, 2024 at 05:04:53PM +0000, Alan Maguire wrote:
>> On 25/11/2024 15:51, Ben Olson wrote:
>>> This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
>>> and use `lib` by default so that installations match the conventional placement
>>> of libraries. For example, it will now install `libdwarves.so` into
>>>  `/usr/local/lib` instead of `/usr/local` directly.
>>>
>>
>> What about distros that use /usr/[local/]/lib64 for 64-bit libraries? It
>> seems like CMAKE_INSTALL_LIBDIR does the right thing there also by
>> default, can you confirm? If that is indeed the case, it would be good
>> to amend the commit description to not be "lib"-specific, and say
>> something like "CMAKE_INSTALL_LIBDIR ensures installations match the
>> conventional placement of libraries - /usr/local/lib on some systems,
>> /usr/local/li64 on others. Otherwise folks might think they need to
>> override this when they probably don't. Thanks!
> 
> Yes, it should respect `lib64` - we've just tested on both Arch and Fedora.
> On Arch, `lib64` is just a symlink to `lib`, and this patch places things
> in `lib`. On Fedora, it places things in `lib64`. Just noticed that we do
> have to include a built-in CMake module for it to work properly, though.
> I'll add that in v2 along with the commit message change.
> 
> Thank you!
>

Great, thanks for confirming!


>>
>> Alan
>>
>>> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
>>> Signed-off-by: Ben Olson <matthew.olson@intel.com>
>>> ---
>>>
>>> This patch addresses this issue: https://github.com/acmel/dwarves/issues/48
>>>
>>>  CMakeLists.txt | 17 ++++-------------
>>>  README         |  3 +--
>>>  2 files changed, 5 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/CMakeLists.txt b/CMakeLists.txt
>>> index 8ca1bf2..b2c8057 100644
>>> --- a/CMakeLists.txt
>>> +++ b/CMakeLists.txt
>>> @@ -21,18 +21,7 @@ else()
>>>  	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
>>>  endif()
>>>  
>>> -# Try to parse this later, Helio just showed me a KDE4 example to support
>>> -# x86-64 builds.
>>> -# the following are directories where stuff will be installed to
>>> -set(__LIB "" CACHE STRING "Define suffix of directory name (32/64)" )
>>> -
>>> -macro(_set_fancy _var _value _comment)
>>> -	if (NOT DEFINED ${_var})
>>> -		set(${_var} ${_value})
>>> -	else (NOT DEFINED ${_var})
>>> -		set(${_var} "${${_var}}" CACHE PATH "${_comment}")
>>> -	endif (NOT DEFINED ${_var})
>>> -endmacro(_set_fancy)
>>> +set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
>>>  
>>>  # where to look first for cmake modules,
>>>  # before ${CMAKE_ROOT}/Modules/ is checked
>>> @@ -84,7 +73,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
>>>  	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
>>>  endif()
>>>  
>>> -_set_fancy(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${__LIB}" "libdir")
>>> +if (NOT DEFINED LIB_INSTALL_DIR)
>>> +    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
>>> +endif()
>>>  
>>>  # libbpf uses reallocarray, which is not available in all versions of glibc
>>>  # libbpf's include/tools/libc_compat.h provides implementation, but needs
>>> diff --git a/README b/README
>>> index f9aeef7..0627872 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -3,8 +3,7 @@ Build instructions:
>>>  1. install cmake
>>>  2. mkdir build
>>>  3. cd build
>>> -4. cmake -D__LIB=lib ..
>>> -5. make install
>>> +4. make install
>>>  
>>>  cmake Options:
>>>    -DBUILD_SHARED_LIBS
>>

