Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795114426;
	b=C2eKvYeapxaREeg7rP69bVlCjZ6X7aaTQ9EDbDIr3k3c7V75hXLEQLkQgZkocbj+unqk
	 IIKQD/2NjsEuPbOVYC9Rjj26i9IDCPzpF+XDN3hizvEAx5zGp05S6Vda5zcaNzYr+nRGA
	 Bic616XCGxdGRvbIl9ceHeIg4t4pwEMk9xOB/VYG7HZDKIUwk1YNbJHOkr8ijnWx7Rpsx
	 T3U8dgQrJetHMtYCrj/TQ7iXapTB3L5Q+oWUvnn60LV7Y+iFsc/uzQM/76KQgD0nSy4v5
	 IT8fr+Bku1CKJMBh8LbpAeYZbZ9Hf7sLQw4sTqAnMnsKjjzZbhiLViCkTkYPnpRMsCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114426;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis;
	bh=Ik0hKmONn3kDMoOuExO2O1KduzxvvEkJaK3C5bwkqQw=;
	b=a6Fp/+OQYI/OyYIa607Egp4XgMsrQnA3+Hnghq3KhKmLGjcu2I+e9IFj20fxv3OVCVuo
	 TMGvdtcQf+Fg06Hu8dvqpOdnqd6HRX5RzTcF5KoQgO66S8/Cs20kE5d5Qtgzzpo/ynNv/
	 prZZvW4RK2sh/1ojBaBPjng2Rv9S2y1LlR5QdzE81X868uwjuKubN5g0BAAWkTTkCDXWl
	 w0LNHikvKjtUCJRsYWYezwepf5L+lWlGRJqLpEYRR8dKH8ikicPu70z/CdT/9u4ictBYU
	 mahjDhdwdDrJEhoiAnOLddH3CQ9rlIFagbFk2R/av79PTI82R+q/bOREia1pOqVdYCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=XFH4B0B5;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b="J/QBHSZm";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C9606AAAD;
	Thu, 19 Nov 2026 18:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC6C9606AAAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=XFH4B0B5;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=J/QBHSZm
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJFJTqP1657658;
	Thu, 19 Nov 2026 18:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Ik0hKmONn3kDMoOu
	ExO2O1KduzxvvEkJaK3C5bwkqQw=; b=XFH4B0B53771HXdZRyV7+E0jKvpiBHgH
	+jA+RvCv/eFrHWO2x0cRgnvCmxcm+/deuM4q06jN4hk+rhKQLgpbAu/0mqneHzZs
	pLu+T3Y6IoeRh4a7InIeZo5SC0yRhg2RuIlPykM0PmMRRQZj5j7+ZA2rqrbibGqy
	kpq17gRi4+Rq9q7EbFKuHvlb4yF8hoB0UZveGzXNYe/xJwmeOjSv8CJWXcw/y+/q
	DyC4Gz6WW2G78qeQDv2+phxu8VktRcb0gXKgCd2pGABm6Qmee6+2I0XBMjiTcgAm
	84nfeYswYmFuN/hdMKkW7rASWVCViEF+nHemZnlbBjeIkO0ym7UifA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytq3gxa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 18:53:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJIcmPt3070616;
	Thu, 19 Nov 2026 18:53:41 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4j26jt8kdw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 18:53:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gp/Q4W28Co3/Om2EVbVvmH6GQ6c0WmqV4b4awjymBnoTCRNS81v19DE+1GiBktOowC6qjjAgb5hwwBsMFTUkybvXVC3yIi2iucwTeE4zBbpe+7OToyYlyhjftKsbGrfev4M//jTIXPqAiXZGzoBMwWjSLEMs6hA0KxMvGR8mPkPSPgiIn4Wuok5rrQgUnATabtHq2XmtHWDw1aensKk/Gpw5lBh8OWPx7hdc8LsymHpthg5uAMNdywQyviGaGk94Vs6eYdEpn2cVj2ekHY4Us/L7wpfiJUiz5Um8bGVmhU4wPEgXVZJ745eK4xO6Deo5awglKQ6lR5+PMIZk1D+qOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik0hKmONn3kDMoOuExO2O1KduzxvvEkJaK3C5bwkqQw=;
 b=zAGv4NSztOF0rM1kViVETU2i9cL78OZCtPJXpse8EUao9ZGR6RjzMFMXhIQYRd7fG0Z4E7+fUDUtoM3kXnqdVGmW5aWENedTBx2GodR09cWLRca25/P/L1NdmmlQ5TvLKQ/LrDfbi19m1RXZWZsbfGKrwciQHSEG0d5ui5zUAlXC2yJWj7FRcjw5b6V/YW52sqlUAjblWjUiy+ca5k31hZCIMJUxCp3lIJLc5Svj2kCjylXBcXZAU8wVsn/WZDeTvS1hPTcqCeLjsDt3n9mKSnI6ufovimh2a5kGyMxuZa3MxGJLjl45pwZgixbrsxv9bL3+8NU9+tQaJ2emP7Ou0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik0hKmONn3kDMoOuExO2O1KduzxvvEkJaK3C5bwkqQw=;
 b=J/QBHSZmrER2YtLT5bW+evyT/i3KL+ImO0iXZ7iU3OCfCDR1fP2GhduS5SzQ202+3KvRWSmzu3ko1+6bpv+grlOjCivIb+o/oU3z+k8TTEuKeGkkvCWGGtN64Bn68cOTa1V4Y1d2/QTpDIBk7uXOkcCdQQOdH9hfUuJwx/u6mSU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2557.namprd10.prod.outlook.com (2603:10b6:805:3f::22)
 by CH5PR10MB997719.namprd10.prod.outlook.com (2603:10b6:610:2f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 18:52:38 +0000
Received: from SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73]) by SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 18:52:38 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/2] Fix DATASEC assignment for global_var VARs
Date: Thu, 19 Nov 2026 10:52:32 -0800
Message-ID: <20261119185236.4113166-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::35) To SN6PR10MB2557.namprd10.prod.outlook.com
 (2603:10b6:805:3f::22)
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2557:EE_|CH5PR10MB997719:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ea298b-05e4-44ca-4d76-08df466e47d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|261009223027099003|3023799007|56012099006|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/uSQagUjowjDhRCX7F0vT/eO/N2Urkh+mPsaQP9Xlp4wfnWAujYRyfEykqmhVjwThc7ACRl51emBimSGTcs/gVFA3+LJIHvsOtUprKtta7bXreSqys/7YvvpD6tEs7yr7v5KzfeQd8u3W4Vvfj1VxyiA+0LiakNGAKlarjJDHX0LbilkoAJdRW+mOv/5RJO/2cpUdGnHFO1OFAayO3PGFUmMuSnylJ+xQzwcljpYTQimJ5NDDLjV3JyjZhn+3DX5B/YErTUCi73zUlpe5D0u1qGsTA2m7DyY0rz9cpcQ0bPWxRf3Ul4Airx6LnJC9iO/grgNUdtx1yWa7DOFEd/rpijptVloeyhMyfiEaHt9l3XzwQxaW9Q9I1H9PXNjLaEES0ML4J6gGxbPp1xclYe3SOJ6br6Mehi8DPgJp80xN0y7rETEbd9ierc6fd1JUnBhyGRzBFAm9w62jaZAXzwTGdbBG7a8JzQ1BkORaHKZABw+aO1dJTfk7s3R0SK2G6z35JxM0H4D54hXNJKZYVpA1PQHl/hwxwOmijMCXf4zGIYuOGK3ufMs1/3Fvp220eYgtGGmRwcholLhy/XiUrtFCd670+1aXRY3jlVd/xzyBOGB5uHgQHnorBRShG/opO3ZZci+GT8AfyazOevbbX68jonEzbJnkwIyCFmxEOYa86k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2557.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(261009223027099003)(3023799007)(56012099006)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3l+0G+wGOSgiZ0NW/o9cp+WP8zeclKQsAs+K6jo3M/ofJu1egODmCQNOjhcq?=
 =?us-ascii?Q?f7uwl/EKNEXLnEbPff9n46+cBwC34ZePAsdfYi10vMMZwNH1DaMAFM6aZX+X?=
 =?us-ascii?Q?A0Hi3EY/0bjruv/5JamJ7WtFzxff4yt0oHDeUEcWMb9pABwlliIE0aytw4Zj?=
 =?us-ascii?Q?zzMZ0Qc5ZVfByvoLMs0hqW1vUjxmVNVZn4YcUV3OHFSdQlk4a4Z7lU1Fkipt?=
 =?us-ascii?Q?OXgRqS+TUSLJgEqLjSGfgVEPkQMU1OnFeTI6UcKx+P9wAajY+N8OqEAznR3y?=
 =?us-ascii?Q?Aker4x9bOT+yskYYek/rOvAkjG/Bvxynlxw3sB7+QoXEyuoGyHHCXzZlLjKX?=
 =?us-ascii?Q?13lC6HIL22BpYjtoKqQMPgsKXItZFDch8yJbnJC2HcCw0Q5EF87nK9F485Lo?=
 =?us-ascii?Q?mGHCq7iBvMj2lKDnPcdE009JWVKoC7EM6yfdVAxjYR1D2YPqxUSOJi6CGPOC?=
 =?us-ascii?Q?Wqg++oY/tG7gH2KdtSQK5z3wvm6pJn9t4DPh5PS9zYbUK+hqYBAVkE2SyEs3?=
 =?us-ascii?Q?6JtAx89bbeH35EQ7I9WDXuNmQyZu54bntYwN1a/odCzoN0Q2rJx4Z8ukYvWn?=
 =?us-ascii?Q?j/YXtOIgV+IbyPMeqtIFIggcZe8NXIodnVchE+n9jm7pXrbspQhHxTC2RbrV?=
 =?us-ascii?Q?dCEFtbd5RDJMZXWkmM3g+6A7rBE8BRQPBVviiKZikXpNeIrnrxgSau/Ui4PD?=
 =?us-ascii?Q?cv07Pp11lpqjBuVXHED2zRwR9GLPmu4bI49TdQnKDanMIHhsZ2kMYeZHq8JD?=
 =?us-ascii?Q?rScwyM9DodF7KazNS5R/5Nv4JzWtL6NvtdTJGd8WqquVh2QERyUpZnMZC0Cj?=
 =?us-ascii?Q?GlG5mEhjFYGr6N7tvCK9urv0ZYaYNM1dCe1MZAifTvkLXZLjiFoGtUVAJahJ?=
 =?us-ascii?Q?c2+LuDEn5Ht2f9IakNlniCxHoIegiyoGNjCsUs1qUMbIJlsX/nXuRqdC9ba+?=
 =?us-ascii?Q?UbwkDzgI2++lLT7uGdC09/ysp8rqhA+fh1njrESCf6b8uwVmj1P7sxzEJGVB?=
 =?us-ascii?Q?KfNYigsc2nKizE4FA3rGLpYzJjfEcyjXEVI0qJy9++KWPAGFO4+n5eHoeWlN?=
 =?us-ascii?Q?VrQ/rPtEJt2kHWoBfRxS09AX2kr0WDHtwtTyKL0nMsQ6wKq49Q6/C1Wn/0FP?=
 =?us-ascii?Q?Y27febbw1AgPeuFapOQPaUFLPHbV3zm8C5dpJmNQ8/TU2q4mmnDbFRXPOeKJ?=
 =?us-ascii?Q?uMpB2RvIfneew/arKMWWkPpHEDk3DjVXaufhRmaC1jWVRiyKPm3BsgjMKbG1?=
 =?us-ascii?Q?aERpnuQhm3aQ1HdTghi7QVw01geMshSnN9APb2WqPwR6tkS96Txj8GDn50ed?=
 =?us-ascii?Q?oWQd+gg3cOElqvIc/Fi1uHyFGB6piimZ1D9ZLjPimfpAElU6MITQ1zp/tb+A?=
 =?us-ascii?Q?7xb3id2qdFV/a2ZGzfN2+sBKOoOgyTgJxhtD2bOFiESW7Tr8NkUeD4vTYbKl?=
 =?us-ascii?Q?jUDHRa5XS9I0dWcVVPvtlMLbk0GG0ZBxQ+WvDDsYsIvigqIE8LKR3TD4MRum?=
 =?us-ascii?Q?bHwtANfkiQKq70R6pDPF4uIwZ4286LXQpZYD534aKs3Wgaqf9klYa0eQuNQC?=
 =?us-ascii?Q?OhS8MEQVhctzoB2v2prUwClqeRo8TUqzZtr7jKCRYPZiesXBHyNU5GQJd8R7?=
 =?us-ascii?Q?p2Km7VxyBo3gARrP5uI4kON9pM1bY6dlkoWZjeZSAoDeAcYqkQME1XT46O+p?=
 =?us-ascii?Q?NjuGieywGM1oz8hPIAu42Kg/xpGvQyJtXX+wBDt1gfjxv4awdCNYlLp6TrOO?=
 =?us-ascii?Q?yIZXqpWfX8QoOk3axzHGQb4H2CxI6m8=3D?=
