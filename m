Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2E428849;
	Thu, 26 Feb 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121412; cv=fail; b=AFrEA3waYm94Bd4dazRiPkPfcY9Qrc6zbD4oa3hXIvVojRH7SYrY4oeJQ8yh2Z4XKFJqoKHWLITOPcI3GGlAj6hY0Nq2wdDDqVzokSK4wqJSWi+K4ci96uKZE0Qn9ZRPOos0AxYySzFOGA9C8q78Gcud5IjCi1K3mJu6yAEAtNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121412; c=relaxed/simple;
	bh=SdW3nnlXH5gW9NCIZ/ImDXtQXw8zMVFnHK2MgDFbEzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tGg03TlPnl/ErGylSb+Ivn+p5jP9Ipzwp9Tau27OcgHCXqmkbUKm8UxSjbCdd9dEN2ryuqM9VXRfPC7FgtQf+/u9q1V6ogLun8kNQeSFQZaFQhQxVbzI6t72FDiKZu9bCFjV2KhvWukX2sVDUBgPVqzXbMhnrS4TGMPE9mgQk5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cWtR0Rx5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lDNxOT4z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWtR0Rx5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lDNxOT4z"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNAlj193290;
	Thu, 26 Feb 2026 15:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j4t6jt1N+9JFV/EBM2zy/3WidatMLy6pPjEEaq3Mhno=; b=
	cWtR0Rx55+Qhgo2ydWwH4daNWuiBV4W1aQ1mNJ3OfmL48G6lgrof396ev4fwIe01
	bNvE6ntJ1N+S1tdNd3NY5YJB5on076kj4afaKEanbMNlLi1iiHe2h38dUNwMV4iL
	WZyyGDdVZ0vcmYX36H/swkdlC5fi1uQ7fcB2GHLV6NmKX6EC4n57QHU6htRQ+ENG
	tLVsZiWn1+jij9gmqCBEelczWA8sej27ZkFeNnVs0Z49ygeriOZWsRwRIOG5nW+0
	rlvOIZPgX6lCEp1rdYXRgAnFT/L1wQhaldHJue6ZnC3JaNfySgfvv7Hx37uFK76K
	cjwgaNDK4/vT2VarjMxY9g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgg3rwep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 15:56:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QEro3l012751;
	Thu, 26 Feb 2026 15:56:13 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35gwge3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 15:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgUllP7RmBvtUHScpyA2pEyW5GBf2bwla+bLSgA+zg7aYmRiBZEfqu9vEjTEEKfgUwXwoNLheKbIcAc8Unrn5HhLwLuuVaVxfOPrh/OET+8EA23duTHAp8fk5c1dCySQ6UxL0UUz2sfqA148pusNNZj5FrBvy3MG3gSIJnNPBU2WDVPZW5C+T6kSyeA/nZRihWyTWwWHvZ+ti86NvcFd5nWTGXt/PJxrueokAQOPAdzEeehx16vMNqqNKLu3+CIkhOlIf55XgZlHsevdzWIz61V/kCRyKesSe7py4g/Fod6bQgzWHdbuSQ7EiGIPh106G5RjJLLYJCX4RhsP5CzWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4t6jt1N+9JFV/EBM2zy/3WidatMLy6pPjEEaq3Mhno=;
 b=c0Ko0mDvm4pNAxU6VyZdJypBFvrcnZXm2HanFgdBOv3vIhCJ0qwbjF2W9nZXuplURHryqslq15/PNt1qQpdEcQDzsShGgfp+ra+SU92ikUgeEA1zPWtPj7TEskAyupduYrNwOx5xnFnRPsplLQShEfNRN928nBygSxEQwnIIFVS5R1YbjqHxhDvT+jpEQlq9M9MgPr4gneSH/0Hp6/NDQmJ0mHBrTfZ01CMEa/y3Rce70BvcAN3QKmzAddxRK8Uvb3qAjbYD11xyMx4wGGmi6w2EeRnjfF9ah18eA72g/vtmcFa5mMyk0AJ1y5ct+AYfw19aIYm3DtlO15MVhX3tVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4t6jt1N+9JFV/EBM2zy/3WidatMLy6pPjEEaq3Mhno=;
 b=lDNxOT4zIJDInJ6ZKtNl3yTRnuNKjh/JtYTFwczHSmuTrmp8lLGMSilCvT9LVW81bz1GcBJ8b338N6g7bYzplFilfMA25/gv5nZmHp+9/VeiSTwqZ0If6iHbUUw+msh6NAobIWpU8OGFLf5moD/OXTPPSr5lqahyaGgnwAltg0w=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 15:56:07 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:56:06 +0000
