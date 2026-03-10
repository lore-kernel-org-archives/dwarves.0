Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC943637D
	for <dwarves@vger.kernel.org>; Tue, 10 Mar 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133018; cv=fail; b=aWdF6DwodllE7UhneGuvFPibRp3isRQ0uRGR55vl/GWi1ETZL11UFMqdzu/F8kmALmN+5OV1y/rGGCMzZYfI8znb2sF3ffaqvfR3xxaG4ecIAcPLof5oJN+s7oZSecn+fy2bL3CZERfsnV0EVKmrykpoCxfo7jAh4Elz5IUVV3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133018; c=relaxed/simple;
	bh=Du2ZDnMpkrFW/cEPXFD4YE0t37c868QQPQzZsvCt1Yo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ddTBVkn8G8mNJWSDCRREuWDqUHs0zfeIN2FkN1PZjVkfoUvatH8uc5LPE5X5o3v9WKmZkhko0xVJ/u7cvzmdCZZc7UVq33oS8Gmr8r/ZXRQ1gMFuGywvZ11n3uy/KrAuIJIFPg1KOn+AqEOAJBjU/0NYFXEiYlrFGKtS7tHOJ3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rel2sIlx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fvIzuOZL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rel2sIlx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fvIzuOZL"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629IMjtw094045;
	Tue, 10 Mar 2026 08:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=83hvUiBv+U6NmP8p7VTv+dtiwNRPw5mVF4S4HXpeBXw=; b=
	rel2sIlxuuwwCDxbLWykUKIIOg9qybR6vErDJeIQ6LOOT/Or7/hVg1GKtmgYQdS4
	4gTj5z+D29O1BqBG73sf71ccUWxe9WAG+UQCPUqryDAn1ttn9BiS2PxqcjL1T/6v
	gn0ryP7A/kR0c4v0aWmu7XaYRX0a3gFVyTxMrW2FZX4DPwkvMoi5kCTEO09e1EH6
	z42YoAkOn6EHRpFfDJeIQ0TRHtxaulZxGeMhNiZ76hsh6i7W1e8StlhE4sf/7WP9
	+Cdo6/qP47yZTMrKJRSiEuk+OLqb7IWJ3On+v7lo8NAAPjh8+hM80G+9mjZ9bklg
	MAbZj90sPmPLAAcqxkmQ9Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmdkjfau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 08:56:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62A83GAq012836;
	Tue, 10 Mar 2026 08:56:49 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafebvfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 08:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAMmXGMFvb3mKJDgwpfOAQ3zmNmo+39Qn13ZucnF2Ad9ZrUi49XSeSy94lAt1/6oMrgvLIcn06mD205ZdilTNYNlhniJRlI4jMmgonAGCiR8ru214uHF4En3PRYcxtLIKeOHb8H5M3jrxLzU7sNOfe1L2eRJ/WuTa8WQnp/AYcigqls/gjTQvA/JGWCZfTaLdfC8dEqVrXe8HAl+qbw3I5TeX+SLzqE0k9PryjDUy/C3i6lXBzU1xPBgjt7j/f50vGY9HvaSuonnPI4Gj0ptlhDa+iCIdl0MmL7pHIZokhKa95HsXCtEP1wHlOen0a5IKXDKnJq+ztBMeMurC6HRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83hvUiBv+U6NmP8p7VTv+dtiwNRPw5mVF4S4HXpeBXw=;
 b=czJ/ysQqc5eFcYJcdY7XBCndyEaHk82YWd6EoQl5aCizfbs4zo86ooTHf8YBslzi6p9Wzb11SKzz6aFaN3Zxkz/ifPE0gK10sK1cuDBXTq/84ZnFLB6IGi4RMdtd3HFcL9FEMjjBpqUexxr6qdkTQ7fZUDkI6Ocrqpdk4x19cxY78n1aXDgZrTn32bRuzXpvWFCgPYcCSc4M2YhVNETuydokeKMGkPT/0FOOlqW0ZDLipvwiGxm9J4DSI24JKCijCNfiq+e8O1wYfUC4LMHIujZKvBwYCp/Y5YG8/dMCigsyfSInu8bCeypzHlCfVOf8g0FvIlVC2NMT10RU/KtC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83hvUiBv+U6NmP8p7VTv+dtiwNRPw5mVF4S4HXpeBXw=;
 b=fvIzuOZL14D9Ekv9NrJ7ULY+p/r1HvDi4Fy375m0FxMYv//zm6ql1sjIb47BbB5s0kLdv/5UEKxGc5qP57nfo3z/4OZwFYtCLvXWKnX3T4gWVDf7pyKuDGHx5g7XXWJdmf0T9j5uXdqbHUFQkxS5AAMnHAf8XGlHkyAcnvziApg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA1PR10MB5757.namprd10.prod.outlook.com (2603:10b6:806:23e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.25; Tue, 10 Mar 2026 08:56:44 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 08:56:43 +0000
