Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C22F8C34
	for <dwarves@vger.kernel.org>; Fri,  4 Jul 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646902; cv=fail; b=racTYD0NndAcrWS0s7PHx2ClP7VCeTZWk4i7JYAsDuRaMlWVDUyTis3b5MSaLw9MAxsZ1ktA/NwxHitys6iJ1N1j1mnMDNZds9FrsCG9i9RKRgqGb0R7p4X7kzDfbQsZQJquMhhtlsUBvcPRCJ/HPX0ZlaDYgbuqtG35pEgYu3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646902; c=relaxed/simple;
	bh=wQfaxKe+ojLwX1MD7ZY/d4KOAwsE3DrFqcFPP+FmrCg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gmQyQ/2sa2u7gIP7+V+FQ3W3Oyo0UcDVZ8UgeLx1+LR1+K0u9CzCBaJN0Qo4B3Rg6mM5nowFeGiU7cFXJ5udlWqsZXbnLw+DvIh+ZRl5rtn5meTYYNG6LtZkpFFtSMDfI34EDmK1h4J1JnCsPkx6V6S5cRX8q1RhOsKd2pISNjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iabGvltm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BZT7Nc11; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iabGvltm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BZT7Nc11"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649Yvnv017067;
	Fri, 4 Jul 2025 16:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RC76I2z7+iF4IoiXmETt/qTwDnHXRkIdGxv2iZPH2kM=; b=
	iabGvltmvr9HFk4QfR3OX80klo3gpDkOfWZhQNKPTSUsPcXcxkaRdCJb3of9lm2y
	CKCZN6jLoezJcuuOqqiVypbSzYp938+AOUTj0LN29FWiUqdmcOSBseCP+d//2QK7
	o8wybj6++1vs3VJ3PbyT00sQRU0AIba/KIy7iKCAn443s4lrSOK4hD3x+xUTJDKI
	MfaZapv6Dhmlm9hmfVD+el2R/geh/YJVTQ6AinCTpHnFBiBIHOarJEa/3XoSA3uE
	ERdIGgdp5OePXOY4+DBGLgm3G9l5ugIDM/HHyYXmByF2MIRP7CS2hoUgWQZlq67f
	dzzD9cL34WxtRfhHzXQ3Lw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xxb169-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 16:34:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 564ExJEj015173;
	Fri, 4 Jul 2025 16:34:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6udqmkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 16:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GD6oJmC+x+HGA1heOg1R7bDPnpTiiaOgW84ztcKWiQS1N5zu4cnVL1C4q3QnsaK1N+EgYCczTehEtDQGb+EE6LsWVq/3a2RXMYxdJk9FczuWZPF46cJnHFkkMZsC3s2Rz5Y7UpChRJIBMfHdYiYTi0QKSFWnPW4pTWcSbdKDfbU6FiOqYwtwLLEqJHCUJUlhWfWBj5u351UzHaeB+pPym5DxvSAXFZLbw898qwMCvuEuTz82i3qaHNoO3qNFFwpXQefnA9xx5/2oCfQrl7pZyvfRdyop7M41ta0uWNK8M0KgEtTXOfH7FoYVwysMVQtTkc1L7XeuuTX3lOX7RiycSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC76I2z7+iF4IoiXmETt/qTwDnHXRkIdGxv2iZPH2kM=;
 b=EPP/QUwTt8vtz+7Ncke+XMIZ7sRntbBx8UlCjiBw7AwfIC48k/0aqDOB9KkhrtMj+4HDJjRdPVW0FyCQ5gL/9XYyacfY6SpqmlALNZV90G/dMbAlbzI7n4q5EXYfxJa+mDGsWq/6SMYmG6ODlhnPKKnnl83FuHEXEsfHdD8MZCRfOBk2s+qg34+FEdrJZfnY49d7mER7M9zWU9cI6Bn/E5wMw+6btr50i/XEHtpvYK427VgICb4qAgS7M2GeECrOinpT1067V/BBWLMqr/SMzbVL6dRxT3P/g9TdQMuKPlx+ynuihWFcvrVG/gb+Py/iNWt7V4EunwNQhFkl+XSAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC76I2z7+iF4IoiXmETt/qTwDnHXRkIdGxv2iZPH2kM=;
 b=BZT7Nc11A53vtasLjcN0OIcUi4XJdvsf9gnRieuCcTXS3H3NXS+frpCt7gve6NcH7oZt355pwe1enGK6jOpnQqeMQbYLi9NOWnFKrgGFe6ELSQH8A5y6NKfVhH7AdrkezwEazjDkZ9zTvaWduidckdEVKm0NqSJqcT7USL524ZE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ5PPFCAF322559.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 4 Jul
 2025 16:34:52 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 16:34:51 +0000
