Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627711A4E9D
	for <dwarves@vger.kernel.org>; Tue,  3 Sep 2024 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358055; cv=fail; b=YGC9rJh1Q3+xisEL7+D1epx42wXrAjri0HFNdquFs/TbZXB3OJhcHk9TPsvd1rX1CYJTIZLWlQHPYxUkYy3M7bPlOWI/fmkg/MN6wAPuDGAjt20N4fDKboEbSx5/wd23qZh4xvgaNaOncRB+/dJIfV71lxC/A3+u54aYrp2f2KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358055; c=relaxed/simple;
	bh=lcB25fwP8D9kI1NzZIXiZ36DeH7zalAL/iZbVnuYCeo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=liCqa7/3YIcnJsvQEkRCdIiDX8q/NGGmNXExTlqEsrIlJycOYhghL3aVpEhuBvMzw5O8V8E6DDfe8ci59yuLFiCNCE5yalgS9fZo3V2Hgxb3tYXph7OQ98aIX5Fj00bhnIx0FmSz9isqOihI3SGueCvTsU7wn5CpBHmqSiVqYOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dOBwusJo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vfMlhg/u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dOBwusJo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vfMlhg/u"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fVMZ007225;
	Tue, 3 Sep 2024 10:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Xvr3rx9xT2QXSGwyYpkI1GJEUVAJnITF8VehsS2xR+o=; b=
	dOBwusJo2lqsyVRAaYDi2JLUYyha7JR70oiYIAMxmXWikn+dQDDJSYj5sYDyd0Xz
	/TQd9oUr5p28lW7te6RVdEnu51ZVJUF95uOljnV5tdj5TrBT6fzNky8uRMFvVcy4
	vTD05wo4YrdJ3LUFZjhXIGh9PmSoKNrtFt8CqfsGGYVskzwKbbyrmcBI8Svziqii
	cMKRqEYQGZq5LFkzGFfXckEDpZnQP63EHTuvtqwOjum6fqYcCxFYjfNWj7YWKa5o
	ots9nwaJYl+dC4Nh6MN59oV0g7negz31D2TLoWzDPW8hkh9+x9OoXWMJ+ecx1uWH
	u49buFg1BsWLULVn6JBs5A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dk84h5wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 10:07:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48381ITa018410;
	Tue, 3 Sep 2024 10:07:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmegu9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 10:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctW54QCv25xsh6JoC/8p0DdQdqhrfFowEJQoc5k1F9e5AIsYhn6V7l9jUG29f2wg364KVRjICUwUlVrAqSN5uCCviazbgnw4Z1TT4yv0mRzxJZvNFbaS1XYWdGC8B8JNiXcOU9h0UOrPc7ER7li5BJptEnz6s/hrvZer4mnbOma7oaFSXJQ7FQM05KFuroJ1I0fmLRnZDRly9HUYuT0cOYcFBO6rSLQ6OAS/OW0ribuU3XNjN4nlP/a+9Cy1AFcBanx4xdzx0Dk7yI9osLAdllUibvLBjhwiv2TLr6KpNVIAGNMUKqrUDoidyA2iR2Yt+EYjdgxBJAihLmM3Eg4keQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvr3rx9xT2QXSGwyYpkI1GJEUVAJnITF8VehsS2xR+o=;
 b=iLbiujS0wo++YKEFSN6f3m/sn/1uiVSSOaOa1QqGtHdZz18X/EBMeDg62QYN2PAwybQ63aEeS2VFXFlZ4JEZ9siMN3L262pyrNVKjPbBg91KQ+aP/Vf4IC+0/OgwdXjmLV/2p1EKg6m0wx1Ti7hbZSUg70moQgSc+YXYJesuN0sHvkHmvu1aV/uw6KWLsSrDD+vD5MZ7UISp5YOsDzwYfEfkfsBGxleHbWqPdfB2dqokfF/cO1hYnd5UjW4dAoF4pwcTGLyy3IxXl1zHJ6l/aLFMVoNPszv4yTGMNU1abXkkxY8k+hAXhnDtq2LWaX+SyO9lBfY4w0nEcrWlywb0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvr3rx9xT2QXSGwyYpkI1GJEUVAJnITF8VehsS2xR+o=;
 b=vfMlhg/uiHzP51XmqUCItm27X0M/MK80y1Y+t5Uxq7EGrth09rYFIMpeEUzlo9ED3HGhM+AVMdGyXlm7BGXwgv/JiHGldfv7wadwfFG7UQucEbNpL5eIMnwMFT8EHS/iDDvAYqY0RrOYl6XFCtOhVIfWBydsT7wippm5/0E7nZQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6347.namprd10.prod.outlook.com (2603:10b6:303:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 10:07:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 10:07:12 +0000
Message-ID: <b9a5e324-8a22-4232-91e2-9b0b101b160d@oracle.com>
Date: Tue, 3 Sep 2024 11:07:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dwarf_loader: Fix memleaks in creating cus
To: Viktor Malik <vmalik@redhat.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org
References: <20240903062352.763644-1-vmalik@redhat.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240903062352.763644-1-vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:205:1::44) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: bf15153c-1da3-4436-d570-08dccc002e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEp5ME41WlRNK3dFLzNhcXI1K3M0VzQ4NXpuNmV5dndtenR1U0cvRUtITmJY?=
 =?utf-8?B?SE5odXJsUDdhbFBZUVFEOEJSRml6Y0dhckJ4cEdZUmdNUjVXcVlHRUdEUWJH?=
 =?utf-8?B?eTlpYk11bklJOUw4VldPK0FWZkRubVhJaEkzLzQyRk10bUpFd3lJUFQxenF1?=
 =?utf-8?B?aE9YRXR0WXVPUmhIdGNiT3V5NTJxKy93V0xzOXZydk5BNUZ0K0tKZUZsUWFh?=
 =?utf-8?B?RHVWdjNCenc3R1JpTE5PMTNaN1J5K1MybEp0dC9ENWtzQk51SzZCT003WTh3?=
 =?utf-8?B?QmJhQm56LzcxV3Y4NCtHTU1ROU5sQno3VzBBTHlpVkw4MG4xTDMrREJaempL?=
 =?utf-8?B?V0E5d0dnNCs2dk5LaXBxQVVheWVQTUxHT3JTbmZjUG9ldEtGSkxKeUpFN2sr?=
 =?utf-8?B?dHJEM2trMEhvVjJjNkw2bkcxcnJ5cjhkR0drMlNDeXE3UU5XM25wS2wvWjFu?=
 =?utf-8?B?QzNORDFOQzV6cHpEV3YwelRUMlRwTlNFeGpWTXA5WTFZTndNMmxoc1VPM2Y0?=
 =?utf-8?B?bDhJSWR6aVc2cFN2cTQ0SnoveS9CTkNyMEVJNmN4WnFKVlQ0QTRwUGZwUWNQ?=
 =?utf-8?B?UmFTTC92aEg3MDBHeHdDYnB4MGkxV2llYUFYQWt4eGl6S1Y0b1JxVmhBL202?=
 =?utf-8?B?QTUrbHR6K1Y1MEh0Mng4ZElBTUZBY1VNQ0Q5aVlKdmhBakNldE91QWFrUU84?=
 =?utf-8?B?ekYyUG50d0M1cDE3QlJ6azFSN1V2aWtXUkY0L0RBSnZWSUlYSEFjRDNCZ2N2?=
 =?utf-8?B?NXhkcGxZWitOY0ovb1BEUXJPdUY0anJjVzZLWjVPTytFYVpJcFEvT1U0Nllh?=
 =?utf-8?B?UWMwMy9UZ1krbmZvMjFXRDBVTkI5Y1VxN2pNTytTYWhiS3hRS3haZFIwUkpS?=
 =?utf-8?B?NytmMkJxbnBpQjJ6Wmk3QlMrZmRvRjRDOVVNeXBTYkErZmJiTWVwRlp2ak5N?=
 =?utf-8?B?cmxRU1d5VVhyeTFYdnk2eXFLR2l1T3N2VTF6SUFtbWZ0SXllS3FYN2dhZmVa?=
 =?utf-8?B?NWlKWWgvd0dPTit2eGwwcGZYRDFpd0tvOEI5K0JaajRSQ2ovaGpRUElOTHdL?=
 =?utf-8?B?ZVVmenN2QVo2MkNoR2llY3VwRnBhVG9JalI3Y3dUTE8vM0hzRXNGMHBXaEVK?=
 =?utf-8?B?UTZyeTUvRVJQaDZkdHBXZStGZW9NRG40YmIveWswdUFKUjB3RXh6WkJqUjI1?=
 =?utf-8?B?ZU9ob1cwa254eHo0VzZBdWdXZitTWEhCaWhUU3NwajlKMFFWL055amFrd1VN?=
 =?utf-8?B?QlgzSFF3U0N6S2NkLzRTRVdSMXRZUXlXSm4ycWhnOHhRbEI2amZjUmtrMGg1?=
 =?utf-8?B?OUo0cUIveHlTZ0JNSW1HNnN3MVZScUtCTkMwc0ppeXAveWRhcmtKRk1sK3Js?=
 =?utf-8?B?SDBiQ2R4Z3RsRWlkdVV4eTNLL2pONFY1L2YrVmZlTHNTTUl6WDhjTVdTMlFG?=
 =?utf-8?B?Q0NaTkNqaVBjU3FpMGJEc1lBSVZHaWlKV09jdTJlMDU2NVMxYnRvT0JvYTlU?=
 =?utf-8?B?M0JxOGtPTlRuZEUwNThEWTNYZisxV0hQQ3k2K241TDRheG9PVFc1T3Mvb08r?=
 =?utf-8?B?UXdhT0N2cTZVVUxndE0wWVp5Y1Z0YmF4VXpmREQ2V21aSFV5WnpKakROVkFL?=
 =?utf-8?B?K0lCZzBsZUNaTHZ1N2c1eXFzbXpGM1FESHBmQWZaQ0Y2Uk4rTXZwdWtySnJX?=
 =?utf-8?B?NVdDdE9rYW5sbk1oOE9COHRzWFBtQlZ3bzM0cFdhQTlNekdTWUtwSFlTOG1X?=
 =?utf-8?B?RG1uU1llZUFHOXFndFRIWGZ4ZmxZZi9HUzZFUHYra084em8xdEV1SU00RVFP?=
 =?utf-8?B?dEJ3aVNNcnJjQ05wYUhEUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDAzOGxDWVRna2xucm9hQjdrM0tYYVlPdXpUb1phTkxBaDhVV2diQXpmRkIz?=
 =?utf-8?B?RUU3OGw0a2RHN0FTYVFJUklZanpFMDlUZ3NPa1Vtek80c0x3aXlnaWQ0dlJn?=
 =?utf-8?B?SG5ESW0rS284WDVQTmVLT293M29TVGFkQW1xZUEyT2krYlFrK1cwekM1VExu?=
 =?utf-8?B?L0NEWWMxWE8xUkMwaW12WWdTSEQ3amtXam9XamdDMDJUTzFDNGxRbDcxRHgw?=
 =?utf-8?B?a2k1dmlwUmZJWU9LMWthaWN1czNrNXV1UUhNZVhjcGt5Rkxwcis4alY0b1Vl?=
 =?utf-8?B?UGhPTkJ6amd1OHRnaVhUMWE1dVIvWDNKN3Z2S000ZHR2ZFYwQzBld1ZaMm44?=
 =?utf-8?B?bkVQUTZVR2Yxc1JFU3ZObk1zWVZnMHhsWTA2M0Fnd1F5RER6SXdpWTVKSk1h?=
 =?utf-8?B?cGs5QXV4Ymx2d0RQVElZaDhNZDRhTzRkQkJ1bndaRkh3MWpBQ0toaXBjbk15?=
 =?utf-8?B?Y3ZGOHVvQjFvQVpDeG55ZEZRQ3hIeTNwUnVLSkcxZ0FFN2lFUzlsQnR4Sm5h?=
 =?utf-8?B?T3JOTmN6SWR5bUlwQ21mSHlVWUNjTVhuTFdONkVRb1RxR3ZuckNrUEZ5YWxv?=
 =?utf-8?B?UitPOXZLT1ZKbUV5V3ZuWnRMK0YzeUhGZVhIODYzMWhmZ2Vrd0YzRUVwTnpU?=
 =?utf-8?B?Z3JQMXlPVjIzRmRJSlp3ZGNBNU5jTnpCdkUvaFkwcFB4Rm44TVZMRnhrUkRj?=
 =?utf-8?B?SDdrVWMvdC9hbWllK09nNGFqTm1NQitGUzRCanh6ZzAwdVE5Z01QZDlKTlVS?=
 =?utf-8?B?SURLWUM4eGJDRVlYRGVrcmt3ZFRBUG5NZEFXdkdTMUd3blBYbk1tNmdSWThU?=
 =?utf-8?B?emNJN0cyd09QWGNjTVdONXZMR3RXVTRDSStTcVBLN1k0a3ZuTGhFcjAxWTh6?=
 =?utf-8?B?SGp3K0FBa09EOUVtdjRoWW9xTmx4a0hxR2N1RDdrQk14WEFOOGlBYmNFbWxU?=
 =?utf-8?B?VWllbmlIOU1ueEF6SnE3NTFtOVo0VFpTeXVmT2tTcW55bWlGWWJPUGE4VVVU?=
 =?utf-8?B?NlZpWVYzSFVkcXZiMGhpM1h4YkRuM3NLSUlKaTkrUWtZTDRrdFRrd3FDUDVH?=
 =?utf-8?B?ZFhQcldHTk40aERGTVlnK1d0ZjNLVE05aFduK3I2YXE0eEtwUXFXY20rMDR0?=
 =?utf-8?B?b09iT0t0K0lSUWlLYnR4OG54NmZHckdvbEh2bjZOalEwd0lFNHdldy80RzhG?=
 =?utf-8?B?a09QdG5FckFyVGdRc2xOYkRsbksrL0ZVM0ZyakhFOE5BQnZNUDNJV2FoVy9Q?=
 =?utf-8?B?Zmc0QXFwVFJwMjVsOUZWRnliU0w1ZitlOUlCOVlGd2hsazNMOTZWTElQc09k?=
 =?utf-8?B?Qk9qNlVnY2pkQWRtRDlBVlViUXNpUDVseFVrQ1NmTGx6QmZPQXhHL1FsRDd4?=
 =?utf-8?B?bHc4bjZ1czFQcXk4VmEzOEgyRVFDRG51aXA3WE5wSVBDMzlYenJNTTBiTHZ0?=
 =?utf-8?B?TkVjalpFNm4yZ3RZcHpTM1RhWjg2dFBBd3habzdYRnN4enYyVysyeUtkQzRo?=
 =?utf-8?B?cnUrUG5wczNVRzJSRVNsUDMvMHdhb2RaVjY2US9pUEZLQWFlUmhFS3JXQWEr?=
 =?utf-8?B?ZlhJZTJwTVYvY1BsZ2RVQ0R3d3hIWHZaSmlQQm9BTnN5RWFWZTZMZnN1blhY?=
 =?utf-8?B?VEdQM1pvWVhxQmt0SVdSRVRKUzlWRG5NaCs0SmRMK1FTdDJyZmxpZldiOFhq?=
 =?utf-8?B?N2ozVjVEZS96dnpObHlHM1FnbVkrRzRWQ3Ftam5RSldIdVQ2Q2tSWjBJeS9k?=
 =?utf-8?B?YjZ5eTNtWG1JM1VuZHYzbTdFdFpEbjJIQ0FWbzkwOHgrR1JzdE9TblRSS0RI?=
 =?utf-8?B?S3lyd215RFlyaEx2M0ppMkZZMkxpUzNlbU1XbDBIZ1RvRkNFczNtV1NSVVV0?=
 =?utf-8?B?cW9TZlhwVEdkQ09XSFlYT0o2cTRXcHhuOFZZRnFOUmhBQXEzWnRFc0s0Q25I?=
 =?utf-8?B?ZEsrM21LSHEzUWYrOU5PYmppRTBqdkIyenJUU2g5V2h3QUI2bGhyVDgvUTNM?=
 =?utf-8?B?SU1KRzc5dElHMWh5RW9tSGo2b1VWSnNGVmJJWHNkMHhvcVBEQkE2eTlKZ2sr?=
 =?utf-8?B?U2ovWDdteThWOFppV3hESDM5UGFvVThmLyttS0xHRTVFNU5GRmV5M0NwalQ5?=
 =?utf-8?B?Z09QTzlwMEQ3bkJNOHliZkFhZEZDaWx0NjNmTWUvQ2lrSnEya3BzdFQ0dmpM?=
 =?utf-8?Q?x2PQzoVnVnUvUhM438xBUQ4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YeQ62ziDCMVkrFDv8vPzh0Gjly0gz9dvn33VjwsZXb81aZ1iL4z+h07dj6XidFpFIzEsvFGPV7U4LHM8a4ubEEx97PCB+ZqlTHljGTxgrEU/So8WKN2GvM+N+9gmW3L5V7sVLj/Pb9FIFUHCgQ8tCuvNpyiCwJansp7ioLidkXjkz816HyPZ0MLY6QJNmxbPUxCWxbRGTjH8+eaXGa0YWj0T2H4YZhnsqCEHmvORKsnUqv9+ceBz4cdAW3rKEFIl+aajcSPqL5rMjO4P7jnLonvwzwB/fLcC0+5harsGFZgY+h4LQIsIxuRsWqiR8Oe4Er882Zh+BKdwyHNJzdIA50s4XjWCI5Eh0sfVVFaDSE0/UUmnWjX8zcIztQ4s9lv6BaLE7CUNUkLzarfcL4Lvkc96KMIMXl6lAHjCvp85uzLBIrr0AGM/M3ewyqqFYEBLOa0njGvRuxPnJO7wFTfZRzOkkJawt7S/W7ndH558j3gzNTA1usGpSVxDdwYumN7qGoU7SvL19MxmfloYDRtbHjO6RpVLfNwlA+x+ddWl4UE92LEohiwa7+u+zWXaS7MmzqtfG8pBbILAncDyVgGKvYmd/bSJ8PFkOhb927SSadM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf15153c-1da3-4436-d570-08dccc002e01
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 10:07:12.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92jVi4nT51I4mmc0eng5Lb7vG9XSI3yb2FkmyA2JVXpFeom0xmwTNhM0FpFY0vc5pvjj+NsTKmHqvTwhN6KGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030081
X-Proofpoint-GUID: p9V7dDtR6DH_QjB3Q-LjPpdNw5h2MnCN
X-Proofpoint-ORIG-GUID: p9V7dDtR6DH_QjB3Q-LjPpdNw5h2MnCN

