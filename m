Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B5183CC3
	for <dwarves@vger.kernel.org>; Fri, 23 May 2025 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998379; cv=fail; b=k83WONc/GexWByXXJ8nP7uW3TOJPlcRerElHgBiuR+JLo5fRdHESAdtKK9Bgqcmzahn6zU2eNlOOxycDS7Hr1jBhtoLLYEvlMBv3fjnJ8UEFdVV75OdAuv0+DRh9T6pBHofael+WVgzt28hf8u86IQKCG4ULIhPpvrBOW5dNnlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998379; c=relaxed/simple;
	bh=ZV/afhQbPs0tg51SJcYeYIXJgZ0GrzZY0mCjYBbrEKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IW80ljvOKiGgNjl78+R2Vjon1lvmjHvOGz1CcCBAgrPdJcJGe47Gqc20kjXO7447ud86HY/4FboPByHShd6GBTwi9oZT1gFhrbFmpIO9R9gpABt6v7/rvXF0W6XtdhCqMfcMACrtAuexNnoVAMqbYDKpmG+jgLUlIfMm1U9u644=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=So8z7epj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qICLsODF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="So8z7epj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qICLsODF"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NA8U02028033;
	Fri, 23 May 2025 11:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ka7e9b1Z9CYMoP5I0CveRYEMACNyxP7BiLt/q48MQcY=; b=
	So8z7epjnd4b90295U2ObtLNwgdbSH6p8RHRJwLuFampC48PgqtYw/jq3dH5t2v1
	aijLMhxVLZhGM+A6Lnzq9j2b1/hgExziOeRFkn8AIamqRESJKGHp81puGU/2f/Ue
	uAO8g4/+KDK5UydCA9xK7nCFfXmycgKDT5++WABqCE69hqsjeRjfdAYDX7tbMvoa
	y4wAejjWdjL5oZ3CltZ6HyHZq2Rhyd+m4KIVvJwI1p/RJJVsKw605QC49HwA8BZa
	QyIeov+bSloh7yP7IRTRheSjOME45h5Sb1bQTeBhdurjKK5aIWxbjHuvJCwko4Uv
	iEKpRWwpl8Ih8G3qE4UWPg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46tq0jr3y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 11:06:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9a52n033586;
	Fri, 23 May 2025 11:06:03 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rweqt4xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 11:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQX+uoHhFJoXaq2uJY1rycfL/aWcYyWxHNWYpBgdrSjPM7sjJuSKQtxDLantujc4xI0W02QrBLqgQQDScOdQW/R8wjCAUxdY/ChbsA8BJV1wSGRVVgpLcDIm+uY/V0yJgnTLNs6PUudCqUELwZhkcVPIthVXjtCGvlQgLmrcWQ98b9c1DeqCbDwjzPs4BRafGTyXUH6Ugn+UzHBm0qIqOpK+jU/vUBfbWeiWd0rWFRysh86AaRhWYuGXnDD0SAhdV2XFgZt7bBILiObw46yJCsysfD+XzlA8bE+4N7njRmqBMa4Is9kOSHIkO+ZE6V334V8Mk8/EGsdYq+n7231YIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka7e9b1Z9CYMoP5I0CveRYEMACNyxP7BiLt/q48MQcY=;
 b=WKRnj6IkryFf5Si3CT+LLwXi48vda1WM+JDVW9lm9higxcZFmdo9gzR2rC6wwDtlD0t6tJ6vg3l74an7k9F4mZ9HIonUJCH0QvTJ6wXUgv4spJ5VsdR36m6TqMNDtc0CjWIJTs5kjkRYkaie2Um2lCDpttuMyWBZ4Bw18aLFwWVETEXedJW7Hh62lDXZTtZCbDFBmCs23ddmBFGMKApvB7XBruiRZkbkrKuF0k5JXWIDiaH9RWbYz5SIw8aiaP6xof3YgoWbHuWpIoXlLhiewgvFD+9VG+6glIFzs/ALddaxeKV8wIMsJcbcrLdaVmSwgksVs3oyLVhzPkXEgX/ghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka7e9b1Z9CYMoP5I0CveRYEMACNyxP7BiLt/q48MQcY=;
 b=qICLsODFGTSM5gezjcgOfIQKla5rJ8TWziuaRkniT/mRjkk1cjHVOQGkmrsJwuiEWxIRFQ+YycPh93Q8Yp11koGbOjF7hwS+WMYniNhzjwis782lOhKQwx6D9ZBwWLk9+2UI4iZOFd9MaAGwv+0KXxq35+cWKo/JHA9SmYPBZ58=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 11:06:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8746.032; Fri, 23 May 2025
 11:06:00 +0000
