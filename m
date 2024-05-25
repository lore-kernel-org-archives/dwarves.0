Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4A12E5E
	for <dwarves@vger.kernel.org>; Sat, 25 May 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648186; cv=fail; b=rPTNI40QRUc/C8HGedAsBI33sR6+Vzz8aOoQxaBCs/wwF6ABGhDcWZwmyNXrc4PzyGUur3WorHSBX/Og2rIcOyKzoGYPDS5IWJsTlK/6MmnDz1nU+4jIOaHj7RBkR7dNUG7LOmLZmlYsZVylcS2nIWfohTFRMWveZQaz6072zuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648186; c=relaxed/simple;
	bh=+7kWMtPJBH0KNIVFQoynV4lJZ+Mvc3Fyzg1vtYkrKlA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J2qDDJ/+iaUO6/QQ6mVqub/rEazizRSij7OU9AVlF1E7pHiTGnKsbbHM+vKyOueC+V+XJbF0GlALQo0O4VY4iconD19VtFO+xLyDHRAJPGT4FK9+AViZ3JM7ZijH0ac7s+OY9sht1JG5gYxLaUORa2jbnTvJkPNUEU+z3rrGvFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44PECPp9009279;
	Sat, 25 May 2024 14:42:57 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DZKqI/vXxdnTuiFbyy8ICH1IJBaItTdOXVZ4hx8+b/8M=3D;_b?=
 =?UTF-8?Q?=3DeFPaT5cx+MNNuroWqTMoQvmw94WuCp2KMetFzGrgZtmaj0I6YFKVyjvCCPbL?=
 =?UTF-8?Q?gXdoqflE_pm2JPVU4qJebk7mLgQQvgJSqTs65621WsBoF9K9Mq1uR03U6QeuXyI?=
 =?UTF-8?Q?uNc+3hWxeKbrCS_8ABbSEuBM844FTHYvUaWLLCs7PE9lO35Bu2P5EIj+w4pTh8z?=
 =?UTF-8?Q?Rujcvh0tML7aAU6Ot3Q7_SGzRP66gKYQC3HEeE0jLdRe3IZNHVnJMrrT830SrxE?=
 =?UTF-8?Q?ww6nQ+a6B34upuI3HvMisY0mnQ_j6D9JRI3x0SQmEjZC+SEjRfAtai9OJPGfRSs?=
 =?UTF-8?Q?l1ch3roB2jNzE5UAVTEVgfWbXiyxrkQ9_rA=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg0ceb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 May 2024 14:42:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44PCcG5n024426;
	Sat, 25 May 2024 14:42:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yb6e4k00a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 May 2024 14:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArZ391RCKJcSAVhifr4XRCCG2nSju39O3+FbIKnAJVkgPwDdoIUyHHv7ROZbKu5s2LH0rXexjzemArUsHWFlpbpa4n46gL67gU8aBLiXx6yqI4aZO0LRHkCO9ayF0TU5y4+i/5KxOO6hAz9q8+ZpU5IYAJHlcOk+kmqzKTob5H/yGLAjrZcPXRyvQMzHWbPsni4AdWYV0xY6ahLo9jvIcsSOdwSq5aBmJbPbIn0kJTfo2Qujv8fJ48TZdAn9Gp5KOn4WCigs15afKbQPK4qo9O5Gat1ABc0TzY85qFxsbqeAXbhoWqYFBOS+OndMvWBQI2C97+b7L/w8OIQdG8fTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKqI/vXxdnTuiFbyy8ICH1IJBaItTdOXVZ4hx8+b/8M=;
 b=OA4qaB2MbmVhvJWh8mWGnI9YpKP83HcHKjJA29j7eoW56sVbSO03IxzSWb4itSPSyWwRED2Lvq/zCnR3mzOC/nlFCK/wKlIq8XS1bHKZk142tRRPE/7tGUBO+ia15zRqxjo1McU4LuKGxRxCt958icr5rylb6UuCX94zzOOe2NtMykon9DEMta07j4iOYeAhcvpiFmbWBONJgAiu9fOVbqKFYmpXEiBZRCttjahJzpvp2iYJNjSVn/cTbbi/XwFi/cQselaSP2Vg5CJ9LS6WsIB2ltH0p4PEjGEGBfMZxKKkWwAgXAbmCcIVnh7Q4SSopCJku5j51ZAhRmjHMjw9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKqI/vXxdnTuiFbyy8ICH1IJBaItTdOXVZ4hx8+b/8M=;
 b=ZMLVaW7Q1sGO5jn03NrGhKt6WR+c5xkV+/XCpiBU12gRVuY1w5+xOqtQweZvScfd+yCqQ3A+v6wxn42FSCJ414Kfvoihv+RxROdlttzVhFfWJYzYT/akQWVGQnkywxTXunuaWy+Hu5ykbbDw8QXUEHLaT2BbDDrmLlWfHg7ILgE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Sat, 25 May
 2024 14:42:54 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7611.016; Sat, 25 May 2024
 14:42:54 +0000
