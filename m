Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2936EAB1;
	Mon, 23 Mar 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270619; cv=fail; b=ukH7pdSDliuL+P7X4nEKuHQCPYflhr+KMCL8juorgE+ZQVkwhHfaZ44TPxBNquAsDAzwnD0n1tyG67vnQLG/GvyQVLHhKPOt3HjiZacem8n3Lwy9lHlWoLGQY0OXCoTEvOBAbuOkhkJJ5pI94Bwra5BLEQ8Y1TvHx/Jr4odpahA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270619; c=relaxed/simple;
	bh=DxTT0E0K+WVgQKOcc9hczABlK2Nqmil+DRXpLS3J6T8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g4G1Bl6WFd76XJJtBnKKbr7T3y9fmae5usUAb0CN/YX360MKoMEoons9IVrrdgYJpde4z6SCrt5RsZoEkBdIbOIaLDTb00adPVGIeq7Cnv7YOvJskVKJOFsWPezuJDuN5ohSGOeEBX0j5/lKkPGI+TlqQhnCrgZvTlJ3DJP/THI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q21AZwxq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AKRpji7e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q21AZwxq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AKRpji7e"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N17oAD1694320;
	Mon, 23 Mar 2026 12:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JzJR6GTYkMesaFdEe8ocmaDjmH8tdL2L79smIRfQNKw=; b=
	q21AZwxqo0cLxdt9N1xE310r9yY+F0IlN1eKFNEVksRKNZ566bd/BquKKtiZj5Fy
	D4z8i6e5iUvRXyGWLEFYq+ECqVBcdwqqfZLmUKBv9aoAHLGcvSNhlJePKjsX4vXH
	xjRI7Oi5CjenZ1BKOHAtaaYXTuohjFQKki3FgQRkiaeSwVBasVrJo0l7CGFpIl2G
	zcNFcSqO1EIRcRqaE0mVgGlKo4dbDOXRvtlE4wYScqGK4y4BnGQx/EGpxs9x4lxK
	QEGaH1CaRSg2uf+6UUUp9ByP/tvdwIGekUOqUUiAIH2zLsFzDZsqf47y09NxhvEV
	RDVuYfuKI3/BusUnpWZhCQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpj6tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 12:56:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62NCW1xT038376;
	Mon, 23 Mar 2026 12:56:46 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d26xn1msw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 12:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nT++RBta5xRCBsmk0eCfddg3PgEK7GfXb+Ki9Ue32aK/RksOEmULhztvLCvC4gysbDzZtuGZKdl/XnvF8aw7myBfgtEtvs1E9CoxUDmvkh2G2ZurEGjv0PnTG04DQgAjXNZ3OS8JS8YZb/aAxCpOUqKXaiKANSh6Yo40RjnrJpEXvGBDejoJabS8j90JmLW0dvCm/cIgJYFTC8jEhrBmiiKJY/EXoU/s8pvrKbivYXeLN4wfHzt2MMSeFn8zq/0g6dqZyGT//RzB/WPC8GglCli+MDKRetvfSjPW2So52Ch2rlEZMwpgyQ5AjMeFSZLMqmezbklyCKzXqu/dfPweMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzJR6GTYkMesaFdEe8ocmaDjmH8tdL2L79smIRfQNKw=;
 b=U5xR8T+uSGLQzrM4c0eNrlTA6UGfBBXIt1fmoD87TfMbG4Zg5PNUlk/gedrpeOn0g7eOIvs5XOlAWq4wr4YkwWtluJRRMsfW7iPD+MYb9GZeJxKq/O/WsMCP2/ChuulaJ4MImeAtHd1/w3hhbOGCYL2C/HP2ZGGeb6ztbkrnlGmO9k5+CQ9F6T7BRvLfjhbjx35sYNFNqTbdoSim7yuc+IBOXIyv0D8DkAwTzFvgDjVM1I8LeZ3hCtznIe5eSyyd6GnsOJcaV0tMRad0xAps4eFeV+E3ci1GWP+KqiARxC0qK9vfBILuhrgaX0itVaZv7z4F3o6Q0sXSiYb6boBAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzJR6GTYkMesaFdEe8ocmaDjmH8tdL2L79smIRfQNKw=;
 b=AKRpji7et7R79yUNZIvTkd1rJRlR7XAFDRCFuO7OkDaA6PtrUw7BdPkl6UkCk20+DNvQg2vmMfI07VB4NvJCLHxuSmnEeZLMmZNqb30FKO6y5zkOjgESdddSIOxrFzhCRLhMnjGkIU0prTypCTlExHI70+ll6lOclfOrHV6NycE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS0PR10MB6994.namprd10.prod.outlook.com (2603:10b6:8:151::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Mon, 23 Mar 2026 12:56:42 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 12:56:42 +0000
Message-ID: <0ae2db28-d300-4dd0-ad37-abdb46b96de1@oracle.com>
Date: Mon, 23 Mar 2026 12:56:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3 1/9] dwarf_loader: Reduce parameter checking
 with clang DW_AT_calling_convention attr