X-Exchange-RoutingPolicyChecked:
	M9BvJMy8kOUDIjJItDp/FrC/OOVdQpWutIVeed81SlSsdvBBOy1ayOpcDzH0+3xs3fISWZhDcEHeqT+sxRivugAMqQ5XWno46GnWWA86PwdeAziWUYGVJ2nGVgq1bGTwzbWjTS2KdgE31CYX0wuZ0NRzKQWh88OEFBL21WkBn8VG0EfjLNnW9ShK+NR/QY0lkGpyGLVezK/pg1TnRYwqCiH/x8RU55qmZnKG1KuR354fRZfMRDN1olkJcVNMZiVhGGvTPkmYm5/4ielt9GY1bNQdtZKSo4D2PDntbAIN9MywDvsnd0b8Sl20DJwITDLijCIgnNYc2LrypmIe+OT/AA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	15kaXrQwLZImv0M19TfqhsF6G27cMYeQcaEf/PNQbJi5ekMJb9PySe+GItIMedkNQkF0s1ekkAVMzTakpf7cZHfsmbLd14wdNIeNG4TpRT6Vy97oOJydkx/n01EtSy+hAjNmZEXju7vU5Eok0hdoZwFhIF46GnfMTDXq1eGbuyJAKPgwaieMjt3z0kAFLBADvGxZTCsoRPiEBo1LwZkaFT0LcfZHgEVA6l1NrW+g6puMeeYIwkqFyNOkxvHoQ17mr4etNI+x9GsBysmiSGXXAC79P/Avw2I2W5PKIbHeASj89GaLNHlBanx3qp3up2giw7rZXuqKL9+g7CWXyrNiKKtd5BR7jgqUrO5DZXTHUbhiDo3kZJGjfN/YsWvRwa90GGcvvxf4HlCu7N1I2r1xp2fjp1ZRRFLBJjBzLBS7r0jbKbccE11Uks9cAfe/XAQknzejIDjVq8/A3b40bBAjPY85c0SOKGAwd1thTtlLPYVwz/0jomsrYeL36rZqVsBA+S4UWpCogKhDLNhY0fL6rujJNOqUuZ8c1GGUIFy8L0uV4cezWNUEMHKWct+cLhchX1pNegjRptCT6d3XLHuYbPzTAtzLucGduNHmA5ek6R8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ea298b-05e4-44ca-4d76-08df466e47d4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2557.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 18:52:38.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTTm1Iz1oTuOA4lBx8u1XG+UESrd8Lrk3x9iXIrSv1uaw6gL5KeTVsQcmFNH9+u1q5tuMLV0KIh7+tKALgnpMTc3W7WJW2E62O83Y5oZuwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190075
