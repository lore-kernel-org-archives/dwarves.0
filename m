Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F11F03EB
	for <dwarves@vger.kernel.org>; Wed, 12 Mar 2025 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798328; cv=fail; b=kpaMO9LZtPPivHtukQeLGG4lECxh/AuIoqLENrOzkiUAI9YNfn54Wrqp1X+zhpE8GUmBxKxQsFPrr+IN7FuzVDcWvnEp3gVZBo+mVUNlX/mX/Rvgbk5s8CEsof0f6q7jLWkJzlAVwQCuO1t5FADXCjZ1JT5pmqjZFxHNxl5Ved4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798328; c=relaxed/simple;
	bh=36ocelwnz2heOnmN9nWORsh4GBc67PR/k08DRB8sNrw=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5tINXIGC0+Nye6JCkFDIqtodU2z2xpCZVRX1+SIVRZkk49NSkQXBNaab9nDz7mZre0lx4Pl6E1RdjjRzAcHbT68zceqTI/+BUsp6XRNLbHhjuwk21S7VAuuy6IPU+RoQV2kNoscrdFEnA/ea0HXWGT9l/mlOUUcJa8p3/0Rvoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=As4mq8zO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MokWa7rm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="As4mq8zO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MokWa7rm"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CBoa2h024759;
	Wed, 12 Mar 2025 16:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/XeJgZo+Iib6jMYI8UxY11QZ6ubbRzTgZ1OL+RO2y6E=; b=
	As4mq8zObCyV7Y0YuPmbZMqwtz3IaOKCwPd57GPAF1jtJMf5Az1aJnZ7ZFJoJ20a
	OVHpK7b5Fr+g4ic9W+qh3cjEjiWbJykVt0jGoJDVukI5zzwOiZMtMm2rysM49KUB
	5QFTjZ1kD8k6vAT+VZ2tZhwpgaEjPPUFcsw/4YhJwujxBVp4ubKev7XTEJMLNv4o
	w6PdZlqLX8z8xu5BHu4I34zsakYQSPXLnsfDamb4/pmVPHfVUc2nq5rkJwbHvYIi
	R7zHDAI+WERAKeHKnfRUEMl10I9lKdh6z9UZOlKX08x5CIH9+W5ZGn/m6WivJNlO
	fIsmTLlB2tErHW6DvOoJaA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dt97c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:52:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CGWbPx022301;
	Wed, 12 Mar 2025 16:52:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atmvgq31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:52:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBZKpV0fqy4h/6rp4Ge1xswk1Qid0hwXLFsZPfXdQZHOhTx5BfDdK6WqLBcR2JHp5ZBSmhBMhnTjP6iO67gDgnxu0+1vpXaU0yseudIMbK6+yvvsDr1F5RMOxDdIiUzf3EaPrJN10/UgI2D9tNe6760JBHllJ2G6R7KCYy1YRfAm0zle9Uc147EooPfrlFcdijO60t8crKZejJ3S/AmRJwdpHIugtLB8GIaeRFAMVVd3TKd1Ax0xxvg57O5DkAfrZVKN3VTJ2vDfqD8ev1bn0VgIsshYH9RCSXDNwHP9GpKhpKPlzknC08DO0mebF9oPv6T5NBUVeXAUFOTnfb+uoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XeJgZo+Iib6jMYI8UxY11QZ6ubbRzTgZ1OL+RO2y6E=;
 b=uHJi+Vb7+az9E1mioFXLmoT03uOzVAOx8fB4SyXdT01ttE6DOQBWrrfPJzxmhjVIHNljbGVoZ60JrEu8djSa3HXJtRQ9FvyHs8EJDOGoYKAOhDzpaFxsWer5nsmrl4teN2SDgn9Z1ZH+fgSHLnJLxKREeJY/z6vQHJl0IA5NGu2cH1Ti3t/wDVqBfvSqfvzmZdlR/mbQek6DhqUWcHpdC31fzd31eyPMJYNs6LuXvDNGMDX9BBtFpUaOv8qV0g+TWtFaaP0lNnAZPyIAomBBQpDZ1eCpAUGWY4DaPaEFwULr46/KHz1lk5GmMsK2Mch7pwuDbRb8lBxV1oAr821c/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XeJgZo+Iib6jMYI8UxY11QZ6ubbRzTgZ1OL+RO2y6E=;
 b=MokWa7rmgbdXnf+DGva6TxLjZ4HpXUSMLrI1Q/eGuqYVg2CuA53nDCGHCwG84N0ig48W14eVCYdm/Gj3RwD1pBmq3j179cE8eyPsrmMI5c37a7CcBNjK3uwJvEtSdifuIC8NTgxnmgZVMLXHDc35kIKJjnoZnTv0if5qPoDj+/M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 16:52:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:52:01 +0000
