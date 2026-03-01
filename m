Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FF27B50F;
	Sun,  1 Mar 2026 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772404210; cv=fail; b=L/Aa1PJ4H5t+D9Eskh+LnJqomKhxQx3SX50Yn14u0K9w8D/8oAefJYkz6POZo969makAingFfIq+CLOkS1UdJpvEGBAVVvid6VT7syx3VEiwMoHgqiXno4tNbLvl1pZla4MT9arng/NkVRGxHnlCj2ZnE9R0NK97FhM2J1ShSks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772404210; c=relaxed/simple;
	bh=Sr8dj9UrXw9/7bCRzXYEL3KVFcd5FEa3j+eTiEAuDCU=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6k+g90AXzTXPZzPBrE0UW+0jRDFSFBeCDjPiAGd9Z2XxszwNP5ZrBMA7l3k+ZMGbO/f3WeRJoIBmfxybQVIGagXjOduH9PsV/Qhc3eeG0L+tbbMT2wjb0girnCB6nLIiIBtShYaAnDH68IGsbjPj9a8YMDyYF+9iJ3QMASqmr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MP3TmuIr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yUFE+l1i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MP3TmuIr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yUFE+l1i"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621Limx3739791;
	Sun, 1 Mar 2026 22:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dZS3IenAbrN3+bbFNoKrKiLdS0XgXdn81SHBs2ivuyk=; b=
	MP3TmuIrcg5vRMdn0ywygYn4/IjRHa61MHyNVF1Zie2bg0YT0lPM0CbteC3TvfrZ
	kg4NTpXliGp5Mi1//Mi9u5ONgggNqmmr71dLZjOmW0Wm+hv2ZE/DZyJKLHuui8DU
	g9gEiQ5LDLZTPJxhbQY4/LcwUJD1xfTzWO8VDHd2GtBkYZWVK8WCWCCAWUMiftwm
	iQP9bUuatvGHgncnK49HJvij9+740bFPc729rYMeE4d0iw8BH+p+ElOHmNCOo4O2
	JGUiztOARKMPUA+J30rdTMZucPc14ftzW7cpk7ORhnZiOJF/yNgJ8Mwpx12HkTLZ
	mc97dmjP/rEInLtHDL0ZFQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ckshmha2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Mar 2026 22:29:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 621H3odQ037701;
	Sun, 1 Mar 2026 22:29:39 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptcgews-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Mar 2026 22:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWd7q/R2qu5qUrvWXtKAxhL8iWZWjShStpg/jbSdU2TDWAKMmRj3FdpkMqMzF7RIlmdpeIWapNAGQhJ/4hMmBdkIhuYWdWmNn58KfGzH4eHoDibYZlu6o1Y6Z9qsbJeiUX7jbKDKpIHeONF1U51Rxdw+DqeqtImerSJXGJKSvKCsu1iC06pXtD2ZCwSjL5arxRcQbJWLmI8CgYRR8PHxnWrZhiYG1tRtp3qSO5K7IuhqazPMFkpy6NcD6LLz7G6DPhOqBkEMqh9N5I7wieh89Cx+/zO0yKPfGrvXYJ6B0RCxS8iJO3lkgzqL8r/4K5bevVOvFP0hoN22wtF25K+4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZS3IenAbrN3+bbFNoKrKiLdS0XgXdn81SHBs2ivuyk=;
 b=CsRSWWMhybX5NlOB7zfmnP4pGkAnJAWEUiIvmJQf7rYRx25wX2i2nWEbwCh5qc4WICTEgH0PifEe8fB1uUu4Z9qTqn/Ri8Gsfrd6luSdvrnF9nCLZk1EoEIg6cQrKsKGuF3PnwdSrzGr+BZxaHZ2QNbd+IpFUElzS9OQI6Nr1w4JFhWg179gbuRxltfU4R0jfqpDyJh13JTRj4ZLa6thrbG5i5xDa61Wml4WnC1EK5SAJPvEwP+UcNBhSSzwOdhmrYwoY2oB5nP+d2pDf4/ZGgO+MZ3KAN4adyRshOe0h9nzA7t1h1cKDFqFSdd5OryDTvsnmdDb2E2XWbL1f7RTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZS3IenAbrN3+bbFNoKrKiLdS0XgXdn81SHBs2ivuyk=;
 b=yUFE+l1i6BMc5cYEp/e0vc6YFhtoC8Km/F5HybYeQnrjK+u0t00w9wC3+lapwm+TKYrDi5yqUm898lP9UDaw4+Mw7zqeZmEqmNYPdtEpDdfn5857O3kpfNNcSUQWKOp61FxKqxj/6gffd0DwEe2ildmZGkTn45z8l1xNWFqhjlw=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sun, 1 Mar
 2026 22:29:34 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.020; Sun, 1 Mar 2026
 22:29:34 +0000
