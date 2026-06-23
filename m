Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83080218592;
	Tue, 23 Jun 2026 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220308; cv=fail; b=UFE4Sudn3lDB68iMINB+MfJotCzadySNyecEYuhH+hPxmWpBV0eJbwZO3MkKvkLTdxJ5Dj3omtOtDmdRMxpEQ9SX//9Llp3GrQgnryvkNBCIEqTD5PNdByHXygImHZXtn9NUSfunsSyueLUz3DYgnAWPPbh2ZZ4f/4W+k16tNBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220308; c=relaxed/simple;
	bh=F0uO2tPkNqpEUZhwL3L6IYrAXGiAoO+TtRRcL87Ewms=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=GYagkrrEqr8hPC+whg4NbHrLAk1VLQ6pMET3di8nJ7w31SMHQZM346MoT16av9jCWcj6KRTSgAa3zpCXQdBoqiHVmsWTiWbL1URj1BsKre6k4dR02ifI2WnYf8ral8dVxkngS/2ZtVryBkuAjgK1XJVPrs18SnLSKHkk67ObAMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vn0iU6ou; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AyXMSWi1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vn0iU6ou";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AyXMSWi1"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NCN1dB4063586;
	Tue, 23 Jun 2026 13:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vTXvP45BXW8C+UkF5O
	GzR3W4wQp1XK1tiW61NECAdxg=; b=Vn0iU6ouE8SQFN5v6Knll6CPNqDY86YB1I
	EedL2O0CdzPDxYibvZLZzpPlDb6wGNXUJZw9vyCd+eCsyWqTokOSRyguqFT0q62h
	CpjFrHikABF8nsP73bdXLrFTjmpZdFBJmOsic2+RZK3CFyzU0c28v3wDePSvFl+d
	PBhGNszgcqctZifxnO6LXTH5iE7/UNlpEhr9hFt5GIpytUgtF0wNbMwvzzCNafwC
	HU+VfNGr7WQegDX6UhHm0++4yB/Bv+cQkPmoGeuns1l8JgcurGxnlSeuPH3pjpW2
	58fWT04kN8+GbUcwK56Xqf23BAP+Bx0F+STNQiSCwyBDRSQa4Pow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjfubjry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 13:11:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65ND8ego021349;
	Tue, 23 Jun 2026 13:11:39 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhaq2mh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 13:11:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIA7UuMa6uKA7sKjUrl4FKjIWX2WqeD4fOjo9pH/3sROH78TcFpfRCGdgVOjf+Tuy/pvA2CINnw4aZZ9RlZXQsIdkOAfKTbobcAOVJytmCyTkdyKbJ6omPnBuL6VubyimOGO8yil0LfQd8hTo8Vx63ODQ69ZuL40p8NnSE9Yy8r/7frGfDA+jkqrZdHZEYRvlfp0KEh2u2JSG96NADRA186F5XrmnyG/RcYHgGxVPh6KWGqkL9umx1xpbUIlNYuobhf0gUFsvW/2KVLrTRZLBAi/BBkFNP37u05f/gpwveW2O19+KkN1HJOYl/94bcioxmC/msrpQDmheoPlvpnNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTXvP45BXW8C+UkF5OGzR3W4wQp1XK1tiW61NECAdxg=;
 b=VJet1RH1vpaAdw8uVC6ifyj+2Jx4R/FLLxA3IKlXANX4WRl5c3Bpy4KeNp+M3h7xXJp+ftHVokO105df2dx2KW1qf9ef337OxV5/Y8IiYfTnW0Ww0OtvIRL+lzCnKfYGH/tMM7HQjsOoFfrLrEYjuhh45R82I5SUVcDOnJAM2mSeUhRReLAbvd5DxbMSwTjiYCKVELcBXJmc+D0HWcFD5htM3+RItmcojSznU0XB7Dm1dNlpUj6PErM0MQWm7eKc6Uc5mMdPgQrIrFT1A+Lb9v2A0jdPOXr/Yo9PDLTvx85Cg0BwvtXscsv0TjkqFG3hIcAtvgOY1dhBAM+DT9Mk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTXvP45BXW8C+UkF5OGzR3W4wQp1XK1tiW61NECAdxg=;
 b=AyXMSWi1zzIMmgxGiEiGcKPJQb8GSAYMy2yJtsV1ksHy8e+kQGCDc7IaYbZ5M+ukddnGFYHUDQ2onW9sobbHE57BmI+rhKRkECnewIdgCLzR/47yrAbVsFJ+tXO9Cn7FV++yOEdKBlMTuh7M4D9rrLDHFSodlY+gMuwbkoxho6s=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by BN0PR10MB5173.namprd10.prod.outlook.com (2603:10b6:408:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 13:11:35 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 13:11:35 +0000
Content-Type: multipart/mixed; boundary="------------OVh3Ckh0a5sG60cdyJgLcZDu"
Message-ID: <d270a215-264f-4c5c-9d7f-0b1568815e31@oracle.com>
Date: Tue, 23 Jun 2026 14:11:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v7 0/5] pahole: Encode true signatures in kernel
 BTF
