Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E2126C04
	for <dwarves@vger.kernel.org>; Fri,  4 Oct 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033373; cv=fail; b=P0LukGGeOOE2e4cec0HGowzOGspaqWI+8NbT5m8n8Gme3ODzndOg5bp4poBF5imo4SITqpVw4kE81W7gAMPdIWrkzVtYzhD8LYjzVAXfRtkowGokzDsyZEbBPMqAiyiiJWezIAxXH/+F2D4B6gc48AU2QasH9TcDrAFo03yI/BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033373; c=relaxed/simple;
	bh=3rmgrs3R8VC+zVFQHuknCgP4iqmDVG+93ysU+JkBuh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JccVwSjf29YQYYGxUJN8KCfTBpzrlL/KCr8mZ3XVGghjf11tQ7UrFnLMur39x5UfDZD5dVVoFZx/0hcXbWfx1FK6G2VA87W2GSrl+gS7wuoB66L5PJCC+VJSd9tJa64gPrn3q/4NsEse5UaQqX2ywPf/XpEKAtjez9dfqcnf2Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e5IjQ1aX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G85yuq0p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e5IjQ1aX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G85yuq0p"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tb3H009226;
	Fri, 4 Oct 2024 09:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=RucuB4n0WllvpIF4TgTpNCaVoO3MhxBtiJRV0g0NHPw=; b=
	e5IjQ1aX59WzYu5ufTFkEz/fwrvm0VQX417nezjlKqTpzSE85JaOlAqbo+2dnlxn
	lL+R7YVkJPE4YasjgyYqCGqA5Kee9u1u+kUn0W2QBpdohWheF8vpV2e9n5pR7DoG
	3jj1zuT1WJvV/ignJ6/HeTGQlt/gvmLuPqWu+DohcC/GZMzqlC1wIYhkTa+3KBtV
	MXW8+lfXRYkgQ0Lqjj3zMws92Ip0JQRvaRF3YB7kEVz9OGhvt7GHE3G8aaHun6Tq
	ZAq1V/Sepz5yRldAZ0eN5TP/1B2/pjaliN+yzEhRC3FwVVxxORiJl3pCTPVWCGG9
	XBM1TlEGbIiAZbHYgRswRg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204897xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:16:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4949BJDa026295;
	Fri, 4 Oct 2024 09:16:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422055h65q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN2krElaMtyw7MNi4IaJ02GyJWSYWV9GP9ApK3OMlaXMM95d0XyPMyQwXMwbSJaNmBJ/1jlTnnolB+Kb5qBXwlZXy47rHRTJi0lT+Kj4SLm/pg29IesRPhFlMFApadEMxXO20KDT1RTJotcabJCfF+k/NPP13BV6madiGrBz6v0fzo6xD9hC8mg12NVDhbJZjKZxP43fskkh6u0dqlfI6aTJ2Agiy4iqHoViFWibCVfMkczVrcW/pllqz3xLr+g88FGak7ps1Jd8EHdoEQhfDL/iDl8EkjA4b+UGqJuQ6gATLHHb/HN8s2xhtCrqTKZ9Ayfby/UgnMVzBTK3wiYyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RucuB4n0WllvpIF4TgTpNCaVoO3MhxBtiJRV0g0NHPw=;
 b=fG2ctHCHnGBcGakOJmnxwB1LEc3oHw87CjQPO18aaUDFlsApAVwYcO/OZV/3WPU2ThUV/j1OapRd/Ynh6wYuPYGUCTOnuntvvIZIkTGskOK673RpWXefj73fa5F4N5ChL8+c8OxE1VF7gqH6Z2msAMWONMbuyDI5+4usRsVGpSKXx5g0UWwht/HhmW8JkWl4/8cy3bGFSa5dpCQKBaZ1zd+FI5Ok+5H+nISdnWf9k+wsUprjYexxq+NpPWq5zmErEQKnG1TxS1JeAZ/nsux+5OcARZSfcaeid867XLkbx56HPU7yUpTQJAU12bEIRhdUFDXH7F8fZdzZ5SH2YBGDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RucuB4n0WllvpIF4TgTpNCaVoO3MhxBtiJRV0g0NHPw=;
 b=G85yuq0pt22IWoEaxb2zyFwH79g6Bcr3AelR3C0zUuoMGF0sd0dfEYpGRkE57FZjvi6nZhmPGBh76v0Qi6VqiHyzondbn1D5fJggeNDaksK+y61o4njoKdhbL0/ParULUWWYSLILZ0YjYvKg+AiaJCrEWznx9uOkfS2aes43fpM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:16:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 09:16:01 +0000
