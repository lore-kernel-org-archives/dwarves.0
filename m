Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DA3D9556;
	Fri,  9 Oct 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567206; cv=fail; b=aHzjh0nuvXgdcr/CLvICKBIiLFEUy6gojuZALXCIABxgYMUDYDErCofvZMovmotsXDQ+6XP6/tyAgAfEu5fZZBGbRYh7Bt9Q6JX2X9Yz6hvVeES07XL0W6LtB/BTGasxdGplZSmbDRPePNaObRVkJALqP7i0KlqYBbO7njHiOzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567206; c=relaxed/simple;
	bh=EpGnSEG/9QfSjviMpDNy6d81i/FgjnyCB0Pe+jUWr7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jpovKMr+HiaBWx1iXpGSDFWR+gSc8uJEVt6CUhdSm0bnQAn43yJa06KBfDqI75fHFD1S99ibwDKAeiCRKPkyJXvTsnpYJSo5KONzQ9SWpCxWUnF8h1Pm3RVz7C6VwV/GCbWmAkLaboBE4ttfIQQYfGgl3Ok7pf8QZ6PSyKJxHKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V2zunG84; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gJXwBlj5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V2zunG84";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gJXwBlj5"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699FMp1f3390258;
	Fri, 9 Oct 2026 17:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=elGHfwKY+ijnF4fPxWNXKf52LpJSGpY7mLgFI5bwhNU=; b=
	V2zunG842YpJ42L0ArpOi0qTyHfXXkk1bsqkGBl236g6Lmf6v1bMsQlR70c0sBaA
	hUkHyY4srTzM24xnk2o3vpRC1LnI5eTNEzW66MFTOFDQXpcOhbHjsLwiiAZGYzjX
	8O8nNm9vPOJQJNs30VLtzxhRaFJcjd/xxgdr0kWKSp8FMQubaphI/1erWFKb8vVE
	dNdBxXs8zXMu6UZBxBT8EZVoeUq1tw6sp/FZ6geniHQXeIcISqj8BKUwle9gSNrw
	/NOeCozHFwjBxW1+rwQah9JfFh+sCAo0pSVmbovZEWrWdh4R09WaHjvcUuPCKP/u
	QgXHy1i6Rt4eae7Lp8y+Lw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xeg3p2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 17:32:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699HOJxg020910;
	Fri, 9 Oct 2026 17:32:55 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h74mxg828-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 09 Oct 2026 17:32:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6FgO7ldr/54k4H2+G5xTGZjejw2PoqINaXgSZJ5/YC/j8LJod1ng7V7aqhglRm7Q2QvMW1LKrfm947kyi82S6qiuJUjEBfCaovds0iELH1jaA8geWQgY8FACPowwW58gFRBfqwyn3/Jd7ejYqY/VCz4cwaDrqq88jWV2RwqaiRHseHMnzut5zNrI2X/7tAL9627yDwAap4Cmv530j4F1BwQs6WpeFWKbgCNZ74i7HHkPF1gxCAtikeQaQHMSD3yBMt3kkKsuAegJ3Y/QFDPMjWfRhGhKVEELUwb4cXbA3ZNuUdBPKLTJK5czqBmya0pGrGRqd3hp1d0wHOCD/1cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elGHfwKY+ijnF4fPxWNXKf52LpJSGpY7mLgFI5bwhNU=;
 b=AB5himP7SWMgYEACLoYcNZ8X8y3U3gzoA/dI/yjRK1+Hwd/mLlwzzYE/uaM3XpAMHh2etNtU2oQg8Ddybo0yoWqI1Ct624oWPMY9SUwTAJ2NZgFPjAgX8mOXrCbaLXoDab840q2PHSeepuZFKEQE0RIZ49FyThmYUyYjybEXwBsplBoxOvCc8uzz3q/3kwYwVRAEZtXzDf4HyzLjewJhsx5cgNDZvGIMJabqRczdLMMtlG4lkYi209cbNaGbi1CF+Vw4/Cu2xQxo/tpqIKsPN7LbW+poCInF8LT9ADmch1fWsmRlcP2Cvw4+s4Yg3T1XCmI3qvetXl1oXtLFe5Piag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elGHfwKY+ijnF4fPxWNXKf52LpJSGpY7mLgFI5bwhNU=;
 b=gJXwBlj53czynsHms8aeW4uvHRLEJ3+8kjNHq2Q2DCb5XQicAT5aWdEe/8P1uVT00TjnwouYM7+T5CNs1Qhu31f9WTWMek3bJ2IEW8GAkg4IVMqqarznKGexv/i/Cg1zGOgbYmcMfeKoZ+mT1asWH/DO8f9PF0aoNSgTDhRjQjM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SA2PR10MB4458.namprd10.prod.outlook.com (2603:10b6:806:f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 17:32:49 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0522.002; Fri, 9 Oct 2026
 17:32:49 +0000
Message-ID: <0980d4bf-a1f9-4984-ac7c-51141d498e6c@oracle.com>
Date: Fri, 9 Oct 2026 18:32:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 dwarves 05/10] pahole: Support inline BTF location
 encoding
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org, dwarves@vger.kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
 <20261002174043.3823987-6-alan.maguire@oracle.com> <asjoNE3H9ZqL4rsR@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <asjoNE3H9ZqL4rsR@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0287.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::15) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SA2PR10MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 69edf0b5-d20a-4a02-462d-08df262b56f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|18002099003|22082099003|4143699003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	vh9bDNpGHVOAu9m25pJnlKQnay/3LCmFP42XvUekLum5nbeTHA7IywGe1VijT4WssP3sG2BydW2DnfbinK0Gs5WNJZMamFBJ0VOkANbDJTDb7f4U1BOvq+fZncTsqjPHjfXHgd0gA3yeIpSL9bUBiQq2UGLke0pYnVii5FI/WgRX0GQd/HRRUAFK2S1btsdM6/Cz3fLXQFLdUf+Yc07g2ifXCVR64GwxhLeWOxdMTejpxuiRE4IHi/By0WfiIISTpGozVdc+c14UE2NVdIVadrxIIm84y4afaJ+QKb6bBeAnUuqeMspAiT5aHYftweORRfDqTl+B+GtqRRSmE+INwR8RU3WJsgjWxbS9LrIq3aT+YEb9pda8UdIBpfxD9pfiNOu/SYZi8q50j1pnXxEwRK5KbsEy++whMMQTgzA6KF6sGgrmInEK1cRNZ7+gjVuglrAc785k4LavNuIytLddELcIayIY3MF9+4RuZZj5L9IYlzbNQEgy0OU6y4sZhdncj7k7vrXnULG9HY7/ANuHYxCVrqJlh9ARhfbsxOLJqTTOzpWij9SYhxHoMKFiws9ZXGDobA7SqfSTPmCWUojQXPMXxI8cfEi1NJe5Qnl6b6kgVgauaRFXA6MJFWKk9LyJcru3TshYZMpG+nuDL6esW/t+rfx5cS8pv8lpuVeBVA8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzJucFNCZmxTeThyRmR0dDlkV3pXNk10R3BiY2FnU05DRDFFa2s5aWNnWXUv?=
 =?utf-8?B?RW01ZjVmMEIySHpGTHdwcncxVXZXVHM3dkRubkxncWpNMU1EajBkVjlTZnZF?=
 =?utf-8?B?MFJDNnJXYXUyWjk4V25mNG9UVlBIMlNFbDV2Sk9uT01CblllczVudDFzT3lH?=
 =?utf-8?B?MHZNenJKaTdmRHFmWndDWWxqSmxVTDlCRTJwaFo4UmJsa2NYR2dBWE1LUEpi?=
 =?utf-8?B?djVDMElRWDJjSlRZMjFnNmt4VzROSFBsSmJuL3pBcFRLTnJkTVBlTWFkZmU5?=
 =?utf-8?B?SDJLTk5keFVrRnZMakJLUU90SDEvWlhNSklQN1BXZkJzZ1JHMHRJbEVVeTNR?=
 =?utf-8?B?bFZFOXBOOXZiRjVYRnVzWTF3Uk5peTlndXZkRWRqbWVJTUZqQ0RHWEh4NGV3?=
 =?utf-8?B?aERjYVhnNk42eW9kUjhrMmxCUDRyZ3hrMGkxTVJkVTdWRDZvWUpnV0R4aVMr?=
 =?utf-8?B?SUJ0UjdyWUhpNVlGUXJQR3pNTy9pclhDclhXVGs4SzZRR3ZFS3NMcm1yRU5L?=
 =?utf-8?B?cnAxSEJYWXZUWkgzTGRQVTlzbjlTR2pJbjV2KzBRcTRDWHkyb082a2Fjc0Fj?=
 =?utf-8?B?RWpmR3dYOWFQQ0Jocjd6WDY2TmRJREhSekJZdGFZTE91OXNLM2lUUThUUlZw?=
 =?utf-8?B?cjl4V1R1Umg4c0lCK1lqVFlubU52OGFadmtrSks1RmxmNTlGUTZjRzdPN1BL?=
 =?utf-8?B?MTg2MlNnWXFabWpUaHNDS1lEY0d6SGNxTDdQUkdkTENycGxVMFROU0l1SXN6?=
 =?utf-8?B?QmYvSGZLRHF1dUJNTm90Y0xtMkZONGY0aUU5ekhMRWtWSDFWbk1pK3NGV0ph?=
 =?utf-8?B?RnJqbXFsNStlME15Q0RQZmJvTzJyKzM5bk1sNHpNVlF2QnJmUXo3WHlIdlJ2?=
 =?utf-8?B?YmhhZjFJZWoxT2RsNmJ4RDVaVDRrVmlnYVVvc2pOUDRXcWdvNTdHamlBSTVS?=
 =?utf-8?B?UkJhU29MSTFUNzJoaTgvaUhUcnd4bjYxOVlJYkNXVkhKODdSSUlZZ2pBbTU4?=
 =?utf-8?B?OEpFYy9yVkU1TEhjbWRLUktYNFhtK0o0bnl0bE1rb1JQN2lkeGJXUG5BNits?=
 =?utf-8?B?MFp3WkZva2VSMldLNVN1cGtWK2ZPaTc0KzV3eGFsWGJzc3ExWVhFcDN6YXRL?=
 =?utf-8?B?MTl4MTFaWFpnVGZLRW5ZTWhDemJHVEYwRG5TYWVrSVAvc3lwbFdwVkorQ2Zj?=
 =?utf-8?B?R1Y2d1VuS05GNTgrWDl6cXQ2UUlSbW9HVVlQb3c1cDZrMGc5L09jeUhZalFO?=
 =?utf-8?B?M08xN0ZLVzgxMGUwV0laU1R4SVhrTUN0dEZxNFhUZnpjTzJTNmVsd3VwVHps?=
 =?utf-8?B?bGNJVXJZM3JLa08yaTRna0JWbERwZ015aUkzRjZ0T2hwdFRyVHpEVHdzVy9F?=
 =?utf-8?B?enJObkJha1pxTDJEVVRGY0Fxa1RUWTdxaW5NaXJCUnp6c0xhOW1RZ2VPdmxx?=
 =?utf-8?B?ZmtsMDFRMUdJdE1rZHNOT3k4eHJGT2xOTzhtNkhjRHF4NjZDRUJZUHR2VWNS?=
 =?utf-8?B?c2R5YXc2bzJNUlM5aDBaODJZaUFFRHZ5S1VNR0lHWHNobVg5aUNsLzFsRXRO?=
 =?utf-8?B?Mzgyakh0QVIxSXRkMUcrcWx5a0txcitxTWRpempRMG0vTEJ1M3pYMENkNnVI?=
 =?utf-8?B?KzIvMXZmd3FUdjhYNmJLVU5mSm5XNWVqOERJTkdmVFlOZnAvOS9TdVFyVkY3?=
 =?utf-8?B?L052SmlvSEx1eGN2SU9XaXBHT09KQmpsTzcrengzUnhTZ0k0M0ZNVi92c1JC?=
 =?utf-8?B?L1d6ZjhHL3JqMVk0WUVNekdaNjkxMzc4TGhkOUw4T2JSLy94SU83TFFtdTFL?=
 =?utf-8?B?eUExU0RWZURmMi9veXFTcmtqeFk4Y1NocXR0dDBheFB1amszL28yaEpMbGFp?=
 =?utf-8?B?eUc4S3djamI0eEJ2WjFLS3hXRno1OG81TTF6Zk83QXE4UTB6bEw0RXZBZ1pj?=
 =?utf-8?B?ZkNqblJzdkVNa2YyNGJmc0J4WEpsenFjSUdzV2RxeXJSeW5MZHR5SzExdUcz?=
 =?utf-8?B?VUJaN1UvaDBCOVhsSVF2OVU5eGVacGh4K2NHRlJhRjhZSFNYVy9yZmRjNEs3?=
 =?utf-8?B?dmR6NTBISkl2VVk2ajZGUXZWTXlScDdqQS80cGhObkpFRkc0SGhlSUNuWUJ4?=
 =?utf-8?B?b1pFNjlPdVErNGZUNFF4cTBtbWxkczlaZFpCVlBsb0o5ZlBYUFJiUFJkUDBx?=
 =?utf-8?B?V1VJc0cvOEhRZGRhQmNkWUFlVG82dmk5ZVhCeXQrZ1ZHN1pYS0VKdjBOZ1VM?=
 =?utf-8?B?ZTZvaGpLN2RQUE1sTEhCcVFPTmRUaVFvSzBGVUx2d3pKWjZYcjExS2pmTFo0?=
 =?utf-8?B?TTFYKzhnbUIyV2QzOEg2ZjA5clBpQjZrSFQ2NE96bklwcTZnTjBtdz09?=
