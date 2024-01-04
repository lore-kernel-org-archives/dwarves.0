Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74F241E2;
	Thu,  4 Jan 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OM87bQZf"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404DhXrn010929;
	Thu, 4 Jan 2024 15:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=0nfSpFXnuzSxFRVIFkDl0QHg0g6qdeCPEI0Ae1IEvVM=; b=OM
	87bQZfbQwdYEPRHghvoiW6QpG6Qquy6M2KLFdQrIKhu0f+vzeEQuQF6BzN1NeUfz
	jRmVaXI1w/k6nIXogFOJ+/sWKB/1+gwLP5kRp9E9begDGKiIrU4IL5SI9x1dd/HZ
	+dZtzzzD9OsWQo9gNmUeDNNZZqeuhGAxxKMhTOTOJBdSFcCxqFrO0ghaQXSnQCxj
	DkTPsmNa2egP4mrqoACjZwSFTEfswOjzwBe7jn+XOcxa7hPk5lfHmJGqM1cf8hxV
	IgSIi0IjEbTroWDOufH8VDf27K0/N9AUphE2XOnjREzz1onDDIBw2z6sjnoELxos
	IcIdv+7uiRiCNgEeb+Gg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd84cuajt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 15:10:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWbQ7N9ySaOUDM0/4srR6BiyoMA02gZWG0QqRRjyXh6duw63xkSrgOVKP7//HuMoA/KkUdRvt4yLSdwx5eOUY/mi/7GEDFzS+DU3PDFUCG8DezL+9s+dfrD84X+XXNW8cuSRmQZx6W4t5n4gj1/otgEbIJiIa7P0ya22ad7aGObijQg9ZG3xeHAwBhXB70fAfTiYrmLBoI3CwW2strAZzTWuq7KijS0XodHM39oiP3o1jciJYXdfEpmVGjRystxVkBUK3Sq6WAAtslKd0lP+UMjGmUpSFc8u/NE74K0kKho3L00tzhPBjzO8s9GTtQywuSPDEN+DZ1U7n6GtjFW8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nfSpFXnuzSxFRVIFkDl0QHg0g6qdeCPEI0Ae1IEvVM=;
 b=Zokma879oUYHFRtYx/QvB/PrHAPQyTDOC1ygvZkPepbIgCPFt0T+d7en2c9hTyA4ja25LttI8wjt16Du1/DdyxynqtEL9PfLyJWZE8rULoebQ69UByRsG3y9haWN+Kp3gOK2UM78sTZJ44NwXw3puXe9u3kp9Qi4RqmkSl6yPNrr6HWAbJtMObTTqH4W5Fmaw3Wc7e6fgtgii+H+Z6n7V3NpRanY7dnAIlo0EtyJuKNw/nhmLZQH+ClJF3KCpDE34Nx8V3K6rg5xVoTMSNrYEOHuFM3PG+vCEc8GABblPqEK7MWeQi6SAD4o9pkR+WeKBswbfljqcI02+GyuEkrQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by BN0PR02MB8238.namprd02.prod.outlook.com (2603:10b6:408:155::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 15:10:32 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8%5]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 15:10:31 +0000
From: Brian Cain <bcain@quicinc.com>
To: Nathan Chancellor <nathan@kernel.org>,
        Kent Overstreet
	<kent.overstreet@linux.dev>
CC: Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo
	<acme@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>, kernel test robot
	<lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        Mark Wielaard
	<mark@klomp.org>
Subject: RE: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eep...
Thread-Topic: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eep...
Thread-Index: 
 AQHaMr4rpG0E0J8/iEqD3zuijWLkVbCxGIoAgACtOgCADAEDAIABBe0AgAA16gCAB8nEAIAAF2AAgAF4MwCAAF/dgIAAH2qAgAD/eRA=
Date: Thu, 4 Jan 2024 15:10:31 +0000
Message-ID: 
 <SN6PR02MB4205748A50077B6FBED4D3CDB8672@SN6PR02MB4205.namprd02.prod.outlook.com>
