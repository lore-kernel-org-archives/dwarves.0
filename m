Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1B36B919
	for <dwarves@vger.kernel.org>; Thu, 23 Jul 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826844; cv=fail; b=kHN7W1exfAutcL9muUrSEflW99SlUuM2vbbTebYQPmBpVEkEgThYRiJe5hG1NFf0eIlLjjzSQwBb68TjquW17WLs0oGqAIghx4Tz95R9DmFV70UNflsPSbyQNMZ2d+EcEmnQ9+fR2kPDejXAcyFrvT1TVNHLP2dAb9OAf3Tlt78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826844; c=relaxed/simple;
	bh=Bg7w0ydFNaN1+7U46lutaCMu8g3v2/u5Q3RWac09Sx4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GvpurVjfuETRjr+mVbSpPiwUrKquw/xIkjTa6EJLCmaHJTBuzRS7QANKlZKNLTc0dKZUuC7YqRSgxGat74bCJWVcl1kfUV+GlOg50RVU3xXzMHtL9A8RTtJwnVV+3PL/N1Oow0KHEJCZGxxpql6HeI0Dy2VDR7dMxjcn0N/Abiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qBw2cTR2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j4/SpG9i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qBw2cTR2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j4/SpG9i"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NFvQMK1441115;
	Thu, 23 Jul 2026 17:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tQ2TreCszqveEily2iEGs8jfMi7bkPbmZQDOWaBuFmY=; b=
	qBw2cTR2mYEyXP8WdtGaH2NK7BDCyfLFFi4IS32R4TEwgR7mfFKujbBqB67fm4Ls
	ch69VHOu1R0H2AVoWETJGWOcWrRnKtepfO9Fg5SoZioWQ8vnXrrohysDDOEVWVjf
	xPHpkrScJXPJwyWOL5t6xY9Ch8T3beQEOUWdndzs+Q3PZZx/Xls56JmumN9N5p/q
	tqpHKBYleMH+IJcBkEJGV0SPPawuKIR1hwJp3t9Z0OqO2qn3AIGz9c9fl627c+Dl
	9bimRAAXkx22+jRoCfDOhWkeZV3NLlIYs7nAuP5jMK2OKM3v6tBxyKqWqrZoATNC
	1vE/Z7Mq6VSjNZ0K+cvT+A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1sqqe5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:13:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66NHDaTE017663;
	Thu, 23 Jul 2026 17:13:47 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxsubq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 17:13:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkknAUC38K6dL6w0kSHJ6LoPqrxPl1ERQby9MqoTLYKZFrZDbDBIQzbF+KZOpOPp84vWacx1nF1MRFGRc8JgTiC9EtmApGrPCJ833vooeSRah4gCJIxa1Dw1cLck4mkz/Rj35HZVqBdL74iDhO7prIBnt8q98BmQxlPBiSapNgEY7FJo8QyHB/WMcMQ8A6oJ83r5QZkk2VAQDMjYReVZWVHLP2LKE4vEeYYhS4ZzqEPmsYyflrud0JIk6Ew+uzxrkh/eWiV4X2ZtXmCWrUGjS5nUY8EzbYtO2evkaNimY7+BWMaSykGlclMP1vNuk/3xsX8WmQzd2EHA0UviV7O1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ2TreCszqveEily2iEGs8jfMi7bkPbmZQDOWaBuFmY=;
 b=BHVPfw/PzIHTxHizbVyS63DUbu7S10EPZXWPYwRwxZ/bxLibyuekwVuLhvKia9R7z+oFklUP1B6c0ERlj/jomI/ayp1cDUTdOtK0erHa5FqUAEtGC74F5UowoWxBc9vUf7/7NA+uOxR1aCHgLzZgD3lGeeeea9GDlHBkh00I7mNP1vLTth3aEPw1qE/Tr9+43WBHfLx537u5iztwQbSFD8iO2w5hX6M2QElPXiNljIN73025EOwO++faVcxPTqZnLql4UAtL33dqE0nn6hhBHGhIUZq/skZSqsdtKI+63YrMHsbnXFHGaI/OfVjU1bWU2BG2OJ01M8czgQaohW1x8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ2TreCszqveEily2iEGs8jfMi7bkPbmZQDOWaBuFmY=;
 b=j4/SpG9iLq7dWlVUlpnNGa39zIkr89VS7M6KlPdOsAEmPUKEVKBOOVVbEwGg+VgSL3THI3hd3tw+saF1+Tii5/+uS+qqln+44m9P6FeQcaTPPice5u7nhYRrKfjmXh57EHkRguXif1W6gL2vlEEaU4vUz0EAFVzTK9VtbsxNd+I=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH0PR10MB4693.namprd10.prod.outlook.com (2603:10b6:510:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 17:13:16 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 17:13:15 +0000
Message-ID: <97b948d8-e208-4c5c-bcee-0ab7b9e32f51@oracle.com>
Date: Thu, 23 Jul 2026 18:13:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] man-pages: improve language and formatting
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>,
        dwarves@vger.kernel.org
