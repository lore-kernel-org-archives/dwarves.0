Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2FC3126D0;
	Fri, 29 May 2026 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061851; cv=fail; b=QT62BOQ+3+WDe7TcXJdw8wMyyiDUg1V+Je/LlknrEBA8pWrr8f18fpu0VfRhIG48FOO6HTdEDX3/YVZpr6Vt0Ooc4VdjXseSZpMXUeZa7J025uPnEfNnaO2mCUnqiyuBYXQP12RMydu9wDqElgy+mEZmrclYitOimGTU1j1EGBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061851; c=relaxed/simple;
	bh=y0Jcxuabc+Dsr04sjhwzI3reOdIJElRToLuMbhQnr0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E/kU3qwNMoWQ3C5oxN9iGNlMOmybIDc7z/XEnRuNilD7jghUzzg3IChNOq98D9br5fGKaEUAFIWi5LWJ/jU967FyrsXxxeFMrc96ndkbJZ0UlsLTb+J/ww4DMG9KzcI0HxsergcgtIIHV9m0ThL0txgLfPgLg6lPSQUtFDQr13k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g0PLzqX1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PJEUzDXO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g0PLzqX1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PJEUzDXO"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6fWDC986346;
	Fri, 29 May 2026 13:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+jFDCImH62dc615sliYL4/mFSk+SsTBTn4/6vXYPGP4=; b=
	g0PLzqX1pMfcbyOQcsXZKYd8uafdQNcHu/u72VatAv+BYPXbpDk7ktgp4kfYeZst
	xn+jkcQ3JD5bJ9Jj0Z+udWcPvsYhWAQepUNBCtxJK+PxWNkKCmHXUJ8MwQofG5A4
	MMmVZ1dpcrhu5QUfLTo3jHXSMkl2+M/e8uUqMpJG294IMfjV4fXLCDewWYuO/h+T
	WXxZ0MSuA9PgDPrAtSpRZo5f+BIMMsTn/BoA0LrGFa2cZZBoLyPgxsL+jHyynP2L
	tnOTG/kr8VfzB/meF4rSgE82MMr8gbIpmIHEHKdaaT0DP0e8wPkAv+bzGpHxfbJN
	LTPZOrFs7N+b7Zw0aoMkBg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ee7wpaqhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:37:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64TDYj4o003680;
	Fri, 29 May 2026 13:37:12 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4edjx1negh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:37:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixpYXF7GnJeRkF4IyRxMOzvKmzpVaSuIylUoKcU7US+BXoH4dy75gTBnZHULoEXVrPXvXQlL1Td5PttKSJ/1I2nGzg/WZqtARPcEFhvfOJRZClXyUxMQy2+YLR+fZFIV53w1NXrng/ENgL6CzUSBcM0JfqnP8lSbxhUAIw8BvoECYcZelH1go3O5CiZE8O5ICMiDTHm4e9SDzv3FwRrnhfBKM3pOkNk3h3jROJpjVi+fNaJZBSRdXJzJerE1tIK/ze6QraTl0stQZr4CRbiRB0tKTJS/XQ0mXNyR3SGULDzRufFy9lOwRN6ggk+3DZV9XyKZepKmbpCUhOcXcz9mVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jFDCImH62dc615sliYL4/mFSk+SsTBTn4/6vXYPGP4=;
 b=GRb4MSHaw0l/7nofE4ul/xXn1+aQiN7TeWDS6zUELo8AQ/lQPjEBdev4Flo3iIRb94MJjS6C/tdohW3ompuaLDFuyHkvoFFr8Da+OsdGOCOOQBVxhIF0XbpEJ6I0qw0Sq2sMwoh1iGjb8IbkucuDsol5+8TLrFGZP+0TZrpSL6GQp0V4/Lzlso9vDD49mOpZIU0NDrEeSbaaM5ujyqQyaSTLwZFbhkXmWEFttVAAvnMqraHlEXxiVux116jJqPWsikqU1+KUIWxffQ/q/k5EJzsxB6q15qoDIDs5u0PacGA4nfmlBzITu/7ZYcPraNan5kSYBZKrV5dyya4Xpm1fFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jFDCImH62dc615sliYL4/mFSk+SsTBTn4/6vXYPGP4=;
 b=PJEUzDXOra9XF9a6CBmsltd99V/ewnxFEnVHWwMOydmOJyu4z5UowHR07WktbDOgKbQeHugrps1xVDBFLp53+n8A+BUh+HTu/9mpL6vnD1qZtDwLuljPFDsLrctugeYxW9aCuUogXpmS6tIGyWUkszsIEPKbga+pvBiCNdbifeE=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH0PR10MB6983.namprd10.prod.outlook.com (2603:10b6:510:286::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 13:37:07 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 13:37:05 +0000
Message-ID: <81094fe9-c77e-4f84-9449-e7c9bb29fad6@oracle.com>
Date: Fri, 29 May 2026 14:37:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PAHOLE Patch v2 2/2] Add support for DW_TAG_GNU_annotation
To: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, acme@kernel.org,
        jose.marchesi@oracle.com, David Faust <david.faust@oracle.com>
