Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198423101C2;
	Thu, 18 Jun 2026 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793547; cv=fail; b=dTMuMXM/u7M4N2se48Top6b6rtQ9A+K0EnCtttUDcI7V7f097lEcBq69u0JNS3iSvhbmGL6lSMEK/pKFC/YSSQXjNsMFPE5SCZnxm2wkaI6EeAsU2d2FqjLwGsS6ohdBNg3tAgw8RwO1JyJbPjPztQoXv5PhDlXG1NTda26+JZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793547; c=relaxed/simple;
	bh=c1h4kqBaZJaRUvgIbsBORlxh/ixGfC+BbPX6O6zItww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ag5kltOp9syIz0J6imWo2AMeihzDL3YmyKMUhQc5YaLkY+/1iuz0buTozmsSi0eIw6bT6EPMZH16ws829aupRBZGH6/Xjm+MeBqtU7DI+k2rMTcxNQwrEcIFaP4Ub04Pv/ldswTQ0ePO3ICLkL6u07/dEB1jrmIv7ST/CH60zPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Flbs0CT4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QBUKEwvx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Flbs0CT4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QBUKEwvx"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I6FGHm2404438;
	Thu, 18 Jun 2026 14:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xXECoAbe/LShVF0GRA+eIW/oqDO1YQdpYfBDklVkIBM=; b=
	Flbs0CT4R2sZRlFHhEWwSCPTjRKMAU7I8DIHVGnZxKlM13ojFvoX0E50TARVfH8v
	pXR6Pxf2X6HDOkhx40orCcXmsIpvCJx39wNZdsjfz9wo+1rg7Iapd5EumAAbawrm
	Iuga6FsnYHgRpZPSIlv1Ef+BySZ+X4D27JlNMwzlGW/QjTHXdmyngFEHAiBXi12G
	sY0zHrDh4l14hDaLLFfkiIc1e8HSdH2lUlnKMPIcebKP1sv35+06XACoNhqRHWek
	n3QmIIMaiQVRert9/MR62fTb48RB8GtgBuox9NIXzRoamwTZyZWhmC6YXyR/wpZa
	dskgwKpwE4Wv+t5OMGxuuA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4euegd2pym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 14:39:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65IEc24w018599;
	Thu, 18 Jun 2026 14:38:59 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ev14eygp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 14:38:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbAIDepImUl0nfIiqgtuoCLVeADE9qwRvXIJlWbJZI9IfyjGZVAwthmA/4r+/GoaI91uPiOf4v1/i7SEFZ62URvZyBUITWVtmUVNQMGoyIqwJM9cu2Y6ct1d3gX7VpyoIxlAT3Voij8nQQY9gq9WpaHw0Re9rxKDgr2hnrYoSnDJ7a2viDZAbcEcXeac6lAPXGeqFN80WMvIeYDyCA0+kny1xwSDApBLS4tvy17pUXCaToc+1ui09fcemONS6QLFPJ1SmjsWJB9Yub98RboctD7GIeCqQyTEYrVdbg3FKKOPVpUvANEE5qH3vGIdtpQaSWw20KXbGdRhpDsadiPf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXECoAbe/LShVF0GRA+eIW/oqDO1YQdpYfBDklVkIBM=;
 b=q6t1OW89BJzawWHa7aB9YSYfwT9o6H707+X3wEMcyxTICQBhW0sd+JCW6j8jDGjBAHiyU8a4hgNfx8kBoQy0FDhY5DSIio+UbMFwCXuMRhFJTEudiXCu6CBq433h33szqcDsQzgSK0QrN/UHFon5sZLavlF1dQI7rNF9Mm25g+IydeZ++z1ZyUkBxGwQWV/vR7x6T4ZAlYac5w8t+Ym6dzJwqJDxO80An1aDStreVO9Knkhf7iq5gCz29m7qUd7nUa8kpBqCooOCJSkt2ibNbOVhARQbg7QDKw/pECE1QX5sDkpK8x+X8vRkvKsJrcK0SLkAKzqf54aGdHtwGoBA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXECoAbe/LShVF0GRA+eIW/oqDO1YQdpYfBDklVkIBM=;
 b=QBUKEwvxa4YB6hTq2TL6Ehj8mlHU9td0C+1HHxqY6/vVIrIaP6mqZ8bGmd9IArVCQbnzACJ1dkLvvOd/weL8Fj2L990wCQGbPA2+k7jzEhjc/HcryMYRnY7zGHBnk3FF2U7nyNPAugqtR42P5+L4ksI12YaZKt0rc+KrTWBgBvk=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by PH8PR10MB997764.namprd10.prod.outlook.com (2603:10b6:510:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 14:38:55 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 14:38:55 +0000
Message-ID: <92447e74-7578-47cb-a08e-f6ca8a9e9274@oracle.com>
Date: Thu, 18 Jun 2026 15:38:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PAHOLE v5 1/5] btf_loader: Handle decl tag component_idx for
 parameters
