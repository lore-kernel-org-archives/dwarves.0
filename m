Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76E1D0B95
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055335; cv=fail; b=YhNryNzR/OQCAu/i6E8Dcd0GJ2Yzeim1aiPHZbH1mqhc+rBAxJ41CxOfb6h2Sg8jHGOmsF4HDiLUybeszrWR4nwV53/T57WTiZr6Qp4980bzJu0Qv9uyCV4Qard+1HBJgCiItmNEwM+0FzmQQar/i+X10oz9r4Qo7Sl3DgRZjF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055335; c=relaxed/simple;
	bh=bqetXCzS0OPCV3JLsICCNK5WsUiGiQL0ltQieAiTOGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+J64rDmvljql3DsqLjC1iy7vifHr3IRg/hJ//c3RMty7qT4eMHpD/lGivPfiiQEUu70I1/7/w+KYz+yDcz7CdRfzO4+gaz+HwTDPnPlQ8rSDUFfLwlxzrRNF7aKjOKbGFuOVGMRnPbiONz4FUTYHy4dlKa+qO3vkKHjeLqXA4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i5P7EaXG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u9N48XDq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i5P7EaXG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u9N48XDq"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLYl8J018686;
	Tue, 19 Nov 2024 22:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=186wkfGMo9+fOIKHXQwasKRYEifxH+M2pmI6vrNzEkk=; b=
	i5P7EaXGeDH7MtpdOuw8/H9fssUaVq4O2KO3RFH5HKgPXkk+qPeUu1Wba3x+ncvA
	P59y5dWXZZ44K6fUgH1MAqflM3eZoaTcfAf8le8WGr3DpTatGpiLLyLvDKkUMwW5
	JzQXWDum2Ucew5RWt7OIQcZTkICL95xiSWmxTUw6Dyo4SKuAVIewJu+tTLyR90M3
	4ripKf/AZlxsc5VwO4XjY+VNFCOVuw9gieXpVNKUWMy5U2p3FfPCEYLgTsHrYAxe
	iMyls2ZYeC1I4bAAJIvcAhij3VTG7SglTl7dVB94vjlA48oVsGmUOYr/0z6nmbmf
	1nmxwDRIaZhRtz1z8gA4fQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebx87s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 22:28:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLkD1v023145;
	Tue, 19 Nov 2024 22:28:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu9mwnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 22:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C14OurROD57PhQiSRrm+ScQff+HZZD+hecodqRxQXxbbLFZqA3ock5YNBKJMJ1SpGZi1U0rPs2GBbYeeSv/3V7y59+JNKUwfXsNDDdm5wsRwvLLqpf2f1ZAY75UwcwwqNjtXD0ceelunhCh7BfxRsd36qNuRyAeiX2uHvPi3l9hjYGo5N+uGSrIQrpvTcNtZ5YOBs7GOb2mjHpfk+29RptpzMsdS7Nu24MBgwjh951TvUfIwIRchDyBuQ0IoGSU0hED+fmg6A12pcBeOxr/mChGjnJbC9Y1BkLJCAyyVP3yOGeCJ8q1zFl7YIwQFv16wv8JXHRD/1VbrbUHNmTt6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=186wkfGMo9+fOIKHXQwasKRYEifxH+M2pmI6vrNzEkk=;
 b=ps6DbHhUmIyZPL0/9iNW0EtZoO0MUKDvCsInSfcdWmNn8R2fwTJdm6qVtjYCEFUkmbdqZwMsoSDwQRMcg4eG9+0zi3jlVPgE9qOiTz1vVwQJuZDBG6WiZ92y5jDqsaso7y3U3biaSuy5p1hYr6dhfiCXSgo0P8F48mSEB5NCMixltVnXDoy/hBKz+TLbJODosP4LdgHZ3lVDLx+E8L/xikQnZvvQ6Z1VvcVviU00CWxmUvs1PfQHVxTzj+FQTzuWJao3ICJUGyWhjuS3eLNe2fTKca/UYYuhZKVwdaEGHBdXEymXIkw3FvqPQgqzYo/74j6tJHbEiQSUjHqR0cqxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=186wkfGMo9+fOIKHXQwasKRYEifxH+M2pmI6vrNzEkk=;
 b=u9N48XDq2KmVLmOi50XXefOA1y2LLRa6EKj8ExIvI4vvfZ6wH8c2LLy9ctQZFWZp3TR0BektXJ1RiIoHrFidJro+Kk4+xwF7cPFoHytqyOvNgKra0/fjU8vd0XqaPegYVRqdMEjCLADsMJ9UR19kfdnCyp9YKSs301XplTH8FoY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN6PR10MB8024.namprd10.prod.outlook.com (2603:10b6:208:501::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 22:28:30 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8182.013; Tue, 19 Nov 2024
 22:28:30 +0000
Message-ID: <f2d1b6b9-f04e-4cd2-b73b-1a72057088da@oracle.com>
Date: Tue, 19 Nov 2024 22:28:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pahole: Honour exclusive BTF loading
To: Eduard Zingerman <eddyz87@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>
References: <20241119134032.783215-1-acme@kernel.org>
 <20241119134032.783215-4-acme@kernel.org>
 <a1366bfad38306b2e7e41549ba1ac2ed217b94ff.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <a1366bfad38306b2e7e41549ba1ac2ed217b94ff.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN6PR10MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ad5d1f-ab07-4f76-33dc-08dd08e97eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGFBT2N0UGVQK2FaVktQS0lSKzdxdy9NVWVETHpDR2ZyN2gzc3p6TDUyYTJL?=
 =?utf-8?B?MWhFU1IxTENaRzcvR0kwTDlmK1NibGZpbEY2SHdvUmswcUZMRzhRRVBORVpT?=
 =?utf-8?B?bTVPdDhHWlIzMEY3TmxUd0s1WnFoMmVNUjRkR2RUTCtKSFA4UlhkZm9ReFAv?=
 =?utf-8?B?cTViM29QRjk3VW1wem9ZUGtBQ2NHSkNZcGw5aVMrdUlzSTZxcm1nQ2hscmRR?=
 =?utf-8?B?SjFkVVRwaTdHanFvMTlrK0lyTVM3aHp5RzVNMk5tK2cvUFJFcDVublk1Q0Q0?=
 =?utf-8?B?L2F5V2NUeDRFZGpraC9JUzBmYndQeFN5MkxINHFPbDBXT0cyN3JUanZsNWxV?=
 =?utf-8?B?b2hEV3J0MHAvK1dtR052TUpieHMyYVJvTnBHR0U4bllSTWJHRDR5VDZuVlQv?=
 =?utf-8?B?NGZoZTllcTFsTDdha3ljcXYyMnYraDhwSk1hVWNIeDJTQktuamVlemt4cnlM?=
 =?utf-8?B?dXdwc3Rhb0NQYjdZUC82RisvbTBmcFZ6WUg2SmxGOXRDQ1lsS1JvQURMZTVC?=
 =?utf-8?B?ZFI2YkFVcXhLVzMyNVhjY0ExeFVhNzgxcGMvWkZnTW80RUlNWmEyZkUwRHQz?=
 =?utf-8?B?L2Q5cXBsajU1MHErUkUydnZlaWtpcVRBU0FMQUZPZTlRTXJFL1VzYmVHNXd6?=
 =?utf-8?B?VDlXY2ZrUlFnUUd2MWVFNEU2Y0hqdG0yaG05b3BxRmtzRUZxckt1UnhrVWxG?=
 =?utf-8?B?Q09MMzBqM3RDV2dJN0VVSVAzc3dFdnJ1cnhxRXlxWkFqUzFBK2J3eUZZdWJR?=
 =?utf-8?B?SUdFYU9WTjNtWFJ5ZldheEJrcFJZamxNODhPUGxWUWlwcFpSVnpBcHpnNXgx?=
 =?utf-8?B?emhEY21vZ1VmeG96QUlsYjJtSzVpSXlkemtqcTlIVFlUUkZ1UDNkeTU5S2d5?=
 =?utf-8?B?UkJ4a3NUVEZMT0xwQ0NwWEx4MmhXWWF1clRXQ2VMTXd1TllKclk4NjJ5MWlw?=
 =?utf-8?B?MWZpaVRNUjRVVVlmVVVzNjdQZTBtSEw4YmgyMXRsVkFleHhmSHFxbWN2NSt6?=
 =?utf-8?B?dmhPajlENDVFd0hPRjBuSk5DNGpjRndvQUFvQ2pVNmZqZkgvTDUrc1VSSk54?=
 =?utf-8?B?VU5MWU5VSGNtcUt3T2tGS1dhblNucHdCaWN1T2lsVVJldWZ2Smo3cE1WbWJN?=
 =?utf-8?B?cHUwRkRoV2RKa2hrM3ZEVHhnUGVaZFhHb2xJUWZBUlNlcURKVWh0ZU92WWVr?=
 =?utf-8?B?a0ZCL1BsWGFLUElFODI4KzdwcmgwbTV0a0paTVB6MHhvaUZNRkRBK0o3V3Nr?=
 =?utf-8?B?N2tqK1VzQkpCalZtSTVQaDR4RjNiVDZicHcyYTBLcEM0b3JUUnRqWXR6a2tr?=
 =?utf-8?B?czdxTmpCa0pNVWlQbjRBRzdRaTZybGhtcVROeHVHV1lPNmJBUkJuazVmRFlU?=
 =?utf-8?B?bkVPU0ZpK0wzVDRLSTBvUkJFNjdtM1VSQmt2N28vV0M1MitNU01VNFlZL09T?=
 =?utf-8?B?bDZnV1QxcmZFdW1OZlBUbmNIalhWOVpqMEorNW1DTkl1eDM0bmJPSkVXQWI0?=
 =?utf-8?B?c3Vtc3JMMG94NHZXZ0RSTStBK2J2T2duSGhzZ3NVMHBmdngyejhxeUU1bVdw?=
 =?utf-8?B?NDFmbXFlTmNNenN5MDJBZ09WR1hxWjJENWNiNFRnbWpCejZ0MzRSdnY1ODJa?=
 =?utf-8?B?UnI2NDFHZi9XM2hYcnF5MytGWDBnOEhHOWI4bEc2aGQxa2cxRGg2RkhtYVZF?=
 =?utf-8?B?UlpvaTA5S1VOQzI4WHlialJtTVJ1N0k2YktmRDI3ZU9CYmg4N2MvZ1BEYTQ1?=
 =?utf-8?Q?Bw5Jm4tQmNqjt9O1rnZssk36y0l9ITYLUC2fhDc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE5sSWNKdlYzKzJaTERMa000YlNLd3VqK0NDZ2Y5VWlhdWZHaUFTU3VEUEZJ?=
 =?utf-8?B?eW9QVkFRR3RlTTBuRGRrTXlkUkFVbmFjdU9YZlc0M2NwQnM3eXZZUWJocHFD?=
 =?utf-8?B?ZzRTVTUrMS9WOFlNMXA0dHY5Ukp6YXlHaWMvMExlcFlMSjh0Rms5TThNaU5Q?=
 =?utf-8?B?aW9TR2dVR0pOZXpndUlQeXgyV3M5NmdzQ0R1RjdRSm5EYUdnSTNMSklnQU5n?=
 =?utf-8?B?Ukh6QW1ERS9iUytjd0J5TVI0bHNLOUFzdG1BQVNNNXYvVjJTN3pRZ0pRaGdu?=
 =?utf-8?B?VW5NVngxenVPcjUyVmxNb21PZTk0UWNOU3FWN3oxSGVnazArWXJ5WDhrK2tI?=
 =?utf-8?B?cG9RSVlRMjNTUmw0L3dSQUFwVVEwVTV0WHlPTXVaTkVpSTljTXFVQVVzUENn?=
 =?utf-8?B?MmJDWVJQQk9wZDl1THNLWnNjcGFKMnNMZUFMY251RjIvQzZ2WVFzWXhKVEJi?=
 =?utf-8?B?bFJCNXMzbWZLSFM2Zi81N1M0WUw4ODljU0FydXUzOG5reXJhRW1hY0ZBZ294?=
 =?utf-8?B?QkNKazVQSHJyY1gvdEtna3FEaWM2TE5mcDdDdmV4SHBZTkd4dGd0TGdaTXlY?=
 =?utf-8?B?eGZYZTRtdUVPcWtPN2xHQzNIZ1BjNUJUUHo3SzlqZUcreGd3N3dWQ0xJU29I?=
 =?utf-8?B?ZGJUaSt2aWNtbXM0NUsrMTFzTTluVVIweTlIdXpOYUhCUGFaRE82RlRYOERP?=
 =?utf-8?B?K3RUYjdoRGV3b3E0Yis3Yko1SDh6QURENGh1QlFjTUU5dWg3K1prSGdPc3Na?=
 =?utf-8?B?eDE1V3hybm9xa05tUVd1dlpXTEhwcHY3eHg4UEV6QW9obDMrek5YNGNwYk02?=
 =?utf-8?B?RlF5Slhyemlva0l3MjFaNWdEb25CWGFLd1V3OFA5QnBnMEdyRHlsZWpjMXRH?=
 =?utf-8?B?MEZRQVNrUkZOK2MxOENDaW1SdEdaVnFTbURKWHgxNGFyTk5TYUx3dFBDQ3k1?=
 =?utf-8?B?MFFCaTJ0WEwxNHRsdldrSkI3dnNKNGRDMG5BdzRtOTMzZDVEUWFRN1d1YzRr?=
 =?utf-8?B?dHNlVEJCSGZQcTdIUXJMQzRYL2RmdjFJbmF1YTZpakIrekdzT05BR0VaU1Jq?=
 =?utf-8?B?RGJDc0h4WExkWEkrVlJlbEdsdXY0WTJRRkNXL3R5cnN6U1hhTjdlTEQ0cVhI?=
 =?utf-8?B?R0diYmQxekNQUXJqb2hSM0NMQkVMWHhsM0g2NExuRHBZaXJGS09OdXJ3QmNZ?=
 =?utf-8?B?ankxakprbHNPRTMyN3dlWnMyQmtpd3RMWVNZelB4aXdnTnBnTUJMV05oYVJO?=
 =?utf-8?B?a2sxUkVRbXJnK0RhM0xvcFg1VldmYXh0bktZM3hvNS92TUNJRjVUM2hNNmE1?=
 =?utf-8?B?VG1HWlZ0eDRwc0dLZlptbWRZWjlicm5iMGJDa3ZaVTBUblJKUHNMSlloWnRn?=
 =?utf-8?B?Zm9xczhLcTBnMGYyRlhETERLS3EyWjM1aEpxSGZtdmU5ZGVzTUh2V3RWMWVu?=
 =?utf-8?B?VUxrcWpCaUY1SzlFcGJjb05oNDVWcFJiY1o5Q0lRdGdodk5JMW1jNjdza3FB?=
 =?utf-8?B?NjJnNW53N0tFTldnUndadTlRdGgxT0xqYklGeVBFeHhJVnNjT25VRUI3VjlS?=
 =?utf-8?B?VGZtellrdjkrelhUYzZ5ZVJ4clZmdml3ZlVzSWx3YVkyd2JkTEVpYmlWRjNy?=
 =?utf-8?B?UFZJZnlDL0daTWFTRzdyd3RzOVVaM1J1c0N3K2FZbEVxQmZGQlcwYUtuVFBD?=
 =?utf-8?B?ajZPVzcrdEZHMWoxYjVqUGdQVlNvUnpCQmNINGpCUFRMV3FzOVNMaE9IS0Yz?=
 =?utf-8?B?aHRzdmxIaE5JTHRXS1BrRUlqcG5wL3hwNjBncHNQbDI0anhVcy90Qm5qN3V3?=
 =?utf-8?B?clBBU2tIUzc1dUhSU09HYjJ4V21pVTVrVWNZOHYycUpYMW9RT2t4V0V2cVdP?=
 =?utf-8?B?dWhSQUpObmw2T1p0ZGlBbjl6KytwMnNnMHVrbzN4eTE3TTVQRko0VldRaDNV?=
 =?utf-8?B?Wm1Bcmt1Z2N2TFpkanNWeGthY2lvT2F6aHR1NkJBeWVya0xQekdnZmRTRmQz?=
 =?utf-8?B?clNGTGZUSWc5OTNzODRwWHJ4Z3lnbFdya3lqM3ZWY2FLYmlGbXkyT1l3TUtu?=
 =?utf-8?B?RlR5L3FKcFlhUlY2RCtxcVdZOGU1QUY2b211UjJKWmdPSm9aR1FFdUJyRGVQ?=
 =?utf-8?B?U2g5cUFRc2Z1WUhsMXJQSi96cDhaVGNQdk9MalZYMUNTdkJteHErRy8rNVAv?=
 =?utf-8?Q?8Mi6VRZl0lJ0yzQ3yKY59V8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QMnYAzv8YWoKd+3ECwW8Pf7YcNTR9PTUYkCBziNcRQ2n+G4UI3rmZF+tjl1YHHhapn2A9d0uLHOx+ymwBC9MTdDxjUP5O6+vfg3HMJSCzPnk3B7WjQ4PWwuPX6GP8/Rc5iK3Xq++IcLLxW5p2nCYsEuciyGsiskCUsb9jXRNLe8JLOKJpgN1NK+ejmlfqjeS2JPnCwqYR/6eU0x5+0iBIkxDGzJLmPhevf5EqyXMN9XxzuBd/Ro7B5krXmNCaTki03HIbLTn24jDMMI5T1JFovI0ALedymbeThf+ISSYNu+HYgPNwyylArn3Ho30eZRmo0ZhA8eqnN876m7S1sZVKBRQIPNuF63ge1r77Tki5woOWl7qDJ6EGcAj5Xh+DmRsctviLxTNDOYjnYGBR+Y06Qnhj2p6wb70oUR4w5CPKtp1SYhbqd+okKMGTyaamrRrGowSptXIvI+a2BSv2zsS7+pAgGVifvrLxOccA8pH5jK62M/l+A14v9w4/bKaRxyGxBTxNLMa75+bZsdl9URoiWL95dv2Qv7n2IsULosLBy2O/nii51z6k17bL0W8RtZS0xghSEyszO3y4/aujBR9X6bkaWQVd/5r2YjlWBhkeqo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ad5d1f-ab07-4f76-33dc-08dd08e97eb4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 22:28:30.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh/M1gT3Mr+PE06KUgb4JGF43IFEgyuXeFUZ8PuBYd0CYGUfrnSxvpFEFiwPzWKHr+Dr37rC3ynqoK1VNGYomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_14,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190163
X-Proofpoint-GUID: vA8TGVQhtbH8-mNKXxIOZN5s-3_aQB54
X-Proofpoint-ORIG-GUID: vA8TGVQhtbH8-mNKXxIOZN5s-3_aQB54

On 19/11/2024 22:04, Eduard Zingerman wrote:
> On Tue, 2024-11-19 at 10:40 -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
> I tried the following test on top of this patch-set:
> 
> ----- 8< ----------------------------------------
> #!/bin/bash
> 
> cat <<EOF | clang -o btf-and-dwarf.o -c -x c -g - || exit 1
> struct test_val { int i; } g;
> EOF
> pahole --btf_encode btf-and-dwarf.o || exit 1
> # Note: has to be llvm-strip, otherwise --no-strip-all is not available
> llvm-strip -o only-dwarf.o    --no-strip-all -R .BTF -R .BTF.ext	btf-and-dwarf.o
> llvm-strip -o only-btf.o      --no-strip-all --strip-debug 		btf-and-dwarf.o
> 
> for fmt in none btf dwarf dwarf,btf; do
>     for file in no-such-file only-btf.o only-dwarf.o btf-and-dwarf.o; do
>         if [ "$fmt" == "none" ]; then
>             cmd="pahole"
>         else
>             cmd="pahole -F ${fmt}"
>         fi
>         printf -- "------ PAHOLE_VMLINUX_BTF_FILENAME=%-20s %-20s ------\n" "${file}" "${cmd}"
>         PAHOLE_VMLINUX_BTF_FILENAME=$file $cmd 2>&1 | grep -P '(test_val|pahole:)'
>     done
> done

this is a nice test, maybe we could adapt it for inclusion. more below..

> ---------------------------------------- >8 -----
> 
> And there are a few surprising (to me) results, namely:
> 
> ------ PAHOLE_VMLINUX_BTF_FILENAME=only-dwarf.o         pahole               ------
> pahole: couldn't find any debug information on this system.
> ...
> ------ PAHOLE_VMLINUX_BTF_FILENAME=only-dwarf.o         pahole -F dwarf      ------
> pahole: couldn't find any debug information on this system.
> ...
> ------ PAHOLE_VMLINUX_BTF_FILENAME=btf-and-dwarf.o      pahole -F dwarf      ------
> pahole: couldn't find any debug information on this system.
> ...
> ------ PAHOLE_VMLINUX_BTF_FILENAME=only-dwarf.o         pahole -F dwarf,btf  ------
> pahole: couldn't find any debug information on this system.
> ...
> 
> It looks like DWARF is never loaded.
> llvm-dwarfdump shows that DWARF is indeed present in only-dwarf.o and
> btf-and-dwarf.o. Is this an expected behaviour?
> 
> 

So my read of the current intent is for PAHOLE_VMLINUX_BTF_FILENAME to
provide an override path for BTF debug info only. In the above cases we
know where to find BTF but don't go on to assume there is DWARF there
too. I think this behaviour would be more surprising if the variable was
called something more generic like PAHOLE_VMLINUX_DEBUGINFO_FILENAME -
i.e. not specific to debug info type - but that's just my take.

We could certainly make the override mechanism more generic to other
debuginfo types, but I think that could be done in follow-ups. What do
you think? Thanks!

Alan
