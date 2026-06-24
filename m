Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00815257452;
	Wed, 24 Jun 2026 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324018; cv=fail; b=XXSVmG/OHeKxsHApOwoAiSDZ+CRuRbjeXxr3pWLfrHmdya8DESvPNtv5Xe3aWVh8vARY/rgLWHFjM5/kTH/2VbfYLOZb1LaVa1PxTUvfszR6NRqYmJUbx47VxjUqnYSZQmG9NtRnGO29gEvKxi+wb+6cU7dbGo8jB1bN6Ssjs18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324018; c=relaxed/simple;
	bh=ghD3MTT3kTfaoCs7gpur4ecQFDMNMPWsJwtxyco/dVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G5jauV2hNW+pDk2Psnn4e/5ARLnrX1vnrIy5x4vWO15y7vQUGzj/czwGawXZllFh+AuDbYgi2/QyPbNh7GTv9oIqYcGHRl5y/Vmy59xwj8t8RdYAsq9RylXix18zWZqlFZBzE6vmsPjMvnxYVaupaLnDXhHWSl8PbJGmWtzwEmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oCJbp3r3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cKqqj828; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oCJbp3r3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cKqqj828"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEaDd52556520;
	Wed, 24 Jun 2026 18:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=H8RZ/aZQ5q03oKXGGrMIMOPhmB+QeNiBDULKmy+Xscc=; b=
	oCJbp3r3694bYDq62OavfdLcYxUbwSQT010EAfD0q/On6CFetnE5qzRveO6/txGw
	9tTPJGupPqBpwA00oBFPFMXNzOqFEIOh21EwJVgEAFDi9FDZTLwgRGPBhp78lSpq
	D8h97F2NrERFzmZt0NRlye3qGDlnnfMxR5GB0Gf5yu8ARUPUXeN8LELQxCiV8GvD
	htf4bunwGXkHm0mJ4ZlC+KCVD9rZg/a0f8ENrOybWNPlEgmUbwXlODhQqoIUVeX7
	FFbfy3EZq2fusWB4h83GXuxyGsxg4pu4VJlaxYDAIS4XSHgzP2S5vi1qNl+aTm7d
	vT06htcDs9vswt6NZFrJKg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewke5nyfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 18:00:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65OHwsfk014820;
	Wed, 24 Jun 2026 18:00:05 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhas05bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 18:00:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQTYGIYQzbpZEn0bGAZf1HB7WevkfauQlMJfhmPHtmNCE2lryIScy2V6OYP9Z2ws9xkxJKB9UhkSvq/opFFeaUipXtzMEP+3IPbnBYywOburU59AjQ+1nRlJwovAHajSIiBoCq59sJtthL1hslnI/7nw1xAA0b39oJ24OtvUncpATx82VJ5arYniZ5AHr1sJ12RUBcUsW+HD5re6SpbzuC2A7OCPQ6x7SDpiFRMiN1qLjY4GJA32GRucrljczFDr5O6qygwShfEwiqXIQMLjbnhFymmzscZ1UGa3x8p+wxqpFLbVJ1u24Qhla3oTjwKniP2y3Dn3HxEUk6dDNRHviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8RZ/aZQ5q03oKXGGrMIMOPhmB+QeNiBDULKmy+Xscc=;
 b=wiao8GSFhxy9NYhSis0lTlxSSpy+rfmvQurZ4+t+7etAwTSkQUiLtDqUtKGbxVS+yYNTuvLacB/UrIcMubifH+2R9PX6OLx0qf62RVsKaI7DgbGN6SMpJBoQLtT6t2HLubGMj79xnW940jc370hYzfBZLkYRr+T6+zMLff+Q4usbtrxwQeadciwmdKecCtbm1kD/7KVTtSrupznXodtyqPk3ihXJJY3VhqglBJvep/doOWcFlXwz1ZJNNdIWlBI6Ax2mv5N2nVnMGqzfUMOHus+hzUhcobiCWOprRYg02J2VfVgfpDgc2zNuD5RZGz6G1JzPkARAkjXdLa9Qxmrzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8RZ/aZQ5q03oKXGGrMIMOPhmB+QeNiBDULKmy+Xscc=;
 b=cKqqj828hsTaoffV5ZQvQk3ruKI6nr1/0VIwJjrG9ABwlqiCJwFOskAM1AoNqu/1YbwXa2PBohlJ9SnLnTV2xWzvZ1W7qbiU8n+d8jvjKrUrQImZJNZqdHaTBRaPB9/B/1Qu9HVa7jKpXsIGWe07WtiRqQXdR8MWwNvOWoW/L0M=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:00:01 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0159.014; Wed, 24 Jun 2026
 18:00:01 +0000
