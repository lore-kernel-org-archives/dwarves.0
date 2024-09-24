Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861163FE55
	for <dwarves@vger.kernel.org>; Tue, 24 Sep 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188318; cv=fail; b=QIpmYds3W1EnJaYhehGlFF+PoJM2aYdGhxjUnL32SwzDUXbnCCfH1tsmQpfmOEUgw5B2Kquaha2oAf06uL5jqxUg8nHwEc1dmPS1YjJWFkiFihl6+QJ1u/9rhBHZStObNBBEWedkKzg8e2nzZl6+9ZqBSugmkot8VYv+Yb22roM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188318; c=relaxed/simple;
	bh=OVjJjRQDLz99oMMcpYMKxQHvT42qPx+BAnJDEgmGgU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5vBE58cQvLKM0bh3Unq92szTCOrUAia0bvnVqnyHfjUlfTh0a6AMTnMxCn4kA/TG5/FubkvXobKHT0uR7VYLKUZPCI7Rs13q9I8ogplZ6jPkwuRZ/oChkIE01tmCbO/eiax6Bj478kEMbR0bqiCMCNIOdc0lEZXZkNIgNbeTtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fp3djM+B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rEEkep6T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fp3djM+B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rEEkep6T"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQXcI007280;
	Tue, 24 Sep 2024 14:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=41TYF16uCd1WM4eeZep0JWp5iRkWkQmpD0mMoTT3rwU=; b=
	fp3djM+B4KWHBDiprwvwfn72zjZbj/nI7vLtKYnZi603fRWPSkk/YrdY5V9q23zB
	MHMFbhcEQXKqPuW0+6gRGnwCP9VASWzGYE5/au5+6bNbcMw6dXgia/UPzNTxjgqf
	CSRV188Lq6qcbvURisbp9nyKkdIDZw6Qfor9onbQWjpxkLWFvQKjhg0MqtGLQ7S0
	B28W33YfeOjOqufLTixNhKmyKIquhTiE7+G+lQJ3M9n2bVl9oh2m668pn74RG/K/
	iq4deSIpvAMf2tjXKQo3Vs/I8QHc1I9a4qcUT2QK2FT7PLPqM+VyICVNGPAi0xvJ
	MqQF72KLOiiCkvJUyBO37Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1afk0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 14:31:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OD9olk029590;
	Tue, 24 Sep 2024 14:31:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk99unk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 14:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1w9l032gezLpkJxZX6VEP0e/HytWb5AbPmgdwKPtoRQFArPF8XH2wIsHTCOr7rTXU68RMZglnsUjv47wVqoYgA2ectpbgaE+8xO08W9DduQOn2DX3nFCVY3gHBB2NgTlGrdcfQXKRVNibpt3dgZ76q3I+5/sCBwWr25MXQ3ETLZiQXWIKTTm1oK65WVutw5sGd1IIx5ifm37IQeNAGJWm5YfBSTsSADfMMcoYADjrmnaXcAt6S/498jYC/yRLNiI+CD/ANEP+/c0VqH+vI7ypNtQPN/ESmVH9KOJ+8hqXBDO1eBqQ8s7aux0Bg3PPkvEWR8VY9Gdn3FV1KgGBgUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41TYF16uCd1WM4eeZep0JWp5iRkWkQmpD0mMoTT3rwU=;
 b=TCROrlxpzRpmMcck1dUCer+hgqUrYaELJJehtRgYKfMToDjSuS+3cVtO7drLFH6ddrkGPaU9kez4Y+lGXkYrl2pPSDSHyLak1s2tFZvsOX80HOt2r0+iqifVVsARBzir/lnsDRdwjGIJjd5QASiHfMm+Nw4NEOz9VeHG9/BREyjlhlXoy6I1mXixekdJPgtRsuBYOBJkSLURHQG9hc22ic/WuIAsuVvkV3z4Od/61eovATEnO2bNHOFcvcXugtPXd0sr910B2Jo0GiwHEwhV6cSejzzV+qxMOEW7tkjSANu+lI6hIAxgcYhN5iT5D4F+23Cu3ZyXPNqmpI7EG6e6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41TYF16uCd1WM4eeZep0JWp5iRkWkQmpD0mMoTT3rwU=;
 b=rEEkep6Ti1OwgPGoZqHJ4gt21H2W4gRVezNuobEYPZ+CrAXR6w/oPLCn232duWlGTkz6a97dqBT9FR1f+feRC01rGmP9NxggC6W55ImmxaTI+Ntz1KV5t12tQyEFXjDohV/wc8ZnxZRSw9uK9uxyV2vhBex+pA/6qeB8jKyMRyM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB6794.namprd10.prod.outlook.com (2603:10b6:208:43a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Tue, 24 Sep
 2024 14:31:27 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%6]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 14:31:27 +0000
