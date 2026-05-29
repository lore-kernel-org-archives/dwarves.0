Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2C1CD2C;
	Fri, 29 May 2026 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061062; cv=fail; b=M7vwfAnK1Xf7inEZrf/Noy0D5BhJoQ04BLOOAMtgcjMGHecfHb38Bt879FxPapVRHKrMYrXp7njoehkX6Pshk3bieMGTb4FHau1c8lVHWjF0WQx0jeQ827ihU9rsHVKlAh9t/1XhxdBdTtUVjF7WSLJ5GnaJwO5PeiPsp7Qwy2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061062; c=relaxed/simple;
	bh=qNCoFKWpSGulPMkaNSdJ6GKStxr3OytJWfTEA2hmeSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mrE15cfLZaEBcww2V7lIE1xedvncRLvN1e4ByexgM+hIdDGrlv5Y4xCMDPO8hk9vmYIQFE7oUJ+QK4oVLlLszzS4YJgfw2N5iqzd+nh4btteulx1wmvPwbLRD3ZAZuJoQVzWhTond4x8VHgrzGzlVOUZcGjUEIjnxJUfi/U46Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QMeD0ZG4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Js0oKT48; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QMeD0ZG4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Js0oKT48"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6gCHr786016;
	Fri, 29 May 2026 13:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Q0hgFqb1Hqiijl+sRdrZ30EIyetUNChwjR1Tnxk+XhE=; b=
	QMeD0ZG4YE/XqiAX2rqHkZz1JNHy3uVuEmwODPsTv3hwCPNXdGeCkABMG/cljdO6
	N9xKZ2UudCHKApbyuYbO5lZKBizQSPSSKHRrObhxPYWzToAiUjlr/IiVffAnSseO
	pYp3Ze616IVs+lWqQfhoG9XMCpdY3+nr0KI0q6yROdH70IcK4RbqOw9+xAYH6qYT
	/XRoNw6f58keHmCvDe7gxnUtacas1bU7n6Mi4Bfrifbp2DVgyQm5cMZ3OWohTgYw
	Vq5IxdZWeWSxSlHutHs+el6ha5S6Ljfqlo+gJ/1grRqz0xwj0vXJzHAj0P+OR06Z
	pi5C2B/fiEkz0phicENs4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ee7wk2qja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:24:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64TDJvEM015672;
	Fri, 29 May 2026 13:24:10 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4edjs4jdyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:24:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcIQXc40t/Qmltq3Te4bLThkeoyztP+odvDFPBOkqJUtgmtzIBWVRwz5KeBNbZv3vTRyOUjmL/mpeDuToCNxufQno14Z6e67I0z9MfK5C/CpqvPm5zACBsi2BtTFCafd7LyNU+mdXOz4Cj+qupa00rf9SyJyYW+ria7B4RLH2XIu5YDYPqZwFnkbUC1Y7xcsWJzOCn0eoYipQDVrk4tToIIohjfS/NrgwoUcNEwNq4YFSJPdpxo3Hn2he7gBleJFVzzOlcBF4SJXJ65qMME6lOldCoPVFHVGAXSNYdL2jFX/5WicP5gKQ+1d7m4+PBOM+WBIGQHTy1ip9xzHbws+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0hgFqb1Hqiijl+sRdrZ30EIyetUNChwjR1Tnxk+XhE=;
 b=qGy+p7L3ZfzCupoa7zKu61mk2fQRk2/4zp3+OSJxngjkNwxim/YajN+6wWbvjx6PXoDmaUSWor6Wk4ytlGDgowtealrs5MxjEg/gvLNnJuyaId0RNuMA9h/bHAI/fKVqklH0LdXj4pMoFkm3XNPZHEyaV+ddL0sDw7l4553l27G8psrND5YgGBQ/9gekkWBtj+Qmk9H0xiO6KE55swlmoUD3Gxj4hnJg9Es55AIsb8EH6n8/nQsjEOZeKO8mCMjU2pwkKeK9nbXwvhacKpS9BQlBHifgBiC9URuOT2IQ3kedpfFUn5xkkVcqx/1fq1xSmucY7UVr3rH7vha9Ymz60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0hgFqb1Hqiijl+sRdrZ30EIyetUNChwjR1Tnxk+XhE=;
 b=Js0oKT48lHBQuR4e6+WVli697HH7eiVtVEKHgBhTlaKYXwaR9omAOfICvxVl87ZlXZwFdJ1u4yQWI524iBCzy2q0GrEp7v1Bgu6d9XYacg1YKhftZhrUw0md1/hIepbrX/i1F541gWqMlmfHFXvNuXcvECQgVwknBc7zhP0WbTI=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH0PR10MB5642.namprd10.prod.outlook.com (2603:10b6:510:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 13:24:07 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 13:24:06 +0000
Message-ID: <8c8826d1-6534-4aef-8129-5c8da61f731e@oracle.com>
Date: Fri, 29 May 2026 14:23:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PAHOLE Patch v2 1/2] dwarf_loader: Extract
 die__add_btf_type_tag() helper [NFC]
