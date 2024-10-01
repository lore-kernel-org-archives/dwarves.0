Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB71C6F7B
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802722; cv=fail; b=G6P2SA1ukWvnthYJbKya/2Xj7NQd7x9v3dF0cODP3BS/Z1Q51jvM0T20XRdnnNB9M8EQln1eTSeDKzNC+bJU8H0Phfz11yt7eBSRqjlq3+Htxsl1IaCfe7wBYu2C66964Q+BxQP2Ivcp6RvoTIHdouAe4oCtr9+8Z2pFYfaLcgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802722; c=relaxed/simple;
	bh=Z7VOhauVv9ptOH3PXyQ0LND9xvN+jrHzAn5kpT1CRfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DTZs4A0OnPdliYz8cUPo1WzngfyPYqaZ5c+lATnAGkuhr4zuw5n0aLmPASjYWeldvHGCe2aGRm7zT9JghCDqtJaqHnGMjtlMxkxKld3eOByW+iidoGNwaLhiRwxe8Wf5hfSQa2ocHLGM6RZ2VLaP33N5VGJGcB3EZBSoNcO87oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YDkCQwwJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FpaT2Kpy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YDkCQwwJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FpaT2Kpy"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491HBtEY010959;
	Tue, 1 Oct 2024 17:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=KqCT8AdRdO//HPow3FLTj5PwFhT8TkiRzBhGX3vcQZI=; b=
	YDkCQwwJCvigN6LzWpoeUWLULQ3aa9Kv98nt7tNoEOeLc5w4bMU3gYLcm4vGd8I3
	CH8LxXvxkHOldnbx3rppQRW2vFiYVQwv1v2RYK2rqG++HXiO3uHfsQ35YpQRPDMZ
	ibWWQLY7u8QWOjIj5ARcYbcdJzkWEpN3eYtvnsvx4E1eXRj6piBloFOnefb9E8tP
	vowVaXWKxlRDRGxZdviN19V2Kl/z2pvoU415N3aIhvGv8ZMJRGzIpTjNADzniYbE
	JgN4zB7pCl0trbpsFIjy1/8MuWIFXZy62PcEgj1j6bTtUf3d/L6jJDtGhBEhUgev
	RkUKtgNlNioVmBW1wD65qQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9pr87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 17:11:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491GsO8g017318;
	Tue, 1 Oct 2024 17:11:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x887trsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 17:11:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsE/fmyjxtyXf3yrauLsxqQ8Gvn/nKM7BG+ZxZm0IVsPvO3SxiQP4N27ly0McZqa2m3ETi3SMRCfturcLWUHGMqYHuPeS/3UWmI+UPl3emCQJOVrm81ST5DEM5HGmvN3KYo8tk3yVQP646q1CY+qSAJOL4SsIutc/qRPJTulLqTStWYMfooyli5smqA1YAH1RYEwHLwbxI6C5cv0qV5SuWfICDF+5JBhZtSwhWSbggEdWO22UfX42nymq/xfw/pHu4vYPG/DKaI+JaYlW6zEjcrP3BWX0SUdk+NgzeDHiKna+zny9oHM+B6NO31A/cPdMfFrSejDGBufYK8Ms/vIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqCT8AdRdO//HPow3FLTj5PwFhT8TkiRzBhGX3vcQZI=;
 b=h48G7OTnbB7Ip0vG1QuxjT55QLF0KNYbMuthbGBOwj52GeruYEiSgTA6xdUILBCcZrdaMb8q+f3DAQzP8BkrxXJxi/wgE0L35mUHpWzcebZEjirElmXbmw+VxbO5i7knhAAg22hTkgFIGZvgmBUieQG6qZwU9+WmBkKu6RwNt4zn9NGWOS8YjmOFT12ILwDefs7lFIqRVQDnj89bYWimrUGso9pmoY7dSGeOS1V+1QFyVR50lWCsSmbiacR02SrHSN+KAJBpquF1qHvIOOuRJyfaXNd0Mr6xmUNKqwN6104eLRcD3ioY25FNxGWJMFPBkNHG6T7RNbU9UaUuO8ehHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqCT8AdRdO//HPow3FLTj5PwFhT8TkiRzBhGX3vcQZI=;
 b=FpaT2KpypTyh6W6iUapXdsBo7w5gGQu0UiqR+yx0RnLHc07qRAtxNquQDngPBlJclwqiqNcJLnrvD0S+rdmpDUhyBh3lpTBV9g7I6aYAjMYq//Nmfnfs05kA+DwZMNUkZQhrjdXud3fX3fUAuYTT6ZKChOyy7F9gQLQuQjHIzzc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 17:11:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 17:11:12 +0000
