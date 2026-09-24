Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED183F929B;
	Thu, 24 Sep 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266538; cv=fail; b=enhXKjx4nLs5FOOR585E3MjqpkznJOMxHLUFivsY8FsI1S7WXHt60ElqPoRNKKdyjilBkRVqFoBiunNyqp3Z1KRchtBWE/Jr7TwbRXyjIWPLiynXM8DCph1zf7xsRuIQS9zdl0efDMnUhyYMnqzlBBmiAdRJMKmDa3bC/S/0cjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266538; c=relaxed/simple;
	bh=iHrEhshB0KoOp9+OOoMnl1N8xZ3LAhiqczF5RydUMrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YTX/Ro5qQaX/tlQWCTUIcaCTe8WsO4Q0lPkfX1sf445m1RcIGj8wpyVZy1KeTCBPs7CIFrW6AOFsuskP8052yhAq+GQQpddsZ31vnZv2oYRdMYISe+8faxvnsZ+e5U8kbq5P87fKYfpaWwzj0uFKxLcuCebq3QMf0ytyCA4Y2xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BnWa9Lpg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KFwQvYqQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BnWa9Lpg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KFwQvYqQ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFtZlE3288633;
	Thu, 24 Sep 2026 16:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gJMQTj/BThkXVkKT1bwfbPDH555QjXSeTkWPImPG1Ak=; b=
	BnWa9Lpg2+JpkQgVxja91YuYRvcgbH33ELYHV0ngTUuo/jgOUr6SMjhpsJOQdPvi
	Wi9+vhSSeby3O8Jg8ZFpjfSD2axG1wuR3i3ejHbzm3FQ6UKuf4saVEhZWRoq5x/B
	674aFXo17E4Cu9byaIv4JFM8evikokrERKQKQJxlhZ0FbeV2n0n/DChtdTaMEFp1
	2vMezBCqn8NR2Yr9p+sUAcfZ3ybeE+Bc46/W22r7xEovl3x/PLu18Hqh4M73DKR0
	1crqeIcvj+FkqtxQI+/uwwHAzPJzX5vZL9OmuOcz8ymPz3xXpNCNPXBdEqUdnpnW
	kuM93AxuI7guPZ/FNg8bGQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsjxb82m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 16:15:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OG5bWA038466;
	Thu, 24 Sep 2026 16:15:25 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4guurkh2hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Sep 2026 16:15:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P28N/XVxTzCrEm8y41uVAufAfkbeblRxAAzoSVUaAhKrU927XJuNHt3HKTflsfrgsyoXa9Mb5GpCfGrzghHkEAIpaIWc4ZIaBTZNwZ2mKm27RWi9krz0QTEFfOnJCVRGE6PJikxLB8lJMCibO7nMkRUnahpE2jc0VPHSwAnemV6I1GvtikzFb3mXSRmfYv9+5heH/KYQfZLIhK57TeOd0IF97YPoxXoVCpcpcoWFj2ssHg5d/9WGdj/ZHFy7Lgdt7PlH9Z4r1wBwjW7xcRkm/FaKa9YLz0CnzCxJu+M40jk0SZak37lNHKzUf0IdXwWh+zpJ2Nr/ARkXnKGmJS/qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJMQTj/BThkXVkKT1bwfbPDH555QjXSeTkWPImPG1Ak=;
 b=RB9BosQZ2pZe8ddm38O6cFYUoGuHIb5gLKUN5D6UtQ7WWDMZqej7erUUrM5qwzNamOSNZdLlRUUuAAvxel+DiA4eah0G/mD01DdQebsuwkXHaHornsmVbOQ+8Mc2Rpg2KFAKi92fT3Dcc1pv8alx/3H0kXbHulvzdkA4MymuPFp1rE1D27PgANRZ+WLXIYPrVlaVB7h4Ci/bJ3t0huqGtgDIEhnPzzpT99kpAEp4YIDqMr7jS/HV1RnNny/1kYAjPPqnncKwd+TGLh/spBYyXgfXdJ9ShfWBCKD9uXPIorJu1pbCGyvKJJFnomh2/1UcLSPEh+ww3q6isb/Br1/Tyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJMQTj/BThkXVkKT1bwfbPDH555QjXSeTkWPImPG1Ak=;
 b=KFwQvYqQeGCf/c7Jembefc+NxYiQAoZFFUtKZ/jZ9iyEoJjX9t3SZ3JEna4Ncsg1fwo58KtQJZJQjFDFGAFPRRWgW0Nzo94MjbROT0sFZ3FxF97XQXBPJZCsU64YXqnfsiy4CvAnEH2mOe8qqf35l1rzNKmxAux/wzzPRPscWAg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Thu, 24 Sep
 2026 16:15:14 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0472.005; Thu, 24 Sep 2026
 16:15:14 +0000
