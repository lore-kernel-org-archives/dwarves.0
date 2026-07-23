Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00F4B8DE2
	for <dwarves@vger.kernel.org>; Thu, 23 Jul 2026 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826258; cv=fail; b=tR9M+NhTjzKagNON0TEglHNU91UUItu3ofEt+oWE8bTIc8/JRkvBUFCwobp/FITxsYw7ozfV08j5PgyuhNVQEsaiwPC5wYwC3I51QZQc/HjcqF6iIiA8M6XudbWnipUSAqhm8tgAXpdw+QfxB6vGUzbd6j7Y9d3IHKBebRf80NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826258; c=relaxed/simple;
	bh=sXWLizEBy09zgoocB9ffXXTdwmOmQl5qZjEXHRmZqlg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pxCmsXacZVFnplbwJjKgFr7dgg0Cu6EHuT0/ECUIdfiFLznRrpVtLsdpv3RGUw2ZzjDuTRZSjQjQJkvhmK7PpHNn/6VfclIjKy1TYsI3fZTOK3J3autIXl6F6hxtMChPKAyXg4Swx0Dz6exAhptnA8fGcy5bvZxsEcTw93CQthQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GEtgNLW/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VGTH75/8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GEtgNLW/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VGTH75/8"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NFvO941253785;
	Thu, 23 Jul 2026 17:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hBGrmP0Aq0008qJNyCD7O620rOQRC3h3rTKZLtUOXRU=; b=
	GEtgNLW/5T0puiBQbhGmLWNFuYn/NrU+rpx5oTbwHrCnadukqhORBlxl4Mtowmwp
	qkqBkIuUYSd/fH9nUnDsMcHQ3sprJ6hL+veCGZmMMUAgbgsMEtM224LOb0Y6jJIu
	z6RCw1+zaSRn6/HAPV/7qO3OocaeK+fACR7I6JaqwhNzket6Dh3pLZMHtmnxS0Qh
	5uGXtxzI4fufJna1jscBuahOlDsrl34iwxEsm2/gfq77xNZwSDJXFyHSnMPDiPbA
	baQ/D1sgDGe1aQJ0hyMzV920oeYuky5SKHpoqIkOzab55YC633q3Mbov0bOAab8r
	Z2HV3X72ROQ6+h87kZzMfQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1n3q99p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:04:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66NH3Er7009366;
	Thu, 23 Jul 2026 17:04:00 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fgts1cpn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 17:04:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtP+ahC2pUXrn5MYkQewqmwyMTJwdWzql0kjmrp6moi4x/TV1a3TIXu79LdnFCsUqUP99qwQXEdbUtQUcmxZkLMtYunhqJ+0YYEcan4fD6Ly9y0ZYwsiIkXurST+ZvAi1K300hCrG7c+flcpPtCDI4SjSGp0XhodZ9YmpQ475Jx5zh4AJjFUltzU2WwZEViE4AMxL4wat+n2ltE8nqbYSs0zOSQkM+hDzW4CVxiFhfnxtfyh7MwfQxorg6MEUlgQ9//Nnt62rOvSEkmjpKgMQ0h8xPjfhVM8CnvTn6TOrbV2GgZP1laPSX0xyF54uO5INeCSn3pW/tk4Du0PJgfztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBGrmP0Aq0008qJNyCD7O620rOQRC3h3rTKZLtUOXRU=;
 b=DiVuDm1Uu5Oh5u3V8eF7ymzE9iD8F1F6i8tyIZoRe91p6bYhRbosCK7WAHPc0MNZaBtJCyi3uyyrEL9xlGiX6/Kk7xX/CxfzIeDTZsGoV7ik7fPrp8wYKTtpXTuycJr0jDJK4FQC1QgiEsuJwNA772fNi8Pq2nwrGJuttuysA3ZrBTJDdWMRM2Mw+20pQFNYeiwgB+U4NDP0AbH64ZpVBoiCb4DApgbqcbD0meOuuv+Fo2eWTrr3b00UvtsgbDiDhTxeUYPy/qz76vUfxkjXjoUJFXxiEPcWW6+1DlV0NeUAOXZn0SFshJr/y0VQJqoVlCBIb7YV+CdW6ROD/GVdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBGrmP0Aq0008qJNyCD7O620rOQRC3h3rTKZLtUOXRU=;
 b=VGTH75/8AKDio3SK8wqh58Qf7K2wap5KqRAnjftqdzfUY2tNcwK1/lG7JZCcziLeptmqLBY70FqMdN/hI/HeHooDx1y92lPaoJSB2Nf4NEjc04ZFW+c5pWxtVw2xrNmjaWZ8LCjlKYzgR1coCbXrOka4NUeIfxqQ0qM19HJ4iqE=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ2PR10MB7825.namprd10.prod.outlook.com (2603:10b6:a03:56e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 17:03:56 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 17:03:56 +0000
Message-ID: <f3967b5b-1a15-46f9-af02-7af2b5eb5014@oracle.com>
Date: Thu, 23 Jul 2026 18:03:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btf_encoder: Add O_TRUNC to btf_encoder__write_raw_file()
To: Namhyung Kim <namhyung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
References: <20260717180105.136705-1-namhyung@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260717180105.136705-1-namhyung@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::12) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ2PR10MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 1580d259-6dca-4aa0-aa75-08dee8dc6194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mARhgpajRKEsBvW4I6Px4XBo4EpnG0D4ZAUX+8nUhOp8M1PPrkcAkgK1dpKAWBu+vJwUzZVfURbMLecNbca0GuyCmfoLhkJMa4GRnICd9OZatt8TaISiqLP4Rw63TSnN1q8NyOR/yNFlMTyYLjKBmHlDH4X1K76IiSvTTBkIp0kzb9y0kPTM4rXOliVEIEmkON+/ATf5IK7F+wb6V0BofGdMa9mOFOzfqQcD6OqhdfGjV5Gu3v43NC3lZgWnBEQfrBHVJ0g3bJRHUKpIuvzNzhOdgwc0CEbfqM9IOtUzeDktOz0FLIsaJmbUfq8eK3AUgqpP4vZmCyKD2uAICmtUnZ7Z0Q8lCFKNDaXwHiIhDeCbZwSZehWBhotryIXQLJj5oFhPZ+3T5fVuQ4tXJiCFpKx8mkiyHA+SFQsCsdRuIKLdbMpRjnD3CguO5L1S/FuizQTOVWZ+xY4jCBU5+kOvctVqttP7OZGypATjVRxp4bfNIQKDj+yfotBj3kg/o77Z5DXzJy+EGPinS6FF1+2KKuCDk+uZBjBuc8tHbfK4zqGMX+nH/K4AF6TpZYwA45QsIanY4v9oo7cuonlxWkdy2k7t5RL1zD4GAZBasROcOduZwOi8nc6177ZzNCPcd5bHmRR1j5Efk0YmH4U+k2gdY8NWz7EDkBz/CoJzKrtrDmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHhoc3h3dGZMRTBaYmpJUXk2WkJ2LzY1Q0RzMUZxVWgxKzVjZDZuSUNPMC9J?=
 =?utf-8?B?cTJFOGFrZ004a3IvaTZvVW0yMk9KNEs3b0NwTEUwSmxvN3pTN2RJQUdDOFM0?=
 =?utf-8?B?QUY2NHFuSHZLbVRJbVNRK05PakJWMXZFbFZITWttQUYvelJZSEx5Q1hCcnhi?=
 =?utf-8?B?MWVWWXJ6aU11c2lRaHl5TmdUU0dhL2N1TVZDTDQzb0FWVEZYbnhHaXY3MGIr?=
 =?utf-8?B?Qkk0R29uYmpHTzN5Y2pQcHFNVXp3TmxvblZ5Z0x5d1NaNFE3VWlJZzU5ZGc0?=
 =?utf-8?B?VXJmYldrQU1xZkRzbThObjR3cllQT1lyVzdjSE12ZnM2S2kwYm1qVy9ONUhQ?=
 =?utf-8?B?UW9MeHU1aWllRmpWQzAxdVNpeWdHSzJyUy9MV203WW9TcWE0OFlmbmVaQmcy?=
 =?utf-8?B?ZDVHcks5bzdEbFhDeWxLK3ZoS2FTd3VPN0JrTUVMdFpvcW1PcHRKZEl6Nmpo?=
 =?utf-8?B?NlFoTHloekhLd0RYM0FpRjFOdk5Rckl2U051aE5kVUM5SktHMjZscEFHM2Nl?=
 =?utf-8?B?M3Z0cHpqZjVhRXk4WldRY1E3TXc5VXE5RHVWWnlIVHRZWUhaVjFsUnkrN0RM?=
 =?utf-8?B?RE9yU2s0L3R5Uk02OWViNjZ3eWxqdTVBODVGc0VIL3lVTlVsRUNUSEZkZWdD?=
 =?utf-8?B?L3VFT0RnUGxlWjd6YjZxTEpaVGxBYkJGb0JXYUdCZVZ4QnVsdmpMNGpjdEpu?=
 =?utf-8?B?SmFRb3dodGhtZFZPM2RJa1Jjczd4N0JvdGdoWkgwUnFpT2lCODI3WlRHa1gw?=
 =?utf-8?B?d2IycklWaTRVZkhETDJDNiswTmVDZm5LVjF6Y3ppSlJ6NlVWQ0RuTkZMb2hZ?=
 =?utf-8?B?VW1DS1VnUmRMRGdHakViZHJaQytlVlBtLzg3YnN6Z21LSDdCRHpqZWRUMEMx?=
 =?utf-8?B?bjRlUEU3bXRiQ2U5bXVISlpUT01CT3haU2NzU0wwZlJwZjBITTNzSld5WlNo?=
 =?utf-8?B?MFJsaW5hUXNHeTJPc0pMa1ZSd2hjSllzTVJ6d0JHUmJzRlBodkV2L2NsRGEz?=
 =?utf-8?B?Z1lhVWZlZ3JsWnJRSDJuUlR6TVF3ZEVhUzJHTFNXL1c1MXkxU3N3bU5RTTM4?=
 =?utf-8?B?UGFrdWdnTnM1QmhRZVVYUjVObEhNZWJiWWtlelBoQkd2eGtVazZRRDh4bmc1?=
 =?utf-8?B?ZWVsSllvVElwZjhsRXowblVDdzhFSGRCREVDM1o0cENsSXFhWTVBblB4RE9l?=
 =?utf-8?B?ck1uc1JBbFVoWU5uM0JPSmRZZGlMMGF3amlpbVI0Z3lkS0ZmNTZFYkZFRXFj?=
 =?utf-8?B?U3A2V1EvRGFhb3lGZ2FaRFo0dGdqUjZzcU80ME5Kd1N2NXhFWlFvWkk5dmJa?=
 =?utf-8?B?WmttRHo0R3lmdEh4T1VPQU1vSlNrSElYbnFXRXhRdThpemU5NDNHM0ZubVhK?=
 =?utf-8?B?QjlVM2hibnl4SWpUN0U4K2FyN1F1dzRaWGcwdkVTNnNNNnRPaGVwSDgvaVlh?=
 =?utf-8?B?WnVqaXV6VXVzcE9MeFBaa1RwaGg0aFNFK3B3S3pLdUNFdDBaTlI5NnUzRnhi?=
 =?utf-8?B?aTZmMzcwK0hRcGRUTXJSb1hiVWtGYWNSRHJvYWkyR3ZmRE1zb0ttZDgzNml3?=
 =?utf-8?B?aE9qb1d2ZVNYM0d0bWNnNVcwYUx2Mzd1WUdmNWZQWXpLblJMN01SaHFjWEtk?=
 =?utf-8?B?ZGtzMFYyUUZwdHFpemlHTy81M0hIS3VpTXVRRE81Z1JoN2xsQm9oTVNlRllK?=
 =?utf-8?B?b0RMdDJBZ1FFUGpRYy8wbThRWVZDNHBtWVgrQ1d5Y0lnWWVQbm9KeDU1djc0?=
 =?utf-8?B?U2Jxclo1c2diMzdGd0dMdTB2VmoyaWgyMjlncTFWMmp5RFFiMzUxSU01SFUx?=
 =?utf-8?B?YmpVNDRQeHl6MzJPM2NpZCtGTFROR29DZC8zSUNyaVJlOFNGZkJzMHhubzZN?=
 =?utf-8?B?UHpHVGV2TnMxWVhSdWw3U0NwbUJ6NWlMNmxIK3I2WVlWYTMvbjBvWVlpWEc1?=
 =?utf-8?B?cGVFbCtIVmc3NVlPVVZIMnpVZEJSSkRhdUsvZFF3TTlvVzB0RG5SUElmWHhZ?=
 =?utf-8?B?MVY2MnJvYm8zbHU1d1ZJUTNwbTlSRkNLU1RDVElZOEhSb3BoVUVQcHh4cWRp?=
 =?utf-8?B?K0JHbUwxZDZxc3Y3MVltOXgvNVJ5Z0ZNTWdxTGk3bXRYbW5Cano3RVdtNTRV?=
 =?utf-8?B?T2RTYVdpbmhkOVUrOGRCNTdVRXIrN2ROaVZ4TVA5MFh6ajE5S29FeGU4cUt6?=
 =?utf-8?B?ei9lOHFCR1NkUGlVajhnajdpN0xNL2VOeDNienlRb0tZNHZYeUJ5dE00TFFX?=
 =?utf-8?B?N1J0OXFjTVpZK0d4NC8rY2ZJdG1FVzZqbjI3RG50YmRtOWlmNW1DR2xXQVZN?=
 =?utf-8?B?Q2RmR0Z1MlF2alQ0VVpENFZJc0pqN3FLaXc0QjhMRkRYNGFPVCtQZz09?=