Message-ID: <4d50db76-dd41-4855-977e-1e2a722b73b2@oracle.com>
Date: Fri, 4 Oct 2024 10:15:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 0/6] btf_encoder: implement shared elf_functions
 table
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, andrii@kernel.org, eddyz87@gmail.com
References: <20241004051347.41143-1-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241004051347.41143-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0098.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ee6860-8eca-4f71-d9e8-08dce4552a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejQ1cUE2bFdraDdLWmVPbWxvd0VjM24yVTh4ZFFVOHN4cHlxU29HR05FL1ZI?=
 =?utf-8?B?OWZKQzBzWjZraFY2ektFRHVlSk9aYWpTNDlUL2ozS2oyZ2VyYjdWQWVBVHBB?=
 =?utf-8?B?QmZLM0tQbksvYmk3Z0tNNnNqVDB5NGVIUjNDak4vM3dXKzlPUTlFZzkzbDVI?=
 =?utf-8?B?VEMwejdXMTBoMW9zNzR4VXN2VVRxemVrM2NLZ0tsUTFCdGxiKzVVcmpnM1Bq?=
 =?utf-8?B?WnYrS0VlZ3dFSE00cGdtUUZoSjcrTE0rSSs2ZjMwVWFuV0hrajFnRkFPVjlI?=
 =?utf-8?B?a09FaWJjcmYwaTBHbjdtemJMS0IrVmliYXE1MnhtVHRGaDF2Z1hmZVE4VXJj?=
 =?utf-8?B?NlF5enhyZ1hna2wzK2dnZnhFOGRaVXBFa0c0bUVhZWhLKyttTDlTcTFjK25S?=
 =?utf-8?B?ZDVVMXlGZFlzblNmMUdQOTVVSGR3cnN4OUNCMUVUdmZqRmh3akFVOVMyUGc0?=
 =?utf-8?B?YWl1R1VIejdjdk9ib3UyR2VXTlNZaG9wcXdad3lldHA0MHRtK0E3Yzg4UmpY?=
 =?utf-8?B?UmRDdFk3YVZ3TkhUNTdGYXIzMUhoMmMzSE1KeHIyYmpoQ3R2NUl6a2w4SDJ1?=
 =?utf-8?B?OHIyYk9HeTNUbmZJR2hveHh3cUIwOVZXR3U1cDFBYnV2NVZtUjBQa200eDBS?=
 =?utf-8?B?VE14QTlPMWNZem5NenMvM3hVcmQ3ODdNblUyTndLL0RWVis4UFg3VzI1aEJ5?=
 =?utf-8?B?dEpsbHpFQ0xhSUhHMmNiWjhlaUxhZng4UmhyVVNTY3hFdkxZb0dQdEhpUmhl?=
 =?utf-8?B?QmdkV0xha3BpT1JCcmpTNGdOT0FYdysvMEpaNDNuN3REVHlZUXFxRks4TEhh?=
 =?utf-8?B?c0lRb1prRTJHYUozRUxoWlpzVk5ETHE5ZTJnVi9TbzNtdk5SYUpEaHRFbklv?=
 =?utf-8?B?c1BsaHZMcUIydmVyMHJwN3RMTEhrWjBIYTE4RlorRm01Uk8vWWV2bUcwVjFa?=
 =?utf-8?B?Y3JkN1gvNHBUUXJqREF6UWtXZzdZaFlMOEc4NlpwUUhJSEZ6eEphUm5mU2oz?=
 =?utf-8?B?QWpxbko1QTdKZHkwcjQ0VXU3alFyajQxSmpJS2gvMU9xMk4rVmFtWkp5c0U3?=
 =?utf-8?B?ZFVTdGlrdXJPTisxRm5ZVHN6NEJ1WDhiMFBDVEVFRWtadGIxK3gybHp6YzVP?=
 =?utf-8?B?cmEzdDlxeXBnUUtIVzNFWS9kNzlZakdvYjlOS3JvZTBlNHFPbE13Z2FlQUtN?=
 =?utf-8?B?ZE4xcm1JeVRjZjdHR0Q4bjMrd2taNDRRQlhyYmVoQkd4czArSlowWWg1SlZt?=
 =?utf-8?B?em91QlpnOW1ENWpKOU1vRWlFcU9IaSt5UjFoZFYxWiswb1FkdGx6SjgyUXdq?=
 =?utf-8?B?NXcvSWpIazAycXJWR3NRTVZ6c3VGckJjbVduZTdEb0lORnBxRkx0RGllajNK?=
 =?utf-8?B?dmgzRjFpVWVtKzFFUGg3RjdlSm5xdjJlaTMyK0JwR0ZKSVRJWmJEYzlEeWJv?=
 =?utf-8?B?NXJCeU1XVWRreXVTVFVUNXZ1Z054MjdpeGRLZXJMQUtNaFM3VklTY05GcWln?=
 =?utf-8?B?d3k0Z0ovbnQ3UXhFcFZ2L3ZRa3JNeHNTcFo1TFlsTzNSYzVNUC9TYjFEUEZ4?=
 =?utf-8?B?QUFTejc4bkU3K3A3cFVnRHN2ZUdjaE1LcEhQa2crTVg3RzZaTjRodTZpKytP?=
 =?utf-8?B?ZDlHa0dmRFl6YVRYR1hRODFkVWJFV2xoREZFUVdHNzgxQTJOcTEwdWM2MUlp?=
 =?utf-8?B?cXJEcW1JaGJTTkN1ODR4QmlRRStUWTB1NFo5Ly8vSUJtWkFXYlg0akhZK2hE?=
 =?utf-8?Q?ciU3Eo+ECZnforMY7g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWp1OGI0bnVEc0xLMFg0L0NlbVJlTHRQK0pINk1rK3F6UHlHenhOV3E3aVc1?=
 =?utf-8?B?dEgwTk9CeGhKeDZGWGh4dmlBczRpdC9seThsdFhEbG9jZmd2c0Z3bjJLNkwx?=
 =?utf-8?B?T0lsNjJlR1B4emdWSWlxRHZBM3BVeWFpd3NmSFc0RW9GTHVLWTVWaEJyelRV?=
 =?utf-8?B?bXBDS1JzTW92SndBZnFuZmU1MW4zYldHeitQa00veXdIWXp3N0F1RjFUTVdu?=
 =?utf-8?B?ZlhyaVVzbnFHUmZZc1N4M3BTMURxcWh5Q2UwUEMzcTlYMTR0VE04dG5GaDlE?=
 =?utf-8?B?c2NYWExEcEFxSEJkTFVuclpwbnExR1hUQlA1R3YrL05wSHVNb2pjUFA5TE5l?=
 =?utf-8?B?bzRSS0kzU0ZNVnVrOXdYY0Y2T1BBWG9ocTJwV0hPajI4cE5CckxFNVlTTGQy?=
 =?utf-8?B?UU5XZkZpMm0rc1ozeUY4cG0wTDRDb1h6ajdhV3RJekcydWR6UTNCNGRkWHEw?=
 =?utf-8?B?Yk1aeENQZXlYc1FtamRBcEVobHlDeHpBSVgzQ2tNSnpwRnZ1N3dlOVY3eTgr?=
 =?utf-8?B?N1A3Sk5RMmRheGpjbktpYm5KcnpseUptRmVnenllWkpOS3VuMVB2WW1JWkNX?=
 =?utf-8?B?ZGZGZDdkSWljVzBlU3lHNnFuaU1OTHFsaUVPUlhqWUhpTi8zSFNiVXhXY1Nx?=
 =?utf-8?B?SzVhUGE5cmh1NzdFa3NwVDl2bDFuNTliemEvZ2dKWmRHbjFOMHVsL1RjOVpr?=
 =?utf-8?B?ZnhBSDkzQnhFdkJMek9kZWYwRnJvRTE5SzBPd2tEQTE5K1NvMXF1UXMrQTRR?=
 =?utf-8?B?bC96MS8xLzJ6OGQvdXBlT1ZXaVhFWW9BTmd6Nm1MWWx4bVJkb2hiVW5tQkcw?=
 =?utf-8?B?VFhoSEdJYnBsNTAyaTlNT3ByZ1A4N283Y1JmbG5JK0tiN2ZEYkVBcno2NVlO?=
 =?utf-8?B?MndhcXVNbkdYcXRRZ0czcWU4VXZLSzJGSTVDUWxDZDZ2KzBoSHZmWmRGWnhk?=
 =?utf-8?B?ajQ4YXZtVHprUG9ZekNPeHl0YmlETk9YbWw2UGxmck5XUjNCdGFWQTQ5R1ha?=
 =?utf-8?B?eUhJN1dKYmE4ZlJpNkRJQk4zckVrYUxlenR6aFlEWUdiQlYxbHNEREYzMDJW?=
 =?utf-8?B?Yi9yNXlBaXJEYmErYnQ3VC93UThCcXB2dC9HUnY4OUgrbEt3VWdjSnk4RzdB?=
 =?utf-8?B?Mm1xZitpdllwbU9DQkpLdTRnaWk3ZjE1ZXBwVFpUb1ZVMnkxenhRRVRlQlVa?=
 =?utf-8?B?bWlmaThXenBoNUNzbDNoK1Mxam1kMUhLVkxWeHFjZ28xT3dMVkIwNXRVOXdR?=
 =?utf-8?B?LzRyaHJFWW5MTXRneUQ1dFh0ai85ZVQxQXA0WjJ6MEJweXFmNTBHQ0NNRXRq?=
 =?utf-8?B?L2tGM3picG5OZTc1TFFvZlhCOHZtSVZjTFFsUmNrbzVLYjVpOVRmb3dFSVI5?=
 =?utf-8?B?S3pDd0xxRy9iaVJFcWVMWVdVc2JtMVNRL0FQbERuWXNTeDhKbDEvZE04Q21p?=
 =?utf-8?B?ek4yZnFEZDZQRHp6cWk3aFdSc2JENm9KR1RYTXVGcVBEOFlCMjIwUzk0OXhS?=
 =?utf-8?B?d29heCtmOVZpL1V2VjNDNWpLV296bFJDbGl5Rkx5anI2aGRpcTkzRnBHeTZF?=
 =?utf-8?B?OVl4TGt5aVg4ajZNb2V5YkpzRWk3OVVJYnRuMmZIdGx4MnJ4dzltRWhMY2hJ?=
 =?utf-8?B?dWdyQnZjSEhIbEZ2c3o0c0M4bUc5RmJSNWkrL1E3ZW15UGhYR2N0L3dWV1h5?=
 =?utf-8?B?blZwMWJMQk0vNWhwRHpmd1FkSnRuc29mejQzNER0dWYzUGpKQUR2VlkrU0Y3?=
 =?utf-8?B?LytveHNObkpWZmVzNm1STnlKZktOclZ3ODJXM1d4YTdoMTc1MnJ0ZUV2OFRk?=
 =?utf-8?B?ODJRV1A0SytEUGoreG1wK3BpaVV6NHpJT1FZZTByK09KQm84M0c4Q1NwMENV?=
 =?utf-8?B?TmRKOXR0WXRLWStENzVDMHNNMzIzTEFQZXdpSGRLeWJ4bTYxMWl2MmphUzFp?=
 =?utf-8?B?Wld3dktqWUl5ZHA3Yjhabm5PY2VXUWNQeEUzSHlxS2FCRWNDcUYrY0pCOC9u?=
 =?utf-8?B?L3UwS2g0djNhOFJiOE9zRXEwcVpTWGY2WExwc0d6UERObWlLa0FLNGtGZXdS?=
 =?utf-8?B?TzZjeXpwMU1EeCtoWXlEbk9kbW1qWFliZ01Hb2pRTkpERUpFcXZUMVRQWk85?=
 =?utf-8?B?RXg1bzhwM0Z3SkZ2eHpycWU5YXVPNTZwN3BqU1NFMEN1OFJrMU5IMjY0aGE5?=
 =?utf-8?Q?24npJ13jqt5MhlT9yx4YRrw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UVrsVa96HvpSONkROJhYnN7hQxn0JllClk6m/BCkkbAmU9UUUfbQKGqtzy2WufOkBZvQDXGv5SBmkgHvfAPZDw9RpmO+WOAC+RqMKJiNaDDPbv4I92EsFE7eBZDjhs//chtqxHSKQqHq/CjUc/VrLbiyj+69lBbyj+/df1tHPDwdbk/OlwUwo9ZPrd3z4GhsTOBVH9CrbykxG2Db5amHVG9A3QzWAbNhamO+uZZ6ClaEezH29F+aFsamdhNcSU5p/qi/2Va3mHAJX3sLyD0uqKq/tEQ8sJruJQBRxTJOKr2z22eHwVuUoC7ruZNgFLZeqWn/cCEKQEQpMNC8mUSO5lyBJG4/OzPAEpeTS3e7DF1QKhAAlWHQfTbVRjwCT7FtUJQquUHoFT8bt4cLNBlZHMPvEoDbdVeR1jMwGbc0W5bX81dMfoSDPI+ugqE1ABzoilJEQvKp87x3DmJnlaMIqkjHUBQAWAhANl2xagFb8WZlqOg9mej9+EZKq3cvpoCEa5d4EPN+5orX0lawIS1CAR2JxIsjlaDiWzz7PhpuQwTS8ncNvZjjXFFgQdskR1wYWD765a2nXQyfKUwiQ509dkj4FGvDW1x+558knnJUQE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ee6860-8eca-4f71-d9e8-08dce4552a30
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:16:01.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWz5WYVPECvXiawDdsxueeZbHMEyrfdIoIk62wSJJooP1U9+az9W8wCLWQNMjl7b+us20naDH6dpDqqmUaG09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040066
X-Proofpoint-ORIG-GUID: yNOWzefPAjWzfx48X_KSEkDknRHuCH__
X-Proofpoint-GUID: yNOWzefPAjWzfx48X_KSEkDknRHuCH__

