Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFB256C8D
	for <dwarves@vger.kernel.org>; Mon, 10 Feb 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206699; cv=fail; b=WRCPTLayvfYZZD8HN7dBkqKbqKNGiRB7TDD2FmHCQ7XemtbpCvDREjd97bSYBxI7nqZipCXKFB+nzoHLX/RSVtlYtiMEhpo2ULQfhNEeHH1b6lENlqOMSxU+iJ9FkavWrwjPXMtWIpRgINl9C6Jpu29n4C1eeG9D72e6T2mmxGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206699; c=relaxed/simple;
	bh=DcMe/9LjxNuHI6vL/A0s7K0HMMm1qpU54ybiJJr7Vsw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DejV+azUlqdQLSlOlhe6AIWV7e6F5S3d8dbHj31Ic5FlMgDbcL7owmYJlkz9tNrvAbRw9cqPslP+L5ZllAWI0DJCELX1KDgmfDDkORwbP/zZmY6lJP5AK9xfEvs4lnNQBfcwE7kYI6GsCoz6b3iw4T+T8kTJPWz2L8BctGUSCLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y0YGG8ny; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bo7scSHR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y0YGG8ny";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bo7scSHR"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AGfac9025250;
	Mon, 10 Feb 2025 16:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ml1ZzCzbjMoY3bP7Ema/Pd+EC9Flur6ZW0PKdAPaRv0=; b=
	Y0YGG8nyNbhnAq4IaDbsFJA0fEIrTLmzmjZBdZnY5TuF03uVlfkf9++Kpy52cpP8
	TUZNLP0zPI2DSc9qkfcHWYo/oRHN68jR+hNGBh4376UF6ulJClhi4vYAQ0UFgaXI
	UdMy7ru5WmRWCJMO6hYBPaNjyoQCguXcK5+ni1DpeTy7Y12Pmu0esGS0x7xCy07I
	CLvgmL431fxZiZGG/80STw97J+NGeRfK/NGHHQVzzkdnQNjOz07hjbfrl0I1udKd
	gf8KN4yQ7qQYfGK+OWebjyrFWITcNlx5wvWXa8t+4HoaZY0DDc4wMMKSFN9xa+Ot
	GXYzhbdiKvFY/LvBC7ikeg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn3ddk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 16:58:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AGERiS009778;
	Mon, 10 Feb 2025 16:58:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqdwpqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 16:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kykb1BBN7wML8Dd050TFywi5RSgTxScXY2TG1EaJFb0zv7GnXy+Mg9+TLpKvZt/66MuhccKcJkU0Oma+va0gW+hFZXypi9xqXM5b7dZRvkmSwE8UTv7tGR3lcbB4FISx+5ppKf4Z69sUchnepwmbcNMibBiaM1dmVG8HZQfJCRU9Qmqxz10JoGAjEKmzEaYulTn/BxTZaYd71cq1ZvWeAhOiZtdMZTRYrxZPoE5xD2kPYr3kVLMuSm+NszQLJRby0T3cSdsnYIq0sWk/CpUAK5UZhd4UGtWsibWizCMexQTKcDHUUMbcnj9ZcbjlNg7INmnGqep9vowyVdZpi7McwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml1ZzCzbjMoY3bP7Ema/Pd+EC9Flur6ZW0PKdAPaRv0=;
 b=uJ8XDQdqVhyUVrT+QkaWpx3i+qflg5jY6DukrFKjtnOzT+dOcvll2BOrMFDeWNn7TPtmVKWMuF2H8PzHYqfCcANaPbiU83jw+raaORCB/rRfog7Zql3t3G/xLzsUlQ83rZ6oFmR6rlQbGeHAfDZtLAPxKlZ51L/IyY2mQ8t8g+brBWfFCLFYOP3YMolDoa5FRSZV+jVFbkeiSD5M8qCrQc7IQB6qWwoPxR0UJrAk7zvfVjI82awMCHD31pm9QabaRQft8vuSUqTWGSli6cSKlKCQSyXDZEvMCH7gO3nBgWPILU7IAOxoH1rkRNUM8/C5vyrJlc2IZoknq6rFMzYj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml1ZzCzbjMoY3bP7Ema/Pd+EC9Flur6ZW0PKdAPaRv0=;
 b=bo7scSHRW8lWcjZlh7wBhY8GsE3Y4q3ihvARXmkKPhltJnxXSe4QXqutH+qOWxma/JHPV62i3ve6O0ZfJ+1LeE+yp4h9SM15+k/3mKxCfBhWRnqDXdyVrJNf4KWim4VpS3kDEMvjr0YWuEhA9nmmPEJwH/PPCnxnTklDSOdx2Ow=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4238.namprd10.prod.outlook.com (2603:10b6:208:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:58:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:58:09 +0000
Message-ID: <80c1c334-ac68-4cf8-ab42-a93d9c8974a3@oracle.com>
Date: Mon, 10 Feb 2025 16:54:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Reformat a too long line.
To: Domenico Andreoli <domenico.andreoli@linux.com>, dwarves@vger.kernel.org
References: <Z54u8vZh5tJBzv2V@localhost>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z54u8vZh5tJBzv2V@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 53558d63-3840-41a5-cfb1-08dd49f418ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnB2TnlSRGt5WW9lcDRzdS9FYXFxL05wQTRnd1UrTHhicnozTFlINkZKZStC?=
 =?utf-8?B?cWRXTm0xQ0hIQ1J6TDYvZjI2Z1FVb0tYd0VTdEo1RzduMElhM2JUVWRyZ3k2?=
 =?utf-8?B?ZzVHckM4ZFpNR0tiaEs0aUNCc1lYUHVVQWp6MENwTURianladFVWRW1aaVEz?=
 =?utf-8?B?OFIyKzBhdzVHTGdVd2UwcmJxVi9qRFZycnRiaDRPV3BXczlhcEZjVCtvRkV4?=
 =?utf-8?B?bUp0azNhd2VEVU1UejcxSElCWGg4T3JIYmhHZW51d3poL09oaUtickVtcENZ?=
 =?utf-8?B?WXJWSFRsWnlycUx4aTJmS0o3WGREU2FZNElpK284aHM4N2NxNjMvcXErV1Nk?=
 =?utf-8?B?K0dvN1dpTjZoa2h1a3dKMVZmY2xJWmsyNlR2V1gvR050UzRvMXU3eG9QblZ4?=
 =?utf-8?B?VDQ4RmxCai9wbkdnbVhOTEp4czI4dnRUclpFVVF6ZmxDZkQvbmxCZGlqTUZw?=
 =?utf-8?B?RlRSMFIvd09sbUJDaFVIVFZvUVVjNndvaG1lcjhzNEM2TnQxbEUyeDZwQVF3?=
 =?utf-8?B?czVCOFBHN2VadlF2M096blVnOU9FUlFJK3k2Z2Z2NXFVSDdhSW1PbnczUmN1?=
 =?utf-8?B?SVdoeGNZM0xBVzZpUXJwd0VXNGhsTFFDY2l0eVFub3hOZ2YwRzErL1pZV29C?=
 =?utf-8?B?S1hYdkJNSU5CUndYOFpnOUVJeGFHaFByY1VYR0VwcWpwQ0U1VUJTS0ZRWEdr?=
 =?utf-8?B?SEcyNkZnZHpRekQxdFNtakRWU0JHeWU5QmxiWENyMUtLTWJtSlQzSVVqUXl4?=
 =?utf-8?B?aDhnUDhxTkNsNzBOVmE5ZENhR1dlU1V3ZjZlSEZMdTJQSUVheFkzVVdIcHRw?=
 =?utf-8?B?Q2FnOEdoNGFROVdIdUhLeU9qanVodUJEK1UvU3J0Y3VVK0F0NExwSXZ0NndQ?=
 =?utf-8?B?VjlvUmlFbWZjNE43WkhlSlBTbnJJSkF3SHdWYmtoeGxPQ0c3ZG1qSk5BNGNP?=
 =?utf-8?B?YjF1YVZrMFBZRnZITjNmYTUrbmJNSk5DVlJvZUtCUmNiSFNJVmR0alNZdERt?=
 =?utf-8?B?K0hRR2FiV3lyZzN4Q0dmOFpqdjZYbGsxdEF2cHhHUmxSNnEwZnZQT1ovV3RF?=
 =?utf-8?B?YzA0NEh5cTlzRlJMVDZ2MHZHS1ZFcURWcTRJdUJ4azhXZllNbmxHcjZLcDNP?=
 =?utf-8?B?S205TUNrd0kza2xFSHgxSVU4aU1ZL290R1QxRngzbUg3YjlFWUhaWDlGNThI?=
 =?utf-8?B?dlgrWmUrbUo5a2JjYldXVHJoc0RqRXFYVkpodktTd1VSWFduMHhMSGUwK2Nz?=
 =?utf-8?B?ZHBLNlpuOHJNZXo4MWRQVmFjZXc3cmt0dXlhZ2N4b2UyeFhqdjZEcXFFSzBm?=
 =?utf-8?B?NWUrWGkwUjFXRkxqVlVkVDRJclF0cjlWd1c3V1BzU0l5VmdOUmVuYXNmd3dw?=
 =?utf-8?B?UEd6Z2FxbzVLQXZ0VEtWYXAyaktnY0Q4QjVMSjQxUzJNR1pxbHh5eTBma29y?=
 =?utf-8?B?d1BjSVp5cXgrZFdzeXRyUmlNMHhXa043UEtMUHNmTkM1U25GNnVUL3BBampG?=
 =?utf-8?B?aVNkTWpoRk1CNlRvSFV3VHdDSHd0b2lieno5ZWpHZkJqZUVpV2pFbC92SFJQ?=
 =?utf-8?B?QW4zRzhEWUZwQ1AybWE4LzJwRWs1aDZxcjhWQS9iR2IrcTdYYkhqaTlqc2xF?=
 =?utf-8?B?ajN3d2swdW92em5nbmN3Tjh0T1p1UHF6WUNpTEd2V2VzZU9mMGtQNURYWjB2?=
 =?utf-8?B?YVlGNHBaeHhOR2t4Tkx3a09JZFByQkFDVU45TEcyQWZReDc5T1REbCtCaVlQ?=
 =?utf-8?B?a0hKSkxPczIrMFVFUi9LTGNXUnBOeW9pV3QzSWVpbmg1bi83NVNIanVYWklx?=
 =?utf-8?B?dldOKzcvR1FFblhhb0dQVk5oaUJjZ3lFUG1UT213eFduUkhkRUFyUUtNbzc3?=
 =?utf-8?Q?oIoH67pUIzGjk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEkrSlpLOVVnaHI0KzU3NGk5OEd1clQ0SXdncGRmVGtEc3hORXh1QXBrbVRU?=
 =?utf-8?B?dWV0Nzl1TE9mM1AwZTF3OHZOL3lYWS9rTWVLb1BDMDd2WW15cXBoS3NRd0R3?=
 =?utf-8?B?Qk9OU2NscGhlMHpkeDN2SkpUUjl3a3k2Z1lSeU5wcWU5NDBSb0FaVmtuZlEz?=
 =?utf-8?B?Um92TFBzNW5wMVdEdlFSQ0pqYmlqZDd6bzhkTmRPdWkwYi9qS1JiVnlpNGxQ?=
 =?utf-8?B?L1dtdldHODZMaWV2RzdnWlhPNXpVMUIvQ005REx4REhzeWVodUZNcFpVd2Vr?=
 =?utf-8?B?ZnF4enltRWVsd1RQc0JIWXNFVlJWZzRBR2R6MTljdjhGVXJ0dm1qazNWZFB2?=
 =?utf-8?B?R1RiQnUzNzg0aXVUTGtERmpiejZFWGVJdC94aWhiM2FGcEl6My9GQnlaVjM5?=
 =?utf-8?B?aWVXUHZnOUlZOTIzbHloL3JQUk1qOHozSXNuTzBta0pTTDczNnh3eDlqdlNq?=
 =?utf-8?B?aGVJTWJNZG16TWJQMitlUnRYOEVGZmtkaUYxM3Vud0VJbHZDRWxhT1FUekpG?=
 =?utf-8?B?VFNTRDJxTklIVHNvcXExS1M2c1E2NEVjN0pyZGZWSFNRcDlpRy9NbFZOWVE0?=
 =?utf-8?B?dS9HNTJPL2t6NTRNck9UWFBBUDZjS1NYcGdBUm9yRXMrK1V5dmRMVmxuRHV6?=
 =?utf-8?B?eXNyeEkrUXpoNjlpSGxZSzd3Nm1meVNFRkdOQW4wZnZlUGd0aklCa3hTdHpE?=
 =?utf-8?B?RzJEUytTNjA0MFNOS3ZFZmlFdHUvZUNiQSt2RGFoNzc4MmZOWmtQUUVITmRh?=
 =?utf-8?B?clBIaisyMHRLN1BKOE5XZi8xZWtpdWF3OUlvT0lYZWlDRGNNR0todFZRcHhM?=
 =?utf-8?B?TDQxR2NxQkg0L0ZiVVMyZThFeDlEekZaa25QcS9QZTFLVVJxTm00SHRGaEth?=
 =?utf-8?B?V1V4ZDVad3pJSGVYRm01RUZ5ZlRPcEd2U1ozbEpzWXF3bHBWWTlEcGdqYkVu?=
 =?utf-8?B?VW96Wk0zOW5tZjZydjhKb2poOXg2K21nZ2pYd2EyQ0xzQWxKVzFIbFpCajFU?=
 =?utf-8?B?eU5QWkF3eld0dGVYSE5VekJQSk9NeHltNS85c3Z1SXF1SnVtNmx1YlBhWmQ3?=
 =?utf-8?B?TTdSaVRhWUZYWGR6STZhT0xrL1hndTJ5SDhCV3JGa1RNSkhNT1hEMTdnNkFI?=
 =?utf-8?B?bXJkODhGSXBYaHhYc2xmbmljNithYzZQWVFRMUU5cWt4dFpYMTh2d2J3MXQ4?=
 =?utf-8?B?cXZTelVUS0RzTCtRbGlDcHNFOU41TUdHSm9BOU1kQVByUlcyd3VyOFk5ZW5K?=
 =?utf-8?B?dFJvYUJLSHlRWUNzMXBJZ0RJMnhicExrU29Od2xKODVkVUJzc056MkxvRGxE?=
 =?utf-8?B?Zm45K0pzZUk4VEdkS1o1OG9vTjhjOExRUEtub0QreDVEUFI5WTlDREIycTNn?=
 =?utf-8?B?VThwc3RUZjY3dDdxNDVFa3YzZWhJMisrdWhwdXozT202UVp2Q21CZFRkc3VS?=
 =?utf-8?B?YThMK0l4NUcrUm5LRkMwYitqNktyTWpjWjZJU0RkY2piZk95OWJwckFVaXhK?=
 =?utf-8?B?RUhEV0NLQnUrZzdXQTJVSGZHSTZPOE1Rb1o3OTViajJJS3UwSHdpNGpua2Mv?=
 =?utf-8?B?emJjQ0dtNWQ0S2dMVFNaQmdWVER1cTRSR2RDY3hmSEJRMHcyZG9MRDgzWHM0?=
 =?utf-8?B?eVZqZlZJRXA0R0Y1aVVhRzBGTG0rMDZBQkswRnJDL2hkWDMycVkwOEpIYjIv?=
 =?utf-8?B?Mkh5alZ2UFFqMTl3c0QrN3dSeGZnUGp3Z3lJZjhYd2JSYWpzUzdsQWc3c1NX?=
 =?utf-8?B?Um85SVE1UU9ZMHZ6TXpSL3RYUmVaTkltL3h1bkU3MXhGSE9vWEY2RHZRT1hk?=
 =?utf-8?B?TzZCelNYcVR3QnZKc0JSNkFlOUdIdG4rZU5WaVRCdThRVDl2NUNObWEra2RK?=
 =?utf-8?B?WnFnelEySTc5QURSdUZjTWtqNVZVYnZiYzlWZitJUFo2bjFETWl0cFlUeUxY?=
 =?utf-8?B?MG1uSUN6OWlBcVZ6QWtjTUxrd1AzaERFUTJ1MlRaSC93dWpwVXlITDg1VWRx?=
 =?utf-8?B?bDZaQWxSRHNmdGhXTnRlTVJ5ZDM4a1hGTDl6aWNON2tpRFpmd0cvdjF6ZS80?=
 =?utf-8?B?d1RMK3QzUVBJcWxISE8veGdjZEpLdmZBTlFJWndYQXA4OGkrcEV2Sm5ieVQ4?=
 =?utf-8?B?c2pUQ0hRLzFvZ2FLbFhHajN0Y09wZ2JNL3RxM09hRldORjNxOUpoTThvYVZM?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2BmCd0BQmzX4m6LEzydpQ251M32CZs23Vg23/hcFm+fatAaGgfZFFDJReJ79MOzlP6B4Jc1dIoOumVGi10zx56BcdJhtmsrJekiyBL2Qmo3KQZSQedgj5WlRlDny1ENIgcu3iqeASyDkvLh8rctbDQZcLp9yI6dWwAKUZ87/9qPxn5dzNsxjTy7jyhp+U5U63lsghGo2v2v3ODN/MdTNewhfCB7UtaLHeOId8UFYSjftxx3F6kUqag8p8fyBQK8ptvHvXh8dIsZYFPV2Lsx83BHZiWej02SBIE/FH2uCxYT/yD5pq/NAPdGgLslTH190+OpgAoRmpJHAUXfDneKykYcsE2a2Tl+OF6RIuRT7jhTdUWnfNkMsLEpezvAxWS3Q7a89r4hue1rriCq6sPoqb0lJGLjNHgeksPo9uLYCOY0uto41gd5aWenVmBlf8sv8PQNwTkqaS3gPmEaSPnXV0Mf5xCM7UGNT5Bf7Ry3m3NPtmVDrr5mqdsOFNNsYoC/SdnmgXPFgTQrXZYumOhT6G+H+jgayc3bm1fHJT68Imu/612K+fUus6hRptfTCbmk0266VQVVBCnhGgWvHuRn4EH5206Dmnol8tA4tDNYm0Y8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53558d63-3840-41a5-cfb1-08dd49f418ae
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:58:09.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ruo4vBsvp7UnYvf9ra8OU2B//t8pKk7KdPdwj/IiZf6KwP9w0v8ScVgNhP0EEvtbYJm7c9qC+30SOtjbBjB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_09,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100139
X-Proofpoint-GUID: 0FihPw7jCdX9s5GNMcRDoUwu-iKdOfvX
X-Proofpoint-ORIG-GUID: 0FihPw7jCdX9s5GNMcRDoUwu-iKdOfvX

On 01/02/2025 14:25, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Reformat a too long line.
> 
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

not sure this patch is needed; man will reformat the line for terminal
display, right?

> 
> ---
>  man-pages/pahole.1 |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Index: b/man-pages/pahole.1
> ===================================================================
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -304,7 +304,12 @@ Allow using all the BTF features support
>  
>  .TP
>  .B \-\-btf_features=FEATURE_LIST
> -Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to using multiple BTF-related options, and 'default' represents the standard set of BTF features that are in use for kernel BTF generation, so is useful as a shortcut for testing the latest set of standard features.  However kernel builds will call out specific features rather than using 'default' to ensure that the desired features are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
> +Encode BTF using the specified feature list, or specify 'default' for all standard features
> +supported.  This option can be used as an alternative to using multiple BTF-related options,
> +and 'default' represents the standard set of BTF features that are in use for kernel BTF generation,
> +so is useful as a shortcut for testing the latest set of standard features.  However kernel builds
> +will call out specific features rather than using 'default' to ensure that the desired features
> +are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
>  
>  .nf
>  	encode_force       Ignore invalid symbols when encoding BTF; for example

