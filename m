Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520114F20E;
	Fri, 13 Sep 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247170; cv=fail; b=uuUM9ITjdTnZLv4drw7Kkj3GQ7QQHcO2IunJmMyOtGTI/fq9CxJMa+800IiOmNjxo9eC4SzNjFVErXc1YZT9yANFLLCmMxtrpzD6jKX1aXnOhCT7VPsYz8rwZXrKzGD/QkS5oa+YUmVQts9ZKNK6YDUYfKkmTviPsOKCfpMvEHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247170; c=relaxed/simple;
	bh=1XkPQoaOm8OY2T8r8xmuYaleqvRbCwDL1cFN3j03nDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=arTCqRZrDzysIj0YTdPuU7CVOJwMgOjMBluYuXomwgioWFeGzwHT/Sy8mUMiULF9Iag+QN3h7wBtBDtYApDE+To9m6uycGWn7sHxWssmK5xoWCBj3b9MZ9zd9hSnkquoT5eJOgjUD4gxJAu3uJIBQ5RW8dhxgf6FFyPp22i3f6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TJoqLMfy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gwpaD+OU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TJoqLMfy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gwpaD+OU"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGkYFo029440;
	Fri, 13 Sep 2024 17:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=PgfDZbVOVhXTDJ
	kiYuZnY/o7qUSEsEk4+DqzAjuObUM=; b=TJoqLMfyNbZNul31PQkE2/0QNtw7Q6
	x0xyOzL3o1zf4TTb5kDB15n7tlkIh5vm93fJiS+Tyw27X22SZ4wLIVVll4XP3x2T
	uPdR1C3Gb2K9U55l80NaMIxyzpp7OCNM9tORsNqneZxQqyc6ETK83XEfe/MOVBqy
	6q6PpJstqmTRxr7SagQXtcmPZBTAyYwUMIq7B5Keo7Vd2mEDy8X6sbotx9SmG5FB
	TgfG8kXpgkykK4/yrHY1OjsuXF+yHwp+4BV6erNgs8oUIfesmLpIa8du8kRvZcWP
	iHAoAO7iIKX8M0IeRpRUl+zJx5bnzwF1Jtxv7Z+J1JU3tThtFLdRqKfQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde0e75a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 17:06:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGeWWb033168;
	Fri, 13 Sep 2024 17:06:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9k8a9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 17:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYLGPIcMQMTUVUHXSr/SG8iXJbPd3b63OGL8rbJxt3WjKuofu86IU4Czp9qCiEuYFPsSO9sZotvVoPLzEjEFty0Ejtz7UYNY9FZItaMVRvOofRUydabqsHE6h1MW0j0ew/JpMmoz2gfDeaM7P7TzwueeUzL0+/qOsNFucGSq8i2e7uBOjeX73iWk3JAwOY/Opiwi92IZ767fzDLpON1MeWpbJ+tELeTu3m4eGANS1PFX0i4wM8sPABq85rAx51h8JOWHGaJwrizPbNcEnV+muDeC1ULN9cS/j2uS2E32n77mvXY6bWQ9ssuSsPR21xwIoY90pjuUwmxVrIwvoYl9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgfDZbVOVhXTDJkiYuZnY/o7qUSEsEk4+DqzAjuObUM=;
 b=V6mvzhGqllf4VB9rdLH4i43QVaAIw32TQ4ZEXJG1mOJ5p8Sih1xNrsfklVHwg65OL1+kS+WAoRIo0/EC4JfE+vOVmjW8Lfcj7JGeVc2rIQug2ubmMQOnxxAYZk3bC7Csan77FCBndvJ8HzgGti62h9I9R8sWgSToPQy/goslu2W0wc/TDRsOhLKgCQwZPTsUcSaxFQ9T96/67xOLPy3J7dElNIr1bb6D98UgVv8WfGC0ob3Kef75l3uJgxNllBMyExZeuA7aw/kmPVEd0WoSotL/P/6hXwnPn7faFCRe0t9dCmicKPw38jFsxYqJwM5tOPbW6kBWM1Resd+jZsSA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgfDZbVOVhXTDJkiYuZnY/o7qUSEsEk4+DqzAjuObUM=;
 b=gwpaD+OUvtHDM3T98VM5aaZ2EDqULH8NKt1UOoURr+4GaM6buMT/lTuXQuZZSaJ8+DsAFZIANYdi1sZ60B08xuK/W1lPm1SDalHKxbJySVOmF08gu2a18rdIqV3Y12eNlS8V9ZnPrASzHrieI2/OaoO28tWvrlzy1JA/XAeg/io=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 17:05:57 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 17:05:57 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves 3/4] btf_encoder: cache all ELF section info
