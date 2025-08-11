Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754FEEC8
	for <dwarves@vger.kernel.org>; Mon, 11 Aug 2025 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754875162; cv=fail; b=nmcFQBVc0/bhAJ9T9PVi5w7XF3LuU93GEsaDj+PW7wDCl8Pb2wJtuEXImyiF39Fw746M6Kr6fdsiNBSY4R+Ad7cszsFKbI+HUqD/rhsIsbtlNbjuWVo9h3iIvCHfx1S4A4FxWX5ubEQhZrfUku8vcV8bHdW5nPRrpB0jGlMmhv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754875162; c=relaxed/simple;
	bh=8Y0dWCFxt7R+5Gr6YZ6S4KSbqeeYXkM5bFAGZKzuQPM=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=C/ec3X03NGMiccgfzT95RmoIssU0f8QszI2gS3P01AVH4F+DvzjlmcMdcWxS8mz87Ow61XGTmnixd18KZqrCrKQ0iCSlElPP7i5BD9TFlYhufXE1DK/8Je+udIq8Q27PHoi5AYtb8i3XhdKIEucmYngkJZakhahxYHY3KWcOYe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 57B0tm5D1744545;
	Sun, 10 Aug 2025 18:19:01 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48e5uhrv7v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 18:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/aiMzF7k/bHsZaxdJ1yH5goGb340KY2NqqkdsuVJP6VdVy6V4HUHRZgsBkvTwen9rYJ3lapukcDSSUMoYKFxHyCflyBpbbzPs4p83OQFM+ZgroGa6LQsPIh9Htwf8WIw0G6A/JuKSzFlKEQd4XPX16JDr2wp0t6L6zTVcSmKhUCQCsapqDhqJk4r3C9HMd0hSOrC4wcuWUxG6cdBzWcy+POYb003ZwBQawyntel28q1FsQE7tL1TTkyj32kxJvyNXDEb5R72qVD6lEf8Kev5v7/1xVEUXWSh2qAf0BAw+7OSZ+HkqXMPM9eMEIVF8TlajoZPxZfz9sbT+thFR4vUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws+ccNpfQi625bh6BdoG8NXn8KYgi8+P+C9qLmYrd8I=;
 b=uhkizF2IY3HT5KGn623CeOeZ86NP2FQzFUZh00XNNUPUoUOTK8rBvO/wBzbs19YIk0siee/QvftBJSUmA4567oKJzn/MLvR+zrcT++TZeXnw0wVWgkanJKmo5cgz79/evm4zCUmX1alq//J2Un2/xJokim5BtWa1Ae1NUncwxGpmn7VKvd1+yJIwago8kzFLogqMA8emTlESD/Y/pxfSzS/ZZSXaBcyLnK8lw1lUgiDBodu8PO8Pm1957qThaOBcbQn1GnchT/XtdSWV/BBdI6OMfCnpF5pqUW776+mtPN3WBkacrTolFRWdfCAximUQK6mssWBbCyJJXWXns+GRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19)
 by DM4PR11MB8178.namprd11.prod.outlook.com (2603:10b6:8:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 01:18:57 +0000
Received: from CH3PR11MB7297.namprd11.prod.outlook.com
 ([fe80::9196:38bd:6b0:2d0b]) by CH3PR11MB7297.namprd11.prod.outlook.com
 ([fe80::9196:38bd:6b0:2d0b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 01:18:56 +0000
Message-ID: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
Date: Mon, 11 Aug 2025 09:18:43 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: acme@kernel.org, dwarves@vger.kernel.org
From: Changqing Li <changqing.li@windriver.com>
Subject: "Segmentation fault" of pahole
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0058.jpnprd01.prod.outlook.com
 (2603:1096:405:2::22) To IA0PR11MB7308.namprd11.prod.outlook.com
 (2603:10b6:208:436::12)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7297:EE_|DM4PR11MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd3bb03-7485-4839-1250-08ddd8750a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFBwcUVFVmpBQVRKMGFXa1l5ZkMvcS9zd1JZdlF0Mk9yUW1Gazc1U3EvL3Fo?=
 =?utf-8?B?Vm9pcGV1U1FQcHVYd1pXQUE4ZnZTYytGQzkzN1ZacXg3Q1ZFZXBVa1JMZkxh?=
 =?utf-8?B?amhGNE5OK1dyK0p2RkJXR1EvRWhsWGxGaDJDcFdpVmRwMlBDVEVwREZFSGJ4?=
 =?utf-8?B?bXprcW5wRkZXNm85K3N6bEhnTUdzMDB3Umd1Uldya0Z0TWR2NXY5djJQSjE4?=
 =?utf-8?B?T25MVnNYd2M1d0c5UmxMV2pqM3B2MzdSUDVIdVh2aWZ0cG85MWNUcVJDdkpZ?=
 =?utf-8?B?bnZGSjR1cHBpa0w2Ymd6Q3oxSVlwZldzNXgvcVdnWW1Uc0VIYWU0SE56VjNY?=
 =?utf-8?B?ellpOGJaV3dhbElDVi9hOUhsMGtKQzlGdnV1YTRtVis5cy9XQ0YwZ1h6YVZY?=
 =?utf-8?B?YSt0MmFxY2RrNm1hdUMzblJ5WkE1YitqdEwwZWVmd1l3bzU2M2Z6bmo5VFJi?=
 =?utf-8?B?eit6d29iV3pGUUxrbjNwWkR3Rzhqc3hlRXYwV09hMmJnR05NVkxXYnhqMFZB?=
 =?utf-8?B?Q1hIYWJSRFBFN2IrSEJHZWFUWDNlYjhKMUU5VzlKVjk3U3NGYlY5NVBGNDBW?=
 =?utf-8?B?cmFWR0wxZnVVOUEwMEFYRUhvNVF2NEsxUGdNdElhK3VSM0JZNkVvdGR1S1Nr?=
 =?utf-8?B?elJuWnVJOXNvSkg5RWdHa3ljMVlrWnlHWkhiT1ozajJsVWhtYnpZdzZGWFkz?=
 =?utf-8?B?b3NjWGxDb0g0NG5oMmdQb0taQ2R4OURYUS9uaEwxa3BEcTRaTGw2YkpnMTRD?=
 =?utf-8?B?azR2V1RnNTBVbWtTTjc0N0t0UlJSS0pKNmxQTlNkbC9ERDk3U0syUlVSdmp0?=
 =?utf-8?B?NnUybWlOdm5uaStlamFkcVZpbHV5K0VLSmxnTkt5NVR5QnFDQnVYdm44dnVn?=
 =?utf-8?B?K2paaVdBVXdYRVhvWVVkTFRkWlpyenhKU1hVbWlvTVVjMkRwMFQ0YmFEdVpT?=
 =?utf-8?B?eWQyWkhsQnJwQUdSL3N4K0Z0bmIrU3BXWE1KV1l5c3hWdWtTa1BkOUxoTjNq?=
 =?utf-8?B?bUFNUWpaaDlYQkxxOUN5VE55ckJwQlV3RkJXZ1pGbjhxUGI0Zm1ENmJoeTlI?=
 =?utf-8?B?Qkd1R3JxakVhN0orc1VJOHVHM0RmcDNBblN3S09sMlhHb00yblIrZVZiWTZm?=
 =?utf-8?B?dFFPcHRPV0JDMDYzemFLb2p0Y1I4KzRkWll6dnY4dkZnYnlIRWlFSGM4SmRV?=
 =?utf-8?B?SndZWG5lU3dKYmlUTkluZFhyZ2EvQUdURDR3MndpV1lzeEF6cnhaaUpMdjdO?=
 =?utf-8?B?bU1Xd0o5U1NGTHBjWGd2NGFIR2o3Rnd6N3RqRk03UWVuSTRmOWJYU0dpUGVO?=
 =?utf-8?B?UFJtT0tvSm9QYy9abG1ac0Q2TE03MEN1MStGZnFselR4SkoxNVg0RVdrdGxz?=
 =?utf-8?B?dHEzOE5MZ09uSmdLdk4xWEpnaDdicHZyZHJOL2lETWxlNldlUGJqNXpQY3Fl?=
 =?utf-8?B?NGFWdFliZFYzazVoMjhBdnB5VkNxV2ZEMmZxcHVkL2IxeHY3OHhwaExJbEtI?=
 =?utf-8?B?SVpqemorajAwcWxJbDQ5dUZmRDBxNjBwdGZFMUswK2V3MFo3U0kyOEJBY3JY?=
 =?utf-8?B?SnR6RTZ0Rk9EeGhoL2ZId1F6ZFlQa0NFakVaamNib1pjY0tKUnVBTzRrRm9x?=
 =?utf-8?B?UDA2Y0IwQUcwZjlFREZjaTRNbmlHQWxkR1ZrTHgwVjZRWlV3NXFMaVpwVWhM?=
 =?utf-8?B?Yk44a04wZW5NMjQyell5QjZKZ2RkNUxrRldYZko2N3RJak1lMmUzRHZIMUVx?=
 =?utf-8?B?SjJsaDFBWXFmUVpqditabXdubGdRTFFxN25pTzdrR0w4TFh4MWs3OGliaHBR?=
 =?utf-8?B?S0JqVnU0TklwMHhDaW5ZT0NFN2ZsNUFWWWlySDJ1Q25HVUJ0aFFhNHZKeWRB?=
 =?utf-8?B?RzViTCsvMC9Nc2RHK3pjNkRZWHh2eHZDSzlnTFBYZm9jN3FmRVN4b0IwYkJS?=
 =?utf-8?Q?4fkF0C/uVaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTA3UTRaT1NsaEpXZGt2RTdIOWtuWS9Hd2FkRnpQaEVPaXpPV2JvQkVaVHhG?=
 =?utf-8?B?WWJnU2paQVluck1QRVU4ak56Rmhib3ZzZWpIeVZRQ0NobjhsbFdiUS9Mc0Zx?=
 =?utf-8?B?SEFmSE9SOGNpdkxCc0FpNFpnOGJqbEszU0pGUm1HTm5nN0Y0NHpGOWlOMlVn?=
 =?utf-8?B?aHVXWG1icDI4dVpkczJCdkw4SW1ZRXRqM1NoelluWElVK0loUzY0QlFhK1dt?=
 =?utf-8?B?VUQ1MzI0M0F3b1MwVG5WU3RoTDhnODBxY21sd25ucU9ZT1llQ1cvdVZYWnNH?=
 =?utf-8?B?TFUydVRINVdvQnFHNlRrU3pmcVVNR1oyeERHUGZ1ZGRvK3k3aEdzRlJrTktE?=
 =?utf-8?B?QjVYN203a3Qyb1FONFFTOGlQTmlzUDY5akc3cTE4VXhaTmk0dktmTVZvRUp2?=
 =?utf-8?B?R0RDdUJJTEJXdXplTXZlb0xYRnhibnpvS2hVWjJlUm9rNENoWkRSSllNQzU4?=
 =?utf-8?B?MlJ4ZWFRZnl0K3RmVnJEVUxRVXJFZzFUby9LTWUzenBabTNQVUdZaG4zc3pS?=
 =?utf-8?B?Nk9vRm5DbTJmNG1tK2dEbjJ4bjFZSWtYbUxlQ21va25kRFBsdTdBYmwvTlhR?=
 =?utf-8?B?MGtNVVRvK01vT3p4S3dPa2NVUzRvakxGUVBTR2FlUDBhcVVWUlNYMnhuSjBi?=
 =?utf-8?B?WENIc202WkZrZ2xSeDJ4ZW9xMHB1TUpjdm5YOHlCS29oTUM0cm8xSVhhVkdD?=
 =?utf-8?B?TWJSNk9xeGhsR1Fvc2ozdGJZOHJacllmbzM5ZjdjQlkwNldYMFgxNkFzMTZI?=
 =?utf-8?B?VFY2NjdxN1l5ZlJ6WGtyTEtmUGRBNmNvQnFuNDRYd3JIMHU1dGlJeGFqZWNQ?=
 =?utf-8?B?L2gvc3F3RGc4bzlkUjh1OGt5SC9WS3hLYmxMajlESWNRenZHVDkydGYxVTdp?=
 =?utf-8?B?NW9rSFRDSlorM1NrTndNSDBHSnhQOGUrSDl6dDRWVmpsQW9pTzlWSFNUcE9S?=
 =?utf-8?B?YStrUC9MclQvUGx6MSs0ZFE4NTJSSC83bWxjUmcrQ2lHbDFCUEpCbHQvTnZY?=
 =?utf-8?B?bHZ6VFQ3R2V2MEJaai83Z2tJL2JkUzNuSVB2RkpkOUxJSW8wSEsweTNORzFY?=
 =?utf-8?B?ejNJZS8yV2ZXWFZCZXorbHRvK0E4bjVlSXVRVktJY01SNzhxWFR2UlZNb2gy?=
 =?utf-8?B?Q3RGRWN3Z1hUN0dFK24xeThMSVVISVY0clpVQVFrZ1lsTnZOOFVqaXJ6N0hQ?=
 =?utf-8?B?Y2R5WGxOcFFXb3Fjem1WV3FwclBVelZtWXRndlp3K0UvU1FnZkZZYnNxN0Zp?=
 =?utf-8?B?N29hWFQ3amVsa2xXNmJOOGJBb2JyTExGamRVN05vamlDWjgrVnUzV0lYSS95?=
 =?utf-8?B?K3RTbm43YzNybFNDaXVnWTNqdWx0R05uRVpxMHFidmdnTnZ6VWUxQWlNaHZl?=
 =?utf-8?B?MnNLWmRnL1Z0bThvdmFrSk45M3ZieGVPenR3ZVJ6R3ovRDAwdWs3WWxKOW8z?=
 =?utf-8?B?NkVqd3JFeHdURm9tVlpST0hZdVdxbTBSYkROS3JEa1Q3dkYvZlpKejhraVQ5?=
 =?utf-8?B?ems2Q25PamlKV29Kclp0S0hnNUVpanNTKzB3SHg4NnoxQlVGdVNOb3YrL0lI?=
 =?utf-8?B?SWtoWEFuQVhFNEwvUVlyaWxid3pqM3lhd0VUd3JPMFJ6ZWRSNHVNQjVqejJU?=
 =?utf-8?B?cEJTZEcrTG9uWEVMb3JXMVZmOWZhZGRwWmNWZXV0TWNGZTNVd01mTlhTUldj?=
 =?utf-8?B?SmpBNVZRWk0vM2tkK1l2d2ZPbTRuYXIvZ0xNN2hUR1d6aE9GRkFnL0h2WWlu?=
 =?utf-8?B?VmEvY1N4MWNkWFlndWYwWjQzbXl6M3V6aXJFS1B4OUE1Umt5NHEzV1AxZGp5?=
 =?utf-8?B?Z2hXQmI3TkJnNXZqRit0QXFPNE1CUHMrWG5pRkJScXRKZ3hSQmJzbC8xME1p?=
 =?utf-8?B?WHFBcXNmS3RLdGU0TzNtdnNMMlpvOHZmOCtrbzhRdUgwMVJ0UGE2SHBCUW05?=
 =?utf-8?B?Y2VBOTJXTUdyL1o1VGhHQ214QXBRcmM5eENUdlVzZVJxWStpd1RvNlRyaWxU?=
 =?utf-8?B?OHJ4Tk14RzhwUTJveXA3UTEyYnh3b3MrejFEakMrd1lZV1Vrc3BVMDNtaVR1?=
 =?utf-8?B?L01oSTlobVJQWVNTM3VLMjRSOTBTM0d1UXEyQ2JOeS9DSHBGbksrQVIxdTVL?=
 =?utf-8?B?NTZqTjRiQk9sc3FLVDZPVG91U0tCTjdxbUVsamQ2WE5WVUdZMmhoNmsyTngz?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd3bb03-7485-4839-1250-08ddd8750a9a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7308.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 01:18:56.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9P3zKNwbJp6tIv5fHdNM+8gIxiycVqzp5SVeX5cvc2nGvWr85ljYLOo8RNZvx+v6c2aDlowtOO3et1MkJgNthbHNZPolZPYluSaXyE643U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAwNiBTYWx0ZWRfX9ZejCldPg/pp
 NfAHY6YA0/FGppFugb5bqlDKMig7sPykdscClZo+LifgcDHCb33/CdjAOsganDTePJmLHcwOKi3
 q7ZCEjW83aVehwh8k8+1OJ9yecgzzRUdCcSBafBRWkG38hSwgJboLErHQLixuqBfd1I67hG/6Gf
 mc5FNPReHXsJq/Uo3GOM1RCFcV7PkEOiJLwqxvon3L2AJPMPZR59eSuR0HIe02xD4FTuI2oRapa
 Xi/fWhDdb2sYVdoH8wVphqeeg/9LKFCVi+3gXknAMsyMHx88QsGxmDftcs/1X7qt5jN9v7gsmYD
 PsRHkrNWLv/sr+t2bB5tTOmFQy0fYzbg3WK0Y46NyVblz0oFD0t3gIviiGY78c=
X-Proofpoint-GUID: D6xXRIr-erfmMfba4i0D1YEbIvfFNfKY
X-Proofpoint-ORIG-GUID: D6xXRIr-erfmMfba4i0D1YEbIvfFNfKY
X-Authority-Analysis: v=2.4 cv=cZzSrmDM c=1 sm=1 tr=0 ts=68994505 cx=c_pps
 a=qdv+Q4TnSqLF0nLC9wtOhA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COJYmX7F3Q572tfcbEkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

Hi,  Dear maintainers

I met a "Segmentation fault" error of pahole.   It happened when I 
passed an ELF file without .symtab section.
Maybe I passed an  unsupport file, but I think it should not segfault,  
maybe  a warnning or error message is better.


Here is the detailed info:
Pahole version:
# pahole --version
v1.29

Reproduce Command:
root@intel-x86-64:/~# pahole --btf_features=default -J 
/boot/vmlinux-6.12.40-yocto-standard
pahole[599]: segfault at 8 ip 00007f7c92d819e2 sp 00007f7c799febe0 error 
6 in libdwarves.so.1.0.0[189e2,7f7c92d72000+1c000] likely on CPU 0 (core 
0, socket 0)
Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24 18 
e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42 
08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
Segmentation fault (core dumped)

root@intel-x86-64:~# file /boot/vmlinux-6.12.40-yocto-standard
/boot/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable, x86-64, 
version 1 (SYSV), statically linked, 
BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, stripped

root@intel-x86-64:/usr/bin# readelf -S 
/boot/vmlinux-6.12.40-yocto-standard | grep .symtab
   [ 4] __ksymtab         PROGBITS         ffffffff82c11e00  01e11e00
   [ 5] __ksymtab_gpl     PROGBITS         ffffffff82c24730  01e24730
   [ 6] __ksymtab_strings PROGBITS         ffffffff82c397f0  01e397f0


(gdb) bt
#0  elf_functions__new (elf=<optimized out>) at 
/usr/src/debug/pahole/1.29/btf_encoder.c:196
#1  0x00007ffff7f92a7d in btf_encoder__elf_functions 
(encoder=encoder@entry=0x7fffd8008dc0) at 
/usr/src/debug/pahole/1.29/btf_encoder.c:1374
#2  0x00007ffff7f94489 in btf_encoder__new (cu=cu@entry=0x7fffd8001e50, 
detached_filename=<optimized out>, warning: could not convert 'btf' from 
the host encoding (ANSI_X3.4-1968) to UTF-32.
This normally should not happen, please file a bug report.
base_btf=0x0,
     verbose=<optimized out>, conf_load=conf_load@entry=0x555555565280 
<conf_load>) at /usr/src/debug/pahole/1.29/btf_encoder.c:2431
#3  0x000055555555db49 in pahole_stealer__btf_encode (cu=0x7fffd8001e50, 
conf_load=0x555555565280 <conf_load>)
     at /usr/src/debug/pahole/1.29/pahole.c:3126
#4  pahole_stealer (cu=0x7fffd8001e50, conf_load=0x555555565280 
<conf_load>) at /usr/src/debug/pahole/1.29/pahole.c:3187
#5  0x00007ffff7f9d023 in cus__steal_now (cus=<optimized out>, 
cu=<optimized out>, conf=<optimized out>)
     at /usr/src/debug/pahole/1.29/dwarf_loader.c:3266
