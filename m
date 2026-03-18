Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C135F5F2
	for <dwarves@vger.kernel.org>; Wed, 18 Mar 2026 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856688; cv=fail; b=G8wxN6jBFL3x4yft0UwQXro6FaIv5snuKVslrkVNLR9z+r/l0/BYkur1Z2ENVj0Vc115UIbrjlBs/dSeApgE8HGeT9n5k/6NaJ+ccNzihxTVbB0jToFGLu0sRbkrIR+xasiISCbHueFDJnEsbntdp0FfW7rJT2G9I9hi3EuZRLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856688; c=relaxed/simple;
	bh=3LyEiyRWfHK2bf8OrlgBXIicPbfxm4USe1FrO4YuZHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=toSPOmKL5PYHNUini8lB6oxnbdeg+sohQ7cefQECkBwLz3zLohPpfTqe4joiXCSTgOrBukLOvNh8SffUxr3QN3l9g6dsd99kHhfhhtAFjr4AfdN/FgfFbWsoMCrrNk7q4XJGT+NZvwwN1d5popIky6Tsfj52VXFgVJfmpiybv2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aLkhLhke; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ESPhpMur; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aLkhLhke";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ESPhpMur"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IFmd4J2168018;
	Wed, 18 Mar 2026 17:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GTLrxs3nIqKN8raJBguJKP/QEzQB1RlWIiPp7V0K+7U=; b=
	aLkhLhkeETHfUIZvfgDshH7BZLrnV8HzP4JumiMYnjmCIhnUD2aXrBdkjpJGVmfE
	A++Cy3EOdPjt/youOjnebq4NiVPFV9TUGs7WPIhR88zkjMJfsMlZ2edzg8fHqHt+
	0RNDs6R8WMUxXfEqAqdk6V8KaTkQBvjSuS6nDJu6vxsH+1aqVJ8/aj5hZ/ZqPplI
	q7NkQgFCo79goJL1x5Na4aQa+knhNiNhlsu9IuA5o/XgQl+VVPrW0Lw1TU/GG1ca
	QkOVf/5GlDbO7MLj4QUXrSCA1mtpZrTTqs3REgnJJ9pZvSkQPaAYe4INEHPTB6mp
	pbUGaB2uztE/OLS8s5KQLQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b6gbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 17:58:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62IH9XHC030461;
	Wed, 18 Mar 2026 17:58:01 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4c00kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 17:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOq8GOrPOvnJ633iI4i/UzlX8zpXbPM/5hnk3xpNGfFe2JqzxH3UpYJW1863PTge8YhxF+3y0A94J7OJ/YfduoqhOUBem/g16v0Tzk1GDmwlmxTD5EUS4/aOeUkL0A244VER3EwjCoALs60SkZ6qEgbOhpBxQQmFseMAE8Q+PPC3GMpP8XGekfWN1biDDvhdBs20juVFHuPXHIEBWvSGxcqR0ZOnqz3/46FTXYymj2WlV64OlJtSjy43HGl5Bkv1DuI+9TiVllObUtLQsnOBP0NvCmTt3d/Bnvy2+JNTXRL+eZNIlbHtCvn0sY5Tk+61DY913+8AeKwZ2qw7EDksPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTLrxs3nIqKN8raJBguJKP/QEzQB1RlWIiPp7V0K+7U=;
 b=bNva9OS2FYSR3Gm/a8yf57EWur6nSPfZRgYqKtIBVmlndjzjHH/x20TyBs5tUBRPNj8NkyzwXK38FBYYCrwAGXLomcS5qDJtfvKauhfoY6KFNAz/9bju+8TQaJmeP2QeNrCXOve3EgxfgtNdxhM1NHpegwNENAcF6QzXGIl2ilmo93U5h0XWHTKPFmdet4pzlDTojL6cWxdIo6f+Z7YNecnoQzEBqb3pCP181GGaN4+D4FA93KqaHNCALWxXFPv3WW93Od2UVHCFKkNbfe2zjvvTxfmz2RuCai1VPmyuh7MO/FC/X+ujGn0mzsIrUauucwabbAa7eVpGdWWAOPhI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTLrxs3nIqKN8raJBguJKP/QEzQB1RlWIiPp7V0K+7U=;
 b=ESPhpMuroO7uP7JYGWepeFLNLK//YWBk9CQK/4HTfyB3QrT7cRdHKj6d6BtbKv+LO4e3qgV458cAWqYlEB8V54khyhUXMWbXRJYaUBZdktnBMs5BMJb4CrKlXRUyvEo11HLW6zHH+kRO5R2GLhoNcWu0BQEsEprwcOISdo2+mfo=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Wed, 18 Mar 2026 17:57:55 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:57:55 +0000
