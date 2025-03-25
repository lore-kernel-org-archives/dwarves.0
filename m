Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23581EA7F5
	for <dwarves@vger.kernel.org>; Tue, 25 Mar 2025 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902368; cv=fail; b=nHYzxZLqQy2I+bWt+dJhYq3uFqbyVgLh8HTP9X4FnlBNxAyxHLjmGFfP1k4SLdZVNIlPqu+NxobmMnxa7u4mwo1i+SforEybJP1IptSMH8LDU3Tl+73ADR4OnblbP83zBYT++sJgxeSOPeAHUf3bdh400wTQviG3kbEXoPwgzk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902368; c=relaxed/simple;
	bh=ADEA4FFXvyYJtPNizf2BcKWzh08WZO19yfy5uy3E/fc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mBXmg1hJo4FVSHLbEgsUYDXJCgqAu8DJUMVpDTr8giy8rwIv0frDRIZCyZREPIPAQW/5W69qtnUJy7fe1XjoI+fqz8OVfmcVdX+diQOV0gOisuDSFDtFpve6jW6O7bqtUguQI05/PhXxRySR5NoKGGvfQU8QPiX0lobyWTuL4w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fKZqngVY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QfB921Vu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fKZqngVY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QfB921Vu"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PBMuRk016609;
	Tue, 25 Mar 2025 11:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oXpUKBuwlOS/+4q0Zxv+oxOETKV+QNpmp3jTe4wpBPI=; b=
	fKZqngVYMIYagd9Kiyn36yXkgLf1Vrgx/WtLeEi/LO58yAe5zuZPcBc3JJz5Gm+p
	f1cz/y38Vxs/dcaGDg9I/kxokUoFTMMQqKugwNLSRqMa5yrg6jViJ2wRbXwthWlY
	VCeG7/UxP8b2yThBJfEbX8q/8pQA51Aee5qYmGQ/NQ7+7BaxaOZUIYSt5mgJTvFw
	PUWgK8G0oNhcCAZI02kBZLUpl5zuBMNBDEoFSZMThzYPacH3IDAYGXfIXSPb2F1N
	DGszfPQhfaXchztQ8VGkTfYMaVUyQFl1AOHVm4o9hV/RVhygRTnGLvRVKbU/9hWM
	VvlXn2S4J18acFgiQU9tBQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrsepy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 11:32:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PBA6xJ015212;
	Tue, 25 Mar 2025 11:32:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj91qbxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 11:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlW6R+St15+bhR45oeAZH6srkhFhSkqIUQZOfiM2KyJGq6jsEHoLWtQlr1JWHjuF4fQ86lTVTAxLK1YfGk8+3DQve8RDbzREgfi3lJAHQKysyBRq9t6vx8hnrmILiG4zoNqN1SvFDpzdMV2lYMGZF1tqXWVEC3b3q4gD+wPLHzPclCOD4g/P0jezaPixjzSQRzugJHT7PW0beoDPfEUBuHk6uSV7CxH1wOv9AMkLzFr0pg8WazNT1TpClfjJS3gWPBP1GJi90JaiGBrCI8Otl8Q4PPTs8BQgvhwwmNW+L2o6tDIBXVvjh6943bp0TOWkGhdhXL75o834ej97vQ7ueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXpUKBuwlOS/+4q0Zxv+oxOETKV+QNpmp3jTe4wpBPI=;
 b=xqmuS3oWnLcOS0K8vBYxQgWSTIs4rEGE29wVayYLO/xCBn5ufpFzEmEMDttJyYP2jACV1KAb7r5mWQw4Lf6W6XV/eq5GMm5Ms566/TNoC4xixnXwdxWQNrcvT8C3htUQgIPgG19fpkZTPxBL07ZGxPqT2bmkpbmKambIAoVnvleJtFr6nfd0AdNQoNdEw8wYeOuht+L+9QS0jNbgHo+pna8Hzt9hGr2ubcGdIH2K6DG4rcIPENwe+ZLgsgQwybBmKM64NDEUsy7m99yGYW4Kxbr1nvSsQB3rq3j1aYQMtaFmMWOSzBK0PykDF0TXfOeBnSYe5bVA5qA2ShMPdG7xoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXpUKBuwlOS/+4q0Zxv+oxOETKV+QNpmp3jTe4wpBPI=;
 b=QfB921VuZMce5VJO8l6lMd0RKp+LNnwdanNCuQ3FEtUZEK0boLGRde05EC/9Gqam0SbjJ2SfOpeCpCCfCY3vVfZ79fZ47sUfSDmARFalP4A3lOG74C/efS2t2NLAfDrJwzvOLvAkLQv+WYLqjfuQLfE8jXfWVXBPIw78YoT6L3w=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6797.namprd10.prod.outlook.com (2603:10b6:8:13d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 11:32:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 11:32:39 +0000
Message-ID: <880f4a6f-cd49-41b4-be9c-38f85647467d@oracle.com>
Date: Tue, 25 Mar 2025 11:32:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: parallel pahole hangs while building modules from
 nvidia-open-kernel-dkms
To: Domenico Andreoli <domenico.andreoli@linux.com>, dwarves@vger.kernel.org
References: <Z-JzFrXaopQCYd6h@localhost>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z-JzFrXaopQCYd6h@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0561.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: d2091948-dda1-46d1-a7c7-08dd6b90bf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVhTS3B2c3VnYytNd1grS1lLblpmSzUzYjNoTTVrZHVyTkpyblQ0U2FnMUZQ?=
 =?utf-8?B?YlphYkJYR3NVV0gwdDc0YWZ4REpjT3V6ZTExWjdaNzRCTklwT25CU05jQk1s?=
 =?utf-8?B?OHhrdE8xYi9EL3Vid0ZPdDZyTmlTaHVhUktVQUtWbFc1clY0dWZaYktjTGJ1?=
 =?utf-8?B?QUcrQURHaHQ4RDYxVlp2ZUdOTGdJK0hQZ2x4V0RLdlBVSDhkZndsdTIrY1ZW?=
 =?utf-8?B?R2VubFhpUXhVYVR4d1ZHdGVlU3NvdVhPc1FjYk9iTWlERktHdFFvdXhhWHNS?=
 =?utf-8?B?dVJKcHZwSk1hdGdTWlpvejhqeEJzZWNIVmk2ODJqWmhuTkp6ZWFyQm50ZlQy?=
 =?utf-8?B?Q2F2Mzl0SDNzN1hySkNza3liazFWenQyTTY0SUJkU3kwOHBabHo5S0dLQlVH?=
 =?utf-8?B?Nm9DUEJWY0J2SkpiSmFGZU5CL3dGQVVVK21GRklrbW9IY0haMmNVNkpjQjFM?=
 =?utf-8?B?U1lyU1ZqcnlLdy9yRE5MOHBMdWxBNkpxVEpZaHRjQS83S0l6Z0YzTENQWmV0?=
 =?utf-8?B?Q0VTUWpTeGhLT0FyRFNDNWs2UWs1OGdrakhhTDhlUGpwa0h3ZjNNdW5VdXJs?=
 =?utf-8?B?Q2pkUmNGK2Jvd0tXTlVLMVZSWXErN3dyUnRVaVJTdjhjSHJPa0pVbjZCZ0NH?=
 =?utf-8?B?QWJvc2lFK0U3M0hUcm1QSTZmYWlFZDBGSEpSTGZDS2hqRERzMjAzWTZpTk9V?=
 =?utf-8?B?UEhwVUJDZGlEcEVHSTMzTm9SVld1aEpHVERyRzBXRDQwRWIvZUE2akNkbm9V?=
 =?utf-8?B?dnBBcG1PV0dhbWltTnBHbjZCdDdEMVFLMVhNaG1kUDRaeXd2RStHVEtzYkJm?=
 =?utf-8?B?aGFyZjBzQm95emo0NXNFdDI3MGtIUVhTSWFUcmxwSVRQd00wRlN4M3U1aTlY?=
 =?utf-8?B?alNyR0hBd2J1U2xXTDB1QlcvTHdUallsN3ZOYUpZZUp6RjdGeHVjRklOVm55?=
 =?utf-8?B?dlp2YVd5ZldiRkpKT1NnYWV2SHByRnpJditnUTJRME9TME5PN1ZRMDVKYjhx?=
 =?utf-8?B?Rk1SN1FCZ21mMDRHVG9GZnhtSFUveFZTcm5LZG15dTVDalpucWYrSlZ2Wk9x?=
 =?utf-8?B?TjB0UWd2dWZwV1hxVmVhZURLNUtrWlpodHBqN3RCMnFaSUZPNmdiZUxNdXR3?=
 =?utf-8?B?bmhLWlNHMW1jK3JhUCtwMkczYlB1cXNsaTdQV0YwZFkzd3lnUnFEdm0raXIr?=
 =?utf-8?B?bGsrNGpwOFFxakdNSUpXcnZWRXc1dUYxNWZReHVaS05nelRzV0pqalpvelNW?=
 =?utf-8?B?UkpVVytEQXB4S25jMWd6aXpWUlY3YmJXdTc4aHUvQm9tRzd4VjhjSXB5cW9u?=
 =?utf-8?B?Y0hsSXZXL3lCS0QwSVVMWWo1ZGQxREltVVNRVkJVYktMTHUyYkhEbG5ZWUJ3?=
 =?utf-8?B?K2dxYitnS0hySm9GVWwwT0ZFbHdkcDkwM3pvN2FLdFpXWGk5TU1xS1FsbHVs?=
 =?utf-8?B?WWZUQUNvTUhoVGN6VU5iWmFUMkYwU09pUmdmSVF0Z0wrQUQ1YW1aN1dBN053?=
 =?utf-8?B?TUhCRGhWLzErUG9GdnFFa3hEY255QTRBM1ZaeFJ4NCt1akRJSTBGVVJVdEgx?=
 =?utf-8?B?MXAwM3NvMGx4K0RXRWNGVDVld3FGeUFuT3dkOGFpbFJHS2FycVVWS0VYbEdK?=
 =?utf-8?B?WFZFL0hkYlgvQ0VTSWhIRzUyL1ZaRUFIOVU2ZWVjWHJ1MDlsSVNuV3FUSmw4?=
 =?utf-8?B?dThBUFdmS3hITzRGelhtZ2tFaExRcXVvNUttNXdaOTJ5VlhSZGNnR1h5UlAv?=
 =?utf-8?B?bTZ1NFJsS3o1c1JrRHViNGw3MHA0RE9ZMTZUKzVORHJ3S3ltdmtyb2Voallp?=
 =?utf-8?B?SURSblNhKy9hV1JvY2IveCtZZFFMYXNaTlRUNW94Zzk3S09PdFc1b0V2WHJ4?=
 =?utf-8?B?VURVRzBrSjJzcnErTC9Yb2Yxd2V6bEpQcTFhNnpiTFFKeGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm4yOGJtY1JuNXBpNU1qWFRPS1lyOUJKbHVBUDl6QU9PTVdqUHBPajJ3Zi9Q?=
 =?utf-8?B?NjdZWlNwMDA5WkhiYlM0bmFRWWs1V1FLTW5sc000aDdxWER1T1dGZVhzQ3hk?=
 =?utf-8?B?UWRQU1RLK3RkUUpHNHUzVFRQRGZkQ0xBbUFHQ293YVZaa3lvall5MkhheWZX?=
 =?utf-8?B?Rk15YllQQmN0NzRuR1lySllHUi9pVkh5SUF4dTluTE9wZng3ME80ZURuNGtm?=
 =?utf-8?B?UkplcjNQUVVaS3l0N2dTd2Y1NkhIUENhcWRRRllCZjk2UURtNGNxWTVxWmVx?=
 =?utf-8?B?K281dm96WWJvbSt3bk1xWkZMWlJlUXhJdjR3cTh2MXNKSGRMWTJzWFpKU001?=
 =?utf-8?B?L2RZNTdrYVFnQjd5Yy8ydUtrZWNXdlp2ZWZ1dHBicUFVSnpqRlNXNWdpTmFD?=
 =?utf-8?B?ajd5d0tqYnQ4TmZEYy82cmZZdEVTckY4RWY0Zi9kNDRmNkhrejFhUSszYngx?=
 =?utf-8?B?dnR0ZU5EVy8vYkhPSm5JRlpiUXFqb1hxb1IzVHB6a29QSEZ5bm9TTzQrbm5X?=
 =?utf-8?B?LzN0RGVvdG5LRTV3UVF4MnZFQmpCa0tHMFpBL0JmMHlYR1c4b1ZjRjgwOExZ?=
 =?utf-8?B?QzlTakhlS3VsVCtyZENHZzZLY3JYNVFMYnJzZ1JoMmg3bHpIMkN3NlQyR2h3?=
 =?utf-8?B?UWhOV01BUVE2RnkrSjd0WmR4Y3ExWURBdXQxck5zbGZ2UFlQb09UZkoxemMy?=
 =?utf-8?B?bi8rK2R3T1g3UVdhK3htVG5veVpob3d0NFpIVFhsOXQyR091bEltcFk5cEZ2?=
 =?utf-8?B?L29jZllvMG9zZmhtbkduVmFUZVlkdXBCSFpVV3BkemQ4UFF1T1ljWlNhQ25Z?=
 =?utf-8?B?SnN3cWxBWVJsSU1WdnhBS1Rrb29QY2taV0QwU0M1VE9FQmRlYU1lSjVTakk3?=
 =?utf-8?B?Vmc3Um1LYmZNZFJGcS9lanB6T0dONlJuUEJSdE1GUnYrdDJkVnhNUWpwVGdr?=
 =?utf-8?B?ejJzOVhRbnp5WlZvcW9kNU5jMFlNOFBSejdIK0dLWDc4NGJTUkR1ZWhVWkF5?=
 =?utf-8?B?bW13a29LMWlId2Z0RFN4S3pqNW01MlZWdUkrWGs5aVlKMm0xM3U3bTNEK2p5?=
 =?utf-8?B?ODBKNEZCc1RxMkxmdHJGbmZsOU0rbk94QW1NQzNWbGRxQ0dmUEdINHR6T3ov?=
 =?utf-8?B?UEdzREhRRG95Zjd5MzZKWWpRWUI1MTJ3cm9uejhFTVl4Tll2MDlFM0tiUTlL?=
 =?utf-8?B?SXpjcjdvSThqNXhUdCtZSlJCOFlWcjF3dmV1b2h2NWdoRDhlV3FmWit4OVZu?=
 =?utf-8?B?d09QWngxOFhjOGhwdC8vRmtkUUFKcG54TktyRWl6TmxFWW5kL0EvUW1STHox?=
 =?utf-8?B?djE2WlpmdTJXd01sVUhFMVZiZDZOUlhBNUp0K0NqditoZ0duMTVPT2dnNzRi?=
 =?utf-8?B?SmRudG1kd3AxUmV4RVBpRWcrSU5OUUVKUlNFNUh4SG51VjcraWVQNFRpM1M5?=
 =?utf-8?B?cEp2WXB4RmhleTZtdk5ydmVZS2JGOEMyMUdGV1p1bnVzL3hiVG5EZVhLcGJs?=
 =?utf-8?B?Tk1pOFg5YWVFSTdlSGZ2WE5COWFJcFUwbTMrZ1AycG9NWkNMUDVhVStlcVNP?=
 =?utf-8?B?KzV6cHNLbXhJRERsYVg3Q3phTWF0V3FDT3Z5eVpDQzU3cHJOd1kweit1Y0k5?=
 =?utf-8?B?ZjVFT1QwV2RtT1JsRkUrQkZkVTA4TXVwZEE3WERPcDJmb2ZaYkZZL1JNNW54?=
 =?utf-8?B?MFkxVnE2QjBEWWpjOGFPcGxLRkREVXQ1YmJiNzZjNFI2aFp6WVpoU0hlb1lC?=
 =?utf-8?B?ekd6UEVOcTN1Zm5xOW5MYW5OcExTRVdXclJVT01KZ1JIZmN2bnBBdDJadEMv?=
 =?utf-8?B?Z1g0UE9nc2c1YmxHa0hycCtyTExyOXNnZ3lRd1BiR0VETWI1R0FVaHYrQmdD?=
 =?utf-8?B?UjJKd3E2b3NyVUVGRCszY0VzSW9zZkdUeXJLVzBEKzlOb2xZa08yRElJV0FK?=
 =?utf-8?B?WC81VTVNK2QwQURMOXBtMW5ZT1Y4WEJyeHNtMEovOVdUZjlVZFpQazBOV3Zy?=
 =?utf-8?B?MW1xanFSSUtTOXBEOU5iMXZsQTdxZ3ZBMEI0SWlxRzNwa1RXSVpyK2p6Mldh?=
 =?utf-8?B?bFk0U0c3T280SllFK1E5Tjc2NHJCbENWWmhQK3c1TDJpbm9OTXBCb3lmOWhV?=
 =?utf-8?B?cjlSbmFyOXhYOWFtN3pwQWJhc2R3YzR5WmpvWkZHQXpiMXBKSjZGQTNzTHJU?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f3PN+kJWPX2Rdfcx9Y5d1a3WcmXZ2fIsWOqBXEuwD60qlOfYlWkQWH/kiaXjhyBl5lhOVeh9Pbear4LacPNWxZN81Pe7rIVsXjK62vO2qnTbl9/1jgCYtgH066H131TGstDuIUyTI86uLflJt8xW78r/QCsa62f8gE8Dy6JffGTzqqU1hZF6dgWSJhiZbaRZR3xaInweo8tTigRK6G0Y69fJD1WhiMvaXUBtgI26qOZ+M5vzJ+Dv3n5NDASfvEKwkuviOGwx1HMZM4k119LA80vMb1HIKaZb4CUpR/B4addV8C1EYkkivWRB2PzzFSd1ka7x5lPIW+aaEbwzBth8U93f0Noghq5sB+neQ2bfe7ibFHPa+yYLHVkwlsVVlSc80mLRj+eqpmRxcCRf6K8AVm4GHoJkm49xaBtVGZapbceIIQP+GjIDDtxirkAaXoJdmrbjbcpHlOr9GK1u8sYuCPystreUxn/AasSjGgG+PIJo6OroiAHmBan1k9jGGJ91jWq/gghpAyEWPEP28e2abkpEEI1HCNnUMVxSHmRa+5fUVZF5dvK8T4YOcBsVWvwH7HNVbme59pxZlZ7P/GE4veG6Cgt/Ttl2qSb1WdnDFAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2091948-dda1-46d1-a7c7-08dd6b90bf6e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 11:32:38.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+AaWXAmYD5hxv5nlOlPUzmVE8s0Xa0C2dcnfEZAbTZOhBCbUYzS2jDAVNzG99gI27CnhpPB9wc4vQ/4pURTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250080
X-Proofpoint-GUID: KqHdteL5B51Xyhw0rsWPyaMlUK38GaX2
X-Proofpoint-ORIG-GUID: KqHdteL5B51Xyhw0rsWPyaMlUK38GaX2

On 25/03/2025 09:10, Domenico Andreoli wrote:
> Hi,
> 
>   This a forward of Debian bug report [0] where you can find more
> details. At [1] and [2] you can get the kernel and module to reproduce.
> I could reproduce on both amd64 and arm64 using pahole 1.29.
> 
> This is marked as serious severity because it makes the autobuilder hang
> as well [3].
> 
> Could you please help?
>

I tried building https://github.com/NVIDIA/open-gpu-kernel-modules
with bpf-next and latest pahole v1.29 - based on the next branch from

https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/

...using gcc 12 and all worked fine, so I need to try and reproduce your
environment more closely I suspect.

Can you provide the following information to help reproduce this:

- pahole head commit you tested with; it's described as 1.29-2 but I'd
like to understand exactly what commits are in that package
- which version of open-gpu-kernel-modules you used (which commit)
- the kernel the vmlinux you used was based on (which kernel tree, head
commit etc). the bug report says
/usr/src/linux-headers-6.12.17-amd64/vmlinux is used so does that
correspond to the stable tree 6.12 17 branch?
- which version of gcc you're building with

The more closely we can reproduce this the better. Unfortunately just
having the module itself without the base vmlinux doesn't allow us to
run pahole as we need base BTF + module for module BTF generation.

It's possible extracting base BTF might be enough here; from the vmlinux
you used something like

pahole -J -j --btf_features=default --lang_exclude=rust \
	--btf_encode_detached=vmlinux.btf \
	/usr/src/linux-headers-6.12.17-amd64/vmlinux

...would give us the vmlinux BTF, and we should be able to repro more
closely.

Thanks!

Alan

> Regards,
> Domenico
> 
> 
> The command to succeed:
> 
> This simplified (sequential) command succeeds:
> 
> cp nvidia-modeset.base.ko nvidia-modeset.ko
> LLVM_OBJCOPY="x86_64-linux-gnu-objcopy" pahole -J --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_features=distilled_base --btf_base vmlinux nvidia-modeset.ko -j1
> echo $?
> 
> producing this output:
> ===== 8< =====
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> Unsupported DW_TAG_reference_type(0x10): type: 0x28172
> Error while encoding BTF.
> 0
> ===== >8 =====
> 
> 
> While this (parallel) command hangs:
> 
> cp nvidia-modeset.base.ko nvidia-modeset.ko
> LLVM_OBJCOPY="x86_64-linux-gnu-objcopy" pahole -J --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_features=distilled_base --btf_base vmlinux nvidia-modeset.ko -j2
> echo $?
> 
> producing this output:
> ===== 8< =====
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> Unsupported DW_TAG_reference_type(0x10): type: 0x28172
> Error while encoding BTF.
> Terminated
> 143
> ===== >8 =====
> 
> 
> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1100503
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1100503;filename=vmlinux.zst;msg=19
> [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1100503;filename=nvidia-modeset.base.ko.zst;msg=12
> [3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1101262
> 

