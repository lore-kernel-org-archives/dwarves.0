Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1B347FD9;
	Mon, 26 Jan 2026 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447423; cv=fail; b=or12XwFbzS9lwI0f0OiT/gG0vC2MkMHvc/517tts3s76FEJp7uUXVgTHQB3hTPwJBxOqeOk6TE0GS4H1yQohB1xyyMvXHcxnOyjLgX2Q8yratBKl2YvC8WvR77bnCnbWtpH9fhG67mLYjdQVyCi6/KTcZ6gjvCMFptDQ7GmeQaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447423; c=relaxed/simple;
	bh=iQFiyWL3FSShrUr9k0e9trcTr+YFbt6Fu7A1OrgUOY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iLqqPdb1vEuF74/ngqE8whon/E8VhFbnT+1F/j6v9Rki4zoprPmWIU8uH1OwPZnmL1TX3eRECT86ws1fj3Mcp0SPJL9TnxXR4CdT2X5Mfgt05/IlAhPP17fhouQT611Or4D3w3yr4odlt7Nyxwgt82+1Bvw7r/FhCNNq3RBZ30A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WzpKUqJo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rZHUm5e6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WzpKUqJo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rZHUm5e6"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q3KllK158731;
	Mon, 26 Jan 2026 17:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f1DRolXHkk9oPDICGNmadDb8VstAiUVoXGS2kY0oWm8=; b=
	WzpKUqJoGHcm2QwT+MLh4RU5DtDhZtG+ihkF23xjXpj0SLczq5r47MOqnwaj1ISn
	jp1zFTrWJgQ3zn3cmrc4emVgyt1JH35yUiOoYk6FmsDjJ8DuTpv3ZFGZRZNWyeby
	iJYkePLUn/1HU+Rx9FWDeuJgZXOgBJEyneU9oiuUs5i9DZBJcUE14eMTOAqPSi5t
	bH1MFGSkbLyq92eLH6p7w1537k0g4UDaJ/K12diwo1w6cACJhPv42bE2sY6SiTha
	oIpbcl/NAymZ54weGlFZIkk1xAPs5ufdFupNKJzfZR8U9VbYPABtuAcPVD/TngGB
	5qlX7YFSlqi5+BStkyp0wQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny2avt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 17:10:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QGM6Oq032883;
	Mon, 26 Jan 2026 17:10:12 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh86tg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 17:10:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlWtTtH7y186eHNXXHTIOT7+i/mp2tPQ2vPHzOuCNY4vfjJ7xfD9BzY972OWCRDdoMNZy1nNJEkYhmqNe6FL0VpHfo8oWk404q+WSm0qUDcnoX/+Ig1dvJsN6u9t+dUBESbV6jQpIh5A9ta6lZpKyNCaEmVMrhks0wuJLp4Q6CLqPbjYKgqkPFq1RF7r5jFxJVRXjvnNdRyf2kGQlcK4vdLAUdL4PQ5SosxbZeq9TZazDeEmKcMMtWKmDB5yOfrDvIHwo0b5VhJ8bIwjyR3BIUhBVJ1SconF1SrDwlDdcD7oTztZ+9hOTRnb8A5MFFyyFJP7ojSwAvR6CyM7oyY4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1DRolXHkk9oPDICGNmadDb8VstAiUVoXGS2kY0oWm8=;
 b=M/o10ekIww0QTzAvOP/9FLhIRDzynrKNnsvVXQHSE0MRbjRl5/falChbS2ph4Wn6kTaHEQQtjj+V696vcCBcEm3SnZ0+nfhlmE/b2U8qDXLX7eA8XP3KdeFJhFGZsxL2I+t4vTHDAiivowqTD43KOc/ilYTYTF5VrKXq/EOW/igrXwxbvr0L9yCbOXOYfkAp+xuLFiVKhqZfNxx4fM0+kA6QyQ29XgC43bjUG7CmCSyMvQwSCUnyJBpYwGW1myZWZGs/XH2SuyxVduTJRgEEK3TKYvi44IU9MnNmSU+qSaBQXlnYdGmk3v+v/DG8dB59lMey/28HzmM97dDx2KsPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1DRolXHkk9oPDICGNmadDb8VstAiUVoXGS2kY0oWm8=;
 b=rZHUm5e6JXrVJ+jDI3osAu/c2nBTZjQErceJLt/KMNUww0P3JMOSUwQ2Hqj6yYAfmcRFteyXx2F5/JpXsN9M4yvy6oS02YJlNeUhXZIce+Gu8PFM1UFLrO2Sd7ClVdJJ9HkogG4aa1TTMGwK6YcF3t4PUnhwFnVYrQUe6EcRp0U=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB7385.namprd10.prod.outlook.com (2603:10b6:208:42f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:10:02 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 17:10:08 +0000
Message-ID: <61ae18d7-30e6-494e-a0e1-f5bf7dfa2758@oracle.com>
Date: Mon, 26 Jan 2026 17:10:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 4/5] man-pages: document true_signature
 btf_feature
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: yonghong.song@linux.dev, ihor.solodrai@linux.dev, eddyz87@gmail.com,
        jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
        david.faust@oracle.com, dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-5-alan.maguire@oracle.com>
 <aXc7uFtOhE7bSZnw@google.com>
 <e7345200-ce29-4077-9d2f-7d7e4b47ca79@oracle.com>
 <aXdOIBvo9rZLGn-f@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aXdOIBvo9rZLGn-f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0623.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: bd372d4b-bcdd-4fc1-0822-08de5cfdc1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFJsQlNwV25zTjAxN0srYVpiNUJKMFlPcnpldUFEb2hmMUdIUkVsNGJrZWU0?=
 =?utf-8?B?Nk9mMHk2U2VQRDROa2xnb2c5V1pIaTQyWWV1SUtObHZ4dGlQeVVEditEYUxy?=
 =?utf-8?B?S0RRTlZrU01CSmVzaVJhMHRFQjJNK1BaZjBTNDByK1RRTW1wUzFaSGwvRjN6?=
 =?utf-8?B?djlaemxORjhKSGEzbEFyNURwbUxyc00ydjlYNXZ2S3E0YzBMUUpCdWk4Nm5B?=
 =?utf-8?B?UFQzUEVJL0tnOHBCMjluN2c1QWJkTlpGc3RNWXZWNFhacWhIYy9GUXVPZ0Nl?=
 =?utf-8?B?Tng2UVAzdENkb3Yxc2VpYlNkeVVmVXFibzlIWU1QNFE4WjVzQ3dwcDhDdFRs?=
 =?utf-8?B?VWhiblFycXVtVEhqU3BLN1cvdEN5Ni93WFMyamFqVlh2d0M4ZHJVOFNsU3NE?=
 =?utf-8?B?c3dQN0ltRUxTQ09QTWNDY1FDbEZCMFRpdDRFcGE0R0paR2dVMTVrb1ZldG51?=
 =?utf-8?B?aG5tV0tXMXlVUExoSnJ3ZkJzaFNMbU1LZTBUTVlEUFVLS1E3OTZEQitSM2U1?=
 =?utf-8?B?WHY0aHBjcnNRajRBbE10N3VhWGt6bm92d3lUQStCSlBGaTlPSmV5TFlmdEEv?=
 =?utf-8?B?UE9HME5mVjVJamhPeldMZW80NU1OUThsVXZxcTZpYnJHbEhVQlRGVElTWkt2?=
 =?utf-8?B?UGhSckdWUHhOMjcraHppbzl4aHFCa2tXdk5TUTkzbERXWlY4U2hFTVlra3hQ?=
 =?utf-8?B?cW42SXpyblNHc3Nza1hKUDJxWTd1eGkvYlhBTk1acGs3cHoxU1NoL2Nrekd3?=
 =?utf-8?B?dE50OWZyR0hGVFlBQjdTbHNHQXNvNzVld1BrZ2dxYzlKa0ExRzN2NmtoVFN3?=
 =?utf-8?B?SkdGdjIraStOZUtOYjdTMGd4QnpHSUZsUmVVWG4xRllCN2lTLzE1d2pTZERL?=
 =?utf-8?B?YmM3YjVJbysrbkdQVm5tbUJ0UE5GT0lGYWdzZzZNM0ZxQUpqWkRaLzIvZW9S?=
 =?utf-8?B?N01WZlMzNE5nbzhmSGVXUTBnaWphUFB4ZUo3aGdSTHdyNk9wdzZDMk5HUUZy?=
 =?utf-8?B?dVdtS2Izb3Zac1pJckdOY1MvTmgvdzJjNnpMODhKZEpzWSs2SXBINzhhcmJB?=
 =?utf-8?B?TXdwZ2syd1pUUnBGc1VyYUM3WlQ4QXI0QWZ4am5yb3RES2pPN0diL3VPbTlh?=
 =?utf-8?B?ZzB1NXRjUVFLamVsdkl4dUF2SmlpTm5TYm84eTc3UFhJWVJrZ2RvUDZRYnlo?=
 =?utf-8?B?L3BuOU8vcFFYZG1SMTlGb3pyMWQ1dEtMdDQrMStuRlNGYTNIa01LSnBXdVFN?=
 =?utf-8?B?QVpXT0ZTdndzYkFpanZPWnVKRzBpeUtiay9GKzNObGVyYmdzL1E3V00ydWFk?=
 =?utf-8?B?Z1V0Z0NZc0srVGxPMHdmK0pSVVBmUFR4MENYZjlkUnNTQnJrUG1XR2ZtNTNw?=
 =?utf-8?B?bVB4VkZnbnByK2gzdWhFZjM4QnJrc1BvdDhxL1k5V1dBSG5pVmZ3YW5PNjN1?=
 =?utf-8?B?Uk8xSFBoRk5ySk1NczJCeDIwNDhGZlpvdkFEdnltcGlkTlpLNHQ3MEVuN3lk?=
 =?utf-8?B?L3JQeDZnZkQvaFZIcWV0eXNvS1kvMDRqS09YMWVXUWFpNW5kQ0g5c0VTcER3?=
 =?utf-8?B?U25yaWVvUlJhRXMwblZ0SjAwbFhNZHpzalFMWk5DMTJDT0JqMWxYZldYMG9i?=
 =?utf-8?B?R2VlS0FlR0NEWHlrOTI1N21VdnJQWWdWTHlacElkVUExWThtRVBYNHlicUxq?=
 =?utf-8?B?VkV3UE1pK0tqTkJueDhOSlBoUFNnOTgwdTZPdy9YVUswWnZ2OE1TVllxdlpo?=
 =?utf-8?B?RTljMkpsUk84dlFoVjJoUmhLMmtMVlpmWmk1NlJ1NFkvR0NVTlNRMklLNjJm?=
 =?utf-8?B?Z3pNQTBTZ2l3SHlkemJDNVVlZUxzUWMyNXhDOFY5VzEyYXFtUnIzcnM3OERM?=
 =?utf-8?B?MGZqbGMvMUJuNEREOEtsYmVWbFJqMWtmMHVUQ2xKUWhSbFJTY1c1YXNmTE1o?=
 =?utf-8?B?MHNmVFo3SGdrRjlocjl3MmszY1M1NEFzRFViQzZCRkt3aFhhSFBNdWpDcm9j?=
 =?utf-8?B?bHRFbzVGcjNYUHU3RS9rcnhRTjcwRUNLcWROb0Y2WVB6QThwVm1GUFN0VWl4?=
 =?utf-8?B?YTlZdEt1T1VNSEY1czEwaFZDYTBYVDZ0TmhCMlFhZlMzbmRvbDNzK1ZFUUdK?=
 =?utf-8?Q?jG70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3pBdEJPdmIyOVhtaHVDaEl6QkFMc05ZUi9qc1JxRDlQQjNML2pBb1YvR2gv?=
 =?utf-8?B?U2R0bkkzZVdGSGd6aEJxOTJLb215cTZ1bEJhaEwxMm5RQnFuMmNlUjRZK0Ey?=
 =?utf-8?B?VkF0eGF4THVxcEcybzNTVnlxa3FTSkgyOWkwQW8xQUhyV1VmdWdHRmdUcmRK?=
 =?utf-8?B?ZFViQVRFRjMvZUZBbktlbEdUSG1KM1NoSkNDc2c1YUFRc1FkeHdFMEpUbzdK?=
 =?utf-8?B?THVsa3J3K2J2TnBEV25LTk5NUjFnbnlPNE9IbVZzSjQ1RGFPdC9ldzBJdmNU?=
 =?utf-8?B?R1VzM2JYV2ZFRkNyTnhwaVhYOVV6cjdka2pmMjdhTkRJSGZ2eHRtRytNdmxB?=
 =?utf-8?B?QjU0SE00QUR1ZmtBZTA1aGM1ZldkZHJRbnRvSEVUV0Y1czlsV2s2YmN0SDBm?=
 =?utf-8?B?YytMT0ptaHEwWTFXQXE5bUVwSks0QkswOStHNk9lUkRUa0JhanJLNkRuVmdX?=
 =?utf-8?B?Mjd1WnZoTHJmSTRmT1dWNk5ZV2hVMGI2ekNsN0FaSGk1M0FJWjFXYllEMGdk?=
 =?utf-8?B?WDk2L0lwZGtTek9iWmdpcTJOVGZIOUJ6a25QNVNhclhEbUVWaWlJK1Z1Q0V4?=
 =?utf-8?B?cGQ5R3I4VjBkR21HVmZLbDFtZHN0OTIveWx5eXZWT3JOaTZacVI5R1MvSE9B?=
 =?utf-8?B?a3g3MGxvN21Zd2xZeEtocDVqUVU5QVJyTzBSVE9sMVB4aTgzZTN0VmhDM0xX?=
 =?utf-8?B?N05rRmEyWDdHUTJHVzFGYVdvYmhtS1U4K1k5SFNXTGwyeGFJbW8vdU9kV1FQ?=
 =?utf-8?B?NFlEYzhxc3VlUWMyczhkVXB0djExMU9MZm5GQlpiNSs4TXlJcDRCMXI3cHo0?=
 =?utf-8?B?M2tLd1E0bUJybi9GTjlDdUl6cUdlYmZENmlWMTBHRVlPRHRMRXpZQzU5a0hR?=
 =?utf-8?B?MXJmVHdlSmVRZzY0VDdCZmd5MUZnRm03V2hGM0t0Q05SRHRIeHRYYU0zQWsw?=
 =?utf-8?B?M0JiRytQQlVSMGJLWTdSdnVrekdrZnk1VlpTNGRETU9iYmN2OHFZR0lyQW5Z?=
 =?utf-8?B?dUNBZXVVWjY3WUpzSVFPWTlOQmdrWHN0ZnJ4U2xqd09MTzRmWFhvZmVYc3Vm?=
 =?utf-8?B?NFVkdTlwdUVTYUhYa29sSUZIZVdFSS94QVQ1OHpVNUY1Wlh3TXltVDJFZldz?=
 =?utf-8?B?YUk4TjVsdWVqRUJWZ1Vqc3pCR1piTG1WQzQ5encrWUZKOHN2ZHlXaitFVTJP?=
 =?utf-8?B?bjhQR09GMmduT2F5cm1NR1J4R2JuZGNTRHhabXRZemtGd0lpNDZ6dCtuWlo1?=
 =?utf-8?B?NHh2cFBJR0RLYTc2TlB1a3grUXlnbUprRVQ5SjhWTmZ2eFVhVVIyMnJ3U3Ja?=
 =?utf-8?B?K1lvdk1uOEloU1hQY29zaWtrdDZrNUM3dDJFa3hYZlh2cDVGK0tKRDBYRFJG?=
 =?utf-8?B?NjQ2R3lzOWI5dlhRb3k3SE1RMGJvdHRaSkxWUUN3RWNFOXBrYlZtYnovK3k0?=
 =?utf-8?B?V3NaNmM3OFRBbC9tekpwL1Jra3BYUktoYkc1Qkh6elQzbXkydlQ4UGtxaXNi?=
 =?utf-8?B?NFlrUEo0MExiY1l1a21lM1NjZmVZeFFsU2hiNDRtNzZxZ2FxcFJKbVYwWS9T?=
 =?utf-8?B?Z1FmWHJ1K3pyWUVQaUZCeUpiU1R0bFpSRVZvR3MxVmVVb0E0R05sb3I3cEw5?=
 =?utf-8?B?T1Y0b2Rxb1FFU0MwczZZSjB4MGNscDVUYUplTjNGOEJvMElUV0p5OUkxZ0sx?=
 =?utf-8?B?OHpxQUdvZDZKaFhiK1VhR0Jpd0pWWk40Sy9Rc3ZzSGVqUEllVzl4SDRWZUJu?=
 =?utf-8?B?U0ZycWp0RXJmNElOVHRlMFhJdFFZYjhhUWI4bE1XQWc2eERqaGY3MmE4MVJl?=
 =?utf-8?B?MGxxNk9uK2NrM0Z5RnMyTlplaitSYlFpKzNYQUpMdVVCVloxTSttM3FIbG9R?=
 =?utf-8?B?Vkc5NDlNeWhQVGtNZ2I2OWh1Y1J3VTFNMkp3aDRXYWJCck4zNmZaSTVEUUFS?=
 =?utf-8?B?WXU5UFROMDQxRkc4Rk5wdHFSZ0hvc29ldmM5SnNNTWdwR3grbnh1UmluWjdJ?=
 =?utf-8?B?dGl1QU1IMk9XcSsyMlNqTGRSUWdHZW1MVkxxb0U2TUlmZG11M28vMGhIdXJC?=
 =?utf-8?B?V21xV1BlOFlBR2dRc1hlS1VOK2ZEL3JaQ2V6aThCVDBxREhRSm5wTTY4NTVK?=
 =?utf-8?B?RndtRmt0SlNrekxBSWROZzB3ekw3WFRncEJwWGhYcHpRM1I1YmxQOU9NaGU4?=
 =?utf-8?B?anZ2dlVzUm4yYUh3ODBib2EyNlVMQnBUem5PQXFoUnVZd1JuQVgrSGltVnEw?=
 =?utf-8?B?cEZRWVBPNGVHb0ZPVmFTNXhiZzB0V3JuOWJBTGNXZ21GV1E4d1lra3ZRYVd5?=
 =?utf-8?B?RDlkRHh0b2pkZmszbmgwNldObHhHOUpyZjZ3YVVtUmpiV1A0WkxzZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1lHfNbXKeBMgNyOiTniws69Bl3+VEiB5sr0PH/7CAuFW4q5HAQ3WHESuz6XFeBQG4hF6hoISgNaJ4Jsfd2fqfGQTd1C5pFKSo1TvT9hL82y9tl0znIeeuGUZYlkvpzGzIiZFn3VLUOHjLlVhOg2T7FIsbYe+buu8u/ALFGbQ5y9a0Ou28DHidvF7+rOERhqN8A5utHt0//X/siFUuHfT0UOcKUyPCnrSHLPhIT7+BitRYE1rR7cCAwLecYKEbgpHZw2Jc0l6dxvTht7ncQa9XMdkq++8o3ja/OZfB73KvPCGsPk/l6ZxQ1ZWwhp03bI4TucuatdzAvETjY0Zag49QG+lvhlgTpt2qOhyIcIQEzqb2GDWOS5ogIzrumfGhzQm5Zk+aAUp/GBbpSG7gXp+vHK7OGaykClEPPhvCr32kuVdHwQ5JPjXoyB/vCte+qpuHmsKHLFJYTCz2l3LeNl1kKpDEQeZwD2bMX+l9fKQ99JajE/v4WNwRSrt18lKLzUw0AvO0uSp/TNa89A0Cb+1IaZ5r1zRkn8gal1XzljhVRbJ2P1QpkkicxNVd2tSFttmGdG3S2RzSjUZbjQheRQxie6MGl690ZIBZNtf5A+o9FY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd372d4b-bcdd-4fc1-0822-08de5cfdc1a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:10:08.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXJqe9rT8DJ57olbaYkdFHo0rKtWuUfG4VwDpne6efkYS6gVcsQQePU5tT7aUXXyQAheNxwQoT/xacsZdQwqug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE0NiBTYWx0ZWRfX/HbkNqNC1Gy+
 pkyNEr3Q/UA+EbM6RRcHSfdtbZe+fI6O3oYnCtdTbsBiqYAJjOIgcyp3gPKVWEIOJQe4VGv2d2R
 r0irxRnIxtNoABfPPMfgMG2ox1A/Fe3x+7WK77oTnu7F+VdzZd6iVRn4Nli51IKPijo6sSVUA3C
 6xG7FjaYo2kT2Jx264kbiDdwLjcDRmSFC/wCSwpV0bdjPzAltaUg/0rcP/STmEqYMxhgv6ZfvRw
 MJdbRQWF4Fl3HU2TpZqxkB6bi/aCL/7GvR0p51x3cePlXc+LO9pdzns7NEo+Z9HQvAu0T29q6A7
 U+ZOaExxgYBZhYmTrrvynLaBo9NieDk+s49LyG2GPfEI4RbB4sfKZQdyA6e9a/kGlOXjQ6PSZIx
 ur/8L7fejJoZkoUuacGlu3E+cmu97Tftl49kS+AWRquhcIvxm+sOqS2JVZC5oEYP+Ypvu0drc3m
 C9ytsHIIYlxzNisz0sg==
