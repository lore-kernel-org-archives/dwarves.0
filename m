Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA17256C8C
	for <dwarves@vger.kernel.org>; Mon, 10 Feb 2025 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206701; cv=fail; b=fQyC+vUdx4FP0mnDmxTOzUVjWJNErjeloNMGQS7He7uRgVsckyYlY0aV73NsXo4XmJJgw0pGOaRF6i/OeSNiDowohaE2Y6SpCjH/fGvVc+vjNU241zB/p+cz7d+Pk0/MarnDT6Y3e1zTEGQw4cIMEY9CIB/hqRC4hmb1ZCbdVfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206701; c=relaxed/simple;
	bh=vI/vBZDUs9ChaLKFLYdgwi9ci+p+QRrJO8RETp18Hu8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c2vigl6FEo3SytMdOOfsrpTo1CQZAdsRE8mf7cE1s+FnFLjEQdIcmGL0jXDufLkP/oi8uOZaVmKcYZmNxbTHR2FjBSyP/c2dq5qzIDt7oxVvtOmJ5DxOj0E9ANYR5N7PdYkpFFNNbV2u0mH4MyA/6NDzSbhcorB8C74kgo6MLCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HfbeSCja; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JrTEnpKb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HfbeSCja";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JrTEnpKb"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AGfj4q013401;
	Mon, 10 Feb 2025 16:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/uMWPnU9EMq3laZr6ilPgMoWplsF9wND0QX3uRxK6pg=; b=
	HfbeSCja7Wh7hv2IVaY3cx7Vuw5L+JeyjTkGw/3dU6TAtjR9ZrST3W/ZLKeHbWff
	0ZAkGVZe2zs2TGU8N5WSLlf9DEho07dJHQCrGoS8j/LrneZolp46GZKtO1yNsWS+
	fagf91AzjER6o3dt2c78iip99J833XuVfbUTc9qRBTRT0dlN9+o/RlB3kyn7j3Jt
	L2BqEdlkMdSdrceYIDAjG0FCA/HjixJfWeeWd2MPs7qzelWtz2txo5SK7gJ6yWIB
	vpzBmFYy1Jm7GXUjfZznDM92bObRkXokBA9lvRYFBkK1eYoYCihcO/fRokwvKE8F
	qrA5U9Y75TyCsN3jl7pjHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s3udfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 16:58:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AFbV5N002588;
	Mon, 10 Feb 2025 16:58:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq7nq2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 16:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmHEqHKk5xkJ+1FBHDPtNuzN+Aaf6fiCyysmHpEFevKgyf3ZTXXB7LWQdvcQZvYmJACH6TSJCZAXSOq9Qeq/4SvmNLAATEdmsRtlBeIrqDb0qruQDT6y8ZeD/hEo8/afFXBTMMuCodyvvlPB35up4hFdFSs/9pg/QmeXVTenO2I/Vlq4nfJvLy2H2kuFKhJykg9Jkk7LrW/FOCHJgEx1imO1iEAvemoq3evfdLgCGreMqcbjgbSWyeJy5RdhRVVFUjfvEwVWuRPXR/D4ZWvCXIDhn6NJ1bL2RbedRP2Lvn2buHOV8fnX0RKTFv42wAQI1Mhpw8RWscCoBZO6TUKH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uMWPnU9EMq3laZr6ilPgMoWplsF9wND0QX3uRxK6pg=;
 b=LqoQMN3j2IOhAD8uRGqFWaa6/TBabNDx8tUCJ55I/a2DydF5cF+oIE14rAM26p73zSiwiNqr2vyIesla9aQBkkJ3gF3cCJ2hk59fAXj1o1Wz4iQOQfPb2+w33P+NUOFsfMzmCP/TL41yDO3/J7MyJQ1fWylPQ4fBg4LcRHXK9duKvrzPY7ozBxrzHCxzKMBfI7yEAQ0Ec4TpyWItqKKewBvlUTm8mLiOMVbOj70bjEA+i2BY5LvXLkoHwAEE52urQYRvxIOMLK6LYX3bJ7koLexFx25ZbMwP+KywksjlEdQ1F5k2+MUUFi9l1/cBssMpg4irOccafYoEtqD93+kKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uMWPnU9EMq3laZr6ilPgMoWplsF9wND0QX3uRxK6pg=;
 b=JrTEnpKbuAKpse47TqDAPoM2pEiYnF7i1H6UpzAjwIWEINv63oiQ9PQz1uwoUKBQBun4yj5SZ16nkl1sAMnggSzk8q0faU7KyNOLCQGctKJ0Rmc36Gj5NQiZACl3APoHJkdkeMqZlBHSmkY7VcHnUcAu1Ftd7JDR3HLTDZVqduY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:58:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:58:08 +0000
