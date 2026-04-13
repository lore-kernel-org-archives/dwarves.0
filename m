Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC13806B0
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075462; cv=fail; b=m1FiG586DOoRgaqPwK6O6oyQxsquLdKtw5geqcddidwZoxk3aLdJMa+WyPeTo15XT3u36aGhjhxPADHOmc7Av6y+VA99I+kRKn699sdqC+eHTt/xgNhr249I7huPUzlbLWCTWLUzfEwP+JKvVu4gmpuTVS5/+wVx92uGGzgpARc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075462; c=relaxed/simple;
	bh=419+yqbYR2rLR6yJhBK5lazxrKjudr5PvPmThDPAE5c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGRekRjAkVW5PEP3GLYW5cdK67Sjo3y8rHtpOGe+7rlMYDlYRxekrfsxcyEzXW2W92lgkO10DfrP0wb1EHfayW0RP2wsgMg20RpuMgU2RdntPUIfP2MN45fMl96rxGiKYsrGQrryaTkmBHd9wK7w6GKntEaivJxNUm5XZgVfBCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=btTYPbjY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uy/NDqvy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="btTYPbjY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uy/NDqvy"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D1nBDq2923149
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 10:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kbveOIQYIA0MPqGNjxH5ktDuB6JGZ6pJf2S56d0PxRI=; b=
	btTYPbjYxaYo69t+NpoSczJ+anXNG3yNF6Nw+hJNBwtGrZPnWoYojoev5Er/Ygz7
	AcoKh6CZJzGaNqVpi3JV6rtgjdanDKpVjWXv0DwI03vXudgS0xGf+B7KPKafDu2y
	EOHwzENfu7cy+hFQ/lzPEG09/j8+R16gQSPjxzZqisWXO2Veo0s4e5qJHLQkWw2R
	7TRHIsxt9BnHHpEPXTwShw7V0aOGJbLSExAFR+PzdV18FgOkisIu6Khi1SGp71/0
	ID31ky5h4w++NeObxLZYjoUPv+iNNmLxi3ThCMZ6ZjZ47oZ8Mlb+EpUggMou4ZB1
	tc4OSFgYQSNG6IgGppKHhg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dfd7aaw8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 10:17:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63DAEmKE030205
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 10:17:38 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dgbsd9ya1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 10:17:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruXWomWUsSmPvuu79Y0MObDJRCYXa4mYPln/ltT2aN28L9lwp+1L83wibP91MRskXvle0ca7q0CkifJU+1/cdzrkAZT62zN0QqDJaAGdeL/+A8Z9Ddas0WHfsvGGyc4DyPv8hPf027rQeI19jbMqCakzEEJCTx4/Z/IJSSE4xvXhGsYYQDG5WyJDw9Q+Of26EsvxmV/WwPt5ppeOKMKCwdBKbB6fEk6dZ7BlkeT6ONrgwa0fRC5RMEzR+2n/Lbu0HZ2nSQyo0AxRi6PUIdQ2iIU+AjMqedaRXUHROjuI6BlbH/bGGpomxumzY02yytWMwnuDrCEAyJUGbgIORxG/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbveOIQYIA0MPqGNjxH5ktDuB6JGZ6pJf2S56d0PxRI=;
 b=JEG9yxT5mSzoW9tCy/iLaZ4O/upJVi47wuuR6mVJ5etYKiQ56Vkp/NNBTMlZWobCkxDz/darIxBLLggi5zLiICcgwwCsWhFo+UOG0cHPd7fKVSswwGNIjd3tVCzY8NoZ2RaqaGxiui553HHRNVFhh+DL05f7biTPhdt+oRDfPcW+PPjvyimY1yU0B/DFkmr3CRTGH8KcDktwfrCVjvg+rMsoRYXM4NlCdJolUKa08AvxXe39KA+r+Mqp4jExXOjPUFyx0YPmTVK2l/mSpiXgcjH7G6Awa5sSGwkf2ZQwhqxj9DPFnS3chvYocQy5HuBx0eyT1iIICPFcKSnDP58AUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbveOIQYIA0MPqGNjxH5ktDuB6JGZ6pJf2S56d0PxRI=;
 b=Uy/NDqvy/ONb7233eSy8msLJ4819BfCTrs2Auoqo0dl4uZD2jhR80hKvN7YLusFsYIS3HXlHXaW6jXyUA+mxavH+78HUA/v0MHeTB1TxtC7T2bEIvqOjpEPJd8HkMbdmQQ93EVysYgwpXNyURP8AGTbGhLeknCxqqPYNLgmV4QM=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.39; Mon, 13 Apr
 2026 10:17:33 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 10:17:31 +0000
