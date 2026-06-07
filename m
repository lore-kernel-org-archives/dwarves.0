Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574835836A;
	Sun,  7 Jun 2026 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826126; cv=fail; b=Ag7m5QoBA0Jha+D90CJ09zEwc8zL26HnTXGOu29bKttlKYvfvDurk3dUBqSfBWlrhsBMaiy0tsWyo9G62IXNZSwix0g9AaOgz37t+6hIeYmz254QiwUfs8UlkalTky8h5dr5ZCfuPQWbMuITqE9rl5sJXwTWIa+sodZjnszGPhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826126; c=relaxed/simple;
	bh=+3/m3V1HhF+Zu/QL6fKk3ugfsL1BWu8Rct/bGDqAarM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QhTt9HOf2prVtgA6qWzDZEKJNbiBHgNhEg1CY+OIpU7xWXiKKwTCfQSDUpWmaHUuwkUuyAvYvwKSAJeiCvNMsYokzGXoP0bX08dzYE3/zzbWiqY6pb6z25+CFC6YX2DdQUcAc7A0TlNpkL9a8tMyR0spwO8oyo8C27h+DEVy9jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q3L+gO+/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bwmEtAQV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q3L+gO+/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bwmEtAQV"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6579nHS8441790;
	Sun, 7 Jun 2026 09:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Go76bOw7ScRbQXTyVJ1QuQPBnEPmJZv2jpZPeMh10vQ=; b=
	q3L+gO+/O0mxF6K08yAoyn+EJ3R2pnLg8PQxn6xxcV3uOoF7NzP7eR8GqwaM1dV8
	Ks5Hrd2Wg34tyf7p4BaIt3yuf6s/gn9/lxmm7rZddMzx1CiIVvhAbVHj4w/2dgsF
	mHJD2+tyXKdaWpDMoopROd0xBN635/z+amRjNSU5s746oft626jMU4hSHFd0EFpg
	4cMHXKLmNqu7ss6giBDv8kgmomWMcBsiVh2X6e3l7Cm2FuLhDGAbIowwabE5Ap19
	yOurjGTYjpKs3DnKAyh+AjG6q9p88ukRHhZLoOhBRyQBzXr/SJgt+XjYe54Da3ZG
	eMWx50Z72WES78+jxMlJeQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ema4y153f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Jun 2026 09:55:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6579swcn023959;
	Sun, 7 Jun 2026 09:55:01 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0cctq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Jun 2026 09:55:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UazgL8e7rIx1pjuHJmxXlh5tdnU54pLfSGO+SKmoNN3uhSWRuGP35Kkre1B8uatVo9+ETSTra0TsZDbAvyI00QYEHzrj5DPrN7EbtFAQJb3SSkBMianan7UBhhd5J0PGdR2qCTaWfvGGNFQ1U9m2wvW9a+TDnyv1o62Xm06h3LwNyihMaks4a95YxAHihzdZ0isDYYibEJbB4fBkiNP5YPP+gBu7WeJ6DZler1/U4Ln3VqG/Jg/YojBSeEwbOH/C8CPcRHHaVxmgs1bxQ6qiOKIiyqWTZv+9BtTJVcql13T8JK6bag7rSHzsiaQnHakwZ7eJaRAodrh+79aW18GuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Go76bOw7ScRbQXTyVJ1QuQPBnEPmJZv2jpZPeMh10vQ=;
 b=P7J4AOI0k7QiX8/Ov2nlCUCVSZaLM7VR+10nhSFwkSEiPEMbp5+zuBFj7xav0qIiD9LshOA9VEbGDhgZLTcREnYL5rtdEY7OWBzu6bxp3wU4kcpmi08mtywA722TODQdgu7EMU7lK9vlSQdBO0f5tw02dBI5vKnYbVMJwUxCa5mQH26LdfPscEyvHF0oPKQxYi0vPna2DCNfh/Nmf2Vxs/3v9L21Z+NOhWmPlC8uRAfptMXliUsVizEkCXCH68Uj1jZo/q+bRbbGYVyVffNMNjPb1VRqiqB9c9tjU/K6JK+C21jeWwYzy87nig2sfs2HmbG8sZV33KTkcMEwj9FsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go76bOw7ScRbQXTyVJ1QuQPBnEPmJZv2jpZPeMh10vQ=;
 b=bwmEtAQVK3+otZM/XLmHU7bvt7rs1SeDkU6iEMya4qPLyyvIIHu5JqZ1jwb8Buan2XZxMclrAlzz6fCA7qJZ6xXMyI55vlVBDUvHvMWSo/bY0agYPSCu3SIvF1zBJB/v7qBSGakDZL209YuzptH5S0FB38kbQw2lj1+xzYDt6UM=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Sun, 7 Jun 2026
 09:54:42 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 09:54:42 +0000
