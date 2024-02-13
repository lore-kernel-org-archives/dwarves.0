Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B91F5F6
	for <dwarves@vger.kernel.org>; Tue, 13 Feb 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849217; cv=fail; b=BuYEZJkjaCByTnx6xeWR344NXrLmZtYzKckr3X2NdP+9yWINXXWKB+cLprPO1N52T+YDyeUoQHekYb8ktQvelgxbdati7gxkjxUgfHkOScq7Ek+HAaZqhDRDRPdRCWIWSUrTe+A5uXmC+ofHnC4S5WpKzsVKsJzoGrYvvLYPsZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849217; c=relaxed/simple;
	bh=yL7ZlPYnAQFsFa7OidOXPkndTn/o+LKGDd0oTmXLL84=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GdtcVxZ8uu6EU/84g75RcPjhfUHdDpL9WsUHfbqzek1OA35Po1H1l0aYIU+YSjWAKXliiJs+9AIU1dmACIWwMCbWu052IhQy3eDAopDpo/3WK9L2eTIAB0YDDysHUIlZRa2Ci6abGDrgoIW5gAYANE2XlJLItCtWGYB9OLw+Nwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mq/DPmUc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W8OpUwQi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mq/DPmUc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W8OpUwQi"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DI9DQD026320;
	Tue, 13 Feb 2024 18:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lJZaQjuZwGAI6qfndCjYNREkRYbgEZNb1iqPIPRiZC8=;
 b=Mq/DPmUc6vgqW2dqgednoA30uvfUTy7YZ24ik0W4/uc5jvG7qur71LeEJQ1ZX01VoSNm
 dbiQR5ivJKdHGsS6R23qaEqVxUUpkXuk2Pv/E1htTttXvOSYXMpC3n3u+J1v/3JP0aRa
 fCJU3UpROKQLVEMbfS83D5Hw792Mod0+Vlcu4q0eEVZ6hkEohMUezISBPIKznls3JfEM
 z6sjbMBSCfbb0cVyXk5DV9Dkckk67+1XvCqNmC2ilU9rPsmEF60zlQ3MxYIEWHmGeG0r
 zspiKuIJF/yDPBL4/y9bs6lm+kuM2rnX9pHWQWy4bZQwFP1vvbN5cJrQ+dVtJ/9Y3xiV mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8cxr84su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 18:33:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DI8WWK024638;
	Tue, 13 Feb 2024 18:33:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yke1wwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 18:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HenSUDhzkUCy5Cycrk7RpsPB9uWZeJU4Og6tYXldC2rwedqONvgx1wVzn4ilKa+e/fSJ6nI7R489hmTzsQ1NxDYY0h8BTLc8KmI1TuOxcRKm7rCuC/C7yWTG50poQV22TvLTMunlWiNRj2dpP3w9e2fETBOWRbE20Mxm1wYxBhM72vj6Z+lJktQUFnRIrlrNWOr7H/3rFKvIPjZO0lYoeaR+QuzdxQymimke6PB2skduzxSqbJgKnBup5bGt1RA0A0OAmYeN4O8/OpI/T0NN8xVF+AuCsTLil7YE2tQVlJIwjkQVGtQU1gw/+K66IrZTSASWzdx6LwIF7TQD+zToVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJZaQjuZwGAI6qfndCjYNREkRYbgEZNb1iqPIPRiZC8=;
 b=fZQGnRkxTfvdgLMrnrv5HHLg3VVZ8V+vd3gi8dBmQyGr4PcEJdN5uEAGtyPE4ZeUoacVyTUzECa73vpTqOpCDWf0pXkqYvFdsBqsL/zIfzwvU1Ch707icBg7V/l3cYny0QSOTy0LtSgIc4LQISM5ahVo+YXMnL+EGuT4vffYsrA8gx5dxNLn2Ls1XZ2ThmTDnc3OpTLAfftUmOYM3EVNWHZgOWEhr2DECvg+EhCfSB3tYfo6dUfbs32IU/de39nLQTlVnJBAs6w5wCLxt9OTco0X7nwIZGqClxOBOOp592MARcfic0WJESoaGHCXxTPmmYy07Vwz8Xz/CvyWL2275w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJZaQjuZwGAI6qfndCjYNREkRYbgEZNb1iqPIPRiZC8=;
 b=W8OpUwQi1PVkX8Xy7gytZmsRJzTTf33KqVPVsaLEZ1CJyyA3V2P/FZYiRWPfrft1cQEhswUn7TnilY+ZX7rMrDYasRulWJmiYUBJwjnS87FJ1SlXmoemAyspcSA1h9jp/ISp6TIVNienK3Dw4/tijpA9fHk/is61GtABv+gutxY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Tue, 13 Feb
 2024 18:33:20 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 18:33:20 +0000
