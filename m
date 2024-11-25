Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C719066E
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570760; cv=fail; b=UdI/ZKZVDfcyhmnsYr64Juu6kCYH0DbTzj8gGSe/HEUoPWKlbL8ZQ2hzdCK+fjz7M6j9vzpfHfOr9dNc8nW6NwhxTDy/3N+kiHdz1dgnuNCk9EJmvOQtTb6QY+Fl6LuzZnMzy1lAcaWc4VW6Ny+2XZcJH9sWPm798GSFjkDrHvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570760; c=relaxed/simple;
	bh=Tm0/mrppwK5lj1PCWLdY5HLB6gAU/z0LQSKA434fLkA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B/yEfMcMoxzznjjYOvNmCtGBJr4N17BJ9jkKcnaYhWRau+KAciOsheMUiEEvIOImGK3ISLe2V8SpMvhbisN7Yz8K9XRJ6HimcFedGrREXLrnETi8A1J0cvdcpTs2lQNMjaGth3TmyEgV45jFXoWAiPGRHWzpo/lmJX6u+Nnk790=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmQqniPU; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmQqniPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732570759; x=1764106759;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tm0/mrppwK5lj1PCWLdY5HLB6gAU/z0LQSKA434fLkA=;
  b=MmQqniPUfJnG8QeDOL++gnS9KXCmCQrD9wYtjgdSq2HIY2eGJtKNHiTb
   1fHtqqyr9jcU9Wxfu7GhaFdClJnlkTJT6tTkM7cNg39mG8+YBdlH8Hsup
   DfOmBJlexrtb4VBqjDRtFGrTcjpU6Kpve8hc+lCivIgcS3rT4UKgPRM4q
   KT57UgQ9naNQmrGp0D0CvODgAy4KiECVjvb3vw47zyCZN3AxVpMlLn/nA
   FifveeOn+eL5RG4hpQT7xOggFpfAecacL2rey1E/3W2D5g+SQAVBKdQsQ
   CaMofwp+Za7zBOSeydeeSI39ai6cmNintQo8NkA4rMHkIlyNsVHzt5lDm
   Q==;
X-CSE-ConnectionGUID: JgJi7dA0QVKt+eHuVh3yZw==
X-CSE-MsgGUID: q9suJJGFQBKILYFnJ9iFUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43362705"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43362705"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 13:39:17 -0800
X-CSE-ConnectionGUID: ThBmItvyTAuVcX/ftakOrA==
X-CSE-MsgGUID: nBavWbk/TluWCEN/lulPgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91731243"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 13:39:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 13:39:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 13:39:16 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 13:39:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qly219bOBTMi51pMh3OYCopJyn+DAWQtzeiwTSYpjlkTNmNJZUy2Ahnec5IOdPuPAop63zIIbV/7zlhUKS3Pt9bzJzOZeZadZE6C+glBx0rhWPPFn7uT9zZd34BEmmomUh4VixBvQ1W6N5JarBiGdBnJ0iERumCvRtn8s4UNKhiOLKpjAAGJwNMBm6dmlT7CymiNX7lwi/NdKERG7VRiolWOMuLmaJ66jFvSuGdRBELhLmKb7MA0+bgTwCgpDpXnxgJWPuToBczmvHR4crEgwh1KLRWljgeb7tVkTa1SiCRjVWe/ow/Hin4/xVCvYO+B3o+J+Xgf7kLjDKaDFGhLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjYvuQdlzQ2o2fOCPxoG/M2lBLHRWpQq+Qu5t9CMOzM=;
 b=nTJbp8u8Fh3QpHKSl+eEIRmYegTz2QeMD3Ti1qlBJ/iHyWlXlr/Jnb0U6dB4Ss6QwyoO+uzJUxOXaquiQCIbWa002BHnAHMc8f7/IAWQRHxDKQrwA9x5gsBwit0RUwOrSbwBU7pPmTC6zhQQqFGl+S18D8giJvffWU26li/xytdtKfh4V+17S7vP0mx80OC4rhpGGX45u5pIH2HctW8YyOQdX0kf2VQqrlqt094GUmdgtM01i+s6vD9xvTrwM95NGGALshjdwLXdKGDN8xHjzXecGxFnHiJkRqqUg2Ky+BPokG3YD/hAHS/04r7AWb8sUTwP/2MTiqTqy+SA8rMOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 21:39:14 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 21:39:13 +0000
