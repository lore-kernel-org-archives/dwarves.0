Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4628504B
	for <dwarves@vger.kernel.org>; Thu, 14 Aug 2025 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164578; cv=fail; b=c7TUCflJBbykPSPWLwQ+HBifeNrZlAiBoRR+bAZw2/xdNVrhjPnxfWuryd6Q1h2OZ1FOIU2q2KZt9X0oIFrUHXYws6n8jkp0Oeqh3ratY+J0tEfCv9dUuteTEXOkHTWegAW5BD86q/yPXMbRQyTsZXSJ/VjN9HvBmo9fyID/kYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164578; c=relaxed/simple;
	bh=ZTm5htZyTe7tul7yffRi3dLAoIcJ3vv4iexuNGMrRF8=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DkspunpZqBc6UQvelExvsXjoh2Xn0IdkLOVOkA9342w31Nbe/jsLFKkDOBqyIB9rTClsBzAThUO74ZDzwEpHu+PhBcfh8K72vBgKTo6L7+eT+PRpE1x1XUNrUT0D29sOvamZmbBKHUwQvTDKb13zkqhHbeGdPit54hk2DnCUYwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57E9adOO1377619;
	Thu, 14 Aug 2025 09:42:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48ggw0sm63-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 09:42:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnkzsq9sCp79aXGNIWpW4DhcMvjXJGdnZbet1l7A9eqiOhhV1ONFda+KE8EIWTZ9C68nxMiBTzlqrhfIM09zQo5fy4abJMjWjSleFNtDRApyoGhvCjksadezKcLS5jRsjsqTozVp+MEfc8L5ih9IIHczv9y0CJTKzQ1wsqTt/VTIbspGHk5lUELayVePBX675qiRjs31YTIR0dqlSgyqjDGhmvGhMWYiIqqIpBNGfNkdbRZPCf0Dx3gP1bU8Uk/GS2aJEKqekmGlay5UAQzo46P1Ftq2ALZx61rptOByixRQmRKQNZcGOrwoN9Ltt1/HEKkCrpSqye0XpdZ8I87K6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVp/yZSGFrZgGAH08SiO8NbyWkBHA+WJmrUMOsNqmKc=;
 b=Mn3zWhGr1tDXCxmR0tTOjZ5yK2KGiLB5aezSE5OiXhDzDKQ3yxgH8U2n1a+sUP4Y9jC5Uv4HIitWZvpufHnr8SLn0k7+YubO/cIHlE0Zq3ob//Guk5uxoXu4dzEIt0KDPRLSF2dfLGZ2ozNj8f1F0VC4Yu9+mUD3GfmvfNwcbwJJfh1ev0xnObHWbRrFioJgjmb8WDfr9K6nyeWy62klbYorrA5JPnN/uYsqfu7RytgVWkedym8hvo58F5tTmmfTYPM3oAoqi7fN0TcmVpeF24m0WusC9/SKzs4mnMGISOyY6lUCkGt7IVYvbcw++bs+Ihkr2YQGnpox2ACweA9SBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 09:42:24 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:42:24 +0000
Message-ID: <ec72bbb8-b74d-49d1-bb42-5343feab8e5b@windriver.com>
Date: Thu, 14 Aug 2025 17:42:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: "Segmentation fault" of pahole
From: Changqing Li <changqing.li@windriver.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, acme@kernel.org,
        dwarves@vger.kernel.org
References: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
 <37030a9d-28d8-4871-8acb-b26c59240710@linux.dev>
 <f1e2dc2b-a88b-4342-8e94-65481ae0cb4f@windriver.com>
