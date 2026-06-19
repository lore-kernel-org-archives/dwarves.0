Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974A37FF54;
	Fri, 19 Jun 2026 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871450; cv=fail; b=kAJWDoP9ThgJa86GQZDVRY3Ii1uNhfHLrThhj2zw+jy/5IF5lCSvLi2iasS0FPwp2P2JII7QWyFh5XSwAArIo8AZIkjpEC8sAbfKnNMXeTd0QEElayoOF3vJEERdVrvOARpsyk/kPOJTMxv09ZVqTF3J6zaWZbhaNgVCQM4T+wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871450; c=relaxed/simple;
	bh=mmvlv6Z7z6A+bYSTRXSENoiji4/ih1heQqIcUuN1HW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CGb+3x54bSw2Es+2lh2Ukte7arm8DA2GwabvuZAvXW6e7pvMdxa4pzgQzmhZ3+cmKISty1K38Llbidj48jf7ZjxWTH2j1AhZUGyiAcab/XH/pvu0KdPMja+TmraO2SfOyW2US7qUsBZ2s0kOn80PlHKhMEDywyuDuyzZ2oSvd1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DMkmB1Su; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l+cuTWXR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DMkmB1Su";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l+cuTWXR"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J0hDh01677137;
	Fri, 19 Jun 2026 12:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=l76M6+y2+wKfu2d8V8fSjkmaBzg/nidR/11jfyJ6/YQ=; b=
	DMkmB1SuUZ9nPl8nA9GOdigGzkCO0NeqNyNssEVkIMpqMEgMtQ4S2FLjI4t5fE7/
	wEZlfsuPZNHrAqvYHQlgfjxPbxOL1wH4A2aY9wSuvYts/e2nQDn2ytooQ46aHkQk
	ZChYYJHXg6b6ORqJtMG3g2cuDAY8+be13LOWRzpnGTqCscnmJVJpg3QbQ8gq0hfp
	T0AVHKSf0NaLADqZWkmPyOq/kdkI8TUD8/iUkkkuCdtfRq7mn/TaWSJ1Jk5D+pnK
	s4FNkN6eI6qce9sbKHlouTFMLAVa2oF68HR9F6z7l/zmTn2dLIHEPGPCg6MzSrfP
	luriQVKgyF+1M/6BkvvwjQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eueg344d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 12:17:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65JC8Z4n015720;
	Fri, 19 Jun 2026 12:17:18 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ev14v9m7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 12:17:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkipN/npY7it0t30b7d/Do7DyRruQW/Qbz3RcO91Haf+dqn/So9toe4i9xhgg1ef7YXDlgtzPRdqIoHbKeKebN4g5QjOYIFX0wVPnlTjEEo9v/7q9zbMR4pwRKCLD5sbus5WGOLw89ZzpKxZ1gv7tHHopSf33pB3hp+dwipHAdFgV7F5LFIAXrmdrrW7QoiM6/FtQvSJn9nfxeZsGrAHD5F0tpdA7ZMIpIynzIat17TF3qNEALPc+bWzk9+95vAUWLgq7d4RkMDBz0apyYF1hZ0FHlPKr34mXnvd1bHFSS8fXLWryzUBPEYwEETGVy+4CaTrQ4z13OVFCE9X8rFlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l76M6+y2+wKfu2d8V8fSjkmaBzg/nidR/11jfyJ6/YQ=;
 b=bbbINadth9Rt+zyuHE0O/HQOzmA90AdcwQLQZZV0BK39cRJIfzjWFfpCdDLWL5r9JMn85YmMI/b4ZyRu2Ng7MO7nG+0YhFDu3RNdr0S4sNmEMksMGINvU/YCIA3951Jjn5cnQw15ER4UAQWi3W1PLo8ylvlg3+99ruryQMOX4RnCp3mvLsL6pnIE5LUIcIkMo2tF/HwYn3KoNjNrS1XTHVHFv8fSohzsKW+uNH5h/RepYCzLx8XLYL0h1G9ht2MEaK8Ok0fIN2wmghnIdw2OHKMS5EnrfQHSKl3X7O4PDjCxVDSLeHk2gtnD9UNEwRx6YeQg/3TaaVfcMJl1jMm47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l76M6+y2+wKfu2d8V8fSjkmaBzg/nidR/11jfyJ6/YQ=;
 b=l+cuTWXRjia3ACzcf8kV0KzgjsUDL9rZ7k2vr54zPnWG3MD8ICammyOlyn2Sw2dexbdv1PYhKKf4XxT+Lr4rdxnGQ6Y19obYJ5vkOxV2ZQi3MhXFO09rjPHYJusyiUgK4yTtd967X94fEVgS6QAA/zAkzVjA/glC9WWghtdKnMM=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 12:17:15 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 12:17:15 +0000
