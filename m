Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797C29A3E2
	for <dwarves@vger.kernel.org>; Tue, 22 Apr 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310671; cv=fail; b=ANwuZ7N8n2JzJ8Wc6mfI/7g+LSaoU3a52vjfrG/D6Ttmepq/cbk3l02eTOyTS3BshDTNLz3nHhMhqobbDhLTlXsxuXVyATUtNo/JsQ8+is89qv92+dRdD5eKZ4F6HVX6X9IvkVKDLEyTs33B9p6wQZJHJVIdiz5e857t0TJDzWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310671; c=relaxed/simple;
	bh=UTE6pR7PeOOE5VdFUIu/XyLfaG/LIJRo17pgZddVzSQ=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=N60QJk+1WM+Z1bvOcP6br1asL4EocTpiCvfkbCN73wjve7YPQk0JJP526M3j1F7rWCJc1IvIuJigvInfI27xvW+PS65gIwYhSKYW+pgvaf8xXdR/6wkuauxKkzwLopzVYXsgt8aj9VbrfoOqgGUM/FgMOChj489lPjDoPRULSkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MpnZpiTP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DoiYDnCQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MpnZpiTP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DoiYDnCQ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7N0kg006201;
	Tue, 22 Apr 2025 08:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=A3W3htzpjMnVU19m
	13BQyr4bDyluJL2dcQTs/thtMmc=; b=MpnZpiTPGi7K13IhIRfWtuqmOy0s7g+t
	zu+IT33hclfRAVFhNnr04BpzNnIq88rinrTAUybd2zL0avqqU85MO25XkOo6/Rfl
	RN30mPdlaAE2ZDbgPXh78ZCD1cV1XX9HX8s4auvtKIqrG3zSGBNMtyiFZyMcHDri
	uHRB4aoQ0SlzizNFy2EvK615Rv+L6bw5hovGMUdCVcHQLJrzLKAw+2I9L6hdSHkH
	UJzd9hMiYplaZoko6zOKcuAnjCMu5HsQZFnB4wsevg9ZBKQDkUgpjODiZnvcXrYk
	G7j+tTXn6Izr1zijyzMHAXfyvVHzUF8LXMXiL82CDsVnYO4eogRy+w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0c0re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 08:30:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7hJFR010126;
	Tue, 22 Apr 2025 08:30:07 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012033.outbound.protection.outlook.com [40.93.1.33])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464299jqky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 08:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6IA8XIQ/A4YfdEFB3AGU2/V/BkL7DZbysXNx+wGTLAIaqZvNwtzeiabOoxTjT/uQ1YXhX9181bPMTyEPds/KSCwYXRpxDKUqxMzDKoLfbSJ0PoEeltav/SiSGq+2m+FlLk8oITrs0bonT4rYZcyDC0A628KnUFHGN3vFTj7CdP/wKtWKgu89L3NGrxgg3ECHcmeL1/UvZWM/5jpnVlmlLdXTuyS26dvzAt1ZTUS6iiBhAwxtFfvVbUAKVWZy+qxyqhwa9CEKjLOszbFZk9H13FlDU9E/M6TGhmoWtJEzGrlJ06+gy5RCBeT+xXkUI0WSwqi9olvtidBfs3gue6MQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3W3htzpjMnVU19m13BQyr4bDyluJL2dcQTs/thtMmc=;
 b=Xba8Q/wNJhVMbjExRCe3Q2JPcKT4EulS6LH0NPx2LRUfeMW7bC1CJaELMlu5PfDqp6qAUiQT48HRqm8B03Ta6321Y1sCk2gke9VBpYN83zMBvX4CHzuKRiTxuVcqi/AR/WKuejyTwKHZ8U/RSVm9Kz+qflhFyH5UNhryl1zkyH30ccbFu4D4N7ZZeU2TMuxaFJc2DfP992z2DVgsAl27/gz2M8RURTegmE7DuvctIaidj4z8Mdt14Td+zU5luDjsvjImItw82fSG/tt+6wCtfqNj2pFYlk4Ls5n6ShbV6ptQyXqa4ofXXjpgk93Eet+fPFDVqABjPq53Jm9ACJNRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3W3htzpjMnVU19m13BQyr4bDyluJL2dcQTs/thtMmc=;
 b=DoiYDnCQPGVo2jfQEtSSvecsKINnr0qFHBYCYHd9SnegvU5vNNkdK5cxuZGlZWy/m4w7k9GqdvwlY8mF6kD70zQzXUL2+v6SSj95NFd2+iR0JqdCZ9m747UGE+c0vq/MLEFhMR1tJmrDuHmmKxVTBSggcsWqqvREMH++CLQ8OPQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:231::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Tue, 22 Apr
 2025 08:30:05 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 08:30:04 +0000
