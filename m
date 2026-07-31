Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3403AD529;
	Fri, 31 Jul 2026 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502377; cv=fail; b=deP/u/7b2pQ5pL9cmvlIjD/udqx1lQdBVnmV8SD2U001IaK4MBwc8bn2jufELNyk7nR+WT/jjor5zByjgdO0naX3ZV+v2ZW/89EpA/TkraJWIfN21MkfK8TiWxrgedifwLLQIqyIACWiG7zp2nRcVxTu1p8jZPSzPKJWYaAWhBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502377; c=relaxed/simple;
	bh=3T5+KCl+ybeUAIbNgya9KJE8opQc/qIrLb33s4+7kHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6UAsaJE8ATT8vxpnQGbgRR0Dt0PAXId+BJUA27qa2J796SPchyFwdC7KvTAlRMsjLt90GR+jtEz0gZV4+SamPl+Mm4LfSxFbi94c621XsDixmR6kC6yrtlcNLAs+4gGxWoJVdc/nKbpzakuPjbPJIeeYDPerVs7XjUoZF34gxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ns+HCkOr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FPeo20BY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ns+HCkOr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FPeo20BY"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBRoJF1417159;
	Fri, 31 Jul 2026 12:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/VJKp/6DliHsaZHW6CePj9LbqH7kwBVWAJ0bz+SP9AE=; b=
	Ns+HCkOrPtih64HT8q8N4cwVj/Bedde/ahsGpofqNV/CR7ir+nsEJH1KeBrTnY5j
	m3jrpFe/hFQFZ/X2mW86YUGrb8Y4qHZKqDr+57u1CeEfdIgsW5/EGjxSZP3JvQyE
	DDPmsUpjnNIxYmHheHcho7l6kvLIn1lXU/8n8ErIWnNt6UdDK7fklRE12rNGz5Us
	Mr9YbxNp7Q25HHKlVqLHBdIeAopU2WFoQFP55WCfr2t7rsuPUqfs0rRc/irHRby1
	KnKZsvwXDP2N6mq0WcON5vp8cKi3HMhFWzVnYwUSrJgS4HjnC/aEo7Z9SVfhBbFO
	OYWkv7xA82CKwr8Izw87qg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr1dj2qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 12:52:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCo6Lc022369;
	Fri, 31 Jul 2026 12:52:48 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4frtugbchk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 12:52:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzIM4Wztj+2jhcq54uuyFiJzoO3k87VMkBEJPEpHHhPccuNowGubcGqDKRbdSTRqqC3RDgTL80xPthOrChCPPhvKlMDAO+9IhqU6nPx460+WDHkVdrGJUT8598W+UuRkYhil1UwGQYwcKvqdF7IyCEY+0CLLGJOCQuYsSI6YLIlSDg9XxWY+XuBzqKiGdRE70mZpuaH4ThAoHxJSv9b7plsLayZ4OzxY2ia9qMqGXioacWawdN1peytePfz7s4bQZUeUisXfX4aIKUAU3IHAWd9wjdwUDrmgf1QL+hXKspCxMC25BTgyiant4947LIFoWCXJRL3XBRk6GuOVXRovWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VJKp/6DliHsaZHW6CePj9LbqH7kwBVWAJ0bz+SP9AE=;
 b=CeFvakB0S1gbgn3Jl5B9OG2F1rKrOGL66r2/XWBGkYPBESgmtoXaE2+gudixae4TtBDmvtb6jaQ7izgXkjGlVjSGgW5feY6Br8DtyTrJt6Gs+4Za8a4g+PiA7HDsPMKZzI6408Ym/43uy3kB6uqFDmCbss+51sGVeIpjbw33osVKNaRMdvee2x55hsHjnYtm0SYovt95TDAAF+w4RyKU4SvrxGVshOR26faCGd8IZqvldfcthQOCN2XbBEoE1ZZ9pjmBBV2cE0IjA881k+2tomEwyoAzamsn8eUJAXKQbPE2zAZP1w8xOygnRKnRRCfn/R3Tbokuiy5Zvi4kiP6IRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VJKp/6DliHsaZHW6CePj9LbqH7kwBVWAJ0bz+SP9AE=;
 b=FPeo20BYyXESrsI5OwqZnHAIuXlus7+KZxrPS7vRexJpohjhYQZBOcUmKVjZeqvX3u4CThlR3D0ISaqsRGgHIt7GqiBspIvRrIcmUV3webrOKr0dExDWfCFpUrtnlluswvpSpr1g4GBprmqqW+AUUgf2yU01eALOoQ4OfBpME6U=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by EAYPR10MB997951.namprd10.prod.outlook.com (2603:10b6:303:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 12:52:46 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 12:52:46 +0000
Message-ID: <e4926c40-9788-4f3f-991f-6833ade41000@oracle.com>
Date: Fri, 31 Jul 2026 13:52:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES 00/31] pahole: Bug fixes and small improvements
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>
References: <20260729190733.72876-1-acme@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::7) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|EAYPR10MB997951:EE_
X-MS-Office365-Filtering-Correlation-Id: 513699e5-208c-46b7-f073-08deef029dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dYNpuFhd+ZUMjXNbNBPykw3fINKAdrUh6fgMVvUEd+6HmUS6FPxRPT9dYuOrUl0gLA+AaJp7OqseERlG5DGdtc6J8tXt8Di9MW9jlcEhGq+UH/exL+KtcZYQCozXNvN/dxwkDpuWKUFNs7COjoOBtO98YSFAVNkj8uQtpaP7ZNvoZ3KYxyEGvM4hZ1v8o4/mzhnzevkKxpd8QkPyNVuYMLrrQXlRiaPawxxtKNBtor199QGIsanINXtCWm95hncd2Hduy2mPDlLiqtDgf1FT0rvFmOxsWaDMlYkU47CH/OCDHuY6/3ghADjaKDtbP00d0M0+4ydiBLGiLlQ4Sxobi5uRbHJgmEFZ5qa1HdyzhzdADiN+/ZiHxUhUwBfSvmenmPh1Fml2WMEMTGF3uPHmkg3nGa7HuWinMl9T4wnjhT0vjYPIDThnk19D6RReWT+MwMIKx8J+Wkb2PU1JLlRgJhux7rg8/V992hLKiAYfy+MaUmX0ZBU7WxtbaF8wbAF3RVtvktTwEGrz36Y5EKS2gVebVia6Q842hzXX5wYyAZtzrlmdDYDNZ0SUEpnQoucfHaFRQOltvRZiIOkp3b3b4tLpwdaejjM2uhY6xFUSX9nIfGVO9Dvonf5sx9hMWROcWnTp3Km70PhnIE4WeBOt2ezo2ksqXhYK97UT61Kf3H0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHp1ZTY0U0ZhTG5RcXp0OXZMeUh5NmJYOGMvMHhqOEJvb1hndUJYbWlrNktj?=
 =?utf-8?B?cnVXZWVuTVlmL295MXB2enRuUFltVDVhVzVHcE5ZNVlCN0xDSWRDU0IxTDBI?=
 =?utf-8?B?azlFMkZqemNPbXV3QlBsYlR2Z2RzYkxTU0hRSS9zeWdEbmU4UXo0KzJlZ3M4?=
 =?utf-8?B?TTZUQ3FzNlFNK05WMmFlUXpsQURwQU9XaTNZdHBrNW8wL0lZY2dGQ0dWTFZZ?=
 =?utf-8?B?Q1pSL1orb0VvWlQrV1V0UDJnR0syUzlpSG9PSWpHQ092SjZsaHZzSEtxVnQ0?=
 =?utf-8?B?RFdodTVqcUxyQ0lGYk1nb0pCUlZtK3N3em1ZZ0dhUDVtTDZMSE5kLzFWSXhP?=
 =?utf-8?B?YnFEQ0ZiSFVwenpRTUxYQW1adkNOQ2lXMm1wZkpvbEtYMlJVL1MxdzRRdUNx?=
 =?utf-8?B?dndreCtWRTFMcWtCUVYrbnNkcG9BbDFmYzJxT1lqOHl0SEJkend6SlgyT3pl?=
 =?utf-8?B?dUY3UEV5ZWZRN0l4K1hxYkVXS1NQb1dPU2dYRE0wT0ZIOVNIUDBZRXpONnlk?=
 =?utf-8?B?c1dKeFM4ZEd2N2VXTmRrN1Fzc2RpcmdraFlhNk9keHRFSzhoVGNDdUY3aHl3?=
 =?utf-8?B?T0JQektrdmZGc3pDWFNSYllmbE5JOCsyV3UzMGVjK3JHSWkzMllaOGtaU1Y1?=
 =?utf-8?B?TEUyU3Z1dzYrOXAxZ1VuQUFCSEkxSTdUWCtleDgvZ0pUWkJBQURQWGdnUVFZ?=
 =?utf-8?B?ZG9ZYXJVK0x5bXJUYjlBTWVBNDJ6eExQRzJxRnR1a0U5enZtQ09JV2NFOXhI?=
 =?utf-8?B?dnBnanIzU3oxQ2llSFFha2RCM2pwWm8zVzJuV2ZkZ1FCVVMzNHB6bXJuT2ow?=
 =?utf-8?B?WG8rNUhOZjhUMTFnN1AzcGlNWkdWcXI1dHBRZFU3Wmt0U0ladTdMSFQ5cjhy?=
 =?utf-8?B?TWdRSE9Qa2w3dFhMc0Nra3VvdXRlb0R6bHVXOVRtajl4Mk0rSU4ySk5qU2Yw?=
 =?utf-8?B?U2J6YzN5YzBUMHZHTndVN0RodnNJajNralV3U2NxZEZVUUJWcnExdjROS0dh?=
 =?utf-8?B?SlRoNENuVDhJcHo4c29qcTVzQnh0SkR3Rkk5cTQ5NnZ4c083NWVpQjkvZ0No?=
 =?utf-8?B?Tnc4UVlCQTFBK0ttbW52T1RETDI1MUZFdkxaMVliUy8yakk5dTQxNkFGUUsz?=
 =?utf-8?B?MC9JWUQzZ05odTVYakVZbTVjRDdBSkF0bmIyTWZINjlVZTdmalJCbld6WFU0?=
 =?utf-8?B?RXRXSlVadW5XV1VOWmk1dVp6MWJsYWVmS2k4UkJDNHo3eENnOEVaZkRLMDR3?=
 =?utf-8?B?WXFma3pmdjNzck0zTkllVEJWZXEwaTZnMGJhVVlXTHo4ckorakRwbGJtSDBI?=
 =?utf-8?B?SkpFdGp6YkJDdnBmV1hGc1JXdGdtTFpiRU04Qjhrc3loVXo1bHgwWGp4VllE?=
 =?utf-8?B?dk5ZY3pIcG0zMEZCRE1URXNKWjl1bTVKbVcxVjdzN2IyVHRhbUoycTFGamE4?=
 =?utf-8?B?dm5nWTU2RGFhS1gyMHVUY3RYbkZ3MXZCbDJXeVNRVU9aamJxOWFRNjhoWms3?=
 =?utf-8?B?QjlJZEhLRlFiS2RXMkV4eWlhcVdjZmhYTUZuUjJMTlgyYVE0VUVhckxOSlc5?=
 =?utf-8?B?dTYyNnRodEtWNFFuU213dDh0VUxZSmlGNGpDK0dVdjVqODZ6YXpZZm9pK0h1?=
 =?utf-8?B?NVpTZzNSclhMNjVnVHduYU5FNFdYVzNkZFd5bzMvNmo0bUg2NHZNK1pKemE1?=
 =?utf-8?B?RVB0eW5sLzZCSXRNTnhMcG5sWmZSVElpVWZJUCtpdjNvSXR3WW1oRkE1RWhL?=
 =?utf-8?B?NWM3S3E2QVdDWUhkaWhxVWJkemFPdjNKWmRQcnBQaHJvVnB0YXg3VFJkRm9H?=
 =?utf-8?B?TTVUUTMzYXNzSWNKUWJ0RHNqQlQwREY1bTRKOGJ3Uy80dHJXdVB2aWtXNlRy?=
 =?utf-8?B?K0lpME8yRmZwWGtTa2VGa3dCbTMxVkxNN1p4ekptUHNnemxXWk1GV3pSMHJ1?=
 =?utf-8?B?ZmYyS1BNN2VzOHRleFlMbEttcFVMeUdpRzNPSFBxL1graXNqeW0vcUFiQ0lF?=
 =?utf-8?B?QSsvWDRhWnNpOVJwdjl4OFBCRDdRUlRKRjNjMm5USXRnd1h6NUxRdHVTNy9i?=
 =?utf-8?B?Y1d3Z2tyWi84ZmV1cU5obG92ZVRUV3N5alJ0MVNER1JTSGlyeUlISHJDUmJu?=
 =?utf-8?B?WkprdGRRcjBWMnJXN1VvUExGZUZobmwrQmt4OHVmTWw3WVVtVnQwN0NjWXJX?=
 =?utf-8?B?YnBFM0dhUGhBU25QVGkvTWxLMGFBNDVjRERMdCtNTTcrbTUvWnRvcFloQWl0?=
 =?utf-8?B?VmZxYTg4T1p2WDJzSzN1aHpVOS9YdkZmc1ZhSUhDVDY1Zk9qV01XeXlPSTVm?=
 =?utf-8?B?YTk2K21mdXVLcnpONlAra1doWU9JNmVUODVMN0FvdUtFRU1aY3N5QT09?=