Message-ID: <e258ee1d-369c-46f7-a93b-ed665c276130@oracle.com>
Date: Sun, 7 Jun 2026 10:54:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
To: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, acme@kernel.org,
        Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
        David Faust <david.faust@oracle.com>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260602195512.1511013-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MN2PR10MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 11806a83-6886-495e-f102-08dec47acc03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|4143699003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	47VjmYexYASLgcxyovj/t3KQArB3r+aei0eFBUS4pv6J9ScNnaskPreRjsHFyQHQFlBJUS6VWUysm39r9xklkUduL72Fr1aBDoCi52UCSE45njC33WlM3OKmYbRgxYcNfwQIW05qP3gL40pqifw08nk3K5ShJ4aYJErKdko1fsvmkr9cuNFp442hkiAJLyuTrvr0X94NKUu2Dr0TbWCozXXp5pDeMZmeejlVPsN+zCOsDmY4hASt5m6NbuFU3fwXds3ETjSoEYnM9e5C0nF2PSc7s+pYdr84Ihr5E5Fp42D4IKlkuTSj25UBY0poa6CyXznks88C5ZjzEaYetdpts2LDkwZBsFXwfdS8vD05G9hTyYgPAAC58N7lyAQO2v3+F2wI6+kJSABoJVas+U6xycoVJgCkElozXu787RFleQkpaMjogMDY7BLiuESV/5/8QF5/kbyuv0gJi5/pwo3IZm1WpfCtd56XcksTbaHCemwBoKpbUJzG2xiV8PmtAzhTXG7Msd7fMcsLbTQ/kHNrWvr7eWHXypQgJVD/ApCpq7qMXilpCVwgP754J0CxAyrAKkgjCyKwme5HpL77urSYgiCia376TRD4smPO/ui3fLk/7oa4fDAQQU0oIxJ9wOQf/qIRPPMbpgQQLWlYl8b1w18wZBZfXsVee85h+krXJUgcD1a3rSTSmt4pJi8e5kYl9OB+sLWU00RbJRoVvI8FPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(4143699003)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXczVDRxU2o1OUp5QjNFS2VwaFQwTUkwSjIybnhabm9VMXJRWW1LUUdTWU1O?=
 =?utf-8?B?RHptVHppb0dWc1VMcElZb2xkclg3MzlIU0hEVWtVMTIyQlpJbTZybWZxM0pp?=
 =?utf-8?B?NkZHTjQ2bHRSMS9YbXNSMmhRQTNHM3FpTHRhSlRoZFlyT0p5SXFoM21TZVcy?=
 =?utf-8?B?TUZKR0Q0VGdSR3Zwc3ZRMmtNMlZ3M0hvZnVFN2hRZ2Q1N3A0RE5qeWR0d0pV?=
 =?utf-8?B?SzdWNTFOSWw0cmdYS0s1VXVBRmx1MjZCWnUybjRsenR3Y3kvN3hYakxXSWdl?=
 =?utf-8?B?R1d4OUlFOTV1Nml6c0xZaXVBNHJVbUpQWnVKNWRLUkJuNkprbVo4N3lGU0Mw?=
 =?utf-8?B?NVZiczdSYW9WWVVqQjNDbkpwdi9SdVRteGk5aUtkYUpYMER4Vnh2a1A5cjVo?=
 =?utf-8?B?Q2xQRGw2Z3FWb3RuNTEzM1JCdTAzRytWakd0NS9NYkRMMldSNm56QUU0L2VN?=
 =?utf-8?B?eE9jTlA4SjhqeHM3b05ieXh1OXdtaXBDSjBjem9ZaGo2VXgzemJocmFMbHF0?=
 =?utf-8?B?ZG01UFp5d3htZkhuajR3Rm9XOEhJOEcrZXZSalRnVU9LVXlJMlo2dmo0Wllo?=
 =?utf-8?B?enFiQWNiRFNsTXl4M3dSQnZtZG9ZQ2YxS0RtS3kvdGtvTWx3cnRUazZmcWVN?=
 =?utf-8?B?U25nL1BwSCtLQW1iUjNpbUY1c1FNdUlSeXp0ZTBzWEp3cm9ldXpjU3BrOFNi?=
 =?utf-8?B?aWh5L3I1VmlPZnFIS2hFQUt4ejZIOXE0cHhicTN2NFg5UjBBZ29zNnpuUmNN?=
 =?utf-8?B?cGJaSjlkb3VXUGJCSE10T3h0SDFqV3F5K2d3MlZySTc2T0I5K2ZKSWg3Y1h0?=
 =?utf-8?B?WG5ZMGxBanc2SGtEdVdEaDBLOVFVUWkvaFNTNklSTnhoN001dkxmUFJ1bXlk?=
 =?utf-8?B?bWJHb3g5UVcySzltNEZSbnpyTHJuSFg3cTZpaWhXSGlSZkxaYXg1QVpuYXpv?=
 =?utf-8?B?Z3dXYTV4M3ZyL0VoMWZpSWk1d2txLzFpZmZuNkZia2NxMGlKTTJtTXZpTmpw?=
 =?utf-8?B?YlhwYm8wYmZJUFVBemg0SGZ6NGJFOFZ5ZFJpS1I4T1hZbG1HdUFRODYwYXlz?=
 =?utf-8?B?Mk1qSkd0WDVoS1lyZ2RwQmFsYW9uQzV3T2tlNDdiMzRxQ0o3TWdFTmJrWVNk?=
 =?utf-8?B?YVptb1NWQmNpR0tIc052bmV0VDVJMEkvZHQyN2E5dUFraXNxS2F5SnJGZnE4?=
 =?utf-8?B?YWdTMjNISFdhanBJMkxSbXEzZmVYTU0rRzg5R2VBYTZZY0dBRlI2UUltZ1BP?=
 =?utf-8?B?TGh4bHNRenlPNHc5YytyQVlTVlhTTC9hcjFBcHBIU0I3OFZ6ZUFzZ3RrajAz?=
 =?utf-8?B?TVQ3ZG9oVlllYmRDMUZNNFJuaGUxWWkzRmkvcUltN1pWMXZsQ0M2M0xsYWZ2?=
 =?utf-8?B?R2trSmVEdjM1NHdSenk3SlNXNjVraGJyMjNsQTZvMlpkL0h0UGFvOGVOdW0x?=
 =?utf-8?B?NXpLYWpUVnhTMHVpd2tEQjJ4MWNaNDJGNkNnVW1MbmJlb1lRNktmRXVBM00x?=
 =?utf-8?B?RU02MlphLy90Yk0zNTd5cmxueE1GOVRHc0lPcG1DLzBzVjJLQkkwS3NVTmFO?=
 =?utf-8?B?T2F3SkdhTVd3L1JybVNkMHRQNUxYQVNXMnlsVnlZcnI2eGExb1JZRzRZSG9l?=
 =?utf-8?B?dDY1TjM3c3dySnhiMHpNWjlNc2x2elJwWW9hREwyVDNTUVhDaHNGdWptK0xu?=
 =?utf-8?B?K2x1NFRmWm5qaE9xNDBUOFFXbG9oUUtRMk0zS0ROUGtnYzRROEcweFExR0Ji?=
 =?utf-8?B?SS93NHRRRHlpMG44VytUNVBDbEZzd25qRGN6czhpa0YyUS9hald2Sys1TUx1?=
 =?utf-8?B?clRuTmYyTmhCNmtNR2xQOGRrdDh2MFZsV0RrcHNFeEdzZURWWjQzQzVBQ1VJ?=
 =?utf-8?B?YitiT1EvZWF4NnlHRVprVXFsTXZrWFl5ZDhFZ2V1L0IrSDUwOGpJRG55aHVV?=
 =?utf-8?B?UHJkR2NpRWNYMXNvdzl0VlJZMEovcG1scXV1bUowMHQySHUwcHdGQjY2ZjM2?=
 =?utf-8?B?dWZCM3o5SzNBQU8yN3NQTEM5c2M1Q2xkU09UckZscS96Y1dyYThXTXhIdi9Z?=
 =?utf-8?B?UVNZeU1Qa3FQWGlKcVZLRlVKMDFWanJXQW9mN1pFcUJUL3ZUOUZZdXRHT3U4?=
 =?utf-8?B?dmE5bkhVZVVBdEtabjlVZDNHdzZaTEk5WDByRjI0MSt6N2dJY3V3YVBLRXhD?=
 =?utf-8?B?VjlBODMyWHJNVDRUVnlTRFRORzZEeGpjc3grQ2MvQXU3bUUrS005SmZlcHlF?=
 =?utf-8?B?bE02eElQMy8vcDdEMUhVNkFSU09VMm5iM1lReTJoQjh3VkJ5U3g4aE44aWlh?=
 =?utf-8?B?Tkl5ZWVyTWFmbE5aRWlOL2VucjUzbXpWaUx2ZWxZMU0wRHErdGlWUT09?=