Message-ID: <09dbfeea-a4d1-4b7a-b92e-bcf8c4cdabb4@oracle.com>
Date: Thu, 24 Sep 2026 17:15:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2 0/3] pahole: Fix arm64 argument register
 allocation
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260917164038.1576763-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260917164038.1576763-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MW4PR10MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 069f0a01-2af7-4265-bc85-08df1a57040b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	n6j7MFJUfYDCVM+GmELE5P9TfeXAYROOthd/zttw7upIyQIYrPrJa7Fp7UOLSFyMuRTTuX7yueiDnuS9544Kpo4wtsM1ndACDVtCvNN5qzP7h7mXBpQoiWYhKXENIvP5BoChLL95BdiLfW3G2DggVBKUgRc2t35BMJQBCE5pzJe8rjGAcfO02DkPHf4iu8HOhqx9O1iXmbjQU6j4ogoPLhrA3OYhxexzw3Tb67ua/ACOhlYwcilGi1no3wP132Hzw5lPJo1Rsp+xwnk44RGsXynn6koNotRFi5/a2mVqLZy83Wr4y/LVeOQvvD49WfdpTZQUs9MlF31ae1S4jsZNkr4QvVjalGUtmgDBOEqVOgOaEhZmjTMv3+GKXUfaOH45J0u2ZAOaCIqWpIzJJT7Kziwx0qP4OfDgIwRR5omt/vZvHGZfDoOXI83kXHQBn6TXXVrqDMeurWExybnjIFl6Jyu18uooOwNWX2eW0PsbWVBoSe7XecZ0pcPORy/MZ8wWmOsvaLUAXm3f+YTVfvn9RrtwUYQGWZd5EVfDt6z+v2P/FFlcCq0zCn/f+EdopQOk/31HniwhOWP0kz/vCo4l/NpgC+729Phk1IijpGUXdG/JTLLKoP/8T1z+XZbmqi0emuoh76U8ejmHWl715PG0e8IvjjRd2DoZF6/FhsTKEy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlVtTjBaTElQUWx0RGJOS3VGK2huRmtqSE0zWkJYLzN6ZmxNN0VZcXVPQTJ5?=
 =?utf-8?B?aU9EQ1F3c2g4WDZDTWNRWEh3bVlvaExDYmVidkRlRGdhSnA0NENtMmVQQjln?=
 =?utf-8?B?QWs1aTYvNHlOb0hGZ0Zya2NxeDVrYWlzaEQ2M1BxenFHeFZpZmY2UUhraTNm?=
 =?utf-8?B?eTlZMU9ocmZXQlZIYmhHV0dVVWVQU0J2NEdMVkRocUZxUi9kY3cxckhlQU85?=
 =?utf-8?B?V04vejFQZk5BZXdURnQ2YjhZZkhGUzJRM1lpNkNRa0hwbWY1aW82c09JUVM0?=
 =?utf-8?B?Zkh5UUVhZWlIcmhLMmw5OTU4WGdteWUyYVdVcVZwWlJVY1REZFZhZEFIUllF?=
 =?utf-8?B?QVl4d1A4VlpKenFHaHoyNzk0QmhsU01CNllETnFMY1RkWlNsQWlMRXo3L21O?=
 =?utf-8?B?eUZvWld2UWtzbUJkSk9XVEYvRFZ2aktoOHg2SldJbkFlbmt0Q1M0M04wMzFK?=
 =?utf-8?B?OVk3Y05TQVJCQ1dIQmV6Z2tTeWdTNngvVGhYZElHS3Vmcmg5YkZ1K05JWUR0?=
 =?utf-8?B?MEFhT3VFcmZDRkpETU9FaFRYTkV3N1U5UDc2bWptS0ZRMGprcnNpSDk0d25Y?=
 =?utf-8?B?WGwyQmtvLzF0MFVoNmVwTEt2UkNoNzdlbXdMTjFFaTBBK2wvQ3pvcXYvaVRQ?=
 =?utf-8?B?L2E3a1dUbE9xT2lHUnVGODJGNlFRenJQb2wySFFOOXVPdnV5T1dkYnN3OXlm?=
 =?utf-8?B?MG1uVVlOaElJU1NBUGhFdVVVRDRUTDc0U0xCOUpiOU82NnRZL0dUdkljSGF1?=
 =?utf-8?B?WndZK3FpMlFGWWtUWXk5OUtCWkpIZUErMTVDblllMmlVSnhQb05oTlZ2ODZN?=
 =?utf-8?B?c2VQZmhnbTRxR2FNZzlvOE9XNXFlSVZFK3dOTjczaEE5V0t1SlZZRnBuY043?=
 =?utf-8?B?QlZQUGVYWlh4N1dNOHlUVXkxOWpLNFlNTXRsaExmRXhRNG1maUh1Y3RPVXRE?=
 =?utf-8?B?bmtmVUF0R1JxM21WVUorUHJtb1ZmN05ScWF6cVZtcExicG5tL3NlKzZmOGpL?=
 =?utf-8?B?VjNvcHlsUUVnRG0rWEszNU5FZVZQN3hycGJ4MzBDZGdGRHZBK291Rk1zaDhW?=
 =?utf-8?B?UEhIdWxVWjhWUk5QRVdIWURwTkhEcWhvZTJKN28yOGNZTE5xY1AyTWo5ei91?=
 =?utf-8?B?RUwzMFdPNGJ5YXdqek1Jc3JHR3dUNStNQXdxM1FlWDBzcTRxWnlVRDU1NkJ1?=
 =?utf-8?B?V3M2WDE0RE93VkIwZ1RYS2NReWpvUFo3UlY3VCtvM2pQbU51REIvR2hVNXZw?=
 =?utf-8?B?THZ3WVNwK00xZyt2bHd6ZnFqTkI3NlAvcFM0RHYxUEcvaGpUUGN4alpMNzNF?=
 =?utf-8?B?VEVoeERrTHF5Zm04akZWREZmNHp6K1pvelBDaUhnVkd5K0xBcFdNTlZMMERO?=
 =?utf-8?B?dUtySG55RGYwQkNuR0EwRE1pa3NPWmcvS0FMK3M5OVZDM3lwcG5DZGlqYVFF?=
 =?utf-8?B?QVh4dUNNVGJ0dUNGd2JIRys4NnhBQzZJY1h0OUZpOXpJMERub0RCNUdHWGtJ?=
 =?utf-8?B?UDVmTkdKNHl3QTIrbXRqMlZQakdCSDIyZ2Y4TzZQSi9LbTY2Y1ByZ3RhNzNB?=
 =?utf-8?B?bnpDM2dMMVhEQWkwK0dZemtRajljalJJb3p6V01LYzliTHdQYWJxck5sQ3NT?=
 =?utf-8?B?TUhXbnA0VDk1a3N5bDFQNGd2Um1WNjM5WnEzSW80VC9XSFMyWU9zcUFPQ3F1?=
 =?utf-8?B?UmxpMHV4MUdWQVVxT1JDN2xGdVNGSjR3ZUloKzA0NmZaQ2lGTmJ2U1pGNTV2?=
 =?utf-8?B?aGV0WkIvWStweGlRbGpPMVZNeWNYRElmUTVyenM3SDIvUWVPc2w1OTlIVEZk?=
 =?utf-8?B?TlJOM0YydGFKbW9PbzEwckc1b3F4YUF2Y09vWWdmQ01XVDhhbUZieFF4UFNS?=
 =?utf-8?B?RXo5UDR3ZFVPa2dDTGdzaDBlZzRVRm5Zcjd6MnJHbml3T3hVcHNmamIwVUJo?=
 =?utf-8?B?UnIwRlp2cnZLRlNXZTdPTVl6ekYwY0s3Si8wSEZpOWxTQ0d1bGRabE9qRjVT?=
 =?utf-8?B?cVhzaGNaYkMvckhqS3FpdVh5SEQ5Zy9ZSVU3cmpxRVZpdW9wUEYwVWhkWWFL?=
 =?utf-8?B?MjBSdEFLRkh4VklDeVVnVVNSbml1YVNDbU85NUpSZ1dJVmp0dm8yUGN2TEVU?=
 =?utf-8?B?ZkFWK0hvcm5SOE41Y0FtOER1YjZJVWlGVmR0V0RNYnN5b0VuVndra0lMSFh6?=
 =?utf-8?B?NGMvTmNsZ1FsVjZpZDZqa0RuTVJkZjRJZlVoclR4RzJuVEtabUMwOEtFcDVJ?=
 =?utf-8?B?QkNWMUdsQmlqVFltbzFlRENMTjErbTlwOXRtaDlod3BEdk9Jc2tMc3NhUjBC?=
 =?utf-8?B?V0hjdDFtUmk4V1RWd0l3dFNsQ1NmdU5hSTFzdWJyM1RSTUZkUGZDUT09?=
