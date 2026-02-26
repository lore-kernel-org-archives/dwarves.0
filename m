Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C703D6475;
	Thu, 26 Feb 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123206; cv=fail; b=UhmGo9SNyILVmf5txlal4V/m74CrWJ49CFLSlQPM1x2bK2UNeFAlT5NIiHVpJh8nOZ7FY8nPPGTWxR2/O48CpRVQUrFZUnNJ7qzKhzHS/7FOfdiBR0qPUz8ID8u0aU/LA0BM5xXfWns1X98DWnqMu6hAJNBEcLC6IRg6V8B2ru4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123206; c=relaxed/simple;
	bh=kc5UUUTQ65u99NCIclxsQ3M4JTAIsD8r9ZgBAtfvIHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qDWRqJzbFvftseh9iXfipduNTztkObGZK32RYbDQ2Qq8FXN93td0VRDNK6YkQF+c33Skv3g3pck9Nc5bnqhXhjEm9oxhugxsxfshVJJWP4byJ6gyv15yE16muQHQ/aWYhS0L8KQ8N2XYFY0vkkeFuHOy/Raz8Yl+Iq+yCHk2qNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qjGHpoFg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kfuFo5Qq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qjGHpoFg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kfuFo5Qq"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNCqg107273;
	Thu, 26 Feb 2026 16:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WRo/oP3WbjTN0cZt+hC8WlV5Acx348RwlkQfeqV5Zro=; b=
	qjGHpoFg4in2o4RwrnfJ7cBo/lHvYuCIa9ts/xXWJSAkbEDa1zrNu9tva9eoZ6dY
	mqjkMCGBboRDrdPnlKwoYCp3ITl21EEbyl72ByzRR4f/u8oXO5evu8W9z+J6WADk
	JnzuyuOIyC9fWcs1bxwwy1Lo7B2f1S3vUzu8sbviDFttQdPLP0ky10GhK4dbZfJ6
	al23g1xilHHLaQ3uPTwrtz6bJ35W0aY4lNN0e72Ba4ULVDh1MtxF5dht6KXwQUPK
	DyV0ogDB7yt8VvSdQQ7i9kR6c9U/89jOpgdBwVXJjfq0mTc62VPxCCNgw79VNHzf
	DF+4C1kwC6FOaOIfTGaBSA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjh018xgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 16:26:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QFGRtk015693;
	Thu, 26 Feb 2026 16:26:11 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35cwteu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 16:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njqtQ01rKRdontCau6Np5h+3lECzcOcqp0vgR+rUv0oDu8yMVof39TZC9Qk1R7QDnBvfrLC82ARj9x/luhIqaKFi/DdIohI63ni5eKPN5uQUo0Q59oOsbX64NbTPq0ma0u0TWKrEgGYV/fsbz7eiEc7+xyincfQ+bsh/cNfYCCxsp5QInONSSDsaNDuMilPVlBUs1/i9obTgcm/mh184LpbE+bpU12vsWI2hVEHU3tW4oVOfGJhavpEo42ia5rIfvAIMBtj1Q16dCD8i70FXTvdMKF8/izBwm7uq0IY77eO9cTZGi1nYk2aHiitKVl0QW9FbdTzumNBPyGvqxdAgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRo/oP3WbjTN0cZt+hC8WlV5Acx348RwlkQfeqV5Zro=;
 b=PZZnRA5ViKOPbtMOxtXggEXpx5aEE6YkR5xlcu1/j+dRL48kdj1bSx2pq34m6ZpGeOsYVTBB6fGEvS0d/inNOw4uE+F2pju4DtggWYAtGjVHxDBhYXkVkCfeK8SvCqijzWAR4NSKxxetuNh1tL1R3OIDET94wHoIto7WvJoRbMytlP3w3RYWwYOlyTDTwzId1JE/oSD1WRHJLi5TmCBOC2Yg3dy8sMMV4AJBcPbuhLGJ3xTZCUys3ZBNt89908PUL4glfGGuiMrq969ZhZc9MMs4ovXLbqSKpKYRfwgc8pK/miYTVdbMEasIsQAH3E60CRi1YlwQ+OvyyHn1OOBCEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRo/oP3WbjTN0cZt+hC8WlV5Acx348RwlkQfeqV5Zro=;
 b=kfuFo5QqdmYwaw+RGcEWibGJVQcSvDwAY4rRZWNUjazcE1G7LkgZglNT9Mbn/S85SOyMBrgOpqyMPTSkH3cPI9K0rgkpG6FybJs22RxpbL1du8McpRLwxfZblky8fbhpdt66PQeWseKRG/xTcwTCEIY2az/3uNb89SHMJCkWARY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:26:03 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:26:01 +0000
