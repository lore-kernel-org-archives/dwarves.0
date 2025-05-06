Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049B1C5D55
	for <dwarves@vger.kernel.org>; Tue,  6 May 2025 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556253; cv=fail; b=hdMKYH2audsMtOKmj0MFvf4GOQg4/rInduhncUXRPEI6jPoCg6SIVoq3vbKqBlgbm41M6J2Sm/xk4XI8Ue3hUhbsJoe4P36jzWdjBvEfx35sOJnWPc+sy0ese7/iK+kxyOjV8gv0u53ga0NzHOlY4u2fLcJZRIg1FcyR7S/5DwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556253; c=relaxed/simple;
	bh=KtSa8R26w+25V6iEmT5C/OB0vNZR3xU3VUsqdEwK+4Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mVX5U9qSxtAntFHDE5g6SfLN/7wIdwwFo2M56opj5/2jmviQhLL3VjmrnNBprDN6zM953p79k0qkzuF91N4maa/wvldxytke7pJIjpC3Oh81W9XUj4WVTIHkE8MK2PaiYKA12DLdQ9YkeoVXb0QgdQobDObSm+NUs6c5g3z81uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fhW45ugC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qK1sru8l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fhW45ugC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qK1sru8l"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546ICAd6012196;
	Tue, 6 May 2025 18:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3dBoqVEtDZ49Wbnr+MCJLr6pcCwt+V8LpkTZEbXVWRE=; b=
	fhW45ugCG3hwZVfpXKlqqnnnfWZGllRi36q6X7dQcJJSfVP65vaEfrWuZnZU6pGp
	u1ysi5w6xmq7Cevg1JBo5+ZfU+opAyLR4lBlo7/9IOOQVuIkMG/DHJJNLLvHjL9s
	bMzAu/tEBkLrcYJNZagH1B8o90i9s5M39hZmh3wm7W4gixpa8TX/LnoPY+Uod3VE
	MwGtdT9FE7vYKxZ89k/yr3TEW7TSuPQhWt3yDzfMiD2LC+QNLdynuSOeQ2ogYZg5
	GMh11uT97d8XZ2Gmot1El51jo+zcm5VvWMi3qVpPPfIug7i2YXzqqS/WSejpZ7up
	uzRjGp3KqvksqrwuSimQrw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fqg9g1a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 18:30:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546GfwXT035999;
	Tue, 6 May 2025 18:30:48 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011031.outbound.protection.outlook.com [40.93.13.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9ka5jrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 18:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3VUeowBtgigl9S4oxqHOXi1YcbvneTpJsMjEHp+r1+coFRgZICArBaF1bmukeHFBiIGzIg39xIsq3LZaKMI/oh8uCoqhFXwqg+0oHzMYXiWRSJNntkdi+YEbfIbcZjqqzFi+Waf505P92mGyq/yhY2l3TIJaUTpq76FAz/W7T5i46FBk6N0HKxpIF7Rb7PLwY+GEc5zReWsus0JR2jTEdfafTUPfGgeeAUVEFy7uGvadASS/kvs40RrCACT2GoxtPOHI11mBS7SJJgYF5ajRy1cXI6PSH2bkDz3okCJsUkllqkxlDJKvkkntHROEY+pxzjwdnfUbfYrqijkQgZCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dBoqVEtDZ49Wbnr+MCJLr6pcCwt+V8LpkTZEbXVWRE=;
 b=ZWQgBOv1u1AtVXGNcMlouX5tDCYsVRFjX8HH4FGjoFk0vNN8gzcJk2xz42G/qOKCjrTMtam5n/TdHCJglJ/+qGTX38Ru14QaYZGz/mrY6etv63xzE6Z2UoMUqb+R3W19lJHOaXwE+OBjuKQKzXEbzIe4hUSEVgIN7AbQQkdd5QYJOPp6PsoReWrClsQxRhxEQZ54ERoDqpju5Hvl7XmW04uHezA0kJ+VTpQh5LFLQWN+zemJJnymy7c7y90gmtLxdCH8+oD54f4+aSHU7iS1go51Mor61UlWoEyJado2rR53wbzpKsuYiSHiQU9uCLpCNu0ajCada33hWn18J6Qgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dBoqVEtDZ49Wbnr+MCJLr6pcCwt+V8LpkTZEbXVWRE=;
 b=qK1sru8lNMMOnvB9EKcj5JcPXl7GurhB04rIaNA8PmMvvnlYLGufoFfkpVHk2P8Q4tGQvmaEC1qu++RNfeMDH40hNhyAacoDvHFOnKYgrOX9zxf1ohiS9z+uU+zzYosnjUb9h07Kd9lHX0vFFrEe7+8rVfQw8J1ZFFQ+IoStcGw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:30:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 18:30:42 +0000
Message-ID: <77c28c7b-3ba0-4304-a4d1-6296528fa84d@oracle.com>
Date: Tue, 6 May 2025 19:30:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC dwarves 3/3] btf_encoder: use function address to match ELF
 -> DWARF
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org
References: <20250501145645.3317264-1-alan.maguire@oracle.com>
 <20250501145645.3317264-4-alan.maguire@oracle.com>
 <85008f75b2715a6679cbbb84ec473fadd77c7a39.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <85008f75b2715a6679cbbb84ec473fadd77c7a39.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 79903ab8-e4fe-45fe-664a-08dd8ccc1b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmlSMW1tUWJ3RHVYZngzRW00cEZwOEp6OU45ZnpteGc0UCtYTWF2N09zTGhL?=
 =?utf-8?B?SmQyR0o0c1hPRmN0T09TOEdnL0lGbkpFNGZ4OXNPUWtIbTlHbmtQRk5sUHlp?=
 =?utf-8?B?VWhyTzJKVGNMY01melptUi9POTdkRVlNMXE3LzVDWThjNW14U1gxbGlLOFQz?=
 =?utf-8?B?VzRSOE1WaTdVQVZhM2l1QWcvbjlLM28xTzhkL2d2ZFRVaFhLSXc0K3U0RFll?=
 =?utf-8?B?Zm1jR0ZrVkZYZWZOUXl6eVJVdTQ3RGkwU1UrcEVZU0wyMTVBMkg4WXNmeGdn?=
 =?utf-8?B?STZDZEt4NlNCM3ZQZVVncFpIZ3VWM0ZXeE90L2J4ZWgyNUJlOUNpUFRsVjE1?=
 =?utf-8?B?VkdkUVRmVm85TXVXQzVGMnoxMzhnQW5kTkFmbDhrY2dnSXZTTTZxYkVKMFlv?=
 =?utf-8?B?RDRCVmtyUXFxVUI4WTh0MzJYYkhGNm1ZK01xdU5KYUZKdEd1YWpldWd4YVJP?=
 =?utf-8?B?Z1NheTQzZGlrTHBpY0lzblBIRnkwdmpTTEtsbllxTUdKbE1vSHFTQTVaM295?=
 =?utf-8?B?ZkFFejlQL25NaW53bVM3L3luWmkrc0FweHFvYzJkV0trWXVyQ2pEbTNMNHht?=
 =?utf-8?B?RlQrWWMwNjJCOXNFYVNCVjNFci9xZ1psa0twMkhZSTU1aVBraUZPQWROSG9C?=
 =?utf-8?B?WlJpSW9aRjJyWnY1MkZRYnNCMjIrSUhyU25LSDNLYWcxMG9jNnZlVmhlWFRv?=
 =?utf-8?B?dUVYaEVmVDFkWmlzRjlyL0M5UGpHMnFMZXZrRzBNd0xSaEhDczNZb1cxQUxk?=
 =?utf-8?B?b3B1aVZLQVhvY2VTYUFZbzJJYUtwR015cXl5UDNsbXZ0aTRSYWEyaTh4OGR6?=
 =?utf-8?B?dmd4cWU3NWZvSlFEd29BZTRCZFczUG1NOHpxZXRDQzdSM3ZIRlBZS1V5aGE1?=
 =?utf-8?B?b2tTZmNJRm8zVW1WRnJFTUl0WlVEcWxpZ0c0MTE3ZUJsbU9VTDlwQW85MFZN?=
 =?utf-8?B?Q0M0UHFnU1B1eTB6dXkyZ3pYY3MxRVVsQzNMajN0RmJlYmJzNVIzU1hGQXZL?=
 =?utf-8?B?WFRjNkRVaFJidEJOU2twdStURWhmQ3hyK0F1MlFKOGNwdXVHRkhUU1hacnV6?=
 =?utf-8?B?QXYxVDJhNXBTdk0yUGNNL1dLMTEyVzBESEVlWnJsVzVEaDNrT1I4ckszc3g5?=
 =?utf-8?B?UXJoNE1XcHNwTmd0VGU3bCthNUFXeUJIQWpJbkREd3RqamRoNngrZjdZWXhG?=
 =?utf-8?B?YnRtTFdLcTlWc1hPRFhxd3hPbmI0S3JUNTVabGtic2ptUDc1eFZBdWgzMU1j?=
 =?utf-8?B?Szg2STZZTmZFZU1kN1hZRkFvM2Z0NnhISXdDNU12Rk1xMWZhMnRCTjlBNy9t?=
 =?utf-8?B?Y1c2VXFOS09iNVBhMC8xRTRmUC8vNHI3ODRwRktYTktLNmtwaVV5WWtPOEFU?=
 =?utf-8?B?RFFwcVd2bnhFSG1tN21VWjZzbjM4cVZvc2hyT09IbTBrTzcyYStUTlZaeGh5?=
 =?utf-8?B?bFhmTmNmblA1RXdIT3VNV1A5ZmtVUUhnbDRTSXlCT0RHdXNLa0hQL2dmOFNx?=
 =?utf-8?B?OGRpeVZyNGpncXQyRUNYMGhHZ0xkRERlR045bEJHYUU3R1M1S0ZCL3lWTjg4?=
 =?utf-8?B?OVI2UGZsUGY5QW9MbHY5bzc1WVB4Y2tlQkoxeHJIQUJ5NWl0K2lPNHFQRkV4?=
 =?utf-8?B?S3psRnIxRUxNbi8xZDRlS051VXQrTWJ0VmhhRklaVW04ZHk0bUw5L3l6eDAx?=
 =?utf-8?B?QklCWlhjZEQ2dzByT0R3djJWWXIrWmNzS09hSnk5alRabmk3YUtHeHNNNjc0?=
 =?utf-8?B?YUgvSUhzVnRyd1B3TWZOdGF5eUp6SkFGZG9JNm9Odk1aMllZZTJPUUJzUU8x?=
 =?utf-8?B?eXJvdjQ0RFBuNmNPdVBTZkNiZkRaY1NoemVGOHduR252UDRoZmRERVMrYVZm?=
 =?utf-8?B?QSt5MHRYUDBtVzBUQlZrVXp1Q3UwYXo0Vlh6TDZyRTZCODBEY1hkN1BNbGds?=
 =?utf-8?Q?l7+hnzXJ5ng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGRpMkpRY2srNW94TUVLcDArejFGV0hBS3BmNW1LMkhjRnl2Z1c0UDRQa2Z1?=
 =?utf-8?B?SUJOVWdTTVREdlRMZmxESThvaG5ERVpBRjEybGZOWFVFbE9VbWRPSGpKcTAw?=
 =?utf-8?B?bFZ5TjR3MFN6dzhJTDljQUEvdjJ6amZoSHVhVCt2SzhOckxxS1d3SXczVmh0?=
 =?utf-8?B?OVZ3Wlcwank5cHo0U1BubHA5VzdMY25PTEtZenEwcmhIbG02Qk5DQjhaY1ZX?=
 =?utf-8?B?Q3BFNUxKRnBBWVhxaUNvbkFkUWEzSTdNSU5sYjVnYkJ0dGRqa2VuMkt6NmRm?=
 =?utf-8?B?VUR5MmlVZ0hQU1JWOEh0eTRHc3NhNzBHcXhGeVlMdlg5MkRrWjBIaktYeEVN?=
 =?utf-8?B?N3RhYytMU2JpQ2R5SkNlaGdwdnBLM29uZzNvQmlpeTVZTXN2SWNUU1g0b1Vo?=
 =?utf-8?B?SHROdmdkb0pzWnN4QmpkWWVDMjJleVM3WXhabTRWeDQxdTluOTZOWFpZOVFw?=
 =?utf-8?B?QWhPcmpTQTJ4UFNtSVlMVlhvMUJxOTQzYU81TysvNmVQdHprWWh0ZEg1d0lt?=
 =?utf-8?B?WXk2OTFqVUdJVmlXLzNJdmN1UmlIdkJIeE55ODZTZURST21WeFNqbzdqUVN2?=
 =?utf-8?B?VWtsMGRaa25TOXZlWWRqRTE2aVVQQStjRW14czN1OTVPL2oxUjlnR2VXZUdr?=
 =?utf-8?B?V1MwNGxFZ0kvY3N5UHp3dlN4UkQxbFQrUUYzYUR5UnRyMkdZdVhSRDVBajFN?=
 =?utf-8?B?cmpKVXBOUjhGdTViRlhzQ1pZQ1VyYTVGL0RsRWpXZWpLdUtNSWwvUXUyVTl1?=
 =?utf-8?B?Z204V3BFbnpUVUd5aEJMQk5tVGxCZ3JEZVVLTmJWTE50SWhvUkRrNW5pZDJW?=
 =?utf-8?B?SC9zV0YrSGkvSjNGd0cxaVRyVDhCQkRGUFQyUVYyN0FTTS9od0lSTDdlRnJO?=
 =?utf-8?B?OVR1UnBVdXZLUVRMSUh3amxqQUg4NEhsbkx4QTFOYmk4K3g5RjVtOVh3Tmpj?=
 =?utf-8?B?ZTcrcHdQYTlUcythU0J1U1lsZVNrSDFteENRVlBFamRIdll3YjZ0V3hOK1Ro?=
 =?utf-8?B?M0g2bUIvclBWYm9WVERPdFhSZUJMSzJtMlVWckdQZXFDeFUrNXgvbGwzTTJD?=
 =?utf-8?B?dTBPM2NtODdhZUtFTHVxVVB3ZjdiSlNUUXFGQmVGQ0lBTUVJMkQ2U2IzZ0lm?=
 =?utf-8?B?QjV6eTlMNFFyYWxBbnUwZlNHMkE0VEN4dVkxM3BBWEVZVWcwdGY2ZG1KVXRn?=
 =?utf-8?B?RkFYR2hEK0lBWVR6K29DeWtFbzlkNjl4L0JodklINS9xcUhpQXg5ZHFGWlJx?=
 =?utf-8?B?V0piOGFOcHhBV0R3c2lCaHNINWFKcjlSc2xpOUs4aURoYllHM3F4bHI1MjEx?=
 =?utf-8?B?ZndmdW5QNGJEQkJKdkZaZzhScU9CdmtRTHNVMW9YYWttZzQrZCtIa2liSm5O?=
 =?utf-8?B?N0cxOGRnVDBSMnpoS3I1UGo1N2oyU0FOUzlXVzJlN3paMmV0bmNYQm5tOTMr?=
 =?utf-8?B?TzNHRjJxQ21DSXI3bkh2NjVlT3hOMTZZVndQUTk3L0RDa0FLY3Frb1BzSEpR?=
 =?utf-8?B?cFRFRm5PVnRuOEJkY1doYTZjVDJ2eER0d0FuWS9kdVUwaU5XNGFTdGlUNGhm?=
 =?utf-8?B?QUtoNjBha2k5N1lGa2lzeU1MdndjMHcycE1UT2dWbThDOTFWYkJJM2RYVkJV?=
 =?utf-8?B?TzVlMUhQVmhoYVlGU1JBL1ZUUDhrdjVCU2dKUmlCZFpTR3E2VEpBUC9scWw4?=
 =?utf-8?B?R1hkcXYzZ0YvUzYzTGpzWjNSeDFFUkloWTNqYmJkWjlVc3RCS2E0ZllZME1M?=
 =?utf-8?B?cXN1VElLWVNLUzRPKzduY0RGaFg3RnUvUkRNTTRjK29nc2xEbDdWTFhTWDky?=
 =?utf-8?B?Wk9Vb2lPWXkxY3JqUit2SmRaM2xmRW5ObWpOYXdGaEFuZW54MGsySGkyV3pJ?=
 =?utf-8?B?ZDcrdW9iSDhCREcrR3IwcnhJV3QxWU1LSUVXYXRSTHViaU02UWY5WXE5eFpS?=
 =?utf-8?B?ZkYxNG84RStYQnVoOFkyN2k1MzdkY2hXQ0tnSUhFbDhpQTd3eTdEc1daU09U?=
 =?utf-8?B?MDNQU1RaSmNyWHBFN2hreCtUMWdyazFBQkNIanZvaHlLMDBCQlIrQnh2WUV1?=
 =?utf-8?B?VkVPTm9WdnpzQ0F1dmh1ZkRjWS91c2F6T3NFVUZ2TjFxUXh5eGx2SHR3RWtB?=
 =?utf-8?B?dTEzNENsUXZrZWF5SFpMS2lnYngwY01ZUDRyM0NMNTd1dDZaTkVrdFlnMTVx?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2QWbhRRr0ulujAbyNFC5+WZlmN8RAw+/ohRmrmcH1GhFAlVdns+W6Om7Nq9Xq35J5H9rgcX19GBrNPIAiROj9ojpslsLlI9CKMoMmnYq+dzOojzYtJCD+Z60D54FUsMcCOzU8Xid2Ct+tB+24jT9aguXbyW0mtzvBiwmVgtl1an/y6Qe66ZVUwTTvEYSmbu+oVd3bH9CIQcdfB38T0CdEvptSR++SPI4hQgvf9eOodRYkkC6EhyAJKDiU4SUYfPwOm1Y3+Y4gaaGXBu9gW6gw7QthPuqdY318v4zPoKtUpLvcuPld4pvkNRSjEx9wEFtFb7+3W8Cki9HycLdqIrZbBYiI4W1EAoZ6zJDa83Rz/U79UAJ1RjX+BYejGHHMKqN12o5hLCgoyFoZ67xyExb0j2CcgpR8sa0sdoAWx8ZcMDNEd9rbjoMvfjmpDEZO+NmZr31xjcOD+61fo/48gMAz7lTfT4cc7v0q0Ar9+EUPmUEj/E+pM1WFNz9QY7NcmOGXc2ORsWBDB94lV6UllVxyh3s+9e60UCX/f46eYif9cbM23XByoGY+V493I5Ul0r+/nibfeXw2voAY5BBnIx9IttW1vhvi89vPsZ79NSSurA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79903ab8-e4fe-45fe-664a-08dd8ccc1b5f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:30:41.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfJT36OAwc9NXbuzZ9KFItdCqwLFLcQqssXkWJndduTjeSk1wwqVPR3XdgAIn3+THvE3jS3Pu0b4TwAaHIH7CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_08,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060174
