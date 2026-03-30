Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030F3C2767;
	Mon, 30 Mar 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865641; cv=fail; b=D/KdJGoSMbdSaBJWjoLbmwx72lz+KL3zYqzWLeo7ouUvCxDqJ8wK/SkbH5E6C/Qptx1dx7P7lNTwn6DLItjJ3PD6Hbm4lLqHOZsVoA0DxQZLz7enSp6R9jRsI6GTso6dZ1ZB1MEe7QdWtaHh3BSS700IMIXb5uVcmRPbErdgUGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865641; c=relaxed/simple;
	bh=69Ff3f/utkohP5kdgO6WDrOEi4fUZ/yb6LtVOPnzaQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TTlz2IIb0hG1zb+9nOA7NV8ZG38s136v3AFJu2RQwmqUzV4Qmyf1YIP97Y/PEk9JdFMFq+Tj5sjeKX1zISc3e/M18cPEl6Ib22DUMqYYoOs/gs3PnlW7NZyegN9Sbdol9jEQVyIFPPyIJ/XrhyjrSywwm7SVGSw8g8GeQNdVniA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fzYjHPnC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g2/LU0BU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fzYjHPnC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g2/LU0BU"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TNnE4A1475303;
	Mon, 30 Mar 2026 10:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X5tL3pUy/ENmDRnnPE4FTh8X2/rl9QNCsY5f/IlKERU=; b=
	fzYjHPnCei9PlM0y0dgbnLdoSFcefRI2+5pkQIBxmtbepU0ZQWrfl/EQOt1QBLaV
	LzTMlp36Khbcgtrb7bpvbeUrdZLXjPUb1ZGjJ/fe/nsOL4msOtvGItkrdUoGXL4Z
	k6HFgAo2d/5LBO9Qc/nCFigPOcUpQv0DZkKLSGwtYHo/GrJaYcJEuFrjm3bdFIIK
	tCCJmLhrc70OEXAxzN5StvmKGwoiPWj9hrrivyaNt0zUZO5juDFIKCHZ/U8j2bFd
	AqQfd8rtSLQO6nOEP6+V88WQhhgacpT5iSY+yMXHwZzGS96ZId+TIknaMzQxTkca
	snA0INZ0CHaXX0okeCeYAQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65w79vwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 10:13:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62U8Qrlu022422;
	Mon, 30 Mar 2026 10:13:42 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65eejttt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 10:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQSKVPFVPydNlwtyeR3zQAO16w9j9KeILltoBz+44G/cDaFwKNalD46RLqth7X9+1WgcTRGEydenAIhSp3kpjizY+BdfGt//yszYDUdNzmd6V9nNgcZeXrKUE3di4yXd2/EQOyaW3+99XWa8npFjDxAPnVZ4i8I46U8Flwq61DaiWVGstVG5zDY27MlfdU80UOQ+D6hvdlwoniq+BJx4iWvpoLWzlTTPHWLwfHuwoRVX26RJomqATj5Z7QJD7RglmMW/z9TkqpfTOaJDUsKGDqS6gfVIKFq6c4ODK2eG/kOpcn/XW5YlJLlbd62yZZiMreNmfP+zh3qgGNYVw8QxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5tL3pUy/ENmDRnnPE4FTh8X2/rl9QNCsY5f/IlKERU=;
 b=tncnaG6O5Cf+0fxER1dxt6HX9HOKgFUtRwCGWgi7alTdiSbRgxqA+zO1W3aO/Pn686bDY+Rf/Uc+5r+gI6GPwEOE3YM0Gr7w2Oqg9XN3Pv1EjeuHxRuN/++nIO123XDyz2IHtbaSLPG6pnLmYHimD6sxpokRBY+b8fEEunjfauBJJpKIZUXesYovC4VDqENTLarU6LIBJlRjpLV6wYRAjCYLbuiPkAEmd0mz0uUO1RaBAwb2IWBi+/K/e0RlGbKhGuv+jPVlaL/ziQD2Ttxt7P/Z88ZzWaEMtj5vHqHDOtDmX9H2vPbsuwJZ1RHmR25FskibQOov/cJfZtHNaKVMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5tL3pUy/ENmDRnnPE4FTh8X2/rl9QNCsY5f/IlKERU=;
 b=g2/LU0BUwUwnFsiIN+1ZXilUmLP9A1Bl1y523iNKu6GtCnRRmMQchQQzPHzwr4uNtlX+VOmuPEUdtCFchnitetPuVjBS4JG7R9tjnii53m4sIXliLWAG2fBsNkysBU74JjPk+47ovZXOoENcFawbLgEEB8cYO7resiwat6FMR7I=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 10:13:33 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 10:13:33 +0000
