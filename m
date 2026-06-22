Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8338F654;
	Mon, 22 Jun 2026 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116079; cv=fail; b=pljraeneTZTljSBWNFYKGTKXMgiSSHFrzK2h0knHdCmi+Z8yBM96PEYgwDEPZMvLqnPSlCf8V8RM0LrsJn930sY9huk8frl6FRWOAMGsmnGUQb+68uHUcVTC4s8H6sktATkTfAzIUtU9Hf7/Twk9k1rsIfUbYyp9GdGLs9HA4/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116079; c=relaxed/simple;
	bh=DXnpHkBTsEOtL8vdgWRc0YMh/ICQNoanEIuXEJSfvQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OGhj9wpm4wQ615S+sThOJCCMWQOaAEsqZ9w/6hukykfwykdvHYpsv2XP+W5gpSdNd+TqLKe5fJnbRD3PX99dfUgkVgvPNSzEPluizs156a/m5BanX36F9Z3TvOQLSw4ikmFYhPIN3niKQ6aT8VleY26t5ozoe7NcfzuHlnf9Nys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CQdho3rh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ptccZ2QJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CQdho3rh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ptccZ2QJ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M03ZF9501982;
	Mon, 22 Jun 2026 08:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dE368StdY5zf7V3B/wbRMZeEQuUxcT/PJHiC2YtJUxg=; b=
	CQdho3rhABv0XHChpQSbEGln/ibGb5rw3Rm1T1tWqlxRfbghO6hGki+ZRlaVstct
	Toaj7vN402y78R0b5dPKqdsbCU4boOYeRtVSEADyUZ01OqFgwzS9ighMlaJN2c9Z
	NXXpbCE6N6hPWfI85O+FAo4QuttJEdo3m6JlXkhumHio7MZ042Zrio83d/ilLN7R
	/BzTsXDFaIyuJWlPn7Tiym+uAnkp9TjMvR2/PvSdE+7xc3QkYQuSL0XL1vODe10d
	b67ROGgwKhRVzRpOqKCzSMghbaIh4VLsOo8c8VJLWzvcQS72PrIhvFVDTSG0hIU7
	o9bKuQ0udh3lN+WYmtLa3A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhs91jd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 08:14:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65M8DUP6038271;
	Mon, 22 Jun 2026 08:14:30 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhands1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 08:14:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzCgZkd7nYimIqCzSNwQdH5oKEAeru5DyNywl/9D4byy7Bmo0sN0b1+2XMrkprxg8XULkrU/MFSxWDvFZCHyBSNLaW0KGBmqYzknleMv9csmYY8+lncWCPLF10xPF5QEVmEW3GgZyiuyoOREQCoAnn1HALizwTQIPCpmbqk5EcOE/KoOf8xYP/IKXpKZ4J4Mek+9JDLggIVOk7vLjY3XR0HkXdjq43/4/9bKQNuOjFyCwz/stdQbC6nlsk30m4i521kxM1PugXYL4UktE5vov8cgY7FR8iKDNCu28OkogpB1X0M3k9/XeTdPnFM9mMgN1mmOYVB6YgkmOfYd+hIeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE368StdY5zf7V3B/wbRMZeEQuUxcT/PJHiC2YtJUxg=;
 b=kU/DceSxdl6xDqz0TwKRUmA9P0/y6sIQ3bncyrJlwta1CaM41MWZfEGSHTkNMUJ5VNVR5bDt9ZFBJpii3+7YAqXeq3eid7zS5k8RGTxXG7wtccta0TpD9blzJCmfJzok9yi1MGxw98XF40x4obejADy43L8MYS45yoqfMmi0E1qZzlB/nrHvHN0tPOnIK74IpdF24aGEm0KNz4Fbf2R1fFtngUjDznkta43R8Ib6Wxl/2YCs2zttBcq9tWD53U/TJ4DJdDo9dGuJbl+DmZZKrcEnqtPGMXFSsd3NdOpMypDhB1l19rtPG5gNOToM5oEdXYMnaeBEayTUm7tQsF+jvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE368StdY5zf7V3B/wbRMZeEQuUxcT/PJHiC2YtJUxg=;
 b=ptccZ2QJomSLhkaM4MZJRE1VErp6PxFI/R9gIoiDatfqFLQ/GP+MPsv3BzsEmWwH9IjWn0QHF13Vaq8MR3Htk4DgvAma/Io7Q34P9CZYs6prcFI7pddHL8oCZ4v6bPqRckOgZb4RZIaXkpJuDjQilglnAxXAmaci7mud6S0rMBU=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DS0PR10MB6173.namprd10.prod.outlook.com (2603:10b6:8:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:14:26 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 08:14:26 +0000
Message-ID: <9bc04946-81ce-4c24-bbc3-178a01fe6381@oracle.com>
Date: Mon, 22 Jun 2026 09:14:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v6 0/5] pahole: Encode true signatures in kernel
 BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260618011358.632394-1-yonghong.song@linux.dev>
 <675af05f-6f76-4a37-9619-5275fb941263@oracle.com>
 <d63e4e38-6059-442f-b128-69fad20cab32@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d63e4e38-6059-442f-b128-69fad20cab32@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DS0PR10MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 7355d80a-1e4d-4247-938a-08ded036468b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|18002099003|22082099003|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	ISq5y5xiWUUQt6rhDZC9MEjjI/8+IdRmtyGMFtRWktkrmZfZuAZ/FPPEbN+FyS0Q8qSf/OXrk7/PtisBikgCjcXZ5zQwXp9o5DT/gfqD/UrtuKvX2NViqE6XWRFyTQvurQ0UkOfl+PSfAvsI8dCcX2a6tKYgol+aD+il0++m+9DahSwpWh9oM8g+AhNDCnVZ0rxKXHjwmSJul2ASEdn9ucfl31wyg0TJLC0EybbKTqYthZ4sX/yaoz/P8h0ZqEEejPKk5nZfLZIFkT/Gglhcxud1xCiYBdtlO/SYb/ciZmtUGeOdkng2uWw0EbcODczNAaYtSNea3l967QfTjQ41iM2jzNSAWE+0A+Ab51OUpxmQbRRIxcoQEMg+yZRV7yRyFd4rRG8UCDB4ZzGgsH9LrzRV+wzeALE1HjGVQT9sgCOFOaGQsAVWjClx8yMwHJ2/bAJqB6FriGBJio9NQW+txAp3bZwxRiLN4owv+CehxHBMB1qCEyLAwLQWjy2NOFlaqg5ywdGuWVOnpgozdLn0Ul8qEVSsyLWAjFCGKMDZkGsyotMSPGOtzYjhvmlRngprzsC263jh+iJHH0nrEAInwKATBg5MVWX93MVLQTmHBiSY9xy35lK1/BV8OrO7nIh0zm09ZgQEJSmvQYatsR+HRQ27VhPIyck76m4nvgUYVDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUZsaTJEcmxkR1F5MFFEejJZYUJvMDJYeFlWNi9RUVNGeGk5WmtwMWN1UmQ3?=
 =?utf-8?B?WDErcHplY0NpTkZmdVBCQ2hNc21mVGFOaXBubDFuWUpYQjJ4TXQyMmpRZ2Er?=
 =?utf-8?B?Um01VEpDSFFpaXRaRTIyQ293K1EvOFE4bmF4bnVLNDJILzd3M1BqaW8vbGE3?=
 =?utf-8?B?SDF4U2wvdytEVm1HK1NlQUdVWStpR3pMaGs0YVc3UWVseXRJL3h1V2wweFhM?=
 =?utf-8?B?UHRCOWRQMTFvaVZod1l5MG1DY3huY05RSVc0a2xFc1NIR080QnJaRzVsN0lL?=
 =?utf-8?B?QUs3Um9IdzEzK1E1Y3h5Y05XelpaNjJjWWpnMk5SbzJaUWRKb2ZHMWdVY2pC?=
 =?utf-8?B?WVNGSUtNWFJQQXl6ckdZc2ViTHpzM3NvSURyWjB1N244dWlNZTU1ejZMRjJI?=
 =?utf-8?B?SWw0UTVMR1d5aDhiRkZMSXhaWDBsckJsQnQwWlpJTDBVa2hXMzY3SUI5bEQ5?=
 =?utf-8?B?emQrMS9EYW5td2orZkhITlowTkJHQytKK053N2pCd25IMnNoRHRZd0xlaEZX?=
 =?utf-8?B?NEhhVGF4clRKWjE2a0dqYitKMjFsbXNWTHNkTUFGd1FjT1Z2MDlzM0xYeXdD?=
 =?utf-8?B?ZXFWbzNYQjg4VXVLdlM4Y2NrRjVzWkJxZFpQOVFNVk0rWDlrWjR2MGFtS2I4?=
 =?utf-8?B?YTgrNzVsUVY3RFI5SURJZU1zbW1vV1ZmMlhvOVplSUFCWHNkb1haZXpnQk9S?=
 =?utf-8?B?ZXNQT3BORDM4OUM1ODFleWNMclcrekY1R3BjZ2hIOEsyb3lNaUVxMlNvR000?=
 =?utf-8?B?TDY2Ym9tTHpLcStXbmpYS0o3NmNja21XaWxCMnlDb0dnVFJjdERwZG5KUXNs?=
 =?utf-8?B?Zmlxb1JnK2J1ekxIRTVWdXJMTmtZRmVaWHJ5RUMyTk15aHBaT3NJYlVOYWtW?=
 =?utf-8?B?YW5WTFgxR3pMczEzbTI0WjFjZ2RCa3lhMndud1ZiaGRzMUlZdGk0RWhQaE5R?=
 =?utf-8?B?WWlrN2lUQ1pWbTdzVGV4dllPcUtxdnhoZ1VnU1FWT2FuMFpVRUVubzVrR1BC?=
 =?utf-8?B?T3FVcXRnOFp6SWorL1ZoWHRibkpDRWZyVUxKUDRRTGJlczhBdWNDRU9yQ0lS?=
 =?utf-8?B?RDh2bjV1Q3JPeW9BT2FKMkJJZlB3cHhRQnRtMEIvblpRUzd5YS9YNi96WGt2?=
 =?utf-8?B?ZE90aEJObkFudUtJcTBrVTliZEpGU2o4VVU2eVVrYkNLTWRFSmxqazRjZnVY?=
 =?utf-8?B?R2ZtQ2ppRnV4dGNIclhzYWdmV2VKMTZqVEUrMG9vUForTXJHTTk4STFQaE1J?=
 =?utf-8?B?eWY0RjJqcXFKWnlIdjBKcnR3ZGgvSFlDK2tvQUlLdFhFdXRlNzFobEp5Z3pn?=
 =?utf-8?B?d1p1MEhXYWZKRWN2R0toQVdRaEZZblZnNlFTenMwTjBtdkZMUFU5ZFR3RXht?=
 =?utf-8?B?ZzhXcGVlTjRRQ0U4aGdoMENOUC9nMkhlUlk0UGZCYWtUeUNvSjAwMyt3ekI0?=
 =?utf-8?B?Q0JUQkZvd3N0SnZCSU1VcTZhYlEvYTY5UHN6RXUyMC95K1BPT003K2dTNHJp?=
 =?utf-8?B?U2JSL0NpdDZoSnYxNkV0MEhyakdnN0FBRjA1QUFSZmlQWDZRc3R2dzJSRkR6?=
 =?utf-8?B?MEhYN2hzSG1yd2JJVlBXOFkzNGg5QXcvTGNmai9lNVVVMUkrU3RkSE9taTdM?=
 =?utf-8?B?Z2pXWmJDQTZSTEplcXNZM0lJbXQ1ZUlJeWhQWXNpd0VBL0xNRWRDNy9xSUFT?=
 =?utf-8?B?QStOM0dvR1FzTml1WVhXUldaVlRNUXFxNjErRmlZUi9yRWpjeHZmVjN4Vm1M?=
 =?utf-8?B?aHJqZjNuTnJBVjJoc2w4K2NvNFFadE5XNzRCMDRNcUJtZXJnVHhtV256dE1S?=
 =?utf-8?B?S2xIZmtsNThqd1JnMTZ3dVQyZ3lCa0ZWQ3RtWGdIT3Nwam5SZTNOOS9LcXox?=
 =?utf-8?B?K3VrQ09tVlhRRWZ0UzZBZ3dscXRueGlNc1QxRW94cWF1Z3AzU2RPcC96Ymx3?=
 =?utf-8?B?clhYTFJwdWpCVUFIRDQyTWVvWjZ2dGpJWnJqeFR1YkFhV0hsSlU4cVNiVXB2?=
 =?utf-8?B?TTRiVFo5OUowQVFrem5wZ3Mxai9uVnE1UERDUy81RC8wSldVL2dZc0xKOU5R?=
 =?utf-8?B?K05XU1NWMmRGYktpWm9XTFpMMWhXc3hMbEoyekJ4K0Q4ZzlUekhsUlFJOW9N?=
 =?utf-8?B?TG5DQUtDYS9zMVNDQmplMGVZL3JkVTlidGV4U2JHb1RtV00ydGwyanNUSzY1?=
 =?utf-8?B?TDE2N083RlViT2ZzeWVPdkFRVk5RU0hiSG9mOWNaMHpUdWxsa0lsWHpHTENG?=
 =?utf-8?B?VXVKZHVja29paDNHNHdidEhVUlNuaXRDVHdzOHNCWlRidWR6ckxSY3B0ZUJw?=
 =?utf-8?B?VUpwc1R0KzJ0d01lVU9UOUE2c25PMG1PbDF4TlhlQXJ6QTc3ZVJoUT09?=
