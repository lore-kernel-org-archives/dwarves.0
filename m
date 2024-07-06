Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A65D2EE
	for <dwarves@vger.kernel.org>; Sat,  6 Jul 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720290030; cv=fail; b=IAEYMdpgeAGGaQ9yTfelQ2dWHWo78FdKglfusuNVKsiFYNFS5M8hPWbXhoA9K92B/vdQaeaaAq6pR4QwOBq50bmCMlJ/g/0QybPLZ/KtsnyXp5WeTWPhnfj5uh1MRJNVvCZXVRK9TJE1IVwGEeJaC5AjpfuGoBezt57jz+H30Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720290030; c=relaxed/simple;
	bh=CA+KlSAyG/UUhtrw8+pIPpD5ZyMbN6x6fdTnPVcH98k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7U3+eSzinOGI0DSJAQxXxTsYaD2VfRR83RRREjM5UisjwC9ytCQwUeNuXuhBeXEoDpGFAzAuJ9yvvYgkkvzt1A0SVsmX1utqXD91n9C1PBWy36JvfktJULVJxVCtOq9mm25D+uZPV1PNEWi5HWcTw1Q0gY3YHMIJXGa5t5bmOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GNf0a42x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dPuAmbuC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GNf0a42x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dPuAmbuC"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 466FK2Nh019983;
	Sat, 6 Jul 2024 18:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=yv8RD4uV1UnwOTXhy7e4hngaoBNlyKTMrpUjKfgSdro=; b=
	GNf0a42xU19qZgYPFeOimf9hzLYmPYrEMN/5FIfFTO3mdP9/NKa624s+qR7Tr58S
	+iiyIwe352ay9c0n0u3GgqJT7a+WL08M3V0T4/chIYwjeAUWcJCe3FPAnBbqQbs5
	SiIDHC47+sFiKZsWeNEZkFXmcb3QAQhL/uWnKgXm0ZmoW/K44tZyby+MLHoukWJU
	rsEvHkCbqZ81+mdONt2uA4jblatfxlTDR3ROTBD4CR2gCSxWxrTFtAtlZt2i4o3L
	61rK82TC0FxmtfgeCSecWOog6i9zk5e8ys+7GS38S877mydtDPz5dZxtFAOoGgpK
	YMR3fUFAZvNLOb1xkCqF4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkc8fwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jul 2024 18:20:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 466HW53K017851;
	Sat, 6 Jul 2024 18:20:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 406vc4whb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jul 2024 18:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhizyhoLuZZ0Do075XnhYuNTgGOkRf80Rw5Hdxue5OFRqO5HpLOcCaAhi+XsV8O+FZ1q4Gkm+xi6ELeArXYPYwwsInDG1A9uH4IVxFWe/CKYFfy5fb/QFli3v5ogvLFo1Bq+5Ath+GEbzWRX6a8Oazuiv/bdfnG3ZAWcmTvBme8793G8m2TqfeHmLzxsFIn3EsVVo2JocUjpbbmIrcUK8pF154jVduztPH//QRrkOcsWpb2Wg8l/oBWBIwAfB7Qp4h0MpZqlglqRPXQqHPtsUtx7lkW6L5HbwdyPOhlP9tCiDlS4exO6jj5Ww0W+a+PqnfWC4PfqQ7Opghoq/G3QZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yv8RD4uV1UnwOTXhy7e4hngaoBNlyKTMrpUjKfgSdro=;
 b=MtTZTkCoy4mRyDGC1AnY2SGw7VUyrlAMndj4VUtDmrkenN/T9qZbnV28OZUyYOZ2QG4en5rKAsT3xOfXMQ5c2ohIpxFkbMGTIm8BvPbrdrDjI6vxqVrB7XHTkE+T9g6y5m2r7cH+Kf8Nf+r4p36Vw69Nqcw94zQLo8Si5BRg2YLvyuAOnEt2Xj3DMUeykudGmukr5UK102C4EtuEOYncy1fDIRJflsBwkdtlJtdhOfobyv72bKdtD7WCQrzV2LFEUAjyFfZlrJq8S+QDcmk56Ug7RXCksjQtKIw3gUj7tRMRgCXi9W1B0ZRKJgMOeUd1sRVXwyB/w4U+DvHVBLVJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv8RD4uV1UnwOTXhy7e4hngaoBNlyKTMrpUjKfgSdro=;
 b=dPuAmbuCxyfIPwGMbPzyJZa4HqeahxZiF+lEFZJZSmd0Ncd+a+URgQasPsXALEkPu3Pkfenbm+NZyqE5FNOt1ZatwMtaekKCHQcESasmFuup/59lSsVE2c1RLuYDqLvCF3lO2vZu6ic5/whA4Ke+79YiCmYQbBBscB8df9sozUc=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.33; Sat, 6 Jul 2024 18:20:13 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378%7]) with mapi id 15.20.7741.033; Sat, 6 Jul 2024
 18:20:13 +0000