Message-ID: <49f241d9-8c88-4920-8f54-3e6d5c1fcd09@oracle.com>
Date: Tue, 10 Mar 2026 08:56:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pahole: fix discarded-qualifiers for strchr/strstr.
To: "d.hourtoulle" <d.hourtoulle@geoide.fr>, acme@redhat.com
Cc: dwarves@vger.kernel.org, Damien Hourtoulle <damien.hourtoulle@gmail.com>
References: <20260309165220.2974165-1-d.hourtoulle@geoide.fr>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260309165220.2974165-1-d.hourtoulle@geoide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA1PR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: c7eda08b-48f7-4c5c-fb72-08de7e82f38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	EzRXt5BWyU7x0HVl6SGg0kMFcvUa1Y8grJ1sDPmL8iCT9NwIWAcwdeqP7Gvx/t/OnIwAu0rGtuswJXAo8WEpZ0KEMUesUmgcFd4VsozO4Dp8EkG/hOx2bPG3dyAJQkqgxLMDKHdskbb78Ycnj6EAlem1Megy6KO79W6jBGKfYL4lSY+1nC1+TrCYTr2iK3sjwDetVXFQbXqoITNY4NZGRiZ63yRuJkhtsI0CVT9NZonkSod7BDa9hgw0X8/p9dvNnfO894BSbEsglpzsoIYRJymT5jmjGzU1AGZgHcs4Xo7bctm5nOnqsEIqhvFKzae5sDOG1JjhMINntQF2AovARJw9xDbDq1rKTFiBmNhhWdNH7WSFe4Y5ZZVErSb6oT448ORgvQCJRkct1u8hqHQ98Ptl3+Q5BlslbB+hId85AfKS1cBwW+/fkuqPNAdCqTORbw9WT7TtfBLIplp5vyyyPLJYhFL9aMW7X5rmqDXCBvaGn3pVR/jMjotlXUX0O9i/ui50WIje8DI/nK2DPrQgh4OPRuiMmCEr74riwbXTD/bqlzX/NCyxZSP4r7ImSmpMjMZr76wqVpGRcB26fZiOFZxaWT4tEoRpnD98TeRaBi03KTB3Lqu/JWRC6V2z/oyEwzpC+/4DWlwyVtdw68TxLMOfkRCTLs9vmWmlysllmaOWWWRQQdTAxDp+yIC5J5ZCZb+sMcw1oA4uJAt6zw2p7HSvesG3D2TAQiuoSatvVhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHJBNk5PbHRJbmFBK2RIZHA0ZzBWRUJxdjFsWU9lK0RJWHVySmxvRFc0aG9s?=
 =?utf-8?B?QUNEMFFSU1gxSDAyVUU5SG5nYnJNY3NaNzRodXRmZ3BCUVNYZHZoL0V6M1pp?=
 =?utf-8?B?eFdjbmVramlPNDFrRmt2MmhGUXVIODZMaEw5VkVXZWFoaXB0SnUzTzRtRUMx?=
 =?utf-8?B?UDBpcHE4MjJPaXVGcFpXTDVLQ29NcnlXVUY3eHRONFp2eXE3Z1h1S1JqMFFK?=
 =?utf-8?B?SlNqdVNORllvZ3l5UDVOcUdkbHdvZ29QcnZvOG9hMWphU0NtWjFxam9sOU93?=
 =?utf-8?B?aktiLzJUWmdZZXROOFVnNEE2djlaNWU0VkNJamJiMk1tVWhMZWFSUEZmaGhG?=
 =?utf-8?B?clY4dEV1SFJCaDBibVdQaXNqSHF3dXd4dnNoVENwVzNybXR4cU1BQjNIVFVX?=
 =?utf-8?B?RTJDZ2NJVWJWZFR2aXdaTXY0MjBoWnlsdktoRVZxMFpoQVM5TFM5VmtZWEoz?=
 =?utf-8?B?dXBET3BTSlZWSFpMZll3YXNlWnIwK0tsbUpPeU8zdVB5b2dDaXNsSHAzbzVK?=
 =?utf-8?B?NHh4OWNtcG5IOTlXZmI4UCs3eWN5aVowMnBoWnZqbEduYlBnLzlJd0dZTVJW?=
 =?utf-8?B?aWhWSWR3KzFqL25yMDQzTGZMd3RqelI0QkxQZEZLSy91clNSL09TeVc4M0Vy?=
 =?utf-8?B?SFpab1FoSUpyZE10L0J2TjE2bUFTRU10S1pHRVg0ZEdkVklCT3N0cjU2SUw0?=
 =?utf-8?B?UklvcFB5ZW1FZ3QzR3I0US9NT1oyeTFvQ3dHY3REdjhwbWdQRUlLa1hSQVA2?=
 =?utf-8?B?UHZkejlxRUpHcElxcGVMMnVxN1VQWm9Ca0QvaUZKWkZTakR6TzdKcjZHdUVK?=
 =?utf-8?B?bkthU1dBaVdnUys3L25JZnBjVzR2aXdtd1pFRFczMDF6NlkrNS94MHlHeGVM?=
 =?utf-8?B?bWZBNEVhSzhIVU9ya1FJVDk2QTVsU2ZTVGF3L1A5SFovWmtPVTJxS0tvTTRL?=
 =?utf-8?B?dEJGZUZ5SVFORElOczIzQnl2Rm9jOGE2M0hJN2VXNXB3TVVPakNabmEwVVVw?=
 =?utf-8?B?NjFpWGZIL1AvUVlaMk9wWFI3UWFBTEs2UjMyUUJCeHZjZnlxZmdTSWNDVGMr?=
 =?utf-8?B?ak1YUUhzTlg0SjNmdnMwQTFtTkpPMEZvTFhKSmUvT0J2SVNqR2F2ci8yYXhD?=
 =?utf-8?B?QnZ2TDFnTHpOUGtwcWJIWmo4eEwyOWtnMmN2emR1MmZqdE45STRRSitxdHlS?=
 =?utf-8?B?bVo0R3RjU1FjYlNUSFpWZFJGMkc0Ky9ua3ZyWXVONmZvbUYxemNtaWdsMkRL?=
 =?utf-8?B?MFZadGd0TE5aaDR5SndTTzFHU3BMK2VNQjN6RzhkMlc4NWRrWjAra0U0QnNQ?=
 =?utf-8?B?MHZXc1VwVWF3d2RieTJxR3BKRE9RYjUvdzJ4L3QrVnBvSWtlWWpoL2Y2SmNl?=
 =?utf-8?B?VDE1QmJEcGdBYjgxYVgrbWJKakZoZjBzM2orNXVuRjZTMmNLcXpJNU5WS2dX?=
 =?utf-8?B?VnNRTDVwNW9HbVE5RHpzRDVMMkw0eks5STUzUEZXOUtiTHVCTWhBdS9ibk5Y?=
 =?utf-8?B?RGZKTks4UlJwdG1zQ1hEK0VVdDRXbUVneWgxOHB5bWdBUWhTQWlYeTlTZ2Mw?=
 =?utf-8?B?d3gvcmZmTUxVUUtqdEIvUjFzN2pMRzZEbzgwT0JOTk4wR1V0MUNCZUVFSE9t?=
 =?utf-8?B?U3ZFQUt1RkFlekg5aTRRTjdkSk00MVg2UjRLYVlTdGVBdFpwRXUzNVVHbUZp?=
 =?utf-8?B?dytnNVhDOUVGZHNXTkRpRm1qYVg0UzY1K24xSm1zNFc0UU8vV3BUdWRFRHAv?=
 =?utf-8?B?bzEvbStOWG42TzN1eTBVSlprV0loYTNxUlMxZG10VHlraDNBM1BhTmlUV0Jt?=
 =?utf-8?B?TXdaWlYwTnB2ZEthWnNXVXdZQU43NWJiWklFZmx3RXlEaG9IYXVWVkRBVWJY?=
 =?utf-8?B?SStZd1NOSWY3bXVWMkR1b2l0cUs1ZHZ2TURYYjU5dHhzQUFzOXVCSHROSHo5?=
 =?utf-8?B?M3lJeXdnWFUvWng5dkNOS2R6bDQ4UmJWdDBjQllGUzNjZGp4L1hZTFMxMTJH?=
 =?utf-8?B?OWM1VWpqa2JONTI3TzFocll6MnU4NEplKzY1NEM0NzZKY0JhRHE1eXVOQXRp?=
 =?utf-8?B?Wm55a0hqTXpmL2V5MHlQL1RGUHRYMFhlQmljaFd6Uy8vdzBKS1hIVkdDQkIw?=
 =?utf-8?B?aGdpY0pSSVF4Vk9rSHNmUTl4dUJHeTJab3gwSWRYaDBTSWZ0dlVqdnpsU0Qw?=
 =?utf-8?B?UGg3UHhnV0xidHVEVVFoaWRUOVN6OU9zLzMrcVZmU1d3OW8wQko2ZWlJdHB2?=
 =?utf-8?B?RFN2WDRzdnVUL3VId0o3aHArcHFRdlRXSE5UQlRFUStuRVZnRU1Fc3ROZ3ZN?=
 =?utf-8?B?TVNNWGdWRTBIOHN1aWRSTlY0OUtKbHV6NUpwZ1VaSG9uVXpSbE9lUT09?=
