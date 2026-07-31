Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C333BE652;
	Fri, 31 Jul 2026 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492682; cv=fail; b=WPOvu2rA3M54jGOsCHp4r78rMjcwkfgYGKZw9+J/595GQqYFhaAQrf9oxU6glGJkGo0Uy0KEarihhs8RH0aoUgZzM8n7Oj686qG7MkmcLXHV9ZU9rVAELEP0fpY/WFvM3Rd6D1hLZ6MIehsHDI7BtefoXlV4B0gTjFoGZrn2Z18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492682; c=relaxed/simple;
	bh=E48NLNuC8YhEcaIFLENKQGNjv3Ux32ZVWT7/8pI0b0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dc01Mbpv6ZDEpAKl8uDraYY+j9hhP8THuDNSnyRqX/WQ/nuBdPJOBRm8GhhAAgTTLWHufvCM8i6jRwj9TIwLuNN9MgBtSphr6LsIE5ifblxcmhMORdaBOMWS+sfap8frDoSy4MBbJjZJlefAmW+EA4SWxd+QBfNGHVTVaR8ij3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bCu+Z3Yy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZrkyB8z9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bCu+Z3Yy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZrkyB8z9"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V1UlMP2516422;
	Fri, 31 Jul 2026 10:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KL35WgBmGXn/0wZtVpKGuDLNomkYug934gPQq2ufGIY=; b=
	bCu+Z3YyPKgIHNa8jDa1oOtDiUAyEeTNCqW/fNl6ZbOGrPqFYu5CnJ2xBgqp6JPM
	ST28X3ATgDxo9Ngq0Y8OUzdh+Zvxk1MB+dHOMBSkP6kLxkYQFC4lPDpnrfljsXWx
	oDPfIK+Uqd2tKyl7qevMn8/tMghI7rm8jF0A7ohZ8t8S8DHPcT+IXywjKgTn4v9S
	LLK++yl1UrFojq2WVyLftJFJxGdZhCv6aagQuDaJEiBHCvCNIts/jA5aZ3Ye57q0
	gwGlPsIpPi94SNnuJxYrgc7i3DtpMFNjzOODRar0bV9iBattKLLF+89xlmlOfZ4Q
	uJ2OgsX1E9EeIO7i3HTMcA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr1dhej5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 10:10:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66VAA575034542;
	Fri, 31 Jul 2026 10:10:57 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fqjww7ff0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 10:10:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjCwAFnyN3UcLa7IHn6TqoWtYSkb2Ne6ciQyiZqOA2Bx6NUB9ZglgGkGwMTGg3te7QxtCCFFKNq9qmRkestBY2Z1kq3YQhmmkFWVcMthvJgYdeDvxmANj9Ti+F+KaxWZc3phRLtpBR9VlYKtOC6SXmnRP5A3IVXAh+V+sY7iXiMiFSmaGzbZePrv4/DhneI1EzXOkSlYXy8DMU1qmiAbijciyBYwpN0zjNMItts7mm28mDtVKZNqxELLhX4TaSB+w5BerByDXF5NV977uvVVMxxp2DhcCz4sEiE3WaOHYGCbZqhzCwJVOqPN73e3dEAV/8vVEGVP15afpg5JjnHXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL35WgBmGXn/0wZtVpKGuDLNomkYug934gPQq2ufGIY=;
 b=JzG57w2ekpMqQmfePtPiOGEnNwlzuNJpOiWxYXokqpAJ2AB75udKejulJeboVxov8GRa7gYy8aDOAhyWV5lptBDNUVYS2nFpq5yixR41mvwCdKHMYjBwH7lZHScPWkNgUcoLYVYphnR609IUwvwjuzHCp8C+feDp16HWqnVnRR2Uo+vU78pzzyh7ssADbpt9VEOMT86FwLM8ASNN9E/ZBFmlTIhxPxTmbHI6ubUabF4Y5vGWxqdy42ZSoDtSnyNCh5oD6zNxmS2NgU0naA/m2m+epT2DMnvd9Cyltxq3i/l6wCGitN/KmCta3OkPIkJxW0EzWwOi7GDerYaUbDpDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL35WgBmGXn/0wZtVpKGuDLNomkYug934gPQq2ufGIY=;
 b=ZrkyB8z9NAE4AYAPyG5Ox6FvBudME8O4bIfluWkegHozU+WQpflKAnxkWbJ/TG+SBiCjJc0mRh5gXsWijqa/Lhert7LJ4aVaCNca6JrNFDBb6JBh7XWnE4re1cB5c02lO1gT13s0SF9v5nwvxCOX4IBbhiTh/eZ9dV+GMWJjdHY=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MN7PR10MB969465.namprd10.prod.outlook.com (2603:10b6:208:5f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 10:10:54 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 10:10:54 +0000
Message-ID: <96d51330-0abf-4533-9731-5334b4018845@oracle.com>
Date: Fri, 31 Jul 2026 11:10:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: Ensure the first same-name function
 has a non-zero address
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260728023722.1978868-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260728023722.1978868-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0284.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::8) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MN7PR10MB969465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3960d5-589c-48c4-40aa-08deeeec01d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	L0muvFc/3EMeNiWF53MYj1ljwQYvXIbHWviAl5Qw36Aj3Km/D7s1dgz34FYZbQHZfyJp0nmi44a99CHT7wfMVC1Gf/XXZwe8qQyMHJP0e4ODZEQJHegCZseDJGjN+OHerClIyvphBOQhFp/dHhVR+ZLjmU33E7cn1pA/wdZAk0lloiku9wNLUaItdE7YyjQ8H/PvNbkSjPXSkCBAViRpWMHmRD8J+5CCujohVpJnRcsR/Zo2qCglExY/ywdUP2BFyUqk1Rnzz6twkKGwb6n5h8EnCvj8oK9KWlPst36pjPm3lep9WFsaJ+qJCyiwqSqKi0wz/2WgenS9uvxDg3giBSE41rHdp7WMWd+NAs+mCF5gG/lL/9iz5J8ByIzFnPZTtzLZMn0sWwKy6XD4JeYBJG/w4w96ORnWem9Kb5MlWFGftTSdpxZzXLs/TbB1fjQYTkCXJxwN7mg95evwg2ICDBlzUvKk9udGILcd/uTCNxW29PHHdfaHYTQx8Q+yIcIINEVduo7mDTkjPg1siTAi8GTo00OTsg31SsuCSeN549SVPlMMmnwjK8tXOw7D6/sFjHJ/OPhfCKtZm2vTST3BKLFUKxVtd83zJzevIA5DPkJXk+9H+9KF1eQvQyWN82DIrz/XrBY0RKJtctAv7RKhUC3c6C+uem2PmyAtSfK271Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU5DQWQyZzczOHcrSTFia08yN3pGWjNwT3QxeExEUGpodmVuSjQyN2hLM2Js?=
 =?utf-8?B?Z2RESHVqOVBvVG9jbCsrZjM3Q29Ca3RDc1JpcU9VNytzVGVjUVVHN1I5TE5a?=
 =?utf-8?B?bVZ5TjdtRG00ZVU3OFllaXFYMXdVbGtsS1MxQ2hQY1RneWN3TkVhb1lwUHU4?=
 =?utf-8?B?ZWpzMmRSbUl0eVJKNi9qTUgzQ29kcHlKTHp0NlRHdUtoM1NZRjJ0dFJrWnZR?=
 =?utf-8?B?NUhxY29zMmk2THVDQ0N2Ri8wa1RTTTE5d0Y3bVQ1VFNEWDBtN1ZHUEVhYkpm?=
 =?utf-8?B?Qk5oM1ZtUzF5MkVndVI1bVlOUVo0ZEsycHQ5alh3VnIwTWNoZmlCemVsZ3g1?=
 =?utf-8?B?b3cxZmMxbzFTakVuRE1TVTdOdStUSnYraFN1aU0wa1NXWithNGVEMVhCbDVM?=
 =?utf-8?B?UlhtcmZFUEpTSXRzSHVySytXVW9BQ21OYVVKc0U5TmNXQXd1QWZRb0xMbG5v?=
 =?utf-8?B?Ukk1eUZJNVVPUXVVVXhJS2hhNGdMMWlHa1dRdVVYYTBIZlVRWFhWMWo0alFq?=
 =?utf-8?B?NytadW1TL1N1Sk1jck8yaURWcUo0NUFUKzFIaXNEZEJ6TTlDNS9uSHhTWFhY?=
 =?utf-8?B?dkhuUFhSV2NXZEozeGdTdEorVEdLK2lZdm9NT0s2dHJGOFZOMTFEMDVGS1RH?=
 =?utf-8?B?THVqbzZkTDNNRCtNYXlsWmdyZ1pvb0tWcWNxa2J5eFVLa1Y3NmRpRHpodEpk?=
 =?utf-8?B?WjRiV2Ezam5iTkNKa1RWc0RoOU5yRkY4cDl4ZmRmTi9yNEd5b1M0KzQwTitv?=
 =?utf-8?B?RytnV0VVMEQ3VW9WbklJOStpT0F3bVh1NGkxVkhtTUhmVUZGRGFNeTJkazhp?=
 =?utf-8?B?Q3dPaEMrZi8xTUt1R1dvOThGOXF1bzdkalJFWjkxWFlKaE5sWllOVG85RHpz?=
 =?utf-8?B?TjRUWXpOTmtxZHVWUEFrU0VpWjlxVlVlZVphanpnb056TnFaTER0cDRsUXZH?=
 =?utf-8?B?TGR4c1dJYkpPM2ZTUWZKWUhqclR0eTdjWkx4T1lEdUFlcVozWDdxbmhRTXR4?=
 =?utf-8?B?cDh3MG9Bais3ZW5vdldCYVpCeHozblNSaWVGZWhiR0tSR3FVQWdsMEF6Qlds?=
 =?utf-8?B?Q0l0cHR6Z09zL1M1UkpaNTlETFB0bjd4MkJaU05HSUF3Yk5oSUMxeVVIY3Vl?=
 =?utf-8?B?Qm5WblVCNkN2YktYRnNzYkhraTRLd05hTktkWGExeC8yQkVyNzFaOVNyZmRB?=
 =?utf-8?B?TzdDVXRlenVLQ3ROMkd0elhpZW5JNmE1T2ErelB0Y2tuSlM2VVVvQm9yVVMx?=
 =?utf-8?B?TlRITFNDbmpNV2tTbzRBMnZheDZEZHBMbWJaTk1qLzFkT2YwaVhuSHhJSms0?=
 =?utf-8?B?aHRnNzhFay9hRkxORWtka2tjaEtRcllYdUJ4L2RqdWxwR1YzZDVNVGNKckV3?=
 =?utf-8?B?c05qUTVoTWJmd00walVHa2RJd0F4SVNvbFo1QnlaRzNydTllRkI5OVkrZEpY?=
 =?utf-8?B?bk50NXhIb2Y3bjJCNERKN3o0Q2NQdmdaMGhsY3NOSy9WcTZ3dWhrcWcxT2VW?=
 =?utf-8?B?QW9URTYyY0dadjFpRW5GMEM1U2dqQ0JveERxdVo5ZEtlc1cwaGI4NDdQR2Jo?=
 =?utf-8?B?eXM5VXlodHRybFpSRmlYSVpPVEJjZjVMblFmdTBVQUF6WEZwWWhUWjE0Vjcw?=
 =?utf-8?B?ZUtnZVNjUVE5dVZjYlJEZEI0bnh6YTRlS3lOZG9hUHZBZTFON3FwMnFrMzc3?=
 =?utf-8?B?aHNRN2wzMzdGMGltNEFsM0c0dUpTaWdIMXgydEcxMDErYldlREV1T091NVBG?=
 =?utf-8?B?VDlPdk5SbXlKRU10eFdjT3RoMHJCZ24vUERuVDg0UXpKMG9zUi9rSjFSUitT?=
 =?utf-8?B?UUdaZUdJSlh5Y3pJNEc0UmNTQllIbGFtYVVDY2dFSWM2QzB0TXQrWllPOGR5?=
 =?utf-8?B?Ti9hMEFZM29pdlNRRjVqLytwakVERU01RE1DUms1bTNUS0YyNFF3WVk5VmRS?=
 =?utf-8?B?V2NVbHV0K1NIa2ozaXBiNzVoRjVDaTcxZU1vRlVqM0phOUV1WTlGSzlNb2pk?=
 =?utf-8?B?VllrcUo3Y0JEdFhVcEJiTWoxNnVYM045a21CUkdpT1hVZzJJbTkwTndORmJ6?=
 =?utf-8?B?WWwvVWRzcDNKUWNlZU1BZUFrQzJDMG1PRk9FZmtXUGEyOFIydHpsWi9NVklh?=
 =?utf-8?B?Ym1lMzJ2dU5rYmREM21VNVAvbWpzTTQ3ZHFaYm5GQjltMlNLN2x6TlE0Vytx?=
 =?utf-8?B?ZlVyQnJkQ2VvSlYyN2ExNXdXejU1dnBKVkZCYW5OdzE2L2Z5Vlo5b1pLU3Bw?=
 =?utf-8?B?QjNGbE9NM2hPbjBPeWlIa2t3b1dreitvQkZtYS92VEdJdVlNejhWWWpHQmJ5?=
 =?utf-8?B?aE90QjcyR2RVZkEzeDdZUzkySVNMSmZEWmthU2h6VjVRZVRSVUVhdz09?=
