Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40EB66B5E;
	Thu,  4 Apr 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217955; cv=fail; b=tdqYmG2OHCsMQTSsLDpD/sGAesmB3xR0Gv3R5J94gjhNusJCjJwTOOMnkeo1cGKm+yjB+vi7JJLI6AG0CkyKVU+XrOcRWRTING1ECa5n8YpgJz9AbaBIjQhQIgzk8RcxxtzLIw3kCtqviv1ZRrKpjJTj32BxFuZ/hVdGDpCNg54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217955; c=relaxed/simple;
	bh=4o+s/OfeU+YRLp8cdSurzAK+M5OX3fq/LQX2aWfed8E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f/oqRo/h0UjIC+izOOxGsdpRnQCHvnCI9uXqy6FXFa4knXSvQWdaYhHLK2eZnzeGpNi2Kefs71sVqzv+Y2z3E5zfEyv7pkRuS50PRTIz9SYJC7eQOtYvlPKvajwQSSq7WORejf0Dkun701ZaSiSt1yA52BGNt8NnTtXfPs9Yahw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kproq70g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z8IJk5eL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kproq70g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z8IJk5eL"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433NO0Pg008091;
	Thu, 4 Apr 2024 08:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=23ikdf13uupIPe1Bft5MOHCrTZuLzdfxgRhCwLrYE7Q=;
 b=Kproq70g1kf3g5qX4X0k7K8sx2EfnYR2bda1r789aKgWLvq1sHPTyyk1WcEndijhFx6P
 LmNPEVHke/SF+YJ6kX++Cc8AbJzGsyTBKyP7zhvfOVxrF36KTI9qbG1uRkUuVAYRLzbc
 myqaFtHdowfGo9LheqpHBsdatUns0UX6/56NUnejCoaraacDFtdvgk+L5QE5BCLu+gpF
 joDQMMjfDkCu8kghr0S+QQFLrogLqpxwHiGOqCGXHDkcQzB8NZqI/GNuIjN/O6cKjv7K
 XFPTVbLt59/nber4CeHARM02prhTuyiMPyan/iYjkC93Eik5/FcpIP4tW+h22aF8C1mA Rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emtgnxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 08:05:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4347thTT038961;
	Thu, 4 Apr 2024 08:05:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emquwb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 08:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1kxVqVBTou43VyJkFKNGtHgrCMVMRB/+M9mIThosPXC0Pippd8ERQynAnF0+0M63EAwPA5X7xQVa3NEQ1LWFruO6uu5dQ+7ps/idezcvbAajeKH4SkEHqC1S4aFW5gCi/ze0DXlpToaH0ECqpHZ9M8uUtOm2uxJ0fBUGuR8Q0j6tHXJDGzAujspbJF+c4GPE5sZM13EfGjLDCUE6sqvhFYn4Kg7Rrfdh4UlNdoqPnOqaoQ2Q7ah/PDlniKjuV78oJeBOaL+5GZwWS+ngEcnzvzftf6C1+4kyiwdRhP3PAyQT7BYUKSFFSgv4qayWCIrvIaLWk+TB/3Z/0jebIPPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23ikdf13uupIPe1Bft5MOHCrTZuLzdfxgRhCwLrYE7Q=;
 b=hAclA+t9tnF5MzC7tnzS8sy2wC3bo+QVIVIdprMrxcybu3SuSjbm+yBk0pSVKS1nTj3JKs9zoC4YrxNb6GZsm6UsrXxxUY90QHy4lX7LdRC9zrUH2b7oU3KxRbhjkLx/gn16U0gLJc2I94DDYKxTkZpvK3f5BDG8H0RKLoXV+0eeqJZzZkGmduZIrvLQz/eWHrwjI644Hil8yAmUocFtWftMh4lTIFlJ2H5aK8VxOy5SWGlPCUUVjZypwmgb6VWS2Z1K/+VfaDQKV3YYAaDlnPew8yHrAxRUOmGJq9laMSJJMyoQuWqc/WMxJxzwsdlcaQK/tK9NUMS6OcUYDrYBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23ikdf13uupIPe1Bft5MOHCrTZuLzdfxgRhCwLrYE7Q=;
 b=Z8IJk5eLEYQuSWjCI2o50sibFEM+tvBtbWgZ/afmx5WwSWZqmp8u49XGHZRRnyLZW7vUO1rRCIe/zRx5AEIa4GcqNi8BPn91zqGta4ALKS3S0zXCtJKet8OuC6MJlIv7Cgj9dgSODf56EL3uLG+EN5N1Ll5DUS4Bsq4qawNkfsg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 08:05:38 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 08:05:38 +0000
