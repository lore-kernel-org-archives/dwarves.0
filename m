Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD901D221C
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038471; cv=fail; b=n/gMGAUUCceLAM1+ZEAe37ysGR9BYs7qnlKHlYtaoM0SM7n3vGKM5z4OWVhalIRI+LfEK6l7rlYh/vU9VIv65qCRuZhD8ONxcWISEGqoYlnSteB6DEn19ZWfipyCG08buVqTDoA41x8rdXFQSVnJJV9X6yFWeeC0Lt8sHqufIEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038471; c=relaxed/simple;
	bh=HFbZmc4h+/wVXYxMCjQiV6z5c08j+9gG9E0JGqCeUF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HhglwOEcVvrhBnEGf7LAe0Odv7S8Ij+hOeIX5JBh4zQmnn/RMlTabaOgBrP1w+9ilxZQ3t4WPNnaog9xoWWFG5XBkdqyZsandE8c57hZqcW1F3xL4zwYzkLZcknNAcrW2pFGDucxNSiqYfA81MVakxtw0gQoPB7wN7CJ3lPUrHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Li0Afbqx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WbgVxvsP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Li0Afbqx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WbgVxvsP"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJHBfFw027726;
	Tue, 19 Nov 2024 17:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=C7b3oKApt8NsDOZsxIHvTLD1sJufFazky0cE/30W4NU=; b=
	Li0AfbqxiMJZUQlf1Nipquk+1DjX3jQa5xJ8fQz+YWQKfRjMNW1TQUTphIfz5FMF
	EY4HUOpod2eDRCZO1qGoyXcCNEFSKgz8fQSuTSM0ZPJJ40dJ8ipFiDq/dEhoaW5q
	bHs6VskuzdFkUNL0eeAol4J8Aru6A/xH0A5a+iUQSnHmaSGGncJt5Z9xfjbKi5XU
	YCckcsAAVTbGip+X77CSisM7eV2SGXo4bu9qhwCLJy5uGCeA55tCevayoBvx/Kx2
	NMsye1jrZTObc4iVcLsC4xjK7Tct3VmFamovJuQPpYgkfAO4SUPkpy+rLiasoN28
	YA4Sj+PpqEnebEoXMUiJYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa5kx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:47:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJHHDIb023158;
	Tue, 19 Nov 2024 17:47:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu99g21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:47:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrJy1bkgEB9n2VlH6ia/N8p/XOlDby2Vnpaez7+sk8zo3YqWcGBE8ebCltEh7EomsIrWeE5knUpzh3i7mBTOQky/HBg+xtYxRcS+YNF3Q/xQyGHUDpGL1e9wAsMqXr7qRTUTW7wCRQsVj7vbTh6M4ucNzlq9zcaecNSMgpEZPsEPtJycYLjr1I2vrU2hS/+rMogN+r4Hm+AyWU6Y7UEzbVhL5NYHyOERyAbGOfa7J2ZC05/FD+Zoe030mUQRvhgSMkcgEM0yTxVB5xzziZGH/nlLfwutJz3Q5TDvG/wNOt83P2sdKi07JXYgetvgK1aKj/Zn0J0vdxfjNlYItVKhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7b3oKApt8NsDOZsxIHvTLD1sJufFazky0cE/30W4NU=;
 b=TgTUxdzEDILKk1JIb7FV50tfDcFTs7/GgONxU7eLciCWiNGJt/LWqir6C0yuG2oJLe6iAnOBsj258ANqcW6sY1dPtY77YbJ7Nn6LzC9k+ZjpqQZnQsNpwDh/tMJFdhLmwfJxMfpsohEXoFtgQG44lY8ukBBkRhFgwXkHxrzSDB6Kb3gvrvHObDqKjIL5xFenfMIMcMN4vvkW+L2zCIIVC6woJPQJCbEgqFdyhgD6zlYLHGqry8TpWO1ErWMLyQdEq9q3Keg+cws0i4g7fi+SOqcQWbw1VQLAEXRxpbzHN2TgrgbbzbJzvFNvyRQXIL2BBNEG2bGKfvP7JpF5mi5gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7b3oKApt8NsDOZsxIHvTLD1sJufFazky0cE/30W4NU=;
 b=WbgVxvsPpGr1e3ewOImSYilTYthZUtLGcX9+yuFGFfVwQwthYY4iNGpr8LZcZr9atRFrZswHblp/oN8/t7EoZB2yGiuSZF7g04hspEn+cc1fXlP7LSHQZEzP/sgnTDMxbmqpG9tfJoi77orwwDJHjAgsr5TD1rQBzdtwL8+53qo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:47:26 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8182.013; Tue, 19 Nov 2024
 17:47:26 +0000