Message-ID: <8b06999d-2c32-4678-b2a9-570b1cd11745@oracle.com>
Date: Wed, 18 Mar 2026 17:57:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] pahole: fix discarded-qualifiers for strchr/strstr.
To: "d.hourtoulle" <d.hourtoulle@geoide.fr>
Cc: dwarves@vger.kernel.org, acme@redhat.com,
        Damien Hourtoulle <damien.hourtoulle@gmail.com>
References: <20260311140938.81459-2-d.hourtoulle@geoide.fr>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260311140938.81459-2-d.hourtoulle@geoide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::26) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: db8898bc-8c5c-4c61-ee0d-08de8517e171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	428/Q8yIXDtJvuwJ8ovX2SXmoywUGeIx/Unv3kGH0wJLBOjB4wdwGi8LHT+6mPGI7OrBruXJFgGCP4wJHh3uNOIEVbr5GIiwbXxFJHTQhppUY9/HZz+dEFXmNMiTeoAoIULYhcU0kc7xTV3fpYLC725iuqYppmuCPOjuuovTgJoQHyIGgLDNgw/Zx5FtP3jHoC8YzWI0KDrYlEz8wVu8k/uuTTdCaZ1R36y+9+bfOOuV2i+E/AyfXVUJIbvdqdJKmb0oPObbF9uC6Ax2dtcXQlDvKtDNyITwqi4zOiK6JaqFTh/VqBF7H1hrpNDMktkeJdaHbYEcObQN0cWn3//p3IvoS7OFMuoHmRZSDKodhZxDwy4XFLSL9ZcyqhAu8kuVLxylzUdlHfiIj+Vi9bYcuYzqMCG75suQxIjJsTVz26+uI0a704JowoFFQTL4IFFGrw7kLcxjcE54YI4ffpF1f375mkEFg1YosOKcDJjYxOcMIM84JPDY++cYPYBQl569bf8mKXTLYDdC83k/NZvEWIDE5svbEOnUVps3ixWJOvkJyYAYMMnP0S//SDdsSHtMdyi6vk5P7rDiPwcbh9zKExgDwoE9ExwUcUS5cH7aSRDJGZNXZyRDEPCMkkOIS1RZlJi8Czkb7Bar+ngZ//RqJMQS3vHlxjRth7LS5ed3cSdTqizIjDQwABfibeOY0EBj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFRnL2dobUQ4Z0Z6eGNPYnZTRURvaFBUOW5KVFQ2a01vTlByMzN1ckE1NlVT?=
 =?utf-8?B?L3dlVitxaFIrNnZtbkJOTzBhbXVobWh5SWllNlA0b2swNDdIc0RmWVRiWHNk?=
 =?utf-8?B?VWcxZndEb0lyK2lVeDY0R0xQVjE3YjJHZHVZOXRIRm1NUTNwRGJTVC92VkNV?=
 =?utf-8?B?TE5vbTZVS3AzTXhsaldHdHJ2LzRYR1RnVm5neWZmR1J0V1lGczNqZUg0SHVt?=
 =?utf-8?B?VGMrS0xMZzY4bXVYUjdiamo0VTMveGJEUGtoRnFNR0VwQWQ2QklxbEh6TU1q?=
 =?utf-8?B?QzB4V05LRDRYOGtBdXIxR2pjcUNwbWcxdG4yRnJDb05adW85QTAyMnRDUU0y?=
 =?utf-8?B?RmxrL01nbGxweVBpOFFyMnBnR21WcE5BczZocFRIUHg2M3p2UjBacXEySkNR?=
 =?utf-8?B?K2JVam5OeS85VGtORUZpUkh3WWhxZWx3WGRVY1M3THBnVXlqU0ppd3d2MzJZ?=
 =?utf-8?B?Tm1FSno0NDFYVG9XY25FdHBkUEVTUG5YNXQ0T0g4Z2RScGxwczg0SnBFeVZ0?=
 =?utf-8?B?QnV6OFVHN0k5NU9VNmFIbWVwYkhKVzZra1puM3RSeG1MaW1tbEtyYVlSTWwr?=
 =?utf-8?B?c2REblE2RVFLRmQ1aW10SjBFTnhiZzBkbE93anhwYVYwbk9XRzM0cDY4VXpi?=
 =?utf-8?B?OHIvWXdMOEplcTZLV0hjVmRSbHROS3lHcUlxRDlRT1RPTDdydkE2S0RWR280?=
 =?utf-8?B?SlRoWitMb3VnSWVSRmtYZHlrQ1lJZ2FkUFdKNlVPTDdHS09xMHZYU1dOZkly?=
 =?utf-8?B?Tzl2VTJVWlRoU1JuUjZIaHlsQlAwV25QL0pXc2lIMHFwenkxNWl4dEJkZXI1?=
 =?utf-8?B?czJuWHhka21RUWNhS3JENlhCMHlGMkhDNWc2ME1oMG85WE9ZWEVoUjhzYVhD?=
 =?utf-8?B?b3A0TjZSNktMYXVWRDNLU0xuYjNNZ2xGeG5qNm9ZU1RpQisxMC9vbDZhYlpr?=
 =?utf-8?B?eHhLbFlnamRlQldZbWIvYkNuVlluL2U3MENuR1pONjVMY3RlU0tVWFFERlc3?=
 =?utf-8?B?RUovUEMrOHd6UWtNdHp3K1ZWRVNRUThZN3N1MkRadlA0d0tBRkxBNHg1S2U2?=
 =?utf-8?B?K3RaeFRjdGhCUCs2Mk9hZ20wVEFSZVA4T2RVY0E1Y2F5WWdsL0VjbUlzV1dj?=
 =?utf-8?B?bE1ROFZsQ09yckl2TVJ4d0pwZkdjWUFCQldzeUtqTlhmNWZCVkwwOCtBU0Yz?=
 =?utf-8?B?MU0zYzA1azZtSG16R2R5RVpZYklYUnkwV210VGovQktNNzRSWGhLODREcnhZ?=
 =?utf-8?B?dWhxWEJRQmdaS1E4bUFMcUx4Wi9GV1ZLeVExOUpuRk9YQjJzZGY0UVd1V3hr?=
 =?utf-8?B?RkhUNTMyUTQvbnNlMlJXUW1JRm1FN1BTNmxOVEpiK0FTQysyR2hmaHdnc1d4?=
 =?utf-8?B?bm0rNFN0eUxCV1ZJNS9BN0NkcXdTZ2V5OU9ENWR2a0NSVWlha2Izdk8wclJ3?=
 =?utf-8?B?V21OYy9WL2xNQVlRR0pmME5Ib1Q4ZzhYTnpQOWxINm4vb3diaStWSWJuRE5X?=
 =?utf-8?B?clhCRzFaK0FHTXlnME54bjJBZDRsd0hWME1id0IvbWwyczJsaWxnanA4a1I1?=
 =?utf-8?B?WEZMWnNETnlxTzRWdFpYcTRoZ0FwQ2ZHMlI3UmtiWHV5dy9seVZ4aGd5ZDJI?=
 =?utf-8?B?d3RMS3Z4OGg5VjhxcVNVbjMrN2VBUlJHa3RwU2hyak90WG1FdzBRUFhJN2xB?=
 =?utf-8?B?RStrZjhQZGJJVm9zNEVDdjRiUmlVM3A1RGh4UUc5YkVnZVhGU1BVTUUwa1lZ?=
 =?utf-8?B?OFlMVlpxdFRLTWNXU1ZiKzduR1hpcEovdkE0YWZKdXUxSUc4b2pCN1Y1Kzls?=
 =?utf-8?B?WWVVZ0gvcWZNZnFSOWlSOXVLamZQeTJxVXc0TW9WWDZOZDVuRFF2WEFiNUxl?=
 =?utf-8?B?RGI4VzVOWG5uZVBJNW9TdXM0RVRVU0JGZTlsaTBIL1ZYUk9aVS9McU4xdHBJ?=
 =?utf-8?B?b083ODhGSGxETGpnVXFsYk9IMmtSTGJIc2FtL1hCV3lEamxFRG9XY0JENkdx?=
 =?utf-8?B?WlRSWHIrY2M0YTRyYlhncEN5T2t4eVlzRUZ0bnFhd2E2dEJpVWl1SVpPdmVj?=
 =?utf-8?B?S1MrWllpQjNJKzdtY2tDL1QxL0MwNGhRSUtHellxOEJ4Y2toY3ZHUFp2RGI2?=
 =?utf-8?B?c2lkZlIrVmVyeHpjV3ZPdFVna20rd1I1Qzl2ZWpOYUFrSEh3TldIQXkvTWdI?=
 =?utf-8?B?MnRBdWx2Nk9LSi94QVFEWHRmcFd3VzQza1VqQUZZMGtEYi9DZ0JpdHFYbks3?=
 =?utf-8?B?OUFYN1NkVDJPNG5qeG83MGlHTlZYcDBtamJGRzJmRXJoeHI1ZHZObG5pUnd1?=
 =?utf-8?B?VnhIK0x2ejUrWEtldXRXOUkzQ045bWpFZk1oZHhHL2V2Wi9XY0FIZz09?=