References: <20260528223616.2035618-1-vineet.gupta@linux.dev>
 <20260528223616.2035618-2-vineet.gupta@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260528223616.2035618-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0257.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::29) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH0PR10MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: d13ca861-888e-4ed8-796f-08debd875fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Vwyd9uhmMRopDk8MIlAVfZFjJK7HRkkUddnrnzibCURhi+XbPfM0PtN7SRLroEeCTB1yEmxnzB0SRP1BKGgD25vNri7ODx9nV+wSMDi2JzZ4Uj3hcwY+6k/TydpIOlyDE6w9sGNf/D2iM/oAdADlao8A6rO9IInrDoeiode8tLu2QXr5pD7Ck97/53vQiDRIKQSS9kGFa65fMLoZT/EmLdAQpcsoG/pCJsypNqF48xi0HQeJB/llARehSx1b3JarDv4iH8rhmdPncf80wRmrH/GJgQOJ9UeBK5gPoHsjwGnc5WwLszaM9XK/iIJ6FNsL/zeODT0ZGp2Fjk3znmYeRUDwR7v+2nY4sUpPbbOEWhqjY/ohX5gnpjE0NN8YD/yMt9OACp16XifEaWBzx0U0prI2HoLB8Eo4vjqZwQz7uVeavc5X64ncSkWVRMSn32XAr0MVKTICXtWr1OXx2AND/aSTeD3TZAuHFEcF+g4AKN/qC6bDaiU5TSMnp1YcKnMtCyQhso6TtfgXcBFRywvmzoVGYenZRDWoFSgzM1Nn5qyS8CQLmd1Fk1dc/CBBMPyu2fHZWN8QmG/+owaUuyceOnh05U7EDepabw6L8VLngulFvmKC5J+RlOXRMqIlsqbp8ppg39BVYfxKK8meQFdYqwZvt3UNXp4JoJ3KjGG8Dibmzir9FTCKQ8GAMP9n0Gd72wG09ko+I0g2P2HeWegrQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFhrLzlwWVdrNzdEQ3RpSm5pT1Ard3JVUUozUmN6b1dyMkt3R2IrY2FDZFBC?=
 =?utf-8?B?dE16R1Urb0hDbytEcVZOZDQvc25xOWEwTWpIMVhIeWpUdmxNdnpWNGhLZHZZ?=
 =?utf-8?B?Nm5xL2JHeTB3cmpFK2IvR21tWEd0YkIxcVM1SUlnc2xyaDZBbFEzOTV6djIr?=
 =?utf-8?B?bEl6T2xRNGNzNndkM05OeGRuZ2VRczFpbWFhaldrVWwrSDcvOG5FY3Vhb1l6?=
 =?utf-8?B?bEJXbnArZXAyVGMwanpkdThER01kb3pSditPMkZvTGxhQWtTNG9JOEdQU3Nk?=
 =?utf-8?B?OFBqQmpZQ0M2K0RqTllwaDBQVzdmeUxNbjlIZVZJMnpEQkxkZ3hYa1NVRkhh?=
 =?utf-8?B?alAvYms0RzBSVXp0dzZ6cWYvK2xxLzNsOTRySW9XWlgxR2YxcEs5bDFPVzcy?=
 =?utf-8?B?SkY2Z3BlaGxQd2lJVzR0aVFYTnlNaGpCSDUwK2kyZCt0RHMrQU1yWUdSMWVj?=
 =?utf-8?B?QTRqYWxiZForcWRnaCtRajdiK1pZc05nUXNCZFdid0REajQ1bm0zQ2lsU0xW?=
 =?utf-8?B?cjl0YWJpN0NoY1E1cXNaK0lZcjVrSWtMZG5kU3dFZEJwN0tySnJKaW8rTWp2?=
 =?utf-8?B?TEVQeTJIN1RFNG5yN1FVeFRjbFkwSURMcnJyTzgvalhzNEdBdzFuVkdDMXFG?=
 =?utf-8?B?azBtMkgxaDg3eC9iM0NsNTI5czJvbVNBaHNObW5HYWtTRXc4amkrNzIrTS90?=
 =?utf-8?B?dG5udmd5Mm1rbGJucjNIeU9pZWFWcHVqMk9Ec1NTTlcySU9hZG5zcExyem1E?=
 =?utf-8?B?K1B4Zm50ekVIM2g0UnJGdmtobUFtVkhJRk5NUDVidStsVWFaaHFPdVNFaTJH?=
 =?utf-8?B?eHY0NjlOMGR2L0VhLzBkYjU0VFIvOGFYNzVka2tOQUwrOUxxRmdkZTVIVDNm?=
 =?utf-8?B?WWQ5eDdnTVRjQjhlUXhXWW9nM3JjUnpKejJpRVA5VDF3ZGNETmpwNjNxbjFM?=
 =?utf-8?B?d0dtVUVHS2FFM25TU2w1VWVTOTdhMkVsckJsQlZjUnlrWlEwSmFyOUk2NVVl?=
 =?utf-8?B?N2o1NzdFMkN5bCtFSVJ3UzF3Ym9DWVZjeWtxL0RFUVpvMEJNQVBuTVd3NFov?=
 =?utf-8?B?YnNIZWJTV3QrSi8vK0dsaFoxUXZxd1Y1MkJLVldOR0FuRE4wWVd4M3c4Y0cx?=
 =?utf-8?B?RXFKbHFaRkJlSXJyT2cvSWhsQWh2N1duU0RrSjRQR0JsN3FPeVFQM0Z5QXdU?=
 =?utf-8?B?NTk1aEREeUNTZTRGaHJ6VVNlVlN4ZzZaenFuUEpoL0w3Qkl4aXcyVVdkTXVJ?=
 =?utf-8?B?OHFWN09iczdnZmg2N0ZIaU1NYXJ4T1NJZWxDS0EzVkVkUHJOc0tpSU1NVW5C?=
 =?utf-8?B?Z2lVWUJIYVZRYjdlRmJRSjVLZ0ErU0x4UnVwM25JOEViUytaMDRUSmg1V2k5?=
 =?utf-8?B?dWd5KzNXN1E5MVgrL0RwZjhNMy9FZnZ2MWVZNGhmcnp4dG5tNmdpSXp6cmt1?=
 =?utf-8?B?cmFUM0ZZSHY1bktNaVc5RG11cmJ3V3N3ejYzbzJhT1M1R28wYlAvSUdxTGJs?=
 =?utf-8?B?VUZUQy9MVnNoeHFsWVhrWWVWb0drUTVnZVBpM1dDejBHVXVrNjZQaFJhd0lo?=
 =?utf-8?B?cEtsMnZtdXZDakZJanRFK2tzcDRKTGxIRDZ1bm9Nb3pZcWtMblRzVVZaekxF?=
 =?utf-8?B?YkxLZVUxWXlwcG5tRTMxUUtrK3ZCM2ZVZHlIZXQyMi9Odjg0clk1RTFzck9j?=
 =?utf-8?B?UDdoTGFOWVM3bzhmL3haTTBGbDIwQ2J4VSt1WTR3anhHOFI1UXlOSGxDcWdC?=
 =?utf-8?B?YThEaXdKMHA1akp6L21zdWUrRm9pWnlZVkNnWHFVUklIa0ZoU2tCKzRDR08z?=
 =?utf-8?B?ZHhTN3FlZUxGNGlCdkYxa0JMalB1ZUJXQVppcThJeXdpcEd3WkdzVDRLTWhn?=
 =?utf-8?B?UVQwQzUvSFcxSlNkMXVUOFl3U3kvV3kyK0kxK3prV014d3gwU3JlWXVzNHhU?=
 =?utf-8?B?M2tobHI3blduNU93TVNiN1NEWGNlcWVISTh6ZG4rNEt1ZGVJOFpqdnhNemNL?=
 =?utf-8?B?Uk5aVDlnNXVvS1pXQmdWWUxybzFZc3FIZEw4K0V6L3BFSFZlcHp1em05RFFa?=
 =?utf-8?B?aXZta2RuLzRSMTF4VXRjY3VyTlBsVFVSUjA2ZmRBMHZEZ3hNTGIwQTBQNUhs?=
 =?utf-8?B?cGFOZ29UdWhZOEFTbTJtTklQT3Q1M0ZhNzlBTTNnTmZ3bnpTd1NZeVpXL0Iy?=
 =?utf-8?B?TFgzVW00R3o1SExnaVlrMnVpL1U1eUZKUHA0MVNHOFN3THEvd1NQN3R2US9P?=
 =?utf-8?B?UnhQNTViT1BlaTZWWDNNcjNubkZ4aE9EYkNkS05qUEdFMGxidWhjbHZHb0E1?=
 =?utf-8?B?eGwrYTQwNDhQYm5wWWUwN21GcWlHNEZqV2ZkdW9sTU1LdXpwOVBPdz09?=