X-Exchange-RoutingPolicyChecked:
	oHr6xu3RUSg3OxNNBcTWTMhP3sEl5Q7YSNs7H5ri+wo0Zq48eeGnckyj0t5OwVRlGsslw5kVpS8QBqjfpFrDbOVqOHAPqRMVMXWkny+/He6M9VSY6Hta9oi99hFKDgdQMZlaXxLepaxDjzCb0nZ6UXp6NHGD/QdF8mk5RBFk7b1FzH9ghJjeuwPeMyGE9YhdV9XCsp5Xct68BOX/elChSJcVK2yUP46JtgxWdrkj/j/DYnJJ7wO6vgGd4ANtRh2XrPQGFhTIH9DjfyzLLQ8DHU9peqQEuI+NpKFlzCQ+8Q0aXlYgpyHN3mZmONXZZrWwQn2vcERx/p/8PDah13nzDA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e68gY409S9PWM3xzZLgLMmvehYU7nkC9g1O3mVHZHgIEhESjNo618SCynSwrs439siTU2Qz0uBEVbqCdAPu+xjERILvi5AOtaUxP7lTa9FN5aM78h1ImZau92QJhb+uszytgLlEn6U/zF/yjkmv0ENHlcSNO7nyaIN+MY5guSwdDODPUPVedIjTJGGDv3W5RNsgw/NpNeJrHthgMw/tJOyMUFUc4cJAkTLyWK9cuqultUwySQsNIvCQbV4od0BzmeT0eHMZa6n0fVPCZY13hfnV3/9H3t+Wf65ikhUvZdAohcsHBKVPH1ZES3AsJkj2jOY6LblpdYCispR7tU5IE/FdCVasIUyJ3XDWOTekf1//Hy+5RpHd1YzKuVYP3UoXdwOe8iurfsh6kMJowpAQO4j0MAG+Vy6BWBSSHiew88CPbH6tb6bkrE3YdVHGSsh+h2e9gCAtA066IQvirfLStUx3odtPqJD7B8JIj7QygPAc6dEHupV5GKnCH33QZQ9urLQle+NMefVjYvDNCk5/PPWyoRvk1FRebgcysLTWeQSLj8+16chRzNicTsrOqiSrwxkGItnyqugyib1VH5oFzf8+/qfwmjTjFP4WzsehFcqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7355d80a-1e4d-4247-938a-08ded036468b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:14:26.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/0DeCCBcVctFWCEo8nPmm+sM7Xyk33AVlu5yic+Zm6/50/46AZ/E849DUmizVfoCzy0o0MR+ASehJH4GKnjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606220080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OSBTYWx0ZWRfX1j7rKrJeX9us
 LhDvligIrUCiNYuIiucWpFRy7wP+WqkXMHEv5fEP1zV9eWieqwJNcDHW8USCYXgW7mw0wtNS/qI
 +B1mkGH8xilbj5l58m/ZJBstQFnkLkWe7THh1emX/E9rfnOHvtbchY6MEf8Yn5qARAF8QZgjZCC
 pM1/oYlJ5/R8g2uahy45E2a3EafozfsJLNUqwlsITJfEu94j3SxzFjNSvD5aXKFVJ3i/40hQZpp
 7u3rxq/HVRQ8ynKASDtpnkBpY/SpNIwbvcjY8BPz4+jbenYkOX+ZRQGJGqK2pKrY5sMjYqbx9D/
 c+jq+4b4S4VSWpwj9I0vn7gyfIGy8IUDlbdqlR4tLVmzdgp27v1s2yvTDHabAvdznj8RckDIsfx
 IevFoMP7kMC+IgYmTKvArVjhvChCVXIykGm/45qDxqfeGmUZorPQKMltNsJw2ZP5NgEdc9QERvz
 6rET4vsEozfPuKwgv+iqVqXKVK6+cVnfdd+67weo=