X-Exchange-RoutingPolicyChecked:
	rVtj1W3UJWk0fPDgDHPGs8ewAWYaEEO0p++Ivi+LIv9hpi/zBiiXRIqjrUEAvZJTuPwInegPtlDhRX8LvSWy4gggZRBdsHQZ8vvEUgO1y01QY1dIEOL9MrNT9Li7sXX2WritW+7n3uQgbmRHdNsIq/3GwvV1VIF33jqx5hU/wbKHeKZmkDR9GKQeHQJiKcxSBsw/cd/5vWlazxBb5K9cF/h0o0ORci/8IevdQDAkF0wttOMNfuoM9guyrRrNIBF8hiUnVjMCdUYaTBO/zja4aPyaz+A0ty/seusU7qE5ioVD+QwhtlaP3zFxh6VpPYEWHZFfBD3004HXcsZx2oAcFA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xtk+Yqi9TOpdEvVVfMQIVaqnPessH3gAoF4V3p6Z2hAwE3KfeGdnK4mQOtOBMPF8WPaiVHEtg48qKXRgL+W/7B/xemt0fBEQmzWTEa8F4SS/lV5/xqKD4ZY0oxA0/3exwGFlVePCBLlL40FKhJ2L6gVERwTkbG+VUQ+aqrtzPlyPW1Z3UaqpcpdnjK+nqae3j40P/PGwNVbuu0Qu33UyTn/MKyVDF9u6w778kUOKn/qT1lmVNaeSgWF/8l2pdccot13qJAtp/fbuAoQAFeb1TduptUPW6gdulyC1tnUp4cO0bpdGoOMtywqHVv7HLDYmatpO18MgBbdd1LAYsMxqgki4GdoHKXurLADRJzR/LwxBgpZgXC6num5V7LqCPze+5b7oIw//n3YCOW8DQ6u0kQG6/OZl9/wzL7cnypV5Sx2FHAxliG9u4E3gZPzv9Th28tVFJNUwkqgEEtRRnX6sMINV4Xa2etnGJPliM7ttQCtacTfddETYeY3ppwiyhDGs2x7eiEOGVDWkmHpQVHZvQncYOS801IYSZ1mPI1CSGeoUbZ/5kow/A0SgoaVEnwBYzW4bPH47G4tiEtRKoiR8iJUUK96SgeyIQJBE3bibtRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eda08b-48f7-4c5c-fb72-08de7e82f38e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 08:56:43.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGQEAa9DknMm9Aa8YgnGPgb+MPgIGjNTmdDDqo6dE4LCunx8oPXwZGSL3u88v9UfnqS+aygcw604fRCpmcSG0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100075
