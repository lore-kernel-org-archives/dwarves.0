Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECED30E821;
	Fri, 27 Mar 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627398; cv=fail; b=ECHeho0NzOuCZgGAe7gufqcDL9nBus2ZiadePS+Yc3uLBml3z6VfZ9gp7e/fgw0ECyJtPGtw7PO/kDE6rRa5261WKr1asaLBPP2jEiERtqY7oHXMl6tecU16Yvd54ADqAB7aIXbrFrhSoSDwpWtmSgaeefNHqJpYxnIKAusMrHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627398; c=relaxed/simple;
	bh=vR9vGGsoi6TG7MJCZhZ7SmPaMVyynLxE3cc2TtNIHJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kGcti1ZPfZp6X/F4S9VcVoBlZMxXWUtsSgs3nHjEEuvICkQQv1kVE7AS7o9vHaexLPymy9N7Ni2jwqYp497TY2omX336EtZOlso/+5nfH5lO8qCv5FBgNQ0o6sYSsO2dTZhuzAbpOAOMTnUA6x45f5CdXwiRhEqWmE4d8Mw2N8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=emZEZU26; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TFOFNB6h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="emZEZU26";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TFOFNB6h"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R5Vl9Q2065141;
	Fri, 27 Mar 2026 16:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uulz1d1ObR5ZosN+blNYC0V8xb1k/5mWo9Wm3m6RvKs=; b=
	emZEZU26Y3rorfiSz7QrtrcgF09+5cktkONocp/DunguUk8vS9oNOfK6DYtSAjqT
	bMehBQEByqzNVlIncrX+9+4FeE2IJtQM6poXyzswcEJhr6e1kdXz7UDYSK/mvjpi
	cJoYbrSFe1lhz9+d9rcgV0coNI3osevKwz6zPsw4YDClC/mJB0IE4mz6OdqgYRBu
	pTQrJMhws9ONwl/DfMigs9cQl6jCCoGgyEAQfzperG0FfV44M+2Kb4cyS1ewtJqE
	nUS8/9fBOY9uKdZ61hXV/BWMmpmyInK9uuGoBHpoxWghZ9AoJvBOTw0Iqu0/lvox
	qWwz66cgZBaQhakDJF6eBw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpt8mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 16:03:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62RFoorl012306;
	Fri, 27 Mar 2026 16:03:02 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsmn4jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 16:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eM8JYULYQGWEoxB/dpPVNivHBoYbw8A/r5dLWOndG5oG9z0qWcwh4q/CQbi9A+YZu5UB6jAJ5/QgUj16Cpl50c+Gupi5Vbvop4/Y/G2xilwIEqgbB5FG5aNTLGPBShpoM91D5zRvNenLGSien0b4NMJ0Hq73bRtyUxyVx2vMbVDB1i4AqSTmOBmmgNv1yDeHVToXF+kfKsDteUhsm6Mq0lLHueqgclFsvYdZn+GVEbNvyCgHhUewatdMlScW7oqR4l6YN38djiFlE30f76Dr7XInzYRq/HarjjPHT4in8sumKW5tRwlYPzY18ETs0hvNPeT4eGRAnyQ7VkkxJR+3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uulz1d1ObR5ZosN+blNYC0V8xb1k/5mWo9Wm3m6RvKs=;
 b=IVSpPZpDhT3vWPUCqJewDPPUddQL/LpZozmt90QICNtt47VrPbHiGkaXTPsfC8I7aerLVrhi/38JQQpsESaez1MafYJmxR931aHbHWrovDHFNYBmhCDICYdeiFQmTPcdwXGez+cCTBipPODz//s5gF+dGz7a0zsPBtj7ZuCkZDuHNjUL7SLj9UdKRnYCsmF8ciu6fJ2VSQtaVA0O4ZH2+LTV7GDUdCl64+FCtRfCQfeC2hWIavHtMlAh3yAtfnwAPZtaengqXc1VGOxy5PWj2U7nrnz/mzwuoYPY7gHhInaytXBsc1ii/jVlIfHi1pEJZtsH86IA6Wvh+x/WC4l+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uulz1d1ObR5ZosN+blNYC0V8xb1k/5mWo9Wm3m6RvKs=;
 b=TFOFNB6h7L1Z1/9Dl4p73IQyjKSmAX+xbGZT0VDmMExbuSsTY7wsUiUapRe0ZKYYMG34cKbZd/Yb6qTTqHOVayU03L4IGXPUDosgC0oHzCA1o2YVgY6lUG5Fqu8+UPnwT6gPx3+sKRFJswLRcW78nFJ0LykG7sMWPgHidQd4BwI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ0PR10MB5599.namprd10.prod.outlook.com (2603:10b6:a03:3dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 16:02:59 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 16:02:58 +0000
Message-ID: <c2143369-7b31-45d2-9c34-ae311582e074@oracle.com>
Date: Fri, 27 Mar 2026 16:02:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 00/11] pahole: Encode true signatures in kernel
 BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260326013144.2901265-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0274.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ0PR10MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a33dcf-860c-4615-1088-08de8c1a5089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EC/CT58goQYfDTjeYbN/gQRWLAxcxNSM6tg7wDSfMEO66+ACst98/eiRWcRmont3Ki7o3eU91H5xBRJJajm+VeDYAvQ1ggEvQb19fp8MG+ac9Ghr4zYfbl5kEdceTJsVT+4HzyTQuY2rY5ZqakwEUWw/pj/KewrHSYclp9083Zl8ix080/93uCxbbyX6XHPaZrAB5U0o+u/+v0/qdb7blEq7FL6ia7uQTABC2RNnkCGhypU6KJ+QZV+vc2JqHC6W/rVZqOZIUXc5Gui302IvLN28hZYG9uD06A/oCyz2dOJgHXQoFdXbvGMZH7pA6ZU6IMOA79BXrJjCc0dEeMbIju53N6OaQ2OqFDDUZit0Naps6hX1lOHvqzRSpPnKVccetnN1bzxAeyP235xeRCv7V1wyHrEsINpUoH+qF/8jbrl+QnrpaGzyanloIqKmtHEmb4ybkUkuTTLBCsdrTYXDBEY/2EyY2RR6IDtQPHubJ1H/djQQHVIz7d+e0mTbsa9dVlJ2ZZkeU2RwNxR5tzvlVvZx5vjZ8L3FdoPMH5WEHjm2/h73L6tx8s0uEfKTYe4ErCcRC7X8jEkaeaPj0zeef3Os/SF4kjvtN55IJBYS3Cw3hjzgJhE52DEy2C6McaZ6x+R7AnXxIUo0uT3XW3wcHCxV4KzXgG/CXoCyWAGLGnDrA0/yQQkaL86eoKqYdoHViEwzz42sdJdTrUTtLMUCAtFgSjlZkZOmul8YIwju2gKgs0O66yYUdlm5vFtJvhfe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmZ5SFQ2UTNtOTVHakE5TjU5L1lyak9DZitudTVrcG5peHJlZHhoNmdPa2RM?=
 =?utf-8?B?NkF6OTFzNVZlT0o5eW9RYXBLMkVjRFJlOWVubkozRWxVemRQaWhEWlFVV0Ez?=
 =?utf-8?B?dVZZUGh1RzN4bGc4ZGhOdW1jNXp4bWMxM0NTdUU5UlVkMnFrT2liS0prL0ll?=
 =?utf-8?B?WVRxRTNtSHFXZTdpWWU5NlBWakYzNGpBQ2x0emNGT3UxdUFGbm1zU2xrQnA0?=
 =?utf-8?B?OW9rTFFPRzk1RFFjMkVuWjI3V25lWDJ4d1lvT2IvRitkT0l3dnArMitwdCsw?=
 =?utf-8?B?VzRCZmtSclpTeWRlL3ZKUWloTFlSTjYyUTgzOEd4dTNpMGpuaEVOeStSYTQx?=
 =?utf-8?B?UklHOXpxV29qcU9hTS95OTBqd2R3VmFoZm1QMXpWa2Jya09VSFZGMGZ3c2w3?=
 =?utf-8?B?N2QyeGdsT3hLMXdpS0JvYXRDNXMyc3k5b3FHWXBXM2pmNjNSMmwwTzI3V1lN?=
 =?utf-8?B?MTluUWxHSEMweHlZQmxBVFNldGpxYTBZN09VTXBaTFNXVG9GUXVWVmg1STlE?=
 =?utf-8?B?ellTamZ5b25wblkxRERMU1lVU3FUdlZHVTdwQ1kzK1I3RndoY3NJWUhhVXNR?=
 =?utf-8?B?QmJ1YUpTZHQrVktPbXh6VUR3ejJUdVpKVkNGa3ZtSCs4bXdHQjBoVS9yZ3hs?=
 =?utf-8?B?djFZOW9CeVB1emUwNklQVWgxQ0xuQ0RBSmI5VXJXbEZmRGlPTS9LVWhBUlVK?=
 =?utf-8?B?YjRRRzA1V215SEY0RzNVYjZYZ004RVdyR2tBVXF5VlRxWXh4MWZIL3VyNUFE?=
 =?utf-8?B?aHNKZkdsZU00VCtLeXUzYXV3MHZha2pULy9Ka20wNWloVmozZWtCcUNyUjZo?=
 =?utf-8?B?V0E1K0dOc1hqdG5jYzhXV2xyYVpNK2kzK29vaWxKWmZpbkw3VjFhajIrQURt?=
 =?utf-8?B?WnB0Tk1aRkY4dmRXOWpXWGtwZjJ2S2JMVTM0QkJxZjZhRjNZcUgwSUxRaFRl?=
 =?utf-8?B?M1hFcGY1bkxZeG1RSEtuanVodHNHclhOVU5nZmwxb2hwWTlzTkJhYUZ6dGlW?=
 =?utf-8?B?T0dCdHI2ZkdLNEpTY3V6aERjem5ieDlPdHpIMCs3QWJ1WnVCVXdnUUlnbnlN?=
 =?utf-8?B?SW9JVzhJOE0zMnJvNUhlQlRvS0xrTmNGK1pnN1pUWFJMYjYwN1l5dVh1eXJt?=
 =?utf-8?B?NnZOVGpENjJGbFMrYXVndHlmU25vNFd1aEMzTVQyeDIvb3ZESURnNTB0ekxN?=
 =?utf-8?B?WUxKaWtWVksrSnM5Y2tzT1FKc0J2RXBFS3d0R01aQWluTVpTN1dOTllSSmRj?=
 =?utf-8?B?MHVtaE5BbEJERUpRR1VyMk5IRnNSdzBha0VmaXp2MTJPcTNOeUtuSkZEcWVQ?=
 =?utf-8?B?WnNLNjZOVzkwL1NvUXhNYTRobitTUFBrUEppM0NIWkZZWENOakgxZmdsSWdj?=
 =?utf-8?B?UWVxS25lb25ROWdxVWRBMHJaSkNGV2pvVjV4ci9mK1dJazB4RGVIdzdhZ3g5?=
 =?utf-8?B?NWRmaVNxSTR3WHBaY0U0N0FVTUpnWStvS3pmdTNyVi9zTEtLbUM0SDE4YWRY?=
 =?utf-8?B?OFRWZngrTG1ZVm50dWhpL3R6ejVTTlJCU0ViSmxSc1J4NkwrTlVQQmN3ZnpC?=
 =?utf-8?B?dTVDYnpUNjRQR25CV21mWjQ4UWdUOEtqMnhGNGIvdkZHMStZOHRyQVZlaU9w?=
 =?utf-8?B?cGFkWE5YUW5WWTlxSW9wSzQ4dDFSYm5UUzRkSWVnbXhrN0dod2QvQnIxYURL?=
 =?utf-8?B?ZHBucEd3VW42ejBhRWRJK1NBVU0zdWVZUVIvM1UvSUdCcFNZZUwrdnhNOG96?=
 =?utf-8?B?Z0p1M0NZclNqMzdhN3FVV1hTZDAzc2NpU2tlT284OHkzRGxrYzhRVjF4QTRF?=
 =?utf-8?B?UzNSRGVwR1RxdVUrd0RINEVoNlVBZTMvUVpaRG1GbkVnanBxQ2ZhNmYzVEZo?=
 =?utf-8?B?SVcrblhyRnRuOVk3NUpWZWp4NE5oMHFuZmUwU3RMSE04ck0xNGtCNjZ2ZDdr?=
 =?utf-8?B?M2RKODdnckZSM2pOUTZTUjYrU3YvQ3A2Z3pjSC9CMS8yZlBFaDByajJUYnBJ?=
 =?utf-8?B?QzFtVUJvOEhVb3hQRyt1NjJldlAzVkplYU41K0ZtMEd1amJwa1hlQ1pJajEw?=
 =?utf-8?B?ZllWaHJybnIvSjRmSkR6b0ltTXB1YTNlTUx5VnBvdUZ0RHVYcG5iSUdCcHhs?=
 =?utf-8?B?K3F4NVNLbll0NUh4QThrYkg2OXAvSXhqOWQ1OGRMV2JDMlpUT0ZKdVV2RHpP?=
 =?utf-8?B?R1dndE9EelBXTW92UTZpbW04Q2Z0MEZIckZOVXpFTjFUNXpRamI4Wjc1R2ph?=
 =?utf-8?B?QlRuY0pYdmtZOFVKalU5OThpYXcvVTJVNjZyMFlSYTNPTmFZZisyTjBZTUlh?=
 =?utf-8?B?K3JQMlZlSmpqdTI4SUVDbEY2YmdNbWwyUCsweE96cGZDdVhzMnpYOWt6VE5L?=
 =?utf-8?Q?K65vFW7pHg2HkYGs=3D?=
