Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471227E04C
	for <dwarves@vger.kernel.org>; Wed,  8 Apr 2026 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657159; cv=fail; b=au8DXViV3DzNzCFywNHrsFgA1aez/IZSd2I0leGV5x0e0ulBh2yOQfGrzjV19pd9j3O1KkBgP2inCXtzc10AcycdYnO6SY+DBVMgeiLg6YZR69iVJWjUMXBEbZa7oh0gVXeBqjNpmgpiUEBmIOjEke4LNyZGNNidtAR3Y2ot7eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657159; c=relaxed/simple;
	bh=q61cvWWc2BM9JW0T+Y4DfGyAH4aHAg3GE3hZzLwmHo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hd7pYI7gqZcLprFxZVo4en6rGe8VL8v7fXO0NaQ3PBz37vuZ+x8mt/PiPZ2dqiESLEOb4Z7u8r9ryRBLEfvFjysc070nFjo9TIIyKjWsUJJM8OryMF8WMTI8mYbh+JwAGFDz1ZEYKG9/TrIglBqu6w0XdexYMamnjxjB1XKJqJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HIxdZwFV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oEpyK6Op; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HIxdZwFV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oEpyK6Op"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6383Rnr7212613;
	Wed, 8 Apr 2026 14:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5GDH/AOdqGnd5ICmIpAUnKnTh45BZKpod4TSSGv9OOY=; b=
	HIxdZwFVzlayAguTei7L2cbOqEWYmAGqBCbKgdUn9Ozxj9KWM1RY1YOyFI8ursE8
	6jsEQr4on/+iGfzOlyUwXZkhKuOhB3wcGRxLYyBc1w0xSlTMJ9U/hel6bcXMtilT
	EJJU/IyzClk00+dQId5in12EGZZz56Qg6h+Rr+NzSVT2TVUBy/STy6kSb3KkRr59
	lIn+8Ot097Zj5tEHYQ0bIaFnBIlWTf06NodBFsKeXa1zAzOYFEQN14UIZ4ncirkw
	9CbI1BDYA9y5RO5zMkhfCwq8s+ipcLi2eL+jWGcu35IMio7j1okbsUv/TGBJ1Ehr
	cBkCaHkBE4f4fdj5p1Lmvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqaum8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 14:05:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638DvWp0040165;
	Wed, 8 Apr 2026 14:05:44 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmn9hqhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 14:05:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoFaWZwyIHBYOO1EtTofLFU0XF1utDCbz00H3679SvfwpxeXBMkhZShGm22ADhq7RjEBku+RTDS8+P2lNcGOIHG5CytkMF4fGIO5b2stMJp1OAErMisfLaT51W4445I+6Ym8mFsLs1Di6Q3IpG/RaSvt8tHdzE8/x9nU8axYAWk0n0q14MZJ4hzSBSYSbTwtpZBZGkl2+h+4VIU1tcrxwAZNCMsWYQV6mRcmZnHeAPl7B2ICgqwwdXDEEKBCvn++IRbXuoqJfT6+8kXCD89roObrDtQwqtXzTWPslRMz5faCYwLLK1DOP3MsxhG5KnisDL6LjryJGpOA+i7FFex/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GDH/AOdqGnd5ICmIpAUnKnTh45BZKpod4TSSGv9OOY=;
 b=l6W40pnH/cZOG3DHH4yu816/VI4ultPHCO8fpFJqQ9l6Svhb4gzX1PjRFYhX+Z5u96ls09aSsIT0xkwxyejUqiArURwhsKlCdWM5RG0mxdWs36CEPpG8hvkkSr32sLrtrcvPMkdWLXxbA+jH2sU7O7Ru/OcmhPEwJ1STqTjPRtOAN0bYhNM6YRBPyveZeCsUnL9FRWcR7pf45ER0/PXY8SY8GujS6M0j8L0h3XqTi+rSY7lH/qXrMXwOz2bhwdld16zaoWQ64wlG3+vqfTT025CA0vuRZU1NhZuqm65/2KrvcHTKkS0zb0ikm509sGkk73JEB0dTwNHZENTV4+94ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GDH/AOdqGnd5ICmIpAUnKnTh45BZKpod4TSSGv9OOY=;
 b=oEpyK6Opfhh7wa9r0Dd5y2e22LxkYnVVV4X0A9ODBzXUFu/wJWnuXcLtQYN+Jwo8qWK0273cRGZeCiZwlMGAUXtgCIjkVD7bB+HIEFXxZYGL2s+Hb/FSC8X43NCJBorf42Ovgbv+FQygnzdrJ7IDfCY7180UAzjRSJvIyckXYp8=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by PH0PR10MB4453.namprd10.prod.outlook.com (2603:10b6:510:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 14:05:41 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 14:05:41 +0000
Message-ID: <78c51d5b-554c-42c0-ac6d-2e7738d9f3ca@oracle.com>
Date: Wed, 8 Apr 2026 15:05:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dwarf_loader: Initial support for DW_TAG_variant_part
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20260323211533.1909029-1-acme@kernel.org>
 <20260323211533.1909029-2-acme@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260323211533.1909029-2-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::20) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|PH0PR10MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: bed95654-2dd3-438d-dc93-08de9577eaf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/enYGBA40GsRKv26VEmimaQeX2xZvaYAJB44tiU+TmwUVKEZUsIDtFrm9LwY4URn/Hzwe7ZWneKuD6ujpWLfYI+x0VPGNYdQ7VftB21OvoZE357WGwfYHZI60merofQftGQ/OF3vRBUxnn4lEoNtEfH58e70IBebR//UGiQmUVTRgP0dliMpqdVqYANbqq797upOU2+5HqMI2oz6Aanr8KN/+Ft7gjn3Q0zcH9pJCwZXtQB2DzucbzjQKLVd5XdwtCWBMIgbV5pmccDwPSv9dk2Al2jrb9fAHw0v+2XtrFVT2yYVVIIxrbifN9Bsnq2BIZr8S5IheaWPkMMyNVIMVproulnfm3cfZnenfUlgGT09qYePkNMdYyIJ0zqyksKRgWIrss/9Yoob+C+h+4AZ6585hb7OFwe4idGfMHjid4TUJkl8C/U4utJ6KUlOLPveY/SSDq2rbVDDPYDun4yrGevqSXF7nL+oJh9QX6qFGNVyWUyy3MLWsVsKO2ND24btJK4tt4yE18MSTSyVFrAdMtoWIltaQgsjWN7uxKOGIQfjcZx6c99D4/yVkkmURgjtLm50SkytZAt7XsGYiZxSuih+0xceIaYcGJIaomc1at+KDdZbU/UaBz8Q58HFEBGGDhiHjN+ugTY1PqN5Sj9kX/8B+vbZWaaf/B5t39L7xyWUxtGhr5bD1tSt5vN3OH8oRmp6fPzQ8W5+3s1X4ugVH7xlfbAxskgjCiyMDCF9M3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUt1b0dTSVRtTThPWm44Ylh2YnE4SkxET0x1S1lHRnpoRmozTXRVRGdtVVI3?=
 =?utf-8?B?TzF6TlVMSFU2NjNqdnZoSWdqekJpZnNrUUpqK096ZE41Tlhybys1YmtsUXZD?=
 =?utf-8?B?bExaVnJqeGRUNTU2MXV4cG5Oakc5Tzc0V0tPRGl5ZW8zcFFaZkptY2FhdGZk?=
 =?utf-8?B?S3ZENWdrekhFeEN2K0YxQ3Y1QjMyZlZlSXFTd2tMN0laVUJOOHQxS3JQTFc3?=
 =?utf-8?B?U2Q3NVdnOGFSTkNiVmxaWFFvNlFSNDFLSnZIek4rc1JHR2tENUxwcmJoTUNn?=
 =?utf-8?B?QnJCRFVTUmJMV1ljT0dYSFl0WFhVNlRzejlFM0s0L2locnFvRG12Ynh0Yk5B?=
 =?utf-8?B?L043NWw0eWY2YnUxVHBUZE5xRVNmYUZaM2ZwT1M2QjRUOHhaanZMRWdXMjh0?=
 =?utf-8?B?N2FqKzZyQzQzZUpVSVA4VHlVTXJlbGFiUVNJTGpqWE92bXJGMnpWcXhLM3Zh?=
 =?utf-8?B?UGQyclA2cGE3VlpaMlFxeWM0cXJXMHlXTlVoZllZb3FlUzVkb0NuYndTb3RS?=
 =?utf-8?B?YU10bXlPdGxscW1qbFRqbzlHQXZHc3BaSkpvQm9VTnBBR0hSaVBzclh5Qjgw?=
 =?utf-8?B?Sm0vK1gxQzBrQ2dEOUlKZDQ4T0dwcW9qc2JsOHNpVWV0b3JSVGw0OG5RU0Q4?=
 =?utf-8?B?ZE1oZFd1RFhOQWpQcTdHMXBuUWdnVFpNYUdnRVJQenR1VGhtSlhRQytQbDBu?=
 =?utf-8?B?UXdiUG9EUEsvd1JxNG9oQW5venFYK0RDK0V0K01GTVBRZHRkMXRIZm02eHgy?=
 =?utf-8?B?Q2s4ZkNBMkFTOU96Sy9PTzIyTE9vYi9nZFQ2TFltUnFabDhvd2NISnlMSEda?=
 =?utf-8?B?dUcwWVRidVFzKy84NGVLMzJWNGIrNkJVbmkrajhubVhwaXlpSTBnWXI0ajZs?=
 =?utf-8?B?dlZDSkoxZWZiMy9ZczhSWGtUL2c3UjZSQktpTEpoWCtsRy9oTHRzd2NBN0Fn?=
 =?utf-8?B?UzhZb2IvaVRac254QytMYlpESzQxblVLZkdmMzdnZyt0YjBHTG1iQnFuUUVB?=
 =?utf-8?B?b1o1WlpCZkxtZElvS3Q4ZnlvK05hSjFrQ0RFd2t3TWV2dGtoVjdnSDR0WkYv?=
 =?utf-8?B?dUVkaExJT1liZzJLNnFsY3N3SjJBV1JyUHJOc01JdjJNWU11TFVYWWpmNzNR?=
 =?utf-8?B?eGxsWVl3aU1UcjdrNndHWHphOUtSWGdOWVMvTG9VeWMyaGdwWVRmOWoybzNh?=
 =?utf-8?B?QmFPWE9yT05yM3JwbFVKajBoWDl2V0owT1ZyVU9MR05wSnd2NXNmYjdrMjha?=
 =?utf-8?B?RCszeFo0RjIxOVp2WDlJeUI5b0o0NUR6WWxYMkg0V1RGaVhGVThnMDkwMWlB?=
 =?utf-8?B?VitxTzhWbDJwSEU1R2ZaZE1MYW95SnkvV0MxbkMxMFQ3bFJ4MWdRbGVreGtE?=
 =?utf-8?B?WnYxUi9ZZ3Y1WHJHeFYwQU1GckpMUzhvZ3MvZWlHaVJsUyswbjBMQXRGT2JO?=
 =?utf-8?B?MUExWllXcHdhMWd6bUdoM2dQcTN4WkIxWkhUWldvMGhYTjBCbnZEdHVZNklI?=
 =?utf-8?B?QW5XK2ViSVRCUjZTbzFPNTFBN2ZrWFY4ZVFXY1dDako4MUtmajNYb3RrTmlm?=
 =?utf-8?B?aUNNWHdiR0Y0ZW93cXA5N2JOcVJBTmZ6ZXU4a2JhMWxqcjNWSTIrUGxlNzQ0?=
 =?utf-8?B?YWFHNzBpRXhIK0R0UDQ2YmF6UVlYMUpjMTNSZVRnTjcxbENRdmpXTHNEUDVU?=
 =?utf-8?B?UUZRMlJNUzhabm40R1AwN2JBVkVEN0Z3cS9KNFNoVExGZGFWRi9OOS9CVnkr?=
 =?utf-8?B?Vm96MFAyR2dtQ04wQVl0VE4vMDc2ZXVna24vZkJHdnZOOG9taUUyNzBtL1h5?=
 =?utf-8?B?YWxhSUxURmhXMmp2M0E3b0NuU1hvSmNkQmlKREJNWGcrZHhpcnYxeEFNd1Jm?=
 =?utf-8?B?ekRMUWVaTG9mRFIxcnlDUkxKUDA1eTlCOGRDQmxlZVNrWFZyY0Z6YUF2bnVn?=
 =?utf-8?B?UmVUVFRKVFRRQnJTWXJDdXJ2VHMyK2FXQ0pEZENyb1YreWRFeDVibjFHWHRq?=
 =?utf-8?B?TUF1Ly9BUklWU0RXaTc4Vk1NNG9qMTZBVXhUTWR0Tk1MZW1jaHIrS1QvbEpL?=
 =?utf-8?B?S0tjNmlNNVlGa0IwY29uQUkzUW1odTN6NVZwVUQyUVJQMTg5dkdDWXpyRCth?=
 =?utf-8?B?VVZYWGJIaTkrLzg0U2x5WHorVVIrM09IWW5oQm9PbnFINXV1VEt1Q3RrcWR4?=
 =?utf-8?B?YnBCcUJPWlhxK0lqanRDdldiVTRNWFlDZTJGRmF3OVcxUE1LdGQvN250N210?=
 =?utf-8?B?UzBFRGVReGtzTEUzdEdqNnIwblhicE9RQUp0WWIxTllabDJIRnBYb2hCQUJN?=
 =?utf-8?B?eElmaGo1LzlBaHNZa1MwdjNad0dNYytQemV4RGh2dUFUOTAvTXpKdz09?=