Message-ID: <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
Date: Thu, 4 Apr 2024 09:05:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
To: Eduard Zingerman <eddyz87@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
        Kui-Feng Lee <kuifeng@fb.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
References: <20240402193945.17327-1-acme@kernel.org>
 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0216.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4762:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aKF32Qa/W6WOzIrc146NEK/on5nV0YfnMBYQxyXDxu2nm8P5snbaUKBov/eVNE5gvg3ijyY1Rm9kuA1F5NTdHkzMntvoAaSWsFQ4+VqnhMGaQYwstpVTVAGFXRROS91EUGmxmyWV1z+g2uqUWcbeQu3e2c5AMd1LhG4XZeByjSrbN8Mi9JP9sPhBofetkurKlgExuKjAzgTHXIjI3S58mHeNIpOH6IJ1Pbxt6oJxKenabDtrPNqOnD2HlUhwzTFiGOcAI3mNf7DkpbFWhevJygQOJTvHJ0+bIFv/XgX53/vAnq8yE8sI3+42fbQf+oxPLMjy/CkYQD10kuaxNNdQcjaq2RtINZ9g5l9Ts69vb0HaDTVwkvoVho+mvOEgdXIdAtBNwGfFJqaMLA7TTLKFqcie8kBMMtXL3OhG3rxxs4YIFxwOWm+EjHvzkTLs5eS7KRoPEBoooJnT3TRSUsZdwOUCUALSRkztc/lT+j6aCopSafyB+WgpNVKqGqmP9GqIk4rfVEL4eJfxPhWLmsSE2GEIeiU+PD0I3t8n/MS9I2EawB8PDqLglm65JWinne2sqDFW+LH29eAKjObjDL8Aw5Oz4OcYMnCAQ/cHfbHL3BPtWRckO8GrJkbT+YVPC4fddN6gpvQniIvK/tYZ1p4cJuKxoI2aOo0lDrQMUKJr9sw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHZIUGZPck5PQ2pBTWNmbmhpL3VzRWIvaHpERVhRcForSTdEWjVJZTZLSGg2?=
 =?utf-8?B?V2cydGpqOHcxcW9rcVhpQlBNOW5QTnV6Ykc1bjR2c2FUYTh0R29kWVJPcXpp?=
 =?utf-8?B?VmI1OHFyK245RGRVUDJxdm96Q2xkSTJudTBKRncvcVZvdVdDcHZKcTZyQ2JU?=
 =?utf-8?B?ekhvb253MzlhMytvVExQVUZPK1ZDNDZLTFE5cmJEcE9aVlRWU2tROHRnQUF4?=
 =?utf-8?B?TlBXS0RUM0RNeXhsZ0U5R1lyT2N0VSswNHRRSWpFZVdVclR0WnptbDdUNTlN?=
 =?utf-8?B?RzMrbE8xdFRGZHZQeUVJTVB4cll2UnAzUVUvSnVhTUNFa0JDVHRjUTF3d2ZO?=
 =?utf-8?B?dHBQZDFYYmM3UnRVVEdHTXBWU3IvM3FpMU9jTEZvKzA2VVV0STE2c0hMd3FR?=
 =?utf-8?B?M2VGNitIckxxcTBQTVp2OWtHSnkybHkray9RYVVJZHVVeHdRQ2RwTHgwTXE2?=
 =?utf-8?B?TXBHNmJtazlTb1lsMFZvZUYvRGVJVkt4dUJUVDloRWprVW5CZldyTjBrNjF3?=
 =?utf-8?B?clhMeTR5WTI3dXpzTE1PNWJZTzNWUnZWS29jZlpsblVUQWtRMVVrUk1nb1Vw?=
 =?utf-8?B?TGQzVWZ2dFdUSGRTU2NwWFdHNCtuMDUxNnhSeE5rcDk0TkpzQjFoc2FpMmFR?=
 =?utf-8?B?dVQxbkxTMTV1MmVqUDJpaUZsb2Jsc0Roc3ltNlNYM3ZDRTYzeEVMZ25rVThM?=
 =?utf-8?B?Qmp2a0tuOU00YjFKdDFkYWxNd3JMNDRMTW4wbHJPc0NJN1JDYUtaWXRPbVRW?=
 =?utf-8?B?RnRtYWlHNGhJWFZ4QVUyQ3MycVREZ3NLa1ZwUXF2bUhZaFFHazMvd2FPZnB1?=
 =?utf-8?B?MVp0YWJrN0g4bGxhd2U0K3o2YW9VUkhnQXI5TWZITlV0dGVQbDhmYWk3SUxC?=
 =?utf-8?B?RmI0d0RhZGc3emRGY3g4WWV2UVlJa3ZTRGE5QXUrYzRDUElQS2xRUlFka3V0?=
 =?utf-8?B?V05WZjB0a2pJcUZtR01BNmYrVWRGekRLckhFSncyQnZ1WmFQWjJYYzFjSjdJ?=
 =?utf-8?B?dlpsWXhhSGFYZEh5Yjd4VkFITnJOL29ZbnR2SzdLRnpyUTVlZW9BNm5ObGUy?=
 =?utf-8?B?RTJjbDBTN3p1SE05KytjTEovZmZINWJIdTEvYTFmek5HNjlvNnh4MTBDSzVM?=
 =?utf-8?B?Wlhzek51azc5YlUxWlR4MGhJK2o2dWJWSXYvOGdzNmVnd2oyZ2N3WXkxZk45?=
 =?utf-8?B?RFhjejhLV1lJUXYrNXFrdHBBMVMvRWJnQmlnbVRjbjM1bkkvc2FSbHFPYndu?=
 =?utf-8?B?REdKOTFsM2lyR3QrZHcybHdKaURTZnJUUW45ZUEwODFPNExHbmQvTE9tYjhG?=
 =?utf-8?B?Q25KQUtRZWVyby9OdWUwc0NzK0prVjJGQ3plSTUySG1xc2F6RlNza3EvdEpX?=
 =?utf-8?B?azlxT0VaRThURnF4WUpIL3Y5NnVhUEVZSnRaUDhqNEZXcUxsYzdSOTFsVGlL?=
 =?utf-8?B?aForZjRVM09BU1V4TW84aDZDQWlhZGdiRjg0N1VrdFgyRDlmQVNaZGxGdjN6?=
 =?utf-8?B?eExWWVBpa0dJa2VhSk5RU3FSdzNzOXVBMUFBaHJLejVIZ2xlZFNvQ2dCZlYw?=
 =?utf-8?B?bkpzWjd5c0dZQ0dnMDlJbTVnZFVLZGk1Sy9PVFFianM1UjduUGI3amtkcjV4?=
 =?utf-8?B?eWhWZEw5bGQxU3AyZS9pVjBmaTlRTTAzdzN5WlBzbW02dTJEQW5qV0Z4Yk9r?=
 =?utf-8?B?WVBuTkV2bk9kVjRRekl1Q21DbTRuZ29pcExLM0tQRE5qczBCSTBFdmVlNzd1?=
 =?utf-8?B?dGtHcW1ocUtGcUF4RzVlcTBFaWI0R2I1cFFNOTlTOVY5ZXE0ZEJuR0xOQTEv?=
 =?utf-8?B?TWZzYTluaU05U3dsTEFRNVltTDJNcGlROWp1WVFvRVNGMVpKTW1WRGhaWStC?=
 =?utf-8?B?V3JOV014aUFWQWUyNlJiZWUzbk5aK0xlSGZ2eWMzWkFtb093Z1V4K2tGUWJa?=
 =?utf-8?B?bEZyYlR2VVpGS0cxT09lUFo0QnpQclFZMHUwWjhMd3RNeFgxcEJRdlZ3Qmsr?=
 =?utf-8?B?TTdrbElPWXJXTjNsbUxaT3RKU3JMcEJnT001RHVpM1JXKzlOZUtOZHM3Y3J3?=
 =?utf-8?B?dmhqdk5TeW1YQVdMK2wrSFFtL3AvYlpJSi9Cb2p4Yy9oYVpNWU9GbzlTMDUw?=
 =?utf-8?B?VEZ4eENBOWlwNWtZYTJDTmhibVZwUTdPSWk0Yng1VTh6bS9WZ3lhdVdHK0Zm?=
 =?utf-8?Q?FWg3gG6RoG53wc1/igcz1eo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pISWLP0hLaxSh9y6Kzv7x+z1RRjnIoWrcM/Pf/pO6hCY/GFyI5IPJI6VeCTb1+UDS1+2UjyYftwpfneWD3Mc0p3oFVoWfA6Fd8amXbpviJ9zwhbd1wdGKG6B6rJlllMVgae+4kg26Q2YOYLID7KaoYbuXo5PeBmrvPqLJdIEdq3LlzCm56CvxjzUhkfAHdt9AhJqWhzzXM81RX5ByVdDe8FagzRLR+N3+O7LjBsabj1qHAhahNzukkSIVBOE8/dEMHbrHn1JawG6EenTKi8axr1GGk978FkXD6WWAp1llsYoqYdXl61Dslg2mF8fSyJNrLqd0dA6KE59k0CgJgfQuBAKaEJ4PF2nFZ/UgA+N1u2wt7NvHtZSiNCQc2cfVbPGzX/YBjVoxGs2D6zm98O+tNtlMkBgPg10xB+lRAirGJ3s5QJOm3dVYWrvOZELt5Xul0z4T47QdQoskQHqB8YmaK7wkM9xY/L9wPL8xEMXNjU9Ok9QHRIgCGTVmYjlU0TxagfwQWPjmvz8X2rGzYwxt8ZWoVdbTqDxT0qXE6rUVRpmmRI3z7VP2te1EE+BN/7UDQKB1hNscfI2DCdCTUnkDkR0g21R8X0skoV14qrETVc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f5322e-612e-477b-a82a-08dc547e0386
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 08:05:38.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWQoNZEnsy6yEepcnIU0dEFOZeu/QZ15CIWCz427o7NdK/44JZKJwaKvB7BmFzq1Zid7HcOI1U4e+N7vqGKQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_04,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040053
X-Proofpoint-GUID: cdq6TByKcKs88s5yTpIl_eSLgPkfxqmr
X-Proofpoint-ORIG-GUID: cdq6TByKcKs88s5yTpIl_eSLgPkfxqmr

On 04/04/2024 01:08, Eduard Zingerman wrote:
> On Tue, 2024-04-02 at 16:39 -0300, Arnaldo Carvalho de Melo wrote:
>> Hi,
>>
>> 	This allows us to have reproducible builds while keeping the
>> DWARF loading phase in parallel, achieving a noticeable speedup as
>> showed in the commit log messages:
> 
> [...]
> 
>> Working on libbpf to allow for parallel reproducible BTF encoding is the
>> next step.
> 
> Another option would be to apply some sort of canonical ordering to
> BTF itself. E.g. put all PTR before STRUCT, sort same kinds by name,
> sort same kinds by vlen, etc. Something akin to [1], however this
> experiment has several flaws:
> - slowdown is much worse than with your patch-set;
> - I see a small number of functions with identical names appearing and
>   disappearing from final BTF.
>   

Could that be the handling of functions with same name, inconsistent
prototypes? We leave them out deliberately (see
btf_encoder__add_saved_funcs().

> I'll try to figure out the reason for slowdown tomorrow.
> 
> [1] https://github.com/eddyz87/dwarves/tree/sort-btf
> 