X-Exchange-RoutingPolicyChecked:
	G+sVasuLh75AehY38YToev9tQZZTFLgOFWFNzDDxnM+Zpy6wA/hl+ljdekGXbVnY8DWFAMK74d5nz+Gxv2pVvxYGRec2jqZgp+4xNJ7T5FaihPM0WrN4GXLqaSAGMEMgpcae/pYsbvH3IDjCGKfMJ/qsHBbrvG0M6ccc2N+3bcv34LbPfY2bYEagIE/deXAokAlPsMeE/Ydnz6EXUiJcevGUQcIiq6UQ+mm12mlhDDGg8YOmIqvjEDCfa7H8pgEPumQxw9m5EyMEUZzy6RF+IRX2T+t/+ZkWOmtGr2TPfNgl6DuAMl2gr/iFZdLWe/ZeNlmWKjn4EKsKU06F+VFB3A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kXDJ8fCm6OPcqyMOfLkrwgDGgM+E3TglD+mahk25g91w8n5Hmv+j2aHeHNiOHvyJp2l8WpllOHXi5z46ZlxBfvFX/llQyBi+2nh0uhL8pi++ESwwBjr5NAQvyNCWihwUEJFCgL0dOcPVXoaBBOU8EEfsAcyW3fZ4WHX+1m7pkvBri+q12weRIoGbFL2Gtteztn43MciXP8+Nkm5OELD9s7GJ1h1031BuW4Isrjo2C7uVE/7crY6ZfEwUxjZypPHXzOOLaNw2L2imNj1SsArtSBruPip3KFJEN/LECs52vwDXM9X3wwvlphF9rvFwf8d7qQyJykZaaPUVILWcn6ilfsDBSuoausl2BUSO4Bezf2Mi++iQYrCvZzmIlMTgznHdHJusu/v4Oc9Yp9UjuPpZwAjWlOEqkQAq3lmYqKf6309XblSBbJLiejrawu/Hz/c5TzpC4P7ndPDgfP+oOOb2pjH+MfLAyE/VMvZIOtBPd739EMsAZE/RwYeWxn9jDH8n56TUAbDSvHvrWlTRkFOaiGrqvUOhVGHMZGhiMnqRgsrisN6lmvdiLAUK7EMOx5ftYAWQd9vR1ru403iL/mulVAmglTdMMCqZ3SVu/z9C5mE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a33dcf-860c-4615-1088-08de8c1a5089
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 16:02:58.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAijyE21KHQFkp3KrdsxoF2MZTI4AcOpoOWYVhsvYp+10wurdGJ41IiqFtNid4krPWqiG0iT0qPqBLWpKM6r5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603270110
X-Proofpoint-GUID: 3v3NJ3YCGqbxuIQotk9ONOHLCaPDPZzM
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c6aa36 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=eEJmrmIP_k1uEPnyfaQA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12275
X-Proofpoint-ORIG-GUID: 3v3NJ3YCGqbxuIQotk9ONOHLCaPDPZzM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDExMCBTYWx0ZWRfX3dW/J5zSh57R
 7TyJ9dyM2wQI4C9x5WX5l5DVdIOky2izQlBU1mpd1ccqfUMyimp7GWgDYCiD2HlrxbgBGIP8Uof
 4ykppFqK0Qubqsm3XH+LMBVIn6ZaoKwMpdSldg3V/vmmJ9yFUVPZy8T+xpGPd1DHa860Dyc0ANB
 5gO7hUdPZVvhMCmMLzx5TYiL8Is5z/SyX3iFNBgkzCqO22++6kgjQjJBHj49ZyDFNpFaxTDdPaY
 R5xhx8LJNMyIdiixWCgkl+PAwvAOzXhleZzeGJOpz1WNpWv3iGvf6UppMhSmOqVPb+MSwdKteFj
 tJHynaABWbiOeuYyD3jwW9d6OPpRe0V+5sARdvABm2rPpePElzn4pcgYNd5B9wB0zlCB8inWnEc
 beSrnzyXOunkfEbDLVY+Wf2qrN6E8bRefGvsY/Wc78puepbNB3iGxoA9RibrS/b3r340MBkM6JD
 5ps2PJGm9WPKhF8BBAipIJY2yZvMiQYYmBDX1ieY=

