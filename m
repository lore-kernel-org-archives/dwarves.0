Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6920E6
	for <dwarves@vger.kernel.org>; Wed, 25 Sep 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256499; cv=fail; b=NtAn2HNNLRts0mlHqJ9gz0X0m8tQ4plQG9vaBnQpasHN95c7Swq3rORSPzG5sEldVrgpdHz0xmAleNykUl6G6w2slaII0cZPBLjdxbCsDEB1nTqUU3VTsk5OALYgiU+9Tfvs2OIQUbsHaqZD2J7BpcRhSy+Xmmej1Et7MEJ8iJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256499; c=relaxed/simple;
	bh=HXi6Fic2kCNqbUpG7hf40tNFReY+UIYPytHwO3/Tj5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UBocLTkbfb1gcnGV4t2hNOwVZrkZe0NJSm4ef2JgEp3t5T5pjF12PEbyDd6S26mXkV4/hUGqmqX7HEEm12oZKGrjhxeryuy3/dEyIbFbVBf62T+w71wnaN2RpLWZxIMWgR2+PO4kI+Mt5W+7QgmBJsJ9SI0ZhaCymhKjo2GVrFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LABCfeju; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v1xHT6wp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LABCfeju";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v1xHT6wp"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1u6Iv011646;
	Wed, 25 Sep 2024 09:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=4A58hDvxTldWs4+f5cpJHKEgIlJBTcocqNEP41dhxxw=; b=
	LABCfejuTeYc2JzjSSxe5isQRR/CA8auj6N3o8a+Bi3CGA/SlyOhm4o2QL7UrWsQ
	Nr88nZDxXYDNbi4AfNhsdVvV1y44k2L20FsMHm9npeX0U+ZFtb0mHK0RrzGudmF4
	niZQxhPCNFUupssWsIIcbiruocPssvLZsfQqNV8BtsQHvVNYcSt1SAO532yb67aG
	tX/3F9KhnaR68XVgfFS0pIe5oKrcb4O2DsQ4A8ZE6l+LRmqY7D34gYLIhGDBcZt/
	8oxY1tHQiO8PJQT/XIVZr1PhJBXtChBX+KRFjqT3rWE2HmF/lMKWsJpTzakoFWh3
	nVZNHnBvIQ62uxvlvLfFhA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx37cmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 09:28:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48P7bw7s031128;
	Wed, 25 Sep 2024 09:28:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc70ee6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 09:28:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWUn4GnvjVat5VUsgYJjR55G96Y700rkzkPfmpjpKew0AO1c7S4Vu4Qi49Arges5Bhodc7q4T2Idkn4fkED6gejLggweh/APJQlyew6TavzlhzUD+be3iOBUqdYyHQ8Kltx9xgEidtktaF1uohPhufH4QUpDLJK7mFLojSsGAtFBP7CjU27fLQce8lzrSO2LpZl/brmwagCMocPuyWllYCHRPbXUrrnDtEt3EHjBuAWXoGKHKpPs1gJHqp+hXPxCKtWA2uDHDvvKW8DojMg+fmVCdkoJhGhDxAD9ZPGHOT//W+48agx3by+vZuvPVBOjE75m0b/KazoGR5okeEYniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A58hDvxTldWs4+f5cpJHKEgIlJBTcocqNEP41dhxxw=;
 b=AhDR6jqoZkqv/lphkrq3KpgkUnd1gpzvbjlwpSW3qCRfYLIHLKfNnZkK5KDCwWSVfzGIfzTG1HT843K3K6ewtBEdDsbeJkNifO6eLAVUUCcu6LqgGU09ZTM/j2guWLeU3g4KU7x3odd5134gX6LosP4HR1UCD8OdfBmF+DRI8hDQ1Tuox9G2acC3NvzohBCzvbgHK4g+zcigMIBYMu+uf/77EaM2kmPDarL1ZBdvlQ4aQRtmlL9QmVrr6d0uYvIBB/4Zbrqb583RS168w1BD3X4bGcTM8itsGBrGNlPiWAu5EM87KoG0aEIFiNiH+Vl/ESSbrSP24MHryDOc/ht5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A58hDvxTldWs4+f5cpJHKEgIlJBTcocqNEP41dhxxw=;
 b=v1xHT6wp13218m+iaYE7xSwd1uX0i+6XBpUV8LzOgQAbLG5+1WWDnO9MZ2BrzPLpwBU1G+OBc1uWnciev44QwCh2JZLZb7rykkZeLdsiXXIPfxJksawtubnnSDXERGmuwDIXGhR3aogqpfw6j+yEfxwbhx3lHkkWNbVq+5hwYbA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 09:28:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%6]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 09:28:02 +0000
