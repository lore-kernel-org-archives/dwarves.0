Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BECF19066E
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570821; cv=fail; b=M1Is1WRLNkgCBGU3462P2kabO6yyFSYodEcaJGJxrgv3zD8+xNxi8oosiLS6L22103jp/IXHwvxSxBlK7KiAXA1Ih0R7I4HSxjTBgZh3SUxpBmAl5hZ8QiQQxqthL7fo0XZmr2BnmbzAoUO+ok4qZc3zdkuRdTB0wxG+zIyVeWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570821; c=relaxed/simple;
	bh=Qj/kVWmOBriI7jRJJCRUvwZucp8KZyeCFY9jkxE8G7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YJ7V1ilp26xG1sh/541jVbtyFXmI1d8PzcKRKob4sJbsQY1NTYPO3aDOuE8vBUmWfCeCOgyrjytEcPYTx/raNCrs0H9q2xoCc474dC5oPLAIchj+JPA1B8Hb60arGzny4iOLIy6sSPWGptVcDBjcwJTSxXnk5lGJV1kadMc6hO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hCJTEs0T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gAak2TuX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hCJTEs0T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gAak2TuX"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHXWNf011300;
	Mon, 25 Nov 2024 21:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FZvSuJKHVCY210j3WS1+Z61z9QDYzJ9gCgFlSPpdJPM=; b=
	hCJTEs0Tbm8sfExxKCzTC2rsvlNRnLXVIrUzU5hK90V4lOMVI9GS7aiI7lnZ5ZeP
	IRcjBQukzPPKScmSRQZLRay157WC4G8TGxXyqXi05snafD/6uJ0fqqh8XbBuKki0
	HKE95P8qoVwAxtbxQFVSBlnoozciOYNCkGN/bTQ9Ef/fZroNRXok6WUUlb4yoJco
	exUc+JO6k83L6SQyOewWgvgnqp8481Qe0G77wah7TDQoeaF3uYcCw+QR/8KFB9HX
	onsM0xXvzfKJuQllD72cEP3TfxjSXgT+cYnIs2VO37KZwnQSyjJda54pZRA/ABh1
	frrSdpzMW1WYr2DZV/jIWQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433874c709-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 21:40:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APJtrT4002614;
	Mon, 25 Nov 2024 21:40:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g8a8u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 21:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nim6Q8T6uecHs47bgs4Nr0I335UE4XGJm5cZbkWd/7r0AW8SB4frOmKwr84YBxIn+K+DVS4c9/GjeuMnJcG5Qo8dPAi0KUlAEZ4ZOJUFDYYCZ991ICS87IxCTWhby2a8ZhUUyc1+gN+BHVs3KFnRjrjWP+WAtOcJGFZuaM5v7qwqIsh0FmyWd3+QLevUPpGYPqNgg0V2UJ08uopoxFgMGHg85Oc6C2DYx7cJxH4GjIWPBQ2nRVoI+sesFpwPqVsythD2pOfmprSvQjbdbwMy1S+pEZ32boZLUnHdPps0dSHYNj6iTE6VcVkagWE2plAE8JO3hVyZE0YUivEX1r1gZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZvSuJKHVCY210j3WS1+Z61z9QDYzJ9gCgFlSPpdJPM=;
 b=nDwRbqq3aikPf1MD9GgUB431jAKTDIUg6I2iDnYQHxpdS7gAmJzUELNxDlRWZMvnYgsFana/tEb64YeTWjk4yGrJ9gQsQnR91XQRFqzpU8SyPgxo5Xi7gF4pJnZcafEF5OhnX4koyQEVgQaJ3Q9GcF3aN+b7yeFourjD+s/Wo7WEGeXDavkj6d8moG3XCZgCKMXphcxrtLN6Jw0x9PlYmKsATEU82X61zrzZt4oHryU8+KuFLf1bvIApdELwt7NdCYThKwwmqcsTnEYZGvv/B2eQaQ9QJM4TQKGZLzvY35pmEJK++Zer8WqbsobFqOMreaKoO32AcUvVdeIsLUXC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZvSuJKHVCY210j3WS1+Z61z9QDYzJ9gCgFlSPpdJPM=;
 b=gAak2TuXGYAOT+ZrT5v3uzPRVpToaeFtHryJEdpNdIstOefnmeHjxNWVaMtVJQRnvZgT/OC8afbx4EdedcZrL4+QALZ3XzEiw9HmUl/RkKKcAjHrnp2F1UQvIcYcu7+FC/jtKR9d3H0F+dKyO/gPDxQDmeTW9h/dt1I0oJ2tmGY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 21:40:11 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 21:40:11 +0000
