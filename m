Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0A3B14C7;
	Sun,  4 Oct 2026 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791096634; cv=fail; b=t9N0cyM0cAuDK1IZhjBiavGNtAyCS6JbwIIrpAfJZBKIkIxrzYEEC+hW5KRRiYdR3ftsN2KozOVuYmfX7I5M0dats2YBAGaAkw+hEIIbm2JQ6QH3AX2xuHtofecPvVOyN8JG/cOhZlaW3Vb18hKe4Wnvqwz1T/dvtE9j86auZek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791096634; c=relaxed/simple;
	bh=GAipY+u8EvPsND0EOgJVv7dKvRbMFib/bJdj+RVY1r0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZoXCcsLYxCmHx1Kd92LS8wt9jNd1bCWCqcWjYYgz8mWUSYIvKQt5mMjWMFtVNi1v218OPAK5iSOs8IhEdyulDhN5XAjfB50tmyIg/1LU8OHAlgtmk4bvDGTv8UmzTzVlBrlgADvjIKJQxyCG/+NDGCvAW5Q4pc0B2ne5oW4IBMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d0ukenRZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f2IYBn5Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d0ukenRZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f2IYBn5Y"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6946Z1NC2983954;
	Sun, 4 Oct 2026 06:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KivGWJ4AySdXwlMtx3wjFYeqkDfFx6Wucf+3h6RkEAI=; b=
	d0ukenRZ4Dyc7UurLHCeAlu3mfMoReCnQE14MXe8NUp2J+b4nfEShyQRbUPwjG4Q
	pW8xVBdWRWabmO3xAZNFwxw1bXBHPtD1MLhOG2FOuJP3STc9z1WWWu5gg3pxnDtv
	1Mr8JomcOTDrPRBZTxYmDgtMDQ64UuyEdRjTMCWc4wVGqf7v8eYa5uagGDrSVym0
	ypSGrDscc5JylgMSU8p1VvxigoUP4K/+G46ajfJWq/9MgzSNGMuBIUTJ6aHAHxBh
	J6IUQTIUGwacDNK1/PHJ8nGmoA7PsyYIrsX4JiA+hxVvSLfQR8/ghjnu65PW+Fry
	ipuG4711CkzfU1/xtkgl7g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2rg1rnhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Oct 2026 06:50:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6946oKDs023451;
	Sun, 4 Oct 2026 06:50:22 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r5krgm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 04 Oct 2026 06:50:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Shi5Curt3tlbe8xWd9Y7DnlTB1nDAQuZz+NnZb2zJHMHB0RwHhqbjDahIkm9N8/jmVVF5jVFC9FUMdFVc7VXpYfEGmRfBvIJ0vFgXIemsxC/9wlq8F/0UN8odGdvsVpyn4+H42cPKoejGRgR2btotgbqubsYCwSTc5JxlDQx54Rq0AWPRTKtPdWO5G7U5jwMGRVq2n/Typn8rQCE2mC4alcaw2Y4VR2ZII7baKSvCQSdlFmKWz4xdvCo0W+X/2LUaFOUjb0NLn02FOn6yHsWnSWj5rb2NmezSAbGVpP+i2Q21aAKVaGSDYZcr5uEIx5N55gr0rQ/rdXuHVR2Oin2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KivGWJ4AySdXwlMtx3wjFYeqkDfFx6Wucf+3h6RkEAI=;
 b=yBnccdpX376HNxEUPWePygOF5Z9naQ9wI9vhD4E4YUhoxZplldUE+BjObi/n4F//LGlVMN17s4JWkxYHlkB7G5NfzMiuCfvqu4tnVQM3gRGy2aoQqQ4dFVbOrnoKaj2ZLaDnW/v270Tw1+0aQDutpHTPteSohcsdPqkMYDb8CwHYt5KxwNdUi4SOL3n75H8ELR/4ypMFvrbMkgdyK1ffQpJ7voW2YQK2ZEaIPQwDTReui5qaakwZ+p+CeEt8JuoBJrGlCJA0ShRE08M93YvWCnZz7AVi84exruVtyl3MZpCAHiJIakF7eUCeUgy2YEyy5EmyWsPMKMmPL3BI5yrZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KivGWJ4AySdXwlMtx3wjFYeqkDfFx6Wucf+3h6RkEAI=;
 b=f2IYBn5YAjtAxQhv+kOqT2aQAVhHZfGQ/pz2XyA7REV9KkQzIvKYd3f5a8i5EGTr2hp2HttDGoTm7aZ3Yeamm7KvLuQT9XwfxZX0NkH2Sky9X25loyZCuuLuigOtwFMx658RcdwWhRklW0ykUR7QvZfhhAzFClawaElaMvZJy6g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CH3PR10MB7258.namprd10.prod.outlook.com (2603:10b6:610:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Sun, 4 Oct
 2026 06:50:09 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Sun, 4 Oct 2026
 06:50:08 +0000
Message-ID: <84593b64-4002-4557-9d4d-e9f7d44acdd5@oracle.com>
Date: Sun, 4 Oct 2026 07:50:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] dwarf_loader: Limit parameter location analysis
 to x86_64 and arm64