Message-ID: <388875a0-8768-4be1-b4f7-27b6418a866d@oracle.com>
Date: Wed, 25 Sep 2024 10:27:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 3/3] tests: add test validating BTF encoding,
 reasons we skip functions
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
 <20240916134946.3893204-4-alan.maguire@oracle.com> <ZuqSNU414XALGsuJ@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZuqSNU414XALGsuJ@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab5668c-26b3-43cd-4cb9-08dcdd445a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnlDVXJ5RGd1cnRhMEFMK3dFOUpaTVA1cVhmVjhRaHJzOFVET1hvUUpBK1Uz?=
 =?utf-8?B?bzRmSlBmU21QbDhCN3F2R3lHZG80NHdIN2dvNXdNdHRnbzgyK3R5Z1YyZ25N?=
 =?utf-8?B?M2VyNWNKVUZzUFlERkNIRHRwVloxQUc2OE9EckdOaWdOU3BtUmR5Z3JOdDMx?=
 =?utf-8?B?cTcvcDZ5emU4S1BuRzQ5a0t1NUxacXlqUDh3ZURXTzhvTXorREF1YmNwNGIr?=
 =?utf-8?B?RTRkWGJLTmt0UFcxRmJHamw5UmtJNEF6dkd1amV6bHhMZTZVUlNhUUNIZTlj?=
 =?utf-8?B?QUx5VjlOZVJXaHNpdXZJUXJZTjlFZURjOVZuNkRVOEk5SE9tdkQ2OVRib0Z3?=
 =?utf-8?B?RWZsRHA0RHNiai9hVmQ5WUpLeUt6NTNCMW1UYmVsK2lEbjNhbDMwNm9oUUFs?=
 =?utf-8?B?NjE3T0ZaQW9IN3I0clRYb2lWOVdnVHVoRHZsWDFIWTdVeVRqb0o5SCt6Umd1?=
 =?utf-8?B?M3p4NWJGSUMwazduSHFNYzBHTmdwSzRkNEZiUXUrRnBuVHVFbHZWcjA0WUc1?=
 =?utf-8?B?aXROSi82aC8zK0lJcnk5UG5JQUxHODMxeFJQRlU3M2FROTQxVmZjdnUzSzVq?=
 =?utf-8?B?WU1UTC8rdU91VmtBblZhT2VHSEdyTWVHVWJiWnBaTG5KeDhrSngva2RXbmRB?=
 =?utf-8?B?TUN1blpGcEs0dVAwUUVORnhOcExTVklHSWd4U3VRUEVMZXN0K1prQ2hlZmNr?=
 =?utf-8?B?a2JsUFlQVzhBMFZLQVFvc2orRmJPWmU2bStPNnpXSVJoQmNrUVhGdkFYSnpu?=
 =?utf-8?B?VFprdkEwYXdNMjRmdmZBV0JXUlZVTVB6bzFVdWVISkhuY1N0NG9GL3V1dm51?=
 =?utf-8?B?RmNkRndHd2pFWWRNcmdRQzlDR0NLbmtaMjk4SEtZTWUwR0VOVmU4VnkrckEv?=
 =?utf-8?B?ZllTSFBRc2tvdVBzR0pDOUVKTUhMTFBzUlAwS1FUYWl4ZnZlbUhyTW9YY0RO?=
 =?utf-8?B?aFg5NE1zdzJTdlEwbUpzRFEzV3B4K1VJbFNORGlIMzZvUmdOLzE2THhGNnNI?=
 =?utf-8?B?S1A2QnY0djVEbG1QK2l6a2tXZFB5R0YvV3V5emJKNnh4ODg1MmQwZFlncWNk?=
 =?utf-8?B?M090NEtEa0wvcDR1YzNnOTY5SDFFcGtDT0xaM1VqditLeXA3WDhOcVErNHFQ?=
 =?utf-8?B?aTNVRnM0cG05YkNudjVFVGJzdmdQM3pCYXNKaHR4c1hnVHZWUTdGMm1tMmVT?=
 =?utf-8?B?WkdWdXVSeGxQcnhxaDNkVWZ3V2NUUU9aWGN6akhqK29KZDdVaU1GSDFpN1pw?=
 =?utf-8?B?TEErZFpWUkh5dnFHK3dnWmR4ZmZVK3NzS2FLSC9taHpaZFRZbU1HMnRjZGdW?=
 =?utf-8?B?bGNrSUozaUhIUjdhMEZEaXdhcldzZFN1OENleEtleGRzT2lZOHlrdi80SFMw?=
 =?utf-8?B?OWY5MGM2Q2xYK1piV3dURGEvZXVyOVpZcDAyV2NJNUpxbWZWT2I4K2J1Ui9B?=
 =?utf-8?B?VWRNanY5RTBoTENGMnA4NFp0MDJXZTVheHBQSlRkNVd5Mm5DQWUyT3l4enZK?=
 =?utf-8?B?S285TFJiUDVsVGFFcUpHYkxwZDlpaXRvSTY3N1dJZEE4Z2VkWHIxd292RERZ?=
 =?utf-8?B?T2J1d0N1eUdYQVczUCtnYzY2MmZ0RW83OVdzQnEwWnRiRGpzQ3pZb3lzZXBx?=
 =?utf-8?B?VldSbXNBYUZkY01qS1dVV09iS0tta1lQcW5hdGJNQllud0ZIYmczMnU3cEcr?=
 =?utf-8?B?bGxtVG10b2ZLS0ZHRHlLUFdWWjJDTXRjbGE1TTBMUmVUaXg5Zzk0UHV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkhXN1VTN01EYkhBakp4djgxUzY2REJuYTZ6Sk10OVF0S2d3cHo4WWYxQkZl?=
 =?utf-8?B?T09sUFZlayt4cFVFRjNqbm9Nc0VDODl0Sm1qNk4weGd2a2FGM2pPK09OajA5?=
 =?utf-8?B?REZnNzVONFAyRnQ4OG1wVFdVamJmU0pTWEMzZXdsd1J4bXNSNDlLMVgxeWUx?=
 =?utf-8?B?RzFmSGtRcnFaWG1zc1ZLckNsV1BZbVBNN0hwcXZMWXUrb1FqV1RWY215aHc2?=
 =?utf-8?B?M203ZTRRS3EwMUhkdjFIYms0Z1RxRU5TbXBReWNZYldlRTJtVnJPTlZOZm1X?=
 =?utf-8?B?SEdyd1lLZkRkWnE4T1I3UHVPV1MzaHZxc25tdEFOWnk0dEh5cnJQenVMck9C?=
 =?utf-8?B?T2NReUZRTnFrZnA2N3BnOWlZVWc1b0FRQWhBdDNBaE9yLzI0TlBmZlJZZURn?=
 =?utf-8?B?emFaY1pFTGRSMnZHMDJWanZnSXVFbUppdFV4YWh5Mkh1U0N2WjVsTkU3Rmgy?=
 =?utf-8?B?VGh3NzZZZlN4RFpZNThHUGxCZThWOE5CRWxjVHhzdkRiWHpRa1RXL1cyWlJp?=
 =?utf-8?B?c0QxRHVNSjB0Q3pIcE95b0h0dzdsM3dZZEZOQmgwMURyVFd4ZDlJTVphb04y?=
 =?utf-8?B?YVh2amdpWnJaRDZPTE50UkJCNHhGVnlOZ0c3UlpmbEpiSy81cmQ1TUtZaVhn?=
 =?utf-8?B?TUFkVll2TDl4cUFyQmZMOE9Mekx4Tm4vWlJXeXRSZFFGeGRUcy90cm10Tzhn?=
 =?utf-8?B?aWZZNXZXbnRnTG5sY3M1UG5hK3NYSWg2ODNNeDE0RnlGVUtRZDdLbkhYL3Nl?=
 =?utf-8?B?L2xaTEE4ODNJa3o2UTRWZ1phVVBzdjRuOHJrWWNBYXV0bjFxRWJieG1tM1B5?=
 =?utf-8?B?bktuNERLWHNwRWVncHpOM0V5ZzRGYzlyT29tczQzQXVsMDZzYkZjTkd6cFVm?=
 =?utf-8?B?M2F3dnEyYWJSMW8rWXdEMVJGTUwxZWV5WlNRZlpxTVB6d2dRazhnZ1E5Y2pu?=
 =?utf-8?B?dnF6aDdycVRrLy9XdytJOTNvLy9STHlKeEk1Yy9xdUFTYTFDTDdpSzZLUGE3?=
 =?utf-8?B?MzBhZGd6UWI3MTRGamlCdkpnVGN1K29QUlo0TEhuZWdmRU5BZ2tEVXU3eFls?=
 =?utf-8?B?dFAzQk40OWtudHhoc0kvNE05MmVleXRRVTF5Kzd0YTA5MmxyVHpFcWZ0S2lE?=
 =?utf-8?B?TjNlRmorZ2Rpd0k2c1dDL0JFaVJKOS96a3puQlI3WUIycjZLdWlMMFI1OWd6?=
 =?utf-8?B?a24rRVRUb3loOGdhTzIvRGlaQmhsSWVEdE1jSGovdkkyc1ZlZ3JXZGdobnR6?=
 =?utf-8?B?K3l2eTE4elowcjIyRFk3US9TZ3hDTFBwL3FlNkVJMHBZa3UxNGpvM0pHVkdM?=
 =?utf-8?B?b0QxcnAwUmZ5NWRhS0FqdkFSOStJc0Y5U1NpU3ZHZlRGWmhlajRLT1duZjJ2?=
 =?utf-8?B?cjF1NUF3aHFiU3ZxeXIybDdIVFZmbWxRemE1aFg5VkkzUmVuR2hCbGltOVox?=
 =?utf-8?B?Ti80ay94TDR5eG4vODMxUzgvdHdYZkhhVGhFMUNOaGV0VmQ4Q0dwTGRrbUlz?=
 =?utf-8?B?SU1HZDlSRjhsbHZiakhsYzJ1NXF4dDhhUm5vRGt4TjJ2Yko0ZFVZRXZpSWdR?=
 =?utf-8?B?SHpTNGtNUk1mMkUvdGZXeSt6bk4xU0Y0MFptc1FsbEhGdzlkZ2xpU1NHUW1p?=
 =?utf-8?B?WktVcHVNZWFzWXBGZFpzclNPQ0FXOEtIN1l6MEIrNWZRb0F3SnF6Y3BOajhK?=
 =?utf-8?B?WUd6T2NYSnBxaWhISFUzMUVydXR1NmZidzVXZi9uL3QrbFBzYUxCb1pPN25N?=
 =?utf-8?B?MVRpU0tXOFpGM1JCYXIzNDVCbXJPMEdUa2hWenVUQ3RDU2NNZlIwdGFIazBC?=
 =?utf-8?B?eWFSSUdIb1FTdnZBTFAyZFpmV3hRVCt1SjhZTEpQRlduZUp3alpmVVh1SFhC?=
 =?utf-8?B?ZkwwbHZ6dmg0WDVhek1NZ2s1eWdlc09QUWNXd2Z0Yk5zRkNMeWJoM0c4T3Bs?=
 =?utf-8?B?Qm9QOFZyaVdXdXVSSHE2NlIvblFxTmFHSXAxNFc2M2VYNUtFTzM1dkgxNGlW?=
 =?utf-8?B?MGN4UHltbGVvQi9ncGw4RENTdG55TVE5a2xPT1BRU0twUXM4RGMyV2NDMEV3?=
 =?utf-8?B?OUoyVStlSlc2MDdCYlZtOWwxUDJpdS9UYjZqbDF5T2p1TjloRE14QVFZVGcr?=
 =?utf-8?B?NVdJU3VkK0lNNGpsZFJESEt2RkZ5M3NBWHl5b1ZjeWRCTGcvV2FLMnViM0ln?=
 =?utf-8?Q?VbRdaopsLLAAY3rg3u7Xjkg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1HW/iuTEGeMNT8HraU/hWfU3+IUZVLZkb9T+hvDRzdOl/AtOpdjqt3GKOfVzGa2eNIMvKz1Px+b9JjzX5Aaz4N6DNQ8mulAQTrJmnU1qP/1IH1couP+v451Nq3f/zlFvmp28Lh0AsND1YR655zQpB2VkH8H4SHbIqcDebWt/wEzC1lVavSCMPhBWSdVauHLv36rYKRlADWbtQeUyTy59Brb9mUYDKyNB7kKO2ndvXMyM119PUfHxbis/hjq0yvEn5kfsSWkPCuW3rkyH6Jam1pYgN3sg2GXlcNMxwYvJRnXzQkyhI5Rcf6ANCVeii9buNTEYpyGhLlT0lA8BNgiqo2E1JA/0iH79+gvKWOINb/D1iA0aFSd83nJB0Z2TFxQFboBBTquZn1U9CVSf2Dg2edaPAmZsu0/wiS/6Hf3G4lMYXPDyW3qXbDJwRCCLYfTTYn9DH1CChejLYtsvL+b6EI5NJ8q3jZv04DNd8RWD4LoXgMtwiXMYx3yuADHQpXAc+EbAn9P50h9EKgp0Pcn1s4agxMMXj612THvo+G0gOvfOPNtyXWeuc09Fc4ixons6xnScKcwPSJeLCaOdVNGnmZ103DVlVd3ffQwGr6ATsy8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab5668c-26b3-43cd-4cb9-08dcdd445a9f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 09:28:02.9599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px3ppxXolNKoy6FiR5m/sxuALr8i/y9/atA0tc9G/cULDg4tq9ovex1xlL6scKj3LkjcfDJhmXGc54JpmpX33g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-25_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250065
