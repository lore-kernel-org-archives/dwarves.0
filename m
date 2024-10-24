Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64113AA2F
	for <dwarves@vger.kernel.org>; Thu, 24 Oct 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774900; cv=fail; b=tHBCXauhgKBS6HDYHPVj/2LXxogXOFCXebwWpukRJAb0Ldxqc9mHN6RAxnQiuo0adLAuo9yD6CNWtl/EeE7gGWBRNRzPiktEqJhvSBBV+H8i+SotIlT3ifVcqTWKyaO5v3JyNgsD34lmpc1w/tOypsdMpy9STxgnF5Xw42HPf78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774900; c=relaxed/simple;
	bh=tkNwx7YjaPk+xvgS6HQ9/+XLtqPeC5VegK5J1q7wXFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VPpYFbtqWPgKQCXA6RwDjInH6WpxqSfuRsJjUrE5cwp1zo0YraCoUnuoIoHc3UXy7Z0iywmNPNF+VCefInxR0O3belvNoTizmccqfKVizn5bG2Y7LIXTSjvlsOIHlPRoiochsR+c72lmIrH8BNdDnurRPP7LgTu54XIXIlJxV6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nWYxIzUU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZNx2rdD4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nWYxIzUU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZNx2rdD4"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC1W7o016378;
	Thu, 24 Oct 2024 13:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lfc4cJ66VKCTjYw9qpbfiAJPE/j7cxfXpY/6MGCmxH4=; b=
	nWYxIzUUED2XvxGBezn+zsBkjkVj4KkXyFHoBz7i7aOAOVOC2odvSbiXoVK5rIqz
	dtlg46HuPajThWqC5rP1cKYO49GzSQ6XdY0Ae1sQWCfG3/y4y5BZrBe8C4ftNvf6
	TBVHhMan6oSxGHY4/05g51puLaTb5lnnz5gvmIBIkI7KeCA3tXN9Xyr591pXo+GI
	jwhdkFGZiuZiNdp+cRDWC4sgKcM7WueAewPZQ6247+VzkGF0oLusMi3e8PGhSQ+l
	dghLpRIuHJtO/tkiSfLG7DbVp4SrrcgM4WGHi2uVV45/xeZ/TmTIvyQxzCPsrzKv
	++ztn055zhW7Pdpqor+/7w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545anrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 13:01:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC4N1x036040;
	Thu, 24 Oct 2024 13:01:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3wsjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 13:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxLJagfk/CXy9Z0qDYO7XoXQh3jsI2+vvAX0rPVuBwKq5jWi6X1vdXl8T+kPBDhoAOEQWXffr8Pw8OmXZGFuNu2IVAbVGSoDnYDf/e4aBpTEcJfmTg8NHZ9we48agDMPERDcHmuivcUiVn0EinIlG1yFqXjyeyyAK6bCqP6H3ifGWnYggagshOO9S6EVehP0Nn0hZMfNCBuxYSHrphfp+jSPcyAE2bD5UFc7q5fS5al4/pg5F5XJYs/BYuZwFzB6IPoV+CrFrBCf5Cg3cWGGxYVAI3vaW73L0DJ2tUY0ILLUhl11MvEUQtiL9e/3ruseS8GTFeE2QrhbHuHIaW0ZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfc4cJ66VKCTjYw9qpbfiAJPE/j7cxfXpY/6MGCmxH4=;
 b=Vt2W8bsML9fkDz3xDbFXz/DQePF0e2S9TY6n2IK+DC4nW04wjZ+sd/A6g1Gn3AECBpGcKLxy5Y7pEmjpwy+jwOZ8/5ROWzOmqoRwFQKDY1CQMxT5MMN0QJeCiyAMofnQZkZU2S0r9ouXVfDRovGZHyvndRTqPLbHr/3G5HEkjJwy6jpuBUnDH6b5cWmcmq0zLNlP+OGV0ligvVhDdcJxcq0iKMw+zagLNJK3mAwfhPxDHYKC1Mv2YJ+tgfmIlTeZcd5LzrJViEtl9QR+ADmjfZ7VITOZGm0kZKAxdQ7FxTXS7DAZrS6C6Qq4Pp4ePH6gkUsQxsJVU5C8eTxXHAXErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfc4cJ66VKCTjYw9qpbfiAJPE/j7cxfXpY/6MGCmxH4=;
 b=ZNx2rdD4/+2hYpI02EyNN2RnKmR47PxRrN7cYd8I2eZ1zdM+jtSrJmk8MvGmDMP1pBbWlNkSvtoDKK/mBjJx5bAwhobHweGGBAqXxIPzFuF4TEK2JSnV7zFOduEXHLH1kbf0JM+4WkhHzwle9Urol0I8fWuSOn7iMaYmNXMXk6A=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5581.namprd10.prod.outlook.com (2603:10b6:a03:3d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 13:01:30 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 13:01:30 +0000
Message-ID: <74f2a4bd-27c9-4f5b-963f-2d1a492c9eec@oracle.com>
Date: Thu, 24 Oct 2024 14:01:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 1/2] tests/flexible_arrays: redirect stderr to
 avoid warnings
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
References: <20241024112615.750704-1-alan.maguire@oracle.com>
 <20241024112615.750704-2-alan.maguire@oracle.com>
 <CA+JHD923mvOrr9JoKeVkeB1k2PTGSHsi7=6HPrV4tVNF1R=GWA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CA+JHD923mvOrr9JoKeVkeB1k2PTGSHsi7=6HPrV4tVNF1R=GWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0086.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: 424cc8a1-2dce-46da-416f-08dcf42bfa33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDNwYll5TzZVUXlxdFpaUXNCdklFTzhnQ21kYVhXakx6R1dPeW1mUWd3cmpT?=
 =?utf-8?B?aGZOdVpINk1LdEtLTGJ4SDBiaTBpRkhzT0xVdi9BRXN5YmFlZk5sMURLMnRu?=
 =?utf-8?B?dmxYZFE5NmFPTk52cWV4YkZFYUNZbkZJK1BwV0F4SnZOc1JIK2pGemdTVW9S?=
 =?utf-8?B?VWZvWVJpTVVaUm9jbUZTZTltSVBCRWJ0YjJnUFJFdW1ldXFyV0JvSlVZUE9p?=
 =?utf-8?B?SE5Oem1kaXdKNHVrQXBaQkZMZVp4OU5lRTVGY3dJL09Sd0ljQ3drWHRzZ1Vx?=
 =?utf-8?B?OWQxNjQ1TjRJUCs5OVZucnc3bnV4ZWJ1d0VtOVU1RHMrNHVwcisrWXNRSkV3?=
 =?utf-8?B?NERUM2NqNWlBaFcvTTEzVTRaL09RaUNrY1BodjFUbm9qY2h0aUlIczhIcG1V?=
 =?utf-8?B?NXRITTB5cUNKQVk4YWxXUFhwUnIya21pK0xtWS9EVW9UWjltS0J5dDczbDVw?=
 =?utf-8?B?c0U2b3lyRzhQUFBwd0hWUEJVc2pDT0FhditVc3FkOVZVRE9pNWx2anB1cXgx?=
 =?utf-8?B?SVdJcHJiOXZqRlNzNWFyalFHRFI0SEJYSS9FSnZPcTJRdlZtdENSMUVDcndU?=
 =?utf-8?B?Wkp3K3hPVWlOWlJURXorTmI1QTdNMGZkb0dGNjVtL3ljTmplZE45VS92Y3Z6?=
 =?utf-8?B?ajJiYmtCdHVOTG9RWHhRVU1SNW9DZ2VsdFRnNndPZHp2Y0dRNGYwTkRINEhu?=
 =?utf-8?B?bzRKdCtwZWJPci9GQ0toUjFhdldwSEFFNnlScFpLSk1KTkV2Q0R2UkFTWEkx?=
 =?utf-8?B?dXY0SGErOW5HZ0QrK29yOFR3NEExYXhsaEt2MFFkc1k3b0VGazR2cy8rVk9S?=
 =?utf-8?B?RlIyaUJrb21oZHBpQmlsV0lkRUxoemNvaUlkMzVveUg0Yi9CdVVYa0tPbHg2?=
 =?utf-8?B?a21kM2dZTzVsenB6U0QyU1U0VVVWUUtDQ3ZpZmdydTJrV3VkZzFGdkVCdVJV?=
 =?utf-8?B?SXZGUzZseENTcHFnMFB1TWFtOXhrUTZGb3Z6a0c5WmVFeExZamxFV0hWS3ds?=
 =?utf-8?B?cUk3d2NyQnZXQXZ1YWw0ZHhnZjNYdWNuT0t4a0VRRVhlQ1VraG5DREV4Q1hp?=
 =?utf-8?B?eG1ONFV4T29TMFlxK3prMVZ0VDJuRFRsWlovM1A0eDh5dU83djJvWS9GcVFV?=
 =?utf-8?B?RFdFditKSk9CLytNYmgyeUkzQURMOTlYZGNsaEl1SlJmZEJraW5JWldNZ0dl?=
 =?utf-8?B?VkpXN2EydEFOR0ZOd2RldVE1VkdhSHRQRTF0SXIwSnJuME1qSFI4czVDY21N?=
 =?utf-8?B?SHZPRDBvQW5scjh5M0x3dlZrSmZjc3l1ZS9NQWdSSjUrRzJEczBtWmVqS0Yr?=
 =?utf-8?B?R0dzL0VveVhSUUlGVktudEwyNW9abzdTMnpjUXY3NXZXZTZQR2RhMXNTVkc0?=
 =?utf-8?B?a2hmQUxvc3c2aDA2Y3hwSUwyb3ZmbjdHVlVZZ0NZSnljRWtLcnFEU2drWXVt?=
 =?utf-8?B?Y1JmcnFNR2JnOTFhQWFER0J6NmRBMDZYV2x6bDRHREdpaVREbi9NeGI4dkJl?=
 =?utf-8?B?allJc1NWZ2ZUWU9pYThlL3pGa0kzZGx0WjhVWGRjR3dzQkVaL1hmcCtYbzdr?=
 =?utf-8?B?VEMwNitZVHRmeTdtei9pZ3FYOVRya0gyM3RCVGlXc1RuQTc5alB2UTRXcWps?=
 =?utf-8?B?MDRrSXFVUmtlU0dQUUZka1lMTjBMRDhSOE14Q0lkU1Q2Z0NWZGFCVHJndTl5?=
 =?utf-8?Q?arNnWc/ZQ+SfXtt3beFt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajBpeldDdWpnc2cyNi9IanQ2NGxUditjUnlqakV1aTZwemlLczYxb3M5NElS?=
 =?utf-8?B?ZXg0dmZJOGxUSEIxYlRMV1l0YXlkYkI2bFRSSmNua2lWMlZVTS9VbWpvRTRk?=
 =?utf-8?B?RUlsSUswRU0xNnZzK3AvaDkwOG1KNWdFdzZnNU82L0hlc2IyaDJpSGFycjcy?=
 =?utf-8?B?U0VXMHZmMWttVVZRMFN4ZzBVR3dyN0NFOGVsTWR2bUV5OXFSWWtFKzhacnpo?=
 =?utf-8?B?bFpQRUljRUVJNHBQMkZCazhkaXBwRFBqa3o3WXJMTDBoZ1c1NWxMZmRaR2JP?=
 =?utf-8?B?SDlQOWp5V3ZtQlFhaUYyVGJacGMyTnMwZEh6THptWENPSmQ2am1TTlp5QXBY?=
 =?utf-8?B?MnBjV2hQWUtZZkNtbm5MQjIyUkRoMWJyWDM0SktaYzhyeGNZalB3QnZnU1Ru?=
 =?utf-8?B?ZElaZ3RzaXM1YnZkZFVlRGNCK25oT3VGaTByU01sZHBWNUM5VHJPbDBhdzBW?=
 =?utf-8?B?N1FZYUt3bnE0MXA2eGFBZDQycXdwaFdhQitYVnVpY1pMMStKTUpaNkZXd3NK?=
 =?utf-8?B?SGVKK21rMUJNRVN0WjFBRlJkVlpndnhEcE1MYk04YVhQaDJTaWgrMlJlaHZL?=
 =?utf-8?B?WE54T1VwOHNFVWlEVXlENVk4RDVuQjIyWGZCK3NkMlg1NmlROU1ueGhzbmVx?=
 =?utf-8?B?YU94VnJjVXhoNzkxRHZsOTk0b1FtVEw3WTVGVnBzWC9Ec3BLQ1M1MVljZjFw?=
 =?utf-8?B?U1MyQVRJOGZGQlR1RGd1dVROeUhWTzh3Mm5LWTBDQ3NQS3UzREZUR3hTRWpp?=
 =?utf-8?B?QzY4RW5qaW82Y0RaOXZqOXdMYU0xa0ZTMERrSEIybHc0bEZUSVdsZElMY25a?=
 =?utf-8?B?SjBIdGZsRER1K0luYTdDb01FSlJOZGRLdmZ2TTFMekt0QlFsckhySWlTL1Fn?=
 =?utf-8?B?TmVyREZ3RWFBTWw1TzloaUUwRGl2ZFlhNWlRR3k0SXQ1dFN2KytPWHpkVGV0?=
 =?utf-8?B?R1E3Vk95OFpNMGZaZUFGQWRNbmF5Yld2R1Zkd1hBT0lJcXArTjZtOFdwamJy?=
 =?utf-8?B?S0cwK0RmZXdNZWx0bkhRby9PclByUFBNbk9wdG5iK2hnbW5TVkYyWFpYS3Qy?=
 =?utf-8?B?aFAzallGSytaNnFxdVVyMGNXLzFKYUN4TmhJMUloNERkL0U3SDQ1Q013MmRV?=
 =?utf-8?B?WUtGUG1rSU1RTVpSUzRSSGhZdlRTd2VUWmdDd0orR0hBRzFtVlljQzVCNjY5?=
 =?utf-8?B?S0g2TkNKNm9tWU5XeGtla3dmejdlRW0xYkFhV1BiNkFMcUY4ZnVxRjNUbyt0?=
 =?utf-8?B?aDZQUGZMVmgwZHU2SDl4UVRzaDU3QmN3ZGZVdURiU2IvSFI3MC9HalVIYnZ6?=
 =?utf-8?B?a2FhWEZsbEJnZzNYdXdHeGdVZzZob2x2cFV2eEF3ZUFMS1lDcXhPSlkwVit0?=
 =?utf-8?B?c2JvRWVRZHVUMHlKaGZjRi83OXBKeDBQTmtNYnpmYWF0WHNQREkvYWE2dWli?=
 =?utf-8?B?VjRRMFVJVGFXRDBnTDVwWGdaSU1CQ1cxZS9DVEtaNlMrVitZU2Q1dTNFUXk1?=
 =?utf-8?B?UDVnRlFhV21lZkRHTkJxa1V1OEhrRlpXMWcwZUlwV0hoM0ZTQ0pKR1hzR0ZN?=
 =?utf-8?B?cUhnUlpnN0t3SFc4TlBQN0xEcjN5NFF0UTZJT1N6VXFJU2ZxaUJyVkVjQ3JX?=
 =?utf-8?B?TTFQeHA4aEZSS2pZYUY4ZW92UDlIOFZzTUNZNzRJbW1zT3JVK2VIWEgza3lY?=
 =?utf-8?B?bms2WjZhMVJxMnNINGhzTXJ5Qk1ZYXVXVUkrRlM2NTB2NHNYZXd1NHE0aXlY?=
 =?utf-8?B?SDRKTDQ3QjV5R0lxMTk5a1YrZTJkdEJPNGFKM1N1SlVrWXRadkpYNFhNL2pG?=
 =?utf-8?B?Qjhzb3J6aFBpVnZ6cUdxandVbUxVQW5jS0d4SFgyWlFtR3QrRFU2N0hBTkpy?=
 =?utf-8?B?WHd6Zy9uT3gzd2YwaFhUdFhtUnNPV05ONkxVRThPL2hLUHB6QlA3WEVER2FW?=
 =?utf-8?B?Njk5UEM4eU9kMWpSU1FrS0tONDA2NVNXWXBwZlJleHg5N283NjhoYm80eG5s?=
 =?utf-8?B?a0pIbzZBcXF2RktMRGJJL0xkV1pQUWllKzBVdm9Ob3NJR2pHNEVqbFZzT2Nh?=
 =?utf-8?B?c3gyY1g5cmordGErZi9xQVl1eXZNWENxN29MLzFsMERTYzFjVUVRYTVXVkx6?=
 =?utf-8?B?bFNRV3BFaUZyTWM0Vkk2MzdqQ3RRNjNDb1Y0eXdkNHB5aVZoejJYcnJMY2ZH?=
 =?utf-8?Q?EzNg75qH7zOqM36vlUIJf98=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iEgjIBl10oCuvC41wHhZt1bAyg37qQovpyhsFtF814kI/a5fDV27ovGbfBMEYMKAmLIrpjMdQVPQVT85QGHKg3aTTMGUsrtTEQVxqspdeVGWmOD1lyd4uiQmSeFD7Ou8urWCH01gVjxtOf61etYyk4qb2ev51Q/G/ByU+u4ac/89cehzoOecufvk01QThavHCvIczqRb/oTi2yg/6dhzOpuLPvvk4pAkLvfBFCpZiiLdYMLVG8+8/GhxjMrVpgEhKmEK5vypWJMUQ7rHIclSTobxlmMaJw6kicJFZqtYMtsrcy7Hl6UvdtZfXvXLNHo+F3nlxMBsKZ5nz76MBUNONg4w5A6hl3h0YiD7B8MmFE+d5L3QZalB+zRJfvm6YUX7sahhOg4tjUtHZbAmy8YN6Nb620y2eP0YnI7sks6pM88ysdhMxS0OqNvBxWcCTq4zUSPk0HHiiHM5TPPZeidtxgsNgbd1TS1F787KEWD+MYPJR8gdxBOuwZwOX2Mhm0DHkXwueuDplfnOs62MoME2ztRnQV0SusltsUsAInkUwinXI9HQgZKRutWjbRfENXZ9NUT+jriXMb0iL1bJGJHf5ayQg3oRM+lanUWZ4EJWjyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424cc8a1-2dce-46da-416f-08dcf42bfa33
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 13:01:30.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71nMeGlzW81Lb5qBnYxF8IwOHXFfYZA3r2WM00xjwKjotkH9QB/XNukIZwKabI9GU/rBJdxL5k9PX1zcynxmYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_13,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240107
X-Proofpoint-ORIG-GUID: 3MImzWiP0TO3rsZv2r39m0gneBE3t2dN
X-Proofpoint-GUID: 3MImzWiP0TO3rsZv2r39m0gneBE3t2dN