Message-ID: <a78ff51c-059b-45b3-9c81-2c2d5a5b5e9d@oracle.com>
Date: Tue, 24 Sep 2024 15:31:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 1/3] btf_encoder: record BTF-centric function
 state instead of DWARF-centric
To: Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org, olsajiri@gmail.com, shung-hsi.yu@suse.com,
        jirislaby@kernel.org
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
 <20240916134946.3893204-2-alan.maguire@oracle.com>
 <2be35785218e6df18d3e05ddcaf0406227e05109.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <2be35785218e6df18d3e05ddcaf0406227e05109.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c3f498-4513-4add-aee4-08dcdca592b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3EveTVsSHZtTkhramMrYitZY1oxa3I3REI4TGNZTWdrMGhsQzV2bnppd05X?=
 =?utf-8?B?OGpLRk5FLzdLdXdrRDhxS05Mejd0YW1OVTZwUW1Ock03V1hYbDZUZDllTmtP?=
 =?utf-8?B?d0RZVmE5SVdTQm95VTBFdVo0bktSZUpxN05FQUk0ZmZGblBOTitTSjBlVVRI?=
 =?utf-8?B?dklMUFJzVDZVUXZKLzIwUFZwNzYvM2dxeXFzWGlnVXhKUzNPUXM2NzF6enlv?=
 =?utf-8?B?MHBFeU1QdzFtYTJ5YkV6NHJWVDNaaklOb2kvSTdzTkNIS2lYaTFrM2JsdFpt?=
 =?utf-8?B?UTlvbUVLMEF6eitPMXUwNFVDMGF4WHJJSTNubUxDajR1WlNtcWVPNVdUYmw2?=
 =?utf-8?B?Y0tiSjFNbEZDU25PWE95aDB0K1ZnajRQY3ZwRGlORWVEZlpzTkRRVTFYbjZV?=
 =?utf-8?B?SDU1bmphSXhJaDlJekpzUFY1M3RaeEl5MlNvSWwrYStubVdQSmlQcXNzUW1m?=
 =?utf-8?B?TVdSb1I4QkNyZS92R2R5WkV0YWZnTnZrdzcxS08vQXR0eFRWRzN2N2ZxVEl5?=
 =?utf-8?B?cVM2dVU4Ymp0ZlNxczljK2FTNTlqRVFpMDNwNU9waEpnMWVyV24yZm1vZXVn?=
 =?utf-8?B?TzlVYzdzdjhPY2JheitLbDVVUnVnT1Y1OVFHZkV6WGRyS1JMYXdzNXdad0FU?=
 =?utf-8?B?Ti9aZDlKVzVjcU9zaFNrM0V4bkwrWUtIZ1pkQ2UwVFdLV1hJN0h6TEpyVHps?=
 =?utf-8?B?dkNZdjUwamJSQnJZY0k1S2RUOHh2YUVSalg3Tk5nZ2l2WStoeVErUmV1blhL?=
 =?utf-8?B?NjdZcnhjakZTT3F4Vko1NlZENDJHVUwzV3JKSTIyZ253SlN5cmZqdmpjL0RO?=
 =?utf-8?B?MkNUNG5PZUg3NmtuVVFFZnIwRWVIM3EwOWZ3b2dVV2hvc2xaekVsRHJBRER2?=
 =?utf-8?B?VFFYcW93SjVIQUdHeWNQTDc1K2JaazVPZlJZTkJuSEs4RHBiRHZEdm1lQU1m?=
 =?utf-8?B?SjZ1U25NSi9IVEdIaW1lbE1MUGFvbnd2MlBhOW9IQnp1QmRCb2RaSXJaRnNn?=
 =?utf-8?B?aXJCUi9ycGVFL2ZQWWFXUkU2WnV3ODFVMDNOZzhzUi9jVnlxNUhZaFh5TTc4?=
 =?utf-8?B?TG9CbXBrc1dVZmoxaHZxRVZqUFhKa1VFWHZ6eGZ3WlUramc5a1RmamcxVDRS?=
 =?utf-8?B?aTJxVW1MOS96NzBkdXNoT1ArU3NkZWtJZmZkK1VzcVVPb0RZWUI0U3psQVAy?=
 =?utf-8?B?dGIyc0RUUzZpdEhyRnZpVVB0Um05SE90eEk0eTVXVSszSWhkU3pSamNhTVc0?=
 =?utf-8?B?cHJodjRsQ2FsbldrVTdSb01xR3cvRjFPb0ltRTdBTXpVT0E3KzFCZnowL2Fw?=
 =?utf-8?B?MjBVd1p1UkxjWXlhby9QTFpGRy90ekJSQkN0ejNZRUVkaFJwajhld0tJZldF?=
 =?utf-8?B?NCtmNHg0Tks3MUppemQ2dG1KUUVJZ3o0dWtpbDVWQzloSnVPNEJiYVd5TGUr?=
 =?utf-8?B?Z29rMmlPaHBaRjhQZmRVSHdxeDZPaWpNcGFsWmRORXZvTnZoL04wdDZGU1VH?=
 =?utf-8?B?eFpGQkd1OUdINjBwRldnRmcrY0dPTjBoWUxBaUNWUFRtbjFEcTJwUmk2YUpD?=
 =?utf-8?B?V0h1cW9GOUZHRmJBMktEdVdiQjVyOCt0UEJ1NE92RmpRelphUmJTKzFxQmZ6?=
 =?utf-8?B?ZkpiTkROQkExMkVJekQxQjV3THRiejlzRlpqUFZDOWt5SXZ4LzZIZHFoNDRJ?=
 =?utf-8?B?cXpISnFnUTRBcWlJZ3labWVjYmFXaktscXJVTFl1OEowekxzSkMrRlRGbW1s?=
 =?utf-8?B?dlhrS3VMd2pLMDhISnRKZm9MQ0U1d1pVekh2clNzK1piQ1c0L3hxQnBUaG5Z?=
 =?utf-8?B?Y0JVdWNWd2RDVm80dDRidz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE9yaURFT2VRM0hoWWQvUWt0MzhqVFk3aTlDdGxPVVlkRTA4Mi8zU3I2bmtB?=
 =?utf-8?B?Q1FJdHdYS0lUVm53M1pDcUVGc2RTRHQwWDlDSnA4VjFycXRLU2pTSG9JOGo0?=
 =?utf-8?B?NHpLSlJNS2pHNW1MdHp5QlRjd3gvWXllRGhRNEJIbkQ5NStGbURrWFd2RDgv?=
 =?utf-8?B?Y0VoZkZFU1BYQmhOUGdtaERzb2JDZXFiRGhIc2RIZFRJUERQL291VmNpYmQy?=
 =?utf-8?B?dVR0V1R6ay8yaGdPUDFGVkdsMG9OSjl5cXdtbllCK1plL1FSOGlxUlJ0N01j?=
 =?utf-8?B?T2tQQ1dEa2VseUpldU5NZW9HclViQ25RcXpzNGpuMklaZjhhNWcrajI0S1Bs?=
 =?utf-8?B?NzBFaUQ3dEI1SFhiRDBvelZpS09neGxQSHVQWEtCb3A4aW1mUHgrMk9FMHMx?=
 =?utf-8?B?cklNWXUzK0hrOFl3cE1tYTZBa2ZiTUlpRzY5OW5hZ2hJMll2OUVBZUhFcjdJ?=
 =?utf-8?B?bEhwTGhtT2dKdEY1Zm1lMmttTE15WDdVNjdZS2dLOUlaRmlseFVMVWd3bnNZ?=
 =?utf-8?B?NGlqT3Z4RzhqQ3M1dUNEc3drRFRhOHRwRWtOMURabTJWYnNtc0xkekRObnBT?=
 =?utf-8?B?TFViZUx1azVsa1VTQmVnU3RLWGVLOWsyRm51MTJmckpZcXU4QjZIbUttOGhm?=
 =?utf-8?B?aG84UXdvUWJIK0VlV1AyMXIza1YrSGhqdlBjSDNtNHp3SUpFT01Pd2gwTjBL?=
 =?utf-8?B?c0FsdjhCcDBDa2F6OW5zY0pvNFlIM0RWUmhweVhZTEtBUDBQMGp5UW8xemt1?=
 =?utf-8?B?VzRDVG9pdEtISUJyK0FyU3l1SW4zOEdsWFFjY1d5bjhhSFR6cjVRRWorNkNM?=
 =?utf-8?B?SGpGajRpNklxWmpVWEFZa1FnTmpuc3FtMUNiazlwWFNXbFJvYlVNVHBIekNj?=
 =?utf-8?B?ME96N0pPdGxCbFgyVGJNNld6emZaK08vM3BtVkFNYm1KbmwzRUp1azlVZ3NH?=
 =?utf-8?B?Y20ySVhLWllDZU50Z3p2cjM0Q3hOeE9idW0yWEdJdHc1MzJpN204L2VXUE5t?=
 =?utf-8?B?cXBYZ01hVUR6cGVXY0F6YWJtcHFjRzRmVFRZVXVtWG93V1VuTDFHK29uV094?=
 =?utf-8?B?anNJZVg2bERjbEVlbklrWkRxMkdSeFVnMTlURU96dllUWjIxc1dYTzI3bm0y?=
 =?utf-8?B?d05mN3BOTlMrTks4aWgxS3A4Z1NDdUNDMmpsUktPVVRpRERUSUo0eDdMSFJC?=
 =?utf-8?B?SEhTUTFFempSeXNBVk02S29kQWMwbEF3bHBKMHcrUkNYN3JRRHlTdjFuYWVN?=
 =?utf-8?B?elAzMDJZaE1jSm9aci9KU1RBVmpBNGxGMURsak9Dek5Pdm4zMUp2TG02Uk45?=
 =?utf-8?B?WnRnTGs4Q0ZrcXdkZEVvT0I4bk9NTUJsSTBpZGFSVEd3U2ZDY0hFZkpuR1Rr?=
 =?utf-8?B?b0g2ZEhKWXBTVnpvVC9GZVRlaHVvUi9UNDZPNXBaYm44WmgwdlBiU3dpem1i?=
 =?utf-8?B?MVNsRjVpaG9scnprZ0dQRE15anNnQVBpZUFSZjU3UnlSd0RqR25WRmZyU0hL?=
 =?utf-8?B?aHBzUkdrTUxkN3N4RWxqR1FwVmQ1ZkpieDhkWkg3eHNtNjlZK3NnYXpSZXVJ?=
 =?utf-8?B?NmZVdXNFelZ2VDdOaXMwUGMxd0JEc1FiM001OFZXbUxQVmFzTE1SSnhDQ3hB?=
 =?utf-8?B?NTdHc0VnY2YxQkZwUG13RC9OamNyTU1GRlhyNmZ0MkFoQVlmTjFnWlE0a1FZ?=
 =?utf-8?B?S09Vb2VBa2NGWHQxQkpMMVo0NVpGV0Evd2JFS3IwaDM3aWJ0ZmhMTUl2ZCt4?=
 =?utf-8?B?c3NZYUo3RCt5aFhRN3FCbDJXQW1iNUhuR1ZhZ2g5UmJzcmxxQ25saW9pcUxu?=
 =?utf-8?B?NTM2d3lHdDdRL3hpMlY5VFdYdlBsUTI1L3JvYW1OUzhHcUI2OGhYejQybEgr?=
 =?utf-8?B?VHNRTDZOMTlEcFBWWTI2KytWbUpuODRiN3NJOWcvZ05GdmFLV0RYWGVmMlVk?=
 =?utf-8?B?dkFiVXd0TWlkRS9Vd1hHd3BBa0sxZHJWVFZDRFZndHRMV3BXbFA1M28zT0lL?=
 =?utf-8?B?cnBnYWp0dGltY3RJMEtnZDBZOXlwdGNNNitNNHI0WU5uNVVaRkxmS3VCZVMr?=
 =?utf-8?B?M2J6WVp2Q1BwblEvQU1Qc1Izait0cGdhMEJpMGhLcmd3SkppRmZDbjJWYTVY?=
 =?utf-8?B?cWRnaThPai85NXZKYlc3WHdNTmRNK0NnRGlRQ1dDUTIvbENuL3R6K1R1RnVj?=
 =?utf-8?B?S3ZEMmVVNUQvZko4bDBQWk1acVQxcHRvNHVBMEx2b0hQOUlJRFl3Rnh1d0Y5?=
 =?utf-8?B?YnRNSHpKQnZoSXJZQ2hrYWhuc2tRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HCrv5+acNBP3qERGktpWf5g7IcFgcfnF2Jd9oDY6/OqVXPwFuhH8MOqkahp3/VcrT6gptQTlAnC3zQZ9cGCm4X/9QApgOERy9DjVpNYhzT7WiPaFKF49uo+s85CEoup5PlinNEnp+y7jsEZhtAfOQI//WFwb8arZhJ6U6GmtPCDVwxEtRhTztif8sgJfI2wWO5+IfEQkZa8NxC2a6Pztv0EiN4OL6fnvCCVgXZzoLw0nJsqWjcMPAJn8+2WF5tl7ROh3s4ykV+9jsRRN77cB9/pqlQRJERTzf04wvbhpx1FVv65djLj8nqANUXh/XnBTKEbDhfRyk1yF54yKydqU5RJXdZgPkoxt3tPh6za1FWVCCcYgGKrWCEnC8IuGNzLHFozslvvYEtI8+cCgVP0IDplrk1fEkjNZyURP0c1+xV87iGnhnSmsshl3h5ZP+8+Eh8fzQwn84ZmCIEPjybN5nGDZ+DzjtVY/yThQjLRfqo40bv9oi56YLgMfV3ap5x+06dd9Me3l0NBOYloalk8v/GWbzY6hmZYtsNRx6YIearmBndKb9QfY20pRpere6mNky0sostyBd9IahHFD+k5rdvZJNW779+XvnnVCYeYqz4I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c3f498-4513-4add-aee4-08dcdca592b0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:31:27.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgTnCEIJkD68Pj2GUr39lgJONHKLLFd1LW8pm7XXToNM+jELt9AyreeX57Oq0DYHREzL6MalT7TrYQKCI81UKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240103
