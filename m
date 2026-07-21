Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91693BB9E0;
	Tue, 21 Jul 2026 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629508; cv=fail; b=TFn5VUmHFubigPQt74YnPIthryDvAvd4I2QL4n8I39fswk9ZmriK+epordBWHqZ2xFgULKDtJJcyqW/nj1jhQfWSKUFQoJ69M5ZbjV1J/Dh0e48WX7oHEPvUhi3i/wD1RuE7nQDjFCwg9lnr5nI7F+H47/nZYNIhgTEOaC32lAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629508; c=relaxed/simple;
	bh=9JIgWi0/2dHk/iDSbXR2mHRa8ou8w6l75msZMFUweYw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BylgiUDUqarhePwXgcrKdv+DaxC9NXya8pYtubEbFzGwHDcbrzs5l7N+cLfny33MXU/QiW0i8hhiZS5QjGnG1secC84jNc1gzFlTaastgBdNnqGk16scW8xs/ha4yK8+7rSsRQpu/aiwQPjvtU+IVdCSTk/IOE68lYHJ3TW0Dos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AvVZkglK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ruEUrbKZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AvVZkglK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ruEUrbKZ"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L0g0B13101436;
	Tue, 21 Jul 2026 10:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DCL1/hYxuB04+7CZ01pe6CM8DdcO9OxtCEYzCumvKb4=; b=
	AvVZkglK1YfQkOTf2ywoM7uzwkMq3tDUyOZ1z+5/WqyFgqtZFu5dFW/bhEHcgfkd
	4sIC8kng1vgVxj5sSelRigUnLr26rnnJ6AMQAyaqenMGYcbsk0sFQAyQO2L0U1+O
	CNZZbH8p3YrJJ41OvUd9R/HABX4VbG0K5fX5y+9StoqmNU24YHYfNWhIziVFLGao
	Wz1otAuYiev4bVt/8Va3xhxfUOTBLlNdqDdlaTmfyCHCcAn0/WT3Te3POTQUiahy
	UAJR/shaURqOzOs0FM+XUUrlfcOOhQMf3SYSRvIwojOKb3RaGrgkFZs3+Cdhj4rH
	6QiW3Tb72i28QDy2iwPaHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1mv37gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 10:25:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66LANUKD010653;
	Tue, 21 Jul 2026 10:25:02 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxpjq78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 10:25:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAocpxIHKLhdjcapFSqLg+4bQ8in5UB27w8de8tuxoZxnGpRG8pfZb7QZoVraElZKdO5YflTAjJmU8p1Ih3zqXr+Ktqxh/+OpyKV/LDDJNw+CEdyMSVMUigc97+CTV4763VfBEf1VhDtTLvtrcVsA2hJwNLiSqRUkEvfl/z9/wqPYiGFPTJt9/CZKWQnZ/E40QOBQJ7PcBvCxTcdV19yPQaAU+Rq0z144HQKuAStTjeH0es86s3+5Oo0n7P264xREIDdzjvYKfAu4AUUTNJlvvt9JXsyvfkM4fid/sbZzIFRQWA4O0q+ncWcohEjNHSyG0J8HWlm3Co4S0z8jlXVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCL1/hYxuB04+7CZ01pe6CM8DdcO9OxtCEYzCumvKb4=;
 b=hYIaebx6AApqfPUh9KSnQQ25wbSHxVZ2ESJvyzoFjqK/wTL6/WtRpgjm69FfzRUUILD9ZssIZoYsaEErxmxO/tZm8qIn+84/3/T75APphMBg3059ero+zry7N0bUbWWxo+r1il6Vw15hOO4auLytRi4oXNaRlm0w97qf89LmcNkN1e3/nkgXTfzanjKnRqt9JCYWQKTNa3eWFAspCJGHkTg6wjooW71nkGWFMr2eCwQ2X9NtcWRMmisZrU4BXWM4YfuqRcy9IzNLocOeUTKbJu7EZWMH4AcLOmFJ+xvf7at8bhBqd8ntHu7N8F8Az7RH/LVQHxfvpyrqGv466RpF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCL1/hYxuB04+7CZ01pe6CM8DdcO9OxtCEYzCumvKb4=;
 b=ruEUrbKZcziXmEDpEM6+X1cPsz5yQmWwvoKMV/VKZa26uejjrE+JGyrJ3a/suon3PVBy8JIbQZ2UBro3dFi69J+CnyKpCVpWbvdvhWpeSyXmBwlHLsZelrx2uNA2n7U+sU3KgLbP8vxKu32NPJx1MWtxkNbshd8XeEKLacAYqqA=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SAWPR10MB997789.namprd10.prod.outlook.com (2603:10b6:806:4e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:24:58 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 10:24:58 +0000
Message-ID: <d69247cc-3c90-490d-8479-ce07fba58fd9@oracle.com>
Date: Tue, 21 Jul 2026 11:24:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 0/2] clang true signature follow-on
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, olsajiri@gmail.com
Cc: arnaldo.melo@gmail.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
References: <20260714135035.814273-1-alan.maguire@oracle.com>
Content-Language: en-GB
In-Reply-To: <20260714135035.814273-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SAWPR10MB997789:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc5fc95-183d-4eed-8794-08dee71250da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YItQEwrAg0/QKMq6CaveDG0uaQ0eWo6mOOrupMMLlm1a0iOXuRYHE5icDRk7XwZ538gOylX4+HpLWNvB6Hi+uqiEJ+dyD3LARh+4/f0CfDpP24q5U9CpQfonodkrMTQYGH4CNyuNX8mTQkFW6Dai9pmrKVG9PwhGsuPyrDNxlQwfpVSdcsonr98ZFHtxtmq+oh46dsGioDXYgwHbAoqm3mFlMYMf9DWA5UoXHkX1bPRhgjR80G+ODXr2jUEUl8DJg6T9ctXIywVNTw2WyjwEpS4yhiNeL0mTE2ogbD/NVBM5HKchHMWV/+nHfOUNO4NkMmamTjOy7NwgJS33md/enp+47jS5UQ2ERNFj6va94jm10twIrw50wy6LEBEZT52ONSRleTNgt4LHYO/cFmvROb7CKo1CBSMZa1gmAw4RQfpqFpdUCwgZ3BrVsPF8W96bhXgE97cSy7nOSLBhxPol/u870XsrfziwszZmRTe34IF892ZUu3/8yb749BxW17eKcTgugwRU0xEgBmlU+fSd3sale9HNMn3oLZqnSdQ7CleDe3Y5z9fv4HplD0MKzTfFYU0ZHYOzFNyDJYgFuUC5kNC7T8F568uGwNYorBfscnJo0efs0kVDhixqzHHLHtetK3cgB14kGHBemUYjUC1ZN6/b70tD30N++pNSaB6m98A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHo0VXVBZ0dXd1hjS1M4c3dvUXo5aG1hS0xJS0N1cjJ3R1JxbVpKZVl0SVZv?=
 =?utf-8?B?R01DaDNhajV0S0NmRzdjbmdSckZGZ0ZtQTJCK2VENm1rSy94dWtKRVZKdXh2?=
 =?utf-8?B?bElXci8yRFBYMTY3c3k2SUJCK1VEcllaSWhSNzJ4MVZjRUw4S2htYncrK2x3?=
 =?utf-8?B?N2dkdXNzdVprWmdscDYwRkp6ajhDaVczU3B2U2NWK095L0Y5NWxLSFAyS0FD?=
 =?utf-8?B?cDIvQVErV21pdGNUWlI1RXpqOXM0MWtuOVBhaldOVWNsQzRMTktqck5FWUpt?=
 =?utf-8?B?K0FrMEdrdWxrSzY3ZnN1SHpUbFFheEpnbjJZd1hhbExkc296blI1dm96bE5w?=
 =?utf-8?B?dTE3SG9SQmx3OE9EVlpFTXpBYmlNTnhaR1g5SExFVnlDSE9Nd2p3TmxBYmJ3?=
 =?utf-8?B?S3NzZmdNZG5IZDlTOFF3bnhLVDJ5WDcxMFJOQ3l5R3UxNTRWTFo2OGp5aG5q?=
 =?utf-8?B?NUNKUHRFZ2pJVTk5RitSM0IxZUJsT3d6YmZUTFVTSWVvdk9ncDBLcHhnd3Vx?=
 =?utf-8?B?UG5QOVdsNWVYajZvcDNaMWJwVXpNa2w0OGF6NEROUm5PZDNualptMGx5amxt?=
 =?utf-8?B?UWFXNU1uUlBtN0Y0TDd2MEFhYWZ2ejM1UmNhTUZIWFlsTTAvTmhzRUQwQ3R3?=
 =?utf-8?B?eUJGTWNzVnBuZlR3R0l0OTlCV3VDU2ZaMzlCN2xpSVo2aU1LUmV5RVYwSnpI?=
 =?utf-8?B?cVoraUZpcWZwWEZDU0ZSZDl4VEJJNXF0dkZxYTc3WkNzMkhlOEdva2hTR2Uv?=
 =?utf-8?B?S2d0SWxETHYrSnlYNEUvMDNPZUNQMldOVmVWb1ZzcVFnVVQ3OFdOUWtZWGNp?=
 =?utf-8?B?RUN0c1RYa2NRd3JBUnN2YUlQZUtIcmVGdkJ0bXNpZVd5WGozM3JVVFpXMnkz?=
 =?utf-8?B?UFRxMFM5TW1kTUNiWURxWlpNd0t1eWNZVFM0T2ErVndocGZiQzcvSVA5ajV4?=
 =?utf-8?B?RGJJbUdUM2xmZkFPMmtuTExoeVgzNVZrTUxVRDduOGFvQW1yaGM2MjFLdktJ?=
 =?utf-8?B?UEFzaXZENFU1ZldqQ0Fna05aT0RiaXNTVlRhNVMyaTFqcnJYcGk3K0JGdVhh?=
 =?utf-8?B?VDU4Rk1BQ2JXeU5JNXZYdlFCY2hyU0tmZTlBZHN0dlJaMWIvUGZmTHlueDRj?=
 =?utf-8?B?VkY0UXJNK2pvZUNJcXRMYUhvOFVFK0JZQlE3UjhFRUx2d2xJYUJqL09PeGE3?=
 =?utf-8?B?eG9EakhmeU1XUGU4NTJydis1NWk2RDBMUXFwWWl4cDV6UEdoQTNYL2RvYTd0?=
 =?utf-8?B?Mk85ZzZYZ3I4R1NiNWJCaFVweUc3c2ZLcnpQdkNnV0JwWjVzQXNzQWlrK3JO?=
 =?utf-8?B?ZG9wZzlHL3dYRE9nR2hXYkdzR1BJYmo2WnVzS202OG9QUkNoTHRBZUd4Vzgy?=
 =?utf-8?B?elJIOWc4aW5pdjJhWk0ycXZkbDVUcVBqWEJEdlpvK1ZIeDBGMXUwdU1uSG1u?=
 =?utf-8?B?SjRrU2ZRekxTNG1UaWtaR1BOWFNNTWRWZ25QRU83SlJhV0hieGR3M0N4OTRy?=
 =?utf-8?B?Q0xxS3Jqd21sU3RsTHRReElrWGcrNGRKa25ZQ2xIdlRkaDBzaVh2L29tcHZn?=
 =?utf-8?B?ZkVCVWgrdk03QlZEeUIrVXkwOTU1eGgzTWRsQlZPY1YwV1ZuTWZXMVpDUjhW?=
 =?utf-8?B?a05BTzdaSGYxd3hzM1dGTFBVdzI2MFJtZUJCUXlmNlF3cmVtZ1hZY2ZLTTZ1?=
 =?utf-8?B?YnBPYXBKQ0xranQxem50d1lUZnhpc2N6RW5XTmtocWQ3L0FnVkUwYkNjN0NI?=
 =?utf-8?B?Y3BMNi9ETkZncUp6K1NWMmpiL0Q3Qnhpc3J6dlhKN0lnTEg3SENzSGw2bjd6?=
 =?utf-8?B?NHBxVEplWWoyV2pQZnpNNFNhYkFKYlpSWTlVank3cEVkZGVDblYwYnJzUVA4?=
 =?utf-8?B?K1Z2RnpDcUd0c1pIQnB4Nkw4YSthMlBveWpndTJBdTJiQ3NNMi9Eb1RnVVhM?=
 =?utf-8?B?VDhHbnVDcGtBb2x6VjZCdExOYUgvUDZCNTRzVFhvbEhvVjBWZ21NS1RMZnpz?=
 =?utf-8?B?eWxrdUlzYzUwaXBzWU5WL0I2eDRQN1R2blZ2aVJ1ZzNCOGdnV3k4aDBmVFF3?=
 =?utf-8?B?RXFvdUs0bFpLM2hUaWUxcmw4WHZBNlhJdUlQVlRtWE5EMTVqbEdSVE5tTUF0?=
 =?utf-8?B?WjArOWlPbUF4QmpXcWlYZUdyejZxSko0T25KWUo1V1gvZzNKWWM0WVAzcHFD?=
 =?utf-8?B?MFFxMmhoUnBzTExxZzFUMzRzNDdBL2VLUmFIRjVSRWNKSXphRGlOTEVSR2Fr?=
 =?utf-8?B?d2ZVeXZoTzZJOHFCYUMzaHMzakQxOHJ5SWd5WXNRZTZOLzNCSHNyWUxWd2hh?=
 =?utf-8?B?SDA3bTJXbVo1L2FBaUtKTEo3R3lubE94VUpHVWZZT21lUUNOa2FiUT09?=
