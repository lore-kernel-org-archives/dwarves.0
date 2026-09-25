Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B623254B8;
	Fri, 25 Sep 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319810; cv=fail; b=PUWetwsyDtawTh4Zvr5plxen6+ujB/n8t357fd7VamyISW8Ph70q1FxpLXHpI3IW6cT967o7MZPPq97wJ64N0oyyA4PGbrFxUhO9FY0Fw7WUp9v8vMc21YUMcKRcRmBZKSFwbjoys7E2PDmibmneDdPElT4KD1MO/NyhReTNvJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319810; c=relaxed/simple;
	bh=eIJ4Dqbv3Wjw1BjqKgmjWY+dJXgGVIFCHzH/wlmoZrs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOkVtqjZOVOVyqM3VPACRUv9zIU3jB1/AHdB8czvpAzWUIZBalJNe+kkwU7IODbQPGyP3YLRkfiepENheBdElweJU7E8t9iQsyN90f2eINzjX1w/b+GlefxpQqQgkrtbcPmxcZ7gRzheOc5GKCaTOodNpUKUyilEhkpHSZpnc2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V+OrWlqt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GyJm1fFG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V+OrWlqt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GyJm1fFG"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P3ogxG1895240;
	Fri, 25 Sep 2026 07:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z5an1LE92tIXyUFmuB4OCELP1Hf0VOREeRVbUbr4Cp0=; b=
	V+OrWlqt8J2bN6dyW3ZJVkgBxYu5Yo6DIxVsNIcQU6XcEjoeej3ro+7rGN9KrF6b
	iC5GcaGvLnjab5cyza9ewOD/TakhgL4qKUthRY7gXbhh+9xAOoyJ5D68INSm1+6p
	6fH+ZdD/c5knG1EVTx9/epzCWDMBwEtyiEgCo+SN47M/agxu5j8FRynfI43nhRIW
	d7GBwu6t0qPgTcjTGz/pIsA1xitzRWnoAGTYfHLlYZoXHdxsWezRkmSG448TUsaG
	i7onFx05B7v0kd1uEQfFYaSrKDLvUwPatt7+FkY2GH50vGDNvVplDBVlRWCLUwsl
	RPl4N5LM++U1XeFL9jM41A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk218w4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 07:03:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68P6oSAT001760;
	Fri, 25 Sep 2026 07:03:15 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepsw0b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Sep 2026 07:03:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uooex7miQh62BRf2WT9h72OZJ1AqdVCeB6v76/vkdKo4QHFKuFWpyhfPGdrL9eOWK9+wcr75xwOCHGXGCPNV615VKbo37cGiAu54FdsFD0Uhn8ZYYJJ+AQ6trrbFXnSsVdmeJ99fiaY5f3htMQbr+3uKoZnHHLp0I6oAK8NikJm7LqkiPT0wM0wBxlv1NXd2ilfsBUkB7BIZEQS42hUhGvaQTQphbTxrw23DYbziZ5V4j2zQcRWA/UTi2ol38lFZsxfWUG1pkUGGQ9zuo5R3zl91ECxej3qB/2LwlIlZWhbfzD28R2oPiJDi3PjuIbn49HUQJQL3MWiOTm8Rw8zjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5an1LE92tIXyUFmuB4OCELP1Hf0VOREeRVbUbr4Cp0=;
 b=y5yl3OJuIlk/IJhWT4SI/i+U07KJT7/82UfqHqVzavnImi0m4uMgnaJvgh7IJSK+heUYLKlxP7HmG3jTMdpkAbJo2KzuO5z/bQ1s6FDRccPCsAljW1yOZE19WOTzvNblIPNryEvAA1yaKmUGKbPO5suuCGE3tUNb+KDSdScSmPnVh4itHjbg4AhV6B3lvZQec0I+PgOMyGzf+7moJCv4G8KUNXMXrUNbLqzD6J0whW+VYkwJJdtTryzug18MKnKgNAz0pBJMlkzmzF9Ct+Z4oUAqWDt44miwidKOozvix4kCsZR3Do11HLh5O90xjxYGkG4di6FhbVatJs7al7bElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5an1LE92tIXyUFmuB4OCELP1Hf0VOREeRVbUbr4Cp0=;
 b=GyJm1fFGoOiieql2MVgf7MiRsudo1x7Br9BdMD9WOBaOUY84Yb50j24IIhZnLVmlDlQx17y9ZPgUBbMItLc2k4cuyDQiDHanBHTI+EDhmO1cDwZZYDpu0s4jt76t+4a1pgy1fHoNk4OnW6TmhaFN10nRzXvjKUyEqOhDEOJW97E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH7PR10MB6108.namprd10.prod.outlook.com (2603:10b6:510:1f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Fri, 25 Sep
 2026 07:03:11 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0472.005; Fri, 25 Sep 2026
 07:03:11 +0000
Message-ID: <9ae5de79-6e09-4c45-a62f-ff4a6611c758@oracle.com>
Date: Fri, 25 Sep 2026 08:03:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2 0/3] pahole: Fix arm64 argument register
 allocation
