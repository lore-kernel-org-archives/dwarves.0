Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB6202F70;
	Tue, 10 Feb 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753485; cv=fail; b=RJEgzGixGOGW+M6hSTXHydfsra/R0bUBBMTdu6eS2zQ5jK0JYSQzqoXg1xc8Ep1+hUWS7EA2ubxrp+yWuLIkVjWnNISfduXKZQC6kUJ5w6F4sPwrp3GAQj1whDg8pHrqHtWgds7NjwyY8fB4OdDV6NbqzCe7n/J0hlT5Ih8mQwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753485; c=relaxed/simple;
	bh=oh8X3pVMm9RD3hd+feKrrOtAqhGtoh1sqz6p4X65euY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cDA6IC9GK1qo3yOreZ+lDxi2TQdOnC3PpCvjpcbU+7Ht4OulYDXSUjLz9D3OHhPxop/cwGL0+OvqstU/5zE4OiOgWo0F2S6IIUP8uOTGM0nNl8tgXMMHoYPxvq09oJIdAMoUDEo5teFGZMurHE2HsMufBwIBGgp1Xa2z/qaDEvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lnq58HK5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fd/Jzf8U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lnq58HK5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fd/Jzf8U"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AJ1sC83608127;
	Tue, 10 Feb 2026 19:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=usolQ5/0fwM215ql530filRzzZjbnigjGRfqw0EutXA=; b=
	lnq58HK5ClEUArwv40OnMg5OtnrO23wJe7LNac+zTvjroxPB5/Qwkdy1D+quT04g
	DLoSxkB18EQDtPwxj83yM8CKiUTEyjUgr65Qk/uo5uoqqHK3h0YlQoF4uhk4nZ8k
	GHW6Fg5QTeM74XEOHbaIZPoBqgWCEX/D8ekfEeIYsJBhXh8elgio/dAk0rryDFR8
	RLpu8cZE5TAYh4NgdLwwp8j7KS0x+5NbX1hTlJsGrgjail1bINSevYmtrzUsLDz6
	syR+UX1jEE2dHVG+25YlOQ33q61Eazx59ghqG84tboV6Ecl/VqfJx+w04ItyMami
	t10VNKb+vhl20PYBC+dU4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8vs0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 19:57:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61AJnA9r012969;
	Tue, 10 Feb 2026 19:57:52 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c826yh57w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 19:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSrSK7eFcQdbay/FNWxC0dT8ybfaW8t+BqOStY5tiDGjt7IhoK57sRNr8pwSe/vIcogIJMWVbLxhLvmNNdmpjEeDE2AKNgQei7FOlqdPdIxI6HGeHBxPmXxmbJC7VJN/+t5cbQmHv88FLz807BO/dKGw3CZd2u71wRVCx2SfmIF5exhZIPRwt6jEsk2k4CgqS01Cd+JkwzGWCnMBhmsuPJPFzWrXQvzip8fhnMEIltl2s2DdHxozMZaw4hmjb0TssNOzd8oDF3qkFsaMiZI8ANNkrfwNUd6sZbLYdiyjsnbJ9Z2RHWwsfTO+lfBj5c/hRD5xminuH/dRMWP+iw1qBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usolQ5/0fwM215ql530filRzzZjbnigjGRfqw0EutXA=;
 b=pjxXRK0S+KyNbBIb0Hi5iVgblI9AE+7hl9hd1oJwWoGMDU1H8QCSiif+ngR5ZHG+2O3WILMAlUrn6Qah0NHu7RvBVl2CEnbCidJ6ojDUdFB5pbjp4RnDk/gI2sf30cycOT+3uXe/oaBSfJuEQReOPmKRUHz7m7FCmVnAtyJXBUtDtrHXP5sBTY1+yWXM+i8BSKFT1D1ci/HTgmY4X+8pbWoyxyz/icfT3Y5E0Nd2bGWdlSrPwYoiVN3lI35QUidGUe0hhLNCkG2I1wghfk18E4gUqYkFNsCMltZci2QapHXVVf1aaQ3qmrIBMbFnx065hK2kCY1g/lRw8/2GZewNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usolQ5/0fwM215ql530filRzzZjbnigjGRfqw0EutXA=;
 b=fd/Jzf8URDhx9jv2KxnHb35u86E1NRjXOcaOxsbFG0IR2tW/O8/Q6U+U0AbdlpE1hT7NmlIRtMyRpntbnSLnQa0nbSHdAXLp+oo9er49Odumg533k5178MXbZkgJ3tIjHylqbIcT2AL5g1mb+wI0YI4iH1oip+dBgGC4RqASWxk=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA2PR10MB4553.namprd10.prod.outlook.com (2603:10b6:806:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 19:57:48 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 19:57:48 +0000
Message-ID: <36dd0074-040c-4c69-aa0c-99d8ff5edbbf@oracle.com>
Date: Tue, 10 Feb 2026 19:57:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 0/5] Improve BTF concrete function accuracy
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260127172041.1558244-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260127172041.1558244-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA2PR10MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: e90d5dc0-f613-4260-4b25-08de68deaa2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXBPV2lMa3FLcGowSndSNmJuVHI1VmNmNldOMExiTWNqNlEybS8zeEtmVkxs?=
 =?utf-8?B?SlVmd21FYUdCanIvNnB5NGdQZnRGdWJNWmFRSjVyakFGV28yaElKc2hjd2Vv?=
 =?utf-8?B?QkhsVnhsTE5Ga0dPcDRmWGtiYXI0K3E4S2haWGNpVFg2WjJZci9YR1lpY01S?=
 =?utf-8?B?L1VGMFpjVmxiUnMrdTNIWDVUN3hwcXUwY1ZNM3BwaW96dnoyTW1KaGlNbDRx?=
 =?utf-8?B?alZBTTlhYUs0QnpydU9nT2w4Q2lncVdJcWE0UGFjekswYTdwVnJ1SUIyQmll?=
 =?utf-8?B?WVZvS0s2NWhZbUdDS0dtZEQ5YlZudE1EVlliQzNLa2hxaE1DTmtKVThSY1pJ?=
 =?utf-8?B?UXRPR1dKYk9UUEVjMVZCMVZ0YW54UTl6ZEF5cWxOeG1rU1FkVkZuc1dhTHNX?=
 =?utf-8?B?cDJRdjlFNmZxZzJCc1M2UnhNd1g0RlpCNyt2c3NTODZ5K1NRcGV5V09Sbjdv?=
 =?utf-8?B?YUdwSVZ0YUdQeG0wS1RGcFM0RWJBRUs2NFRZOThraGdHQjEwaVdOL1hsdVZx?=
 =?utf-8?B?ODNrbGZNc1dmZkdyK3YyUEJid1NGYjBCN2ZmSmpIZ21zNnVmMUxIeGVxNFZo?=
 =?utf-8?B?QVF0Sk0rWUxHMXptQ2JpTmwxYzlObkxBRXd3bmJ1dk16Z2x4cnU5b2VkSGlz?=
 =?utf-8?B?YUJMTTRHSmdPb3FTZXY2M3FBZ25EWVRXMTBqeERGWnlIbW1aYXk4TzhLakxz?=
 =?utf-8?B?bG1TNmUzMkFMK001dm1BeGRFSVYwempqd3VIWi9LSEFrOVBuZ1d1cWVXdzFq?=
 =?utf-8?B?QWdXaS9GbklOcDJwcGdDZVVCcTFTTHg1WDFvTEFHTDNkUEMwL0FWUlJ5bm1D?=
 =?utf-8?B?TnZQQUd6UWZCY2tkU2hMeWJ1UW95TU8reWU5blI5RkMwdDdpeCttNnpkbTZJ?=
 =?utf-8?B?dEFvb3hYMzlkTVpKQngxVEQwVFpIZzhMZjhnb1pKV2dURE1TamRJbFM0M204?=
 =?utf-8?B?cUdIa0RBeHRvRlkxSHhZUFdUTHJMM01VWmNEdjFtbVVLQTdvNVBtSFFUTEF4?=
 =?utf-8?B?VlA1U01Gd1JPQ3NXaTZ1Z1p5Tnc5K1B1NzZ6M1FDMjJFSDhHNFFoeUpQL042?=
 =?utf-8?B?a1pOVzJydExreUdNelg0NlBPb0tjUTFWVlpCaHQxd2p6R2g2TmhNaHRzdWla?=
 =?utf-8?B?dmhpcXlMc21RMEs1RGMyd29od3FCekhWVzA2THM5ZUphQnltT2dGdEFRR090?=
 =?utf-8?B?UG5uWUlxY1hzV3NGWnpoNHNDenVnVlZyWDFyanVPcExiMjg3Q2MzQ0JoMWsy?=
 =?utf-8?B?RGVPazdKOExwQkduZDZQVWxqWW1TSVIvNi8vUzFKaFl2UG5IRytpaEF6VDJm?=
 =?utf-8?B?TnRtVW93SGdaZTk1aDJvYjhPYU9oclJ4OVBQQ0lkdXBWckN5WkVZVEdkRmVD?=
 =?utf-8?B?TnRwR1NUZEtwT0NQNWZGQW5PcVF2NVRSWWJ3WkQwa2JPNHk1elNRNWJZSjUy?=
 =?utf-8?B?c3cwbWIrWE1tSFJCV2pDU2w1VG0zRHZaVlFEeG9tMnEyMU8yczNFUWxJQy9O?=
 =?utf-8?B?YmJuL01tcXlnci9Rb0lpU0ZmTlY2dTJ1eElLZjBBNnRvZnJCWTIySk1mVHhH?=
 =?utf-8?B?K0FMWGpTR25XWDdVZi91KzNacnBHa0ZleFdzektPdVVlTzgySjdQdzJnNW5s?=
 =?utf-8?B?S0lOQU5nblF4RmZjWk9JSWxtUTV5Y3NaNnB5N1F1VlJUeTJYMGMzSmgzbWpy?=
 =?utf-8?B?UUVua3gvUW9VK08zYUhDdis0WUdKUXJyOWpqMTU4U0h2bGhmWjB4ODIweTBm?=
 =?utf-8?B?cUt3UG11UHUwdDFBM25kMWQ0TVQyY3lPbHFaekFzN2tvaFJKRG52T2tIeHVm?=
 =?utf-8?B?RDdIbkJjRjR0RkpVeUl5ZituYk9CaURUVkF4d01BUUNPMnJHWHFuR3JuN1Uw?=
 =?utf-8?B?bzlUckRnemVGaUQvZnNOUjNjdjVYdHlsQ2NacVg5aUVBUGRNeEFQU2d4amVr?=
 =?utf-8?B?V2Z6b21pN0FFN0FZb3U2ZkwxOW5Fek03NTRpN1dkNEJvVHUvWVF6MFVUZlFz?=
 =?utf-8?B?Q25BYk8yeTVjS1JHVjNrZ2JKOHprSGhCWjNiUUlJVFJwZkNEOUNJRkxTVjNr?=
 =?utf-8?B?YXZXU29VNmJZdHZZc0hlWlZzaG9aSHZCM0FXRGdadzF6V0s4L0hZYTZ0Sm5s?=
 =?utf-8?Q?4WgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU01R0tlRWVhV09Ud3RZU0MzZU1rM3dZc3pCRnFSNTZWQ29sOWFBb0VQaXNK?=
 =?utf-8?B?MDV0SURCeXZsaXU3dmo5ekNjcldUZzhpcFptRHYvTzhUSWl4UTl6ZDQycis5?=
 =?utf-8?B?R0dEQkhSMEozclhFc0VEaFBaZmhseHNsWnhEZ21TUUZwTlNzem14SWU4MFFJ?=
 =?utf-8?B?dWZkU2p4MUNreVQvclJqd1VJQnR6ZXBRRUdJeWZLQXhvb0tpZDJLL1N0dSt2?=
 =?utf-8?B?S3NwYkRuWGJjdERmY2k5SHo1UmVNZWh3K1NjT0xSenVsZHozc0lnMm1qTHh0?=
 =?utf-8?B?L0F6UVp0bmx4eFlZRU5UQXN3UDFIRzF5OHY3MjlzUmtUd1ZsNnNlNWFwZGV1?=
 =?utf-8?B?N29VOFdsM0ZCNnREUk4yeG1oeXRHQkEva2tZN2ZiUnhTNEhnOHI3VW90VThh?=
 =?utf-8?B?b2lxbEFYL1Y1WjVNWXlvdyt1SXJNTkIwTUU4Y2NFMFpiTnpYYzlLVW9jS00w?=
 =?utf-8?B?aHJ1SURNU3c5YWh4VVNLeDJEcDI2d0FIbTZ1VUFkeHZ6M2RKMzVRcmRsdytW?=
 =?utf-8?B?UjlnalMzdDMvWFlhZHFOeXJyRVJ2a29kZnZ1TXVDYTdyMitpU3NYK0lzN2hN?=
 =?utf-8?B?ZU1sMmtMaEdEYmlUcm9nejFzd1lGK2IweTNoRXRIZWhzTWxuMkdBQy81NHhU?=
 =?utf-8?B?T1NHTXBGN09ZeGRXSjhmWGZOeW1CUTFCbnR6MmpUQzQyNW01VVVxdTMyNFph?=
 =?utf-8?B?N0JrZFY2cFprZWFGWGVmSXhIN1lYcFdpcFFYNFFrV0FBb2lFb0d3K3FDOHl0?=
 =?utf-8?B?ZXc4TE5TTis1YUxndElqU05lNE1lS0puYzVMR016cWRGVkh0UkNJYXo3RXcw?=
 =?utf-8?B?cjluMm8zVmxDd2U4L1FjYXJ1L0ZRWENvRG1Sbm90cXZpY2MzY1ZUS2ZzT2wx?=
 =?utf-8?B?bEpnNU5OSjB5aWxIektTUm83OTZjczdhYUFYc0dwcTFEd0xUN0NsaVZQTDhN?=
 =?utf-8?B?UFNkdER6WmJKTStrYnM4aXhmQTZWTEc5T1I3VVVHRUdEdHBpanVDcGpldHNp?=
 =?utf-8?B?allIcUczZFBzSGlHc1pXWUNQSVhhTmRNR3dZajFJZWJVOHVHUGFPVlFNcHlx?=
 =?utf-8?B?Y3IwYVBMNmRRYzBFQjhncW1YZGtLLzhxZ1JxSE5SZFR3d21RS3ZvUmxMWndn?=
 =?utf-8?B?NGRiTktFMTg3UlRISEt1V0VsZXlZeEp1K3Y1TGxudk80ei8xNmVYV0Roc083?=
 =?utf-8?B?dFhBZlNld3VsSlJCQ0ZIakNKZ2FCQXBxeDA4VzY2MFVlaDZYTmI5R2ZrRFB0?=
 =?utf-8?B?NXBwUG9BT2pBRXVMR0JEL0Y4NTEyWE1iWTY1RGtmbytJS2lKemN0RjhlUjVE?=
 =?utf-8?B?VDdiQngwYWdtRnA3NGdBN0c0V3VpK0VnQkNOTC9CbHJhNGRBSjlkVlFWbHRm?=
 =?utf-8?B?alVsWU9GL1BTcnZmMHJxQ2N2cGtsZUhMdllGb0xqYjZLVnpaTVlXWXlqbUZs?=
 =?utf-8?B?aHl5S2FDUEZmODRhZ3dZRStwMDNIL21yQWg5UVBCakhoQjMyS0NWTjg3MGZM?=
 =?utf-8?B?TVQ5QkpjZTcvU1JrT1FmTjQ1L3NQbFpCSVIzT2ZQSFZzNW8vZXg3R0dHWGRa?=
 =?utf-8?B?bUQ5bnlQdDBQS01BMDhNU3cxVGxNZjhuZlgvYTBsWW1uVTd3UE1ZUVZ4NXp6?=
 =?utf-8?B?WUV3d1ZZQnBKRG9zK1Y2eUdXNGpmdTRVSTZWTU5PWE1ydkRJMHZmK28ySVlv?=
 =?utf-8?B?QXZ5cHRpdDlBcEJZQUpmNWczMCtvL256Z0d2SjVIMFBsaldCSVJsc0d4WkhI?=
 =?utf-8?B?SEtDeUtVcTl1bmt5NGx0SEJUb1htbVZNRTBva29nK2lSdE1uZzRmOVpsbzUv?=
 =?utf-8?B?SStudTd2eDJKVHpVclBtVTg3bzltRzVlcTlEL2xwRi9Gcm81Nll2SGNwazQy?=
 =?utf-8?B?YXdPL1hLM013UTJIcTAvbWVFMGxySzZCUXZaTXZFUEdpVDIzVWh0ZnR1eVl6?=
 =?utf-8?B?MFlRTTBVeURSdU8xYm1SYmkxbjBWN0xRaWRCOE4ycHFzSUVsZVhhQXAzV01H?=
 =?utf-8?B?cDFmUHhLT2xHNWlkc2RBN2F5VEwrUGtMMXdDRGRPck10NkRPMXVwMW4vMHFp?=
 =?utf-8?B?WlE4cGNIaDZiSjMvRi9UdHdmbjF2c3Q2Q2tyd3p6S29mV2dqWHc2eWJXWWNr?=
 =?utf-8?B?cjBnTmtaS2w2VzNZVWFSWEVaTFRyUWpUSTRBNXIwVTlDRmNsREdpUGt5Q3c5?=
 =?utf-8?B?cm5MYnd3QnN5N1h0ODhFYS9ibXdVQVFnejlmb2pNeHdMS1NmWHJBdnRYS2Fm?=
 =?utf-8?B?N2hRQ1R2clJDZ0IvUDg2MU0zMW15MXhuOFlPdlB0T3E4QXREVGkzYlRMZ2JD?=
 =?utf-8?B?aUFnVkxhZ0c5WlVtZ0E2TXoyTlNwMHp2TDFNQUd0WFF1bnhZR3FVUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y8FcuTdqYFFsDL6YOmfjnC1Rv5DSiW5D7WiYzl5lHE7lnYwUsrreTtOjvtRU+tDaYI3wql80rdnaTHmjZ3mr3UXFrE2QHkNRd3eyrvdHFk4r1TaTqeJgRBcNeQ2mQRatyChStNGeigrt90VRJUpr14jqdUidRMKRt2lPSUJhvIQxwuDoqPdrGe8DMonrmWjuL4hg9YaiLcWp52Z/cPPlXfQOHkNTqBayRmeZNAVC4EROOC0gzipZiTcjKQXUpewXEmVlx7hkqbmH+xaEpcItWXQj54SyS92EbHucxIwy0gsISmfpSIIdwyKnaiKKr19zuW8lq6H+Kk4XuC7/n7Ju3Y6JpBB2gBEHmcVX5ojq3mg95Xu4P0oUD9faucgsHISfogYs99noDPXaJhtvTub/tnibh/6IZxE9QoU240+AzWa21Hv94Swj4ohbcnOxcb7m/BmaFa0Fwaa2Vfg1NeZ41Kw+EaSP9P1QvGJNqm8bwaEYtEqdCbZuUrT8zf/lIop1Y6fCj8UubkintG0zUmD6e9kzmr+eFBDAR5dEIWjgmpv2HiyaDCREBeWrbIjfD6TUIcHSHHs5kSiM1KCh11gjZdBRVaXWipV6CmdWT5h4CjI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90d5dc0-f613-4260-4b25-08de68deaa2a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 19:57:48.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lplbADr4qtHSe76ZrPOVS4TdkcgVgotELio/9Kzu+hQXsZW8RooiUbIdBJlj9oDwvTHhNqPY04jY+TsYl7/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=659 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602100165
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=698b8dc2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Ni55W4Fcb3mwT4oVGm8A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13697
X-Proofpoint-ORIG-GUID: YBdCc-EeS8hRGVc1xm6GVwDL5q51x4Dn
X-Proofpoint-GUID: YBdCc-EeS8hRGVc1xm6GVwDL5q51x4Dn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE2NSBTYWx0ZWRfX7vK9DEtlTESR
 Pcft+QJm5nP9U5a6UGTSpmw6KPQ1P32w8eUdqpO+oTaBzcCthNmTxkfABTsVJ15JVsy2Oy3+NOC
 JZYDuV/tsI/lnNhRdse8Z9ZFwRT/U78DpUCliTT0W2XuPrXvGPQ1/XdaZ3bT5X2MGJckUmCyK1c
 FV/fK3RSrfLjeDuF+FyWU3JS+aqlcdfKX1WqHr+bj6CVB84/Ir1jmw7ZFTqN4ZEm8xRJcVdPydk
 hhkYvFrcBBz51qYH/y7b3cQVDkk9CdjwdjmkWwT+Fhiu59a6XpDyCRs5Pt4+tBmKI0bdzP1Ve7O
 ZQb6l9pD52x7oUrGVGUh27dweY+TFdJ6nPcxd3e9P95qf5p/irP8w6KUH3JC2YCPSONEbH95NzQ
 U0kBGOd+YERIlcaR0EMPL+9lz+6kVzz0XQGEIQZkklsEJGyOif2p0b4OekjWZxmPOru+Z5xh1o1
 bgHKfd3yQzv2pUDiYYHxGC7NGwLy1xrELVX57sgk=