Message-ID: <9f594fec-7044-44a8-8d92-10aaffbd5bbe@oracle.com>
Date: Wed, 24 Jun 2026 18:59:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v9 0/6] pahole: Encode true signatures in kernel
 BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260624052553.3139112-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260624052553.3139112-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::24) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a7bd03-49a6-4010-0384-08ded21a6997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MChgVB/+sFJ+gW1cq/usyqoeNuLtcKRag1TuQVSPvCvKutDYuOTTtu/vk2NXI7tXtmvO66CdWh3SCU7nCHnSmL0/6pdwBQ4jjZypJU/J87fMI1YwB0N/jUfe4XEVHOBAVjSF08BHxAwRgAkLvQMlARYNyl0p3Lwztm/k/hz/uN8b/BGhd4vlKXI+k1vizfJ+OxMthGZZ4iV9KNsrRsfLiEpuAI5vgPCJFW+Upw3+0rsGrFj4arBvwSGFtB3jQmDVRGf7I6CAbQwEp3v+eYyse2Bk0GqVjvp07RAiA1juVad6bUoyPILdpM/O+tVvUnWwmkNKc933fYnXFGmjsez5RI8UPQCYdScZzLuVy0BXB2KSQY8OG/lj3aBEjTzyd9L/x2x3DEd1U8m5eEFFLThn6/Qr/cT2y43B+N+mPWB7UKMNAIIKNOIM8KayHXYca9YWopAbQpBwsXGbvXQKNQRn17w1i+KpjyOcYQQcqIyuXasC4kRrdLPP9cnlGhV3vcCBUckGfdjOm1D62UGP3WpfpKG8D/QTFJXJqgfaGA0qFtUn8tRnm4qU/fQlhAueKZiB3DDZiJyaECQ1gRMWWWCZbMULwYn08w/xMNunWwm3WJJIyY/ElRp8bWUVjAznkNKDIigfmVtSUui1dn8xS02qd6QNbvuXgiOJlSEUWBVs+X8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGFIOVBLMEV4cDh5c05jOVFDcXlTM2lnYjJ5Y21JSjVHclRDbnFWTVpXYXBl?=
 =?utf-8?B?SVl3ZkVCR0pnWnRyb3FqMnNKblpmeGt0cE8zQ0lsNmxZczNXYWttanU1YUlh?=
 =?utf-8?B?akExVWdjd0M2ZGZ0UHhEcytOUzlVMzArcjc4NzdCTEZHc1FUaVptK1BXbzF5?=
 =?utf-8?B?cGQvNlZuWEo3WnAranlCRU5vS28xdHI0TEFaMktLNDRVSVpqT1B4TUk2bW5z?=
 =?utf-8?B?V0VjWnR2anVlbDhpTlZPNjNGUnE2TUZibURZSUdHT1J4VU9ibVhMZGJvaHhH?=
 =?utf-8?B?S0RwYkhpUTdVNk1aYkttalRTT29Jcml5ZEZlN3dmbFhSOEJSb2h3N0dscWt2?=
 =?utf-8?B?UEZvYlZXLzVKWUlvS1FKU3R0TDU5YTA4cVlla0MyVlUwR0V4MkhWMXVpSkFi?=
 =?utf-8?B?QXM0TjcxMThEVGUvbXE2a1BEWm9ic05CczZPSHo1dE5yUnNBVHVQSkRjOFhp?=
 =?utf-8?B?bWdUTVg0WHA5ajUyV2ZRTGRkOWFGQVJ3TFdwTi8yUTFJcVg5Y2VhOWZKbHRu?=
 =?utf-8?B?MXJZdEI5SVZBY2UzOVc5MGYvUDdNdHFiSmpGT3VyL2twUHRwMzRSSEltZlNp?=
 =?utf-8?B?Tjg2K1hvM3QzYzNFNW5DOXJWUHB1TEFNQWE3RGtGWWdheUl0R3Y1VVowUjlK?=
 =?utf-8?B?ZkMzSEErS2RTcVFrR0t0RW9ISER3NFNmWkUyUzZQMFpTck5KTGdPTTVtNVc2?=
 =?utf-8?B?OGhCUFlVbldJNFNvQ1o1RnhwZ3RZOFNEa0RWdExJVVFueWdNRUNGRUtrUi95?=
 =?utf-8?B?NHhVeTBPQ0JxTUJIUm51MmlXMkVacGI5QUZOVHBNWExreHVKdko2ams0YnpP?=
 =?utf-8?B?c1J2T2g1Z1BKTDJnTXU3QTdyNnpHaGVlWDNNc09PVDBmOWhSUTkvd0FQUTF6?=
 =?utf-8?B?Y3NSdVFFSGN6dHJxT0xZdmc5MGZ6OFhxOFIxZ3VlcWVNQmRNYzg3RXN1YXFs?=
 =?utf-8?B?TmtadHNrNUNJNTBWSU12ZzJlZU5PZCtIOGp3c0Y1MHdQYU9FM3l1WmpHQ3U2?=
 =?utf-8?B?bUkveUtGV1VXMXZEQjFzdEhFeGdnYTJLYWIrMHhGaVE5WVJwckpXR1RrMTJF?=
 =?utf-8?B?alpiMnplalUwUnZJM01nN2k5M0t5Q3RHMW9VUUhBYjMvRnlSaTUwU3YvdlRH?=
 =?utf-8?B?NkdVeWlQRFVJZXM3ZXBNRkJYbzdPc01YZjRIZldYU1ROUHByclZrRVcrcHN6?=
 =?utf-8?B?YXIzcUhvMExZUmpyU3dreHYyaXZxL1hTWllkd1RiU3pTc3huYUxsY2dUUzAy?=
 =?utf-8?B?S0FLUU95WXNlOFM1OWpJWW9iNWs5RmJWQ0tpR1RYczE2cnhGVnhvYndTKzNn?=
 =?utf-8?B?Qmo4ZlBnL1hsanB0QVc0Y1FLMWgyTlhkSklhenJXc3k1R1NaNEEwOUwwWmli?=
 =?utf-8?B?cjMrdldwbktYaFRaVXI2TkMreFBLT3JvSTUzNU1ESWNaV1JaUjgxR1k2Z0tz?=
 =?utf-8?B?aFFBa1Y4K2V0YzNHR01WaGdZZnVCaWpEOFl6MmdZdHJHb0paZmlxK3ZvT0w2?=
 =?utf-8?B?Zkh6bUY0Ym5zRGpFM1cvVlcxRGlPbDIwSWRtd1pWL0ZmZTY1RjUyWElaS2sr?=
 =?utf-8?B?cFh6eFhhbU5KdlFXOFNBSzhEZmo1Rm1ZU1pnbGVDRkhqRVhzeFg1NURaYzVJ?=
 =?utf-8?B?aFdVcnV5RkVGOXhLVGtDTUMxd2V4dkNMSGhWRUdlclpab2lXYWxOL2wxNjlK?=
 =?utf-8?B?VXhpN3QxQkJneDNQRHhNRCsrZzVXTTVFek9lQ3MvaGRxWkZ0NlBsZlVrLzM4?=
 =?utf-8?B?MXliZzUzVlEycDVZVWVBNnFMbjBjQzBTWk9QdXRoMW1CNU9ueGVtdjFIaGhn?=
 =?utf-8?B?Yk90Z2szUHE3WEx3c3plaTJMVW52ZmpwUFZOWngzTk9Rem1ZWTZNVmo1Um1y?=
 =?utf-8?B?akRDaUxCcWxXLzMwOTJ5dmw4OGI4MVZ0dHF1NVBXcnBoMGFid1pTdTQxczcx?=
 =?utf-8?B?T29kejNKWDA0cjYwUDdJZm5MWmM4TnYrdlNqQTBJMWdVYi9BYVR0eFlkbFdC?=
 =?utf-8?B?eHBTaEMxeDdpWlpFZmY4MVVFQ0FkSkJzTzB3TDZPcjJoazFGUTVxSDhNVGdq?=
 =?utf-8?B?azlJUDZpUlA1emtZd0JWYlZEczUyalVGZnFaOXBXQWZRck9Ed1o4eVE0OVFt?=
 =?utf-8?B?MjVyamRlTVRCdjVEN0kySWgrMGtJbDdqZ09ZWFhvdFM5Ylg5cTFXV0ttd1dN?=
 =?utf-8?B?K2pkVGw4OWRRcnVab09kNTc1TlB4d2gzRE40b1FPOHdSbmJiaDFFdDd0YW5r?=
 =?utf-8?B?eFRoenNWRDVNSlNqVWRSbWxXV3dVTitJN1FuODFZK0dOLzR4VVd1dForaFli?=
 =?utf-8?B?RVQ0OEVDd0dhaGU2elNaVFdBMDV0ck5LRm0xeWlyOFRRMnRDclBKQT09?=
