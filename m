Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB038F23F
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115722; cv=fail; b=oIWXCqbNOmQbUBUrwq+F4lugxWfhyN6TWBeT0iYXF33p9DdazKv4zt9X54cfoSs9n2GmXpVjpgAZ+OeQCkIa6UT9TwVAm0d0CqqAFRl9e9crMmZATSNTYeRVtA8+cKD2jFdd9P9mFz9aejE5UT9AXsUNG6UtyKcneop05kdtDf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115722; c=relaxed/simple;
	bh=zisIGVgJyDxm4eCuuFVgYMEP0B1WT+Bq8xwfChSsfbk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FFW6pvbAZirjwA9iU5aKh2ogTN9b0i9bzlwrKQJOarIBj3wpAzPT6xWPI+H7sEqA64A8uzmHvBq+6ir9wfEWwrQRRsOA3KcbFf9RS4KKW8EKEXK40hsD9x3ybTTZ9SeRusbGd5QercpeZqtx0+r1La2Vrj4m1vx6359bvi168vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e4dSY5+m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jx3KE0yE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e4dSY5+m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jx3KE0yE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M19BuS442215;
	Mon, 22 Jun 2026 08:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jIWQIRjeXGEWGCmcpeUyYFf8CZapjhdGs1/1g3ZnDxA=; b=
	e4dSY5+mDSFCCQ4vXpl2qxfQmm282UuTkit3FXC5FIeonHsozH2Bnwmgs7WyOWxv
	o++kR+CfoBZ1TXvmFpbZV/hUJTIjIOXeLp8ICBsHNm+tANx3SqHzVxPtf39XY1eZ
	ovnjutOek78czy3Mru8epJAm+iO4rrM02hHQlq7UZ1WkxVE+Gf15NbKalB9i2nzy
	cyj1/RpBbZnnr9AKOl3/rKUwtzaEsNI2bwVUBt6MDej1+jB/bbpI+IYLyFhrnKZg
	hXvH5T1vcWNgSUj51gwnV/QJcoaYBVeX5Y/DGBe7gLqoLSTAh5TZa2QlUgh4qun+
	BPFOktrLZQIKMOYbkiKvdw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewh9c1grm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 08:08:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65M88WGn023099;
	Mon, 22 Jun 2026 08:08:38 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhandm5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 08:08:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOXUgTqgGA/H8e/xd6gzvneFHDh1/ueIfVs0reI9Bo12/OYbNvX3+liphrc4h3nwaOlBGy4/uV3vbnDlyVZFwDLM9EpbHHK/BC7vxa4+T2sezM1A68No0FJWs0bWE3T29Zz+PI/BCNfzN1PIQueZV/8tAQUt/ymR/J5qvbMDqdVioND2Hh4WgerxXXU55iV4a9pbUjozidodH18qmpd+0/eiwF0ktpTpes+ylIRgyKOITitJLmu61FqigZT67mBVLzl9GbemKaKCw9bJU6XUq+eBgAeoGOWVxE6RXwUelETSrTtV23AHzu0mVhfhZu+fK2bkztMLxDtGrzQuRR592w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIWQIRjeXGEWGCmcpeUyYFf8CZapjhdGs1/1g3ZnDxA=;
 b=rtmqtWVLG4l9HwJKtxBhlISfIpugWRzgXPbA8653e5MovdxFRU8sH5yciSJDn5tzuNMlNqlTOSCXkWe3oEohjXgMykCRLOPX6pVfaHdDuyRcY4Y80FaMUz4ELuAGyvY+F/UEpNCPtEg85Ovwr+FHLrKUpUneQLfNanIcSXLP5QcMLamKW8suxRI4dj1lXzsOlXTYzSSCGpn+vFTi1JXi3lT8UQJa2B0fpfEdV2pQKyi1c3wH8BFu51x8I2QV12j7THGNKO2Eh5IeYlYCh7RnnyekgKhWKMNuimR/Js1xLkfbSlT4MOKrmsjYSOuq6gL3eZF4uXIYSS4/ak4NlpcePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIWQIRjeXGEWGCmcpeUyYFf8CZapjhdGs1/1g3ZnDxA=;
 b=jx3KE0yE8UGWP9YuMKIFitqA4kSdscEAhjYW5zwfRShN7Dsq7MMy15o5LASnN/7fMHNE4mMfiRbCz97vUV6aR9n0q1f+zLKS+X87oTZpXFtq3BFO6a4Y0H3D8deTa3HXfP7VSgRvpKV+y/4LIdKXmJxdRzTRMP+EmL01guLPbbg=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH8PR10MB6599.namprd10.prod.outlook.com (2603:10b6:510:224::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:07:31 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 08:07:31 +0000
Message-ID: <5fa01a78-40c5-4ef9-9cd0-4d72a425da7f@oracle.com>
Date: Mon, 22 Jun 2026 09:07:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] CI: add clang+aarch64 to matrix
To: Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
References: <20260620083056.361658-1-alan.maguire@oracle.com>
 <d9e0f529-7b42-4b97-abb0-ca54beb3a25c@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d9e0f529-7b42-4b97-abb0-ca54beb3a25c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::16) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH8PR10MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 81214206-ee46-45d5-4aaa-08ded0354f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g9yfIB+1yNvBRXDau8rluoHG5zMWklFfSfFwYmlIkM4/F6vqv3CCzjjL4vWW//6GRjKK4iVFoM5pCVUZ8EP0iR/DkxU0eRoF3YglzVj4+RxnlzmVtlyCheG6cpqqiapHPxlqy2+vbIOXZIHN4I1fZgE5qVH7e9qaP3XcN8ZO1CexbBsy0J2F/sN0E2eiOyI/8LRclE4ZtBVNRXACN+0unPkCyboRK5FXovkqxifsuKd3qW/y3GZGqEJqmH+71w7BgQwaFsKokGihOKbR/lPBn2QBx4HM064CpzwCCSoPhBxufiVRH4kY7v5kG68i/9jmVG1OagZfOCKT6oV2iqMb2xrjGWMkX8Cejt00DBpCEGIlF8CqGCgQSprd9YT++XJ1Q+bJrLdPAmAB1mp0jItMEOqgX2wlkQLO/77Lhyp6AyyDeJSK9qZ6R6Px21Oh146ofSfsqpFtRX8wJG4xuhO3y6pgi53E/H7jrDrojkFXHFnJwRtem+FIo6xe/JclmEYLog8V85U1jT+TmGYhDWR6/9dO1HceEa7rtI2CVM2gzAWhO20/bZywtYxhhQlWWAZhSNX1GXVx/1cX07BlLfjwSXyW11GJ3iJQAGZqD+i3wbA4C0NY4yNvHrn9SGN1tDkUpkMUaSMHtk0KsexeTgUAsxgyb/vOuervpjmeNO/atjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnpTQ1A3SmFFblRzeTRFb0thejVNbnlpd1U3MnEzc2FYRkwzSnJkYUJMM2lQ?=
 =?utf-8?B?LzlYTU1PUEd4RUFHVXNrSEFXMHN4TmFpN21jdHFCK2I0cENuaDRJekZhWEh1?=
 =?utf-8?B?MlVFUm1kaFZ6Z0IyRk81bTYwaFI0WW14QWtZQzJlRExkbjhXRkdNbFo1V3RL?=
 =?utf-8?B?WjA4WkVkME15Zzk4K2kvT2QxT09PTERMODQvV25TVWhIa1UwMDdNT0t0eEN3?=
 =?utf-8?B?emlRMUdGRVpURlVTY0FpU1p0TndUc2MzVk9WWEdYcmo0UjdQTWlHNEVqRzRH?=
 =?utf-8?B?SW9tT2Zxc1JuRFhpdVlpK0hSRkNtMElub0VWM0txOGZIdmRWVXJVU0tESjVy?=
 =?utf-8?B?YmdLV0pxakdBM1JCMkgxSDdsaEJWQnVnYW9Nb3hCenlJbGtZNzJMWWQrNmEy?=
 =?utf-8?B?ZU0xRFM2UHkreGZsZEpkSWYrNkhoK1RwdzBMc2pHNS9aR1RhSndReW9FaXVB?=
 =?utf-8?B?b09ZVEE1VlJ3bHY0SW5LSlBpeTRRa09XelRoQUFzZmo4Z01aVkZoTmxiMHJz?=
 =?utf-8?B?UVJOVStzTFk0emFZd2Fta3g3TXB5anYwVWlUMENyYlJMZGJ6d3doendTcE9m?=
 =?utf-8?B?b2QrZlJrNm4rc2luMVhlK1ZlNjF0VnpjZlVTdHI4VHdGdDZtVm1weE10RVNx?=
 =?utf-8?B?b2hxUjVBS1RZdmVlM25QaW5pb09VNFNPZkkxOHNNS1Vjd2pYbmRQb0RVS0Q2?=
 =?utf-8?B?NW9zYVI3a1A0UnhqVjJYeGhpdEVRSW5HNTlSSnNZNDdIRE5DUWYyeXdFa0cw?=
 =?utf-8?B?Rzgvd0ZMY3pyOHRTVGU0RU4yR00wZkhyNTZIN0NGRmFERTYzbTVndlRFQVFu?=
 =?utf-8?B?WlQvb015ZDIvYXViNHdJSUZOSnFYcmpxZXRBdHFleUI3R3VrbUVDcU02Q3I5?=
 =?utf-8?B?UEYyMnpYRXcybXc1VGNiaS85M29pbGE3S3k1MUtOZHlBMjYzY0V2eUJnRE03?=
 =?utf-8?B?RWNTRzFhRENmSEdVWkVGNm43M0RtK1BpOW83NTBjY0N5SFdNUWdSQW9GdDNo?=
 =?utf-8?B?UWtzZnpnMFVOeFk3L2s4WlhTcUFJcTRtMGR3V05GYXJKUWJMTE4vV0l2Qlcz?=
 =?utf-8?B?VU1sVllaRXFreW5iUTE0dDcxaXc4Z2RGWElkVVBnN2hpVkJleEFQYzUyUVZP?=
 =?utf-8?B?NU1LdDJPRE5EQmFHMGZtYWVSa1Fad3lrTEpaTWpIdmg3ZG1BRWtPODFtMEpo?=
 =?utf-8?B?Y0s5dndHMElPS0xjd254QTduYVJuaCt0cVdGZHU0LzZKc2J0Y3lnRUJzOXkr?=
 =?utf-8?B?ZUQzUngzY3JvS1JUZFF2TWFqV3JacEVYZzZsaXdxakNaOWJ3bXpGWHZLNFd3?=
 =?utf-8?B?SmtEelZuODJ5cS84aVplRHNjcVIwOVpqTVQyZmk2VVBYSWVQZ201OVlKYmhC?=
 =?utf-8?B?R3pXT0tXdGlXeDJ6eXNlQ2pBMEhzYTBvS1hqbFZORlRmbHZpajF6RkdRQWFF?=
 =?utf-8?B?NU5ndHhDZlIwdDdpZU1nNmc1Zk5xY0VwZG5zUmE1MFQzVmpkVTkzRzFFZDVJ?=
 =?utf-8?B?MHI1YmlqVzlkR2hqcVJwaUROczg3dTE1WUFmV094NTNaN2ppMW9qb1g5dEUy?=
 =?utf-8?B?QUhMd2Y0bi92dHpYVmxiKzJPS3NTS2NMU01HNXJMcnBiNDZDNzNqeHNDYnht?=
 =?utf-8?B?Vk1odldmWnI1a2l2RzVnUTlzS0JlWEROL1hCc1d5KzE3ZUxFOW9QU3ZVWEZE?=
 =?utf-8?B?aDM4TTFIQk5vMkdxSFdubURSZFB1SnR1UCsyWXpRRDlCem5Da1lEcTNZMGFE?=
 =?utf-8?B?OThjYzRhNHhKcTVMcnIwcXU2ZExHUE56bGpnVnJJYm5veTYwMDhMVFU3N0Vq?=
 =?utf-8?B?NHc0OElBWlgvM0phRnI3clU4VFBxeGcxUFJFY1JJbnlZc3ZnOHM2WSt5dlpW?=
 =?utf-8?B?Z011YmJpWUloTDRkM283Z20xRVg5ck5MWmdpRldHWHM0TFZSN3VRbjhJUzZ4?=
 =?utf-8?B?MzU1S0Y3Q3B2TWpMOEZtQTg1S2szbU9VRXBoOXZDWnN2ZFpaakE5eG9IQlJp?=
 =?utf-8?B?TWFZSzU1Y3l0RmM2c004UTRuV3BFaDVvUXA2dDhqK2NDYVVva0E0aDEvUjJ5?=
 =?utf-8?B?RFNiczVRMms1U1kwcGNmc2FaMVdhQzdiVTV2WVdITEh3SmFyUUpEaHpPQzVH?=
 =?utf-8?B?WnJMQmJzZFRoSzFhWjJIVkdmd3Y5cUZ2SDBXUXp6MmIzK3RCcUh1MmZObzd1?=
 =?utf-8?B?U250bUlEZ1BFRVNrN2g1NExrTjZtaEdXeGxtUHp1N0VVTjM2ZUdYRUlqV0Zs?=
 =?utf-8?B?c2lyWWFJcURYbzcvK20zNWRTK3hEQk9BaFNqM0hYQWYyUjRmY2x4K0Z6Rm1O?=
 =?utf-8?B?d21YZDNJZjNHUGQzZE8rUjE1eGE2QllpeU9SK1lhYjZnTGE0TnJ5QT09?=