From: Alan Maguire <alan.maguire@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260917164038.1576763-1-yonghong.song@linux.dev>
 <09dbfeea-a4d1-4b7a-b92e-bcf8c4cdabb4@oracle.com>
Content-Language: en-GB
In-Reply-To: <09dbfeea-a4d1-4b7a-b92e-bcf8c4cdabb4@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0233.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::17) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH7PR10MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f4f022-2a1d-4f04-1421-08df1ad30f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	39Ck6URfNGipGHK0oDdGIiBi6KPx74MMVw8daWv78wfaf2smN/Sb461u3DgZKuhlRWcYrFxKB+kMzejZFSjvY13WjpaIh/ocFon5AGLPyBHvOUDIWjv+4mJwWU6n8r0+sfY07DGZJTE3IfvQBUwdgpdqt/oCZ/qnwLomFt/i0eew/PSotTPi+uDAAwDYEZb1yF6TjG0A14kaE/7H9IXQ8+60NcYn3WFZNKePbUJKuiZ1nQGoHeCPO44EN0GVIb7lcLYKdZX47T7OOLBDRZuh+hwAKZM+1mrL0MlXXMBrRz4rEHp/roZi4DGdgeaYKQzGbyI+g7Bks1BFjUYO22EQ+SHAWpeIZvO2cSBgH+GAi9y5CsaSG/1QrPe39qkl/ev8JjECUNKneB1z0/1c0UIXAgnG6NNOuEF8ZUvYQVhR9NMLEjExBDToHKQTNe1z3n2x2Nx6jhZJOC4mKt2fqd2MIa3nEO6T0nWuwktaEyzvo3r9buZ7YRp3/ci9uRDf5YvCFePR7XgrzWjEnfKzpPep5Ss8h4SgbS7IWqdsgAzWVHfkhRPIKhSu9VnuQJzW3rkTFIfpIqxKKQ0BH+dqxQEyeZPiZwbyFY6olV6mN8g8odl51hfu5Pv7Bo38cv4VuYXsfvHbh8GN+mlv3yoBIOsw6zaDDj4HRWa3R/D0r3M45gM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0J6amRUVVpvSVRjVmxTUnVGMkJLdllqSk8vWW1zOXFEb2FRK2w5eXNFQ09I?=
 =?utf-8?B?RzI0ZUdkR1hWdzVucVczTlpZS2JVR1ZzdVMxbGswQmN0ckVRTFZrallHakhQ?=
 =?utf-8?B?TG9HL1JtVlVQV3RSUk5iZ0E1SnhRUGhyOXozUnltL09lWGpFRmxtNmRKSGlw?=
 =?utf-8?B?dGh1WVNLUFFjOHFqVkN3eUdOL2REdU5FMTRiaVRndkhxdXIvUVQxOFZGRkhZ?=
 =?utf-8?B?WmQvVFNnOW95SExjMVErMDFEL3hZb2IrQTlRRHpRMmpWeUpzUSs3ZEdMOWg4?=
 =?utf-8?B?ZkUxSDlGQUl4eDkza3hSRnpaZWk0UmlDbVhzSWR0QXYxRUVqTzg3Q04vcFJG?=
 =?utf-8?B?eFpMR2tHcEpNc1djdnVBQUtLOGpReVFzNWZwOVdZZGVuRExFQU5ud3VLU0Q3?=
 =?utf-8?B?WW1vWDdyNUw5Q0NOSndGVlZKYmlWaUpTSGJyZ0t0d1RiVGZBU0VGQ0VaMUlj?=
 =?utf-8?B?MGNmMXE3MHlQM2NiOFEyRkxIOTRvbWJsZ25HMGdOSkpmQnVicDZSZ0RjdDZx?=
 =?utf-8?B?cW8ydS8wRkdYdjcxajNha3g3QnZ3NHBBS05KTWg5S0xzbW5sNkdUcnlCZ2t5?=
 =?utf-8?B?a3VMTnNrOW8zT251ZU5yRzVCcmpDdnFKVTg0WmlyUXZxYitrVFpqNkc1cGx1?=
 =?utf-8?B?QkQ0bFJwYjUyUWlpYkczNVhoWkhHcjNDd25mdzQrRU45dG5lSGZpbkVxMWZi?=
 =?utf-8?B?a2kvMGpwMitoLzdxZnBwZWp0QTdrc01TeGhpR3ppdjd1RXdZK0RHOGZNaVFN?=
 =?utf-8?B?LzE2Y1pmdGJnakp0cm9NeEVyQ2ZmblU1Mk5wR3p5ck1nOHJUdFdXOHNhOWhL?=
 =?utf-8?B?RDRxZFBFQzlLamI0U05hRzZRTUN2dGpYcDBUTXNOME8rSURLcTJqWU9idUxU?=
 =?utf-8?B?OEJlU1NMZ0oxbXVQM0VhdWJ0NDBRZUZITjdwR205MkxnNy9ML1ZzclpNZFNh?=
 =?utf-8?B?YnF4R2pLcVBUMkhNUE45UnljZTBjd2hHTTVrd0ltV2hjRm1QVVJHbkFpR0xn?=
 =?utf-8?B?M1RieXlVKy9kQktCQlVZK1VIb2lNSGlaRlZUUWhTcVBYTGpodE5DanZPbEpR?=
 =?utf-8?B?ZU9HSDFJRFEzc2hGdnZZMVJBUXlnS2ZvVDEvNHR6V1NCb2traFhpNWNVKzdJ?=
 =?utf-8?B?dlV6MVRFV2x0M2VmQVh4TkdaK0xkT05yaEU0R0lsMUFvWDFqQytYZmFCbm5W?=
 =?utf-8?B?d2NTd2NWL1pxZVRZSHRDZVlyS0Z4LzdySTBFeXM5WVVZMW5ySkxKaFpyZVlO?=
 =?utf-8?B?clRXa0tMTklLTUdRcy9FVmxFYzRhWFZ6aXhtUEVYRzNMMlJDRVZrUGs0OGpB?=
 =?utf-8?B?REJ1V0dmVzFrTXRWY1p3bU42djBoZTFIWXlUdjBjeENVQldlOUZTQko4aHJT?=
 =?utf-8?B?a3Y5UHBaUytHODNxREZvSnMxNUN0S0FPcmNYaSsvcHoyeFNVenM4RWxka0V2?=
 =?utf-8?B?Wi9GUWttbUNxaXo2RHJsUkllOTZzbHJpSUd2ZEROajJyeVJtei84ekFnQ3E2?=
 =?utf-8?B?NVB4SksrUTRwTHJsRWF5QkQrZ25LTlJNMWExY213Z2hGZXdKdzQ5YUZBeThX?=
 =?utf-8?B?Z3BTcVZVRWI5MHBNemhtYlF2dDhxeFJFNmVxZUxwMmxIcEZ3OHlHbUwrQ3Q2?=
 =?utf-8?B?ZnduOElGYWpsOTF6VVI5UFEwUTlqd0N4YkpRQUJQNUZuTkZiZFBMcklYQUZi?=
 =?utf-8?B?TUc2aDVuRnlNU2NLb2hiNXBiL29vbkhOQ0dQeVdvK2pnZXBkc0lWd2M0Zmll?=
 =?utf-8?B?c0hDZ2ZZSm9MYnp1RjNtZGlraTduZC9MWlQxdWFBTDJFNTF0TWlZeFpJanB3?=
 =?utf-8?B?NDRkTEFZR0JzV2ROYUoxcFhtUVJveEVEbmRkN1pOendBdTFzM3ZVL0p0S3Fs?=
 =?utf-8?B?dXBNbjRtUjJiU0tBZVROZzBUVm1mdTNKdVgxRUNGUDVMTEcvNHBDQ0MvNkRw?=
 =?utf-8?B?ZkV4ZnZVVUgyNGROUkFmNExaeXNMQ1VOZWZHUWRqbmpiKzNaZ0dub3VFVHZk?=
 =?utf-8?B?U3hRK1krMi9BUkVRbnZSYlF4Wm1JbG1LSU9UcmVBb0ErbmJCU1FqMzV3bWc1?=
 =?utf-8?B?SGw4K2VJN2F5V2tnRVFKZnUyaEdpQzExenZVL0V5TXhKN0U4UUplV1B4ZUdu?=
 =?utf-8?B?ZFFIK0Vlc0JVak5YV2pFcFF1Kzd2c3NyanJtcHZkS2w0bUpOYk5Zc2E0ZVpI?=
 =?utf-8?B?NGg2ZlYybTBOR1ZoVHIzVGxpOXQzMXJSWktDRU1vUFo1OWRyMGVsR1pXU042?=
 =?utf-8?B?UDYyNXBwWDZRRDMzK1dIeWNZWkRNMVpud1JIMFM2QlVkMEkyVGcrRE1iblMx?=
 =?utf-8?B?T0Q3a3prQmlkL1ora3R4Z1pUbmdCOUVHRUZpMzZEK2dKNmFubFJ1dz09?=
