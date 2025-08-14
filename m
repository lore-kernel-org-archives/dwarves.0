Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E859D2E973B
	for <dwarves@vger.kernel.org>; Thu, 14 Aug 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163296; cv=fail; b=JVR+wiZ54lzFZ7fsBQHZdcKZ6u5khUK3Ul0Mlj0r0xXnVbeeQQXhGSZPbtx82xyMGlO27cJtQpxGEsPKcsqqxxK9htH46k0XHlLI+24aKNqVCS4tAYsF6DkOr59Q3AjsE/gzupCXp+jdNmuIcJ92bJ7YqkMJVvJJ/bHc+ZW85Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163296; c=relaxed/simple;
	bh=gmWW66h/4lY1Zn/avvWlzoItf/cw+4nFbXUv0EJIrpc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cHcD5yNcAHE6hjZHKnxsuQOZErR4BNUBjIye7wAGaNoqgxEvTs33MNlHYd56d3aqX6N6cUfs2VuOvLaXp3i71IqZe5nPbnjATxi9de5JtORfgFkA1GXI8Nwxe808fAvsCHtG5Iirtcv0yO+g0IH7n5I8vpybPn+wc1bcykQZJ4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57E7EV4F1633020;
	Thu, 14 Aug 2025 02:20:59 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48fvk22w71-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 02:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mndv1+2Z1PGje0UqK0ri+caV7XJdKTYWCAemYm1I4hfMwc6J6lrlpQe8H0riN3MhpudT0fogjcdHBLJrP6mdUfkAmast5w1c25RQK2l1d/nGbY9yCPs6HGDXr1QXwz1kqpkQp25QNGrPPfsXImZpS+M9GhFgk7AK7yNVlyh52AEDSCPCSpgyFdVmcNXmIBhyJOhhl8lN1a7vAHi3F7jfxFvFmz70FA8kjWodMzMxZAtIjdS1hyiuMi13zyue1RjbcDgO+O1NzzlMnTWol3WBD8VeyaHx+Y89xAIcwubblpkKwyl5jrZS+P8UUERxPyuuOCews2jl6rfwa3u/+ITYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kGZhkIwzFTWaXJYBBSkiFBiTmZ2kMkqTcuB43rswV0=;
 b=YfNwfrLDM4tLzn0HtowhPrGozMXOUjSJeBKxINB/FiqmFU9lLrHpBTcWsAECOBdbm11mK75lkRQXFADxbYthd8UyNQPrsHgTTNq/2tsvVA9S+9mpXWBnD/XOpCTuZRE671iX4a6lQa46QGiIdb4lvGg3y8c0bUfbe+rjufhwRa+bXpFzX77+yfA3cOjEIxq00gezzWWdd5LEu2cNUf8mnmAL9v2CZd28wWEbXa46k6Fl//+PTDjsP2SO+cF3EyPrjXkoSIKGFrOE5BLgjpDT1tmzRO8KmzZUKVME+N8NEpfosDioz8wwaMlrxUBVHntlXShufpdnnYbXAd6W4vItRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 09:20:57 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:20:56 +0000
Message-ID: <f1e2dc2b-a88b-4342-8e94-65481ae0cb4f@windriver.com>
Date: Thu, 14 Aug 2025 17:20:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: "Segmentation fault" of pahole
To: Ihor Solodrai <ihor.solodrai@linux.dev>, acme@kernel.org,
        dwarves@vger.kernel.org