X-Exchange-RoutingPolicyChecked:
	nQy5wLNTOAn+64VPGCL8imJVpjnPAfIkELOskRq+YwBfGgDrgP8mAMvyTFvY9dxs4XUDSE4dE6SEBD9BlDD52St9PNu6lYfi+lTSx4MnQYTKjjQIku1BXy6NXR0xsDqca8wyhNBgk+1k+HZgd4RJabKFZJn5fawd26f15NqtJJ23ofkuMyp2HLp5GbRAsGEmCqe3Mqy4YnK8mTQrxIYmOFLgE9qXxqB1X8lA00HuPcfRYLyKt96XZ5fzvDQmJaBMSbAbamie8ZzAJDr4QRUprS5UVFigqqx3TGjWE9PFL+eM/m9zSxV2wSdn6M3Av6Fh5NyI0rzKwqhnp8Ii8DHOGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wZBA2W7qSWqc5vx4cUJO51PejAlePh9D8mNrJfOs9LpsGIFjKverMdxaj5K4FX55U69NgKgOMlwsfeJbljv1LuscyogLX8lTCE36ussr32RBSwba0uVSRxw+Ywjln1xA3W2x7xGmeSYw67A5Nyoz37ngw3MDp7B/1rdZ2+mizVDz8d17z7ahWPdOgxxKdJ0Ym+UYpJhtvzvNZz3svS7AEdQRDDEzX10y1ceAKkNsvzfqZvVioreK88xDotoTruC5qroyOmGER5suIbwhCp2Ng+yg4vtRF7EsUf8h77XYOfCvPARMGlTa69sQo/MfkoqT+d4G2zmNAvMhfHVjViNmv/ZLKUfk1OnFXzHYi+8N6BxNXqapBAL1ZnmGtApwJXOJXPydy/atpCd11zeA0KwCiH0Y0d5fNtiStbzwUxC0AXvPRd8jCY/eEqaH5ZXW/xJlQtUTYXPLXsraLbBgH/Q9E2pVlCWmvgWI0wyoXut9Wkn5tiCRQyeuqD1JBo7JiXv2Hju/K5A4e5FwrK9mxZwujfgTMiyZHerTNhRU/PQwTvEgJiCkfJCe3ClsMs0ugJek80QZOxamo2srNKzX60tfMLrZ6PL9x8kV+zxO8pNA+XA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13ca861-888e-4ed8-796f-08debd875fba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 13:37:05.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASRlYt+e0AAN920QktNhgdd4N750ZH04oFmIxhzGivVxIJXwzkJrCmW4pRpvvjgTnECkNRDohln9SLr01xhDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605290136
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a199689 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=bxhwBxYZw2JXNvDWF2YA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzNSBTYWx0ZWRfX2azUVoRDJuuM
 HFRnlTayek30gsVd+LizYcJCv9XOFjqR7RECsoSf60kWw1biuFqo6NPS6Tk4/OdKKL6bkyb07x6
 U8bOGfJUn/8RGyyTiXHs57nFGCgNBrtjq9EOC7QKIZf/REugjl14hN2T0aY3OS1eBWKL4Dng7wV
 kicVA/QRazWU5kR0yVQSMfL0kHTfLoWTOjLFa2Av9iRVtkeSSq43m9OV0FWOe9N3VCnV5pbYw5P
 ZxQb1CQUXqbTpja6SFnsnFzBc2+gL79fseyBR3vhLVhsbxmUdQW3TG/sc9d6l4XKANax5Q2rkDa
 Z6D2cwtW3zHYiFzS97582xOu4Buw6WC1S6gGMJCJoImVhWflxpkWbHkrpRPflQJFLkmBjiEKaqj
 AfvITc2to/F5TvqYduf/+09t7RPWeoMDDXT19BslRMoIJ6NX3rjGwGJ9WzqbRmLp61YO+bZT4Ch
 BKtTdvMyOKpTsmjVr0w==
