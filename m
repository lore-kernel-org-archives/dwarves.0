Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EFF1AF0CB
	for <dwarves@vger.kernel.org>; Mon, 25 Nov 2024 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560587; cv=fail; b=I/0N8m2xy77biGs3kCyTD2i3Pf5qwXhQtQAtK3+VLuQcGAzS3EyujBiaO9MJsyFzSGpZnym5N8aX82amMgipnKLrZ9tddwu/FpaQYPFYvoHmfYaVh9CKFeKydl5jRK+X3QTTgfyZYQExPcpLR/rDQWGwIOxqnvUMbWFcimhaEcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560587; c=relaxed/simple;
	bh=KYwwlMhFpWN9aU66CoUDhRAdonMgqJNjQwzIvbCwQA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GQMFWMfIm306CAxbhFXTi/UIChQ/drBi7kKeyer/4h5I2yfVTA4f/TcC5wxmfVwVDhncrD3RbivOLW3NHcXPyY/lfbUdkXeGy4unw4m1unLYLRaBMtWFyTHYr0T17ZUa8nU/kd1+3vyl+O51BVT+YCITOxNJ66Q5WVqg/eFsSS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoM+pZV/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoM+pZV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732560586; x=1764096586;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KYwwlMhFpWN9aU66CoUDhRAdonMgqJNjQwzIvbCwQA0=;
  b=eoM+pZV/N9e7CloMsYbqpRidN678mUMEQeor6bgIGUee8uscYXE4cF3l
   t1Be84ZDCLeWuy7hf3DY1qJvNUK4OudqVA1gkQu2nJTkZBJc2529+jZOC
   WKFpLSgek/yDSgEf3/3lf+c33fxavLeagdCGYT4Zfp7JQb+g0bHmE93B1
   OLG1uDYn2q/fpaInjmi//uSHrtslBHVVWbGzG/jNJlKwAx5Lyv0W/suXK
   m8JG2k5TZqoe16xursufZLbV4HNS/QStKm6xTLcfMw1Eiq9xYNUNMrbta
   Si6D6cLMbSLYiltFaX4IF+6aAQ6Hpy0+NVraDy9lv+nG5G6Te1nqKOELj
   w==;
X-CSE-ConnectionGUID: G9fIMcyZSmueDOBKLRoSeg==
X-CSE-MsgGUID: JjFqaDRrQRWFFKEtjH5OyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32630030"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32630030"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 10:49:45 -0800
X-CSE-ConnectionGUID: eyXCXQIJSY+YUb9TeS+uYQ==
X-CSE-MsgGUID: K/4IkpBrSDOTsmesUvZzBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91543289"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 10:49:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 10:49:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 10:49:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 10:49:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSlvLq3rQD1uXaG6C9lVhHJvjVTcfUcE/zUqaufbTZADj98vXseo+Iyaqgh4dAy5o5ZTWqVe26EFdwyk2LDtLWINvrBHVHj6atTXUguF5yHWoU4bPaKJwkSZ7kF4g7EOF6wNbzBDK1gn1sLn9eIFkP2hj/AQA6cNVfYMRS78Xs6+fthk2eXXh2MkISQh7TlHIJGtAuGcA8o7cyDKTo1AXmmMp3WOPDwhAaG/s/jdVx2ej88VXoMGRe1meGPLKPVqH0o3vteOz7xhg3LSDsYLQXodPh6iDDbk22CtO/y3D8Z7R+q8OGKWE1FGW+p/pQy4EmaNcPb57drGA9emIdkEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ACcVOTvRTn5WrGNWqt9fYULpCBsdOOvGJhS5mRj+lQ=;
 b=jpFsEZp1hn3qKVnFS6rcGhPM/0M6lWGdj1oj52J2PX03VSAxlMWzhbEdlNb/UZDMbPKmTX7VLCngtffbPpdXCmjBdSy2LgrYqeKCC0BYs02+4E6q/YvGAEkT7Opun2ILlfRH4L7p4Slm4tQgXsn4efdWwx8+SN9LscaoaPyS/87q8Deh46IIvgnI41T3lqNTy1bC5/S3VCbRRSw1FhoPg4FuCUDGoI7ZX77raE4E/jDD0BEfVA7g+D8F67a5fQpfpKeGCtGfJ/mSNOPzuh8YK1SUeacZxt/lVv0faJigM32pa0/kubTZ5CnAsIl8KLvfFxshajpalU0KaeYzMO95Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 18:49:34 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 18:49:34 +0000
