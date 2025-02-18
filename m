Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCFB13B7B3;
	Tue, 18 Feb 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897686; cv=fail; b=uvnxii4HjwT52SK32qKwNnb76e/WEL3wfu+3KJVpAqKIPGXXm2AUbeFxYyE62MIol1sOFyoZbGxJgzhyTJmuf3gDmpjlMpIQcuO1LnGvA0giQU2nzVwMWRxFiLIGPsXRFm5RfKyPEpP21/8e7la7T9eWuyTUYq0H25RCBeI9LDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897686; c=relaxed/simple;
	bh=C2RvAptJGA0RbgiHPx4UkiaLQx9HB9n90z/PwoThrNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=p/PV5lc0Pmhap4FIdoiChFPanmjkMg/UxqtfnQ94qc0NAFsnuIHIHH8tFVsJLJokBt0ntfZ1fPiCGEKf0xBEVeqK3pJRvh+KQCKGXBjaFUcWotuTeIMpMW3JxwXg4GqW90wL9+vhtHbrwsmfMRaf+I5lkDyR2wnxT81dO8y1A5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UOj+OvjE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wk18Kop7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UOj+OvjE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wk18Kop7"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGMX57001518;
	Tue, 18 Feb 2025 16:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=icA8SuTWyf9PAVaB75
	UankZm17HQg6nPdnRhbTxlP/c=; b=UOj+OvjEF/w1lzAH5nszyr6RxxmIEfT4t0
	mdeLkDEIOOs77U1fIBoNY+Wqtdr338IzKgqy/QUgYzkn+RPOOLJM9sjGHFwTXU2+
	/QSohSwldfIpCxTekUug6kPYf2PRBPPl3vVF4oC2O6QuFD+mE0VLMvpNTQtkUZwd
	9M1S7lMJ8BJ7G3/deJYDhepn9Q3y4QDrGhmXSWSn30Eve98H5vzQSmb7gpMAdBy3
	5DjJzlyMe29v+wlv+8ZEoMDdKUTqz88xaaM7qPXndYJ6SPPDwHcoDOVd8FBUXH8M
	wQckz5KqSFpurnAvTqbqSP2cPXVqVpCc17K9KgnKsPQClolSgtYw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tkft71qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:54:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGR9sW005198;
	Tue, 18 Feb 2025 16:54:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc91h5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StSo6FWcf8AL/71nmSq14/vo4H5CtSK4x7tFp63oqbW48NFEb2zMuzMwJbgFyHVUPLs0JYPDSCE71ZfhEEkAn+QM4Wj6M3gdmBDWquSLCZ++jba0p5lPj3DRwZJv2ZSOyHs+HjPuD2vwMBTdwKf/PhFAU22kKtlaLrCK7Rleu+o8nRD8knKTCEUzuFlvX+MKIaBbJVbaCqfLtwvgG6+JoYf5zzocsVSlaO0WfTPqLYMphSoPluF9NB9uyylxmuJTSZxKGakfnIGDbkTiJfPyTT1lWoPbBpnSgF6h97oKAND0xczvKBUgjRyLRNTpSlHJAOBQy0AOljW+rG+RW5OOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icA8SuTWyf9PAVaB75UankZm17HQg6nPdnRhbTxlP/c=;
 b=s9XV1OqVwlTmFSsJXU2NBuh+uxcp3hb33k0Eu7/qyqrizF+TeRfSQQRiWcJuQoXHe3q/VsM0Mjs4ozjkPm+G6JxgShWmtgU8czTpU10jwD/jGewdsPa/xr/Pm4B9BzJMpPQf7O1hjkhz4QcGiSnNTO5gcKwGf7yYBHvLulwZEiBJupLHb/H41za+n7jAFYRBdqlXADYpWnQSzKPxz3wjxG1yLCfGadjNIgruiIQlNuUInKuXEfTYtWTMfCxNy4vOrckSNuc/9lWdtxYGnv7qVZwi+EQYW0VHlCyyLoeM8ZzqzBHZhbTKNzEIlb115M/BZTV9cWIomLs51TIaNrAlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icA8SuTWyf9PAVaB75UankZm17HQg6nPdnRhbTxlP/c=;
 b=Wk18Kop7MX3mJ2Oq4gqvSTe+OUJkZKANBWzt6st+qibHwhdFEWFsNKczF1Jdg8vpU2AkKjWVeXJF7PNqQ+cIX3YrKN17YrpuWT9Y5e2nC/AMeZcPuAkYeaGUvPrdnlaeyshLW1PaxlPf0VXJT5Q2kGQkebAEHNhg+dYwtFstkv4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CH3PR10MB6762.namprd10.prod.outlook.com (2603:10b6:610:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:54:38 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:54:38 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Eduard
 Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH 0/3] Fix duplicated VAR and secinfo