X-Proofpoint-GUID: OjBYzuGymzBFRm_S5iXdhgailstP7_1w
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=69779ff5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=9-X2RsXtX_USOp_AEbgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OjBYzuGymzBFRm_S5iXdhgailstP7_1w

On 26/01/2026 11:21, Matt Bobrowski wrote:
> On Mon, Jan 26, 2026 at 10:51:31AM +0000, Alan Maguire wrote:
>> On 26/01/2026 10:02, Matt Bobrowski wrote:
>>> On Fri, Jan 23, 2026 at 05:26:49PM +0000, Alan Maguire wrote:
>>>> Ensure non-default "true_signature" feature is documented in
>>>> the manual page.
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>
>>> Acked-by: Matt Bobrowski <mattbobrowski@google.com>
>>>
>>>> ---
>>>>  man-pages/pahole.1 | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>>>> index 3125de3..90a8f45 100644
>>>> --- a/man-pages/pahole.1
>>>> +++ b/man-pages/pahole.1
>>>> @@ -337,6 +337,11 @@ Supported non-standard features (not enabled for 'default')
>>>>  	                   of split BTF with a possibly changed base, storing
>>>>  	                   it in a .BTF.base ELF section.
>>>>  	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
>>>> +	true_signature     Encode functions ensuring that binary-level
>>>> +	                   (rather than source-level) signatures are used;
>>> 									 ^
>>> 									 within the generated BTF.
>>> 									 
>>>> +                           for gcc these are ".isra.0" and ".costprop.0"
>>>> +                           optimized functions
>>>
>>> For BTF generation, would there ever be a situation whereby we
>>> wouldn't want true signature support? I'm just trying to understand
>>> why this isn't defaulted to true.
>>
>> The key reason is the "." in the name for gcc-optimized functions
>> "function.isra.0" ; older kernels will reject BTF function names with 
>> a "." in them, so we have to guard against new pahole with the feature
>> enabled by default being run on older kernels. So by having the newer
>> kernels request the feature only we avoid this.
> 
> Oh, yes, that makes sense. Once a new pahole version is released with
> true_signature support available, will you also be looking to update
> scripts/Makefile.btf and conditionally enable it based on
> availability?

Yep, we're hoping to get some support on the LLVM side for true signatures, but
absolutely, that's the plan. Because the --btf_features option will simply
ignore features that it does not know about, this approach works with older
pahole too without erroring out.