On 04/10/2024 06:13, Ihor Solodrai wrote:
> This patchset changes how BTF encoders collect and store function
> information in a table searcheable by name, where their
> btf_encoder_function_state is maintained.
>

hi Ihor

I'll take a more detailed look shortly, but I'd suggest respinning the
series against the updated "next" branch shortly as there are changes in
flight that Stephen is working on to encode variables; they
significantly change the processing of variables, see [1] for details.
They have partly landed and the rest will likely land soon. It might
make things easier to wait until those changes land and respin, and I
don't think they invalidate the approach you suggest, just will require
some merging around variable handling I think.

[1] https://lore.kernel.org/dwarves/8734ldm72u.fsf@oracle.com/


> Previously a separate array of elf_function structs was built and
> stored by each btf_encoder, and when the encoders were merged before
> dumping BTF their function tables would be traversed and merged too.
> 
> With these changes, the table used for searching for elf_function
> becomes shared between encoder threads. However, additional
> information in the table and in each individual elf_function has to be
> stored to accomodate the sharing.
> 
> The memory footprint is now slightly higher, although it degrades
> faster when number of threads is increased without this patchset.
> 
> /usr/bin/time -v with -j8:
> 
>     With patchset: Maximum resident set size (kbytes): 1402792 (~2% higher)
>     Without:       Maximum resident set size (kbytes): 1376700
> 
> /usr/bin/time -v with -j16:
> 
>     With patchset: Maximum resident set size (kbytes): 1456044
>     Without:       Maximum resident set size (kbytes): 1450748
> 
> The idea to make function table shared between encoders has been
> mentioned previously [1].
> 
> I've been looking into ways of improving parallel reproducible_build
> time, ideally making it as fast as non-reproducible.  In an off-list
> discussion Eduard Zingerman suggested creating a btf_encoder for each
> input compilation unit. This would allow to enforce the order of BTF
> merge after btf_encoders are done.
> 
> With each encoder maintaining it's own table this idea proved
> infeasible [2]. And so making it shared became a requirement.
> 
> I implemented a prototype that improved the speed of parallel
> reproducible_build by using a similar shared table and implementing
> Eduard's idea [3]. On master (84ab453) reproducible_build was ~50%
> slower than non-reproducible, and with my experimental changes it was
> 20% slower.
> 
> This patchset stems from that work and discussions. The longer term
> goal is to make BTF encoding reproducible by default, and fast.
> 
> [1] https://lore.kernel.org/dwarves/20240909155031.1596249-1-alan.maguire@oracle.com/
> [2] https://lore.kernel.org/dwarves/aQtEzThpIhRiwQpkgeZepPGr5Mt_zuGfPbxQxZgS6SSoPYoqM1afjDqEmIZkdH3YzvhWmWwqCS_8ZvFTcSZHvpkAeBpLRTAZEmrOhq0svfo=@pm.me/
> [3] https://github.com/theihor/dwarves/pull/1/files
> 
> Ihor Solodrai (6):
>   dwarf_loader: introduce pre/post cus__load_module hooks to conf_load
>   btf_encoder: split btf_encoder__collect_symbols()
>   btf_encoder: introduce elf_functions struct type
>   btf_encoder: collect elf_functions in pre_cus__load_module
>   btf_encoder: introduce elf_functions_entry
>   btf_encoder: switch to shared elf_functions table
> 
>  btf_encoder.c  | 341 ++++++++++++++++++++++++++++++++++++-------------
>  btf_encoder.h  |   5 +-
>  dwarf_loader.c |  21 ++-
>  dwarves.h      |  18 ++-
>  pahole.c       |  28 ++--
>  5 files changed, 303 insertions(+), 110 deletions(-)
> 

