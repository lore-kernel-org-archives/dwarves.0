Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252352C80
	for <dwarves@vger.kernel.org>; Fri, 13 Sep 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226788; cv=fail; b=QZKpNi6oGiXR9BrMGq/bOdk6zfWKTiSSoAUK0MbmUKg7BspLw2CmsVVYMGPgRGLT66wN9DCeK8uSRWiPIf3mORA7gZeOmsINhS2jzeuR+QXcT3QSIVEWi/BvaKY16+PIdnctvIeRBorK8R/ZLgEY/hqVLVpyHDqOQiqhgLYWVok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226788; c=relaxed/simple;
	bh=+4wxn1YHwqTsKXS5crt99TiqLMt2NrraCskCA8NRegQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BtKu6Iaga0onVGyjowq4r+5FcjiFmhQ84pPuRNiEM+G/7cCjPFRwsHeUdI0aepB6VQUUg2IyV6sMf1pdoBjXHIOW6/T3fG6p01w0d9lOpqW3lEqByJgxDjvdW1kvE5JNd/wKyKsT9P2tf5kzrNWCOmY4nCRuqjGF0No/SYQMhTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gVHOZNej; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RTB3Ky3K; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gVHOZNej";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RTB3Ky3K"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YUPD003541;
	Fri, 13 Sep 2024 11:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=L8qlqmi4hILKxZ9NIyDavrFfomne8nJmSwa3i5TLVLA=; b=
	gVHOZNej13it1j1pbYqZtG3CjI1xZZb7jlFDNklouQlQj4wGe1tKiKaDWUvan+py
	6vZxQeRqxRPpLFOYmRi1U+yeIH/pU6njyHgtcAob7/BfAMFZdeA922Bx79kYJOyS
	JbU9vJ0XHT1kGtMVZz+uWd1nPctPCuHHSVxmSKvPiVOj/+Ep7yt6VY9y5vl9Qzb/
	BAixGjEjCzfCS8r5vrVBFclanc8WVSyUjTDI8iY6zzGvjQWnSyQL74hBkLSNy2wC
	/Rxi22AEx/pERNkx2NRPWIq7oolM7OvbVZfFNDxw9gq7Rmafx67vkA199o5TABcv
	eMenLakFGAdHpotx6s9Bqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbuw3nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 11:26:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DB9Qnn040820;
	Fri, 13 Sep 2024 11:26:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9e7eme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 11:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDEt+sE92c8gkuMfQnFPk2YcEJAzTtQr7ikqCQTA8lG/eZa1uM8Gx6tKhhmjs1y9kbBLg8VFt3YWslEjjq3e/Ih7X7HbVcNnFHhtqqjdfNYRizmDuta4WgjeU9+LVGwf23qSxNC0xfhriI/74LUTV5A9IDkpGXPx+9eV6Xdat+KMMLcNjXB/S2viyqycxBU32DTQnYpZk9lI6ViUHe9iIPOkDJTLnkt5pp+p/50WAwbLBINgg3/4KmGmSl/7/PQDLM3qP3v6WeHZdj24GkDsgIaR7E6Y6KRdXQNByJQsNmIHrUYhJVZ5aXhKsp3vwcTZ3HrdurJWxKbx1hDI8s+w9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8qlqmi4hILKxZ9NIyDavrFfomne8nJmSwa3i5TLVLA=;
 b=JbKa34j9VTGCH/d7R6Yzb709y8XJuqGHzmH3ZuZQjwhq7UJtWoPRbQ+N2ilv8BYHF9rwBtX1Aiifkk+kkIqPZ5ADc5X7GddVixYu0GkGE1FqONl071pr/A2HGn3vfgPTuiM9RjYxGKLuegC4BRP2Gtqt9oDSs813jURFczdKm6cxKYGYULZj6UHvvZmI8rz80M/KzPca3VhK/iG4E+Ni+fXi1fK+l60Sode5KfMacSGDnyzK8oX6tZV/lZNEdKngWkKmFXw5NN1Mu4lYpGiSQ4WrZxEq5CvItcPuCVQ6XWCPyRnUOlv2QOQe6FObGaY4IqYFp3r5uMXOZFAMllqZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8qlqmi4hILKxZ9NIyDavrFfomne8nJmSwa3i5TLVLA=;
 b=RTB3Ky3KQdr2DArWwnR+9UlN3qkghzRwHf4W2CUs6QV9YceHZYPLa8c4xdxa4s8xEb7c5a1iSmXXONIbtK0hiApg+WuInDm794B/ezT8D4I9fJpyvH5aTsMW5hcidIv0j2P9JDCYdWkPP8xChk7+wjPPpTY0aRX58DFiw9rf9gI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6829.namprd10.prod.outlook.com (2603:10b6:208:427::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 13 Sep
 2024 11:26:19 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 11:26:19 +0000
Message-ID: <4f09aa78-8a42-44dd-a685-37d6b9db7415@oracle.com>
Date: Fri, 13 Sep 2024 12:26:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dwarves_fprintf: Handle pointer modifiers correctly
To: Will Hawkins <hawkinsw@obs.cr>, dwarves@vger.kernel.org
References: <20240904164148.1735624-1-hawkinsw@obs.cr>
 <20240904164148.1735624-2-hawkinsw@obs.cr>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240904164148.1735624-2-hawkinsw@obs.cr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0358.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::21) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 73925ffe-3997-4245-832a-08dcd3e6e37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUFMSzJxdVc2Zmx3TFFmVVRPclZzN1FCdG1mTzhmcEI0WmRrdzZ0MExVMGxq?=
 =?utf-8?B?aGVXZG85QjZMcVZyVUhhUzdJL0Z4YVVndnpuUmZtRUhGSTBnbGMzSThoWkdV?=
 =?utf-8?B?Yzg2ZU5MUTNTQjBHUXpDR3RnT0phcU5TT1VhaTB5T3NRaEM4U1pBVFc5OENQ?=
 =?utf-8?B?MUFaMGh4eHU2OUZUT1pIWnBEb21icDZSTmE5b1ZNMG1TTFM4RGVVYnRmUHJU?=
 =?utf-8?B?MFhIV01VSFlONE5xcForV2dodUwvNkI4RDdyaUdEckk3TXAraHcvc2dhUmpQ?=
 =?utf-8?B?UEs4MUw4Z21RZ1RmRThkVHdRZWl3R3h4UWlVb3JKV0xqUDBySTcxeGN2Y25E?=
 =?utf-8?B?alhWeG1MUUFjVkpSTjhoWVo2eGx6OU5wdm9xVEhwL3BCWEIwRk1TZHF2ZDJY?=
 =?utf-8?B?R0VBMUhlUXFaQTdxU3pxWUFyV0g1NGMzazhpN0UxUTBteHBsYjlvTldpeHVO?=
 =?utf-8?B?RDcxYTU2N1M3NnNrcHMxb1ExbDhWTW15djBvYTV5eHZiZ2pTNFV2TGJGN1lD?=
 =?utf-8?B?cWI0bURiVStSd3E3QlBsWkZITmQyc3o2OFIvWWRXeGVQS0lNTHNKdXZKeWsy?=
 =?utf-8?B?UWR0enlURE0reldPeDQrUkdPblFIWUM3bGpmcVY4eFMrb292Zkhia2xZMmM1?=
 =?utf-8?B?cWluUVEwZENJeHNNZzFlc1R4MmRTS2QwSkM0SjNrcWZxUmQ4aVFvTi9UQ1dT?=
 =?utf-8?B?dTFsS2NVVFFvdjBkaEhKdWRJU1MwaU1xWk52Wk9Cb3dwbHZRUmtJaDZySVZj?=
 =?utf-8?B?c0MwSDlYaGhZekpUdVJIdGoyNVZPWHpwS1JuZUtHZnZHOWpLTW5wc3JEY1Bw?=
 =?utf-8?B?OUJ6bUduZ29LZjNzSXRqVFU1dHNyTWRwSFZ5aldBWVZmUlpIbnNRRFU3WTNC?=
 =?utf-8?B?azhPWGhNNnd5WE5YN2xMZnRUZjdWemhsWVUzT2tRRnFkVTlYUWhyYWp5cUJl?=
 =?utf-8?B?S3Jhc3FMM1lWcUJNdmNVb0Q0eVBrM3ppa2FweHJNTDJRa3N5enNZL1NLU1pD?=
 =?utf-8?B?bDVlMmVpNTgvY0ZVeEFJamxUZnJlL3FiSlBURXA4YlR3clBEOTAvOVNXT0NN?=
 =?utf-8?B?VUtxamdCUlFpYStiQWMyVkV4UTNHZmY3Vzd1ZzcwUFZlK3ZCWFZKcEp5c0Zs?=
 =?utf-8?B?Y3VMbnUxUTJXdnZGOTYxV3dsT05kdHVDdDZTUTVCaUM4QXpBbWdFaE5VK2dP?=
 =?utf-8?B?Si9UMSt5RFRzOG4wemw2a0tmZk1KWFhlYjdlaVBiQWhQSGduQlBvUFBJZzVl?=
 =?utf-8?B?TXBLakZhbFFPSmZYVGphUVJQbS94WDl1aC9IN1lsZnVUOWMzV0srd096ZXE4?=
 =?utf-8?B?Mm1aRG9YQmFGbEhrTVpxTnpzRVc2MHJpWGJZa2t3blE0TDk2Yi95ZlppNUxx?=
 =?utf-8?B?Mi9tK2ZLRG5EZVJIVkNXcWFaa2dDTlk4bU1QNW5BMkxweDAzbjREYlBoQ1Jt?=
 =?utf-8?B?bklNWUlwcU0xU3AvZ0VxNkVleUkvQVhXV2dGeTI2a29kRDBBd2J4K0VOcUhn?=
 =?utf-8?B?SDMzMEdnNzRIWTNUNXBiakVaUDZQUXFpRFJjTTBXUXVJS2ZKWE03eTZxc2pF?=
 =?utf-8?B?c01WRG5HbEg4SlFaaWQ0VTlXYVRXcFE2SGRaQm5vMnhWY0tsekt3NTVJaTJz?=
 =?utf-8?B?VmNIL3F2VnpyVjBZUERVZVhvdGErS21UODBpbGFGdytBSnJMek9oNkNVeUVF?=
 =?utf-8?B?UitDM2dqc0s2U0dLbG9Od0twamtFTXk2bGMxMFo2cDBwVlZjSFcxMDJjcmNN?=
 =?utf-8?B?WE5JS1Zlc0Ntb2thZTJBZWpHdGRUUStZYXhHUzN3aTdYKzF2MldjSzVjOC9Y?=
 =?utf-8?B?WDlqcHJ2SWZmNkI0RGdLQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L29nNnhGK2NTbWJhVGk1Z1RMMTlZbWVGUUh5bDhBZW5nYjRjWjBBeVhGVEdI?=
 =?utf-8?B?UURYYnQyeEI3R2haL0lIUHVFNzNHTHQ2SU1OcVBkUlJSMko1QUxDQW5jUmZ4?=
 =?utf-8?B?TndldzFpTmV6YURTMkpQSW9vamlET09tSkk5RlkvN1RZYTEzSFZqU1dFZ3h4?=
 =?utf-8?B?c1UxNkY2Mnd4K1VZZnBaTm1MdysxN2FjYlN0T3NpSFU4NytQU3U0MGwrUFZi?=
 =?utf-8?B?ZXYxdU1RbkR5cUowODVuSnhOaThHdEVqdHpyQy9YYW01emw3OWZ2bnhLKzlu?=
 =?utf-8?B?MWdSRWN4MzM1YW5oazFnZHAydStTTy8yTHdiQ21STGJVSjlFaHFnQXNYNCt2?=
 =?utf-8?B?TmxsSDJIblZwc292Y0pyMlkrUEEwU3I0b1hMV05EZ20rbDIwMHJyUmU3Qmd4?=
 =?utf-8?B?enZOWFhiWHVhOEVlc0RUSW5YWGxlSURnTk4yY2VOMTVnTHJOMk9xd3M3NXhP?=
 =?utf-8?B?UEVHaVNvbmtGVUo3WURVOWwzQ3ZDRWVMVlNyNXVXd2pZT2ZDcW4wemJqazFV?=
 =?utf-8?B?Qmg4K0JrRHc5V3VNVjg3MTI0WTBjZnN4djgyRDkxTC95L052TVhQTFNub2Rp?=
 =?utf-8?B?OU5CMDAxeWM4M05aaENzR0xFWVRGakRrVXRLaFhYbFBYYjFyeVZ6TG9FOGg0?=
 =?utf-8?B?ZisyT2gvdzBEWmNhQmUwTHl5cyt4UW5jZHRoMCtXa0FUTmVWUHRKVUlsNURl?=
 =?utf-8?B?ODQ1QWJFaHoxQXliN0QrL0V4MExBTncrenhGcDVqandrRGpQM1Z4Wmk0MkZC?=
 =?utf-8?B?NFFWQkh1NDlIOEt1T1g4WXA4Y3RuZ3JHeDZPcTZBY1ZrVVZKTUxXVUI3MSt2?=
 =?utf-8?B?K0lVWEtIV2Jta0hQR3N5UE5kN0pkQm9WQ0xvWjFVei9YSVExb3dJOWx0M2Jr?=
 =?utf-8?B?WGpyd2ZmTGdnMDNGbkpNelJ0cWxiajBWeWUwTG5STkFtbXZZcmlyR1ROMGgy?=
 =?utf-8?B?SW0rUUJ6QWxKUHA0RVlKSE5UNTdSWjN0TWRRMzdPbmJuQTFWdkJiZWpyQ3c3?=
 =?utf-8?B?SGVtQjV4WndGWEJUOFVTNzh0bDVFdm5Za054YVpDZW5NbVlyOG5QK2ZhSURZ?=
 =?utf-8?B?WDR5dUpIRE4zTEV6ZDcwcnBIQWlwTWo1U1VQMGlDL29tYXBWekkrNzBYbTE0?=
 =?utf-8?B?cG9Id25LTUxEYnlid2F5K1l0dGYzais5R0xkMnM4YWUraktOMWZoRnZLZXFk?=
 =?utf-8?B?Qkt3eVZIK0Y3eCs0T2E4WklnSThYNWZqazdwRHRabHBEMFlidG5xaEgwTHpK?=
 =?utf-8?B?OUp6Q3o5MG1tUHFQYW8zK1NGbXhoZzBlRFlQTzJMQWhmOTl2UmJ0MTk3RTZl?=
 =?utf-8?B?anB4M1BtL1hMbUR5M0VPTW9aV1Nqb0dPZDdaN2lkaUlQck1aU2pUcUY4cml2?=
 =?utf-8?B?dWRoNVhWd0x4bGNzZ1NhdU9FRlpodFBWRkQzZlVacUR0ZDlpZWZia2w3WDMz?=
 =?utf-8?B?Rm1nUUJQU3MwL0F0WWxPdjd0Mi84QllUQThpNFYyMVRyb3lOOGlnMHIzRWcr?=
 =?utf-8?B?ZFRGQTgxRlFTZmdvc09zZ2dnYUVMTHROblBDSEZpZlY2ZEVhd0NpWVAzN1Zi?=
 =?utf-8?B?WkcrY0pjYXVLZkdkUXcyZ2IxVmZPL2pCczFaR2crM01MRlZvV3l6aHozZlpz?=
 =?utf-8?B?MnVkVVllMkZLK1M4dGpMUnE2eERkMDNPYm9OU2dqZzFhNlZIL0NWemdQWU1p?=
 =?utf-8?B?L0VvS0p5bWxOTTh5akp5U0pTMFZhSFJxa1E0V28raGdVNisrcXUyTWlvRWUw?=
 =?utf-8?B?MHorU1FOVTVMOUpNaUFoM2l6NUUzYUFaVUtNYXNMM3BWWk5wNC9zQmEyc0tM?=
 =?utf-8?B?eHJRUFFseURwL0hzMU5WSkMyUlBUSG9BTllqcUg2MkVUSjZRUGxkckVTNG4x?=
 =?utf-8?B?WFFILzVnSDV1YVJjc0dVR0d6NmtvREZDMWhld1JVa3FaUm84bGRkN3JjcmpU?=
 =?utf-8?B?d2VjZzhNMmFQZDM5akV5MUd3QXdvdGtGT1d1dTA3dDF2eGt3OVBtNVJKaDgw?=
 =?utf-8?B?ek8xaEEwSjVSNEE4dlJMSXhGTmxqUDlEYUpYaFlVOVZXNGVoS2IydHpoeVlr?=
 =?utf-8?B?TGJ1QlBGelFPYXZIS3o2bWgxZ2tYdGVrRkZDWW1oUHF4NmptSk9LRzZPOExY?=
 =?utf-8?B?dTdreHBJRHRpSDdOaWNsVzhyTkJSck95aFZadGtaM1UwaVpPQUYyVWlSdTd6?=
 =?utf-8?Q?snK65F/PMHLSlhGJqfr3TIM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q9NmTWPGOhutXKvP1p7VzSha054y/wfE++zXp4xkaoTT/DfZl2oQRFBzYnK+C6XXYVveX/ygGZXL/k2gcvhLwdLuN6THaNq+wV73JJSFRmNcOKC/cBRk5VFRJI338SqovjfEs+W3vCb6fVWyLaYEnprgvjODpaigWsa0zBkZKT+5buyoULPFSO8EWbrIoVZmEcgJt2i0w/gxwUgJ4X3auSlSUKOpSHLoV7auHNQso/97P9u6J2SJkgyK2EQN3glTb6AqCdyRNoqhNgl+TmROq3+qucaQZ8DPNBOEYpz8CFq3fw3HnIwoi4YBXUeFJ9QbQ1cYhb/RyOSBQ9u1VZaLkdPTeSzQHcWvFbJylyMcldDgRFwVVDtQV2HraWTOba6hlkfwb1uTOiuMX86tvwCNnlOlqpXOgZNEflWP5objKLn4brMDXYeQJ+Qc0lq+F9T0SfGqTP57rCJwT+JQT67/oRDT79+aZ1eQYHirwuFeNuCQEPn4X+9CGXFHNDL2TN4BtspK9bCE/21bwMuSLZbfnL4OpkUanW1rv5+E5GSrspP9KAiBfbD3DrEv+ES9o16mF1d0Y2gZhKDbqC829dws+jMO9Y7vf5o5jqaLrxGuawY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73925ffe-3997-4245-832a-08dcd3e6e37b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 11:26:19.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElvwvOPvwd8H1Zv+DVujBwuK70REXNmTaElCDOv/ZpHCA1ARsPgsLzd5i+Hr84wAP//82dsbwm3IGMGzPxEpFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_09,2024-09-13_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130079
