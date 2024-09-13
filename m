Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B011EEE0;
	Fri, 13 Sep 2024 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247819; cv=fail; b=s4gW9a4/LfiEbwlG57jzkm6boJ83M91hElCMJHSLLjLMIhtYKtHpgPiImq3BSGMxbzKlUBZveWLcJiYvSLSCd4jmK76/8vWnHHi7Ash7gvPV1a97HkHUFa7Tkcyu5pIvs9+B9om/2fskKKClk7pTT5yEFTH0X/vfsMsN2smlGRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247819; c=relaxed/simple;
	bh=Q7/S9HeA6+gprwSguKhz8o4FKZpoPPMoPAMmeuLpy4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=YgTnGxIxkdfi2ogi4myOXT5+P7/MWiJjf+N4bzQ/y/vcHqmiRV3qMGeBsQ73V7YjgJGZo68mKkNPSfMwuSp9vfw0Et78l2O1Ec5m1BnHP/DR/6ujgNwDCwTeOd+PniWLETGbnxRJlhz0E/HY5WMZbzu5AbOpVkjfDPGcEXLzfY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dUm7tiVJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U0rFCLf4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dUm7tiVJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U0rFCLf4"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGZsG4012331;
	Fri, 13 Sep 2024 17:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=/Hc5BQgB7tCBXQ
	O7YBF9RffGP9tBMs7w2lfSEcDfDk8=; b=dUm7tiVJSEw3ym0B6wDmlydEvfksca
	Srv8+6yb4pMs4fl9/iUHhoD/IvtpZWKQF/iE/Mlh1dfMoPejq2xWtNBSRj13RKSf
	4RHeNWWqrFM4eLXPNL0zszZcVr09mp0HikzUQVeZisHmb15hXu+m4/APimZNKPXZ
	lTEuj+y2Vs+tOQIkjfQeplXMBrOeyYNNW6GJQU50G3d5jTM2oxj0lI9k1oJoV/wz
	0Exyswe1D9aXL4aLnmibu/ysy68lpkLH5GbKJvGsdmnNm1RXuErkiRHDNEuByGpn
	R93TBAzzs87mG6j4raPO5g9ctA1ZdbIHdLjudPvBKytMwHdAZSxFc66A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctp5w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 17:16:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFx388035571;
	Fri, 13 Sep 2024 17:16:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9cx2cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 17:16:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0FY53xPI+kfJBKvg7PUeZm7sseDA5kp8KYSoylyWIw71+WiZ/xshJXyTN1ddqSBMVYL40DfVj2niyaypHJu9liS24VFrrHMMVLYh0jag5OaAajiqkBF67/QhR3ogoCF3fg8sEFRkEh7n5CXRjHBuEXCdy8ooywg3Ilp+/g4WgS1FlZ+YQKoyM5xZP7mGCgXBjsAWXqMpATDFvPENYJJKjbzhuzgrGeTOenGrZdd2LaT2+tRsMQWjw3/keJJswLlZ+WjL5BQq0bxuIYwHHqnxJjC/G3ksYVUFCrMKehhsuTI6WlYU/Hl77muC7Ov5K5Lw7+vLjK9/lxnSCqaW1RerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Hc5BQgB7tCBXQO7YBF9RffGP9tBMs7w2lfSEcDfDk8=;
 b=L/tooLzSwboIpMMQvZOLCkDlrt7XRkMqo7heMU7P/lWDxh6ExZMjn6KjhhWwugWbgfgEvuzZB66sUC0IuNnR9I0mf0ueV0dDnhdq11n8mqapfXMYfVjDsAl9BzeodQjhHp0A/x49EK3WEM/LSngaR4T3RYfIVCQiQ2JRGVNioYSgb8N9jgBHFbpKYWJ742Xi2cAJfQV3jzHxwdr7Nh0av/NJ13Fvp8KqcsgX2boQnNB1VOllgO7ELknNfBxMZBuCCH89q/f3sBWBrMY+MHbpOsIdJg6boo1XNYWNWb2AWSuKea+lNJMpjUju44kcgYNQ0dJYA7v5H8IplYfY+k7HLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Hc5BQgB7tCBXQO7YBF9RffGP9tBMs7w2lfSEcDfDk8=;
 b=U0rFCLf4mzeWaSgY9mA0FeJPSZ25KmzRo3TOuQYs/UBd+SeGvqrTp7cHP1WjjK49n7y2l/YLVCu6ZQfwlj2TV7Ba5sdcN6hAG/FKTsYfTszm7df3Wx8DeGNDOvhl5luBNKovhWXRVPDCS1QGBOufd+Zk06BqLDqGj1tG/zLGgCY=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CO6PR10MB5553.namprd10.prod.outlook.com (2603:10b6:303:140::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.7; Fri, 13 Sep
 2024 17:16:51 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 17:16:51 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves 2/4] dwarf_loader: add "artificial" and
 "top_level" variable flags
