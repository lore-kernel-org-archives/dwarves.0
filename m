Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389361BDA90;
	Thu, 12 Sep 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168134; cv=fail; b=j1VhxksD97KrZAE1jzpb0wigr8MQJxBC/tA8k7wWiB/smexIcpulS3PyOVU/A5v7kc7gnOOUqRj7xoqtJhaLNACCJNCjW8NOkWhVa/QPTfS25TLVunFlw092exojyDrbsZqpbV4czIbS5rpr0N+FhkR4LpIeWngZBs/bUl04WH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168134; c=relaxed/simple;
	bh=IvCjxnJtc7+XQAfk52GDRSbnZA/9LcuLOzN94iTYMDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGHKhbyebeATsiiIkra6ZGyCbkUy00Z32ViSrESuyRT2gmW5Pyse4EU9iWc0CGbHye0t4klNZqa7W3rlv9eo8I1kVMQTid+nO25TQDc0+cXDCDkZVSONVKrgEiZJulcDUAnLJ2Mxs+hLqFUc7sDzcJPXbgopkmWtfrq+ymfgxec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=no13vz0R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g8ezS72R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="no13vz0R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g8ezS72R"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIfXqE021180;
	Thu, 12 Sep 2024 19:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=n1oQM6Ik5jCHDeKyX8rIEXvkD65ik91tolapq2MpGCg=; b=
	no13vz0Ruj9GfcjI7Wh/vDcVQ5X2q7GIdg9KDy4k9GoVWD2C5Y6S/t3b+wTuC/Pz
	AaNKZ3bhorGHuDj180vAhx0mIWKq+XYiC626Yv0TMFUnjb4SIOS8Wus82b2Oi1sQ
	r0oZkwxs+Fo7KmFTVyWtUUdmejzCoom2MowpJioQBrfirietX1IRph4//9FRzZNB
	leNUO22K5hkeAarx24qVW/K4qj5n9KqikIriQlSlE1iyA+uQJqOhM8WrrEoS/zuV
	PCexNOGxL7WrvREFP55fg7Ky1VWnDte0qi+gBQq3gvvUwoujf8fnju24FhHb2Iko
	dC+YDic/MaNie6VbychQ3g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde0btqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIj9cb033550;
	Thu, 12 Sep 2024 19:08:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bqc4r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+lJomBPJL8lBvOP06UmSa2l3NFAKMP6WS4IIN89RmH9TdCpDEwST61jfY1sQsyrl3CVOWxcd6aBnFrJ9zrWc2m0eZnDNaB6bIxG3a83FBz4R/al+9pD4nb97sgdKvB4u9qibBJ6TJfL+HgfQ70ZFtn42q6KE3b41/xJOv5VY9avvl41GAComF2z1iigknUfqMg+Ey0BZwG1sryV9YVwjp53g6Lq5UdJ8M33y6ngyyl1UnVzq4t42vc9YES0H7GdFnTzaeG5w0C3TbdNRmLVDTitMdZGlTpeH+/E858IL92GtOjIETZpupyhvAMuZQv7LNk4Hr9bXpkUdmzRIAN2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1oQM6Ik5jCHDeKyX8rIEXvkD65ik91tolapq2MpGCg=;
 b=v8e123BANxwrqFKGybahDw7ooRryrLSe0Sykhv4tElfVej6vW8Umdz7iNByGnuIYWhixiHUS4dEk9tzjmLphCz7eLc4Dwh3AJW2YUr/awAj8YKN8TSRIvr5kLHv+3erE/zenqQlkTOPDqTzjMSDfEXryNjN9Oy0L0JSB56BRW48jWTWTm8Q6K7oocYmmKvi45VewP8DzZcLxjanIaU9ESb5opAnGkYJBmhb1D3ZYazJGNwBHje3Kh2gHBv/C6IyZ/iTY9FDvtLF22ff3+pLlhmQksbmlh9eeeXbWMUzT9XbUb+dSYfH14A7sRWAYm29cqp4tqNlt0w4p5glVuZWLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1oQM6Ik5jCHDeKyX8rIEXvkD65ik91tolapq2MpGCg=;
 b=g8ezS72Rdlyd+1yxZbNqJfg5LXXA5nnshWi05GTtiFjhUT/0nPYv7YJcvOZ5th81MWqYnmoEhlc9sind3x9mg3yPf2XxU0oJL8u+CxiUVNA64TG45AJpoSV4jxe26B0tLWs0qP2Wn8cW+jsmb532vR9pR16FNC7/wXfVsxErWKs=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW4PR10MB6533.namprd10.prod.outlook.com (2603:10b6:303:21b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 12 Sep
 2024 19:08:40 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7939.007; Thu, 12 Sep 2024
 19:08:40 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 4/4] btf_encoder: add global_var feature to encode globals
