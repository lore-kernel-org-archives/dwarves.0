Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3DF1E5B9C
	for <dwarves@vger.kernel.org>; Tue, 13 May 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175983; cv=fail; b=letk5KJSYPBM4x4bWXoH95r7cSQJO/lca4j6KO6oGpN9ZKrGLFjBOzCAsasr+/veea0sQ8E3MDI37Opt/B6spBAlCFMSLpKTWaXJ5MSCfBD/wEY8KlpX7H+2+RJBFqvjzcSmLAURz7P4rzVhdrNHrVkAQ74Ab2XCIamLmFUU3Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175983; c=relaxed/simple;
	bh=OQKRDCcHgmz9p5Zm3LXkcjfcdnRFWnCJXTI8tQdu5YE=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=QC3YbnthkMrJQNhiPS0z25+k0SzWUkYhAVSKSiG+c67ndA+mcGvaKyfVktG/AfkB73kPsx00/MlAcKSi/K9RovHEqCLCxniSWXPaecbyDODvKiM4Ml2ueRKujS6pmebkDi875Vo0WzIgfJZeuqA5TGwMNUz20YFv7iEEL4q220s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NJyYojVZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CCc9ruoq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NJyYojVZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CCc9ruoq"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DL0lBu021615;
	Tue, 13 May 2025 22:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=6q/njUO7CdYF3sSM
	p2ZHLa29rpahP4HIT67+ehxZMxQ=; b=NJyYojVZWlrfmtKrHVuwy4myzSAo8bVg
	CChPga9PZyWWSZmDEVstmHkgI8uQX3jCObOBNjqrSs3kkQff5BDnOkt6kXILYjmL
	8leYUrrN/iDLdR/dOmIR0QWbiSAjsvFeUz+isMiKZQMGB0aLBfp5atNByTwWRLEV
	Vup7B73zJ2YPgJ+DZGdguv58zxr3FVUhshapIXQ+5VG+bch2Xm964WqwUkX+9RZw
	fMROJqSGcL4mffmAFCLGL1PbgpCtO18Z8mMRYHMP9hfeLmd7fAj/f0H4rNbC3Yd9
	ZsT88hzaWfM+0mpbY4d47ypIxyNatY+aNwuB0rmS5aNuLfSpffmOrg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcmgcff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 22:39:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DKvApw033319;
	Tue, 13 May 2025 22:39:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013058.outbound.protection.outlook.com [40.93.20.58])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbs8eeam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 22:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZI5sspHYe0nApRd68HREmFEYLG5X8gKp2XTZHWT0WTclTuc133A+Ri8mCxZQDgZRAzadYi5wcfViSh0wNnQcryFCVmZ3SkW09spPhBZhPPNKlhZ2GvL3D9tIvLCQ3octI4bQ6IPODV1sbtmjsl0MVJIhU9r2kzI/osqzK8u9n2tkLg+BU69i8sAnwzMnmByxTAEuOwfuV/bDei3vQhdIS56DEW/vIYuangUgymUxNKIOVEUWfquvt1Y6AHcUsbNwfw+2QdNk8oAECA2fRd+5Tto0OMQCxiaZzC0S+OGcLslLRZCvyH2Rvdg9MbIfJHxgwF+yehgZcKoXFBheZra+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q/njUO7CdYF3sSMp2ZHLa29rpahP4HIT67+ehxZMxQ=;
 b=jKizNqqMi5av+dK7UnVRgfR9PPjwNElLIaBGEsETVfQmrE3MELWX7Y1TvwZczeVqiNsAwTzRBpB+0cpaG5BbL0DIzI7E8sMqvhY6CG0g/EnalfVMIisAYAaFt1Avquh8q/BIr+NgqWecCqEkyZiDfWQDawgPkrmFKZnIGQJcik2l3bFUcxa8ZlZXJFdVtjOpTLo5UzALdjk2cKlEJHEqNgkYHkxsDZ3fPSNYUyy1Kewt7Xa66L07VXbjkuphlIHG/m9BaEvDiiQXkW6GboWmTFnGjWq1RCfPoAsGIjYZxwj8g7cVYZpqJRTFoho9yYsCYcfgkB06GNTla8A252ATnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q/njUO7CdYF3sSMp2ZHLa29rpahP4HIT67+ehxZMxQ=;
 b=CCc9ruoqaya8H4e0jBv+iwtVMos7tCo+Y4dLTHx8PpvvB2YfmkiSS8nOk2fcQ4+VpLFUUij/y6rltotwkQV8HcskXbx9EBKmiJ/AFMbI+RZe4KpalsL1zIN+n03oDyiI6vURVtefKmOfiEwByw/OOfVHB9Gcxc8Mck+11NfKzxg=
