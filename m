Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41737411676;
	Mon, 15 Jun 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543995; cv=fail; b=f29yc6BpKA+ksw74rI7LK++b59I95rzOlfwYXEGKoUOT0zEjd+GDxwHEBalfmYl4i3KPGMoaQOhlPuvQcsJZ4x2LiKZmgtBw27NdoM5TxXcqK2Av9LG3ZjOxarsgNBclfLfzV3MYiWw8nNgl5wr8xue4G1Phoe+cpM9DHMh9+tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543995; c=relaxed/simple;
	bh=BYeC4/We378Byd6rp3Qh/J3vB/U3fpIrRBzosS3ke7c=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=oBT7jgn3mOGseiVgsH9dH/51dJkT6kl39U4muYTr/mhmfPdUvcbX0UkJ7yrdMk0HUtJQZEY5FGP4qN9gP5OtyQBzG4VXELX816pG1XKbUiCi8pM20l+4WoHfZdz8vY2UqQbHt/bzQxDo73TeJXiH/vhJNJfAc1iJKf91o1J/4W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=naPXaNU/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YZcSnnH8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="naPXaNU/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YZcSnnH8"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCN7tG1304897;
	Mon, 15 Jun 2026 17:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=f1Ugn02jzeIZ6cBRMf
	qDAIYhv8XvpahTpEXyqXSKjSM=; b=naPXaNU/+sworup/lWH0Z7IlSgKGxBm6LO
	0kxVwXoUzqF/98PO0spiRZD8gjDIuuWTpFKfV+hcNVShGJQGOZ7ejJSfROtiS2G8
	UbnyU4on/6arw8P5SjtpkGTRyNdNoRBcgP+BPDXraosPqj8TobPPIEATjG9GonjT
	sgVFLvj0VR4PLJAfdVuAmRDZPsW4cs1yALaDOLtEVVfPgzf2/dbsnwFg40tOIxsL
	Tsz20zFEy5aPbjKaRi8gZqA6/KD3zeI/oqSdZ5eATGLRoHdS7VanF6sEgNIpp5GY
	/JCQRZgSGp/TmCSiaIVP+cqI9GhbLexwF7sQ0PXMVqK8B+Ihur7g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es1q7jyv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 17:18:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65FHIVnX020862;
	Mon, 15 Jun 2026 17:18:41 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4erwnp5qq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 17:18:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4u9UXdj8vzBEFAr8HJx0GVxzKsaqhJbM5f79ObbN46F9j4VRRyyJcmjELP/+RwXaIjgLtGUpz6l9eLAO4BcqGzSffEWJBaD6CtQgls7MRb0IqIyX6WniEzLASVVagdwmAhiBVadk1fFBVxzhEceW1yTHOH65Q0xGuj4vAK6x3OnzNlDHcHSq42FkNLL9/tSNogS+Bxe+Zbxu9rWecg0hVkucqRPQ/MLH53Caz5n2yKjDB4Qdm5+/j2gv1onNSaPq2y3tTF19kJRtTGbaJOFkJw+ekIKEq9JF3RJzBAxk28eQpWxkfGDBRTDw4Z+S1AnlgvE5D6TrHb1mjaV6OsI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1Ugn02jzeIZ6cBRMfqDAIYhv8XvpahTpEXyqXSKjSM=;
 b=nEdHxl9GYM4xVMWhSJfto8eLCID5NAAXEYvNrtqe2egtE2L/7Ok5n63tzXv3Zk7CYeq0AUvoh6V1SJzZuZRN8W4deOa0ktjn19uCYKtoIRIEnLXNoSUByoTmv8KuaoJWL7T5StLb4oJnIK3Z/Xnmcdwv2sqGq2rzqF8YIr9k2+1MDRIk8KevjFbJ4geiRoo5pZWgzyR03lVHhraIg3Dxc4HBE5OCe81/zXU9DPphN4oLJilNvW0fJZV2eTCXj2o/syY8n9y94yrWW4QerIKZQ2M8SiRHdHrCpUXSRfTINnrIUGRLw2urq6GQL32n08Bz/ybCzaSlK4BR5NGwSgAKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1Ugn02jzeIZ6cBRMfqDAIYhv8XvpahTpEXyqXSKjSM=;
 b=YZcSnnH8oEMz5HmmPOAsRhQZGizd4ZA+8c7VG5vybw9vaAXPd4zhrXxk3lQigGvr5Xc3wLV+2BotKyk10d3qxjNDU3soGBy/ECVUbp/eBHWPMKQLs27r8baVmehoOwSYlXVbTnv0jYMSandlHwMfT+LMYSRjxOaoEQFTSH46K1A=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by IA3PR10MB8640.namprd10.prod.outlook.com (2603:10b6:208:583::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:17:53 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:17:53 +0000
Content-Type: multipart/mixed; boundary="------------3eXYCrIJEr3NzOMKmCpMZDxT"
Message-ID: <84234995-4664-4f03-81fe-38b22482a319@oracle.com>
Date: Mon, 15 Jun 2026 18:17:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v5 00/11] pahole: Encode true signatures in kernel
 BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260523165712.1225231-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260523165712.1225231-1-yonghong.song@linux.dev>
X-ClientProxiedBy: FR4P281CA0343.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::12) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|IA3PR10MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffef770-8575-400f-9d85-08decb0208c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|6049299003|1800799024|56012099006|6133799003|22082099003|18002099003|3023799007|4053099003;
X-Microsoft-Antispam-Message-Info:
	5IxLoAdi4+P6Xhicqr0iJxG/Z28kLSPP0Jd9eKdLcmFMBhvbn5TkGZwghGfyGNBJxDc64a7VqEgb3ZQkkpPXhgH7UjCl6/c18WzFI9ztJ+ViibmVO2MYWwDgLspeTPqOit0WSvkYnnqdkbHLMCLfcM5PCydttU9D1sMTbfw0CdcM8XqIZgNL9TA/M1E46n4NjjcHeK1tlzWqymui5CeCtMCS/5Hrvf1S60KiYwOrbIvUs5pNq3dOSsNjncnGsIE2Vu5Ghg7DGqTvIBYrtwyIScuQa1N7C5zIQrPvlQDX/aOGAQ3icCwaW7jZDP1LT64JmHxrHVxBuRmwkY0wMks5tsPi94agUsUHM6X1xdV5yB8d5lskhHwpl+Dc9f2L4m9dam8tR6ChoOeJIt4CC4CbEufAeBNjWojANiswq6K+xS+TKvCOxzxeWGmLl6CyCzG1yhlLX1lsL1oo6LdTZF5bU8Cl1ycBcifZAqpj6q0zN7InnTjvbOHVbD8A4Mbpd0jhyGW9OHqOAJiYsRP6D4UXnPeC1zYT8q30ubUsWoHe0XzFH0TXckYtV2sLXYPJ3Ompt31iXdUvzNH7S5lNhEsvJwxgZYdONjLJmq8otEDfeF1m4jljPK2rDo1XEHBq3GjW3XZCHu7BKPPIm8cm5qFNRKU/GLCMSaqZpm9PwjGlhornq61ipUwvJOukF/Y97mVR4rPNToGFk18+b4C7aOHRWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(6049299003)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUorSi9ESVBPNWRHM2Y1MnVsVmZCYUt3U01PM1puUEpHU21vL21KVFlMWVBu?=
 =?utf-8?B?UjBKZDFueU5QOEt1eFUvbnNidXgvWkZ5bzE3ZE4yb1dXSGtaODIrcE1nUk9z?=
 =?utf-8?B?ZjBsYXpOQTdubitJcVRTNTZiUHEvYjJIS1dHVjVzWkRMQ2l4cnVVZS8yRGI0?=
 =?utf-8?B?bUMwZlE1SHIrRGJhN2gybDVWdzZVMWI1V1pCU2xOY0RkcEpsalB0SnNXanZ4?=
 =?utf-8?B?MVFOMFE5ZDdncy9FbHM4QkVrbFJ5Qm54dzVGV2dmdHNOeHVBN2ZPTHhicDcr?=
 =?utf-8?B?Y2prNTJucE9obzR1amEwbVJDdW03cTBsamtTaHA3bDB3NTFWSE1JZmJlenF5?=
 =?utf-8?B?MkxkUG03a25lM2pWd2g1OG83eDJnYk13UWlQNERnL1BXRWR3V3FPYWxMYzdD?=
 =?utf-8?B?R2Yyemo0R3J4RVFRcllOZ3hmdnN1YU1RRHlTdEF5TE5aTzl3SXIwNzkzc0lo?=
 =?utf-8?B?enlrQTF1NHZ2M2sxeWUxc1F6a3Q2SWh3bVZHUmRxLy9iWGxlQnI2TTJWaHRY?=
 =?utf-8?B?MFJrZEs4aE40VFpram1qbllmU2ZyVytPNVM2ZnNKNnRueHJCdDgyeWExc3Q0?=
 =?utf-8?B?d1ZtMVN6OGpaVkx2SWlSdHBFTmRpc1hzNGhiWEY0RFV4UVRReklLREMxY3ZB?=
 =?utf-8?B?RG10cFF1UkRFaFJQNHJ3eTRsMW82QlVrSHN1UDNFcjc2VjI1N1JRbHNSYzVD?=
 =?utf-8?B?ODcxTDJNZFAyMFRQQUdQS1RNWEtJb1UvL0pRUTlsWGtWUHc1a0dkM0dQT0RG?=
 =?utf-8?B?c2V4VEFEb0dYWDl0cUhjZVhXUzFBeWdTand5ME9Yd1drWFZJOWxpS2wzMWFr?=
 =?utf-8?B?MmJ4QjlBR2ZhWlo4TENvWGxuRmZhdjJUN2lZeVZncTRybVk2S2RWaXRjNTJy?=
 =?utf-8?B?bHNMcVc4c21pbU1FQ3BENDVYaXVRVGh3MEs0OEp6VS9PN295RG00eDEvbm8v?=
 =?utf-8?B?YmZtb0JXWGhoclBxQ2Zyc2pPOGtlNmMrWjhqMVIzNmVpWTRNaDdIb3NLU0hC?=
 =?utf-8?B?RUREbU15bllCazRUd1JTR0ZaTStPbE5VM1hPVmN0STZzTllhZzNsRFpJWHkz?=
 =?utf-8?B?QTBlV29YSHo1NDA1VHd3VXRxWjVITmUzVUhsSkRIaTZnbnJpZmF5cG1NTVlH?=
 =?utf-8?B?RHlsckI3Q0krbXRMS3RvdEhnMGpSS1lhSTBMZE9ZZWQxbFhXUFRFcGZFdEEv?=
 =?utf-8?B?Q2tIaXozdmpDcW9ZNHZNT0ZZMlpadVVUblBLbVAremhabklsTUN5R1hWOUsr?=
 =?utf-8?B?UnBaUHU0SDF2RGxEaDA5blZxVmF0SVNlVzR0OVBmMllvdWRkQkJYRnp2M2FW?=
 =?utf-8?B?VUZHUmRtczZ0VE5KN2F1d3RoY2EwOHN3dm9hN01MQnBkem9DdURsNEM2SlFQ?=
 =?utf-8?B?L1lVZWQvZDQrUUpuNTFoanlxZzNhYzk5WDJiS09FVWdmYVRaWmQ2MXRpZEFu?=
 =?utf-8?B?RFhFWDAxZU44bGRFSFh1SGo3cUkxKzRoTXpzb0lKUW9tMmlpMlBEdU9ub1lK?=
 =?utf-8?B?WjU0M1dLOTA3cUk1RGNKamptODRVSjJSayt5SFpCQzNUVDFhZnJGWG1wK29a?=
 =?utf-8?B?bnFzZWJMNDRzZWZZWi9XUElrWXhYbzBiZ0FYY1Z2Z1ZTam92VWg0MU12d3VS?=
 =?utf-8?B?UG43N0x2cE5nNmFSVk04bjJaSk5hcHlxNEx3K0xacUhJVjMvQ3ZJTGtSSE9P?=
 =?utf-8?B?TkJkMFRPcmpZdTRnWE5LYXVUcXRRM0p4aFdKWC9IeUhPL1hReWFlVnZsNTcw?=
 =?utf-8?B?L0EzNGdSQ0xnN1UwdTQvMUxJeXNMRWFvc2dITklOcHcrM1p2VE1nN1cvWUpX?=
 =?utf-8?B?R2FadDBFbHg2WnZiNGFhSGJBa1dEcnlwYU5QWG9URzlEZTd6QWlqd1N6Yis5?=
 =?utf-8?B?WDhrUThwVGdnWEc1SWh5dVg3YjdqQUtyeWlRaGFvNDdaR2ExeHFvYXhhcUtV?=
 =?utf-8?B?N1dMWjcrMVVObkJJY2JiN05KbnYwOWJCZEJDV3JEOCtaSWIyUStrZm5ITGFV?=
 =?utf-8?B?Tm01YjNRbUM2TTE0Wm5ZYVJROWwzcmhCelNITWZuaWRQNUFMT21neEYwUTBQ?=
 =?utf-8?B?clZhajAxZmpHNVFKbnYvL1plS0hEeW1ZNnZOblFZcHZ0c2ZUTVpDRFNTWnR5?=
 =?utf-8?B?K2lEYk85MHlURmFDcmwveDN4YjczMVcrSjN2bVJiQW0zMkVUWW1mb1BRK3R4?=
 =?utf-8?B?blNubk1ZYmMzWXBZZ0FCVnFMRkN6L0lIczBUb0Yrc3VEblpmd0RrYklxYmNs?=
 =?utf-8?B?dW9oUThiU1NiVnMwL2d4dGpzYklBUTZzcGVLNFBqNGcxb0FsSkRDMmhDVDRs?=
 =?utf-8?B?aFJkdEJaWlBUWDBaVUlsVE1abmp0ZERjVlN0QTZSQlUybk9zT0xjUT09?=
X-Exchange-RoutingPolicyChecked:
	B3HMQk3fI00x0oMQCAsY6YwvEZtKLMo00iZvO7NWUOszjJ9lybNwlxSvGvh9zivVUYeoMlJy5gRzgs00+16Vkdfe8BO/bXxc8rCIPhA6B0LqLKYtZal+9FCjbyP1QClpjGyCe3blaskMGfoCREQNyUqV2/L2dP7QUSkHZfrfX6UCP+KJIq3WPVlksQz0RJ8fyziqw+479VucJ9K3oJqowiySev6lXEwIOIEOfZKpubKNsseHzZl4kf7QdM49w5UkWgGR4DTV3myfqjnzMvEedoUmizy7o8Wt5DcR/82aUbJpVrzgONvQ8dOSXKTTA6mPRpMXE/cMN079F9c5r9BFlg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EhG0B7lKY4WHZoHIkFk0mjcCXrAVwA39NlSo+JVvSsM+Pz/iPq8xO0j96osOvg2Cgl+uUl9l1yl0aT9ASJ6XXRy0jmIPJTySYqzdD9fnaJpQJLLr/EoRLZPDmgXmjKPi9IIKkVL5Ol0stwppaENj33zjZmZHebUxGXJwWZgwNFr+jyM7ijtFdEHrynzUM7IlSVwaHoMk6T0AMZqpl8uwdYY0JaPbGAWJltuDdRmSo6bQiter4czuyEZjM6IpdMoR0nZFcWLJoPsnloTgnamF5NWWrhKDtYmVHvDlTs3JvHXdMFCx+NZsUhSrPjE5ezgoILry23SmCCRNv7/ZQ8m95AQv9SP3wVWL31wcmbPmSRbrom0I4gBCJs6NvsvTCddd8hGRozXID1uGUsx60NszRodADqfCDEPEP0dch5aj+BKyUopPVK9gHdkynwOnG1DVJ4MKyvyg/MVvd0W+3w3WV+0XpPiDxQ39rtiwg0ejtKdwT8hYFn1QaxVZ11yzG0DFHbVrDtDx0Ubj9BMHcpntZabnC8ECUXJA8wtv/PyO1N2bJ3Cj26AhtDKWnkZ/qeErukQlBI8d/zxrKXwfsMxx7ZPrKoqf3uX7N1vmmidwExo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffef770-8575-400f-9d85-08decb0208c9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:17:53.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU6KljyjWzLXNGVL/rL61Fhr8ADm85MDzniBK6kda+vY2hTF5zEpAVaBQkQCNI9qVSh2BDMmzFloqfLC1yC0hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606040000 definitions=main-2606150183
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4MyBTYWx0ZWRfX1DZ1dym5h+W0
 cQT0WvuK7q0RYi8bPcUkiM7Va+pDhaIZsRUm8NlRves4MDfUI0N9tsKrvZGxMUYVjt8B6qe9uET
 EWWo0Y4dhLqacd3F3LMoUYweQYycOMmqke9kcWsS2yB6csMVFGUw
