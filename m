Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9FA146D60
	for <dwarves@vger.kernel.org>; Wed,  1 May 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586581; cv=fail; b=mPdZ+IdHrrfDUid1rhdUsqQmXXRZfi46/7SnglfWxWBHXDB5DIbpwvqH+RlGxDuzDFvKwjzNA7tgsRbWVk/IUj6/Mij8FA32sA2pJ6f/FBTsUHTz48CcwUY8G48H2XYop916rx1zFiwUq5AsdzGS1tA2U5v//Kl81qmv5p85h0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586581; c=relaxed/simple;
	bh=nJ8cE/oSa91sMpf27OK4GcCs4gFOwXP4tdtzIDNIkKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LGfiM7ZXFlaeFkk5LK1nO4dw9yHe+D3fT7opn6Bu8QPHWwfDLfrsIWT3Pqwm2UHAyELssbGCAUoaap0xM+lXh7W2v3I30JGRUVQOfBIpULaosG+kF0b6UDEEkWvayDMtRYEnWAwwFnLV5BCP11bPQ1FZ+a5NxXbYxq+DFSMcjsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WdxCqxXD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z1gs8YaW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdxCqxXD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z1gs8YaW"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441ARosh014732;
	Wed, 1 May 2024 18:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YuI2hQEVjtS9WhRB8NI3hNy7gSx41TDP+JhJaP8lajI=;
 b=WdxCqxXDdwcw/xA+EjP8XrVaqbqAlaET9TooNah600wsHMAwPyyaWHWIS97IulbGh+sb
 rj1vUsWNHGTpV/BUxxugVYECHAKQogfSKYbhO1IEUAbx/G4q80vlBCRQ4mzEvu0Uq3a6
 J50Uj9si8oZKnOFqSSvSz9aV0q1cKffeFI6ar/cvMdp1Mq1xt4MhRJZzBk+sHWtehguG
 ZaPhik29RGh9RLdyDGChDUOCnoVyhwyKT1J+VyAQro8R48Wx9zY4iLHU2fx7+IVJqoNI
 AgIjPmbJS6FFtDbBvRRRxyKUTXZxT6QNG8XIdzApenBUWip93aI7DrS0E/HNOUQoiInD ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cqpa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 18:02:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441GRYXm011449;
	Wed, 1 May 2024 18:02:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt9kyqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 18:02:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHMs02kZ/EBJRNHzhgWdBtzYi5pMqmz6C7YSRcbOVMltzoWuX1kKiasLiC5HnABVshRF5ZklhGB5cMaEj/Lgd2q4xEHQpQB3tF0ashQr8nLmwdNTFgOL7JzyHclZrU28LFaGh+V0X4PzOJ/p8RrdBR4tCXRaabQP+xy/1Q6G58NCr3lZ53BoIjsi/2jQXHiIaQywt2RPcI9PYp8Ho3lVaV1GODj5eCUso3dby0Itb1c0SqSKZKp2WMdb2fQsgf6DLbz3JkYrGZTbeQdBXDEsFQP7PwETbcdoHto7t7MyzLAeA8e+BJ+e7Wm/JeI07luPYm6jowE6QXui8xClrdUSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuI2hQEVjtS9WhRB8NI3hNy7gSx41TDP+JhJaP8lajI=;
 b=aLp7XpXuc5PwUiQxTF7Ishf5ekaHlU76RL2qaDfPbasbbBQef9t3X9KxcJ2jTGJv85hnUsTD5HDd61VL16W/IcGSUhBc5D6QJcF8C8RMgAsIWmMqtnn4OjSvZNZlsBIwcnTgsD5IyaL5WhgSqV9uzkWWnuIJTIoDR9XtL+4Z6E+Pe6abrM6gjMct7Dzy1bOwjFep6ruT+ks5DnUyDj2zi5iBsaKWdfS/DZy4NUgKphX9PKuz05IbrRVbnSPowtAVPbJhp4zFQtV8RVsnFp18RDPo2iuJEu4oNRodPDxyyEOhbpGPqw9QqskGjR4J4KC73GlQc2W2wa2Arq2LPJxOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuI2hQEVjtS9WhRB8NI3hNy7gSx41TDP+JhJaP8lajI=;
 b=z1gs8YaWcdi4XQjc1LlxP3sFN1kLj/2LUJ32pHylrRNnA2z5Emylzg3FVOJfrwIeI9Ri1pDSwF2yHa6QzGJxbkV+sCzohwBVPAumz9EyBKK/xtrTbow0LbERPloRh33qX2GXr03nTbpEkboBoRb3jmT3JsuW8v5R+wQmiVHczZY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6720.namprd10.prod.outlook.com (2603:10b6:8:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 18:02:41 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 18:02:41 +0000
Message-ID: <3e83bcaa-94d8-4a43-90ec-b21486367862@oracle.com>
Date: Wed, 1 May 2024 19:02:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] Documentation/pahole: describe expected use of
 'default'
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: andrii.nakryiko@gmail.com, dwarves@vger.kernel.org, jolsa@kernel.org,
        williams@redhat.com, kcarcia@redhat.com, dxu@dxuuu.xyz,
        eddyz87@gmail.com
