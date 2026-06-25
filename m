Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1423C516;
	Thu, 25 Jun 2026 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393806; cv=fail; b=Ijo25UfhqTxN9ElHbGgQXZaYsTK0okWA311mKwpyMFV/lBO2g+o6FUYSZIVu8x8ndq5iKCqxSrxyaOiaLHjh7NJuoFXYSGXpBWywhW/rfBPdUKJ+RoLLUuQqVPsN9f8XqPQQmhcjRQUU9Nsv+4Q2E4b6ywehh+tExeIFKktc+UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393806; c=relaxed/simple;
	bh=w/0YGHDR3PeHxeY5bTMchrh841IR4+DkXDn913ESMrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VuJNnr6XQUeHsXTlnSJ/eA82LLdbBB6rwc98gjvK3R6NWPoULGE117russAU8/ZUKITY3RcuFWO/u6cuBUYQbn166oIhqwthgDfG8VMX8pa1F5BNpNtOMD5AMRoYodLlBg9o0UYkWlTOiCJP7cW/WBwBQ56WNZSyuwkudNxhJcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c0eJHhWX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XBMsZf/v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c0eJHhWX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XBMsZf/v"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3lTrQ2539756;
	Thu, 25 Jun 2026 13:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8htgghRCysWnTKVEvC/arECNbxB9IKQ6uv+SIOzC4/g=; b=
	c0eJHhWXlRzb7DKY5EYVmQ1NJE/f8/3o0CNEkPKHCiTFJnzZ7WyDIUlCu9Bz+q/a
	6/2WHPlEMpPqeIngR7zgdxXhVUmD4tKPIWfdX2Lj65P1Xjn1erIUDjI6a3Dk+YqP
	9lTSr20OWMhRxZ7OC2SunKnIVROQDdwpGKOcJpqV7ycmSbS91giEGbaAbRCdb8mb
	Ubh2y7Ru98oB34k0zZmLMnFzcYO53BYmbw/rmWwZH8n84n+61aO96ZanksEAvSaw
	gtI0GOtUXvRlkJ03oUYio5A/TFFYreKlLh718Nk5QWioKpJfRLFd5JoI1JngMSxV
	Hc9HBJGJ0QrTNXKdTYpHYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhn2y5xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 13:23:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65PDNBcd004697;
	Thu, 25 Jun 2026 13:23:16 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhaf8tvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 13:23:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXJ0WpKycNF8mtzeL51MI1DJyl0I9q9UYV3EGyikwPIiO1t6p6sEJUiMuUSk11z+Bh+p6oy5f1+76H8kRe7A1ZRvgkXXfHOQhDKAb+qEgt4nuLdG4uzM+a/t2LeTFHHcdbWQs/osluVMC+v4WC1YHtSFsLVQ4mFG+OMDDfh0aHWJYOGjcVvbBn3k3vmmYBSzslp8S0h9hoREPs4lossCNsZ65w5YWX6Y/dflm6PwChloeZgNeSuVBZr8fpBxZtyXWv3Gn37QiWs3KAZyetdauOlfoZmFjNtRPGv1uzg9GDtm3ZrrXKCN2weCBSGkTcPtMZ+wa/oly4fRhF+U+WaZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8htgghRCysWnTKVEvC/arECNbxB9IKQ6uv+SIOzC4/g=;
 b=axWy+cdBdxo/AQeqmwf2t9DXvmt+yG8g/nzTGV0CLEx95sfi7QAYp25vjJHJVHqxd3GzidZJ3lcit1JKI0Z2dYY6sx945Snh18VNDDhCCbivI4dJnBvhGXj7NjqkP27i8q3JNwk47F8hghK7bmxh7XukiSs65w+36DfNxHHYimZwFsMRI3K7W1VUZJglfcK275A3YvHbG9QUk29J3uyxsI9FV9dbieNfFuJxzi61eZS+afLs/IMsyaD86HATOcdnDHZhimi71DdEA5WsXxiwJtDgLfbeCkMVu+WdIEp0FzF5/4gncAhNeafNbHTXuIFZuCxGe205vu2cl5glDVH9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8htgghRCysWnTKVEvC/arECNbxB9IKQ6uv+SIOzC4/g=;
 b=XBMsZf/vcU9r59P0rYtwM8bH3DLNZGDbsygCyb9qI+tD7tNLVk0/NiA28Tjhe0nkmttKiHpxMNo1awCk4OTYUtodiWV5bQkJkX/r8eyP6lV2p4CMROBakR6r7Pr8/SA2miWAKitdWp8Ka66wbDXp1swy/9RMAc/r0iqOrfgVlRI=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH7PR10MB6354.namprd10.prod.outlook.com (2603:10b6:510:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 13:23:09 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 13:23:08 +0000
Message-ID: <1d7828aa-164f-4c36-9d5e-2eb2088ce5b4@oracle.com>
Date: Thu, 25 Jun 2026 14:22:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v10 0/5] pahole: Encode true signatures in kernel
 BTF