On 03/09/2024 07:23, Viktor Malik wrote:
> Coverity reports a possible memleak in dwarf_cus__create_cu due to cu
> not being freed for the case when it was allocated but cu__set_common
> failed. The same situation occurs in __cus_load_debug_types.
> 
> Fix the leaks.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks!

> ---
>  dwarf_loader.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 04f5637..065ed4d 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3247,11 +3247,14 @@ static int __cus__load_debug_types(struct cus *cus, struct conf_load *conf, Dwfl
>  				     build_id_len, filename, conf->use_obstack);
>  			if (cu == NULL ||
>  			    cu__set_common(cu, conf, mod, elf) != 0) {
> +				cu__delete(cu);
>  				return DWARF_CB_ABORT;
>  			}
>  
> -			if (dwarf_cu__init(dcup, cu) != 0)
> +			if (dwarf_cu__init(dcup, cu) != 0) {
> +				cu__delete(cu);
>  				return DWARF_CB_ABORT;
> +			}
>  			dcup->cu = cu;
>  			/* Funny hack.  */
>  			dcup->type_unit = dcup;
> @@ -3378,8 +3381,10 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *
>  	 */
>  	const char *name = attr_string(cu_die, DW_AT_name, dcus->conf);
>  	struct cu *cu = cu__new(name ?: "", pointer_size, dcus->build_id, dcus->build_id_len, dcus->filename, dcus->conf->use_obstack);
> -	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0)
> +	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0) {
> +		cu__delete(cu);
>  		return NULL;
> +	}
>  
>  	struct dwarf_cu *dcu = dwarf_cu__new(cu);
>  
