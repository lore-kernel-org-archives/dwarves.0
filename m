Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4121194ACB;
	Sun, 15 Sep 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400997; cv=fail; b=CeFUpqONp6NtiYxspRIiRUA2Bie6J+EA6TCTZmkiwdqbvUpuV+B47Q96HLqms0o+mZfkAPo+NchWLjC3HiskcZO1kdKZ+iEYd2yTWKdT+1EItc/C+B1i1VvHXFVAvQZfvCpMAyityGNDZfxXV+FgPwHhEbE2sH7VW19qGtZSxWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400997; c=relaxed/simple;
	bh=BwDOwIx35iDO+jlhBh80AzWFIkdSXeUAh9bF80atXsg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ufTo0Cc95rYqKtKGCjf17UmfrLqKRVaLf7nsOrXvxVuYio6PAkaPcG+PDkgVUf9W9aO4dEiVP9z4IugGOocECMy4zOk6cZkToaPG9Hkcf0cUaUuQJHEWPhDrR1zaeLURR+eet9WsFPyJXfBTvdlFc3dmWtFOPl4CWzpPUMLgtpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PZA5jste; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DXIpbIhS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PZA5jste";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DXIpbIhS"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FAkwSW031681;
	Sun, 15 Sep 2024 11:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:from:subject:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=rgtNkhxuuRldQuPcKfHQwXIAxr+FqVrLLyAYJSTwsfw=; b=
	PZA5jste8iUSG7n6VC/G2V/H7F1eblss26EP3pRxBFH4kStRQq/y3V8G/p00Nfn5
	RaNes2Ho2w30uRkp3uWaDr3qWBdexXVoGvTO7nYRwAHsaLGv66cs7sZUfshVOlaR
	SCHDf4hHN9BQy7ACh5rLzEzO1dH5sZ2t6KVvecVS1krOq6YXpAE/ziPRIU9cwd+c
	LSqJkbwuG+2+W9Au7FC1XD3JEV1V180UCj7ErbO7pjUDmrRYUbUoU1sfCgAPfzES
	rQvtD/fT/KbYgbo1mmWmB1EpVy3UXPR2PwjK9Th2hJ9srxYEehGCrV/206gFm6qu
	qns7yiECILSnYiGSkEWhGQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n39jb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 11:49:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48FBBoX9034697;
	Sun, 15 Sep 2024 11:49:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0xd34nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 11:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8NfHGBE20Qj/Cx9iVy0e7F62zl82Hk7NEgxd2rN72OUObs5VoUDse3ZlG6TrvaUkA2NZX5lc8a9ufiSdGO5m3TImlGKAWSku5Eo8DHNL2S+PGyTg3yEI+FZYw6R2jaoGC9o6cvEPHuIN/qfkPHnw+A3MdemoIJfdwPVm3mJ29XYVcNA4KRYUGHgrR1tMeTLTwkN1eDutPb49VzMZUBke5joyMTbLCwLgG5nr/rbHtorSuXY+WhYu509J/NF1h4ntMaQuMGlBn/zPyIrpRo0mOnv1Q9eSJlcUZq2lEkMMIOM97+HnZ73jigZPSCtKT2UsOc/dorZyRVfBH4D7u0CZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgtNkhxuuRldQuPcKfHQwXIAxr+FqVrLLyAYJSTwsfw=;
 b=AyKr/niNitAZ+uYeUsswQHn4Vp3jI5wQrJrOaKlcJ8NoHhqoPgYv4pm2vzVGIFFdkYF/5cCK2tp6VdFqbWLacDKNv58NESdD1wXhf8/K5bz8Vzz5RWRIDYkgzN/6p3OdiRv9Z9nlhodaeofrkm7PyY9gEgmOfL7tXkzo3qB3s4/uvM6mzCjXau4m1Udjue4IsFGKQ6V1+9Z617W276MeToCbK1hg77UkoO/ZQvknLlUYt4qoYgriyL6hN8/rwhYQ+ipfp2i0hASfpl2yrYC9ao95hg+45Ui53oMZVhCdX/gAu4F6rW5S7YjY69bxmB43ohvRBw9B5c05Yfigcl+uUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgtNkhxuuRldQuPcKfHQwXIAxr+FqVrLLyAYJSTwsfw=;
 b=DXIpbIhS7YToA4dkxIZfIj4Iv1qhousZDetvX72Acx1vGOpHTar+2t1XsD2zK+LOTTfHRnPx+gQpU1NL2Zff3pENDDeDdDAC5nOukP1T0qRbULfHiVAW0SM4c7JpH2ZKTXyiDWc4L5tgTHHqQLM0A8dXCu8Ldt5lDdl1qjeI3rI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7930.namprd10.prod.outlook.com (2603:10b6:610:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.11; Sun, 15 Sep
 2024 11:49:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7982.011; Sun, 15 Sep 2024
 11:49:42 +0000
Message-ID: <491270c5-f756-4c37-957f-5134f1f13bcd@oracle.com>
Date: Sun, 15 Sep 2024 12:49:37 +0100
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves 4/4] btf_encoder: add global_var feature to encode
 globals
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
 <20240912190827.230176-5-stephen.s.brennan@oracle.com>
