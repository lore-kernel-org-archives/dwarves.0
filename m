Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5872416859;
	Tue, 15 Sep 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472424; cv=fail; b=r53EhKB/HHiC8VqCNIFuTBtvipYCsIX06L7avI/JsPpbojHttL8sJ7Iz5+GKuyeZzp+L9EU4yBxATfM9iNy7QVziJ3U2kXXh+k8KrbiGwJjwXZFEevJ2x3GAgEHfsyWorUYaxzVwm7SWmcQVtZGPBaUfkYHB0dehRCMKh6dpDzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472424; c=relaxed/simple;
	bh=aeXFL0fP9gysce4n47q0Xc5Wf1EDkM+u6aUxfEk4eE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g2QWABWXIoV9nSLsVSZgrhJbh725mQoSccHj4KqIOfGWMA54T2eCNKFNgBLWGrprDV1JGqGS3kW9JyeZwK4FAee+7HIh1hI4iF6QGuX5trR1aCviTwGF5BNPe5nAPypJvQ+1VU6J5QQrYY35V0cMVv4LT7AC4fysyLMilpSWhOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XSS3j9IW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a8RoAN7p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XSS3j9IW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a8RoAN7p"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F8tiWb3591921;
	Tue, 15 Sep 2026 11:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fKnaqtF/yix01gXU6wdeHxlCVjy4nRhtTifF6RW8+EY=; b=
	XSS3j9IWs11OnUGAxRU6dY4py5mRKDB+fSGy6resbxwb7DA7ywLrUNCOSQoG+aiT
	3M0hnk2mDNzfalbYpfoKVFgM22vXYr+AYA/WSL8s9WkKRRV2JphPUbjKxtp7ggc8
	xp9dc1btEPCoXzangTrzUjyHJrvpxVmub2QpcrTM5mIjljxc46HbvB9tPtkP/SmF
	5n+6zduRt9hYJr5nW+AdhzLLqswKf0jSg/qwf2AUYx3KHcOHRnWiTAMIyxwQop5h
	hDPHa8+wYWO+cSl7uzh9FBltSZn8p6fQBMVlEsZj7vpwJIfiQKivrbMF7g1Tw35I
	PALxJHP/EHuR8oJJ9rNfmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmxm7bgrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 11:40:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68FBe3j9030129;
	Tue, 15 Sep 2026 11:40:13 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6a0srn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 11:40:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LW3CB2gYjDkH1cOHAUNo+yWODopYAcS/CJ5SQ+YM4RjXljMWFLVmREttagg13quDDpBoRgQjt9mcGS5cEuFMbbnpIvF+cRX3jZIF910Ka88YJ/tniS2AFsAYjE73X6Pa3Ij0GwbujzkMjPb4CRhydiqJjaY2IcB0a0pAtLTcINWBCRQvYvI8/8IKcaMNY4HVqmEstfkF6dHPkHD7F1B8oMQ++4o9/8/iNpu736OymmQ+erDkfEhgqXnYt6k2YwUW0bSxJQ/RLUB4alcLehCvzzUO79C4V4dDBfUAdvpEqgwknKVK6Pf7tTWSw6+vR6JFI2jX6CNev2AXZlah8UPUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKnaqtF/yix01gXU6wdeHxlCVjy4nRhtTifF6RW8+EY=;
 b=BrJWmXf3gFTfMloua9vsCc6ykZ+hNx2zBnwsBWMBdpHLsmGbhWO9Qb21KjmcYkGOlU7NOT+MbdWOi/uhVUmK5lBRyVPSPgLLIxKZCeqqJPC/HtSW/B5D1gs+xWTC9zUtKNxzWEWyh0LkcRPu0z3W6nBM7d5hW2VKop/ICOy75pBWPUkNKI/QpcZ2gqj5fr5Ow6b6fyDzjXiX7dMLKf7lRRbXNgayyKxiIVAbpkwenwPGYqZAC0SIGDS7p6y8RWtPvdajYIL81v50Mf/SrzW5e7PtnNGBTo7MqZoLHBpK0uF6fuOmSRehOGoK6kK3JV6W7YndITz9+TBD2Vic5yP9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKnaqtF/yix01gXU6wdeHxlCVjy4nRhtTifF6RW8+EY=;
 b=a8RoAN7pvwhyGNbOnOEGgVmEDcOvQFw1Zsd7cgVYpCH8V05BAEbTPiwSksza4nHsDYI8Br6E3WIicyWzCrmzeUm97ahMrJ2PSZ0E059aDiooaRhRhT85mwMsVcNdr2y9k1SlO6WL5nWtBWIEL0Rj6/XFxFyH8SjsMSVbOpLidig=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 11:40:06 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 11:40:06 +0000