Message-ID: <663c926a-09f2-4239-bbe9-078bbf900822@oracle.com>
Date: Fri, 19 Jun 2026 13:17:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PAHOLE v5 0/5] support for DW_TAG_GNU_annotation and fixes
To: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, acme@kernel.org,
        Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
        David Faust <david.faust@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260618005731.273181-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX1P273CA0007.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::12) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MN2PR10MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: fa025544-cedd-452a-f8a6-08decdfcb282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	LIcT0oF29kZwoxKKWxijWEpJY7ncdVkye0mDr9iUsasksZGkSr+x3ePMcZTkVTLqYPYlVfJmhl85qgEghr95lNkbTOGDvU7V68hWVz5sGAESd5yLpORshZHj8z9lydsGlaPurJH0eaH4+mSfgBRCnh1y0LmzGmCBta3msAvEzQi2myNWm9E9adTwQFFXZJCxXtGpgE2PsBOv2tNhKqN1ZmfraXs1m/9ilucJslakh4USYC+vLlcU4couytnZbTbFVIQjKjRtkwzMJZ8+23vw2xGN60bKNkXW3GR5CP5qaxIQogy7EvbfX/lLdpWsm9E/SXzNLaOxtzSHV7mmM3fVOSUnylNOdRU56JXEZsaSvarnA5JX7uV2FN6/DbgkoVYS7smSfnLJf9JPJQslb7HIiLksGkfKL7JzbcaJxxPbKMR7zco+ngSrnp71LRBUUrihI4UbjcR3Nk5I7cy1pCrbsR7zlrU8cDz7/o6byuLN1kEBS9sj0wbTR2PiFkLruNLY42C3QKqo4b5W+X75ZF6dm+2+gz0GFBlAM7bQApO7iFXj7nI+EEDPz/tIExQgkF6hwzlc/dufW5XxJeTbgvF/D719W/U14+bKTyOyziWjXGOw8FgiCcNf/mZcjcpxI97oF0e6z/Kpqmokb3xTQOr9JINj1r5DRquKz5gveeTn54s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEVrZFV2M2ZLaDgzaUFLRVlONkJqZ0tkUEVpQjZmR1NzR1FTclppblZUMVRZ?=
 =?utf-8?B?cDUxYWw0c3UvRE9oMTRTNzBnVUwwODNIaGhjUEEyZUNxZE43bmlDbDZtMkV3?=
 =?utf-8?B?dHVzOEJQR0hLZ2FRTGF0aERVcGxZdFpXTytFRDdrUlFjOS9vZVhBUjVadTdr?=
 =?utf-8?B?NXpoTjZ5S2pyVmIzYlU1c1kveWdkZ1d0NU00WE1Da1ZydmJuR2x2UGFtRERt?=
 =?utf-8?B?aGs3NWNlN1BvNTh2eUhoTXFHbzY5WWZLdU9HcjFnSjNLVnIzK3FBV0ZNM29T?=
 =?utf-8?B?WVRiVVVqcXhBVGN3UkM5LzVQTFcvNitZY1lkczZLSjZib3Q0azZBOG9YMEFF?=
 =?utf-8?B?bTBSNkNRSmRBaXVBYXYvT1ZwSGdqM2xRL1puYmZBTjdkV2xwTm1QR29zQ2ww?=
 =?utf-8?B?czd6Z2N4L1AxM1F6U2RPT2c0SjBjOXl1V3N3b1NXNUZkcTBQbFNjWDJGVmJD?=
 =?utf-8?B?OHVza0JrWjZ1NVRlNTBWT2phaUUyZU5oTEVwSldrYUxaRTBuLzZzMDVKWU0v?=
 =?utf-8?B?TEZ0L0pHSTBWVktnMDlPd1QzVTJwckFKUWNBY0tITDZCcG9pVktJdzR3SkhP?=
 =?utf-8?B?em1qdkJsNFdsOTJUUEIyZjFaYnFyNHo0WDk0eVdvR3QvYWIrb3N2VEVQMVgw?=
 =?utf-8?B?b0FCRTYxb3o1YldVUjBqNWZWWURDKytTNWp3cVROZHIxYSsxUFo5OHY4ZVAr?=
 =?utf-8?B?RnJnb1c5eTg4TWl1YTl0STdPdWFpbXZSTUpNbnBoN001RVd3VzlNVG9nb3do?=
 =?utf-8?B?MkRWTzRzc0hzL0tiYmU2Q0xwckVUK0FrMmRRUkxEakFpQnA1L1AreDJVZjJB?=
 =?utf-8?B?OGxaMndFV0dHeEJkMDdyVFRpZnZkL3BqRU5Jc2l3SzE4VU1LL3doSGU3Y0xi?=
 =?utf-8?B?aEJoU2M5bnhzYTJ3NThEdURhc0NOeEZPaUhzNHNWNWdnZlgzN1p2dnl1KzZT?=
 =?utf-8?B?WVRuUGpVOFJMQnRKMExLdXI2ZXNKNWh5OXpyMGt1RmhvVFQ4YmljTTl5N0xL?=
 =?utf-8?B?L0VUVHVHNGpKcUtsSXVFNkp2bHVyY21EZ2NSdm11S1MrcERzL05BaFh1c0Rt?=
 =?utf-8?B?QjZMQTFNald0VGV2STRqYmZyY3dhNGpUcTUzb2lkZmJLcXQzdjJHUDFCOEp5?=
 =?utf-8?B?QlpSb3JDMElDaDgvTVVuQlJKdUpwY1JQZHZEcytnRE9CRFdYeXNhREZiTVdV?=
 =?utf-8?B?RDVYdkQ0SGlMbXdRM21sQ0xyZCtodXF3R0xsamEyR2pGeHFRbU9EYnB6b2Ri?=
 =?utf-8?B?dzVFblBGWnZsam9IZFpKUEJtZUR2WTgxSk5naUlSVWhSdnRibFgwUWRNbzlM?=
 =?utf-8?B?R1NyNmYyeGIvaXdkd05OQWhNL3dyNG1QazZsMUxtRERncnp0RkpHT2hjRzYz?=
 =?utf-8?B?cnA5eWt1WENmQzI0ODNMRG5vbzZhcWFGa0xFVGdKcHd2cXNWSHJaeWRBWlpm?=
 =?utf-8?B?RE9sOHJsdjhCWWRUc3ZZS3RhN3dualYvcWt1Vk1OMkF4dlRpMmFvcmUzbUJB?=
 =?utf-8?B?Vyt6OEcvNTdjOW1nRHF5dVM1bVFBSDViL2ZxOVQxQ0I1RERlYkNscHZGWC9B?=
 =?utf-8?B?ZTk3UnV1TWN3WlZMajgreUVrVEJaRnE0TWxJdlpYSGJzUVgwZUcraGNNTko0?=
 =?utf-8?B?OEJSTmZ2U0paaWxiYnAvZHM4R3J5bjV2MkFQSmpYUnFwWDlJTjFlSSt1ZTJo?=
 =?utf-8?B?S1BheGI2NTB4VEE5QWtITFF2Ykk1SXpLeURabzl5UkpwNnF1R2gzMnBWUlkz?=
 =?utf-8?B?dkdRRmZNcCsvdFlvcURUUythV3hRTFk2TlBSd2MzUVJBNG4xc2EvQ3VkQUJt?=
 =?utf-8?B?UzJhRGV6aVUzTkFiVysxcFN5cHFvY2NXOXlpQllkM2dIaHA5OWhCWXNiNWZX?=
 =?utf-8?B?VGpzajB1aTRwVm1DWkVvQUZaTUNqdHprZ0hDSkUwcVlDdUkwd21nN1dtdFB0?=
 =?utf-8?B?b2J0cDdWWG55TlhkTjZNVU8rOHhJU0QreFR3a29WMTFHeHZ2U1d6dExZQk9K?=
 =?utf-8?B?TnIvY1hsRlBsTlY5SmZBb1VGQnZCcElEOE8xR05FRVpTU3NGZmFzZFNkemZY?=
 =?utf-8?B?eWtnZ1JCRTNYU2pwVEZDNlFDVmFsalQvbXNDYnByQ0hlS3BLRjZWZ0JTa1M2?=
 =?utf-8?B?ZExaRnJ3ejcyZUVKMDRIVXZuUmJWdzg5MlFNZVBucUswdkhhdWp4THJMYjBz?=
 =?utf-8?B?blNlNkJBRTAwSnFYTCtmUXg2L0lid0l4NHdIZ3lRNm9oMmd2aE5CRmx5U1h6?=
 =?utf-8?B?UWRNb2VLUHJ4cjBTb0NYdlI0Z2ZnNVI0WXA1NE1jRVE1SGsyMFdReE04RGhI?=
 =?utf-8?B?dFN5WWFOSmNuWjdDSGRWdW9keThNcTlCQUoxUm42L0hTV1MvZDlyREl4MnZF?=
 =?utf-8?Q?7E8wqy1cffs0E8W0=3D?=
