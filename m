Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCA1A9B4D
	for <dwarves@vger.kernel.org>; Wed, 14 May 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236157; cv=fail; b=Vsk0IRGBPLq5JMT/Ld65EL6+K8dUoI5FF1/4qkUasBiDK8UYVNE3wiTGuf/y4uz4Fr1fDKUO4sVFKhu836Vg07giwKkITps2m+VlZkDS4nBFwF4sF21PKyJpqYJokqxy/HgUhlHZV2heGuA/r/BVLgaOxtH1jpcdLZXRi0Sk4HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236157; c=relaxed/simple;
	bh=Q/+1J9eE1NoMnCLTQSInFSkKVhfoCBOO5AwrGtCjKeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cd3KjFF3wJkkWGhDnBBAm1irIe6T8ahDdcufuhRXNuqzULm+5bjDXtjqmLawUmxUHAqsA/mc+WWHPwtP6PSlUVG+RiIBCk4vJfe7OOeXIZlsoanKkUt7OsgqGF4cfcuwH4w/Psbo69MzMzbr9bdNGHoAjI8kxXhrqHl8QhKFVe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DvsFtdf2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uua5gVP7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DvsFtdf2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uua5gVP7"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDhsR7020591;
	Wed, 14 May 2025 15:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SoyXVTJE+Calf+puYmCtrqSjK/QkzedCeMStBFt2kGQ=; b=
	DvsFtdf2FAn5diSkUmHvHCJWdN6K4UqWtlJS0TEgYGWOPATY0dw1V5/cu2RCtj2H
	rHBMiN3WC20twCpkvgb1T4yySvp07Y4Ut6yBJp6ykf3P/jXcapGqYQMfmEAyCNLj
	PmAtzJY/g0Mbck2aPe2z3w5cI0CQ3LPafAbiN7hso1m2dp1USXn/tpJZJ49tW1Vc
	pThQ/u9uyJ4KjHvZd/09+exxg4hXnQifLJD9eH2E/mPRNoNsckhPIu1/8zAq8Apv
	b/1413g8+RzPGgTS69+TEYea8amVBFqfjZCjNnZIrMp++1AFCcni89fdNn2XqXrS
	6o1YNHIp/u2IgHvnqDRZsA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcct5v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 15:22:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54EFK8HL004975;
	Wed, 14 May 2025 15:22:30 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mshjbd94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 15:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mq8eFhFkToWYva6Am9gl1UX920UPdWGl1I8TyTmAPs+qGdCexMZF4zsClR9js8O7F7EGlK+dG9J6HPXil7myiWBtxTA6JyjI3qJfTWPJk/x0ei01W5g6kl4qpmWFW/nNK27V7qo5zD82Dk2SuPuJWHJ3mdrAwWxRbpDJ/VHoHh9eBV3HPOkqyh+6idvR4c/u/oxoJF/U4uw/NRRIHsR6j+FkqbaI4xt6lXVPbTwqyPopQbo52SCb2sWSMCrHBxjRd6kNAlse+kH8fCWGQ9QSWh7dya0fFDtDriSh1SGKEfJuK1XJmz8lZyxUz6bmco3znTSLly6t+8VgUIxc5Ph/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoyXVTJE+Calf+puYmCtrqSjK/QkzedCeMStBFt2kGQ=;
 b=RdVAii9QzrDQzdizk2ILSdET2ligrCmRfTsbjWIg3Tm2lKAo8aVwKn1e9QtyFFHLK4B7NkR+Cb+149X+RnLijePMi2V9kQfsqzFGIh1inTjssXigh2vAgze/izok7L02gORbjP9cqlbQ4KJ6/Y3fIVuP6mtp/8G/vQOZlpn6JwqIk+QWQB9m47r5JegOES4Mqixvn/4X0RO4F5CcZW00tvPlrcj2MV6Gd51tJaJXBT5TTgh8isK6x+Btm+dxRAXUK9MlURo8t0L/VAGfbkx8n263JHASEGPr53T4FQB6yxpwr70BasGLGds5mgFQWa6yyJcH9cWSkZFNzk0BGXqoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoyXVTJE+Calf+puYmCtrqSjK/QkzedCeMStBFt2kGQ=;
 b=uua5gVP7buIJ4bLObCTVPkBreO9j5QIEl/kD4V6nnz6So/8Swrk4F4F0f/GHfmpPxwCbzHM165EPrCGFPv9EDITAxEsKTwlxuI3FHDNRdZnLYybSxapkmwaczc0ADKHvdYPtrtYkBTfwr9qbsbzbTh0zyg4bLqAFivERTv8LQxg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4604.namprd10.prod.outlook.com (2603:10b6:806:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 14 May
 2025 15:22:27 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 15:22:27 +0000
Message-ID: <f5ff6332-eb86-4c08-b4c4-9e7c9b8fb882@oracle.com>
Date: Wed, 14 May 2025 16:22:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Pahole, BTF, and vector types
To: Bruce McCulloch <bruce.mcculloch@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
References: <b3948534-c567-4348-990c-28efe144906b@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <b3948534-c567-4348-990c-28efe144906b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ded0c6-d392-43f9-b9ba-08dd92fb2292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFZISXJxTFhDbXJuMmRyWlhVcThhM1lVRW5lTUNXUUZoOU1YbjExc1A4ZEFk?=
 =?utf-8?B?RWZEM2tSR0hTeFJtQUl6ZngvUHlmN2tyWmtuSXloaTZnYzNSRW9yU2x6TElF?=
 =?utf-8?B?NWhhdHM5UUFIeVNzcG5aSGpLVnhWek9TZmFMQ3BGUFl4eWxpK3pla0tVaFNC?=
 =?utf-8?B?V1BMODRCTVJZUTJHUGd0M3YxMzJ6TFFJN0VSVTRnaVlhd0JaMzE0UGtLckV3?=
 =?utf-8?B?ODl1V3M5YktkYWZ2ZHBQaENsMFBOTzJSWk5UL251TlZZM1M0K3dEQVJJUlpU?=
 =?utf-8?B?NStVTlEyTzIxTVpGUCtKaGFMOEFJM09qVjI0bEluT2ZhM25VT1hkSk9vT0tM?=
 =?utf-8?B?bXAyNzJTaFV2RnEycUh0ZDh2QURXNmQ2MXltczlkYjdmTkxCNjA0NzYxNTB2?=
 =?utf-8?B?TTQ1UmZHZHRCR1FpNVBPVEorYytTMkhReEZ4NzR6UWwxN0l2ekRuVGVzcUhE?=
 =?utf-8?B?Y0g1MisrSjREd0RNNEZRRGVIbEJ0elpwSWJIZTlreXAyWkhscXVpbHJ1WGhV?=
 =?utf-8?B?RzZmYkIydWhDNGVvZWFJUjZPY0xsUEFKQk1mSGwrRTg2Mk1YTXUrZXY4V1hC?=
 =?utf-8?B?MXduaVNwN0RFMmxrcW1xZFNxdmh1K2d3WEc1aHFIOHgyQlhOdHMvb04waHJk?=
 =?utf-8?B?TmJiNlRNY2U0dnd4STJjZDIyRVNleHFlQmlvbWVRTE52ZWlDTHhGWVB5LzBX?=
 =?utf-8?B?SG5DN2N5cWhYdVBFa0NKajJnL09kRmNoY29jOUtENjlBQ1IxdUduOXdpTW8y?=
 =?utf-8?B?bnZWV1pKSFA0dDU1eFpnd1BLcTR1UVQ5TjVTZ2oyN3BZNUIwbm5QUm5TcEt1?=
 =?utf-8?B?SGVFcFBqcE5IOWYveTVmSGZwcERvM2k4UzcySFdhNnlQdGNsOVltOEoycVho?=
 =?utf-8?B?ekxqNjJUSXUyUnlIYmhHdXBFZDQrUHorMEJMSFFhSldWVXVTK2dEQ05GREpw?=
 =?utf-8?B?Rm05WWEwenNQQ2YrSHZzUUp4S0ErOTNFdTJweDJUQmtZZUVnSW1jeWUya1lB?=
 =?utf-8?B?VUwzK0pWMTR5M0hRYVFTOWUwS3ZoUExCMmhCN0hyMVJsbHR6bjF5cHQwWWY1?=
 =?utf-8?B?czJtd1VoSmRnZ0piTkQ4SVdvV25Ha1FPaThVdUxGOVBpYWFpeW9CK2N5b3o1?=
 =?utf-8?B?TndOM1NZd3UyaEVZaFF3T3J4aldCczVmMjYrWlpvK2ZtVWRqcjNUNWJjWEFL?=
 =?utf-8?B?dm9XQzVWY04vcm9jV1d5WCtIS2hiVE1qL3d6ZDhJYk8yWTdvaWxYOEg5aW9t?=
 =?utf-8?B?eWhqeGNoSTBpTEVBQVNXaTNCUnE2MFhiN3BYTEg5UWhYRzlMb2hFTlZMTWxQ?=
 =?utf-8?B?dWlwV21JMnRoa3l6eUw5R0dNUDBicWZnK2FtdFhKalNHTDdCNlgweW12a2FO?=
 =?utf-8?B?a2grbVRSSGxiUWtMcGpGVFlRYnY3TzU2UjNQcXN1REo3anowZVBmRERDMnh2?=
 =?utf-8?B?bVExN3p2RHBjbGN1U1Ftam9zdzY4V2c0bGc3MmkrR0VNYWsydmZZbjJXZmZD?=
 =?utf-8?B?UXBoMm43enRuY0ZiMDkrZ0RlNHQ2dW5QcmZwa1pjaHNoUTNZTWE3dUk2ZzZP?=
 =?utf-8?B?ZGFFcGlmSHE3V0V3Zk44Tkp1dEVLT2tZTXdEQWp5QXlLWjhtSlhIVEVwanNs?=
 =?utf-8?B?RDA3THhKK1c3U3RWUFpWRkxzeFZlT2xKRFhSMFk3MXY3YldJdHNTUUczSGFN?=
 =?utf-8?B?Q0I1WU1HM09KYzBkbG02dFFEYk5EcjhBYlgrejYrRDRLaE5EQWZ6MTZhQ1F2?=
 =?utf-8?B?a3dPZDU1aTd0eHduWEI4c0M3SVNUQmt3ZTdDa1E5eTE0Z3JrYStCZ3EyWDlu?=
 =?utf-8?Q?JkrsnLlEzOETi4Ze09pIcOhqywAPKpp/zNL5g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzdXc2hhcWwrSlNTZE4yT1ErcTlwQk8yWDZIZFJTVjlDcDFHcUJmUEVJRDZs?=
 =?utf-8?B?eFA1YUJ0dERpUThOdTBrVWJrQ3NZOUhCeHllQ2NYS0VSeEp4WTlCYUdtMlNX?=
 =?utf-8?B?OEN0UnhFSmlUMXNwRmtybXl3OTRhbWtZWkg3VzZQSnhJRWRodzdCVW4rcHFu?=
 =?utf-8?B?NHVsMGdEb1F3cm5RbmZUcEY1c1U2NnJzTU9xc1VrYk1wb0pNNm9xU3hVcTAv?=
 =?utf-8?B?Q2hjWllsVDNYZzRQZ3IyWWJVbFRSZ0ExOGdPclh3N0FPUWplTjNOYnJyUWg4?=
 =?utf-8?B?YVlCbWg4UWQ4aW5nYlA1aEJpNUo4TUNzYjc4cWhGaHJ3OVpUZDBERnRMOWxv?=
 =?utf-8?B?REtacmhONlJFUTE3OWhOZzVTa2lNWUg4dlVLSUo4cXBQcE9rTVlLbTJ6d0xi?=
 =?utf-8?B?aW9XMEMxdDF3eTV4RjZ4QjhUeG16RlA4ZmNXbVNXN28xd2RqU29nVXpyMG9M?=
 =?utf-8?B?TjNFUklCbWdSYlBCZ0trVkVRWGhXTTNtMlJOME5sZENnRzQzWnBhMDR0Skgz?=
 =?utf-8?B?R1ZnMFZWTnhhWEdDTWtEK0pRWmVRR1Z2UDloOHBOazZUNy9DWjVLeTlwNnV1?=
 =?utf-8?B?UzJVNVVhQzBacTFjYzJ6SlNNZDNoWVB1TjhULzdQUGJXaHJYeHJibmtubVpE?=
 =?utf-8?B?bzJPU1hZQ3Q4dWppeVNKUmxFN0t0S2FrSXJIR01NRi9TYWhUTDJHTjdlcC9h?=
 =?utf-8?B?TGZselhnVnNxZUwvTk5ZdmJwZHJTTXdwN1ZwYkwvQ09jSC9OYnVWcERnUktj?=
 =?utf-8?B?SWlqdys3YlFZTExpNFJjTGtZMkdSd0M1ZmdyeFhwblVwZzZjdjU4ZWdvRnln?=
 =?utf-8?B?aDdueVFXZTV5Y2dWODVFSVZicjgvaSsrc3d5UFYrTU91aW5XT2dSZXJER1pP?=
 =?utf-8?B?UEZCY3FrenE4UDRXNkFydHljOGJqdkJzMjh5ci9pYVpSb2tKYVRlOTVxRFJT?=
 =?utf-8?B?VzgwVUZwT2xGVkZUQk40aGlPRkdsYVdXRDN6Zis2NnJOWXVxWm9qdlVDM21U?=
 =?utf-8?B?RHZPSUVuak9WdVZvYW5McHFjN0xtdXk4QWRpbTQ4b3p6WEsyQk5iVk9nLzFH?=
 =?utf-8?B?cFd4WkYwMm1tdmVTcittVGZyU2YzaHEwelVRbk9kYkNFV2hERUJ6Vm9JNzlP?=
 =?utf-8?B?T1ZhaWtHSlYrK3lmUXdJcGhyL0hxK210TnJwWGxwUk16Z2VudUFWTUhxejNy?=
 =?utf-8?B?N2NGZkYzU1FGTTlmU1RMdFo1bkZmR1FoOWlrRXZCMkZDVHVSWmJGbGE2blhJ?=
 =?utf-8?B?cUh2SFBDVFAvUG8xR0QwT09ONXg0THhvVzNreEFaWmpNUHU4M1BCenVBUmZP?=
 =?utf-8?B?b0tKWVg3L2htd3B2alJ5Mjh4RTA0OXM4OFg5YWxDaEF2QVExWm1zeERNSTlF?=
 =?utf-8?B?MEI0cVpLcFgrSUV4dVZyYXA2V1VuOFlVWmJnMjR0TFR0djhOZndRVGpzMXVk?=
 =?utf-8?B?eGVVTGhRZmdVSW0wWjh1Rmx3dTRhQm5PVFZnamtxTTVvTk5BSmRTaXlmcGhz?=
 =?utf-8?B?OXE2TktRbWlVYjNlZmZXVEphTlVrcE1XQm9BMEFmMmNqbitzNnZmMXRubHFl?=
 =?utf-8?B?WWhwNDlwd2pCMlQwRW9lMXBEYmM2S05uUkVyeldiVi80NFFhbEZad2RWMnZO?=
 =?utf-8?B?YW90cUNKVEllVWdLWFl1M3ZRSFdkOHI3WEJ3UHpyM3I5a0xWUkNoU3dvWThZ?=
 =?utf-8?B?NkdhenFyK3daM2lydHdJNEdhMGNVUDFxaEFHVEU0eE0zeGhwbTRiWThweith?=
 =?utf-8?B?aXIvODROUEUrc3NPYXFCMGtXVmRDa0QzZjhJekFMdGtETG0zdHN2YjA1ZVRV?=
 =?utf-8?B?YVBvUWJaaE8vdVJwQlVBQTVrN0dWS0xTOFUzbG5YejNMU2syQStkTlFwU0pH?=
 =?utf-8?B?c3RQUWV3NGQ5YmJBOEdEMWdlZFg4ckU0K1VuRVRmMlVFdXZzWnJpUXNoaVdq?=
 =?utf-8?B?dVBLeGhoZERoZjJnQlRnckROelp3eDVKcDA1L1MyWDMzb0hWUlEzTnkweENM?=
 =?utf-8?B?Y1RlRHJ2cDlIU29JcjJhYW5JZ2NVMldYUVB0YituYXlEaDNqS2VQRFJvWHNO?=
 =?utf-8?B?VUFTazRJVlljV1p6MWlUd3B4QjhRSDlOMmZZREYzRW1CZU5QSkhJZWFNMmIz?=
 =?utf-8?B?bGV5M0NNTzNaNDdTNTNObDRFS2lFMG85ZlBuWUdkOFZkN3hqY0lmN1FReHlC?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hhoPjUZk+CwUHwbV0+dlmrz5oDycMCty1FiA5jno2km+YAOfazkrZYVX9CIIovIeH3zweOMocP8cKR1PbpPHCynvliTLKDmQl10nzwIad9oFmJPZs4RxOkWJ451AOXIkMGdoZwE5FLHizpAy7tNpNPUGrQE/XpdNO1ZvFBRa0dT3gz6F9tCocGSf74ApcOsBHFqh8UoFKu7XiWFYDBnJt7AABBt3I09jTP339CdR25LGVtvUrvpjw04cnUBDThx2qt29UDlTGijpKgQSJ2Rss1XCUnyD+pby0Wnyr3czzJn3ihRhDBnoKIeZWW+1E8ef8Xa/zLq0iDSYBVxaiGOu7GM/B14PBiXKy3ybuxiWm20JeltH0Ffs/NRXSriR+wBrYoj9YYpBp/84fk6kzi5wK4ycP8haz6eU83mafgRrycBlJfSO7/IsrHJ6/MxnU/LQPw59TziWfDpxzZefPMhiu3ZTLffE+zvZ7GstXXEs/QocdjWRyKOdJtQ233dKOEOFC612n1ggs4N40OOxzT/hT6jIe0rSbItjAm01lmv8jiPKpYIMjUs1ztsf21BRHXVVYWm87K5Ooy9C33DasKPNsG7eJesvZQNulXZhHV580Mg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ded0c6-d392-43f9-b9ba-08dd92fb2292
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 15:22:27.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUt3heTx0NcV+uv4fzFHL5/dQ5L679iUtJJRq6EqEtLmTlEna5G3JTxtu5lK6xuM/EGgFOheQoWDAXwCbkZnEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEzOCBTYWx0ZWRfX5K7Ww4eHZl9m O9gEex6WV1324NexmfLNK3RLTPRlOSTwyZnMYn5F2rwpLrwuBEKpRCvG/2FXzkz5OIXv3ZPehHc jTzD0T2d+VNXfwPyB3RLSAz0dyWB+Wd/E24R07R3M8IoCksCx9NJ6ScNsGKZ3kBWHDQjgZw+11s
 HukrPgHC/FDY14VtPrJa7RvyAZMBis5SoESAcE1Fy+UBTFCz/DxJ529kPgbWWGjO9ZP6NaC1vfs cLPU9XFAIq6dK36Xs0L91dlfMBpsutLZrb9d8ngwJPjwhh8UXufl97+Eeb+tLZ+pU/sEx7A+Fgs CkbjL0sI9yZklkfZFM9mCJM8ENDCZEXPP7MWxPhKFYAWNnr6+TSTWbZsBjpzLGij+P6wTLZmLuB
 HEvfY4uii3r5HtHDmHM1IcBqKrHTTmHNQlb5HqF1/noLlWfmDaWj8P2QX0wqE6toSWl3owjf
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=6824b537 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=p4yhxsxNAAAA:8 a=IBS8mUSXS0KF9YFMHpkA:9 a=QEXdDO2ut3YA:10 a=yp-Zx5YoBjEA:10 a=4AvGVvso5qoc5vnZhopw:22
X-Proofpoint-GUID: SlEZxS1o8um3EAn7StG9hLmE-vk26PuU
X-Proofpoint-ORIG-GUID: SlEZxS1o8um3EAn7StG9hLmE-vk26PuU

hi Bruce

On 13/05/2025 23:39, Bruce McCulloch wrote:
> Hello Alan, Arnaldo, All,
> 
> Recently the Linux Toolchain team at oracle had reason to start emitting
> types
> with the vector_size() attribute as arrays when compiling with -gctf/-
> gbtf. This
> is a change from the previous behavior, which was to emit these as unknown
> types. This emission as an array is consistent with BTF generated in
> both clang
> and pahole. We have some ideas on how to implement the change in GCC,
> but were
> wondering if anyone involved with dwarves had any insight into why
> vectors are
> emitted in this way. More specifically, there were concerns surrounding the
> practical differences between vectors and arrays in the realm of memory
> (e.g.
> Vectors can be passed as args by value, while arrays cannot). More
> information
> about this can be found on the DWARF std issues list [1].
> 
> Any input on this subject would be much appreciated.
> 
> Bruce
> 
> [1] https://dwarfstd.org/issues/230413.1.html
> 


As far as I can see in dwarf_loader.c we do record that an array type is
a vector, noting that struct array_type specifies true for its
"is_vector" field if the DIE has a DW_AT_GNU_vector attribute, but this
information is not used during BTF encoding; they are as you say just
treated like normal arrays.

So we do have the information available to potentially do something
different for vectors at BTF encoding time. Did you have a specific
representation in mind? Thanks!

Alan
