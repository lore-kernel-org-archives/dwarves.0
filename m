Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856291339B1;
	Mon, 30 Mar 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864598; cv=fail; b=Ax7qnuTBgKuaFljWAIeeWpvWYENrfMu+JC4y1b+HzzY+A+oRb4L0F2j++KVSRXg+nXpbyVZptcGX7xIDt+T17O3lhc8w1BN/WDrKVYzTv57z57f0tMAbHMBakF1uo1h39taA/x1sSfPOgrFOYDMF0W+4ahof4nseNnwHEXUJTlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864598; c=relaxed/simple;
	bh=pQHTE1bir1l3DhBgSd5AzO/6AMu4co/mTxS48FMp70M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E9um16TZJ8lGBSACFtg86PU+18L0FmI3SDNoVvcGEr2mGSSgKj613toFpMQcESROpVIgTr68jjTgwgRD9aSitUpk1ShNkecyxJtj4lYGQA/YKxBECbiIXYd2Z0vo3mwc5fneLn2LCk5DPhQTI0v+8DbkBpFddE74yh6zIJAzpEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p+5uHbX1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RdZUM4eb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p+5uHbX1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RdZUM4eb"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U1bDGb633172;
	Mon, 30 Mar 2026 09:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oYCXGRWbUoElZ5rJftSryDFLF7dTdfXyKvPfRh2mYXc=; b=
	p+5uHbX1JZG8OEfTEwdAZXsi9qEMvGjIS8zoBaJvQpoBpKeLnfLiwriAukNnPJGG
	667ZXfZKYyzvKYaKc7SuQUX78EebEH5Ja/dj4zbXM2k/SVE5DDOoK1efjcG9wSP4
	Vk2DSa1jiNgaRPMTxNBtKmeWItUos7NB9E5uqUqnbFQXpvwMXYDMeEylvAXJSGXJ
	YEXnlKdC8D/aECWLc5FwGfI4yWgs3siRi9GiieA4xblLS5B2MUIuX3Mt8nxRYIEd
	0z4eUMZAhOkx1ZH8xHrNxxtQQjixVcmMl44WYbiQ0wqWaEeanWUvAwbQO7PcaEu7
	MZtX2EN375Da7ZmiyPMJug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d67hq9tbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 09:56:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62U92YMa036474;
	Mon, 30 Mar 2026 09:56:17 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65eetrtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 09:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs792jrVjxOLtwVbvKiitFvRY93abC9TokUd3HbNQ6FeS5MOPwiObIYfKxXfHv/fAX8re0CS3dazMNq9ZGzZZtJWv2xnkdywC8oIHtERG0yEKJGtC6cORwLw0g2ET2e011YhgGW1Pi6JVAW9ONAwI+xlm54wW947iOcVp9kl0uvd1sq3eee954G37msYT1n/sPKvYV/xneTYASIO7aHiWa2uqk2vnng9lDtgRxjV/qAnTEf/V2bz/CtFQttjjOua+DKljs73rdYX05pm2DhQNC9MeJyVFu7XV5zvYREbkfqZKCQijooEMvffweZAWSwNWSHOP3uduP/9wxoVGc/i+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYCXGRWbUoElZ5rJftSryDFLF7dTdfXyKvPfRh2mYXc=;
 b=cJt9HOBsqcetDsR6W2QgFq0HHLBS0hoDlA/Mz1etbuh01V1YD4qNdbNtyV9pzYOF4e/HtsOztZMQ1t6vYGbZ6PWvVbX0rTk70eMkgZVsWU6j9P9adz4gULprTnkzH4pbn0cb0/8Pw1VCTLIEu0j8XPFGzesKvhVjymtGK/gH2OdeVVzE0pBuF5xawKyiMAXgL4ZKVimvmdRVsSLsv1J53TBoStOcEPWKkRK6TI+K1uhG/fgu7yuR0ecXyiQlYTJXLfJPvN4n8Kae+O3lUPIaG2MLlWc4+SMWgehg7WfbnBKpFrvIie50/oSJIfD/3sXveo7NI4n+nyw2Uz2ZhO7Tig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYCXGRWbUoElZ5rJftSryDFLF7dTdfXyKvPfRh2mYXc=;
 b=RdZUM4eb+ln7h8bA8Hh945WEP5nD/7GL27/WYcE86BkMpPIPUjn4QFP9lzgMTfHJddIY5WYnMvPCAxuOvGoMaofC2KbqKQygi2p+2qVyjpDCI/Bws3C0+K4J/C/vje9q7NaC/CGqPCUkXWLJuhbuD9vYLR5QbZjcOpQoRy9diPo=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS4PR10MB997644.namprd10.prod.outlook.com (2603:10b6:8:319::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 09:56:15 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 09:56:15 +0000
Message-ID: <908e71c9-42d2-43ab-9e1b-6111a5e62488@oracle.com>
Date: Mon, 30 Mar 2026 10:56:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 00/11] pahole: Encode true signatures in kernel
 BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
 <c2143369-7b31-45d2-9c34-ae311582e074@oracle.com>
 <8424ac77-a469-4064-bfca-542d671d5ea6@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <8424ac77-a469-4064-bfca-542d671d5ea6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS4PR10MB997644:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bed2fd-c030-40c9-fc0a-08de8e4294ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	snZ/zl8E1ptl5TASvOBv/v14fTko8WVFpTqS8NPzMRuwEkPgc41ByrYy6zbXzTGds6byleN9exPZV9VWxuyJfTEEzagZsParvlOyNwQkq+fu2RBNtCtM/XVvrzg60fL32yZZQNBCGtviOdIOPu8q+iAMJSDxBgJcrO/oh3VikMFjEzw5exIqEEMLAM8RLtYodjaiJknN2bMgtejTYDfnLyL6hU+/L/Vhbk+hWPsJy+zatvzCrKD+tM9kxdvmcwdUwfYZjCueTksMPkmDP3bDSoIklgc4ume392/qEtDfZYE7oQMhtThcgNSOnmkhNrsDI5Zy8yjxXxI2fQgzSJwnTcA0DlxyDqQDnfV9pA7VuO2a0I+DqbWVHEsKgQU4ub5bEPYsBeJ1/gLL0ED6EMKZfL70CLQl+O5zYQq9kwB0Oewe8avBTnoeSpgwnC/IcPCU6CP3O4xx6xaDF6Me7HjzyMtwJmTTVXfgrF2rdJfDMP/1eFAnn/8a811F0XT5WywD1KjP/b9lIVVt5vRc/WDapPy5jIVUsr7xWAMf1oF3Ozbllsr8K5xlEvAtL6Kwhkd5u5dvBTgOpYHpBrzO7c9yIMc5B825hUVzC3vaHQssWWxqVYzhBCIX5mAoSm9dT6Hn5l8ow3UK7uuJbKNqdGC+qih1/frk9N50/8mO2Pl9aeLfRvPGUGPPwz0sECgD87DHDxwvjb8fVm5jYUmD8RmQqB+TRPOtINoW4Ad+uvP1OlA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L21yRWlQa2pOczdjZjNXU2RPd0lnM2twSGdQQTl3VmtzR2hUOE1iSE5DbzI3?=
 =?utf-8?B?V0JzSXVYTHhRSUZ2Y2xGTm8vZVV4V200WUFwQlZqZm43NkNWb25vajg1SmZH?=
 =?utf-8?B?R2pCM2I5RU5aMzUrdDFaQU05NnJrNEIzZFF4dStGaGY3STBJdXVCT1NjTzg2?=
 =?utf-8?B?TjF2VkMxSmRJbzdOdVBCZjFBZFhMbnlJMjRoUFpKTDZ5aEplOWt2SXpCYWNT?=
 =?utf-8?B?RTVPd2FFbC9Kem9UcVg5UXF6Vk9TYXJnbVFoMkRzTVhkL082TnIrWXJHcEl0?=
 =?utf-8?B?Y0hZR0x0Uk1QZlZCNGgzejJnZlpzVEd1V29LTmMyU0xOQWYwcVA4N0RjS2Nk?=
 =?utf-8?B?eXQ2emd6QmdzeVJuSmt3NDIxQXJIZDZNeDcwaEZXa3p1VCtIRDNJWUZGd01K?=
 =?utf-8?B?cTZxK3pYeVpEbXFyQlRROU5FcEV1ZG9kcjBPbUo1THA1MDhXQXFzKzh0dWM5?=
 =?utf-8?B?RHR4RHphVllSR3gxQUZ3RXZ6MHV2TXk5dnhiYzF3eG9uaFdPcDFqdXhpc1ZQ?=
 =?utf-8?B?SFFvSnlSNVBsem9pbTRjdDVlWUl2U0lUMWVFb1hXZ2NKWDllQkNYWUl2NVJr?=
 =?utf-8?B?SjhOM1BTc3BkRWVqWE9GZ3NKTlVEbkRzZkFEMHFGajhJNmNPaVRZd3NUSG83?=
 =?utf-8?B?U1ZPN2pXbzZCNXl4MGdaNjROWkw5TVRJaGtkcUk0VlRUVmpUMTIvTjE3VVZj?=
 =?utf-8?B?U3RUMUIvZk1qNXdqaGgrc2I2aVh2NTh3QkxtWnhlSTA0cUk1K0lJajN6ODFX?=
 =?utf-8?B?NVI1VUZVOUs5VDN6UzBIVXRIMS9FeVNMSHJadllkaU1qSk5UcXhyVUVmRnVC?=
 =?utf-8?B?WGhPV0NsRUY1TDFmWWc5ZStGWXZrOUlvUXdabjhXMnBGaU02TnBtZzZnZHph?=
 =?utf-8?B?ZXgrYXpWSERnenpZMmdxOERYWlpYSUxYblg2b083MGRUK09ZSm8zdFN2cFM2?=
 =?utf-8?B?WkRIZWdndEZ2L1Ird3NHbStjSkJhVUp4VXQ5YllpM3ZFWDFwcjI0SUR2d2w2?=
 =?utf-8?B?OCtwV2hDb3ZtWEdRejlqZmpjdWlXQXBGWlE4b2hiblA3Qms1NTZlWkM4TG9o?=
 =?utf-8?B?QWFLSExFM3lqbjZMRStGUjN0MGxNb2pGS1VDSmdqNENvbTlwR3J4R3g0d2wy?=
 =?utf-8?B?S3N3Um5mOTRkYTU4dUtvVUhvMHJxUE00aVNGQzdMbzVQU00waHQ1enB5VWdk?=
 =?utf-8?B?YXZyRnBFNWlWQk5GZVBzb3IvOXpRbXJiQzNTVXJRTFFaYytodGdtVU1DcHBL?=
 =?utf-8?B?ZzhKSjI2a3JWTFU1WFRBOTlDY1JHWWtaTW5SYm9qT0wzMG9CSnMvbmFuNVVw?=
 =?utf-8?B?ZXBIbzZzOXhFcitIT1ZLT2l6YVFjb0lRYTh1V3NPRlBSaGwzZmpES0dLYWZZ?=
 =?utf-8?B?R2x4YVRSSXV0aFFOWlpnT1V3WXZRTFJLY1ZkR1RIY2tCMWZBVmhOWXJJYi9i?=
 =?utf-8?B?cTBERTM4VWZUaU1nRFF4cXRoU1R3WEcwOHE0NDZSUU9VVWdHa2JQTExPVkkr?=
 =?utf-8?B?cmJJa2Z2WnpNR2RWV2I2SUQ0b1N2NVdmcHdQdFJBYkYzdmY1UlpMU3ZDc0lC?=
 =?utf-8?B?cXBUMUZJY0YzUXUwRWk1UW8wVklqczU4aUJrZnU1ejJlR2wzTXZpZ1FEa3Bx?=
 =?utf-8?B?OHBpTkxUQTcwUW5QQjFIZW9aTmVTdjhYUlhyMGdwNlAxN1hwODU5Tis2SGZR?=
 =?utf-8?B?RHJaR2ZqOEhFNDgvMkllUUF1VHZnS1BwQnZteEhTK1Yrck9kY3RVWnYxQVdZ?=
 =?utf-8?B?MDdiWjRRZkFLTjNBL0dVWUdtbTdIY2tzV1VSaGJEaCtia3lSVmF5T3dLZjdq?=
 =?utf-8?B?a1hPbitnQnZBaFVlMnYwMjJDYm5YREprSEtzNEhrb3k4ZzArd3lSc1k3RjVR?=
 =?utf-8?B?cU92V3BuTXhZUVZEQnFZbDNobStuUnpIM2hjS2JJa2thdzluNmFSWmwrMUw0?=
 =?utf-8?B?bG83MURVK3BFaTdiMXhKSWp1dVgwaTdJYldBSEVTQ01QQzRxcHRoTmc4YXQ5?=
 =?utf-8?B?ZFp1VllMOW1GQk50Q0pzdXFIVGtvc1pMMUVTN3gvbkVzeFowc3ExbmE5d3JH?=
 =?utf-8?B?c093QWxDL2FsUFBtRU0yRGpJVkxta0RRakQvb3hvMGJxK0FSZDZIblhMaWgv?=
 =?utf-8?B?WDc3M0lHYzlNazhqOTVVejhidWdCUHhwRHJ2MFRwYmZiL2JwTXZDR2sxOGJE?=
 =?utf-8?B?SDk2ZUFMQ2ZkL3BVU0NhS214LytGQmZ0OTR5WFZsbnd2dmhkTGRLaFhyQUIx?=
 =?utf-8?B?QmZDVXA3TjNVQVV0Wm1MeERTcU5sckhwalNSVDZ1dkxycFpQZ1hoaGY5T3Z4?=
 =?utf-8?B?dEViK1EwcStZeW5PVWpRakRmYVR5eDR1WnFISlJKZ3RVdTVzVkZrdz09?=
