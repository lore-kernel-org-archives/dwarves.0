Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7E396B8B
	for <dwarves@vger.kernel.org>; Mon, 30 Mar 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861540; cv=fail; b=jCTQKpus17u1Fw0D0pQlEJDfjb6jIGjbDVFuwuOyojXlSDpMn6mXHIw2W6cs213mK7PcVggC+yxdJXNUHxL5KCLgnWSowgK+3HGsSWLu2yzvFvrbUcovDKJmHSSigBtgSBOM3CIJzJnDHIZM8a3APns1MtqunGLs5Jz1GTqcsdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861540; c=relaxed/simple;
	bh=2L6BToZXBdOEmiLTXIy9PEwl4qvC60MkmSv4Tj7Vxpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zs53JJcoTNWeN9q4EJvPebVf7kPsATenAEb3o4QlloMx3XBTakgwa2IgqqO9IJgsjN7N4nB8l5aFyhhM7uZL9fraaIey3m/zlG1geJdomRLOmckiQEtqNSFoxRddZ8f/QtwF3rrLFH7QaGDw8KNv4aFCMu9pJtgaSjHSE0L7n+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EvCEIZaW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RgYvB90h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EvCEIZaW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RgYvB90h"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TMuA2F577905;
	Mon, 30 Mar 2026 09:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hFSgFUpSFf58pme7d6pU7g8mxTa73Rk+O6EY9njYQgI=; b=
	EvCEIZaWxJLX91bCGXS44WS1SmPD0z1HhS/Ef0u+heBftAhZI1Pf4ShZDGNKR8sM
	P57TnmT9IcxO1i9JbyAYATC/DG3j2o2fxv+bi4gUkZYW79bnuumdzAMS+2k2GFoB
	Pvrriy7eiMj0xmTFR/iSzz3eF5Wd6W5yThqJ6RqcZTV1RMIyTm7I+nfyiZ1ZFcDi
	JL4YR2oF6iojt2/jvzyHW24bYtlu5BxGxOVex2SrK5wFviPpAhqdwsSl2qzbLb6w
	qXL+CaegBZw40sVMbr2EAO0rjuOEM9q9LCCpPyvxKPudwBqE2ar5wNqqjPnCdVSE
	HOpU6HL5/1jIQMzOOzDwAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65jw9sng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 09:05:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62U8OnX8029482;
	Mon, 30 Mar 2026 09:05:33 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65e87mvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 09:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMpmN+hrFVOa23DD/lLRB34kNz2BGER/wFdejEMSID8ZP0VIFEvwOr7iGproasufySjsua6xHFx0LQFKSX4nSQIXtLgjoF02wnnadaeWD8AnQoPYZHN2UCE5+JrKxvtO5lhyUnELSAbrVY082s29ovhbtb/oO0ZON6hdaMeaQIQFb58A05YfaHJcSRXh5+PvG08TGY6J13xF+axSDPGLrKC/VVYMtDRIRcwUKl6C88PPMs2UT3VrPt91MTlL7fIHerfoGa84jrVPqxdaPqAB7HrN05iVAg7qNVrWBZxV91ZiXukpuzPnz/aeZhiS0EkemOSGfXHLkFAQ7j1QSV036w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFSgFUpSFf58pme7d6pU7g8mxTa73Rk+O6EY9njYQgI=;
 b=Xu1Go/W5sQvDpQ8AeHfFZJBkB2hMyrw+vFouY4OER8jxI933QxnDBCMguw6TDfl75b4ydUtQ7CwdvRFFKbvBLGGeNHYyR21WZhRfkCj8Iovm72Tbyyu5JCkLAtivHa3oqibDRrFFAyn0LoFpodY04kICS31DiFDM+tB594qyL0JIWtgKITePw3zVcS6UQ0L3cXBy175HQSqJIFXo7O+VYh0BGnfhsXfAOcRiFYqBgijuRfOCMFVS04s5OfGRO/nMLp/evWMXKljmtnbEOZo1C9z9LR6HUACNDT/8p3D+waNn+5T5UehzZXt2tUXQcMw7b14eY2otTqoUE6YSTJ733A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFSgFUpSFf58pme7d6pU7g8mxTa73Rk+O6EY9njYQgI=;
 b=RgYvB90hRghAHA8Fr7u9ZEwqXW11HVjW+iwmwEatIz40enOiivSrvPLVtRNP2z2udoJA5qFq7nZbfecWlAE+zIuM846O2GY9nhcuzDqVNkGNGNgBdp2UFebx23BwdDclhwOn7EonxgOiOSOJtgjv+b1CfXjB78L0pq8P01dmgGY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB5188.namprd10.prod.outlook.com (2603:10b6:208:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 09:05:31 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 09:05:31 +0000
Message-ID: <741f21ad-5b95-4028-9f0f-4818f00428ef@oracle.com>
Date: Mon, 30 Mar 2026 10:05:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dwarf_loader: Initial support for DW_TAG_subprogram
 in DW_TAG_enumeration
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20260323211533.1909029-1-acme@kernel.org>
 <20260323211533.1909029-3-acme@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260323211533.1909029-3-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::23) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 57699b45-b362-4f04-1941-08de8e3b7e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KYO8zg371HyVbQwKfQKbxewj8K+KRouKzHsc4KC/1oGjxbj+f6km911wBYY1DCbsVim/TBZwKOz7ZW9bM8OWW/umKrqIzTbbO6R/Mv+T5vseGvDiMUfcEQRi4x+wdx0wgReR9EzutCbKqzoXnCkZBP+gBSWcosyMd6zSoXeunEy5QWXlOkz5f4lE4sXI/TpKXYNeBav8NR9UKgY3K7/s29Su49vBZRzHlGMJyXDBwBqB6c7ofUgKIqn3f2sPiv+eicr5CGaTfMdcBck33zauhURy0FcDoINgCg2NHfQOkTQbbAjIqcmBo5Ac/WWtLnB/8Cz3xuGWgovXpNZXN3DdFUml5FoH9hleGqE0YsXYxfv0wssAJZewOhx5L8EehDTV7gB4x4ghem6Xs+23KpOqDKSZ581YHhnDox3RqQIUyLniE5jogM1JJ13mk7ZRTeNdWEMcv6pYvqOfNzObFt6G/znlVq4dQjrKed3KldqKzg45GdrqibqoANLY+TpF+AjYeMQxGoZm5G8ihy5nLaEm5UemOa2Yg2vH6iO6cac+mI9nsqXoca8M3Kn5SxuzWYoD2vIn64RP/FjxW53UAiCOL6ZIGNvQvTMvbXklkLheDoaqHecy/MsCiRJBIpjUeaRA0y2qkLHIEwDxbDfvKDCAbJoiTKbecr0LjuBrFO9H38fZlUfy8hjRk4ZRN+QskIBtM/wU6Mmp4xpJv8Gqpquw8qyT+bFAbWa5IYLf01mS95s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2pGeElFT3laUEF2dDAwRFgxZEs2NFRKaGNvaWh1cDFUdEpib1UxSy80bXBZ?=
 =?utf-8?B?dnlqTWt3OGVMQlh6eS9HMjRuQ2l6Sk9ocm5USzZpanBsdHNBTU0yZzJMMnQ1?=
 =?utf-8?B?dThYbDFXQUdSVFlCeCtTbVZiM2d0VXQxdlp3U1lzTDJHcVRnOXJrWndZekd2?=
 =?utf-8?B?c1oxUWhjdlVFa292TmZuYWl0dVAxc1doOWUvcjAvTTVaY0lrYU5pR3EzQkMv?=
 =?utf-8?B?VUZXYWg0WUdKb3hhS044ZUNHd3pKNzhWZTFHamg3bE9ldUVtUko5VzlsRFRK?=
 =?utf-8?B?QkdkTEpKMncwM2MvczhhZEpvbWR4N1ZRMTBQVVhGYmQ5OEVvQ1lITXQxdWc3?=
 =?utf-8?B?dXRmWVFHaVA1NWtURk1LdXNxOUw4WlpidGhQMEE1Yzh3WVlMaFJodG45Qk9S?=
 =?utf-8?B?TWptWmJYcTAxeDdYRGNvYVd6N3k5a0dXdTIrakRpNFBCemRzSFpQR1BkWHNC?=
 =?utf-8?B?QmI5ZFJPdGxaNlVKbk9IQmpzWWV4aVh4Y3hSVXJlRmtnbFllK2o5ckNEak9F?=
 =?utf-8?B?Zi9lNE1EVjYrZVJ4N1FSUWFlTEhRV2l2MUpwQXlZbjNWNzR1c3dwZVhyYnVB?=
 =?utf-8?B?K1RFWGNTOXQ5dDRMS2NTNWRVNnJhWXhCSjQ4d2FlY1ZKOFp6K3Z5TUEyUlFx?=
 =?utf-8?B?NEprRXFMK1B1VkJ6UCtRaTQ5RkZqWEdrSmtVUU9ZUnpXNFdGbUVXbW1KaU0x?=
 =?utf-8?B?djMrZDNFZ00ya2xremNaajMvWUpIUVRQT2RjSVl5MzM0em0wZThCNFcvVGp1?=
 =?utf-8?B?bkdsVDJNNUVXN0NtZUsvTDkwNHEvbVlDTkhKZjYwaUlndXdpZGlMWC9zemNt?=
 =?utf-8?B?cFhodUhSR1R2bkQwUXJvZ2FlYk53QzNrOWN2QkdaSkJqaE1MdGt6eWEzbWQ5?=
 =?utf-8?B?WHhuOFJjcHZmSFhveThWbGpiRDdvOEx6NXhyM05KZ21IN2RzdE1ZamJNOXpp?=
 =?utf-8?B?cnUweGpDUHBqUkZpeDhTbVQrRTNlM1lFdWoycFhyRE4vKytTRzQ5Si9EeDh0?=
 =?utf-8?B?dVpTOHdMVG5ENnd3UjJTYUFQZGt2TlpFSzY1UnJMZTZ1NVZxMjZsSXk5YStt?=
 =?utf-8?B?citiOFdORjM3blFVbnl3RjJsZlNHWVpwUXA2VDJ6SVhRa1RMYnlVWlF1SmlM?=
 =?utf-8?B?YjVqMkh2eW1lby84T3UvdWt2eG9FQXRTZWQ1R0MzVXJ0K1k0KzhSWTAxbUUv?=
 =?utf-8?B?Q2JnMzMvMGdBRWZQVVlVQ3AxN3RKSW9FdHVBcWxRQ1NnQjBvNU5HM1F6NlVs?=
 =?utf-8?B?b29GdXJwWmUvMGdXSmxOL09KWDFqN1NjV1BxYWFHK0czbWQyQ1pvU1ZZdzJl?=
 =?utf-8?B?ZnlyTWhqY0YwZXQ4dzgvNG9oSDY3aXhaVlZYT3RGSTF3Zk0ycld5aFdCczgz?=
 =?utf-8?B?TENnaEFac2dMQkYwZFl0SHBEcE9CNmM4bDcyWmQrWTZlZE85SW1PWU14UzRO?=
 =?utf-8?B?dThhVnBaYWo3bGtqUUVMQ21ydVAxNnJPTVpKUk1qWlEwNE43Y1dUekFGQzdD?=
 =?utf-8?B?S1Z4dEthTzBubHIxd0xtTFV4VFMvWFZBZ0NRZjFZZWVtOHRSWU94U1NsdGJ3?=
 =?utf-8?B?cDdCTWs2bW14MHJtSm5VVjZ3WTVuTm1PbHlmdU9qdmVNUlpQWkpTNVNXa2Rk?=
 =?utf-8?B?NW9vNDYvVGFrV2NhRGxtNE0wZXQzbFUzTVlIanV2UmIrcTdhVWdmekdWTGlF?=
 =?utf-8?B?cUZtb25PeW45ODZHSDE2SnZKQjFPRlNoUDJ2cnJ1d0VxUzVBcnpDNDZqNnRI?=
 =?utf-8?B?WVNDdEgrN0I4eHVBOUV5WHdqVUJtLzJOWklHMi9DWkg0aGNSZTM0bHRycnBI?=
 =?utf-8?B?MGp3SEhuV1VOTm14bTFLa1I0QjBIZ2k4bjBvR1BmNXg4S0RFa29WbXg5bFJx?=
 =?utf-8?B?RlFCbUNUbVl6V2Z1NHBCT05DeUxraFZaaFlLSU9aSDFhQ1NqU3l5RlVjRmgw?=
 =?utf-8?B?Tmo3SDkrSDB3czhzZUx5c0M0QVhhaXpWRnpGWnFCSndrY3NsS3ZBc21RYVQr?=
 =?utf-8?B?dFJKQzJHL2ozU1VKZVlUYmhyeUVBTjBJK25uYUR6akVwRE5UMmVKS2dhVW1h?=
 =?utf-8?B?SmdMUHFhZkU0VUo5eEdONEZvaFJlYVkxTkJCMWJrcUI3dlcwRnEybGo5NzVo?=
 =?utf-8?B?dFpER09EVnVxT2FES1NlN3prT2FObmFZZlhRT2xnTk8wa1JURmMreXppWWxO?=
 =?utf-8?B?clZoMTJpUndTWGFDTEFVZWtiMkwrbjBiNHhyTXc0a1BMdWtUQjFrcVhBNE1p?=
 =?utf-8?B?UFlDdzB5UWFLUmQvdkUrclRaK2RqT1laYUNpZzhRNXU0VjF2bGh1a0hTZ1hH?=
 =?utf-8?B?VWFsb29Lb1VFVEUrVnBTVC9mT0tHVStQSmVaVSttN1g2R1BnODNZdz09?=