Content-Language: en-US
In-Reply-To: <f1e2dc2b-a88b-4342-8e94-65481ae0cb4f@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|MW3PR11MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea97735-5ed6-46cb-d503-08dddb16df91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFBPZFJ5MllOSUdEdEZhM0dJemdsQ1ZjU2lNUnNtc25mWWN6QlVLSWpZbFRP?=
 =?utf-8?B?TlYxWk9CWEtPQnlWRDQ0SkRHS3dEVCtUVHRGZlJmL3l2MVRuUnZFWDdTWHN1?=
 =?utf-8?B?YXpnaTg0OUk0NUM0ZTlMdkJlUkRROXdocW5GSkV0OXBtdWJiUjlpNi85MThB?=
 =?utf-8?B?VVp2TFQ2Q2VVOUhFWnhUREFpZHdrRGFybUk2YzFubFhWZUxHaFkwQ3kzRkx6?=
 =?utf-8?B?VDBtc1BYcXJIcHVlM3hNSjhlMjZUR1JsNVIvT1BSTWpKRjQydkRvalduYmJ5?=
 =?utf-8?B?bFRDcSsrL1NXTG9hcnRHNFlPMW0zTGJXMmYyNmpaWDRhaEErOWpUb2pMdGpC?=
 =?utf-8?B?ZFVJMWN1TzNpQUdrM1d6N0dmSzdOZFdSM3FrajJ2TE5FR25pWSt6SWF0TDhN?=
 =?utf-8?B?K2VMUFVEKzNWWHMxSGEwa2YySlVCMTVYYnppUVF3WW1YMXpsT1piaTZ3Zm5x?=
 =?utf-8?B?WHRlQ3ZFTU45QU04azNnQUtGaFBzTWRQRGF5SmM5L3BnNVkyNzloMkF6T3hu?=
 =?utf-8?B?OWZLL2RHb0lQbkRwNUNBS2ppQTFIUTNEZ1huQUFlR3J1SDE0eUNERTZvNjg3?=
 =?utf-8?B?QmhzMWp1THBvYnIwKzlQbWRibXNwL2tCZlNDTzBrQmNDdTJiQkhIL1lydmJ1?=
 =?utf-8?B?bmFaeVFvZjhzRGpPSnp5NUJLdW9kQjhSSHl5djNkMS9IdFdGY0FNazlocHlr?=
 =?utf-8?B?OU1OSG92VUJwK0lmaUZXcE4veHdmNGwvQ1NHTlpwRWdtYmZjU2tyRDNFbTFp?=
 =?utf-8?B?MmJEdVdGeGZ6SzAwM0ViQWk1R1FFdzg1ZzhGWXRpNEVMTmlNL1NXeVBLOFlx?=
 =?utf-8?B?bGdBalhLWjJ1SUZxdEtIOTVRQkI1L21odWxJMFZOM2JRTjdoWTAvRjg2L0Mw?=
 =?utf-8?B?U3FGVUwreDhHZmZ2REREbkNwQzAyVFlZZnNBSzFpNS9KdTZOeWl1dlB1RE9T?=
 =?utf-8?B?S1cwak5GNFY0TDI4bDNiaStxeXYyekNraW56WXhBYmtQQXpMbW5GTnF0ckdt?=
 =?utf-8?B?dDhZRXdZLzBIeStNMVYrZjJXdVVrckYvNnMyUzRJckdUNjRjN1RUbUZKWnpi?=
 =?utf-8?B?S080UW5walFKTUNGaksvRzZQQlV5Q05GQWV6emNwUnkrbjBTUUtPNXN6WWtJ?=
 =?utf-8?B?UHRrWWtFN0dIQkFVWmMzS0EyZjRzWmVLQ283RTZLRnB1MFhDZVZJZFNkRDNn?=
 =?utf-8?B?WVlBVmJsWDBabHRCWFM3Rk05K3lFVHNkSVUvZ3VQL1VjMkZKS0FsZHQwS2Qx?=
 =?utf-8?B?OG5RQklUSWxUeTlwNVUrKzdoNDB6LzlIUitzRGFSc0FHcXR1dFNMTmJQeWZF?=
 =?utf-8?B?WXB3aTdQQzN0RDkxc0pJcFBNaGtQVmxYRTQ0aDYxSk1qbnlVS0lwUHdQY2Q0?=
 =?utf-8?B?NFNvcVJKY3JPTTVWaXZJUUJiQitRNmlyWUFWNEI0VC9GZjhML2FubGhrRmw0?=
 =?utf-8?B?SGVvd0EzUjdGUmFzd21kM1cvYTdCelc0MDlnYjNycDkzOEFBU0Q5ajhHZWZu?=
 =?utf-8?B?eEhuL3czaWZmVXBoelVPQWNRcVdyTVc1VlRIVUxUd21MS0JoT1YxMkJRczl6?=
 =?utf-8?B?WDRTT0EyQXM4NmdMZEM0OWh0WXJnT0xpbzNIZVgwa1R6MVA4ZHFFcHVhZzRz?=
 =?utf-8?B?dTVoN3FVRENDMU42N2tma3NXU1YzSWdwMTFvSXhLc2NBOXA3L2MrdEJBRlRy?=
 =?utf-8?B?VWxibW9xdk9UMzJPcGxLMDBvTFRQN1JMWEdtSzZqVTNmK3dSWnUvLzM1Y3R1?=
 =?utf-8?B?OHA4N0F1SDFRczdLU0JITENPNmNSVUdGWnp3ZlZjdjNqZVc2eHloMk5RenBj?=
 =?utf-8?B?L2YvRStQL3J1RVpadTBtRWhUNkZ5c2dFajlLUmU2UUFFK2p1U1FkZ3ZWNUtN?=
 =?utf-8?B?d0RPQVRROG1sTWN0ckMvQUlDM1pvR2hFcFBEeXRlelhmenJQL1VqcTE3Y29P?=
 =?utf-8?Q?8f2lYF+CvHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXovWlpnM1lxWGVQbEJicHcyeTgxYk9oTkNSUnNFb1praTRvWTd5OGZtRjZ6?=
 =?utf-8?B?Yk1EeTVpRlQwNHgxZEFaNGlxcTR1QTQ4U3NYSzBOZ3lpclJxa2dEUlhOTHMw?=
 =?utf-8?B?WktjdjJYRERUU3ZVZTdnR3ZHVlhIRmhzMEZNNVBWZ2Zmcmw2OXBBdDhOU3Rj?=
 =?utf-8?B?bkl4UUNvZURMbHZpZ0IxQUVHY2xka0t0TkxnWjMyUUJ1bkM2aTZENVBtd0sv?=
 =?utf-8?B?SzV2VmxlN1FjRE9sSldFNnN3N0VZb0VXeWJnZ1dBY08wWklTR3dlNGkzYkl3?=
 =?utf-8?B?M1ZEOXpGeUFYVGRCUlo4MGFTSVRhR1YvRmNrTi9qWU5mTDhPVENWMlV5cDJm?=
 =?utf-8?B?aVNvczdpWkxaQllNWjRBb2h5VVFNcFMvVmovdmJZYk4xVlNOL0o5ME12Q1Yr?=
 =?utf-8?B?cUh1UTVZVTd4aFN5RlREZTBndnZGU1pZMWg2Sjd0dFNoNlFLenZyTFNYQ0Rt?=
 =?utf-8?B?aVVYQ3JFcGo0Sy9sTm4vU1NPZnVYbWVCcnFNZHdhd20zNWZURGZRZGtpclNW?=
 =?utf-8?B?OTBPVjAzeFc1bUNqK1dLVEl5MzBVU0Z2MTNJT0VVOWtVL1FDNW1xc0NiMFhi?=
 =?utf-8?B?aVhOcXFyRExJb05HUFBFTVVrVjR0ZmUwMHVVc0dwMU5WamYzM3dLY0gvYWJt?=
 =?utf-8?B?bG5rcFJ2YU5NOFk0NENlSjdwTk1wSlJFQ3pDSmswZzd4V3p1NTNCNWVDeVlM?=
 =?utf-8?B?UVdMaFBYZjFtZ0xZWHZPMlY1ZkpEbjF0bi9TNndZNm9rcTA1cnF2MnFvbDl4?=
 =?utf-8?B?aWVHNFNOT2ExbGhJUDVlL1QyMVhxR2VOTkRiRTltS3VjQWw5R2NIREhkVnYz?=
 =?utf-8?B?OUVSdStncFJ6N3EwTjZtM2ZZektPQmVPbFdiYzhyMU1xTXQzK3NVdElUZTFp?=
 =?utf-8?B?Sm5WSS9ERmNYNFM4SXNCWTlFRU8zN3JOc2ZvSWhaYVBlRFBUenYyWnk5bytG?=
 =?utf-8?B?YmhjWUVzQmxEMVRuZlUyNitXNFc3VWJGZU10SEpLUFFBK2QrNDhIa1BKN1pa?=
 =?utf-8?B?bGlObnQ5RzFyMFFVb3ZhVXh4LzdDNWFpNWZNVklRd0NudHBJUmhLR3J5NzMz?=
 =?utf-8?B?c1ZBenAzNXM3Z2hFOHlUay9tS1lBcVIzdGJwNTlQRHVYSzQ5aFRyZS9qOUI4?=
 =?utf-8?B?K3pNRkZUM3JLRDhtalVuWVIwZU05WnYzSFVVWGo2Z050ZExHMytTL0hFbVR6?=
 =?utf-8?B?eTlYRGhKVlJGK1JjQ2V6TVlBbTZkS3hjMXZ5VklLVWpVRW5Yb0NsN0ZlNmI5?=
 =?utf-8?B?ZUVJc0loNUVUNmRkUEdmUENCT1ZXLzRNRm5LZk9vSGlZdmZRdzJNS2tJWk5N?=
 =?utf-8?B?cXR5MkdwWkhSKzhlaUJ4cmxvczQ5ZmJtblBRYjczb3RWcnV2U3N5QWIyL3Mw?=
 =?utf-8?B?T0gyTWEwWVdnZW5iRWYwdnJKeEhpeURiR2E5a0xLNk85WTA2dEg1SjZidEMy?=
 =?utf-8?B?ajF0L3docjNGaVE5V29qc0lnU1JrYnBmVlZXWEFvME1JRjJBbllSRDQyNEE2?=
 =?utf-8?B?Q1NGeW1HRlczZDRDMDhOUndnckRyZDBDT3M0UUpzWllaRHQrcjRULzc2bjVN?=
 =?utf-8?B?VFRUS09ZcE9Pa25iYUlNTC91RWIzQjZUN3J4dytjbFduVExpNFVpNVV2dnhN?=
 =?utf-8?B?T3BwazFUTWw1elB3dWJWOXorZFRibks3UlRSVXVGODRwVU5aNjVzTk5VRDFn?=
 =?utf-8?B?RVVOczJNMHNOU2toUVhRSHlNMXF3Ri80VFhUcEE0UjhkVEs5Z2lSTDVMT3hk?=
 =?utf-8?B?Z3o0aVRQaDdXaUR2M2M0ZFUzK3c4RUFWYk5XYk1ML28wNGVVUEsrdnZKR1da?=
 =?utf-8?B?YnE5UnZpdDZrYkRNWFRtY0JaNHpNb1Z2cUViK29tTjhTNCs4RHFkVk9jVEdC?=
 =?utf-8?B?SkoyalBDMlhGRmVOLzhLem9VUzEyK09pVEwrVDJYNUg4eWw4RS91Snk2WGtz?=
 =?utf-8?B?WHdSK1kzYlR1RzhnNE40aEd5UWQ0cURNQWozdyszQnZiZFZPQ29mc2pGanJJ?=
 =?utf-8?B?SWxVaTlTTmtQUkpSZTRVL3FJeHRSa2tPZExhTE01aC93bVVQbkEySm9vRGFr?=
 =?utf-8?B?TnFIZDBqRFAvM05kQ3lxWHN2SUcvY2JoekdzUXZaM3E0QVd1bEpwdUF1ckNx?=
 =?utf-8?B?eDBGZ25NZDdyVW5tY2lWTktoakN3bGR0MFU0VG5aWlFSOEpsWEdWQjFNdGJu?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea97735-5ed6-46cb-d503-08dddb16df91
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:42:24.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjxYbkmClWRsrBjGgsuJhKl5AbL3MbO2Kov76QT8k4hG14JiBilVshsO+A1dk6vww+JgXyVZl+jeRnSR8kPwBluc/3EVvqHzBfMYaIWoIIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
X-Proofpoint-GUID: PTwKa9Qu1PyWvNaVXZ_mBdUwEh98RJeF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA3OSBTYWx0ZWRfX06kjBBzZXXBl
 H5fJPqIdffGY8GACr6ymy+SdMmjaQ/fXbCQoVYLVqhds3N9IRGRG+2vjVXnCMOft+ZF+PUba325
 0aBNo7afgUDKAqjfN+6YBcKxp+8d1In23yY6Cw4lovCIp1oBblNDau+FNvTMPREJp/ClL63E2B+
 KeaEE6HUEsK5jZ5oqBorrJKvcRFSGlN8G4OjqFesLndXGzIOzhOzcWsd1+hihfx6fiFqrWUOpyV
 5HXApDqTgBSqG1KWLz5HC8um2sZpTt7WyMyPYBqUyKDiVA8dYTL1mUFrwj6vqDleBfxt9BFC0w+
 n9BjlKbGJg4+xYFUlZsRSssA4MpqdWJNfHnM89ZcaRoXhI8c1GAStsJorZs8rw=