Message-ID: <9c63aab6-bed6-4e6d-ab07-6b3b1bb89ea2@oracle.com>
Date: Tue, 1 Oct 2024 18:11:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC dwarves] btf_encoder: record BTF-centric function state
 instead of DWARF-centric
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org
References: <20240909155031.1596249-1-alan.maguire@oracle.com>
 <ZvwXmH1IR9gWQ1wZ@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZvwXmH1IR9gWQ1wZ@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 5316cfd8-f6b1-43a6-9777-08dce23c0cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1NpQ0wwZjZKWTJjWEhZcUZVeTMzaUdjTlR5cVJPRzhoZlZOT3ZFN29Gd01v?=
 =?utf-8?B?dDhBL05xeG14aWtxUGczeDd2YlRiMm9KSzJWcXZqYUlrSW9qYmZScHhKQWs3?=
 =?utf-8?B?b0N4dk96L1RZNHNwUW1uL3VDNldlamdnRktKdXNOVVpQcGZHNDVqeTltVGFo?=
 =?utf-8?B?endZWHdqTGx6Rmg0WC96Q2dUYzN0V0lIdXNBVkNpU1JUaEFDaUhFWkhQRVdo?=
 =?utf-8?B?WDdtSUt4bjlvWm4rbm1CWC8xKzBHbnpGYVMxNHlTOWtWV3l2aGhNaEkxVEJ2?=
 =?utf-8?B?OGNiejlVY1RKVVFIZGx0dzZPYmtaZjdiVHVJVGhBTHl5NE5MVkhUQ0d6Uzkz?=
 =?utf-8?B?M0VZQk5HYUtPOU5pZmVqUTRUa3NYV3ZZMjFCbHFBbDZ2VWZIT2d0ckFGVSt2?=
 =?utf-8?B?NThxSHBkTk1veVhUTWp4U3RkMjF2ams3TkVFUzRaTzY5WjREeVk0RlIwV2JE?=
 =?utf-8?B?U01KVzRUanJiKzZNVTN2L2xoZXpXUUUzN2ZsWUs2OE9TSmFITlE3MUpzdGJS?=
 =?utf-8?B?dzlkNkdRTG05SXRzTHA1STYzWGxxRjdIN05RdEo2Umk1MWFFZllVQzhrRWJa?=
 =?utf-8?B?Z29MYkFzcU1FL255dnc5dHhWY2ZVQkxQREdnZXllOEtxdUcvK3g5ZTZGaFdF?=
 =?utf-8?B?UW5NMnJwUWc5ZnZoSkhmL1dEcDNwU3RpWVV5aTNtL0JBcXJhbElndTJSSkZV?=
 =?utf-8?B?MGp4WU5ZR1QwellhRmloajlOMEpibWJNTTFSRy92UTNGVnZSVHFrdUhFVnEv?=
 =?utf-8?B?eUVIdEI2NFJvdDdPalBKYTNhTTUvTzQvUmgra1U0K0xYaU5jMzJiT2NpUU9P?=
 =?utf-8?B?cmpRQ3B4dVo5dkxManpEenExUWFtTlZ6L284SXRXMGZaT3E0TjRjMmhZSGVv?=
 =?utf-8?B?YkFwQkQ5K0h1aVJhb05adjlETTdtaTZIckVPUTAzYXVpbW4vV0h5a0l4aWZB?=
 =?utf-8?B?SkVZTnM0RDZXTXhZSGF4YmdsZUQ0UTBZUXFpdHZTWEpSckVxbWxpVjhqWTJa?=
 =?utf-8?B?dXVyYUN3dnllZ1k2eC8rNVJhUWRLQ0p6VW5qQVZzUk5tb1c5SlQ4Mm5pb01I?=
 =?utf-8?B?a0JsV2ZiN21NOWJHME1NY1k4KzVqV0YydEtWbGIwR1UvUE1JR0pZR2tKMHNJ?=
 =?utf-8?B?eEt4R2FwUlRBWUdEbDdldldoNmh0NW9IRW9hV29raGY0clhsUXNUOGRDaGdC?=
 =?utf-8?B?N25NY0FyeDR2VDREbStPV1Y3dm1kVC83V2p2TkFrMVF2dFBodk5Bb0NOMlRi?=
 =?utf-8?B?MWhoakhtaUJGTTR0L2JOVHp4NWFOR3gySWJBcEU2b0k1YVZWa1pWSSs0UUpq?=
 =?utf-8?B?b2xhQ3c0ZTR2bXV5WkJoZkNjSVQrb2xiZnZ3Njk4Z1lycTdsRXVFYXBpa2ZO?=
 =?utf-8?B?akptdHVNZ3hLd0loVS8wVmNiYkw4cldpblk2U3Babm1tWlNMV25ZOXBBRUdY?=
 =?utf-8?B?Uk5abWlaejNpK3VvdEFvWlREV0V0Tjg4QmFYa09aUmxiR05FK0EzcER5U3Vw?=
 =?utf-8?B?SjhhclBzUUk4NjZvWTF0ZnhEcFRjYlkyT285dkh1b3l1Q0pJbWxMUW1zSHFx?=
 =?utf-8?B?c1c5bFI5NCtnb2EvVjBOUnp0V3ZJWStWeG0yZFZsSWdZclVVSDVSQzdUT1Jk?=
 =?utf-8?B?SFdWbjFuWlFCVHBMNUV6SkpuNUppc3FkUjlYeWVIUWRhTGxLNlYwTllQZWtM?=
 =?utf-8?B?N09nNkUwdlFqRDdzWlErWUdlVkx6WktoZXRiSVJUT2l1ZU5QajVWa0lRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aElNUTRWdFhweW5zMFFROTdTRUVhcnRXSVB2VVBoUlQ4S2d6OHlld2RGbDlk?=
 =?utf-8?B?WW4xdHpOdFJvdnVHRjdWWXVzWkRHS3BpTm5FaHdGYnhQcXpuWXZUY2hCc010?=
 =?utf-8?B?L1pSc0UrcUI2cXFXOXNacGxkL25HY0NVVk9Ia21ZR2dJUFZaanU0MDQwa2ww?=
 =?utf-8?B?UXV6d2dEbGdrS2JQV3BONFA0T3dVM0lpS0gvSDluUHY4Q0ZSb0k0WGRDRGxK?=
 =?utf-8?B?V01INFZIaEhOeXJUMkpNUkd0bmcxZyt6TTdEVSt6SXRnK3F2bkNqUXZDUEZi?=
 =?utf-8?B?eWZJU0I3d1hPZ1lIMkRlVWVQdmZSTFRaRWFzYjdDa2lyL2xrOXBNOHhKdUFV?=
 =?utf-8?B?NS96bTRNYk9Rb3RNem1pUXJGK3Z2MHdZWDFnd0lBZGpSckJRa1RVclVmZ1Ir?=
 =?utf-8?B?SHh2M1I3SGpOdFovdkxlNWk5eHJ4ZFpRRTdPcEQ2UkszMFU2QUx3SldxMkFR?=
 =?utf-8?B?SWxuQ3hHSVhUUFB1bGhJbFU3MUlIZFo3UElEYjBnN2p0QUlUQ0JtRWFOaVh6?=
 =?utf-8?B?dTZUWVgwaGRUanFReTg2L0FSM2JlOFJFOW9SQUUybW40em9LYUxOSlgxYkFx?=
 =?utf-8?B?YisvRWFFTEpuUXNvRHRsaWVKRTR4L0xjQzJvQXZVaStFR2NBS2NsTUJZYkVC?=
 =?utf-8?B?R1k5UEVxMHQwZ0lCbUdoU0tkVkI3ZGxzQi9zTjR0U3JpNUNRYWNCdzJZZmFE?=
 =?utf-8?B?WFZEb2JoRHBicDE4enozTndhazB5eVpyTjZ4NVJpejFwSnVrbWVpMGtqNFdY?=
 =?utf-8?B?NkVYUzJIbWQ2NWdROEo5VFFsQ25HV1ZxUlNTQVRaTlgvY0JBQkhBVHJEelpz?=
 =?utf-8?B?d2svQ1dMckloSkNGQm13TnhZakNqVHN0YklwazVQZm56VTkrTWRFUlF4SXhu?=
 =?utf-8?B?RXZsUDdVTjFjVTR6dC9wcUNTNHcyVEtOcjh5YXNrODdkN3VrWDRjeUZOWWRr?=
 =?utf-8?B?SS9FZXNzdGpIMDZEZHE4WmxtK3o3dTVWOThJaVFYWWhtSm95RFlGc2MzSnBq?=
 =?utf-8?B?R3d2cW1LNGdneCszbWJFVzNyOVFCK204UkNrdTdyVjRqVjVEaEJCZzBzUWwx?=
 =?utf-8?B?bFB1czViVnk2Z082ZnIrdWZWTDNrSEsraFRlZ01zVUs5UDJqSjVKZjB1VFJF?=
 =?utf-8?B?cTA4ODdpSmcxTlBOZG9sQmRGZ0NIalJ4aFFPZGdXRGlGM2lHbVp2NmdURU4z?=
 =?utf-8?B?eW9hYzhUdmxJbnpnb3BGL0FVeW52TWFYMFNSdlZMQ3RjdlpJdWt0c05rQ2po?=
 =?utf-8?B?Q01uU0d1OWVlajNzUCtpRmJXQ2EwWnhhS0d6dzFHS0hQQmJnTEhGa2RiWlcv?=
 =?utf-8?B?aDVCR0hlbjc5dlk3YjZRSHVKTlZzaFVQMDJnSlJqN21DdGJIbVhiNnhYZzF2?=
 =?utf-8?B?MVlMRFdZS0FDU1JidzZMNlJpRWtCYSs0R0dlM3ZBbXViUDZ1S3JoNTdvZTNj?=
 =?utf-8?B?RVVMUU1EV0FqaVhQam1CVUM4blJrUGRzc2I4eWMzRFdXRTR2SHA0YWF1Ukp6?=
 =?utf-8?B?cUN1UGRqcEc0dFk3QkVkVzlUcjQzLzMrT3NWWnJIZkJXR3dRYmg0T3ZWQVRz?=
 =?utf-8?B?anRUM09udnhIaEM2cGNVKzZzRThoODk1eTIrYllQRWlqK0ZqZ1liNU9GSStw?=
 =?utf-8?B?cFRRMVJMTUFvNmV3Q08wZHc5TG1hRVJJcHZ5UFVuMDl2SFBuNTdFa3YzSnZz?=
 =?utf-8?B?bEVtQ3RnUERRemNsRUQzVmNHcU5KdGNYaFYyRHppNEZkVnlHV2hkRFZaSzNI?=
 =?utf-8?B?dmNOcUhJak5xbXMzMWJ3RFlvUHRjRkdWMUtWY3NCa1c2NWgxYUVSUG84UEdq?=
 =?utf-8?B?L25MMFZDZ09PZ3gzUkppbXlLVWo2Ry9MbzNZdHhteXBIcDAwQ1NsOW5uZnZs?=
 =?utf-8?B?RnZLRkJzbXZMMjZwSjU1Nm9HZFJpYndRL2Q0b2paVUtNbStic0ZHUTZLVnBq?=
 =?utf-8?B?WFMybTBpZUVuWnFjVHZDR0Fpc1Qya1VEYW9EN2gwa0JSeDRDOFdNc2RjWldN?=
 =?utf-8?B?SnVaS3JlOVFOdDJscm5YYU9ZeU0yREZiLytnTWZGSjJSdHg4WDFiYnVwaDhr?=
 =?utf-8?B?VmhEM3VBdEZPcGh0UE4yMTgwK2dnTk03WWF5QklSbCtPcWxOd25nNmpwa21m?=
 =?utf-8?B?YlA2Wm1DMC9KMi9ULzNiRUMyczFUajhYajZsRHRqeWQ0WXYwRkRLNzNqcFhG?=
 =?utf-8?Q?7wLBFzhFm9cJ8xxmq/wsGP0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iKgvsPn+bTNwHm/dF4liA4f/wPkBZxpS/0MhHuudPiFOY6aIoPc0r/h7vw9+3Bon7aKnXqvQ54OTBf9xcRaWWU6uH5hIRIPenKiJ+x7OUgXG0RY42uh0YO8fbusNvlNh1M1Ifa4cJ0NokoVU539iphAHkbxxLsydA6dTFRKVYtfFEg/eMJPtdxy0ZzvWAgGHBaIhUCWkv37tQDwmCTlyuKVvaidNK8guvOdxhSnQ+MrHRmXp0QlFDNjryi6AaHjOsrNYjmVag0+1Wmnd/3y5ENopcojTa29k11j/TpyLVj19/OYVUCyvAc2D2YUnFl3g0m/KsWUh9fXzz+rODX6e0Z7AhfLeufls+YY0V/ROiif1bE7QFnToFGGl7v7VPktLt3ZRlVKdcv8FsuOXO1DSCaTGEEWmnZNvAePe42nAuCIMTkeCP1td3IJe7rOWr8gLjGsA+LVudBjMmq50b29YPnOQAZKjwQ0dMvta4vSRTyfKCXwqHzJ2D9TYggbowQ3LmpSUvza1SonsJdrgKyMbrWBbRL79IuYqY3rIKd+wkLujmqrhhSF86Qzdh9503mMtaGuPQRDYucKoStPImjlApwv5/Y/eXYwcFJoHT8fvjno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5316cfd8-f6b1-43a6-9777-08dce23c0cd3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:11:12.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeWU+yrybXr2XMUx+qw99XfyqriKACHKtPSTDES9A7wBk3gsIkVn319PkTAILmGzKKySRnk0+sP+ZO4tPLBJIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010110