To: Jiri Olsa <olsajiri@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20260625020148.1883082-1-yonghong.song@linux.dev>
 <aj0KGx-5FwUbwGHc@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aj0KGx-5FwUbwGHc@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX1P273CA0004.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::9) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH7PR10MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: e481a01e-d292-4d0a-4bf6-08ded2bce5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mpuGwe8WnaYXgWtaQnOtBFHzXqQBk0sukc24vHJONluJuGVFDnuzMs16qxhFVfV75LaMntfp5PVKgPEDd/jnLVt38SjzVV3CUjcjPS9LAjKvpSisDcAoRvTh00G6G2EFkhY0dNCet19R+mwtiHnnyQTNkJEMV1MVT+I/zX9CjcC/vEEo9jRxIgviGHKzcXKjWIFYHr8UW+eQPFswvBJml1Lf7bAco2ddQW78u29QaTerhHDwY4W0+Ku0cmfcn+WjpgtwN/cQNGh9mLlMTmwX0mMs/XgoWepBE6g0c458lgJQyWquzSrWgyY9iSkQO2+kKHF8tm57mZEFuyMZztA3B/srdDKKaL9fOFzf/+3bN4t3BIa2bHWcV4HFDXwXmvL+Atvz/6nGdnKUinUggedhnHCIW5FurbFIyWzLg+mthKhAnHEpsujsBA2mWjXTqE2FdqiNKyjKgq1KLY39cDvnto8vuHB4EUyB2OGLwRhWvXAdCDAnKKXkcCbWsLnFZD31kzWxwqKKbkqcmJF13NrNM8gLBZGGmmLGfYUUQ1jtqMZ3BGcAT4RrMkS4TWBENbFYU7aIWKurnYv264ZRSRx8bU2gJuAyn3mth2pIUfyqBSecJcGPlSXFtimpb+Hp+kU364CrA2T2w6v1p3t+5dIVWqKpKvfpA8siK7d7U9wMPTI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RC91WUUvRHA5dXkwRno2V0taME5RRzVERnF5MGZQTkFFZDl0T2lJTzYxaUNM?=
 =?utf-8?B?UjFhVGwwNGxkVXpjUlNFa2RibCtlRmtTVW9XWHBLTGFHeXE5UzZodU0zRGpF?=
 =?utf-8?B?YVEzY2RDcU81YnV1YkpFWDMxR2h5dXRkTTZsY1pUanpyYmhqN0dUUXRwTC9z?=
 =?utf-8?B?OVA1MjJiN3BmcklWVkNZQ3g0QVlocDczNC9oQzVGUDNTRFAzbTVod3RkVDBV?=
 =?utf-8?B?T1haZWQxMG1zYjFXYzkxV3NPNmYybjhFSk9OZzluUGVaemQ1MFpnayt0OWI2?=
 =?utf-8?B?WENHN2hqdWpnczQ4N2phNzdHai9ENm1HQ0dWOWg2d1dRN3RSMVFRa2NCdTc2?=
 =?utf-8?B?M1ZHb0Z1dmJlVktaZk5tc08ySkI5MGZHK1EyeTlqQ2tOMUR6M01haGhUa3pP?=
 =?utf-8?B?bFE4bTJnTHQ3aUZ6TDVFSXhQVmNoVmFFOGdyckZDRmNNTTB3RG5BNVFQTGUx?=
 =?utf-8?B?RlArckRrSmh1N2pwckhxc0lYbDZyU2s4Rk45WFR6YU1CQTl5Smk1UlVuM1Bu?=
 =?utf-8?B?cjJjNGVjTDlyV09KUDVlYWJhQWpVSlJYbm5EUGE1bVF4QkZ0alZabWJ1RXE3?=
 =?utf-8?B?UGMwbEs4YWhrWCtKVFl6dWlsWWw5YndmRXZaSzM2dkhQekE1cWdhcFBTQzBy?=
 =?utf-8?B?TCtVbkZXd2ROR0VGTGFtdG1FcUR4RkNGUlc4cThSZ3JvTENxUFV4Tm1xTlRn?=
 =?utf-8?B?SEdXOUJudzlFUzFFYXhTWGZTcnFBSVRhcThFQ0tFRkZrV2dtRktHbTV4dVZ3?=
 =?utf-8?B?amxjb0tsZjNxUEFkSDB6bS8rQ1I0M2lQNkQ2blViMWFoQjcyekhDclJVQWc2?=
 =?utf-8?B?K3NNT1R4MC9jSEtOcXlrODBUWStpODBvZ1ZlMjdLNGJmT0VXem50ZFVkMVFI?=
 =?utf-8?B?UWdXNUF4SFZEdTNNVDU4RnkrU05xT3JkTk8wUldLejNNSlQ2SVh3OExTWkh3?=
 =?utf-8?B?WWlhamkvR1BXNFkweE4xYzhZUEllSTJtYnY4bDl0Z3NldXllMHFjZys3SHpx?=
 =?utf-8?B?YzVZWTdmdHp1WGtMb2t0YkloQlZjRkM0NjJBNDU4UXBLRklYVUMvZmx4WEtr?=
 =?utf-8?B?V0paMlcvN3RidHFvZlo5cHVpK0N4MVdvOTFLRnBtN0d1SEE0VXhHbzlWWjh0?=
 =?utf-8?B?QjhyTVNTNy9BbjRiNVh0a1BwQWdKYUhMY2FNVUJCY1owVXlJTVA4Mmdjc3pp?=
 =?utf-8?B?TEp2K1FwOWZlclU5YVJJb1BBZXVZd3UrMGRCS1JkRkNVNlNaMWxjdmpKVzBy?=
 =?utf-8?B?TmQyTEhWdWhuaS9QUWtNMDM4OVdldlB5SHJPem9LbXUwKzZvNVFDbmZ2NDY3?=
 =?utf-8?B?SnZHZUVpamJlQ0Z1eEk0cy9qYkl2b1QxVVljeWM5T2RiN1N3dXlkbmdWUjZu?=
 =?utf-8?B?OFE4VHc5b0M3ZU51dEpPZ29RSi9uS2Z0cVQwU05CQkZNNHhvUW40QmdUUFZt?=
 =?utf-8?B?WTJGUitkQmNnUE9xdU41RGNBZGFSU2FHUlZrK3dFWEhoRk41enhoL1l5Y0tF?=
 =?utf-8?B?MEJVcTFkRzhiQTZQcHpsMldzdnVlZXlCVnhTRGlrYmhQM3EzVVdzNFpMR2tO?=
 =?utf-8?B?SUsrRDJ1VWwydVBEWWpCR2JtM3BBWmxYTFRnS3hQWS9hNFpKUjI5MmtLNU9q?=
 =?utf-8?B?ckJNSmVBL0p1N1EyUzNCWW9vcWRsVXU3MmhZM3NuTDlWa2F6UWRMZ0ZZQktU?=
 =?utf-8?B?c0t4RnlOUVpMOGNXK2p2RjVjRUhiZnl3ZE8rV0k2TFhVdyt3VFpMQUNKbnBJ?=
 =?utf-8?B?SHZjUVhuSzduYmkrSnBqMDZMckQ0ckE3TC9OZlh3S0N4eW44cCtrajhsYWRK?=
 =?utf-8?B?ZityVjZrZlZjaXpNaDIxVStIa05oQ2RnL0ZUZ0lrdndHTEtPUEFJSFBMWldr?=
 =?utf-8?B?bVhyTHZMQUw5d0lTb1hyVmgyQmVtMDF0TFpoRkNoNmh0L21CQjBVOUJza0tI?=
 =?utf-8?B?R0QxREhTVmRCcGVKd3FrYzNra201a29rSlhPV3V1d0RrZnFpTE03eERqakRQ?=
 =?utf-8?B?ZDJWUVhLWnM4WEJEbi9uMzZyZzNjZUEvaHFZdmZ6cCtNTlBDOXFnNFhHclhJ?=
 =?utf-8?B?YkROMFk0NlFPeGF2RDlTZURidVJxTDEwRHJXWDR6dWx2SEpFb25FbFlRYk5K?=
 =?utf-8?B?MktUa3JqeHBVbE16M241cWN2MSt5ZWxHRWs4TU8wSWtZQ1NhelRnby8wZmJ0?=
 =?utf-8?B?a3VYbjlIbFhNdldBUjZ1ZnpDOEdvY0NDZEdOQnpFMFNPR3drTUwxbnFIa0lI?=
 =?utf-8?B?QUk0ZVNFTzNGUWpaejNLZ3VpN2dpS1NBVDhGNy9jdUVFY2hSTFBENXFka2hT?=
 =?utf-8?B?RXFYMi9PK0dUSDhKL0pEZWVreUw5NFRzQnAwS05yT1ltS08vNml3QT09?=
