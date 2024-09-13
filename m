Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5571DA626;
	Fri, 13 Sep 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234514; cv=fail; b=S0mDfhE1JVzmD7Sb+/cJVa+M8ipkFF6V7ed59eKSOVbx7xxVD7fS4eyRRon0HNyqxElZx/yUUd8INshUU8oUVjiPYjPuMA7/PVE/ENwzbnIe03jlo+pts6hve7r4HsMmrpUTFgwpOUrNCDagpYAyuowDUwaNfNtsSoqF4X3DRAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234514; c=relaxed/simple;
	bh=1Mq9UocvW97c89CitheWBDd1LE5YsjRo9FT2q69o/hU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2sz0gu0WOWGdiBGNcZgIxNdKc9pr/w+tv0NIB4fIkQVHoV9nq3qTMyW1k5KOES34+E65PN4gVhQoZi2tLxqCZShapA8dPwO5Op2M9Eosl6JFC9G04l04864UJSdgnOiIKhYaFcLK9LG8hTe21azooJmUS9Ds3LqtnEdA7+F9Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WDhnqWTL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LGO79fVL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WDhnqWTL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LGO79fVL"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YKT8029026;
	Fri, 13 Sep 2024 13:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=jGM6A2HXejj1zkbK1zCSYhphAji/MSVikrUca5udvbc=; b=
	WDhnqWTLbitoJAPKN9Q7c1LDNzIWqOzl+mSiZTvkos6QkoTm94wkl7aM/IIyKQms
	bVtdQIs3viJUEFSAHtoIdja1TSdc/pLrafrFSRh7GvsTjibW3U0qDdHjlndLtl33
	/5lpRkTkh6lKogPmJg0IDnooxJud5cxMdnNLFgwv2lV/WmfYkemBLQTuzk7j0CI8
	vJM4OPBcn2H8ExWDtSNcNvnDobUz7/P4xzNX4cZ73FY+7jwtYuXq/VJL/PEY8z84
	t9My7RDJWFYqhEMm9KVg9z8zrOO1/VpTRZqNj4LGwaLBxIbfVkNRQHrn746FSL2p
	50TVKVQM6/susjmlgR7q3w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde0dpx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 13:35:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DC4tWb040800;
	Fri, 13 Sep 2024 13:35:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9ebqvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 13:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh8tmEFzDJlHutiqZ5hmUdbGO6MQFjGjBGBmA51E3gTNptmgLAc5lLOuAAlq32gfvBW73tnZQYyK/s7ZiHD8BtXyGljZ/mMxJWizB58SbAhEf+YmNQCRPN2vZCC/wLNzEaSx44wvsmiuZKIlrYxgQta8dGiSLmOyhozINGfs0vEcREl1ygjZG4QDrlG5bYKJizSqqMiUkfxjBu5KXMZed3QnikHCobTUOj9JztT+lgmvgqBtFNIHDWW1SWWCqulFYSpz+PH+GvAYMv8rO8xDUWYnmWH3e0zTCz+YjPxcQonZG1q0+3CHJKtYRGGSIBTPmP0Wh2/T2Tb1fIDi9F8s+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGM6A2HXejj1zkbK1zCSYhphAji/MSVikrUca5udvbc=;
 b=bVO3jDZ9dIbKoafAiJIEOjOJHJXOn7qefVQKm3rey9FHHuWjUZnSlUeMSr8aU0GSglarUUqYPUPQyn+KphlxdwovyM8r87znsvU3Gf8oYcS7s88fnNvjlOVdR7GlP16afdIbCnUAGHBqf2+CYGSiHSXvuK465fKMK/OAmyrkFjJvgPVgb652w9jm0A2BToewWMPDq0NahIv5WUfvWjkeATmqBLCNRLd/o4hGo99vzu1NXzXQDvJ1srWUo/7lZT4TyXsUmhwlp2r44MwrpViZLRQQO0yJwQo08FGr0BYu+wJ6z80sVPnqzwUXpKngC/nDHhhpFexV39PSVeRd1YduBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGM6A2HXejj1zkbK1zCSYhphAji/MSVikrUca5udvbc=;
 b=LGO79fVL0RQg5FTZ0YhphRPCeKJ7zP3uUoQHa54OZHA2vWM9OkOUmjGaM7XZbU1OyRMZc7eeXUbjFo0oCGmiWDhJ5Q3PnQH2xjIKP/zrTAPhdyIPwvUB+jITzCAyr3i1HWJyb30zWviKLi0ajqDTakYsw6Y3S+BNohl5pd7AXwc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA3PR10MB8113.namprd10.prod.outlook.com (2603:10b6:208:50a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.8; Fri, 13 Sep
 2024 13:35:05 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 13:35:05 +0000
Message-ID: <85af9dbb-4e96-4dac-a7d7-29c83f517030@oracle.com>
Date: Fri, 13 Sep 2024 14:35:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 2/4] dwarf_loader: add "artificial" and
 "top_level" variable flags
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
 <20240912190827.230176-3-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240912190827.230176-3-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0438.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA3PR10MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bb86de-fc54-4322-ba41-08dcd3f8e0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlpuVHdnYWlSN2JvTEZGSWZVdVBTalFoZ2ZscXZyNGxoYmNTMkVwZTMvenJu?=
 =?utf-8?B?V0JuMG5qZGdCdnVkR1hpNytHOTBCZ2VvWUVqQlkwOTJKbDBTMTZ0Vnc1bWs5?=
 =?utf-8?B?Y1RHVWdqTzBUNlY3K0ZPanBwakdmU3hHa1h0ZnJ3d1B6UGt2ampud3JtODNy?=
 =?utf-8?B?djk5Smw4SHkwaGNHL2g0WHphUkxQOWJtMEMxUE43VGxveU83TFdSeVR3R1hy?=
 =?utf-8?B?K1VnUjQ5UUJYY1BxRTA4RmZTWUlXS1ZEY2hyVW5jY1FoRkFiNTF4S0xXNFpT?=
 =?utf-8?B?ODA3NEVuQWxYeWl5WjlUUWNzNFJiQ0FBV0tlODArckszQjVzWng3alJ2ZnlN?=
 =?utf-8?B?V1VJOVl0Y2RHZFZNSzJjWVNRanJYZHo0TGJWSmNNM01wMS9nZEdXUFNsVFcy?=
 =?utf-8?B?SFdxRWxUaCtzSG9HMFRSbkdOTWRJU1N6N3pWRWwyWGFVai9TaHVlVkcyaXp4?=
 =?utf-8?B?dFYrenJQbW9Kb21tSEJMZitPRnZ2cTc0cElZenhMd3Rid2NTaHhkdlRjNTdE?=
 =?utf-8?B?bm4vaDNnUGxQNXdmYkNuSStQblpkUnVvM1ZVNkFLLzRvSWRyVG14U3dyKzU5?=
 =?utf-8?B?QlpiZ3FqTG9lNCtLSVlaMkp0OXlJYjRwUWpXNjFMd3llMGRqNkwvMVRtQW9D?=
 =?utf-8?B?dFVYakNmdU43cXlDS3ZnZ1ltK1BHckJXTVZaeXR4QzBYMVhrSUNYa0FpRW1O?=
 =?utf-8?B?MXNyNWJ2dDdKdUdIdFgraDR0akwvVmtRaWY4NEFJRk1DOEpTYjltdk5jcGZB?=
 =?utf-8?B?aHlWK0g5Y3laWFVJNzJncDROV0NtUW1YVmEraE9PYVQwZ1VmY2xRWU5sczNJ?=
 =?utf-8?B?dHNFN2xURlZ5WHVMZy9YZzFhUkNpUWJDeXorT2FGRWQ5V0NFTERLTVBWNTN3?=
 =?utf-8?B?b0dtcXEwa3JLcHlLTGI3WlVwU1BFUmVsTk85cEQ5eEJONEZPRGtVTDJ3dHcy?=
 =?utf-8?B?SkV0aGpEY1BHekQrQ2g0eGNmNyt5b2g5UzBESzd1S002elFEOWNJRlg0bG1v?=
 =?utf-8?B?dTNHRlZPK3VNcE5Ga0NDZkRPNmZQZE5lblF2QTNuWUE4dkw0ZzlMaUNFT2dN?=
 =?utf-8?B?b1VlTlFuQzFpNHMyeCszNVAxTDJLaFN2OWYvdEZEa0JEV05BdGdqZ2I0Y0Jv?=
 =?utf-8?B?dk1QMm1mcXF2akJCaWY5ZlJhT3Awd2tCU1FLV1dHNUpkTWN2RUx3MU1ybDNY?=
 =?utf-8?B?VVoycUROSDJ2eHU4QkZNL2FhM1VuSXNVYUxiNEtrMTUxZ09uUzZyV3ZreVNt?=
 =?utf-8?B?NGNZTWpKWkRUMXJwZm9hNURzNFV4RVdlQ2FGL3B0cmt3L3VRalpVWjB3UnJB?=
 =?utf-8?B?bUhkQjRSRlhUc1FpZ0tLVVRaL0ZaUTE2RUdyUlZDeVlBelc2V1lSeU1jRXRN?=
 =?utf-8?B?U1lXbUJlTmhpM1A0UFdtcnVGZUZoaEhoam1vd3BqcWMzZHpqMnlRdVlGcFRo?=
 =?utf-8?B?THhDd1ZzVDVYY01iZ20wSitwclJJLy81dkUwMThSOVFwSzBvbDJ1OWExdmF5?=
 =?utf-8?B?QnNXUy9WekczZ2VRaXkyZE1UaWhhN1lrNCt5RW5SU2tZWFFxODNhalBTZlZt?=
 =?utf-8?B?Z0JvWmR4clIxaE41NG52c1doY21LYktGZ05xd21XZUFoT3Q3aklwM3M3RXoy?=
 =?utf-8?B?dFIvcVZXNWExdC9CeDhib1IxVlQ2Yk9CYk9BYjc4amtlSFVYWFNKR2Mrck5J?=
 =?utf-8?B?STVWTms3eVpzemxlT1FGZ0tISkRYVzRGWHRVaFYzMUR1NXZCMGI3U0poRVRX?=
 =?utf-8?B?VmRDa2pxYW1GejRDK0tkU1g5RnRmSElHNis4MG5ORkhlKzJQTkRNOEYzK2M0?=
 =?utf-8?B?L3dTZXh4OTd3YWExUlQ1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGVHdlRRMzJBVW9LK0p1ZGZNUElOU3c1TkxBYTFjeFpnMmpmcmRRd2kxemFu?=
 =?utf-8?B?dTV6RkVXbmN1aEFXQW1rOElBMUZpRTl4cXdnMlAycXppWEJxa21LUXlLSFBk?=
 =?utf-8?B?VzF2emErSDE4Wmd0WXRlZjBZb05HcEVKSmtlQWxuaW1paDRyeEdWLzZjKy9r?=
 =?utf-8?B?SFYyZ3RxWGRhTnNhdFJYelVqUHFHbVJXRDlIbnFsUjZFY2lpRTBoeTFlM21U?=
 =?utf-8?B?bUt2aE1Xd0Q3TFlET1dlQnJJV0RWa3hzYXMrb1FNeU1wOUQ3eVVUMkVZa3dV?=
 =?utf-8?B?MGNGZUxEWXh3TGdIZjZHOXlHMjNxVXRGQzk0eDdBZmpISGFEU1pMem1nOTdL?=
 =?utf-8?B?ZEFtL3gxWGMzYy9vNTd2OUVib3lkTW9MK2ZSMWw0bGgrWngzbVl2V2d3WElC?=
 =?utf-8?B?UWJRcGh2NXgra3NmZ3BkVU5YUERTUXFqYWhNT29lU3loTFlhdFluL0lieVEr?=
 =?utf-8?B?S2lsWTVoSEZKMWV4T0huc3EzTEx5QzFDVm4ra3lodnBtZTZLZFZ4ZUpPWTFL?=
 =?utf-8?B?WFJvUmhlT2Z5YnllSlY5WFRldHk4bkluTGRuSkt5TzhWK0ZsbU1KeGd2czl4?=
 =?utf-8?B?SEZMRXA0eDlNVThVTFc2MmRCa2lERjdHMFZleW5Vd2VPWlNRd284UnJ0enQr?=
 =?utf-8?B?SnN3RVB6UUNjSUwwMDRXdFdKZjZ5Q3lPTVNoZXlsdkJmUGdNa0dzWFBWQmU0?=
 =?utf-8?B?OUFrMmErRm5UTDhpakFLc2l1Y2Vwc3NnaktMRXYrQlh6bGM3N0E4VkhXZnQv?=
 =?utf-8?B?R0ZkMkdWcG1TQ1hoTUpzVzhzSUFLcWg2am9DK2N3STRZR3lKYUdSbWNmSEN2?=
 =?utf-8?B?YzdGbDRMWGhNdjRhNmtlQXp1cDhhZGlHcHFoQm5vakYvM1BQN2R5UkJZVTBl?=
 =?utf-8?B?SzRVYkoyc0NubmZKTU1DSC90QW9iZkJwOXJsWWZ5M0J0elVndmhVNGJGd0l3?=
 =?utf-8?B?YkVBa3ZqcXRMZWc3cm1pN0VnY01SOWpPTmIvYjk0Tm5JNEt4ZTlOK3JYdlZv?=
 =?utf-8?B?RmVWd2F3QzFndnE1R1plVytLQWFIT3dUT0ZmTmhsUnU2Q0ZuSTErbFJCVjJP?=
 =?utf-8?B?eWY5YzhPT1ZhUnJUODZUbXBoZnY2Njk4dmJ4YzhVYS9LY2VwMURFNVlIUmdE?=
 =?utf-8?B?b1VqNDFSMXE2dDFQWlE0Tm4vRlcvWGZHNkJpZFExbEZuazdnR3VyZ2tSZVdH?=
 =?utf-8?B?bWJ2Mm56Y3JxSmJ1RlJZdDNPamRWQXdabmN0QnN6M0s2MWdudFo0STV2OXQx?=
 =?utf-8?B?Z01DT2pHdzBBVS9FQWI5WmF5KzF4VGdFamo3UUpUN0F0VmhEcTJZakFXaXBF?=
 =?utf-8?B?S3hUclJVd3I3djBjMzJSZkdqRDlGNGRROStIZHc1VGNsYUl6TTJocS9welNh?=
 =?utf-8?B?aVlVK0M5RkZTcVpRNUNqNXdXdDdJNTJCT0xhU3ZOdFZlRWtSMGhnaWhKQ2p6?=
 =?utf-8?B?Si9lZk9QSk1UZEs4aUE3N1huRU5WSm0rWjh4REJ1NWwzTSsvMmNFYUpoN2s4?=
 =?utf-8?B?K2xHbE03aE5MT0MzMVVka1R4a3FMLzhmTisrT2dwb1VYSCtDYkdYWkFkRTVD?=
 =?utf-8?B?SFFWVGEzVnFLZnJRRHp4dHkzQ0FKZE5lbTlzV1YwSitheENaMDhVWjFkRnhS?=
 =?utf-8?B?cGMrcXRGelVuamRJcTFrWkc3MmV4SUhmTS9vSzBNditScDR4TWRvMCtocWxS?=
 =?utf-8?B?bllab3Fmdm83c21nZ0tlWTV2MmZPaUhXU3N5NlU5ckQycWJPRnNJakpsZzIz?=
 =?utf-8?B?UW5Qb2Jnak5RRUxPOHFzcW9tcHJOZUVIYXpxa2lZMjlkQjFSa0xHRlBsVlBX?=
 =?utf-8?B?bi92WVcwdk9MZ1NLYVZmU3Mwa1FMYjhaTEZHdWpTbytmV1dzZmQrRGdvbXZW?=
 =?utf-8?B?MFBTWEYzNlpDUTNRRjdjTzk3VjB6Y05iT1ZxRG5VY2M5cm5yeHNqODVKbVM4?=
 =?utf-8?B?L2NaQzVzNFFxVGJJOHlLRHpFS0V5YkFkL1ptRFRyZTlWbXlSRDRVYnAzSSs1?=
 =?utf-8?B?Smw3amE4MHJhSk5Nc3RlV1lQNjV4bUhwNXJNSktUMTNJM2FzYkV2UlhLSlB6?=
 =?utf-8?B?NXlaR21KcGZJcW81eVF0NVg3czV5OXRmdEI2U1hDSVhCa1puSTU1UEs4UnBt?=
 =?utf-8?B?cmF3VW45Y2hXbHl3MjlhbThUYnBIOExxb3BETmxNenAwL3BtUDNBbWJ6RFVC?=
 =?utf-8?Q?HKPFN8OkQTS5s2llEHFYgRo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DTjRzFQW6aIroicnFHqGsbCUjvYCwp1xhgkOoOzvVzUGG0i0eMNQhRXWtdL6kTIyRKR5YC3KRmYh4i4rVSZN5MYjEWdZZOf+WaTzcFOExZCeVYAnxQE9l09E8fSCdzQ1us14GiwgIZt2W+UC+xmuM63FNMfRx9bpC7X1QrhgquH3Lke4a3TDFgjC6SFiB4JPcYy6zzxoN+iBnu8Bi5RG+RcADURUGTQjDm35PrptLTxdMxFxPa5AS/4X6czXCRMKPqZLNStc5lq36U0G3J3b5VYBBYv6Jk+0yMxR87+q6JLkvPinD+nrdYCCA5ODo3uv/PR0d3Q38bM2Qq5jnppciBH7R16+NNbcrssDp9oEQiDnXStWyJDhIecxHZtajsqdLCPNLGOI5Rre344AuP2zbpRFz/XlDWq1SdayQcKHjAmc4c0mW95ntEJxPq3JoLQ9hk3mCuDNvHP5m99OyBHvvVs0sLQSkOCcIA5W2mQXp8TXZ/GsnlEEiP35IxJ0YzPkZVcROeoSyY9GLFVGSallVQHpgb0kSjPwKO8JLtTaqvnXQBzRlM5FXab85TVhjiSU7PmRkRbH5i9CFugT+ZGk6dxKJk1J7FMOdONUtcZOclI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bb86de-fc54-4322-ba41-08dcd3f8e0a2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:35:05.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gl+Lu+cl5GFKSlqd1Y0iGHykzRKvJBUIFxhtw5YFuIODT45R1K+jShzwO5IU7vJIcX3mDAmtpsjWMEl830L7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130095
