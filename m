Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785B3E6DE2;
	Wed, 11 Mar 2026 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252680; cv=fail; b=Tjxp7HPatzP/hn9H4tvXdzZSWa1zSGmzXv5O1p+Wi51m6T0ltdCa/43Ugn/XUnwXhJMwM1TPIrbeUzJgwcX631IfIzPpsmfx7+M//n8uWgN52BPPY5e0P0C3K0X3wEh6cCV4ofEHIwNal5ttjYBWor1tRre9k6eE0e202D8OjwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252680; c=relaxed/simple;
	bh=YQSXhXOK3IVdOMW6ufURJCKQ7777+essP0y0WsM0aU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fbuEQTkBXgX6kHHlJh14Ht9Ba0eB1HrHrAldkFTSW/rAtjLvKZRHTMJp1RYkmeblC2zv6m50eoI1wGHjITOt3hmFs/kgFbMy1CIrC2FLx3Kk8EsC4fC1H64dIg9YxbgTtYaxc9Rgoiw5xxVsLVKMnNbfW7sXdZdrGrGgU/GlTjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aOILbtmQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=awVZDzNW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aOILbtmQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="awVZDzNW"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BHMfh02334243;
	Wed, 11 Mar 2026 18:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1Cnjq3ekO9F2yKGH5sEVVOBRHzQ6jJMH1Q7VsR018X8=; b=
	aOILbtmQQeqQo2EPB2e99XBS8LFTPF2bdaZOPp8VnK3O7LQgGxZwFN9IQ6vZvJGp
	glLslPx5zO5kq9jTLzBMRlXalM9gYJiQmh6vsers6KxzOJzQy6pL1FLkMehIe/8a
	ZLhKYUcjZ4Ht+6qESJ/nDGMav0BsI5GmqdeDp1LnvLwokdi00pP61oV3paPgl1D4
	rMU36wuuoeOTFIqXODdLuYu8UjcSeG3W6f32qe2MfiSFuSfS1sYj69Ie4xykm0o2
	47LWJXlJ6pT3lBTZO2jX91N6+hovA/CwUGGMveOT92aKuXQSDua/OPMrmTNwB3Uc
	HOP2/1RZIMuSXs2chmUugw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu4sts0am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 18:10:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62BHE7pi038456;
	Wed, 11 Mar 2026 18:10:47 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafg5fcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 18:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeU5BsWh4SDMDyeG7MG9ooj3BUeS7WKCGJPssOOWU0Shth7qXNQ0ZF2zKZ82Vc/TLNPBcPfWiGyTtX0uAZMPSpZ6h/vnITW8YACBtT21AZ0KzvGObAfp1YJvUizqRWHDaahgrBkb4fKJ6SmTAUqB8etSghcQ4SGnNTX4ZAlTjh8u2P2SKCJJ9SUjSCFmIrUwcOkAjR7Hov6v9fllxzvk5wSjksiNCvV+qygTfwb2g/Sy/mRfygGusoxGHRr6dkz+oOTs7gnUJU+ujWKIGlMXmv43Er5JEgl3/MUGHr/g78LNXyTH/fHmN/avVJbgJlr6jaaN8naLvyTjg+eI0A9fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Cnjq3ekO9F2yKGH5sEVVOBRHzQ6jJMH1Q7VsR018X8=;
 b=wzis/6Yowx8XS8m0mDAH0R+zqSFGGi5BX9dd2V9aLZdj57kjRtlbDCccf9Ui/3UTbFKb4mrU+H0tTfTIHDW9Kf42G9Y1Jz2o/Hr9tyWkJulHBoycFvxpatVeTlvx+1CCVV/1IAtjMgPO64FV1tcvykDrjXC6p9LMZVMJToLhjtOoUKKXrrT8nZlxq3Rp5DQhBQSiJe0W7nAtio8+qRNQ0U9TRfYjjQSBcD4aQovkcRLWXbnPbv51+9vOB9t34LMCYJkbwDny0a56kAOGeiOdzvfpVLckqYOTcIK7YqtdC3CXoe9vPMXbSu2puINkTvw6MjqbngWDziWUGIUUmis/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cnjq3ekO9F2yKGH5sEVVOBRHzQ6jJMH1Q7VsR018X8=;
 b=awVZDzNWegJjWQlWtQGhXm+vD6OjUHST4mAPqb+PvXzsw3/v06vnN5spuE5rbyhB2F/rizA4nt8yo0iSgeNiweRYu5O4ZV8zt6zhg5oohvi+gdfYTxsSt2Wryu20tuywrxEXj/JCQixyOsrpnxUsYd4qlh2aySu6+OcBEOyft9I=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SN7PR10MB6666.namprd10.prod.outlook.com (2603:10b6:806:298::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 18:10:42 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 18:10:41 +0000
Message-ID: <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com>
Date: Wed, 11 Mar 2026 18:10:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 bpf-next 2/8] libbpf: Support layout section handling
 in BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
 <20260306113630.1281527-3-alan.maguire@oracle.com>
 <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0056.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SN7PR10MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef1ebcf-dcc4-41cf-5d7d-08de7f9981ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RDg+CLStJeHskqhKHBwVxO9OourDMJVkNvpMA+BETe1s6lIbXY9eeC2ZmYOnUTLqx9ovHP402ZnoBjTi8YUx3R4jkdwCPovuZCvRNDxIbasFVK5WHAqPpy38lcY3UmYxOhFhMotwXvJ3REW3DgTKfixExdQkGdHts074eKWWs6dMV8GMTAf1k8W38pfSI+5qcpd8hCU0pFXUJ75iBVHXu1ZSvUtQSH0LVXbtDJvhx+p6Gfppo4OaftP+Z8dJ0z/RCZffwH4JknxsFvgk1sq136tLfsLMNoOy5bb/i0baFsNTD4B9Qxj3qp16W0H4h+HwKiMepCaomu36gVFUa3sQNvZfcCLBhOCcHjx8gv9xbL/s1vWkZZT6TiYP1PSIAMjoa44cOgepEIrqIo6q5DtUfVMfuP7aGNpRW062PLpW5qg7pYbq9DB9siHFStn0Ro0fbiPe2ZgpmLfjb2GQ/SnSgXqkwK0bD+G6n0SQU9A5tl8dXBjLrEIn20d4e9XAmsAgDEdQOaf5SAUz4D7OGdV0+Bh4+kG9st8JqTTiPjwRxJEK0CC/aCrxdea19QVsJhz96APvLxZaGxXz1ATTB5FUVyRHBQzbptPeKDhzCe8Ta2n2XYB+Yb11ORtziMTSG4fRHoydK/Tl0uggX65S9DNFeKcZP0oONWbQaGZI/rEczwnQXB2tFSb8N0yxUQzmLn9ryFy9MkxyT06u5iT6h3BzfvoDvMTWQNygDHXl0yQBnHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzNGU1k0dkN4STliMmRqRzZWR2t0bGgxendSRjdUcjN5ZE5UaTNpZ3BXWkk2?=
 =?utf-8?B?emZSUEdYK3ZFN2MrTHAvb3N2R3RLeFZqSTBGYnZRQ2dhaEFKZ3d0REpNYlB1?=
 =?utf-8?B?V1NnRFBVYVcrSFkxQUltSHpzVmdkT0s5bFNXMkQwVjhraTZQT291MUcvWlJY?=
 =?utf-8?B?V1E4TUJQMXFudWxxR2o2RVBuNnhIbVlSN2ZiQkw0Qy93OVhYSGVvUDZTbXI1?=
 =?utf-8?B?R3grUnhLcU1vV1kyMUVlR2RwaUpZUHk3VzhmbyszZXBzUGdGc2ZuQjIzMGt4?=
 =?utf-8?B?SlV4VksvRnRZNmZRWTQ0T1Zrcm51R1FuTEt6MWJTcU51RXRXOTJQeWNMUmNh?=
 =?utf-8?B?aDNBUWZEZFNYWlpjT0U0cUVhNTdMWkFDdFBRMFZKdDNNQWlRN29qT0JxSWVV?=
 =?utf-8?B?L0NwNWVSRWlOeE12UTJLdE4wdFFtcld3dTk0SE4wU2FsTllPVUNpOVZUWmxR?=
 =?utf-8?B?djEzYzA2RVpza3ltTDJVOWc1YmxSMFlIbHhVZEtWSjBNM1lKZkNVRlhaYlhL?=
 =?utf-8?B?MG5xeEJmOGVmZ09JRjRMK1ZGSDBlREN5eDhoK01FNzZ1cHUzMytYWFB6Tml1?=
 =?utf-8?B?cHd0eHhtanlCbVg2QTNKbFprWFluMVpjTkE0TUEwMS95TDR3Vk84Wmd4MjlU?=
 =?utf-8?B?Um5zaC9PZlg3R0pUaWFZZngzeWFuLzRNYkR2ZTAxajVXS0RMayt0MGF0aFVo?=
 =?utf-8?B?VnJNaHpnRXNHZGMrWXJJaERqczFXc1kxcDE5MGpzT04xQXB1VzJpVng0eDZk?=
 =?utf-8?B?ei9RYkdSU0MzZ0o4VTh6dVdLcW93U0tHMVorRHFHNzVEVHM0bmJackM2Y0pV?=
 =?utf-8?B?NnJ3VHo2eGtpZW1iZE5OYzFPakEzUDhtTWtvM1d5alp4UlpSQXJjM3J5dU1W?=
 =?utf-8?B?WFZ1MWF1Y25yeDNGWkQ1RkMwTWRVRHRVV29TOXRiRTYxdGhMamFoeURkQk5F?=
 =?utf-8?B?Q0pTblJZOXcyYlBkMHF2ZUJZcnRsenl2VXM2VUl5ZmE4eHB0LzNEc292OGVZ?=
 =?utf-8?B?WXFZOWFYMFM0K0dBN0QzUUthWHJaZEpVYmhjZnlIUi83cjhXcFkzNzU1SzBv?=
 =?utf-8?B?S21SL3dlU0N5UGhPc1ZBMGVyZTdpL0VSK3FpZ3ZtSEk1YmtsdXlDL3FpMVJr?=
 =?utf-8?B?amlSUHo2RUkzRFVMRDJDbGVNTDVaWHdYSkl5TERSelVzd2ZjUlJtS294Yitm?=
 =?utf-8?B?dXRtWHBSaE1GR2xhWmt0ZlJQb255UmFvM1lRYU0yekh0RDJBM09FRHVxQTd1?=
 =?utf-8?B?K2hTcVRicWZqb3E5Rm4rMklMcUFpMEY3YnVvYTQxS1cvRC9ETlFXbGFNRDBW?=
 =?utf-8?B?STNadmZ5WC9TbVlTSjQwQ0didVBwMjlwS0Y4NmNlbTVOUHJCRXdMdTF0VXR5?=
 =?utf-8?B?ZSt2dXU4M2xwMTJxR3duRUZSZUZVSjE3a3Z3YzdjMTBLSm9abWllYUtFYXNy?=
 =?utf-8?B?M3JOdmE2N0JyS3oxVFdJWEMwbEl1RVJwWndUWFBqTjUrOW5QWFpKVEw0Q1VL?=
 =?utf-8?B?SFNMZlRJWUU4cWFIS3BOREdPblZQNzYvemM5TG5lWGxsdmNvSUVBN0Rjdmx6?=
 =?utf-8?B?VEhqbVA3RVdMS1pncWlDRkY1NjlrdHEvenoxWi91Y2Z1RS9DRk5zSmFncGlu?=
 =?utf-8?B?Tzh1dnMyTVBsaDc0RlBJTk1zY1BLN0dLL0pzaEwycTNLMXFYeVlwTXltRCtQ?=
 =?utf-8?B?U00xeTFidjVIUS9aU0RhK1JhOC9tcC9xT3YwanFHYmhoa1FhV2w2Sy9tSXdO?=
 =?utf-8?B?N00yalRXbDZydVBSNkw3d1Y5b2k3NEFlUk4xdmRVN085cHdVa0s2b21CK3VF?=
 =?utf-8?B?Y3lLYUNxTWFUYWJnWlRYbGcrY2ovVnFpaFp3ekw1dytsNGtneG1nTXRPd2ZL?=
 =?utf-8?B?alNoS2xEd1lTdDFDMjB2ZmpoNEljb29MdnNYcm00QlZUeHo4Wjc1YWwybGk3?=
 =?utf-8?B?NEZOQXk4TmlZcjJqRFZ2bENDS1lpb2hpQzZLbklTYjRYVEZMTDg1SW1RUndx?=
 =?utf-8?B?TnNocHNObnNPT2U2Z0VPeU9vOG9zUEd0enZvK1VDUkFZMDhhVXppbmhmYUNN?=
 =?utf-8?B?V1VaQlpqZ0R4TmR5Q3JKeER4bHNtc2xFdXJ3bkxhQjRDamtHZXJVRnppWVNG?=
 =?utf-8?B?UUt6dXB0TjZsdStOajVOWXpSdkJTdEJQTDJkZ2VmRE1qVTFySnNxN3BscDl0?=
 =?utf-8?B?WXQ5dzNldVZZY0FwTU5sUWJ1TkJjVmNrazlxVlRZYm9IaTZNOC9hWG11NzYw?=
 =?utf-8?B?cHVmWFE5eWZUT28xVk05cDQ2eWNTUkNTRFlUa0V5Zy9xRzdpb0lqK1BMczBn?=
 =?utf-8?B?bFY2Z3hTNE93S2xvQjZML1U2SzhSNlJPZjNDTm1QNWx1VEFzT2UzaHJyYkJ3?=
 =?utf-8?Q?oCDaHVLazhq6PFLE=3D?=
