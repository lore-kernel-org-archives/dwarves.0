Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E228689
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550222; cv=fail; b=WsCRIv1FocHyCjToXkQOkIRgXKoKsCk2DhxNrs2xTuzFm0dTZBqbp9/jZe+AtjCnVdMykk8+9WfDZkl8KkglApu3LMbHXi80YSp6//HMLwRdLJa2h1IkG/hTNVBb6i7pgKifH+SevUIuncSOCtGKhsKoiFbKNoNL63ae1oRYyzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550222; c=relaxed/simple;
	bh=oahVy/Z4emcE7e0joubo8vDZ/0guJvK+lVkj4T2nIQg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=mX76wVcveKhwQJk/OHs4zb1SFv2TJWMih6XpM0YaV3yPaeUlH2jmzc0ynnn4N4UHM5VqSFoqy9jZHqTRE3+SQS2df5a1WaopE/70MLKCvl6PrvcAJLQ/4Zj7pId39zkILUZYxpG9H9/IhEkKzZhVZxwdy2NyCl7FhugUgbkS9x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Na546+T3; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Na546+T3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732550221; x=1764086221;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oahVy/Z4emcE7e0joubo8vDZ/0guJvK+lVkj4T2nIQg=;
  b=Na546+T3UlIPRfcakU+vl/TpoTz3cWg8/eHRPa+px+cMBxqx/fYGXdem
   Jn6lOp41aNXEQBrCXl7RfMOyNn62+Jzt38PfR5ziH/vOyrCd2QwFsfSkv
   rM7Xe1PbN/S5/y8KwjdOQ4ozH8t6RTrthOPZ8H0ile8cVWpXzeVd2dvXh
   rVr5kPdoY2daWMp4B7EdO/c60uo1Rk/IiiSiIIzNV4TfLF5JQLO3BS0IB
   1+KgGc7Mw8pzcpKYOjxIXUBHSrFXSMNDcfzpw84uf50bP5p3akzZ7oMcn
   14S5xXcBMJz9Rrx8Yfb935dgin/xJ3H7LPWH9wyBFS5Z1ZRiEElfo9Nww
   g==;
X-CSE-ConnectionGUID: L437r5OHQCWiagVHHffcvA==
X-CSE-MsgGUID: Qww0TQ4EQDCj97U9fRveUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32723455"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32723455"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 07:57:01 -0800
X-CSE-ConnectionGUID: h7RIzvYdRh+Do55zX9ucpg==
X-CSE-MsgGUID: NxM2cj2lTtClsCbFPhz/Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="122249462"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 07:57:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 07:56:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 07:56:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 07:56:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViAlsJ0c9KOwp+rRmFz56GDevUQnDnJgy8F03umPbnSjMWikeKUUnTujUyMNmrPYGU+1+AKiMKKACjGwZy52xKfxQN6pMEW+2r9Ccs90lBxvSP29/jmk/YOLjGCrjT7SG9og1TApTcBZTaHXBlrTN9dnFAgnX8RFkufVvbadiRTcYYUugJcaGTZ9+CwaFC7TvLtBhbtCF6KGM3zhPjRyrWi/m95meCjrmFMU+QHam/HSII6p9aq4Qkd7WYy/I+OUXc7Yb3/Ca9tghvoHehtGJz3eLo9vT4wfrStXz6KjbaGGDNPikbBbB1SgdzeKu5gxR/8Yci26b5Bxn+quNGvmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fq9JvwqTTDgsLatiWABBmsfhqBE0Hyz0WQpbnaiHOg=;
 b=lZVhdFlvnVEtOyPINSICh46QlXC7jJj+APJ7uBOkCQ7LMZXFtcV0d4pFZsvWUwg/RhLoUppQWv2xdD+LH1y8b3H9SSSPZJ1Mff6Qgfw8CsZ7zPctADNhpD/uP8ucJvwGzrkzVZfKKwg5VHNFtP5haSiIJwqVRObzYO5kS2Kf7ABOC95kNe/4UMXzCLYdHmHZbXglMPoFt8NcRD24pDl20U6bwBuuxMGGk5jM20wOG+7HeN5rLN7oZI7dAxBBGdhXrHMkWzKTuq2SZiTfkLMIJX6oOTsDZf0wtB+NNZGyBenkZxClOXpKqdn16QJEXSDwtNapl3cjr0U+A7rbCXHFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 15:56:57 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:56:57 +0000