Received: from IA3PR10MB8513.namprd10.prod.outlook.com (2603:10b6:208:576::12)
 by CH3PR10MB7631.namprd10.prod.outlook.com (2603:10b6:610:180::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 22:39:35 +0000
Received: from IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::dd32:577c:40ed:9823]) by IA3PR10MB8513.namprd10.prod.outlook.com
 ([fe80::dd32:577c:40ed:9823%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 22:39:35 +0000
Message-ID: <b3948534-c567-4348-990c-28efe144906b@oracle.com>
Date: Tue, 13 May 2025 15:39:32 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
From: Bruce McCulloch <bruce.mcculloch@oracle.com>
Subject: Pahole, BTF, and vector types
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:408:fc::18) To IA3PR10MB8513.namprd10.prod.outlook.com
 (2603:10b6:208:576::12)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR10MB8513:EE_|CH3PR10MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 951aa087-06f8-4b41-febc-08dd926f0917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVpnWTloeURTSTBPV2xoOERmT21ZZkFYdE1MdVgwVVl2em1Sd2hpa3M5MUw0?=
 =?utf-8?B?eFpnVkVTc09NK2MyU080NjlyN0p0MnZPZE5yU2puNDQ5aUtFN3oyVno4QS94?=
 =?utf-8?B?N0xsZEpwNEdLcU8vZnRvenQ3ZUFpQkxZUWFPazFaSzF6dy95Sk42S1JJdFFy?=
 =?utf-8?B?aksrNWwrbzMxZUpQdXRZdG04bmovRnE4dkpFb2pFOHhrK0lGeERVUlRLcjNK?=
 =?utf-8?B?Wm5wRXhOTlFtamRtUGN1cVJlaEdnSWE1aUdRbkhaTmYvdVF5U2xQUjZmRjNJ?=
 =?utf-8?B?OWFRam9PcEpNa0ZFSWFBTFpkRGV1UlJibWxtNjZmaWNCUVZtT2Mxb2NkNDI5?=
 =?utf-8?B?cHF2Uk0vVHFqNUxCeVhJOTdjN3VoNmVvcllyUGtyNVBpOWx2T2d0WVFkclhG?=
 =?utf-8?B?WlFQeFNEMFd3VmFmZUJaYTRhUkdpTnFDZ2tPUmxGdU5OMFdSbTJCejhQdzRi?=
 =?utf-8?B?eEROaHNkK2psVTlpMXk2SkhkRHpEa1NCVXFUMzlJT1BlWHZMWEpodXFsMXhi?=
 =?utf-8?B?WE83NXBPRzNsKzZYMklOY2RxTnVRQ0VPUVFYL0o2Z2J0V1lrVHZkNDVhTVh5?=
 =?utf-8?B?cUVGNE9pdlV1YUpWa3RrMjdaUFlBTFpoZDlwU0dzVktDcW5TVmN1bUhUVGNs?=
 =?utf-8?B?RFJQT0VVeTZhcnR4dFBjaGxOOURxNlZ5cWdEdkZPZTJCRGlLbU1sT2lKTG1D?=
 =?utf-8?B?SjBXalZUeW53VUt1eUFOU21Ncm5NMm9pbktUdTIvZjIvR0gxbWJHdmFoZEhU?=
 =?utf-8?B?M3pwMmtUWjBKdm1hN1Z5NkpRaHFXVUFPc3dCK1Y3TUIzUCtteXpTYmpmdkgw?=
 =?utf-8?B?V2I0dnE5NW1EWGt4a2RqWldwWHNqcDc0UWQ2KzVvN282V3NtRjI3UFZDYUpR?=
 =?utf-8?B?TnlUc0k1R3FDSXVjSjJhTjIrUUFESXFGd0h3cHlBMkk0L2VLa2szdnpvQnAw?=
 =?utf-8?B?bmJYVVdRWmpaTTdwN3dGaG9raVFoTkpCcUtsTlFWWmpZSGMrWFlvTzFSUFpN?=
 =?utf-8?B?V2NmSVNnSGd6aXFGTEJCV1BGZGNQYWJyRWpPN0RISWdpbFY3QzgyZm5RM0Zz?=
 =?utf-8?B?NjFRL0dFSWV4RXhtdGQ5RjJnUGxwcXVsVzF1dncwTlJoKzhuMzNRTE1kZm9B?=
 =?utf-8?B?NzM1SzN3dGVMK1YrcHluaXBjSjFBa2twd25xL1RoQ2swNHFxTnF3bWtBNnY0?=
 =?utf-8?B?U25oL1BQL2lFWC8rZkE0bUhzL21jTE82enRKU2R1b1JUR1hZNmNHOC9RM0Fi?=
 =?utf-8?B?Y3FsNVg0OHU3dCtJSkp5bnFaTTJjNk5WeG1sd2lEWmRqVmdmb3NwODZoQVU3?=
 =?utf-8?B?SzJmazZueUNhSVRxS3NvcVp1cmFCSXJsYmQzQmR1SXIyUVZyRHJmdC9MTVNI?=
 =?utf-8?B?M2lKa2kyZVhZYXl3VmFZQldrVUY5VXJ5MjR1a3Z4WFoySkEvcGFWdFJDMmRL?=
 =?utf-8?B?ZEpiWXNnT2JYOS9LL0EwVWliUW5GR1JJMXZETWhONDdmZTBEajgrQThXUnhD?=
 =?utf-8?B?ZEduNTh5RHd0cWJoYWRFeGUweDZiM3lJZWVsYnQySTIwL050elZQZW95b1Jv?=
 =?utf-8?B?THMvVzNsTTloT1BOSDRyWjJQYlJCczA5QWZuTXJkL1ZDck85YVNsWm5oMFJF?=
 =?utf-8?B?WVgrbDc3SW9CWUM1OVFWZVZVYWY5NTZNOTZkTmtEMmNCNFdDNzRrdlZTQ3Zn?=
 =?utf-8?B?ZUFBMEtnRy9JVTMyL29CL0diWFFNd2dHaFM0Q0duVFR2N042b1FaNUMyY3ND?=
 =?utf-8?B?QjlKRVJBOVBlcTh3dXNIdjYyYW5tVTFNYlczREw0RHRUQ2dtU0dtOE00NGx5?=
 =?utf-8?Q?ykzymMXIOu19AGlyguIs1I4kuySS1zusOCAHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR10MB8513.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm05ZWYvRXdHRm9GSWhQTXFHMTBTbHVybWh3YkRBOUN2bXZ5Nnk1eFkweEpi?=
 =?utf-8?B?dXJsbzBHaTVsT2VWbkVMMmh6VnVrRnlsN3dpRGI0RmlEeUprZWhqUUdyVHN4?=
 =?utf-8?B?TkJxaTA2VFk4YWVVUndBRyttWXlndDh0K1VPTE5Yd2tydFFxVDIzemovWjMx?=
 =?utf-8?B?bFJCb055NFp4TmdWUmdOdzBRdjdVU0Q4S0hFb1dJT0hGK3RGblhTdlhCejM1?=
 =?utf-8?B?MTNFN3dGTWdzR1U1bG9CU21XZ1JUMnIvL1hRMDVCT2FkRDZTbVVqTEh3eE9I?=
 =?utf-8?B?RlV5bDY3citqRzdXdW0zYXdUeXdtdkhYMzZqeGtFMDF1Qk1ES0NScUdSZDU0?=
 =?utf-8?B?U0xJbDIzelVkQy9DV3E0b012TzJCVWRFTUpwUlFJUnRXejBVRTZOUWxtTTND?=
 =?utf-8?B?c3FMdzg5SWZwVDZ1L1FseXU0NUxMS29wY2FwUXdyYnN5SkNYanBLcnBQV3Np?=
 =?utf-8?B?Sm5sWFliLy94N1JYTkJQc1BRNkVFdFJKUlhFNmp3NGlhdGxSRk5JQkEwcWR4?=
 =?utf-8?B?QmdMQ0pOMWt3Z3RabldNMHRrancxeHZXNkJJK29jOXgwNTNQdXhnRFhKRUpN?=
 =?utf-8?B?YkpScnZDUFdpRWdtYktyV0xhUnlVZ3JKeG1MOWRLWXFPdExLUVNiWkE1RXBN?=
 =?utf-8?B?ckk5VmdBcm1laU50akZFU1FTeXkvamtvV2RjNm1iVVJvdDVydFBSam4yMlhW?=
 =?utf-8?B?ZlMxV0pkZE9ULzFCNkZab093aHg3TVVaL1BEYnZaRmN2cWlOR0NDWkN4TkFh?=
 =?utf-8?B?dTRZS2g0YVBmQUtSQlo3a3VkMlJwdFRDMkZnNXhRaEd1K2pERlJTdkFJV2tI?=
 =?utf-8?B?SnF5OTJIU0FHc1FJRndQOUc2a0JKVWdId1pMMTBGOG9FY3pxYjVmVGNBTGM5?=
 =?utf-8?B?Sll6WFVUSUtEQlZGd0o0RFA5U3EwMnF2NHJkNU1uWDc4LzBlNEkzdmVOelN2?=
 =?utf-8?B?U1JtejhSMUFSbFk2Rno1VmZtMDV2U1B0cWVLbExtaGdMVVZDQkxyTlhyVUhG?=
 =?utf-8?B?M0w3MjlaYXI4T1AvTVJEbHdtWUgvbVZGYkdQKzQ2NGlkem9Pajd4MkQxWWlE?=
 =?utf-8?B?WmpDbG93YTA1cUNvZEg0UVNwd3VOTFNFa2JHaU1ZTG03KzJLWjlBMzYyUm44?=
 =?utf-8?B?Z2tLS050TVRZOUtEY25scm5qc2hpdWZSd2dtdzFpOWJ6Q2txcUwwcmt5dTdR?=
 =?utf-8?B?aTY1Zzl3OHhJNk0zWnJnKzFHSmtyazI0UktrUSszRHlkTkVORVVWdFdIUG0r?=
 =?utf-8?B?VGJHd25qMWpuK3B5RXFHV1JlUStIS3MzRktnbjlUSDhoQkt4aWlKcnhRdk15?=
 =?utf-8?B?dFpSMTJEb3RtL2hLYXpIMkMzNXVweEtiMUpZTXltM2JxenZ3anR0dkl3N1hk?=
 =?utf-8?B?NCtoS2NvUjBhV2pNV3c2cGYzVzFFdHFVVzNFUVZUMm9JbVFnOUhmbE1acnlj?=
 =?utf-8?B?TVVONkdhRE51d0VTZmZadDAyaDdMT293Tkg5aDlYTTdya3QwcElzRlpBMVg3?=
 =?utf-8?B?cTIrTmhDSU50MDZVT1NkTE1YSmdnM0o2WTEvSElEbTZkc0thMzI3dGxaTUps?=
 =?utf-8?B?NUZrZFc2Tmc0RFc0bldEWVpMd2lnZktUTmJEZzNJckdwSjFKbGI2VWxOVHlL?=
 =?utf-8?B?M1FNWEJ2Y1YzREVXRzFkdHBzM2Z4aTAxV0RrYXh4NTA0WFY4RytSMTRVVEJI?=
 =?utf-8?B?QjZZQkwxS2pYSUFYdk5iNVhRWTZjVmlMUnVURjRUWS9oWGtwSHFZSWp1SWlH?=
 =?utf-8?B?VEZSc3dUN0Z3WDYwSG5kQWJXRDFZSys5a1hYcHhiOHNjWExkamdRNkdRa0Q5?=
 =?utf-8?B?U3hQQTgrM2FZemVaM0lyTzZUaUczc1V5RVVXRmFheEIvMzVRZGd1S25JbS9w?=
 =?utf-8?B?YmZGcDM4S0k1SllaVDFCODFRVFZDM2xkUDg1U2lyQ3hWR2pyenBtMVoyMUUr?=
 =?utf-8?B?VUE0aytmY3VyUmtKci9lSnBJTEdPejlyL2J3YVY4NVg5a1NraUJIV2c2TXo1?=
 =?utf-8?B?bkdSRllIMGdlcGJDMDYreHl6QTZ1VmtHaCt2akJ3OGFSbU93S1BjT1ZIUWRw?=
 =?utf-8?B?Wmp0Rmh2MDhrY3VZOGNkQmJlMFl5SnVNeHl5dzlYY2lydDdBODhmeHRJbmd6?=
 =?utf-8?B?REwxQWJYS0lYT00ybU10aW9wUGdPaCtlN1Z1a1ltbEwzVE1VRTNLcUlNSjgw?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9KvWmQ9u7ebG3E55XaTp/5oeDWntu0LabWtDUVgZPnJIHLIRCG0Q/q4i9ZhGPfsFkjT6+JYiEQbmD0My6/5bvtKzEusRr8r+IZchjpiZN6xGgk+36PptjUpKkPZ4gY2+D+m1E0OIUiRt+eO5C3nWIQWXOK7QFh99DLJCNArCYVL5NNtLXLCX6eaJxX6GlvE5UcfmUWLuBEWbSa3qiROIMmLL5SvUdN1RV/flsmxmlKXvd9oCgwUOZas9VszlsyMpsn3NVMo0cE2UOIMMyt/eC9v2EHz+sSwlxZTXDem4s/5COmViyO4+2HdgyUI5K6SIy9aR8a2m1Rcti9ObuZ6W/fU/KkQSs68KypoMNlTe0MCSHuq1MwOQSmijNt8WJ6YK9VFMDgNBpan9dEO5m5qgKLZPDafIyQ/8MaXOqllRiCbKnXJiZwmGHR3yfKq45hDZurrtQWbqqx4+KSZY8FVp3XmQRa9QQ6myyM1qyWf8U3krDiZKtFeVRxNBlyUnB2lqL65cQcMXMfXIdzwZCMzQlQNklp0ZDqv0nbVoNvrySdrur6GMcZsPTP4P0b4Ntmcvb0OR/En8ihaZbt+0dLpN7VfCR/8Q1woIeR3S2WEEsmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951aa087-06f8-4b41-febc-08dd926f0917
X-MS-Exchange-CrossTenant-AuthSource: IA3PR10MB8513.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 22:39:34.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QFFAdjJA2BYjB25j79uyVVWuagsuBkVlKZUC7X/ZMaokr5D0nzNf67ETc0PTiR6DEhdk9TFWQkdEzqGwSQqTTudFhSlZI4Q1R4/z3VZ0Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505130214
X-Proofpoint-ORIG-GUID: AVYQ1dEuFwXfE-ZuYZv7snIBassHEF-A
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=6823ca2a b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=p4yhxsxNAAAA:8 a=AxSfRC0JwFwEq0eBWVIA:9 a=QEXdDO2ut3YA:10 a=yp-Zx5YoBjEA:10 a=4AvGVvso5qoc5vnZhopw:22 cc=ntf awl=host:13185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDIxNCBTYWx0ZWRfXz9w+0Jcv9IEt FNytVwjL+mXKLcKEKV88dF+dOnz2VmLdiYJDhH3AUwmTEhdSFqpdI1RPfg8AycYxxDdfVzdxXkr tlMhJlDzMRZO1JTIbI6wZMIhJCKffHsXIHUcjxp9n4V+TnMpUGJvfrTxLtemv0Mh5KxhLeMbxvl
 ZzYKw+z5OowB086VxcVLj6hyknnmr/1zWoCHXKzwGuRcClLncl9HNH7fWH1+7JBCaMpAx5ge7Lu jEQ/yyymb4hCEtd31+htYmriYbLJfYZOynNC7pMKRZq26+8ydDuEWwAGmUkWN2fPdFRxA0u9PSA xm6PLsvTbTyQ/N8YUj/Svnrw34eORY7+BHGwO5FoDmICt4Z50v0wDSobbG3C5TMdDqFtfC7lAZd
 wySgST1cZ3ID31RaqrV2v6+4fLCjCCkTrDUwBA/ukLZFhxQbnbmb4cUYeNt02/70yLac6Bt9
X-Proofpoint-GUID: AVYQ1dEuFwXfE-ZuYZv7snIBassHEF-A

Hello Alan, Arnaldo, All,

Recently the Linux Toolchain team at oracle had reason to start emitting 
types
with the vector_size() attribute as arrays when compiling with 
-gctf/-gbtf. This
is a change from the previous behavior, which was to emit these as unknown
types. This emission as an array is consistent with BTF generated in 
both clang
and pahole. We have some ideas on how to implement the change in GCC, 
but were
wondering if anyone involved with dwarves had any insight into why 
vectors are
emitted in this way. More specifically, there were concerns surrounding the
practical differences between vectors and arrays in the realm of memory 
(e.g.
Vectors can be passed as args by value, while arrays cannot). More 
information
about this can be found on the DWARF std issues list [1].

Any input on this subject would be much appreciated.

Bruce

[1] https://dwarfstd.org/issues/230413.1.html