X-Proofpoint-ORIG-GUID: XygGF9k-G73qdGKvqCF9RRC4le-o8NqQ
X-Proofpoint-GUID: XygGF9k-G73qdGKvqCF9RRC4le-o8NqQ

On 18/09/2024 09:41, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 16, 2024 at 02:49:46PM +0100, Alan Maguire wrote:
>> use pahole to encode BTF and pfunct to check that
>>
>> - DWARF functions that made it into BTF match signatures
>> - for functions we say we skipped, we did indeed skip them in BTF
>>   encoding; and
>> - it was correct to skip these functions
>>
>> It is not possible to check everything, as pfunct does not
>> print "."-suffixed optimized representations, and it does not
>> analyze location calling conventions.  As a starting point we check
>> for
>>
>> - functions encoded in BTF match signatures with DWARF
>> - functions with multiple incompatible return values
>> - functions with incompatible parameter count/type
>>
>> This test automates manual validation of encoding/skipping,
>> and as such will be useful to ensure regressions are not
>> introduced, for comparing gcc/LLVM-based DWARF representations
>> etc.
>>
>> The test takes ~5 minutes to run in all; output looks like this:
>>
>> $ vmlinux=~/kbuild/bpf-next/vmlinux bash ./btf_functions.sh
> 
> I'm trying without specifying vmlinux, what we have now in the
> tests/tests should find the one for the running kernel and use it, but
> doing so I got tons of warnings about egrep usage, so I folded this:
>