X-Exchange-RoutingPolicyChecked:
	lsQvIid7dVB2R9SV1FDSpPAA3jM9goO5y1lOq69RaWUE7Y2C6E6vr0exXTdvvUbG/btqUmejd/T8BgTyv1komVVba0ZDU6V8Rdyj6FLljSPTlYj4P3wLyab5VsyMQ8O1Ce28C9octIdtSJrWLYDdMFAtzVPjYijlbTymF44k9zZVjdtX7bnOu+e1mKBOEY0UjZVm+uMvxT2AZI4bN9po7WJs3OaECV7ZYtJI9ZgL6aephbRZBwMvFrz6qOkThG88iudpCxvv0gCpl1ZCG6iAPDV71L1gHLsyhmur5vf5yspKPCi9q6XMu+CCGS1ltl8gBk8jdRPYpBi6ifOoadM2Gg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zj2mxTbwkvZfF3sRzf5zJ4sgyXbsvbp0BV1ebKRbCFsksBo2gqYIV/ptWwyUSmaYKCWJtkkhQ587/Ex40cJFVjsyiwgV5VSHbs286tpFvMDuU2gbSf61XnZHCv9YVLJYW8svQGqYE+fIWWr5md3v7PoBUMp1rTSSHxfHmrZgOb0frzRv+jpkhzSqrI5IaO3EoVNRBIZ1bqJevaCPLjXE3+7l9uBXW918LmJvDjivvkC0YXAJfGw/3QpA+GXjAwxXBxyM2dzxPLDj5xrHMez14Sc0hyhUBkyJFDfE0Y67eTcVMaI+lPuhd35vA3ZdzewPADw4nqtQI7WpfXEMnpcUN0b9lTg/iF3LOGfIi0X7sUMHokEsr5WFSdWekpKpxptUxzhINHadCDUVRX/UNQ4yPn8FKnnlHMBJqWy1WoEh3ADtQnVIWXnZCJO181FD28LF5khfmAzqUnKQVnCGqMNNZNJkPAcO02dG5sJgvAbC5Vhb74+55WDrK9Hd0pk/R/b6TdZb2QW39TnfNqXE5r7YQnIz3YF8PXuABgLurF8w7ltZAPDUMSrBH85LGpB+LDtu62WwRo4zZw2rbAw9ld9bYXILrR7ieW1z9mh9OLe3TgQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f4f022-2a1d-4f04-1421-08df1ad30f73
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 07:03:11.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sAu1uT/KmDiGG/KTOgAt3Z6jxE5v434hk5sMmadjk5n1MpWK00kMVhgetRggHJf9DKYZXl3bJsuQb/6n72dfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=954
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250027
X-Authority-Analysis: v=2.4 cv=APP6TA4N c=1 sm=1 tr=0 ts=6ab61cb4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=DjWq3pXOSa5iryhWglYA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfX9B6HpcslC08D
 cPBRjmsYEOrUbsbNn0nCIujQQe+zfRKNqNp3vxdFDNsEAq1tATMXa/Y0GZSiOVK8IDM/EZhy1Ut
 /FvQD76+kl1qvQ1OiTd2YbqCzAR9HKp+T5m73DTpaJ2w+s1tIKgf
