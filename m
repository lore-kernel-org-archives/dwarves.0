Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86D3FD957;
	Sat,  3 Oct 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791022448; cv=fail; b=r1jz4GsN2su8C+gIDOEFXlusVXdQrbOM1Kt+CDeZcqPn6Xts3avGH2u0wx4BGDZKcL+il6Rg8fT6naBTyDKN+oPgIbLHd45qgeZbzWGoETlibS1M5LqEaUpPEhDyr1MDdrDNSZyHUwRqMIR3vmro4rdE/yrIpqMoSVHRukz+c4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791022448; c=relaxed/simple;
	bh=NetZqI1+Z/XTdsBxLeto7TBJcvcL8LSiVWXk3WAamyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n7P4/hwPyrbvf5KzAh9U+VyfRiNxih2vkXTMAHiysiJq0Xg6rU3JVU0GoL83vg2M8rDjyBgiPlpOYPqTh6P9cKmkQZjq7Gai2S9Kb+9Wah01pa4JZZe5bHWxpZXbFX6YOdR4FvPALk0kMUC7hQvlWYFNdiijjpdsZZhliSBlIlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ep7yKmM/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lJ+3EQWz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ep7yKmM/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lJ+3EQWz"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6939KbJ5850506;
	Sat, 3 Oct 2026 10:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hAEeMuG5/fU6liTLKPqrqxahR+zlitnQW8vL0t7OYv4=; b=
	Ep7yKmM/B4sabOkIcTlQ1NuOxlCju/iLf6r2SD11W0WEY/BlrY7Qkv2PuVtF1+tH
	ID4m3BzxGoLLk1PYstZeURFBhXyFwuoPALzB6VKpIabT4ThNty601USRAV9oAiwG
	SgMGvdsGCj0ysvj0JAQmoTN8D1YUffjxR3jmZlSJvHRwa9Bt2Pbz3vRBiTmvN7SU
	CWSt79ylo9q9XvqMKTm/2QnHoKr7Vl4iyH/4poWo49Op4/bMlgoAnpB03wEnfXq3
	WmRoZM3icAuCNrXZPew+DGd9mLwQSX3VeWOIW3gx6wDxARSHMzMAVjM7YA7+qyMN
	QEDeeqNgF18femtH8vH6Nw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2r4b86eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 10:13:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693A5NF9029166;
	Sat, 3 Oct 2026 10:13:53 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r5m7tea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 03 Oct 2026 10:13:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNEr1XLiMrmu9R/dVxwMyUtXU2adUCPYnh9VqXdvxwZdYkrdh4Hga8wkda4K9AGS1tMJ3WHFxGXoi8Cp6gjvZNr+/Rgl71rjv0gnn+ETNuKKtuL7JERSduTUpRZUOJxqf8/5aRwCkFNIwtiveaE7S8aFge437a8t+x7RMPHfVvA5vL+NjhhEWTYKs76k2+YE+xjtCuROf/XY6BIkY41htN9Irlfqh6B4q1TBGfhx8BFye6sxSWaNPLbL04ysVy0ZLykrye2XmYdBGi5sHdj6AdG/cAMzhjYfQPwElwtgtRC9xOv9bXyW21wUvpKwpmomvkeNztAfkI61QhDNIUby8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAEeMuG5/fU6liTLKPqrqxahR+zlitnQW8vL0t7OYv4=;
 b=xdQ1JswsShOIY5AYLKvLRwAM4PSpGDupXHPHdc67WjpqAVJXxNwy1ZIWqiwajAfW66vUmo9YL0Iul0TzPpegaLCFeKlxqy68z2ycCa+Gpxh7I3WRRVDBUUqDXTWrl9bF6XFJ/fcRhLwpydOWk8ZJmgN4HRWs+DtAehI/MDABKbSaCxJxYZ2QgvKFAJ8gGuwoGbUZmrmY4n6sgzdw9h7hsrmWu/ox0TcpltA1RvcXMYyfbFHfydkXD3HH6DKmr3+YoxuqYdOHngr3DuoYkfdYQtjxz/Nb5UG/OYxaoYHJNNYwnGGIy/0okftAx04SoWE61iZsv8AmV2WMhErY0PB3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAEeMuG5/fU6liTLKPqrqxahR+zlitnQW8vL0t7OYv4=;
 b=lJ+3EQWzyWgalrAjudUmbMFGYAvtihpAL7aEgfLQ3HCxCuG1Y4/0jb2xBZvpz0/LeShMYCyeQKt1neWR8Db5ptV91zj7spe5ipK1mQwgOWCV1tp4M3P19E/oA64OKJ3Yh+e0/ANSOPonm6JuYHWqi8DJWm8IGMbKLRCdOFrXBNk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SA1PR10MB997628.namprd10.prod.outlook.com (2603:10b6:806:4b6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Sat, 3 Oct
 2026 10:13:51 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Sat, 3 Oct 2026
 10:13:51 +0000
Message-ID: <b845d224-fc7e-4789-b7cb-8decb3c9520d@oracle.com>
Date: Sat, 3 Oct 2026 11:13:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] dwarf_loader: Limit parameter location analysis
 to x86_64 and arm64
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Nathan Chancellor <nathan@kernel.org>
References: <20261003084357.4185491-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20261003084357.4185491-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::9) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SA1PR10MB997628:EE_
X-MS-Office365-Filtering-Correlation-Id: 502f2cda-a927-46f2-a50e-08df2137059a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|22082099003|18002099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	NMO/k03CxNCLuX1vk/mGho8lKPh/VXmpg+04XZ0RYhnE33U3P+s/VFtBmpRX8tOS68KPvNulAPtP8i7brXKp4CrVouxYRWGixXj1/SOZ0ilhg2fOXUDV3xRYZonfRUzdiEmPD26RdiS42kM/tjDHkBVcwtd46k2hiqhzxiHpocziUHUF4o+v44y3Z3QybtS7SW0De1R9QcUMpzZq+qv8Fj4+AManStnZkPez+3SSbxdl2zEP01UAFPzxROtmvkjzZVZNxOxgwGRwHFApzChI8Q8OYctR4UjHl+muNtfSvcERTSqcY1XvyDRu1IO7G8G/eMuP2uDWYagv5ba8CP11HT0H45I+t2Xz16ps1OP3BkoFDXaXiar/uWnWZBwAsvz18iK992Jm0v4mPmyIMExRvvF1qJfwnbWc+wfamIMtEjy6ajiN878YCHuymR3YuEJrRTjhVK/0oMAAtLCbSwDi2yO88JR93L7JhVQm6O5eHzWiUpsLzWDEQ1FVfA/GdnS+TvzID+gg+jUwD9MYOCUW1MhHR3yMUgk4Gz9T9iiLOXr+gt21dUS5XMULTXSEdjvOwqywPxMnsitlqki6rZXnhAB01FoOJL31Sdnw3QWBjMTOvfk2xI5usMkuRQm/WEjU9UdoBUsdNkxGUB4/wtGpkrdlwUS6CLaqQ9ksKxfsd6Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anFRazlPN1ZWNlhqNnZjV29DYXVUM0pZSHdnemNReUFxcjhDNXJzZHVsL2lZ?=
 =?utf-8?B?MUpLK3NneFVJTnBmbitLbHBBOW02eEJIYWtWM2ZTeVdFUE5XZWF3Nmt0b3FL?=
 =?utf-8?B?anVrTWZvcjVLMjRUNEZEYTlDVFRORTh1cDdUZUVtdjFlZGE3S2pBTHBpMlZX?=
 =?utf-8?B?a3Vub0hmOG9Zbk93UWpLOVhsZGQ5YU5wL0Y5TmNtc25kTExuNjVMeDQyWHR4?=
 =?utf-8?B?TkVob0pJSm5YMTRIVFNCUzB2ZFlCaTR3dVFaaUFWT0JnRG9IZEw0SmdMdTdw?=
 =?utf-8?B?akJ2bVI0TUU5QzBOeFB2QS9kSzV6Rm11YUxBU1B4c2pTOVlWZ2FqNVdDYVNn?=
 =?utf-8?B?L01HbkFGc3JLUGxQWWFvaEZydFhKRDg1VG9aVEUxQkR6T25RUGhUaldtWS9a?=
 =?utf-8?B?R0RibGF4dTNMYVVSbmppUS9IQ1hyQjNyMlBtM2o3MUtNam1tNFhsQWNlSHUr?=
 =?utf-8?B?bjhwZFVLQlM5Mm1ROFRvRFU3QldRUHlvZzNORzI2ZEF0UFBKMTFiL25Fejdw?=
 =?utf-8?B?Y3BpUHVkdS9UQlJJUjd2ZTVxdkp2djFxTlhMVVBJa25jTldwdWo0UXc1ZXVp?=
 =?utf-8?B?b1hMTjhXVkZrUisrTW0veWRnOHl6T1BKQy9naUtmMnpZcWx4d2U3elQ0KzNw?=
 =?utf-8?B?SjUxUXNraDlBQ2JQTTdQYVFreXZOYzdpb1MxNWpPQnc3ZU5SQ2ZGM0V4bmNw?=
 =?utf-8?B?NW5adlhHa3dYdHZJU1U4VXE2Tk56WUxZOW1pREYrODlzTlBqMVVXQU9sN1d6?=
 =?utf-8?B?R3NOOXdhcGZpRUJBWmF2cWJrRi85Y3NJcUNpVDNTdlVPYWxBQXp2Zm1FTHJ0?=
 =?utf-8?B?TlBZdXpJM3Y0WUVlQVgvQUxLNzBRQXoySEFkbmxha3Z2ZGY2U2RESHBFaDNi?=
 =?utf-8?B?ampKTkg0ODRnL0RHNlhnS2VERTk5K3R3VHY3S3FMTGE0OFlyczZVWDgzSU5E?=
 =?utf-8?B?MzQ3WHl4TjArZVZrL1VvTVVvM2FOT05pRWRMdWFNMUVWZkxnd0pZb05weXR5?=
 =?utf-8?B?VXJKS3dCS3grMm9EK0pwRVZ6OHNnZUJHbWt6WWdqZHEyNXcwVE12TUZ6ZzRx?=
 =?utf-8?B?dFhmeVcyelFKTWNKbHJ4WnhSMEpXanZMNTVsQVdFR3o2ZStjOHlSRUhhZmRy?=
 =?utf-8?B?TStTQ3dtUno0U1JiMXNBWFE2bkh2eDRqV2RhdTJlRGVtK3p3NENramdpcm9B?=
 =?utf-8?B?eWRqMjFyTXBIVEJ6QVhPaEl5NVhGb2p4cXhSc2lLaG9RVzBmaHVXOFRWMjhX?=
 =?utf-8?B?aWFVL0h1RjBlV0ZSZ3J5WFJ2aEJnYmMrenQwakxUUTVxYXc2MnkyNi9XbDVK?=
 =?utf-8?B?V2QzVGo0ZXF6aXZQbS9Mb2lMbVpnQTZBRnQxc1NyYWFxUy9zc1YxZjVzckJR?=
 =?utf-8?B?NnJJanJqVHJkZzQzVFR2YVB5NXA3RHNDaU05SFBwOUU3enNxbStGcGRMcitv?=
 =?utf-8?B?UFJBTk56TnFNbzZIeWlJUW9oVFZJRk4yUDZBM3JaaW8wNVdYWk1HMEF3SEhr?=
 =?utf-8?B?MmFGNVkxY0E0VS9sTEZkWjlpdXRiNzJRbjRqWW9INC9mYjQrVkUxTnR3UnVY?=
 =?utf-8?B?UmtDUjFXYVk5eVluUzAzWUgrMEJHYlk3NXdDRC85YjVKUXdjNkxXSklYRG1v?=
 =?utf-8?B?VjRWcjNmZUZDMStKQkp2VnlGdDdZdUgyeDY0eEo5TXJEaHgrZUVvMFBGaXZJ?=
 =?utf-8?B?OE1lc3hST2w2eXVzRGx5N1dPWHFvTmRPZThmTDRmTkZBSG9CRFp1a3VCOW40?=
 =?utf-8?B?NmNPWUpSd1gwQkZ0VzdZRzZNU29xcDRjQnczT2I1Q1orak9oTkdaTEhXTVBF?=
 =?utf-8?B?TVVPOVlhZHFtVzkwOUNPRVJKZFJSWm1SUmx4UElQL2lKZVVKaWZTNGNjL00z?=
 =?utf-8?B?VS9pTW9vc3NwSFJUblZ6NzN5dzBBRVQvamlaejdqVTdiOTBaT2VPREJQNk5l?=
 =?utf-8?B?aEJEMWlkcURNNGZxMkRUQXRrelFIekZDZmNtMmZzSDdZUlpudkdNL0toT1Q5?=
 =?utf-8?B?UDE2akFpUHgvVUZ5NHdXS2cyNUNTR1pQeXhDSHlSSjM4bXYxWU1IaVA1eXZ1?=
 =?utf-8?B?MkR3aWwzckVQQTE5aWFSQWFKcms2VTFUNXYwMDdxWWQza1NIOW05QkcyN3ZH?=
 =?utf-8?B?TWVXMmR2T1NtY0h0b3VaSnZ5MmtWc3R4VHA0R0pUZXVGQjdsOURJOWlXaGNZ?=
 =?utf-8?B?ekJmOTAzS2VqRWhGZktMNXJqMGpyVCtZd2RXOEhlL21sbG44K0hlSnlrQW1S?=
 =?utf-8?B?d0FpcDl6YWJERUtCaTAram1xTkR2N3RuYk5HN25rRFJTZ1ZwY2pJcUE2N0pW?=
 =?utf-8?B?QUR5cTQ2bVJ3ZndvanZ5ZDdIYnpRRUxDWkdJQmVqbEU3K0hZaGlsdz09?=