#6  dwarf_loader__worker_thread (arg=0x7fffffffe700) at 
/usr/src/debug/pahole/1.29/dwarf_loader.c:3672
#7  0x00007ffff7dbe722 in start_thread (arg=<optimized out>) at 
pthread_create.c:448
#8  0x00007ffff7e314fc in __GI___clone3 () at 
../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
(gdb)


Command  "pahole --btf_features=default -J 
/boot/.debug/vmlinux-6.12.40-yocto-standard " works well since  
   /boot/.debug/vmlinux-6.12.40-yocto-standard has  .symtab section.
root@intel-x86-64:/usr/bin# 
file /boot/.debug/vmlinux-6.12.40-yocto-standard
/boot/.debug/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable, 
x86-64, version 1 (SYSV), statically linked, 
BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, with debug_info, 
not stripped

root@intel-x86-64:/usr/bin# readelf -S 
/boot/.debug/vmlinux-6.12.40-yocto-standard | grep .symtab
   [ 4] __ksymtab         NOBITS           ffffffff82c11e00  00001000
   [ 5] __ksymtab_gpl     NOBITS           ffffffff82c24730  00001000
   [ 6] __ksymtab_strings NOBITS           ffffffff82c397f0  00001000
   [49] .symtab           SYMTAB           0000000000000000  154cf200


Analyzation:
if the ELF file doesn't have .symtab section, in function 
|elf_functions__new, |funcs->symtab will be NULL, goto out_delete, then 
run elf_functions__delete.
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encoder.c?id=06350d14776a77e16ea5064030fea63bbdd22f27#n176

And segfault happened in line: list_del(&funcs->node), since 
funcs->node  not added into the list elf_functions_list yet.
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encoder.c?id=06350d14776a77e16ea5064030fea63bbdd22f27#n170

Should we check if the node is added into list elf_functions_list before 
list_del?  Please help to review this issue, thanks.

Regards
Changqing




