Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B51A3AA6
	for <dwarves@vger.kernel.org>; Tue, 24 Sep 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188818; cv=fail; b=Sbi0eWIQZJOBG+JpIZYRXNyCNb2nKaSMCSmDmrA+HC5P/kjm9KE6hU0h1Tz6CuKrzXKeQ3QlanBPNOSsrAjupXWGS9ntknRqVkbB8Qpcy4cIReQhHBb6+1I9nsDG98TJwCoKnBv7gsPVQHX6pj61SBuB8X7sAVUcGuTSCPEqrYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188818; c=relaxed/simple;
	bh=++mj0hk0334Igrbg7XWS1laZ9fhm6AESBUGDaE5cO9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ue5E/VDE7AK0UenqCRPq/o5sxRaRBPeMYHsNuTrbF3h3w44AFOPJdTgKCIyDidjRWjzi4dKmKOLz8lcXt2+HFSBaB+8bShjfzbYRsrBCSk5enUgTOLE11nCmBsHNqIYBWL9ElYVkqONL9lXayBXRV3R0ohEs4+nLBeaX2V02ql0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BUnJ0k5r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rm8yUGp/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BUnJ0k5r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rm8yUGp/"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQVm8032302;
	Tue, 24 Sep 2024 14:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=RFZ93yBZE+EgtESUU0ykEgUa9uA0LqJ68DdknDuW7qQ=; b=
	BUnJ0k5rZS/dddo/3e2vXFn++r5CovrrD13tPesIZniKqEK4KOXu5nqETItCNEz1
	XaH2yPOQZXvgmQ6a+sQXnjvoFy+imtcy0n8YzYIzBLmugfIBBXdW/Q5yR3tC1hgF
	73NnVrnsqGI0CcwfODACdsDGIwtA649+hee4FUBF8KUqr/Rid4elrt3iFeZ4KLl1
	VYyn2azh6ywd+O4ePV5mrthkKJvDP5xf5OSYrlQY1KfLoLGKlP0jU4WV3gHQ4Oh/
	PL4w9nlztm/CgrnTK6B1tj8Iepfpupi6xM3rJ4VL+TXwzDNuz2yj/Jvs8Q2+VppZ
	kTZAlu/T5zMBeUqsiLeJFg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppu7mkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 14:40:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OE7pLv005156;
	Tue, 24 Sep 2024 14:40:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9bfk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 14:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN5n7+Ei8jT/kE+m4NmrdWa/PrTYjS5XVtifCdSkiEP4mTpHOPhqoiHW8CNkU1s7UUT8lRCmBqOuCGcX0ucH10PdAVgfujlsYUtW4ou1KpvbKqyx90xrQO8kNpZdlySHSC8BMQy3RiBZwnIWonBfXhp6s7A23BccXMyCvdatRv3AGiBtpS0L0/JQS2JGPDtYIAAY0j04yfGKqr/gC0dCrKxjZsT1MKG9NpRK+h9qyIQMgZ4Vx0JUgkb/6QFEbZJFdGvxQlZBuZJX/w/QRUHn92MpalOqAlRx5XqZAE57mKW+g8hrAiYS/1AvGFBBz7GqC9TV8byaIugdydaUvYtGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFZ93yBZE+EgtESUU0ykEgUa9uA0LqJ68DdknDuW7qQ=;
 b=gUJwQ/0UakyYNHEdxcOIW+5Aturu4v1AgB59QrFrefwBYP5iLRO2SXjMWRv48Jvz06guBGXKLoz+cGW0orH3GST616jhg9vufhs1/8UUAEjSERbeTpsuUCGvro89n1BQ4hsXy+4RSFb59bOgj/j8fw3YxvVj0aCoI2maGGtppb7xo4Cv4JV/waq+Pk44Qy55DQScYsgvklECAFLN1lfEgnaIGyCzCBKV2rF0CWR5fhhY5vNDiID4tFnGYKFXoK5D0oCrRQdcDV8ErTvDmBeocxbD95LP9PXwnhmQGaUDqFTOM0NcmtpuVLWtwuUslNM72VZ1YEOViiYsRbpE2dNTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFZ93yBZE+EgtESUU0ykEgUa9uA0LqJ68DdknDuW7qQ=;
 b=Rm8yUGp/c7s9epC7YzDzLHzK/lGxo/P6AUtiRXppxXN2RIlnNn0NrOuibT7y3oyO0j9vVmC4PC8uuTOisw2AUQSAEV0t0UWl6puQ/ZR3OFQBXK83EhrKupVc/q9bflTsADqp6mxURmcohjqLtyee4j3dDfuR4YOUgxUOPSa5SmI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6879.namprd10.prod.outlook.com (2603:10b6:208:421::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.9; Tue, 24 Sep
 2024 14:40:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%6]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 14:40:06 +0000