X-Exchange-RoutingPolicyChecked:
	NdY2QHdJfkEP5K5yFw79d373Qj+JUrcHYnZW0QehgGG/v4jphHq/+wrRoftN8IHEqkNMenGHXG0LwhTuq4GnpIPglu2eKs9rieCR5rnXgAUy6UmFVISScgUxCQa5v9+pcOpVOZeku1q80lg7zPQ1xksyvrBpEPBydcmkBChA/ByP733u+/XQYI2Ay5hyOT/GFZyUZ/rviMDi+zBnBQb7EtzhVYBWTmR565ukg0lX94LvVg3s1kATC0SMdisG50bJQ5UkyLsZMJ1SRNVwk02mTzRz9JnKlkQ23pWRfsXa2NaaS4Zr/9d5fBnrsRpYt5IvYO9sDQqllnQaP8bs+3w9Jw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KZ14y9phkfoGAPP6ZJdzKwK/BmXUFliOyHK1UZmYJ36/yiwgKHdpHwBrragCqrKXcKdpj7MxpogSPEzvttIBHEQe2zvjITnw0oaQkoiPTdYDnsKEuj8i9G8YYcelby8J5QISCP1M4ZJaoh5bktuc8cySJDimTRWFw4pQpI6fAAdE5jS45WoCnXsujO+7YdslT796IEPIuR49Wmmd1gpRX1CRGW93lhex/Iz9Q7imqFNALwzGrkFrl2cUBVzUMp0hTS5QbVoTGl+J28ahpuUyTXeGuHgVygbAlociSHGnyQAI/xdEwI8864uNYzeeDLiG2aJ5P3V/o4SV/lX6fEsIamQcI6CoVUudtNpXT6WDDiZZzxBgfLuRLyYDyLefBTahwTuZCo52zlVl5v0o7Eh8TuxzRS8emKNq19QYMvQT44Rh/O/XE/LYHsqnBVUui30ZMTLGlqR7dpA6axstiAnnmL9AD5ilvj+nfFEpmk4+CzFZqhdk6Vf1ylwtn4C1LUeJ8znvQECM1vZUoO6INJqEmMWKu098nH45N9zNRgB+fKEsvdC0O3d9zGUi27oiGwjT9GuUaPi2WKmCoxGaTS9+NWi5Bb/crZDBoH90ZFczdeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef1ebcf-dcc4-41cf-5d7d-08de7f9981ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 18:10:41.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMT78PdH5DTcEqfADv1QX3iPtzmBMewhJ9hqgzosDR4ep0uBReM35Xj2ymNe4rsa1f04CK20wX6o26bOHj5QMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110153