Date: Thu, 12 Sep 2024 12:08:23 -0700
Message-ID: <20240912190827.230176-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:208:52d::23) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW4PR10MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 3319bf0e-1d87-46e1-ddf3-08dcd35e502d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IFalqmfdmi6UPE77XYosCAWlDslzRPO0nxs+Iqf7VlUwQeMDegyN4/EgWY3s?=
 =?us-ascii?Q?s/QlejbxwhLAHy7iR0vykTAevcFircZi2QrQVaQdir0A1B4+Xg4AnagZwlYn?=
 =?us-ascii?Q?54T/YrQB8uDwJimI+2kd+7ZD2EZtFIkDfa7Z9TMkJ+A4TbpctdAokrNIYhao?=
 =?us-ascii?Q?Gev3GkCOc1Hizaq1/KmWdHyEig87SVLjuSPCgscBK65gioT2E+gcjfcs6RC4?=
 =?us-ascii?Q?9UX8oE2V89EXH26JmjugJpBAdhkfSviyYvcAYRNhBXTrV1v9xr6dFjMxhamP?=
 =?us-ascii?Q?r1vN5PQ1DEfnEInq5JFJ2NGPniWh3TY6bg6e4PDsTXAyDHo/9xINKeCD/YJ4?=
 =?us-ascii?Q?Kl/cR8BDO4FOBOn9vd4xcHmlhAaO3OVl6lKPY/w9Copizb1DbOiRiblOuNma?=
 =?us-ascii?Q?x3fW8Adl4ryxJareDgaEguPfzIrY25mM9iJhc2gxTSqSbZZAryU6cc4kf/e7?=
 =?us-ascii?Q?MsnzA7i2TB8sBvibWrr2W1/zOC85RFhcjHeabtUvVtzyLLXmeYw5SIXA9e+c?=
 =?us-ascii?Q?bwDUgdsbr3HnczpIPiue9LdwBoqZjC1e3EUc6vu/hr9ZeEt5uF2CrYPIg+zL?=
 =?us-ascii?Q?JoqPsSyKuC2d/E86T45DLPDjhIVhu+w+XZc5YJehQ9UOeyGzH2SHFsMNSRuX?=
 =?us-ascii?Q?wI2sN1gNW82KI2llxZz5KEr+Nc43OvR2Mkevq9hZtXgPJd7L/NVzP2wt2bb5?=
 =?us-ascii?Q?gapPd1xnH1zz/fKNBUqTti4P5YtgQGO1kcfhp+xYFbMK1FPhqKeh74QTZ2eX?=
 =?us-ascii?Q?13AjnScOIMr2NQmYlhOYjP4F25X1dEOCih+jJqcsg017uXZalKsEM0ht6ob2?=
 =?us-ascii?Q?OPYMvpSVLwMgCimsA33xmEwc9C7kELwlyCrCexyHw3JuvgzkuqlKEczMj1mM?=
 =?us-ascii?Q?iilae90p/EDmDpDItXS9IaeKegxS4KYA4P+74DIbsmIEKH+RJMfazzHlN1cm?=
 =?us-ascii?Q?CJ8iPEwl2WQRbEeE4qboB7KogNlKH/bC+mxUrKiOhGsLejF7dRQrK4fW0pSK?=
 =?us-ascii?Q?B4RXslVjJlKmfbvgPqabpIEYUzCGjJFDzp5J+nnWRo2B9/LcR0QjuykmzWGG?=
 =?us-ascii?Q?7HVFOEAzHpG0QRnyz5iAyXAhXKUQBAPh8+gdvNg2Y0sJ2ni6GZd+bhP2cVra?=
 =?us-ascii?Q?b8B4AxW0zlgX0n3rxFrC4I+AFvVmmx7cnhpr5akHlNbe5gtxEypRCdl/B9dJ?=
 =?us-ascii?Q?W+1GYzHU9s3eeC5uwH+6a0G6AX0/yMSvF8Gb7Lmbv+pbLy4ypxg8m3TkoMCU?=
 =?us-ascii?Q?ckJMGy1/8jdGH80ZUzwe7ykLFImnuZJQpegq7WvKn/pmjXBXpFOyPZbZYuzF?=
 =?us-ascii?Q?tpBEBUWdCDEfE70EFiAsUrroKpqVvzvyU13uUGLoJ6aEdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coaz3AB7+8dt66rygrOYQD4y6J3bZb/xxG4RwCCH3xf22XgoBKlPwPArLMnz?=
 =?us-ascii?Q?vpJ8i40cz0s/AXYOKuNCKg6i7d8n2dLCCOe8Wp7tbYvzhu4i3ubkomv3c9LU?=
 =?us-ascii?Q?lXijwImrZGUIxpM9+Mi5GAaCmCA8jaso0t17aPTqnmsZWhxPy5W9aaiWK5zs?=
 =?us-ascii?Q?O5XDT/SZfr2w7jSAYNo5u+09MISq7tOS5QBK4pGNrmpvNMW/cG6PAVvmFM4E?=
 =?us-ascii?Q?R1YamGBSCs7AttDFHmUAbh0cVjhK0dBxG1tNenCyV+RT5hvNS75DSNJQyfdv?=
 =?us-ascii?Q?R5mqti5Xeqo5X9mkLrjOj5AqRHznF6dQpPD3tiaZ4WaTpLW+0QBUdAOzSFrZ?=
 =?us-ascii?Q?XGtEYoSVp1RoicNiqNkNjUf5eGepEekZAt5hi+e+yF/C0RcVocQVUR21dHu9?=
 =?us-ascii?Q?5vmiLwt9SfCWxheA5hvajRT5akaAFNLSjR+jr2xA27u6+E6nMpuvbaFcpiTv?=
 =?us-ascii?Q?14t3H6d/HJQaDyfa8zXyMb0YWWmyZe9Kb/QWRY8iI8DmRbU7JxNWJRkFW5jW?=
 =?us-ascii?Q?OyCfHYKerp78p2FOf77gyTlyvwEF5TI4t9VwrOAKwXVzv1jr7lSfjlyqhqf9?=
 =?us-ascii?Q?gEw+xHWZa3MPEGayaQST2RHpV6wmppr3z44PHEWas3arOEQej7oTKwXzvB8O?=
 =?us-ascii?Q?LWcIyeM5wg9i5NmWHPSyMUHDX/p70soirshH9Lnpf6g8k8YUtgToQd6iQLPb?=
 =?us-ascii?Q?rOFB/T8UEt3geH0cM0bKMB1YT9MsY9EI4HXRLzss5UiWexFK+74O1SraxnVS?=
 =?us-ascii?Q?fq0dYNc3DFvAqBEEC+BoSJkGmZkxbUCdspVexpHaFXUGXGX6dly9FV/p1cxd?=
 =?us-ascii?Q?3yc345dcFlV1ZDr6nY1QmrgzHgYb1F+3U0eTA2RVPLEZ66HEf7X25UfSn4FD?=
 =?us-ascii?Q?g4AHfrD/yfFyhuUkz59kZ9M7713bgqqojbPEvNI7qb0BaLeLYv4jokYQ2FU4?=
 =?us-ascii?Q?4MzXPk5IHNhFaLDtBUJDGLTfX/rbHphFVTXIx9uqV1jOluolsl6Ztd9jXc5t?=
 =?us-ascii?Q?d+XI1X4jnPBaBgjvOJfK0j4emWGrEU1eO4HIwMDGxAUOzKE0g9RrsGUcrlPg?=
 =?us-ascii?Q?8qwAxzu5qW4GT/GtxtRjb/1UjkyXgNwNbpcoDRckFG8AD7nHLny3sX1Nh6gg?=
 =?us-ascii?Q?Hc7QXIv9dePHFyM0WtPhkFhiT+rMXIZ0dQqP5eGBpZ+xxfLsZSIYFph7Lz81?=
 =?us-ascii?Q?OJkk4h9jOnb4KzMwR3CjqOsSjet1hHaxG8O7oTACfUmxR7uq3K44XCuspupG?=
 =?us-ascii?Q?WUuBKdN3Ilsz0B8kMISVHjohz3Pljl9RJ2n2Mkh8UzKcKNEEFFAnIElhxHTK?=
 =?us-ascii?Q?qPBqJ7zvqi9zdQ7CZlmoQ1pu/1BPnTwvUPghoR40iKA9sAmj8vegKIL4yDEd?=
 =?us-ascii?Q?zCRARUZ5SI5FMR2lyBGKbGTf9yWs4iDTaOHWZCXhdmFdwLU7XJGwaC2EkxzY?=
 =?us-ascii?Q?T8ojuJ8J4/d/AnJ0wTHYeTuniP1aTjASG4moPZYg0KrFPiVqQYGzmofxa9GQ?=
 =?us-ascii?Q?bw3WFo0VpCGTzKYswd2aXyxWYO4LWh8RVa9prGJFHS/vmD/s2cq8ipMMjTih?=
 =?us-ascii?Q?wSbxkfBMoYs309Ax+5d4C74+sC7/Sp4HOmgNYA9fIDbPgj5RDvkGI6MKlUX9?=
 =?us-ascii?Q?FYJekbbzSLURlLR6WI+VsE8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p+QKmIv7Vm1t+iL8T5Dec/MiZOTvgUu8h1gibDYEo4GmoruEq1epSkSajUjCZmpvVnuLurq0ZTYsEFx4byswrDtIgJoWy7siALb0WOLlezdmeQHUWV5tru7nBSdmIvJjDPoucPXu2B5DF2FvrURdiDkW4tmGdfb/VExBh2zuH6+oyHBJzDgffeDZIhX3P7hbhZLOYqUU2/hoLuVubhfF+ssmH1pmu+vjO8FyBBgEIGhY7Y68hNFk4ShtVb/Xul/EeVTAH6EOWNFEqQXRr1FEmmaYfOywj+2xM7DWgmnDBQSuqEEM3muOJh3HbT3gqcIbJx4alzedsUw5uPAJqN7aRfTRNtUez2ktgmFdqQfdeydxja353QsSiRLL8kafXtd+oqYfll1/rTt+iM+iccFJv6WAUmhUErwXErhyT3+qCCMfE2z91Mb9Gh0eXnYwm1gzHVAvQS2X/lIGjsiL/Ri1ntpdvbkFCCJzwYgbggyOyxSAXiPJ9oIRjyZLkCAdL+wgxtHoXBvr1p/14H2uUfYZgCFXc3xbY86eCGLXPNilOW++PqZzseKSvgktstyhigX+v/xbrL/l5/YjnfmWlZAs6M9Et/SlARLbEiu7AKBzIJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3319bf0e-1d87-46e1-ddf3-08dcd35e502d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:08:40.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3QwfcFZM2OvjjvRugc68UTAJps7VvaoTQUYQeGPcOv58VSADwLjfJ8IW+AgDgQC7RmfkYgt+voRu7eVL9Eb7cz++fCkklHX50oUTJj5PoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409120141