In-Reply-To: <bf2a075b-1f30-475e-9d64-c96bbf646454@oracle.com>
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
 <20240912190827.230176-4-stephen.s.brennan@oracle.com>
 <bf2a075b-1f30-475e-9d64-c96bbf646454@oracle.com>
Date: Fri, 13 Sep 2024 10:05:51 -0700
Message-ID: <87wmjfmqkw.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: ROAP284CA0093.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:10:40::26) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|IA1PR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8740e20b-9d75-4c2a-5f1b-08dcd4165590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhLk1OFfv9jzzm3DEEj4P1LGro19iU9cOguzMMX0bMjl+Lnc3NWyx5fq9Oh5?=
 =?us-ascii?Q?M+EMBkqJ180ty64XRf0CKbRXDiZpUVcPgjM3ftLAVzyv2rPLU0px2I9ME682?=
 =?us-ascii?Q?vfMw1P05t6+H0p3nwWJqSnBwJ6lKMsztoy5MEuC4WK5FgbbrJLHeXwHWClWT?=
 =?us-ascii?Q?yw76F/EUw1YYWbIE/hViHKpFnH3tpuuVeVJqYM5EYrM1k6M3oRzYMTFLTf/B?=
 =?us-ascii?Q?li0xkK7dpnPpfZpMEM9j/YmspzYkkgieCJo9Ydwlo/q+3Ay+0cHX4DzYiGp7?=
 =?us-ascii?Q?81fwQw2w1x2ikOhlZr8tzgGCWy0SnzNyTyRwN6B8h9SyRKO9OSD2jmXMgJFh?=
 =?us-ascii?Q?/deiepOttQYPbROCYTtyPZov0cKSb2Z/99kjNrqS9zH/ul+T4SqH8QOyZ/tI?=
 =?us-ascii?Q?orzM4Hpz7u6rpZkBoaCjbcVmaJppO9+y2CjAyUkTyoGOYLRNS5TRSzsIa48D?=
 =?us-ascii?Q?R+ZMW0yHKvtdnPaZNGKZ7QXLtRPKQ3e1hqu31X/QkFWoo2PFHuCqZxaYXxiM?=
 =?us-ascii?Q?HJp+DTE5LEDvPUmRodP+opwYyEIfsugMj4i/ToZyP7GqR0jKdk3ht6648nJL?=
 =?us-ascii?Q?ZjmH6s3EpEsgZbZcVMtjw+1cJmlExa2V/LopgpiRSMVJGFzXni5qLE1EpNYk?=
 =?us-ascii?Q?I3vHMgoMlGmlTQCTqM85fA6Lgh24Y3r5Qmrj8T6H/iiF1lh3eiqqhbqq3I7E?=
 =?us-ascii?Q?GaxNEpgVId4kFiqnr5pzVaM0Nl3xjKRtZ1h93T4gvZZ+Ktr3XJe0iGzP8JeG?=
 =?us-ascii?Q?HR1fVGFvn0vxsfVQXDrOYQZdxSq4qPfSrY1BW+wURlpL5fdwp6WShxLTLeuo?=
 =?us-ascii?Q?5k1HIMXYwveutAIymWR6rNVYc4yIdUkrLQlGYyVBGOgQXKYTXMZkLV2BK4WR?=
 =?us-ascii?Q?x+e2c+AxBhPFkLKWO6d4aJTFS3jzcZ/RpaVfvDv/p1VXaIXedXQAzL1UlQuw?=
 =?us-ascii?Q?5xuctgGYvud3FkNGjeyNZpSF9HaaiGn8DOGebXXSU2TWPhaHM+D+SlFCSq9y?=
 =?us-ascii?Q?PDtIY+U0cKgdwCsE0YW92nxbhG9B1zUB2JRep5rUxECb0267FNzS+tYe2IeW?=
 =?us-ascii?Q?H7LUe0nNS12ilz6GFNzlRsw+15oRzJdf00eX2xxowdIzRTBOt2/U1u6KYD44?=
 =?us-ascii?Q?8bV3mpsq5BLAUaVYpVbnszQLBxA4GEmdE/D7CoFVOA0oZc9xqoNV7GyijMhs?=
 =?us-ascii?Q?neYuUKa/o0kgm6/PJqx3rr/2T9Sl7HHxH/sSwsIpG09zN32bp0HSU0bgMYKo?=
 =?us-ascii?Q?nzYjtU5CAkbTHe9UAJKxJ7aKiYHqFFqUSQaILM+AcefDS5sqbRgG7BLUoRc3?=
 =?us-ascii?Q?QYLMP0YwkvpaZSeoX5kFUUXNcxn+Os/7+uKvIr/wez0CHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TT27QAmMCYbiAEEc61LhW2+UqQ9MTG7cTAG0Tk+KuF/++qiKZaLUSk2roKGK?=
 =?us-ascii?Q?BAbUue1SUpphGJDYRpZF/0PB1n+roxOjipaveV/nCdA0aODijTqdYb8//RTx?=
 =?us-ascii?Q?nQE+zToPKun4JPa8ExwNqnXaNpTxp/qcinC3CCa4rpUcKRkOGFb4Yr4+vnnD?=
 =?us-ascii?Q?h6CyKbuxX0AqINno9RCHdv0KKtxfxnVrSnGrr9m+fPAbZRHp7H9kg46gjhEW?=
 =?us-ascii?Q?04UKISIk7posExrxoSNVb1TAHIwo1uFlRF4DslkeilNVz7PC5PEfjsn/uiaM?=
 =?us-ascii?Q?ne/YUXZ8wMW6bt0+lflFgxufu1KgEb49oWeZV188E8K9MQx6KoLD6pjOAzq7?=
 =?us-ascii?Q?RHoX86Z3oM3Y1qF+7APiGKB1c9BYBs19WGobO3y4VObO1I5fLRv82Ww5tSx3?=
 =?us-ascii?Q?ODAFqg0n8amsIr6tCNN0KJed+PbpQ11oMAz2IqA+jKrIPZbd+sLW7157K7Vk?=
 =?us-ascii?Q?EB0nrrbnW5ApaipA9/Hi+1IE3X9kXH3PZtP68FvrbgxtlPCBBCjZ6UyXbDf0?=
 =?us-ascii?Q?EaecfRyfUhdSWG05XikRoVVnZm3xwflo0G+hUsvqYTBTclrFlJzXbjRwPYAc?=
 =?us-ascii?Q?t0BUQjd6LXEVAMDiQ1goV9J9EVzjd8DDGTLAqwI8f+UdralsasM5AGn/d4mW?=
 =?us-ascii?Q?iX4uKPKtJ9/vpYUGp0AJwjqFgA+K94bua3OTQh+ZDZTRv+rsiUCDR9xPxeo4?=
 =?us-ascii?Q?hxPFAqFTTyLn081c1aIirYd6s5LQed9B9TsgyNeJvvhNaxvIaz2tF/JuqBtx?=
 =?us-ascii?Q?jhEtAGf7LjebyLLlnov6bwOfPTUelSFBHz1vip3OChFukd6woumYgVYQn1CM?=
 =?us-ascii?Q?0f5yqOhwL90jQttd6iuf28119Q8elw3Oddp/4TM0W5Avbh2fsR3jdapI/VYS?=
 =?us-ascii?Q?gQG/JkuhNetifdvSpebCrtP+p7DkUg/s6tj1bwKZe6ywZDWmovSXMStWJQKc?=
 =?us-ascii?Q?7SlMpD/9UBmoztqwTA7mCe47YTNuvP5lCq9wFBtafFvIfXRokHA+VNkbRLN3?=
 =?us-ascii?Q?h0rwVD0mbGeixR36q+wkg6zW+tMIOcE3Na1Dy/aj+s74q8J0rZzfj2rHh0hV?=
 =?us-ascii?Q?J+L4GYL8H4xXlvEBcpoKmf2SBOephW/vQmm2tu39Ovyob2UgT5N4cQjuOaMm?=
 =?us-ascii?Q?68eE333+M4Rl49eougTzyKdtHrhWIZbJv0suh2zWsG3xNuw8+a4f+fSV7KA1?=
 =?us-ascii?Q?MHB2iUS81lW9Kue6egVq/dtgodPhzmo1fR+IRG0dQUaryoA2+yzdrYGXaRm/?=
 =?us-ascii?Q?oR7nFji/Mk+jkoJb0HPcdW3etbys6e+WBm1WojojLvqx5pOqELMsd0ps+E+y?=
 =?us-ascii?Q?5XizW8Mahc5I5y6cgfBLNo/F0/DuM6/JJpTYAFhDAuPLzNukXQSOU6OEElt2?=
 =?us-ascii?Q?YY5VT4SodNohajxa3hEVBQFqiMw+SWIRyZUR8InCFfLVJCQ5R29AGx30bT3R?=
 =?us-ascii?Q?SAHALEIxaSZOJktvgqhu4uq1o+ov0gFEOd4JAPIK2huWtra70IYIOLztqU5U?=
 =?us-ascii?Q?M1gSTCTA4RExEUEVWMNq775xRaY7YaXZEauR9+C1YOxSF/OBICRSaHQ2h2PO?=
 =?us-ascii?Q?IXJ3MZ7GaAVoRdQWPr9nK+05PV+/+DJ/aeUnSTHmzJu2qejUsdHG/XUNjZEk?=
 =?us-ascii?Q?/NjaABwrxEMfVR6jcM+PVoQfzLLhOn6vhhl6iPVByFxd7i+/37+wEvm8jyA4?=
 =?us-ascii?Q?+TtttQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/iJotZO4ntiKm9Cr5NAqEIyxeKkkC0AvXpSX0MIexI6GIj7pyPpIu0m6zFueBYF7QwtTafrJsyfrtLNkogHcakXPSHS2B6LZqapybkvaXPqMCSJx38gUeFxuWiATq8n4EQ5o7f/2z29R76JwBQAix4+HdE3V8hCGW6FXLWB1YX/9p8JBN4lDPgSUlB2DUU0VSwI+Uuw6P/on1/WGhei3/tJ8sdJqBvAX507hCsdwmnIeHJXIfoiTis2uYww4Q/QCBJmHJoVsBiuSi1tRnqMFFezePcfegzzpbRqCINgZXcUMZJHe76fYBaARL2Nt7zMIPEQKbLd+MuiBLWtXar6UnwAerPc17TD2K9fJ74TGm14eoQVv4+RtlkNvoGs41pg69VsUfpDqiNd4N2M5WqVQapaZY5iAlyQPX/bJxk5AnL0cQrpSmTppZXgnbNBR2orF5yqTKKgyaqa4V4k4T/oXaS6gVAubSn9uo+Zcksy2qas6DOmwjGAJeCrmL2suSZxFOeYVUafC5QjxlUDDE9QOP+fSd6Tayc5/HvoAyy/fPwSErXsu/pszw5UyaZB1h1MnckQMcegz94lxrgnyyHKWgAdV5YhVs4/FDzRsJU8J9pc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8740e20b-9d75-4c2a-5f1b-08dcd4165590
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 17:05:57.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LzpHWXUc4GcZLs2LefozPH3kGLHCbjhK0JWP8ROravepqvvYZ6UCBee5PLsQ5bOp5gfR0wuEtCwaDIZiQR3n2kz5ZVcKP02HzWQGAbMolI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130121
X-Proofpoint-ORIG-GUID: oSsFx4lkkPZcjMBnU32ywY4MZWAi0rv9
X-Proofpoint-GUID: oSsFx4lkkPZcjMBnU32ywY4MZWAi0rv9

