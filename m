Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56126ED37;
	Mon, 23 Mar 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280561; cv=fail; b=m63GCU98MbwBrXOnt0szD0MIdkPaVkkFzEMpXPgck99A256uMFdT7zDB3TR8aAv5yzc87+ghmUmqMyAxfXknZph/dfIwqhoKlnyPc8MECPcVJM+Ul9IH4vc7qG2YcaQQHz6sfQn08S8ySjXYZy47Hd8yqFe/aw4S0AcVMPMXfl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280561; c=relaxed/simple;
	bh=AKziHsJpCgP+NXioE7sVMj0G2AG7HvpCzsONMtIkfO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QVSGZSQo3cf1oFdiT9dB+I4XosVbpu3fZJEt69AcbQh1C8lewm1e0fbNhnscJZ4MBv2q0cWjqOB6mHndY5Kfyencw7RcC/J8ee4IKZP+6E02MhalyekPoqQYC4hNgkHXAi5/M0M+zMvNYnAecF/WeUixeSs30uc0c+Xj8iVUKZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7JDkNYu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oYhKcJuv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7JDkNYu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oYhKcJuv"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NDt2FI1770921;
	Mon, 23 Mar 2026 15:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4mdpJYv0Na7/OwiWDAJOnIgGGZ6ONRLf9es78STayRE=; b=
	i7JDkNYu9uQoygL8Iv5xmnrxV7E1czlH4OaQ34pF1Tl5djhXUZyFKQP713r9haGS
	Gjm6eC5qp262HexY7p87eTNm7MwRISja+OWUERgwMfmAHeAqZIAOZ450ucSYyIAv
	H381W3b50a91GL+xLAhP+iaKplqRDj4uIpE0OiDUa7PCu2fCHof386SjrJyiOLae
	k4fswX9UADC92n6zYcNSClYIWjT7nFkld/h9EK3HiSsi4IiKaDH7cAq2V7VrCew3
	Xdf6ojCpr0jhNsbxp1SPlDwpZaB+0ACiAnEiVRGe4x7YXtOPqjPT6XHliyNjE1i1
	FEk/u6FpOayKxPPXUdrGQQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2ahrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 15:41:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62NE4a46028971;
	Mon, 23 Mar 2026 15:41:32 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs8n7hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 15:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5Br0adG2fPvMZV0oLMnOCdGAbzqUp6yNp/wvGltaRs49aqCmrq1STKqUGQEdYiNKZe4HKxGzQbsbsOHjlE+hcm2q20C2RTaktM6CqGRXgWVZdMqjDG7HBCzlvwzuOKx0WtyFfEd6FF3NJHkbtynEncSAACUJ/uZl1v/RkSWJFQ6YyslBPikVAmjKiyAlV4yxT7sBYgbxqNfkwzOCMg3oM+17uZ2I26HPQExVAOUOLNJNMvoNNVp3dyQ2wIKe7cKKUZTZOV5tYLYL3G5596Z3GQyENMqv4Uth+PeWTih7lolE73bLEATCks3WsgSESS7A5dKGQFUNLfiYuY7qrtZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mdpJYv0Na7/OwiWDAJOnIgGGZ6ONRLf9es78STayRE=;
 b=CWmYKaP84GqG5I/Hd9t16eDuKBqHCHJF77FqL1RJGExHAeqenbPfM4Dc6UoN16SeBnrbi2wm/Rt5/mna5vPJ0J1z4ySuPNGqvvnSBKZyt4xXcvvBK0xoYJyu7TAk4chtucErGamGdyNiwLQlZ2wSknrhnwIqWgnu0+/tohUNXf1yuyggX/WMb1z/o4bW9HQGK5cI1sZe3qIGqWCjb7w+BmwTpgGQWBf64qSylxsh9LOGx3LgdXp2uBntc0MYtqaTOZfiC86ps1x038MWK8eJyx+XZr0Ok0le3Hmpf06AYtCElk908bqegtrXmvtLgSyM4Tt1kyDrQpdzcCO8qyyQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mdpJYv0Na7/OwiWDAJOnIgGGZ6ONRLf9es78STayRE=;
 b=oYhKcJuvmk3cO1bu6FGPawskQv+oxXEKinwhLtajv/OJWVOkgUwzguUsX1dZL3YOLNOjWcEhSCxOL34/ID3QibNKicGY/3mLkG6ujOBIxEjVWltWQW9lTHwO0NdgHRE+YidXRiZ9kDFVV0damD9PEYyKrxIyXbgtygUAGUdDNmI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS0PR10MB6894.namprd10.prod.outlook.com (2603:10b6:8:134::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Mon, 23 Mar 2026 15:41:29 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 15:41:28 +0000
Message-ID: <0ee4bc7a-692f-46a1-9373-2f405e5305d1@oracle.com>
Date: Mon, 23 Mar 2026 15:41:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3 9/9] tests: Add a few clang true signature
 tests
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
 <20260320191003.1975752-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260320191003.1975752-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX1P273CA0002.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS0PR10MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 900c00ea-cd4f-4505-103d-08de88f2a654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T/OKCH5F3mv6LcNCLnb9UInmu9EhN2hn/JIIolHaXlpxRSktlajUDNUCtEkDXCo4o6FwnJZdbjuRAdQiHFvWvUd0ERO23W6+UDghhMtpDgFWK8kcaG+t6Taexn6JPPid5/zhp5u4Os/3Jaay08MyKvSPzhifMIM8Td+541v200KyZTmR/0edEsp6mQPgsVvRyCFCbK+MJUVK5vWeD8+80irZ5/E1z+mSy11DRrulybZzCGx3yGq5LQVhNvWVn22wCeMRjNFc09Vyg10DL/50ZtEYZfm1ywxG6E7RJmBIBBNkFBYe2ovOLkqmK+MpCwpK3kfbCGW7fmeiXn88HQlYxv/tTOuL77dU2J6FfvHWa4U2VDkNFYv26PqHb+2YucriCoxnaSGCtnoVV/LyKH21RzEGy9+qKHqSM1DN7jkSO2nk2afTRx8oqfgpT3gL0zdMERxg4gpHh4QWHIrL5JefEAwMS/W4wK4KSfSfP9XhEZxrEocmYbJAkSPQsyz3Xj0sFFOlZ8DbrrF8WfJpXSTh0oUM33fzTHic3htj2eEfPzKzTMa8zn+9VOjZ9X+S7yBy1lwFvgtNVJfbT2umN+T3ngnJ3pCkkyENSnHR6Jry34ODI8NvXZhH2CLGECSNTzfaNL2gDwQMqIFVfxHGRLH1qA3vB/tAQ8xlPIyf5i0wZBXMQXa78Y9OCN+TOWG+P9dtZF0bauE/CLE6P/D81PB5YolRRPs+IcPDVM/xaN90ZDEKEarOCkmatW4o3vaIxl3c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2dYOWxyME1HQVBpRWRmRXhzV2xNdG0rcDhzOXpKR2tpYkpMM2ZBTmUxUzk0?=
 =?utf-8?B?V2I4OCsvZ3JoZ3RGb3orU3Q4Njh0WTVwWk9JSndsZzAvN0RFTWRhZys5MFFT?=
 =?utf-8?B?eEw0MTJPcFN1VC9JSDdsdUc0STJZSHdnWklBMlE5cVRWTXVISmFUMGxhUW5h?=
 =?utf-8?B?ejhLZnZaT3BsWklnLy90dGMrRGp3bWt6U3JOQ2h3eEFGb0p4OWozazJBcEor?=
 =?utf-8?B?dmFNNzJ6dHUyaFZGbUVZUjFEUDB1aWFqUGhVS0t3RnMxcG5EWFdWM0YyRFNL?=
 =?utf-8?B?MjFtMmNRT0RrYmZOTElidGczVXV2c3N3UEtmV3M2SWJkVEtpbnFwc1hmTFlx?=
 =?utf-8?B?RURmQVJhR3ZUTEFIY0hOc2p2S2VDSkhBV2RybW5QMUt4U1ZDVFFnS01iN1d2?=
 =?utf-8?B?V2dZbHdET1BqRFE0TEw3TDl6VnVFYXdGQW1ycFZ3V2ptK3FqZmV4bC9uMlY3?=
 =?utf-8?B?a3MzbmZyeXkyQzhuWHZ2eHMyRk05THZnTVp2RjdXUUl3L0V0cWhGMFdVd0xQ?=
 =?utf-8?B?SGluMHRCVUhDQjlUc1RuV2hRV282V2Y4SUZJZkJ3YlJYVVM3T2JOSE5lcWdV?=
 =?utf-8?B?Z2grODhXdGt6NFRaQ1VoS3hnb21OdzFuVGdvTUhQWGhqL0dlVlE0TTd1TUxB?=
 =?utf-8?B?T2RsZ05xaFJic2hINGU1UXlYVkNnRVZ2SEFVY1psU1UwNERFeUdQVWlFcVpp?=
 =?utf-8?B?b1luMWpKQmZFNjBsY3h0Nks2Qll2bXAzdFRpSzVDYy9zUGZ1c3NNcXhlSVlK?=
 =?utf-8?B?TFhIQnpXTjZOdGN0U1I3N2J3VW5tRTVibFlSSkw2RlVDc2FtVUFDczhmN3ZF?=
 =?utf-8?B?MkUrZi9JR05SaXowUnM2c1hZaU1GS21QMTR6WU0reFZBRy9tSWxwRjNuR1Nn?=
 =?utf-8?B?dU1PbStDYUYvRjBpVXk5UzJvT0pFRnpNckxab0gyNHBiVEdCeCtRR013YkRO?=
 =?utf-8?B?YkZGQ25vdGhFeFpDclBVQUdrbVZBVm8xUm1RUWk3UjhFRmdZaWVxSk5jQVBW?=
 =?utf-8?B?NmJLWmhnRC8yTDZTNE9VUzBUVnd1YzlFSGtrWG40NE9IUCt6VlVyc2kxU1ZD?=
 =?utf-8?B?OElkMGx0eExJVmFWUzhnMituRC9Hd0FFR0pBK0JnV2RmKzlRYnA1d1A5SzJU?=
 =?utf-8?B?bEpSSUdLSW85ZkF5MWxkM2JIWFgwVmR4aXFYVTlMNUZWUVovcHVsOVR4ZWp5?=
 =?utf-8?B?bThEVzFabGFrYkl2SktvR3M0WGJiVkhqMlY0VTB4b3cvYVlrN0RwdnQzZ292?=
 =?utf-8?B?N2F6MnI1aG54YjV4T0lqOStCUEFMTC9hOWxyTGNWaVRQTnkwWHowNzUrVFQ1?=
 =?utf-8?B?L1hnU1ZuR2FNVFhuMzBudkVkU0MrUzNRZ1dTeDB2YVJEUG5xQXdZYVJwZkFX?=
 =?utf-8?B?VmVVTHBwRFNLVG9ZR1ZJbU1uZHdldzdQcUJtbHFHNHR3YXhSN3RSMGZ4enhI?=
 =?utf-8?B?TU5UakxYZytDTkpGYTZucWwrSEtobHBIM0E1WGhJM3RBcGlwNnZmZFhDbkg5?=
 =?utf-8?B?MytsdXMwTTlkTWhHaXB1NG93eDJlRVdqWENLSGVBc2JGQjFRV1VzSzU5Nmhn?=
 =?utf-8?B?NjhEOHUwU2NhZDE5cGpLNmFrMGsrNDlkbUIzMEdDSUZNZnFmZHY2NElIbG1o?=
 =?utf-8?B?elBDeDY4Q0NrYk5YQUNpRThVdUtRZVFqcDZtZzZ1cTAwdSs5c0d3dDRCRTdi?=
 =?utf-8?B?VDJJZEN3WVpFLzFhS3AxLzJRSmhYclM0enVGdnpwMHRVTm1McEFHMUFENDcx?=
 =?utf-8?B?UUdxZ2FyQktJUEpJZ3laR0FVbXZwS2NhZmlnU0pCS2JYUlJ1MFl5U1M4bzgv?=
 =?utf-8?B?ampFYmZTRmd1Tms2RHpNVEdwR2g5SUt5cjBBZTUzSTF2UUwrZnhGOWM3OGJD?=
 =?utf-8?B?YzlVcmpQMHMxbmlzcVlWRW1mamVwOEZLTlI1c1JadlJZU1hSNThrclo4Z3Rq?=
 =?utf-8?B?LzBiR1dxLzFjMUpxTkhzcTlpVVNORGVUbmRURkNkQ2FyYjYxbWRnaEVnODEv?=
 =?utf-8?B?RUNCUmgvR1dsa3l6YjVIeXlPWUVsRitqMFFHSU5TdlNuUzBld2xHcG45K3V1?=
 =?utf-8?B?TWh5blNJdEM1YUVIYkd4SWlhNWtJN1h4aU9VTnZZUUhvdEtWcjYySm1RWjFo?=
 =?utf-8?B?c1lzdmpaam9lWk13b25ZV3N4MjRROEs2UzhZa2FMdk1Zb3huRHVkUGlnV1BT?=
 =?utf-8?B?Ujl3TTVZMDdvNW11WU9SOU1WSE1abHJ2bm9ZakJPekttSXBjUkRaRTI2YjEy?=
 =?utf-8?B?V29tM1A5Sm5NQTV6bGJIc0RtTFZJeHQ0V0NNMG5nTHRTWWp6NU14V0JaMlJD?=
 =?utf-8?B?aVh0dVpOMGtrK01LSytwUWdXLzUwc3BkZTlRcmZCTmFjbGdvNUV4dz09?=