X-Exchange-RoutingPolicyChecked:
	ki2XjFNQLl9jRAUpBb7IItrfgvm/Rg+/rc2Wk4F3wtduX2UJ0dst3NmUhqvZWsFdIp50fMKhf025XuUDuWdQhzd/P6nh3vIBZeSVOxJWur8vLUluWeNDitEphp8nPyilGa4lpfDAApPUy9B96NftjIlLNvhp86Q1qnd3CV6VyY2v+H5VB8sTvnLCepTeEMxJt0Z50dnqzwPkZyltmMuWHA1QO6xnnkibJHrFWPcOQs9d+WRBqESp5Md8jhUmscy7YGfT4apipyI+/nS3JW/xU5t6onSJWO0UpRVynzaPmmAPjLGzu2HY90UnMnQ4k0ra+eV8CdoM+03iMyMkcJ+LBw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zqi6v7y7JoobfpDptrESz6U8TV3gblmVg7IYjVQVfgY8zeBkhq+dkUUpuADS3nw+i2m/nMmj/iAY+IcsATYX2wdJiMvmk7y0vhOofqNfKZ2SFt5Z019/vvk6NgY0hNEv49OmNbZd95OWyuTWjj/1p9HuSN7BACeyZVr7vgr6uwTN+Yi1/RPy7w9o2bEXnDEuIXUUwVVXf4S5bnLE2mdYCIbtYiKQxkpy7kOU3Lc01iwUK5y1rxkqph5xNJkbDxyQEBEqWoT2zcg1+2TZExTw5b9FHhDu2+4kbUpblDZU+eVjvKYH7qbfHdB8AWlcWer+BkibW7WAE/csOJiUY2fXwlyAUbNxSqjaiJTfWTwLc1G9i3GnR9Yuhd7O+M+5OQ4hXFQlCs4erzEWOE9vxrtsEimqn5acY+3AF+y6hYGWhvsdf4Jdk24eP6xfMYX3pemzY0azbriHJ6NAPx8kqro4ffkAPN1eAnbycCCw3OMplPusvqIj2q/qABw4qDZIc/v5cbJvbq0DqMemhPPf4aNDi+28lg3K7GoIqvyEtlHmx5thcMlXxUsFmdkY993GHOq7t38jZ8QmffFcERNApp1nHwilml4T1J6Hpho2ZPVZG0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8898bc-8c5c-4c61-ee0d-08de8517e171
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 17:57:55.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gz2xRJom3mQRUnZUd/3zXTbjIKwLLo0czb2ZgNDl3wvxp3Pb3AHZyQ8SL29KHBOkvrl08E+GLQxYo/QdmcNxDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603180153
X-Proofpoint-GUID: GaXbvfPDVGpxX_jsJAwRfd6CwRzoW_pD
X-Proofpoint-ORIG-GUID: GaXbvfPDVGpxX_jsJAwRfd6CwRzoW_pD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE1MyBTYWx0ZWRfX//XpnjG+sfnf
 IHhn5fp3iM1bLsdhgxswkKNUHNvQ7yR+16GUJc81XncOwDk8Dy4iv61DozKCoIQIh3vGyOsNmvD
 BCi33+VQAhUyF5QrGGqog517nlaa+evRn3wMXDSGWJWf0Vv+0SYFZaMlMiAz+THUfXAydfK6Xtb
 69XXXjYfuqiG/sP0OViWW9ofkON8//gQVENmHS7ePqxcR/nysICYuQfhWi8NSE0x+zwYpjBGslI
 azf0VVeqOcUa0ocf1MxXSpLJlfW93Ja84lKsEEZRbPaPvQrOcVs8h3S7k9BBWkruaeTz3R15pNW
 I82qhmHgD7jH79Rq92dkOoKHv607F+d56K6e+xIv5wJMLYN/1TKAbedh1L91LZNW9MFKO1btwl/
 Phob+ussDKGdjU+bduYLWTicNt2wchdGSEjoydomgo5tEFdLYgM2avStWvYRMuvQbQCYsGIQ2eF
 3Q6DH5aIM4y4eUDsX0w==
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69bae7aa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=CCpqsmhAAAAA:8
 a=pGLkceISAAAA:8 a=zNjkItqz-Tks98FfUNYA:9 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22