X-Exchange-RoutingPolicyChecked:
	KkvvkF6Ic7XR2c3UAdnm4DSJ0XOvQ0/swBYQm2C6HbX2KZbzISYvtlAgRLkgiJENGvFvZnC2AFHtnmK2UQU0mRfMpQO92GwSaUFyviOhKxhNdhXMwBIygJl39QuOGh+XqG2sfe1JGpfKdsYn4dCLxzI5KTDbsvY8AktKNnXTmr9OZpMvM8DQAn6eNRHR4qobyQ/X3YeM94U6MQUXexoftU5+MYZ4KMp3+fLEyl39hcNoXRKue5bqjwjN0PsqmHvp2gd0Xo1eK7qbN0mdpINv65vj5NiTtsu6cWEy/lVv+9ZzkiRmEoLaWOA8r9okaLezRYF3yejd2fJ67MxDP3AxIQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IJRnc563ThtYTxac0EJdJOnbUrUmXplyNS7aORbi7wj8N5AloT5jPOyS2GTiMdam2PJzG/HAIvxfG1sn1l5bpYBXPjOA0MCxPdnmMHu0o8FBAvsFdUBL8TKqy5JFPFI7ArOY2+R3jM6Np3HFtP/jsbvRZKi74Ur8kBb3VrVB3Mk0++XKYTlVbI6ELQa122EYikr/6AnJLgdobxKPb1RaJQ0YP/sQ+kjeC5XXh5800UNLKmAGfadw30mmHZOG1f1MhdpeEXgBtFuBvsbb0ZccJtXhEG4k26I8UAYDO1YMcnvztIMHXkUmalXQfEsO/PNqVNkAKipbXiTikq/ZOhiyGpmHWcgL/QhuRmFnEiJvoehJzrSAb81tzFyXOdF7PCTga40lhq2Q5tQiLOXer4vWg9glBUFeDZ6ldNAAqRDu8e7OBl3eB8awTpQ0/cSGq1KQ2PkEvB+H22Mc7Ato1qiDEYhCiG+o4oJS6NK+/WCGnhTw+kmClTrCSWK5Vcklr6lWRip+E2S7EpbFz+l8ffayjmMFqHTbnlM4h5ky6d/LL1omt+tm9gKmgiZ+XPho2bLuvQGwXfEpVDipCFfki6rXQanIfzTmLnwVlVDmKXOHhMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81214206-ee46-45d5-4aaa-08ded0354f08
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:07:31.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vs4HzMzL5wtq70j5oSJ0JlUlVKIVcBgHf2QWh/1l56t3mgbP/U35ZWNl8+5haK1m7PBOqMqAuv/w8BkjItpSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606220079
X-Proofpoint-GUID: OSiDQJ_Cx3r-rULZJWDKWjKb6TWqDZcr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OSBTYWx0ZWRfX1RwMrkE/O2mV
 B03L5aN9Tf47BXf4nt8rCNB2F2zjjiTxmwDK+W9L0o8RN3RhwnPNZsRooFL6NEoxNFdSHi2KHvo
 J366uK8SfzaP10GFbQnfzFnS1wVkiznFyaal4ZHUnByba+XhgpIp
