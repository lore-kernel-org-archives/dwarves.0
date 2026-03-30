Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF837EFE9;
	Mon, 30 Mar 2026 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859522; cv=fail; b=IR6OtU9ElhxgZCBldYaJioOWgESKfQL5wh15KN8vDJ3n4s/0T4bO1ye63NGwNrj9rolgzthaDOhmE6F5yLRMjxt5t8sP69QqQT/HFkv4ebWBLQGVZC66Ayaj6ffbsi70cT2rkenh9rZj3aXNUQUjS6YFd7if8ssNCe97gCl3pLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859522; c=relaxed/simple;
	bh=WGzYYhu8Sf5UUKtICTEMh6BNzXamGJJP1h+V4t+o2Bc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nzlRuztpA/gE3mBpotRG5I//aYtzRN1/yVFXbWiu3n4iOmRlsw9Ki/iAh9YMt5/CpgEWccbW7nRDaNAT7mQlYPGOTWjwk2yBBIjdmqgHX2VKPcX4zSNutfqhzRW3VmodvJMqeQI8q+t+buqfIZzZNbz+kCGUFAUPY8ZZ1nglipM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FkcYI4wb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qq5C8SfE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FkcYI4wb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qq5C8SfE"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TNe1DJ2395463;
	Mon, 30 Mar 2026 08:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5mPi5TXMLLqGLnohG4227eEytozrCz9EaBzoO0Q9yFg=; b=
	FkcYI4wb2Z9r32cdZi+hO9NHC0iHFs+6eYQkEC7qLMfgbxDdE92EFTw7aT41bd3T
	ViPLz5RCPEboOkaXd6F0lhN+CrdpZhmAUkEAnCG58tUZnZoXrj5daDCu5Bz9PB7l
	mW/xPe5hI0TWmOlfjk8F9X13tqq3QW/N5aJhlwq3+QG8PvH2UgJE6JWorlUshuxl
	kOrHs8KpNQ8FKafEh2qhW/2eDUKIUN/Pobp6EhFaExsnHHlA+Ke1+YAPcB3/muah
	ckEnlb1uUNb+2TxCUlox/VO041egkRd+HswTWY4T7Mqney1JQ4/imngm0TYt/Lze
	5aaB1avKy+/uQ+bJJblg9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65s0sq4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 08:31:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62U6d8US029413;
	Mon, 30 Mar 2026 08:31:47 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65e86peq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 08:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMEMFU3ydrawEbapNwjJkiZp4H/PTWTIVykOYx3bC1mginKF+fHLrS/ezCB2QaC1yyZkHvIzyAFXtVPDS3PvMa2ekIYwoA9md4L1NA//BS7Yo+Xc3JCvPt7lI+WVqWS8QwhjhdDRxA6LuqpsyfRH26mCsZB/YGxFL0X9W1xwR1Wsz+4N6gbcjVftnBpzBEC6wxi5bFLZiv1ydj4p0ZofJmdvfHButVToOMyBrAedFIqYWReVLvIyjgAVz9qVL6i4zKJ9Xcr7NZvIY6EWbHI5/KkdiJYDls+WHldb8THs8i2KycmLiehsMGLzWNgwEhJkUBRr4xgDRBBt+vk5JBqblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mPi5TXMLLqGLnohG4227eEytozrCz9EaBzoO0Q9yFg=;
 b=hxJsmU77EzK/h1gt8lP342MAlt8Frco4aANjjbUjwyPOPk8epy6+LheQYgISFUBpYKDctfocwTrOwjGNyv2oLdm/dsCtM5r5M81vpA34gl/KAehYfjv6rqrvDWUeG1l1YyzJ/RBa1twFJezUYyX5NN2uHiutWffw4ACUkC5+IIoO9juP+NM2YYsDddTgEBfSu+DqhmwRrUGJYh35rIWMjegvBnS0mitAJn22rhajnxo1ZMEgUpPAZSDN3/i4brMT5FiMnPL/bHGOU9PmnkuzZcnOAqJJXkzhJibuqXk+pYfqaY20VNgtHTCIt4ghnyP/zdbUKPfEOIsw7rjya1mY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mPi5TXMLLqGLnohG4227eEytozrCz9EaBzoO0Q9yFg=;
 b=Qq5C8SfE0eN1U3QRooDxslvYtO1TaTPRRbYDU94kLxCwPuwZhetGFtT4miw6nLFdn0+N00N7CiRnE++2wt2VJ7SmwQPkutJ6yP7bSakjnPyita10Irlu1k5giNz5cThrmL/aev8djkqMA9MF6n2nEBuGfJsRgNvcmYS67eIwFGk=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.28; Mon, 30 Mar 2026 08:31:44 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 08:31:44 +0000
