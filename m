Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197943F0B4
	for <dwarves@vger.kernel.org>; Thu, 16 Jul 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208021; cv=fail; b=hSCCWN3ozrFxLJdEjqT32idR1pZW36vXNWytaw830sRRFseEXsjRPpsSkrCNbYVqJFMXha0dSED2KPypUF1BnQqBZbMaLr2lcio+WqN0vOjY17PEVTd+HkuuwtP/IneVnBmbtWA91i+MTHeCg21/5VFYtKa4OciChKCzvWj/b88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208021; c=relaxed/simple;
	bh=oNvuHCXECkzo5pRiahjp90Nx73PlamIo2pOiE7VERmU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=konpjHuabW6QdQdhzHUNKnd9sEI25SrnJLCOzrKSSeHgNjRMTC83E28xTtD5EfUwajiBbElbJ5yN0G+HmTZtkR7AbhUc+bmAjQwQCUPmMxdN2BcQzjOvjP9CJWgHpzqJEbRyT5i2zGrVdCQ/ASCklvazpID+6vZtm7am10C+og8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DOJoNoM8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ywwmG3Dy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DOJoNoM8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ywwmG3Dy"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G32JCj3747662;
	Thu, 16 Jul 2026 13:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SnJWp7jjGwrcfhqjcfU2YFFyvzf3rNJAegb7T0OuMlk=; b=
	DOJoNoM85xxNYSp+nKP1eafy4hSzA/opLiheZdeZW7o2KTKWjEtO+35cD1/8b8gF
	91J9jAwYe+W72JOKzQDWm/KSSo39PifIlY1BH0mKROdA1I43KBXwSD7cJ6XGQoUH
	EFFDf+lU3OFTkaawPK9AG8nGOuJHGKZskwApiLYcOp1OBwJGY1HY3GuNBnarWLpr
	xMdfU8J5cf9yatHlsZ9v1HOLeKsfl6XMf6pDF1u4zBEfI/aooa8+PFaz29Zl+Wg/
	2rhATX04/uCYN3ee9bcWj9QZ8k14KjOncnA1MEbYvSRKoXSGBl0Embsh/F++EZnX
	4WSz+ef6W5Wxstm27P8F9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fben1rhcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 13:20:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDJf0n025010;
	Thu, 16 Jul 2026 13:20:15 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fdmhc15py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 13:20:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFtazGUu9XfXGlS7AxMVlkY/T31UssIYhUv48/8V0h6LOTqcVMRohHEiVzfdQ+JCcYHeeaRSPmxIbZqFkTop53QTbmn2eKe6WWwYO0UUIrqkW1rFQfJSJ/Sot6KdfCSKQRqYPHbbaTKGhL2CM/f2JU68BmaQIz1+u9v1ceYcd0+FmxhViYovmx8kAaJsLxW4x1Xwuz7O4dhhV0i3k2Qrd1R3g04HVw7zJpNIR31EYGPqFXMWyUCxhqsoBJdkUlmH6Ol40mt0d9cHeBkZ9a3BwVetnDDHmZO+LJkM2cRP663qYriMPp5cnN8zjTRpnoPAoXyCraHY6rzTw7Nlr1xA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnJWp7jjGwrcfhqjcfU2YFFyvzf3rNJAegb7T0OuMlk=;
 b=XsrVj68s00c3FIkT0SfcJewoqBBdaYOCKl/CvUN6yYykQM4abBZZUhAPKu2v3Hp36Mhtn02/+9OmZxFq11f5ElCAxw5eu/kq3lyPnK+bjfTKlQYqHsc21VAJ+zbCKedu5DZdMeT96L+edrNXyd6rLMAjgMWuLbsqrHUV5A8lxQytU28nRjIOhfCzsj32erF9RskSEKNCqd+yJx8a7FPnqLm3m7zQ40Q90yZ/J0uy3jpVeh/wakqC/g4cLCRshmAfL0gG6EE2ZSVOI3TAWryAVGRfVEFA0NOUmLuvogdt8eYwFG5QSMaLD/Bbt/3kVrmZySWqsbyBYlSxecILDMoJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnJWp7jjGwrcfhqjcfU2YFFyvzf3rNJAegb7T0OuMlk=;
 b=ywwmG3Dyt+EM2+qXNTfnPDy1CEkIamE1K/6hd6emMQtW3tprKvreXyiG0LGwEYjrMqlxojbz9N8PbXk1icDp5ut6xhNsT+lPrSmVfhj6aiUoUKoc1HnPyA8dGsX2MbRKeoBsv65ixV1qS5f2498rYLJE/BICm3c7kU0q3SQbLm4=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MN2PR10MB4381.namprd10.prod.outlook.com (2603:10b6:208:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 13:19:08 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 13:19:08 +0000
Message-ID: <1246ee79-c064-4e93-babd-996b2d33dba2@oracle.com>
Date: Thu, 16 Jul 2026 14:19:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pahole: fix BTF function parameter type match check
To: Florian Larysch <fl@n621.de>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
References: <20260714140858.17507-1-fl@n621.de>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260714140858.17507-1-fl@n621.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MN2PR10MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d56d97-163b-4f77-3951-08dee33cd13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3hjCa5f4YZG27u7padN8f0eqX36YbI4+EAJQS4yzV8MW4eykab6I+e3rPc3NdINLnsyaZ6IWjXy24mDs5jj6ap9TO7iXhOI/UacaTbZdfEqcxoRsdD/y/KFpZwk9oadRKg/VVihaNrcsdbOVcz0hlEdnl6IXj1DoKT3nhYHFPfjPsIaIy4d7SsV1rHVy1KPLdZd8bAzruWEQCg8JoOI40Fww73lxgsCds4JtbliRky4PP8XnfMOT0V9jyfGEOSmocRCGVQwLvBX6ZEBjcRkZ5MZFZGH37JUd7BnSNcUHBtuBopcMHAoneZvUq0EvKW0JgFophppjF1oGk9tAF3L8Fb17wYALxfW+4mTdgEXQca+0A6X08jKDy8hr+bNcJKGgNQb1u2FIpFRZ+j6o/Wm8V4xa4Gq/0gU26GuIPd6UDFb2tE3hlBAnOqgT7lRKR0S05cIVd75ygkDqEFR7YSV6vq9roCw83ibtrHt2cOuAih1N8rrf1mAUy4gsmbvXNmrAzYB67b4t3BRpmqcSlvqYwlYj5kWCJ9JYIKlEXxCtVg1dGK/KMhQaYaNrUv03054/bNcdDQUOtqjneChlmj24k4mR5+rlEwOaXdNe1eMmjGtvpp2KflfDL7Wc2TV2mU9AWy5QVo1y7fAakJDNbeJqx4uOAdwFJVnrM4LoSB+3ft8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2s5ZHhVeDA1aWhvUEptTnF4Y0RMd2IrYXhsdjZraHgrcUFNREs1Um9TWVpJ?=
 =?utf-8?B?V2hIb00xN3RZdGpqUXZYclZZeHRkTVY0YWY0Vmg4TFIrUjdsY01WNmpCd2p0?=
 =?utf-8?B?cFFWY3pFS3BRZTZZZXI2S2FQelJXZjhZY1NkbjBmYnhPZHMvVWdodUY3a1Jy?=
 =?utf-8?B?K3BWeUZjV2lKL3BrU0dWS2tTZCthcGZuakNJNHJUcXFwTU9SRUgxVHRhYW84?=
 =?utf-8?B?TlNLYThQYWoya3hUZWFTWHBhdnFwYkRlZzNZdzQxYWFMRFM4SjR0LzF2Uk9n?=
 =?utf-8?B?RnZZSzM4VFI1UFhrYkpCY3VuK09YRzVlN3JKZkpEeUc2SzQ1ODFLd3RUb2lN?=
 =?utf-8?B?QzNBbldSbEw2MlVWNXZuVDNIN2wyeWU1WGZEaU1vTk1tZ1doS3plTjQxTmh0?=
 =?utf-8?B?MWhHbEtQUUN1NklCNHJjZzBVaGI0MGEvRnFyYVdNY29JbDRud0p3eXJucGRt?=
 =?utf-8?B?MnllWHAvVERqK2R5T2tzY2FraWRyS3NhRTRrR0tqVWpNM3NINTNCNlZhRG84?=
 =?utf-8?B?ajdyRVdkSlZQR04xMFN1bHZPNUgwbVIwbEpXSFFkUjhJQzhwcWg4MDRrVHVO?=
 =?utf-8?B?QnRxbzAxOTQwcitYY0h1bjNjUU9RUnl2dWJ2RVlyUnlNVjhncllkY2NLNlgx?=
 =?utf-8?B?S3VZSzljUVJIc3lkWW9kNVNEWklTQ3JyVnBDelNqd2s3OEtsbVlaajdxVG9Q?=
 =?utf-8?B?TlRQcG5WbUExVUc4Ui8xdjFRTDJFcUdZUmMzRVZITmFSMWRxYkVKdHJhQUNB?=
 =?utf-8?B?S2VzNkQvSXYrQncxUXVGaUtUZXU5THkwSU13eHlGM3BDRTkvVFBjSDJqZkVP?=
 =?utf-8?B?ZW5aa0FyazhmeU9aQ1BwWExobHkyaTREcnlTc3dzc3l2dDM0eDFvVzdib2Jv?=
 =?utf-8?B?cWdmRTNnaE0ySE0vbEVJak8xamhYV1VsWGM1U1lwRmJoTDQzZFJLaXhoUmJH?=
 =?utf-8?B?Q2JsT29pbzF3aGZGTzhEalR0MXptZDBLVEhldFNRNDdKdXlmSS9kVjEyblBZ?=
 =?utf-8?B?SFhvNE54MTFIN3p4UjA1MEcxakdqenQzTE1PM0UzN1QyejRkK1RCZ211YjZs?=
 =?utf-8?B?aU1vTWFXRXZaZUJYZVozUWc2dzlZem0vYlJpc3lySGRGbEM3bUpKNFBwalJR?=
 =?utf-8?B?Nlp3Q3BGRlV0b1BhTmcyUTZIcW44M1ZyNnNtc2FLWHV5MmZIMTRBTHFZRm5C?=
 =?utf-8?B?R2xudHV6MjM4RkxEMCtKeStYKzBXQlBrNWFlOU9XZjN4T21xaWZvWWcwemVR?=
 =?utf-8?B?d2pBdFBPZmg3RTlDcGRiRXQ2Q2wyUUZwQzJBbG13dTVLd052UlRvWUFwOUNS?=
 =?utf-8?B?bklGTXJiNlRrZWNSbUVLTm5KajA2YmVZL3BDQ2tLVlRxemVSVEFTNDdqUmM4?=
 =?utf-8?B?QXQ5ZWMxcW1WT2dtb0tmcXFpNTZjK3ZObTExMXdxUy9BOVAzRzdwbFhXYUFF?=
 =?utf-8?B?c2g5UUdlRUgwc0dBN0dhUmJHQytCeWs4d3lQaFhqeEg4TTVidk9ib01IdnZG?=
 =?utf-8?B?SnRHZi80RnhWdkx6MUVGdmlObmVnYmkyK0RZMUNxcCswZGIzdzlzdVBOTDJY?=
 =?utf-8?B?QUNjWk04VWJyYXVFWTFXbFpVYWdjaDRCcVpJWTl6MHJ3TGtESHk0Y1hQVVo1?=
 =?utf-8?B?Q1cxejdWS2pxOWxsa0M3bDI0Sk5Dc2xFbzRRZWQxSDgrcVVVL3NLZU9sZUtL?=
 =?utf-8?B?RzRXNkg5QVZmcnBSUmVieDc1bzFLelZGU1RPZ2FCMnZVMm1veW9iQXVyRndV?=
 =?utf-8?B?Tm9vMVArcjZTUlcvYkc0QkQvYzNxWDdxU0tkZDRvUE1HdERYU2RmMXlpSktT?=
 =?utf-8?B?WTZYcThGbG5sS1UzQW8yakZ2UTVSSWU3OGwrQ2ZMR3pPb2t3RGpWcG1BY1kr?=
 =?utf-8?B?akQyTE1sWUdIcGtIYTdxZjJwaWVLcUF3cmJtMHQ5bnNNMXNNUDVnU0JqeXFy?=
 =?utf-8?B?b2pRNkVjT21KbWs2WlMzbXg2SzkwOGtXRUFucGMzM3dwQmNzS3NjblJIaWt3?=
 =?utf-8?B?ZzVoaVRGWDFXby9IRVllVWgyQ3Q3aUZFbFFjZ3o3TnNyK3Z3R1NDMEN5Z1JT?=
 =?utf-8?B?TDVmbWVvYzBSWGhWK0w2YlR6Uk1WY0QzN1N2Lzl0VU0yS1A0RmdmREZKM1lK?=
 =?utf-8?B?TWlXUmM3eWZmaEJaQjd5YjVxUFZrdG1vVVlPRjEzK0cwVzJaTWJCK1huZU1q?=
 =?utf-8?B?Z3NMRXNlNHVMVmRiNFNxb09sRlY0SFQ3dVJUajkwdzZSOTZuUStqZWpsRXFr?=
 =?utf-8?B?b2NVdnpkQ0txTHdlMFBXWHpvTlJBUXR3S2l5NVNiZEgrVkx6N0laKzAzUVpU?=
 =?utf-8?B?U3ZTZU9uWXdCZ3ZkZ2JQalpRQmNxMXU2QlRnWSt4aisycUViZVZRdz09?=
X-Exchange-RoutingPolicyChecked:
	Pxr7BGT9xUPJbihOhSJxbGiKhtZ0NdY0j293Tz019aG9qufGbvGUjGHLk6BshXVePInM5wjPVLklxMd4p5ojmBDp/z+QB5nqn8SKzSS4YVXePI74hnaDAi26zz+5N7VWtg5AFfEOVoWzxgQJVhSvyFYzWpwqPm0bckOPl4oct4Wydci+F1bwipnOYa1acGTqBtvKOLnz3Fey2+LHk5z4RxKcgPt82qj2leX4ttPgbKKJ4lPRFq2w2rMPWdU6v87vlnf/+8qzON6UBPgzneSocpkXnPoDWsJ2LIzrh0QMuYBbCch5IDY8nTY50mub8apUp9ZCBcgKUTFq1auSbY+HJA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WDQnTKtYsa9Ehquq25JqHKQMeHBFGZAIM1izor03VW/eS4pqh5Ljjoe3Y6Q8OSDl2kE1abpW5ZYF3rehy4BueZeHnMGPwiUXRkzvsZ02L9GYdPXTHuJ5KNmLXVLxSNGWYdXpnsCXHDJc/Tii6ECpGQTaqQB9npJzUUthQXXmDH69kNwN6kwuyJmcU2NfhmE7oAMRUA16O644mb6ynH+Wqjwh7NEO5ziAH3tiJFxZYqHk5OeRJxaWW8IpSC8/NfjtNNERZH2s8CL6NHBqteZB1reOZkOJtV61xG09IZCrGeGbrQ11soBXfrXk7JpL1Cx/c1pIZjHnok6ThHhRhVVnLwhBA5tJOE2n9oiUzbdHY/6unomuSDkq+3cQK2wrUI0P/8PpKQ/d5ZVZ+lLLGjZR/bxA9rpaj0VP+QxcIBGuBhPMbrBAji2+RJ8YDoiZSzYkg/JxrJKM6JFpjva3ClfqtXuvnaOmCcuOZmeVU9jqCFPQznzVHndUCyHwVONLohSFkzumKcqcQ0obctiV9u7Cx/agVG87K0q1+lPZMx+yK0K/UiRDm6lj5olvndoc9zUXBNRu6IObiHD1bS7T98F45tFvGJ9Z4nrxWInZEBWGMa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d56d97-163b-4f77-3951-08dee33cd13a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:19:08.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sl/OVi1tUNj2S3fJyLnOxD0JB2l9Mkkx3FUpxUxPTtLlHpi9CdxwS97H+O3ieQI+rFdiX/zRWOZkEX793Kshmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607160137
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a58da8f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=mTTwAUO23BErR4mYSioA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13632
X-Proofpoint-GUID: V8ip6ojj3zUPKYtyqEFS3n_ZdJdPOuBR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzNyBTYWx0ZWRfX8RZ5Zk41MMtn
 UBYMZM7MXasI04hC6x4EnigFC5iHHreZDeSPF64mWWE1uTEAQjW/pBVPtZHJbn3S/vIpneUOhmt
 MzbTpWp6bRe/rZC6Q3frO1TGai1mw9TfgFvfph0v2Y3vtjaScFIyGBu0VntdYJEtbZmzLAoAy0F
 /eLlX8d4mlbJBJWozvC5zjyCg2XrTntg4jrH2lDnu6kLiOFoNoG3R01Wnm3gT3+Oyo5I+1oGjIU
 gJyh5TiqsI7k7HYCYWWlhx46Rpn2PcZu84EQFTlHPb3tKxCIFjRY1fYn6GZNpNLsfvMBaTa9PBz
 9zXxlfPfjtP76oxJG0ApSowcZJz5uCoQkeamRFTjkckECCqLXpXMTp1y4Kf00gxDXyIioFKENro
 bxdWtmGzR2P6Q2mivQw0U+AKAFEJyVIQljwD9x1CTY3L7x+rr7FJWX26spkC9FWZ06GriIBEO1I
 J9bIQTM/XyNGXQGezLhhLP/+YWl77VBpQ9OTjHQc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzNyBTYWx0ZWRfXyoKXo3SSbFBs
 LUBy2NrOhmEL+CxJf0Wxuf1iaBJ5u9Q0NypoiYd+kC2hN1rSviYHaMEFOJJSgCdjDGUL56FTU6A
 pFV1/1agG6v36Si+KBXFpu4Wb4eXAcY6E+n5U7dH5g920T38yZ11
X-Proofpoint-ORIG-GUID: V8ip6ojj3zUPKYtyqEFS3n_ZdJdPOuBR

On 14/07/2026 15:08, Florian Larysch wrote:
> The BTF_KIND_FUNC_PROTO arm in types__match() first checks whether two
> function types identified by t1/t2 have matching return types and then
> attempts to iterate over the function parameters (p1/p2) to check them
> for compatibility too.
> 
> However, the loop just repeats the check on t1/t2 instead of p1/p2, so
> we just keep re-checking return type compatibility, ignoring possible
> mismatches of the actual parameter types.
> 
> Fix this by actually comparing p1 and p2. This also resolves a
> unused-but-set-variable build-time warning.
> 
> Signed-off-by: Florian Larysch <fl@n621.de>

Great catch, applied. Thank you!

Alan

> ---
>  btf_encoder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d5af706..3aca2c2 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1129,8 +1129,8 @@ static bool types__match(struct btf_encoder *encoder,
>  					  btf2, t2->type))
>  				return false;
>  			for (i = 0; i < vlen; i++, p1++, p2++) {
> -				if (!types__match(encoder, btf1, t1->type,
> -						  btf2, t2->type))
> +				if (!types__match(encoder, btf1, p1->type,
> +						  btf2, p2->type))
>  					return false;
>  			}
>  			return true;
> -- 
> 2.55.0
> 