X-Exchange-RoutingPolicyChecked:
	Y1bEe5C9d6bnGs6b+qbco6FOGTHlq/miLwA2e5igk4kYPcAefV41VqzZBfzuYTdsfbCv3ZCVnk++gbeFsJJBbUJqHKdoKdjEH8n3PeIJl2ruQMdw0PQYEwCTSv3sjumccbEqrssvtR+3UJKu9LKY6zmLFxNMdNBsdLU6WeicMO3HAot0ghcyy6MXmCe1FWyATZINGtzDC8jFh4eNywICosuQ2122yCaf2zRzB6DXJQMZP1BwdGC5i4WpTXRRtba8azwzyo/H/jmU9nCongnfar5hUKIda+/SvbUBn0X1dAXRF5pQJVDkDp7mVjE2PKX9sblBRi2ypzBpUiRACdhGWg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u09FHdyHb3fn1zqV6VV6r6qoBjQFdheSzE6kp9eBWIYUTryxPaRlClmpc97LwQf/UuRhUmUGNhk/+aF5HXulauFrxlta8mWoZ1/QQcuTphry+ebQ14MUjDwIZRZgdtwzumISuJOWzG9LD+CuezsH5m7t94zPNabERX5BTUi4iRn8IlfbZRCkE1Ax1KSUwmMCRG9+41KTL8DNKG/bp+PAwEDzRo+0GZ9jfe3B+oCWYFdfyHgI/J6CqpO3cd3/6r5P3aD5at4+uP57fbXfj+xrJIlS00R/0Lqhw1s03XVx2iHRKpUX+Z0kYx4dFBcl4/WCELDQIINLMtxeiuMINqQ25YJdXfZ7R/1yKzwDcFZ0AladYbGkqRaXxui41qqC04SD647+pp/2qhEVHYNupyOp5YY/obXjA2MhB7b0hcJBOpb4CTWioS6HSQtTQcfBrj/JatZDnraA0vCJydLKic3UdnmT8oUblf9KONwv5njn/f6VjjxB9Vgd5LeV9YtgQLk8eNmEdkzPkMBJKZGMCP6Ik1zsmTOyFT5IZW535O9Q2hM0pSZY2Kz/UqjHMm0fCAIZ9O/PiIWdKRGoUGO8vQdi2n4Hl5dDOPhWQ7qvePjITVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc5fc95-183d-4eed-8794-08dee71250da
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:24:58.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUO0u8rfMoOSCciKER+6T2I4DWrROPiYTDjJyQK4BEPyChHSwaTfzmYtGx0xLZss0oxTaREfX17Z6Qhuo9cQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR10MB997789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607210110
X-Proofpoint-GUID: 5HcFwhjYVYve0N132SYqSEFmsq8-CUF1
X-Proofpoint-ORIG-GUID: 5HcFwhjYVYve0N132SYqSEFmsq8-CUF1
X-Authority-Analysis: v=2.4 cv=IsYutr/g c=1 sm=1 tr=0 ts=6a5f48ff b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=EHR8qhrlT3MozxiZAfwA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12218
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMCBTYWx0ZWRfX7mZVysaMyoL3
 lke82mzdQoQ1Up+R8WWwVD6CP7/rbc0OuunzsknB7mHJ9LQuQt4K1AYVjMwsEuhcgWXUMF+SkMI
 ftYL//hcR/ITzTWRvNEToNGNV4JqANg4swGS0p//FkWbMrZ/CQu4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMCBTYWx0ZWRfXz3KPlQEKN4pj
 9gt+4f+jxE3PfkoUenUyrGVEac1LLr9GPBi36UcJDpZa5OgwZo8e8GNB2E2il5stGrTIrhvsunM
 q7+nk39S6jZ8GSIVh1ETnhoDlI4nX8bdIFsaCbqr1pLsRYsNoGWha62JQ3Uq7nEaujRWhrkzZKk
 JQ31pv1g8AAOuCurZqXdtClCvSKMeq0BatjN2WyMBwunAfGz6TSh1SOuipILZXVaXR2W3BlAL4A
 mfUzGywicB80XVUBwwWBOnBCUJYmdF+PJvmM6H7TKLtJ7cAFPx7qVxA8mvFZG7/uW5AhV1EZMn1
 csHzW63sSdJD641ovT2ihJMbLHVsGf/Xb2iWwJPts0mVzR1Byaiw+jRuXWcXLvsjMJF30OMGAKz
 OdXV+X1fSZZqzLTIEBmrGVgbYrheb+N9Bg0u5GAKWsZ/BfB6x7UqAUHnBfaK9Z2waGsUZmdIVH4
 lkhtfC8smJFRuvzw3pFD/Ny3ltj3PoX+DrpVR2Ms=