X-Exchange-RoutingPolicyChecked:
	fuA4VoM4kat4c+l2HmPnj1Idn40FimlmCZZ2yI4R2ZY2Hz0fBF7ZY5hnY94X63SYAXPgI6gExfezC6Np2/adsbBkiUlJW3IYz3idUT11c2YyAXFfnRl6tRrRq0pfTPC+UizPI4Ye/1SElExNhUuRQVGAQ9siBKEeOvidpQod7aeKFdUtuI+nXRzTc5KZjtiB5sqPQIllnWikqiH+CDiSl+l3SZkh3yzdEiN9KXobVOkRwxOiiSWamrrPIPaHmSwcwVtQim5ICohNTDiyGo8pOiP9OQ8a1yDQZdSDCMElsBXBGUstfealFuNQRkUV1mMcfiOM+J/zgUCMPt0Y356sCA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RjR/JZLCMAb+nVEQ4aTSoJ+DqcJzFOq+/KuIUresthh6u3YPccNcim8hst8P2E53v5stX2uLw8nrq2P7fttPyzRflzEVJTE+/5nLlOrTMSJ9iMwDCJIs1VXae4Jscg2v2k9jUPc/7yJxspU/qWAr90lt+GCw8kvefMYVGsqo0UpcG3js9QGCgScoeerZZWeF1/7Gt9Gb40NdkMVbS0JgAAfLhr1tcxtlbHZlCRaUIsah/d1g4X02bF7Sd/huSlv6u9eNce16Akfbz+w31b8UV9cnx2w4gDXrs3dWCDlEttlRHcqYQMLcdAnfUQTNNo8WD1HZVOs7a67h6Fe8zR4VKvO87Fhzg7YfJoEipzorKxP6g+Aqw66aLbkBZP0OoR0Nh5i6VDAC93IS7Lbn9b5Zc0eZdz41u3W4Z+CNmm/qCH/xJPMugqDENjgNoum8nsn9xy8uPXvFwfCLlZzbv/NSf409cayZ6Q/VS/S5DGF04AmFPwiE+5gGB+fp4w78SnwccTREutjTV2fKfRXiMBCXUoyvFLw77rkEKhMe6Mk2uoGoMdlOKkPGXUgDcQoaAP8mIslAQobra7XnhbQX+LZebm2mheOlmkwaL7K1rW3BnE8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a7bd03-49a6-4010-0384-08ded21a6997
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:00:01.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcKucT/5QsOhaiDJc/Oazgv7yCleSN9zzPSMVKY3xrNEEqZ2+iQGp18XbJKrlJmjKuGh0iqtsOnn5y9ACRQ1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606240150
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE1MCBTYWx0ZWRfX4mPsLeGpsy0h
 zNgrriLPLidYs5HA+Wzcw1j3UKCsilmtTIUFxs5JJRc7AWOWEPVBa9XlD2JfTT5FXRcQ4xG3dNw
 XLG1TQGmJS9BuTJTb72Pg44iyjsAe5kkRazyq2pnhb5y8JrxgE3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE1MCBTYWx0ZWRfX9+JPTwKdxhi0
 XwRbKPa9HX+iXjuqdWOaWmr1cQXn17pqsfL0wvui/GXJX694FPHY4gA9KFX231+f72gP+NhGNI+
 Pago5PQgqREfZDH8z/8YYwbeOMhBJx6F2uheo9vT922fj/RU/K7aO9Os4775zj/AZmU69VZusNn
 H8LQDZGmv2cYcf8ka15AAfMl1wPoc/LOyhHJPX0tlCb9xrAbHsVS2IelMndOyh0kEaqJyYHOxFu
 8kggTi5lb5EO+0pIr20bahgUOIcQ5wPUgPMgXFvZcYCyTh0f6PGpWejtClu5T4qbjM8C2xmbrf7
 StTDBA/+40jLV/9Lx387Wm91/lm4F3A4yvJSQEhtM+Blgh0jigwCpDtkvoE2gO0U7J2S1Oh4jKV
 mLIMrRW6X2KlllU6kC9tCcAMTM43Yog5I1bbINSteSkXVCqnomw=