Message-ID: <9b67e055-23d7-4067-8db6-765ef459f79a@oracle.com>
Date: Tue, 13 Feb 2024 18:33:17 +0000
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: Encoding BTF information from DWARF causes "has void type" error.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240206120226.6r7n4vQ3@linutronix.de> <ZcI3TVlOYuQfCWv2@x1>
 <ZcJA-mrVh5qmkxfV@x1> <e009cb74-feba-47c9-9d5d-b99517261017@oracle.com>
 <15bd5441-9e34-426b-9715-df43beedf1c8@oracle.com>
 <20240207123021.zCd9dUk2@linutronix.de>
Content-Language: en-GB
In-Reply-To: <20240207123021.zCd9dUk2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 40794421-8ece-431e-ef5e-08dc2cc240d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xkU78UllFT/mYnSQ/Aer0g8l8vCrKdwkrqNbCd7YBbuHi3NKtk8RmxeAKJ8BAZXWPafz2Aym7EUh36GMKgfOvwTwJN9ho3rPsLOAdEdRbj/f9sD9GaQzolLz78cukyM5AKE3vHFBI6smVQvWI+Z7iA3rAUBNpQbDuz3eyEfE49pazJ9HB2+z6Th2r0bdRNXuWIc/ybPp62bRARhhDSVnEylBbt2MMmK+RhZd0JXXWemxjz7yOAMKli5ZWNc0ZM+o0DGyBTDdzc61a0bIUpUeUPP02AU93KzS9nv4fqwetXGQJb2tjgMAer904M6YhayzRHnRoywwRITijrecyz6vI3eADRn4qg1/kdb2oXcMjQZCDpPT42vZnzQpb+dioOgyHD9HxA5eNZlQtbukqY/c3RASBLK4MubopfYaov8QlUm3urd0g4lLnF+/ejAQgN7yHBtr/MS1b8wyOruh1fX54XfuV9hLw70cgX2i1SHGxqJvnYwe9/bCwwX2T9HtHc2jqqNtocDsDaqdXvOnWC0YsAhpalqafq+NariVsRQMl7A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6506007)(31696002)(86362001)(6512007)(38100700002)(966005)(41300700001)(31686004)(44832011)(66476007)(66946007)(2906002)(478600001)(6666004)(6486002)(53546011)(54906003)(2616005)(5660300002)(36756003)(8936002)(66556008)(316002)(6916009)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDBjYWJ6cGJWRWhtZVpRWW12QzAvTy85VFNqeXhCbVNtRGV5bk5vQzdicldO?=
 =?utf-8?B?YXdCNm1iQXcxV1BXNWNOWU8vaGtFTDgxZHh2V3FWTzh0UmNFQzJQYzB4eU83?=
 =?utf-8?B?ZGtNRCtCNGs4alBQZzRNR05Od2FiUHFVM01BOGpCTFI2QUc2T1dRV1JXemNh?=
 =?utf-8?B?NDZTVWkxMzJyTXU2MWNIT0FYZ3lBWW9NSmdvdTBnUzhpSmtWZE1UbFhuRHVs?=
 =?utf-8?B?VEc3eVB0QzVzRmpzMjZzSy82MFJmWVprWGF3VElhV2JCQ2ZFejFoU0VJemJo?=
 =?utf-8?B?c3RJZmh0RkE1aVUwQjlYTzhqakVMb2NlcDNybVhVUkxXVkR3M0lkSXo5cDB2?=
 =?utf-8?B?TEJHREhyRzZOR2RHL210VG1qNWtmNHpwQlNsTGo3NDh0dm8vQmZGclRuWFVD?=
 =?utf-8?B?N2lKK0Q4cStubmNVV1ZMQWxCaHl6aG9jSEdKUU8xWnUxd05QMnRWK0owdEhP?=
 =?utf-8?B?dzJzaUc3Z1hncnRJMjBaZnA1bkRybnVBdXY4dWpIOW52K3ZDMmpZSlcvL1Bk?=
 =?utf-8?B?cEVNQ0ZPeDFBZVl6eXR5eDhCU0YzbklBK1lQL0x2NVdTQ3FUSFkza2FtUUxx?=
 =?utf-8?B?VnJGNGQ0UkV0ZTMwZ1ZvK0pRVmk1eDM1b2pIdndwamlhNENhLzhjbEJTeDJI?=
 =?utf-8?B?SEZxRHJGZ1RhdGRuby8xV3NrY3NwcVM2QlpUWTdRVlg0allJUFFFbVFWcG9C?=
 =?utf-8?B?Z2ljczZEL1lUczVTWTl6L0FlbGdrNm1SVGdUV0NCWnVXcERjTGR6akxJRG02?=
 =?utf-8?B?YlVOT2VnV0RpU2lNVnNpODhNUFN2MUJERERpeDlTa0NpNWVUd1BnUGtzTWFt?=
 =?utf-8?B?ZWlpN0dzc1JXZThwZ0JEaFA1SmgzSFgrbUdjb2ltSnBwSHdaeGFjOVU0Wno4?=
 =?utf-8?B?clZETnppNkxGUDJKUEdDUkhNQi9TZGp3aURsSVhJem0rSU5ySGY3djBiV2RK?=
 =?utf-8?B?OUhZZ2wzTWt0b053ZlFpMFFyTUxWbzJENW5jOWJUK0s0NWtjUGRwOW1WR1pK?=
 =?utf-8?B?c1pQT0pLVm8va3NMd0dHWE40d0xlTzYzN2Y5QUMyMHFzWHFtMnNOalZyVXhJ?=
 =?utf-8?B?NGU4WG5aSWVRa2ZOK290MW4reFlGTWVHZ29IS0lLakVRb0V6czVOUXFLYzRC?=
 =?utf-8?B?S1pGOWhnZzFndWcvM3JSQzVXeE5JNFZydXFYeUUzYmNBNUR3MDFCOWZqZHJ3?=
 =?utf-8?B?NWJORGJvd1c2QkdhV1ZITVBiWmVYemtlZnFTWkcvclV3M2xJbmZHWWU1cDlM?=
 =?utf-8?B?eWtPNUJONzZENmtJUmtNazJWTWJkTUc2dmEvd2RJMGh6TXhjR2Nwc25IeTBB?=
 =?utf-8?B?d3BMUHJ6cUh3M3pxNGg1MzdxYTgrUjh0R2dYNFZtbTloOFdXeEhmS1p5WFd1?=
 =?utf-8?B?YjU1MWFKM1laclprTVVVWDExbDd2NWh3MWVTaEN0SmRqNFp5QUJua1lucWJq?=
 =?utf-8?B?dU9KQTlhcm9KSElFMmt1T2hyRHJ6SGFVRE9tNmhORU0wbzRyZldTSUZtZjZq?=
 =?utf-8?B?dW5oMzUzSDh3ZUkzR3ZiZmhRemlnSjhlR0NGcmpOcUJyejJOQ2pySWcrUkxE?=
 =?utf-8?B?bGMwalA0Mk9HMGIyN0ljMXRxZFF6aThFNU9QQVpIeStZdzFGM0JhVGRUR0NG?=
 =?utf-8?B?Tk43Tm9ZTmNnQ3poM0lpbDVORGpab2xHUUpoeHYvVEZ1QU9lSXNBSkNPZHVa?=
 =?utf-8?B?V1h4S2pQWk55ditYcUsrRDdJajgxMTcrdkNDeFpiWXcrSUVvUDgzek5oYlI4?=
 =?utf-8?B?c2RFeS9zdXA4SSs0cGFsYU5Bb2pOWm5JOTdmN3ByamVPbnNvV3ZybkNPZkdU?=
 =?utf-8?B?Qkl4cUx0NndjTXEzOXBxWkQ5dncrNEZ6L1kzUFhaNTgvelprNTVLTTZ0RmhP?=
 =?utf-8?B?aTVJV09ueVI5MnY3Qmp2ck1JSExtWEpQSEVXcnBvZDVscmdJdk5OUEpldGd0?=
 =?utf-8?B?Ulh4L1kwM2hmUjhabkI1eGtmMGlkbUdiSzFsNkFxWDVEOFBndWZYMXJ0WExo?=
 =?utf-8?B?dXZxdndONWtDbkN5VmZicmNvVmRJU1dHdmJIY1VqdEFGYWJqQ3djMnRyTVcw?=
 =?utf-8?B?WkN1N1RtRDhuMmZ2cWdNVUFIMkhZakplL1NQcG1OcWUxM2FkZFU3TmIrQjIy?=
 =?utf-8?B?dkh2T0xtZDhPUU8wdndoRXk1Y25CNytuODZiRmdUbnA3NG90NWcwQmJ5MzFF?=
 =?utf-8?Q?NO+0453qSHwB68UMsgSMaC8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fMwu2Srk+2qt7Etvo26HWZdlrcQXjQp8OqVg/GrZkzO842OPIaI+tMRAu2RbLgcQd7NKvMplx7Kkm6/R0SDFoHtpaQnK9dR6LPkb3hNXwtp5r63DuNr2FD4tPEV89h0SE7aq+lGgqBnvqSDlAvJf1yywG9J5vVQM7R+meY/8uJojGjYBwYKuoIwZfVrEaPj13JnOmvMwh42dCDmz+Ttilog4k1fm8p2cFFvAUfsNfBah9PiAYTkmTf6gXHVW5ZXuOHXa2OPFfD2RDrYJxifergRa3bjGBklq3lFRvWmKxiVcYi9s7LXC8u+P4JsPO8H+ORtMV30C2XOCvmoB/vGhsNb+clDhOy7Cum3MK/iUr1srOJsjri9fEboAC9k6anuJoYpO+/9hm7pi+J6G+XBc9c9Uui6hRNRZFLQqKESPGHlkMbJbAIbv4vc5xpSyXUE76bm+xiNv2EobEkQ2Pu+pIoNIO6zd2FtKO8LPjXm6jbVf2klyNNBHAAPjUSGyPlQ5vIU4K01DCA167YaE2JapiWQlNCIuEdEnlANqHD0jIhCh4DRUEE6ySDfA39YNgXflw8MoM5GNb0LSw3DZ+H5zNPrVI7vPAG7nLr6F3ewSv8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40794421-8ece-431e-ef5e-08dc2cc240d3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 18:33:20.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8nqDhgzpZugykbGWi79WGak58HELHUlYSNAPl9Duorqmetz/cIGrw+o+8fWjCejjlT7PPTy/gdNtjGBglaayQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130146
