Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB29186A;
	Fri, 13 Mar 2026 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389785; cv=fail; b=TUNyu4Rw3GGXW0Cn8/zd7lPzfQy+PxwCr92PqGp2nVn6f9dX4qTOB1yyqA1WkYBtk4AyNLmPYPT2BFEGLoL0ep9k4vYsAVwOzc5QB55+P3Np4oG1/WmdJlycbfFxsmJHgjqmowkp4rKN4gCdjNndt05HLZrt1EsQLxJnTWzcOn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389785; c=relaxed/simple;
	bh=EhxhBoFrK4OT8Egl5Z7LGlcVgcnwBzyaDBLQzNjA12Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I0duQS8f7wEFoyWTB0TS5ideqdfApne7chqCBbiUFglUP2EI8zaVFdNlNfUiN1BDY/x+KrqdmEob1vCPouDHKV6YutDiVQNfREHm0Ok5AUxWP5YL3WWaPANJnEMT33kwDMm5Y3vWMMKTcE6NRxKwxjhkiJD3szaGJZDXinVmfTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kSoxMOKg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I5duKNx3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kSoxMOKg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I5duKNx3"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CLGi9L1338395;
	Fri, 13 Mar 2026 08:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zJKsiZM+Lm2NZWfwREEzC9bFOZrg0c+BcHZaSev9FGU=; b=
	kSoxMOKgv7vCsUTILh9eOV4MIkDHYd8R+Wqumyw2Q8aISsh2rQtb26ZD3yccxCvA
	XjYLCWbOm8Um+0FoKgSvy47Cl9BZtEDtC+fyGXGzKptImFtsaaY9pUqtHUIQIY3f
	6QxDXOG/LiDW29zbvL4A2WmB6OsMuvp4u8elEgfotu9Swd0TgewVU3lsKhT3l4Uw
	YVUYteWD9Vodcxn+qk/BP4ZlV/I31VqkZ4eKmgKBisYG9LJzDbDCFAR0mK2TBdJS
	DgcjgWBYHGcIq1/3C7Pwgda8eu1SHdjejlqkBzg1hZRawC9234CLQswDu8amnxzJ
	IkwojBzc0ZwY+kFrI8nAhw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cuh4fjdxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 08:15:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62D7CApc022372;
	Fri, 13 Mar 2026 08:15:48 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cuh5mdcub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 08:15:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FosiblYeJqSCcOCfsnLdoqwyYiAohDRKJFpeN+1NK/WRZrXtE/LUQo0RTSOPHAtNppaT/wj3krNLyJvfE40FrBMW3/fHvhYJieoPCsGkSaZNYiEKz+RDwEhwoHSGnPl6dV1Gwp0v2dIhK+1zZQd18kLPnA0pHdNmNRTMNuxWmv9DrH74S5D4fsvGAPXugneYoG3zxSdKuXjtfqUU5nUDt6QLh09u8zsmaMmvsuaC6pUP9WAyjCUFVajWwK9HJ5DSzWS1HU9E+6d6LkDpXhuucCZbP3PCychcT1VNOxslk6gRxQX1gEy9zkeRmItnuKcKAC6Ep7FcnbsEzvH1623KfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJKsiZM+Lm2NZWfwREEzC9bFOZrg0c+BcHZaSev9FGU=;
 b=WTaLWUvrYZPosrruyiHfO07ypLP8doAN4XXWs0AAsVYNg5uTk8vLUd0ZImvYmXFQjw3yFnVdKNAdAt0eEIT5dszkwa6v89F9pkzw+8ajO/SL5z/c1vtmMzE4FZzyZKkEeh82FMV3G1e/BgSUhbvgRZyNpWGGaxvvmDDDWzD/ppPSJd1W4DGpz/YS72Y2LuRwPKOISRe2zzZ5NOvT1UDUkB8tZkXtWOcSjIs0tbrD6nfWKuHMBAD3hd6E5h6DuXwqQnGabmF5gWY6R0MKVm1klrcDnzifn5A2oCF2kM5WyL4QWRU4bwF/PrrMqZfI0L+UGB7C4wpuim/qLUuwE+Wn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJKsiZM+Lm2NZWfwREEzC9bFOZrg0c+BcHZaSev9FGU=;
 b=I5duKNx3E6ym6NFDJF8TdMr5553d9TOPPuwK3WnhoP4vMXtF7P+yNODm8VCzFBl8GwwPNpdu8THmL5DNOpVbSW4jD476D5pGiwk2yjc6nVshdKxDC9DqRR045RzmtRQdbo7/4c9itaJP6sj/fSJTGRYCAED7KpucXh6zuOkfky4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CY8PR10MB6611.namprd10.prod.outlook.com (2603:10b6:930:55::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Fri, 13 Mar 2026 08:15:45 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 08:15:45 +0000
Message-ID: <0f3acfd2-4dc8-4059-bc08-aa1ec90b04cc@oracle.com>
Date: Fri, 13 Mar 2026 08:15:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 bpf-next 2/8] libbpf: Support layout section handling
 in BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
 <20260306113630.1281527-3-alan.maguire@oracle.com>
 <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
 <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com>
 <CAEf4BzZefR6qQwu1jENEMg15UCXXnfqfwHYRV5y4NAXWwuo4zw@mail.gmail.com>
 <50f76d21-ff5c-471d-bb11-208925778d32@oracle.com>
 <CAEf4BzatOXf0YgtQj0X+kQ=NSo_rFLAjQ0BHf-ZegFm+t43J3A@mail.gmail.com>
 <8294fca1-4d11-4c91-914a-c83d12f00ecc@oracle.com>
 <CAEf4BzbNQhga9bQuj73yE3Eg0KDuntsr-EqNOLCjSz+9GgY6Sg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzbNQhga9bQuj73yE3Eg0KDuntsr-EqNOLCjSz+9GgY6Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CY8PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 884629d9-75b9-45de-72e2-08de80d8b99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JfJYXzwK4cWff0znVs5+jv5sGHLOyDEq5VQL1+UzPJV5NJ79jFzhaW5Pe9E9kvOxVwnkEvYIUafG9pDCi51WYybTPS8jX/knwsoKr6lKZQu/MtXAQaqimJXQaXU88zOl7AiqL2AbnOObT8i/0y1jQShODmw0ar0qiDoWBeCrWrvzAmJuftHsnS9LxiQ1f2l/Mm55BImZDeUTvCQSlIFczYAjv0TNNc1Ha5TYG5B6+fCkK3jT9NPTxl7HDM5IIVYskgdVID4g3WNfEackBfgunhCtl8JQYBv5yWHgABCom1npYLUQMpCKvfqOQIORGx/08whTPP07g3gO3esV9KRJCaZ+XZ8wkLQw4YNvSYJOGBcQUBGEjC+sGGKFrR1DZDw50VQ1aw0PoJuvzEldoloh7enLTOxzf1nCIox8IPvccXq7qfW6hpgaCKkAke1kFeuhj4j7IGsOVNskPvtIeWf6PWLpCMEkSwfcMdyjSEWmfWkoLJn5KRYZRI+QX6Et2zjv28qRaAcYNpl2/oN6vxQcmsv1O9gSZPypBuAClHvhLgmOJyLiaMCySKi3r+/7qyMlolQPWSbQrPIW4Ro6czup27MUg3tZ/2KVZ2LOBrs0xvnmDCgaDmOq4e+ZJ8vZWhgixpsJU1pdYrudGPdBsj1RzE37Hd889kPbh0+/U7hmnTCT8o83xXgU6GKeKhp1MtsoT3y/bfmcRIJkbQMRWRw2a7CjVjv0N3scJXXDDnB3kIY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3ErOWZ5S29kQXNNeHBOSS9ua1ljK1BsOVpMUmpjSUZGYStCVy9XWWlIdTQz?=
 =?utf-8?B?c0xvWUpwRE9LVVdTUmxJYWc0RlhKeHhNK0lkeHVKK0JuZVBjcjFoYjVBMFlm?=
 =?utf-8?B?S3JSZXVTVStEeFg0Rk9Td3laMjl3cHlyTi83eW5yTWJwYXJnYnpUSmIySUVB?=
 =?utf-8?B?VXl5cEFIL011VTNHYXkxS2lkUnp2R0pjWHB2RTJBaHIrYkVwOG13WnUxSkxq?=
 =?utf-8?B?ZmphWlVPRjBMSWRPZHRrZEpjbGVKeEFTZzRMM20vaXlTR21Bait1ai9NUVFz?=
 =?utf-8?B?WTAvcjFrQ2Ixa0lhUHUzanFNaW44Z3JZNXdiK3R2YXozZG9XZHB2Zzh3YVdw?=
 =?utf-8?B?aGZXSEY2aXNidGV6SlM1NTRKc2RrbDVsdTYvMmFMbzlibzlYWTJSYlFCS01u?=
 =?utf-8?B?OHQ5dmJoNGFkVldoNDJPZ0JJMGxBamF1NWdISDFwMUFDRmFHVXd6dUtBVXpS?=
 =?utf-8?B?SXZlMUh0cHowWmxFTUJZQWlyRS9IbWt5dmNjRTlBcFliUC8xbXJJVFJEMjds?=
 =?utf-8?B?RUxYbHhTMmt2alBYaUtkUWZncVplaHlzaTFlcytWVHAvaHhlUEprSFlrdXRY?=
 =?utf-8?B?dGNFQVlVVmNKRVRxSDhuOXliZElCU3BFUlRPM3M0NnJHcGljcHlBTDhjTHdO?=
 =?utf-8?B?eWhldFRQZnRXRFhPaElvS21uTHNaTXJTYmY1OGI1THhKd0M0MkFCeW45cms0?=
 =?utf-8?B?UUFlKy90THpFM0dBR2J0MUl5MXhva1IxSUpWNkwrQmx3VWVRZ1dZTVZpWWNR?=
 =?utf-8?B?UTFUdlJFbzBSNjkyd2k2VE8xVHpZMmVUamVlNUpIaERSNkFUV0xtOFFoQXEv?=
 =?utf-8?B?QkhrUmhKQ0JWQ1lsSXhXRmQzVnEvTFV3bS9DOWZPRW1DOTdpMTVJK3YzUnZV?=
 =?utf-8?B?d3I0R1ZlQjBmaWJodnAxTE1MaURIQWl4NFU4UkdRK1YwTGNMTWRKcHIzU1ZZ?=
 =?utf-8?B?N00yRW5meFZRb1JFSldkbVM1UWF2MFZKaHU5S2xzVXdLUGp5WmhrK3c4N0Y3?=
 =?utf-8?B?QU45RHFvRGg5dnRxZVRGTzkvbjJ1Z3BYSStrZXpuYk9SK2dPK3FjcHhzc2NM?=
 =?utf-8?B?QVpLVnd2ckN2bnJ0U21GdFRrZ2k1M0N3QVpjKzZjS3JubkZVSG9ocTNkQndT?=
 =?utf-8?B?K2NZUDd0YUZrR1FpQTJTVzFNam5lWitlblRpWVpVWGVnblZPNDdEcmMranUy?=
 =?utf-8?B?UlROTW9HOEMrelRickNxRVVUblNvM29hSUZSTGVEK25ZR3RlckpTK2NHRVVK?=
 =?utf-8?B?UkMxdXNnUG41YzVla3NOOG9JdzRlR29zNks1a3dFK2VpcDlqbktJOVpwV0E1?=
 =?utf-8?B?VkVQVXFJNGFidEc4Q3ZObWpNQThCMHlWdWV0WjZ2cGNZbWdzK1NXZjlaRTNU?=
 =?utf-8?B?SklVL0hvLzAweFQ0aEo5OEVWbnRvOEo5VVc0SkdMUUh5d3Rqa1JjZE1HVENM?=
 =?utf-8?B?ZUtEdVZFMEZ1OFczdWJkRy8xVnl6MlZRWTZhd0tDL0k2bnlLVWV6Qnd2Sjdq?=
 =?utf-8?B?a1J1TDhsNDNITHM2c1FvQWV6MkVsMHptVUdWZm9zU0ZwZVJZSXBrTnN1ZThI?=
 =?utf-8?B?VGR5TzBYMDZUSTcwMkV1aWdTUTJ0OEFQMHB5SFZXNjBvVHBLblZmc0xZNTNQ?=
 =?utf-8?B?VWt5NUd2cHJUWSswNkdLMlczbDF4eFFOV1hFNWlPdldMM1BzN2NSZHJKb001?=
 =?utf-8?B?MFVPK3pnZ01XTTZYVlBEU00wNVBiT0xKL210MEVPVmxwR1A1SGNkYjlqM2V5?=
 =?utf-8?B?RlNOcWRwY1I5Nm1nV1EvZ2xkK3p4cUZFMXNTWTJkSTFRclRLcEZrbUhCNC8v?=
 =?utf-8?B?a3JYampGT3BkQ2pYWEdOSlNaRThRekxRbk9wT2xHcm54WlBZWVZuUmVtblN0?=
 =?utf-8?B?Z0w5d0RzeTRCWjIxK3hlaTFpU0Z3SmQ4R3I5OFBBeHdIZlFzOTgxQjBqTENG?=
 =?utf-8?B?alRqM2dlTksyNUpIeXQ5NTFtYUtRa1ErT2NuSGNrcnFMeWE2TDRxWTByMk55?=
 =?utf-8?B?aElueXJtNkJIRm9penlQOU5INWdXeVoxMG14b3UyY2xKV3JHTVlRQXN3TXRw?=
 =?utf-8?B?TC9uZis0MGtpaGdRNDNybU1NMVlKV3k3TG41Qys2TGpkNlVKaHkwK09zdGVO?=
 =?utf-8?B?NFhvWmh1ZThzR1VhYm0yR0tCV243SVByOWI0ZjZFc0JIVjEwakkwMHd3NGdq?=
 =?utf-8?B?ZTVJM0NMSWNwSTFmVmU2bitXTDFRc2pJQzUyNGhjdXRTaVU5dWlTYUtOU29q?=
 =?utf-8?B?KzB1K0hST3lXVDdQM2QzY29CbHUrRm1VaDN5UkpEd3ZUWm90d29NcHdZOURV?=
 =?utf-8?B?a0M3dXJ6OWZaTTRPNTJEODlmVHIxQUM5RW9DWFp5YkhIQ1BZcHJxQT09?=