X-Proofpoint-ORIG-GUID: 8epfugd3RG3sY-qnxGeJloQtU66BK2S7
X-Proofpoint-GUID: 8epfugd3RG3sY-qnxGeJloQtU66BK2S7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfXyo2za4lvSsVC
 aq15sMrx8qj5YdiW4BvZ03vryZNJ40R5JHZF1VpL11f48GdYdKGntRRLY8ReOIvPN0c1Tkri3BO
 iRt9wQDtU5XzoKm+VluUfKH4Mf5rzYLYOOkc5M4HllKpK/rdN3XgJcxFMlienXhrQfPATc8LEpR
 naS+4KGCx9JC4bGbHlttBFRxPEhQT7jay3rDSdy8XnqSWK1ykGjO5hlZncKicrDvZO5yjPNA89d
 QHF1JyhxmCQHHje+3z5Gu5ISvb7vctOgtOk2VQ6KZzj3svXXUxdb5vqJWLkVSD4S00P5jLRP3QM
 jcf8Y14nf8X+t1WAGgiiroztxADZEjwRHSrpwL1zZtI5E5lpLR/VNTpO7dB1tEkkp2m8FKWFPL5
 pa1rBrAcFZp3o9u8KeUesf4BXgSVmz2OXvWuWCkYBpHGC+VdgbRnDZZmEDjjYXaOVGQRTQ/26iP
 IQ5wAN7vu9FrdzbySWRdlhlVK4KVURo3QhUqIODQ=