On 27/01/2026 17:20, Alan Maguire wrote:
> This series brings together a few solutions to issues we have
> with accuracy of BTF function representation at the binary level.
> 
> The first patch detects mismatches between concrete (binary)
> and abstract (source-level) function signatures as a means
> of either excluding them or providing a "true" function signature.
> 
> Patch 2 adds GCC true function signature support for optimized
> functions; with that support, we use binary-level signatures
> for .isra.0, .constprop.0 functions and represent them with
> their "." suffixes as BTF_KIND_FUNC names.
> 
> This allows for fentry attach to such functions, and
> the "." suffix is an indicator of signature modification.
> The feature is guarded by a default-off BTF feature because
> older kernels did not support a "." in a function name.
> 
> Patch 3 uses Yonghong's example program as a test; compiling
> with -O2 we expect a parameter to "foo" to be optimized
> out and the true function signature should reflect that.
> 
> Patch 4 documents the non-default "true_signature" feature.
> 
> Patch 5 is Matt's patch to favour the strong function
> over the associated weak declaration.  The other patches
> are important prerequisites for this as the patch selects
> the binary-level function (with a lowpc value), and in
> the case of optimized functions we were often selecting
> the .isra function with optimized-out parameters.  Because
> pahole did not previously detect this correctly we ended
> up with functions with signatures having reordered parameters.
> 
> Patches 1-2 help avoid this by better detecting optimized-out
> function parameters.
> 
> With these patches in place, ~20 functions are omitted from
> vmlinux BTF; all these are "."-suffixed functions which
> we were not noticing had optimized-out parameters.
> 
> Experimenting with adding true_signature to BTF features
> we end up adding approximately 500 .isra and .constprop
> functions to vmlinux BTF.
> 
> The true function signature support here will also hopefully
> help pave the way for Yonghong's work on the LLVM side.
>

I'm planning on landing this series shortly, so if anyone has
any additional feedback/objections do let me know. Thanks!
 
Alan