X-Exchange-RoutingPolicyChecked:
	jxATDr03WGASKMqteoUN8NFnF7QUprxotzzRlw5KxSo0n+kfYpOIeAC1YXMEFfj9QJRaU+FwUHV70amP8xjrn6kI11quDz/F/w8AGrtSJS74J+Un6fO6s+IB5dgNu+VCNVGmkDK6ng0CF+l9QykbTTZyXxtB6g8cCewV8oCws6J/F76rl3yQJZniF7ui/fidJG3A98gq+ocOoeJ5LVYK8b4IklodZmShW6DL58Nq9KKYetfYj47eCiio78funAIq5vteUd89aONs4/bBSs6byg3K5ws/DaoKYlxg+SNszTf52S68QZ1AV8R7Xxs3pFdJE6KmUcjCCzOacv1mAHicqg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ngu2M55e3pubNHZZc37+EqYakOHU8to6afjh+TE234RJMBEvYqHCCVr/fsAcvltzuOiOshI98+/H3IOAIamoulu+aFqjBY0r1609MadwoWkJRCDNME2P2OKyRfZpY47GncnrawdGeGsuavw+mFmgqDu0meVwX3Xth3B8AHPkdnNp0hNoAIjuW/p+I+2ekByh5ahR6a0jMps0Zq1Fhnm+kQg7x7L6bxA4AdoC+qzOT3jq98B+PlywXTtUFjwzdXrSCkonYIzT5QDOjCLPoBNtuPt1M1Na6Fe25wvE5fkZ1rwaYNoKNB204uIghzQhmkt3Yy0MlOAWa9gvX7Lbr3NAAmy4Aak3552S0ue86Ta8GSc+A+iH5KEeinsL04ZUxxqrPX76qP7uI/lECisSM0nl1gTXg3oizeL5PjjzMnWvlSFcUy2DtyY3JnYWtEjxZrLeWKGf6QzEHrN11jqNVOT0WPFDwBnZP83N21hyTNfXq3p5zFM0JNmUjjMsWOLk9AzMQP0RvFhGpXsXctD2WbvL5pZA0VOi1gJbpjOGUFttbI/O83+omoFlNyMVrVpo/MqaIFJ69xywpduPevC8GGh84sz2YvE+XDzokLeJVJVKLe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa025544-cedd-452a-f8a6-08decdfcb282
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 12:17:15.1052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vO8M2r8v0pljy6cpCz1HqJIdT8HbBOu1EIeoa4KPqq61rTORZWSvHp+ymDFQjNXTPPLeQ1IkCGoSqpCWNu0yGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606190114
X-Authority-Analysis: v=2.4 cv=I8VVgtgg c=1 sm=1 tr=0 ts=6a35334f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=xYw-gyl9qrh3IiJ5s-AA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-GUID: IoNUHDTKWwNV22Jt_3c48KbokyEZWZ1t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDExNSBTYWx0ZWRfXyHuXQDliRvFg
 wZsmjgTgNA+8b/lZ6niRgv9pfdIq5uoCPQA18s++PSr7b0d6Omz0p6k8WSZIpPYV0eOzXARVdTg
 ur8v/hjVQ7ZF5TSWVbYIDIumzQCigwXO2aHWWAwB+4avZkiB4v9ZYZi19cb9WWit1h9opZshy/V
 dL1ak0XI52SQwRij9uR+Uzbwx55Lgn8wwjJ9OL+sQNgASTpv2VAAbFplSi98Y4hgj6jL6kKNrNM
 6DBHB7bfHRg1ClLxMz8t4AvDEpv2caublOl4NDWSX6QmOVoccyRxrLlTeDWVHH+MOOkr8jkzZoT
 ENLHOAHjUAqgZnGbLoTL47Rqb3bOxNETXkOyTw3FP6rHTQZ/PcYG+AqiOoCC7hSSSMZM6gLbgs3
 V5qHvQ2zxY+zWnjV9VjVuKP/XJzFBeafV63w4hM//I3M6+ALG+WHrYckujsKAv3gEnPj11neHTi
 5gzxEtbSP10/l12pfW8bRucgopwtx01M4wYIB6dA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDExNSBTYWx0ZWRfX33W+9QLO/TS7
 8RPrFBlBPoQGl2m/F4J9KhozIsmJFGLY+T6pGuNJ0M8nb+NZ4WwpMprC7gMyLqO568MjlaJdIH3
 Y9VJzQhiDx/OQB9sOQ+tKaSOhdD3t5AGZj7ArNDpuFOAuI/N3zid
