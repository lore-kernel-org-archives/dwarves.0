Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936A21767D
	for <dwarves@vger.kernel.org>; Mon, 12 Jan 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216002; cv=fail; b=NUQPcQ5PMGuJoYe7JrPx8upsrK7Heynpw3DqMNR5QJFq5i3foGrnoRgxhQpYRfx8KOOfCPrwO7HLN1DvbdUjg1zItgZBmwbbU7zYNnBfAiYPEBDFI1upRL2W4zEFgeGQ6Ji8HxiSoznd0Juh855Tz8K3sWGFAB3F02eA8XWefEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216002; c=relaxed/simple;
	bh=GyFOIDwk8VCKsQeHPMsdpvKpGA1JRClWUlihtNH05rE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U/+axswoEK1g56GOO3ft8ff5mlg6d1azPgRmIP00emActFfkV8qETUmgfonQu6ghotEZJgI6lq70f4pGmz91eiM29xHJE8Yc34vZI1Ajs6sCFFfhJ1aEG1sFWuAK3lfmPiA502/LFoOj6ss3WpjJzFMid/2UlD0SPf2J7upLVAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GMk/aknW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ec196Big; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GMk/aknW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ec196Big"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C09HKp808246;
	Mon, 12 Jan 2026 11:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Mh7tDyYCbnOqsZ1bAr/svd4eQSoOivdf0ttESMs7POY=; b=
	GMk/aknW3llRSherUFgFQc5IXaoLqa+Jh+GyqC9Mo3pqmIVpDIO4Gf4knIIO7ik2
	Qd82VvWqwGctyGWNafwKK30h0qYDeCHw1/EUKvB3DnTqRr2LWbf3jqIR2qNRe45+
	3C8ESlDAVipgitE1rgGBxvGUeMtliPlBdHJ6AGK52uwU74lRKBEDR7wFZJQLJbjX
	ZPzQfljsEPyOXo2qdtFgK2IDSDq5buJqWcOUXPgih3I6PD7dCym4rORggPTazak+
	t3fGHPBf00eY7D5rUQhabtj0W8Wch+iEIbgEAnkY6h2iBVQtL2oxhG+ZxLSFpbAs
	oZkmIKSnH1kVADd1PCmzQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrp8hd9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 11:06:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60C9mDYY004204;
	Mon, 12 Jan 2026 11:06:34 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7h2bmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 11:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzJuzemDo6Id1WASvWCfZDUcC5gOgNk1QpoDjphCvUt+yQ6tXZo9C50lLh5S2hbxyrK3B23e1Yj+Tc4CStSWlH5GgHB4LJuoDw7DrGO9ICzTg7bTNs3WuBlQVrmFeCx1B+tYLbjxev/YakLzIyLuzQE0toH8FGn5SOx9kqgBDTUTZxz2CICYd/nJSk7vSNF6DCOV44ivYqL+5vaippUZ4Bw+ZotgMTWKva0PBbWwwm1J1hej6bCRR7Gnr7tWMICVM1Xd0gopmWSOhks8RNB487IIGPPXS1Ln28E4uEhwVUItv4qDXtrnNSY/6DqA8oBYoD8YLjeUIJAiKonpi6UZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh7tDyYCbnOqsZ1bAr/svd4eQSoOivdf0ttESMs7POY=;
 b=LB8YWQCm3ENel2wFDLX+ww75FX7D54heZU0YO7K+/zZU4R9EpxriN520LMIbAErAjgq3vV4+I+XqYM4RPCW0Z/DW8iAAVLjBYNKwPkkZIkHNTFrpQUe2WK1ffblOBTVCG1fBV8D+Z0DdLqgf/xvD+3DExQ3D0DE3SMAYFfO2JHTFOBvc+MRzvWcZK/EodsOuSSzlVb7AV8DsM5YA0QvBusH1CpmL28nzxauhFM+5OVZfVDsYVL9spfSP0V7E9c+n13sLfQpDOMXVbODDkcgmAH4uJMDxfllDwxfBYyF8ifvBCUQUH+7cAhHRIrExJ72wnvNaY91q4Iq3PvdrOoXoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh7tDyYCbnOqsZ1bAr/svd4eQSoOivdf0ttESMs7POY=;
 b=Ec196BigCrnFie92Ph0Ms9mNzV1appc5aq5qG5Cu/d00fwn0xyqARCqZmjcQZUOSsSF7zmUGHq5AqcNj57AyzpfERoUxYBqANowLUsycUEvmLxECwWIS/6MHlGGL2ywMzci2Lm/Trol8GZtam5p0xN+lRTu1eS/Jsdv3asZpkOI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 11:06:32 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 11:06:31 +0000