To: Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
 <20260320190922.1970709-1-yonghong.song@linux.dev> <ab8lWhTT8LZGbtQs@krava>
 <2c9260b9-0eb3-416b-a75f-f33f37be6b63@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <2c9260b9-0eb3-416b-a75f-f33f37be6b63@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS0PR10MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d77af6-4947-4132-cec1-08de88dba148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WijHx1NrjHSWe9njwKxlSqTtapzO1/6uMTCp9maUClhkfw7WYZsDArAHGSg2Ex1D3kpsGwgFWS6wlO4dUz2SKyCx5rfMKZaeBlVpuLNGw9f4sCAq6Pzw0bTZnQ4ybR5+dIoQyBc3KStNijH9C7aLr9tGL/dJ0sILBdEtCyeQcMTl2iezSTNM08BFeDrkrK91I9LiGYpelUIpLDu0l2iA8+4Q+/AFQ6jOx7cKpa6QwRxcZy23me3j7/wI8bJ/X6Tth+wgzMui9dopZ1rv4HcIyZr8X7JwimCgSxOeHOKA+fDAaYUT6PH3pEmBD8EpXD68IrJReTYMPPAWJc2YeZ6d8//R173lVwWD1zbgXwGjMxyaFanuJi+VOelc/FtWgsA5oOgA0Dw1V7uuqFl2x30IDZH03jg5ghs9GLnUfDsMTpQsiNz2qxJk9r7DdLIcSmvQT1LSQHGaDok3K84CuU1E4+LEhdS8fjRbUmQV9N2OQi9w2Sa74QJqMlevu2PxuT3FUnjyhdpC5+g3jrWB3Q22Ye2WRhvGen2ZU3033GbXbFRnvB+iEt8DZne1tIL0hW4xGdl75nmyN38znWzHZP65G8QyDbluvKGQKaWoSBXOp+r3h+HQiYJboyzc7CnkdI70zmygDjUa2DyU+qzooGPD0eXbqpFHUHoeftcpfFMmEOBtu5+Gxy//PJGh3GwDKG2kAd++b2AM+y2ycuWQOnNVugulXw2P1s1GdPdI3hTY/OQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW80SjJocjM4WWtqQnl3d0d3RlJYVFltYytqWlMrMGN5bVR6TGE3VUdQeUky?=
 =?utf-8?B?UE5TOGxzSmpWRWhGNDdFZXd5a3JKVGtkYkxZbXFtb2hRZyswMXFrVlFrWlZH?=
 =?utf-8?B?M3A2Y3lGejFRWWVjZ3E2dmlLcjM1RC9kS3FrQ1pYelpDVG8rc0VCN3dlQlIr?=
 =?utf-8?B?Ym9zb2xCa2hONTVZd0FYTUZ0bFlERHFKL3dUMXNCSVFqV1piVzZLWVNqT0FW?=
 =?utf-8?B?NS9aS1RadUhIOVNDd3hZM3A5Uk5SUzVqdGdIM3o1a3JXMUp1aHk2OXlqVk92?=
 =?utf-8?B?RGhaZ0FtNjU4ODF2ajNsdDcySnBaR05WeDNKbmxjQ0YzWUcrQ0toaVU2dHdE?=
 =?utf-8?B?S0tJeXU2RFZmZ2V3ci9neis3MnRkcW5DV20xK1JiNkp6Z0QzbG9MVnY3Zm9C?=
 =?utf-8?B?ZE55dk9zbFV5S3hyVExsRlRFRDVrSEhES2dMOHJmYjltMURuM3RnWGw4UCth?=
 =?utf-8?B?cmVBVDJnNFh0WHRFdkUxTW40R2ZFY1dZNEFWY1pnNDYwemU1emlHTjRNU1Fm?=
 =?utf-8?B?QnJZNG5xY2c0MFF3SFR3L2VqamtHUWF6dEdjQkpha2NqZGVOU0t4dkdydnlG?=
 =?utf-8?B?YWk5RXhBV0FzY3pZT1NRQi9LYlVXbGZZWEJ3VG85OVkzalNRd3htOGRBMjl2?=
 =?utf-8?B?dE1LVjFwU1U0UmQ0Y0VDWkNmSFcwcm5iM1RiV2FBOEd0dytldmhIZjVEYUpH?=
 =?utf-8?B?d0tGS0dRZzVteXpzNFB3c3ZMY1JIei9CcTZNSkdOeklKMWpEVjU3Wi9QaHBT?=
 =?utf-8?B?TW5jMEpKQ0JUdVpqL2xyUTY1bzBpQUVZZjFMN3FQaURkb0JFMjJYOVl3VmpR?=
 =?utf-8?B?ckJuV2ZVbUF1aHowcmZuZVlQYUlJckJ5RFpaMlZqY0o2WFN4bnZBOHR0dzAy?=
 =?utf-8?B?VHpSNU5sb3BtUWl4ejdwZ2dZNHpkSUo4enVva1RSR1VIKy8zOFFiNVRpdjly?=
 =?utf-8?B?VG1iN3BzbFNjTStnNG1CSkdvVjA2cjBDME5RVDhJandRb3o2NUVnZmxieG1Z?=
 =?utf-8?B?RXBIdlhDR0l0VC9MOURBUlYwRXFZZ1o3UExmamhDWGIydlFHOWFoWDRNNTZa?=
 =?utf-8?B?MlZCY005YjBTRGFRa1ZuRHdlUVZiN0xMWkFha01sWGFRdHQxUGg3dHgxVGhj?=
 =?utf-8?B?bFVuQmd3NUh3dElPRUxmR2dNSGpJSU1tYjVLeHpveXBLSW15d04zWk9vZ1RM?=
 =?utf-8?B?SXNvaE9GWmxMQTFVMzN4UG82TldSM0VhNUZ3enk0NGFuZjduSFNzVGNoWlg1?=
 =?utf-8?B?Y1MzVjB5UFI2Z0FPMGtiVkFVU1c1YWs4bnljemJWY1A5TTBuaTlYWDJIOUNu?=
 =?utf-8?B?OXlKeG5TeWFOZWMxM1BEN1JnQmVWSnVKM1pZMWZUaHE4SzlDbmFMOVllT2x0?=
 =?utf-8?B?SXlLUGJZWENEenl0dUE0WkZzYXhhODV4QzBkVjREdldMV2FBNjhZREh2Nmk1?=
 =?utf-8?B?UVNlUFFSZjA5N2M2RlVJKzVvdDMyeTVZdjlTaEdqS2xSUW9ZZVhuMWJIc0ZN?=
 =?utf-8?B?Q3NTYzAwcllPL3FSVUVXTFZwRTlDamM4T2JOSmJMYVBycEhubk0yWkgwRUkr?=
 =?utf-8?B?V203VGpKVGpIeTlPVnJVN2N0NnVlS3RQbG80YlhBTlpKK0xwelBzdlBxOHJw?=
 =?utf-8?B?ZWsrVE95RndRWk5VQ25MNy9qV0ltZGNDdUtGS3R1eUZ2YzZTRGdUb1lqUDNL?=
 =?utf-8?B?UlJlUW03VUsxNGNCK0ZmV3UyU2tEU2NzZXV0WmVHTHVlOXBqUzZETTl0bWNK?=
 =?utf-8?B?N2ZERDNmQnBGQmlBMUxIWUJKNDJGelRtWEd2NXg4RlBwd0FWVitwSkNPalNr?=
 =?utf-8?B?M0hzbmpPaWJoZVlPZDZDeHczcHhGcjNFS0lBYkJnMHpSaXFLbmlFV3VPdnRa?=
 =?utf-8?B?dVM2Y1R2bllyVFVXb1hidlJvT3FhOXorMlFBMHlNUUpvcmFvWkMwZldyZzVJ?=
 =?utf-8?B?cGxzMWZxemMwcTZCQURRMVZoQTk0d1ArZVYva3VHSlllQWJORGdEaFFUUVF1?=
 =?utf-8?B?bmdMNVkwYTJaT2dleEtOekw2Yll6Q25NVzExakwzZVN3UWc5VHNXQ1AzYVlO?=
 =?utf-8?B?TFZIdHNDaEZpazhGODBQdXZ6QUtOM2xpUk9vTldmV1U1bkNiQ05RUVlocXc5?=
 =?utf-8?B?Nll1dHZhbmNha21PbnQwNVlNTDZsMVQ0dXJuYkpQcnpLRStlQ1NjWHMrS3B0?=
 =?utf-8?B?Ujh1Vi82eGUxODhoNXVFNkducFN6NmhkbXJnREd0WklKa2NWU0Z3b2JvdmpL?=
 =?utf-8?B?MGJxVDF5VlN2eGJuUzJrWlpub1g4VThyU2NzVzI0Sk1paC9tSG92emlTa1VO?=
 =?utf-8?B?Rms3SUw2dG9NNlVlZGdrdFdXOHFBcDBnRGJETGxzSW5QUkFXbGpGQT09?=
