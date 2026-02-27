Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF943C056
	for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205547; cv=fail; b=kXsIHVG6uphKhKumThVsu1Tlkvn5A+RTKZKKzmNPO93Duj7sXt1MrLe3jrrcDd8MP9iXT7mqX0M+xxJglSbVXmR3TeReJL9gCVW0+lxoraKNE5kBYKguuKrrh57WhSRfKa7P3eyE6bG9J0+QAQsK51gMgvwxBbH/dpluwaq3W40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205547; c=relaxed/simple;
	bh=IjYQzJZb36mt3Tlr40EUR0YezxV1kbnB9p++c4FbhGk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=olcCGbPANCD36TA8ts43XDBCWkElrv21NoIl9IXrSN4rtoYNaViQcahEbc72/zz6LRXUzm5wpVCy6q5O6PcQdrsikYYudjkFJja9hpvyrlvr1RhlCjU0eEzBIu/+5dEwzY+RrzQbVEwm9NGfQqktCwKAUK+MUz/jtabiGTYA0Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bLCfmP0N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nisfbFGc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bLCfmP0N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nisfbFGc"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RELDAs3019789
	for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 15:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HNOidrs1E/6+L/UlxoV1lQck3DO7V/THTJme7SXQQ0o=; b=
	bLCfmP0NKIY3npVW3Qz9VxnJjHfpA0kInX1JuqI1d3Fgh1P27l1PHq71IxbdguGZ
	LbljsiNZnpLt5o6MJGRQIuFMlpP3ImkLUKgX/1+usBpYm8iUQx5/GUxPcPzUFv6e
	Y+52lmHjc1UtBvlk+8W/chYCVeXm5zJKDW3rcjyp+LOlYSw5w//5baGMV56TY8xr
	uWTxLQINvjCnoRn/O4PStJZjC9V+wx9ZZ6O25r0pAOk2RF+lLorJlJSkqGduhG6C
	5Oy9Ymvx7CkCvz2Mo5rkAzoNYBBqQAxWA9vu7dcdhg836x8WFX1Xb1+5kqT8q2xS
	us07TvRxgvYGN2dmc0SAYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgjfur36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 15:19:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61REnbxx005093
	for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 15:19:03 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35r8frn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 15:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UefDGUdDF4Ugwh9FFR0LJGCj44ERMKL0aDJDwah9ldL/QltbaWb5Epu9TLqKNgSBeYz5TTIQLzY8qv8cF+gnlxKE15FOjIIk6Y//eLhhGj1vffYPhtVzpIj8cGgm2hFYoJIZV40nCRURPuGsWRmwcP2ynyNb1ey48Ab9VcCfeRyyl1E3zbn4UrhGlDMp7NtoYK/YnXa2B59ZP7q/bcuEEu1Ys2XBdQvK3M2HieZbukU8+dUmf3+Rc1dPIfN3D3EEeP0n1UJPfHJDfiiQF+6Wn9jN5TEERq9Ws9ONUaAglmsd0tVGCYwAhVxYKVWmXxqfkl4v6Y7gCjFtGyevjLQb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNOidrs1E/6+L/UlxoV1lQck3DO7V/THTJme7SXQQ0o=;
 b=yTtN1O7oW/DOMzGuekQyXm6WCJWrcHCc034zBAR2vvxK0okjsayDw2+GlbUBuavGvG+J7bKGSOi9s8ZXw+tCkNIj+TVWs4AUSBsgy/Ndx3MaF+N+SwUW5dfmS2K4jhIAAnNo4Pt9bfLI29tpI8Lb7tmZmk7AAC8B88sbghRIhN33LqRNYZDHT/xcS2xRrYkbOjXjT20K3KbS7u74ZERDUPqUHMfD/buD9UUmm2GWzgoFJ1ntVM4qp0MHM+aDdLLScUQWDzwYjzDDvo8hwBqizg8bP4hewnN0Hf2jg47YAwdMqZ0CMoaGeH9DlsK08Lg/SSt0RDEjObp10gnZcW2MZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNOidrs1E/6+L/UlxoV1lQck3DO7V/THTJme7SXQQ0o=;
 b=nisfbFGcS9YQZGMRirncE9wOma84TbdIwOXdVun0vqf8uMhQr63BKuhwmjUdu1sVdHnkTlz6YQCny4c/1u4ezy/GkKK6O8A75o5uyhK4S95SNEw70Hk8rYP2Xm4Bn8XLoiZ36wPIQR5jXxixmlnSZz+Tdp8uHdlOarwgpDh75es=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB4422.namprd10.prod.outlook.com (2603:10b6:510:38::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16; Fri, 27 Feb 2026 15:18:59 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 15:18:59 +0000
Message-ID: <bff6256f-37c9-466f-b8c2-0fff09ee0e84@oracle.com>
Date: Fri, 27 Feb 2026 15:18:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_loader: Fix warnings due to type permutation
To: dwarves@vger.kernel.org
References: <20260226075805.1901714-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260226075805.1901714-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0091.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c0f189-2c2f-4af2-7a3a-08de76138823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	lq53m/UTUUwm55j+AH4qWqF6e60Z3D0Vtif0Z56yJrw3UWaCwLoRpx+cPY6z9Dh/eBNUYYqf4S1yK9ayg2mSNI2uStGeydeELtQKd2G8KE0gI0R5QQXxiO0/rpRVjOQv8nRPJkknLkuXpq07lhMR1pb/NGyLUVSxUO2G6An3Jg0maPVd8yoA/IhfDYuTYl9WsklaYHj9vxWDwxbwn1jeshoQAAkv2WMyS5DkhqeqSX8ALFRyycijpAQW0oPKW4mhPpWvRhcyKM9OvFSgfQud8LXR2CsYGFM2x9lDeJyUJKREuCdIjYIUZAPpN6ji96uliJWC4+Xi0+awTd2ssns069UpAuxcdc1bHJN9Y9m8WrCrYEsw9YxzmCN20/vPoaXFoSndgEJAsuci1aB1YbK6Imv1J24Mn2WBo/kWZqo+sjpY5BjxhFUc5eQgYCbHiHQ3mu69FtKSV74Xd2vtMJOvk/waXhejxED7T6GQp+empeVNrf+0c6n/tYSha2FVMkx3UZxrkN8fs/kx8ex7qxQxdflsASyKdu5g/b1EfxxfIXfNP4HvrelC9ssQ7yD3Tu9D36DrMCsw9aD/kxj7N6wSjo0CnHJ4UhxFe+Gq7pQv+npDgU0/YdJPWpgTH+rIqZPI4LZLhdVhdDO83dU633aQRE03ok6xcHEoX25me9dH2UQdk9ebwTQuoBh/f/QCicTLUFwh0PGuSLV9s+7fmuQJPnmS1GP+7TYkglB1jEsnGJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmFpVzdMblB1UEZMK2FZdHRHMkdrWlVURUEwdlRTeUNOcVVPcS85WHRQMDQz?=
 =?utf-8?B?OVdQT1l5RlFCUDk1bytvQWd6ZnAvZXFlMHVXc3hTOXZCYi83NzFWWUNHTWNn?=
 =?utf-8?B?RzBCRXp5blZXZWFEcEsrZUpqMWl6dkwvdjdiU1YyK29iYmlVTzA4MzVWME1T?=
 =?utf-8?B?bFAzWkovVzF0WSt6NkJMMkVQa3poTHVmVlVNSDdZeENsN21HQkQ3anVCQVR5?=
 =?utf-8?B?RW84aThISHFIelQxVno2akJEY2JSN1ZnM0FaWGs3LzhteVZaRVVjQlRFdW5r?=
 =?utf-8?B?Q1R0a2xhaGFjdWJ4UWF3UVRNMjdXejYrYnlNUTF5blVSUXNjaGRtMkNTVkhJ?=
 =?utf-8?B?YTNFeURNeGhUSHMvOTJ6VFhrQTg2cmk3Q3RQNVV3eldpc3NZVG9DSmhlSlcv?=
 =?utf-8?B?ZVpMc3J5ejRuaE5YNHo2eHFXL2ozcVNLZWtHSzVuQWxFVkw1UDhwYlN3N2k2?=
 =?utf-8?B?WlVkbmpVSmdKbUxIZGl0eFdIanRpYnhmcUs4Tzg5MVkwcGhGVmh3ZFYvYUJL?=
 =?utf-8?B?Y3J2eEFRTlNQZzlNM2hxOXd0ZkZnejF4TGZUMVRNSGVPelhHR0JmV01aeVNv?=
 =?utf-8?B?NmQ3cmUwVWRpampiMjdpWlQ0RlBxQUtyT1dmWGU5TUNyNlY2WFNiczdOaHIy?=
 =?utf-8?B?SmprOU5Zd2c4dGp1dUN0NkYvNTRHYnRyWm1zUGw4bFBoWlh2Z3BiOS9HVlFP?=
 =?utf-8?B?MktVbzJ0ZFh3MDNWcHdEVEJmYi9wRjlDUW5sVytIdWN5cE1VVDNSSmxTOUtK?=
 =?utf-8?B?QkNmaHFPdDhpM0oxblFxeFhPV3g3Sk9oZFVXREl0RVEyMXJIcW0zMzlmNnVD?=
 =?utf-8?B?NnVZdDhJUjdmdU9DcGNIZVBVUEZDblR0ZnR6TXFYTkJ5MG9TaElkeG5Xb2Y0?=
 =?utf-8?B?UGMwcHluZDc5SFJvdWZneVBlbU82NytIamU4bDVCeGduV3J1c0RMNTVZVjhz?=
 =?utf-8?B?OHJwSE9GK1RlV2JhWmllT0oxeVUvSEl4RitBNThIc2tQdkdqUVlocFBSSGg0?=
 =?utf-8?B?WGJySXR3T2NGNEsraEFwMVhNQWVlTnQvOTBIang1STBOd3h0MHEvTmdvZDlw?=
 =?utf-8?B?WkdxanJEMVRPS1U5RGxMbTZyWGVJSVFaWm8vS1BpN1VxRllDNGFVbVhCeWUx?=
 =?utf-8?B?R3FoL0p3ZUZhMmptWDFnR0lqaXNiYk56ZHJZZ3hzMVVOMWJoZlBRYmVKMlA2?=
 =?utf-8?B?ZUxRZmdLS25xdndta0FnQldpZUxiRVVsZTVrNmVnWVBIVzV0Ujd5ckxYb083?=
 =?utf-8?B?MTZrcWVZK0Z2UGc3L1JoYS9oMjkzbjZ5TFE3U1VRWjFkRnBZZ3dEdmkrYVpT?=
 =?utf-8?B?MU9Ib3hzbGlPSFUyYi9pZmxIOVErNkdXaG1YWG1XN09xYjR6TVhhQW9zYjdD?=
 =?utf-8?B?RmlPcjVDQTdDZ3UzdFgvWWxodEZJWWNITHZ5aEdmNFEwMGJNWG0vS0ZGMTdy?=
 =?utf-8?B?SGZDQkUyOGExUnF1UGdIQTIxQVF1MU1rWEowUmpYVnc0SmZuRkpqSW9yeCtK?=
 =?utf-8?B?VVdmenFiY1dsdnJHYXkwTzBRSmhZcnhEUWRWeUlYbGNrTlRMZ0w5blJXU3dE?=
 =?utf-8?B?Q1lHZEdlSVdlRFozRWQ4cUNSd1drdFBpK1lpRkNIOUJxb3VtMzIzUWs4akdR?=
 =?utf-8?B?TDF1VVl3Z25SZTN3bkY3NVRkeW5XMmM1S3Y1SU9TUmtWMnZCL1lseFB6eWpY?=
 =?utf-8?B?VHpnT2o4SjdqanQ4SmllM00rQVFlMjNDRWg5QVIzbVZBd05tdktIMjJTVnl2?=
 =?utf-8?B?M2UvNHdEQ281Mm9Dby9pOTdHU3FsNit5bWpUaUVkVWxrenA1aEJDbjdodnNt?=
 =?utf-8?B?eE1tL3Bud0d1TlM4TXIwbWIwMTBEcm54STlpWE5ZYk1EamhZUnRJa00xdFg0?=
 =?utf-8?B?SHV6SWtJWW1oT0ZwRHJ0SHZDcHVFamdmS2sxZHNXNHpsMVMvNXRLVlkrRW56?=
 =?utf-8?B?OTFBOUZHM3kxUmdiQW8wbzdhUDc4aCtSenUyTGllWThQZHRtbHpSdkxhQ0NL?=
 =?utf-8?B?WUMxc1Q3Uk1ncDRpdGpuTTVEbEcvQ0VmVkE1R0hIU0FuNTM0MkpCQy9wMkRh?=
 =?utf-8?B?SzVrRXJ4d1Z4WmdLQUI5SVBHT00zZXo0Qmt3elBwaUlxWEJnQWdic0hpUkxU?=
 =?utf-8?B?OExaTnZqTGN4WGtOSnRnY0ppTVZzSjREdHBqRjFRelh6eTU1Z2pkWTZndUhK?=
 =?utf-8?B?OTdRRWhHVGpZNVUwaUVjS25ZK050QTBDSUtmd1Rjc3U0Zit2ajdpL0N2c3JV?=
 =?utf-8?B?L1B6bzVHYzE4cUVHY24zY05yNVdPclRMVkN5Vm8yYWdmQlVtWTE0RjJEUGVo?=
 =?utf-8?B?SFY5cVVLUFFCMVhyNUh0K0hUVmwyVmNtZnc0dlNOR2lCQXdLUTI5Ly94c1Nm?=
 =?utf-8?Q?LK7HsewT8q6L/UFk=3D?=
X-Exchange-RoutingPolicyChecked:
	siKvR/Sc+qZkviSMrkizsLqPVPr63WnXlH9tNxqeQ8Jscp1STzHena3g2dYNREh57G5lBoIcyIyqT2DoFU0T7hLR2sZ1tKIIJ1hmIeBVxnUirWF2AvMM2BMl0aFuVd8P9+VEQ+ia0enXZdNuzjhLQfcUJSQ8YZYvyUdzyRVD7cuwPlChkF4ZfAs5oDLTEpKF5jPNXkeT0l4jdf2qDtolSeMAipdpSH0eI26g3+fBozdjpfH1csOXacKSb8nVxsZOPddlDUpf+pU4YeBXEYx1hKp7sfwpOgZhbfrvCyBZsyD1nkUz1mDZ1xkcJ6oi7AdAWVbyNEB98I0R6JJ8SdFMUQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ih8tKL3A0bxG/aIoSxDlnMIlH3+lnBKm+JlOgfZOEdvom6DssVsbvfnSVhFXPrbg/dEzTWNdciUEboicH8OUjfrVwzgX2X4tpMclUuA1WcH80If95MskYRlr/mPYFedT5JCh1DNcIwwqNFBRiV+B0ajM/N6VI1sEbx6QqKNuOAZ5+TJiLKUQzbI7eM+BxcoZ/mBlTvRU/P4TW7WnFcrhQeqFeLr8fSz/BwXFaHer6CPb5uD0Fp1JLyF4gsO/Nsbf1LQmWbX3qMdAdJAPmyTXFgr/qL+DQO9u4faBcpyTL5RGGyXwNCCrN5k8S0GNJ1gqUKX761STpHV9jHkCjPHwNJCwSrzui++8Ix0KFdAuFimGZFeuIygMQrgo+fUO+gKWoi8MNgm6gJ/asoG5znpjilrOkQ3VO6zw9WA7/vGFX108LtqataTQwlI9nHJKLINn2zQ9F5NGRsX1XDdJ0IEjoTsTVVsW1hst/BYMAR4HrFFYztjv/WJiMFZ4rHeXgcDK5BD+gkqFW3jaxQfX+EIJAPB9ekeUh31DxEOawsfhtlMrQqRDWBbqS8HwuXfj5dxP7xPlTzhnqAPH52TgRmP0zUni07rrCFvwJziwkmTKMmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c0f189-2c2f-4af2-7a3a-08de76138823
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:18:59.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ4BsCsYgw2pp5c9MRxhHc/62wmlrKI+ionKhoAKYHc1PcvdiZhUQuSMR5YtFRo0MqJqF59ggVx1U2hQTIflRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEzNiBTYWx0ZWRfX3NJW/wegL8Xw
 5/EE9ghz8AukiDJknSuAXik6OR5BexBrTf2cSvoQ52dmQfFcmbMMEDCbUYJoQdT5G7kOuhjQLcL
 8p/0R8d+/LWUuW4BvggLma1gtBGGyYos0Ppxv1QZgH/Us82N7T1ZKSZWqkyirExi8/YDrod2+VZ
 t4ATGaxiw18rXzELQa70IHsQwRUjVEtixstgiveQBei3IdBR6bDqZpy06VS0U32n6UDrZ1r6xS7
 LI9Tdrl379rf4sMbzMruSuN+qZVX3pfsf6d1B08/VM/GGmLWspYm+1gFKhjIfrN1y8IUEKe4izs
 VGQxwZYTNiCLOsTKABeFkHSdjZUkeBHdYOQ+rCEDveSdL1ttMLeSyFN2uqfw0+prAT501JHoFsy
 +n/YIJVFbcUGyc8sUWSzJ2Al7l0OySRDmc7sTQb4VICAPc6b8dsKyrnWOlBMqSB9ikvRvc3v418
 GbHHGZw5Ka4onCpJEM2WXk9valuMkt7lqNwrFaEE=
X-Proofpoint-ORIG-GUID: plPkQkJ2DJG3SCGTcIbr-4B4BjTVDMkR
X-Proofpoint-GUID: plPkQkJ2DJG3SCGTcIbr-4B4BjTVDMkR
X-Authority-Analysis: v=2.4 cv=L/oQguT8 c=1 sm=1 tr=0 ts=69a1b5e7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=q5doTdf-TxyS2zFDVmoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12261

On 26/02/2026 07:58, Alan Maguire wrote:
> The BTF loader implicitly relied on the fact that decl tags appeared
> after the types they refer to, since it looks those references up
> and adds attributes to them.  As a result, when a decl tag appears
> before the type it references, we get a warning of the form:
> 
> WARNING: BTF_KIND_DECL_TAG for unknown BTF id 61909
> 
> We see this since BTF permutation, but regardless BTF order should not
> matter.  Other types do not rely on looking up their tag references,
> so this needs to be fixed for decl tags specifically.
> 
> To solve this, simply create tags for all other types first,
> then handle decl tags.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Given how annoying these messages are, and that they occur for
both pahole and pfunct using the BTF loader, I'm planning on
applying this shortly, so if anyone sees an issue, let me know. 

Thanks

Alan

> ---
>  btf_loader.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index 64ea680..b591219 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -505,12 +505,13 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
>  
>  static int btf__load_types(struct btf *btf, struct cu *cu)
>  {
> -	uint32_t type_index;
> +	const struct btf_type *type_ptr;
> +	uint32_t type_index, type;
>  	int err;
>  
>  	for (type_index = 1; type_index < btf__type_cnt(btf); type_index++) {
> -		const struct btf_type *type_ptr = btf__type_by_id(btf, type_index);
> -		uint32_t type = btf_kind(type_ptr);
> +		type_ptr = btf__type_by_id(btf, type_index);
> +		type = btf_kind(type_ptr);
>  
>  		switch (type) {
>  		case BTF_KIND_INT:
> @@ -572,7 +573,9 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
>  			err = create_new_float_type(cu, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_DECL_TAG:
> -			err = process_decl_tag(cu, type_ptr);
> +			/* decl tags will be handled below when other types are
> +			 * loaded.
> +			 */
>  			break;
>  		default:
>  			fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
> @@ -584,6 +587,22 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
>  		if (err < 0)
>  			return err;
>  	}
> +	/*
> +	 * For decl tags we add attributes to the tags associated with the types they
> +	 * refer to.  Now that other types have been processed, we can do this.
> +	 */
> +	for (type_index = 1; type_index < btf__type_cnt(btf); type_index++) {
> +		type_ptr = btf__type_by_id(btf, type_index);
> +		type = btf_kind(type_ptr);
> +
> +		if (type != BTF_KIND_DECL_TAG)
> +			continue;
> +
> +		err = process_decl_tag(cu, type_ptr);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	return 0;
>  }
>  

