Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565B86F06D
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566960; cv=fail; b=nUuDMPjAWmgEVbwpEDm1oPTXbwz1gFdIoB8uD7fBLhheQndI5y1tusv7JYpgrywv/+I+t1SEwc56i7NRHFXzL8MiTqd40plO+BLUIB6VsUWklYHXDR7d2h1a6/jFQcNCUae4Z8CaG1V8+EIfOYJLgXtrgQQUjlR2woOBe/Pl2x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566960; c=relaxed/simple;
	bh=x8fmoMoOHldHHUHvGVs/L22xzLSyqTU/DUygtic2e74=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SIclSZioa/uJ7C2HqYyahyXxvAizn1vjhWxIyxwZjokpVhhRiBMCxg4CV0FED3PU3uTSTOJ40S9SJtLc41W2LcxfzicTAcvgSQiPemuPMcx31JgqDhtLJkK1zoH5N4Y4WWco343SlvC1hf0N9e6SMozThu4huf5YMwx9QMJljxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+hz1SsW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+hz1SsW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732566959; x=1764102959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x8fmoMoOHldHHUHvGVs/L22xzLSyqTU/DUygtic2e74=;
  b=c+hz1SsWMyHYnqoKAVWa7SY6nkeaAFBydGHjkHRGUMvostad0vtgcFJA
   nzfQ3YID5j1Yxa30qWk6Ko9/08OQ5rpwT1wMsAQODpTNfRp3vV+mSH4u0
   ZL1A/0QhY4nkGiHZvARlj0Mo3YjQgz2DEz8bR6+RA4SRo0AyAnjf371uc
   9cdWG73ZJvtBq/zuT7pYDqsA9VRU7+xT6S1C3KV8e+WnrF78AQVz3yZZN
   em/dY9YDNdkJUwN5uXtLGH19nBkrdxF1ziIvRI2UTmMTF9FVJ+rhgoSmx
   jIu2sH8Ci2HOozcPnN5jyWTWKui2hZbkXc+GF9qX2EJBOuUWWqhqLsqjO
   Q==;