X-Authority-Analysis: v=2.4 cv=e+A2j6p/ c=1 sm=1 tr=0 ts=6a3033f2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=UH_ejEYMS-LMaO7CyHUA:9
 a=QEXdDO2ut3YA:10 a=bJihpg1eAfl2waOqD2sA:9 a=B2y7HmGcmWMA:10
 a=O8hF6Hzn-FEA:10 a=CP5YHU1okwQQHhbWYoO_:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-ORIG-GUID: lR3KI-uQdBeYWDTclxvB2KFWX7N1HhpM
X-Proofpoint-GUID: lR3KI-uQdBeYWDTclxvB2KFWX7N1HhpM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4MyBTYWx0ZWRfX6EEPzEfDIH1q
 oH+G69nnJEQsw9E53dIxorp4o6E7Xu21obI23y1inPP7hAJ9qhqKXBfYGGUCws2VwH1SZ55zxAj
 oQ6bQAonj2oWQYF2W0xgD2yNVyHFWj3/O+935ywamZhbBM5D2Z2wISGlTQcSNHRK8IxEDYBtS4v
 FC24HAUspWZN7Krs2RkevGrz/BdKSDAiq4gf4r6OGAvaP6Tr0DWee6qmVuKARCIaP5Y/KLkWq8b
 Ls1tgoVmeecg9trDbtsFtCZvsSjrOOGr0QnqCvBhMYsfU3lDyd0A+WcrCzSFjirkAUPgxpNfSN5
 MUYO+5PTRrA6xm90Ts7v+128EjHC15oSyP6BIy50Fo/cz25oF15UAuI7DAalBXNFjWR5qGt5/wL
 OgXO/MucWpdb5znqZmuViosvqAyp462wPy0Roq4mfxE/LUo2ACO8rRuPPbHCn1zEvHEVspFI8qJ
 AscMZnS4vjNRqWEeKjNrF7eJgNoNDT845geRpBYo=

--------------3eXYCrIJEr3NzOMKmCpMZDxT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/05/2026 17:57, Yonghong Song wrote:
> Current vmlinux BTF encoding is based on the source level signatures.
> But the compiler may do some optimization and changed the signature.
> If the user tried with source level signature, their initial implementation
> may have wrong results and then the user need to check what is the
> problem and work around it, e.g. through kprobe since kprobe does not
> need vmlinux BTF.
> 
> Majority of changed signatures are due to dead argument elimination.
> The following is a more complex one. The original source signature:
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   typedef sockptr_t bpfptr_t;
>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> After compiler optimization, the signature becomes:
>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
> This makes it easier for developers to understand what changed.
> 
> The new signature needs to properly follow ABI specification based on
> locations. Otherwise, that signature should be discarded. For example,
> 
>     0x0242f1f7:   DW_TAG_subprogram
>                     DW_AT_name      ("memblock_find_in_range")
>                     DW_AT_calling_convention        (DW_CC_nocall)
>                     DW_AT_type      (0x0242decc "phys_addr_t")
>                     ...
>     0x0242f22e:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>                       DW_AT_name    ("start")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f239:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>                       DW_AT_name    ("end")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f245:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>                       DW_AT_name    ("size")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f250:     DW_TAG_formal_parameter
>                       DW_AT_const_value     (4096)
>                       DW_AT_name    ("align")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
> 
> The third argument should correspond to RDX for x86_64. But the location suggests that
> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
> the parameter value is stored in RDX or not. So we have to discard this funciton in
> vmlinux BTF to avoid incorrect true signatures.
> 
> For llvm, any function having
>   DW_AT_calling_convention        (DW_CC_nocall)
> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
> and 875 kernel functions having signature changed. A series of patches are intended
> to ensure true signatures are properly represented. Eventually, only 18 functions
> cannot have true signatures due to locations.
> 
> For arm64, there are 863 kernel functions having signature changed, and
> 70 functions cannot have true signatures due to locations. I checked those
> functions and look like llvm arm64 backend more relaxed to compute parameter
> values.
> 
> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>   -pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
>   +pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes --btf_features=+true_signature
> 
> For the patch set, Patch 1 introduced usage of DW_AT_calling_convention, which
> can precisely identify which function has signature changed. This can filter
> majority of functions where their signature won't change. Patch 2 did a prescan
> of parameter registers to accommodate some cases where the optimization could
> happen but didn't. Patches 3 to 9 tried to find functions with true signature.
> Patch 10 enables to btf encoder to properly generate BTF.
> Patch 11 includes a few tests.
> 
> Changelog:
>   v4 -> v5:
>     - v4: https://lore.kernel.org/bpf/20260326013144.2901265-1-yonghong.song@linux.dev/
>     - Check info.signature_changed only under clang.
>     - Fix an uninitialized varable issue (var reg_dix) for gcc.
>   v3 -> v4:
>     - v3: https://lore.kernel.org/bpf/20260320190917.1970524-1-yonghong.song@linux.dev/
>     - Add simple prescan of parameter registers in order to get true signatures
>       for those functions where optimization could happen but compiler didn't do it.
>     - Do not create a new name (e.g. "uattr__is_kernel") with malloc at parameter_reg()
>       stage. Instead remember both "uattr" and "is_kernel" and later generate the
>       name "uattr_is_kernel" in btf encoder.
>     - Add comments to explain how to handle parameters which may take two registers.
>     - Fix some test failures on aarch64.
>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20260309153215.1917033-1-yonghong.song@linux.dev/
>     - Change tests by using newly added test_lib.sh.
>     - Simplify to get bool variable producer_clang.
>     - Try to avoid producer_clang appearance in dwarf_loader.c in order to avoid
>       clear separation between clang and gcc.
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20260305225455.1151066-1-yonghong.song@linux.dev/
>     - Added producer_clang guarding in btf_encoder. Otherwise, gcc kernel build
>       will crash pahole.
>     - Fix an early return in parameter__reg() which didn't do pthread_mutex_unlock()
>       which caused the deadlock for arm64.
>     - Add a few more places to guard with producer_clang and conf->true_signature
>       to maintain the previous behavior if not clang or conf->true_signature is false.
>

In order to be a bit more concrete about a proposed way forward, I'm thinking something
along the lines of the attached patch (which should apply on top of this whole series); 
rather than doing prescans etc, we record param info as we go as we do today, and once done
compute true signature info. This saves some complexity around prescan of params etc, so 
is a bit more  consistent with what's there today. Ideally we'd be able to enhance DWARF 
processing for both cases (you have some great improvements in that area in this series),
and unify the representation of modified signatures where feasible. Let me know what you think.

Thanks!

Alan
--------------3eXYCrIJEr3NzOMKmCpMZDxT
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-dwarf_loader-unify-true-signature-parameter-analysis.patch"
Content-Disposition: attachment;
 filename*0="0001-dwarf_loader-unify-true-signature-parameter-analysis.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzNzBlYjdjZDYxYzRlNTY5NDRjM2ZkZTUzNTNmNjM5ZTc0N2IwMzdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGFuIE1hZ3VpcmUgPGFsYW4ubWFndWlyZUBvcmFjbGUuY29t
