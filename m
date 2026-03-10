Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977635F5F1
	for <dwarves@vger.kernel.org>; Tue, 10 Mar 2026 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139137; cv=fail; b=KpG57E/Vkq+XY4SUZsmR4xffCcT/K+DNaemaUeDJPLuN1oiZeSRwUzrbz5RD7S/ktG686IS2ELxYwXeElI1BHSCLlBGxd+adwTsh+9IkeAFRJzJJKXRfWlxQi77XN+2+20FJ12UahpXnP5BtJBTGHchvZlyiq5CkQEzNG16LuGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139137; c=relaxed/simple;
	bh=+w8ejZSLUlaqg8g731YXbj4kczO0oigYF0WJrGMn49k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yz9QXrwrLMX89lylDwbzP/YgLXM261U/Uyblrb8dprzjue4iAq/hZ+L+MPT+7/qXGjmcUNnsAtQ5MgyGRcYSORVXgpEgYo6IznO6ci1pLDS+RE+k+4ROCu2EFFZsnme1vkJi7KcXXwjJOYcVm80wQupkGL4W+7eJE0IXeV9ZAxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MA1FwZNA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pAVKA/nB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MA1FwZNA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pAVKA/nB"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A0aXuB3216075
	for <dwarves@vger.kernel.org>; Tue, 10 Mar 2026 10:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DbMGLUCDv7LNAJMABNrQtHpUXuvzo3IYLh8ne8lQ9n4=; b=
	MA1FwZNAMYtIlOdcvsqIhPj1gpYo5TUTT2vwx29mOK9r2AykOQZOAuzcYLfYqQZu
	oAXqx5+nQUOyv8rxjUJQV1OKlEnLcC4kn0KJ7Qldih2vLTxsmacnYmQITiVDUHyh
	WUo7EH5H6/eoEn3p5FgOj2WOkP1ktQjHWcQtIyvKXZsYtYOt75J/nk95Pd4DBxzw
	gFraaxWiyfWrcLohY1pP3id8dTZyTZBFpxV5wo5USbQi1EZbGLHX8Ass/CoLn8uM
	QT+xosGZdj3fzDp6eVUrUyFCoz5iQey7AqwgAK+xHJn6sIQWxQ0O89FwoKFBMnjZ
	cSRZbjQZGFD5qoCk9kSQAg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csm9ctkus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 10 Mar 2026 10:38:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62A93M2R039578
	for <dwarves@vger.kernel.org>; Tue, 10 Mar 2026 10:38:54 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf9y7sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 10 Mar 2026 10:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8vMATbFpqxsneBavR9JU1oKKnEr5l0PofwMODC+Hc5fPs9dbvytg1lY/qwF+m6kZk2JuITD+t5xUSHP/uimmJMHAhdRbi7jcxd9bXN9qrWUFrXHrP4WhREjxjseLwYEwfqtyoPaWUcbqo0EVRxqzMXGdAoLj/dk8AN/4CzsoDtT/o7ymiiiMQYQWenlynDRVGK/Of/37gVLuIRP++m6wXHGRNBS5UY8PSUR5TKi750l+R8XqaVcqC9B/+SLzjdyZLvqs8K6qPdoaWKrsf6Y3XnBgavhUWnI9mgy12nC7BhGpkckEnMT8RleQhGHIqdAbDfrb0Vz0QUOOnEXILZyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbMGLUCDv7LNAJMABNrQtHpUXuvzo3IYLh8ne8lQ9n4=;
 b=mY3t+Pv1E6BXTw6PBEVPR7LyybkbZc3niJC6HcTsA35IC+RtwElXxT9PchmVPu5ja6H8n6mQH2z8yXc1rCc7DTsq45oYWD4o5NCrHhMhL8caV/3eNBiKo9diUvMZ7DZRNsvQIjc5EtLqRZVGQEnrDQt2BCRoCpk7+LjYLchaf/0LLZOQ+WWwVTFFC1Sr4zgCuTmmSHBTMq0F/y8RJ1SCYctVh9YcBaBa2YLUPpJzXeeyMy3lcPMc1izgWMvcwPtIIzCCVzraqH04NCjdJtSMIRp3QBJoEt7/nNS8baycCix9U8UXRbDVVDeEO6sWqtClj9hT/cVizykwIzdF7Nd9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbMGLUCDv7LNAJMABNrQtHpUXuvzo3IYLh8ne8lQ9n4=;
 b=pAVKA/nBrYIifyVfi1dG5H+R5VfPz8C1JePBrnXAb7VJkVvr0b5w2P/LhzDpLKqNxSm6PyOZkMWmXAk9ixh7eVlP4povB+KYyzOVGysnzIIUvwqvuo+pUApXFOVCbTl4KHRikXzVY5f9FBQ7U8Ar/lDsMrpyyh05l7A0/tyFAVE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 EAYPR10MB997828.namprd10.prod.outlook.com (2603:10b6:303:2c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 10:38:51 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 10:38:51 +0000
Message-ID: <32f1d292-bf0b-448d-ac6c-bcd289df4fe9@oracle.com>
Date: Tue, 10 Mar 2026 10:38:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 dwarves] Refactor selftests
To: Bruce McCulloch <bruce.mcculloch@oracle.com>, dwarves@vger.kernel.org
Cc: elena.zannoni@oracle.com
References: <20260309205643.1985134-2-bruce.mcculloch@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260309205643.1985134-2-bruce.mcculloch@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0049.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::16) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|EAYPR10MB997828:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a49afb-4b90-4c67-4c5d-08de7e913837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	KXMdQm27paCzoOxem20Pp6U0f5OgGHaL5ArnuZKQN/NWivgF2cFoQfJemnOfDJtIyCoC8r6ZgUvyy1Iqn02QUsUwpYGN6fSOGassesNkZW2S7Y5obktFKnX2ozRCjZ/THpX9ZqG+YF7dxuadi7xZr7UgydBbirEqAgugowC+AYdi3PtirZuB3NSiKna8z58wox9S+4vdaMWMtRTNmHu6ltdaEcLyTgxDrkfbGdIsBIQM8UMK35aIJ7P6CYyjQ7daQ8OmVOiWkYPMjMG9Lct/VFAxtR1RzAlMJhEuTsxK29/Vr+3Y6xEkrTWtv1hiIVG3Mz1Ux43HXkbhyGd6dObKD36JxyZZ/YDlv5oYmLrokfNrTbsWID0G8tdY0hp+imtvA5Kz1jp3P6cwwKZBrdV/Qx/LVgb/8ApdSmhJb4Yp4JIfWSWr0L8cN/+Mvu9bSfhAZZcO1YKetthIgF8KYTDJJCEddu55FqUeaRv7L/xizcexo89uhmKS/6qafFP7wzLcDh7m++fpGItamqjduY0eMC5e5DW5mrHRNHbUOyAnkz7FtGuVYcSE0DdXSXwqe1auLASiiMCSoVLR+xQgO6uJbhrO3bDoBfR+1gvWaJv15KPtxMAqJmoE0dqzKk6rz2OdPyxdsjGVMsKFmzxdwNXac4tYCrMGX3VWspUE68NCqKZ/T6fSgXz+KCydvPN2ewG9VPEHFAVo1tiEqRzzMBLYsnZiOfHZX08p4MYXa/h84+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEVpeW1aYTZPTnE5Y3N4ODBjOVBTVnBDbFVLWWUxUENuM0ZsRG9hY3BwWStB?=
 =?utf-8?B?SE5MODJocUFuM2c2VFVRV2lGWjY2YlZmbzExYklrRjlGN2dJUjR5QjZMSW84?=
 =?utf-8?B?UHpXTUlZcWp0RFJOKytOT1g4dTFSVHRuVkVoZ3RpS2hIYXRmODJRK0YyYmRl?=
 =?utf-8?B?Y3JzL3FtNHZkN2F1aFNFVHhCcEFMbWs5ZmJCOXdXcjJFVFh3ZUlUQzdxTUI1?=
 =?utf-8?B?QTU2dGxVZHhvUVoxN2VoNkFOWWJ6bmlkTkhldUlOQ2JCTk0ybHZOOGdqMTY4?=
 =?utf-8?B?aWpaeDBYMFJJOHM1MGFUN2owaHl6aUl2VWFkV0ZXanFwRVl0NEd6bFFPMysv?=
 =?utf-8?B?WHNVV1U1SXhHUHhXMittaWZadElCcEltWjFjb1ZXajVicHZOMFJxbUNMa0Jr?=
 =?utf-8?B?UW5EYVJuNWdPb0hHV3BVU3kvTWNyeTNSL0lhS2F0K0s0elZyZzFIMWY5SU1i?=
 =?utf-8?B?SHhWSGVIMWJiUXNCOWNIanFZZjc2SUFqcTJhTzEvL21TZkExTi9yOU9ZK2RM?=
 =?utf-8?B?aW9vZEk5azByTjJIR0FGUU5yNklkbUlqU0d0R2RuTktJVHEvZlloeERSZXkv?=
 =?utf-8?B?WVFTTlUwdFBtZUliOHlQRVNOenMwTjhaZFJIcWt2dEZacWpTTThWOEE3TS9k?=
 =?utf-8?B?MjBhd21FdEdFWmxiVWUwNElzb056RVdrZEJZeWRUb0hjMkRFUEFMYmNPOVAr?=
 =?utf-8?B?eks4QnJGaUJQWENZdlhEZERHTHdOR3NLM2dGeHEvUllLRnRveVR0Ulp2Mk1U?=
 =?utf-8?B?UDdsclNSb3VERjRsRkpScjdyUjJxKy9hdTFXbmp1OVlJQVF0UXVsTmdGUTQy?=
 =?utf-8?B?UXl1VG1jc3VSa21sUXV2czdKT2N6bUVlOWdlTjY5cWNLWGNpSWo1cTFXeUVO?=
 =?utf-8?B?MEd3MHFhWlVPeFFmR21EZkVpNFRiSFc1YnVZTGZmRjFKZnh6RWIrUTlFdk0x?=
 =?utf-8?B?dG9VbGhDeSt2a2ovT1ozYmpyS3FmWFV6Q3lBcnhkZkcvSVVqOE9QdnB3MVdi?=
 =?utf-8?B?d0lhR1NQUm9NanA5eE41Qm1LVm1jb0VXTER0ZlJZaW84ejNIcEJnNDZ6U3pu?=
 =?utf-8?B?RE1NOUFYTjRldzE0SVJwRTVQM3RLdHQ3V2ZXU2k5Y21HYm12dHY2MXoweVJP?=
 =?utf-8?B?QXZzd3JZU3B4T2Y3UVFvOExGZzNBTVAyMHJsQ0t2VkdGbUFFOFpFQXVPVUc0?=
 =?utf-8?B?eDFMcmlERjFiVHlCNTJsUERJaWI2NG9XMENSNnJJT0FZVU9BdE1TKzBRZUJ0?=
 =?utf-8?B?VkhTSHZUMWZ5WW53dkdQUmg2YVpjQWNkMUxTM2ZNKytiRWsvR1lTRGVvYjhk?=
 =?utf-8?B?RndaRHJVYVQ1NU5PcTJyVkRWd3ZzNzFDOVRXd04wNkM4dUxOQUlWRGdRZkR2?=
 =?utf-8?B?SGx5TEUwb3U1bnJMUGRYdHdnQ1k1KysrQVY4Y2l2TWJYTWJiQ2gzcEFKWExE?=
 =?utf-8?B?c1lOelZUQ2tzZUZVL01XZWJzUEQ3U0xyNVp2YVV1MGtDcW1qNkU4VnlEZm4v?=
 =?utf-8?B?WGpCZHYrVi9sR1ZEbW1HMjVNWFVteUs4Z0NTSG1HMXpvYjBkNmphZDlZU0NN?=
 =?utf-8?B?NXQxeWVXaERPUitqZ1JtQTV0WklGa1Z2VlFoZExzUk45enZxaEtxY1FHUjJt?=
 =?utf-8?B?MjFzQkNRRnJxSUowTC8wM3RTZ1UzcGZHVmVkMndhMXpjVEExTWRoeFovdjAx?=
 =?utf-8?B?ZERGb0t1ZmFqRjBwMzUwTDEyMzFIQmx4L1FsVXBldXZvZ1JFTkU0NEk2QmFC?=
 =?utf-8?B?UXFSNER1ejRpcUJIQmR4VHFkeDRaamNkZWVzZmFNUEFqcG1pUmhuRGJEOTZr?=
 =?utf-8?B?QW9RSzVnRzBTYzRzQnZoK28wTGJjYXhrV205U2FXQTVmZDBhckhjaE1keTJh?=
 =?utf-8?B?TEJyaXFUQzZIOTI2d3M3Yk16bk51VTNCYXhpUWhlTE1RRmVVbVppWStaSmdk?=
 =?utf-8?B?b2lKV2NaV25zY1h4ZENGbGRrdXJlWE44eVVIZVhnV2hYak4zUkZwMGk4QU8x?=
 =?utf-8?B?aFBjZGNlc0R2UUVGVUhLV1ZGS0FvdytKVTh4NDluZXlVbUJUbUZlbS85OXlI?=
 =?utf-8?B?RzZWVFVzZC9hdUpGN3cxRUppbVZZbUE5MG5CUzZWYzFqZnhwU1lhLzNrNW1t?=
 =?utf-8?B?S3pQTTAzZFVFU3prelV5c2dwcHFOOTZMZ01nYmp0blpGd3NzaGI5ZDhTTUJn?=
 =?utf-8?B?MmJTelk1a2xlcGxGODA0UGt6NFc4bmlrekVqUmdJOHNsUkNhSFdqNS9SOWFJ?=
 =?utf-8?B?Z3pjNE0zVU1uRUxmelh4NFZtTXFJZERDazFBcUxWYUdva1hlWmROMG1DTVlz?=
 =?utf-8?B?bVFyd0JuMjMwa09SSk5xdjdhM0s4QUo5OG9OYWVSU0tCaVRoTkxrRHNacHUr?=
 =?utf-8?Q?AbOoUs8CJJ1ITlYo=3D?=