X-Proofpoint-ORIG-GUID: 1bVLgbxWUU052C2wxue6nTOoX12pdBld
X-Authority-Analysis: v=2.4 cv=ZPPXmW7b c=1 sm=1 tr=0 ts=681a5559 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=LrsLCNZWpwGHxiLnfnoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE3NCBTYWx0ZWRfX2EA1TfI8AfkD AegM2LHJnt4YeY9RH2vWwfaIQBbNHz2Viki0IY7IBly2Nl3rhfztd5NH/16B5a4nH/AYciinYyb 0JFVrdpY452O8YLw/8R7G8TPTc2BpD/Yemkf5JJuveraA+M/QhTEX/UXzqOq09YjJaIiF0CPxsJ
 X5mTfyTMd+zSwfwK9pyi3X74cFP1+N2dFN6fNWUC5Y5MeOsi8rSjhiWHiNqGuDYQ94WMVUCOIhR IVyouRPdV1WjIado1RCyXJXS7Gp2XVoU0P55LxtQWo0m4uXb6bl48QIkAImVUpJjz/e/UfwcQTL 42Ti42Ik6BZ7xAVfYbUrKARBbPdn8qC1RHMXOeT/L/swHRdXnAy4NgTt2kTg5qqEIkwFwq9cWbh
 /OkOmGqOURcRevzyScWw5f7Jity+4HcMofG6uwMHDN9ynpTXGJ4aQTpwL0orLGJMN7lae6Sq