Message-ID: <37ec740d-b7d1-410a-a2ea-331d19b59f5e@oracle.com>
Date: Thu, 26 Feb 2026 15:55:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 bpf-next 02/10] libbpf: Support layout section handling
 in BTF
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260226085624.1909682-3-alan.maguire@oracle.com>
 <1e030700935a6f99789250a8841c908cfda89f4e5cd215ada2485b02c07994c7@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <1e030700935a6f99789250a8841c908cfda89f4e5cd215ada2485b02c07994c7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CO6PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc87ca6-260e-47fd-2219-08de754f8cce
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 VdTN0m3R9FU4PbhrSdm7Z9qBez4VY4+ufE6UgvhHTuEgEBR8ELdiXzjEXSaMu0EQcI8F24n2X3zLWwYEUXW5wDCUdFmHblvsvUWjtqfbumOqQ/H3DwsWvGzrHbqVCdt3kCO4t/eECtrXARAXry8z4zS/rmLoWnmmBIlpVyLtbM2WBzlfeHx+BYOBd3kseHLNaIObgj/pISmEZnCPaIHGnYezMkYWpVLDdDAK5t+7b9V7Pb01SrpPx44imzZe17xmQcd77rQM4zGn7UDBG7LD4MK0dH+SJazuK2iQ7QCRsTCeN3UZjke3hdxGbtPri7VQp11J+wrIKBK8EvU3PbquKRnzo0jJGoerZmSlJ9ul7g9bJHD75pzvDon8kfdjNc/bNOeLWwVE2Nf9FXXyoB4OFlk0VD9jsqTrTnBefusCj3P8eBf1g1T7zjJPQ3mfm3Mwqq+02IcMSCvXz3d9RwCM/7O8N/o5l33eAnp1WR/F8DnPlnI4EELTZMkuEPTDoim2tESB8v+RxpxMer3pA5q+/zSbM+OBnqONHJdwyd8t+DXsth/eIXTRIK40bcWMlYHyZD3YMlL/k8Paad5WSSrha39YaZwedLoN81xj/OsPpTlbu6N1NtsZjz1OE2PnHOXkMkwRClEfOx4kyh3dQ9NfmiI1cXUWY55wWqZuBj7RoITqJ9Gtq8CjhClIdZIgvt7v
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VDJHbEtZaWI0c0pFZ0ZnNDZtVjNRazljUWZiVTA0ZncycGREV3piUWpNZFdi?=
 =?utf-8?B?MXpZSjZacHJNOGJobm1EUG12MUV3RU1GSW5wMTVhcElIRGk3Wk5nOHhhZ3kx?=
 =?utf-8?B?eXRCdHNRK2VvdmZLVTJ5UzBwWDNQMFJVVjdFdFhYNDA3QjRybG82WTRVTjVq?=
 =?utf-8?B?V1VNTTM5UndNSitkd3B2SGNaZlBvR2N5bllQZWUxWUdDTWUyMEZaVEdobDNR?=
 =?utf-8?B?RzIrVmJQMzlBS2NaZTdwYzIvcnpveFZRL1RJUE9BdUE5dENia1Z4VU1jbENL?=
 =?utf-8?B?YlpRY1pBVWlsb0x0cFVPcml5UTVCTmxLellCT0pEUWpsM0NMbVlRMFEvVXpi?=
 =?utf-8?B?TVRnaDU3UUtsTXc0eS84ZmlzL2ZBWHlkdUlhS0JSNDFBN1h0WU94TWhvWmhn?=
 =?utf-8?B?SjlZaHc4bVN6SVpUM1V5RUs0NkZ6VXA3WVk0eVI1Q1Zyb1hEQ3RaaWtqczJq?=
 =?utf-8?B?WjYxa2Mya2J2ZzRHcEpTUGNpNXN4VitYWEloc2J5NGd1Z3JPbVVpYWxHa3Aw?=
 =?utf-8?B?ZFg3T0U2K2hUODdEd0lldTcxVFRPRHNmSEVKNUFOY2J1U09XVUtUM2JNQ2gy?=
 =?utf-8?B?M1hzdCt5NXY1S3lHM1hSdGlrV2cxSFR4b2hPT3ViT1JoRWJOU1gvUnEwRW9q?=
 =?utf-8?B?V3NicjRPb1FvUm9BQTBzSzJNL0FMTGE2Q2d4Qi9BUmxnYjBzL0VReDBONGdt?=
 =?utf-8?B?VllzRTZQRktsREVma1Z6RHQ4RnlsQlI4VW5ObFoxT3dpWnVxUFA5cU1IcHds?=
 =?utf-8?B?UDBlUHRBbXZVaE4vTE8rU3RiMlNOa0ZYRjNNTjhwNm1kSXR3U0k1b2g4d0Z4?=
 =?utf-8?B?RER6WlJwN0kzSHI2L0NHTGF4V0RqUENZTDh0R1QxK1FURnFYT1V1TnV3TTVZ?=
 =?utf-8?B?dk9ScTRGUFpITU5ob2J6SHN4aC83dGVyZEdBTW9mVFBBMDZ4L2h1OURmcWdY?=
 =?utf-8?B?NEJXb1JEZTFXREtjMHl4aTZTZzJkd0ZYeTQ2QnJ3aGpVekgwcEVHRThhZ3Ru?=
 =?utf-8?B?cTVWVHd6d2Z4TWZsTHRRMlpmQy9kMGFkN20yU29pTXZJaGR3akdwT1dNZ3pG?=
 =?utf-8?B?WjNIa2tIbkZmUVhlYmNXK2JPc3d5NUJTdm5UZXpzcys3SWhmdTdreWs3QTVi?=
 =?utf-8?B?WkhtZElSY28yQnhIUHQ0NG92MTdyMzZjR1grUCtlYW5uajk5RFVrVWdSTFcx?=
 =?utf-8?B?SkEwY21Dc3JuM1NOWjBRa0wxbTl6VktPNUVYNEhnT2pWdVoxQjF6aDAvZG1Z?=
 =?utf-8?B?TDV4bXcrRWl6OXB5MjRObS9tL2o2Wm1OSzNidE5USDBmZnJTN0ZuSG83YWs2?=
 =?utf-8?B?T1R3ZXJHdk83MjgvaXA2UmtHeXd2YmZIM3B1QzdsTDBpRWZkeW9RTTlFbUFx?=
 =?utf-8?B?QUEvVmN2aFkxMTYrLzhRdWtTM2tiSUVENG5uUzI1SDBicXdTMWQrSk9OTzZ1?=
 =?utf-8?B?QlJMN1RpKzdFTjVLU3dSQmtKS1dlNlVJZnlTWFNhdUxMUzJRdmt6d0k1enFJ?=
 =?utf-8?B?YXNwRzJPc1cvUlRRNGVwdXl6MW9iWVlWVXdWa0hhZEE2Z2RxMjc4clpUbmwv?=
 =?utf-8?B?T0l2UURJUnEzbzJrMzRnNFhhWmJndTNnRzBWa2Vja0U3VWpxcDRmNThuUkxk?=
 =?utf-8?B?KzMzcVl4dWlyWXMyWDMySUR2aUt2R0J2NnNiUnFTV1pTMjFUdmpKT0hIVkZi?=
 =?utf-8?B?K3duQ25PSGdER29QOTJIRGtTaWNwOTlaMkVIOUt3Rm1sZnF0YjM2eHpHdGMv?=
 =?utf-8?B?OEpLbkVwa1NJSGxiTnlNT1FKcXUxTzRKRkFFL29WTFRmTGh4enNTRHZCM0hT?=
 =?utf-8?B?NXorODdpYnhSRWt4eFB5akJkTWFJUW1sZjl5aFNxUzMyR1ZFeThBVWxubTV5?=
 =?utf-8?B?YkFYUE9JZ0RpV2ZZNUxOUlUwY0NjRE5SaDNpMFZKYit1YU01cENVRENnSXdU?=
 =?utf-8?B?MGMxU1J0Q3M1S2tsOGttdjIwTUxLV0NDQ0VrTFhadS8wNGgyK0MyT2tiQU5T?=
 =?utf-8?B?dkhDYVZuYW1NMzMyYXZyUFRFYWNHaWw1L3NUUEx1T3M2ZHZZSTFVdHBEU1V5?=
 =?utf-8?B?elNya09WdGdOQ0dwVkd1STZOalNyZkdUZ0VRbHYvNW1JZkVQc0N1a21heFBV?=
 =?utf-8?B?VVhaOHFESXFqdS9lNlZHeWpKQ3g4VFAyUHpPOVdobzk0bXBnUG9vcDlBeDFj?=
 =?utf-8?B?MTJnVjJtODlpbXZFeVdJVGZRUzVUdTNnYTU1UnlxY1Q3SUlRWkcvMzJZRlBp?=
 =?utf-8?B?UTRqOEpUM3l4STRZNzdpUkJFditzN25SWUtlRWZDZkZjaFozWHNNbmtCR2Zm?=
 =?utf-8?B?ZjJjZlRQMlpNWTdIRjcvalZpYi9QNDMwRVplZnRvT1gwdkdrRElaZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k2KjNYtHSWbuA/X6hDeBCEGSnhSMambRItsjl5vunhuP7TwLhgd2jzjKjjHalVEcVh3Qk6p0V/esPKCz1lhE4YEsVWtKXktVWDoWUKgbbwLetHeG6Hm5cQ8bZrlib8F6sOi+8Nk322EX2KnOhHHUj8LhDNK/opDcDywauCNU8l2WUax0w4SjC+V7odoR0knJYP3lVkXxXxbd0cfYut/oDPrPf8OS+LFt5Jg0PnNwWfnWGW/HVxUUCbpJ3AsoQziADTvvPHAbbvDKgGLwMaMM5a02giEJCmYugqAFKZcJbs8AMREF7oPhs/hxsb7LYpZ9G94kmCKsJIsS6khceDNKve5FMGGQP1yvYE0o5HuZowuDa+yFkpU5WslKpuNoaoZ+f7XVh2vG4YN+6qqlSAgntnHBm/U4armzE3iCLmvJrzVni1K2H3XoUliFt6lu8mhZ/c81RdNAAZ73flEQG9mDYPcUal1wli7iFcljxrS4wfOS+VGuElH/TgKweXx+Npx2N8nTWxXMRbOVZmZhRd8h1gH8yMF/7uVSDA7dlneYutryPsHlHOAz2J38VxcY2rT9B/brj6kQqle3V7QJjvbxWOOg9aAIkav0PehdxpLzPnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc87ca6-260e-47fd-2219-08de754f8cce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:56:06.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olKQwctzzqmz/MZ3bp6J9f5rwL1qid+7EQjftk6Cp0lFdRR44l0JylmuiPqI4UTuoAZCsSzePnhU06A1Ou9S5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602260143