In-Reply-To: <377e9ec2-35fe-440d-923c-8918756fc635@oracle.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
 <377e9ec2-35fe-440d-923c-8918756fc635@oracle.com>
Date: Tue, 18 Feb 2025 08:54:36 -0800
Message-ID: <87v7t7fb1v.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0741.namprd03.prod.outlook.com
 (2603:10b6:408:110::26) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CH3PR10MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c6e9c7-c132-4a52-bfab-08dd503cee62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ig7D6EQHymyZXHqjbrNRYBwFt5CcPAl5xY8qt3il3qAUZJ0k0uCWLRPAQv9I?=
 =?us-ascii?Q?ujtm9ITekQ4YFzKyHthZQF7HkaYN8aJ532C+2aj7YDDXPTQtr+p26NK06mmX?=
 =?us-ascii?Q?Pa5cuKMTsNfhiP/Cv69WgvwJ2GQD5k8v+GnVLso7HFoiLUiYz4tx/RdVBPcq?=
 =?us-ascii?Q?K2E0lUsL2HhOoBRKP6tpFRrfmFb0OWu8Ab2M4uVt/XgAlP7ucsxuFK4LQFgJ?=
 =?us-ascii?Q?rzWJs/f71JpH4+/w2McmKvAc5xg5sb/3eKF+792SuHjqY7Vmny3XSnrxa5cx?=
 =?us-ascii?Q?7G7mojQQ/NRy/5M2L0jN4l87UD+klsw2xujpVF4cUSiRnvFceTa/JWyTPbAH?=
 =?us-ascii?Q?CsFeO1tUN2CBUP0uo7OFSEQbQGAsOi0SH0eFtMPqVCEBA49AEXtFmpptov+2?=
 =?us-ascii?Q?8h+kwQ1KYVG/8gqo7oYLsjaQq41WA4jhW8lAxmollJChZwNS5whOZSLXr6pc?=
 =?us-ascii?Q?NiL8IBb3dSQh7WSKA26Ec7LpFtHZWPkb6MqKwqrlBCCc61AcnzCYm4kom84Z?=
 =?us-ascii?Q?UtwMfMjw21SQurdNHr1BpjBWQFqgZx2Bu6XqM+NyIg1Qrzy39IXDKMxQDxQA?=
 =?us-ascii?Q?CvhsiO7kyWBjIQyVrt9TArv3AvkUL7hOpN5+okRcEKRj7MxyesTXUSR8IFdF?=
 =?us-ascii?Q?//knYgDQUCVymsasAKvYzlnnuZXBAI1B30UXy0cXp9FAawmIYC5esEShRWtS?=
 =?us-ascii?Q?dDvPNceKnZzZ5RXn0a+Y8gaRY4E1/19gZwLESGxzDEDJyqr4R+o+H+GboPPL?=
 =?us-ascii?Q?6gq17kJcd9g9pV32DaDRKAkCOIXnXfFb0JrWEWqlCtkN4+zBhk3OvRFO0HNM?=
 =?us-ascii?Q?LhwLzCqAThoGenCYK+9JRjIHMu9giqzpSC0xaB50erGMKudyGBa3tK215Bm7?=
 =?us-ascii?Q?9NprB/q7YbGNDwPdoLFZ2/ATYTi5DvPAAct9CY0gsVA8SA+DGLtV2Cx84Bcy?=
 =?us-ascii?Q?02iz5aVOtoXGguJDnfpLhp9y7SiNMz7FHlkD6shS/tBpTh8+UVuQ8eVyznXP?=
 =?us-ascii?Q?7dUA3GfEIAhHnrosyAR9A0GixBI2wnxjpBVuLKcE/AeJDIIgpVl583EdWq9n?=
 =?us-ascii?Q?Ss9CfPya2fmrxJYtWVsm0GmTTGH2kRvgvi+MjYmIzRHtYbhsdE4rlog7XrT9?=
 =?us-ascii?Q?d8BrZKpjy8J5Ukv5yGXLCuhxyX8aiCHTA5pZucH4IQV9z6YcvvLUBBP85nOF?=
 =?us-ascii?Q?FzQYDxeYFDaMwlT8ptnsyTp0bxNegBu3ZFx0Qa9SgNQbxqo2jj2VzjQ264tn?=
 =?us-ascii?Q?Q9E7Tg+DuSrADfJQELwy5/6QgaPcKQv2Z+HAoAu1EBuOfZ8LswJ2NVLwqfy1?=
 =?us-ascii?Q?Xy84FPXwhjD7LmOhDS2uN3PbX6Lm6RjnCF0Y3/mkNIbMfFei10RFZHVmVHNf?=
 =?us-ascii?Q?JNcv2FryDg8/eAqOWRzwR8umr1kE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?12fI9sdY9dzvRMo7TalVjHcPk0HEahvMIrFzDtMEdhYuSqhJXJWrnqJq1CWh?=
 =?us-ascii?Q?yo+olXaFM6Apb+F4PpJori0iVQgjsjsGB5NyaMm4RKWn3kgx22Esbf8CksHd?=
 =?us-ascii?Q?Vzgc1oguU5DZh1vQGVmzi0jmeW/Fww7DRWiVETECQIhWxTIP89iPLwmnTIoD?=
 =?us-ascii?Q?SPMEkaCEKLgzwqGPlUU1j1T7r4M178TIlB7MDTFeRSdKFtNRI4bv+IVWuSCC?=
 =?us-ascii?Q?rB6ctT0srr/GKRvrKaMFxB9e2oFttveSEwh3SDBRqXPFU9OZpzjUWP92iCqB?=
 =?us-ascii?Q?irK9xtEshqqa/uaPqcr6FpdEgs5LVYFfgnWvhRewV3Bpy0zho7fKnJvyT31D?=
 =?us-ascii?Q?iYKZOrtWyr/9p5Om9Eddyngkq/qLg3VDMF22FYVeyXskHAF5Cnki6Ppqbbwk?=
 =?us-ascii?Q?06o6VwfEyc9/LIR/EWhzQe1+BEiEbcL3YkT9WDDBST5ZRY1dZxe732vcSHM3?=
 =?us-ascii?Q?j0rSYX6vy1g8TxTjjaOQ3r0qrsa5PP5f0inrwYW54/NLkB4IESxradfi7ID9?=
 =?us-ascii?Q?KQt0sPgGviFAnKTsQ/DFfb5uqiyM/UtFp6ZuSdvvRQueFFNSfkDGxKvhH0Pn?=
 =?us-ascii?Q?FWDGRQHBcty6UE4w+UJCG6dDgAfmOl8fwTW6tsSCmMzGaXq9cZDrizaTAsap?=
 =?us-ascii?Q?p75ipzgIH2ivziIyfTBA6+DWF60Xid2yTxmkocJm8WQ75qcD5Na3P7XV9aZX?=
 =?us-ascii?Q?88N6lg5EwZE5wrAUSN10ykBHHWhb/LjwdcGorWW9qSyk4XEcDmWmRnTH4l1+?=
 =?us-ascii?Q?U1eGHyOGt8AaA5ssHjtPkK/eHvm0DN4/5lH6BacYf69p0e9UXei2cqIXWRxn?=
 =?us-ascii?Q?gdkynM1t4PxjR5lEsj/wFyCcqWpgDx5h/vtG3sA+RL0h0KKMDvf5kpi42Wvu?=
 =?us-ascii?Q?4Lx6C3ObrLLuch0c5k3bx5bf6Nc93CpD/COiuR7W3IAgpVARLHanvwfIWaoN?=
 =?us-ascii?Q?cWLDSzY8ImFaR6J8zag33VcIjUQw2XE9tji12DpWaZCNnUADdHulZVGic5VZ?=
 =?us-ascii?Q?+gfHxGYpQ///mAhh1whxSld4gYQmFPLwVry2rrQiqV0+tX0QP3SNyWs/pQ9l?=
 =?us-ascii?Q?22y1C/ZbxxAVoWljfSIP+b9VOE7alyyiTVGY0YOpD2Oz0UHv1fJUlXKjY5xF?=
 =?us-ascii?Q?aWcFIOnnnqt2+GezEY9ra1JS3SaMXHcDh3xN5pDXLgKfUdzSbgh5LdZmblxR?=
 =?us-ascii?Q?A11UQdbnTyQrPqw1Arw8yY6fGyLsQBcSqoEhcNADIxBTh2sCFlDrimpBXvWJ?=
 =?us-ascii?Q?Svw/tAidbzPX/iraL9x5X8mdOZqf2MVOA2QMcZCint3GOrBIe3V2QJvvGloy?=
 =?us-ascii?Q?fJlcXEXsTc2jy6EIhVxv40cuE30w6lutL+J0M2e7FbKHGZWzemc5SOtAkR5n?=
 =?us-ascii?Q?NoFLgC64YQfWFsyYT8vjc3rVwnlLdzV3w+isHlY4GtVbD42gPLJJN2f4/Z1q?=
 =?us-ascii?Q?GUejm3OK6fahiA/LIcSHbqvmQMbjjX6W8h8IoNwPloo/6v8P5gn+BGJLZkQk?=
 =?us-ascii?Q?PSzG4Zf4oyQWYen1QRI2lmhv1frqK74DQSBRl7AUW1v6Y89hymA6guS3eRL8?=
 =?us-ascii?Q?etG06JXtjuYZxLDbKWguAa/OHkrQ9tU5qP+csi1HrMJKcniADLRauoUNIA1i?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OH65WucwFndFnGTq5HvEqlvN+4qmvg2KrvHkILKE9RlkPV4GGjkEzk3ghYsDzxz7VsDilejnIlacvDAmOaIzPFbM12zkv83n8o4SLsBMbNgkbW/Me+dC9RGr+tSkiYp7lu8n+JbNgLQf3rCVvsgZXZq3vbpenD4nPJqo6V6xgtSL2tpcIpNiAZrGU0Usc0LARM5Etv6I7z7JqOsXqnT3EwQpUc4u4gWDye2y4vdn4QL0+cJ9XNKtpSZo5SvWL9pKo3mbyWkA05oj8xbjNxhbZLCIgltS/iRPs7kTmael4AuUr8ZeEZC70kSkn9FFZtERptY7BmfeeBVN2JzNSnkQWNfxgK4XmOB/zEz9WsVh29kUCOHfHAKkD1kroa4ybP28BwM/UtnNLqUsh566YGAJ6+9ADUZ8vM504dbT9hEfOYeMgIHy4kgW4zTrjVo69XFPK8ICxD4/3DBOlmFXSkrEPn9qJfsa64MiQSyIOPM8xOGT3q9/LqpRh4JVq7nYvzrlK6gAuRIPKFx4EXqW9+c/SqVk3jrFCzv/WbwXS6iR0OwI+tGUo+TPBOMqMGc2vXWzVgCXrbPQYJuZvOZ5h84sehugEljO32F95Seu9Xca0gg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c6e9c7-c132-4a52-bfab-08dd503cee62
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:54:38.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goOUDHytfxVA31LMvM3yRsc4KtJoOHjCL6EpL8KRM1Z+2iMS0MPxRFmRo4iqPA1BKumu+PmrXHW5lrZn8h1ZeyqvYJkEHZZkfrzj8tXfjWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180120
X-Proofpoint-ORIG-GUID: 6ItVFWY-PdYyLjnG5DZbg3semoGQA2JO
X-Proofpoint-GUID: 6ItVFWY-PdYyLjnG5DZbg3semoGQA2JO