On 14/07/2026 14:50, Alan Maguire wrote:
> Though the true signature series [1] has not landed yet, this
> is intended as a follow-on series to resolve an issue it raises;
> by sharing the optimization detection code it can result in
> the non true signature case being overly aggressive in omitting
> functions from BTF that have optimized parameters.
> 
> See patch 1 for the details; patch 2 tests the change for gcc.
> 
> This series applies on top of [1]; the danger is we do not
> want to land the true signature series without resolving this
> issue first so hopefully folks can test with this series on top to
> see if issues are resolved.  CI passed with this series on top
> of the true signature series at [2].
> 

Last call on this before I land Yonghong's series with these
patches on top; in my own testing it looks like it resolves
issues Jiri ran into (with functions with optimized params
making it into BTF when true signature was disabled), so unless
anyone spots any additional issues I think Yonghong's series
and this one are safe to land. CI looks good with the combination.

Thanks!

Alan

> [1] https://lore.kernel.org/dwarves/20260625020148.1883082-1-yonghong.song@linux.dev/
> [2] https://github.com/alan-maguire/dwarves/actions/runs/29270441984
> 
> Alan Maguire (2):
>   btf_encoder: Only skip optimized parms when ABI changed
>   tests: Add GCC default-BTF optimized parameter coverage
> 
>  btf_encoder.c                  | 97 +++++++++++++++++++++++++---------
>  tests/gcc_optimized_default.sh | 69 ++++++++++++++++++++++++
>  2 files changed, 142 insertions(+), 24 deletions(-)
>  create mode 100755 tests/gcc_optimized_default.sh
> 
> -- 
> 2.43.5
> 
> 