X-Authority-Analysis: v=2.4 cv=MuBfKmae c=1 sm=1 tr=0 ts=69afdcd1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=CCpqsmhAAAAA:8
 a=pGLkceISAAAA:8 a=zNjkItqz-Tks98FfUNYA:9 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22 cc=ntf awl=host:13819
X-Proofpoint-ORIG-GUID: hY1Ha1-5iP2LNl1Aaq1vhLcEF9zhPvjl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA3NSBTYWx0ZWRfXxucSgYx7Xcck
 EY7Up/5sQgIHRZ5pqK6tcdXcI87cv6e/tAHIZBBAPxMyqCtUtprOPobpC0LaQW1LpzD1K/Ct8Fh
 dbH+ERD+kbOs+4xnfJG1Up0sZPBNdg295uqej+Z3GwyEea+QXjB4ChGMqO6GZZJH8d2WdCrQDNb
 Nk42iXs1Kdk9WuO6KzY4aGj6k0OFgnyQQeHkhX9Y23PM/dxklZCaoSzian8OZ3ddmB4e8oqwmCp
 rn2A4zBaTN+P1a94pWLovZaqplzFuHJDsUnJHWv25vQyUgTwEORbYwQK54HPKc0xUNCMr28ffwl
 DZgmHkzEnbY3SyPpNUE3sobBFgl/cHw1ng8FXdbjHbuU3uWJ0TLLZlKgPeKsn3RxMNRBLklaOoY
 j/n7AnqIo74Md2cqG35iRXthFMwQydVGQ6qWOhFe5T4HfQYCVgwzF1hxg/AjuCu8EqxDZv8TQ7L
 fM6doJTZKiGQlKJ9IRL/yl9AOjvkNYV6d+Ntbipo=
