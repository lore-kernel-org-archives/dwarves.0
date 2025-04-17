Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C18253352
	for <dwarves@vger.kernel.org>; Thu, 17 Apr 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744904330; cv=fail; b=crrjDT7jNwuAUP9TyYrP3QNKsOqfgFFYIsuULQ05inZjANYteGn7VFTz98kuZxSYAOpWDbiYihvKy476JBMEa+QsVIdv33QCwnH7RYRx5XtnWFeCc8LsFxh76wjcgBonuYvW/PuLQNfzySf6m3u6rgI6xhldN2E9nKSWK4b+Fso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744904330; c=relaxed/simple;
	bh=nx4EOBX3qKawCQFhVoTt9K9xj6yzj0AyhSMyaExeGZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EbtV+9hidA3zgQI/P3o3+NanI6qLtlabEV9SV3/224KKPbbu84y97hApM3jrMjBpZNsl13bygF96lrmpJkz/QzheRk6Z7ac1o9hCJ3/zJFgJUcU1WmHSdkDRn67zdJ5MkZo2o8mt4Iv7ljg3r1Pny8QE00Q8rYETnnkrKt8U5zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fce5nMql; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tQZraOP4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fce5nMql";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tQZraOP4"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBpaGu030492;
	Thu, 17 Apr 2025 15:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TUADeHff3wDw5tp7Csr2WeOGupC9fZwVHDRrjK2iavo=; b=
	fce5nMqlk8haq8dvkEH1gh0LQr/66ons9RLEWGXUotFxrgDQQYFu05RL4L++AVdw
	3xVFZiCzVT8NT9MeWg4B74pfYh2DJMiQFRrYbKZiQQZfBW9Jcq4c+at7UYqvxTTW
	nJKvyTBTidfgSmr5FNOSzhZt4Q3/U0bk+LmaM9i4FWtlYR8G9eQlsarsB+bVYR0G
	RF5TnyeIRTzxQhxu2hdw8E4SnjLSvH8s0DihZ00aQvMdOLrrGwUGtaaQ/vJeG8cI
	gk5tjZsvv7V9CZdr4gm239bBFB2GFVucg0Kyx3bmxIcTn9fTUgMKAKh5XT5d/lWw
	XpLY/1VknP/qktBcmh9xQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46187xxqfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 15:38:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HEk3lO024729;
	Thu, 17 Apr 2025 15:38:40 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d53p03v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 15:38:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bgk0MhJc6otPtVOz0YmoGCJsn1kd1712WjojdoymdqeSlrpz7iAwrgXuEnqVIR7E7oQoMslyn6tsiJjIHYbVSEMcz++oW2BP4RUaUeyqh8y1L1DAPoTN0y2IiwAMAOBfCxMN6yBek3WI8E8EmUbDleFuVWUIpqhvFKRkuSyGsENe8l0ZEZgCwlFZ2mR5q3L4RfybC2+4cREAtiHd3BgaI8mmoV8+avQlYLNjNd17JiRf8ASjdtyp0GObppFv19lNbgtvf7qeXYjl4U+3U8PtngJ4Nu45z0ALrCK7GjzH1z6bmuJTXTU69MPoGZMMk4kd5Z+1bNYzHEMuaf8JogftqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUADeHff3wDw5tp7Csr2WeOGupC9fZwVHDRrjK2iavo=;
 b=R5ViEePqonC/WQeRoeuAk6tWjivDaHnBrl3/iSEB/cCeitmbvKrU/ksSyxDF/PHSS9+0Yy6tmD9yNZaiibth9LHQD0SKvk/9cdUnyqD1IIRjT+9aFuO46bBG1Zr8o5JntQkEqpOknrDUdGybzu5/n2UxhRs+CovXGDkr6H6kg9DfYmqLw3jsHrOEiKS1EgOCEfIBSJleml/DgHdr3cWHt25O4qZkT4BH5c1U9XSl5z+y6t1cas77v16rfAryw9c9DxJetP3z8fAnPb5VNsZS7R7RKgc8lQakjfcU45TCU1Oe6SfIyMXcuLiTh47aN0jk+ZrPzq4BkJcugC5VWaLYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUADeHff3wDw5tp7Csr2WeOGupC9fZwVHDRrjK2iavo=;
 b=tQZraOP4Pl5v2zNp3bAGB91GXwfXQ4Hlr8V2SPrrzu2NjpQHPKV6K0kNejBHx0yntaCFAizSvGBhJ1uISSWtfIja6ZGb+Ls++nfVuUloTtV4P0gPEQN/hp8tytc3p6h4WYKnoSQNPB7YCb2itwPOCwPfzMKlLjjPgzggJ1zCZ9M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6168.namprd10.prod.outlook.com (2603:10b6:930:30::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 15:38:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 15:38:37 +0000
Message-ID: <a518d355-5815-4045-8df3-f15cb5ede2a6@oracle.com>
Date: Thu, 17 Apr 2025 16:38:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Is 1.30 released?
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Domenico Andreoli <domenico.andreoli@linux.com>, dwarves@vger.kernel.org
References: <Z_4mPCCLXBCakppE@localhost>
 <aae20053-ce1e-4fa3-8c73-1f1a702d123c@oracle.com> <aAAGVRUbj6_4YEWr@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aAAGVRUbj6_4YEWr@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0432.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 17180465-6904-4f7b-8122-08dd7dc5ebe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXJ4RzRLTTRIK1VHVDJ6dW9mSWluNXpBYnV6bHlwa1FwOEU1QmFMUXN1LzVD?=
 =?utf-8?B?UnpPMHpaVHhxK1NyMEtjWW9xZll2SGIxS3FiQXF2WVBGTU8xa01vd2gxUE4w?=
 =?utf-8?B?Q3ZRQnNNU0l2WS9SZDJuTVVad0lFZytmRXcwN3FGVjJRSWhEajFuMGRZU0N5?=
 =?utf-8?B?WVY5eXAxVHAvdXIwMzFKdlpwZ2t5Z1I3Ujc2eTBnajZRNEhCNXd5bDZDdlRG?=
 =?utf-8?B?V3FieVBNcWRDanBpZHNVT1loN1BlRWExVUtKSFNYY2tBdGp3YzUvZE5qT29n?=
 =?utf-8?B?TGJUZGVwNGlLblFTRG1QcWpkcVArL2dEaFZ3bGpsM1FFSmlVaFFvakdNLytu?=
 =?utf-8?B?Q2RCclRKN2Zsdmo1TGk2TkZSTXdBbVhtM2gwb2dTeHo5VUZKeFhEMjZ0V3hx?=
 =?utf-8?B?dUdoSGZqZmdTWmxNazBXUXE4TlVBRWRQZ3pPTVVwVmtaVUdSNHc5ejdMcG96?=
 =?utf-8?B?NjkxOEtBNm5jaFpPUVkwOHpjQXl3ODBaNlJpNHczc3N4a0JUWnRpY205a1hD?=
 =?utf-8?B?S0p3ODdQRUVFMTlJckNFcUk5MmlOQmNHUlcyTERIUkYySC8rV0lyeDlSdDdB?=
 =?utf-8?B?KzhMUk1SVTNOWldPYm8zRTEvVFFVaWtaZi9EUjBvR2QxRXQ2NWltOVNsdDRs?=
 =?utf-8?B?VGpiZ1ZqV2pKQ2xrdklha2d1TWVYVklyWDVHRXV6eVBxTjAwdW9nS253cXha?=
 =?utf-8?B?ZndyU1I2aEszODROMzdEM3B4Tkdwc1piSGNGSFVSV0JhRHdHVnN0aURTYUlw?=
 =?utf-8?B?ZVFVZHZnSXJFN3RQV1JTalNwUnh6RUluS0grZXVFcUxQbzJBQjdCakFqdTha?=
 =?utf-8?B?L1JJZjlDMGZVWUY1MnBYdjNFbVR6UnF2bFBRNGRnaEJWSUhFenAvZ1E2VVhj?=
 =?utf-8?B?aE81ZEc5UXR5RmNlc21IQkJ5NVFRWW94ZS9STWxZOW9oWVVjdHAyU29ORys0?=
 =?utf-8?B?amJpT2E3WGpvaTY0VXlwUmNTSENoU1kvbHhGZXF6aVBFQ3JYUkY3eHMxTkRn?=
 =?utf-8?B?ZUNNbGZ4OWJVWGQyamlRVjJ2VHFkVGJVT1lYZXpTd09YbitIR2JKaFU5bVZy?=
 =?utf-8?B?aFdCOXdoTzRkRVpjT3psMWF5MWdxVklNamhvV04xU3hOaDdVcE0xdE1IclMy?=
 =?utf-8?B?ejdDYVI0OHM2em91Y1pWWmJpZ3lRVXRtV0VMVTQ2ZXc0VCs0MURnNlVoSEg4?=
 =?utf-8?B?UGF3UFZjU2JzT0x2cWsxYmxONUk3UkZGQWJRcHVkNjFkSDBxNnhFR3JUcndR?=
 =?utf-8?B?UldKVENMMkEySTZjV2FYTysvRmVZdE1rKzdJb3RDc1Z3d1BhSjY2aXNPWFRF?=
 =?utf-8?B?dEpkMEVGV2M4dHlUK0ZXQy9hdWVydFd1SlFJQm9zcnRsMEoyWDJIdzNXbVhN?=
 =?utf-8?B?K3h2WWdNcmtBVkxwdnR4SUl4RUhweU1NVXAzblpWM29GTXFzZlNxNGI0Zi9s?=
 =?utf-8?B?em1wZmcyMnJwNWwrUnZlNS90RGEvOEdTanlCdDJST3daQmNOSkx1YUthN0kv?=
 =?utf-8?B?UUFRZENOWGNLbXJ1RWRYNTI0SS9EUExjaDN6anA1Z0kzbVlTRXdqVURMMHlH?=
 =?utf-8?B?M1k1YnhkWUxNMStWWnNxanFLdDhEdU5CeHNiOU04NzFpWEI1cmNSQ0FaYXdS?=
 =?utf-8?B?Y0czWGJ3UHoyNXRLUnNDM3R4NUNmdmtoSWgwaEtmNS9QcjVReEQ4UDZLUEZ5?=
 =?utf-8?B?WXFwVVpYYS9wRGdzQVBxclk1SUMvM0MzRVRpV0NGcnFTRFZIWThvMkpzeVJv?=
 =?utf-8?B?YytVano2aGI3Mk4wYmU5ODFTVTYzZWtBaWZ1Sm9xcEVIdW1VQ1FaRlRPbnFt?=
 =?utf-8?B?bXVYN1V1MUFIK2VnOXNXbUI0dmxGOTdsSHQzYTFyTmQ4RlpwNUYxc1RxZndO?=
 =?utf-8?B?b0NrcW0zN09ZMm1lVEsvUEJZQzl2dllQWWkzaXVHd3RYd2hDaWYyRWhjSGlM?=
 =?utf-8?Q?QN0cbi5duHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDVtdmN3WktDak5oODZyVzFZR3hnNjVldTFHNjFHUE5wMWxLZVBpQ1U1aWc4?=
 =?utf-8?B?cmlBSTlVOWJKSytZMkhKcThTTFVMMjBaaHUwdWZ4SkQ5TGxXQVRoL2tvTEVV?=
 =?utf-8?B?aWJSTHpqNzloVGRJTW91VWpYditzdkEyU1ZzZnh6VEFiSndUVFFSQis5aG1C?=
 =?utf-8?B?dS9lU3JPMkI0WFdadDJQbXEvSEc0eTAwZ0JWSG0xbXU1cGMrOEd2dWVpZVkz?=
 =?utf-8?B?V3h6Q3d2L2lnbUJlblRsc2VoaUJXVlg5dXU3ZWJMaVczRUxhZU9FY1E4SGJJ?=
 =?utf-8?B?amVmdFhreWplck5NQmhDSzJhaFROU2piN3lOL0tkTnZqVThQOEszTWR3Ymlm?=
 =?utf-8?B?a0ZoNnU3bnZvUmltR28vVWhWNDc1U0d4enhqZG10cm94VlBTMlRYbTY3NTNm?=
 =?utf-8?B?QmVtanR4RE9JQ3V0M2pMT0tCOFd1eCs3MThrM09OcjJOOTBzY25xVVpncXpP?=
 =?utf-8?B?WVBuMW1iaHVJYWgvMmlrcldyYjBJWTB3SXIzbFgwcDVzc3orVW91czRYUWhn?=
 =?utf-8?B?dVhuTDcwYllFM041RlNMbXBsc3RLY1NlNTVHSzMrdVJ4ckp6N2IzZStncXNE?=
 =?utf-8?B?TzNaUXpCd0Uxd2xSUkdXME1tKzdOS3pmUTJCM0Jmc0JFNjg1YXR0MHBnSkNx?=
 =?utf-8?B?d3JzT2RNVnlwRTRLbndpTnZKc3VxbEVqdTlaSTNmRHR1SkxCU0V3cFc5VEh2?=
 =?utf-8?B?dHg1VW5Sa1ZMcDM5RGMvSko3eTdPNkZKeEFDVnlCcThvQWtPZWZXcmVCWHI0?=
 =?utf-8?B?R0YrdUlTVVlXSUF1YVROazNuUDJGL3BEVmxGUE5walBNZGpydmFhTDV0OWVl?=
 =?utf-8?B?c1Bnb2gyNkRzRUtFeEN4VVBnUmUycUl1OXZrYi9nU2JOc0JJUXEvK09jQk1T?=
 =?utf-8?B?aW4xZXNla1VpZ2RIOWxZWFNmK25jTUo0TGVmcEdyMEthUGdJWFo3WjVuQmVG?=
 =?utf-8?B?MXJ1N094YWluNTdjMXFubVppTElJSFZUSjZqU0QzS3B0RS92WktuTk0zZ3Nn?=
 =?utf-8?B?NVNwMWsrNk9OeHUxWHJJcjFGU3BlSno4Zlp6UmYvQWIyZmZtMGVnL0JxU0hD?=
 =?utf-8?B?cG5nSUl3MTFET1pOajdObEdsNGo1aHdsOTlLTWxhSVAyYTdKTjFSa0poNlpD?=
 =?utf-8?B?RHNaUnp5aU9nZHI5NllacCtOaW1jTDJpKzI0OGdSc1V0N0QxNjNvOWlmaS9F?=
 =?utf-8?B?cXl1cTBPUmdLRHZUUUFGVXdLNExYTlIvb0hTa2RtM0RMNU1xUUlYU205YWU2?=
 =?utf-8?B?VTRyYnpjTXhtMis1V0Eyc2tHZ2RCM2JzWjZCa0J5U1RMMTIrUlhneER4MG1Q?=
 =?utf-8?B?M0hTc0hjdUluN2FwcHlTK1k0QndPS2ljRzhIU2laOGZBOHpYN0QyWFJabENq?=
 =?utf-8?B?eGRVTWpNNjZKNUpkUVRhRDFhWlRaK1Q0aDV1Zzg3eVJ2bDlQekVvazZyTERL?=
 =?utf-8?B?bkMvSzJqbndvMzc0OGhsTlYwVFl0U01vSzhDVDMwUFZ0WXd2TGZpREd4K0ti?=
 =?utf-8?B?U2l6Q0dsTHZCNkNCU3dvTTd5SElPOExzb0QzTmhxUnZIY25ZNFhONTU4T2pi?=
 =?utf-8?B?dzFld04vN1A2UUdUNXg1d0xGdEwzZ1A5UnVFeUpJcFZva0kyR0RDK1hXUmpn?=
 =?utf-8?B?MmdCa2VrMEtDUis0bXVzSGhNemRUSXB3Ri9VbEY3dCtPa2JoSDAyMUw5Mmcr?=
 =?utf-8?B?UjRNS0pyb0Uvdk5jVlJEYmNIZ2Z4VlBaa216eW82UFVqVkp1UXA4NGJXZU42?=
 =?utf-8?B?Yk1Ta0JuTWVGcWhIelBLK2JjUGlsTit4UStDMVZVRGdyU1o4MVMxZHVER3Bl?=
 =?utf-8?B?SVFSRzJEd3o2RlFCaHlzV1dTK2hnSlRNVTZ1OVI2VWs0SXVuSFlLaytTbjQ4?=
 =?utf-8?B?dGdQaEE5TS9KWDRkTElNQm1aMk9EWW5DSjNabkhwWHVhWUJobHBta3pSNWY2?=
 =?utf-8?B?UlVOM1piUWsrRHhZeG8rNkEvYmlWOFFlTm5sOHF4WFNxcVNFU21USjFDUGlh?=
 =?utf-8?B?cEkxV25iQlhPMmQ0V2VKdG1BMUhGVUlyZkVoM2hMQnNnaDExQUFPWHR1OVkw?=
 =?utf-8?B?ZTQ2WEUrRjFyNmpPaFN6c1QyZkV3NlJOOWNLcVVNS2svazJhY2NPWnNtWTBJ?=
 =?utf-8?B?OEkySGxCR0ppV0p5WmloK1FqZHFKa2VDd09TNkJtTEJmSHlCMk5URVJPYnQ3?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PbYw30l8pxby0sRlOuZYws/BNCE9X9YQ2Pe4xy9nnEMmnYpsDid1OhooiMauLOWpE64fwxblzLRRrBGUFpY6wbgGR105BgcKVEzqWITtH9jP2/vW3M61nMscCUt9oUe7dDtQro4o9QSgvHly9gfPrE9VwmMw5lwrSxA0AfsMfV5d2kmeJQoQlSG0A/I5HlP/ckjhg7Nwmb9KkykUzdqUinoeyTtpUZdeBY73ohRIf/dHMNd7//mqAuuTVc7/O+ZXfB+SzeX8qqybUivlkl25MvsN12tdBJiwHSx6GkRkKGjd7MKcvA5LxNBdWRq6o4SDps9Earg9SIYKVZQ01ZjsmwkZqz26OpzN4f1m8ghF7WPrCS0XTW+bdZLpV975MTWhnPPC/C5HqJrv31+grfwuvweRkjByWUqIlqz8dh5DaddJJoTQB0ZqnPzmfeiozPOT4WpWvg5xbVizWXMsZ9adE2DoDUiTp7ylCZNhL+82VPf0vVz2mHVfP/qnYhVyLl3a6qfBpLzVmhglY76+TAV0JHwLzqOdASMbIgt6rafc8+cW9DMxJGVqepTXS5ImELTyYWX8PiocRFSDTEGdpNjoxY5ZXG07HQATTK80+hhLe50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17180465-6904-4f7b-8122-08dd7dc5ebe5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 15:38:37.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDywzMyQdDorYJxVLe0PcSx7cG/tsFIY8ZcX9I2llfm28+Yz8AcSggqK6vMEsrzdsB+YzblYFKBUMI/rqVp+6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170117
X-Proofpoint-GUID: Zl8avQVsmNtMEGGeGJWWBicZvb6WUQrD
X-Proofpoint-ORIG-GUID: Zl8avQVsmNtMEGGeGJWWBicZvb6WUQrD

On 16/04/2025 20:34, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 16, 2025 at 08:51:59AM +0100, Alan Maguire wrote:
>> On 15/04/2025 10:26, Domenico Andreoli wrote:
>>> Hello,
>>>
>>> I see from [0] that v1.30 has been tagged but I missed the announcement.
>>> Additionally [1] does not show an updated (& signed) tarball.
>>>
>>> Is everything in order here?
>>>
>>
>> Arnaldo got some late reports of build failures when we were finalizing
>> the release; we're awaiting more data to determine what's happening.
> 
> You mean this report:
> 
> https://github.com/acmel/dwarves/issues/63
> 
> It is not something new, they say they started seeing the problem when
> switching from 1.25 to 1.26, so not related to what is in 1.30.
> 
> And I _think_ this is just a correlation, the cause seems to be a change
> in how they link software, they have LTO enabled, etc.
> 
> I did some analysis and updated that github issue.
> 
> Or are you talking about some other case?
> 

Nope, that's the one; didn't realize it was an existing issue.

> If this is the case I think we can go ahead with releasing 1.30.
>

Sounds good!

Alan
