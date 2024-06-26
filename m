Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D247187331
	for <dwarves@vger.kernel.org>; Wed, 26 Jun 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412202; cv=fail; b=eOpRqU5N4+THG6Oe7jS3aqKeoO0HBAWmG8xtjYhQqfQqy8kZzqL28GYsMSbWsEtEPotxcVbhV8fKwFiY74jTBfwifQdOrQcQAuVaQbhFvEbtaT+a+u90HbpPiB/7J8EtEt+gHx9lXghoFnaEG5URZlrEzVIbemhqwv4qBXqe+QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412202; c=relaxed/simple;
	bh=CRSpdkXZfaDHcbD6+fjov8bjBNOgonL8wvyh/k4uuJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RE1Ck3lpPyh0lqDhKX+mdzlhylsud4yMqFXkw5pBv+vtBUn/jidOyhHJuMB0UsS92QFlJT/teUokA1/WjJE4w1feO0lCp/qAUuHLYBjvhjpwwd81Jd3gyaWIMuZWccpDRShLZeCxT4YmO06RIJK7haLLvgMlpb+LpyQlCI4gGaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AMaWhdpQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y5joDcjy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AMaWhdpQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y5joDcjy"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sKdF001393;
	Wed, 26 Jun 2024 14:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=CRSpdkXZfaDHcbD6+fjov8bjBNOgonL8wvyh/k4uuJg=; b=
	AMaWhdpQx1VvMNemyctrmYudQ0nNcGJ22m577blYzTHCXmrL62+GNwJnIfXyFNhM
	24A+ewC/zm14eM4kKUyZwCCZi3LiL3tPhpUsyNPUVoA72VPsp2Rp4QphhI8nYkMG
	vThYJkO4Rx2tV0clgXB7ys+a6PN4GsSfIiqpi7QlaC4lQu7cTnlT9/cEgkpV4UXi
	d/CWr+q4gwUWTxIOjgnx/L0u/YcJGINMYdpczGwlw6NLByAsEOPEoXXCYh4pZ1Yo
	SF038b/MgSXqytKLwRb478P2InDr6O+zBD//nFlD63uVrQ0Vl7C1DXPLaeGlVssc
	7kEwiRg71vw/eiBxezYeFA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb3gp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 14:29:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QDQZeb001351;
	Wed, 26 Jun 2024 14:29:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn29ur12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 14:29:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw+YVwbF9ig568U1YIY4UI5j7HBY8VioD/HbsPgls6lx91vXb5Zv14gPzBQ9H72xbfpB5iqpT4aLSQYgzI0kMSU7MFlQx7gbzXHxHaONChsjPz5OZvaDdhQ3P0G3q5wOxOZXuW/HAXRbYq4ezM6XMbbL89apFGNBGE40EtcPdlqUolDwodtqObX4kh6m/H1PDS0Jga/gDnd++mUWzDYq085F5S9YcnH6iPlrOrzLfRW5UgfaFqmZ3F44RHGbBkrJg3tap/kiW8xmIrfOOjIZVvkFUtz08I5cERiBOqcxtiZn/bunLrvWEJ0tSGk8/PFgY/9zM1NZzDQxKb/yC2QaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRSpdkXZfaDHcbD6+fjov8bjBNOgonL8wvyh/k4uuJg=;
 b=XXykhQkQRgTrwD3AOM12Xy9vRyuszQGFIwoZ9kAkeaWEYFhHvIH/5Cu5koIDplC+dHucQKadTaLhzNWaHS4q6zWbgAgcS5g1nTUn01k5uPANE68c/glEBbpDl3I8Q7NpIjBt4krltIGt9rACOwWrVZQ3k69hLhZwlrBz74ynVJ67olIRfA83T0dFpAappoi+zk4LBZ7hGhumdz75Dc2+wevqLXyc1eHVHd9Vl91qloS22+pbnEE2Td6r10hJ2VMWKgl6fu+rrl4Y1C9QDFR2Xmyr0lo+ZOWf+jrppTsuwyqzsDuaOmHKkB/GDRaiSq8s2vByL/tm3H3V+iH+Ntt/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRSpdkXZfaDHcbD6+fjov8bjBNOgonL8wvyh/k4uuJg=;
 b=Y5joDcjyG3EBwM4nnX7FEKtlCiy/3NZVdXYLT1JUCvom6mbkbRew1VLjUex0C+a4fEwlrmTJ/k4ENbR6o0gTmw+4H6gKIuJs4aI1p4Y6KUPcibTpkqp8msK6SwtoyR89xNGsIew2TJC+AtmzUoQitzBgDsId4FM6/aJEhe53P/g=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4475.namprd10.prod.outlook.com (2603:10b6:806:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 14:29:43 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 14:29:43 +0000
Message-ID: <c1414fb5-f7a8-4cb4-9c27-9c0c9b431f28@oracle.com>
Date: Wed, 26 Jun 2024 15:29:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
To: Dominique Martinet <asmadeus@codewreck.org>, acme@kernel.org
Cc: andrii.nakryiko@gmail.com, dwarves@vger.kernel.org, jolsa@kernel.org,
        williams@redhat.com, kcarcia@redhat.com, dxu@dxuuu.xyz,
        eddyz87@gmail.com
References: <20240626032253.3406460-1-asmadeus@codewreck.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240626032253.3406460-1-asmadeus@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0625.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d3e45e-7e80-4d04-08ea-08dc95ec6bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UzQrRkVvNWV1bGtRYndiT3JseXNOcmNwS2RQb3F6Q2puV3V4QzBiTmpHVm5Q?=
 =?utf-8?B?MStIREV6NWV2MzZ4N0M1enZMMkZlbllFQUdFRVIxRGg2MUFhUS8vYnkxcktO?=
 =?utf-8?B?OEhlWkZBTGF5eGc1RW16UXl0dzFNOExFdzlMQ2RkUTJxYkIrREpWTEl0dXJn?=
 =?utf-8?B?cUZzZjZLZERFbDVtS2hiTHFhdVkyTFJpdTkxNFBDeHhUcmRMQWcrUlVuSDhF?=
 =?utf-8?B?RFNmU3NwTFU5akdWeVlIaHJ6Z3h3SFZaRE9HemRWK0t0QmpwN3h6TkN0eXlT?=
 =?utf-8?B?ckhuSTZUYWV6anJ2em1HSVQ0ZHgrcUxOVUtNU1JSVUN0MnVnTGhTZDkzQ2Vo?=
 =?utf-8?B?Kzd0UTBoOFh0S1FCaE9GUXQwaHZoNzU4RUhWNzRWODlxVjlLbUdKOEk4Sll2?=
 =?utf-8?B?WWFZY0tIMU54RURQcEsrai9JaXlEZ2dqK0JwV3QzU0RpUXR2T3lyWTRvWEtJ?=
 =?utf-8?B?UnlTZnc0K0VMdWtqMjBIbTFEVGFrRjA1Zi9zRHhGa09NcGt6U0toVGcxWWNp?=
 =?utf-8?B?VERhd055TFRrYXVPRDRXTEV5Y2crL0tFRVJJSkUrU3FYNlRrRjZxbGNmVHpo?=
 =?utf-8?B?dWxHd0dkY3RtaHJjSVdvOW90Q3EvUnRxZSt6c0JGaFVyMGx6SXgrbkpsbk02?=
 =?utf-8?B?MHloUndTM3R5Z3kzUHBqaFJGZnYzSWJpc2hya09LWittSWh1L2FVb1gzRTVE?=
 =?utf-8?B?RFFieVkyTGg0NktiM2NKWEREVFBhdWlBYnFEdFFiOTJHckUxUVRSWGVLcmNo?=
 =?utf-8?B?LzM1UTdWVzRRKzkwdXlDVHlVSTNwZFhocERnMXdySTJvU2QxbkIyaDdLSUNF?=
 =?utf-8?B?bUY1UHU0eDgxY2hSbG4vZ0t0VkpJdjZhdFcrYm5qampjVGtIUU56K0gvc09E?=
 =?utf-8?B?NmNaK284VmwyamNpUU83bzVrZjgxZTlvaWVsSzJaR2U0QklUd0h5ZDhBRmUy?=
 =?utf-8?B?SmkyS3UvR3RhWklFOTJGVEFLRG5rcEM3S1ZXOFBTdGhaMnNVRy91TGlqaU5J?=
 =?utf-8?B?Q2k3VVJOV3I2dWJJZml1ejFiRVk3bllpZXl1dUNLK0xRREhFUkI2b3B2dGRk?=
 =?utf-8?B?aFB4SC9jLzFBUjRRWXd2TzBUTWNEYWdZTTZzS2lneHpNbm1UcnFBenA2M0VG?=
 =?utf-8?B?bkFPQzBJVjZMZmtsSG55VER6b1E3WHAweHlZZHEyNDVmRGMvb3c3QmZDaFc2?=
 =?utf-8?B?elNEMjFZckQ1emRSdGJYWC9BeGhIQjZUL2FpVk93NmZIbXN5eUpsSVg5emJZ?=
 =?utf-8?B?Wi9POVBNUjRycm5icXpKWmllTFVZVUxGTTRpVEtlZjYra252WEN5WGhKd0NC?=
 =?utf-8?B?aUVBUDByNk5ZZFRzK2RrWWRvMFRKYThVdVhPNGo2Q3dDTDRNcFkvMVE1RFRD?=
 =?utf-8?B?Y3lFV2V1T2ZGSHRmR3ZjeWxKNFJ0MXJibSt3ZDRXTnlkK3VWbERESHBhRkZL?=
 =?utf-8?B?eGx2Vm00a0Nla1BwYWU2bVRsTnh3dDJmSm8xR3FTQUpsc0o0VFRKZkpYc29C?=
 =?utf-8?B?djY1dWY2ZnA5STlob25HOGtXWGdTM29KOXZiRE10WWhuVEhhR1hLQU1uME9j?=
 =?utf-8?B?YUNyWU8yMVJlL1ZkU3dUVFQ3eEk2c3dnaEFHRnNDNFpzdmQ2N3VteXVvb3RR?=
 =?utf-8?B?dFpGNGRZVUVydmxONTdZN2Y0REpYSnVnd0tFZ0NTVmxvbDg0bDJ1YitQcHdT?=
 =?utf-8?B?cXk3WnloVHpnNEFyeFBHNVZtWWNJOW1oeVVRNmNucEhtUmx6OTM2clZXcFpm?=
 =?utf-8?Q?jdmPOhM+ImHXxpAUZw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjBpREpuZ2ZNd1UyYk1iaW9FemNWRWYxQ0YxNGVqay9jRWlzSkJqL3lEVktI?=
 =?utf-8?B?aXI2VWdLek0raUZ1eEVkclp3T3F6eXFOTS9BL3M5WEw0Z3VPak90aStsZWZx?=
 =?utf-8?B?Z1pVVjhQWWd2UWRaZmt0eC9lbHV1dG9GWmkyb0FQQ2dzSi9GTVY1dUorWFhy?=
 =?utf-8?B?eWxvTExwS0RRS0RiQ3RuWE56REgvbXBOVzhGL0c1aHR3MklwT3JYZ2dQVlcr?=
 =?utf-8?B?cjYzVkZTR20zQVM0dXFTdTE0K0s2V1N0ZmpBU0R0K25kOS96UkxrVGZzdXY4?=
 =?utf-8?B?c3dPZnJYZjhublo0RDZCOTNmUWd6OHVpRmFicEdtRzJucUd0Q3g4WVovT3pr?=
 =?utf-8?B?eDMwdzFYZ1VkcFQrS0xPZWYwT3dUSXUzTCtGMzVxc1lhaTRXaE5zcEtMTUhJ?=
 =?utf-8?B?SkMvaGs2ckRzN3pqNkdha1lQSEUzNUxPMXhaK0tEdkREQjFTUlF6dDlmdU1i?=
 =?utf-8?B?RjQxMkJVTytzcms1ck5aeFc5cEpPako5SjNLWERIcFNhTDhRdFJ3RlN1V3Z5?=
 =?utf-8?B?d3BHYWN1QnNuNkZCNitkamVUbjJhZnVBWXhheHdEMEtWbzJ2a3dIYUJSL3Jn?=
 =?utf-8?B?L1Q1WkJLMHdrNG1pUTY1bkpXOHN3NkFjRFBOOGNCcHVLcUFUVkMwVHFGTkxG?=
 =?utf-8?B?MWJQU0tKSFJaeDV5SzBjb25JUkdGOGUwMU5vVGZDSkVwNm1uUzl1OGovSWNv?=
 =?utf-8?B?K2o0bC90bFJvVThLUnFOWjRDcXAwNVBXb0xRcGNiNDd3bjA1TWE2N1VXQ2lt?=
 =?utf-8?B?cHRyK0pHQ0h1VWhvKzgzNWpuRXM2WFFDSWhacGhKMHVsY21iaUV2RzN3clJl?=
 =?utf-8?B?MTFMQlA1TVJFbTFyYi91ZzRXQk1qcXh2bmhlV0lORW9NMUdLOW9GNnBxQzJj?=
 =?utf-8?B?bFA3UWZ4eklPZ0RVT3dVRGVldURSOWtvWk56YlZQZWJ2MEptVHJTWnlPVjBK?=
 =?utf-8?B?RmtBazBvVEcwS21ySGxXY2JPR05oamJ3eUdZcWlSbmhJUmFkaEJyTHpPQXY5?=
 =?utf-8?B?VEV0aFRLR1RWSmFGU2pWVFIzZmMyUmJmV2VkMjA3SmhwZTVvbW01OXpHNkhv?=
 =?utf-8?B?MjdEcmtxRnYwbEdIejdhQjJZZzhhZ1k5MFpTNzJXMVdQYUEySVhLR3VXbWcz?=
 =?utf-8?B?NndwZ3RYaFJHNUhNS0dRanZkN3QwU2ZZWTJwenFzRjdaOUphZkZveVhTZDFw?=
 =?utf-8?B?b01XTWVtYllxemhvU3A0TVFMMDRFakNaekNvQ0RwVXFubnF4cmJyYkZDcTdh?=
 =?utf-8?B?VDF6ZmsrWTNVWVM3Rk1NUjMvZFo4SUhkeTU0TFZZSUpVVVhpUlFOaldYV2JJ?=
 =?utf-8?B?VTlFRUlRd1FqeDlEUHpqN3hiSVJZd1daNzY2cWdON0k1aFdvNHZucklRU0Zw?=
 =?utf-8?B?QVBTYjd3ZzBFNjV0WUFYS0YxbnhDT3dxcXRnUmoyMWJIUHZDZmxqL0VIeEtH?=
 =?utf-8?B?VjFlYUZqNngvSTBkeE51WmFWeUQ0dVdCR0RMc2xJLzR4c0NpbXg4SUFtWkZ5?=
 =?utf-8?B?Nmh4MEhBRTVDR3pWdi9CYzZ6dmE2ZXRldUFlNEVnaUplU0N0VCtMS3JxdWJ4?=
 =?utf-8?B?RW9kNTlwbFhyYi9lbGlGOStBM1BwZmd3aXBDY0ZmdXR1OWQ3S243eHRpaEth?=
 =?utf-8?B?MFAzaFZxSkVPS0lDYUo5bXhrRkZDbFlOSU5mQmU5U2hNb0xZeG5MK3VzeGha?=
 =?utf-8?B?Zmc5NnQ4U3dRODl3Z1hGampLSkYvY3MzL1ZmSU8vaUFpcXc5aC90VWQ1Zi81?=
 =?utf-8?B?QWdTTUFrUkZjNzl6akZwdklFdUxkdjg2b0V5YUtiK1IrUjFpYk8zUTRVZUlq?=
 =?utf-8?B?bzEzanhQSTRiUjZZRU9zdkVtN2JaNmRBSWkxMTRiV0ZqVmo0aWdXTVRrRkgz?=
 =?utf-8?B?d0xJMDVCOGpEbTVMSG1CSVdtenhQNzJJdEJOVVhKSnhwY2h4ZCtNVTRiaXBp?=
 =?utf-8?B?WjdUa0VSQkR1ODM2QkV4Z2JJb0hnYnhEeFBPMGZWNUY5OGljVUIrR2hKT0JW?=
 =?utf-8?B?cGkvMFVobSswMm4wV1lNc3drQk9wUi8ydEJvTzBDem5FTTdYS2svREVsdWwz?=
 =?utf-8?B?TGdXRDdSVmZsbSs2U296UDllZEZMYncvK1MzelZ2Y0lMeVJPZ1lQYUVma0RX?=
 =?utf-8?B?WWR4b3lSUlVGWUpMZTh3ZytkelREOVlxYjRub2lzMnI1UDZBVE1tSGFxMFBn?=
 =?utf-8?Q?W2i+pwCYl6l5qlC45wRWRBw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	erlAZJTg+Yew/JzeL2hWyFbDqNNQwKQfcOdPY86gavjc/Fmvi7nUeubjamSRUcEp/43jVlgEW5Jv1QdM0xOAQbaRNrKHu28z5pwSvK1qWHIA8wVUvW2SWsbgT8Mylvvvh88gxTUBLG461INTPhcv7blDMiPvZetSjKZ1LIcMNLLuYdT1ZG3Qf9PJLVZkV5senRhMQp1SjsT0E/EHdgkHjZhKQP6IB/7nh6AWfpQq2YSvcLLIHQyXZf5pLQmq8EbPeVFkx0pDcBIXFFzkfE90dXtOfhhUhMW8F0D7iwTa+vhP1MdVEBLPMZmypsIUKVb+NMM0P8Fv4xwm+rkAf1ytWYb3Der2jW1920IUYjOChzQuIc6MPao1CW6+xoR8Qaz3lYAbpIYUefK6J46+Sg2NRK0mDAdbzfsab1zECjNBEcmDeD5YXsQshZWjf4mwywBKboEK9HolzKJo5xnstXgtOjsZBLqPcOPQ+awx5JFnx8wvPDDG+p/qIYLpPb+2P0uwIGiB4jSA4Z77nPAO/5mi2xsYqJR70q60PAA2DWsa2oT2ad+nOqSc9VKUV6CeVsGuCSkMZ2b5/RtPTpu69zKkjYGNEk7ZlpeGgOxDEUvY3zU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d3e45e-7e80-4d04-08ea-08dc95ec6bf7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 14:29:43.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3zEZNYqhbcW/eTMcPLKAegXj8cQTV6ruWLHTdSFWuULEuzWjH2RaOkTf9B9hSQHbnoqNxwPterHfvoaUZScbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=807
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406260107
X-Proofpoint-GUID: TNxgq_COM3cup8KItJsSWJTRfoPzKsvC
X-Proofpoint-ORIG-GUID: TNxgq_COM3cup8KItJsSWJTRfoPzKsvC

On 26/06/2024 04:22, Dominique Martinet wrote:
> The SOURCE_DATE_EPOCH environment variable is used in reproducible
> builds to set build timestamps and is generally synonymous with
> reproducible builds: instead of making users figure out how to pass
> pahole flags (e.g. explicitly setting PAHOLE_FLAGS in linux) just assume
> that the user wants a reproducible build if this variable is set.
>

From the kernel perspective it looks like as a result of [1]
the setting of SOURCE_DATE_EPOCH will be converted into
KBUILD_BUILD_TIMESTAMP; I thought the plan was to add the
BTF feature flag explicitly if KBUILD_BUILD_TIMESTAMP was set? Are you
planning for use-cases outside of kernel BTF generation?

[1]
https://patchwork.kernel.org/project/linux-kbuild/patch/1443741332.2730.75.camel@decadent.org.uk/
