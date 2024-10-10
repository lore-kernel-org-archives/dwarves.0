Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42319C553
	for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592280; cv=fail; b=R+ZLRPjun7VKTckJuoYTQfldrNYmbSj1MsS9yJYyQBImY+ofXbxTnmU9jq/wfKiekJ3lCeY9nVvn2FQP0qKFlgnCm4KvLQBVC5Mo6KRhIomq2imkk0Wrq6I+cRsysXhRJNpIMIdEBvf/+Kj3QKteJHaZe50vNRfbPZAeLmZBL8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592280; c=relaxed/simple;
	bh=iNiDnTu/ZdMAWpMjRKdQE/9MEbD2UgWo4zHa3TtXJYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kv75f9BHUnq6+7o4p/I6aATTV4S+rFDr1NhylQOQK98PzSM/1UoLrcCm09gEPq8RPZZwq4bXJkDyup2dLS63a0tvKtmUCA3LuaeQRfJf5N5TY66QIjOuFQGhuTC1C2zcgDaRUc0qY1mWPIv15mpF6hogjWG1yfD7rkhXq/mTSaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mUJP/EyJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uygva8bo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mUJP/EyJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uygva8bo"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtcnf009423;
	Thu, 10 Oct 2024 20:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+UQs1RysrLPK0qOpBAAq+X39WURfx/MlNJwc4QdNPx4=; b=
	mUJP/EyJYR1sZPoxKSIL6QuYS279gbSer4eMedQcE6J+PsgIeTPFX4I1JyQ4ekeV
	HzYZrNS48L9YLF6gKa843Kp2EzMRxLH8bRoYP7QY03C6Avz/GSltoiXJE5QUN0ym
	4CC12BxbBwqzRURs7iz6QisMi12Nfxu1P0+ReHNrRTBiEOM0hYkq+Rzr6hNYWP9d
	3azVJ71STOj+xir+WvpKy3G/9Y832YezqItnjcLirr6DgIgNAxoCSaiSEY+GJ32f
	EraHN+JgwfBIbXrDZageBxqtCp2KYeWAj2cMyiDIg0DT1AxcQWj6/ox+HTD9Z5jo
	t61MLiLfumhkzkftRz6IZg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306ekpra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 20:31:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AIrOCm027646;
	Thu, 10 Oct 2024 20:31:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwak8qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 20:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Itci1kwrLzWJ8PkdPVoxTgcttUBy8D4uw39mCqc1+EPIoD5+P0w1G8jcCPYVftRxg204p+GmYlZn6xWXvkZBsvel35Q3PJY3ZUBkJ+rMhv73zeFeXwHcdx5J8cj4HNWEHCsfUuC5SJ99HimbuMVjyelYwxlz5+Vtn1WvRbOBqUr+cIPpRiwNxs+s8DuLVVPzjpcCUyxHZZIkaOEngA2P7bVdrdGEToJV1vZsAlChPbGEc2U9fAgk944KkwZ3muj+GxVSiXsTgQDCxzJiAxEUUgBPbiUU1c6AxTD5lMFLO4hWKpTIDQbB4utWLs3XFtMOs8h8j0L06QUMQ6gNdcHbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UQs1RysrLPK0qOpBAAq+X39WURfx/MlNJwc4QdNPx4=;
 b=sOJfcb4rVQhP2RIfdCByr6T/2fQ3uBHBMJNUZcqBZX7emHv68xeW6VTuZRo7vo8Q8LmT+5nHV1JAf0/NfnMN8IWbHms+PrhqYDNluloB/mE6yjGZrk3ZsdRA1y1b33d1ktjFiKiY5Uie4uNvVw7qxawSVw9FjD5awqVDBB0xp4fnpkN9wqFtGOcwYF3QN6QBvpPjrBMyFxfrCqsbQMWM0hGujaXJ97WwEJroHpyNm0zIlQMz79ALaTjOk/RHE2KbXzJka83A7rzzeIuZyVZqLN7D3CqvkHLdRpaxM5HD0VyWz/AgavbN3wqLE0jglgXEQ22FTdE+b9p9PP30NJ7cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UQs1RysrLPK0qOpBAAq+X39WURfx/MlNJwc4QdNPx4=;
 b=uygva8boWWoK4EuQZXiThl8HrxYdK7JTyTyauf4Av2jCjPZLNzcS9DjP7VEYiyrc6cOclgwKukVAIm4lyZyK+MRaUqblrQOoewKhzGR3+zQs/8CnFVB7hnSafs9aLic3Roj0odQ31f8C8eSXIkaGMsVnAdi9N4DNOS64gsrqCnU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5101.namprd10.prod.outlook.com (2603:10b6:5:3b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 20:31:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 20:31:06 +0000
Message-ID: <af7ca712-7798-4204-9e15-fa2065154699@oracle.com>
Date: Thu, 10 Oct 2024 21:31:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared
 elf_functions table
To: Ihor Solodrai <ihor.solodrai@pm.me>, Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, acme@kernel.org, andrii@kernel.org
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
 <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com>
 <4C0idzPIUJesSQi12dB1SgeTQlGl13N2CCsvjPfdLbvTEemTJoQZ4P-LJcOQqRyM69ZLKVv4mIKDQJvfMYMV2oITse1_uS_m_SjVigh8bL0=@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <4C0idzPIUJesSQi12dB1SgeTQlGl13N2CCsvjPfdLbvTEemTJoQZ4P-LJcOQqRyM69ZLKVv4mIKDQJvfMYMV2oITse1_uS_m_SjVigh8bL0=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0184.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: 9265706c-14eb-4cfd-7d63-08dce96a778c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE40cXpFWWFZQnVNMXlvWDdWRFZHRE9OSzRNLytRYm1hdUxjcWdlVExKUW9j?=
 =?utf-8?B?ME9YN09YSjRZUElzL0x0aCtDQWxyYTQrZW1od09XcGMrY2FaMms0V05Td2Vx?=
 =?utf-8?B?VkFhTHd4aTBMNzA3NUdkcUNSTjlnUnkzNmdPMkRLbU1pc2p3bFBRMlU5NzU5?=
 =?utf-8?B?MHhvZ09JUzJiOGV2b2E3eHlUaklNazlKZFNRM01idmFRN3ZtZkNPbzc0Tm5u?=
 =?utf-8?B?eUE2RXR6VC9JeGx2aUxHdXlSbGtOSHB4VWU5d3VGZDVCekFNaGVYNlo5L0Rp?=
 =?utf-8?B?VXc1NzN0bHRiKzBaQldKT1FPc2lGMkJJMkNWUVAzWnNPdXF0VldvaDAxR1RC?=
 =?utf-8?B?SUxDSjlrbWVjYUZmQS91Q1lWSmtuempMdzV5aXh3ekpPc2J3cGhKY3haKy9w?=
 =?utf-8?B?YU1BUGdBcld6ZWtDMTBiaXd6a29ERU9CQ3RxWVM1dGtEZkxPNXZza3dUZkRY?=
 =?utf-8?B?a1dmeXBxbEF3Mi9vWWZyWDBvKy9hd0Z2eE1XTFhjUiszRkNhTGNkb3Zad09E?=
 =?utf-8?B?QWhIK2oxblZFaUxQS0ltTklIVFd3c2YzZEtKVGw5Q0dHSjh1WVRHZW83Yjdu?=
 =?utf-8?B?cXpYcllXOFVHRDhVaWtvUXhHSytkQVlQT3FQVm1BdmRFSWpkWEFGWkVrdEFM?=
 =?utf-8?B?SjdsZXdGVEFCREYrSlVrWlhlclNNRWJGYS9pOGZzdiszZ256U3dxcW01NDRs?=
 =?utf-8?B?K2x1L0Zsb1BDNlZtaVE3dWJVTnVtYkhDNFVhMnBhVEwxVWw2MytTQ01QMzBV?=
 =?utf-8?B?azcvNXVpSE1kUVRnL2RLSUtIZ1oydVhIaGtEZ1JSaFdEVWFXSCtXWTVTdnlK?=
 =?utf-8?B?bkZjQU0xTWRNKzVYaHQxS3NlakxXeVZoRFhUSUFwbHVhazhzNTBUMHdaaXNG?=
 =?utf-8?B?aUUwRTRobzgxcmYrUHA4UDluQzFKckJEbjJEN28wdm9vdERuYXlKRVhLY3RH?=
 =?utf-8?B?TGwxa3ZUbWxQNnVvc0RudVVGVGg4VG1yeTdaZ0F4SmdQRitCT2tkNjZKVGxL?=
 =?utf-8?B?LzQzSjM5dTI4WEFNaStOMjlMN0FVbTZsRkUyaXRXTkRQaktIcmJvQnFhSEN5?=
 =?utf-8?B?ZVJuTzNwUXp6TW5RNUpXazV0SkJLN085T0FGYzlvTUMxdUJXRnVmMDA5WVBK?=
 =?utf-8?B?MGMrUW5MVTFhQ0x6eUJHT2JKR05ubXNISC9qWGt0Q1JyVzBiL29uOVJRMmIy?=
 =?utf-8?B?c3BvTW8zcG5FZC91Kzh5QUhSMVVqSkFUME9hNHlTaXA0WmZjSlJmcnhuajJQ?=
 =?utf-8?B?M1dlYU9ZVUhFVldmc1cvUVRKQ1RWaGV3bjhKSVNQbEgwMG1FK1UybWNoeWhQ?=
 =?utf-8?B?OW9sSW9jY01tRFUvbGJlcEwvSitheWRBeTJUb2prVWpYeVdLWDFDQW8velBE?=
 =?utf-8?B?c3dHd3M5WXNBZFBVbHJQNnhGQXgyWkZTaERkWVlnSUFTbmxjT1hCVlY1ejFT?=
 =?utf-8?B?T0Y1blc0NnhWTW1ra2FPNCsya0ZxWVFsT3BtaHlHRzd5SStLbzlyL3RQZXpD?=
 =?utf-8?B?VWw0U0RDZnhycVFFYVRwUDZkaWdSZUxZOUR4WW14d3k3OXgyNldJZ3hvNU1s?=
 =?utf-8?B?Q0pWci9KUHpqcS9nYVBJNHErUWdjbU9saUpEU3N6OXhoclRPUG9zRkpVZlNq?=
 =?utf-8?B?ZzRuTklxSU5SbmdpR3ptNG9xODNnc1dKckg2ZjN3Z1pidDg5RVRtZHdZZVRI?=
 =?utf-8?B?dHVPSSsvL2MzWTIyTkp1QXlRLzZWWkd6VmVzTW9hQVYvTGtnM09GbkxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWxOd2JpdHlVUmZUYzJvbEJ0NTFXV2V6VlZxazBkbGdOb2xZeEpEejlveE1X?=
 =?utf-8?B?bDRkUytwbU16L3VIN0pLcEM0bjNFanp0U0pKM1lMeTc3WlFSUnpkM3I5cjJP?=
 =?utf-8?B?VnIyQjQ3WFVuU052Z2luZFZsTmZSck5XZTJmUWVYV2ZKcTVGWm8vdVFFaEti?=
 =?utf-8?B?Um9paW9CUm14R3NkYS9RcW9MVkd0MTdqUmxwQWtwUVRDR2I3QjZraFR4b0w2?=
 =?utf-8?B?Tk82THE5STEwRmtUR0Q1NDhJLzMrZWRZcWdnZUVUdGdzcVVhdkpxLzBERmkv?=
 =?utf-8?B?bGVWUDJ6RTZ5WXV0Y0dPcUR2c0l6R3A3d2lmMGg5YitiUFNDeXFTVzQ0enBv?=
 =?utf-8?B?bjhsbWJTMThtRDY3NnJQRENGTXlHUjZTYWtBWGovQ1VDNGxPTnlJR2xOUGlK?=
 =?utf-8?B?RlV6ZkowOWxHSm53dEdFdE5OUUxRZVhSV0dtR0hpREF4YmhIN1lIMDhIRDVp?=
 =?utf-8?B?eWprMFIrOGlSQ2RpRDkyYW9KMDg0c2ZNQmxrdnUrN21nZE9UOUFyNW0zSWVX?=
 =?utf-8?B?Wm85QktQS1MxUHdLUGkweVdoUHFQTXdEbjhyTWZiMGxFSDBLVzR5cnRaVk11?=
 =?utf-8?B?U0Riamh6M2ptbHc2WXU0Uk1uWGY4b21mMytTQ1d5dEZmcFFDUW5BSUQ2TFBr?=
 =?utf-8?B?WUs3TTJ2UDY3ZkMrQ0plYnRrZ1h3aVVxYVg5NmN6RlBBbllDTzBuVWVUektu?=
 =?utf-8?B?UVk3ZlVOK1VwSU5IYmpsQ3VUV2tiVGQ4OXJ6blUzR0lZeGZ1VURUNWgxUk5Q?=
 =?utf-8?B?WXdMQ1d0cm00Rmo0bjV0Q2s4NFVwSXEwTUlMOWVmS3NEY3NVK2dmQm1LbytM?=
 =?utf-8?B?R25ERExRa1YzTjdqM1F6Zm01V1lkYWVvUm5vcld3dFkzbjUrR2o4aHhRVVJj?=
 =?utf-8?B?b2JGa1hSdmdOZzNubHFkM1NDdkgwSVpZY2owT1lnN3ZVdCtsS3l2L3owM0ZK?=
 =?utf-8?B?Q2hKZ29Wc25LR1pYSXlQQUNtOXhnVU9rN1Y5SFdGY1c0NnFvc2JJR1p6aEhM?=
 =?utf-8?B?R2FaZEt2MkdHMVllT0dXcVhSbGJFa1VHSjh6dHFVSjlPcjZlRXRTTFZvR0lN?=
 =?utf-8?B?WnNkWUExc0Rld1RxaXducnlMMXJrcXl0TytDR3FYaHZtaUUrSnV1MndsTzFT?=
 =?utf-8?B?ekNEVDBHWStzTnpHOGpDYVJCM0M0STMzODZBbVJEYTczV2tqRGNOSUFpRjZt?=
 =?utf-8?B?aVNYTmtXSVc5N0lZZG5ESFZ0OW0zOEVpUUM0d0xhb0NiZlA4Y0ExTEt4MW9E?=
 =?utf-8?B?MitTeVd0Y3ZaY2MzWWlPZGx3VGlHU3pFdVdCVmQyQXpDdW9LLzlpbkFjblZw?=
 =?utf-8?B?YVV6UHdZTWhNSVVOQXRKU1dEQWszdHZ3am5Zd09QUG5kOWxzby95Q2laYU45?=
 =?utf-8?B?UkoycmxNQkkvNWZicG9iUE0rN1Y3U0JIcWVsRERSaHIyYU5CRTBJb2RwYThE?=
 =?utf-8?B?QTNNVDk2QURMK3AzeTBqRFdOT05xUnZ3TVBRakNoSm05ZHo5WTkvYy8zZjkv?=
 =?utf-8?B?RFlsdmhlTFpzTzBna0pEekN5VkVaL0RXWWVhZ083MHFJOW1aY2k2ZkpCTS9x?=
 =?utf-8?B?K2Jzd2c5UnY3NXExa3VESXpvcnlaS2hINE1zRnBub3UxcWNrL05aZFI5elVO?=
 =?utf-8?B?aXFteTJTY1gyM1hSSS9UUU51cFc1WklTNmhKanlqa2srS0dqUmVGczNYdWZY?=
 =?utf-8?B?VTBtTXFaVHB6aGdzSHpBWW1yaVZ1S2VuU242dkxrVVVYelBTcU0xRXd3NFFk?=
 =?utf-8?B?Z1Y4RENLTkVVaDRpUzR0MC9SV3dkRHNBOTh2MmFHb1dLazA4czYvL2xXTGlB?=
 =?utf-8?B?R3hKQzVLZnBtc3d5eDFFVVZQckJGS3N6ZlF3ZFFNK1BYNXZ5TFAxT2J2Rncv?=
 =?utf-8?B?R2VvRFI5WlkxY3RVSXJRN1RwS05QY3lBWGhuYmtCa09jQmdmMWZaK3VLb1U0?=
 =?utf-8?B?RXBDbmVrQVlacGpyTUViNjNwZWQwT2dPTzVzVFVxRTJ3aTY3Tm9iMkdiekhK?=
 =?utf-8?B?NUNtZTJkNmJ4QUs3cGpUbnl5SWxRNVpoRVYrS2p2ZDlzNDVwZXRkRi83ZDU4?=
 =?utf-8?B?UnJDMVI2MDQvQUJjOUZKc2pQcS9sQzhJLzhFY3JMMk82T04wMW1LN3MwWW1P?=
 =?utf-8?B?ZnNQSGNNS0d4Q1Y2blBsM1RQWUowRnh2WXVTNGkwZUVaK0IyeEtUV0pRKysx?=
 =?utf-8?B?dWd0dk1DMUR6M3R5dFJrQkRLQjF5d3pxbkNIU1dVWm1uL3hCK2NsKytXMlZq?=
 =?utf-8?B?NmVWV0phTjloWmhYN25COUdNeGxnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B4jmwxAgaCUv5L6BHtTPFjWwXf2s9lmikwtWnuq7rus+5eHdFsH9TPis7xx0OT5/P87hbibjIXinPLTeJ8qCejlcz/AzfPvzgr3uIiBQn2AOHLVaHk7BZmLHpgePlywb9frUhVeMJy0alTHY9/Zh2JVTCVCX5ysyYZKdMYTVKnA02mtdPlA7VGeCiTMDzfRDBojJQRuOLn8GiYVH4xAotqieaPrE6rOPQcck6m4bmWc/YHvdq0d/0kR0cwdJIZKAEjY4mLKpb5ug8ep5AC/8t58VsENvzpFGvhR7ILXewWXsPxJC1kb2kyc6hLwJVxFNFqElImnBE7AaUIA1PtYfuFCdcyTJ3ym2ZgtHOHizfM5l3zMhFIbw+8t2OmLum4dw393NL0Ohb3CZIsJwYoX5nocS7SwpVUE/g7BnpDpbexEk1yd1X7c5h1eKFZnOQrNIG+XO+w7//4B7O6JKeoDqS7dGNaOvEySVRyjUDQBGS6/x0pKah+V8FFw/Usm5GuCy3HYYUnssTeX/xCZRbj9q4eXUSGHxhfhfOUhbT0Lih0AakHw8OFTYTvQJApFHIfqTJlPQmvhPsFCT3GrfrtmDBdbP2/AKj0ZDGJM4gq6TNDY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9265706c-14eb-4cfd-7d63-08dce96a778c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:31:06.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4NFbufA1g8Lq3fVTMyGrIHCa+h9BTJv+uhPxAJoCpPkhJUOmWFY/L1ojtfDZ7I8OXnFbhhV09UdYvkArVj1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_15,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100134
X-Proofpoint-GUID: FxVf_u25LpgOiYyQcy-7oqf7zkFUQ54P
X-Proofpoint-ORIG-GUID: FxVf_u25LpgOiYyQcy-7oqf7zkFUQ54P

On 10/10/2024 01:36, Ihor Solodrai wrote:
> On Wednesday, October 9th, 2024 at 4:43 PM, Eduard Zingerman <eddyz87@gmail.com> wrote:
> 
> [...]
>>
>> Do you have the performance / memory usage stats for next vs this patch-set?
> 
> Hi Eduard.
> 
> Yes, I ran perf stat, and looked at max memory as reported by
> `/usr/bin/time -v`. The difference is insignificant compared to
> acmel/dwarves:next (a1241b0) [1]. See below.
> 
> In terms of speed I didn't expect an improvement. It might have 
> even gotten worse due to potential encoder threads synchronization
> when accessing elf_functions table. The table is now built once, but
> before the changes it was built once *per thread*.
> 
> As for memory, no difference is a little surprising as we now have one
> table instead of N (where N is number of threads). But more stuff was
> added to elf_function, so I guess it ate all potential gains.
> 
> 
> Performance counter stats for './pahole -J -j8 --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=/dev/null --lang_exclude=rust ~/repo/bpf-dev-docker/linux/.tmp_vmlinux1' (31 runs):
> 
> acmel/dwarves:next
> 
>     68,904,383,016      cycles                                                                  ( +-  0.30% )
> 
>             5.5862 +- 0.0304 seconds time elapsed  ( +-  0.54% )
> 
> vs this patchset
> 
>     68,235,717,886      cycles                                                                  ( +-  0.30% )
> 
>             5.5550 +- 0.0412 seconds time elapsed  ( +-  0.74% )
> 
> Memory on acmel/dwarves:next
>        Maximum resident set size (kbytes): 1392640
>        Maximum resident set size (kbytes): 1394600
>        Maximum resident set size (kbytes): 1393788
> 
> Memory on this patchset:
>        Maximum resident set size (kbytes): 1393564
>        Maximum resident set size (kbytes): 1394840
>        Maximum resident set size (kbytes): 1392348
> 
> [1] https://github.com/acmel/dwarves/commit/a1241b095de948becfed882929dda7c4318e022a
> 
> 

Thanks for these stats! In general, I really like the direction; it also
fits neatly with our future plans around encoding additional info like
function addresses; the previous approach of storing all info via name
matching wasn't ideal for that. I'll try it out and review the changes
tomorrow.

One thing I'm curious about; I presume the above stats are for
single-threaded peak memory utilization, right? If that is correct, how
do things scale as we add threads? I'd assume that since we're now
sharing ELF function info, we should see a drop in peak memory
utilization for nthreads > 1 (as compared to the baseline next code)?

Another thing we're encouraging is running the tests; you can do this
via

vmlinux=/path/2/vmlinux ./tests/tests

Not too many there today, but we're working on growing the set of tests.
If you set VERBOSE=1 too you can get a lot of extra info around function
encoding. One thing I think we should be careful about is to ensure we
get a similar number of functions encoded with these changes as compared
to baseline. I don't see any major reason why we wouldn't, but good to
check regardless. Thanks!

Alan