X-Proofpoint-ORIG-GUID: qoP7x3Y2itMweEOQJlWLSdqhgyd1Jqke
X-Proofpoint-GUID: qoP7x3Y2itMweEOQJlWLSdqhgyd1Jqke

Currently the "var" feature only encodes percpu variables. Add the
ability to encode all global variables.

This also drops the use of the symbol table to find variable names and
compare them against DWARF names. We simply rely on the DWARF
information to give us all the variables.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c      | 345 ++++++++++++++++++++-------------------------
 btf_encoder.h      |   8 ++
 dwarves.h          |   1 +
 man-pages/pahole.1 |   8 +-
 pahole.c           |  11 +-
 5 files changed, 181 insertions(+), 192 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e3384e5..1872a35 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -67,16 +67,13 @@ struct elf_function {
 
 #define MAX_ELF_SEC_CNT    128
 
-struct var_info {
-	uint64_t    addr;
-	const char *name;
-	uint32_t    sz;
-};
-
 struct elf_secinfo {
 	uint64_t    addr;
 	const char *name;
 	uint64_t    sz;
+	bool        include;
+	uint32_t    type;
+	struct gobuffer secinfo;
 };
 
 /*
@@ -86,31 +83,24 @@ struct btf_encoder {
 	struct list_head  node;
 	struct btf        *btf;
 	struct cu         *cu;
-	struct gobuffer   percpu_secinfo;
 	const char	  *source_filename;
 	const char	  *filename;
 	struct elf_symtab *symtab;
 	uint32_t	  type_id_off;
 	bool		  has_index_type,
 			  need_index_type,
-			  skip_encoding_vars,
 			  raw_output,
 			  verbose,
 			  force,
 			  gen_floats,
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
-			  is_rel,
 			  gen_distilled_base;
 	uint32_t	  array_index_id;
 	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
 	size_t             seccnt;
-	struct {
-		struct var_info *vars;
-		int		var_cnt;
-		int		allocated;
-		uint32_t	shndx;
-	} percpu;
+	int                encode_vars;
+	uint32_t           percpu_shndx;
 	struct {
 		struct elf_function *entries;
 		int		    allocated;
@@ -737,46 +727,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
 	return id;
 }
 
-static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
-				     uint32_t offset, uint32_t size)
+static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, int shndx,
+					    uint32_t type, unsigned long addr, uint32_t size)
 {
 	struct btf_var_secinfo si = {
 		.type = type,
-		.offset = offset,
+		.offset = addr,
 		.size = size,
 	};
-	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
+	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
 }
 
 int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
 {
-	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
-	size_t sz = gobuffer__size(var_secinfo_buf);
-	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
-	uint32_t type_id;
-	uint32_t next_type_id = btf__type_cnt(encoder->btf);
-	int32_t i, id;
-	struct btf_var_secinfo *vsi;
-
+	int shndx;
 	if (encoder == other)
 		return 0;
 
 	btf_encoder__add_saved_funcs(other);
 
-	for (i = 0; i < nr_var_secinfo; i++) {
-		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
-		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
-		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
-		if (id < 0)
-			return id;
+	for (shndx = 0; shndx < other->seccnt; shndx++) {
+		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
+		size_t sz = gobuffer__size(var_secinfo_buf);
+		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
+		uint32_t type_id;
+		uint32_t next_type_id = btf__type_cnt(encoder->btf);
+		int32_t i, id;
+		struct btf_var_secinfo *vsi;
+
+		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
+			fprintf(stderr, "mismatched ELF sections at index %d: \"%s\", \"%s\"\n",
+				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
+			return -1;
+		}
+
+		for (i = 0; i < nr_var_secinfo; i++) {
+			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
+			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
+			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
+			if (id < 0)
+				return id;
+		}
 	}
 
 	return btf__add_btf(encoder->btf, other->btf);
 }
 
-static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
+static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, int shndx)
 {
-	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
+	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
+	const char *section_name = encoder->secinfo[shndx].name;
 	struct btf *btf = encoder->btf;
 	size_t sz = gobuffer__size(var_secinfo_buf);
 	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
@@ -1743,13 +1743,14 @@ out:
 int btf_encoder__encode(struct btf_encoder *encoder)
 {
 	bool should_tag_kfuncs;
-	int err;
+	int err, shndx;
 
 	/* for single-threaded case, saved funcs are added here */
 	btf_encoder__add_saved_funcs(encoder);
 
-	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
-		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
+	for (shndx = 0; shndx < encoder->seccnt; shndx++)
+		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
+			btf_encoder__add_datasec(encoder, shndx);
 
 	/* Empty file, nothing to do, so... done! */
 	if (btf__type_cnt(encoder->btf) == 1)
@@ -1799,111 +1800,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	return err;
 }
 