Content-Language: en-GB
In-Reply-To: <20240912190827.230176-5-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0050.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe65831-09ef-42b2-41d9-08dcd57c7cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE55OWV6M1RyN3crT0dxbCs2V1N6ejBqZENGUWNhN0hiMEFsbTBIOXpSZ2d2?=
 =?utf-8?B?SW45NjZXV0NLV0h0Wm02QnVvZUEyclROZUZyWWRCRHBVeFRrNUhVZzlCdGkx?=
 =?utf-8?B?dkJleWFEbm9LUWNmNjFWT1hTSjVBR3hYak1oZWhqUWhqU3NIejk1WHFMcU8w?=
 =?utf-8?B?KyswZTB1SjZwVWw3VlZXbjRuZzNlNTFPTlZwczRDeHJITXdpY1NHU3Y1ejJC?=
 =?utf-8?B?QkhKTUdzdDVMSnlkd1l6TS93WlNqY3ZzUTlQUjNsV214OXNuc21LejJQOXh4?=
 =?utf-8?B?Y3FvV3B4aVZ5bmlGVnBPenBQQnltRitqdnVmWVMzMDdvT1MweS82MExnTnJD?=
 =?utf-8?B?ZnpSZmRtN29PSkcyT0VNbmd0aUVCcUNLS1ROendicE54WHl0Nkx6emduM3g5?=
 =?utf-8?B?cnpDRDljYlJhVnp1akRyWGtBb2p6UmpoOTVXYXdFbW1DOWV1VjRCVS9tV2J1?=
 =?utf-8?B?cVdJSFgrYlJSU3BVYVRETENMK1F0S1ZyUTNpZGZxZDZOMlZiSjJ0TzhMczE1?=
 =?utf-8?B?elVmVS9aRXdsYUFUU2hiUU9TbS8yc1dvdmUzbVoxK052Y05FcHp5UUtoYUI1?=
 =?utf-8?B?R0dCUUhERnhyN3QwUFJ6UGlhQXM2WGt5VzRyR3hIZ3hBRCtDb2RSWU05MDZI?=
 =?utf-8?B?MThza2tnZkhyTDZ5aCtTeXkraStJcVpDYi9lbGk3VEM3WFhzanpzVUlHYmxv?=
 =?utf-8?B?QU5YYS9tUWlGaHBNTUovbzk0NHFDRm1DbTRrOEJGZU1CYndKc0kwcTdDYnV1?=
 =?utf-8?B?aUpVZUpkV0pUd2tzQXFNVFQyWWg4ajE1SWtET0VrcVF4UHhoMVAvbTBYQVZy?=
 =?utf-8?B?NkVQNkpldjRnSk5zcjg3Kyt1a2FBNHBZaityay9RMTBrMDk2SnN3RklxMHVU?=
 =?utf-8?B?cmQ4VTk4RFhZVnZNSzA3MnJHRU16UzF0RDlNc2VlRDN1eldKNFMyNGY4VTgx?=
 =?utf-8?B?TlFDd0U3amFiRU1LdW1Ydk9hTVg0bUJHYkxKTjdnYjVxRlR0K2ovTW1LRGpQ?=
 =?utf-8?B?KzRNTmFRdXdKUTJ5RXlLVUxZQ1oxckJtcmVXYXhmdklwNDhndEllbHBpY0Zo?=
 =?utf-8?B?dGpONGZKSEwwLzhXeTNkMEV2R2lTQkxZcEsveXI3ZHc1NXVOTXVHVVE3aTFy?=
 =?utf-8?B?NlBlcVExa2kwY3ZIYVFRRjRHMzQvTW1zaVdoellkRDYrazF0WXlGdVFrOTUr?=
 =?utf-8?B?TDNPd2JBNjJNMXYvQkczTkVPc1dwc0VvRFpjK3pMRStEYjErRmsxNmswOElH?=
 =?utf-8?B?bVc3UXFUaGhMK3BrYWVmZDNEMWtkM3M1N3R4d05Nay83RXFxTjJQNHk5ckVN?=
 =?utf-8?B?NllqN3hGakJaNjBFQUpBL1VmTmdaVEhnekF3YlpHemNYOGh4UjZVcGFDNnVH?=
 =?utf-8?B?bndGSForZVRIVWh6czNtVVYybEVKb1BCV1hGbmdQclB1SGxOMEJuTXJSM1p2?=
 =?utf-8?B?c0EyQmVhelZKUDJ5cmJja0JPV2plL2dHOURueVBzYTBJbFdyV1lpcWIxZk03?=
 =?utf-8?B?R1BJaXhsSURTNitJWCtyV3oyY211VlFjM3B3QXQxYjVzZU0wZ1NkYnFGbnp2?=
 =?utf-8?B?WUwvbTNvRjVLSkF2QnZUQzJhWDQrZkFsRmZuVXJrZjNBSkJ4VGJIckZYYm45?=
 =?utf-8?B?L3hOSExEQnlrWGJDNnZvV2pMVkwxcytIZXRNaFYzWUZIS1VLbDZHNitWYjVD?=
 =?utf-8?B?MVJINzc5d1dXQkNMa0JwNjRFOXBCYlFaQ1RIUnBhYlNIRzMxeDkwUTFCMEls?=
 =?utf-8?B?YlFzRVFPazQ5K1RyRWc2WXYrMUVvenczMk5za0tMRGVFY0VtRnFSWGZSOHNX?=
 =?utf-8?B?NkNxeVhsS3ZtanpPZTgwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzRvbWtkL1krNXpKbGFTand0R3dMcnZNSWxST2VyV2UxUWNMZno2ZTVlcWdW?=
 =?utf-8?B?QklFNXZTOEg4UGRoengyNVdzVlFFNzFNRGVTMEIrUkpIZHZBc3NhRWJleEdH?=
 =?utf-8?B?N3dlNDJQNkQrV2k0UUtEQlovTlgzRFFiS05OQlIrUmluSlkwdmVweW5idHVX?=
 =?utf-8?B?TUxrQTQ0aUVKRjZldGZkMjdKMmRLZ0lDRjYrYlhrSkdIVWd4TVliQ293MVZo?=
 =?utf-8?B?NWtrWTBxT3haNHRqNXlTL1IzelZteFpiNmdIR3E4dC9sTmhXNVF3Q2dSR2hh?=
 =?utf-8?B?TXZoait0cDZTK1UvaG1YeFBCOS94N1c2dDYrZ1BrTjF6THVvTHhydW4xSHI3?=
 =?utf-8?B?QTUwRU43dlh3OG5rdjNjWmpuSjFQQVZKOTdUbVUvb1BmanZxd01sOHVsOWVt?=
 =?utf-8?B?MVc5NkFEOU1zeHZUM3ZFcmdhdVRQS3VXWXBxWjBKRGRlN1BiYlhLOWpPdVQz?=
 =?utf-8?B?aTdjcVF0Z0FKb3hEWElJR3c4MVhaKzBvR1dPSnQzOW5oTjdFRVF3MFlkeExm?=
 =?utf-8?B?Z1BzaFhENUdSM2Q5c3JBVDdjWSt4eVo3eDM5QU9wRW9uVlY2RURITDA2dXlj?=
 =?utf-8?B?VHNjL201ZU1SS0dtTDdoMk1OYSttcjdndWpiK1V6N2lFZ3Ntb3crelRDQUlz?=
 =?utf-8?B?M3pUVGo1VGZvNDBTU0lBQ1QrUkpTaGNjc2dVSm1VU0FtN3VhRjJ5RnpSQUtC?=
 =?utf-8?B?UkdlNHdnNXpESmNsSDVmckc4SnpTbEVmNjBrVW9WcnFha09FM0wwS2lGNUF4?=
 =?utf-8?B?dXM5UTQ3VkdQanRvZ0pVc3RYQ3lVajE5R2lvay9NdHdlUkM3MDNiNlJ2eG5Y?=
 =?utf-8?B?bVJpeUdhL29sbGZ5ZlFldVZXK3EzbjBkODJ2ekZVRTZ6RmJ6a0Zic1hMMXB6?=
 =?utf-8?B?NERYK3hRRDBDZE1IVTk4bTRYdlFxMEhPZllia01ZWXo1ZEc0b2hic043ZEd0?=
 =?utf-8?B?a29yODZCak9iNk5DZTA4TERjZmJtTXVCYUsyWm0rUE5EZFA3SHZUT3pzYXM1?=
 =?utf-8?B?cTV6MmoxdUpnY0srNG9sc3pqcVZRM1JTclJBZFJHcTNpUHBpd0ZrdC9YR0dT?=
 =?utf-8?B?NEJsVG45aG40Slp4bmordStRS3dEdlo4Ti90TWg1NkdReTVsNDhOc24vWUpk?=
 =?utf-8?B?cU4zTmE3czAxMHQ1VlBZRmJiNEdmVEY3NjJJbjNHSDl1QmhTUHQ0SGEyN093?=
 =?utf-8?B?cFR3M0xEQ2x6K3djc0Z2NC9aTk1CQ1J1WHEwbXI0UFJic3YrVllXVkNTL3JX?=
 =?utf-8?B?cTMvMmNQMUJBRUVFWjM0TmNiZkpFakd0aFpJQTAzQUFsZmZIQjZoYWxJMnVh?=
 =?utf-8?B?V2NIUmFGSC9Od0d0dG5ZalZXK2VQYStKa1ZVWjlzVkwwZk1xUGJlQzcxWU9x?=
 =?utf-8?B?TENIV3RMWnJJamZDTms2UmM2QXJJeHdKbjVpWGhVRExMdUVDODhrOG84QkVR?=
 =?utf-8?B?dDA0V3dEL0dmTTc5dXljNXlkMld6MmhSa0I5dEhDT1NmOG53VVV1K2pDbG5i?=
 =?utf-8?B?bFlxSWJZakRlQXRMOEZ0RnlCbGhnUjVieStFYUhJSzlzV25iSU9tK2FTNVpD?=
 =?utf-8?B?bG56U3lYeTVmU3NYSVk1RFd1ZDlIQmNOc0NTMlFHZ3JGOVpEclliUndZeUZQ?=
 =?utf-8?B?VitNMFloaGR6WUNVMVUxbU84a3RtbjgybkVBeTNRMm1YN1JtYi91VVkvUzZr?=
 =?utf-8?B?dkhPQmFVRWJNeXJWMTIyZEc3QlFiY3pCVlRBakZ1R2ovVTREcjFnWG1FWnhW?=
 =?utf-8?B?OTQyeFNOUjJlcDJ5Z3VnK01KSVFTeVE4NUtCY0JZOGM0QnpjUUVJVDdqNUJz?=
 =?utf-8?B?NC9GQlZrNzFVZUh5NndLWmhsSkpsMm5paEhmN3E2UG8zQkphbm1mSEZuOFYw?=
 =?utf-8?B?ZFRZdEFTYXNEUWduWXdBcTlqc2lBdmtmWmI4bmJUa3pJTEZhaml2c1JvWnox?=
 =?utf-8?B?SGN2SElzeW1lM3R5Q1RRVk8xQTQ1Yk83OCtiMFdxOXJHNURJWlNYR1V5ODUv?=
 =?utf-8?B?bzQrSU1GbDh5OWM4YWpER2l5cHhIdGx5c0NpbndheEo3alp6YytXMk1zUDZS?=
 =?utf-8?B?S1pjZDhSNXFFT0oyanBLYnZEazFyMzRpNENaQmNmS1Y2TlNEME1paUFvdUd3?=
 =?utf-8?B?R2g3Rmp2Q3BpUjBJS1RNSGFacnpDRlhhREhSdytxL0tFWnJYb3lCVjJPcVBQ?=
 =?utf-8?Q?tIwMsBRdTbCW3SANhp0MYK4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CrvcC2djvuQckQSwZiBhUIh/+0EbxXBh1pj3WFKVy61btkUI0c/5HL/v81QlxW3y6Wzf60MSW7Tdyweb/Tb1Z5kBiJZa3vxBezmwYF1XzilAi+vr3nCq1/hBy0lgISam0Ir7Q1ZLAQu4yY5l0l/u5CyBfoLj9h0ijWuEK7YxaH7DGk3DqHb5B0cnT9lDTTfsmHgggQEirisPUiVAHSHqOMUBkUTrpd2/tKqXaP1KLGcZdEB4hl6Om3yqlxs7reP+5DwbpIZpmTJ5SCPXxWWXLt1QDrTmTxe5E+UK9sfHRlK4RxLRe7UiUFJvUvs+sluShv8ZqEfBnrYjuYsnZXUhNMYVxtrMKWUY8522Td5ALIO9L6dHYFXnUwdyFvC2R9ErYCLbQYYJGZRa/VC7DeSKpr1/wpfZQ31rZ85rvCpBNejOitofqKfx0Th9qaoGufQrswHBhua3g4vLeS2t9QjtCM87K3QB9gS+9RF6L6+pYyjC7jph8dBpdI5J91wzfiyXJA0Ki8A/KKmUi0XGo7i4nAAnqBRgFe1Q912Ax+2cBdmI8+lKqYxAk8JAuNrAFPvydWZhOBNSiv0WugKzUxyaETsdRECwGlhLNO+TTZvXoXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe65831-09ef-42b2-41d9-08dcd57c7cb8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 11:49:42.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjOBQ9E9Hrmg+yO75YTaDi6XRKyxTVFp2okXJCde5xYbBflG9qEqWNRDnHsj54eVgbzCqmpvHRn26dZubCyyWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_03,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409150089
