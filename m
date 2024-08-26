Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631813D297
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658659; cv=fail; b=ntkTlJGuyAFhEz2EQ55CxOkfFFLJ2Sz5wKT+RyGaB+Ek/9Ye2zmJWLdFFTXTdz7zgwzfHYMukrNgrIELRyeUY85R73Mh9NLxpbJBs39miYW2A14EBTUR/lk4J4uDXoQ1hZzI/1kImLRMiDR7THV7qcG8TMeaF4yeYUuCSE9HZxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658659; c=relaxed/simple;
	bh=XQGGd5WHou5LaubOUqMU/CwdNlDMXz38XoSdDVHVSqU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qsV5OR5u/Ndl5j/bgFxwuQUxe9/83oFtUo38DdWzgvOzJktcB8pNHdldYWfL8ZN5lkHCklAn0gejTGZ0bB5EJCWqdM71j5D3DVTykZlCIUXXFvKaAmnea0JzbsXex0Zg51egeKFzmoXjGlpOyBcLLx0wUNAnguXcXYISs+HsXiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C9K10eb1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HX9uUlkF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C9K10eb1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HX9uUlkF"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q7fSUu002845;
	Mon, 26 Aug 2024 07:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=+QFZvXjv17iDEKBxP65d6FzGk0xutjHjL6X8gPOeZiw=; b=
	C9K10eb1bL5O279SnedpYj0/lTboh1JPsaHAttHnMR+1O3VRZkjDl7wYjPDgpilG
	XQjdb5rWkaLWQsefdB5IDecoCPLOEhZaOdYv6A3NXJHvf9/saEQNmGgPcH0FZDVc
	4uB7xyV7nOpbx1Ef02reYpDoDuYidyGgTtiygrvQlYcbXbEAEiRG10DoRHC0i/PN
	vOsxcXkpwcJuJufpLCX12r+tRm4oqvV6ktRK47BwAiQKMoRtnu+yEkxGc3u00zu/
	boQ6WGI2Nb8GTi+1Izr5l7wtaHNYS9GeJ3Gvx3Q7F5kNnx8xkpBwSAxLjWlfI7t3
	Q7FFmOz1Om0RRSZMvIYUAA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6jj6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 07:50:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q6IYRl020095;
	Mon, 26 Aug 2024 07:50:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8jx2e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 07:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGHtHZHMXMWOGcnLzS2zXJLvpbSx+0CRvg1Y/aepMo16VwTeZ1JMjVRNe6CPhGo0hMtR9tpWqiqMvMpxmdlv9z/IEdBQPdhH+KD9J2ESx1RyIEB/i2JEsLaQVcJYggN89QkZlxz5JbYfEUT231kAPdAHXITGuD0VZqEyIAcJcvNAHhZKBwbnw0xoUwaqi63k5tzsDXAZ/qhzDZQieQlvGfvnUFVDA5zwVg9rPBUDdDLsocpjS9yXymffFS/tfr/BIFz7/ZO1z5A32Af8ixYAQjdq3J4VaAJkl+1D1aE4Fo6dMqqtqSVHp/VU8MzWQ06RCEzas+JneMT2R8THAXN9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QFZvXjv17iDEKBxP65d6FzGk0xutjHjL6X8gPOeZiw=;
 b=sWNM9vFJ3mU6lyTaqAoltX6Ir7lPliYcjsS3DSf6Wc49z54Ys+AO8YygVw6Oq8+W2cNGQSpivQbT6+Urx4vY34ZdlusRBSG550ARz4DjkDtvW81YFQuGjAhJ4BgQzYhv1AqBHnZGPhK1uDkdElXbUtckFYgpvhkhtjcMuCwh71CfA1eryJiCoJo0YDvIIdPLBitXIMmwqpNiJgORQyNVB6CcDY5EOgwjPRE6SFpYgv8gHR3ESlGmdVcnTnOFW6JYWmOvUUTI97jzA5SvA8FfxxhypMX4J2x9MYjkl3EOsB4pz5jMavY0JjhXLvK7V9YRLETSYkZ7dxIML8+etsDP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QFZvXjv17iDEKBxP65d6FzGk0xutjHjL6X8gPOeZiw=;
 b=HX9uUlkFL6lz7kZ+cDWwmU0zKH1Id8WTtxvSaSs/EivGTGKkioGjt5Y7N4fSjn1vs3oD+qXN41rYSrfSlZwJsZ8GrETzIRDfh6cphIA5VFfI7hD5AV0qLVNIT10o5HHX+idNIBMcbdHL/2AgLoPOem60o6yNeXQ94s9I5TDbO4w=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 07:50:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 07:50:48 +0000