Date: Mon, 25 Nov 2024 09:51:51 -0600
From: Ben Olson <matthew.olson@intel.com>
To: <dwarves@vger.kernel.org>
CC: <alan.maguire@oracle.com>, <acme@kernel.org>
Subject: [PATCH dwarves] Respect CMAKE_INSTALL_LIBDIR
Message-ID: <Z0SdF3u92HMAu96S@bolson-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To PH0PR11MB7446.namprd11.prod.outlook.com
 (2603:10b6:510:26d::5)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|SA1PR11MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: c5944f65-bfab-40b6-a58b-08dd0d69c9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/fMONODSpwlut+6vAor3IvVQtc3QZ5xQ3MUgggI1+TkdcukpjPtKi6sQyfR2?=
 =?us-ascii?Q?uAVAbMxOACY1BCyfF7jhOxnpX32lnbqrRXUXWjJJBRVe5vFsS9K8iX7pO6E+?=
 =?us-ascii?Q?SSviI0dORkDbjACaJ1eVvdRsZ6Mu/unryWf2Vrgk0CRvDrqux7ku96iMaxxw?=
 =?us-ascii?Q?UrP/AA9cMaPNO0aFLB6whU0MjEKDS35BpXGwlyXi2IYCn7sk1cbFQziZAR7j?=
 =?us-ascii?Q?i4/Ph4axKsKWYkquu58PAcAbNky2ap2pn+YTwBR6wha/foWab62+gheB0SSO?=
 =?us-ascii?Q?3bDcRzEEI/YG3ozI/mwLRrE3PoKIASnKovtYIux9r4dEeWXBAm7+kL2VFBv5?=
 =?us-ascii?Q?XqQ0kdtdu91aZ0vSszSUTAqE+58hwkC6ld62LiqM6B0ZOMGXA3B6HsDP8FyQ?=
 =?us-ascii?Q?z19yO3+eBIQkd+ayNR6vspjSnotNPKr9fSMawKL2GbU8O+RVlVq5RXJ4DN2x?=
 =?us-ascii?Q?3AeX3ycMKKior1Rmxe9nHtTBdVmBxVihyxKYPNsitMomk7URIEPzgSgk2aMx?=
 =?us-ascii?Q?dg1+q72AMBgcGLa5Nve79abRruD58/I6RZcHwAGQE7Y1Q4QzMBceYhkwrtPA?=
 =?us-ascii?Q?m1zrkCy8hXJvWI5nRoPJmcWYUEplwsH2i7LriNs44YpdPI2xZwbsjmAlRd+W?=
 =?us-ascii?Q?hsA+LTfEIs4XQMaFnzC6oj176gDwy1p2oMytC9cWZFvXQxR6EQc0pXar+nyL?=
 =?us-ascii?Q?E7bqV6mrVHc1arVov7TbEsOhAIbIKktZdkGppMfZ8065MyZqd6Zx1GXuvH8S?=
 =?us-ascii?Q?Aut3xjz8c4Pco8uHXrZH29tFdEUjOe89Zy3Vr2mAxNxWYIqis/pFGAhSLNBu?=
 =?us-ascii?Q?sgsXpB6GvsNv4ej4Rzi6b4wvQbY8Q/70s/Xb2nVHnbBrtxvrqMinycahtwQt?=
 =?us-ascii?Q?yAmKAvWu9UNiAadqO8gLqQvjnTeZSZ+tRfVCD/erIT8PxNr1Hjg4jIeY6a58?=
 =?us-ascii?Q?8buWha4UwPxsRv/eZTKEhdskLkvbaeI5dRx6n3TKRy0GgrdTSoO3Q4n+RdnX?=
 =?us-ascii?Q?pAZJ8sVibgz+Eu9yA1LO4CI4VEENbf1nykdSx6/dD6IkJbxlAg55f7KpnXJi?=
 =?us-ascii?Q?0apZtRykIMkLsqQ6gdVAmzkyLnGJ/a8PbJV/02Ca99S2BzaQPZZsq32LYMlU?=
 =?us-ascii?Q?hFmjT+r6fcsfOuslbIwDOqxfDhCyU5F1AHhxLv8qTGvnW5OR/v8sJZ0xOBFd?=
 =?us-ascii?Q?9szD42JcC0I4AlAAhth15Bxb+8CAT3S56ugCH+PMX61rzaFKpaF0UoFjUmGC?=
 =?us-ascii?Q?PnxY8aizXWzDQlnL620H6lPDlybZB+B6I/22C4iS8BFl12WOcHDO8vKwHUSP?=
 =?us-ascii?Q?fPph5KEP/NdZ5lOGL6zPWKpH9TcRx1j7MX0BzZskYSKC8yrMO4gqGDPX+C2N?=
 =?us-ascii?Q?sXs32Go=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L4FCXif7GrrayvyoI3nWbLF0Ku+ENDdL5lIhB42IBNVxVpdC3VA5iyV0QbuD?=
 =?us-ascii?Q?G61AimVtpOKspPjFZSZTFnaE1uKB7P4j+x+MFaJ3m151ZP2hGZMTbC7lY6xJ?=
 =?us-ascii?Q?K+2pBHVXNR8jsOta8H8FYBz6I7nv75YvJdWiJGUxa5hzEPxCSt7a/oi5JWl5?=
 =?us-ascii?Q?naIkppKsQtOkHeY298XTPE6BTGjGf8ZLBZiTA44tc3OjdRahOSLLtqY13H/8?=
 =?us-ascii?Q?2m3g8BxVOXI0JGGIoTRylEgkaDMUYt9xRWX7Gdw48Mhg7vGZw0DH328DPnDw?=
 =?us-ascii?Q?xn5fgbs/Ge751A9mPUyBKD4dq0gKR/8VDmk6HfOBPQG55lnndh/s7mh2r1aQ?=
 =?us-ascii?Q?NVvakbIhpp+1L0y55wBP8ljRtmh75z0ABgIqkyvUVvhz8e64uzUktpywBF0X?=
 =?us-ascii?Q?WH94iORNXYJw8Mw0O6+AIwguIn5YlAYe9UaLJVUr+WHTKyMddhyuzaqQ5k2o?=
 =?us-ascii?Q?V1dPehq2XOh6KHlZCpsq/gMR8iUxd6A6C6BLi6oBfGIOA/o0VkfAKzeGg/IY?=
 =?us-ascii?Q?DYIfunnEPTaHE/N3lnbJFu2kmtZ1a0uek7AYMwk9fOsQNzeD+Oki0RkgTnRv?=
 =?us-ascii?Q?8G20lUlIWPJkqduutUnTqfWWzkqU6mrR/vIx8nsZz/0mYtU6sux0Di1+0/Xd?=
 =?us-ascii?Q?g7O/x51Sm2Buwi+wcIN2eQLhFEdSEmqh5P9CgIXYeciGFenIMl6MwTRl1sMs?=
 =?us-ascii?Q?0CjgYYQ5sk56aH4Y+oH8Axzktzl5/jcSgpzGoIvZbgDT+xW8dNtCQqLWHH7+?=
 =?us-ascii?Q?zYoIsMydhFbJMSZBzpxv2BSNag/Rl0GHs9ITrWOq/6K2WcN1HO+TG4CmYB/W?=
 =?us-ascii?Q?5Onw1yqLb9iDCMnd7ufHYb2BJmupzPFikLtbJSFLs6wIRn/Y7o4DAJBYlEnK?=
 =?us-ascii?Q?i1Picl9wLDw2bcJ9f8D9g7dCsALZv+yQsocyepliAKGKIU8xQc1hq4iJfZd4?=
 =?us-ascii?Q?Dkkn1jDaarxkDSQiSqBP/iIEfhJkMflBJzXj8EAXR3g7QoQiutoaj8f7Xl5j?=
 =?us-ascii?Q?FyUk584jwuVTh7NfTDdptcA8BSRosRbnODu6WbhF5VvFJ2lNE8fc/pOI2ZK9?=
 =?us-ascii?Q?ZPFTfClh3XB4o1r2qFrca3OqFFdu65g4y8jm4/ETIDj6G+YkHpHWMVz2jfFp?=
 =?us-ascii?Q?NAbNd5rDWHqXAz0POG/O4RTNuGkn7bwWluWpWmSTuJP9+SZSVBjn8fhFVYrW?=
 =?us-ascii?Q?LZ2gZ7vbK0dZvyskBHeqKUvS/cVM4RT+4lD2xMHMcWsRlybwDr3aYik1KNem?=
 =?us-ascii?Q?sbM04ID8YfH7YJ0qUxnawp/2koCC06I0LaObaU7c24+N+nuztGBAOMyxHaf9?=
 =?us-ascii?Q?uKY8pYpsjA3H/3iFQ7PzmTUrVSHZlJvdjEu5rLwD0z9pJ0eyJUCd/yUX6L91?=
 =?us-ascii?Q?/o+SqBuoz3LPxJDXewIEtZwU3V7NedXsjAsDA/Q4K8/xtDHdVDZyE6IZjvQS?=
 =?us-ascii?Q?RDZnDfxvhfzMxiL3XAvFeyc8lM7MZEz0DNQ05glGAhm0bJdUzsde3DtQ45TF?=
 =?us-ascii?Q?jaFbICoD0ShgfP8gw1kopjrTSxESpVoYTYrrELrPqsF2k068Ts+BMtcOmLNY?=
 =?us-ascii?Q?rXJIRYpOick80rziLgonamYbvhhCdkMiO1m19Y1FWslPLCBrPlgM/jKS+3uy?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5944f65-bfab-40b6-a58b-08dd0d69c9c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7446.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:56:57.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyD1RhXdqpOo3wRY6lI3DHGm6yMWy0AsMsWIRNrmiqUsrUY0ocwSVoRS7xGcHMOkPEYpRiCAUKW8Tlz4QwPY7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
