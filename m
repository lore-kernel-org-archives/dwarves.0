Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4E22DFAC
	for <dwarves@vger.kernel.org>; Wed, 16 Apr 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789939; cv=fail; b=CRH4hd3dA8Ex+hQzggRo53aE2KcqDlct/2J8A7Mu642N4zIIDm2ab9bGiDHRp+41C4LIx7xOIPSgwGzsaS1akw2ZuN3PJlZrLH7ssjU7VnY9FBcvJ1qzMqy7icLyIBIG6ex1X42nEAj/5mOyO9iIuh91wMChJ391bSo/N+cszYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789939; c=relaxed/simple;
	bh=39wUo4eSrvoEPq3YGZSbVQ15Sw2Af/4O+iGpYsH6Ovo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rnwPsIn8+CinNp7+jSilIdEJQmjaX5AP4JoQEGqoWWt/W29vxJDEnU1oBrhRSUg7ISWm+aC8MLHmlYLpaVVULAe6oZUYGoa1DEv5P//A4H/DQj4kxgvBxK5GI85IoCTHdJvhCaW8hsbyOnK08hN83LkGNfd7Zu/ZP9foN5Ey29o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zbo23UA1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x+e0Fa+T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zbo23UA1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x+e0Fa+T"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FMMubt009190;
	Wed, 16 Apr 2025 07:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QL7I7jI+/KtRb6IsrClqLs5xMXzjUAkRwTjNcvni0xI=; b=
	Zbo23UA1fjSXifoiuRT9Fok0Zsp7vH25+43c1hE2r7p3/7U2+xQGR8XejVaNm8Sv
	NoHoFdCxagnEkr2Y4SY8jXvcAniV/O88ST/SDILk8v55+0KSS2TWtctl/nouOf4A
	Mt31xZHAU8qz8X0sQWVDRcAGzn+E+pERzYb+h2zUuCAGai2pZpr535St9Z3jFZ6H
	+4ON9VZoiAVPg5DmSrgo8DwvyNZlR7s2nMQCz9Um9nHee6Y8Gie3O3H/7Oz4zu4G
	oE7/mDFFjWZPnAUrPhgZwFhQh+QnvlJkWJ0fXGahAJ4lPOxoLE2NmOYPHH5p/Mz2
	KYWBQ0HP6fI7elNfAcX5mw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd3c5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 07:52:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53G6OaGU030959;
	Wed, 16 Apr 2025 07:52:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbbs60n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 07:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NurllL0NLteCOf9EFsKs5KIIbhVTDok2asnkDianuGrT/ROSkQ+l9UHN1OodQ7Wc33tjsbUKFmZi9cC8koJMtKnx0XMJ4BO3NhCT/EPmWFcgeZLVeN4oRt92OHgYbDcBOAXQVpq7IlYV4WXG94HHvXupa/CoLu9o4+RkpKqaOnWO/ZDJW3KisnRP0R04PWhwoX723S2hp5TnxTaSCNa5rHzcC/W+lHfGYGeeoP9q6XowVvWM6bf4Napu9mx5d3LSseBCFLuNxJYSA1OIvapabPdWD2/MwHhONBl3UaA7s17SWjCWH8nkS2CCKBOYvTieLTPXAbgXg7MX31XrLfA1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL7I7jI+/KtRb6IsrClqLs5xMXzjUAkRwTjNcvni0xI=;
 b=hBflABmVEfG1bnopkrgqZOgacF8HBqHwjWzZG5lWkpv/Oku5zeP2V+sAAGcCWSKwM4pTD6zUfAVUfEKo+jxjojloIId4j86U1S2I+NcA80zYI6DzQyUx+KYrCdyQxc+N7r7ALz0PMZVrX4uVwslDN9PCBazc3/GaayN97w+ryceWPPRWNuMMApbY1V8IQzQHpf5Tu0Roia8S83zycUdXxtT7FKdWoGYqcobjH26HLuPqgM4hLUHz6UHcijljBNYf4yeRaTcQU8PPx4SmX26zC/NnWyo9KSVzN4dUUdOQNGfVDM1b1JEK8N2P8sgFEUOPy9YAsyZ0NlTwhpowKgqNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL7I7jI+/KtRb6IsrClqLs5xMXzjUAkRwTjNcvni0xI=;
 b=x+e0Fa+Tu4IYG75cjcyQIPi18ksNZrasJ4aibChgdahOPSUBMhIzBB5PmguGSHh/DbrHc+7yN3d2RfMTUjC04BA+EjclU7p6hxismmWJafxSVC6Nex0/389ay3KuC4rEGpMN+lmCBFqURa/B6bF/lo9LsfNcM90RhXHBqw5kPoM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB7006.namprd10.prod.outlook.com (2603:10b6:510:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 07:52:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 07:52:09 +0000
Message-ID: <aae20053-ce1e-4fa3-8c73-1f1a702d123c@oracle.com>
Date: Wed, 16 Apr 2025 08:51:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Is 1.30 released?
To: Domenico Andreoli <domenico.andreoli@linux.com>, dwarves@vger.kernel.org
References: <Z_4mPCCLXBCakppE@localhost>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z_4mPCCLXBCakppE@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc2aec6-40ac-4145-d7cb-08dd7cbb96b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHU1L1ZPRU5hK1psYUFYSVhtN3dodEFXc0FJU3pHM0lzWkExVTcyUnVrU0JQ?=
 =?utf-8?B?aWIwWDRCRnhiVVRTb1d6R1RLeThJWnByZllGRHdrZmlseUEzOVFZTmNrbVRt?=
 =?utf-8?B?dFRxMlpORnhRR245YWtBN1lUU3hKenN3RWMrdWh6Q2tsRk50Y1B6QzNoOUpQ?=
 =?utf-8?B?TCtZY2F0SkNpTmdOckN6anFVRU56Q0V6c0x4akpkMTJDazIwWExWSitxNlhI?=
 =?utf-8?B?ZXhHZ2g4cytZa2t1SnppNVRkTEdNVEd6WXM5TGNyM01veCtXQUdQSEpGTmFh?=
 =?utf-8?B?bGIrNE9BZGVCdGhMTW5ZSW9RNG9QUUcyNGFITGtuNG1vVWZyNHcxTUNVc1Fr?=
 =?utf-8?B?TlJnS04xaUFzT2ttNytiV3pPUEtpTlFPWnpyMjBxNlEwbWZXeWtiakVYZVRL?=
 =?utf-8?B?eEhIRkJHWktNZ0k2OG1PWEtHN0pIWm5rT0RmUlV4ZlMwaXdGbkU2bWdKc0ts?=
 =?utf-8?B?TDl6N3c5UW1zRldJU1lscVJiSjd4cndXU3VwTTJsVzRyS0tQVjRSZ0NtY2dM?=
 =?utf-8?B?bFl3OUlMbDRDSVRQVnRmSDUxK3lqdk14VTJweGtWdWNyYXJVWHNwSVJaNGxZ?=
 =?utf-8?B?VzIxVFJvemNTUGJlM1lZa0JIbmxMeWpVcFZTTUdmOVBKcU9ZUXZoV2lVZWdS?=
 =?utf-8?B?YU1leFFkL2I4TS83T3pqdWN4NEFKeTRwajJFZC9lYWRMbDhZVk5HMlB0eE1J?=
 =?utf-8?B?Zk9nTVRpZ0VYMVJPZjZTSytnKzRabGYzMzJYRVhpWXNXRm9zMDRIeHRWdnBv?=
 =?utf-8?B?bVBNVkhCOTE0aVVVYSt6czM2L21SRnZOUlpENjYvb2toM0VTTEU2Wld5SXVm?=
 =?utf-8?B?Tk5aOUR0d3VHdU9UQ3lHKzR0S05BaFNGUEFPcVNadms1OGxTR3RHMk1mZm5P?=
 =?utf-8?B?SnNnY0ltVU4raFhRbWZhTDZKb0I5RGtNOUZleEQrZVhBUjRJRXBqL08wNHYv?=
 =?utf-8?B?Y1hZelFMK0Rpcnc5TzVYTWVPdkh2ejBydVd3R3ZuNmdGL3FZTXRWRTcwTUFP?=
 =?utf-8?B?N2ZSeVFDWUo2RnUvR0thYzNzT3M0L2JrYkF1Mi9VTkxmcDJsazZXL01ieXhq?=
 =?utf-8?B?aW56eCtRUUxsWGpMbUdHWW1ZN0U5NktRa3FQSG0yMlV6RWVJWlZ0OHdBMlVD?=
 =?utf-8?B?UHJSbWhMNVdIVjR6WlRTN2gyZVJXcWluZm5kS1VFbmx1VkFOS3ladW9Wb2N6?=
 =?utf-8?B?cWwzRDR0NTlYeU9KOUZDRjI3ZmkzOW1yU2FScEdEVFZhL0VqS3JpOERtd2Mv?=
 =?utf-8?B?emI2UWNVeFl1SmxWcGU1NkpNMFVzNWVXMjJzb2hJRzVIbktRc2VPK0FqaXpN?=
 =?utf-8?B?NEdsMlB2TEhhaDBOZ1JtSEdtSklNaUtxYnVkNVBsYzJZTGMydC9pTm9nekEx?=
 =?utf-8?B?MmNoSE1EMm95dHBjWTRROFc0SVdraEdVSGViUXZzVUR5VDEvTzJhcHU4WHox?=
 =?utf-8?B?MmtjRmFqNFFEaHR0d2pBWUlrdnNTZWozUWM0bTNsTVNNWGtYeGNNOS9EOEVK?=
 =?utf-8?B?MWF2TW9OVXY2NW9JanVtL2dMNERvSnR5Z21uUUZONUdwRXVqV0VScGs0dnhq?=
 =?utf-8?B?T2V4ZXpEcjNQL29YdHllbXZxaHhQcUlMR2JTQWhNY1NEZHNQQW9WRWs0cS9i?=
 =?utf-8?B?bTJ6OVRqc0J6R29rM3Y3ak5ZdS9vbm5qWGtEck5LWWpjRVVKMjJ6ME9wS1Bw?=
 =?utf-8?B?WVd2RE0vMkE5c2lqQjFza0pSNEVIcnQ2RjJhWmhTR0VlV2FpMm45cmtBNUdG?=
 =?utf-8?B?M1FiNmhIellDRGxkU1R2N0RUc0xJR3BJYlJzNXFQTlF2bmtxQXd5UzRFZlZR?=
 =?utf-8?B?dGIweVVMTkJsNTFSdWtTZmZsdHQyQ21sTFd0RXVNMzF3eWJBMks5RmgzOWJR?=
 =?utf-8?B?Q1BhZmZHRndHZ3FkVndXMTlmOS9ZS1U0ZXlzMFhKZktBWC9lejZ3NjdFbDBO?=
 =?utf-8?Q?kZiXacfIE9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDM3Lzc2bjZuWXVYNUIyOTAzZ29QbzJGKzdMYWpDZlBGUTY4UGxyaDl3elRt?=
 =?utf-8?B?dHdyRDBmSm11VUNyMFhTYlczYWdIdFRUVGJCWWtPWDJqVDBEZ3F5Ty9Fa2hq?=
 =?utf-8?B?NnFON21RWllBWnhTdzZVN2lBMnVic2RqUDRHSXdjWW4xMHZlUkRUYkVmMnV2?=
 =?utf-8?B?alFoWlNPWVNmOEVXQjNBQW96aWwzVHFIOEFCcEhITXRNU3l6ckJPQ2M5cS9Z?=
 =?utf-8?B?dmxlMkp4MXFTcXFOODBWWVFidG9FMTA2RmYwbjVmMnlLenVMSUhYdzJuNnpO?=
 =?utf-8?B?ZTFIL0p6clkyWEplTTJPOE1FaUlNV2xrRmxIcEhZZ3UrcmJSd2xvcG9ONVJm?=
 =?utf-8?B?K0xOVEsvcHRoZjFUbUFxVlZSU3BFZDlTN05yS0RpQy9lUEorRWk3UzdWZk5i?=
 =?utf-8?B?VkJKcWRueVFIb0Q0TEFhdFFwZHRVQXdKVVEwUndSYzZpcGhKNDdOVDdjMnVD?=
 =?utf-8?B?R1ZQQ3BGNnR6bDFFSUNIMGI1cmxERVJvckZxZzlSd1d1bmpHZFhsRTlQM2xr?=
 =?utf-8?B?V3VxZElxUVlseE9ocWNzZkplSExvUDhJUTFvUlAyUm1INUVydjhtSXlNMjdS?=
 =?utf-8?B?Vmx3eGs2YnRCUFZWbU53Y2s0UHBBWmljTnN4Z1h4eFh6Yzd1R292NHpIM010?=
 =?utf-8?B?VG5UNndISk43TFIrYi94RDl5NGZoVWdrK2t1WUZZdnJ5NXZ2TWYxOWpGS3JS?=
 =?utf-8?B?Z2tOaVFNNWpHMEo5d1FXRlIrbWFiajB3QzNDamI5eFRkNUt3TVpESmJzZG5h?=
 =?utf-8?B?UmNQY2RuQzZPRjE2emtyZVI2K1J5R3lBSmxPbXVlY2hMeFBXdmlQQVl1TXhw?=
 =?utf-8?B?YUFteE5mNW1EWW9EREdGSk9YU0lDWUlWZ3Z3Z0xSTUhyMFRkbjhaMDBCTFFP?=
 =?utf-8?B?bC9URnNPRWU0aGpaNVFFK0pyQkdMSkxyUUdPaCtWQmg3NEdNN1lkaVp2ekVu?=
 =?utf-8?B?cWZyR3NQUTZyMUQ5OVJDd1AxTzZLQ01FOHI4cHpTWGQ5Ull1d2Nxd0kySjli?=
 =?utf-8?B?R2dEbVBFaHptRTM5MTdLRXFBQjVWOE9TTGtYZGVYOFp3NTFoMG55MkJFVEVy?=
 =?utf-8?B?N0oxUDhoK01udXNYN1JyWFRhNWFBcUJ1NG1PODhSQ0lFVWFiUmVVSk05cmpl?=
 =?utf-8?B?WnZGQldMM0p1RFQ4ZzhiZk1rU0JJd21DU2Y4S2Vuc2xReWJWM1pUZDIzcytK?=
 =?utf-8?B?NXlSU2hZNGdMM3BadkJHQzkvRlhWTzROL1psQlVzK1J3VlREa3VuYXR3bE9Y?=
 =?utf-8?B?RW5hVmNDdTQwNTNYY05UVzRndzAxT1Y1RzVhTkNGZjZpMFArUnVKaE1ibDc4?=
 =?utf-8?B?WkVTbzBDSTRTMHcyZFpyYjZ0QjhtZVFLd1NWL0paNzc3NWJYd01DUmFDUkw4?=
 =?utf-8?B?NDFJTjhNMCs3VTFDRjV6ZXlGZWtPQytqTHlJZ0J5UFVLY21iWXNTczRDWjQx?=
 =?utf-8?B?QmZtL28xR2VPS2xNcTQ5eDNuMWxrOWQvajVEZWVFNmVkekQ5TkhNcnFueWJQ?=
 =?utf-8?B?MGdEcFI4UzZ1R2hRYmdZeXRDbWIyaGd0TmZrU1pNZEdJVWhlSDh0ZFNEd29x?=
 =?utf-8?B?TDFBZzV3NGU0UEVqN1VPNkh6eXlYZndBQWJkaXhEQXRLemJVUGJpZGhwM3VE?=
 =?utf-8?B?OVBScFdWeTZXaWlJMUlyVStvU05uU1lMaWlJVTNJL2lGU1hoVXJVZ0swT0gz?=
 =?utf-8?B?eUlBdlhRNEZRUHB5UkZ1b2hBMFdBME5ITnU2YThNVDU1MDdNcWd2N3g4TVhK?=
 =?utf-8?B?SG9nbkpyRk51WmU0cnVwREpQSWYxeVkwYXhVWkJ3SFhSTUp5Y0JOZGcxUGFG?=
 =?utf-8?B?SXhRQ2ZmK0h6WWJJcVNmdDZhYnp1MmxFc2dGNzlsUEg3Y085dFcvOWcvV2E3?=
 =?utf-8?B?SGExOXZPZGk5N3d1NjBkTnN2bDcrRlg2QmVnV1NqeDdWUXUycW16RTRTTHpB?=
 =?utf-8?B?cVN3czgwemxoaGRUNzhqQ2FFNTlkd3VYQUdScWl1SENoaDN0QkVNTytkSmEz?=
 =?utf-8?B?NndOalJURE9YcmV1TzkwSjRrdmxSYVlWWVphdjBGaVJpUDFuN1dlLzFhTWw1?=
 =?utf-8?B?amIrcFBJejkvSlpvSERsbHQ2TUt4dGJtK1BnWW1zaGxiekR2SnhWRlR0VitR?=
 =?utf-8?B?aWljYzhodzBMMGRXVkQ5dkRIWWlHR1plZDFndjA2K2NPMll6YkkrVWpVVmtU?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xEMaQ2JJNnddsUDiolzKef4Lt42JaizPRQiKV08T6g2aYdWhrdBHl6m6qx77AdIDDCCas0l/LJRpdEuUHwL66jjQwr5Ue26bwfiorpPn4okrIpA90rfFdx2zKWM8Qp/OK2DUuhSWGsIk+AqKcbTldZ3r98mKXyYpFwyhzb8HDJb+sdm9gT1AKn6jdbuPd9maBwAl60pcBhlzJf9JTKjnCyZq2PNMu1pIhQCDeDQQ7/r+OpYBmW9u7oHEhh8buB5AqW80AwkWRVlhHy+bz29FjewhTfGhzFGTPduTTYl9fkdUInO3sCFqUDomxE8gSybMfJ8pgiAtX7OHmaOFjpCEOYtxgZT/6GPdt5TX0oIk4nCVQ14zItDG+JUoF1uG2WR2cktfch17hYzG0FOumgSsi7MLzuGH4qhSpFLvcX7+AVc21R7wDwFPleORRHrRsteZkfWKvMdhZzi2q48b8iDn4flvTvacmiKg8TsQDElNLGuItnn3j2k9tnDHEhHJSR0ZLGPUMw8vDp6G3mAg9T6tdr6Tlat0JCwZWZ580T5jZWZCooQAMGQMly6xxkJH+ppw+c/OqGKKIbNEqKiwmuK5zZxxy7/AvMnclQ97hEBU9SU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc2aec6-40ac-4145-d7cb-08dd7cbb96b9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 07:52:09.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciMY7YP+AID1WXOXAafo9UuA8oQcHuzpPMyT7lx6vVGOHPq9x3KmdEaHN6wByrZx9crmzXGKeIUHyN1XNzKSxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504160063
X-Proofpoint-ORIG-GUID: KH5adzLOSpzVQLp9AoSGZget1z8ryZYJ
X-Proofpoint-GUID: KH5adzLOSpzVQLp9AoSGZget1z8ryZYJ

On 15/04/2025 10:26, Domenico Andreoli wrote:
> Hello,
> 
> I see from [0] that v1.30 has been tagged but I missed the announcement.
> Additionally [1] does not show an updated (& signed) tarball.
> 
> Is everything in order here?
>

Arnaldo got some late reports of build failures when we were finalizing
the release; we're awaiting more data to determine what's happening.

Alan