X-Proofpoint-ORIG-GUID: _tnBVUhYjMDTy2BHsLvpbZXBrVjuKIHL
X-Proofpoint-GUID: _tnBVUhYjMDTy2BHsLvpbZXBrVjuKIHL

On 01/10/2024 16:39, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 09, 2024 at 04:50:31PM +0100, Alan Maguire wrote:
>> When recording function information for later comparison (as we
>> do when skipping inconsistent function descriptions), we utilize
>> DWARF-based representations because we do not want to jump the
>> gun and add BTF representations for functions that have inconsistent
>> representations across CUs (and across encoders in parallel mode).
>>
>> So to handle this, we save info about functions, and we can then add
>> them later once we have ensured their various representations are
>> in fact consistent.  However to ensure that the function info
>> is still valid, we need to specify LSK__KEEPIT for CUs, which
>> bloats memory usage (in some cases to ~4Gb).  This is not a good
>> approach, mea culpa.
>>
>> Instead, store a BTF-centric representation where we
>>
>> - store the number of parameters
>> - store the BTF ids of return type and parameters
>> - store the name of the parameters where present
>> - store any LLVM annotation values, component idxs if present
>>
>> So in summary, store everything we need to add the BTF_KIND_FUNC
>> and BTF_KIND_FUNC_PROTO and any associated annotations.  This will
>> allow us to free CUs as we go but make it possible to add functions
>> later.
>>
>> For name storage we can take advantage of the fact that
>> BTF will avoid re-adding a name string so we btf__add_str()
>> to add the parameter name and store the string offset instead;
>> this prevents duplicate name storage while ensuring the parameter
>> name is in BTF.
>>
>> When we cross-compare functions for consistency, do a shallow
>> analysis akin to what was done with DWARF prototype comparisons;
>> compare base types by name, reference types by target type,
>> match loosely between fwds, structs and unions etc.
>>
>> When this is done, memory consumption peaks at 1Gb rather than
>> ~4Gb for vmlinux generation.  Time taken appears to be approximately
>> the same for -j1, but slightly faster for multiple threads;
>> for example:
>>
>> Baseline
>>
>> $ time pahole -J vmlinux -j1 --btf_features=default
>>
>> real	0m17.268s
>> user	0m15.808s
>> sys	0m1.415s
>>
>> $ time pahole -J vmlinux -j8 --btf_features=default
>>
>> real	0m10.768s
>> user	0m30.793s
>> sys	0m4.199s
>>
>> With these changes:
>>
>> $ time pahole -J vmlinux -j1 --btf_features=default
>>
>> real	0m16.564s
>> user	0m16.029s
>> sys	0m0.492s
>>
>> $ time pahole -J vmlinux -j8 --btf_features=default
>>
>> real	0m8.332s
>> user	0m30.627s
>> sys	0m0.714s
>>
>> In terms of functions encoded, 360 fewer functions make it into
>> BTF due to the different approach in consistency checking, but after
>> examining these cases, they do appear to be legitimately inconsistent
>> functions where the optimized versions have parameter mismatches
>> with the non-optimized expectations.
>>
>> Mileage may vary of course, and any testing folks could do would
>> be greatly appreciated!
> 
> So this is what I'm getting here:
> 
>   acme@x1:~/git/pahole$ pahole --running_kernel_vmlinux
>   /usr/lib/debug/lib/modules/6.10.11-200.fc40.x86_64/vmlinux
>   acme@x1:~/git/pahole$
>   
>   acme@x1:~/git/pahole$ time tests/tests 
>     1: Validation of BTF encoding of functions; this may take some time...
>   Matched 60956 functions exactly.
>   Matched 205 functions with inlines.
>   Matched 127 functions with multiple const/non-const instances.
>   Ok
>   Validation of skipped function logic...
>   Validating skipped functions are absent from BTF...
>   Skipped encoding 709 functions in BTF.
>   Ok
>   Validating skipped functions have incompatible return values...
>   Found 14 functions with multiple incompatible return values.
>   Ok
>   Validating skipped functions have incompatible params/counts...
>   WARN: 'irq_domain_alloc_descs()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
>   Full skip message from pahole: irq_domain_alloc_descs (irq_domain_alloc_descs): skipping BTF encoding of function due to param type mismatch for param#1 cnt != virq
> 
> Humm:
> 
> acme@x1:~/git/pahole$ time pfunct --prototypes irq_domain_alloc_descs -F btf
> int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq, int node, const struct irq_affinity_desc  * affinity);
> 
> real	0m0.128s
> user	0m0.073s
> sys	0m0.053s
> acme@x1:~/git/pahole$
> 
> acme@x1:~/git/pahole$ time pfunct --prototypes irq_domain_alloc_descs -F dwarf `pahole --running_kernel_vmlinux`
> int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq, int node, const struct irq_affinity_desc  * affinity);
> 
> real	0m1.783s
> user	0m1.577s
> sys	0m0.199s
> acme@x1:~/git/pahole$ 
> 
> ⬢[acme@toolbox pahole]$ grep irq_domain_alloc_descs /proc/kallsyms 
> 0000000000000000 t __pfx_irq_domain_alloc_descs.part.0
> 0000000000000000 t irq_domain_alloc_descs.part.0
> 0000000000000000 T __pfx_irq_domain_alloc_descs
> 0000000000000000 T irq_domain_alloc_descs
> ⬢[acme@toolbox pahole]$
> 
> So it is inlined:
> 
>  <1><1c21f2f>: Abbrev Number: 100 (DW_TAG_subprogram)
>     <1c21f30>   DW_AT_external    : 1
>     <1c21f30>   DW_AT_name        : (indirect string, offset: 0x3ac7ae): irq_domain_alloc_descs
>     <1c21f34>   DW_AT_decl_file   : 1
>     <1c21f34>   DW_AT_decl_line   : 1086
>     <1c21f36>   DW_AT_decl_column : 5
>     <1c21f37>   DW_AT_prototyped  : 1
>     <1c21f37>   DW_AT_type        : <0x1c110b2>
>     <1c21f3b>   DW_AT_inline      : 1   (inlined)
>     <1c21f3b>   DW_AT_sibling     : <0x1c21f8e>
>  <2><1c21f3f>: Abbrev Number: 14 (DW_TAG_formal_parameter)
>     <1c21f40>   DW_AT_name        : (indirect string, offset: 0x36eaef): virq
>     <1c21f44>   DW_AT_decl_file   : 1
>     <1c21f45>   DW_AT_decl_line   : 1086
>     <1c21f47>   DW_AT_decl_column : 32
>     <1c21f48>   DW_AT_type        : <0x1c110b2>
>  <2><1c21f4c>: Abbrev Number: 43 (DW_TAG_formal_parameter)
>     <1c21f4d>   DW_AT_name        : cnt
>     <1c21f51>   DW_AT_decl_file   : 1
>     <1c21f52>   DW_AT_decl_line   : 1086
>     <1c21f54>   DW_AT_decl_column : 51
>     <1c21f55>   DW_AT_type        : <0x1c11049>
> 
> And then we have inlined subroutines pointing back (abstract origin) to
> 0x1c21f2f (DW_TAG_subprogram)
> 
>  <2><1c236f2>: Abbrev Number: 29 (DW_TAG_inlined_subroutine)
>     <1c236f3>   DW_AT_abstract_origin: <0x1c21f2f>
>     <1c236f7>   DW_AT_entry_pc    : 0xffffffff811d3a56
>     <1c236ff>   DW_AT_GNU_entry_view: 3
>     <1c23701>   DW_AT_low_pc      : 0xffffffff811d3a56
>     <1c23709>   DW_AT_high_pc     : 0x17
>     <1c23711>   DW_AT_call_file   : 1
>     <1c23712>   DW_AT_call_line   : 698
>     <1c23714>   DW_AT_call_column : 9
>     <1c23715>   DW_AT_sibling     : <0x1c2378e>
>  <3><1c23719>: Abbrev Number: 8 (DW_TAG_formal_parameter)
>     <1c2371a>   DW_AT_abstract_origin: <0x1c21f3f>
>     <1c2371e>   DW_AT_location    : 0x36add1 (location list)
>     <1c23722>   DW_AT_GNU_locviews: 0x36adcd
>  <3><1c23726>: Abbrev Number: 8 (DW_TAG_formal_parameter)
>     <1c23727>   DW_AT_abstract_origin: <0x1c21f4c>
>     <1c2372b>   DW_AT_location    : 0x36adee (location list)
>     <1c2372f>   DW_AT_GNU_locviews: 0x36adec
> 
> But then the first arg points back to the right place, no?
> 
>  <2><1c21f3f>: Abbrev Number: 14 (DW_TAG_formal_parameter)
>     <1c21f40>   DW_AT_name        : (indirect string, offset: 0x36eaef): virq
>     <1c21f44>   DW_AT_decl_file   : 1
>     <1c21f45>   DW_AT_decl_line   : 1086
>     <1c21f47>   DW_AT_decl_column : 32
>     <1c21f48>   DW_AT_type        : <0x1c110b2>
>  <2><1c21f4c>: Abbrev Number: 43 (DW_TAG_formal_parameter)
>     <1c21f4d>   DW_AT_name        : cnt
>     <1c21f51>   DW_AT_decl_file   : 1
>     <1c21f52>   DW_AT_decl_line   : 1086
>     <1c21f54>   DW_AT_decl_column : 51
>     <1c21f55>   DW_AT_type        : <0x1c11049>
> 
> I.e. can you please elaborate a bit here on this test/WARN as I am
> missing something... :-\
>