X-Exchange-RoutingPolicyChecked:
	t/EQQDFgfCEje1dJ8J+b5DgMmJBIImPn9VoEjlHpwxg3t7cXCLzSdhImKIO36Fn08Om+BaazbiUwG+9ut3Q8TCEHV/C7rq6tbDO1oXRsuabXnrAjzcLZ51NyqH8P71V6OA4KGrSFcYnALQzM77qnueb2Idv+DpSmQ52DvSoG3Gtn3T5JRU84PIdoTTiP82UMZ5OdWcf6GEq6jgpXOX25DzibmC8k3biIhGOYZVKv9DwnCBfJ8505DDqGvHLQ66pYgAiGbnQQPrieEnewuQmp0XKF7NrS/l0LLUIAUmZcyAA3LaCal9g3DwYnSCukcUQyjkjFVkcQfaRMGGy67BYmkQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gpVVzL45CoVO+Jl7C9T1jIwW32mwbAVNjI0VNV3YDadziHt3FbwDxMk7pguC8vqD3MuzNiEUlGMth7qpnekHX8ljpaBanBnn88xJRJE6Tgb4GcsKtkcRf4IGHfbAxz0JfmoXRbyOXL3B9vb0cm6Yv6USBtPgqKhmBr01ILExS91Jo3HpacCuHYfAXydC4oivNknvN+BwlXnm3J5RF4tzpvZahfLP+Zyud1Qz0Y2s1NzIk35tutyspw8mWk5DxGwJET/NbTkLswONSuH8YsFW61HcSNfOmMMG8pomjoMZRorXyFLS/BWNPI7ozepnl0+OEhIrsESi7aVijGSl4V4ibwwT7WkoL0rld4Sk85J2++ssWonY203j6ln2MNiYuiIdpQcSBGDK+wSPBYmSLc0Zh857/4xQYssnXrXvYT3TVv3Wj0pINeOmWbDCZDzsUQXdiUCZPzqtiJ2g0ibUvS6A0sU6AjtqBxKvZsVCopdsLcK/kzsvwCoXgGBc4WwBUGiSd66w2HtYVaAgDnrwAxcGPSshwTIv/yrKA5AoJqByw/i3S8ZWWRowD6G90W064YUGRVdpUHum7RwG7H6icYvZ7C0jfCgVUHa6CJbNo534BNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884629d9-75b9-45de-72e2-08de80d8b99c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:15:45.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjRVhuSpUHOXxkYSjhUG1NQorC6tvvQKZU73dVmJy48TQ9m9Q/LW6lE5mUpHy0LdWZo4S+n7+zs6btOOmS2BEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603130063
