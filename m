Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775F221F1A
	for <dwarves@vger.kernel.org>; Fri, 18 Apr 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972584; cv=fail; b=VRAeCiy/UyK5X/Iosg7XUsIZpDoSG3wAzgcLTUSYTyD7CaUx0SylYlhK71rjL7Ivo648RdgDnBSOW9UbXY+GUh4jF8I6ePpKEl9oYBFVHg2KSuBsn+KHgZstR0sa/3tmZHjRyRS84C63VqbZhs843P1esLrGO7aZa73FGwvoA1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972584; c=relaxed/simple;
	bh=DS6m7OnUXzSiMMImBNQTHKBXtWNYKqQxDifN7XtLaP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CnCXQbNQQsYh1VAlIAzYq1XGQCetK+avpPJwZiaEdCq4f4rRuANfaSndUatsfErHjDcQIzijeq33ye1uK1yhLGvx7yUASc2xnWmHb47nQ1XF4fGW/cgb/22e7rh6Zfe1tsf4qP6R8V95yno2n7ZktjIW5GWt2X4o0qSJccPilxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iUDiyiRB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wgp3BZuR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iUDiyiRB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wgp3BZuR"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IAH2eZ028964;
	Fri, 18 Apr 2025 10:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NhGJCURs/bsilJkY5tErMQshCGQc7fZaC+8UVAHfTzM=; b=
	iUDiyiRBamma9VpZhtUMLdYzWDNzVFnCxKctVnQ3vRszg7+VJ2QKYExzL/j7FiW8
	Dfy0TWrxM75Qo3xT4vmEs0HTgvJ6QE/gFQPogdVoXAjr8wVqqGBP/V15deqDYVnn
	m+Iv8SdOHPYB91QwW6BarLML5W9u8ivCBSpHL3tt9ckMCha3DM2vXlQlit490Lpy
	4BxtrjYE6WNtVgXN2ffmSFwkU+362Qg7SJl0pd/+QQYQu4AS4duQUp6vbsIQNeUk
	OWR78kZq0mMp/XpxT+mVcjKtrr7bbfj9NiC5LYHOkHwS+dvB/p3f7zrh+9drc37v
	33xxN3lazZP7FM3Eo4LWwg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 461944ft00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 10:36:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53I9MrGH038821;
	Fri, 18 Apr 2025 10:36:06 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012011.outbound.protection.outlook.com [40.93.14.11])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4vrsuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 10:36:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNFlXeUZpWOAE19+oI/R8PW7PCQLwgxvaaQgbVVTkj3oxDpFQOO8h1rfchdsJjoFesXXRDWPm1PKY9C4x82zISVDSCZdNuHKPp5HKkuuaC+sA06sCz8YJ8Y7/Wid6toMBrrpc7nZHMgWucS66LsUGy0KrIlTqc2PZ0AUUbawftBAUw9E3ff+1twfj3paxWiiha7xQOuRgbMOhYOIvy4DIgJqghYdiKnt3IUPlNL/45asVSw49EICeZnnJdz1WLoyLwIDRep+xuIrmFrhNlQpQZLYlAl3mpa23zJZnPlFj/Yt5ScaL9vbh1AXCDHg2DZJKUyAGS6+22UpKSNo+5Kryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhGJCURs/bsilJkY5tErMQshCGQc7fZaC+8UVAHfTzM=;
 b=YUtj6H2V9CwqFR9oZL38tKIJUdR5uC+v41OJpe5hw7DBbGQxeJmIhus8FCHzZh4mxrokr2K8uY1ByaEc58cDwf+gMZsj/ptRxZs50b0llFnhhwBVJ6P5L1uIx36vXo3IovHAeafOOCEI6GimS7D75lWdbSO5UCwp8k45fuw/KVv3/kTAsCBGw8eTkffiJ33JhJoOVVDWOcvwsFd5VoD06Gz19bXHj8C+UWH5E9W6PXqrZAohH3LQByOfyZA5E6cI72zz9+VnhL0pj+vytqC2Y5WF8FJxdwc60eGy9OiMWHEOFffC/5rjppR9iIzO+OktP6nau55aPEUiqDEZ43f0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhGJCURs/bsilJkY5tErMQshCGQc7fZaC+8UVAHfTzM=;
 b=wgp3BZuRGwKHchqe6nIkmw4NB5uJ4v0O1Eb2CVippj3ZTAOsusuzc/y8lRGZizLL8sVX/yX7Ok5WOKEMheu+dZXRBp+sZeiYvK3R98OB5cOStPPB5cwpKTXB61kHv/wBR9eONy/E+OmAU2ymnCxlu8mVl2q3zPgzW9ZqGGrr40E=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB4362.namprd10.prod.outlook.com (2603:10b6:5:21a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 18 Apr
 2025 10:36:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 10:36:03 +0000
Message-ID: <100faea4-1408-4de5-8cdc-2ebadeab00a7@oracle.com>
Date: Fri, 18 Apr 2025 11:35:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Despite `-DCMAKE_INSTALL_LIBDIR=/usr/lib` libraries installed to
 `/usr/usr/lib`
To: Paul Menzel <pmenzel@molgen.mpg.de>, dwarves@vger.kernel.org
Cc: Ben Olson <matthew.olson@intel.com>,
        it+dwarves~vger.kernel.org@molgen.mpg.de
References: <9fb4f7ba-0de1-4f75-9bd2-66212ca8cd86@molgen.mpg.de>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <9fb4f7ba-0de1-4f75-9bd2-66212ca8cd86@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::16) To CH0PR10MB5276.namprd10.prod.outlook.com
 (2603:10b6:610:c4::23)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM6PR10MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b7e8af-235d-4038-a53a-08dd7e64cf13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STIwNHVaYklVYW1LbXc1VXQ3TjdINU0vTkt0K2lZL2JLY3JPeG15QlplZjhR?=
 =?utf-8?B?OWNsay9uSjU4WmhEYWxnVFJ5ZmErajdMcFgxWEJCU0pXNU0xcFF3T2lia2lN?=
 =?utf-8?B?RS9QVU9kSG9DOHhJeWFSdnEySnFnM0p6M2lYcE9sVDhkZHlFMlZ4dFREbXVq?=
 =?utf-8?B?LzliNHJkV09Lc0tlS1p4SjRDbE9JY0lmNFpyTkt0T0FPdW85V09scFdRL3Nv?=
 =?utf-8?B?WUZNNHJsTUdGQ2lVc1RsdzgvbUwzWHRMeUxPa1Y2SnQyT2taOWx6bVZ1dGlt?=
 =?utf-8?B?Y2hXRHN1Y1F4ak12eXRYUWxMczZjMjEzRmN3K0Exb1pDcVNGeHlkQ2RkSmUz?=
 =?utf-8?B?aVNFb0JPVGk1SUlyWXBPVnJHT1ZOekxiMy9IRjV1YXlBajR6aDJINGRLemFM?=
 =?utf-8?B?UENhdGREREFhaG9heGZxVkRnUGZSNkU3NEc2YzlpOHJQbmY1Vm82MW9sNzdL?=
 =?utf-8?B?ekN5eDJrUzhkaTI5MHZHK2x2Y3BtaEhUb0luQy8xRnJGL3NhaGljZWx2L0Ez?=
 =?utf-8?B?SllUYXVBd0hDNllKdHhCNGxtcHhWTnJHVXRHOENodGtRQkU5NnloUmJXRkNJ?=
 =?utf-8?B?Q0FIOWlnRFZKMy9QMFRBWHBFbUxtTHp6QmUzQWVNZDBaaWxBUUI4UjRsUXBR?=
 =?utf-8?B?SGRnWWN0Q2lzS2pqVTdDeU0xSXp6MU1FN0NuUUxSWWN4TjdRU0cvNXRYWmJW?=
 =?utf-8?B?SmloVEJYNkNCK0t4SzdNSzVmVEtPaUJpT3o1L2ZqMUpyM0dQVkw1M2dtRUdh?=
 =?utf-8?B?MENxd3B5RTRxZVROK281b2VaUk9OYk9Yd0xDYnE5bTNYTTgzTTV3ZWhCblJw?=
 =?utf-8?B?U1FyUC9zVDhDYnYvS2ZvNnhwZ3pqT09vUTZENHNHSUh1SHpRYngvL0xzaUVr?=
 =?utf-8?B?MFRWZjRpNkpvOFprbzBtWVZ5bHN6cEVjdElYVnpiRVQ3R0U3cDY4V3o4QjBE?=
 =?utf-8?B?QVdaNWhsbUlSUkNQVkZxQmJzc2p6L2lSTndwYlIweEp2cTVCRUxwKzlEeDIr?=
 =?utf-8?B?aTJlc1BDV0tHNCs1NmZKS0V5WmVCTU94WTRqYlNIYnRuUzJaaE1VMUlhSHFW?=
 =?utf-8?B?UWFEeHdtalcwaW9yUnkxZlUvQndJSFh1RmRvdTlsVkpKcDZQNGF2dEVMVXBH?=
 =?utf-8?B?d1dpSjlEYzJCNmlJZzlCMTJKcGVNNTRZdmJ4QmNvNGFQam12S3pDK1Z6ZFJo?=
 =?utf-8?B?UmZ6TmErZEc5b0hBeU1KREpicUFVTmJQa2taVmdMT1RDK08wbTVRZFExVjcy?=
 =?utf-8?B?RFVUQlBWaDd1eVlPekpqL3J5VjNRRzlHcmIrWXc2UFc5R1ZlSzVONWVIT3c0?=
 =?utf-8?B?cTV0c2dKN1M5WWFObmJvUU1ZY2t5YlZhMEdjbEtITS9DdGZFSGhBeTVkeHc1?=
 =?utf-8?B?czNyQytJSTYxaTFXbHM2M0FCZGVpSVd2ejFIYzFSQUxFSTRGWUllSDd3Y2o4?=
 =?utf-8?B?SGRxdW5ORnpJYzQyc20xYXRiMnEvMmtVczE1N2dGc0NJZTZMcWdRUWw3b3Ir?=
 =?utf-8?B?eXY2THBCYTEzbERDNWFRYU9HWEhSTnkxMTFEblcxN3NFNmlwT3laSHp0Ry9I?=
 =?utf-8?B?ckdYNWd6ODVBWVFsYWc0ZWpVZGFmVllnMWI3ZUw5QjgwTjk2OGVwanhHenNn?=
 =?utf-8?B?bDh5ZEdaNms5dytHbzlsZjhEa0U4MytVNkJlSmZBL2Y2YzRxTHVnV2txNURK?=
 =?utf-8?B?ellVVW16Y3lPSzJqcEo0NCtUNEtQeU1DdXNOM0lHa3Z0MmJ5TFNGdUxVcjFZ?=
 =?utf-8?B?WUdEZDF1ZHU5QjJGS1ZNMk5uN2ROLzVRUFpNa3dhbW5VUmNyNzR4ek04RUhj?=
 =?utf-8?B?VzBETWVpdi9SVlFvbUoyNnFGSlluZi9LM2Rra1ZsZTJkZjAwL1V2Vk1ZUWQx?=
 =?utf-8?B?QWo2TXdvbERHTnJpZTVYTVYyMlRhZEVLdkdqb1lKMTREaWVUaXorekhwT2VL?=
 =?utf-8?Q?xaxP3/ru2aA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0xic3ArTXhVTjZXMWVidEFrQ3Q2dzNLdHdrK3d4ZGpON09HVncyZTlHNEY1?=
 =?utf-8?B?MVFjWXZ5cUZ6QWc5U0JHamk4K2hpUmo5UmxOVFA2cjUveEliMVZJT243c0Fv?=
 =?utf-8?B?SjFuZ21zT2Z3VVpSL2VnaDRTb05Ub2ZsNzJqdHYreExtRDFZZnIzQkRrdzI0?=
 =?utf-8?B?Z0hZTmNHMzB5cldocEo4WC9DR2pQOXNCNG8wYjc5aWJzVk1BUlpmQWcvV1RQ?=
 =?utf-8?B?UkFwWWorR3ZYS2JtOTl2RFVVT2ZISDdLeDV0TUhKMnhCYklhT2VHL1l6c3dS?=
 =?utf-8?B?SEhIRjJ6WlNWTHRlQy9Oeld4cE95QThEWnA3TzJuMXUvekM5c280eE9SQW5M?=
 =?utf-8?B?Q21FMUIva2hnVUdyNDJiU3pLU1Zzc29CdUhES3hVWldmVXlhMnVaUnRMYVFt?=
 =?utf-8?B?NE91SUQwVVpwcG9sUmR0TUZGQUNLc0ZrSXBtU2l6dWV6TnVHa0ZXSU1tbjNz?=
 =?utf-8?B?NDhsNnQxejBwZnV1NEJlUHRBNjZFb0ZBamhmVzgzY25CL1QzV1NMcVFwTlpn?=
 =?utf-8?B?aUpXZHo5K2ZVMUxoUzdvRDJmMzVQK3dPM2xVVmVNdTlpTk4xc09rd0trTVkr?=
 =?utf-8?B?MjB6ZU11YTYwU3hvdm5seVVvVjhPRVE4NjdzaGcvQ2dCOVF2Ny85Nm1WWjkz?=
 =?utf-8?B?RjBpZFpCVE5zcWdlVmJyMkZnSjM4M3lnU3k5WnFleFlUMloxTGFFZWY4M2Zy?=
 =?utf-8?B?bHVDQ25YTlNHaHMzb3VsWVBrbytxZEdNME81M3pmbzlaMEM4YU9IaEFzc05v?=
 =?utf-8?B?VzdESmFQOUNnVzRPUUFsSnRDcVlWV0FUR2JyOCtNcUJnVVIxbUczM2VJdWpa?=
 =?utf-8?B?SGlTVlh1dkNBTkpsSWh0dGRUUHhOd3B2b3dBRlBBSUMzbHU5VmN3cDJJYmpW?=
 =?utf-8?B?RHJFZ3FFSmFKeFZzVTdEQS9ob2NTNXNzVll4NGFOS2RMbTBKcnBpSTl5L24v?=
 =?utf-8?B?S0JlTERSWktqRjlsTDJxVEswczM3eTBncXlNY3V3cXQ0UzRMRFVCVHErR0hQ?=
 =?utf-8?B?NUxoR21KY3JRQ2Nrb01QYndyaVAvVFlyT1RDK1JyUWZaTmkzL1N6R3Bxc25m?=
 =?utf-8?B?RHluck5QTXZuT3phcitva2hWZDQ1QUQvSUhySElaSDV0bHV3a3QrTWFiT1FD?=
 =?utf-8?B?YW5GdGVFNW1JOGM0N0lJeTZpZGZ2VnQzaS9NZTNPbWFON2U0L1ZCMDRSTWli?=
 =?utf-8?B?UVhRTktIRG9iR2hJb3d0b2dQcXJwbVErRXVEYTVCb1A4NW5qUFdLTVNQTUYx?=
 =?utf-8?B?SzMvdUs2NWdMa285c2tINXlZdFpBTXc0UEZDMGU2d0JDMGI2RndQZWdDUVdO?=
 =?utf-8?B?TWVMVHJtSzFvNGc5dXh3MnVHdCt0bWJiS202R2RKSGR0TDV5NE1EaWpDMWZ3?=
 =?utf-8?B?TXZSYUd5NnJSN1JBN0NzY2xLU0YrY1FMVzAxd0lEYS9wN1d3R3ByNDVsaytO?=
 =?utf-8?B?QUsvWURRcmVYVXdTUncvOXZvSU1FVGpEb05KTmwxc3FUTDY0QU1ObURpb2Uv?=
 =?utf-8?B?b2M0R1RwZ0tlZDZ3a2drQmdGRy9LcUV6U1RxQkxWWkp4U2NXRmVpVnV1SmZG?=
 =?utf-8?B?SW9IcTZQbXpRSHFZVlNpc2lpa1RJNnFoV21BeitmeXd2QkFVbEwzclA1MXFN?=
 =?utf-8?B?M1BOb0RGbXR5RWtCK1pnZWxJTjdWSnZLVnVVcmhIQVgzVDJxSm85N1llMXBq?=
 =?utf-8?B?Rzk4NlNwZ2NkeXJBVGNwbGMxd1Q1eXFualc2VlQ0RnFNMy83RnZsbUJWUTU5?=
 =?utf-8?B?QWh5RHRJeXNrYnA3SlpJcHdRZTZLUnhFLy8xTWZNUGk4eEw3VEJLZzZuNHZ6?=
 =?utf-8?B?WTJMUEkyMTNGMGVleHBYc2Y0Rmkvb1psNlgyOGk5dCtKTS9CdXlsQnk0TkF0?=
 =?utf-8?B?VFpXV1REN2RrS3lORnBFMWZBQ3Nsb0xzSlJTbFFTS1NTQkxkcjRpalBnejFB?=
 =?utf-8?B?U2tuTmh5eTU0eC9tdTJnZjQweVlCQjN1cW43T21USnAzaUx5RzczQ3lsWkRS?=
 =?utf-8?B?a25xakJNNUxHUDdkWVBPS1pNcDd6eElsR3ZVVDBHQW1TaFBXMjkva2U0ZGw5?=
 =?utf-8?B?Z2NWZTNjbSswL1VFZi93bXV4eWtGK01YMlowbjZaTnhFZUxyL1JTSWdqZ1Jk?=
 =?utf-8?B?SzdoVGFsUzcwL3BZSWJnN29aUEcvcDFBVnZXS24wTVI0WU44b1g3WS9KS3d6?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/PYDh7YXnIaHmtgGNpkFSg1R93fh8SzOrFtA+VqnXMj9/F/heiw/69A1Q8pDEG5HphrUVhFs4giKaP5u5NjpiZ2kjd9073Bw9F4NxtSrNLztxBhllNxL2ajbAR0j8vo6jXySaH0QOn8nlDQwo/Xyuu8521Z02ysgeOZCQUQE9aauGLhxauVfStGJ7pS0D40peKb3PkwsxiFLvSBVb9lANKt/axH/iQclYzhOpAQ4+FgbHI48idrfg2WAmspCDkbHHrzKfLbp0qKw4eYcXrRr1HYeZZ6EiE/mjlneJHQsdf88hPczHswLQ/na+JMcNXmjtUyIv2BoO3kI+DrUOftANhPsTHctXUXbFlIDEpramEYe5OG9uOli7A55z9Ihgdd1jFaOPNCkgwk8aTnH0JX8x/6Yb03GQy7s0+L7/ZB+DvrIe4JrMJr0z1KSRCL1W4WyuoJdpCRWZ6e5N+KlTBKHO10C3Jl7qprWBPVDih9DrrXkHZmUgRN5dbYlXUr8FUpXKb2GteiS9ChLHKw14bHiQ5PWNZbeZ30MuIZyLLtFa3p/8Cz18yhV9F4sfXwsWdLNGnzwakouDXQz36J3ZOdj1AA9WUhcJjxfb6JlhGEhv9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b7e8af-235d-4038-a53a-08dd7e64cf13
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5276.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 10:36:03.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpSdPi1HqOPlPOyTaQawI9UnU5kTT1Bxx7kDBrUqEXPTqxEV8V1qnKxWn03//Cy0nvzRkMEuLCLoItAL0KeA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504180078
X-Proofpoint-GUID: fbYYf-PWj5yCxD1wPk8nri2OfIIABeOL
X-Proofpoint-ORIG-GUID: fbYYf-PWj5yCxD1wPk8nri2OfIIABeOL