Message-ID: <7e5d20d5-d8e1-43af-b7ad-022713080190@oracle.com>
Date: Mon, 25 Nov 2024 21:40:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3] Respect CMAKE_INSTALL_LIBDIR
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ben Olson <matthew.olson@intel.com>
Cc: dwarves@vger.kernel.org, brandon.kammerdiener@intel.com
References: <Z0TefTqE9Xqx0Gz0@bolson-desk> <Z0TuO4iXUK-kgTqb@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z0TuO4iXUK-kgTqb@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0133.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA3PR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fe888d-8c03-4fd9-e845-08dd0d99bd23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a29tbWkwSURTa3poaGdGTHdKcmt4T2FqNW8xU2poZm5uMndaQWJYVVp2bHJl?=
 =?utf-8?B?dFU2SFhRUzQ3akI5a2dYc2k5dnljeWxtU2cxaUtCMkNQbDhESnlTL3dmMGcw?=
 =?utf-8?B?TWo2M3YxTlpFRG1KMG1YckdObytPa2FtOEZtcU5SMjNoTUlQd0Y4SmlNTkRq?=
 =?utf-8?B?SXpPQ0FhMjJ0V3hFbGtMdFJWTDQ3YnJRQ1Y5TTJsT2pSWTM0OHpZeWEzRUtS?=
 =?utf-8?B?UmVUTWF3YlFDN09ZMXdZMU5sVFpUdDF6L3N5N002blJNYW1RNkl6eDdVYkJN?=
 =?utf-8?B?ajZyRENVV3Y2amRlM1l6TFoxSlhRR081eFFwN2o2L25PYnVET003WFdNK3FN?=
 =?utf-8?B?bEJFb1hBL1ZIWkl5WFBpdm14VUZwYmJqWXdBSlAyV2trTTRkVWpzOTdjWnc5?=
 =?utf-8?B?Q1lNd2lqSm5YODZaVnhVd09XczRjMHZabmt2MGI5Yy9zRmFtVHV0aEpLY0M0?=
 =?utf-8?B?azNDbG8wY0VXTkJzTEl0OWhGZUJzdTJORzk0TjIvVUdUMWdJQXhBeFdseXEx?=
 =?utf-8?B?ejlQSEg4UlQ0bnJqMDlIZVliUStZdEVFN2ZzV1lta3BTMHllcUp2QytyYjFH?=
 =?utf-8?B?Q3J5TS9zY0ZMQUtwaUc1N1ZnbEl4bmRsT2MxemQ3TzFIbk83QXdlT0o4ckhW?=
 =?utf-8?B?QVkvaE8wUjZjOTdVREVTMUJSOCtlNWZ6SktiZURuZ0VFV0xEUVpGRlV3RjJh?=
 =?utf-8?B?ejNJS1RSdk10VnhSR0hzVlhZaTVFWUJ0aElNS3RNMVErTjc1VTdzSzVPYjV2?=
 =?utf-8?B?a29KdWRHQnNmczNEWERQcGNVR2VFb0tZNUZXZGg5N0d2WVo0NEdEb0ZDb2Jy?=
 =?utf-8?B?a0pDQldHUWFZYVk1Q1QrUzVMdlFPdzA3TFRLS2prOFhmYmNtZmJjRmZVb3FD?=
 =?utf-8?B?VDhHQ3Y3U3VZemUzU08yMVF5UDkraHZQRnF0WnVwVkduL0gwVk8yeGw5WkJi?=
 =?utf-8?B?RXlPOVpadUFyRnFOQTBZcUpxVEJ2SFBkSWNZQXJkaERDdlBrZkt2ZmY4N21X?=
 =?utf-8?B?SjdBRnUvV05UL1JrZ2lGVlBUUElNdEowYWxzekY0VkhhbXh3Q2FheThqVTJK?=
 =?utf-8?B?ZCtUc3VDaVBsV1JUT082LzdKeWhrS1YzRy9QKzN0TUpHS0VpKzZoUUV4VHQr?=
 =?utf-8?B?ODAzNCt4eTlZeUNWVWoxVTQ4OGVJK0xvOFNXRk5CYUdVd2pjb05Ea0c1dENV?=
 =?utf-8?B?WU1OOHl3S2Nodzd4dmplak5TZlJpMWFSUmNCbEp1KzQxMkRTdFRSY2FOYWJs?=
 =?utf-8?B?aHE4cEVaMGMwNG1aOFU3UnhMUVhxOTA3bzlkZ25qc08xSzE4LzhRb1VBY04v?=
 =?utf-8?B?M1hVSWNaV0xkOXY2cUM5Vk1ITXhuN1lSYmlHTTRQcDB5dEJOQjE1dXRYR3Fv?=
 =?utf-8?B?VnR3Vng1L0NPcXNmVFBPNFZaVUd2ZG5CNHJyL1lZLzFNL3ZyM2dncWpYdTJK?=
 =?utf-8?B?V1NHUnRqQlV1RUNmbm1XNi93dUdwSWUxSEl1UFNQa3dYc0pDWUpJd3VLeERs?=
 =?utf-8?B?ZWdNSVhTSTZYcGRDcWtmRGU5RG10RHdQd2FVYUhDcDJCTDFBVzU2UXhoanZ0?=
 =?utf-8?B?NmFkeDhpL3ZyU3ZWWTViOUNHclp6OEJQM2VNb1R5T3lrTHgyeThWaWFqVVlx?=
 =?utf-8?B?NTVxMW5lSjhRa2txWUlPS1dFbDZyNUZJUjkwYkV1UzJjT0MyWkkwbUgwM016?=
 =?utf-8?B?WVhyb0ZuUW5RSTdhcUIyUEJFZ25KRFhkNy9CRWdYc0N4dFJIMm9Fd3o5cUVn?=
 =?utf-8?B?TitXL205bWY0elBqZ1JWYjdQVFlieVJJSW8xbG5IQjB2aHl4eGl5b3JIY1FX?=
 =?utf-8?B?SnRPUHc4RVBMa3BXcWY5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVF0UU9FS1dyS01rSEloTkRCbjVwSmxKeVhMU1lrcUpLOGxodlg4bzJsN1J0?=
 =?utf-8?B?L0tML09yUTlxaTJYeDRpcUtnL0FuWE9oQlpiL3VEcmtPU1p6enhYY0R2UXZh?=
 =?utf-8?B?bjFhc0hqM1RQcHNmdXdKUWVjekZMcHgxUHZmZW5kRWordEI5eTRLVHU5dHJS?=
 =?utf-8?B?SVJweVR1RjFxeDBrWWVEV1JyUmlqcCt2aDdWQ0lFam5DdURqV0JxQVhCQmFm?=
 =?utf-8?B?d0ZBQ3RlcnoyZDlzZG9jZHd0VTBiazJRNWtDWVM2L0RTSzlaWWpHa1N6VFBQ?=
 =?utf-8?B?N25wdENjdDFzNWJQVEg2REljR3BQUG5SQTJmV2hQeUJOWk5Xc1hJSWY3RFpV?=
 =?utf-8?B?WmtVeTBXNTNoS0Fsa05sM1BBcHB0YUR0bDMxNFNiMjFhMDNxQnZ5ekwxcllR?=
 =?utf-8?B?d1pTWDkrcjJKSTRIVVgyWWhOZTVJUnhaaHFyZGsxVWJGZmwvSnlNWkxpeDBa?=
 =?utf-8?B?R2FFWFZtZUlSOVY0Y3pycS9ONlFwVzZUazNEeXdVMUk3RUdCcGpNSUNGbFZk?=
 =?utf-8?B?VjFRRUhoZUpEaEZ3MGpjeEsxeFRiRjVBYWR6VHNFM2FVUjIxOFBDaER0MUVP?=
 =?utf-8?B?RlFpVkVqVG1OSWxIR0FjaDliTG5KSWEyOTVJZ1NMUVBpdytJS3BZMHprQkQv?=
 =?utf-8?B?T1lOeVJoYnBQTGxYQUV6TmwxTmZVb2l3T0hYYzUzTGRhZVdhN1ZWVEpyd2h0?=
 =?utf-8?B?UmpHdVZJWWp2aGFyZzBNeUJ6YzJ5VTU3b1d1SkN5MUJjeGpEL3V4YkRBQm9O?=
 =?utf-8?B?OVBDbmY4N3hXcHdoeWRSWE1PUWpEdVZ5blA2K2Q2a1duQ05od1VSdjRleWZO?=
 =?utf-8?B?bXAvMHNkd3pxUHBYOEVDQUg5ZVV5R3JUcjZNY0sxK0VaempsbmY2MlVLekJQ?=
 =?utf-8?B?ekxoY0pjWDNFWS8yazl0bTg5VTNnWjl6bW5MR0dNQlM1ZUgrRHFNV3l2VHh4?=
 =?utf-8?B?QkJ4amFhOHlSMGtzSkZyQWpEVVE0bjNHR3RzNXZVNitjNThTaGxSMzNCZG1Z?=
 =?utf-8?B?RkpnWVZQR1BRYTZDR1dWOEp5SUkzR3BheTZUS1lXZUUxNlErZ0dIQ29Qd1pY?=
 =?utf-8?B?ZmxIczl1dkdLRjlwL1BpWW5BM0NtV09GcU0wT0hlQ2JWVlhrZXZkaDhScFBX?=
 =?utf-8?B?bS9sbGZULzgxL3lmWUxKN0lkL1dVazc1UnBRbXlNSjdZNERWVmI0RGNCYTJh?=
 =?utf-8?B?Q2haZHMvL1J4YjNmYVFLeFVuMVhwczJJOHl3RmNkN2NTS0RJNFRFRFZERllN?=
 =?utf-8?B?SS9URC9ZQkpFcFF2a0dMOUhUMmIraUhJaFdiZERyNFRkd2k4ZXJZNTBYQmlt?=
 =?utf-8?B?S2lkK2ttTXFUWFJLbzdnaU5vWXE4REZGbzZMd1hRNEcvTnFBTTgra2VrcFo4?=
 =?utf-8?B?V3RLa3d2d3pMYTJPb0wvbUk2YkVYTlpOeTROQncwUFVBOUwwUS8zTlROYWFS?=
 =?utf-8?B?cWFsVVlTRXFYZWtmREtIcmM1V282eXVucGRQeVdaVmp0OGZHYVlpU3FydWM3?=
 =?utf-8?B?dFN0OXhGeVBrL1RGZFV1dnVLU1pNNEVQSnVuNjRHVDM5YkwxcEV6U2V2eUpO?=
 =?utf-8?B?U0tTMVFNaTAxai84Q29uVUtra3h2aEJkYzU2MTNrRG0wcDdYcG1vbDV1dUJr?=
 =?utf-8?B?eW1ONVcxdlVvSW1KMEdPMkQrV0hYOXByZUlnN0JaTTJKYVRzc3d5aG5rMUd3?=
 =?utf-8?B?SEpzbFNQZnRWU3NVT0pGTEt1Y0wzNmgzNFVMSEI4VkV3T25hMDEwYWJ4YXVM?=
 =?utf-8?B?Q2dkRWpjNHlLejhoTUlUK2NLaU1qbmkyREIrSmw3cUllTmpZa0VQbGV6Wnkr?=
 =?utf-8?B?bi9vdUdsdHFTRHFBNUFtMVJzd1hJTmFKcmN6MkVtZ29iQWNNcmJ6ZWhZUkFZ?=
 =?utf-8?B?d2l6cFpvZEdXTjJ2cklXdk0rcThEZEdGcUVjM3ZwTENOWlF1Wmw2ZzNQc1ZP?=
 =?utf-8?B?NnNKYmU2aTZlQlpaZ0tsM2E3ZnBGK1RTVGlOcXJNbkpiMDJ2S3g5YTk1cFMy?=
 =?utf-8?B?U1VQbjVPd3d5TGNhejdpTXVUTTUzNGxucmVCc2RmbFJSV0ZjYUtaT0hGU25I?=
 =?utf-8?B?NkpwdG1jVU9uZVY4c3NKbnZTaDQ3WXFQeWJYWlp6SERoTXpyeU1sQkdqT3BW?=
 =?utf-8?B?Y2V5Z0l6bGI1bUgxK3RyVXRVMGJFc1ZtMTYvb2pUVEhkd0I2T21FTjdrZEdC?=
 =?utf-8?Q?F9w8AMBEZRAN5b2Rt9QTquY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8Ob4X/TChVX0CjkSnIjCWvFVX7jz2EGQrzn1jxCg/YzTojxmUIZBtZVIikwhyfdq82PLuC5fnymDWv5keTufF5clO9IUR9dyFDqQ8OMEC+V4M3e7P0ps86cgMne+omfHfzTcKyIuzFXIXJPgFfNiiYP8608opr79AAcGRSOGIWW2actuCpf86Uq9Tu0RAL2gwIwSI3zm6kEE8wA2JdWJbowaZQy+BGMLm2gLG/18TSn/uRiU+rdKIx3sQWx90QjnEzjPBJo8GmXx6sC2oaq9r19As6+anwVJIcG7I2CnHJQYFfiozFEaAuhryRrbPHaS//gPa1chMuvdDr9Oxv9+fuPNj5Jak96sTPdYYeYmH2A1c/YXLBbgIW7dFf4Qa1VbAvLEMe+OMuETKJvqHhogGABgFhfqSCI0myg1ScHh1tQFGrDW21hullGZ78pN2Zw+w76rQGGs+egUC+CJHml9HN5H47cglH7EnrnW75V+hPlAUOznd/C/DECZl1wNJtRkfwD2BmWgKtQSQ7tI0iwXwHu73+vQLCwC2DrlRGK1jrXYW+U4JZd0I+Bo1N7krHcmqUgHdHkrDfWjK6BkLllgJZ7XRewg/qjMMGA5XOdJhi0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fe888d-8c03-4fd9-e845-08dd0d99bd23
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 21:40:11.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcjEps041Ac87dt3gLrAH6hfxVRikDTAyRl6NTlvpTuMZkwZgzmrdvzW9wumeDvVux/BW8SEyXbnxBA5pmLaRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_13,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411250180
X-Proofpoint-GUID: mG-1Ot9w6Ek2TKfXNwBCvF2qTXPdHh_E
X-Proofpoint-ORIG-GUID: mG-1Ot9w6Ek2TKfXNwBCvF2qTXPdHh_E