Message-ID: <18c050bd-d151-42b6-8c1e-b50477e0fa6f@oracle.com>
Date: Mon, 26 Aug 2024 08:50:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] btf_loader: Support linkages for BTF subprograms
To: Will Hawkins <hawkinsw@obs.cr>, dwarves@vger.kernel.org
References: <20240823212835.1078351-1-hawkinsw@obs.cr>
 <20240823212835.1078351-2-hawkinsw@obs.cr>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240823212835.1078351-2-hawkinsw@obs.cr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4a3cc4-b9c5-4be5-c05f-08dcc5a3cc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGhKNUZYZkZ1d0YwQTJ2NFBMYWRjOWV2WDNZTmRVOHpTY3NOVkpQSkI3engx?=
 =?utf-8?B?dG8vV2l6ZXB1aHpPcHJNcjAwMC9lUjBKK0U0YTNRdFc0RXRNaDJuZkhNSmdu?=
 =?utf-8?B?SitGczdYRWtQWlJ6V0ZiamxUMzl6TVBCZFNQS2E1T2dablhvdjlPRkd1VGlk?=
 =?utf-8?B?eDFqby9WSWd2cmtIcU90NGRrVWdBQWJkL0l4OFZocU4xZm5CZmtFWDBxOTNF?=
 =?utf-8?B?SkhWanZ6MmJjbm9HRnlBMUNuMTUvMjJnKzZiQkt3K1U0K2lBdFdDTkVCQm1N?=
 =?utf-8?B?aEg2U3BPOEVEYVlMeGxCZGN4TWNyUEIzS3ZDQjVtSkRHcXBoOVc3STQyUHlz?=
 =?utf-8?B?a3V2VG5sZXZ1eTlaMlNQYzdFVXlUaUgrQmdMenM2SlQ5ZlE0STljUlBmS2Er?=
 =?utf-8?B?TnJkekJSSStkYWUyaEUydEJzbWxaUnAyanFQZERDcmZHZW1DazFBZ3dyQlZ3?=
 =?utf-8?B?YTdzNmpwMkd4MUE2RTdTWnQ5dThZbkRjSkVSZ2p0WmsyUkJOd0EvSklZWTdW?=
 =?utf-8?B?eTgzUkZSL3RMbHYrM1R6TzJ3SnJyL2tyanU1N0hleEg5YlR6bGQvUGZTU1Bt?=
 =?utf-8?B?a05VOTNia2p6QVBKNzVZY0lCTi8wL1JDZzZXdERRYlJDVnFEclFtL0Q5VkJK?=
 =?utf-8?B?WUNDNzU3NUVzMHU0MWJKNGRKbm9DaThyMzhDMlRQT1Q4OGdEekN2aHFLd2dj?=
 =?utf-8?B?N2ZnZ0dOelFPcVdUN0Q2ZGlaM1NkK3FXSTdQVzk3U3VqVS9pZFBRSzBlZUxK?=
 =?utf-8?B?QkJ1TmNwUmlYK20rY0xoTmZtWm40L1MrdDF4dVRzZ3ZDSWdDZFExeUVLZ1Fk?=
 =?utf-8?B?dFFkR013Nk9RdHE0Qk11NEdGLzRZQUpQbXBFaHlOcThkNzV5NTNpZTZVdWZk?=
 =?utf-8?B?eEZWSjJxb0VQR05iaTBodTRoZU1lSFlUc1EyQ2VmQnplSmpubG9aQ0hUbXor?=
 =?utf-8?B?QmlZM291VVpQZk9ZQSt2UHpkb0RzSlFGTTMwcDV3YnZoTGhQems0aHVpWUZx?=
 =?utf-8?B?aTZ0VVYvWWM0VlNuWGNkNStUbGZSNy9zc0tQWWVVcVQ3TEZVRURkQTdiRHli?=
 =?utf-8?B?VktmYjlLMzNXRUhUS0NXV2pKWk5qeC9CdUtUM3lQcDhwb3IzaEJpMWhMcjZG?=
 =?utf-8?B?UVpUQXVpMUF5VlFIZlhzaHlWM2p5SXErS2k4dlB2Vjd6cXhtSHFvamhWelBJ?=
 =?utf-8?B?S3JENmI0dDNoRURyVlQ5UEpSVDdCOGVTKzZKdHJBYmJ5OW9OSkMxdS9lUUds?=
 =?utf-8?B?elhFb0liclVSSFlScEdpVEVsUTVtbG9jMWFtRmhadkdpYzZJdm15VzB3QUhY?=
 =?utf-8?B?dERMSWRIVmFSUkMrSkY2UlZGTm85a1QxRGlQMSsvL0FlZ2t2NnRBY1RsVzVH?=
 =?utf-8?B?VXRPMEFOVGhOUHBFQ3lVM2QvZi82ekNHNmRvbmI4S2NYamo2UlZPdWZkdGhv?=
 =?utf-8?B?Ky9QbGYrdEoyQ0QzRTM4NTM1c1dVUTVITzlRTEg5eUF5cy9wVjdMQmlYcGlS?=
 =?utf-8?B?VVZSVXZPK3pSY0M1aUQxT1BSaFRxTWFYUThOYmJ4L216MXppK3lWN1dmeHU2?=
 =?utf-8?B?ZzZjdzQ1SWwxb3FKa29kWUpGdW5YV28veWIybEMwdzJ1TWVjcGthVXE1bnZT?=
 =?utf-8?B?MnBzRWphZW5ZNktGR2FEY3MrdGJnSy9qWmxnSlRtOHE0SFY3QnoyVkxrVDVK?=
 =?utf-8?B?d1lNdllqTFV2ViswZGY0U0xBenM5L0N4S1JMVlRoQzhMMlJISFBzN2pOVjFQ?=
 =?utf-8?B?b3ZFNy9PZ3g5eGo4Z0k4WjE3dC9XWjJqV05aZmxQd1dZWEYzMDZxN1ZLbzZN?=
 =?utf-8?B?ZTg2d2NmVW44all4N3krZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFU4TlNvbFVoRTRjcHFGQXR1TzVVNTRVbHk4YkFEa2ZoVWhaUi8wY3gvYXIv?=
 =?utf-8?B?Z3BvNEZiSlA5MHE3SXljNTNlSEFySFBwcFNmSXF1aUFhaHRzK0NmUy81dHB3?=
 =?utf-8?B?T1p4VFZXdCtDeFovY0lFZzdiYUR4YXNucUgrTStieiswMGYyOVFya0M2ZkJW?=
 =?utf-8?B?TVVyeE5pR0g1M29WZlErbXJBdFF4V2FYWHpETGFYOG1Zd3IyazYveE1VL1cv?=
 =?utf-8?B?blpjYWF0R2tPTytwYkgyNVpKcGZEMFJRYzZRdUlrS0NrYlJtZEt5VXJ1Y0Nu?=
 =?utf-8?B?UGlWT3Z3bkxFNC9pdmMyWTNpOGxHOEgvbHBJZitCcmttaSs5TzhFSThxMS8r?=
 =?utf-8?B?WnFocUdEMGpUYzArZHN5RDhidkdKL0h4VWxEbGV2MFZEZUJqUlYwSmNMK01u?=
 =?utf-8?B?VFpwT3ZyMWlpOVhQME9TcmF3MFErdDFPZS8yYWVPWS95U1laemdFWGNxd2Iv?=
 =?utf-8?B?ajhlKzk3UjZvdUJmTk1Bby9zaWdHVC9jalV6NDhmVWpJeWxuUEpVWkxlRjhL?=
 =?utf-8?B?UEN5Mlp6Y0diVjlMOHcyOUVuRnpaTzZxWEdwV2FKYUNDcFJZMWhlQjlCMG9j?=
 =?utf-8?B?ejg3Rm1yb0hYMGJiTWVGaGovR1JHWitlVkNTRWhTbkhOODRJTzIxUE9iZXBH?=
 =?utf-8?B?a0NFbUlRaFpvNWxiNTJnclJvL3hXNXFaWjYwWHRNaVkvUWExdXovS1NNdEJv?=
 =?utf-8?B?OGhaV21KNnpiS3BZajhoWTU5WENJNzZNWVlJSkFmM2ZKa2h6UHM2VFV5ekQ3?=
 =?utf-8?B?Q1R1ZmFLS3VCWFljSTJpNGNoYVBsZU12Z1JidmFvQTc5RFdxNklGTEgvVll4?=
 =?utf-8?B?WWRHUjR3UUtQQ0RUOVhBQndwSUhweWtPM3ZRTVhLa0l6Qk1uZ2JwdDB1VVlq?=
 =?utf-8?B?cTBqNDcvTm1rWmpmb3F2UEN5cndrOU10YzI2UTRkT29EZFptZFVuN1Q1TWdR?=
 =?utf-8?B?VTlwSnRDd09KN1crSjFMcmJ1TDJleUNqZDh6VUJYMFpVMzNpNFNhUFllNHBJ?=
 =?utf-8?B?bFhQM3M4TkdDM09UcS94TVRPTXladEZiUTFGaEZvUDJ3TTdvdTF1RVBPOUZO?=
 =?utf-8?B?VWM2OGV2ZnNRNXZsQUtBbnRPMVpYN2NvZjY1Q3ViK1RIeWV0N3JrMnAyK2tH?=
 =?utf-8?B?V0RTdVFKMmhPcVA2VVhEVk55SmFFZTd4cUJla0pndGc1U1NrLzlpdmMrcDUr?=
 =?utf-8?B?ZGF4WUs5QlF1MnBDVUNoU1dSd3g4cmUrQUEzc3NWTGZMVkRvNjRiRDI5NEVE?=
 =?utf-8?B?TzQxUkVaY1F0TTNBMGdUYmgxb1d4M0VycVVQMGJLNEJGWW9LTjdrUGxTRm93?=
 =?utf-8?B?cTJ2QkRaWVhxZTVlSmtQVlgyUk5acnI5ZnNNYjBGSmJhY2c1d1NGVTRhSXpI?=
 =?utf-8?B?S3pHNmYrNHlsMzJaZkZtanI5b09xR05qQy85bkplWjcxVjVCV2hLZEp4cTZH?=
 =?utf-8?B?ODhUNWtBTmlMVnZEZzF3VjRtS0RqR1BvclZLNHZ5cEtHVjJOTzFDb2VhSWhm?=
 =?utf-8?B?VEw1amZneTd4WitBZ2NwcVVkbFpwQ0tSbmIrVUZKU2x1Yk10bTIzeUNJTDlV?=
 =?utf-8?B?OENSSVlOektrZVhKbVBjQTd4WHhveDU2bUhPZWVQa0xhQWNIaGtBU1Q1Y0ZL?=
 =?utf-8?B?OXJUUVhBRldtbGIzc3hYK1Z5Z0pZazJqWk1TS01PMTBDWENkYW1Eb2dHc2E4?=
 =?utf-8?B?YWhBcVVNbm5LOFdJcDFmN211V3g0c3FESGwvOXZnZTZWV1puZktDT1pNaDdS?=
 =?utf-8?B?RFZHYVA3OWhyZ1dwVDZkdlMwMUNQdEhjTHg4OGpMKzdPM3doU1lNb2ZlU0wr?=
 =?utf-8?B?bmYrRVhlbEprUzhWbGNFbk85Sk9NM3piYzg5VDhXaHZnRXRuaVJaL0pqZ1h4?=
 =?utf-8?B?eDFIamtRcW9Cd2lqODNSbk9QUno4NXNsQ1ErWXVqM3hxOHUxNy8xaVBwZmp4?=
 =?utf-8?B?R0NaalZ1WDVXYWJLZ3VNai9kMm1zYW5YeEJ2NDhQbU8rTTVzNUZZVXViYVpI?=
 =?utf-8?B?bzVBQUZVamZHQzJUT3pxcWh4WnNFamN5M3BndGdPR3ZoQ2w1NnJ5d3pLTnBP?=
 =?utf-8?B?TXpKNnF6ZVdoU3ltMXhKdVV5ei91RkhHbHFUSDB5aTY2K2NGdzJvZEUwTXRm?=
 =?utf-8?B?cXZwY3U3MHNjemM5aVMyTTdDdUwreWg4WkpoUGc4dDEwV01XZHFxRHgrM25a?=
 =?utf-8?Q?koqctkDVsbLqeW+ZUW2aF8g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W3FYeszVzU9kwhHAHNqA7zBBoxW/uzsUQX+K1WnEFEJ/41MWNuz03TrlVlq671DsDTXTb2wfAfiLBWUmYucCFB7SeOv7hWvT9j74SqQEio02TIHo4AqOhngKe0tUbuo3LzO4XD16Q7KQX4Wakf6I9O0IvN9oydWL8kRmFS6VcIc9ySmMwlk2pn2n8AIuMLd/mfbb97UkZ9Tx7FkvzjgI/6Op6wO3ystykIuGyz+46NC9ggshEao9ldelPQSFHAI9whnPAql7N1P6e373PylXv2RaMI0yvQhwuj5BPO+Q2UysfPBpft0lxAELIPPi0JGZ55Tv2nergEGp6V9YQyutD4U4bluB3c9rnm8pVM1K/Nd30ABVynQD3Vnb/UDbKRS1/udfYcUxJL0bVh2ZDb1XSMDxt1Ceu6iXcTmR32mYrVwX5rMp8RqZd32tf/0uyoq3p1uFVAxe6acsYOD1PE0Mi4ZR1NT6vagyaauj0hGYeuYtjNLrk0Iey6ZvwumTcvhP1C1nPTb5W/18pvCOVSzOF8MsdsrfhpxjEClAI2D6HXgtnEnswvMRhaPc60XQfmVA3ucU5/JiSqqmKJzJSfcUmZNwaduhuHPFiAIEbddyEPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4a3cc4-b9c5-4be5-c05f-08dcc5a3cc56
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 07:50:48.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHrgxkgPyZ/FT6Xe7sxuMqaX5kCSRV7a5WiWVpJd0qO1IjM4oCw9aohDS+LG5XwjYZ4WBwrOirxCvIdm5YwOAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_04,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408260061
X-Proofpoint-ORIG-GUID: h1q5E98sPHycMBOvJvcBSt7QPeloKIVT
X-Proofpoint-GUID: h1q5E98sPHycMBOvJvcBSt7QPeloKIVT