X-Exchange-RoutingPolicyChecked:
	aPxKmszxX19tS65HqBGHPD4DYDUfy1SW+e2HoAoFO1uPq8CIbQellCNsDWkH0lhX1rtKWFCtVXIs0HdsMv2zkBCccQSg0CW81uqPsxiywyHLStuuG7EOGNHs7NTYvJqtuxJkPtx2A98ha+GUm+rYR2BFrWHkDZHA7vbRxy2n4fiw7VskjoU/d+FFM44NHR2MbMMd//oMNP5YaoH5eYrxVlcxJWjPSvmj8wcho2eAJIabvmEtTbcpyn7n7l2vxOLgbF5Ktmw72wxDiVutVNhzugJItrCO95vroQXsAJL9V+UiawApnz2R8GHa5ZMWVANEcsVBf+yL2rYggWQ1otNZ+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tWolasPclgGh6POvAnM3ePjLw+TLYcokT0xK6qdUz2uBes/GLuG4Pm9dlqUi6kxyLQpgGTegomjCEWM4KE8EkEltkUuRvA4fiB7Dzb8Jp8HoPncN3vcLD9y8Jdchm5aLu3mwTuExV9w7DJfKwcTxJsTjEuJTezNPs7Alj58vbNM9o5Iec5ev+GIcahprYR1qipZDVQ/J7cYFFLpT+g+S6q2kbVPU1UK4MIFnLWcD4md7Yok4jHahzKp3m/+Wsopg7C2UdiKBc2gYHISutdmJbY2vVPUgY59S+N0zlEQcHNdrS4BMTKhU24tSNo9byHGHQAqDMrUFXNRUWizQpS1gwRx9p36Pgy8yUmLOgQuu6/MWvAiEIhE8YTi2SAuqJ0WGvmvxA7HqFclBK9dLyHrWngyLyh3gFNWSIwly66AcGEL2Z0vr2JRkZaZy+1T8njjhVaog+wLAIU4SNDKsmWuukHpsdPkjNQWONaDNDO2c+B5+/tit848qs4H7bqhe82U+glJJLO8XpBlYNWnRR+lTHix6RlnWdavJ45nAKeZJNTtRWaJ9kCWVVYEXr1TI8YCSQsTBp0AjGBmS6D4PkyqFv6WPGIogwOivr/GeXoZS7sY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3960d5-589c-48c4-40aa-08deeeec01d4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 10:10:54.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxpHuIo0aVARmj2aDXvAxWUHCFTJzFv7Fd1IGRI/5ELiG4BbN2iHBhJplxhtIFPEklxoZ/xbSMnOnc8A14mL9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR10MB969465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310076
