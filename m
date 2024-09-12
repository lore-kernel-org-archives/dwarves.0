Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F321878;
	Thu, 12 Sep 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168133; cv=fail; b=Ap1047juykSsuMFmbXYpbP29WeOUIgjxs/++5SrSRK0t+RQQtdtsEc2j8Iu1JNGIUOCo4UhqyhnQTrG1AitZuqiyb5uFufOpspfDi6HIIfbbBjbV51YK+h8pqW6oacfcDEO5on5rannYgewQsALCMFqQZUr2oXIXLGCiV0HPfMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168133; c=relaxed/simple;
	bh=Lne4+pcEbjmKKzoxdWtGQ6ymXjHQUXMrmCJ7XW+jyLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EG+v2W0EXJaJpGldYboqVE6CJ4mso5Ej6384qJGfYPc+xvV6AiGu2Erj1vI4/VQzGkZ32vSJX7rdoQHUkAVG8oNkv6CFzH4hhHBGmk5vQSE1tbGlwKFYZqOXfRasuzW4tRZgeUVCw639pjdCy984MrxCNvIMnHKgRVT8Jdldqcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e0AV0iqR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bu+mWWbd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e0AV0iqR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bu+mWWbd"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIfZGs024403;
	Thu, 12 Sep 2024 19:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Yflf7/F660EJA67qyZaC1l7RBWykH9NzmdYfoY+b2VI=; b=
	e0AV0iqRuIxZYdUjdbP9u2lJVB0PC0AgUvKDUTHgHxCNmb7Z8cAabtv6LG1QZuws
	F/u85GB7Ap16QB9K8sB8F6bhGJHNy66GltoA3go2cjFVKdeINK2M+i5sYkOcGYZT
	Bq0ZBLeO6XRf0VwXd0Zi7swVFn7740dqPBpqh30/raIRPPnpZUj6aczKayUMB5BT
	NRSmr3U1m1meoJROcZ/PoVP4qzpy1xbX6OrRcCvx4Z3cT0z3Pp+zj4tddXNelUGy
	J/Evgk7utn1ztRWMd86Qo8+wV38NfNeMjFefzK6hRwkz/lpy0PCi4DVy29QwQCQp
	OeeZ/CQsXLPgUbUhAe26KA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8d3juj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIj9cZ033550;
	Thu, 12 Sep 2024 19:08:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bqc4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NliEu7aNKG+1B+AN6+dKAsFSFU7Or1QNW6DvM2DPj/u4nYWDsi7idWYRnEu8qdEGk5UcwSKv+Y7XEfeEITn9k+qmU79fNrvRYnu7gO+3i6IlIm7gKSmsPkE2auqlKCJM0zDbtYnnr+z5zYvZAyr3yvnVP0I3BKbumAdZqx3k8LPnZd5QXaF+SaHTsglsAHVzRXeZzah+jLyMOqQlMfGgyJSdwMTbnjcQ9tHUay4vfxekldmQIJvxXdWiiayfF8Rczp8QdHdMNKljvp0akpjydq+xky9JlpzPplDB2SNSeWXJ5KtYJucbQ7qo4sYLL1BjOul06omqqhDOHhukFicQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yflf7/F660EJA67qyZaC1l7RBWykH9NzmdYfoY+b2VI=;
 b=Xn6UkCPQVq/Zx1sJCvbRWp05XOYEMCru2n58CBVmbyCnF6B0cXxUy0Xeihz6wRRvVHRNkI+2OCRxWrSrKx0X8qHU2pwunMCqYyy8qVMQHEfl5Ihz12zns8tEkNRvW3mJHumixStVxaFvZRIG2vdqIl6U7+04tHE9oPjV0PErDdDLKGAgKfO+8f7om9Vza8Nn4K98H0PMWA//u07DqM6LAz3ocNjBXMlL/y8eiOKUsx+3z8xzDhoELeCTdebf1G8zc7SmKoKblFhv9GgspOsOGTLX1KZWY4kZ4bcG/ZlqrIt9r5ErXnY9F29G7IEcWY8vEQh8Uwfo2b/UboXKN0K1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yflf7/F660EJA67qyZaC1l7RBWykH9NzmdYfoY+b2VI=;
 b=Bu+mWWbdRlVjTVp5BF9UlawjVZbITRwZy2tj6rUM9HCQuKeHc4meEXmC1o+D8HzkWzyDQ0MTEXjrARwgmXtiTqKorxd+Nkg/hHuRAqtyAdqoOqQG9jIkR3FjC1PbB9gIYtFLeZa21lesPr5sEsGGFpVz8lHCau3WnJ6CWrBNIQI=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW4PR10MB6533.namprd10.prod.outlook.com (2603:10b6:303:21b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 12 Sep
 2024 19:08:38 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7939.007; Thu, 12 Sep 2024
 19:08:38 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 3/4] btf_encoder: cache all ELF section info