On 23/08/2024 22:28, Will Hawkins wrote:
> Handle static and external linkage for BTF subprograms (functions).
>

This looks good to me Will, thanks! A small nit is that it might be
worth mentioning explicitly in the commit that BTF_FUNC_GLOBAL linkage
is ignored since it does not require a linkage modifier for the
function, but..

> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_loader.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index e0d029a..488c757 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -30,6 +30,9 @@
>  #include "dutil.h"
>  #include "dwarves.h"
>  
> +static char btf_linkage_name_static[] = "static";
> +static char btf_linkage_name_extern[] = "extern";
> +
>  static const char *cu__btf_str(struct cu *cu, uint32_t offset)
>  {
>  	return offset ? btf__str_by_offset(cu->priv, offset) : NULL;
> @@ -87,6 +90,11 @@ static int create_new_function(struct cu *cu, const struct btf_type *tp, uint32_
>  	// for BTF this is not really the type of the return of the function,
>  	// but the prototype, the return type is the one in type_id
>  	func->btf = 1;
> +	if (BTF_INFO_VLEN(tp->info) == BTF_FUNC_STATIC)
> +		func->linkage_name =  btf_linkage_name_static;
> +	else if (BTF_INFO_VLEN(tp->info) == BTF_FUNC_EXTERN)
> +		func->linkage_name =  btf_linkage_name_extern;
> +	func->external = BTF_INFO_VLEN(tp->info) == BTF_FUNC_EXTERN;
>  	func->proto.tag.tag = DW_TAG_subprogram;
>  	func->proto.tag.type = tp->type;
>  	func->name = cu__btf_str(cu, tp->name_off);
