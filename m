Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BC374A16;
	Sat,  3 Oct 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791022423; cv=fail; b=eUgZCTQmQB5njKLwGYtPI/nXPIqwTzogxojyBCKR/7TWeJMQSJ6pxL6KmFgfVdVyClIeO/1wNmfHCk9uSXYYnTbLlCZZJpG1eMQIPiZfl9IZvSAB22h57sSf01j+pB6cyzxW9midd8xNaVKT9L9bY55wLLazQqkEHKdYeSlYggo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791022423; c=relaxed/simple;
	bh=C4afGhsQAxShkes+/FdxMocZ46OE0i2LwWtGfOqdWbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OwXPKrFrVgWJtP/bHAaSgMkw6sFgnK2EhA7GGgxdXDQHMGstMKGQBeI15VkTxzSRor0Qf7arbu+Yv+V34BGrjwaVscH01ttduBlsIgZjZRyl0uTiSMPb9vm0Q4iW3UiXAUtY5aTojCrn1h6QVwnQFtFLQkVElO/mZp/gR2smjXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IbRuwaTF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eIHg9I9H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IbRuwaTF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eIHg9I9H"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693A0qOA1785671;
	Sat, 3 Oct 2026 10:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8CA+Rlngl3SuBE0NVR7oy54/0NJMHluLPh+Vu/Fg7SU=; b=
	IbRuwaTFDWioSWPSCQtYgjjo6ycEXIhcS2eWVqkiyIZKOdmiqqOj5vzrO2OUG8hR
	/ADo6pHJcfPGff3RwxAyhSkVMAj3a/wJGoH2oY82mJnP1iGiXAqqDyXlLY19sxik
	+qz0ZRTRuyzugYGopwfKuTwRL5soDPhSpqetI/YbE+JbUDXcbe0Pa4RPHEiXML7J
	9wYqx9xQGMtJW6YHigP1oXEOo2bVucDxuweovI5pD+MZ0dmkXp9hHOcH6vkKCy90
	FExQDrt2eyK97hz9PdiDlktO+1hHLa+JISxsOnJFeE5TKw1UIma+Ag/RhHSr2PHY
	DoRqdvpsA4QjfD1FWTw/gA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2rm986a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 10:13:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693A516a004578;
	Sat, 3 Oct 2026 10:13:15 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r597bc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 03 Oct 2026 10:13:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTnxMrZ4K9DRvDIAuq25HP27aAKgNjJ9fhjj3LMEOpOYSVyrmLEhr/aSF7UvYbVN4BzR3+6s9ouqRCSloq5klVEFXvT+KrYdtkZGHH6gE9agq5il7QV08T4sdOJQYsu9wMM0bQfQURTqu2CKaMktREMptbSSkoXbcO4ykkvZ3bLxS7Pbhsgg+IqnFbbasxcWZArCGjPXwS3F7jbB8k+tKhM0I1j1XUKnPWS1JUpZT3m49Ga17FCvd21gXZPyaUgY2MSp4HcKVgeIHrRGpz9VnX8pX1YxBbeEszU+8hzvuJmiBe5nb9hqkhVpPeGtd0sm87N5xagUHnSNyt4pxuRajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CA+Rlngl3SuBE0NVR7oy54/0NJMHluLPh+Vu/Fg7SU=;
 b=t2K80+31c3VvWD2+Mw8RHMnxkUMbblXB4HtG5orPsMEJZDR+INT9n8Ayezvg5qrPIEw5pJHil2FR9bnDgyLXZX5mjaz1ykxwk2XaNOPkb0cfpNVbazRXV9ssaFENCTM9iTLybf5AsTyyw7MQpaSYythFjOONY6C1ah8DGEHCO/KjaWDRUDrkp0oIfgvf7MYfZ9mm61WCsDCXU//SV4YN2Ap/wX25z2iYszsN1CTM0wNIb7ge0euTinrgEMJ3DaPSXh2eOmS7AtrH4HRSIFTrsTdYUBVBjPAmVeR6+S2Ytf+U7o91rPIjqPCehq0W+IwgW1tuln53eHel4SW8JemZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CA+Rlngl3SuBE0NVR7oy54/0NJMHluLPh+Vu/Fg7SU=;
 b=eIHg9I9HDt/LXbwh8TdGWJL6BBuGD2mHwl9wYsBei7qkOyD3R176m0kV9KkCkojDXM5i+TbA/36NxyvJzP3zBbTGapHY/wHqTLgoKl93GwXX4v2IQoGOf586GvKQ725Zjxh5QQkX5zFFTYLkRms1ZRFpNLqfFT2P9LsC4zLrjfk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SA1PR10MB997628.namprd10.prod.outlook.com (2603:10b6:806:4b6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Sat, 3 Oct
 2026 10:13:12 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Sat, 3 Oct 2026
 10:13:12 +0000
Message-ID: <ef844c36-04f6-4936-b7bd-0e733195dffd@oracle.com>
Date: Sat, 3 Oct 2026 11:13:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 dwarves 00/10] Encoding of inline functions using BTF
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20261002174043.3823987-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SA1PR10MB997628:EE_
X-MS-Office365-Filtering-Correlation-Id: fba96ed0-036b-45cf-8185-08df2136ee43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|1800799024|376014|6133799003|22082099003|18002099003|56012099006|5023799004|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	KXrf0PPuCTg2B4D+OQU6Bbzq9Gs47ogzgzuqzIqOimlrIAVgJLCyoYh71utX0u5noYGJVRwCUpNwXnwo/P6/e0AKzXj7snFPGXHwStgdF4iptm0zsD3hDTK830P8tyGveQaVxzFDrqYF4O2GEbbKXPmm63T9798cwDZSXFGiDaQbymES5Q1IhMAj18XazkIGzmBvSOOK6MrBl+aR35RvqmOiBG42pYrNrxAA9JCeGY0D1b+3W1e/w7aPLhIJNSGkkk+/Uq24y2xzYEwLe7E85AgA8mbO9gn22fDhO5toCaFuc4KrnHRVjnqaOivE8EN7xiCH50lrpN0xTncsGC1yDreVtucaEvT8HWAJv9svffjyr7U6LFDmI295yxKL7YwiVOhLgv0xpQLZDk36/vae1ghOlBDfpHEMcb6tNjVfFC4bn8pe5FohEJnXR9L/KHpkZWHrr+CMe/CBeYLBRJFzA6VfUUl10xtQHqnCN0jHy/tcYKOp0+hkw+nGGlDU63SMo3wO51AXUXitRkuGUU0B0RSY65VCRD6rI7B7YQkw6TBPSPx2cTjWylf3zS3f4W+TMmsCTD4VKQc2WZEyNiEuY1s/Zdu1kasS7HLhSuf0uM4tpImEBbuJdhXxgUKpBI3nLke5siawEPiPtT43P7NTjei0tVNXw6L23J9pIoynCSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnNKY0pVRFh4Y2xYSTVBdUZhc2IwSFVBaWxNK0hhMmdROGVSZEYrN3F5cG9H?=
 =?utf-8?B?ZkFmMjZDUUNmVzA1WjJpdnFFcC9xdjFBQ2xvakpTN29VWTY4Y0k4L1Qwb3RD?=
 =?utf-8?B?eWw4bW4wS2YyU0ZQYXdtUjFZdEx0SVNuMGFFNnlPZlk5a3dldFFDcDh2bHdm?=
 =?utf-8?B?OHhPdERuanJHaTZyL2tiNGRQelUwSkNsNVlGckVsbFRzZnFuZFVEQnNESWZr?=
 =?utf-8?B?eitORVgrNllGTjR2OTVmZS80cVJyYndBRm9oWHhFZmVJOE0zMDlidEtoM2Fh?=
 =?utf-8?B?SW9FTjJpTHJ0eWZlRUEvYW42QS8rL1RKVW5pditTcHlSODQ0RDRodnJBbkQv?=
 =?utf-8?B?cmtaSVhYNGI0SE1hSStGc0RmeXdFM2tsQnBTRVZreWdrTTlKR0t0Q3FYTHRL?=
 =?utf-8?B?TXV4bUlUaTVxYmFXbXZxcWNQd3Q1TFNBQkQ3a1FPbkU2Vi8vcGMwRjRTNlUr?=
 =?utf-8?B?U1dMUzArZVAwbG5kaUZzWlhrU3FLREZNSThCakRMUXFac0dvaCt4ZlZxUCtQ?=
 =?utf-8?B?TmIvTGRlbGd1cy9EUEYwR0RJSHYyWUhFaEM0SzduaTlGaks2ZzBsNnVXdi9h?=
 =?utf-8?B?cFRzVklHSVgwOWptTnRBWmlQcFZ0WU01VW56UmpEOUNwd0VXSE55MEpXbXk5?=
 =?utf-8?B?OWFjbmpzKzQrVGZ5MGpNbTB5K1pidGg4NEFSMDhTeDM5RE9xY09mZUd2dVBp?=
 =?utf-8?B?R0ZUbW5NUHVMeHZjdG1qNGVtWExQaWV6L3FEaE4xUWt4U2RnZTN3S3RMdlIv?=
 =?utf-8?B?TlVlcUg2NHN3dWNPaE9rSW02L2dSZ3JzWTdBaTg3TFVweS9COHBOK1lVcWU1?=
 =?utf-8?B?cTBDYVRCelZOK0thQ1BtUVhIYys3b1ZncU5QMFZoNCtHSGJPQ2hYRlN5Rk83?=
 =?utf-8?B?dEd3YTNzYzltdjJDQlA4SVNpNVdvbVpybjR0Ymt5U2xPQitzT0JKRjMxLysv?=
 =?utf-8?B?d002d0tiTzRmVFRKM204eHRzd1BNTjVxZUdkVUhrNElOU1BoWnFXVWtGdFp3?=
 =?utf-8?B?UG4wbmtxWU40bGxOSlZ5S0Y3UXRtYiswWnBHWHBFVE85ZTFyU3g5ZmYwbWsx?=
 =?utf-8?B?dVFKd3I2V2xaL2VjUkpEVXliWEl4dWc5Vk1vYk10azZ2SnVoUm9FYjJXNnZ5?=
 =?utf-8?B?K0xRV2ZKN2JKemt2VjBaZjZ5ZVdWT0g4ZFhIN3o5RXVSLzhjQnVZZG9kbFVk?=
 =?utf-8?B?Um9NQUs3cEJKOWJQV0ZKN0h1R2ZvYmc2Tzk5dkdOTitDTkNqaU45UEVwL2tD?=
 =?utf-8?B?NjkvYXBWZThyWGZHR3RsNzh0SUlNTEc2N3RGWkcwaVdDY1hDTlFmdmk2Sm1P?=
 =?utf-8?B?RFowbHRiVEJ3K3ZKeEMxWndFTGkvZll0dnVKaUZqVm14eVBocnc1a1FFQ2dy?=
 =?utf-8?B?Z3NYaVFCZExDU2c1RmpDTnh4cjE5ekpUTlZwQUlEbjdUcU5iU1Z6UmZpbVk2?=
 =?utf-8?B?RmxoVVBCbVpsYkdnN2Q5Zmt1RUl2VEFHUkh0UWpTVUV2NzVVSHZZeHhpd25L?=
 =?utf-8?B?U0NBRlZZNmpmRGJ2UGdRa2Fxb0UySDVUV3VFUjlFTGhFL096NDJWQVBnaVRI?=
 =?utf-8?B?K2dNbWpKT0J5UE5UMzdRSytmK0gxOTN0a2NsaXJhLzJwdVNQSVp0clJINjFD?=
 =?utf-8?B?d0IrTlc0RmVoQmg5N1BhU3JwSUhyMU1Zblh6TGZtTWxrUjRwWllVenQ2clJQ?=
 =?utf-8?B?SVBIZGY5eDFnOXFPR29jRVRkdHVRc09oSzZoSHU5NkR2WDRlZmd6WFJnNVhN?=
 =?utf-8?B?bGowcGZEbmUrRFkwOVNPbEFIMEJLRTRLTkxFeGhqaG5aSzUxYXFwWWgvTUxk?=
 =?utf-8?B?cC9rS0NTVk9QTkNBREFDSzRBRG5VcFdGZEo1Si96em5CMkg4OS94QjBDL0x3?=
 =?utf-8?B?RDlGOUpBVjYwWFByY0laa0hrTjJqYms4aVVKdk15RUFCbU40V1o5dFdIQWRm?=
 =?utf-8?B?R3RYRkk0RjJxNmZhNTFHVFZyb0xjWHZtS0pPTFQxTXR0eFF3U2IzTHl6UDA0?=
 =?utf-8?B?Yk1XQUFLLzBpYUROTnRPTnllTFhNT1FkZkxYVE1GK3IzMUlmbjJmdTBsbWd1?=
 =?utf-8?B?bldWRnVhMlZxWlRqWGI2SXd4S2JDVXFNSjRmL0wxNWNNbnNGSXZRbnd2TTgz?=
 =?utf-8?B?eXdPQzlSaGlweUZvYk5aUUlqWHZ2U0dqQk5ycmVUVjkyaFBRd2xYYVlzcVRJ?=
 =?utf-8?B?OUFaU0xtVVpKZENjeWdlT3RjK0J6VEt3RU9NL2M2SGQ4MHZRaHpEOHRJWWU1?=
 =?utf-8?B?WjVPZkJqZEdiT3oxSi9BWE5wWnoxZkY0Q2xEalUveWUwNWN0OXZLOU1keHQx?=
 =?utf-8?B?YllhcTNHL21mUXlFbW9kamc5cGhxdWcvZzVLbllwWTlGZ2gyZUpSZz09?=
