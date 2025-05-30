Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4EF224AFE
	for <dwarves@vger.kernel.org>; Fri, 30 May 2025 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748609518; cv=fail; b=lRLMXpQmsa2CiejqxlaIez//MLXKA1VbvZ7gs9PLMHC5SpQmvvFwb+N7GQocvSV5/COvXIOgxvungPDyCBECZ95ZrIGQDylHRvsrkQIHpNONWfmFqQ3IVk4TGtOY3yap5HQE0QxA7ic0atkPTyJBFFFWJqv6T3UmVuZ3GIeR4XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748609518; c=relaxed/simple;
	bh=QdiRx4Cg20gcEPmluOyWKsHHQLN5NZdYkoE2hXZjf2g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZX1OzKcPrO+Rr8aMQ3cYHQY5sFdI6vTUVX6zV7VhQfIvn9/eU8r/0d8miThyjjUh93RVbnI3zslTC9o1Gn6eQjALYetroe4iq8BeL+TyWkIMBVqYPiOprvyDgJX/4YvleusF3WboThJ6lw9h2uCyZzyDKnwXzjbl6o3QE4cWmLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l1fuon6l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p779JeTP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l1fuon6l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p779JeTP"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAsxIu024760;
	Fri, 30 May 2025 12:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fldZOUTXtrLohtnBYCfIawAfHGaDlEu5dJVjQaAhYr0=; b=
	l1fuon6l7qOD3ikCx8axnYIRiUDnorho2IeFTI9ot64rQJ6QIVK6udZlBJlkY3pw
	raFt2CHtM2iHxzEUuWvy4U4fRPpDCP+3zTWgWpynGlgEFvXOawHvzqZ8E4+3pB0A
	/q+XC/HqALl5rudEPelItLFYM6X6eSnCutgHF8g4QdXW/IPelSpmzduWYN9ZRPYR
	ERO+ozglxcW5xFgWEgnk7/5cYzS8hUjXSxMmxXo+7bXkH3crugAwa4CXNN9kr/+U
	qshO4b7Br2ALAEzveSP0YgjKAnppO2RjUyJPh00jr38D1+JFCr4MwyWAu2dusKhm
	7is7AnIuWcQyGVpi0mJZVg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21sa1pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 12:51:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAoqQi026650;
	Fri, 30 May 2025 12:51:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jd7t2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 12:51:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHco2UNv/Q+NfK46CIPXJotiCpxhLVeA4sbhfBMw/QCONdTv3+ssbI6QxC4tc25+drTBox++iauD+q9wjd8P90XkcfLUGwBJ58uiY6OIBD6XC/pbmMyJNFK6vHHIUp/QLEGH/ITEZU7NfVEsMqGXu2E9HLL9KmeDsjnmDJA50E61j67rRk6kx5KhT7r4mAjpAqB6r+81j0lahNXx0dyqVNG1Q+aP11Zug4KvXF0W0o8Ev+2yDij88ldb/LVaEefa6YHrPh8JomGgBofCfstpIu0S/aqbZMFiojzx6YAbpWgzSi164gouREjte6s5TNAff2WjaDfyoCYIVeLLGlsuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fldZOUTXtrLohtnBYCfIawAfHGaDlEu5dJVjQaAhYr0=;
 b=IrufCW8QC9Sj6gwq1ZAvmUcC+LU9ZmVccdEM3+yyOafyYhGyTg8CQfTZx+yGrFdK0aro/hET0r/ZPY+jNQyW9q8+PXesGk0+dawZ5l91f4XRoZxKevZYKylyHSJjGWalTYV95YenRUTvo9Jtg09URF26+D5r+x86u10X/v/U3TuM641AR2RQCY6zM+3dKEVuize1yRqdypmmjoAbM6XI2wQCR9NsusFj4to3LaTwj/CZuZNDgoKGFbr1Qgob5q+BV9sS60+CLh2WWL0svZAmasKkQmFe5bSXOc6OL6pCETPe2ogxt86UiROc7JA21adZ7rvlG8CvMbLmo19U7AyNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fldZOUTXtrLohtnBYCfIawAfHGaDlEu5dJVjQaAhYr0=;
 b=p779JeTP3SzFPKlhETwQykYNbsW5w/tz2JnrgdIDyTcZIYGBEZrmUh1lfLMLw14WvzE0Bga+oFwBgHSeh9VlW0IX5xlarR3FSIBKbd1cx60XTlFiT4iT2obXrrMcuWI5+gTv1ZrXppWp9nsvWk5v1itX385JaDM9gHEQgHkcTAk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA4PR10MB8280.namprd10.prod.outlook.com (2603:10b6:208:55e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.36; Fri, 30 May
 2025 12:51:35 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8746.035; Fri, 30 May 2025
 12:51:35 +0000
Message-ID: <6eb0e0b2-019c-41b6-ac9f-efc445a2664b@oracle.com>
Date: Fri, 30 May 2025 13:51:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] CMakeLists.txt: Remove custom `LIB_INSTALL_DIR` handling
To: Paul Menzel <pmenzel@molgen.mpg.de>, dwarves@vger.kernel.org
Cc: Ben Olson <matthew.olson@intel.com>,
        Brandon Kammerdiener <brandon.kammerdiener@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20250420064220.81114-2-pmenzel@molgen.mpg.de>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250420064220.81114-2-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:10:234::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA4PR10MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1392f9-18ec-4673-4139-08dd9f78b58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEJKYys5NGNrVkt5bUkvTGtWVkVBNUNpVzdlcXlZR1JrN05WVFllT0hxWlNx?=
 =?utf-8?B?YWVKRklsNWVDU2R0UTBFWG45eVZheXUvczdKWEZoWjNzb01zMGR2R0Jzbldl?=
 =?utf-8?B?M0ZQbjJ3ZU9oaTNjNGR2akRDSG51UWRIWWZIbWc4eVQ3MWxiYklNTkVRRWp6?=
 =?utf-8?B?L05qRXZOVDBhdkVsZGJ3TjVMVURvWGdkR0ZHTmtNbEpZYUpna2ZKOGlmMysv?=
 =?utf-8?B?bXNCd2NnTVhlZlBzWW84K2wvNnN0ZnVhQWJTclVYekFnWnJTZzBseWFOOUVj?=
 =?utf-8?B?SjBVN0VWeDhDTGZnUzQ0RngyRHI1QVQ1RllWTmU0eUhzYTNQUmJnTUczUnRz?=
 =?utf-8?B?bU5Vc1VjOHg3L3ZKYkxXeTNaTEdZd3Vrd0ZGYU1qMlJwRDRZTFlJUG9KeVVy?=
 =?utf-8?B?UzgwR24vNGROaXh1Y3VzK0JSRmZDMGtOR09JRWRFRzRjSGoxT0t1S05mRkt1?=
 =?utf-8?B?V2RpdjlPemhuTm81NVZsUW5vZDlMRzJyVk1XQ1h3cnZFN2R6OU1ZZ3h5RTRr?=
 =?utf-8?B?Y3Q3aU1SU1NZcmt6VkpzbUtMRFA1WjNOcnd1cnVuVVRib1A5Mk1kYy80Z3c2?=
 =?utf-8?B?Q2lCVG03UkhTNU5iV1JSL0F3MEVxdWNlV1kxUmpKbVUyVmNpc081Sm1nVy9i?=
 =?utf-8?B?ckxWWG1FMk4xc0s5WlBpc1ZHNzdXeWJaWVVtOVBJV1Z6clNMTUtPdVVGUkMr?=
 =?utf-8?B?ekdsRk5qTTRRU25NbWgxQndjNjQvd2JtZGRScjVyQjZYRDdlMFovMXV2YnJy?=
 =?utf-8?B?cmhINFB6QUFYVjFSZEFDMWtOejZmOG1USHVVY3BvajEzUlZmb0FJVWROL1Ru?=
 =?utf-8?B?azJOUnd4cG5QSFVYaXR5QUJpcDJORGR6N0VadnhEeTZFSGhoOFNBZnp1M1pj?=
 =?utf-8?B?SitsQWIxY1NCb0RnU2lZSGpLWnlCVFRWYnlaWXorQk5aa1haaGtOWlJ1TjZW?=
 =?utf-8?B?V0F1c2MwdzJheW1uaVZYOWdlYzh1WHVzZEUvYXB5YVZDelNVOU1yNWw4VDND?=
 =?utf-8?B?NHZYWG1yRllobVVxZkVIOGFMenRTbUI2WkJQYkpWQWp6amk1VUVkRjZkUjhx?=
 =?utf-8?B?azBZaHBCd3VFKy8wOTFrVUo2YldVTlhjWVNCbzJGZGlZNU5UeUtPME9vN1lM?=
 =?utf-8?B?OVdhYncvRy80K0o1MFpDSllZQVRwbDFDWi9TOEtaSlIvZXBVcnVXS1ExS05P?=
 =?utf-8?B?QVdzRTZFOFlYSDlpUVNadEwzZmtUbmhVb2VEK2tNUE5yVmRYMS9mdVAwWS91?=
 =?utf-8?B?NDVXaHVzK2xFRVhDcE83Yk5UWUFhbWVzcGd4ZDJaYnppaUtFSjg4OTVrZGNY?=
 =?utf-8?B?cHFYUnYrNzV0MG9HLy9leUFsREN0UXJLUDBCZEdHVnhFMWQrRzVURXA5SWdm?=
 =?utf-8?B?QTkrOGxEeHhuYm5aRHl2ZjgyTXVGSGZiY0JZYk5jS3hSVDB5WjFjSmxjYVJO?=
 =?utf-8?B?SzFFNEw3bmN5TEFwZGRPUUY3d3h2dzNneUlBYldSVkkrSmIvenNnQ2l4cFpj?=
 =?utf-8?B?bWk4Y2EvM1YzK2Njc3RwZ291bnhKb2xraFQ3TC91S0VTZTJ6bWZPMXRBam5Z?=
 =?utf-8?B?aGp0Nm1DYU9pUFdYQi9ZWE5MOUFSVHgwMXc1R2V1UnJsU0oyRDNlejF6Y1VX?=
 =?utf-8?B?bjBSZ0Zob1FHWUtMUzUxRTZCbjZQODVKSDdyTlVtc21vRWdwQ1QzZTl0bWZq?=
 =?utf-8?B?bzhLRzg0b1NxOXUwZlk1aklCZHRyRDlHWkd2dEpEUFJYQ09BZnR5a3RSeEM4?=
 =?utf-8?B?cU50VWV5NGt2ZjAxTEhvd3V2VXNnL05nN1lWTHM4MFp2YWIveGVicUZMelVI?=
 =?utf-8?B?cnlRVzZYWlhJSTJiOHpwR3lva3RsZDZXRHBlZURuUWszNVBYSUVkTU9EbDlK?=
 =?utf-8?Q?N3vzxVxygM1/x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC9DSFJVSzd1MEFTdUNJWlNmOVJaK2Jpbm1NNVpWMU5TaHd0SWxzN280TEhM?=
 =?utf-8?B?Q2V6ZTVlZmRKdEhUT2UrelFva2drL201QkVlWWNIVExGb1JQdDNucjB0Z3FM?=
 =?utf-8?B?UDcvRFpKTnZEcDdRZ3VPM0hhaElJMXFyb0hITTBCdTFZYWplOXVLNkYwM2lT?=
 =?utf-8?B?USt1b244V3RvSXNEMHRsc1JiM1QyQWowcDJZQ1U3RWxjbk5wcXBFa3dadE9I?=
 =?utf-8?B?aFFqMTlEQnorSXZxYWo5M21wOGYvaTM5dUJPK0grYk80eVkyam03OWZIaFVC?=
 =?utf-8?B?OSsrU09PR21HVzdJVm0xT25KQXBDTW5ENUtUbW82a0FUbndTbzlBYXVZSWov?=
 =?utf-8?B?S3NVem1EeFlhRlg0cFpZcWs2dzQyeVdGK1VFZmpKMXRVbWEycjlrSS9ZQ25V?=
 =?utf-8?B?WDBaT3cvY0RKNStjekNYQm94MlMzRXo4S3VYOERTb0VoYllsSkpqdHlQdzlv?=
 =?utf-8?B?eDJETWt1YlRaVDNqc3RoRC9BUWxiWG5CUW81SytwRG1UaTlmZU9QS3U4dGx4?=
 =?utf-8?B?c2swU01oNEI4ODMvVm90NUhJeDZoVFpBQXRVK2VadmpIaTIwVzcvR1NUNmRr?=
 =?utf-8?B?Q3NSZFpvQWxzd2RXMDdpVUNMZGNvL0NJRlJUaWFlODRSWUhvMDZFRkNCQVA4?=
 =?utf-8?B?YWoycTBaeW81WUlZVzhZcDB0eEFINDNqRDhEN0d0bmZ1L3k2dDJsQkRmbkE0?=
 =?utf-8?B?OTJ5WFNwUjdJemR6WjdWWnN0UEREMW9LeTZFWHdESVd3YTVpUkhJMnV0Vkg5?=
 =?utf-8?B?bm5YbktFczFTbnlnK05pOFQwUWNqVHUyazFxTHlkdDZLNmNnUDdyeHdJN1Jz?=
 =?utf-8?B?Tmh0d0c0RVhFaVpUbGVLeFFNTUNRYmJidXZPY0ZheFI0Mmw3RGdhN3FNWTA0?=
 =?utf-8?B?bm92MjhzNlpkMFJzUFJlTGp5aFpva0wrMk5XQ0w4Qnk4LzcwRUljbjhneXVL?=
 =?utf-8?B?eWpkdWhyQ1VCY3lOSnRxc2RUb0JGSkdzelpVMXh3WGdiR3U4ZGVjbnJxeVV0?=
 =?utf-8?B?Yjdzcm5EM0FIN3NIWjFCdFpyT2gwL1B5S1VJWExMellFUzRtdGJyK0xwSHBy?=
 =?utf-8?B?d0dPVGVuSmxPdWJjYTJ4N0JRV3NHNXhTb0NZcDFFRWZrUGFEVjBWd2Zldkpy?=
 =?utf-8?B?a0QwcmVxVWpLOUlJRmJXaCtvaGhJWmRxSGdFelBUQzE5MFV5d3N4YVNtRis3?=
 =?utf-8?B?MTY4YklkSzZWcUw1R2MxZTVERXJuWXZ6d1VCdTVXTEVvYml3VnN3b3pRWHRu?=
 =?utf-8?B?Q05aUVd4NmpUVDROVkJjT05UZnVVT1czcHpaQ0V0T0tPYUVFRkhZMzE4TTdi?=
 =?utf-8?B?TWo1ZzkyMExkVGhFTWdZdkkveDl2YnBDSzJMMFNiUDVXZVVnSzBXMXk2VWpq?=
 =?utf-8?B?MUd4cVlpK0FnTXZQLzBFTVkvL1krT1BoQ0xCZUVtcEROVDg2eGFXK0NCaXdL?=
 =?utf-8?B?d0JBSzU3NlZ4UmVITmdodHJWeEFQRHdZZU5ybytGbEt4dnVlemRhUkJVTlRY?=
 =?utf-8?B?Q1JaTG94UGpPVXkzRHd4TWZTS25sQ2hOWklQNUVlTkFMaDJqK3FFOWRMR0x3?=
 =?utf-8?B?SWZBaVVaZ1d5akdFMFFISmJtUEJFbmJrU2Jwa0tiWlpsa1BBQmRvM0NkazJl?=
 =?utf-8?B?NXV1NGEvd2ZwaXFtdnJhZ1poQlBseEQ5N0JxSG1XWit2VmdrTHA0QmdMVVBu?=
 =?utf-8?B?Sm5OSXc4aTNJK2RnMk1UMTIxZGdRR2pjWEhRMjlwa2xTdlhrS0pBQmIzU0Nn?=
 =?utf-8?B?eThiY3NzaDNTVUNrUWwvOW1xYjdsa056aU5oenhDMHdkS0dHQ3V6VDQ5elhH?=
 =?utf-8?B?SkxHWGZZR3h3dzZ2WVgzQ2RSQWdFU1RHMGNST0lLT1JkVm1Fb3BWeDlGK2tE?=
 =?utf-8?B?SmVBNG80UnZkTUFnTGVDcFlhdzNSWUQzaElyTjFWUllsNkVWYUN1cTN1eFBn?=
 =?utf-8?B?U2ZDNGlGdmdkR0VyZS9lTjU3NWE1MUt3ajNHckNRcVVzMTFyZkhmMzU0V2gx?=
 =?utf-8?B?ZCt1ZGZVZ2J6Q052Zm5JUVA3Wm9qUThYaURNRnZvZkx4dHZHSVB5Ny90azZn?=
 =?utf-8?B?dFRVZlp0TjNSNWFXMithN0t3aEZEeWZHT1l5cGVaUjd2Q2w0a3FIMjVyaENr?=
 =?utf-8?B?SFF0RVorM1lybHcyaUNUOHpodWpaK2NvSUtmOXdTU0pZbGFQYjVIeDhxU3lQ?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P6ogECf7sIZ2WtC7DFnxz/2Bu/3ETUOIj0CmwbXydvRRP73sR9SMcxXLoi0KJf1NPc3jer0PArGi2sJWBrC7f91N7ksw6DxGKSdzPnxGDMZ8VQm1zS8NLyFyYX+SgAOEGQBiYqWUO/lofLeFri7TosGvaBe7n4XarekOY06aZ1UYI5Zv09WiuNbT4bXs3aFq5LOfUYbkFf1+aqO4sC2eo1horf5W7qT3wo8qynewuSI7hj/tGT2QaB9iGZOTNGdwPP0dxMVkEfAedNoDlXbEJIRGxlMq2Y47nm6mudKeQRCCeyCSpp/3J0cMMKTiktalLl7wz50gX1cX4qgFVsW77t5VJvGDk3NMKaUxZg2fGmNIR7NuG6rMtnlRNlZDbC3ju1ARH9Gn0DUaEejSDLviSVblsLkqvpcDAz2KHKCCaKIJLH/vAB/4s4lFMx8ykp7EzPfOMuLPMefW+8rArZDlvF6b9wp9hLrEHPjoUTFDe7e8wKz9Nekvuvw3WIwFZKx8GID3Abh5lXsaGAh8nHXV+iPZf1C5wYoeKg0MZJdtlNiQj78ly/QrO1GRwASyr0XtjmPlxpCK/EMs2TseV96qbs3Io/ZNbm8xd3k2bynBTRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1392f9-18ec-4673-4139-08dd9f78b58d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 12:51:35.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9m51mKgzdFz8le4TMLG960AaLIM4Y8TcmYy9cEEUfFayKhMfPAdu/YblsYVx01484Lc7CnyuRZYazbiD1pYccg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDExMiBTYWx0ZWRfXyhSSaP3zxQA4 v3/1jKtVcpV7GzpQNBL2i48R2TOULXTj/jWUYnI944OXeUoBDnuF8PegwooQsNajfXkA667JWLN 5q+V2MAtetDswRRaB9uveSut3Kdj86UjmCUxx8YY1ao9xMEr4kjs9u0V09gF/x7M3JgMnLw7ak7
 yxv6SRrawnLE1N1GpkMPCg8sFwHdhxG1JMw/DUghGbm+lrFz8NUi0dceF1kuiTQ5mqXJKsw6Ifk h8dCnnySUnSMr8f0E4f16xUrsJYNlvvL/25yWITUPm+xcYTcD42vo55CjKeHchnFYgW9fZ8n3fs qIOOW5xH+k0v5B4nJaLQGZX5QiIf//6La5sEBsaZl9+sM/ZP+YuFtP2ENwxy+ZYUCsrMNccvrF2
 41MB/mKp8W3ULtT4PsFOSVKjDqpJFmGTI4lei3LjrH96jzdgOS9nUNHaUjjVKeZ9b2OzQVoN
