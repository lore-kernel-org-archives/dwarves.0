Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6A181CE1
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566794; cv=fail; b=TIg73/n9DDckAMVmPszAc2WjlBvs4vmL7LPJCGsIAFZIBVYUg1ZVk94XcoRVvF71qiKssHlaMGT4+rkvk6KGULK2e092BaJD3wkG0tt/E5REJlCNTr1CBYAQleX6G0YmgtASuCBAV2AhKs46SQoVN+VBt6iObvLX7crZrMVI7Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566794; c=relaxed/simple;
	bh=xBxwkRtgTrKZL7Jddf9ZkiZkDWyzmyWcDUffPkGYnS0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DbKbNWhdE1GqFd/Dz+lKASrEcQJlq2YOQLoI2DPWoNFjaweEwHyWsjsIy3bFBkBwPKLORz9dxGmIZlj5QNrO5dDKGITunA8h1Afw5jpzzYBNdO4hv2M8bOKqcuazJDP0Icf8KI3wpvJlikSAXkZ4W0Jh9iB9bxslHMFuGBiqPck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVKEMumy; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVKEMumy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732566792; x=1764102792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xBxwkRtgTrKZL7Jddf9ZkiZkDWyzmyWcDUffPkGYnS0=;
  b=BVKEMumya42cgWpoKBJmeoZWwEEYbu2kI1sXHs5RBEdGCxTriWgCKjWj
   ephDOU6gu7j+stS949cdrO/RTE31WLZBJVoBTuuhHT6jKPS0Hx+JvqBqO
   iDDa/eJ+6lAVkp2GRXUyRaxgFioe1GEaWyR4lgXNK2IIA9q0+Kopa+xyO
   JQ9lF8ISOuDT4W+ZZm8UHqr9zWj8EClp6G/LJ/+sa/QbDeBSQXhrZlB4T
   VKT+aOv8GlNzG5fznbTWfJOQuLyZTDvDj7LAhd7BA3Ibaa76mXxhsF95k
   kql0ocQoie+KdXdnE4wgDPvpkLxgMfQgF9lgq7Sg8T9VARxszRnVMY8zo
   A==;
