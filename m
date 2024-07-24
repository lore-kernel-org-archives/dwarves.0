Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA81C2AD
	for <dwarves@vger.kernel.org>; Wed, 24 Jul 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815524; cv=fail; b=Mu1cwBrFwOcW3bXFDM1DlQQx6SmtjXcpcr9nQ7g+KLcSIh9TxWugYEU2cDUI61IKDmOsiogx0q+6eri2ezAF2sqX+m4HVfEph9QFDIPN0mLZpkmiYhgHqinL+h025kFxMhCJ8XMnIi7vX/nORclXdwxAL3ZB2asVBQO7IWL8ies=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815524; c=relaxed/simple;
	bh=IE0Mbl30G9huRnMlu/uEWxjpzmCKNoEtzbxHTyC7nfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V7+aww34Gknh5bEZgv/4s/1ZH4cGK5nO28mYjVHhg0MJ7bcwkdINUAv57R3BvoY3Q0XPWNXAyD7XnlpcdBvLb7PKLiPEamrLXZNI86ux2kmH2ue+CdyBd58EZ/ESoHD7Wp5Tv2C3dfwoUPIUWyxh0p2p6DsgN+a3QvUTNW+yURM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ozKKuXtU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zmoYvWJI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ozKKuXtU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zmoYvWJI"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O5obBY022227;
	Wed, 24 Jul 2024 10:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=nDl3DySUaqGhgSILRvxdeIEXVJv3QKEiHD393BQzTws=; b=
	ozKKuXtUoxW+HteISXi9a6k+0ryNBDumrcJSqDBKtr8R1Or9uNlBiRy+6DKGH5E9
	q03x6fo74NfzCI/NviqCiyWLO44BfaERW0tddyF5nlINjA2anV/y3BuDcf8mhcYE
	xox9VeGO3iLsmfo2vnt6meNj5oWrwVzXooQRkEICQqU8C5THplVXmvjxUxPyWV70
	SJnFvXvdxSdTKzg2Y7nODd5s8nTBnfUpuXGz64deIJk3GNWo36OfmonNuEbGEagw
	bvIFfMtSXyVeeBvmBNOx03qT0N6F4c4Wn6gmogfr9dm7bpCLOAfa97gyA6S8LTLU
	je0ftpF/APfGcGmlnpvPjQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe7grd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 10:05:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46O9RdXa018834;
	Wed, 24 Jul 2024 10:05:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h280thct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 10:05:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0z3p89HvKYAeuzdN/yVojEAEe9PstqUlwvflnKLPjOk+znQWjk8PZ2PHYxZOFHeTsxGcxQ6tPRaMF+gFQFd0XNmrPmpeJT1MyPIxzgXs2lwzWKZv86zgkny5jWTTTON02Yl/6GZh5lP4envv3w9gGLSYouNORT3P6eNwGDMXdjGfk62nCMOSlHYT/xfVrY2IIYkMo9Y8zDkf0CrAvjcggxyfM8xZRVOafzwabS0oXS1EUHses0KAgkMMhrRGTWP5A12IIrg9SZ/ncjYGRY4j6TNNp9PVGITs1gJb0sD9nOQ9msM2XZNNAimE9pp4rjRcNSfhRcuT44tcbRZeH7cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDl3DySUaqGhgSILRvxdeIEXVJv3QKEiHD393BQzTws=;
 b=LhtAuzaF0eXT+HegGkOxIGYRhINnN6bRyVfCRrO9LOFZveRR5r8rydt4R8kM3IPuOotvr5QRnvrD8YHYjMvo0h16Kj4ArkyTHENoDDNi7ZxX+MJzfzFQDo7uN2tcQx9kvR+NKX3tYWyZwxyapcyzHTFdaTmriz4uzuqhCw2syoT330B5Y/koF70Uyb/2sBUjfC0anCRN+P/rLjGNUi9c+nnoLr3yaUpOZm1jdBulx1Y1hz9qe0Q5nml5UCW8tKlJmDHM/hZ5ga0Pk/40Z5qIV0ZllGxQx2RYhbKRx15iYz/crfuSDCnv7pVSgZZA3O+rOgn+7vBp6iFtIOzBC9S8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDl3DySUaqGhgSILRvxdeIEXVJv3QKEiHD393BQzTws=;
 b=zmoYvWJIcWWo9PyrOiTg21ccCz+oP5aAaCyTiTuydTPN/M7qNmPhb8FHzPrnQU2SkW7Pxq7/FkQUV2uIFp2en4fXMjTpmlLXI+ZKuQB4pAPwXAosX/ohzPvJMWMCnrx7kKLo5BflWKjBTa0kL/MpuN4ZINSNV3wFtPWC/yZdYjs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 10:05:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 10:04:59 +0000