Message-ID: <49774454-15bb-4076-81ab-1da4414e0548@oracle.com>
Date: Tue, 15 Sep 2026 12:40:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: Skip the argument register the
 arm64 ABI leaves as a hole
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260911040955.339939-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260911040955.339939-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eabed41-e9cd-46dc-d7f7-08df131e170b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	bzouvBa7GblGsz4P/av+NYeru9Ko9HbDh3WVpu/63E29I44mdl52v8EAV7uelVphaq+WJURqFpACq0PzX/C6F8VLrZtxOejpLIbKsYcT+Q89KtZKT070w1HjWs4fPw3Dg9XBtZY21P+z6FAbNUtiZSPEbcYBPGtAV/C3DKYD9eJRW0kssuztxWDnERKWb9gi/9u6/tHSHq6BSoxBwiX6UyQnna0v+eR3cgJvRVOV0N7YPL/txhhFmP3qxqySvxoAqNbnNjO2NJSdXqrcWnY8yF+R2K6yXulGzhhKZl/OkgsmqBy+/ttEENa7irHVCZKD6V8XiA0rw9fbFLLERFyfEMRngk87TMYcdSXdYUqnJYYciUZZ++7TKjDxCVmMZI784FOr2ShOwis/oFnilhaQEy1bxWsPTp9Js2D6sQ7IjT0sUYLhpmHr4QLZdN5YP7HoBv1b9bpfKpi4/+R+/214DA8kqwFBfik9kU6jqfEtyQ2vAy2ztD0raniL1q3P35z9LmlHDf35Mat8YAZjMAKyPRLVvOcU/Nn3kL3EsuIFX4lmqjGPzSSc8etU58e+qLro6zktIXCKAPTsphbe+ujevzpdjBveVVOEzsJGu0rVl9ttsK/1s902LyMTh/o1dvzZ5oh/i7cCr5XpW4KtCfu5YJxaN1S/tWmPIEGR8Al18mA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGswcTlnSkJwM0pReFlZSkN0WjlySmNLbmI2cjZ1T1NSVkY2K3ZnWm5mK3ZK?=
 =?utf-8?B?RlU5QjNBU3BxTGRXdFFlRlg0amg3NEViNHpZY0pFTGdSdlNMSFBJeDhlVG9U?=
 =?utf-8?B?RSt1YS9SUDField5NmlUM2FwVG5DNWlyWVkvazdycnFDT3J0bTZBM2E5RC9O?=
 =?utf-8?B?Qjd1OHNJWDV0TXJOUWdkbE9EZDB0N0hzY05XZ2JVUDB6K2pvejcwMkxwcldM?=
 =?utf-8?B?Rkp0OTMvckNOcTZicnMxbE0vN0RjMXo2SHBiSTUyc2JHWEN0TWF6d2pUK01L?=
 =?utf-8?B?V3lybUdmMlFHdTZ4Q0JPb0J3S1BOZkZrVC90NW84WjJOc2ZyOVI5RTh1VzZW?=
 =?utf-8?B?b3RnQTZOREVYVENBWnk2UW5YcnF4aUpWRG54NGJnY2JESG8xenNXNDFmZGFS?=
 =?utf-8?B?WUlmN0w0MTVabExZK01uZ1h0VmpzeG9IYnJkZDhZZEtFUXFYbG5CbW9ZMDRz?=
 =?utf-8?B?WkdsejFqR3NLN1l3QllPZ2FDcTh4dkRrdWtVdzlKS0xoaTRCUmtnTVRxQ01s?=
 =?utf-8?B?QXRDQkpjUW1kbkFJeW1vV3VYQytDK2lZTXdwYnhrTVpLRS8zWUNyTTZTVEZl?=
 =?utf-8?B?MXhpSDRPY0FVeTUrNGViSWZMU1VMRm1yZGZ1czFObGlpUlk2bndZeDhQZDBB?=
 =?utf-8?B?RkFXK0IxZ3c5WWhwTzlKKzRwd2luelZpUEt1c2RaZTdhNlNIbVU2Um9hY2FF?=
 =?utf-8?B?eTRlN0ZGc1hwL0tRM3lXZmthM1MrNWhhRjNmWTBIdDNYU25zWkZYYU45bEN6?=
 =?utf-8?B?RU41OUVQcHZKUzl0WkJ3eXZ6NzZLZlArVDAzTm1ubGM4NEJYVXlIeHdCelZ4?=
 =?utf-8?B?eGgrb2ExRGRDWEpDa240VGNvWEJCZUNKOW5zdEFPY1V6TjR1Zk1aelgvOVFt?=
 =?utf-8?B?Tmo5eUk5M2tPaHBkcEJacE1tZFFOSDRpWWMzMjhRZ0RTVXZrYVBabTVyZFFO?=
 =?utf-8?B?alZGeHNENkFhVnpqQzF3R3VkWWRMTWs0cE5aM0FKbENzeTNQR2hnQS9zUG9O?=
 =?utf-8?B?Nm5sTFNqc2hUeFZVZVJXVWJtTFBBc2xDalI0SDQ1bE5YaG1kUDVuT043QVZ6?=
 =?utf-8?B?a2NkdThRL3l3Nk4rUnRWdUZ3TlgxVG1Sd24ydk5NZlJZa0RESkNwdkdHcjlS?=
 =?utf-8?B?SUUxYmN6TFNNTTZ1Z2hmazhQTHFmTklyRVdWWlozTFpVVFVNSWtNZWVtUnlI?=
 =?utf-8?B?NUFpRmo4MlFZWS95M1FYWnd3SXNJUk8yMEh5ZUlJOHlhbU45TEYycHRmWi9Q?=
 =?utf-8?B?aVpGSm5XK3VHTmFVcndQVkY1elcvcGZnaTVRa3I2SlJacFptK0dsRmhFRkdP?=
 =?utf-8?B?R1RPOXBHOFpXOWJxRmpieTlwYXBpYk5TK3BkcCtHLytuVHlhSEptZ2E2UXUv?=
 =?utf-8?B?WTQycHRkelQ4YUhsT0tHWUhOKy95M2VRWFlzNWkyZEtIRm5wYjFZd3BLMHQv?=
 =?utf-8?B?QVRITnE3THl3bkxtRDE1SlRLVUVKZytNQXV2YUlGWkJtWjFIeFlGOW95bWFX?=
 =?utf-8?B?TVpjTVE4Wk5Td3hkTlF5MENVQTYwR0RZTlp2ckFjYlpDZXBValFWbnNwSmF2?=
 =?utf-8?B?Ynh4OWZrSHJPTEcvRzVhS0JUbGRVNm1qSitPK2dBQm5qQ040UkhIb1BJK2dm?=
 =?utf-8?B?ZmdEQUdtSm1NZDg5YXZKbU5pVHhGeDRaWU55TG0wRGhCWis0WUJFZmVxZjlh?=
 =?utf-8?B?YVBrU1B2bzBUWWxUdTVELzNJcUZPRUdQeGRMRFoyamRUVjhuaXdSbjFFcGF2?=
 =?utf-8?B?SUl1QnlNNVhlTjVvNFhucTVvWWRuQTNRYWVWdThJbkNMU2p4NThzVC9YZjVE?=
 =?utf-8?B?NlZPZENnZFBkR2lXVlVPNnpOakwvd2lWZVVmRGJVbnNISEVzRDdzT1owQ0Vi?=
 =?utf-8?B?MTZzVFAwVXhMTUNpK2dXbis1cFFVZ09jazRHL1J5VEJkU3NMMFJnR2s2Ukxz?=
 =?utf-8?B?ak5oTCtqRC9lNlZPaXhPeVNLcExSQWZjWnBQMHRSbDdjdEMybWdxaGdPbzRl?=
 =?utf-8?B?N0lhZnEyaGZ2cVlHWTZiOG5hKzJlaXBvd3BYVWUzQitzTy9UTzg1eE1mSmlq?=
 =?utf-8?B?YzVVakdqT2duYVJQN0QvNTZJc29ERFB1dkdpdXdlTFpPSGp4Vzl1UFdTcW5t?=
 =?utf-8?B?U0xLd0xzb1hNR2Rmb3M4c0RiL2tJQlpDK3pvVmcwejlqakkvV2VCWXRDOE5n?=
 =?utf-8?B?MGJjV2RjckhTNGtsRWd6ZFFiRGoyRFdQNGFXQ012VUZYai9Yd3A3Mlh6dEJt?=
 =?utf-8?B?TDExM3dBYmhobGVVU01lemhweFZXR2RKc3k5UDU1ektZQy9jekpVRWZWZVdY?=
 =?utf-8?B?ZGhZSFRreWR2aXJ0d0FTRW5KMWN6UTNuOGZ5K1QrTVhzVnpvR2tOdz09?=