Message-ID: <8b591079-987b-485f-b37d-f4207dbac08b@oracle.com>
Date: Mon, 30 Mar 2026 11:13:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 03/11] dwarf_loader: Handle signatures with
 dead arguments
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
 <20260326013159.2904078-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260326013159.2904078-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2efeab-cd65-494f-1da9-08de8e44ffca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HH6U2fWygyVbBX+z77YNrmo+Lk97lRGkKlUn20xdMfXS58j0qQmqftr1vYp8QWjqjUdR951HHoAssv6vI4r7f5WXnuynY5mBpkx6LOFQIeRNr5fuhXRZgcpanURZoFEAeIJqEQQNRksl3L2w34SeuHYnQL/gR7wXFLImsy5ZJmSzxvmK8nYhAx2cZBN3RkQPQuB1fYeYIXBGy6p6h/4RSIMTxPUPpl3SwkcjyocLuJ9gyhNu26d9FQqIkvqq/On2va3WHaIlvuZFogCVsm55bCOlP/S0dv77X7qycUUSY4ioaz/+CK0pq7qYG5S7tiyfpciJbYUO4lsQ0hJaFcEZTGCPV58xTqw8UMF5usPVIbGV3FKKM69OaA7+JiWjP1287ZQ0pCosd0tWoJUSmmpNYSqL/iKQd1mez2kR/VOzLPlLp4CYF53CZWgGoHdW+PvBVMJghI4RzlvN3+XhqfI2Ys9iSyfxw5c7THSNYX5E7AGWHRGspx14IKx7qcmQyqLrJhzoBLl45rOR8tsd2TjKDPAY05EZ2FjeAtvbq1bcY4owolehOYExADNWoWz+qzQBohxcwQ3xYoE0upfEIuGsrgf4UdC0ExLyaoDKKqTxydEhtTnxENG07h3ogObi4UcTQixTHAIfwcfHxAVkrqOrqdsf5kG5x+2Vwn792w3HZRm0MlKJiOufqSf3rXxiHtAIrw+qYrhElZ5M9NgW6bCg+LpK0tcNiysqt7l2yeEa3Rk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akttSlA3ZW5SRGJuRlJuLzViYmZxNnZoUFBVRm9JK0JacmZYMmdoTTVCSGtx?=
 =?utf-8?B?NWgreVlBVTgwNW9UYlE1NDI5Z2Mzc2paUWhlbEtaNHpDcXFMZkJPYU00MWhT?=
 =?utf-8?B?VWVYTzJRYlRBUmI1NVlLelFlTVlXUU9yZjl5cXRldWNjdyttRVRXclNUTERp?=
 =?utf-8?B?YXlKNTkxYmk3d2JBQk5NYldIYjJiNTJxZ1NwTGpFY1Z0bGxHNUxMK29GK1pH?=
 =?utf-8?B?Ris3azd3L3pRMitNR2RLdEoydTdZbTAyMk1tVUpmd3pUQS9GWEtvbTRiUFh0?=
 =?utf-8?B?aTFENkRRR09iZFhqUlpjZmJpVHRNcTB4NlcrN1dnZGhhRVpKN2VyUnltTDNP?=
 =?utf-8?B?R1M1YjdnSWxXcFNNVmhyV2hSV3ZpeE9zNmRCUmhvSm0xQWY5SmhhVkpHT0dx?=
 =?utf-8?B?dThjRnVVdkFlakgybUVGK2VTeE5mZmlUSFRUQ1h0V25kYVNOL2NIVzdwSXdp?=
 =?utf-8?B?VE5zTlVwM0xYUlVlb2EzZ1B6akwvdGNQQ3EzQlNuREJkam56ZCtkSk1JK0V3?=
 =?utf-8?B?cEpNajNXM3hlUzFVRnBDT1BxOTcvRXFIVGhZZjI4OElFdkl6N0dXUndWSkgv?=
 =?utf-8?B?WmdybjdWWTJOazFxWnRLc1hvSnBXc3ZNckJhRG1xb2pvekQ2eUVhSDVyL3Fq?=
 =?utf-8?B?NzBuc2NIWEVoME9aNWZ6VEw3UlZIc2xMSStnVjhoY20rdFhSZmJzK3FZZlhp?=
 =?utf-8?B?Rmw5RlZsRHdCR2tYNmNsS3NtbzdPdkR1c245YVNIN2hUWEdUSUZXeVdHcFZZ?=
 =?utf-8?B?RGRaMFlXcTNrVmlVdTFjcnVVME5OcWI3bWFQQnlaeWlHcDl2cjNLdGRvWkVr?=
 =?utf-8?B?ZjRjSkVUZ2JJS1JzdVQ1aTIrcjVQQ2YzMzBhUnY3RmxhU2FJMmpsaTdwRkQ3?=
 =?utf-8?B?WU1RM094c3E2SHcyRW1mY0hJZHBTMGtZWVFWZ010cGxGZDY5SytqQ0JRaHIw?=
 =?utf-8?B?QXFMR3NjbHN1YlkzRjl1TjhaRVdtNE9CQkdMdjRocmF5NGo3clBDaU85bVpj?=
 =?utf-8?B?akNkZDk3djdwUnJsdzhJaW15enRzd3RnSE1oNGRla0hFL1EwY0t5MC9HYm1P?=
 =?utf-8?B?N0NUR1BJdE43dHFpa0VYb2Y5dk9qRUxzZVZZa2ZmQXJFazViNi9ETzJXREhM?=
 =?utf-8?B?R0FkQnpsajJwQWV5OXo3UXh2cGx1bVFyZUFSUUZQRGN5YkVscEEzQy9uQ1lR?=
 =?utf-8?B?ekZvaTJwcVE5c2tHMXRFNy9rL3F4MmZXYU81dnd4SFByL1ZCd214YTkxQXJW?=
 =?utf-8?B?NTI4VzZGMmRydm9oMy83WWhXT1AzUjBXSkJKTk5ndHlvZHdXUnRJVWZkZHJR?=
 =?utf-8?B?R254dXVSZTNuWGNtUWRISGEvcGFhcHI0dEM4S1JGS2hTbzBzMkluVGNsTzRI?=
 =?utf-8?B?RlRUSG1EUUoxWFNsMEYyWkk2MFJOZk8zQmFwcUVuN2xJZDJzQXlhNGFwbktN?=
 =?utf-8?B?QzlhYmJVZXlxaExFaXZOVjBkZHFuc2FrbTRtMG8zb2luVC9jdGpDbjR2VXRO?=
 =?utf-8?B?bjd3dGlJQUNIZXNZcHdYOVFmc0duVm5QVUlVYUVZZnRtRFZSL3k2bEVrSTNl?=
 =?utf-8?B?dUh3cENGSXc4RnJTVVc0Kzd0MGtSSmhvUTVyWTRPSFhUN3RFR2xXd2NKcU5L?=
 =?utf-8?B?SGNBd3creHk0cUNhamZhN0FFa25TOHY4YTNNcUo4WGlSSHZ6Y2FDc2JlUjlP?=
 =?utf-8?B?WVh6SE5UL1dlZTdhbFpnNWo1ZVVYeGh4SXphL3gwdmhGdU15TFZWMmlyRFlE?=
 =?utf-8?B?SzdVZGRhaXYvT1ROS3Z5ZlowVTZrTmRlZG82dEpiR3dKVk8rYW1hdVhubXg5?=
 =?utf-8?B?anp0aHlxTFNTSWNmUk5zUmxLNVJUV3BrVEVuejNvZ3p6cWpRUGo1YXl2ZlRk?=
 =?utf-8?B?QXRxLzE1NnVQdjZ3aWorbGl3cFRKajNxVThCT2hnSHBSZC9sZ3BoZTNVNCsy?=
 =?utf-8?B?Mkg3RmlTenZFd0ROQ2dyL1JvT2crTGVtbjBvZjVQU1RtR1ROQ1FkS2JRU0ZP?=
 =?utf-8?B?TXozY3lsOHIyMWZ1U0ZDUi9OWTBycm4zL3Y2WjNQam9OdURKZHdWVHI3S2lO?=
 =?utf-8?B?enFUSGZqdnp0UGQ2dTZEMmhqOEdRUTdIMUt4bFFJVnNaNytFWmJKR2dYcHl2?=
 =?utf-8?B?YXh2a21sUXY1VGcvWkI4S3F3cTFwSjFyczgvMjBFMkdZNFFEMjczLzB4WVR4?=
 =?utf-8?B?eEJjSVpaVW13UU1PWVVMRDdzYjhrTXhnR3NKZWRDWDRaUUtUNmhUeGJZL1pE?=
 =?utf-8?B?S3hwNUJhN0YzQXhhMitSR2NoVFpxbEgyZy9EdjFQN1d5OW15ZkcxZGM4UElO?=
 =?utf-8?B?eTJDTE5VaFk4OGhEWWp6Sm96Nm9Rd3J5M1ArNW9ZdEVyREpXNkhjQT09?=
