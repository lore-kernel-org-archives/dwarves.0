Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDF28D8E1
	for <dwarves@vger.kernel.org>; Thu, 31 Jul 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953051; cv=fail; b=r5zBgzuFsI92jbMBkWXGpvBkV6saR3mN5nzJQMg30E+/WNzgABUaT56JeJzmB+zrcP8htX2U/EoNLDiShnErCABHmh5ST7b+VJFZsPJHdyqHaB2SCLJMHeDGPoBahjB0Jr386WkDrHqZwaX5nvbLj4lSrxiRrOGboTcOdY0f9+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953051; c=relaxed/simple;
	bh=YQ28MgcEi6X0QcFMdW/FssQU42Xic3OdeeO96sY3rt8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vGdfQLpZEjiqu6r5hb3Sv+xYwJrXJIWTTzUkclA9OjUV3bI7S2CJN7INW8V6rPkXoXt/BeDHhSyOG+xlvT1PYEQdXQ0NoyZgu3AH7pzeEv0aF9a8GAGKKyPj3v0U6Zc8KYmNYGgf6l6jYBRaJRGISh04cMBwBFEhGrUnHXNx7WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AHR+A06M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bilDfArm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AHR+A06M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bilDfArm"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V7C3G2009871;
	Thu, 31 Jul 2025 09:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Fhnor43j04p3MXscdzhRGejAk+c51kA6QEfdheQehJI=; b=
	AHR+A06Mux4XNGCc957R5142tCLdRwa3Si0qltvdC+axA30y9ic1zx8G7vkNVpfC
	cb0jL/2V8PHdqRwnIJDWUnK9XilLauM6AV/9RMzJmjLHDi/H6W0E84T5R111mKpr
	LyDAKtnlzVRTB927Z3CC6ityvs73CZsc8SY9x5/rU6NPEJwlb8mxArzehpLakfYZ
	GcBzQSWv784SEHm9/GBLUTNh593laI+DEXhTrn5p8Q1bF3GZpiAP8tg3EVzvZX7M
	ltX5pXxdQagdKaoqHdJKSdMeSy6hAfuhXqt4T0bpy3H7+2zUS3CYwIA8lsoVmi5j
	kwBp7N2gHQALsTx708Ug7Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 487y2p0jjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 09:10:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V94FlR038626;
	Thu, 31 Jul 2025 09:10:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfc04rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 09:10:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebCOMZ9tiRE+t20k0Eh1R8D/6BfyBCGdDsLkD5n/oT+TiL4UzVXYya7/WSyx6/eQuhH7oyrUZQcON0W5//KKroZgB436LwWiLQyUozQ8hsf89diRRrua5eS38Vm0OsMhx31hBAm9/FgdgMePlHY2lo9hwlbV7+LYKMN2KUtiAhtocG7H6t4sa+r3Q3LULIGkoIzYzOuXc78g1XSzp8VYOi2AFbFNZnxIBikpaCJAk1B9A9/qYVHZ77WQBXD8ODqUgrtTTL/EefqYjFFH7Od7AV1JhLnnxObILyU9cuOoWltjHGabVmmFNvneICTQ4U3y2tbiWKwkOmseCWNNKdkltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fhnor43j04p3MXscdzhRGejAk+c51kA6QEfdheQehJI=;
 b=HiJwNMBQxiIqlMaiIb/4UvoAf5FmU6C79k2kiSenxy8vRTYS2X/WvEFLnq8LGIJ7AgKPBqXx39DHfuauYjbh065wh7Ynp9eylWPbt7t9SYXPTqEL6MUWQyDsap+iXXREyipaQDIDsaqP2R+Auu+PNTzNgOj0Y4yYU4jEguFnEc2tZrv/r0FqsLs+5NMC7KG/h+TAP6h5B4htDPmygvSd1b/iDMyMTdoAcKs07f9PtEJY+4+7W1NUt6xSPii7JfhWleYwqhzoWHnjzTtB7I2zW+8fTnIM2JhynufGHUwy4aBlkT7QkreUgHc1gAYk2kbNYr5r7OctdR9LIahD+9tiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fhnor43j04p3MXscdzhRGejAk+c51kA6QEfdheQehJI=;
 b=bilDfArmvIpkgtxvMly/aoTmYGYeMY4H4W4W7hA3RGn9OhaKDrAXih/9B+zCQcIggOLhS8aVDkJg7WaxnXdbxImdvs4dGSvXlGXWGq+wrCjyct2ww+5P4lUstbTwHSixo4euxqr+fR6UEVqtZviZrmeXAWkqDU+qemtCsq5KpU8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MW4PR10MB6418.namprd10.prod.outlook.com (2603:10b6:303:1e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 09:10:32 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 09:10:32 +0000
Message-ID: <150ae6e2-08fb-4d47-84db-ccf1bd3996ad@oracle.com>
Date: Thu, 31 Jul 2025 10:10:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pahole: do not return an error when printing only a
 specific class
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        dwarves@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, ebpf@linuxfoundation.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20250730-lsk__abort-v2-1-fcec3172a878@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250730-lsk__abort-v2-1-fcec3172a878@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MW4PR10MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 6543c367-040e-4674-944a-08ddd0121a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czUxWWcrUGtVd3ltZW9GOVNtUFh6bDF0UXNqNDhRSTc5Tm01STQ3WUVGd0lN?=
 =?utf-8?B?aGpFRlI5MUVBNTQrMktVZHNDMkZwbzNmYUJoTnJ2clIzb2ZqSFJJVzg0cWkr?=
 =?utf-8?B?eVpjU3d5amxwcFR2K2IwTlFlZm1pa3ErL0FLMGtFaXdrSVlZb3l3L0lNc21C?=
 =?utf-8?B?QkRYNHU4RHJGZDJaT29DbERmWndFend1bTZGZHRLMFZBbEdiQXJyeGdvMm0x?=
 =?utf-8?B?RVI5NkNndExGcDF5NnN1MFFEaVB4S2k3U0FocGluR1BVVUdndlYvaWtSRkI2?=
 =?utf-8?B?NWtMRjFUN3dvekVFU1NVSHNPK2VYSFNQQTlBN1c5V2NNazNOa0t4eE9rc3Fy?=
 =?utf-8?B?WnA4YUxEQnNvYXkvUWN5YklUdk1ML1ZnZ2NwNXl5Q01HbHZab215WVV0QXRH?=
 =?utf-8?B?UzRHZWpnbVA0WCsydTdOWHM5cFpUVDRGNkxxYThHNzhXTkJHc1RobjMybndl?=
 =?utf-8?B?TnVsN0J6OWJzdmo5MVA3OXhwQlgwN2Q0aWJJMTRmeHlTcXZ3Qy9OdjRXUnRQ?=
 =?utf-8?B?ODEyNTh3aEx1TGlnY3RUZnowbmFZTUN2eGxiaUVCZFJaaUorVnEzVU1TYXFZ?=
 =?utf-8?B?dnVFaTMyWng2U0c4SVJySjBKLzhtM2pqNjZwb2x2Y2ZzV2pReHNnbk1XU3Ja?=
 =?utf-8?B?d0JRMGFsUHFieFBxYTZsVmRSQlRwc3lvTG8vS1IzNWlGcU1NQzNmU0RZdDBG?=
 =?utf-8?B?NHRSekwwWUpNNklVUlB1cDE4Z25iZ2pPdW9qdFc0cXJHd0cxS2ZFMEM5NzF1?=
 =?utf-8?B?ZEgyLzRXV2RxbmxUbkNDM2ZlZmE2QXZnY1NwVHdMU0pJb1JIaitLUXd1eURC?=
 =?utf-8?B?TTYzQ0d0NkhXVlFKdnJiUXlpWlRMd0xGL29TV0JCTFdzWlQ3eEl3MzNHNmVB?=
 =?utf-8?B?RmRkQnUraEREaDdHaXJiRkpuQ3ZXdHNTSVZFcjE4YXhlcVhPTWwvd1l3ejEx?=
 =?utf-8?B?U3Badm9kaHJvcGRqTDhuMDZkWFRWWmo3SXVlcE1aYTFrS1ZCaUI2QjlqZm0w?=
 =?utf-8?B?aDUrSzhNeldrQ1kwNHBEeVE3UGhFazNwZytIaGVUTWszVGFyZFNUOE9Sc2NI?=
 =?utf-8?B?L0FzVGpveW9qSTlFZUZqTHo2MjlNbzRaenEzZkQ4QUJzZ2RqczN3bVFpM0xz?=
 =?utf-8?B?WWkxSlcwOTg1U2lFaG52T0VkQlZxQU1XM0Y0SmQ0MXBvRE93cUhaVFlzVXJs?=
 =?utf-8?B?SlUxMFBIUUxpdGlmVFFNOC9QajlEZGx5VjNKMGpMbTBvaENZb0x5aWZhcmI0?=
 =?utf-8?B?KzBFQ0dTZlhRR0ZWZXpHSkY0cnV3ZzN6U2F0Sk5Qd2cyS2dFQXh5OWJudlZ2?=
 =?utf-8?B?TS92bStxZEJCeEc0eTlNMWZ1ajU4WE45L2tXcFEwVnkxQmlpZ2ZseWFETktV?=
 =?utf-8?B?MWhNYkIycjZaSyszK0pnQTVMSmJIVlRYVnBUVGlLd0ptQWtBMFlWZkViNkJS?=
 =?utf-8?B?S2Z1OFNDOWJhM0Z2RzlvUURQOHp0WVZiRkY3VUJIYzUvOXpJWHo2azZjSDBz?=
 =?utf-8?B?MHVnU1BlOWdCdXg2MDZ5Vmloa0FFejdWaEZ2Q3gyZndubnZUd3IvMFFyS3dw?=
 =?utf-8?B?Zi9mRC80MitoaGJXZzhMU0I5SzdMYU02SG9Ea05jTzU3WU1GWFpwLzJJbXl0?=
 =?utf-8?B?UW9sdURadUpxWE9laFlMOFFkanVIZUZFTXJvN2pVY29mTHN3djRPckJtc2V3?=
 =?utf-8?B?clNhTkFiaGRWdGQ4UmIzemNYWHlKS1ZiQ2FFNFVHeVBTakhlSFhGN3FZQk5Y?=
 =?utf-8?B?bXFXZXNkTFk2enYyblBhb0VLSWpTWUlHdmkxQWpHa2dTMXE1aGJmVTJ4ZTBm?=
 =?utf-8?B?Umxqb0dySTlRZ3k4d2wyV0tiMWZhUDQvM2Ryck15WllXajRsN1pvaXJEREdJ?=
 =?utf-8?B?MXhDbDJ1V0FMMlcrd05qTW1CeDR0SkpxVVlvdGhueXN5RU1pYmRDK0Qzcmln?=
 =?utf-8?Q?1R3HfI7lZeM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk1vYWdJOE5Kbk5MY0RPVTVpRjI4N3l2TjV3c3JnVHZNUGFoTnFMOHNraUhH?=
 =?utf-8?B?OVVVUXhsK2VyRjJQMzhkTE5WMGNBRmI2U3U0TWhLL3ZCVUZ0dUdubFhERFA0?=
 =?utf-8?B?M1YxMS9TL2tJaEYyV0ZhS1czL200VWl6NE1oaHBLWTlFaEU0SjdsVmlRSFRH?=
 =?utf-8?B?VktOWU1VZVppNVgyb25penk2Y1dNRDhxRFB6cmROcmF3QzJ1b3hJMHk4Yldq?=
 =?utf-8?B?eTdaci93dGhocEkva3I2Y0RkWnp1MzBjcXhrRUJocWNZVHVCbzgrdFYvYXpX?=
 =?utf-8?B?T3RuZWdscE1HNWluSlg4dk90TFByVjcxZERrbW1VTG9PMGtWbk5FUXJkaVAr?=
 =?utf-8?B?dFlSRFpldGNvV0ZVYmJvRzU2bUlDWCs2NCs2Y24wSkZIdmxMYnEzd2x0ZUxY?=
 =?utf-8?B?aGdWK0Yxd2ZUWU1TRVBhZkhMN0VjbkVFekVFc2dWVHpvVHVQd0FnZFZ6MWp5?=
 =?utf-8?B?bnZlYWpYT1drV2tISmk5SFgweStqZE95Ky90cWI0VFVBNmIvcHZPZjdoZzh6?=
 =?utf-8?B?K0tqcmhRbmVQTXlxemFTQ0lrdGsyR1JocVNDUnJWWE0xMmhnUW82T3BtY1p1?=
 =?utf-8?B?TnM2OVhkVXcweEc5SUt5UHpQOXlOdmVvUkMxZWV5ZVVSNzU0bnJscFRUdjFt?=
 =?utf-8?B?QmhRVys1TUtCMEk3bG13NWQrZEZpREQ5NEkveUJwNEhIWHVZS1RIZXp1S0Zx?=
 =?utf-8?B?enZQYlhCcFFwYk9XRVNmMm1IVEZjTU9KdUdlaDhSNGJKaEpDakdDV2M0cWxO?=
 =?utf-8?B?bVMzZ1N2eEVqV0ZDajN5R3d0bDFWQXJNZVpPZzF4Sk1rOFpDcmM3N1QrSVhL?=
 =?utf-8?B?eFcxUEREQ0FJQ1kwSFVHYzdJZnh1RHVGYTVleXVFRnVaR3FVT3lpTXl4RUc4?=
 =?utf-8?B?MGtpYnlZY3k4ZnZJMUEwbDNvblRlbU45VnMwdlJMYThRTERYNlovTWFtaWxy?=
 =?utf-8?B?ckdHOW9MSTAyMzRxSk1KamU5M0thenhuMUtEWERRbUhnZndBb09abCtFMVV6?=
 =?utf-8?B?QkN4NG5rRzZCNHFVL0tHRnZHcTV2OHZVOTBrcDBOSHI3Zlh4Tjk3TzZzazVI?=
 =?utf-8?B?YUt0eEcvcDkxejRpWmNXK3FmbldYZ2puYkFEZkZIbjhHRmdvMUwvdjMrdHJU?=
 =?utf-8?B?OTM2Q0hoTEFIWGJiQ3JISWpFOEhvU3cyU0QxQTZFZjlxWjBtbW44N3I4ODB3?=
 =?utf-8?B?dmF4WjFBcGtsN1BLakVqdXBPUWd0MStvNTBVeHJXQVN3b2drNDB5WkE1TDN2?=
 =?utf-8?B?N1ptR01YVlNzdTQyMlNuMlh2dFhLTGFzdDNzZmVZUlVEa0JSUU91UCtnZUJ1?=
 =?utf-8?B?WEF5ZHFBMmZpaVlOa3NONVpmS0pOcVl1TGQvZ0s2c3dkZ3h1UkIzTldVVFQz?=
 =?utf-8?B?bVJ3QlpHbG5DakxnTktudDJqTUhpaURnV2ZSaXhjTVNwOGdyL3NianRCMktp?=
 =?utf-8?B?WDNMTlU3ZjFpUWtvZnVtelZZaU5uOGFOYmtPclZVbWEyVUJsQlllb0hCYjhJ?=
 =?utf-8?B?LzFZRm8xZkFjUHltWjdHL1BLQXAzSEhkRDhYQ0k0WnR4VlBGWWxCbWVqdE5V?=
 =?utf-8?B?MFM3R0VDT1RTdUdHSkJIbnRXWWR6ZDFmbHRhaGwwT3RINWl5WkxiTzdDUWE0?=
 =?utf-8?B?RndZeGlpNlphRXE1ZXRVY1hhWW04YnlyNUhXTU1ha0JMZFZnbkh4MEFnZXNN?=
 =?utf-8?B?ZUN5cWY3RmxYbGx6VUpHSnlyTG9wQkxHQldiSjlEcW4yNWZrOFFvRmZrczZW?=
 =?utf-8?B?cUVJaGEwbE9JYUhwYStCRkpqeWx4ZXpwMUl4N3pnQVNLNmFDcTdLZzQ3RE45?=
 =?utf-8?B?RUxZUjJkdEc2RjVZbWxpcXpPdU51NEpuRU03eko1VkNodEVDSTBLYUoxMEQ4?=
 =?utf-8?B?K0pmekdGQUFTUG9tdThzVFF0SWdJaUVBQk9mdUM3aC9oZXBEK0Jvb1RYbmF1?=
 =?utf-8?B?aTFqOUdQUW15TDllSlAvdFlYSzNvVVJuSmc5aXFIemVjVmVtTGNNVlI4V2dB?=
 =?utf-8?B?d051dk1kYnJ3S05zN2NIVzdrOEw5d1ZVUUszNVdoMGlvYTVyWVd6SkhuK2Iy?=
 =?utf-8?B?Y0plL29CNFhVZEVwQ0hmRTM0M1JNR01jQURKeUU5V3VXeDVST3BZK2RvNDZZ?=
 =?utf-8?B?UTJRdDVsYTRDazhnWnFLbkgwYTRRNTlTQ2dWYkFKa1N1QVpNYzJ5M0phNDZ6?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vZSrRHbK/RD/gxlWCu+5Ipu+lADeaWkoXr/xyS+TjgvLzIiT3vvgIFwS4mWwrUMgzrFqzzJ+qwQZ4wMXWtcNtI7cwulIrWPCo9ERRl6lXLW6UjYMkzYw8U2siKUetqVpSI95kMq07WL+pi4aZBcXW6AjfNqqnqLA8OR99S3ysoLLE7bSch907BH1HYOqeWhRZoFsZBWqp3cybAX9iZIRzxj92wMFhBAr/ZaZPoQ1GyBt1rckP4xbdpYu89NoX/LsTowa7LCx1fhSXiutwSFJBCeNd5VpVjEvi4vyBBAeDcSY4p551Pu5uWg/aa0UcGikrUrz1+78GmRFXOmpaEWqwWgFV5Gb9F0IKlVUlDhmp+y/7GyRNqeVSc+5aidy/W8sx3aixMkNBgK0dyfASU9Az4fmq3pXNGXB1o2Y1eum7t5qKS8JwckHgvw6K+shCpzuX+IzZ84vikOUQ0b1sipWxVxqwFiKoQ9DfHJEfZR6fYv+S/G6xQbQp+Ij74V3RtTNbDh1pGvm+Lpl/4hl/yVQIlu74SLj6alcAI+k1TKqht0wIonEleQjz6utLF+POUTIAY/reSpsIVJeOS9K7ESu9k1zaaM/a1gE/4u2mWW4ZUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6543c367-040e-4674-944a-08ddd0121a2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 09:10:32.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Coto85d1KYjxRouSuMhCsWPWtkNPtzVy+LGsfwfbcMclrkoI+z4xjPF4Y3UO7AgEepw+M92sNJyXPHjMvlVDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310063
X-Authority-Analysis: v=2.4 cv=COwqXQrD c=1 sm=1 tr=0 ts=688b330c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kljl6ElNen18G7mm:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=yPCof4ZbAAAA:8 a=azaWCVoMocoiOZPyPqQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: ksPMIOK9r3xAJoz5oFv6mR7RS7Qj0Lp-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2MiBTYWx0ZWRfX8kCfgekG6J6+
 4HYj95DO8Bu4EfSoC3hQGIxM+XIckqcDhNt6H5kV0xFBDnyGY0tymjcp+hcHmWOVespAx5RXvaq
 XQoyAR8LSrZ4ISpQSoRTWOJsY8voz2XTwXHvDyY9ycjW7xamjtWpSgqdYToVknuKyt/+xparUWS
 0ngi369DrjNtwG1pfprtn5C1mg/JiFz2Z4c6TZaZ9AWIbNWG9vP+lXQg+C2xji8qiDMZeFMdvfR
 kz6sp+bF6UpiWbGisxxGSmcq4RVZYbTEdQPVDff/P4RTksudhU+TeXvN+PPm+NLbASvfH/eo1Gh
 5YJXyePWIxTQpINp5AcYiwgpaQMziJPohAmDweaLNnrJIowx4zGkGRDUiqBl439jFvO8I5MGzv9
 eEz3HoI2fChpEyFCIVB7PqzJVIWzTQnDBDvFVqIlKNs+jweeAS3e+wzPgNI1wW7+/Tqp5xIw
X-Proofpoint-GUID: ksPMIOK9r3xAJoz5oFv6mR7RS7Qj0Lp-

On 30/07/2025 16:26, Alexis Lothoré (eBPF Foundation) wrote:
> When trying to print a specific class layout with recent pahole
> versions, we get an error right after the expected class print:
> 
>   $ ./build/pahole -C test_bin_struct_packed -F dwarf tests/bin/test_bin
>   struct test_bin_struct_packed {
>           char                       a;                    /*     0     1 */
>           short int                  b;                    /*     1     2 */
>           int                        c;                    /*     3     4 */
>           long long unsigned int     d;                    /*     7     8 */
> 
>           /* size: 15, cachelines: 1, members: 4 */
>           /* last cacheline: 15 bytes */
>   } __attribute__((__packed__));
> 
>   pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument
> 
> This error is due to pahole_stealer returning LSK__STOP_LOADING when
> dealing with a single class and when it is done. This LSK__STOP_LOADING
> is then propagated to dwarf_loader__worker_thread and interpreted as an
> error (and turned into a DWARF_CB_ABORT). The main issue is that this
> LSK__STOP_LOADING value is sometimes generated by actual issues during
> pahole stealing, sometimes by "nominal" execution.
> 
> Add a new LSK__ABORT status to distinguish between those nominal and
> faulty cases. Still let DWARF_CB_ABORT value propagate when the stealer
> returns either LSK__ABORT or LSK__STOP_LOADING (so that any other
> running worker is properly asked to stop, thanks to
> cus_processsing_queue.abort), but also propagate the LSK status, and
> return an error on DWARF_CB_ABORT only if the status is LSK__ABORT.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

a few small things below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> Changes in v2:
> - rename out_error to out_early in dwarf_loader__worker_thread
> - Introduced lsk_status in struct_dwarf_cus, which hold a worker LSK
>   return status
> - keep returning DWARF_CB_ABORT if worker returns LSK__STOP_LOADING
> - in cus__load_module, do not return an error is lsk_status is different
>   from LSK__ABORT
> - Link to v1: https://lore.kernel.org/r/20250716-lsk__abort-v1-1-586f31a9d97d@bootlin.com
> ---
> See [1] for original discussions about the issue
> 
> [1] https://lore.kernel.org/dwarves/DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com/
> ---
>  dwarf_loader.c | 19 ++++++++++++++-----
>  dwarves.h      |  1 +
>  pahole.c       | 21 +++++++++++----------
>  3 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index ef00cdf308166732fc0938f2eecd56d314d3354f..1b44327c0b9ef9f4d9ae120e2b6d57b531c65277 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3277,6 +3277,8 @@ static int cus__steal_now(struct cus *cus, struct cu *cu, struct conf_load *conf
>  		break;
>  	case LSK__KEEPIT:
>  		break;
> +	case LSK__ABORT:
> +		break;
>  	}
>  	return lsk;
>  }
> @@ -3439,6 +3441,7 @@ struct dwarf_cus {
>  	const unsigned char *build_id;
>  	int		    build_id_len;
>  	int		    error;
> +	int		    lsk_status;
>  	struct dwarf_cu	    *type_dcu;
>  	uint32_t	nr_cus_created;
>  };
> @@ -3657,6 +3660,7 @@ static void *dwarf_loader__worker_thread(void *arg)
>  	struct dwarf_cus *dcus = arg;
>  	bool stop = false;
>  	struct cu *cu;
> +	int ret;
>  
>  	while (!stop) {
>  		job = cus_queue__enqdeq_job(job);
> @@ -3679,8 +3683,11 @@ static void *dwarf_loader__worker_thread(void *arg)
>  			break;
>  
>  		case JOB_STEAL:
> -			if (cus__steal_now(dcus->cus, job->cu, dcus->conf) == LSK__STOP_LOADING)
> +			ret = cus__steal_now(dcus->cus, job->cu, dcus->conf);
> +			if (ret == LSK__ABORT || ret == LSK__STOP_LOADING) {
> +				dcus->lsk_status = ret;
>  				goto out_abort;

nit: I was thinking we could rename out_abort (rather than out_error) to
out_early since we can exit due to either ABORT or STOP_LOADING now.

> +			}
>  			cus_queue__inc_next_cu_id();
>  			/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
>  			job->type = JOB_DECODE;
> @@ -3750,7 +3757,7 @@ static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
>  		job = calloc(1, sizeof(*job));
>  		if (!job) {
>  			dcus->error = -ENOMEM;
> -			goto out_error;
> +			goto out_early;
>  		}
>  		job->type = JOB_DECODE;
>  		/* no need for locks, workers were not started yet */
> @@ -3776,7 +3783,7 @@ out_join:
>  			dcus->error = (long)res;
>  	}
>  
> -out_error:
> +out_early:
>  	cus_queue__destroy();
>  
>  	return dcus->error;
> @@ -3872,7 +3879,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>  		goto out_abort;
>  
>  	cu__finalize(cu, cus, conf);
> -	if (cus__steal_now(cus, cu, conf) == LSK__STOP_LOADING)
> +	if (cus__steal_now(cus, cu, conf) == LSK__ABORT)
>  		goto out_abort;
>  
>  	return 0;
> @@ -3897,6 +3904,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>  	struct cu *type_cu;
>  	struct dwarf_cu type_dcu;
>  	int type_lsk = LSK__KEEPIT;
> +	int lsk_worker_status = LSK__ABORT;
>  
>  	int res = __cus__load_debug_types(cus, conf, mod, dw, elf, filename, build_id, build_id_len, &type_cu, &type_dcu);
>  	if (res != 0) {
> @@ -3930,9 +3938,10 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>  			.nr_cus_created = 0,
>  		};
>  		res = dwarf_cus__process_cus(&dcus);
> +		lsk_worker_status = dcus.lsk_status;
>  	}
>  
> -	if (res)
> +	if (res && lsk_worker_status == LSK__ABORT)
>  		return res;
>  
>  	if (type_lsk == LSK__DELETE)
> diff --git a/dwarves.h b/dwarves.h
> index 883852f4b60a36d73bce4568cbacd8ef3cff97ea..5df1cdad9be36212bd6548e86180860daffa3f63 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -43,6 +43,7 @@ enum load_steal_kind {
>  	LSK__KEEPIT,
>  	LSK__DELETE,
>  	LSK__STOP_LOADING,
> +	LSK__ABORT,
>  };
>  
>  /*
> diff --git a/pahole.c b/pahole.c
> index 333e71ab65924d2c64771be7d40f768f02e9a0f0..66448fc430c19e5137a8467026d35d2ba3125e4c 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3165,13 +3165,13 @@ static enum load_steal_kind pahole_stealer__btf_encode(struct cu *cu, struct con
>  
>  	if (!btf_encoder) {
>  		fprintf(stderr, "Error creating BTF encoder.\n");
> -		return LSK__STOP_LOADING;
> +		return LSK__ABORT;
>  	}
>  
>  	err = btf_encoder__encode_cu(btf_encoder, cu, conf_load);
>  	if (err < 0) {
>  		fprintf(stderr, "Error while encoding BTF.\n");
> -		return LSK__STOP_LOADING;
> +		return LSK__ABORT;
>  	}
>  
>  	return LSK__DELETE;
> @@ -3230,7 +3230,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
>  		 *
>  		 * FIXME: Disabled, should use Oracle's libctf
>  		 */
> -		goto dump_and_stop;
> +		goto dump_and_abort;
>  	}
>  #endif
>  	if (class_name == NULL) {
> @@ -3281,7 +3281,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
>  
>  		if (prototype->nr_args != 0 && !tag__is_struct(class)) {
>  			fprintf(stderr, "pahole: attributes are only supported with 'class' and 'struct' types\n");
> -			goto dump_and_stop;
> +			goto dump_and_abort;
>  		}
>  
>  		struct type *type = tag__type(class);
> @@ -3291,7 +3291,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
>  			if (type->sizeof_member == NULL) {
>  				fprintf(stderr, "pahole: the sizeof member '%s' wasn't found in the '%s' type\n",
>  					prototype->size, prototype->name);
> -				goto dump_and_stop;
> +				goto dump_and_abort;
>  			}
>  		}
>  
> @@ -3300,7 +3300,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
>  			if (type->type_member == NULL) {
>  				fprintf(stderr, "pahole: the type member '%s' wasn't found in the '%s' type\n",
>  					prototype->type, prototype->name);
> -				goto dump_and_stop;
> +				goto dump_and_abort;
>  			}
>  		}
>  
> @@ -3315,7 +3315,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
>  			if (type->filter == NULL) {
>  				fprintf(stderr, "pahole: invalid filter '%s' for '%s'\n",
>  					prototype->filter, prototype->name);
> -				goto dump_and_stop;
> +				goto dump_and_abort;
>  			}
>  		}
>  
> @@ -3386,15 +3386,16 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
>  	/*
>  	 * If we found all the entries in --class_name, stop
>  	 */
> -	if (list_empty(&class_names)) {
> -dump_and_stop:
> +	if (list_empty(&class_names))
>  		ret = LSK__STOP_LOADING;
> -	}
>  dump_it:
>  	if (first_obj_only)
>  		ret = LSK__STOP_LOADING;
>  filter_it:
>  	return ret;
> +dump_and_abort:
> +	ret = LSK__ABORT;
> +	return ret;

nit: we could just return LSK__ABORT at all the places we do "goto
dump_and_abort" and avoid adding a new goto label here I think.

>  }
>  
>  static int prototypes__add(struct list_head *prototypes, const char *entry)
> 
> ---
> base-commit: 9845339bd09f9889dd741ed94f71eb92008dcdfc
> change-id: 20250716-lsk__abort-2b517860af28
> 
> Best regards,