X-Exchange-RoutingPolicyChecked:
	VlzpHaLbEzxMnWG7834QLzk3ytWFvtnWq7ASOn7x/ZXM+65JhiFMbmIv/Beh5qvitZsgNK61aH4RWty4Jutb2p/VrN0OYR0evcFPmLn89Dzd3N8fgQagi8n+4KrIQgYxNLj8bS2x/xfso9DFWAbXOrwgvbcxaw0UNZnvf3zqSO83BhtJd3ZE7lH/2iCQaXDX40WwiZy8u8X+vzhEHsPCE8P38SYNn9EbmrwfmzQKaK1dIWE5L3SMbdG43w6SUBiP95NYA0VbZZjXhPYz7SdhawlyWiCn3mxpxpOOBKJqSBdKaen69JXTLaq7oCGynWORPP+2tuRj9D//aNw/m/EFQQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PXQp5JBXQ8Yxm1sfzG2GMWOQozeV+4cvzid2gvQJZR5exNns22Axo1l4wuvboSMV/AKP7R4daegfIiY4nHU0HIg82hoEKlgJ7sYxNJOll42+rf4Ok7fRwP1ALQ09w9brvct8dHkm/i/mBcq8Sz/3WTf6o9n5eseaEhABdqPuuUU+klp58q7bI8p72HWOEH8PMhyGcyAbIZVviVybv/UM87aJqgCkpnkomyjEiHeu2gq4FWcrkebaVWC5+rXK3vBfUlkp0gWeyqaIFYhzCOl9iWbKCGQgEaE6VCNHhGkIPyyBY95b7+JITvv5ruxEzcDhHBDHxWq2BiuZF4satOpwgvPSV91NjGj4loEL2g8UzGLHj18/e10yEXN9+aLpn/32Xn8RgjQogGyQjSHcDy7kq4IC7Lufo7EIhPo34DnVBPwp1QRyX9QLRXsQLeUJOuMpz+tB2d2dXwW+KRg2e6Jv/x4BwkAikyRFu+PnQubL+fKkLJ3zx+k3HszZ1Xy4hkX4Ha/nSDuhvyIJ7sc7QiuUokLefhu8EFgGLe2EEkH1QA0iTgxvaXfyn6C0VhUdel2YdpLzmw3D0GQ5c00rP4qf88jd076rukBlm4C/5OOfViA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d77af6-4947-4132-cec1-08de88dba148
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:56:42.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7dRq/Bsg+Ga/1ftiCRirGaGQJgxZwzB497et2Ys0mT04fBnkTtkwiY6SgGF6+sxIVq8TuzrQMn2P4u4hDnXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603230100
X-Proofpoint-GUID: mk9AEEZohDPNDTgrVjAHx7Yv0MkvdQo2
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c1388e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=NEAV23lmAAAA:8
 a=VZB9oyRBYkHTOHfPpOgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12273