X-Exchange-RoutingPolicyChecked:
	ciL5dYCjyZr5IyUSKQg1TnqYHIAmZPuuWyeyvGzWCQ1X81G7zwbB7/dgvPX+on5IIT9gaPvq1vWbbLJguNad3oB9ggV5uKWeXdfk8os0OdlUDPmboMfWiDLAowjsket3WdKtYmf0GAwaulGz92SXeen6lcLVz3bmaSNpXahXMbepmyXkioG0XHdodp4rXgq7jXe9BsdepTijKGDfN7L2gwnjwfJbUkWTGfMQkeSM2/HkYHSgDKRV2rKR97NUrZQ7foyn99eilUVun9gSyKv1le6qsKKk77tD2AYlJq7h25MlGvZdEVIauHSEloBOVJ7cGUWPioB3lP32xhZbbzIyww==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A1EA1C+qybm+oVVh+rl5TGMf8gdBmr13eL7dlGmZuRUgSReFymQn5VJ3aCVu535mx3S7otW3Zv9tSgVRnGhyKfBISIdZXmycov6ZV55NOkFTcMD9YL4XTAbkFt9whXQxG5K780MVqm4U/IK2KDLTV9b+j3j7MZ+LRwaKlFG4aMFwFkWBGmqkP5nNB6vidFUbzI1SgoljJvRItx6XSZ1kw9XEJ5cmjY6+/27klvhsEXvI3l7UtkbMWTQ1V5AywJhRxijZIRDH/PlMgqqoMpTdGAby93SSS5Mx8/ORAY85RBKuR+NlIcYxorNg9lGV1/a059HqJh3cFSnXmIgLvo32zu45SMi0atj5vU01/g1oKJNO6nbY2OpMbzvkXnLFgA/0apPo6Xi1c43IvFhlTfZ5g1tSMMFNVducIN1uL5R4dv84lcwAlCKy73q5VhPvtjlqIenQjjlJ0EYdppNs73SgFJamKITJ2Sax6G61tCMoX/G9JSdYZw4ND665Uhd71idk3WYTaBPABEBe+5fnGpGMoQECvhyEda++qVfc8hbBR3sJ4YnhZMpRVP4n1GqyaVL7egKjC0f3j5oTramfr49Prm+EPF6+YV/R1TcNBJxcYMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2efeab-cd65-494f-1da9-08de8e44ffca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 10:13:33.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkYMPZxmd9CkmQsl+GU6v2DrBoO4WNdH9bcrWXcoj+Z0AYqg3ZoAq27T5+Idp9GfBOoKxW6sRngJZ2i8PyyhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603300080
