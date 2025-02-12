Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1917993;
	Wed, 12 Feb 2025 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321424; cv=fail; b=qLikBcIIocyu7XvpGmVVnFB3t3cO2GY8cwJBFEB6vQeFGBE98wYI2NTqwOPTuchxbJ0sFdmjVxYtj3ImR5UvtnOSWo9xt3QybBD0X97E3TY/Ad/CXyWRBgkS/NzviXvkgtNRWVjo4GljPVrs6fc17pKHrOwpuZaeAk8p4wnRbxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321424; c=relaxed/simple;
	bh=XFeO7zwvJz5RSeMToXPBk54zmaCJdzb22hokcVnUWV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lysBRwckImEjp3UD5YH4g0onsLPtoXKbvIy8u/E/4z79084hu3cQr8kTmr5bgIR/oKfimJkMWkN/oPzfajyHGsYePK3wmiTBaKCXIZApmy6qZiG0KyQviKe70oV3IPMfpmJMiVFG3FKsDinY8rHC3SmZkaEHRwYVpDbeuB50Q1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QVkarX7r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u6uN+BJ8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QVkarX7r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u6uN+BJ8"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLfx33008451;
	Wed, 12 Feb 2025 00:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ppnYF+HRPolEv9W9WSCRzVf9mtal27hwVWpXIFhLaUE=; b=
	QVkarX7rJ88NWOQhSxT7aj7hxVBgF9w1CFrXFsTZj4M8qgK15uFAbT+ipcoaR6x4
	Z8IujS97bRikKXPWQYKDr/NNjqHECXIE4moXmYvkGLie/Vpk9ec4tlyAnH9Eoj1w
	OIHfQtH0Y7i9rh7boMqbjBNS7wC5e4rrBa6m1UmAe9OgRAeFArfpCT45t3xR8u6J
	W8je+VC1QLEfSeAfTRQvcvPKxe9UEisvdIJgizzniK7KBzbAp4V9c9ubpogrXGjT
	4zREcPGmOPNzmQoWFgRHIxvcvVYHeFSMsWmtfeGz3IPu2nNmO0NKizw15E3CZ2Px
	wxNbETilSFCfpTVvA8Pl8Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2edmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:50:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0UNu5009748;
	Wed, 12 Feb 2025 00:50:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqfv6n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvt4u6XtVOEcOFLOVhZXndBAPB8e9dHWOvRk9BmWIertCtP5cSdg+Z2YnVnGfGESJf6Vky2qnYlFrqDmh+uzNEBVpLGy4H8VkWLBE4F3IaSccdayBzGQ+Ho1HbO+VRSnrHWSEYF23zCDghoQ3mmR1kCLv6L5K7PeB0YQJjJ/oLt/atZgy29L2L08KOb3RVHi42OImx7eAVQ9x33YhYY2pxKgqzIrZHCXQpnuNzMnpOT1mzn1TDF56arlbFf0gcHgnq05B5XdCN55hedZgfc2I+qFttxaH2kxsCTFGFwfVxhp26oNNAm54Wr3AC3QQXwSJjTK5oM8ZPLLZDwjtMOZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppnYF+HRPolEv9W9WSCRzVf9mtal27hwVWpXIFhLaUE=;
 b=jc+0FimeAx3QAYn2Thx8Y+dLcQidWsGsA3MAvvGYOBBQO2XEc3tswyqOVKdE6L/xKVXiSHIDmNi/OQIK7ZoPtGrosxzcvMSuUnwvHMwmx6O5BEFlI6/57XF0py1i+UNKuY3uFJJ7auF5eTzU+qPtQ71U6uBU2wSTnbqCkR5YclYMjOSh25nfCtFu1rwNXJf2L1L07klkNLRzMbUUuyt41lEieAyFPbVye9JdT9wHEAnygxM7ykqaSqX0dgaAhwOKUqRaeBz4aKB0hVr2f/gU2TdYmPo9kACmzVBcsMiVH3m6wnafS8lZcLfFxFyWdHaPAZotquoMBidTKIQ2yrWhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppnYF+HRPolEv9W9WSCRzVf9mtal27hwVWpXIFhLaUE=;
 b=u6uN+BJ8+6UQNGpifiaNuVwQV7KslU9n4jJiSE8TaiVASN6iih3xDo5ug1pkyzub8gwC+5goQWmMBrlPqQY/lEO9klAwpBS3RR8vbUXLcLsi1XLaYdWaA1tZXg+/0GNmKbli4TyYiBB5Sm6q4vlCRGzvsVDX2KDHiX65DkqfCas=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 00:50:08 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 00:50:08 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 1/3] btf_encoder: move btf_encoder__add_decl_tag()