X-Proofpoint-GUID: 1bVLgbxWUU052C2wxue6nTOoX12pdBld

On 02/05/2025 00:25, Eduard Zingerman wrote:
> On Thu, 2025-05-01 at 15:56 +0100, Alan Maguire wrote:
>> Currently we use function names (or prefixes in the case of
>> foo.isra.0) to match betwen ELF symtab entries and DWARF
>> representations.  This can lead to wrong matches, especially
>> where optimized function representations are concerned.  Instead
>> sort and search ELF functions by address, and use the retrieved
>> "struct function" address to carry out DWARF->ELF matches.
>>
>> Note this is work-in-progress and many functions are missing as
>> many functions do not have - or at least we have not retrieved -
>> address info associated with their DWARF representations.
>>
>> As things stand, there are exactly 1000 functions missing from
>> BTF encoded using the address-based approach, since we skip functions
>> for which we have no address info.  This approach actually adds
>> 63 functions, so there are effectively 1063 missing functions.
>>
>> 485 of these missing functions are __probestub functions we do not need, i.e.
>>
>> [66116] FUNC '__probestub_xhci_setup_device' type_id=61452 linkage=static
>> [61452] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
>>         '__data' type_id=108
>>         'vdev' type_id=44186
>>
>> The real function is:
>>
>> [147543] FUNC 'xhci_setup_device' type_id=147542 linkage=static
>> [147542] FUNC_PROTO '(anon)' ret_type_id=21 vlen=4
>>         'hcd' type_id=37057
>>         'udev' type_id=37029
>>         'setup' type_id=44209
>>         'timeout_ms' type_id=9
>>
>> This leaves us with a mismatch of 578 functions.  These include
>> 140 missing __bpf_trace_ functions, which are definitely needed.
>>
>> So perhaps we can fix up our DWARF representation to find associated
>> addresses for some/all of these, but we may end up having to fall
>> back to name-based association for some cases.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
> 
> Hi Alan,
> 
> The change makes sense to me, the code updates look reasonable.
> Interestingly enough, I observe much smaller discrepancies, when using
> llvm (version 19) for kernel compilation:
> a. functions detected by dwarves/next but not detected with patch: 56
> b. functions detected with this patch but not detected by dwarves/next: 70.
> 