X-Proofpoint-ORIG-GUID: mm4-hY-Rd0gKzgjmeD-pmWAnUOdlUcPm
X-Proofpoint-GUID: mm4-hY-Rd0gKzgjmeD-pmWAnUOdlUcPm

On 12/09/2024 20:08, Stephen Brennan wrote:
> The "artificial" flag corresponds directly to DW_AT_artificial, which
> indicates a compiler-generated variable (e.g. __func__) which shouldn't
> be included in the output.
>

Nice, didn't know about this! Great to have such a clear criterion for
filtering.

> The "top_level" flag is intended to be a better proxy for global scoped
> variables. Currently, the DWARF loader examines the DWARF location

Looking at this, it appears that top_level means it is a top-level
compilation unit tag, i.e. not associated with a subroutine tag (I
think?). That's kind of implicit in your explanation so I think it would
be helpful for the log to describe what it is as well as how you're
using it.

> expression, and if the location is found to be at a constant memory
> address (not stack, register, etc), then the variable is assumed to be
> globally scoped. However, this includes a variety of variables that
> aren't truly globally scoped: most commonly, static variables in
> functions definitions. Their locations may be static, but they're not
> globally accessible in any useful way.
> 
> These flags will be used by the BTF encoder to select global variables.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>


Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  dwarf_loader.c | 12 +++++++-----
>  dwarves.h      |  2 ++
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 065ed4d..d162214 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -730,7 +730,7 @@ const char *variable__scope_str(const struct variable *var)
>  	return "unknown";
>  }
>  
> -static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> +static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int top_level)
>  {
>  	bool has_specification = dwarf_hasattr(die, DW_AT_specification);
>  	struct variable *var = tag__alloc(cu, sizeof(*var));
> @@ -743,6 +743,8 @@ static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf
>  		/* non-defining declaration of an object */
>  		var->declaration = dwarf_hasattr(die, DW_AT_declaration);
>  		var->has_specification = has_specification;
> +		var->artificial = dwarf_hasattr(die, DW_AT_artificial);
> +		var->top_level = top_level;
>  		var->scope = VSCOPE_UNKNOWN;
>  		INIT_LIST_HEAD(&var->annots);
>  		var->ip.addr = 0;
> @@ -1767,9 +1769,9 @@ static struct tag *die__create_new_label(Dwarf_Die *die,
>  	return &label->ip.tag;
>  }
>  
> -static struct tag *die__create_new_variable(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> +static struct tag *die__create_new_variable(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int top_level)
>  {
> -	struct variable *var = variable__new(die, cu, conf);
> +	struct variable *var = variable__new(die, cu, conf, top_level);
>  
>  	if (var == NULL || add_child_llvm_annotations(die, -1, conf, &var->annots))
>  		return NULL;
> @@ -2243,7 +2245,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
>  			break;
>  		case DW_TAG_variable:
> -			tag = die__create_new_variable(die, cu, conf);
> +			tag = die__create_new_variable(die, cu, conf, 0);
>  			if (tag == NULL)
>  				goto out_enomem;
>  			lexblock__add_variable(lexblock, tag__variable(tag));
> @@ -2367,7 +2369,7 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
>  	case DW_TAG_union_type:
>  		tag = die__create_new_union(die, cu, conf);	break;
>  	case DW_TAG_variable:
> -		tag = die__create_new_variable(die, cu, conf);	break;
> +		tag = die__create_new_variable(die, cu, conf, top_level);	break;
>  	case DW_TAG_constant: // First seen in a Go CU
>  		tag = die__create_new_constant(die, cu, conf);	break;
>  	default:
> diff --git a/dwarves.h b/dwarves.h
> index f2d3988..0fede91 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -848,6 +848,8 @@ struct variable {
>  	uint8_t		 external:1;
>  	uint8_t		 declaration:1;
>  	uint8_t		 has_specification:1;
> +	uint8_t		 artificial:1;
> +	uint8_t		 top_level:1;
>  	enum vscope	 scope;
>  	struct location	 location;
>  	struct hlist_node tool_hnode;