To: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, acme@kernel.org,
        jose.marchesi@oracle.com, David Faust <david.faust@oracle.com>
References: <20260528223616.2035618-1-vineet.gupta@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260528223616.2035618-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::21) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH0PR10MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f24372-450d-4092-cb4b-08debd858efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hcjkHnmWYX1RvEKTM0nLyLvJg2x8QE+Y/b6ul4FKs5QND0CxBljEKpjgltzNwn9PScvpnQYhi13WTZumc7lkQ21WWhHeQ9cRS2sI0k5zX0aruPoRiWqrhmWrf94WzA2GK9QXjZkKVtw5ywsFq88TtH0l+TyawBIcBjhypiL/u7qSSsiGpdrIKn+LYWTcWxd8/E+O5FpCCcu/p6dIXv5vnhuimjArGezmxR2oEwW7tr6gp5dmtDCmkeXAaQliw25rSPs4PRtb107Wv+xRsjRMNFdaanA7Q8HJ5G/0dZZ1ir0+yCTjBqgC8ZJSmXDGCYI/IZ0ifl01R2p8RqhKwBHBPDgNsVpRHNLk4OPkPi4opsjxML++9NkWue/JbvIcgj1W9/ru/kOchWKMSa+9m7xYAGvYm4aIlAZA1w/mpg6e74iPdw96/zJCAEsiKPEKG5SL5vvkhZPGN7nIcyt+EqnlW8ExGP016ruZkVr2HLvkheID2gd5U7/UBYx8RsP/fvptoRo1LZw23XK/Y7czGKh0tbhYrEi0OB/EMQJcwOa4B8r2yZMUJYFP/fV68Zr9D31qb/ZOFXq4ekj69i05FI52O6Jjoc1358RC8mIVvGOljSYvndVS6UpBSonlJlkD+F/0JrNoXzum+3iiKSUG2vU5Y50baAVQOsEcXAk/oL/ypMcqIM3BvIADojpBZJgHNdiK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmNYMDd5a3VhSGE2ZmUzYUw4L2ZucnZaQTZ5OUVSTkRhdnR0VTgwUmZWYWx4?=
 =?utf-8?B?aXBEUkVzNHE3UXFqcnJpYnlTS3U1aDlYYkY2dVFaZWZMR3hEY0lmY21Xa0VF?=
 =?utf-8?B?WHBlUnBpVGJyUW5Rcmx3RVVZTWY5YmhDMGhYemdmeFU0RTFnOElZSVVJSFJF?=
 =?utf-8?B?N2NPVkU1U3BIbDkzUHZEQkc2bERsWHdiQmV5MXphcTVkWVpVZG40aFZvY3k4?=
 =?utf-8?B?SlpJVU1tRzR4eGdidGNYQ3p1azlONTBlV3NjeFMxZk41L01qZWlpK0VSQzZl?=
 =?utf-8?B?UmlDMEpyZk94UU9QVi9BczdpV3p5SmFWMDdqQ2hISXp4dk91aU1GR2ZHc3lu?=
 =?utf-8?B?NlJwdUVaZmhHdURsQlgwVmE1UGthdDd4bU95TmE4dEdGTmlBTlFWN3hLcXly?=
 =?utf-8?B?VWtiTFB4ZlVvMlFnYTBqWEUydUlWL2gvZ292eHlKS04yaTZPNFAzM1FsUXVJ?=
 =?utf-8?B?N2RmdGF6NlFXalhzdFFzcW5QNUxQUkMzSHpBSlRMV2laNUJvUDBZRTZpOG9H?=
 =?utf-8?B?cWpJckFFcXZrdEczWFM4Njd0Z2w3UmdwNHNPYU9EQjFmd1paM3ZQNnBuRGoz?=
 =?utf-8?B?RHJXVUlwbS84N2t6R3QwTXp6WHlIaitJeWZzOXlrZi9MckcrakpLclJaOVZq?=
 =?utf-8?B?MTZVWjl4Yk5XdHhBdzNXSWVoWFBYRG1EVGdtL1QrYmo1ek1CNVlRL0JJWjNQ?=
 =?utf-8?B?ZktuL0NuSWl4Zll5cC96ZnlJVEJUcXFJNkVUMXV6MTkzNUZWd1ZOKzhsTDVi?=
 =?utf-8?B?SXIySUo0cDE5czVxZTM1MXRQQ2J6aEhTWVA1SitOc3NqSlA0SVluMzdQWk9E?=
 =?utf-8?B?UnBGejlQRUM2aUhVbExyVE9paS9EK2JkcE1oTElPVEh0b1pTNEtHVk4rSW1x?=
 =?utf-8?B?WTJiZ1VQaVIvV0UzN0VqQ0sxbXdjU2ZRUGJ0cUE1ck5GS0pXQktsNnVIdEd5?=
 =?utf-8?B?VEZKZ0RZdldXa000NUJCbWFmaWhDZDE3Q2ZOb0hKT3VQSUdGUCtPdksvQVFh?=
 =?utf-8?B?aDZ1dXVWOVlsWWVJNmxFbnFlWkwvbXpDM3NqSHpGeW5rL2Y5RmJRNG1VRGJN?=
 =?utf-8?B?aHU0MTBDTlRmdnRjaklpN1k2MTVXbjI3QXBmeFZIanN4Z0hhVlhWYlNaV1pL?=
 =?utf-8?B?ck1NT1J1YWliZk1lcmV1anl2aDVQK09FS0lSYWxueERFK0JhVUNNc2IyYm5M?=
 =?utf-8?B?ZUlUOUN2bjdlTVlEaE54enhJcjlTeHZkemowdnh3ZEFEVU9oMEttSjUyV0Vr?=
 =?utf-8?B?WVZDc0N5a0VYcXdZcURqd29aY3hVS2o5dTFrbDJzSGtXTjRGSi9seTdIeHly?=
 =?utf-8?B?RFJFWjRGYVZYdEhidGxETER1S1paMWIxRjh5aW0vRWFReU91SDBucGwyVUdO?=
 =?utf-8?B?eGVERnJOZTdGWWJuZ3BEU1gwNEJ2bE9RVjhadkxVV1ZSQ0hTNENWeC85cHNK?=
 =?utf-8?B?UzVmQkdGU0FjWG1pQVg4N1BlT0l0ZTR1Nk02WW5qd0hoWlpOZGpxMTRaQndU?=
 =?utf-8?B?TWtZMThaVUh6ODhNbGFELzBsOVBOa1VrRndneDdHdlVkUEtYd2lIU3BiLyt6?=
 =?utf-8?B?c3JFN2VKRURoUEowUTl0WjZFUVJvQkVrMTBLSkRmQnRnYTZtNkxuK1VNV1Uv?=
 =?utf-8?B?UkZBZTN1QitHZ0w3VmRBUWFlY0JDUi9iV1dSdElvaVd0cjBkdDk0RWdjTFdp?=
 =?utf-8?B?WjdoSnpCUXhnTXhOaFRkNkdNL2VQZHE2akhPT3RML2JpcXc0K2IyVkc3M0RQ?=
 =?utf-8?B?QTN4OU9kVHhGZUpseldablloZjVlL2Mvd2diZ2ppOEpNUG9KbXF6Qm1BWndR?=
 =?utf-8?B?MFJ3WTZaV1N6TElkT3l6QVFXMXU1MDVhcnNVZXUwbDI4RHV4ZURqUmhnZHlm?=
 =?utf-8?B?b3M0a2lhT0g5U1l5S20zRkZMemF5MXFOZ1dVcmRFQnI5SCs1dGl5Q3hlbTg3?=
 =?utf-8?B?dzVxYS9NS1Q1MzdVazc4SkRWZGxpamk0M2t4SnJEdDhxdzBjNWIzcGI3cHFq?=
 =?utf-8?B?MDJEdWo5K1cwcEJTa2M5MDgzcEowMk51dDErNCtTSDl2b3BjdnB4QUJQU0ky?=
 =?utf-8?B?YmdrRkU2L0JmYTVPV1RML2s1dkh3RW13L2JEWjdwQys5dFZ5ajZBRjVLbkln?=
 =?utf-8?B?WTAyYnFZSGhNMnJ0MGxXN3pRZTNYS25RdG1Mc3MxTEV6K0h4UFlyTE9oaHFs?=
 =?utf-8?B?c1Ura3Bscitya081dmptTE8wMUNEUnIrallvMjVmVVBBTXVvMnVIdVlpQlZT?=
 =?utf-8?B?bHFudDVCdlZOUXU1TnFJSmtYeXdIK0ZnYzFhYlcvUGxUU0RpS2V3NEJLZzlP?=
 =?utf-8?B?K3dteTNBaDFoOUcrSHJkaWp1WmZFTXJDNUFWajdrSGlkSXh6eHBVUT09?=