Message-ID: <09440a31-5f04-4c66-bcfe-0a11c128dad3@oracle.com>
Date: Tue, 24 Sep 2024 15:40:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 1/3] btf_encoder: record BTF-centric function
 state instead of DWARF-centric
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, dwarves@vger.kernel.org, eddyz87@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
 <20240916134946.3893204-2-alan.maguire@oracle.com> <ZvF5AdxV-8chJXgp@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZvF5AdxV-8chJXgp@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0224.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: d3414e0a-0c25-4778-4323-08dcdca6c85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S21GRnlOdStZT2J5SWI3eVJjT1FSZXMzZWVzSEl2TUI1MEFrd0NWUGQya05m?=
 =?utf-8?B?MHczTlZIRGxud3VQeTNZaXM5YStkQmM1YlVCTUU1cGJ5NFV5N00xa2ZZNkhW?=
 =?utf-8?B?YmxwcFZZeitISTRWN1ozaG9aWkhYUldzSmE4dHdzVXorSDVvc3hYSEl6R0N6?=
 =?utf-8?B?YkZ3QUxDd1hZbDVQKzBIL2R5VGJRb1FlY1Z2ejVwYms3cTJVTE9Ma2lIM2F4?=
 =?utf-8?B?THlnemh4RDFUV1dmSDArWWNHTlY4OXh2T2VoV0FOWGNpTnp6Sm1Oc2I1NDlD?=
 =?utf-8?B?RHFBWjR5akd5aWdSeDhUU0RudllOVXNWcFU5VW1Wek04dW42WkxEa09mUmpP?=
 =?utf-8?B?WHpocW1CMzhCd0NPVVNJT015RnpoQ0xXK2N1WEpzQnpuVVNDYmRaU2RqdFMz?=
 =?utf-8?B?cjlWT0hKdkR6N2xJZEFPOXQ1MGVnOWNiRjhUcVhFNWYyRm8zTE41WlU1bGJF?=
 =?utf-8?B?bGdBOG5uWkZZcnFjd24xYWNYRE1Qd1ZCMDJid2hiY0twZlk0cVVMQUUwMDk2?=
 =?utf-8?B?K2t4OU9QVTdlR3JRR0NrK2Y5U0svVEFwak5hdWpOR3VGQkJZZnlFSUlIRENr?=
 =?utf-8?B?VnFLMHY2K0IyZTEvZzFsb1psRFUwcGY5c0oweDlPWGovaXF2dTFkQXFEbGxH?=
 =?utf-8?B?QnhyQW51RjlwNllFMFQ0ejNlNFd2S0dIQk16bjBXRXAwYThBaWZjYXNzZG54?=
 =?utf-8?B?TDFvOUwyQjFmQXJ2T3hxUWVFVzVNMWhHV1I2OXJIMUpzRjNtUU5vVEVBWTln?=
 =?utf-8?B?S2dSUGE2NGp3ZmI2TFo0UXQ0ZUZUbmcrRkwwQ1FaeGk1VGk1bW5CVmlNSURT?=
 =?utf-8?B?emhBY2F3dkV1bTFxUWNucEFUK2RYMEJTRlhhZEliUGdJdEVrRThpZU5YZXor?=
 =?utf-8?B?R2poQS9qL3JqeCt6V0dOUzdiRTJzM21MZnN2K09JUXZFRmxLRzlGU0RSWlJs?=
 =?utf-8?B?MHZqb2UxNlpsdkhFakR1U1E5WTBJa3gvUGJ5Y1dvZDRLS3QrNVp0MnZhVDBp?=
 =?utf-8?B?cDRCM0IwQmNHTlRhdUJmNGQrUDRvTzZtdlN1OWpHdHV5UHBpaXRHTDRNeXMv?=
 =?utf-8?B?cmxBOGtEUWVFMlVaZ3VPODBnQ01aRm41OHhOQXFZYkZ1WERjWmtZYlQ1M2Fy?=
 =?utf-8?B?UnY1Nk9LMXpaaU1UZ1VwTUZndTBsR2xINUdhazdKTmpBdjd5UXpJOU5wbTNt?=
 =?utf-8?B?T3JqQ2VmbjIxRDY1eU1sOVdFVHVCNG9zbTBqc1NkenloNlpQQmJRNHdhR2Mr?=
 =?utf-8?B?TWNiRWlaNHhwRXcvZ3FXSTBxaUFrTkV3TjdHMDlXUlJzQThDSDJyTEM4ejc3?=
 =?utf-8?B?dG0zelMvQWNlcFFac0dleGkvejYrMXlwUXVDN3BrQ2huTkUxWk9rMCswcHE3?=
 =?utf-8?B?dDhyVUJwVGY4YXBpWi9rcGg4dHdZNjRReUJ5cnA1WFJKazZubC9qYUJwbjhB?=
 =?utf-8?B?N2RDYVNOZXA2MG9BV05mRDZOSWVTRXM5SnpDNEpjSko0YXA1SnpZYjcvNndw?=
 =?utf-8?B?bEFTTmYzbUVlNHZpanM4VVMxNWlidkNERkVnYU01bzNGaEFCY2daS3FTKzVx?=
 =?utf-8?B?ekdoMERFVkVZck1TZ0hubm82VUQzNWNnai9sMnR4THpDRk5yTVZINld6VHlN?=
 =?utf-8?B?T2ljUHNXVjFrMlVrNGhETHh5Njk3N0xzSmhTNDEzbnZabXk1Vm50L1ZHUi90?=
 =?utf-8?B?Vzd4a2VKTHBWdlZwdXpjQnQ0T0RYODVZYmpJOHVhNkFjbFhPZHBUalF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjlQRVYxV280QUpnVG9wVFU4aTFlMlZYRGRpT3JZQVh6VUZkWGNKcGVqVDZs?=
 =?utf-8?B?TEpsTzlESWVRcEhGU3JnYXpGR291enNLc2s1R05WVWp5ejcxdmpqdVhwa05t?=
 =?utf-8?B?NGhmeDE1dmdZMzB4dzJqWkZKd3B5b2JaTUd1ZVhoSVFjeHlaRllxWUY2d09V?=
 =?utf-8?B?czg3YXJMalVuREdSWGtaY2RNZzA4WWY1VTR1b3dBNGtxYjZYVWFoZFI3VVZV?=
 =?utf-8?B?Y1Znb1JCMmtIeUg4VHZpUkVwNTA3WXkySGJBYTVCNkxDc3NQTGxHdWRxZEdI?=
 =?utf-8?B?a2RTc0RRNC82TmpyOHd4d2FydjBpVmFsUFY4OUdyZzZEdHhXa2RtN2N6V1g3?=
 =?utf-8?B?b3R0VFdESVh5SHRUclVwRTNYSWJTN0E5ckZQKy9wMXF5dEZKYk9WSzM3QlZ5?=
 =?utf-8?B?dG1UT00xemp3V2lxLzF0bmh6V2poTUkvZzk3c3A5Z3BIazhhL01PaWpJOWRk?=
 =?utf-8?B?bFptQ2RhRWxvRkVmKzF2OVREVlh6dGNpNnF3YXBwRFRUMGNSQVdxRVJmSHMw?=
 =?utf-8?B?SExJczhyN2FLZk11RFdXUkJvckxIM3FLc0tZUTlTUlFtd2ZpNnIzazNoVjhI?=
 =?utf-8?B?a2VkdFU2NmNTdnNSbzY0ekNJUFRwQ2dLWEJ5SEpVOGJpRVlFb3J0MWcvSzFl?=
 =?utf-8?B?bVB2MEUyQSs2eE94ejlsRnFkeElCMCtxb1J2OEFkUldlQkxTNlJnVkkybzM4?=
 =?utf-8?B?cGNiNFRjSDBKYkQwRGg2VHNQV1V2VUQ2T2pXc0ZDZUh2YU5xNVVOVmFKcnRV?=
 =?utf-8?B?UW1Cck00Z3JLbW5MQ1l6OVNTN00xOVJiNVU0QmdSWWJDUnRxYWJkNVdVZ0tZ?=
 =?utf-8?B?VUx4NlVuR2h3TnU0M0FwdnpMQkdqNkc5Z1BVV251UjdqS1kvdndCUWczV2pz?=
 =?utf-8?B?alY2TW0rT1RMMHRSWFlJZmwxN3RpdnJIRGlaSE4xWGlRRXdZYnN5TlEyTU1L?=
 =?utf-8?B?VFAwOW41Q1dCUzZaTDJxVmNtRTVHdldDTlJWVWcrVXZTRkt1T3YyNzV3eFVT?=
 =?utf-8?B?N3pCS20vU0Q5cGxHSTlYeDRXQ0RuMGF5TFk0TWs3bnN6aFczNmxXR1hrei9u?=
 =?utf-8?B?UUVLV0t6Mm1uR1JTU2tpaUR4V3JFSmsxY1Q3a0VTSkRHa091SjRnWmdSYUVz?=
 =?utf-8?B?T1ZpMVY3TmgvaXErZUZxT0wwblBRdTA0UWRJQWMzQ0dqeUdiVFo0eHN3WjRW?=
 =?utf-8?B?bkNUbDJPK0hMV05WR0xYWXVwVS9FakhrQ0VmdDZjeXJqb0JxLzNHaGpxcnpa?=
 =?utf-8?B?UkRNNjJkZ2VUZjlhbVVSRlZqSVNsS2R6Y1ZhTlIybXNMcmhFam9SanpUN3JG?=
 =?utf-8?B?WmpqSFFUVkk1VE1PUkl1OWc2WEdMMndaQTlEUFp4MVpCNWVaejZlMjlNaTly?=
 =?utf-8?B?VlQ2ejU1QUNjYURLYUpqRkJNRXV0d0JsU1N1S0FheHFSeW53OHRUYXZZSG9v?=
 =?utf-8?B?RWxaVHJtL216OFBOYVh0VG9xZ1lPUVprbnJyR2pBT0Y5V0w3SzZHdldZTHpG?=
 =?utf-8?B?R2tyeEkxcEZTbnErUnN3ellLTnpkUW9GK1p2VDcxdkFXcml2d3FTanFucm5B?=
 =?utf-8?B?dVBzcHdhNHJqRE1TVnVobDZxMUxOT2ZNRllUbjYrN3BYK0lMTXNWbVV0Z0xR?=
 =?utf-8?B?bWZmTkoyOFdKa210QkVSempMUS94TjJDMUZXemcxUklSS1g5a1E3UllGZWF0?=
 =?utf-8?B?NFhabDQ0M1F2UjRKUllnQU1YbnBvUzBkRjcwQUQwU2h2MmZxeC9QU3VwMndQ?=
 =?utf-8?B?U1pGTk91dXlha3lzdHhEMUJ6aGVxN3BDZUNCUmFwa1kwUGJKTUJzMGRLSkxt?=
 =?utf-8?B?VS90UFZZSjU1eU1Mc0F6YndGMzJPYXY3V3F6bE8xTmFySFRsWlpHTWREbkM4?=
 =?utf-8?B?ZTFzdVRXcTlYenZoY1Z6V3hKbW9xY3YrMW9xZXJORmRQREJIb2NvWmxlRlZ5?=
 =?utf-8?B?YmxRU25XUmtxcFQ3WFRacnd4T1M4YVIzMjQrZkVpelRhdWtGeVQ4Uk5ua0JW?=
 =?utf-8?B?dlYvL05venM2WENhV005NjdxSTR4WkYveC85aFpEbmNIcWllcitxdFIwRzND?=
 =?utf-8?B?bTFRcVVreUhsMGV2THN2YW1YYmpkN0g1VVFBWGxES25ZbWV0VDRRQ1hLRlVJ?=
 =?utf-8?B?Z1YxdjQ0S1dPZVhJR1NBU0xlM0Rucmd5WVM5SUxPVVVQcDgzcGluTzNqMkNq?=
 =?utf-8?B?b09lOFdyd2FsMHFBblJmeWttUUdoeEs1aG5XTjJ4bXhtTW1PMkwvUG9ieGcr?=
 =?utf-8?B?Zmh3SkYyTWo0Rkt4cTVvMnJPblVnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l+YWCpXjWriax+NhPrLZzKokaHUbwupmxEyqvA7ikkzuvGvDbJDT5iRPdAT99HgBC3aZ6XjoJrp3j3uXhxf+hqSGzpgwnbYcSCzcmJI5UD8w6iQ4vngJp6PWAMqZgNVat+OCzzUkrPINANZ5br7/0G7liJ7X1NvIwxqBJ92pF2nrYrVU+fSC1EBsnJagl5JEOe5/DzG1PvRyu2lmV+s057suOS7zS+0r7n3gWBVXcRcT185BzaGPm66Hj98H4eYz3G5jHOzCEiSKi9+EnRmM0csG4KmsM9Alex1uBYo/7yus2j++ZIzk5HzIhexQ3QQLSv/7CMlz/OQXBwG3v04td+mlhp87lO+L/xhoJWD31n3qBB5wzm8AYoS3k7fnjc66OdN77pC2ta+1bj7Gcqz0DwlOJ/oNQwVlPTvpsQ0SOejAWfVIhMK9bD8O5kc3RQzRxa3q8cZrXkBDmZ6mRklD/fdbfqWNPZ283Y3sSM0OHqJQ3iXnRpgTrVI7FM5s/RcWyAOsTnYkJf739Pu4V9majcYON5LdA/UlZJaq8P8FuQBZOyrYnDwil+/q665F+JpjpkQvhjA5VTCfALIVxEAsmWNlDwyz4tk+/cIoD63+7JQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3414e0a-0c25-4778-4323-08dcdca6c85c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:40:06.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN+X9OLvYbl4NhMo9SIbyycP20TsQ4enjHDhAvczV8fb1UHnwZc+tnqNjcZw3PKTlnd7BTXEuKJIv+McNd1bkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240105