X-Authority-Analysis: v=2.4 cv=fN453Yae c=1 sm=1 tr=0 ts=689daf84 cx=c_pps
 a=E/8BleX2w456MFKUPs7IYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=syfNYHXCo_SBGoLZ8NQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PTwKa9Qu1PyWvNaVXZ_mBdUwEh98RJeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun


On 8/14/25 17:20, Changqing Li wrote:
>
> On 8/14/25 07:45, Ihor Solodrai wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the 
>> sender and know the content is safe.
>>
>> On 8/10/25 6:18 PM, Changqing Li wrote:
>>> Hi,  Dear maintainers
>>>
>>> I met a "Segmentation fault" error of pahole.   It happened when I
>>> passed an ELF file without .symtab section.
>>> Maybe I passed an  unsupport file, but I think it should not segfault,
>>> maybe  a warnning or error message is better.
>>>
>>>
>>> Here is the detailed info:
>>> Pahole version:
>>> # pahole --version
>>> v1.29
>>>
>>> Reproduce Command:
>>> root@intel-x86-64:/~# pahole --btf_features=default -J /boot/
>>> vmlinux-6.12.40-yocto-standard
>>> pahole[599]: segfault at 8 ip 00007f7c92d819e2 sp 00007f7c799febe0 
>>> error
>>> 6 in libdwarves.so.1.0.0[189e2,7f7c92d72000+1c000] likely on CPU 0 
>>> (core
>>> 0, socket 0)
>>> Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24 18
>>> e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42
>>> 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
>>> Segmentation fault (core dumped)
>>>
>>> root@intel-x86-64:~# file /boot/vmlinux-6.12.40-yocto-standard
>>> /boot/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable, 
>>> x86-64,
>>> version 1 (SYSV), statically linked,
>>> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, stripped
>>>
>>> root@intel-x86-64:/usr/bin# readelf -S /boot/vmlinux-6.12.40-yocto-
>>> standard | grep .symtab
>>>    [ 4] __ksymtab         PROGBITS         ffffffff82c11e00 01e11e00
>>>    [ 5] __ksymtab_gpl     PROGBITS         ffffffff82c24730 01e24730
>>>    [ 6] __ksymtab_strings PROGBITS         ffffffff82c397f0 01e397f0
>>>
>>>
>>> (gdb) bt
>>> #0  elf_functions__new (elf=<optimized out>) at /usr/src/debug/
>>> pahole/1.29/btf_encoder.c:196
>>> #1  0x00007ffff7f92a7d in btf_encoder__elf_functions
>>> (encoder=encoder@entry=0x7fffd8008dc0) at /usr/src/debug/pahole/1.29/
>>> btf_encoder.c:1374
>>> #2  0x00007ffff7f94489 in btf_encoder__new (cu=cu@entry=0x7fffd8001e50,
>>> detached_filename=<optimized out>, warning: could not convert 'btf' 
>>> from
>>> the host encoding (ANSI_X3.4-1968) to UTF-32.
>>> This normally should not happen, please file a bug report.
>>> base_btf=0x0,
>>>      verbose=<optimized out>, conf_load=conf_load@entry=0x555555565280
>>> <conf_load>) at /usr/src/debug/pahole/1.29/btf_encoder.c:2431
>>> #3  0x000055555555db49 in pahole_stealer__btf_encode 
>>> (cu=0x7fffd8001e50,
>>> conf_load=0x555555565280 <conf_load>)
>>>      at /usr/src/debug/pahole/1.29/pahole.c:3126
>>> #4  pahole_stealer (cu=0x7fffd8001e50, conf_load=0x555555565280
>>> <conf_load>) at /usr/src/debug/pahole/1.29/pahole.c:3187
>>> #5  0x00007ffff7f9d023 in cus__steal_now (cus=<optimized out>,
>>> cu=<optimized out>, conf=<optimized out>)
>>>      at /usr/src/debug/pahole/1.29/dwarf_loader.c:3266
>>> #6  dwarf_loader__worker_thread (arg=0x7fffffffe700) at /usr/src/debug/
>>> pahole/1.29/dwarf_loader.c:3672
>>> #7  0x00007ffff7dbe722 in start_thread (arg=<optimized out>) at
>>> pthread_create.c:448
>>> #8  0x00007ffff7e314fc in __GI___clone3 () at ../sysdeps/unix/sysv/
>>> linux/x86_64/clone3.S:78
>>> (gdb)
>>>
>>>
>>> Command  "pahole --btf_features=default -J 
>>> /boot/.debug/vmlinux-6.12.40-
>>> yocto-standard " works well since /boot/.debug/vmlinux-6.12.40-yocto-
>>> standard has  .symtab section.
>>> root@intel-x86-64:/usr/bin# file /boot/.debug/vmlinux-6.12.40-yocto-
>>> standard
>>> /boot/.debug/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable,
>>> x86-64, version 1 (SYSV), statically linked,
>>> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, with 
>>> debug_info,
>>> not stripped
>>>
>>> root@intel-x86-64:/usr/bin# readelf -S /boot/.debug/vmlinux-6.12.40-
>>> yocto-standard | grep .symtab
>>>    [ 4] __ksymtab         NOBITS           ffffffff82c11e00 00001000
>>>    [ 5] __ksymtab_gpl     NOBITS           ffffffff82c24730 00001000
>>>    [ 6] __ksymtab_strings NOBITS           ffffffff82c397f0 00001000
>>>    [49] .symtab           SYMTAB           0000000000000000 154cf200
>>>
>>
>> Hi Changqing Li, thanks for the bug report.
>>
>> I couldn't reproduce this error with a stripped vmlinux:
>>
>> $ objcopy --strip-all ~/kernels/bpf-next/.tmp_vmlinux1 vmlinux-strip-all
>>
>> v1.29 fails with:
>> $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
>> Error creating BTF encoder.
>>
>> v1.30 fails with:
>> $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
>> pahole: /home/isolodrai/pahole/vmlinux-strip-all: Invalid argument
>>
>> Different errors are not nice, but at least no segfault.
>>
>> Could you please share the vmlinux binary that causes the error?
>> And also check if you get a segfault on v1.30 too?
>>
>> Thanks.
>>
> Hi, Ihor
> Thanks for checking this. Here is my retest result:
> On version 1.29:
> root@intel-x86-64:~# pahole --btf_features=default -J 
> /boot/vmlinux-6.12.40-yocto-standard
> pahole[333]: segfault at 8 ip 00007fd5025179e2 sp 00007fd4e73febe0 
> error 6 in libdwarves.so.1.0.0[189e2,7fd502508000+1c000] likely on CPU 
> 0 (core 0, socket 0)
> Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24 
> 18 e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 
> 42 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
> Segmentation fault (core dumped)
> root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
> root@intel-x86-64:~# pahole --btf_features=default -J 
> /root/vmlinux-6.12.40-yocto-standard
> Error creating BTF encoder.
>
> We can see that the same vmlinux-6.12.40-yocto-standard have different 
> result. After do some debugging,  I found that
> /boot/vmlinux-6.12.40-yocto-standard segfault since it has debuginfo 
> file /boot/.debug/vmlinux-6.12.40-yocto-standard.
> after I move .debug to .xxx, it will not segfault.
> root@intel-x86-64:/boot# mv .debug/ .xxx
> root@intel-x86-64:/boot# pahole --btf_features=default -J 
> /boot/vmlinux-6.12.40-yocto-standard
> Error creating BTF encoder.
>
> dwfl_module_getdwarf in cus__process_dwflmod return different when 
> with or without debug,  without .debug, dw=NULL,
> with .debug, dw will have a value, then causes the different process.
>
> On version 1.30
> root@intel-x86-64:~# pahole --version
> v1.30
> root@intel-x86-64:~# pahole --btf_features=default -J 
> /boot/vmlinux-6.12.40-yocto-standard
> pahole[314]: segfault at 8 ip 00007f2b0b6b2bf3 sp 00007f2af05feb20 
> error 6 in libdwarves.so.1.0.0[18bf3,7f2b0b6a3000+1c000] likely on CPU 
> 0 (core 0, socket 0)
> Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24 
> 18 e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 
> 42 08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff
> Segmentation fault (core dumped)
> root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
> root@intel-x86-64:~#  pahole --btf_features=default -J 
> /root/vmlinux-6.12.40-yocto-standard
> pahole: /root/vmlinux-6.12.40-yocto-standard: Invalid argument
> root@intel-x86-64:~# cd /root
> root@intel-x86-64:~# mkdir .debug
> root@intel-x86-64:~# cp /boot/.debug/vmlinux-6.12.40-yocto-standard 
> .debug/
> root@intel-x86-64:~# pahole --btf_features=default -J 
> /root/vmlinux-6.12.40-yocto-standard
> pahole[441]: segfault at 8 ip 00007f64a9032bf3 sp 00007f648dffeb20 
> error 6 in libdwarves.so.1.0.0[18bf3,7f64a9023000+1c000] likely on CPU 
> 0 (core 0, socket 0)
> Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24 
> 18 e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 
> 42 08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff
>
> Segmentation fault (core dumped) 

