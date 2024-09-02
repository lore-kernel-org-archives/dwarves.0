Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B519E965
	for <dwarves@vger.kernel.org>; Mon,  2 Sep 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283014; cv=fail; b=dBQu4oYGy836rygleWv3pdfEVqocKG/jHVRjDijkLETcQu29WtsnM4y8TNxMkF1n0BEyPQk7U2M4W0He5SsySu2oeOaStXjq++tszZ4ebmbeFZjzGZymD6ZGTw8fd1TaAJKFeAxassuCAHYnzKYakw+7YYAq9/poQ9iMGB64xow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283014; c=relaxed/simple;
	bh=3tfOH+8ngWzvr4V3HxvccffQ5usV0QodlMEVYU6oh3M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FHEqBpVF0y4SefVb7BYc5SjZUdE+/YdnM6F6f3rV4zvAkgqfjVItEb1dkMznzmfrumglGxuSxwr2YQBRZJhBuk5jr2dTMXdPwgz2FWXMT7akobTCadyU+DKOxScx8Gyx2sZoIK+tyHJ2WRf6b22gM3Pm8qQqqeONB7JoTNe4zn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VYz+PalK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ly/Ruwb1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VYz+PalK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ly/Ruwb1"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482B6Pam010834;
	Mon, 2 Sep 2024 13:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=+eyMtHiVEzeV+AGWVsGPq7e3YO2vYrfmSscyohXiD+c=; b=
	VYz+PalKG6miXDpbmiLnBQE085z/vYAQnPCAa6q5IPQMJTEEkbowybifjcUM0ViG
	meLJhNv7E/IBRiIXNO79zm6iX/A4x4JJMLIn3RmKjY9kf8mRmu7DeIWOvZF/Ym0g
	a5WJo0U086UG4Y2rTGjVpkCyOOifZeB9F2vZy/DcFK/mUSmCJn4aMwLkbqMcmbRJ
	TiVDWvK7OaUEa2iQnPrVzXrkr3oOM5EKwU4SDlUzQnIq45OMxX3wvfDEfTyfTmWd
	j+fC9DqmtSdZ5PnFee8oBHfcClvmCmGjKvIBSwFjG0XePnomBeKgC7JLeazHaiQl
	CKQRa27iAJXXwEvG6/tFtA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dad1rg7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 13:16:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 482D4MZA027890;
	Mon, 2 Sep 2024 13:16:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm7nxp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 13:16:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLz3qqcNT+9NgHgiz8WSIf41WRbs359BUTSovi0NqjbqOwBrVtUPw3bMT1oG6HcmSjQGMSxqOajvqnEG3kkxUFIqepPyMwqmlrXOnVueW3rYZX5VMeJHiPgPCINyHPfoE8h17SNcjX0U5suw0jA+QbQENOO7+A8BDRABakVzKTkLkElqnIZQDdIthtOQMT9kl6WB5a/2x5R4l0HcoF2/9qf0ZP+6GWhcz45G7OorBzO6dACy02RYbDZnQHq2KKnuRUWbAL23SUu+TB4JC8g+c9COCmQH8sMC5nzLzVxiLzo6e+o2tVObqNwYk4/IMHg1UC1Dtm9m6ISiuWxzZEeJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eyMtHiVEzeV+AGWVsGPq7e3YO2vYrfmSscyohXiD+c=;
 b=dEtMErgwRsGWElzL/C/lletKBC9bz+R8iPCwJXZl6cNK1s0Lhba5mgfC9uH2CD8RzGhcE6VORNIVYoQKF5sj0GQ2JGJa+jcXDNbatFLtkbdXS1RUH4WYxnwZbzbVtjkmjI6WdTkuJAQbs/nqaSiD94atVKIM81p9s3nCLVGHH2v0Kgh3wy3Pr8p/knvJTXT6JfLkyhVOVbc8MNfoiEwD8D3d8dY5TOL97+HkBZTSgbVdXawVzZ6pSWXai1IYP6ZQT3itjwGGxvkv0GNDTLC1XbYEBAMoNnyVX3cMWwOBRSzkozKLEMoX1XGx5qJzxsjmAKlXJGfWVH3v6nKNl9kSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eyMtHiVEzeV+AGWVsGPq7e3YO2vYrfmSscyohXiD+c=;
 b=Ly/Ruwb1ssEUPZzGQgeo9jDJf8u8AMbx5hHzunzCyFrgbv5XJ2HC60xopxclpqBGZwVOBH82jhyQsBBRZ8/hrgUwq/VItxH8B+H42Utas0hha2yX4+JVjyLE1WH+dxRtW7YwcrGWJhAe+TUZKgNOqJ7wVi3g5pyynl4oSXEZank=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV8PR10MB7773.namprd10.prod.outlook.com (2603:10b6:408:1e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 13:16:33 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:16:33 +0000
Message-ID: <3e5c79bf-6c6f-435d-9dd2-5a3fa5fb7334@oracle.com>
Date: Mon, 2 Sep 2024 14:16:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] dwarf_loader: Fix memleak in dwarf_cus__create_cu
To: Viktor Malik <vmalik@redhat.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org
References: <20240902111157.748247-1-vmalik@redhat.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240902111157.748247-1-vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV8PR10MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 81aa6751-b127-4b15-97b0-08dccb51764c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFpyWWxzOU1RazJzR2p5bkxZRTJySmdtZTBkQkhsbUFnZy8reXhNZVMvM2ZO?=
 =?utf-8?B?MDNTS0NwdzVab0I2akIxTlZoWHdOTk9lVEhkNEVJeGptM3ZEOUd2QkZvVDVG?=
 =?utf-8?B?UEJTSElOTm9zdUZwOVpZRG15U3FuZHh5cFhsZEdiNE5ibUhUNEhhZTRFYnB0?=
 =?utf-8?B?UEgzZ0t0VVJQbHlJUExmQThWSi9zT3VFKzMvSFo1S3ROYUFSeCt4ZmVyMktv?=
 =?utf-8?B?MC9uTlM1VGVFbTAzb3hGWVFKanl3VlArU1ZhOWsrMzY5V256d2JMcmk0WEcz?=
 =?utf-8?B?dlo4dXJBYTd6K2JYblg3UEdQdlJaZTFuQ3QweGVpbVZFdTNMbkUxdGJ0bWdP?=
 =?utf-8?B?VDNYVFFONVBNM0xwV2R5STczSGJESHdhUmtNVEFrUGEvQWFzNVVvMzZsdlFI?=
 =?utf-8?B?a0QzRUxLQ3pmTjBWTXI5UHplMWU5N0xMaVNZQ053bXBvV3NpWkl4Y0I0VU1x?=
 =?utf-8?B?ckZJV2wvSlhhMXZpbVdBTys2QTJjODRpeFJoejNUNVlFRnhubTdmZVRnWlhh?=
 =?utf-8?B?SE1ibEdUb3JBMU1lWmYxZFVWZm8vVVlqSjFqMm5jZmg3VmdqbW1LSmorak9n?=
 =?utf-8?B?a2ZhMWJBYlhiNmg1NjdhaDR5THpvUEs0d01WNTRvYjVNU1h6bnlxMzZRZ04z?=
 =?utf-8?B?aFFHS0dEWUVZZ0pJcUIzYTdyU2NoTlIyWGtyenpEU0o3QnQ4b3YzTSs4ZFhE?=
 =?utf-8?B?d0xSUlpqeHVxUjhEZXVQWVMyWW55RUtXWjMvWXBhMDlwRWZGMlo5bWZTV3Rz?=
 =?utf-8?B?M0VtY0FpcDJGZEJ2OXpCMmVHb2lLMU9vV3NFUEVrcFA5NTJQWDQzSmE3UTY4?=
 =?utf-8?B?NDBpa0k2cklGdlFHSlQ2ZVoyTU82YWk5WmNCeEM4NlVQQ203bnl6OTI0MEY3?=
 =?utf-8?B?TCtuV3VRVzRjcDRZWFNiejF5Tkd3QWZGY3dRaElTUnZsZVNuVTRqcWI5Sm54?=
 =?utf-8?B?VDM3WEhVU1ZkYllFcHBjUDFzWnVzbXcxUmpPdjhkSGprTCtSdU41OEw4eWRw?=
 =?utf-8?B?OWdlKzBaUEw4bWM5Vng2dUNGY0pDeWNzNDRpeGczMm8yTWVvUUJUQnVMUlRG?=
 =?utf-8?B?dnhYZUhtMWpSSTdjeDQ2WlF3YkdtMjdlUkd5SHVOTlNTcm10dHFzN0JZMStE?=
 =?utf-8?B?YlVMUnN0bjRqZVI2aGQ4WHJCWDBPekIrTHJGUVM5UTJuMjdickNOSm05VHR0?=
 =?utf-8?B?MW9PRWxscSt1TjVId2pCd3BsUzZQWExYdmpzMW16UWlRTnBhckFFT044TlhW?=
 =?utf-8?B?MUtocmR3ekhvWk1oOEE2K1VKMmxxVXQ3WnhRUVRiRUJ2MXkyakNZSi9DTTZJ?=
 =?utf-8?B?b1NwSXg5VHluNGR0MG1jN1kzcENtd0gydkxsNTg4c0VsTEdzVkp2elhYajE5?=
 =?utf-8?B?VVI0VytVZEFOTHNMcEo0a3p5V3hscEJ6eUx5UkRpSzRGNmNyd0daZ3NTUlRQ?=
 =?utf-8?B?QkZBSGN4Z0h1V2d6K2ZyUldHV29PZzdmak5vUzBnT0o0ZnpSNjBkeVRKaUVO?=
 =?utf-8?B?RE42a0x4dEZDckJWeHQxOXg5UEwwK3lxZDg2UW03T1BCTmg4U1Ftck1XOUJn?=
 =?utf-8?B?MTJCUXFLdjhkc1IwOHdOS29EeEhUbDE0Vy9CVGlTRzJwSllTYnBPeENDa3Fw?=
 =?utf-8?B?NnZocDI0dXZESGl3OW10RnRkZEtpZVUvTVFBTmc1eTl1VTNDWkhKS0tRbUNR?=
 =?utf-8?B?em1mZzM0eDBCN3ZNSEQrSHhlNGRSL3hTcTJNYVdVQXBMS2Z4RElOd2dXYjgw?=
 =?utf-8?B?Q1BBdGoxc0FubWI1N0cvanVxTGlsUnIxd1grWTRpUWxLR1dNb1NMeEhwaWp6?=
 =?utf-8?B?TnlOMnVHYStrVkx4UXRmUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjN4Z3F1amtmV1JLQjFTWTNCR0wySGVsK2cvRXhLWmNXZENtY1o0VmdrOFBm?=
 =?utf-8?B?dEVSL2graElCaFl5djg2NUllRW9pMVZkNjNERzlYODdZaXVVOE1vdFNENWlD?=
 =?utf-8?B?NFg1T3psTm9zMkRCVzF0L21JWm1tNy9sOW5nalBoRm1VVmhkVFBnT0U3c2p6?=
 =?utf-8?B?T3htaEJXNVlOeUxXQnhsRjBueGVrVGdSbjV0ZUZFbENjY0NDYnVtQ1JDOUJY?=
 =?utf-8?B?RklJL0lUY0YybDIxZGtIVTJBVW9OWmxzdDYyQjlWVUZEWFFCTUp0cTFXT2FW?=
 =?utf-8?B?K1ljUlYwU1M5UGNwMDJEaldvS3BVaExzSFhXZnlDbWpFaGU2YkR1WjBiMkVW?=
 =?utf-8?B?YmdZeTFsOUVIWVJEdEpraGE5V2FwKzBiYytKOFBYTS9GY2JKRTM2Qktwa1dj?=
 =?utf-8?B?QzZ1TFhycmdYV0dUV1RmOUZGdlFkRnNWbHlMM0JDQ2IrZi9XcWdzUktxM3JK?=
 =?utf-8?B?eFNjanJscVZmb2U2MjJyb1V2U053dzFndHVJT3c1SGR4WjVsVElhTzk0Z29S?=
 =?utf-8?B?bWNQZGEvbHR2MTgxN3p5RHhna2V2U1h2V3VoOHhJb1NwcUlYd1E5VUhIVU8z?=
 =?utf-8?B?bFhldFFOU3dCSUNqRmZaaHVqOHNHSkNzTWkwcXpCdVA2cDU3eHFmNHlBemlv?=
 =?utf-8?B?dE9mT0psdE41STlEeEdna0ZiYnhlSHUySWEyVGdWem0xRlplVkFPWkxqcmVF?=
 =?utf-8?B?a1VrTUhRSWdDaGZrVDhrbEZsVWQwS3FtaTM1SHBlRmNpc2puWDFWbFNRKzZH?=
 =?utf-8?B?Z04xREVQS014bFUxN204Uk4wZnhqaEtHNkEzNWpNQ0tmYXFLeHl4SERRZTRY?=
 =?utf-8?B?TGZXSGJka3dZWS8xdW5FdDVZSGphbHdydi9JSnUveEd6bTlUQ09ISUErRGJY?=
 =?utf-8?B?SW5PODNpREprZ0p0OXFvMmwrY3pCUGd5dXptTHQraHJxWkZ1WWh3bFlOaURY?=
 =?utf-8?B?eGRVdlZsWjQ2M1dIQTRNV2hXOHRTTHVrRHk1eE5ncE9iUloyLytOVWE1ZXRW?=
 =?utf-8?B?cEE5UE4xTVB2SjlpWVRWTTVRVW01R2k3R3hEZVRQRS9KR0JVSG1aRUZiRHp2?=
 =?utf-8?B?UDBld3FodC8yeXM2cnRlUUZiNG1KTlVHTnZXdFpmRHdvK2k0amhOM1ovcW9K?=
 =?utf-8?B?K0hoRmgvY1dKeVhsbk1NZUNKclF5YWs3NnBRdEpFcEtlT01HQUMrMjFsSndN?=
 =?utf-8?B?MlczTEFCQk4rU1hVcmJZK3BvWTFTa0J2dStIRi85c3hVS0xBaTRUamJ4UkFZ?=
 =?utf-8?B?OFNJVjl0dTQydjc5S0ZIYVlNc0FoajVyVTAwaWhtbWlwcVhLcGZ0cWorV2Z6?=
 =?utf-8?B?b1U3eGFJK2tXN2R4S1pud0Z4cURUbWozQk9kRmlYVGlhbzdEWWlONUdIVWw5?=
 =?utf-8?B?dmNQSVlNRWQvb2NIemxBMm0wYm5EbnNhU0Z4eDMzdkdYQnluSEh2eTVOTFdM?=
 =?utf-8?B?aEU4YXFEOW8vWVBENTBFWXdVdnNSeEh4SU9mNnltYnkzcW55QmxuekZFUHJh?=
 =?utf-8?B?Ty9DUFIwSGZ6REY2QTZJaEtEdnB2UEMwWGJUczdkc2dUb0VwRXBVVEJuTXRQ?=
 =?utf-8?B?TGU5UnNiUGQyQ25wWWw3d3hyUUNUYmtha0F2cHlLYmJMeG4wSEV5QjlvT3RY?=
 =?utf-8?B?Rkpsa09rc1g0bjhMQmVpY2trV2toRGJRMzdZeVVGc0FMWXQ4d0pWSkFCQ0Fl?=
 =?utf-8?B?MS9JdlBkQU1zY2gvc20rWHpGeXN4aTVnU2FpbGZsZVVyZFIyUnAxS1g3TWV2?=
 =?utf-8?B?R2wxTWhNZWxtdVVHWUpvSzFlaFcyRGRKTTFXeTd5WDBOa1drZFhXRnVYQWxh?=
 =?utf-8?B?Mnl5STBBaURtbFFmdS94Z0xyRUN1OEduZ1RrbHVvWGJvb3ZvZGVaQTN1bWdC?=
 =?utf-8?B?a0VqcllkQy9Ta0VNOTR0cW51WitYc05neElNNno3TkIwWVFJYmo4QllJVUpM?=
 =?utf-8?B?TXBXZW1tdkdFWnkxNjZqbURlUy9iS3NpdVdBWHJDTEg2SXYxeGZ4aGg2YUFu?=
 =?utf-8?B?ZjJpaGNoQjVhRXQ5VkVGNitXS1FJem53V3M4NUtIdFVTait1NmZraG5Pb1Ja?=
 =?utf-8?B?cFRwTFQrSy9EVEdLQ2I4RlZYQkViM1F2OXFkTXF3MnNuMDVHU0M2UHoyYVlR?=
 =?utf-8?B?dFpNZ1AwZERDckRuTGU2TXhVbk5la3lZM0hEMzFSVnJydFpMaTk1WjREY2dv?=
 =?utf-8?Q?eWmkRWSVp6kocCC7ZnLbMQs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uX47OUfMEXnZhQciHhENM1qv84A8QxIUw4rDYmIRUoy/R+EJ2PTOuITu4wvSNf/rht7AI0x1v6rqFa6mSDlgtixCmC5Htg06PTjiP8yCl9HM0r9htYtVpijLtTWv4Cb14EXPmnWG9LUko2aJYFoyyNaqP6+Xxfv5LNW2nRUCmZmsgGVfSGfvfpSbtkaV1x6uc3wV4nuCJUsBEcT04YYcNdfaDtnsx6FuBkSHtbNYARPF2UZRDJA75+KLCBR7krlbhgtWcIhOBIaRTUa5Gs08R7lmIBUMJn7sxr5U3qAs3fvnTRO+YSmPDRQ3ZmPAcwyAfxOpLUhBhBWm0q8BMygCem2weDjuVpDWwVlOyV01piauXWvqfWjP7P+k3e8JBYW/jLgEz9iAC9L5T1UI/09r/3WSBXIDprNeEGgKhMlwgH8JOJZqv9zmiQ5sWsexmQvC7+BnDZBDhxcLxcM58+x8Xoo562koxxJGrnATc58RymR2+vzoaI0knck/I8Wv7P1NIOoIk23vd0EuNCW5QaQUadNG/h4N7Tf3BM2GXJLyZ3B943/OUp66rieK3IweRrudgIyg/NU/mduDsLXgZk7QU8f3jAL3l0eJnBaB2Z2xYpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aa6751-b127-4b15-97b0-08dccb51764c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 13:16:33.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uomdQWsAyOsSKhMFuxFpY7m5lFOlxN7uB8aYvCzZnI0PordOK4JcEME/bW1YQ6woAyjhdMfzYKu1ouk5B2DmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_03,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409020105