On 24/09/2026 17:15, Alan Maguire wrote:
> On 17/09/2026 17:40, Yonghong Song wrote:
>>
>> The arm64 ABI starts an argument twice the register size on an even-numbered
>> argument register, leaving a hole when the next free register is an odd one:
>>
>>   u64 f(u64 a, __int128 v, u64 b);
>>
>> passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.  pahole did not
>> model the hole, so b looked like it was in an unexpected register and the
>> whole function was dropped from BTF.  Patch 1 skips the register the ABI
>> leaves behind, patch 3 adds a test for it.  Only arm64 has this rule; the
>> other architectures are unaffected.
>>
>> Patch 2 is a small follow-up.  Floating point and vector arguments are
>> allocated from a register bank of their own -- v0-v7 on arm64, xmm0-xmm7 on
>> x86-64 -- so a wide one never occupies a general purpose register pair and
>> must not trigger the even-register rule either.  It does not change the BTF
>> emitted today, because such an argument still advances the general purpose
>> register index by its own size, so it comes with no test of its own; it
>> keeps the alignment rule scoped to the bank it applies to.
>>
> 
> one small issue here; we record alignment for structs from DW_AT_align
> in associated tags; we should ensure that we utilize that alignment
> where available. However it's a bit broken in that we don't appear
> to record alignment for typedefs, just structs.
> 
> I think we can tackle that with a followup though; unless anyone objects I'll
> land these patches later today.
>

Something along the lines of [1] would make sense I think; i.e. factoring
in DW_AT_alignment into alignment calculation where available. Not a big
rush on this though as it's a less likely scenario in the argument-passing case.


[1] https://github.com/acmel/dwarves/commit/e6bad3dfd334438d6d835084b0e832c95b6d1302
 
>  
>> Changelog:
>>   v1 -> v2:
>>     - v1: https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.song@linux.dev/
>>     - add commit "Do not align the argument register index for FP arguments".
>>
>> Yonghong Song (3):
>>   dwarf_loader: Skip the argument register the arm64 ABI leaves as a
>>     hole
>>   dwarf_loader: Do not align the argument register index for FP
>>     arguments
>>   tests: tests: Add test for 16-byte aligned arguments on arm64
>>
>>  dwarf_loader.c              | 72 ++++++++++++++++++++++++++++++++--
>>  dwarves.h                   | 11 ++++++
>>  tests/clang_parm_align16.sh | 77 +++++++++++++++++++++++++++++++++++++
>>  tests/test_lib.sh           |  3 +-
>>  4 files changed, 158 insertions(+), 5 deletions(-)
>>  create mode 100755 tests/clang_parm_align16.sh
>>
>> -- 
>> 2.53.0-Meta
>>
> 
> 