X-Exchange-RoutingPolicyChecked:
	sbInZO1m5CmqO65BMEev661deg0KMqXBMCrdEKUzXsaqnnXgDP7IDiNMFg5aKPc96LpT7OrB9I4L12OfijO3lHMOfb8mioP2l8GQsFYLmDv/l3oMD9mPnN3LZZ0Lvqf5Y74tQvS8AAXYs7GEqnPvjCsP90+SvEp6ZzDuB7fpbTnnd/ZkE+SZJEJ2eAyWxUacOFDaHMLQo9OqDFy9PZyG1+YoKM3S+PApzw5X93Ysx74lk9egDY3yO+mTSG7s3N+6y+SUTAgVqgf9V8OGNk5TOubh0oGQGdimX62hU4MkHZ+lD8oF+f+J0wL8GGZ298wJ3QgdDU4g0enDuv+oE8cjJQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jjpyyKfbGIaJxPlPhU1JgMtdeUAfM+Vimjhka2K0HLQcfDY5CoRk+iygd6AoaFqDegK5pSEXuliku5Tan7xMmIgpU7tqwLDrkY0DnsIREO6LOFilEqRH/05qPtzaZp213cAqrwGl5ieGSbecTtdQvoRmqXMVtmTwfjww9J2ChqCI7qtU5XfpT948YxJh7QbPUrxNUvnrHWdSRkt3uUwqB4vRTcLovDr3nYpBSJBRvLoTQcpsuz+R31uqDmo7GD72Hpmja967QeY3CcwlXzruK3oftTYZSKhC3CERzTmUMuG5KdOqM6UtbfyO9rZqfN2ed5P/1u7w0zREnnofdzgIlIn8N0gTz3fIkXWrun58w7EYOu/sKDPRpL3iaNzSgJeKQ3BmHs3iRUmkmmejXVYyZxqAQbL6IBrzVqhdejQT4e1rP4hGQljQQqvJ5tn7IMXXxAXN4eZ37jXvpXTC+PPPY78oUjCw62p7hVhtWcpcsPR60WLJBWABMtu4oZhNAKtPspZq7YFGVhkh/xxdUkFa0F7ph3rjlPa8iNfKrv71c1/guFMyjlPqyr6DaGxX5yFd8bhe6hKmBl21l8u/azpj/FmmsQFVahK4QzTwzsqgJac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11806a83-6886-495e-f102-08dec47acc03
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 09:54:42.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAfWN+fjVCa78pd9L1iiqtD/cJDOYG+OcqgaApeph536Q09ot6oFp1pULyAVyQB3dE0StQe6iOfuBBglbglHQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606070096
X-Authority-Analysis: v=2.4 cv=ZMvnX37b c=1 sm=1 tr=0 ts=6a253ff5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=A8oJy8mYAAAA:8 a=xbN_RWdLkxfpcboYsnEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=MasS0_dV9q-jaWZIey9J:22
X-Proofpoint-ORIG-GUID: VQqrMD6N1jzmUevYepHIsS6_yoUn8ujy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDA5NiBTYWx0ZWRfX3Fw8jM531mAp
 Zs5Xkhc0kcA6fI13BPFc1BSTO229FV6R65DCWnCnzesbJtgN7XifEJTUiyxx9GehbSNj3TMOGSU
 DZRelc1gkjN/Qc3KvCWIs5fsWHg8lVdDnDeNsmCt5IbBnAr9khmmw0vZbw7ACwL8frLp/83nAf9
 fJ8S0kZAPwG/3Yo8/V0tsd6aOaM6AYOH9/keA5SNgFsSM5IirkMWlMHkGv0T4zX9a3SGOklce6X
 sp41iCwG7IhrRanohn7b06Bi/AHTU0mAyXjH7ASGhSH4P6fVPuF1NXPajpVz7kzPF4NbLYkCJ2J
 VFyjTsZQ5tGWcgzCUQhaa5oC3zKfrFW7VVPX+N/mBMnUtWT/8l9oSgsW5JmZK566+qD/N/wJD5Z
 qpenawMq7Xkyrb4Xfo2JlmxmfXHUgzxNLV9kr/aAqX2H2OZqn1BxxZL2Pq6AwBf8+OhCnK5Fsmd
 rnvITEK9p+K1XFrymOQ==
