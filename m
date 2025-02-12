Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F017993;
	Wed, 12 Feb 2025 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321427; cv=fail; b=R7R8LK2llr/rpg5RxePKjEXB2sTCnenIyb1KAMaF6QYG0wQ/g+btmlVdz7vfBeIIYzVW8OX6tpZa2ox4g8coAkVPsjCYYeRqq6IIgCeGuavzzO9QfP6t8XV8LjaTDL6Bq0/wf0Z6GP30x2fpTiA0K0CH2AbbRBnvoxk9Ag0V82s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321427; c=relaxed/simple;
	bh=UDsurFwIcDxIGqPaGXMncQYqZR1vT5Cc8g6oXbZ9Fw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FpWdyBfk0s7bdgel9NoUIUBVKamBotwRA/+VqLqt3wmrYFcduDI2cgQveVh1nyo1pnccrIvTk8u01kLddjhSnwprRuJoD/BVTycMFfLVKnjfq7Ed6o5fs09FRWvsT1bRQk/xFwOv/xZ3YhLyVtc13e5CJPeGs+iJx0a0oxkUP3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UtUXjcnc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e+Wg1IAj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UtUXjcnc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e+Wg1IAj"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLfxoc019624;
	Wed, 12 Feb 2025 00:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0z3VZ/JkCHFku6k0dsdZrkap2DT1LavkzneFXQvP9Kc=; b=
	UtUXjcncJOQWPEFAGgysXVWlxBxVWwxnUspJxZ7TDLJirJTKj0vLyo4OqVbiFlFm
	YLaUN6BKTCK2LlANy1gIHVGdMguvNaFUNjffWF0cp05rCktpTqiHbJomJWd63iF9
	4g2kwVuiX+dL7vXkFrdQ95oW6NzeUMif0nBiZOyKJhy38PbdJGNmvYywYMORNt8y
	o9v8K3kw+zjRVdc6Ucoj9LxgdhHvlmQdvQi2+A364F85PqhbEpht/79Jy10b3yVi
	PAm2/uu7iJDYb6ZqkFbWyqNcAvMzPdZs+SYHTr81309uGZSEjP52LqNgsxuMLpZz
	Gd3NgTkHNIDOGUrt5lttgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s3xdd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:50:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0QlxZ030485;
	Wed, 12 Feb 2025 00:50:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p6301evq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/h3yLWZNM2irkgxcY+jBru3kdW92FpPNeigtxkVf7CKZWiWY7WgpVaXy0qlJC8XsrY0QyWdQ0hrvVvFfhq8lWP+a0H8kZirdJLxx1VdTfnlQaXaL+3zmYg/EKkWaeZjjGZb0SUy4KY4kfYgW1ocEzcjtpOD/tAO1TUM2Lai9+A13V9+mSU/IepgnawCViOVRizPDSAdk8hstA6z4ywGe6hzh9NYitfarT3IGl6Zgaq3Mbq8dYM+0lv315L9mKdj35+nMVpICoaUZykGR+xsLOsJ80d3b9U5zAaeRTGrE4aHd7um0HB+wEscvxmRIZTWaOx6UrK9etb8TD5UYsxWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z3VZ/JkCHFku6k0dsdZrkap2DT1LavkzneFXQvP9Kc=;
 b=g50O4rxkqB1Uin2a1p2wNTmhAoXYW2D90MWJGJGPIrBar8uG0eAM18V5WqUTPnOqoVv66poryT3FyYm8pUycsMbghtGxCNzlOPjmlfO1ZHfoW880LwBkJPoa556S/v0t3KEmEISy4/Vcb9y03ziJXpZqqnoW0klggK3W+2JEIQAbBwDYBCZjZXLLiprB58eAeCgCJ9oY5S4BbZKfL5LPA0Lx4YaMuB+VZpuixkvt3HdbYLFoDCEAV4LZSdw9INLJhSMO3bytBw/YWZmbnkmrUgLjNWE2vhwi4PuPyU+uK9fu8SbM15J/9i3VOriH8QZbmNKlrtPw5UpPfbrZObLhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z3VZ/JkCHFku6k0dsdZrkap2DT1LavkzneFXQvP9Kc=;
 b=e+Wg1IAj0Zb2/w2Eez2MmgNvv3OmHqkG3kcblk6aHP/RULo1wIXxbS/34vqMKAXYWgOWFWmOonMYSyILALtWwwKbF34snHrELdswzwYlwCwakt/to5HON+Dgnn3XWiVBDU4NQS3if7EGNBycUZBpvEvO8J663vaQll0NYyrwzNU=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 00:50:13 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 00:50:13 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 3/3] btf_encoder: don't encode duplicate variables