X-Exchange-RoutingPolicyChecked:
	LwdPYeYuFdg84U8jsEtR1zrzIU5aRatqJV8pA1hxGw8dDFEP9vC779DS4XcDC/Zzz0GeA5z8J2I5XN5t5KumXKhntUL/UwEA58RpdVEW3K4g9V+qCzFDMqQEL7rSfnottjjIpY2sfEFQsqknMCrF0Wo2y4S+ULeKpw5NM5P/EScjSy5i8gBoSS8cEI7VJDPf8UfILRjjHTQgpO4yNeyL0mlNAeW0vPqRIid1INYczCRQXrwLZr81JAueFNjZ2ndJf9NK+qwuvau4t5nVhmj2kGxfcChz4CVQFH0AHMBDH/9PoI0WO4k8CotaM96kRhVMdtujWT9aZf8Wc2eIW9O8IA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i5FwaSbS6aB+S8QhXYQBpqyqEWPSNik5besvizXhpHEyErWzY2fAp5sLSnXy+37GhGBJQjDRuQLdeaflyT4Sk8VtIJcNzbTNCT4ifvD+WTq3WP1lexM05xvDkdmfwlcP4B4EUTu6F7ZCOuCOhHHMCwUz2GNgiQ2+eYLOm6b5dtp57KwkG1gYF73VvwlSEqhJFOd9xnwQbfsCyCSIv+DVYd3Qcu54WdjpcN2gmQkqInhqLykE/8oHyucQ11s8xOX3R1tIK4/d2e3ADXLxG0OyQ8NFwxzRKDezFEl1JawlqcE0xff4fLJo1PX82UMHBAPfTbQj+R3wOImIrKY4TFFFYBk0hbGFgJm000XA3CCP/7Tg47lN8dOm7mnM1OTo0YHAkROyxtbSLGyJCFg/7hvRmJS61qKRHPyQ4T/yjLfy0Hc0NMIWWdLcGtpF9tH8nbywHIrxcaHDqloFlFld6n29mp6rcSAa/7I5JERg3hCEE/eEtgeLEmCV248zdE21z3og6aaK+0fULvN7OXo8h9Lrd6QDE4jyGlJ0SOECWytUy5F1mVSfeBOSJzpATmm9vCh/spNfn24EjUNI6dr/5r71WN9k2Ttl7GXsppkh2haUI40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502f2cda-a927-46f2-a50e-08df2137059a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 10:13:51.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyFJVMdRPj1VD87YPet2iiGTT7mpG3ce9z8o2IU3nMwuvLCcSF4g5QypHOzqhaM41XTYKf7b7E/q79eTyJtrkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030040