X-Proofpoint-GUID: qazKgqUbm7SqaoM4qp_EZgP1cCLfH2Zk
X-Authority-Analysis: v=2.4 cv=Y8fIdBeN c=1 sm=1 tr=0 ts=6a6c74b1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=HZpgTNFFu0RSMucs_CsA:9
 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3NiBTYWx0ZWRfX9/AcER68Nj8g
 hqmdoucFnJrVL1ALjvOwk8jSVtjSFXbuBk9jvaJnma8iTxv51VR7ZrHtLYlp0GoAkVpGtWMFfcb
 wcBf2XNrRSccP1rew++xRpiXS74X3Zcwskm6Jt+iFSuZiPM6xaPZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3NiBTYWx0ZWRfX2of4HcOp1M/0
 57s7bvTo+lftl5GAiA8nWyOBCOEECcMQR6ZC4gLVzuYmvd4Tki6m/XPkxD4KuoQt4Pd0M2PC+Mp
 i9bTpZlWbrxGD2lcmhqiFRpDKMLjV0PK7P1RfIjZ/EvinKQFkLKqkkWVjlzbu6TAizNH+EUPiN3
 /XUWL9WPPgL4OlMlJPobBR8LCMY4hYcsIKWn8DLOFiJSs/aVtxCQLGNGNRgdXpYqIrxAQ4xZ3cO
 +Czw8Oab+ER+0c4gHeCVW4emdMdB25h+J49tl0keDixdOrVOspK3nKOfsKjhi5i6AgaX/0hnAWu
 8tEFmgzcLbR0MZYUlLm/UQhymFZ5LMMHxLzsIK5tDy78aedGEhNDoGiGxCfOfjM6feJXV7gxegd
 SvegMB1XXg3R9lMl1CLSRJDSnh1qDtt4Q+/QrbyNpnJaTK0Oe6wKEE7WqQV+1NtspJGWWt+X/hN
 gKR06bb9i0dV8qxlgiA==