Interesting! Thanks for testing this! Good news the difference is much
smaller here.

> I only investigated group (b) and noticed two oddities, there are probably other.
> - function "kmem_cache_release" is discarded from BTF by dwarves/next
>   with the following log:
> 
>     kmem_cache_release (kmem_cache_release): skipping BTF encoding of function due to param type mismatch for param#1 s != k
>   
>   while it is present with this patch.
>   Debugging a bit I can see that btf_encoder__save_func() is called
>   for this function only once with patch but twice by dwarves/next.
>   I suspect this happens because of how btf_encoder__encode_cu() looks after this patch:
> 
>     int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
>     {
>         ...
>         cu__for_each_function(cu, core_id, fn) {
>             ...
>             if (...) {
>                 ...
>                 func = btf_encoder__find_function(encoder, addr);
>                 ...
>             } else {
>                 if (!fn->external)
>                     continue;
>             }
>             if (!func)
>                 continue;
>     
>             err = btf_encoder__save_func(encoder, fn, func);
>             if (err)
>                 goto out;
>         }
>         ...
>     }
> 
>   Previously find function call used name: `btf_encoder__find_function(encoder, name, strlen(name))`,
>   Because now it uses address specified in DWARF I suspect that:
>   - The function is inlined or something and has different addresses
>     encoded in DWARF but only one address encoded in ELF symbol table.
>     (There is an inlined instance of the `kmem_cache_release` in DWARF).
>   - `func` is NULL for one of two DWARF instances
>     of this function and `btf_encoder__save_func` is not called.
> 