X-Proofpoint-GUID: VQqrMD6N1jzmUevYepHIsS6_yoUn8ujy

On 02/06/2026 20:55, Vineet Gupta wrote:
> gcc 16 was the first release to support DW_TAG_GNU_annotations and this
> patch enables the same in pahole. Bulk of changes are dwarf_loader but
> btf_encoder also gains support with minimal changes.
> 
> GCC encodes btf_type_tag and btf_decl_tag annotations differently from
> LLVM. While LLVM uses DW_TAG_LLVM_annotation (0x6000) as child DIEs,
> GCC uses DW_TAG_GNU_annotation (0x6001) as standalone sibling DIEs
> referenced via DW_AT_GNU_annotation (0x2139) attributes, with chaining
> through the same attribute on annotation DIEs themselves.
> 
> Handle both encoding styles:
> 
> For btf_type_tag (pointer annotations):
> - Recognize DW_TAG_GNU_annotation alongside DW_TAG_LLVM_annotation in
>   child annotation scanning.
> - Follow DW_AT_GNU_annotation attribute chains on pointer types for
>   GCC-style btf_type_tag resolution.
> - Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation in the
>   internal representation so downstream code works unchanged.
> 
> For btf_decl_tag (function/struct/member annotations):
> - Add add_gnu_annotation_chain() to follow DW_AT_GNU_annotation
>   attribute chains on function, struct, and member DIEs.
> - GCC puts DW_AT_GNU_annotation on the function/struct DIE itself
>   (not as child DIEs), referencing sibling annotation DIEs that chain
>   via the same attribute.
> 
> Also:
> - Silently skip standalone DW_TAG_GNU_annotation DIEs at CU level.
> - Add tag__is_annotation() helper macro for annotation tag checks.
> - Rename add_llvm_annotation -> add_tag_annotation,
>   skip_llvm_annotations -> skip_tag_annotations since these now
>   handle both LLVM and GNU annotation formats.
> 
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

Thanks for the respin! Sorry for the delay took me a while to get set
up with latest gcc. Two things below, but in summary there are a few
things we need to line things up between clang and gcc representations
I think. To test these completely there are some existing btf_loader/pfunct
issues below that I've outlined; I can send patches for those fixes as 
prerequisites, or feel free to roll into a respin, whatever you'd prefer. 

> ---
> Changes since v3 [3]
>  - Add helper tag__is_annotation [Emil]
>  - Rename some functions containing "llvm" as they are common to LLVM/GCC tags [Emil]
>  - Deduplicate checks before loop and inside loop in add_gnu_annotation_chain() and check_gnu_attr [Arnaldo]
>  - Fix some typos and move some comments [Emi]
> 
> Changes since v2 [2]
>  - Removed loop detection logic [Alan]
>  - Move test changes to different patch [Alan]
> 

I don't want to introduce scope creep - and I may be missing something -
but it seems like the current changes don't cover decl tags for function
parameters. On this topic, there is an existing bug where decl tags
that have a component_idx reference are not rendered correctly by pfunct
which makes testing that properly impossible today. Parameter decl tags are 
prepended to the function declaration rather than tied to the 
parameter referenced by the component_idx, so we should fix that first.
The root cause is btf_loader.c always attaches attributes to the function,
whereas it should use the component_idx to attach them to the parameter
tag where component_idx >= 0.

The following changes are needed to fix that I think:

diff --git a/btf_loader.c b/btf_loader.c
index b591219..9bb52c3 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -477,12 +477,56 @@ static struct attributes *attributes__realloc(struct attributes *attributes, con
        return result;
 }
 
+static struct tag *ftype__parameter(const struct ftype *ftype, int component_idx)
+{
+       struct parameter *pos;
+       int idx = 0;
+
+       ftype__for_each_parameter(ftype, pos) {
+               if (idx == component_idx)
+                       return &pos->tag;
+               ++idx;
+       }
+
+       return NULL;
+}
+
+static struct tag *function__parameter(const struct function *func, struct cu *cu,
+                                      int component_idx)
+{
+       struct tag *tag;
+
+       if (component_idx < 0)
+               return NULL;
+
+       tag = cu__type(cu, func->proto.tag.type);
+       if (tag == NULL)
+               return NULL;
+
+       return ftype__parameter(tag__ftype(tag), component_idx);
+}
+
 static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
 {
+       int component_idx = btf_decl_tag(tp)->component_idx;
        struct tag *tag = cu__type(cu, tp->type);
        struct attributes *tmp;
 
-       if (tag == NULL)
+       if (component_idx >= 0) {
+               struct tag *func_tag = cu__function(cu, tp->type);
+
+               if (func_tag != NULL) {
+                       tag = function__parameter(tag__function(func_tag), cu,
+                                                 component_idx);
+                       if (tag == NULL) {
+                               fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in BTF id %d\n",
+                                       component_idx, tp->type);
+                               return 0;
+                       }
+               }
+       }
+
+       if (tag == NULL && component_idx < 0)
                tag = cu__function(cu, tp->type);
 
        if (tag == NULL)
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 757e499..ab1c381 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1203,6 +1203,18 @@ const char *function__prototype(const struct function *func,
                                        bf, len);
 }
 
+static size_t tag__attributes_fprintf(const struct tag *tag, FILE *fp)
+{
+       size_t printed = 0;
+       int i;
+
+       if (tag->attributes)
+               for (i = 0; i < tag->attributes->cnt; ++i)
+                       printed += fprintf(fp, "%s ", tag->attributes->values[i]);
+
+       return printed;
+}
+
 size_t ftype__fprintf_parms(const struct ftype *ftype,
                            const struct cu *cu, int indent,
                            const struct conf_fprintf *conf, FILE *fp)
@@ -1244,6 +1256,7 @@ size_t ftype__fprintf_parms(const struct ftype *ftype,
                                if (n)
                                        return printed + n;
                                if (ptype->tag == DW_TAG_subroutine_type) {
+                                       printed += tag__attributes_fprintf(&pos->tag, fp);
                                        printed +=
                                             ftype__fprintf(tag__ftype(ptype),
                                                            cu, name, 0, 1, 0,
@@ -1252,12 +1265,14 @@ size_t ftype__fprintf_parms(const struct ftype *ftype,
                                }
                        }
                } else if (type->tag == DW_TAG_subroutine_type) {
+                       printed += tag__attributes_fprintf(&pos->tag, fp);
                        printed += ftype__fprintf(tag__ftype(type), cu, name,
                                                  true, 0, 0, 0, conf, fp);
                        continue;
                }
                stype = tag__name(type, cu, sbf, sizeof(sbf), conf);
 print_it:
+               printed += tag__attributes_fprintf(&pos->tag, fp);
                printed += fprintf(fp, "%s%s%s", stype, name ? " " : "",
                                   name ?: "");
        }