X-Exchange-RoutingPolicyChecked:
	VC8qmxysnEhb8ho+FPPBKplf/WxaBTIqgvtfXSlLa95v1S5gMOZyjWCw++k4Rl4XkbBLUZUG5nNe7K37yOuszF8MdLqMQbacxzH9d/vlF7OMFM5lpoDe68JqOJwI6qrVNmdeC8t3UwZu24EjuuoVLpLfvGabeYn+h/K1CaysWy+E7rok3N9+1e6VUIwCcLMCjs7Y0cuAe/07D9AzDwJ6ZpT8uM5xR9fxIcSLF43cEBw9p5VY+64BqY3Zv7vBJM0vXybcsXaqRjsiC1e/N+dhHb0NoW10/9FywhuL5GinqJV0WJ1cmPGrQRL+Yf2uCZSwJpg5XY+gsvbFyywKDcn+gg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D9Padoz4eTzFmHGNnyCM9GEMWvqho+k90GJEOmwHYDQxsqIFRZMsaJDNG5l6WMTVPWvjtuIm6nrZiJGElMsa875EA52aCqc5qBE94tQFzMUgFD00sGSRZGGEfAL4YxxpIC31foPU4a/kxi+B+AORIOr9tqwf7dQ43fcNoSejMDRFePltYTzu+V+X8pmkBJDCMXCqm9FcIXX4RorA/ylCLYpBs6jFpHXmMaNTYiazUZSmIXU4vUN9Z9L1RalplySA6whTxnOzewUxqU1JSemkjH+2mfRfkT/j9HhjHC6PraIJLqVdzaSL9GqUrxTSE/vPFJbWoebP5paFxKbtCsL1pvjh9DXfcw9EbNrehFgfUwFg0y8P5r3nfOYGK8n33JG9KN8hNCHU2tCt7SMXfL+MszLP11EsgLBo97wTP0VoNUH1Ha3UVkjXuOPmJY4s0HS4KhVNaqBofJnpOSuCCuZ8kzWNTR8RcDOpr50xH95oOcl/fpSh5ZHqhDPuiXZoQnGSwt07UWXhsbotZ+F9sp1SoQ0t3hhU7LbUrpD+vDMkN6w1YfmAnZHOEJONdcD8WvB/KmuuzKV4EINRATb72kqlNxoPYLMJFWN29HcZ3mGDjDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069f0a01-2af7-4265-bc85-08df1a57040b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 16:15:14.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj7ckBG4O5CRZsTYLtHeNz+2KmCiCRRe101aCJlw69yD0jlVGk/68usDikjOIyUOD3VSsneMtw/dBmnte32piA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=993 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609240066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX7N5Xa40E7mpb
 194x8vV2/kTgOVLuWYrroEociAHIPbtuN565wY1FUqDrspTerY3I0Qt6Xi1k5B8KAHQY90EZvPd
 VSc8+A1cyV5uNaJCKKBjLYa0HJRM9No6eyFo3wjAbML+mPiPI8OLnCPOkm5oHYAt5P//PIhAjOh
 LMjZc1azIRLgevx218efOndcpPLwZU8aHDobVpT68LqZioi4ois5VlEdQktpAvnKrytDLOF8He6
 zydwdsuNoyH26ic5/jwrBmNju2NzJk6AMKRXtsGa2nBbmcPu5CSZoCLGzkbYmvkrqduPn9FOZT5
 4yDxWx2EI1gctl0wjB9qiS6QfEtQjrR7ByBcOW3UUlfGp91tCKzmn/GOHiB1ItZ7RM2sjycV99q
 h4bFgUD4HoQZerm0kf8vizpBRlrhgqyjvVyFI0DWkZO6dMhfCtHRE2uhe/V82h2v7tRo6Ow6z/A
 xNPVeZ4dt1sY4LsCQ7A==