Date: Tue, 11 Feb 2025 16:49:58 -0800
Message-ID: <20250212005003.1413091-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:e5::9) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce21467-1118-4750-b162-08dd4aff35b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lbBRwl5FWkfHsg5yrSNU3ssT6YItfuLbPP5YWy/hNWbMHF8AU9AWmqPdqxbG?=
 =?us-ascii?Q?ECZ/A8K8MWtUXW+GK4kQXel9AMxeKkCvegdgKlUzz6npyWt5GZZBIY1MA92+?=
 =?us-ascii?Q?C5mhTEDzOCuVxr1dkv7ie8kSYs2jgYD4+OwTsa3yCPJAXVjnZwZf3zyDOVsj?=
 =?us-ascii?Q?OBpIaR/hv6PUUMF/65aib0f716Re9ULoHWUsJJrMZpH44XS+ccEckOIHbaRu?=
 =?us-ascii?Q?yGVMYU/nR96hQtqn32GP8u56m+iHI6OVECMawDrmFnDn1MzPnEWpDkc89emL?=
 =?us-ascii?Q?Fg8ibDKF9Qgl8TNCoWIjkB6d14E7B+EKaM6Szx84hgWx9GkYK07gq9IjlNFM?=
 =?us-ascii?Q?1VdYNBq++CnfcY2Sq+160PT8fjOjiZst7E6DgywVOp0htaN8UNkAj2s3GPOa?=
 =?us-ascii?Q?0UvzUWKdiVUGL4C/JkYVNngeJLDzjOyMJo4mWzTV8ipe/v8NH3EUEbrKWQpK?=
 =?us-ascii?Q?2yXn2MBPwvQ5/sKQ8L9sjuIVeuznk5Qk5KdybJ5C7D9AXf7oKPh4MSpI+8mz?=
 =?us-ascii?Q?jBUsSSTytD4HdOenv0SE38g7Yo8rITbeKSmHZpowXUpZcZLOztfPQRz/5lN3?=
 =?us-ascii?Q?A8cxfWzNaN2GAQ+Dj/IwEjmp0FT6bh+rmVYeWYk1izFb6wrKJ25JHXrgRJFM?=
 =?us-ascii?Q?d9fMsimLc5B4kvuqaexhqDwwSkW49xMX//K3T2sHwUJXe+IUKVVpekAn1VBC?=
 =?us-ascii?Q?C+AkVNu9LLHvGBpJiS6n2XYmBWn1GQotuGUY9knM5yT8RQevJZ90UnZbDVMD?=
 =?us-ascii?Q?7DcwGn3/V+Yc5WXEGSffQFrBC8gkopbjPRSJOmPShGxaPUpZ3k4F3yyUcPrh?=
 =?us-ascii?Q?0Os6HYS7A+g6tK0JEYuDCu5rGuARUPfi3my10T3mwEyllafbDLIioIvpsm9u?=
 =?us-ascii?Q?Coi/gqzzIvc5osnq9ZdIh6TXDDGdDdNAhJaRvIfwlGtxP1MzjWgIGPsgfi8S?=
 =?us-ascii?Q?6dBTuVVFW3IZoognYEp2iWFXSu0paCaEdHr0XcQqHthm8jsUEcf6tlNmMy34?=
 =?us-ascii?Q?5tLlg9cgZep5hAc1urfCedu0JOUi4hf7msEgOk35762qxsc6AG6WpThVTPfg?=
 =?us-ascii?Q?f6T/acW9lmu8Q40II1fd0x0Au1fKAnqdJZTrkEVdOwB6fZ5lnPO/EZAV4Bbt?=
 =?us-ascii?Q?yFIfBhkInhb0waXkDY4MktGhEHxOy4nKu1nMJ8bI6oifk3hFCs28mnd9yHBi?=
 =?us-ascii?Q?O2IHGyDu5qp5JhqlAMwXNvzeF1nGYqxaJl+wEIHu6Rm7xnA4Jn2WV9Dx/qLS?=
 =?us-ascii?Q?ef6FEmGFvkhV7V4AK05pXiZPDpOICAo/ICSISlnlxWtyZNtmYabyndtL1ATN?=
 =?us-ascii?Q?TnE70+DN7zUVctqMd7T/sRJSZJUPP7ozJWzNLL1Ldq9KgfjYupHjL8cae6UZ?=
 =?us-ascii?Q?0NKNnU7N+Z/O3TPoPGOa4/tzldKR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FVrzIcvbWNCPbx+yxCyWX8eXeRpXIRMFbVnhQEKRGslgARMEVvSoC8jgxD/w?=
 =?us-ascii?Q?Kx9nc5Z5nvgo90hamKGaWNU1Tuja6OgCzKiNjVLCWhPOCNhmcReknVTWLwKJ?=
 =?us-ascii?Q?2mubHp0f1eSugDHlvtaOBj49W3wFxGB/htxfQT2NBo2AlMaHSnH1IlYdaqfw?=
 =?us-ascii?Q?SMg8AYOr/OWltX0shtgP0eNEgleoV1AaUTH4PdOHU3D2NjdMiRD5FTmYhxoA?=
 =?us-ascii?Q?jJwIC3eKTG7PH2AFen/wzwGCbk2BcR1NINClHax96doZTmu6mHaK6+21mx3X?=
 =?us-ascii?Q?GH9G6r273vfdponDakqdW4yELHVV5I6DRIFLBqR697q2TvnOherCowdU3CBP?=
 =?us-ascii?Q?GXyefHmWPF3/Lm6eln1TqlT5sLndtpiv8PXj6YGYxuFSbSx6br9bE4XTAb/4?=
 =?us-ascii?Q?ehlpLGdeqY7oyM07ft6lirz9nCEICSPgshEPMu78655kHMOpXbKOBM5t5KMV?=
 =?us-ascii?Q?agZMdnCOI0zx3bsneT+x1ijHKQ/lPhQjfICXXZxt91/3/BNgW4MAb3aWSnSz?=
 =?us-ascii?Q?B/rs/z1EsXEgjZBXK2v7QY5l+fK6WxfgHTYAYNm+G1TuiQ6SmmRbipthTu1W?=
 =?us-ascii?Q?AmWAUq2CdSp2+t/1ngwDwCtbSrfmlwyR5FPjvi43UNwxxSRz1e4TJPVbH2nm?=
 =?us-ascii?Q?+xzQGDmEz4azi9fNFa1yQnQ5PHvqMDCuuyM1HAH3xbLYWIKYTCJXjQxQJOL4?=
 =?us-ascii?Q?CEn0z+/xY05pLiawWpJSuAFFvF3Fvu9iywU8vTEhxbh08C5jBtafW/XU8n3s?=
 =?us-ascii?Q?tkjN0MuC1bBU1PgF+pSMcvi4CMq6yqiHsxzMi/gAdBbG//yrj8oMV6FPHQ6N?=
 =?us-ascii?Q?cXbK8TNgZRROI+3cLluckdFOEDE8vUkFMyEYVaifpyRthzr6wAPb8XuyKbTe?=
 =?us-ascii?Q?/dvN5cZLuEmdbGgoqxJZFfNMy1fnWodXzhY7QdMoKIIY3C8QWMGFVt9CflvY?=
 =?us-ascii?Q?ff/ZI9ovqq0eq65slIwijslEGevd5gGDgwH9YrIFn2WuGS/ZlR+lSS32Sqe6?=
 =?us-ascii?Q?Sb8Q0+XhAy4Vzyj8pBA5nDySSW1GfPX7RqrrDM4TGXuTPyzOMtzY0fb2pvNC?=
 =?us-ascii?Q?Uyh9OyJALogVymhcYzhDN5l3rtgZPzcE0IG41Y3d1Gzmqk///xZHn4ScC98j?=
 =?us-ascii?Q?aG54O1Xhb06SpTiYQYLuLY6xBUu11ll+pr3Ic+pXvX2Tg4qXmnrgf13BwWq/?=
 =?us-ascii?Q?V33fBRazyNttf8WTNS2MhAqpDauuZPJB7ferlDhq3ndN32aPqWUgkpFxduTs?=
 =?us-ascii?Q?LGj3Z7bdXvamZOqgh29hEjfDV1xbNyURn3l/2iSjV+FdMUfsPZQoFDxpUMlC?=
 =?us-ascii?Q?2H6iM04sAXDLu9SU3fe2zZyNpWz4bxOjnaKx+oaOsGo6Us9PRrIZnAFF2a9g?=
 =?us-ascii?Q?lxs4O4TTAQeNzNoBpNlLmlokoiF4PyHJGTpb5lRPHLsJWxCOSkXgXKFDWOov?=
 =?us-ascii?Q?VEK3TptdnAiKOflYejuSa+qF/5VcloKsHDKIjRA+zHnps9lwhUnLNYvbCkUh?=
 =?us-ascii?Q?JvNprRnbCsQY2bSSBvJ/Ms3J8XdJdWUixZqB5pUnC0v4CZnwIQtoEvw1zUaH?=
 =?us-ascii?Q?18Xvwv0SiL6MD9CtNaQtC35Eu8aXDolN/cmC+wXolAwnWrgGhtKFsMnyjGk+?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cx9ZOJ5I4cerTxwa/Ca8cHU53ad7hPcxcRyJINTTeqt0rs6vg9FpPX7/ezJtBxfyyBw/+SfgCs3LOyteVP9lu3G/vV1d8Ik6FthmbfHJR4cO3qKME2V4FeRXPVWI7jS8jbKA0W9eymIFIRyil+ZycZbAHgpNDmhOthk9svnVRcarqB5TAh81dnRaGUa580dRD4z2RlenJfERZs+tfVt1LsXDoDyX4RYCs9B2KY+YbU4KEU1fAxfBK6QAR/LBJpKxY/x29js2E3H5HB9T/n17/I7+dAIyORCVis1UFgL+sDpSQMiRKoykr/8juyReYbOPlK/E5l9rQDkZHCwnYdgUrrwxPFDwka69IDE9sY+d/aTSncneoKr2HCT/a5TiIKVaccnqo1Ny3htN7myaekidFl2OE+sttHQnhPJA8Oh6QQPQyrl8oe9KSCbb/uZFxen+QrQ9SaSJ7A60f1vcT+cqtAFjgIeKHOVVQgZBkhYj8BcLTK6DCyBXIPTYEfq7qZkOGx+ijh/aF6VNKtFQ0zpUY3p0F0yVSHmNopdTFaow6qJd1cDcwxgrFI+3HC5cK+PE19pinoWdVtALqp265NVfFr/LGVr5IehxbZMn4f2xm2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce21467-1118-4750-b162-08dd4aff35b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 00:50:13.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oGrsWl0VcWEVcLU0CGwgI0+6w7l22EeFofUNM4CsMUEuDkW9S5J8s69ajP1HOBdw9VFOSt4pDxuJlmsmEK98d6ms8IyXAKMr3+Y6p9h5VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120005