X-Exchange-RoutingPolicyChecked:
	Hcv+ShRy9gYEez005zYHx/RsX/rojJWynO733hwu8jxRADwPRH6tMVKzlbE+uKfplT/bR9UoRhEjiphHekmZ20K2oHX6WgrU13CEQ3KBk91eOghfKbUHxPH0y4+3/NCEOrP28Nc4kLHO2nudsnoCGyBiki7Gw8Js7uDz1uhj42hLUByxe2HFpbqrl4+mbM+2+gzpWwX7MJeA3JYB7AB2dj8dV8koXMzoSA/6qshda+dMbQkTF55ep8OfYchOO51LrxvyAiLji+XYRgfn7RtQbyhL66toTwOHkg4imAQx4lNu0redMn0ItCKv30vzIm5dWU6uZP3C4HjZuA2CBaXkcA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z0o6IAo/MeKhn+bnD33O3e+d+Ue0MQvr4PnFjiHtGvEOjR1kwraeYJrSLkLap/IdAuasA8xCh/3ESYc9mhkDJn5yWUgXa8FHUQDTKveiMsIC4TD9hss8ORK+tOXI15KB7z62WuMiqGS77k/wRg8UdbnYbjLHqrIuz3vYzRiIHrHblNCHSjSFoRKUJZQ1vyvsGl2WzGP4VWQIcGf/Gsb2Jgj5YEv/9D4vClBCCKjIh1BaTXzXcFcM+HET2oQsjODLLyGCHODGmTT6eqsSGhMRkxkg5Qh865morE4/9GzToCTGl9lwDv+vd1r/d9aj9zE5vgjxV0f0uiJLLNuaTVMX5MxnVtPMcDSdbW4XeAhYXAeIVkuA2Wgy/blGs73qOU8RAWAf9QSSrMVv/ikpUwt00qSygutTgjdp5rNBDfMvBFuhGqJnkZSgmyOcUmEJPwEY0euASDwLJKuow1QqKIHfzVWKA5q8RjwDpiAO5RFPD/DRIUuFbc3QwGTsGuu4pooCR76E8eXj3DAuqY0iEi3YQUZh4V7HxFJg44Um1yHsNHslHHXhxhNlQFnh4Hghl9kAmRFWZnsIewL0LCMbqt+Qazcj7Gkg37uipHHDp6mS+J0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69edf0b5-d20a-4a02-462d-08df262b56f7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:32:49.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5R99P//D1ZY5WfmZyZI9m2OMEqlZk43JU7y8tGmPagvAspbBuBkj+JqrLoUBTCg8qH4LEeZZkfklTOeKe4NUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610090069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2OSBTYWx0ZWRfXybsyO6uttEOC
 2+PcY15pJTFoCM+KSXa++A73Z6+SCcSS3dvl3k5ztcH5IaL2SquboEhoNCPdGtScGCAuNB5sDhZ
 x5AahYnXrJHHmJDvvMq5utY1OHZrq/7kP+rzaphrpD03g7/sChTMYy3K5JGFO6SXH0PQiGLTgw8
 +9JVnoSz3GJ694U+Ilulstuj3Td2vb9nhncH2f1yi8HBd/+EPtImh3zXXD31DVH2SxvmdV3Ei2+
 fzKHnY+ABXPp0Qq1Fs+l6DLTRdWgrMkeWlkb/U2tLDlVWCA/LxJr5AtFKd56Qz584p8sfjInVF9
 wjhGLDDUQjv+4Gjrk8cYAywiFYPYLtWVbQQjH43vcYsMomgADIxU2UoVculH+x3RtdjlpPhKoxy
 YIRstip/9O4Cnr3YtT6kiP426el3luC0GkZCBFgtGZEXMaN8MAYFcO6bubBfkA6E0Eway1HevJ3
 VmZ9P4F9b08bjKz7Idb+a+w8PX9H/o6ieNuZW/6o=
