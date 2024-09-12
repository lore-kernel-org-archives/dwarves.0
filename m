Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125331C1AAC;
	Thu, 12 Sep 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168122; cv=fail; b=PqNCgkA/1+pIfkXVA4n64uP29lC3FNXoYX8OuVV3bezlybBC/4/eEQugHsmqy9Wa7cvZDcGrURWCcJzRCamv02gJxsrlS761CTJUoirTJaFF4+ORwMMZOcQ26zrBxww+RSqXckgoR/bGv6+tWIOZsfE0KtzqtHFTDSyE+3ffTUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168122; c=relaxed/simple;
	bh=rhpS6WTlbBptCiC4hWfCs0znLba6WNrsVYB3NmfYLhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pVWA9E9qzHQPzVzWiQUOs74kjfAzCiU+dUMGRbXWh5Adpw7eywE9xInOitNsD0iwjrMwZCl6bo+rF9qKNm4gjPxHhLHm3yh5NEW2KWeIDFYdbL+cDhr6Sd/JtgPfzjSkBghGW2p5rTW3n0vmRHU/t+pqpL0xQT5bpFfHKYBI+U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j7CUmNYf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=do2ANZ4b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j7CUmNYf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="do2ANZ4b"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIfZGF024393;
	Thu, 12 Sep 2024 19:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=nrnbTAK9N2ew61
	WrWctydHL9tSP4XjqoKIGqko/7WNY=; b=j7CUmNYfWW2pnnOOnI95CHs9QgLfsj
	BeBfkRSg9PJDOnvEIxcQBDeOG1ONjOOVKIY0g32hG/b5iy4SSiNaqUScE+oNKoPd
	lkg9ufoqNnIzG42Mn1/NhJmUVydvgRirbktS7HSWOJwEYB1qrj4CwpW1LrQcx/jR
	QtHM5sXOn9RuULTWDFfbbsM/BgZJjAZOr621VnjHOAzbwosRKnfW7OTc4/6AMYNI
	6/wstxYc2XibCE5/Sqh92RlvlP0wsz2DkkNAzqob/PF0VQaRhlqCERGvFoNNvTDS
	Es4RzyGY+ySsufz/QZcBe269v4RK4zSaoxGvtRL74tzGjyj0Uh78ofOQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8d3ju6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CI4kd2034160;
	Thu, 12 Sep 2024 19:08:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9c6g6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW95cCxri/zMirrve1ULBjQjSKZtNp88pSsZftYrEFKO3VnGLxNdEpF2kBzEC7e61Tv+OWIM8ySjrpWzmWrYHxAvvGoJtEOQwkDxhXdULjiHX65omdlNr6ITkGlor5YGiYVEGffJj2fK1l39pFQGjS7Xc5ULrRIk5b+F5uoNjMLWRGXvlEMuQsNkd+BsaPa8ofieNxIY5V5BIBfLbhdrDusdruBB0uE6D6lJecMAibfNtOEP7UQtsQCwv7TXRzJCrNhHdySPNuGwfAdAb7Wr8XEiPdiFpRh9+KLcKh9bgan5PvGZ0A6G5ODTD52BUd4naCZU/kmx0Fkdmj0HUq4JIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrnbTAK9N2ew61WrWctydHL9tSP4XjqoKIGqko/7WNY=;
 b=Hb0wGTWqkOyswOo6i2NVf35C9NhE5fsPS8oDd+NO4xr50YWA8windiptMJ10DIl0hwUBvoOohLxx4B1wHFSuqO8NE4hIYdkIaKW+eAkic3lrJ+c0czCUgmXfecqpQ+EiI0aEqZWy8/NYiTE4tdeMYVgc8ebNMc78+YewKcLOQce38Veg90qk23JiSWMA28tGiZIkB082+HEhACysY1YfSeUwwAlDEvvSXDowxKdPFqR382d7Dv/DvvyUp14GEKeHbqwemLTvFiUvSrHTvJOebuOUX4P0moolKWIQgnQfvv5dDlA0kG9wzMeYiQ3wgMoXkQWH/0ly/N37komIe9eRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrnbTAK9N2ew61WrWctydHL9tSP4XjqoKIGqko/7WNY=;
 b=do2ANZ4blxB6wFY4gq7tSfVclt9GkI49X9hfhNfUYHKp+kIAJtjSpI3IEUSsykckjVuKryuWScuvqfaXkoeh3yq1jEhTef91oGimvTGVI6ftQ32SkpLeQwbNHrGUlJVuJ/BrSlg9BUSRJTcL+8ZbdDfAYGbzqXqzfEcPRxQlHQA=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by LV8PR10MB7992.namprd10.prod.outlook.com (2603:10b6:408:1fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 12 Sep
 2024 19:08:30 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7939.007; Thu, 12 Sep 2024
 19:08:30 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/4] Emit global variables in BTF
