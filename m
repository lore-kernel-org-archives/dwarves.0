Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE5224EF
	for <dwarves@vger.kernel.org>; Wed,  7 Feb 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300132; cv=fail; b=dVviHev2oPgmzcVJpLjYjGHS5GXrMnS4wIeKVk03T5noQoWR78HZP072HwmXJCrUOo7PIAlgEh+kClRz3l7ji8xFNIOIQsiXxIRN/AYnuFeZq5cFBDKWWMa0rek06zfGmX7ikoHI/okYwaBnJ+gY2wF/OLuZhSUbXC6e275vLik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300132; c=relaxed/simple;
	bh=lGx+8BY38vrqujnRt7U48OtzSpsqTUHmCblvsasSyIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bb+U39c4n+K3dTWzkfykh8SeD1oBJ4Wpc9M3gNqUCcXVOxRqqxy5xdqnjdh4QetDVZzVfP0Z7H620Y9G3DNRkYqtuazQYxyMYXIwxZ475gOWP4BCbNEPakCb09O0bojh9hUEVJhROAmxThVjGMqDhrcejit55JAmDtLNXvVQ9hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H3M1zV1X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PjxRGN11; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H3M1zV1X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PjxRGN11"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4179xU2l018183;
	Wed, 7 Feb 2024 10:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3OwsZszYOP3a/Dz8av6J2l3zj2c8qbb+DPBWGTvPcwc=;
 b=H3M1zV1XFtwHb3wolL/ElKPBXATJ7rK7tVUGQktK0s0CnX0WasgzM5yu8E0ETUbUpbnS
 3YXFhPsml4fYoR420S0Ed4dS/pCWPP9QMVu15R0lTaWxsITg5T88WdQoYI/ODWdjZBHp
 tNIzQp7fs/4SSxMTFWM9Vxz7T+g/Lrst2mbQKSMpSlTcR3X0lhj7hiVixhN7Mlo6FTyS
 nSRbtv7VnAnI58jy8KIqCq1O3sUrei+gvi3KLB8F2HGhkOCnp6Q0/bw4rnQ7dKYnwrF4
 xYciNkwe0SX4DgEFiXj+hM4SidazvB67bpinYtgQ+LjULm1a1aCY5uOI1RXhl0gkTO0D xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbh6rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 10:01:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4179T9ho039655;
	Wed, 7 Feb 2024 10:01:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx8gmcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 10:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meYm5foOcSZlBPMAezmoHSGyayCgyDtMj6pv54uS+Fp//TKEySpmdKqLT7SdF7/qkBmKnEkyXvIQHEWVj4PMGCU7s2EZm8VTgXh5hB1XOLtsLwU5C4frUhEadDK4y+u9EWGNIVUWOTxvwT9o7RHOPtKLoTcG1fbm/QWZiJWUWrHmD+5DyKhmAUla7sV2M42RHuFoBPRkTb51tlMmP9sOE/jtESK/zPCqQJAjVnBG6QweKCw27Slpg/Jcw9XU9zrOgDZ7JlzRsAdiH/8a/9cEFKt8kevy1ZFrAYVqMTJfRbEIaQE9vxu6Xz31fORqI+IcLWOSNDxdAcdt7TvZhPOasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OwsZszYOP3a/Dz8av6J2l3zj2c8qbb+DPBWGTvPcwc=;
 b=LqnhCt7AynM/7ZCLzBt1MMD4ZkBuubFPViWQOJXE1xTewe3q9pMBeJsWEb8iDABIEl1EuGm8XAJRcQ5djUYqBtKbHrJNYFPaTRAD2PZEEX7tEBuewH8/THzQa7WXAQPQkcoRdYwhmL5O6UHs6Ito8C0nWFrrMZM6/0Xhk29QfJ4D1kqNAQilbG+FrGVqxKG8vxgFhkIabBVkuX6RydCf+NRPG3UToVr6oL80FuK+6bIC3WLoDWd06rm1zs8HwqtjTw6Hy87lXyVhR7MeUSjazyf9IHhEuxYuHGCnpe4yIOmP2tuxEcurS3IzXZpWTnLxoPs+8aMsakMXKb+rKlikGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OwsZszYOP3a/Dz8av6J2l3zj2c8qbb+DPBWGTvPcwc=;
 b=PjxRGN11ao+gycb+4Rkfhg+40ICyPMCzNKwSyXnTn/EQKN0lU4abl63/9OPv8QpWoHfaGGRcYu+m8Uy6Nyr5/of/erRsCiUdoJ+rEZ5s5z+zteDfYWqIjpd9N0GLVr7hhqVKrel46z+p/FccZZVruWpX4IwBX0ZfBwOmSc9mVPM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6204.namprd10.prod.outlook.com (2603:10b6:510:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 10:01:51 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 10:01:50 +0000
Message-ID: <e009cb74-feba-47c9-9d5d-b99517261017@oracle.com>
Date: Wed, 7 Feb 2024 10:01:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Encoding BTF information from DWARF causes "has void type" error.
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>
Cc: dwarves@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240206120226.6r7n4vQ3@linutronix.de> <ZcI3TVlOYuQfCWv2@x1>
 <ZcJA-mrVh5qmkxfV@x1>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZcJA-mrVh5qmkxfV@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9e8f0e-f964-4dcd-0a5b-08dc27c3cdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y9GgW4XMfWTKOgVuF7MxJF8WVqt4AddJWLB1qR3+WDCxLJgH/UdeD0x3Q7m5HjaFBJZ3Dbm8O+F5DKLAzWwA4HNIbiJIMAIk9QIMvx1BWm1ktprA1wp3eS+m4tN7ZImiEVmHN/Hpf7UOUJOI7S0mrtadLKUDgxXAB0O3w+RKHf4CXyhcQOrKo3zy+wNaO0DBEfJbMh5+6pvktbCxL/Qa+XTgeBlknE3fTS7CCyuAUmzWtE5b4R/9FYJMLI8umN2j3Dh+t+xgt9pXxutESD62CRIUfyWthwBcQR1iQSM9fLpcNg7oyTciwyQOK8dL3UbRNu5pH3bHpMvyH8r+Cs/vVIBjMczSjmXObk0nRvRgkSDQZRqoM8KgbHzHQg3oNa28vTlkya4P/20kqRnqetQs3klYgmH7xoPBAOK93ztx62/xnqx0dTpidHDJ/CgD+o3ImzH30HJMDfl/poTg6EisWE+r02YA8QbWyCJhVXbvidv9MBhXBq5Z/RGvmrilXr7j29oY0Ih5MtgpCS3ql6KdfMwygXzwlUIM2aL/nOMyd4HWZPYnuA+nuQ4yUcZjsI9eoHXtXS1QIqmMNAf6H0sIzw2h3iKcDRMZUxNWSH2Ssygsb17jrK3n7dUdMhWRncwk
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(31686004)(6506007)(6666004)(53546011)(83380400001)(31696002)(86362001)(41300700001)(2616005)(6512007)(4326008)(36756003)(8936002)(8676002)(478600001)(30864003)(2906002)(966005)(5660300002)(6486002)(66476007)(66946007)(66556008)(316002)(44832011)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTRCOWpsMlJNQmdzaGIyYUVsWEhZMmNTU3ZIR1JvWTJqZC8vUmI0S2czanha?=
 =?utf-8?B?b1dUQloyQ1gvamlFMnh0YUswdXgvZ3IwMnhDRWdrWkJldklhcHZId3lvTWFa?=
 =?utf-8?B?OC92TW1QdnJ6eTluemQ3VmgyNjhTNEd6ZHYvU0tjSXZ4LzBuVndrV0JvTHoy?=
 =?utf-8?B?R3Q3Q2F6bnp4clZpaFZ2ODQwczRwaWN4aktETXNCSFdlVWNvYTR3WExZZ1ZU?=
 =?utf-8?B?UUpRTHgzTDc0NjRWbTUxaGFrNGlFdjkvUStLNHkxNmM2Lzh2YzZYMTVwWVVR?=
 =?utf-8?B?VHllK3JEWXdVL1BmRlMzcDNaMmd5TEszUSthbGliVlovL0ZrTjk4cWI3MXdq?=
 =?utf-8?B?dGx0TGJPWEphak9ycWR1R0NheFc4R1JQdmRkWXJnR0ErRStGT05zTmNwa0xs?=
 =?utf-8?B?U1k4cTgrVlUxT2R5bU8yZ1NjTmhpbmFEWENxbEdGdHBEZE5TUEo5KzZBQ0xI?=
 =?utf-8?B?UjVLZE55b2F2Q1JQN1FxQkNpaXhJbDNYbzI0ZE9KZzM1L1MyQ1piVzBjYzcv?=
 =?utf-8?B?VmdPa2FaYUVua3J5cGdlTW8yMlRMV3JRWUV6a3k4QkJ5WTI5VHBQdkhyK3o2?=
 =?utf-8?B?Vnd0K1FhcVBwVlEwTXBBUkRVWE5aQmsrVzk0ME9NTlhVOUdUejhORDdJWmZB?=
 =?utf-8?B?SjJCMG5GcTFtYS9kUTZiamhkdnh0dnE3UExrZkxCVlFyQUlDcFU4cFNESFBp?=
 =?utf-8?B?ekQ4dUxJd2d0OStscGFQSnlUYytUUWNyVzA4VHRkZnM0L1RxVGhCdGpqZFJB?=
 =?utf-8?B?OVVxTTh2WmR3TkcrVEF1VUFFQzRCRGNyVWpmNmwyekpWbWl3UGxlZnBvaWEw?=
 =?utf-8?B?Q0VGcnVTeDB0YUwrNk5tb1pKcXVkeU9xU29JSTJZaXo2U2ZJZ1JjVFhYQkNJ?=
 =?utf-8?B?UTZxZndid2txbndpRDd0MjVtSWgyNUgzM0lmeW0va3IxcnVpWlpmWGhmd1lr?=
 =?utf-8?B?akY5TUludHluRnYwRjFCem0rN2ltaWx5TXc0UWxGcTV3eUZFMThsemRuRG9N?=
 =?utf-8?B?VGVOSW5zS0FUQmpiQjBmUWVUWVpSZkFSb3V5d01yRXF0OWFpYS9UdkhwL3NL?=
 =?utf-8?B?YjRrOHdMdUtYcmRrM1JocXhKNmczekYyOStOVnRMYm1aNS8vZDJsakNaVnZt?=
 =?utf-8?B?WGxQSkFpSTFaV3ROZmd0UDNGUjNHQlpyL1dPLzZYbDMzS3d3U3RQN1ZNaDRJ?=
 =?utf-8?B?akp5bytyVEVCRW44SXJ1dmEvZ1pDVWFFQVd1RG5LeGFmSWFzdE1VSFBlYTln?=
 =?utf-8?B?Z0tncEdxblZsZFBXb0FKOWl5aHJURnpnNWhlSUppT2lSaXRzRlVjLzAzMnJl?=
 =?utf-8?B?RGN1b2FlcFR0UVhlOXZHVXB4dUZzYjNUbjdzWWtrQlRhMGl3ZVd2dkswQ0l4?=
 =?utf-8?B?djdsRTBxYzVhcnlubWxoSU96QzRQQzF2R2xDTTdja05ua05vWUxpVzgvTW16?=
 =?utf-8?B?OTQxc1pmcGZ5UklXQStXc01IYUg3KzVLU0RYVXRCWVhjRFQ5K2c0dUU0Z0p0?=
 =?utf-8?B?UDJGZEtmQjliYWpwMmtwVHpzZnVjeUErRm1oRGJKcGgwSU5kRG1tRldscHN6?=
 =?utf-8?B?Tk5LYVcxSzQ3VjI1WXg5M0hiTmVRY0JsbHBVU25wWGtxOHQxU3M4NEphTFRm?=
 =?utf-8?B?cjduSXd2eWJLS0F4U205OHltek14bUR5SnBqM0o2a3JHOEphOEk3cDJNdnVJ?=
 =?utf-8?B?T1R4WWpMSUhwUk1BNkRtZGd5NUNZMnZjYWc3ci9QWGpObitJaGZXTWpCU3FF?=
 =?utf-8?B?YndiazNpUkw1VEk4S0srNG9US0ZJclVnTTcybVBxOG9HaFFpMkUvVTBOeGQ4?=
 =?utf-8?B?YlR6cC94Z1VGZzBvc1FQeTdGWWxibXJvb3hRR3YwYUxFWkU3UUx4bm9iamZi?=
 =?utf-8?B?VjVrYTJvdjlzMnhMeFZySFM1Y1FXRzFUR0RONTFoODl2REFZT01iV0MyR08w?=
 =?utf-8?B?bSs3MlFtV01FTTN6TUE3Vmd4Z3JXbXJ3WHM2eEdhZnN0RVkxcVNGNlF5ZzQx?=
 =?utf-8?B?SENaZzJxSFVkbnl1TW1QQXlkQ0E3SWJjUXJjcTNaT0p0R1dJYzVKc3FKdG5x?=
 =?utf-8?B?eTVJRzIyd3hnN21VbXk2Um1aZUFHY24yRE0vazdSSEhmZUtBRkZRQWd0UTVH?=
 =?utf-8?B?ZHZiQ3pXcDdJZE8wYUlGZHpkbkNyempVVlA1MjFYWHJEbG9DRDlrbHI5Q1BX?=
 =?utf-8?Q?u+ZroM81wu6Zs1nwjJUg+eU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Il70uLtTRdzH4kEWiqc1r5ZGwP85cv42TIY0G62DoPBChBkQyOTfCAIa+4SHfGMa9r8WuL69fkqeyByl70m741y0fVvdUXQss8JHqOkJDq9JVNGzebfa5LJgjCo4UH0oxI5H8CwnEUPgN8nuPhetopbTP41HC8gXjc3Yg4umDE6UocLpa4+aiCyoPO5lTcqMDWs2110tudJAYZADrsBst5NMuLRDtnSXTB9rm2YatTzpESvNlMNgNBF9DVyMcNxChavHG/h1Wwvv5HL0nVUdf84c42LtZAhVs1Wnh4E0YXxDSXxB67srY2u8PtT65R8yvIKFT9F+IkOshQivu504NbPfW1Gm00KI48LrRMdWyBXACYi6REFOCjgApGYCfsjRC5cBXP9eA27ZI6PxeaFdTAzlRjBTuR/ppN25qPs4K80VDZ/bR1CQKyUPoZzHHvjFC73HckShK3bJYMfmlHMDOBzeJugjg8avG7WRoWy9P8PKDIQ0VX+4JOYwA9aGj7jNKaAeMPrjOsGbhd7o1WS1pQ4mwdYi1T8j2fcYe90ws5tbLUsRrReF61u/6qowV4t+tRuEq3wmj7JxcFTzjrq3O5AKa5dQ191DqMcy9Pj26D8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9e8f0e-f964-4dcd-0a5b-08dc27c3cdef
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 10:01:50.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvXa0XeyuFokmgMomIUAdAS1/kk5nzzcYTgi8sGgZamgZfPgbJAEYcjzLCCcIwMuLHzHUAGz5dy4HAVKOKpCUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402070074
X-Proofpoint-GUID: YPGeauC4Kfg9skyzZPdjPmDalQ91WH_8
X-Proofpoint-ORIG-GUID: YPGeauC4Kfg9skyzZPdjPmDalQ91WH_8

On 06/02/2024 14:23, Arnaldo Carvalho de Melo wrote:
> On Tue, Feb 06, 2024 at 10:42:44AM -0300, Arnaldo Carvalho de Melo wrote:
>> On Tue, Feb 06, 2024 at 01:02:26PM +0100, Sebastian Andrzej Siewior wrote:
>>> with linux kernel v6.8-rc2-RT and the following file as testcase
>>>
>>> ----->8--------
>>>
>>> #include <linux/spinlock.h>
>>> #include <linux/local_lock.h>
>>>
>>> struct per_cpu_struct {
>>>         local_lock_t lock;
>>>         unsigned int something;
>>> };
>>>
>>> static DEFINE_PER_CPU(struct per_cpu_struct, per_cpu_struct) = {
>>>         .lock = INIT_LOCAL_LOCK(lock),
>>> };
>>>
>>> DEFINE_GUARD(ll_lock, local_lock_t __percpu*,
>>>              local_lock(_T),
>>>              local_unlock(_T))
>>>
>>> void function(void);
>>> void function(void)
>>> {
>>>         struct per_cpu_struct *pcs = this_cpu_ptr(&per_cpu_struct);
>>>
>>>         guard(ll_lock)(&per_cpu_struct.lock);
>>>         pcs->something++;
>>> }
>>>
>>> -----8<--------
>>>
>>> compiling and running pahole afterwards:
>>> | make kernel/pahole-tc.o && pahole -J --btf_gen_floats -j --lang_exclude=rust  kernel/pahole-tc.o
>>> |   CC      kernel/pahole-tc.o
>>> | error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that has void type
>>>
>>> This doesn't look good. If I swap the order of "lock" and "something"
>>> within per_cpu_struct then it goes away.
>>> The dwarf/die object it complains about has only DW_AT_abstract_origin
>>> and DW_AT_location set.
>

Thanks for reporting and providing all this data!

The eventual generated BTF might give us some clues, running

$ pahole -J pahole-tc-good-swap.o
$ pahole -J pahole-tc-bad.o
 ...and dumping raw BTF we see that in the bad case, we've got 3
variables of different types called "per_cpu_ptr":

$ bpftool btf dump file pahole-tc-bad.o |grep per_cpu_ptr

[88] STRUCT 'per_cpu_struct' size=136 vlen=2
[94] VAR 'per_cpu_struct' type_id=88, linkage=static
[95] VAR 'per_cpu_struct' type_id=89, linkage=static
[96] VAR 'per_cpu_struct' type_id=87, linkage=static
	type_id=94 offset=0 size=136 (VAR 'per_cpu_pe struct')
	type_id=95 offset=0 size=136 (VAR 'per_cpu_struct')
	type_id=96 offset=0 size=136 (VAR 'per_cpu_struct')

The first variable [94] is of type "struct per_cpu_struct", the second is

[89] TYPEDEF 'class_ll_lock_t' type_id=87

...and the third is type id 87:

[86] TYPEDEF 'local_lock_t' type_id=73
[87] PTR '(anon)' type_id=86

which is a pointer to a 'typedef local_local_t'.

Contrast this to the good case, where only 1 is seen:

$ bpftool btf dump file pahole-tc-good-swap.o format raw |grep per_cpu
[88] STRUCT 'per_cpu_struct' size=136 vlen=2
[94] VAR 'per_cpu_struct' type_id=88, linkage=static
	type_id=94 offset=0 size=136 (VAR 'per_cpu_struct')

So I think as you suspected we oddly seem to be conflating the
per_cpu_struct variable with its first member somehow, and
worse doing it twice; once for the typedef class_ll_lock_t and
again for the ptr to local_lock_t.

The DWARF looks right to me:

0x00000764:   DW_TAG_variable
                DW_AT_name      ("per_cpu_struct")
                DW_AT_decl_file
("/home/bigeasy/linux-stable-intree/kernel/pahole-tc.c")
                DW_AT_decl_line (9)
                DW_AT_decl_column       (0x08)
                DW_AT_type      (0x0000073c "per_cpu_struct")
                DW_AT_location  (DW_OP_addr 0x0)


Putting additional debugging in the BTF encoder:

diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..73ee6f7 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1520,6 +1520,9 @@ static int btf_encoder__encode_cu_variables(struct
btf_encoder *encoder)
                uint64_t addr;
                int id;

+               if (encoder->verbose)
+                       printf("processing var '%s' at pos %p, tag
0x%x\n", variable__name(var), pos, pos->tag);
+
                if (var->declaration && !var->spec)
                        continue;


...we see

search cu 'kernel/pahole-tc.c' for percpu global variables.
processing var 'current_stack_pointer' at pos 0xa14be0, tag 0x34
processing var 'this_cpu_off' at pos 0xa14cb0, tag 0x34
processing var 'per_cpu_struct' at pos 0xa201f0, tag 0x34
Variable 'per_cpu_struct' from CU 'kernel/pahole-tc.c' at address 0x0
encoded
[96] VAR per_cpu_struct type=90 linkage=0
processing var 'pcs' at pos 0xa20c20, tag 0x34
processing var '__UNIQUE_ID_guard44' at pos 0xa20cf0, tag 0x34
Variable 'per_cpu_struct' from CU 'kernel/pahole-tc.c' at address 0x0
encoded
[97] VAR per_cpu_struct type=91 linkage=0
processing var '__vpp_verify' at pos 0xa20e60, tag 0x34
processing var 'tcp_ptr__' at pos 0xa20fd0, tag 0x34
processing var '(null)' at pos 0xa21130, tag 0x34
error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that
has void type


Looking at the above, we see it's the __UNIQUE_ID prefixed variables
that cause the trouble; for each of these we wind up encoding an
instance of the per_cpu_struct variable.

We have a special case meant to handle this, but it is triggering for
the __UNIQUE_ID variables:

		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
                 * have addr == 0, which is the same as, say, valid
                 * fixed_percpu_data per-CPU variable. To distinguish
between
                 * them, additionally compare DWARF and ELF symbol names. If
                 * DWARF doesn't provide proper name, pessimistically assume
                 * bad variable.
                 *
                 * Examples of such special variables are:
                 *
                 *  1. __ADDRESSABLE(sym), which are forcely emitted as
symbols.
                 *  2. __UNIQUE_ID(prefix), which are introduced to
generate unique ids.
                 *  3. __exitcall(fn), functions which are labeled as
exit calls.
                 *
                 *  This is relevant only for vmlinux image, as for kernel
                 *  modules per-CPU data section has non-zero offset so all
                 *  per-CPU symbols have non-zero values.
                 */
                if (var->ip.addr == 0) {
                        if (!dwarf_name || strcmp(dwarf_name, name))
                                continue;
                }

So I suspect the problem is

 if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name)

...which uses the associated address to look up the name, and then goes
on to use that name to encode.

The problem is the conditional check above; I can't see why it needs to
be guarded here. We never want to do an address-based lookup for a
variable and not have it be the same variable name as we have from DWARF
- which is the one we're trying to encode, right? The following fixes
the issue for me, can you try this out if you get a chance? I might be
missing something about that check so other folks please do weigh in if
something looks broken. Thanks!

diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..aecb311 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1559,10 +1559,8 @@ static int
btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
                 *  modules per-CPU data section has non-zero offset so all
                 *  per-CPU symbols have non-zero values.
                 */
-               if (var->ip.addr == 0) {
-                       if (!dwarf_name || strcmp(dwarf_name, name))
-                               continue;
-               }
+               if (!dwarf_name || strcmp(dwarf_name, name))
+                       continue;

                if (var->spec)
                        var = var->spec;


> Are you sure?
> 
> What I see:
> 
> ⬢[acme@toolbox pahole]$ cp sebastian-rt-void-variable-btf/pahole-tc/pahole-tc-bad.o .
> ⬢[acme@toolbox pahole]$ pahole --btf_encode pahole-tc-bad.o
> error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that has void type
> ⬢[acme@toolbox pahole]$
> 
> ⬢[acme@toolbox pahole]$ readelf -wi sebastian-rt-void-variable-btf/pahole-tc/pahole-tc-bad.o | grep DW_TAG_variable -A5 | grep -w per_cpu_struct -B1 -A4
>  <1><764>: Abbrev Number: 29 (DW_TAG_variable)
>     <765>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu_struct
>     <769>   DW_AT_decl_file   : 1
>     <769>   DW_AT_decl_line   : 9
>     <76a>   DW_AT_decl_column : 8
>     <76b>   DW_AT_type        : <0x73c>
> ⬢[acme@toolbox pahole]$
> 
> ⬢[acme@toolbox pahole]$ readelf -wi sebastian-rt-void-variable-btf/pahole-tc/pahole-tc-bad.o | grep '<73c>.*DW_TAG_structure_type' -A7
>  <1><73c>: Abbrev Number: 4 (DW_TAG_structure_type)
>     <73d>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu_struct
>     <741>   DW_AT_byte_size   : 136
>     <742>   DW_AT_decl_file   : 1
>     <743>   DW_AT_decl_line   : 4
>     <744>   DW_AT_decl_column : 8
>     <745>   DW_AT_sibling     : <0x764>
>  <2><749>: Abbrev Number: 1 (DW_TAG_member)
> ⬢[acme@toolbox pahole]$
> 
> But when using verbose mode:
> 
> [95] FUNC function type_id=94
> search cu 'kernel/pahole-tc.c' for percpu global variables.
> Variable 'per_cpu_struct' from CU 'kernel/pahole-tc.c' at address 0x0 encoded
> [96] VAR per_cpu_struct type=90 linkage=0
> Variable 'per_cpu_struct' from CU 'kernel/pahole-tc.c' at address 0x0 encoded
> [97] VAR per_cpu_struct type=91 linkage=0
> error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that has void type
> [98] DATASEC .data..percpu size=136 vlen=2
> 	type=96 offset=0 size=136
> 	type=97 offset=0 size=136
> ⬢[acme@toolbox pahole]$ pahole -V --btf_encode pahole-tc-bad.o
> 
> It ends up considering two variables with that name?
> 
> ⬢[acme@toolbox pahole]$ readelf -wi sebastian-rt-void-variable-btf/pahole-tc/pahole-tc-bad.o | grep per_cpu_struct -B1 -A5
>  <1><73c>: Abbrev Number: 4 (DW_TAG_structure_type)
>     <73d>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu_struct
>     <741>   DW_AT_byte_size   : 136
>     <742>   DW_AT_decl_file   : 1
>     <743>   DW_AT_decl_line   : 4
>     <744>   DW_AT_decl_column : 8
>     <745>   DW_AT_sibling     : <0x764>
> --
>  <1><764>: Abbrev Number: 29 (DW_TAG_variable)
>     <765>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu_struct
>     <769>   DW_AT_decl_file   : 1
>     <769>   DW_AT_decl_line   : 9
>     <76a>   DW_AT_decl_column : 8
>     <76b>   DW_AT_type        : <0x73c>
>     <76f>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0 	(DW_OP_addr: 0)
> ⬢[acme@toolbox pahole]$
> 
> Just dumping some more info in case Jiri or Alan thinks about something.
> 
> - Arnaldo
> 
>>> At this point I am not sure if gcc wrongly created the dwarf information
>>> or of pahole accidentally matches the internal local_lock_t member as
>>> per_cpu_struct because it starts the same address.
>>>
>>> >From dumpwarf the problematic entry is:
>>> | 0x0000085b:       DW_TAG_variable
>>> |                     DW_AT_abstract_origin       (0x0000099e "t")
>>> |                     DW_AT_location      (DW_OP_addr 0x0, DW_OP_stack_value)
>>>
>>> which looks slightly different in the good case:
>>> | 0x00000852:         DW_TAG_variable
>>> |                       DW_AT_abstract_origin     (0x00000980 "t")
>>> |                       DW_AT_location    (0x00000040: 
>>> |                          [0x0000000000000046, 0x000000000000005b): DW_OP_reg3 RBX
>>> |                          [0x000000000000005b, 0x0000000000000061): DW_OP_addr 0x0, DW_OP_stack_value)
>>> |                       DW_AT_GNU_locviews        (0x0000003c)
>>>
>>> I made an archive with c file, the compiled version in bad and good case
>>> (swapped the first two members), the dumpwarf output and uploaded to
>>> 	https://breakpoint.cc/pahole-tc.tar.xz
>>
>> Lots of great info, I'm on it.
>>
>> - Arnaldo