X-Proofpoint-ORIG-GUID: 7S5cIC5H3CuR201zcG_FxgvMWf1flqJS
X-Authority-Analysis: v=2.4 cv=Wokb99fv c=1 sm=1 tr=0 ts=6a38eee7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=e0xsoFJDsFkTDqE39DkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-GUID: 7S5cIC5H3CuR201zcG_FxgvMWf1flqJS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OSBTYWx0ZWRfX5mU3qpnPqOIM
 Nucdk/ayNF8AXWQfnb65eJX4/E1Pu2g4CBxrHS1eOWge7cVcQM0iv9Ol+j7CBIQIvKvsHAFRzHi
 cDb8aykYAtR77Z7fZqigVsPEx4GOxVR6wFiTL3lHEMD25tfyKvyR

On 21/06/2026 17:47, Yonghong Song wrote:
> 
> 
> On 6/20/26 1:46 AM, Alan Maguire wrote:
>> On 18/06/2026 02:13, Yonghong Song wrote:
>>> Current vmlinux BTF encoding is based on the source level signatures.
>>> But the compiler may do some optimization and changed the signature.
>>> If the user tried with source level signature, their initial implementation
>>> may have wrong results and then the user need to check what is the
>>> problem and work around it, e.g. through kprobe since kprobe does not
>>> need vmlinux BTF.
>>>
>>> Majority of changed signatures are due to dead argument elimination.
>>> The following is a more complex one. The original source signature:
>>>    typedef struct {
>>>          union {
>>>                  void            *kernel;
>>>                  void __user     *user;
>>>          };
>>>          bool            is_kernel : 1;
>>>    } sockptr_t;
>>>    typedef sockptr_t bpfptr_t;
>>>    static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>>> After compiler optimization, the signature becomes:
>>>    static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
>>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
>>> This makes it easier for developers to understand what changed.
>>>
>>> The new signature needs to properly follow ABI specification based on
>>> locations. Otherwise, that signature should be discarded. For example,
>>>
>>>      0x0242f1f7:   DW_TAG_subprogram
>>>                      DW_AT_name      ("memblock_find_in_range")
>>>                      DW_AT_calling_convention        (DW_CC_nocall)
>>>                      DW_AT_type      (0x0242decc "phys_addr_t")
>>>                      ...
>>>      0x0242f22e:     DW_TAG_formal_parameter
>>>                        DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>>>                           [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>>>                           [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>>>                           [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>                           [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>>>                        DW_AT_name    ("start")
>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>                        ...
>>>      0x0242f239:     DW_TAG_formal_parameter
>>>                        DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>>>                           [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>>>                           [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>>>                           [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>                           [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>>>                        DW_AT_name    ("end")
>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>                        ...
>>>      0x0242f245:     DW_TAG_formal_parameter
>>>                        DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>>>                           [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>>>                        DW_AT_name    ("size")
>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>                        ...
>>>      0x0242f250:     DW_TAG_formal_parameter
>>>                        DW_AT_const_value     (4096)
>>>                        DW_AT_name    ("align")
>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>                        ...
>>>
>>> The third argument should correspond to RDX for x86_64. But the location suggests that
>>> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
>>> the parameter value is stored in RDX or not. So we have to discard this funciton in
>>> vmlinux BTF to avoid incorrect true signatures.
>>>
>>> For llvm, any function having
>>>    DW_AT_calling_convention        (DW_CC_nocall)
>>> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
>>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>>> and 875 kernel functions having signature changed. A series of patches are intended
>>> to ensure true signatures are properly represented. Eventually, only 20 functions
>>> cannot have true signatures due to locations.
>>>
>>> For arm64, there are 863 kernel functions having signature changed, and
>>> 108 functions cannot have true signatures due to locations. I checked those
>>> functions and look like llvm arm64 backend more relaxed to compute parameter
>>> values.
>>>
>>> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>>>    -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>>>    +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
>>>
>>> See individual patches for details.
>>>
>> hi Yonghong, changes look good but we do hit a CI issue; specifically
>> in run_selftests in [1] for gcc+aarch64:
>>
>> 3: clang_parm_aggregate.sh
>> Validation of BTF encoding of true_signatures.
>>     On arm64, BTF and DWARF signatures should be the same but they are not: BTF: long foo(struct t a__f1, struct t b, int i); ; DWARF long foo(struct t a, struct t b, int i);
>> Test ./clang_parm_aggregate.sh failed
>> Test data is in /tmp/clang_parm_aggregate.sh.NH5a6D
>>
>> I think the problem is that as well as creating aggregate parameter names we
>> need to decide whether they should actually be used; in this case it looks like
>> we hit a function using aggregates, but without DW_CC_nocall. Perhaps the
>> reason is that the calling conventions are preserved while we only get a piece
>> of the "struct t a" argument? Something like [2] seems to resolve the problem,
>> please take a look and feel free to roll the fix into one of the patches if it makes
>> sense. You might find it convenient to use the merges of your series at [3]; they
>> merge your work with Vineet's tag changes now that they have landed (just patch 1
>> required merging IIRC).
> 
> On my arm64 machine, I run ./clang_parm_aggregate.sh and can reproduce your failure.
> In v5, it does work with llvm23. Probalby due to compiler and/or pahole change in v6,
> the test failed. The following can fix the issue (I tested with llvm22 and development
> llvm23):
> 
> diff --git a/tests/clang_parm_aggregate.sh b/tests/clang_parm_aggregate.sh
> index 9502f8b..339cd19 100755
> --- a/tests/clang_parm_aggregate.sh
> +++ b/tests/clang_parm_aggregate.sh
> @@ -58,7 +58,7 @@ verbose_log "BTF: $btf_optimized  DWARF: $dwarf"
>  
>  arch=$(uname -m)
>  
> -if [[ "$arch" == "x86_64" ]]; then
> +if [[ "$arch" == "x86_64" || "$arch" == "aarch64" ]]; then
>         # On x86_64, clang emits DW_CC_nocall for optimized functions,
>         # so pahole should detect the optimization and produce a
>         # different BTF signature.
> @@ -66,14 +66,6 @@ if [[ "$arch" == "x86_64" ]]; then
>                 error_log "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
>                 test_fail
>         fi
> -elif [[ "$arch" == "aarch64" ]]; then
> -       # On arm64, clang does not emit DW_CC_nocall, so pahole cannot
> -       # detect the optimization. BTF and DWARF signatures are expected
> -       # to be the same.
> -       if [[ "$btf_cmp" != "$dwarf" ]]; then
> -               error_log "On arm64, BTF and DWARF signatures should be the same but they are not: BTF: $btf_optimized ; DWARF $dwarf"
> -               test_fail
> -       fi
>  else
>         # On other architectures, skip if we cannot determine the
>         # expected behavior.
> 
> Currently, my test mostly on llvm23. I will test with llvm22 as well and push another
> revision after your CI with llvm22 land.
>

Great, those CI changes have landed now in pahole so you should be good to go.

I think the problem I was seeing was we got some of the effect of your changes
(renaming of parameters due to partial parameter) in the absence of DW_CC_nocall.
This raises a question for me; if the function register usage does not change -
matches calling conventions (meaning no DW_CC_nocall I think) - but we do get a 
partial parameter from DWARF, should the parameter name still change to
reflect we only have a piece of the parameter?
