Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2421D88CD;
	Fri, 13 Sep 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234006; cv=fail; b=nqANzSGFvo2dXf2Ps55YYC3q+nvdynYW7I98/JSOeEQBbgmjjULiAO35UcfY7xA3K4ZLw6/uHYt/xRTVb1rzq9yBgyBQC6N9M7/1aBID5PN4XNktMvzSKyQ+B7bWQozLkLsYbIfgvP3sz/2SOAxEqtSKSofoK6xLRie2/YKLhtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234006; c=relaxed/simple;
	bh=/TrprXR1Iz15RP1JwQve19M7LamCn3Ht+OZT0igEDo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M9OKaI/PooIBxfKktYDoRWTqP/Y/vUv1VZuGTROBt8MroYEicgBLWrw1Fxa3MmuHLxCW2npCWMhajKwKJQ/dNF0zsyT+1eTlsxafBNC/arMcJ5ng66aCeepTOusrUwJdVzmm2s1kRxlrBcC/O1pE7S2B2IbK6obCgIEpLoBxeiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XKF9tktk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YxZv8HHr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XKF9tktk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YxZv8HHr"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YJSv003455;
	Fri, 13 Sep 2024 13:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=qXgwRg2jPlld5YaX1IpFdIKSPJlYwQf1ccx9K04A3gY=; b=
	XKF9tktkszZHddyGQmePumJauXf436FVzBz5AWLD3WiG/wDKv4YeL1eNf/8MTasL
	PUp3NGQBV1lNJ7hfS9xhFtI5DmJCVauyRRxiHtiBEwOR5ivHRY7aM0JVdxZVfJpE
	HAXR+0r4iTfU3EBzonN7PzNzAefPObahEfoZH4SWffsxdSDeKjvCdOOCEQQ6itrt
	DwjbAmgd3UkUMSzMaQKJiHAYbe2Hd7ibPCr2H9reJtozq9JoMW3/p0Yq+EjB6X2H
	NlPhYDekd9i+Xz/VHnAcZqDPrRdvKwyBk10Z+yn3qmTkN8yxdS/ZJGo37YQYg0x9
	8nl8y5A3y7LzLfw7kq7cRg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbuwbyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 13:26:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DBU0hV034260;
	Fri, 13 Sep 2024 13:26:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d4hfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 13:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+Mvp2lhh3K34vVgl+DYVyqVuUeT85tIMrvAoyBCcjvnUWk4TqdLrGcllZJ6+y5KWUNtD3fwka3ZLXFgZZ1VML4WnWOOoFvMT2KFnvxYBf78K5MitZ8lf9jaUzWxEgOuzzc+JYNfXv9uTfLmCS5h3WrHibZeW/xCFzQhlT7f8xKbvYrvSo/1oTczvCyeKw6resmsobKEOLMMwsBknpkjn45BvKafEJCo2yCCBqSLTnDzngempz4HLn8XZWsrjZ+9J5WAjSmB/v6d+XHYXs15JhfzLJJMow+x2ia+Z7kXg3oXFyYIHFfWPLMIBKcdEuzn8lYHwVNUKykRC+1/Cba15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXgwRg2jPlld5YaX1IpFdIKSPJlYwQf1ccx9K04A3gY=;
 b=rqXlBOdISRj3Rn1/wDcpdHqQJeTqmSNPQjwCp53tjWIC82yJGfeLHzK39igvpmGqPl2P+PNiiTro4/q+UGuLIxYRQdJey9VjQQ/guJReiR/jWVDhgOREvajhPVNkbenp2str3Uz6LNC/szpRalPT6lRwgJCrg9gLVghyTdMKvYJd3007JEcg8hL/yNoNZfEnNHhBtHtcJuOAwZeIv+anyt5K6MXbX0YokQyWCz8b+eDBlM5486l0NAmrGVUW57wiwzA91uiahOBuB42lxpAWR9GYyxTz6Aa7YyPNPP5Pd4u911P1hfKXBA8DveCRjrUSM/WT2p1KBp2cGG6OulSYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXgwRg2jPlld5YaX1IpFdIKSPJlYwQf1ccx9K04A3gY=;
 b=YxZv8HHrXP83lEGw63a6IXRFZrizuBo7w05wosUsV/JFk7dhJnLw/vbNnOW1hsR/SiGU4Y+6Vz0JttKMZFfz0VmuTmIm557xqSS33TE07dK1Ns2gVXwYohiA1Bf4a66WiR34ZU6Root+EqYrzoKo2hZ20OJ8K88IsstWEZ7tysk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4134.namprd10.prod.outlook.com (2603:10b6:610:a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Fri, 13 Sep
 2024 13:26:36 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 13:26:36 +0000
Message-ID: <004e691b-440d-4594-bdd8-cfc0cae90e2b@oracle.com>
Date: Fri, 13 Sep 2024 14:26:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 1/4] dutil: return ELF section name when looked up
 by index
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
 <20240912190827.230176-2-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240912190827.230176-2-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH2PR10MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: d9aeb414-c565-45f9-b4bb-08dcd3f7b0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXYvL0pzL2lBbnR5cnhRNWhZMDBSUXNYVGtoWmhRZ09CVjdEYThkYktEdjI0?=
 =?utf-8?B?RFgzd29xU2J1NEYxWk1yMHVjeThKVGFQeXkzVGw1SGlBMDl3V0hITDBMdzly?=
 =?utf-8?B?VmhBMFcxWStYbElxVy9HWDgwQnlNanF6Q3VudUtWVHB0QnQ1cHN3VHhaUXRp?=
 =?utf-8?B?NmJoQ0ZTNzFRdEc0NXRRcStPRDNuaTV5SDZ2Zm5PRWtxWVpIcHljbk9JQURQ?=
 =?utf-8?B?c3VJL3ZsS284YWdFL0lrZFRjYzR2WHgrN3IyaExIVTk0TXFKT1luZUhiZlZF?=
 =?utf-8?B?djFUTEhmd0RBTVZBei9CcTJPWGxpcDBhOEwxeURzMG5JYVVUNld4eCtZYmpo?=
 =?utf-8?B?WW11Zk5EdkhUa2dNeVNNT2NzRVRBa1NzSzA5ejR3S1c1dVpQVjdGRWNuVUIz?=
 =?utf-8?B?RldEZTlTa2w0SUFKQUFDZ1JCbzQ3Q3kyUnlmSnZiMkRCQXlySDd3bnA1Vkdt?=
 =?utf-8?B?MDNLVSs4Nlh6QTBCQ0wydHNTaXNORS8vQXIyVnZVZEc0WG5IS1JhcUhaaCt3?=
 =?utf-8?B?emZ5U1NueisvOS9VbFFUaUJKVXB0cjF1S051d3U3S2lrNHdhL05LL1VlYWMr?=
 =?utf-8?B?UDd5SkV1dWczS0VNbXFrRXZUVlI3VTgzWXJEZ1BFTEdpMWZHcWV5U05hRE8v?=
 =?utf-8?B?RUJmRGdGVXdxaS9yN1lMTlg4b0o0YU5FbUkvbHZsRDh6MERYQzVva1ZxU3Fo?=
 =?utf-8?B?VEtCNTY3QnNGNzhwNWR3Ti9kYmViZi9FRkRQN0JnWng5OTRPNDh1T0lFREw0?=
 =?utf-8?B?aVVtZW4zY2U2Z3Z5T1F5ZU1qdnErc0VpRnIwZDFwSGNqTXRKQnpiclplM2Fs?=
 =?utf-8?B?SnZ2YjVRb096Wll2a3hOYXZDcVlDYmZGdTQ2Um5NdU5BeXZYVVN6d0xlbzY0?=
 =?utf-8?B?ZDY2Ly9WNHBNUTU1eGUwL1NoeU1aK0pZTENmUkNJQVpwS1MvUVFZS0tKL1Bo?=
 =?utf-8?B?UnA2WkVURGw3K0txUGVEQlRvODdZSmthY3BZQlE4TzJFaTY2MXlpT1RTWTFo?=
 =?utf-8?B?YStrMHpoZWlzWW5zZEVKWGhWTkRsR0FLaWpzaEFQTlFsdEEzSTVHS1BLWVVr?=
 =?utf-8?B?dklOVGRPYnhsUHF2a2pGM2ZrNUVlQWh1MU1lQkhkcFRDUHFrd0JMbE0wVG1B?=
 =?utf-8?B?Z0JKNmhqU2Q1YVpWTzNYODF4emdTUkE5SHRiZE1TaXV0OUs3ZU5SalZLeFJi?=
 =?utf-8?B?NWw4ZTFrNFMzTkVxQjVzYWdLODBvK3NYc09SamxDcDNFditGbWFSdEVYcHNa?=
 =?utf-8?B?ZG8yRXNMSWpXb2tBc09sRHpTWUZzdktwUDJ3NkpLN1FqWlhWV0NmSng3bVNt?=
 =?utf-8?B?RW5XaUZla25sdTRZNGVST0pXU2VEZzJuek1kMERBczhOWlZFS05QVkF1UFZx?=
 =?utf-8?B?YW0vTnkySkF0K3BORnFOb2U1d1QxTm9PYVVxNUN4NllxVDNzdEZrL1MzUSta?=
 =?utf-8?B?RlBvY1g5UDNSNEF0ODV2NDVKeFlDOThIWmg0UndmSlRBTWcxMHFNanJSN1Jw?=
 =?utf-8?B?Z0xIc3NidjZ2UXJGZ2NYR0YycC9nTU5RNklBRDVkYnRsdnM3Y2RhaHJKdlRw?=
 =?utf-8?B?akxNSWgxWVhlQlRlRU5VZFpuZE53MFhZMzFrRDBBVi9Pb3VLWGhHQUczMTZN?=
 =?utf-8?B?blByTmVodTZBbmlnbXE1cjNBeW5kQjd0UGczQUFpQWFQNmtrb3NlREhrOTlQ?=
 =?utf-8?B?WTZueDhVNU4vVFBCV1pmUUlEZEFiOEJXbjRTVWZKMG5sVUFPajBEcUlFbXZL?=
 =?utf-8?B?MmFOeEsvamRvZENmclRRSmU1VjJUUXhQcDRqRG02V0lDbHlTM2Y0cEhqeVpY?=
 =?utf-8?B?TlhYYVpWRXNHQTlCWTdPUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWVZUVBHZXMxRFRQcjg1R0RKZS84R2lCSFJFMW91Wit3MkcvTWtQS2dYZTJm?=
 =?utf-8?B?VTA3ZEJJS0NmT21zSEhhc3hBay9mM1Rxd0VjMXpwaHB0MDlhT3M3NWkwRURZ?=
 =?utf-8?B?NGtNWXNaYThPUUpnZlFJTmxtYUIydFdKSStMbFhFckJ0bUZISTE3c0lySDE3?=
 =?utf-8?B?UGY4bkdRb0haRzJWWEp3ZWNzWmVKYWZJdmswUU5wZy9SQUNqNDM2VFBndGpG?=
 =?utf-8?B?eFFFMDJNa0hyYjQzcmF5djhNeTNXMjdpSlNzSVkzbjRGckwwNDBQajJyczBR?=
 =?utf-8?B?NzNEM0xpSEVhbDllNk1sNUtGaTJxM3RrZlFsbXhiVW5wU0x4YXZPcHMyY3Yy?=
 =?utf-8?B?d2xsOFpadWFPSVR4MzlCelZDQkVMeWJib2VIdVRLUFVZdEgwTUd1NnROM0Nn?=
 =?utf-8?B?QUtxMkdrWEU2ak9WaytyUkE2c0QvZVl0YkhaOFpwaEZYLzZaeU5VaFJRV09z?=
 =?utf-8?B?TWg1b05hdlorUEV4ZTFuS3I1UTU2bi91bk5yV2pWaGVKTVdEUkR4bERjVkMz?=
 =?utf-8?B?OEJSWi9vemxoNUFxcHRMNklHOWVMbDdVNTVEOEhnY0ErVnVXTWxLL3dWUHZ5?=
 =?utf-8?B?OGVpUDZFc1NnU29GWlV0ejhiT05LUXBZLzdiam5Nanl2cUc2czRhQWlCRllh?=
 =?utf-8?B?T0p5cHRaaXIwUnd6NzZUVm1nRmh6USt0cFZFSkNmOG92amJNTzE5RkVFc25l?=
 =?utf-8?B?bzJRQ09Cc2dEMUNVMHNGeExzc1FTWS9qdS96NGdIUEd1OTVXWnR0VDRHTE9V?=
 =?utf-8?B?QTIwSDhtZThLQ1FNeFJvN1Q2ZktIbkpYcWV1bmNnampnMjB3RjkyUzg1S0V5?=
 =?utf-8?B?b3h0R2cySlhLcXpubG5kak9JalBSM21LbkJ3YjBFa3luMEo3L3laREtNb3pR?=
 =?utf-8?B?ckJPUnNacXp3RFdUYXVJSTVGT09KZnhyMEpSV1dSYXByY240c3pvZWY2VWRQ?=
 =?utf-8?B?akp3SzV0a2ZMN0F6bUJFN2VacDI2TytvNmNsQlFCVVVKNzZXOURpNEwzaWVu?=
 =?utf-8?B?a2dUZVhxa1hzL2lJNXB5dXY0bDVPckFrQjY2WGRPbUs3bkJReE9pOVIzRW5H?=
 =?utf-8?B?Z294eEViNHpHalgrTkFjNllkVVIwUWdnODl6eWtoV1piU0hiejJDazkvMlZE?=
 =?utf-8?B?bUZIb2JWdnYxNDB6MGJvUlk5TENTdk94Zkd5djRaWm00MEc2Qk1UNkx3Z3h0?=
 =?utf-8?B?TERCaWlmTVM3NmFlRlpFajc5aWc2a0FFSXFNVDJFakRwdityTHdBYzYwcVZF?=
 =?utf-8?B?MVN5SXJmaEVUdExPUFMwR0lXVzJoaGluM0ZaWFgyL3JaODBsdFdQYTNzbEJH?=
 =?utf-8?B?TU14ZkdFc2hLVzdwM3JveURFejlkeWxBM3dnN3dYSVJDaFdKczR0ZVhNRkFW?=
 =?utf-8?B?NGY2K2ZYWElwY1FId3lhTUdQcWJXelU0WVhoZEE0RnIwSmVEVHZtbFdETW9S?=
 =?utf-8?B?S3Y0RU5qTnlLcnRHMG5HT2hnLzZ0NUwzd09Sb2tlOXgvNG5DVTNyeDNkYm1q?=
 =?utf-8?B?bUJXUG05a1lXS3NWcWl6Q1lzVVlZRGRVeFZ3SkxmRjQ4NnhIbHlJbHJiSUcz?=
 =?utf-8?B?SjNFeE94SFdJTEZzVjhDc3pLQ1N1Rm5yd0hRVHZmc1Y1a3dDS3VVMmdhaWwz?=
 =?utf-8?B?R0FLY1Z0YXRqcXVpc2ZCOUp1MnJmT3U4eDNtOWFMM1phMEd4T25ZSU5rK05i?=
 =?utf-8?B?U1p1VW9qZkdraGh2bzdwSG9qTEljd3pTeVYzbDdlcXV2VnNCd3NoQklYa2F3?=
 =?utf-8?B?UTMrSGZxMWVFcHI5TE02OHJMQ05nUTZVZDRwWEJuVHRxUzBrUURhdkwrOFhj?=
 =?utf-8?B?bW9EdTNKc2N3dkFndjlkZDNBVWhwOEluL2R1SFV0UERyTGdFQ2kvU05DbTE5?=
 =?utf-8?B?OWQ3V08rZDVNaitrMzBYbkYzT2tFbmtNeVlMR2U0cjV5eFQzTjJhS0ZIbm1D?=
 =?utf-8?B?UTZaaDRpR2c3VkZ6eFlJWXB3dU91dXYxZW8xck54ZUJkb2RpWW5IN2NrZkxn?=
 =?utf-8?B?SXBTcjlyaHovc0w5OGxmYzQwYS82dTNITVdOS2daaFZVaEJ3Vjg4S0dkZU9M?=
 =?utf-8?B?MWFNWEJxejlOYlVQZituTmxCMG5Pa2o1RnFLYkZIZGdhUktwZStKMXQzbVlR?=
 =?utf-8?B?N0RDOGZtNVhTV0J1WEVXUklXdmlDMEJYakI1SGo3dnJYN3RxNSt1dU9teEJq?=
 =?utf-8?Q?urImWoMn3/EpG17UniTBMFw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CZpwRgjjSSRleKVWJPoPgJywwBor73QJptab2/XUkKMldevrNLNHpTKVOeYxRbjtwiPGQemduaOnbT/Nfs3Yoe24TBo+HRMi7Z2t/E60sytFCJG7hj9xMTHt7efvb0RKTcT10uxqv40J1zrJ92q/jS/fwXGtLvjulACJSVmYoK0uWyOiZ59+RTushnQxFvtkDzxvigkXBhoi3fcptqOy3voIC9+vFkZeCT+/0A4o9c+RBR8rFzJfTtXhTiJBSugr9DlTB1gApWpM/XlzgZCf+SUToz7SzbL2g+9MEItaWjyHKk0oZThCGJmVdxtOeDF5on+9geOUMkWZYCqDzeN7cUi86JebC4KaI23UwQCL1eaVIzpwXXmbgWCcnDY+ifHa6az8HbvoakVK0SJwzry1O/6UmAvwUs0qkBtAQ/r3ZvyZDjb6ixNJb7HtMGE52XCWxeST492RAIlmM2f4I96CF0CzSgCwliqHC4CkDTX4VrlF+mQq7f6ydFrWQX1muoLPe5+WAqzlVgJiqVu2yCjUfwD4UWANcT4vRCS5TEnsBGJPRIuYkTXf5rRQ7y8reIty1lFP/bCBRmuFpnXUlopmHbtraC+Eeq3YUuv8g4Wx1rU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9aeb414-c565-45f9-b4bb-08dcd3f7b0e7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:26:36.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YeRM7tRz8rpGDDoCBoRJp8Anlm8/PSSZzOp3YnjeofTRJ5xLmFGQ1F17R81QlSFg7AbQR/qNWi3ZTPGUKutgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130094