In-Reply-To: <85af9dbb-4e96-4dac-a7d7-29c83f517030@oracle.com>
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
 <20240912190827.230176-3-stephen.s.brennan@oracle.com>
 <85af9dbb-4e96-4dac-a7d7-29c83f517030@oracle.com>
Date: Fri, 13 Sep 2024 10:16:50 -0700
Message-ID: <87r09nmq2l.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:74::46) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CO6PR10MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4120bb84-8dff-4a8b-97f8-08dcd417db8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22KJWU3lRUegUIR5m4r8zTWQ+q5C+btzMaiNMAghSo7nFuiadVIGHPa7sHLo?=
 =?us-ascii?Q?w9kwe3pxZ3yzKphjz/sN5dwtrtDpzeuwnZxHvV61j7qnAxUSi5EkcUEc4rm2?=
 =?us-ascii?Q?1bLA/S2b6N8ReaJROCaufSdMPHSVpJ0oClf6arLiXjBmxpM0BFMh6Q8VjP5m?=
 =?us-ascii?Q?NnpcLhB/jJBR+A0HOSBdgNB4cuVG3K/rOrc4ipmSZ9gwmusEHp0V5VnLoZ/6?=
 =?us-ascii?Q?w9ziKEzIG3adzv2cpixXQfR/OUqvG+lgRPk3jtV5yKKbtU80fyne4C4e8IVr?=
 =?us-ascii?Q?jAf45xAbf4pa+bfXsdakBU1ScjPgEjGzSCqPA0fIiaIJ4F273ne4zEJtAvnM?=
 =?us-ascii?Q?/MYmWb6WB0cG92oYqbasBUf75riNnnM7GJb0TbO159ybAyreuKMoUyU3DGYd?=
 =?us-ascii?Q?YAhaGPZ+AXupUYOg4QF5SO1qa5qwldVKk1uCGyJ4i/YZSFueKN1Kdk3GfO8x?=
 =?us-ascii?Q?YtowtsDH4q1WtKQjuH2GrOIZzCnRzVLe4E6WBiTISW9rRcij7nqZRlzf8ciX?=
 =?us-ascii?Q?LadU1lLKJxl9s/I/xFHT9m9XoBokS83f3Qit7RDqRxzkoNwy+J/HmdSIPA+0?=
 =?us-ascii?Q?B6MDuoYtD3tFv6T9LKhoMF4/x7zT5qu7sQVmtOZOpct1c6xDrHSdn7uIGh0m?=
 =?us-ascii?Q?gOukumkWlaqxasTCFagKBAVKj1cFKOQTwB1loL4pXIvV00Ej/isRRHhNpMS7?=
 =?us-ascii?Q?pnSvNcUQ+iSa1HnbycQffjM8ce7zBgDmF7JLE9tw/6uEqb4sHv3+3WTfk4us?=
 =?us-ascii?Q?NO3fuMSVaKykZfI3yNRnExeTtXx+Wd8MStAA7bXhNsVuuPlxwoWPdN6XkL1I?=
 =?us-ascii?Q?xSfqcwlLnBcJs9iRmQo/9VHauXvlkA6VsfVKn6CAgInRdqc0f1tc3gRtUEvB?=
 =?us-ascii?Q?CSG4CnN8ysW7fDWB0voXT4IG2RekxpyIAcy8SK8hn6O/66pkkIQLsFYROnOp?=
 =?us-ascii?Q?RwhMxyXES1iLhThqo003uRfNU9uHy27euY5pflRHiGpbImQhzpHtkfjqPXf2?=
 =?us-ascii?Q?MSVt7ih071qUpl2F5+JcpWoxO3/RHriTC6ye5XgomRYlATa9DQqB4SrDxn8u?=
 =?us-ascii?Q?v9fxUuZFP81DUJGJUk4gicKT/yqtMizvfQnViOkSybygcQvy9T+E0b3QeuCI?=
 =?us-ascii?Q?gKE14HPCPfCD2z1QbmOvY3ppnwqIy+a/MVegWRXJVn0fH2havMMzrnhp17ba?=
 =?us-ascii?Q?/Ne03LatHxnhbq9i163JKRqpjUX2GpdhRiUWb3yJp+MppCv3FvqrLd3Oa5ZR?=
 =?us-ascii?Q?BjHF0dTORQXH0mzqE6TVghmauuKzlatbp7/ssrW9AU1npAjx2f/K7DfYj4bD?=
 =?us-ascii?Q?0gTyRc6jihcsV9pve/MuXCha4k31UfM/pmsuuDY+ZyEgRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTFeWDP3MMlpOYbqkYfoaLfX8KKvgGUhQ6ILqF9kSKxVVqAwZKrmezEakjfO?=
 =?us-ascii?Q?AWpEAmGryvP7wv12/E3bUBtmG2jZ4EK+7qh4PadT+XDW6+LtC+FpqqQdwplx?=
 =?us-ascii?Q?dKEumm1Qxg/SoebC0eEKJxpD5G1PLDF/HyzkAvqPSLZ5AIUZ3K8ZHp7hnsUR?=
 =?us-ascii?Q?3aQKaAGVKEoeDv7YPMyORRVX9Hoxq9kGa5Rdlqh3jGvoytHknypJveU2L7kj?=
 =?us-ascii?Q?SxXovQJlrHxgGOb8B348c+TCjwT3+rAcccQjtjZvp9FGgLIpR+XyPGLcgJEg?=
 =?us-ascii?Q?vaycxWFBt42UwbH01Y2xLuXZ9v1IPeMPq1B+WTj1iYo4mg3ZF+Atx9HsMoo/?=
 =?us-ascii?Q?fkjZYIP23NgHYt36GZpepqLvrn9EK5GJ/pHm5oQRbEI/OQVeDjO9SHUujqMQ?=
 =?us-ascii?Q?i6UwLV3i66qvHj/RvjS0MRJoVWY4UVgk7Vh0K7yyTZPdpd/9B/q5HnvX4cF3?=
 =?us-ascii?Q?I1xllxfx12I13KZb/xGgD8iaqlgr+lPFK6rKoVhus/J3U5VfapF6O8OZ95wH?=
 =?us-ascii?Q?jQxU7zegBBCrRML5/cvKdENgewI7euDFldOAkAnBEF4+3vwgg82N2FnVw5ML?=
 =?us-ascii?Q?t6r+zVZpdj3VoY/67rhA4wcFzhHOQrpyZp0hUf5AGdvon7GWsqkbQjKvVL7o?=
 =?us-ascii?Q?ky/Yc778SMd5xGivX5Jy67LdikHhWsHoxefGcCw5cE0Dt47VkQK/1SW1aqD1?=
 =?us-ascii?Q?9gb6pq03g8TeLz8dkGLCSn/UiHUBqRV6l/XdJs3z6iNLHollNpzmRsc/TG7Z?=
 =?us-ascii?Q?A8LzZtFnZawAqy6bDi1QABsuzIGJ0Z8rD8YSqJFSOypNSpmZTIxzukUaVv1r?=
 =?us-ascii?Q?p5zpEgc02VXQVB225BJvhokuuB/+oYDzcrWBgf5rk5861VckT3KnW0qwOSo9?=
 =?us-ascii?Q?5SjZFyWgJdr+ZpzvX5fuAJukRsz29+2AaAvIPH/FZmaWl1sg+2XFd4f4D1AE?=
 =?us-ascii?Q?kW4QMixyjnL0YojqSZsLstXMNSdb2Z32Y3wpzprkGLSsG3Cj4drwQA8f9s/f?=
 =?us-ascii?Q?Ktv1SkCVDE9pEFhgFtOu1iOdkPsYXZIiOYmi4dIorjfxWQQJ+Ne8HBaqt/vh?=
 =?us-ascii?Q?pmLm8ocnEP/izONfOtM14s+AZ+OPNiQbj0qOfi+EaEDX2rzhR1dh3DXUinP+?=
 =?us-ascii?Q?sV9YjNaiCx5yotzhfGFT3SNEJL4w7sOEZOhjJoznkNFtfZ6eFCMVAJpTgbsg?=
 =?us-ascii?Q?AEZ9dL+FU25R88haAR++BgW5iOof4QTkYrKzmImUuktRj/mLW4Ytit48Yw04?=
 =?us-ascii?Q?YPJmeeMNbrOBnA1n01DrStoaRqgijLS7XDzGCa/PTP1ptmfzJAHNMQTi25O2?=
 =?us-ascii?Q?iJmgKgwZaO8HVKstPetmBUlbOq0ZthottPkfgnNkSZ7qvcO0OZZ4sdSeoIXR?=
 =?us-ascii?Q?QH2W/gDtjm5g8/hioPcVa5nnoaN3J+Jeu/K9YnK5MfUwTDkEENeaX5jS24j9?=
 =?us-ascii?Q?OTWm5rItt8FNggEABqH12xTSE9pfmMRVhZlPmzFER04JjfommXK/Xp9EXPiL?=
 =?us-ascii?Q?vbcj+T+GQLLIuj44lqWmPuf9XeBd0/8ZhKpe2COVDzNcuO0pg2dGrea6oHmb?=
 =?us-ascii?Q?rec2OkdV2TmFPI5LNuTgn9QRolk74RtHWDEnm2Wd/+MB+hgXTOFgFiHGPeK2?=
 =?us-ascii?Q?enGcHfmZBaiNco6zrSrbalL5FP6nRclVRKUx0hyVQSgxo2dSI6y8FC1ne78X?=
 =?us-ascii?Q?d/nxBQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KEowPVetFYuZNqERJ6NFt2hZHbx/SksmSZd49bwp3Pe5FDqZ2F0FC7Y0baNGnl7uHMLKEKCJr06x8KlD8gMRAxiJ2/E2oGtLiXz/gEvGc3PPM1V/vL/zbLE8IvLKZyVPa/GH9tdBbJFPpQatfvhIVB6+cf526UbjwKHJUH86dtO4ujb1bOj36rs4TTQVIycSicsCC2NQLMB6Dc2s1mBO/Yp3Q8x1057Xyq18mMYCfiJuyHX/+fxVxCpyEimG6GJzYjxcZrHrzhJ82oSd0Nt5ck+7Xf7WMrinjaV6gpmIVJAAKNeX2zfjKKtDeTXE2eLemUt4Fi2caRwhiHleYBUWWZCldvVpqh2Vjgd/EpmAgn9pXoTKEFJ5UJqTNWoSL7tGQuceEC7NNhnCrQ7PgY40I5oSgy6L/mYz4Z98aoLGzznkzdBqWW9zXOHpbSAhJnh5UHYONZZLmpzjRbbgQCr5YrV4HJqCgfAbX5HHC29OFCt9h+KlhyXzGr3HseWfrbxRr46qWmx/VTFuFQaYlfN70Vq3fi9KvmqlBdnZMiGDkh7PNTh87P3hdzgOVMHO6AgJn6qQmbgKoXH5XcM0hroHRqjBx+LAzGZyRqSkXYldevk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4120bb84-8dff-4a8b-97f8-08dcd417db8e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 17:16:51.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqBIGL8sIbCXY80cnfwSxUfKFCQrZkUAtQuxB26DOtlWYac7LxigpfND65pFefM2Fajb4UQsscEu83IbitPKmAyp7AjLa46K2inNV4WCq44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130123