To: Emil Tsalapatis <emil@etsalapatis.com>,
        Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, acme@kernel.org,
        jose.marchesi@oracle.com, David Faust <david.faust@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <20260618005731.273181-2-vineet.gupta@linux.dev>
 <DJBWI249TH74.C8BAB4SRRTXB@etsalapatis.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DJBWI249TH74.C8BAB4SRRTXB@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::17) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|PH8PR10MB997764:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e72af38-a4b1-4967-c05a-08decd474f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R/tbqTQyaY1CiU6RZgQu8mnd0LourqnItXS09oWeKqX8vRQHXj0CyYckbtN76QIerhXn3gZYMuiaaGawB5lcul+9jGxdR0ehMo4O072LL184PKFYv03CsANibnzJZD7WY8zu8jIoLY2ancRfP4pQf+vl03qIb4CmIUxVW6sPYJMADHgPHSGseRWY7nyNhcquka/kvZNxYlFq+jIQovObi/VfvUhmT9hLyv9qEU53jr23T4+uQSEh4MZYO/r6PQa4QI2iS/x1BaRIE1LDTlPlPeyWA/unwZY3NPdSr/umiCHkMEap0EGlYLa7iY0BvP25JWyznSeEnBRauYQTpLUjh6DQPNp9dL3tit5QtFflvZEdeT/oP0zH0XibJY9Mu37iXbMa//yOSNk0Wux4m0HgTt9IfCesOGQkKuDCaG18R583Vg8LT+djjQtwnWjq+pSvTdyR8yRM4rVISUwsk/9otTmAQtv2KQgUDHRjQ7wjfCiGcygj6j15U8yC8ypLKEC+z2omw+Ac8AFRFrLTsYxGZ7/aiRaVeVrCkjQdGuMtRKyQiVWZmlsWEmJOt2dx9D4ZYS8MvBSPf1ivHlOI0cX0p7hIAVSD4G8m7eEmo5Rw5s8oRi8kpbsu/wes4V4UPE5ILSTpQjSgzbJ4CQdSLNRwnhplVzCWvPV6dl6XzeuPhG1Aqoh/I87XwJRydmuroNkM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QllDLzlGTmFCWDN6TlZpK2o5UTF3MVRQazBZM3NGRXdxMFgxekpKb1F6YVh4?=
 =?utf-8?B?Z04vb1ZBYUNpT3JCS3kwa0VzbzI5NDdncDFFTkYrNGFMd1lPMzhaNVVPN3A2?=
 =?utf-8?B?UjRFbS9CeUdsQUdTMzZ5aTJCbjY0eTd5a3B3WUVsbXdhWnZSUWNkdzhEZC9O?=
 =?utf-8?B?d2J5R2xwcTFWK0plazRBQU44aXB1TEtuaW5QZVQvSStVSE5lbjFENmZRSVNo?=
 =?utf-8?B?SW81eGRrVWM4THhORGp4SFpSbDBsR1l1N0N3RDY4YWlWcjFJRXYyU3FFZVpI?=
 =?utf-8?B?WStCNFM2T05EaGxUNkx2MXRTT21hR2xhYUNtWTZJdTYvNVdIUmFDcVVaMUdC?=
 =?utf-8?B?R0R5dFNsSjZWZ0tmUW83cW5UaGZUVmRRMGxPbFBFRFFFdXh2R3FTSytONXRk?=
 =?utf-8?B?bzRRMmptSmJkZjY5eTFhNXRhV0hSdDFBSDlReWdlSW5YNmJYTWYrTWRxK0Vw?=
 =?utf-8?B?MFpINFdwd3BRQVUremZFVGZlL29XWWlLVW1YbzhpeG9WYjR4QVNJRkl3Z0pZ?=
 =?utf-8?B?dk1GdHd5VnBSWXlMSlZXMm9qem1wT1ZVblJmOWFLQmE1WlJITUF4eFNHcjdU?=
 =?utf-8?B?Y211Y29IQlhzU2ZsOTNkdnNZZWFMekJxNkdiVDhObXVqSTZUTmZMdkZHOEZL?=
 =?utf-8?B?V3NEa3RTU2Q5YjFYMjBhZm9iTURxSEk2K1BkUmZEWDc0MjNaZUJYZkZyRjZk?=
 =?utf-8?B?aGRCWUVZZWhqSmZ5czYybHJHdDRqNGFQS2tZbTd2bEorTzdlaUREUVlYS3lj?=
 =?utf-8?B?N3NuR3NneHZHWUdobmlobkpadVEzTkl0QmhHMjBSOFowOXFKdStNaStveWZW?=
 =?utf-8?B?RS9vL3k0QUxVREtNeGx1ZUtXd3E3Z3hHZXFkUEVlNThsWmNIcEFoUitKcXR4?=
 =?utf-8?B?aWNZRHlXSHZBRWdmcEdlYk55UlY0WTZjbVhCV1pGSE5OWGo0aEJRWEt6MGRy?=
 =?utf-8?B?ejNRVStiK0lrbThaazFTVTdxUHZWUXBSUkRsZlNia0hDUXI5QkdwdllEb0JU?=
 =?utf-8?B?OFFrb2xZVXZJNUswM2FXNDI1ckNPQ2VVWHE5TzFzU2RDRHNkR1ZESUo4OUhT?=
 =?utf-8?B?SXlHaTR5SmV1SWxvVHVOUmpidEhQSzhGVDhhNWx2WXpWRW1Oc2lWRjViM3lY?=
 =?utf-8?B?K0ExdjFkbHZJVnU1OFBXRkI3czZGYjhuVlhRYVZkUU0zVUxJNTJXQ1cwUDJB?=
 =?utf-8?B?ZzVESm5vZTBoSHNFN0hFemZJU0gyemphUWVIQUlLUWJ3WkgwUnJFaDF6bVQ0?=
 =?utf-8?B?RnY1OEEybGZGVFFMRGRQK3dKcUs3Y0EyK2YwWEpPZHlVRmFoNUVaRUxKRTBx?=
 =?utf-8?B?WjZSZVVuZ1VwdGlCVzROM3J4V1BVb3pTWURaeFJ6TmpORGt6WWFEZnpSUWVX?=
 =?utf-8?B?eGd2Z0xQU2lqMkJFTVdPb3o3Qy9PVlptWk1VUVVTUG1OclNVNzAyZUFOSTRP?=
 =?utf-8?B?MkxlMlMrcXpUd2hORi9zQ0VvZkhVNHA0ck1FYzNzRGJwekdhQzEwYVdTV1pk?=
 =?utf-8?B?alQ1Ti83NmpXeERvS05EVFRhWFAzNXhBRFBtRlNNK0cwTkFOWnpMWXpIamF0?=
 =?utf-8?B?bSttcG12aHJjZ1hKOHRJd0JlR2pPWlVpT043aEd3bklaSkFtOVV4TXlyZW1p?=
 =?utf-8?B?VU1GU0dyQ1J0RFBZaWlmVDZJZS8wbmF2NmI4bEdLYjVQUklqVFhjTkE0aU5Y?=
 =?utf-8?B?dkJVNmRQY3FXTjJrdEM5aVVhdnJlR3NPKzBpUWJuY1ZxS0sxbnUxTXJFSEVS?=
 =?utf-8?B?S0oydTFBelFmZFhPTUZZT1lLQjlZRG8rR3pNclhCSWc5MnFVL0svV21uWE05?=
 =?utf-8?B?ZG5CK1BwZHVMUkp1NXNZcUZGQmlQMldJakwwS2ptemd4blFLSjg1K1pKTC92?=
 =?utf-8?B?UWM1LzVhejF0b255RzRXZ2VWaGRwSExQU3RPOUZ1T2hWY1dkbDZrMzNMRFds?=
 =?utf-8?B?WlYvRzlVU1NPeVN6NTVrZ0E3dTh4WkdmSStwN2RpVW1QTms2MXdyOHY0eGFq?=
 =?utf-8?B?R3Z4NjNOeVJVbHRZRC9GYmd4K044M0swQ2VxL0VXMzBkT3NlcGlhVktFQnBR?=
 =?utf-8?B?Y3JmYTMzeEZCOGRnOVErZWpWODZNTUV1VnJHWXJxSW5TY2N3YWIvTU9lMWla?=
 =?utf-8?B?aTZKanRaVHFVNjNNTGpIaXArMVNwc01aUmVzaFQwZGdVZUhjcXd0TW0xQkpM?=
 =?utf-8?B?RDRXWDhWNHFyK2QxTDV2YjR2cjIrNEdNV3lBT2o3YkVLcFlxbFVrTVA2RVFM?=
 =?utf-8?B?NWtXekZxalRUMTFKdmUwTWlQNTVmL1pVNXFmbWU1RXUxK1B6RVFidUM1Sitv?=
 =?utf-8?B?RGJMTGZhMUpxS1dCbTdJKzUzWlpIekowVzZyVytNTVNZN3VyMkhnUT09?=
