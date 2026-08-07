Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31C46D093;
	Fri,  7 Aug 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090182; cv=fail; b=QS1a2cAnktvmHmhvRWkXPcmt+s4MvwP6i9+Tr1GHLzghnz1LoRs4CijhKDSQZovxgdzuY/KYBwZBAnpcoaXOPQZz4lZpaEcl9kQs8jZvGC35a86CBlc3e9R/kcWUiYs6SYhAk8ctxhzSK4U00A0klMmBUwY8Xwk8mSYelDYguOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090182; c=relaxed/simple;
	bh=m93VZIfEPE5GAAdpfWsxAt6CfPi7p6GzFnJlMLDImtQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=abvgCMHtwIfMifrQwYRap2O715O4pbpRiPD2IYtRfNXRhHR9NetVg20qlnBxiXII4VJKn1tkDqWdUi2NpmgRM9nk9JVqHHkzVDWN3LXa+Q2bNHgAGaVod1MhVI3mpzqxJe7/uYwy+0usW0l64e7YUPZk2qWZe+7u0VqDg+FuLXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dIlYXta2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ImF4rXz/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dIlYXta2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ImF4rXz/"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6776kkTn3081949;
	Fri, 7 Aug 2026 08:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Z/HxpMu37/J2Als9jBQCxt+k34EmZwObLQC0NfRNiNs=; b=
	dIlYXta2/vofnpiC5+mWcLMjljOm0m39Twdn7T69tQAqHbfl1LU0HN1B87izPeio
	6tJCEU8vlV7c/J4Q8Z7iS6ht7WxgkCPgpKJA3JDMTFSD6CXkbD64VU9tjG+i9GVy
	00HUvVEIu0DEbfY5PDwmM0f+aDnyFTLWMmHlTVEX4rq6+SvMQIZTEH4kq5vkp8er
	KbQql8wO/SiEc1oIRm3x2aMBRx00a8EDRhpsZa3g8tsswJ9n/wFKy5qDGHgrBwFz
	fRBBnCjrrnyAQYea4JR/iPxsQYrfP6lxZe48tL269s/hsMwey9rEfVgss2iD4pfC
	33iq/jf+Vr/eSWwFtBYpRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7cyfjbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Aug 2026 08:09:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67780jEX000567;
	Fri, 7 Aug 2026 08:09:25 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78wnw6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 07 Aug 2026 08:09:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6dnRrk5A3ziBdkEVnJuUshfWVQJR70oWuRMFWNITMFHkty/1q3peIVJF3AQ6NWTDKSjR6WJKXSi7ntbw4HjW0oJ1l2hk6bJYI4SPXiX8IweAAnDi/aYQxT2QMmO6/lb7Br//HgDeb9XVOy+I2ffPwB3mQpaUjtjBM/Y6Kvj9eN2Vdqpl++87Znw42HJKWmuG8d1yXKDqRjA/CLD0TbaMBM7pmlWSo4sceGFC9hzo96Gmr4GjhLNrYJRV9NlOcMVRzTyulsJvpHtUxL+fIZih4Cu++aVQ6XpJTqbkPc1r6RM9T2IR348QkxbpuWUIogJV48hjH/ErkLVDrvUtidJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/HxpMu37/J2Als9jBQCxt+k34EmZwObLQC0NfRNiNs=;
 b=oqvhGWhzwj/LTpPdeVRfj7uaoICNERvwa0xrmh5MO3JL2HyrxbB8oOUydxNIFlVltk9vnpqZPjDgulhPjxI9nQAxyjiiy3z3g0VDQ/kCOuMbB6XUELlcEV1qj2xMsvkFGZA/Qgai1+AwW+Za79gwbZ9DfmsxpW66urGC08sx7BfiuhM3hNB11z8ebGvE3s6MbeV8upgdVlVd+T8TBXhFOlKjCBwJQx0QhL73gMzKzFN3V6aRAsXrXGumba+/R+4M6ztI2TK0wvDzULc/AIsQvMBy139Kug2ROek8YCNPz9U1JGFeZS9GL9iCuTjZuPEk4a8WX08yyt96CSMN2nkJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/HxpMu37/J2Als9jBQCxt+k34EmZwObLQC0NfRNiNs=;
 b=ImF4rXz/pZyjFw4SgRTSI5kPVkARYkX7aK79q+4cKAKEtY6JdWXPfY7YHFe8nagAiVNbNsSr3GdYb7dxcunxPy3gNF5osBXeG7vQ3MBNk16aBe7hvEUIBA+GW8RA1FYRT77AJK4Z5yfhFRtEC+mDIo+gd66OgUe5l/4aQzE5SNw=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH0PR10MB997568.namprd10.prod.outlook.com (2603:10b6:510:37e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 08:09:23 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0270.016; Fri, 7 Aug 2026
 08:09:22 +0000
Message-ID: <18b557a8-e1ca-46cf-b03f-5e68490c9229@oracle.com>
Date: Fri, 7 Aug 2026 09:09:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES 00/12] pahole: Support more rust tags and references to
 dwz alternate debug files
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        Mark Wieelard <mjw@redhat.com>
References: <20260731193102.110693-1-acme@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260731193102.110693-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH0PR10MB997568:EE_
X-MS-Office365-Filtering-Correlation-Id: 4405f875-a855-4120-0550-08def45b3084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|6133799003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	uHqVfeuK/3wq5Bz/ExcBSyWoVKPW8wN1SX5nJU/K1qFIL7UGfW4Bks+EGJpe6SHHaUtDpZsOrWh1aGw9iK058rQ2gl9SqZB2Un69JYjOFffo/ftkch2Rk/CqyeCqUjg1DltOGb6J8xd70Lu+1MkNI4VUtbff44mRtfShvfzpHmWctMEzEZWJt+N659XTaxblNNN5wE1Zy4OYqp8Gml/ljsyg/IGv1etuiJV+FnlRAQ/JORELFWB1IHFp6LdfuC/bIHn79PWO8SJarut23UXkjN/GopkQz3Zjy/IFt8+TIsevoYnnTJYyMhFT3P0URmlW5RGAgWnIrqdIWkQzVfJsr1X8GUSmx/tsm9NjCJPqDICmYLrPxtvcoF8KSVKTFtqLpvmMALDTjnkMYEyIS6qOS+EC0plD7T7WJFyyB10DrQ9TEeslUimqCCDJOW81UUFK5o9AuDl1G/VIR4PlN4QbC0FNFZzaTUersETueBp2Muq/UO+fBJNiZHkkt8xWsloTHnV/bjlnKAq3IIGWbdi+vvMynA/SoaQJDO3nRfs3Yp5qtsZGH3G8OIgJxBLmJy196yBgWSm1u3UUBRERKHaKWEYXa5VsenQu/UmEd6Rop5JPj/1/zSIcrlwS7olQJCQf+/OsUWzzs01oeRjCozXx0c2b4ltONk5CGMw1A6mfwCE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(6133799003)(22082099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFRVWVJaWkFGaGJQbHk1U0dIc2k5UHF5VjhGZXpBLy9rNXhESncycW56czMv?=
 =?utf-8?B?T3dhWHJLT2UzNnVDd2krMC8vUHRBb1dxK3hya0NvR3dsRkR6RTcxSkdKMEh3?=
 =?utf-8?B?RU53NVVVWW80ZGh3Yjl3Y3htKzAxUzMxWHF1c2RoTDBIcmRkcnJJdmhvUU1T?=
 =?utf-8?B?eG9nQ0NVaHNnYjBPNk4xU0EvNmRub0pVWFUzSWw1NTh2bjBYbVdiNjdqc01D?=
 =?utf-8?B?SUZBaUdTd3pVRXBZT3RCSENLUjZLRVlUNXJ5OGlMZ1lYdStUTk00NnFGQzQ0?=
 =?utf-8?B?UU90ak5sM2NkaFp2NkN4VytCQy9sL1NXaGl6VXlDL2Z2aVN1WExuUlJyMU5u?=
 =?utf-8?B?WUdlek9FZHFQYlZjeUx1Z1dqZkx1U2ZWdDhxMHlQd1hNaUxEWTgvV3pSalZR?=
 =?utf-8?B?Mys3bjlmYitBMlZCZFlBM1FSclhXUmF1QTNXMWxRSEhId0UxS1ZSWGIzcU1P?=
 =?utf-8?B?aE1iazdLc3YvYWFnZ3NPd3lyRXFMcVpzbldsWGtXbzVvNUxsNEljMTFZOTE5?=
 =?utf-8?B?Q3RmT2JVK1BmMmh1Rjdua05SQUU2N1JKSHhKSUZNMEhhclNGVzlDTGJ5NGVK?=
 =?utf-8?B?VW9JYnRlQXBhbXlxV2g2bjN2ZmlMQ1V0WStUTmg2TXhwRUZIVkVvQjFaWTBI?=
 =?utf-8?B?UU1RanZ3Z3FLUWlMNmpuaEVzdGtURlVzQ0I4Q3lFT0VkbVlRWVJ4U1RNZW9F?=
 =?utf-8?B?c1ptemMrUkR2djZ4bHA5WjR2SVFvd1ZxVWE2L3duWllwMnBSSGhzNkx2ejlp?=
 =?utf-8?B?cWdxZWUrMGNuMnJucEhhUGE5bU03eG9aTUFnVUt2TnZDOEhMZkNCeFM2ZmVI?=
 =?utf-8?B?MzJ1Y05OSkdsS2dCSFRkMURhRHc0K2FYSmEycUNyMnY4QURkVXZyTUZFSnRa?=
 =?utf-8?B?Q29nalBYenhLNGppblA0YmJmZW04QmtPQ1hucU9td2lKRHdFcjU4QXI0TzRQ?=
 =?utf-8?B?SDE1OXBtMEF1d1Q4eTZuMWZtd3dLZWRoRllwY2xwcWVwZHpGM2l6SkYxQnR6?=
 =?utf-8?B?eVB1VkZTcGZHeVdWM1NzcTBqVnNUOEwxanlhdDlDdFp4WEdadVREckZmQUxk?=
 =?utf-8?B?SDc1ZGdaUlBmVjh3eFB4UmZ6Q0RoZkpoQmx0WjFrV3F0a3gyaDE0YVp6V2pp?=
 =?utf-8?B?OW9Mb0RUTHM2UHpwejRLM2hyVjFabm05S3V1ZmFkYUsycEVxOU1jbDU5aWFB?=
 =?utf-8?B?eTdpMmNMbk9xQzFaUnRlVUhrUkw4NXNzdFJ5Y1FxRWJwamNIaGxGdFJaZmhL?=
 =?utf-8?B?YkNTeUtuWkcvSFpYZFRnNEFNdllVdllQbjJ3VlE3RjNEVXlGSzNNVERQSzk2?=
 =?utf-8?B?TkRNWGFlNTZGODEzLzcxYVNYbklRZExEN29vdnFkWnMrWnoyRk44K2x1cXRL?=
 =?utf-8?B?ai9OQVRkYWdTcmlzdzJ6TzRnZDFKdDI2dUtLSzQ0Z1ZtYTVKU0NIcklCbkFz?=
 =?utf-8?B?SEQvb0JHQmROSlFvakJwWlJtak0zcUhNRW5LRENJdHVvMHpaOXIvdEZrYkhj?=
 =?utf-8?B?V1RyQnZrRHRySitwV0JJLzcrU3FVWENYZ2gvekFZUUZoem9XYTBKdkozaFhX?=
 =?utf-8?B?b243cklkWkorakIxQVZXSktuVUdjdGthYTg2Q21TNFpJUDBTcXNKL1JZRXZv?=
 =?utf-8?B?OXBHNTlnTzcreDdRQWRIY0Y0d2FuNEVqZGhtWncvUUNVUS8waTVMOXp2TnBn?=
 =?utf-8?B?OGhhNS9mZHZBbXJ3TTN1c2dtMEh3OGk4TlBYS1ZqNkx5cmhTVUNiQXFFQlRS?=
 =?utf-8?B?Q3ZUb3Zpck5iQzdxRUl2SDZyK0RrQ09pN2Z2Z0FQWnRRUjVRNnVFbFE2NU5m?=
 =?utf-8?B?WXgycU9FZC9EWXMremdYazNQSVpaeFJncFUrenVDVStkZGh2dWptL3V0VXpr?=
 =?utf-8?B?UXdEeVZ3OGRYM2VxVnJWckR5Q2d6ZFU2dE9TanAyaWV2a2xoQ3BVMGpLSk4z?=
 =?utf-8?B?d1B6YjV4amRVS20wMFJhQTVnR2tqTFRFdVp3MUorM3pOMDJSVEZoNXRXZ282?=
 =?utf-8?B?ZCt1dWxKNXBaWVVkQ2drVEd2ZW14TXZHd1BLZFVmSWtKZFdtcmVwbFArb2VB?=
 =?utf-8?B?blRzYlBnZzJDZlE5Tzk0cmxwMEVIK2t4eFhtZ29mMjcvQ25zeWlkT2NhU1hm?=
 =?utf-8?B?aVQrVzgxK2RPc0lKcmg0Tk1DbFh2WlJOZVRZbnFPVzRjTXU4ZnRNTE00UzJ2?=
 =?utf-8?B?dWxORzByWnlkSmlQSWlod05Pd2Q0cTBoVUFUOXhWVW9FVUQ3eGwzWDZCUFF1?=
 =?utf-8?B?YjlLR3JxNHR6d01WNUEwd1VIdDRjOEk3ZWtacFZrUzE5LzZaUDdRQzMrWlBs?=
 =?utf-8?B?OHQvRVBlSzljNDMxTU5aQmsyK3I4TnZld3ZsbENWdit0YTNNWXhxUT09?=
X-Exchange-RoutingPolicyChecked:
	Xdleb4ld47c36u0ZyX63CsTRWaJqzrtrW2K/pfJo5y3B4GpVcJxnSsQ25+SsT0Wh+cXRLTz624ZfJGMDcb4tvyhPy4c3XDZe8cFFf4jsDKhdSt2LkYs/cuBaKhnUUq3hHlr5W0e+uTa6CERWbtAbOsoqxhsge3OHengEhPLIoEhmY7V9VlW0v9rpGkU6XVEzfy8XO51YaGfDkCf8a1yNPWPydxtNOMhWgzqVIJkftA8nKtuS6GDHkDXbLAjcy6YfIJLDlDNKJ7Eh7+Fv2tbkG3FHQx7bs3cmeEI9RkAmbwnX2+mGZhp5o5+VYDHSSy+gK+e2/wlCF2R1Q5dFeOYf9A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/TpqW2nje75iWDfyawuEyGZlDpeGLEjT6M7OxlsdfSU3ldnz/7GCPXnygFiY7hHBmUBpGXphTMiTIEHoayvwyMKTjUTT5agPt3Hi69NsEBPNuWcJyk2DiK68Dn5NLJ/Rb8Br9Xy9Fteue/GPVRtDIOYiIHNau2/kxJGrFxkbbSMEpf01YHAWDTRZbBKKTGzg5dlvtVCG0IFSUB2Kd9nqJOa+K8CJkaTSUTWQm39tvm9LFMWeFAEe5l9JBQm+OY9OW0489NVq7OX8ZQiv+/wXRlRbjGWn9PX3Tru4tL5nZF+QqwHPeCEFh2cVGz/zMJpnhYGUE9hXMGkAIj5FQx7vGVG4kSJyI9A92U3s6S1aslRCl19d7XnOAQ24OQmPvdd89Pl+j+9cJDS9fhKb3aMfxmIcyxSZx2UfDRaZLNEiNPKxN4vXhw7EVwutkVMHGBX9rkHGazVtVdt0QLVUc49RLRLe6v8096Z1+4VPE6McP7ITRK/S0Lu5g7aj/KLiHH6xznFZVBwf7iYOiUqoabJsxjUZqZmE5/84mRNKCdbVr0xNCxHHyuJFZlwcKI7FGHyZVfShbIeAlsc/f6lLxyS2YepohEpgrEXMGOLyDTAJrds=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4405f875-a855-4120-0550-08def45b3084
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 08:09:22.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgGkioSi9bjV7pgUz4w88VZ8HFR2QSKsBJNjVuK2yPUbFqASLBpcAMIAl8Wg+h0jutbtHNkJ4xvTSZ6Z9kKZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608070059
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MCBTYWx0ZWRfXzW7U9iMKO7T5
 v2fLW7oqmgdlRJNiwD4hLqZhbWpjXYcRCcxRfmejgMvU7i92BUS3hGZzzpeTVCFUEgvPuCz83fQ
 axf0OEGwFARA2t1sFRg+qWvZP3WdDEhhr/crF1ftDcZXUEodxu0O
X-Proofpoint-ORIG-GUID: HIxTe5J8SMRbePTzV-w4J7roztwr8Gls
X-Proofpoint-GUID: HIxTe5J8SMRbePTzV-w4J7roztwr8Gls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MCBTYWx0ZWRfX/Bp6WaUNIl+3
 Twa0rX5yht4CvpToR4KioAXLZ5nuhqP1M6eePzVL11UJlZ/U5sRB6P9vCjGj9Ctpo2axK0jbhjw
 Wh+6rwh+mVeeBmAeZc50j31m7JKXO4ucIKIdmPJ0QzCVEWSlEj4oqzWUxHwsW2fQWkYcVocT4D/
 PhWtgtNl1EwFxqs8JayTC+FkbhdzGVgSoC/njJJD+cGI85W3HxQ/bB9uM8ztaeVqF4Zyr+X2LCY
 VLTczvF8pjkGWHFHqDKXuy45TDP9Zuq7Mxxi+v2Jt86w42OJkmkHpC++EYGeDo6edclbiHd+lPo
 MP8tRGuIXhWKbn3/H/jzVE9BxPV3TAAnP9hZ5wigdCsNYA5S1Ky2/RuUTAXWPxg/9DVO+Nk0gjP
 5Qy8tV+cwscavx+E7Ve/0g7qFuFZ9fyB5zy1vMkM6t2C865T/A5bubReV2wHI7DDSjfuqbgMP6E
 5emrlMGD5DrHKQ0SGEnWL/ysFWEa162iChP/+/1I=
X-Authority-Analysis: v=2.4 cv=TsPWQjXh c=1 sm=1 tr=0 ts=6a7592b6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=BiLkx8lxpuncJLzAAUwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101

On 31/07/2026 20:30, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> Add support for Rust discriminated unions (enums with explicit
> discriminants).
> 
> Rust enums like Option<u32> and Result<i32,u8> are represented in DWARF
> as DW_TAG_variant_part containing DW_TAG_variant children with
> discriminant values. These patches:
> 
>   - Load DW_TAG_variant_part containers with discriminant tracking
>   - Populate DW_TAG_variant children with discriminant values
>   - Handle DW_FORM_block encoding for discriminant values
>   - Handle DW_TAG_subprogram inside DW_TAG_enumeration (Rust methods)
>   - Encode variant parts as BTF_KIND_UNION members
> 
> Before: Rust Option<u32> showed as empty struct (0 members)
> 
> After:  Shows None and Some variants with correct layout
> 
>   === pahole --expand_types output ===
>   struct Option<u32> {
>       struct None {
>       } __attribute__((__aligned__(4)));
>       struct Some {
>           /* XXX 4 bytes hole, try to pack */
>           u32  __0 __attribute__((__aligned__(4)));  /*  4  4 */
>       } __attribute__((__aligned__(4)));
>   } __attribute__((__aligned__(4)));
> 
> BTF has no discriminated-union kind, so variant parts are tentatively
> encoded as BTF_KIND_UNION with overlapping members at offset 0. Further
> discussion is needed to see if we can keep that.
> 

It seems like these variants mostly have a leading discriminating
value (telling us which variant is selected), and it looks like it is
possible to infer its presence by determining by its members if it has 
that discriminant (do any members have niche layout? if not it is there)
and its size (depends on the number of variants). Given that, would
it make sense to have a discriminant too? It seems that the above
example Option<u32> has one, so we'd have

struct Option<u32> {
    uint8_t tag;          // 1 byte: Explicit discriminant
    uint8_t pad[3];
    struct Some {
...

This would give us a better match for the in-memory representation.
What do you think, is it doable?
 
> DW_FORM_block byte order fix: uses CU-recorded endianness instead of
> assuming little-endian when decoding DW_AT_const_value and
> DW_AT_default_value. Fixes cross-endian DWARF processing (e.g.  reading
> big-endian s390x debug info on x86).
> 
> Also add support for cross-CU type references and dwz alternate debug
> files.
> 
> This is needed to improve the support for, among other things, Rust, as
> noticed in the pretty printing or a perf binary that has rust objects
> linked, built by clang/llvm that use cross-CU references.
> 
> DW_TAG_imported_unit support:
> 
>   Handle same-file partial units where types are shared across CUs
>   via DW_TAG_imported_unit. Force-merge CUs that contain inter-CU
>   references (DW_FORM_ref_addr) so type lookups resolve correctly.
> 
>   Fix cus__merging_cu failing to detect DW_FORM_ref_addr when
>   DW_FORM_implicit_const causes dwarf_getabbrevattr() to fail.
> 
> dwz alternate debug file support:
> 
>   Handle DW_FORM_GNU_ref_alt references to dwz-compressed alternate
>   debug files (.dwz). Pre-processes all alternate partial units with
>   separate hash tables and dedup tracking.
> 
>   Before (Firefox): 1774 "has no entry in cu" errors
>   After:  processes cleanly with 0 errors
> 
>   Firefox uses dwz compression which moves common types into a
>   separate .dwz file and replaces duplicates with DW_FORM_GNU_ref_alt
>   references. pahole now pre-loads the alternate file's partial units,
>   resolves all cross-file references, and processes Firefox DWARF
>   cleanly.
> 
> Includes inter-CU type reference comparison test and
> vmlinux_comparison.py for DWARF/BTF analysis across kernel configs.
> 
> Known limitations:
>   - Pruning of unreferenced alt PUs is conservatively over-approximated
>   - Merged-CU path is single-threaded by design
> 
> This makes pahole to be able to support more of the CONFIG_DEBUG_ DWARF
> options, including DWARF5 and compression, see the latest patch in the
> series for more details about how this table is produced:
> 
>   ┌───────────────────────────┬─────────┬─────┬───────────────────────────────────┬─────────┬───────┬──────────┬────────┬──────────┬─────────┐
>   │ File                      │  Size   │ Ver │ Producer                          │  DWARF  │  BTF  │ DW-Hash  │ DW-Out │ BTF-Hash │ BTF-Out │
>   ├───────────────────────────┼─────────┼─────┼───────────────────────────────────┼─────────┼───────┼──────────┼────────┼──────────┼─────────┤
>   │ vmlinux.dwarf4            │ 835.7MB │   4 │ GNU C11 16.1.1 -gdwarf-4          │ 599.2MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
>   │ vmlinux.dwarf5            │ 736.3MB │   5 │ GNU C11 16.1.1 -gdwarf-5          │ 499.7MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
>   │ vmlinux.dwarf5.zlib       │ 497.8MB │   5 │ GNU C11 16.1.1 -gdwarf-5 -gz=zlib │ 261.2MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
>   │ vmlinux.dwarf5.zstd       │ 454.7MB │   5 │ GNU C11 16.1.1 -gdwarf-5 -gz=zstd │ 218.1MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
>   │ vmlinux.toolchain_default │ 736.3MB │   5 │ GNU C11 16.1.1                    │ 499.7MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
>   └───────────────────────────┴─────────┴─────┴───────────────────────────────────┴─────────┴───────┴──────────┴────────┴──────────┴─────────┘
> 
> Split DWARF support (skeleton CUs) will be supported in upcoming work,
> so as to cover all the possibilities the kernel build system offers
> for generating DWARF.
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (12):
>   dwarf_loader: Initial support for DW_TAG_variant_part
>   dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration
>   dwarf_loader: Populate DW_TAG_variant children in DW_TAG_variant_part
>   btf_encoder: Encode variant parts as union members in BTF
>   dwarf_loader: Handle DW_FORM_block in attr_numeric for Rust discriminant values
>   dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
>   dwarf_loader: Support DW_TAG_imported_unit for same-file partial units
>   dwarf_loader: Fix cus__merging_cu failing to detect DW_FORM_ref_addr
>   dwarf_loader: Add cu parameter to tag__set_spec() and dwarf_tag__set_attr_type()
>   dwarf_loader: Support DW_FORM_GNU_ref_alt references to dwz alternate debug files
>   tests: Add inter-CU type reference comparison test
>   scripts: Add vmlinux_comparison.py for DWARF/BTF analysis
> 
>  btf_encoder.c                 |  66 ++-
>  ctf_encoder.c                 |  34 +-
>  dwarf_loader.c                | 873 ++++++++++++++++++++++++++++++----
>  dwarves.c                     |  77 ++-
>  dwarves.h                     |  63 ++-
>  dwarves_emit.c                |  10 +-
>  dwarves_fprintf.c             |  54 ++-
>  man-pages/pahole.1            |  18 +-
>  pahole.c                      |  20 +-
>  scripts/vmlinux_comparison.py | 367 ++++++++++++++
>  tests/block_endian.sh         | 146 ++++++
>  tests/dwz_alt_file.sh         | 204 ++++++++
>  tests/inter_cu_refs.sh        |  50 ++
>  tests/prettify_perf.data.sh   |   4 +-
>  14 files changed, 1854 insertions(+), 132 deletions(-)
>  create mode 100755 scripts/vmlinux_comparison.py
>  create mode 100755 tests/block_endian.sh
>  create mode 100755 tests/dwz_alt_file.sh
>  create mode 100755 tests/inter_cu_refs.sh
> 