X-Exchange-RoutingPolicyChecked:
	DDlHHOElxN4Wac9K1CeTvpe2NfeKmF708CkeLPAdtIzmFaCrfZYhj/3sDeEN8mclrsVmEO1i1iVwF7Cnh8ZVkM6GBTfXgBIUuqEmlk8n9ZcSOq+cS+jEgI4+Iq/qCeUOfO7nfCwcosyG1pRnHMIz3ge0JoKp7/3O+s9kVBED4c27O508lxgmXr8Sln90DyZa3nhdkB/Dddf/nam6vM9HGiBRjkR+RSzxWJq+BLQfA6O+aMwH39kD4E2ghmIq2Re9M1tTaxy4ofQyZSq4hpeUCjN7EiXNr6poTdpvErLOpAhFQLoaZsv6Sg+kEgwPR1grhPwJiM834cx48D5a5LBlAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vViXGJO8gFNuPUfk2QgF3NCt+BGm/+joCl9xEEXPJeqk8b96vlU5KIS+KDDIsZzGqodT8uFlovk3Ty11XE7KwAmW7GhCNsliTdlEvbvwvKc3yK+OnkZHoweknOCjQQmWmrY5V0cFBo48kGpw/cD5d757fHPI2UaqH4mt4oBQ8My2i9aJkVV4AaUJJclw4W7QCbhoIHHApa7yteFIGhawacVJ6YhFCERkMx4xkSv3gJ07Dy9PdSi2Ham/naj+Nr1A0pXo57xnBnd5un9ZvDpNNX/xhhpTE6HYxM8TLxGOSwff3X0+Csdls21DdDo/Hf1XcV1lKLvIZH3QWM9HxyWOXdX4/lmUvVpIuI+L6bm3cmmiyt905uvzXQqOocf1b+4hNYEvFzy6Foa69rI439tU/5f+TNapxXKx+NOI9SmwR3Y+fyxoOY9VTE7VyNPmpTqKCtb25FBTvsvSPvXMJH3vWSS+JdIQH7iDd6+UvXjk8v5NO06Gp+wnuwC6QWEh6TuiFSXRMAYdIe/EuPWqbR3blcT357ab5pwHVwCrpPlT4hRN+UA+apgVPZPdSM2zKTCkhPzH7zkFpGZU+jI+1Bpehw/jY9OvlmtbcPvfMmFMNCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1580d259-6dca-4aa0-aa75-08dee8dc6194
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 17:03:56.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ0Kf0LJDyvYxosUPJ6sumJok2k+9M0/ACqgDOZ0kHfZ1tgZY4AyQxbTRrhKMhq9evFAxiVcBwsqy++1igmoEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607230167
X-Proofpoint-GUID: HFH5LDnXvio6U2-U7Y_HZ1lb1_drQ3zf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2NyBTYWx0ZWRfX1ooQmGrHCd7l
 v+I2AnaHsuT6EJFH/o3bO/sfkUr/ozoR0VnUfAmnKaOI61i+tztYm4dnb3UHJDTxorxQmuLZ2Om
 RsWiRr54qyQd7nJbMhQMb4LCjP9BTyA74GiAA+sjzKoLQJZ1iz7M