X-Proofpoint-GUID: iYWtm3rtSVM9uG8ShBUQPLKmwEgh9NBw
X-Proofpoint-ORIG-GUID: iYWtm3rtSVM9uG8ShBUQPLKmwEgh9NBw

btf__dedup() does not deduplicate variables, nor the contents of the
DATASEC. This is reasonable, because there could very well be multiple
variables of the same name & type from different CUs, but with different
tags or DATASEC offsets. So it is up to us to ensure we don't provide
duplicate variables to libbpf.

Unfortunately, there are some cases where variables are declared
"__weak" in the source code, resulting in the same variable, with the
same name & type, at the same offset, being encoded twice. The DWARF
information does not encode any difference between the "__weak" symbol
and the overriding symbol. And even if it did, we couldn't filter out
"__weak" symbols, because they aren't always overridden. So, we must
deduplicate them.

We can't guarantee that the types are identical prior to deduplication,
but we can at least verify the offsets & names are identical. If this
happens, simply skip the duplicate copy (or copies) of the variable.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index d989fbd..29b2054 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -869,8 +869,36 @@ static int32_t btf_encoder__encode_stored_vars(struct btf_encoder *encoder,
 					       struct saved_var *var, uint16_t nr)
 {
 	int i, id, annot_idx;
+	int prev = 0;
 
 	for (i = 0; i < nr; i++) {
+		if (i && var[i].offset == var[prev].offset) {
+			/* The offset of this var is the same as the previous.
+			 * This can happen when a variable is declared in one CU
+			 * as "__weak", and then overridden in another CU. There
+			 * is no indication in the DWARF which symbol is weak,
+			 * so we need to deduplicate. If the duplicate is the
+			 * same name, this is expected, and we can just drop the
+			 * second instance. Otherwise, we need to raise an
+			 * error.
+			 *
+			 * Ideally, we would like to verify that the types of
+			 * the duplicated variables are the same type as well.
+			 * However, there's no way to do this without
+			 * deduplicating the BTF, but at that point, our type
+			 * IDs won't be valid.
+			 */
+			if (strcmp(var[i].name, var[prev].name) == 0) {
+				var[i].type = 0; /* Don't encode corresponding secinfo */
+				continue;
+			} else {
+				fprintf(stderr,
+					"error: encountered variable '%s' (type %x) at  offset 0x%x which duplicates variable '%s' at the same offset\n",
+					var[i].name, var[i].type, var[i].offset, var[prev].name);
+				return -1;
+			}
+		}
+
 		id = btf_encoder__add_var(encoder, var[i].type,
 					  var[i].name, var[i].linkage);
 		if (id < 0) {
@@ -894,6 +922,7 @@ static int32_t btf_encoder__encode_stored_vars(struct btf_encoder *encoder,
 		free(var->annots);
 		var->annots = NULL;
 
+		prev = i;
 		var[i].type = id;
 	}
 	return 0;
-- 
2.43.5

