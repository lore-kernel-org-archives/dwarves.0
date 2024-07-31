Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF91200CD;
	Wed, 31 Jul 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447850; cv=fail; b=h8YcdZoYeveYmBqFNeO1JfLgRp5YjByCIDQT4/P+45TnizAJJQDNAAOnpECTf9un8T9gg91iuRzmbAEr4Rl5RSRxO5maXM2eO4UV+i41K07l5r7sdW3PipxrP8KJdJj2w4dpuOQHWteEfIcOpPRaZUl9uv6XOqX5P33UYTYN9/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447850; c=relaxed/simple;
	bh=JHDyoRfIAzKZg8ENzbJz2+ZrZUW2cb8idYcdlzuRrwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eEfO3rLT2wZ+xRAotbozSvsf5ZYvs0g0h5ux78FLNFDnxERigfIjLtGca8GCZOBWwiOPWnTCQXo+p4FWGCheQMAWvVZ0xLcDehzHuWJ1lyoyJjojnwfawM1hkFlBrOjgoln/GuwVZFI+labQqM7/QQ3zpBpjLVrfyaKy0RGE8vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LyP2XHj+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eAiGeX3/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LyP2XHj+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eAiGeX3/"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VHY81I013592;
	Wed, 31 Jul 2024 17:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=tBl2zUpwgmDhWOzNaS+rznLb1VQTWRged9tk0U0Dl7c=; b=
	LyP2XHj+Kq28yN7wO6c3o6ZzptjVV9AyZdUISN7E+eJDCN8Xru62EQwM3Kgqx1tK
	7um6i9bIELxGGs4AgZOOEzWemEu0D36I0Y3acdZjmMSFh1OhnHEcfcSM3x+LYn9W
	evOYlj2uyvoAKvQc0cSqPTJpmKbvIkWYSbyDWLpW6lgnvP1rrSgX048ybJXK5NJW
	Haw1+9/gjaj8jhf/qPoe8TdPRVurqziVytfWEfpP5GEpbaXLlMDjohmMCOx2uYxL
	s/rlqGGVg0CKeGIpZ9xEDH4TaD3Iwey9XXMGkQ8Li7Di1kGjd+6FPJ0RYF/V5E15
	grtBaLCaAWt+4oaFbzxjDw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8qvrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 17:44:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46VGNmFx029075;
	Wed, 31 Jul 2024 17:44:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qmprxer4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 17:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxMmgSuUxz2wt2+E6ljF1WYQ5WpXzaGqtSCYMkrb8knoFqYngLcDh5Dtx2UPdYyYNyt5PMwH1sqzdCyxy73WOdXUvrlud7fxueRdpTv6uT6kgGMiI1n41XSiNenqcwcIUkEnzQ/E5pWagF0ZT9a0hwyGvWBgOYFq739sEkb9BzU602eRdiGIFpIzdx16nNhtVSsglAMK6CaU8ioMe6VPSI49SUeybI4IkLIjaaJBeKPRJgUl74s8NmaZSTwb8krhuKLbC64TQNMgxp2txGYLd53tlh1tPjgx5WIuSs6+naPR4RHSlFVW/5Z/ep4Le4t4SdsKTJC6bTX1vBeVMU/vPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBl2zUpwgmDhWOzNaS+rznLb1VQTWRged9tk0U0Dl7c=;
 b=x37uGyyi39eqz9B8wrWAks2eSVLuPMQszsEg08JQ1YJKFlcKEaSXwYpT+TrloHG3kFhbjKe9SdwUHVkYz21v+K0SExC7vFK5+Kt5qmUH4oe48duOAgoP04S4N5s7iEcNhWMH7LjkdImnllBMJPVk0C4NLCQP4QpKWaSGpJuqd+Q7ri/mI0SYzbc3Ed03M6ghTtSF3Y8XY6we68lNf7yzwxXi7vv3HYLUP4eFY0vpwdV7muPQ8yX7t+H3AsydopAKOsEZ1/qRdtMwSSDxNPrFdfvne/O7d8opWdblVwk9MgCFIU1ZX5RM6O1VpbzoyhGf14hHRUHZmRJ5BupZuv8W4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBl2zUpwgmDhWOzNaS+rznLb1VQTWRged9tk0U0Dl7c=;
 b=eAiGeX3/KN5kOa5puWLEjIuq2uxjEBlCfycVOnTpknbjyDRVn20EvF8gumzUH0DCZdWSEIlD7MojrL6y2XwBlPblXPVToyw6ZgtBTOH6ncAU3vGTrlTm3mGiKO3kqLmRiX8k4eKPYOC2wpzOOjMJl0YuniwfwmGrdGH8PFEPwbQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7647.namprd10.prod.outlook.com (2603:10b6:610:169::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 17:43:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7807.030; Wed, 31 Jul 2024
 17:43:59 +0000
Message-ID: <d4152b9d-2bc4-4458-a1a2-71ebb5932d9c@oracle.com>
Date: Wed, 31 Jul 2024 18:43:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pahole: Apply CU-level filters early in loading
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org,
        dwarves@vger.kernel.org, aliceryhl@google.com
References: <20240730224350.4039790-1-mmaurer@google.com>
 <0c0031f6-7f5b-4ec2-9804-c9d576c8302b@oracle.com> <Zqo7mW3brA09hA8b@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zqo7mW3brA09hA8b@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a381c78-2ce4-40fb-443a-08dcb1885b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0pIY3FjNHpZREROaFlReFdoZEg1ejBwTVY5czI2d2I2K1lTR2RsTUxJUHN3?=
 =?utf-8?B?LzZmbm1NTFpkSk96OTZ0QXpxc1pVM3MyWWJkNGhFTnBxRUY2SDZhUXQyeXhZ?=
 =?utf-8?B?Z0lpcm5PNHdIdWFaTE55OHlSVUJVMUdPdHdGRms5YktjRUhRMktkWjkwMGxR?=
 =?utf-8?B?R0E4d1BBQVJ4aVdHdEFpcWhSR0tOZ1dMd1BMWjZ3RGlRbDZ3R0VWanFVUytK?=
 =?utf-8?B?RFpjbG5YUjBpQzVXUDg0RzhISXFEQjRFWlR0YUxFMkp3RmovM2VPanFNdkhr?=
 =?utf-8?B?eGRGdFVkNGhGanhwVTNaeDR4Qi9Qd2VxQ0lQSXNuRXROUStyalJOa2VOeEpt?=
 =?utf-8?B?WkNnWWwvS2lxZVRWd0FMS1VYRG90dzNiT2o5ZjVabDMyKzdRNEx0c1VZTnpm?=
 =?utf-8?B?TzE2K0hPaDlrVG9LZml1K1ZORy9ESEhaQlJIL2tMQ1pTWVVKVkM5T0lJSVVy?=
 =?utf-8?B?d0lEUGUwWXZuSE1PUGtBY2NWbDE1N3BoZVhURm9tTjEvSzZHUVBSb1c3S08y?=
 =?utf-8?B?N3dPZHJTN29Zb2s4SnVVTEoveS9KS0xhdUQzenRmeWdzR085ZGttYU14ZU14?=
 =?utf-8?B?VzNFNTVmbDdpL05pazdPSHdHVUpyaWFhdHdhNHZuK3RKQXExZjdqNVZqNFRS?=
 =?utf-8?B?VXFEclk5TUxLcm4wd2RpbjEwUUpwZ0wyS3k2OXVFZ2g1TkFqT0lhdTdSSVJl?=
 =?utf-8?B?Y2JrNjVmS1UrWWFGbWRla3AyZDdsT2x3Um5MaWlBNlVtbC96R01FV0gvUlds?=
 =?utf-8?B?cGJQdEVldTNYY3FPSEM3ekpQZno4dGZBN3dmbjRrYXl6M29nNlJ5WUR6dm4z?=
 =?utf-8?B?U3dnRHorQ1IxeHd0TEFhc2RUSjMwSk9SUVlIZ1JjMkxvVVQza0daL1pHZEdk?=
 =?utf-8?B?cmJTcS9CQlNkU0hJSnE0NkpVMnpCMWRUeHQ2bG01akZKaldFL1ZSMUx0bXc0?=
 =?utf-8?B?dDNCYUdsY3J4WERtUjcxUzlNSWlidFVhSjBYb2U0M3VOMmFTellGdGJlK1o5?=
 =?utf-8?B?WlU4VmNJRWVOOGtKWFhwTlhOMWkvVGRjNkV2bmhGM2JKK2xRS29UUXV4aWpR?=
 =?utf-8?B?bTBWQ05vM3FuQy9SL2JjV0VielQ5YXhBUG4zYkRnUzBhVG5HMk9aVEwrTlRU?=
 =?utf-8?B?R1E3QjhHc09ZNWVMbk4za3JIaHBqY2o5ZmYxR3JJVEV5OWVkTzY4cVhqcXp0?=
 =?utf-8?B?M0paYkkrdzdTLzVCOVFaeUJnSjV6cUN3cENnOGUrek84aFpvazQ0QVBjUFRV?=
 =?utf-8?B?Y2tSUEx0aUEzWFRQZjhNWGp6a1pjR0RXUm1HejA1LzI2VVNmdkEyWndQTWtW?=
 =?utf-8?B?NVlTVW5ndHlFNHkvT0J1NVBWWnlDa2lVVkdtYmZLSDdHWTZjTnNnQldIYTF3?=
 =?utf-8?B?eGlPVUF1cDU3T2hyRnBKbUMxYm1ya3ZQZWQ0d2VwTkwyTCs1S2xvajIwRkdJ?=
 =?utf-8?B?UXNva3JOcjhGM0g4TWZBcC8yVkpBeFIwOHM2U0UwOXZMK3lpVExpWnphMVZL?=
 =?utf-8?B?VmVobkR1Nk1haW5CU2FienRMaVNjeWJyQVAzd21paWphL1ZtVzQwVUNlTmFP?=
 =?utf-8?B?SXVGb0RPWU5oVCt0MG5adUtGNGNmQ3N2RHVaRGRRZENHc0RIOEkzNTdsOU4z?=
 =?utf-8?B?V2hUeHR5ejdrL1JHb3JEU1NrR3JhL2NEL3F6WU01aW1naHV0NjdGc2w2Nzcr?=
 =?utf-8?B?cVZJUEJLY2hlZHEyUnd3ZCtQK3Z1SG1Yd3Y3c1VnUC9TWVBBQk05MWpob2lM?=
 =?utf-8?B?Q3hFWlBtQjdtWC9sRnBJZDdraVd5NXkvQVg0S281aURaOWg5bU9KOGVZcUM3?=
 =?utf-8?B?M3RxNUR1T2dJenduMERrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTJ2NVU4ZXBJam5BQ0tlSVBtL0FLcGt4TXNZSUdUOWFIZDcwQTdWRTd3L2wz?=
 =?utf-8?B?VzFwOThqdjFFWWJ2UnIzUXRJcU1XSnJNeWQ4VTdDbVV0N0w5RzluYnNxZyth?=
 =?utf-8?B?OGtqV2Nma2VYUXhJUW5jdDJnRVJlVzU2NE9TNUZCM0tuZjBJM21wb3ZVVzFJ?=
 =?utf-8?B?TjZsQTk2SmkzNmVud24xeVJXSWJ0VU1YWHBYRGF4K0ZTenFJN1U5aVE3Njdi?=
 =?utf-8?B?QWFlRkNMWFYvK0o0eVBvbnFuNTNlSy9FVVNYN1lSR2h6NjJUU3ZvdzBoNVNE?=
 =?utf-8?B?Yk9qNzZBdWxKU0U1ajNDOFRMYXBqcFpGcWRocVRsU1RsV293MldHbmpMamdF?=
 =?utf-8?B?WnhoRitsZStlQVdiY2pJT3ZkcDh4cDk1TER1bnBmZ0JoUUwvYnlnWFJXMDJQ?=
 =?utf-8?B?ZWh5T0xSQXFqUHRwL2NXVFhxNW02ZDRpa3B5djhjZ1RLZjEyRmRGWWUrRy9T?=
 =?utf-8?B?ZUtOcXU0NXRLRjlWL1NDczRYZk1rSC81Wk9leEFxSGp5Q1ZQeUdUc3NGVkg4?=
 =?utf-8?B?SFJqVC9IL2txbGRlQzBIL2RoazlsQXphSDYzVHZCMFQyV3N0SHVtNUpGSTlW?=
 =?utf-8?B?WUdRNEExWW1HNGpVeDI2dEpkMWZEaDdxKzNrM1Q4RDhzeUJFUXpuTUZFYm1W?=
 =?utf-8?B?SkFmRGUyZHdacW5qd09nRVBjeDJlTU8zdW9FYjk5akEzaWFKdW42WDhBMzRP?=
 =?utf-8?B?WTJFYVVnT0xyU1ZGbXB2ekZOZnpTV2g5dis0V1pzNTBzMkhDaitIMC9rYUQx?=
 =?utf-8?B?Ym9QbWgxR0FlYkoyK3BON3ViVmcxWDZzQys3S1dOTTloWlpCSFRlMG9ORUgr?=
 =?utf-8?B?VlBuNU9ZT1JMOS8vbHo3TW1zZ3JhRUwwYTJtajFHN3hteitib1FMUER1SGJk?=
 =?utf-8?B?Q0FnODlRcjNUZzByRDZxNUZnZll3S3NsU0thSjYybkhjNDNwUUdhS0lkc0tL?=
 =?utf-8?B?OU16NUhlSENWVXhpNXBkTzZnWGhyaklNZmNkMzRTSDlLalI4UUo2bHRQMWRM?=
 =?utf-8?B?T2xpOEZrbEdXem1hZVlFajdCemloVk05eUZUM1hRVTZsMU1iOEhBM3E0ZmhL?=
 =?utf-8?B?RmdEeXRTRVhMYTJZUHJISmUvckc0YzlJWDRWa2hyWkhnVGFZdFBpc1N0QTZG?=
 =?utf-8?B?K2N2a3k5TWpyY2EwQmE3cVlkR0lSNlNraHVhOE9OT2dxUURQeS9XU2hzekpy?=
 =?utf-8?B?WkJNRnFzZkVHR0J2M2ZWOWcwRG5rdERRa3gyb2FET0hhZkdCeFVzcTcrN1Nv?=
 =?utf-8?B?SFlSeHN2TkNiSElrT3BJTWpka0R6Y0NCTWxRU1o0d1EyaEJGSm93Y3FHQjlM?=
 =?utf-8?B?VWRMa2lFcEQ0WVE1K3lBQmc3U0lDTXhRNjNjNU9JSnFCSXB5bFZpOEVDOXZ2?=
 =?utf-8?B?VXM2c3ZQYWVOZDJWN3VBNDF0ckdxTjJ3RTU5RU1MQ21CMDk1eDRZVDU0S0dJ?=
 =?utf-8?B?QUVRS3RRV0ZmSncyaHloVmVXVXR3U2ZXZzlYRkpVQjhMcmtZOVM5WG00Q1ZN?=
 =?utf-8?B?RkZjSUJjUURRWXBIVjhXdTZydDVOdTg3TU9yK0pORENZVFoxLzI3ZEJtMjB1?=
 =?utf-8?B?ZGpOV2lIWWVYaTNReE44RGF2NXkzaDg3UlNPK2J1akgvSnJEdzhSM3M4dGpw?=
 =?utf-8?B?WEpmNWpqenlaWG1WQW1ydENRNW5wd2I1cUwwQUlyVXdFVUZhMU1oV1pUZTk5?=
 =?utf-8?B?bmRYVnV4T21BVmZhZk9CdndPTjBvcWFYSXVuZkhQdDJwZjRibnBuS3hUbzdh?=
 =?utf-8?B?bmdXdVRUb05JTG1tM2xRRGhrUWlUT1E2UDg3eDllYklwYldBN2dYMm1kQjVW?=
 =?utf-8?B?ZVVxaWU2NWxvUFUzSE9qWGVJOERwK1l5c2lsNHZDMFhKVjBZbjNLcTM2akla?=
 =?utf-8?B?eW00YTFvODcvV2swbXpkdDdTVFJLclRwUmtVWC85VnVoNVByazJQM3VnZm9P?=
 =?utf-8?B?cGxuSThDcVZwRUhZcThDcndKME1PY05nOFlGWGtvU3FTNVd5VTloWWFqaXFB?=
 =?utf-8?B?QjAzeUR1bVJvR1BHNVpUalJheTVoWXRnMENqM0w2YUFhU200dGM5UDB2YmRP?=
 =?utf-8?B?TnlZUHphT0JVMVNUbEVkR21KNW1OMFltcjN3OS9LWk9IZWh2eEdwTXU4NnIy?=
 =?utf-8?B?UmhBbWFFcGlFSnhZdHRBU0VNNGtNdWpyKzVEK0RDakZTb0Y4dHRKby8vL3FS?=
 =?utf-8?Q?mlrPrOI5zDXhORtPJRwdbbU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6+YO06uQBX0oOw97VoATyOvsDJF5MnWElfOwoEiuxCngB33CFtxOaL43gJh/k/mGtI+peBW7RtkM7/10oLPUCvxnZ+vrRJTa51C2vAdiLRM6v7ikAEAu+rXPlBIAcpZ1f59JB4OA6ZFqZe552kJ7SthgrO1gqI0gW48EHM+ibmWXlq2KX83MXSKrHtPeApwLbEhvgwipjGiFBI2NYiFTlkpfLzEksB6GK1VieOqUFxeY0tTxiL/iyMIZDkjmtBz/mXA5odwYFdMAuoPoMT5+iH19M8MY8kg82noWy5mM7CXqK31OCV6Vq+aPs5wUOov4c6irnfKgQ/ly+9ufRgPj1lVvqmDHTVa3WX1ffUY11+zW/TNKVjJoq5TzPT5Y74KKPnReWalGQ8XB9bg/Y2gy02Q6HpHyTD/n/PlAvFHSLoE7GM8JkrUsl9rLb/snqoOP8SLbLGRhUvwKfvPThOcJ4AKgS6l25OkAmI1Vt14oIreQnmUZvF4DK7lVTp94bKh6IoFBg+KIoguDq4Qu6T4bkvImHzi67PByA3S2UOwqYC9W3prG017iH5ly/kVgeDz/H2OVQvhILJ89n9vrEOkl2lenXBSsWFl/99d30zT1p/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a381c78-2ce4-40fb-443a-08dcb1885b9b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 17:43:59.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7ZCNm2JdXdY5FRlV+cWCcaCFwIA6YJyxxfSgSjQ6hCsQYD9+Ju4L9pbZqIzAxQKuLyaXuEtgNmd8Wi7epQhew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407310123
X-Proofpoint-GUID: f2VDCUFLxIwHyAsdlZnAbiXFvaOjk_we
X-Proofpoint-ORIG-GUID: f2VDCUFLxIwHyAsdlZnAbiXFvaOjk_we



On 31/07/2024 14:26, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 31, 2024 at 09:57:25AM +0100, Alan Maguire wrote:
>> On 30/07/2024 23:43, Matthew Maurer wrote:
>>> Without this, even with `--lang_exclude=rust` set, running on `vmlinux`
>>> with `CONFIG_RUST` enabled will lead to errors like:
>>> die__process_function: tag not supported 0x2f (template_type_parameter)!
>>> because the filtering doesn't happen until finalization, but unsupported
>>> tags are reported during loading.
>>>
>>> As an added bonus, this should speed up processing of large objects with
>>> filtered CUs, as their details will no longer be walked.
>>>
>>
>> One question on this; if we are always doing early filtering like this,
>> should the explicit cu__filter() call be removed from pahole_stealer()?
> 
> When I saw the introduction of an extra callback to be used inside the
> dwarf_loader I thought that it would be used only for this specific
> language filtering feature, i.e. a defensive approach at implementing
> this to avoid unintended side effects of doing all filtering at that
> point, maybe some other feature somehow depends on the cu__filter()
> being called where it was so far.
> 
> But then it is being used for all filtering, so it seems just a way to
> reduce the patch size...
> 
> So I'd keep the cu->early_cu_filter() but would use it only for the
> language filtering feature, wdyt?

So if I understand correctly,

	if (languages.exclude)
		conf_load.early_cu_filter = cu__filter;

? Seems reasonable to me. Thanks!

Alan


> - Arnaldo
>  
>>> Signed-off-by: Matthew Maurer <mmaurer@google.com>
>>> ---
>>>  dwarf_loader.c | 10 ++++++++++
>>>  dwarves.h      |  1 +
>>>  pahole.c       |  1 +
>>>  3 files changed, 12 insertions(+)
>>>
>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>> index b832c93..c48dfef 100644
>>> --- a/dwarf_loader.c
>>> +++ b/dwarf_loader.c
>>> @@ -2854,6 +2854,16 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>>>  
>>>  	cu->language = attr_numeric(die, DW_AT_language);
>>>  
>>> +	if (conf->early_cu_filter)
>>> +		cu = (conf->early_cu_filter)(cu); S
> 
> Also we can have it more compactly as:
> 
> +	if (conf->early_cu_filter)
> +		cu = conf->early_cu_filter(cu);
> 
> No?
> 
>>> +
>>> +	/*
>>> +	 * If we filtered this CU out, we still want to keep iterating, but
>>> +	 * there's no need to walk the rest of the CU info.
>>> +	 */
>>> +	if (cu == NULL)
>>> +		return DWARF_CB_OK;
>>> +
>>>  	if (dwarf_child(die, &child) == 0) {
>>>  		int err = die__process_unit(&child, cu, conf);
>>>  		if (err)
>>> diff --git a/dwarves.h b/dwarves.h
>>> index f5ae79f..92d102b 100644
>>> --- a/dwarves.h
>>> +++ b/dwarves.h
>>> @@ -72,6 +72,7 @@ struct conf_load {
>>>  	enum load_steal_kind	(*steal)(struct cu *cu,
>>>  					 struct conf_load *conf,
>>>  					 void *thr_data);
>>> +	struct cu *		(*early_cu_filter)(struct cu *cu);
>>>  	int			(*thread_exit)(struct conf_load *conf, void *thr_data);
>>>  	void			*cookie;
>>>  	char			*format_path;
>>> diff --git a/pahole.c b/pahole.c
>>> index 954498d..937b0a1 100644
>>> --- a/pahole.c
>>> +++ b/pahole.c
>>> @@ -3765,6 +3765,7 @@ int main(int argc, char *argv[])
>>>  	memset(tab, ' ', sizeof(tab) - 1);
>>>  
>>>  	conf_load.steal = pahole_stealer;
>>> +	conf_load.early_cu_filter = cu__filter;
>>>  	conf_load.thread_exit = pahole_thread_exit;
>>>  
>>>  	if (conf_load.reproducible_build) {