-static int percpu_var_cmp(const void *_a, const void *_b)
-{
-	const struct var_info *a = _a;
-	const struct var_info *b = _b;
-
-	if (a->addr == b->addr)
-		return 0;
-	return a->addr < b->addr ? -1 : 1;
-}
-
-static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
-{
-	struct var_info key = { .addr = addr };
-	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
-					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
-	if (!p)
-		return false;
-
-	*sz = p->sz;
-	*name = p->name;
-	return true;
-}
-
-static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
-{
-	const char *sym_name;
-	uint64_t addr;
-	uint32_t size;
-
-	/* compare a symbol's shndx to determine if it's a percpu variable */
-	if (sym_sec_idx != encoder->percpu.shndx)
-		return 0;
-	if (elf_sym__type(sym) != STT_OBJECT)
-		return 0;
-
-	addr = elf_sym__value(sym);
-
-	size = elf_sym__size(sym);
-	if (!size)
-		return 0; /* ignore zero-sized symbols */
-
-	sym_name = elf_sym__name(sym, encoder->symtab);
-	if (!btf_name_valid(sym_name)) {
-		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
-				    sym_name, encoder->verbose, encoder->force);
-		if (encoder->force)
-			return 0;
-		return -1;
-	}
-
-	if (encoder->verbose)
-		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
-
-	/* Make sure addr is section-relative. For kernel modules (which are
-	 * ET_REL files) this is already the case. For vmlinux (which is an
-	 * ET_EXEC file) we need to subtract the section address.
-	 */
-	if (!encoder->is_rel)
-		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
-
-	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
-		struct var_info *new;
-
-		new = reallocarray_grow(encoder->percpu.vars,
-					&encoder->percpu.allocated,
-					sizeof(*encoder->percpu.vars));
-		if (!new) {
-			fprintf(stderr, "Failed to allocate memory for variables\n");
-			return -1;
-		}
-		encoder->percpu.vars = new;
-	}
-	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
-	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
-	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
-	encoder->percpu.var_cnt++;
-
-	return 0;
-}
 
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
+static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
 {
-	Elf32_Word sym_sec_idx;
+	uint32_t sym_sec_idx;
 	uint32_t core_id;
 	GElf_Sym sym;
 
-	/* cache variables' addresses, preparing for searching in symtab. */
-	encoder->percpu.var_cnt = 0;
-
-	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
-		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
-			return -1;
 		if (btf_encoder__collect_function(encoder, &sym))
 			return -1;
 	}
 
