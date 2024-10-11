Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F8198E7F
	for <dwarves@vger.kernel.org>; Fri, 11 Oct 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664079; cv=fail; b=HQ7qOQXHcqR1XBnwulTUs0/ZaFfRP6+yhN4NY4Lh4WgsV+2zz+WkWyUC+psNE+A0QAXty1HckGfEUgO/4uJXxr9ECfzi8U38fgMa7zLNARxE4pcK246TQRpTayOmjkoocSipOu1wGRrVZ/a18FOH7+iIQ9zk1Ea/BI/1AUDrSq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664079; c=relaxed/simple;
	bh=HLy9HGHN+Hp+WK1qJ9hBkhJ7Dscvku/AlaK6T7I3nz0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XLWWkJfCQbS7HTnzphBPgOpGKysGr6AkXLGZZ8CysCOZquupHDqIEHLw7lUPUBrh+woy9cxnvHiKLKObqQO8Gw84/SK/O4OVK6oiJN9HntOh8QpRiHW7XiTm2IzXjaiK7a0NiQChc7sEl4BxfV2gKoQiZ0vBC76RLHaOyKMolF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DpKjJdTd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XGlikq2R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DpKjJdTd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XGlikq2R"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpWL4020223;
	Fri, 11 Oct 2024 16:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FU3Xc0zWICCnCuBotZKDhk0TZ2xGuZwtajnkPVeKkqw=; b=
	DpKjJdTdy0TEVMA6hZJmdHwOeRzytvWd0/X+dNHogj7UBMKizigIvQkd0M/jbEuK
	Xxaugdu/iL3jzsaLczKEn1jQi1dyqwI8EWtnaXLAW4Y1RiRA4TOo2K+jgX4EZA/E
	XJ2e+Ks7XnkBb3tn5f4ThzyOGfpYaocNIyHtq8uEWQU996XfSh5q+AW4ya1MZ6lH
	lM7zhQQ8D9/Et8/P03lEiT3H03AvQexo6t8neJ1ITI+qVC2+pGlA3QmA9VQ07IrI
	JSBGVmyCLOPImdrNFPMItpCAPh9xbq1QMZh7/LKDh/MxHG+C1ycXR3ALEGzW7SEg
	D3Msr/nHomeUoYnEXVr5cQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306en8s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 16:27:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BG7g2d033330;
	Fri, 11 Oct 2024 16:27:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbfqq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 16:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YenC2uQymPvl+BEnNPHZt2CiqZeFVbYYmzO5gOLY6Kk57HNwQHQup3GPsyaNc8DIOrYbOjyKcEHoYVOHy2DhmpRQ4H0cy2sTLlL0H3DE4dvfOYOnGVwHE/h6O5sIiJ2RzWa8zTPnR5CBKhshDa6on8jz0hT6TqOelTwJZFVZ64o5NkkGxx4/bNAqSwqmP/eMMfmXk3m/SSrMNHBlGuneZyCeEBAuAXSKy6wEV+SUIM1IOCeLZU7jjjj80sYnDnQtWJ1JBN+yzdZYAtn7tADDWEuxTTKbTJMvYNRibRkvX576kVH3asbpPiOjuWpA5ngY/zK8v39fmt2zZhdcalEw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU3Xc0zWICCnCuBotZKDhk0TZ2xGuZwtajnkPVeKkqw=;
 b=czW3HeeENC5+74DHHGans8Z62irbqGfhKiKaomUJTsQUJuwYhP6kU5UzlZpyY1jaAaX0Pj2UNTFIZugOrFgDb8/b2WV0yUw0mwHNRcTIZZ/0tRYkLgErgbOKXFwXwY3hCshcvlGs8kB2yFqvk03QIThzudXIzyxLPk4QG/VQsV/EjtC79Xt5dZur+4E4mciolIhZcAcfVmzkaNE7aU3DNyGe7geW4lJWeKBOXcYnRr3Y7W4nxks45/3YTFt+oxb3AfJg8aFNnxJhYgWYaPtGpmaJICMsK1o6ziWx4nerpYeDiuXuEuAyu1eDXwfu8E/aC+ab/qSWbU7RYNGlLy/zCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU3Xc0zWICCnCuBotZKDhk0TZ2xGuZwtajnkPVeKkqw=;
 b=XGlikq2RHB655gWaBr1IgkZek+gecrdpmvbsblcXl/fnN8XCKoUNY9BdjahBpV48Snc0xeb/KKlLTosq5GVaRoGKFv/3JJEa5gnp0DYfLKxoiLwV15Uf1tORVmgDD+QP/ge2TQqRzrnNJrAeftxYDF6+WDK5yOjTAssYrBlWBJQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW5PR10MB5806.namprd10.prod.outlook.com (2603:10b6:303:193::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 16:27:41 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 16:27:40 +0000
Message-ID: <52889283-56c4-4cf6-aad6-b0fbea9e58fb@oracle.com>
Date: Fri, 11 Oct 2024 17:27:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared
 elf_functions table
From: Alan Maguire <alan.maguire@oracle.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, acme@kernel.org, andrii@kernel.org
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
 <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com>
 <4C0idzPIUJesSQi12dB1SgeTQlGl13N2CCsvjPfdLbvTEemTJoQZ4P-LJcOQqRyM69ZLKVv4mIKDQJvfMYMV2oITse1_uS_m_SjVigh8bL0=@pm.me>
 <af7ca712-7798-4204-9e15-fa2065154699@oracle.com>
Content-Language: en-GB
In-Reply-To: <af7ca712-7798-4204-9e15-fa2065154699@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:205:1::28) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW5PR10MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 0328cd30-7c4c-4ec4-ed1b-08dcea119ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1p4OHB4aUZmVDIyMDliNkc5b0NtalNtam56TGxidTJUalRhcEZZYUtNMlJR?=
 =?utf-8?B?NXVVVDd5MVZGWkZEcTV6VkZLQWt3eC9uYVMweS9qMGZLRjhGMlRUbzVUTVFW?=
 =?utf-8?B?cnR3V0pzQnNhN1dGaW9mRFowS1Qxb1VPTEFkOEdhSWJhclp2eENiQ3VBaGJC?=
 =?utf-8?B?VlREMzROY2lBRFhVUjZDbEE1MGR2RlhjYTUxNnNLTVZDSGpCaFd5ZlFwK01w?=
 =?utf-8?B?NDRLclVyM0JIeTNDTzZJblRmWVVkSkpaYnY5aVVnMmtlQktHWllLSTdBMHNL?=
 =?utf-8?B?VnVsVnUrWE53RFM5em5ERXFVZmw2aVdBMDF3Ti81ai9mMzRKVTRnQ1dtbmRD?=
 =?utf-8?B?a0xaZEp6cVV5WllxdHpqMzBncmhuN1BJVUVPb1JhdllLZ2NIVjR1dmg2TUs3?=
 =?utf-8?B?UUpnOU9vM3ZRQzF6NEpKclVTU01KeVZnWDM4UGFnVVJQbEFHamw3U0cxME9G?=
 =?utf-8?B?N1cvaHJyc05uTkxQT2FxVTlEcUNXWnpTbVk5TVAzNHhPaDZyQWpmU1VUeG4r?=
 =?utf-8?B?K3YxU1M1MFgzWDdBVVJyZzhXbWdrTHJDUzhObFZoOVgxd3MrenRFbDhHU1Bx?=
 =?utf-8?B?ZjV0OWVVN0JIOHpTdUdZUk9XUVFLQmtFNWJSWHAwWGl3bmtvMUFGSjlDVW1N?=
 =?utf-8?B?VFM5QWxqUFdrSkpuMEh4UHhFU25WcHU0NEFyTVp6QktTTW56MFNWdVlqVUxw?=
 =?utf-8?B?SzBJc2ZpZ3VrZ1d4VnZOSDdSOVI0OFBmYzRobFpSbU9ycHlPMVFKNjg5MHpB?=
 =?utf-8?B?M2w0N3l5KzBCUjVhcndpa3dWS0o2bFlVSmRENm1PSHFUZ2p0enBzd1dRSHBR?=
 =?utf-8?B?T0pDQ1pRd3k4T25oVmRaa3EyTWVlSkl2aVp1QlVWQVoza21ySWtPTXhQcVpR?=
 =?utf-8?B?NHV0ZEFFZUowOFdodGxWeGZQVlBRNzlMVVN6aEswUktyMFZCd1lubkpqMWYv?=
 =?utf-8?B?WkhFVXBOYWo1ZUtSamJLREJiRE4vYkhDQmQyTVZKRGJqRFkwK3E1ZlZwb2x3?=
 =?utf-8?B?K0MwMXRNQ2lmWmZ2LzY4QVpkV2RpMk1TNzFrOTd1NUhrVGNBVnNZdXpGS2ZD?=
 =?utf-8?B?bEYza2VqRmdMZHJVOVUwTDBqT0hEWUIybGZ4dnQramhwNFp5REtkTXRaQkF2?=
 =?utf-8?B?M25rN294V1QzRmZvbktpOTRHcVNUaGFLaStKV0swZjhyVlpoUDB2U1RJMStY?=
 =?utf-8?B?K0dMSjFSUmtJZi9mODdnVmFKYkN3Qm5oY094b1BXSFl4UCt3cUtyNXpNOTcr?=
 =?utf-8?B?SFZjelRaRGN0YTJIeHVMOVdBMGEwKzkwNE1mTUEzbjZVQnJITkE2ZDlhdzdL?=
 =?utf-8?B?TG5INUFVZ2VxTTFCTDJXY0NuQ0lYeXBjOU52YVFwRGE1dFFyLzRQR3o4UXJk?=
 =?utf-8?B?bXVQaEtMVFRXYW8ycGp0WlJoTzEzR3kyeXN3MUd5UHU0SHM4VlM4S0U0aFRn?=
 =?utf-8?B?S01XRW84UXFnTGdOTjVKY2o5eC8ycnM0OC9NWlgzMTQwdkdIc1hWL2wvYkhw?=
 =?utf-8?B?eWNIL1dyOXhOZnRBRGVjZDRuODJCQkx3bURXeUYrallvdVBMK095UjF1QW15?=
 =?utf-8?B?TDR1bUVjRVNoNjlDUFBxczJNOGtxK1dLQW03ZDBQTzZxQWQzQU9vSXVjbHdp?=
 =?utf-8?B?K1Z5dEtNSnZIelJaeHVkb2hWd2o0RmQzMnRKMVBhcklKYVNLY3ZlNzhxcmEw?=
 =?utf-8?B?cEY0dUt4TDJ0MjRjU1NucFBVSnJ6dFFPTW42Qkw2czl3YklKUDd3QmdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bURNM2ZwL05xM3lWZm9kbGRYOGhZS1p2clVrMDE0S2YwOVFtTHVBcU41WEhX?=
 =?utf-8?B?eHA3aHNseG1XZzE2SUlJRlBmYTNsRnZnZ2ZxWDNpaE9BUXlLUWNNSGx0QWJB?=
 =?utf-8?B?YVVLck9XNE1oUUJ0Y1JoY3NSVXc2L0FtejBISlpJMGRyYVYxQSt0OEZ0eWRW?=
 =?utf-8?B?Z1lyelNNcTkzVW1DeFYzdFhpdTNNK3NBc3VxbDZtaEtIdlJNNm5DdVhOeGY1?=
 =?utf-8?B?YThnOHY1RVQ5VUpwMEdNWEpGWVI4d3IzdEE4VFp6WjlrS2NTTW1Fd3NBdzlF?=
 =?utf-8?B?dWtUOEZWV0J6U0pWYmFzdEtPQlRjY3RMNCsxeXVWdG9CSEFyNUVCcjBIbjh3?=
 =?utf-8?B?dG02eHpLdGVLczMvRFJvenJjejRRUHlETjI2SjdBRTkzNjRLWTU1VTA3NUVU?=
 =?utf-8?B?N0FSMWdqQVduYmVmb3B6UXluWERlRm5FOTQzeU9RRnNxdnhXRE1WdGFucWsr?=
 =?utf-8?B?UnovNFduS2pKV3RMSGVKWXpTUTNROUoxd1RRNHFPei9xYVN5RUdOSGpJSTI5?=
 =?utf-8?B?VDV2c1kzdmdDcWF2R1ZhNE42Z2NLdE11NGdRZlFRQWlaUnNqcnpyTW5oY3o3?=
 =?utf-8?B?RXdlRGVVOVR4eWI2aytCbjZUU09aNXBTU3lLNzhGYXJtSWVkbEJDLzdqdWJy?=
 =?utf-8?B?UGU4UVc0dkIwWWpZMWlPYU5nK1RtZmZJa2hYaWxTUlhWSnh1N3g3czNsenVa?=
 =?utf-8?B?YlIxU1czNHRFME9wTUZJZlNtaktVYWdITVpkdVJhbDF0NWFOMUs0c3NUd0Ns?=
 =?utf-8?B?cmRDcjFIbUtSVHZSc0prVDRSSVpSa2t3ZVZkWldYMFMyN2lXcW5mQUhTeGpo?=
 =?utf-8?B?Q2JUK1VMb09iSEtSdnY3NHVVMXI2MVlPVjQ0TXI0ZVhWMDgxcnJOajN5Titl?=
 =?utf-8?B?TTNwYTc3UEMvVi9ER2Q0MnZqeFFDRGF5NXpjVXBEK2pydzc0SHpkaHBOWEMw?=
 =?utf-8?B?Z2ltUTAwU1RuRlFqeUg5dkdjK0tVY2ltenF5czZhZ1N6bTFWa05qbGNjbFdV?=
 =?utf-8?B?VTZYT3FtN0RzSnl4MC9XQ21CNm9ieSsxWkpvcTl0dGRGcjY2RGp0ZEZ0QzFy?=
 =?utf-8?B?WnFhbU5wYkJOWjRqdi80SExYdEJ1K0pDUVptbkJ3RGJxRFE1ODVNTU5NQ1c0?=
 =?utf-8?B?clBkTWU3SDVUQTZvZzlFbjFCOFZ5Z1B6czhsQjBjYTE3cU5iUGxQbzhlYlA3?=
 =?utf-8?B?cG5NbUljWENpV2hkcmZ3TUpTK2NIeC9hSDU3WTc1dmZJTDRBZitlR3U0dElO?=
 =?utf-8?B?NTRNMWhyb2c3M0VQU3pvTkhlYWV3M0lieGcxL1ptQ2s5UzkxVUNOUC9NRU4w?=
 =?utf-8?B?cHRlc2FUUTlxQUx2ckNmc0NGbFdUVm9hakEzL0lzakx3TktLbnNrMmc5eW9m?=
 =?utf-8?B?d2I5Wm9hWTJlNy9aVjFsVFBRVzlZSUJaZm54UGt3RWxVQ3lDQW1BbjM3NThi?=
 =?utf-8?B?MVZDQzc0cmZQTzNWSUJIRDhpUngyWngwY3VycDdFOGVmSEdZYVZPdFlpN0RM?=
 =?utf-8?B?eUlCald2QTJUUGFOVC9Qdmp3aTlTam1WYmhPQTl5alFGQWd1aFNDNkNEUTZB?=
 =?utf-8?B?OHdtM1ZWcTdXdzN2NnFheUlIUndUQktIRUFyV2RpeTRGOXN5UThUV3hOSFFx?=
 =?utf-8?B?ZWFxNG1lRGQvL1A5RWZvaGYwQjVoaU5wVW1xSVFPNWx0NDV4MnpiY3lIRzll?=
 =?utf-8?B?NzJtaUp3Y0hxOUxsaExXTzV1SjJIRm5HbkFnYm93UUVrdUFpdHZTWVVqaWNv?=
 =?utf-8?B?MzhTQkFtcnZncE4wK3YrZ0VTaUJxMFVXdVE3aFJ6by9saEFma3IxQnVIM3F0?=
 =?utf-8?B?RjZnQVEvRlNQbW1yVEltdmlXR1ptSkpheVhHQkJxRzM2Zi9ZWU5GbVRudVNw?=
 =?utf-8?B?cHBmVDhLdEsrcjB1SWl6MXNLM2N4OVA3YUFuYTZockVCeStLZUNaak5wdUFF?=
 =?utf-8?B?cVI1blcxOVY2U2g2a3ovc1lIVXllZkRvUjVHUkNVbExTRm1uRnk5ZURUb0lJ?=
 =?utf-8?B?cmErdk5xTnFQM1pJWE01M25VYmQrTG5XczJGSEZsRkFXMGRnNk0zSWRLay9K?=
 =?utf-8?B?TVdnbFl3dnM3bmtFUXJsUENCZ0JQajBOWjhGVTBZbFhSTHVwb0oxTEhjYmZQ?=
 =?utf-8?B?ajByaUZhVUMrNFBGQkJWelFvc3liY1JzcDlRb3NWbWY3UW0vZ3VXVXpTWXhJ?=
 =?utf-8?Q?ehuRkGRz2WHsYci8sjt5+oM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8nz9Oi6HhJBwnEfJiADMksg9/7OvZpvbQdHqeuPQqJunjKVvXNHLjRTpYeewJs2gnzWCMa5k4HIipXe5OaIcDK4u0ImswgRQGtefJS4wRJfAmRyB9SI5MSEeuDNjAEpbTrYPJziuxtELIrCOATXD5vr3Aiphorcw7rclSP2X1MLflxj+Ygjh++mhkReoGUtrPNg4hYDNaMfADvqSLfir05RgtC2xpXv7b10YoTX7zf2Pt/5/Qs1VdKpKPW0174TfchnBcXwlHC1DEtKuc/n26OrF2jRS+N8vp6U/N5lFbYQt/41NivjX/fWNjZBLZpXi25Yk5yULLotYqIJxwqmr70uzeO688Whc4f6l0mBbrJbA7kRV5lVWnURgagl1jcW5bbVxLskBjO2YlwKAS8W+2j1VNp1SD7j1AiXDa5tsHJwebXtGxrVD5yoZx8zmE7m0oyKtQE/F5oNRdq3yFg9m0XJwxDGGMCxh/JIwi6eZujeHue/GVk7SSvgTvt56PJ/5xkKWdfLZOQ0lRx9zoftCDj2kxm+0W2xcRAmP4eE/oFPKxYEQKXIKgRa9tASGle27FpqejElloKX7cQUdY97249rploY60x6CfeM547C+Ft0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0328cd30-7c4c-4ec4-ed1b-08dcea119ff5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 16:27:40.2023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZf9z9bxu2rJCvFMXWL+vN4pM3Tlqb8lZIUY+8Qcl2Cty2B1xyE/Jqp0k4aS7DgvpIHM3u+ltET3O79TmoyRQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_14,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110114