Message-ID: <0f31b6bf-7622-4a32-85cc-b69c4bff2b0f@oracle.com>
Date: Tue, 22 Apr 2025 09:29:59 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sami Tolvanen
 <samitolvanen@google.com>,
        Jiri Olsa <olsajiri@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sam James <sam@gentoo.org>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Dominique Leuenberger <dimstar@opensuse.org>,
        Dominique Martinet <asmadeus@codewreck.org>
From: Alan Maguire <alan.maguire@oracle.com>
Subject: ANNOUNCE: pahole v1.30 (BTF type tags for arena pointers,,kfunc
 refactoring, github CI)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 65feb47c-c6d7-4316-3e4c-08dd8177e1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU5IWFQ1TzVjS2dxSmkwb21ZTDFTbXBwcFcrcTQ3RFhiZ3lMNHZEK3VISmhG?=
 =?utf-8?B?ZkRyNUE0SExZM1lyN3hVU1JKN3hKQ2lYY3RUdFVMTHNDVjFGVFBvazE4S1Fu?=
 =?utf-8?B?WEZpUFA3bG5EdjJHOUF6bFA0NFJaSGJSTmk4czFNYUhNcHpyQWtNbVMzcW45?=
 =?utf-8?B?VDA5STB0dEpkdTBpMDI1TXExc2srelZSN0lVdm1hVkJjTldrNG51aktvL2U1?=
 =?utf-8?B?YWlieUlIREJQdXlhejg0NkNFNFlISkM0Z1BkN3FOdVphWDhvUkRkZWFCWHM5?=
 =?utf-8?B?Wm1Bdiswa3pSNmk3VXNsNmlhbkNwR1YzOE9ZOHcvaW1ZWm5GWFRYKytOSUE4?=
 =?utf-8?B?VzdYNlFoVG4raXAxT0kzSmZmV1Zlc0FkM3BXNkN4aVY4UEZ6YU9lS2IzSXds?=
 =?utf-8?B?UmdRRHdRSHpjSHJDanpLWmlCMzVqU3N1QkVML3lLOVpqUHM5d044MC9nZ3NN?=
 =?utf-8?B?VUEwb29lMDBtcmQ5elJxR2dJQzc4SGJMc0pBWm5DYytqNENObkZHRUJFbVBC?=
 =?utf-8?B?ejByS240VWlkU21FTG4zelJleGRjTklQcXV3TDB4bnk5UFQ1UDdEU1hpYW1R?=
 =?utf-8?B?SUN6amJieVRoZGZNY0RpanpITElmWHQ2REFLR2NCZ2tiVVpSc2dyNWxwLy9C?=
 =?utf-8?B?OVJOSTdUaUpDV3JXNGJVY2hFaVNUbW93K2VrQ2t6dWozMEZ2ckpsS0FVSUpC?=
 =?utf-8?B?V2xFSk5FVDE2MUEzNkQ1TmJ4SUpPRjhjeVJiZEFjOFRrd2w2d2NYQ1JFQ0F2?=
 =?utf-8?B?UUZxTUptV0pMVmUvK0QvcitEWDhlYW1SYy9lK2hzWVc2K2V5Y1JPTkFYcEI0?=
 =?utf-8?B?b3QrS2JlbFcyQml4SFlwbjRuQmxZR2FEV2Nnald1WURIbVp0YitmOXpNWjgy?=
 =?utf-8?B?RVVlbUZockE0Mm4wbjN4d0twS2JYS3VVR2piS1ZnVmc3QnEwcXVjMHJpNmNX?=
 =?utf-8?B?UHRSTldJb2w5djI4cDJCTVExN1VhTGhBTjZUZUhuL3FZQ3R5WlVFUjNjWmlo?=
 =?utf-8?B?MkZ1VzJIaEFOQVdJOGs2ZlpZQU1aWFVYTDFCd3BzVDVDdWV1TmE1RENlZFVa?=
 =?utf-8?B?SzZDb0d5SlRqck5mVFI5YXhleFZSM0ZkT2UySEVmK0poU29TVGIxb1g4UzBE?=
 =?utf-8?B?TjVKb3JZa3p1LzlGNmlaZnNJSjF4MWtDRk0vcy96WGlCbzJQb1UvaGtLRGM5?=
 =?utf-8?B?T0gybTRWbWZmcWdlZ0htT3VzOURLUHJEbmh6OXdoUjhSVUpyL2liUlBEUVBv?=
 =?utf-8?B?Q1hxZDE4NWFPZmQ5SWdTNlBxRHZSWE8zUXc0WGZXbWJ6L0UvbFVnVXJoYnhM?=
 =?utf-8?B?bXRQbjA4VnUxZEhjemtJRWhKWEY5TW5jOEEwQXZiOXBmQ2YzejVYeGwwYzhQ?=
 =?utf-8?B?cnlheWN0ZUxKMWVtVjNQSmtwYXhTVDVkYmZlL3hTLy9zRVhDQkFwdkJrU1hn?=
 =?utf-8?B?OXltcElFQ01vWEo3eVFwTll0eVFxdEFNR3dESFJHWG5SZ3VidXQvMFVjMEx6?=
 =?utf-8?B?MkZUZy9WL0lMTVJieUlCWnJoME0vNXFRV2E4V29ud3Ric2JOeVpwNnNpTGxx?=
 =?utf-8?B?RGR1dlJwQ1FuWWozcEZvMi9IUjNKK0lJWmFIRXBKOUgraU1HWHR4b3VxOWYy?=
 =?utf-8?B?NjNwZ0RGWVFRcHVNdGIvYWF4S0ROZXY1OVg4bGdqOVc0QmxNNFNnb1lFa3RM?=
 =?utf-8?B?MnhZaGRNZjlKWjFRMTA5UU1xeXFoZW1ZNjlmc1ZjYjE0ZTNTVTBCZzdZbVlG?=
 =?utf-8?B?TFVZZUk1MzFsMnoyZmtyTUdJaEZPMjl4T1Y5ci9YOVluVGF2MG5YcFpkYUVk?=
 =?utf-8?B?eWVvUDRTQWRHRGlMRTZWYTNLalR6bXpRMVVqbDBDMG1FbkU3RE94Y29ZRDRp?=
 =?utf-8?Q?kFszyxhmzh8Ee?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHh4S0FDa3RIeXhaSDhCaW5lOGJ1M2dUdFJZMElmbVRXc0hqQTArZ1ZrWC9r?=
 =?utf-8?B?T0p0d3JFUVB6NmVBMEtBZGF3MDZIcVVYL1pKdUhVaVpoelZNMW9yOWE2S3ZC?=
 =?utf-8?B?YjBVSkpoQ2pNRGhiL1ZxekU4WENQM3d6eHFWenh1dGJkOXJGOVBsQ1hoVkhH?=
 =?utf-8?B?SkxBb3IzSnB4T1VTeFozYUY2R01DKzA3eE1rWDgxNllFY2JxTnQvb0hmbnFW?=
 =?utf-8?B?aDc3R2lJVmhXZzJFWDdXNzE1T3UyZXhucTROUi9hTkpHZlNxMS82ZlVxOE9W?=
 =?utf-8?B?V3Y5NFpqQVVOZFhWZ2VSejJXTDNDZGs3bDBBL1lGZE1id2FXQzUva09XS09q?=
 =?utf-8?B?OUpDdmJ2N3VMOUNwQ0ZDTElYQUF0OEQ4L1BWZlRrWEdjRjdrOTZnRERZV0lt?=
 =?utf-8?B?ejJTZktlN1MxVjZuQlFPcUwvbjdKZUIxU1dXai9QV0ZTMXFCYTZXTzFmcWZR?=
 =?utf-8?B?c3I0WjZvaDlYKzZHQ2R5SG9iYjlUd2xPTnpFdFVuNUVMUE94NzFjRVk0QmNx?=
 =?utf-8?B?a25PQkpIcysvcm9USFZIMkFzbUpUbU5ZNlNIY09WMFdyVTFYUlRUY1cxbnlz?=
 =?utf-8?B?TlNNWWFPcnF5N0Y4TjdVWloyeDg0eTdQTllNblJGWkFqMU5WYmVRWEFNRnlI?=
 =?utf-8?B?SVV1MmtMcmI2VUFrSTFicFk5bFFmZkMxRmlxbDUwQnhqZHpBbGRlL1hYNnlC?=
 =?utf-8?B?Tnoxd2JDWWdQZDhlS0l2RmlCZ2dxSzE0bjFSQVpXNzFyY2hFUlFFS0grWExa?=
 =?utf-8?B?SWVWYStPRXBveGhRV1lhNXpiQWQrZDNncEczQ2JlazdPNm9oRE55bVNlRGhJ?=
 =?utf-8?B?OUVuL3k0cWR6YTRTVkZBWHJyNFRucDNRU2YwWFozUWhJVVN6dzNqVEdBTVBI?=
 =?utf-8?B?ZzRlcVNNbUJ3UVZ0V1VabCsvclhxSGVlOWRhZWRjN0Q3eWFBVnFITGIrYzJI?=
 =?utf-8?B?ZDRZcE14TmxqUzI0aGEvSzl2c3VhamFnejVHdlR2NHdXdHZGa2w3ZnFVeDBB?=
 =?utf-8?B?QTF2RWhPL2ZXd2JvYWpGdDRPSDgyaG9rOEJZMVY2ditSZDY0T0xBeWhHRXFG?=
 =?utf-8?B?REd0anVZejRmdnNHUFNBWFlFZFA1NjRESTRvQlZiUHNXQTdHbUZKbmMveHhV?=
 =?utf-8?B?cDhFelBPdWt6RjV0eFUzSmJjcXQ5V0hoOG5ITlQ0ZWRTc3QyKzI1QTdtZVc0?=
 =?utf-8?B?Snd1MVFVajA0WTZmOHl4c2thazI0T3Z1NEloOXlvOVpzLzJSb0w0bHdUNE5i?=
 =?utf-8?B?YzZqVmxFTjR6SFIyWjNGd0NyUmlTV0RwNUxqZXVIaElRbjRLVFZCMDBLdFFF?=
 =?utf-8?B?bTN1alVleUMzbDRkcTRDdnVGMytiUU9zOHM3UC9sdklGOGRlQ3hnUTFLNzcz?=
 =?utf-8?B?RDdsM05rSk1NbmR0VSs3Z1B6KzdnQ1RmMjlwb2c3NzZtRXRkKzgwNTNUMlFy?=
 =?utf-8?B?Ym5vaWFLN2R0RmJoY1BudWxpMWxnLzRLcnc5ZHhwdjZsSW1nQ3Z6Ny9ZelpK?=
 =?utf-8?B?RTZZYnpPWm43cHFSeHU0eUlCcEswU3pJbzdBcmI5WnNyVnpvKzgvaEtvWTJ1?=
 =?utf-8?B?emZHT2NHYWhRVFFRSHRkWTVmYXdpRDR4RGZBWlJST083QlFPcHVZd1hYdno3?=
 =?utf-8?B?WlgxYURuYlNreHppTTV2V2J2ZndodGJ5aTV6SXhGZTFxM25pdWJ3NDh6cVhL?=
 =?utf-8?B?bVBSR21XbXVvUnA0Q2ZZL0t0R1NIbkhROG1jTytXRk5Ed2tLYXRJQXhZWnFU?=
 =?utf-8?B?WU5ob2YyWEZVNWY1UWVXVzFkQ1pQUjBucHVHQWRVeXA0eVgvbjY4VDB5dkFV?=
 =?utf-8?B?TUtzLy9OVUo3NTZQQ1g5QnBYRmg4WVhUNG5IRDZndUtuaExGSXhLeEFmSGpl?=
 =?utf-8?B?L1RneXJVVVJjS3NucS9FQ0swVXNQTUM3eHJaczF0RjBheHNNUEJzNzZkUjF4?=
 =?utf-8?B?MGV6aW1FcDVCU1JGVEg1TmRzbDRPUk1hL1RjZUM3R01tQjFlbXlrM2hHMnZx?=
 =?utf-8?B?eGxxaDYxang0eEk0RzJ3NkI2MWZRV2k4NUlaTGlVNnZjYnpaTWEyWUVkZWRi?=
 =?utf-8?B?a3M4Z2xkYjNWQlJVbEJ6YmZrTDZZZDRDcjFSOGxFWmR6c2FDZ1FNQWUzY0Jl?=
 =?utf-8?B?dWF4dmdVb0YvcXpYeXBhOW5zcjlvOVBhUGZNMWp2T1g1cm9VSVZtNktlTy9y?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zzYD61fc7xsbnt7KTBD4bketnwkka48GlGDOENlBOqXAV1TqMpr9cJKrtbP4qFpgLzQ3puVPTFphvWptLNFAAC6RO3vLcFMJTuNxXr3VHavTEhH645vYOeCgP0Fah1/gU0PQnGyfBXtqGprjGqm7ygLpdyq2uFAj7pSOE0dZd0Q7yk6UZNe5l0wYzoFagctjCKwkhsDZ0GwdfC1decxho9ZpilOYCTgdMoNi5UrZo20rolirAO2100OCyeS83jEodiVZwD65cG3MzogGK4gN41p7ApO6etM732XOf05uA5IP97tX71MGn65k7FvWsTsWeQebdkrLRmlijDqzVpFsy1ysVff1bzu1hG+gURycr2iRdxlD6tsluaswTFcFk9ZJlaZTWu/GHqf6MSUtW5w+2BzcDHOR1igWNMPsqk0X9A5i/guOhaKrFtPFG8e72t7KxT0UHJa/CzXMMGte0TOsHQ225HvHiBPK9csVLjDI+HJHpfjVyPjww652FGq7VevurCedkM0XMmK8aQ6DgK8MHNrkoeFfccHMhQgnqMw4j0MG/JvROW32S94N50VCheBzB/wqqKb2MFqgHdNpNdMii5KX8AnmUrPNFisi9++2TDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65feb47c-c6d7-4316-3e4c-08dd8177e1c5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 08:30:04.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKhgIIEH4LY/ixIufywZpYznCCsdnS/RmBqKxUsewcD/gNMp4+jjWNEUJcNZtopY6r3m41E8sU93KyZbE+KFGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220064