X-Proofpoint-GUID: -S_DrKsfnNJx-PHL-TE1gt_-STcnWkNy
X-Proofpoint-ORIG-GUID: -S_DrKsfnNJx-PHL-TE1gt_-STcnWkNy

On 12/09/2024 20:08, Stephen Brennan wrote:
> Currently the "var" feature only encodes percpu variables. Add the
> ability to encode all global variables.
> 
> This also drops the use of the symbol table to find variable names and
> compare them against DWARF names. We simply rely on the DWARF
> information to give us all the variables.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Tried this out on x86_64/aarch64, got multiple DATASECs and ~28000
variables. All worked nicely!

Tested-by: Alan Maguire <alan.maguire@oracle.com>

more below, mostly small things though.

> ---
>  btf_encoder.c      | 345 ++++++++++++++++++++-------------------------
>  btf_encoder.h      |   8 ++
>  dwarves.h          |   1 +
>  man-pages/pahole.1 |   8 +-
>  pahole.c           |  11 +-
>  5 files changed, 181 insertions(+), 192 deletions(-)
>

What's really impressive here is that you've deleted more code than
you've added while also adding valuable functionality; that's a rare
thing so didn't want to leave it unremarked!

> diff --git a/btf_encoder.c b/btf_encoder.c
> index e3384e5..1872a35 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -67,16 +67,13 @@ struct elf_function {
>  
>  #define MAX_ELF_SEC_CNT    128
>  
> -struct var_info {
> -	uint64_t    addr;
> -	const char *name;
> -	uint32_t    sz;
> -};
> -
>  struct elf_secinfo {
>  	uint64_t    addr;
>  	const char *name;
>  	uint64_t    sz;
> +	bool        include;
> +	uint32_t    type;
> +	struct gobuffer secinfo;
>  };
>  
>  /*
> @@ -86,31 +83,24 @@ struct btf_encoder {
>  	struct list_head  node;
>  	struct btf        *btf;
>  	struct cu         *cu;
> -	struct gobuffer   percpu_secinfo;
>  	const char	  *source_filename;
>  	const char	  *filename;
>  	struct elf_symtab *symtab;
>  	uint32_t	  type_id_off;
>  	bool		  has_index_type,
>  			  need_index_type,
> -			  skip_encoding_vars,
>  			  raw_output,
>  			  verbose,
>  			  force,
>  			  gen_floats,
>  			  skip_encoding_decl_tag,
>  			  tag_kfuncs,
> -			  is_rel,
>  			  gen_distilled_base;
>  	uint32_t	  array_index_id;
>  	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
>  	size_t             seccnt;
> -	struct {
> -		struct var_info *vars;
> -		int		var_cnt;
> -		int		allocated;
> -		uint32_t	shndx;
> -	} percpu;
> +	int                encode_vars;
> +	uint32_t           percpu_shndx;
>  	struct {
>  		struct elf_function *entries;
>  		int		    allocated;
> @@ -737,46 +727,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
>  	return id;
>  }
>  
> -static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
> -				     uint32_t offset, uint32_t size)
> +static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, int shndx,
> +					    uint32_t type, unsigned long addr, uint32_t size)
>  {
>  	struct btf_var_secinfo si = {
>  		.type = type,
> -		.offset = offset,
> +		.offset = addr,
>  		.size = size,
>  	};
> -	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
> +	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
>  }
>  
>  int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
>  {
> -	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
> -	size_t sz = gobuffer__size(var_secinfo_buf);
> -	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> -	uint32_t type_id;
> -	uint32_t next_type_id = btf__type_cnt(encoder->btf);
> -	int32_t i, id;
> -	struct btf_var_secinfo *vsi;
> -
> +	int shndx;
>  	if (encoder == other)
>  		return 0;
>  
>  	btf_encoder__add_saved_funcs(other);
>  
> -	for (i = 0; i < nr_var_secinfo; i++) {
> -		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
> -		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
> -		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
> -		if (id < 0)
> -			return id;
> +	for (shndx = 0; shndx < other->seccnt; shndx++) {
> +		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
> +		size_t sz = gobuffer__size(var_secinfo_buf);
> +		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> +		uint32_t type_id;
> +		uint32_t next_type_id = btf__type_cnt(encoder->btf);
> +		int32_t i, id;
> +		struct btf_var_secinfo *vsi;
> +
> +		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
> +			fprintf(stderr, "mismatched ELF sections at index %d: \"%s\", \"%s\"\n",
> +				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
> +			return -1;
> +		}
> +
> +		for (i = 0; i < nr_var_secinfo; i++) {
> +			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
> +			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
> +			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
> +			if (id < 0)
> +				return id;
> +		}
>  	}
>  
>  	return btf__add_btf(encoder->btf, other->btf);
>  }
>  
> -static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
> +static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, int shndx)
>  {
> -	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
> +	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
> +	const char *section_name = encoder->secinfo[shndx].name;
>  	struct btf *btf = encoder->btf;
>  	size_t sz = gobuffer__size(var_secinfo_buf);
>  	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> @@ -1743,13 +1743,14 @@ out:
>  int btf_encoder__encode(struct btf_encoder *encoder)
>  {
>  	bool should_tag_kfuncs;
> -	int err;
> +	int err, shndx;
>  
>  	/* for single-threaded case, saved funcs are added here */
>  	btf_encoder__add_saved_funcs(encoder);
>  
> -	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
> -		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
> +	for (shndx = 0; shndx < encoder->seccnt; shndx++)
> +		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
> +			btf_encoder__add_datasec(encoder, shndx);
>  
>  	/* Empty file, nothing to do, so... done! */
>  	if (btf__type_cnt(encoder->btf) == 1)
> @@ -1799,111 +1800,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	return err;
>  }
>  
> -static int percpu_var_cmp(const void *_a, const void *_b)
> -{
> -	const struct var_info *a = _a;
> -	const struct var_info *b = _b;
> -
> -	if (a->addr == b->addr)
> -		return 0;
> -	return a->addr < b->addr ? -1 : 1;
> -}
> -
> -static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
> -{
> -	struct var_info key = { .addr = addr };
> -	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
> -					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
> -	if (!p)
> -		return false;
> -
> -	*sz = p->sz;
> -	*name = p->name;
> -	return true;
> -}
> -
> -static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
> -{
> -	const char *sym_name;
> -	uint64_t addr;
> -	uint32_t size;
> -
> -	/* compare a symbol's shndx to determine if it's a percpu variable */
> -	if (sym_sec_idx != encoder->percpu.shndx)
> -		return 0;
> -	if (elf_sym__type(sym) != STT_OBJECT)
> -		return 0;
> -
> -	addr = elf_sym__value(sym);
> -
> -	size = elf_sym__size(sym);
> -	if (!size)
> -		return 0; /* ignore zero-sized symbols */
> -
> -	sym_name = elf_sym__name(sym, encoder->symtab);
> -	if (!btf_name_valid(sym_name)) {
> -		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> -				    sym_name, encoder->verbose, encoder->force);
> -		if (encoder->force)
> -			return 0;
> -		return -1;
> -	}
> -
> -	if (encoder->verbose)
> -		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
> -
> -	/* Make sure addr is section-relative. For kernel modules (which are
> -	 * ET_REL files) this is already the case. For vmlinux (which is an
> -	 * ET_EXEC file) we need to subtract the section address.
> -	 */
> -	if (!encoder->is_rel)
> -		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
> -
> -	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
> -		struct var_info *new;
> -
> -		new = reallocarray_grow(encoder->percpu.vars,
> -					&encoder->percpu.allocated,
> -					sizeof(*encoder->percpu.vars));
> -		if (!new) {
> -			fprintf(stderr, "Failed to allocate memory for variables\n");
> -			return -1;
> -		}
> -		encoder->percpu.vars = new;
> -	}
> -	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
> -	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
> -	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
> -	encoder->percpu.var_cnt++;
> -
> -	return 0;
> -}
>  
> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
> +static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
>  {
> -	Elf32_Word sym_sec_idx;
> +	uint32_t sym_sec_idx;
>  	uint32_t core_id;
>  	GElf_Sym sym;
>  
> -	/* cache variables' addresses, preparing for searching in symtab. */
> -	encoder->percpu.var_cnt = 0;
> -
> -	/* search within symtab for percpu variables */
>  	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
> -		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
> -			return -1;
>  		if (btf_encoder__collect_function(encoder, &sym))
>  			return -1;
>  	}
>  
> -	if (collect_percpu_vars) {
> -		if (encoder->percpu.var_cnt)
> -			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
> -
> -		if (encoder->verbose)
> -			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
> -	}
> -
>  	if (encoder->functions.cnt) {
>  		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
>  		      functions_cmp);
> @@ -1925,75 +1833,126 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
>  	return true;
>  }
>  
> +static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
> +{
> +	for (int i = 1; i < encoder->seccnt; i++)
> +		/* Variables are only present in PROGBITS or NOBITS (.bss) */
> +		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
> +		     encoder->secinfo[i].type == SHT_NOBITS) &&
> +		    encoder->secinfo[i].addr <= addr &&
> +		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
> +			return i;
> +	return 0;
> +}