Alan Maguire <alan.maguire@oracle.com> writes:
> On 12/02/2025 00:49, Stephen Brennan wrote:
>> [...]
>> to feedback or suggestions regarding this. I implemented it in pahole
>> because I'm most familiar with that code, and because it seems to me like
>> it's reasonable for libbpf to expect that the input variable information is
>> already deduplicated.
>> 
>
> I've been thinking about whether core BTF deduplication should handle
> this case - I'll try and lay out the process and maybe we can think
> about whether it's better to solve in core dedup or within pahole.
>
> The deduplication of VARs should be straightforward - they are
> considered reference types and since in cases like this they share a
> name and refer to the same type, the reference type deduplication could
> be extended to cover them.

I wonder if there's a hidden catch here... DECL_TAGs can refer to VARs,
but as far as I can tell, the semantics are that the DECL_TAG actually
*modifies* the VAR - it says "this variable declaration had this
annotation / tag / whatever". This is fundamentally because the
var_secinfo doesn't point at a chain of DECL_TAGs, it points directly at
the VAR. (Compare that to, e.g. const/volatile/restrict qualifiers)

So, in a hypothetical situation where there are two variables of the
same name & type, but one of them has a DECL_TAG referring to it, would
the deduplication keep these separate?  It seems to me that would be the
correct behavior.

