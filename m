Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C32500CC
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560756; cv=fail; b=RnzXyqG4KEr5caAFDp3vdhDOGf4NkgEHfuDrD/Rk0CWEg8kD99UhbecwN4zLGinO6hEw1ZxOMIa0Z6aUpOVqL5Yf7fYdWnIV/mocqfHwnTLMMvL9l9wMenyGWYlSdcd15piYJJZRK6uPhtOw34X7p/DWDm2ka6+aLbFN/d+ym0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560756; c=relaxed/simple;
	bh=PypqM48wHNxoRfT/XSjeM06GEiTTt2qozPFTer6vebk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gLGzWBozgSucJBwVr0ND9hV5nRFuX0ywVdPAfp1NCRkHigw7XTkqoR16xvCOTt+899hesiVCukRjC25/0NGmIK/dvCXxQbd6wFRhpTcU2GJ7/5joYe4sYM1L/EXqUew596avGjBAUjbIWZPDqoqiB9/pePePhy/2tSOL1qNJPMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKozllil; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKozllil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732560755; x=1764096755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PypqM48wHNxoRfT/XSjeM06GEiTTt2qozPFTer6vebk=;
  b=OKozllilvMjiZEGkpA72EzT79G6wWwf6LQLf9PznDKsdozqiiI54COWA
   k3VJxghXE42lQgXb0DS0YD1hwETagIsWGR/o0Q0ik370BX5CIh5/usqbw
   pRjtAEwPdjL6cMSxz5bCGpbd2WBDK7Zs4jDJTtB/lEUJkO6gdw4l8n07w
   kXIK5Irtw5ou9rE9wlLzrSBbj+pKOV7aqQOmxD/bo5cpppvotkH3jfHuv
   RIh9HbJcBSL2lMLGCnGFm5GcfDAosjmpqKBD/xV6yypQYDVEk9Mh1RN/c
   EuFgPXLImLr2jhGazsEL4BWXQ7zkt+d7clglE9bmjsc6i8CHPzbjqg0Jb
   Q==;
X-CSE-ConnectionGUID: Er3DD2yzS/6ennH18G25YA==
X-CSE-MsgGUID: NtcK0XWwQ8KgoNoF8R0OmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="36345650"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="36345650"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 10:52:33 -0800
X-CSE-ConnectionGUID: 5F8J2MfVSFCnAFfYLnOhTg==
X-CSE-MsgGUID: zXrQfQR4ToK4GBsMc98TvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="114621258"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 10:52:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 10:52:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 10:52:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 10:52:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qaMiWkG3dd2U/vqYqX8gXKSrFvFpXzQYvBbLBBMKnqQU8F2iV51mWepyHToYGR+Mq291aGpfcIVU09pogLm1XwNuY4K9s49MN0+k/aPLsn/cLl6FW/OvfuVyJAaq+1nytzStNhTkMMU9485o+Euu6Ez/5+05qMCd8IuKZ7JaaQh+XP6RAXbxFYYw6elZppE0TIReSeyekMtGppqwUmFxdofoW1hMDZ/6J4riUhFQC3cL30uS6IEtoz0Uq03fRICV6d2smbf6J4obzy/8tR06/fI+rX8TiPA6V9o5ygjVSSlKCg9omzgN02ZewwvBmq1T9Zzttr9cF/JUWjF/puKA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEUT0pvcAPVtElE9PXtdVoqB/DjX5zbzqw5TTJDHRPM=;
 b=q+dZv1c5hU7u74gRmxvcvEyeGy0+yFuiucz7qjxDQm4HIo/RrxLnSV+lB4MumEMl7enSDgrjbye0y7Ro0wM4OqdqY3U+crGvQr//q6zW53+viaPuTuI+MnZKhQdy51UL81Cla0eDnM9lhnN5ljhivwFuzPAemn4fk6c3S+7JNb7dGP4Z7xnOsTsfmlLij80QueZ66piwNioWv/7Q0taacpPVnjfTRuECTBZhqgPkeTbVd6p+80VL4QS5kGvv6HObuE2noj9DlAkFXK9IZnp1Wscx+vq23unNihC3X8kptKzeW86BAv3DHKX9s75dVs923y5Iniuc7li8uHcfkLP3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 18:52:28 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 18:52:27 +0000