@@ -1409,11 +1424,8 @@ static size_t function__fprintf(const struct tag *tag, const struct cu *cu,
        struct ftype *ftype = func->btf ? tag__ftype(cu__type(cu, func->proto.tag.type)) : &func->proto;
        size_t printed = 0;
        bool inlined = !conf->strip_inline && function__declared_inline(func);
-       int i;
 
-       if (tag->attributes)
-               for (i = 0; i < tag->attributes->cnt; ++i)
-                       printed += fprintf(fp, "%s ", tag->attributes->values[i]);
+       printed += tag__attributes_fprintf(tag, fp);
 
        if (func->virtuality == DW_VIRTUALITY_virtual ||
            func->virtuality == DW_VIRTUALITY_pure_virtual)

 
Now with that fix in place, we can add a decl tag parameter case to the pfunct test:

diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
index a46aa1f..520148b 100755
--- a/tests/pfunct-btf-decl-tags.sh
+++ b/tests/pfunct-btf-decl-tags.sh
@@ -41,6 +41,7 @@ src=$(cat <<EOF
 __tag(a) __tag(b) __tag(c) void foo(void) {}
 __tag(a) __tag(b)          void bar(void) {}
 __tag(a)                   void buz(void) {}
+void qux(int __tag(param_a) arg) {}
 
 EOF
 )
@@ -48,13 +49,17 @@ EOF
 # tags order is not guaranteed
 sort_tags=$(cat <<EOF
 {
-match(\$0,/^(.*) (void .*)/,tags_and_proto);
-tags  = tags_and_proto[1];
-proto = tags_and_proto[2];
-split(tags, tags_arr ,/ /);
-asort(tags_arr);
-for (t in tags_arr) printf "%s ", tags_arr[t];
-print proto;
+delete tags_arr;
+if (match(\$0,/^(.*) (void .*)/,tags_and_proto)) {
+       tags  = tags_and_proto[1];
+       proto = tags_and_proto[2];
+       split(tags, tags_arr ,/ /);
+       asort(tags_arr);
+       for (t in tags_arr) printf "%s ", tags_arr[t];
+       print proto;
+} else {
+       print \$0;
+}
 }
 EOF
 )
@@ -63,6 +68,7 @@ expected=$(cat <<EOF
 a b c void foo(void);
 a b void bar(void);
 a void buz(void);
+void qux(param_a int arg);
 EOF
 )
 
@@ -98,7 +104,8 @@ fi
 
 if [ "$use_clang" -eq 1 ]; then
        tmpobj=$(make_tmpobj)
-       echo "$src" | $CLANG --target=bpf -c -g -x c -o $tmpobj -
+       echo "$src" | $CLANG -c -g -x c -o $tmpobj -
+       pahole -J $tmpobj 2>/dev/null
        run_test "$CLANG" "$tmpobj" || failed=1
 fi
 
Running this we see:

 ./pfunct-btf-decl-tags.sh 
Check that pfunct can print btf_decl_tags read from BTF.
   Testing with gcc (version 17)
   pfunct output does not match expected (gcc (version 17)):
   --- /dev/fd/63 2026-06-07 10:42:19.711753983 +0100 +++ /dev/fd/62 2026-06-07 10:42:19.711753983 +0100 @@ -1,4 +1,4 @@ a b c void foo(void); a b void bar(void); a void buz(void); -void qux(param_a int arg); +void qux(int arg);
   
   Complete output:
   a b c void foo(void); a b void bar(void); a void buz(void); void qux(int arg);
   Testing with clang
   passed
Test ./pfunct-btf-decl-tags.sh failed
Test data is in /tmp/pfunct-btf-decl-tags.sh.hXPG6r

The following change to dwarf_loader.c fixes this:

diff --git a/dwarf_loader.c b/dwarf_loader.c
index c492b56..7f5b44d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1910,6 +1910,8 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
                if (param_idx >= 0) {
                        if (add_child_llvm_annotations(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
                                return NULL;
+                       if (add_gnu_annotation_chain(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
+                               return NULL;
                }
        } else {
                /*


> Changes since v1 [1]
>  - NFC Reduce indentation with early exits (Alexei offlist)
> 
> [3] https://lore.kernel.org/bpf/20260601183511.594100-2-vineet.gupta@linux.dev/
> [2] https://lore.kernel.org/bpf/20260528223616.2035618-2-vineet.gupta@linux.dev/
> [1] https://lore.kernel.org/bpf/20260526181818.4159927-2-vineet.gupta@linux.dev/
> ---
>  btf_encoder.c     |   1 +
>  dutil.h           |  11 +++++
>  dwarf_loader.c    | 105 +++++++++++++++++++++++++++++++++++++++-------
>  dwarves.h         |   2 +-
>  dwarves_fprintf.c |  12 ++++--
>  5 files changed, 110 insertions(+), 21 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 633bc6162ce0..d5af706d7638 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1831,6 +1831,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>  		name = namespace__name(tag__namespace(tag));
>  		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPEDEF, ref_type_id, name, false);
>  	case DW_TAG_LLVM_annotation:
> +	case DW_TAG_GNU_annotation:
>  		name = tag__btf_type_tag(tag)->value;
>  		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPE_TAG, ref_type_id, name, false);
>  	case DW_TAG_structure_type:
> diff --git a/dutil.h b/dutil.h
> index ff78aa6dfd10..be02c68cf4a7 100644
> --- a/dutil.h
> +++ b/dutil.h
> @@ -35,6 +35,17 @@
>  #define DW_TAG_LLVM_annotation 0x6000
>  #endif
>  
> +#ifndef DW_TAG_GNU_annotation
> +#define DW_TAG_GNU_annotation 0x6001
> +#endif
> +
> +#ifndef DW_AT_GNU_annotation
> +#define DW_AT_GNU_annotation 0x2139
> +#endif
> +
> +#define tag__is_annotation(tag) \
> +	((tag) == DW_TAG_LLVM_annotation || (tag) == DW_TAG_GNU_annotation)
> +
>  static inline __attribute__((const)) bool is_power_of_2(unsigned long n)
>  {
>          return (n != 0 && ((n & (n - 1)) == 0));
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 42a0f3f74ce3..14f71c9043aa 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -908,7 +908,12 @@ static int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t b
>  	return -ENOMEM;
>  }
>  
> -static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
> +static bool die__tag_is_annotation(Dwarf_Die *die)
> +{
> +	return tag__is_annotation(dwarf_tag(die));
> +}
> +
> +static int add_tag_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
>  			       struct list_head *head)
>  {
>  	struct llvm_annotation *annot;
> @@ -943,16 +948,40 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
>  
>  	die = &child;
>  	do {
> -		if (dwarf_tag(die) == DW_TAG_LLVM_annotation) {
> -			ret = add_llvm_annotation(die, component_idx, conf, head);
> -			if (ret)
> -				return ret;
> -		}
> +		if (!die__tag_is_annotation(die))
> +			continue;
> +
> +		ret = add_tag_annotation(die, component_idx, conf, head);
> +		if (ret)
> +			return ret;
>  	} while (dwarf_siblingof(die, die) == 0);
>  
>  	return 0;
>  }
>  
> +/*
> + * Handle gcc style btf_decl_tag annotations for functions/struct/member tags.
> + * Pointers are handled separately, inline in die__create_new_pointer_tag()
> + */
> +static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
> +				    struct conf_load *conf, struct list_head *head)
> +{
> +	Dwarf_Attribute attr;
> +	Dwarf_Die annot_die;
> +
> +	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL &&
> +	       dwarf_formref_die(&attr, &annot_die) != NULL &&
> +	       dwarf_tag(&annot_die) == DW_TAG_GNU_annotation) {
> +		int ret = add_tag_annotation(&annot_die, component_idx, conf, head);
> +		if (ret)
> +			return ret;
> +
> +		die = &annot_die;
> +	}
> +
> +	return 0;
> +}
> +
>  int class_member__dwarf_recode_bitfield(struct class_member *member,
>  					struct cu *cu)
>  {
> @@ -1596,6 +1625,8 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
>  		return NULL;
>  
>  	tag__init(&tag->tag, cu, die);
> +	/* Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation internally */
> +	tag->tag.tag = DW_TAG_LLVM_annotation;
>  	tag->value = attr_string(die, DW_AT_const_value, conf);
>  	return tag;
>  }
> @@ -1637,19 +1668,21 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
>  {
>  	struct btf_type_tag_ptr_type *tag = NULL;
>  	Dwarf_Die *cdie, child;
> +	Dwarf_Attribute attr;
> +	Dwarf_Die annot_die;
>  	const char *name;
>  
> -	/* If no child tags or skipping btf_type_tag encoding, just create a new tag
> -	 * and return
> -	 */
> -	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0 ||
> -	    conf->skip_encoding_btf_type_tag)
> +	/* If skipping btf_type_tag encoding, just create a new tag, return */
> +	if (conf->skip_encoding_btf_type_tag)
>  		return tag__new(die, cu);
>  
> -	/* Otherwise, check DW_TAG_LLVM_annotation child tags */
> +	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
> +		goto check_gnu_attr;
> +
> +	/* Handle LLVM style annotation tags if present */
>  	cdie = &child;
>  	do {
> -		if (dwarf_tag(cdie) != DW_TAG_LLVM_annotation)
> +		if (!die__tag_is_annotation(cdie))
>  			continue;
>  
>  		/* Only check btf_type_tag annotations */
> @@ -1662,6 +1695,26 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
>  			return NULL;
>  	} while (dwarf_siblingof(cdie, cdie) == 0);
>  
> +check_gnu_attr:
> +	if (tag != NULL)
> +		goto out;
> +
> +	/* Handle GCC-style DW_AT_GNU_annotation attribute */
> +	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL &&
> +	       dwarf_formref_die(&attr, &annot_die) != NULL &&
> +	       dwarf_tag(&annot_die) == DW_TAG_GNU_annotation) {
> +		name = attr_string(&annot_die, DW_AT_name, conf);
> +		if (strcmp(name, "btf_type_tag") != 0)
> +			break;
> +
> +		tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf);


I think there may be an issue here. die__add_btf_type_tag() will prepend
discovered tags to give us the BTF representation we want. However a
proof-of-concept test shows that gcc tested with latest master branch
as of

commit 0e634b961123280c17c1c651b1d8b1567b9b523c (HEAD -> master, origin/trunk, origin/master, origin/HEAD)
Author: Marc Poulhiès <poulhies@adacore.com>
Date:   Fri Mar 27 16:29:16 2026 +0100

    ada: Fix bug when reading multibyte utf-8 character
    

...shows that the DWARF representation already has the BTF-desired
order, so we wind up reversing it. Test below, but I _think_ something
like this may be needed:

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 14f71c9..c492b56 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1633,7 +1633,8 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
 
 static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_type_tag_ptr_type *tag,
                                                            Dwarf_Die *die, Dwarf_Die *adie,
-                                                           struct cu *cu, struct conf_load *conf)
+                                                           struct cu *cu, struct conf_load *conf,
+                                                           bool prepend)
 {
        struct btf_type_tag_type *annot;
        uint32_t id;
@@ -1656,10 +1657,38 @@ static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_type_tag_p
        cu__hash(cu, &annot->tag);
 
        /*
-        * Prepends: for annotations tag1 -> tag2 -> tag3,
-        * the tag->tags list ends up as tag3 -> tag2 -> tag1.
+        * Consider the following set of type tags:
+        *
+        * #define __tag(x) __attribute__((btf_type_tag(#x)))
+        *
+        * struct sample {
+        *      int value;
+        * };
+        *
+        * struct sample __tag(outer) __tag(inner) *global_ptr;
+        *
+        * The BTF chain should describe the pointer as:
+        *
+        * PTR -> TYPE_TAG "inner" -> TYPE_TAG "outer" -> STRUCT "sample"
+        * 
+        * The tag nearest *global_ptr applies to the pointer’s immediate pointee
+        * type first. So inner wraps outer struct sample.
+        *      
+        * For clang DWARF, child annotation DIEs are seen as "outer, inner"
+        * so to get the right final order we need to prepend.
+        *
+        * For GCC DWARF, the explicit DW_AT_GNU_annotation chain starts at the outermost
+        * BTF wrapper:
+        *
+        * pointer DIE -> inner annotation -> outer annotation -> struct sample
+        *
+        * so in this case we preserve that traversal order and append.
         */
-       list_add(&annot->node, &tag->tags);
+       if (prepend)
+               list_add(&annot->node, &tag->tags);
+       else
+               list_add_tail(&annot->node, &tag->tags);
+
        return tag;
 }
 