From: Alan Maguire <alan.maguire@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Nathan Chancellor <nathan@kernel.org>
References: <20261003084357.4185491-1-yonghong.song@linux.dev>
 <b845d224-fc7e-4789-b7cb-8decb3c9520d@oracle.com>
Content-Language: en-GB
In-Reply-To: <b845d224-fc7e-4789-b7cb-8decb3c9520d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0669.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::19) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CH3PR10MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: c76cda3e-b642-471a-dc79-08df21e3bad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IlfrSFaO6PJv7otr43Km1CTGNIPS0bS/9/drfxkVF2adgh5wgFunQ07VsoIxss4/BEZdZraisLEO7uZfwIHlgIXHT5N8TRBjfTrKQzxWFApL6GxZyRdY7u9W2IbbK+9BpxdVX8FG2T3NNhQkN1XogMBJ2wyRl2UMWlu4FYzrSPFNawiJfDoPCPxr0RoiI+iagujxSrnE/pquGTsu3Zo7OAYJzzvNQYOAm052ZMJJ7WBiCDek1nWXFaBQ0c360usNWetufX1HZVUhblwiQ3v0UeMNzZskB+i24WFO/Mh4JUoD4/qzrWXuhL12NlEh2VTmqbWoZAOdlLEJ2EVu8dthNYCJZc3CWHANHvhCoULzqXx2NxCCmbMPJ1jxYPuxPLlFPTmXJ/B3tSvVrlXdrR/L90c4v4Yb105LJu1aLOEs7dUp0trNmr53xvb64dUOkQ0IBLXVMBexMx2Ff6tVRWbe0KCpaFbU+E8kzKi7EcnDHdOLodTM/Sk5QrDDI3angR/Pirfm1lsPqNhs2yOfqPZfj8Zz9P428qXi+ZA6jgBJ+FdHeiotWh/dWqAJoRpVhBEKVdDu8jy1hC01ddefS5osJlzOnZnS+YaTPXyjem06VkacoYfl9Z4RMDdpeW4oMjexvlcVJ1lhGepjmRMIKtWNr0nefQJaGBLqKyvZYZtjbqw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1pJbnczYitEZU1FSTRqTzgreXpmeUNqdWZrY08vVEVKZVpwczN6VDFLR1dx?=
 =?utf-8?B?cU1vaDIvQS90MWZBMlZ3cWdoTEpKWnMwTjlIRkZPMEFqL2NHMTF2MjNaSnhS?=
 =?utf-8?B?OGNuSENUNlZDcElWRVZvbjY1NWZRVHlmTVVXVElHSUNaSlVpMFZLa0NZQ0dh?=
 =?utf-8?B?dHMybWRTdTRWaTZyTW5nbmJPTFdYbzNwNFpJWTNSVWt2MjlhdVUzUHh5OEtk?=
 =?utf-8?B?bUZOb2wwNjNDeUpKYnNxSnVVaUpMLzkyUzZlYXp4NGdYV3lrT0M2ZWtoNTJK?=
 =?utf-8?B?Wjh6Nk5VWFJmY2hUSDVUQWRYN2ZYbUlJT1BTWlI3ak1CMkVvVjFUMGNBUDQr?=
 =?utf-8?B?WUhKTlpjNWNaVTUzQklCQjQrVjVkYzhUZUdvY01SQXhPdzBzOVcvdEtlUGo0?=
 =?utf-8?B?R2FKYmR1djBOd1M4RE92ZHNCbnpxa3dlK2I0UHRhbnovcGpZMFo3RDd3anU2?=
 =?utf-8?B?VWJIb1FPcGxRcmdPVFlXV05jYjRuOHJQM3htdWducS9ZelB6bEpVZndHcy9V?=
 =?utf-8?B?ME9BenhUOXNKOVFwRDJZbGRwVURUZ1dEUno5S1ZKWDFZWGhjVC9LOEsxR0sx?=
 =?utf-8?B?UjQvb2Z3aTZTVnpiOTluZ2dnek5oVll5UUg1QXgrMUpzZjFGSjBWV2lmWmM2?=
 =?utf-8?B?WTVNRmFLbDZhYUZ6WjNxWm84ZmNrQ3dhWW1JNWpVaWYyZ0s1M3RacjhzNDZX?=
 =?utf-8?B?cFNVaTM4NWdQTGcxTTFteVVWeVIrdnVMcVdERFE5YVVrS0RrTE9RclBvbTZq?=
 =?utf-8?B?OTcyYUM2MXp6S3MveThEQjZuRFd0TFo2ZE9mZ3MxMitnNExjb1phWnFTblZi?=
 =?utf-8?B?aHBYd25jT1FIZHFoeTRYRTRxZUNPL0JoL2d1UWZiSW9kV3ZHRjBPVm5lL1Jw?=
 =?utf-8?B?M1dHWFJqbzVOem5yczdzTVVwSWExWW94NUhXYmI1OVdNdWFUS3QvMHI4d2R6?=
 =?utf-8?B?U2lPOUhvRHVMMjA3S2tJU3RzQWs3SEYxcXRLSHdnZUxSSHprL3FyL1V0ZG9z?=
 =?utf-8?B?blptQlVDL212djZOYVNwNFZzWGN0YWFpMUFCR0VYUmFhR0VjcXdhZHU0bGNK?=
 =?utf-8?B?SzYxUDVCazdJTU1vMEpPdU9sb2lBajB2d2dwRVNiRkg3L0ZUUGV1KzRTTXRw?=
 =?utf-8?B?bEZNUzZzcXVUOUg5SkRsZ0YvYjE2a3Z5ai8rLzZ5eW54VnQ2Q2Y5akJqdERj?=
 =?utf-8?B?Qi9GYjFFSWRBUFZkTkxOWUp6dUVkS0cyY2lzQlFqS1d5L002NDZwZGtxQTVE?=
 =?utf-8?B?QUViZ0FYVEp0MkZ3R1ZPY1RQL2dnemZSaXpXaFZRTyt0ZXVRT2VMOFdMdHEr?=
 =?utf-8?B?MStaaVN2bVF6T3I4SWJzZ2R5YXZTdnlQTGlCeGtJQTBJanB0cDVSWEcrdDFT?=
 =?utf-8?B?NjBGVFJzdEVLSnp5MDQ4cEsxZHNjWUFKZDkrYVZsREV1OTk4cGx6Qm51cmVO?=
 =?utf-8?B?QWR1dUlNNFU2cXBDOE1KTFdNdlJ1VW5XZWNuaG9zUTAxVG8zTFF4ZzFZVVcz?=
 =?utf-8?B?OW96Z3N5TVFYNmFYRjBMeFhXNW9WSW5rOE1WcXNUdmw4cHFLa3g3ekVPbG1k?=
 =?utf-8?B?c2NvaUJQYnNwZ042cHd4NVBLaGg0dGtVdmtIZ0FiRUNuVFFoM05kc1pHZDdw?=
 =?utf-8?B?amNpc3ROcWU1Y0E5VjFQWWZ2OTRWWVdOMHN0UXF2emNxNnYvMTJENXF1WDZU?=
 =?utf-8?B?amZ5MVA0WTRiVFVpSmc1Z2lmN0ZhYnhRaWh1cnNRa3JES3V0Q1dMOVNJcGdq?=
 =?utf-8?B?VFNHVlBNeU96TUtnaEd6NlEzVUdnNlBsSmczbVRrWGpKYlczcWtHdTdrMis2?=
 =?utf-8?B?SFNTVUhVS09OMk5ldTZvbStQQnBDT1ByVUZtQkIzaDVjZDg3OC9QVHQvajNJ?=
 =?utf-8?B?ZEozQUpHbndNN0xRL0Q4WVdIKzh2TTZSMkRvU2tVUkdVU0hZR21GelRLQWYx?=
 =?utf-8?B?Q2lIdG1Ed3drNWQxN1ozK1FKRHUzMCtWQUpJK053STZKSDJrL25YMjBNQVZF?=
 =?utf-8?B?Y25SN1JjT2lrQytENHpTVkx0ZHk0WnJ0Tms2eVZhTTRxYlRIZkV3dXVxeVBV?=
 =?utf-8?B?V25qdkZXZjErNHMwc3UwZXpBdlFyQXVlNVZwbXB3cnQ2RHBkSDl1UktlMXAz?=
 =?utf-8?B?MnRtZzUwcDIzSVMvQmFJVGpyRitvb2Y5MzIrbTFvdWVBRzhWbWdDdkZmMk84?=
 =?utf-8?B?a1pzZXZxOWRHQUUzWFFYenZGMDBDeEVQcVhrcWYrTUxUclpNR3p6SXVtd2ln?=
 =?utf-8?B?S2lqcVNWSUxkdE5QMmt3bGo4V0JER244VCtVR3FuWStRRXdraDhZdjQ4VW9Y?=
 =?utf-8?B?cFQ1dmxRZTZmbmxodlpoRzNZelNwQXRzVEJmckFBSklPYmhoNkE1dz09?=