Message-ID: <142825ed-c195-407e-be15-4c760a3dc8e7@oracle.com>
Date: Sun, 1 Mar 2026 22:29:26 +0000
User-Agent: Mozilla Thunderbird
To: alexei.starovoitov@gmail.com
Cc: alan.maguire@oracle.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, dwarves@vger.kernel.org,
        eddyz87@gmail.com, haoluo@google.com, ihor.solodrai@linux.dev,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        martin.lau@linux.dev, mykyta.yatsenko5@gmail.com, qmo@kernel.org,
        sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
References: <CAADnVQLTwLSWaN8arz5NmCwqJxd3DPhtKn2is5AgrQ0AwYFi7A@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 08/10] bpftool: add BTF dump "format meta" to
 dump header/metadata
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQLTwLSWaN8arz5NmCwqJxd3DPhtKn2is5AgrQ0AwYFi7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: e414f240-6d15-42dc-339c-08de77e203d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	no34KNOPfdTTDxTtLC6QFVsweJehvaj2BnScnLIjQBC2MSwiOGxqoWsc9gGfIITpVIKYdAbqDFmWZL2HDzpUUzVjEF0gUZTxn1bw4kDERTYsteZJz6Bw65svBTAXzVpCvq3YpUSkuavNS6Fu9clK/eeOCMSl79n0AcWPxKsSe+KfRfnqoN6y5UuAO85C+/Xu9tlzClIXo8FMtVa2qPl3ws00U6wLmsQUooY42rZ9m7Pt9xcqZtxdMwm3khWVbnH2/B0gs1zoliz8jRi4Hro6hrLxufJR62nmk+qAv1ODLxo0DIBveD9X9do0MfjsCn+1hzCzvGBEXNzVOALWUGiUKNO2D/I1EcMKhPKGYY6SbYIAyi7eq89CEwHRK+AyxYoeSNFYCeUw1BNcARz8NjqRk4/3GC+Iru8enSODaqDU5xJz9qutzkeLtVlywzBOrf/MBygydaUqEzZQokf1xa02eo4FVr5q0IIj5/DRsfjMM+5hzMR6Nt4Vb3Pbxy/A4+m/6BOkKhSoqs1uM+VCgWNhvkSEuvDHld5dJJyOnWIj2deDN8EYDCYI45e+NiXIqDCO2EnBuVUTCpeLzcsvWlk0vhKzbjNUJ+P2WCQ+m1TRrGcjlOmaoEfXi/KMjLHPSuVkM4zIgrM8E3Iguxb0iCTOp3LL1BTW2W/nIyQ02lC7jA0RyzI1RGRY7uRk+bKVAM6/zNXZDhyG5Gy29dmrd0qwE+inbVNSA7p1pjDAQc5pgvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTVMdUxiTW54SFkxOE4vQnRCZjNDQ21lbG44UDBrZC96RlppdUxKS2NkTnRn?=
 =?utf-8?B?RHRETnhMeHJDbFVVNkNwWDhyRTEvSmdFYkFGZDZKQUVXcHhKWEhjRUZMZHdm?=
 =?utf-8?B?OGdGNHBjZUVGWGVKVWtNYkJFYnJaNGgwOUl5dDR5OFphUHN4cHp6N2p2d3Za?=
 =?utf-8?B?THR2QWl1OUJOQmozdFVFMzBkWVdyZTlUU2NJektocmw2RWY5OExKNlR0bDFN?=
 =?utf-8?B?aVNmdWJsUm1oWDFrRTdyS2ZJL2YwaURGRnJFMXEyd0p0bnFZMVVJVFNLZDg4?=
 =?utf-8?B?RzRyY2hodGFiK2RlcStBaWJaNFFtck1YM1pkSXp5Wkwwdi8vcGMwek04WERQ?=
 =?utf-8?B?dEVDVTBWb0thaUFsUWs5MUxSdUZmRG1pT29aYlZnbTZ1VFkyRnJteUt5dzRU?=
 =?utf-8?B?Z25vMDRDZ1FvRzcyUHFhRGxCa2pCWXZxVTJEaXQ0eVNSR3ZENmx3VUFTeXF2?=
 =?utf-8?B?aVdqZzRKMWJ1OVVXZWZnNE9IREw2K0gxYmhQY3dxbktocUxjVlFaOWQ4cXVJ?=
 =?utf-8?B?ZEhZOFA2RWw5QlhFK1kwN0s4WGRLVndGM2NSSHpzcDVrenVnd2IzOFZ2MUxa?=
 =?utf-8?B?NnBBYng5V0VYbFFwekhJU2xrZmRMRzFZOGRDU3pmby9JbjhkcVdvOHE3VEg2?=
 =?utf-8?B?Z2c1OWNRQ2RnSFZIbk4wQkI1TWlBVkZqL0xqRDZ5ZnF3eWdZZEtpcDdjOVpx?=
 =?utf-8?B?S2ZYeW4vb3Z3Ums4Y2ptSk05VDBUNjZDV1A5V0l1QlZ0VHdzenhGRkVxN3hx?=
 =?utf-8?B?OTdZYkxlVk9pangxeFduaUk4RWhJNW9USFN1QVE3SitWTXJoQjdlc3lYWk9V?=
 =?utf-8?B?QjFJWXJaV09XS3VhTWNub0hySUZKOEZGM3lqTmI3N0Z6dHA3MmZmVmhMdnk5?=
 =?utf-8?B?VWJRTG0zQmF5NVVvcHFHb0NMUlNTY3g3YUMrY1dJZUwxWkhYOFdjQ0lqMWxB?=
 =?utf-8?B?U0NnUGJsWjBCSXg0eHBQRmpYazRhWWIzQkxrd3JsNmtXNVhzQ2pCbm9TeGdn?=
 =?utf-8?B?ZEkvYXl2VjlJZE5zUCswV1ZEUEhFbEoybC9GM1BiS0IyMnU5S09PaUphOUtH?=
 =?utf-8?B?d2pqMk9PeHNjbTdHTDRha1F1OFpQK0xTdmx4V1R5MktCb0ttbWx2OEZPYzkv?=
 =?utf-8?B?b1ZiUXhPcjZsVVZueUl0cEN3WTVkS3Z4cUNBKzVnZW10bnBPcTNOUkM4cUs2?=
 =?utf-8?B?b3YyYjVwaVpSaVRFOWJJMG4xQ2lHaElDU01aNVZ1anVnaCtXZ2xBNkhzemdU?=
 =?utf-8?B?azcrVzIxSkwxS3ltUWxaSDNEZnJoaTIxUWVqb0pPTzd5ZysrN28xcktLMm8x?=
 =?utf-8?B?U01tWnVYMm51MnFqaW9qQ29ldE5obktqamVIZHFYUmYvMHhpdzlsVEl1Sis4?=
 =?utf-8?B?aWdHWkI1ZFBLTXFYdVJtTm8rbXpqV1VYRWd1aHFJWGlsUi9MeUFFMEp4UmVs?=
 =?utf-8?B?WjhPUXQrSS9GdWNIMUI0ZzFZNG94MldwL1ZaakQ3VFNmSzZjN09DeHNBQ3Fw?=
 =?utf-8?B?WTFrRGk3TUJpUXM0ZFBWNzlpbnI2eTRvOUhzR1hFTmdCYnlSbytuOHBPL3hI?=
 =?utf-8?B?UzAxdFN1Z1JHdEJKS3RMYm9kT1VQV2dmM2piRlRWRlZEUjdoU0tPejg0ZVpn?=
 =?utf-8?B?dEpFLzlWclFtM0tmVTFGV2ZlL1RxR1lSaUdodlYxc1I4dG1DdlRmTkNWRXBl?=
 =?utf-8?B?dUo3L3hnd2EvNHIwRzdDQ083Ukpva1JBbWs3eHF1NVJERkgvOXR4Qk9TUHp3?=
 =?utf-8?B?c1Z6cThuLzU0UVorczZySVJWSzZSeE5YU05JdGtNS05NNGQ3Q1VaUElwZ0xG?=
 =?utf-8?B?VzN3MVNhdzZENUQvN0g2WWlYUEdqanNGbnRHTVQ3TVUzbXdwMUEyaVpqM09G?=
 =?utf-8?B?YVVsV0lWZXZkbkhwUWxyY05WcWc2WmJKNmcyWmtoLzR1Qjh1SllEQWlQbVgy?=
 =?utf-8?B?eVgxcEZONlNiZlR6WDJEbGhmQk5vSnJxQ21tRHVuK3c4TU9kZnBBdUdZdUov?=
 =?utf-8?B?Q0ZHbXVFdEJpeUsyMjBycEI0STVPaGN0L0ZOcG56QUorZnQ1MDFoS3ROamxC?=
 =?utf-8?B?L05ySHh5NHBNZkFhcnE5SkNNUnJGZHNJM0VvazZkSnhsOUhKWk8vUis3SElU?=
 =?utf-8?B?NjVSOCtjRVRpY3oxdTZ5NStrVXpQamVtUGNPbHF3NzhzbUZaTUN3cHVyU0FY?=
 =?utf-8?B?SHVJMjNzbjNqSDVvOXBFOG9CQUR2cm0rMS9Xb0xmZlNHdkVhZU9OSDZiYU13?=
 =?utf-8?B?WlVSZnZyUkUydFJwMkVLSUZCT2xtaFdnMktFaFpYclBwc1FBT3FuRzhpbXhL?=
 =?utf-8?B?ZHlZSGVjMWxPbi96a09RL2FIem10SDVOMVU3L2QxMjY1bzFoTkNndz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lOAU6oF2wa8EhnFidXaLqXPkfIsPFVJHU/cYl6rcWuegh5Dw5wkszto9inv76ovRPF/rAg0dASCVTlmbiSkxlQvvUtcswJbxm4O7WcBpNUqyaN7dSsqGtXVjdPvA7fzduJ8PbHIhZm6ZDMXZ0nApk/sDO3nrP4CZsZkeOIv/86eFQgRs4fGG5AIFJVyFmq0MWqEpnwqgHC3ydIuPKQjU97dU6VOJOkeh6y01eLbho7ah9EiqgiBa4XrTeKgJJYwxiu2sb1q5bWIeM2NPgXhIoJK2HLz+KdFwrMu4x3D07QeypDqp2P5fT5gPIxEnqBwVY4B2ydQpDYD243dBinpFXzmW64JI4FuRwdCDcEJWcyI2L7xGT2JIvV4ySJV32NvCVjbnGrcvvNyf7lZYcyCPola5/WPzXf5dsFbRvErh8YiiUg3/5YhOBiXTEVzsdgXUF/8wenMlC2J77EkotMxBDFhLMbYEJc4+Pw/0fP8Fkz+63RNju+fCxiewGZ2EDF+2swyJyDauc1ylFSZaTxpmzyqMMAn09sQ+vgQt5kKOH3bq/eUDl+8SUOC/YGAJ4Pa2Eli3psIuST5xCkCCwL+w8bTJldBw7AoRrYSquEmemcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e414f240-6d15-42dc-339c-08de77e203d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 22:29:34.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sp8097NDzgmA45IO2hRlflRuH6NcrKbgdIxwqyWgALBbuk640d7fmpm6YKDCVnOegsyq0h07EvqAohEwu1cNRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_05,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603010206
