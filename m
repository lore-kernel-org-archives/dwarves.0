Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE419066E
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570830; cv=fail; b=ayPlrcrVs+z4FAwxQGN0Gjo/J30d6boSvl7I0bdZuzTVhd+YmMgrEGpt68Dn2ea/H2kA0iGM9VfiE9ISW9Uy+G2OchM+jGy5rNaEkgIKwLpMRGhXwnWQS/aO9gg+ohJXoiEGkgiqcfQsQujtpNKnjbYepxHEhzjv9abieMrcr78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570830; c=relaxed/simple;
	bh=QLOXOYFWtUK6e+xSnCj+k5mtCOeX6P3NxYXtC3ICViY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZMh8OVTvY8EO7JScjz3qSqtpy21oRgmOF7QelQ54/nZ5KE7R0JZKKcDz7NzTJzDRlDCwEh2gd5QhMdV2oUc7KJ7PPJn5QLf19BZ+Ejwf3EVzCn3nePbp7iaJU2Z/b0Q6mENe5LbtEQPQKWQLRFsB8mnNxmp0UWzeTyLm7dOrAjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmYnvx5I; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmYnvx5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732570829; x=1764106829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QLOXOYFWtUK6e+xSnCj+k5mtCOeX6P3NxYXtC3ICViY=;
  b=AmYnvx5IvpBjyBndmpTy7hKeIDX9blnHX0iqF8XGRTS6ISQDEUxqg/Kb
   BHGMzbWShXDf/22DBvGUF3YZsn00mbWfu55y0gigs2KpQL2pV1mSgNWwM
   +hkkko7a/Ka5CduiNoqiK+jWWjkcPI/esNGJuWbOXLwjpV+L4LImK/4x4
   HbDzecx45aB6Tf/YpAAnxmEuHtcTlDvRMPkTOBmMVPQVElRYcEvlZYXCh
   vaoQouJyk3OyoT8MBpm+ZzVLKgHrV8fOeFhxfbY8KzaB0covEiMUEKjWf
   gvRk2uK+4JCoff8+PTlOJC8c7BiTwEcVI8JCOvF6CRoUe1xzYPb/ZEu6L
   g==;
