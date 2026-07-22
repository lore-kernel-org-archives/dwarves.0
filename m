Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADC439F94;
	Wed, 22 Jul 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735671; cv=fail; b=jeT9JtT51hRYsMBjmouHdRBshbtQ7UhghQpccE0ijTqmQ754bzVl1kqG4t1FxS5R9sjT98Sgc8F89Lk0ci8kpj9bEPHhjKN1EY29bc5OVzmUAvCfpMhs6AtmDWp3kCbR1fI1NtkmW8COBuJ3nzFmYjxQ0DS1VFgQKQaoxOJNVBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735671; c=relaxed/simple;
	bh=tLUc5HNqfkBvyXPUwaLT+p5uPKgIKPlmtF4lqBNDfnw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=uWVK8XPIhLMeh0BFy1Fe+8Pe8bjGXAqO9B8G+f3thsDV97inpRWz23aUJ7tLM8yQT99+8VcgKY9lKUkRHhuGrSXEpCAWyV/e89OiGrGiRJ1VxHbA/Gdu9KY5TXs27OLeqazxqTqdS4lUDzNEAemzy58YstC8nF1/oxEif8UHzxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H9/UbLPG; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i7aut7bs reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H9/UbLPG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i7aut7bs"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MCwViR2613189;
	Wed, 22 Jul 2026 15:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EmBntq3iodDLb5FN0Oq4Azj+6Hyx3/eIt6ppQS2eoIQ=; b=
	H9/UbLPGfmcDD5raHeIqv3JMUQ4tztO9hFBNdSERWsUQDqWXf2g9lbARcH6DpX4B
	C3uf1SXc49wyAEyNzrNR53sd2D3X+ypfUckZct5C9yU21lqZAKJXEFzA9ekUDxYJ
	/9YrxOx4EMwnAjsLvEaFh28uPtGF4+6/jXQ6kJBfuq+lpU67rMo0D7Y8GQ0Az/IW
	ij4eDV9Qvg/QiV8WMSG1bNoSoWBTP9sEvQKMdNGJ5ZBm+8s3EMFpD3DhZQV1cw4Y
	uCc95mNCBN/PScCUomQPG8dzDD/8HLAs47gIItDq0BRZWSPsTzHhfHHJt+L1fEfs
	OmG1XYCJpesgx0cckrTVZQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1mv5eyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 15:54:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66MFrJ2P004702;
	Wed, 22 Jul 2026 15:54:25 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxdt20k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 15:54:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq+mG3BHuICvNF2IwqVu83MNbba6oGT7JKPI/wy5O3qw5BWHQnZYeq85DrCEocFejZ5pP6uagElJVEbL4sPND9Z9jybMrAaT4nZm677sNITyR8zjvD/hMpxDDrgSeRAHJh/65iVTWm0su7FRV3Q7t95b63W62LZrEDtxlEUxtPfOFeXBHSUTbDMHOPihsACBHhvgTv4W+FZkWMDDnSrwXbc2ATersT80KRxUaM2E7pkG7XM9QqW4kycV/9CSaoHo/dxWMSBcDna07kgT02fzWh2oIaK+R73tGmj/P64QNywl13aSuT3uqBTG+SS5dRyTC/LJDp8IR0zDyNTeGHrAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frLNINPLzkcfgBxXY2Le8Oxn7bo0aRChUUH5Li0mlpw=;
 b=TDl85Pg2HRMVwI6uZaqyFFjlttfk/G3+PgttawfukaMmRk5UYI8HNz3Q2WzDN0Vo4fEJ0GdHoC8vAmtOcwKJXIe8vBeOz6X6UBPxX31KZVFi8x/QmyJHeT6PKULsMbU/urKgbjkSGuf/qGTnO+IhHDj5ZTLiHg708vF6MxkM8jlNAZviXNRC42wPdzsSmPmpVnELJVfnlQ6JB2EAR3RKkgraFEnU1RrEJO0zI/7aQRQmRZnFPlKge9CKLU7y/P1myRP4e0Vz4/dY1kkPV1Yj7+aeuAg+KauiCr5jVTLswhlAPndxX8gU+dQdkacE06NMK8KPas3hRA5mZX751VEzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frLNINPLzkcfgBxXY2Le8Oxn7bo0aRChUUH5Li0mlpw=;
 b=i7aut7bszX7p30yRm76zTxi1AZCKl8SD8iNRLQf5G5xJintdEbgZ+fQpVYPuuUIghG0uJ+G2GsOwgDozAXJ17EEjBvj5RmUUX34NBLkWQR+GCfVBkOifBtQ3QXwh16ZM/RKLKjCnPxEBj+GhqkhtMZtpJHo8QihCmK+X6mOVl7M=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MN6PR10MB8096.namprd10.prod.outlook.com (2603:10b6:208:4f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:54:22 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:54:22 +0000
Message-ID: <9c6a9c82-fb9f-4986-ae3f-33f7073cd70f@oracle.com>
Date: Wed, 22 Jul 2026 16:54:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 0/2] clang true signature follow-on
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, olsajiri@gmail.com
Cc: arnaldo.melo@gmail.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
References: <20260714135035.814273-1-alan.maguire@oracle.com>
Content-Language: en-GB
In-Reply-To: <20260714135035.814273-1-alan.maguire@oracle.com>
X-ClientProxiedBy: LO4P123CA0646.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::15) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MN6PR10MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fbae03-aa17-488b-f517-08dee8097f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|56012099006|22082099003|18002099003|4133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LL39s0oy2Re/r5LU1509JZKLcvFZjBQNBltxltzxAp0xoPDqSdFD6Yhf1RuEpyeuOX+P1/act+VIIzW1F1DMUaDcOAVj+Z2shz1uHdukby6BQ14cgZVeC58b5vG1JVHvMxISuoVkl+40yGGvD9eCGSFAfH8u89iLkRKM7wIob8GtA17tBTsZOKvbRi3h40qrzd7+2Jx4BseLdUDGI4/HeNJcuVVc03Yu1DtGNWmuf1eKTm4yA8IyqkXdjH6VatLlhQ3anpWVz2eb9dQnn0vY1tlaOy6BgpOEXnQVgo05F4Ic8+3ZdQf/x76cBj5EMVaPX5W64W1yVFO+wnBRM15mHo9PZ1fquzMcXmTXNeuN8GkIKMKdLsF9vKoGPWU2dm3HJGYyKuf6i7M1rNLCALRs4/7y8FxfHoMzisQar4GqqeNRQWPpFXXMDeoifMRaSCiMx6dKuteCayoeZM/oN/6oLVt2pxJN80PvmYbtYRIIK+8hzZ4nFyIyV+eopMqgJX+MFkgze9pJr1kOSBwj5fN2qia9OiyE5gsTYXqMmUtt4c1x3VSoZ2857CCKa9wA6tQ39zW6pWepwoWOCCYnLW0R0+1eHlAGY9+ZyWRQ6689rzm22cQL/oMj4oml24nUXxT3FpI7ktdc99uSM3LnBqGD0OkixuufFtsGIshuh8TOZss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(4133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjZ3UU1NQmt3R2l5STZWWGN4ZWJhczZMZGh6MVlyelFWT0RlVmVubmlNTEdI?=
 =?utf-8?B?SmtoaTQwWHU4eTJWNSswOUhCRXlRQlpKZmQ3M2NNOGhYalJua3J4ODFyaTdO?=
 =?utf-8?B?S0p4NGNmVW1RUUR6WjFQWG41OXAvWWlJQkRVVkVhQkUydTIvcmxvRVQ1S1Rq?=
 =?utf-8?B?aHJDMExWSjJrRXNnREFqcGR4REh5czgrSzdqcTIrblc2NkpiZThjVDZiaTln?=
 =?utf-8?B?YVM2aTBoZlU1L0NjWU44dFk4RFFMME40MWc4VjQ0bDRwOU1TMHh4UEU4ck9E?=
 =?utf-8?B?QnY1c1JISERjWjd0a3k1ZVlQSGRIcTJ4bDR6T3FCMTZla09tOUJKN2w5MFgv?=
 =?utf-8?B?bFM2MWlYRGhsNVJ6U1NDdkhXVjhyKzFJM2plUTNMUUg4UXVqb1h0bFR5cld4?=
 =?utf-8?B?RDZpZXZyT1k1S3FxeFFlVXZsZ21qMFV5dVkxb3FkN040QUNUaU14Umgxb0RW?=
 =?utf-8?B?MFU3TGtjSUxUMkp6Q0dqNTNnaFZ2OERGQU53SWJmZU9VNDNYVHJHNXY0emdq?=
 =?utf-8?B?bXVXRXBzMWowN0tETHZodDBwa2NCY3VXdjZteVVpVnVPb2RyUFJVVTFJU1kw?=
 =?utf-8?B?elhIZndLcE9yRzd0YlpJYVQrSFBhcFdOS25UOUxib0xXcUFqWExkQlRTdWsy?=
 =?utf-8?B?YW9KK3dWbzZmc1hyRlpKb2d4cGFCVmZoTVlsalNYbWpIZDdkb2IyZE5PWEIv?=
 =?utf-8?B?SmRjZGpPcDl3Wng5WUlGaCtUMVZvc0FYc05Zc3B0SE5qQSs0Sy95MEV0cUM1?=
 =?utf-8?B?L010aDV1dUw5YlZ4OHNVbTdNUzdGYThOaWlHWFY5Vjh0SVl4L2JYQnU0MnZz?=
 =?utf-8?B?dXYvZWZXNnFES3N0OXFaM0xzd2phUVRtUC82TVpZQUR3eUVkTW54Q2NQT2hR?=
 =?utf-8?B?RklleVl0Tkx1eHVhU0lTTnRHZlVqRVRGNk5XOE9oVWljZnlqNEo2V2U2MkZQ?=
 =?utf-8?B?bTl0cGt6ay9Jc0RwRzVzT2xFekhqcEx2OFNldnpwQmppRFNyN0pVZ2c0WDI1?=
 =?utf-8?B?SGJoTnNUSnVIYjFjK1ljQU8zeEVzaDg5ZzNWNDBFTmtwV2FIYktkR3Zyam9Z?=
 =?utf-8?B?U1hzenlZYVB3bXI0WGNjRmFsaXFYcUptQS9sMkVZYWdXbmRYNWZxN0piZ05h?=
 =?utf-8?B?VVNobXRJemNYakU3WkthYStmdFNlVzAwbmJGQXhZTkg0SE5DK2Fwa0l1Ulpl?=
 =?utf-8?B?c1dEV1VOM3FpR0Z1MEVma0RoL09oazRwYkl4cXMydmRCSkIyS2VRbkhZd1N3?=
 =?utf-8?B?dnpLQkVCY1JTbC90eC9ZelZMMUZxcDdaZi9yOFk5MnlzUWZWTk01ZUNOTEh0?=
 =?utf-8?B?YjZ1YXZveURkVytVZ3lhdkx3N2MxOUR0VnFOTVY3azQ0SWNvUFhqZlBhVXpF?=
 =?utf-8?B?WWMwclJkVkQrUVNkaFFIZUd1SUR1SUJ3MVIvdGN3eDBBaGhTNTFxWGc0Wlhn?=
 =?utf-8?B?K1VCUHRoYTVKaXlwbitudmxvTi9OUUZtUUpiUkx2c2V5R1RHYldNdmY5UTBw?=
 =?utf-8?B?c3h1SmYxSjFtWVo2azA3V1JucWVIVjc4VlpOOWZ1MlVrWlJQcWFYb2VaZ2xP?=
 =?utf-8?B?L2lqVkVuSWs1eklyR25aMEpJVWZVNGdHbXNFRFZsVmRBQWZ5UGFkaDBxb0tE?=
 =?utf-8?B?eTkzUmJ0SERWa25JQ0ZsTXpCSU5rN2Jwb2VJaGtJQlMxTnVmQlp5MDIwcFpV?=
 =?utf-8?B?aERzNWo3cTZmNHVGUDl5Mmh3cHN5VC90aGxtUlVZYzZaU0dIbmxuWms3NmlF?=
 =?utf-8?B?UVdyb0IyRmduZ3kxS1QvdXhJRHd6d0pYNnZMU2QzWFU0Tm56Z090ZWN2UUVR?=
 =?utf-8?B?T2JiRy8xcTcyOEgxNU5kaVZsN25UcUxHZHR3RDhRZTRyc0VWM2xEYVg2dWIr?=
 =?utf-8?B?dEpKaHVSYTljZk1kQ3BMVmhFZXk4N0FNdm9ZeHJvZUJxTTdLeTdYZjdtTDI5?=
 =?utf-8?B?YjltRTEwQStjYWFlZGZhQkFrUVA4V1BwYmtwL2xLVXBNSWRBSUNQRzk4emps?=
 =?utf-8?B?WTQxaVo4TXYwcFZJU0RaSE9Gb3E2MFlGRGxSYTlkK1JTYXhLbko1WkM1Rkhm?=
 =?utf-8?B?dFc4QTdlK2R4dGtqSFJ4VElwSXVUcTFFRjdnOGRmUXk1MDdnR2RwaDlkL2dG?=
 =?utf-8?B?bXB4ZU4wUVg1ZkIyQ3l1V3BVWTBtcnQ5Zis4Q1BHbGlYRUdJNWVsMTc3RFJW?=
 =?utf-8?B?N2ZVeUpQOFMyYzZsajBSUUNNU1dWcmJlUE0za2EzTlVoT1NlNDFVTGwzeUtp?=
 =?utf-8?B?NzdhSEJZTm1ZVjNSellqUHcxUnRXNzBweWRHWjlvckUyWktXNzNTRGs1NEh5?=
 =?utf-8?B?QVdpY3hlWjEyd1ZSNnBENzJVNW9HeUxjRm1wSVlQdG1qNkNZLzJ0QT09?=
X-Exchange-RoutingPolicyChecked:
	DZzqtwU/YEGSoiakEhjVfcx3W3sNZwTv/DNB+HnPzfAQrtfvKSY75ydOvVbh0sQYOYsFuuzjW8TWVpdtTn2i7gtP7fY923NX2LblgoyU9ycTr8Wdukhv6LIhRC3SToMWLLLJwyOfyxTdawUiy3Z+3PlaZzIh9Q4ztKUsjh54rBZhs+TSd03kkuz7/bdQx/8h+gNzcVRyRx3ygjLet179YKziVh0YML4ry1roLr2c0zkGpmnInhZL247lY9+hYUJAYFlpNeFK+oBM2p3xpv9VG3b8x++HgxZ873Xy0J4fxmyOhX4doIrLcm4QSdqPUomXJbKt4lCYYW5pX/WIg0EOrw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N0eI5wbxRTez0G9ACNjRoT5EdZe3plgfwKOyr775E9CHT3FaS4v/rXdaZl+747uMCD1cPKjUZB9CYrwwzTqYyoCv4+4+bbbmk/LEHy9fDOsl7H4jqGzU/ujBWNy64b6bizxqyLlUb9HKpj2cmHCQs17yL+nmrD2QfA3xAIqfjOm8esA3dpUpccCDCP/gJEK2RAo4je7leXlb1lmrwfE54k47vDQZ6QBicpsSbMTUyeo/CW5M46sV77KvY9/85Mq23aEFN541dy6HZjdepqe19NPq+2TjGxW77EbL3flhrYXJ9psdLa+5ovwuu6bkAClocAtbu2IFytrx+UuvuF2+Xak2PdWfqx1spoVfAfLek2a7vFnskOqYTt53aljkJcrHGrnAZVWMjiQNXbJuwEBgyumNo/hzDPNSMW/fsVooPw1QipXDrwWMYa7CkpGlrJgepAXKS/V5gEORa/h8+1vNBTEO2rwVYW/CiUcmuxcqs2qDgDwlvfkdmmb42MyUQyoXT7KsgAQ8SqTPaRY1Tw1de3h+sGxmv8rrtaHeI++POWhEiIoY/k6S2F+zlIcAPn3CJsTjgFUz31eLiMD1EVu93i49jxcj9YEcJflOEQbyf+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fbae03-aa17-488b-f517-08dee8097f42
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:54:22.2086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jZ0QjTWHcgZVDLg2UR2lZTTOiGBeOGPvSq+Y8zGOHc/ESdXIM7w9LYrZJIgmZS3Ws1T5m/8jbX82yDAuXuCQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607220156
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Equ_Fg_8OzzCuiqKKLHpUFm-sf3pmUsx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1NiBTYWx0ZWRfX3azZ17v6N2eY
 nsKMMMzQ3VH3Yl1GVkNZJPKOaUyYAsBdJGWPA9zIEmuU2yTjsJR639O9pt0dLfx3oJzvOh0kSj5
 0D6FmCaTASYt+Om5cvWnmRjCyHy+0auQxrA2vX0RuCqSva37wzBG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1NiBTYWx0ZWRfXyWmSSUdYeS7K
 nqlATu5zJrqAXUlm7Y/526aDeaXuz0AjKoXH0FDaFIpEvv8z4V24HIbYzrPRA99iSqf0BRleSPd
 q3x2UircHkRvkjrvHee3QoKrhZe0ioK/lzaKqymfbnztPxmVrUi2g5nhwCZrnLaOmrFlkccSY00
 f/3yYcCDDZUyZNU6S0GvmuRdfZxYSHLg/4N0T+hRqVEAXR8nXWkUim0+OXxTuRXbvu3UvTJw4Hg
 4Nl1RjyJM9AbhlIcNAQA/K+Q+mKimfOV/tdBfLC5rH850AAZ7SAl3UmWC6F0s+GDuRNCdXmKpqJ
 n5Sx+c/pJg1oHRaGmfyHafHShPVWM/kSsRoTRis/N41wDYJqulKo9W6T2Je+SqDrt5omWgZswtB
 ewCsFnzuT/L5pPYyKXnKeby4lotm4buBEcVjctdb0FmbbSoLrYPDYpr1fo5BwwVDQ/Iooyv9PT1
 11hFNK8UU82r2V9CAFQ==
X-Authority-Analysis: v=2.4 cv=ZpPd7d7G c=1 sm=1 tr=0 ts=6a60e7b2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=d9WBezoqIoI1OZwyxD4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Equ_Fg_8OzzCuiqKKLHpUFm-sf3pmUsx

On 14/07/2026 14:50, Alan Maguire wrote:
> Though the true signature series [1] has not landed yet, this is intended=
 as a follow-on series to resolve an issue it raises; by sharing the optimi=
zation detection code it can result in the non true signature case being ov=
erly aggressive in
>=20
>=20
> Though the true signature series [1] has not landed yet, this
> is intended as a follow-on series to resolve an issue it raises;
> by sharing the optimization detection code it can result in
> the non true signature case being overly aggressive in omitting
> functions from BTF that have optimized parameters.
>=20
> See patch 1 for the details; patch 2 tests the change for gcc.
>=20
> This series applies on top of [1]; the danger is we do not
> want to land the true signature series without resolving this
> issue first so hopefully folks can test with this series on top to
> see if issues are resolved.  CI passed with this series on top
> of the true signature series at [2].
>=20
> [1] https://lore.kernel.org/dwarves/20260625020148.1883082-1-yonghong.son=
g@linux.dev/
> [2] https://github.com/alan-maguire/dwarves/actions/runs/29270441984
>=20

Series applied.

> Alan Maguire (2):
>   btf_encoder: Only skip optimized parms when ABI changed
>   tests: Add GCC default-BTF optimized parameter coverage
>=20
>  btf_encoder.c                  | 97 +++++++++++++++++++++++++---------
>  tests/gcc_optimized_default.sh | 69 ++++++++++++++++++++++++
>  2 files changed, 142 insertions(+), 24 deletions(-)
>  create mode 100755 tests/gcc_optimized_default.sh
>=20
> --=20
> 2.43.5
>=20
>=20