X-Proofpoint-GUID: -a70qgJ5-FfRbvvneB7WBnyIR-fNCr3b
X-Proofpoint-ORIG-GUID: -a70qgJ5-FfRbvvneB7WBnyIR-fNCr3b

On 23/09/2024 15:19, Jiri Olsa wrote:
> On Mon, Sep 16, 2024 at 02:49:44PM +0100, Alan Maguire wrote:
> 
> SNIP
> 
>> Baseline
>>
>> $ time pahole -J vmlinux -j1 --btf_features=default
>>
>> real	0m17.268s
>> user	0m15.808s
>> sys	0m1.415s
>>
>> $ time pahole -J vmlinux -j8 --btf_features=default
>>
>> real	0m10.768s
>> user	0m30.793s
>> sys	0m4.199s
>>
>> With these changes:
>>
>> $ time pahole -J vmlinux -j1 --btf_features=default
>>
>> real	0m16.564s
>> user	0m16.029s
>> sys	0m0.492s
>>
>> $ time pahole -J vmlinux -j8 --btf_features=default
>>
>> real	0m8.332s
>> user	0m30.627s
>> sys	0m0.714s
>>
>> In terms of functions encoded, 360 fewer functions make it into
>> BTF due to the different approach in consistency checking, but after
>> examining these cases, they do appear to be legitimately inconsistent
>> functions where the optimized versions have parameter mismatches
>> with the non-optimized expectations.
>>
>> Mileage may vary of course, and any testing folks could do would
>> be greatly appreciated!
> 
> looks good, some comments below.. I was hoping to find some way
> to split the change, but can't think of any ;-)
>

