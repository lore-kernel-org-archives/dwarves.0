Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1932D0CD;
	Mon, 26 Jan 2026 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424716; cv=fail; b=WGXIoLcPojrvu/mSeLEeusjOn5Uz7VJPG2OGd//rriIovvJIQl2+O1HTQySQLpA3wfaY2ZhLkzTGQQHQ1NZWDV4/xwYbxDy/nKoobhWj+5+86qNTmX+eYcj1s53BZplsFrYosVqLrbdSF6bZqwdUTZDtrK2Qdd9dW6KD8ypSSBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424716; c=relaxed/simple;
	bh=54tMq63VJMdBGm52fWDmhIzK7ydsVRq+fGCS6s8NsE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DiPhwj8BBP4cxwRYx7xnjsOmdGYfLGB148JjY/VieQ0qIO21SHGZFUGpBcSm0n2c9+wmoxew6VuVMohBuewAeBetGR/pgVbN29gV3hiRToyC2dtvS/H3/3xUppdV51Ip15umFkKedxPSaQOEgNhUlorWZryBH1D6U3wqBslAuyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tf1aloxN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WjuAebu5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tf1aloxN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WjuAebu5"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q4K00p249820;
	Mon, 26 Jan 2026 10:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LHtbaFgYJOC9uzMrVkQ0HJHTu8lyEmqP/bSeRuIpa24=; b=
	Tf1aloxNk8RuaZ1fYk2RRhHfjelDVpcU+unRaWYFhBrrGt8dlKixrOG8bSLnCQuv
	AO/1mC6C8KIPj+m7ZTu0nKNIVYv17AeaTg/g2tMnfBV7u7VnAG/MfbHU+36jSaQj
	7V6uu+fwGkkEnkkCJ/3pwqwqFrm7221/J7MpQn6U8xjpXmbneLytfhbdYQpg2iN+
	3KAfvFTWMdM/0Y/YRlQO5moOCPJ1EiTdY5wuYXwfwpIJuW9Ip+IQyZC3PzKLgw9F
	HCSjWWqZS3zTG5+rcLF5vVA3Ei7mptyBtupT2Bw20qhRYVTjcsnTNCVXFEvM5/oD
	xMS1uNWtLDBmCG/0X/D8lw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny1pcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 10:51:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60Q9VUHV010549;
	Mon, 26 Jan 2026 10:51:40 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh7tsbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 10:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6J12GacluHWCpFgk7mxD1zuEZc6q4t0F+UyGwzMlieCUX0URBAxhlDjuCqc6ulQCm5XGoNOb2m1RkyMlXQQScmQ5B9CDNTaknnvpyAWIA7Rsv6LVWRnDJmrykuKAAFbhHt6cP5+qSy845COI8WmDaioPJ8cDyPKc4bPGR0lBXlYYbWfTej5EZMFlv9GIyC8u1dIjPldMSDJWg45yQCTmw3R3Cx7HwGXj3W0uO95k8OTUzmUg9xRgWnvfYGOT3iHd8TM69+Z32cg9xkB6qMNGP42IkzldcT1iIsQpt/5QiDeVVIf+yrNtFJit3XN8lOdyoFwq9h9CUTjFjx87ST+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHtbaFgYJOC9uzMrVkQ0HJHTu8lyEmqP/bSeRuIpa24=;
 b=IXpXKKw2NtC6uHLnyiXV24ONaUPGKBketiqHmPm/17fUkKHtidNoUl3GkV5u6Esmuf2JthTrjXb4PsMb8vcEIAfBfqgtMrnBb6FUb0mf+IE0J5BrRRftVdo2rjJfVMn+/HOPl4jBZNFJMSaRJhmq7zLeraZPzM2yMsazioOxLio+ho4DAkiUqpwLtbFJOP2dAeGtxRk/nZHQoFIZ1TavZP0bF8XkapecGq/k1/bqMXsZlVweNbwpyDZ6R9x0AjLfMAkaZ1ahkGvFCnXzF/ye3TQTSa4/zt4ptIv2gMRnUfRGPnpTXiudgk0GlaDUoFg9TNIyv+8OHSLVmRCpo/KDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHtbaFgYJOC9uzMrVkQ0HJHTu8lyEmqP/bSeRuIpa24=;
 b=WjuAebu5uMeFba8ZfVc3q2P6ziof788eccjaE0lfhmKiaKJSXMQfRSnFBwz1nnn4uF8pouGKY7KmFguVm5gdcUEYCRPstf/UkiYOQUybksrJOdN+aFoC8l7PADugMdUvQHNgii6XTO6YeI8DCmiH1m1UGpVdmCeyHhyYj0jYX1g=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by PH7PR10MB6458.namprd10.prod.outlook.com (2603:10b6:510:1ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:51:36 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:51:36 +0000
Message-ID: <e7345200-ce29-4077-9d2f-7d7e4b47ca79@oracle.com>
Date: Mon, 26 Jan 2026 10:51:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 4/5] man-pages: document true_signature
 btf_feature
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: yonghong.song@linux.dev, ihor.solodrai@linux.dev, eddyz87@gmail.com,
        jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
        david.faust@oracle.com, dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-5-alan.maguire@oracle.com>
 <aXc7uFtOhE7bSZnw@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aXc7uFtOhE7bSZnw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::8) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|PH7PR10MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bc0e2f-f203-4901-9f9c-08de5cc8e045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3ZBK1VySmNlVEFLMnlDUHJNUlMxcTRYVXRnZzNKbG05OFJCWHVNM2ZFbVdM?=
 =?utf-8?B?a0VlVlpHcHVPZGJyS0ZnUHBTSU83ZE10RFZ5RzR3R1I3NWhOeVlaSUIzdE1y?=
 =?utf-8?B?a1ptRUxoUFRnVnA1eWkxaVdlV1YzZml1dGRsdzBvdS9hSytweHd2ME9RQ0Ew?=
 =?utf-8?B?dDFqUVloekpBaHRDbWwvSlk2djBUcXZrNTJhRzlaSzcvMy9SN2hLdVlhbXov?=
 =?utf-8?B?Z1lJYnlYSGF0RThUd3JOandpbUFJWFpBSHBLZWx1eFBUN0xQWXpSUGtUVGJi?=
 =?utf-8?B?VlFEMW9ZL0M2MzBKRHNBTEpJK1FGVGtOVGR4blJLVG50US84L0dnWEc5WTRG?=
 =?utf-8?B?cjhNZGJoMW1WRUIwdFFQY3k3RVFENHR6Skw2Rk5UUE1tWEZOWC81S1lnRHU3?=
 =?utf-8?B?T0hJSFM4TFJiN2ZMdFBOZzVnSXZJUXdwY2RXWjFGellFMytmd0xkb09ZN2tZ?=
 =?utf-8?B?WCtSVE1Ld08vREl1M0xveUFtNUZtMGFDQ3phYjZFRGdUQnZkWjRKVFpXL25x?=
 =?utf-8?B?VTJvSHUrSHo4VXZRdGhDdTJqck93SmlDUWtXYTcyT1M3SnlLaTZJTnpHNTky?=
 =?utf-8?B?dHdNM1FCYlpQRTNpcVdDQzBFbExhNXlNdEpsWGNRazB0UFlIbVptSVozQjUx?=
 =?utf-8?B?TmJyamc3aUE4REpZdWQ0dE1VR0pjMWVrRm5QdnJtQVh4RCtmdHpQODlDTFU4?=
 =?utf-8?B?SVo0M3c4STVjWXg0NXlsajdnSjg2V2VPdkxkUGt2eTRMRTZTYjE1RWNHQjFF?=
 =?utf-8?B?TFl3NmVlQloybzUwL1dDb3ZxT0x6R3g0WU5xeFc4U01ubVJzTDNxMWFyeDRK?=
 =?utf-8?B?VWNrUngwdk90Zmp2TC93OWxDb0VtNmkwRHkxZFR6MXVld0pkUkxqcDh0MmJM?=
 =?utf-8?B?a1RhL0pHUTFnbkgwbVB6SXBKTm5HeDFRR3Q3R1UyRUdHTzRnMzA3VENlaGVQ?=
 =?utf-8?B?MmNkV2w5YTdES0NUejRmbzh4Y05KYzBmQ0NrUFBjMGhjajJqZVFqT0J0aHhm?=
 =?utf-8?B?THBUdmdubFFEdUlQT2RWbVgvUTF5UEtEYzlJS1RLdUNLb2RPc0QydFRVSDVV?=
 =?utf-8?B?RzhHSUMzdk1wM1NDby9UcDY3MkZjY2RhTENwUHZ5Rm1QWjRYbkpWRzFQdy9l?=
 =?utf-8?B?RzlleEZwNzdnUXp5TTh0REQvb0hyNndaSmZvM2xORStWeVdjK1V5VXV1U0t4?=
 =?utf-8?B?WUErUGJpbkVRYXdudTV3NjJYNk05VjU3engzdlFpRzFQL2hYNURkTnlwY0lx?=
 =?utf-8?B?Qk1PWVBJT0Ivdkk5eFgvT1VsZTd1TUtYbVZqVG44Y084V3ZlMWptenUrSXRy?=
 =?utf-8?B?SkM5cTV5elE2UEFTZGRDNXQwajZmdndTc29VRHJKcEphUndrcVUydndtczR1?=
 =?utf-8?B?ZGhrUVgvcWVvdmY5ckJtc0ZPaVMxblJMZDgzUmViYUFwTzRyRnBabFVPbzR3?=
 =?utf-8?B?OXpFRWpVTXBqZ29hc2NCcjdYY3czeWZpcDMrQThsWVVUOTVYeUNzbWtzbEFy?=
 =?utf-8?B?R0JZNGNtK1I0a29yS21vNm9ZSmNuOGdrampydzdGM0pHY3hINEZOR01rUVBW?=
 =?utf-8?B?UlV0UzB0b1FzRjV5bEZGZGVrNllFa1U4YURGbi95SCtKQ1QzMWZwMElwdWU0?=
 =?utf-8?B?QmVwTE9nZ2s3OVdQMTZZMC8vdEltMHlQa0NnUkNqTUdqRG14YXZjR1ZmVEl4?=
 =?utf-8?B?QXcrR25WYm5WRlFaNnF3VkoyTnpRQk5JTnRFSWYvbW40d0hnSDVnR3dETFZp?=
 =?utf-8?B?YmE0UWtqZnpMZ3hBWlFZYWJiRHFjOXVYZzBCVU9uanlscTgrUUUvVENWNmRy?=
 =?utf-8?B?WHNESC9Va2F4VHdjazZYTDlZUHdlQUs2VThTTlBpcmpEdEV5MCsvS3kveURt?=
 =?utf-8?B?R3ltbG52RXcrdmZuRExwUXIrWk4vZjhFemJCdUdLYVBTQWF5aStHQytwZm5l?=
 =?utf-8?B?TmJObzFZRk1oRVRwUWVZSEFnL1I3VjVyN2JtMGZyNWE1UnNGZE1IVnlYblBH?=
 =?utf-8?B?bmdwUG1vWndVN3BiY0U1aFhpdG1xYzlxSVY0VCtmYTFYa0NQUXBTakE1RGxi?=
 =?utf-8?B?MDJYVzE1UndxTXJ5YklzWW95bDR1MjBaN0ovV0cyeU9qT2tmbFNoRFVXOFVJ?=
 =?utf-8?Q?AUWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1hiTVQvNEpSZTRRWHRiaE5VTHFLb3ArbkVTMFZodmRzK294SU9WNitGSFQ1?=
 =?utf-8?B?djdQOXRIU21ibWQ4bGsxbTc3RFVYZ3FiV1B5QmtKcUhxKy9zWXJFUjhjUEZm?=
 =?utf-8?B?VFdSNFRqdUlJMmx0TzYyREVlNTRZQm9FT0RyUkNxZmpsbTY0bklLVkxqY1p5?=
 =?utf-8?B?ODFRQlpiQXFJeEdDOXFzT2hXbUFNWjdienhDbmJZVHlvZEdWMHdIUmYvUjQr?=
 =?utf-8?B?UTZKSC95RXlCTkJjMzV4QU1wQk1nZ3hIdEhFWTZrcm1CeHo3Y2lvVThpUlNv?=
 =?utf-8?B?MnBrUFk4OTVENHk1aTdNRUsrVVNHanBRRlpWdkZIaDNxZGhQQ3RIWVlnZyti?=
 =?utf-8?B?emJFUWxIL3RnNy9uWEw5VTNyZitGdEZaWGJseUtSTzJXdVk1aVJxZk0xS2Fa?=
 =?utf-8?B?RDNNRWVzUkFxRDAvbjRZaHExV3VESDN4MThkMkl0MzFtL2EzQVJ2TXpEN0V3?=
 =?utf-8?B?eGY2clJFa1llZ0ZyUnFsbUZ6MDJoT0UrRkVMb0tCY1lSWnZ3MFhrUFBIREVr?=
 =?utf-8?B?eEQrSTBHeld5QnRtVXprYmFnMlB4UWpuLzVVU0FQYWQ4MGhEV3hNMWt2L3dn?=
 =?utf-8?B?SEtXa25ZZTVuN0JkVjNMcVg2RjUvWDgvUTBvOUtwRTIxVUFFODZGQ05TQmZu?=
 =?utf-8?B?c1ZkbitTU2RaOHV5UGtaQ2RWOVUrdzdKYzFpTHBobDhuQVVheG9tTHpReVR2?=
 =?utf-8?B?VkFVbWtBK2h1cXE2czcvL3VBM2RlZlBud0RTUVAvMkZzUmRyZ3luRW9lNW1h?=
 =?utf-8?B?L3lSZTd0a0NXT3RXMkF6Tjh5WGJ1bmFyKysxSjdsQUcrcDdoY09SMm5pN0Zh?=
 =?utf-8?B?S2JVQzFMQm5WQnZYSWRuTzRhZlgyMHJueXVQZUduejhxejdMZzNGaGU2Wjg5?=
 =?utf-8?B?N2JwUisycHQzWmNRbGNCOWN3bzZmVkxPWDhNTmtHSGt5QXA4UGRSZ1oxSExt?=
 =?utf-8?B?Q0M0Zmw5c3JTY3pwbXo3SktuamdwNTZqWUhDbHhSOE1sSndrN29jZm1yVUtz?=
 =?utf-8?B?VHVQSldaRklDRklJVlpMRDhSQnlqTGZyZHN0ckwvK3ozRGtOYUM5NGloQjND?=
 =?utf-8?B?bkZvN2pBOEViR09WS2VFWmlsbWtlU1paUXZjelRsdTNHYjVUUHlJNkFoSTVZ?=
 =?utf-8?B?MXVLdU5UaU83NllJYThrS3B6VVlKc0RURVB1UnlobWw2N294dEw1L3lIY05O?=
 =?utf-8?B?RW1CZ3JNNzEzQU5nRVBNenNDUFh5bDBVM1Y3b3ZtczhFc1FDS29DL01GdFBB?=
 =?utf-8?B?bS9ibnBDOXdQQzM4SlQ1T3lldDN0Nlk4a25Fanp1cTVFejBqRGtRN01nRzdW?=
 =?utf-8?B?RjRxb3poZGxkd1RmTEpiWXcvRGsvSk5QUlJOc2pLM3ZQWkZpeEg3TmFPcy85?=
 =?utf-8?B?YjQrMFBLK2hGQmpydU56U0t2Vld4YzFYZmFiK0QrOG84dzlCZTdaNWo4SDg2?=
 =?utf-8?B?OEVaNGQ3SXd0SWEyTDFONFFpOGRCUnBJTFF1R0pxOEZ1cGJySUxtUHRMSlpJ?=
 =?utf-8?B?RnBsZmFtMTZhS1hvOFhrMXptNWNKZ2I3UDBXb0JtMzhUY1IrZUZRdTlWcWlr?=
 =?utf-8?B?TlptWEZML2xKRDFVU3E2Zld4RmlnYWhJaXB2MnVYZjU5NzVzWkwrTGZ3cW5R?=
 =?utf-8?B?bjhmUWJYTnN6T0pTZHdHQW9CZVliZkpsV3B3UEErQVdaL21xZkV4U1BvdzRZ?=
 =?utf-8?B?YjMvQnd4QzR2NFQxZkNRcitxSFdSQlNUQU5Bam1hTCtKTlhkYUMvT1lsWGR2?=
 =?utf-8?B?NDdTSGNrdkhIQXVCcXZvZ0M4Tk1mKzk3UmMzM2V3N0tFUWR4dG5DejJHYm0r?=
 =?utf-8?B?UFlsLytySkdPczVseFAyQ25Pc2FiT1ppRWxUQlRUVGl6UmNzOGNZVDExSnhl?=
 =?utf-8?B?ZzBSZEVTQkkrcU5uVis5aDh2QWl2SEl1eHRlMVhobHplNThTOVJ2MzQ3RlF5?=
 =?utf-8?B?UlRtdVNtZERtaS95VGMwVHFUb0gxVzNOT0FjVWxmMkplckc2eHoxd3RJQXF4?=
 =?utf-8?B?WGR1ckNjOWkyQTEzNCtnWkZyVlNtWE53Y0pRTTFjeVpkRVFHbHpKQ2ltQ1dT?=
 =?utf-8?B?ejRMTHZ4VVdDVUFkOGxjR3FFVnl4RWpnSHNjbm1oZHZwZUdtWDAxME9jbXFS?=
 =?utf-8?B?RVhyeURoVktaLzk5Z29XUGtMYTlPVGRZM2pSN3F0N2VnbGJyd1E4VkJQYTda?=
 =?utf-8?B?SHZneWdlU3orUHZZOU1hRStvaVN0V0R4QUIvSUs1enBhejNWRVdZNWtpaUZG?=
 =?utf-8?B?Q0JwU2kraUwvUFpEbGh5eHdWeDFwZXFIUmh2RXlwSjJEME5GaGRLYVdON1lQ?=
 =?utf-8?B?cUZYQnZ6dTVDWDNXL0EyLzVVZTRxZmF2RFF4Nks0eGgveDJQMWxqdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5bCwoMiEUCRBexvFCgCvNbviedAFu8NyIrkRPIFsSfYuXHP11ZC7hRVQJurpATsapoCWbL4uA53gOL8h6WZSslcKcuCSfaeZIhgF9eOroEMt4WRVEx+WPgo8cbfAl4rf04wfP2+zRAZwzF0lTH0L61L8p9c4gUt7+wpOp/BmtM12H0zTTlS1oEma/KlvvAJTv13OiNJXw/H+DdGfSc2cCgZzk/6jPt7wXHWEJPJi699MwFDochaDYTXvgkvuN/wTk2PresVfTjakcJRriTRehvkE+35O148vYjOqnQqViQeskzF0UK3hXF3CJI3lLKFaSUBu0zuyWk6zpRg2k0/eWD56HKewvrjnvr6vp/+7Mctlx7QDDiyaTvtQMxoguYjKnBaIblDi+SwvU9AdyJFFLvKp6lgZNq8b1NSVu80IQnfGvaFMp2mPqisxm5Wnhb22bbxMp+q2UzP/n1j3G6RPqsvZiBrGmUT40UgB8zEMFu+Gx7YlrkT1eXJuR4kPVFrGKtadgWlUpKIMnZ/HcBKS9BUJsuj6unahdiSo7Yc137hHGbfyknKJ/lP180QT04LxAsKRZ/ZRkme7MZzEv7fl+Ke3gloQoQvAOCoN5aa2WlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bc0e2f-f203-4901-9f9c-08de5cc8e045
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:51:36.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLZ697y+hEfBZPvOcnAt6BSo8RC5dtHEeLt5irJH9NfAI8F2rmV2o36k2t9g57ZCkm4VFY+BqP0hKNvnMoQMLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA5MiBTYWx0ZWRfX0pEUmro08ZqY
 tCChMKhMBd7rkrAJgIjUdQG+1M7IHWJGxANslpUAbQwXKQjvvxnOruSE+amMzuuBB9ZRl1T8wtT
 ClmKWiIe4HuMz/oiuCd4XgPFDlESFPjX77zlQwlQw74aQ95enkb9nOpW5MhnfWE81SbP7CTB8tS
 VsjuO5X8E+ldQHYfArdiZrb0Sn9JEiKH/t7LegFH4PmjW2hRX/9bl8GOl9aQw2W5xPImFmzapoT
 t/YraRUad0Va0rp1UZ80LZlkGK7FVfbvuJdbXhATKpHwt2CsWyjdVLLaFgWXplgt7DtENJG7MB2
 +vecRHte6GcwtA6xDE5Ac13alp1ft0fYDLvAZpeN0TNOWuw5KGyD6BR9olPQubfSGJ8UwIBncoc
 m0xAQ+DOpu7vmx5+1xlZaW8NiQDNBZsQw2cjyd6DfGx4Culg3L2qyOcCxYkGvgdMPI4KYvmj/A4
 2Mrhv5ku02g/NHj7wkQ==