Alan Maguire <alan.maguire@oracle.com> writes:
> On 12/09/2024 20:08, Stephen Brennan wrote:
>> To handle outputting all variables generally, we'll need to store more
>> section data. Create a table of ELF sections so we can refer to all the
>> cached data, not just the percpu section.
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>  btf_encoder.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 36 insertions(+), 14 deletions(-)
>> 
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 8a2d92e..e3384e5 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -65,12 +65,20 @@ struct elf_function {
>>  	struct btf_encoder_state state;
>>  };
>>  
>> +#define MAX_ELF_SEC_CNT    128
>> +
>>  struct var_info {
>>  	uint64_t    addr;
>>  	const char *name;
>>  	uint32_t    sz;
>>  };
>>  
>> +struct elf_secinfo {
>> +	uint64_t    addr;
>> +	const char *name;
>> +	uint64_t    sz;
>> +};
>> +
>
> One thing we've run into before is hardcoded limits get exceeded on
> systems, and while it seems unlikely for 128 ELF sections, I think it'd
> be better to make this dynamic just in case. Also for parallel mode we
> have N encoders so it might same some memory (which we're pretty
> profligate with in other areas). I'd suggest using reallocarray_grow()
> as we do for functions. One thing we may want to tweak is that
> reallocarray_grow() will grow by 1000 or 1.5 x the current size;
> starting with 1000 ELF sections is a bit much.  We could perhaps
> tweak reallocarray_grow() to have a min_growth parameter to control this
> and set it to something smaller for ELF sections, what do you think?