X-Exchange-RoutingPolicyChecked:
	wao+Xn8Aj1H46uVEUUpfDAXG6mObWMouADl6FzaF5zbMA+KfRP+QiCtwtIippqzfueJjyXHF9ojgKKqjFxyhC0wuvB8EYT8Y3GrSmdiSaQI9xPZwzI2bS9o9jM0BFURUcckRyaMYBE8dfS5pNmOEINwvipWws1fW9JqWWMjmi8iabnoBhpMLPJv4r6FSrgV3UOESP6eT/+bhirRu/2VVnISenCQqS3Tp00vhhWm7uWUJz/pVN++i4L0M8W7KaWvlZFNN8gHDZq4DLPusCJI0Ywc9fn1i6U8zotR9nYhUfQtbkZ4jN/e/enzAmGxtPAl9ZN04FGmZ36kjQbv/s2KehA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YGWb3KZHIIzA3U0cVLb4uGOhjmk+h0cYHQ+SvOGi1CWsvDD77b+GCj+skoLfK7jOgswueb5YByudws8QHXflbUUti27mNqIaN6TctqUKKXG5p/g+gQKXhpl3zPdqBMRv2nWvy6ftDkLci4Uv7HCWvch0JdNvw5Y1Cva6KuX8OZUNSNZQ+mc20+FoAXd1XFk0KD96sO5VJi9MURtHxJgz5X4vuOEq1XopzpKKIlkkZqDuf5U2ddqK727NMiU5o3S3d3trHslXxw3uYBgl7VfUXmAk2IE3A2ObcaxvNxTjHSLlUyMeHCv7Xay2MzN7i3PMo28YMe97vrvfw6vGleH0XhYx05zZeMvQBze0Yruh7jnFtmXX0shcJwB0QTtxhIcbYfMBme61GXqE7eyb1peW312dw3enjX8rkHNepQyJN96LA6BGPHXt3f86YucJE3GUUmOnpTbAZgMTe3Yk8GvW+pO1lQTcXZDy/ZHykvDXro1QY/M1vxnCZ0Siy1zR3jhg5+OS6m7+OOnWM3DJv4jsq8J/F36isyyiiTIwdc+ScO4f3S7OwU88tTvhVzKtD6kq7286m7pkncUlaJ7ByrEFVta2+z77UB99qETLND1hQUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eabed41-e9cd-46dc-d7f7-08df131e170b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:40:06.8637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ywx1kfhevj58T/ZfEU8ohYvb6CKoR4vFcQelXHX1ME2SZewaSDC3fC4HiK1a9qIbGTFieKBwis9kgvNJKyFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609150169