I think this " Invalid argument " change  is caused by this commit:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=b4a071d99bb9e7c0d3c6ea7a6835389a4d350ed4

encode BTF with DWARF less files is not support for v1.30, so, since  
/boot/vmlinux-6.12.40-yocto-standard without debuginfo, it taken as in 
invalid argument,

I think it is  ok,  but maybe more clear reason is better.


Regards

Changqing

>
>
> I can share my /boot/vmlinux-6.12.40-yocto-standard  and 
> /boot/.debug/vmlinux-6.12.40-yocto-standard, but it will be big 
> attachment, I am not sure
>
> if it is ok to send big attachment in the mailist.
>
> Can you check with my new test result?   if  still need  the 
> vmlinux-6.12.40-yocto-standard, I can try send to this maillist.
>
>
> Regards
>
> Changqing
>
>>>
>>> Analyzation:
>>> if the ELF file doesn't have .symtab section, in function |
>>> elf_functions__new, |funcs->symtab will be NULL, goto out_delete, then
>>> run elf_functions__delete.
>>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/
>>> btf_encoder.c?id=06350d14776a77e16ea5064030fea63bbdd22f27#n176
>>>
>>> And segfault happened in line: list_del(&funcs->node), since funcs-
>>>  >node  not added into the list elf_functions_list yet.
>>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/
>>> btf_encoder.c?id=06350d14776a77e16ea5064030fea63bbdd22f27#n170
>>>
>>> Should we check if the node is added into list elf_functions_list 
>>> before
>>> list_del?  Please help to review this issue, thanks.
>>>
>>> Regards
>>> Changqing
>>>
>>>
>>>
>>>
>>
