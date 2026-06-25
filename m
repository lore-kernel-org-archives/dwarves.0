Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380B3B19C2;
	Thu, 25 Jun 2026 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404300; cv=fail; b=YuLa4lEhO29gujNJxVx8I9Y/0HmHrF06GeJaJxsp1NfHyKbMqXK4EWYYdGwQrta2wswGk1x6fnjFvGj1fXN8SivU5YKfGEOxBB2WZa6Dc2ty9V0FHAWCUgqnYf0+61RvpJAOudF5tboWTKihiUcdelucdw/6rl7W7tbNNlL32Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404300; c=relaxed/simple;
	bh=GqJNSmBbidC+DaVsVcZQHoRxD3FEwCPtgX6PrJFqhGM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DlI4+oYXC02UhVV4t/Ju0mMIaJqMTAKHmV5f5bMS0IzbRjFv5cWE8z97OyG1AyN54ON50MkTCQX6tj30t6Eo7PeHHpd+wrPtqRCsAZ29pC42ddB4lA+upA8Cz7079LhuHZ12/JXConwuQXV/7wzR/1AXAUGU37T3dIJ8PWYSeZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T9z3CqHQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y0MVVwNa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T9z3CqHQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y0MVVwNa"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFHMBn881358;
	Thu, 25 Jun 2026 16:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yWJ0QplUA0+eX0hpXabn1f4y1rbiwJiKennoD9e3v8k=; b=
	T9z3CqHQFAawJdx6QN24xF59revOlOSh49Zf0MmfwDpEAWP7K1x90PK1fg6Y3Pal
	WWOwPjcLtudtPTXYJQVTJ/s6+OkrZ3vmnptS5GilO9kJpfEgzZ4YMjWhkkIOVJHV
	p9v443w6Hh4txm2/Bp4UIW7kbBExVccOj28eOfmPGtpgNSbzoPdknOGVSm+Dl0/L
	wZZJfXiWbcUVOd2hROOf60/beMjb0ggzHQvv3+43iUOo48TnekjMOwsNAhb0wNeq
	9zr2Fzahs0cV2dMOax/6B66OD+kgbwOGX/tyCiopagD7a3Zvl1ouiPVxHBjyihNQ
	kAU0P4KMB4yIdFC7kSRfQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhn2yjdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 16:18:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65PGI1Zj005728;
	Thu, 25 Jun 2026 16:18:08 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f05sayj82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 16:18:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWBXl733I7W4ckUlVYgy9NUm/u7Qu7ucHYQu2tGOyucSPAO3C8dNlTB2TMrkOqTwpRq/cgFGH3/C/4qxekHmnWl/wtFxpOLy+LAO+BTH8V5nmFTq41iDiosdg/wcITm7GbwaOZd57mGW4t19l8XGfx+YarCyBRZkFcDJZj/dKU8Mtyz3kh0WKyeCwueQV9OMHfP2aafn1gm55NYeGKt1xvXFNSWUrsIse0FG2t3XAy7O4l/x0CDM+X8tAmD2tiKXtVvGQEVBG34EOQRoyLVCJe0aTIH4gWabhM/6N9J1I+pkWp0Ze/Dkw+HSlW9REuJdrTF2YfXJIwo05JgCcPCQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWJ0QplUA0+eX0hpXabn1f4y1rbiwJiKennoD9e3v8k=;
 b=w9tCB2Sov07NvH3HNyYsak+YoqulhdyzO7Mek0SVWMWdAljJsc8X2nYPLqNnpDcbhVbzb1UaW9wV5Zxyqje3FqI7rSjewswb0Ro8Uv9y30/H/o+/LeysZLcZxx9DyI+yMxPYRkiMfF4VFaNBbPslZ2XX1B1iVk0jVRS+mimdFkX+dxcNRg2ioKg8s27bSpooS3OhX3O/OZDcE5CmCFkvw1GBWYVFp+fCAfjcMqcD1O/+g2ASEPQY3HUlO6KNx/LaU5AZ99LQ7oHzQdl2yNj8JqYMdXNugon9jYZlMLcW8r54/xTzs+SMsMbDRzDzZMKFfJoPwFZ4hoxHspeeKuYe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWJ0QplUA0+eX0hpXabn1f4y1rbiwJiKennoD9e3v8k=;
 b=y0MVVwNamtX6W/NlQnUOp/dboffq+sc5qbnYrhI+KA9Y10hL0v3+1+ybwhC8Y4YsqtlXYnwo6JPjZ4NjExjuSD4CEx86xe98bqtxRB0U9dUuhM6VJ8qqokn9YCQHShcObMpPwIO8+y9Rk6+HgZFIN/DynzQgcziDVtHLSno8Ev4=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:17:46 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 16:17:45 +0000
