Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F768312834;
	Fri, 27 Feb 2026 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199373; cv=fail; b=tOOCUkGR0SxZqK1y/qFPM1M2G9YMn3WYo2B/hQQMNqE+yyq5vR6MJs7H2QABj3OsQrowowKeH9ZnfaSarlHjKflr/uxeHYC+qxfRwmH2VLkmtXEbQghRS4CE2n3nLyfJIQ2Kd30z3EvBggOsbRV8CcNrGGJgIkOMQCCPX/w7f0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199373; c=relaxed/simple;
	bh=qNmxKu74EcWYAB915skuDfnyVP75qRARwxqiobsgzkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QWmNLWtlEkcSAo/hXMjAOaQF5B19g1NqimUSPMDLCXQYcDwMwcq7mSLbHhVW7V9822dvGgio1W2ZjDzsyCpJxM/sZYHngsEAWFwo57SyKpwFsF6tvrjPciEv3vF0oMScLe8JG6I5k/1YjxXpzJYUWbibUcesj2tB++tx1icKClE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QffHo6S7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b0eRbwcq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QffHo6S7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b0eRbwcq"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RDPMsN2247800;
	Fri, 27 Feb 2026 13:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dOA0aiwDtUS8tsRgs6r6r5Sr9YlKS1Ey+e76rZMZ1NU=; b=
	QffHo6S7qDoO76pI0X6QlN6Wbr+nEaYTta1cxqWafjMmfwXls+rbl0jvQwU1exQu
	4PSP7NsM59Yoa941F5kMGE0A+xjSlb8y3cd9WUWvrcxw2lK2kDooKMF3SrSh25Q+
	UINBOS23bKpuOKAIJSogjLRQD0fzVgcdTD68e3tpxEFOTPjjXarx8FrRrk6h/FaW
	SrFEOylld/B6u1HkTOx8vJSW9Gi+Ov59yUVoP0kYm3iv5PQkEVoNDCjnWn1RG771
	Y96Fnl/tEJObWGEhozjFm0kV22TB79Yx0HeM4T7njHkv5v/LAifRNJXMFSooY5YJ
	6Bv3ne0Mq6A/H+GumqaEdw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgg3u3bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 13:35:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61RBsPHx015761;
	Fri, 27 Feb 2026 13:35:41 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35e362d-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 13:35:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLD1WgpNopmsvoJz+gHXl2UmtEJB3MPfNY/h9uCE411GvbsDostCdGWnA1mISHcVZYAR4nFG5eieHLoTFohw7DOc4G4Nfnfb9s8Kg401XqoxjWKYp5A4uOmadL+PI8PtovJW3QR0LHMW7bnfejX+1d/asr1dctB1YpQ5ojfYYjI6aEZIr6aBrQoC7wg7IKJR4guxMeXFFI+iLk2ev2W0HT+v548+iCnZe/ODKyDJffBhGTIp9h8V/ejSKL6Xe0+eap/gJ/rpBJXfM3VLoFeja1laZbh/y2bKzSZC4zTu/Pd2RzU8fqPOeIPiQCSBC1TwwfxK5Qcj70e/MupZiz6PrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOA0aiwDtUS8tsRgs6r6r5Sr9YlKS1Ey+e76rZMZ1NU=;
 b=HO0u8FxHaTBAphAjnbYZbxEcQn4f0/O3MGHapdeqyenlf1LFsc+vDyFZeJ7P8n18f6/+CLw56vkFC/pRmANmz6y03zN5Cy/NSCAoZqs8sjmWZUNvPiMk0/J9l1O/i8DhT4KcvF8gRirnajTY9BAwl3Nwe5cqgucdRFDAganGhAVbS9fn8tpldP7sU2HXoh1FTsMYs3+v4YGUNfDNA2T3OFOSNXsfh+kf1zxevtETNfb9RWHScjmz0ybzPNUPT4S/8ijLdIOZJ9fB4LG78eYFMaLiXACQwKUHOeDMMfiYtyE8lt5TQtEkWI2DQOw3gxxRdiLIzfbQwLxSegoo5UYd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOA0aiwDtUS8tsRgs6r6r5Sr9YlKS1Ey+e76rZMZ1NU=;
 b=b0eRbwcqCUdS3tRYWs58l56K3JGWaPnKFksDLArzPUuKl/Xy6Brkea2VrJG2BDbrJHHPTyQs9hB70cg1QgBAygg2mmVJcuHMLfq9wwYdDih1rewUdIyzal6AweW0oxNfh/IIC8U+KQ9asNsYOmi8Zo6Ef5ecfHgh6TJF/1Sqz7c=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:35:35 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 13:35:35 +0000