Message-ID: <272521ce-f78c-4a21-a276-6c6d4ab5f6e7@oracle.com>
Date: Sat, 6 Jul 2024 19:20:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
To: Dominique Martinet <asmadeus@codewreck.org>, acme@kernel.org
Cc: andrii.nakryiko@gmail.com, dwarves@vger.kernel.org, jolsa@kernel.org,
        williams@redhat.com, kcarcia@redhat.com, dxu@dxuuu.xyz,
        eddyz87@gmail.com
References: <20240705235518.504490-1-asmadeus@codewreck.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240705235518.504490-1-asmadeus@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::32) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b04cb9c-917f-4684-d6c2-08dc9de8470b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TktIdERTZjQ2emlPQ1ZKdE0wc0E3QXZZeHFUYXV6WUY4R0thZVdjcHJiVith?=
 =?utf-8?B?dTBBVjVLSVJJWHVRdXU1ams3VVZ6d0ZpY1RWWmdvYlhHRjBxaEZFUHRpQVVk?=
 =?utf-8?B?ek5nc3pkM1hlZnRBSStVU2w5U0ovYUYzRGI1ZklNNVhJNFA0MGNBRG1kMENP?=
 =?utf-8?B?dTBWR0JPVmtGS2h5SlFPVU9ucGtKLzFQNEZRYUdSNGRyNlN3bWlCV0NUV3FB?=
 =?utf-8?B?Ky9pNklyK291d2ExWUZTSFBCU3dTQnlSbVZmdWJFWDFjWHRnUFdtUFZmZ1lE?=
 =?utf-8?B?N3FRY1dXdHF0THpYQVJRWHhQTlJ1SGdWdzM4YjVWa0c0QkVYK1kwWHlhSGl5?=
 =?utf-8?B?NkpRN2NpZDI4RjRSbDZPQi9Jd093bHZ3SEdwdjNpbHNVRHhTOEVENXF5RjdU?=
 =?utf-8?B?Ry83REZzTko4VGtKdnd6TFFhd1JHMGZoN3E2bmRrNDg0dlh5cE9LMTVNMUt3?=
 =?utf-8?B?bXBjYVg3WlI5d2JwaHF3Q2NKSmNadDR1OTUvRDlzUTZKZFk0eld2MzNFckdF?=
 =?utf-8?B?Yzh5bkJYVVlzczIrNUJiT1lEZERrTHpvOS9EaysxNDVzbzh3WGtKRjdPWURC?=
 =?utf-8?B?MHFBd0htSlF3c3FZWTNVNGRHTG5iVXNHdUFyWGRkSmE4M2FGQ3VDOVhkVHd0?=
 =?utf-8?B?ZWZXUWxncFFQU0NWRTJyRzgyaTJFcFBUcVQ2VmpEcFVTaGNZUVhSNVVSSUww?=
 =?utf-8?B?Ym9VN25Ob0RmYTBYNFBTc3ZQVUlJM2dLdXBxMlRXdUVVTGhFSTFEdVQ1blMz?=
 =?utf-8?B?SVBWOWlMaGZyNlR3UzREaGxLSjFnVE1tK29wV00wQzZSaGRWNUhyU01sSW9q?=
 =?utf-8?B?S2YwQWpmS21mcWloRTBJai9VZC9nblJtbGwvY3ZwazJtaWYvVGNLRks0ODZD?=
 =?utf-8?B?ZC9MSytqOERINWcyZDlEZnAwcjcwVjdYNHRQNlhseTFyMVJWQnljSnBQV0x3?=
 =?utf-8?B?b1FMY0JrOHdDM1JjZWVUUDArSTNNUXh0bU44dVExcUpZN3NRUmpIRDlycndR?=
 =?utf-8?B?Ky83WXNaZW0zSjFDcVRaVXVuVTBBWEJ1NU4yUFhJdTZkakUxbUpQZGxxWEN6?=
 =?utf-8?B?T2p3TDBqbnA1TWt1aDhuVDQvZVpoTHFHdVZLWXpSTWRjaVBqMEQzeWd0SWVQ?=
 =?utf-8?B?aDkvaitUSmMxREhJVmpkYS8vaEU3TklwL1hlVmhSMGRCL1o1RlMzbVFzdGZ3?=
 =?utf-8?B?UU43MWM1ZWR3K3pKL3VBek9zK3N2NXduc2dBdmhxVWE3YkpLdnZ0NzJCK2s0?=
 =?utf-8?B?MXRkT1dNUVJtUVo2RFpGVFNBTTlsTlIxNHlrZEltWkI4Nmo1VWh5U045ckNn?=
 =?utf-8?B?NG0yenl3ditpODlUSCthOE56bDVUNjJxQmQ2Z1o2OHN5ZEg2a3NjSGxyb0Jr?=
 =?utf-8?B?eUhvVkxjOW1SY3ZuVCtSTWx1ZlU5UmFXOWtqbTd5WUpjbWg5cWpMWHNQc1ph?=
 =?utf-8?B?OXFBeGlCV3R3cm9pMERiamxmQ3MyN2lhNmlJOER0aEhWcENKWC9NWUJET0pH?=
 =?utf-8?B?dzU1aXlyU1F6eFcwcFF3ZXBIUERqZG9OVUFoWjNZRFMyaXZzQnBDWTFkbEhx?=
 =?utf-8?B?NEtlNUxpMjJaYVorckY3bi9QMVF6RC9UQnJ6djZkMytJY0dDRlNrQ3pBWXdz?=
 =?utf-8?B?VWpzSEJ2SEhDb09HZFRZU0NnR3k3Z3VueHlrWlg2eDZqQzNWVGUwVGdMZXpT?=
 =?utf-8?B?djdYdjhKZzUyS2wrVlhLdVl2QWMrcHoxK05MWUx3ZVNpcmVFNDdpTHVoU2pD?=
 =?utf-8?B?L3doQUtlWW9qWldQV0dqNHdzbHhVWU80RFBCaVlYeWhKNTl1SVo4WEs2eXlG?=
 =?utf-8?B?by9SVmpJQ1lXQnlOeWRTQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2VTbnJjdHl1SFIrU2s3em52WWNVMzE2SEpHK1BzRHh2TitjNzlPbnVpWEY1?=
 =?utf-8?B?UzNzeFZGQ2xhYU4ydUpiL2c4b2NBeXZXT0xIdXNTRkhxSUl5c05heGpKSHZo?=
 =?utf-8?B?ZnFuZi81OE1RSUo4YTBPSllrWGkwVldoY1drL05HRE5GdlIxUVRUd083Snor?=
 =?utf-8?B?QjdoQVZJRDdLQkNQWDNNV1hDVnIyMVlmeXhVU3RzamQ3NENoRzEwY25ucVgv?=
 =?utf-8?B?K1NCZzB4QzR5cEhPbi9lNit1bVFVandCcklqSE5YbGR4bGJYNXZCaGN1YXZh?=
 =?utf-8?B?QXhuL0hNWnRwbEJQdzJKNG5pYkorZDRmTXZLSXFJc29pQkxaWEtEVjl6dEpF?=
 =?utf-8?B?alZQaUtMekJmOERESTRFTVRrdnZ5MnJPVVE1SkFzQkZ4UlhuTWhudTlSVFg3?=
 =?utf-8?B?bVN3ZGtqREtNT1RtdXA5M1pQby82a3JmWnFqNGNaMlRTK2xLTFVoZWo4Mk16?=
 =?utf-8?B?emQwTW9acFJ3QVFJc0QweStsdUxNeU51Qm9WWVBzUFVCdGR6b09XWTdRUDFq?=
 =?utf-8?B?ek1KeG93eVJ2aTZRbWRTaVRZd2crTU9GZ1U1UjliL3g4eGU4SEtSd2ZLUGtm?=
 =?utf-8?B?Q1o2TlJNVHlhMEVQTnZHL0NUeS85Qk5RdDBITitIRVBGSUc3cDVCWDZzam1W?=
 =?utf-8?B?d0dtMXVwV0tZVkd1RnZ2OE5tVnBHZ3dGV0NiR0RBVDdZdG5RUlFoWHZscnUw?=
 =?utf-8?B?TFhjMy8rWU4rVnlwd2p1NUJQN1c5NWRvMXg2OWU2M3h4Vmp4Q28vbVZVeUVI?=
 =?utf-8?B?NU5NVDZvZ1hTVnA5dnJkNUNoNmo2ZWx5TEV6MGs2ck1udTU1MVhNb0ZzV1JS?=
 =?utf-8?B?NWYzOVY4WDRsV3FVQUdnekRhZ1pMZ0cyQllKMm50eWE3UlU0S2JTMDlDd1lW?=
 =?utf-8?B?aytkTDA4NVRmMm9tZnVRb3hNcWFSR0x4UHN6TkNyNHptWStKcjNCeE9Ub3hx?=
 =?utf-8?B?TzRlSll2Ni90c21TQVpZdmdxbFdpZExNYzd1cHkwOG1UdFJQZW5jbVRRb1JJ?=
 =?utf-8?B?TzM2QUNGNFFiQ2xoRnNxVEIxZXpib0k2WTh3SWFaM3lmZktZUHd3aGZrWlFX?=
 =?utf-8?B?UERHT0lpMlBOZjlwQzhKRHlGSVpWVTZDN0F3bDZieWhtdU9oOXpCQkw3TmZY?=
 =?utf-8?B?ZnlGVVpRQU5OVVdwK2FJZ2hlZW5uZ0w3b2dpN3RtazZma3d6ZUpsL0Nnb29O?=
 =?utf-8?B?YzlQSHdjRExyTCs4Z1BQRlk2NC94OFJQQmlaMDdQSmVxQzJpSmZhNlFnR2t0?=
 =?utf-8?B?blRxTVh3aEZ2NzV0TEpaRjlYTXRFRHJPaHZ1TTY3VGlhUG9md3JpSnFnSW1a?=
 =?utf-8?B?U1kyc1hEY1FUTHE4ayt2TDFuYS85TkFYdW95b0ltUURVT3BhS3llOE1mL1o4?=
 =?utf-8?B?TUZWWGx0YWNqK0ZkN3RYYVlZV1JvV21KYkU2ZzdYc25uUGUvTTA4bEdyRDQx?=
 =?utf-8?B?TWF1V3k4eTFqa1BMMVZyL3A1MXM3Q0ZNcmFja3U0QnNRbFlhVDAvY1djTHhr?=
 =?utf-8?B?aFZTMnlpMGlQUFVzUzY4NitudWtwTEVpNlZmTjVuU0JnWGpzcGN6R1JSTUgy?=
 =?utf-8?B?Y014S3E4ZWk5TWcrTmVVMXBkdEpCVUJDREtIZTZWYjI2UmNlTlJCNG5ZWmM0?=
 =?utf-8?B?UTVRSUhxaHRYRHZCUTBIVHh3MEJFNm9WZE0wdlByMTh4Z29ObldiNjFRckk1?=
 =?utf-8?B?RUZaU1h1SGYySE84enBoRHdDT3VDdWkrVXFpdTdkN3NoV2d5SHdOeG5iNHVv?=
 =?utf-8?B?aVVTMytRTzQwK1hQTmhEMlhrSkhodlVRY2ttWVZtOEJJRDZXQXJHSUVsZnQ4?=
 =?utf-8?B?bnpRblhKVDduWlVwekRqMUh3RkppUGJaeTdRVWxhSk9HbnJyeXc5WVNvVGZu?=
 =?utf-8?B?UzdDckpYWUFkbGxNaTVLUzlSSGVOaWJoS2FIT1FRa0ZDM0gxU3N0OGc3RnZp?=
 =?utf-8?B?eXF2dGlYUVMvUnNlc2dKanV3aWJyVDQ4NWNsOWVDczVZcjdWcWRVMm16SkpD?=
 =?utf-8?B?QlZRMndpT3N2RjA0emhwOHZUYmdya1hZMi9MekJvT043N1JSc0hZWWlXM0VI?=
 =?utf-8?B?MjAvMFluaEt2eHpVeW1ONVRJYTZUbXhUZzh6bmwrWGdybU5TSThaTTV6VHZR?=
 =?utf-8?B?Q0MzRW01QjBoeE9NR0U5UHFNa3dPbmplSlVQREU3ZjJOQ3FnUExhQjhPaE8w?=
 =?utf-8?Q?nLGnQ3Z7GgNsWWNotRl4IzQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Q/kPvTauN8DH00lEeon57oH9gAeT7r+nAypbfIcWDAy8LrWpi9LhNTlvulXSMUPTOgu/Xq3EMe+7frAxm7Eg5huzPOsHD1DggqkzdW85BEMIRsKRcVCsgkdd4cBIsb8Ul8Shs5isYnJphdj+zZQIFfiOUZJ3pQqsr8bnNL9tdxWMUWdZOAtKzAJhGxuK1HTBZdTa42F16J03DNCUzkvE+SSzJynTRpKw20/xtjWJJbb2DCGszsW3YnKXf6qW85A99Wi7ZZ0hzd1JdpPI9g2/HwgyKXJ4Zynd8zMgFSl4QBJQqD1QNxg2BTGvKfaiISrPwh/B7Sq2pAL2modc/Q2GfmWu5Mbp9R4W7u3ZyydpzVovYkg14FDf/vGO/zfWA3Z+Gvqt/nR60ipAs1RwH5XfeRCvi13MawF6OWhs0V53W05d7gHv503poia+Pdtlo4RZfvr7lIB3BVHrRu270cYuAavECQEeXgZCRo2UA8KBrkLE7Gc90KITvTlv7yZN99BEyWPW5pwgPBI5QJz+4o1ouoq3XCxLGXZPnFzEqgi+h9Ph8bnFB+wlysrnPZ0tfL4ubZwDcXCXI3+Nz14Ibs7MorEAs9zuBKDX2DsBy3shZts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b04cb9c-917f-4684-d6c2-08dc9de8470b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2024 18:20:13.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYRXyVY+HsiNoGtT2CI7SByZqLgdvYji4k348mGF9z/WgHzykRhg+VA5p/Jd0YEEv/uCdo5Y3mVJ8KSU4cyUuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-06_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407060143