Date: Thu, 12 Sep 2024 12:08:19 -0700
Message-ID: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::30) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|LV8PR10MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: d23bfaa0-eaef-46f9-6e36-08dcd35e49cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yfhrxicZn4fdWWRQ5SvV+S2wTyKepuSRBm1lfwjr5HMMNmuWQY45C95ka5T?=
 =?us-ascii?Q?+3eIEKcrTy94dT4yrcU1aIQlnPcJDt1FBOZISMvDlCz/fcb8PF7ofWweEK0c?=
 =?us-ascii?Q?8WCjD8pf2KvCR/SGYDlXUD1xBRc5s2QiRXnXdkQMTEW6Y2Ohfhdkbt+ZRj5M?=
 =?us-ascii?Q?6TNPTAxKnqyrPIhHjsUYnAqbwaUUTLKX2UyRAwaQ5lStHIKBVQQTP9v6MTlZ?=
 =?us-ascii?Q?Jfa/OFYHi5ZBzzkPlvC2fjHA3FhdQzZJW+Nku7xtKLtBsr5dwCuzB47mQz+6?=
 =?us-ascii?Q?k7FYmqb4+3WcWbDcE7sAxvfAVYBF8aqN2x1Wvt+H5kpV8GBKX2O2PLhB5QiC?=
 =?us-ascii?Q?KhRzGyCytPteyVDRb0eYs/nuNHAQUIEETPl6/2WwW3jZXdFeX6YimxSbZEVd?=
 =?us-ascii?Q?xcfw62PEVljoI8e/Xb7fVsquFi4RU1YNzRwpJL721H0+MpYPAcnGwFpIgsrq?=
 =?us-ascii?Q?Bewm2nUlu9qtKsbepla6zxSK1Hd5jZxWVUX9qMXX5TuwP7w24R/ptFxSbU3d?=
 =?us-ascii?Q?W+yB8JBJwGx0RAq76TTIn97h7U/Prs6Wx50C01w6a2xpw6tzAP/pnuJ5+NEV?=
 =?us-ascii?Q?4c2gRbjOju76jZ2E8TW7czMaA6g2SHgCqhgEA2siuhVrxXg3GXEpzJEvFxfU?=
 =?us-ascii?Q?YC3nmFmR0y2jz8DCymS28fQ6ER9ZukB0BbdlqzjyF9O+yBTvg5WMcCqvkOKP?=
 =?us-ascii?Q?zrOXli86YRBir1gsNFeUxQgeqL9KxBejNzpv3dj6CxYP7Y7RWHI22f/Jbewv?=
 =?us-ascii?Q?N6HJt41bg3NyGLm86Bd2mLySt2aVTS/eNzqJO89tXnJfzqNMuKTwU5ZYbd5G?=
 =?us-ascii?Q?L6y22X3sh3tSueKmfM6UgNKzEOXo6WltjlBAd370fVziy0HF24uVh4GAk/jb?=
 =?us-ascii?Q?2kyXcslx3Zf3J7AwXvu+5PEcsa2uU5AzQN6Lom0ds+9FfTM00kg7tJVE86Mw?=
 =?us-ascii?Q?tFa7n4OO0Svwwmga53NEy2XQiYw1FsYQ2gpcdu64j4grl2VBjCR6xZQqS6pm?=
 =?us-ascii?Q?GQ6EWbNPlsrpZNEfoavavWBJwurbAgxIPU1YfmU1c5romLPxxw45iQBS4dIG?=
 =?us-ascii?Q?uZaHWv+14sqovbGrcBiVzuoIYGPszFMTt+TeZiH0Mxly3PDskvPjuPWoTl/X?=
 =?us-ascii?Q?qkiOPBAoNOtWVi2p7i0z3Uq/VAekJNaXB2SSXKyEwvFaUy/jk3RBD7gOyx1y?=
 =?us-ascii?Q?pIxlFOHL2ZrNFPUr4/y/htvWx+lccbz8j+2C7nNjEa7zdwId19Diw0KLAjcH?=
 =?us-ascii?Q?uCYh+cUb2YinGFm10zCegVNlDtVzEvgXGlSeKcbGdlEjWRm/N1Pn3PYGElWr?=
 =?us-ascii?Q?rmFeGs2i/wmKLeS8KXrdV9P8IOXc8qgN2lPEl4XDD7g5zj349b1m91vgD+Dt?=
 =?us-ascii?Q?V7nWe34=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nt28bA9nx9IbqmCvTfvsV9/xy5EfqjjGqzEaZ9D9sXLzicZT/c5vicDsiCuP?=
 =?us-ascii?Q?jmcD+BmmbXwDsdyuMOUIPkntMqzspv6LyuEEFQkAh1WWk+VpTW3zyKkmlOhK?=
 =?us-ascii?Q?LNaq5mOXH95wy4esgSSeckfM2mFfO/jWg/udYxzocTyRjeTb7MxQEmUOKxds?=
 =?us-ascii?Q?gw0afl95YNvwRx6V4qSRBtX8x/aIkT75wMy0OPTelnsSuhvnhPwwxK/bhwUt?=
 =?us-ascii?Q?CRPUQryu3LI76HSqcXmtkhvnf5CWZRVrUYIk11TNt6rQF0jB54+vNHm906U1?=
 =?us-ascii?Q?zKqKv65L8wIuMyCiqEp+qB+xE2vKaOvKO5xPOEhYVDTVqP7ZBUGyrCjRM7Kp?=
 =?us-ascii?Q?KYbnOgPswo52WnLk0po4+Vq7TmImMd26I5Fync0JBT2Ip2lOSaE7IxZD5ypx?=
 =?us-ascii?Q?o5XjM/xxw1BMA2m6hvuHa2TaG2JmJ6FmtgfSHmZrzTedgDpz1hZOYX1UdMNM?=
 =?us-ascii?Q?l6LLvsAKBEwgVAJQeZaH1C/KQmokihADEnjl/HgFCx45i5raL89PU6KaBNUy?=
 =?us-ascii?Q?n5rMDFiYS2WmQev84LVYTDxJn8aHPk0fE7BSxzFONZFg4EIsTq62B2ROq6Hr?=
 =?us-ascii?Q?i9XhwGy+hB129Q6T2J/exxXRNBd1hzF+pmbB+7S87P123lZYYyVHCezRPc8A?=
 =?us-ascii?Q?Ghqk/V1pQHy1Nz6PPAwtXV5r1XA79AvMNyW7rLOd7f8syCWmJYj7wmXlup3H?=
 =?us-ascii?Q?ssn/0QxRazeDg76j2FpHP9ORi3U8x0K6LYzFpwHvRoYXxBGvUjKgnhxGHP1D?=
 =?us-ascii?Q?xoiWiAJY+DIpePFkRRDl7ap6BME4Bc7HH7OrNA34axKiAFI1zLoO/SSsptl4?=
 =?us-ascii?Q?HfjJ7s3ku3UIdfnDf7WK5lg1oCwpMZxyF8ge8C1BvrOLGAksh3IlJQ7I6cdP?=
 =?us-ascii?Q?YWb7pAt8yyv7YuyApliqu9uC8a2tGOHNcOK80dRz95+ZnVnAWumMYXRWv2+f?=
 =?us-ascii?Q?YcYzM5XgdaJX4lJ+4B/zwqXm92sNnG0hQ0JwkfQCEIBGHcRaztBTC0YdrU3N?=
 =?us-ascii?Q?+wfqkBzQCjkq4WnHm0Bjcm6V6gFuVvUlp9tZAW3b1r0nbjzWC/ZLmMIB2NCu?=
 =?us-ascii?Q?IRh+Eq9vgC0FVnohm/Afmh+VkK5KaoxExbqHRlzTAfvUmQnafbuWcgoqpK02?=
 =?us-ascii?Q?cuoWTI3PhoJjWjEkneVkMIvGA+hBbHSCBhqPjtiKct38uKJxKm9KFRCMcXiX?=
 =?us-ascii?Q?z9cgeDh2VCgcMY+c9S3go/Og7JXUH6KTFkqfXwSLNXCSIacFTFSjO54Hr39L?=
 =?us-ascii?Q?Q95wo2JI2FdejZZGtNTjrV2FNyS2WwssU4twEGy4leaLVZM+opVuU6HZnU3h?=
 =?us-ascii?Q?lzyQm+53G9KwucglOdICufbSEt50pLu9D68/iKkBMd2iuJg5oR/GJmuBmfOY?=
 =?us-ascii?Q?7pbPKodpmYD2I/Pr11dUV59+VJwXgE1B2rp5b8LZT9bYr79xcI0s04Zsc+3Q?=
 =?us-ascii?Q?28aA1jDFWMtlVZDrtKQVpTG7xM1ZgoAD7atYHogG+ZCSTSx7tycS5a+favpO?=
 =?us-ascii?Q?fYoAQ1sODlYMHPEr0kFK5kVFVTuTgeXgjmQimz8JdQDSF+ok+Jj29WKXuyNo?=
 =?us-ascii?Q?Qk5BWI1W3Hwxi2uilPvqPjb16Bs/ubG0dGL0uGPrDKoWV8UKlKWqd/MxqRfv?=
 =?us-ascii?Q?/QTYmaaCw48wQHqHALjl72I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dMOpS0kB9x+mgqaetM/To64o1ZA0QEr0lhKCIMUQstIwLLwFTGwO+2gjMw6YelNC7KI7bOMvtUY1fA7q462WRlkThvrsAEx8yVwbsWiW4uGj/NsAH4zpsl4tlIlmElbvGb2eSOHnRWcldG+cAbI6IDGOEwjl3iprZV40dKbCFhwUrR7rLnlOZtI6ejFbGIwky6B03UicKv+zzD65wcMMR6bcTkxyyR0/fvBNXfXteYqSnRaLjCofTz50AdA72M74aAP2snBu7wPtVMP0UfnIBymCO32CZLYkHLQnG5xQ1n339qksOAXUtSZe0IFuF8l7NuQFcNXEwusO+Ci98YPq4qsQmkJrZMf0OswLRsR/Q3uqxJRQ8JgKp6vUDw3AgIOjkkKtfkb7IVLbv3wXPX7Kq33ngnnWTvPZ3IDpsR8QzY4XkLe6p8cynIg8eylNFJStDUwjvFLIaxx/c+wQQcSCJbSJIGdx8iavvHwDKs7V/T/AFJ/TI9Z73qLsyWqlbVbC2aoYY5B3xvJY3xTONgp5Ye2AvA7juWt8UNJRwvV1DFwwvBhUo+21MOIAYltZ6G9eYVpUsYji7P+JRMEcCe992bPiIiii0Se4hp7TE5i803E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23bfaa0-eaef-46f9-6e36-08dcd35e49cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:08:30.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYGCxCSUBhMZEu6dj/1QYxeDvXwBPjrql4+lNwrYIE5KfuifXjYxFYreWXn6GpyM4/emjZkP4s/H8/BDRhA4+f4xNgsbV+dd8pHma0RDZYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409120141
