Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837DB5A79B;
	Thu, 16 Jul 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218344; cv=fail; b=ifX4Pt6hOD9x9/Z3LkHwpXSo0OE8PEkRLL/VSscoAi/9v3VIDHd1FCNiMuz9cJJwTenThurV+c5JkQ2IkE3pazQc8YDGEre8z1pMFzA0ThSPJ4gMzy1BiA1Qnbmb12nOFUYEhV4irnMtyjwBtuy1OW/yGCJynP9H0Xn7hO5Hl3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218344; c=relaxed/simple;
	bh=DQRxyGqE2x3fCx5UGBYQqs8zHFo7npR4Jjk8EacOODQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KY1jYBpH5u28EzLwhYMbXYwIqUm1jlwNTGIEfdOVjicGRZJPtq5FM2S/NwDw+GyViuzn8s53Eo81f9Q3DFtAqAkCfWn1nPj/OcAJX2axCLsCKSYMV/ZnbW9UrhtrIBngHECgsMmCtGc1Hq+e9un8lEQrGnxgeDw4d1ztKJNy8J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=drEFYeIV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ynbPkJ5T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="drEFYeIV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ynbPkJ5T"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GFPUwF909839;
	Thu, 16 Jul 2026 16:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yBv+WPR1Q0J2qljw14cerXT0FzzZUuqVcaUZKBOUijU=; b=
	drEFYeIV2TbIVleIe56EZT4K/9zvOP6SrnPhGeg08RnUNv48us70ra26Ie7Cq9px
	YBZGK1CMH6UieayNV2KU7sVb6ED9Qf1xSXpJrfvZfqLfOJy7m0OaEMH3X+iOdKuF
	bKYr4Zuv68FAr62OVApoRqP4yEa453SS23RfmY3vXmgad4Lpsfk316rzYAYK+gPa
	XSghHDtnABh7yu6y55/Q4Mv8sxxglBgKkhCzRJ6PVtyZMiqIIWqJt6X/LpkJvcBq
	7e662rbVApKARnRJJbCfdvasluN5ol5JGqegw/5TJTpknn9LL9i+jCyDc4p3Hgqx
	Sx1dtISwUFZ6yM4tkxApFQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef10uk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 16:12:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66GG3fAE017513;
	Thu, 16 Jul 2026 16:12:13 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fdmhc70rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 16:12:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZE32N4uKTllizSvcEABJ04LxFaoOaf0T5uytsIQzE4fzp/yeT58moZVurwY+bBxR13T18ur2OzMMXQiUR/v0VMcx5XMI92hH+tvcik7bUKyhQ6aLrLeAMFa4zeu/8bqxUybxSf4k6wvOmGXPqQ9XLwhJpCqp/LDSOYG32BHPVtQt8Xj2k+b6R5Q8O4e+8txPT1LebrurYRXFHRgnNpKVJq46+o3GEDiV1ghfAviteXtYvUO77cEqVkw/1n3cRFvECAhprbkWCRwaSUtqjIIMfRrmoMsUKGn6tum262KEwsavOMCWzB/C8uYPTZgNbgoezBkCienoY1gME2OtSMUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBv+WPR1Q0J2qljw14cerXT0FzzZUuqVcaUZKBOUijU=;
 b=Its+d3Cff62wKaah/PLg7AwjvT31Q92lVmYPVEO9cCoSI8eB7MvHsxABNCWY201z++ZQSvICaxHODgzlYhZvNpHjgy9+oWVoTkehRlpQaR5OPzLv1lXJh9wvICJS3oNgglaTTbT1Dr8VVLOhkshqnvH8YLWTLRGInDgZoDmQ/E+nyWGfEKTwkUe2CjJx9mmAUwEJTEo/MxBvNnA9kQL3GoGaPJ5WjoXuxzHjAIQnYmjXsyLNWaaOUNTNT5FFNQw9JVcovD276uP4NNfOambddlOL02ApTvcOOTfyS4Z5+p0MzJrplPaeR0EMvSjGD7eWdjujlKE56zCMTWgIERH9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBv+WPR1Q0J2qljw14cerXT0FzzZUuqVcaUZKBOUijU=;
 b=ynbPkJ5TbUDVCzWwSRSjkOkGQDSxfnmZNbEDfaMmTnoE5B8CbJD503pC3dBi5k/AeZNi9zfuXVnQwrT1Xzg3ezFPPs2qu1IbyBiJSmA0urFprw3cLZnA6FVJHe0SEHfiBm88RRnAEGeZEjfT8TC5utrwN2T0zX0YUAH+8mJWUys=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by IA4PR10MB8658.namprd10.prod.outlook.com (2603:10b6:208:562::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 16:12:11 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 16:12:11 +0000
Message-ID: <a0bc5009-0c11-4909-9ae1-7dc873a78ff9@oracle.com>
Date: Thu, 16 Jul 2026 09:12:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
To: Yonghong Song <yonghong.song@linux.dev>,
        Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, acme@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
 <9152fde6-d35c-4688-9ff1-c7fe152c9b2a@linux.dev>
 <4e425892-2aec-4fee-a199-7fe9c615d982@linux.dev>
 <252c53f3-3f06-40f4-9cd3-795eb298687c@linux.dev>
 <c9beceb9-946d-47ce-9311-4b9559f21613@linux.dev>
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
In-Reply-To: <c9beceb9-946d-47ce-9311-4b9559f21613@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::8) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|IA4PR10MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c89ca3-617f-4896-18ea-08dee354fe19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|4143699003|3023799007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	CVQKZnCGmNG8GxLWPu44wtDvPymlYTf7h4vHdTdEcuXuhgmoitcZc/BFgFyUlNUONDeX4mDXs7EY+P/Yxn5jP5Gieaq0HA7DYeAs1ejVIDo3qilgc90GEsc+CvmNQ9JEBw2Qdu6RfuIJhzxJfKV+K7XQ4U/zJVT59bTolbmCRm3Ll17yGRMP+5JhMup+MF0RIA20SFNhAMJi8rwZaIIphjl//AU952ZJZDuRkwwc9G55XoSvz89IIC4oNbFq7O4O2OEOY38LqRFjs2YACyyuevf/piUI+2tMtHd9/1tGkQZ+HekiWNX1xwu8bKjTowBES9Fi5/QuP71/XRKhgulCJ6zHf+XWfsqQ+9f0r1fHd8OX3M1J7yWCXNBEOfTo6HV/6LsqcCxQwKiL0LmUZKsB+vIQv0PxC3IOrpUKmn6/8P4zMMrrfVhulE+EgnqvFs6O3VsynwjAZ5wGbWOefLaziFbDK507ES+zzwPPHprOAZMjc6dnkrvKcPKBKKNnLE+O4CI6E1fNWo9R2qVt8dHmNFs8nHCZ/12ArX136kEpx/xVWSEQfngqD5UROvGEYHO9RFzVlVdlL5xIGhT99CJ5joVpRE5g8tZj8I6KKt35ce4jQobcn0BGN6wafrS4pfTo60cdZ8bGR/qxlh9Xppj0JGlzOgdGeOPPrKVC7IobLtQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(3023799007)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUZRTktrNm9TQjFDSWxoYURRcE5yY2h2SGRhTW5jZVdpOUZZK3J2ZFI0dEVQ?=
 =?utf-8?B?UDhVd0M3ZGdVRklydnhzaDFmZWR5aElVbnF0WTZVNkpPdnNQU3JvRVJaeU8w?=
 =?utf-8?B?dU9RTXhvWXJxSHZaT2E3YXZVT0tyYU5maGZialFrMGJLUWR0ZkI2QjRJNXI3?=
 =?utf-8?B?RDhQRHc4MDJLSFBxTlNNaFE4WWpRWmpIK0J2RUNaRW1vWWVaeXBJSTBGcDVH?=
 =?utf-8?B?eUEyT1pUM2FKUTZ0eTBQRDNid1VtYWtCdmEzRUtXSkNBVEVnWGs0V3gwTWdU?=
 =?utf-8?B?MVhrTjZSNVlUMTREbkp3MWIrSTFjbjBwKzViajRadW42UjM2QlU4cDYrZmxq?=
 =?utf-8?B?Vm5JT1RLTS9RZHpDMHBoTnp5Q3hlQ1JPZHhTVTExcUlDeFovbm9BUWJQZ0ti?=
 =?utf-8?B?Y2l1b2JQdjlLUmJBMXJacE00N216b2VOTVBWUkdldjF5dFFZcUR5ZjNuTWhS?=
 =?utf-8?B?dVhiK0tNcHNUZklOMnlHVVJpVU9oclozK3lvQ28wY0cvZ1dnQk4wRTAzSGFZ?=
 =?utf-8?B?bkU5SHNqbk5ReGxBaldncXh0aEU2dFdSdjM4KzNGWldVbjlTanlCV0FOdlR5?=
 =?utf-8?B?amtFY3BCVVpHcGVQZ3BTWXBGd00vMy93NFZJb2psSmU0bmlHNHJwWmp4QWZH?=
 =?utf-8?B?V1dUaW4ybDZreGZ6bldiakFST0lkeVg5c3lhaUk2dDFGbmZIWXBLYUUwajdZ?=
 =?utf-8?B?WFJLRUp1eUhPbjNwZTR6d1M3UVBVTXVZaVNaL0UvS242UXRBcFc0V05UYzhU?=
 =?utf-8?B?N1kwN2VhbDFxeitaTzBsTkI4aU9NQVl0Sjc1WWF1NWN4b2FPM2xYTW5GNFFk?=
 =?utf-8?B?WWovcWZ1SU9TNnFDTlpqR0hPUzhlZXcxcTRHNVVvbTMxUE04YjRPVnczQmMw?=
 =?utf-8?B?cUUyVTM0bkh3UUo2R2h2ckR1RDdEUVd6OGFiUEJZV2lsMi9mVVgybDBTZjJI?=
 =?utf-8?B?QjB0enMrVkR0UTFyMXkwYUxYdGRjQVEyNTF2cmh6bytFUHdWVklJY0xLcmxK?=
 =?utf-8?B?QmxJSzF0eWRUeVMvRjRGK25CVzBURnV6UDJZd2Rwc0d0NWxLNTlQNVY2Wm0x?=
 =?utf-8?B?Vjd3Sy8wRkR3Vk5wSnV6U1I4ME5NM0RMMWZvU1NsQXVqSFFlMytFdEM3WFp5?=
 =?utf-8?B?SStoejVoa1dwZm9xTm0rd09PdVpKTkZMeldsZFlFdFJzZTVRdGxxYkVmRURm?=
 =?utf-8?B?ZWs2bkxHMTAvWkcrMUNkYmViYlYxeXdTRmx4UWlHTDlqdHBRTTliazlRUTg2?=
 =?utf-8?B?cnloWDBSd0wrSXZkSjJ2OWE0MEZIYVBnc0YxMkhWL3hjV2dzU1BCbFRIWTJB?=
 =?utf-8?B?WmJpWjY0WU11YU1UK3JVQmszSlBNMW9JbmxHUWVBWmc3Z0p3R0FtamV0N25N?=
 =?utf-8?B?eHcrcUJ4S1lCWHM1V1Q0cjRWL2EycVdpcUxDQWVGY0xQWEErN3lQOVNwUzZl?=
 =?utf-8?B?aXZIbzNEblFxeXFKb0M1NUkrODdIbUlNZXVsd2dITFM2WisxN1RUM1RNSFc4?=
 =?utf-8?B?VUQ4cEl1aU5oTjlGYW9YNExzM082ZUFDeStvUTdqYjRhZVZaQ0x5VXZZaG1L?=
 =?utf-8?B?VVhEcnVIOFREZmw0Y1BQUGo5SjZxNEtwZytBVzZERUFSaFlNUkRoMnNrMGRz?=
 =?utf-8?B?cWRVbUhLYnlOLzY0dUcwS1pjVzJtMTNIQ1JKQVNBMGMyQXJYQWlPcjJ2WUdm?=
 =?utf-8?B?ZHVVaFY3cWFCYVV0ZE8wN1dKQ3AwNHlYWWV0akljY1Z0bFpMVkg2Wko2STMz?=
 =?utf-8?B?dUk1V1NrMzk1Y0d0eW9JNnJsRWlHMUoxVzN0TWN2VEYwLzJNejJYUHRFaXg5?=
 =?utf-8?B?V0c4QWM4dkRjcjZZZzNVRWMyRmVyVnhIN3l0dWJXZU9oNXJhNC8vdllWUVBY?=
 =?utf-8?B?OWZHZUhPeUlxTEM4SkdLZEs5WXhxY296Unc2cFR6RjRNNFdqcDhuSHVpa0Vp?=
 =?utf-8?B?SDdYZWhpczJnR3lYVXNuMHZEbkZ4a01BaUJxM0NrYzRJVDZvUE9Cb1NaT3Yr?=
 =?utf-8?B?VGI1clNBSm5WOTkxM3RWY0xwdWljMHVKL2thNE9BU3dHRElNOTZNMEZpWmJV?=
 =?utf-8?B?aFdSenZENGdMaFc0andaSmpBNklueUJOUURNWjN5QnpCYnBtR0dwUThzZWZQ?=
 =?utf-8?B?MDVoQkttVUc2UGtRRmlKUTcvMXdjaVA3Qmo1K2xiNm1XMnVPV1VYRnNZeU5S?=
 =?utf-8?B?Vms0MVhURE84V09VY0FnRlJxN2lESTh3dy9ockJnVUlQclh5cDk0Y1pjZitR?=
 =?utf-8?B?c3h5aDZLVmlFd0o3dzJwa1RzaEJ5c01iVXlmdDVtVkFSaHlLV1A4cit3VnBF?=
 =?utf-8?B?Y011TkJ1Y2JLSnV2dTJlc2ZZV21YVGtYa2VoZzhwRmNROGQ5QWhSUT09?=