Message-ID: <a83ddc02-d601-4a0f-b5bc-9dd359d7a2b8@oracle.com>
Date: Fri, 27 Feb 2026 13:35:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 bpf-next 01/10] btf: add BTF kind layout encoding to
 UAPI
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260227100426.2585191-2-alan.maguire@oracle.com>
 <df00956ee63256fa4f1cd7d847797e49362aee2963cfc771a05e9c4ef640e781@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <df00956ee63256fa4f1cd7d847797e49362aee2963cfc771a05e9c4ef640e781@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH4PR10MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f84c8d-c5d4-4c89-f7e2-08de76051636
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 YKuRNX8cc+RzfTro5QWvvzKiG34dGJ+r/q4k2L7mq9cC9pBwk1gZlQCC6u4SN/U8dWWfcDU7Ynbi88TcNgwco+gRAZZsf7MwXezAIxMUxPXqE0JiO8pnEJOZ54AInjMiT/H2Z5srnMpZ85Mh/90xCi4kSS5Ps69iGVWGFYc5QjgkGeCfR1IgK4KnLfVIrDZA3GLAPsEqyNiolYiTHJd9UogNH/GGcGFye396J0oDCNAHmvh/Of3OV8vU91kQ9xcMGGezZ4pSkDbIYmqjJ8SGClaFBDWQRz5AFPdLYuKZtsKAkhOKcD3PsWLZvH6/UWHG18nLPmjbd48f2K721lNLKlteybJEDLjINNjDK/VetVJCAcaSseFtAIL3jwvo0zqsxpks4/Z42TPXCXIPmojPZoAlPbL8V3lonLQDHRALgR8gw/ZAv+RHms4LmMIFriw2HVmEvOezMaUzW29I0Whw67NOdADp4aPLiAAIkX4Wmzdc031IdjZhKNHNmdTTN2CX/4woHHYeHd5IDJLcUKh5kZjWZrREjbmmVExqc8SKoHSBu1+jAbiWpGA57OE5LTNzF2Czs/sMAaLU1P7XPFTqVnc+X6bZFOsnwtfoWsv4tXmizJwRWGFzwSM3xiVrV/OrLEl8a2DE0WeTbz3HXs8pukdhZXx9lsSdA9A0KNOSNcUVu4CMpi8jVKaX3OkF7Nse
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z2o2UVhWRDJvSjJkVEdOMHFvZFFpak5kY3dkOG9TdXFqQ1VCUytZRGJzem1t?=
 =?utf-8?B?SmtneSticFBCRzFmMWhQU0QwejJQbFVkbUE4SzF4NGR5eklQSmlnSDZFL1dM?=
 =?utf-8?B?RXE2bm05YUlHODJCSENsNEtEaStFVDNFR2ZTdmo5TlBOd2pQK1YxWTk5R3hs?=
 =?utf-8?B?djRJdnBBU2RtZ2hMNzVXMkdiNWtCek1vNnZXZmJNdXJNY3VBbml3NVkyZmgr?=
 =?utf-8?B?R09wcS9pTzFwaHRHZkJrQzI1UlJjMFFoMGMxN2tPM0h4cU5mQTc5ZDBqNGU4?=
 =?utf-8?B?blUyamcxcHkzaWExNE1ydFJDSVhrYk12enJSWlYwdXhWUG5oSXc0K241Tkli?=
 =?utf-8?B?eFhoZUVPeVZMcnZDenRyY3pucTRpL3hKME5FbC9EZ3g2dURXMFh4SVMzaCtC?=
 =?utf-8?B?WjV1N1JHaWlpQTV5OENCSXB3QmZhNXVOTTJXMWR0aW0vMFpURWM1cElOOTdh?=
 =?utf-8?B?SnQ0RnFLOTlDVk05SWdDZTVQOUxRb29ZTWlnMXFpUUhmZERYYWdFT00yYVBT?=
 =?utf-8?B?V3VYYjE1UnRDQTN2ZXJlc21iVG8yQWRjMjhNTTdUSjJxNGxJUVpCN2tSdXc1?=
 =?utf-8?B?WDBWYWlWUDZxcUFMdisxMUhpKzIvQS9mU3l5dUhzckpHcDRmQzNmeUpPVEJ4?=
 =?utf-8?B?S28xK3NxUEFZYmRxZk1TRDNXbVJPcTFKSzdXR1lCRUQrb2hCdWtJVEVGRFl6?=
 =?utf-8?B?M2o0ZmdWOUo0U256THJpeTJnM3NkMEx2Rkk0WHoxR1JkK0ZGS0RYUnA4OVB6?=
 =?utf-8?B?aktDUjZaNlVQYVZtVEJ1L1NwZnJHakNjVGMxZHREWC84OStteUUrNE1HM09K?=
 =?utf-8?B?VlQxSHlRTEtUWGszMXZYeUhBL3NhYVpCdXcrTjNrMjN1NWlnQnpsYXFrZDRu?=
 =?utf-8?B?NE1nYTJwOXhkaTlsSWt3Y0orQkZjODR2ME4zTFFRVzI3RWdsd1A2NU1yb295?=
 =?utf-8?B?UHRhY1pqU3pRUmZBSVVEQUtyUmVZcmZUL2dMYkNTYWNPVjZMdXZoYnR3Y1Fm?=
 =?utf-8?B?N0pTTGtQOVFWYlBZaktHa2xCQmNEbGNNRytRL1ZDUGtQeG5zVnRXQWwyc0NW?=
 =?utf-8?B?cVdodkVPNmJxUGUxL2w5MTNrWHRYNk5WVVZleDlESTc3L1gwVE52cWdlZ0Vi?=
 =?utf-8?B?SlFWNUtkZmk3T2ZWUk5TNk1KK0pZY0xhQmtqRWpQbDM0WkRjYmY1WEVOa0tj?=
 =?utf-8?B?LzgrTGJMbE5ERHlCVC9LR3dQYWdPQWw4TmdjSHhBMWErZkpMckZPMVpjOG9K?=
 =?utf-8?B?bUNkcjlSalpsRWR6NDN1U1paaURKQzBpZ1Qxc0d3VTFqSnZydUxBeVhvL04r?=
 =?utf-8?B?NGtWUXVHRU1wZUluTWxUbVpBaStlQ3dBN0RmSVNNZzU3TkJOQ0pJWkpWbnNi?=
 =?utf-8?B?eUxYeVNQdWJXWGcxUlZEY3JCRXdZMWVGWjJPd1VSbWNBZHp0ZTBweTJDM0ZV?=
 =?utf-8?B?SEtZMnFtam10RDFKa2VuQTBvcVN4ZTlBVGFlOUdkdG04WlZkalNtemM0NXBL?=
 =?utf-8?B?ZDl3U1d5WTlkdEluZ0JtUnlaYXhXUXVMdW1TZHdSK1NGV0dmZkQ5RnBrRzFI?=
 =?utf-8?B?c3FtRmE3WGtkMHhEN3ZxYU1LWEJYdFdVM29ONzNKRFdJalMxeklWcDBOTkdQ?=
 =?utf-8?B?aHlYdUU4YWYzZW80VklzMzhDSWhuQ1hheU8wMTVJY2lKRVBOeDZXeHIyS2Fn?=
 =?utf-8?B?S05DQ1g4MEtuOE5OZ2tkb3F3WHhoNExhM2t3SkFQNHJGK3RvVFFQNnI2WUJQ?=
 =?utf-8?B?U3ZqMVFhaGczQzBqTUlJTmV4aEg2WFNlVVpuYnc3ZFFtRC9NUWFOZXFkckJD?=
 =?utf-8?B?WnpxZjg2SjNHS0Q1ZkhCUjlzZEd6bndFRm9tdUF3NTJCSkVCYmFSRzZMRFJ0?=
 =?utf-8?B?NU81ZkNQR0wxanQyUExSOUpzSld4b2hmaFNMQVNKUFdDcHBtVVBoOFJZN1Jl?=
 =?utf-8?B?b25uUFI1YzZsVWJxTERuQksvNktxdDJmZktlNW1ET1VkNzloYUM5eUxPOHBH?=
 =?utf-8?B?azAvUWQ4TWtjNWkrRllhakI5VlRpNjM4TG5tOU1pZ0pTSm5TLzFMMUphQjN5?=
 =?utf-8?B?MmVZWFRNL2Q5Y1V5WTA0emM0RUMwYXNnWkFRbTJ4VWJUbUt5T3FKZlJ0bVBZ?=
 =?utf-8?B?QzV4V2tJVnFXcHY1ZUNRdGJlbzdsUHJYeEVTcWNzU0RVeFlyUXMzeXRSdzha?=
 =?utf-8?B?MkRIL3N5Tm9PRUs5eUtvc3lzMFRlakRIY0hOMUtnb20vdXJBTndaODJ3WVp3?=
 =?utf-8?B?dHp2cGNsMG14R2tpTVdWRkdTenFuMEIyYzRDMzVKekxuNDNKWTEvVitDVWpw?=
 =?utf-8?B?Mm1ORWpNTThWcmQ3cEdmZlQ0RmhiazZvN3NlQXl1ZnV3MysrT3JFeGNYMHBl?=
 =?utf-8?Q?jOCnJjDpJMnrklaQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCpPY9kavq7ac9XwJor9uElgjsS0vhoXtk9lJjtQVJxRHI5zbzjkiCbkewkR9M6LcPMn6HhKEH1rJ1cz56a8ddVH5Gwh19LbwiRs0EFkIUdY5xfw8af04jvRuWawrrwf1iEaynBbqiUgac9CXvLEBrG3U3oSUx9soTzZ1NJm/IeLpoCWz8yK7q66K2QXhmesXd7YqZsIcSWeLfFYiUNt+qCngni18RTvPS3iOa73j1+6VwXeDU9vf4r193zhOvK4jXbzbcq2jY3bsjl1n6yUVDmyzMjxqZX18JRqwybni3TUjnM7BAxr5TziOkjFGoSCEHY4gnyDIVxeKlypFGs7mAWDoME6nxy2CubwFDXkaP43e1+EpTSjUZjeadS5jKJznpYMKYjoxvwW1p56fs9Zqyqntys16Pt9Y0/hHBe+lPkd3xS6Sh7F0VAITjZv/jMJOWjfDLcBCMHmqO5aoBlvUrhplEWHQkDcgoLZKuGa7dmkYBxmlOBT/K9w6uub1eH9BZFzYmMMVmLOO3L1aO2UqNHYk7cYgu+mS1qLQOXV2QjxKm8QZEiBi3dc2VN9VEhqB04xzgpDvR3UKMjVDD3x0FDbr6lxcaDFu/SCp65z2ew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f84c8d-c5d4-4c89-f7e2-08de76051636
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:35:35.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vwj74V7+UZYXEk22xb2HDvAfuWxnPeeJe1A21W83u9A6uJFB/iJ+9wJwA3n+SqThMljFv2/7x0iIpTFoQGuog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270120
X-Authority-Analysis: v=2.4 cv=XZqEDY55 c=1 sm=1 tr=0 ts=69a19dad cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iFABrAoMAAAA:20
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=-oCLXbLYl1vJg8Z30FsA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: OyyJlwN8UQaqDj3UYl_zozBwHL4LNtwv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyMCBTYWx0ZWRfX9gdgXRSh97xW
 nIZur44U7jUJH4g/tEVpul7lVUYUbEkNgXO5K63hZQ5KoYlxvJXF1goUTO81Oe83alMyFQEke4C
 YKZtUcwJ+FXyQqR/S3hnYc7kMqZEtHay+CV4jfxoEV8k0tHSERf8j3GAAkRVmqpVc2tldRgn7IJ
 b21Nn2qI1ZCSkc806FyOIKUzg/3gDsixiOlcIp97r7f6ScSGMvdy3DyDzedsB3+9FfQvriFMEeR
 owR6+oyiHK04hwK/wzrCR+zlAUErm45JB4XFEVCP5JTU6MhgtSvPsFbLTeJjDUbm6Lio4dqWds9
 NsDPHWp3EoLQRLEGegqX6qq8NUcZ1Y1zqS04ZQMfMfopHY+U98USBLN3pWgdxNLvQ+cad3UBQUT
 gd4Uw/HY6rm67K4iks+oWunkSbXU0e5WDW9es3SFEeyx/iIBHtvO+uSGfpjtmvDt0WEOQ4DIRMV
 xTTUsgSKmw/1BHKYfvw==