Message-ID: <3bdacbc7-8385-452a-9443-ee9cc03abd10@oracle.com>
Date: Thu, 25 Jun 2026 17:17:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v10 0/5] pahole: Encode true signatures in kernel
 BTF
To: Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20260625020148.1883082-1-yonghong.song@linux.dev>
 <aj0KGx-5FwUbwGHc@krava> <1d7828aa-164f-4c36-9d5e-2eb2088ce5b4@oracle.com>
 <906ec2c1-e62b-47d8-a0bd-4d88df26c0c3@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <906ec2c1-e62b-47d8-a0bd-4d88df26c0c3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CY8PR10MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b462a8-7184-42f2-05f5-08ded2d54acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|3023799007|56012099006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ipBdbkitBirUksud2ulbZPuDj/9y601YEz2nwBW0swPz6TM8wrjaV3X7XYjNP6O1tu027nDF1/czz+xDyiiRohS3aGXDjLVTyVAoWtneIawyI2RtMygpmwN/q8GKeFjN+qzZinQ4KoUY3w6wxu1zE1q/QcBokjme11vVMHXwgHo8CM2XIM35dF4Cbi/zzcfPxsPsY+q4m2T/fDu9mzNEFN0SXOiFvpQKqbFX6DnFXCzhEflOWHtejtB+m/uhxvUvT6ArVFD9X/sAsxYyqfPQoMRKGMgdvuCL/2Ilk8CCGr+j3lDKVeGyKbGBrFQfQQ96B5tLwbnGHnDvZn1v/2jjFU1g+seGUA38roG5qfYgJpZdLiNY2zo9tY1UxDrM2bEqdV6VfITW/WT4VC5i+ycAVObZTm06gRnlQPmtII9HAm+pwDJJm5ZQt7jVD7TDJfRRoJvixFPpPGwmQ9GyHhsEqcz83rrBxmtThWWJUWP+zhbzywpqDbSMR74DMU+IMoLR21iHihCMS3rF5aDJ0zerMEhIM1/3XvyKh8nYhydfjQNh4z+xpZDznN5WuwIFCUU7fqAv5G0OZqjthXJJQIE+2wd9yy6ZOexXS1q8NCwdRutavXH0cH8wj0HUAhcAYbD+5wRbVrBwuyD2AcRgxBvlvlgupXKuvamhEVUOR1X/6lM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(3023799007)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0NXWlREaStZcUtXTHBNVkVvMlZJY2xuY3V4MVcrT2xsc3kwODJ1VVF3VnJJ?=
 =?utf-8?B?TC9IdTV5QVg3SlJaOERzbE1CQWo0SEJFYmgrczVRWmtWRGpOd05hU1hLb2Vx?=
 =?utf-8?B?UkJwSVByYlcvMnJhbFlxNzROK3BqcTVaUUlsRVRqQkZlV3I5UFBuSHRZY1I4?=
 =?utf-8?B?SlUrTDYrWDJaejR1MGlTWjFZaktaQnQ3VXh1SFRtRWVudjBXZmxCbG4zcjFN?=
 =?utf-8?B?ME1QdXYrdDZ5RlJVRHVFVE83TldnTmdkdm16dkRmZjVBaEVaOG9GdmtSLzNU?=
 =?utf-8?B?UzJuRkNqaFpjOGVYTWVHMklXODVGdi9CVnhuZTBkZ1B3dVZPZWs2aUsxSWxX?=
 =?utf-8?B?TFBKZUM5RjNUSUM3MWZNNnlrc21FWWFGQUE5T2VTRS9GYitQY0lrKzVKNEMw?=
 =?utf-8?B?Nzdwc0gwR3NtN3d1bWhnbkVFSjRCVHRqejBZc1MweVhJUkhqVi9rVi9wQU5O?=
 =?utf-8?B?UjdmVDJpdzROd0d4Wi84cHltTm9EcklJZ3c2UzdpZXRjQ0kwQXYyM256dWFh?=
 =?utf-8?B?alhWaHJjZzF1VHkxSWVnQ2g1b3Via3NCeDVzeGpuZnV6L2E2WnNzZjd1RTFG?=
 =?utf-8?B?bXo4TDVmdlUwYVR4Q3hJRmtFRzhXTUxwWWZrUTYwUDBkSjhlOFFNcVU1dVk0?=
 =?utf-8?B?eDBUSC9EV0lUK2xjOXNsY2JoaHpMNXhPVDhBblpEOWpxU1pNRlp1dVJ2L2JN?=
 =?utf-8?B?LzFhdURXcEIrTXRhak9MenB1Nks4RzQ3S2RIQ3pCZFRCNXdET2hnZTZxdXNk?=
 =?utf-8?B?MGNTWEE1SnBlczhEWVIvVzZBeFJaeUpEb3RibnZscnZmdTdyOU5xVHJWUEVy?=
 =?utf-8?B?S21tWWpXcVQ1Q1FxeUxsbUZSY2RCTFBuWDZzdWh6R0hoVjcybFM0elFYdmlW?=
 =?utf-8?B?RVVrbU9xdm9wa0hpYkI4TkhuZzRYaW16UVdQZHE0NHhweklHM1lac1NranVV?=
 =?utf-8?B?VmUzc1VXSmwzMkZSRU4wQ1BrSDd2aHRES0pWbTRIV1BMbG0zb0d1aTV1SkFr?=
 =?utf-8?B?OVlBY0hQTjNFMzljWUYwaUtWbDFHS0NybTU1QWZJNnBDNVFJUjdmbWtSSkdq?=
 =?utf-8?B?enJ4Y2RadWRFdDNoWWsvODVMa1pHWlZGVDdpZVNocWd4ZlNlTVFBN3hUNzhk?=
 =?utf-8?B?MHZIU2tHakpsNHB5dmlTeXpXQXU0WnZFODF4Vm9xK05BL1dHS2RlWUlnS1Mw?=
 =?utf-8?B?VXdKeGpKQzJ1elY4cHV5SnhFMVk4aklybzYwcDZwdXp1MTB2NlpRY3B0Ry8x?=
 =?utf-8?B?U1YvVVY0SndiMGMyMDh1T2ZPVEpoM3BTKzU4M283N1Q2SEJ6SjIrUHNtSFJN?=
 =?utf-8?B?WXZkUy9qL1dFM0cyZFlZc09FcE5VWk9rVjhybDE1V3pKZ0J3VU9aTGZSejVR?=
 =?utf-8?B?N2FDN0UwM0NrVGlJV0U1R0ZxYUtWL21ueFhVUlY1Yk5kS0JBN0ZzNS9hRTU3?=
 =?utf-8?B?WkRVd0JMWUJwNVVRZTAyN3RVaUpiNmhDV2JJdiswcjZHTGdWbzRXVmtUN3R4?=
 =?utf-8?B?R0R1dTROSzdBQkw0a0xtUUpVU3pTdVY0SUZETXdNWEl5S3JiMU9Nb3RXVkZI?=
 =?utf-8?B?MmNNLzRaSHl3bFdHakJKT1ZmQ3lMYXdvelB5TWNubFkyeXVUalc1VDJXSmpy?=
 =?utf-8?B?VGhRUlpBb2lKM29uV2xadzYwNGFFb0x0amhmUUpCc1F4K0lUU2FEWjN2RnNB?=
 =?utf-8?B?cVZoeHhaS3lLZmJiK3pjQWZMQ3ZnM1V3N255MHc1aG9vdFRSL1UwUm51a0Jm?=
 =?utf-8?B?UHFpb1JRRld6R3hpNm5FTUFBK0o3TDFPTGFXbk5UL0ZhY2NQT2RTclpGODZZ?=
 =?utf-8?B?aG1Sdmc3MnZWdjFWTmFIL2FHaHIwMXFibUhyUnpDMTlBb3FaK0JNdEEvUDN4?=
 =?utf-8?B?NG1UN3padCtLZGd2clZEMW53NWo3cWJZRk1Ma2FaTlpDaXNMbWllaWs5bTdp?=
 =?utf-8?B?UC9QMmIvQzVzM1JFTGRIaHczOUF2YVhGOXFyRmYxWXdLMU9JT0xOSys3a1dY?=
 =?utf-8?B?a21vYUhCd1R1OGgzTjRTdnlIQ2pFem1kVk1mQ3RIOTlQWEFEL1ZwbEh1Rkx6?=
 =?utf-8?B?c1k4Y0taVGFhQms1UEdYN0ZMdnhnS3g5Rkd3am9IMG5QcUlJNDYzSnRuOXhw?=
 =?utf-8?B?eVNFZTdSMmJHWDRPUWtqSjNlNHhuMmNJRDZsQzFGUGJMblVIcTlHQVBYM1ND?=
 =?utf-8?B?bmtoNjVqcjNMWjdyUE53cHZ6QWtIWWpKT1gwSFozWEFOa2RqZnNybEZ4eEFw?=
 =?utf-8?B?NmNsYlpOK01GZDk5c1NPSCtzMXVlaDM2TlFDbEZiUGxjcS82ZEorc3dTYlpV?=
 =?utf-8?B?RVFtKzRvSjYvWjMwdTFhNGczbXlRK3cwNGVtVWsvL1VmR25uc1lxZz09?=