Message-ID: <b90f8fb7-539c-468f-a6e5-56cd8687896f@oracle.com>
Date: Mon, 30 Mar 2026 09:31:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 01/11] dwarf_loader: Reduce parameter checking
 with clang DW_AT_calling_convention attr
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
 <20260326013149.2902251-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260326013149.2902251-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0283.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CY5PR10MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c2bd99-ab33-4a18-e231-08de8e36c66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fNa43WirMnMETii/ig/jd4UsEArtK51GPaec01M1/9JRxyGpo20JpZ5Z0ul41PZMlNuFIJ+g3y7zxgAzYpuNIvvp8DPjzVt1ewjEtoCeBLL3s27x3Q1W/2Ud9EmEplmBveQRPYKKuuYHl1E0XA9A8iiTWrMex5CPsqigBfVm1+YGb8whnL8h1oDu3FUk4W5IAzH1LxEVC01zeRxBCHW6LK+fQLZOmRajgDbf488MHFGvpT0W/udIgqH2yccj0CK4PvcG9QAm+WG/go4rSaJLA3hcM2M3UtbOXZ4jg54GMPOKTCQOm3H4HPFDnnM4JCILgMPj3d0qsrMDRfaZgB4rZ6z3K3HDJJnMEiH7kVueV+iWmEgay/hvv2txKNaYT+gsgHwlUCAU+X3P3X/OlwGlHoYHcnPjGMd45t6aPpS/G2Hi+bMOzN/iyIO3CG/fnbMM5t32jBB7y47Im5uH/tnD0Fyo9Cdy7Dsll3T5GJ8Va2BOWWUuSoNWcmwv2YjJwmIncekNglGKcqhX0Sgy03DuowrSQEi3/PNbO5ynOjM+LeKx3Iu7USTMxwTjkA73bjs5Iw1taBv3gVZvtTJKXtaihsUlllvP/xdkDPsna7baDjKSjyaMa8FV55Nmqw7/NdUXoX7aWVDbZR45KsNWD+eEfKeJzZoBGWADYdN2WnqSWJLUAkV8bLmb7N6K567ODXoO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1doaTBLYXhiVDcyRkhTNWRyVUp2Y0hnanc1U3pRRzJkcGZEU0Q0NzRnQW1D?=
 =?utf-8?B?S1BlSnZIblp6LzR3Y1FYVW1jNUJqODhoVkFQdWd3RnBuT3JaOFllT2RmSjNw?=
 =?utf-8?B?RHF5VVdzdEhSSk1HeTVxdmZnRTRBYkt3YWRHUlFmamcxV0ZQK2FVa2VmWWhm?=
 =?utf-8?B?Ty9ycCtPQUxBNVl6NVhJRyt6UTJWTG9CRE5FRmwwcEpVVHVUVXdKQWJSbklo?=
 =?utf-8?B?OVkwaVZVRnFsNWZyNExkOVNPeHNUOVhTU0dTZllVRWlVTUEwZGpCQTFaUUVK?=
 =?utf-8?B?Y21VVk9COVVkbFZFVlFyd3Q3dHB0bXdvaFBxdFJZY1pDQzJJajN6Z1o5c0RU?=
 =?utf-8?B?clE2WnlmVGd1Mk9IQUU5NzErUGV3SWtoRVM2SjdyZDFOSG1nRjRSQk1VK2xI?=
 =?utf-8?B?SEFzRm1VcDh4RHc2Zkkza2ttNTdJQ0F1Y25RTk04aEphNEk3S2IrbTdEdEx3?=
 =?utf-8?B?N2dkOUdqWXUzL0liSWhvWWxReC82cXJITTFrVUJCOUswY0pUd013TjlRdkFE?=
 =?utf-8?B?NHR6SUg1S1pVblNxWnFsYUlKb000dnVVZmNUc21vN29pSXoxNzRJOWRWOExH?=
 =?utf-8?B?dkh6a25xTURZeDNHOGVZZUhxZEZETW0rdFJsaGZhNUtnWlU3VHJnUGRDVGRs?=
 =?utf-8?B?R1FuRHUzemdYejR5WXdYSytKR2xJRVFhMWkveCtoTkhuTUZSbElZRXNabG50?=
 =?utf-8?B?elV6TllaRUFUeEZzeVlsL1F1ZlRPbENWMkIyUGRheXZ6ejZjQUxPZi8xU3BN?=
 =?utf-8?B?anJSZUsvSXE3ZExSWTBpc2s0WG5OeXRlWHpGOUdXRmxjL01QV2ZoYndmVEZL?=
 =?utf-8?B?SFlrUnFqMU1odTBqUGhOT1N1Smx1VlZ3RE5VM1RNQXFYTUxKQVlyVVJWaFZU?=
 =?utf-8?B?bFRsSnVRcTI1TWN3M0xPZGZmY2hEZ2Y1b1FjWkN5YnpYSVB2aTQxa3lhRW0v?=
 =?utf-8?B?WEhvM2E1VWlNemMvdE5mWEVYNmFBb25PQ084MDZ5WkZXUHJCaXFXU1owK1dT?=
 =?utf-8?B?cFNPaWwyV0k0eGJkODh6Vjg5Qi9ySXBRWW5YTWgyeVlGK3hYWldZRGVVVHd3?=
 =?utf-8?B?TzF5SlpKdVFrUDEvTE9FRFMwVmZpbDBRTHlvc2xrcG1LUWdrdUxVV1IzZ3Qv?=
 =?utf-8?B?bGdJTVhKWXR2R2dheDU4a05rV1BQL050L29kOUROZWhGWmVPV2NVRmFiRWxV?=
 =?utf-8?B?UUxJVC9GMFQ0ODNTcndYSDZvdE9DUGs1WTBudlNvdXgxaVRiNGdCNUc1Q04y?=
 =?utf-8?B?UzZyL1RXR2hqSmFOLzJnNmY5U1lPRkNOMW5MeGUrUVFMa09GSzc2eEtWRkFk?=
 =?utf-8?B?YzdLUHZSd2hlN2JJQUFKQnQ3VXBHQmg0TUZmSHVJUmt4V2oyL2RUVTcvMGEx?=
 =?utf-8?B?bHRjK3BZT0VyY1FwTWcyQTgwTGtqalFKVXB3L3l2WDhtcHpjS3pJTWhrbVFM?=
 =?utf-8?B?b0NTeW04OFJXTnpoQVBQSEtHaWV1OWxQMHpBWDd0b1dTMkdyd2lMMUUxR0xD?=
 =?utf-8?B?WkY0TkVGNHArdW5JMjloOFhiTTEvcWdhS1ZlWUs0WUVDSUgrUDJRM1JGdU1q?=
 =?utf-8?B?WWpqTkhhcTF2NXVXUTJPb29UcERwTDdHcTk3Z1RhMzlEdHhMZGlINWxUY2w3?=
 =?utf-8?B?MHdHY0hEOU1YTlc0d1pyOTQzTTJEM2plV2JBVnVvT1ErbTZNK3FWVTVlcFBp?=
 =?utf-8?B?MnRuc3B6T2o0YjkvUXFkZlhJVzF5R2J3YnJEWWZhdzhXOXJyaW1Za1FnSW5C?=
 =?utf-8?B?S1pRRWV0RUluZ0RXT0xNenhuUEpBb0VoV3VOTzFST1JlKzFocTcrTnpwWWZQ?=
 =?utf-8?B?dHpxQUQ0Zm9Xc2V0SWVuNHBTbGpDbURXMkxOY2tIalF1eVk1bEwwTHZhck1y?=
 =?utf-8?B?SnVJTHQ5SFNJMzAyazV2OFJ3TENOekFNeUk1MmpJdG5odkxOZTVCR1lHb2NK?=
 =?utf-8?B?bXIwdHRVRGZhWUE4UEx4OGRNZWEyQlg3bXZlRlZZS1pmOWdoWDlBeUgzSk53?=
 =?utf-8?B?cFl2RjNOYW5YcWQzRG84U0JPMnZ1Z0gyZ2o1NEdnNjJWbUttTmpEWFhWYms5?=
 =?utf-8?B?WFlNU2tOL1Y3VkY5Mm9TaThqM1lGS0VjUmEwTHYwS25PL0xpWFA0eUdLT2dw?=
 =?utf-8?B?WkVrOGVpSS9HRjRMaFBQZmdCWmNreG1sWEUwU3oyN3J3REZGTUw3Y1JVSGsy?=
 =?utf-8?B?b3gxK09Ld0llV3A5ZzJMNGRUUmpsZVAyRUVFRTV6eFRWN0JmakVZbUdRYjk5?=
 =?utf-8?B?LzVnc21PNFYydkhHOTBCNGFHYWpVVkREY3JrOElBYkxTZExSQS9DT05Eclh0?=
 =?utf-8?B?b3BSWXJ5OGYybU5TdDVEOHZTT2FjUXZsWFpGRUo4NUU1dmh4WDNuQT09?=