X-Proofpoint-ORIG-GUID: OSiDQJ_Cx3r-rULZJWDKWjKb6TWqDZcr
X-Authority-Analysis: v=2.4 cv=Rd+gzVtv c=1 sm=1 tr=0 ts=6a38ed86 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=m9BFx1RLpwmvCK-OzFUA:9 a=QEXdDO2ut3YA:10 a=EGXCy7tgtEMA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OSBTYWx0ZWRfX9M8zYI4VCIJK
 8xntDV6MLuxXR8x5ZnajU92dlpp9dEOMtXyR8opz96bR5ZactunIlQBrWOq+DpWVYUclV/7tcmN
 e2u/69sYXwYHmJC7wcm7MgaSaFkQxYqPMHbgZR39XSMwOD2+zDO0Q2Z0Rvy5PR6jPiYhRYCrUzi
 8mB0bF5m5f6qV27oVeR9NqXGbZoURWnK0qR1oRh/YDwnDETv+fZsZcAmI1sp5velN41UieHeYSr
 Mc8RVXbWHcd+uB3Gl25QJS7PG1w+IG7TPCTe9tOS+8Z4q7XlSbt60agZPCM2Yhjn9/v8CufEZrc
 yP80aU6eCcw1QSMS3+u7u/4mQrApiC1oX0YUfHpZSbMoOeOvdJ7C0wJeZOlOlGc+AIW523pMAXB
 T0M1pwgn6+6FpfLhiwq+ko6h9VCbMyaSJHdijBpoHdyagbK1riDAkKIpXFSkPhJda1Q5jIC/UpN
 HQlFRCNTX4E5bzK4Lt9l3XufBafwQb3SbxFAexXo=

On 20/06/2026 22:01, Yonghong Song wrote:
> 
> 
> On 6/20/26 1:30 AM, Alan Maguire wrote:
>> Need to test full matrix of gcc/clang + x86_64/aarch64.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>

Applied.