X-Proofpoint-GUID: kRS7l8E3Aa5WVfQA58jOmngq5KPcZ2Tb
X-Proofpoint-ORIG-GUID: kRS7l8E3Aa5WVfQA58jOmngq5KPcZ2Tb

On 07/02/2024 12:30, Sebastian Andrzej Siewior wrote:
> On 2024-02-07 11:03:15 [+0000], Alan Maguire wrote:
>> On 07/02/2024 10:01, Alan Maguire wrote:
>>> The problem is the conditional check above; I can't see why it needs to
>>> be guarded here. We never want to do an address-based lookup for a
>>> variable and not have it be the same variable name as we have from DWARF
>>> - which is the one we're trying to encode, right? The following fixes
>>> the issue for me, can you try this out if you get a chance? I might be
>>> missing something about that check so other folks please do weigh in if
>>> something looks broken. Thanks!
> 
> So the former patch worked.
> 
>> apologies, but my suggested fix is wrong I believe.  When tested with
>> vmlinux BTF generation, around 100 per-cpu variables disappeared.
>> I believe the fix should instead be (deliberately leaving in
>> verbose output to help debug future issues):
> 
> no worries.
> 
> …
>> This works for both vmlinux generation and the problem you ran into.
> 
> the .o file was a reduced testcase. It works with the "complete" file
> here, too. However once that file is merged into vmlinux.o I get the error
> again:
> | $ pahole -J --btf_gen_floats -j --lang_exclude=rust pahole-tc2/skbuff.o
> | $ pahole -J --btf_gen_floats -j --lang_exclude=rust pahole-tc2/vmlinux.o --btf_encode_force
> | error: found variable 'napi_alloc_cache' in CU 'net/core/skbuff.c' that has void type
> | error: found variable 'napi_alloc_cache' in CU 'net/core/skbuff.c' that has void type
> | error: found variable 'napi_alloc_cache' in CU 'net/core/skbuff.c' that has void type
> | error: found variable 'napi_alloc_cache' in CU 'net/core/skbuff.c' that has void type
> 
> The -V output is huge and I don't really know what to look at. The
> skbuff.o skipped __UNIQUE_ID_guard826 and a few "NULLs" and the address
> for __UNIQUE_ID_guard826 was 0. In the vmlinux.o the address for
> __UNIQUE_ID_guard826 is 19440.
>