X-Proofpoint-ORIG-GUID: qazKgqUbm7SqaoM4qp_EZgP1cCLfH2Zk

On 28/07/2026 03:37, Yonghong Song wrote:
> 
> When true_signature is enabled, the same function can appear as two kinds
> of saved states: an inlined (abstract) instance that carries the original
> source signature with no address, and an out-of-line instance that carries
> the reconstructed true signature. saved_functions_combine() compares every
> same-name state in a group against the first (anchor) one and, when their
> prototypes differ, marks the function as having an inconsistent prototype.
> 
> Without this patch, the first same-name function may be an inlined instance
> whose prototype is the original source signature and thus differs from the
> true signature. The two prototypes are then flagged as inconsistent and,
> because --btf_features=+true_signature also enables the default
> consistent_func feature (skip_encoding_btf_inconsistent_proto), which drops
> functions flagged with an inconsistent prototype, the whole function is
> dropped from BTF. This primarily affects clang: its signature-changed
> functions keep their original name (no "." suffix), so state->sym is never
> set and they bypass btf_encoder__add_true_signature(), falling through to
> this canonical-state path.
> 
> With this patch, same-name functions are sorted so that, if any instance
> has a non-zero address, such an instance becomes the first (anchor). That
> addressed out-of-line instance is the one whose signature represents the
> true signature, so the consistency check compares real instances against
> each other and the function is retained in BTF with its true signature.
> 
> It is hard to create a test case where one function is inlined in one
> place and not inlined in another place. So I built the latest bpf-next
> kernel with
>   make LLVM=1 -j
> and then did
>   with master branch:
>     pahole -JV --btf_features=+true_signature vmlinux >& log.pahole.old
>   with this patch on top of master branch:
>     pahole -JV --btf_features=+true_signature vmlinux >& log.pahole.new
> and then get warning messages:
>   grep "skipping BTF encoding of function" log.pahole.old > log.old
>   grep "skipping BTF encoding of function" log.pahole.new > log.new
> and compare log.old and log.new
>   diff log.old log.new > log.diff
> 
> The following are some results:
>   --- log.old     2026-07-27 19:06:20.223881463 -0700
>   +++ log.new     2026-07-27 19:06:28.874109831 -0700
>   @@ -15,45 +15,28 @@
>    ZSTD_getCParams_internal : skipping BTF encoding of function due to unexpected register usage for parameter
>    ZSTD_getParams : skipping BTF encoding of function due to unexpected register usage for parameter
>    __ata_sff_port_intr : skipping BTF encoding of function due to unexpected register usage for parameter
>   -__build_flow_key : skipping BTF encoding of function due to param count mismatch; 9 params != 8 params
>   -__build_flow_key : skipping BTF encoding of function due to inconsistet prototype
>    __collect_tables : skipping BTF encoding of function due to ambiguous address
>    __fl_lookup : skipping BTF encoding of function due to return type mismatch
>    __fl_lookup : skipping BTF encoding of function due to ambiguous address
>    __in6_dev_get : skipping BTF encoding of function due to ambiguous address
>    __in_dev_get_rcu : skipping BTF encoding of function due to ambiguous address
>   -__instance_destroy : skipping BTF encoding of function due to param type mismatch for param#1 inst != inst
>   -__instance_destroy : skipping BTF encoding of function due to inconsistet prototype
>    __ioremap_caller : skipping BTF encoding of function due to unexpected register usage for parameter
>   -__ipmr_get_table : skipping BTF encoding of function due to param count mismatch; 2 params != 1 params
>   -__ipmr_get_table : skipping BTF encoding of function due to inconsistet prototype
>    __ipv6_neigh_lookup_noref : skipping BTF encoding of function due to ambiguous address
>    __key_get : skipping BTF encoding of function due to ambiguous address
>   -__kmem_cache_create : skipping BTF encoding of function due to param count mismatch; 5 params != 2 params
>   -__kmem_cache_create : skipping BTF encoding of function due to inconsistet prototype
>   -__kunmap_atomic : skipping BTF encoding of function due to param count mismatch; 1 params != 0 params
>   -__kunmap_atomic : skipping BTF encoding of function due to inconsistet prototype
>    __map_range : skipping BTF encoding of function due to ambiguous address
>    __map_range_leaf : skipping BTF encoding of function due to ambiguous address
>   -__map_single_page3 : skipping BTF encoding of function due to param count mismatch; 3 params != 4 params
>   -__map_single_page3 : skipping BTF encoding of function due to inconsistet prototype
>    __migrate_disable : skipping BTF encoding of function due to ambiguous address
>    __migrate_enable : skipping BTF encoding of function due to ambiguous address
>    __mod_tree_insert : skipping BTF encoding of function due to unexpected register usage for parameter
>    __mptcp_pm_send_ack : skipping BTF encoding of function due to unexpected register usage for parameter
>   +__neigh_lookup : skipping BTF encoding of function due to param count mismatch; 3 params != 2 params
>    __neigh_lookup : skipping BTF encoding of function due to ambiguous address
>   -__netdev_walk_all_lower_dev : skipping BTF encoding of function due to param count mismatch; 1 params != 3 params
>   -__netdev_walk_all_lower_dev : skipping BTF encoding of function due to inconsistet prototype
>    __pci_bus_set_current_state : skipping BTF encoding of function due to unexpected register usage for parameter
>    __pskb_trim : skipping BTF encoding of function due to ambiguous address
>    __release_region : skipping BTF encoding of function due to unexpected register usage for parameter
>    __remove_hrtimer : skipping BTF encoding of function due to unexpected register usage for parameter
>    __sk_dst_get : skipping BTF encoding of function due to ambiguous address
>    __skb_complete_tx_timestamp : skipping BTF encoding of function due to unexpected register usage for parameter
>   -__skb_gro_checksum_validate_complete : skipping BTF encoding of function due to param count mismatch; 2 params != 1 params
>   -__skb_gro_checksum_validate_complete : skipping BTF encoding of function due to inconsistet prototype
>   -__skb_gro_checksum_validate_needed : skipping BTF encoding of function due to param count mismatch; 3 params != 1 params
>   -__skb_gro_checksum_validate_needed : skipping BTF encoding of function due to inconsistet prototype
>    __task_rq_unlock : skipping BTF encoding of function due to unexpected register usage for parameter
>    __tracing_open : skipping BTF encoding of function due to unexpected register usage for parameter
>    __tty_buffer_request_room : skipping BTF encoding of function due to unexpected register usage for parameter
>   @@ -63,44 +46,28 @@
>   ...
> 
> With true signature enabled, this patch allows more BTF functions.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Applied, thanks.

Alan