Message-ID: <5b737d77-6db1-4e63-91dc-68b48e5367bb@oracle.com>
Date: Fri, 23 May 2025 12:05:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] CMakeLists.txt: Remove custom `LIB_INSTALL_DIR` handling
To: Paul Menzel <pmenzel@molgen.mpg.de>, dwarves@vger.kernel.org
Cc: Ben Olson <matthew.olson@intel.com>,
        Brandon Kammerdiener <brandon.kammerdiener@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ben Olson <matthew.olson@intel.com>
References: <20250420064220.81114-2-pmenzel@molgen.mpg.de>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250420064220.81114-2-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 795955aa-7758-460c-56f9-08dd99e9cd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkNuQjBmSlNreGVBemsvTkRWb212ckdyVTMzelEvb2RjUGdDNG92K2hKdnJV?=
 =?utf-8?B?MnFjRlFKWHZGS3J6eFVMVGd6VGFac2YyZHRyZ1hOUFBPanFWYll1VnZYWEVN?=
 =?utf-8?B?NFpmbkZPYmlzcVlrbG1DMHJJSnBYNTlSNjlVZXl0Y2VvV0Q2UjdYK0JSdG44?=
 =?utf-8?B?bnpESkZvL2VjRVhWNHJ6NllMVGRXb00rYS9yVmoxQnRQRUpTNlRubXJFVHNw?=
 =?utf-8?B?ZCtNTkl3UUhoSnVTQU5XaWNZMVJxUytUNDJpc0pORzM3aDV4aVhCT0FUZ214?=
 =?utf-8?B?ZGxDTUp2NXRhbmV0M0M5c0xHem9TM3Z0S2RKZWdBeDAwT0dqWEJSZGtzbHlr?=
 =?utf-8?B?Q05ERjFHVDBmY2dCU1pjMXo4eVdRb2YvdUgwWXVQWGY4SzhyN0pwRTRNVzRQ?=
 =?utf-8?B?Zlp3V2U2c3M0cDlzbHV2OG9IL2I3cHlaRS9hYzZ2QmdwNWFJSUFJRHdaSFo1?=
 =?utf-8?B?QWgvNHM1blk5eW1VVnc0cEN6UktTV3k5K3lnSzBLaERDUzl1ck1kYUl4N05W?=
 =?utf-8?B?VXMrTk9IMmE4VjNqc1lNUXhJMGRKam5BRS9BbjBITlhkNWFTMFRoZllGZEJn?=
 =?utf-8?B?NHBWREoxTXRUOUdFWWp0Q003VVdTNC9vWndhYWpVMGIxbFUrNUM0NmFIeWpy?=
 =?utf-8?B?akw5d0wxOVJjMVlEZEhTWkFXeUZtRm51TSs1MGduczF1RFpLbmI3b3gvSTcy?=
 =?utf-8?B?Qm9iU1pLTVNrd04wTlpBZjAvN1hIVmJudldJSVYyRWdPWWQ5Z2JpNUNpQVhL?=
 =?utf-8?B?Q3NKdEVCL1JUL21CMVFTVzJWZ1pmcWVmT3ptZTBrSmRaQmhMdXFWUUtnRHk4?=
 =?utf-8?B?ekUwRUVlUFYzMnVSaEQ5VldBbG5wRGlGRmxnNlJRUTVkUkk2bWh0VWhRc0ZR?=
 =?utf-8?B?MmRPZHdMcnU4SkJsa3JpOFBUZk91T2lndkkzTmRJeC9ZdzFyVXJTMVNCYXpI?=
 =?utf-8?B?WnhrVzkzUHFOS0xzdkNKWk9iUFVwVXA1RW1FY2hLUUFBa0xHKzk4aGZHdmJP?=
 =?utf-8?B?cG56V2NFWnR5U1B3OWo0T3JybUJySDBEVlZNT2FRUlBWS2NPOXZTVytkS3pB?=
 =?utf-8?B?U0JVd3pmV1VmM0kwTnlyTWI1YTRDQ2RON0ViQXQ5LzUwZFNUcmFwK1JKRlZE?=
 =?utf-8?B?K2oyK2RQWWdndnY4aG1YcVVjd1NJclZqbUQrRkFEUmZHTkJ5Tng4WXFESHpF?=
 =?utf-8?B?TUpBZ3FQNTdLMzg4NGhzbGdKZG1yTFQwdzZWTzZVWUlvMXQ2MjRUMjUzWVhP?=
 =?utf-8?B?ZzNLVmV3elk1WnlhQm0vUUlZWmZEWWtrVmRZRHZDL1ZXWWE4eE5OanBMRXBT?=
 =?utf-8?B?ajhjbFFCdUxhdncwVzVaVzV5WTRESithWjNWWVVjQlpWRlJDVGVFVy9GSkdB?=
 =?utf-8?B?OUZHa1I1Ky9Ed0thUEZzVnVoVnVzYzRhWWNIajlieW5OSWlMWFY0bXJBckY0?=
 =?utf-8?B?QXJxY0dOclpIZ1NSZTBDaDMzVHJ5UVYzWmZHOWRCNHR2L0M0N3Uwa3JFRUJJ?=
 =?utf-8?B?MzJmcmlySnlCd0xMRS9JUi9YSXdPTXY3blA0Qy9DUW5ZYTJUbDFmc05TaWlm?=
 =?utf-8?B?WnIvZG5ySVdpQlZEYTFoS3BTT3NENE9OazVNaHFrbTZPcTFHSm1zU3hWU1VY?=
 =?utf-8?B?NVRtMHhmM2hMQ01NMjdoZm5mUXN5MDhmVTF3bkxPenM4eWUvQ1FLVHByV3Bz?=
 =?utf-8?B?SnRXR3AyZmpkTGdYTUZTUVlhNVBTRCt5ekZsZHF0b1hTZVpkNnJPYUNLd1BE?=
 =?utf-8?B?TjVEUTdwcWpWMmdRVTl4Z2tMZnliS29lWk1ndEpzaytROU9XZmxUOGpYWFlu?=
 =?utf-8?B?a3U1dkdZbmEwSVRqQUYraTBzYlVVWWhVdmxTeVFYTWtHOGhLT2F4ak5jaDVs?=
 =?utf-8?Q?7SAgJKgWD1JhK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHhKMXRtUzJNTkZSdXpaMnh5ajJzUjBGckVheGd2b3JxV3UvaEtYZDVYVUFV?=
 =?utf-8?B?cFc4ZmJobk5MaFVXODNOUEFOTFBsMTBiTGdydWp2SnA1SWt3d3RXZHJsd2g4?=
 =?utf-8?B?OEVNTDl0ZVhOWU8xZEMzWlJaOE0zRHozNjBSUmFZdXQ1WXRrdCtqZTNQbHJw?=
 =?utf-8?B?c0MvZEdPeEVpRGgwQVRpTi9xWGtubjQraE9mSkZFbU4ranBzSE1LR215cENa?=
 =?utf-8?B?UG5BdjJlSENvOUZxb1JFSitNQkVhbUxHOVZVVVBYR1dwVnRhQlJyazRKYWpC?=
 =?utf-8?B?azl3K0c1OE44LzJTRDg4T3lqemQvRkM2MTZCWnAvM01kZmZmcEdXN1FqY0Jk?=
 =?utf-8?B?S2d4Q3ptQ1Q3d01RQ0ZOM1gwU24zT283TXRMWE92NG01RFpuRk1WdW9ISXVD?=
 =?utf-8?B?WThsL29aV2JzZEFtWEc0VmFEYWV0ZkZnMjRiNDFSUG02UnF4SllPUnZ5UUg4?=
 =?utf-8?B?Zm1JTTNtd3pTVDBZNjcrQXlDRnBiU1N3NGZ1blc5M05sR2Q2S1RBbm14a1dZ?=
 =?utf-8?B?OUxFZWlPam1nU0JvZHpzd1RXUDFUb29xUnFMWUZjd0Jkam5KRHdPVTh0RmNG?=
 =?utf-8?B?V0pLRE85dlBMSURBbVRtRnZRMUhaUXhZSENTRGJoTEkzTXQxR3M5dE8rb0lQ?=
 =?utf-8?B?VVlIaGVDL1ZBekRSRFpLZEsxNk93S25SS1N6NEJVZElXK1BSZkNxZnJZQU1k?=
 =?utf-8?B?a1RmbHBITDJIazljelRCbTVPbDE3L1ZnUmtMb25LbVFkUzdjQnY3eFA3dmJo?=
 =?utf-8?B?UTFpVWt3OXFoaThYRGg2cnVlL2lnMlBmWlBGWnp2Zk0zUlV1cFp6V21hYWdF?=
 =?utf-8?B?TnZ1clRTUlRDUjFnd0M5VWE3cWQrVlIzbnJMbWw3RGJvdkpnOFc3L0s0Vm94?=
 =?utf-8?B?ZjU3bVpadVRrbG43TkxjbGVicU1BZE1va3FZRWlRL0ttT1VrbEFzanNteVNZ?=
 =?utf-8?B?N3Y1YTcvWWRBMGZ3MVVUSjNVKzZMU0VaQ1F4c3lCL0JuVGlTcE4rQ3h1a3By?=
 =?utf-8?B?YXRCaWRURnFoMGVQeFVrcmwvZ1lyZWoyYXlpcmZRdW8xNTJEWEdyM0p4NnV2?=
 =?utf-8?B?YkdUNERvUEgrSDF2MVFNc0ZyQ2s3WlhpWW1aOENoUTVGcHV3aTlnY01iNE9t?=
 =?utf-8?B?ZjAxZFpkMUNBM1Y1SnFOUitlQ0xlSW1OQWZwV1JieWpydHlMK3h5d0xsdVA1?=
 =?utf-8?B?NnY4VjF5Y1hQU29aODdMY0k5cngrWUlZSE5wZHlZSVhrY1d5b21scVYxQk94?=
 =?utf-8?B?dzFWQW90dlFoblNHemtNZVIrOGJNTzdRTnNHMUwzbXBBL3dIVFJvTTUxK2lF?=
 =?utf-8?B?eFltU0g5M3JBYWpkYmVaRzM2dWVlNTcvVSs0TDAyTlhiZ2xWRWU4NzdPK3I4?=
 =?utf-8?B?QTdzcEJwbStUeFdqaE41b0I1QlpXZnZVelBNZVh2Y0M4TGc5OVZENU1US0NS?=
 =?utf-8?B?U3lxT0pIWUQxRjFEek85eHJnL2FobzRVT0ZPVDhZbGg1YnJDbVExTWNaSGN0?=
 =?utf-8?B?bk96L0JLQmxDMUdEb2IzNC9WOFNJQmtONVIzVzZXQ1poc0ZVdWNpblVHS2Vw?=
 =?utf-8?B?ZGxENHVVOHJFOTlYVHZTekZOTkN6TXZXOGdqNk1MdTF0QVF6a2paR3VhWUJL?=
 =?utf-8?B?bVNkd1E5TUxDbDR3OGUxV2pVSHlXYU5BK2dNZWhoVWJCSDRsd2hQcTVpQ0dI?=
 =?utf-8?B?aUdxZ1EycWN6Z1JzdzVPaFNRQ203Y3JNa2ZIZUxWYmVwYUhaN1pJbVdybFho?=
 =?utf-8?B?NU1FdktZQ1ZjeFMveklRK1BtUzJ6WU1BMkZFVU5EZW9IY0Z4QjRNRktteVRn?=
 =?utf-8?B?YXY3R3UwVHMzeXk5ZUpEaU5lUTBITitSMGNJTzFqQXZlU2hpL3QzUDlJTndm?=
 =?utf-8?B?RmJpa25hbTlsQk1NS0doMXpKak51ZitTdmxTekV4TU0rbnN6N3RMMURINjU4?=
 =?utf-8?B?YnJZQS9LeWFVU09NUXAwaldhUjYvQWJtTDhyWmUzRk9kYlI3RmlUVVBkTlpP?=
 =?utf-8?B?T1c5SzJmWnJaU2U4VHJjZXlmcU52bS9EdFk0UEV6ZzQ3SGxrWnlFSjBXd3NL?=
 =?utf-8?B?ZjE1VzVBdG9LS1M4Mzc0MFNiOEpnTlI2OEhwK1FtR01mTU1WUUVoV1hSMytz?=
 =?utf-8?B?WlhWYVJrNUozNnBRT0pmRkw0T2ZrQm5ydzMwVVNDUUs0bmhpd2crTlYwZ2VW?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N4m8XThxUZCPTqs5J9XHQepHPyDA3BV8D2lWoJv6qbe+JQKzNHczF6R5p3Sv3SVVjPtlAizuFBTksmoXv8jHliDByHv1aYLNgh4EBeOoIO9xwJHhMPkmNq6oliq+BT7W+yZVCIBU+JNk1zIuO2aPxtIkAhP3X5vQgbZLUlOlopyPRjYU+na76mJudV44SAEc1S9uQvVorBMz0oSnPCU0A+Yzg/mmCJRXSqeynGYktoB67dH+3GNitNz+Osuf6keXZKG1AwxkkfBe/dw+IkW7lA1nFL4/tf7RozQQKb/uTkjVhXN6DmCjbbblRSYkpA7vKCWN0R0H4H8PzV9Qx6m6lw8fL6mJdcVii3313jmx24rLW/LHvdEFKGq0XDyrqyEGm7ao2yeY1GqxmPj6iSCCxt8/vjbk31bN/W2QzrQXz5a6Mo9p6I2UFuVfNwn9vnTQPZOMY/QfMpMLcrnHJ1FgVbHUiCZtivVLNV3fVvwk3YN9O/EARRWKQl8wCG3yjqvOS+bjXedWf+h9qU7EhFh8tJ8+SiwPD+PfIXR5w8EPgabYCELys6fT8nEJB+Mv6x32bAQYL3Pha3g1WneZFffJ7H2xOeSjclHmxS7ekAeFJQY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795955aa-7758-460c-56f9-08dd99e9cd09
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 11:06:00.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TRXwCmKfi7tWf1LiqdlrKz6CfbI3JqdIGEwmi50xeQfmsFN3NCzhYuOpyJGXn1meUgkNtkRs27bBzQg4nHw3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230097
X-Proofpoint-GUID: GjcZ7mOdbd9ULLrTHiYzGDxveh4qVjsP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA5NyBTYWx0ZWRfX3dqvd6XzfSY9 ioigWlZUSBHqkx9s14ZwJUyL4AzzEGL5SJDmjnMnEfNn2bWePdHqjrBbhuvc+be4hfagCnIy8hF BnDWey+Al2N4vzuMusxrnnGn3pQiQPh1ZFc+kaxRhkh5FifA+M+fEPfLEclwgAzE2gPM6jpWNEX
 ESoS+c9OaMEZOMPQPXIEZrHFGYSEAo+uixczxvUs/KSWyLkTp851DnIo/ZzqfL2SXfaYMrKmhDq Rkzo+fdFtRUg3Z9/qONddTD9ZB2WyypJpfYGp97x99NmT5ke0PlMuiV88M3jJR3sguAzYpRNKuv txeQo5CXuTwReH8BWhWS65TkPOms0rJAr52CtEQHfsjVlMefCwg4+9TxE1mQZ7OIkNqj7/BcgDK
 fZSmARBh5rrYdDzpiafzO7PnRbwcE2WS7BE02i4xZvNPA13VwNtvXuA9UtM3Bhtus4hIyftc