Date: Mon, 25 Nov 2024 12:44:34 -0600
From: "Olson, Matthew" <matthew.olson@intel.com>
To: Alan Maguire <alan.maguire@oracle.com>
CC: <dwarves@vger.kernel.org>, <acme@kernel.org>
Subject: Re: [PATCH dwarves] Respect CMAKE_INSTALL_LIBDIR
Message-ID: <Z0TFksQxRUvEucrF@bolson-desk>
References: <Z0SdF3u92HMAu96S@bolson-desk>
 <f52e76e5-457f-45e7-b9e3-77ed273cae3e@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f52e76e5-457f-45e7-b9e3-77ed273cae3e@oracle.com>
X-ClientProxiedBy: MW4PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:303:16d::16) To DS0PR11MB7444.namprd11.prod.outlook.com
 (2603:10b6:8:146::11)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|IA1PR11MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e86e7c1-e123-4558-696a-08dd0d81e77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LVZo43TotRrCwlwruCiygKI39ZvRQkeFfosNBN295+enKFFmbxnNS3Ui8IQV?=
 =?us-ascii?Q?ovb+ygsl4GZYmc70jrIyktzX7excEtETvIgUHDu+eK2PZdmmlgCoZIIjsmN9?=
 =?us-ascii?Q?gG8hX+10hENYXwCh9AXdnqboEce4YNcR4VnQus0InZXH9srsmGk+MKcXNuJo?=
 =?us-ascii?Q?kzaHCpmq1udhZ4M6Gsa9bS1wIppBhiSNKqV5yFoXy7CwlOgt8y/mQQErRdbO?=
 =?us-ascii?Q?FNVjdaTaQKTiOH6g7QCMvSr7rSNtzr6x1fVM9w2EUcXnxhGyAH3MqOfZtJU7?=
 =?us-ascii?Q?EmAdX5szHw5oL3n1isDjrkuceHrEq4iK9+NIti1AbQSTq7zi0U/6bL+s72xd?=
 =?us-ascii?Q?7MrrRjdS2/lH3yHxRQ1au/ihNrUEvQVWptSt6OZS3CWaC39COnCxbIDBInPf?=
 =?us-ascii?Q?Ahc2pNLh7RH8Vpo8v7klanYG1yIlz0GQqWojETXzDkYRcok11/gBnea/MFPm?=
 =?us-ascii?Q?T1fKeR+lZWA5GgDibIpV2UWSXFoVeUHXq+QukSjB13S+xkLSkD0ex6FPGaLf?=
 =?us-ascii?Q?vir38cLPouOB8CDFgRTMEizK/I8fxpvIJVTa4aI2Il0XlWpkG39nBbpJoPCy?=
 =?us-ascii?Q?pueGvtfQQ4vdKMoFFiV4NBrat8sPTsysvxHz/12oDesESefBRj3254g1A+G3?=
 =?us-ascii?Q?QC4KQz+xfWnBQIkrXYfd/kzij53uqfmo7Vrqw7NkSXphTn8jBu5r1yNQNfji?=
 =?us-ascii?Q?OW06iaXsYulGJdZLZZmW2G2fZlHkUlxkVC32hPXazU4MCAt73G32fwWrEbPj?=
 =?us-ascii?Q?vzNqzZYDlBgbLMwBixoM3mrUfkuUa31zmYpc7DQtGW3IhAHdwfGflzn4gY9p?=
 =?us-ascii?Q?j7wDSK7y91v/kDjT0fmbEFDt+8QlWZmtJ89dd8yxuMaGslchd66p4zMxi5Xy?=
 =?us-ascii?Q?9/ZGuLyheeY/p2BrLTBoMAKKFEJc5RQsVQPTRsTkxml8XIRsfJRNcOabg8e3?=
 =?us-ascii?Q?eKSb+pXQBAVk23Ngse59WYA0fx7ZqZeh01AsBuCeOe7oNVqIWWdK1h/xRTp+?=
 =?us-ascii?Q?+xEmYlEenDjx26v0ZIUG4pPmcMYGKbndAPoqIdV3rVbrGQkkEvyAODHTqBsK?=
 =?us-ascii?Q?MZkp3WjBjFCXLvhxxkpvVsnoRWaVxoGq9l+yCBTVMxb6JEqeR7c+2WzI79nk?=
 =?us-ascii?Q?zmFx1cTcFP/ALr+5ymq9l6tyjABKtthttSlkA0l1vyoeLcbmrjYsNjCmS7/J?=
 =?us-ascii?Q?nzuR2q63o+UuNfzVL7aAZdCYrxQo9+jFvMP3HeeKS477UExC804f2AbboVOX?=
 =?us-ascii?Q?NkKnNBnQfFazXkaSUi8sRpuDlmZqY9dDUwp2gtlPU7go5h9neqMWwzzE5eEH?=
 =?us-ascii?Q?cZE/0JwrAo3141cHaHQd19gR3LwcChPzfRw1QbAG5RzdLyNlpzc/YrFQyKsS?=
 =?us-ascii?Q?MwlawQ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zqNusR7IGA3Nsh/RyxSNTYqlSa8AsfW6+qe81y6zHl4rZzRa8brTl+1yEFfR?=
 =?us-ascii?Q?UNMPZRXSNyrrgUi/rfTOx5BvXzSiUeKWxYA/fYnt1jFKSYDSfPNISuuEZt+u?=
 =?us-ascii?Q?BY00sZ+qFZmN7wWC2xb0a4oreLUJf1fnwkeIDN8MrX3UixI/m0CroKXTHFdR?=
 =?us-ascii?Q?S3qIGGaJyQHFbOBROFWHJPpr3hez8Lpz06We4r36iPVn0OLQs17BDYy+u2YD?=
 =?us-ascii?Q?5nrWaAGvu2wBvUn3vjPAQM3Gp9Lg974YuDjS1JRJ+9oinYccq5h0m/pG4b5G?=
 =?us-ascii?Q?fcDIDiCo5UnMScbGKWEv9UEnVpiihikaCU42/SFTNR34Ww2SE/xD3AhZhJMQ?=
 =?us-ascii?Q?mgZkscUBRYrhH8cYJODQtGscacv24A2c9I6U4YwdfM1186gu4LqbXc+VokQ5?=
 =?us-ascii?Q?rZLMY2bMnHQbHWCbo6VTES0SxfOC/E3G3qvcqWfrbPjA6xoirpyfmGRJB3n3?=
 =?us-ascii?Q?/orpQvl/HkV/1HbWp/Gtqs4BJag4X7EipVatWkNGanCYDKV0XUmA/jypUT47?=
 =?us-ascii?Q?of6/MQq/PkkO69+wmGwBq6l6zlUz0LTGIRCrHwKXj/KgcTHZjFqEHPIqQHIx?=
 =?us-ascii?Q?uKwEM74ZZaLnNQ4vcIJzWz39XSx2hQKreGNCVioTsQnIuV359+t4It5R669y?=
 =?us-ascii?Q?t9TiVNbCkjXJmnwolWE8+9hlxmKJoxG5BZysxnNHwaz8q62rhjJ7IJxuxAw1?=
 =?us-ascii?Q?TjlCwI5rYQvMYd4VAtNU+vxs0wCjzPBH2Pzi77zj6QvoY2BUsum9YlbR0RLn?=
 =?us-ascii?Q?kfLHzWMQBEOGRwVAF9zKT2u0YO8sgXUnsovQq3SOLyeTcMwkPqjYX1FMsKeE?=
 =?us-ascii?Q?y7vTmZLyPqmehuXd9TFwt6FamZd7++0saJDl8gRZoHASXhi1o4PSbLl4AFUl?=
 =?us-ascii?Q?yI02iDiECuqfDsrL/jdCkrvkr8Ataxsh4da/LJ6plNqGy5cTZiIAidE8h1mX?=
 =?us-ascii?Q?ZRj8xN7HAAZIiPKAn+/jHNJvIj2e2rZ/czKDtVBsK1heVxuZmvIqVG8qS95E?=
 =?us-ascii?Q?diiKddZHWjWWfh1hltgVm8nPTtwt3Bmtc7EAXFIGQjo6NTYryHYfZEBh00HZ?=
 =?us-ascii?Q?4vcDHN9pktyAZEIFu4Q4UnTjXjLxQ+6eqtjSNxyG4nYwYBb/1J/CMVopWAa2?=
 =?us-ascii?Q?vdrfUTf4o2ChjQPg+VARpmBvlcTUOIh6/Cw7J9bH4vJKEb0EzBPv8A5Uan68?=
 =?us-ascii?Q?6DJOiRMAN9zwIQc/5gHdEG3JP2OM3IAySqGbwSoRY76vyBLDLi5jmXgZfdM5?=
 =?us-ascii?Q?o4GJk+GupOqRJ+SQAxDbGeheWnwcCB7qAofyXA7t5436aTVQBojR5RZiaxDc?=
 =?us-ascii?Q?Jc2ArLFlGW8RTt+Y6G5euEAvNDhmld8rjhuPXX4j+I81uzNH1dF3i0LCCnhu?=
 =?us-ascii?Q?ACaSLV64rz786HXuHkA8HT+dUkrjDgdeNhIvUrHeBGprWI81563RR1lgzLKM?=
 =?us-ascii?Q?ClrTxz4y29N289T2xF7i7xGzvRzCmDWIh1ofQbFwthHt2WUi44eSkO7uwys7?=
 =?us-ascii?Q?TVPYcP9vKJsITjo7BBQBtrgaNHtdDtfwkpw18rYj4S99g68xWVtxMzGJYmDV?=
 =?us-ascii?Q?iX9HV5xzYCMJdD6UKv0r2EoiXxuBc1z2u/MXnVDigpMNqd14AD/nGmsVKvFL?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e86e7c1-e123-4558-696a-08dd0d81e77e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:49:34.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f2caYIK0e+4pApE+8I3A5j7d3m1bAIWdrnxGPMQOPr8Kv1N6ko1/D/Ptw97WyYl6Ro70p03hVc3Fv/NTmSYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com