Message-ID: <f91db3d7-743d-4f76-b597-1ec5e3a4efa8@oracle.com>
Date: Wed, 24 Jul 2024 11:04:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Domenico Andreoli <cavok@debian.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
        1076564@bugs.debian.org, dwarves@vger.kernel.org
References: <172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
 <ZpoNZHIYuERg49N1@localhost> <Zpq6vEB3G1UlAeGR@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zpq6vEB3G1UlAeGR@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7cdfbc-3079-43c2-4798-08dcabc813e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V283R29BS0JtS0JvTitZbS9jNWQxRHEyMTVlcGFHTjJWdDhDUXpmYWpLRXox?=
 =?utf-8?B?K1dlNUQzUVJzZk96SmgwcVFKdVl2a01OcmlUYlQwYUt6OE9NemtsWW93N0Ru?=
 =?utf-8?B?VFNMUmpOWHBIZ2NWc0hUc25Ha2ZmTHorZnUyZHV5bk83U05TaEFYL2swRGNk?=
 =?utf-8?B?dTlxbkR5bDhZN1FQNWpZSmcvZ21CaVpHWEs3bmw0WGI2MVNNck5Qc0NlOXBs?=
 =?utf-8?B?SU80NkIvRCtBVERldm5XeFFTaThQbmJrZEx3dGl1ZnVWL2JJU1AxR2RiNFJV?=
 =?utf-8?B?UWJuYWlQd0NDYVAzdUlsVGs2MTlMNmNOaDRMVzNNYzBRWlJ0SGVIV3IraFlJ?=
 =?utf-8?B?UHFBVlJXWGR3dFJrU1hPaHF3Uk5JZFk2c3F1YTh4QWZZekNsYjF2MjRkSk1h?=
 =?utf-8?B?RW9MLzlxYnlUNUd6TXlZelBoRnN1RmRqcTROQmhsYzd4dVZMU3JoS3NFMEhO?=
 =?utf-8?B?UEdieHh0cGhHdXk4MC9vNllDd2ZUVnVKd24zRE9IaXh5NzQ5WkU3TlV4Sk51?=
 =?utf-8?B?Ulg1ZmZERkZPdXY0UTJxUWZ4aTFNM2d1aFRvT3dCdHBpeWxJRVZOanRqWFM0?=
 =?utf-8?B?MmNSK2RTbWowYzJ3QWlNZXpVUjJ5RThrVGtZc3Q0Q3JIdGh3Y3NSRzZxMTJS?=
 =?utf-8?B?S1JHRXZiMko2RlVoSWp0dzhISUlnSW5CK1VhWDRvS3NpelR6SW5iMC90cHRN?=
 =?utf-8?B?am95dTJHbXBESGk0Qk4yVis2K1E2b050SWVLTnRlTWVFWnJNb2VUeHh0YWhF?=
 =?utf-8?B?alBIaS8zbEdoZnY2cGkrOGlGQjFFVlBzUzZCbXZGWWtlQTNpazZSeFcvNm9q?=
 =?utf-8?B?RERHaFVMY2RVT3BnY0lYa2RPUXNGcTFqVnBvcjRjZTkySjlud2FvOFR6dnlW?=
 =?utf-8?B?TkE4dDF4QU9xSjNSQXpycGo0VWFIOTdneFpMMGh5bW1uTXpHZzdGWHJOY093?=
 =?utf-8?B?UUF3TnlFdW5idHdGb3U4VndoZnp5U1hqWC9jWkZjUFlNTXp1eWVDdzQ1b3Y4?=
 =?utf-8?B?cU1ncTBpdFN0a0tXMndRZGs5WkV5Zlc5UXRKdThRN2NrNlU0eVd5Q3ZxRjdZ?=
 =?utf-8?B?VWZ3dTZPMEtXZk1mNW1yRTE0a0VwRmpUeGZCSnhpbVlJbGdnNGFyeGdUSG5O?=
 =?utf-8?B?S1NkOXpoREVsTTZ4bHczU1NhWjFUbisrcnVtcVhldEZOMWIvOUNUV2UyZGFR?=
 =?utf-8?B?TTBtOE9nTW9lVDlpaWFrRGRoY0ErNDdRSkxVKzFGQmFNSGNBWnIxZnRSYWlh?=
 =?utf-8?B?akN5QUhkNWxaUlFLakRrUHJvMVhrUU5tWEErcUhDTVd2THVIS2JROUZ1V1FR?=
 =?utf-8?B?THMxVGdGTVRLNXNmZWFlOG5GWWlOT0RXRzRCMWtvc2FldWxmR1hXVitacENZ?=
 =?utf-8?B?SGtadmVEVnltZzJjMUh6b3RTVmUvWTZXU1JjSzRqNE15UFJrWjBrL2RNMDFj?=
 =?utf-8?B?MS9LNWc5VFRsL2RGR3BTZzZQam1ueWRTOWVWNFlWYkhHZCs4SlRLQmVrSWdI?=
 =?utf-8?B?dDFaaG9HbXZXeGFKelRjQ1ZiTnlmMHFKbkExc2tOM2xjdjJha25Ma0JPcXc5?=
 =?utf-8?B?eGlrNHgxTC9vaUs1dDZzOGt6T2FPQjBxUlpOTlNtbjVKK2NCeGZwMDloS3FB?=
 =?utf-8?B?dlorVFlNSzVDanZOeTIrUUphUFNSRDMzWEovUm5XQnpFKzZjT0pDQll0anQ1?=
 =?utf-8?B?bFlwUFRUSGF0VW1qOXNIQ3o3eTVBVVNlTVpPU3hJSURicm8yUXFvYkJpRDB5?=
 =?utf-8?B?a1pGV3g3WnVYK1JISXRhS0VwVzJWMXNoV2NUMElVZGdlSTRoOXZUL2EzRFk4?=
 =?utf-8?B?T3ljWGxVMWpnWGwxYnBXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGthVGJWeVg5aVRnclVJUVdJNDMzc2VTTWJuVFhmdDh0YldNVWJ5NHZSbkhm?=
 =?utf-8?B?WmJ2ckFlMy9VNExFNll6a1NoSDZLdVFPMWZyMlBLaDVlQXRqNEFVLzlNUG1V?=
 =?utf-8?B?dFFjeWIyWlNDbFVWa1pBNlcwQWY5MFQvei9WTUh5dTlhWElKQmF1bVNwT1Zv?=
 =?utf-8?B?ZHYzbE45TE1TUXpiTHJ3TXVtY0ZzVUh1d2Nia3krRHA5d3ZFM3JDenBVbXFZ?=
 =?utf-8?B?bWlTODNaWk54UElMRFlrQ3ZxMmxIVi9nRCtGVlRKYTdvRkhhazRSMG11RWt6?=
 =?utf-8?B?dEcyUFFRSE9qbXpmTHpDN2Z5TVY3ZnBzR2pJQTB1Wk04cGFEcXJLL2RMQy9Q?=
 =?utf-8?B?N0FtSW10SVBGcy9BL0sxMHRRd1JTalorcUl6WVRpdmtvOVBKc09zaTFUdllC?=
 =?utf-8?B?Y21kWEtxWnpUd3ZMTE9tRytTL1QrWWo4M2tCaDA2RlpGeW5ObXg1SzUzaDVG?=
 =?utf-8?B?MHlBUlh2b1JJUjQxaUZTM1M5cHZoSG1WN3V2b2ZqTFI4ci9QeVhjV2pvUUFx?=
 =?utf-8?B?RythNlllTVVVeWFOdEh6Vk84OHJEYTZiWTRMZlNkWkJkZ3FsU0paSWtNUTE0?=
 =?utf-8?B?OFVZeUlLSnMxMzc2WWw2Z3N6RG1ZdElzZzF0aVhzVURzMEZiUy9OcmdOS1Fu?=
 =?utf-8?B?Q2MwVUZnRGFTZnJRakl3OUhSRFFveDVQdzR3OEZnL1lqSEd1WXljRDdWMEpV?=
 =?utf-8?B?dmJCWUJYMUEzaTBWbW96cWVnTjlkMzRqM1J4b3NzMGNuUEN2QXFsQTdjbHJ0?=
 =?utf-8?B?SEIvdUtlcnFoUEsvTUc3eWJkU01mZFlKdW1KK0dWdTg4UzJ6bE5oMDEvemFI?=
 =?utf-8?B?MVpoSkJ3djA2cUhsekxVdkRnSkVteHVGQXE5TlNXWkFrR29iQ1lxTGY2SEo0?=
 =?utf-8?B?VUFqVGxtb3FHbzdESjg1MTNQc2FUWXhnNFRIdEVIMW1DR05VQ2dBRC9SZ1cz?=
 =?utf-8?B?eUVncVJiZE83TFRyeEYza05MVFoyZVhjeEFFQ2NWMEV3M1p3bVFsQnZOUWNL?=
 =?utf-8?B?TldoY0JyVnI0Y1laQjZnajBDd3R4bVYxWjZyNjhBdmlqblYyOWdPM004VkRJ?=
 =?utf-8?B?d09iWnc5Z1VPTXpuUUNMRHZXU1VnS3kreHB1Mk1vRmRrak5KdHhuMU9kMzdN?=
 =?utf-8?B?OFRSdnhIaVNJRXVEVGR5U0g4amdEVDFrM0lvK0Zqc3RSSGRGNTNHeWRtbnJP?=
 =?utf-8?B?MmZDL0FWTTJUYnFacGFaV0V5TGJzblpiSEFoMm9FVFQ4OGhXcG9EWDkwWnVm?=
 =?utf-8?B?Zklzc1ZzVUExd2hJVHpTcitnMExaZlViSGpHKzBua1p1TXdTN3pZQXBMV1hF?=
 =?utf-8?B?NFB5c2JEajZJNlBibmtLN25HNWR5QTNPeHAxNWlqM0hoVS96UGRibjRqTDVQ?=
 =?utf-8?B?UGF5TmdjS2pjUmhDc3dsOWhnZy9EYUJjZEZDQVlIeTJXS1JnQzBZRFk3aUYv?=
 =?utf-8?B?bWtXV0JWU2t5cWlqNlVCMDJIL1E2RWNDOThxWE1OMVRqaG92cTJHTll6Ni9T?=
 =?utf-8?B?ZUNCcXBhRjlXYU8reUVqMk1CSklDbUtzWTdZQ1FzMUxKL3VLL1ZicFJZNm56?=
 =?utf-8?B?blhZcTdScytxdzh4OW9KSnZiWDRtTytwR0VXRTRncDJzMzVicld5U3V2SndU?=
 =?utf-8?B?WVpqOXgrNzFqenVUTUtkeHhuaUc5dkdZTm43VmlxK2VGbXVMandwWDBtbFN1?=
 =?utf-8?B?MDBCcFpUZEFtS2NjNU1oQmo0ejVrTFlKa1lhWm52SFdrMStNcjk1amVTN0Nr?=
 =?utf-8?B?SWtyd1FYcENweXJWckJ4K01oNmN3MUlMUWg4MTZFZ1I5YVFIUzFhSkc5ZG1u?=
 =?utf-8?B?UkFQSlNtcnhtNzNvdFFTVHRvZ0lTNlhvZlNFcERLZm1IL0Z4MUNLNHcrQUQ4?=
 =?utf-8?B?MWI5aXZ2WHFIVldleTE4QTZDNnVCUFVITFNFcUtSbGE4SDFON05VL0oxbHl3?=
 =?utf-8?B?aWVBRjBYZmVTdUR2Zk5ZL05OWS9UbUhyenZSTDhiMnI1S1FtbUI5ekJuWXpC?=
 =?utf-8?B?OWlYYjVRcEU3T2RyYUdWM21BcXhhb1ZBQVFEdERUYlRrK2pPSk5zQlNrVk5m?=
 =?utf-8?B?M09FWWMxMy83K3IwTDMrS3N1UDNNSnp3M2hVdGI4QVlXS0JPSmR0RzlEbHZj?=
 =?utf-8?B?dTVFQ0JLdnBlM2VDRC9nR0ZoaCtwVkwvZXRTT2lwTlplOGxRTjJhN2dmSVJZ?=
 =?utf-8?Q?77/sT6X3c8rnHe7hvP+KcFY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QAwFaCS19bv6hWmM2Pn0BpW5u9vS2miFJru8SRb7QMHmVHrxEwH8ETOEV0HmPuDlp8U4VT/Tr7Isl2gYl4KCtZ4StyZQXDUZYdwpvCLFWikSAuXOWeTfDJRGLATXGg962pOAT0FtEAvSbhtWGXmj1wMGWuL69niTL0ca2+BHSnJM7RNjy3+NDGEbjrNj9WLvN9PfXS4R1JFkROwyE0L5sP+A4XeoNTUH69XA5Ys9Tf0IfHZw3hAEkXSxNUjiw+MeBSojDfe+SGUQcpAGzhxlm8xIkF9hK6lHoBXsC0G2HXDPQGxcOFGI5FsK1CKCEJ8ji4inoMkzJ1zV2FRb2szFwG28KGZ1gUKvzLIuOLD9QzOQ0W8bLDeHfltngHHICoNOjLp0fUUsDB7tYtIT7QBHgWDiTxB788XORjKTdLMO8S1jZRYgPpF3zPjcDtmDbsZojnyJKsuXV8jCFzzwCO0J3bup7thzNarW3citIUpwmNEoSRb4AWrKcvNa9QejEYWpSBMe3JF4qnincd8dpyuY/cSN0VtQ5dyrvzuGOF/h11wW7zCzNXXpa+7HYredxEQNvUZPxgrDVabhdx7AGK7eFFbcY6tvO+F7YvexvMD/PhY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7cdfbc-3079-43c2-4798-08dcabc813e6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 10:04:59.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOrjgLXI7N/c9s85TGviBbb+jpeeZJJAz8vqXRUFp1aLZityNk8yt2C1kaTV4szqTmxuJg4irt6MtuzQoqYXaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_07,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407240074