X-Proofpoint-ORIG-GUID: LqaCgblKyF8U0Kay3UxoqIRVq-xkaR8E
X-Proofpoint-GUID: LqaCgblKyF8U0Kay3UxoqIRVq-xkaR8E

On 06/07/2024 00:55, Dominique Martinet wrote:
> The SOURCE_DATE_EPOCH environment variable is used in reproducible
> builds to set build timestamps and is generally synonymous with
> reproducible builds: instead of making users figure out how to pass
> pahole flags (e.g. explicitly setting PAHOLE_FLAGS in linux) just assume
> that the user wants a reproducible build if this variable is set,
> printing a debug message in verbose mode.
> 
> The impact on build time appears to be minimal enough even if we
> incorrectly make this decision (on a Ryzen 7 7735HS):
> $ hyperfine 'sh pahole-test -j --reproducible_build' 'sh pahole-test -j1' 'sh pahole-test -j' -p 'cp .tmp_vmlinux.orig .tmp_vmlinux.btf' -m 4
> Benchmark 1: sh pahole-test -j --reproducible_build
>   Time (mean ± σ):      3.991 s ±  0.045 s    [User: 7.223 s, System: 3.741 s]
>   Range (min … max):    3.950 s …  4.042 s    4 runs
> 
> Benchmark 2: sh pahole-test -j1
>   Time (mean ± σ):      7.083 s ±  0.095 s    [User: 4.805 s, System: 2.242 s]
>   Range (min … max):    6.964 s …  7.191 s    4 runs
> 
> Benchmark 3: sh pahole-test -j
>   Time (mean ± σ):      3.858 s ±  0.089 s    [User: 13.447 s, System: 7.078 s]
>   Range (min … max):    3.763 s …  3.978 s    4 runs
> 
> Summary
>   sh pahole-test -j ran
>     1.03 ± 0.03 times faster than sh pahole-test -j --reproducible_build
>     1.84 ± 0.05 times faster than sh pahole-test -j1
> 
> Where pahole-test is the pahole command of the linux build (minus -j):
> LLVM_OBJCOPY=objcopy pahole -J --btf_gen_floats --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux.btf "$@"
> 
> And .tmp_vmlinux.orig was the .tmp_vmlinux.btf binary before being
> processed:
> ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments --emit-relocs --discard-none -z max-page-size=0x200000 --build-id=sha1 --orphan-handling=warn --script=./arch/x86/kernel/vmlinux.lds -o .tmp_vmlinux.btf --whole-archive vmlinux.a .vmlinux.export.o init/version-timestamp.o --no-whole-archive --start-group --end-group
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

