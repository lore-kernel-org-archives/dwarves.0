Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FD1BDA83;
	Tue,  6 Aug 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946223; cv=fail; b=dA7wtjCUuJydDRiZGi3cMcZhl/EAGPykfIy37vDCl6mR254AUyK9PGiH/ZBuuSY/cnQ1pamirFvHsxjn5aDo3NSz98mqw4680RyDcZbxrJrtH7EaioSFfYXiV/H0U3ZWVv0G4SIUA2YYpWCgLyf8Bey/eNTPm1Xw/tv6zuSCbL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946223; c=relaxed/simple;
	bh=MQeM7XD+uMOGZ/DErv5Rcc6Gr90w3iy3m6XC2aiBShE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ILhQ1UBNqHKwaVtz2o2yPyjmIAYSolZK3+7crtX37DRpX3hQSzhdnU/p6UfwlWkgJC3dZhqErAT44lR2q0OjpFU05OVgbqDw+Vcl2KpGwYQtrA0KTA2QwKW+Smu3aUUaCInyCh6+m3M6IZSi3WpVpBLEsOr7kAquXICEYRhRiU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aMaKA+JC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FfauE8Gv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aMaKA+JC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FfauE8Gv"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765l8Jv031383;
	Tue, 6 Aug 2024 12:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=GJ0fUTaOKkLeh4k22DoKyoZzvZm7tp/t0EJggHCAjQg=; b=
	aMaKA+JC3OPfoD7kS/M5Y764B4AkZSCpw4iXjJSKhOhwM7Dw600gVfrlOTaaNSjB
	acpZn4ki1y4ppLGLyXah/BfTV/u/tkyf+7+OVUsB7cMSNNnR7x9o6svuotB93UPw
	t3jRwGmRSpI8V7ZDjG5XLR7GARZo6BgShv7IsewWCIhWmA7gvVdnRuJtwsk1LM88
	lMWM4DKFjKGUIjxVHVeRTUknNnJSFc8zA6R1w3LhBuG6MH/MpXTg+c2Mt83/21FV
	leRIhrwBdWV7ByyjUhZexvMAqcCcfOlcWppA4uudNeeyJE+xvzixLbuaO9QbJUjd
	HB45Jf2EwOjVs6/VdZ2eZg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce952v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 12:10:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476Alshf021099;
	Tue, 6 Aug 2024 12:10:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08j9e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 12:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpMGA1+SIQ8+G4ZFd4PP8OuaCjXhraa5R3fmIml1AyZft99Ggk9KsL76aKrtfbieKFp51glme9ZInwOzaMM6z5cY/aOeYREDmgj0ut8pUnAj32qQDkuWAsu7AYcLer0m8kdz8nTbxo/9sxw4KKTbEuGbWYiSIf87j/Rmm4++J9xQX6WeyBOw6h6U1RBmInwRIjYXkJfsv4L/NJzGnMz/yH8CHkunf/OCEw7vAiscp51D/tive7+gPQs1RlF7q5EqWmlvvzYWVZ5YQLo9C9/FwGAV+rBP9m8L1FVWRg6MS+kZvbIcUI22TTiW8jwFJWfCJBa5e92LmT2F0yI4oXYNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ0fUTaOKkLeh4k22DoKyoZzvZm7tp/t0EJggHCAjQg=;
 b=rfTPZmHWak7csNbSKjyl2RAhRHq/Och6qXF7uvtqbK/h6Vw8bzTxQEdEgr6en3o6DAafv8pR53knWygghG6eRGK0wXQeyeTGQ2hD5J/eYl9U4e5hjoCa/+ANgFewMYNDlXz0acX1JDvpGqdNgte64Qk1na1SPQGGkrbxSU2QAk4KtoDunaS/lJlpJiMuivDE3hoi3YGL+SCZ0aDX5icIg2kQqh4VZ8poPxz64z6U7MqxYQk7x5WdLdLrvn8IdHhz3TNmbRW0PAMmbip+GHipkVRRA6QRaVDzdqnEuXhTPdMnefBinKea2nXlfZyTV4t0bl/xP4T0G+eCy32W9Rsrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ0fUTaOKkLeh4k22DoKyoZzvZm7tp/t0EJggHCAjQg=;
 b=FfauE8GvJ37+U4ziEcRS/KC2NEAYFeP88sLauIGVGdvbwb0Wkmib2LMge6ylTcXmvTgzh14nrMdwIjx5Ggna07oSzo5kE2rzplJSWj+fEmwbnk3EeunEULQ5I6guqb8jtIHZZ0MhBiwmTqwAf3QIUBy9rOISznCLTKz/Ta6Vni0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5671.namprd10.prod.outlook.com (2603:10b6:a03:3ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 12:10:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 12:10:06 +0000
Message-ID: <25bc65c9-e28e-48cd-b5a9-f603d846ae51@oracle.com>
Date: Tue, 6 Aug 2024 13:10:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pahole: Apply CU-level filters early in loading
To: Matthew Maurer <mmaurer@google.com>, acme@kernel.org
Cc: rust-for-linux@vger.kernel.org, dwarves@vger.kernel.org,
        aliceryhl@google.com
References: <20240801185054.2518383-1-mmaurer@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240801185054.2518383-1-mmaurer@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 1640abc9-1842-4e8b-9478-08dcb610b5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHJVaW1qWUpCSVBZQ3BpaHlENnVUZXRlWjJtdUNxaEZTL3Y4UlBTQk1EVEFJ?=
 =?utf-8?B?MWVyZzIxWmtpbUEvVVNQcUtHaEdLOHF2a3oyQ3N3Si9XVWZxOE5NSWZ2akts?=
 =?utf-8?B?Z0xsYVJndWdnWFpOQURFRGNyVVE1Y2lhSGpxelQ3b0MxVFRXcUJEQ2hndVZC?=
 =?utf-8?B?NDM1OStqbGlaNjA1bUh4bHE5UzFmKyt0WGJrM1gyVDZrNVlTWTZqTnVucERP?=
 =?utf-8?B?aCtmSTcyN0t0M3ZFb245b3lPTjJkNDdIb0lFbjl5bkhEck04YjljSVhaVnFO?=
 =?utf-8?B?NThlYWljazM0UktSSVd5NXdFUzI3cDkvKy8rVXhhN28vanYxaEVLdEs5NTI3?=
 =?utf-8?B?T09qSmlYZVIzOHdkWHc1Z3V5WHlHbTJwUG9ZMlo5RDZvbndIMTdmOUllcTg0?=
 =?utf-8?B?QWs3SlFQblJKWmRseEo1V21EdFBVSE5FRlc5VGxNOXBGUk52YTNtdDVWZm82?=
 =?utf-8?B?YVl0SkFDcW1sVUs3ei9TQjAyYitpQmJSV3dqeDhNVXdIOEFheUl6S0ZLR0Nn?=
 =?utf-8?B?ajBrd3ljSTh0MEZiRUtvMHBrNW90UmpTNCtHUWxnZmtjcjRQL0NSdWFHaTNQ?=
 =?utf-8?B?R2hyNW9MclU1ODMzZllobnZCN1Q3MzcvMEpRV3Z0UVhmeHZDQlBZd2JvUmhr?=
 =?utf-8?B?R0wxc003MllCOG9ISlZVNTBJYzR2OHYrM1BKRWxYQWNTL1RRTGdQMEljY3Rr?=
 =?utf-8?B?WHQyWFI2ZEU4OW5WTHZOZldhdW1rdUlPeW8zcDlRNEpINkh2U3dDL3FhOTNR?=
 =?utf-8?B?VUJpbnQ3NElKemRNcm9rV3RIYjNkTVJQM1RsYTdZd2d5TXhaTEF1akNsc0ts?=
 =?utf-8?B?NEhpYzNMT25OUjdYZm9XbFNyanRxM1RraDZRa3R0YUVtTTFCVlZTRnF5cVFZ?=
 =?utf-8?B?VFY2enJnR2MwdnhnUzNZREdCbjFCWFRrbG83bzRUNUVJT1Z0ZTBrSlhUTWpm?=
 =?utf-8?B?cjRabkVHZzI2USthRnBiK2RVcWhoYUpRNk9ndExRbVcrNlZZK25hQlIyYkox?=
 =?utf-8?B?TzE0SDlWVXlzUU8yRjhOMjNYSjVHRno1Ry85Nmt3Zmp5Y3UxVEZXcS94QXMx?=
 =?utf-8?B?RzhMNjI0TlgwMncxWWlNeHQzeS9FK3lyV2ZxWm9uQlk2R2NLRjJ1OUg0MjhM?=
 =?utf-8?B?UU5kZWwxVTNubzFlZTBLb284MFZlbUhYTW5lZGR0cXVPaDRwUlB1K3ZxVUlx?=
 =?utf-8?B?ZTJhTnlWOXpKR3ZhaXhkbW5YdEM2bmdoMTIyUjVLa1lmR1VsK3diMkRyK0E1?=
 =?utf-8?B?b3ZRcFNsbjdGNFRML0duU3RmQk10UkxHb1NtQWVoRzFGWGE3YWo4VDVEdzhF?=
 =?utf-8?B?V3dVbkJDKzVISDZVdVlGQU5OT0tycmFIN2dhOE5zSlhnMjliOU5SY01TaWdr?=
 =?utf-8?B?ajVFYU9HZ0wrVlZibEV1SnpFYk1Lc1YySENrODJsK3c2dUVNZytOaFhLRmpN?=
 =?utf-8?B?dHo2bU1wM2pQZisyQVliVWg0Vm81RkM2Z0trQWZDQ2U5YkFpV1g5Zzk2Mzd6?=
 =?utf-8?B?cnE4enlVNW9iQVhBRGNDY0RRWlZxNnVsOWlGei96VUlUZGc5eWhLOWpBN2tz?=
 =?utf-8?B?R1owSVI3VWNiVUxJUEE3aFBOQytXalVQQTdQUVRVVWVJVzQxTUs0RUdYcW9F?=
 =?utf-8?B?SVdtVHg1VWdGbVJwNzRJbk9YaGJQdVVSdld0SStGdGZ0L1BKblpGQjJnakVS?=
 =?utf-8?B?R3BYR0xJa29ycFVWYUs0MWxLZy9MQWV6RUFzQXM4YlZTVit6RHg3NHhGNWpm?=
 =?utf-8?B?U2pDQ1J3UGhUclNlYWIyLytnbStpRFc1V2NMTG5HMUp5b2UvLzM4RlorT2Vo?=
 =?utf-8?B?ZUtYdnBPVUZBbExGZmR3QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekk2OGFZdVViMXpETFdoQndmY3dkNDNPNFNCYUk2VGlEWURzYXFsRUFGeG5X?=
 =?utf-8?B?RUZDQXp6YTl3cmJ1OUE0dmhHbWFUNVhHM2RyVVB2RVd1TnpsSDhlNXZ2VGEy?=
 =?utf-8?B?SWdaZlJkQjJ2SlZHQXF1QWJaU2VrZ1BhSnFsMW9VNlBKYldJWjB1aVBtRE0y?=
 =?utf-8?B?aXNqMis2T2M2U29BanZUNkw0a3VkMG5KOEl6a3R1WC9kdXJ6QWNIdTFOWUdm?=
 =?utf-8?B?RXRWM3ZoWWR0Nm9lZFVUbzVHaUhGNHF1Sy9uTEJWUy9WL2pObkhDdm5ZRSs5?=
 =?utf-8?B?b0QvY0FmR05hbnFidzNyam55aTdwMkRrdnFlUis2Q3RxM2Vrb3Y1c3phL1Va?=
 =?utf-8?B?Y04xT1ZPSGgzWWxLQXpoQ2hNNUY1MVZoREZ3alU3VHUxRHBKZU9BWVRkV2lI?=
 =?utf-8?B?VUlHR3JyTHRsbkJyTEhhcEN4REJPTHAvV3lEeHNSMlM5SU9zUG1jTkl3Z3hU?=
 =?utf-8?B?Ty9FRDBWelRxZTJoeG00QUJTWTRGeWp1a1ozQkxQNlZrOC9DeU8wdUY2SUd1?=
 =?utf-8?B?UGlMQysrUFJpdkcwQ0VLMFZlV3BUNzh0WTd4WjlWUGx2OXdENjA2UE9PMk1Q?=
 =?utf-8?B?clNudkZFR3N5cUkzak9td2lmNmtYaWZXNldHbENSM0dIRTlsVHN3VE4xV3Rm?=
 =?utf-8?B?dWZBaU9jL3ZSM2ZHNmtDNTBhQzRkUng2UHBGOUpmSEFDczluNFdraHVQajRr?=
 =?utf-8?B?QW9LaW14VUJySlgwM1pZcHdlR28vOUxnYzFyMXAyVHlEb2hFNzBQNXNmQVpw?=
 =?utf-8?B?Z3BxaU9wUVhSb1h2QU10Rm9TbmVKektobnRleTIrS0tOMFFnc0lqazhOTFZk?=
 =?utf-8?B?MnFYRURCbXBERFF4b1oxKytKaGVWY0xxQWw3Yzd2R0ZjMW81Rm5GTUxzeDE3?=
 =?utf-8?B?NHA1YXZuYWF6endlRi9LanBIOU85Skc1dTFKY1RmdXRlRnhWaW1FTHJoZXp1?=
 =?utf-8?B?WEcvWFVGK2RPV0o5K3I3a1k2RVkwZkg2Z0REWlhlME16YitVc3lpcDhMZFQ4?=
 =?utf-8?B?Qzl5YklGOFVQSks5NDdPbUUxRWNTRlNGTDFmS1AyM1drajZNSDJXNmZmZ1NX?=
 =?utf-8?B?Uzk3ZmFqWlhnYmRtWm5yb09tZStieUJpdFNyelJ0bnBreCt1d2k0M2xYaU8r?=
 =?utf-8?B?YWFiNkQ3dGhKdXJxSldZSUN6byszVjJ1Tnc4VnpLTzFOSklRbjl4MzB2RkQy?=
 =?utf-8?B?cXVOdEYvb3ExM1hQYVhGREo5clIyRzRsNG9CL3JwTUxNZkpZbmtabFFrRW9E?=
 =?utf-8?B?SXJienFadGRrb2xrMDFlS2tDS1NwTUxvUys1RGE2emNHSVppK0tzMWpzY05W?=
 =?utf-8?B?enpZWm1GNFRJMGdGRTFmdWlDQzlzYkZqQWowUjBrOHQvaW5EWUV4WEZGQklN?=
 =?utf-8?B?UVlSZHdmeXN2M0ZpQnNIY0IxeVBkWlJ1OHZ2UTFrUHBCRTZNWTVRVklkc2lL?=
 =?utf-8?B?WVVvSVdEbHJTcmFZaHcyeE9vSHlORXQ1NlQ1ay8zbDA4SGIxdEpjazI4cFRJ?=
 =?utf-8?B?MzZlMG5IVUdDekZFMWlSL29lenp5cGZYVUJwdDlhWlNUOGQ2OElUdDNFemFa?=
 =?utf-8?B?OVdKY3FhN1lKdzE5aUh6YklEa3VZNDdRZjZYc1FyZVhHcFA4NFc4Yno3cXUz?=
 =?utf-8?B?Y294c2d2RmdwdG9vWVJZYnBNUVdpdzIwNDhsdTlzR2J5Znk4QitTdEpYbk1a?=
 =?utf-8?B?blFrbkx5Q25neWRwZUF1aEQvcDVHMDU4ZjVENGtVRXdtU1ZIMnpTZDJRcGw3?=
 =?utf-8?B?T2IxNCtsYkQweDlzSnhmV0JLSHgvMm5ydzJ2dEkrOEVuNHp6cVVZYmlwdzNm?=
 =?utf-8?B?MnVEdjRLT2lmYzVuQmh1MjVnNzBtckE4aWtPWnBOdDN1cU9WTHJ5cXBaNUVy?=
 =?utf-8?B?L0YwODZQQjdFWitqL202eDkza2YvMWZBT1NKOVdNSStTRGFjbG54VTU5OXF6?=
 =?utf-8?B?WkVrdXVPZWlPNnFabmwrSCsvbDRxc3cveXRHV0craXdlWmlQZVgxOXhvMEQw?=
 =?utf-8?B?WkJwVGU4Zms1aHhhZzM4NU5qdk9XUUJWR3FZdnRKZTNodWlwd3Ira2gvUXhn?=
 =?utf-8?B?bjZFbXRtbzFUZlVVVzNIU1FpTUZmYnorVElSUGdQTmxobmlWdTdXUjJKcFA3?=
 =?utf-8?B?RWo2VW50SlpFamd4d0dVSVZaWG8zNEZGbzdJbVFla3UwdnlDSmErUUlhUHlL?=
 =?utf-8?Q?WdhtvzPjkx2iY3BXcwldgTE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qcYVd64sMWpcxzOfZVMOT7aBxHsvkE3bRySNNq6e/Bwpzcnfa86KxkAoVg49p3An4nl1TLSnDrrJLOyB3w4rTBienpjQ4EVuM20AoIXgZUHJNviQ8KwB4Wp58hd1kliJMOQhKWrdihMDvRUwVz/APCnNH+Y3OygxJKZ6RVkoWZRp4zJ+jDA+2D115J0G0xwomW3VzDCOGynNmvb23CWoXAtH745Ain5NJnvn1N8ayrFJpLJUzuQ5dPQPUORdXCd4l5UZJ0j75cDOwmRoMCm5gCryN0ThJcfW+CfwEfUfDI4RdVgc/DnvxHvhuT9s3g4xSWu8p/yx0BbDA45djefY4/TL025GGlHpRipCfBc3XHr0u0ZFF31/bFJX8aA/3mDRYh/0d3S0I/0iipEYFiVrEkpVonQFJuhj2qeId2yiaaJrrffClu7tVB9h3aAcYdQ+C9oxZegZL6w8d0F0iQofu7ikf5h0ecY6tg1R54vWbYy7mV91SaWPPHoo6lfmft1MYHZGctHxzgmtGMF5ENHtwcffdXD2DUlLflzR9agG71NzrYz5kE6Ja4gFhU56UZr2luxKkjAW0bOjpRW38xLzwGO9vbJl2T5dXHakBcPe3eQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1640abc9-1842-4e8b-9478-08dcb610b5af
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:10:06.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTm0+Yd7+40TLgJ4i47GSl4dWBvIQdKCZKq5OziNyLUNaycq6J20lLQk1id1rxtdRe0ye94WIxNWNNFin1x7ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_10,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408060085
X-Proofpoint-GUID: 6YOD3RKN8SvCv8REBjYQN3_YcfhdJBzK
X-Proofpoint-ORIG-GUID: 6YOD3RKN8SvCv8REBjYQN3_YcfhdJBzK

On 01/08/2024 19:50, Matthew Maurer wrote:
> Without this, even with `--lang_exclude=rust` set, running on `vmlinux`
> with `CONFIG_RUST` enabled will lead to errors like:
> die__process_function: tag not supported 0x2f (template_type_parameter)!
> because the filtering doesn't happen until finalization, but unsupported
> tags are reported during loading.
> 
> As an added bonus, this should speed up processing of large objects with
> filtered CUs, as their details will no longer be walked.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

LGTM, thanks!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  dwarf_loader.c | 10 ++++++++++
>  dwarves.h      |  1 +
>  pahole.c       |  4 ++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index b832c93..02a17f4 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2854,6 +2854,16 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  
>  	cu->language = attr_numeric(die, DW_AT_language);
>  
> +	if (conf->early_cu_filter)
> +		cu = conf->early_cu_filter(cu);
> +
> +	/*
> +	 * If we filtered this CU out, we still want to keep iterating, but
> +	 * there's no need to walk the rest of the CU info.
> +	 */
> +	if (cu == NULL)
> +		return DWARF_CB_OK;
> +
>  	if (dwarf_child(die, &child) == 0) {
>  		int err = die__process_unit(&child, cu, conf);
>  		if (err)
> diff --git a/dwarves.h b/dwarves.h
> index f5ae79f..92d102b 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -72,6 +72,7 @@ struct conf_load {
>  	enum load_steal_kind	(*steal)(struct cu *cu,
>  					 struct conf_load *conf,
>  					 void *thr_data);
> +	struct cu *		(*early_cu_filter)(struct cu *cu);
>  	int			(*thread_exit)(struct conf_load *conf, void *thr_data);
>  	void			*cookie;
>  	char			*format_path;
> diff --git a/pahole.c b/pahole.c
> index 954498d..42a9c16 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3765,6 +3765,10 @@ int main(int argc, char *argv[])
>  	memset(tab, ' ', sizeof(tab) - 1);
>  
>  	conf_load.steal = pahole_stealer;
> +
> +	if (languages.exclude)
> +		conf_load.early_cu_filter = cu__filter;
> +
>  	conf_load.thread_exit = pahole_thread_exit;
>  
>  	if (conf_load.reproducible_build) {