X-Proofpoint-GUID: eB2Ku0jIiEhwVZ3Ako6XTjDHfN5wEW6C
X-Proofpoint-ORIG-GUID: eB2Ku0jIiEhwVZ3Ako6XTjDHfN5wEW6C

On 28/05/2026 23:36, Vineet Gupta wrote:
> gcc 16 was first release to support DW_TAG_GNU_annotation and this patch
> enables the same in pahole. Bulk of changes are in dwarf_loader but
> btf_encoder also gains support with minimal changes.
> 
> GCC encodes btf_type_tag and btf_decl_tag annotations differently from
> LLVM. While LLVM uses DW_TAG_LLVM_annotation (0x6000) as child DIEs,
> GCC uses DW_TAG_GNU_annotation (0x6001) as standalone sibling DIEs
> referenced via DW_AT_GNU_annotation (0x2139) attributes, with chaining
> through the same attribute on annotation DIEs themselves.
> 
> Handle both encoding styles:
> 
> For btf_type_tag (pointer annotations):
> - Recognize DW_TAG_GNU_annotation alongside DW_TAG_LLVM_annotation in
>   child annotation scanning.
> - Follow DW_AT_GNU_annotation attribute chains on pointer types for
>   GCC-style btf_type_tag resolution, with cycle detection.
> - Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation in the
>   internal representation so downstream code works unchanged.
> 
> For btf_decl_tag (function/struct/member annotations):
> - Add add_gnu_annotation_chain() to follow DW_AT_GNU_annotation
>   attribute chains on function, struct, and member DIEs.
> - GCC puts DW_AT_GNU_annotation on the function/struct DIE itself
>   (not as child DIEs), referencing sibling annotation DIEs that chain
>   via the same attribute.
> 
> Also:
> - Silently skip standalone DW_TAG_GNU_annotation DIEs at CU level.
> - Update pfunct-btf-decl-tags.sh test to use GCC 16+ when available and
>   now passes.
> 
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