X-Proofpoint-ORIG-GUID: ptAExACr8o_oKewUmrVhmOetIG6nX3MS
X-Proofpoint-GUID: ptAExACr8o_oKewUmrVhmOetIG6nX3MS

On 20/09/2024 20:18, Eduard Zingerman wrote:
> On Mon, 2024-09-16 at 14:49 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> When this is done, memory consumption peaks at 1Gb rather than
>> ~4Gb for vmlinux generation.  Time taken appears to be approximately
>> the same for -j1, but slightly faster for multiple threads;
>> for example:
> 
> Hi Alan,
> 
> Sorry for delayed reply.
> I tried this patch with selftests vmlinux and see huge reduction indeed:
> 
> $ /usr/bin/time -v \
>     pahole -j1 --btf_features=consistent_func --btf_encode_detached=old.btf vmlinux
>   ...
>   Maximum resident set size (kbytes): 3123660
> 
> $ /usr/bin/time -v \
>     pahole -j1 --btf_features=consistent_func --btf_encode_detached=new.btf vmlinux
>   ...
>   Maximum resident set size (kbytes): 464400
> 
> [...]
> 
>> In terms of functions encoded, 360 fewer functions make it into
>> BTF due to the different approach in consistency checking, but after
>> examining these cases, they do appear to be legitimately inconsistent
>> functions where the optimized versions have parameter mismatches
>> with the non-optimized expectations.
>>
>> Mileage may vary of course, and any testing folks could do would
>> be greatly appreciated!
> 
> Interestingly, I don't see any difference in generated "consistent"
> funcs (BPF selftests kernel config, compiled using mainline clang):
> 
> $ comm -3 <(bpftool btf dump file new.btf | grep ' FUNC ' | sed "s/.*'\(.*\)'.*/\1/" | sort) \
>           <(bpftool btf dump file old.btf | grep ' FUNC ' | sed "s/.*'\(.*\)'.*/\1/" | sort) \
>           | tee | wc -l
> 0
> 
> A few nitpicks below, but overall looks great.
> 
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>