X-Proofpoint-GUID: m4yypq2whznEhx65ZaOjOrr3yOcp_RgW
X-Proofpoint-ORIG-GUID: m4yypq2whznEhx65ZaOjOrr3yOcp_RgW

On 19/07/2024 20:13, Arnaldo Carvalho de Melo wrote:
> Adding Alan and Jiri to the CC list.
>

I'm late chiming in on this one, but judging by the output:

  BTF     .btf.vmlinux.bin.o
+ LLVM_OBJCOPY=powerpc-linux-gnu-objcopy pahole -J -j
--btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
--lang_exclude=rust .tmp_vmlinux.btf
[102044] ARRAY (anon) type_id=99491 index_type_id=14 nr_elems=12 Error
emitting BTF type
Encountered error while encoding BTF.


...we hit an error in btf_encoder__add_array() as a result of
btf__add_array() failing:

btf__log_err(btf, BTF_KIND_ARRAY, NULL, true,
                              "type_id=%u index_type_id=%u nr_elems=%u
Error emitting BTF type",
                              type, index_type, nelems);


Unfortunately we don't preserve the negative id value (containing the
error code) in btf__log_err(); I'm thinking one thing we should do is
modify btf__log_err() to preserves errors for cases where the encoding
errors out due to a libbpf-returned -errno, something like


-__attribute ((format (printf, 5, 6)))
+__attribute ((format (printf, 6, 7)))
-static void btf__log_err(const struct btf *btf, int kind, const char *name,
+static void btf__log_err(const struct btf *btf, int libbpf_err, int
kind, const char *name,
                         bool output_cr, const char *fmt, ...)
{
        fprintf(stderr, "[%u] %s %s", btf__type_cnt(btf),
                btf_kind_str[kind], name ?: "(anon)");

	if (fmt && *fmt) {
                va_list ap;

                fprintf(stderr, " ");
                va_start(ap, fmt);
                vfprintf(stderr, fmt, ap);
                va_end(ap);
        }

+	if (libbpf_err)
+		fprintf(stderr, " libbpf error %d", libbpf_err);
        if (output_cr)
                fprintf(stderr, "\n");
}


So at least if this error recurs we'd have a clearer picture of what's
happening in libbpf. What do you think? I'll submit a patch for this if
it makes sense.

Alan