X-Exchange-RoutingPolicyChecked:
	yR1/HvRBAIGowicL53lSy05mj373/A6EeO9vEoRGWve24Kiv/xv1DE6nlbqo11c6X/bL6LRAhVI8Dsu+AWEthLTUXgQvpFkMDO8jKTE3yxzz88AsDImzmN0T+3Jksx7PUjMZG5z8LT0xrjFgy8hoZH/rTuIASri+S1wDHO+W68JHnI9kI0NiLBq6whdk9V2B7kl+QOHywSqsCGJTowV+DbUJir+QOMWeBQw38fq+jm/oXxJkEehlRYUS4gZ+nnaQF75gvlX8QcbiVJZ/6N6aRqJxD1HRHRMJWTHue3XD+I0XwKx1V9AIVFPy7B+1w/SCpnt+WZDfGGYv2RdKsCtC/g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vSm1qqGZS4EQ0ZQI0sGfwEuQ3f3/AzhqV9U421OCAboL0MPCnSlpqriSwGLDl08H6eIH0b9a5HSkzaXaND/BKQJkPyWItzvsFh3AkLAmA3VkjimPdjK7o3L4DOWNk+BTn/2xO4QRbD6dEXAa4DcbZBAY0waOpIUF5VvRzj04Vz524NF+OJ6JCDjOv17PEpo2D1kXa8KeLFWOkcsbcgCxgEqsgT9eggW6IuihPPbulkhRrsgiCyhh8IFTvwaQdUdTYJHeDdYrQr1lkyNvQzBezQHEDtpE30p31hgINJqBmrvEv4WfmwfweR8FeMqn18egB/YH6NzmK+zVljsl7a/KmPssmyfbfxjBb5jyIP7ZZPjxbzy+WjfqZ6Q4Hq80YKnYLBXZTb1iO9WMnDabZ9G3FzTRLMQDjo+G+TYNZhMUEFQXKxWfCjv6HvLiuH1Ly0PUxPPyeGvqw+e7pKbcdRg08zLUXSWSDx8vFihJmz9+iPsLUPo68Tr7YZ76obwwCRVluYX6t2vlathI3/a4RGoQCfcJ9UleXqfLtJYlQjVUUSfCU8ab7PKAZeiJQrt4EAF+nO2wcl79vZFSoOD93IqjICmYX24ETjgoKY/43AcGncw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba96ed0-036b-45cf-8185-08df2136ee43
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 10:13:12.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBxBmMIqvic15BBpjptAqqIdTRqM0vNrAohurTs1b4sFgTSqVHrf6avMWb/r058UBcbgXVU85nXNNweNcgJVLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030040
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA0MCBTYWx0ZWRfX6QzMWOMCQIFs
 oRstLp+KLvECarBOFifC5Cnjicc+hu//rziPM6aLiwCNuMLlmwRdwGMp5QDXWWM4J+OL2R9/h64
 R/40oiYHymswKIeFbfDd6lO6oY4bzyrObrYs2TRihtzXXr3gut3qm7poB0L8bxsbWK3O/d/ado0
 kNHSbDF8sFa6uR5NkTAObDmOTAM2Sv6ZT5oju9+/gY0kffOFIlroMX9FK+ajepRHIk0BGdzWOyI
 /fvf24I1sBxG4hI9P2PM6xj86dpXTkuB5EhGR0Xisxni50MAwySOxCTXX3Ypxvky2x3rH22wasn
 nRKDw3U3Z8AwDZi5skzko8DP9ydlAN+lm7VCnGHuYJV33ZXPL4coXq7RYyK1mkvD5BcOKOem5GW
 sX4bYScsoIeQdUYJPztkV1x8PSuqXZOE5gzV3p3wzqnvqauFYTN7OcBcpPjiOegwELjlYKHvtNQ
 8xMzSC4UY2wIwscy85A==