Thanks for trying this out! From what I can see, when the individual
objects are linked we no longer have the offset 0 that triggers the name
comparison. On the other side though, if we are not selective in doing
these name comparisons, we lose encoding of a fair few legitimate
per-cpu variables in vmlinux BTF.  So the question is how to thread the
needle in ensuring that the matches are accurate for cases like the
above while also ensuring we don't leave any legitimate variables out.
I don't have a good answer to that yet I'm afraid.

I think the problem of missing variables when the check is unselective
_may_ boil down to cases where the DWARF name is NULL (due to it using
an abstract origin reference); in such cases we cannot name-match and
such variables would be skipped.  We have some code in dwarf_loader.c
that attempts to merge abstract origin references and their referents
such that the name is filled in for the abstract origin-based variables,
but it may be that we are missing a corner case somewhere. I'll dig
into this further on Friday, but if anyone else has time to do some
analysis here that would be great! Thanks!

Alan


> I uploaded the two .o at
> 	https://breakpoint.cc/pahole-tc2.tar.xz
> 
> it decompresses to 1.1GiB.
> 
>> The explanation is that prior to this, we get an adjusted value for
>> "addr" to do per-cpu variable lookup, where we subtract the per-cpu base
>> address. We should also use that adjusted address to check for a zero
>> address in the test to see if we need to use names to resolve per-cpu
>> variable identity. The problem was the __UNIQUE_ID variable had a
>> non-zero var->ip.addr value but its value relative to the per-cpu base
>> was 0. With the adjusted value, we do the name matching and skip the
>> encoding as intended I believe.
>>
>> Alan
> 
> Sebastian