X-CSE-ConnectionGUID: D/d0tIHCSQS17XpycZKfVw==
X-CSE-MsgGUID: I8H0haiiQb2zATSroZPZtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43321402"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43321402"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 13:40:28 -0800
X-CSE-ConnectionGUID: 269LzAy6TqOauTbgnCDITg==
X-CSE-MsgGUID: 8gPFvymtQyaR8PdUP4rB9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="92212978"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 13:40:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 13:40:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 13:40:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 13:40:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8BGRi2oGCX9nPF94/rf3EmuUdA/XibzcYYeCAWQ6W10z20S/6hlxqpbhGPbNmUgxUUxjGss5Rk7jzyhroBkw2d42JdfZvO5XiVOnyJlL78ROBjLwdfXvdktLjUE+jYvbqNGeCip7D3jzOYIdvfMjo6kdS9Jh7T4fn+1k4H7i/JEAFTkogYkTlmHAyuCBedqkH+8vDIyyirKxIJ6A5VJxOoo/DzKCRtaoxJV9xiUgNYYH3dJ1FebYWfxKLHOJkTp5dbgQzE4nn012lBW4LI1TdJYPmYPy5bq/bMwZpawBH2XBltmXLBZ71rolAhjgXCeNfrCfOKGdXzOIr/Z7g7KhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2k8ao4DPnDqLzLYBeC9HC7oa8d9QboXAOEJtABSy7Q=;
 b=G7703Tn/GbJHXoN/HusUjEIy07aEOGmgDMhwLZ6LelNR4bmDD4+zOm66FQfy+jH0aAU3Fqfg1Bl/55V9FkKkf3Tkhv5aKUt9BmzSAe4Ab/tPrOwTV4j92yoosWRWAZgvBV/KSHBgmjIZdQzzq1lHymXt8Brnoc2sx75hLCrmlyTnlWAtrbQCP1i3Yt+e0SCqhLDC+KKJfpBZpI2AwDlHuqYfDXEFRHt38QTM3C6tclxGvCGDpgwHqdfH3vFFlXoyqFo+VO9O1wy+nmfhN5RsNYQqvX+QOGZ53q5lktJBYyJbsfnex+wrYe3GnV2ZPUwjHHd0SLvcOIJu+EkEW1HrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by CYXPR11MB8729.namprd11.prod.outlook.com (2603:10b6:930:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 21:40:25 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 21:40:25 +0000
Date: Mon, 25 Nov 2024 15:35:25 -0600
From: Ben Olson <matthew.olson@intel.com>
To: <dwarves@vger.kernel.org>
CC: <alan.maguire@oracle.com>, <acme@kernel.org>,
	<brandon.kammerdiener@intel.com>
Subject: [PATCH dwarves v4] Respect CMAKE_INSTALL_LIBDIR
Message-ID: <Z0TtnS-0iXq1Bc-0@bolson-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To DS0PR11MB7444.namprd11.prod.outlook.com
 (2603:10b6:8:146::11)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|CYXPR11MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e38528-fa44-48b6-ddd0-08dd0d99c57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LSQVJcyljqRl3xYMyypWimJ7ET6f5MZUyPCqN7pkjYCr37WAtGvu8QXZ8WuO?=
 =?us-ascii?Q?GrE81xVmeDRkS7Hmg+BIYm1gnEWvqQe72Zu+Gu9C4KfEcjh9ad1dqvC9iOaF?=
 =?us-ascii?Q?xyb5QPXku85rhUP+2DrDpsZYZYSeDZePmezd4he9oqsNssDEFlV2VgodMr+i?=
 =?us-ascii?Q?Ag4WtO74T2gMXZRLU1QFPBzWI1AECEkuSyOT8QOqZJ63iex6vWhczX2koR9K?=
 =?us-ascii?Q?JwAyIrxsZRR1+LjMwAXQDhWLfiIOl9Dd1oG+OylhBSj++fVmPNBF5kmOY7DQ?=
 =?us-ascii?Q?vjShSKF5IPSh3/PNVxKZWxbq6wu0m9H1OcZSoUOgGAnDUv84anmUcmQDRVZz?=
 =?us-ascii?Q?OyZirqp+YD6zZwhjDWb+gH09YqEQQ957QKrHV0uUAPuuySjbIwGhKfIAti6V?=
 =?us-ascii?Q?WBO5TA8oP6u2s6LR7nN9uDmuEEMDxSfANH2UqTE+THir+BUE20rD0Nz8U3bP?=
 =?us-ascii?Q?CbA6m6egjkD+5Vvw3tfgAn0d1V68o+qS1Xf8i91DXJb/YNI/nnlRZ/9173Ng?=
 =?us-ascii?Q?Xz6PEon18SD2aUY7w/E1kObzk69ompA3m9C5W44l1+Q56/gTEa8gVHRaWB/L?=
 =?us-ascii?Q?39ROy3+mYzZX32zQ2cGkoP23mxdk2flzBvWhNgRLVwiGsC4seWTbIuY0CJsl?=
 =?us-ascii?Q?FE7tfppCnPm/a+GhRcdMhntko6YIukpT50EmrClEf4EutlvNH7qkf7qM80+M?=
 =?us-ascii?Q?1knJsN068agjbPmlYnVbTO6GrVjv2j4ns7R2ZfSx0IFvC24FaAUsnSfhrhtO?=
 =?us-ascii?Q?ODLwLvYdBREGl/exCP8Fvhklt8WPp68AJgfL/2keVGIxPY1UD5VEIHqUIuHX?=
 =?us-ascii?Q?bpnfsU0X7J/6x/ty4AjwVMXOntHLhw4ln9I6Wh4tBwiwKcIOblcNM/l4UTTM?=
 =?us-ascii?Q?FPTZTWfUf9D7cBuM56xBTKeuur7Pqfr23rEBNWisXnqpzQ0ARInR8Vb1vfNh?=
 =?us-ascii?Q?jka9kF66Rrbo/0qAwdrE7asDWySWGfGjsaDFnjajh2V6xpN+ElJugEcIG8qQ?=
 =?us-ascii?Q?7rChhzo2NY4xriePuRp71gJF4N7Mj5K8WEJC1yawJvoA+W16Sn+YAGCm/xZG?=
 =?us-ascii?Q?Cf284ry+xtTW1wko9beyYdZDaXmmblXh0cTowXJbeP66/iVTKFGtCHtkdET0?=
 =?us-ascii?Q?/oArlxbAN0iYX53BM0be5AOjL6XIamkTCXzfJZSZ5KU05Hq+yYWBCfl5orb2?=
 =?us-ascii?Q?VqdofyUZ3vOgWSdHE+PkZ2FoXpmQM5LA1k1hPi1lnyDeSGGTJX+OXdN1ohkr?=
 =?us-ascii?Q?mcmQAy8Lkp5LlSKs9gOnXnM72xa1xobSG7C0poUh3ZLwEgYLw8eoqH197Qcp?=
 =?us-ascii?Q?CKlHI693SBPYWYLEXyRa7MdQCMbdcpbnb5rGzebzcnVtpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CNJcWhtMM0vTQ3xiq21fsPthQ1+lXcOxYWr77TZFlIdCY5bpJ2toEQGd0f2h?=
 =?us-ascii?Q?BsSAguzqPFxeqVGSWQa2aFv8icG27Z+l8dzIi6RgOB+tS737Wf9aRKraBRxF?=
 =?us-ascii?Q?A2ODsRyb3aRwoT6vyiURYFf8JDPhHiXiznwHLbkF1K8VvRlwAY0BcbNA9Kgp?=
 =?us-ascii?Q?8GW47m9akloesgdDEVKufjmv+jaXxsk4qgQkAWMR4mV97FP3zV6v4OdlbTaL?=
 =?us-ascii?Q?8ZLiBb7AXr7Odqr0D+lQrU7vnn1pSoUtHDz3D0hZfWWkcylOzLU5Yu1bE8ZI?=
 =?us-ascii?Q?z9LJKiM/fAOuZuieWaJmRoJKegVd283z+Zhnk5M5HR1xeUK5n6x3i6CmMU6T?=
 =?us-ascii?Q?4mOE0yaTCPHkShScuvGxpYW1SwODnHFqLpbGpR+V4+7+aFSkpVsBa+xf+IwH?=
 =?us-ascii?Q?T9xCNU1EVnqBWDD85UpRPZvBkFtQrVXs2aDQvy4LqXU2MI0o3h3F/VUEde0Q?=
 =?us-ascii?Q?4Kpo8gR1PxV1CPOJKN6Q3hXgMfwyvVRIgOZu/oVPestdL1Cg5xI4s+4yz1r2?=
 =?us-ascii?Q?ZUfgOLEfUp/xZDA5dp+AJm8mAj0LMdUcBqvZvHUWGTDBjgSKx/do1icNpZTk?=
 =?us-ascii?Q?FrzxssulG/Rj1VqZuFPfNb4Ue1E9Adq81zFqwGwIpeGzGM7Ba6ejSeqnWmrd?=
 =?us-ascii?Q?oMOX5v7jgYXeS87iMKy0IynBYh9gSv77zLSnqyCB6WigmaLOUozV3agHI4Ao?=
 =?us-ascii?Q?M4Vw1Jq+DHhOC/8FUTPbt69uRutbnkCXQrqxLsOn2+/zGWsbAUE9y4IwyliB?=
 =?us-ascii?Q?ey8dK2K698yNSMANBdW4jPSXtlY3L4DqLqw32jNG7VIS1E0axo8Jgjw5ayTZ?=
 =?us-ascii?Q?NsIRxZVPKtQS4t6913nMwqEUe2iEV8FqSJrsr1PMBxTwOvqWRBxu/cYwUSrn?=
 =?us-ascii?Q?Y3xyp7IDWf/BJk2IFOZi9haJCLpMjSH8bSbWeb2Za5P7vkjOzg0nYKsEcP5e?=
 =?us-ascii?Q?+i4v/stWNygjjJqGqGhX3i5BlTuoQFsS+73ZpJb9FxNsA61P+O2YcO+wMNvE?=
 =?us-ascii?Q?tFpo+gCH//rtcpvJMagq+1zY+nQVD13qbrtwg5rbYDhLFsfHvw/FugNyCamv?=
 =?us-ascii?Q?yHIP4l36t7ynDbSYdXPw90QBQalGrApkvHziYfCnBsxgJg7n5rmpwdhV0csZ?=
 =?us-ascii?Q?2DiUUYvAYSmwbmOz7zovsnFgCCk9ddqQLBDl7cm44sU2qNbAA/q4ierzcBsO?=
 =?us-ascii?Q?1x5Xcx7BrvT3n7HrtY2D/1SR92O2UZj2/j3RguT5ZEn9RkkkXYFizTeN7ULC?=
 =?us-ascii?Q?bafenfEHe5y11pU4hHz4f5I3Xq4IsYU9nW1WXGKXv15V1321fEGW3mdU/JWK?=
 =?us-ascii?Q?zG1jxJA4n4sC10fZQO5Gje/nSccGY15WlETAfIa9IepmUiR3ZmZO+4APPmkx?=
 =?us-ascii?Q?AiOUW0Wph44g0TiAVzXatHdfvXrmOM1uYQgUmalXbNkbupFQXLvB8AqbDwpo?=
 =?us-ascii?Q?o2FD5WvLvE3oU7XJ0pqJY5x8GP6d8NCfeWVb8b3ArkBv8g62qaCaSujTfB3B?=
 =?us-ascii?Q?CYQXvVqATWg0ZcP34zGn9muUhIEj/ilX330Ox3+fYKEGxlWXMwlSQknFqk2E?=
 =?us-ascii?Q?D3fXW+XkMOYGYSOiQGopVfAZfYPSmvnMcUld+QabVlOjUAluz0cgV7eOPjQG?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e38528-fa44-48b6-ddd0-08dd0d99c57a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 21:40:25.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSOmsDO0diVo9g1ZVPcy6h0nZ06kFLeFzBK8eKP6vDVQqIlOHlAWOrTYFXRbg9EnOzcHeWkBAJf+/EePVpp+8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8729
X-OriginatorOrg: intel.com

This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
and use either `lib` or `lib64` by default so that installations match the
conventional placement of libraries.
For example, it will now install `libdwarves.so` into `${PREFIX}/lib` or
`${PREFIX}/lib64`, depending on the distribution.

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Signed-off-by: Ben Olson <matthew.olson@intel.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
---
 CMakeLists.txt | 19 ++++++-------------
 README         |  4 ++--
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8ca1bf2..1d0dadf 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -21,18 +21,9 @@ else()
 	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
 endif()
 
-# Try to parse this later, Helio just showed me a KDE4 example to support
-# x86-64 builds.
-# the following are directories where stuff will be installed to
-set(__LIB "" CACHE STRING "Define suffix of directory name (32/64)" )
-
-macro(_set_fancy _var _value _comment)
-	if (NOT DEFINED ${_var})
-		set(${_var} ${_value})
-	else (NOT DEFINED ${_var})
-		set(${_var} "${${_var}}" CACHE PATH "${_comment}")
-	endif (NOT DEFINED ${_var})
-endmacro(_set_fancy)
+# Use the standard library installation directory
+include(GNUInstallDirs)
+set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
 
 # where to look first for cmake modules,
 # before ${CMAKE_ROOT}/Modules/ is checked
@@ -84,7 +75,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
 	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
 endif()
 
-_set_fancy(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${__LIB}" "libdir")
+if (NOT DEFINED LIB_INSTALL_DIR)
+    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
+endif()
 
 # libbpf uses reallocarray, which is not available in all versions of glibc
 # libbpf's include/tools/libc_compat.h provides implementation, but needs
diff --git a/README b/README
index f9aeef7..7ee3b87 100644
--- a/README
+++ b/README
@@ -3,7 +3,7 @@ Build instructions:
 1. install cmake
 2. mkdir build
 3. cd build
-4. cmake -D__LIB=lib ..
+4. cmake ..
 5. make install
 
 cmake Options:
@@ -12,7 +12,7 @@ cmake Options:
     Use -DBUILD_SHARED_LIBS=OFF while invoking cmake to create STATIC libraries
     and link applications to it.
 
-    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
+    Ex. cmake -DBUILD_SHARED_LIBS=OFF ..
 
   -DCMAKE_INSTALL_PREFIX
     Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
-- 
2.47.0