@@ -1690,7 +1719,7 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
                if (strcmp(name, "btf_type_tag") != 0)
                        continue;
 
-               tag = die__add_btf_type_tag(tag, die, cdie, cu, conf);
+               tag = die__add_btf_type_tag(tag, die, cdie, cu, conf, true);
                if (tag == NULL)
                        return NULL;
        } while (dwarf_siblingof(cdie, cdie) == 0);
@@ -1707,7 +1736,7 @@ check_gnu_attr:
                if (strcmp(name, "btf_type_tag") != 0)
                        break;
 
-               tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf);
+               tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf, false);
                if (tag == NULL)
:


Here's a test (feel free to adapt it if needed) that fails until the above is applied:

#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only

# Check that pahole preserves btf_type_tag order when emitting BTF from DWARF.

source test_lib.sh

outdir=$(make_tmpdir)

# Comment this out to save test data.
trap cleanup EXIT

title_log "Check BTF type tag order."

GCC=${GCC:-gcc}
CLANG=${CLANG:-clang}
PAHOLE=${PAHOLE:-pahole}
BPFTOOL=${BPFTOOL:-bpftool}

if ! command -v "$BPFTOOL" > /dev/null; then
	info_log "skip: bpftool not available"
	test_skip
fi

compiler_has_btf_type_tag()
{
	local compiler=$1

	if ! command -v "$compiler" > /dev/null; then
		return 1
	fi

	"$compiler" -x c -E -P - <<'EOF' 2>/dev/null | grep -qx 1
#ifndef __has_attribute
#define __has_attribute(x) 0
#endif
#if __has_attribute(btf_type_tag)
1
#else
0
#endif
EOF
}