Message-ID: <15c4f7e7-c5b3-4374-8e52-bc17113cac43@oracle.com>
Date: Wed, 12 Mar 2025 16:51:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix spelling error.
From: Alan Maguire <alan.maguire@oracle.com>
To: Domenico Andreoli <domenico.andreoli@linux.com>, dwarves@vger.kernel.org
References: <Z54uxjn-wDXi9LGq@localhost>
 <ee05d33e-044d-4652-b6a3-06f830fa287e@oracle.com>
Content-Language: en-GB
In-Reply-To: <ee05d33e-044d-4652-b6a3-06f830fa287e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 394925ad-c368-47c3-c4e1-08dd618635a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGtMU1VyR0VuaDQraXVpUTlrUzg1WjZqZTVLRFhMb1NtcGREeFArV3cyRmhM?=
 =?utf-8?B?SGRtOWRoWHhGMmpQRWsrSlpDcFZwdkNXUUxOMGU0ZjFzMmQ3NEVVdENKcldH?=
 =?utf-8?B?VUJDbXZEemttSE14c0luZ1RwYnNUaFdTY2pXc0VRVSszNVQzc21wbGhIcDJH?=
 =?utf-8?B?Wkp0bk1xUDh1WFNnQzFNcTg4TkVpOGhSNHVOSWFtdWF1VFhra2dLUHBENmN0?=
 =?utf-8?B?R3hMenA4Z2ZGd2lwOFdLL056SGtsQXdHRHhpaFJEUmNiNEN3ckdDR0gva3Bt?=
 =?utf-8?B?WkxoRXVYTjE4akN4S2ZEMFhYRjMveU5pek1YWnlNRkVtMzFuREx5SUFDR3ZV?=
 =?utf-8?B?OXBYWFJGaFRGRUFmMENVZ280M0ZQVGdiWVJRaFZ6ZGNPZW5Oam5rK05DL25P?=
 =?utf-8?B?RDBNcGtJajJ3S0lNeGFOeHBhOFczTUtNY2VoWmhPTmlhYnRUczVCa1ljSS9V?=
 =?utf-8?B?emJVYlYyVWxGYVF3eFVHekd5UnBYayt2Um12c1JLaVNpWUVqRjFNWlpQTFZG?=
 =?utf-8?B?VlRiakhpNGJiYkpiekFJeTJkd1BtNi95RWp4bWsxOC9YQ0hqZU5GQ2ZlYi96?=
 =?utf-8?B?V013WHQ2bGhpNDVNamk4bEZ0aTR6TkR0OWhrZGNZaElqWnhGNmNhUElWWGRC?=
 =?utf-8?B?MWFObWkyQlgxR3FOK200WUtlNVdTeFFrVVB1UkRGUzloMXRDd2ErUnh6dHZ2?=
 =?utf-8?B?a1lNMTRyUnlvRTlVL2V1MUt0dFJQRGtKdEZWQmk4QnJ2emxiQURsM1p0ZnQ3?=
 =?utf-8?B?bzU2ZTd0eVo5MDhPZzI5VUxmOW1RdmdrYWJWNkpIQjZaUUR3QytjbCthRlBo?=
 =?utf-8?B?aXI1YUNrUDQzc1lKa3B4bDRUeHJhY1hmYlFSOSswaFFzMUFSb3Nvb0xQbVVi?=
 =?utf-8?B?MmY2TGZSL0lBT21HVytyTTEyV1czNzdwM1ZsVjdTSTl5Tm92UmpKazRNY25W?=
 =?utf-8?B?Uzdub2Q2WW9xNXJjWTdMYWRJNE5xdTRidURwbFdjNDlHMThsTVpmOGFKbHNS?=
 =?utf-8?B?ZG4xZm9MQ0IrdTRoNGhTN0c1dldkS2Y5d3Q3T2Rpd2l4NCtjS3N5NVhIZXhC?=
 =?utf-8?B?UC80WTR4RFdHZmpWUnpiOUY4T2MzeEpTbVgvT1NuaVd2dE1Ud3ljNnlIOVFN?=
 =?utf-8?B?WlBGK1RuOHlyY2duT1ZhQUxESUEwZG5YVlZrRVdDZnRZMkZPb29HWXR3RWdV?=
 =?utf-8?B?ZWw1Y0s1SHNVUm5ndHRzODJycnNsemlySUgxQmlKNzh2cE4wYy9BSjIxWHJk?=
 =?utf-8?B?MUJkaEEwd2o5bEk3Q2JjTXdNbk9uTmdZNzMyRHpOTFA5RVlvQXRSZEtLMW1B?=
 =?utf-8?B?YThrSWhxclcxR2VSY3VnRUszSTg4MFI2djRJNVhFMXRqM01NWFUxOGlKcE9E?=
 =?utf-8?B?WEcvSGpkb2x0MkU4eTRqYmlOanhmSDRqQjdkNDY4VkE2cFRvd09kT29UMG5Z?=
 =?utf-8?B?djYyLzFiN0h2aXVVT3NOMlhJM3NkbGIyWnROdHpKRDFPdFpQeFJ4cXVsWkEr?=
 =?utf-8?B?N29INUNaU1F2Qk13Rm94TFdsUGs2eVA3MGxTMFpwZFlQdGVrVGFSWVdWQXd6?=
 =?utf-8?B?RXRnRnR4b0ZjbHI1Nis5TVhMQ3F4eXY4Qms4RnhQL3dVQ3VaRTJ1REZkcFhi?=
 =?utf-8?B?YVh6QkFLZzkrRHU2bXhVTjBpajdUZXg2SG9iT3NYNUp3ZHUzWnlNTUtkOEZB?=
 =?utf-8?B?alBibFhSMjlIRHM5UHdZNUhtZmlkMEV1R1l1azhHeGFhZGI0K0dHdFNQZmFv?=
 =?utf-8?B?ZXJGSHlMYXFtRktMbkZaSVdSelNGYVpobDU0dXFzWnJHU0hwaDZQR0ZyMHZR?=
 =?utf-8?B?UjRBY0VTTUQ5cUJva0dwWEZFVjAxOXVJeEpKK2JoRzNLS0pMMjVNWVB3a0Fn?=
 =?utf-8?Q?zn9YDJX4dVyRn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1Yyc2I0aEs3c0FrQkhHWlVpNEhLSGVSMzJDL3pWZzd0OXVNVDNpaGxOM1Qv?=
 =?utf-8?B?bjNMRVFwdWJpMXpWczRKOEtCNGdEa1lrb2QzS2tSZXE5UUI3L0pEcFlBNlJk?=
 =?utf-8?B?SzBvN0gxbFNkWVJtUlhxREJEdlJVRTFIeURQazRTcDhlaENMVy82RFo4YWhu?=
 =?utf-8?B?RDM3RlhNQnZKMEFUd05RVHNkRnJLYjdrZTJocWQyb2VlRnJYUGlPQlVVTVFZ?=
 =?utf-8?B?dHRqS245ZlZ6N2x4TzA0VzM4dUlOVlZ2ckFtWVczUTVKNnYxZWFkY203K1hJ?=
 =?utf-8?B?V25WNGxJTU5FUi9CUXUzUmtIYUhzY3RVUVhDeFJIZ3l2N1dqbW4vSzltcTJX?=
 =?utf-8?B?VVZub2RpT09naHI4RHRqeUh5bVQzeFhSa0JwMTl4dDd6L29uU25wVlVMdzRX?=
 =?utf-8?B?RDRvM1NmRURtR2xHOUdVd2ttZnlwNjNubWNOV3VjeW1waSt5RFF4dVVVbi9Z?=
 =?utf-8?B?K1hKcVNRNUh5cUN1K2FicjM2WGZBR0l5ZXBtRzNtYU4ydGVPaGlOaExvckF4?=
 =?utf-8?B?Y0pHemFjRGFLNm5qRnB0TXp3d0VoOXJWcjlONFNoRGcwbmNVWVcxcFIzdFNn?=
 =?utf-8?B?S2k3OU9EdHJPMXFjcTJ1dHRoVWZZTGhuMnlpTkxWQU93OTBiWStkNHZ3T2o4?=
 =?utf-8?B?cEdqQkM1M3F1M3dhZU5aUExFUTFuaWxrV3QzUVplaWplQmpDbEFLN0FCY2NB?=
 =?utf-8?B?bjl1ejhVRHhDNTdEWTg4bzZmM0ExSU1tS3ZIc0g3cmRSdDRnSDROUjVpTjA4?=
 =?utf-8?B?MTFKWjJkc3dmU1A3YjVSSXY0OHUyTWJiUkFnWWdxbEtCVWpTMHFkWUFnOTBu?=
 =?utf-8?B?a3YrYWZzTG0zdGhUQmpPTDNWTFVFOThjcDR4NGdvbGFBaFVpMWpJSkl5bXVs?=
 =?utf-8?B?Y1Vyam5TVjhqZXg2T1dHUW1kRTRjK0dkQitZQi8xS2ZQNzFxcmFjcGlwRFdo?=
 =?utf-8?B?elVqMjNnVVJwMFVmSDlBSzd0NTR2bytKWHIzRHUrYXdtS25iNmlCRjRyYS85?=
 =?utf-8?B?TGY3RklmZVZWRHlqZmw4RkpIQkpubXJTbzMrd0hlY0ZLdWVzTGNMZ1U0cm9B?=
 =?utf-8?B?eWVvSlM2VmRWbTVrTjJUS290RjRIbGhiTFAwaFh1dExqTHB0U0JEQjNiOUlD?=
 =?utf-8?B?TExEa3JNaWhKcWNVRVo4cjFyTFJHam1PQmpGamNCS1E3RmM1S1RHNlY4ZWxD?=
 =?utf-8?B?MWFBZGRjYnliRVlFUTBIQ2FmZWd2MUU5UXhpSWtXNUUxczdOelpBVi9lMW5Q?=
 =?utf-8?B?TVNlelVINXVoRkg4RHE1WEJ6elFrYXZpQVF1T1VmMlE0a0JoeGtYczZNNTVG?=
 =?utf-8?B?ZzVLRGNjZWg5TEI0VzZqdC9wSUkzRGlxSSs3cElHaU5HeG5xbmdiUHRWMHZF?=
 =?utf-8?B?NlVqY3pyaHI1VHJSU2V2cUhHcnIvOU9lQmxlWXRiYjRnUmM0Uk5BWXpHVGlM?=
 =?utf-8?B?T1MrNmRoNjJ2a1d5WnJVVHByLzFvQkVDOTBKUk9oNWhudUt4UnBuU0YvUGM2?=
 =?utf-8?B?N1JCM1lpb3FMYkdsV2k5QU5uUWc2aktTbVlnM3M4NmUzK0dBRTJZMUJyL3Nv?=
 =?utf-8?B?eFBkRVdvdERiMm5VaXVmNzNoNGlwSDJZampRYjR3Y1hGdTNxb1NROEZGVVZV?=
 =?utf-8?B?WXRvQ1VpeGJGZm5LdHMrcDdPTmJ6elF2cHp3SFc3K2JRclJoaVQzT0ZIbzhy?=
 =?utf-8?B?dTYwTmI4MXFudUNNOGJjTDN6bG5sUzYycW9BTURES3RRSHJZYkNrdVBuVmor?=
 =?utf-8?B?Z2VTV2VTQW1XanAwdEpnRkhiYTF1TTd4NXBKWWpHZmtmT3gzZEtKZjRXK2hl?=
 =?utf-8?B?NkU2OW10ZUdLMmNOOVlkWFI4NEQ2bHVoOGc1TG51ZXVYcW95TFovZ1U4cktx?=
 =?utf-8?B?Ry9YUVl5MUVKbjBjZmw5ZE5KU0hOMG4ybFhNT2lwdjJGa05lb1VWYXJxOUhw?=
 =?utf-8?B?d2RlU2UzR21HQi9lSVlabEFCZGFYbnZOV3ZFdzNaR0NCUitIZ2ZqeDNGaGVS?=
 =?utf-8?B?blpKSUJSS29iR3BPaloyTUVRTU5wbXVPOEx0V21vNWxCaUliK0tTM1VmTmZO?=
 =?utf-8?B?UkVCbWFBWGN2ZGR1MHJ6dGQxclhEdUVWTGZJS20vazVoRS9UU2lMbDJGNUZJ?=
 =?utf-8?B?ZWlPMHdPa0xKZ291NXh5UG04RDQvZmhjQklDdlAyT3pVaGFKeHlhMEtuL2lj?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hZAocHpVi4ROzVg4q/W6TZfp8h/LCX3NkBapnZ5PX8xJw570rpru+dOzbW4oSW3cn4CJb1xDdbKb+oH09ZFZR9E5xO3xmP6EUauO8jX/pdir6JzrXOHYDoEJJYB+wHrv05KeIjocnq1xj4c9o2jJaZse8OJc5W3XyZKVykDFRA6VU/X5w5AJFaV2jVAfudV/1Sb1FmUng92pjx+A5mtbYv00YgVqktNo0Z/amLtFTjquoahQaMWka6+8ktqObZs1qNa4YGBTmJfJ6SMjfSa/pE/n6AQQjIJoAOaHVhf+kUrNd+psfFOetdMNYE0xuWeVoXwDj0zEnqAu8Jn8dXcLl9EaN8vyjeVyGahYfuyt6nQ3b6etj8K8C+ocF/qOLwzfmByaa69aeY7QJJNFF6p0FgfVswDe0UkfdqDKzDxnR4pyC7OB8bUMG7Yw6SMXb4lIj3cA/jzYI1K78p4iq+dbaaWlEv6cMErjFbl7sCo+yqYqbAgH04prJ0SSQBq+udsF4A3N+oqdPt1lGleXKpACAjbEO4upfQ4Ojvz36HTfbzA+P3owEqRqlml5KjXiVb6yXpKm7mCc8c1DAwFcnFBJ9q/izkx3PalhV5oo1UBpors=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394925ad-c368-47c3-c4e1-08dd618635a4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 16:52:01.2399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHrF6ax0VySq1nyIXoVBglNqss6F3D9eNbsSqWy4SWBXrrsUr8lnKD3o16LO4LlFtvjgjzw+54e0aWCpA9z8VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503120115
X-Proofpoint-GUID: EMBAg9-p5KK9NvDuoRwkkiTLEPHR6ehP
X-Proofpoint-ORIG-GUID: EMBAg9-p5KK9NvDuoRwkkiTLEPHR6ehP

On 10/02/2025 16:53, Alan Maguire wrote:
> On 01/02/2025 14:25, Domenico Andreoli wrote:
>> From: Domenico Andreoli <domenico.andreoli@linux.com>
>>
>> Fix spelling error.
>>
>> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
>>
> 
> looks good to me,
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>

applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

thanks!

> 
>> ---
>>  pahole.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: b/pahole.c
>> ===================================================================
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1436,7 +1436,7 @@ static const struct argp_option pahole__
>>  	{
>>  		.name = "with_embedded_flexible_array",
>>  		.key  = ARGP_with_embedded_flexible_array,
>> -		.doc  = "show only structs with an embedded flexible array (contaning a struct that has a flexible array)",
>> +		.doc  = "show only structs with an embedded flexible array (containing a struct that has a flexible array)",
>>  	},
>>  	{
>>  		.name = "expand_types",
>>
> 
> 