X-CSE-ConnectionGUID: eMqL//4PQCyRVzewmHJDSw==
X-CSE-MsgGUID: hY6AmQxaShCViB9C5NOseQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43194304"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43194304"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:35:58 -0800
X-CSE-ConnectionGUID: oXROrR0hTSO3Y5bXul/n3A==
X-CSE-MsgGUID: R1aoS8VSQL2wLIin/ie7bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="96308559"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 12:35:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 12:35:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 12:35:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 12:35:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVSRJVE39TN05x5yROeCrQeBE3FqVvurkgnujSHHld4GovffDyJbU50K1crBiK9flSMkeaFz12zaBdrymqX8Qmgo4qLqYmB/DbanIzAqH6tJOvKCknRbHxqNBNUFNPwzNbA/fIvIVOmv87CfvXu4Q0sX8q1Z6AOQRzrPSb18CHizdekV/GOrY3kHDTFxcaRSKCkCohdn6tKodCzYQRfdjHO35qdlq4q4Cs6vw3sM7ebR3mNr5d07cPdFyBH01fJmq/roc3eTi3QmPIcN1YzNRpfTBuvw1l5rm5BKw+77Mc0vNblaxaLum3nXzOHx+X9Zod1O5FJDOfyhEY+dwR4EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86omo8ue4aHjwgaigsK11ZMWl4vXFJRsz9QGravzv6o=;
 b=W1BUylxRZGakTedDE0/gxRmYGWNwkKjMK+zVo79fszQyvy7MhyS16Hx/vPNcBn2c/YgofK8+W76tEjgpkYtXAzOFl5SmUrvfksoSs+u5EQwKtXYpjztzXNRyxBx1fcSgvCqUVfAwGILgSXoMJpw4lG/NjnYf/1PEaivBKaJwETod3pPhQDZ/CWgcxJ83moftaZsyOMCMN8H85+YzUpbD13hBInbySOkJR1gr9E2HDxy5NlExy+6xnx/GUc9S9F38A0t+XT9o4CBfXrGbM9okEvysrRUHFtkwmceKiWFYovQ3bz7wanB8xIWq4ZG58VqUCWCn/Wn2Nh65Z8GGjJEXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by SA1PR11MB6920.namprd11.prod.outlook.com (2603:10b6:806:2bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 20:35:53 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 20:35:53 +0000
Date: Mon, 25 Nov 2024 14:30:53 -0600
From: Ben Olson <matthew.olson@intel.com>
To: <dwarves@vger.kernel.org>
CC: <alan.maguire@oracle.com>, <acme@kernel.org>,
	<brandon.kammerdiener@intel.com>
Subject: [PATCH dwarves v3] Respect CMAKE_INSTALL_LIBDIR
Message-ID: <Z0TefTqE9Xqx0Gz0@bolson-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To DS0PR11MB7444.namprd11.prod.outlook.com
 (2603:10b6:8:146::11)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|SA1PR11MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fb6c2a-fe91-4d0a-4c05-08dd0d90c1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+dGa/5r8OoJ+yOc7+li8PWZ9MAxtYP9iy7Evic3OvEypXuXKfOD52DD4BqGE?=
 =?us-ascii?Q?5xfcqAGawcfkTRPQGXEpR8HsZIno36lmdN7h7Ptv7Flcd4jDJSX5Q4BJWfIx?=
 =?us-ascii?Q?6RyXWUT7W5e5D2KTgy9d3/XhPcTi0Nywc3YJ9rp1ngrmwII7tXa6pQeSymv1?=
 =?us-ascii?Q?0vYj7wXfXfRGw2KXcYX6m0aStOVVFHWrEt4XQxSPW63cHIEtJpFM9KmBrj1D?=
 =?us-ascii?Q?FtpGjYXFiSTmuswCuXNCWnOrWkYeoLqSgrI1tIsSViptWdU9c1cKvzskrw+G?=
 =?us-ascii?Q?hhuQCWWoTDX9IC7CYwfk5VvQJlrBdlRXoR+zlTOkSvo8OKsyM/PrFWwOBLKm?=
 =?us-ascii?Q?pu3fxcBXARNoIjE35Hg/gD6xe3Pe1oe47obQPS/hSopUGX/Ru602Ba1TYJr7?=
 =?us-ascii?Q?rG4ifrVZ1qmnH09xlppkZsboXaTEh/oDx20D4QIbtWiOU1Ij0b7hb1JqKY+C?=
 =?us-ascii?Q?mN++thmjK1tZakAZLtmKE03o69l5dvBrQYJ4YT5Bod32A2kzubsZr69BXfgE?=
 =?us-ascii?Q?aDdrsrTVAIGV4lYZgz19jcgdO3CDT1w2+53+nG5AgdyIHCmYzbiBG2rJXyGq?=
 =?us-ascii?Q?KYX4XdwI/HYMTA7gpYaEuo8TYAv4bt2YEZ3LngvmNLZDHbJHxf2utlwCxibg?=
 =?us-ascii?Q?5HOPWiRsyeKl9xM5YQQOuyvoTBObGs0F5rT25phvlJUIUauPpdFVkiy6klQR?=
 =?us-ascii?Q?YGsepYxDS7WquFt42prElZr0l6AWjMDQail+bLteh2cEsibudso0mfhQ5f4F?=
 =?us-ascii?Q?veTkG/HWluOz5+w7wGVUOC9YpZYnpHT2iEBM+da08SQHiH45m2+b1fyzIP4r?=
 =?us-ascii?Q?u5Mya0Tq3D3RmSBNTO1OmeFwkLy+ez1DBKrgzo9opwEwFv+NdJSTe/RcGBED?=
 =?us-ascii?Q?OQvAUsj1eFH6BinUAesfTWeHHcWdePxpiZq7raHlC/Cv8nOsHXSf+yOl+QEm?=
 =?us-ascii?Q?5UbyD/gM5FW6hQayA/OZ/sqDtV+40gH8t2OMkh7VMkCWBgfxt26VYPHTiX3G?=
 =?us-ascii?Q?6d/oXkvCxMCpxp6RgU0yIvE3wVaDkLUxIuIyxpr3IkltQyoWqj/Z3FFK7Htg?=
 =?us-ascii?Q?nieKdl1ayVTfQmJD2sP2l/skYpnRSgpvHZuBsJC1+rG3F7nrW3yzKYrTb546?=
 =?us-ascii?Q?LEg8ujkBY1Anwymas4s4aZ9lQvTUB5pv8aEgVwpALjTQ9NU/IvtT+alDvJFi?=
 =?us-ascii?Q?sgNdPrTLwXgK2HIRoDCt9JJMHF0VuM0KWTtUY3T1p2lWZPccHjJ3JsMMTbZ2?=
 =?us-ascii?Q?7fJSia8RlaO1NMZV2BYIRG3XKiwgpqHYYAmjN4kGkGCjIdpSjifKCwaWlIQF?=
 =?us-ascii?Q?Q66Z4+P4Zv1N1ftB96nfnua3GaKPwFWsma+n8J0x9y4RsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?91TEcUd4nlnhZhMxY2aNDJqoWUFchXT51hwAp2w3G+HrhgaTKNSzcCN2Lq49?=
 =?us-ascii?Q?EjFL7Xdq409ci2VMtpJHOlu9UVUI0szOClwFNBS/bJYihmMatoyHQ21YNkz0?=
 =?us-ascii?Q?HD5zZBvOXx1ORbgxvVQqVFSadKdVOSzYOZTsu92bIJpHlPOKIjM2yZEhK67Z?=
 =?us-ascii?Q?uCN9Xj0v1Ygoc1L2VsXx1r35u217DcMySk7kX+/6M6j6L5W9FHzbvoIH3Da0?=
 =?us-ascii?Q?t+ZXNAQJj106wUDvKR6B98o9YVsiER9NF+b+oLoKmGWGnfDIiZOmnoOtVuSV?=
 =?us-ascii?Q?08twNCZbPENEsa1BSZEYmfhRZ4Hgs0jqdr7XZP4NzrjuQpZIJi1R+KW5CAmi?=
 =?us-ascii?Q?X07ivyMSHR/NazBBcrts9FWkRb4OezjJJC7FAR2IWgq8c5TtzftVucFqg0Nr?=
 =?us-ascii?Q?LqVNMi2uGiC5S9y/omW5G6QYZw4t02n9Si46kumIoZWKu5tv58c5CoK9h8Jp?=
 =?us-ascii?Q?UJzRJ3ur50L9ZxAHpQHB6yEe17E4oBWvs9eSXm1BU4a2fi5BHyXjszbRhJXq?=
 =?us-ascii?Q?S0MuSMrgkde+04yI5ryny8bEvqRMEisz0nwlWhLdSm9n/oh2/16a/mMb0uh4?=
 =?us-ascii?Q?Ib5BheHfzd7M1dQKqsEpQKMMn65E6PUji00jiPZk+8si3/+2rBQ2LvIMsgHH?=
 =?us-ascii?Q?Tz7RrxlPaW7vAzznuA1de12q3+ieJIphJfKfcI2jmEIWPmm9L+pqJdI9EmTn?=
 =?us-ascii?Q?sOtEO8bp+TfmQgn5tGR5/eaC23HYIw2B4BVv4t5dgwmwYM4g1lUhuZ+64++R?=
 =?us-ascii?Q?TDFx/Sjp7ab0vOxmZsytUuqAoc08x1UhibiqC+dQK33uimp17mpnlY3vMzYa?=
 =?us-ascii?Q?Xt4BJsRPcr1Il99ak9znq3QgYBE8/oeCvdL6tijGQWkeVfXD/eRoZjQhdwYu?=
 =?us-ascii?Q?vGaAczzNhB8xAeZxLPbZCBv8oYnB5UNXF3GZ2+lqxH6KKwv3H0EfcBh6wC/9?=
 =?us-ascii?Q?bllfPLTt7QuFuIOZoipF3RTLq9S5XR8GRD3RlyQUd9OSWOVrIeCr6qIzPsWA?=
 =?us-ascii?Q?k62X4Jikb+IMle67sVP2ffZuAvVdBDYpx7JNh3FYHOUJLBqysQnn+sjJaA7l?=
 =?us-ascii?Q?NdVQ0e1oSNzbG6n+imOdUEmfXII3bpjD5U46gwsNM5OjUEHyUL5PSBbnswf7?=
 =?us-ascii?Q?upeyjyd0FgMY787YBoD7jYJq28G3A7JPnUbkzCpOEpJwU/6t7pMsqHh+1oF/?=
 =?us-ascii?Q?ZLfFUEp6owpckslfQ6uuDLpj9pJDOpOuOJoq37xFadAFwaTWwnOalJlScqAK?=
 =?us-ascii?Q?jC6OymEPELuV4VKrxDRlkVVnQsnMKSJxxfrWcdR6R+sGmfx+AqnHE8Wr8ORH?=
 =?us-ascii?Q?LtY4ajuZFkhrvI0N4uNboF995ukR60SOuCXfdYghrAWKc+L5l6o6yOJfrKpX?=
 =?us-ascii?Q?ZQwEKLh/eP01JS2rbSMtO8l5Z+AjXvj/BUmOK8S67Dmcw/tMFz5NbcmsDKOO?=
 =?us-ascii?Q?sUk2+QOXy1P+oWeWfEp2aQ446TswVyhKKQmxBaKoJ1Huj8NAviUML5cW1I2e?=
 =?us-ascii?Q?zlDN9pTt+aKoM55lTOpBTUq4iXnOsB2/oGAIn6yfw7w1CVuQcmRAq+ssthob?=
 =?us-ascii?Q?z3IlvDevOy70GGWetRHNugM/WLL39ZJl4PzH/D3L6vtER5p9R/14QNGiMTO/?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fb6c2a-fe91-4d0a-4c05-08dd0d90c1ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 20:35:53.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBrWonVhTzPKRPgsW6ZTSkIRx4d0aOHkppKkAoX0ygsbj9iYRF3m/hzXurN1ZKFz13LcBadpI4n8P4xVKSTZkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6920
X-OriginatorOrg: intel.com

This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
and use either `lib` or `lib64` by default so that installations match the
conventional placement of libraries.
For example, it will now install `libdwarves.so` into `${PREFIX}/lib` or
`${PREFIX}/lib64`, depending on the distribution.

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Signed-off-by: Ben Olson <matthew.olson@intel.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
---

Changes in v3:
  - Added additional change in README
  
Changes in v2:
  - Included the proper built-in CMake module
  - Made commit message distro-agnostic


 CMakeLists.txt | 19 ++++++-------------
 README         |  5 ++---
 2 files changed, 8 insertions(+), 16 deletions(-)

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
index f9aeef7..e9f860a 100644
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
@@ -12,7 +11,7 @@ cmake Options:
     Use -DBUILD_SHARED_LIBS=OFF while invoking cmake to create STATIC libraries
     and link applications to it.
 
-    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
+    Ex. cmake -DBUILD_SHARED_LIBS=OFF ..
 
   -DCMAKE_INSTALL_PREFIX
     Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
-- 
2.47.0
