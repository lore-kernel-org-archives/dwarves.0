Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532601C1744;
	Thu, 12 Sep 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168124; cv=fail; b=MS7AG7ydkWMhGoMFvUsQ76TR+bhPTsRfMbLYu7bV/wHqDxNaaWgr7za14BdpFBLJnYbalXjXIQXFnZ7X+xtkmxy1zGUBhuSMXVoZWEaHEA4wXKaVmLVvg0fVxaD4lvdxR3sLfDIUwxDgNzP8OMnVK6+PJ6TG8JL7ZPkKwejxmd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168124; c=relaxed/simple;
	bh=H8o+WRMzUpm4cuVVrO0Zupol5sF3e7nEK31iVl1FPVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUOvckNGmgHw8+LhNYgpiy3aAqezsnuYKFEvNyehYO3yGjIGfDZyxtHD8STh/kDziNkWKtWvWRvnNuiiyvFCcv4vu9zHpFxJYYY/9CVPXa/XCVfiSUZ0kMdKe0Qa01AciRldK83ECK1wo0owTz7y0t8TZ2crY8BBo6Rlh8Pqkcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bVvMc5Ok; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cZnqFJu7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bVvMc5Ok";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cZnqFJu7"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIfgo7020913;
	Thu, 12 Sep 2024 19:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=GGJi/GXlYVXu7H/O1h/YFd88yrw3PMC9HA0C5hJMFvU=; b=
	bVvMc5OkXGDnvW/X6Ez58PEvuBw8+ICIv8dxYyZpnpOo36rvS9LRT0FHdMpEXWHC
	xCv8hgpTqmhaABvvtJos45y2e9r3QoPSeWKX4/Lpv3JNXnZW47A91TjJeZ/XhCzO
	eAWSMCBBtB/cMSPoOHsQNGCvryZLCnsQA+TK0jOHVxMuDuQ7TzYj0V9nuf/6YzFl
	5RslSR65MIQ69lewcZzZwPJtsa5Av0553uGeLcneVG30kbhM3x9E3lE6nSCZuzu7
	Gplnexl4X/ulrI5isCTSUNXx7MdjXi1oB4i4CqO1aZxPuGzXrgzEV367A7aZhLnF
	r8Gqcr7xNdCbnYIPhkeFGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctkrpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CITFve004154;
	Thu, 12 Sep 2024 19:08:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bre26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AK9rtdrBdOcPCnSFvj/U3CYY5ghDlS4XY3ytm+D2TtZiIVAOOz+k3KivQw2PHSCDdbCvpwdcQjjcwTsqt3b8PJm8b/lIdqKQa72dfxgQwApeK09VM1pFEZSfXqU1jH03sbn84maqOCHDbDw4zPRN2RKW0ZxzHAImfEVJKMAugFakOmZDm9t1wD4+UwH/iWUYMWib3+jKc3rBZ6h+cSnF4sryRB5GYi3D/u/5rqQjz7h2UI960o71bJqPoKPnqdvKXKd460SRQ7eFJ1kWQo5vTtFEtXONgIU3CZuFWqt1oIxE6GWwavIDTZPrTR3CHdwJuz6k1dVgon4buxb+kFYjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGJi/GXlYVXu7H/O1h/YFd88yrw3PMC9HA0C5hJMFvU=;
 b=QILSJhhEybsISQx6qSEFTkPBRBrJzg/l/jKi9F0y3H9gqfocaAe6+CBAMbD5IlJ8RaOlbR1cRlXQdaew6Rk7d5AeUmRtJ1N8jH4X1xulYUiGrUsLSDSWxi86rCSQSdx4hBRICOCK64Ghyz9PhDSG38m3BORGUU7A34uXgESLWCvtbEE0D9kfFdvj+EyKHaHJwIiURNArVlj4GiaeyDOc16K5SrSgi3nyWdaUcgXYVwyN8xjILr5nwSx1BAxk1KBiiZMVrEiE3g8cu3pDX7VH17w+TgXmKUHbeXTETyM4dCbBu9JQ74HgPxiAdiprl7mZKCg50pVxUj1h20iFDuKopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGJi/GXlYVXu7H/O1h/YFd88yrw3PMC9HA0C5hJMFvU=;
 b=cZnqFJu7+8caLFiOgfzMd84O5w2dFR+J+qdH4WV0UmU0ONCFq8TYtWfLEq05MgFXP3g+47dssHunITiPRTzAsEoanDiu3lcrXpb8mU7pKI13itcu5OjcM+P44ul7WZo2mxKHf7pmkz4UGBqlLn0KY2da25pJNvP4XTmyUe7j09E=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW4PR10MB6533.namprd10.prod.outlook.com (2603:10b6:303:21b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 12 Sep
 2024 19:08:35 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7939.007; Thu, 12 Sep 2024
 19:08:35 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/4] dwarf_loader: add "artificial" and "top_level" variable flags
