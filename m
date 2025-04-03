Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DA250C06
	for <dwarves@vger.kernel.org>; Thu,  3 Apr 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705633; cv=fail; b=YxLaxGQgxlxXqW+ywD10zwpKIg1QDXexWYkSaRDcAVaL+q5M9a70fEmstWmMSeWDWnyt6D1E5Y10UOz0hyrLYFaydvuSrOkKEv2VXLx2QxiokMtdLLxuldNmwUGT94cBRCFhqwvZ2/6dzJLLXmAgNgBvjfi6Dt4TjjFf5H6MkaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705633; c=relaxed/simple;
	bh=ehaM7kyqluFosW6HO33m8qHK1XZ/UMtf4o53eBn5lZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kC/AUKYU9cFqe+6Q7Co0ocbDj6UdYeQ2jG9qxLxpcSCmbikWp8JgcQNq+7TL6uIVZM5ipRlRSJ18g0bHmueqIcA2fji7B2CjM9tHpLMg1I/PiN4r91CHi89iwaBX3Rl0pdtYXtmkG0MlWP3caUfb5zqElP4/y+kwZo52QGKn5pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J74NC5NS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f75J/DqU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J74NC5NS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f75J/DqU"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533GJXqe011195;
	Thu, 3 Apr 2025 18:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XeWafHUKVhOqDQMtrK5u5tghC2qA/QV1Gy5lpgSsfik=; b=
	J74NC5NSFTbtbdezTbvvqAZKrXhGAxKI9qN21rVp+80UBuEBOpAnnwngEP1HFWKR
	RF8YXW3fYaVnFVI16VUlIpGuI/YP7oVayG92/4PI76sMzZfiqYJ+AqarCSjWoAjL
	WJ5HLkx423uIb13DvYIE6KbZOWImZ0inIvckN7iBr/VsIfZvc7PynN21FbUkPCvU
	K9uzhrHmS2GpJX/myaqX3u80N1cGiqU2zvLgmbFkRUHh5SUvTty146/SJuMJKdjy
	+hM7ch6++KdiRfyqEzPiqrt/rggbAgXaVrFi8jbcNVmtPEilZ2L0hyvD4rkvgAm+
	C3TM0wsJjLXUTrAOHNQr9Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8r9n9j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 18:40:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 533I166o018154;
	Thu, 3 Apr 2025 18:40:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7acjsw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 18:40:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFc7OkbMND9+AXH+UeUVHfTg7/nx31jqooVI6JFY41PAKxFJu9QxeSuDFbyYELQFZtMw2Sb3NEmp+l+7WWuRp6dleMQzaEAb2FZ9CdyGIMZGTFQpRzJ2Jc/J6uSSZ3swdJSn94b3zy3sebpwkBQUpGeLy8r3EuFi9M+8xAln148jdKS7nRzwPbCSgZPXG/BZWJysFw2eF/ODUKw9B9bADcRFQOofT5lRxxgCX+CaauPJTcDT8vblX8TSHWniHdk8IKsskTY8oqi9hevzl76UqFmg05OW7/GUmlR5zStVlTRfV/g5/E77BR80N+853dIV134Z7tWNnNU4COtMgRCYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeWafHUKVhOqDQMtrK5u5tghC2qA/QV1Gy5lpgSsfik=;
 b=sbMdbPu1kn21yPff/efa7r6Zo/UPcmo+qQ+3f9ir6DELF2EdIZUYgtznSyecIiDcXWbEiogl88Cm5vArJVLeeToUF6ktcMHHb4BJfkeyAbx/sGvezAVI8xH40+gc7kjabVAO6cXZVwfRpLuShv+ZLPT21/0W4SEIvFXVZ+qsSKhj+QM/ftECvxaoLyYUKO6Rh5fHjHfqXY3GmfpgV+SdHTxkTBauzktnqaDVhD5CCAzX7k77rJV51ITwPNhUnWxZvISqiQjew8X8JsZPIWEnLBPEWeG5zrYXu3NCrjzZPyvZuykPy885v+QOEbFElRRUEJR5MCSOx18WKol3EVlAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeWafHUKVhOqDQMtrK5u5tghC2qA/QV1Gy5lpgSsfik=;
 b=f75J/DqUOFXnIp+sYvnPNFU6zyrsF4Fm1X7hJjSD/6C7kHPbJemp8fEvFkXNyuRK2zkS3ez+NKsMUVyO6ML6B354o3lAcDFutZsG2nXoT5uCCBw/9w23PyESnaHYhshaulf8wCOSb3wf8SteFCVSgoLjgLzgsfuGR87AziuDteM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA3PR10MB7993.namprd10.prod.outlook.com (2603:10b6:208:504::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 18:40:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8583.038; Thu, 3 Apr 2025
 18:40:23 +0000
Message-ID: <a86ffc25-fdbc-4f6a-9579-aff59400d677@oracle.com>
Date: Thu, 3 Apr 2025 19:40:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pahole: When trying to encode BTF avoid DWARF less
 files
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
References: <Z-2fij_hUUFYF-YQ@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z-2fij_hUUFYF-YQ@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0019.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::32) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA3PR10MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd834c7-b747-4630-07ec-08dd72defe58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVFPRkpiNGRKbXplN1NsUGlVM3RFVktXOXlQOVpOYXdOWnBuazlaWDJFNjNm?=
 =?utf-8?B?RE10T2JGUzdUY3hrM2xjNVM4QkplWm1RREJReFF0d3VBN2doQTRnV0RiMnZR?=
 =?utf-8?B?ZWNoNlhuUUVMekV0TXE5cVI2YjdWbzE4ZTdEeGQxUlFSMVVRS01ua3Y4Z0Vv?=
 =?utf-8?B?QjRXZDlnYjBEUVgvVWpEdmZLeU9pU0tpWmhkZHl5aGJkWVdYdE9NeUZ3NHJk?=
 =?utf-8?B?cWM1TDBjY09BMjBiQ3gydi9zOVB5RElZNnUrdDhnZkJneXVjazdvMXlDZ2lN?=
 =?utf-8?B?TDJORzlsU3ZkRHdraE1LMjZzQzlrbTVvOUZpRGZmYTRWcEwyY2QzbHpCeTRH?=
 =?utf-8?B?V0ppY3JYTFd0MmNKM1ZDdWEvZXhpV1lYY3hBRkRhNDRWV1Fzc2xOT1dxcS9t?=
 =?utf-8?B?Y21sOS9PSjhIWHFDUHhkQTNUUDVQT2pLUzR5aUM3dlEwWEhTUUxTV2RqLzFN?=
 =?utf-8?B?dTRHN3crUHlRdUpnbzNYTnR4S2xOcFpHLzVNdmRvTGdyQ1ZJeUdGL2hLMlpQ?=
 =?utf-8?B?b2hpbHdDbE03UllZcnRNK2RlR01ldHA0cDdPbmxDbEdlWjY5OUtRS2NBSDdC?=
 =?utf-8?B?a3ZCZ1pXbUtsN1Qybm5EOVFwdXFyREtpQTdWb3BGYUY2NmVHRUVmMVN3NHg3?=
 =?utf-8?B?OFFFRVo4aytVUG01djYrTEFteWhGZ256bVRTWWREeHFJMktLOXpxOGZScWkr?=
 =?utf-8?B?U2N4aWVMZ2Y2eEFRaG9MejNMTjgrMmZuT2hyOVVpVm5XcnVEbnIxM21jQlA4?=
 =?utf-8?B?SE9QNUhJWEtGNk1IUG91aGtTOU5pVmYvVStjd3JBdWtCbUhCbjF4VmloL24r?=
 =?utf-8?B?VlpVWWlVRmRJSHhPeFJIYkJIbHB6U1Z1UnJ4WHVBaWx4QTRreG1mWjdpeGda?=
 =?utf-8?B?R3VBZjNXL2V0cCt1OUtWalFWYzEyK1hzU1dGMWVSd1MzS0M5YzVOOFNRRGxs?=
 =?utf-8?B?Y0xFdXpCWDlMZHRtZzYzRStLQSszL0FVc3JxaHJJRk1oVjhOZkgrMFdRSmJB?=
 =?utf-8?B?d0QyYUIxT2pIdkExUVpaTjlFN2wvRlR6YWlrOUJoTmJ3a29NVFJpYkZScmdY?=
 =?utf-8?B?cEtYTnlBQ28wSXVyclN5V0hIZ2VpcDlHSVYrWlZVOWRjUDNEY1ZVWTB2VE1E?=
 =?utf-8?B?eHBOaGoxK3FMWkJGbGgwRWpJbG1CSWJiQUVzMkEyTUhxYW55eXdjRWpsZ3py?=
 =?utf-8?B?dkQ4TnFPZm1IMXlWWGVvTndKTXR6Vnh6dlJGVXdmVSt6SituaWMzRjMyZXJx?=
 =?utf-8?B?Nm0wNi9neDE5Y05hbkU0Rk1WZXdkQm5idWtjRHNpVG5FK2tyZlBOcmJmVTVG?=
 =?utf-8?B?MFpJY2VNVWZkY2JIUktNQmdpVzZ0bGhSdWNtUHpLc1hZdktIOW1jWVBFV3R5?=
 =?utf-8?B?M2wyaGljcUxlNEFYeWhBb3VFYXRsU2pZOWt5cWRvVVVnZy9UZTc5OGQ0Z2M1?=
 =?utf-8?B?UGVVbTV4aEl3amFuNHV5by9BZkFwb1ZxemI2UXhjak1Jb3ZOYk5Id2lqRXpB?=
 =?utf-8?B?RTMzRUZzbi8rdktHZ1VRQjg4Z2x6WmlKYVN5WVdtMVUwWGlTbzNmaUQ5N1I1?=
 =?utf-8?B?SDJ4U0dIN0dTdFZKbG9OcTBhdmNwdFFaN3MvZ1lsNzVKY05vbzhFOVV1ZnRh?=
 =?utf-8?B?NXlSb0d4cVlOSjlhZkd6TFRKc2lZZW5zWk9ja2Jlc1c0bkpJY0JMdlBCTFM0?=
 =?utf-8?B?U0xYeXlkeXlXWjJuYU9RZldPUWp6RGFMQkxSd2dkQmkyMHl2U1ZiRy9MYTZX?=
 =?utf-8?B?ODNwS3ZELzhJWG1JOWR5Kzd0OHBqSHAxelZRdkxMVGRURzFsdXdVclorVzdm?=
 =?utf-8?B?Z1Q2dWprczh4RnlHeFpFZFZTc0FoSHBjRngvcnlWbjNCdnhPeTFuQmlxV01h?=
 =?utf-8?Q?JErZY/xRw5hsT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emlKbUdjZFJJbEZUbDBTYytuNCtkbHZ4dWVmVHZpcmI2L2pnN3ZJYTZ4NG94?=
 =?utf-8?B?SncrVlNMVmhvK2x2dXpRZE5qWG5GQ0NqMUk1LzdkK2Zoekl1VE9meEVnbWsx?=
 =?utf-8?B?T1dzQkRxU1pQVThOck1POERHNi92MnJZdllkMnIvaGZGSC9oTXlPNmhZUFQ3?=
 =?utf-8?B?eTV3MDgwRWRQQ3Vwa0J3SXdEdGZIRjZPSHk2dCtTOS9LUmgvVUdvZXBvVVRt?=
 =?utf-8?B?UGVNVkNGa2ZzYnZqUUI3WG5mc0Uyd0kxOHZuZlo4MWF0a0RMSkNLOE1xUHAw?=
 =?utf-8?B?dldCbEsvSkp5aGNVV1pzeDd3eFhmN3gzdFM4dGhMQzFsZlR4K2N5R0JVdE9Q?=
 =?utf-8?B?ZTdMMzZCb2NPWmQ0Z3F0eTZLN0I0UGhJbE1najExeVBlOHVMQ00rQXprWUk2?=
 =?utf-8?B?bEhkcEcwNnhVTERTQjUvY213b1VjZGVBTXJGY2FvWDJxMDYvZ25JNUFRUjFF?=
 =?utf-8?B?OU9pM1JibzVSblBoOUxwZmxkWUtVQ2FzRmkvOWt2MzlqWHFpeDV0UUtmUEZC?=
 =?utf-8?B?cG9LdTRpeVZxblpJbG1uRzNyVGVwY1Z1OEdyMC9mbWI4UEsxeHhmTHI2SXow?=
 =?utf-8?B?ejBGN09MbENOdllldW9FUlM4cjR1bkg1Tjd4ZkNTMm5vYzROaXVVRHFHdkpB?=
 =?utf-8?B?MnB6WXFwTC9abVFCT2RqN0x0TDc4am5hN0FDR21Wb0o2eGUvcEpMZnVVT1Ra?=
 =?utf-8?B?YkQzb3g4VEpCQ2l4N0Uyb3cwNmtGaFZveUNxbzBGbUhyQ2pzUkNNaXFtZHpl?=
 =?utf-8?B?WVdqbjM3dmgrc010RkFBYVBQOWFySzNuaXF4OHJJM3p3TUZaM0xTVXQ1ejRV?=
 =?utf-8?B?MDhlNDFuM3FMYjQ1dW52RTVSTElwSHJPSTdyZHllcW1QZXIyUjdxMVNDVFd5?=
 =?utf-8?B?Sms0WEsyRCtlODhKMmNnS2RmQ3MwZUVMZVhkTGFWV0dKQmh6dlE0OUhHcjNi?=
 =?utf-8?B?QlhUSi81c0ZMMWVQTWNIT3RXYVc2cllSS0VHV3JrU3pkYllybStFV1VROTVJ?=
 =?utf-8?B?SU5FZ2tjZU9NL1FBMWdXVmFZMEw5c3o5QjY2cTQ5Z2IzMzhRUmNDTzRFY3Zy?=
 =?utf-8?B?elFyUE1CbWJRTWxyRDNhU1ZkZGx3VkM0TmJEbnU0M3pGRFlHNzc0SzdDUGZY?=
 =?utf-8?B?YzRLZ1ZITmk0ekI0NHd0MklPOWwya3FiMDY5NVkyc0pPQXM2azdweGdPUFFV?=
 =?utf-8?B?V2hjM3RtNFZ6TGtjdU12dS8wSEEwOWlFVlVTTk1aZDJ6WTlPQlB5QndwYUhP?=
 =?utf-8?B?WXZvOExNbUpDUk1iSEp0M0tKRU5nUjFOaTM5dTdncGhReDlLcFVMYlpWSERF?=
 =?utf-8?B?c0ZJYmZjcnRWUHhYWWI3YUZZRGVpN3NYVFR5MVV5THJEWjk1R0ZkdWliS1ZQ?=
 =?utf-8?B?US8wRWJIMnRZV3RJSW85bjJhUjZMemNBNzgwS1NzcjZlVGVWbC9mMlpVWHh3?=
 =?utf-8?B?NndHZ1RRL2JaUnFtMXFHSmRJa0EvQkxYSTNKTDkxVDNsbHJKUmZkcGdROUhT?=
 =?utf-8?B?QjBDOVpQQUNvamFISzUrdEU5NDhjeXJxZlNFMVZNVG1NZnEvWU5GNTBTV2p4?=
 =?utf-8?B?aUY2YlBKOTlPR2ozUDloUjIzOFptOVlQdmxPTkVrcHZpU3ZXa2V5c3pqeFRj?=
 =?utf-8?B?a1phRnNlTEtoUytqbWNIeGZMdktwNWhhcVd1RENiUnBnQ2FsRC9HVGZ0T25Z?=
 =?utf-8?B?dEJ1RnVxNzB1WEZqb2JBWWtxdFljb3ZUTWk3aVFLWkdRbmhDbnI4a1hFZm9y?=
 =?utf-8?B?Q1dXMG55OGFsQy9aMk12bzdFMURiNkdFWktqME9qMW52OFRXUHFzQ0NoSXFy?=
 =?utf-8?B?blJNbXh6VDU5T1hKWXhCSU9EekRUd0sxL0cveVNQNEEvYXhZVXJHd09lNUtN?=
 =?utf-8?B?b3ZKWXdhNmFPMkZqZmQ0dEFxanRsSTQwZ3VYRjFONS9EWmZDYnVPTVlvR3Jj?=
 =?utf-8?B?UEQ4azhPSS9SOUFDSVJ0VndpaDBnREtPUi9XRTZaVTFtVmFaQzY2MzR0bFl0?=
 =?utf-8?B?cDJUbU4vTXhoQzZBSytBSWd0aXdBbjJxWHpJZWlISXBUYzRmenFUdXhRb3FN?=
 =?utf-8?B?ck1rUTJudnI3cXY4ZzFGbFJvbysxWGprREgzN1lFbXJMY040T1lyNzNPck0z?=
 =?utf-8?B?RGNrTlUyUDNSS2EyQURWRXJadkplTmRKU1JZK2V3T3gyMndhZERRSlFFblJv?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fWvCX2GXZbj+5tMmeXVeD9zswkzFXpdlrY8AD+y5llmlMzuY4vvuIEivZxc0pYt2Ggnd2F8A8LEtaFo6jc2vjFoy44+WGhlS/fuUJkRKEwm74aakfIrEq6h6BNkM4Mp1sTXno/8FP9rSN776gYnmZ25TUENnE/j8rdtXTxS+RXi6T4veHEtcwtoXk4Swl+a6J3guJfdVtHS5O3hcVNpub5l37ntrb/2Sr5lpIOBl0EUP8OrpKkcfOhojzpWRxZ4MHWrVf67pE85ulHDr42kH0cg1nvbVjqsy2DZkkY1TS2D1oH+HLmy4ERDd2f4g/oiKwicvwPOC4EKo8G2RPDCH9byQuk8HS6t350gFP5N9lInWGbvy3OLh9cLTy0jMnGL56j85BS0E5CK0iIyWnZFKafj3D1SL9xli880f9wBhIPesRPsVXX0ALfD0OsDsaveLSxXtkf/uqWBG7f6m1zwaBAOEVlQ4Z4pXecbzynTOjkT4/ej/uMpj3lfn+Nd0alLMyBMlaLDdI/7FeoxNZrwPQBSTqisNVZO0rOGLCTXlO32kACf9YLWvY57PVd/obtudlGS/WxX3BBNEj+aPjOTfwkDmXTPADdy8Dc5v5NeZL6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd834c7-b747-4630-07ec-08dd72defe58
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:40:23.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjqG99LFtl73KlHcMYSadLhYirywvK+UIaKp++CSHZljry6bWEPPcDSViuINZ+Fow6zHdfMXQzscE8I5htLjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_08,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504030096
X-Proofpoint-GUID: uuIeaEnxWs144h9LRA6IQTZNpvDPGHXd
X-Proofpoint-ORIG-GUID: uuIeaEnxWs144h9LRA6IQTZNpvDPGHXd