One small thing below, and asuggestion; it'd be good to mention this
behaviour in man-pages/pahole.1 where we discuss the reproducible_build
feature.

Something like the commit message would do, i.e.

"The SOURCE_DATE_EPOCH environment variable is used in reproducible
builds to set build timestamps and is generally synonymous with
reproducible builds so the "reproducible_build" BTF feature is
automatically set when this environment variable is set.  This ensures
that kernel builds will generated reproducible BTF in such cases."

Thanks!

Alan

> ---
> v1 -> v2:
>  - added message in verbose mode if setting reproducible build through
>    this.
>    I wasn't quite sure what is least intrusive message-wise -- most
>    verbose messages just go to stdout, but using pahole in a script to
>    extract some c structs would see this mangled in output which is
>    obviously not great. Since --reproducible_build only impacts BTF
>    generation at this time, I'm only checking when generating BTF to
>    avoid such needless messages -- btf generation always goes through a
>    file so there is no risk of mangling the output in this case.
> 

yep, that seems like a reasonable approach to me.

>  pahole.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/pahole.c b/pahole.c
> index c866095c8be6..2792e11265d6 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3705,6 +3705,15 @@ int main(int argc, char *argv[])
>  		goto out;
>  	}
>  
> +	// SOURCE_DATE_EPOCH being set means whoever called us likeely tries

nit: typo on likely. also (tho it's not always 100% consistent I admit
I'd use a multi-line comment style

/*
 * SOURCE_DATE_EPOCH being set means whoever called us likely tries
...
 */

> +	// to do a reproducible build. The setting only impacts btf_encode code
> +	// so only check in this case to avoid needless messages.
> +	if (btf_encode && getenv("SOURCE_DATE_EPOCH")) {
> +		if (!conf_load.reproducible_build && global_verbose)
> +			printf("pahole: auto-enabling reproducible build (SOURCE_DATE_EPOCH set)\n");
> +		conf_load.reproducible_build = true;
> +	}
> +
>  	if (languages.str && parse_languages())
>  		return rc;
>  