On 11/03/2026 14:09, d.hourtoulle wrote:
> From: Damien Hourtoulle <damien.hourtoulle@gmail.com>
> 
> Glibc 2.43 added C23 const-preserving overloads :
> https://sourceware.org/glibc/wiki/Release/2.43.
> 
> For the function prototype__new, fix local variable declaration to use
> the correct const char* type instead of char*, removing the need to
> discard the const qualifier.
> 
> Also fix a pre-existing bug in type__find_type_enum: when iterating
> over a '+'-concatenated list of enum names, after advancing to the next
> segment the new separator was not nullified, causing "second+third" to
> be passed to cu__find_enumeration_by_name instead of "second".  Add a
> null check before writing to sep_mutable to avoid a null dereference
> when no further '+' is present.
> 
> Signed-off-by: Damien Hourtoulle <damien.hourtoulle@gmail.com>

applied, thanks!

> ---
>  btf_encoder.c |  2 +-
>  pahole.c      | 35 ++++++++++++++++++-----------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index aa7cd1c..d36984a 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1218,7 +1218,7 @@ static bool str_contains_non_fn_suffix(const char *str) {
>  		".cold",
>  		".part"
>  	};
> -	char *suffix = strchr(str, '.');
> +	const char *suffix = strchr(str, '.');
>  	int i;
>  
>  	if (!suffix)
> diff --git a/pahole.c b/pahole.c
> index 02a0d19..e4bfb69 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2483,7 +2483,7 @@ static int64_t type_instance__int_value(struct type_instance *instance, const ch
>  	int byte_offset = 0;
>  
>  	if (!member) {
> -		char *sep = strchr(member_name_orig, '.');
> +		const char *sep = strchr(member_name_orig, '.');
>  
>  		if (!sep)
>  			return -1;
> @@ -2496,8 +2496,8 @@ static int64_t type_instance__int_value(struct type_instance *instance, const ch
>  		char *member_name = member_name_alloc;
>  		struct type *type = instance->type;
>  
> -		sep = member_name_alloc + (sep - member_name_orig);
> -		*sep = 0;
> +		char *sep_mutable = member_name_alloc + (sep - member_name_orig);  // sep mutable for the copy
> +		*sep_mutable = 0;
>  
>  		while (1) {
>  			member = type__find_member_by_name(type, member_name);
> @@ -2510,9 +2510,9 @@ out_free_member_name:
>  			type = tag__type(cu__type(cu, member->tag.type));
>  			if (type == NULL)
>  				goto out_free_member_name;
> -			member_name = sep + 1;
> -			sep = strchr(member_name, '.');
> -			if (!sep)
> +			member_name = sep_mutable + 1;
> +			sep_mutable = strchr(member_name, '.');
> +			if (!sep_mutable)
>  				break;
>  
>  		}
> @@ -2950,7 +2950,7 @@ static struct prototype *prototype__new(const char *expression)
>  
>  	strcpy(prototype->name, expression);
>  
> -	const char *name = prototype->name;
> +	char *name = prototype->name;
>  
>  	prototype->nr_args = 0;
>  
> @@ -2964,10 +2964,9 @@ static struct prototype *prototype__new(const char *expression)
>  	if (args_close == NULL)
>  		goto out_no_closing_parens;
>  
> +	*args_open++ = *args_close = '\0';
>  	char *args = args_open;
>  
> -	*args++ = *args_close = '\0';
> -
>  	while (isspace(*args))
>  		++args;
>  
> @@ -3114,7 +3113,7 @@ static int type__find_type_enum(struct type *type, struct cu *cu, const char *ty
>  		return type__add_type_enum(type, te, cu);
>  
>  	// Now look at a 'virtual enum', i.e. the concatenation of multiple enums
> -	char *sep = strchr(type_enum, '+');
> +	const char *sep = strchr(type_enum, '+');
>  
>  	if (!sep)
>  		return -1;
> @@ -3126,13 +3125,13 @@ static int type__find_type_enum(struct type *type, struct cu *cu, const char *ty
>  
>  	int ret = -1;
>  
> -	sep = type_enums + (sep - type_enum);
> +	char *sep_mutable = type_enums + (sep - type_enum);
> +	char *cur = type_enums;
>  
> -	type_enum = type_enums;
> -	*sep = '\0';
> +	*sep_mutable = '\0';
>  
>  	while (1) {
> -		te = cu__find_enumeration_by_name(cu, type_enum, NULL);
> +		te = cu__find_enumeration_by_name(cu, cur, NULL);
>  
>  		if (!te)
>  			goto out;
> @@ -3141,10 +3140,12 @@ static int type__find_type_enum(struct type *type, struct cu *cu, const char *ty
>  		if (ret)
>  			goto out;
>  
> -		if (sep == NULL)
> +		if (sep_mutable == NULL)
>  			break;
> -		type_enum = sep + 1;
> -		sep = strchr(type_enum, '+');
> +		cur = sep_mutable + 1;
> +		sep_mutable = strchr(cur, '+');
> +		if (sep_mutable)
> +			*sep_mutable = '\0';
>  	}
>  
>  	ret = 0;