X-Proofpoint-ORIG-GUID: 5hpXQ2r4va6-nzEYdKAxhdVdpmTU44wI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDIwNiBTYWx0ZWRfXx8njDwiPEB/F
 MV3m8BInwYc2/SnFAzn8q9jtJd8REWn64BnQJ2LnejL1j+aoIeKB4TJWcXRARKvpf0iTSud5/BZ
 wzGfrMUn2a0eE9ebVwbU9rNtx2F2oqX6ZUZnmzLbyTEXO6JD8yVJNIc+nLX7d6uk809lhu4Ta2F
 Q6z0nzoPnVYbI2Fh1R6NLS0jP0GNluGih2+hXYPg7OuMP1BbgbaOBCeK1DgtUufPl/Ttk5B01Nv
 68knez3nQH4CWFkQYJ+3EPsrGTdLfQSRI/OUrAQFkrA/7af3EuQcEEArson714NRsAJ+xLH7Bup
 WVElZczFBdDGRAmBTifK1PloMXkSSJEoCsRnrL9+BLOYdePgHbgPRMyY3zlXwaeurpioN4DCbEi
 Gbcu91TNbTI6BJghZpcPS+LSU/cBI7kQAFDvqoVXCIaWY+gfZmK/xhGbUnI/KZPtL717mw/2x4I
 3obO9etUzXv3tQ14M0YMiU2Rro7gNMlgyUGHAcLM=