X-Exchange-RoutingPolicyChecked:
	jna2MIfOXFYXkDTrYBAGGKfLp706LIrWBC38sZ7LO7NGhia22mWOidY77WnMOV2M3BqVpd8xeXkA9MfZ2cj41ECvRCk/Z8Rz2jL+8U2nMcbD/ULVrOU7gOxZYnik42cpUL5ujOpbKzViUdE2jQUN4pd7eHrLwpzq9Atkb66iPKYuXEnbXvSls+jVYY6/qaEOabySTcg/Ww5tEvpqCd8v6ZiuTZ//RYkTO2BsBC8QDlzytS0gqV6dxu61khzYzmPleIPoZZR/lGYyfd+/1SLHBsYn6p5Lc17gqQmr4pXKzYdS4mQfbygA1M8R6lWEnT2VpGddYXBQBeni9vevlnKINw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O4FKyyOeDvqVCO6Ja1n4Wx9NGk2kibH8AXNfwid8NrAK5djGG1zpWkd555Ukc8RVRCKz/rSGBPQdNoNVhoJC3H/R7w6+xl7Bn9Yg6VVfREfQWtdR7MDWNnl05YPNVfdFh8Rryd1h90LLTWZUrBuvzPMo2+ySDx7dGhafZSfBMLlnzxjtJU00AwdKvbLDtA6IAWKWQ74lQxr/aZXh3hvE7sg6lbJwBoqWjpcfm/VvvGCeaB2om13Cp5sieNjqtrcd2Qzr5kXn6Apl8Di9ABrSWjV7A8cnXdP8mJVXT0DBYaEJQndqTeZSODpq63EMmSTs/3OeOPJPWaFS1xL+Ew5OduQPCmDcXSDQJ4IsqGhMYqMzSNLBzHRE4xbkBOhShucD6G5A1XFjlIr8M7G6paC+BBKE8euDal1TdPiFQnOzSeJKZ5p9FK2AIhodZiEhsBDc3uDaz187X0s5aG0IajahicS0y31L+BIh02T7yg4Hkpw64UomRjrH+rg8qIkO3a8Iefme0oBPHjONfiXUe6trjeMG5ao1DaIy8haWNC+SwP3BCsA3kqfxGpXrVECre4AlEDBpN19rAGOJiwXuAG8pep2sZySGLDwa7i4JN6t0Jis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed95654-2dd3-438d-dc93-08de9577eaf4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:05:41.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7sNZ7UWKRgVNDyFs2HupnOfE6MLB2+aO4xMT8dDV6cWABrfMZHYLN8A5RAPKaAxhlZIcvL5luk0MT+DuZmkMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDEzMCBTYWx0ZWRfX4chu3B1q1/J5
 tod2HeYQEOZDB8eitno+jaj46VPCD0NkdNj4UznDSessixfX9dZ4L1h5VP96+sX8b5VhIR+QTVm
 fLnoK4gW4H7X8nRKpPg+rfFG4BAExRxOYj8Aha2GzSZeo21tAJDpOLPlX7C+vgM6x57SrT9lDjo
 sLubQjh1NDs+WbYWlc/gRls/0awnL6od0+GYbJhwm/ItBGCu50ftwwGqpo7buseBL332kF8V8eJ
 guwSgZBWVJWQnvhx9MRPmHRpNsilqI4vXdGmoF0wx1z9I1pxSEbmMqBX4LLsxEe9C0H88dezVcR
 LxDDeBe8J5pLBkWUxzlQZ6pGcvOAg35p3Iw1B/bBtdqt0QYN1Tbmao+0gH6l7GRrr/AOB2g4Pkt
 pDnKeWUZRMDkTWhmx8In9aER9BIENYKCXZfzvLUaRAh1FJeb1QdglX3IMa7pFL/FgyINr6aLsWX
 xTbteC54mgn9yhW5b7A==