Message-ID: <6a4a5873-d296-4daf-9311-8dced18e6f8a@oracle.com>
Date: Mon, 13 Apr 2026 11:17:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves] dwarves: libbpf sync with 1.8
To: dwarves@vger.kernel.org
References: <20260413085834.152464-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260413085834.152464-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf01e4e-49d3-405d-6cab-08de9945def9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HOVNmLoOhYZJQiHc28byW2laDBHc+Zc0JF27KaaE2oYYo7N+d1rpL/y81l3XQCqtn6B9wpA527iLAevaSaGBpjPPgBw5ZIV7WrUYIRWnItA25Mr5VIBY+Fq6MCtmwsz3sT2pOWZtjENedN4SbiQ8R0q0ny770ml8394dcfh8gpfZpfsSZnFOkfpbFHgZAObIsGV9t/6kYla1TPpclYYDMWnB90I9UBwQ5at4eniZu0Q7eCG+2CNnXzMzYnmJzcsz4q/ED21nlQ+qDRsX7lo4WF0cUdXnv/59/usQGnV7EcKuJ3neoim9VNh9EryUPFu/gDIfpxMOghtI0IlvOuEYkv7AU2iNuOWc6hlg+i1ygMvoeckR/ApkqYG1iTshqsT5N+9blw8+4korzHVxj8l7qYQ0O9YJ0C6lyWBRemNSsqjSzyHrI8QwHNUfwf8K8vC+EwrAPzMgAHIHLfhJgHt3eKvb2oZlneCstGY3WD0VKQ0oiJi0Wd7kkRkkUstke17olUno5VdcUh5Dj6Vf7lcc+BTZk4CX6+G3j7FCGjE6pA3uskbGNW0IetYsQTyIjmqT/DOY+LTHjXMfu8rOz8OyRFy5dHoPAxeKrSZ6y+urtihX6TzBKvAAjOxmINpHBSkNuFMvVXoNVQyCvU2iWGbBDvmK1Z1mkgW72aj5G1UK/jmgoresN+NyR5BbTVqCPSejgfu4ccVHjvbJDBewHyr7Xl812DvROpfDa2E+NG1HRB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWdyQjVuUkZzKy9pTm1SVTk4bTVXYkt1LzhnUUF3QjVrSnJMdTErQldVLzd6?=
 =?utf-8?B?ajNyZURhOUJWYWdkOVJ2Tm52dWZicDFSYUl0alhIeGVVY3JiVkIvNXg4NWhS?=
 =?utf-8?B?KytZR3ZuMWpSZ0k3djdOdUk1ZnpaeE92L0ZLajBrM2liWEhFQ1JiZ2o5WGtG?=
 =?utf-8?B?clpWYWs2VThEUjFEWW83ZkdsN01sWnQwRjhYVlp2dWhxSnpNcUY3NXBpKy9n?=
 =?utf-8?B?ZHI2Ump2NW5XKzVsb2svR1FaMkF6U0Nxa1JucmlzazBvclA0OUROWDFTL1Js?=
 =?utf-8?B?NVNNdGRlMDVVMnlCeU1NQ01ZTTk5My9iUGthOVJhb2VMOTlsczludEVBR3ZI?=
 =?utf-8?B?T0VCdmtqbGxiSmFFSW1xT2JaMnR4bTdGRjdpNnZYM051TjZzT2xGVHIxLzlh?=
 =?utf-8?B?SDcwUFNiS0hBMHcrZkxGeVUxWVhEQWppdnpLTVhkYXBtQ0MwWlJBK3YyemtC?=
 =?utf-8?B?MzdPK2tZRGg3QnROMUw0Slc0SG9YOVNPdHZVaUFsbTlqMXY4VE5WNWxaMUtX?=
 =?utf-8?B?ejhGakJmL1VSRll4WHNyV2VXS2Rqb1JKMU15VUxrOE95YVByMEZnOWRNM215?=
 =?utf-8?B?ajBZa0tkdHBIcEtKd0lnSHZhR2pSVDRCemJZU0ZhREJOb2h4RVVWdXRTa2R3?=
 =?utf-8?B?RjduUm0wR21FT2FOOENRaU1vY1FwZlFwNjluTDN4d09HdGRyYUpZZzJOVHRp?=
 =?utf-8?B?eHJTY0RJZzhsNFh3UHJCSTZsYXZjNHh6R1R4K1Y4NmlPUFZIYm54amVzcnBl?=
 =?utf-8?B?ME05cVN6SnVqSktMRlh1MjJvVnNIMDVpK1lkR3JiZnErYVhWaVVhUktKZjlX?=
 =?utf-8?B?QkRXTGVMbzZzZVNOUDVPMytKZS9qdzFmbXZpQjlzYVJIWG8xdyttQnZ0YlRU?=
 =?utf-8?B?RnNXZDVydkt3bjRPQTdQbFZ0N09BOUt6YnhjaWlQVlhOMEF0YXJ3RGZpWlJI?=
 =?utf-8?B?dWpBTzRyV0lQNEJ4emtzdTBUajBiRXFielQ1ODA0aGhEQ3ZVdlRMeURQSEJt?=
 =?utf-8?B?ZHhJSk85ZXFDQTZZM2QraGxQMUZ6TDJFWE1FMXFmWG8yUDNFQjhSZm11eDE3?=
 =?utf-8?B?cm83L0FjcVFRTTQ1eUNsaXdCSC9QWmNpcVlPZjVOK3JEMnQyNld1eEF1Qzh4?=
 =?utf-8?B?MFZkMHNadnJvRld2cHJXSUk3Y2l0bjY4ZGhRSWliNGs4UTk3WlZXTGVScUk2?=
 =?utf-8?B?Y1hucForcS9zSnVEMElIYmZLU1R5ZSt0U3VXV1JRRTMxTmIwZ1Rmd0EwUzRU?=
 =?utf-8?B?UVlwbmxMQ2tlaXY0U2pkQ0tmSzB1QWxTQnpaSVR4NWFSRWJWdkNVbEJUdy9F?=
 =?utf-8?B?NlI2QkdGaUg5UmlzQmZ1aktRaHpMaVh6YjhmVXMrdGFhR0Fjd29LMHU5U2xR?=
 =?utf-8?B?WjNiY3JubXB2eHQwOFp5RXZ3OFphQnJXU2x3Yk9jRnl2Wk8rRHlaY3ROTUQ2?=
 =?utf-8?B?RjRDRUZQTVhxWFpxR3lYcjdTM2R1Z1ZBL0ZrWUxsQzg4aDZmQnlGa2lTYlFh?=
 =?utf-8?B?dU1DS09mOG9jb3dHeWxjbWFySjg5Z1RwTWNlWWhyNWxHMWkxdGg1TnBaMDJT?=
 =?utf-8?B?OEprLzV5bGZzTkczWEU0dFdLcHJHS3p2TER6OFpkczVBbmlPT3R5SzBlREZv?=
 =?utf-8?B?elNRcklPQjIwaWZOaU1LcmdoZ3FoYmtKREdjSDlZaHVBQmZWRjNhM2tDbTVD?=
 =?utf-8?B?S1ZiV3dycVhNalFkWmkzVERhU1h3bE9menpOaEk4NzAwclNrM1hNWGNSRFJ0?=
 =?utf-8?B?RHdONDQzVHFzRWlURDdQbm5PeWRkU1U0WHhlejJ1b2c1RFFvL1RTN2JWMW40?=
 =?utf-8?B?Sno3RDY5VTFlU0JGNG1PZDZmekRoNDJ3bnVYY2JPeUlUczI5OHNucEZhY0FX?=
 =?utf-8?B?NkNTMWZYZ2dtRURucVRsY3IrS29YM0h4ZWJXVUtyc3AwcnVSQnBtelhhb1NE?=
 =?utf-8?B?VjVySXVQcGJISnR5VktCSWduZTVTZFZPZkxRZUw5WkNBLzQ1dzBrbFdqVlo2?=
 =?utf-8?B?cUE5RmdDRkVVd1JZWEVyR25qdGczYWV3NVBjS2o0SEttTDdmd1Y2QzNMci9V?=
 =?utf-8?B?Qzk5THNVSFFLN0lYRWd5dkxRa2QwSUN3eTlPSjV5THhIVmE0WUhHcmtFMFBB?=
 =?utf-8?B?cHRGZDNMTVhybHV3VVdKVHhZaDg1eUZiZ1lqcnRaV0hOdFlSejdZZlZtV2hj?=
 =?utf-8?B?cm0zOHhMQkNGK0JLcDN3KzRwdlJKN3o4NjIwNGxSbE1NSm1LKzhyaTJqZVha?=
 =?utf-8?B?TU81TjZzT3BaVnpyU1BnL01vcXZ3N05McGxTajBhaXY5RkV3WE5nQUl1NS8y?=
 =?utf-8?B?QU53TXpwY3V0R3JTNXlhRjBlb1hRTDBOeUQxaUEzbmE5MUU4b3NwUT09?=