X-Exchange-RoutingPolicyChecked:
	lYZu0RccQ1OI4/gsyau1ae+G/N9tuvF99OXrF8F1OayL2G86idMcpufBpEziLPSFXL7oyi6tKq0KhTx46qWvDadctqLOsrxFdTkZpgkYg3bSndV8EK/1lFcI8aeJf8/gyKy6bu/zg+Fgpg9ifXVI5Y7vI+ln1Tmk07/TsCG6fipZkZjNcSSaIjdjNf6MvHy/8OvddhqUbeYcoNcu5Hes/3YftHNpSOLO1py2FfCFYiZN42vdzTVEcTRt73EAIIoOh69wqRfKcgcPNGwX/tYyUvWTwgz9HFwC6bKI/nP8aPk2fqFqQxG70ofJJuSYCpPq9ISevcvGc/G4wJeH1efCiQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aytC5iqi+1rtwCgkg6HjsWfukQC0b2Z+7R3PYnlnKFzmF109mMG2IV8yng/HWl+7AP8Ho9owJqTo4E1YfNv9SDF+Rz22UA8RteXWQ3M8Dnasb4FoPh82kmECjfnzkLx0ZgiPWLek7dbGwcLfuWWHBh4szsA+tNES66mZCLe9Azhu8RhDXkbLobQYPdh/Jb2CCBLdEwSX6uHg9cw8lCDh44/ZRKlUUK89cl0QzZA6Ndwy1nbHCf3b5U0n1RZlG5iK4wWFlQS9RyXTjyFvk3uu2TwrEYAw2C1ROazXWGtAhImNLpjL8PoNnXULfzdyOTikDlKodZQnarkWhwkPNyQucCZqyaW2drg2n9DVdnh/OlkB7nq88sYJlDuNklKfLjQXaAzDntn11Wf4YA/xD+br41IQYjd3LmV4kI9G7LTn6vZyjXWcRlMkq/WkUOpZ6iF1tgTwhfORqJlXS+rD7Hh3EwS5pqQMfkv1DNkA0OnTRiCww0VgkL9Y8j5rH7PVqWqdkp5mz5n0NWE/7sqCqf9WabqKc/4LRbKI88x+FAzWtj30S9XBk7JRj+TEJpvL1yzA9u+DdtRdSivNWx3E9RiBaUB3i4IdbUTzOdgeT/m7Jlg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c2bd99-ab33-4a18-e231-08de8e36c66e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:31:44.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TXgFVXKcY7bDtivv61T1rTIfdIk+vGgDtOcVvwwLphxxy2Xzqas1pdTy9IMOEk2OkDUnQKgohLdjDffbyQ78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603300066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2NiBTYWx0ZWRfX8MhQ+g7vptTk
 xu9Rj+1NlmDBB3WOlIbUQ1Cs5Q/QlMpQ/srAb4mKGmrLn80rq3UnOCn9/S4HC6epy4VHG2axuKC
 5+LT0Hc8nYMTqvK/8rZjZPK9+ykX48/QL0gQFycMhC3l3XrL91p/JRYX9/NxaLvgrGRDIyE4bhH
 SfW+RehaA6BrtQ2LpvNr6erWeEFdLgFmfqwNOM+4lpshDR3gH7wPCTE38hu8sR6MG6O22dG5KaT
 5u2LWW7OAGg6IKU8aQxPeQAnO4TejE/11z0S2VxQBVVjip/DjmFQo4TRQDNaEzqbWuu7kTbUDu2
 gE0m7pfIZ57rDVwpfrOw8Yv5Jd7yzBWoJjWbNlKRuWCigvShr+QQu0UV9gARNE/C4+dywgOvXAv
 x2mLwE1vOFkG7daaqnYKNmdFl1fu+rAZEkmmvoIs6HvsleGHOaZ5xM8Lrmv4KDsnuAiJPJdIgSE
 pF/niPqMkas5ctNfSaQ==