So this looks like a case where - because we don't have address-level
specificity in mapping between DWARF and ELF representations - we have
mis-applied our consistency checks to the partially-inlined version of
the function irq_domain_alloc_descs.part.0(). I suspect what happened is
this - we compared across the function itself and its partially-inlined
component; the latter's late DWARF _did_ eliminate the first parameter
so we labeled this incorrectly as an inconsistent representation across
all instances of irq_domain_alloc_descs().

The next step we need to make in order to ensure this works more
accurately is to use function addresses to link between DWARF and ELF
symbol table entries; this will allow us to know that a particular DWARF
representation refers to the ".part.0" instance of a function, and as a
result is not relevant to the actual function representation.

Today we just use name prefix matching to link between ELF and DWARF,
and in some cases that can lead us astray, making us reject functions
that are in fact consistent in their prototypes. Equally in other cases
it steers us right, allowing us to notice that a .isra.0 version of a
function has eliminated a parameter for example.

I have started looking add address-based matching, but don't have
anything ready yet I'm afraid. Worst case here is we reject a few too
many functions from BTF representation where they were actually safe to
put into BTF (and support fentry). Looks like the absolute numbers are
relatively low thankfully, but it's definitely something we need a more
nuanced solution for.


>   WARN: 'rcu_nocb_unlock_irqrestore()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
>   Full skip message from pahole: rcu_nocb_unlock_irqrestore (rcu_nocb_unlock_irqrestore): skipping BTF encoding of function due to param type mismatch for param#1 flags != rdp
>   WARN: 'validate_device_path()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
>   Full skip message from pahole: validate_device_path (validate_device_path): skipping BTF encoding of function due to param type mismatch for param#1 buffer != var_name
>   WARN: 'blk_rq_map_user_io()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
>   Full skip message from pahole: blk_rq_map_user_io (blk_rq_map_user_io): skipping BTF encoding of function due to param type mismatch for param#6 iov_count != vec
>   WARN: 'acpi_ec_setup()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
>   Full skip message from pahole: acpi_ec_setup (acpi_ec_setup): skipping BTF encoding of function due to param type mismatch for param#2 call_reg != device
>   WARN: 'acpi_button_notify()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
>   Full skip message from pahole: acpi_button_notify (acpi_button_notify): skipping BTF encoding of function due to param type mismatch for param#1 data != handle
>   WARN: 'bpf_sock_is_valid_access()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
>   Full skip message from pahole: bpf_sock_is_valid_access (bpf_sock_is_valid_access): skipping BTF encoding of function due to param type mismatch for param#3 info != type
>   Found 118 instances with multiple instances with incompatible parameters.
>   Found 1 instances where inline functions were not inlined and had incompatible parameters.
>   Found 295 instances where the function name suggests optimizations led to inconsistent parameters.
>   Found 7 instances where pfunct did not notice inconsistencies.
>   Ok
>     2: Pretty printing of files using DWARF type information: pahole: type 'perf_event_type' not found
>   skip: /home/acme/bin/perf doesn't have 'enum perf_event_type' type info
>   skipping...
>     3: 1 file not available, please specify another
>   skipping...
>   /home/acme/git/pahole
>   
>   real	7m46.729s
>   user	4m21.097s
>   sys	3m27.223s
>   acme@x1:~/git/pahole$ 
> 
> 
> Test #2 needs a perf binary with debugging info, if I provide one:
> 
> acme@x1:~/git/pahole$ time tests/prettify_perf.data.sh 
> Pretty printing of files using DWARF type information: Ok
> 
> real	0m1.705s
> user	0m1.083s
> sys	0m0.595s
> acme@x1:~/git/pahole$
> 
> I'll try to improve that message...
> 

Yeah, not sure what to say here exactly. It can be true that there is an
inconsistency; I guess we could add that sometimes we get false
positives and reject valid functions? Thanks!

Alan