On 16/04/2025 11:39, Paul Menzel wrote:
> [Cc: +Ben, +Alan]
> 
> Dear pahole folks,
> 
> 
> To build pahole 1.30, I configure it with CMake 3.25.2
> 
>     cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=/usr/lib -
> DCMAKE_COLOR_MAKEFILE=OFF -DCMAKE_VERBOSE_MAKEFILE=ON -
> DCMAKE_BUILD_TYPE=RelWithDebInfo -DLIBBPF_EMBEDDED=OFF /dev/shm/bee-
> pmenzel/pahole/pahole-1.30-1/source
> 
> and then build it with
> 
>     make -j300
> 
> and install it with
> 
>     make -j300 install DESTDIR=/dev/shm/bee-pmenzel/pahole/
> pahole-1.30-1/image
> 
> Unfortunately, the shared libraries are installed int `/usr` as the
> prefix seems to be prepended despite LIBDIR containing the full path:
> 
>     -- Installing: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves.so.1.0.0
>     -- Installing: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves.so.1
>     -- Installing: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves.so
>     -- Up-to-date: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves.so.1.0.0
>     -- Up-to-date: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves.so.1
>     -- Up-to-date: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves.so
>     -- Installing: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves_emit.so.1.0.0
>     -- Installing: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves_emit.so.1
>     -- Set runtime path of "/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/
> image/usr/usr/lib/libdwarves_emit.so.1.0.0" to ""
>     -- Installing: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves_emit.so
>     -- Installing: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves_reorganize.so.1.0.0
>     -- Installing: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves_reorganize.so.1
>     -- Set runtime path of "/dev/shm/bee-pmenzel/pahole/pahole-1.30-1/
> image/usr/usr/lib/libdwarves_reorganize.so.1.0.0" to ""
>     -- Installing: /dev/shm/bee-pmenzel/pahole/pahole-1.30-1/image/usr/
> usr/lib/libdwarves_reorganize.so
> 
> Looking quickly into `CMakeLists.txt` there is
> 
>     […]
>     # Use the standard library installation directory
>     include(GNUInstallDirs)
>     set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "libdir name")
>     […]
>     if (NOT DEFINED LIB_INSTALL_DIR)
>         set(LIB_INSTALL_DIR
> "${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
>     endif()
>     […]
>     install(TARGETS codiff ctracer dtagnames pahole pdwtags
>                 pfunct pglobal prefcnt scncopy syscse RUNTIME DESTINATION
>                     ${CMAKE_INSTALL_PREFIX}/bin)
>     install(TARGETS dwarves LIBRARY DESTINATION ${LIB_INSTALL_DIR}
> ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
>     install(TARGETS dwarves dwarves_emit dwarves_reorganize LIBRARY
> DESTINATION ${LIB_INSTALL_DIR} ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
>     install(FILES dwarves.h dwarves_emit.h dwarves_reorganize.h
>                   dutil.h gobuffer.h list.h rbtree.h
>                   btf_encoder.h config.h ctf.h
>                   elfcreator.h elf_symtab.h hash.h libctf.h
>             DESTINATION ${CMAKE_INSTALL_PREFIX}/include/dwarves/)
>     install(FILES man-pages/pahole.1 DESTINATION
> ${CMAKE_INSTALL_PREFIX}/share/man/man1/)
> 
> Passing `-DLIB_INSTALL_DIR=/usr/lib` to `cmake` works around this. It
> looks like it was supposed to be fixed by Ben’s commit a2abd9482162
> (CMakeList.txt: Respect CMAKE_INSTALL_LIBDIR) [1], but it doesn’t work
> for me.
> 
> 

hi Paul, thanks for the report! I'm not sure that the behaviour you
describe is unexpected; [1] says:

"If make install is invoked or INSTALL is built, this directory is
prepended onto all install directories."


I couldn't find any official documentation that described the
interaction between CMAKE_INSTALL_LIBDIR and CMAKE_INSTALL_PREFIX but it
seems reasonable to me that the prefix from CMAKE_INSTALL_PREFIX applies
to CMAKE_INSTALL_LIBDIR given that the latter can specify relative
paths. Commit a2abd9482162 prepends CMAKE_INSTALL_PREFIX explicitly:

+if (NOT DEFINED LIB_INSTALL_DIR)
+    set(LIB_INSTALL_DIR
"${EXEC_INSTALL_PREFIX}${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
+endif()

So you could either update your cmake options to specify a path relative
to CMAKE_INSTALL_PREFIX:

     cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib
-DCMAKE_COLOR_MAKEFILE=OFF -DCMAKE_VERBOSE_MAKEFILE=ON -
DCMAKE_BUILD_TYPE=RelWithDebInfo -DLIBBPF_EMBEDDED=OFF /dev/shm/bee-
pmenzel/pahole/pahole-1.30-1/source

That seems to work for me - I get the install into /usr/lib .
Alternatively you could use LIB_INSTALL_DIR, i.e.

     cmake -DCMAKE_INSTALL_PREFIX=/usr -DLIB_INSTALL_DIR=/usr/lib
-DCMAKE_COLOR_MAKEFILE=OFF -DCMAKE_VERBOSE_MAKEFILE=ON -
DCMAKE_BUILD_TYPE=RelWithDebInfo -DLIBBPF_EMBEDDED=OFF /dev/shm/bee-
pmenzel/pahole/pahole-1.30-1/source

...if you want to specify an absolute path.

Are there other projects that use different conventions around the
CMAKE_INSTALL_PREFIX/CMAKE_INSTALL_LIBDIR relationship perhaps? I'm not
sure on the conventions here myself to be honest. Thanks!


[1] https://cmake.org/cmake/help/latest/variable/CMAKE_INSTALL_PREFIX.html