X-Authority-Analysis: v=2.4 cv=XZqEDY55 c=1 sm=1 tr=0 ts=69a06d1e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iFABrAoMAAAA:20
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EIAQhg6-gCSQOtpnFwMA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22 cc=ntf awl=host:13810
X-Proofpoint-GUID: sLK19yS5FAG88loPBFMd_w9pirCwVjma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE0MyBTYWx0ZWRfXybWb55oMm1lJ
 mjIUFddi8EbC3PFqWKxfJcjpR1MrBAtzZSgqV8I3gBp4MyU3MExkbqF4vl/qCNTI8efzX5btZ06
 h47u30AdDooEOKYyKr0Unbl+UVs3HBBc2kPxun9QX9wtBXCJecf8zKUnpWCLajccF1nCxucz64u
 1o+8K8OLDYp5sjNh+STMa/cOELPLuDsEPyaOGHrUobqP7ld3J6JgOh41bb5pOJjPcIzcDUipvzy
 gIArdVqZJPu691WBMs1dQH6N0dGhD+Ysk+29FZCSkXST+PBgPoQcSb6G/CBSzXzIDDQ3B+6lhpk
 v0KuSCFzD1iPogUkw2pCHdhT+iIbCf8ixCUsmbhmLy5uRcsHty/ZU0zCkoLQ1gbIkRzUpDAJUvH
 SXXx5nD5KG7bINO7YF2yjhyeXvPlDLCNhpw/r4lRXF/RaHttn1YS3SxpkPqCionKR27WCOu+rF5
 IiI3eYYExnHDlyw6lEa4Ne00a/ldtweShEIwT6FM=