X-Proofpoint-GUID: WhAfFyfbscdWd5sbRmhYKyxIOE5DNHDm
X-Proofpoint-ORIG-GUID: WhAfFyfbscdWd5sbRmhYKyxIOE5DNHDm

On 10/10/2024 21:31, Alan Maguire wrote:
> On 10/10/2024 01:36, Ihor Solodrai wrote:
>> On Wednesday, October 9th, 2024 at 4:43 PM, Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> [...]
>>>
>>> Do you have the performance / memory usage stats for next vs this patch-set?
>>
>> Hi Eduard.
>>
>> Yes, I ran perf stat, and looked at max memory as reported by
>> `/usr/bin/time -v`. The difference is insignificant compared to
>> acmel/dwarves:next (a1241b0) [1]. See below.
>>
>> In terms of speed I didn't expect an improvement. It might have 
>> even gotten worse due to potential encoder threads synchronization
>> when accessing elf_functions table. The table is now built once, but
>> before the changes it was built once *per thread*.
>>
>> As for memory, no difference is a little surprising as we now have one
>> table instead of N (where N is number of threads). But more stuff was
>> added to elf_function, so I guess it ate all potential gains.
>>
>>
>> Performance counter stats for './pahole -J -j8 --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=/dev/null --lang_exclude=rust ~/repo/bpf-dev-docker/linux/.tmp_vmlinux1' (31 runs):
>>
>> acmel/dwarves:next
>>
>>     68,904,383,016      cycles                                                                  ( +-  0.30% )
>>
>>             5.5862 +- 0.0304 seconds time elapsed  ( +-  0.54% )
>>
>> vs this patchset
>>
>>     68,235,717,886      cycles                                                                  ( +-  0.30% )
>>
>>             5.5550 +- 0.0412 seconds time elapsed  ( +-  0.74% )
>>
>> Memory on acmel/dwarves:next
>>        Maximum resident set size (kbytes): 1392640
>>        Maximum resident set size (kbytes): 1394600
>>        Maximum resident set size (kbytes): 1393788
>>
>> Memory on this patchset:
>>        Maximum resident set size (kbytes): 1393564
>>        Maximum resident set size (kbytes): 1394840
>>        Maximum resident set size (kbytes): 1392348
>>
>> [1] https://github.com/acmel/dwarves/commit/a1241b095de948becfed882929dda7c4318e022a
>>
>>
> 
> Thanks for these stats! In general, I really like the direction; it also
> fits neatly with our future plans around encoding additional info like
> function addresses; the previous approach of storing all info via name
> matching wasn't ideal for that. I'll try it out and review the changes
> tomorrow.
> 
> One thing I'm curious about; I presume the above stats are for
> single-threaded peak memory utilization, right? If that is correct, how
> do things scale as we add threads? I'd assume that since we're now
> sharing ELF function info, we should see a drop in peak memory
> utilization for nthreads > 1 (as compared to the baseline next code)?
>