X-Exchange-RoutingPolicyChecked:
	ehiL/iNlTdnES9UlpL+eAeRuNKQz+nUA6pzrogyZwReZDUyvcQ2r3ivziMzzGu5Ilha95QtQAQ+kJEFiZ2UbUQ5R8PvQJB/qRXXZ7kUBWSJ8YPlpA+Jwxd5iRGbN8J20ehVu1xo6BYw76U4P5kU4ghaX8y14J3HOEPZtvmhw8ufLQELjZxiJF+leYvoAt8If+enu8sU6XShSJdd/qT0yf6PXKZDDAXGNZWZFsrc31ARaLFb3nAQ9eHmozx9EumNc9yjTj+CuWBqLsDllf8XBPY4S1gArbFaqb1VBqzBhEh5tCRYUrMNqtfjZfK26eytljbWfHHL89tOsbtb9ngYL5g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2KZV0SbVrMpou9ddbDBRvdxeY+sJ27vRthsT/mxUEMMaQk0biyWuDJIe9d79vCfakqUITr2UcpvZ9NibxjoS16eJUgSC9ZI764ABSE7hRrjROa8uWGJxRugYvfMMKKi0TRasg8kuGU6HCSp/uiiLRuUz/i8JE2VFwCMibSZCaLSwQpxxT644Zn8FgDYBpjgA6H//ns464PI/nLKxISeEWK45J4x+dHQ+wglagNsFtEgHFcNxmTBUUAKyeMtgUSqpEIdIHHmtNSJF5NFBMbBmZd6DfASvuWtfs11JLM5aQqFy11L9x8u+6I0b0MHRPSy3HAIkOh8EPftRjFoIPBbELHH4STZkDKwD7/T+AYPEphnfZSz03v+vlQCbtXEyNNmYEl5mP0jKNNFI70d1qbr0+ebco8vFNJMxN7BB5lsdFCMxREkKKYq97wt/NmUBvt8WLcs5Ftu6Mi/JDr3mC58SPimmHtjERGAmbersiTyTqcRh87gFUj1ttmxk7h5mls49PxIYG6GFmToAjZnZg6sEsi2Fcp3SS64zI7bQj2kAYsSKAsUzZNYxK2WurG0GTzVFP+2y/rme6gYktagK94aUjGnI3XfWA55j3zAGmh20aTU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b462a8-7184-42f2-05f5-08ded2d54acb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:17:45.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ptTc/+Lb6viDfPjJmS4P9kHRQco98aVqcCrIwjNV/qppOS5Go5eUwHK6xCZ0DCXp8y5xhkUp8WQmdqgxLs8xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606250140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE0MCBTYWx0ZWRfX7SYsTmqsnYOZ
 yUUeUdfjo4EOVaK/+zmOG3I6YWP+BSm1/ALpsi0U5ywLpcAyVKGybaehFJNl+IV5NTXl4tt+EMB
 e2eQ+XPAWK/aqd9ajM9kxcqeiZAu3sWsG2WzX3I6bI19iiCySQctLSr+Es1s+dq2LtqDggcXcBG
 O55CEJAdjq+AuKB8XIYB+EKF3jtvLm7jxcfpXw83oxpGmW2spQz7x09s5rTl03YhyX3cYy2CLhL
 ar57HRpWHWINdMNtsYDx0jY5/Ai/4/xzMYVjgUbxldIFudMVvrnmTJ1cQvXsIkCEKe+zXTeytql
 JsovXYOjvzPyrLfkWMqfCjUV9SDAfT3BwY8tsHAGVLjXx14nFSGXaDTUCM4D9y4m0OQA6t8QikJ
 TMfYO1u2UGJNng34AaAU9yommBzEV+eNJTSONpLvCs5mGe6fxAmA6anLX+kqzJXmnsB/XfPfnbT
 KN6VqYppID4CrvUZb2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE0MCBTYWx0ZWRfX1AQRsTU/Ucvk
 9+AB9/5hYrJVuMPXJSr3bfEgQefEleHrhW5l7S3AiG8I3rykMyKj7XkCu894VLol0mVzVK6blK2
 O5tPLixb87cpy3EyZpyXU8ZYNQehKslJWI79UwE3oGEJ25JSNSIB