X-Proofpoint-GUID: JaUQ5CA9Dw2PbIXXYk5Gx7m5GNu69qG-
X-Proofpoint-ORIG-GUID: JaUQ5CA9Dw2PbIXXYk5Gx7m5GNu69qG-

Alan Maguire <alan.maguire@oracle.com> writes:

> On 12/09/2024 20:08, Stephen Brennan wrote:
>> The "artificial" flag corresponds directly to DW_AT_artificial, which
>> indicates a compiler-generated variable (e.g. __func__) which shouldn't
>> be included in the output.
>>
>
> Nice, didn't know about this! Great to have such a clear criterion for
> filtering.

I've been finding llvm-dwarfdump invaluable for learning these things.
(Aside: thanks to Omar Sandoval to introducing it to me as I've tried to
wrap my head around some small parts of DWARF.)

I discovered this attribute when exploring those __func__ variables:

    $ llvm-dwarfdump vmlinux --name=__func__ | head -n 12
    vmlinux:        file format elf64-x86-64

    0x0001bfd3: DW_TAG_variable
                  DW_AT_name        ("__func__")
                  DW_AT_type        (0x0001c0f0 "const const char[18]")
                  DW_AT_artificial  (true)

    0x0001c148: DW_TAG_variable
                  DW_AT_name        ("__func__")
                  DW_AT_type        (0x0001c552 "const const char[12]")
                  DW_AT_artificial  (true)