Message-ID: <a43307cd-bfb8-4ff1-b03e-2d6732af85ce@oracle.com>
Date: Fri, 4 Jul 2025 17:34:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btf_loader: infer alignment for zero-length arrays
To: Antoine Tenart <atenart@kernel.org>, dwarves@vger.kernel.org
Cc: pvalerio@redhat.com
References: <20250625152329.28601-1-atenart@kernel.org>
 <20250625152329.28601-2-atenart@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250625152329.28601-2-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::17) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ5PPFCAF322559:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8735ad-bfc8-4458-f753-08ddbb18b305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk5UV3pqaVhHd1FqeDJuQytDNWd6cnRreE5EZ2lESjdVczIxWWNueTdNaEQ5?=
 =?utf-8?B?SWNBMTRBdEJ1VHlQR3VCR2xOZXJxeEF3QXhtNHhpV0NROTdPZEcxeE1yU2VN?=
 =?utf-8?B?NlBENk9HdnNZeCt4NWZvdHhMcmtaMzdCbjNPRkxsOVFVWTFJV0Q4UU5ZWDVz?=
 =?utf-8?B?OWhvOVlkTVVBVlVrUDZVWjMwMDNyZ2s4NUh3RFlacFVVREpQZ05YRDZYazNU?=
 =?utf-8?B?WTZ5WS95Qmxxd2ZLSHFQZHVkRW9jSzBVeUtBc3NaMXVKbzhsYjcwbWIwb3or?=
 =?utf-8?B?NXFWY1RTRkJabDU1K2RyVXdRa2krTmJNMFIzNUQyVUxQQW5GdWZneEw2ZWJl?=
 =?utf-8?B?V3pYR082aktVNFpQZnJMN0MzZjFpR1dzT2ZUbzVuVXcrd0I0VlZBVEtkK1lo?=
 =?utf-8?B?U0hackc5MnRKdVpESHpDK0R4aDl2VXBtRlJVUDdzdm1UcU1yK2hReTA1Y2xS?=
 =?utf-8?B?VW90blc1aDFud2FkR3BXbFJtODFvaGpzTEFoU0wrZlVSVnM5VUZqcU12bXpJ?=
 =?utf-8?B?T2lXV1ZLVmdpa1lJQzk3NlhFN3NKM3pOLzhBdG1adHgrcC8rRFhBc1ZyQ29K?=
 =?utf-8?B?RGpDZ2lwd0k3WUtLWk81ZzFwY0dNNWY1MVppb1lqaUN0dmhBUjVCc1JrYktp?=
 =?utf-8?B?SHE3OGRLTXY4SWJBRnN6aGo3Z3dyYmUvMThxNSs0VklrQTlpY2UxM1Qyei9P?=
 =?utf-8?B?QytESGkxcFVlMitwMlNOaDFpRUpDM05vZjBXbHdKWWdPUS9EalhsdXBFWmhz?=
 =?utf-8?B?VnVMNmdRVnBBdFF4ckdrREpDa0FXeVRNK1M5NmN1YmZTaHdSZ0xmYVpSdU1a?=
 =?utf-8?B?YUd6TGZnRXlSbzJsRHB2Q2lISVo4eXljc0ZYKy9jaDF1dmJ4dDVQRlRuRUNz?=
 =?utf-8?B?TC9JcW9VTzBiMENERnZQOUdtK3RvYVd2RVRpSkM3OHhjUVh0NE9NamhjQ0Na?=
 =?utf-8?B?eFFMamNlSlkyUjgzWnkvdU1ZdkNWSDNBb2xqWlo5SWo0ek5UeFc5U3JKN25V?=
 =?utf-8?B?Si9KclF2RERQWlJGbm4yQW5PMktHazVMeEgwMEhTSnhLZEZmblRjbmlpSXBK?=
 =?utf-8?B?d2dPMEdWUDRDZUYzaFp6WE1BOG9kUlRnbHBMWDdkWlhDaVEvR1kwbUJWRmcr?=
 =?utf-8?B?WDNOZER4cVVTZmUzZGMvREZORUpjR0JHSjlPcFRPZlBXenFLRUFJUkt4dmVZ?=
 =?utf-8?B?OTF6ZUF0OXl3d1RFa0g5dWZTSEgrc0ZVanlSd1loSFRqZGFVQnpCMGRaN1Qw?=
 =?utf-8?B?NWk5ODdsNElrdGZ0ZVNPTWRrNnIzQ0VidURJYXNLUHJJbkd0dHVMdGpGZ3RF?=
 =?utf-8?B?alBMWHZGem8yZEZWdkZqTUFVVmtwYjlWZEdJdTEyakNocXhZeFVZTjEwUGhs?=
 =?utf-8?B?SHZwdTE0VE92S0RwNCtaSVdtajlyVDk5eENCZXJsU2t4ZU5PZlFDNDFQYWpp?=
 =?utf-8?B?L1NEVFpPWlFUTWVqY1M5UHEwZ2JzYTlGWmhRYnRSd2dEeVg0VWVQRFpDdHhi?=
 =?utf-8?B?TWw5TmQvRW9aK0RRWS9GejdRdkIrWm9xLy85bW1OTUVSOUJ5bzhIMDdRbzRL?=
 =?utf-8?B?Y2grUHdySWF0Y3hyUG1RYlYwOGpyZjQ4Q1VsQXQvWVhxVHVHTVdJS3FoMFVN?=
 =?utf-8?B?NVR2ZGR6QWZpTjdFZ0hSS2V2dnRXaGdXdHQ1NXlaRk5hSEJjRkpUb3VyNmlr?=
 =?utf-8?B?cUJrMnFJbXl1bnJSUWVTNDFYLzdPb1o5aXlXQm91ZEhwTWZKMVBzSlNoakhK?=
 =?utf-8?B?ZVZRRFBubjZhaTl2V1V4ZWowMHU1RVozc2RiQlhGbzlUV2NKNnpxd0tWSnJv?=
 =?utf-8?B?bmtKUkNoZTJycXhnRGJSWThEcFF4V2p0MUltQi94aGpCc2ZqL0ZXL2daLzdz?=
 =?utf-8?B?M0F0eUFCK0FWbHUvVWZraUlhbFNFRUpwazJOdmtQR2dhU0dwNzhrNXhoUENL?=
 =?utf-8?Q?oBOZcY5oCXY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LytMN211VU51OGVwYUtGb3hmR2VEWitmZldtRHM2V3pEUEc0eXUxRlA0Njcz?=
 =?utf-8?B?RFQxUkJ2VHg3Qng3NE00ZmhWekVNUWRKVzZVU2EySWoyVHBpcjM3ZHp4dnE0?=
 =?utf-8?B?b0RBNXE0a2txWjhUb3pST1ovYy95eTVYb0NLRmxuS1NYNE9FMFMydmU1eFNI?=
 =?utf-8?B?Q0E3NjF6bEFTN1VBUjBaaTZMRVZxNzFwSDFtTlo0NmhGTlhERUo0bDZTdjdO?=
 =?utf-8?B?ZTRRdGVEd0ZKRmViVFVMMTFVcGRTTkZJMUFweUhFTFBYUEkrWExGZC9xTHBv?=
 =?utf-8?B?UDMrbDkzekhScmxTTWdrNjluZkovZFBpUytiREZWSExTeFAzQkpQUEg2ckp0?=
 =?utf-8?B?N3VLdHhaaEFTamw0LzkzdENBbzdydVlCc1JPRzF3T29FT1pUcCt2ZUZ6Y3Jl?=
 =?utf-8?B?ZWhiZElFMVhaZHo1c1dDL1Nra3lEN2MweVd5Vm1BNzVnR1FJUkpVUG5tQVVh?=
 =?utf-8?B?bW9lb2FTalBITzdxRmdvMHRSdm56WFd2WjJqY3pZczNHMTNLbHN1ZlR5cEI5?=
 =?utf-8?B?TWNQVlIxaXV6UmU2U2JXT2ZLYy9HakRYYTRCZTRzT2JOUExwazR5ck4wdXNa?=
 =?utf-8?B?VTF6aDJ1S213cllOUU9EZmFjempjMXZyUVVXMU5pTzd0NDJ4Zjh1QjB5TkJi?=
 =?utf-8?B?VHNQVzlZUHFOVWoxQ1k0R095dHY2NGVad2o3azB6YndMc1dFN3NhYVJNbmlV?=
 =?utf-8?B?S1R4YTZRbkY0MHQ4bit1aEUvN2VJM2l1SDNvRzVRRWlrZHg3eHR4ZFkxNDFq?=
 =?utf-8?B?MVRpbVA4T09wTWVqQktZTDV0L1lRY3UvODY1T1R4SStmWlUwS2N0YVNRbTdU?=
 =?utf-8?B?WVV6RG5NSkZvMzN6WTdEVGdvek9lY3BDRzY5bEsyaHJWZXIwZXF3czNORG1y?=
 =?utf-8?B?RkhWMkN6amthSGlrcTE2V0wwZklUYnJyRHpCV3E3eFJFRTU0UGltekRQYXdp?=
 =?utf-8?B?d2p5QS9QRHZZbmNiR0NVajBnNk5Qc0xJamttSy9sS2VCYlBMckxGZFVEVEdj?=
 =?utf-8?B?c01uY1k4clJYVmJ2cmtqL21iTGJoaWsrTVExRFZ6TklTYTMvNm5DOFRmRDRn?=
 =?utf-8?B?RHdRZWh3aExRa3plK2hxYUVZcHVqQW5YaXNaYlBubWhTU2Y1bHYyYWV5MFBN?=
 =?utf-8?B?ZXg0NGdUbW5pVlRYajhHVFBqc0NpZkQ4NmNHZHdJQWhiSFRsQUpVdTFIUEpI?=
 =?utf-8?B?M2JwOWJ3UFRPNWR3ZDFOOGV5Q0pXNU5MNWRoTkxZTGp0QnZ4U0x3Zkk4dDNZ?=
 =?utf-8?B?bE5rWHhsSHEwbHFRelVOZFBjSVE3Uk9HMTBjOFZqMWRqQUNTVkFUN0FJSzJs?=
 =?utf-8?B?S2l4RkRUOEZHZHY4RlhWS3g0WmtZUTlRY1N0bjhsZjJ4dytXLytLazZOVlRZ?=
 =?utf-8?B?Vno0cWpVV2hVQzU2cFZZeU5tOEVObTJjaFhSRmNmTUl3TFBYN0p2clFCd0tv?=
 =?utf-8?B?UVBwNVc1RVFrL2t6YW40RnFjdWJHNkhYNVhCeVZTWFd1M2tRUWNobmRucUZH?=
 =?utf-8?B?QjdvUWxMUEF6c1pwQjV0YkdFRVcydE5sdVI2ZFhqblRYSVJlU3VvdzlVTGh3?=
 =?utf-8?B?RzRKOS9DYmJPZVhuUTJtQmFkbjdJZkYyalF0Z3pGYzZaNitGYnJWQnBlRHd6?=
 =?utf-8?B?ZSt0QlYvL3Y3Mms5Wng0NFJ6Y256dU5iZkVzREhSZjJyc2VEdHF2YkhxeC9t?=
 =?utf-8?B?REMwckJNOUVpTno2RFBScXBoT093RXgva2FSSnlicDd5V0pSUmE0SFhKVWVi?=
 =?utf-8?B?MHo0aVB5TGRqd3cvTk5td29neU5neDBYQnhqVzVMOEIzc0JjVXhBWHh3V0xu?=
 =?utf-8?B?MFV1TGNCVDc1bjlWSUMyY1RHUElrdHprcVlqaDRsTWtsWVF4d2EvME1TTWlK?=
 =?utf-8?B?ZTF0eHNHMmIvbjg1UXJtdzhrS1FnV0RMV1lJbFBsZVJMNzhVOWNFU3M5SG03?=
 =?utf-8?B?ZkVPSm91WWcxcXdEcjFmSTJMZEkxTnFUYWpLL1VsRWVNZWJhVTZacWtCMU8w?=
 =?utf-8?B?MW1UeVhOY0tLSFJrQ3dGTjc0V2k5MEgyV1JMeE5XRFVkcUNIY0FhMHo4UlRO?=
 =?utf-8?B?RkNwdUNRdUk5ZThrV0lXKzBRdzJqMUxHbExOV0Jqc01UNlorbm4raERPQStV?=
 =?utf-8?B?MzFPVVQyU2psaGRWZGlYSUZBUVcwMG9hZGNreitQeUUxK05GdXM0RC9DZC92?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dpBB5Wch0lqFauirLFnGZbppx+KHvWfXKgvfOB1CpYn6Sp2c4ZIu0fCK8lw/AF5XsnASmut5CUiide+tYXGlm0o8HUVQVWyVtnJ3mIjXbXXf+sfqnpimUHvPaQAXoh/xE1ABXn2Q6v+L7bOjKqdmpiM5c6O/iEtrsjzutcSKWUhpi/yt6PadGK4TvRQc0PFa+SxTHwnzsfubLoU3fJUVJS2fFlv2pg1WziJt056jda6riYNBBi2IGRKVFzCD9+dh87hcIdtWr1Hb+FVnX/IyCUOkrmEmYztovvUSly4qZAwRjiLlK12xUx1zI0MzMKA5iJBUTzam/2qNs0sNzGOWanenmKWDDuMOIhuvdMw18l7I5UHtbJDS3mhF8BeG1zFNFzIuyg80wEAIBg5VioqFhfR8Ydy13z/GY61Hx7RC/o86N0syVUKeU0dOdtNJWdeYxGGu6ZdIXUn5/ygyP8YUgwSuC/05uJcjFOc1DatWNyJSURISVr69rhMXMEgzvgkdDM4qLERarGRncbPbqkWwj183FjA8WENpQlYr38sf7fD5L38RUPDUSu6VlXi0tgihp1GlFNnrjEyVNf2vMEr9ItkBLxTJo4M/aKJ2jfKMGMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8735ad-bfc8-4458-f753-08ddbb18b305
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 16:34:51.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LQ95uqGClQzBYADLYXxhphiqfMdl6LXTzmluzi1+pjAojcNVS21mGzFwcJpfhhTPuUiOPGgf0k+Zi6g1bVIiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCAF322559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507040125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNSBTYWx0ZWRfX2i9+4tCtMRZK 1Hh2205KxJfh9DbNWCw6ShzEjdsOBgPeylvjjfHXqBSxrEcfz8RXjK09t/wVpM/0Ha/27+pFTyg ls/LtB5y/phdiBNdhb4t5IP8IYfnMEbDfBH5wi3QK1K+Ty3oPj5KdUdqjL/OZvn5leFVzG4PFYU
 ZPSNEiWcfet2ACzI+hRifcGX5hG7q5aybNKlZqp8gn1O3/QM9d7io6kd58AgFDVYx0SK1SdHwzY 8kxeOMZHsz23rY6Hm4ifgtkHSQmjM29A8A5mPo5dWBga3w0dsXUPsQuu4gNp/1+IVJARg4t61X8 /i4liGZhL+PKhXkVRa9Vz3EivJaJeH24vg9zH142TVP2ASmBqO9thqQ6FRdFFHd7zDGWB9oBc23
 lrEXthBkgheyE+gIs+ThwRrGsFkZ7H0wkqEzNAJIURd8eM9DwPOEvjRAb96aYTzRPNtI+USw