X-Authority-Analysis: v=2.4 cv=QMD91QLL c=1 sm=1 tr=0 ts=6ac0d53c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=PxxNKYubCvPY1B6V7VsA:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: HPjwZ0GYHTIxK41o4PuK_i_FPk6RX-RL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA0MCBTYWx0ZWRfX0xiP0d9uiAnO
 5akRBOKTWUeyc3j7mO5kWsIWUPwX1EojRInIIBLzp4gs5dtaFQeQ8VmQtgVWqfxE+CFFuvmNX66
 r7wQ8BaSibv0NOW64d8KUhrhJg98Dzgq5PcloyiZ9wKbzR9uYL9b
X-Proofpoint-GUID: HPjwZ0GYHTIxK41o4PuK_i_FPk6RX-RL

On 02/10/2026 18:40, Alan Maguire wrote:
> Support encoding information about inline functions using BTF,
> in particular the libbpf interfaces added in [1].
> 
> When the "inline" BTF feature keywords is added, we also process
> and encode BTF_KIND_LOC_PROTO, PARAM and LOCSEC info for inline
> functions as part of CU traversal. Patches 1-3 add dwarf_loader
> support for this; patch 4 then uses libbpf interfaces to add
> inline info to the generated BTF. Patch 5 adds support to
> the btf_loader to support recognition of inline functions in
> BTF, supporting pfunct rendering of a function as inline.
> Patch 6 verifies that encoding and display of inline functions
> succeeds.
> 
> Inline support is gated by presence of BTF location-related
> functions in libbpf; either use a bpf-next libbpf containing
> the series [1] or use the embedded libbpf (the default)
> from latest pahole.
> 
> To verify all is working,
> 
>     pahole --supported_btf_features
> 
> should show "inline".
> 
> Patches 1-4 prep the dwarf_loader to collect inline info;
> patch 5 converts it to BTF; patch 6 adds the inline annotation
> to pfunct output via BTF inline info; patch 7 creates an
> inline site representation in the btf loader for use in patch
> 8 for the --inline_sites display; patch 9 tests inline display
> via pfunct and patch 10 updates docs.
> 
> $ pahole -J --btf_features=default,inline  \
> --btf_encode_detached=/tmp/vmlinux+inline vmlinux
> $ pfunct --inline_sites --elf=vmlinux /tmp/vmlinux+inline
> 0xffffffff8120004a [trace_initcall_start_cb+0xa, .text +0x20004a] task_pid_nr(struct task_struct * tsk [%rax])
> 0xffffffff8120005f [trace_initcall_start_cb+0x1f, .text +0x20005f] get_current(void)
> 0xffffffff81200090 [trace_initcall_level+0x0, .text +0x200090] arch_static_branch(const struct static_key *  key [addr 0xffffffff83e275e8], const bool  branch [const 0])
> 0xffffffff81200097 [trace_initcall_level+0x7, .text +0x200097] __do_trace_initcall_level(const char  * level [%rdi])
> ...
> 
> The --elf uses ELF sections/arch info from vmlinux to render
> registers, absolute addresses from base/section relative.
> 
> The --running option can be used on inline BTF and the running
> kernel (kallsyms) is used for address resolution; this ensures
> that kASLR is taken into account. However if kptr_restrict is
> active /proc/kallsyms will show address 0 for kernel functions,
> so pfunct should be run with privileges in such cases if absolute
> address representations are needed.
> 
> The kbuild infrastructure will split inline info out into a
> separate split BTF object, but pahole encodes inline info
> together in the same BTF object here; this avoids the need to
> invoke it twice during kernel builds.
> 
> Changes since v4:
> 
> - Removed unneeded bool (Jiri, patch 1)
> - Split adding parameters to inline expansion (patch 1) from
>   recoding changes (Jiri, patch 2)
> - Fixed issue with parameter indexing for inlne sites; use ordering
>   from abstract origin (Jiri, patch 2)
> - Fixed issues with PIE binaries; our section checking for instruction
>   pointers did not work there.  Fix (patch 5) and update test to do
>   PIE and non-PIE validation of inline encoding (patch 9)
> 
> [1] https://lore.kernel.org/bpf/20260924111428.75957-1-alan.maguire@oracle.com/
> [2] https://lore.kernel.org/dwarves/20260925185200.1318067-1-alan.maguire@oracle.com/
>

