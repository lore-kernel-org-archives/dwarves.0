Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13348593C;
	Fri,  2 Oct 2026 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939016; cv=fail; b=vFu6+SmZybk+DRBE8yCezx6e0oj3vTXz0wz0BvRJoyu2dNXCtIF/4jm8uaEfHic8W0BXvDHGDjP2auA7j/gjsIVZvjYJcuBLUj/O9XX4ncHDhDW33V3zVR2jr3Rer8J/EkRr4t/zWikfLIludjU6giRtH1FR0P3jIGRHINZYtGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939016; c=relaxed/simple;
	bh=gGG8H9BQDA9II5cAqX2SwaltuAUd0ZPBgpfZzCyeDCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vDmSzSWoOVlERaoI/4kgOa6LvEEh5sl4X1J9ZXj3zuQubUgdiOsPt21iWJv0YMztlOPZOFFM41xyD/1foJINBydHENrEDxTfZgznDm4Bc8fWtwyshS9A7WyRYMyvraOtk/sGR+DAfHaKfp5THdfczDx7xcfmp3vM08wy56zleuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=asDHkg34; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j5ZVOgt7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="asDHkg34";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j5ZVOgt7"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6923ldis823461;
	Fri, 2 Oct 2026 11:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JKrIB7zGNuRaI/vhYWjNc/KO/AD6yHd1snB7wXK/+xw=; b=
	asDHkg34MBsERRmvJinpEG+g22wmdIIK1T9olosA05cdr4rXaY9dokPiL/483GbX
	pVlA8FNMElLuSfxoTJmtUE8RMBoYohmVvE34IfRPdJZmZkYMe803zQQgmfle4QMZ
	UTzDJ7Y9nojEYPsBBv2nNZnCP53LHh2k8tVii6qM9RlgyHaLGME1f+MBeKIY+3Pd
	yKGbPrvG62yZYyZ6E5P3Vk1uHRxdePCp/yzqfmMixAIQmw35cLQVqP2bwScl5Z3C
	7sXz9yexVkcZEyESEI2vbxoB6aLpN9S0EVNKx7UJXN4+HmoiG+Ob1nQGQji554ec
	nm4np6iVWIdvCknsK6h/3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbkrdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 11:03:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692AZO0K031425;
	Fri, 2 Oct 2026 11:03:05 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtd2uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 02 Oct 2026 11:03:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFbgxamuWe/ravQs6bcUvdR01OY4A3Jr08pLA4+06KeUvJ8Yk9NRd+C12ofeNXix5qjJsmplkavR3h1Zc87zRImukK8wzGBAf4KZXUg51sNPYLyughGVBYj5MZrswWSHxIu/3dwQTqXEfASZ9i9W8qxi4x4I7I8jFy61oZbcg+1OqDHj8LuWOt68kmP38AShJKxzpX9ruBruIeHsKsY3peVM+Olu3gXRAvCh+mftyq+XBFlYibrAIIyAjrDkQSN7wo6bh91zqUZeae7XfKI/U212WABByw7yePJUDx6O4ZaktUksK1u192QgydHYRekCRhwdQAxpMRw2/0L2uScuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKrIB7zGNuRaI/vhYWjNc/KO/AD6yHd1snB7wXK/+xw=;
 b=LZ0FGD3hAaLmgzyx7w0B7PinoDjJ5/9cc1cD+NYE4jv7h3z5HqMvHgD0fPlvGsQEyrnCwikjXbKnx29IJIC+pnKqzaKvG6hShXGboY7evlumqv4aB7fBLgOhVLNlgPNwvwAzieCDbrP67MyCRTkKvRVAqCggK3/JHyReGjTWbLvF6yQTLm7k10o0tl4a/Hsi2TOeth7p4UgysWVbisP+6tUG5ff0THuXyQiIYAGRyb/XUc4rwtFYrEDv3RZV2L+OxyAHPtdN5ICKPQfE62JlwX8zRmB9kGZr6x09hypU8JUadtC4JDR39Rxf/4zUvr2QpmVdj6280xqXhO6XIQSE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKrIB7zGNuRaI/vhYWjNc/KO/AD6yHd1snB7wXK/+xw=;
 b=j5ZVOgt7E/u6ha9RP/6Jx6YpQ/vuvk6VgyBPvB7WUc+QTGyE/+7iJExEPOH3/5Xxf+NiUzJudHIPhHI2INTqbJCdcoQT8c1GYcz66An1SAoWzebpU51mjhePxZaQIkFEGA9u2SyeQGwArtpCMBWTRiJsZsDttsj8YwNXsY8Gpq4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Fri, 2 Oct 2026
 11:03:02 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Fri, 2 Oct 2026
 11:03:01 +0000