On Mon, Nov 25, 2024 at 05:04:53PM +0000, Alan Maguire wrote:
> On 25/11/2024 15:51, Ben Olson wrote:
> > This patch changes the `cmake` configuration to honor `CMAKE_INSTALL_LIBDIR`
> > and use `lib` by default so that installations match the conventional placement
> > of libraries. For example, it will now install `libdwarves.so` into
> >  `/usr/local/lib` instead of `/usr/local` directly.
> > 
> 
> What about distros that use /usr/[local/]/lib64 for 64-bit libraries? It
> seems like CMAKE_INSTALL_LIBDIR does the right thing there also by
> default, can you confirm? If that is indeed the case, it would be good
> to amend the commit description to not be "lib"-specific, and say
> something like "CMAKE_INSTALL_LIBDIR ensures installations match the
> conventional placement of libraries - /usr/local/lib on some systems,
> /usr/local/li64 on others. Otherwise folks might think they need to
> override this when they probably don't. Thanks!

Yes, it should respect `lib64` - we've just tested on both Arch and Fedora.
On Arch, `lib64` is just a symlink to `lib`, and this patch places things
in `lib`. On Fedora, it places things in `lib64`. Just noticed that we do
have to include a built-in CMake module for it to work properly, though.
I'll add that in v2 along with the commit message change.

Thank you!

> 
> Alan
> 
> > Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> > Signed-off-by: Ben Olson <matthew.olson@intel.com>
> > ---
> > 
> > This patch addresses this issue: https://github.com/acmel/dwarves/issues/48
> > 
> >  CMakeLists.txt | 17 ++++-------------
> >  README         |  3 +--
> >  2 files changed, 5 insertions(+), 15 deletions(-)
> > 
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 8ca1bf2..b2c8057 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -21,18 +21,7 @@ else()
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
> > +set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
> >  
> >  # where to look first for cmake modules,
> >  # before ${CMAKE_ROOT}/Modules/ is checked
> > @@ -84,7 +73,9 @@ if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
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
