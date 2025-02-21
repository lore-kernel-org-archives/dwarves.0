Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C43594E;
	Fri, 21 Feb 2025 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099916; cv=fail; b=eHls3RLF93a456yuivORd7nCDtWCm01UuQH1urEQjCuhNYAAsvM3vKEHtgxmj2Bjkv+PzC7QWbjHEf7Bfx6Ob6cijGP8Og4OhqgGdjKhp0tKkRbNtReofhFGNDVLRsmzxlznBAx1X2oNwj30kAf4Ou5k9oxRY1jjenl/sPMC13g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099916; c=relaxed/simple;
	bh=kurH7NV9InOZYDEI2aj9OCOI2SpnC/eV9HdfpYU2gMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=QdCyoB7DmFcxguHQzQEzWAfX5tKRC+AyBgGwj6Ted3wM9jPXnL8ua2xsCJX8wh9sYOI72JI2o7oXWAqAGclv+0zwrM1fZNb96GMW+fVQygIaGnoFBCvMXN7Kd/yHPLExAkqA8B2YNG04kFXF7ZzY/zKfeh58QrCij1suV6P0tNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mpgf3+1Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ArMr0i7M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mpgf3+1Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ArMr0i7M"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLrZoT013967;
	Fri, 21 Feb 2025 01:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=j23KfGvck23upm0r7I
	Ed2ibNDFC2/OVd6EcON16j7qA=; b=mpgf3+1Z4LYF/fiO5gdLTbo1MgR4tBkIAF
	7VbkX1H5sna6Z6V5R6S0zCkPosCznXmKZdiXw5s3pXYHn9BY57AXAJuXelfuhq91
	PwGtuo6qJ949dcoNjenBOF7UF4CGhhv0o/1oRBXBTzOynEEus/pFuiJQm6VliXpx
	5MzvTuVZWgAn/J/qSoD7El1aBp+ZPea0VTuWfn9OOOGF1BLLW2Ps9hGc9IaJqiYi
	96fUCOcj87OOBcr+7ez7bfCkAN4i93jdqW+dj6X2RVY9PefHQdzc7d93/Zh7PYa/
	uVijLqAHMydhpR+XUPBH5sSSVpmRkzKsnOPIWpkKmM5GCgGNS+lA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nnepj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 01:05:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KMs9Ub012111;
	Fri, 21 Feb 2025 01:05:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b4qun2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 01:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfAFw66AlKuqRJmLGChpb3qBocaZvf4XogNoa5AE6MiP8FWOqP8/N2n8gp1ef5lMAHuDmoyzCa/3+sjxLoE2/2MGBM/uczS0+z0JaUn0HjwIBsc3U00WID+mcr7mofxS/hFJFaXW9dR4I93PVNF2Xudz8tTkZJBI2BThc80f0r6U4rfMg0HqA/Q4RsllPyL6S1BfDR0bdgbBdZU4dxOK1IEfOyadi/oGVapZQSgUe/Fz0fiAyID8W6W0iVSQGBqWN14Q094AafV9zva/EYfcrjQkMk30a1zTPQuVIbqlUfSPoVSU23GFo5bjxpyt0y3hX5AXvsimdBK7bt34pOBLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j23KfGvck23upm0r7IEd2ibNDFC2/OVd6EcON16j7qA=;
 b=IhKJb6hw/dtWl07gOmlRpjQjH4+vHWaUafn5Uh37s3PULVPQEDbnOVSbSxlYClkPZ2u4oxJFqgZxeCEyxUfrU7Vdxx6K+rs2HljYpTf1Q0Q9FQkWjuOWchBCSnvlhPAiNB+USQo6G/jW1xGOrCbcK/CPQbi30bzAODa0BnxC9NEzbgRZdBdgyoKVJx200dpQewz2bXf8wDVM3oT2iSnixZ1+xRmaYsg3Q5wkM0q+OpG7lR5Lw62nm9xOyE9GM6qY5OOtZakhoZTnT/mcHCtshUBjK+yuWM/AtKpS+1OWlmQdxfpXEIsOYmQ+DgOOoB+YTNoTWcauCC48aXU2cFFEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j23KfGvck23upm0r7IEd2ibNDFC2/OVd6EcON16j7qA=;
 b=ArMr0i7MhSwY7Bs18Orz77A4K36e3sU3+1HqopQRQ71O6Q8kK4PeQusBHx/IXQUwbRgTFIb4zEJdqZ5NDm9nqxE82vZ6EJ/ZgjHlClBxvzN1wUoL57tAMCOAhokmgh3Tx7bc7BnB3uJCmytpCZdRTiL0oSg1f01LQIs3QPKNrjc=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SJ0PR10MB6302.namprd10.prod.outlook.com (2603:10b6:a03:44e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 01:05:06 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 01:05:05 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix duplicated VAR and secinfo
In-Reply-To: <1b0f9104586fa37a5480581e6dc59780b25d3b29.camel@gmail.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
 <1b0f9104586fa37a5480581e6dc59780b25d3b29.camel@gmail.com>
Date: Thu, 20 Feb 2025 17:05:04 -0800
Message-ID: <875xl4kszj.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SJ0PR10MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc23f16-d51f-4dbf-22f2-08dd5213c70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zfSSPNTJWKOafSr1Duj0+7KOCjwD8Sk8PttLCgeBeermPL0l5eJ3dOZFmyZj?=
 =?us-ascii?Q?cY0Bxd+B/xUIDxU6X5ybf6I9N79DiphqzY+AUxKryvYIAcapdVBuwU5JLcVm?=
 =?us-ascii?Q?ZhGLkMo8qKy+SBA9xYlICSpECekopp17/4BvF8PDzxSFVbbu8l97qkTAv5go?=
 =?us-ascii?Q?AelgFcfyFkZe3G+in6I1Wo3bY+oCmsamqN4x7PGMPapCzInx4J+p1wi54U98?=
 =?us-ascii?Q?drcjICPhDwf/Nx3To5GN9/gf/b0NRHKcFQpLYm8qx2RMVlVWLgMpHZkCZJSf?=
 =?us-ascii?Q?//BmbfkoKuLQAFCT00887z3sfqwrvZjJ5KxDREl2SnoGppuXZcF5cK7IfIRF?=
 =?us-ascii?Q?4mYGL4UqfkoxAgSsCYoKTWyQXAvbthPZ7pw/r5yt4rhXBgX+RUzqjx0i2CTn?=
 =?us-ascii?Q?sot0g0xNZP7qUPh05hTP8splGm3urp7bF6g+U+3VT5KSrxLWfLaDjVk4JqNF?=
 =?us-ascii?Q?tlFLDx8HFGz9NteB/7TubcNFPMizTG4rfQmR7Onb4Iy2jc/qtUYalH6x2Ngg?=
 =?us-ascii?Q?W/Mh1pj+5lOpFCMHF1RFy//wMm97oH3Lg5YkHAD3NcXnDqU5GS1+K7CXEaO+?=
 =?us-ascii?Q?zLUyhJ6hocfiS6duwwXGxjeb9bXtLyDV7phjiReOS+KYDX4atF4yJkDWkyct?=
 =?us-ascii?Q?OgIunCc/pucZSIDxyF8ZQIXfA7//shtjTzyo/Hn4oksIVtsTA/XIZaJyeJk8?=
 =?us-ascii?Q?yx8y7bVu+bSRQcd+VxPCbz6h2byc9d3sxxkgvQg8LPdGbUiKxl+6HTViRoK1?=
 =?us-ascii?Q?neODDZ+CpsqdDulIPW37q/5NsdlLa7aTRWiN6KHcY6oEJ1OLNH/CDnhDEluN?=
 =?us-ascii?Q?SlHrLiicbuwC6DNpEwFD2l5OQviWY2xidgJtjMDkGJJ/kUSx2ndxovq6JVXT?=
 =?us-ascii?Q?EjTyG3uI/7YI0W3UVPYEtTTIKaGkjO6QCOTDZLt3Pz+fp638aqP4OKkJEQzk?=
 =?us-ascii?Q?TETkFyOgOQEev/CoWWg35Iq7NvGB6TNxW+puSiRALYr90g1VprBM3jUq7Mk2?=
 =?us-ascii?Q?UggnyuokETgb8M+Zaz/dYWxsb+IVe/FNZKmhI3R+nFxKt8eyy8TTurSS4Asi?=
 =?us-ascii?Q?rxM4t6obCkDTNf989accK/j3i9KTuEe8cf0P40/gA04H5KXnmjCD36NHZ/CF?=
 =?us-ascii?Q?rS8YcvwGsv7u6mkzhDJ8USYzUV+vHmFlLQfa1UgEzBK24+cxdfUpRWuiPSCQ?=
 =?us-ascii?Q?TzrvAAN5whxnSNySbh7ceMp9xs1b67uC5smrv6AKamkCU/hItHogRBw8A8m2?=
 =?us-ascii?Q?OgDFeHSTxpIanPQkn024ArcTBmBAp1Xz38wADHBG4Z+6GBkxpr4xFCBhfT17?=
 =?us-ascii?Q?XDb5rrldcTK0yxA8nCsKjHw9/q0Hpk2CZiJJbGNNNv8DAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IyWcAhwxbdh1k+4HPlJUE35kYQ0ZN28SPT1vNrrPbH3QsLNW8ppgHQhUTr/e?=
 =?us-ascii?Q?REtV0lvJkQAV7WUcVqb9pItzRrLhKdo2l9jFzG1umX/druzVvm/GYRkH4eK9?=
 =?us-ascii?Q?zD6Iw/5eulG67/Tw/Jd8lkF7Z8UbXMTNukVmD/GKlRjyB82fIy5xgddnPngg?=
 =?us-ascii?Q?Gb79J4Au1K8DestiqBZeNSurVmfSA6gYAJL/a8sHTpK7ee+WqrM7EBoFhHKg?=
 =?us-ascii?Q?WOe60viyVKUBsOYdGtF7gHZEDJn3YBWkHrlZAZkB0lD2B5/sJwlbT23hvJHe?=
 =?us-ascii?Q?4vx3EWNtfItUo+VLUnNlWdfTDpjJlpTetT28qTGWsC5DjmjNtoQxgvP6zzjy?=
 =?us-ascii?Q?7HZOXXK6ApjKrL0wFUR2c880TEG5qzdKaBFWxM7s9IvvX/iX9qn56JS0OrmF?=
 =?us-ascii?Q?WQHF4QTkSKiId4hqtALQw3LDkvXxh1lGULWrj8saBBO6H91FjtpIKcVodpN7?=
 =?us-ascii?Q?5ulz58cW5CWzo74CsMqq+KIHhGXLn0auMwYBqwEWcahVW65Vgss7g+rqyd3s?=
 =?us-ascii?Q?L7+n0YqXAF4Hw/O9RJXylktyf1sO2r39Uy9S0i1vKTCfcH2WSnuoPMaQlK5F?=
 =?us-ascii?Q?otSj3B2yFB5rr0pEQRVdngDbWjf95oDi150hgS5u5FDZ/s3gN1UXXvrQ7joq?=
 =?us-ascii?Q?H3TIYkB1+ZYc1kHub9DnN+UvbpXaKdH2smiwCz8KA3gyS7zh5l+yMTx1teKr?=
 =?us-ascii?Q?yLsOF/DICABPZ/h9xfbMklEG6eyw9s1q9gQn9EyQv7fNt4cj02bd1P02dTTL?=
 =?us-ascii?Q?p51UbjJl/xCdhjL+QEZF48iGicr2MBWQPZ2ZCjk2tDG6yaeqUAwzffsBoHVw?=
 =?us-ascii?Q?UwO9yFN4VaQuRHvA0UNvzM1vHZYJs28gioDKaKHMxGGVi00e4uUo2b0ZSfUJ?=
 =?us-ascii?Q?5bpo3nbMevQzTAHVyUtIupW/elsdaHLClN26fA6gTsyn5OfJyN42Gcyh+P5g?=
 =?us-ascii?Q?ZaUL11Iuhu77NkG14VtdCfQWPKsNGHUQRkJj4LnL5fN1DNf6m5mZUDFuwGh2?=
 =?us-ascii?Q?NNv+sBDr/AxpQLoXRPJHaYUHBj3/TsMajkg7ow4B0JpQ4SivLfYz+LX+8QZL?=
 =?us-ascii?Q?d5vR9TD8ysrNSwjLw4Cra8fjK9yPcL8/R7dvKTcstFBGotWjuhDjX5CoF6is?=
 =?us-ascii?Q?FibPnLY5vwjkLqeCZ3+ORgILJLpTpXUsY0/gF1VYQn3lTXg0IYemVopGIYfX?=
 =?us-ascii?Q?mAVdVJkiefplzLw0grXXseVtGapUeghlfGhjihRe8qcHSEksHLVYjioIYVx9?=
 =?us-ascii?Q?AmnXMo3QN/xHN3LCW93nPNRxnADJ/plVAFKQGLuq955JCbh5gH+ULTB419mC?=
 =?us-ascii?Q?RxHuGc7ooXOEYHZzdtwkRIvMj0Z0h6oGGAYiWjmH+GOFYL0pX63T5lJ5qARP?=
 =?us-ascii?Q?lWbBIx0GW2buX8WqqH6kzb7qQJ2WcoZ6T/xJpwqHn48y6/kg6lIMnZwl7oZc?=
 =?us-ascii?Q?8sF+aBzldMLPOiVIZV6UDlDal86lVdPTpVqS7IIlctFUpzks2sWrlqH1awol?=
 =?us-ascii?Q?qldUkielM2rU5KiNi4PusiX2+h6b2kvfBXDDm/X6WnxlMXG8sdN9r5LEtrOH?=
 =?us-ascii?Q?ESqAYVaoUG5qst643adkdcbXDaeerhiYs8RVn8fQ0xTeKMNJBKe794U7r/Ky?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	joXHmsKdslW4X7qWO521iVVnFNbmuks9IZSdbhcN2EtTfrBCjZfZh/ZChXZjoLcIlpA53LtTvqj8LZ6UWTGmCDiz2rwofXdStHvi67bsM98VNV1qsw9mPe8+bxe0cJWddM5lFZJuK+WheRvaL5tjKL6HjRFoP5MFknZSCJPH/HI4o9SQZWOL7bgz7PT8tr9QsI07AWF6T/64kOE57Q9ldj5k1LLHVPFgHCGeNzuu1PFmfVnttE9fEq7hPs0azbnWP8iRI2uonPSp4qVBHjIr9kxCf842wQcxkwmIPMkgs5d6UqaTEwxdc7mVfIOf0pMNDVeLTWeoW4cK45V92ZqY4Uk7IbOdOTKr+9lmWYJ7gaWGwRZVx0mM+X/awxtoj6cVrS3urALrqLWKiy8sRZrXLjBmTCZhMgLzDSLI6Do5Sb1ipKgkn9/f+wg2Vcoh9zEZLvv07QmvfFH63YbYgCuLfaA5y1PUiVkXzPWP5D+DM1pmSXQG8eM8Ysf+KdWo0bxHMn5PKWx9vpvWBMqp5Jp8spkA72Ce33CbiarFzIya6AaSrgXu5RCIy6idBYmAd2Qt3nbiMm5NfbJZOSR7Ky+8fV37vpsBywWcOpTo0BNiXvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc23f16-d51f-4dbf-22f2-08dd5213c70d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 01:05:05.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdhrAPhtZltBJPJUi8Kxkwm4iMRB4RFMdKY8jtBx0apbQ3kxDkwIDw8pn1qjaokmBfw4RBpVbpccSJUz+89bUccycNF8EWdUTLlKhdgDmYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210006
X-Proofpoint-GUID: XJauZUqKcbXkCWVrTEHodWUyqPO4TVGO
X-Proofpoint-ORIG-GUID: XJauZUqKcbXkCWVrTEHodWUyqPO4TVGO

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Tue, 2025-02-11 at 16:49 -0800, Stephen Brennan wrote:
>
> [...]
>
>> I've gone ahead and tested this by building & booting a kernel with these
>> changes, and the kernel patch series at [1]. The result exhibited no BPF
>> varidation errors, and the drgn BTF branch[2] is working perfectly with it!
>
> I tried out this patch-set:
> - applied it to pahole;
> - applied [1] to kernel;
> - configured kernel as in [2] to run BPF selftests.
>
> With this all done none of BPF selftests could be run.
> E.g. doing './test_progs -vvv -n 1' gets me the following error:
>
>   libbpf: Error in bpf_object__probe_loading(): -EINVAL. Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.
>
> If libbpf is hacked to print verifier log for
> bpf_object__probe_loading, the log looks as follows:
>
>   in-kernel BTF is malformed
>   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>
> BTF is broken in some nasty way, as nothing is printed to dmesg,
> even if I add some printk's inside bpf_get_btf_vmlinux().
> All I can see is that 'btf_vmlinux' is set to 0xffffffffffffffea very
> early in the boot process.
>
> [1] https://lore.kernel.org/bpf/20250207012045.2129841-1-stephen.s.brennan@oracle.com/
> [2] https://gist.github.com/eddyz87/5282db54255b81eed731b955dc5ea690

Thank you for the testing (and the review). I haven't yet been able to
reproduce this. But I see you're using clang. I'll spend the morning
building & running selftests with clang to see whether that is the
issue.

Thanks,
Stephen