X-Proofpoint-ORIG-GUID: GjcZ7mOdbd9ULLrTHiYzGDxveh4qVjsP
X-Authority-Analysis: v=2.4 cv=AY+xH2XG c=1 sm=1 tr=0 ts=6830569c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=f1hami8VAAAA:8 a=VwQbUJbxAAAA:8 a=jcb1ZoXaaXgvJ1QxxgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O4tMhvHXPDgA:10 a=FMFxGtP9trmfb28vA-lX:22

On 20/04/2025 07:42, Paul Menzel wrote:
> There is no need to explicitly set `LIB_INSTALL_DIR`, as CMake’s module
> GNUInstallDirs sets it itself from `CMAKE_INSTALL_LIBDIR`, and takes
> care of everything, so the line below is enough.
> 
>     cmake -DLIBBPF_EMBEDDED=OFF -DCMAKE_INSTALL_LIBDIR=lib ..
> 
> Note, it’s common to set it to a relative path, but absolute paths are
> allowed too.
> 
>     cmake -DLIBBPF_EMBEDDED=OFF -DCMAKE_INSTALL_LIBDIR=/opt/usr/lib64 ..
> 
> From the [CMake documentation][1]:
> 
>> CMAKE_INSTALL_<dir>
>>
>> Destination for files of a given type. This value may be passed to the
>> DESTINATION options of install() commands for the corresponding file type.
>> It should be a path relative to the installation prefix so that it can be
>> converted to an absolute path in a relocatable way.
>>
>> While absolute paths are allowed, they are not recommended as they do not
>> work with the cmake --install command's --prefix option, or with the cpack
>> installer generators. In particular, there is no need to make paths
>> absolute by prepending CMAKE_INSTALL_PREFIX; this prefix is used by
>> default if the DESTINATION is a relative path.
> 
> So, remove the custom handling from `CMakeLists.txt`. Also, update
> `README` and mention the option.
> 
> [1]: https://cmake.org/cmake/help/v3.31/module/GNUInstallDirs.html
> 
> Link: https://lore.kernel.org/all/9fb4f7ba-0de1-4f75-9bd2-66212ca8cd86@molgen.mpg.de/
> Fixes: a2abd9482162 ("CMakeList.txt: Respect CMAKE_INSTALL_LIBDIR")
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Sorry Paul, left you hanging here. Above seems reasonable - any issues
with this from anyone (I've cc'ed Ben who made changes in this area before)?