Message-ID: <de9dbe59-7adc-4e00-a0eb-7f5b3cb88ae9@oracle.com>
Date: Thu, 26 Feb 2026 16:25:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 bpf-next 06/10] btf: support kernel parsing of BTF with
 layout info
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260226085624.1909682-7-alan.maguire@oracle.com>
 <dc1d9fb29ac2eba86b21fb85ad1bac9d096f0e9680ef87b42a86200120b5e7a1@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <dc1d9fb29ac2eba86b21fb85ad1bac9d096f0e9680ef87b42a86200120b5e7a1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0441.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 06968467-cc21-46c5-4e2d-08de7553bad8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 oaw9vKfIsalHsqpzglMJ2Y0CRF0E1q05h+Aekcz1jL+OqNlVdTxZ8yzTd8sH60QskeAJYJfTJnQojnvhpfSx33xeunAT52KKBhGlcXF8e2WdWDEK6ewS5eEH7Y5Pvk2gYaRHn92zWLSSjbfLHE/v92q0f0ig1ncdPObHtCa17tOTjLgEMLa6Tbz18NORm+g7JCYhHVbIS3jF/fovHwO7fFZS25iZZxHnknJZ0eOw8iUXXRHAmTETVwrteqTP2k4jP4MxyQqu8+Kw9QcEOYCdK4mVcLfXUdB9V0H86yTJfgC/xYIhKn42vsuMRbBrcU91AuImcqAHS3wkb+3TykXCA0w+c/W0DGMVYSvTISG+I2XKwTpKufH8t+YgFo6nVnWRmt46LtrnamAUxIV5sPiZnDkQGfpMdN1f9nqSQnsv+7N0TLoyEGCCNST3KitXjY8YztWC8ZQ/6jjMEqx0Xunk6ePT3qRIYIx+zg5bCVY7ivPNXWVB3CXemrnVbFwVex2MANuZGNqX8TSX+8YuxSBvyo2RWsFQij+2Wplm7EIDkJp3q1zD0/kpyeDnEmziHFLaoUioAfbEyNVgw8IpDK1qZfdwIQzMaKDtXNJ9RJ2Yok8ATG3vGMOzkT5Y9LxQXsWGGBmk3/vHt7ern+F7sgAWRcEXcpB4VghVlkBFpqBqaxxQF2A+m6gVBN7xOszbQt0Q
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UUVjbVBlc1FiZm9PM25UZFZsdXFITVR2dWE2SWk2Mkx5S1BOVG1VaURmTitG?=
 =?utf-8?B?YldCR1lwTzVibDRCMWsxT2QwcnVsK0hDOVNYU002TjVLTmhtZFRoL0tXdmFi?=
 =?utf-8?B?WFJNM0wvcUl1VDdVTFRpYnBHL0laeFY5UHlXWkczK0N0Z0g3cVVsRTM2TG1M?=
 =?utf-8?B?eEp5L25HZUpQZDk1ejhqdGFmelZNQXAyZkZ4MUR5SjB6N0dGTmJOdytBa1U4?=
 =?utf-8?B?dDEyNE9GY0tLMGRWdWRFR21YK1NlcmtaZlEzZExsb29WUnJuNkpaR3NGQzho?=
 =?utf-8?B?d0p3dy9jRU5KUVhHWXBHZXZIbTBrSnA3UmZPY0Z1Zmc5cXp2TkVDVjJ3M1Mz?=
 =?utf-8?B?NTQ3YURSQmJaSFJYSGk5ZVVVZ2wrSUhPeC96a1BUVmc3RWJvNGFJS1l2dXdH?=
 =?utf-8?B?enJKaWlKQ1ExZzhnc0Z1T043MncxQkk3UG96My9nZGJ5V3BuODhaYVowY0dR?=
 =?utf-8?B?TDF3RlJNbWsyeWpCNkNMaTNYcEZIYUs4eGRQWlFROVJxK1JNR25tNzlBdS9D?=
 =?utf-8?B?cWVoN3VDb3ZJVTVQWU1QTVo4cUpoYTFndXp2TnFlcnh6UzBLL0VXUTAyaWFN?=
 =?utf-8?B?WGxrcWZRamlLZ1dGRUtNOFVTaGkrRWs1dHdmMFoxMGNtWVE5c1kyblRrRm1X?=
 =?utf-8?B?ek1QTUlQYUxVa1NRK3lZR0pQYllvNE1KbHdoOWtDUEdKRDFqMlJ4M2cxeUh4?=
 =?utf-8?B?UGsweU9VWGxReXhyak5nWTRIUlNNZWNFTkdyNitKZnRTWk41QmNPYldIMS9q?=
 =?utf-8?B?MmZnRDhYTFREMTZVYzZaZWlkUlBPbWtVUnJoTC9yc3VuZlNia2VOZURyNnFK?=
 =?utf-8?B?RzZXUm1SMTUzYkhjcmpLbHdwNlg1NkhYZitKbWF5VVc2TTRzMDFYbjJkcXBL?=
 =?utf-8?B?aDY0RGRhTEw0ZHpaRytMZ1V1RXpBRXRjSldzYW1Id0lHTDFDTlR0YjRsSkI5?=
 =?utf-8?B?TWRZdzVPVmttcGRoRCt4ZVMyaGo3VEZXQXR6VDNycnVTOFprRDBjRkFzZ3M2?=
 =?utf-8?B?dTlnUjVKaWtlSm9NL242OWM5dThJZW9vL3JRaU9BMTE3NldpZWkyVjU4QklL?=
 =?utf-8?B?QlUybitDRWhLVC9QbDFjS0ZRbVAxRHBmaDV1VW44RW84cVc0cnlQSUtZWUsw?=
 =?utf-8?B?UTNySlNidW9UYlYxUG9yR1pRZlJROEZmNGttNlhBQ0FIZWFtNzA2QlFKUXlr?=
 =?utf-8?B?cmtPODhDbGU0ZFF5T0J2bGpOQ3prUjZ1cGN5SnVvK013WFJYUWNRMnpkS3ln?=
 =?utf-8?B?d1diMDBzb1B1cHFRaXVMaW5kSU5LQVlVZEdseEEwNjE1em5vMkd4RElrRUxC?=
 =?utf-8?B?NlBmM1hzVnphZ3JxL3F6MFMwcjdLRW14Nm1DMEswWCtPNjkvRFphLzdCL2pn?=
 =?utf-8?B?UHVsVW1haHRqejBaYnk0RFFPcjZ5RW16dXJ6b2NoREFETEsvVFNDa1hEOUl0?=
 =?utf-8?B?NGJyUG5UYnFka3JGMnlqRXpvRi9sWmQ5RFExR202TXJ1QVBoME9yUU9rNDlF?=
 =?utf-8?B?Zi9ScWd5Y2F1OE9HSjFDSVhma2UxR2FORFpVZXhDS25wSEJUUllscEc2OG5i?=
 =?utf-8?B?U1RyUTlHZXJvQTdvbktyU2NGcHNTWDh4MVdySU83M3ZRNkhiV1pndm5Wb0l2?=
 =?utf-8?B?R2RXM2ZRNEV4dm5FMEhVNDBGcW43dmZLd1hhT2p2SS9hWkpSekc3QTBrZ25F?=
 =?utf-8?B?WGpPQnZlL3ZBdlYwZlBYb0lXSlltN015c3lDOU9IYzkrSkdvM1lYcU1RcTFL?=
 =?utf-8?B?bFdFS29kTE9zR1hQYWY4dm5vcis2ZlZSdmdva3p4T3czbnM3QWFnV2pYb0I3?=
 =?utf-8?B?M1RaNEs0ZnMzUXQyUFI5d3VLdnBMenQ0b01sV29Rd1hCNGFFZjVEM3U2MjY3?=
 =?utf-8?B?eW90YmEwZWtCMitkTCtjNmtMU2tyb25pc3pPdXBJNkx2WHNZYXo0bHdXSFQ5?=
 =?utf-8?B?RU5kMDhERi93M0ZPZ1FaRVZqenFMS0lkdERXdHNPY0I5a3FhQmU3dFJPOEJ0?=
 =?utf-8?B?c2hiZU9sSzZGcjhOc0QvNmhNeVdURjZlZm1oUVZSQ1Vmc3h6V1NCYnpVSlo5?=
 =?utf-8?B?eklWcG9Ca3p5YnBST29OUm91Wi9ITHlSZmRyL3BXRncxY2JPK0pGTEN2T3Qx?=
 =?utf-8?B?WmpraUJEeTRIT2kvNUpMdUQzb1dzVnZ1K0FXaE1FcWZMOUJsRWl5dmI3MGIr?=
 =?utf-8?B?RUhwRXFiem16SnJIVjE2bjZHS1gxS0laTndWalBKYjd0YytBcXlrZGJ6VnJZ?=
 =?utf-8?B?Vy9oc013Q01NdGszVHk2Z1o1cWF3WUdEYnFjNDR4UkVDdnlXLzZhZjZWNVVL?=
 =?utf-8?B?elM3VUJEem9lKy9sRHNsa1p1ZUR2RVJjQVRNcDJZQmhFdWJTaGlHSTNIVUZt?=
 =?utf-8?Q?plFXgvYeL1MwuSHE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DuKydI6eaJ9bzYxwbikK0na4IToaqnVa9mLhdhpRq6Dij2AujJJIQ5+cIFN5amE8EYwOlHeohY8POTB4nk/pW2EKzaimQTQDE4I2VcwTzcICtOBphqMJyDhaj/lS50iEDFO0qn/9gI4Jzw3rVz3DwU1H5pwo76QQz1O25RZBM7aRDuvdNix+zCbJEni4OdhmTyrod1aTyaiJ07FixZKwvJ+xKtGFDo9zVRKFxWKmP+4Jjl8nR07PKQk8mk3tIkyhjiwwvwLm9541Nsu+rf1GIHKA4FOodphabs4MQDB6bWesj3Pe/kT6EMdvgzJ9kcp3qJTVAO/174fHqEwRzeoLb71Tm25nXCv9qbEADTefVk1Acu+CXxZFglXAAQUev3Sps11MDEOjc78Vfr1DzwtERFVSX5AoGYgCrHXbXxBY3F/wi/optBMBQbqYxvbnWP/6K2SGhbu6SyTEaigde+oPCrhoP6u5G1yyuRL3jroQ+3518mK/c9rpnMg60JFsqx2rNDKt9Mu9yvi5Pf7rgAVo8Owv2Kvbdhfz/LptdMpqlxKNGdRWyqQC9Ihx1cy4tHHqB7aZoyNv8EkYL1T73X0fAiK1K4L5P/Iqigh/duAR3so=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06968467-cc21-46c5-4e2d-08de7553bad8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:26:01.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtwCSDAJk74iSh5APEcjZI1oQKHCXl2RUNiNiDWh6UgMkiJMbARwZdYNwPhaj43WXBy0WKlzn05Jxm/iarLvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260147