X-Proofpoint-GUID: lMoQwf2UMT0Jx14w6HWqNpPimHiS4NKB
X-Authority-Analysis: v=2.4 cv=NYFzRGD4 c=1 sm=1 tr=0 ts=6ac92548 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=TUXQibRWYbr_40ZaNxMA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2OSBTYWx0ZWRfX0hk4y9LJ3D5j
 jWjJxXWsHXTrn/YGFnFT34PRbD1HwiS11ktlvN/W2cX3SVUiLZbl5EwmVgJ9FJbn/03KvT7x/9B
 c4EHnjrhsdbAfmRQdzOYrfOf1oe5P4wBEqtMX9ln7DwKwHEwCRAP
X-Proofpoint-ORIG-GUID: lMoQwf2UMT0Jx14w6HWqNpPimHiS4NKB

On 09/10/2026 14:12, Jiri Olsa wrote:
> 
> On Fri, Oct 02, 2026 at 06:40:33PM +0100, Alan Maguire wrote:
> 
> SNIP
> 
>> +static int btf_encoder__add_inline_expansion(struct btf_encoder *encoder,
>> +					     struct inline_expansion *ie)
>> +{
>> +	struct ftype *ftype;
>> +	struct loc *loc;
>> +	struct parameter *param;
>> +	uint32_t section_idx, section_offset;
>> +	int err;
>> +
>> +	if (!ie->function || !ie->name ||
>> +	    !btf_encoder__inline_addr_to_section(encoder, ie->ip.addr,
>> +						 &section_idx, &section_offset))
>> +		return 0;
> 
> hi,
> we get inline locations also from .init.text, which then fail kprobe
> address validation.. is there some usecase for keeping .init.text
> locations?
> 
> I currently disable them in kprobe_multi change I have on top of this,
> but I wonder we could just drop them completely in here with something
> like:
> 
> 	if (strstarts(encoder->secinfo[section_idx].name, ".init"))
> 		return 0;
> 
> thanks,
> jirka
>

hi Jiri,

Yeah, it's a great point, and certainly doable. I guess the question is 
if they would ever be useful? Are there any cases like early boot-time
tracing that might find them useful at some point say? Or even informationally -
i.e. function foo() is inlined 700 times in the kernel, 20 in .init.text
and 680 in .text. Not sure..


On my kernel the inline.init.text sites are ~2% of the overall number of 
sites, so it's not nothing in terms of storage, but a lot less than the 
.text section. So I'm happy to filter them out if we think it makes sense;
maybe we should add a section option to the inline feature or something?

Thanks again for testing!

Alan 
 
> 
>> +	ftype = &ie->function->proto;
>> +	loc = calloc(1, sizeof(*loc));
>> +	if (!loc)
>> +		return -ENOMEM;
>> +	loc->name = strdup(ie->name);
>> +	if (!loc->name) {
>> +		err = -ENOMEM;
>> +		goto out;
>> +	}
>> +	loc->section_idx = section_idx;
>> +	loc->section_offset = section_offset;
>> +	loc->nparams = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>> +	loc->params = calloc(loc->nparams ? loc->nparams : 1, sizeof(*loc->params));
>> +	if (!loc->params) {
>> +		err = -ENOMEM;
>> +		goto out;
>> +	}
>> +	inline_expansion__for_each_parameter(ie, param) {
>> +		if (param->idx < loc->nparams)
>> +			btf_encoder__add_loc_param(param, encoder->addr_base,
>> +						   &loc->params[param->idx]);
>> +	}
>> +	err = btf_encoder__save_func(encoder, ie->function, NULL, loc);
>> +	loc = NULL; /* save_func owns loc after this point, including on error */
>> +	if (!err)
>> +		return 0;
>> +out:
>> +	loc__delete(loc);
>> +	return err;
>> +}
>> +
> 
> SNIP
> 