If not I'll apply early next week. Thanks!

Alan

> ---
>  CMakeLists.txt | 5 -----
>  README         | 4 ++++
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index eb87300..844ab61 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -23,7 +23,6 @@ endif()
>  
>  # Use the standard library installation directory
>  include(GNUInstallDirs)
> -set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
>  
>  # where to look first for cmake modules,
>  # before ${CMAKE_ROOT}/Modules/ is checked
> @@ -75,10 +74,6 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
>  	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
>  endif()
>  
> -if (NOT DEFINED LIB_INSTALL_DIR)
> -    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
> -endif()
> -
>  # libbpf uses reallocarray, which is not available in all versions of glibc
>  # libbpf's include/tools/libc_compat.h provides implementation, but needs
>  # COMPACT_NEED_REALLOCARRAY to be set
> diff --git a/README b/README
> index a938266..fb92d68 100644
> --- a/README
> +++ b/README
> @@ -18,6 +18,10 @@ cmake Options:
>      Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
>      when invoking cmake to specify another install location.
>  
> +  -DCMAKE_INSTALL_LIBDIR
> +    Default is to install to lib or lib64, use -DCMAKE_INSTALL_LIBDIR=
> +    when invoking cmake to specify another install location.
> +
>  You may need to update the libbpf git submodule:
>  
>  git submodule update --init --recursive