thanks for this Vineet! I'm building gcc-16 to manually test now but I have a few
suggestions below in the meantime. Changes look good in CI [1]

[1] https://github.com/alan-maguire/dwarves/actions/runs/26632028538

> ---
> Changes since v1 [1]
>  - NFC Reduce indentation with early exits (Alexei offlist)
> 
> [1] https://lore.kernel.org/bpf/20260526181818.4159927-2-vineet.gupta@linux.dev/
> ---
>  btf_encoder.c                 |   1 +
>  dutil.h                       |   8 +++
>  dwarf_loader.c                | 115 +++++++++++++++++++++++++++++++---
>  dwarves.h                     |   3 +-
>  dwarves_fprintf.c             |   8 ++-
>  tests/pfunct-btf-decl-tags.sh |  32 +++++++---
>  6 files changed, 147 insertions(+), 20 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 633bc6162ce0..d5af706d7638 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1831,6 +1831,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>  		name = namespace__name(tag__namespace(tag));
>  		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPEDEF, ref_type_id, name, false);
>  	case DW_TAG_LLVM_annotation:
> +	case DW_TAG_GNU_annotation:
>  		name = tag__btf_type_tag(tag)->value;
>  		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPE_TAG, ref_type_id, name, false);
>  	case DW_TAG_structure_type:
> diff --git a/dutil.h b/dutil.h
> index ff78aa6dfd10..abe0e62b412f 100644
> --- a/dutil.h
> +++ b/dutil.h
> @@ -35,6 +35,14 @@
>  #define DW_TAG_LLVM_annotation 0x6000
>  #endif
>  
> +#ifndef DW_TAG_GNU_annotation
> +#define DW_TAG_GNU_annotation 0x6001
> +#endif
> +
> +#ifndef DW_AT_GNU_annotation
> +#define DW_AT_GNU_annotation 0x2139
> +#endif
> +
>  static inline __attribute__((const)) bool is_power_of_2(unsigned long n)
>  {
>          return (n != 0 && ((n & (n - 1)) == 0));
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 8fc9a6794f2f..a3d51e30703c 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -908,6 +908,12 @@ static int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t b
>  	return -ENOMEM;
>  }
>  
> +static bool die__tag_is_annotation(Dwarf_Die *die)
> +{
> +	unsigned int tag = dwarf_tag(die);
> +	return tag == DW_TAG_LLVM_annotation || tag == DW_TAG_GNU_annotation;
> +}
> +
>  static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
>  			       struct list_head *head)
>  {
> @@ -943,7 +949,7 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
>  
>  	die = &child;
>  	do {
> -		if (dwarf_tag(die) == DW_TAG_LLVM_annotation) {
> +		if (die__tag_is_annotation(die)) {
>  			ret = add_llvm_annotation(die, component_idx, conf, head);
>  			if (ret)
>  				return ret;
> @@ -953,6 +959,32 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
>  	return 0;
>  }
>  
> +static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
> +				    struct conf_load *conf, struct list_head *head)
> +{
> +	Dwarf_Attribute attr;
> +	Dwarf_Die annot_die;
> +
> +	if (dwarf_attr(die, DW_AT_GNU_annotation, &attr) == NULL ||
> +	    dwarf_formref_die(&attr, &annot_die) == NULL)
> +		return 0;
> +
> +	for (;;) {
> +		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
> +			break;
> +
> +		int ret = add_llvm_annotation(&annot_die, component_idx, conf, head);
> +		if (ret)
> +			return ret;
> +
> +		if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) == NULL ||
> +		    dwarf_formref_die(&attr, &annot_die) == NULL)
> +			break;
> +	}

the pointer tag handling below uses bookkeeping to track visited dies; is there a need
for that here too? maybe a bit paranoid but perhaps we could haul the loop detection
logic out and reuse in both places?


> +
> +	return 0;
> +}
> +
>  int class_member__dwarf_recode_bitfield(struct class_member *member,
>  					struct cu *cu)
>  {
> @@ -1596,6 +1628,8 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
>  		return NULL;
>  
>  	tag__init(&tag->tag, cu, die);
> +	/* Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation internally */
> +	tag->tag.tag = DW_TAG_LLVM_annotation;
>  	tag->value = attr_string(die, DW_AT_const_value, conf);
>  	return tag;
>  }
> @@ -1638,19 +1672,21 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
>  {
>  	struct btf_type_tag_ptr_type *tag = NULL;
>  	Dwarf_Die *cdie, child;
> +	Dwarf_Attribute attr;
> +	Dwarf_Die annot_die;
>  	const char *name;
>  
> -	/* If no child tags or skipping btf_type_tag encoding, just create a new tag
> -	 * and return
> -	 */
> -	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0 ||
> -	    conf->skip_encoding_btf_type_tag)
> +	/* If skipping btf_type_tag encoding, just create a new tag, return */
> +	if (conf->skip_encoding_btf_type_tag)
>  		return tag__new(die, cu);
>  
> -	/* Otherwise, check DW_TAG_LLVM_annotation child tags */
> +	/* Handle LLVM style annotation tags if present */
> +	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
> +		goto check_gnu_attr;
> +
>  	cdie = &child;
>  	do {
> -		if (dwarf_tag(cdie) != DW_TAG_LLVM_annotation)
> +		if (!die__tag_is_annotation(cdie))
>  			continue;
>  
>  		/* Only check btf_type_tag annotations */
> @@ -1662,6 +1698,47 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
>  			return NULL;
>  	} while (dwarf_siblingof(cdie, cdie) == 0);
>  
> +check_gnu_attr:
> +	/* Check for GCC-style DW_AT_GNU_annotation attribute */
> +	if (tag != NULL ||
> +	    dwarf_attr(die, DW_AT_GNU_annotation, &attr) == NULL ||
> +	    dwarf_formref_die(&attr, &annot_die) == NULL)
> +		goto out;
> +
> +	Dwarf_Off visited[256];
> +	int nr_visited = 0;
> +
> +	for (;;) {
> +		Dwarf_Off off = dwarf_dieoffset(&annot_die);
> +		bool cycle = false;
> +		int i;
> +
> +		for (i = 0; i < nr_visited; i++) {
> +			if (visited[i] == off) {
> +				cycle = true;
> +				break;
> +			}
> +		}
> +		if (cycle || nr_visited >= (int)ARRAY_SIZE(visited))
> +			break;
> +		visited[nr_visited++] = off;
> +
> +		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
> +			break;
> +
> +		name = attr_string(&annot_die, DW_AT_name, conf);
> +		if (strcmp(name, "btf_type_tag") != 0)
> +			break;

should we "continue;" here instead; if we encounter a non-type tag annotation
might we miss subsequent btf type tag annotations? might not be an issue today
but might be more future-proof to continue here maybe?
> +
> +		if (die__add_btf_type_tag(&tag, die, &annot_die, cu, conf))
> +			return NULL;
> +
> +		if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) == NULL ||
> +		    dwarf_formref_die(&attr, &annot_die) == NULL)
> +			break;
> +	}
> +
> +out:
>  	return tag ? &tag->tag : tag__new(die, cu);
>  }
>  
> @@ -1690,6 +1767,12 @@ static struct tag *die__create_new_class(Dwarf_Die *die, struct cu *cu, struct c
>  		}
>  	}
>  
> +	if (class != NULL &&
> +	    add_gnu_annotation_chain(die, -1, conf, &class->type.namespace.annots) != 0) {
> +		class__delete(class, cu);
> +		class = NULL;
> +	}
> +
>  	return class ? &class->type.namespace.tag : NULL;
>  }
>  
> @@ -2051,10 +2134,13 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
>  			cu__hash(cu, &member->tag);
>  			if (add_child_llvm_annotations(die, member_idx, conf, &class->namespace.annots))
>  				return -ENOMEM;
> +			if (add_gnu_annotation_chain(die, member_idx, conf, &class->namespace.annots))
> +				return -ENOMEM;
>  			member_idx++;
>  		}
>  			continue;
>  		case DW_TAG_LLVM_annotation:
> +		case DW_TAG_GNU_annotation:
>  			if (add_llvm_annotation(die, -1, conf, &class->namespace.annots))
>  				return -ENOMEM;
>  			continue;
> @@ -2360,6 +2446,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  				goto out_enomem;
>  			continue;
>  		case DW_TAG_LLVM_annotation:
> +		case DW_TAG_GNU_annotation:
>  			if (add_llvm_annotation(die, -1, conf, &(tag__function(&ftype->tag)->annots)))
>  				goto out_enomem;
>  			continue;
> @@ -2408,6 +2495,12 @@ static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struc
>  		function = NULL;
>  	}
>  
> +	if (function != NULL &&
> +	    add_gnu_annotation_chain(die, -1, conf, &function->annots) != 0) {
> +		function__delete(function, cu);
> +		function = NULL;
> +	}
> +
>  	return function ? &function->proto.tag : NULL;
>  }
>  
> @@ -2469,6 +2562,9 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
>  		 */
>  		tag = &unsupported_tag;
>  		break;
> +	case DW_TAG_GNU_annotation:
> +		tag = &unsupported_tag;
> +		break;
>  	case DW_TAG_label:
>  		if (conf->ignore_labels)
>  			tag = &unsupported_tag; // callers will assume conf->ignore_labels is true
> @@ -2494,7 +2590,8 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *co
>  			// XXX special case DW_TAG_dwarf_procedure, appears when looking at a recent ~/bin/perf
>  			// Investigate later how to properly support this...
>  			if (dwarf_tag(die) != DW_TAG_dwarf_procedure &&
> -			    dwarf_tag(die) != DW_TAG_label) // conf->ignore_labels == true, see die__process_tag()
> +			    dwarf_tag(die) != DW_TAG_label && // conf->ignore_labels == true, see die__process_tag()
> +			    dwarf_tag(die) != DW_TAG_GNU_annotation)
>  				tag__print_not_supported(die);
>  			continue;
>  		}
> diff --git a/dwarves.h b/dwarves.h
> index 5ec16e750e83..42b8e39aa2dd 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -670,7 +670,8 @@ static inline int tag__is_tag_type(const struct tag *tag)
>  	       tag->tag == DW_TAG_volatile_type ||
>  	       tag->tag == DW_TAG_atomic_type ||
>  	       tag->tag == DW_TAG_unspecified_type ||
> -	       tag->tag == DW_TAG_LLVM_annotation;
> +	       tag->tag == DW_TAG_LLVM_annotation ||
> +	       tag->tag == DW_TAG_GNU_annotation;
>  }
>  
>  static inline const char *tag__decl_file(const struct tag *tag,
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 1ec478c2a027..a514d7e98923 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -140,6 +140,8 @@ const char *dwarf_tag_name(const uint32_t tag)
>  		return dwarf_gnu_tag_names[tag - DW_TAG_MIPS_loop];
>  	else if (tag == DW_TAG_LLVM_annotation)
>  		return "LLVM_annotation";
> +	else if (tag == DW_TAG_GNU_annotation)
> +		return "GNU_annotation";
>  	return "INVALID";
>  }
>  
> @@ -658,6 +660,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>  		snprintf(bf, len, "%s", variable__name(tag__variable(tag)));
>  		break;
>  	case DW_TAG_LLVM_annotation:
> +	case DW_TAG_GNU_annotation:
>  		type = cu__type(cu, tag->type);
>  		if (type == NULL && tag->type != 0)
>  			tag__id_not_found_snprintf(bf, len, tag->type);
> @@ -731,7 +734,7 @@ static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_t id)
>  		if (id == 0)
>  			break;
>  		type = cu__type(cu, id);
> -		if (type == NULL || type->tag != DW_TAG_LLVM_annotation || type->type == id)
> +		if (type == NULL || (type->tag != DW_TAG_LLVM_annotation && type->tag != DW_TAG_GNU_annotation) || type->type == id)
>  			break;
>  		id = type->type;
>  	}
> @@ -936,7 +939,8 @@ print_modifier: {
>  		else
>  			printed += enumeration__fprintf(type, &tconf, fp);
>  		break;
> -	case DW_TAG_LLVM_annotation: {
> +	case DW_TAG_LLVM_annotation:
> +	case DW_TAG_GNU_annotation: {
>  		struct tag *ttype = cu__type(cu, type->type);
>  		if (ttype) {
>  			type = ttype;
> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
> index 35884b4e8687..5fdddc09f179 100755
> --- a/tests/pfunct-btf-decl-tags.sh
> +++ b/tests/pfunct-btf-decl-tags.sh
> @@ -13,17 +13,21 @@ trap cleanup EXIT
>  
>  title_log "Check that pfunct can print btf_decl_tags read from BTF."
>  
> -# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
> -# in upstream version 16.
> -# UPTODO: add a check here for that.
> +# gcc 16+ supports decl tags via DW_TAG_GNU_annotation (gcc commit ac7027f180b).
> +# Use gcc if available and version >= 16, otherwise fall back to clang.
>  

Is there a reason why we couldn't do both? We'd ideally have CI test both clang
and gcc so wouldn't want to skip one or the other really. I'd suggest we lose
the elif logic below and test with whatever is available gcc, clang or both
ideally. We can fix up CI to install gcc 16 later.

Also I'd suggest move the test to a separate patch. Thanks!