Date: Tue, 11 Feb 2025 16:49:56 -0800
Message-ID: <20250212005003.1413091-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:c0::14) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3b3774-2234-4166-315a-08dd4aff3295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlUtFacY/Dz3CQupTaksIfoBMViYubWHm4pWKfLW1mqpk9SsKraFZ6NQXaSA?=
 =?us-ascii?Q?PO8ruGteY1n3KYGkMb5MvqHRXT/K7NCos20Q8wmfzxOjd7RQCfArBOGYW/QV?=
 =?us-ascii?Q?pI3n7lWLKKYShTPY6JI1veEtemxDByZ6pY/cjLj4z5YbwTH0ekIYG/LHZR7s?=
 =?us-ascii?Q?mLQk81o0hw+QSIUM8YQ2qPDm/l1IDJY0JvgDUWEO/J9TaGAiS1RBiW7rJw54?=
 =?us-ascii?Q?KWwNrV5xkc5nirtbbRG6kTIqcC1RcPu4QGrj6BzgNIAD0O2SfM1sMNe5H0Nq?=
 =?us-ascii?Q?9tGHXZw5aigvlMK86ypzipwGJ8O50Cg7XyuMcDxUSRz1qgUl7wR1InS46hsW?=
 =?us-ascii?Q?hi7NKHZPVUTor1pTp3szYuO/g+CqtNf87ocPnY9kqXd/3El2da/m0IkrBKmV?=
 =?us-ascii?Q?gNVE3yXXH0SkX0qhOcPaSUT/Vha8A6WhVqefvWSksUe2/UovBmIarDG1KRhE?=
 =?us-ascii?Q?1VjHBXpy/yKMh5eClSeuVpjm/EJD1ZjDVK/pDKiyrUQnuuRFWdHfROHlBWPg?=
 =?us-ascii?Q?zc0kMXVUFZCfzVflED4yFKECtOSxI6KwvB57/qnbSb8Ntq99aW8XbG6mW7XB?=
 =?us-ascii?Q?iZ3HH2InNi5X0mfzNCxKjZZDsV6Z28l+u5QYjO+AjHPFNrro1yhsFqT/d7pc?=
 =?us-ascii?Q?JOXHi6bD/vjTuTsK869ILpWyjELBeGBG3m/GFXjuyHJVDoaOxWv/TB4XZsZw?=
 =?us-ascii?Q?vrrCoWGVWCPm0sc08wk4Dhh1k6BuJjX9SEYbswgxzi5dV8b3tu5M5IXGK+TV?=
 =?us-ascii?Q?FzbyrCnJ8IKBYd6/uB/4O+dM/1kJiziBJ7qpau+VWJEDvfbyAn/Zd0TCCcik?=
 =?us-ascii?Q?BhaK6/b8VGZlKNKX8y8ZT41KIO3+k2L7J5Fjn2ksuotQynJY4a+a2dZ94F/j?=
 =?us-ascii?Q?/FTUgJDkm0+V0IUbL986i8GBV8nkbD1ugD4sv4ZtMNbR2i4giPpU3viSOvs0?=
 =?us-ascii?Q?oQtmD9ithUS5n0U/I7WKov1DipOiYc9nVVEEJ6HqlbPkNRePNVxFVQxFXFA1?=
 =?us-ascii?Q?DUexVRlzTxTayFl5QYhjcMp37R4to2EH2QjzvVqg2Mc6syefXIFUkaw/bqg6?=
 =?us-ascii?Q?r1qAvG24js/N2V7HYIYsCcKQZ4vKKxlAhnbCnZCFvlcnt1EmZ4N4+QrGO6YX?=
 =?us-ascii?Q?iP0VEaa5z4mjG50SXM3zG9ifRhRtcr3X2YH9+i08zVl48ws4/O1xJUNhSAeQ?=
 =?us-ascii?Q?o3hK/GHNS/e7ldso3gHRIOBgt7LHVHi3TjG2QFIfIvfrZBaH8MpmmkJQRQMF?=
 =?us-ascii?Q?im4Fin4yF9z9A1Rm11Zk1DFIJXviMkRnzR2XB+qOV5ncQCUI2/16cyUPp1Vl?=
 =?us-ascii?Q?tpaopsipZ75UdC6J2W3HKzdj5SS5Rhz0E4RxV2qRq+c6DBYYUtEDlmYY5fD8?=
 =?us-ascii?Q?Ss7Frejg4fK++z7AI7O1n0twAsY0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?csybTnofW4ZhVMmphjjrkfwl7QcV8HVtLGhinTnMulilAFIe7OaxfAGBs378?=
 =?us-ascii?Q?uZx7btz9X2IgSWcAe7AncKRDBU1SdCPvgilWwqkBMxW7hkQ27TzQ/bxsmjby?=
 =?us-ascii?Q?efmAyfKvFnaaA1NG+s56VW9WkdTGXr/HphmQNmkI7BuPa4w7ZKbk2qAoYMMC?=
 =?us-ascii?Q?RN9M1Mgf0pwDYlRdwv9KzWHnDQLN0LJ9O9flt06an0G3nZD/N2/LAmBiZhL2?=
 =?us-ascii?Q?e/FqnR320r74Zmp7f5XrScupPkRaEcizmWqPdp00KTVyP1zXLMFk0hCSwrz7?=
 =?us-ascii?Q?VQyWmziVREHL3J3N8SnjqvaLkyVS3hlqbW6BqEoN87IKDA39iX64lgxMrQJm?=
 =?us-ascii?Q?UnYBhdnYIroKpBVJgO2yo/2YN0Yh04jkHbBmQa9RZUuULzm+TA/tYsVgaDFv?=
 =?us-ascii?Q?pYJfcv/jw6AUGRfi9PaVu9LE+gonDOy2MU0BsqALixxB1nItvqW9qd9qgP6k?=
 =?us-ascii?Q?JWmXKeiLthfyj/Ls2mwe56+5yDHYczIKqSz2sDve20qyBPJo8MrYFCl2z0NM?=
 =?us-ascii?Q?tdFZzIIbB646HEYC6UI9H/G4ecHRUcCPv03qOp4OYO9w+FI76iSi8PB8Vgw4?=
 =?us-ascii?Q?etNGsWBQ+Mj/HZ/8cx2LNOEauQ5Ev+9xAZ5zbq+eFxAlhWcEcGKlXVddc3QL?=
 =?us-ascii?Q?DOiQcykhMJ10N6kklJfiEPY2FF+HOtIUKDg0l81XYRYQsVpK7wPDQ+LcGdMP?=
 =?us-ascii?Q?lA+tRloWdtwvMv/TmiMyAip2xVvkobC5m98VsyMHjC10w0PiO1pBzIoz82M5?=
 =?us-ascii?Q?3uC90bLitfxIb6pq+cmuwwkhbjt6wMGDyrcv48mxCsYuABeIiGD7NyLkmkkn?=
 =?us-ascii?Q?6j1onh4CWaQ4lQf6Ki9DVlzYZg/BNkBxAgzFDYhJx63itA9ZY0g3g+7dOD1W?=
 =?us-ascii?Q?K8lceRiLE4FISaGEtX3sQVfyKT+wWNQHZwZuY5tJyP+LZnCQ8A5KOhXzezvU?=
 =?us-ascii?Q?wyZcxKWZgBjTaxTMo1ZpSk9+Pg/g93mWVxpKRLGjdwPX6ZL57ZHzU8HiXRXt?=
 =?us-ascii?Q?t+rbB5iZMjaWyVeIL9utOeespbgbZWbCw/mavNeONgDwVEKGkhhs2zD8dTFS?=
 =?us-ascii?Q?i5EgB6Gy2Rza9QPvvkYkflfG/A7BsscnVmfxclpRXUqCU6fqt4aN6utVXSo6?=
 =?us-ascii?Q?sAQuQWYhEa3qyTACcHt0OFFacGH7SyM6RgUDPNBdK0muHVcDNih7YB2v03cC?=
 =?us-ascii?Q?s9lwJJUivL8AobGjbCQJQspXPx3A+NYBJqGR2+ljZsXuKZyQKaOCwogBlHK2?=
 =?us-ascii?Q?ySuuj8rPh5fuuTZMAHc1xIKfWHa+K+A6rN1qya1kE42ql0rpPrVgM9zBbQ6s?=
 =?us-ascii?Q?sJEzlq+fpm7Kb5evglkV0DZllmU+NQL7LveBg2yHnr1UxhS8Cssjcy3CH/1c?=
 =?us-ascii?Q?aq/Kncpvh3gPih5gaDXMLe2x5m5/M4EcxG2WmtzvnHrZLjJRwT0BeFAsvZXZ?=
 =?us-ascii?Q?4wAhijJ3p8pIvIJl9yBhIsHPf4hGqmx+8C+pag5HhZmvYNLtdD2JawpMPhUE?=
 =?us-ascii?Q?Db04KxQJHq6in67oQP5KzwnrYU6sqeE3+FiNjnmrsgvVBN7Q9s/Q0hOZBoQd?=
 =?us-ascii?Q?h5YdAMtzcK23rEBQkZk5rSo9s2ZJwun5ADt0cDSwN3r1AjXRWR17W30MsI9B?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3WN5SUZL/ZJq6X931KR7DsuB3rSnCaUhOLnARiqo3UOuKe3A5HNFtBSNjcyD7FPrvBm4j1+U4JdT7aSLjgj82FKlEcDTcfph4t6wIkT8GO2qopG5k/tkfbo2niArPFFflKfIzGTL1K5XKWcrBMFRwnUgn05TxAiJgfbJvZrHN7YL0YSDo9NUB0dJSky4gi1LwLi4sRKxTj83Q4rLQn8DPTUkRWwbQQPd5rLbxrbSjhE+jzcdoD0dwRVKLWrWr4D8ADEaedBCYG+F0zQlEt7rTIiNmxeoInlSM2LtmTYYYy6bMbGaFEtjHGeHxGyWynHd4t1HDj4eBW+LdzoHaJpUrBcyx2bVpsTgNk/zqnKIKRLNd0fmgqog2HW9VxMEHV6/YK5jrrqQU7JglfFrZJ5KM2u/eDlZHusIaux2fON0aT6cbZDPcLfzaOBd2bXB7Hp2w9d1cakstiyvRICiMWzuWm/aHERKuNUcdhaM72XfLSmVIyDjgAB5Ryt/oNasDWqGN5X8pzAxZYIFto9ZO6sjgj2ULs6XtSY4BNc18OwjYmtUxMn7DjICBALxusYlH+A667Fi9EAJjfytJpja313XvIjc+QaHuz7IMMD37AyMyuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3b3774-2234-4166-315a-08dd4aff3295
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 00:50:08.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap8ufq1aC+akc+yQVfxBV/XdjiX2cSZj90GmU75ok21cIMcZ5sH4uIzI9W3khU2CdErSGwq5dHaYt4Us4ZzNvXTK6DVSjT1usTky5hV275I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120005
X-Proofpoint-GUID: 5ElJzlh3FQPMpySZ4-w1U2fjS6747_6s
X-Proofpoint-ORIG-GUID: 5ElJzlh3FQPMpySZ4-w1U2fjS6747_6s