X-Exchange-RoutingPolicyChecked:
	r9VZWzKGPusJcGayAMuuZgJLioiBWmLd+2gYXpZwVWhhgAR1g+mRYHNEHjtE4SuEHbvjKYolYETDi/pFtFuGJG+5esQy3FfE8hVqdqt8MxLtc+PP6rSIhXYaJSbFxQ61DraFdiyXkHDK9lQ16Y8aRZpyHSQjVllyAK1RxZXfNrMgxKLFVcEsus0hITQFGy9cWxXaKZwp9+VfTYPwityXWMFirayRCu505/SzLVL+EWhtc4RaMRQMI8YlRQK40Ewktmc2Dv/m0yA14cEIcuOhwgBEZctX86sIz+i0+pwZGBzfsZehwYSRhKDttPX6uaSdQAuQmzbcNmnc/MREL3oHYA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yXEQCUE+TYzpmT/hr322uTtT4fuq3LtwIfqvEFaVfPoq/BERLPQtJKWUkI/Bc+EK4ZJgU3kwDlu++WP7Jgm/I76OmbFX4/BM0cBci0dAu3d7NON7jjOKSeyCBI7RCFgSPIklU1R4zQmN77mAOAyc9yJEt2OoIT8qhOIh9p6kqPZzDqVm4HZWZf3uHIy+vM5w8UrzKrE8MIhutnSwhhCoprV0fD74WZ2sNvVLJ0R52ZVcdktfBtlEMz179jtj1DAKptRVIIgjkS9ck2nSW7Jde0WcFEAzCORQpkQm63W9+topK1s4Mwcln9rBAw5B2ADP/mghBHsChlX3pcNO1FBWcBhA9MMQ6BdodL4HUz9T7Y07DYP5xcQhw8J+GINv3jE673HiMMVM100MDOUKkoTYv9GERg0G0e3Y9maM3iSJ8fyulRj0r+Kc13u4olQzYu93XCjsKKS8ff1orSa93biIO1CM9WY6RYRSH3ULuHQDzaaEJhrEQ6BAEpBhRHeD6pKx+bJ40oDtGJ3ki0RddNOV11uf0EF/rcGoSdOPGRRwwKiENsf/Zfc8fP36xB/9P11pTAf2B4IhrfFfkt42i6A8ibOG+pWkYiPKntuEsluqkzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f24372-450d-4092-cb4b-08debd858efd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 13:24:06.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fPe80MyZRNRYUg2Ks78Q5SAilOooIv5UbFzBX8g7L24zEwwP1F86kjWj97W2t6iQFrpRqVCnv2HGN9PKAUOCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605290133
