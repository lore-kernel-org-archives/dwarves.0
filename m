Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268376023
	for <dwarves@vger.kernel.org>; Tue,  6 Feb 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211380; cv=fail; b=YaCQShliSZixBwgUEUyhZMtlGFIU5xXbgTtsI4l/s8PNnA6OjdHl0IeYeUKBgX+04rG6bG35jztMAAHkFl8N1Ss8nEKZoBvK8l22PSVJLhB+thsEL7UBSdrR8SZdRGmmPe6qW3OKUWekYYVyD5N5qQ7z84rbADmMA08s83NFimY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211380; c=relaxed/simple;
	bh=LmXdx1X45sDL/5MA3CWzyfuDkUtKF9LlD+HACwy2Vlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WkIlOrMux8b4Gv7HX3buLpzAf/TZ1DTXZaN8LrFI3VKY7GH4GpW87Px1yCMltkbCgAfgT7AHSLhxWIYktuj1IBjZnU+VH/bey1lCcXa6xN2WHvIjZ7DnHmUNRWTIR1MQiY/V4OfYS3GqqTKGBggc81apTEJFTB0IIH8AYLld02w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zaq4Z8th; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ok2yY5IH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zaq4Z8th";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ok2yY5IH"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161EGwm006197;
	Tue, 6 Feb 2024 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=I0l0og6bQpl++NKoF39j2P2+TOaf6BbSHLpLPuj5f+I=;
 b=Zaq4Z8th9Xi6yIfDkPryDC/wb2DsXUbuks7B/6IrjpTEtLDNfEVCqC5miFlhmNDHcuGg
 PBkR5zLAV0U2QfPpjAeEOKWsfdm12D/vdnzkmKnVcBVEr7hDiaBaVNvMnjDvMesyHVB6
 sg0TJu5yUGznZ9sQtvw45/IgM1UfUYbxgrENf8sEzxErd1pFyqr1e3nU2Non6gaeHa2k
 cnfyKwYx9LcRfGNzKTGKrhlhKndlwrN38Yb75yBXDZCt4hvEiBKXJ6aDYPHCu+ZYUXP7
 VrA5gOZs6I6+Ce29K5QdH7Nv6D8PetlJvDiI19zmoRY+oofHQIWonSIjDBVda9vdybXX fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c32paq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 09:22:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4168CLVj007358;
	Tue, 6 Feb 2024 09:22:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx77dq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 09:22:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShzSpE6xIHFFyUWKQFGCASutqG2Uz3bwp8qxTEU6WFC3pch+EXylZk1dR5h8D1E7K5ydsDGY6Q8KdKkOempF+lMqkx7MszIQPYmpOE6rSlBib7fhClZRW92Oq07nCrcArlP0367t2p3LJpBowERNjdgT0AUY+OKRMUsMgWDnYFez03qe6OFRQ5mKZ2lDyKoZCy2NOrr544UtTVq8x+AB3p55paOaFLypMvmRGBhwsxb1h1mzXy87F/mM2XcuUJJ/YcvW4qibwdwSDx99dll8qac3o7URzXBZ7X8zjWpXOC3AjlN8Ggx7TmIEeC9zuuPpmea8MfP1rjdl29zkLmwecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0l0og6bQpl++NKoF39j2P2+TOaf6BbSHLpLPuj5f+I=;
 b=XGt5u7Im1NTfUF0QoBJCpycvhau/m1KBVXJkHYAgN1z4DqlFYWlg4ADKj3tJ6Qtj1S61NTgunObpXrGXrEovp5HWBEU6t8HutdbvZGPdFkUdKcEwIAW2ksdaMciA6i9tMLBYTbvyCoQgmcaYTicpKwKh3X80J0MYJhHvafth4YRtwZgLBt38Cy8kzpoLG8/ym4bskHZP/HdP4fRAJFcJwEkMZHSDSYh33GSH5jtE/MCXkxpiDxzZX2lsMmPvc5IjIlSGEZGq2OuRLQZi59Lzt5C6AvksU+RXTAIiedZcyfnbaZDd7x/6urrSCaSsDVTfJB+jr1W9nbYPOmtDSBbnog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0l0og6bQpl++NKoF39j2P2+TOaf6BbSHLpLPuj5f+I=;
 b=ok2yY5IH/AaPapFr3eYVvAU2CzUw++r1f5Cm/0AAKZKZ1GyPXyLooYEvYbj5B08z1KjoxadDEYkG+TC9Rz0NCOMpz48b/V9FZTDYMpiquDRbNEwy4/HJgDRhtcGxgbbmBut/DOh1PZZSCn+RPQ0VwwRA8qX4hHkTuT+tKETuW9A=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 09:22:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 09:22:45 +0000