-	if (collect_percpu_vars) {
-		if (encoder->percpu.var_cnt)
-			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
-
-		if (encoder->verbose)
-			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
-	}
-
 	if (encoder->functions.cnt) {
 		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
 		      functions_cmp);
@@ -1925,75 +1833,126 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
 	return true;
 }
 
+static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
+{
+	for (int i = 1; i < encoder->seccnt; i++)
+		/* Variables are only present in PROGBITS or NOBITS (.bss) */
+		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
+		     encoder->secinfo[i].type == SHT_NOBITS) &&
+		    encoder->secinfo[i].addr <= addr &&
+		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
+			return i;
+	return 0;
+}
+
+/*
+ * Filter out variables / symbol names with common prefixes and no useful
+ * values. Prefixes should be added sparingly, and it should be objectively
+ * obvious that they are not useful.
+ */
+static bool filter_variable_name(const char *name)
+{
+	static const struct { char *s; size_t len; } skip[] = {
+		#define X(str) {str, sizeof(str) - 1}
+		X("__UNIQUE_ID"),
+		X("__tpstrtab_"),
+		X("__exitcall_"),
+		X("__func_stack_frame_non_standard_")
+		#undef X
+	};
+	int i;
+
+	if (*name != '_')
+		return false;
+
+	for (i = 0; i < sizeof(skip) / sizeof(skip[0]); i++)
+		if (strncmp(name, skip[i].s, skip[i].len) == 0)
+			return true;
+	return false;
+}
+
 static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 {
 	struct cu *cu = encoder->cu;
 	uint32_t core_id;
 	struct tag *pos;
 	int err = -1;
-	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
 
-	if (encoder->percpu.shndx == 0 || !encoder->symtab)
+	if (!encoder->symtab)
 		return 0;
 
 	if (encoder->verbose)
-		printf("search cu '%s' for percpu global variables.\n", cu->name);
+		printf("search cu '%s' for global variables.\n", cu->name);
 
 	cu__for_each_variable(cu, core_id, pos) {
 		struct variable *var = tag__variable(pos);
-		uint32_t size, type, linkage;
-		const char *name, *dwarf_name;
+		uint32_t type, linkage;
+		const char *name;
 		struct llvm_annotation *annot;
 		const struct tag *tag;
+		int shndx;
+		struct elf_secinfo *sec = NULL;
 		uint64_t addr;
 		int id;
+		unsigned long size;
 
+		/* Skip incomplete (non-defining) declarations */
 		if (var->declaration && !var->spec)
 			continue;
 
-		/* percpu variables are allocated in global space */
-		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
+		/*
+		 * top_level: indicates that the variable is declared at the top
+		 *   level of the CU, and thus it is globally scoped.
+		 * artificial: indicates that the variable is a compiler-generated
+		 *   "fake" variable that doesn't appear in the source.
+		 * scope: set by pahole to indicate the type of storage the
+		 *   variable has. GLOBAL indicates it is stored in static
+		 *   memory (as opposed to a stack variable or register)
+		 *
+		 * Some variables are "top_level" but not GLOBAL:
+		 *   e.g. current_stack_pointer, which is a register variable,
+		 *   despite having global CU-declarations. We don't want that,
+		 *   since no code could actually find this variable.
+		 * Some variables are GLOBAL but not top_level:
+		 *   e.g. function static variables
+		 */
+		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
 			continue;
 
 		/* addr has to be recorded before we follow spec */
 		addr = var->ip.addr;
-		dwarf_name = variable__name(var);
 
-		/* Make sure addr is section-relative. DWARF, unlike ELF,
-		 * always contains virtual symbol addresses, so subtract
-		 * the section address unconditionally.
-		 */
-		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
+		/* Get the ELF section info for the variable */
+		shndx = get_elf_section(encoder, addr);
+		if (shndx && shndx < encoder->seccnt)
+			sec = &encoder->secinfo[shndx];
+		if (!sec || !sec->include)
 			continue;
-		addr -= pcpu_scn->addr;
 
-		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
-			continue; /* not a per-CPU variable */
+		/* Convert addr to section relative */
+		addr -= sec->addr;
 
-		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
-		 * have addr == 0, which is the same as, say, valid
-		 * fixed_percpu_data per-CPU variable. To distinguish between
-		 * them, additionally compare DWARF and ELF symbol names. If
-		 * DWARF doesn't provide proper name, pessimistically assume
-		 * bad variable.
-		 *
-		 * Examples of such special variables are:
-		 *
-		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
-		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
-		 *  3. __exitcall(fn), functions which are labeled as exit calls.
-		 *
-		 *  This is relevant only for vmlinux image, as for kernel
-		 *  modules per-CPU data section has non-zero offset so all
-		 *  per-CPU symbols have non-zero values.
-		 */
-		if (var->ip.addr == 0) {
-			if (!dwarf_name || strcmp(dwarf_name, name))
+		/* DWARF specification reference should be followed, because
+		 * information like the name & type may not be present on var */
+		if (var->spec)
+			var = var->spec;
+
+		name = variable__name(var);
+		if (!name)
+			continue;
+
+		/* Check for invalid BTF names */
+		if (!btf_name_valid(name)) {
+			dump_invalid_symbol("Found invalid variable name when encoding btf",
+					    name, encoder->verbose, encoder->force);
+			if (encoder->force)
 				continue;
+			else
+				return -1;
 		}
 
-		if (var->spec)
-			var = var->spec;
+		if (filter_variable_name(name))
+			continue;
 
 		if (var->ip.tag.type == 0) {
 			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
@@ -2005,9 +1964,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		}
 
 		tag = cu__type(cu, var->ip.tag.type);
-		if (tag__size(tag, cu) == 0) {
+		size = tag__size(tag, cu);
+		if (size == 0) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
+				fprintf(stderr, "Ignoring zero-sized variable '%s'...\n", name ?: "<missing name>");
 			continue;
 		}
 
@@ -2037,13 +1997,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		}
 
 		/*
-		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
-		 * encoder->types later when we add BTF_VAR_DATASEC.
+		 * Add the variable to the secinfo for the section it appears in.
+		 * Later we will generate a BTF_VAR_DATASEC for all any section with
+		 * an encoded variable.
 		 */
-		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
+		id = btf_encoder__add_var_secinfo(encoder, shndx, id, addr, size);
 		if (id < 0) {
 			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
-			        name, addr);
+				name, addr);
 			goto out;
 		}
 	}