References: <20260713221504.393412-1-stepnem@smrk.net>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260713221504.393412-1-stepnem@smrk.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH0PR10MB4693:EE_
X-MS-Office365-Filtering-Correlation-Id: ff911a50-f45f-4166-5495-08dee8ddaf0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|3023799007|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6Zg5PHNuBL08EJxDlnt1Per9A9MuBLxwoRHoY2lj91DurRm3NjVZcAYoOo7OQAi9ohHhf6evXt5dDG0FOSUyGMOiywE8MFlZBc/NGsTSqcW0vlHkboDzEsgQDSwz12MaGV5jOqsB8/f9D6jTCkjFz3FWYM95tGTMCTC/QAar7rm1Z8fFFFbkdM8r02n4tj/sOUBQjynKEQ05adPa8wi5L7fZBECcZNJ669dzoUwgGuRT0ov8SQ5uHarrZdIz4MsD8f6DA6cRM4yhU+33DbcH8GoT6ZxBuYoxifvsCVKMW0vWjlBc0wFmQNfduAcoqNriao10nWuhzSq5BXXzdE00j3Zz4QMKdkkpIXKqJRSxQBZVfDBMJo9ccTtvXoAkd7BglE+SeUKX2JDUl0ozR7DqLUy8e8vr7rxpLfRxNDdPXwZE/ZXG8KRasUqtjrasREnhaNfb0gh3N9dyhSO+8q0tL5jZkmopQy2WASKY4a4bIyzwgn8Lkif1smtvwVHBa80sD7WLNDYO/S+KeXfRcvSiuI95qrEmDOmR1jk/c1I4jWnTEvVIDVW0dWMssXhYqp2bGCyC4QoNCoQY1h6TjbEGLkU6H5jplXqfKhkJVyvz+pBs15OBCjXXVn4wXtt0ylhW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjY5U1pSckdNNURnWjV6d3RPZVlleTlHZThXakk3dXRVK1NFTWo3bHJSdVpV?=
 =?utf-8?B?QjZKbEs5RktiTzFuWXJyQkR5c3FNSDkrQmNoYkJQQVVZcEZuYlZaSVRWWUFC?=
 =?utf-8?B?VU1BOStFaDgra251TnlIUXp3QkJaK0FYcld2QW5RODdjNmJYMkJydU1LR0lw?=
 =?utf-8?B?S2tIZnZLckxZY2pJSCtQNFdLYnIyR0VZdGRrb3dWeFhhdCtKOFlTcVRkZzJN?=
 =?utf-8?B?VGozSmJDWG5ScUQ0dW1BMkxjWG9uV1lGUmdQZFNmMDRSNnYyVzhFYVpMTVEy?=
 =?utf-8?B?N2NlZm1pTVBkbmdtcnF1bHRYSHBocytpd1VRVkREc3FwMmwyRGZSY29oNlk2?=
 =?utf-8?B?QzZqMmxsTGZrVU1CdThsbTJZVEFuRFZ6TmlFTnc2TUlqdlliRjRla3FPY3M4?=
 =?utf-8?B?TzJ0elF6WGp2aWZaTE1xYXVROHcvYStjaWpjUGJYcDNLOHFvckJKamxWdDlh?=
 =?utf-8?B?aGdMcG5xVURDT2doT3djQU9YNld3UzE1ZFFqQmtISFB1UlFqSHc4amhDc2h2?=
 =?utf-8?B?UEZoOXF3RjdhQVg2OTV2TjJNZnJBQTZCK2p5dnlTTXdrWUtkWDJPOEY5MDFD?=
 =?utf-8?B?bGl0TGVQM2dYMmNPYnc1Zzd4MVZBa2E0SXdCOWRwcE9uNWFWQmQzWU1PRzE4?=
 =?utf-8?B?aVViY2dwam5rdGNGYXNGWFo2RHpKSGlvdnd5aGh0U0p3bzBGY3RkRit6REpI?=
 =?utf-8?B?ME1kZHZiUS8rR0MvS3FJclpHRXNhYVdxM0E1dWV4YnpSbUZJeis4N0JsY1JR?=
 =?utf-8?B?NTROVGN6WFN4MGpFd2ZhVjdLWGV4dmo0VkxUc0FPd1U1Y29aWVZqNGNta2Z6?=
 =?utf-8?B?dFlRTlF6WGJnajlNN1Jsd1MrYXNFb0IyTmFEQStvam1aU0xEamo4SmJNYkxQ?=
 =?utf-8?B?aXV2TEpCQkhWQ1h6aWxjTXJaZytBMDBrbTg3WGEySlJVdzBmZDJvalVieStv?=
 =?utf-8?B?M3NzMGJaZGp3U1g4c0g3LzFPdUhtTHVqbHVjOFl4djNNeUtwYnhTMGlrV1Fv?=
 =?utf-8?B?cHZJdXJoWk5UUGFPSk91RzduV1UyMUhDSktZQzBwemFwY2Mya1A1a3VSNm81?=
 =?utf-8?B?anhJZWFjOUVvY28rRGpFaWp2bU55c3hHcWJ2dlFBeUZYV1p5dFV4Rk9rYzlD?=
 =?utf-8?B?WkZqYnArQzZXRm9MWEQzdzdyOEZIRjF1S1hYVENCVnRoYldSYUlsTE93M01p?=
 =?utf-8?B?aUt1T3NHNVhjS0tCMnV6dndVZnpKM3dwaHozOTZ5aWdHdGhudGtSMGdsV1B5?=
 =?utf-8?B?aG9WZ3dDQ1d3WTAyYlZHRHdCU2ZoenVIRXJYVVBWUlpmNHZ5Y3YxSkI2Qkda?=
 =?utf-8?B?Y3NTNGdRMHNNTGg2L011akFwcFM5K1lJVzhDN3dhSEE3eTZ3R1JuWTZHYkg2?=
 =?utf-8?B?RkdGYUlzS05kdFVGSGgxRmZ2NW9CTlJBYi9zTmhGSzlBRCthbkJJVkl0cGRP?=
 =?utf-8?B?NlJzK1dRVjh1VXByelpzeXkvdERNMUdacDBJcEphRFFtdWZkQzQzSWcxMmhj?=
 =?utf-8?B?ODJqWnlZTktpaHFadi92WElxRHpqenlaNjdOVWlkSnFMYU5jSFhDVXBMdGxv?=
 =?utf-8?B?ZFRhdEVGSWR4RWVpS0dUN1dKYUxlOEdjQ01RUWNnbFgzWEd1VEl3YUNTc25w?=
 =?utf-8?B?bHY3dDkrUjlBbDNhbHNObDVFTE84NGdGWktrWHI5ZHBjOVVteDlUYTltaTJw?=
 =?utf-8?B?YkJ0ZTdnN3U5SVYxaHVoVXBKMHJhMzIvOEY1ZXgwV09mVElSVXVkbVMvNEJw?=
 =?utf-8?B?Q1dsTkpOeEQ3Rm56aWtYZnM4R3VUWmVLUGg4dzhKTldtdDgzTzZ2SWhIdU5w?=
 =?utf-8?B?WDJUaGhiUDdobGpQS3ZpZUJlUWxhR3ZNdnpEc0Y1bDZ5Z2IxMVNtelM4SHh4?=
 =?utf-8?B?VDlKeUsrdUw2bW1CTHlKY1ZmSm50NENFWStkM082U1luUktmM3pEeUhXeFBt?=
 =?utf-8?B?S2NMdFlvc0daWjFwZi9INnZwR0xGNHlUNmJXRzhZSjhLdkZlMnNsc1ZpM0tm?=
 =?utf-8?B?T0pROVpXSU9oZTEwMXIwY0I0YU10MGNnRGlKWVRhWFIzb282bEtaQTlpT0Jt?=
 =?utf-8?B?NzNEcm5KVERNeTB1Z0dGalgxK2RNc0R3U0xrWWF4dklnTys4Wmo0aXlHSkFU?=
 =?utf-8?B?ZEcxRXhrWTNKNjdQbjVVUlhaUFMxODRaaUFxYlZnMTB1MFJESWtZYXo4Q283?=
 =?utf-8?B?azlWN0oxY0NCTmxxaUVFdWxJdUIzWW1YTVpvNHJLR1l1bEJxTGlzQ3A0ZUor?=
 =?utf-8?B?aFluV1NJaElVY0tib3R6ZmVma3pTRlNrbUtWNm9MNFRFV0dOc0cxZERvT0RH?=
 =?utf-8?B?SHJUSFo1YkJVNmkwOWE3ZzIrV2QxS2RMZFBMUWJxVTRsWXpyOWNidz09?=