X-Proofpoint-GUID: aKVhNDllb-Wr1I53QQCKMDh5PrKa1IDd
X-Proofpoint-ORIG-GUID: aKVhNDllb-Wr1I53QQCKMDh5PrKa1IDd
X-Authority-Analysis: v=2.4 cv=BIQmP1QG c=1 sm=1 tr=0 ts=6ac0d562 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=SGzt5zz6rJIIrbZQKIYA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA0MCBTYWx0ZWRfX/8xhTyp9oZCR
 pFUfPMYtpEZw+tF0mDCBfnd2IItn1i35gq6Tcfscd5Ytkshp3EsXgOY3T8rRG0+Koc2PZgps2rc
 rjJnlJ5ZZ1e9Jg2Jq/GUcFFn4jJ++UVWdD86uhZsTgvKCxq/dEF+
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA0MCBTYWx0ZWRfX8bb7EGnshPM5
 YxAoY2x+rosePYw6+361L/C9tdCZwIN6zh0RQ4jkyeFrSsj3gPmaownlgfgFB/lTwlpQCEo8G+7
 YJN5g4vkduF6b4yMJxN/BTw7Uk3LfCcOYEvM1HU7RsPVvSQoG1B22RCCjgOI1BZ4peOUSNx7jE/
 fEBaFWd16Re2Cu1DtBKBhkBq+72Whx0TRqOuaiGcZnSoporyDziBa8vxY9A94/LljHaC3ksiaOV
 KzRVgWxg8mJHU4mryJbh/kmkV+Gbbm1u+U6ZjyOkPSAoElA09XX9vYnN3ueBkubHx147mOkm0hD
 kjJZ8bFgLf5XrMeqL9/QQ428zUnEpstIn8ta+6qGZj0iJ0BvrCTD/Dr4mCXaeq1AKlqnQ/QqWU5
 9eCRNZdbQncr9nVxdbcXU5VhlNA/FAFjNirdjTDsRmJBZNKKLL/4PczTYC29UesZ0NOazUULXBC
 TtHKwq1XbuT7D9Z0LJwl8+6AgSttxv+t/pt6udb4=