Date: Thu, 12 Sep 2024 12:08:22 -0700
Message-ID: <20240912190827.230176-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0057.prod.exchangelabs.com
 (2603:10b6:208:25::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW4PR10MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bde4af8-6dce-4d25-d4c1-08dcd35e4ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kRN7Tg9kULSpNGzOkpxaXk28k3XwQra6+Mp6b3HfFz+RvtfMFx+Vio0VBRcH?=
 =?us-ascii?Q?nvIppSvkqnkXxmcJUvy7XSvJC8i6xGYM1vfQMQ51JyH3hdvir9txlGv5NEFz?=
 =?us-ascii?Q?agBPNlYWxUS/kRrW3kXv9gf2LgIafR1ri3BCeWrBlBZnp31OhBX/p/fBJx3Z?=
 =?us-ascii?Q?/PN6Eke043q74XUJtte34OhEobopajvKcOZ6PGkuVEe0qWZG5vYHMjLe5Afl?=
 =?us-ascii?Q?duXLAZlpID6j21L8WjjRLNtZtZsQcbtCzt9mn56zm0phX5eXep1GW7nV/0YT?=
 =?us-ascii?Q?xVLU4maTfT16/YsibsDgzVMN0Nzf8WJh1zZxVSw51/frr+VF5F8dcxwTVVW/?=
 =?us-ascii?Q?KBMoBVov8ceeUI/vTyKfAIVMKnB2aIxJSTM4UfOK6v1tl/RIRHRQIEwdrx1I?=
 =?us-ascii?Q?Ed2CE/Gvsvmnc2Ir0Q2dKqJPgFxkWCplTRn+NKiDhzs++uGWxYANtve76xwP?=
 =?us-ascii?Q?7TdWn8dKIxwIlwPrCle80q61wzH74RCcSX7L17mjXLyNvIrVS8zaEMPdAEBA?=
 =?us-ascii?Q?67n8GSc7LHAsEgUKOwE1glna52kWdSifBbWODbaENbbG0e+aEuZu2cwtCsxx?=
 =?us-ascii?Q?goaAGJJConYIX4hOVJVnE2BZRdbKUBwRagpxZxl0NYO54lhDBYPB5CjEMiRS?=
 =?us-ascii?Q?CkG9WUp5SmZ5XoZ7xn2bayH/nSfjxxr9J663A1sBkpPvbZG7e/NKXPEhEN/E?=
 =?us-ascii?Q?z8lB9WQFGy2nrHLyJxCG/u/x7LCLhkvfeBa0mhEbny/CB6CVPrkrk9UeAbt1?=
 =?us-ascii?Q?AdxJr1/qNnxzRBmwrPqtt5umwgn1WWZR7c8xRB3wh5bUdpsPZgPr+nBn3nY3?=
 =?us-ascii?Q?nQUc6oS5+ctqoyZj95MYtlcB0oV8TQ/iRbSSssz/ia3h7dOEkeNsi2WBx3OH?=
 =?us-ascii?Q?XZQftyz0WPGa0GiecXFVdHB99Vly8k9GvzndCj+ptTkmuQ01vzpNntKO4Smh?=
 =?us-ascii?Q?IIRc3kWchymhX/XzK5bKh5JrLHGcGryWsOaiP3CwMcl1qJUY8wfHf2HQEldQ?=
 =?us-ascii?Q?HnnPrTHsU0k672sDdGvLWdWttroarR0CxvXM9l7HRGy4PkVCObUOiYPUsgfd?=
 =?us-ascii?Q?BpDijtOziDaUxCfoidIkrY/pdzniCHmC6zdVVlz61g8ZtA3X2+q27ncG20lK?=
 =?us-ascii?Q?0QwMfbWRBwebFVwf8WBPqkRKdH/okLnAEl/QK/a4Tc2VMOMRXQRj4/PcSlDc?=
 =?us-ascii?Q?eRw1/Om3EEydriMheY0MjTT4nlJlmOekLCuPyVZKdCLdnU/H4osTpIgtIXUw?=
 =?us-ascii?Q?8xco8U9+hEEKOA5jo87xgmWMe28xhgNC0Ecc2fnEy2yDhB1hKSww3p3dxgVW?=
 =?us-ascii?Q?s/4d9/3PPlRU4dbDmr1jE/Vj/j7dTi0HQ+6ZBm6Qy2aVuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PjTsOSZvldgRvREpifJfibvPPNLpX00lP+sGkIYjbsnUD8UY31zRvDIYUX2F?=
 =?us-ascii?Q?e2lrvvRt/Ad9ZgcsB3LfwvQaOAIItqmn1cKEOooxO58U+Ewyww9r/aoZd2rb?=
 =?us-ascii?Q?CDdrCgmr1oJU0VLr7iyfHp+0ykX9nzdPtG1Fv61PXw+lPxFxeGMdAwgfMbOi?=
 =?us-ascii?Q?PyoOcI3V87x9tFvsMN1/nhKgBkSpNIiPb2wjx+vXXhEhKQHGl410/gW2BFrX?=
 =?us-ascii?Q?Gc00+gSbhRecpkm0V1eh5tTUvEfNwsuLqLAZjaUsxLf9rgag0CH4PMtf5U3v?=
 =?us-ascii?Q?d8juqgYp+7KHjBsT53rSrMmZ9FHjYTN7pdoEVRT2ZS0biVcbSMVVk1QAY3A8?=
 =?us-ascii?Q?vfXVnKOX/Mt6PMEWMCWln5tlzFNC9CbAj3waekzybGhKku3VtRWcGBC9729x?=
 =?us-ascii?Q?fPMg05b9VZ7lR0v5Q4j2H/0mZDgpM8uHoHG1hc0aqdX0SaSylPqEwdYdKXAB?=
 =?us-ascii?Q?86WIlZxMWqyLVsAL5SS+kI5kEo49GiSyFdvQywxBAND04rND7aFGSCLuk7EU?=
 =?us-ascii?Q?g+a3JkNHIkceXzKzHnTkXJwTmvZ5p6p8aGPFgMKqpeDZw4HzbKhlorR79Ukb?=
 =?us-ascii?Q?jzcqua5aClgg7GTzgg3p+K8BWoqDYYTTYvZewaCPb3kQuhYoih6doOEUdAGU?=
 =?us-ascii?Q?XZbkvvhZwebJtIK1Xd44DVneD9NZUQp3zR0tnJ3vq8S/TMSbmsFLVL5e4hb6?=
 =?us-ascii?Q?WjkQsZgkx+5KCqpy2XKza90UzTefvjP+qcUxg4plT/2ZWgEyOOLPjOz3BbhE?=
 =?us-ascii?Q?Z9Q3D26kayeZEGaScK7yzoZoRGpVwjBeAvIJzsx1AiXTpRXNPPIMQwT4/B/v?=
 =?us-ascii?Q?KovX5ZDLvUtEkMCjS4yqihZONxXr+Z49FhI6tav1i9oOccQiFF7q6E13jZaC?=
 =?us-ascii?Q?6tObytyZnG+PzYbQVZvZC7jlfpd2Nd7COCUIK7qJLICsBNPul+FehE63hyf0?=
 =?us-ascii?Q?9k6qukATqfy5dkO7pq7UwyO/WBYwmGjtZXeTNml3i5cx7ZhN4/lH7wyNsV65?=
 =?us-ascii?Q?7TfduEzLoTXKZjQnR6iN9DpIhzpV5pJkwO26GFdH/N3fGq9kJxgr6rPq8P8y?=
 =?us-ascii?Q?fWLen2zv+NBLCwji0w3rCuwFwA/aigcwU2fpveBzgIAlI5+QFjFqRoVxye54?=
 =?us-ascii?Q?kweT1u7PBGRKrr94RKhjo2YozXWZvtdpSV34T4UZ5OreykFCTewm+V/TosoD?=
 =?us-ascii?Q?efeSTZQyAUZHpjuGyQtWKcTcs1BZZWopmk8ZwzAyoejiW45QzK4dhxeg/WHy?=
 =?us-ascii?Q?VnaqeATZjtHKJNQ42h840rra3oFqx5Ei2o38dKX4+NKXZ58HVKMHSJoaRhrR?=
 =?us-ascii?Q?8KVNrO8AVtrAdBe0NuISv6QFhBSL8zVtJ017x7DsTiBykClRGW4LfA4lY2hm?=
 =?us-ascii?Q?GSYjNPGVbe2/50NnejYePvFAl3tX80Z9PzHR+qcD2LF1/esXcEHluxNnDNZX?=
 =?us-ascii?Q?pOZsTiozhPZt3AGm7vFAcCPaTN4H18qdpux+PLXethC7rlHfNdNR7BlYNJgT?=
 =?us-ascii?Q?mLfPekbvKEzbX/34zwhTtnhHq2CXUehYD7mRKMAWV5STlKZgflPeWNJtm2xy?=
 =?us-ascii?Q?Nu419PUaBD1824HrtRYV6tf8DCSs9fUPe0JqyQ80VaLijcWnbN9cAy5+sgLZ?=
 =?us-ascii?Q?h7L95iFEg7EpA85UbxRj+dU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f1lpBXfkvFjZov9GKFzwwnwPUn/hPZuMFKxDD6TuGF/M9Pos5f6AX6HISeS8xTJJfEN6aSAlf0JYZmRSDssi5AF0usa06MEcQZgsufV86/HX+1P7bFxOQ6ktmJ5zpdKAGA2GA1OhhOdUoUVTxri+54YjZ4vNqWwnETlJgOQrgq//61aEMf3X4LILwoqc2hyCRnpZFrviQ9h6mOpzWwrHmWVmi3prD4AKUmvTcGwY3jZ/+xo0KO3RijS/m0RS3EFOGVd1e4dFgkD6S8a1/t1I3rmqQjEXG/iD9UYJWHubNRgV0dVSWR7o1PYCyqDWrX1O9NI51/6P8gy5uCU6acIgUrFWeL1+5XraD/7BK2fj1ifDq/e3itmArqnOXQNvpRRG4/6ZfKa6/qRngXJAEaBdKh8QsULnBESZMWI8DZhWIfS9kCYh/6eQ7V8pc5uGFTPKJ4PxT+RCt2O1jJEO1OSvQKc+Cbf51p8WWTfgl0IIdnXtFnGooBS56LQYOeABDBaovRucDvu5MQYWmfFmxOFdhtXehR79DJGpSx/9yipj45N1Kxj+21HTOQFg8wz278VKnf4HyAGWQQ+J4md4u2rBDGhxNVKiNfBXD/8EW1Xc4mA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bde4af8-6dce-4d25-d4c1-08dcd35e4ebc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:08:38.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1dl19d+bgVGm9jRyFrxv0L+vsMmm5PoGSlf03ZHcVafPogdyFZ3k1qsOXH0trt7Nvq/RI0wmL6WHrcaSmxbYwo8vgoLOqawAw7FNMNHr38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409120141
X-Proofpoint-ORIG-GUID: mG6yNVoFU17cHahmfRn7x9jCPx32_9bi
X-Proofpoint-GUID: mG6yNVoFU17cHahmfRn7x9jCPx32_9bi

To handle outputting all variables generally, we'll need to store more
section data. Create a table of ELF sections so we can refer to all the
cached data, not just the percpu section.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 8a2d92e..e3384e5 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -65,12 +65,20 @@ struct elf_function {
 	struct btf_encoder_state state;
 };
 
+#define MAX_ELF_SEC_CNT    128
+
 struct var_info {
 	uint64_t    addr;
 	const char *name;
 	uint32_t    sz;
 };
 
+struct elf_secinfo {
+	uint64_t    addr;
+	const char *name;
+	uint64_t    sz;
+};
+
 /*
  * cu: cu being processed.
  */
@@ -95,13 +103,13 @@ struct btf_encoder {
 			  is_rel,
 			  gen_distilled_base;
 	uint32_t	  array_index_id;
+	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
+	size_t             seccnt;
 	struct {
 		struct var_info *vars;
 		int		var_cnt;
 		int		allocated;
 		uint32_t	shndx;
-		uint64_t	base_addr;
-		uint64_t	sec_sz;
 	} percpu;
 	struct {
 		struct elf_function *entries;
@@ -1849,7 +1857,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	 * ET_EXEC file) we need to subtract the section address.
 	 */
 	if (!encoder->is_rel)
-		addr -= encoder->percpu.base_addr;
+		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
 
 	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
 		struct var_info *new;
@@ -1923,6 +1931,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 	uint32_t core_id;
 	struct tag *pos;
 	int err = -1;
+	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
 
 	if (encoder->percpu.shndx == 0 || !encoder->symtab)
 		return 0;
@@ -1954,9 +1963,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		 * always contains virtual symbol addresses, so subtract
 		 * the section address unconditionally.
 		 */
-		if (addr < encoder->percpu.base_addr || addr >= encoder->percpu.base_addr + encoder->percpu.sec_sz)
+		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
 			continue;
-		addr -= encoder->percpu.base_addr;
+		addr -= pcpu_scn->addr;
 
 		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
 			continue; /* not a per-CPU variable */
@@ -2099,20 +2108,33 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out;
 		}
 
-		/* find percpu section's shndx */
+		/* index the ELF sections for later lookup */
 
 		GElf_Shdr shdr;
-		Elf_Scn *sec = elf_section_by_name(cu->elf, &shdr, PERCPU_SECTION, NULL);
+		size_t shndx;
+		if (elf_getshdrnum(cu->elf, &encoder->seccnt))
+			goto out_delete;
+		if (encoder->seccnt >= MAX_ELF_SEC_CNT) {
+			fprintf(stderr, "%s: reached limit of ELF sections\n", __func__);
+			goto out_delete;
+		}
 
-		if (!sec) {
-			if (encoder->verbose)
-				printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
-		} else {
-			encoder->percpu.shndx	  = elf_ndxscn(sec);
-			encoder->percpu.base_addr = shdr.sh_addr;
-			encoder->percpu.sec_sz	  = shdr.sh_size;
+		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
+			const char *secname = NULL;
+			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
+			if (!sec)
+				goto out_delete;
+			encoder->secinfo[shndx].addr = shdr.sh_addr;
+			encoder->secinfo[shndx].sz = shdr.sh_size;
+			encoder->secinfo[shndx].name = secname;
+
+			if (strcmp(secname, PERCPU_SECTION) == 0)
+				encoder->percpu.shndx = shndx;
 		}
 
+		if (!encoder->percpu.shndx && encoder->verbose)
+			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
+
 		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
 			goto out_delete;
 
-- 
2.43.5