X-Exchange-RoutingPolicyChecked:
	UV31pVbe4Gw+vIz68OBIMU2lxON/CdLlJFZrkFWKP9rW5SK6MxTuFG39+0OT9+uWqO4oXUHNjer1hC8IdDHDaJKRYvVcM0Wa2fS1/o9wSZ/MCrQ8CXz7Q6BopTpoaFJtQFZxMPITR6ORf918iC37Ej7ZnFqC8VS5Z9xPkCK3GIidtqi7LbtQ9OE4LGcGeXqi2lf//B0yNtnrwe+I+VEmHnpy4tyH3UVS6kj5W3434QldpDaJjcKDwvklHCrx898212yr2GRg6IoSXGS+9/u/323Ookig9rHGlNw1ZVuKfsGuk/hD58qEhbUvFufU5xb58HqKMIlbDUPdG6shyDZxSA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2qRiI6guYnRsdEU4FCMiS1Vo/XAtot8NW7pMhD2KCF5G+P44dPhUQ7RwbU1/n0Zr6uULNXrHBr5YC4HAir66RYMlht5YM2nzPXrzlLylv7gNUU4KuwRVx3qha/BDyv5IyQKsxQemi7AhtNeOELgV8ZjSJCqJAVuhwkWUQJraY2X3D/E9WnOWO0UWIq/V/ojwKKJmiixLHtk7SuReQv9dFNF5YLN7U4RjtfoDdHdYKpWqYB/fa2wlwt+DUhywLs38UAfvDmt4qhcuDjdQB86rmZDjamNF/Pru2OdT2j+eEFYwSh0kZntqIbyxVFYYw+3r/awEGXqT1G78eG6ZWVz+FqQmjJO8wePHfxhdVTXhkkibMtDM/ncXQc8wSUrHd6IdfyOagQl2z180IxwZe4pTXp0bdvhKGXJ7sOkDV7e6cxZ/MF+UpOmT42j6uw4h49R8ZudMGkXnfEo278YQWV5Tx56elg/6MCSnL4L6HVWl0r+9aNQW6+KnleYld0je9bXrI1R88ONAiCOgRUdvGCY6QfwvgmIZArvIiPgK0rbyaFmugu6xuhM8BSe76ugPuAWWja/FWS5dqFmdpxBJN3d2fEWD1V/tLBuZ04V6pk0kq1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76cda3e-b642-471a-dc79-08df21e3bad5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 06:50:08.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzWrVm3TTpa01lbcABJXpZwocDAW54H2kxc4bWhAPv5wt3IQPJlS//wkW7vRkv9BXYFeGTaWbeFHDo/xKF7Wuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610040027
