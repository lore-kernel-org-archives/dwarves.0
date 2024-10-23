Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D21AB517
	for <dwarves@vger.kernel.org>; Wed, 23 Oct 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683708; cv=fail; b=dBHr3bMCmuVg5NA2vp9xpVbVE2bARCP6/Heb4gbDPZ2ECdSpmg52KVY9IwbgvWn0nQ+Tu/bmG+MMcJjTM6nCzN9ENvtSoud5hRSWNes4g7cpqA/Ffth0QEiFi4wXsdDOTr9mNORnVP9WSxJh4NYdHfaBwnkfMFWwMn37UBEguAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683708; c=relaxed/simple;
	bh=r9s+22hp0Rpi3U6xNl6b6Te7zdugYxez8FbRIrty24Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GRRtQpPfvYzqxHyvddLHUuZpO4kq7Vpo3PNUk2EwRHG5Bj1SCidYfBo2M16QBPbz4Ww+ExctU4ZWD+uJzmSVjqF2HSDsqZ6RPyhqgOnHC+Vi2Z0ZHQGnM67nYCdOzrSQtPoDi0El3d2WfabRZbVVNzLnfbd4P08i75q9gi0MXd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R+Okscqf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uFa//ERK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+Okscqf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uFa//ERK"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQaGI000732;
	Wed, 23 Oct 2024 11:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/iUhpNS0I2xeNsi3edMK0Pr62IWgTeWpFEoPbnMTEyk=; b=
	R+OkscqfMU+z9PGRauSB7eSSYanqsNUQzQO8N59J8nPJvwr/60KEegqrt3Rq/F8s
	k064WEz8qNIPeI509J7CFJ8Xa+1Eg7DU1dj3645oGgEMO6xoHEJfwfpIzoDR2cCI
	OQkhBF8HoDvAw2QFEe4fF8XD4ZHTKH5LYOwOAz5nrFBKOJLQffh12TpkW8Mlnaxz
	HeocF9MC8RuCGGpBdF2vW5OQQMq2nZrC+aUyOg7Yi3dcYioWWWlZY5w+vXI6b0mT
	MAD6drlaz1BmHbGWOjbtWCVxOBFXovxunE2DL6i2zBnW0Hfc+yzi+C+x7n2rdR30
	/paCoNl34HMCeT3YM3xJsg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uqvg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 11:41:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NAcBaN017761;
	Wed, 23 Oct 2024 11:41:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhje57f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 11:41:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqYcVcsGXWvIm/Pg6zkA9ZbAejIt0tw1EHhH5ajywsF7/xR3P+XTfaun4cAUEHMOJE4fbVc21wZnLyQgpO/Yt/H55DBrDcI49cZ3YiodM6Le+77kBWfH9gdrMk05gSSaCas5f5BfZsfHEGzTQhjJOadMXjSiakIfbWSnKNDz9G4j0P5wDcc2VQV3m8w/d9bg0Qkx97PJiGwrcPNPWFNG6QqCFo+sl28x8DkD2GyHC8reBMI/mbOAFlSsp0hliTpCHwPCYcdOa+I/hz5i/6HJobMa2S6VYoi9ct4d0fzp8UX3jItiw4h1OS3sSQ1G8l7uXIiouHUMTxJZ0tuRbpoLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iUhpNS0I2xeNsi3edMK0Pr62IWgTeWpFEoPbnMTEyk=;
 b=vz7FsjTPw4gkkxphd+Z6oCOlKiXnaVMQRnrjifEf6cNAwCSSgFhs40YhBU9eQ49W9BNIVUmX44v5Lwcpmx0FIodAh1Ht39lGg+LE0JEiIWGDzdikbTOoZvKLeDOWCCvDB+nRPrLTpK6weRpfg+53rPPhtooTf89JxsTOIgbj1DmnMDv5kXwNmFxCzNjZvtZIVzjg1K/BukHZOksv0EU1Lze+cIMIKcGpc10BXBGM7l/sKvD8FX+ivR4BSB9xA/W7rluVjQfFO4dW/U7LIe+1UPyqInUJQ63Qx5iAuJ+0jrgJG17peB0yIkGcjDDGpdK/wk/tXbUXRszmDMkBHUtexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iUhpNS0I2xeNsi3edMK0Pr62IWgTeWpFEoPbnMTEyk=;
 b=uFa//ERKsg6EgvYJ+zfiBb2gSnAhJgZ33kEb7DgHZY+ZC567TZJmKIjuZQ79+M71XfDU4yc4ZPkXG7e3yNuI+OcBAt8Mv4Sh5b4prJFbj1TSdM5lymiqubbXxIuVbM5fPYsftTVz7sBIQoQLsja9l2ikTPMITj9yRY4WHoCDC/0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7604.namprd10.prod.outlook.com (2603:10b6:208:48f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 23 Oct
 2024 11:41:36 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 11:41:36 +0000