X-Proofpoint-ORIG-GUID: MYR5IchOgYTqsu7B6VtOnezsBCrHilvc
X-Authority-Analysis: v=2.4 cv=Uthu9uwB c=1 sm=1 tr=0 ts=69b3c7b5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=wrs7IkYBIppZkYxbyjcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12272
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2MyBTYWx0ZWRfX8MyGnKLYjhzU
 4dtky+f9GPNTioatOjx9Iq4IdFL0L0aARz7FRWZ7AQm3Pl0ef3l7oKYNA7S3aiHkknrHcsxWXr5
 NyhoVQoNxXnlXC1c7KpdYGxTafpZwGZnAnuFJgrbpMDhM619Z5tUcbedmiN8RuSMMnq0HiD9tY7
 ADTLsSe+bn4ev1JPca7yX6rwojriTFjrGI32+vNw1e/DrW7RZdUalsyy/4WBFzTBGqD/GByr/rS
 3bKVpRPFEqi24M4f3dCqOyDU9qCJDD53+04vVzWKtPPRQwVYEUMXnin1pUNUX7iHe9y37moVL2q
 REK79a2MujyGq7pTBquJIv/sIf0C/tSA8WRe/RQBBC4pSVNYH2o0dYxXppimhhW4oWDE3RhUR9/
 i0fjbgdMvzqYfRJTutkVpqWnZ9zVU2fI7u41fbHn3JRKdGdcHHeeH0c78R76c4AaqtSVrLboz9t
 UTnKQs7wre1HuHb2SZKGtQnZQHBX/qoGqMohBo+Y=