On 24/10/2024 13:13, Arnaldo Carvalho de Melo wrote:
> 
> On Thu, Oct 24, 2024, 8:26 AM Alan Maguire <alan.maguire@oracle.com
> <mailto:alan.maguire@oracle.com>> wrote:
> 
>     With recent kernel, saw
> 
>       2: Flexible arrays accounting: WARNING: still unsuported
>     BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already
>     with attribute (bpf_kfunc), ignoring
>     WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for
>     bpf_rdonly_cast already with attribute (bpf_kfunc), ignoring
>     Ok
> 
>     Redirect pahole output to avoid seeing the stderr messaging.
> 
> 
> 
> This is something I kinda expect from these tests, now I want to get
> hold of such a vmlinux to understand what's needed to address the warning. 
>  
> Maybe have a quiet mode for testing just what's supported in a released
> version when tested by packagers?
> 
> Maybe not, as knowing that they have a kernel with a feature unsupported
> by pahole may be important and should elicit measures to either get a
> newer version of pahole or disable a still experimental feature in their
> kernel? 
> 
> WDYT?
> 

Good point on the visibility of warnings being useful. We have VERBOSE
already so it seems like having QUIET (implying stderr > /dev/null)
would be easiest to add at this stage rather than having to add multiple
levels to VERBOSE. Maybe QUIET isn't even needed though as the above is
still clearly a test pass, and the messaging doesn't interfere with test
success.

Probably best to drop this one for now anyway..
> 
> 
>     Signed-off -by: Alan Maguire <alan.maguire@oracle.com
>     <mailto:alan.maguire@oracle.com>>
>     ---
>      tests/flexible_arrays.sh | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
>     index 7c21253..e9e3cb0 100755
>     --- a/tests/flexible_arrays.sh
>     +++ b/tests/flexible_arrays.sh
>     @@ -20,7 +20,7 @@ pretty=$(mktemp /tmp/flexible_arrays.data.sh
>     <http://flexible_arrays.data.sh>.XXXXXX.c)
> 
>      echo -n "Flexible arrays accounting: "
> 
>     -for struct in $(pahole -F btf --sizes --
>     with_embedded_flexible_array $vmlinux | cut -f1) ; do
>     +for struct in $(pahole -F btf --sizes --
>     with_embedded_flexible_array $vmlinux 2>/dev/null| cut -f1) ; do
>             pahole $struct > $pretty
> 
>             # We need to check for just one tab before the comment as
>     when expanding unnamed
>     -- 
>     2.43.5
> 

