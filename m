Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDA29D28A
	for <dwarves@vger.kernel.org>; Mon, 12 Jan 2026 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216044; cv=fail; b=mzhDabKEZUnkwE6Oxt+O+zrsEDAB0nJyp/c//DbpGLAVg0mhbUItXwdU5FGgH6pKvMrnIDteOOgshq4D+wfM98PWv1+y111LCXWqu8jxzhr0OA2aj3PsRc6LWzo6KdTLuE4ouOw6BzK4oAmpIi49knXul2Hbdf+vRJJQMSTnXl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216044; c=relaxed/simple;
	bh=WFLb7ZoYZayYWFeT1JUL9MObUq5T5IH2VTd8WzcEG0U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dZEqamBQgRWo4CqVWD6BJ2haLcSNg+MgvEi7O74tn7ThzmImFanGMRpvTFfTzu48D6J1Mx0mKAhKrHD6/xGkA4KJq21sKC0RZZbSjy+37g3KZGP2qZ+qp7LB6BG/DHQ+V3jznrnMibSbG2Sj9ceOlie8ecn2/HNOPXwLCGdYAxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Enl3qlYR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tHxBl0Ku; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Enl3qlYR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tHxBl0Ku"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C2rlEG486939;
	Mon, 12 Jan 2026 11:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HHD6kZ7Y4BOgllfWTV9OVdh67eghio6r9JtbIqpeFFY=; b=
	Enl3qlYRZZwAs8cQP4V64YADuVldGPG0fHp1MHx5LWoHBV8OrBNduEwRCk9dcdCx
	K6qEyhq+p0KMB1NL6zy6i0xR6mHMChDdsIfzBERtB7RXsVmhJkDukBG5pMr06M51
	zFbceot1DXKco8lOmTNZYsnrQH6PSfAP8E+SQw4QqbZclUq8mPLXyDUgzC65ftL5
	kAtVype32/T5Z6EwZb5sN8lZHv0mSdgnZR06rh9IN6n49vTGNThtPn6Mg/Ivf9Ei
	AjUsL99xG2YgrguBYd1/NIkA/eaUxV3lhWp/vDPrp5KCaRt3XnC76kPHk8P4Naet
	nOuVBAFiYz+XI35KMBISVg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwghdhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 11:07:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60CA05oG029335;
	Mon, 12 Jan 2026 11:07:12 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7h1yqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 11:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is0F+FvTIt+AwZzKlVsvKUQ1wGh5llrdWTFrs4puM8mCif+yN+tqrZL+iv83KZuOUmV8Y6YHpKCsapAmC/2XQfJ6v2as2Q2pcobzb6TC0Ds2qFkwmmg2oLzfiEik+4xnwV6LrcaPn/ikucFK4xA8WPjgJD6OB0sZMFGCBYhR14Lqd1ZrMiylahYXj5cG14QisjLWKU9cRsrGKBXB/KqmKRWsZ1pQgqegB02CuCc85DpnOX7JokOL7F+mbQmftkOPZFkQT52wJ0ajsXliT4H1hBPHbFsrSeaG9Km13uoSTxf/kt90+jPG8tc0n3pVVw6TR1vjkZROPvL+XkAKwGlIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHD6kZ7Y4BOgllfWTV9OVdh67eghio6r9JtbIqpeFFY=;
 b=Su+S1zG1mlFz2PAFWSzaLy93js1KeIRzwmzZExmX3d6be3DmPnuqJ8ouLtsFR52p6RtxiboyzhCSlH6ns/1KmFnIfgJuoot7jBZWL1uZwz6GbBbN+Gr0XGgNfFaehlrjtTS3Pn4JO5REViniqTtBJtQ5mOS+vJtXVV2Vz01ppCM1eRiLc8P0W1t5dv5uV/cH3MYjo/XuozD5jw7+YTAcp8Gah0O3M1k54B7om/aaGc6wZMLoQk/XisVjJJok7KJFcCLuWYei7ZnXBVrGIy7gDZaVPmvdNNv17HxDCufyaKezas2DD4IQQrK5jQUElJPhhZjt+yNciIv/aUgo4VAlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHD6kZ7Y4BOgllfWTV9OVdh67eghio6r9JtbIqpeFFY=;
 b=tHxBl0KuTEbJpmGGxgQ/BDzsdJ/0MNF1ARBuU1u8dQgDHFO6xnKbn0/IFtUkzhRgyDFsBNeEqNYvHUMZ9gbyk6y4dEugVpiwShV+Xf4txNvSqsrcRgLutziEdaC8vVuW2agLHiJb+cOmf7t5oLVh0QmB4EihUK+3+3J9G0eF7qM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 11:07:10 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 11:07:10 +0000