Message-ID: <210d44c8-2404-4fe8-8084-31940d8aeece@oracle.com>
Date: Fri, 2 Oct 2026 12:02:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 1/9] dwarf_loader: Add parameter list to
 inlined expansions
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org, dwarves@vger.kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com
References: <20260925185200.1318067-1-alan.maguire@oracle.com>
 <20260925185200.1318067-2-alan.maguire@oracle.com> <ar0umERDiFj2sN3W@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ar0umERDiFj2sN3W@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DM4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 2283b5ad-a18e-4b7a-0f87-08df2074b98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gQZRMS/7pXvH+zHFlUEHTpZ2Ij6IHp/DHUNGTnMVrWyMq2tFP7h+/6uqd3XvWvz9WphiisAmsbxbxb/PUO4z9veHQJcLZx9DRZ2/hC+vGCynFmstg3lzAWOlKq5yn+pkdOEriwbYjEK+AhJ4/ncvZe6/z86cqIWDuj1a1SfRKRFYFPePHxU56yxE0muI29BJ/wHMKHYAVtMIr4koYM2OhJ2rTjgqQ6jvHky63AFGM8WxGpXPs/4wliol073/R/lnBTo5h/9UF4XLIZNdJgbYqKNE0AdzrNOpjssbR42KIw8PxJNdLbVgxihZAVUk4oS8gqDBTXIBEVWFcEVpjZkB6nbRTH73xkbnAznHW+r6f/5eBb8xgFrehyR6l+StCMUFtG5h/mTorI5oQRgnypdmKc8uYz5+MiwkyaBihWIrfGSDxC/XYZt1aqmQS2RoEEObuua+3DrQ5WhVI38LR+QbemSHIPUcLgpf/smn3pc7UsixjARIgnmPNIuP5n2KfzjiyycuZT7lqt5bnpqezJNLpbv2/27Jw3K94fgvFywga0BT25tzs5KlDDbL2x0x/RVxPWYQ0vGwwcIS+QnCyf2LYOP6xJPvSOWMDXX20WhUCMFBX1NhfB7rrrIfZOAKoVvjFduf0IzbqRzH0PJ1xeX4PBTdVdniqiN1vhzcOxlu6g8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0FUQmRlTitSdnRSUHJEcmU2Yi80MGJJdjkvK1ZmVWlZZW5DS0tSMVloYktw?=
 =?utf-8?B?Y0hpLzY2QVJXWlZ3cTd6WUpNMWwvdHJTemNSRVYvcmlLVWFwUU5MYXE1RGFF?=
 =?utf-8?B?R1AvOXNDUW56cER4V0tTVHlYcGpvR1dRT0Z0R1duWFVjajA0Q0ViTWVObGlX?=
 =?utf-8?B?OTd0V2Frd2pYMGQ3eWd2cDVFajVJNHlJY3hRMFZDV2Yxb0lXbzdaa3NtV1I3?=
 =?utf-8?B?UFBIUGM1N2lmKzVDby9VLzR6S2cvTDBoZC9OalM5MTZpVzNwS3UvK3dZR0dP?=
 =?utf-8?B?bG5sQzBEZFpZa2U2NjFuTUpMTWJXV1EzTm5sMUtNaEJaSlhuZXE4ckY4c3dI?=
 =?utf-8?B?N1ZjZUxKc09KNCt3bU1SUGVnN2NaUm9HMm8rZ1FsWW1sdVh3RVhCdFJ3Qk1Z?=
 =?utf-8?B?QzJpZHBzY3FRc1Z2bklSL2dQdE9NTUdFLy9XcktEUXZIM0RlVzhQTE43OGl0?=
 =?utf-8?B?ZzNXcnV4cHFXQi9vUWxTdkNSNVJESlhKd0xQVHB4TFUrMk1IU3dGVWo4eHVm?=
 =?utf-8?B?cU91cmQrSld4ZjFDbU5MRGl5SU9oQ0RXeE5xTDZzUGN1VVNBU0UyTlplTmlV?=
 =?utf-8?B?ZHFFdFQwaW10c3R4U2Z5eERPN1BObnAwM09BRThPazlRUGdmSXpuZFpWSmNK?=
 =?utf-8?B?M0hIVTZPZ2RJQjdnMjNJSlRIdVk3bG1IOHRXT1NBVlI0NmxiQ1QrZUZjM3ps?=
 =?utf-8?B?YWNGOU5WcEJldjdvTDVFSjV3ZVYvTlZheXZwb3haTW1UcHBBd3ppMDBlM1dB?=
 =?utf-8?B?Skg2ZDBtb0kvRWhtZlNtNVlXeldzRlRUWmhmaHRxdjU5bmxscG13REhrVVFt?=
 =?utf-8?B?eHdlZnBSY0UvcERkSDBuY3dXb2NRNmFabkVaZUdaMVh0UlFZYzNKa1VTcjBs?=
 =?utf-8?B?aHNSVU14RldNdVNEUFJHUTVkcWszandLU1d1R2tHaVNLTFhGVWZVRFNveXc5?=
 =?utf-8?B?eFVXekQ1OHFTUUJSNXhpYXU0RUtvU1N1VUxPOXZWV1BoWnJmY0piZUdRODAy?=
 =?utf-8?B?VVJaNFZnRm1aME1ta2NZT3lSS2tTUW0xQnhKcDlGSVYzbDQ4bHNuSzArNnp0?=
 =?utf-8?B?MnJrT0ZuOTc5VWQzaUlkamFHWk13N1BJSlE4Rjl1c29QcG5TNS9hWXZWUlZu?=
 =?utf-8?B?WFpKQzltaHcvM0lsRWdNZmZocmtWNkVnMENWbXl4Smg5UTBXR2xOMlE0RnFt?=
 =?utf-8?B?dDhIZzRpWk9vM1NHaFlxK2dCdlErUHEyUlZSZzNRZ2tuQ0JuMm05UjJ1SHRm?=
 =?utf-8?B?dFJvM0FmaDgvRUR2OXVTWEtBM2syY292alh0WlZQa0gvSVlRNE8zYlJHc0N6?=
 =?utf-8?B?Y2lzRDBLVW1nUE41Q2xJS0tJRVdiN2dTMjZWV0ZxK1ViOVJXamxZSTJjT3dI?=
 =?utf-8?B?ek44UUJvL1lBL3ZVK2pDZGdYaXRSS29tbDRJZ0luSWtSK0Q3YmlidXMzTm5J?=
 =?utf-8?B?SlQwQWludTc3WC9YNWdyQVR2QTQ3cjFDelhBVnl3Y1ZLc3NteWNGUjcwc0xB?=
 =?utf-8?B?QTVpR2hDbDc4cGo4bHEvQkJlYlFNM1hDWFpBWTlUMHZjcWwvU2VRZGNGMXll?=
 =?utf-8?B?YldjRkI2Qk5qZmFETWdYSnB6b3VWdEhNL05YLzV2SWhGU2c2UktpMHd1VjFu?=
 =?utf-8?B?K0c5ZTRnWUxmTUlRZ1lwQlJsa2EyT1IvalRxTlFFaUc1RDZWNWdNbk5zTHQy?=
 =?utf-8?B?bGhZeEZjNEtaR05KQTBzemtCaWJ0bkZ1cFhWL2VGTldIdXM1cHBla2hDb3Nq?=
 =?utf-8?B?SG8zN2QzdGlZdmY1VVZ1NE5TWGhhWTZ2SkRXeUR6V0JOUVhzVnpFc3ZpekN5?=
 =?utf-8?B?NkpwdUVyS1Q5SzgvS0hkcXk2SlkydzZhUzJpUWUzekNVNS8rVjhFMUIzbEl5?=
 =?utf-8?B?V2dpZHhVdTNlUXFOVlM2RWhuNUlhZDZDMlA3K1FmSXlDdTA3cHB3VDZtSHhq?=
 =?utf-8?B?Wmd4VWZ0ZktmcEVERmdZVmg2aitSblZSa2RIZnNvWEdBdmU1WmtoYTloeE1s?=
 =?utf-8?B?SVZaS0FTZXdzYXdoNGdVaE5Lcm8zOG1LWGxkMDdCR0pQUkdQREhmU1VqYi9s?=
 =?utf-8?B?aVRENCthaGZvYkJoWGUyM3ltV3FqMUNlQ3FRazl5L1RoVENaUlBYQUxTSmFB?=
 =?utf-8?B?TUFjeG5scUpyczB4Q2g2dDNNRm1HcmdRVXZ2YzFzZzFSZCtpMSt1c29IS09S?=
 =?utf-8?B?a1BtS3lZaDZyVGhOOTRpd2pJbHJaZkxhUVR2SkZ2UUV5NEgwNEE1R1A3TEp4?=
 =?utf-8?B?NFhJakhTWVdaeDBOSHoyQXdDMUJvTkRsUW1HVGpySWxyQU9zdzFrMTFzdmV1?=
 =?utf-8?B?eDJxNEpTOUo2RkRhWUZCM0I5dzFMQkZXRXBsazI1NUpvQlN6bUlFdz09?=