I should have better explained the rationale with the env var;
the idea is that the user can specify vmlinux=/path2/vmlinux and that
would be useful for a "make test" target - the vmlinux to be used could
be specified across multiple tests; we'd just need to add the same
envvar override to the other tests that need vmlinux.


> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
> index 45094077809c1e3e..4a60a18845115d3d 100755
> --- a/tests/btf_functions.sh
> +++ b/tests/btf_functions.sh
> @@ -69,7 +69,7 @@ const_insensitive=0
>  for f in $funcs ; do
>  	btf=$(grep " $f(" $outdir/btf.funcs)
>  	# look for non-inline match first
> -	dwarf=$(grep " $f(" $outdir/dwarf.funcs |egrep -v "^inline ")
> +	dwarf=$(grep " $f(" $outdir/dwarf.funcs | grep -Ev "^inline ")
>  	if [[ "$btf" != "$dwarf" ]]; then
>  		# function might be declared inline in DWARF.
>  		inline_dwarf=$(grep " $f(" $outdir/dwarf.funcs |grep "^inline ")
> 

thanks; I incorporated this change (along with some other changes to
minimize the amount of greps/pipes where possible) into the v3 series.

> Running with it now:
> 
> root@x1:/home/acme/git/pahole# tests/tests 
>   1: Validation of BTF encoding of functions; this may take some time...
> 
> Seems stuck, so:
> 

