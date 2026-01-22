Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E62D46BD;
	Thu, 22 Jan 2026 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106153; cv=fail; b=VS7OBATkq93t5KQ0EWAHjhDFFsiq4O5IQlgVb3FyQ9EtHwcVL+q842PuS/OUSrhtxaDta7d2uWcMFf3b+t8mut7a56088Z3zuepbqGTg5WsnIunchLNIiO6PFKvxNWeUJD8Diw2eA2srWiaXgehEEzPoaiQpKY3bXfKf0qRGY0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106153; c=relaxed/simple;
	bh=2g8iEExXO4teErjtrfIUPUoF7ddi1HO3Y36qE0jNGns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sIzknR1jF5wVWwr6UTIj9f77efdVTdBQhOBJV287PBR0d5c4I/en6aQHfast5uD5kOcwiecWKOZci92BFbNaIAPLnEagS0U673k4dqagJmx/840ksMASpJvWRNpCD2y6wxhdviBnLbhmhdYD2jT7KIpC3W3BcyvpPYsDgu+fl50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mgIqKrzW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YWd9QPZu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgIqKrzW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YWd9QPZu"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgYL9329851;
	Thu, 22 Jan 2026 18:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W8DJ1enhuMvOiuWjbrrd9weKBxODUhC1aPE8P7MQmao=; b=
	mgIqKrzWb1+vvefzC1tmjj/4bIw4qmw6me5g9IP9JoCmBP3Rp98VPYGd4+P+FMEu
	KAbu6HZCBRCN07/6OJHtGn8Jwh5AtUzkRzdAMfsUguRN+mIHCMg9Rfn7Ice2H2po
	0Qi8/iosGHWC33hPzbq56is7r4THClwc75BGtGTYLC4KtTRzlxWys5d6ZzcBHk7b
	SB6jIhmQbQS2dunLVlLIji7eefJdUvEBHYwlUMpuN3txQdlDbPK84EkFWGZX+xla
	PDHZ3HUG31WjZbdNKSsHEMhF5M12uEXsAe4MT6pw3B52ieXX03s4M7EUQyxwPgMC
	KLo80bRfCxCM5BJdLXMBfw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd4rea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 18:22:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MI5rBO038127;
	Thu, 22 Jan 2026 18:22:04 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd7nuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 18:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEtEsmRSnKW0KCtZhXF4yPrPPlL5lHF5BB7by9JbUpU6JMjxQ657BcifmEwIGhjZJSZbvNYguBhrommPiLqXTTQ4ZEI4f9mlbAV7DwwdFqSmj30Bcekt35QoEmBrQfN1GdXrG7OgIZLF0eZm2E6FPf7ciyFXoOpTYxbM3rSjtNM/hwDDwhxEtlvHuD1pACXFYhYmz7q49gqq4e7sEDHhI+VBn115ktaq3GvCwWSX/mCQYw4QhvRW9XyjcPVwfeh5thnBzMZz+4bal6nuj6Ezy7yDgl+hhC+o1ZW9cCxUk+FZf9DUZBU+wL7lt3fpR4ddATXKYeBqvo8C6ljk/pZIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8DJ1enhuMvOiuWjbrrd9weKBxODUhC1aPE8P7MQmao=;
 b=ebPgND2PvpQfQwGDiGdLC2RXSRbR/Jl6v995HOxZrSlyMs3rQAoaUrjOh1M8YNWSmEYIClYvIjgnK7LbTxw8ZxftUbdkd4SeGMiwmGcQHxqjvUB1cfCAdcFbHLUwGkMuXXoqFMwwsHl++rUAWfM+HuHGBl882aQ62aKiDsIc7OJaoNO7HjzEhop6UoRVlXiKWHD7ThLBhK/U2PwO1mpdxv7T9Vd/vIqae5RWFARZydbMkYk3fTKtEjOVdmknqiWGrvUlzj3KtffX7h9NLLT7iAcBHGQlOLn3sPxLaKWL4Pao/ucZaMxHhJYwgHwCS904JS24t+sdZQMzl7jvUq+z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8DJ1enhuMvOiuWjbrrd9weKBxODUhC1aPE8P7MQmao=;
 b=YWd9QPZuogoflNA12QN4okocyufoNLCDdfe7P9VNOjH6te3+sDvxOqs+P5T8kSEdX8B2KdZIa+5rsgVNDNpDWAnn62mjsPEeAaIT+zIgUWwsDePtuIhJBAOWHnb+4WHbq7qSKhB+Xl6m2E/Jl2MTA36WRR0zV9PkHvdSr/hzFo8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Thu, 22 Jan 2026 18:21:54 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 18:21:54 +0000