On 02/04/2025 21:35, Arnaldo Carvalho de Melo wrote:
> Make sure only DWARF is expected when encoding BTF. In time BTF will
> also be accepted, to fixup or augment info produced by some producer, be
> it gcc, clang, pahole or some other tool, for now, avoid trying to use
> BTF when DWARF isn't available.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  pahole.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/pahole.c b/pahole.c
> index af3e1cfe224dd14a..f247ff5e88feeb95 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3493,6 +3493,14 @@ int main(int argc, char *argv[])
>  		goto out;
>  	}
>  
> +	// Right now encoding BTF has to be from DWARF, so enforce that, otherwise
> +	// the loading process can fall back to other formats, BTF being the case
> +	// and as this is at this point unintended, avoid that.
> +	// Next we need to just skip object files that don't have the format we
> +	// expect as the source for BTF encoding, i.e. no DWARF, no BTF, no problema.
> +	if (btf_encode && conf_load.format_path == NULL)
> +		conf_load.format_path = "dwarf";
> +
>  	if (show_running_kernel_vmlinux) {
>  		const char *vmlinux = vmlinux_path__find_running_kernel();
>  

LGTM

Acked-by: Alan Maguire <alan.maguire@oracle.com>

In the same spirit, should we error out if the format path is explicitly
set to anything other than DWARF for now when btf_encode is set?