X-Proofpoint-ORIG-GUID: zKvQaKfZnfjAiaNEc0CSbkkCgedmSno1
X-Proofpoint-GUID: zKvQaKfZnfjAiaNEc0CSbkkCgedmSno1

Hello all,

Currently, pahole has the "var" feature which emits a single DATASEC for
the ".data..percpu" section, and emits only the variables from that
section. I work on the drgn debugger [1] and have been working specifically
on features that allow users to debug their kernel without necessarily
having DWARF debuginfo [2]. To that end, I'd like to see *all* global
variables included in the BTF, not just percpu variables. But this woudln't
just be useful for debuggers: libbpf already supports resolution of global
variables with __ksym annotations, but these have to be declared as void.
For example, in tools/bpf/bpftool/skeleton/pid_iter.bpf.c we have:

    extern const void bpf_map_fops __ksym;

With global variable information, declarations like these would be able to
use the actial variable types, for example:

    extern const struct file_operations bpf_map_fops __ksym;

To that end, this patch series adds a pahole feature "global_var", which
includes global variable type information in the BTF. Most of the important
code comes in patch 4. The major difficulty is in deciding which DWARF
variables should be emitted. The current pahole implementation considers
any variable with a static memory address a global, but that includes
static local variables, so I've added a flag to indicate when variables are
declared at the top level of a CU. There are some other useless kernel
variables which are generated by macros, etc. I filter these by name, which
isn't ideal, but works well.