X-Exchange-RoutingPolicyChecked:
	cyWW71eROrwWI+SMsHRkr8W9826c4dC3sHn2oSgoK/EBjqmbrQG7zO0LgFCPP49XKtij0DG9CFNv3riMIKqo695K3e2VGNbp9Zaa514rC6tYG/+3Sh6zDLT1FQo2jGqe5pVR97ylE/w6eFcBFTl5XVYhNF1kk0qnffjX0M6y970xWRpumveecm+eOwzWquhTHn5kmK4fPrAX4JqRYciUISkDQODobhNbjsAYD2+Rgudkhx6Xy+6G9ozl9e2XttTD7jUMfkV/4Mmy8MbhbH+sN3yf92ChU6zFe87sZ38fZ1PW7ffWo79+Nk1DTW4aBzTDUsEKl8rGv49MRW3+AOuIzA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rp6Mq+LSP737gkBGIV/3EpvsHkhE5AG1sifCajsRW/IrGz9IT9q+qV4fqNIurF8h8HRZDMsX6W7gbG/BOtMam7wsdOGqBBlQS1AvmzHh1cQx1S/2GAxO4lwhvR5pRsWJKLwuOtKv9CC34pf5/ucCp6+C+Hu3Qt9BJ/6UbBe9p+Vym2hIhN/0muGoMbV4T/gM8YEoBJ4aAj+w8cr5kg53rfnLrrGw6r+Ulwi28axsBlExfLP1Sx0yYBZuIzYjzM6CYh2Wuchcf1pnk6f5AmVymgYh8zxYPHvjziTryNA2fEHy/rrGfhblYOsEmUabvPsRQWzvVknq+nKbcew/ZCqraDzQNTSyosu912Iqff5A3SXU5zfEDDFRdvAZF2kjYodYQHwqjLkoJQUiXPYv/CMf/rk/vIibfV0apr0SN1b71yPOFO/neROCI2j/FSEWdsKyKcJTvuqoa+pHEn1ZE2FuCsF7+MlVgGJRxElHDWI3/nK53/vWDQFMTFqwGGA3dZQ0lz7iI7N/Sve3zxwAEtUkLr2yQq5ydZpWeFhqupwaR9U0AcNUahzFujVCx25l70CMAlRUkgCuPJvEqMdrq/jEKlZ5+4L+YE3IuYojKYDRrKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e481a01e-d292-4d0a-4bf6-08ded2bce5d2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:23:08.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3l86TCAD1toxDLzXzj4PJfCLG+uR5bUDUC4Qk8pkNrlBIdAbHtZIrRipbQ9+uPT823skWl+dWkIRNxtInZ9+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606250115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExNSBTYWx0ZWRfXxVMIHFMAgi//
 bvaYX4CgIJtybn1Vx0nYyPK/14UvuTZ5tIdvmIRCtQGQof0kFXwpadFsz77jVGFXFBk+frwzXgF
 1H84Id0VbD6MIm3U+GgSkUMbP7c6DhTZM0K7gsEy/J7quV/YaT3SmK8w96L1hnKsK2H6Gn4QVnC
 M+mf1LpkGmKXkCE5kcrSkQf8w2Xx5HC2aXj30u4SRa6AqS1EQjTyLacRSutPQoCp9NDYc1ykt/n
 QhqWESzQotGYZxECiU9Tr8kDzkR7HGOkg/GwIXatKw+P5AqVF98A24orwTeDu6759EVnXF9pl/P
 IT4zb1blVcs1Ln0agfIc2AjfGNJK5/q+bypETlAGxOoCexy8EabjM1S4H1OMuSs1ekzST9DEGGO
 n99w76e1cV/b3OeaIpDtA9HnyXwDbnulOJDjFA5imCJikoIxL1GD/APxzjl1/6l8zbsQIEwvyLt
 xoxHDCpqx4E0BgFYF4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExNSBTYWx0ZWRfX447a/5UVdNpW
 a53uNlkILEmLUHIx2YloKut8l3ocaiYWWEjoqGausumRSd8RDZwH7uKwZkX2ElohLtrhfrduUdK
 pz60gGi2I+lxDrGeqwTavhU7Pr7UYIq0VLezYdLRVAp9PgpyZScM