X-Exchange-RoutingPolicyChecked:
	GL8XNRQ+t8YbZS8B/iQq7fYQ0y8pcFzMnSMV0hWz4xW6+WNv9/are4/VuboKfVT6Fo9UiXi8r+lb2j65tq75EPI9HQ4mv7sL08Or5jqwhvY0SN/xYiJFS7Zo3Kg+Z2cRT1ak7Ao598hKHTOjjzS/uF6qhvhzaEBAjHEW3Da5PnjBeXh+3/RJKLG+5pH4z3v2gZhv03ZbIZIiXWATzSetnSt+jTixHDUYOZpCXhBMPFLpTT6AU8Ay2iY9Vwikjd0F9LAJhWY+8y5H+0ejeEOrJl6ANphvZ9cj8vgnbN7iRwaV4ZNEzUhhHgHc2jtYxiGmmqNpnExtEUHQ27gcgP4KAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H9AyIpfj/iHuo/UPRxdrSVf7OO6G24Vpad6XHwB+aWz9PrqbkV8DDHRwR0fhXBO352NNJFFm+WIM1AoxG3di7aeG7sd+h20If4HG3mLQd7fwq1ejjN1U0kysmKDjWfoO68VmBhogMtwJ+ssSwAGI/2XXm7kBw5nAAHjK+1pKdBrK7amWF+0YHBTiX1OoHNR3azTv5lU9f7tL8hPFvfuv0RZnUhrRqHVfyB5+MIg0dMiqqq/lQoVhvwlnMavkgLgDuKaDPHWnZkgtKPgSKXNA+3EgqknGpfPd83r+3tjVWW7G3OMcfA1Of7Th/QilVJ6JFSfzfydMuDj7AXC0NVaPp7f2hFoEJUOVxE42Rpbl7dlhiTAXWiCRWHG6lInavzMCO2g6RjOctjqQLr48gtFEtqe8j1BN2OFLVugAnZ36NSuimPH0afWoUOCaLvLo/FQyQW3x1DBt1odt3Z9OwtyOy3P3HjztnP7CLzCKaMm7ZtL4IXGGKoAlOZVA7WNCMS+6My/W+QsTRbTKGXATI/nteZxKCqzacBeLb2/zD2xHrLEree4YwCm8U9tq6SmPSRaE76MorowJOwTtFsJ+266tWo1U0G56aykuoDd9Bsk89eA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bed2fd-c030-40c9-fc0a-08de8e4294ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:56:15.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFnOTsr7YZWtN2hfpecfF11XBFJ3O+dUeyX5YYHrSRD2F0jgA58gr+/YFm+I2iJRq6sv4IO7AriXzZSa2rvLcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603300077
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=69ca48c2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=NEAV23lmAAAA:8
 a=FMeiI-8lGC5hG4MUdM0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12276
