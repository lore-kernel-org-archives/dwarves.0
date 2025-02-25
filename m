Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F7A440C;
	Tue, 25 Feb 2025 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446190; cv=fail; b=IfkMnsn14gXgIufGLELk1yN4Td5uCBMDn4LiYI2PVzEAjFwP2TunVaM0mdmmUQnOKIWiHvJwex7lKKJIvtPvI9vosUFah+Df2IM8djuIcB5qzLx5fcL5PGCVqMj5U8qJ/7/NXYyAQnEefp1UP7FRwOrZ1kXeaoEs9v6HgtigCqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446190; c=relaxed/simple;
	bh=IOP14WIFMOKmb7UmQXCgJYcM24Cr3V6W/pvUp+oKp18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=dDkMHVhXTaxK2lAPaey4TeCyFuinX012HsHOG0gfN2JM+Q4t5+jNi8/GxR8yUoKIq5SMsAK283MkIuzNXOYf5xdV2KsH9AYjFHTas0a+MpwYEyPBaZFhDVOz0WLelCiu7daIJmj0pSHzFjssTgr7XPM0VrVvhTM/WLbcK8q1sYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aD28JW/g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bO9rGrhS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aD28JW/g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bO9rGrhS"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BnPL031343;
	Tue, 25 Feb 2025 01:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IOP14WIFMOKmb7UmQX
	CgJYcM24Cr3V6W/pvUp+oKp18=; b=aD28JW/g7JgndL5ZzVDDvpmv8Y1NZwBbyj
	+jesvAQ+2M+fTCwb3lh3Xigu3QX+zxEqY+Jtj1H+uZtlmCnqu3+Ml1oOV8u7Y3RG
	Q/C9SO9NIE+iysGRYvrpK9jz+lovJEH4KYVdNvU3sUcL5npfIfIHMWtvsNYjTnEF
	kMIbzQQBPjwmuSjzNQ9PIYG5O824Bk0CMkQ2Gsar9WF4GSsKrgwZcmwCHhPvF5yw
	Ay0OnXAUSYz1SF7fxDX1jqbe+m4bX5FF6wy52z5mRSf2kgcCBnOdIogYHMiGrhBR
	3lC/jC69A7S+3MjYWoQUKDvjPd2ip7GKO7LNvH1E3t6Rzy0R5B2A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t3xhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:16:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ONMpIB010113;
	Tue, 25 Feb 2025 01:16:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5188j85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCigIyTnHdCz30Kp0yMHzj2fQC5qOgb+DpsLq4pnJO7zPMdx68o+83qfJLcsgr6iCXHhYrvxFVdBxMcnb7jm7rvhgRsWPu6t66Ig6rzqRqpxDipUSLZ3H6nf0aQ2WOljDis2tc6TozOXfStJQVJuIyLRaE5/2ATX9O1S5JlLarpXcQhf6uAh9c+cK5rGJxWk6Tv4kIohy1mY1MQl7xXy0bTiHbo05enKmrFYu9Lqs9lv9SuBTYI2XWRaBzi5yHIQMOGxTP9lsNVKWdqvm7I6yMSHKRfI8BWZ3w6XHiz41m47UJOPKOtHcLR9SZXLFH1hUoCTkhX5dnkMdM0eeb6txA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOP14WIFMOKmb7UmQXCgJYcM24Cr3V6W/pvUp+oKp18=;
 b=hiF+naTaq/nrkdBnJAVKn5DOsOLYrKc77cMbv5AmcDz+GuQpHYYevJeS3vifMUe9jvhIX/aAOmBXtyQMj6m5H+WZcKnAq4Et8Ml6zmP0FbeO++GcWT+pgP9bpDv+s9l7I+9+JSytJXhhjEErghPA61Nei35xHQ9Y8QlEiZjTqENPP5ZpB+A+8Upd/QgRO8m+ArjpQnwns6MEU7TtRweAK/4AFsqn6Bc1uBQbMwXUi2pq1PWkyDUjXgS8TLDSEHhX98mcm7C9/CAMt1kHZoqTAsHPDzSPsBtDJMuGSYCT91VCDBwkTEan9JDonifWuEno1hrI1+azN1HmQcJpKkVEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOP14WIFMOKmb7UmQXCgJYcM24Cr3V6W/pvUp+oKp18=;
 b=bO9rGrhSGUyY/WiuAfvvz3za+X46S0TrKVz3tE8inKOEKTL9FUl9XBuQPkzg/onCSjgc4D+HsGH8Qk0+TUSeQevhKVUhrohHt8ptiBNxrgEI/CtqQiV+vix5IjZM8dLAbY6P38XzTO83i9S7bun9/E7vh3g6wYPqGEt7Z7bI88s=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW4PR10MB6394.namprd10.prod.outlook.com (2603:10b6:303:1eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 01:16:18 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 01:16:18 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix duplicated VAR and secinfo
In-Reply-To: <d3c1201ab0ff7831b03cf9cd00afb09696e6e40b.camel@gmail.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
 <1b0f9104586fa37a5480581e6dc59780b25d3b29.camel@gmail.com>
 <875xl4kszj.fsf@oracle.com>
 <d3c1201ab0ff7831b03cf9cd00afb09696e6e40b.camel@gmail.com>
Date: Mon, 24 Feb 2025 17:16:16 -0800
Message-ID: <87h64i6cyn.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::27) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW4PR10MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: c5410aa8-c476-42d8-9fe4-08dd553a0179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8veqxsPO4fAfMUSshz3/csN3iFOAVozxGwiMq1O+JW0Kz1ozw3MC18olJS5C?=
 =?us-ascii?Q?vtALqMf5cLghgRUlbpArowrpx1tPe3CzfCcW4zsrIimGTHNJCstVLaJAo+MU?=
 =?us-ascii?Q?mgDKh53VBC61K8WtRZtRrk/FUw2K+apnrA8BekjNb840tKe7yEJ0vzAPJIb6?=
 =?us-ascii?Q?EHMu6bax07f2FrtgRgBNYcRNJmDsbFLj8EOLSlbX4x6qnkJXykyDTnIGy/mp?=
 =?us-ascii?Q?WwQ9sUULj6Ujr2njnxXfoOiplyDUhzKZxKs37cL/BG7nAzzfEx9kjwllzIq/?=
 =?us-ascii?Q?0zMoUn64PulkPjHwoy7J0yKgB/nk7+gzwQGAZQaoOwjd/e//czdtysC/bpU7?=
 =?us-ascii?Q?wZpacRa7DWSJFN1fN4sFCytI5lTWFC7fiATcLMe41kyP0XhsaTFc/38yrvgs?=
 =?us-ascii?Q?lMiEevTIH0RtuWcqw5yM019IXNiLMhEpWOgKk10eyE2XGGhYHfsNPVuzhqNb?=
 =?us-ascii?Q?VNePVRZdCExSuvV/msWhoOlC5/IwmMpb+V31vtTLuJC2s27046VN2mIAKvH9?=
 =?us-ascii?Q?8sUsUMCs7Z9hc5mitoXXFCmGnJm6c8aVT+Ve6HLdCgaIc/QRpQgX6N59YJD/?=
 =?us-ascii?Q?ND+a3lTgsYDRz2blJs3RIlf11Vq8WhzzmnCIaULzrX/94yOgyBqsPn9RwCxK?=
 =?us-ascii?Q?Onpszm1Rt+9wUXzDHRTLvbTyvUexdcxNvpJ6sAaxrHsa+QdJbNrfyb2tZQk0?=
 =?us-ascii?Q?ql1phYEhEaVvI/4hO6AYrtJsWtXkbmv/9QLsVWncUqWFk4cutIY4vhXamILc?=
 =?us-ascii?Q?RKReE2R/u0bTy1hAmiaTSZ2uE3aMnv2Ms9sjjZcSar1TY7vjrSdRS2uw53qo?=
 =?us-ascii?Q?Yk00HZCizYfCHxNnqqf6FzPwhUqJp6dIVmDRBVyDnJBS+BjpFU/96H8vvgAp?=
 =?us-ascii?Q?TTc43AHWNn4HTmWV7VqUvbyjlbyHZSP44MsJivqVJrNRigvxG7jyeJjSIiDh?=
 =?us-ascii?Q?Tzj5eFJRiC8jGJ/HhKddQQG++BokUsfbO7uJPpdFZkzX4ZoHXPONbopqhbLc?=
 =?us-ascii?Q?cGZX3qsXRMhkrTRtDgWDu9H6BvG4ZKEbIFrhCCEV5Jtx8W7xaC/ruf9H+Qr6?=
 =?us-ascii?Q?aZ/15YW2YITk0GpQlNmHg8W6TvsYj6ZvxJTAn8493tCAnn3lewe621oTASkz?=
 =?us-ascii?Q?L2I3KGGRssyo0N5NAwyXQOR/YCADtp71w8Oiu7q6isyf6I636Gd7BiImanvc?=
 =?us-ascii?Q?EWFkP/kq99nsY/O7NgFqCMLa6pU2UTwxZ05tlDJ9yPQZ+WXVVcadbkb9PtTe?=
 =?us-ascii?Q?ww3DtzPLS+40GV/8Hd7YFlZxYRvXEno1Rm8QE4UA3ZzfMt3+oE86Y87LOfqr?=
 =?us-ascii?Q?3dSopKrodFIIG36XRYofQwzahruqKyGMroAJpPLGxXvYw3OsVaDwxHtBBXHM?=
 =?us-ascii?Q?MmPohjSbalS7OCPP6xsijDN5MkCc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFIKO69Ph0jSrmGGuIuJDJ9ArZ7cOy84bv9IyNInqzoDTRDgjD12W+o1DGN3?=
 =?us-ascii?Q?+ydUaYS+ogbw5xgWGvi8Nu+FXXeLJBJJK+cVjDuHJCF/dCM6236rZcqk8EmF?=
 =?us-ascii?Q?gAh0SomorbjIBNFPLtmbYqxkXRIUhzSSF4g7nY7tUkUZdJ1RgGFth+DtOECI?=
 =?us-ascii?Q?QFRyx0+IbrHXONzkw/8nq68w0hK9cLLO0lgICvwCWLXCeIrXpFtJQMO95mgY?=
 =?us-ascii?Q?XgPOnyRHoYotIUyE4bhxzmzSbyaM5wGf8IAa+EZMp4VstpqMjR2cR/VFXr68?=
 =?us-ascii?Q?Uj5nEcBzouup1+u/fsAYgo2YlbL6RBF9q4wGND9i8ZLQa2mH1LPbiL+HTHHC?=
 =?us-ascii?Q?mXrEBhfnp0JDlvqpXj2IjvHaqVJKVw2OpF0wWSCsO1zm2nVZ/3VsMOJv4tNO?=
 =?us-ascii?Q?H6bSNwegdwgFrorWX6yDqhf2jij2rNDY8HjhJ0JOm8uChcZ5IzMibldz9Zem?=
 =?us-ascii?Q?AkpTPiG5XfWnPYzasfTzELNfTce8e4jYzINwnnznXkD7dxZg5z36oP3cKyAt?=
 =?us-ascii?Q?NTSuvXNdMyDYOGSLBCTPfFYdH/GvjyRs1lkSxq1rT9tDk+gUCZTbGaEPZp7z?=
 =?us-ascii?Q?XV237NZ/c5znNyA2GHS4D0cTXNmsUPuB2ws6/ZIGzstvopjGwBHomhHM48kS?=
 =?us-ascii?Q?dkhbe/8GOG3v2LhwfT7MxnrRersJ0tR5x+uUaDzKx1A1oSvcEVSEOGrgl9H0?=
 =?us-ascii?Q?DLbG8Srgg5GdpxZANZuJ8KsMxTYt4QMR0pESJfPXEmYCrm7qaLoG4bNVFBRw?=
 =?us-ascii?Q?zelagx6kO3wPCfHVt/d7mJfYLHe9D+qgArNX5592j9LuqaS61BAwT9tYnQEl?=
 =?us-ascii?Q?uE4xVgaxjkM3kviwkATAgkEb+gGS3rGOzkGTCpWdCsGQKN/FlCNeKl9cMT16?=
 =?us-ascii?Q?7aJC/5CjSOAsgfzNJYKBlpk288jVJ6yPYSfeyr6EQr0ay+X8WVjBkULl+zNG?=
 =?us-ascii?Q?/ZrZUmzjcnuiLpjE6ytgsAJ1PeHE+6rf5MLGBf1TTdrRWQKhHgX/Dzk1ql0d?=
 =?us-ascii?Q?vGDESVkaJHa3IlLRRP8oaBz9BA9VMzO23uf7s+JDdCDjQJEgYsdW07PYzNwU?=
 =?us-ascii?Q?l6dr1kRRdZo4Q+I+0pxVC/DD3TcApZNK+BcXkufKPGzU2M4hkQbZc7C1fevy?=
 =?us-ascii?Q?b079mMu108ZEPmXheZrw+24oik+xaPyuqEuWiwZ01MZuWPrKS9NhtpKRkAgn?=
 =?us-ascii?Q?Aao1tQe9YQxjL4lJ9r/HlR+yCgeZnGpdZ8cM5ydtYJc5ZEDAP/qrqTby7aL3?=
 =?us-ascii?Q?oaTZIea4vvu8Nwt12IP9/hC1Q1nUeMdkJfoUXQUNvKW9q02s7qdja5SPJ7nb?=
 =?us-ascii?Q?Xp/CR/o0kK0BWB2MlhlQU4ZYzkpCSv5ivMtjsWexAAZmfpkqV/ZULRPacJRw?=
 =?us-ascii?Q?AHPrbkNzMDKM4ojvmyhxiUQM+BwV+7G+75d1VOwsFiECdJRkYaibsz7q6SA8?=
 =?us-ascii?Q?pVkAL/SDvFGxtXcSakPh2TslB06pfQIzNYduheN2KmKW0Ru3NJJGVoQJjnBR?=
 =?us-ascii?Q?VxLUHEDBd510G2+c8SUWG7Wwg+tt5JFfI0L3d5WSzwpmWAp2rtT5iyoxybXS?=
 =?us-ascii?Q?lGgQRH6Gr0J+PYGpFKXjr2XZxtEtpKQ9jmpPWjaDcSE01kaZtimTspP0aqbN?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lHF2aZdfWgXjdb5/zrc9HTzuDOVLlBB6sHtkC/jeENKjDWHSdBbKRIrb/toaT+XFuP9jjRaB9cl+xBzNAz2vnHOQ4dGgXuEvwXJCmP8IWejolm4GNIgNBs4IvhVsWd8OyMp+zIub6KhkS4arndd13GJNKhXOTlm21iZQyWvDzjaH4Eke7uY3Dgsz7tk+xOsbad7zyaYZu7qnLZ/EWJgV3sfQmxCaRLXvJMEQiXDwkcwixDCvEr9As0U/CDowOsAjA474Nsctu1g0Zj5ozwT5tbtuI3vMW9G+DfkevUaa1Hs7voJipSsW+rE+ptmtZ4fA6pusOgnOsFaUSdxUvp0Paqhf1XQTD6BJhOTvQWKVpndcQP3QAxm19Wz6du4JiSWh2COA8mlt6daAVFPmP1dSa8Xa0jEEgxFw0ndPKSQgqACm2VANI4MdPwR23fXdVONB7+ZuP2oAEv7v86Y3nJr/8IHIHP4m8neKCf4Bc82Ebl9o0fgVPFnogRKEkH9mnpKxaEQ+fj0g2UE5a0UhU065Lzg2n5w7vay5sE+cC+4WXyHo9IACcfRlRfFiLYemojpJ/tqC+S2iHnfUKz7vbt1bf0k9U7POmC1a6x+RL0flvoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5410aa8-c476-42d8-9fe4-08dd553a0179
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 01:16:18.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB1STzwaGDF7XR23T0IIwiBu3mjB9uq1DMhEMC3gbmLawYgRp1EW3w2xbtytkyRL1Y5eZAd8oDnv9o1f6GSk4GN/kWUcvxjvFeV1vnUmBIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_12,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250006
X-Proofpoint-GUID: DRehiPwLjSgySSB5WUbDHiZRMWOL0Qln
X-Proofpoint-ORIG-GUID: DRehiPwLjSgySSB5WUbDHiZRMWOL0Qln

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Thu, 2025-02-20 at 17:05 -0800, Stephen Brennan wrote:
>
> [...]
>
>> Thank you for the testing (and the review). I haven't yet been able to
>> reproduce this. But I see you're using clang. I'll spend the morning
>> building & running selftests with clang to see whether that is the
>> issue.
>
> Right, should have pointed that out in the email.
> Clang version is 19.1.7.
> Just tried with gcc, and `./test_progs -n 1` indeed works.
> Then re-tried with clang, same result as yesterday, test fails.