X-Proofpoint-GUID: 1LihZ8LE7IuVRm9E1TAfl2YyVSKMuAQF
X-Authority-Analysis: v=2.4 cv=E479Y6dl c=1 sm=1 tr=0 ts=6a3d2bc5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=sqw2a6EB4MzhdGyKDHYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1LihZ8LE7IuVRm9E1TAfl2YyVSKMuAQF

On 25/06/2026 11:59, Jiri Olsa wrote:
> On Wed, Jun 24, 2026 at 07:01:48PM -0700, Yonghong Song wrote:
>> Current vmlinux BTF encoding is based on the source level signatures.
>> But the compiler may do some optimization and changed the signature.
>> If the user tried with source level signature, their initial implementation
>> may have wrong results and then the user need to check what is the
>> problem and work around it, e.g. through kprobe since kprobe does not
>> need vmlinux BTF.
>>
>> Majority of changed signatures are due to dead argument elimination.
>> The following is a more complex one. The original source signature:
>>   typedef struct {
>>         union {
>>                 void            *kernel;
>>                 void __user     *user;
>>         };
>>         bool            is_kernel : 1;
>>   } sockptr_t;
>>   typedef sockptr_t bpfptr_t;
>>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>> After compiler optimization, the signature becomes:
>>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
>> This makes it easier for developers to understand what changed.
>>
>> The new signature needs to properly follow ABI specification based on
>> locations. Otherwise, that signature should be discarded. For example,
>>
>>     0x0242f1f7:   DW_TAG_subprogram
>>                     DW_AT_name      ("memblock_find_in_range")
>>                     DW_AT_calling_convention        (DW_CC_nocall)
>>                     DW_AT_type      (0x0242decc "phys_addr_t")
>>                     ...
>>     0x0242f22e:     DW_TAG_formal_parameter
>>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>>                       DW_AT_name    ("start")
>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>                       ...
>>     0x0242f239:     DW_TAG_formal_parameter
>>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>>                       DW_AT_name    ("end")
>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>                       ...
>>     0x0242f245:     DW_TAG_formal_parameter
>>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>>                       DW_AT_name    ("size")
>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>                       ...
>>     0x0242f250:     DW_TAG_formal_parameter
>>                       DW_AT_const_value     (4096)
>>                       DW_AT_name    ("align")
>>                       DW_AT_type    (0x0242decc "phys_addr_t")
>>                       ...
>>
>> The third argument should correspond to RDX for x86_64. But the location suggests that
>> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
>> the parameter value is stored in RDX or not. So we have to discard this funciton in
>> vmlinux BTF to avoid incorrect true signatures.
>>
>> For llvm, any function having
>>   DW_AT_calling_convention        (DW_CC_nocall)
>> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
>> But for non DW_CC_nocall functions, it is possible that true signature still not
>> available due to locations. So every functions will be checked.
>>
>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>> and 875 kernel functions having signature changed. A series of patches are intended
>> to ensure true signatures are properly represented. Eventually, only 20 functions
>> cannot have true signatures due to locations.
>>
>> For arm64, there are 863 kernel functions having signature changed, and
>> 108 functions cannot have true signatures due to locations. I checked those
>> functions and look like llvm arm64 backend more relaxed to compute parameter
>> values.
>>
>> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>>   -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>>   +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
>>
>> See individual patches for details.
> 
> hi,
> I tried this version and had to choose another function, because "arp_process"
> suddenly started to show args registers in proper order ;-)
> 
> now I checked "stop_cpus" function which is added to btf after this change,
> I attached the dwarf dump below
> 
> "stop_cpus" has DW_CC_nocall set, so it has signature_changed=true and I see the
> function ends up in the btf_encoder with optimized_parms=1
> 
> but we do not skip such functions now, it seems like we should?
> 
> I tried the attached change below and it removes all the extra functions
> that were added in the btf with this change
> 
> btw I can't see any other use for optimized_parms flag, it seems to be
> just set and never used.. so I wonder I'm missing something
>