Date: Mon, 25 Nov 2024 12:47:27 -0600
From: Ben Olson <matthew.olson@intel.com>
To: <dwarves@vger.kernel.org>
CC: <alan.maguire@oracle.com>, <acme@kernel.org>
Subject: [PATCH dwarves v2] Respect CMAKE_INSTALL_LIBDIR
Message-ID: <Z0TGPw6P8y3c1lKO@bolson-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 092408e8-daed-4d9f-10f4-08dd0d824ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YWNwcp0coF13DFLKEIenkcPbIPFW9pmLLqCIbDXzEG5s0mFnqKSvG8gq4r1K?=
 =?us-ascii?Q?yQduBHfi9OMosc0AhNKRUBsZw1XMtpAMCywDFuAW30kSKL8q/erPzpHOKZa7?=
 =?us-ascii?Q?Ly2fIrRB//xM4y5Hw9LmGOa3WvOBHzHT58Tcu5oaibAtqNBDkpkrv4LqPlPI?=
 =?us-ascii?Q?OmvMHDtJX4cVZ35/qUKvoIXONPKzuMksDmWm+3YUcO54h0PICzwVqujomJMp?=
 =?us-ascii?Q?f1iVECnh6LrEKL60W05bFxqT3SPMWxao7tIm8Rkw+kKtzPexG0SV3cFASDPm?=
 =?us-ascii?Q?rAXWsImly5OFcO1/LfyCmNlY/SUEFXaQlJDwi3YaYVnG7E1I0X468WzKzP9s?=
 =?us-ascii?Q?+Bx1N9xG+EuAFwIfjnGMz/TqLgA8Uzo9iKxaBh0A1fSCGmmJUBWCOg0mQwmg?=
 =?us-ascii?Q?V9H0XlUWnipJuq9MlBITPpCynUdUzNuxPnk95aBLzAHhlEcSZ7yej4CqWdvR?=
 =?us-ascii?Q?hrPvHIdk/H+c3OrGoAaffoZ8/A3T/C8+bJ8UU35ksrvlt3rMmgf4LltU5C5C?=
 =?us-ascii?Q?FuLKCh1kbFp9afWHjBy8Hu/pWHoGmQgBSiTvRc0PB9z/C03j5/r3ba0ldav1?=
 =?us-ascii?Q?V4SviJ7eNXUbt7wLQA3CR1YHKhI/6LLv7kdwnaPtijaYPTC8RNWUG1AdMUKc?=
 =?us-ascii?Q?wFIxkR0hjWwuLRNXdzUckrYtzQbD83p6TgWKvXu4Yigv2x/qOvKopfL8Yuv+?=
 =?us-ascii?Q?nereeTOHGgOba5xOjTmCDazIUWqleLdjBZYaLRFfzvJsoTjjwPqKkMvPLAp1?=
 =?us-ascii?Q?WQ2e33G83wkr691ByUtJeRJc5BWjwmj2xDB7SNYiaAgYm596WlWptb6UPHKI?=
 =?us-ascii?Q?eojEFLl/LOukH/hxpQjom0IwP8B1mjtmOgT4+vApLuiggXyD9jQT+KNpV9mc?=
 =?us-ascii?Q?qRAZbkg8PRP39RGk830q9EM0hE8eFZ/SWoOLqWQgwV7i73KOWfb32SfOnGyt?=
 =?us-ascii?Q?CdHj7gQYPlvHm9uMnMMBG9d3Dz+F3n50rviQx4Fmf/L1H8fDyANv3JKGx6Pd?=
 =?us-ascii?Q?ryUFStqQ9na9yywu6nA2fzoErnJ9NA/HF1xIWcRW2+HO1NldHFrvFiR3U3lG?=
 =?us-ascii?Q?IlOdOcenBV4P9yC4kgFHKKZantocIL1G2Lkb32h7117YXO3F+EkKw+HqQYkd?=
 =?us-ascii?Q?5NkUgeTprz1O03Xc4cp9/nVRWIWuQ5T5TxWR6Gk9udT6MWqeeoWEAfrEySIo?=
 =?us-ascii?Q?jGf09Hjv733q63Qge/Za/qOIpnASlVHxbCeJ4Q5gKgbkLVsVN4UXisuCmZxV?=
 =?us-ascii?Q?kJhqdEpkAX7urHI4lqrqkPTOrlNZvW59BWQ8XRN4kyJ7o+6GEkONwRFu639+?=
 =?us-ascii?Q?USkcKrkntz4VKhm9Y4REMdD30anVjCV2Ap+fnLnX0IVYmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4f6RKxrNRQqPNbR+RNdjQiF6UAA77Hftf5lO1IDeBfXZ8+BQXj1P6VcNaTp?=
 =?us-ascii?Q?dNpyId/S3jSXPMgiS5px6/12p/hxfTNYzuSxkvePDXeZEswIVoP9YaC1eXSO?=
 =?us-ascii?Q?Av2Cc0rVpNw3FpL1jcJbv+fDR4Rfz44uOIhJLMLUXnAkgj/vyV9KpgGxLM5y?=
 =?us-ascii?Q?9S1fSIKC43qL/SGO3n1bBwJ1LKR/4dcn7zs4GWq3Q2KpKl58tUd3vQUESR5v?=
 =?us-ascii?Q?LJmzdyejlD5/hOmvCvqiwXlFAaXYAobsXXMHx4kVW/tjeMzfYPVDFjE1VdUO?=
 =?us-ascii?Q?FUGEjvin5dhegkf1g1Xp5jqwi+/MZJ1/1A2eIlrlS8RQVXaFbGBtx5do7M8I?=
 =?us-ascii?Q?LHYUFHhc/QSBffZvwUh9pkl8HcLjaiph/R907v+8Z1Z/ujUqf+pDVO9OISdm?=
 =?us-ascii?Q?bW8Yg+3j3Z2ne2T4nYI5EeL2qcd62i5I+4+29tNlUPMoxG8ITZnQD3zerTp6?=
 =?us-ascii?Q?a5Y/PPtjkE9qiX/OasNba0zShdqsCh35nfiz4H7OWUA81LUZKO7pczZxhCiS?=
 =?us-ascii?Q?Y0AXrCbOf49xPG6YpWxYB3wxMz2ya1X3piDOUNbZQQhhR0wN+aWV9aE2ohmJ?=
 =?us-ascii?Q?vZivZWy3do0dVjMElaU2/Omj9AWr3/hHnWSRO0aYPyTGFOC/UcVfX+YAgI6D?=
 =?us-ascii?Q?Pu4mWEWGZgZP5HGueIs73w2rjGyhj5Nb9wEmUsidKzxA00dD/61YfLPJ42Au?=
 =?us-ascii?Q?09A/zBGocZe3ol81DanyH03I400CfrSFz9QU88aFomwe5xY32DihsX9N1R3E?=
 =?us-ascii?Q?vouycuGmsn64gT3//PFMCC8L9cQ5LP3x2P1f6ZpsLhV+nzjukl/0+uvaZkYw?=
 =?us-ascii?Q?m/KFfcNGOF+bHenLQr3m8zvN7WjImN8bBfj5lPMutgNHtt8A63DhvSKJqvim?=
 =?us-ascii?Q?A/KpiKKw7OK+zDbD5F7TbdUDTvj82QiqSkFWROfIwZYbMSU6wJyemSowQCJj?=
 =?us-ascii?Q?k7DNP/Th3gsqfp/GZ0GkT3wFUGEf1nQyRV4L25BPJwoZjL7d118DbL8r3rV5?=
 =?us-ascii?Q?gi2XyM23o/kH5JlVFDJUd1Df2Kl8IBzLYX8aV8m6SOTBr5jZK49KRf7+rCfd?=
 =?us-ascii?Q?jk9M+FelFcGAHHm73tCU5NnJZgch3itnCXYxyUHKYC/nD/mJLFbWjtYClc2j?=
 =?us-ascii?Q?nsY0CQMIp17QS/5rZsCEir3PRtjicpmKgMmj9kArtFnqXf5qRL6R23+ABtqZ?=
 =?us-ascii?Q?HLpIOvfA/rhhi2G+kcRG3kqIessjxXAUIAzWLUhf59FpulZ11UrhfQKTIy45?=
 =?us-ascii?Q?y/T4O8ul+RTsNgLD1WdA4Tp3Fi6FmvDlETb4WCC98P3ctuTl1dxU3+XeV2ov?=
 =?us-ascii?Q?NMpcObm4bjuuKNMHnrpuPIr6OaP/bTZbzazwBAo+04LfUbtaFCubLG0Na7ds?=
 =?us-ascii?Q?RKDlivyHLo9YvxX8Ht5OMo6VlqqwM1mGev7aa3xqEYScbVS7n9nzEASCRiSs?=
 =?us-ascii?Q?locUSqdQbHQ8CqYLn47bKYKsKzLmzGBs3DOCU0fSrAGtniCDZyoFO4DwJgop?=
 =?us-ascii?Q?7O2h4VhbTX4XVEcuuGzVhqFiMAlWpDCxDcX/YhpBey0frdsDiybhM6BmCvQv?=
 =?us-ascii?Q?H5U7U4IflSRCYfFeNS12d56D1NeGmv3AeYpivRw3aRwOw8cLU11oY+Ps8Kt6?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 092408e8-daed-4d9f-10f4-08dd0d824ed3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:52:27.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 364K12kWqnDtNETOn4p5JsuvvcAosLXrh682uKYqp4bxHaNB+tzlZxIFO4jSQgydOWbLye5uD0JITvE+elfNfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
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

Changes in v2:
  - Included the proper built-in CMake module
  - Made commit message distro-agnostic

 CMakeLists.txt | 19 ++++++-------------
 README         |  3 +--
 2 files changed, 7 insertions(+), 15 deletions(-)

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