X-Exchange-RoutingPolicyChecked:
	Fgob1cGOFWtNglDAo4vWab2bqiPNbNJqt/mKBgWHFlX5N78DF90HozWpqu1Hsry+6M4whhcbD4NZX1zwXPOKXFfuupRCHCa4VNGCElbspHW5YJLlM3ku+s0J0i93BHvkg6wyY6o22ltKAFfio9Cvu78ODRD8pKSri3NLP63nfOTDy+R9C5vZAeepuN7UogT/UrNzAKy7DGJ+UPyxdkWhZwy6yERVYESNHPFQCZjLEsdYIUePPisvzQSrpw7zKLAND2DJ1cREwksSgMXJoZFB5Hu5bNo4OcRJc0AFVN/5hfOiD14qUwGy5mdXm84f+ZDE8bayMntfXyxZm/ELGuWWYQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d0pWFjx2VVOTXH3FPsgoLmA9jf/q4Bo53eqazQVrUpBe8EwRjA9VoKAtw/pbY9zbX1wh399Rc2KZGrxefV5bQrECZTylFPp2StPo7qo79GrFdZk3ll4+D/x1CFzh8b2Wtq1Zb5e89+b2jIYbXi6a6O5hJzkPUlOtGv3Vhpv0MCgxsxP/YUVK8cnq2DCJHKWTrJwRZF+ZXiKA0ka3o8Hzde/rE7VZ786wIp8VUmRpmsAJdj4Sw0UG9ZY2PZ2xrJ5jKjoj2lkIfjyhyG4h45ObINBxUeb1nWSk/HYCfPo4HB07D0A313PMOK5h9Fh53jBveg8nHrbBWGvuVTb3E4he/rOHZmQ0zGZ7wi3VC+z8dDlk1F+2nDVzvkX+0aXVC1r2RKvD79V6gU4lZMpi9qsti7JbGVdL+ss6H9NJKFSPRd7JWCqPeEHwcHGVklNTikAgN770iKFodwUkGIyQqj7NpffUBYCxUkSwh3bXA1m/sOvhx5bbH6ETZdCVfaH5jFP1J8zN4jE/9+o90X7mhBACuIMOZjq+zkF1IcGuGdulFOD0qAGq9CyoYBVcU9TBAWfH/TKB6YhSmwntF3hiG0DAUuLLZuhYhFcqnQX/vGHUNt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513699e5-208c-46b7-f073-08deef029dd2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 12:52:45.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDCSg7Znkr+8rtfeYp1ggihjWsX+piNDiY/Y9PHh4Br7MNsMZfgqW5x6IPyeZ8uieM7PcdtPNV6qllWRXWBM0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310097