X-Authority-Analysis: v=2.4 cv=afj0Dhot c=1 sm=1 tr=0 ts=6ac1f72e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=A68iVgu3ph3kzwdLPyYA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDAyNiBTYWx0ZWRfX0q9euKhIxssm
 qO6Pqy+JMy5/o9Yez4NDLwGGkdpm5+yRcuD54N8OYo+6INOaCF/TLcYm0iEtGSH+ZAWZF1sLop4
 ETfITK3rhHeQeHgERLSHfiUykBvars61EcQ7mmj04TTA9BQewDCvbTxfxjA+jitoas/uIQfep/F
 OfcWtsBzTta9Gv1k8EGPlJ3P0610+8Yx6t7lAY2+Gu1lx2eVYg1QPZNUjA0o3AxwncnTP0VnJ1i
 /+za43n1yOdCzqEHIp7rysapk/Mt19zmxnOgeCh5AA1rTzwxwLpgraAqfuockWF4XWwn4A7APhl
 gq1V5vaQZRpAc3VQSfeSdMiM+gpisK7TgnY8BZMH9ASbbhsHogX3hJDLSzBMYSjUvOPysBl2qJR
 5o4Wfu/GrLStKUBGm//11aIfa0FJin3Ao4AIArgnwyoUq+pzetCy7iQLzyND/IdbMFCIrRdD9Yg
 a3nfVOXeiSrfciAORvJamCFpw3Q7e1w5tuDTqSq0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDAyNiBTYWx0ZWRfXwguV/7QaxpBv
 D5SkU7IF82oFmMru9TveXqJ6y7eQisQfmHM5WWssbX7bGVb9f6J5FUNX2FTcZWqlJqvEEWjhjkK
 HKB/96HxVsE739IH2/XBtdob85AfYHiwof9Kqp2pxJAsKHbPaXDB