thanks for trying it out and looking at the code Jiri! Replies below..


> thanks,
> jirka
> 
> 
> SNIP
> 
>> -static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype)
>> +static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, struct elf_function *func)
>>  {
>>  	struct btf *btf = encoder->btf;
>>  	const struct btf_type *t;
>>  	struct parameter *param;
>>  	uint16_t nr_params, param_idx;
>>  	int32_t id, type_id;
>> +	char tmp_name[KSYM_NAME_LEN];
>> +	const char *name;
>> +	struct btf_encoder_func_state *state = &func->state;
> 
> func could be NULL right?
>

good catch; I've moved the assignment to the code that deals with ELF
function prototype addition.

> SNIP
> 
>>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>>  {
>> -	fn->priv = encoder->cu;
>> -	if (func->function) {
>> -		struct function *existing = func->function;
>> -
>> -		/* If saving and we find an existing entry, we want to merge
>> -		 * observations across both functions, checking that the
>> -		 * "seen optimized parameters", "inconsistent prototype"
>> -		 * and "unexpected register" status is reflected in the
>> -		 * the func entry.
>> -		 * If the entry is new, record encoder state required
>> -		 * to add the local function later (encoder + type_id_off)
>> -		 * such that we can add the function later.
>> -		 */
>> -		existing->proto.optimized_parms |= fn->proto.optimized_parms;
>> -		existing->proto.unexpected_reg |= fn->proto.unexpected_reg;
>> -		if (!existing->proto.unexpected_reg && !existing->proto.inconsistent_proto &&
>> -		     !funcs__match(encoder, func, fn))
>> -			existing->proto.inconsistent_proto = 1;
>> -	} else {
>> -		func->state.type_id_off = encoder->type_id_off;
>> -		func->function = fn;
>> -		encoder->cu->functions_saved++;
> 
> we could remove functions_saved from cu now?
> 

good idea; removed that and the "processed" flag from ftypes.

> SNIP
> 
>> -static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
>> +static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>>  {
>> -	int btf_fnproto_id, btf_fn_id, tag_type_id;
>> -	struct llvm_annotation *annot;
>> +	int btf_fnproto_id, btf_fn_id, tag_type_id = 0;
>> +	int16_t component_idx = -1;
>>  	const char *name;
>> +	const char *value;
>> +	char tmp_value[KSYM_NAME_LEN];
>>  
>> -	btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
>> -	name = function__name(fn);
>> -	btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
>> +	btf_fnproto_id = btf_encoder__add_func_proto(encoder, fn ? &fn->proto : NULL, func);
>> +	name = func->alias ?: func->name;
>> +	if (btf_fnproto_id >= 0)
>> +		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
>>  	if (btf_fnproto_id < 0 || btf_fn_id < 0) {
>> -		printf("error: failed to encode function '%s'\n", function__name(fn));
>> +		printf("error: failed to encode function '%s': invalid %s\n", name, btf_fnproto_id < 0 ? "proto" : "func");
>>  		return -1;
>>  	}
>> -	list_for_each_entry(annot, &fn->annots, node) {
>> -		tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id,
>> -							annot->component_idx);
>> -		if (tag_type_id < 0) {
>> -			fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
>> -				annot->value, name, annot->component_idx);
>> -			return -1;
>> +	if (!fn) {
>> +		struct btf_encoder_func_state *state = &func->state;
>> +		uint16_t idx;
>> +
>> +		if (!state || state->nr_annots == 0)
> 
> it probably can't happen, but state will be allways != NULL in here.. should it be:
> 
> 		if (!func || state->nr_annots == 0)
> 

I've added assert()s to the btf_encoder__add_func[proto]() functions to
ensure that either the fn or func are non-NULL, since winding up with a
NULL fn/func is more of a programming error than a state we can wind up
in.
> 
>> +			return 0;
>> +
>> +		for (idx = 0; idx < state->nr_annots; idx++) {
>> +			struct btf_encoder_func_annot *a = &state->annots[idx];
>> +
>> +			value = btf__str_by_offset(encoder->btf, a->value);
>> +			/* adding BTF data may result in a mode of the
>> +			 * value string memory, so make a temporary copy.
>> +			 */
>> +			strncpy(tmp_value, value, sizeof(tmp_value));
>> +			component_idx = a->component_idx;
>> +
>> +			tag_type_id = btf_encoder__add_decl_tag(encoder, tmp_value, btf_fn_id, component_idx);
>> +			if (tag_type_id < 0)
>> +				break;
>> +		}
>> +	} else {
>> +		struct llvm_annotation *annot;
>> +
>> +		list_for_each_entry(annot, &fn->annots, node) {
>> +			value = annot->value;
>> +			component_idx = annot->component_idx;
>> +
>> +			tag_type_id = btf_encoder__add_decl_tag(encoder, value, btf_fn_id,
>> +								component_idx);
>> +			if (tag_type_id < 0)
>> +				break;
>>  		}
>>  	}
>> +	if (tag_type_id < 0) {
>> +		fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
>> +			value, name, component_idx);
>> +		return -1;
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> -static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
>> +static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
>>  {
>>  	int i;
>>  
>>  	for (i = 0; i < encoder->functions.cnt; i++) {
>>  		struct elf_function *func = &encoder->functions.entries[i];
>> -		struct function *fn = func->function;
>> -		struct btf_encoder *other_encoder;
>> +		struct btf_encoder_func_state *state = &func->state;
>> +		struct btf_encoder *other_encoder = NULL;
>>  
>> -		if (!fn || fn->proto.processed)
>> +		if (!state || !state->initialized || state->processed)
>>  			continue;
> 
> state is now placed directly in elf_function so will allways be state != NULL
> 
>> -
>>  		/* merge optimized-out status across encoders; since each
>>  		 * encoder has the same elf symbol table we can use the
>>  		 * same index to access the same elf symbol.
>>  		 */
>>  		btf_encoders__for_each_encoder(other_encoder) {
>> -			struct function *other_fn;
>> +			struct elf_function *other_func;
>> +			struct btf_encoder_func_state *other_state;
>> +			uint8_t optimized, unexpected, inconsistent;
>>  
>>  			if (other_encoder == encoder)
>>  				continue;
>>  
>> -			other_fn = other_encoder->functions.entries[i].function;
>> -			if (!other_fn)
>> +			other_func = &other_encoder->functions.entries[i];
>> +			other_state = &other_func->state;
>> +			if (!other_state)
>>  				continue;
> 
> same as above it will allways be other_state != NULL
> 

both fixed now. thanks!


>> -			fn->proto.optimized_parms |= other_fn->proto.optimized_parms;
>> -			fn->proto.unexpected_reg |= other_fn->proto.unexpected_reg;
>> -			if (other_fn->proto.inconsistent_proto)
>> -				fn->proto.inconsistent_proto = 1;
>> -			if (!fn->proto.unexpected_reg && !fn->proto.inconsistent_proto &&
>> -			    !funcs__match(encoder, func, other_fn))
>> -				fn->proto.inconsistent_proto = 1;
>> -			other_fn->proto.processed = 1;
>> +			optimized = state->optimized_parms | other_state->optimized_parms;
>> +			unexpected = state->unexpected_reg | other_state->unexpected_reg;
>> +			inconsistent = state->inconsistent_proto | other_state->inconsistent_proto;
>> +			if (!unexpected && !inconsistent &&
>> +			    !funcs__match(encoder, func,
>> +					  encoder->btf, state,
>> +					  other_encoder->btf, other_state))
>> +				inconsistent = 1;
>> +			state->optimized_parms = other_state->optimized_parms = optimized;
>> +			state->unexpected_reg = other_state->unexpected_reg = unexpected;
>> +			state->inconsistent_proto = other_state->inconsistent_proto = inconsistent;
>> +
>> +			other_state->processed = 1;
> 
> SNIP