Date: Mon, 25 Nov 2024 15:34:13 -0600
From: "Olson, Matthew" <matthew.olson@intel.com>
To: Alan Maguire <alan.maguire@oracle.com>
CC: <dwarves@vger.kernel.org>, <acme@kernel.org>,
	<brandon.kammerdiener@intel.com>
Subject: Re: [PATCH dwarves v3] Respect CMAKE_INSTALL_LIBDIR
Message-ID: <Z0TtVQlYtiLerLb9@bolson-desk>
References: <Z0TefTqE9Xqx0Gz0@bolson-desk>
 <3e7a5089-f483-45e8-b53d-e2d3bb719835@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3e7a5089-f483-45e8-b53d-e2d3bb719835@oracle.com>
X-ClientProxiedBy: MW4PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:303:6a::23) To DS0PR11MB7444.namprd11.prod.outlook.com
 (2603:10b6:8:146::11)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|SN7PR11MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee8e136-c0ac-4f6d-7f01-08dd0d999a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A89iAtX6+YMFtPaCd+EZ+yS5v7kGTLHZgqP0pBH3M1lYBf892Gxk8spt86fQ?=
 =?us-ascii?Q?erBekBDFcHDn0s75gpihoLEUf8vvkqNxLsZ0U6m2yNnLdhTBhKhlx+oFGahG?=
 =?us-ascii?Q?f9oqwkg16A6dWj4VwKjMJ6VAnF+wCTeNaN1VcNmIfaZ48TzajaS6qzW+d6Yc?=
 =?us-ascii?Q?xH+EoBVQd6l8F2D0z2XdxOqf0jGDRMAmoP3BMayATYvzMRXi5BjRS56C+QI+?=
 =?us-ascii?Q?hqZhemGOsXQ7jucN/BADBUKZQprwEc7zY9Dk2f8OwmfKjcqOPTK9u8nXhLts?=
 =?us-ascii?Q?ccIhQriaeDqYJ5Cd5K0Pr3JSaFMIyoepQ9xsv/KAluYzl/yfmRcJOtNI9t41?=
 =?us-ascii?Q?hH1caF7uXKn7SRbvwExAqs0cWDEMZj6zPk1+XlEr2EX80w+vGNywYWFoGvu/?=
 =?us-ascii?Q?EqpgR6e8vwd5uGQKeV9yRY9sOysyEuyVZSWRoFerf8YUM1P5RfI8lfc/e+gf?=
 =?us-ascii?Q?dIB9qYVOOr5z0Vbf5eQS9vpd01I6evzljEy2/joMNKp7OWf0N7g1oYKPvLBA?=
 =?us-ascii?Q?06wZ1ag1wEvRtkCu20ZGOkRoiqqqn4Cg4lFyaZu9e4vw+x7S196I60PER4R1?=
 =?us-ascii?Q?7quNe4a0WdcgGQH+EcnNsXOyOBL2ZL8RcF8Mdm0x/6NZslJ8GOPn8X96o+Fi?=
 =?us-ascii?Q?F035ke1FvynGRqDCv1WM+/bEVOvCEJ/28Z4as1Dw4/DOQDmNrlB9+dR/bxuw?=
 =?us-ascii?Q?Idl+2ScyhDMJ9fSCG4QJUNLPXOH6wQhbcXzfkuvt3YA/vD2mLEEF4TyZQtMD?=
 =?us-ascii?Q?r1Mxr8dCbrfXdyx9KAugnz3vAr2rB8EGQ5nx99zorfL4SvToM4o7i4oiEHHn?=
 =?us-ascii?Q?DQR2G4RFLqRZeQYS9j5QKObKscTb7LlO4FOu8FWo0RbRel23mhomDDXGDVfW?=
 =?us-ascii?Q?3PSbpO1ihDprFqPmlyWJede51Hd+bQPuVmYKovSuzOJG5YKZ9vyM3ozgIiSF?=
 =?us-ascii?Q?AUW/+ZHon91fBtPFfjM7AqopdHDcdHUMUYYuL1ApkfTtxyD37jxJGuCzHfsE?=
 =?us-ascii?Q?idMWoW81/K0SsoUpJJk7yGU0mF7urQK9d6HBPPBklbKLZ6EoI6XaYNTaXlK/?=
 =?us-ascii?Q?zR2ltuuVPy0jl8IlWt2vt0aDtPHCjp9yH2zAruErvX4KgLQvTS5Gm04QBJqB?=
 =?us-ascii?Q?rL0uJSYCgvNU/1PQtj03wp2glMDGztbdfpgxCCbUUEi9POFe9bK1DRjH0Exu?=
 =?us-ascii?Q?hcl5Y1lvQgwfzUxSbl9H7bunjMEHBl8Aed9AL0zq8kH26M4tXYNud+gD9XfA?=
 =?us-ascii?Q?SRXXZIIUUk4CrNK/RlhgQg5Uoj58EnKsrrzesc9kewCbgyhKoQ6BumIm9TXl?=
 =?us-ascii?Q?Jd+nF9UFPTajPf69QbpPXkBzfcCBXoe7z1Jn3Bykuv8XXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TN3YdZ2x2AwqbkMe8ZgMiMT0itJTXdxPfhIOsYz5iFuj0PjWBn43FYLwovla?=
 =?us-ascii?Q?9oniyi28A6ssId9Ko6Ue7vRZTtnkZ/V8Wzz0iiUuiJGkK47Tc3aZATMlWnGT?=
 =?us-ascii?Q?iTecekrOD65V//01NQxLNk+NYTz8by8SyLGgxaayc9bNM2VRxf31zVma3JsF?=
 =?us-ascii?Q?MuZZHmrOw+cfT2mllaf1S9XneKZ7rRpSrdpLLeLFf/S6j6Kpq5u0v7FPaqYp?=
 =?us-ascii?Q?C0Ecu8kR4klCH3MY6s8xJB+A/4RrrlUvdIeBbsso7Bg274mnY0wHZw7LPZRH?=
 =?us-ascii?Q?ks+WzpVb4fqflKn6QGlzZ32s1AquwJ6Csh2qMq8A6cpYy8pfEFugyt1Nq0Aq?=
 =?us-ascii?Q?XCiXgCppqGlGIYhgP3xu0XbzgQRRpgARPi1o6+SpWe+VFlGm8vkFTe4mYrTP?=
 =?us-ascii?Q?xInVVEuhPkxEVguH4El7GDY5AoqRRPpL9rL0T6QOQe/im0fAJa6ltGh/DWuy?=
 =?us-ascii?Q?N2v4elsKmbGAnBFqRpzdicd/tXRPTZ43mJJGtIN+IOuu1paHbP/wuIVssAQ1?=
 =?us-ascii?Q?UsQjqX3uNArWIRXnhGIdizmSqbouzvxCdLjkjyuoKuLh2sVABYfr5Ov3AOJQ?=
 =?us-ascii?Q?Ep1jTGoSOPQDOvvEdH1LwUBBVkUJiByQ5hzYsIrRe95WBCZSwqLateirPpKD?=
 =?us-ascii?Q?mhsiRenkqyCzLUwpT2/ul7fgSaB8VeDk8TPuz39fzgZ8XYQufIIqnBDgO5J5?=
 =?us-ascii?Q?+SgxPcVPQZ28wHrO0QLhc/m91N7Fy3Uu48y3dPb0s3LSCNFtvFreanNeiyvH?=
 =?us-ascii?Q?JAP1ZtvqGXt77vb2K8vdIRpAPyRCG1dOtZR8zyvZdreT3IHhWZywip/RCaDS?=
 =?us-ascii?Q?8043En0AkIx4TcYU/jgjTj+NDFbhfTJwVfWKsgETdeZSceMrDq9EUyg+YtrH?=
 =?us-ascii?Q?TNuMLkr3RwFI2Sb1iAv3i7XSmnSc5Kt5txCzKQ1fsxNP0x45yuMgK7lRm5H9?=
 =?us-ascii?Q?QloZEoJOKj0BnGJA5e1yPzbJ2JPLm7tlMZwP5EITyRnLGnBfDl9Xn6ITCZ7A?=
 =?us-ascii?Q?YpizLE4znH1JungSC6HK11tcljIfo6vHjp5a/IGF+cjpzkRz6GjuVC/O1Rqr?=
 =?us-ascii?Q?iwM6bjhZo7CvafBCG5g7HwxCY8ARt7ZjcBJbm+B/dNW2biKIpUFPs7iSFa/G?=
 =?us-ascii?Q?CsLFp41Jv34LvOffdIDTp1GBqR+t7bQsaffeQOiuSs4pT935tj0WSmQEDkkC?=
 =?us-ascii?Q?tyFqqqnPHHG8hhN9iADT4hgcwGLfzKDI+Zp4+fbQ41kJRcvRutKMIdjK+eRn?=
 =?us-ascii?Q?J5SbeA7bpi8RIdvv+xZqHGVTHwaHG3kcwF2PdNCbkSidfIvxYim3U4xSs36w?=
 =?us-ascii?Q?O2gkZmzmlz9SzvFq80uAeoZDBl1kioVEWHJpNbjhDa4sufSqJrIO+maen4Yw?=
 =?us-ascii?Q?NtRdagUAeF7W/tpFDLU+xiNzN2Gyx7WhY/0GS/ACGV9mfZMBDOanND7vblZp?=
 =?us-ascii?Q?IqaK0zAZiUHUoU9Qwr1AtGYNjGctdu/muocZYKgc/FnUncbJyRCnARlurk4S?=
 =?us-ascii?Q?u+7hOhqiUshiJCpcFG1/59KBezqfJ+EFZYAYDDmLEJ4huRtXccThdEjXfn3B?=
 =?us-ascii?Q?LrDJLZkcxnAFCNsvTaXPFOcu9629a+p/F2I7S1O79arU5SKUxNNabKFVoNn1?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee8e136-c0ac-4f6d-7f01-08dd0d999a92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 21:39:13.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaiL6kbiO6PUcOkfYlG33nVlpFESDyJzkTz0ksJ7lnL7Sh/zx8flLsBBafKmz0qFWSuQz8L3aoc0rzCGvGhJ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6776