X-Exchange-RoutingPolicyChecked:
	fEVq/xOAJaRhf5+eGCAJfbNPCip7Tj6IfZ9aTFfvPmff/gPAW4Pj2BVHmCWoFFLzjkgpZ7TSYlKiEbStQJcT611ZJrtFkIUwwC20v7qKehuMoj5eokn+zjgmVZjwFzMtSAmKWcZlXC+/+yZ1bkSYMT7gWzBKkXHdh17KbxDw4ee4DFBPSlLuxuVKPXbNllcmTVD8JK+h5A2QO/7kGGjOx08zUjefwoI1xFhZVopRJPnNAyCXG1sK/w+BHa6lDUotZKqqsJXk2VcMW+fuxaOfVGEqSIRns5Cu9yANGTyshu75TNUYyQexVz1Pa0JptIK0ljyNPBjhfPAqjG+/o2c+wA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vlQf1OIsZbLm5CGC0f0JoxHBSzvvQnKVpwAFFl6uy5ZC4vGSNGdyQ6Nvg/jMaQKwaq2bS+0zTdU+Rr+/KmZcBOKd+S+BvePYsWKT8F2B0uWBk5BVArJZIOmzD2yUkn3Knt0CxM9+qTAvtbmQfJl7fpUDXCEsI/LsQQu6yIRo7ZtYuChNRTSMeN5oPhbFP47v58Ns6ZMoxIMQenp5EbyUtCex9RA2fT9ffYscI33xfxD7ern7euT/h0DaERMkQXYQIAkq8AQM/l/989qr21hTy26kv15SDFFkJfhP+GEXginITj5AgEYpsiwnZV3O3ntI42SUT1fkh26h5LOIyadczL9hkFhltqRUHHsDPxqFueKELohtH0jyKJfmVVBjAMeQaFZVCiIwFFeYf/WKsuTjFMo0e3+WrN2jmCMMQUJ+6xvNsigjYBE2RULer2C27BTUEcKXTuxLPAl1vk57eJiTxkkrZglw09HjjdzdDECeXQlEgU6w0axMNmuLJ5gVSFIdm6tOjOoZC5mPdNlMVDAR+o+5kM0TjREKeJrP21ovaGMRvEhQ9o8AbPTgpKWUuoDD0/FZko7f5ehgFG7g7vqy1uTTm0aE5QoE+GWCrFoRD1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff911a50-f45f-4166-5495-08dee8ddaf0d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 17:13:15.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGaTADPLIsHjyxlNpTpY/+EPjWgO/2Q405F04UUgZzKRTRdLlK9LHxpGn0K9y2g1t/IVvnOoZG1H5+y73mOINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607230169