X-Proofpoint-GUID: tU-g77PuF7QGqIgPluMjphPHX8a4_5gD
X-Proofpoint-ORIG-GUID: tU-g77PuF7QGqIgPluMjphPHX8a4_5gD
X-Authority-Analysis: v=2.4 cv=DKSCIiNb c=1 sm=1 tr=0 ts=69ca4cd8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=17VDn1QLlj9GSKs-mYwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12275
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3OSBTYWx0ZWRfXzFgFiucs18/V
 QE60wN/Au1y/3rfiIEM04oGtsUqxIF56TG25KjDk4UKOlaYbqizthBnoXTYZH6qcUmvDhHc5pLn
 vVjopNoGlwmlsuHkb8bMteTUbSQPb0xZJsZseG+dgQgLFhr/PfIf2yGZusy/bq3acXjEbAAOASS
 SBD8lKM2eCxbxqjRPaKEZNhL+7dAePr6hWZKhSak0RyzU74sUXnDqXRAyIQZ34/qYXz3fZJ4gel
 K//WjZ9JeaIdSnBCh0cQYdsn9bVAxz1XJUgEGm99oLxlnAF1It/DenqC1J0PofHVDDnzqj/AlUk
 jaGp2aYR8s2WMA+r7Cw3/DCnyn1G3Ndxd/gYlDPv40eRbkcRQyKlhUZA3vZbIg9Z6vPzQxoudzz
 b5b34NUt4YoX6yQIggBMkepzWknlwqhqCU6eJMyDbAlC8AEB1fRi3aC4/FelMtGaMemKg4E65UF
 wCtdIlnSCfAHywUcwDHj+cul2lnzovPRoCjsoGL4=