X-Authority-Analysis: v=2.4 cv=U/+iy+ru c=1 sm=1 tr=0 ts=6a3c1b26 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=7BJqr6Hxt4E3RnydPUgA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-GUID: JcBUXSydK8qavdLzLT3J4pXeLZBwszX8
X-Proofpoint-ORIG-GUID: JcBUXSydK8qavdLzLT3J4pXeLZBwszX8

On 24/06/2026 06:25, Yonghong Song wrote:
> Current vmlinux BTF encoding is based on the source level signatures.
> But the compiler may do some optimization and changed the signature.
> If the user tried with source level signature, their initial implementation
> may have wrong results and then the user need to check what is the
> problem and work around it, e.g. through kprobe since kprobe does not
> need vmlinux BTF.
> 
> Majority of changed signatures are due to dead argument elimination.
> The following is a more complex one. The original source signature:
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   typedef sockptr_t bpfptr_t;
>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> After compiler optimization, the signature becomes:
>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
> This makes it easier for developers to understand what changed.
> 
> The new signature needs to properly follow ABI specification based on
> locations. Otherwise, that signature should be discarded. For example,
> 
>     0x0242f1f7:   DW_TAG_subprogram
>                     DW_AT_name      ("memblock_find_in_range")
>                     DW_AT_calling_convention        (DW_CC_nocall)
>                     DW_AT_type      (0x0242decc "phys_addr_t")
>                     ...
>     0x0242f22e:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>                       DW_AT_name    ("start")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f239:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>                       DW_AT_name    ("end")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f245:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>                       DW_AT_name    ("size")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f250:     DW_TAG_formal_parameter
>                       DW_AT_const_value     (4096)
>                       DW_AT_name    ("align")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
> 
> The third argument should correspond to RDX for x86_64. But the location suggests that
> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
> the parameter value is stored in RDX or not. So we have to discard this funciton in
> vmlinux BTF to avoid incorrect true signatures.
> 
> For llvm, any function having
>   DW_AT_calling_convention        (DW_CC_nocall)
> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
> But for non DW_CC_nocall functions, it is possible that true signature still not
> available due to locations. So every functions will be checked.
> 
> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
> and 875 kernel functions having signature changed. A series of patches are intended
> to ensure true signatures are properly represented. Eventually, only 20 functions
> cannot have true signatures due to locations.
> 
> For arm64, there are 863 kernel functions having signature changed, and
> 108 functions cannot have true signatures due to locations. I checked those
> functions and look like llvm arm64 backend more relaxed to compute parameter
> values.
> 
> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>   -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>   +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
> 
> See individual patches for details.
>