On 26/03/2026 01:31, Yonghong Song wrote:
> Current vmlinux BTF encoding is based on the source level signatures.
> But the compiler may do some optimization and changed the signature.
> If the user tried with source level signature, their initial implementation
> may have wrong results and then the user need to check what is the
> problem and work around it, e.g. through kprobe since kprobe does not
> need vmlinux BTF.
> 
> Majority of changed signatures are due to dead argument elimination.
> The following is a more complex one. The original source signature:
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   typedef sockptr_t bpfptr_t;
>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> After compiler optimization, the signature becomes:
>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
> This makes it easier for developers to understand what changed.
> 
> The new signature needs to properly follow ABI specification based on
> locations. Otherwise, that signature should be discarded. For example,
> 
>     0x0242f1f7:   DW_TAG_subprogram
>                     DW_AT_name      ("memblock_find_in_range")
>                     DW_AT_calling_convention        (DW_CC_nocall)
>                     DW_AT_type      (0x0242decc "phys_addr_t")
>                     ...
>     0x0242f22e:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>                       DW_AT_name    ("start")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f239:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>                       DW_AT_name    ("end")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f245:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>                       DW_AT_name    ("size")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f250:     DW_TAG_formal_parameter
>                       DW_AT_const_value     (4096)
>                       DW_AT_name    ("align")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
> 
> The third argument should correspond to RDX for x86_64. But the location suggests that
> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
> the parameter value is stored in RDX or not. So we have to discard this funciton in
> vmlinux BTF to avoid incorrect true signatures.
> 
> For llvm, any function having
>   DW_AT_calling_convention        (DW_CC_nocall)
> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
> and 875 kernel functions having signature changed. A series of patches are intended
> to ensure true signatures are properly represented. Eventually, only 18 functions
> cannot have true signatures due to locations.
> 
> For arm64, there are 863 kernel functions having signature changed, and
> 70 functions cannot have true signatures due to locations. I checked those
> functions and look like llvm arm64 backend more relaxed to compute parameter
> values.
> 
> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>   -pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
>   +pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes --btf_features=+true_signature
> 
> For the patch set, Patch 1 introduced usage of DW_AT_calling_convention, which
> can precisely identify which function has signature changed. This can filter
> majority of functions where their signature won't change. Patch 2 did a prescan
> of parameter registers to accommodate some cases where the optimization could
> happen but didn't. Patches 3 to 9 tried to find functions with true signature.
> Patch 10 enables to btf encoder to properly generate BTF.
> Patch 11 includes a few tests.
>