X-Proofpoint-ORIG-GUID: EA0EzBHF53eGBV5az2masx-y0YD4-ynz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE0NyBTYWx0ZWRfX5UTZKyQw5+gT
 9E8QvRwUsudBoMmgUbt31rvFzD4QYvQkIPAj3nPlqt4+3RfHtwhGxGgaxDZl2+wjEZrKp++z/bf
 VFpm6KdNVo5rvOCzYfJjxC45v56J1hWPKMYLz5TgCBNmpDJauF0vTd5rxJq4GYzhPqWM6ZKf6Wg
 GV1AwRADHi/kSYSM02toufTRYrbDYhuMOXSzbcqH38PSn2N8jCjldFpOsPE83U+O8+J7I8NMzqj
 eNo1EUqXNSDqV2IbG2vMuabWptpKrdKqYRuXFLUQAde/i8hOd3rM9aAdywjJe+4uYBc9dXnPvfN
 qAVP+gcai7HfcPKJ8onEpi+CWpc7CzMef8pzxnsc8QXxyYtkuDTuqOJVLXdHz0/WwY7RurJZeTs
 N/vr6QSBW4GBnwiSl1LN/eklssdiX3fB1mfvYLLLiOLO9myzGqlG94T4SEnpXBhvLGgBRydzCE8
 LbWx490Kq+d9/ro/aWw==