Message-ID: <dfab8a0a-5144-4754-ad9c-91dd69add143@oracle.com>
Date: Wed, 23 Oct 2024 12:41:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 1/2] btf_loader: send warnings to stderr
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com
References: <20241017092433.690192-1-alan.maguire@oracle.com>
 <ZxFzGNrgeFMSswGe@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZxFzGNrgeFMSswGe@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: cdba599b-e8ee-4bb9-d74d-08dcf357a6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDhUamIwQ21JcnZKSjhiVEVLYU55NlJXOWhFaXU2bFk3S0xwMUFDWmNQUG9V?=
 =?utf-8?B?VDlpOXFZZmp5ZlNpQTRwWlBwTU9pbHg1N0daZWIxOG5wSW1Od0lZUXBsd0tN?=
 =?utf-8?B?ZjdCMHR0U0c4eE9DTlMxSTBMWW80THFySGJJRy9oMDQ2aWRQVGdWSjdNdGVM?=
 =?utf-8?B?cHpuYXZMazEyWVRLVTJWc2JMcEk4RGxGZFhKSGl2K2tWSlVrakhINEJsT3ZI?=
 =?utf-8?B?WGptTXNXOEpLQ0haaVZSU2t3ZFpFdEpXY2o0OVNQMGZIcnQzbmxqd3UrYjJt?=
 =?utf-8?B?ckprUkMzbzRpMnZ4Zy95WnNmZlAwRHlYWU5oMkJlNEtjMTB1cXp5UGJSUXNI?=
 =?utf-8?B?bVNXUEl6L0drSGxwRGhES2pBMXBuamxnWVJsajNETUtlRWpPV2VvaVZRQmJH?=
 =?utf-8?B?a244RjVHT0NWT1BSQWxlbndoeEVlRk9XSG0yb3d4bmRpODhXMUJSblZrT1pM?=
 =?utf-8?B?VXNGRUhOTndPeGZQNXhXSkM4ZXZSR29sWm9Wb1NJUUtEaDBwSVZWU3NRWTVa?=
 =?utf-8?B?SXg1Rm9UOXp2R0oveWFEVTB1MVdnYnNMbXRtYVBKQTFLakJjWDF2TkRwWDcw?=
 =?utf-8?B?ekU1bWE5cll4SHJ4Mk90MmJzNlhrTVc3a09XaGFjM3d3NnlCeGJtWDVVRVM4?=
 =?utf-8?B?ZDFmK2syd1BJM1E2T3owemtiSVpQMElPL3JuTkZCOWVGczV1MDVicVZaYjdN?=
 =?utf-8?B?K2U1aVo5Uks1SGZzZlViUGk0ZjUySlJkTWcrbFgyREFXZGQyblRBVmtXcFF3?=
 =?utf-8?B?VmJ0eFhvVk91SWpBNWJJNWpXUThrTHU5SUozZGJaMVFENUdYUldoYXRIV2ht?=
 =?utf-8?B?VW5waytyYVlYUG8za3lEa0NjNlp2Y1hVM1BTU20zOE14VHhqYk01ZEhmYklF?=
 =?utf-8?B?bDdTVEVML0Y3Yng3TE05aWNtd2lWSnZHNkdUNWJIVkQrMzE4TTB3cEVPdUQz?=
 =?utf-8?B?c3BtMzE0RnpvalNYZks1bmVDM1QrZW52L3hram9HMXpBYTJLUWFaSGxPbTVT?=
 =?utf-8?B?dnQvWE4wdzJiSkZ0MExoVHVhVE5lZ2xpYmJIaTRLZlA2eHVRWEwxRXFiNTVr?=
 =?utf-8?B?UmVhcVB0cEhwaVdQV0JFVnBnYUNXQXN2VVhKaEZjQ2M3Mlh6VkhRcEhIU29B?=
 =?utf-8?B?VGFmZTBWc2V0SzI3dCtDMW5rSEQ1ZGliTXZsYzZ6SXd0MFpiazVsdSt2aTZ4?=
 =?utf-8?B?aVk5Q3NlSkR1MzcycGJsM0ZzZXVjOVIrRlhvbjhoOHJIK3RHazRJKzZWZ3RV?=
 =?utf-8?B?RTFpemw2UTNPOTRPdzhzeEo4aG9EeWJvUFprRUxDNEVqdmlmUXgzL3l1RmhB?=
 =?utf-8?B?dVVWbzF3bnE3VGZRcTJ4amZmWDdPdE4xYjZsZ2lQa1paU0NJTit4TW0wazNv?=
 =?utf-8?B?WmhOWkt5c2tRL0E5enZnVjdHdU1wZlFwdkI2akdnQXlXdjNCODlrR2RWNG51?=
 =?utf-8?B?UkQ4S3diWmJzcXZ1YTZpdndSVWRvK3VCSVZxZWU3a2RaeU1tSzk2MlhWY1o2?=
 =?utf-8?B?Y08ybWNVMThtMDZVZXVwUEJXd2hPeU94NUI4NWxCM3VoL3N2WENvS0dzaWxh?=
 =?utf-8?B?OEJDZkJFb0tqMHpBNzYrbjdEdEhJSXlMRk11T3gxSndYUjNCQ1JLZ2F0UFNU?=
 =?utf-8?B?ekpTbkFlRFBtNFYxK25uUm82UC96d2RobHRJbjFPeGU2VnljdVVZUjA1MGUx?=
 =?utf-8?B?TDduME5jWHQxM2lxYlFPUnJMV3JDRm52V2tKSk8xTWFEWFY1SFVIUjRMKzY2?=
 =?utf-8?Q?a44slQTzFc6/1PIUvojybSa/oTV0251eXrhQ9nI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnhUU3VoeDRBa2VjUnJXN1NhWXhMcW9JRHRxWUZHVy9oWk9md05LSmduZG5V?=
 =?utf-8?B?anVMSmxKQU1TR3pMWUZ3MENSTS9tdTNQRzRFN09COW4xSHdqY1hEN3VFbEFQ?=
 =?utf-8?B?UHRNbW9PdEEzMVNGZkZHT2VlbzZvM3V3MXNwSldkR1hwTERnajVKL0J3eTVM?=
 =?utf-8?B?dndPakd0Mkh2VDV1alJYaTJFVkZ6UlBORy90YVZVbUhDNVFlN1JZM3RISmdF?=
 =?utf-8?B?Tkk4Z21kM0FLTC9aalE5T3I4dUsrdnY1QVFvT01vSyswWWpNbCs1NVFNZm96?=
 =?utf-8?B?NUI3T0FRVkdRSWZpeGNiQkNlaGhNdVVwT3ZJeGZJc05oVW83dVJJYWN0ak5v?=
 =?utf-8?B?eVFlQ292TFBJSEk3enU0MnA1TUdnNm5mTVZDc2VKWTlpeng2NmRTSDN2eEZp?=
 =?utf-8?B?QkFBVUF6VHJ0ckZiL0dKY1pHSTVJZktyUVNBdWwxZUU1anpRZ1hNbTZ1ZnVz?=
 =?utf-8?B?ZlNzdmFTOTA5clZiblA1Smd1OU93QTRMR0tiMDYrZ3U5SURGUDhiTVQ0cU1a?=
 =?utf-8?B?UXpTNkloTmpqdHpMb3FaSVN2aUtwcVo0V3J2aW1FNk9wYUkrczZuT0h3ZDFE?=
 =?utf-8?B?S1lEb3EycTVpTEUzUkNzdElqamYwYWZ0UDlBMkxuOEhCdnliRGdkM1BScnkr?=
 =?utf-8?B?ZTdDS01CQ08rTWNCY21xMVNGOXJ5Q21SN0hQbm9hckVPZ0k4UUV6K0JQUTlk?=
 =?utf-8?B?OFMycGVLMlkwZ1k4eEhQMHRDTHBualZzdFlVKzVCbXA2OVVZZG1VcGZhQUxX?=
 =?utf-8?B?UXpudU9QbFNVbUpFOHp4YU5kWmNkR1dNc2lGRE80amV3ZTRoYlBaaThGbW1M?=
 =?utf-8?B?ZVZhSmY3aEhNbUxteWQ1T2ZrUnR3d2ZPT2JhK1dteVNTN1BjdXdCL3ZIUWhR?=
 =?utf-8?B?R1VxWE1xWkg4OEk0U1FRcEFJVWo4NDM3TlFSQm8raFd6VXBOMFdjV29MM3NF?=
 =?utf-8?B?SWFQc3BqaFFYVi8ycVgwZHMzN0Q0TUtEck5RaWcxZUl6bE93c1cxUkF1am1o?=
 =?utf-8?B?ZUtsR2xYRHR2YTcxWndLMjIzZFRvYnVCQjZYL3l0WHdFaGltM0pRa0gwRkoz?=
 =?utf-8?B?QjNuL2Irdm94bzZLTFVzNnY1Qm4xR3dRbmlVZDM3VVpJVUFqT2lNMlFpR2Zn?=
 =?utf-8?B?VjRRdDltUiszOEw0M0IrN2w4U3FjR2Z1ek9kWnEvWHlabWdyUE84YVVnYmk4?=
 =?utf-8?B?Q055TktlWnV4QXo2bU1ZTk4zMFowSWRaZkxKQ1cvRmJSN2VvR3dzNUVxemti?=
 =?utf-8?B?bFVXaWljYzBjQk1YNG4zSTVlUVVUaHhxQWZIRDlrRm9ZcFJYckxMb0tBeEdm?=
 =?utf-8?B?bnhsR3hPWTlSblMrRUJpY04zNDNSQkF6ZWZZbFhwNlowU3ZvalowNDVtMFVP?=
 =?utf-8?B?Y2xFR0lwaW82YTZsV2xoeE1BOHBZSWdZWUxuREF3R3JtZTBsek1JT25scEFy?=
 =?utf-8?B?L3NIQ1h0SFZrWFVDRjhOS3RDc3RWdFZaL2g2cHVla0ZXd2N4MHcvQ0RPcnNF?=
 =?utf-8?B?eElLQVhiUm1pSFIrWEtDZjl5bWQ3QUs5am44Z0N3Z1RmU2VLVjRXWXhCQjlD?=
 =?utf-8?B?dDIyV2R3cmJtK2lFSW4vWStkTHBRRnRsNkFHQkNHamVLbVBGSlNQbkJtSmxx?=
 =?utf-8?B?ck96MDVwNkp5clZZRXJzaE16YWtYYzkrbkhTK1NmZ045NGZrZGVVQ0JSYVho?=
 =?utf-8?B?T1ZDT0Y5c05TQWpENkplZzR6SFVkd2hqZ3o4QlFOaTA4emFTUzJMQXI3NWdy?=
 =?utf-8?B?M0dEa2FmYTRsdDhzdVlEVGNjd2N4UGZJcHlMaFBtQWk5TnVGT0ZyZ3Z5TXQy?=
 =?utf-8?B?VUQweEd0bkY3T0NIQXlmb2hwRHJpdzkyanREa2xoK1F4ME80c1pCdWg5NU4x?=
 =?utf-8?B?cERrL3d5NGlxTHJwdU5DUG02YWQzL3FrU3VqUUpMZk1QbkE0SmNXVXlwNXNi?=
 =?utf-8?B?ZFZwT2w2LzNRQ0FiM0c5SkF0ZXE1c2xJMktJK2kyOW5PKy94OWlMZ3hDemtM?=
 =?utf-8?B?aWtwcVFYR1JGVy8zSWRQSjBXWDJKUDYySFIvWlUzQ00xVDNiR1ZITHQyeGhh?=
 =?utf-8?B?V3hLNDBHbDA0a21ZWFo0aEhZbkpDaytKNDRmYncrZXVJdFJEQURwMnFIVFVq?=
 =?utf-8?B?aWtLMHhCS29lUkJPamhWZFRwV2NhUmhvTWg0d2NqYzhmSkt6RExpYnVGNitF?=
 =?utf-8?Q?867gWaAwN2KoqKlQzrk+vY8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zPJGqCZTj/IvsZuATmolgVn/tH++e9bu7+C5W1JBlZMPPwuF3OC360qSV08E5f2l3yIjY8TjXnVF3wMRL31bmMKqBAQ/aB5nJ9fQcMdqfDMXlCnhv3esNLXF8Er3PInnztAFZI//ArdwdNeX0IOn9GgxtWgEvNuZ9vJ+PCYZtY6DP+iE+NdCTt9wBMe3+KBsgMBp8i+pV1HCiVEv4AT37G2dXvokaRBg00VMmfhrvOI/ifNtJYn7nrLnvP6EhlF1wx5IheQNDK0XwwAUfYPseR0tnP5mIMi6dyPlVBNGZj3z1q/Qlor+4AryAYhBObErEo/cCpXib4vHXbTW+yW/mDTYr3daF1B6+v/Rkkj5lROKBOUIP3ftaKbDoJqr/ZPIqRzcGmZPS6f875ZzNXCYlfRRGC1AyUgjcWMJFX5PypFJPn19/9pUY6ovBIqlXfaJS/ayqfzy/FwmAEa1q067/k88kV4gKNtoiWHQY73zVJlwT/pZvh40MtHicLxf9q/ROQ8HpJ7+lwm73YJJ1L3miFcbLo8QhW6x7yEjHsuNkjNUjRZbQ5WHehgUCzlAVuA/DrPoHXrGU98Ng/iS+je6G4aDXKNekpFPrXuxLXelZwo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdba599b-e8ee-4bb9-d74d-08dcf357a6ac
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 11:41:36.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZJ9ugoXKaX9z06kMKYULk6O4PP2pOIQBFFR/rLSahGdjxnTifhzEGN926RFq+ns2eLyCAXru0OXHz18tfn9UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_09,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230068
X-Proofpoint-GUID: dBCOV8CMwQp8f24hsgvQW_cPY0suyE0X
X-Proofpoint-ORIG-GUID: dBCOV8CMwQp8f24hsgvQW_cPY0suyE0X