I'm looking through this now, but FYI the test run with clang kernel build
is passing now, great work! The log [1] shows 23 additional functions for
clang kernel builds (see the "Compare functiokns generated" step). Interestingly 
it shows a few additional functions for x86_64 too, I suspect a side effect of
better handling of parameter location info, but I need to confirm:

### Compare vmlinux BTF functions generated with this change vs baseline (none means no differences).
1345a1346
> void __do_notify(struct mqueue_inode_info * info);
4994a4996
> int __vxlan_fdb_delete(struct vxlan_dev * vxlan, const unsigned char  * addr, union vxlan_addr ip, __be16 port, __be32 src_vni, __be32 vni, u32 ifindex, bool swdev_notify);
15185a15188
> int devlink_nl_param_value_put(struct sk_buff * msg, enum devlink_param_type type, int nla_type, union devlink_param_value val, bool flag_as_u8);
18862a18866
> struct cpio_data find_microcode_in_initrd(const char  * path);
48240a48245
> struct dst_entry * xfrm6_dst_lookup(const struct xfrm_dst_lookup_params  * params);

I'll push the CI change to enable clang builds so we have it by default from now on.

[1] https://github.com/alan-maguire/dwarves/actions/runs/23638670169
 
> Changelog:
>   v3 -> v4:
>     - v3: https://lore.kernel.org/bpf/20260320190917.1970524-1-yonghong.song@linux.dev/
>     - Add simple prescan of parameter registers in order to get true signatures
>       for those functions where optimization could happen but compiler didn't do it.
>     - Do not create a new name (e.g. "uattr__is_kernel") with malloc at parameter_reg()
>       stage. Instead remember both "uattr" and "is_kernel" and later generate the
>       name "uattr_is_kernel" in btf encoder.
>     - Add comments to explain how to handle parameters which may take two registers.
>     - Fix some test failures on aarch64.
>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20260309153215.1917033-1-yonghong.song@linux.dev/
>     - Change tests by using newly added test_lib.sh.
>     - Simplify to get bool variable producer_clang.
>     - Try to avoid producer_clang appearance in dwarf_loader.c in order to avoid
>       clear separation between clang and gcc.
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20260305225455.1151066-1-yonghong.song@linux.dev/
>     - Added producer_clang guarding in btf_encoder. Otherwise, gcc kernel build
>       will crash pahole.
>     - Fix an early return in parameter__reg() which didn't do pthread_mutex_unlock()
>       which caused the deadlock for arm64.
>     - Add a few more places to guard with producer_clang and conf->true_signature
>       to maintain the previous behavior if not clang or conf->true_signature is false.
> 
> Yonghong Song (11):
>   dwarf_loader: Reduce parameter checking with clang
>     DW_AT_calling_convention attr
>   dwarf_loader: Prescan all parameters with expected registers
>   dwarf_loader: Handle signatures with dead arguments
>   dwarf_loader: Refactor initial ret -1 to be macro PARM_DEFAULT_FAIL
>   dwarf_laoder: Handle locations with DW_OP_fbreg
>   dwarf_loader: Change exprlen checking condition in parameter__reg()
>   dwarf_loader: Detect optimized parameters with locations having
>     constant values
>   dwarf_loader: Check whether two-reg parameter actually use two regs or
>     not
>   dwarf_loader: Handle expression lists
>   btf_encoder: Handle optimized parameter properly
>   tests: Add a few clang true signature tests
> 
>  btf_encoder.c                       |  32 +-
>  dwarf_loader.c                      | 546 ++++++++++++++++++++++++++--
>  dwarves.h                           |   3 +
>  tests/clang_parm_aggregate.sh       |  85 +++++
>  tests/clang_parm_optimized.sh       |  63 ++++
>  tests/clang_parm_optimized_stack.sh |  63 ++++
>  6 files changed, 763 insertions(+), 29 deletions(-)
>  create mode 100755 tests/clang_parm_aggregate.sh
>  create mode 100755 tests/clang_parm_optimized.sh
>  create mode 100755 tests/clang_parm_optimized_stack.sh
> 