X-Exchange-RoutingPolicyChecked:
	TE/2QElMxeD3whImurlcJSqvKYYw8zLed1GD8n+OK+uuP599Uvv6+HMrMfUs7vsQYxWh3Q6yYTcGveQaBD8vfT9xOAlJBLLAeITYqnkT8pbi0XpJfhLAgNq6zSTglTV9+/bIWZYX7elmFxpUaVLoQaxFIiND54fYb0IAVS8T9aQ2tPsz9r6mGXpgUZjSUqNKYY5uqz3nnVTVov6NhRtK/DCm4KSG1ivBsf+vrOzh47fUcdidfzu85xMQBUbMq0Kw77GfgLX6KrkpXDVdNANa15UwQyLfXOCUUHXYubphiDUUVzs2qtM55O29y/xOopVB+Gex23SBzcf/bDnayTta4w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0czddNdm9zimg+O3fvV3uK4Oew+sblYbLJQZ556huEGDPvH1lkWDInfM9qTQ+aMwwTiIAUNknz5IIEd0WZDm6fN3Z+OhhVTqEQfb2RHrAUbn5ROPZ0MfaWks0/w24172Lnu+PdWemHLPvkwGX0UtzvI8Qno2c3+laluIGwci2ZeTs06fM6r2rrwbh0o8foEayRGEKqSWG4J+NCjilf+P3Pk3dXiZpMUXkrDKvLXafs5HHskWgb42FT7EQsQNcPFvbkI788Q8LE/77yflIbzczf7QNWdLrkeAw9n6vK4r4vJ2G8Y1w09dsgUO/jkd06EKdgK959ZrLQ6t47wfHrab4hBlzYe/Fpmg16to7bvQVlcKeCPzkFKSghw+kF+HD7vkU2gXxI4qUfc4IRsKINMNbX99ff8EFFCk6AG0R/prd2ZcETl2koJr4COdPyTZIhLa9zq8FO5SASCy7QtZKTmYxlxTALsNDOwfK9d/DOK5XELmQZNZiBV49dTR0IywcpTASpCPut+Cn5yyAWw/GXfkExkrATfFkGgOTpW0CKVg45OUs98Gd4x/1Al/dhHrVcLZJhUex0zJc/e94YcZ3SBuU7YgTcyDCKYdfVoIp5WpDNQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57699b45-b362-4f04-1941-08de8e3b7e88
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:05:31.2092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpTHieNtQmNcQUpNHuuVWmujlZT7lUtYSqaXLBp4n5vxijbolNDT80ZMBE8XFq/kkzwVCd4Pc9zEQ/NpdEo46A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603300070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3MCBTYWx0ZWRfX/0w1bbzaICwp
 TEDGbTxVsJIYXV93Rx03Rxa6w/eW8ZuFKMCJXpDwvL8NiBnb/qMgjoooO/OuWyJcqbM/KIMcAiv
 TjB3UWDbIBQN6wND2BYkYGr5jL6LYQhAlBZ3rU4q9ZKAwORX074s9sIaNppuzOvRfkIsdp90cnH
 7O0BjVMjAFT3waLhDU9+xpPVuvdO+7rrduJpgel2nBqaCeXZH/DBTo/4vQxSN1bfC0JFj4PJHYp
 lvD8E1oLLLJ2PJFZuSLdgySAU60/YG9WcbH4b7HwC/U1mDHNDmV9eXsrsMyhWC+PjHADHbazajm
 cWWIK3wzMHrky6xGgHsiA0HBPr5z0X/kmecKWBsPIJ6eGADoGVMIZO1AjDMUzqI9P8QLcf6s7lQ
 utUebGLRvWSrZ3L6k+IvRFojk0iaRd+JmZasoIabBLTzd3qpQipM80+04q1/SpDvvv09PHalx+w
 Ec2lKmM6qsRWVRc5Ljw==
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=69ca3cde cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=_nt0qgtSTFgWODJrQlsA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: QB70xLf4Sp_nPL2t0eE8w7puYF-qEQP5
X-Proofpoint-GUID: QB70xLf4Sp_nPL2t0eE8w7puYF-qEQP5