X-CSE-ConnectionGUID: vnIpIMpeSai10LaA8t/UXQ==
X-CSE-MsgGUID: 1BL2SemlTDiKbBKJZTwNtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="20288565"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="20288565"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:33:11 -0800
X-CSE-ConnectionGUID: SdqOfaWMRMSPq/318vRsqA==
X-CSE-MsgGUID: 0wPSkT4PRCCa8s5yez4g6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="96308125"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 12:33:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 12:33:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 12:33:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 12:33:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR8kbaMfumR6jBQ7A+GTjmdQC6fPiupu3eOo4LJGQ965cKd5N1p9q1dOngySiD63xag0hrlJFgUcl8OsZpIFTN+HZLDj85GZmHy5K766496dS6uqjkgACwIsISkfmQnpJXs8C8lAouBifRCOQVOnqDY14MDlBS50jR7iJiw5w7bMsMNJS9kj5ML4NyUaiGJAxF1TM54JjmxThXBrx/Dh4cxFv8eedM9HqWm9TX6KxmgmRldcQ3DcHvEYnLr8r/n+/Q6ynRAg1RloOePNZLHmpT/ZLgH2lIVJXM/JCRO4QgItvvsidNJRONaMZFLyVCH0YvH/yEbzBpyx9g0iO5H0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGJ1+eaBIjnXolYIYQAznU8WNDg8HY4Xkaw02JSHXMY=;
 b=f2JRnM3EkAtLSwJa1jh8DhTHyhJvZTTC9iDVy7qL+lq9Y+mJWsHY3fnNCMEIz+Xg0s+IwOWt5cM+vB7zR1zMrKpfBKaMBwnsv1pPlKh/QvWC+udX15y+OAAbYgAn7PZyYbnaHrYP/EFoqzeQY3nrB6H+1s4O8MNuWhNoQTMphFExF97810UxsxJ3rlN905z6H87K6UoEq+x3/LDjECqgVIU7/ykY+BZ7dTeIaYDqmi+S0BgR2/r3HJ0X4RfRuBnhKyh4M/vJCT8dN/m14L4Kkcg6tNVYE+EFozNKxXXxi33bQy95w1H5ymE0AiP2dHNewuQ2W7TZVIPnOvz1HnJdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by LV3PR11MB8556.namprd11.prod.outlook.com (2603:10b6:408:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 20:33:08 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 20:33:08 +0000
Date: Mon, 25 Nov 2024 14:28:09 -0600
From: "Olson, Matthew" <matthew.olson@intel.com>
To: Alan Maguire <alan.maguire@oracle.com>
CC: <dwarves@vger.kernel.org>, <acme@kernel.org>,
	<brandon.kammerdiener@intel.com>
Subject: Re: [PATCH dwarves v2] Respect CMAKE_INSTALL_LIBDIR
Message-ID: <Z0Td2QLw7BT1vXbF@bolson-desk>
References: <Z0TGPw6P8y3c1lKO@bolson-desk>
 <7b845bdc-6374-4c95-bc71-353f69f785b8@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b845bdc-6374-4c95-bc71-353f69f785b8@oracle.com>
X-ClientProxiedBy: MW4PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:303:b9::26) To DS0PR11MB7444.namprd11.prod.outlook.com
 (2603:10b6:8:146::11)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|LV3PR11MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e288a7-00e3-46e1-cf0f-08dd0d905f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NDu1cvcqaxbki+TccMpGnUeMXrzWDWOY/nz0zeuDQgQeJn1Js878hdOP3eKS?=
 =?us-ascii?Q?lL/cBnwtz1K/n3Gm8huThlRDyEtfLZkqjb6N2/zbb0AvAYeVhd2Mykn7sTbB?=
 =?us-ascii?Q?GplS2SWeY9kQYwjgvcrxKxMCgHSA3gfT3G5AWqagMUIqCdEFBwyjwD/pUU6+?=
 =?us-ascii?Q?CsTT1tS2AGKFZ535bqjKI999s/jQCzZ3rlR8wTo7ki8ZIjlRnYjC+hTcIuA+?=
 =?us-ascii?Q?ydrb9Cg3hK45JU7HOhEyM1rDb8p6nQ8h+R0Mu+H4CAL+7knOHAVYhlajhk25?=
 =?us-ascii?Q?L+qm0r9zV8UDjIDInMmoAXU5odGGTc/cVLQInjMYIlPt/X8xu1vYSINqKdNv?=
 =?us-ascii?Q?G1CbfC9LN+BT+/6S41ltYK+bsxP+lJ5KosgrZJY6tMB3Flbok3K4AEmQeCAR?=
 =?us-ascii?Q?lTzREsV+iaFH8NjpoGLp0sQXQpZp9p8mJ4w8q7GDVAxY+kjskNAsqOLkL1TB?=
 =?us-ascii?Q?qDdCMJ+AqsqJvYIyEsnHamRnfgFn0EHnv3WtZbO4hOPDkRB+O657GeD3NR1a?=
 =?us-ascii?Q?LyxYjj4EiREqn6xPL85wX1gY4qe/wBSuWp64iTMs/y3d/WnYWp4nGl9Ztb+p?=
 =?us-ascii?Q?3lpbfceJYN64amva5nQxIq4q3+vp4tXv0DTpBGmLYcZ76mMGv5d/xynJTBh+?=
 =?us-ascii?Q?Lw0XdhHJgqmiHbNi8f2yfUnbtkWDzvViIiSHof7jftg3iSfKXJq4sxLX0MMJ?=
 =?us-ascii?Q?Km1eteqIzLV80i2oG7U5yamPtAx4xsRnOpU50StOsvajBw0QDVawxChXShLd?=
 =?us-ascii?Q?+tmY9k5AJxmnYAoP9UN33And5T5MvfAlMl2y3Tz3u3m+dS/hdUUaifsANNi7?=
 =?us-ascii?Q?TxfxsI7wt1NMOonyQOOH4sMcSJsCETp8PlCqHMR2nv23TbfO6BP9WM7hdr+a?=
 =?us-ascii?Q?luchWRpID2Zgfz9nDHP/ZfVkvyw6ArnanK1kvZqnYES7I0yqf+zGhuUIW+Xv?=
 =?us-ascii?Q?b8UTbvO8cC8BtYy8kkddb1H9ZKlVYmwrnXGbnqXup/cUsZ8bHgCMC8zJYAb4?=
 =?us-ascii?Q?W129KadFzlxofpNZzrchrIlRiOKSk5lNoj/GmqRao2AMy16OnS+N8crdWUxY?=
 =?us-ascii?Q?cniyOJe41J+mQnZAbTLRhyDkLLoqV+n+6nOApdEXDpCM3rsYRE29XzSIVURA?=
 =?us-ascii?Q?ZCdm9RIxP3yRmR5snjH9IpdJmD+VFuykCtnbBSysj+sI59ar+3BdgQO2Mzns?=
 =?us-ascii?Q?amI/dSTFirD3UKPTfZRZ1J2/hOW1LRo/gb1KDq5PFlIJeyK2Dk/qGKCszwqj?=
 =?us-ascii?Q?3CrBvkuf5AmgeoBls3sj3h6D6rlvtSxTsMiwvT158WVgY2Lyl4LMzmq70R/C?=
 =?us-ascii?Q?N4mF4A4dPpHYzHc8i4pJdtniTJ/OwcWRkqNFagR0//qIxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpYGR/PyYsf4cTUvcsRFjjJIQGS3HOLfgi9szPfZyeI7OGvdIUVFNeGSDOJX?=
 =?us-ascii?Q?hLaVtXWYkikdlnzSoZBhHKmm/rQqAwz1qFCLyWX8eCD/WpPUIYTj2NtrDA02?=
 =?us-ascii?Q?uB04paW+asqXNZrNAG+XmjhBvzJyBp41EvBiHgkDp2P7by15FALoTziMvKk4?=
 =?us-ascii?Q?Slu27Lmj4jCvhfTWJrd1Mw5U2UVlbTUZEdvNFebLSJs8st3Xk2IoR+aKDzmt?=
 =?us-ascii?Q?gVXgpGUEucW9s1UWuFvnl/viU2gBx2nvclPCVdLUXP7V54YCx6ppLBQZmh5v?=
 =?us-ascii?Q?mkhhjXVye3HyIna322CdAr3pN+PJJR97gaMzAZE9R3zxkr///I7wqT1TOVFl?=
 =?us-ascii?Q?BKGFBeI0QvE/K+fEs3USKmJEZGTqs/yAphr8GwTKikNKWr3cFwJFRUpEW8q/?=
 =?us-ascii?Q?JUNCe0PC3bGi2DFP3ZHbDlhJyFFfZkPe2HzdlzbR6G82xhc8Vz4TWsisVaXF?=
 =?us-ascii?Q?keG5UK6sR8Q+4fUbdN+pLoSSTFHcw4hfarL0+YUzHmmXK0muZa6hf72B1ihB?=
 =?us-ascii?Q?fro7PRPmkr8yxmNVr6HnU4L7YfHiI7bKhX9kq39jEg22Dy6lhzFYpLQPOxt4?=
 =?us-ascii?Q?3+/iGm3amqcCgeXVyo07a2Zl2r9U9OlOLkKXJ5dlfGrQbHeWlv+rM4uhrhh1?=
 =?us-ascii?Q?ZPta6HwdkptZTr9ZSeePHrgZix31//jo9uZPqZHf8kYX+tYwUmGUeTkwBkQE?=
 =?us-ascii?Q?W+YSKaaosH4P5jk2moj3tTXQ9+9scRUAYH3Z6Um8xJj/vqGHN2B16laDLETb?=
 =?us-ascii?Q?9Gu0ZijVhAPs/XUFVrHDyLfisfFcsE52gybSOnH/mDoga+DV9e2R8y7uYNcu?=
 =?us-ascii?Q?CsVCri78U1gzMgKaXYJSmvvSQt5oSdM0+E3L25IUCVYl11K/EV5v4Sk2fWB3?=
 =?us-ascii?Q?FYelg6+jlITB0oURnwi0UcGsJHUNLkVYEfb+j7rlTwz3BuPSJ8s3NQ1AbKpu?=
 =?us-ascii?Q?h+Vzdq92FlOGZ6QTRIEKjL5kIXX/VbniuJYKOiqwSX9LSZzpLJVhkixfmvPt?=
 =?us-ascii?Q?XMdES1C3fuWf9iwaDBHlA2yAjCpKo5F8/C2yH7kQCXu5X9+lrSdWod84Ay2R?=
 =?us-ascii?Q?i6MaZr2YcblmYjjJILZGTHWC9NgxB64qg19DtEARHh2YETHmDbANqTm0tO82?=
 =?us-ascii?Q?8RxdbWFvgYYxaQs+wNWZuGDgaECIxYXqbNTnjVB+8It7tk4vodVB/zk2DoSa?=
 =?us-ascii?Q?dN9BzyvWPmy3O3+Gt6zOdRZlv8zLL258s6NGecrFCSsjqrNQJNfw5wdGAp4n?=
 =?us-ascii?Q?ZwgGcCeD8wIXClugXn+NvSIqgAJuYGjM1sUd9H2/Cl9i7RLDKjQq+SWjAHQX?=
 =?us-ascii?Q?iAwe6KJVRBTgFcXhzBrMlBGlGzcQA6hT2HGmismeO5lsqegUH0MsEC000Zuc?=
 =?us-ascii?Q?BcP5zXiERgCLdlLMGfBIKKqPt7s62+Kz1TpuS/o93S/oW3p60M0rTFAclzw5?=
 =?us-ascii?Q?HJBS+7YIm7+fDpCa5Qil0noV8+9aD2+Sm+Q5m/I52yfwQGrdC9lK8ld4prgr?=
 =?us-ascii?Q?eltcxFTd+NgJLUC3ZSx1M+ncoZrVX7XHiBiF+QwpCC6BMLanpMy/ii/Ge34c?=
 =?us-ascii?Q?Pt+ddI/q8YmnGv3+Wo/e54CyKp9DE+aALe+ck3etJ3c38lS2a6mQ0c2bWy8W?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e288a7-00e3-46e1-cf0f-08dd0d905f41
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 20:33:08.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQkFXrVsX95cZplDW6SeDt237YuEaDGLBF8USrwxLvG+50eIGW3Vyh/Jh60z7SpjS9pGLahbTgyII6wyPTs1Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8556
X-OriginatorOrg: intel.com

On Mon, Nov 25, 2024 at 07:19:53PM +0000, Alan Maguire wrote:
> On 25/11/2024 18:47, Ben Olson wrote:
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
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> 
> (tested on Oracle Linux which uses lib64 for libraries; specifying cmake
> with no arguments did the right thing and "make install" installed into
> /usr/local/lib64 as expected; nice!)
> 
> One small nit I noticed, sorry missed this last time - the README
> has another reference to -D__LIB:
> 
> "    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF .."
> 
> I think we should probably remove that reference also, right?

Ach, you're right! Missed that. I'll add that in a v3.

> 
> > ---
> > 
> > Changes in v2:
> >   - Included the proper built-in CMake module
> >   - Made commit message distro-agnostic
> > 
> >  CMakeLists.txt | 19 ++++++-------------
> >  README         |  3 +--
> >  2 files changed, 7 insertions(+), 15 deletions(-)
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
> > index f9aeef7..0627872 100644
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
> >  cmake Options:
> >    -DBUILD_SHARED_LIBS
> 