Date: Thu, 12 Sep 2024 12:08:21 -0700
Message-ID: <20240912190827.230176-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW4PR10MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d29eed-8b89-4d9e-d73e-08dcd35e4d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nD/wJHkXnZWJH90/EsWe/2DT6U2s5fYPxJeVS7DpBvmsMWfIdQyhaVfLOrPU?=
 =?us-ascii?Q?OO5SNB2FJ7Q5mfMxVWbOktaxB5bJIssDayt/rDOM9TYciQjfSEcDhSmpHvcu?=
 =?us-ascii?Q?EIU6YgfMZ4OhckEOSjWFn0piBf6k1S0NLKebOnpR70AvPKSEXxqa0x5dFcFq?=
 =?us-ascii?Q?O3ewTrhvWT8cI7gAihXT3tji0z1GgvOj3i/IB2h5W0ialGpMnGx+Ya2zJhvr?=
 =?us-ascii?Q?9EPj0bgPRFQ+I5MWYiZiLh1AwJQFuvHU54d4XDHDrXzKlDNiowYIUzkgd9Km?=
 =?us-ascii?Q?23McLlNHURXyokHfVANedS2c8bk3oZJHG3RF4q9yU0PJMfqA1dpDigIZkSBo?=
 =?us-ascii?Q?FYhHCIIfWyWaJvmdViwEaKRb9H1DS5V4y6UbRXpJ48Vqgb7f/71JUPVPgf2A?=
 =?us-ascii?Q?HwIOE2fGVELJ0zT9FBSL4AoyYOBeGc52giPl0cFx2lrU2WjsASLn1Wu69ZUg?=
 =?us-ascii?Q?pIDUcv6qiklMob0KmlC/QywmH6WntuKxk8PzTD8Nk6bbGS0vpFB5XQYTbdg0?=
 =?us-ascii?Q?Q6PN6ILpwjn+9/V4l/VKhQmgga54666RHfFry1dZG6Qbn6V6YA8qRJbekb2d?=
 =?us-ascii?Q?NP+ji2t68Qx3M8dVd7AjIsFUCPk3+C94KibRGuYW11H5EhrnKIGxtslkEYUg?=
 =?us-ascii?Q?g4hnIJKxZkb0NlRf/l9hAGmtWTLcKk206ygyEo3UDldoHkjHoEv1FYJdMhya?=
 =?us-ascii?Q?m6JnQgAnxAxfzoD4vNLxPtyHeDlbvXWLv8qc/v6UdwkW8kSLnsnUCt0nQfml?=
 =?us-ascii?Q?ETK0KrkF3Kj1dzhAez34BmqQn67kyxp8LABDHwQBs5PdL77NNunJTgfiZ6t5?=
 =?us-ascii?Q?bRTjv5/gCVGf17VOsYD/HqDRLDK1I5yqwO0MNcMfYt1vUNeFCfE6D67HsSm3?=
 =?us-ascii?Q?QrO0oRSoch3b/32Pt54Wgj9eO98+3muBW0JMl4I6cm192AmFkDrZVk/+YV8q?=
 =?us-ascii?Q?+EV/cD5UomEWhxlDTD7W9zQIrh6G0val+dsnzC32FpBBIdBIjYOFXtv/+tan?=
 =?us-ascii?Q?0R33UCS2RcP7dYg7x/I351DOWJekyHslii+infgzBiHUHxVbsePLaHB5jb9T?=
 =?us-ascii?Q?i0lh4OhFB77EugE4r7CDKIxhpEQoCadnL7d9WsjEIW4BJdN1RMRNLZB0kgju?=
 =?us-ascii?Q?G5utRj8fYdxNejuBAaS2BeBLkK4dmCNNiwsgVwuvWA2nw10kp26514Jbevda?=
 =?us-ascii?Q?dXTA2seZI0Szqjbap+i9cfvr31heIpAjFE3prrv7QLsaVTLXUFqB6yykxYXd?=
 =?us-ascii?Q?DyGozz0vpo2swpQwEXKc30gCF2lSqYbe3AX/iOR9RbAlQB8PtiR3n/WKBhrK?=
 =?us-ascii?Q?v5/QBwoOEwVvSFz+uaGceTm0OvKyq1XN9S285kVMVqnFcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oirLil9MbpRbgYM5kCkw9B4gp7ZWUj/PWLc5NxX4kjZPh5yODhN7WDbR8TGL?=
 =?us-ascii?Q?AbmZAKHllqdc6V1P6gfuzpTdfQDg39BLHTE2oo1KTsUZ7hftO+n0Ih/ZDoyV?=
 =?us-ascii?Q?C+HU/I80S9qZ0jFO6eI8RVZhNFqWaFFykfAtTvEeYuPY1fvdor9MSu7gkzMV?=
 =?us-ascii?Q?Ld4jiBeDLkDujRtOh0zUWMRs22JVmAQbGFX1ZEUFd1rceqQqHV/KgQyUaykt?=
 =?us-ascii?Q?T5e61D/fARX4X+30AVjHea49LhWxSzNukVjDG3VMuu0VujsfOzWuZyXhM/OM?=
 =?us-ascii?Q?8TxXTZmcu43nbgLo4jIiQSr7l1jUI4bT4FbHLtZRa7m8e6yPvkysqzQakSa3?=
 =?us-ascii?Q?BUWPBVQoEAy/xTtwl4ZUpVKE/FNoZ2GpsVFSOfKZG9x77NEderX5/MGttrgk?=
 =?us-ascii?Q?ZJWQYOzM5ZxmWxH5myIy5s28+c4UgAGqTWrKPF0pQoN1y9fpt2N0QNBN1ygf?=
 =?us-ascii?Q?/jIoXYN8UZ2qBMrGSILd/ULIBDgctXiKzABUmq7igGKua+yXljYzbfqtB9SY?=
 =?us-ascii?Q?58j6VBk2JSkpsWJTddqbivwLQ+SSPZIybxd3z03RQK6bTfg7erGGr504uVgF?=
 =?us-ascii?Q?Sou21lySnhx1Bxqj+viNIQMSZ8Ei87MYSlsGrfNl4zNoGn/23YW0pVMaTSGu?=
 =?us-ascii?Q?myYYmq8irUMlUf3nr2SdDMRGRjPolwr8NHSziBH5Stva5gKETAAHEc0LAfnH?=
 =?us-ascii?Q?HAuWqerffqzCktiFD051sGHLPg+BVYwuj2DttqdQqGiMmvelYnRm1w4ZFF01?=
 =?us-ascii?Q?Pf72AnZ52EuAc/2N5PtcF0V2y/O/1atwmtZkAABYY6gnm22oQ8r8xgOKDKVE?=
 =?us-ascii?Q?lUJdtfVgM8WLq5TM1cte7Uravt3WSqqkIIwlBwqOQgfL4omLmtX/ePROqfzk?=
 =?us-ascii?Q?Qfex5HXfbRt3heanUivy5Gu2va299YVybiVaoEuL1mS9SbPif4piribIEStx?=
 =?us-ascii?Q?GZGl0gkevm1kH4/31QOqqxnE3ayP9+n1+m+ZM43DozbjZTgcB10Tfr078MPO?=
 =?us-ascii?Q?LmWPC8d8C6NmZOpV9VuqM2Q1kb1B2lagnZLJZvPcLXqR2p9nbw6gT3T6xaLq?=
 =?us-ascii?Q?T/3poGZVAjyVdELRpxG3sMIdjZCAV10G14r+WpCECsOJkWJ7zHccnOoHqRh6?=
 =?us-ascii?Q?mTMgdR0U4sQ5Np3M/YtLJFJ2Cpf7EzCe/8DLM03X1NOd4POeohfnSi8CBiLo?=
 =?us-ascii?Q?BfG4F7zkmVC18rkYY9JniLllFBVQRlWnfHChuwXWaQwA+cBddLGi5Gb0hix8?=
 =?us-ascii?Q?bxwVeYQE0yNakDg/wXMM44bNp+LujLM/VIb00whOuSeQ/uq50qRyNOOU2Zuy?=
 =?us-ascii?Q?AmrdAcIbTHBhIwUvw/F+ACno533kihNZ7F5OY7zBFzOGDoX6z4lqXCk3sIVX?=
 =?us-ascii?Q?CZnRlKZS4vFYrUwlkXWp6Y5BXeHd1k0hJALAcEA6+URCJyFXi4GkmYT/JV4Y?=
 =?us-ascii?Q?C68zK9NWDMgomjEyvKjAlMA43GMFGg5EJdMZ8uhRagB99quLSBsHUwTRt2qX?=
 =?us-ascii?Q?D3rd1ZU3vJXfuBrpTQy6wGNk5Wai0hASL8MWlw7DzzMGZMXE3+T12nl9op7N?=
 =?us-ascii?Q?AD4IOHql/zqrFGKSYtdNCCiNxZz9PP9Q2nOQ/Zghv71fgOu+WN6Rfr6x+bYw?=
 =?us-ascii?Q?pNeW/Faf3B08mgHbEcDPLJI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n8dzD8ToaWQ65aL/h+ISSR7pFLpgrZ9k8P1HtbPDn0gcxC6DoedgidVW8OyGqVtzhKFMsOGX8rXt1WivfWUBSaiwc34ekmaQwIGQnliCW1FTo5mb4CHLxPdiFVYV5Rk6ORe4214WiUbI4NTncR9Iw2bSGtg9roERGvA7KfuSP6E+v98y/HH5EuXnNKSUe9Uly1ZU9QtSbVYiWfQqebJgM6oMXxorsMjFNhtUltziqE+REKMg970GKwcvfO9ZMiJ4gJCE+FegeJzXIUSw/dq7hK6QKaRsfbK8qkOwesPqH0moi/loEj5n2JHv+FU+whN0IETXZ2YBWdBMzf1bSPj3z8v9rQQ/vpMpRamZab44vy+L4Q2aCS7ySj+jGshK6Qu1DAQ3IvRBZeV7lxTmpRwXZK1/+rDvPljM+W45hMi4LVoJAe55RLkbxbf3SfkzsD8yKY/JANEi1aIu/RcrEknSO1LyvF8ue7A9uQUEZmNVnCAPKLSwYtgawywCgLptpuyeT4ApMojQLTLBPwSGRmr2o/VFfhjj5fIdmx55hATQNpF3lM6TtKAuN6Xa6Biz+HXR600DoW5DfLdyLvOzNWECCXQTzRiGugk13o2+AH6kCBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d29eed-8b89-4d9e-d73e-08dcd35e4d32
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:08:35.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sZkUKvTgXfsbXf+Nbm+tY6RxaDHBD73ni8gEouVeEodAhRenILE37YsXZfnSQlih7BaTBB8PfRlU/ko5idzrk6tCaUDkUSRpaNjWKJj+7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409120141
X-Proofpoint-GUID: mSyOKBRrFs73LpeCqjBKPFMp_8HhA4LE
X-Proofpoint-ORIG-GUID: mSyOKBRrFs73LpeCqjBKPFMp_8HhA4LE