On 25/11/2024 21:38, Arnaldo Carvalho de Melo wrote:
> On Mon, Nov 25, 2024 at 02:30:53PM -0600, Ben Olson wrote:
>> This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
>> and use either `lib` or `lib64` by default so that installations match the
>> conventional placement of libraries.
>> For example, it will now install `libdwarves.so` into `${PREFIX}/lib` or
>> `${PREFIX}/lib64`, depending on the distribution.
>>
>> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
>> Signed-off-by: Ben Olson <matthew.olson@intel.com>
>> Cc: Alan Maguire <alan.maguire@oracle.com>
> 
> Alan, can I keep your tags?
>

sure, I think we need a small fixup to ensure we keep the step 4
(cmake ..) in the instructions though; otherwise looks perfect!

> - Arnaldo
> 
>> ---
>>
>> Changes in v3:
>>   - Added additional change in README
>>   
>> Changes in v2:
>>   - Included the proper built-in CMake module
>>   - Made commit message distro-agnostic
>>
>>
>>  CMakeLists.txt | 19 ++++++-------------
>>  README         |  5 ++---
>>  2 files changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/CMakeLists.txt b/CMakeLists.txt
>> index 8ca1bf2..1d0dadf 100644
>> --- a/CMakeLists.txt
>> +++ b/CMakeLists.txt
>> @@ -21,18 +21,9 @@ else()
>>  	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
>>  endif()
>>  
>> -# Try to parse this later, Helio just showed me a KDE4 example to support
>> -# x86-64 builds.
>> -# the following are directories where stuff will be installed to
>> -set(__LIB "" CACHE STRING "Define suffix of directory name (32/64)" )
>> -
>> -macro(_set_fancy _var _value _comment)
>> -	if (NOT DEFINED ${_var})
>> -		set(${_var} ${_value})
>> -	else (NOT DEFINED ${_var})
>> -		set(${_var} "${${_var}}" CACHE PATH "${_comment}")
>> -	endif (NOT DEFINED ${_var})
>> -endmacro(_set_fancy)
>> +# Use the standard library installation directory
>> +include(GNUInstallDirs)
>> +set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
>>  
>>  # where to look first for cmake modules,
>>  # before ${CMAKE_ROOT}/Modules/ is checked
>> @@ -84,7 +75,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
>>  	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
>>  endif()
>>  
>> -_set_fancy(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${__LIB}" "libdir")
>> +if (NOT DEFINED LIB_INSTALL_DIR)
>> +    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
>> +endif()
>>  
>>  # libbpf uses reallocarray, which is not available in all versions of glibc
>>  # libbpf's include/tools/libc_compat.h provides implementation, but needs
>> diff --git a/README b/README
>> index f9aeef7..e9f860a 100644
>> --- a/README
>> +++ b/README
>> @@ -3,8 +3,7 @@ Build instructions:
>>  1. install cmake
>>  2. mkdir build
>>  3. cd build
>> -4. cmake -D__LIB=lib ..
>> -5. make install
>> +4. make install
>>  
>>  cmake Options:
>>    -DBUILD_SHARED_LIBS
>> @@ -12,7 +11,7 @@ cmake Options:
>>      Use -DBUILD_SHARED_LIBS=OFF while invoking cmake to create STATIC libraries
>>      and link applications to it.
>>  
>> -    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
>> +    Ex. cmake -DBUILD_SHARED_LIBS=OFF ..
>>  
>>    -DCMAKE_INSTALL_PREFIX
>>      Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
>> -- 
>> 2.47.0