X-Proofpoint-ORIG-GUID: HFH5LDnXvio6U2-U7Y_HZ1lb1_drQ3zf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2NyBTYWx0ZWRfX3rTLLUM70jSr
 ZxmS82I/n/rSoUhrO9OOW99q2mPdr9FVR2SsSki7IcR8ikvn2CKA2U+V+F828V5NEM6eF9VsTFN
 insDmO6z06sSVTIhIbCmPBN0RYrqej8kOX2q2Qr4NGn0e/VrcJRgvjz0j8Gu+4THLSmfxsXzil3
 Z7JCnlzKbi751oT6soSwKfYGtASRvMxkFkiwUM773yBfVIvy2v8gTYia+g/xUv8XB/n9LLGfkBP
 +sgLtGnhmzlzkTkejYv9D0TvXmKeqY+wHWuGK3ifaoggeMOZCC6bQaEmwpMGpMErbu0kPyRF6ne
 aSolBAUJTU9ritcv4NTQ4LCqgSU+DTTVC9e47UNMrJQFkgb4AXsGelgJj62UfkyF4OrbJJgTCqy
 +tucVxjqjOm7/dY54CL48Yi5W2IAan6iLeDYZ2ZKr5s1qX31oLVvEi/nhnCozH1EvF315B3yIxa
 BDFQ2dPT2NadGwIXeCA==
X-Authority-Analysis: v=2.4 cv=PryjqQM3 c=1 sm=1 tr=0 ts=6a624981 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=pGLkceISAAAA:8
 a=Z6qUqDySk5cqzGNx75AA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10

On 17/07/2026 19:01, Namhyung Kim wrote:
> 
> When it creates a raw file, it should truncate the content in case there
> is an old file with the same name.  Otherwise it may have some garbage
> at the end of the file and it could make the kernel fail to verify BTF.
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

Applied, thank you!

Alan

> ---
>  btf_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d36984a..b810dd5 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1878,7 +1878,7 @@ static int btf_encoder__write_raw_file(struct btf_encoder *encoder)
>  		return -1;
>  	}
>  
> -	fd = open(filename, O_WRONLY | O_CREAT, 0640);
> +	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0640);
>  	if (fd < 0) {
>  		fprintf(stderr, "%s: Couldn't open %s for writing the raw BTF info: %s\n", __func__, filename, strerror(errno));
>  		return -1;
> -- 
> 2.55.0.229.g6434b31f56-goog
> 