X-Exchange-RoutingPolicyChecked:
	ktw0OoHIrjGoQ+INKQx7R1OvL9zgW/UlmASkyMZ3USjZa5Y+m8hKgrezaGfVV7pVYHpZ2PPJ0GGzwKyhuR3uKk7oEIrU1V1YXJgBSA1m6wCkHeLvkaNHGKQVBhgepkVzXAN3LpA9hqffuwwtV2Lf2nO+KXTltA7W7EaW7C6+Xh2otCZg4PJt6spBAPqdvH9N48QhNsXnDH9RlJ5ec+SA5J8uOIOUWL2lioz1GMwWtTy27B3Mhi4h4TtjxlCaAulwX4r6zfZKb2KFw2+/MCZVl1ph/c7PU0w5KRSOh+3UkMJzdAUDBfnDOPXkOVk8L2Fjq4li1fkJVlVpoI7k0/LfXA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LZoEFl6CEqtdFFeF7nDXd+Xi/U27I6HY+Mas8DPaOzaSLGVscVBgQv5qu0L6fgtG8LnE7CoZlty7DAz2ZR6ioMrkvizwnrDr7VP/K8fF5XjWuvDgMNlsAuva3AaK6LfaQytlHapszOaHIf8Cu3Q0VSNNHGiM0CcFosuo3RycLPL8iMIWgl93m9UTh8rPgifkxUdyFV20weGVJ0QRpT/eXaiOGhKqtb0Z6E35UzBqvS4uqIKuRiwOsWUfbTLDgdyVZ/kuDwMODY4UvmKvtIJAvGSRd4Fu+day8FMq068HbQOm5zI4l+Fx9p8oc5xhUAJs8iUZ1TsvJkTqSxYJieVOmmB8NLsiecvWaCUHMrAin4wtS2ri8NDKB/ggS3jAjtUXFOOZ5JZagm9BeujG8fRyVy3vgn1eZlH8HWFufg3RsZMT1blzcgMvF7Pytzh7wF+9XZ9zQbeP8hybcixmlgOCE8FyxzNnc7rbuhrMaEH0yqayvAK6aRCfw9WuE1kAAXGpY53wP+Z2bz+NuKLoDKWAf4eCUZ+L/cWLbGng5GQo38rvfLYocKv4sAEVlIBnQVjbIPV8WOQTdJ10pDHSlYoxcnkyce8FczTbhmh284OhV7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e72af38-a4b1-4967-c05a-08decd474f9f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 14:38:55.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3d3SuhVKpfH5wwdRc9TojxoWyG0mXCEfVoTioWiBAjhlYmBpb50aQAA8dKlQoT8pPvqicUFgjAQikKnrlzA7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB997764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606180136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzNSBTYWx0ZWRfX0vfhujRKGhTC
 95mjJL/slRHBXTqXutCPg7F03djD5clP0lwk4vgcCwuMYXkzeQo5p0mAik/uFxhcyhtttn8sX0L
 R78szl3Cb5IOXQhJ1IJ4m4d8fJqghfsBCxuYM+juCkDyj6qHo4/hdMgH66jOxK+dS7YBFq+fl9w
 U1+Xp1gdtuYH69UkRfjPIkOVMAI0wBAojdDTElOguLoGYcwDt1EndpCQ6EC/g3Sml+RYQX4f/4Z
 UfJGeCjDiMxWw7ReqVvjItflJ9uCIvhhFwNAc/w0M/FXOSeqL8jRwaP/BviuduoFfGwj1EMXMhm
 NN9ZU/0BVxVLfQONx+EnWlMuFBV4XVnEdXtVbTChbOXwRp3O8gi/D/ZXyHnHy7u8hpO4BsoyWtR
 5l/XA9XssDeW82JTnFXmE2qdbeBQs4D+o2ZK3Jkl0LkHHQ2uJEArW5g3XzsjdXCn74mwwFBnTx9
 tl8xOrFWP4ysEMUhVxw==