X-Exchange-RoutingPolicyChecked:
	TAEFhcXbd3EomE83cUz/AKWK/d/3OD1m+AP42yHMpb/Y6+LU0qWu+BNdy6Tmc4tmmRTyxT9JwlCyY0DpPMB+yvGhbFfe5aPwheszzU3BQv5FGYOSwOp1pb6l1zJqOENndN2uUGON7WG/Ah9KkQfb3wIBnlRt8qTbaZwABpLuHX+W7dX+6w5RL5VPAVMO6d2ezfMSx32266+zNLlIXaPRTv/vfknDDY44soX7yLQaJCupEByPdwd6Sf3jWRZ6EcLSr5AhoVYydi8AjivMz/kIz8E935K1Cel7Fn4jVnJ2RvSvmk76wWyIsXJyZ7vAkyJ6f04eOK8/RN3T14QSMoKTgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jI1FH4kZr93hAqUxuXPZELrPBb7OwrnY/tZ54CnCtv6EDvDFbXc4oGefed/rNVeJ49orHFWYgMPBq5KaPcBXTW6/sZmHDDMsQ5I/wbtDK3NPb4t7j5zkezr2USOL7RNlMfsuc220f6Pi3+nQ4nSQutCNytZkkz/1mQgs6CiV5knFJGrXoaf/878ciOANnuHx+RLy24Mbtnd3Ot7mmFyh53XQd6rtu/fN3PJ9ufj19EEUM59063cX5kZPzLhXVJMEpwIPihCiwg4Rh1hvWXn3re32xEC6NhFEbEOyI96EQPj4lCKxCPagKLoQOq3L3JfNnc50y19r8x7bY9eg5fTrAEmWEc98Rq8Cap6NjIjU3v+gj0TOdJOXQ/9Hc5d34LEOPptNXMDRgRsNnOh2FvOmwhlPLNQrdPFhw+d46tbzTm3E5C3OG215x/MW3oFDm4b+pIbqrbb6CHO+vbhBYHX8pjnKi95w7PUsyBBX8iUz5MXR5e5OGRD7C6sHHRRdNb+eVCGV+fnQnldBgph4disBShDJmu/5wYQ2Wc/Ghexof8msZYV0TQhatCL5qORaKMX2TZ0PMM2ZaeATZ8HXY8Q9o3B2C6x3de4gtFoupobEnlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900c00ea-cd4f-4505-103d-08de88f2a654
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:41:28.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zA7ntv6S/wOgkzZFNripadJyd/s+tZ4dgafCm5koWSBpYNwF+RgwCP3+2FujFN3BlMZERsnTfIX5D+/RvKCLNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603230120
X-Proofpoint-ORIG-GUID: 81IlUlsLTG8e3yLz5EHRMpG6WaWGT13l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyMSBTYWx0ZWRfX17HlOz2OKKMm
 O2N9RiWeeVQNZBgETKTRD9/NEp37Av8Y+yrabX7fhWRSuQJAPMan0fxuSiol2k3ryJQnd0QMhSR
 trlPtF5VV0D4wLBb6KJcXzJOiFkVAB4iHZykFAIz+EdKsTCrlinfHFDX2NQ+O9MXR0DIeCDUahy
 guJV3lO27PWgVvDezFzQeetzUdwVsMHuJqN+CvfICJsMRA93KdkqsuSAgEsaDsJWJm7veJT02MG
 nXFMsIVCBetqdPx5L1QzSqnLWrtCjYbjNXAspN8eGZ6AjtMj+5bT2SwxD3J7xRAJSFd2ULH7qEW
 54ZCPe4MZbqOffmYGu1/RKPlm6RI6M/anwuPJFdE/YejLbqqHIRiRSb/CYfvePskk3SpSimtxMQ
 3FlwxXwZWWKXlHSNgkHeeCflZd8X6i8tLFwok6rslYoJYq1+yvj2VtonL4DsPQyttlhw+V1iDMz
 nkOGGC0AUVyX5afxPHg==