Message-ID: <d760b2c8-a715-488a-852a-235aca8bca6f@oracle.com>
Date: Tue, 6 Feb 2024 09:22:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pahole: Make sure the features string is NUL
 terminated
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org
References: <ZcE1PJ8MPXzVb3mJ@x1>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZcE1PJ8MPXzVb3mJ@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9f67fb-4b8e-49ba-e937-08dc26f52ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3rjzVJXIKfP0rtLzNHGnWLP4nar6/dcqhZ7bA7gZdPRrwCQAkCXRj85sjb+NBlLe1H8dyAUSR0YGHXcVdUlpn4Henxqz/Mhby9oCa69lb3Iow6rvXSTfwE6h0YEbEk/kR1F02bOCENqVc7VBE5zVc8HDeAo8y6rWHQmRgm027cWPJGGr96DHwj6EIHJjOixn7WcNutEFA/j3pVNqFl4PsDezY8LbfIX0fyYUn65JVwQeS1wkxySBb7cs8YeW4CXqA0qYlPYiP0Jw47drblCOWbe+dqtOyvV5pfLyhjKuyTMs20Rl+l183JZEANlRD0c/GvT/9BfYkeZjYV/VCCS2EfcShEoLrEUD7TsEz620lFHJCtPDGPkOcHaZYLi/L14vmqGE4VIXzj9ETQxa/mNWnlTER8TFuonfdvG/fpodW8Om5IkEzCUnRLFfCD55rW0B8HHkLH84z+9lYK738eai3HNBH/+jNwXolfGglhKfgTSnp38BfWgMA/1JX9HMD6Pkj6uLQtCJ8wZPaf35+jr9bx66sScj6WVz8tAq+NCCsjvDbUD4QzGcbu4oTwLMwEUSL91Q769E0F0bCl/57TbWz9aSV1yUaPnrplxn8xa8HA0WzzleoEIY8UfKf+z0F4j40P7QZm3GXfoDC+RWd6WwIg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(86362001)(316002)(4326008)(66556008)(66476007)(6916009)(66946007)(478600001)(6486002)(8936002)(8676002)(5660300002)(31696002)(2906002)(44832011)(2616005)(6512007)(6666004)(83380400001)(53546011)(6506007)(38100700002)(36756003)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1Q4WCswa081VVVla0F0eDk4K3Q1cDNURVpXdzNvekhCM0xqUEVDMzdVc2Fm?=
 =?utf-8?B?ZlBpSXJvTk1PSUszMFJ4S2djK1dlVGljanRrV0ZDWSt1T0gxRGVJOExTQW8w?=
 =?utf-8?B?ampMNkNHWnQxZHR6SEl5Mnl1aHNPOGpyWjdLaTAzUXVhNTczQmZUSlVqTm12?=
 =?utf-8?B?V3VDaEthRXNpQnhEcnU5OVJyVHhtMVROdFFSNVRLR3pTSjhDd1ZvVWlQVG1S?=
 =?utf-8?B?dDZ2V2JVNk9yUHE0dDlUTG5yRlNTMG5YYkZWWC9LUGtOOUE5bEYrM2ZubEUy?=
 =?utf-8?B?dmErVVhNSFAvQWZjMXpYSHFlcDJqcUdoTEkrci9KdEt6Rndxd0xTWmJ4dmtR?=
 =?utf-8?B?SWN3N0Rtb0paNmVUaFhWZDlFa2NuWTExQVdFM0E0UDdTcnBUQzcwUEZLVTRF?=
 =?utf-8?B?VXlacno2N2l1YUlNK0dTeVo3eWF3YWFhd1B4MllBSkQ4Z3Y0RmQ2S2FoaEJG?=
 =?utf-8?B?dDVSVDRyVkpEWEJFYnA2V0Q3azNjaCt3SFdQb1MrcmV3NExQanh2b0xwOG9B?=
 =?utf-8?B?OHFrcmFiVmc0VStTV1dLK3BVOXBPUk95UGJTVnM2K0VUSTZDYVlOekpTUG13?=
 =?utf-8?B?Y2tTMXdsdnlSUU00ZndjSlZLam8xcXBLUHJlc0k4QXhoTitMQjcrUnBCMTFX?=
 =?utf-8?B?akg3TktIRHJPSlNBZ00rUUl3S2tFYVphRHo5aWJnT1Q0Wm4rUHlMZjIzL3A4?=
 =?utf-8?B?S3VoV21NQXJRQXRFY0lkM1E5T0Fzc1hTazNsS2JBNnRMajlUMnZxNlpUd2hM?=
 =?utf-8?B?ZzRvRVFITjdtTFA0Um5tamZ2REpNWE1DSFhvUWJ6Mjc2d0VhVHY1U0MyeGpU?=
 =?utf-8?B?U0tjUllUNTJZd0Ruc2VGaTl3NHF5Q1d6c0ZHRGErUGFPNlJSZDVDZjArd0Nz?=
 =?utf-8?B?S0Z4QmZqb01pTFFNK1E5MlBZclZnUm4rMThBT0xJYW1VMWhQZWRUMG9pZ0gw?=
 =?utf-8?B?aFJkS3BWdUxjWFhwZTU0OWc2ZmlQZVJ6ZDdhbW9EbTRIWTh2YVU3eVYrYkd4?=
 =?utf-8?B?YjY0K2JCZFUwRy9pMmRZVWRidVBINC9ZM1FEQjZ1S2EzdGFzY3MwbjlmY1V2?=
 =?utf-8?B?V0NuYVJvdEt0LzJIYkJmYkQzVmNibGg1c2EwZEIyQWNURlhhSVU2R1QwOW9I?=
 =?utf-8?B?Y0xzY0RWTU84NW1WQ0oyNmRINFYrenN6OVVlQzlXYlptcmtDOTJkeGI1cEg5?=
 =?utf-8?B?aHdMRDdRcEtoai9oK1ZiMzZLSjBSU3pDNDNuYm5kQ3haZVJKQnRNcDlNTjdz?=
 =?utf-8?B?a0NwbEQrTkI3V1VCamlrUk1mSWVNTDZTT2dWVjdoRlBFMGNGSlhxUEtQc0l5?=
 =?utf-8?B?bXlNZDlqSTIrOGdYR1VRRk50RWRLVzlmTVk5MmJZYllXbnhCcEd2TmJQUnJ4?=
 =?utf-8?B?cUZkb0NneFR0bGxGNFRQVlU1NzY5VktZTS93eHc5R0F2eTlGUDNvUi9wTnJZ?=
 =?utf-8?B?cTY3UTZpek1iVHRzSmUrK2JEZ29vM0dqbTZvYUdaeUdxUHRXd2J1cWdNdEk0?=
 =?utf-8?B?ZlJMWXluK0E0dkR5MXdYSityQkp0Q3BvcG1PKzJJMGhEMWYxTHptTkFTeWZC?=
 =?utf-8?B?dFZDREZYNGNYVFlRV0pqVTB4cEJiK092UlpzUGx6QnNNa3dxSXNkdTlkWkwy?=
 =?utf-8?B?eWp6L3M4WktpcEJ3SXBoMmMya3ExV0xCb0lEbjQva3FiQmxLK2w0R1ozOFdL?=
 =?utf-8?B?RldCR0E5YldvQ1REeGVRc09MV0ZJSnJwL3dHUklxR2ZMaHYrWVJyR3ZOYUdr?=
 =?utf-8?B?eEZtS0thdDQxRGJPYWhsQTVlQm9VMVVZNE4wOXFPSHk1aC9LK3Bjdmx0SFJP?=
 =?utf-8?B?YXlORmpaMDRLSmMzN0JwQlc0ODF2RTN5Y0VxeHRWVUJBK05sTzF5aFhLNytM?=
 =?utf-8?B?RnlEVzk2OGhVS1JlZWV0Vi9ZVGJ0TnRuMUliTUw3amZydE94bHJUeUFBZTZS?=
 =?utf-8?B?WEo5UmhIaUtFZk5nbGJ5dTkvL0JnekdzU0JFQmtQbXJrNWJ6dG43ZDBMNm5I?=
 =?utf-8?B?NHlzRlQ3Vm5oN0U0Z3ZUU1pTQnUvSmJSeDBKTGtvS2dYeFZNWkhCQTdueHFS?=
 =?utf-8?B?SUlTbmtCZWpmQlhqUWZYYWdybWhRVlNqSG5RSjlLOWRzUUpoM1NBUkdyTXYx?=
 =?utf-8?B?TEw0d0JhRTR4MXZmNjdyZ0ZkT0Z0cXNEb0d2UzlmYlpnNDlkbk42ZTBGTVAr?=
 =?utf-8?Q?dlsAJ8+TxEFbXUOJoitHI+0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z9CtQpWmMbSF2hy9NurlC7IxzdcmAkahU6s5Z4DZEyksBzgBuQRhsnZ6NwrBxJjeRCn9IqkGsaAdG7Xf9MJQik4GQYPBbReYImyNIXBHDBfnz58Bu7121TUbd/IIuO2R7JPr8FxDWgEaZ+su6BwYVdOrBssJ2NLkNIoO+VCGcdn0+giX6LIBNyzAfBPVfeLUfjkcO7OS0UhyYiz15Ejz3kv2MZ0gNv1yrQoefqUGsL7D3x97MLzd98isa+YZ4nA1GdFDfaF4wy2j3KG2dXf5n3SE8DdGtHEOcm4lI/qJRI7GTnWxn+jZEchceavcKfM9yn/5Ar67VWDoYOmkTPH/oi5mM7hZw4lh6lbWhEwjm5uPVwO3UtV2z0ady2m2N3ddSXTWvcNAio2SPANsrIF0fLnBUh84PepND+WMmLO+am6Fs+A3hR9oD8OkNM7xbtvyPRNnh3dG0KG/s3XdHF5ebE8BhG6ai/XBACAj8K/k2JV9IbTmZNzuk18J11apT6xjrzrfj6wEICOrhIA+JmgMhtnI+Elz7sAmSthg8e7WQwoRlDOBnH0WtQfhcMdnS8Rex2EpnuQ660oVBsooZxV0PaieQozx7SrR0d2EsDyHpxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9f67fb-4b8e-49ba-e937-08dc26f52ccf
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 09:22:45.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ4I5QQdESH4OtIqKVS+Ft/JD/l1K5DLqqdezyFCPHkMfDfHGf4f0pQYTUSrOfDN7aE3aJMh16NXNDa6ltR8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060065
X-Proofpoint-GUID: nP1t-KI94hRSgkw2IAjBDOCAa4Yqrlrf
X-Proofpoint-ORIG-GUID: nP1t-KI94hRSgkw2IAjBDOCAa4Yqrlrf