References: 
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X> <ZYKWxl9oQXODIoNe@yujie-X299>
 <20231227224338.GA267659@dev-arch.thelio-3990X> <ZY2EUr+EYzyro3NH@kernel.org>
 <20231228173404.GA412881@dev-arch.thelio-3990X> <ZZQ6CpBnqpBgxSgp@kernel.org>
 <20240102175342.GH26453@gnu.wildebeest.org>
 <CAKwvOd=AAuqKk4GXV0jWORwJKJ0gao2zVd_RYWXoA90A77c47A@mail.gmail.com>
 <f6moe6xstxuj2wrnqftc2w7kx4yrnjyoqnigxprvnv4ymtgre6@6ioujgedt72e>
 <20240103235543.GA696229@dev-arch.thelio-3990X>
In-Reply-To: <20240103235543.GA696229@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|BN0PR02MB8238:EE_
x-ms-office365-filtering-correlation-id: c86c69cf-a021-4587-d482-08dc0d374b17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hoLbbtEE5TsR/P+9DXMHWvhKL/V8lywMIUuX/x1S4jKCfNVWs1Vc72sGJyxZpOr00B7JZARai5F3yCMmiV+9HtvrX0vbKBUkpUn2F1jTmjq9QScMWT7kIYwKHDlSJJ2HdQsjlf5xoZ9G0Gour03o/f087tBAqRLTy7DAUhhGdgrxbUjSOdbnsFFRcQU3LZcdk68/031fg+5b37u5Bxl2OpZUWqQ4Y0U0ysMyUqlym+XozgEByVTLIp0QXgWHmbFKo3nL+JUr0hQQL/RJb6tNP5mPsN+SYiVM555Vtx0bbBkIMXEuYRSBhs7sxlkgB3EOy9x86vMgO7ZeoNbTTHn+hsYZxli3JYBNwtJi+N/RRyArVZDPkyxMJAJDSao50A7ksJhR9UiRnHwQFkNV/X5p4fZ2k4CfdaYrfe1iGE936A0Urfxllkd64b5rsAZaQEzrXbJ8IMckjMXe6XygjOTb5Dw1EluzUU7iaxFDYlkX4gJRzJiYafZc10B+C9X01HO3LTU4OzLwhHsYfQ3rRY4hF6nPEKKpN+mSD4y22GZfZPJA+lxF1nGxnjF65s3cXpls6oa/kB6Qr6YM3gr2Vkj1T6m26R+VALwLIx9wjdNTffNx18UJtqnFrn93tVNcIuOYFC5IWneZCMXh5SNuhUuf3U7YdFYjeAoI7JwSNHZwW3BZAmpiwdVA5y5Rw9IpAxBf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38070700009)(7416002)(5660300002)(8936002)(4326008)(52536014)(8676002)(2906002)(41300700001)(86362001)(7696005)(55016003)(9686003)(53546011)(6506007)(71200400001)(478600001)(33656002)(83380400001)(38100700002)(26005)(122000001)(66946007)(76116006)(64756008)(66476007)(66446008)(66556008)(110136005)(54906003)(316002)(219693005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZFU0Tk1paVQvR01NWmlwK2FkSW50azhYOTVBUmo5VHptZG1DRDdFMm9CZW5U?=
 =?utf-8?B?UVZNeFFUa2FRa0NFZ3RGSS9PMlZ3ekYyd0M0VTNUb2RJS1dITkp3RkF0ckRT?=
 =?utf-8?B?UHlpYW5PcUNmbzlBbjR2cmN2Y1plOUk1RFBJd3doN0ozRFVuNHlKSERzNkxH?=
 =?utf-8?B?T0x5cGxHM2cyd0pjRHZOaUhkMXBCNkJROVhmVEZIanZXMWwyamJFZ1dQdlJL?=
 =?utf-8?B?akVsZVVIK2R1dVNOWlQyL0JNSGFlSDc2M05uMThLcWdoNXY4ejdaRUdUK2Fy?=
 =?utf-8?B?Uk52VGt1TFpIQ3hEdkpRSG5XdUI5dVcwVHZoSWxsdXpHZm9rR0w5ZGphdnRS?=
 =?utf-8?B?TUZiT252Y1dnaUFPQ0M3eTBLWklPc1VJNVVER0JBS3FxL0tMSHpVS015KzFm?=
 =?utf-8?B?ZUYydHNwTVNUNE4rdHBzakNxN3VBVm13R3VhdGVxZzJ5d0VBS050U2FSc01Q?=
 =?utf-8?B?QlkxTTdZcEFvazRFUU5OS2dNdEdtNUVnQTZjeFNSOXdZL2UzTmlYMGxwR0FU?=
 =?utf-8?B?dnlybUJLRVluNXR2enQxbDhXNlpGY0p3QW85aTAwelJCTnNTaVYxZDZTTGJW?=
 =?utf-8?B?Wlk1VmhFYy9adG9ZN09nWTMzak11Uy9HWnBpYnNaVTZRMkVXeER3d01rcnhq?=
 =?utf-8?B?QmVkZmEwNlc3Vjc4NHVyWEkzU2JUa2lITDJaa1FlLzkxdVNtR0VMbzVuRExS?=
 =?utf-8?B?N1NCSG4zbTN2Z2lTZ0kyZEExZlZlcWdrU2NzQ2F3VlNZcllUSS9QSEdIZFRO?=
 =?utf-8?B?ZDIxUnBqeEI3M2tabkR6bUxjYk5uOWhPRzN4L2gvc04rWlUzWDBYUlRXdmpM?=
 =?utf-8?B?WVp0aEdCaGZmRGk0a3QxTDdyNUxGTm00ZXZxclpQZVhaVHNyS2EvRHZkSk8w?=
 =?utf-8?B?QWVUd0I3WEtWdC91MFhpZlRtOEhuZDBXSVVGQkxVd2ZVTUo1YWZXUVF5UkZr?=
 =?utf-8?B?bHJ6a2oxQUlBRzViUStQVDUxL1hpMEd0Qnl2TXVyUGQ5djdTbjFibC9kdmFo?=
 =?utf-8?B?T3hoeFR4Q3RHUXlsNW8zSVducjZsZ2xMNkhjaGdJeXFoaWc1MXRxWnVRajRa?=
 =?utf-8?B?TmVBRnMybUJpZjBRWThHQ2QzZ2lkUmpIWU9IeGdtS09zMEU2eHRZRXg5V1JD?=
 =?utf-8?B?Q2M5YTQ5WFk3eUk3c1ZCVWk4bXkyY1NKZXBEd0R5MFh3blhTSkl3YjVxZXdK?=
 =?utf-8?B?RzdUS2xWK2dmNVpYaWRoZUZFalJqSklNeVJhS2FxdkRqdGN3ZEFGWFF2NmM2?=
 =?utf-8?B?L21ERk55ZG5wWFRDckxNcElPUlJvbjVXNnFaRFozbVlHTVFhSnNDZmVySERp?=
 =?utf-8?B?K1VxV256OUVzKzU3aVR0NHVzUklBa1JBSXJyVy8wcDZiZ24za0RTcWtLdjRm?=
 =?utf-8?B?YS9FdFZuMC9ScHRLYlJjeDh3aENZM2o2VlREZDdya09nb3VzdHNrWWxpVjRM?=
 =?utf-8?B?RnRVOGowTEhObVd2bmhKajB6VHo1bXp1aUhBVGFyQ0dqckc3ZVZldDJ3Q0RM?=
 =?utf-8?B?UDgrUXRwY1JBenVyNTNxd05BTlZPT205L3ZpbTI0cTFtM0NGbFR6SVFQVGxv?=
 =?utf-8?B?dWZ1MW1CRFUwbnJpVXIwMWZnUElRTzJDZGlyTENjUUg4eVQ5QmF5eENmNUxJ?=
 =?utf-8?B?SVBzR1ZyY2ZVek81a0NBZjMxVHBTNEs1T2wrcXVoTlJXcXRzWDJsSTlaOWhm?=
 =?utf-8?B?QjhPM2RrcXEvTnBoT3cwWGNQUncrZFpUdHRnYTJyeVd6ekJyME9pdFoxYm9F?=
 =?utf-8?B?K01SZGRkNU5jS014ZnpzbVBoOFBiZTBJMjdNSUd0Y3ozT2NXU2lNUDh0aGUw?=
 =?utf-8?B?ZHpFSDNvZWJhZmR3RGhyU0pNODJ1UHlHajhKU2Y4N2JWZEhyRmlrOG1raGdm?=
 =?utf-8?B?d01GLzB4Y3NJLzg5clJvSFpOZmIxMU9TUjRWVStLa0ZYNDMrWmdnNGl3eEk1?=
 =?utf-8?B?eGtwWTRkaDlUVEVUSzBRcFZDMm14dzRGTnNyay9EKzdEWGRWb3U4dEZPMmVa?=
 =?utf-8?B?eGVsNDNiVzdIM04wRjVqL3JRdFM0U3JYZUZ3TTFKWmlUS2lQOC9MQitMUHg3?=
 =?utf-8?B?eldYQnMwSldGQ21vVlRld2VpK2MyZzB6VnByVElIKzFyYVNpVWpBdENTYndC?=
 =?utf-8?Q?O+Vw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6H5/IMP23qc/plNDtmYIJEo6QcfvXur6pBbSjbx7sO3JzzUSrAl/cwDYOMYvH59sBDFMlESdl3xt8e9HDu7FjFKjvxI9HKTQ4J3W+Q/psUaWsDVHBobrTk49UWLVRqV816bN0B4plFMAozi6UGSHEB9FzjSSovZtnsuhXjQ38MEbWTPac7uG9lBQXBgTXrQoa5oPVUSepKkCs9bLlre4JDQ2txPIbOmRqlMbejiWFa0wo/i+CUaCeyPXHjBxEvbO+f3+wXySYb+Gv7JbDFWemk98MfKZz1r3ViFW0yT8iFUGKqKp/+wi+/6uomQx2+OkSzfiZbbUKHWqWQWVptrf/pWLNkJOBQeFLlStktmEM6pA1KXPwWthOGDfc8LMABW4N/0/yHuNUnFJh41CloIH/LPhq334VWOBkiUYAiuZz0Mvc6fsIhkgQ2XW6/NqGL9EVZumbrCGQmX/Ab2kjDZgeaetDVozPf/rTQVREExxqRAa080eD9apat4FXHgtH0qkJVR/YfGusB2FD1FV1PYEO3NQWdSoisirKTYriTZYqE1bQz++yZcLV17ZIPzoKnJILGYDce/lQ3TiOymG9GRdN3mj1Onyw+RTFPZOKWiUmXy4Fh+d5U1bfKg+3g6m1TXm
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86c69cf-a021-4587-d482-08dc0d374b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:10:31.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qxC7CYl47AhRidOKTK9xdwdkSa/i/2W+p1KnHbgXcSjUoAGkjBWWkGN2+udFaElyaVVXA/T1s3W+9vuJ8vmKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8238
X-Proofpoint-ORIG-GUID: aHhhE_s6uCwW91z-5nvpPcuISWdA5TEZ
X-Proofpoint-GUID: aHhhE_s6uCwW91z-5nvpPcuISWdA5TEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040119

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmF0aGFuIENoYW5jZWxs
b3IgPG5hdGhhbkBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMywgMjAy
NCA1OjU2IFBNDQo+IFRvOiBLZW50IE92ZXJzdHJlZXQgPGtlbnQub3ZlcnN0cmVldEBsaW51eC5k
ZXY+DQo+IENjOiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT47IEJy
aWFuIENhaW4NCj4gPGJjYWluQHF1aWNpbmMuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxv
IDxhY21lQGtlcm5lbC5vcmc+OyBZdWppZSBMaXUNCj4gPHl1amllLmxpdUBpbnRlbC5jb20+OyBr
ZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT47IGxsdm1AbGlzdHMubGludXguZGV2Ow0K
PiBvZS1rYnVpbGQtYWxsQGxpc3RzLmxpbnV4LmRldjsgbGludXgtaGV4YWdvbkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGR3YXJ2ZXNAdmdlci5rZXJuZWwub3JnOyBNYXJrIFdpZWxhYXJkIDxtYXJrQGts
b21wLm9yZz4NCj4gU3ViamVjdDogUmU6IFtiY2FjaGVmczpoZWFkZXJfY2xlYW51cCAyMS81MV0g
L2Jpbi9iYXNoOiBsaW5lIDE6IDE5NDIwDQo+IFNlZ21lbnRhdGlvbiBmYXVsdCBMTFZNX09CSkNP
UFk9Imxsdm0tb2JqY29weSIgcGFob2xlIC1KIC0tYnRmX2dlbl9mbG9hdHMgLWoNCj4gLS1sYW5n
X2V4Y2x1ZGU9cnVzdCAtLXNraXBfZW5jb2RpbmdfYnRmX2luY29uc2lzdGVudF9wcm90byAtLQ0K
PiBidGZfZ2VuX29wdGltaXplZCAtLWJ0Zl9iYXNlIHZtbGludXggZHJpdmVycy9taXNjL2VlcC4u
Lg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBR
dWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBh
bmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBPbiBXZWQsIEphbiAwMywgMjAyNCBhdCAw
NTowMzoxN1BNIC0wNTAwLCBLZW50IE92ZXJzdHJlZXQgd3JvdGU6DQo+ID4gT24gV2VkLCBKYW4g
MDMsIDIwMjQgYXQgMDg6MjA6MTBBTSAtMDgwMCwgTmljayBEZXNhdWxuaWVycyB3cm90ZToNCj4g
PiA+IE9uIFR1ZSwgSmFuIDIsIDIwMjQgYXQgOTo1M+KAr0FNIE1hcmsgV2llbGFhcmQgPG1hcmtA
a2xvbXAub3JnPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBzZWVtcyB0byBuZWVkIFF1
YWxjb21tIHRvIHVwc3RyZWFtIHN1cHBvcnQgZm9yIHRoaXMgcHJvY2Vzc29yDQo+ID4gPiA+IHR5
cGUgdG8gYmludHVpbHMgYW5kIGVsZnV0aWxzLg0KPiA+ID4NCj4gPiA+IFByb2JhYmx5IHNob3Vs
ZCBkaXNhYmxlIEJURiBmb3IgaGV4YWdvbiB1bnRpbCB0aGVuLg0KPiA+DQo+ID4gRG8gd2Ugd2Fu
dCB0byBpbmNsdWRlIGEgcGF0Y2ggZm9yIHRoYXQgaW4gdGhlIGhlYWRlciBjbGVhbnVwIHRyZWU/
DQo+IA0KPiBUaGlzIGlzc3VlIGlzIHJlcHJvZHVjaWJsZSBvbiBtYWlubGluZSBzbyBJIGRvbid0
IHRoaW5rIHRoZXJlIG5lZWRzIHRvDQo+IGJlIGEgcGF0Y2ggZm9yIHRoaXMgaW4gdGhlIGhlYWRl
ciBjbGVhbnVwIHRyZWUuDQo+IA0KPiBBcyBmb3IgdGhlIHBhdGNoLCBJIGFzc3VtZSBpdCB3b3Vs
ZCBsb29rIHNvbWV0aGluZyBsaWtlIHRoaXM/DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL0tjb25m
aWcuZGVidWcgYi9saWIvS2NvbmZpZy5kZWJ1Zw0KPiBpbmRleCA0NDA1ZjgxMjQ4ZmIuLjFiOTM5
ZjU1ODNlYiAxMDA2NDQNCj4gLS0tIGEvbGliL0tjb25maWcuZGVidWcNCj4gKysrIGIvbGliL0tj
b25maWcuZGVidWcNCj4gQEAgLTM3OCw2ICszNzgsOCBAQCBjb25maWcgREVCVUdfSU5GT19CVEYN
Cj4gICAgICAgICBkZXBlbmRzIG9uICFHQ0NfUExVR0lOX1JBTkRTVFJVQ1QgfHwgQ09NUElMRV9U
RVNUDQo+ICAgICAgICAgZGVwZW5kcyBvbiBCUEZfU1lTQ0FMTA0KPiAgICAgICAgIGRlcGVuZHMg
b24gIURFQlVHX0lORk9fRFdBUkY1IHx8IFBBSE9MRV9WRVJTSU9OID49IDEyMQ0KPiArICAgICAg
ICMgcGFob2xlIHVzZXMgZWxmdXRpbHMsIHdoaWNoIGRvZXMgbm90IGhhdmUgc3VwcG9ydCBmb3Ig
SGV4YWdvbg0KPiByZWxvY2F0aW9ucw0KPiArICAgICAgIGRlcGVuZHMgb24gIUhFWEFHT04NCj4g
ICAgICAgICBoZWxwDQo+ICAgICAgICAgICBHZW5lcmF0ZSBkZWR1cGxpY2F0ZWQgQlRGIHR5cGUg
aW5mb3JtYXRpb24gZnJvbSBEV0FSRiBkZWJ1ZyBpbmZvLg0KPiAgICAgICAgICAgVHVybmluZyB0
aGlzIG9uIGV4cGVjdHMgcHJlc2VuY2Ugb2YgcGFob2xlIHRvb2wsIHdoaWNoIHdpbGwgY29udmVy
dA0KDQpBY2tlZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo=