X-Proofpoint-ORIG-GUID: mk9AEEZohDPNDTgrVjAHx7Yv0MkvdQo2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMCBTYWx0ZWRfXz5Cv3qbEFT41
 VM2frxd8mvbAHg7llwj/9rz2Da8XxdrT0+VrRavl4M70+8NvpniPUUg95PmILBtqt8RPj9lbTJD
 obnNW+NcYQFsxZJbvH3TqjW6PJW2dfsv65+sHZSHQJnQ6HKzvwqF5EdMRcmc4SQffKHNnf0tTql
 Elrk2/Rz7sk07KzGcTgiMMAAmHF9VB/OfhlwaHUTukq+Kl4yuQuAdmuS/8O9D/NWo+lKB03LdSu
 ubEUXUnVrlkAt2OFMDMoKML6iLcNuFaHw95lpJlYsy6hzijyG9JTfQiLk2oH46nCmy4jqwWgvHM
 2jDnQhO3zY0J/IeQ3I+6kBUdCqzpPCdcyRJgXWHWXeFhyz2w3Gem8QddIu7iho1Y4vRL4urDJC0
 eIC2tSslwGXGrE4saF/U4GEnLU3dpK0RgSqycviOdELaYhuJ1LpjlCFXeE69bV0kTkv0icLpI/t
 /HK9hb18cKpkzIGKp+Hx9QmFVLAUR4CXKgrUMyYQ=