@@ -2070,7 +2031,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
-		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
 		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
@@ -2078,6 +2038,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
 		encoder->array_index_id  = 0;
+		encoder->encode_vars = 0;
+		if (!conf_load->skip_encoding_btf_vars)
+			encoder->encode_vars |= BTF_VAR_PERCPU;
+		if (conf_load->encode_btf_global_vars)
+			encoder->encode_vars |= BTF_VAR_GLOBAL;
 
 		GElf_Ehdr ehdr;
 
@@ -2087,8 +2052,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out_delete;
 		}
 
-		encoder->is_rel = ehdr.e_type == ET_REL;
-
 		switch (ehdr.e_ident[EI_DATA]) {
 		case ELFDATA2LSB:
 			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
@@ -2127,15 +2090,21 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			encoder->secinfo[shndx].addr = shdr.sh_addr;
 			encoder->secinfo[shndx].sz = shdr.sh_size;
 			encoder->secinfo[shndx].name = secname;
-
-			if (strcmp(secname, PERCPU_SECTION) == 0)
-				encoder->percpu.shndx = shndx;
+			encoder->secinfo[shndx].type = shdr.sh_type;
+			if (encoder->encode_vars & BTF_VAR_GLOBAL)
+				encoder->secinfo[shndx].include = true;
+
+			if (strcmp(secname, PERCPU_SECTION) == 0) {
+				encoder->percpu_shndx = shndx;
+				if (encoder->encode_vars & BTF_VAR_PERCPU)
+					encoder->secinfo[shndx].include = true;
+			}
 		}
 