X-OriginatorOrg: intel.com

This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
and use `lib` by default so that installations match the conventional placement
of libraries. For example, it will now install `libdwarves.so` into
 `/usr/local/lib` instead of `/usr/local` directly.

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Signed-off-by: Ben Olson <matthew.olson@intel.com>
---

This patch addresses this issue: https://github.com/acmel/dwarves/issues/48

 CMakeLists.txt | 17 ++++-------------
 README         |  3 +--
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8ca1bf2..b2c8057 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -21,18 +21,7 @@ else()
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
+set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
 
 # where to look first for cmake modules,
 # before ${CMAKE_ROOT}/Modules/ is checked
@@ -84,7 +73,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
 	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
 endif()
 
-_set_fancy(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${__LIB}" "libdir")
+if (NOT DEFINED LIB_INSTALL_DIR)
+    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
+endif()
 
 # libbpf uses reallocarray, which is not available in all versions of glibc
 # libbpf's include/tools/libc_compat.h provides implementation, but needs
diff --git a/README b/README
index f9aeef7..0627872 100644
--- a/README
+++ b/README
@@ -3,8 +3,7 @@ Build instructions:
 1. install cmake
 2. mkdir build
 3. cd build
-4. cmake -D__LIB=lib ..
-5. make install
+4. make install
 
 cmake Options:
   -DBUILD_SHARED_LIBS
-- 
2.47.0