X-Proofpoint-GUID: hY1Ha1-5iP2LNl1Aaq1vhLcEF9zhPvjl

On 09/03/2026 16:52, d.hourtoulle wrote:
> From: Damien Hourtoulle <damien.hourtoulle@gmail.com>
> 
> Glibc 2.43 added C23 const-preserving overloads :
> https://sourceware.org/glibc/wiki/Release/2.43.
> 
> For the function prototype__new, fix local variable declaration to use
> the correct const char* type instead of char*, removing the need to
> discard the const qualifier.
> 
> Signed-off-by: Damien Hourtoulle <damien.hourtoulle@gmail.com>

the changes look good, but there is an existing issue in the code that would be
good to solve while you're in the neighbourhood I think. more below..

> ---
> Changes in v2:
>  - In type_instance__int_value loop: update sep_mutable instead of sep
>  - In type__find_type_enum loop: introduce char *cur to iterate through
>    the mutable copy, so sep_mutable stays const-correct and is updated
>    correctly on each iteration
> 
>  btf_encoder.c |  2 +-
>  pahole.c      | 33 ++++++++++++++++-----------------
>  2 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index aa7cd1c..d36984a 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1218,7 +1218,7 @@ static bool str_contains_non_fn_suffix(const char *str) {
>  		".cold",
>  		".part"
>  	};
> -	char *suffix = strchr(str, '.');
> +	const char *suffix = strchr(str, '.');
>  	int i;
>  
>  	if (!suffix)
> diff --git a/pahole.c b/pahole.c
> index 02a0d19..9dfeeb2 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2483,7 +2483,7 @@ static int64_t type_instance__int_value(struct type_instance *instance, const ch
>  	int byte_offset = 0;
>  
>  	if (!member) {
> -		char *sep = strchr(member_name_orig, '.');
> +		const char *sep = strchr(member_name_orig, '.');
>  
>  		if (!sep)
>  			return -1;
> @@ -2496,8 +2496,8 @@ static int64_t type_instance__int_value(struct type_instance *instance, const ch
>  		char *member_name = member_name_alloc;
>  		struct type *type = instance->type;
>  
> -		sep = member_name_alloc + (sep - member_name_orig);
> -		*sep = 0;
> +		char *sep_mutable = member_name_alloc + (sep - member_name_orig);  // sep mutable for the copy
> +		*sep_mutable = 0;
>  
>  		while (1) {
>  			member = type__find_member_by_name(type, member_name);
> @@ -2510,9 +2510,9 @@ out_free_member_name:
>  			type = tag__type(cu__type(cu, member->tag.type));
>  			if (type == NULL)
>  				goto out_free_member_name;
> -			member_name = sep + 1;
> -			sep = strchr(member_name, '.');
> -			if (!sep)
> +			member_name = sep_mutable + 1;
> +			sep_mutable = strchr(member_name, '.');
> +			if (!sep_mutable)
>  				break;
>  
>  		}
> @@ -2950,7 +2950,7 @@ static struct prototype *prototype__new(const char *expression)
>  
>  	strcpy(prototype->name, expression);
>  
> -	const char *name = prototype->name;
> +	char *name = prototype->name;
>  
>  	prototype->nr_args = 0;
>  
> @@ -2964,10 +2964,9 @@ static struct prototype *prototype__new(const char *expression)
>  	if (args_close == NULL)
>  		goto out_no_closing_parens;
>  
> +	*args_open++ = *args_close = '\0';
>  	char *args = args_open;
>  
> -	*args++ = *args_close = '\0';
> -
>  	while (isspace(*args))
>  		++args;
>  
> @@ -3114,7 +3113,7 @@ static int type__find_type_enum(struct type *type, struct cu *cu, const char *ty
>  		return type__add_type_enum(type, te, cu);
>  
>  	// Now look at a 'virtual enum', i.e. the concatenation of multiple enums
> -	char *sep = strchr(type_enum, '+');
> +	const char *sep = strchr(type_enum, '+');
>  
>  	if (!sep)
>  		return -1;
> @@ -3126,13 +3125,13 @@ static int type__find_type_enum(struct type *type, struct cu *cu, const char *ty
>  
>  	int ret = -1;
>  
> -	sep = type_enums + (sep - type_enum);
> +	char *sep_mutable = type_enums + (sep - type_enum);
> +	char *cur = type_enums;
>  
> -	type_enum = type_enums;
> -	*sep = '\0';
> +	*sep_mutable = '\0';
>  
>  	while (1) {
> -		te = cu__find_enumeration_by_name(cu, type_enum, NULL);
> +		te = cu__find_enumeration_by_name(cu, cur, NULL);
>  
>  		if (!te)
>  			goto out;
> @@ -3141,10 +3140,10 @@ static int type__find_type_enum(struct type *type, struct cu *cu, const char *ty
>  		if (ret)
>  			goto out;
>  
> -		if (sep == NULL)
> +		if (sep_mutable == NULL)
>  			break;
> -		type_enum = sep + 1;
> -		sep = strchr(type_enum, '+');
> +		cur = sep_mutable + 1;
> +		sep_mutable = strchr(cur, '+');
>  	}
>  
>  	ret = 0;

the intent of this loop is to search through a "+" concatenated list of enum names, but the problem is
we never nullify sep_mutable (or sep in the old code) at the end of each loop iteration. so when
we find the enumeration by name at the top of the second iteration of the while() loop were searching 
with "second+third" rather than "second". So long story short, we need a
		sep_mutable = '\0';

...at the end of the while loop I think.