series is applied; added one follow-on fix to handle an introduced issue in

dwarf_loader: Ignore dereferenced locations in ABI checks

This fixes an issue where clang kernel builds were omitting functions due to
an inline-intended test being applied to function signatures.

 
> Alan Maguire (10):
>   dwarf_loader: Add parameter list to inline expansions
>   dwarf_loader: Recode inline expansion parameter types
>   dwarf_loader: Resolve inline expansion names during recoding
>   dwarf_loader: Collect inline expansion location data
>   pahole: Support inline BTF location encoding
>   btf_loader: Add "inline" annotation for inlined functions
>   btf_loader: Record inline sites in CU for BTF
>   pfunct: Print inline site information
>   tests: Validate inline BTF encoding
>   man-pages: Document --inline_sites option
> 
>  btf_encoder.c       | 427 ++++++++++++++++++++++----
>  btf_loader.c        |  96 +++++-
>  dwarf_loader.c      | 581 +++++++++++++++++++++++++----------
>  dwarves.c           |  35 +++
>  dwarves.h           |  69 +++++
>  man-pages/pfunct.1  |  74 ++++-
>  pahole.c            |  12 +
>  pfunct.c            | 718 ++++++++++++++++++++++++++++++++++++++++++--
>  tests/btf_inline.sh | 155 ++++++++++
>  9 files changed, 1917 insertions(+), 250 deletions(-)
>  create mode 100755 tests/btf_inline.sh
> 