I agree that the static allocation doesn't make a ton of sense. To be
quite honest, I was lazy during the initial implementation and intended
to come back around to make this dynamically allocated.

I think the answer is to simply use elf_getshdrnum and directly allocate
the array to the size we need. I'll definitely do that in the next
version.

>>  /*
>>   * cu: cu being processed.
>>   */
>> @@ -95,13 +103,13 @@ struct btf_encoder {
>>  			  is_rel,
>>  			  gen_distilled_base;
>>  	uint32_t	  array_index_id;
>> +	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
>
> ...so here we'd have a substructure like this
>
> 	struct {
> 		int	allocated;
> 		int	sec_cnt;
> 		struct elf_secinfo *sections;
> 	} elf_sections;
>
>> +	size_t             seccnt;
>>  	struct {
>>  		struct var_info *vars;
>>  		int		var_cnt;
>>  		int		allocated;
>>  		uint32_t	shndx;
>> -		uint64_t	base_addr;
>> -		uint64_t	sec_sz;
>>  	} percpu;
>>  	struct {
>>  		struct elf_function *entries;
>> @@ -1849,7 +1857,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
>>  	 * ET_EXEC file) we need to subtract the section address.
>>  	 */
>>  	if (!encoder->is_rel)
>> -		addr -= encoder->percpu.base_addr;
>> +		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
>>
> We will need some of these mechanics later when we encode function
> addresses; great to have this!

Ironically enough, this code (and especially, the is_rel field referred
to here) gets deleted in patch 4. Maybe I should have left is_rel if you
think we're going to need function addresses from the symbol table.

But patch 4 fully embraces simply using DWARF to get the variable
addresses, and it stops using the ELF symbol table for variables. The
DWARF addresses are always absolute. I couldn't really find a good
reason for using the symbol table, except maybe as a decent way to
filter out bogus variables that didn't actually become real data. For
example, the x86_64 percpu region starts at address 0, and many bogus
DWARF variables have address 0, so  making sure the variable matched the
symbol at address 0 was a good way to filter bogus variables.

I didn't think it was a big deal that I removed this behavior, because
with improved variable filtering, this code continues to produce nearly
identical percpu DATASECs, with the only difference being that we now
(correctly) include the fixed_percpu_data variable for x86_64, which was
omitted before. So there's no regression in functionality.

Stephen

>>  	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
>>  		struct var_info *new;
>> @@ -1923,6 +1931,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  	uint32_t core_id;
>>  	struct tag *pos;
>>  	int err = -1;
>> +	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>>  
>>  	if (encoder->percpu.shndx == 0 || !encoder->symtab)
>>  		return 0;
>> @@ -1954,9 +1963,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		 * always contains virtual symbol addresses, so subtract
>>  		 * the section address unconditionally.
>>  		 */
>> -		if (addr < encoder->percpu.base_addr || addr >= encoder->percpu.base_addr + encoder->percpu.sec_sz)
>> +		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
>>  			continue;
>> -		addr -= encoder->percpu.base_addr;
>> +		addr -= pcpu_scn->addr;
>>  
>>  		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
>>  			continue; /* not a per-CPU variable */
>> @@ -2099,20 +2108,33 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			goto out;
>>  		}
>>  
>> -		/* find percpu section's shndx */
>> +		/* index the ELF sections for later lookup */
>>  
>>  		GElf_Shdr shdr;
>> -		Elf_Scn *sec = elf_section_by_name(cu->elf, &shdr, PERCPU_SECTION, NULL);
>> +		size_t shndx;
>> +		if (elf_getshdrnum(cu->elf, &encoder->seccnt))
>> +			goto out_delete;
>> +		if (encoder->seccnt >= MAX_ELF_SEC_CNT) {
>> +			fprintf(stderr, "%s: reached limit of ELF sections\n", __func__);
>> +			goto out_delete;
>> +		}
>>  
> as above we should just reallocarray_grow() more space.
>
>> -		if (!sec) {
>> -			if (encoder->verbose)
>> -				printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>> -		} else {
>> -			encoder->percpu.shndx	  = elf_ndxscn(sec);
>> -			encoder->percpu.base_addr = shdr.sh_addr;
>> -			encoder->percpu.sec_sz	  = shdr.sh_size;
>> +		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
>> +			const char *secname = NULL;
>> +			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
>> +			if (!sec)
>> +				goto out_delete;
>> +			encoder->secinfo[shndx].addr = shdr.sh_addr;
>> +			encoder->secinfo[shndx].sz = shdr.sh_size;
>> +			encoder->secinfo[shndx].name = secname;
>> +
>> +			if (strcmp(secname, PERCPU_SECTION) == 0)
>> +				encoder->percpu.shndx = shndx;
>>  		}
>>  
>> +		if (!encoder->percpu.shndx && encoder->verbose)
>> +			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>> +
>>  		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
>>  			goto out_delete;
>>  