X-Proofpoint-GUID: 9kanW7EiWE_9NwVYcaoy7DAGrjqis4K1
X-Proofpoint-ORIG-GUID: 9kanW7EiWE_9NwVYcaoy7DAGrjqis4K1

On 12/09/2024 20:08, Stephen Brennan wrote:

nit; needs a commit message, e.g. ELF section names will be used in
DATASEC encoding; as well as getting the section, optionally retrieve
the name.

> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

I think one small thing needs fixing below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  dutil.c | 9 ++++++++-
>  dutil.h | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/dutil.c b/dutil.c
> index 97c4474..4e83d59 100644
> --- a/dutil.c
> +++ b/dutil.c
> @@ -207,13 +207,20 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t
>  	return sec;
>  }
>  
> -Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)
> +Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out)
>  {
>  	Elf_Scn *sec;
> +	size_t str_idx;
>  
>  	sec = elf_getscn(elf, idx);
>  	if (sec)
>  		gelf_getshdr(sec, shp);
> +
> +	if (name_out) {

nit; before we were directly returning sec, so if it was NULL that was
for the caller to deal with; now though we're driving on assuming it was
non-NULL here. So I'd suggest changing the above to be something like

	sec = elf_getscn(elf, idx);
	if (!sec)
		return NULL;
	if (!gelf_getshhdr(sec, shp))
		return NULL;
	if (name_out) {

...
> +		if (elf_getshdrstrndx(elf, &str_idx))
> +			return NULL;
> +		*name_out = elf_strptr(elf, str_idx, shp->sh_name);
> +	}
>  	return sec;
>  }
>  
> diff --git a/dutil.h b/dutil.h
> index 335a17c..ff78aa6 100644
> --- a/dutil.h
> +++ b/dutil.h
> @@ -328,7 +328,7 @@ void *zalloc(const size_t size);
>  
>  Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index);
>  
> -Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx);
> +Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out);
>  
>  #ifndef SHT_GNU_ATTRIBUTES
>  /* Just a way to check if we're using an old elfutils version */