X-Proofpoint-ORIG-GUID: BToYoUer4hbHx-DXCMVY-08dvOkgyafc
X-Proofpoint-GUID: BToYoUer4hbHx-DXCMVY-08dvOkgyafc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3NyBTYWx0ZWRfX4RDPlmFJd6Q2
 0vJoMpOEsoYELqa+HX1Yx3iw+7pfuI5qHb+duO6jr6unT51mLHQLikVcgV9d8qa1ZXyjwgiT14k
 bLZoKCTLiZpmkvG4Xn5wr3rj9kdc4I39ckYYWdUyc1z2G/SgYZokOLUPDqiDARwaal7jpcA8fU8
 4d9MJtkj1BYbJL6K2+eN0jdCavxIoq5vKvYxEt4jMjlRGdWUpDtC9AL7Z6hpFb+6bGSdL8FWP3+
 eIHQw93wi1UscIhJonMF95av54chjTAWs8WJxjxDjcTWtSLL353NKR5E0rIBRG1hSZWtoSUjhiE
 G2kpbQ9yy7T2HdyWzECQcnbZ7Osq2hw8Tw997iXIeiNDD+J/LivBVuWkJ5FfJM/uv7NYO4GuvD2
 ZwC0pugHCMkXsdSHkTS/lfZylOGiLiHg04Y9vY+0+djxoxbXb0/xm8G1lBYw/bcF+fu9XhVbr2V
 Wwl5dnKOe2sOCUeH10/WrSvOGr+LhR+o+zZV5RtY=