X-Exchange-RoutingPolicyChecked:
	mdJ0GlBEjzTx+237934rSZj5Bt81S9iHHZantAmnSeMynAcqGVviclFzdwFxEBH6NKXRXBK+lBK/8nrPu4IZ5t+th1lxU/x04Lt34dypKWNB2zkh/Ok05SM326dFFT2ESS1TENTFP3RZp5V0lL/dRDeAUl03qFjwq+lVeBIqSxxXKp5VmylBgTANKyTX9kTrtSBtJAS3047j2XLHgpox3KxSbyrQGFnHnMzuN9LxxSIJjLfC22/I4adZN9dFqwk/Ie7gnJXpQpGpNWUhs4HK7ZWyGXkzJpJkldK0TmsfA2U8IFmuHBQlXcWp/CDM0F+2nclLmKT32eDS9rA5ifO2pg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yqNXb59b50BNuYzo3PPcuvd63/UXZUdMts4JTMUUrj028LO3uJmzSc3CxOCQs1XriaaX2W8/XUKTKSTDHkhL3CARclG/aykBcXMZhMU0Ad8GY2KUQqcYtzZqot8z4jmWlj+buA1RiBlJaee+Bfu/R7n80c+L3dZnsS4lQVgO3LH4+bAjIFta31bUVIfdxs/1XCY7QoadYJUfR2rKIPecCARn9n49QIcZWSzRsomYLULbb9m/TwZWO6q9HghDmBk8g5mJ73VECU2jgjshepcgkaQEwD6fwNqaBO6PajDky1a4iubH3q8JQYnBOpoEDgUGsu0XWuRG7h7EqAUg7k3VjpI/Fn2b8Y27zldEHffGSYVvteYeN7/dB5qyHvKefDwLDf9tdOn32U0Qr5YIye5Vk5PuOu9n7RF1PbCqnABUjNeIsjkl5RVFz8kXkBk3ulRtA9CP2kbeL1qHy3oU4es3PsipXpGIiKkrofOhuGmvkWyKI5kFwpKqzR7YUc61RCgMtvruaQ63Btac8ImhwbEwD4YxPnV5E/vFA5CanOT8aghyb/nSnvt5UKkZWeD6NEPJyIclWboTGqVvAeQuiJH9uZZXjTCnQys7lTILDMnbBLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2283b5ad-a18e-4b7a-0f87-08df2074b98b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:03:01.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5BbqJ6T7o2dChskzfk+tJjhzOVlncAVTpOrMuYh0T3I6PUpDA0dGZHKaMbWxYLWi4INPj3sRuvTxAOueLYeSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020042