Then it was just a quick ctrl-F through the specification to fill in the
gaps.

>> The "top_level" flag is intended to be a better proxy for global scoped
>> variables. Currently, the DWARF loader examines the DWARF location
>
> Looking at this, it appears that top_level means it is a top-level
> compilation unit tag, i.e. not associated with a subroutine tag (I
> think?). That's kind of implicit in your explanation so I think it would
> be helpful for the log to describe what it is as well as how you're
> using it.

Yeah, I'll spell it out more explicitly in this commit message. I do add
a comment in patch 4 which explains the differences between SCOPE_GLOBAL
and top_level (shown below) but something similar should be in the log
message for this change too.

    top_level: indicates that the variable is declared at the top
      level of the CU, and thus it is globally scoped.
    artificial: indicates that the variable is a compiler-generated
      "fake" variable that doesn't appear in the source.
    scope: set by pahole to indicate the type of storage the
      variable has. GLOBAL indicates it is stored in static
      memory (as opposed to a stack variable or register)
    
    Some variables are "top_level" but not GLOBAL:
      e.g. current_stack_pointer, which is a register variable,
      despite having global CU-declarations. We don't want that,
      since no code could actually find this variable.
    Some variables are GLOBAL but not top_level:
      e.g. function static variables

>> expression, and if the location is found to be at a constant memory
>> address (not stack, register, etc), then the variable is assumed to be
>> globally scoped. However, this includes a variety of variables that
>> aren't truly globally scoped: most commonly, static variables in
>> functions definitions. Their locations may be static, but they're not
>> globally accessible in any useful way.
>> 
>> These flags will be used by the BTF encoder to select global variables.
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks!
Stephen