X-Proofpoint-ORIG-GUID: OyyJlwN8UQaqDj3UYl_zozBwHL4LNtwv

On 27/02/2026 10:52, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
>> index 266d4ffa6c07..638615ebddc2 100644
>> --- a/tools/include/uapi/linux/btf.h
>> +++ b/tools/include/uapi/linux/btf.h
> 
> [ ... ]
> 
>> @@ -19,6 +29,8 @@ struct btf_header {
>>  	__u32	type_len;	/* length of type section	*/
>>  	__u32	str_off;	/* offset of string section	*/
>>  	__u32	str_len;	/* length of string section	*/
>> +	__u32	layout_off;	/* offset of layout section	*/
>> +	__u32	layout_len;	/* length of layout section	*/
>>  };
> 
> Adding these two fields changes sizeof(struct btf_header) from 24
> to 32 bytes. In libbpf's btf_parse_hdr(), the non-native endian
> path has a strict equality check:
> 
> tools/lib/bpf/btf.c:btf_parse_hdr() {
>     if (hdr->magic == bswap_16(BTF_MAGIC)) {
>         btf->swapped_endian = true;
>         if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
>             pr_warn("Can't load BTF with non-native endianness "
>                     "due to unsupported header length %u\n",
>                     bswap_32(hdr->hdr_len));
>             return -ENOTSUP;
>         }
>     ...
> }
> 
> All existing cross-endian BTF has hdr_len=24. After this UAPI
> change, sizeof(struct btf_header) becomes 32, so bswap_32(24)
> != 32 and the check rejects them.
> 
> Would it make sense to update this check in the same patch as
> the header change? As-is, recompiling libbpf with the new
> header breaks loading of any pre-existing non-native-endian
> BTF data.
> 
> This appears to be addressed in the next patch in the series,
> aa01655822a6 ("libbpf: Support layout section handling in BTF"),
> which relaxes the check to a minimum size comparison.
>

In order to handle all the fallout of the header size change
in a 100% bisect-friendly way it would be necessary to squash patches 
1,2 and 6 in this series into a single patch dealing with the UAPI,
libbpf and kernel handling of same. I'm open to doing this,
but am conscious of the fact the larger patch might make it harder to
review (for a human at least). We used to explicitly separate UAPI from
other changes for BPF, not sure if that's as much of a concern any more..

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22482435858
> 
> AI-authorship-score: low
> AI-authorship-explanation: Standard UAPI structure definition from a known kernel developer with prior lore discussion links and Suggested-by tag, consistent with human authorship.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: UAPI header change increases sizeof(struct btf_header), breaking libbpf cross-endian BTF loading for all pre-existing non-native-endian BTF data; fixed in the next patch in the series.