References: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
 <37030a9d-28d8-4871-8acb-b26c59240710@linux.dev>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <37030a9d-28d8-4871-8acb-b26c59240710@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c06935-e8bb-4621-0fb8-08dddb13dfe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDBtVjlqeHZRNW1JcTF2OGdETG14Nkg0U2JrM3F0K2JlOTFHSDdRTEFVcHRm?=
 =?utf-8?B?d01BR0xONVljSnI2Rng0dVgzeUZHOGdmbHZPenJSYkIrd3FzL0p4L2x0cUtL?=
 =?utf-8?B?Rk9ycHptNlg0YklDdkRSZkg0ZXM5dzI2MW5lMHBNNGxGc1dOSFdreE5kYXpL?=
 =?utf-8?B?ZDZwam9YOWtmRFE5TktxSVI0ekNUNHZtMmQyYThueTZqemZmUi9saC9aNWsx?=
 =?utf-8?B?bzJUVTc4cmFQWTZ3ZTkySGxaQS9kd1NGZ0FPT1IwdEt4N2ZzZldFbmt1RzR5?=
 =?utf-8?B?TGM5YWZITjE3bUpxdGNJWVJoajVITHZrallZZ2xWVWJMK0ZpQXphUWJhbVRi?=
 =?utf-8?B?OERPN2ROOXJjc3UrSVJZbHF3eUpxK2duaXcxbVFxSzRiempCcnVDV25adzky?=
 =?utf-8?B?T2QzQXJSZW1lNy9jUTZDcmJmS2xDSXVPVlZWT0w2YXROYnpzWERTODdWNU5s?=
 =?utf-8?B?THhKUUdWTmZDV09ENnJrQllnS2k3UzRwYzdGV3pVRDBlR0JhYlc3bmV2VThl?=
 =?utf-8?B?VmlJK0pRSHlFLzMxQWh5UGZzWW05THJRbzkwZ1JPNjg2ZWNvY1ZYWE5MKzVV?=
 =?utf-8?B?UEJHNHRrelJvaEtlRHloTk9SSHFBQkpEa2hydkJiMlNLYjNyYXNaaU9PNGkw?=
 =?utf-8?B?bWFOVlhZa0h4TUt6WUxxQUIxbzBpbFlIQWx5dHYzbVhLd1d5RTg3dVRrV29v?=
 =?utf-8?B?Yy9MK25lWVQrdVVTY2ZMY1dtYnVzRGx2WFVmZ0t3OWZDZFhGcVlKa3RJN21a?=
 =?utf-8?B?OGlGb2EwdzRVVTBjV1l6ZitNUGtTN1NQOHJoQlczZXY4bDczTFdvaXZHOHhl?=
 =?utf-8?B?dWs1VUVXSnB5Zm1XaXlDZyt0VGhPVjhMdTQ2NDBnaFo0NnBtcngya0Zkei9K?=
 =?utf-8?B?UndLbXZHRzdSL1FyaVdZYlo5WVMrRy9XTC9DaTc0MmFOMVMydFNjUVFrbDFB?=
 =?utf-8?B?a0F6MXNrK3FRQk51NExESXc0cWhFbzQwa1FiZHk3ZVowK3YwMllzMmRKMGo4?=
 =?utf-8?B?c1VWUzF3ejVOeXVJNFZLTHQyYjhWbmNubnVDREVOOU9KY3VjbGpZczlIdDlk?=
 =?utf-8?B?YmtMb3JobUFuSGNoNHFUL1pzeElOZDB2RzhGTkU2Wm5mOUR2ODJnbWhBcC9I?=
 =?utf-8?B?SGcwRUJsQXcvQUpCaUg2Y2MxYjF4aXAzSTRISWVUWTU3RURQd1pjQ0JxVVMv?=
 =?utf-8?B?RHBpL1NNVkZXT1FSSEs5SytvRmV5cUEzNHVZMmQ3VHlJOGl0akYrc1U2L3cz?=
 =?utf-8?B?VDlWWkl1c29POGhSeDIyRGs1UHVlejN2V3pNQnFFa2s3VmdYa05PK3RjbVph?=
 =?utf-8?B?bkxzRkY1cm1MU3BxNlo2Z1JKbXFGL0UwZk9Gc3AxQjZ1SVlaeUZPTUJoaVJC?=
 =?utf-8?B?K3VicjA5MXRhVWRGTVhNOTM0b00rdEdxckdhTG5qMDU4alZQYnF0U01EK0Ju?=
 =?utf-8?B?d29FaDRaTUNERm50a0dTUGdydTFFVzRsNzBRb01KeGxIUlY5ZWN2N28yTU02?=
 =?utf-8?B?em1HSFE5eWJuRFNQYXBnWFBvbTBaNE8zdGhJWGFnRGtEVkNjUk05Qi8ySk1s?=
 =?utf-8?B?djJSNkxwUzZFeDBKd21zNmpqemVhcFhrdFZrK3NCRCsrM1BoNS9NWHJQNHk0?=
 =?utf-8?B?cllmclZzNTJjT2lzeWxHUkYzNC9FU0Z5c3UwcUMwVTdjL3BleXVJSUIyOTJ4?=
 =?utf-8?B?cjVrR25nRWV5ZUxRY1YxYWZWOXR2UXZtZkpDQ1VrZFh6RkZFakNOZkVtV3lR?=
 =?utf-8?B?U2lKZUM0ZnMwWC9NZWdKMWYrbThvNVFxV0lJTDJJZ3dETnA0cGxSRW5jOXB0?=
 =?utf-8?B?SU5Ud0wyTjIvWk5Ka0tSc1h3aEpUTUFGQkYxRklVS056bitrR1RnbVV3dDNB?=
 =?utf-8?B?VC80TGo3bGhBd29lWXVSM1VKaUdydlFhYlMwTjc5dXYxb3plOTEva2ZvZjhL?=
 =?utf-8?Q?OoYGOz5E4oM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0J0K3NkYk9VMTBFOUlqV2wzNFBmQURYNk5lVW8ydkhWNWdRSHFmclZWa1pl?=
 =?utf-8?B?S1RDbGtPclh0cjJUQVJsaUxHN3lmdDdQMWQrTVBRL29Wb0ltdmtWd3k1elgr?=
 =?utf-8?B?SE1zdTVpMGZJcGN3cEtzYVRIa0xRRzZtWFBKdkc2WUZKVHJ3RUMyWU9FUUxH?=
 =?utf-8?B?ZTVDbitqcGxhOTg2aFN4VWdiMElJRE1MZ1VnNzRvT3FCVWpyYmgrUDdRSlJX?=
 =?utf-8?B?bld0anNjalc1OUZ4blExTUd0QnJYdm11S0pIVzIzbjJuaFhVdlN0YnhrSGhJ?=
 =?utf-8?B?NjdDU29VK21ia25iTHNPMURFbnFtUVI0QSttbmNyQ1pJbXpWbURNL2wwWDgr?=
 =?utf-8?B?VWNFaHhrcVVJaDRKYWcwcnFlaDVDTk9PK0lrbC9vL3JQekhsbnlqRlFuN25a?=
 =?utf-8?B?VzhHSU9lM081T1JtQXVLRVFKTFVrNnFtMDRzRVAwWXdaUHNrbG1YT2Rra2hC?=
 =?utf-8?B?eDFNdVZzZS9XWHlHQ3IyeU5VMmhpelovU2kzZ2ZGdEpLUWFYaUsyeGtQa3NY?=
 =?utf-8?B?VW41ZkhkMFVma2RxUUhRYnZzZUREZHd5Nnllbzdpck5SOHRFdVhDeFlyTDJ1?=
 =?utf-8?B?QmZZaUMrcDBocnNXandaUDBta3JBdUx1ekRpd2ZLNld0RmJUZEJsVjZwLzB1?=
 =?utf-8?B?OTEzWDRIMWVTcVVVbVBTcyszNmo1YnV4SWc1NXZGSUpIaE1ibnVsRWd0Mk0w?=
 =?utf-8?B?N1RyN1htUjRibEk5MVpNME1WYWk0UXA0VEppbkJkdXNFN1hYenZ1eW9DYmp3?=
 =?utf-8?B?T3hvRHRTRTFweWYyTW9Ec3NCTS9NZ3RpODVRQ2RPQ2FqSGZwNDVEZ1lsVVUx?=
 =?utf-8?B?OWJIWXRTUWc5VlBuYjFaOUJWby9VS3U3bm10d0ZlcWNURUZYVEswVWNxWFpt?=
 =?utf-8?B?M3NndU8xVkZBcUpGaVBwR1ZhVUhzdFpTcDB0TmdlNGtXem9ZbWlZc2J2UDFY?=
 =?utf-8?B?SzZZSW1jMXhRNFZ3b3pabmRWOXU0QUh2dW9sczVka250aHkxMlVVejk2Q1JH?=
 =?utf-8?B?TkVISUtyRVhpdlhOMGhrMkN5amZSNzF1WGVOYXlOUFl3K09wSkRBbFk1TjFw?=
 =?utf-8?B?ME5TQ0JldVJ4SHBpak1iMkEvNjdFSy9XNmFoT3hoaXJMLzFUWVRTelA5YzZo?=
 =?utf-8?B?MXJ2ajBaUDQ1L2Z6TVdBaFBTd0VkUmRQSUZETjlRMFZyTWVUVjdRalZrSE4v?=
 =?utf-8?B?MmVKeldZRkRUbTllR0ZhdWpoYkljQ1BaU3huL29Cck4vUGJ0K2RQbEFQaU1w?=
 =?utf-8?B?cHBYZVdMQkgwalJQS3FFeGVDSEdIdS9yR3lzcnVVdDYxQ3lYclM4OFp6MCtD?=
 =?utf-8?B?Z29FNlhGMXliL0ZWblBRbWlRZDR6cFhBR25wclJUNm9uT2RLTU5FS2cyT3hN?=
 =?utf-8?B?bUJ1UDZ1WCtSRmtBVzdoRU9LaFNOM2pxSi80Yld1WVFCQlprOXZncGhTMldJ?=
 =?utf-8?B?WU44c3piMmgwZzd3ZVJjakYvZmRwOWVCUkhlZ1hablhkektBOWMrYisySnc3?=
 =?utf-8?B?bTdzUlFTaVJTWGt2L0xoTldTQmMvYllVOFdoOHJFR0d0TW5uZTYrbS9oYzQx?=
 =?utf-8?B?ZE9TTHB4YVRXb1IzUFlQQjBlb05RUWg0ak0zSXhrdXdVNWxabEZ1bDlhTXNy?=
 =?utf-8?B?MHVPUWR1S05WQ3ltMHUyUkhvN0twSTVnMkxLalZCUkdybVg0SVBEeERZNVJR?=
 =?utf-8?B?OUtFb3QrYTNybmFOWk1HQzJEMXM5Mi80aXgxRmlxTEF2VG9NWlZzUXRmbmJB?=
 =?utf-8?B?OGNqRmlqSDk5UllUNHU1alFtb1lveXB2SVJoNTF4S1I2R05Pa05GQWxTSWJK?=
 =?utf-8?B?S3VsOWtLSWhCRzM3SXJETVRpY0lRNTVHWFN4UVJySFNUR0x3SEJBZVBNOHpF?=
 =?utf-8?B?cGg1WjVxdTJTMnBkODNFNm02Zkovc0FZeFg0Z3ErcW5HTmdDSGZMOUtzcTg4?=
 =?utf-8?B?SlpwVVlqZWx2U3QxMHlxUXA2d0tURE5RNzA1cTVxbnZGdytKOUt1eEJYVzNa?=
 =?utf-8?B?M0xtcVVRaDZHbDU3cnM4WWNZckdHWjZLQmZaeCttb0Y3SzdreDlJcmdHdlBq?=
 =?utf-8?B?UzZnNXkrNGpmTVBqOHc4NzFlMlVUYUlBL0Y5U256RmI3N05oU3JBUFFtNVhG?=
 =?utf-8?B?d0thcWlraGpvSjZ0NEhOVGtOMmpiUFlvU3loZXdEdU9JckJST0hseFowanN6?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c06935-e8bb-4621-0fb8-08dddb13dfe1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:20:56.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTfdEmdPAmM2m1H0YlMQijEGE8qlJSt3tQFrGgYStKpSqcryerfyYLFCjEKEZBzWnZnPlEn/GnU3fl/XVuH/r0NDOQ4sXBt+KFrQfoCAxYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA3NiBTYWx0ZWRfXxB3t1PW5B/Lc
 ci+jINmXDfsAvwCo94Ny7yUfKbjCQgRfciNPZOOp48r/3iK+sljhCNkPpmJdI9JiGjdGO8haP0S
 5+JjFRDnJyKW+wijS3nHTJ9jDPDwIIt6WrI4Cv8j7culIwyhS8CRr2LPu96bOPvswSVu/zl/5NN
 NY90ocuXnOZDWHadcg9UmTNoTzWg4manKoESgPXODfVZcnrHNCPvoytMoXCXzU0mby5YB7LS7DO
 tjUUV5LpGtRfnE0kGACtXZsMuBg1XGhVGBlqv2SfIK+1648Oqb9Ep71soRQboYBIrNttJi1exDd
 3kFH7aEFpFHD32Wr64DgfOqF4dI4saEYpjtKZJ3BxKjDHgHj24F6maj2vr6S9g=