X-Proofpoint-ORIG-GUID: dxMJT9506PIvJQteWlefE5YIn4J29F0M
X-Proofpoint-GUID: dxMJT9506PIvJQteWlefE5YIn4J29F0M
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abf8f6a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=aV1XLGOmOXK1ygaX-YMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MyBTYWx0ZWRfXydqQgEy7ywAP
 pRoAwVo89eASDgwI86j7rz6QKURlBlEQBtrzyh6xVdQnYfun3UVSf/YKPHlURe4NJSq7iaTHsnS
 h2R0M9XtRLLbJ8/6NkgpZEuiYkxlzaUt0ZXsCR/EWp3PTA+8tgbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MyBTYWx0ZWRfXzhThsJFjbDhf
 mczPN1P3Pn1H7NbWeLazEPJxQWZVCsjhL3hPBQS4tXM6CuYNZ6UgwUeUTapQy/HYau0Vx2QgFW6
 VBc2OSSbMUvP1dsV2kky49NbEvUwMxgq0IIiZ5oEYJtzbRAYe+JYT9jkhowd9Lf7yvEZyhAzyt8
 Cy0pbR3reqHimiEZ8h1m42hXRpOi2eMx37M3mGg3dnSlTFiFQEiGOGCG0LbIi7aqEsnrAjEI9k+
 QjR98sBfmaqPqNxyLwncBVNz7uqgTC2IPKV3MP5Y12jKVCo7rkxgcTeWrE7CSQ/Hta+mAeILy/R
 p0B67gnCC5UdafkzfXWebErLdIXKcgWMYAKOsWDZEOv2rLy7tT9rzpHhz9uTTlUyFqbWYcO8PNn
 1H9pD8VIbgNUvfFObZMjPRHJl9y2szv/jgDL8yv8JCp/Qck9FuRok1dE6ho3gdZKTcFtd6amIaq
 10c0Wjf6RTDLXUHGFbz32oxCnLaXAF7yq6Nq/Ihw=