X-Proofpoint-GUID: 81IlUlsLTG8e3yLz5EHRMpG6WaWGT13l
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c15f30 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=3jKk7uM3LTfX5udRi3UA:9 a=QEXdDO2ut3YA:10

On 20/03/2026 19:10, Yonghong Song wrote:
> Three tests are added.
> 
> Test 1: VERBOSE=1 ./clang_parm_optimized.sh
>   BTF:   char * foo(struct t * a, struct t * d);
>   DWARF: char * foo(struct t * a, int b, struct t * d);
> where parameber 'b' is unused.
> 
> Test 2: VERBOSE=1 ./clang_parm_optimized_stack.sh
>   BTF:   char * foo(struct t * a, struct t * d);
>   DWARF: char * foo(struct t * a, int b1, int b2, int b3, int b4, int b5, int b6, struct t * d);
> where parameters 'b1' to 'b6' are unused.
> 
> Test 3: VERBOSE=1 ./clang_parm_aggregate.sh
>   BTF:   long foo(long a__f1, struct t b, int i);
>   DWARF: long foo(struct t a, struct t b, int i);
> where the 'struct t' definition is 'struct t { long f1; long f2; };', and
> a.f2 is not used in the function.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

thanks for the tests! Ran this through CI [1] and got a failure on aarch64:

2: clang_parm_aggregate.sh
Validation of BTF encoding of true_signatures.
   BTF and DWARF signatures should be different and they are not: BTF: long foo(struct t a, struct t b, int i); ; DWARF long foo(struct t a, struct t b, int i);
Test ./clang_parm_aggregate.sh failed
Test data is in /tmp/clang_parm_aggregate.sh.YC44qj
---

And for a kernel LLVM build (enabled with [2]) we also see:

1: btf_functions.sh
Validation of BTF encoding of functions.
   This may take some time.
   ERROR: mismatch : BTF 'bool __scm_recv_common(struct sock *, struct msghdr *, struct scm_cookie *);' not found; DWARF ''
Test ./btf_functions.sh failed
Test data is in /tmp/btf_functions.sh.P23ipZ

This test compares BTF and DWARF representations, trying to ensure we see matches
between DWARF function signatures reported by pfunct for both BTF and DWARF. It might
be worth looking to see if we can refine the test here to handle functions with changed
signatures in DWARF, skipping those that have DW_CC_nocall say. 

In the above case pfunct is reporting a signature with the flags field omitted. The
original signature looks like this:

static bool __scm_recv_common(struct sock *sk, struct msghdr *msg, struct scm_cookie *scm, int flags);

...so we don't find an equivalent match in DWARF as a result.