X-OriginatorOrg: intel.com

On Mon, Nov 25, 2024 at 09:31:33PM +0000, Alan Maguire wrote:
> On 25/11/2024 20:30, Ben Olson wrote:
> > This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
> > and use either `lib` or `lib64` by default so that installations match the
> > conventional placement of libraries.
> > For example, it will now install `libdwarves.so` into `${PREFIX}/lib` or
> > `${PREFIX}/lib64`, depending on the distribution.
> > 
> > Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> > Signed-off-by: Ben Olson <matthew.olson@intel.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> 
> feel free to retain reviewed-by/tested-by for small changes - I noticed
> one problem below..
> 
> 
> > ---
> > 
> > Changes in v3:
> >   - Added additional change in README
> >   
> > Changes in v2:
> >   - Included the proper built-in CMake module
> >   - Made commit message distro-agnostic
> > 
> > 
> >  CMakeLists.txt | 19 ++++++-------------
> >  README         |  5 ++---
> >  2 files changed, 8 insertions(+), 16 deletions(-)
> > 
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 8ca1bf2..1d0dadf 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -21,18 +21,9 @@ else()
> >  	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
> >  endif()
> >  
> > -# Try to parse this later, Helio just showed me a KDE4 example to support
> > -# x86-64 builds.
> > -# the following are directories where stuff will be installed to
> > -set(__LIB "" CACHE STRING "Define suffix of directory name (32/64)" )
> > -
> > -macro(_set_fancy _var _value _comment)
> > -	if (NOT DEFINED ${_var})
> > -		set(${_var} ${_value})
> > -	else (NOT DEFINED ${_var})
> > -		set(${_var} "${${_var}}" CACHE PATH "${_comment}")
> > -	endif (NOT DEFINED ${_var})
> > -endmacro(_set_fancy)
> > +# Use the standard library installation directory
> > +include(GNUInstallDirs)
> > +set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
> >  
> >  # where to look first for cmake modules,
> >  # before ${CMAKE_ROOT}/Modules/ is checked
> > @@ -84,7 +75,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
> >  	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
> >  endif()
> >  
> > -_set_fancy(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${__LIB}" "libdir")
> > +if (NOT DEFINED LIB_INSTALL_DIR)
> > +    set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
> > +endif()
> >  
> >  # libbpf uses reallocarray, which is not available in all versions of glibc
> >  # libbpf's include/tools/libc_compat.h provides implementation, but needs
> > diff --git a/README b/README
> > index f9aeef7..e9f860a 100644
> > --- a/README
> > +++ b/README
> > @@ -3,8 +3,7 @@ Build instructions:
> >  1. install cmake
> >  2. mkdir build
> >  3. cd build
> > -4. cmake -D__LIB=lib ..
> > -5. make install
> > +4. make install
> >  
> 
> Last thing I promise! This should instead be
> 
> 4. cmake ..
> 5. make install
> 
> i.e. we still want the cmake line, just not to include the -D__LIB=lib

Ach, both Brandon and I missed that!

> 
> 
> >  cmake Options:
> >    -DBUILD_SHARED_LIBS
> > @@ -12,7 +11,7 @@ cmake Options:
> >      Use -DBUILD_SHARED_LIBS=OFF while invoking cmake to create STATIC libraries
> >      and link applications to it.
> >  
> > -    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
> > +    Ex. cmake -DBUILD_SHARED_LIBS=OFF ..
> >  
> >    -DCMAKE_INSTALL_PREFIX
> >      Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
> 