To test and measure the size impact, I've built v6.11-rc7 on x86_64 with a
defconfig, and enabled the necessary BTF support. For one build, I used
pahole built from master, and for the other, I used these patches on top.
Here is a comparison of total vmlinux and module BTF size for old and new.

                      Before                   After
  vmlinux BTF size    0x5f4a03 (5.95 MiB)      0x77e948 (7.49 MiB)
                      increase:                1.54 MiB (25.8%)
  #modules            10                       10
  module BTF size     0x20c5 (8.19 KiB)        0x3235 (12.55 KiB)
                      increase:                4.36 KiB (53.2%)

The module size increases more compared to the vmlinux, because each
module's BTF doesn't define many types, so the variables are larger as a
percentage of the total. These are also rather small modules (whichever few
were enabled for the build of an x86_64 defconfig), I'd expect larger
modules to have a smaller relative increase, because they would define more
of their own types.

To sanity check the output, I looked at the "DATASEC" generated for the
percpu section, and verified that it was nearly identical. The only
difference (besides the type IDs) was the addition of the fixed_percpu_data
variable, which had been omitted by pahole's master branch:

    --- percpu_datasec_master.txt   2024-09-12 00:04:37.255240578 +0000
    +++ percpu_datasec_global_var.txt       2024-09-12 00:04:24.214980821 +0000
    @@ -1,4 +1,5 @@
    -DATASEC '.data..percpu' size=199384 vlen=302
    +DATASEC '.data..percpu' size=199384 vlen=303
    +offset=0 size=48 (VAR 'fixed_percpu_data')
     offset=4096 size=4096 (VAR 'cpu_debug_store')
     offset=8192 size=16384 (VAR 'irq_stack_backing_store')
     offset=24576 size=20480 (VAR 'cpu_tss_rw')