X-Exchange-RoutingPolicyChecked:
	AnJWuoIdw9BdVaD488+SE9CnQk1ttQK7ux6pL8VH7FN0LaQhnMBiL6YyArMT6JK0LTBTuIiYtfIAv8ajb8EWX6nghYS/1jf+g0mKzdO86UWHYMX9brTgL++PPt4wSAlZbca6sBXEa3yvodHVx03Def1J8Fjf7V4eYSaE3UpX9t6DawtMflxP2vSnAjwVGZQDpXx+Ao84F6mRN1Ou06CM74AYCJtPz12HYWyZg/tUfUb8E0uavS/oLPondeUmlfbB9ir4GDdZTSMqXLled+edelvMg1ZTbLKEP8mFks3G5SdRHHF0bQTtHpg/ytUCjTGInHq01Dyypg0/Q/7VUSGiZA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ETMPl0MdY6MfkjyTVslCb/lzhjn6X8GC8i2KK1874C5VY/pdgxnJeNI+bWP3bR/EYgEM3sARYdrwlAObpQrtytwBv8jWPDXnkuS4Zt+Qnxhpt6rVbNTZKvUdJUxce0L8bU/M9SY+jojhZbGcEfw69CzSqjXQqBnzA46ltKJzEgltfyZYHcaOTqjLfZWMkd7pKfNxEP0DUEF/Np7q4WErD/VGeuwON5T77RcC1r7bY+GMmqPdE42a5B00KqDdKLSPuOauv+vRCMO4pViGsgnuWTnGwKCgXAx/M2FKWiJ/60Iifd8ny4xkaihxo2XncjzecdVPE7U8tYyD3LKqYJQEhmptArtBInI1a2aPOCsTTwnXKoK4xqtUdKkj/3k45+HAN4IWyrpM0uxcU1ORbCJ/zQhePy4Brau3i+M/yTRZSimzgn29vYwxy4cVMWgiLKoVI1VH5WvIfQkFHLeqdmHFes1D1Ru2HynyJuM21Hy0v1iEi650vttEGqSwlyUkpsPpJzicgLnOFgRxRoAnAv9QSWcgkjHdSJoQ0J3F2BzyC7//PFRpo0qMfyxCNJ16MPlCThjlw9nbcC31Ue/d0KFpvc+DGhKOD9Ors+CxZm6a6zk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c89ca3-617f-4896-18ea-08dee354fe19
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 16:12:11.5236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAMy2eFevEmtGTuaCRSx97SPl1thR1LNsKV7clxBx7aaDtMbSCeR1RYpYSCiFwcAJn8I8dqmuF92D1dbrmq7XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607160165
X-Proofpoint-GUID: CRRiQYiU638hDu0HVmvJ0xIk3TNuwg16
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NSBTYWx0ZWRfXwkLr3QdSTFMY
 DgNbHeSJOpiEeB84x2RQVw6xR4PDYyvr/OqrxrgdLXXlMMLk1YLeFSmdfAh8rMpd+LWbc8ehKJy
 gYh5MMyNBX1p3uezK1DFqPi/AMzywP/+3nveD2cPPxYYpI/Zxsb0
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a5902df b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=mDV3o1hIAAAA:8
 a=FOH2dFAWAAAA:8 a=TYMUpXnxTjDD-gq6AvsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13632
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NSBTYWx0ZWRfX3970p0VLi50h
 8jWsH16X4sKnHpmEVcLKmVSzEmTpB1IXwEOUK3llOGXHZD2dtBJedy6tWfH2kMPqplREVzocxyM
 pGOxZRytCtqOo519snMcHrEOtUAmvLw3qMG8Y7QQOjYOeYaf2+Jyf6e9p76zy5BcKxsTZKa2dRl
 +szc4Rr8KcUoQU8wtmE+TNkKh6hOl3755s9Ml8HidJj0cv3Ol5DiUXk+U1VTAaTa9kqbtghHAMW
 zlS94LHDi2ywvWgbbqe4LJfUPYlDhuufVwvPcMgWJKu+tzSSC1k5CF2moiY2H+ATRxVtFY0pRoD
 pbh66BvPVfHc8Zbt45jTGHxOWqCqpmry0XRsEYETz0E0yxpnPANkibS1/sNFwvK/8HNG+rdxVyo
 vOi+dVXQN9ygjKgOPi6pCiEtUE5XWYb3ofiCsBEGSO0WRvRSUQIhHUmqvRaY94FMBvmTOuSK7jH
 waCCpr3gzC5C6qMTaohLHKJCUOOPXOmVQidiSRr8=