X-Proofpoint-GUID: CSZURz55aP2omomyM5gEkyz4AWZ7ab8b
X-Authority-Analysis: v=2.4 cv=Oux/DS/t c=1 sm=1 tr=0 ts=69d660b8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=20KFwNOVAAAA:8
 a=Gd_i1AezwgIHb3jHNxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CSZURz55aP2omomyM5gEkyz4AWZ7ab8b

On 23/03/2026 21:15, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Still doesn't handle its sub hierarchy, i.e. the DW_TAG_variant entries
> and its underlying DW_TAG_member entries.
> 
> This was noticed when running the regression test that uses a debug
> build of perf to process a perf.data file and test pahole's pretty
> printing features, as now perf has a synthetic workload that is written
> in rust:
> 
>  <0><20c95a>: Abbrev Number: 1 (DW_TAG_compile_unit)
>     <20c95b>   DW_AT_producer    : (indirect string, offset: 0x4ee5a): clang LLVM (rustc version 1.93.1 (01f6ddf75 2026-02-11) (Fedora 1.93.1-1.fc43))
>     <20c95f>   DW_AT_language    : 28	(Rust)
>     <20c961>   DW_AT_name        : (indirect string, offset: 0x4eeaa): tests/workloads/code_with_type.rs/@/code_with_type.d6e680867bfb8b27-cgu.0
>     <20c965>   DW_AT_stmt_list   : 0x5e1ed
>     <20c969>   DW_AT_comp_dir    : (indirect string, offset: 0x487f1): /home/acme/git/perf-tools/tools/perf
>     <20c96d>   DW_AT_low_pc      : 0
>     <20c975>   DW_AT_ranges      : 0x2d0
> ⬢ [acme@toolbx pahole]$
> 
> So lets add some scaffolding for the Rust DWARF constructs involved for
> us to be able to continue using perf with DWARF to test the pretty
> printing features.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  dwarf_loader.c | 26 +++++++++++++++++++++++++-
>  dwarves.c      |  6 ++++++
>  dwarves.h      |  7 +++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 16fb7becffee56f6..f0833e8c44a944a8 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -508,6 +508,8 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
>  
>  	if (tag->tag == DW_TAG_imported_module || tag->tag == DW_TAG_imported_declaration)
>  		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_import);
> +	else if (tag->tag == DW_TAG_variant_part)
> +		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_discr);
>  	else
>  		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_type);
>  
> @@ -1170,6 +1172,18 @@ static struct template_parameter_pack *template_parameter_pack__new(Dwarf_Die *d
>  	return pack;
>  }
>  
> +static struct variant_part *variant_part__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> +{
> +	struct variant_part *vpart = tag__alloc(cu, sizeof(*vpart));
> +
> +	if (vpart != NULL) {
> +		tag__init(&vpart->tag, cu, die);
> +		INIT_LIST_HEAD(&vpart->variants);
> +	}
> +
> +	return vpart;
> +}
> +
>  /* Returns number of locations found or negative value for errors. */
>  static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>  				      ptrdiff_t offset, Dwarf_Addr *basep,
> @@ -1990,9 +2004,19 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
>  		case DW_TAG_GNU_template_template_param:
>  #endif
>  		case DW_TAG_subrange_type: // XXX: ADA stuff, its a type tho, will have other entries referencing it...
> -		case DW_TAG_variant_part: // XXX: Rust stuff
>  			tag__print_not_supported(die);
>  			continue;
> +		case DW_TAG_variant_part: {
> +			struct variant_part *vpart = variant_part__new(die, cu, conf);
> +
> +			if (vpart == NULL)
> +				return -ENOMEM;
> +
> +			// For rust it seems we have just one, but DWARF, according to Gemini, support having
> +			// more than one DW_TAG_variant_part for a given DW_TAG_structure_type, so future proof it
> +			type__add_variant_part(class, vpart);
> +			continue;
> +		}
>  		case DW_TAG_template_type_parameter: {
>  			struct template_type_param *ttparm = template_type_param__new(die, cu, conf);
>  
> diff --git a/dwarves.c b/dwarves.c
> index ef93239d26827711..efc7ae214376e1c1 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -428,6 +428,7 @@ void __type__init(struct type *type)
>  	INIT_LIST_HEAD(&type->type_enum);
>  	INIT_LIST_HEAD(&type->template_type_params);
>  	INIT_LIST_HEAD(&type->template_value_params);
> +	INIT_LIST_HEAD(&type->variant_parts);
>  	type->template_parameter_pack = NULL;
>  	type->sizeof_member = NULL;
>  	type->member_prefix = NULL;
> @@ -1366,6 +1367,11 @@ void type__add_template_value_param(struct type *type, struct template_value_par
>  	list_add_tail(&tvparam->tag.node, &type->template_value_params);
>  }
>  
> +void type__add_variant_part(struct type *type, struct variant_part *vpart)
> +{
> +	list_add_tail(&vpart->tag.node, &type->variant_parts);
> +}
> +
>  struct class_member *type__last_member(struct type *type)
>  {
>  	struct class_member *pos;
> diff --git a/dwarves.h b/dwarves.h
> index d7c64742c29a9e9f..95d84b8ce3a6e95d 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -1011,6 +1011,11 @@ static inline struct formal_parameter_pack *tag__formal_parameter_pack(const str
>  
>  void formal_parameter_pack__add(struct formal_parameter_pack *pack, struct parameter *param);
>  
> +struct variant_part {
> +	struct tag	 tag;
> +	struct list_head variants;
> +};
> +
>  /*
>   * tag.tag can be DW_TAG_subprogram_type or DW_TAG_subroutine_type.
>   */
> @@ -1281,6 +1286,7 @@ struct type {
>  	uint8_t		 is_signed_enum:1;
>  	struct list_head template_type_params;
>  	struct list_head template_value_params;
> +	struct list_head variant_parts;
>  	struct template_parameter_pack *template_parameter_pack;
>  };
>  
> @@ -1401,6 +1407,7 @@ static inline struct class_member *class_member__next(struct class_member *membe
>  void type__add_member(struct type *type, struct class_member *member);
>  void type__add_template_type_param(struct type *type, struct template_type_param *ttparm);
>  void type__add_template_value_param(struct type *type, struct template_value_param *tvparam);
> +void type__add_variant_part(struct type *type, struct variant_part *vpart);
>  
>  struct class_member *
>  	type__find_first_biggest_size_base_type_member(struct type *type,


do we also need some cleanup for the variant parts in type__delete() something like:

	list_for_each_entry_safe(pos, n, type->variant_parts, node) {
		list_del_int(&pos->node);
		free(pos);
	}

?