Finally, you can find below a summary of the vmlinux DATASEC outputs which
were added by this patch in this build scenario.

    DATASEC '.rodata' size=2910928 vlen=6514
    DATASEC '__init_rodata' size=48 vlen=1
    DATASEC '__param' size=21640 vlen=537
    DATASEC '__modver' size=1008 vlen=14
    DATASEC '.data' size=2953985 vlen=16451
    DATASEC '.orc_header' size=20 vlen=1
    DATASEC '.vvar' size=656 vlen=2
    DATASEC '.data..percpu' size=199384 vlen=303
    DATASEC '.init.data' size=690040 vlen=4830
    DATASEC '.x86_cpu_dev.init' size=40 vlen=5
    DATASEC '.apicdrivers' size=16 vlen=1
    DATASEC '.data_nosave' size=4 vlen=1
    DATASEC '.bss' size=693060 vlen=2532
    DATASEC '.brk' size=196608 vlen=2

I know the overheads are non-negligible, but I think there will be
considerable value in having the global variables present. Thanks for
reading this and I look forward to discussing!

[1]: https://github.com/osandov/drgn
[2]: https://github.com/osandov/drgn/issues/176

PS: Previous iterations were sent in 2022:
v1 https://lore.kernel.org/dwarves/20220826184911.168442-1-stephen.s.brennan@oracle.com/
v2 https://lore.kernel.org/dwarves/20221104231103.752040-1-stephen.s.brennan@oracle.com/

Difference from these: I've gotten a much better understanding of DWARF,
BTF, and the pahole code since then. In particular, the older patches did
not include DATASEC for anything other than percpu variables. Also, since
those older patches, I've dramatically improved the variable filtering,
including using DW_AT_artificial, name filtering, and getting rid of static
local variables.

Stephen Brennan (4):
  dutil: return ELF section name when looked up by index
  dwarf_loader: add "artificial" and "top_level" variable flags
  btf_encoder: cache all ELF section info
  btf_encoder: add global_var feature to encode globals

 btf_encoder.c      | 371 ++++++++++++++++++++++-----------------------
 btf_encoder.h      |   8 +
 dutil.c            |   9 +-
 dutil.h            |   2 +-
 dwarf_loader.c     |  12 +-
 dwarves.h          |   3 +
 man-pages/pahole.1 |   8 +-
 pahole.c           |  11 +-
 8 files changed, 223 insertions(+), 201 deletions(-)

-- 
2.43.5