X-Proofpoint-ORIG-GUID: sLK19yS5FAG88loPBFMd_w9pirCwVjma

On 26/02/2026 10:05, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 83fe79ffcb8f..3438cc15bb7a 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
> 
> [ ... ]
> 
>> @@ -224,66 +242,95 @@ static void btf_bswap_hdr(struct btf_header *h)
> 
> [ ... ]
> 
>>  static int btf_parse_hdr(struct btf *btf)
>>  {
>> -	struct btf_header *hdr = btf->hdr;
>> +	struct btf_header *hdr = btf->raw_data;
>> +	__u32 hdr_len = hdr->hdr_len;
> 
> [ ... ]
> 
>> +	memcpy(&btf->hdr, hdr, min((size_t)hdr_len, sizeof(struct btf_header)));
> 
> The memcpy here correctly caps the copy at sizeof(struct btf_header),
> but btf->hdr.hdr_len retains the original value from the raw data.
> If the input BTF has a future-extended header where hdr_len exceeds
> sizeof(struct btf_header), only sizeof(struct btf_header) bytes are
> stored, yet hdr_len remembers the larger original value. This
> matters in btf_get_raw_data() below.
> 
> [ ... ]
> 
>> @@ -1601,7 +1664,7 @@ static const void *btf_strs_data(const struct btf *btf)
>>
>>  static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian)
>>  {
>> -	struct btf_header *hdr = btf->hdr;
>> +	const struct btf_header *hdr = &btf->hdr;
>>  	struct btf_type *t;
>>  	void *data, *p;
>>  	__u32 data_sz;
> 
> [ ... ]
> 
>>  	memcpy(p, hdr, hdr->hdr_len);
> 
> When hdr_len > sizeof(struct btf_header), does this read past the
> end of the embedded btf->hdr struct? hdr points to &btf->hdr which
> is sizeof(struct btf_header) bytes, but hdr->hdr_len can be larger
> if the parsed BTF had a future-extended header. The extra bytes
> would come from adjacent struct btf fields (types_data, etc.),
> leaking internal state into the serialized output.
> 
> Previously, btf->hdr pointed directly into raw_data where the full
> header (including any extension bytes) was available. The switch to
> an embedded struct loses those extra bytes, but the serialization
> still tries to write hdr_len bytes.
> 
> One possible fix:
> 
>     memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_len));
>     if (hdr->hdr_len > sizeof(struct btf_header))
>         memset(p + sizeof(struct btf_header), 0,
>                hdr->hdr_len - sizeof(struct btf_header));
>

yep, this is a good catch, will fix.
 
>>  	if (swap_endian)
>> -		btf_bswap_hdr(p);
>> +		btf_bswap_hdr(p, hdr->hdr_len);
>>  	p += hdr->hdr_len;
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22436234361
> 
> AI-authorship-score: low
> AI-authorship-explanation: The patch went through nine review iterations on lore with detailed human reviewer interactions, follows established libbpf patterns, and the subtle header over-read is characteristic of human-authored refactoring.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: btf_get_raw_data() reads past the embedded btf->hdr struct into adjacent fields when hdr_len exceeds sizeof(struct btf_header), silently leaking internal state into serialized BTF output.