Message-ID: <5646ea17-77ec-4d07-862e-45c5fa7effec@oracle.com>
Date: Mon, 12 Jan 2026 11:07:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] elfcreator: Fix NULL dereference in remove_dyn()
To: =?UTF-8?Q?H=C3=A5vard_F=2E_Aasen?= <havard.f.aasen@pfft.no>,
        dwarves@vger.kernel.org, acme@kernel.org
References: <20260107212912.1619603-1-havard.f.aasen@pfft.no>
 <20260107212912.1619603-2-havard.f.aasen@pfft.no>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260107212912.1619603-2-havard.f.aasen@pfft.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: c3dbda80-7d4b-4069-6e6b-08de51cabb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzYyMS9kL25tMzE0alZOZGZLZDUyTFVNYkRRd05GM2xiaUVRNHVsUy9nR3By?=
 =?utf-8?B?WUNEYnl2WHJlTGhzeTZDbkgvWmpKQjVESHVDMFNrQmw2Q2JldE9BRm9YWkt0?=
 =?utf-8?B?RWUxVUcva1FkcDlNTmQ1OHc3MVVZUGpDa3o0dFh1eGs2MVlCQ0VBTFd1UGo0?=
 =?utf-8?B?NXczNWlOS2VmblBwWDNVQkh4TU5aU2lrbXNyRE9tLzdrOWpwZkQyOXcvVitB?=
 =?utf-8?B?cWcrVjM2dmp1UE1zbENzOWxvWlhvcDhHR05zMWZ3a1pGUXNLblNIbkJrbkJS?=
 =?utf-8?B?cEFlbjhKeFd0WjdxQlVkNlFEUnNMNXBVYUltQ0VrMCtqQXJnbFdPSk44RDYr?=
 =?utf-8?B?R1RLeExYZTcvYnNRU0djNHd6ajhvTEFqL0QwNVQwUlM0cHJMVVZPaFZjQk12?=
 =?utf-8?B?Sk1lY204SGNsN0gybzhaLy9yaXRybnZPQk1FQkoxTldQTm1FbExkbCsvc0Zy?=
 =?utf-8?B?RzNqczdGYVc1cmpLNi9sV2Exc2o4dVErakxiMTB4RUVoc3pKbDZJbURSd2Nk?=
 =?utf-8?B?K3d3VUt0dDdFZk5kdTVLbzNzSkdnMVR0WEhJV3FLVXlWRGxXV1VqTE0xQTM0?=
 =?utf-8?B?Q25lN2g3R0FHWi9rVW40eUZPSG5ZSUMzbDR4SmFPcnVVNXF4dlBqcTdpb0hF?=
 =?utf-8?B?M1ZqNmtJeDZsSldGWXZQNlFWNmhyby9yM3NGR05tU1hNTWtqQSs5S3BRYzdB?=
 =?utf-8?B?cmxiUTRHbUo3ZjNDMER5Q3NwTWRQWGdzekxWUXNmajJwVlNMa1F4cUNXdFlN?=
 =?utf-8?B?aXFYNDBWMDQyZG9VM3FzdjhJQVZnZlQ5cGdrcHRIcXlqaVgyTVNHL1Vtd2RW?=
 =?utf-8?B?eUQ0VVBEN2llL0IrL0c0akV1N0pEcE8wdmtCN01IOURKdUM1dEhaOFZ4K0Iv?=
 =?utf-8?B?MHI1dEU4eGtFQ3hOQk02b1Y5L1BEQkMrN0JpQVZsUUpyMFBHOXRpN2I4MTFs?=
 =?utf-8?B?cWMyT3pDUlJHM2hWNFpuai9ieHZpbEJ0aVJzWWp4V2ZKVU5Md0E2MFRBN09S?=
 =?utf-8?B?bFpyd1FIYWFwUW9yenduZEU5MHZKcGNNVVhLLzVCZ01iUXg1a0pIQ0Zvc3dZ?=
 =?utf-8?B?S0RReG9VVVJzRldXOGNENjRTZ1V0Nlc2bUJoUlViU3JzUnkxYlk0YVdpUEdG?=
 =?utf-8?B?UW81YVB4QlZJRE1jcis3RER3WEpucU1jWFVyTkFEMTFESlc3QkdMaXExQUZZ?=
 =?utf-8?B?NUtvVUZ0KzhyQUhmeXlScDZxTVRoL1M5c05jUmdISFlaWXp2RFJ1QTREbmEv?=
 =?utf-8?B?OVBIbWlzdThGbCs3Qlh6aFNNMSttb3NGWThWUnNQQXMrS2xOT3NyYllnWHV1?=
 =?utf-8?B?T2hBNFFIMFpvVmJIcllYV1dMYzZyRjVBSDNaMUFsMFRLOTdCTDh3UDQvcTVT?=
 =?utf-8?B?WFZqWVZxenpEb2RLUzFVc1U0aHYyWWZlY0d4T09YakQ2SWVUYlhBaDVzci90?=
 =?utf-8?B?aHJXMWxmODI2YmMybjJaSmNJODN2ZHhESmRpcjR0azEra3pFdU5WV3BWaWJ0?=
 =?utf-8?B?cXRvbFJ4YjhpeUZRVXc2b2RTdFhrZTUreURwYUFYNnRzK2p5dTVPclA4NDNY?=
 =?utf-8?B?ZkM2MEE3SFpTR2hibTlYZWtGWUhicnJDS0N6ZS9MK2M0cHJVQUs3am51cmha?=
 =?utf-8?B?TGxRbVl5L1hpQVI5KzNpcENyS1Nzc20xeHJKZXFvV1VlQjhiVHpDZ0Qyb2tw?=
 =?utf-8?B?QWE0WGVySkVEQlNiV2I0L2M1L2lHQnEzckJZWEU4UG5zUnc3bFhDTEZ0NlA5?=
 =?utf-8?B?eWJNdDNGM085amlyZGxFL3AxZkF1cVBRSHRpVjcxcEg0T3ZHRElHQ2R5eVlU?=
 =?utf-8?B?Y0hGZG1SYU1yYjNZYm5lckcwRXpqaitHZktWekxZQ0NhcXRGbEVEaTMvaTNh?=
 =?utf-8?B?SUoyenk1cFhwRXEzWjEwMzhna3V5MmhINTJKak8yZFZwSFhJSlpQaW1Kc2hK?=
 =?utf-8?Q?bTBD+9Mo+nGKSdd1IxGivB28JlCn3/kU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzZoUDRwQnZZdG5KSXh1WUZHVy9BV0lhTTE2S3gwdTUrWXdTTFo0c1NHMFp0?=
 =?utf-8?B?MnRXWjVYRGxsemlNenlQVXhHMGpxNURsbG81K2VucTVNY3hCL0RYVndiSTFl?=
 =?utf-8?B?SHlFUEV0ZDhqWVI3ZXM1R1hRTG96NWI2T2dXZVZTVWIyU2xJNWx0YnJ5QWI4?=
 =?utf-8?B?NytyL0QzU2RHRFJCSkZieWwzL2RoaVdBTXlyc0NmWGhlUmxETXZPenlSVE4v?=
 =?utf-8?B?WjRjRy9SYlB3YXVNSHhOdEh1TUFzN1lDWVhHQ2pJTDc3Z2VaWHVZTFV1K1Zy?=
 =?utf-8?B?cXNpQ0tHcklPd0libEhITStDRXJEaFNMN3ZOaTNsOGpvV1R0VGhUMFBob01F?=
 =?utf-8?B?VTVjdGdOMUIvdHpJRHo0VFdWRHFyNFV3U3N2UTlkeTIzQXB2WjdlbGM1aU1u?=
 =?utf-8?B?b2VNcWxPZ001S04rK1hFcUFmMzRYSXJpeHppNnRuemZDK2xtZE1vUyt5UitU?=
 =?utf-8?B?UjEwV1JHVitFcEdXUzRNb1V2eDBoMldpbURqUVFxWFhvSUhrYm53TWNsVTly?=
 =?utf-8?B?d2pGMGY1MkJuMzU2OVhlUTBkNG1pbWxndHpxMDRPZFZtRmNSREh6NzdyZExj?=
 =?utf-8?B?ZWNGd0NKR0pVUzRTZktWdU9hRzI5NnB5TS9EYVhGWlE4c1dOQ1I2YXhCUFNE?=
 =?utf-8?B?NTBLY2FMeXJRUWZKcjJUd2dpTmNvR3ZUWmN1WkJEUzlyMUVwc24xbTJWOFNK?=
 =?utf-8?B?N0hhcHVPbEhaaE1jcXFBdDNlemhQU3ZtMWV6WmMwT1dacitqS2RUTEN0alRX?=
 =?utf-8?B?cVNZcUhPNUxHdXEwR0dxcFFUdXc2RFVPZ2NnQVh6Y2NLQnp0WFk2aXVHOUFt?=
 =?utf-8?B?cTFBNkIxNWRRVE5BUjF0aFNHYzRUQ3hrVzVlL3ROSWcxdmJYcG1aaWZ0a0ZM?=
 =?utf-8?B?dUEyTGM3VERKcUxXc29EL2RmdlN6S1NVU1lqQ2dnajR3akJtQ2R2NjVqSlp5?=
 =?utf-8?B?eUc3dW9jWlVpY3BaNWU3aG93SHZLZm1sNlJVYkRocjFsS0JhTEJicU5CQXhT?=
 =?utf-8?B?aU1EVnRQeVpmekNGd1NQbTgxM0hqcDIyaDlKZEpDSDFWUnc5VS9GY0FZSjZr?=
 =?utf-8?B?RXF5SU1XS3FEcHVZY3dPM3l2OFAvNklCNVhRR3hXUXpuUEY2WU9HV2lDWmo4?=
 =?utf-8?B?SkdRdTcxWGtlM0hlci9kdUxSL3plYVBSUTY1RXV4Y0dtVTRQVms0TmxNeDJL?=
 =?utf-8?B?MUxWb0ZkNlEyQld3Zm41V1g4V2R6aHBUUExGZEpJb3pJMjF1SVpvSHJ0L1Z1?=
 =?utf-8?B?WDdIY2h6YTJZSllaSXMrY2NGVVlQVS9KZVJWQWpRZk0rTGJYZE5SMmI2bm8y?=
 =?utf-8?B?NDQ0dy9wNFpzZjYwcTdwMU52MzU3cVhCaWRsQW0rb3JCYTVrcU9OT2YvT1Nj?=
 =?utf-8?B?SjFCR1Vxd3BodDZudU05ZWQrTkU3Mk51dXRFM1lLelc4SjdPSmhIYTFrSi8x?=
 =?utf-8?B?Z1BIK0FRajVFWG9wUU4rYkxwanNoM2dTbUQzUElOTGxLUk9vYzZ2SGgyeFpI?=
 =?utf-8?B?R1FlNWk5RUxYTlRic0tpR2Y1bW4zbVVtUHJVZVpDK24zUmE0NGJNNU5YOVNT?=
 =?utf-8?B?OWxUMHpRWTBSWU10MytkdzV6TnhNT2xBVzJ2RGdYdS9HM2t5ZEt5b2hjMEtn?=
 =?utf-8?B?WW84MDdpOU9XTlU1Rk9MK0s4dGhZb2pTa3ZFOXdMa2NBSFlxTEdYUUNkd2FO?=
 =?utf-8?B?YXBDaGE0bkM1K21DeklaZjJTVkJ3Yk1sWlRVRk1Pald6WU9PRVpWSFFReXE4?=
 =?utf-8?B?Y21zMnlKS0JtaVo3c2JQQW1PaXhZR0hod0JqRFZKR29yV0FKQnJraGxnd1k3?=
 =?utf-8?B?VkJNeTZEQnB0WWEyR0dkR2JaR2VETVJrQ0xYQTI5eERCc3F4bWxDbzVjVG5I?=
 =?utf-8?B?TGduZVVkMEdFbDM3U2x4VnZmbXh4amg2cisyK0NZcTZQRkxRS29pY1Z5aWpt?=
 =?utf-8?B?SXhJbjJ2bjJLQlB2a1kwVkpIb0RXYUFSeTdNbWR4bjRCYmd4UUFDbUlMOGh3?=
 =?utf-8?B?cHA3anZ4Z2F4Mmt4dnJlMnJXZkFjM0FxTjhqMzRNbXJPcGtRVGZJS01Qd2tD?=
 =?utf-8?B?QmdXK2tKWjcrd2xOSEVSc1JwV3RGMys2ZTU4dDFTeElKdjcrZVlPbW1iOXdQ?=
 =?utf-8?B?RkRSOTB3NnpyMWJsSis1VDdjcSt2Tnl5M3RzTUZ4cEowZ3p6ejRDdXo4aldO?=
 =?utf-8?B?aTlDVVBoUEU4bURpM25DdjU2U1RYTkRURmZiU28wa0crdEJMY0lSTUVHbWZo?=
 =?utf-8?B?U1ozM25NUUJIa0VyekZ1MlM5WkM4a0hIdXZCdG9DcktKTUpSWkZLYndXNDN2?=
 =?utf-8?B?Kzh4TTFra1pIY0IrUlN5dG43Q1N3WFVwWWV1aXhqVGRMa201Zm16dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p6qwrzpa88gIWtmiSOGV2QvGIrthN5ZAqLD6nzp0JT0F3+X9Wxc46zAtbvrbZFThRYv0lXW5QcE99/eyvKJ6guqCE11zRFodK3MIdEYXKyrkgScWFlXJmYp/jRF4+SNQ3FJY2+Fbo7OKPSvnTXDhcD5HqAYcmnmXNNiFn3rjrlejhxYqj/5+NAzkKFzP9d290ERdeGOcr+ZxgU8PbtLXxYCZ9HP7p4/GV4kFa0pZFCJRhWIIilbLLaQL0mb+ZQrSMZ0HXCxz9MLoGjutpw0Qlm6lD6NBPpzhDqYaAsoDvv0dg9yygNQ0RB4easAZYOwP9S8zVtWZg30GQy024nxp08P88MneQGTkbXlzO4Xbgq6FVfCjdi4XRi+0jtqVgBKERlJ6UUbGbOjVkq6GIYpYCe9SAAPwSuv8hcWp7SMQpiElOk610a473e9dZ4q15tpUEkOrxWv9ts2Z15rWolf28maTUgkEb+C2tv3yBOJ+U6eJBTb4Xe/VU66j5EQaTKFsLa06pU04jxGC6Jwq1YWc9fBofv6wCWefcKTyRFRnBGrNHzcmNX4ZAURf8ChtXyYkvTSN0uc/RKLQn1Osottb9towyUToZU8ijPPQXTQ1i0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dbda80-7d4b-4069-6e6b-08de51cabb59
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:07:10.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsB4VESPuyhj0SSp1bbbxfd/JMePHnlrIMK3dphHAcrufR3d/fR2Avsi9PCuBHg2JTlHxuwM2rCmD+F7waVZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=555 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601120088
X-Proofpoint-GUID: iiUzJYDKXmYwwZLrgV3VLRGTgxgyTdZz
X-Proofpoint-ORIG-GUID: iiUzJYDKXmYwwZLrgV3VLRGTgxgyTdZz
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=6964d5e2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=z4TIQuJnYuM0ErpMqYQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4OCBTYWx0ZWRfX6wuPgzhZnu5K
 eTmTtM14bNTITzPRWuQT1a4xcCEtDJsfmouUWql+PfYKNZyJTs94wr47D9hhHz/2eRD+XVPn97i
 lasY+lex1EnllcC2Sxw1nhcDfhPZbqKEYEJeJNe1gfRUu7KS3CjjlkR5GW8j5ZjA6ASysdLTIT0
 Bt0vuL8WazNysa50gLG9fgDSna2uvaoJzmUJaGW6wyx1TNE6Q3UGc3Yd5riLc3azMUemfedhbYI
 /CzjpAkP3KuXnkLP2EgccuToJNg09+yyG+mQh6RzyYSpGq1naE73Z3KYvywgb1I3Di6mYXeQIDi
 VJS/8s6c48nzBqHibh6OfOJFJK3YpCIBhyc9pHA6Y1hgk04K/NNdTWKsUv7SItz8iS7GY/0XEg4
 +ocsNrZMipB2kgX2Ge+eRFwWCldCYPBe/neYYv9eY6qVYzSJq5Rxl1Qkn5oxRgoQojai/CNPSD6
 8+IXsuk3PNv/pMhyKcjMw+2SfBS56ZCvwFUDZQWc=

On 07/01/2026 21:29, Håvard F. Aasen wrote:
> scncopy segfaults when the requested section does not exist. In this
> case, generic_dyn_fixup_fn() (and the related rela_dyn_fixup_fn() and
> rel_dyn_fixup_fn()) may receive both a NULL 'dyn' and a NULL 'shdr'.
> The code only checks 'shdr' and implicitly assumes 'dyn' is valid in
> the else branch.
> 
> This leads to a NULL dereference in remove_dyn() when ctor->dynshdr is
> NULL.
> 
> Add a NULL check to prevent the crash.
> 
> Signed-off-by: Håvard F. Aasen <havard.f.aasen@pfft.no>

Looks good, I verified the fix resolves the segmentation fault. Applied.
Thank you!

Alan