X-Proofpoint-GUID: As-kOHXqAhEP_Sv_raJj8NFsCmbhubIj
X-Proofpoint-ORIG-GUID: As-kOHXqAhEP_Sv_raJj8NFsCmbhubIj

hi,
	The v.130 release of pahole is out with github CI support, better abort
handling in the DWARF loader, more dynamic BTF feature detection in
libbpf, type tags for arena pointers via the "attributes"
BTF feature, refactoring of kfunc tagging, fixes to global variable BTF
generation and memory address sanitizer-reported fixes.

Main git repo:

   https://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.30.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.30.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.30.tar.sign

	Thanks a lot to all the contributors and distro packagers,
you're on the CC list, we appreciate a lot the work you put into these
tools,

Best Regards,

- Arnaldo and Alan

CI testing:

 - support for github CI tests to build pahole with gcc
   and LLVM.
 - support for github CI tests to build pahole, a kernel
   along with BTF using that pahole and run tests.
 - tests can also be run standalone; see toplevel README
   for details.

 DWARF loader:

 - better detection of abort during thread processing.

 BTF encoder:

 - pahole now uses an improved scheme to detect presence of
   newer libbpf functions for cases where pahole is built with
   a non-embedded libbpf. A local weak declaration is added,
   and if the function is non-NULL - indicating it is present -
   the associated feature is avaialble.  BTF feature detection
   makes use of this now and BTF features declared in pahole
   can provide a feature check function.

 - Type tags are now emitted for bpf_arena pointers if the
   attributes btf_feature is specified.

 - kfunc tagging has been refactored into btf_encoder__collect_kfuncs
   to simplify from the previous two-stage collect/tag process.

 - To support global variables other than per-CPU variables, code
   was added to match a variable with the relevant section.  However
   variables in to-be-discarded sections have address value 0 and
   appeared to be in the per-CPU section (since it starts at 0).
   Add checks to ensure the variable really is in the relevant
   ELF section.

 - To avoid expensive variable address checking in the above case,
   filter out variables prefixed by __gendwarfksyms_ptr_ which are
   present when CONFIG_GENDWARFKSYMS is set.

 - Memory access bugs reported by address sanitizer were also fixed.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQR2GiIUctdOfX2qHhGyPKLppCJ+JwUCaAJvAwAKCRCyPKLppCJ+
J6A7AP9SeOQvLKD/C5o+cP44jGOY+R1aBWjZRDC10EGMHKOmPwEA4L147vcTPREz
e5NDIeP2CSIdLNyLSMo0c0Iuni77JgQ=
=AAbI
-----END PGP SIGNATURE-----