It will need to be above btf_encoder__add_datasec for upcoming changes.
No functional changes.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 511c1ea..6a1f5c2 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -827,6 +827,27 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
 	return id;
 }
 
+static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
+					 int component_idx)
+{
+	struct btf *btf = encoder->btf;
+	const struct btf_type *t;
+	int32_t id;
+
+	id = btf__add_decl_tag(btf, value, type, component_idx);
+	if (id > 0) {
+		t = btf__type_by_id(btf, id);
+		btf_encoder__log_type(encoder, t, false, true, "type_id=%u component_idx=%d",
+				      t->type, component_idx);
+	} else {
+		btf__log_err(btf, BTF_KIND_DECL_TAG, value, true, id,
+			     "component_idx=%d Error emitting BTF type",
+			     component_idx);
+	}
+
+	return id;
+}
+
 static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, size_t shndx,
 					    uint32_t type, uint32_t offset, uint32_t size)
 {
@@ -883,27 +904,6 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, size_t shnd
 	return id;
 }
 
-static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
-					 int component_idx)
-{
-	struct btf *btf = encoder->btf;
-	const struct btf_type *t;
-	int32_t id;
-
-	id = btf__add_decl_tag(btf, value, type, component_idx);
-	if (id > 0) {
-		t = btf__type_by_id(btf, id);
-		btf_encoder__log_type(encoder, t, false, true, "type_id=%u component_idx=%d",
-				      t->type, component_idx);
-	} else {
-		btf__log_err(btf, BTF_KIND_DECL_TAG, value, true, id,
-			     "component_idx=%d Error emitting BTF type",
-			     component_idx);
-	}
-
-	return id;
-}
-
 static void btf_encoder__log_func_skip(struct btf_encoder *encoder, struct elf_function *func,
 				       const char *fmt, ...)
 {
-- 
2.43.5