X-Proofpoint-GUID: xeF4079EAdfMAaer093kHkhF_9Z7rDup
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=6977473d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=7B_1JeXpxYlMO_RTTPcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xeF4079EAdfMAaer093kHkhF_9Z7rDup

On 26/01/2026 10:02, Matt Bobrowski wrote:
> On Fri, Jan 23, 2026 at 05:26:49PM +0000, Alan Maguire wrote:
>> Ensure non-default "true_signature" feature is documented in
>> the manual page.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Acked-by: Matt Bobrowski <mattbobrowski@google.com>
> 
>> ---
>>  man-pages/pahole.1 | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index 3125de3..90a8f45 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -337,6 +337,11 @@ Supported non-standard features (not enabled for 'default')
>>  	                   of split BTF with a possibly changed base, storing
>>  	                   it in a .BTF.base ELF section.
>>  	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
>> +	true_signature     Encode functions ensuring that binary-level
>> +	                   (rather than source-level) signatures are used;
> 									 ^
> 									 within the generated BTF.
> 									 
>> +                           for gcc these are ".isra.0" and ".costprop.0"
>> +                           optimized functions
> 
> For BTF generation, would there ever be a situation whereby we
> wouldn't want true signature support? I'm just trying to understand
> why this isn't defaulted to true.

The key reason is the "." in the name for gcc-optimized functions
"function.isra.0" ; older kernels will reject BTF function names with 
a "." in them, so we have to guard against new pahole with the feature
enabled by default being run on older kernels. So by having the newer
kernels request the feature only we avoid this.