X-Proofpoint-GUID: 352luTfHyW0CeSkVYWM3Rvcf9M7jsixf
X-Authority-Analysis: v=2.4 cv=Y8fIdBeN c=1 sm=1 tr=0 ts=6a6c9aa0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=l4zvCnRYZ4CIvERGq2UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NyBTYWx0ZWRfX8smcV9tmWRbo
 cZiTJii56UXw/7hCmQtrRlVRNM2eKRHJr2jzxGpmyDlVp7+2SziK8Svx5hI10Yp1RBCleh7NqMC
 gJA45Y83+NSsv0HegRcQ9KYXbp7L0z7Au7TWjVJ8ILOf4TK1MKOx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NyBTYWx0ZWRfX05fX/MLgKEd9
 EICFixKsuREsuZfEEfLSUeNleZstP6iYZqjC2zXS4Li+eZ5bOO9CGnSFQtGLK4ewS8QlVIvgVnC
 ftWL+x2n6RSgQl30fH8KNBwkslAn/dNB3c+5Ndbl9xCLKFzu87r+lmuen75fJa37OTsQwhso+SK
 say6HE5yeEB6+x5Avjc1utsObkRtdOj4wmhRKykimh8PdJ6It4Y8ciZdlCv038shXlvbvQ2reWQ
 vcgbsAKywW5N2S2ehM6khNo+GfWGAvvnNz7CCR1nFT+8akONdTISpqcVMlAThVYmVRCzzpy8Uul
 EnwkS2QAj1bPp+sujIDpk/fRK86b4q1W+tLslUF3U3yMNrj1le99OwPE3F/3MDm3E1wCVQih/C2
 wRhrm61gRGjkmaW/guXyk1HxdcMCFbVMNAWYjq7N7QoJYCWswAblt1pwYoCvSADtoffQbZm6/ta
 0s5gkkUCuVdC9X5figQ==