To: Jiri Olsa <olsajiri@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20260623040704.2732530-1-yonghong.song@linux.dev>
 <ajp70MRjHvCJNeyv@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ajp70MRjHvCJNeyv@krava>
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|BN0PR10MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a7fc24-513a-48d9-b737-08ded128f3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|6049299003|1800799024|376014|366016|4143699003|4053099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UUQBvvLA5DtwYzOZe6jvs6WAh73xvGTYlk/7iXCUe8Hhghn2rSzAMpieUAdURPXGFJ1TiKBp8zExDcRYgnJO0ASRHgUcVgF8HQPTEU8OuKkf63FeJDrlYVUtbjzVx5f3VOFSOw+AazSzR+j/Kt4N+2AYfpn9otH9Id+KeZViOTsHrd9mi0lYBA094sQYQb/Xm4FQVj5Soyha0mWPVDM3+FVchduPbeYUutbH8tEqghDAmRco3BncFPWEBCO05d9NryEtrM6QhE5PT+DchTxQtu+/rvmBoFIQ9yMwMK6nKBfoCYhY3y81zE+VeSrndF8YeOToNMBO0TfxmBxJFNJAlC0+WEDIf/7bdC5W1GoHoLCncGuSC+DgubZK4UPeygZhLsRRp3uSLLfFWYO279WMX8xyvmhhyIPcd5E7A0KSYlPBlM+OK1dWXMT9W44sw49h77npxDMJy0y3p9jEHceDmTkfKKBUIOu0bjkN7TdziC7W/or7wFci9Ts2ScwRla0+iCrAAkYRWK4itPE/ua5oqa0p2sXWjRXkvpeLNV/2aYmdku/qKc8yRUiX+hn+oot+GGQYy6DYzY9RS8dv02BPFfgkH5dRquoB64mcDMJyyO3ni4ZUtBYFYCORdLjji7nvXa/8XiUxKwhYl9EPpMLpcVwQXU27l/NOjTCNN4wioJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(6049299003)(1800799024)(376014)(366016)(4143699003)(4053099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHE0UytPb1JsK0lCOHFqcUh6RUZ5dXM1VlZWMEdkODYwK1N0UHlMR0hZSk00?=
 =?utf-8?B?QTZrdFltRFc3QWNDZGdHN1hDWnMwWDdIaUpyaXpUSk5uTFA0RXM3eFR2d2V1?=
 =?utf-8?B?cHhyL1N5SXZ6MkgrUGpaQWRnZDVhVlJwMWZFYUxMVldsNFNaNzFtN2hsak9k?=
 =?utf-8?B?YWY2OXBEN3BiT3p5U0xQbUxxWG9tVGJrdDlDenZjSGVaY0xvLzFyNDc1Rkc3?=
 =?utf-8?B?bk5MMUFScWZmMERyeEpDOW15a08vUHcwSmx4dlVSSGNGaUNZOE05UExMQlpl?=
 =?utf-8?B?dTBmTkFkdzBKeHhDNzMyMElndFlqTjVRbXptSlZwbGNEOGJEUTVRdmFJYkRi?=
 =?utf-8?B?VEs0UkxmQ3owV0lkSmZBb20vODdQZGN2RnBnM2lBYU11bUxMQkpXZXlQSDFH?=
 =?utf-8?B?VFQwcU5Eb3RETVEwTkZKVzFVZEQxWVJndjVoTXpBR2JiZWMrZlJtczl1SmY3?=
 =?utf-8?B?OFhMQ3YxWWhsUDRGc2RIZncyQm5JNnVFSHhuNk9LcjY5U2xOSkkwZ1pHREdJ?=
 =?utf-8?B?YnpGY2c2TlNheWxqWTZ4QVE3dmJ2SFQ2TjJkR0htT1gzcVRydWwxT0JzblZD?=
 =?utf-8?B?SlVyNUJrOERodFpzSllhSWNPSURkYmN2SW51TU5xMDFvUjlicWVQTWIzQ0t6?=
 =?utf-8?B?MWJNUlhnaDRJREhDWXBJeVJLQkkveEZhcndoNndFNHZJdGozbUp5bDFwSjA3?=
 =?utf-8?B?VjRkVHRaOElOdllWMEJ2dk5GcGJySHd2OUxDOE9ZdndoVTEyeWUxbWcvZ25J?=
 =?utf-8?B?ZTkwVnRMTnROYnd2OG55VWJUbUYyblNQKzdad0dEbkxvMERIcVUrUWtlWG4w?=
 =?utf-8?B?c2dyNlRtZ1Z4eTNhWjFjTEZKRktCVlpzak9LVW9DUDl0SEtUL1lURExPeFcz?=
 =?utf-8?B?SUwzQ25zSytPc3NIbG9lVGZkM2xLaDloZ2plQWlzTm1OMjFlbldMd3hPeGZN?=
 =?utf-8?B?c29TYkthclpMeG5ZTVQ4MXhyQkxkcEEvVHZaNVZnN1FYMGdvVUowdUR3eVRr?=
 =?utf-8?B?UWgxb1BVV1pvU0FVeVp2RFZYMHhRK1hUc3VRaFBLN1FWajVSU0REMHBoejhy?=
 =?utf-8?B?T1BJRTNLVUxDV0dzMWh5NHlCZkhid3AvRVhqR3N5Qm1oUTdnV1lVU3h0UVB6?=
 =?utf-8?B?OEhnOXVkNXRDVnpmZ3VlM1I5YW5sUUlpakd5N1hSU2lGalJGRVI2UHIzQ1Jv?=
 =?utf-8?B?NS9EVXRXVnZxV1lqMFRnUUlhS1d0NytTQkE5NEoySnNFQ1duOU5LcXBTelNM?=
 =?utf-8?B?ZWZkaFhYUGJ3Y0hFTWlUS1VBMzRrYjdBL0g2TDkzcTRFWFRYNzNvRTNneXI3?=
 =?utf-8?B?OHFTSFVQbWcyWUpmNzRDOGx2dVgxK1hIYTd4RXNGL01ITi95V0FnYXFLNURR?=
 =?utf-8?B?THRaSzZSc3doVHNVeEJlK2xET29sZ0lTTnRQUVRXRzkyZHBRK0hycS9GQm1N?=
 =?utf-8?B?azFKYi9qaG9zL0dXdGE1STZ2YkxBUzhBSEJtTmZ3ZytNdGVUZVpVWVgvZlRF?=
 =?utf-8?B?VE8xYlV2ZGFCWm9ZbTJDaXZuMFJXM2w3SlFMb0pFejhHMnlETm5heElIOEVC?=
 =?utf-8?B?LzdEVC9UaTRKTXlvaldsNEtVTFZVRVFBRzFjd3Jja3dqdVgraGcwSU9waUU1?=
 =?utf-8?B?YXEzNit2TUZESi9uQmVWYitBc0JJdWxhcklpZUJybmhiMG5mRGlvdnJFRi9v?=
 =?utf-8?B?aC9SZmpnZE5aWUh6S3Z1cm5Mclp3MjgwZjRHcVF6TGY3emVsK3VuV1NnL0Ft?=
 =?utf-8?B?REtZcHdZVWdDaHNZVHo1UUxEeDY1dzhic2Q2a1h4aDRqd2tlREtXbzRPWVdr?=
 =?utf-8?B?L01RRUpYdlQweE5qRnpKeDltQ1BLdnlqbW94RGRuamN3VkhTVExYZzRvZ29I?=
 =?utf-8?B?UzkwcXF0aGpXbUFtUVRGT25vUVM2RE5xZnQ5UEN6SFdLNHMwRUNsT0t1Vnly?=
 =?utf-8?B?a1h0Z3F0SWxyeURpc3d2Y0h3dC9MSnordVFkVml4dC9qZUxoYmdnL2dHWUNx?=
 =?utf-8?B?L1c0R1prOGI2V3pIRkhnUUIxSFo5SGNJVVVJODNxRE9ENnhQLzJHb1BrZjFw?=
 =?utf-8?B?QUVVSGVHMkpTUStyZGcvZCs1R2dCbGlKeFNIblUyTGgrNHRUeWpDTEN0Z3VC?=
 =?utf-8?B?OWFsUEVrcjNNWExCc3A4NUtpVnNuK1VSY05yNDhqbzU5RnVTT0lPanR6SFVr?=
 =?utf-8?B?ZVVLU2lXYXVoODJaWkE4VHQyMGE1QXBLMWZGb2NxNUZFNFlVWVlYNnlGTnJO?=
 =?utf-8?B?Q3RVbGFSeDE4YkpVNHRSRHh3TXdjY281TmJZbHBSODN2OTNVTzJ0Y2haVFJp?=
 =?utf-8?B?UzJQVmtBTE1kQXhFaVdjaUgxVVRVN2U3ckNlVmVlY1ZzK1VFQzM3Zz09?=
X-Exchange-RoutingPolicyChecked:
	G/HaOB6sPhKwg3rsNN9GU1pi1kXiXTrsh2Q9k4h0pNByqRJ2a6hwIc3JjJ69sCnRmbcpgVr3b/YlusbAReJyJBDUP9WCzKIq27VaAIg95UBBeDQxRgnQS1hJGJ5nIEFu7STQo9PeqATCoTWhjkxGNFd/Uq3HFh2U7iQGzPv3ntp9idviegC0XfUxTatYywcRw5VBId9ueB9Bi58IBWWpeM5MhLWxOG9BUf1Y/gwu02Tf6cHshmTAkObG22COYqCELSX19OBsI8syXHt7fnG2t3xgXHgeowKxmg8twz7yg0+IFVHzYSE2ovgHtjUsFbMYJ3CYzRKWP8IffVKGCVzQ8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ykSshIf0rw6lN1uZx2E7DOY2yd2mpeOcBXk7g1iqA3aqiMFHurxZNvh9ytLcxioDOCyf8SOp8/9cyTzZLNt2G6F1WIvXxz7YDNVEcWQUIZlPAkCqrNHKzv29CDs8eFol/mC8bWpPWrq538gZKnW+geHIaUsssMoJZ7TAr8lw9dlAMzKWZw0EKpebcqfnL63yfK1+IsOAJxjaKWjSWrA4njN4o2V/GCFFfg+L1UY61grjc2LmkAi6jSO4vgk+ZABculGWz4UXOpctFksFpL5c8m9f+PRj1U/4VSJek72rX+YGjDacJcluxjZGt8mWrxkGgQVRwCAMoRfh12BQ7mo0zLxUlfNhUMDr9vTxLaOwORzJH/49nSIJudG6pBgQPUDbU5l3qteFwqQNWGZbnZ3DADff53IybiiyRE3SKQr75NxmYkj/m9ezfwM8TPNTfnQwQ1AI5ykVUuUl/nC6vVsL+ql6bXm1ZiInNWqzHinj0rXxqHOrrBI99f3LGjr78YGUFm8KnjsOE4Kv0zd66mduHjcuL1zG6YatVYLOJ5TR3Wj6U/iO472olnBJjRC8PeXxXoO73mVQ5JvhOvBipx+4isgQw5aV29zeqRPYuhy5ofE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a7fc24-513a-48d9-b737-08ded128f3f8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:11:35.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs3kC46BJatWHwWduEEVacLcLycON6bEJFaiUZkpGigZQg6y7+7/4HxmJ9HEeTRR5QSAsce+l33/sAzcqU7nDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606230108
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwOCBTYWx0ZWRfX7mum/UOwpnhF
 QzYHHMKGgpaYZTe93/BGCRlOPVqe4ykHNKT0N6gq2ALSOCbeTy4iX0hwdUpnkcx3L0v3Bc7PsLf
 63kA5L9XuYSR3DezyEmjdw0fOb/Bg+fwhP4Vj7OHZnjCAQ37dFKu
X-Authority-Analysis: v=2.4 cv=FtI1OWrq c=1 sm=1 tr=0 ts=6a3a860c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=1nhcN2I-1-s4D8lFauUA:9 a=QEXdDO2ut3YA:10
 a=d00XqsTxfAMNyxTZ1QQA:9 a=B2y7HmGcmWMA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-ORIG-GUID: wj751GsOQPBBW1uN13XM6Xvz3YtPoWGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwOCBTYWx0ZWRfX/kq12V48GKK6
 mSfIClRQltGoKG9Do+L0r/Vz4PHBVxnCls+T8t8uW+69GQkyZisDW4pmi7C7kigT6a67FZIT0on
 wowVFsOPfqQA4sWxjApxPmHn+fPdLNpXAdiVUsb7wmcCR4IZlPBP4nT4KMvObC9qk2ICi2a70qV
 d6qOBv2k4Ca/tvFm7PCXuNtQlcsXmSdZdKV7eWkUqh5VCRM85p9tviNuTt0VmIaXl7e2y+KeAjY
 eNd3VDpwAUzP2p7ZkQveHKkNs5debyv27e35ztetyvusKPD1omqObemGRMm8rT1wAVqinr1+Bcq
 XTj6moHi6RBC4+53fUqYodoXZmFyhaB/f71UTueDPIaIKd52+A8IKthuMq75cGGQwTvSSO6Ozv3
 HvHjy4NtsuUKKNUuOrGdd81FkBbqe4M2xA3UlADNu6h4ajK72MjokauJCDsu/kCc+AskFxU3Dio
 9pM1pydl1NvplkpCFP/8ba/kwjrkhgE3S8kEWVQE=
X-Proofpoint-GUID: wj751GsOQPBBW1uN13XM6Xvz3YtPoWGa

--------------OVh3Ckh0a5sG60cdyJgLcZDu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/06/2026 13:28, Jiri Olsa wrote:
> On Mon, Jun 22, 2026 at 09:07:04PM -0700, Yonghong Song wrote:
>> Current vmlinux BTF encoding is based on the source level signatures.
>> But the compiler may do some optimization and changed the signature.
>> If the user tried with source level signature, their initial implementation
>> may have wrong results and then the user need to check what is the
>> problem and work around it, e.g. through kprobe since kprobe does not
>> need vmlinux BTF.
>>
>> Majority of changed signatures are due to dead argument elimination.
>> The following is a more complex one. The original source signature:
>>   typedef struct {
>>         union {
>>                 void            *kernel;
>>                 void __user     *user;
>>         };
>>         bool            is_kernel : 1;
>>   } sockptr_t;
>>   typedef sockptr_t bpfptr_t;
>>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>> After compiler optimization, the signature becomes:
>>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
>> This makes it easier for developers to understand what changed.
>>
>> The new signature needs to properly follow ABI specification based on
>> locations. Otherwise, that signature should be discarded. For example,
>>
>>     0x0242f1f7:   DW_TAG_subprogram
>>                     DW_AT_name      ("memblock_find_in_range")
>>                     DW_AT_calling_convention        (DW_CC_nocall)
>>                     DW_AT_type      (0x0242decc "phys_addr_t")
>>                     ...
>>     0x0242f22e:     DW_TAG_formal_parameter
>>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>>                       DW_AT_name    ("start")
>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>                       ...
>>     0x0242f239:     DW_TAG_formal_parameter
>>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>>                       DW_AT_name    ("end")
>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>                       ...
>>     0x0242f245:     DW_TAG_formal_parameter
>>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>>                       DW_AT_name    ("size")
>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>                       ...
>>     0x0242f250:     DW_TAG_formal_parameter
>>                       DW_AT_const_value     (4096)
>>                       DW_AT_name    ("align")
>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>                       ...
>>
>> The third argument should correspond to RDX for x86_64. But the location suggests that
>> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
>> the parameter value is stored in RDX or not. So we have to discard this funciton in
>> vmlinux BTF to avoid incorrect true signatures.
>>
>> For llvm, any function having
>>   DW_AT_calling_convention        (DW_CC_nocall)
>> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>> and 875 kernel functions having signature changed. A series of patches are intended
>> to ensure true signatures are properly represented. Eventually, only 20 functions
>> cannot have true signatures due to locations.
> 
> hi,
> I tried to get the numbers from my setup and noticed that some new
> functions were included in BTF compared to the current version
> (functions diff attached below)
> 
> like for "arp_process" function the current pahole gives me:
> 
>   arp_process : skipping BTF encoding of function due to unexpected register usage for parameter
> 
> but it's included in BTF generated with the new pahole.
> 
> in addition to your explanation above also one of the commit says:
> 
>      - a parameter with no location, a constant value, or (for non-clang) no
>        register found is marked optimized out
> 
> please check below, it seems like 2nd argument of arp_process has no location,
> so iiuc it should not be included in BTF, right?
> 
> thanks,
> jirka
> 
>

thanks for catching this; it looks like we return a bit early before detecting
missing locations in the non-true-signature code. If you get a chance, would you 
mind trying the attached patch to see if it fixes the problem?

If the fix works and Yonghong is happy with it we can add it as a followup
and land the true signature series to save another round.
--------------OVh3Ckh0a5sG60cdyJgLcZDu
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-dwarf_loader-Keep-clang-parameter-location-checks-wi.patch"
Content-Disposition: attachment;
 filename*0="0001-dwarf_loader-Keep-clang-parameter-location-checks-wi.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4M2Q0ZGJmZjJmODNkMzIyYzU1ZGVlZTBhNzFmMTU3ZTY4M2M5ZjE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGFuIE1hZ3VpcmUgPGFsYW4ubWFndWlyZUBvcmFjbGUuY29t
PgpEYXRlOiBUdWUsIDIzIEp1biAyMDI2IDE0OjA4OjIxICswMTAwClN1YmplY3Q6IFtQQVRDSCBk
d2FydmVzXSBkd2FyZl9sb2FkZXI6IEtlZXAgY2xhbmcgcGFyYW1ldGVyIGxvY2F0aW9uIGNoZWNr
cwogd2l0aG91dCB0cnVlX3NpZ25hdHVyZQoKVGhlIHRydWVfc2lnbmF0dXJlIHNlcmllcyBnYXRl
ZCBjbGFuZyBwYXJhbWV0ZXIgbG9jYXRpb24gYW5hbHlzaXMgb24KdHJ1ZV9zaWduYXR1cmUgYmVp
bmcgZW5hYmxlZCBmb3IgZnVuY3Rpb25zIHdob3NlIHNpZ25hdHVyZSBjaGFuZ2VkLiAgVGhhdAph
bHNvIGRpc2FibGVkIHRoZSBleGlzdGluZyBzYWZldHkgY2hlY2sgdGhhdCByZWplY3RzIGZ1bmN0
aW9ucyB3aG9zZSBEV0FSRgpzb3VyY2UgcHJvdG90eXBlIG5vIGxvbmdlciBtYXRjaGVzIHRoZSBB
QkkgcmVnaXN0ZXIgbGF5b3V0LgoKRm9yIGV4YW1wbGUsIGNsYW5nIGNhbiBlbWl0IGEgRFdfQ0Nf
bm9jYWxsIGZ1bmN0aW9uIGxpa2U6CgogICAgYXJwX3Byb2Nlc3MobmV0LCBzaywgc2tiKQoKd2hl
cmUgc2sgaGFzIG5vIGxvY2F0aW9uIGFuZCBza2IgaXMgYWN0dWFsbHkgcGFzc2VkIGluIFJTSSwg
dGhlIHNsb3QKdGhhdCB0aGUgc291cmNlIHByb3RvdHlwZSB3b3VsZCBhc3NpZ24gdG8gc2suICBX
aXRoIGxvY2F0aW9uIGFuYWx5c2lzCmRpc2FibGVkLCBub3JtYWwgQlRGIGVuY29kaW5nIGNvdWxk
IGVtaXQgdGhlIG1pc2xlYWRpbmcgc291cmNlIHNpZ25hdHVyZQp3aGVuIHRydWVfc2lnbmF0dXJl
IHdhcyBvZmYuCgpBbHdheXMgZGVjb2RlIGFuZCBhbmFseXplIHBhcmFtZXRlciBsb2NhdGlvbnMu
ICBLZWVwIHRoZSB0cnVlLXNpZ25hdHVyZQpyZXdyaXRlcyBnYXRlZCBvbiB0cnVlX3NpZ25hdHVy
ZSwgYnV0IHByZXNlcnZlIHRoZSBsZWdhY3kgdW5leHBlY3RlZC1yZWdpc3RlcgpkZXRlY3Rpb24g
aW4gdGhlIGRpc2FibGVkIHBhdGguICBBbHNvIGluaXRpYWxpemUgbG9jX3JlZyBiZWZvcmUgZWFy
bHkgcmV0dXJucwpzbyBtaXNzaW5nIGFuYWx5c2lzIGNhbm5vdCBiZSBjb25mdXNlZCB3aXRoIERX
X09QX3JlZzAvUkFYLgoKU2lnbmVkLW9mZi1ieTogQWxhbiBNYWd1aXJlIDxhbGFuLm1hZ3VpcmVA
b3JhY2xlLmNvbT4KLS0tCiBkd2FyZl9sb2FkZXIuYyB8IDE2ICstLS0tLS0tLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHdhcmZfbG9hZGVyLmMgYi9kd2FyZl9sb2FkZXIuYwppbmRleCA5ZDUxZmY3Li41NTg4ZWQ5
IDEwMDY0NAotLS0gYS9kd2FyZl9sb2FkZXIuYworKysgYi9kd2FyZl9sb2FkZXIuYwpAQCAtMTUy
MCwxNCArMTUyMCw2IEBAIHN0YXRpYyB2b2lkIHBhcmFtZXRlcl9fZGVjb2RlX2xvY2F0aW9uKER3
YXJmX0F0dHJpYnV0ZSAqYXR0ciwgc3RydWN0IGNvbmZfbG9hZCAqCiAJcGFyYW1ldGVyX19maW5p
c2hfcGllY2VfZGVjb2RlKHBhcm0sIGRpZSwgY29uZiwgY3UpOwogfQogCi1zdGF0aWMgYm9vbCBm
dHlwZV9fYW5hbHl6ZV9sb2NhdGlvbnMoY29uc3Qgc3RydWN0IGZ0eXBlICpmdHlwZSwgY29uc3Qg
c3RydWN0IGN1ICpjdSwKLQkJCQkgICAgIGNvbnN0IHN0cnVjdCBjb25mX2xvYWQgKmNvbmYpCi17
Ci0JYm9vbCB0cnVlX3NpZ19lbmFibGVkID0gY29uZi0+dHJ1ZV9zaWduYXR1cmUgJiYgZnR5cGUt
PnNpZ25hdHVyZV9jaGFuZ2VkOwotCi0JcmV0dXJuICFjdS0+cHJvZHVjZXJfY2xhbmcgfHwgdHJ1
ZV9zaWdfZW5hYmxlZDsKLX0KLQogc3RhdGljIHN0cnVjdCBwYXJhbWV0ZXIgKnBhcmFtZXRlcl9f
bmV3KER3YXJmX0RpZSAqZGllLCBzdHJ1Y3QgY3UgKmN1LCBzdHJ1Y3QgY29uZl9sb2FkICpjb25m
LAogCQkJCQlzdHJ1Y3QgZnR5cGUgKmZ0eXBlLCBpbnQgcGFyYW1faWR4KQogewpAQCAtMTUzOSwx
MyArMTUzMSwxMCBAQCBzdGF0aWMgc3RydWN0IHBhcmFtZXRlciAqcGFyYW1ldGVyX19uZXcoRHdh
cmZfRGllICpkaWUsIHN0cnVjdCBjdSAqY3UsIHN0cnVjdCBjbwogCQl0YWdfX2luaXQoJnBhcm0t
PnRhZywgY3UsIGRpZSk7CiAJCXBhcm0tPm5hbWUgPSBhdHRyX3N0cmluZyhkaWUsIERXX0FUX25h
bWUsIGNvbmYpOwogCQlwYXJtLT5pZHggPSBwYXJhbV9pZHg7CisJCXBhcm0tPmxvY19yZWcgPSBQ
QVJBTUVURVJfVU5LTk9XTl9SRUc7CiAJCWlmICghZnR5cGUpCiAJCQlyZXR1cm4gcGFybTsKIAot
CQlpZiAoIWZ0eXBlX19hbmFseXplX2xvY2F0aW9ucyhmdHlwZSwgY3UsIGNvbmYpKQotCQkJcmV0
dXJuIHBhcm07Ci0KLQkJcGFybS0+bG9jX3JlZyA9IFBBUkFNRVRFUl9VTktOT1dOX1JFRzsKIAkJ
cGFybS0+dHlwZV9ieXRlX3NpemUgPSBnZXRfdHlwZV9ieXRlX3NpemUoZGllLCBjdSk7CiAJCXBh
cm0tPnBhc3NlZF9pbl9tZW1vcnkgPSBwYXJtLT50eXBlX2J5dGVfc2l6ZSA+CiAJCQkoY3UtPmFn
Z191c2VfdHdvX3JlZ3MgPyAyICogY3UtPmFkZHJfc2l6ZSA6IGN1LT5hZGRyX3NpemUpOwpAQCAt
MzEyMiw5ICszMTExLDYgQEAgc3RhdGljIHZvaWQgZnVuY3Rpb25fX2FuYWx5emVfcGFyYW1ldGVy
X2xvY2F0aW9ucyhzdHJ1Y3QgZnVuY3Rpb24gKmZuLCBzdHJ1Y3QgY3UKIAlib29sIHRydWVfc2ln
X2VuYWJsZWQgPSBjb25mLT50cnVlX3NpZ25hdHVyZSAmJiBmdHlwZS0+c2lnbmF0dXJlX2NoYW5n
ZWQ7CiAJaW50IHJlZ19pZHggPSAwOwogCi0JaWYgKCFmdHlwZV9fYW5hbHl6ZV9sb2NhdGlvbnMo
ZnR5cGUsIGN1LCBjb25mKSkKLQkJcmV0dXJuOwotCiAJZnR5cGVfX2Zvcl9lYWNoX3BhcmFtZXRl
cihmdHlwZSwgcG9zKSB7CiAJCWJvb2wgY29uc3VtZXNfcmVnaXN0ZXIgPSB0cnVlOwogCQlib29s
IHJlZ3NfYXZhaWxhYmxlID0gcmVnX2lkeCA8IGN1LT5ucl9yZWdpc3Rlcl9wYXJhbXM7Ci0tIAoy
LjQzLjUKCg==

--------------OVh3Ckh0a5sG60cdyJgLcZDu--