X-Proofpoint-ORIG-GUID: IoNUHDTKWwNV22Jt_3c48KbokyEZWZ1t

On 18/06/2026 01:57, Vineet Gupta wrote:
> Hi,
> 
> This series handles gcc generated DW_TAG_GNU_annotation with the end
> goal to finally enable CONFIG_PAHOLE_HAS_BTF_TAG for gcc kerenel builds.
> 
> Patches 1/5 and 5/5 are newly introduced in v5 per Alan's ask.
> 
> P.S.: I've optimistically included Reviewed-by/Acked-by from Emil and
> Yonghong respectively on v4 [4] but those were before additional changes
> in v5 from Alan for a few things. Please let me know if that's no longer
> true.
> 
> [4] https://lore.kernel.org/bpf/20260602195512.1511013-1-vineet.gupta@linux.dev/
>

series applied, along with CI change to support [1]. Thank you!

Alan

[1] https://lore.kernel.org/dwarves/20260619073358.1605594-1-alan.maguire@oracle.com/T/#r0d979ca6aa79a4586b75223ec51a54e7be1d74f8

 
> Thx,
> -Vineet
> 
> Alan Maguire (2):
>   btf_loader: Handle decl tag component_idx for parameters
>   tests: Add btf_type_tag ordering test
> 
> Vineet Gupta (3):
>   dwarf_loader: Extract die__add_btf_type_tag() helper [NFC]
>   dwarf_loader: Add support for DW_TAG_GNU_annotation
>   tests: Support GCC in pfunct-btf-decl-tags test
> 
>  btf_encoder.c                 |   1 +
>  btf_loader.c                  |  46 ++++++++-
>  dutil.h                       |  11 ++
>  dwarf_loader.c                | 185 +++++++++++++++++++++++++++-------
>  dwarves.h                     |   2 +-
>  dwarves_fprintf.c             |  32 ++++--
>  tests/btf_type_tag_order.sh   | 179 ++++++++++++++++++++++++++++++++
>  tests/pfunct-btf-decl-tags.sh |  93 ++++++++++++-----
>  8 files changed, 478 insertions(+), 71 deletions(-)
>  create mode 100755 tests/btf_type_tag_order.sh
> 