X-Proofpoint-ORIG-GUID: kcWbAuU0lwkvYHfOys106Kdn7lLGZSw_
X-Authority-Analysis: v=2.4 cv=BvOQAIX5 c=1 sm=1 tr=0 ts=69ca34f4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=NEAV23lmAAAA:8
 a=_s1Dj3tck1VQEgHFaeUA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: kcWbAuU0lwkvYHfOys106Kdn7lLGZSw_

On 26/03/2026 01:31, Yonghong Song wrote:
> Currently every function is checked for its parameters to identify whether
> the signature changed or not. If signature indeed changed, pahole may do
> some adjustment for parameters for true signatures.
> 
> In clang, any function with the following attribute
>       DW_AT_calling_convention        (DW_CC_nocall)
> indicates this function having signature changed.
> pahole can take advantage of this to avoid parameter checking if
> DW_AT_calling_convention is not DW_CC_nocall.
> 
> But more importantly, DW_CC_nocall can identify signature-changed functions
> and parameters can be checked one-after-another to create the true
> signatures. Otherwise, it takes more effort to identify whether a
> function has signature changed or not. For example, for funciton
>   __bpf_kfunc static void bbr_main(struct sock *sk, u32 ack, int flag,
>      const struct rate_sample *rs) { ... }
> and bbr_main() is a callback function in
>   .cong_control   = bbr_main
> in 'struct tcp_congestion_ops tcp_bbr_cong_ops'.
> In the above bbr_main(...), parameter 'ack' and 'flag' are not used.
> The following are some details:
> 
> 0x0a713b8d:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x28) loclist = 0x0166d452:
>                      [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg5 RDI
>                      ...
>                   DW_AT_name    ("sk")
>                   DW_AT_type    (0x0a6f5b2b "sock *")
>                   ...
> 
> 0x0a713b98:     DW_TAG_formal_parameter
>                   DW_AT_name    ("ack")
>                   DW_AT_type    (0x0a6f58fd "u32")
>                   ...
> 
> 0x0a713ba2:     DW_TAG_formal_parameter
>                   DW_AT_name    ("flag")
>                   DW_AT_type    (0x0a6f57d1 "int")
>                   ...
> 
> 0x0a713bac:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x29) loclist = 0x0166d4a8:
>                      [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg2 RCX
>                      ...
>                   DW_AT_name    ("rs")
>                   DW_AT_type    (0x0a710da5 "const rate_sample *")
> 
> Some analysis for the above dwarf can conclude that the 'ark' and 'flag'
> may be related to RSI and RDX, considering the last one is RCX. Basically this
> requires all parameters are available to collectively decide whether the
> true signature can be found or not. In such case, DW_CC_nocall can make things
> easier as parameter can be checked one after another.
> 
> For a clang built bpf-next kernel with x86_64, in non-LTO setup,
> the number of kernel functions is 69103 and the number of signature changed
> functions is 875, based on
>       DW_AT_calling_convention        (DW_CC_nocall)
> indication.
> 
> Among 875 signature changed functions, after this patch, 343 functions
> can have proper true signatures, mostly due to simple dead argument
> elimination. The number of remaining functions, which cannot get the
> true signature, is 532 due to dead or additional-checked parameters.
> 
> They will be addressed in the subsequent commits.
> 
> In llvm23, I implemented [1] which added DW_CC_nocall for ArgumentPromotion pass.
> This compiler pass can add additional DW_CC_nocall cases for the following
> compilation:
>       - Flag -O3 or FullLTO
> So once llvm23 available, we may have more DW_CC_nocall cases, hence more
> potential true signatures if the kernel is built with -O3 or
> with FullLTO (CONFIG_LTO_CLANG_FULL).
> 
>   [1] https://github.com/llvm/llvm-project/pull/178973
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 82 +++++++++++++++++++++++++++++++++++++++++---------
>  dwarves.h      |  1 +
>  2 files changed, 69 insertions(+), 14 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 16fb7be..c569002 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1190,6 +1190,10 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>  	return ret;
>  }
>  
> +struct func_info {
> +	bool signature_changed;
> +};
> +
>  /* For DW_AT_location 'attr':
>   * - if first location is DW_OP_regXX with expected number, return the register;
>   *   otherwise save the register for later return
> @@ -1252,7 +1256,8 @@ out:
>  }
>  
>  static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> -					struct conf_load *conf, int param_idx)
> +					struct conf_load *conf, int param_idx,
> +					struct func_info *info)
>  {
>  	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>  
> @@ -1263,8 +1268,15 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
>  		parm->idx = param_idx;
> -		if (param_idx >= cu->nr_register_params || param_idx < 0)
> +		if (param_idx < 0)
> +			return parm;
> +		if (!info->signature_changed) {
> +			if (cu->producer_clang || param_idx >= cu->nr_register_params)
> +				return parm;
> +		} else if (param_idx >= cu->nr_register_params) {
>  			return parm;
> +		}
> +

logic here is confusing. why not just retain


		if (param_idx >= cu->nr_register_params || param_idx < 0)
			return parm;

and add
		if (cu->producer_clang && !info->signature_changed)
			return parm;


but given that info can be NULL, isn't it safer to have

		if (cu->producer_clang && info && !info->signature_changed)
			return parm;

Technically we could drop the cu->producer_clang clause since info->signature changed
will only be true for clang functions with DW_CC_nocall.


>  		/* Parameters which use DW_AT_abstract_origin to point at
>  		 * the original parameter definition (with no name in the DIE)
>  		 * are the result of later DWARF generation during compilation
> @@ -1337,7 +1349,7 @@ static int formal_parameter_pack__load_params(struct formal_parameter_pack *pack
>  			continue;
>  		}
>  
> -		struct parameter *param = parameter__new(die, cu, conf, -1);
> +		struct parameter *param = parameter__new(die, cu, conf, -1, NULL);
>  
>  		if (param == NULL)
>  			return -1;
> @@ -1502,6 +1514,29 @@ static struct ftype *ftype__new(Dwarf_Die *die, struct cu *cu)
>  	return ftype;
>  }
>  
> +static bool function__signature_changed(struct function *func, Dwarf_Die *die)
> +{


given that AFAIK DW_CC_nocall is only used in clang currently, why not short-circuit
the logic here and return false if (cu->producer_clang) ? Logical place to do this
would be in die__create_new_function().

> +	/* The inlined DW_TAG_subprogram typically has the original source type for
> +	 * abstract origin of a concrete function with address range, inlined subroutine,
> +	 * or call site.
> +	 */
> +	if (func->inlined)
> +		return false;
> +
> +	if (!func->abstract_origin)
> +		return attr_numeric(die, DW_AT_calling_convention) == DW_CC_nocall;
> +
> +	Dwarf_Attribute attr;
> +	if (dwarf_attr(die, DW_AT_abstract_origin, &attr)) {
> +		Dwarf_Die origin;
> +		if (dwarf_formref_die(&attr, &origin))
> +			return attr_numeric(&origin, DW_AT_calling_convention) == DW_CC_nocall;
> +	}
> +
> +	/* This should not happen */
> +	return false;
> +}
> +
>  static struct function *function__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  {
>  	struct function *func = tag__alloc(cu, sizeof(*func));
> @@ -1800,9 +1835,9 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
>  					     struct ftype *ftype,
>  					     struct lexblock *lexblock,
>  					     struct cu *cu, struct conf_load *conf,
> -					     int param_idx)
> +					     int param_idx, struct func_info *info)
>  {
> -	struct parameter *parm = parameter__new(die, cu, conf, param_idx);
> +	struct parameter *parm = parameter__new(die, cu, conf, param_idx, info);
>  
>  	if (parm == NULL)
>  		return NULL;
> @@ -1889,7 +1924,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
>  			tag__print_not_supported(die);
>  			continue;
>  		case DW_TAG_formal_parameter:
> -			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
> +			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1, NULL);
>  			break;
>  		case DW_TAG_unspecified_parameters:
>  			ftype->unspec_parms = 1;
> @@ -2118,7 +2153,8 @@ out_enomem:
>  }
>  
>  static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
> -				  struct lexblock *lexblock, struct cu *cu, struct conf_load *conf);
> +				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf,
> +				 struct func_info *info);
>  
>  static int die__create_new_lexblock(Dwarf_Die *die,
>  				    struct cu *cu, struct lexblock *father, struct conf_load *conf)
> @@ -2126,7 +2162,7 @@ static int die__create_new_lexblock(Dwarf_Die *die,
>  	struct lexblock *lexblock = lexblock__new(die, cu);
>  
>  	if (lexblock != NULL) {
> -		if (die__process_function(die, NULL, lexblock, cu, conf) != 0)
> +		if (die__process_function(die, NULL, lexblock, cu, conf, NULL) != 0)
>  			goto out_delete;
>  	}
>  	if (father != NULL)
> @@ -2246,7 +2282,8 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
>  }
>  
>  static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
> -				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
> +				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf,
> +				 struct func_info *info)
>  {
>  	int param_idx = 0;
>  	Dwarf_Die child;
> @@ -2320,7 +2357,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  			continue;
>  		}
>  		case DW_TAG_formal_parameter:
> -			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
> +			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++, info);
>  			break;
>  		case DW_TAG_variable:
>  			tag = die__create_new_variable(die, cu, conf, 0);
> @@ -2391,11 +2428,15 @@ out_enomem:
>  static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  {
>  	struct function *function = function__new(die, cu, conf);
> +	struct func_info info = {};
> +
> +	if (function != NULL) {
> +		info.signature_changed = function__signature_changed(function, die);
>

i'd suggest adding a coment and a predicate here, something like

	/* For clang, we determine if function signature changes via DW_AT_calling_convention
	 * set to DW_CC_nocall.
	 */
	if (cu->producer_clang)
		info.signature_changed = function__signature_changed(function, die);
  
> -	if (function != NULL &&
> -	    die__process_function(die, &function->proto, &function->lexblock, cu, conf) != 0) {
> -		function__delete(function, cu);
> -		function = NULL;
> +		if (die__process_function(die, &function->proto, &function->lexblock, cu, conf, &info) != 0) {
> +			function__delete(function, cu);
> +			function = NULL;
> +		}
>  	}
>  
>  	return function ? &function->proto.tag : NULL;
> @@ -3045,6 +3086,17 @@ static unsigned long long dwarf_tag__orig_id(const struct tag *tag,
>  	return cu->extra_dbg_info ? dtag->id : 0;
>  }
>  
> +static bool attr_producer_clang(Dwarf_Die *die)
> +{
> +	const char *producer;
> +
> +	producer = attr_string(die, DW_AT_producer, NULL);
> +	if (!producer)
> +		return false;
> +
> +	return !!strstr(producer, "clang");
> +}
> +
>  struct debug_fmt_ops dwarf__ops;
>  
>  static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> @@ -3082,6 +3134,7 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  	}
>  
>  	cu->language = attr_numeric(die, DW_AT_language);
> +	cu->producer_clang = attr_producer_clang(die);
>  
>  	if (conf->early_cu_filter)
>  		cu = conf->early_cu_filter(cu);
> @@ -3841,6 +3894,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>  			cu->priv = dcu;
>  			cu->dfops = &dwarf__ops;
>  			cu->language = attr_numeric(cu_die, DW_AT_language);
> +			cu->producer_clang = attr_producer_clang(cu_die);
>  			cus__add(cus, cu);
>  		}
>  
> diff --git a/dwarves.h b/dwarves.h
> index d7c6474..4cabab0 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -302,6 +302,7 @@ struct cu {
>  	uint8_t		 has_addr_info:1;
>  	uint8_t		 uses_global_strings:1;
>  	uint8_t		 little_endian:1;
> +	uint8_t		 producer_clang:1;
>  	uint8_t		 nr_register_params;
>  	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
>  	int		 functions_saved;