So I've set-up a Fedora 41 environment with the same clang version, and
the plot thickens, at least for me. I haven't even gotten to the BPF
self-tests, because clang is giving other duplicate variables!
(To get these values, I uncommented the error return from my pahole
patch)

From vmlinux:

error: encountered variable "fs_ftype_by_dtype" (type 149818) at offset "3d7500" which duplicates variable "ext4_type_by_mode" at the same offset
error: encountered variable "fs_dtype_by_ftype" (type 149814) at offset "3d8c60" which duplicates variable "ext4_filetype_table" at the same offset
error: encountered variable "pt_regoff" (type 52d893) at offset "3d8e50" which duplicates variable "addrmode_regoffs" at the same offset

And from modules:

error: encountered variable "evergreen_dp_offsets" (type 4e9b6) at offset "19760" which duplicates variable "crtc_offsets" at the same offset
error: encountered variable "ni_dig_offsets" (type 4e9b6) at offset "19760" which duplicates variable "crtc_offsets" at the same offset
error: encountered variable "rv770_smc_int_vectors" (type 5cd3d) at offset "2f220" which duplicates variable "rv740_smc_int_vectors" at the same offset
error: encountered variable "cypress_smc_int_vectors" (type 5cd3d) at offset "2f260" which duplicates variable "cedar_smc_int_vectors" at the same offset
error: encountered variable "juniper_smc_int_vectors" (type 5cd3d) at offset "2f260" which duplicates variable "cedar_smc_int_vectors" at the same offset
error: encountered variable "redwood_smc_int_vectors" (type 5cd3d) at offset "2f260" which duplicates variable "cedar_smc_int_vectors" at the same offset
error: encountered variable "caicos_smc_int_vectors" (type 5cd3d) at offset "2f2a0" which duplicates variable "barts_smc_int_vectors" at the same offset
error: encountered variable "turks_smc_int_vectors" (type 5cd3d) at offset "2f2a0" which duplicates variable "barts_smc_int_vectors" at the same offset
error: encountered variable "caicos_cgcg_cgls_default" (type 5e61d) at offset "2f550" which duplicates variable "barts_cgcg_cgls_default" at the same offset
error: encountered variable "turks_cgcg_cgls_default" (type 5e61d) at offset "2f550" which duplicates variable "barts_cgcg_cgls_default" at the same offset
error: encountered variable "turks_sysls_default" (type 5e622) at offset "30660" which duplicates variable "barts_sysls_default" at the same offset
error: encountered variable "caicos_cgcg_cgls_enable" (type 5e624) at offset "30920" which duplicates variable "barts_cgcg_cgls_enable" at the same offset
error: encountered variable "turks_cgcg_cgls_enable" (type 5e624) at offset "30920" which duplicates variable "barts_cgcg_cgls_enable" at the same offset
error: encountered variable "caicos_cgcg_cgls_disable" (type 5e625) at offset "30b70" which duplicates variable "barts_cgcg_cgls_disable" at the same offset
error: encountered variable "turks_cgcg_cgls_disable" (type 5e625) at offset "30b70" which duplicates variable "barts_cgcg_cgls_disable" at the same offset
error: encountered variable "caicos_mgcg_disable" (type 5e626) at offset "30f50" which duplicates variable "barts_mgcg_disable" at the same offset
error: encountered variable "turks_mgcg_disable" (type 5e626) at offset "30f50" which duplicates variable "barts_mgcg_disable" at the same offset
error: encountered variable "turks_sysls_enable" (type 5e622) at offset "30fd0" which duplicates variable "barts_sysls_enable" at the same offset
error: encountered variable "turks_sysls_disable" (type 5e622) at offset "31140" which duplicates variable "barts_sysls_disable" at the same offset
error: encountered variable "sumo_utc" (type 5f2dc) at offset "313f0" which duplicates variable "sumo_dtc" at the same offset
error: encountered variable "dte_data_curacao_xt" (type 63dee) at offset "38f00" which duplicates variable "dte_data_curacao_pro" at the same offset

From what I can tell, these are all const arrays thrown into the r/o
data section. Their data are duplicated, so it looks like clang has
mapped them to the same addresses. Which is a pretty neat optimization!

As far as I can tell, this is perfectly valid, and I think BTF should
allow these variables to be aliased. So we may need to revisit the
approach more: (1) pahole should still deduplicate identically-named
variables at the same address due to the weak symbol issue. That would
just save space and avoid silliness. But (2), I think we'll need the
verifier to allow variables to overlap.

I'll do that and continue testing.

Stephen

>
> Thanks,
> Eduard