[1] https://github.com/alan-maguire/dwarves/actions/runs/23443008554/job/68198951034
[2] https://lore.kernel.org/dwarves/20260323130503.857217-1-alan.maguire@oracle.com/

> ---
>  tests/clang_parm_aggregate.sh       | 63 +++++++++++++++++++++++
>  tests/clang_parm_optimized.sh       | 77 +++++++++++++++++++++++++++++
>  tests/clang_parm_optimized_stack.sh | 77 +++++++++++++++++++++++++++++
>  3 files changed, 217 insertions(+)
>  create mode 100755 tests/clang_parm_aggregate.sh
>  create mode 100755 tests/clang_parm_optimized.sh
>  create mode 100755 tests/clang_parm_optimized_stack.sh
> 
> diff --git a/tests/clang_parm_aggregate.sh b/tests/clang_parm_aggregate.sh
> new file mode 100755
> index 0000000..bf47c8c
> --- /dev/null
> +++ b/tests/clang_parm_aggregate.sh
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +source test_lib.sh
> +
> +outdir=$(make_tmpdir)
> +
> +# Comment this out to save test data.
> +trap cleanup EXIT
> +
> +title_log "Validation of BTF encoding of true_signatures."
> +
> +clang_true="${outdir}/clang_true"
> +CC=$(which clang 2>/dev/null)
> +
> +if [[ -z "$CC" ]]; then
> +	info_log "skip: clang not available"
> +	test_skip
> +fi
> +
> +cat > ${clang_true}.c << EOF
> +struct t { long f1; long f2; };
> +__attribute__((noinline)) static long foo(struct t a, struct t b, int i)
> +{
> +        return a.f1 + b.f1 + b.f2 + i;
> +}
> +
> +struct t p1, p2;
> +int i;
> +int main()
> +{
> +        return (int)foo(p1, p2, i);
> +}
> +EOF
> +
> +CFLAGS="$CFLAGS -g -O2"
> +${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
> +if [[ $? -ne 0 ]]; then
> +	error_log "Could not compile ${clang_true}.c"
> +	test_fail
> +fi
> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
> +if [[ $? -ne 0 ]]; then
> +	error_log "Could not encode BTF for $clang_true"
> +	test_fail
> +fi
> +
> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
> +if [[ -z "$btf_optimized" ]]; then
> +	info_log "skip: no optimizations applied."
> +	test_skip
> +fi
> +
> +btf_cmp=$btf_optimized
> +dwarf=$(pfunct --all $clang_true |grep "foo")
> +
> +verbose_log "BTF: $btf_optimized  DWARF: $dwarf"
> +
> +if [[ "$btf_cmp" == "$dwarf" ]]; then
> +	error_log "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
> +	test_fail
> +fi
> +test_pass
> diff --git a/tests/clang_parm_optimized.sh b/tests/clang_parm_optimized.sh
> new file mode 100755
> index 0000000..379e6d5
> --- /dev/null
> +++ b/tests/clang_parm_optimized.sh
> @@ -0,0 +1,77 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +source test_lib.sh
> +
> +outdir=$(make_tmpdir)
> +
> +# Comment this out to save test data.
> +trap cleanup EXIT
> +
> +title_log "Validation of BTF encoding of true_signatures."
> +
> +clang_true="${outdir}/clang_true"
> +CC=$(which clang 2>/dev/null)
> +
> +if [[ -z "$CC" ]]; then
> +	info_log "skip: clang not available"
> +	test_skip
> +fi
> +
> +cat > ${clang_true}.c << EOF
> +struct t { int a; };
> +__attribute__((noinline)) char *tar(struct t *a, struct t *d)
> +{
> +	if (a->a == d->a)
> +		return (char *)10;
> +	else
> +		return (char *)0;
> +}
> +
> +__attribute__((noinline)) static char * foo(struct t *a, int b, struct t *d)
> +{
> +	return tar(a, d);
> +}
> +
> +__attribute__((noinline)) char *bar(struct t *a, struct t *d)
> +{
> +	return foo(a, 1, d);
> +}
> +
> +struct t p1, p2;
> +int main()
> +{
> +	return !!bar(&p1, &p2);
> +}
> +EOF
> +
> +CFLAGS="$CFLAGS -g -O2"
> +${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
> +if [[ $? -ne 0 ]]; then
> +	error_log "Could not compile ${clang_true}.c"
> +	test_fail
> +fi
> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
> +if [[ $? -ne 0 ]]; then
> +	error_log "Could not encode BTF for $clang_true"
> +	test_fail
> +fi
> +
> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
> +if [[ -z "$btf_optimized" ]]; then
> +	info_log "skip: no optimizations applied."
> +	test_skip
> +fi
> +
> +btf_cmp=$btf_optimized
> +dwarf=$(pfunct --all $clang_true |grep "foo")
> +
> +if [[ -n "$VERBOSE" ]]; then
> +	printf "   BTF: %s  DWARF: %s\n" "$btf_optimized" "$dwarf"
> +fi
> +
> +if [[ "$btf_cmp" == "$dwarf" ]]; then
> +	error_log "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
> +	test_fail
> +fi
> +test_pass
> diff --git a/tests/clang_parm_optimized_stack.sh b/tests/clang_parm_optimized_stack.sh
> new file mode 100755
> index 0000000..8638af7
> --- /dev/null
> +++ b/tests/clang_parm_optimized_stack.sh
> @@ -0,0 +1,77 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +source test_lib.sh
> +
> +outdir=$(make_tmpdir)
> +
> +# Comment this out to save test data.
> +trap cleanup EXIT
> +
> +title_log "Validation of BTF encoding of true_signatures."
> +
> +clang_true="${outdir}/clang_true"
> +CC=$(which clang 2>/dev/null)
> +
> +if [[ -z "$CC" ]]; then
> +	info_log "skip: clang not available"
> +	test_skip
> +fi
> +
> +cat > ${clang_true}.c << EOF
> +struct t { int a; };
> +__attribute__((noinline)) char *tar(struct t *a, struct t *d)
> +{
> +        if (a->a == d->a)
> +                return (char *)10;
> +        else
> +                return (char *)0;
> +}
> +
> +__attribute__((noinline)) static char * foo(struct t *a, int b1, int b2, int b3, int b4, int b5, int b6, struct t *d)
> +{
> +        return tar(a, d);
> +}
> +
> +__attribute__((noinline)) char *bar(struct t *a, struct t *d)
> +{
> +        return foo(a, 1, 2, 3, 4, 5, 6, d);
> +}
> +
> +struct t p1, p2;
> +int main()
> +{
> +        return !!bar(&p1, &p2);
> +}
> +EOF
> +
> +CFLAGS="$CFLAGS -g -O2"
> +${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
> +if [[ $? -ne 0 ]]; then
> +	error_log "Could not compile ${clang_true}.c"
> +	test_fail
> +fi
> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
> +if [[ $? -ne 0 ]]; then
> +	error_log "Could not encode BTF for $clang_true"
> +	test_fail
> +fi
> +
> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
> +if [[ -z "$btf_optimized" ]]; then
> +	info_log "skip: no optimizations applied."
> +	test_skip
> +fi
> +
> +btf_cmp=$btf_optimized
> +dwarf=$(pfunct --all $clang_true |grep "foo")
> +
> +if [[ -n "$VERBOSE" ]]; then
> +	printf "   BTF: %s  DWARF: %s\n" "$btf_optimized" "$dwarf"
> +fi
> +
> +if [[ "$btf_cmp" == "$dwarf" ]]; then
> +	error_log "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
> +	test_fail
> +fi
> +test_pass