Message-ID: <058d2070-0adf-43be-99d0-0ceeb04fda61@oracle.com>
Date: Mon, 12 Jan 2026 11:06:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scncopy: Fix error handling when opening file
To: =?UTF-8?Q?H=C3=A5vard_F=2E_Aasen?= <havard.f.aasen@pfft.no>,
        dwarves@vger.kernel.org
References: <20260106182354.1579350-1-havard.f.aasen@pfft.no>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260106182354.1579350-1-havard.f.aasen@pfft.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d815f2c-b6a5-49b3-9ce9-08de51caa456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZENwM2c4U0J6K0lYbVJRTFBtSlhhc2hmTTBZNlpzaSthNVNobzJ3T1pvZWFv?=
 =?utf-8?B?MVNpNnByN09mc0hYYWl1cXlNLyt5ME9hVmZXOVFENmZURUUzTjk2RUNZdkZw?=
 =?utf-8?B?QlhCQzV2U1RVOGs1N3FuRXJhWU9EUW5Gc0NhNFBkckgwMDIwWWs3L0hpVjA1?=
 =?utf-8?B?TlZBL0oyT3c3c3NaZEhHNGZtN1lEdnhldUJBTGhkSkV5Tzk2ZW1lMStkeGZz?=
 =?utf-8?B?QU03T0pUWkhteWNoNEp5RjE2cll6S1VxZXhtcy9aNmVtZDJCTVBVLzV1YTdW?=
 =?utf-8?B?SVkxSTg3NW1wOUVpQ3ZkQlFrYlBjSDhKeTF0UTEwWTVoR1VRcTRBakdJdVVJ?=
 =?utf-8?B?S2hETEdKZTBvNXNBSlBGaEhHYWZZN3pWYjcvR2hxeWdkSUp3bmZnYTFUcjl6?=
 =?utf-8?B?VllJVk4vTE9ESWduVFN0QkMzbFExWGFjcHV2VWI0d1dTMHVwSDhlNjRidjdR?=
 =?utf-8?B?dUttejdMc2xEaTN0WE16cVh2TUhnYmNQV3V0dE1XRnpiemF3cGhOZUcrZDdv?=
 =?utf-8?B?UGNGWW9FdVZzTm54bEoyMCtpZkk1UlJNSWlPY3QxVWtSallXcmd1bklKWm1h?=
 =?utf-8?B?U3I2TFBKVi9Icjk3QmtKanFQTlowQjFTczlBbnRsbTdSbVZDVjQ1cUYrZ2pV?=
 =?utf-8?B?NnVZNXVrbis4OGpIRE5JK0cxb0dYUHpQOWduUGxra2FtOGd0dkl3T0tPU01k?=
 =?utf-8?B?S0p2M0ZRNHQ5NWZYdHg4NlFmSTNKYjlmV0wyWmdDT09oSnE2Vm5qTkJwVkdm?=
 =?utf-8?B?UmY4bU1ERkZrOFBCN09aeTZZZ2duT05pQlNrNStUR2tRc3hsYTlzcVFIelEv?=
 =?utf-8?B?SEhXOXBIb1NaM3A1VVpuTU9vYnVmYmFGN3NRTFdQQkxJKzhtYndTTnJkY3RS?=
 =?utf-8?B?ZHFrV0MrU1ZkUS9ENkVPTnNnVTNlODFSM0YxVXFjcHEyd01Mc2dLZjVTM2Vz?=
 =?utf-8?B?OEE2dlMrRng0NHhjcFBmaktjeGFjWUpqU3RTRjBWUUtTOXorMUNuOXhiWnNG?=
 =?utf-8?B?cFFOekxKQld4SWl0MVZaQXlPcDZJL2hsMU5kZnJHZGVZRFpDMDNjSzZFbHpv?=
 =?utf-8?B?SlhXd2Y0SXQ2OEtkWWl4bk5wZllSNkh3WkdYTi95S0FidHY4Y3czTEhpQXJG?=
 =?utf-8?B?R0krVVFaeUlIeXlRMVFIaVp2NHhVN2ZiMEViZzhENUswa3ZNZS9mYXo5NzRI?=
 =?utf-8?B?WFhwNGpXcnRRWWxPVmFyRGpFVnZYYXNFNXRIQTFGQ1lpNVl0TWcrVE9uTURM?=
 =?utf-8?B?d3F5dzZoU28vcFlYVVFLcDBBOStuZmFEdVpxdVBPQ2VhcVhiV1pOWkRwaU1O?=
 =?utf-8?B?TjJqb3lPNklPWWxqczJRYllvQzE0M3hsVFgyRmdZby80aXJKVC9WbXNJa0U5?=
 =?utf-8?B?UHUvZi9mT0lneHNZOXRPcUZHVXl6OUgySHpjY1NwODdvZ3JWT3U5cjYwQmZK?=
 =?utf-8?B?UWZZekJ6SDNHVEJ2ZHptOVI0VGk1T3Mrd0dSWEhENlJaT1NaZ0NJSHg2NVZa?=
 =?utf-8?B?c2pSZlhkbjNocm40WGhxMldYVE5lemxJYTZid2ZWNmY4WmpienVlRWlSYlV6?=
 =?utf-8?B?QXczKzZNcmJpMGhDV3VwVHQxN2llTjNjQ1hBbFdtVEhaaG0rUXlHak42cVRi?=
 =?utf-8?B?QnZpNXpIdmpBWEozZnp5aW5lRnZPZERuc3V0UVdlOWxKenJrK0JTcWlQbGR5?=
 =?utf-8?B?TGRNU3ZTcTR3R0gyVGpPQnk1bkE4cWM3Z2k2VUpiZnJOQUcraGNhYS9KSUkx?=
 =?utf-8?B?eFphTnQyakRKc0N2dkxPWVg5dGlsZ3BSYXZFd2UrSjdmRkRLL0I2WDNhWmdW?=
 =?utf-8?B?SFExeHpPSEtWVEFrNytJQjJiOE81NkpudFhlbVdLSzNhU0o4YjBxaTBLV050?=
 =?utf-8?B?Z1R4SVhkOUlsNTlQOXFsK21IQkptL3JXWklRaytiS20zNkxxZHd5WWtrMnl6?=
 =?utf-8?Q?S+2qhy0CMkYYJnJ45tGAEeqXzO9fEvkv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFrRm5KTWM0RTFQOGh3NGk2OFFpZ2NZdDlVcXFubnRmT0UwZTJhc0NLa1dL?=
 =?utf-8?B?OTFnSmJEMDBlNnp5K3pKMTR2dGdTOHRidnRlU0NjZWdia2hqSDBETFVqY2NH?=
 =?utf-8?B?NEFnL2lvZGZOMjl6amVYVnp4R2paaDNydUJrVm8zRFRaeUM2VTMwTUk5UGd2?=
 =?utf-8?B?T1NVZkUwTjhHMitiN1ZDM3NwNDloTWFJTFRaVjlTaGpuRk1IVkpJTGhYL2xC?=
 =?utf-8?B?NWk1dVNCbFNzRGRFRGNyYjkrRTZJdXo2ZWJrcXh5Q3ZlcFYzdFV0OTJlaTll?=
 =?utf-8?B?bWxoN090Q0RvWjN2T1psSld0VzZSeFhLbHM3L1Q1QnZIMjgyQ25wZXYzb3N4?=
 =?utf-8?B?akhaaW0xS1VwQkNrNncrMUs1QzdEZi95SStIMUMrcWtwb3ZaK21wOXErTHNZ?=
 =?utf-8?B?Y2hFbjZQekRJakNORkx2ZGl5ditWR3d2VU5GazVYeDI5TzNNRXhWdEY3M29s?=
 =?utf-8?B?c0Nyb3J1M2Z2cjVoR3dmZWJaTHQyamRwdStHSTY0L0syb1E1SlBPeHhGdHpo?=
 =?utf-8?B?emtWNVRSaDRsdWg5RkdxUE5YS2E2K056MDExWnMzMUVLOTcrZjlsRDRsSkVH?=
 =?utf-8?B?V1dveEVmRllRZHZuRnIxRHhKM0Ntb3o5Uk50QXVhSDlyWWlLMjZNaTBMZ1B2?=
 =?utf-8?B?RUxXOENJdVVTTmRpMmduOEZaZm94T1FXQkJLVkpYWnVaSE5OMzhWeG95em9m?=
 =?utf-8?B?RE1QRWtKSVpxOThHUDUrK0xjaU5UcW5Za0gzcXVoMjRCT3Z5YytXWmtTN1Zw?=
 =?utf-8?B?SWU0K3UyalRvNTFDZk1LbklFN1YxRndGN2Z1bzAra0hOOU9LQWZVNjRvS2Mr?=
 =?utf-8?B?dGxjTVVoZEhDVnNLRy85Ti9RR2N1N3pzUGE4RlhkSUNOdmZWMzI5QnFvak14?=
 =?utf-8?B?UDV4a1JiSVpJM2d4a3ZHREJkeUJ0amRvWDBic3g5aGxFL1UrVFBQRDhTOHpM?=
 =?utf-8?B?U21tQi9GbzNhdmtkVWFCVXZsbGd6aUxzb2Q4dUpZK05vZ0diL3lqZ2tPeEpH?=
 =?utf-8?B?R3l2UFJtUDgzSXY4M0F3WWYzWUVGNER6V29ucjRtQWJOenJxRkxpSXcxZW0v?=
 =?utf-8?B?bHo1Kzh5RTRkaDFmdHpDa213M1NWZkZaVllmRTAvbGtsaU5oQ0RDUW5kQWtC?=
 =?utf-8?B?MzEwMGY2Q1BWeDE1eTl6cmpFNFdWMkgwdVdBUnlicmlsUFZoeXRwME9uczRw?=
 =?utf-8?B?Z2xPRjFMYWFBbWRlR0NVS2xjdHlSdEpLdU81ZllybW1JcWF1UVhLd21Bb3dr?=
 =?utf-8?B?MTh2ZWJFWEV3dm9wVllINzdsU2pUTVA5ZnFNNjJUZnZ2bjB1Z2FuRUEvOVBt?=
 =?utf-8?B?SnBVYUFxa2xPeDJlYzNTUnV6OXdmdGsxWTUwM3ZPaHBUOFJIQUN5TUlwNzlz?=
 =?utf-8?B?SWYzSkV5VEs2SWZiMHduWjFxYUlkZS9yZWJHeWNrZWRBQUk1eno4cnhVQkR5?=
 =?utf-8?B?TzlLUFBnVlplT2k0cTEwN09CRHIxUDJMa0M0NHdoNFRwYVM2U0VqYjhFak5j?=
 =?utf-8?B?c2hldUJ2cDgyRkZCcGw3aHkxc2sxUVl3TFVZWG1qQ0xzL1VYNmFOUW93dWcr?=
 =?utf-8?B?TkVPaUNuMTVTWm43Rlh2TDZURUlSTERrY0NqdXdvTC9EVUZGc3lQNHA0YzE5?=
 =?utf-8?B?SWZUWFFOT0lRNWh6TFRneG82elZLeWZkdDYyQk1DN2ZnTjd3SS9NYzJCV2Ja?=
 =?utf-8?B?MFBlNmEwbmIxWllUOHVxNGsxVFRxNVVDTk82TjlFZWZXTFFnMVp4VUkzNmJZ?=
 =?utf-8?B?YzlIMkZQdm5oQTA2YjcyL3hIRzN3TkhxQUJweXZYYndRclQrbS96Q1lmcVNi?=
 =?utf-8?B?ZmcwZnJUbGNzd2IwS2pRMnQ2b3hOZmtPZDNrY2hiT3FLaUR2bG0rSHRteUY5?=
 =?utf-8?B?dmdmQUVRZytlTktYdmV2NDMxTzVJOTAyMTA3empFWDF4VGRreTRKNWdxNS9i?=
 =?utf-8?B?WkxCbE9nVHZqSytTMkpGMHpHMzRzKzEzRnRwNitmYnFOTVFUUFFaLzJ6dGJH?=
 =?utf-8?B?endscHg0cUtIajFRV1NKNGZpSFlISlViNVQ1Lzh6d0IybUhKV2FLUy9mazh1?=
 =?utf-8?B?S3drZlhUeVBtMVRNdWVYZTQ2dmxuc1NjMC9TNGFzQ1g4ZG1lalBBQ2g5STh6?=
 =?utf-8?B?TmRiNDcrQ1ZUVm5VZFV5ZE1PdzlpSmR5TCswTmZwQW1NaFpkcGwraDgraDk5?=
 =?utf-8?B?NkZlU0VtWG9KaVl6SEdpZDVGank0QVY2dG5yWFUxNnJjRFpqRm1ndTNOVUNM?=
 =?utf-8?B?SWxoRnFlcEdJUFRPT0VYdEszYWdIV2M0RXpNeU04YzdzdC9KYmFWWUpwdXcy?=
 =?utf-8?B?QjhkVDVZOEVwVm5Dcy8xbUVjNjZpc3UzRHNZWmhXQWowYi8yb0dTUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xUoDKEcr5/q4YMqNmmX4omNg5CnOvkbotGv7heLY3IoGjynMz2N31OvFX+1Vo9m0jyrDwDU6ss87+bVrSnGYv5lor2asW9oQiSsXgeQeAZcSr4ZglSyOAGZyWTJSqa0sko39ZtbsKfEQxfvLMS5Mj9cOGBWmybeZWgYqrj8ar42PFsJWO35jfQpvbEZLMlCLybFgLY2H0dVIIVsDMhZ8EP0n4Ubf52nyLS2YJ6/acIOPARAnngoYXnErMOMQb9xDVTTLGDFQU1lpAupdNJh7bRwZCNX7mptu7EPrujstZnJnLoF12Fk8GvvWvxIJyRjlc7g7BRsBtkXu8T9BiH4IVUBhp/fozAkBiMoPlpFlJjecx5J968vek1JagxM4s00stQxrHFmwJh3psbkNtJEcKJ/AO4xLQ6NUgR1hjzqpKD3PaU2C6tnUXCNPyBQNP7dVTa7WIKziT6eKjx5va9qF+N8z12E9flClOU9/QVWl6timmTacwH4ApzZUOgklzsnPQPWfh4VdhNH6qCTyeeniL0vXh+EVmnSSua9C/ii95MXTUE+LOhrDLXVejA+xCQVK+k4phA6ngh/UZJZxNq2X9o+3oSCmdqVaJzFG7fyw3yM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d815f2c-b6a5-49b3-9ce9-08de51caa456
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:06:31.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqfPy9U4ZLd8xb/XhPHwxCnlUkf8dLonUOnzyC3aRhXEwHzL7cNqBfmJueBkrVzvhpGSUczm+Xa9wgVzfTFoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=954 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601120088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4OCBTYWx0ZWRfX8gFFQpe8Ck7A
 7Y7pGXNy21b7j8zHKEISxgWDSAPLpWASmdyma3P2QydYUdFqcCkCtBAWydxoRu8s8hTuEM1xQRr
 Q520X3qxo8wXJP9GJXnIbVwQCdNQ7FXXEuvOwYW8RydsP86xclETEd+oWdle+Zye0RuPZ9Zuijn
 ATroHLyOBEu7FtgbpCjidLxA7F7k5WTNr4jwLVydx8EUlMZB5NoaQvMfPY4uig5S0oc4gHN4+Dh
 5Pi8zccVxjQMuhvdh73VJmOsx/WS9tnHhcKCR7fFi4a1BTOIwPRz6bQHH1WLlYxQrvIYxAKEPt+
 0DK1GP/gsYDi6CEWrXGS2Uf6Uul9yL8ifiHCA4RYQQ4P5dDjivYFg/aiXM4T3C7wyJ5IWu5YzCj
 Slv2ALwHcZEznv5z+YfVttCJil4jCDw+o+osClix+qiZoRJvhPwtT/5Q8g+H0rLddUVhJRmkb/w
 ExZxRHK62lyAhUG9BTjvxLNPJLwQVHLclaQKRqM4=
X-Authority-Analysis: v=2.4 cv=YcGwJgRf c=1 sm=1 tr=0 ts=6964d5ba b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YLKWlMkzNFchQ8MIdacA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12110
X-Proofpoint-GUID: aYmcv1HddG0lbxzIWoUkyc4TjrD1PVj7
X-Proofpoint-ORIG-GUID: aYmcv1HddG0lbxzIWoUkyc4TjrD1PVj7

On 06/01/2026 18:23, Håvard F. Aasen wrote:
> The original code tested '!fd', which treated fd=-1 as success. The if
> statement has been updated to fail on any negative integer.
> 
> Signed-off-by: Håvard F. Aasen <havard.f.aasen@pfft.no>

applied, thanks!

Alan