Message-ID: <0ddffba9-eb26-456b-bfa6-68bf94e8b481@oracle.com>
Date: Tue, 19 Nov 2024 17:47:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pahole: Honour exclusive BTF loading
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>
References: <20241119134032.783215-1-acme@kernel.org>
 <20241119134032.783215-4-acme@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241119134032.783215-4-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0058.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::38) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: c04e6f25-a8ee-444b-8671-08dd08c23b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1cxVVB2US9mUnhGb0hmRnRaMXdodDR1M2NiNnhNaXFYSEZLU0J1Mi9XNW81?=
 =?utf-8?B?Yjg4MG9mUDNPanpQRzA2TkxQYjI0cm1XaUlheWpyYW5reldDaE1aM1dsM0JV?=
 =?utf-8?B?d25pLzRGQldJVmRsSmlYZ1I0dW1UcGJWMnB5ejNGVDhkTHd4RkpERk1oNHdu?=
 =?utf-8?B?NkVvYm5mYUNiSUw2U01XeWU4cjBBamRzRXFZU1hPL0l3OXZJd1oxYVUycGV4?=
 =?utf-8?B?WlRCSDk5RktWMHdjallGa0lubE5qM0RrY2ZzbVo4NU1oUjdGNkpWTFdab0lX?=
 =?utf-8?B?WFA1ZGlPdkhnYU9mMXJzdHptemlSTnBBYlpHVDRnNE9jN1NadjZTYi9VTzYr?=
 =?utf-8?B?SUVtS0V0YWdMVU1FTnJLTDNhcU9GN2pES0VCZFJ0WHBlcG04K2VzRzBQTDAv?=
 =?utf-8?B?WkU3cjdkY2ZiNHI2ZUxzQXgrcDdUZXR5clZxUGw4UEpIK0szQUovRkQ5ZVg0?=
 =?utf-8?B?c1RLd01EVDc3QlozcXdEUmlLL3lXNkhNVXhFMXVtS3FwQ2JhZHFteitQMUNI?=
 =?utf-8?B?S3l0bGdWWkx4YlozV2d4NEpiNU4yL0tsU05kbHZ1WU1WVUdBeEI5UjRBTVcz?=
 =?utf-8?B?OHZLNVFFNmhPN2pQVEc2bHg2dUFKSWxHbytrK0VGaE45a1VadEVBUHk5dSs2?=
 =?utf-8?B?bXNMQXJwRW11ZHpvRlZmVzl6TkUrZWJ4S1pkTWhVaUpYa3JVVHJGb2JSNjd6?=
 =?utf-8?B?Yk5GMkZuaHhCdHMwWkFlMEhDWC9VSXJYc0FCNGNOMlE4ODgzRmE4OEJmdkQ5?=
 =?utf-8?B?bE0wcUhzaG1pQm9NbHExM1VQN1J6M0ZkUGtnR0ZOb2MxVHlXWUxsRTVWWVhm?=
 =?utf-8?B?UmwwNTR2R3ZzaXhJTStwODcvUUpXeEtFUUV1NWptdHVtQVhYT3lBZDNnTTdI?=
 =?utf-8?B?RFZxMG9oVllNQ3g1ekpCcysyY0ZxREJNRVdtczYxTTVYUWl0RElKY09oTkhs?=
 =?utf-8?B?SnpyRWRwSTVVYnN5VE5DQjF5TTlJK0VmYm80Y1VCZit1aFM1YkhTNDZneWlM?=
 =?utf-8?B?c1NxY09KdEl0R1pGT0tDZGxUZDV5UW1zUHpEKy93b3RVOHFaT0xldEZuTVZh?=
 =?utf-8?B?NndjWDVhMTljcWpZUlBrd0gxUGY2VC9PT2txaWdQNTJvN0EzUXlFR3hwaU1Y?=
 =?utf-8?B?aThrMzg1U0c1TmJQVjdReUwrYWFHL0Q4TkcyYVZxRzFUK3JFV21vRDE4M3h2?=
 =?utf-8?B?eE8wZWk4QzR4VjBLL3MyWURzanBTMWdhUHAyTkhKa0ZKZkFvK0FobUdtZllR?=
 =?utf-8?B?cldKb2hkQm95UGNydVdaam9iKzVDMFZlMlBvVUpralZwdDR6MG9WL291TnQ4?=
 =?utf-8?B?YTR1b1BzaDlQRmd1TVI2Y0pxYVc3S1VTZkJwTXRSODR2SERNOHRFL0k4czdD?=
 =?utf-8?B?aTRmQThaUHJxVXNPR21HNTdJWFIrOHZyNjVyOCtGNW1YLytUcm9WWkd3Zk54?=
 =?utf-8?B?cnBLUE1LZHJJZU83cFBvMXJseUVPUUJ6MzFKVHh0ZW12RnJ5Zm1KeXE3dWF3?=
 =?utf-8?B?dnp1dDRWYTVyeVJZQW9YZVlqdHNqNmhsNFE5N1ZEZXp5ZkpzNFB5UnBFVDd6?=
 =?utf-8?B?UUQ2UEdaOTRJYlNsLzgyM3MybW9qNkYxTGpCQ2MwVzdwZ2YyeXBnQVRKeEN0?=
 =?utf-8?B?S0FqVXpxb0NUQytPNC9zM1NaUjJrVFFmTTA5MDdBUjRCNVRBSnAwMWcrQmx0?=
 =?utf-8?B?SDhvY3FUa3ZoRExLRDhheUtSMUx5OFZLOXk3c05xRU9EbUJvU0VlTXk4TWZF?=
 =?utf-8?Q?h5tykdu+foH4ZDdlQM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkxDaytvYUwvRklSV1NIQW1NUFVLREV4YVVBcmFzVkpld081N25acmhxekVu?=
 =?utf-8?B?VmZFRkNDR1B5M2R5dGVjbU9LWU9wczNGUnhjVUUrdlpBN09JREhRQTFLdnhZ?=
 =?utf-8?B?NzJ5NmZ1YWN0MTREeldJeDVIWEFoZmsyT0Izd3dGNERYcDNwQ28rMzUybldl?=
 =?utf-8?B?RjR6MjFySThkNEQ1NGdzMjM0NGlNT0s2a2MrazZFTkVtbGdwVEV1a3Qvamtp?=
 =?utf-8?B?VVc5eHAwNWlNdWpObytOeVRLOFFTc3l1ZlpLODVYSzJmeDljdkR5eFg3WWlL?=
 =?utf-8?B?ZVpYTDVXa1l1cDQ0U083SHNXZCtyS2RYWStQM2kvN2lWamZYYWd4REg0d3ZG?=
 =?utf-8?B?T09DN1hlS2gzMmlLWTVUdmMvR3BieTdhK1VZSHVRcVN1cjQ4R0txUm52UG9J?=
 =?utf-8?B?bnhLemZXbGlCdHRESktoRFhDZVQ1TXhQQkxmT0ZWWW0zZExFc2VieW9ORHhC?=
 =?utf-8?B?SzZscUNZU29IaHpGVzY4THJHYjV5ZlFvZ1drSjF1eGt6eStRWk9seXlQeWRV?=
 =?utf-8?B?c09rREszdU02M09vb3NyUGIrSWpnRWRZVWxscFYraHZtL3lXM2J0U0JaZ05u?=
 =?utf-8?B?RmRYREVJdkJmRmFlK3FOODNZYVQ4R2JwNjVQMVQ2bS8wTEF0RFI1UTBRWmg0?=
 =?utf-8?B?disvSVBmQ1F4S2lQamVHdGZTdTVEdWo3ZFQxWE5XYTYwWGYwK1AxUDFQTDB1?=
 =?utf-8?B?NklhOG9PalpBMWd6VElqUlpSZnZVaFBEVW5UaC82QjdFeVQwY1dSVVBPL1NG?=
 =?utf-8?B?REZadTdXbWl5NmRNMndwMHMwQk5BQk81T1ZUWk9DSE5SeEE1RzNmbTF2cUM5?=
 =?utf-8?B?YnJYQ3hMT2YzNkxYMGlaYlpLS2g0dVV4YU5GcVVmRGlLMUFXSHRycmo0M2Vi?=
 =?utf-8?B?SzNXcGZCVlh0STlhaEZtNUtsVklXcnFpOGlJcjhNZDRyaExUMms5bFRRYTNl?=
 =?utf-8?B?NXRkSnhSZGNGL0NVM2p2d0lQaitxTWlpWkkxZmVrWlRhYVgzUDM5djhzQ2Zk?=
 =?utf-8?B?RUVrS1R5N1k3Tk8yUjVRRXhqbVhyN2E5K2srNWoxMmhLUXJaZmRpQXZzWUVz?=
 =?utf-8?B?SWdsQWJ0N1hnbEtnZndVQUU0SUNadzFsTFgxaXZ3VTM5MkIzcHdVSnlMdkt3?=
 =?utf-8?B?eitFZTE3cnhnbXFvS0V1a0FnSXVIdkVId2ZRZkpjSDIzV0xzcUJJN0k0RHNx?=
 =?utf-8?B?OTVWK1Q4R3F0QjI3ZkZRWGh1cVdXdDV5K2plUThqWDE4QTVsT0s0VXA3R2k1?=
 =?utf-8?B?OGUxbExQampweDRYZGdrb2lZOHo4Vlc2dzhtdU5zdW1hd2xCdXkxTXJUTzVH?=
 =?utf-8?B?SDZDemZjd1FIQU1jcHNsNHA3TzEza0xwUjA5YW9XcXNHMUs5ditjckd0REdY?=
 =?utf-8?B?Mmt6bGxyVllVYmVPTUhJUkFNZEpGaUp1a1NRdlZUYlFQK2lNQ1MxSmRUbG0v?=
 =?utf-8?B?cHNLMzNBMXc2YXNtV3BBY05iMTRmVUZtZzF1cUFYWEdYYjlMZmhaend5aHVi?=
 =?utf-8?B?VVpsWHlRMzN6bm1odndEOVpzTzg0bkdlZGNaL29iZGQydGMyb0gwWDJXY3VP?=
 =?utf-8?B?Sk5Sazc4b1FROStOTmhEWmVvRDlDWGVuU1hGekYyRnJNblV1Qkk1NE1Oem5V?=
 =?utf-8?B?SkxFMnpMM0pzcHVocUNNZUVwOWFBS0RreDBvZm8ycGc3MzluZU81VUM5VEFB?=
 =?utf-8?B?MHB2WGZ0eVVJUXlYTGd4ZkIvbDdrOFJpMEYrYkJKSUZVYzFsMjVGSS9tUzZm?=
 =?utf-8?B?dWlzamN1bWxzdlRZOUpRbXFPOUNROUxXNmFpY2xUWnQ1cjNWUmFsUU02YUFq?=
 =?utf-8?B?TXhVL05TSzczcXVjUDZTSUdMT3llaDFNaFl4SWZTYkllSkZTT0JsMGxKWW5o?=
 =?utf-8?B?MTE0aE53cStKTzdMR2dRS2dwby9jMW5nVlVudGtMMER3bzhtQnJ4Q1VzaHF2?=
 =?utf-8?B?Mm5kMzRvRXFPOWVRQ3B2VHVYT0JBU2V0ZDhlbThpeDNJVUlLaUx6MFBOMHBo?=
 =?utf-8?B?Y1VUMVB5OHZhbUdVUDJ1VC9wZldKbVN5cGVnbStmeFNJbUVsODN0RDZkdHE4?=
 =?utf-8?B?SFJwN3JkK0Zkb3JWZE1zT2tYSEptdmlIay9DWVJrbWt6VVJuU28xemxBTmFs?=
 =?utf-8?B?L09iRUJZdTdDWWpjeUs0K014ZXhqT1g4WEhiRFBUa09QankrZ01oYjdIUVla?=
 =?utf-8?Q?Vc0IuvlIMVECu41HnW4g6lU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k3s2ugNQ9YwQzKgYRlmb1+p2qh0f1LcXEzxI5rhdRHWLX4/BvUds+5N5QKGTsvu7MBcmu51AK0VRIyMQCV24BcrlMcIuSpubPhIuC2orz2hhnOP2MqEstgvU0WLe1q2AOgZc5G8YwGFLueuGABaJXGK371xlfLbrJotZYozGV4Byvax47Rk3Fhutc4VsbIODtpRuuzQWrtMHOENdUniBMRBuXDBvU6kXZQqXZCw8fhWXZzzXPPyUw8/mIR7qMmMOTKBdxMdRxEaDqd89oYdeTkoNVmHVxB/QP/PIxmMgLmR5IgPnNtfn77zxJ1VFF+N4kkFgWD7QS8UaAZ1RvQdPffn1jPw6/RoYdusVLaRBy/fPt3r8Tyy5Rb78MJ41iVrGUeYFEhpP+vM1QIkhy+76jsNYLT/jdWVY2J0p4aQCRMCBQmEQjasocGqot6FFqTgi6gwnUWLAi1SKEKp7LE+8UES3+ePESmd5NV64uXx1HmFS0s/A+5cguoCFBpDcxRspKs/5NAzxxtv8KxlnUtCNlkg/7kZ5rTj3WzTjPUND7zuuhSorv7XqzJJluZpwYlOJNUNpfxMHQGA78GmmXT4eXXP78s5UxSawzTbR2xHJmB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04e6f25-a8ee-444b-8671-08dd08c23b08
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:47:26.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJGsmcMB1olj0bwJ6curPFa6unn/JHd8oiXMpSMdHInz2mzx17H+/r0MkQ95USRzwu6IoZalXP7r9YHTTs0uXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_09,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190132
X-Proofpoint-ORIG-GUID: Vp8Hz9A3do08PbU1FB3m80Zq1RnNkOyb
X-Proofpoint-GUID: Vp8Hz9A3do08PbU1FB3m80Zq1RnNkOyb