X-Proofpoint-ORIG-GUID: XGVw61FTasv5_yrpmsuHT3MVRdPv3Qic
X-Proofpoint-GUID: XGVw61FTasv5_yrpmsuHT3MVRdPv3Qic
X-Authority-Analysis: v=2.4 cv=PsOTbxM3 c=1 sm=1 tr=0 ts=689daa7b cx=c_pps
 a=+1Pulch26Pu9WVt5L8GVww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=Km67iZTKlGtGngiB7sgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun


On 8/14/25 07:45, Ihor Solodrai wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
> On 8/10/25 6:18 PM, Changqing Li wrote:
>> Hi,  Dear maintainers
>>
>> I met a "Segmentation fault" error of pahole.   It happened when I
>> passed an ELF file without .symtab section.
>> Maybe I passed an  unsupport file, but I think it should not segfault,
>> maybe  a warnning or error message is better.
>>
>>
>> Here is the detailed info:
>> Pahole version:
>> # pahole --version
>> v1.29
>>
>> Reproduce Command:
>> root@intel-x86-64:/~# pahole --btf_features=default -J /boot/
>> vmlinux-6.12.40-yocto-standard
>> pahole[599]: segfault at 8 ip 00007f7c92d819e2 sp 00007f7c799febe0 error
>> 6 in libdwarves.so.1.0.0[189e2,7f7c92d72000+1c000] likely on CPU 0 (core
>> 0, socket 0)
>> Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24 18
>> e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42
>> 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
>> Segmentation fault (core dumped)
>>
>> root@intel-x86-64:~# file /boot/vmlinux-6.12.40-yocto-standard
>> /boot/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable, x86-64,
>> version 1 (SYSV), statically linked,
>> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, stripped
>>
>> root@intel-x86-64:/usr/bin# readelf -S /boot/vmlinux-6.12.40-yocto-
>> standard | grep .symtab
>>    [ 4] __ksymtab         PROGBITS         ffffffff82c11e00 01e11e00
>>    [ 5] __ksymtab_gpl     PROGBITS         ffffffff82c24730 01e24730
>>    [ 6] __ksymtab_strings PROGBITS         ffffffff82c397f0 01e397f0
>>
>>
>> (gdb) bt
>> #0  elf_functions__new (elf=<optimized out>) at /usr/src/debug/
>> pahole/1.29/btf_encoder.c:196
>> #1  0x00007ffff7f92a7d in btf_encoder__elf_functions
>> (encoder=encoder@entry=0x7fffd8008dc0) at /usr/src/debug/pahole/1.29/
>> btf_encoder.c:1374
>> #2  0x00007ffff7f94489 in btf_encoder__new (cu=cu@entry=0x7fffd8001e50,
>> detached_filename=<optimized out>, warning: could not convert 'btf' from
>> the host encoding (ANSI_X3.4-1968) to UTF-32.
>> This normally should not happen, please file a bug report.
>> base_btf=0x0,
>>      verbose=<optimized out>, conf_load=conf_load@entry=0x555555565280
>> <conf_load>) at /usr/src/debug/pahole/1.29/btf_encoder.c:2431
>> #3  0x000055555555db49 in pahole_stealer__btf_encode (cu=0x7fffd8001e50,
>> conf_load=0x555555565280 <conf_load>)
>>      at /usr/src/debug/pahole/1.29/pahole.c:3126
>> #4  pahole_stealer (cu=0x7fffd8001e50, conf_load=0x555555565280
>> <conf_load>) at /usr/src/debug/pahole/1.29/pahole.c:3187
>> #5  0x00007ffff7f9d023 in cus__steal_now (cus=<optimized out>,
>> cu=<optimized out>, conf=<optimized out>)
>>      at /usr/src/debug/pahole/1.29/dwarf_loader.c:3266
>> #6  dwarf_loader__worker_thread (arg=0x7fffffffe700) at /usr/src/debug/
>> pahole/1.29/dwarf_loader.c:3672
>> #7  0x00007ffff7dbe722 in start_thread (arg=<optimized out>) at
>> pthread_create.c:448
>> #8  0x00007ffff7e314fc in __GI___clone3 () at ../sysdeps/unix/sysv/
>> linux/x86_64/clone3.S:78
>> (gdb)
>>
>>
>> Command  "pahole --btf_features=default -J /boot/.debug/vmlinux-6.12.40-
>> yocto-standard " works well since /boot/.debug/vmlinux-6.12.40-yocto-
>> standard has  .symtab section.
>> root@intel-x86-64:/usr/bin# file /boot/.debug/vmlinux-6.12.40-yocto-
>> standard
>> /boot/.debug/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable,
>> x86-64, version 1 (SYSV), statically linked,
>> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, with debug_info,
>> not stripped
>>
>> root@intel-x86-64:/usr/bin# readelf -S /boot/.debug/vmlinux-6.12.40-
>> yocto-standard | grep .symtab
>>    [ 4] __ksymtab         NOBITS           ffffffff82c11e00 00001000
>>    [ 5] __ksymtab_gpl     NOBITS           ffffffff82c24730 00001000
>>    [ 6] __ksymtab_strings NOBITS           ffffffff82c397f0 00001000
>>    [49] .symtab           SYMTAB           0000000000000000 154cf200
>>
>
> Hi Changqing Li, thanks for the bug report.
>
> I couldn't reproduce this error with a stripped vmlinux:
>
> $ objcopy --strip-all ~/kernels/bpf-next/.tmp_vmlinux1 vmlinux-strip-all
>
> v1.29 fails with:
> $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
> Error creating BTF encoder.
>
> v1.30 fails with:
> $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
> pahole: /home/isolodrai/pahole/vmlinux-strip-all: Invalid argument
>
> Different errors are not nice, but at least no segfault.
>
> Could you please share the vmlinux binary that causes the error?
> And also check if you get a segfault on v1.30 too?
>
> Thanks.
>
Hi, Ihor
Thanks for checking this. Here is my retest result:
On version 1.29:
root@intel-x86-64:~# pahole --btf_features=default -J 
/boot/vmlinux-6.12.40-yocto-standard
pahole[333]: segfault at 8 ip 00007fd5025179e2 sp 00007fd4e73febe0 error 
6 in libdwarves.so.1.0.0[189e2,7fd502508000+1c000] likely on CPU 0 (core 
0, socket 0)
Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24 18 
e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42 
08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
Segmentation fault (core dumped)
root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
root@intel-x86-64:~# pahole --btf_features=default -J 
/root/vmlinux-6.12.40-yocto-standard
Error creating BTF encoder.