X-Proofpoint-ORIG-GUID: S8oU7yGyGQKDv6N8O4JdrATzKrBa54lx
X-Authority-Analysis: v=2.4 cv=UINIjyfy c=1 sm=1 tr=0 ts=6ab54c9f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=G6qNw-qzJdZysMDmmfoA:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: S8oU7yGyGQKDv6N8O4JdrATzKrBa54lx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX/bepRdgQpOsA
 xWKjLfYxbWbF4TY1O98/E/zTq2XLw85xvtdL2Cbt3c8Y6yvfpS4l5UwsK+036o4zrsk21+jc2S2
 gZ17DfuytRe8BUSNYP9pe1bxDepVHtwF2+QtQJe8gh/9lpuCQMKF

On 17/09/2026 17:40, Yonghong Song wrote:
> 
> The arm64 ABI starts an argument twice the register size on an even-numbered
> argument register, leaving a hole when the next free register is an odd one:
> 
>   u64 f(u64 a, __int128 v, u64 b);
> 
> passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.  pahole did not
> model the hole, so b looked like it was in an unexpected register and the
> whole function was dropped from BTF.  Patch 1 skips the register the ABI
> leaves behind, patch 3 adds a test for it.  Only arm64 has this rule; the
> other architectures are unaffected.
> 
> Patch 2 is a small follow-up.  Floating point and vector arguments are
> allocated from a register bank of their own -- v0-v7 on arm64, xmm0-xmm7 on
> x86-64 -- so a wide one never occupies a general purpose register pair and
> must not trigger the even-register rule either.  It does not change the BTF
> emitted today, because such an argument still advances the general purpose
> register index by its own size, so it comes with no test of its own; it
> keeps the alignment rule scoped to the bank it applies to.
>

one small issue here; we record alignment for structs from DW_AT_align
in associated tags; we should ensure that we utilize that alignment
where available. However it's a bit broken in that we don't appear
to record alignment for typedefs, just structs.

I think we can tackle that with a followup though; unless anyone objects I'll
land these patches later today.

 
> Changelog:
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.song@linux.dev/
>     - add commit "Do not align the argument register index for FP arguments".
> 
> Yonghong Song (3):
>   dwarf_loader: Skip the argument register the arm64 ABI leaves as a
>     hole
>   dwarf_loader: Do not align the argument register index for FP
>     arguments
>   tests: tests: Add test for 16-byte aligned arguments on arm64
> 
>  dwarf_loader.c              | 72 ++++++++++++++++++++++++++++++++--
>  dwarves.h                   | 11 ++++++
>  tests/clang_parm_align16.sh | 77 +++++++++++++++++++++++++++++++++++++
>  tests/test_lib.sh           |  3 +-
>  4 files changed, 158 insertions(+), 5 deletions(-)
>  create mode 100755 tests/clang_parm_align16.sh
> 
> -- 
> 2.53.0-Meta
> 