X-Proofpoint-ORIG-GUID: A0tsHsh-UtAtLmGXnsTIiuubh5eVyr4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2OCBTYWx0ZWRfX/kuH53Pn5vUA
 aGxQrl+KJdT6uF0QF9Qbq/ZL4wLBkUYySVO+aHGSAdGN3bZDTDP26/UxD10+F3qxh6xHfNOolW2
 YfYaegAtWYnyIjVdLxvmcY/92zHebDSij2Uc5v5C3M4wqnnpriFHeiwt3j/PyW3upsHqoy29gUW
 v6xKmPXnCbUU4uJk1YLiDCAcTpcFCkKdwGPQecHXaqtQzXkEV3KizrzoeJwRfpZDzL5qoZ69sGP
 WwW9OEfNa3uWujtgo70CgztukSQFd9wZfzEOCbdlF3SaR/eBlRli9lWrPfswbX/LFUbeYLt8F8M
 gnNbjHDvOSnhjad2NqSR84RMxrbAQUGCqmhO+1Uj3K7QIRrKPcZ+a59/GznZioFM84rfj0MJuaJ
 pXN0a9iWZMB+CXvQi+/qGiaTKkD/062Gzt9x6jGpsDx5I+/P9yV+JYK3U2yvXZw91OhHVS+DfDX
 HGl7WjZZ1tyZloIJejoOtErNt+Z6IqD0rMrUTT+A=
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a624bcc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=aU6gODHfAAAA:8
 a=dnyXhxrFAAAA:8 a=dcdjaeNq78UnM9ohXHoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=LGewCO6yFNkZ8-qGBFHK:22 a=Jg-N2dyUoHYgGiKYQkJY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12115