References: <20240430095501.1959359-1-alan.maguire@oracle.com>
 <ZjEEkDmfb9Az5PHh@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZjEEkDmfb9Az5PHh@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: d416cd36-4795-47ea-0af8-08dc6a08e47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Sml6MEIxbTdycllJT1FwVzBQWFRSeTg0Z1dUZ1BrMEdNbWlTb1EvQ3VYZldm?=
 =?utf-8?B?NG1KeVVJazJyTlFDUEs2enJmZG02NkZqQzV2cnZOVFh5TVlHdUo2SGhPT05u?=
 =?utf-8?B?djFwdk9DcVBFVXhDWXJqbGVPb1p5cThURkxRL1lrK2l3UlJ1bTl6SlI5OGRL?=
 =?utf-8?B?RzhidTFSeEFuWk9CY2NoY1M5dE1FQjIrL2t3aHRCWWhVdEduOGY0UVRLS1Mv?=
 =?utf-8?B?VXludDZRd3BvREppK1lKMnJ5cGd5RGNuQ1J2ZmNpNFp2WlJRTlQzSU5la0U5?=
 =?utf-8?B?VGZ4MGxNZlV5eENSeS9WZFhUQmpuanc4VmtUUHlBa0J4SjQ5R3FVTktMRHkx?=
 =?utf-8?B?cExIZzVRTElwZGl1WFJaOG9CMi9RTFhaVmNpdzFuN2MyWWZwaW1HM2lPdVhn?=
 =?utf-8?B?ZlhhN3QzTklrUUxnREpWMmQzQWpVMHZqZ05sTGdacllJZHROZnZ0MGVBRXlm?=
 =?utf-8?B?aWM1emVIZm8wMmFob3JMcFgvcWJ6REJJUXlTOEZUL0t1M0VzTythWkorRG9Z?=
 =?utf-8?B?cHBnMENLZUhLS0o1NTByc0NLMlgxeHo0M2c1Zm53MFNzSDY2VmhJcTlGcUxi?=
 =?utf-8?B?WEptajNWNSt5ODdId3RBNlVDdCtMUVlaSW1ucVhDQVRtVUdKdUxabE1Pem1T?=
 =?utf-8?B?V2dEeitSN28wNHkwYmdldUhWb0YzV05zTlEydXFlWDh2dzdzMGNCSnZ2dDJ0?=
 =?utf-8?B?b2Iwcm9veFJHN0d5Q2N5QUFEUjgvL0ZROENrS1MwVEhwTUdsQ3IxRTg2YnpW?=
 =?utf-8?B?bHByaTZ3MWh6S0ptZ3NjRVhZZWUrdHQ4ZmJaMnByMk1nNGpQWXJHSE5VcmtP?=
 =?utf-8?B?bVgyTVlxY1NwazlMMEFMNFRpcXZRS3RJRGhiWVJ2MWU3ejN0Y1hqNEpTYU44?=
 =?utf-8?B?NG9aYzBVdk1QZjVJRUlKb2VBcDllQk16dUVmZEN2M2FZMTRLZHdBRlNaa0Ry?=
 =?utf-8?B?bmxzd1kvV3YxcHlYLzNYTEtETExUTTl0M2V5UUtDbmxHOWczM05aWUxwTFhD?=
 =?utf-8?B?WkQyOWtCNHc3M25keU9qcVRtVUM5SDcyREpNVlJxK05qakYvc1hTL1dvcStn?=
 =?utf-8?B?cjFjRWZqemFqMzlERkpMVGxObGJTejFLZ1hSejBRUkxSYU4vKzE2T04xQVBu?=
 =?utf-8?B?UTdNbmVpMnZaNEZMYm02eVlrNURQTmRmeVVPaWM0TCsyNmpBUFBGeEFjRnh5?=
 =?utf-8?B?RE5jSDNQOVJXejk2dUJGczJ2ZW42RUdmaW1xcS9RUUNzZFllUDkxU0hPRTlM?=
 =?utf-8?B?UCswWXMzNkFNdDBCcnJqaFM5M0hKU3dGUWZhbjNjcHJnSVdkY0JqZVBRdVZk?=
 =?utf-8?B?cnJZM2FSUVlhcTlrMzhwVnU0TzhRZ1lMNVMvZloweEIyNDF4TmN2WFBidG91?=
 =?utf-8?B?RXc4SHZvbFRzOEtCQ20yZXFnb1M0NUcyN3VsZUxackdMaUlQcDEvajhWT1pI?=
 =?utf-8?B?NWVkQTJsNjBXRTdDU1JCSU5Ca1M0N2dCeExrS0V6N1JQK2NXdVhBWWluMDNI?=
 =?utf-8?B?VVNYUzA5a1lCUTJxL3Z2bnlRdFEwRnZQUkxvK2x3VGpQWEg2bW5zbkpzOGlF?=
 =?utf-8?B?cFNBamZ5djFkUWF2b1Q4bjY5TnE0U0FSUjNScDdRbjlPdE83Nk80ZC9yY1ly?=
 =?utf-8?Q?b/5/Cjqj1+UQhGwnpnA1Mb9jWkcjWLVNtbEi+2gOtjx0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZEpyWEx2dzJtaVRMWlRtNVZ4M3VoTkhhMW11dHdudXJjak1ucHh1bmVnQW9X?=
 =?utf-8?B?QWVrRGExZ1FCUmpSV2RGUVBWdkpkdGxyZE9QVUtmN2dua0NVYTVsa1l0aXJG?=
 =?utf-8?B?NWhwS0hXZ3ZidWowaWlXZ0VNcmlCQUFpMW56S251eXgyL3cvNEhLNWlZdWQ5?=
 =?utf-8?B?N1FLSzUwQUNLS3MwLzZSU0FLZ3EwZzJRcHA5L0dib09BdTFhTVFRNjUveTdn?=
 =?utf-8?B?WjlVOWFxYkpsdFFTWmVzQjV1RXhKUDczUXA2Qm91eUtsMjdlUWc3aE42cmsr?=
 =?utf-8?B?U0FtNnNmR0JCYlBMVjZGMUF2QiszeWc3UnBsWVdaK3NUQytGZzRQZ1RaTGZ1?=
 =?utf-8?B?aWhxVnRpZGlYY1V2em5seHEzSm83Qmsra0pqSmVMU2h0UklQbXpIbmtCc291?=
 =?utf-8?B?UlRIZUx0dDF0OXBnMTJocHFHSWZUUTh3YVQ1Q2MxczJ1UlJCaDNlVmRydHRs?=
 =?utf-8?B?L2Q4RTNwN0ptdGRuRDZ2NGdtTEQ3d3k4UUlkVFpHNC84d0tMZWlOTDJqOW43?=
 =?utf-8?B?Z1dFT2k3U3NMU1FuV0VLZ3VhREpGUURmWGk5dmd6U1dWb0lZR25OSlNwT21K?=
 =?utf-8?B?dzIxemM3a2ZUaWlMa1J4NGNkRE8zOXkzM3J5RG1IS2dJcGVuSEw4enZPRE1N?=
 =?utf-8?B?U2V5Vi9GcUcwVW9jY0M3Z2pJYm00ckJYeVFmcW42Z3plbGR0bWVxZk9oQTV4?=
 =?utf-8?B?dWVoVUZvMVJLSzFPcWVYaHNHc0dJZFVteEFRT215Skw2MUE4akczenc5WDVL?=
 =?utf-8?B?NnUwMjZRU1VOZUp4S2h5UHJiVGVGYmo0ZkwreGxJRWZvMHlxR0hobDkwcDBy?=
 =?utf-8?B?NW85WEdyQVI1emxuNDZMN3JEVHl1bE14L2hLbURUMThrK1RYbGNLVDVteTdV?=
 =?utf-8?B?UjFPRCt2M1hPcHZhWXorMFBiRTZwYmFKMmxnUzVCQUhWTkZLalgyVG51SHZ2?=
 =?utf-8?B?Sk9ZSS9HZnFwVUNUb05mVVdsRVJ3SEpxZWlseGUxekRsVG13N2VXMU51QnhG?=
 =?utf-8?B?emthV0JCL2lEdlNybWMxVU5jWVBBUUJKTFp0SDBuaFpJeHdzeFR2b25uOEtJ?=
 =?utf-8?B?eTZDS3lwTkI0V1BlbXczdnhNV3BTaUp0Y2tBK3lWb2tVQ1lrcENnZlY5M2dR?=
 =?utf-8?B?RjNtRkpKdVR1cVhPMHllV29FU1dnT3g2b0pNc29wZXdoUE9HL05pSlhTYkx6?=
 =?utf-8?B?N3BqaTIvNzJtM1BCandVOFJmS3pNZzd0bnRRK2QwT0NlWE1PYm1kRXhuQ1lx?=
 =?utf-8?B?eC9lK0tQVkZiVTlTQlZEU3o5Nnp0TXV2cEdGR0pzekYxcnlheFZkc0V5WWxp?=
 =?utf-8?B?TVZGaWMrZksyZ0JzMFd0Y29wTkxqNkhaalFYVFkxMlkrcW1rZG00b1RKMWk4?=
 =?utf-8?B?MWFEL3BRV3lmS1gzZTVDb0ZibWlZRHlMS0FMd3cvSTBwZC9tR2QzVWltUktO?=
 =?utf-8?B?YjZPKzJDb3Y4aUlqdFVLUGZXNG42L2Ztb0k3Y3RNTGpMSEowTFVLanZNbndY?=
 =?utf-8?B?QUE4akJvRDdPeDlkZDNGNGhhVjh2anBRdDdsSjFNV1AyUnhUUWx1NTVQZ1Q0?=
 =?utf-8?B?Qjc1WmJSK3NybVVybk9iVnBTU3Z6SWxLNDc4RzB3ZWZ1dWxFZzBYUG96WTFj?=
 =?utf-8?B?Nko5czNqSEwvWEFBcW8yd1NobE9OaG1pUElCaDdzZUE0YllVandXcWNNczRK?=
 =?utf-8?B?ZmhLb0VFT2FiYTZWdU9JRmkzZlkrSmttdkFvc05FSnliTXJiMDRGa3pLdHBV?=
 =?utf-8?B?bVlJWkp6b20vZXZnWXhvcWE5V1UzdE5mNEhEaWM0VnBFcmJFeHNMbDJraGdp?=
 =?utf-8?B?di9HTi9VU3NuL0lPakM1L3AzVytLVEpMSUE0anArbytQU2Z4R2xqbHBwaG9J?=
 =?utf-8?B?ZDRya3htR1FWbTBvYldGYlBXWWtUM0dTb1JEQUFoQ3JhOVM4N2JqNlk4eVpv?=
 =?utf-8?B?Y0ZIVjFVYnFuUUFGVmhUd01UL2wvUW5UcmVaNVdza0tRZjBqZGpYelF0bTBP?=
 =?utf-8?B?NUVuV0FZdmE2RmJ6QmJBSjl6Yk5nMWlqeWtTWHZjS2tYMStVazlJenZLSlR1?=
 =?utf-8?B?UGZBOTVTQ2R6YytObGMxY1NMK1BkWDFFM3l5bnU5NjNHZjhMVWt1QXBEV3Jq?=
 =?utf-8?B?ZTBGS1g1MytlTlpYcUpHM2R2c3JxTnQ2NlhlSnA4eGg0YWl4MWk2NFBuYjVi?=
 =?utf-8?Q?cHCy1lIq+z98ivPu/uXEW/8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TTKtVh6FLJCGvpe+nQRgtdQ0g30HAzn3NCLtsh0CFAH3UgudfLT09igsfeaVONswm1Vr9Y40Dceiwu7yZrPycy+umSjUUvYPwdC1Bv2xB2w4bldznekLRkNt687JfE0yMmHjuxcqyTkeFXbkq9/wu10of4qxLuOML4GqZdMw3d9C6i5q5D94K7v7YvSVnO/8xExjAJ0rCVdfAza+hGqYCsbd7zODIkh1NoUjwt8a/TaduO0yXwz/llqFtXDmNWn20Ls4RHKeN288LZRq35tiHNAApZSP8UDeTJ43WTT4WCe6+FT6+O3hfmClGwkx8thcVlXVI84+PnFv/H9Ia1bLb76a9RumACxbsGOn0tgFz/G3FKBWYbMZgY8IiP0bsjlXKEnQQ3OpjIxAYVjIq0Xt91mhCq4qyphyAnki06775tM4OZLbZ0kHXuDM7tB8zWHAq3v/eik89DZvYn+aZuRAT6TNhWv6lL+sPwG/httkkQ6COFm+43H4EiUROJyduUb0pkjUeE/A+SZZKOVr8c138lYy3kh/T5Wa86PQz/CjgkWN9oJI+Rmy4CiloDmVaeioT0QOl+ugecXe/wMMjj/tNtbwRa3of/xlUq4Z//LMzCI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d416cd36-4795-47ea-0af8-08dc6a08e47f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 18:02:40.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSVvllRtmExscZWM22yQeHOrZjhlRkbfed/IjepKCrlS6QyhoIil0GxqbRseVMEN6BiVBlO0B+QQ3C7qhA1Zlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010126