X-Proofpoint-GUID: EA0EzBHF53eGBV5az2masx-y0YD4-ynz
X-Authority-Analysis: v=2.4 cv=D+xK6/Rj c=1 sm=1 tr=0 ts=69a07423 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iFABrAoMAAAA:20
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=ARdZ0EvgSWNiYBzn1lkA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22

On 26/02/2026 10:05, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> 
> [ ... ]
> 
>> @@ -5327,23 +5328,36 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
>>  		return -EINVAL;
>>  	}
>>
>> +	if (!btf_name_offset_valid(env->btf, t->name_off)) {
>> +		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
>> +				 env->log_type_id, t->name_off);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
>>  		btf_verifier_log(env, "[%u] Invalid kind:%u",
>>  				 env->log_type_id, BTF_INFO_KIND(t->info));
>>  		return -EINVAL;
>>  	}
>>
>> +	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->layout &&
>> +	    ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_layout)) <
>> +	     env->btf->hdr.layout_len) {
>                                        ^
> 
> Should this be <= instead of < ?  If the layout section has exactly
> N entries, layout_len is N * sizeof(struct btf_layout).  For the
> last covered kind (K = N - 1), this computes:
> 
>     (K + 1) * sizeof(struct btf_layout) == layout_len
> 
> With < that evaluates to false, so the last kind covered by the
> layout section falls through to the else branch and gets logged as
> "Invalid kind" instead of "unknown but required kind".
> 
> The libbpf equivalent in btf_type_size_unknown() uses:
> 
>     __u32 layout_kinds = btf->hdr.layout_len / sizeof(struct btf_layout);
>     if (!l || kind >= layout_kinds) {
> 
> which accepts the last entry.  Using <= here would match that
> behavior.
>

looking at this again, is it worth making the distinction between a kind
that's in the BTF layout but unknown to the kernel versus one that is
not in the BTF layout and unknown to the kernel? In both cases we reject
the BTF, and given that the kernel cannot be in the business of trusting
the layout provided with that BTF it seems like it's a distinction without
a practical difference.

 
>> +		btf_verifier_log(env, "[%u] unknown but required kind %u",
>> +				 env->log_type_id,
>> +				 BTF_INFO_KIND(t->info));
>>  		return -EINVAL;
>> +	} else {
>> +		if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
>> +			btf_verifier_log(env, "[%u] Invalid kind:%u",
>> +					 env->log_type_id, BTF_INFO_KIND(t->info));
>> +			return -EINVAL;
>> +		}
>> +		var_meta_size = btf_type_ops(t)->check_meta(env, t, meta_left);
>> +		if (var_meta_size < 0)
>> +			return var_meta_size;
>>  	}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22436234361
> 
> AI-authorship-score: low
> AI-authorship-explanation: Multi-year revision history with detailed reviewer interactions, idiomatic kernel C, and an off-by-one error typical of manual arithmetic translation are inconsistent with AI-generated code.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Off-by-one in layout bounds check produces wrong verifier log message but does not change functional behavior since both paths return -EINVAL.