X-Proofpoint-GUID: 5AmWKWSP1AQb2QuWjrDL5x3U6X5aQz_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE2OCBTYWx0ZWRfXzDW0Zu8oDznL
 hjbxkIo6wqqwJjaqTpFQysYSjj/WK/6MR7FCxDoAlrjIYg5VLR4ShLQvAsYmaj7yfEvmH/fbrdA
 aaDl2+0dgf7n973BenwhD3MpcexAE61wC6N2w4L3BmNBMmSz5U8MI7nmZo2Px6GHRZB1g1GbOUR
 g2OF0FI7xo/B1Z7qLA/LqQoto2jlBn5TzLwo2pXZgi1qe6p/XGexog1fI90Vy4NSLYsPoApX24n
 dSKKos3UppufqJRsvmeqlFCGWTzORV3UO1FrcaBzYkL3lJoiJWITHXO6alqfU+KFkCUSgnOe1ww
 51S7TeWyWuFMpVbpjWDdQ45W+YLnJB20YBBT4PuGjKweJ3lKwNiJYLmqGaQvxxSwsFBvr2A96Ip
 pmGcM10Msp1zi/V7ymwyvkUgPHcBshbhO+cYhE9CtCcoXmyD5+dCUP0mmohMCfIgOSv1wGNX6KE
 QuPvM4rdZhdBuJdPMvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE2OCBTYWx0ZWRfX4o4fcgWycBbZ
 7QiJIVD4FAPWgz79yMEPEoz6GelLl4in0Q4t+GsgK0S4XnRZrhIq0oKQUuNnv8R1Kuvnq88dsw2
 LTp3l4xvdvJJQogRoAkxjTwGBhTfuR8lgC+6u+8XbFdbOIb4jeZu
