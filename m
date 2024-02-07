Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2B1B270
	for <dwarves@vger.kernel.org>; Wed,  7 Feb 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303811; cv=fail; b=HRBSr51xX8uLo4ZoaQv22fYw7J1W6ck7K1u/owLwMBuIil3yuglNQmB/zBG9g+L6L7/V9h3+sdNXsIQ/bEZoJVS7jBSHq+fEJ7yU6R9rzvhQkjPare2liRPcfWd0JFzwXxdyD3AHtD7DtZ51/ULD50ZUNmo3vFRnlHZsImOFyOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303811; c=relaxed/simple;
	bh=BpYgZOdxbF5WRnax7QqajZso7p6TioQTozTxpUkAaVM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q8tnpLWHk0eolSbxBXkHUAL55rAm1h8H0FaGaqsZkxral0Vnme2wd45GIw+lI/GlTv4qJLyRPwel+v0t0jnPQfo4kXlCwlMDcd2rkQEaynAAyAWqwwGo4SpDfsJ1W5VZmDD8nFB3cakKTvE6CK3qPhZ3QYwjgQQSUdvfhgi7x2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dTI7Bs3Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AgSHyiDn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dTI7Bs3Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AgSHyiDn"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417AEhiC006000;
	Wed, 7 Feb 2024 11:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jJf7iwN9E5UPCKgiA2ZnjWBHmzoYGvKwrVB0/tUerbc=;
 b=dTI7Bs3QXlrbfSVzWJI27Q3wIr///2P4pTWTis0R5eQFG9K1BmFSZB9N9D3GmV54Gyf0
 mPM5nypVzQvPl8rKrca7O+M/wU13Eba3+OdoW2Q4b4M6rVG0as6ZwyzLyo2hp3pyeE5O
 iK01wOiUgnt47igCNIHnD16LUdoL/PJByiSQL5nDGEjHB0e33vxnOB2AtocFOgyYECzF
 dYLa+qC+FlsOzR8R/fgbRxC7clvlHfn+HuT2sBHdbvJtdxMiu8pESG0/iTR7sUuGVAPM
 Y/PAPrVmzPFHP7oRTNEkBWhvTd60PhpctILX6TpKut19ZHPx9xTAOswMo9ujhH7SrUL2 pQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1v9cv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 11:03:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417AblIx039488;
	Wed, 7 Feb 2024 11:03:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx8jv4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 11:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNbXJzV2d+ZmSCVeMJ66inS4Tj6FrwIYvnpuyPaH7Y0gi1+u24eiR2Am9cXF+ptcpPb4C2ARy/nsQRseHo3V4lIygDy6ODRADyJtw6bLEB0R8Isbh0q10ZfVF4VuMNBrXAHee5fB9yCrK2tm7KnvkNQ7zM7jwyAuiPjhpaDD51dXNbSWqmHQWESegdTLf6q0wcz+y/T01a18jrOSvkMFMwOEjgE7spvB4ouXMwdaTQq3KPIqEWdMK5EtNfiR1+etAMISXQTW4XhoupX2yskEu5DlmgC1qdtd01YIhcXILFsm6OM14XnTkklL/B9RzQN50GKTqv98Ct1JWqj38glB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJf7iwN9E5UPCKgiA2ZnjWBHmzoYGvKwrVB0/tUerbc=;
 b=GxmkupXvgNB+eW1LifQnsDcp3kdKXI5O33j5eES99/RGfnCx7g1dsP6nDUVMGYjtfZ7SE28nY/eZafuBFue348+iAjZBCKaF6thbBJy/cQooNWfbfLTXmN5la8K+nOoLMRBRKc3ni7VqCHEsopD4Cj5aHp9ht/DxXKvb1X1PZ2leFIFysDbXaKhnTItnxgQlvdZJO172GfR0tWXPUf/PrXPVdPtY8VO9NKWSz5I2MBMOs8uivDtdXd/Er1o6J/C5GbLF9nxX0Tthtkf+9S28eFIhiivt0c/Inq+opc9M1HsyaWKL8d5V1A3+m7FAbuyGLGtqEJHhxJkCCZHhw3XHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJf7iwN9E5UPCKgiA2ZnjWBHmzoYGvKwrVB0/tUerbc=;
 b=AgSHyiDnngsJENRyJbTIpHwaPQWuRFYey5serRFw+/bUmmCwO7r2v6c4/Ls2WZ2/lKiqufKEMm/HAAAuxjcnk3UO9/iYl/NTpTaAAxjoqYRTJcjyfi/Hj61TV3wEbi0e0XGY/JsSHk9o7vcozuVKNKFlzAnzBD0es/5zXUI49qI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB7385.namprd10.prod.outlook.com (2603:10b6:208:42f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 11:03:18 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 11:03:18 +0000
Message-ID: <15bd5441-9e34-426b-9715-df43beedf1c8@oracle.com>
Date: Wed, 7 Feb 2024 11:03:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Encoding BTF information from DWARF causes "has void type" error.
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>
Cc: dwarves@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240206120226.6r7n4vQ3@linutronix.de> <ZcI3TVlOYuQfCWv2@x1>
 <ZcJA-mrVh5qmkxfV@x1> <e009cb74-feba-47c9-9d5d-b99517261017@oracle.com>
In-Reply-To: <e009cb74-feba-47c9-9d5d-b99517261017@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: b4558fb7-8f29-4d72-075e-08dc27cc63e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UgwBAGNTVCzMOVKJ8jaDzq0Lx4PQrPDTdyyfAWrfMCIlUfd/LCcZTapDZlsPfUD8DhoigzLydIGCa29+HBXQSZFXH5XCGj7xXVystN94WHs2lNcCfjURUniFv1OXJQ3013cjylKqlfpD1DhfpIEEObmBOdGcSs30qVwMqb03vGVhC4dWgXvCU1cmAtN2/cm5GOcLTzxvTEGzCqwGhK9jaGGJ7GWXFnJZZD2NM7dSbqlmEW8mbqtb+jc9H6Wc7XBIsCJtijibjIq4+/j/r9ooOKWBD5fhqVch3Y9wuo3gE8XJFkp0TUXWnAoUMtNA+cn3V+tMl+JS+KEf3sK7w+u7OQlNLvaB33Enpxg/1zBpdT2OLOYDpVtg7zds93AQFjZOEnfyICuUOKnhYCjnjBp+ZAJmXHmW7c4lEGYx21X1vUtIJY42M577sOnjrFdOlRBGyV3xDaBBy9DCNLGHoSD0SXJVBmkLFhD+a17cKkld7Nmj7kMptkqdExEhBB69auBs5TITLrHqYOXQVMfQ7UuW69jEkgs7ZTWRTHdXfALpmPESilY3JIIC/dNvednXEdCAa96Ky6pNRV8PkErgajHzaN3k2M0L2uei61vqVW3QKfI+RetBRi1DlejTYDrEfyMqjePNndjpG4M8/XXow2TjhA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(31686004)(38100700002)(6486002)(2616005)(86362001)(31696002)(6506007)(44832011)(6666004)(478600001)(6512007)(53546011)(110136005)(316002)(41300700001)(66556008)(66946007)(66476007)(2906002)(8676002)(4326008)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmVTSGNpTlAwNWFHQ0VZTVh1U2JCUW82UlgvRkpaUUxKeVBIWGJsQzFVQU1w?=
 =?utf-8?B?MUM0N1FjaTFCTDZrbHl4RVE0T2Zyb0hPUStzSlN2NVY5RUJSMlRJNjNUMUJU?=
 =?utf-8?B?ZHpkQitnSkFMRnZrd09mQ1RLQzRXUWxxcVhjR3ljTXNjbUxvNGNmYXJhNWE2?=
 =?utf-8?B?Rm9mMStGc2RqUmdYQWRSbjc5L28yVzNiejBiR1FkTWtDNGpYamVtUmo1anJP?=
 =?utf-8?B?VFNMV3VZdDNaMHpQM0RzRVlibStGRHBkR3ExMy9teU9JaDM4Si84cFRydDkr?=
 =?utf-8?B?OHlNd0tsYmVHRklhZUh1UkpWTk04Z0lQbEI5bHRYNEJkcUlDbiswblNVS1gv?=
 =?utf-8?B?Q1FrZDY4cDdIazExNFlKcThmVjZPc3hHTDJMN25KV0ZzcEFkTHNwQkJ1dXUr?=
 =?utf-8?B?LzI1d1cvcU9BcG9ENGwyTXBWaU1ic1R3TERMNUYyMTJBRDltd21RUUxWaFlI?=
 =?utf-8?B?YStwaXBCcGMvM0JMakNZc3dxU1IvZGxBMGYzc1NjVU8zNWI4ekRlZUxsY0Fu?=
 =?utf-8?B?UWR1d2hucDkzYTh5MVd2NSsxZkxYRFZYa1JPSWphb1RNQ2xCV0o3ZW84Mzcr?=
 =?utf-8?B?Ym1KSkdZTm9Na08zSm5Gazh2MzdUaDYvT0xUTUxkeXFYWXE4a1FXR29VQnRl?=
 =?utf-8?B?aFIxaFVNaW1tSDNud2NwT25ZZGY2SThCc2hXY2FNMFUvMTcvd2RhRkhtM2NK?=
 =?utf-8?B?RlNuL2h5S2F2QnhvVDhEZFVsTjE4b1lnZTErR1hpTkQ2UHlaZzFiTS9QOEpW?=
 =?utf-8?B?OUFZUEpPVjVsSDVTeEIzOTJKK0tKeUg1QkhraE9UM1ZhOTJPSXlZTktmaWhn?=
 =?utf-8?B?U2s5QkJ5ZTN6YitlbWlIYWJZam1aL3NobDB2N3RCcUtmRVNENFFsS1FrSGtw?=
 =?utf-8?B?ZkFZVXRnVThhdGNRaUlFRWZoUXRyUmVUNGorNTNzcE1Ja2o0MnFFcldBdUxW?=
 =?utf-8?B?aHZrbWRLUzAzWlUvYmk3U2NZUkZUSmxwNXU2MDdJR3pGUHZvUmYrQndPRUYy?=
 =?utf-8?B?cEMrayt0dnJGRkJ5MStsZkxXU2RDUG1taFlUYS9RK0kvOG9ERkduM2VwR0o5?=
 =?utf-8?B?c0krejdIVkw2bFEzR0VjWE42R2tJVmpJcjJ3aStlN2hDUVlaaXlRMmdmQ3hN?=
 =?utf-8?B?ckJtNnlJQXFjNTVOOEZTSHppYmMvLzVnV05XQlZibEdKOExETnRWVzRxR0NE?=
 =?utf-8?B?SGljc1hRYzd2NDdyK3duaDBnZnVLeEVYdnI3dzcyUHYxNEg2L1I0Z1d4dk1H?=
 =?utf-8?B?NDdMK0NYT1NEYlY4ZWU2QXFHL0NsZkF0U2JYVXBsKzlrcWttd1F5ajNKYm1v?=
 =?utf-8?B?TmJYODlSaUdWY3Avd2Fnb3NXVCs4L1l4WUo2MzlyMjhCQS9paVhlTkJPbVQx?=
 =?utf-8?B?cWUzSGVSbzNDR0VBV21OSWl1SndyT1VaZTRROHdpc0F3OFVQV3BiYTBtNkZ0?=
 =?utf-8?B?S2VRUDVnK3BTRG9vRHJjbDZ6WlkxeDlXaFRwV2U3b2FzMWZxOEZVSTRtUW5q?=
 =?utf-8?B?Tm9PYzByQTU5alVobXlqejFjMVFPU0szMGhqanYyRjhkcGRLWStaaGNoYWdz?=
 =?utf-8?B?a08vaXVYRHYxVzkxdUk1VU1KcWlnZ0FaRjUrbVpoU1dJZGg0eHp4RWFLTU9L?=
 =?utf-8?B?MHVsVDEwbXJlTFpOTE1hcmx2SjlsNmwveXF3NkExM2VESzZXWWQvQTNjRjBt?=
 =?utf-8?B?c0ZkWldxb1NWaTR3SDZYTGRYYVk1bU5UcmloMFJRNDJTaG5NeGdseCtlVTBa?=
 =?utf-8?B?RmV0TXZZMU5UT2wyL2syN0ptQUNTdkF3TG9PZFVZdlM3OEpseXZPUnQzRUli?=
 =?utf-8?B?bFF2NEptdkFBcGlxWmRUZ0VOdFp4REhJQkM3LzNseDFhUDM0cE1GYlNkMSs1?=
 =?utf-8?B?QkdMMlJGWENvWDk0L3ZFMk03S09uWVZNSEJyNG1QcFVQTVJpOVQyZGZXTFQy?=
 =?utf-8?B?MjJQdTNHSEl4MjJ4UWxPZVd2b3RRejRNL3hndm83UVpEYkJ3UVZPU3dzaVE5?=
 =?utf-8?B?M1dTZ0xoQXVoMXZXRXVXL2VxM3RKaXJUdnp6djUxVlJEVnFiNlg5NjRDWWpQ?=
 =?utf-8?B?SWhBWFZCQ3VHdDgxSXNZbnJTVnRxSklEWTEzYmFlVmVXNVJDUDUxdlE3WS9u?=
 =?utf-8?B?c2JjbEY5cEFaWW54VmZmTzMxYzNBVUlyK2wwcE41Vkl5alpibmg1ZytjMVhm?=
 =?utf-8?Q?NIomoKue+5Pa37V2Wmn8D2s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	udnzZNz02uvpHzBXFGFMS5tAcfcq9d7DJ7w7hpyZyPIzyOb86lMkBNhX8pfIaltb83EIV4IioBWSZmWpUNNY/x657zILHuyCxM2p8mLmAB90NLur8G7tKXuasfxxjKYpFpy01MqHwkCnuePujBhhqBVmn7gQkAjIkwMnSWy8lw1gurDvqFadcZ7hPpzzy0H7orqtPQ97cSiGzNkPkOpneXPud+nTlWSBO3wYivsPBfC4vRtFQZ57aCwgakdIRZJ0snN3l6fTCrj8NCdgNzwROlArCXcuDBLuKK39ZBUBsmWZ9/wN3oy8jepiP8+eU0QZVpxmAcYJ13KlDr6DslwMIItypLZ2wuf79/5BzT7cAXpsFgHdpK62s6ORiFao+WU8O0qWGUfTjFvQQ//7MYMklLcKfP9AfsBismVkeCmmhoGmA683rI1bbY7Mb67T6SeoLAwpKx6l1lXDVP/TcDQgoi2KPS12ktQI9+28BU9d+ZSTmDcA5TeY9Tta+B2q9d13uNub9emkyc5O6aAFCRQr3pTjulh338Nu3Q9FRhfvETJzuQfalxc1gWQxNs4ay4M70ldVkt9x7KuAahLYsKyzPTalom4riB69zlJMeST+tAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4558fb7-8f29-4d72-075e-08dc27cc63e0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 11:03:18.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylP2PjWZwWtr+D3N+DaUMP05uJyFLXEUs1ZJAC/ngnJ+vBnDACVkHFbsW1BVruE1bHP2NRRU9goMq8vHQQ/aGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402070082
X-Proofpoint-GUID: eziJyXpx3A8yYDJR0SVK_bhdwIqLCaaV
X-Proofpoint-ORIG-GUID: eziJyXpx3A8yYDJR0SVK_bhdwIqLCaaV

On 07/02/2024 10:01, Alan Maguire wrote:
> The problem is the conditional check above; I can't see why it needs to
> be guarded here. We never want to do an address-based lookup for a
> variable and not have it be the same variable name as we have from DWARF
> - which is the one we're trying to encode, right? The following fixes
> the issue for me, can you try this out if you get a chance? I might be
> missing something about that check so other folks please do weigh in if
> something looks broken. Thanks!
> 

apologies, but my suggested fix is wrong I believe.  When tested with
vmlinux BTF generation, around 100 per-cpu variables disappeared.
I believe the fix should instead be (deliberately leaving in
verbose output to help debug future issues):

diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..ec081ce 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1527,6 +1527,10 @@ static int
btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
                if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
                        continue;

+               if (encoder->verbose)
+                       printf("processing var '%s' at addr 0x%lx\n",
+                              variable__name(var), var->ip.addr);
+
                /* addr has to be recorded before we follow spec */
                addr = var->ip.addr;
                dwarf_name = variable__name(var);
@@ -1559,7 +1563,7 @@ static int btf_encoder__encode_cu_variables(struct
btf_encoder *encoder)
                 *  modules per-CPU data section has non-zero offset so all
                 *  per-CPU symbols have non-zero values.
                 */
-               if (var->ip.addr == 0) {
+               if (addr == 0) {
                        if (!dwarf_name || strcmp(dwarf_name, name))
                                continue;
                }

This works for both vmlinux generation and the problem you ran into.

The explanation is that prior to this, we get an adjusted value for
"addr" to do per-cpu variable lookup, where we subtract the per-cpu base
address. We should also use that adjusted address to check for a zero
address in the test to see if we need to use names to resolve per-cpu
variable identity. The problem was the __UNIQUE_ID variable had a
non-zero var->ip.addr value but its value relative to the per-cpu base
was 0. With the adjusted value, we do the name matching and skip the
encoding as intended I believe.

Alan