On 27/03/2026 19:38, Yonghong Song wrote:
> 
> 
> On 3/27/26 9:02 AM, Alan Maguire wrote:
>> On 26/03/2026 01:31, Yonghong Song wrote:
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
>>> to ensure true signatures are properly represented. Eventually, only 18 functions
>>> cannot have true signatures due to locations.
>>>
>>> For arm64, there are 863 kernel functions having signature changed, and
>>> 70 functions cannot have true signatures due to locations. I checked those
>>> functions and look like llvm arm64 backend more relaxed to compute parameter
>>> values.
>>>
>>> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>>>    -pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
>>>    +pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes --btf_features=+true_signature
>>>
>>> For the patch set, Patch 1 introduced usage of DW_AT_calling_convention, which
>>> can precisely identify which function has signature changed. This can filter
>>> majority of functions where their signature won't change. Patch 2 did a prescan
>>> of parameter registers to accommodate some cases where the optimization could
>>> happen but didn't. Patches 3 to 9 tried to find functions with true signature.
>>> Patch 10 enables to btf encoder to properly generate BTF.
>>> Patch 11 includes a few tests.
>>>
>> I'm looking through this now, but FYI the test run with clang kernel build
>> is passing now, great work! The log [1] shows 23 additional functions for
>> clang kernel builds (see the "Compare functiokns generated" step). Interestingly
>> it shows a few additional functions for x86_64 too, I suspect a side effect of
>> better handling of parameter location info, but I need to confirm:
>>
>> ### Compare vmlinux BTF functions generated with this change vs baseline (none means no differences).
>> 1345a1346
>>> void __do_notify(struct mqueue_inode_info * info);
>