X-Proofpoint-ORIG-GUID: 352luTfHyW0CeSkVYWM3Rvcf9M7jsixf

On 29/07/2026 20:07, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Here are 31 patches fixing pre-existing bugs found via coverage
> analysis, AI-assisted review (sashiko), and manual testing. No new
> features.
> 
> Critical kernel build path fix:
>   Multi-dimensional arrays (e.g. int[2][3]) were incorrectly collapsed
>   into flat arrays (int[6]) in BTF encoding. The encoder wrote only
>   the total element count; the loader read only the first dimension.
>   Both now preserve the full dimension chain using chained
>   BTF_KIND_ARRAY nodes, matching bpftool and kernel verifier format.
> 
>   Before: pahole -F btf showed int a[3][4] as int a[12]
>   After:  int a[2][3][4] encodes as three chained BTF_KIND_ARRAY nodes
>           and round-trips correctly
> 
> Bug fixes found via coverage analysis:
>   - Fix interior pointer free and missing NULL check in btf_encoder
>   - Fix missing list head initialization in type__clone_members
>   - Fix instance memory leak on 14 early returns in
>     prototype__stdio_fprintf_value
>   - Fix error path resource leaks in ctf_loader and libctf
>   - Fix early cleanup crashes in btf_encoder__new/delete
>   - Fix dangling stack pointer: allocate type_dcu via dwarf_cu__new
>   - Fix annotation failure leaks in variable and typedef creation
>   - Fix --errno typo that decrements instead of negating
>   - Fix heap buffer overflow in languages__parse realloc
>   - Fix parse_btf_features("all") being a silent no-op
>   - Fix --fixup_silly_bitfields condition check
>   - Fix data race in tag__init() decl_file string cache
>   - Fix variable shadowing in __cus__find_struct_by_name
>   - Fix phantom holes when class__find_holes ran before byte sizes
>     were cached (eliminates 36 false "BRAIN FART ALERT" on Firefox)
>   - Add elf_strptr NULL checks and fix kfunc bounds in btf_encoder
>   - Use btf_encoder__tag_type() for all type ID computations
> 
> Other improvements:
>   - Fix -Wsign-compare warnings across the codebase
>   - cmake: Update minimum required version from 3.5 to 3.10
>   - Skip inline expansions during BTF encoding (performance)
>   - Use fseek for seekable files in --prettify and --seek_bytes
>   - Guard pipe_seek() against negative offsets
>   - Fall back to GNU objcopy when llvm-objcopy is not available
>   - Add exec_objcopy() shell-injection-safe helper
>   - Skip libdw__lock when elfutils >= 0.194 is built thread-safe
>   - Replace stale FIXME/XXX comments with explanations
>   - Remove 11 dead functions found via coverage analysis
>   - Mark file-local functions as static
> 
> There are several other series that will result in way more coverage
> and regression tests and will add support for more rust DWARF tags,
> DWARF partial units that will allow us to build the kernel with most
> of the CONFIG_DEBUG_ DWARF options (DWARF5, etc), only split DWARF
> (skeletons) is left for after these series are applied.
> 
> The end result for tests/tests is this, that runs in parallel and mimics
> the 'perf test' output:
> 
> ⬢ [acme@toolbx pahole]$ ./build-and-test-cmd.sh
> <SNIP>
> Testing pahole version:
>   v1.31-215-gcd4504f549af6fe7
> 
> Verbose mode enabled - showing diagnostic information:
>   Architecture: x86_64
>   CPUs: 32
>   Memory: 60.4 GB
>   Swap: 8.0 GB
>   Parallelism: unlimited (all tests run in parallel)
>     Tip: On low-memory systems, use -j to limit parallelism (e.g., -j 4 or -j 1)
>   Test artifacts: /tmp/pahole-tests/
>   Compiler: gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2)
>   libc: ldd (GNU libc) 2.43
>   bpftool: bpftool v7.6.0
>   VMLINUX: not set
>   PERF_BIN: not set
>   PERF_SRC_DIR: not set
> 
>   1: dwarves_emit.c: _Atomic type compile emission.                     : Ok
>   2: _Atomic type display and --skip_emitting_atomic_typedefs.          : Ok
>   3: Auxiliary tools: pglobal, prefcnt, dtagnames.                      : Ok
>   4: Bitfield layout and data member filtering.                         : Ok
>   5: dwarf_loader coverage: bitfields, templates, enums, inlines.       : Ok
>   6: Bitfield typedef recoding (tag__recode_dwarf_bitfield).            : Ok
>   7: DW_FORM_block byte order conversion.                               : Skip
>   8: BTF arena type tag encoding for kfuncs.                            : Ok
>   9: BTF multi-dimensional array encoding and round-trip.               : Ok
>  10: BTF bitfield encoding and loading round-trip.                      : Ok
>  11: BTF VAR and DATASEC encoding for global variables.                 : Ok
>  12: BTF deduplication of array types across CUs.                       : Ok
>  13: Distilled base BTF generation.                                     : Skip
>  14: BTF encoding options.                                              : Ok
>  15: BTF encoder coverage.                                              : Ok
>  16: BTF encoder comprehensive feature coverage.                        : Ok
>  17: BTF_KIND_FWD encoding and loading round-trip.                      : Ok
>  18: BTF encoding with invalid symbol names.                            : Ok
>  21: BTF FLOAT and ENUM64 type encoding.                                : Ok
>  22: Check BTF type tag order.                                          : Ok
>  23: BTF encoder verbose logging coverage.                              : Ok
>  24: BTF encoding into ELF via pahole -J (btf_encoder__write_elf).      : Ok
>  25: BTF true_signature: clang optimized aggregate parameters (2 structs: Ok
>  26: BTF true_signature: clang optimized aggregate parameters (2 structs: Ok
>  27: BTF true_signature: clang optimized with large union parameter     : Ok
>  28: BTF true_signature: clang optimized parameters (scalar)            : Ok
>  29: BTF true_signature: clang optimized with stack parameters (9 params: Ok
>  30: BTF true_signature: clang optimized with stack parameters (non-stat: Ok
>  31: Class name list from file.                                         : Ok
>  32: CLI display and filtering options.                                 : Ok
>  33: codiff struct comparison.                                          : Ok
>  34: codiff coverage: terse, functions, verbose, multi-CU.              : Ok
>  35: codiff member change coverage.                                     : Ok
>  36: codiff multi-CU: __cus__find_cu_by_name coverage.                  : Ok
>  37: codiff --terse (-t) type change reporting.                         : Ok
>  38: Compile emission pipeline.                                         : Ok
>  39: Compilable output and type filtering.                              : Ok
>  40: Recursive container search and verbose counts.                     : Ok
>  41: Type containment and pointer search.                               : Ok
>  42: C++ advanced DWARF tag coverage.                                   : Ok
>  43: C++ cleanup: delete_tags coverage for lexblock, parameter packs.   : Ok
>  44: C++ inheritance and namespace printing.                            : Ok
>  45: C++ value parameter pack and shadow definition disambiguation.     : Ok
>  46: C++ namespace and using-declaration display.                       : Ok
>  47: C++ variadic template parameter pack handling.                     : Ok
>  48: C++ template pretty printing round-trip.                           : Ok
>  49: C++ template template parameter pretty printing round-trip.        : Ok
>  51: Class name filtering.                                              : Ok
>  52: Default BTF on a system without BTF.                               : Ok
>  53: Display format options.                                            : Ok
>  54: dwarf_loader.c edge cases: bitfield recode, inlining, call sites.  : Ok
>  55: dwarves.c core API coverage.                                       : Ok
>  56: DWZ alternate debug file type resolution.                          : Ok
>  57: Legacy atomic_ base type emission via --compile (hand-crafted DWARF: Ok
>  58: Atomic typedef emission.                                           : Ok
>  59: dwarves_emit.c / dwarves_reorganize.c coverage.                    : Ok
>  60: DW_TAG_atomic_type member handling via --compile.                  : Ok
>  61: Type emission (--compile) and atomic typedefs.                     : Ok
>  62: Enumerator search.                                                 : Ok
>  63: Expand pointers option.                                            : Ok
>  64: Type expansion and anonymous struct options.                       : Ok
>  65: Flexible arrays accounting.                                        : Ok
>  66: dwarves_fprintf.c coverage: fn-ptr members, labels, C++ types.     : Ok
>  67: Validation of GCC optimized parameters in default BTF.             : Ok
>  68: Validation of BTF encoding of true_signatures.                     : Skip (no optimizations applied.)
>  69: Compare parallel vs merged CU loading for inter-CU type references.: Ok
>  70: Multi-file loading (cus__load_files).                              : Ok
>  71: Version output.                                                    : Ok
>  72: Struct packing and reorganization.                                 : Ok
>  73: pahole coverage: sort, word_size unions, prettify bitfields.       : Ok
>  74: Format coverage: count, skip, structs, hex, contains, first_obj_onl: Ok
>  75: Header, range and seek_bytes prettify paths.                       : Ok
>  76: pahole.c scattered option paths.                                   : Ok
>  77: pdwtags DWARF tag display.                                         : Ok
>  78: Check that pfunct can print btf_decl_tags read from BTF.           : Ok
>  79: pfunct --class and --expand_types.                                 : Ok
>  80: pfunct coverage: symtab, class, expand_types, compile.             : Ok
>  81: pfunct function statistics.                                        : Ok
>  82: pglobal basic: variables, functions, static exclusion.             : Ok
>  83: prefcnt.c: reference counting coverage.                            : Ok
>  84: prettify_bitfield                                                  : Ok
>  85: Pretty printing of files using DWARF type information.             : Ok
>  86: Prototype expression parsing and prettify.                         : Ok
>  87: Cacheline boundary display with large structs.                     : Ok
>  88: Sizes and holes display.                                           : Ok
>  89: Small files coverage: elf_symtab, gobuffer, dutil, pglobal.        : Ok
>  90: Sort with multi-CU deduplication.                                  : Ok
>  91: Sort output and separator.                                         : Ok
>  92: Statistics and filtering options.                                  : Ok
>  93: Typedef chain display.                                             : Ok
>  94: Word size LP resizing.                                             : Ok
>  95: Union word_size resize and packable hex.                           : Ok
>  96: Validation of BTF encoding of functions.                           : Ok
>  50: ctracer: struct method tracing generation.                         : Ok
>  20: Split BTF encoding (vmlinux base + kernel module).                 : Ok
>  19: BTF encoding with kernel vmlinux.                                  : Ok
>  98: Parallel reproducible DWARF Loading/Serial BTF encoding.           : Ok
>  97: BTF encoding on vmlinux.                                           : Ok
> Saved timing data to .test-times (98 tests)
> 
> ⬢ [acme@toolbx pahole]$
> 
> Cheers,
> 
> - Arnaldo

Series applied, thanks!

Alan