On 19/11/2024 13:40, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> When we specify 'btf' and BTF info is available in the system, in the
> /sys/kernel/btf/vmlinux file, pahole will find it and use it to get the
> type information asked for:
> 
>   root@x1:~# perf trace -o /tmp/output -e openat pahole -F btf list_head ; tail -1 /tmp/output
>   struct list_head {
>   	struct list_head *         next;                 /*     0     8 */
>   	struct list_head *         prev;                 /*     8     8 */
> 
>   	/* size: 16, cachelines: 1, members: 2 */
>   	/* last cacheline: 16 bytes */
>   };
> 
>        1.579 ( 0.010 ms): pahole/764777 openat(dfd: CWD, filename: "/sys/kernel/btf/vmlinux", flags: RDONLY|CLOEXEC) = 3
>   root@x1:~#
> 
> But, if the system doesn't have BTF info, which we now can simulate by using an
> environment variable it is tryng DWARF after failing for BTF, which isn't what
> the user asked for having specified just btf in the -F pahole command line:
> 
>   root@x1:~# export PAHOLE_VMLINUX_BTF_FILENAME=non-existent
>   root@x1:~# perf trace -o /tmp/output -e openat,access pahole -F btf list_head ; tail -12 /tmp/output
>   struct list_head {
>   	struct list_head *         next;                 /*     0     8 */
>   	struct list_head *         prev;                 /*     8     8 */
> 
>   	/* size: 16, cachelines: 1, members: 2 */
>   	/* last cacheline: 16 bytes */
>   };
> 
>   1.643 ( 0.003 ms): pahole/765220 access(filename: "list_head", mode: R)      = -1 ENOENT (No such file or directory)
>   1.658 ( 0.002 ms): pahole/765220 access(filename: "non-existent", mode: R)   = -1 ENOENT (No such file or directory)
>   1.697 ( 0.018 ms): pahole/765220 openat(dfd: CWD, filename: "/sys/kernel/notes") = 3
>   1.801 ( 0.004 ms): pahole/765220 openat(dfd: CWD, filename: "vmlinux")       = -1 ENOENT (No such file or directory)
>   1.807 ( 0.005 ms): pahole/765220 openat(dfd: CWD, filename: "/boot/vmlinux") = -1 ENOENT (No such file or directory)
>   1.927 ( 0.005 ms): pahole/765220 openat(dfd: CWD, filename: "/usr/lib/debug/lib/modules/6.11.6-200.fc40.x86_64/vmlinux", flags: RDONLY|CLOEXEC) = 3
>   root@x1:~#
> 
> So honour the request and fails when just BTF is asked and no BTF file is
> found:
> 
>   # export PAHOLE_VMLINUX_BTF_FILENAME=non-existent
>   # pahole -F btf list_head
>   pahole: couldn't find any btf debug information on this system.
>   #
> 
> Reported-by: Matthias Schwarzott <zzam@gentoo.org>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

For the series (since some of my replies didn't reach the list, apologies)

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