On 22/03/2026 17:36, Yonghong Song wrote:
> 
> 
> On 3/21/26 4:10 PM, Jiri Olsa wrote:
>> On Fri, Mar 20, 2026 at 12:09:22PM -0700, Yonghong Song wrote:
>>> Currently every function is checked for its parameters to identify whether
>>> the signature changed or not. If signature indeed changed, pahole may do
>>> some adjustment for parameters for true signatures.
>>>
>>> In clang, any function with the following attribute
>>>        DW_AT_calling_convention        (DW_CC_nocall)
>>> indicates this function having signature changed.
>>> pahole can take advantage of this to avoid parameter checking if
>>> DW_AT_calling_convention is not DW_CC_nocall.
>>>
>>> But more importantly, DW_CC_nocall can identify signature-changed functions
>>> and parameters can be checked one-after-another to create the true
>>> signatures. Otherwise, it takes more effort to identify whether a
>>> function has signature changed or not. For example, for funciton
>>>    __bpf_kfunc static void bbr_main(struct sock *sk, u32 ack, int flag,
>>>       const struct rate_sample *rs) { ... }
>>> and bbr_main() is a callback function in
>>>    .cong_control   = bbr_main
>>> in 'struct tcp_congestion_ops tcp_bbr_cong_ops'.
>>> In the above bbr_main(...), parameter 'ack' and 'flag' are not used.
>>> The following are some details:
>>>
>>> 0x0a713b8d:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (indexed (0x28) loclist = 0x0166d452:
>>>                       [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg5 RDI
>>>                       ...
>>>                    DW_AT_name    ("sk")
>>>                    DW_AT_type    (0x0a6f5b2b "sock *")
>>>                    ...
>>>
>>> 0x0a713b98:     DW_TAG_formal_parameter
>>>                    DW_AT_name    ("ack")
>>>                    DW_AT_type    (0x0a6f58fd "u32")
>>>                    ...
>>>
>>> 0x0a713ba2:     DW_TAG_formal_parameter
>>>                    DW_AT_name    ("flag")
>>>                    DW_AT_type    (0x0a6f57d1 "int")
>>>                    ...
>>>
>>> 0x0a713bac:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (indexed (0x29) loclist = 0x0166d4a8:
>>>                       [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg2 RCX
>>>                       ...
>>>                    DW_AT_name    ("rs")
>>>                    DW_AT_type    (0x0a710da5 "const rate_sample *")
>>>                    DW_AT_decl_line       (1027)
>>>
>>> Some analysis for the above dwarf can conclude that the 'ark' and 'flag'
>>> may be related to RSI and RDX, considering the last one is RCX. Basically this
>>> requires all parameters are available to collectively decide whether the
>>> true signature can be found or not. In such case, DW_CC_nocall can make things
>>> easier as parameter can be checked one after another.
>>>
>>> For a clang built bpf-next kernel, in non-LTO setup, the number of kernel functions
>>> is 69103 and the number of signature changed functions is 875, based on
>>>        DW_AT_calling_convention        (DW_CC_nocall)
>>> indication.
>> we don't display these stats, right? would be great and probably easy
>> to count different flags and aggregate them
> 
> The actual stats will be different depending on kernel code and compiler optimization.
> But I think I can still count them for each commit so people will know
> which change caused how much true signature.
>

I'll send a patch shortly that does kernel build/compare functions for LLVM/clang [1];
currently our pahole CI only covers gcc kernel builds. That will show differences
between pahole next and the current changes in github; that workflow has been handy for 
seeing the effects of pahole changes on the set of vmlinux functions.

We should also look at extending pfunct to do more stats; I've got a few patches which
get it to support split BTF and add a manual page. It has some basic stats if I
remember correctly, but it would be nice to extend those at some stage.

[1] https://github.com/alan-maguire/dwarves/actions/runs/23435796365/job/68173414313
 
>>
>>> Among 875 signature changed functions, after this patch, 495 functions
>>> can have proper true signatures, mostly due to simple dead argument
>>> elimination. The number of remaining functions, which cannot get the
>>> true signature, is 379. They will be addressed in the subsequent commits.
>> after this change I have more functions added (below) and I checked
>> few and they seem ok (w/o DW_CC_nocall)
> 
> Most global functions should be okay. But some global functions
> esp. if argument is more than 8 byte (struct type), they may be
> considered as signature change with the current implementation.
> 
>>
>> jirka
>>
>>
>> acpi_ex_do_debug_object
>> add_bits
>> amd_pstate_get_mode_string
>> dma_alloc_from_contiguous
>> do_set_pmd
>> dst_destroy
>> find_cpio_data
>> find_microcode_in_initrd
>> ima_write_policy
>> insn_init
>> io_tx_ubuf_complete
>> ip6_protocol_deliver_rcu
>> kvm_tdp_mmu_unmap_gfn_range
>> net_dim_get_def_rx_moderation
>> net_dim_get_def_tx_moderation
>> pinctrl_commit_state
>> string_unescape
>> syscall_copy_user_array
>> tdp_mmu_zap_leafs
>> usb_speed_string
>> __vlan_find_dev_deep_rcu
>> __vxlan_fdb_delete
>> xfs_bmbt_maxrecs
>> xfs_inobt_maxrecs
>> ZSTD_buildSequencesStatistics
>> ZSTD_copyCCtx
>> ZSTD_findFrameSizeInfo
>> ZSTD_get1BlockSummary
>> zstd_get_cparams
>> ZSTD_getCParams
>> ZSTD_getCParamsFromCCtxParams
>> ZSTD_getCParamsFromCDict
>> ZSTD_getCParams_internal
>> zstd_get_params
>> ZSTD_getParams
> 