Message-ID: <e6b30dd4-531e-41e9-96ad-39e6fe73be40@oracle.com>
Date: Sat, 25 May 2024 15:42:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: pahole -J non-determinism and reproducible builds
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Giuliano Procida <gprocida@google.com>
Cc: dwarves@vger.kernel.org
References: <CAGvU0H=MvKi=fk6K1M7O+OoGdnNzweXE1m=18yv2DHoPbRVASg@mail.gmail.com>
 <Zk-p8EPf-5juWsS1@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zk-p8EPf-5juWsS1@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab6b629-b9b3-46b2-e5dc-08dc7cc8f62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?azJwakFoeFEzeUZ5djV1MjFBZVdibWxjSEtQOWYydzM3eFpmWTVTVXJPd2Vy?=
 =?utf-8?B?ZVorVWJESStkcCtBSGNPeldQUU81Q3NVSW9FQXFkalRTNFBlalQraExnQm5V?=
 =?utf-8?B?VktIVGkwWEFKU2ROUWtDaEFTR21oMzY2U2NTL1U1Y2dPMENvQXRjdHNYY1M5?=
 =?utf-8?B?QnE0U01ITjVjeTBzVkR5Z1d0b2NERG9zWEFsNCtRL3dySWM3OHhtb2I2RFoy?=
 =?utf-8?B?VG5uQytyQUxNK3pkL1BuVDdDbXNPengxTGFVK05QQ0QyczFCNC9YL2dqanJz?=
 =?utf-8?B?TmRhYUVnUXZqNlppUlQ3eFlnSG9KVzBPQUtReURzNWhzSUxIZnF2UXVqWGFi?=
 =?utf-8?B?QWdvYlJqK1NjSnM2Vmp2b0Z4RXMxaVFraTV4UDRJWmxweDc2MXYyL1BkYnhw?=
 =?utf-8?B?emloZ1Y1OW9KeDA1R0FUOWk0dWFNUlgyM0YvNHNOZm5saGhuM2UyaWNMc09T?=
 =?utf-8?B?Mit1TUxPT01YUll4cEhuL2tNR3dYSXdZSUlndHhlNmhqaE1FdS9hSWVmV3B1?=
 =?utf-8?B?SzZlRFlEODZBNmZYQmF5VzdPanRINnlidTU3Rk5SL0VkcU9KREJKNW9kYXov?=
 =?utf-8?B?aFVqUHVScVJwWGtzYm5KdjlwZGFndHNkaXlGZ0tHRFlkRFNpSUxZdkJMSWl2?=
 =?utf-8?B?cmlTTHhKODBoMktPaWl1WlNTVk9RRWxQQ2lmQnc0a1EwZ0tTMEM3d1AxRm42?=
 =?utf-8?B?aHczR1A2T0hDQytnaUJCNHQvUnNCa0xrd2p5RUJ5NmkzaEczYTJjT0FpOG5V?=
 =?utf-8?B?UmdUb1hubFZUZk9IOW1SRUV1Mi9EbW1mUk1ISk9SbG5uTUY3TSttRG4rYk9y?=
 =?utf-8?B?c1BmT2d0cGpIMG80MnFENnY3ei8wU3BDSllobnpmQVJGRVRtL2hXWHZTTnpS?=
 =?utf-8?B?NDFUNDgxYVNWaGNKSURNZ1BTVENUZFdSQ29sanhtQWdFRHYvbndXT01YOHNm?=
 =?utf-8?B?SjNkK1cwemdTNmhrbkxqNWw5SERIRHF0WVJHY0thdFNGeFlNb1BsRytDeXFt?=
 =?utf-8?B?NnZWUlY2eXZTblZxbXlNcGd5citEejZxVzBLYVA4bU9qUEJJK3duQUVjcGNZ?=
 =?utf-8?B?TFFNbk1BZjAxOWYxSlA5cFgyYzBKcGdxcWNKcmIwZWcxN3dVdW1xVDU1T2ZN?=
 =?utf-8?B?dVlTRUs5R1Z2cUxwdDJ6RmpiT24rRHJ4Mml6QnRYdGJSdFBHa3J4M3RUd1o0?=
 =?utf-8?B?bnNmV1M4VE9LOUUvMUVnWFR0WjFpZ0IvWVU5aUlKYXFDRnBwTmIxSElxOXVZ?=
 =?utf-8?B?OEhoZmlTZW5QanpuRjZ2c0h1ZTE1dk1nNXRKUFhyY044b05vcXNnaUJSdG5C?=
 =?utf-8?B?cThKREgxbXNVcm5wYmg0Y0xuSWs2dWxhaHR4Q1NzZjQ2NmtBRjMxK2VZWmky?=
 =?utf-8?B?UjJjMWJiZlJBVjhVeXIwMHhwZDVxc2hXU3A3N3BsSm4zcXdJT2FwOXJkNW1Z?=
 =?utf-8?B?Nmk5UEhLVUdoMHAwTkFZV0hOenhQeXJOclByZk1QZGlORmtEdTRLREx2aDBP?=
 =?utf-8?B?di93Ynl3WSszUDl6ZkZja1EydWF5WWhmUzVLNUwwTHRzUnBQbkJTVFk0OE5I?=
 =?utf-8?B?OW9nOFNPNndDbG9LUWN2clByUTVWdHpTdFpiN0k2MFlLRmtwZGtrN1UvWlFW?=
 =?utf-8?Q?7K1bIitP/jkmhwPaf+X8OgbDpH2rYROiO14odfnTNDjM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWZPY002c3oxdnh1V0s2TnkxbTVmbHlmMXF6ZWpyaUlFZ24yUU5RWWRNZlEx?=
 =?utf-8?B?RUg2cDlaVTZRalFWbWg3WWdkNC9jR2t2Zm0rbVYvRmRXWjFSZFVZSHhvMFp4?=
 =?utf-8?B?V0ZsVnFYYjhDK3d6MThPRlZRNGpsMjVBOExNWXdtczhxTDFVSHoybUVLNXMz?=
 =?utf-8?B?YlAvQkVZckpZdGRBT2NMRUN2NGtKclFOR1pvczk1VTZ4eFBtYlo4bG83bVVD?=
 =?utf-8?B?amsrUWdMZnNIY3lFVkxaSGVzRTRxT0ZvaDh6QktvdldwWEFaOTMvZjRORE5C?=
 =?utf-8?B?Z3lxWGJpclBLN1hYVmxuVDRhTGs2dy8xUDZuN05lM1lWVzdKbThpY0l2Mlhp?=
 =?utf-8?B?NGhEZkF1ZFlLZjdOV3dqdXJhbE9ZQ2w0TVdQcjdVT2kwNG1aNHdiRW9BSGox?=
 =?utf-8?B?RExwdTUrUnorVjZGMmtLcXB2SVprUkJoRC80NzBJOEJ6Z081VXR0T1hZdmNF?=
 =?utf-8?B?T25aaFRXQWhQWXlockErRGtRb1pPR0lyQUFmTTB0bFB0Z1ByS25vUWl1ZTBB?=
 =?utf-8?B?Z0trQ0VrL2pxZzFGZUtvbDJsM3NLR2hyRFlMSWhmTDhka3p0TFF3ZHNDYmZE?=
 =?utf-8?B?Mnc1MzQyTnkwWmNCZUpjT1h5RFNxelJYWGp2M25JS2dvNUpPdlBNSXZIZXFD?=
 =?utf-8?B?b3JaYVA4Nk1ackhHVGczZktackxDRG1pOGN6TXEwQVNBeGNDcGpUaGo0eGh1?=
 =?utf-8?B?R2lna2tvWXVXQmxaWkNFS2ZkMDh6L1dwL2NFTVM5NGtXZjFMcGVmWmgyRStM?=
 =?utf-8?B?elliMFp4VjN3N0NYRFlGVVJWZHJpZ2xZMzkxQWRFZmxTaERrT2pnck1lcnhL?=
 =?utf-8?B?emZmSzhJdDVlUEtERDh2eVhXbVFaeTc5ZjU0UEVKai9WYmM2UUxXcGI4UEdO?=
 =?utf-8?B?ak5DcWJIcUMyK3EraUVndUJaaEppdzBsWnlvOTM1aTJxdmYzeWhFUjNnTlNH?=
 =?utf-8?B?SU16OCtUTmJrUUJiWFFGNlg0T2JlWThyYjdJaFhYQkFtOVVOR3VrVmRRS0tk?=
 =?utf-8?B?K3BFdEtIWWFiL2xVbFVhRjV5RlUzSHFZMU1vTCtnTS9jZ3U2a2FCYmFyUldS?=
 =?utf-8?B?dTErSSs0cDdpZlFZaW9ncGF2d041VWVxc08zZmUvZVRTV2pYZVZDdWdPUlVx?=
 =?utf-8?B?dU4wWEhGS3FSeE5mK2JsZm9vZVh2QTEzNnQ0UHZCL1Z1blZBZExGWWYvZG1a?=
 =?utf-8?B?UGNhaVpsOFBwcXp3T1JoVkYzK2J1S0ZkU2E4QkFaQjcvWnlxbGNteWx0Y1Jl?=
 =?utf-8?B?UEdkN2pDT2VQWWttbXJlSXJ2bURRT0kzYzMycUdVRnRvL1cvb2pzYzJCdHY5?=
 =?utf-8?B?SWRxSWZ0OFg5ZklYUG8zMlZQWTVoelcxUlgrME1rdmlPWTBCdGxsZkhZWjBv?=
 =?utf-8?B?SHRlSjd2blNNMm1tY2xXQTF2R1FxQ2dNV09VcWErMG81dXNIYzBKdjRJcmxU?=
 =?utf-8?B?b3A2VWRLck9ZVmZrUGdWTi9rdm9QaGk4bnQ5WlhzcW16aG4xbjhuM09YRi9P?=
 =?utf-8?B?ZkUyRG85VFlzQ0RvbEhaT1g1bVVhemlhSUNSZzdldUFab1N6VGw5YWdmdEdm?=
 =?utf-8?B?Q2xrYlhaUlIwc1MrU1RML3RWSFMvc1hLWmNVeEpuU0Z2aHErRGJpR0szRm1u?=
 =?utf-8?B?L2gwZE02aklmVzNmVGtsU0xPTlBINy9PWGdYNCtVUGg4NFExYkMxQXVGSlY3?=
 =?utf-8?B?aVZPTE9RM29nbUkvVmxIWG5Wa1Nhb0ZoSzM4YUp0ZG94c3UvVS9CMlRlWnRV?=
 =?utf-8?B?RmNJTEJCVjc3c3NZT01lSW9LZktTR2NRZ2YyZ1NVdHUrSGtLcGYwOUlSTzl1?=
 =?utf-8?B?VUk0a3M1V2VPSERoSnhBdG56T1FiNlN3Q2Vna2pyUTZhTmRwV1k3dzhUaWpM?=
 =?utf-8?B?OGNpUzMwMS9Wczd6K2dZbmZFcTJKeW9kOUpHNUR2OVBPbWZPcFAzMnpiRjRB?=
 =?utf-8?B?ZzN3QXlHS3pqL0J4OTlFMHdrVGo4UnFnV0laVEZGODJzTDljZzY2aXA4RDFP?=
 =?utf-8?B?UGk3TGxXUVk5MnNyWXBoVlM1MU0yYlZNRXl3YUY2UUdlKzZHcVE4VS9vSGI1?=
 =?utf-8?B?RG5YbElRbE1LbUgvdXM3ZXlkdCtSbDdtUVVYTUpLVXYrTlI0YmdGdVJYVnJX?=
 =?utf-8?B?REptSkdYQlZ5YVpHWVJxTGlsbGVyMXl6NCtzazl5Qk13TU5XK09nczVmajJO?=
 =?utf-8?Q?yBkU5CSpU33iquVe5ovx2aA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AlqIj4w+zojZu1MARDANmLhMnHHIz6584iN3p/cQLIQuTYqavbHHfMjL9JqI9/FWXyp0uj3tHufKFDWcj5ZHY/G3tJ0OBE10mvxyEDpvmLZfLzKvg9JHCQfMBjXEEkwv/NDxC6XlZ6vwWT2yXnRRkI/dZjkeZbFL14PS4Cad8N6Q+R1koWCQiz822QGBh7IpT4iG6MsERSX1NSTID3O+stGuEEYhVX+OpffNuHF2yoqOHKGP3BM73D1+ygOfTuaJVCW3KCVZ+/za+plmd/ffWBnBtEpMgo0wNezhB3aV19awsj7IZ7H1Ft6WpOtF7MtgPTRocj5lwS/637pY9y/DqJTvzP4oiCD4GI7boWnBqGe+l7U8WHfbtAuhRuT3R7FbPqQOsIFfugPnIK29+YtjwP3PMo8KSWBE3hFWjxCeDAXlogMGlj4jsVRLtPm3xU4iUnyNJKt2/0SoKDa8rowRcNaEGRoqB3/fbbXrEi5dc1W2DMaHvqhWXnbYA8a0NXe/Df7EMZAJEFzMqXBRBczwnNVGhtOxweImluahqeA27VYShW32WbQygyiAc9SjgKfC/786F2fGEFGZIAyG2jb3oHThE6AZF+4RfjXez2gvU6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab6b629-b9b3-46b2-e5dc-08dc7cc8f62a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2024 14:42:54.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHp0UI+Ga49qM5mwOZ4P9WzpVmJRlioMxQTw1iWhOzxWu2SqBuDrwNq551kWaZU3zX4kQDlbtF36hlOHCuqShQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-25_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405250119