We can see that the same vmlinux-6.12.40-yocto-standard have different 
result. After do some debugging,  I found that
/boot/vmlinux-6.12.40-yocto-standard segfault since it has debuginfo 
file /boot/.debug/vmlinux-6.12.40-yocto-standard.
after I move .debug to .xxx, it will not segfault.
root@intel-x86-64:/boot# mv .debug/ .xxx
root@intel-x86-64:/boot# pahole --btf_features=default -J 
/boot/vmlinux-6.12.40-yocto-standard
Error creating BTF encoder.

dwfl_module_getdwarf in cus__process_dwflmod return different when with 
or without debug,  without .debug, dw=NULL,
with .debug, dw will have a value, then causes the different process.

On version 1.30
root@intel-x86-64:~# pahole --version
v1.30
root@intel-x86-64:~# pahole --btf_features=default -J 
/boot/vmlinux-6.12.40-yocto-standard
pahole[314]: segfault at 8 ip 00007f2b0b6b2bf3 sp 00007f2af05feb20 error 
6 in libdwarves.so.1.0.0[18bf3,7f2b0b6a3000+1c000] likely on CPU 0 (core 
0, socket 0)
Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24 18 
e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42 
08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff
Segmentation fault (core dumped)
root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
root@intel-x86-64:~#  pahole --btf_features=default -J 
/root/vmlinux-6.12.40-yocto-standard
pahole: /root/vmlinux-6.12.40-yocto-standard: Invalid argument
root@intel-x86-64:~# cd /root
root@intel-x86-64:~# mkdir .debug
root@intel-x86-64:~# cp /boot/.debug/vmlinux-6.12.40-yocto-standard .debug/
root@intel-x86-64:~# pahole --btf_features=default -J 
/root/vmlinux-6.12.40-yocto-standard
pahole[441]: segfault at 8 ip 00007f64a9032bf3 sp 00007f648dffeb20 error 
6 in libdwarves.so.1.0.0[18bf3,7f64a9023000+1c000] likely on CPU 0 (core 
0, socket 0)
Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24 18 
e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42 
08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff

Segmentation fault (core dumped)


I can share my /boot/vmlinux-6.12.40-yocto-standard  and 
/boot/.debug/vmlinux-6.12.40-yocto-standard, but it will be big 
attachment, I am not sure

if it is ok to send big attachment in the mailist.

Can you check with my new test result?   if  still need  the 
vmlinux-6.12.40-yocto-standard, I can try send to this maillist.


Regards

Changqing

>>
>> Analyzation:
>> if the ELF file doesn't have .symtab section, in function |
>> elf_functions__new, |funcs->symtab will be NULL, goto out_delete, then
>> run elf_functions__delete.
>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/
>> btf_encoder.c?id=06350d14776a77e16ea5064030fea63bbdd22f27#n176
>>
>> And segfault happened in line: list_del(&funcs->node), since funcs-
>>  >node  not added into the list elf_functions_list yet.
>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/
>> btf_encoder.c?id=06350d14776a77e16ea5064030fea63bbdd22f27#n170
>>
>> Should we check if the node is added into list elf_functions_list before
>> list_del?  Please help to review this issue, thanks.
>>
>> Regards
>> Changqing
>>
>>
>>
>>
>