PgpEYXRlOiBNb24sIDE1IEp1biAyMDI2IDE1OjQ0OjQxICswMTAwClN1YmplY3Q6IFtQQVRDSF0g
ZHdhcmZfbG9hZGVyOiB1bmlmeSB0cnVlLXNpZ25hdHVyZSBwYXJhbWV0ZXIgYW5hbHlzaXMKCk1v
dmUgdHJ1ZS1zaWduYXR1cmUgcGFyYW1ldGVyIGRlY2lzaW9ucyBvdXQgb2YgdGhlIGNsYW5nLW9u
bHkgcHJlc2NhbgpwYXRoIGFuZCBpbnRvIGEgcG9zdC1yZWNvZGUgZnVuY3Rpb24gYW5hbHlzaXMg
cGFzcy4KClBhcmFtZXRlciBsb2FkaW5nIG5vdyByZWNvcmRzIERXQVJGIGxvY2F0aW9uIGluZm9y
bWF0aW9uIG9uIGVhY2gKcGFyYW1ldGVyOiBvYnNlcnZlZCByZWdpc3Rlciwgc3RhY2svY29uc3Rh
bnQgbG9jYXRpb25zLCBhZ2dyZWdhdGUKcGllY2UgdXNlLCBhbmQgcG9zc2libGUgbWVtYmVyIHJl
cGxhY2VtZW50IG1ldGFkYXRhLiBBZnRlciBEV0FSRiB0eXBlCnJlY29kaW5nIGFuZCBhYnN0cmFj
dC1vcmlnaW4gcmVzb2x1dGlvbiwgYSBzaW5nbGUgcGFzcyB3YWxrcyB0aGUgZmluYWwKcGFyYW1l
dGVyIGxpc3QsIG1hdGNoZXMgaXQgYWdhaW5zdCBBQkkgcmVnaXN0ZXIgb3JkZXIsIGFuZCBtYXJr
cwpvcHRpbWl6ZWQsIHVuZXhwZWN0ZWQsIG9yIG1lbWJlci1zaHJ1bmsgcGFyYW1ldGVycy4KClRo
aXMgcmVtb3ZlcyB0aGUgZnVuY19pbmZvIHByZXNjYW4vc2tpcC1pbmRleCByZXByZXNlbnRhdGlv
biBhbmQgbWFrZXMKY2xhbmcgRFdfQ0Nfbm9jYWxsIGhhbmRsaW5nIGNvbnN1bWUgdGhlIHNhbWUg
cGFyYW1ldGVyLW9yZGVyIG1hY2hpbmVyeSBhcwp0aGUgZXhpc3RpbmcgR0NDIGFic3RyYWN0L2Nv
bmNyZXRlIHJlb3JkZXJlZC1wYXJhbWV0ZXIgcGF0aC4gVGhlIEJURgplbmNvZGVyIG5vdyBrZXlz
IG9mZiBmdHlwZS0+c2lnbmF0dXJlX2NoYW5nZWQgaW5zdGVhZCBvZiBjaGVja2luZyBmb3IKY2xh
bmcgZGlyZWN0bHkuCgpTaWduZWQtb2ZmLWJ5OiBBbGFuIE1hZ3VpcmUgPGFsYW4ubWFndWlyZUBv
cmFjbGUuY29tPgpBc3Npc3RlZC1ieTogQ29kZXggR1BULTUuNQotLS0KIGJ0Zl9lbmNvZGVyLmMg
IHwgICA0ICstCiBkd2FyZl9sb2FkZXIuYyB8IDcyMSArKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBkd2FydmVzLmggICAgICB8ICAxMCArCiAzIGZpbGVz
IGNoYW5nZWQsIDMzMiBpbnNlcnRpb25zKCspLCA0MDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvYnRmX2VuY29kZXIuYyBiL2J0Zl9lbmNvZGVyLmMKaW5kZXggMjZiZTMxZC4uYWI2NjdkMCAx
MDA2NDQKLS0tIGEvYnRmX2VuY29kZXIuYworKysgYi9idGZfZW5jb2Rlci5jCkBAIC0xMjYzLDcg
KzEyNjMsNyBAQCBzdGF0aWMgaW50MzJfdCBidGZfZW5jb2Rlcl9fc2F2ZV9mdW5jKHN0cnVjdCBi
dGZfZW5jb2RlciAqZW5jb2Rlciwgc3RydWN0IGZ1bmN0aQogCWlmICghc3RhdGUpCiAJCXJldHVy
biAtRU5PTUVNOwogCi0JaWYgKGVuY29kZXItPnRydWVfc2lnbmF0dXJlICYmIGVuY29kZXItPmN1
LT5wcm9kdWNlcl9jbGFuZykgeworCWlmIChlbmNvZGVyLT50cnVlX3NpZ25hdHVyZSAmJiBmdHlw
ZS0+c2lnbmF0dXJlX2NoYW5nZWQpIHsKIAkJZnR5cGVfX2Zvcl9lYWNoX3BhcmFtZXRlcihmdHlw
ZSwgcGFyYW0pIHsKIAkJCWlmIChwYXJhbS0+b3B0aW1pemVkKSBza2lwX2lkeCsrOwogCQl9CkBA
IC0xMzEwLDcgKzEzMTAsNyBAQCBzdGF0aWMgaW50MzJfdCBidGZfZW5jb2Rlcl9fc2F2ZV9mdW5j
KHN0cnVjdCBidGZfZW5jb2RlciAqZW5jb2Rlciwgc3RydWN0IGZ1bmN0aQogCQkJc3RhdGUtPm5y
X3Bhcm1zLS07CiAJCQljb250aW51ZTsKIAkJfQotCQlpZiAoZW5jb2Rlci0+dHJ1ZV9zaWduYXR1
cmUgJiYgZW5jb2Rlci0+Y3UtPnByb2R1Y2VyX2NsYW5nICYmIHBhcmFtLT5vcHRpbWl6ZWQpCisJ
CWlmIChlbmNvZGVyLT50cnVlX3NpZ25hdHVyZSAmJiBmdHlwZS0+c2lnbmF0dXJlX2NoYW5nZWQg
JiYgcGFyYW0tPm9wdGltaXplZCkKIAkJCWNvbnRpbnVlOwogCiAJCW5hbWUgPSBwYXJhbWV0ZXJf
X25hbWUocGFyYW0pOwpkaWZmIC0tZ2l0IGEvZHdhcmZfbG9hZGVyLmMgYi9kd2FyZl9sb2FkZXIu
YwppbmRleCA4NzBjMTY3Li5hNzkxNjkzIDEwMDY0NAotLS0gYS9kd2FyZl9sb2FkZXIuYworKysg
Yi9kd2FyZl9sb2FkZXIuYwpAQCAtMTIwMCwyMiArMTIwMCw3IEBAIHN0YXRpYyBwdHJkaWZmX3Qg
X19kd2FyZl9nZXRsb2NhdGlvbnMoRHdhcmZfQXR0cmlidXRlICphdHRyLAogCXJldHVybiByZXQ7
CiB9CiAKLSNkZWZpbmUJUEFSTV9ERUZBVUxUX0ZBSUwJLTEKLSNkZWZpbmUJUEFSTV9VTkVYUEVD
VEVECQktMgotI2RlZmluZQlQQVJNX09QVElNSVpFRF9PVVQJLTMKLSNkZWZpbmUJUEFSTV9DT05U
SU5VRQkJLTQKLSNkZWZpbmUJUEFSTV9UV09fQUREUl9MRU4JLTUKLSNkZWZpbmUJUEFSTV9UT19C
RV9JTVBST1ZFRAktNgotCi0vKiBNYXggMjAgcmVnaXN0ZXIgcGFyYW1ldGVycywgY29uc2lkZXJp
bmcgc29tZSBwYXJhbWV0ZXJzIG1heSBiZSBvcHRpbWl6ZWQgb3V0LiAgKi8KLSNkZWZpbmUJTUFY
X1BSRVNDQU5fUEFSQU1TCTIwCi0KLXN0cnVjdCBmdW5jX2luZm8gewotCWJvb2wgc2lnbmF0dXJl
X2NoYW5nZWQ7Ci0JaW50IHNraXBfaWR4OwotCWludCBucl9wYXJhbXM7Ci0JaW50IHBhcmFtX3N0
YXJ0X3JlZ3NbTUFYX1BSRVNDQU5fUEFSQU1TXTsKLX07CisjZGVmaW5lIFBBUkFNRVRFUl9VTktO
T1dOX1JFRyAtMQogCiBzdGF0aWMgaW50IF9fZ2V0X3R5cGVfYnl0ZV9zaXplKER3YXJmX0RpZSAq
ZGllLCBzdHJ1Y3QgY3UgKmN1KQogewpAQCAtMTI2OCwzMSArMTI1Myw2IEBAIHN0YXRpYyBpbnQg
Z2V0X3R5cGVfYnl0ZV9zaXplKER3YXJmX0RpZSAqZGllLCBzdHJ1Y3QgY3UgKmN1KQogCXJldHVy
biBieXRlX3NpemU7CiB9CiAKLS8qIEdldCB0aGUgZmlyc3QgRFdfT1BfWCAoc2hvdWxkIGJlIGEg
cmVnaXN0ZXIpIGZyb20gYSBwYXJhbWV0ZXIncyBEV19BVF9sb2NhdGlvbi4gKi8KLXN0YXRpYyBp
bnQgcGFyYW1ldGVyX19wZWVrX2ZpcnN0X3JlZyhEd2FyZl9EaWUgKmRpZSkKLXsKLQlEd2FyZl9B
dHRyaWJ1dGUgYXR0cjsKLQlpZiAoZHdhcmZfYXR0cihkaWUsIERXX0FUX2xvY2F0aW9uLCAmYXR0
cikgPT0gTlVMTCkKLQkJcmV0dXJuIC0xOwotCi0JRHdhcmZfQWRkciBiYXNlLCBzdGFydCwgZW5k
OwotCUR3YXJmX09wICpleHByOwotCXNpemVfdCBleHBybGVuOwotCXB0cmRpZmZfdCBvZmZzZXQg
PSAwOwotCi0JcHRocmVhZF9tdXRleF9sb2NrKCZsaWJkd19fbG9jayk7Ci0Jb2Zmc2V0ID0gX19k
d2FyZl9nZXRsb2NhdGlvbnMoJmF0dHIsIG9mZnNldCwgJmJhc2UsICZzdGFydCwgJmVuZCwgJmV4
cHIsICZleHBybGVuKTsKLQlwdGhyZWFkX211dGV4X3VubG9jaygmbGliZHdfX2xvY2spOwotCi0J
aWYgKG9mZnNldCA8PSAwIHx8IGV4cHJsZW4gPT0gMCkKLQkJcmV0dXJuIC0xOwotCi0JaWYgKGV4
cHJbMF0uYXRvbSA+PSBEV19PUF9yZWcwICYmIGV4cHJbMF0uYXRvbSA8PSBEV19PUF9yZWczMSkK
LQkJcmV0dXJuIGV4cHJbMF0uYXRvbTsKLQotCXJldHVybiAtMTsKLX0KLQogLyogVHJhdmVyc2Ug
dGhlIHBhcmFtZXRlciB0eXBlIHVudGlsIGZpbmRpbmcgdGhlIG1lbWJlciB0eXBlIHdoaWNoIGhh
cyBleHBlY3RlZAogICogc3RydWN0IHR5cGUgb2Zmc2V0LgogICovCkBAIC0xMzE5LDMyNSArMTI3
OSwyMjQgQEAgc3RhdGljIER3YXJmX0RpZSAqZ2V0X21lbWJlcl93aXRoX29mZnNldChEd2FyZl9E
aWUgKmRpZSwgaW50IG9mZnNldCwgRHdhcmZfRGllICoKIAkJaWYgKGR3YXJmX3RhZyhtZW1iZXJf
ZGllKSAhPSBEV19UQUdfbWVtYmVyKQogCQkJY29udGludWU7CiAKLQkJaW50IG9mZiA9IGF0dHJf
bnVtZXJpYyhtZW1iZXJfZGllLCBEV19BVF9kYXRhX2JpdF9vZmZzZXQpOwotCQlpZiAob2ZmID09
IG9mZnNldCAqIDgpCisJCUR3YXJmX0F0dHJpYnV0ZSBhdHRyOworCQlEd2FyZl9PZmYgYml0X29m
ZnNldDsKKworCQlpZiAoZHdhcmZfYXR0cihtZW1iZXJfZGllLCBEV19BVF9kYXRhX2JpdF9vZmZz
ZXQsICZhdHRyKSAhPSBOVUxMKQorCQkJYml0X29mZnNldCA9IF9fYXR0cl9vZmZzZXQoJmF0dHIp
OworCQllbHNlIGlmIChkd2FyZl9hdHRyKG1lbWJlcl9kaWUsIERXX0FUX2RhdGFfbWVtYmVyX2xv
Y2F0aW9uLCAmYXR0cikgIT0gTlVMTCkKKwkJCWJpdF9vZmZzZXQgPSBfX2F0dHJfb2Zmc2V0KCZh
dHRyKSAqIDg7CisJCWVsc2UKKwkJCWNvbnRpbnVlOworCisJCWlmIChiaXRfb2Zmc2V0ID09IG9m
ZnNldCAqIDgpCiAJCQlyZXR1cm4gbWVtYmVyX2RpZTsKIAl9IHdoaWxlIChkd2FyZl9zaWJsaW5n
b2YobWVtYmVyX2RpZSwgbWVtYmVyX2RpZSkgPT0gMCk7CiAKIAlyZXR1cm4gTlVMTDsKIH0KIAot
LyogRm9yIHR3byBhZGRyZXNzIGxlbmd0aCBjYXNlLCBmaXJzdF9oYWxmIGFuZCBzZWNvbmRfaGFs
ZiByZXByZXNlbnRzIHRoZSBwYXJhbWV0ZXIuCi0gKiBUaGUgZmlyc3RfaGFsZiBhbmQgc2Vjb25k
X2hhbGYgYWNjdW11bGF0ZXMgZmllbGQgaW5mb3JtYXRpb24gYWNyb3NzIHBvc3NpYmxlIG11bHRp
cGxlCi0gKiBsb2NhdGlvbiBsaXN0cy4KLSAqLwotc3RhdGljIGludCBwYXJhbWV0ZXJfX211bHRp
X2V4cHJzKER3YXJmX09wICpleHByLCBpbnQgbG9jX251bSwgc3RydWN0IGN1ICpjdSwgc2l6ZV90
IGV4cHJsZW4sCi0JCQkJICBEd2FyZl9EaWUgKmRpZSwgaW50IGV4cGVjdGVkX3JlZywgaW50IGJ5
dGVfc2l6ZSwKLQkJCQkgIHVuc2lnbmVkIGxvbmcgKmZpcnN0X2hhbGYsIHVuc2lnbmVkIGxvbmcg
KnNlY29uZF9oYWxmLCBpbnQgKnJldCkKK3N0YXRpYyBib29sIGR3YXJmX29wX19pc19yZWcodW5z
aWduZWQgaW50IGF0b20pCiB7Ci0Jc3dpdGNoIChleHByWzBdLmF0b20pIHsKLQljYXNlIERXX09Q
X2xpdDAgLi4uIERXX09QX2xpdDMxOgotCWNhc2UgRFdfT1BfY29uc3R1OgotCWNhc2UgRFdfT1Bf
Y29uc3RzOgotCQlpZiAobG9jX251bSAhPSAwKQotCQkJYnJlYWs7Ci0JCXJldHVybiBQQVJNX09Q
VElNSVpFRF9PVVQ7Ci0JfQorCXJldHVybiBhdG9tID49IERXX09QX3JlZzAgJiYgYXRvbSA8PSBE
V19PUF9yZWczMTsKK30KIAotCWlmIChieXRlX3NpemUgPD0gY3UtPmFkZHJfc2l6ZSB8fCAhY3Ut
PmFnZ191c2VfdHdvX3JlZ3MpIHsKLQkJLyogcGFyYW1ldGVyX3NpemUgPD0gY3UtPmFkZHJfc2l6
ZSAqLwotCQlzd2l0Y2ggKGV4cHJbMF0uYXRvbSkgewotCQljYXNlIERXX09QX3JlZzAgLi4uIERX
X09QX3JlZzMxOgotCQkJaWYgKGxvY19udW0gIT0gMCkKLQkJCQlicmVhazsKLQkJCSpyZXQgPSBl
eHByWzBdLmF0b207Ci0JCQlpZiAoKnJldCA9PSBleHBlY3RlZF9yZWcpCi0JCQkJcmV0dXJuICpy
ZXQ7Ci0JCQlicmVhazsKLQkJY2FzZSBEV19PUF9icmVnMCAuLi4gRFdfT1BfYnJlZzMxOgotCQkJ
aWYgKGxvY19udW0gIT0gMCkKLQkJCQlicmVhazsKLQkJCWJvb2wgaGFzX29wX3N0YWNrX3ZhbHVl
ID0gZmFsc2U7Ci0JCQlmb3IgKGludCBpID0gMTsgaSA8IGV4cHJsZW47IGkrKykgewotCQkJCWlm
IChleHByW2ldLmF0b20gPT0gRFdfT1Bfc3RhY2tfdmFsdWUpIHsKLQkJCQkJaGFzX29wX3N0YWNr
X3ZhbHVlID0gdHJ1ZTsKLQkJCQkJYnJlYWs7Ci0JCQkJfQotCQkJfQotCQkJaWYgKCFoYXNfb3Bf
c3RhY2tfdmFsdWUpCi0JCQkJYnJlYWs7Ci0JCQkvKiBUaGUgZXhpc3RlbmNlIG9mIERXX09QX3N0
YWNrX3ZhbHVlIG1lYW5zIHRoYXQKLQkJCSAqIERXX09QX2JyZWdYIHJlZ2lzdGVyIGlzIHVzZWQg
YXMgdmFsdWUuCi0JCQkgKi8KLQkJCSpyZXQgPSBleHByWzBdLmF0b20gLSBEV19PUF9icmVnMCAr
IERXX09QX3JlZzA7Ci0JCQlpZiAoKnJldCA9PSBleHBlY3RlZF9yZWcpCi0JCQkJcmV0dXJuICpy
ZXQ7Ci0JCX0KLQl9IGVsc2UgewotCQkvKiBjdS0+YWRkciA8IHBhcmFtZXRlcl9zaXplIDw9IGN1
LT5hZGRyICogMgotCQkgKiBmaXJzdF9oYWxmIGVuY29kZXMgZmllbGQgc3RhcnRzIGZvciB0aGUg
Zmlyc3QgcmVnaXN0ZXIuCi0JCSAqIHNlY29uZF9oYWxmIGVuY29kZXMgZmllbGQgc3RhcnRzIGZv
ciB0aGUgc2Vjb25kIHJlZ2lzdGVyLgotCQkgKgotCQkgKiBGb3IgZXhhbXBsZToKLQkJICogICBs
b2NsaXN0IDE6IERXX09QX3JlZzUgUkRJLCBEV19PUF9waWVjZSAweDgsIERXX09QX3JlZzQgUlNJ
LCBEV19PUF9waWVjZSAweDEKLQkJICogICBsb2NsaXN0IDI6IERXX09QX3BpZWNlIDB4OCwgRFdf
T1BfcmVnNCBSU0ksIERXX09QX3BpZWNlIDB4MQotCQkgKiAgIGxvY2xpc3QgMzogRFdfT1BfcGll
Y2UgMHg4LCBEV19PUF9yZWc0IFJTSSwgRFdfT1BfcGllY2UgMHgxKQotCQkgKgotCQkgKiBBZnRl
ciBpdGVyYXRpbmcgYWxsIHRoZSBhYm92ZSB0aHJlZSBsb2NhdGlvbiBsaXN0cyAoc2VlIFBBUk1f
Q09OVElOVUUgYmVsb3cpLAotCQkgKiBmaXJzdF9oYWxmIGVuY29kZXMgYXMgMHgxIGFuZCBzZWNv
bmRfaGFsZiBlbmNvZGVzIGFzIDB4MS4gVGhlICdyZXQnIHZhbHVlIHdpbGwKLQkJICogZW5jb2Rl
IHRoZSBmaXJzdCB1c2VkIHJlZ2lzdGVyIHdoaWNoIGlzIFJESS4gRWFjaCBiaXQgaW4gZmlyc3Rf
aGFsZi9zZWNvbmRfaGFsZgotCQkgKiByZXByZXNlbnRzIGEgbWVtYmVyIGZpZWxkLgotCQkgKgot
CQkgKiBBbm90aGVyIGV4YW1wbGU6Ci0JCSAqICAgbG9jbGlzdCAxOiBEV19PUF9yZWc1IFJESSwg
RFdfT1BfcGllY2UgMHg0Ci0JCSAqICAgbG9jbGlzdCAyOiBEV19PUF9waWVjZSAweDQsIERXX09Q
X3JlZzQgUkRJLCBEV19PUF9waWVjZSAweDQKLQkJICoKLQkJICogQWZ0ZXIgaXRlcmF0aW5nIGFs
bCB0aGUgYWJvdmUgdHdvIGxvY2F0aW9uIGxpc3RzLCBmaXJzdF9oYWxmIGVuY29kZXMgMHgxMS4K
LQkJICogQWZ0ZXIgbG9jbGlzdCAxLCBmaXJzdF9oYWxmIGVuY29kaW5nIGlzIDB4MS4gQWZ0ZXIg
bG9jbGlzdCAyLCBmaXJzdF9oYWxmIGVuY29kaW5nIGlzIDB4MTEuCi0JCSAqIHNlY29uZF9oYWxm
IGlzIDAuIFRoZSAncmV0JyB2YWx1ZSBpcyBSREkuCi0JCSAqLwotCQlpbnQgb2ZmID0gMDsKLQkJ
Zm9yIChpbnQgaSA9IDA7IGkgPCBleHBybGVuOyBpKyspIHsKLQkJCWlmIChleHByW2ldLmF0b20g
PT0gRFdfT1BfcGllY2UpIHsKLQkJCQlpbnQgbnVtID0gZXhwcltpXS5udW1iZXI7Ci0JCQkJaWYg
KGkgPT0gMCkgewotCQkJCQlvZmYgPSBudW07Ci0JCQkJCWNvbnRpbnVlOwotCQkJCX0KLQkJCQlp
ZiAob2ZmIDwgY3UtPmFkZHJfc2l6ZSkgKCpmaXJzdF9oYWxmKSB8PSAoMSA8PCBvZmYpOwotCQkJ
CWVsc2UgKCpzZWNvbmRfaGFsZikgfD0gKDEgPDwgKG9mZiAtIGN1LT5hZGRyX3NpemUpKTsKLQkJ
CQlvZmYgKz0gbnVtOwotCQkJfSBlbHNlIGlmIChleHByW2ldLmF0b20gPj0gRFdfT1BfcmVnMCAm
JiBleHByW2ldLmF0b20gPD0gRFdfT1BfcmVnMzEpIHsKLQkJCQlpZiAob2ZmIDwgY3UtPmFkZHJf
c2l6ZSkKLQkJCQkJKnJldCA9IGV4cHJbaV0uYXRvbTsKLQkJCQllbHNlIGlmICgqcmV0IDwgMCkK
LQkJCQkJKnJldCA9IGV4cHJbaV0uYXRvbTsKLQkJCX0KLQkJCS8qIEZJWE1FOiBub3QgaGFuZGxp
bmcgRFdfT1BfYnJlZ1ggeWV0IHNpbmNlIHdlIGRvIG5vdCBoYXZlCi0JCQkgKiBhIHVzZSBjYXNl
IGZvciBpdCB5ZXQgZm9yIGxpbnV4IGtlcm5lbC4KLQkJCSAqLwotCQl9CitzdGF0aWMgYm9vbCBk
d2FyZl9leHByX19oYXNfc3RhY2tfdmFsdWUoRHdhcmZfT3AgKmV4cHIsIHNpemVfdCBleHBybGVu
KQoreworCWZvciAoc2l6ZV90IGkgPSAxOyBpIDwgZXhwcmxlbjsgaSsrKSB7CisJCWlmIChleHBy
W2ldLmF0b20gPT0gRFdfT1Bfc3RhY2tfdmFsdWUpCisJCQlyZXR1cm4gdHJ1ZTsKIAl9Ci0KLQly
ZXR1cm4gUEFSTV9DT05USU5VRTsKKwlyZXR1cm4gZmFsc2U7CiB9CiAKLS8qIFRoZSBmaXJzdF9o
YWxmIGFuZCBzZWNvbmRfaGFsZiwgY29tcHV0ZWQgaW4gcGFyYW1ldGVyX19tdWx0aV9leHBycygp
LCBhcmUgaGFuZGxlZCBoZXJlLiAqLwotc3RhdGljIGludCBwYXJhbWV0ZXJfX2hhbmRsZV90d29f
YWRkcl9sZW4oaW50IGV4cGVjdGVkX3JlZywgdW5zaWduZWQgbG9uZyBmaXJzdF9oYWxmLCB1bnNp
Z25lZCBsb25nIHNlY29uZF9oYWxmLAotCQkJCQkgIGludCByZXQsIER3YXJmX0RpZSAqZGllLCBz
dHJ1Y3QgY29uZl9sb2FkICpjb25mLCBzdHJ1Y3QgY3UgKmN1LAotCQkJCQkgIHN0cnVjdCBwYXJh
bWV0ZXIgKnBhcm0sIGludCBwYXJhbV9pZHgsIGludCByZWdfaWR4LCBpbnQgYnl0ZV9zaXplLAot
CQkJCQkgIHN0cnVjdCBmdW5jX2luZm8gKmluZm8pCitzdGF0aWMgdm9pZCBwYXJhbWV0ZXJfX3Nl
dF9sb2NfcmVnKHN0cnVjdCBwYXJhbWV0ZXIgKnBhcm0sIGludCByZWcpCiB7Ci0JaWYgKCFmaXJz
dF9oYWxmICYmICFzZWNvbmRfaGFsZikKLQkJcmV0dXJuIHJldDsKLQotCWlmIChyZXQgIT0gZXhw
ZWN0ZWRfcmVnKQotCQlyZXR1cm4gcmV0OwotCi0JaWYgKCFjb25mLT50cnVlX3NpZ25hdHVyZSkK
LQkJcmV0dXJuIFBBUk1fREVGQVVMVF9GQUlMOworCWlmIChwYXJtLT5sb2NfcmVnID09IFBBUkFN
RVRFUl9VTktOT1dOX1JFRykKKwkJcGFybS0+bG9jX3JlZyA9IHJlZzsKK30KIAotCS8qIEJvdGgg
aGFsdmVzIGFyZSB1c2VkIGJhc2VkIG9uIGR3YXJmICovCi0JaWYgKGZpcnN0X2hhbGYgJiYgc2Vj
b25kX2hhbGYpCi0JCXJldHVybiBQQVJNX1RXT19BRERSX0xFTjsKK3N0YXRpYyB2b2lkIHBhcmFt
ZXRlcl9fc2V0X2ZpZWxkX2JpdCh1bnNpZ25lZCBsb25nICpmaWVsZHMsIGludCBieXRlX29mZnNl
dCkKK3sKKwlpZiAoYnl0ZV9vZmZzZXQgPj0gMCAmJiBieXRlX29mZnNldCA8IChpbnQpKHNpemVv
ZigqZmllbGRzKSAqIDgpKQorCQkqZmllbGRzIHw9IDFVTCA8PCBieXRlX29mZnNldDsKK30KIAot
CS8qIE9ubHkgb25lIGhhbGYgaXMgdXNlZC4gQ2hlY2sgaWYgdGhlIG5leHQgcGFyYW1ldGVyJ3Mg
c3RhcnRpbmcgcmVnaXN0ZXIKLQkgKiBpbmRpY2F0ZXMgdGhlIEFCSSBzdGlsbCByZXNlcnZlcyB0
aGUgZnVsbCByZWdpc3RlciBzcGFjZSBmb3IgdGhpcwotCSAqIHBhcmFtZXRlci4gSWYgc28sIHRo
ZSBjb21waWxlciBvbmx5IGVsaW1pbmF0ZWQgdGhlIGRlYWQgaGFsZiBidXQgdGhlCi0JICogcmVn
aXN0ZXIgbGF5b3V0IGlzIHByZXNlcnZlZCDigJQga2VlcCB0aGUgb3JpZ2luYWwgc291cmNlIHR5
cGUuCi0JICoKLQkgKiBVc2UgcmVnaXN0ZXJfcGFyYW1zW10gYXJyYXkgZm9yIHRoZSBleHBlY3Rl
ZCBuZXh0IHJlZ2lzdGVyIHNpbmNlCi0JICogRFdfT1BfcmVnIG51bWJlcnMgYXJlIG5vdCBuZWNl
c3NhcmlseSBzZXF1ZW50aWFsIGFjcm9zcyBhcmNoaXRlY3R1cmVzLgotCSAqLwotCWlmIChwYXJh
bV9pZHggKyAxIDwgaW5mby0+bnJfcGFyYW1zKSB7Ci0JCWludCBuZXh0X3N0YXJ0ID0gaW5mby0+
cGFyYW1fc3RhcnRfcmVnc1twYXJhbV9pZHggKyAxXTsKK3N0YXRpYyB2b2lkIHBhcmFtZXRlcl9f
cmVjb3JkX3RydWVfc2lnX21lbWJlcihzdHJ1Y3QgcGFyYW1ldGVyICpwYXJtLCBEd2FyZl9EaWUg
KmRpZSwKKwkJCQkJICAgICAgaW50IGZpZWxkX29mZnNldCwgc3RydWN0IGNvbmZfbG9hZCAqY29u
ZikKK3sKKwlEd2FyZl9EaWUgbWVtYmVyX2RpZTsKIAotCQlpZiAobmV4dF9zdGFydCA+PSAwKSB7
Ci0JCQlpbnQgbnVtX3JlZ3MgPSAoYnl0ZV9zaXplICsgY3UtPmFkZHJfc2l6ZSAtIDEpIC8gY3Ut
PmFkZHJfc2l6ZTsKLQkJCWludCBuZXh0X3JlZ19pZHggPSByZWdfaWR4ICsgbnVtX3JlZ3M7CisJ
aWYgKHBhcm0tPnRydWVfc2lnX21lbWJlcl9uYW1lKQorCQlyZXR1cm47CisJaWYgKCFwYXJtLT5u
YW1lKQorCQlyZXR1cm47CisJaWYgKCFnZXRfbWVtYmVyX3dpdGhfb2Zmc2V0KGRpZSwgZmllbGRf
b2Zmc2V0LCAmbWVtYmVyX2RpZSkpCisJCXJldHVybjsKIAotCQkJaWYgKG5leHRfcmVnX2lkeCA8
IGN1LT5ucl9yZWdpc3Rlcl9wYXJhbXMgJiYKLQkJCSAgICBuZXh0X3N0YXJ0ID09IGN1LT5yZWdp
c3Rlcl9wYXJhbXNbbmV4dF9yZWdfaWR4XSkKLQkJCQlyZXR1cm4gUEFSTV9UV09fQUREUl9MRU47
Ci0JCX0KKwlwYXJtLT50cnVlX3NpZ19tZW1iZXJfbmFtZSA9IGF0dHJfc3RyaW5nKCZtZW1iZXJf
ZGllLCBEV19BVF9uYW1lLCBjb25mKTsKKwlpZiAoIXBhcm0tPnRydWVfc2lnX21lbWJlcl9uYW1l
KSB7CisJCXBhcm0tPnRydWVfc2lnX21lbWJlcl9uYW1lID0gTlVMTDsKKwkJcmV0dXJuOwogCX0K
IAotCS8qIEZJWE1FOiBwYXJtLT5uYW1lIG1heSBiZSBOVUxMIGR1ZSB0byBhYnN0cmFjdCBvcmln
aW4uIFdlIGRvIG5vdCB3YW50IHRvCi0JICogdXBkYXRlIGFic3RyYWN0IG9yaWdpbiBhcyB0aGUg
dHlwZSBpbiBhYnN0cmFjdCBvcmlnaW4gbWF5IGJlIHVzZWQKLQkgKiBpbiBzb21lIG90aGVyIHBs
YWNlcy4gV2UgY291bGQgcmVtb3ZlIGFic3RyYWN0IG9yaWdpbiBpbiB0aGlzIHBhcmFtZXRlcgot
CSAqIGFuZCBhZGQgbmFtZSBhbmQgdHlwZSBpbiBwYXJhbWV0ZXIgaXRzZWxmLiBSaWdodCBub3cs
IGZvciBjdXJyZW50IGJwZi1uZXh0Ci0JICogcmVwbywgd2UgZG8gbm90IGhhdmUgaW5zdGFuY2Vz
IGJlbG93IHdoZXJlIHBhcm0tPm5hbWUgaXMgTlVMTCBmb3IgeDg2XzY0IGFyY2guCi0JICovCi0J
aWYgKCFwYXJtLT5uYW1lKQotCQlyZXR1cm4gUEFSTV9UT19CRV9JTVBST1ZFRDsKLQotCS8qIEZJ
WE1FOiBPbmx5IHN1cHBvcnQgc2luZ2xlIGZpZWxkIG5vdyBzbyB3ZSBjYW4gaGF2ZSBhIGdvb2Qg
cGFyYW1ldGVyIG5hbWUgYW5kCi0JICogdHlwZSBmb3IgaXQuIEZvciBtb3JlIHRoYW4gb25lIGZp
ZWxkLCBhbm90aGVyIG9wdGlvbiBjb3VsZCBiZSBuYW1lZCBhcwotCSAqIDxwYXJhbWV0ZXJfbmFt
ZT5fX2ZpcnN0X2hhbGYgb3IgPHBhcmFtZXRlcl9uYW1lPl9fc2Vjb25kX2hhbGYsIGJ1dCBpdCBp
cyBub3QKLQkgKiB0aGF0IGludHVpdGl2ZS4KLQkgKi8KLQlpZiAoX19idWlsdGluX3BvcGNvdW50
bGwoZmlyc3RfaGFsZikgPj0gMiB8fCBfX2J1aWx0aW5fcG9wY291bnRsbChzZWNvbmRfaGFsZikg
Pj0gMikKLQkJcmV0dXJuIFBBUk1fVE9fQkVfSU1QUk9WRUQ7CisJcGFybS0+dHJ1ZV9zaWdfdHlw
ZV9mcm9tX3R5cGVzID0gYXR0cl90eXBlKCZtZW1iZXJfZGllLCBEV19BVF90eXBlLCAmcGFybS0+
dHJ1ZV9zaWdfdHlwZSk7CisJaWYgKHBhcm0tPnRydWVfc2lnX3R5cGUgPT0gMCkKKwkJcGFybS0+
dHJ1ZV9zaWdfbWVtYmVyX25hbWUgPSBOVUxMOworfQogCitzdGF0aWMgdm9pZCBwYXJhbWV0ZXJf
X2ZpbmlzaF9waWVjZV9kZWNvZGUoc3RydWN0IHBhcmFtZXRlciAqcGFybSwgRHdhcmZfRGllICpk
aWUsCisJCQkJCSAgIHN0cnVjdCBjb25mX2xvYWQgKmNvbmYsIHN0cnVjdCBjdSAqY3UpCit7CisJ
dW5zaWduZWQgbG9uZyBmaXJzdCA9IHBhcm0tPmZpcnN0X3JlZ19maWVsZHM7CisJdW5zaWduZWQg
bG9uZyBzZWNvbmQgPSBwYXJtLT5zZWNvbmRfcmVnX2ZpZWxkczsKIAlpbnQgZmllbGRfb2Zmc2V0
OwotCWlmIChfX2J1aWx0aW5fcG9wY291bnRsbChmaXJzdF9oYWxmKSA9PSAxKQotCQlmaWVsZF9v
ZmZzZXQgPSBfX2J1aWx0aW5fY3R6bGwoZmlyc3RfaGFsZik7CisKKwlpZiAoIWZpcnN0ICYmICFz
ZWNvbmQpCisJCXJldHVybjsKKwlpZiAoZmlyc3QgJiYgc2Vjb25kKQorCQlyZXR1cm47CisJaWYg
KF9fYnVpbHRpbl9wb3Bjb3VudGwoZmlyc3QpID49IDIgfHwgX19idWlsdGluX3BvcGNvdW50bChz
ZWNvbmQpID49IDIpCisJCXJldHVybjsKKworCWlmIChfX2J1aWx0aW5fcG9wY291bnRsKGZpcnN0
KSA9PSAxKQorCQlmaWVsZF9vZmZzZXQgPSBfX2J1aWx0aW5fY3R6bChmaXJzdCk7CiAJZWxzZQot
CQlmaWVsZF9vZmZzZXQgPSBjdS0+YWRkcl9zaXplICsgX19idWlsdGluX2N0emxsKHNlY29uZF9o
YWxmKTsKKwkJZmllbGRfb2Zmc2V0ID0gY3UtPmFkZHJfc2l6ZSArIF9fYnVpbHRpbl9jdHpsKHNl
Y29uZCk7CiAKLQkvKiBGSVhNRTogT25seSBzdHJ1Y3QgdHlwZSBpcyBzdXBwb3J0ZWQuICovCi0J
RHdhcmZfRGllIG1lbWJlcl9kaWU7Ci0JaWYgKCFnZXRfbWVtYmVyX3dpdGhfb2Zmc2V0KGRpZSwg
ZmllbGRfb2Zmc2V0LCAmbWVtYmVyX2RpZSkpCi0JCXJldHVybiBQQVJNX1RPX0JFX0lNUFJPVkVE
OworCXBhcmFtZXRlcl9fcmVjb3JkX3RydWVfc2lnX21lbWJlcihwYXJtLCBkaWUsIGZpZWxkX29m
ZnNldCwgY29uZik7Cit9CiAKLQkvKiBGSVhNRTogY2Fubm90IGdldCBhIHByb3BlciBtZW1iZXJf
bmFtZSwgZS5nLiBpZiB0aGUgbWVtYmVyIHR5cGUgaXMgYSB1bmlvbi4gKi8KLQljb25zdCBjaGFy
ICptZW1iZXJfbmFtZSA9IGF0dHJfc3RyaW5nKCZtZW1iZXJfZGllLCBEV19BVF9uYW1lLCBjb25m
KTsKLQlpZiAoIW1lbWJlcl9uYW1lKQotCQlyZXR1cm4gUEFSTV9UT19CRV9JTVBST1ZFRDsKKy8q
IEZvciBhZ2dyZWdhdGUgcGFyYW1ldGVycyByZXByZXNlbnRlZCBieSBwaWVjZXMsIGZpcnN0X3Jl
Z19maWVsZHMgYW5kCisgKiBzZWNvbmRfcmVnX2ZpZWxkcyByZWNvcmQgdGhlIGJ5dGUgb2Zmc2V0
cyBtYXRlcmlhbGl6ZWQgaW4gZWFjaCBBQkkgcmVnaXN0ZXIuCisgKiBUaGUgbGF0ZXIgZnVuY3Rp
b24tbGV2ZWwgcGFzcyBkZWNpZGVzIHdoZXRoZXIgdGhlIHNvdXJjZSBhZ2dyZWdhdGUgaXMgc3Rp
bGwKKyAqIEFCSS1wcmVzZXJ2ZWQgb3Igc2hvdWxkIGJlIHJlcGxhY2VkIGJ5IHRoZSBzaW5nbGUg
dXNlZCBtZW1iZXIgY2FuZGlkYXRlLgorICovCitzdGF0aWMgdm9pZCBwYXJhbWV0ZXJfX211bHRp
X2V4cHJzKER3YXJmX09wICpleHByLCBpbnQgbG9jX251bSwgc3RydWN0IGN1ICpjdSwKKwkJCQkg
ICBzaXplX3QgZXhwcmxlbiwgc3RydWN0IHBhcmFtZXRlciAqcGFybSkKK3sKKwlzd2l0Y2ggKGV4
cHJbMF0uYXRvbSkgeworCWNhc2UgRFdfT1BfbGl0MCAuLi4gRFdfT1BfbGl0MzE6CisJY2FzZSBE
V19PUF9jb25zdHU6CisJY2FzZSBEV19PUF9jb25zdHM6CisJCWlmIChsb2NfbnVtID09IDApCisJ
CQlwYXJtLT5sb2NfY29uc3RfdmFsdWUgPSAxOworCQlyZXR1cm47CisJfQogCi0JLyogdHJ1ZV9z
aWdfbWVtYmVyX25hbWUgaXMgdGhlIG1lbWJlciBuYW1lIHdoaWNoIHdpbGwgYmUgdXNlZCBmb3Ig
bGF0ZXIgYnRmIG5hbWUKLQkgKiBsaWtlIDxwYXJhbWV0ZXJfbmFtZT5fXzxtZW1iZXJfbmFtZT4u
Ci0JICovCi0JcGFybS0+dHJ1ZV9zaWdfbWVtYmVyX25hbWUgPSBtZW1iZXJfbmFtZTsKKwlpZiAo
cGFybS0+dHlwZV9ieXRlX3NpemUgPD0gY3UtPmFkZHJfc2l6ZSB8fCAhY3UtPmFnZ191c2VfdHdv
X3JlZ3MpIHsKKwkJc3dpdGNoIChleHByWzBdLmF0b20pIHsKKwkJY2FzZSBEV19PUF9yZWcwIC4u
LiBEV19PUF9yZWczMToKKwkJCWlmIChsb2NfbnVtID09IDApCisJCQkJcGFyYW1ldGVyX19zZXRf
bG9jX3JlZyhwYXJtLCBleHByWzBdLmF0b20pOworCQkJcmV0dXJuOworCQljYXNlIERXX09QX2Jy
ZWcwIC4uLiBEV19PUF9icmVnMzE6CisJCQlpZiAobG9jX251bSA9PSAwICYmIGR3YXJmX2V4cHJf
X2hhc19zdGFja192YWx1ZShleHByLCBleHBybGVuKSkKKwkJCQlwYXJhbWV0ZXJfX3NldF9sb2Nf
cmVnKHBhcm0sIGV4cHJbMF0uYXRvbSAtIERXX09QX2JyZWcwICsgRFdfT1BfcmVnMCk7CisJCQly
ZXR1cm47CisJCWRlZmF1bHQ6CisJCQlyZXR1cm47CisJCX0KKwl9CiAKLQlzdHJ1Y3QgdGFnICp0
YWcgPSAmcGFybS0+dGFnOwotCXN0cnVjdCBkd2FyZl90YWcgKmR0YWcgPSB0YWdfX2R3YXJmKHRh
Zyk7Ci0JZHdhcmZfdGFnX19zZXRfYXR0cl90eXBlKGR0YWcsIHR5cGUsICZtZW1iZXJfZGllLCBE
V19BVF90eXBlKTsKKwlpbnQgb2ZmID0gMDsKKwlmb3IgKHNpemVfdCBpID0gMDsgaSA8IGV4cHJs
ZW47IGkrKykgeworCQlpZiAoZXhwcltpXS5hdG9tID09IERXX09QX3BpZWNlKSB7CisJCQlpbnQg
bnVtID0gZXhwcltpXS5udW1iZXI7CiAKLQlyZXR1cm4gcmV0OworCQkJaWYgKGkgPT0gMCkgewor
CQkJCW9mZiA9IG51bTsKKwkJCQljb250aW51ZTsKKwkJCX0KKworCQkJaWYgKG9mZiA8IGN1LT5h
ZGRyX3NpemUpCisJCQkJcGFyYW1ldGVyX19zZXRfZmllbGRfYml0KCZwYXJtLT5maXJzdF9yZWdf
ZmllbGRzLCBvZmYpOworCQkJZWxzZQorCQkJCXBhcmFtZXRlcl9fc2V0X2ZpZWxkX2JpdCgmcGFy
bS0+c2Vjb25kX3JlZ19maWVsZHMsIG9mZiAtIGN1LT5hZGRyX3NpemUpOworCQkJb2ZmICs9IG51
bTsKKwkJfSBlbHNlIGlmIChkd2FyZl9vcF9faXNfcmVnKGV4cHJbaV0uYXRvbSkpIHsKKwkJCWlm
IChvZmYgPCBjdS0+YWRkcl9zaXplIHx8IHBhcm0tPmxvY19yZWcgPT0gUEFSQU1FVEVSX1VOS05P
V05fUkVHKQorCQkJCXBhcmFtZXRlcl9fc2V0X2xvY19yZWcocGFybSwgZXhwcltpXS5hdG9tKTsK
KwkJfQorCQkvKiBGSVhNRTogbm90IGhhbmRsaW5nIERXX09QX2JyZWdYIHBpZWNlcyB5ZXQgc2lu
Y2Ugd2UgZG8gbm90CisJCSAqIGhhdmUgYSB1c2UgY2FzZSBmb3IgaXQgeWV0IGluIHRoZSBMaW51
eCBrZXJuZWwuCisJCSAqLworCX0KIH0KIAotLyogRm9yIERXX0FUX2xvY2F0aW9uICdhdHRyJzoK
LSAqIC0gaWYgZmlyc3QgbG9jYXRpb24gaXMgRFdfT1BfcmVnWFggd2l0aCBleHBlY3RlZCBudW1i
ZXIsIHJldHVybiB0aGUgcmVnaXN0ZXI7Ci0gKiAgIG90aGVyd2lzZSBzYXZlIHRoZSByZWdpc3Rl
ciBmb3IgbGF0ZXIgcmV0dXJuCi0gKiAtIGlmIGxvY2F0aW9uIERXX09QX2VudHJ5X3ZhbHVlKERX
X09QX3JlZ1hYKSB3aXRoIGV4cGVjdGVkIG51bWJlciBpcyBpbiB0aGUKLSAqICAgbGlzdCwgcmV0
dXJuIHRoZSByZWdpc3Rlcjsgb3RoZXJ3aXNlIHNhdmUgcmVnaXN0ZXIgZm9yIGxhdGVyIHJldHVy
bgotICogLSBvdGhlcndpc2UgaWYgbm8gcmVnaXN0ZXIgd2FzIGZvdW5kIGZvciBsb2NhdGlvbnMs
IHJldHVybiBQQVJNX0RFRkFVTFRfRkFJTC4KLSAqLwotc3RhdGljIGludCBwYXJhbWV0ZXJfX3Jl
ZyhEd2FyZl9BdHRyaWJ1dGUgKmF0dHIsIGludCBleHBlY3RlZF9yZWcsIHN0cnVjdCBjb25mX2xv
YWQgKmNvbmYsCi0JCQkgIHN0cnVjdCBmdW5jX2luZm8gKmluZm8sIHN0cnVjdCBjdSAqY3UsIER3
YXJmX0RpZSAqZGllLAotCQkJICBzdHJ1Y3QgcGFyYW1ldGVyICpwYXJtLCBpbnQgcGFyYW1faWR4
LCBpbnQgcmVnX2lkeCkKK3N0YXRpYyB2b2lkIHBhcmFtZXRlcl9fZGVjb2RlX2xvY2F0aW9uKER3
YXJmX0F0dHJpYnV0ZSAqYXR0ciwgc3RydWN0IGNvbmZfbG9hZCAqY29uZiwKKwkJCQkgICAgICAg
c3RydWN0IGN1ICpjdSwgRHdhcmZfRGllICpkaWUsCisJCQkJICAgICAgIHN0cnVjdCBwYXJhbWV0
ZXIgKnBhcm0pCiB7CiAJRHdhcmZfQWRkciBiYXNlLCBzdGFydCwgZW5kOwogCUR3YXJmX09wICpl
eHByLCAqZW50cnlfb3BzOwogCUR3YXJmX0F0dHJpYnV0ZSBlbnRyeV9hdHRyOwogCXNpemVfdCBl
eHBybGVuLCBlbnRyeV9sZW47CiAJcHRyZGlmZl90IG9mZnNldCA9IDA7Ci0JaW50IGJ5dGVfc2l6
ZSA9IDA7CiAJaW50IGxvY19udW0gPSAtMTsKLQlpbnQgcmV0ID0gUEFSTV9ERUZBVUxUX0ZBSUw7
Ci0JdW5zaWduZWQgbG9uZyBmaXJzdF9oYWxmID0gMCwgc2Vjb25kX2hhbGYgPSAwOwogCi0JLyog
dXNlIGxpYmR3X19sb2NrIGFzIGR3YXJmX2dldGxvY2F0aW9uKHMpIGhhcyBjb25jdXJyZW5jeSBp
c3N1ZXMKLQkgKiB3aGVuIGxpYmR3IGlzIG5vdCBjb21waWxlZCB3aXRoIGV4cGVyaW1lbnRhbCAt
LWVuYWJsZS10aHJlYWQtc2FmZXR5Ci0JICovCiAJcHRocmVhZF9tdXRleF9sb2NrKCZsaWJkd19f
bG9jayk7CiAJd2hpbGUgKChvZmZzZXQgPSBfX2R3YXJmX2dldGxvY2F0aW9ucyhhdHRyLCBvZmZz
ZXQsICZiYXNlLCAmc3RhcnQsICZlbmQsICZleHByLCAmZXhwcmxlbikpID4gMCkgeworCQlib29s
IGhhZF9zdGFja192YWx1ZTsKKwogCQlsb2NfbnVtKys7CisJCWlmIChleHBybGVuID09IDApCisJ
CQljb250aW51ZTsKIAotCQkvKiBDb252ZXJ0IGV4cHJlc3Npb24gbGlzdCAoWFggRFdfT1Bfc3Rh
Y2tfdmFsdWUpIC0+IChYWCkuCi0JCSAqIERXX09QX3N0YWNrX3ZhbHVlIGluc3RydWN0cyBpbnRl
cnByZXRlciB0byBwb3AgY3VycmVudCB2YWx1ZSBmcm9tCi0JCSAqIERXQVJGIGV4cHJlc3Npb24g
ZXZhbHVhdGlvbiBzdGFjaywgYW5kIHRodXMgaXMgbm90IGltcG9ydGFudCBoZXJlLgotCQkgKi8K
LQkJaWYgKGV4cHJsZW4gPT0gMiAmJiBleHByW2V4cHJsZW4gLSAxXS5hdG9tID09IERXX09QX3N0
YWNrX3ZhbHVlKQorCQloYWRfc3RhY2tfdmFsdWUgPSBleHByW2V4cHJsZW4gLSAxXS5hdG9tID09
IERXX09QX3N0YWNrX3ZhbHVlOworCQlpZiAoZXhwcmxlbiA9PSAyICYmIGhhZF9zdGFja192YWx1
ZSkKIAkJCWV4cHJsZW4tLTsKIAogCQlpZiAoZXhwcmxlbiAhPSAxKSB7Ci0JCQlpZiAoIWluZm8t
PnNpZ25hdHVyZV9jaGFuZ2VkIHx8ICFjb25mLT50cnVlX3NpZ25hdHVyZSkKLQkJCQljb250aW51
ZTsKLQotCQkJaWYgKCFieXRlX3NpemUpCi0JCQkJYnl0ZV9zaXplID0gZ2V0X3R5cGVfYnl0ZV9z
aXplKGRpZSwgY3UpOwotCQkJLyogVGhpcyBzaG91bGQgbm90IGhhcHBlbi4gKi8KLQkJCWlmICgh
Ynl0ZV9zaXplKSB7Ci0JCQkJcmV0ID0gUEFSTV9VTkVYUEVDVEVEOwotCQkJCWdvdG8gb3V0Owot
CQkJfQotCi0JCQlpbnQgcmVzOwotCQkJcmVzID0gcGFyYW1ldGVyX19tdWx0aV9leHBycyhleHBy
LCBsb2NfbnVtLCBjdSwgZXhwcmxlbiwgZGllLCBleHBlY3RlZF9yZWcsCi0JCQkJCQkgICAgIGJ5
dGVfc2l6ZSwgJmZpcnN0X2hhbGYsICZzZWNvbmRfaGFsZiwgJnJldCk7Ci0JCQlpZiAocmVzID09
IFBBUk1fQ09OVElOVUUpCi0JCQkJY29udGludWU7Ci0JCQlyZXQgPSByZXM7Ci0JCQlnb3RvIG91
dDsKKwkJCXBhcmFtZXRlcl9fbXVsdGlfZXhwcnMoZXhwciwgbG9jX251bSwgY3UsIGV4cHJsZW4s
IHBhcm0pOworCQkJY29udGludWU7CiAJCX0KIAogCQlzd2l0Y2ggKGV4cHItPmF0b20pIHsKLQkJ
LyogbWF0Y2ggRFdfT1BfcmVnWFggYXQgZmlyc3QgbG9jYXRpb24gKi8KIAkJY2FzZSBEV19PUF9y
ZWcwIC4uLiBEV19PUF9yZWczMToKLQkJCWlmIChsb2NfbnVtICE9IDApCi0JCQkJYnJlYWs7Ci0J
CQlyZXQgPSBleHByLT5hdG9tOwotCQkJaWYgKHJldCA9PSBleHBlY3RlZF9yZWcpCi0JCQkJZ290
byBvdXQ7CisJCQlpZiAobG9jX251bSA9PSAwKQorCQkJCXBhcmFtZXRlcl9fc2V0X2xvY19yZWco
cGFybSwgZXhwci0+YXRvbSk7CisJCQlicmVhazsKKwkJY2FzZSBEV19PUF9icmVnMCAuLi4gRFdf
T1BfYnJlZzMxOgorCQkJaWYgKGxvY19udW0gPT0gMCAmJiBoYWRfc3RhY2tfdmFsdWUpCisJCQkJ
cGFyYW1ldGVyX19zZXRfbG9jX3JlZyhwYXJtLCBleHByLT5hdG9tIC0gRFdfT1BfYnJlZzAgKyBE
V19PUF9yZWcwKTsKIAkJCWJyZWFrOwogCQljYXNlIERXX09QX2ZicmVnOgotCQkJLyogVGhlIGxv
Y2F0aW9uIGxpa2UKLQkJCSAqICAgRFdfQVRfbG9jYXRpb24gICAgICAgIChEV19PUF9mYnJlZyAr
PG51bT4pCi0JCQkgKiBpbmRpY2F0ZXMgdGhhdCB0aGUgcGFyYW1ldGVyIGlzIG9uIHRoZSBzdGFj
ay4gQnV0IGl0IGlzIHBvc3NpYmxlCi0JCQkgKiB0aGF0IHRoZSBwYXJhbWV0ZXIgY2FuIGZpdCBp
biByZWdpc3RlcihzKS4gU28gY29uc2VydmF0aXZlbHkKLQkJCSAqIG1hcmsgdGhpcyBwYXJhbWV0
ZXIgbm90IHN1aXRhYmxlIGZvciB0cnVlIHNpZ25hdHVyZXMuCi0JCQkgKi8KLQkJCWlmIChpbmZv
LT5zaWduYXR1cmVfY2hhbmdlZCAmJiBjb25mLT50cnVlX3NpZ25hdHVyZSkKLQkJCQlyZXQgPSBQ
QVJNX1VORVhQRUNURUQ7CisJCQlwYXJtLT5sb2Nfc3RhY2sgPSAxOwogCQkJYnJlYWs7CiAJCWNh
c2UgRFdfT1BfbGl0MCAuLi4gRFdfT1BfbGl0MzE6CiAJCWNhc2UgRFdfT1BfY29uc3R1OgogCQlj
YXNlIERXX09QX2NvbnN0czoKLQkJCWlmIChpbmZvLT5zaWduYXR1cmVfY2hhbmdlZCAmJiBjb25m
LT50cnVlX3NpZ25hdHVyZSkgewotCQkJCWlmIChsb2NfbnVtICE9IDApCi0JCQkJCWJyZWFrOwot
CQkJCXJldCA9IFBBUk1fT1BUSU1JWkVEX09VVDsKLQkJCQlnb3RvIG91dDsKLQkJCX0KKwkJCWlm
IChsb2NfbnVtID09IDApCisJCQkJcGFybS0+bG9jX2NvbnN0X3ZhbHVlID0gMTsKIAkJCWJyZWFr
OwotCQkvKiBtYXRjaCBEV19PUF9lbnRyeV92YWx1ZShEV19PUF9yZWdYWCkgYXQgYW55IGxvY2F0
aW9uICovCiAJCWNhc2UgRFdfT1BfZW50cnlfdmFsdWU6CiAJCWNhc2UgRFdfT1BfR05VX2VudHJ5
X3ZhbHVlOgogCQkJaWYgKGR3YXJmX2dldGxvY2F0aW9uX2F0dHIoYXR0ciwgZXhwciwgJmVudHJ5
X2F0dHIpID09IDAgJiYKIAkJCSAgICBkd2FyZl9nZXRsb2NhdGlvbigmZW50cnlfYXR0ciwgJmVu
dHJ5X29wcywgJmVudHJ5X2xlbikgPT0gMCAmJgotCQkJICAgIGVudHJ5X2xlbiA9PSAxKSB7Ci0J
CQkJcmV0ID0gZW50cnlfb3BzLT5hdG9tOwotCQkJCWlmIChyZXQgPT0gZXhwZWN0ZWRfcmVnKQot
CQkJCQlnb3RvIG91dDsKLQkJCX0KKwkJCSAgICBlbnRyeV9sZW4gPT0gMSAmJiBkd2FyZl9vcF9f
aXNfcmVnKGVudHJ5X29wcy0+YXRvbSkpCisJCQkJcGFyYW1ldGVyX19zZXRfbG9jX3JlZyhwYXJt
LCBlbnRyeV9vcHMtPmF0b20pOwogCQkJYnJlYWs7CiAJCX0KIAl9Ci0KLQlyZXQgPSBwYXJhbWV0
ZXJfX2hhbmRsZV90d29fYWRkcl9sZW4oZXhwZWN0ZWRfcmVnLCBmaXJzdF9oYWxmLCBzZWNvbmRf
aGFsZiwKLQkJCQkJICAgICByZXQsIGRpZSwgY29uZiwgY3UsIHBhcm0sIHBhcmFtX2lkeCwgcmVn
X2lkeCwKLQkJCQkJICAgICBieXRlX3NpemUsIGluZm8pOwotCi1vdXQ6CiAJcHRocmVhZF9tdXRl
eF91bmxvY2soJmxpYmR3X19sb2NrKTsKLQlyZXR1cm4gcmV0OworCisJcGFyYW1ldGVyX19maW5p
c2hfcGllY2VfZGVjb2RlKHBhcm0sIGRpZSwgY29uZiwgY3UpOwogfQogCiBzdGF0aWMgc3RydWN0
IHBhcmFtZXRlciAqcGFyYW1ldGVyX19uZXcoRHdhcmZfRGllICpkaWUsIHN0cnVjdCBjdSAqY3Us
Ci0JCQkJCXN0cnVjdCBjb25mX2xvYWQgKmNvbmYsIGludCBwYXJhbV9pZHgsCi0JCQkJCXN0cnVj
dCBmdW5jX2luZm8gKmluZm8pCisJCQkJCXN0cnVjdCBjb25mX2xvYWQgKmNvbmYsIGludCBwYXJh
bV9pZHgpCiB7CiAJc3RydWN0IHBhcmFtZXRlciAqcGFybSA9IHRhZ19fYWxsb2MoY3UsIHNpemVv
ZigqcGFybSkpOwogCiAJaWYgKHBhcm0gIT0gTlVMTCkgewotCQlib29sIGhhc19jb25zdF92YWx1
ZSwgdHJ1ZV9zaWdfZW5hYmxlZDsKIAkJRHdhcmZfQXR0cmlidXRlIGF0dHI7Ci0JCWludCByZWdf
aWR4OwogCiAJCXRhZ19faW5pdCgmcGFybS0+dGFnLCBjdSwgZGllKTsKIAkJcGFybS0+bmFtZSA9
IGF0dHJfc3RyaW5nKGRpZSwgRFdfQVRfbmFtZSwgY29uZik7CiAJCXBhcm0tPmlkeCA9IHBhcmFt
X2lkeDsKLQkJaWYgKHBhcmFtX2lkeCA8IDApCi0JCQlyZXR1cm4gcGFybTsKLQkJaWYgKCFpbmZv
LT5zaWduYXR1cmVfY2hhbmdlZCkgewotCQkJaWYgKGN1LT5wcm9kdWNlcl9jbGFuZyB8fCBwYXJh
bV9pZHggPj0gY3UtPm5yX3JlZ2lzdGVyX3BhcmFtcykKLQkJCQlyZXR1cm4gcGFybTsKLQkJCXJl
Z19pZHggPSBwYXJhbV9pZHg7Ci0JCX0gZWxzZSB7Ci0JCQlyZWdfaWR4ID0gcGFyYW1faWR4IC0g
aW5mby0+c2tpcF9pZHg7Ci0JCX0KKwkJcGFybS0+bG9jX3JlZyA9IFBBUkFNRVRFUl9VTktOT1dO
X1JFRzsKKwkJcGFybS0+dHlwZV9ieXRlX3NpemUgPSBnZXRfdHlwZV9ieXRlX3NpemUoZGllLCBj
dSk7CiAKIAkJLyogUGFyYW1ldGVycyB3aGljaCB1c2UgRFdfQVRfYWJzdHJhY3Rfb3JpZ2luIHRv
IHBvaW50IGF0CiAJCSAqIHRoZSBvcmlnaW5hbCBwYXJhbWV0ZXIgZGVmaW5pdGlvbiAod2l0aCBu
byBuYW1lIGluIHRoZSBESUUpCkBAIC0xNjcyLDY2ICsxNTMxLDEwIEBAIHN0YXRpYyBzdHJ1Y3Qg
cGFyYW1ldGVyICpwYXJhbWV0ZXJfX25ldyhEd2FyZl9EaWUgKmRpZSwgc3RydWN0IGN1ICpjdSwK
IAkJICogYmV0d2VlbiB0aGVzZSBwYXJhbWV0ZXIgcmVwcmVzZW50YXRpb25zLiAgU2VlCiAJCSAq
IGZ0eXBlX19yZWNvZGVfZHdhcmZfdHlwZXMoKSBiZWxvdyBmb3IgaG93IHRoaXMgaXMgaGFuZGxl
ZC4KIAkJICovCi0JCWhhc19jb25zdF92YWx1ZSA9IGR3YXJmX2F0dHIoZGllLCBEV19BVF9jb25z
dF92YWx1ZSwgJmF0dHIpICE9IE5VTEw7CisJCXBhcm0tPmhhc19jb25zdF92YWx1ZSA9IGR3YXJm
X2F0dHIoZGllLCBEV19BVF9jb25zdF92YWx1ZSwgJmF0dHIpICE9IE5VTEw7CiAJCXBhcm0tPmhh
c19sb2MgPSBkd2FyZl9hdHRyKGRpZSwgRFdfQVRfbG9jYXRpb24sICZhdHRyKSAhPSBOVUxMOwot
CQl0cnVlX3NpZ19lbmFibGVkID0gY29uZi0+dHJ1ZV9zaWduYXR1cmUgJiYgaW5mby0+c2lnbmF0
dXJlX2NoYW5nZWQ7Ci0KLQkJaWYgKHBhcm0tPmhhc19sb2MpIHsKLQkJCWlmIChyZWdfaWR4ID49
IGN1LT5ucl9yZWdpc3Rlcl9wYXJhbXMpCi0JCQkJcmV0dXJuIHBhcm07Ci0KLQkJCWludCBleHBl
Y3RlZF9yZWcgPSBjdS0+cmVnaXN0ZXJfcGFyYW1zW3JlZ19pZHhdOwotCQkJaW50IGFjdHVhbF9y
ZWcgPSBwYXJhbWV0ZXJfX3JlZygmYXR0ciwgZXhwZWN0ZWRfcmVnLCBjb25mLCBpbmZvLCBjdSwg
ZGllLAotCQkJCQkJCXBhcm0sIHBhcmFtX2lkeCwgcmVnX2lkeCk7Ci0KLQkJCWlmIChhY3R1YWxf
cmVnID09IFBBUk1fREVGQVVMVF9GQUlMKSB7Ci0JCQkJcGFybS0+b3B0aW1pemVkID0gMTsKLQkJ
CX0gZWxzZSBpZiAoYWN0dWFsX3JlZyA9PSBQQVJNX09QVElNSVpFRF9PVVQpIHsKLQkJCQlwYXJt
LT5vcHRpbWl6ZWQgPSAxOwotCQkJCWluZm8tPnNraXBfaWR4Kys7Ci0JCQl9IGVsc2UgaWYgKGFj
dHVhbF9yZWcgPT0gUEFSTV9UV09fQUREUl9MRU4pIHsKLQkJCQkvKiBhY2NvdW50IGZvciBwYXJh
bWV0ZXIgd2l0aCB0d28gcmVnaXN0ZXJzICovCi0JCQkJaW5mby0+c2tpcF9pZHgtLTsKLQkJCX0g
ZWxzZSBpZiAoYWN0dWFsX3JlZyA9PSBQQVJNX1VORVhQRUNURUQgfHwgYWN0dWFsX3JlZyA9PSBQ
QVJNX1RPX0JFX0lNUFJPVkVEIHx8Ci0JCQkJICAgKGV4cGVjdGVkX3JlZyA+PSAwICYmIGV4cGVj
dGVkX3JlZyAhPSBhY3R1YWxfcmVnKSkgewotCQkJCS8qIG1hcmsgcGFyYW1ldGVycyB0aGF0IHVz
ZSBhbiB1bmV4cGVjdGVkCi0JCQkJICogcmVnaXN0ZXIgdG8gaG9sZCBhIHBhcmFtZXRlcjsgdGhl
c2Ugd2lsbAotCQkJCSAqIGJlIHByb2JsZW1hdGljIGZvciB1c2VycyBvZiBCVEYgYXMgdGhleQot
CQkJCSAqIHZpb2xhdGUgZXhwZWN0YXRpb25zIGFib3V0IHJlZ2lzdGVyCi0JCQkJICogY29udGVu
dHMuCi0JCQkJICovCi0JCQkJcGFybS0+dW5leHBlY3RlZF9yZWcgPSAxOwotCQkJfQotCQl9IGVs
c2UgaWYgKGhhc19jb25zdF92YWx1ZSAmJiAhY3UtPnByb2R1Y2VyX2NsYW5nKSB7Ci0JCQlwYXJt
LT5vcHRpbWl6ZWQgPSAxOwotCQl9IGVsc2UgaWYgKHRydWVfc2lnX2VuYWJsZWQpIHsKLQkJCWlu
dCBieXRlX3NpemUsIG51bV9yZWdzLCBuZXh0X3JlZ19pZHg7Ci0KLQkJCWlmIChwYXJhbV9pZHgg
KyAxIDwgaW5mby0+bnJfcGFyYW1zKSB7Ci0JCQkJaW50IG5leHRfc3RhcnQgPSBpbmZvLT5wYXJh
bV9zdGFydF9yZWdzW3BhcmFtX2lkeCArIDFdOwotCQkJCWlmIChuZXh0X3N0YXJ0ID49IDApIHsK
LQkJCQkJLyogY2hlY2sgd2hldGhlciB3ZSBzaG91bGQgcHJlc2VydmUgdGhlIGFyZ3VtZW50IG9y
IG5vdCAqLwotCQkJCQlieXRlX3NpemUgPSBnZXRfdHlwZV9ieXRlX3NpemUoZGllLCBjdSk7Ci0J
CQkJCS8qIGJ5dGVfc2l6ZSAwIHNob3VsZCBub3QgaGFwcGVuLiAqLwotCQkJCQlpZiAoIWJ5dGVf
c2l6ZSkgewotCQkJCQkJcGFybS0+dW5leHBlY3RlZF9yZWcgPSAxOwotCQkJCQkJcmV0dXJuIHBh
cm07Ci0JCQkJCX0KLQotCQkJCQludW1fcmVncyA9IChieXRlX3NpemUgKyBjdS0+YWRkcl9zaXpl
IC0gMSkgLyBjdS0+YWRkcl9zaXplOwotCQkJCQluZXh0X3JlZ19pZHggPSByZWdfaWR4ICsgbnVt
X3JlZ3M7Ci0JCQkJCWlmIChuZXh0X3JlZ19pZHggPCBjdS0+bnJfcmVnaXN0ZXJfcGFyYW1zICYm
Ci0JCQkJCSAgICBuZXh0X3N0YXJ0ID09IGN1LT5yZWdpc3Rlcl9wYXJhbXNbbmV4dF9yZWdfaWR4
XSkgewotCQkJCQkJaWYgKGJ5dGVfc2l6ZSA+IGN1LT5hZGRyX3NpemUpCi0JCQkJCQkJaW5mby0+
c2tpcF9pZHgtLTsKLQkJCQkJCXJldHVybiBwYXJtOwotCQkJCQl9Ci0JCQkJfQotCQkJfQotCi0J
CQlwYXJtLT5vcHRpbWl6ZWQgPSAxOwotCQkJaW5mby0+c2tpcF9pZHgrKzsKLQkJfQorCQlpZiAo
cGFybS0+aGFzX2xvYykKKwkJCXBhcmFtZXRlcl9fZGVjb2RlX2xvY2F0aW9uKCZhdHRyLCBjb25m
LCBjdSwgZGllLCBwYXJtKTsKIAl9CiAKIAlyZXR1cm4gcGFybTsKQEAgLTE3NTEsNyArMTU1NCw3
IEBAIHN0YXRpYyBpbnQgZm9ybWFsX3BhcmFtZXRlcl9wYWNrX19sb2FkX3BhcmFtcyhzdHJ1Y3Qg
Zm9ybWFsX3BhcmFtZXRlcl9wYWNrICpwYWNrCiAJCQljb250aW51ZTsKIAkJfQogCi0JCXN0cnVj
dCBwYXJhbWV0ZXIgKnBhcmFtID0gcGFyYW1ldGVyX19uZXcoZGllLCBjdSwgY29uZiwgLTEsIE5V
TEwpOworCQlzdHJ1Y3QgcGFyYW1ldGVyICpwYXJhbSA9IHBhcmFtZXRlcl9fbmV3KGRpZSwgY3Us
IGNvbmYsIC0xKTsKIAogCQlpZiAocGFyYW0gPT0gTlVMTCkKIAkJCXJldHVybiAtMTsKQEAgLTIy
MzcsOSArMjA0MCw5IEBAIHN0YXRpYyBzdHJ1Y3QgdGFnICpkaWVfX2NyZWF0ZV9uZXdfcGFyYW1l
dGVyKER3YXJmX0RpZSAqZGllLAogCQkJCQkgICAgIHN0cnVjdCBmdHlwZSAqZnR5cGUsCiAJCQkJ
CSAgICAgc3RydWN0IGxleGJsb2NrICpsZXhibG9jaywKIAkJCQkJICAgICBzdHJ1Y3QgY3UgKmN1
LCBzdHJ1Y3QgY29uZl9sb2FkICpjb25mLAotCQkJCQkgICAgIGludCBwYXJhbV9pZHgsIHN0cnVj
dCBmdW5jX2luZm8gKmluZm8pCisJCQkJCSAgICAgaW50IHBhcmFtX2lkeCkKIHsKLQlzdHJ1Y3Qg
cGFyYW1ldGVyICpwYXJtID0gcGFyYW1ldGVyX19uZXcoZGllLCBjdSwgY29uZiwgcGFyYW1faWR4
LCBpbmZvKTsKKwlzdHJ1Y3QgcGFyYW1ldGVyICpwYXJtID0gcGFyYW1ldGVyX19uZXcoZGllLCBj
dSwgY29uZiwgcGFyYW1faWR4KTsKIAogCWlmIChwYXJtID09IE5VTEwpCiAJCXJldHVybiBOVUxM
OwpAQCAtMjMyNiw3ICsyMTI5LDcgQEAgc3RhdGljIHN0cnVjdCB0YWcgKmRpZV9fY3JlYXRlX25l
d19zdWJyb3V0aW5lX3R5cGUoRHdhcmZfRGllICpkaWUsCiAJCQl0YWdfX3ByaW50X25vdF9zdXBw
b3J0ZWQoZGllKTsKIAkJCWNvbnRpbnVlOwogCQljYXNlIERXX1RBR19mb3JtYWxfcGFyYW1ldGVy
OgotCQkJdGFnID0gZGllX19jcmVhdGVfbmV3X3BhcmFtZXRlcihkaWUsIGZ0eXBlLCBOVUxMLCBj
dSwgY29uZiwgLTEsIE5VTEwpOworCQkJdGFnID0gZGllX19jcmVhdGVfbmV3X3BhcmFtZXRlcihk
aWUsIGZ0eXBlLCBOVUxMLCBjdSwgY29uZiwgLTEpOwogCQkJYnJlYWs7CiAJCWNhc2UgRFdfVEFH
X3Vuc3BlY2lmaWVkX3BhcmFtZXRlcnM6CiAJCQlmdHlwZS0+dW5zcGVjX3Bhcm1zID0gMTsKQEAg
LTI1NTUsOCArMjM1OCw3IEBAIG91dF9lbm9tZW06CiB9CiAKIHN0YXRpYyBpbnQgZGllX19wcm9j
ZXNzX2Z1bmN0aW9uKER3YXJmX0RpZSAqZGllLCBzdHJ1Y3QgZnR5cGUgKmZ0eXBlLAotCQkJCSBz
dHJ1Y3QgbGV4YmxvY2sgKmxleGJsb2NrLCBzdHJ1Y3QgY3UgKmN1LCBzdHJ1Y3QgY29uZl9sb2Fk
ICpjb25mLAotCQkJCSBzdHJ1Y3QgZnVuY19pbmZvICppbmZvKTsKKwkJCQkgc3RydWN0IGxleGJs
b2NrICpsZXhibG9jaywgc3RydWN0IGN1ICpjdSwgc3RydWN0IGNvbmZfbG9hZCAqY29uZik7CiAK
IHN0YXRpYyBpbnQgZGllX19jcmVhdGVfbmV3X2xleGJsb2NrKER3YXJmX0RpZSAqZGllLAogCQkJ
CSAgICBzdHJ1Y3QgY3UgKmN1LCBzdHJ1Y3QgbGV4YmxvY2sgKmZhdGhlciwgc3RydWN0IGNvbmZf
bG9hZCAqY29uZikKQEAgLTI1NjQsNyArMjM2Niw3IEBAIHN0YXRpYyBpbnQgZGllX19jcmVhdGVf
bmV3X2xleGJsb2NrKER3YXJmX0RpZSAqZGllLAogCXN0cnVjdCBsZXhibG9jayAqbGV4YmxvY2sg
PSBsZXhibG9ja19fbmV3KGRpZSwgY3UpOwogCiAJaWYgKGxleGJsb2NrICE9IE5VTEwpIHsKLQkJ
aWYgKGRpZV9fcHJvY2Vzc19mdW5jdGlvbihkaWUsIE5VTEwsIGxleGJsb2NrLCBjdSwgY29uZiwg
TlVMTCkgIT0gMCkKKwkJaWYgKGRpZV9fcHJvY2Vzc19mdW5jdGlvbihkaWUsIE5VTEwsIGxleGJs
b2NrLCBjdSwgY29uZikgIT0gMCkKIAkJCWdvdG8gb3V0X2RlbGV0ZTsKIAl9CiAJaWYgKGZhdGhl
ciAhPSBOVUxMKQpAQCAtMjY4NCw4ICsyNDg2LDcgQEAgc3RhdGljIHN0cnVjdCB0YWcgKmRpZV9f
Y3JlYXRlX25ld19pbmxpbmVfZXhwYW5zaW9uKER3YXJmX0RpZSAqZGllLAogfQogCiBzdGF0aWMg
aW50IGRpZV9fcHJvY2Vzc19mdW5jdGlvbihEd2FyZl9EaWUgKmRpZSwgc3RydWN0IGZ0eXBlICpm
dHlwZSwKLQkJCQkgc3RydWN0IGxleGJsb2NrICpsZXhibG9jaywgc3RydWN0IGN1ICpjdSwgc3Ry
dWN0IGNvbmZfbG9hZCAqY29uZiwKLQkJCQkgc3RydWN0IGZ1bmNfaW5mbyAqaW5mbykKKwkJCQkg
c3RydWN0IGxleGJsb2NrICpsZXhibG9jaywgc3RydWN0IGN1ICpjdSwgc3RydWN0IGNvbmZfbG9h
ZCAqY29uZikKIHsKIAlpbnQgcGFyYW1faWR4ID0gMDsKIAlEd2FyZl9EaWUgY2hpbGQ7CkBAIC0y
NzU5LDcgKzI1NjAsNyBAQCBzdGF0aWMgaW50IGRpZV9fcHJvY2Vzc19mdW5jdGlvbihEd2FyZl9E
aWUgKmRpZSwgc3RydWN0IGZ0eXBlICpmdHlwZSwKIAkJCWNvbnRpbnVlOwogCQl9CiAJCWNhc2Ug
RFdfVEFHX2Zvcm1hbF9wYXJhbWV0ZXI6Ci0JCQl0YWcgPSBkaWVfX2NyZWF0ZV9uZXdfcGFyYW1l
dGVyKGRpZSwgZnR5cGUsIGxleGJsb2NrLCBjdSwgY29uZiwgcGFyYW1faWR4KyssIGluZm8pOwor
CQkJdGFnID0gZGllX19jcmVhdGVfbmV3X3BhcmFtZXRlcihkaWUsIGZ0eXBlLCBsZXhibG9jaywg
Y3UsIGNvbmYsIHBhcmFtX2lkeCsrKTsKIAkJCWJyZWFrOwogCQljYXNlIERXX1RBR192YXJpYWJs
ZToKIAkJCXRhZyA9IGRpZV9fY3JlYXRlX25ld192YXJpYWJsZShkaWUsIGN1LCBjb25mLCAwKTsK
QEAgLTI4MjcsNTggKzI2MjgsMTggQEAgb3V0X2Vub21lbToKIAlyZXR1cm4gLUVOT01FTTsKIH0K
IAotLyogUHJlLXNjYW4gYWxsIGZvcm1hbCBwYXJhbWV0ZXJzIHRvIGNvbGxlY3QgdGhlaXIgc3Rh
cnRpbmcgcmVnaXN0ZXJzLgotICogVGhpcyBhbGxvd3MgbG9vay1haGVhZCB3aGVuIHByb2Nlc3Np
bmcgcGFyYW1ldGVycyBzZXF1ZW50aWFsbHksIHNvIHRoYXQKLSAqIGEgcGFyYW1ldGVyIGNhbiBj
aGVjayB0aGUgbmV4dCBwYXJhbWV0ZXIncyByZWdpc3RlciB0byBkZXRlcm1pbmUgaWYgdGhlCi0g
KiBBQkkgcmVnaXN0ZXIgbGF5b3V0IGlzIHByZXNlcnZlZCBkZXNwaXRlIHBhcnRpYWwgb3B0aW1p
emF0aW9uLgotICogRm9yIGV4YW1wbGUsIGZvciBhIGZ1bmN0aW9uIGxpa2UgYmVsb3c6Ci0gKiAg
c3RydWN0IHQgeyBsb25nIGYxOyBsb25nIGYyOyB9OwotICogIF9fYXR0cmlidXRlX18oKG5vaW5s
aW5lKSkgc3RhdGljIGxvbmcgZm9vKHN0cnVjdCB0IGEsIHN0cnVjdCB0IGIpCi0gKiAgewotICog
ICAgICByZXR1cm4gYS5mMSArIGIuZjEgKyBiLmYyOwotICogIH0KLSAqIElmIGR3YXJmIGhhcyBw
YXJhbWV0ZXIgJ2EnIGF0IGFhcmNoNjQgcmVnaXN0ZXIgVzAsIGFuZCAnYicgYXQgcmVnaXN0ZXIg
VzIsCi0gKiBldmVuIGNvbXBpbGVyIGNvdWxkIG9wdGltaXplICdhJyB0byAnYS5mMScuIFRvIGNv
bmZvcm0gdG8gQUJJLCB0aGUKLSAqIHBhcmFtZXRlciAnYScgd2lsbCBrZWVwICdzdHJ1Y3QgdCcg
dHlwZS4KLSAqLwotc3RhdGljIHZvaWQgZnVuY19pbmZvX19wcmVzY2FuX3BhcmFtcyhzdHJ1Y3Qg
ZnVuY19pbmZvICppbmZvLCBEd2FyZl9EaWUgKmRpZSkKLXsKLQlEd2FyZl9EaWUgY2hpbGQ7Ci0J
aW50IGlkeCA9IDA7Ci0KLQlpZiAoIWluZm8tPnNpZ25hdHVyZV9jaGFuZ2VkKQotCQlyZXR1cm47
Ci0KLQlpZiAoIWR3YXJmX2hhc2NoaWxkcmVuKGRpZSkgfHwgZHdhcmZfY2hpbGQoZGllLCAmY2hp
bGQpICE9IDApCi0JCXJldHVybjsKLQotCWRvIHsKLQkJaWYgKGR3YXJmX3RhZygmY2hpbGQpICE9
IERXX1RBR19mb3JtYWxfcGFyYW1ldGVyKQotCQkJY29udGludWU7Ci0JCWlmIChpZHggPj0gTUFY
X1BSRVNDQU5fUEFSQU1TKQotCQkJYnJlYWs7Ci0JCWluZm8tPnBhcmFtX3N0YXJ0X3JlZ3NbaWR4
XSA9IHBhcmFtZXRlcl9fcGVla19maXJzdF9yZWcoJmNoaWxkKTsKLQkJaWR4Kys7Ci0JfSB3aGls
ZSAoZHdhcmZfc2libGluZ29mKCZjaGlsZCwgJmNoaWxkKSA9PSAwKTsKLQotCWluZm8tPm5yX3Bh
cmFtcyA9IGlkeDsKLX0KLQogc3RhdGljIHN0cnVjdCB0YWcgKmRpZV9fY3JlYXRlX25ld19mdW5j
dGlvbihEd2FyZl9EaWUgKmRpZSwgc3RydWN0IGN1ICpjdSwgc3RydWN0IGNvbmZfbG9hZCAqY29u
ZikKIHsKIAlzdHJ1Y3QgZnVuY3Rpb24gKmZ1bmN0aW9uID0gZnVuY3Rpb25fX25ldyhkaWUsIGN1
LCBjb25mKTsKLQlzdHJ1Y3QgZnVuY19pbmZvIGluZm8gPSB7fTsKIAogCWlmIChmdW5jdGlvbiAh
PSBOVUxMKSB7CiAJCS8qIEZvciBjbGFuZywgd2UgZGV0ZXJtaW5lIGlmIGZ1bmN0aW9uIHNpZ25h
dHVyZSBjaGFuZ2VzIHZpYSBEV19BVF9jYWxsaW5nX2NvbnZlbnRpb24KIAkJICogc2V0IHRvIERX
X0NDX25vY2FsbC4KIAkJICovCi0JCWlmIChjdS0+cHJvZHVjZXJfY2xhbmcpIHsKLQkJCWluZm8u
c2lnbmF0dXJlX2NoYW5nZWQgPSBmdW5jdGlvbl9fc2lnbmF0dXJlX2NoYW5nZWQoZnVuY3Rpb24s
IGRpZSk7Ci0JCQlmdW5jX2luZm9fX3ByZXNjYW5fcGFyYW1zKCZpbmZvLCBkaWUpOwotCQl9CisJ
CWlmIChjdS0+cHJvZHVjZXJfY2xhbmcpCisJCQlmdW5jdGlvbi0+cHJvdG8uc2lnbmF0dXJlX2No
YW5nZWQgPSBmdW5jdGlvbl9fc2lnbmF0dXJlX2NoYW5nZWQoZnVuY3Rpb24sIGRpZSk7CiAKLQkJ
aWYgKGRpZV9fcHJvY2Vzc19mdW5jdGlvbihkaWUsICZmdW5jdGlvbi0+cHJvdG8sICZmdW5jdGlv
bi0+bGV4YmxvY2ssIGN1LCBjb25mLCAmaW5mbykgIT0gMCkgeworCQlpZiAoZGllX19wcm9jZXNz
X2Z1bmN0aW9uKGRpZSwgJmZ1bmN0aW9uLT5wcm90bywgJmZ1bmN0aW9uLT5sZXhibG9jaywgY3Us
IGNvbmYpICE9IDApIHsKIAkJCWZ1bmN0aW9uX19kZWxldGUoZnVuY3Rpb24sIGN1KTsKIAkJCWZ1
bmN0aW9uID0gTlVMTDsKIAkJfQpAQCAtMzEzMyw2ICsyODk0LDIzIEBAIHN0YXRpYyB2b2lkIGZ0
eXBlX19yZWNvZGVfZHdhcmZfdHlwZXMoc3RydWN0IHRhZyAqdGFnLCBzdHJ1Y3QgY3UgKmN1KQog
CQkJICovCiAJCQlpZiAocG9zLT5oYXNfbG9jKQogCQkJCW9wb3MtPmhhc19sb2MgPSBwb3MtPmhh
c19sb2M7CisJCQlpZiAocG9zLT5oYXNfY29uc3RfdmFsdWUpCisJCQkJb3Bvcy0+aGFzX2NvbnN0
X3ZhbHVlID0gcG9zLT5oYXNfY29uc3RfdmFsdWU7CisJCQlpZiAocG9zLT5sb2NfY29uc3RfdmFs
dWUpCisJCQkJb3Bvcy0+bG9jX2NvbnN0X3ZhbHVlID0gcG9zLT5sb2NfY29uc3RfdmFsdWU7CisJ
CQlpZiAocG9zLT5sb2Nfc3RhY2spCisJCQkJb3Bvcy0+bG9jX3N0YWNrID0gcG9zLT5sb2Nfc3Rh
Y2s7CisJCQlpZiAocG9zLT5sb2NfcmVnICE9IFBBUkFNRVRFUl9VTktOT1dOX1JFRykKKwkJCQlv
cG9zLT5sb2NfcmVnID0gcG9zLT5sb2NfcmVnOworCQkJaWYgKHBvcy0+dHlwZV9ieXRlX3NpemUg
IT0gMCkKKwkJCQlvcG9zLT50eXBlX2J5dGVfc2l6ZSA9IHBvcy0+dHlwZV9ieXRlX3NpemU7CisJ
CQlvcG9zLT5maXJzdF9yZWdfZmllbGRzIHw9IHBvcy0+Zmlyc3RfcmVnX2ZpZWxkczsKKwkJCW9w
b3MtPnNlY29uZF9yZWdfZmllbGRzIHw9IHBvcy0+c2Vjb25kX3JlZ19maWVsZHM7CisJCQlpZiAo
cG9zLT50cnVlX3NpZ19tZW1iZXJfbmFtZSAmJiAhb3Bvcy0+dHJ1ZV9zaWdfbWVtYmVyX25hbWUp
IHsKKwkJCQlvcG9zLT50cnVlX3NpZ19tZW1iZXJfbmFtZSA9IHBvcy0+dHJ1ZV9zaWdfbWVtYmVy
X25hbWU7CisJCQkJb3Bvcy0+dHJ1ZV9zaWdfdHlwZSA9IHBvcy0+dHJ1ZV9zaWdfdHlwZTsKKwkJ
CQlvcG9zLT50cnVlX3NpZ190eXBlX2Zyb21fdHlwZXMgPSBwb3MtPnRydWVfc2lnX3R5cGVfZnJv
bV90eXBlczsKKwkJCX0KIAogCQkJaWYgKHBvcy0+b3B0aW1pemVkKQogCQkJCW9wb3MtPm9wdGlt
aXplZCA9IHBvcy0+b3B0aW1pemVkOwpAQCAtMzE1MCw2ICsyOTI4LDE0NSBAQCBzdGF0aWMgdm9p
ZCBmdHlwZV9fcmVjb2RlX2R3YXJmX3R5cGVzKHN0cnVjdCB0YWcgKnRhZywgc3RydWN0IGN1ICpj
dSkKIAl9CiB9CiAKK3N0YXRpYyBzdHJ1Y3QgcGFyYW1ldGVyICpmdHlwZV9fbmV4dF9wYXJhbWV0
ZXIoc3RydWN0IGZ0eXBlICpmdHlwZSwgc3RydWN0IHBhcmFtZXRlciAqcGFybSkKK3sKKwlpZiAo
cGFybS0+dGFnLm5vZGUubmV4dCA9PSAmZnR5cGUtPnBhcm1zKQorCQlyZXR1cm4gTlVMTDsKKwly
ZXR1cm4gbGlzdF9lbnRyeShwYXJtLT50YWcubm9kZS5uZXh0LCBzdHJ1Y3QgcGFyYW1ldGVyLCB0
YWcubm9kZSk7Cit9CisKK3N0YXRpYyBpbnQgcGFyYW1ldGVyX19hYmlfc2xvdHMoY29uc3Qgc3Ry
dWN0IHBhcmFtZXRlciAqcGFybSwgY29uc3Qgc3RydWN0IGN1ICpjdSkKK3sKKwlpbnQgc2xvdHM7
CisKKwlpZiAoIWN1LT5hZ2dfdXNlX3R3b19yZWdzIHx8IHBhcm0tPnR5cGVfYnl0ZV9zaXplIDw9
IGN1LT5hZGRyX3NpemUpCisJCXJldHVybiAxOworCisJc2xvdHMgPSAocGFybS0+dHlwZV9ieXRl
X3NpemUgKyBjdS0+YWRkcl9zaXplIC0gMSkgLyBjdS0+YWRkcl9zaXplOworCXJldHVybiBzbG90
cyA+IDAgPyBzbG90cyA6IDE7Cit9CisKK3N0YXRpYyBib29sIHBhcmFtZXRlcl9faGFzX3BpZWNl
X2luZm8oY29uc3Qgc3RydWN0IHBhcmFtZXRlciAqcGFybSkKK3sKKwlyZXR1cm4gcGFybS0+Zmly
c3RfcmVnX2ZpZWxkcyB8fCBwYXJtLT5zZWNvbmRfcmVnX2ZpZWxkczsKK30KKworc3RhdGljIGJv
b2wgcGFyYW1ldGVyX191c2VzX2Z1bGxfYWdncmVnYXRlKGNvbnN0IHN0cnVjdCBwYXJhbWV0ZXIg
KnBhcm0pCit7CisJcmV0dXJuIHBhcm0tPmZpcnN0X3JlZ19maWVsZHMgJiYgcGFybS0+c2Vjb25k
X3JlZ19maWVsZHM7Cit9CisKK3N0YXRpYyBib29sIGZ0eXBlX19uZXh0X3BhcmFtZXRlcl9wcmVz
ZXJ2ZXNfc2xvdHMoc3RydWN0IGZ0eXBlICpmdHlwZSwgc3RydWN0IHBhcmFtZXRlciAqcGFybSwK
KwkJCQkJCSAgaW50IHJlZ19pZHgsIGludCBzbG90cywgc3RydWN0IGN1ICpjdSkKK3sKKwlzdHJ1
Y3QgcGFyYW1ldGVyICpuZXh0ID0gZnR5cGVfX25leHRfcGFyYW1ldGVyKGZ0eXBlLCBwYXJtKTsK
KwlpbnQgbmV4dF9yZWdfaWR4OworCisJaWYgKCFuZXh0IHx8IG5leHQtPmxvY19yZWcgPT0gUEFS
QU1FVEVSX1VOS05PV05fUkVHKQorCQlyZXR1cm4gZmFsc2U7CisKKwluZXh0X3JlZ19pZHggPSBy
ZWdfaWR4ICsgc2xvdHM7CisJcmV0dXJuIG5leHRfcmVnX2lkeCA8IGN1LT5ucl9yZWdpc3Rlcl9w
YXJhbXMgJiYKKwkgICAgICAgbmV4dC0+bG9jX3JlZyA9PSBjdS0+cmVnaXN0ZXJfcGFyYW1zW25l
eHRfcmVnX2lkeF07Cit9CisKK3N0YXRpYyBib29sIHBhcmFtZXRlcl9fYXBwbHlfdHJ1ZV9zaWdf
bWVtYmVyKHN0cnVjdCBwYXJhbWV0ZXIgKnBhcm0sIHN0cnVjdCBjdSAqY3UpCit7CisJc3RydWN0
IGR3YXJmX3RhZyB0bXAgPSB7fTsKKwlzdHJ1Y3QgZHdhcmZfdGFnICpkdHlwZTsKKworCWlmICgh
cGFybS0+dHJ1ZV9zaWdfbWVtYmVyX25hbWUgfHwgcGFybS0+dHJ1ZV9zaWdfdHlwZSA9PSAwKQor
CQlyZXR1cm4gZmFsc2U7CisKKwl0bXAudHlwZSA9IHBhcm0tPnRydWVfc2lnX3R5cGU7CisJdG1w
LmZyb21fdHlwZXNfc2VjdGlvbi50eXBlID0gcGFybS0+dHJ1ZV9zaWdfdHlwZV9mcm9tX3R5cGVz
OworCWR0eXBlID0gX19kd2FyZl9jdV9fZmluZF90eXBlX2J5X3JlZihjdS0+cHJpdiwgdG1wLnR5
cGUsIHRtcC5mcm9tX3R5cGVzX3NlY3Rpb24udHlwZSk7CisJaWYgKCFkdHlwZSkKKwkJcmV0dXJu
IGZhbHNlOworCisJcGFybS0+dGFnLnR5cGUgPSBkdHlwZS0+c21hbGxfaWQ7CisJcmV0dXJuIHRy
dWU7Cit9CisKK3N0YXRpYyB2b2lkIGZ1bmN0aW9uX19hbmFseXplX3BhcmFtZXRlcl9sb2NhdGlv
bnMoc3RydWN0IGZ1bmN0aW9uICpmbiwgc3RydWN0IGN1ICpjdSwKKwkJCQkJCSAgc3RydWN0IGNv
bmZfbG9hZCAqY29uZikKK3sKKwlzdHJ1Y3QgZnR5cGUgKmZ0eXBlID0gJmZuLT5wcm90bzsKKwlz
dHJ1Y3QgcGFyYW1ldGVyICpwb3M7CisJYm9vbCB0cnVlX3NpZ19lbmFibGVkID0gY29uZi0+dHJ1
ZV9zaWduYXR1cmUgJiYgZnR5cGUtPnNpZ25hdHVyZV9jaGFuZ2VkOworCWJvb2wgY2hlY2tfcmVn
aXN0ZXJzID0gIWN1LT5wcm9kdWNlcl9jbGFuZyB8fCB0cnVlX3NpZ19lbmFibGVkOworCWludCBy
ZWdfaWR4ID0gMDsKKworCWlmICghY2hlY2tfcmVnaXN0ZXJzKQorCQlyZXR1cm47CisKKwlmdHlw
ZV9fZm9yX2VhY2hfcGFyYW1ldGVyKGZ0eXBlLCBwb3MpIHsKKwkJYm9vbCBjb25zdW1lc19yZWdp
c3RlciA9IHRydWU7CisJCWludCBzbG90cyA9IHBhcmFtZXRlcl9fYWJpX3Nsb3RzKHBvcywgY3Up
OworCQlpbnQgZXhwZWN0ZWRfcmVnOworCisJCWlmIChyZWdfaWR4ID49IGN1LT5ucl9yZWdpc3Rl
cl9wYXJhbXMpCisJCQljb250aW51ZTsKKworCQlleHBlY3RlZF9yZWcgPSBjdS0+cmVnaXN0ZXJf
cGFyYW1zW3JlZ19pZHhdOworCisJCWlmIChwb3MtPmhhc19sb2MpIHsKKwkJCWlmICh0cnVlX3Np
Z19lbmFibGVkICYmIHBvcy0+bG9jX2NvbnN0X3ZhbHVlKSB7CisJCQkJcG9zLT5vcHRpbWl6ZWQg
PSAxOworCQkJCWNvbnN1bWVzX3JlZ2lzdGVyID0gZmFsc2U7CisJCQkJZ290byBuZXh0OworCQkJ
fQorCisJCQlpZiAodHJ1ZV9zaWdfZW5hYmxlZCAmJiBwb3MtPmxvY19zdGFjaykgeworCQkJCXBv
cy0+dW5leHBlY3RlZF9yZWcgPSAxOworCQkJCWdvdG8gbmV4dDsKKwkJCX0KKworCQkJaWYgKHBv
cy0+bG9jX3JlZyA9PSBQQVJBTUVURVJfVU5LTk9XTl9SRUcpIHsKKwkJCQlwb3MtPm9wdGltaXpl
ZCA9IDE7CisJCQkJY29uc3VtZXNfcmVnaXN0ZXIgPSAhdHJ1ZV9zaWdfZW5hYmxlZDsKKwkJCQln
b3RvIG5leHQ7CisJCQl9CisKKwkJCWlmIChleHBlY3RlZF9yZWcgPj0gMCAmJiBleHBlY3RlZF9y
ZWcgIT0gcG9zLT5sb2NfcmVnKSB7CisJCQkJcG9zLT51bmV4cGVjdGVkX3JlZyA9IDE7CisJCQkJ
Z290byBuZXh0OworCQkJfQorCisJCQlpZiAodHJ1ZV9zaWdfZW5hYmxlZCAmJiBwYXJhbWV0ZXJf
X2hhc19waWVjZV9pbmZvKHBvcykpIHsKKwkJCQlpZiAocGFyYW1ldGVyX191c2VzX2Z1bGxfYWdn
cmVnYXRlKHBvcykgfHwKKwkJCQkgICAgZnR5cGVfX25leHRfcGFyYW1ldGVyX3ByZXNlcnZlc19z
bG90cyhmdHlwZSwgcG9zLCByZWdfaWR4LCBzbG90cywgY3UpKSB7CisJCQkJCXJlZ19pZHggKz0g
c2xvdHM7CisJCQkJCWNvbnRpbnVlOworCQkJCX0KKworCQkJCWlmIChwYXJhbWV0ZXJfX2FwcGx5
X3RydWVfc2lnX21lbWJlcihwb3MsIGN1KSkgeworCQkJCQlyZWdfaWR4Kys7CisJCQkJCWNvbnRp
bnVlOworCQkJCX0KKworCQkJCXBvcy0+dW5leHBlY3RlZF9yZWcgPSAxOworCQkJCXJlZ19pZHgg
Kz0gc2xvdHM7CisJCQkJY29udGludWU7CisJCQl9CisJCX0gZWxzZSBpZiAocG9zLT5oYXNfY29u
c3RfdmFsdWUgJiYgIWN1LT5wcm9kdWNlcl9jbGFuZykgeworCQkJcG9zLT5vcHRpbWl6ZWQgPSAx
OworCQl9IGVsc2UgaWYgKHRydWVfc2lnX2VuYWJsZWQpIHsKKwkJCWlmIChmdHlwZV9fbmV4dF9w
YXJhbWV0ZXJfcHJlc2VydmVzX3Nsb3RzKGZ0eXBlLCBwb3MsIHJlZ19pZHgsIHNsb3RzLCBjdSkp
IHsKKwkJCQlyZWdfaWR4ICs9IHNsb3RzOworCQkJCWNvbnRpbnVlOworCQkJfQorCisJCQlwb3Mt
Pm9wdGltaXplZCA9IDE7CisJCQljb25zdW1lc19yZWdpc3RlciA9IGZhbHNlOworCQl9CisKK25l
eHQ6CisJCWlmIChjb25zdW1lc19yZWdpc3RlcikKKwkJCXJlZ19pZHgrKzsKKwl9Cit9CisKIHN0
YXRpYyB2b2lkIGxleGJsb2NrX19yZWNvZGVfZHdhcmZfdHlwZXMoc3RydWN0IGxleGJsb2NrICp0
YWcsIHN0cnVjdCBjdSAqY3UpCiB7CiAJc3RydWN0IHRhZyAqcG9zOwpAQCAtMzQyNSw3ICszMzQy
LDcgQEAgc3RhdGljIGJvb2wgcGFyYW1fX2lzX3N0cnVjdChzdHJ1Y3QgY3UgKmN1LCBzdHJ1Y3Qg
dGFnICp0YWcpCiAJfQogfQogCi1zdGF0aWMgaW50IGN1X19yZXNvbHZlX2Z1bmNfcmV0X3R5cGVz
X29wdGltaXplZChzdHJ1Y3QgY3UgKmN1KQorc3RhdGljIGludCBjdV9fcmVzb2x2ZV9mdW5jX3Jl
dF90eXBlc19vcHRpbWl6ZWQoc3RydWN0IGN1ICpjdSwgc3RydWN0IGNvbmZfbG9hZCAqY29uZikK
IHsKIAlzdHJ1Y3QgcHRyX3RhYmxlICpwdCA9ICZjdS0+ZnVuY3Rpb25zX3RhYmxlOwogCXVpbnQz
Ml90IGk7CkBAIC0zNDM2LDYgKzMzNTMsOCBAQCBzdGF0aWMgaW50IGN1X19yZXNvbHZlX2Z1bmNf
cmV0X3R5cGVzX29wdGltaXplZChzdHJ1Y3QgY3UgKmN1KQogCQlzdHJ1Y3QgZnVuY3Rpb24gKmZu
ID0gdGFnX19mdW5jdGlvbih0YWcpOwogCQlib29sIGhhc191bmV4cGVjdGVkX3JlZyA9IGZhbHNl
LCBoYXNfc3RydWN0X3BhcmFtID0gZmFsc2U7CiAKKwkJZnVuY3Rpb25fX2FuYWx5emVfcGFyYW1l
dGVyX2xvY2F0aW9ucyhmbiwgY3UsIGNvbmYpOworCiAJCS8qIG1hcmsgZnVuY3Rpb24gYXMgb3B0
aW1pemVkIGlmIHBhcmFtZXRlciBpcywgb3IKIAkJICogaWYgcGFyYW1ldGVyIGRvZXMgbm90IGhh
dmUgYSBsb2NhdGlvbjsgYXQgdGhpcwogCQkgKiBwb2ludCBsb2NhdGlvbiBwcmVzZW5jZSBoYXMg
YmVlbiBtYXJrZWQgaW4KQEAgLTM2MTQsNyArMzUzMyw3IEBAIHN0YXRpYyBpbnQgZGllX19wcm9j
ZXNzX2FuZF9yZWNvZGUoRHdhcmZfRGllICpkaWUsIHN0cnVjdCBjdSAqY3UsIHN0cnVjdCBjb25m
X2xvCiAJaWYgKHJldCAhPSAwKQogCQlyZXR1cm4gcmV0OwogCi0JcmV0dXJuIGN1X19yZXNvbHZl
X2Z1bmNfcmV0X3R5cGVzX29wdGltaXplZChjdSk7CisJcmV0dXJuIGN1X19yZXNvbHZlX2Z1bmNf
cmV0X3R5cGVzX29wdGltaXplZChjdSwgY29uZik7CiB9CiAKIHN0YXRpYyBpbnQgY2xhc3NfbWVt
YmVyX19jYWNoZV9ieXRlX3NpemUoc3RydWN0IHRhZyAqdGFnLCBzdHJ1Y3QgY3UgKmN1LApAQCAt
NDM3Nyw3ICs0Mjk2LDcgQEAgc3RhdGljIGludCBjdXNfX21lcmdlX2FuZF9wcm9jZXNzX2N1KHN0
cnVjdCBjdXMgKmN1cywgc3RydWN0IGNvbmZfbG9hZCAqY29uZiwKIAkgKiBlbmNvZGVkIGluIGFu
b3RoZXIgc3VicHJvZ3JhbSB0aHJvdWdoIGFic3RyYWN0X29yaWdpbgogCSAqIHRhZy4gTGV0IHVz
IHZpc2l0IGFsbCBzdWJwcm9ncmFtcyBhZ2FpbiB0byByZXNvbHZlIHRoaXMuCiAJICovCi0JaWYg
KGN1X19yZXNvbHZlX2Z1bmNfcmV0X3R5cGVzX29wdGltaXplZChjdSkgIT0gTFNLX19LRUVQSVQp
CisJaWYgKGN1X19yZXNvbHZlX2Z1bmNfcmV0X3R5cGVzX29wdGltaXplZChjdSwgY29uZikgIT0g
TFNLX19LRUVQSVQpCiAJCWdvdG8gb3V0X2Fib3J0OwogCiAJY3VfX2ZpbmFsaXplKGN1LCBjdXMs
IGNvbmYpOwpkaWZmIC0tZ2l0IGEvZHdhcnZlcy5oIGIvZHdhcnZlcy5oCmluZGV4IDJmYzkzN2Eu
LmVkM2YwMDUgMTAwNjQ0Ci0tLSBhL2R3YXJ2ZXMuaAorKysgYi9kd2FydmVzLmgKQEAgLTk0OSw2
ICs5NDksMTUgQEAgc3RydWN0IHBhcmFtZXRlciB7CiAJc3RydWN0IHRhZyB0YWc7CiAJY29uc3Qg
Y2hhciAqbmFtZTsKIAljb25zdCBjaGFyICp0cnVlX3NpZ19tZW1iZXJfbmFtZTsKKwlEd2FyZl9P
ZmYgdHJ1ZV9zaWdfdHlwZTsKKwl1bnNpZ25lZCBsb25nIGZpcnN0X3JlZ19maWVsZHM7CisJdW5z
aWduZWQgbG9uZyBzZWNvbmRfcmVnX2ZpZWxkczsKKwlpbnQgbG9jX3JlZzsKKwl1aW50MTZfdCB0
eXBlX2J5dGVfc2l6ZTsKKwl1aW50OF90IHRydWVfc2lnX3R5cGVfZnJvbV90eXBlczoxOworCXVp
bnQ4X3QgaGFzX2NvbnN0X3ZhbHVlOjE7CisJdWludDhfdCBsb2NfY29uc3RfdmFsdWU6MTsKKwl1
aW50OF90IGxvY19zdGFjazoxOwogCXVpbnQ4X3Qgb3B0aW1pemVkOjE7CiAJdWludDhfdCB1bmV4
cGVjdGVkX3JlZzoxOwogCXVpbnQ4X3QgaGFzX2xvYzoxOwpAQCAtMTAzMyw2ICsxMDQyLDcgQEAg
c3RydWN0IGZ0eXBlIHsKIAl1aW50OF90CQkgaW5jb25zaXN0ZW50X3Byb3RvOjE7CiAJdWludDhf
dAkJIHVuY2VydGFpbl9wYXJtX2xvYzoxOwogCXVpbnQ4X3QJCSByZW9yZGVyZWRfcGFybToxOwor
CXVpbnQ4X3QJCSBzaWduYXR1cmVfY2hhbmdlZDoxOwogCXN0cnVjdCBsaXN0X2hlYWQgdGVtcGxh
dGVfdHlwZV9wYXJhbXM7CiAJc3RydWN0IGxpc3RfaGVhZCB0ZW1wbGF0ZV92YWx1ZV9wYXJhbXM7
CiAJc3RydWN0IHRlbXBsYXRlX3BhcmFtZXRlcl9wYWNrICp0ZW1wbGF0ZV9wYXJhbWV0ZXJfcGFj
azsKLS0gCjIuNDMuNQoK

--------------3eXYCrIJEr3NzOMKmCpMZDxT--