X-Proofpoint-GUID: 71yqvGk-aa8hM9UcuBuSUhPOGQg84_t7
X-Proofpoint-ORIG-GUID: 71yqvGk-aa8hM9UcuBuSUhPOGQg84_t7

On 30/04/2024 15:47, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 30, 2024 at 10:55:01AM +0100, Alan Maguire wrote:
>> the 'default' --btf_features option is useful for testing the latest
>> set of standard features used for BTF encoding, but will not be used
>> in the kernel Makefile.btf.  It functions as a useful shortcut for
>> testing the latest set of standard features.  Describe this in the manual
>> page.
> 
> Thanks, applied!
> 
> FYI: all this is now on the master branch, it sat for a good time on the
> 'next' branch, got tested by multiple people and by the libbpf CI at
> github.
> 
> Plans now are to get the kfunc stuff as the last feature for 1.26.
>

sounds good! I just sent the patch to bpf-next to move to using
--btf_features for pahole v1.26 and later [1]

Alan

[1]
https://lore.kernel.org/bpf/20240501175035.2476830-1-alan.maguire@oracle.com/

> - Arnaldo
>  
>> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  man-pages/pahole.1 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index e3c58e0..19bf197 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -290,7 +290,7 @@ Allow using all the BTF features supported by pahole.
>>  
>>  .TP
>>  .B \-\-btf_features=FEATURE_LIST
>> -Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported standard features are
>> +Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to using multiple BTF-related options, and 'default' represents the standard set of BTF features that are in use for kernel BTF generation, so is useful as a shortcut for testing the latest set of standard features.  However kernel builds will call out specific features rather than using 'default' to ensure that the desired features are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
>>  
>>  .nf
>>  	encode_force       Ignore invalid symbols when encoding BTF; for example
>> -- 
>> 2.39.3