Thanks for testing/reviewing! Replies below..

> [...]
> 
>> @@ -669,18 +692,25 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
>>  	return encoder->type_id_off + tag_type;
>>  }
>>  
>> -static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype)
>> +static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, struct elf_function *func)
> 
> It is a bit unfortunate that we now have this "doubled" representation
> and both ftype and elf_function pointers have to be passed through
> several layers.
> Ihor (in CC) is now working on having single btf_encoder for each
> processed CU (in order to be able to sort btf's by CU names before
> merging to a single BTF for dedup, thus making reproducible builds
> cheaper). I wonder if this could be further extended to have a
> separate BTF for functions and merge only consistent functions from
> this BTF to a final BTF.
> 

If I recall, Arnaldo's work ordered the DWARF CUs to be consistently
processed to allow for reproducibility. The only danger I see with the
approach of having a BTF encoder per CU is that currently we create an
ELF function table per encoder, whereas in reality all CUs are using the
same ELF. So for this approach to work I _think_ we'd need to share ELF
representations across encoders where appropriate.

> [...]
> 
>> @@ -694,20 +724,34 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
>>  
>>  	/* add parameters */
>>  	param_idx = 0;
>> -	ftype__for_each_parameter(ftype, param) {
>> -		const char *name = parameter__name(param);
>> +	if (ftype) {
>> +		ftype__for_each_parameter(ftype, param) {
>> +			const char *name = parameter__name(param);
>> +
>> +			type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
>> +			++param_idx;
>> +			if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
>> +				return -1;
>> +		}
>>  
>> -		type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
>>  		++param_idx;
>> -		if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
>> -			return -1;
>> -	}
>> +		if (ftype->unspec_parms)
>> +			if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
>> +				return -1;
>> +	} else {
>> +		for (param_idx = 0; param_idx < nr_params; param_idx++) {
>> +			struct btf_encoder_func_parm *p = &state->parms[param_idx];
>> +			name = btf__name_by_offset(btf, p->name_off);
>>  
>> -	++param_idx;
>> -	if (ftype->unspec_parms)
>> -		if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
>> -			return -1;
>> +			/* adding BTF data may result in a move of the
>> +			 * name string memory, so make a temporary copy.
>> +			 */
>> +			strncpy(tmp_name, name, sizeof(tmp_name));
> 
> When compiling with fresh gcc (14.2.1) there is a warning reported at this line:
> 
> btf_encoder.c:749:25: warning: ‘strncpy’ specified bound 128 equals destination size [-Wstringop-truncation]
>   749 |                         strncpy(tmp_name, name, sizeof(tmp_name));
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Which seems to be a legit warning, given section CAVEATS from strncpy man page.
> There is also a second warning like this (see below).
> (when compiled with BUILD_TYPE=Release).
> 

thanks, will fix.

>>  
>> +			if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id, param_idx == nr_params))
>> +				return -1;
>> +		}
>> +	}
>>  	return id;
>>  }
>>  
>> @@ -831,53 +875,170 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
> 
> [...]
> 
>> -static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func, struct function *f2)
>> +static bool names__match(struct btf *btf1, const struct btf_type *t1,
>> +			struct btf *btf2, const struct btf_type *t2)
>>  {
> 
> [...]
> 
>> +static bool types__match(struct btf_encoder *encoder,
>> +			 struct btf *btf1, int type_id1,
>> +			 struct btf *btf2, int type_id2)
>> +{
> 
> [...]
> 
>> +		switch (btf_kind(t1)) {
>> +		case BTF_KIND_INT:
> 
> Nit: ints have a meaningful .size field and are followed by a u32 word,
>      both should be compared.
>

I'll add a comparison of the int info, ditto for float sizes.


>> +		case BTF_KIND_FLOAT:
>> +		case BTF_KIND_FWD:
> 
> Nit: BTF_KIND_FWD should go to default, fwd__kind steps over it.
>

yep, we should switch (k1) (since it resolves fwd kinds) and remove the
fwd-specific case.

>> +		case BTF_KIND_TYPEDEF:
>> +		case BTF_KIND_STRUCT:
>> +		case BTF_KIND_UNION:
>> +		case BTF_KIND_ENUM:
>> +		case BTF_KIND_ENUM64:
>> +			return names__match(btf1, t1, btf2, t2);
>> +		case BTF_KIND_PTR:
>> +		case BTF_KIND_VOLATILE:
>> +		case BTF_KIND_CONST:
>> +		case BTF_KIND_RESTRICT:
>> +		case BTF_KIND_TYPE_TAG:
>> +			id1 = t1->type;
>> +			id2 = t2->type;
>> +			break;
>> +		case BTF_KIND_ARRAY: {
>> +			const struct btf_array *a1 = btf_array(t1);
>> +			const struct btf_array *a2 = btf_array(t2);
>> +
>> +			if (a1->nelems != a2->nelems)
>> +				return false;
>> +			id1 = a1->type;
>> +			id2 = a2->type;
>> +			break;
>> +		}
>> +		case BTF_KIND_FUNC_PROTO: {
>> +			const struct btf_param *p1 = btf_params(t1);
>> +			const struct btf_param *p2 = btf_params(t2);
>> +			int i, vlen = btf_vlen(t1);
>> +
>> +			if (vlen != btf_vlen(t2))
>> +				return false;
>> +			if (!types__match(encoder, btf1, t1->type,
>> +					  btf2, t2->type))
>> +				return false;
>> +			for (i = 0; i < vlen; i++, p1++, p2++) {
>> +				if (!types__match(encoder, btf1, t1->type,
>> +						  btf2, t2->type))
>> +					return false;
>> +			}
>> +			return true;
>> +		}
>> +		default:
>> +			return false;
>> +		}
>> +	} while (1);
>> +
>> +	return false;
>> +}
>> +
>> +static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func,
>> +			 struct btf *btf1, struct btf_encoder_func_state *s1,
>> +			 struct btf *btf2, struct btf_encoder_func_state *s2)
>> +{
>> +	uint8_t i;
>> +
>> +	if (!s1->initialized || !s2->initialized)
>>  		return true;
> 
> Nit: is it even possible to get here when !s1->initialized || !s2->initialized?
>      Maybe log something about inconsistent state?
> 

you're right; it's not possible to get here without initialized being
set for both; I've removed the check.

>>  
>> -	if (!func->state.got_proto)
>> -		func->state.got_proto = proto__get(f1, func->state.proto, sizeof(func->state.proto));
>> +	if (s1->nr_parms != s2->nr_parms) {
>> +		btf_encoder__log_func_skip(encoder, func,
>> +					   "param count mismatch; %d params != %d params\n",
>> +					   s1->nr_parms, s2->nr_parms);
>> +		return false;
>> +	}
>> +	if (!types__match(encoder, btf1, s1->ret_type_id, btf2, s2->ret_type_id)) {
>> +		btf_encoder__log_func_skip(encoder, func, "return type mismatch\n");
>> +		return false;
>> +	}
>> +	if (s1->nr_parms == 0)
>> +		return true;
>>  
>> -	if (proto__get(f2, proto, sizeof(proto))) {
>> -		if (strcmp(func->state.proto, proto) != 0) {
>> -			if (encoder->verbose)
>> -				printf("function mismatch for '%s'('%s'): '%s' != '%s'\n",
>> -				       name, f1->alias ?: name,
>> -				       func->state.proto, proto);
>> +	for (i = 0; i < s1->nr_parms; i++) {
>> +		if (!types__match(encoder, btf1, s1->parms[i].type_id,
>> +				  btf2, s2->parms[i].type_id)) {
>> +			if (encoder->verbose) {
>> +				const char *p1 = btf__name_by_offset(btf1, s1->parms[i].name_off);
>> +				const char *p2 = btf__name_by_offset(btf2, s2->parms[i].name_off);
>> +
>> +				btf_encoder__log_func_skip(encoder, func,
>> +							   "param type mismatch for param#%d %s %s %s\n",
>> +							   i + 1,
>> +							   p1 ?: "",
>> +							   p1 && p2 ? "!=" : "",
>> +							   p2 ?: "");
>> +			}
>>  			return false;
>>  		}
>>  	}
>> @@ -886,119 +1047,212 @@ static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func,
> 
> [...]
> 
>> -static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
>> +static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>>  {
> 
> [...]
> 
>> +	if (!fn) {
>> +		struct btf_encoder_func_state *state = &func->state;
>> +		uint16_t idx;
>> +
>> +		if (!state || state->nr_annots == 0)
>> +			return 0;
>> +
>> +		for (idx = 0; idx < state->nr_annots; idx++) {
>> +			struct btf_encoder_func_annot *a = &state->annots[idx];
>> +
>> +			value = btf__str_by_offset(encoder->btf, a->value);
>> +			/* adding BTF data may result in a mode of the
>> +			 * value string memory, so make a temporary copy.
>> +			 */
>> +			strncpy(tmp_value, value, sizeof(tmp_value));
> 
> (Second warning from gcc 14.2.1 is reported here)
>

fixed too. thanks!


>> +			component_idx = a->component_idx;
>> +
>> +			tag_type_id = btf_encoder__add_decl_tag(encoder, tmp_value, btf_fn_id, component_idx);
>> +			if (tag_type_id < 0)
>> +				break;
>> +		}
> 
> [...]
> 