> However, the DATASEC references to such
> variables are a bit trickier.
>
> As seen above, the kernel currently disallows DATASEC btf_var_secinfo
> references that are overlapping, i.e. if I have
>
> [123520] DATASEC '.data..percpu' size=229632 vlen=392
> 	type_id=7708 offset=0 size=48 (VAR 'fixed_percpu_data')
> 	type_id=5559 offset=4096 size=4096 (VAR 'cpu_debug_store')
> 	type_id=7060 offset=8192 size=16384 (VAR 'irq_stack_backing_store')
>
>
> ..the kernel enforces that irq_stack_backing_store starts at >= the
> offset of the previous var (cpu_debug_store) + its size (4096+4096 in
> this case). This is why the kernel rejects BTF with multiple instances
> of the same variable, since they overlap.
>
> So if we consider the case of deduplicating variables; before dedup we
> would have something like this in the DATASEC
>
> 	type_id=8188 offset=256 size=48 (VAR 'foo')
> 	type_id=9190 offset=256 size=48 (VAR 'foo')
>
>
> ...and after dedup + remapping it would be:
>
> 	type_id=8188 offset=256 size=48 (VAR 'foo')
> 	type_id=8188 offset=256 size=48 (VAR 'foo')
>
> This still violates the overlap check. So there are a few options here:
>
> - change the kernel to relax overlap check when multiple references have
> same type id/offset/size; i.e. they refer to the same variable
> - have pahole weed out such occurrences
> - something else?
>
> Ideally we don't want to have to resize DATASECs with such duplicate
> entries as that would add more complexity to dedup.

Do you think you could share a bit more about the added complexity &
cost? I admittedly don't have any knowledge about the deduplicator, but
naively it seems like the ideal solution would be to delete the
duplicated var_secinfo and resize the DATASEC.

> Anyway I'd be interested to hear what others think about whether solving
> this in BTF dedup itself or pahole makes most sense. Thanks!

Thanks for taking a look into this! Hoping to hear from other
experienced voices on this question as well.

Thanks,
Stephen