X-Proofpoint-ORIG-GUID: UIzjnL1B_OoKSe4wH-rBLIMeWACZzulx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzNCBTYWx0ZWRfXxM8Rj2835rDF
 FysZb9PStE6j5+aGqfYKhMEcPrftzZTM8/KC1QVPCArLaqramBsaXMNGJGmxeKebt/zVCGl5ZJb
 43fmTG3zNDhnNge68HXp1SlgNvvMzNLQnQYJH5u9iCrQlPHoI42ZjU3M6QsvlmOMtQnaWnaz2k/
 5xztkuwSnNZDG8fNM+cwfviGSCzrsiXFGqVkut1eEi16x54fmORv/QHGu8tHEe8aK9Wwv2fQmgB
 OndtRHC0mtP3ul5VURVqmErfsuuQ+4h5XUWvhHEeFHDXhY+HEAVr6eA2E9+JQX4f5tQCTTIF5lH
 voBt8+E51d6XMhrrl5UwDijJ/5o25KBN8eriSMyrOCVlUGHMpLsNjKQTujK5IoTx/4IUUJ9oXgm
 GIbPqiarWieLdc9xkBHJQclNQg81LXYnXMwMokpU0PG45P3iei4SBVvX3vO6sVRxNFEsx51yB2f
 /NMq22oN9OyI63jBKcg==