X-Authority-Analysis: v=2.4 cv=Fv8IPmrq c=1 sm=1 tr=0 ts=69b1b029 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=asiwBFg7G625PXcpc-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12271
X-Proofpoint-GUID: z6Rla4PNVh5zYs7G1CotCJrWuyGYlSj3
X-Proofpoint-ORIG-GUID: z6Rla4PNVh5zYs7G1CotCJrWuyGYlSj3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE1MyBTYWx0ZWRfX7Z7QC9TbZw04
 i2Ofu4y6qp0uOAX5Te9BpOioAPRMc0ppJJbPL7R0Wgvi2wX7o6/2UCeocwvqAbyyVsAVB/4aIll
 RfC/PYgmcnJTIPLsgymJIBMa/+/9NjHWaWlfu5bGekV2pGm9b4f+CTa/FAQ/a8Zd08wWRO7B9ne
 +X1IT2HW/HyRrp+KAXiLoSHGr+z9eN6KY67z+v7LnWRW33aE75my4JWvG1NuiMEMBhwJfUM3deF
 geWPS42KMlRiWBDN6AdCdQAukeh2YhCfbd4dwvNz8VqDim2q115r7HSt9rqfzfnGmO7uCq+3aU4
 q0sgTWcNfpko+knmK6I/7UkEEeHzQoHxYiyzYZO1fNfatJIL9uJetKLwWbmpx/xaCdykHtcaHqd
 5gst3/20d3kZzK9zztTreLXTYU3ZnTZsEDaDJk1bXGPH7FEAEhttL+R/HQrSR9zO0zrLL0FYsAN
 MwM9jx9tPj7OG8JHTZwlDzznGD35yRmttgCqFbTA=