X-Proofpoint-ORIG-GUID: cbjSmgOB-RRU5F5ICE-RDfIOXQMwZvgH
X-Proofpoint-GUID: cbjSmgOB-RRU5F5ICE-RDfIOXQMwZvgH

On 02/09/2024 12:11, Viktor Malik wrote:
> Coverity reports a possible memleak in `dwarf_cus__create_cu` due to
> `cu` not being freed for the case when it was allocated but
> `cu__set_common` failed. Fix the leak.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  dwarf_loader.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 04f5637..ad36e3c 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3378,8 +3378,10 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *
>  	 */
>  	const char *name = attr_string(cu_die, DW_AT_name, dcus->conf);
>  	struct cu *cu = cu__new(name ?: "", pointer_size, dcus->build_id, dcus->build_id_len, dcus->filename, dcus->conf->use_obstack);
> -	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0)
> +	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0) {
> +		cu__delete(cu);
>  		return NULL;
> +	}
>  
>  	struct dwarf_cu *dcu = dwarf_cu__new(cu);
>  

Good catch! Looks like there's another few instances of cu leaks like
this later on in __cus__load_debug_types():


	if (*cup == NULL) {
                        struct cu *cu;

                        cu = cu__new("", pointer_size, build_id,
                                     build_id_len, filename,
conf->use_obstack);
                        if (cu == NULL ||
                            cu__set_common(cu, conf, mod, elf) != 0) {
need cu__delete() here ->
                                return DWARF_CB_ABORT;
                        }

                        if (dwarf_cu__init(dcup, cu) != 0)
need cu__delete() here ->
                                return DWARF_CB_ABORT;


Could you respin to fix them too? Thanks!