hey Arnaldo



On 17/10/2024 21:27, Arnaldo Carvalho de Melo wrote:
> On Thu, Oct 17, 2024 at 10:24:32AM +0100, Alan Maguire wrote:
>> Among other things, this helps simplify tests/btf_functions.sh.
> 
> Thanks, applied both patches.
>

I'm still not seeing those patches in the next tree; is it possible they
got lost in the flurry of changes? Thanks!

Alan

> - Arnaldo
>  
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  btf_loader.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/btf_loader.c b/btf_loader.c
>> index c70b67f..4814f29 100644
>> --- a/btf_loader.c
>> +++ b/btf_loader.c
>> @@ -449,7 +449,7 @@ static int create_new_tag(struct cu *cu, int type, const struct btf_type *tp, ui
>>  	case BTF_KIND_TYPE_TAG:	tag->tag = DW_TAG_LLVM_annotation; break;
>>  	default:
>>  		free(tag);
>> -		printf("%s: Unknown type %d\n\n", __func__, type);
>> +		fprintf(stderr, "%s: Unknown type %d\n\n", __func__, type);
>>  		return 0;
>>  	}
>>  
>> @@ -470,7 +470,7 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
>>  		tag = cu__tag(cu, tp->type);
>>  
>>  	if (tag == NULL) {
>> -		printf("WARNING: BTF_KIND_DECL_TAG for unknown BTF id %d\n", tp->type);
>> +		fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown BTF id %d\n", tp->type);
>>  		return 0;
>>  	}
>>  
>> @@ -478,7 +478,8 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
>>  
>>  	if (tag->attribute != NULL) {
>>  		char bf[128];
>> -		printf("WARNING: still unsuported BTF_KIND_DECL_TAG(%s) for %s already with attribute (%s), ignoring\n",
>> +
>> +		fprintf(stderr, "WARNING: still unsuported BTF_KIND_DECL_TAG(%s) for %s already with attribute (%s), ignoring\n",
>>  		       attribute, tag__name(tag, cu, bf, sizeof(bf), NULL), tag->attribute);
>>  	} else {
>>  		tag->attribute = attribute;
>> -- 
>> 2.43.5