X-Proofpoint-GUID: tIJruN4-y2hCQ9ikV76881nTvvxPPJue
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=6839a9da b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=f1hami8VAAAA:8 a=VwQbUJbxAAAA:8 a=jcb1ZoXaaXgvJ1QxxgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O4tMhvHXPDgA:10 a=FMFxGtP9trmfb28vA-lX:22
X-Proofpoint-ORIG-GUID: tIJruN4-y2hCQ9ikV76881nTvvxPPJue

On 20/04/2025 07:42, Paul Menzel wrote:
> There is no need to explicitly set `LIB_INSTALL_DIR`, as CMake’s module
> GNUInstallDirs sets it itself from `CMAKE_INSTALL_LIBDIR`, and takes
> care of everything, so the line below is enough.
> 
>     cmake -DLIBBPF_EMBEDDED=OFF -DCMAKE_INSTALL_LIBDIR=lib ..
> 
> Note, it’s common to set it to a relative path, but absolute paths are
> allowed too.
> 
>     cmake -DLIBBPF_EMBEDDED=OFF -DCMAKE_INSTALL_LIBDIR=/opt/usr/lib64 ..
> 
> From the [CMake documentation][1]:
> 
>> CMAKE_INSTALL_<dir>
>>
>> Destination for files of a given type. This value may be passed to the
>> DESTINATION options of install() commands for the corresponding file type.
>> It should be a path relative to the installation prefix so that it can be
>> converted to an absolute path in a relocatable way.
>>
>> While absolute paths are allowed, they are not recommended as they do not
>> work with the cmake --install command's --prefix option, or with the cpack
>> installer generators. In particular, there is no need to make paths
>> absolute by prepending CMAKE_INSTALL_PREFIX; this prefix is used by
>> default if the DESTINATION is a relative path.
> 
> So, remove the custom handling from `CMakeLists.txt`. Also, update
> `README` and mention the option.
> 
> [1]: https://cmake.org/cmake/help/v3.31/module/GNUInstallDirs.html
> 
> Link: https://lore.kernel.org/all/9fb4f7ba-0de1-4f75-9bd2-66212ca8cd86@molgen.mpg.de/
> Fixes: a2abd9482162 ("CMakeList.txt: Respect CMAKE_INSTALL_LIBDIR")
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Thank you!

> ---
>  CMakeLists.txt | 5 -----
>  README         | 4 ++++
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index eb87300..844ab61 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -23,7 +23,6 @@ endif()
>  
>  # Use the standard library installation directory
>  include(GNUInstallDirs)
> -set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
>  
>  # where to look first for cmake modules,
>  # before ${CMAKE_ROOT}/Modules/ is checked
> @@ -75,10 +74,6 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
>  	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
>  endif()
>  
> -if (NOT DEFINED LIB_INSTALL_DIR)
> -    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
> -endif()
> -
>  # libbpf uses reallocarray, which is not available in all versions of glibc
>  # libbpf's include/tools/libc_compat.h provides implementation, but needs
>  # COMPACT_NEED_REALLOCARRAY to be set
> diff --git a/README b/README
> index a938266..fb92d68 100644
> --- a/README
> +++ b/README
> @@ -18,6 +18,10 @@ cmake Options:
>      Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
>      when invoking cmake to specify another install location.
>  
> +  -DCMAKE_INSTALL_LIBDIR
> +    Default is to install to lib or lib64, use -DCMAKE_INSTALL_LIBDIR=
> +    when invoking cmake to specify another install location.
> +
>  You may need to update the libbpf git submodule:
>  
>  git submodule update --init --recursive