X-Proofpoint-GUID: oUEQtQ6GQlKVyIMq6JbR-ExbGTs8GdRE
X-Authority-Analysis: v=2.4 cv=E479Y6dl c=1 sm=1 tr=0 ts=6a3d54c1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=NEAV23lmAAAA:8
 a=sPaMbut8sIDUcPr51UoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: oUEQtQ6GQlKVyIMq6JbR-ExbGTs8GdRE

On 25/06/2026 16:26, Yonghong Song wrote:
> 
> 
> On 6/25/26 6:22 AM, Alan Maguire wrote:
>> On 25/06/2026 11:59, Jiri Olsa wrote:
>>> On Wed, Jun 24, 2026 at 07:01:48PM -0700, Yonghong Song wrote:
>>>> Current vmlinux BTF encoding is based on the source level signatures.
>>>> But the compiler may do some optimization and changed the signature.
>>>> If the user tried with source level signature, their initial implementation
>>>> may have wrong results and then the user need to check what is the
>>>> problem and work around it, e.g. through kprobe since kprobe does not
>>>> need vmlinux BTF.
>>>>
>>>> Majority of changed signatures are due to dead argument elimination.
>>>> The following is a more complex one. The original source signature:
>>>>    typedef struct {
>>>>          union {
>>>>                  void            *kernel;
>>>>                  void __user     *user;
>>>>          };
>>>>          bool            is_kernel : 1;
>>>>    } sockptr_t;
>>>>    typedef sockptr_t bpfptr_t;
>>>>    static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>>>> After compiler optimization, the signature becomes:
>>>>    static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
>>>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
>>>> This makes it easier for developers to understand what changed.
>>>>
>>>> The new signature needs to properly follow ABI specification based on
>>>> locations. Otherwise, that signature should be discarded. For example,
>>>>
>>>>      0x0242f1f7:   DW_TAG_subprogram
>>>>                      DW_AT_name      ("memblock_find_in_range")
>>>>                      DW_AT_calling_convention        (DW_CC_nocall)
>>>>                      DW_AT_type      (0x0242decc "phys_addr_t")
>>>>                      ...
>>>>      0x0242f22e:     DW_TAG_formal_parameter
>>>>                        DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>>>>                           [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>>>>                           [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>>>>                           [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>>                           [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>>>>                        DW_AT_name    ("start")
>>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                        ...
>>>>      0x0242f239:     DW_TAG_formal_parameter
>>>>                        DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>>>>                           [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>>>>                           [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>>>>                           [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>>                           [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>>>>                        DW_AT_name    ("end")
>>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                        ...
>>>>      0x0242f245:     DW_TAG_formal_parameter
>>>>                        DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>>>>                           [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>>>>                        DW_AT_name    ("size")
>>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                        ...
>>>>      0x0242f250:     DW_TAG_formal_parameter
>>>>                        DW_AT_const_value     (4096)
>>>>                        DW_AT_name    ("align")
>>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                        ...
>>>>
>>>> The third argument should correspond to RDX for x86_64. But the location suggests that
>>>> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
>>>> the parameter value is stored in RDX or not. So we have to discard this funciton in
>>>> vmlinux BTF to avoid incorrect true signatures.
>>>>
>>>> For llvm, any function having
>>>>    DW_AT_calling_convention        (DW_CC_nocall)
>>>> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
>>>> But for non DW_CC_nocall functions, it is possible that true signature still not
>>>> available due to locations. So every functions will be checked.
>>>>
>>>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>>>> and 875 kernel functions having signature changed. A series of patches are intended
>>>> to ensure true signatures are properly represented. Eventually, only 20 functions
>>>> cannot have true signatures due to locations.
>>>>
>>>> For arm64, there are 863 kernel functions having signature changed, and
>>>> 108 functions cannot have true signatures due to locations. I checked those
>>>> functions and look like llvm arm64 backend more relaxed to compute parameter
>>>> values.
>>>>
>>>> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>>>>    -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>>>>    +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
>>>>
>>>> See individual patches for details.
>>> hi,
>>> I tried this version and had to choose another function, because "arp_process"
>>> suddenly started to show args registers in proper order ;-)
>>>
>>> now I checked "stop_cpus" function which is added to btf after this change,
>>> I attached the dwarf dump below
>>>
>>> "stop_cpus" has DW_CC_nocall set, so it has signature_changed=true and I see the
>>> function ends up in the btf_encoder with optimized_parms=1
>>>
>>> but we do not skip such functions now, it seems like we should?
>>>
>>> I tried the attached change below and it removes all the extra functions
>>> that were added in the btf with this change
>>>
>>> btw I can't see any other use for optimized_parms flag, it seems to be
>>> just set and never used.. so I wonder I'm missing something
>>>
>> Thanks for looking at this!
>>
>> Yonghong can correct me if I have this wrong, but I think optimized parameters
>> are okay, but only if true signature is enabled, so omitting functions with
>> optimized parameters should probably only happen if !true_signature. so for
>> the change below, the modification to btf_encoder__add_saved_funcs() is right
>> but I don't think the modification to btf_encoder__add_true_signature() is needed.
> 
> I agree with Alan in the above.
> 
> There is no need to make change in btf_encoder__add_true_signature().
> This is for true_signature, optimized parameters have been removed:
> 
> +               /* No location info/optimized + reordered means optimized out. */
> +               if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
> +                       state->nr_parms--;
> +                       continue;
> +               }
> 
> so we should not add true_state->optimized_parms checking in btf_encoder__add_true_signature().
> 
> For adding state->optimized_parms in btf_encoder__add_saved_funcs(), with true_signature disabled,
> we already have a failure message:
>    stop_cpus : skipping BTF encoding of function due to unexpected register usage for parameter
> The expectation is for three parameters, the register usage should be
>    cpumask: RDI, fn: RSI, arg: RDX
> but since 'fn' is optimized away, the expected reg usage does not match the actual reg usage.
> 
> We could add:
>   +        if (state->optimized_parms)
>   +            skip_reason = "optimized parms\n";
> to have another message to indicate possible reason is due to optimized parms.
> But it is not critical as we already have one message.
> 
> I can have a follow up for this.
>

I tried pushing just the btf_encoder__add_saved_funcs() hunk from Jiri's diff to CI [1];
it looks like we end up omitting a lot more functions than before for aarch64 (including
some kfuncs) for both gcc and clang kernel builds, and we see an x86_64 test failure:

5: clang_parm_memory.sh
Validation of BTF encoding of true_signatures.
   BTF for foo missing; the stack-passed aggregate was likely rejected
Test ./clang_parm_memory.sh failed
Test data is in /tmp/clang_parm_memory.sh.DV7PyO

The optimized_parms flag is a bit too broad I think; it is set whenever we are
missing location info for _any_ parameter; this may be overly aggressive for clang in
particular which seems to have more missing location info.

[1] https://github.com/alan-maguire/dwarves/actions/runs/28173261168
 
>>  
>>> jirka
>>>
>>>
>>> dwarfdump:
>>>
>>> 0x016f4b1b:   DW_TAG_subprogram
>>>                  DW_AT_low_pc    (0xffffffff813e0fc0)
>>>                  DW_AT_high_pc   (0xffffffff813e1133)
>>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>                  DW_AT_GNU_all_call_sites        (true)
>>>                  DW_AT_name      ("stop_cpus")
>>>                  DW_AT_decl_file ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>>>                  DW_AT_decl_line (464)
>>>                  DW_AT_prototyped        (true)
>>>                  DW_AT_calling_convention        (DW_CC_nocall)
>>>                  DW_AT_type      (0x016e94c5 "int")
>>>
>>> 0x016f4b36:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (0x0065ad9e:
>>>                       [0xffffffff813e0fc5, 0xffffffff813e0fed): DW_OP_reg5 RDI
>>>                       [0xffffffff813e0fed, 0xffffffff813e111e): DW_OP_reg14 R14
>>>                       [0xffffffff813e111e, 0xffffffff813e1127): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>                       [0xffffffff813e1127, 0xffffffff813e1133): DW_OP_reg14 R14)
>>>                    DW_AT_name    ("cpumask")
>>>                    DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>>>                    DW_AT_decl_line       (464)
>>>                    DW_AT_type    (0x016f3242 "const cpumask *")
>>>
>>> 0x016f4b46:     DW_TAG_formal_parameter
>>>                    DW_AT_name    ("fn")
>>>                    DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>>>                    DW_AT_decl_line       (464)
>>>                    DW_AT_type    (0x016f2ca5 "cpu_stop_fn_t")
>>>
>>> 0x016f4b52:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (0x0065ae0d:
>>>                       [0xffffffff813e0fc5, 0xffffffff813e0ff2): DW_OP_reg4 RSI
>>>                       [0xffffffff813e0ff2, 0xffffffff813e10e4): DW_OP_reg3 RBX
>>>                       [0xffffffff813e10e4, 0xffffffff813e1127): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>                       [0xffffffff813e1127, 0xffffffff813e112e): DW_OP_reg3 RBX
>>>                       [0xffffffff813e112e, 0xffffffff813e1133): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value)
>>>                    DW_AT_name    ("arg")
>>>                    DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>>>                    DW_AT_decl_line       (464)
>>>                    DW_AT_type    (0x016e858f "void *")
>>>
>>>
>>>
>>>
>>> ---
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 38455a4c6b6b..cbc5063a6280 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -1564,7 +1564,8 @@ static int btf_encoder__add_true_signature(struct btf_encoder *encoder,
>>>            */
>>>           if (true_state->unexpected_reg ||
>>>               true_state->uncertain_parm_loc ||
>>> -            true_state->ambiguous_addr)
>>> +            true_state->ambiguous_addr ||
>>> +            true_state->optimized_parms)
>>>               continue;
>>>           err = btf_encoder__add_func(encoder, true_state);
>>>           if (err < 0)
>>> @@ -1656,6 +1657,8 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>>               skip_reason = "reordered parameters\n";
>>>           if (state->elf->ambiguous_addr)
>>>               skip_reason = "ambiguous address\n";
>>> +        if (state->optimized_parms)
>>> +            skip_reason = "optimized parms\n";
>>>             if (skip_reason) {
>>>               btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
> 