Apologies; I said x86_64 above where I should have said gcc+x86_64; the list of extra functions
I pasted into the message was for gcc specifically.
 
> It would be great if both this change and baseline are showed. For example, for this __do_notify() function.
> The kernel source:

In such cases, the functions are not present in the baseline. The aim of the compare functions step
is to show the set of added/removed functions, observing the effects of a pahole change on the list of 
encoded functions.

I would like us to get to the point we can use pfunct to print detailed info about a function;
various representations, inlined at specific addresses etc but we don't have that yet.

>   static void __do_notify(struct mqueue_inode_info *info) { ... }
> 
> The dwarf generated by clang23 build:
> 
> 0x04442f84:   DW_TAG_subprogram
>                 DW_AT_low_pc    (0xffffffff82409720)
>                 DW_AT_high_pc   (0xffffffff82409db7)
>                 DW_AT_frame_base        (DW_OP_call_frame_cfa, DW_OP_consts -128, DW_OP_plus)
>                 DW_AT_call_all_calls    (true)
>                 DW_AT_name      ("__do_notify")
>                 DW_AT_decl_file ("/home/yhs/work/bpf-next/ipc/mqueue.c")
>                 DW_AT_decl_line (777)
>                 DW_AT_prototyped        (true)
>                     0x04442f98:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x19d) loclist = 0x00c7000c:
>                      [0xffffffff82409725, 0xffffffff82409763): DW_OP_reg5 RDI
>                      [0xffffffff82409763, 0xffffffff82409ac6): DW_OP_reg3 RBX
>                      [0xffffffff82409ac6, 0xffffffff82409b01): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff82409b01, 0xffffffff82409cdf): DW_OP_reg3 RBX
>                      [0xffffffff82409cdf, 0xffffffff82409ce4): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff82409ce4, 0xffffffff82409db7): DW_OP_reg3 RBX)
>                   DW_AT_name    ("info")
>                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/ipc/mqueue.c")
>                   DW_AT_decl_line       (777)
>                   DW_AT_type    (0x0443d068 "mqueue_inode_info *")
> 
> The function __do_notify() does not have nocall attribute so the signature should
> be preserved as the original.
> 
>> 4994a4996
>>> int __vxlan_fdb_delete(struct vxlan_dev * vxlan, const unsigned char  * addr, union vxlan_addr ip, __be16 port, __be32 src_vni, __be32 vni, u32 ifindex, bool swdev_notify);
> 
> __vxlan_fdb_delete is a global function. See the signature:
> 
> int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
>                        const unsigned char *addr, union vxlan_addr ip,
>                        __be16 port, __be32 src_vni, __be32 vni,
>                        u32 ifindex, bool swdev_notify)
> { ... }
> 
> and dwarf
> 
> 0x06c44a41:   DW_TAG_subprogram
>                 DW_AT_low_pc    (0xffffffff82fa0aa0)
>                 DW_AT_high_pc   (0xffffffff82fa0f9a)
>                 DW_AT_frame_base        (DW_OP_reg7 RSP)
>                 DW_AT_call_all_calls    (true)
>                 DW_AT_name      ("__vxlan_fdb_delete")
>                 DW_AT_decl_file ("/home/yhs/work/bpf-next/drivers/net/vxlan/vxlan_core.c")
>                 DW_AT_decl_line (1273)
>                 DW_AT_prototyped        (true)
>                 DW_AT_type      (0x06c21271 "int")
>                 DW_AT_external  (true)
> 
> So there should have no difference. Again, it would be great to show both base and this patch set.
> 
>> 15185a15188
>>> int devlink_nl_param_value_put(struct sk_buff * msg, enum devlink_param_type type, int nla_type, union devlink_param_value val, bool flag_as_u8);
>> 18862a18866
>>> struct cpio_data find_microcode_in_initrd(const char  * path);
>> 48240a48245
>>> struct dst_entry * xfrm6_dst_lookup(const struct xfrm_dst_lookup_params  * params);
>> I'll push the CI change to enable clang builds so we have it by default from now on.
>>
>> [1] https://github.com/alan-maguire/dwarves/actions/runs/23638670169
>>   
> 
> Sounds good. Thanks!
> 