On 03/10/2026 09:43, Yonghong Song wrote:
> Since commit e96290426e18 ("dwarf_loader: Analyze per-parameter
> information for true signatures"), clang-built kernels on arm, powerpc
> and riscv lose most of their functions from BTF, and resolve_btfids
> emits thousands of warnings like:
> 
>   WARN: resolve_btfids: no BTF func for kfunc bpf_xdp_get_xfrm_state in xfrm_state_kfunc_set
>   WARN: resolve_btfids: unresolved symbol bpf_xdp_get_xfrm_state
> 
> For clang functions whose signature did not change, the new
> function__match_clang_parameter_locations() checks that each parameter
> lives in its expected ABI argument register. arch__nr_register_params()
> returns a non-zero count for powerpc, riscv, mips, arc and sparc, but
> arch__set_register_params() only fills in the register map for s390,
> x86_64, arm and arm64, leaving the other entries at -1. Every parameter
> held in a register then fails the match, the function is marked
> unexpected_reg and is skipped. The previous per-parameter check in
> parameter__new() ignored unknown expected registers, so this is a
> regression. 32-bit arm has a register map, but it does not match
> AAPCS32 (only r0-r3 carry arguments, and 64-bit arguments need an
> even/odd register pair).
> 
> The parameter location matching and true signature reconstruction have
> only been validated on x86_64 and arm64. Add cu->param_loc_supported and
> set it only for those two architectures. On other architectures, skip
> the clang register matching and do not do true signature analysis in
> the DWARF loader or the BTF encoder, keeping the basic optimized-out
> parameter detection that existed before.
> 
> With a riscv64 or powerpc64le object built by clang 22, functions such
> as int f(int a, int b) are now encoded again instead of being skipped
> with "unexpected register usage for parameter". x86_64 and arm64 output
> is unchanged, with and without true_signature.
> 
> Fixes: e96290426e180703 ("dwarf_loader: Analyze per-parameter information for true signatures")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org> # build
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Thanks; fix looks low-risk, high-value to me so I will apply shortly unless
anyone objects..

> ---
>  btf_encoder.c  |  2 +-
>  dwarf_loader.c | 23 +++++++++++++++++++++--
>  dwarves.h      |  1 +
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d6b9be6..2f137ee 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2913,7 +2913,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>  		encoder->encode_attributes = conf_load->btf_attributes;
> -		encoder->true_signature = conf_load->true_signature;
> +		encoder->true_signature = conf_load->true_signature && cu->param_loc_supported;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 1e5363a..9f9b9c9 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1518,6 +1518,22 @@ static bool arch__arg_align_two_regs(const GElf_Ehdr *ehdr)
>  	}
>  }
>  
> +/*
> + * Architectures whose argument register mapping has been validated for
> + * matching clang parameter locations and reconstructing true signatures.
> + * Other architectures keep only the basic optimized-out detection.
> + */
> +static bool arch__param_loc_supported(const GElf_Ehdr *ehdr)
> +{
> +	switch (ehdr->e_machine) {
> +	case EM_X86_64:
> +	case EM_AARCH64:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static struct template_type_param *template_type_param__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  {
>  	struct template_type_param *ttparm = tag__alloc(cu, sizeof(*ttparm));
> @@ -3777,7 +3793,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>  {
>  	struct ftype *ftype = &fn->proto;
>  	struct parameter *pos;
> -	bool true_sig_enabled = conf->true_signature && ftype->signature_changed;
> +	bool true_sig_enabled = cu->param_loc_supported && conf->true_signature &&
> +				ftype->signature_changed;
>  	bool check_locations = !cu->producer_clang || ftype->signature_changed;
>  	int reg_idx = 0;
>  
> @@ -3785,7 +3802,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>  		/* Producer is clang and the signature was not changed: match
>  		 * each parameter against its expected ABI argument register.
>  		 */
> -		function__match_clang_parameter_locations(ftype, cu);
> +		if (cu->param_loc_supported)
> +			function__match_clang_parameter_locations(ftype, cu);
>  		return;
>  	}
>  
> @@ -4533,6 +4551,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
>  	cu->nr_register_params = arch__nr_register_params(&ehdr);
>  	cu->agg_use_two_regs = arch__agg_use_two_regs(&ehdr);
>  	cu->arg_align_two_regs = arch__arg_align_two_regs(&ehdr);
> +	cu->param_loc_supported = arch__param_loc_supported(&ehdr);
>  	arch__set_register_params(&ehdr, cu);
>  	return 0;
>  }
> diff --git a/dwarves.h b/dwarves.h
> index f3453ed..6b75ece 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -305,6 +305,7 @@ struct cu {
>  	uint8_t		 producer_clang:1;
>  	uint8_t		 agg_use_two_regs:1;	/* An aggregate like {long a; long b;} */
>  	uint8_t		 arg_align_two_regs:1;	/* An over-aligned arg starts on an even register */
> +	uint8_t		 param_loc_supported:1;	/* Parameter location analysis is validated for this arch */
>  	uint8_t		 nr_register_params;
>  	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
>  	int		 functions_saved;