On 23/03/2026 21:15, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> In Rust enums can have subprograms, add initial support for it.
> 

I guess we'd need some form of enhanced enumerator kind to support this in BTF,
since I don't see any means to enhance the existing enumerator kind info to
support references to other type ids like functions.

> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  dwarf_loader.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index f0833e8c44a944a8..b5a92160ecf82f74 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1943,6 +1943,8 @@ out_delete:
>  	return NULL;
>  }
>  
> +static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf);
> +
>  static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  {
>  	Dwarf_Die child;
> @@ -1964,18 +1966,38 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
>  
>  	die = &child;
>  	do {
> -		struct enumerator *enumerator;
> +		switch (dwarf_tag(die)) {
> +		case DW_TAG_enumerator: {
> +			struct enumerator *enumerator = enumerator__new(die, cu, conf);
> +
> +			if (enumerator == NULL)
> +				goto out_delete;
> +
> +			enumeration__add(enumeration, enumerator);
> +			cu__hash(cu, &enumerator->tag);
> +		}
> +			continue;
> +		case DW_TAG_subprogram: {
> +			struct tag *tag = die__create_new_function(die, cu, conf);
> +			uint32_t id;
> +
> +			if (tag == NULL)
> +				goto out_delete;
>  
> -		if (dwarf_tag(die) != DW_TAG_enumerator) {
> +			if (cu__add_tag(cu, tag, &id) < 0) {
> +				tag__delete(tag, cu);
> +				goto out_delete;
> +			}
> +
> +			cu__hash(cu, tag);
> +			struct dwarf_tag *dtag = tag__dwarf(tag);
> +			dtag->small_id = id;
> +			break;
> +		}
> +		default:
>  			cu__tag_not_handled(cu, die);
>  			continue;
>  		}
> -		enumerator = enumerator__new(die, cu, conf);
> -		if (enumerator == NULL)
> -			goto out_delete;
> -
> -		enumeration__add(enumeration, enumerator);
> -		cu__hash(cu, &enumerator->tag);
>  	} while (dwarf_siblingof(die, die) == 0);
>  out:
>  	return &enumeration->namespace.tag;