The "artificial" flag corresponds directly to DW_AT_artificial, which
indicates a compiler-generated variable (e.g. __func__) which shouldn't
be included in the output.

The "top_level" flag is intended to be a better proxy for global scoped
variables. Currently, the DWARF loader examines the DWARF location
expression, and if the location is found to be at a constant memory
address (not stack, register, etc), then the variable is assumed to be
globally scoped. However, this includes a variety of variables that
aren't truly globally scoped: most commonly, static variables in
functions definitions. Their locations may be static, but they're not
globally accessible in any useful way.

These flags will be used by the BTF encoder to select global variables.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dwarf_loader.c | 12 +++++++-----
 dwarves.h      |  2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 065ed4d..d162214 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -730,7 +730,7 @@ const char *variable__scope_str(const struct variable *var)
 	return "unknown";
 }
 
-static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int top_level)
 {
 	bool has_specification = dwarf_hasattr(die, DW_AT_specification);
 	struct variable *var = tag__alloc(cu, sizeof(*var));
@@ -743,6 +743,8 @@ static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf
 		/* non-defining declaration of an object */
 		var->declaration = dwarf_hasattr(die, DW_AT_declaration);
 		var->has_specification = has_specification;
+		var->artificial = dwarf_hasattr(die, DW_AT_artificial);
+		var->top_level = top_level;
 		var->scope = VSCOPE_UNKNOWN;
 		INIT_LIST_HEAD(&var->annots);
 		var->ip.addr = 0;
@@ -1767,9 +1769,9 @@ static struct tag *die__create_new_label(Dwarf_Die *die,
 	return &label->ip.tag;
 }
 
-static struct tag *die__create_new_variable(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+static struct tag *die__create_new_variable(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int top_level)
 {
-	struct variable *var = variable__new(die, cu, conf);
+	struct variable *var = variable__new(die, cu, conf, top_level);
 
 	if (var == NULL || add_child_llvm_annotations(die, -1, conf, &var->annots))
 		return NULL;
@@ -2243,7 +2245,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
 			break;
 		case DW_TAG_variable:
-			tag = die__create_new_variable(die, cu, conf);
+			tag = die__create_new_variable(die, cu, conf, 0);
 			if (tag == NULL)
 				goto out_enomem;
 			lexblock__add_variable(lexblock, tag__variable(tag));
@@ -2367,7 +2369,7 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 	case DW_TAG_union_type:
 		tag = die__create_new_union(die, cu, conf);	break;
 	case DW_TAG_variable:
-		tag = die__create_new_variable(die, cu, conf);	break;
+		tag = die__create_new_variable(die, cu, conf, top_level);	break;
 	case DW_TAG_constant: // First seen in a Go CU
 		tag = die__create_new_constant(die, cu, conf);	break;
 	default:
diff --git a/dwarves.h b/dwarves.h
index f2d3988..0fede91 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -848,6 +848,8 @@ struct variable {
 	uint8_t		 external:1;
 	uint8_t		 declaration:1;
 	uint8_t		 has_specification:1;
+	uint8_t		 artificial:1;
+	uint8_t		 top_level:1;
 	enum vscope	 scope;
 	struct location	 location;
 	struct hlist_node tool_hnode;
-- 
2.43.5