I think I smuggled in another change here; skipping ".cold"
compiler-generated "function" addresses when collecting ELF functions.
Is there a kmem_cache_release.cold.0 or similar perhaps? With this
change we don't consider it as a candidate match sice a .cold is really
the function, it's just an infrequently-executed cold path subportion.
Such .cold compiler-generated functions don't usually match the function
signature, but we were incorrectly comparing across them too; Alexei saw
a few kfuncs getting left out of BTF as a result of this.

> - another oddity is about functions with aliases, here is an example
>   from `thermal_netlink.c`:
>   
>     static int thermal_genl_event_threshold_up(struct param *p) { ... }
>     ...
>     int thermal_genl_event_threshold_down(struct param *p)
>         __attribute__((alias("thermal_genl_event_threshold_up")));
> 
>   In symbol table it is encoded as:
>   
>     238180: ffffffff82b2d590   611 FUNC    GLOBAL DEFAULT     1 thermal_genl_event_threshold_down
> 
>   While in DWARF it is encoded as:
> 
>     DW_TAG_subprogram
>       DW_AT_low_pc    (0xffffffff82b2d590)
>       DW_AT_high_pc   (0xffffffff82b2d7f3)
>       DW_AT_frame_base        (DW_OP_reg6 RBP)
>       DW_AT_call_all_calls    (true)
>       DW_AT_name      ("thermal_genl_event_threshold_up")
>       DW_AT_decl_file ("/home/eddy/work/bpf-next/drivers/thermal/thermal_netlink.c")
>       DW_AT_decl_line (263)
>       DW_AT_prototyped        (true)
>       DW_AT_type      (0x059ec28b "int")
> 
>   And I assume that it is not in the BTF generated by dwarves/next
>   because of the same `btf_encoder__find_function` check.
>

Ah, good to know. Will need to think about aliases too. I'm hoping to
improve the number of matches in gcc, but it may be the case that we
have to fall back on name-based matching if there is no address
associated with DWARF. Hopefully in such cases there are no ambiguities.
Will investigate further and see if we can do a bit better with
address-based matching first. Thanks again!

Alan

> Thanks,
> Eduard
> 

