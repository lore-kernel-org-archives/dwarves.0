Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E146A5F0
	for <dwarves@vger.kernel.org>; Wed, 23 Sep 2026 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158937; cv=fail; b=MQEa5MtmEwbhGPM2v7F/AbfIKH3jCu2PQbHKTol18ft+XfWCl3D0vEyKW/wAPpOG0AgFg/voAkehQ/KY47Xo3eFjMuQdbMmL8/iOEEu6LRuSEbOIdKUx6/1szcdfqBtxIvwsl1S43Z+cPweKU6ypi7/vv35NW/oEnLIdzI/xFhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158937; c=relaxed/simple;
	bh=PJkONse+Q12jD2y3HyfYzGfA71JsweNUOZX2e3qa88g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tro+f9GFDBpNnFQQy5/tBwXd1wWwFnHoLOQLC+ZvzNChVKkmeq9mZxUXlHNUu6iLpm81GkPkxs92punzRMt2cv9AwNZrGiafIWUemsD2pqys2gH9EJdeSdSSIJr15meCOUrhhNVehngiPzY0tqlf0uamvPx23vVDzIR3UBhduuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EFJO1h2w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ykPK1ZZw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFJO1h2w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ykPK1ZZw"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N1wE4k3643329;
	Wed, 23 Sep 2026 10:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dWR9Tl/iz66970kw44J2DxsDsrs54XF0ZcoItu4QFGQ=; b=
	EFJO1h2wCC4ih+ZU9gF5fY1WxmckK0TqKWPdV7rT9tza393z3NiFdSzqVjOGR3ta
	/Arq7bOTBQ03cquJt9MBvMJOdFMIk/4Rpqj9xyLcNjwgRYZbWx/6m4rPVw/ptMck
	cqxfQlqwWBPX7+n4jgoV08kJCdu35cUHgH1NNDdC8tzf7vENGTW/z6hPTiy3ktpk
	BLDDJarRGmEwIr3psmnsgLImqJxuDdJL17mFIQ9og08SDFTO/KVNQMmTSzl0Onep
	9M/ghYGq9cS7dg225338PBpKFQzGjXInvYmIFFb2laeipROMxvzzv8pzkg+aZeci
	CxJ5P9jmuk823PmhB5wrGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsjxb5gbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 10:21:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68NAKQT6033496;
	Wed, 23 Sep 2026 10:21:53 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepqm67e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Sep 2026 10:21:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCqvJq1je8KAqfavBBjH65/bMpGckqGVntzYsbscTu/bu4dERE55NAm4TzfDYuaPGjs5bHTcvLV7P9rB+d7bQ/x/bvm3oWzjg02kSwPRg3TrPy6VpHeFvf53MZ7lxlLLccGKcnFE4TC+DpH61qVeXZxMRgCQVvOMx2vMrVcDysT2at4axDlJnk64NRQCyC1Loy+Ie/0CrV6uusmLKDocsxLaHrC2RdyA9fCJ/UscDtYUhnE1IVvI37eSTAnEtTQkU1y6sAvUpc1+lfB5U+sDFFEqhi8jzDX83XChnH3nXSDyYp9v+eL7T7f4knmuU/KOGnUDsldcwQImmqK7IHzAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWR9Tl/iz66970kw44J2DxsDsrs54XF0ZcoItu4QFGQ=;
 b=tv1NNiD43W0Q3WXh8uLiDxBs4JFua4OuxGHOj/706D5ncltW7g9qU0+i7BMxYS2/S3IfqiF1dBRMN1olZmaulFRSumG7K5URD4KshsdPtJTirvrumy1pIrMhry2jW4iyhVpw4JPrs3dzo1E6Dk9TrYLIWbRkoyp2ctVbzWB68g5mmA8angRntSLmeGLUsR4qPQ1Sb6vktyDnwoVtFSWRh01wsDq6JThSaZpwYulQ3AA3b9QBcbwbwgC5mPUCs4KpxyRVFvvFMu0ql7uyqzN4urDV4uVwe87xD1pn30SNAI5zvgw2Mx1+nqCjYYFQ/Rem3FUXiRXrByPNSOpGN0Tgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWR9Tl/iz66970kw44J2DxsDsrs54XF0ZcoItu4QFGQ=;
 b=ykPK1ZZwi/aSbeuWwnwgUFHD8WHOFA6NMeh7xslv9Ai4wXn/hFkWjmdH4LSoELjAaer/IpZYBKOTAz1HVr7KGH6IIu8Kt/1Ji22u1M9J0PeSngrnr9u9RjQEaHYowZSvEOtlNyrNy59ybk7bQEN7neq2fdWWkY9/FdbrLr09la0=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by IA0PR10MB6722.namprd10.prod.outlook.com (2603:10b6:208:440::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 10:21:51 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 10:21:51 +0000
Message-ID: <4665158a-793a-4693-825b-e8b71884a782@oracle.com>
Date: Wed, 23 Sep 2026 11:21:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Escape a leading dot in groff man-page
To: =?UTF-8?Q?H=C3=A5vard_F=2E_Aasen?= <havard.f.aasen@pfft.no>,
        dwarves@vger.kernel.org
References: <20260918174708.289274-1-havard.f.aasen@pfft.no>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260918174708.289274-1-havard.f.aasen@pfft.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|IA0PR10MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: b8595ff7-3a66-41fa-0ba6-08df195c7ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FKJx7c8G5p+RFOp5+VNMnSzPp9A0ssECP1jueILseokxZ86m5LMwGXjz+NCIReBMdC2aX6th3he4e8QEeMrmuJwnZqyJ0vJvdMUFV9zsaJG1BgpqALVJa9WEPGgfakBMnw+l7WeF9iuLnIjmn5Jz4xadNKAvslp5o9sxkz9dLfeSobnhutre85iSUgaXuDqPn581IBl6j0h77jL24KfJgUm6E3EG2RodRYGlsO5jsqCSxR4WnWsvW37Tr4uIgwC7tFyipcCMybpmRPxIqox4LvttzdGoW1MoEd29SIEE2xRuxzTI1VEF9skqwYlQQZ8a21ASoQnA0416GSVkVRo/VRWS3QppkHDNPyK1DPiFRbwnACc7lERplS5BE3UoZYpr+NzQAywFFgmjgQMFXI2XA3slMFADqs4O1HBstn3YwNuNIrzda0N0kgvBg+vdxm4SqSLpQMRXuxj3oMVZgaS6H8T+YNtHk1LCsGGgDhHbJZGysztgH6SbL0wUdS8HS79b6rsH2G0WRHmFf/B0cYk1KmwKKDRoofM6bVPE7T9ZvobuyIQVUwcscEMy5hQ7Z95kRP/gB+61+2v0q38oZa7/PzY0GWgRtLn3BSFwzTPGwgmA8d0+SZzrX39IfzDEmzZic4VsfZek+bM0yb8BSkSLSFfe1UPW88zUinXiVfqY4yw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzIrM0VReTdidG8vSzdiYWV6cDdXdFBxQk9GVmo4NWhXd0ZleElRTkJOSjMy?=
 =?utf-8?B?NVBPYjZEZ2hpR3B5SzFDcVJQODBBdnhYT2krbTdOcW1xU3FhemNqdFlaR2Y0?=
 =?utf-8?B?dENIZTBQLzI3ZFdGTkthZEJ1dnNMcVNtWlNnQmVvM2YwYjJuelBBTnJ4WFdr?=
 =?utf-8?B?UzRXeGJZU1cyRjRXdXRYbkcwZWlrTVlLcXgvWDJzNTd2NW96N2lLT1dGYjNt?=
 =?utf-8?B?UW1oTjYwNkp3d3F6RXZxODhQd2VEZm1hK0Q1aWI2SVhhNXROT3I3L2lKTVpV?=
 =?utf-8?B?K1hidjc2Tk4wbnFSaFpKYW9hWHRPKzZTSk9wNHBxTG51aW03MjRFN1hERHVH?=
 =?utf-8?B?WnY5WDJEcVI1ZUVQSVJCZGtEVUh1aXNxaElobGdkakFpWE5ZcERrRzVVV3pi?=
 =?utf-8?B?RFVoaXo2WWVtRjFtZmRyUXc2OFhwYkZPdzV0UkhWS1RrTUZMYjR5VWJBZk1C?=
 =?utf-8?B?YmUzRkVQQ2k5aTBUVG1YSDVtUUNEcDZOTU1Qci9yQSsrRnFzT0gwNkZYdXJ2?=
 =?utf-8?B?NElhTi9sOVM3TzE3ZzZMak5aekdlazlQUDlhK1d5QjBjR1RzL3piQ0ZDS0xB?=
 =?utf-8?B?K0dqVjJZUVQvb0dkUmpuWml6QlZ1bUZzRUJSTWpiUFQ2MW1lTG5nTGVsOFVa?=
 =?utf-8?B?NjRjZ3BOZWtVb3hyRk1OVU5SMmNHYlpXTlNjcUlMbHdXdGRCaWlUWjdkN3Iv?=
 =?utf-8?B?YWUvN01lZjBEL0huQlJEQkFLWGlSNEdRL2dZc0RqbTRzYStJaGYycWF4bUNZ?=
 =?utf-8?B?ckhuWmgxVmlIcUtXbDhCd3RKZjNHc2pPVnd1cjcvZ05DWWRxUUVGTHVZK3RE?=
 =?utf-8?B?RkVWcFovRkhwNTRnNHVRQUI4VU5SZzdRWWNySkQrU01TY3I2L0IyR2JEWE8z?=
 =?utf-8?B?SXRIUWxFKzlzV1lsYTFxS1lkVFkyb2V2YTA5MXRRc0NFYmRQbitMNFl1bXAz?=
 =?utf-8?B?dzI3bzRnUnJLS2tmY2wyd0lPd3JwUlpaR3ZJV0VMd1NRMUVraHdnQTM5QmQ1?=
 =?utf-8?B?WkhPK0puYXBpSHlvbFlmVzdPaWM4VEdMQ3hWNFRnTFNHMVc5RWNvdjBtd3dR?=
 =?utf-8?B?MWNHN243NThEMUZQcjVRYTZWQ3FSeGpGdFQ4UXFYMVE2Nlp3bHhBSWQ2MC9v?=
 =?utf-8?B?aGdvY2JrclE0aTg5SlR5aWkyb3pJRXZhQXYza284a0VIakEzS0hXYkhBY0Rk?=
 =?utf-8?B?ZWVJVFl5YThNMExCKzZZRmdqcHh6R09tYSs0M0x6WUhBSXU2UHlrdHFtWW5W?=
 =?utf-8?B?c2JMTzZRbW1UdWZ6RzN6L0JtWFZKaUVUMUg3cE1nNUVTZUl1RzVXMXVoallh?=
 =?utf-8?B?UDFEZmNhS0ZBUjBOK1B6amt5eVdNdGVoRkxkcjV4ejBaM2JtS00zTGZaTEN5?=
 =?utf-8?B?RFVDT2NFL2lUK2h4cjlTVlZnTitOY0hvMHFXbkpLL0tqTjlpWFVEQnNyZGxR?=
 =?utf-8?B?V0I1UmJYb3JYUFltQ08rbi9ldzRjMW1EQnAwS2ZsQ1RMNnNDTlg2Z0lLWFBo?=
 =?utf-8?B?Q25MRUN0SnpHRlZXSnRBOGZHV1VtMkxCNG5TOXd6dkZTb1ZGY201NG9jbnJC?=
 =?utf-8?B?QjVlRDdtWEFIZ2tLTXc2YWVXNFR1T3Q2RXZvRHc4dGtKdXltT1IvRjBQbUh2?=
 =?utf-8?B?S1NyU3BDQU13YzVaWWZPWVhpeEVMQnoxRWN2UHN5RXZKOGoxbGVBekNFQW5J?=
 =?utf-8?B?RTBrMEtiUmNPeTFMMithcVJrcmhXd0p0dnNZbWQ2WVF0dm1icGowR2pWZ3gx?=
 =?utf-8?B?RXlXemVTbk5VL0JEWmlIVW84c1F0UDlTSGVWQmxvTjgzNzcyYXd1QURRTHRC?=
 =?utf-8?B?Nkg5U3hOZUVOemVIWUVxSEVWSjRyZHNjMUYxWk03a2pLQ2xMSHVsTVJjcVQ1?=
 =?utf-8?B?alFVTmJreituTlgzNDA1VFM4dGJ4cTFOUmpRRHdOcUw1OC9DNE0zQy9Pa3RG?=
 =?utf-8?B?STJML2hISFVacmk1ejZaTFg0a2VaZW8xT1pxQVp2TEJqVmVBN3g3TkdNU0R1?=
 =?utf-8?B?ajZLcG5WRWdvT3ZkQ1dCSTF0b3NqanJWR0dmT0NjRllValZDcWdHb0hLRXJN?=
 =?utf-8?B?MS9CTmkzU3p6eGIzQzRXMVBQeXhDVnZQNU1MSlhQZXJIbkNmc2JRTDJpRkZS?=
 =?utf-8?B?VkR0ZFdOZSthMFBzR0wxdlhkQ3F4UzZvaDdOVzd2WDFCMkNheEdsb1ZiS3Q0?=
 =?utf-8?B?UEVoT2l2TVMxd0lXbDlTek92dndSNzJ1RFNoclFLTUJJUy9kZzBzTHpXeCtS?=
 =?utf-8?B?UFdaa25KZmx2WngzMjdGZEN2dzdCd0VxTVBiM3RWTGE0amVTcXNJVGU1Ny9Z?=
 =?utf-8?B?Z2FNQkV2VG1mazNnTm10MmFadTFTdldFTnRYY0FtMkdUZXZaV2NQQT09?=
X-Exchange-RoutingPolicyChecked:
	LfDbzdXzbhkgPk4uWhQ2XOiBnspCpD8tQ7BMXJNc8/5+ViOUotOaFN+ZG0NNvm/i+0J3Zgx4o69fjv0e7w5sTV41spPJ8zEdtY8fqn0SZwOxejm3hQfcSaT5dPlAYb0HgFdOROGF1sX7tXDkpzHXI8xLBrUqw8O9NBKi5q1M0LGFJ+MxZh4X95PFQwSxNRs50jPJQGUeII8CpPeMb018fZVw6dolgEVol4GB25AitQm1WAqnadR2mNbvc4q78ltfHfdf+j0Vfdf7kEYSOy1HW+puri6FwXt+AfPxkjg9eBQknmo2WIIln7aFYxzWDKY1uzXGWj/Cpls/qwVEuYilJA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G4MHmJIHQ8KxUSvvlmgTKGoI7o8gADfw69GmRuPWVwIPbUBXLkn4T95pHjooPVZO7+2LNERwy49PFHnU/RyCxFFQNYk61ozEkfQblLEk2Igpti3/NK/Ry4qOZ116iORUg+YA26ZfAmYb3NH+rnA3bDT+gLfcVf1QGKxdCtrTRg0Tg1n/Ae4GQpLkwMAOAUXuuPSeqzqJiY3xZoL/WZfWUCYadn/PQdJuv6ekI0cR58UTHzSaFnCTepW4FJgxpti9F9bEGmgJvcXt6QfWw6lTLmzLbrWb0th4TEzIRvvBubrR/TYDy+A0ewXJuxyNW/dYsVyvPipogyTJqzETgZYtEY79sMsHrkliYVS/5sfCT0knHovHoiJ2xlLG83QPGc2PP5cCNvMDtbWADxN8zuhRk+84M55HLSWkaT64HD4X8bGxVFvOcK2jLfpwrefOGgqK7upfANg7QGSYWjG+eeVeSvWQ8O/8eBViidT30YKJfmW3NApU1boc0rPdkv/I/oAwbaloXqV7zSbYSEsIbdPnQMOTADmPKUqKmp1z0e2XHRJCBYu8dkMdT07YaF88GgmETgRP3QbX3TCiKGO6wYvWiUnQMVj7xqBAuJt3ljWi3ms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8595ff7-3a66-41fa-0ba6-08df195c7ac3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 10:21:51.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJVPo2Ofl76OKiGSqKZ+Ty6oujYA0+ozsmk0vYiHj1sP3RTPwZm2EDwTEjTtTvOuUiWAWYjtky7+FU7KtKxLDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609230041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfXz4hhtv1ah5hd
 +H65nXJqs2aRUGwmNhVlCpL4P9hh9dNbQYKoPtwJMEeiaZl45EKPZZXYOH9Zt6QgYakoZM4x70r
 B4goNsCtgtU0ZdUKNrejR63m0QPjhUEGPgTxU1QWK1EAZGPAiu4u2AFmeyRn+/MM+9tByPL0YEA
 qBUJoLrB4Qy7NHBf0R5sKqISlB9777BnixcN2vaOaOJl8wX95MohdabsNAj7fPEbWo2ZGDo6O6X
 PgYoxZxMmrjlvyACPOSf5+bGazaHase6jNQ9r/vZrad7muh9ZuPuWXIuBqJDL2gB9ens8eIgqVO
 3RP57nh9eAzR/PGWALauCHhj/1y/35juFmuS8M6Z8Uu1H4CGBiG1k3EW9bshD9wAvSVAAD0SPEC
 tNkjrHwiELNYEkutRpC69Qn0lRe9xml9ZLXr/IFc+Q4gErB6ieZ4KGZi5JWNh390E8XYZC30qdu
 6wqJYuy7/s9w6RCohhhQWx5LAb9tAl6oqJ8S/EKk=
X-Proofpoint-ORIG-GUID: D8YrH4AnteHOaysHS917CIYTIAXEmSXX
X-Authority-Analysis: v=2.4 cv=UINIjyfy c=1 sm=1 tr=0 ts=6ab3a843 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=ruwdmTYRWUdhESn6eW0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-GUID: D8YrH4AnteHOaysHS917CIYTIAXEmSXX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX6YK7ES7N4dTB
 p9RK1pDPQaJZY/RLH8yu0Em/9QkbtuWVx4s8csKJqtno+fWV5/TPVDG9AAmm+A7jqP51wnMJELR
 T6xc8oyi4kYcJFaxBoC7nXeF5K7yCJME2DUm5ybsQCIi6ctB/IN+

On 18/09/2026 18:47, Håvard F. Aasen wrote:
> Use '\&' to prevent the line from being interpreted as a macro and
> eliminate a warning.
> 
> Can be tested with command:
>     LC_ALL=C.UTF-8 MANROFFSEQ='' MANWIDTH=80 man --warnings \
>         -E UTF-8 -l -Tutf8 -Z man-pages/pfunct.1  >/dev/null
> 
> Signed-off-by: Håvard F. Aasen <havard.f.aasen@pfft.no>

applied, thank you!

> ---
>  man-pages/pfunct.1 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man-pages/pfunct.1 b/man-pages/pfunct.1
> index 9482ac4..5ce203b 100644
> --- a/man-pages/pfunct.1
> +++ b/man-pages/pfunct.1
> @@ -212,7 +212,7 @@ $ pfunct --cc_inlined ~/src/bpf-next/vmlinux
>  clean_cache_range
>  copy_from_user_nmi
>  __insn_get_emulate_prefix
> -...
> +\&...
>  .fi
>  
>  .SH SEE ALSO