X-Proofpoint-GUID: abOSCWYKZcKbqanT5QlavZs3Zi9Y4Fef
X-Proofpoint-ORIG-GUID: abOSCWYKZcKbqanT5QlavZs3Zi9Y4Fef

On 23/05/2024 21:41, Arnaldo Carvalho de Melo wrote:
> On Thu, May 23, 2024 at 08:25:17PM +0100, Giuliano Procida wrote:
>> Hi.
>>
>> (edited repost due to unfortunate HTML email).
>>
>> Until the reproducible BTF changes land in a new pahole version, and for
>> anyone stuck on older versions, pahole -J -j typically produces
>> non-deterministic BTF.
>>
>> For Android, we are converging to hermetic, reproducible builds. .BTF
>> sections are a significant difference we see. I have trivial patches to
>> pass -j1 instead of -j for the older versions we are using (1.23 and 1.25).
>>
>> Trivial patches:
>> https://android-review.googlesource.com/q/Ibd72ac638faa1826f6655b336cc7001591ea70f1
> 
> That should be at least configurable thru a CONFIG_REPRODUCIBLE_BUILD
> that then would check the pahole version and if less than 1.27 then
> would use -j1
> 
> So it continues to use -j from the version where it was introduced,
> 1.22, but for people wanting reproducible builds it plain don't use -j
> or if you really want to be explicit, uses -j1 as you did.
> 
> For >= 1.27 we will have 'reproducible_build' added to the
> --btf_features= line if CONFIG_REPRODUCIBLE_BUILD is set.
>  
>> Gaining determinism for the older versions means giving up some performance.
>> About a factor of 2.1 in our case (or an extra 10s on vmlinux).
>  

From the original thread [1] looks like we could also use
KBUILD_BUILD_TIMESTAMP as an indication a reproducible build is needed,
though an explicit CONFIG variable might be clearer. Only thing is it
might be harder to backport with a new CONFIG value; not sure what the
stable backport perspective is on introducing new CONFIG vars.

[1] https://lore.kernel.org/bpf/Zf2_fgs0cqW82zEu@x1/

>> Do others want performance or determinism, should I send patches to LKML
>> and the stable list?
> 
> But that is with older paholes, for 1.27, to be released next week, one
> will just use '--btf_features=+reproducible_build and continue to have
> parallel DWARF loading with serialized BTF encoding, which should be
> close to the non-reproducible build numbers.
>  
>> Off-topic: pahole -J -j9 is faster than -j on my machine with 36
>> cores, by another
>> factor of 2. This is v1.25. -j1 18.7s, -j9 4.5s, -j 8.9s.
> 
> I'll try to profile that on a 5950X (16 cores, 32 threads) and a 14700K
> (8 performance cores (16 threads) + 12 efficiency cores (12 threads),
> total 28 threads) to try and see if I can get a better heuristic that
> takes into account these factors on the most recent codebase that will
> become 1.27 next week.
>
 > - Arnaldo