X-Exchange-RoutingPolicyChecked:
	grytbwwt2eI5L7u6iNXXwy3bZAUntwhGwqvYUIx7OC93AsaOrV0DlmoZnpTe2lMS0fH5GF83MZeYeSdDLoDeD8q78tmUGjlDMJ8uo9X7tx9YBLy+/mYS+iyI6lSl6zXDW3RjQ6HcvyOIbhmsP+WaPWMM6YdWMVwRZHiHvIlG0DpM5dRZVKR5j8x5zl0fvrqB8jFizmxxF+HqTAUSXSLqaWY6qgGrcA8ImpGUJzJ8Wsa6I/jkjK49HTqbP+BlJ28a0j5dnkhNTx3gTzSDpg6+PW6Iuoel6eeesv2EkXycRv9RlUsNAuvqjAiOa7fLPetyOvcGMlUbkaB3wfJF+c7RnQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bA8TShK+FNIWKsFvxT/uGvB2ePSOb/NONCNSWurpnsbRjTbGH91IkRcbQJJlJ11XINF8/rSqubbSo6v2BgD8bTAy+R+vb6G7QnC2o+Ti0T1bUlDNXkSAfIDJ5R0TL0IYWpJxJFXkXcyBAI5BliElDxu8dWNMLMQVJHoL9MJ2HpevSCb0hQdP5EGFcQobpzDH2hp+qRFAfw4rxOYNRk4eJxtZwB/+rRa/a6mYUEkdPs/3wSlX5CmajTybKWhVpzCYaKV52TRd1fR6vrOFvie6jXa8cbqTCC6T8ntN95xWEA+/79nQbHFWTqEpM9eLXs3kf9Jjsn11snmlWQiSVumcCtHaHJfCloj/x0HZ8b4T9qjQQ4J+V0F2IlDf9oArYh5cV5IrdBJdN1Z4Tkimt7bwFxRnbT4XuKzlLhA+nJVjPAeYwZaLGvMPkpPchNgBfShrFbEYP0xKVVkd6/aRnsJ0muX7JHYWQnQjdURDHdjA3C6edlfFT2AQ8MBHS0YUvsRQXP5C7J9IforXxgvbJCj0TjseU7H8wcf6tRxzgPi6n0XSnLp9rYxlksm6y0Dk7STFt78qXAIreKaFK72vQMSf2BWuBhmr4iANtL+14q0bAUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a49afb-4b90-4c67-4c5d-08de7e913837
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:38:51.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40aj5Gz3OD8aajm5RnkFIciQQLg+WU9PnPyhQkM2y5X9wH5wjq3LTgfEcZA+ifTPuy2skQFTeQQZqbqiHyJRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100091
X-Proofpoint-ORIG-GUID: bRvflZIbDdIHBoo4OdDecHQEOmli8y1J
X-Proofpoint-GUID: bRvflZIbDdIHBoo4OdDecHQEOmli8y1J
X-Authority-Analysis: v=2.4 cv=LeYxKzfi c=1 sm=1 tr=0 ts=69aff4be cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=x68Lirz7iUdiJNq1bzwA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5MSBTYWx0ZWRfXzjfXeT3pyHgq
 P9A9RB2ftl/JOCMvpTYjBhxSlGOg1OJcUolHvxIF+7cvaWS5tJPFBUIfKIEKQ63hRKZ1Qj5XL1g
 sZD7TtXw/+DG+on3QrpSP5sWuKl8+5EgpVplqFv+V+cpzuIsZ6LBOctvLeUTB/Oo4vaAsEg2eMa
 jBgTpsPK/uF5x0KkJuQQg2UjBWZKifv5d62dKLFi8xK9ZxJ2U87lzWRlkj9Nm+Cr22FTpxk2S4A
 2WuD2fdnl2he2egPWJHlCvRxmI+6ArvO5vv3dCJEBBwJ1qS1Phemo2E3b99hIrW0KzrlU1A6zjN
 j8G/8K+TYcqeisnZoCP81tD0s6w5pbyQZ31M3dgdNf79t1dpzby6hkFiNaH2QXZLMPu4Kebo5ma
 ipaYmsscfUaRVN3R1ItFApbvgV/ThvkdTqGxFpwNIs/rlAi69U/e6r98PHoXbfQ5/LqQbzIUv5a
 UK1bJie3l/GYdK6dyCA==

On 09/03/2026 20:56, Bruce McCulloch wrote:
> Hello,
> Here is a rebased version of the patch that is in line with upstream,
> and contains gcc_true_signatures,sh. Sorry about the mixup on this one,
> someone should probably sync the github sometime soon :-).
> 
> Bruce
> ---
> Simple refactoring of the testsuite with the creation of a shared
> library (tests/test_lib.sh).
> Additions include:
> * Getters to find vmlinux.
> * Functions to open tmp dirs and tmp files.
> * Functions to automatically clean tmp dirs and files on pass.
> * On fail, tmp dirs are preserved.
> * Functions to pass/fail/skip/softfail tests (works with CI).
> * Logging functions with varying verbosity levels.
> * Compatible with non-bash interpreters (for perf tests).
> * Colors.
> 
> Signed-off-by: Bruce McCulloch <bruce.mcculloch@oracle.com>

Applied, thanks!