X-Proofpoint-ORIG-GUID: nPMDf8C2NNPb8RK62qcdWrJL8ZGqm_8Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3NSBTYWx0ZWRfX0wewpY5MvHcs
 TerjSfV9OL7tCLwc08PD//E4vMp2ZoWFT3Sp3kWOFCHyeSjggt7ObsMwzqFdXHc9QGPxEMIGi6U
 kVIlllIAraP0ZEF6mCtuw6BP4nwoEB34ravGAb2KSbUT4wcVkcZi
X-Proofpoint-GUID: nPMDf8C2NNPb8RK62qcdWrJL8ZGqm_8Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3NSBTYWx0ZWRfX/IrWSuFWBisa
 GvFpyQNrkBuhwJbb9K+n0B64MKoMsZVY+wzH8i951+EmM8UQ5yl9C6I8JPAGwk8yANd+xKrlPwx
 wW8OACPnY1yd509lTNR3Po6uYghi7tRLYXSi2kzMNatU35lU7cQIvpVLbI+RxEbHtGMjCf9EYMt
 iZIfrm5VfcT3ZQAHE2YOqiN8dXnqt0Wlck2+e5PbXS/P6diVVfBbvViTLwAEztYEK/ldjpIzPgv
 FdMQ2TaATs++ZC1PPP9hstWSVjopkQ2CarFThxJlxyLdQeDwfXsJkH8Mromv8zDDDU4Q8lI7ZyK
 7guEI923wkovBtPK7g3POnjAH5izADF1D19KXGdZUZ9f1VMV3mIH+BKS3Wtl3ioejEJ8cJsJ0+p
 Je2/V77ZMNFxJnSnC/xA9mJZ376HSEBM3C1WRucTJVZEJ/ZDK+cBkVz92VHWqgddjGrxD5s1b+Y
 FbTF/wN0Rnh2rNOYOCQ==
X-Authority-Analysis: v=2.4 cv=I+vw19gg c=1 sm=1 tr=0 ts=6aff45b7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=jPcv_2rvlE7Bo75heywA:9

Hello Arnaldo & Alan!

Two small patches. The first is just a small issue I encountered running the
test harness. Second one is the actual priority, a bug in the BTF global_var
output generated for Linux kernel modules. It's explained in the patch body
already. I saw that you've added some global_var related tests -- thank you! I
added a regression test which fails prior to the fix, and passes now.

Thanks,
Stephen

Stephen Brennan (2):
  tests: prep_release: use $VISUAL, not $EDITOR
  btf_encoder: fix DATASEC assignment for ET_REL files

 btf_encoder.c         | 13 +++++-----
 tests/btf_datasec.sh  | 56 ++++++++++++++++++++++++++++++++++++++++++-
 tests/prep_release.sh |  2 +-
 3 files changed, 62 insertions(+), 9 deletions(-)

-- 
2.52.0