X-Proofpoint-GUID: XT7JVVgRm6xrZbkuxGm8DP9MCHqusaLj
X-Proofpoint-ORIG-GUID: XT7JVVgRm6xrZbkuxGm8DP9MCHqusaLj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzNSBTYWx0ZWRfXwI2mbByPbc0s
 MIeR1vavzefISg9xPdX9P4vj0CbpDRnfiDlz5PuARXixcPR0g6H7iHIdGiTG62WfQ/foPMsK069
 KxIjhltUYF8btETG5/kbXoD6OasmzCm/rL7S6RrpQKf2CMFzWZyA
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a340304 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=CWErhr8FAAAA:8 a=NeUF1mFhfPiQANLCpSwA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=I-g_0vLIplkVOQ0FYkeP:22

On 18/06/2026 05:46, Emil Tsalapatis wrote:
> On Wed Jun 17, 2026 at 8:57 PM EDT, Vineet Gupta wrote:
>> From: Alan Maguire <alan.maguire@oracle.com>
>>
>> A BTF_KIND_DECL_TAG with a non-negative component_idx applies to a
>> specific function parameter (or struct/union member), not to the
>> function itself. btf_loader.c however attached every decl tag to the
>> type named by btf_type->type, so parameter decl tags were recorded on
>> the function rather than on the parameter, and pfunct never printed
>> them with the parameter.
>>
>> Resolve a non-negative component_idx to the corresponding parameter via
>> new helpers ftype__parameter()/function__parameter(), and attach the
>> tag there. Teach the pretty printer to emit a parameter's attributes by
>> factoring the function-level attribute loop into tag__attributes_fprintf()
>> and calling it from ftype__fprintf_parms() for each parameter.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> 
> With one nit:
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> (Also feel free to keep the tags for the other 3 patches since the 
> changes are minimal).
> 
> </SNIP>
> 
>> +	if (component_idx >= 0) {
>> +		struct tag *func_tag = cu__function(cu, tp->type);
>> +
>> +		if (func_tag != NULL) {
>> +			tag = function__parameter(tag__function(func_tag), cu,
>> +						  component_idx);
>> +			if (tag == NULL) {
>> +				fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in BTF id %d\n",
>> +					component_idx, tp->type);
>> +				return 0;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (tag == NULL && component_idx < 0)
>>  		tag = cu__function(cu, tp->type);
> 
> Nit, I think this can be simplified as follows:
> 
> tag = cu__function(cu, tp->type);
> if (component_idx >= 0 && tag != NULL) {
> 	tag = function__parameter(tag__function(tag), cu, component_idx);
> 	if (tag == NULL) {
> 		fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in BTF id %d\n",
> 			component_idx, tp->type);
> 		return 0;
> 	}
> }
> 
> <SNIP>

yep, that looks good to me. if there are no other issues arising from this
round and Vineet is happy with that change I can roll it in when landing this
to save having to roll a v6.

One other issue; we need to install bpftool for CI. I'm working on a change to
support this (installing the version from the kernel tree), I'll try and get
this in place ASAP. Thanks!