use_gcc=0
if compiler_has_btf_type_tag "$GCC"; then
	use_gcc=1
fi

use_clang=0
if compiler_has_btf_type_tag "$CLANG"; then
	use_clang=1
fi

if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
	error_log "Need gcc or clang with btf_type_tag support for test $0"
	test_fail
fi

src=$(cat <<EOF
#define __tag(x) __attribute__((btf_type_tag(#x)))

struct sample {
	int value;
};

struct sample __tag(outer) __tag(inner) *global_ptr;

EOF
)

check_type_tag_order()
{
	local btf=$1
	local dump

	if ! dump=$("$BPFTOOL" btf dump file "$btf"); then
		return 1
	fi

	printf '%s\n' "$dump" | awk '
	function parse_id(line, m) {
		if (match(line, /^\[([0-9]+)\]/, m))
			return m[1]
		return 0
	}
	function parse_name(line, m) {
		if (match(line, /\047([^\047]*)\047/, m))
			return m[1]
		return ""
	}
	function parse_type(line, m) {
		if (match(line, /type_id=([0-9]+)/, m))
			return m[1]
		return 0
	}
	function check_ptr(ptr, id, tags, seen) {
		id = type[ptr]
		while (id != 0 && !seen[id]) {
			seen[id] = 1
			if (kind[id] == "TYPE_TAG") {
				tags = tags (tags == "" ? "" : " -> ") name[id]
				id = type[id]
				continue
			}
			if (kind[id] == "STRUCT" && name[id] == "sample") {
				if (tags == "inner -> outer")
					exit 0
				candidates = candidates (candidates == "" ? "" : ", ") tags
			}
			return
		}
	}
	/^\[[0-9]+\]/ {
		id = parse_id($0)
		kind[id] = $2
		name[id] = parse_name($0)
		type[id] = parse_type($0)
		if (kind[id] == "PTR")
			ptrs[++nr_ptrs] = id
	}
	END {
		for (i = 1; i <= nr_ptrs; i++)
			check_ptr(ptrs[i])
		if (candidates != "") {
			print "type tag order mismatch; expected inner -> outer, found " candidates > "/dev/stderr"
			exit 1
		}
		print "could not find tagged pointer to struct sample" > "/dev/stderr"
		exit 1
	}'
}

run_test()
{
	local compiler=$1
	local tmpobj=$2
	local btf=$3

	info_log "Testing with $compiler"

	if ! echo "$src" | "$compiler" -g -c -x c -o "$tmpobj" - 2>/dev/null; then
		error_log "Could not compile type tag order test with $compiler"
		return 1
	fi

	if ! "$PAHOLE" --btf_features=+type_tag --btf_encode_detached="$btf" "$tmpobj" 2>/dev/null; then
		error_log "Could not encode BTF for $tmpobj"
		return 1
	fi

	if check_type_tag_order "$btf"; then
		info_log "  passed"
		return 0
	fi

	error_log "BTF type tag order does not match expected order ($compiler)"
	return 1
}

failed=0

if [ "$use_gcc" -eq 1 ]; then
	tmpobj=$(make_tmpobj)
	btf=${tmpobj%.o}.btf
	run_test "$GCC" "$tmpobj" "$btf" || failed=1
fi

if [ "$use_clang" -eq 1 ]; then
	tmpobj=$(make_tmpobj)
	btf=${tmpobj%.o}.btf
	run_test "$CLANG" "$tmpobj" "$btf" || failed=1
fi

if [ "$failed" -eq 0 ]; then
	test_pass
else
	test_fail
fi