On 30/09/2026 16:45, Jiri Olsa wrote:
> On Fri, Sep 25, 2026 at 07:51:50PM +0100, Alan Maguire wrote:
> 
> SNIP
> 
>> -static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
>> +static int die__process_inline_expansion(Dwarf_Die *die,
>> +					 struct inline_expansion *exp,
>> +					 struct lexblock *lexblock,
>> +					 struct cu *cu, struct conf_load *conf)
>>  {
>>  	Dwarf_Die child;
>>  	struct tag *tag;
>> +	int parm_idx = 0;
>>  
>>  	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
>>  		return 0;
>> @@ -2957,6 +2965,7 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
>>  	die = &child;
>>  	do {
>>  		uint32_t id;
>> +		bool add_to_inline_expansion = false;
>>  
>>  		switch (dwarf_tag(die)) {
>>  		case DW_TAG_call_site:
>> @@ -2975,13 +2984,10 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
>>  				goto out_enomem;
>>  			continue;
>>  		case DW_TAG_formal_parameter:
>> -			/*
>> -			 * Inline expansions can have their own formal
>> -			 * parameter children duplicating the abstract
>> -			 * origin's parameters.  These are not needed
>> -			 * for type reconstruction — skip them.
>> -			 */
>> -			continue;
>> +			tag = die__create_new_parameter(die, NULL, lexblock, exp,
>> +							cu, conf, parm_idx++);
>> +			add_to_inline_expansion = true;
>> +			break;
>>  		case DW_TAG_inlined_subroutine:
>>  			tag = die__create_new_inline_expansion(die, lexblock, cu, conf);
>>  			break;
>> @@ -3010,6 +3016,8 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
>>  
>>  		if (cu__table_add_tag(cu, tag, &id) < 0)
>>  			goto out_delete_tag;
>> +		if (add_to_inline_expansion)
> 
> could we just check (tag->tag == DW_TAG_formal_parameter) instead the
> new bool?
>

yep, will fix.
 
> 
>> +			inline_expansion__add_parameter(exp, tag__parameter(tag));
>>  hash:
>>  		cu__hash(cu, tag);
>>  		struct dwarf_tag *dtag = tag__dwarf(tag);
>> @@ -3032,8 +3040,8 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
>>  	if (exp == NULL)
>>  		return NULL;
>>  
>> -	if (die__process_inline_expansion(die, lexblock, cu, conf) != 0) {
>> -		tag__free(&exp->ip.tag, cu);
>> +	if (die__process_inline_expansion(die, exp, lexblock, cu, conf) != 0) {
>> +		tag__delete(&exp->ip.tag, cu);
>>  		return NULL;
>>  	}
>>  
>> @@ -3115,7 +3123,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>>  			continue;
>>  		}
>>  		case DW_TAG_formal_parameter:
>> -			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
>> +			tag = die__create_new_parameter(die, ftype, lexblock, NULL,
>> +							cu, conf, param_idx++);
>>  			break;
>>  		case DW_TAG_variable:
>>  			tag = die__create_new_variable(die, cu, conf, 0);
>> @@ -3562,75 +3571,103 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
>>  #define tag__print_abstract_origin_not_found(tag) \
>>  	__tag__print_abstract_origin_not_found(tag, __func__, __LINE__)
>>  
>> -static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>> +static void parameter__share_state_with_abstract_origin(struct parameter *parm,
>> +							struct parameter *oparm)
>> +{
>> +	if (parm->has_loc)
>> +		oparm->has_loc = parm->has_loc;
>> +	if (parm->has_const_value)
>> +		oparm->has_const_value = parm->has_const_value;
>> +	if (parm->loc_const_value)
>> +		oparm->loc_const_value = parm->loc_const_value;
>> +	if (parm->loc_stack)
>> +		oparm->loc_stack = parm->loc_stack;
>> +	if (parm->loc_reg != PARAMETER_UNKNOWN_REG)
>> +		oparm->loc_reg = parm->loc_reg;
>> +	if (parm->type_byte_size != 0)
>> +		oparm->type_byte_size = parm->type_byte_size;
>> +	if (parm->passed_in_memory)
>> +		oparm->passed_in_memory = parm->passed_in_memory;
>> +	oparm->first_reg_fields |= parm->first_reg_fields;
>> +	oparm->second_reg_fields |= parm->second_reg_fields;
>> +	if (parm->true_sig_member_name && !oparm->true_sig_member_name) {
>> +		oparm->true_sig_member_name = parm->true_sig_member_name;
>> +		oparm->true_sig_type = parm->true_sig_type;
>> +		oparm->true_sig_type_from_types = parm->true_sig_type_from_types;
>> +	}
>> +	if (parm->optimized)
>> +		oparm->optimized = parm->optimized;
>> +	if (parm->unexpected_reg)
>> +		oparm->unexpected_reg = parm->unexpected_reg;
>> +}
>> +
>> +static void parameter__recode_dwarf_type(struct parameter *parm, struct cu *cu,
>> +						 struct ftype *ftype)
> 
> could this be added in separate change? seems like it could
> ease up the readability a bit
> 

ok so a separate patch to rework recoding/sharing with abstract origin?
Sure.

>>  {
>> -	struct parameter *pos;
>>  	struct dwarf_cu *dcu = cu->priv;
>> -	struct ftype *type = tag__ftype(tag);
>> -
>> -	ftype__for_each_parameter(type, pos) {
>> -		struct dwarf_tag *dpos = tag__dwarf(&pos->tag);
>> -		struct parameter *opos;
>> -		struct dwarf_tag *dtype;
>> +	struct dwarf_tag *dparm = tag__dwarf(&parm->tag);
>> +	struct dwarf_tag *dtype;
>>  
>> -		if (dpos->type == 0) {
>> -			if (dpos->abstract_origin == 0) {
>> -				/* Function without parameters */
>> -				pos->tag.type = 0;
>> -				continue;
>> -			}
>> -			dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, abstract_origin);
>> -			if (dtype == NULL) {
>> -				tag__print_abstract_origin_not_found(&pos->tag);
>> -				continue;
>> -			}
>> -			opos = tag__parameter(dtag__tag(dtype));
>> -			pos->name = opos->name;
>> -			if (pos->idx != opos->idx)
>> -				type->reordered_parm = 1;
>> -			pos->tag.type = dtag__tag(dtype)->type;
>> -			/* share location information between parameter and
>> -			 * abstract origin; if neither have location, we will
>> -			 * mark the parameter as optimized out.  Also share
>> -			 * info regarding unexpected register use for
>> -			 * parameters.
>> -			 */
>> -			if (pos->has_loc)
>> -				opos->has_loc = pos->has_loc;
>> -			if (pos->has_const_value)
>> -				opos->has_const_value = pos->has_const_value;
>> -			if (pos->loc_const_value)
>> -				opos->loc_const_value = pos->loc_const_value;
>> -			if (pos->loc_stack)
>> -				opos->loc_stack = pos->loc_stack;
>> -			if (pos->loc_reg != PARAMETER_UNKNOWN_REG)
>> -				opos->loc_reg = pos->loc_reg;
>> -			if (pos->type_byte_size != 0)
>> -				opos->type_byte_size = pos->type_byte_size;
>> -			if (pos->passed_in_memory)
>> -				opos->passed_in_memory = pos->passed_in_memory;
>> -			opos->first_reg_fields |= pos->first_reg_fields;
>> -			opos->second_reg_fields |= pos->second_reg_fields;
>> -			if (pos->true_sig_member_name && !opos->true_sig_member_name) {
>> -				opos->true_sig_member_name = pos->true_sig_member_name;
>> -				opos->true_sig_type = pos->true_sig_type;
>> -				opos->true_sig_type_from_types = pos->true_sig_type_from_types;
>> -			}
>> +	if (dparm->type == 0) {
>> +		struct parameter *oparm;
>>  
>> -			if (pos->optimized)
>> -				opos->optimized = pos->optimized;
>> -			if (pos->unexpected_reg)
>> -				opos->unexpected_reg = pos->unexpected_reg;
>> -			continue;
>> +		if (dparm->abstract_origin == 0) {
>> +			parm->tag.type = 0;
>> +			return;
>>  		}
>>  
>> -		dtype = dwarf_cu__find_type_by_ref(dcu, dpos, type);
>> +		dtype = dwarf_cu__find_tag_by_ref(dcu, dparm, abstract_origin);
>>  		if (dtype == NULL) {
>> -			tag__print_type_not_found(&pos->tag);
>> -			continue;
>> +			tag__print_abstract_origin_not_found(&parm->tag);
>> +			return;
>>  		}
>> -		pos->tag.type = dtype->small_id;
>> +
>> +		oparm = tag__parameter(dtag__tag(dtype));
>> +		parm->name = oparm->name;
>> +		if (ftype != NULL && parm->idx != oparm->idx)
>> +			ftype->reordered_parm = 1;
> 
> looks like we could end up with wrong argument index if the dwarf
> info is missing for the argument, my agent is suggesting this fix
> 
> it gets me over 16k changes like this:
> 
> -0xffffffff8100e322 [__show_trace_log_lvl+0xb2, .text +0xe322] get_stack_pointer(struct task_struct * task [const 0], struct pt_regs * regs [%r14])
> +0xffffffff8100e322 [__show_trace_log_lvl+0xb2, .text +0xe322] get_stack_pointer(struct task_struct * task [%r14], struct pt_regs * regs [const 0])
> 
> I tried to validate one against dwarf info and it seems
> to be correct with the fix ;-)
> 

thanks for catching this! So the solution is something like this

 		oparm = tag__parameter(dtag__tag(dtype));
   		parm->name = oparm->name;
  -		if (ftype != NULL && parm->idx != oparm->idx)
  -			ftype->reordered_parm = 1;
  +		if (ftype != NULL) {
  +			if (parm->idx != oparm->idx)
  +				ftype->reordered_parm = 1;
  +		} else {
  +			parm->idx = oparm->idx;
  +		}
   		parm->tag.type = dtag__tag(dtype)->type;

to ensure that we map to source parameter order for inlines, right?

Thanks for reviewing!

Alan