X-Proofpoint-GUID: UIzjnL1B_OoKSe4wH-rBLIMeWACZzulx
X-Authority-Analysis: v=2.4 cv=UbxhjqSN c=1 sm=1 tr=0 ts=6a19937b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=Nbg9gYEP1KFyRsMC2noA:9 a=QEXdDO2ut3YA:10

On 28/05/2026 23:36, Vineet Gupta wrote:
> NFC change preparing for DW_TAG_GNU_annotation support.
> Extract the btf_type_tag annotation creation logic from into a helper
> die__add_btf_type_tag().
> 
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
> Changes since v1 [1]
>  - NFC reinstate some original comments
> 
> [1] https://lore.kernel.org/bpf/20260526181818.4159927-1-vineet.gupta@linux.dev/
> ---
>  dwarf_loader.c | 58 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 16fb7becffee..8fc9a6794f2f 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1600,14 +1600,45 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
>  	return tag;
>  }
>  

looks good Vineet! One small suggestion:

> +static int die__add_btf_type_tag(struct btf_type_tag_ptr_type **tagp,
> +				 Dwarf_Die *die, Dwarf_Die *adie,
> +				 struct cu *cu, struct conf_load *conf)

maybe just change the function to return the struct btf_type_tag_ptr_type *, 
since consumers just check for non-zero rather than doing anything with the
error code?


> +{
> +	struct btf_type_tag_type *annot;
> +	uint32_t id;
> +
> +	if (*tagp == NULL) {
> +		/* Create a btf_type_tag_ptr type. */
> +		*tagp = die__create_new_btf_type_tag_ptr_type(die, cu);
> +		if (!*tagp)
> +			return -ENOMEM;
> +	}
> +
> +	/* Create a btf_type_tag type for this annotation. */
> +	annot = die__create_new_btf_type_tag_type(adie, cu, conf);
> +	if (annot == NULL)
> +		return -ENOMEM;
> +
> +	if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> +		return -ENOMEM;
> +
> +	struct dwarf_tag *dtag = tag__dwarf(&annot->tag);
> +	dtag->small_id = id;
> +	cu__hash(cu, &annot->tag);
> +
> +	/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
> +	 * the tag->tags contains tag3 -> tag2 -> tag1.
> +	 */
> +	list_add(&annot->node, &(*tagp)->tags);
> +	return 0;
> +}
> +
>  static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
>  					       struct conf_load *conf)
>  {
>  	struct btf_type_tag_ptr_type *tag = NULL;
> -	struct btf_type_tag_type *annot;
>  	Dwarf_Die *cdie, child;
>  	const char *name;
> -	uint32_t id;
>  
>  	/* If no child tags or skipping btf_type_tag encoding, just create a new tag
>  	 * and return
> @@ -1627,29 +1658,8 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
>  		if (strcmp(name, "btf_type_tag") != 0)
>  			continue;
>  
> -		if (tag == NULL) {
> -			/* Create a btf_type_tag_ptr type. */
> -			tag = die__create_new_btf_type_tag_ptr_type(die, cu);
> -			if (!tag)
> -				return NULL;
> -		}
> -
> -		/* Create a btf_type_tag type for this annotation. */
> -		annot = die__create_new_btf_type_tag_type(cdie, cu, conf);
> -		if (annot == NULL)
> +		if (die__add_btf_type_tag(&tag, die, cdie, cu, conf))
>  			return NULL;
> -
> -		if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> -			return NULL;
> -
> -		struct dwarf_tag *dtag = tag__dwarf(&annot->tag);
> -		dtag->small_id = id;
> -		cu__hash(cu, &annot->tag);
> -
> -		/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
> -		 * the tag->tags contains tag3 -> tag2 -> tag1.
> -		 */
> -		list_add(&annot->node, &tag->tags);
>  	} while (dwarf_siblingof(cdie, cdie) == 0);
>  
>  	return tag ? &tag->tag : tag__new(die, cu);