On 05/02/2024 19:21, Arnaldo Carvalho de Melo wrote:
> To address this compiler warning:
> 
>   /home/acme/git/pahole/pahole.c: In function ‘parse_btf_features’:
>   /home/acme/git/pahole/pahole.c:1353:9: warning: ‘strncpy’ specified bound 1024 equals destination size [-Wstringop-truncation]
>    1353 |         strncpy(f, features, sizeof(f));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   $ gcc -v |& tail -1
>   gcc version 13.2.1 20231205 (Red Hat 13.2.1-6) (GCC)
>   $
> 
> When building in Release mode, for instance by using the buildcmd.sh
> script.
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 7bc9b9975545ab53 ("pahole: Add --btf_features support")
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>

Thanks for fixing this Arnaldo! I'll make sure to build in release mode
in future.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
 ---
>  pahole.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pahole.c b/pahole.c
> index 768a2feb338a2f3c..0e079ae19f231a5a 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1338,7 +1338,7 @@ static void show_supported_btf_features(FILE *output)
>  static void parse_btf_features(const char *features, bool strict)
>  {
>  	char *saveptr = NULL, *s, *feature_name;
> -	char f[BTF_MAX_FEATURE_STR];
> +	char f[BTF_MAX_FEATURE_STR + 1];
>  
>  	init_btf_features();
>  
> @@ -1350,7 +1350,7 @@ static void parse_btf_features(const char *features, bool strict)
>  		return;
>  	}
>  
> -	strncpy(f, features, sizeof(f));
> +	strncpy(f, features, BTF_MAX_FEATURE_STR)[BTF_MAX_FEATURE_STR] = '\0';
>  	s = f;
>  	while ((feature_name = strtok_r(s, ",", &saveptr)) != NULL) {
>  		struct btf_feature *feature = find_btf_feature(feature_name);