On 11/03/2026 17:46, Andrii Nakryiko wrote:
> On Fri, Mar 6, 2026 at 3:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Support reading in layout fixing endian issues on reading;
>> also support writing layout section to raw BTF object.
>> There is not yet an API to populate the layout with meaningful
>> information.
>>
>> As part of this, we need to consider multiple valid BTF header
>> sizes; the original or the layout-extended headers.
>> So to support this, the "struct btf" representation is modified
>> to contain a "struct btf_header" and we copy the valid
>> portion from the raw data to it; this means we can always safely
>> check fields like btf->hdr.layout_len
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++----------------
>>  1 file changed, 200 insertions(+), 109 deletions(-)
>>
> 
> [...]
> 
>>
>> -       memcpy(p, hdr, hdr->hdr_len);
>> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_len));
> 
> in all these cases where we have sizeof(struct btf_header), this
> smells like a potential issue, tbh. We are silently truncating the
> original header here, potentially. Which is ok for read-only case, but
> do we error out if someone is trying to modify/write such BTF where we
> don't really understand all of it? Should we?
>

The kernel enforces that any additional data in the header beyond fields
we know how to deal with is zero. We don't enforce this here, but we
get a similar effect since we only copy the fields we care about. In effect
we wind up removing the aspects of the BTF we don't know about, so if we
read in such BTF, writing it out would not preserve any additional header
information (say a new section offset/length) beyond the current size of
struct btf_header. So writing such BTF after reading it in converts it to
the BTF representation libbpf knows about (header fields + sections). 

That seems ok to me, but I guess the user might want to at least know this
was happening; would a warning or similar when encountering additional
non-zero fields be helpful maybe?


 
>>         if (swap_endian)
>> -               btf_bswap_hdr(p);
>> +               btf_bswap_hdr(p, hdr->hdr_len);
>>         p += hdr->hdr_len;
>>
>>         memcpy(p, btf->types_data, hdr->type_len);
> 
> [..]