X-Proofpoint-GUID: 3HINFOQiVrqQfpEZkeAHC-z_CZvQwm5u
X-Proofpoint-ORIG-GUID: 3HINFOQiVrqQfpEZkeAHC-z_CZvQwm5u

On 04/09/2024 17:41, Will Hawkins wrote:
> In certain cases, pointer modifiers were attached to the wrong part of a type.
>

Nit but I'd expand the commit message here to describe a bit more; even
including the cover letter info here would be ideal for the commit log
as it helps hugely in understanding the issue.

> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

small things about comments etc below tho..

> ---
>  dwarves_fprintf.c | 57 ++++++++++++++---------------------------------
>  1 file changed, 17 insertions(+), 40 deletions(-)
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 54d2fc2..6f1f997 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -542,16 +542,6 @@ static const char *tag__ptr_name(const struct tag *tag, const struct cu *cu,
>  			char tmpbf[1024];
>  			const char *const_pointer = "";
>  
> -			if (tag__is_const(type)) {
> -				struct tag *next_type = cu__type(cu, type->type);
> -
> -				if (next_type && tag__is_pointer(next_type)) {
> -					if (!(conf && conf->skip_emitting_modifier))
> -						const_pointer = "const ";
> -					type = next_type;
> -				}
> -			}
> -
>  			snprintf(bf, len, "%s %s%s",
>  				 __tag__name(type, cu,
>  					     tmpbf, sizeof(tmpbf), conf),
> @@ -617,20 +607,30 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>  			tag__id_not_found_snprintf(bf, len, tag->type);
>  		else if (!tag__has_type_loop(tag, type, bf, len, NULL)) {
>  			char tmpbf[128];
> -			const char *prefix = "", *suffix = "",
> +			const char *prefix_modifier = NULL, *suffix_modifier = NULL,
>  				   *type_str = __tag__name(type, cu, tmpbf,
>  							   sizeof(tmpbf),
>  							   pconf);
>  			if (!pconf->skip_emitting_modifier) {
> +				const char **modifier = &prefix_modifier;
> +				// If the modifier is addressing a pointer, then we will need
> +				// put it after the type that is being printed.

again a tiny thing but in general /* */ style comments are preferred for
multi-line comments; I know there's exceptions (even in this file) but
it's the most common approach used across the codebase I think.

also a newline between declaration + comments is no harm too.

I think it might be no harm to provide a simple example in a comment
that relates tag spec + C representation to DWARF/BTF representation as
it's a tricky area. So something along the lines of:

"Reminder: "const int *foo" means that the target of the pointer is
const, while "const int * volatile foo" means that the target of the
pointer is const ("const int *") _and_ the pointer itself (volatile foo)
is volatile.

This is confusing because the later volatile refers to the pointer,
while the earlier const refers to the target type.

The DWARF or BTF representation will be of the more natural form

volatile -> ptr -> const -> int

This reads more naturally as a volatile pointer to a constant int.  To
display it correctly, the modifier that applies to the pointer must be a
suffix modifier printed after the pointer, and the modifier that applies
to the pointer target must be printed before the pointer."

Doesn't have to be that wordy of course (and I hope I got the details
right!) but I think this is a tricky area, so might be worth adding a
comment here explaining the rationale.

The change itself looks good to me and I _think_ recursion takes care of
multipe nested oddball cases too. Seems to clean up the logic too
removing the goto print_default. Nice work!



> +				if (tag__is_pointer(type))
> +					modifier = &suffix_modifier;
> +
>  				switch (tag->tag) {
> -				case DW_TAG_volatile_type: prefix = "volatile "; break;
> -				case DW_TAG_const_type: prefix = "const "; break;
> -				case DW_TAG_restrict_type: suffix = " restrict"; break;
> -				case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
> +				case DW_TAG_volatile_type: *modifier = "volatile"; break;
> +				case DW_TAG_const_type: *modifier = "const"; break;
> +				case DW_TAG_restrict_type: suffix_modifier = " restrict"; break;
> +				case DW_TAG_atomic_type:   *modifier = "_Atomic";  break;
>  				}
>  			}
> -			snprintf(bf, len, "%s%s%s%s", prefix, type_str, suffix,
> -				 pconf->no_parm_names ? "" : " ");
> +			snprintf(bf, len, "%s%s%s%s%s%s", prefix_modifier ? prefix_modifier : "",
> +											  prefix_modifier ? " " : "",
> +											  type_str,
> +											  suffix_modifier ? " " : "",
> +											  suffix_modifier ? suffix_modifier : "",
> +				 							  pconf->no_parm_names ? "" : " ");
>  		}
>  		break;
>  	case DW_TAG_array_type:
> @@ -833,8 +833,6 @@ inner_struct:
>  		tconf.suppress_offset_comment = suppress_offset_comment;
>  	}
>  
> -	const char *modifier;
> -
>  next_type:
>  	switch (type->tag) {
>  	case DW_TAG_pointer_type: {
> @@ -870,7 +868,6 @@ next_type:
>  		/* Fall Thru */
>  	}
>  	default:
> -print_default:
>  		printed += fprintf(fp, "%-*s %s", tconf.type_spacing,
>  				   tag__name(type, cu, tbf, sizeof(tbf), &tconf),
>  				   name);
> @@ -879,26 +876,6 @@ print_default:
>  		printed += ftype__fprintf(tag__ftype(type), cu, name, 0, 0,
>  					  tconf.type_spacing, true, &tconf, fp);
>  		break;
> -	case DW_TAG_atomic_type:
> -		modifier = "_Atomic";
> -		goto print_modifier;
> -	case DW_TAG_const_type:
> -		modifier = "const";
> -print_modifier: {
> -		if (!conf->skip_emitting_modifier) {
> -			size_t modifier_printed = fprintf(fp, "%s ", modifier);
> -			tconf.type_spacing -= modifier_printed;
> -			printed		   += modifier_printed;
> -		}
> -
> -		struct tag *ttype = cu__type(cu, type->type);
> -		if (ttype) {
> -			type = ttype;
> -			goto next_type;
> -		}
> -	}
> -		goto print_default;
> -
>  	case DW_TAG_array_type:
>  		printed += array_type__fprintf(type, cu, name, &tconf, fp);
>  		break;