what if our variables were in shndx 0, probably unlikely but not sure if
it's possible? What about making it return -ENOENT here if no section
matches?

> +
> +/*
> + * Filter out variables / symbol names with common prefixes and no useful
> + * values. Prefixes should be added sparingly, and it should be objectively
> + * obvious that they are not useful.
> + */
> +static bool filter_variable_name(const char *name)
> +{
> +	static const struct { char *s; size_t len; } skip[] = {
> +		#define X(str) {str, sizeof(str) - 1}
> +		X("__UNIQUE_ID"),
> +		X("__tpstrtab_"),
> +		X("__exitcall_"),
> +		X("__func_stack_frame_non_standard_")
> +		#undef X
> +	};
> +	int i;
> +
> +	if (*name != '_')
> +		return false;
> +
> +	for (i = 0; i < sizeof(skip) / sizeof(skip[0]); i++)

nit we have ARRAY_SIZE() in dwarves.h, ARRAY_SIZE(skip) could be used
here; i'd also add brackets for the for() loop body even tho not
strictly required.

> +		if (strncmp(name, skip[i].s, skip[i].len) == 0)
> +			return true;
> +	return false;
> +}
> +
>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  {
>  	struct cu *cu = encoder->cu;
>  	uint32_t core_id;
>  	struct tag *pos;
>  	int err = -1;
> -	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>  
> -	if (encoder->percpu.shndx == 0 || !encoder->symtab)
> +	if (!encoder->symtab)
>  		return 0;
>  
>  	if (encoder->verbose)
> -		printf("search cu '%s' for percpu global variables.\n", cu->name);
> +		printf("search cu '%s' for global variables.\n", cu->name);
>  
>  	cu__for_each_variable(cu, core_id, pos) {
>  		struct variable *var = tag__variable(pos);
> -		uint32_t size, type, linkage;
> -		const char *name, *dwarf_name;
> +		uint32_t type, linkage;
> +		const char *name;
>  		struct llvm_annotation *annot;
>  		const struct tag *tag;
> +		int shndx;
> +		struct elf_secinfo *sec = NULL;
>  		uint64_t addr;
>  		int id;
> +		unsigned long size;
>  
> +		/* Skip incomplete (non-defining) declarations */
>  		if (var->declaration && !var->spec)
>  			continue;
>  
> -		/* percpu variables are allocated in global space */
> -		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
> +		/*
> +		 * top_level: indicates that the variable is declared at the top
> +		 *   level of the CU, and thus it is globally scoped.
> +		 * artificial: indicates that the variable is a compiler-generated
> +		 *   "fake" variable that doesn't appear in the source.
> +		 * scope: set by pahole to indicate the type of storage the
> +		 *   variable has. GLOBAL indicates it is stored in static
> +		 *   memory (as opposed to a stack variable or register)
> +		 *
> +		 * Some variables are "top_level" but not GLOBAL:
> +		 *   e.g. current_stack_pointer, which is a register variable,
> +		 *   despite having global CU-declarations. We don't want that,
> +		 *   since no code could actually find this variable.
> +		 * Some variables are GLOBAL but not top_level:
> +		 *   e.g. function static variables
> +		 */
> +		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
>  			continue;
>  
>  		/* addr has to be recorded before we follow spec */
>  		addr = var->ip.addr;
> -		dwarf_name = variable__name(var);
>  
> -		/* Make sure addr is section-relative. DWARF, unlike ELF,
> -		 * always contains virtual symbol addresses, so subtract
> -		 * the section address unconditionally.
> -		 */
> -		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
> +		/* Get the ELF section info for the variable */
> +		shndx = get_elf_section(encoder, addr);
> +		if (shndx && shndx < encoder->seccnt)
> +			sec = &encoder->secinfo[shndx];
> +		if (!sec || !sec->include)
>  			continue;
> -		addr -= pcpu_scn->addr;
>  
> -		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
> -			continue; /* not a per-CPU variable */
> +		/* Convert addr to section relative */
> +		addr -= sec->addr;
>  
> -		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
> -		 * have addr == 0, which is the same as, say, valid
> -		 * fixed_percpu_data per-CPU variable. To distinguish between
> -		 * them, additionally compare DWARF and ELF symbol names. If
> -		 * DWARF doesn't provide proper name, pessimistically assume
> -		 * bad variable.
> -		 *
> -		 * Examples of such special variables are:
> -		 *
> -		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> -		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> -		 *  3. __exitcall(fn), functions which are labeled as exit calls.
> -		 *
> -		 *  This is relevant only for vmlinux image, as for kernel
> -		 *  modules per-CPU data section has non-zero offset so all
> -		 *  per-CPU symbols have non-zero values.
> -		 */
> -		if (var->ip.addr == 0) {
> -			if (!dwarf_name || strcmp(dwarf_name, name))
> +		/* DWARF specification reference should be followed, because
> +		 * information like the name & type may not be present on var */
> +		if (var->spec)
> +			var = var->spec;
> +
> +		name = variable__name(var);
> +		if (!name)
> +			continue;
> +
> +		/* Check for invalid BTF names */
> +		if (!btf_name_valid(name)) {
> +			dump_invalid_symbol("Found invalid variable name when encoding btf",
> +					    name, encoder->verbose, encoder->force);
> +			if (encoder->force)
>  				continue;
> +			else
> +				return -1;
>  		}
>  
> -		if (var->spec)
> -			var = var->spec;
> +		if (filter_variable_name(name))
> +			continue;
>  
>  		if (var->ip.tag.type == 0) {
>  			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
> @@ -2005,9 +1964,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		}
>  
>  		tag = cu__type(cu, var->ip.tag.type);
> -		if (tag__size(tag, cu) == 0) {
> +		size = tag__size(tag, cu);
> +		if (size == 0) {
>  			if (encoder->verbose)
> -				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
> +				fprintf(stderr, "Ignoring zero-sized variable '%s'...\n", name ?: "<missing name>");
>  			continue;
>  		}
>  
> @@ -2037,13 +1997,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		}
>  
>  		/*
> -		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
> -		 * encoder->types later when we add BTF_VAR_DATASEC.
> +		 * Add the variable to the secinfo for the section it appears in.
> +		 * Later we will generate a BTF_VAR_DATASEC for all any section with
> +		 * an encoded variable.
>  		 */
> -		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
> +		id = btf_encoder__add_var_secinfo(encoder, shndx, id, addr, size);
>  		if (id < 0) {
>  			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
> -			        name, addr);
> +				name, addr);
>  			goto out;
>  		}
>  	}
> @@ -2070,7 +2031,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  
>  		encoder->force		 = conf_load->btf_encode_force;
>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
> -		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
>  		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
> @@ -2078,6 +2038,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
>  		encoder->array_index_id  = 0;
> +		encoder->encode_vars = 0;
> +		if (!conf_load->skip_encoding_btf_vars)
> +			encoder->encode_vars |= BTF_VAR_PERCPU;
> +		if (conf_load->encode_btf_global_vars)
> +			encoder->encode_vars |= BTF_VAR_GLOBAL;
>  
>  		GElf_Ehdr ehdr;
>  
> @@ -2087,8 +2052,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			goto out_delete;
>  		}
>  
> -		encoder->is_rel = ehdr.e_type == ET_REL;
> -
>  		switch (ehdr.e_ident[EI_DATA]) {
>  		case ELFDATA2LSB:
>  			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
> @@ -2127,15 +2090,21 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			encoder->secinfo[shndx].addr = shdr.sh_addr;
>  			encoder->secinfo[shndx].sz = shdr.sh_size;
>  			encoder->secinfo[shndx].name = secname;
> -
> -			if (strcmp(secname, PERCPU_SECTION) == 0)
> -				encoder->percpu.shndx = shndx;
> +			encoder->secinfo[shndx].type = shdr.sh_type;
> +			if (encoder->encode_vars & BTF_VAR_GLOBAL)
> +				encoder->secinfo[shndx].include = true;
> +
> +			if (strcmp(secname, PERCPU_SECTION) == 0) {
> +				encoder->percpu_shndx = shndx;
> +				if (encoder->encode_vars & BTF_VAR_PERCPU)
> +					encoder->secinfo[shndx].include = true;
> +			}
>  		}
>  
> -		if (!encoder->percpu.shndx && encoder->verbose)
> +		if (!encoder->percpu_shndx && encoder->verbose)
>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>  
> -		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
> +		if (btf_encoder__collect_symbols(encoder))
>  			goto out_delete;
>  
>  		if (encoder->verbose)
> @@ -2156,7 +2125,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  		return;
>  
>  	btf_encoders__delete(encoder);
> -	__gobuffer__delete(&encoder->percpu_secinfo);
> +	for (int i = 0; i < encoder->seccnt; i++)
> +		__gobuffer__delete(&encoder->secinfo[i].secinfo);
>  	zfree(&encoder->filename);
>  	zfree(&encoder->source_filename);
>  	btf__free(encoder->btf);
> @@ -2166,9 +2136,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>  	free(encoder->functions.entries);
>  	encoder->functions.entries = NULL;
> -	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
> -	free(encoder->percpu.vars);
> -	encoder->percpu.vars = NULL;
>  
>  	free(encoder);
>  }
> @@ -2321,7 +2288,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  			goto out;
>  	}
>  
> -	if (!encoder->skip_encoding_vars)
> +	if (encoder->encode_vars)
>  		err = btf_encoder__encode_cu_variables(encoder);
>  
>  	/* It is only safe to delete this CU if we have not stashed any static
> diff --git a/btf_encoder.h b/btf_encoder.h
> index f54c95a..c5424db 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -16,7 +16,15 @@ struct btf;
>  struct cu;
>  struct list_head;
>  
> +enum btf_var_option {
> +	BTF_VAR_NONE = 0,
> +	BTF_VAR_PERCPU = 1,
> +	BTF_VAR_GLOBAL = 2,
> +};
> +#define BTF_VAR_ALL (BTF_VAR_PERCPU | BTF_VAR_GLOBAL)
> +

Could also just do

enum btf_var_option {
	BTF_VAR_NONE = 0,
	BTF_VAR_PERCPU = 1,
	BTF_VAR_GLOBAL = 2,
	BTF_VAR_ALL = BTF_VAR_PERCPU | BTF_VAR_GLOBAL,
};

Either way, BTF_VAR_ALL doesn't seem to be used.

>  struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
> +
>  void btf_encoder__delete(struct btf_encoder *encoder);
>  
>  int btf_encoder__encode(struct btf_encoder *encoder);
> diff --git a/dwarves.h b/dwarves.h
> index 0fede91..fef881f 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -92,6 +92,7 @@ struct conf_load {
>  	bool			btf_gen_optimized;
>  	bool			skip_encoding_btf_inconsistent_proto;
>  	bool			skip_encoding_btf_vars;
> +	bool			encode_btf_global_vars;
>  	bool			btf_gen_floats;
>  	bool			btf_encode_force;
>  	bool			reproducible_build;
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 0a9d8ac..4bc2d03 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -230,7 +230,10 @@ the debugging information.
>  
>  .TP
>  .B \-\-skip_encoding_btf_vars
> -Do not encode VARs in BTF.
> +.TQ
> +.B \-\-encode_btf_global_vars
> +By default, VARs are encoded only for percpu variables. These options allow
> +to skip encoding them, or alternatively to encode all global variables too.
>  
>  .TP
>  .B \-\-skip_encoding_btf_decl_tag
> @@ -296,7 +299,8 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
>  	encode_force       Ignore invalid symbols when encoding BTF; for example
>  	                   if a symbol has an invalid name, it will be ignored
>  	                   and BTF encoding will continue.
> -	var                Encode variables using BTF_KIND_VAR in BTF.
> +	var                Encode percpu variables using BTF_KIND_VAR in BTF.
> +	global_var         Encode all global variables in the same way.
>  	float              Encode floating-point types in BTF.
>  	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
>  	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
> diff --git a/pahole.c b/pahole.c
> index a33490d..27b7a7e 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1239,6 +1239,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARGP_contains_enumerator 344
>  #define ARGP_reproducible_build 345
>  #define ARGP_running_kernel_vmlinux 346
> +#define ARGP_encode_btf_global_vars 347
>  
>  /* --btf_features=feature1[,feature2,..] allows us to specify
>   * a list of requested BTF features or "default" to enable all default
> @@ -1285,6 +1286,7 @@ struct btf_feature {
>  } btf_features[] = {
>  	BTF_DEFAULT_FEATURE(encode_force, btf_encode_force, false),
>  	BTF_DEFAULT_FEATURE(var, skip_encoding_btf_vars, true),
> +	BTF_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>  	BTF_DEFAULT_FEATURE(float, btf_gen_floats, false),
>  	BTF_DEFAULT_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
>  	BTF_DEFAULT_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
> @@ -1720,7 +1722,12 @@ static const struct argp_option pahole__options[] = {
>  	{
>  		.name = "skip_encoding_btf_vars",
>  		.key  = ARGP_skip_encoding_btf_vars,
> -		.doc  = "Do not encode VARs in BTF."
> +		.doc  = "Do not encode VARs in BTF (default: percpu only)."
> +	},

you've inherited this, but the double negatives here are really
confusing; in brackets would it be clearer to say "If this option is not
specified, per-cpu variables are encoded only.  To encode all global
variables, --encode_btf_global_vars must be specified too". Or something
similar.

> +	{
> +		.name = "encode_btf_global_vars",
> +		.key  = ARGP_skip_encoding_btf_vars,
> +		.doc  = "Encode all global VARs in BTF (default: percpu only)."
>  	},
>  	{
>  		.name = "btf_encode_force",
> @@ -2047,6 +2054,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		show_supported_btf_features(stdout);	exit(0);
>  	case ARGP_btf_features_strict:
>  		parse_btf_features(arg, true);		break;
> +	case ARGP_encode_btf_global_vars:
> +		conf_load.encode_btf_global_vars = true;	break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