X-Proofpoint-ORIG-GUID: 5YYDeGv5b81owpozaeAyIbJhu7F5KJ7H
X-Proofpoint-GUID: 5YYDeGv5b81owpozaeAyIbJhu7F5KJ7H
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=686802af b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7RuVNZPScD8nBR_n4BoA:9 a=QEXdDO2ut3YA:10

On 25/06/2025 16:23, Antoine Tenart wrote:
> Zero sized arrays do not go through the bitfield fixup logic, which in
> turn makes them to skip the alignment infer logic. The result is
> zero-length arrays being incorrectly aligned when an explicit statement
> is needed. E.g. this happens for variable length arrays at end of
> structures, or for 0-length ones.
> 
> Before this patch we can see:
> 
>   struct skb_ext {
> 	refcount_t                 refcnt;               /*     0     4 */
> 	u8                         offset[4];            /*     4     4 */
> 	u8                         chunks;               /*     8     1 */
> 
> 	/* XXX 7 bytes hole, try to pack */
> 
> 	char                       data[];               /*    16     0 */
> 
> 	/* size: 16, cachelines: 1, members: 4 */
> 	/* sum members: 9, holes: 1, sum holes: 7 */
> 	/* last cacheline: 16 bytes */
>   } __attribute__((__aligned__(8)));
> 
>   offsetof(struct skb_ext, data) returns 9.
> 
> After this patch we get:
> 
>   struct skb_ext {
> 	refcount_t                 refcnt;               /*     0     4 */
> 	u8                         offset[4];            /*     4     4 */
> 	u8                         chunks;               /*     8     1 */
> 
> 	/* XXX 7 bytes hole, try to pack */
> 
> 	char                       data[] __attribute__((__aligned__(8))); /*    16     0 */
> 
> 	/* size: 16, cachelines: 1, members: 4 */
> 	/* sum members: 9, holes: 1, sum holes: 7 */
> 	/* forced alignments: 1, forced holes: 1, sum forced holes: 7 */
> 	/* last cacheline: 16 bytes */
>   } __attribute__((__aligned__(8)));
> 
>   offsetof(struct skb_ext, data) returns 16.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

with a small suggestion below..

> ---
>  btf_loader.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index f4f9f65289b5..76771afedd95 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -648,6 +648,10 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
>  		/* if BTF data is incorrect and has size == 0, skip field,
>  		 * instead of crashing */

nit: could we update the comment here to reflect the change, adding
something like "however we still need to infer alignment for cases like
zero/variable-length arays".


>  		if (pos->byte_size == 0) {
> +			pos->alignment = class__infer_alignment(conf,
> +								pos->byte_offset,
> +								tag__natural_alignment(type, cu),
> +								smallest_offset);
>  			continue;
>  		}
>  