X-Exchange-RoutingPolicyChecked:
	qgoXS/wxHQAexz74dRJrW2TUBwInOcTTUFjRZ8SJ0QarZM6h4fawNLemHb3C0GHkhjW9nHAps6lQZoFfVinUkeiNevZBy/n/NdxP20j1Q/ylFCR9TRmdQjH5w1v4xAiQUamxBhVVv9OzIXI2yDjTTRuH7nhYwa3bkTbmptsM+KSOlxcPy532Bht5rmepZmUR9CKxoX1pJglkBn3Om55x6wyIXtLJRNvtxeGzKBmFLdx02rQfQim+1v90AVHS2JuNUSKBwoubeUcwXFQtnJED1hZePNW1BJcN/MD8OaY3n1cPfhOym8I2n1qGIeoQxFY2dxqqhbHiKLS2xDZ4q4iCtA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3x/iQzqpLNAB/GiCytHZdatDC9N97Ob5ahlW/cxzcc5zt1SzheqsYqVi4O6uPcSq8qWXh//DXUweLHJZi+CNLEPrMPMNi+538lOPWIfFoY5wVR2kn+fvJIulyj8BbNacJez3X4gnHpvEbhCMvTdni92CG39xcqrmGy3uwhOtgq5S8Aol33QoM4kU8Hl7a715xmqIphpj9FJxZPUZIfAqpNsdrnUvwAKTu6i20S7Mk0jdLaFttqx+rYjd9xsVe2p2Qe+KiUEM5KTP/+OG5X4amyggd+gZ9eHOP+5dshhu+xPEH2qN9m1lqmrytGZAVLV+jXOtzmjEzl3bu/ucrbbEmd5jmFVnHnEeaq04WlEfObMIgBD/3TUOwTTnvR8gfGef0zjcCLpj+ampZpqkFbozbAYFvU0gc70UAm87Ew+RaOwsf92s+ZfWYA9vkECiq7uOIT8PNqcfSyO0mjQ4/6t6OPhFDwb1puPRVGB9sMh7p+pIbLtQFD5g5aIBvUNY3/SE6H57Q4duCefKyxy3V8JIQlMlVxtE4l4u6zcr4EBn7TjFRoS+/T8upl1CIepKfg/16Q2NRYZK7q/ISWEtPqrKrosWZeEax6sl14R+QR8LUJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf01e4e-49d3-405d-6cab-08de9945def9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:17:31.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He9W9vyXi9IpHX4Mclhyh+7D2e2eER0fR+QiYpbDCz2RDuOimGEwo+1wA5eMMiEWyD/khExJJ1JYlY8OVVJA4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604010000
 definitions=main-2604130101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwMCBTYWx0ZWRfX0C/hAYiUI/6m
 SgQodpbVxqSM3BJGcWnqWKXomU33z3IQkihxoC95POiBwtqtEkzGh3CzEti9+tmqeg8kn0Amh8i
 erBH7PeXPigCnEAy9BUj8ky6MIKoyaXtNF38UfZEJJRcxuCNWpCj+xnoTXyDlD9IH4aOw/8WgGz
 4kU4Mwy5thVDAvL7ostHyKEZubvdCzJXN3LURXJV8Giu0IrTSOsZqjfS889ot3KIQf4iPB7Ndre
 GH97CLKb+ZYGN9JIIYhi7iOCYZatG1TS9PJFT0WPTJqyysIl0QHslYmCiTVQm/bwq+k1T+j48nK
 FtWBHrcU0ny1Qz+OZd8L/2v7RK7ChRai3zYsEgyY/LBKgzXEFQJ1Tc2FOlKO2CDSS9ust5ACwd9
 JOVqXL9Od2xZnMCP/l28OKAV6+8fscK3mz5zkpT0YssYHyEiPfJOPd1ZiXV70DsdmGVhM8I0RWR
 GKXMMeQQtclsTmJX89/Gk/uh+ZOA9MwdXBT3VAtE=
X-Proofpoint-GUID: CLpVwmjQy_DmgalfcMpZzzjLxmpZF7i6
X-Authority-Analysis: v=2.4 cv=DdYnbPtW c=1 sm=1 tr=0 ts=69dcc2c4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=NEAV23lmAAAA:8
 a=yPCof4ZbAAAA:8 a=8wvGxhp2R0m9zITTE2QA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13825
X-Proofpoint-ORIG-GUID: CLpVwmjQy_DmgalfcMpZzzjLxmpZF7i6

On 13/04/2026 09:58, Alan Maguire wrote:
> Sync with libbpf v1.8 [1].
> 
> This will enable support for the layout btf_feature.
> 
> [1] https://github.com/libbpf/libbpf/commit/dd92bef7f6c7a00bb0312554119b6d9cf38e4f32
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Applied.

> ---
>  lib/bpf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bpf b/lib/bpf
> index 374f780..3d451d9 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 374f7807e197ff35b5c234478e89fddd03e6d0ef
> +Subproject commit dd92bef7f6c7a00bb0312554119b6d9cf38e4f32