X-Proofpoint-GUID: A0tsHsh-UtAtLmGXnsTIiuubh5eVyr4O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2OCBTYWx0ZWRfX4lRej75mWv/k
 20zUCKErMFn+yGM0pxAg8XqyQK5KnELTusW0up/Z5V+hOewsCOKIurTY6mBFr3YxURpfIdyTdmm
 ggDlaswET8l8KC+3To8If/pum/2YeZYbIGspOySUf2zRXFAHvgVs

On 13/07/2026 23:15, Štěpán Němec wrote:
> - fix some typos, grammar and wording issues
> 
> - use conventional formatting (imperative, no capital or
>   period) for .SH NAME summary
> 
> - start sentences on a new line, resulting in consistent
>   sentence spacing in formatted output
> 
> Signed-off-by: Štěpán Němec <stepnem@smrk.net>

Applied, thank you.

Alan

> ---
>  man-pages/pahole.1 | 154 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 95 insertions(+), 59 deletions(-)
> 
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index b1be472de2b1..21378a224847 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -4,20 +4,20 @@
>  .TH pahole 1 "January 16, 2020" "dwarves" "dwarves"
>  .\"
>  .SH NAME
> -pahole \- Shows, manipulates data structure layout and pretty prints raw data.
> +pahole \- show or manipulate data structure layout and pretty print raw data
>  .SH SYNOPSIS
>  \fBpahole\fR [\fIoptions\fR] \fIfiles\fR
>  .SH DESCRIPTION
>  .B pahole
> -shows data structure layouts encoded in debugging information formats,
> -DWARF, CTF and BTF being supported.
> +shows data structure layouts encoded in debugging information formats.
> +DWARF, CTF and BTF are supported.
>  
>  This is useful for, among other things: optimizing important data structures by
> -reducing its size, figuring out what is the field sitting at an offset from the
> +reducing their size, identifying the field sitting at an offset from the
>  start of a data structure, investigating ABI changes and more generally
>  understanding a new codebase you have to work with.
>  
> -It also uses these structure layouts to pretty print data feed to its standard
> +It also uses these structure layouts to pretty print data fed to its standard
>  input, e.g.:
>  .PP
>  .nf
> @@ -43,14 +43,17 @@ .SH DESCRIPTION
>  
>  See the PRETTY PRINTING section for further examples and documentation.
>  
> -The files must have associated debugging information.  This information may be
> -inside the file itself, in ELF sections, or in another file.
> +The files must have associated debugging information.
> +This information may be inside the file itself, in ELF sections,
> +or in another file.
>  
>  One way to have this information is to specify the \fB\-g\fR option to the
> -compiler when building it. When this is done the information will be stored in
> -an ELF section. For the DWARF debugging information format this, adds, among
> -others, the \fB.debug_info\fR ELF section. For CTF it is found in just one ELF
> -section, \fB.SUNW_ctf\fR. BTF comes in at least the \fB.BTF\fR ELF section, and
> +compiler when building it.
> +When this is done, the information will be stored in an ELF section.
> +For the DWARF debugging information format this adds, among
> +others, the \fB.debug_info\fR ELF section.
> +For CTF it is found in just one ELF section, \fB.SUNW_ctf\fR.
> +BTF comes with at least the \fB.BTF\fR ELF section, and
>  may come also with the \fB.BTF.ext\fR ELF section.
>  
>  The \fBdebuginfo\fR packages available in most Linux distributions are also
> @@ -60,9 +63,9 @@ .SH DESCRIPTION
>  By default, \fBpahole\fR shows the layout of all named structs in the files
>  specified.
>  
> -If no files are specified, then it will look if the /sys/kernel/btf/vmlinux
> -is present, using the BTF information present in it about the running kernel,
> -i.e. this works:
> +If no files are specified, then it will look if /sys/kernel/btf/vmlinux
> +is present, using the BTF information contained in it about the running kernel,
> +i.e., this works:
>  .PP
>  .nf
>  $ pahole list_head
> @@ -75,10 +78,12 @@ .SH DESCRIPTION
>  };
>  $
>  .fi
> +
>  It is possible to override the /sys/kernel/btf/vmlinux file location by setting
> -the PAHOLE_VMLINUX_BTF_FILENAME environment variable. This may be useful for
> -testing, scripting when using a different BTF for vmlinux. Used in the pahole
> -regression tests.
> +the PAHOLE_VMLINUX_BTF_FILENAME environment variable.
> +This may be useful for testing or scripting when using a different BTF for
> +vmlinux.
> +Used in the pahole regression tests.
>  
>  If BTF is not present and no file is passed, then a vmlinux that matches the
>  build-id for the running kernel will be looked up in the usual places,
> @@ -88,16 +93,16 @@ .SH DESCRIPTION
>  See the EXAMPLES section for more usage suggestions.
>  
>  It also pretty prints whatever is fed to its standard input, according to the
> -type specified, see the EXAMPLE session.
> +type specified, see the EXAMPLES session.
>  
>  Use --count to state how many records should be pretty printed.
>  
>  .SH OPTIONS
> -pahole supports the following options.
>  
>  .TP
>  .B \-C, \-\-class_name=CLASS_NAMES
> -Show just these classes. This can be a comma separated list of class names
> +Show just these classes.
> +This can be a comma separated list of class names
>  or file URLs (e.g.: file://class_list.txt)
>  
>  .TP
> @@ -121,14 +126,15 @@ .SH OPTIONS
>  $ pahole --compile > vmlinux.h
>  .fi
>  
> -Produces a header that can be included in a C source file and built. In
> -the example provided it will use the BTF info if available, otherwise will
> +Produces a header that can be included in a C source file and built.
> +In the example provided it will use the BTF info if available, otherwise will
>  look for a DWARF file matching the running kernel build-id.
>  
>  .TP
>  .B \-\-skip_emitting_atomic_typedefs
>  Do not emit 'typedef _Atomic int atomic_int' & friends when used with options
> -like --compile. Use it if the compiler provides these already, as of circa
> +like --compile.
> +Use it if the compiler provides these already, as of circa
>  2022 with gcc 12.2.1 those are not encoded in DWARF so to generate compilable
>  code we need emit those typedefs for the atomic types used in the data structures
>  being emitted from debugging information.
> @@ -143,21 +149,23 @@ .SH OPTIONS
>  
>  .TP
>  .B \-E, \-\-expand_types
> -Expand class members. Useful to find in what member of inner structs where an
> +Expand class members.
> +Useful to find in what member of inner structs where an
>  offset from the beginning of a struct is.
>  
>  .TP
>  .B \-F, \-\-format_path
> -Allows specifying a list of debugging formats to try, in order. Right now this
> -includes "btf", "ctf" and "dwarf". The default format path used is equivalent to
> -"-F dwarf,btf,ctf".
> +Allows specifying a list of debugging formats to try, in order.
> +Right now this includes "btf", "ctf" and "dwarf".
> +The default format path used is equivalent to "-F dwarf,btf,ctf".
>  
>  .TP
>  .B \-\-hashbits=BITS
>  Allows specifying the number of bits for the debugging format loader to use.
>  The only one affected so far is the "dwarf" one, its default now is 15, the
> -maximum for it is now 21 bits. Tweak it to see if it improves performance as
> -the kernel evolves and more types and functions have to be loaded.
> +maximum for it is now 21 bits.
> +Tweak it to see if it improves performance as the kernel evolves and more
> +types and functions have to be loaded.
>  
>  .TP
>  .B \-\-hex
> @@ -242,9 +250,9 @@ .SH OPTIONS
>  
>  .TP
>  .B \-\-skip_encoding_btf_vars
> -By default, VARs are encoded only for percpu variables. When specified, this
> -option prevents encoding any VARs. Note that this option can be overridden
> -by the feature "global_var".
> +By default, VARs are encoded only for percpu variables.
> +When specified, this option prevents encoding any VARs.
> +Note that this option can be overridden by the feature "global_var".
>  
>  .TP
>  .B \-\-skip_encoding_btf_decl_tag
> @@ -260,18 +268,21 @@ .SH OPTIONS
>  
>  .TP
>  .B \-\-skip_encoding_btf_inconsistent_proto
> -Do not encode functions with multiple inconsistent prototypes or unexpected register use for their parameters, where the registers used do not match calling conventions.
> +Do not encode functions with multiple inconsistent prototypes or unexpected
> +register use for their parameters, where the registers used do not match
> +calling conventions.
>  
>  .TP
>  .B \-j, \-\-jobs=N
> -Run N jobs in parallel. Defaults to number of online processors + 10% (like
> +Run N jobs in parallel.
> +Defaults to number of online processors + 10% (like
>  the 'ninja' build system) if no argument is specified.
>  
>  .TP
>  .B \-J, \-\-btf_encode
>  Encode BTF information from DWARF, used in the Linux kernel build process when
> -CONFIG_DEBUG_INFO_BTF=y is present, introduced in Linux v5.2. Used to implement
> -features such as BPF CO-RE (Compile Once - Run Everywhere).
> +CONFIG_DEBUG_INFO_BTF=y is present, introduced in Linux v5.2.
> +Used to implement features such as BPF CO-RE (Compile Once - Run Everywhere).
>  
>  See \fIhttps://nakryiko.com/posts/bpf-portability-and-co-re/\fR.
>  
> @@ -304,7 +315,16 @@ .SH OPTIONS
>  
>  .TP
>  .B \-\-btf_features=FEATURE_LIST
> -Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to using multiple BTF-related options, and 'default' represents the standard set of BTF features that are in use for kernel BTF generation, so is useful as a shortcut for testing the latest set of standard features.  However kernel builds will call out specific features rather than using 'default' to ensure that the desired features are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
> +Encode BTF using the specified feature list, or specify 'default' for all
> +standard features supported.
> +This option can be used as an alternative to using multiple BTF-related options,
> +and 'default' represents the standard set of BTF features that are in use for
> +kernel BTF generation, so is useful as a shortcut for testing the latest set of
> +standard features.
> +However, kernel builds will call out specific features rather than using
> +\&'default' to ensure that the desired features are enabled regardless of pahole
> +version and associated 'default' set.
> +Supported standard features are
>  
>  .nf
>  	encode_force       Ignore invalid symbols when encoding BTF; for example
> @@ -340,31 +360,38 @@ .SH OPTIONS
>  	true_signature     Encode functions ensuring that binary-level
>  	                   (rather than source-level) signatures are used;
>                             for gcc these are ".isra.0" and ".costprop.0"
> -                           optimized functions
> +                           optimized functions.
>  	layout             Encode information about BTF kinds available at encoding     
>  	                   time in layout section in BTF.
>  
>  .fi
>  
> -So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
> +So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF
> +encoding that (as well as encoding basic BTF information) will contain
> +variables and enum64 values.
>  
>  .fi
>  
> -If one wants to add an extra feature to the set of standard ones, the '+' prefix can be used, i.e.:
> -\-\-btf_features=+reproducible_build will add all default features plus the 'reproducible_build' extra
> -feature.
> +If one wants to add an extra feature to the set of standard ones,
> +the '+' prefix can be used, e.g.:
> +\-\-btf_features=+reproducible_build will add all default features
> +plus the 'reproducible_build' extra feature.
>  
>  .TP
>  .B \-\-btf_features_strict
> -Identical to \-\-btf_features above, but pahole will exit if it encounters an unrecognized feature.
> +Identical to \-\-btf_features above, but pahole will exit if it encounters
> +an unrecognized feature.
>  
>  .TP
>  .B \-\-supported_btf_features
> -Show set of BTF features supported by \-\-btf_features option and exit.  Useful for checking which features are supported since \-\-btf_features will not emit an error if an unrecognized feature is specified.
> +Show set of BTF features supported by \-\-btf_features option and exit.
> +Useful for checking which features are supported since \-\-btf_features will
> +not emit an error if an unrecognized feature is specified.
>  
>  .TP
>  .B \-\-running_kernel_vmlinux,
> -Search for, possibly getting from a debuginfo server, a vmlinux matching the running kernel build-id (from /sys/kernel/notes).
> +Search for, possibly getting from a debuginfo server, a vmlinux matching the
> +running kernel build-id (from /sys/kernel/notes).
>  
>  .TP
>  .B \-l, \-\-show_first_biggest_size_base_type_member
> @@ -372,8 +399,8 @@ .SH OPTIONS
>  
>  .TP
>  .B \-m, \-\-nr_methods
> -Show number of methods of all classes, i.e. the number of functions have arguments that
> -are pointers to a given class.
> +Show number of methods of all classes, i.e., the number of functions have
> +arguments that are pointers to a given class.
>  
>  To get the number of methods for an specific class, please use:
>  
> @@ -411,7 +438,8 @@ .SH OPTIONS
>  
>  .TP
>  .B     \-\-with_embedded_flexible_array
> -Show only structs that have an embedded flexible array, i.e. a contained struct that has flexible arrays, a flexible array "in the middle".
> +Show only structs that have an embedded flexible array, i.e., a contained struct
> +that has flexible array(s) "in the middle".
>  
>  .TP
>  .B \-q, \-\-quiet
> @@ -558,9 +586,10 @@ .SH NOTES
>  To enable the generation of debugging information in the Linux kernel build
>  process select CONFIG_DEBUG_INFO. This can be done using make menuconfig by
>  this path: "Kernel Hacking" -> "Compile-time checks and compiler options" ->
> -"Compile the kernel with debug info". Consider as well enabling
> -CONFIG_DEBUG_INFO_BTF by going thru the aforementioned menuconfig path and then
> -selecting "Generate BTF typeinfo". Most modern distributions with eBPF support
> +"Compile the kernel with debug info".
> +Consider as well enabling CONFIG_DEBUG_INFO_BTF by going thru the aforementioned
> +menuconfig path and then selecting "Generate BTF typeinfo".
> +Most modern distributions with eBPF support
>  should come with that in all its kernels, greatly facilitating the use of
>  pahole.
>  
> @@ -678,7 +707,8 @@ .SH EXAMPLES
>  
>  .P
>  OK, I know the offset that causes its a 'struct thread_struct' and that the offset is 0x178,
> -so must be in that 'fpu' struct... No problem, expand 'struct thread_struct' and combine with \fBgrep\fR:
> +so must be in that 'fpu' struct...
> +No problem, expand 'struct thread_struct' and combine with \fBgrep\fR:
>  .PP
>  .nf
>  $ pahole --hex -E thread_struct | egrep '(0x178|struct fpu)' -B4 -A4
> @@ -835,8 +865,8 @@ .SH PRETTY PRINTING
>  (variable sized records), that the 'enum perf_event_type' should be used to pretty print the
>  numeric value in perf_event_header->type and furthermore that it should be used to heuristically
>  look for structs with the same name (lowercase) of the enum entry that is converted from the
> -type field, using it to pretty print instead of the base 'perf_event_header' type. See the
> -PRETTY PRINTING EXAMPLES section below.
> +type field, using it to pretty print instead of the base 'perf_event_header' type.
> +See the PRETTY PRINTING EXAMPLES section below.
>  .P
>  
>  Furthermore the 'filter=' part can be used, so far with only the '==' operator to filter based
> @@ -845,7 +875,7 @@ .SH PRETTY PRINTING
>  .P
>  
>  The 'sizeof' arg defaults to the 'size' member name, if the name is different, one can use
> - 'sizeof=sz' form, ditto for 'type=other_member_name' field, that defaults to 'type'.
> +\&'sizeof=sz' form, ditto for 'type=other_member_name' field, that defaults to 'type'.
>  
>  .SH PRETTY PRINTING EXAMPLES
>  
> @@ -975,7 +1005,8 @@ .SH PRETTY PRINTING EXAMPLES
>  .P
>  This uses ~/bin/perf to get the type definitions, the defines 'struct perf_file_header' as the header,
>  then seeks '$header.data.offset' bytes from the start of the file, and considers '$header.data.size' bytes
> -worth of such records. The filter expression may omit a common prefix, in this case it could additionally be
> +worth of such records.
> +The filter expression may omit a common prefix, in this case it could additionally be
>  equivalently written as both 'filter=type==CGROUP' or the 'filter=' can also be omitted, getting as compact
>  as 'type==CGROUP':
>  .P
> @@ -1073,7 +1104,12 @@ .SH PRETTY PRINTING EXAMPLES
>  $
>  .fi
>  .P
> -Some of the records are not found in 'type_enum=perf_event_type' so some of the records don't get converted to a type that fully shows its contents. For perf we know that those are in another enumeration, 'enum perf_user_event_type', so, for these cases, we can create a 'virtual enum', i.e. the sum of two enums and then get all those entries decoded and properly casted, first few records with just 'enum perf_event_type':
> +Some of the records are not found in 'type_enum=perf_event_type' so some of the
> +records don't get converted to a type that fully shows its contents.
> +For perf we know that those are in another enumeration,
> +\&'enum perf_user_event_type', so, for these cases, we can create
> +a 'virtual enum', i.e. the sum of two enums and then get all those entries
> +decoded and properly casted, first few records with just 'enum perf_event_type':
>  .PP
>  .nf
>  $ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,type_enum=perf_event_type)' --count 4 --prettify perf.data
> @@ -1179,8 +1215,8 @@ .SH AUTHOR
>  Thanks to Andrii Nakryiko and Martin KaFai Lau for providing the BTF encoder
>  and improving the codebase while making sure the BTF encoder works as needed
>  to be used in encoding the Linux kernel .BTF section from the DWARF info
> -generated by gcc. For that Andrii wrote a BTF deduplicator in libbpf that is
> -used by \fBpahole\fR.
> +generated by gcc.
> +For that Andrii wrote a BTF deduplicator in libbpf that is used by \fBpahole\fR.
>  .P
>  Also thanks to Conectiva, Mandriva and Red Hat for allowing me to work on these tools.
>  .P
> 
> base-commit: b9fa3ae313589f017f6fad8aaac414f29ce879c5