Did some experiments here, saw no significant difference in terms of
peak memory utilization; this may indicate the peak memory utilization
is a function of something else. Comparing peak memory utilization
between 1 and 8-threaded encoding, a similar pattern is observed for
baseline next and this series, for baseline 1 vs 8 threads we see:

< 	Maximum resident set size (kbytes): 1069304
---
> 	Maximum resident set size (kbytes): 1119412

...while for this series 1 vs 8 threads we see

< 	Maximum resident set size (kbytes): 1071148
---
> 	Maximum resident set size (kbytes): 1125052

So pretty similar really. Maybe a system with a larger number of
processors would reveal something more here and show the benefits of
shared ELF representations.

> Another thing we're encouraging is running the tests; you can do this
> via
> 
> vmlinux=/path/2/vmlinux ./tests/tests
> 
> Not too many there today, but we're working on growing the set of tests.
> If you set VERBOSE=1 too you can get a lot of extra info around function
> encoding. One thing I think we should be careful about is to ensure we
> get a similar number of functions encoded with these changes as compared
> to baseline. I don't see any major reason why we wouldn't, but good to
> check regardless. Thanks!
>

I tried this too, and compared verbose output of baseline and test
btf_functions; both were identical:

$ VERBOSE=1 vmlinux=/home/almagui/kbuild/bpf-next/vmlinux bash
btf_functions.sh > /var/tmp/btf_functions.baseline
$ VERBOSE=1 vmlinux=/home/almagui/kbuild/bpf-next/vmlinux bash
btf_functions.sh > /var/tmp/btf_functions.test
$ diff /var/tmp/btf_functions.baseline /var/tmp/btf_functions.test
$

This suggests the results are the same since we encode the same number
of functions, refuse to encode the same number of inconsistent functions
etc. Which is great!

Alan