X-Proofpoint-GUID: ZWZ3Yxn66zSYmgZH9zX0_-KbmbPqIAcH
X-Proofpoint-ORIG-GUID: ZWZ3Yxn66zSYmgZH9zX0_-KbmbPqIAcH

On 03/10/2026 11:13, Alan Maguire wrote:
> On 03/10/2026 09:43, Yonghong Song wrote:
>> Since commit e96290426e18 ("dwarf_loader: Analyze per-parameter
>> information for true signatures"), clang-built kernels on arm, powerpc
>> and riscv lose most of their functions from BTF, and resolve_btfids
>> emits thousands of warnings like:
>>
>>   WARN: resolve_btfids: no BTF func for kfunc bpf_xdp_get_xfrm_state in xfrm_state_kfunc_set
>>   WARN: resolve_btfids: unresolved symbol bpf_xdp_get_xfrm_state
>>
>> For clang functions whose signature did not change, the new
>> function__match_clang_parameter_locations() checks that each parameter
>> lives in its expected ABI argument register. arch__nr_register_params()
>> returns a non-zero count for powerpc, riscv, mips, arc and sparc, but
>> arch__set_register_params() only fills in the register map for s390,
>> x86_64, arm and arm64, leaving the other entries at -1. Every parameter
>> held in a register then fails the match, the function is marked
>> unexpected_reg and is skipped. The previous per-parameter check in
>> parameter__new() ignored unknown expected registers, so this is a
>> regression. 32-bit arm has a register map, but it does not match
>> AAPCS32 (only r0-r3 carry arguments, and 64-bit arguments need an
>> even/odd register pair).
>>
>> The parameter location matching and true signature reconstruction have
>> only been validated on x86_64 and arm64. Add cu->param_loc_supported and
>> set it only for those two architectures. On other architectures, skip
>> the clang register matching and do not do true signature analysis in
>> the DWARF loader or the BTF encoder, keeping the basic optimized-out
>> parameter detection that existed before.
>>
>> With a riscv64 or powerpc64le object built by clang 22, functions such
>> as int f(int a, int b) are now encoded again instead of being skipped
>> with "unexpected register usage for parameter". x86_64 and arm64 output
>> is unchanged, with and without true_signature.
>>
>> Fixes: e96290426e180703 ("dwarf_loader: Analyze per-parameter information for true signatures")
>> Reported-by: Nathan Chancellor <nathan@kernel.org>
>> Tested-by: Nathan Chancellor <nathan@kernel.org> # build
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> 
> Thanks; fix looks low-risk, high-value to me so I will apply shortly unless
> anyone objects..
>

applied, thanks.