Message-ID: <49f81b2e-187e-4056-b6de-9a7f028c2f5a@oracle.com>
Date: Thu, 22 Jan 2026 18:21:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/4] btf_encoder: Add true_signature feature
 support for "."-suffixed functions
To: Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-4-alan.maguire@oracle.com>
 <4d7c529c-a910-431f-8e6a-b8e5f4f7cffa@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <4d7c529c-a910-431f-8e6a-b8e5f4f7cffa@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0133.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d03e6c-0420-48a9-8465-08de59e31e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW91M0pnS3lYR2xvOU5QMm41WEFTNjVTRmFrbEdTS00yZGV4blZvL0FxbHMv?=
 =?utf-8?B?dGpmNUcyQ2NkMGlFYXhZL3U5OFhGb2JvYWk2dmZpUys2dXdTb0ZmTFZTdDdm?=
 =?utf-8?B?czdSYTlJVC84Sk82MDBoSExxZFcrMC8ya2NoZERpalc4eGRuZVZLK3d4ME01?=
 =?utf-8?B?V2NoRHZ1c2V4YUN6TXN3VFhJTnBSazQ1YU0yR0tLUitXZmlHS29TMncrYm1P?=
 =?utf-8?B?bE55Unhmc0NlSlpOL1JLZXQwSDFEVDAyajR6bWVhK2tVSWNEK3NxYm1DR280?=
 =?utf-8?B?NDBZa0k1Rk5sVjYwOWhLSFFXeGVpOVBDZFkyQTR2MU5CaVRBL2FGUTdsd1gx?=
 =?utf-8?B?NTVOVHREbTl2VysvOVhXeG1SbXRCMEYxcmZsNTBaN2ZCcm1HODZGQjNTTkE2?=
 =?utf-8?B?VkYyakNiQ3VWSnhhME9JcVhldU5lN21DUGhDdStJeFQ0dGo4ZkJXenJHVEpQ?=
 =?utf-8?B?SC9mV2dIMWVRUWFNQVFuVkZmQklOTStibVdva2RnQ1o5K3QwcC80bTNBSU56?=
 =?utf-8?B?cFJQYW05TXBzWTk2ZUpaNWpaRTZYVjhzNHFnUitHcXd3NllVa0x6Ti9QeGRR?=
 =?utf-8?B?MzVaL0NrQWZKWXdWR3VhdWttdGJmYjl5NmgzbXVmVXl4VGxXREMvWTZwRXFD?=
 =?utf-8?B?OG1sdGd5R1lDbFQ0UEZxM3F1WDV6NVFWL3Nldm1EQkcwSkNyNWJrekdjMVlM?=
 =?utf-8?B?dzVWZU1sMGVnd2ZsUnVFall2R0RwOUZzSXdmN1BEemN4SGFxKzNSYXQ2M28y?=
 =?utf-8?B?T3YzbWN0M3MrSTEzaXhtSmdndzBqMnNxZ3BCUk1Vckh0c3g3L0c0MDFBeDhm?=
 =?utf-8?B?Mlg5RGtxdWRRcGNxc1l2R1RxRVltY2JhTmQ3RVI2MmxDeE1pV2JTUzJXNDRT?=
 =?utf-8?B?eFRFVzdmbDh2cjJXbGZyVnZuNmFPYkZCN3lGQVArMThjOFBIL2NMRWp2NkZK?=
 =?utf-8?B?UTRmNlpkQnhuUkxRVDRCb3ZOZFFsRXlLbFErUG9GSFpZbytZcG9EQzc1RUNQ?=
 =?utf-8?B?L1NIOVFrYmx1WnBmWFNZalNEQ25RU2k5MU5aNzNBMURBTHJtSTc4bVFES0t3?=
 =?utf-8?B?SUVYOXBYMlprNHNWNkNWYmZURkxBMnVuazBvMzBuUkNlUlJqaXB6S2M3QlFo?=
 =?utf-8?B?TGYxV2N5V3lNYjNMdlRlYzdUZ0w1bk5xcklxcCtYY28xZW9uZ3FYSzNKdnJI?=
 =?utf-8?B?RXdJREtzVll0Ykk4a3JMTnJTTFVQSGJmYWtjSzJCV21IQVMzQlQydExyZ05x?=
 =?utf-8?B?YjRMRWlIR2JPUEI2VUc2MWxRTWlWU2FOL3BSSHFVdDNvTGhsZnNwVW1yUTMv?=
 =?utf-8?B?eWNGRXBqakM0d3RPanFnSkEyQ0ZseFR2SnpaWGZnKzlIeDVBSkRCV2VuU0gv?=
 =?utf-8?B?VFJWZWV4NVRxbko1Z1RLVzRDRG9xRnFzQWFKbzZUL3libEpkRGJiQjF4MDR2?=
 =?utf-8?B?cjYvSGhucHk1dk5TVFVxZDNEOFBwVmpOVlBMYUR1MWZDekNoZjd6c1pmdFpi?=
 =?utf-8?B?NWVSdG9DUmsveXhQc0RzQzZQNERzaTRPV0NYUGM5OFJpN2NRUXVFN2ZDd3NX?=
 =?utf-8?B?SkU0YWwyN2drUTRSK09TTGlrTGVrYU13WWlBRU02b0JQaXU0WmJvbUdHY2hH?=
 =?utf-8?B?eGs0Qm1jZEdPQTliL2F6QjZRMldjcGk2Zmp2S0crRms2OGhDM2lLNFFEb3pi?=
 =?utf-8?B?czBLcHQxV2cyZGZEUlFFMmNVSWlqRSt0QWQ0TGdMWjdqWnJCVkJkdndPcmc0?=
 =?utf-8?B?WUdienZkUk1mcmVpMmxJQUNsc0piRzYzR3RFSGU2a0FOa0V1b0JNMXFpSFU3?=
 =?utf-8?B?K05FcEVEM0xJVXZyTWtzaGJEaiszUGRYdVM3aFprTVE2MmgvR2tUOUI4d1R4?=
 =?utf-8?B?RTMrYTVFQ2JaZG96N1Z5TVJIc1JBcWNzYTVSRzJIaXJJemFCTmp1cmtuQTFi?=
 =?utf-8?B?QVkybW9UUkFkYnJMamd4cVRDcXRNdys3SnJMTld2cWZXSnFYQ3V5bEY3dEpu?=
 =?utf-8?B?UHhybkJuS2VIc0hYTVBrR0pFSTFTcmhRbjhEZ0lVLzlBWnMxVkVFZ0U2c2FZ?=
 =?utf-8?B?N0hLU1ZJalNiWWxOMWtXRWNBdmNKY1JVdFQyZUlmZVJNMU9xZERQODF5MS81?=
 =?utf-8?Q?zxdI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVhlandzOFMza0NtSUFTZVpMZ2Nob216WWRaaUlTN2RkVEJKMWkvUVlYa25P?=
 =?utf-8?B?c2kwNHhTbUNTZW5WaG1MYWx3RVVMMS91TkxTd2lhVThubVZoa2YxNGpCVWhB?=
 =?utf-8?B?OFpRZUQ5cFJCWmt2M1V2dUFEMHQ2ZHBRcGJhNytVNWFucnVFWE5wdUVEbTRZ?=
 =?utf-8?B?VDlrRDhGcFFBSzRCQW1EWEhwSXBXK09JRkVGWGRUNDByR2pEUUpOUnhickpy?=
 =?utf-8?B?WTFyWlByQ3dPVzNHVEJHN0Y1ZWszakQ5QTM2TERjSlZ0bHovc0wvUUFHck5r?=
 =?utf-8?B?aGRFbklCT0dkZzU5ckNOY2lpRjVGaEtXVHJieWRmVmVjY2ZKRUZCSE1VNHYz?=
 =?utf-8?B?VE5OenU1NnRZVnRCT0hBeGdhWFBPZ0M5c1lRazhuRWxSK2w1eHh4NVBxZE5v?=
 =?utf-8?B?TEt4MDhienNzdTQ0V1pqZHdXWUhaUnBac1ZnQ3NDdGcxS1ZrNVJ2ZnBiK0hG?=
 =?utf-8?B?UjB0SThXZWFpa3Jtdm9UQ2VaNDdEbVBEbzh4Q0lSZGxzcnhiQkhKVVA3akZV?=
 =?utf-8?B?V1orR0laZU42bzVwSGdpMHRwZ1kzaHRXYU14VHU4MzlFOExCR2tKa1lsL0My?=
 =?utf-8?B?WXlIVEkyM0FZYlh5NEVXR0NWYzlLQm84bVlRZFhMQVYxTTc3d01CajJoMFFL?=
 =?utf-8?B?c0UrdnEvSm0wUGFDNm1IUXFnUnFXRVY0bGVVam5zcjRHNU5QQ2k4dGlNZ2VV?=
 =?utf-8?B?WWZoZVU4QlhiUEFEeHRyZnFsOXAraG1Sd0hWRnFTRXpKNzJtcDU1KzJtSFBs?=
 =?utf-8?B?b0JGVUNCK0xPUndSRm50cm5RcUU4ZjFpWFJrV0Fid1cyY0k0ZkVTT2NiUzlH?=
 =?utf-8?B?RDRTcUU5UWJiYytSVVpOSnJpZE5ieUZWK0JlK0dNK2FUYndkOWtRYzdYYjBh?=
 =?utf-8?B?QzArQVY3RU9Sb0xGSzMwUEdaQXBZZy9DMWdGa3NCQTlyUCtPMDQ5cEJRUE5o?=
 =?utf-8?B?dWZCaUlYa1hicG0yMVpqQS9jdUc4YXA2MGtLWURRRUdnVGJlMWsxTExZeGpL?=
 =?utf-8?B?bVRLQ1dQSFNEenRHRjRoU0pndytaVUN0dFc2QjNId3VjcWtoT093YmRMV2tl?=
 =?utf-8?B?bmpseTYxZ25Iai9ETjlpME1lQ29yaVJ3ajhOdVo4ZzNXT2g1cHlMTllkRXRE?=
 =?utf-8?B?YXF4K2ZzRjh5UEFoVVNWTUpCWlhJNkliL25Vb0R0dG5haG8xcFFRVGk4SjIr?=
 =?utf-8?B?Um03a1pVaFI5UmFKWk5teTJiZWk4cUEwMnpQVjZ3cU0zckNpS2RLUGtXYXZh?=
 =?utf-8?B?SzhHTHFnSnl0QVRUQXpSUHV1KzRkdllkdmNIRHMvSUZWWDdLcjdTMEduUFNh?=
 =?utf-8?B?VE9qVDBQUUhQN3pwZ1lCN2JrZ3kxS09zZWg3OG9PUk85amxYWDUwTGVQTFF6?=
 =?utf-8?B?UStpUUVrU2JhakZyVWphTkNyeG1iazA2d09VcCt5SCtUOWNRcVVQbnhQTDQw?=
 =?utf-8?B?Q3lib2N2V2owQ2RobEhXUytLWHhjaFM3bVBUY0hZeGhyKzRPYzRlZk42L3Rt?=
 =?utf-8?B?NUdGNUtMMGlHTncvSDU0Y2x3REY0QjluMjJ5ODR2T0VCRE9xQ1VYeHBwT3VB?=
 =?utf-8?B?T1VGb0tNbTVRQTNWekEzSFVUM2t1RVBjOFJJZ3NQK1RYVDV6OWFER0RaVnAv?=
 =?utf-8?B?TVpicElXVXRMdEJWbjQwenBXazJLTDlkVHBkWTRjSjd2Z2kvQXZKd01ZWmZK?=
 =?utf-8?B?UmJ6aUdBNXBqUXRrZjRNY3lGRUdjcUQwL3d3ZW5XQ0dFdUJyRENPM2h1QWcx?=
 =?utf-8?B?aEM4Wmd2RjY5dVRFVG9nd1BKSDQ0aWhPR3FBaytqditQV3BZK3lVcnZLenlU?=
 =?utf-8?B?aWlEalRPVkZTTUdaQ2s3ZHRnVVV0MEo2dlJYMWhHQVhFYXh1V1N3T00rM2hG?=
 =?utf-8?B?aGViVTBRWFVRMWZSdGxhNGhJSHVmbDVwbUltQWJ3R3puSWptMXpDVHVUalBR?=
 =?utf-8?B?VytoYXJVZzFVZ0pTWUVhT3dJRTQ3SVFiZmhrMUlUYVBCKy9vdVBOeWp1Y3ZB?=
 =?utf-8?B?Tk45cmF1QjFDL29rd2VPZ3RQRm1rM2c0U3RLT3JVNXJtVzd6emxDM3FPS0Ro?=
 =?utf-8?B?YU1UVlVVTzhlY1JZQU1lYUVHWTFkL0gxVzU4YmJHZTlFcGxsY2dZVnlvV25u?=
 =?utf-8?B?ZGovSTRXcWtsKzJpeVlqZlljWFdBcmNRUGhNd3pmbWl2aXdCWmtnTVkvdWdE?=
 =?utf-8?B?SUxVUmh5ekFCWG52dUUxeG5hcElDQWRzWjYyemZvd1crUnVnWG4vbFBtM2sw?=
 =?utf-8?B?dlNkSmpUQ2VWaEZKbmlSSHE0ZkNRaDh6Q2xhY1Y5U1RrcVRwRUE5ZXVldWYy?=
 =?utf-8?B?bzZoMVo3Y0ExWFlNNFRtcTFlL3V3VzBLSHNlSjRJSHhkMVVIcEdOQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lc0RyC7advoYVaWZejT7POHjpbJNOet+aUqv97KDk8adCMYrH4T5NNm0AXW/qfjdcptRPZU80zgG60K20OMIDtgrMCWMXYWJugwV5w5ABfR2YE0MZy5LeJoqdmIRQD1G2fvBwSBKbni5+kpmG1E2du1gv/x90KfpHD84dHw42APQOtRiprtGwNjZhWdWQZjXrJ6pAddY1v3yi5TVt0t4xhj35oveGCCp0CiWHdNhE0rMP9bXsvRv6wXoxMJJ7uAY4d68FSDWaemN9AOiyDq0gapl3/NRqg9p2io9+hljGX31Rgq4xQC5qVFr5Yhw+rvkjV1W/sys06cP1FDhv4K3XpyOFmez4wNbfqDel/yPNIPsVukr8zqIF9WeneOzLWDnjjy9T4v3piQ3Z/Yh1GG9WWWw5VsIih25trAkAgVaLuCPNmXn1nbn6Ce2zpj3pP2PIkSWMcqyM4Z2Dso5Ci8uZXuaIfQGeTFF8RjiC9B3s1GvoamIAK9nV7NC0IS5wD74OF56C7Yr2rXbhSEfr9gWltPfyIsWeknHgpKDbOUUW0fFo2CZiqz17qje/NmPcj6308QaWUTVXmElDkml4zkhHNSxEyrQjhGpvefrAFrVedI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d03e6c-0420-48a9-8465-08de59e31e7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 18:21:53.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmKB8RFlP0Fg5cmje5cBhg4LhAO7BHs9CmkUnO8DUWmzxBeH0CNcKC/nLLGE/yERamM++ODz5sBe7V9R3S9AWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220140
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=69726acd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=bolsTcwhKpvlXRM6xEUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YBLJ-0o9TdDG4WWpUVL7J1JscvL8U5-w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0MCBTYWx0ZWRfX2jz3upMKCpH1
 XR7f6Tw4OHdeu1j9LTnZ3ix5RxrmiS3QoHm/j2KwgpQUbG0noYYx5zqWkCxc9X4XPgmtOhClvU+
 SHTdEJMLQyO8PgEql5X67nFWkrHPGH6K+/dXrvVbSPoMQMuRL4PKYS9dBcvQO3nYRXT8wt0OvDc
 cKDvnH9jHAgRTpAJ4CNgukMdQFqbB5luTJ4EAauMJdPW/GxI6JGUg8zuIzDkzZteiNRW5YROjK+
 9esPiwIA/CvaqUeN5qtxx5jx3GfwKAL0fDltrj+QB7wfR7kn/4IqCLnRHO8W5is6d39hl9ZARqR
 vxHMGFBXKB5omXeJpuaWi/LTdigFDhy2fE57O7bZD1CwqFx79AJCuSlQkWGKhvXz0TnpLiwWfhX
 F9FNhLLx8VgBVqlcA/WIXm9dczitWh9D0aMUuMMzlQ2Q/fIhg2oqS7sTgzP+Paja+RrAQdQ69q5
 6Teyx8Ue8ECIrzF792g==