Message-ID: <ee05d33e-044d-4652-b6a3-06f830fa287e@oracle.com>
Date: Mon, 10 Feb 2025 16:53:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix spelling error.
To: Domenico Andreoli <domenico.andreoli@linux.com>, dwarves@vger.kernel.org
References: <Z54uxjn-wDXi9LGq@localhost>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z54uxjn-wDXi9LGq@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 75512b9f-a8c0-4de4-55f2-08dd49f41832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NklCTjRtR3AwM0VpVTBBSFpHcnluVjBYcUs4MGFpUTRMaTAxN3ppUXhNcDlj?=
 =?utf-8?B?OEhscFNibmFNRWR6YTZiNm9naW1uY2MxUXBLOEt4UXdBSGFXYWZqNnRhRFJ2?=
 =?utf-8?B?UDJTa2VLbmhkT3BhWTRRRW1uQzY3LzBMZXk3azJYclVsckNRVHpFczZETWNL?=
 =?utf-8?B?N21BWVc4cHVxalFWT0t4WlhZNm1UOTdadXc2RVNoejN5Ni83THJ2T3pLNDZ5?=
 =?utf-8?B?R2dsb2J1WHV1RlhHeHpyeldUQXdNU3Z0V0tIRDRpY3hyelBXZWFtY0pQbnl4?=
 =?utf-8?B?dkY4TlJjQS9ydkhXWUZTMGJHMzVFOUZtZVFpSWVra1FMdG9HYWtCaFMyQitS?=
 =?utf-8?B?VnZHaW1odXVXTWlYdTl3K2ZOeURMeXRDVUFyYTcxVVl4RnFRRkRDOEwyS3I1?=
 =?utf-8?B?Z3FaTUUwcC9DcGRQYzB3OExsR1ZQRnpjWWdWaUFpaGsvcldUc3FhZzJqbVRW?=
 =?utf-8?B?Mk9RWjduY3lNM1dZS1FsR3IrNzlFemt2MURoWkdiQUZ6RzB1ZFNIWS9HRng4?=
 =?utf-8?B?UTRDOHJoTTJzdUFGWkxkb2FDekxhZm5LcDJXVmJQek55YTc5VVJVR01hUkwy?=
 =?utf-8?B?Tk51ekNyWGhEdHQyL2xmcUJMWFQva2cwaktXZ0VzRjVucXowWmJRRUhmNmMy?=
 =?utf-8?B?YnFPYlFMdzdqRCsxVXVETjAxbEhNbUREYTkvbHp6OHBoUzBkcGVZV2RwZG4r?=
 =?utf-8?B?R2F6a0xkTWkvUjBhWlo4SzRKZVFUaCtZREVDelFqTnV1eDBQaUhraU9LUEx1?=
 =?utf-8?B?MjYxQ3hjdyt6SVdXcDRncXVnM2RacDQvMXVlY0lua0tUOU1ieHozd3JiRS9B?=
 =?utf-8?B?d1Q1S2J4QnUwVzRsMDRSMWptQVNjN3dtWW4vWmtSRzJsQnlDZFF0L0JoSUYy?=
 =?utf-8?B?bk5kTDV4T1FNd3FWemY3YkxnSWQybzkra0RCU1pqcVE2UU0zU2wvVlgvRmZR?=
 =?utf-8?B?aXp4anZ2aUZBRlk1U1l1ZjBMRFZEVGNFZUEwcUR4QWhpRmtXajdxcmhoVDNr?=
 =?utf-8?B?WndmOGd1MnFGZ1JNWmk5emdXZ1p0VkxONHlZU2I4ZXZvbGF6bTVPdUdvZk1s?=
 =?utf-8?B?Q0hkbmVNV1gwZ2VMVHFVU2ZCZlhaUThMNzcwcWJ2blpPKzZEZE9SVlR4Y0tp?=
 =?utf-8?B?V0pBTVBkYUxZWDVDSkFsbUtBOGhob3VrRDR4MGxWY0dHLzA3QXBMenlYaWI2?=
 =?utf-8?B?c25QaStDS0NkWUxvU0pMbkVwcWl4aTJRVjQ0OFpiVzJMbUp1VWlWWEh0dTAw?=
 =?utf-8?B?OTQ2bVFCazVsanpLUWlpcjVWQWZYaHlUVWdoYVE3UEQ4eEtaNGQwL3V2NnR4?=
 =?utf-8?B?TzQ5bkdZeUtWMlNHZE9KeWlmc2pZWFBrb0Joa2dwazJKbmxmWjdobU9sNGxT?=
 =?utf-8?B?Q0luR0RUMmhtUzEwZHdYbnR5NlI4Mk9weDlpQngrNWhsdGtDckw0OWZpV3lN?=
 =?utf-8?B?YUVTdzFqWUk3WjNzbVFodHZ5WHcwbi9ML1BQZk4yaHcwN3RHYmlidSs5a1VD?=
 =?utf-8?B?MFNSSmVwZFBTTUsrRVUvVTdZVVhYYTVhYWZvMFJob1pZSkJnTTRPUjE4VWVL?=
 =?utf-8?B?NmpyQnJVS0RQbnBJZjRKcEpUcklCdmJreWFxRFJqVFZHVHMwSjRtNXBFcGJk?=
 =?utf-8?B?ZXhZYlBzZTBsNmwrVUdVa0pBSU9GUC80cUZ2UmpMbGR6blZ1QWxHQVZ0VHFs?=
 =?utf-8?B?dlUrbVhxdnYxM2VBUTVPbW1SL2ZUWjZDNXJzQUVwUGc3cS84aWJweE9nSjdF?=
 =?utf-8?B?Zm5yUmxGck44QXUvUTJIYjlUMFFUUDZCRExyNno2L202Ri96VlYyTUVTWlNn?=
 =?utf-8?B?T1gwTm1uRm9KaHlpbUp2dHhpUnFlVmhLS2drdW5tbU5iU1htcElxK04rZUd1?=
 =?utf-8?Q?D4tDG8X6MRQv5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WSt2RkUrUVlZcHNDOGhLVUllbUlhekFDbjNRekdBZGUvUWlGbjRlblNVR1dw?=
 =?utf-8?B?K0UyOFlPRnA2VDczTlJqNTVyVFdyK1ZsOHY0NlYzamVMdTBnSDZZWXgzajZU?=
 =?utf-8?B?SW0rWmprUkhHWGtKOHlWT3FCbi83WGtGSVc1aWhtM2FnemQ1K1h0UDNLVWVL?=
 =?utf-8?B?ZXFHS2MrTHUwLzMzZUxaNmh1MTE4WUNCZGZzMkhhV0dxSFpiSW43dHduUDYy?=
 =?utf-8?B?SDVqTGE0TWQvd29HQXJMOXVPNmhIb3JOdGNKQUMyQUpnemh1Uzk1a0NyM1FO?=
 =?utf-8?B?UzQzQ3BkS1VxT3g2b3FvWlBjOWJGNUNkK0xXclNZNU42b0hYZ3YrWmoyKy9r?=
 =?utf-8?B?bXUwenVnQytDQ1ZJUGNMbU9wMFBQNUg0ZEs3WEZjNjR5KytYSnNKdi9wRzAv?=
 =?utf-8?B?WURXUnc0SkY2Q1dRbVVGZUE2QlZCWUQ3Tm1HeHJzb3B6TjBid3FRK3pwUnlK?=
 =?utf-8?B?OUoxYTZvY1lENzFDZUFKNUJteitub1QrRmV0dHA0KzY1Q2wrdnlCeGI4WUo2?=
 =?utf-8?B?TlB2bEtBcWFoWWtHNDVJL21OdHJzL0xJekJVZUU5bWk1azJ6UjVHSGdWSkc2?=
 =?utf-8?B?QTBUVTdMUldSQUZnZlcyN3BXOTQzbDc3ODJEM3FZR2ZKem1ibGVqdjczbFVm?=
 =?utf-8?B?NDhiYW1qcUZDQTVTVFBXL1hZRGRZWTA5ZGt1a1RvOVkvRUF5ZUlYdy8rdTJZ?=
 =?utf-8?B?YmErandDcEJhSlE2OTlhLzhmb1Fnd1lqeHljUFZWMzZDZTI4WEtQeHRQMkFv?=
 =?utf-8?B?bmlaYUxUaFZrTU5aV1g4VGVSN1R2Zkp5L211OGliZEZOTjcvU21VUFJZdXdJ?=
 =?utf-8?B?MDhFZHpCb0tPMjg1aWhQbERqOXo3d0hNRzB3cWorTUZ3d2JPVVNHbmlrd0Qy?=
 =?utf-8?B?K2szZm14WDJhQys0S1RoS0UzWTJub0Rjb1BIZmxScGd4UC9qNnNKYVZabnVm?=
 =?utf-8?B?WjE0M2x5NUFQK3B0eFBaVFVCc3NZNTFMT2VhVmltMXJuQ3ZkakpnQ1ltNU14?=
 =?utf-8?B?Mi9FQ0tONjQ4eDVnR1AwQzlkWm9VTFNmQmtTTlJ1bFJHN0IwNHMxREYzUkFQ?=
 =?utf-8?B?U0drT3dtNWhtdll3a2lrTW1xVlhpcHVuYkM3blNKSG03eUNQSDBkNFFMdmx0?=
 =?utf-8?B?K2E4d2F1aTNKKytFbU5ESmlOVnozb25GZ0taY0Z4Nm5aOVhrSUxKcEdXbG1T?=
 =?utf-8?B?MlA2Mnk0TGZzZU1OSkFIZk90MjlWejFreXJsZEJoenhESHpXbUVjQjdHUjBr?=
 =?utf-8?B?cnMyblp0RFZ4TnE2SE1KUURCMVB6VVRMQVVxZEhtemJNQVUvMko1MUxZQnF4?=
 =?utf-8?B?SG1MVVBmNGgxVXRQWFF3TmpNUC83cDR2WUdTeUs4bGJoSVE1ejZhVXZSL0tO?=
 =?utf-8?B?ekIxbUJpdFJQOVY4Vk1FbHRTdy91aTQzY1hSQ0w5d3hCMTlEbmhXR25EVFZh?=
 =?utf-8?B?Mmw3aVkrMy93Z3JhdGkrMzVFdlUwTC9td3MrTU56dVV3cGd4WkdOa0JML2gz?=
 =?utf-8?B?eEhwRVNOSGhGeVNrNjlQRHppV3BQZnFndGtES1Iyd20zdlZ1c29MTUhTT3dU?=
 =?utf-8?B?MFFabnNuaENnQ0M0NjV5cjdpSzFsUERVUWhNQi9pb2hNMy9DdDdVbklaVlM1?=
 =?utf-8?B?aVd5TFBYTm0xOVVRMXhMZHY1ZzNWUldWTktaNUlQcTB2Rkw4dVQ3TTNoc00v?=
 =?utf-8?B?VkhQVlpTcmJOdk9Nek1PaklLaUNyWmxOUkxqdGxqN0t2b2wybXJRQlpmNnJL?=
 =?utf-8?B?SDg0aGVqYkw4OGo1SmVxZWhXNERqK1g5Mlc5eHkvY0NSZ1BnUHkxc3VEd29s?=
 =?utf-8?B?L2VRMTFVbG1xMlJ3cUsvQUNDUDk3Qy8xT0lzSkFTTDV5WERicGQrWFhySms5?=
 =?utf-8?B?SHBzOXNkUXV0SVlSbU1tdUFHMkZTSGE0SzRtNFB0RkdiTEtUbE8vb1pUM1Vh?=
 =?utf-8?B?cHAxR01OVXNETTVEaTlaTGFIQWR0elA1aEtQSkltRXMyZlRZMUptRG9YblBM?=
 =?utf-8?B?Y3ZKRnhrdHBqRTVqdG43K3g0Y0RUaThKYUNhZEQzMERwYXl1MW5HbnJSWW5p?=
 =?utf-8?B?WE1VVVpTb05wV0t1MnRPbFh2Y1UvSUt1QVlSeG5IUkpYM0VVRktwUVhSeUow?=
 =?utf-8?B?bXJibUdjTDROWjBjUS9oOUViSVBUMmdsZDgvTEYrSFRyME9OU2wxYzd4RDhy?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JzptnJyfHNtzUUkVDiekKm8d7RYcPKCtGdt3QcRZwXIg0b2aP7mdcFNsLcVMXYkDPCAiBiZq3oT40MsxFTrR6a4lNgiKC/9Pqyc/b1NYJERY/6YYvQfdswYXDhNwjDD7Tsvorcu7Tyes9vwBibrhQ72Caw+hXGHHsh6fmpTVTTIm4W7RWW/4v65dWjB3T9EVv++FaXE2nWDDpJscLML0nLTEKwrpWp5L+NljNOUYmahqQwx+F8Jd2Jydr/LiViWqjJnly1CaC0VqiGj61ReGNzHoq6e/fE5dMmMaCwRETN+O9f6hgu2PCgfZoKGgyOcrcHd9GjmnEed0cRXACmvkVQZKlN8FyzsGa+wb6na0yoItrCrhxW9oxX4SXSoViB1ER3SPu2I9vs33D9I5bJ2sfP8m3DKxw7v7iuKhoXwlPUWS0H0eU9ls3Mz8FhLsnSKqrV8rP10hgbpSg9hBA/mgwsSUiiYPlCkFIK0WsoZl3JH8ew9ZUToGD/E9Fi+2v434ATUqD5lXg5iMv4+7sO7ISd91P5rJQNkrhg/huaPPBl/MreILzO7Aacxm6N2/BSssuy3WoWQSCCv3t20KLZyu7u1PEsqtbbzGCJgaNpcRbU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75512b9f-a8c0-4de4-55f2-08dd49f41832
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:58:08.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMDNQPiOhIvopxiIEcP91ZKdhyuM6E3wewBGqqZt1Ha6XXxWRAHEH0FYddMTuGEgzA8E95X+StXKiNtCtQPpWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_09,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502100139
X-Proofpoint-GUID: ff3Qd_Y-EmT-w7f4U6CZ0QtW3u6Mb_DQ
X-Proofpoint-ORIG-GUID: ff3Qd_Y-EmT-w7f4U6CZ0QtW3u6Mb_DQ

On 01/02/2025 14:25, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Fix spelling error.
> 
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
>

looks good to me,

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>


> ---
>  pahole.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/pahole.c
> ===================================================================
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1436,7 +1436,7 @@ static const struct argp_option pahole__
>  	{
>  		.name = "with_embedded_flexible_array",
>  		.key  = ARGP_with_embedded_flexible_array,
> -		.doc  = "show only structs with an embedded flexible array (contaning a struct that has a flexible array)",
> +		.doc  = "show only structs with an embedded flexible array (containing a struct that has a flexible array)",
>  	},
>  	{
>  		.name = "expand_types",
> 