On 26/03/2026 01:31, Yonghong Song wrote:
> For llvm dwarf, the dead argument may be in the middle of
> DW_TAG_subprogram. So we introduce skip_idx in order to
> match expected registers properly.
> 
> For example:
>   0x00042897:   DW_TAG_subprogram
>                   DW_AT_name      ("create_dev")
>                   DW_AT_calling_convention        (DW_CC_nocall)
>                   DW_AT_type      (0x0002429a "int")
>                   ...
> 
>   0x000428ab:     DW_TAG_formal_parameter
>                     DW_AT_name    ("name")
>                     DW_AT_type    (0x000242ed "char *")
>                     ...
> 
>   0x000428b5:     DW_TAG_formal_parameter
>                     DW_AT_location        (indexed (0x3f) loclist = 0x000027f8:
>                        [0xffffffff87681370, 0xffffffff8768137a): DW_OP_reg5 RDI
>                        [0xffffffff8768137a, 0xffffffff87681392): DW_OP_reg3 RBX
>                        [0xffffffff87681392, 0xffffffff876813ae): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>                     DW_AT_name    ("dev")
>                     DW_AT_type    (0x00026859 "dev_t")
>                     ...
> 
> With skip_idx, we can identify that the second original argument
> 'dev' becomes the first one after optimization.
>

Is there a way we could unify this a bit better with the existing approach
where each struct parameter has an idx value associated with it? For gcc
we compare concrete and abstract indices and if they mismatch we know a
parameter is skipped and set reordered_parm at the function tag level.
We could set the idx to -1 or similar for skipped parameters to cover
the below cases maybe?

Not sure how the skip_idx approach would generalize to multiple optimized 
out parameters; is there a way to handle that?
 
> The previous patch has the following:
>   0x0533fd03:   DW_TAG_subprogram
>                   DW_AT_name      ("acpi_irq_penalty_update")
>                   DW_AT_calling_convention        (DW_CC_nocall)
>                   DW_AT_type      (0x05334dc7 "int")
>                   ...
> 
>   0x0533fd15:     DW_TAG_formal_parameter
>                     DW_AT_name    ("str")
>                     DW_AT_type    (0x05335918 "char *")
>                     ...
> 
>   0x0533fd1f:     DW_TAG_formal_parameter
>                     DW_AT_location        (indexed (0x3b) loclist = 0x00eb9d83:
>                        [0xffff80008419f2e0, 0xffff80008419f324): DW_OP_reg1 W1
>                        [0xffff80008419f324, 0xffff80008419f47c): DW_OP_reg19 W19
>                        [0xffff80008419f47c, 0xffff80008419f494): DW_OP_entry_value(DW_OP_reg1 W1), DW_OP_stack_value
>                        [0xffff80008419f494, 0xffff80008419f498): DW_OP_reg19 W19)
>                     DW_AT_name    ("used")
>                     DW_AT_type    (0x05334dc7 "int")
>                     ...
> 
> It is also handled properly with parameter 'str' will have W0 register.
> 
> With this patch, I checked x86_64 that the number of invalid true signatures is reduced
> from 532 to 96. This suggests that majority of optimized functions are caused by
> dead arguments.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 88 insertions(+), 5 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 412a73e..c1b7763 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1195,10 +1195,62 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>  
>  struct func_info {
>  	bool signature_changed;
> +	int skip_idx;
>  	int nr_params;
>  	int param_start_regs[MAX_PRESCAN_PARAMS];
>  };
>  
> +static int __get_type_byte_size(Dwarf_Die *die, struct cu *cu)
> +{
> +	Dwarf_Attribute attr;
> +	if (dwarf_attr(die, DW_AT_type, &attr) == NULL)
> +		return 0;
> +
> +	Dwarf_Die type_die;
> +	if (dwarf_formref_die(&attr, &type_die) == NULL)
> +		return 0;
> +
> +	/* A type does not have byte_size.
> +	 * 0x000dac83: DW_TAG_formal_parameter
> +			 DW_AT_location        (indexed (0x385) loclist = 0x00016175:
> +			   [0xffff800080098cb0, 0xffff800080098cb4): DW_OP_breg8 W8+0
> +			   [0xffff800080098cb4, 0xffff800080098ff4): DW_OP_breg31 WSP+16, DW_OP_deref
> +			   [0xffff800080099054, 0xffff80008009908c): DW_OP_breg31 WSP+16, DW_OP_deref)
> +			 DW_AT_name    ("ubuf")
> +			 DW_AT_decl_file       ("/home/yhs/work/bpf-next/arch/arm64/kernel/ptrace.c")
> +			 DW_AT_decl_line       (886)
> +			 DW_AT_type    (0x000d467e "const void *")
> +
> +	  * 0x000d467e: DW_TAG_pointer_type
> +			  DW_AT_type      (0x000c4320 "const void")
> +
> +	  * 0x000c4320: DW_TAG_const_type
> +	  */
> +	if (dwarf_tag(&type_die) == DW_TAG_pointer_type)
> +		return cu->addr_size;
> +
> +	uint64_t bsize = attr_numeric(&type_die, DW_AT_byte_size);
> +	if (bsize == 0)
> +		return __get_type_byte_size(&type_die, cu);
> +
> +	return bsize;
> +}
> +
> +static int get_type_byte_size(Dwarf_Die *die, struct cu *cu)
> +{
> +	int byte_size = 0;
> +
> +	Dwarf_Attribute attr;
> +	if (dwarf_attr(die, DW_AT_abstract_origin, &attr)) {
> +		Dwarf_Die origin;
> +		if (dwarf_formref_die(&attr, &origin))
> +			byte_size = __get_type_byte_size(&origin, cu);
> +	} else {
> +		byte_size = __get_type_byte_size(die, cu);
> +	}
> +	return byte_size;
> +}
> +
>  /* Get the first DW_OP_X (should be a register) from a parameter's DW_AT_location. */
>  static int parameter__peek_first_reg(Dwarf_Die *die)
>  {
> @@ -1292,8 +1344,9 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>  
>  	if (parm != NULL) {
> -		bool has_const_value;
> +		bool has_const_value, true_sig_enabled;
>  		Dwarf_Attribute attr;
> +		int reg_idx;
>  
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
> @@ -1303,8 +1356,10 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		if (!info->signature_changed) {
>  			if (cu->producer_clang || param_idx >= cu->nr_register_params)
>  				return parm;
> -		} else if (param_idx >= cu->nr_register_params) {
> -			return parm;
> +		} else {
> +			reg_idx = param_idx - info->skip_idx;
> +			if (reg_idx >= cu->nr_register_params)
> +				return parm;
>  		}
>  
>  		/* Parameters which use DW_AT_abstract_origin to point at
> @@ -1342,9 +1397,10 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		 */
>  		has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
>  		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
> +		true_sig_enabled = conf->true_signature && info->signature_changed;
>  
>  		if (parm->has_loc) {
> -			int expected_reg = cu->register_params[param_idx];
> +			int expected_reg = cu->register_params[reg_idx];
>  			int actual_reg = parameter__reg(&attr, expected_reg);
>  
>  			if (actual_reg < 0)
> @@ -1357,8 +1413,35 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  				 * contents.
>  				 */
>  				parm->unexpected_reg = 1;
> -		} else if (has_const_value) {
> +		} else if (has_const_value && !cu->producer_clang) {
> +			parm->optimized = 1;
> +		} else if (true_sig_enabled) {
> +			int byte_size, num_regs, next_reg_idx;
> +
> +			if (param_idx + 1 < info->nr_params) {
> +				int next_start = info->param_start_regs[param_idx + 1];
> +				if (next_start >= 0) {
> +					/* check whether we should preserve the argument or not */
> +					byte_size = get_type_byte_size(die, cu);
> +					/* byte_size 0 should not happen. */
> +					if (!byte_size) {
> +						parm->unexpected_reg = 1;
> +						return parm;
> +					}
> +
> +					num_regs = (byte_size + cu->addr_size - 1) / cu->addr_size;
> +					next_reg_idx = reg_idx + num_regs;
> +					if (next_reg_idx < cu->nr_register_params &&
> +					    next_start == cu->register_params[next_reg_idx]) {
> +						if (byte_size > cu->addr_size)
> +							info->skip_idx--;
> +						return parm;
> +					}
> +				}
> +			}
> +
>  			parm->optimized = 1;
> +			info->skip_idx++;
>  		}
>  	}
>  