Seeing a new CI failure [1] with this series in the btf_functions test for clang (x86_64/aarch64):

1: btf_functions.sh
Validation of BTF encoding of functions.
   This may take some time.
libbpf: STRUCT 'elf_note_info' size=248 vlen=8 cand_id[1195975] canon_id[1193376] shallow-equal but not equiv for field#0 'thread': 0
   ERROR: mismatch : BTF 'void btf_verifier_log_vsi(struct btf_verifier_env *, const struct btf_type *, const struct btf_var_secinfo *, const char *, ...);' not found; DWARF ''
Test ./btf_functions.sh failed
Test data is in /tmp/btf_functions.sh.v9s3w4
 
The test does not run with true signature enabled, and I think the problem here
is that previously this function would have been skipped. So it may be true signature
leaking into non-true signature behaviour but I'm not 100%

[1] https://github.com/alan-maguire/dwarves/actions/runs/28104464362/job/83214808300#step:7:12

> Changelog:
>   v8 -> v9:
>     - v8: https://lore.kernel.org/bpf/20260623222850.3290612-1-yonghong.song@linux.dev/
>     - v8 made a mistake where all functions go through main loop in
>       function__analyze_parameter_locations(). This is not correct as it includes functions
>       whose signature is not changed. See function
>       function__match_clang_parameter_locations().
>     - Add a change in btf_encoder to avoid comparing inlined and out-of-line function prototypes.
>       This allows some functions to be in btf.
>     - Add one more test, clang_parm_optimized_stack_2, where a global function, with
>       many unused parameters, gets properly handling in location checking.
>   v7 -> v8:
>     - v7: https://lore.kernel.org/bpf/20260623040704.2732530-1-yonghong.song@linux.dev/
>     - Both Check and Analyze phases go through all functions.
>     - Require true_signature in btf_encoder to have name like <paramName>__<field>.
>     - Remove signature_changed (from nocall). It is possible that function signatures
>       are not changed but the location reigsters do not match.
>   v6 -> v7:
>     - v6: https://lore.kernel.org/bpf/20260618011358.632394-1-yonghong.song@linux.dev/
>     - Ensure that 'collect' and 'analyze' have the same location checking.
>     - In 'analyze' stage, undo true_sig_member_name if the next expected register
>       matches the previous source type although the previous parameter may
>       only use half of the value.
>   v5 -> v6:
>     - v5: https://lore.kernel.org/bpf/20260523165712.1225231-1-yonghong.song@linux.dev/
>     - The previous change relies on parameter__new() to collect and analyze each
>       parameter to decide true signatures. The new one separates collecting and
>       analyzing phase from Alan. This two-phase makes logic easy to understand.
>     - In btf_encoder.c, remove usage of skip_idx to simplify the code.
>   v4 -> v5:
>     - v4: https://lore.kernel.org/bpf/20260326013144.2901265-1-yonghong.song@linux.dev/
>     - Check info.signature_changed only under clang.
>     - Fix an uninitialized varable issue (var reg_dix) for gcc.
>   v3 -> v4:
>     - v3: https://lore.kernel.org/bpf/20260320190917.1970524-1-yonghong.song@linux.dev/
>     - Add simple prescan of parameter registers in order to get true signatures
>       for those functions where optimization could happen but compiler didn't do it.
>     - Do not create a new name (e.g. "uattr__is_kernel") with malloc at parameter_reg()
>       stage. Instead remember both "uattr" and "is_kernel" and later generate the
>       name "uattr_is_kernel" in btf encoder.
>     - Add comments to explain how to handle parameters which may take two registers.
>     - Fix some test failures on aarch64.
>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20260309153215.1917033-1-yonghong.song@linux.dev/
>     - Change tests by using newly added test_lib.sh.
>     - Simplify to get bool variable producer_clang.
>     - Try to avoid producer_clang appearance in dwarf_loader.c in order to avoid
>       clear separation between clang and gcc.
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20260305225455.1151066-1-yonghong.song@linux.dev/
>     - Added producer_clang guarding in btf_encoder. Otherwise, gcc kernel build
>       will crash pahole.
>     - Fix an early return in parameter__reg() which didn't do pthread_mutex_unlock()
>       which caused the deadlock for arm64.
>     - Add a few more places to guard with producer_clang and conf->true_signature
>       to maintain the previous behavior if not clang or conf->true_signature is false.
> 
> Yonghong Song (6):
>   dwarf_loader: Detect aggregate ABI register usage and signature
>     changes
>   dwarf_loader: Collect per-parameter information
>   dwarf_loader: Analyze per-parameter information for true signatures
>   btf_encoder: Emit true function signatures
>   btf_encoder: Avoid comparing inlined and out-of-line function
>     prototypes
>   tests: Add BTF true_signature encoding tests
> 
>  btf_encoder.c                         |  53 ++-
>  dwarf_loader.c                        | 603 +++++++++++++++++++++++---
>  dwarves.h                             |  14 +
>  tests/clang_parm_aggregate_1.sh       |  85 ++++
>  tests/clang_parm_aggregate_2.sh       |  88 ++++
>  tests/clang_parm_memory.sh            |  77 ++++
>  tests/clang_parm_optimized.sh         |  63 +++
>  tests/clang_parm_optimized_stack_1.sh |  63 +++
>  tests/clang_parm_optimized_stack_2.sh |  63 +++
>  9 files changed, 1042 insertions(+), 67 deletions(-)
>  create mode 100755 tests/clang_parm_aggregate_1.sh
>  create mode 100755 tests/clang_parm_aggregate_2.sh
>  create mode 100755 tests/clang_parm_memory.sh
>  create mode 100755 tests/clang_parm_optimized.sh
>  create mode 100755 tests/clang_parm_optimized_stack_1.sh
>  create mode 100755 tests/clang_parm_optimized_stack_2.sh
> 