X-Proofpoint-ORIG-GUID: CRRiQYiU638hDu0HVmvJ0xIk3TNuwg16



On 7/1/26 10:14, Yonghong Song wrote:
> 
> 
> On 6/30/26 1:02 PM, Vineet Gupta wrote:
>> On 6/17/26 11:18 AM, Vineet Gupta wrote:
>>> On 6/3/26 1:08 PM, Yonghong Song wrote:
>>>> For decl tag
>>>> ============
>>>>
>>>> $ cat decl_tag.c
>>>> /* btf_decl_tag test cases.
>>>>     *
>>>>     * btf_decl_tag can be attached to:
>>>>     *   - global (incl. static) variables
>>>>     *   - functions
>>>>     *   - function parameters
>>>>     *   - struct/union types and their members
>>>>     *   - typedefs
>>>>     *
>>>>     * Build:  clang -O2 -target bpf -g -c decl_tag.c -o decl_tag.o
>>>>     *         /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 
>>>> -gbtf -g -c decl_tag.c -o decl_tag.o
>>>>     * Dump:   bpftool btf dump file decl_tag.o
>>>>     */
>>>>
>>>> #define __tag(x) __attribute__((btf_decl_tag(x)))
>>>>
>>>> /* tag on a global variable */
>>>> int global_var __tag("global_var_tag");
>>>>
>>>> /* tag on a static variable */
>>>> static int static_var __tag("static_var_tag");
>>>>
>>>> /* multiple tags on one declaration */
>>>> int multi_tag_var __tag("tag_a") __tag("tag_b");
>>>>
>>>> /* tag on struct type and its members */
>>>> struct foo {
>>>>            int a __tag("member_a_tag");
>>>>            int b __tag("member_b_tag");
>>>> } __tag("struct_foo_tag");
>>>>
>>>> /* tag on a typedef */
>>>> typedef struct foo foo_t1 __tag("typedef_foo_tag");
>>>> typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");
>>>>
>>>> /* tag on a function and its parameters */
>>>> __tag("func_add_tag")
>>>> int add(int x __tag("param_x_tag"), int y __tag("param_y_tag"))
>>>> {
>>>>            return x + y;
>>>> }
>>>>
>>>> /* keep the globals/types alive so they land in BTF */
>>>> int use(foo_t1 *f, foo_t2 *g)
>>>> {
>>>>            return add(global_var + static_var + multi_tag_var, f->a 
>>>> + g->foo2);
>>>> }
>>>>
>>>> $ /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c 
>>>> decl_tag.c -o decl_tag.o
>>>> decl_tag.c:30:1: warning: ‘btf_decl_tag’ attribute does not apply to 
>>>> types [-Wattributes]
>>>>       30 | } __tag("struct_foo_tag");
>>>>          | ^
>>>>
>>> [snip]
>>>
>>>> Three decl tags (struct_foo_tag, typedef_foo_tag and typedef_foo2_tag)
>>>> are missing here:
>>>>
>>>> struct foo {
>>>>            int a __tag("member_a_tag");
>>>>            int b __tag("member_b_tag");
>>>> } __tag("struct_foo_tag");
>>>>
>>>> /* tag on a typedef */
>>>> typedef struct foo foo_t1 __tag("typedef_foo_tag");
>>>> typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");
>>> Semantically what does this mean ? Will the decl tag will be "applied"
>>> where ever the type is instantiated ?
>>
>> So these are dec tags (not type tags) on typedefs.
>> Are these still relevant after the change below for supporting type 
>> tags on typedefs (and gcc has in flight patches to do the same).
>>
>>    commit 5754a48780f516cbc06eeb2a31b1e445ddd9c935
>>    Author: yonghong-song <yhs@fb.com>
>>    Date:   Mon Jun 15 10:51:02 2026 -0700
>>         [Clang][BPF] Support btf_type_tag on typedef underlying types 
>> (#203089)
>>         Emil Tsalapatis suggested to add type tag for typedef like below:
>>         ```
>>           $ cat tag.c
>>           #define __type_tag(x) __attribute__((btf_type_tag(x)))
>>           struct bar { int c; int d; };
>>           typedef struct bar __type_tag("a") bar_t;
>>           int use(bar_t *v)
>>           {
>>             return v->c + v->d;
>>           }
>>         ```
>>         This makes the code simpler -- using `bar_t *v` instead of the 
>> longer
>>         form `struct bar __type_tag("a") *v`.
>>         So the goal is to allow type tag for typedef underlying types. 
>> The
>>         following describes the main changes:
>>
>>
>> And if so, how are they semantically different and what's the use case 
>> fot decl tags on typedefs.
> 
> Decl tags and type tags are different in the above. Decl tags will be something like
> 
>      decl_tag -> typedef -> ...
> 
> Type tags will be something like\
> 
>      typedef -> type_tag -> ...
> 
> You can do both decl tag and type dag for the same typedef
> 
>      decl_tag -> typedef -> type_tag -> ...
> 
> There is a selftest (progs/test_btf_decl_tag.c) which has an example with decl_tag
> for typedef.

Curious about the above commit, in particular "on typedef underlying types".

What is the motivation to only support type_tag specifically on the underlying
type of a typedef but not elsewhere? Similar to only specifically supporting
it in pointers but not elsewhere.

I find it exceedingly strange that in this design, iiuc, one could do e.g.:

  typedef int __typetag("foo") my_int;
  my_int x;

  var("x") -> typedef -> type_tag ("foo") -> int;

but NOT

  int __typetag("foo") x;

  var("x") -> type_tag ("foo") -> int;



I mean, why not just support type_tag on any type? Like cv-quals.


> 
> About the question what is the use case for decl tags for typedef.
> The initial llvm implementation is to have more coverage so we do not need
> to add them later on. I didn't monitor this and not sure whether anybody
> uses it or not.
> 
> But I think gcc should implement
>      typedef -> type_tag -> ...
> if this is the case, I assume it should be easier for gcc to implement
>      decl_tag -> typedef -> ...
> 
>>
>>> OK, opened PR/125862 [1]  for future improvement.
>>>
>>> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125862
>>
>> If not, we can close this gcc PR as won't fix / not needed.
>>
>> Thx,
>> -Vineet
> 