X-Proofpoint-GUID: MYR5IchOgYTqsu7B6VtOnezsBCrHilvc

On 11/03/2026 23:37, Andrii Nakryiko wrote:
> On Wed, Mar 11, 2026 at 12:35 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 11/03/2026 19:21, Andrii Nakryiko wrote:
>>> On Wed, Mar 11, 2026 at 12:17 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 11/03/2026 18:16, Andrii Nakryiko wrote:
>>>>> On Wed, Mar 11, 2026 at 11:10 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>
>>>>>> On 11/03/2026 17:46, Andrii Nakryiko wrote:
>>>>>>> On Fri, Mar 6, 2026 at 3:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>>
>>>>>>>> Support reading in layout fixing endian issues on reading;
>>>>>>>> also support writing layout section to raw BTF object.
>>>>>>>> There is not yet an API to populate the layout with meaningful
>>>>>>>> information.
>>>>>>>>
>>>>>>>> As part of this, we need to consider multiple valid BTF header
>>>>>>>> sizes; the original or the layout-extended headers.
>>>>>>>> So to support this, the "struct btf" representation is modified
>>>>>>>> to contain a "struct btf_header" and we copy the valid
>>>>>>>> portion from the raw data to it; this means we can always safely
>>>>>>>> check fields like btf->hdr.layout_len
>>>>>>>>
>>>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>>>>> ---
>>>>>>>>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++----------------
>>>>>>>>  1 file changed, 200 insertions(+), 109 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>>
>>>>>>>> -       memcpy(p, hdr, hdr->hdr_len);
>>>>>>>> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_len));
>>>>>>>
>>>>>>> in all these cases where we have sizeof(struct btf_header), this
>>>>>>> smells like a potential issue, tbh. We are silently truncating the
>>>>>>> original header here, potentially. Which is ok for read-only case, but
>>>>>>> do we error out if someone is trying to modify/write such BTF where we
>>>>>>> don't really understand all of it? Should we?
>>>>>>>
>>>>>>
>>>>>> The kernel enforces that any additional data in the header beyond fields
>>>>>> we know how to deal with is zero. We don't enforce this here, but we
>>>>>> get a similar effect since we only copy the fields we care about. In effect
>>>>>> we wind up removing the aspects of the BTF we don't know about, so if we
>>>>>> read in such BTF, writing it out would not preserve any additional header
>>>>>> information (say a new section offset/length) beyond the current size of
>>>>>> struct btf_header. So writing such BTF after reading it in converts it to
>>>>>> the BTF representation libbpf knows about (header fields + sections).
>>>>>
>>>>> I don't think we should be doing this. Let's error out when someone
>>>>> tries to modify BTF where we don't understand *all* aspects of it.
>>>>>
>>>>
>>>> ok, so to do this I think we'd need to set a never_modifiable flag or similar
>>>> on parsing when we find non-zero unknown header data, and then fail
>>>> btf_ensure_modifiable().
>>>
>>> yep, I'd like some better name that would mean "there are extra btf
>>> bits we don't understand", but I can't come up with a better name :)
>>> if you can, prefer that over not very semantically meaningful "never
>>> modifiable"
>>>
>>
>> would btf->unknown_hdr_data work?
> 
> what about btf->has_hdr_extra ?
>>
> 

Perfect. BTW I've been exploring an approach to do libbpf sanitization code testing
on upstream kernels. The idea is we make kernel_supports() __weak in libbpf so that
tests can override it to simulate old kernels lacking features using test_progs
own version of kernel_supports() in btf_helpers.c. Tests set a thread-specific key
(so no parallel test interference) if they want to override behaviour, otherwise
we call the real kernel_supports() in libbpf. Would give us some extra test coverage
around sanitization (and potentially other areas which check kernel support) since 
we'll have more to do in that area for inlines. What do you think? I can separate it 
from the current series if it seems useful.