X-Proofpoint-GUID: 5hpXQ2r4va6-nzEYdKAxhdVdpmTU44wI
X-Authority-Analysis: v=2.4 cv=Urlu9uwB c=1 sm=1 tr=0 ts=69a4bdd4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8
 a=oGxgNTJ81x8kuW5c5NwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13810

> On Fri, Feb 27, 2026 at 2:05 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Provide a way to dump BTF metadata info via bpftool; this
>> consists of BTF size, header fields and layout info
>> (if available); for example
>>
>> $ bpftool btf dump file vmlinux format meta
>> size 6516862
>> magic 0xeb9f
>> version 1
>> flags 0x0
>> hdr_len 32
>> type_len 3929096
>> type_off 0
>> str_len 2587654
>> str_off 3929176
>> layout_len 80
>> layout_off 3929096
>> kind 0    UNKNOWN    info_sz 0    elem_sz 0    flags 0
>> kind 1    INT        info_sz 4    elem_sz 0    flags 0
>> kind 2    PTR        info_sz 0    elem_sz 0    flags 0
>> kind 3    ARRAY      info_sz 12   elem_sz 0    flags 0
>> kind 4    STRUCT     info_sz 0    elem_sz 12   flags 0
>> kind 5    UNION      info_sz 0    elem_sz 12   flags 0
>> kind 6    ENUM       info_sz 0    elem_sz 8    flags 0
>> kind 7    FWD        info_sz 0    elem_sz 0    flags 0
>> kind 8    TYPEDEF    info_sz 0    elem_sz 0    flags 0
>> kind 9    VOLATILE   info_sz 0    elem_sz 0    flags 0
>> kind 10   CONST      info_sz 0    elem_sz 0    flags 0
>> kind 11   RESTRICT   info_sz 0    elem_sz 0    flags 0
>> kind 12   FUNC       info_sz 0    elem_sz 0    flags 0
>> kind 13   FUNC_PROTO info_sz 0    elem_sz 8    flags 0
>> kind 14   VAR        info_sz 4    elem_sz 0    flags 0
>> kind 15   DATASEC    info_sz 0    elem_sz 12   flags 0
>> kind 16   FLOAT      info_sz 0    elem_sz 0    flags 0
>> kind 17   DECL_TAG   info_sz 4    elem_sz 0    flags 0
>> kind 18   TYPE_TAG   info_sz 0    elem_sz 0    flags 0
>> kind 19   ENUM64     info_sz 0    elem_sz 12   flags 0
>>
>> JSON output is also supported:
>>
>> $ bpftool -p btf dump file /var/tmp/vmlinux.kind_layout format meta
>> {
>>     "size": 6516862,
>>     "header": {
>>         "magic": 60319,
>>         "version": 1,
>>         "flags": 0,
>>         "hdr_len": 32,
>>         "type_len": 3929096,
>>         "type_off": 0,
>>         "str_len": 2587654,
>>         "str_off": 3929176,
>>         "layout_len": 80,
>>         "layout_off": 3929096
>>     },
>>     "layouts": [{
>>             "kind": 0,
>>             "name": "UNKNOWN",
>>             "info_sz": 0,
>>             "elem_sz": 0,
>>             "flags": 0
>>         },{
>>             "kind": 1,
>>             "name": "INT",
>>             "info_sz": 4,
>>             "elem_sz": 0,
>>             "flags": 0
>>         },{
>>             "kind": 2,
>>             "name": "PTR",
>>             "info_sz": 0,
>>             "elem_sz": 0,
>>             "flags": 0
>>         },{
>> ...
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>>  tools/bpf/bpftool/btf.c                   | 91 ++++++++++++++++++++++-
>>  2 files changed, 89 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
>> index a28f0cc522e4..d49d6a70cb74 100644
>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>> @@ -950,7 +950,7 @@ _bpftool()
>>                              return 0
>>                              ;;
>>                          format)
>> -                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
>> +                            COMPREPLY=( $( compgen -W "c raw meta" -- "$cur" ) )
>>                              ;;
>>                          root_id)
>>                              return 0;
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 946612029dee..08dc6a86bc85 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -835,6 +835,87 @@ static int dump_btf_c(const struct btf *btf,
>>         return err;
>>  }
>>
>> +static int dump_btf_meta(const struct btf *btf)
>> +{
>> +       __u32 layout_off = 0, layout_len = 0;
>> +       __u32 data_sz, i, nr_kinds = 0;
>> +       const struct btf_header *hdr;
>> +       const struct btf_layout *l;
>> +       const void *data;
>> +
>> +       data = btf__raw_data(btf, &data_sz);
>> +       if (!data)
>> +               return -ENOMEM;
>> +       hdr = data;
>> +       if (json_output) {
>> +               jsonw_start_object(json_wtr);           /* metadata object */
>> +               jsonw_uint_field(json_wtr, "size", data_sz);
>> +               jsonw_name(json_wtr, "header");
>> +               jsonw_start_object(json_wtr);           /* header object */
>> +               jsonw_uint_field(json_wtr, "magic", hdr->magic);
>> +               jsonw_uint_field(json_wtr, "version", hdr->version);
>> +               jsonw_uint_field(json_wtr, "flags", hdr->flags);
>> +               jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
>> +               jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
>> +               jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
>> +               jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
>> +               jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
> 
> I don't think this part is useful.
> People can hex dump it if they really want to.
> 
>> +       } else {
>> +               printf("size %-10u\n", data_sz);
>> +               printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10u\n",
>> +                      hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
>> +               printf("type_len %-10u\ntype_off %-10u\n", hdr->type_len, hdr->type_off);
>> +               printf("str_len %-10u\nstr_off %-10u\n", hdr->str_len, hdr->str_off);
>> +       }
>> +
>> +       if (data_sz >= hdr->hdr_len && hdr->hdr_len >= sizeof(struct btf_header)) {
>> +               layout_off = hdr->layout_off;
>> +               layout_len = hdr->layout_len;
>> +               if (layout_len > 0 &&
>> +                   (long long)layout_off + layout_len + hdr->hdr_len <= data_sz) {
>> +                       l = (void *)hdr + hdr->hdr_len + layout_off;
>> +                       nr_kinds = layout_len / sizeof(*l);
>> +               }
>> +       } else {
>> +               if (!json_output)
>> +                       return 0;
>> +       }
>> +
>> +       /* unconditionally display (possibly empty) layout info for json only */
>> +       if (json_output) {
>> +               jsonw_uint_field(json_wtr, "layout_len", layout_len);
>> +               jsonw_uint_field(json_wtr, "layout_off", layout_off);
>> +               jsonw_end_object(json_wtr);             /* end header object */
>> +
>> +               jsonw_name(json_wtr, "layouts");
>> +               jsonw_start_array(json_wtr);
>> +               for (i = 0; i < nr_kinds; i++) {
>> +                       jsonw_start_object(json_wtr);
>> +                       jsonw_uint_field(json_wtr, "kind", i);
>> +                       if (i < NR_BTF_KINDS)
>> +                               jsonw_string_field(json_wtr, "name", btf_kind_str[i]);
>> +                       else
>> +                               jsonw_null_field(json_wtr, "name");
>> +                       jsonw_uint_field(json_wtr, "info_sz", l[i].info_sz);
>> +                       jsonw_uint_field(json_wtr, "elem_sz", l[i].elem_sz);
>> +                       jsonw_uint_field(json_wtr, "flags", l[i].flags);
>> +                       jsonw_end_object(json_wtr);
>> +               }
> 
> This part, I guess, is ok-ish.
> I wouldn't do it either though. Feels like a debug feature.

Sure, we can omit the bpftool changes for v11 and add them later if there's a need.