X-Proofpoint-ORIG-GUID: 5AmWKWSP1AQb2QuWjrDL5x3U6X5aQz_U
X-Authority-Analysis: v=2.4 cv=A/n5rKWG c=1 sm=1 tr=0 ts=6aa92e9e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=IIitxqE1_MR7lqrvF2UA:9
 a=QEXdDO2ut3YA:10

On 11/09/2026 05:09, Yonghong Song wrote:
> arm64 requires an argument whose alignment is twice the register size to
> start on an even-numbered argument register, so such an argument arriving
> when the next free register is an odd one leaves that register unused:
> 
>   u64 f_odd(u64 a, __int128 v, u64 b);
> 
> passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.  The x86-64 ABI
> has no such rule and packs v into rsi:rdx instead.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++---
>  dwarves.h      |  1 +
>  2 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 61ef52f..81c2076 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1501,6 +1501,23 @@ static bool arch__agg_use_two_regs(const GElf_Ehdr *ehdr)
>  	}
>  }
>  
> +/*
> + * Some ABIs require an argument whose alignment is twice the register size to
> + * start on an even-numbered argument register, leaving a hole when the next
> + * free register is an odd one. For example, on arm64,
> + *	u64 f(u64 a, __int128 v, u64 b)
> + * passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.
> + */
> +static bool arch__arg_align_two_regs(const GElf_Ehdr *ehdr)
> +{
> +	switch (ehdr->e_machine) {
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
> @@ -3634,6 +3651,28 @@ static int parameter__abi_slots(const struct parameter *parm, const struct cu *c
>  	return slots > 0 ? slots : 1;
>  }
>  
> +static int parameter__abi_reg_align(const struct parameter *parm, const struct cu *cu)
> +{
> +	struct tag *type;
> +
> +	if (!cu->arg_align_two_regs || parm->type_byte_size <= cu->addr_size)
> +		return 1;
> +
> +	type = tag__strip_typedefs_and_modifiers(&parm->tag, cu);
> +	if (type == NULL)
> +		return 1;
> +
> +	return tag__natural_alignment(type, cu) > cu->addr_size ? 2 : 1;
> +}


There is a problem here (identified by AI) which, while not impacting on kernel
signatures would I think be worth fixing. It stems from the fact that we can
have non general-purpose registers > pointer size in a function signatures,
and if they are present they do not advance the general purpose register number by 2
in the way that dedicating 2 general-purpose registers would.

Example signature:

u64 f_fp(u64 a, long double v, u64 b);

To catch this, have a test in parameter__abi_reg_align()

	if (!parameter__uses_gpr_bank(parm, cu))
  		return 1;


static bool parameter__uses_gpr_bank(const struct parameter *parm, const struct cu *cu)
{
	struct tag *type = tag__strip_typedefs_and_modifiers(&parm->tag, cu);

	if (!type)
		return false;

	/* Scalars represented by FP/SIMD registers have their own allocation bank. */
	if (tag__is_base_type(type) && base_type__is_float(tag__base_type(type)))
		return false;

	/* Also exclude vector/SIMD types if dwarves represents them distinctly. */	
	if (tag__is_vector(type))
  		return false;

  	return true;
}

So given that the fix is small, I think this would be worth doing.

> +
> +static int parameter__align_reg_idx(const struct parameter *parm, int reg_idx,
> +				    const struct cu *cu)
> +{
> +	int align = parameter__abi_reg_align(parm, cu);
> +
> +	return (reg_idx + align - 1) & ~(align - 1);
> +}
> +
>  static bool parameter__has_piece_info(const struct parameter *parm)
>  {
>  	return parm->first_reg_fields || parm->second_reg_fields;
> @@ -3653,7 +3692,7 @@ static bool ftype__next_parameter_preserves_slots(struct ftype *ftype, struct pa
>  	if (!next || next->loc_reg == PARAMETER_UNKNOWN_REG)
>  		return false;
>  
> -	next_reg_idx = reg_idx + slots;
> +	next_reg_idx = parameter__align_reg_idx(next, reg_idx + slots, cu);
>  	return next_reg_idx < cu->nr_register_params &&
>  	       next->loc_reg == cu->register_params[next_reg_idx];
>  }
> @@ -3702,6 +3741,7 @@ static void function__match_clang_parameter_locations(struct ftype *ftype, struc
>  		if (pos->passed_in_memory)
>  			continue;
>  
> +		reg_idx = parameter__align_reg_idx(pos, reg_idx, cu);
>  		if (reg_idx >= cu->nr_register_params)
>  			break;
>  
> @@ -3732,11 +3772,17 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>  
>  	ftype__for_each_parameter(ftype, pos) {
>  		bool consumes_register = true;
> -		bool regs_available = reg_idx < cu->nr_register_params;
> +		bool regs_available;
>  		int slots = parameter__abi_slots(pos, cu);
> -		int expected_reg = regs_available ? cu->register_params[reg_idx] : -1;
> +		int expected_reg;
>  		int reg_slots = pos->passed_in_memory ? 1 : slots;
>  
> +		if (!pos->passed_in_memory)
> +			reg_idx = parameter__align_reg_idx(pos, reg_idx, cu);
> +
> +		regs_available = reg_idx < cu->nr_register_params;
> +		expected_reg = regs_available ? cu->register_params[reg_idx] : -1;
> +
>  		if (pos->has_loc) {
>  			if (true_sig_enabled && pos->loc_const_value) {
>  				pos->optimized = 1;
> @@ -4467,6 +4513,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
>  	cu->little_endian = ehdr.e_ident[EI_DATA] == ELFDATA2LSB;
>  	cu->nr_register_params = arch__nr_register_params(&ehdr);
>  	cu->agg_use_two_regs = arch__agg_use_two_regs(&ehdr);
> +	cu->arg_align_two_regs = arch__arg_align_two_regs(&ehdr);
>  	arch__set_register_params(&ehdr, cu);
>  	return 0;
>  }
> diff --git a/dwarves.h b/dwarves.h
> index df77f1e..70adbbf 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -304,6 +304,7 @@ struct cu {
>  	uint8_t		 little_endian:1;
>  	uint8_t		 producer_clang:1;
>  	uint8_t		 agg_use_two_regs:1;	/* An aggregate like {long a; long b;} */
> +	uint8_t		 arg_align_two_regs:1;	/* An over-aligned arg starts on an even register */
>  	uint8_t		 nr_register_params;
>  	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
>  	int		 functions_saved;