X-Proofpoint-GUID: YBLJ-0o9TdDG4WWpUVL7J1JscvL8U5-w

On 20/01/2026 17:53, Yonghong Song wrote:
> 
> 
> On 1/13/26 5:13 AM, Alan Maguire wrote:
>> Currently we collate function information by name and add functions
>> provided there are no inconsistencies across various representations.
>>
>> For true_signature support - where we wish to add the real signature
>> of a function even if it differs from source level - we need to do
>> a few things:
>>
>> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
>>     we can do this via the address associated with the function.
>>     In doing this, we can then be confident that the debug info
>>     for foo.isra.0 is the right info for the function at that
>>     address.
>>
>> 2. When adding saved functions we need to look for such cases
>>     and provided they do not violate other constraints around BTF
>>     representation - unexpected reg usage for function, uncertain
>>     parameter location or ambiguous address - we add them with
>>     their "."-suffixed name.  The latter can be used as a signal
>>     that the function is transformed from the original.
>>
>> Doing this adds 500 functions to BTF.  These are traceable with
>> their "."-suffix names and because we have excluded ambiguous
>> address cases we know exactly which function address they refer
>> to.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>   btf_encoder.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>   dwarves.h     |  1 +
>>   pahole.c      |  1 +
>>   3 files changed, 68 insertions(+), 7 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 5bc61cb..01fd469 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
>>       int16_t component_idx;
>>   };
>>   +struct elf_function_sym {
>> +    const char *name;
>> +    uint64_t addr;
>> +};
>> +
>>   /* state used to do later encoding of saved functions */
>>   struct btf_encoder_func_state {
>>       struct elf_function *elf;
>> +    struct elf_function_sym *sym;
>> +    uint64_t addr;
>>       uint32_t type_id_off;
>>       uint16_t nr_parms;
>>       uint16_t nr_annots;
>> @@ -94,11 +101,6 @@ struct btf_encoder_func_state {
>>       struct btf_encoder_func_annot *annots;
>>   };
>>   -struct elf_function_sym {
>> -    const char *name;
>> -    uint64_t addr;
>> -};
>> -
>>   struct elf_function {
>>       char        *name;
>>       struct elf_function_sym *syms;
>> @@ -145,7 +147,8 @@ struct btf_encoder {
>>                 skip_encoding_decl_tag,
>>                 tag_kfuncs,
>>                 gen_distilled_base,
>> -              encode_attributes;
>> +              encode_attributes,
>> +              true_signature;
>>       uint32_t      array_index_id;
>>       struct elf_secinfo *secinfo;
>>       size_t             seccnt;
>> @@ -1271,14 +1274,34 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>               goto out;
>>           }
>>       }
>> +    if (encoder->true_signature && fn->lexblock.ip.addr) {
>> +        int i;
>> +
>> +        for (i = 0; i < func->sym_cnt; i++) {
>> +            if (fn->lexblock.ip.addr != func->syms[i].addr)
>> +                continue;
>> +            /* Only need to record address for '.'-suffixed
>> +             * functions, since we only currently need true
>> +             * signatures for them.
>> +             */
>> +            if (!strchr(func->syms[i].name, '.'))
>> +                continue;
>> +            state->sym = &func->syms[i];
>> +            break;
>> +        }
>> +    }
>>       state->inconsistent_proto = ftype->inconsistent_proto;
>>       state->unexpected_reg = ftype->unexpected_reg;
>>       state->optimized_parms = ftype->optimized_parms;
>>       state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>>       state->reordered_parm = ftype->reordered_parm;
>>       ftype__for_each_parameter(ftype, param) {
>> -        const char *name = parameter__name(param) ?: "";
>> +        const char *name;
>>   +        /* No location info + reordered means optimized out. */
>> +        if (ftype->reordered_parm && !param->has_loc)
>> +            continue;
>> +        name = parameter__name(param) ?: "";
>>           str_off = btf__add_str(btf, name);
>>           if (str_off < 0) {
>>               err = str_off;
>> @@ -1367,6 +1390,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>         btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
>>       name = func->name;
>> +    if (encoder->true_signature && state->sym)
>> +        name = state->sym->name;
>> +
>>       if (btf_fnproto_id >= 0)
>>           btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>>                                 name, false);
>> @@ -1509,6 +1535,38 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>           while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
>>               j++;
>>   +        /* Add true signatures for case where we have an exact
>> +         * symbol match by address from DWARF->ELF and have a
>> +         * "." suffixed name.
>> +         */
>> +        if (encoder->true_signature) {
>> +            int k;
>> +
>> +            for (k = i; k < nr_saved_fns; k++) {
>> +                struct btf_encoder_func_state *true_state = &saved_fns[k];
>> +
>> +                if (state->elf != true_state->elf)
>> +                    break;
>> +                if (!true_state->sym)
>> +                    continue;
>> +                /* Unexpected reg, uncertain parm loc and
>> +                 * ambiguous address mean we cannot trust fentry.
>> +                 */
>> +                if (true_state->unexpected_reg ||
>> +                    true_state->uncertain_parm_loc ||
>> +                    true_state->ambiguous_addr)
>> +                    continue;
>> +                err = btf_encoder__add_func(encoder, true_state);
>> +                if (err < 0)
>> +                    goto out;
>> +                break;
>> +            }
>> +        }
>> +
>> +        /* True symbol that was handled above; skip. */
>> +        if (state->sym)
>> +            continue;
> 
> I did an experiment with the following code:
> 
> $ cat test.c
> struct t { int a; };
> __attribute__((noinline)) char *tar(struct t *a, struct t *d) { if (a->a == d->a) return (char *)10; else return (char *)0; }
> __attribute__((noinline)) static char * foo(struct t *a, int b, struct t *d)
> {
>   return tar(a, d);
> }
> __attribute__((noinline)) char *bar(struct t *a, struct t *d)
> {
>   return foo(a, 1, d);
> }
> 
> struct t p1, p2;
> int main() {
>   return !!bar(&p1, &p2);
> }
> 
> and compiled with gcc11:
> $ gcc -O2 -g test.c
> 
> I hacked btf_encoder.c with true_signature is all on and with
> $ pahole -JV ./a.out
> ...
> btf_encoder__new: './a.out' doesn't have '.data..percpu' section
> File ./a.out:
> [1] STRUCT t size=4
>         a type_id=2 bits_offset=0
> [2] INT int size=4 nr_bits=32 encoding=SIGNED
> [3] PTR (anon) type_id=4
> [4] INT char size=1 nr_bits=8 encoding=SIGNED
> [5] PTR (anon) type_id=1
> search cu 'test.c' for percpu global variables.
> [6] FUNC_PROTO (anon) return=3 args=(5 a, 5 d)
> [7] FUNC bar type_id=6
> [8] FUNC_PROTO (anon) return=3 args=(5 a, 5 d, vararg)
> [9] FUNC foo.constprop.0 type_id=8
> foo : skipping BTF encoding of function due to reordered parameters
> [10] FUNC_PROTO (anon) return=2 args=(void)
> [11] FUNC main type_id=10
> [12] FUNC_PROTO (anon) return=3 args=(5 a, 5 d)
> [13] FUNC tar type_id=12
> 
> There are two issues.
> 
> First in btf_encoder__add_saved_funcs(), it is possible below
> +        /* True symbol that was handled above; skip. */
> +        if (state->sym)
> +            continue;
> state->sym is false.
> But one of true_state->sym in the above loop could be true.
> So if btf_encoder__add_func(encoder, true_state) is successful,
> we should continue in the above regardless state->sym null or not.
> This will remove the warning:
>   foo : skipping BTF encoding of function due to reordered parameters
> 

thanks, will fix this.

> Second, we have foo.constprop.0 func proto encoding:
>   [8] FUNC_PROTO (anon) return=3 args=(5 a, 5 d, vararg)
> The last argument 'vararg' should not be there since the
> optimized out argument is already gone.
>

The problem here was both 

1. we weren't dealing with const values; and
2. when a parameter was marked optimized we weren't reducing the number
of params, so ended up with an extra 0-type param on the end,
resembling a vararg.

Fixing both of these we get:

$ pahole -J --verbose --btf_features=+true_signature a.out 
btf_encoder__new: 'a.out' doesn't have '.data..percpu' section
File a.out:
[1] STRUCT t size=4
	a type_id=2 bits_offset=0
[2] INT int size=4 nr_bits=32 encoding=SIGNED
[3] PTR (anon) type_id=4
[4] INT char size=1 nr_bits=8 encoding=SIGNED
[5] PTR (anon) type_id=1
search cu 'true_test.c' for percpu global variables.
[6] FUNC_PROTO (anon) return=3 args=(5 a, 5 d)
[7] FUNC bar type_id=6
[8] FUNC_PROTO (anon) return=3 args=(5 a, 5 d)
[9] FUNC foo.constprop.0 type_id=8
[10] FUNC_PROTO (anon) return=2 args=(void)
[11] FUNC main type_id=10
[12] FUNC_PROTO (anon) return=3 args=(5 a, 5 d)
[13] FUNC tar type_id=12

...which I _think_ is right.

I'll retest and respin; was wondering if it'd be okay to incorporate
the above into a selftest, as it's really useful? Thanks!

Alan