Thanks for looking at this!

Yonghong can correct me if I have this wrong, but I think optimized parameters
are okay, but only if true signature is enabled, so omitting functions with
optimized parameters should probably only happen if !true_signature. so for
the change below, the modification to btf_encoder__add_saved_funcs() is right
but I don't think the modification to btf_encoder__add_true_signature() is needed. 
 
> jirka
> 
> 
> dwarfdump:
> 
> 0x016f4b1b:   DW_TAG_subprogram
>                 DW_AT_low_pc    (0xffffffff813e0fc0)
>                 DW_AT_high_pc   (0xffffffff813e1133)
>                 DW_AT_frame_base        (DW_OP_reg7 RSP)
>                 DW_AT_GNU_all_call_sites        (true)
>                 DW_AT_name      ("stop_cpus")
>                 DW_AT_decl_file ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>                 DW_AT_decl_line (464)
>                 DW_AT_prototyped        (true)
>                 DW_AT_calling_convention        (DW_CC_nocall)
>                 DW_AT_type      (0x016e94c5 "int")
> 
> 0x016f4b36:     DW_TAG_formal_parameter
>                   DW_AT_location        (0x0065ad9e:
>                      [0xffffffff813e0fc5, 0xffffffff813e0fed): DW_OP_reg5 RDI
>                      [0xffffffff813e0fed, 0xffffffff813e111e): DW_OP_reg14 R14
>                      [0xffffffff813e111e, 0xffffffff813e1127): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff813e1127, 0xffffffff813e1133): DW_OP_reg14 R14)
>                   DW_AT_name    ("cpumask")
>                   DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>                   DW_AT_decl_line       (464)
>                   DW_AT_type    (0x016f3242 "const cpumask *")
> 
> 0x016f4b46:     DW_TAG_formal_parameter
>                   DW_AT_name    ("fn")
>                   DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>                   DW_AT_decl_line       (464)
>                   DW_AT_type    (0x016f2ca5 "cpu_stop_fn_t")
> 
> 0x016f4b52:     DW_TAG_formal_parameter
>                   DW_AT_location        (0x0065ae0d:
>                      [0xffffffff813e0fc5, 0xffffffff813e0ff2): DW_OP_reg4 RSI
>                      [0xffffffff813e0ff2, 0xffffffff813e10e4): DW_OP_reg3 RBX
>                      [0xffffffff813e10e4, 0xffffffff813e1127): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                      [0xffffffff813e1127, 0xffffffff813e112e): DW_OP_reg3 RBX
>                      [0xffffffff813e112e, 0xffffffff813e1133): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value)
>                   DW_AT_name    ("arg")
>                   DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>                   DW_AT_decl_line       (464)
>                   DW_AT_type    (0x016e858f "void *")
> 
> 
> 
> 
> ---
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 38455a4c6b6b..cbc5063a6280 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1564,7 +1564,8 @@ static int btf_encoder__add_true_signature(struct btf_encoder *encoder,
>  		 */
>  		if (true_state->unexpected_reg ||
>  		    true_state->uncertain_parm_loc ||
> -		    true_state->ambiguous_addr)
> +		    true_state->ambiguous_addr ||
> +		    true_state->optimized_parms)
>  			continue;
>  		err = btf_encoder__add_func(encoder, true_state);
>  		if (err < 0)
> @@ -1656,6 +1657,8 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>  			skip_reason = "reordered parameters\n";
>  		if (state->elf->ambiguous_addr)
>  			skip_reason = "ambiguous address\n";
> +		if (state->optimized_parms)
> +			skip_reason = "optimized parms\n";
>  
>  		if (skip_reason) {
>  			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,