This part takes a while - for me around 3.5 minutes to walk through all
functions in BTF and compare signatures to DWARF.

> root@x1:/home/acme/git/pahole# pahole --running_kernel_vmlinux
> /usr/lib/debug/lib/modules/6.10.8-200.fc40.x86_64/vmlinux
> root@x1:/home/acme/git/pahole#
> 
> Had to stop (traveling/LPC participation), so sending it now, what is
> written above should already be useful :)
> 
> - Arnaldo
> 
>> Validation of BTF encoding of functions; this may take some time...
>> Matched 55969 functions exactly.
>> Matched 239 functions with inlines.
>> Matched 1 functions with multiple const/non-const instances.
>> Ok
>> Validation of skipped function logic...
>> Validating skipped functions are absent from BTF...
>> Skipped encoding 748 functions in BTF.
>> Ok
>> Validating skipped functions have incompatible return values...
>> Found 8 functions with multiple incompatible return values.
>> Ok
>> Validating skipped functions have incompatible params/counts...
>> Found 116 instances with multiple instances with incompatible parameters.
>> Found 2 instances where inline functions were not inlined and had incompatible parameters.
>> Found 351 instances where the function name suggests optimizations led to inconsistent parameters.
>> Ok
>>
>> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tests/btf_functions.sh | 192 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 192 insertions(+)
>>  create mode 100755 tests/btf_functions.sh
>>
>> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
>> new file mode 100755
>> index 0000000..4509407
>> --- /dev/null
>> +++ b/tests/btf_functions.sh
>> @@ -0,0 +1,192 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Copyright (c) 2024, Oracle and/or its affiliates.
>> +#
>> +# Examine functions - especially those for which we skipped BTF encoding -
>> +# to validate that they were indeed skipped for BTF encoding, and that they
>> +# also should have been.
>> +#
>> +
>> +outdir=
>> +
>> +fail()
>> +{
>> +	# Do not remove test dir; might be useful for analysis
>> +	trap - EXIT
>> +	if [[ -d "$outdir" ]]; then
>> +		echo "Test data is in $outdir"
>> +	fi
>> +	exit 1
>> +}
>> +
>> +cleanup()
>> +{
>> +	rm ${outdir}/*
>> +	rmdir $outdir
>> +}
>> +
>> +vmlinux=${vmlinux:-$1}
>> +
>> +if [ -z "$vmlinux" ] ; then
>> +	vmlinux=$(pahole --running_kernel_vmlinux)
>> +	if [ -z "$vmlinux" ] ; then
>> +		echo "Please specify a vmlinux file to operate on"
>> +		exit 1
>> +	fi
>> +fi
>> +
>> +if [ ! -f "$vmlinux" ] ; then
>> +	echo "$vmlinux file not available, please specify another"
>> +	exit 1
>> +fi
>> +
>> +outdir=$(mktemp -d /tmp/btf_functions.sh.XXXXXX)
>> +
>> +trap cleanup EXIT
>> +
>> +test -n "$VERBOSE" && printf "Encoding..."
>> +
>> +pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
>> +
>> +test -n "$VERBOSE" && printf "done.\n"
>> +
>> +echo "Validation of BTF encoding of functions; this may take some time..."
>> +
>> +funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf |sort)
>> +
>> +# all functions from DWARF; some inline functions are not inlined so include them too
>> +pfunct --all --no_parm_names --format_path=dwarf $vmlinux | \
>> +	awk '{ print $0}'|sort|uniq > $outdir/dwarf.funcs
>> +# all functions from BTF (removing bpf_kfunc prefix where found)
>> +pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf |\
>> +	awk '{ gsub("^bpf_kfunc ",""); print $0}'|sort|uniq > $outdir/btf.funcs
>> +
>> +exact=0
>> +inline=0
>> +const_insensitive=0
>> +
>> +for f in $funcs ; do
>> +	btf=$(grep " $f(" $outdir/btf.funcs)
>> +	# look for non-inline match first
>> +	dwarf=$(grep " $f(" $outdir/dwarf.funcs |egrep -v "^inline ")
>> +	if [[ "$btf" != "$dwarf" ]]; then
>> +		# function might be declared inline in DWARF.
>> +		inline_dwarf=$(grep " $f(" $outdir/dwarf.funcs |grep "^inline ")
>> +		if [[ "inline $btf" != "$inline_dwarf" ]]; then
>> +			# some functions have multiple instances in DWARF where one has
>> +			# const param(s) and another does not (see errpos()).  We do not
>> +			# mark these functions inconsistent as though they technically
>> +			# have different prototypes, the data itself is not different.
>> +			btf_noconst=$(echo $btf | awk '{gsub("const ",""); print $0 }')
>> +			dwarf_noconst=$(echo $dwarf | awk '{gsub("const ",""); print $0 }')
>> +			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
>> +				const_insensitive=$((const_insensitive+1))
>> +			else
>> +				echo "ERROR: mismatch for '$f()' : BTF '$btf' not found; DWARF '$dwarf'"
>> +				fail
>> +			fi
>> +		else
>> +			inline=$((inline+1))
>> +		fi
>> +	else
>> +		exact=$((exact+1))
>> +	fi
>> +done
>> +
>> +echo "Matched $exact functions exactly."
>> +echo "Matched $inline functions with inlines."
>> +echo "Matched $const_insensitive functions with multiple const/non-const instances."
>> +echo "Ok"
>> +
>> +echo "Validation of skipped function logic..."
>> +
>> +skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{ print $1}')
>> +
>> +if [[ "$skipped_cnt" == "0" ]]; then
>> +	echo "No skipped functions.  Done."
>> +	exit 0
>> +fi
>> +
>> +echo "Validating skipped functions are absent from BTF..."
>> +
>> +skipped_fns=$(awk '{print $1}' $outdir/skipped_fns)
>> +for s in $skipped_fns ; do
>> +	# Ensure the skipped function are not in BTF
>> +	inbtf=$(grep " $s(" $outdir/btf.funcs)
>> +	if [[ -n "$inbtf" ]]; then
>> +		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
>> +		fail
>> +	fi
>> +done
>> +
>> +echo "Skipped encoding $skipped_cnt functions in BTF."
>> +echo "Ok"
>> +
>> +echo "Validating skipped functions have incompatible return values..."
>> +
>> +return_mismatches=$(awk '/return type mismatch/ { print $1 }' $outdir/skipped_fns)
>> +return_count=0
>> +
>> +for r in $return_mismatches ; do
>> +	# Ensure there are multiple instances with incompatible return values
>> +	grep " $r(" $outdir/dwarf.funcs | \
>> +	awk -v FN=$r '{i = index($0, FN); if (i>0) print substr($0, 0, i-1) }' \
>> +	| uniq > ${outdir}/retvals.$r
>> +	test -n "$VERBOSE" && echo "'${r}()' has return values:"
>> +	test -n "$VERBOSE" && cat ${outdir}/retvals.$r
>> +	cnt=$(wc -l ${outdir}/retvals.$r | awk '{ print $1 }')
>> +	if [[ $cnt -lt 2 ]]; then
>> +		echo "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
>> +		fail
>> +	fi
>> +	return_count=$((return_count+1))
>> +done
>> +
>> +echo "Found $return_count functions with multiple incompatible return values."
>> +echo "Ok"
>> +
>> +echo "Validating skipped functions have incompatible params/counts..."
>> +
>> +param_mismatches=$(awk '/due to param / { print $1 }' $outdir/skipped_fns)
>> +
>> +multiple=0
>> +multiple_inline=0
>> +optimized=0
>> +warnings=0
>> +
>> +for p in $param_mismatches ; do
>> +	skipmsg=$(awk -v FN=$p '{ if ($1 == FN) print $0 }' $outdir/skipped_fns)
>> +	altname=$(echo $skipmsg | awk '{ i=index($2,")"); print substr($2,2,i-2); }')
>> +	if [[ "$altname" != "$p" ]]; then
>> +		test -n "$VERBOSE" && echo "skipping optimized function $p ($altname); pfunct may not reflect late optimizations."
>> +		optimized=$((optimized+1))
>> +		continue
>> +	fi
>> +	# Ensure there are multiple instances with incompatible params
>> +	grep " $p(" $outdir/dwarf.funcs | uniq > ${outdir}/protos.$p
>> +	test -n "$VERBOSE" && echo "'${p}()' has prototypes:"
>> +	test -n "$VERBOSE" && cat ${outdir}/protos.$p
>> +	cnt=$(wc -l ${outdir}/protos.$p | awk '{ print $1 }')
>> +	if [[ $cnt -lt 2 ]]; then
>> +		# function may be inlined in multiple sites with different protos
>> +		inlined=$(grep inline ${outdir}/protos.$p)
>> +		if [[ -n "$inlined" ]]; then
>> +			multiple_inline=$((multiple_inline+1))
>> +		else
>> +			echo "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
>> +			echo "Full skip message from pahole: $skipmsg"
>> +			warnings=$((warnings+1))
>> +		fi
>> +	else
>> +		multiple=$((multiple+1))
>> +	fi
>> +done
>> +
>> +echo "Found $multiple instances with multiple instances with incompatible parameters."
>> +echo "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
>> +echo "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
>> +echo "Found $warnings instances where pfunct did not notice inconsistencies."
>> +echo "Ok"
>> +
>> +exit 0
>> -- 
>> 2.43.5