-		if (!encoder->percpu.shndx && encoder->verbose)
+		if (!encoder->percpu_shndx && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 
-		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
+		if (btf_encoder__collect_symbols(encoder))
 			goto out_delete;
 
 		if (encoder->verbose)
@@ -2156,7 +2125,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 		return;
 
 	btf_encoders__delete(encoder);
-	__gobuffer__delete(&encoder->percpu_secinfo);
+	for (int i = 0; i < encoder->seccnt; i++)
+		__gobuffer__delete(&encoder->secinfo[i].secinfo);
 	zfree(&encoder->filename);
 	zfree(&encoder->source_filename);
 	btf__free(encoder->btf);
@@ -2166,9 +2136,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	encoder->functions.allocated = encoder->functions.cnt = 0;
 	free(encoder->functions.entries);
 	encoder->functions.entries = NULL;
-	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
-	free(encoder->percpu.vars);
-	encoder->percpu.vars = NULL;
 
 	free(encoder);
 }
@@ -2321,7 +2288,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			goto out;
 	}
 
-	if (!encoder->skip_encoding_vars)
+	if (encoder->encode_vars)
 		err = btf_encoder__encode_cu_variables(encoder);
 
 	/* It is only safe to delete this CU if we have not stashed any static
diff --git a/btf_encoder.h b/btf_encoder.h
index f54c95a..c5424db 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -16,7 +16,15 @@ struct btf;
 struct cu;
 struct list_head;
 
+enum btf_var_option {
+	BTF_VAR_NONE = 0,
+	BTF_VAR_PERCPU = 1,
+	BTF_VAR_GLOBAL = 2,
+};
+#define BTF_VAR_ALL (BTF_VAR_PERCPU | BTF_VAR_GLOBAL)
+
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
+
 void btf_encoder__delete(struct btf_encoder *encoder);
 
 int btf_encoder__encode(struct btf_encoder *encoder);
diff --git a/dwarves.h b/dwarves.h
index 0fede91..fef881f 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -92,6 +92,7 @@ struct conf_load {
 	bool			btf_gen_optimized;
 	bool			skip_encoding_btf_inconsistent_proto;
 	bool			skip_encoding_btf_vars;
+	bool			encode_btf_global_vars;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
 	bool			reproducible_build;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 0a9d8ac..4bc2d03 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -230,7 +230,10 @@ the debugging information.
 
 .TP
 .B \-\-skip_encoding_btf_vars
-Do not encode VARs in BTF.
+.TQ
+.B \-\-encode_btf_global_vars
+By default, VARs are encoded only for percpu variables. These options allow
+to skip encoding them, or alternatively to encode all global variables too.
 
 .TP
 .B \-\-skip_encoding_btf_decl_tag
@@ -296,7 +299,8 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
 	encode_force       Ignore invalid symbols when encoding BTF; for example
 	                   if a symbol has an invalid name, it will be ignored
 	                   and BTF encoding will continue.
-	var                Encode variables using BTF_KIND_VAR in BTF.
+	var                Encode percpu variables using BTF_KIND_VAR in BTF.
+	global_var         Encode all global variables in the same way.
 	float              Encode floating-point types in BTF.
 	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
 	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
diff --git a/pahole.c b/pahole.c
index a33490d..27b7a7e 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1239,6 +1239,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_contains_enumerator 344
 #define ARGP_reproducible_build 345
 #define ARGP_running_kernel_vmlinux 346
+#define ARGP_encode_btf_global_vars 347
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1285,6 +1286,7 @@ struct btf_feature {
 } btf_features[] = {
 	BTF_DEFAULT_FEATURE(encode_force, btf_encode_force, false),
 	BTF_DEFAULT_FEATURE(var, skip_encoding_btf_vars, true),
+	BTF_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 	BTF_DEFAULT_FEATURE(float, btf_gen_floats, false),
 	BTF_DEFAULT_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
 	BTF_DEFAULT_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
@@ -1720,7 +1722,12 @@ static const struct argp_option pahole__options[] = {
 	{
 		.name = "skip_encoding_btf_vars",
 		.key  = ARGP_skip_encoding_btf_vars,
-		.doc  = "Do not encode VARs in BTF."
+		.doc  = "Do not encode VARs in BTF (default: percpu only)."
+	},
+	{
+		.name = "encode_btf_global_vars",
+		.key  = ARGP_skip_encoding_btf_vars,
+		.doc  = "Encode all global VARs in BTF (default: percpu only)."
 	},
 	{
 		.name = "btf_encode_force",
@@ -2047,6 +2054,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		show_supported_btf_features(stdout);	exit(0);
 	case ARGP_btf_features_strict:
 		parse_btf_features(arg, true);		break;
+	case ARGP_encode_btf_global_vars:
+		conf_load.encode_btf_global_vars = true;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.43.5

