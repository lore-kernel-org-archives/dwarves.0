Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C311C280;
	Wed,  3 Jan 2024 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PJrEVfzk"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403FR0XG001792;
	Wed, 3 Jan 2024 17:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=RoSHOQRRdVxmjWtZb7CI/J0dgim+FGjw4Mp3qnY0vhg=; b=PJ
	rEVfzkEprvbJ0RJfIbKP7I9XlGfFX3eIV1uc9mS/4kYtmU6CIlnHX30fLyKUYo18
	YrZ0oxTfOQ3uJmnMKHxeS094GkynFNX+vRSmaU3h+IRiZRjsZ1QO/uqTPHthZqNz
	9UaYhixnXz5OeFL7uozC4gsYk70JM6+qag0iIg6J8Ps6ZVia2vyq7tvosJ95Y4aI
	jKiveAz6bTCX4Mxf5Lc8APuPLw5BreIfsUdtMwZHKUmzzUyjoBcClMPGIF7mGmvC
	oUj9ZnI1xpz01iZlqW2WYxs2g5k2LvIf19Fk9VBAOxNi2SDHovnDObkajqm1CS1Q
	9nu4rR5jp3gEn5Ng5aFg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd37y9ds4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 17:25:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBowkcLlOuh+r6b/50BRjIGVkVwiVG3wFf1ZmUFEvVkGcqMFYN/H+f5idnzT7oJ42Gi/qQJdbOxKreYLSFTY4K36U2VValaDMSiJDCkrZDzTRNxTfAPiUrY84elDQFqfL7H0fAxwC3AV9I3+rZYn43xu8dv38Eip+mlrtwMK+9lu9raDSKHwRoDhmDLjEUSipja6EdSA+EIIBHQzk1l8nspy3/FQkAX4fNMF2nVt0k2b32OowgXLY1dRNaF1cB4FkadnrkKie/LVU8VjZ/d4QBjZDPvi6F6hEgdMQea+9u1ApmrnemUnWkPtziP7kUFq8rUMir5ak464bAn0sMjjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoSHOQRRdVxmjWtZb7CI/J0dgim+FGjw4Mp3qnY0vhg=;
 b=bcjatETRU8xjbPLv9tIFsGkBxPuETZov0HD82XQypt7B7yfLI+nerocHK9hvfaHj8JM8RaaqRvyAExR7fGhOyqW21MvlYNY4Of1VZvsLo8UzokBQnjoK3XP+9XOoorPXfd8WP+Xlgwm/nbqE4L/UhPS1r32+QblPULwLMuw+hWfgr/mzUdzaYhmqX0VKtrUn+7XSNE5w5SGQnFKeAIsv3eNCMkBn9JyOsPMz1gSriKUx1RxKkrl/Ho91s1nQpZl1S7tjd+ljZzAm6qDW296hiHYfEHY24gWYKfI+EP9jogGWGAhPq6Lk0rz1wvr5lyBMTy3DLdD8JaD35WXSrkqr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by SJ0PR02MB7277.namprd02.prod.outlook.com (2603:10b6:a03:296::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 17:25:12 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8%5]) with mapi id 15.20.7135.026; Wed, 3 Jan 2024
 17:25:11 +0000
From: Brian Cain <bcain@quicinc.com>
To: Mark Wielaard <mark@klomp.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Yujie Liu <yujie.liu@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kent Overstreet
	<kent.overstreet@linux.dev>,
        kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        Sid Manning
	<sidneym@quicinc.com>
Subject: RE: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eep...
Thread-Topic: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eep...
Thread-Index: 
 AQHaMr4rpG0E0J8/iEqD3zuijWLkVbCxGIoAgACtOgCADAEDAIABBe0AgAA16gCAB8nEAIAAF2AAgAGJjvA=
Date: Wed, 3 Jan 2024 17:25:11 +0000
Message-ID: 
 <SN6PR02MB42057525427B47481F1934D5B860A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <202312192107.wMIKiZWw-lkp@intel.com>
 <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X> <ZYKWxl9oQXODIoNe@yujie-X299>
 <20231227224338.GA267659@dev-arch.thelio-3990X> <ZY2EUr+EYzyro3NH@kernel.org>
 <20231228173404.GA412881@dev-arch.thelio-3990X> <ZZQ6CpBnqpBgxSgp@kernel.org>
 <20240102175342.GH26453@gnu.wildebeest.org>
In-Reply-To: <20240102175342.GH26453@gnu.wildebeest.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|SJ0PR02MB7277:EE_
x-ms-office365-filtering-correlation-id: 935809a8-7d66-4a62-73de-08dc0c80f10c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lwVRXlqQ5eVPGPe1dIHpB4ZDk9PJTnQT3rlDWgpIcv+WAaRzZYy8KdOSqFCGjzFfKaEpu+8zxIvEGw0x5XCgEFE8LxnqlNc/YHUlhmGH6NjY1iVPYJ8q72Wijrb0LBWyxC8byl8hB6qiXCUn0kvDs9VUKa2QERMdn6+HD1Dp93TVE1NlxnNj06PXSYGnOmt1p6o38U8k36nv0sho173GOizJtHhiqnqH94AmIRq2gIB+f/5rNUwq2ascYjf6rDRvvakvYs6z79FG4kQNS0Pi1X1rXgWyPdzozQPvkQLi8NYhejr+vx4WAgFTK2IRUvCr1H7q+X3djmXvH6r44u6/UGvh1c9rpESasBiG/2Bmvqjb+PpCdqzEab/yv0FZmpgHy31otN2ZoFXDYHV1+H9xLSOJhTojfoYh4NoWuIo9e5X5NN58I0SFCPFozFcIifoce4M7Aa7oi62H6Re3TlXzUfXvWifWc8eezmV4Cr/HaykWPHgru4GwauBI/7G3HTWmUZxtv/YiscB/3V4cL8ht7lHcjO1LU7y39BBi/EizK1Avpu9juLlGS4AFiKzh/Ge1v9pleMIkSWdcScCH742LrUgOUJ1/o8fa5Lh8wFBVT5qPbvLi7ybrDpkV6r206tgCGTTpM2J9KNaIa5Tu9WaQ/dpj8Sq8QIbMmFsf8qs2/Kk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(86362001)(33656002)(66899024)(38070700009)(71200400001)(7696005)(6506007)(478600001)(53546011)(966005)(66446008)(55016003)(110136005)(64756008)(66476007)(66946007)(66556008)(76116006)(54906003)(9686003)(26005)(107886003)(2906002)(7416002)(5660300002)(8936002)(8676002)(316002)(52536014)(4326008)(38100700002)(122000001)(83380400001)(41300700001)(219693005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VUZ4ejZIcnY2bFpwUU9oU3NwTDhtUkxxRWVRL3hjTWRuQmNmemxuV1dYbzI3?=
 =?utf-8?B?eC9YNGFyWHhxZG5iVEIyOUthTmJ5dVJsS1ZQMnVSSk9rb3FzRitmeEhGWGJW?=
 =?utf-8?B?WWdULzVRNzl5T0R1YWtGVlY3ZzlBcDNNWlh1TWtxQkc1UlhsR1FXQUxSWWYv?=
 =?utf-8?B?azNTTzdPMU00TjY2TDZ0akx5RFA0UkY4SXpQQWVmMzlZbUNOcjNNZ0JseHl2?=
 =?utf-8?B?UjlZeUN1dENwUEZ5VGFlVzhwTmJlNkxUQXl1ZmhpMzVDMXJMSDNWMWtkVTQy?=
 =?utf-8?B?bm5PMHZzaFBKN3l1WjBBWFk5Zk5SZXlldXVqaXdSYnU4Z0ZSL3ovVFR2VWRD?=
 =?utf-8?B?V0swMkpUcVp1emJHZHpNdlpuU1MzUmQ0bkZpL2ZrWFdaZW1NZDNCTkZQc0d4?=
 =?utf-8?B?RnNOakJEZXZqZHkwQ1JNZFB1STU5NE93UmRQRU52clh5OVNLTU1FaVlzYnVh?=
 =?utf-8?B?dHNJOThzZGZjcXhwN3ZSQ0JSRnRaQ2JJS1FLS3BkcmRnUWgxdm1HL1ZlVTJE?=
 =?utf-8?B?SXVGbXFvNHBGOFg4RWJkMHNNRXhXZG1XWFB6cWhTZWhoYmpya0JwWndIUVli?=
 =?utf-8?B?RFhoNkhLNzNuNHduQ3l4Q3VNb1EyZmhjL21kSlR4ZnJSVVNwT0QvQmZ2VHoy?=
 =?utf-8?B?enc5cWU4azliVEp6VkVxNFpIaUwxSlN0di94YzdZNldLL04rSGsrd1ZsU3Fz?=
 =?utf-8?B?dG1GWkZZYjNzVWdpa1dUbDZSR3hEZ1hIaWVBcEZVaDRNbzhTYUZKK1hLVEwz?=
 =?utf-8?B?WUcwNExSV290Y0RZaUhhOWUrTDlPa3JzMWZIQWFVWXNHa2R1ZVJWZmVLV2w2?=
 =?utf-8?B?QTRpU1YrbSsvbk9DQkd5L0lBUWVqa1oxczdCbDQwV2JTZHptbzFpSnVUQnQy?=
 =?utf-8?B?S1pCUy9TYkl3a21QVkVFSG9lZFNrcXJWVzZ3cStLMVRiMmVqNzhVd3MwTzB5?=
 =?utf-8?B?TlU0cWJnZHI5eWcwenBqUFU5ZlVVcFpwMWRuaTRuNjU0Tkxaa3Vlek9DYVI1?=
 =?utf-8?B?eVRZZnBDMUlCdFF5cHN6VWo4eERVc2YzeFkzNXVrY0FyL0VnVmxHeGJrQlhq?=
 =?utf-8?B?QjFmMS8yTjdlQlRsT0RlZXAzbkkxMkNLV3BaTzdMdGVYZGs1TDVuNjlXcUxS?=
 =?utf-8?B?TmVBV3o1MGdHellmRHZqdzZ4VENwZWdjMElEV2RqOTBBYlhzUzU0M1FnbGJV?=
 =?utf-8?B?YnA5Ly9pUmVGTTF1UzUyRnpGSnIwd3BsNHhJUmhUV0Y1NFZxZ2ppMkdjVVI4?=
 =?utf-8?B?Tkxnb0Z6VmZLdzkzU1ZIUzFxTGQyMEdlam5Ldk10Nk9BWVlQdWRhOVRPTlB2?=
 =?utf-8?B?eHNxQUdxcXliNTdzZWhjWC9vekNtWWp0dkg2RUVLYVY4WjdYb0lCLzFtcjM2?=
 =?utf-8?B?dnViY0pNajRSYzVXNzRYY2lsVk1DZzVKTHNNZ2NsVkNFOHloZXI4TzNpMFlz?=
 =?utf-8?B?N3hyeGlWN0o5bHdLNkRxZUpCMjd3WkU5VHRKdWVNNkFwYVp0clc1aW91UzI1?=
 =?utf-8?B?WVd5Y3Q0MlNhVEVYaWxScWF0SkhvVTc5YkZOZlp6bEJPRmtxcVlhZGxPVzNZ?=
 =?utf-8?B?cCtpUW51bWJSZit6MEJzT29CUlVZMmd3djcyR3NZNmJqOW1nM1VOUmthRU5E?=
 =?utf-8?B?Sm5VMHNXMDNqVks5QTdNdCtFN3l1NDZZRE1GeUY3dzBjNDRwRUtiZmU0QmlL?=
 =?utf-8?B?WlZORDZuRW5QNDlLa2t4M05SUzdOaEFZTjhmYnRnMEdHeG1HRzBvcmJOcVB6?=
 =?utf-8?B?TzJONjhkcWdWSVRNNUFGNVRLUUVNWUd5QmNVc201TklDd3hOcDV1cmdmUzhB?=
 =?utf-8?B?QXBJM3ZDVmxjRDQvc1h5MzJlQ2JobkY0QmRibWoveEVQc0kvNXBZb01xa3hq?=
 =?utf-8?B?bElDL2thd2pRVmNPNG9HZGhiTjJHM3p3MzVHc2pobEZLc2RzUi85VUl1azVU?=
 =?utf-8?B?SDA4SWhpdWpQNWxBdlBQUlo4UkhHeWZhUU5vUHlaQWhkN0xZc08yeUlLNTJq?=
 =?utf-8?B?MlFaWURiUmI3VG5DOW5IMEFVTVpnYVJwN200UVlNZ0plQkU4Y0xJM1c0YWdz?=
 =?utf-8?B?M2M4cTN1SjR4eWlLZXNCa2Y4blpacGhnNWhjZ21TOWp6SExKZGk1WXA2YlZV?=
 =?utf-8?Q?56Pc=3D?=
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
	RA6V/qzwZxcCg+cyMGvRq1nf2I6UDyEfLdzQU1PJGtkxNJlLxdk1aoyj60Ku//kDgNPDOCO1dvHR1gGhuZ2RcUB7X0UHslLGv+2FPwlMbDdZLRMdF2TYCb9AFlOnHoBFiTQ3CghNHsPOUqaKlK5IvQaHVKhaMU3Ipzf4g8VlF7eGMw8U7mY9cJomH9LLQiHq76kaNCKjYYD5Qtjs4IoAyXGVtBHC8aH5Emh0x0gFS8B21bDmmeGxVXilYMrW2DEZT53e097I02rOjEPb8P4tEtCgop3uH7uU4+4KUlsuvixOklQqxnObHjIOIST1zBY6dFfbkPenfRhjgjaLxuHN+9btA0bJa1n4EcSPfBod604k8ZZMFNp5tzGVkdbUJi7n088qgiqlWJQW4kO/APYLyhCP/mDsl9htSLMGXULFKfwRXVab9C93jY/rBpI3fvIx2kR6ebFKu+cL50XCJIZjMpdPNP5JPhAoViL9LWgRjIscmdCf48n+u99yfSJDZBAnjnir597LxkCeAT0HJPIlGXV0bI55x+YWUw+fvMNvWuD5X5PTmnOZvdo0G4PBW2AvnF/2szEl9kEYDjezBd89IH1PbGzOBXIkpNumC5yxmSG25OGv/oW0HwNeY6z9FkZX
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935809a8-7d66-4a62-73de-08dc0c80f10c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 17:25:11.8920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Olt+ZgoSV/AlZppiQcSc9gkIGHnhgfc+Mqzq1mGdx9+RHr2jLBqtJGQyhAf4SiHn4jNp1E2daVTAj4yQ44J1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7277
X-Proofpoint-GUID: q9WQaoqx-HG2VBraK6UyC5dapTjfKEEG
X-Proofpoint-ORIG-GUID: q9WQaoqx-HG2VBraK6UyC5dapTjfKEEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030141

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIFdpZWxhYXJkIDxtYXJr
QGtsb21wLm9yZz4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAyLCAyMDI0IDExOjU0IEFNDQo+
IFRvOiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAa2VybmVsLm9yZz4NCj4gQ2M6IE5h
dGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz47IFl1amllIExpdSA8eXVqaWUubGl1
QGludGVsLmNvbT47DQo+IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29t
PjsgS2VudCBPdmVyc3RyZWV0DQo+IDxrZW50Lm92ZXJzdHJlZXRAbGludXguZGV2Pjsga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Ow0KPiBsbHZtQGxpc3RzLmxpbnV4LmRldjsgb2Ut
a2J1aWxkLWFsbEBsaXN0cy5saW51eC5kZXY7IEJyaWFuIENhaW4NCj4gPGJjYWluQHF1aWNpbmMu
Y29tPjsgbGludXgtaGV4YWdvbkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGR3YXJ2ZXNAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbYmNhY2hlZnM6aGVhZGVyX2NsZWFudXAgMjEvNTFdIC9i
aW4vYmFzaDogbGluZSAxOiAxOTQyMA0KPiBTZWdtZW50YXRpb24gZmF1bHQgTExWTV9PQkpDT1BZ
PSJsbHZtLW9iamNvcHkiIHBhaG9sZSAtSiAtLWJ0Zl9nZW5fZmxvYXRzIC1qDQo+IC0tbGFuZ19l
eGNsdWRlPXJ1c3QgLS1za2lwX2VuY29kaW5nX2J0Zl9pbmNvbnNpc3RlbnRfcHJvdG8gLS0NCj4g
YnRmX2dlbl9vcHRpbWl6ZWQgLS1idGZfYmFzZSB2bWxpbnV4IGRyaXZlcnMvbWlzYy9lZXAuLi4N
Cj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVh
bGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mDQo+IGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5k
IGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gSGkgQXJuYWxkbywNCj4gDQo+IE9uIFR1ZSwg
SmFuIDAyLCAyMDI0IGF0IDAxOjMwOjAyUE0gLTAzMDAsIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVs
byB3cm90ZToNCj4gPiBFbSBUaHUsIERlYyAyOCwgMjAyMyBhdCAxMDozNDowNEFNIC0wNzAwLCBO
YXRoYW4gQ2hhbmNlbGxvciBlc2NyZXZldToNCj4gPiA+IE9uIFRodSwgRGVjIDI4LCAyMDIzIGF0
IDExOjIxOjA2QU0gLTAzMDAsIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiB3cm90ZToNCj4g
PiA+ID4gRW0gV2VkLCBEZWMgMjcsIDIwMjMgYXQgMDM6NDM6MzhQTSAtMDcwMCwgTmF0aGFuIENo
YW5jZWxsb3INCj4gZXNjcmV2ZXU6DQo+ID4gPiA+ID4gSSBkbyBub3QgZ2V0IGEgc2VnZmF1bHQg
cGVyc29uYWxseSBidXQgdGhlcmUgYXJlIGRlZmluaXRlbHkgYSBsb3Qgb2YNCj4gPiA+ID4gPiBl
cnJvcnMgZnJvbSBwYWhvbGUgYXQgdGhlIGVuZC4gQXJuYWxkbywgaXMgcGFob2xlIG5vdCBoYW5k
bGluZw0KPiBzb21ldGhpbmcNCj4gPiA+ID4gPiB0aGF0IGl0IHNob3VsZCB3aXRoIHJlZ2FyZHMg
dG8gY2xhbmcncyBkZWJ1ZyBpbmZvPw0KPiA+DQo+ID4gPiA+IFBvc3NpYmx5LCB3b3VsZCBpdCBi
ZSBwb3NzaWJsZSB0byBwcm92aWRlIHRoZSB2bWxpbnV4IGZpbGUgd2hlcmUgcGFob2xlDQo+ID4g
PiA+IGlzIHNlZ2ZhdWx0aW5nIHdoZW4gdHJ5aW5nIHRvIGVuY29kZSBCVEYgZnJvbSBEV0FSRj8N
Cj4gPg0KPiA+ID4gPiBUaGVzZSB0d28gZmlsZXM6DQo+ID4NCj4gPiA+ID4gdm1saW51eCBkcml2
ZXJzL21pc2MvZWVwcm9tL2F0MjQua28NCj4gPg0KPiA+ID4gPiBTbyB0aGF0IEkgY2FuIHJ1bjoN
Cj4gPiA+ID4gTExWTV9PQkpDT1BZPSJsbHZtLW9iamNvcHkiIHBhaG9sZSAtSiAtLWJ0Zl9nZW5f
ZmxvYXRzIC1qIC0tDQo+IGxhbmdfZXhjbHVkZT1ydXN0IC0tc2tpcF9lbmNvZGluZ19idGZfaW5j
b25zaXN0ZW50X3Byb3RvIC0tYnRmX2dlbl9vcHRpbWl6ZWQNCj4gLS1idGZfYmFzZSB2bWxpbnV4
IGRyaXZlcnMvbWlzYy9lZXByb20vYXQyNC5rbw0KPiA+DQo+ID4gPiBTdXJlLCBoZXJlIHlvdSBn
bzoNCj4gPg0KPiA+ID4gaHR0cHM6Ly8xZHJ2Lm1zL3UvcyFBc1FOWWVCLUlFYnFxQWlsVXVHSE9V
OEJNTGJmDQo+ID4NCj4gPiA+IElmIHlvdSBuZWVkIG1vcmUgb2JqZWN0cywganVzdCBsZXQgbWUg
a25vdy4gVGhhdCBzZXJpZXMgb2YgY29tbWFuZHMgaW4NCj4gPiA+IHRoZSBwcmV2aW91cyBlbWFp
bCBzaG91bGQgYWxzbyBnZXQgdGhlbSBmb3IgeW91IGxvY2FsbHkgaWYgeW91IG5lZWQgYWxsDQo+
ID4gPiBvZiB0aGVtIG9yIHdhbnQgdG8gaW52ZXN0aWdhdGUgbW9yZS4NCj4gPg0KPiA+IGxsdm0t
ZHdhcmZkdW1wIGlzIHRoZSBvbmx5IHRoYXQgaXMgbWFuYWdpbmcgdG8gcHJvY2VzcyB0aGlzIGZp
bGUgb24gYQ0KPiA+IGZlZG9yYTozOSBzeXN0ZW0sIG1vcmUgd29yayBuZWVkZWQgdG8gZmlndXJl
IG91dCBpZiB0aGlzIGlzIHNvbWV0aGluZw0KPiA+IGVsZnV0aWxzIGlzIHBsYW5uaW5nIHRvIHN1
cHBvcnQsIHdoYXQgYW1vdW50IG9mIHdvcmsgd291bGQgYmUgbmVjZXNzYXJ5LA0KPiA+IGV0Yy4N
Cj4gPg0KPiA+IE1hcmssIGRvIHlvdSBrbm93IGFib3V0IHdvcmsgb24gZWxmdXRpbHMgdG8gc3Vw
cG9ydDoNCj4gPg0KPiA+IOKsolthY21lQHRvb2xib3ggaGV4YWdvbi1yYW5kY29uZmlnLXIwMDUt
MjAyMjA5MTMtcGFob2xlLWNyYXNoXSQgbGx2bS0NCj4gZHdhcmZkdW1wIGF0MjQua28gfCBoZWFk
IC0yMg0KPiA+IGF0MjQua286ICAgICAgICBmaWxlIGZvcm1hdCBlbGYzMi1oZXhhZ29uDQo+IA0K
PiBUaGF0IHNlZW1zIHRvIGlkZW50aWZ5IGl0c2VsZiBhcyBhbiBFTV9RRFNQNiAoUVVBTENPTU0g
RFNQNikgMzJiaXQgRUxGDQo+IGZpbGUuIE5laXRoZXIgYmludXRpbHMgbm90IGVsZnV0aWxzIHNl
ZW1zIHRvIGtub3cgaG93IHRvIHJlc29sdmUNCj4gRU1fUURTUDYgc3BlY2lmaWMgcmVsb2NhdGlv
bnMuIE5vcm1hbGx5IHRoYXQgd291bGRuJ3QgYmUgbmVjZXNzYXJ5LA0KPiBidXQgc2FkbHkga2Vy
bmVsIG1vZHVsZXMgYXJlIHN0aWxsIEVUX1JFTCBmaWxlcywgc28gZXUtcmVhZGVsZi9yZWFkZWxm
DQo+IG5lZWRzIHJlbG9jYXRpb25zIHJlc29sdmVkIHRvIHByb2Nlc3MgdGhlIERXQVJGIC5kZWJ1
ZyBzZWN0aW9ucy4NCj4gDQo+IFRoaXMgc2VlbXMgdG8gbmVlZCBRdWFsY29tbSB0byB1cHN0cmVh
bSBzdXBwb3J0IGZvciB0aGlzIHByb2Nlc3Nvcg0KPiB0eXBlIHRvIGJpbnR1aWxzIGFuZCBlbGZ1
dGlscy4NCg0KV2UgY2FuIHRha2UgYSBsb29rIGF0IHRoaXMuICBCdXQgLSBwbGVhc2UgZm9yZ2l2
ZSBteSBpbmV4cGVyaWVuY2UgaGVyZSAtLSBkbyB0aGUgY29ycmVzcG9uZGluZyB0b29scyBzdWNo
IGFzIGxsdm0tcmVhZGVsZiBub3Qgc3VmZmljZSBoZXJlPyAgV291bGQgaXQgYmUgd2VsY29tZSBm
b3IgdXMgdG8gY2hhbmdlIHBhaG9sZSB0byBzdXBwb3J0IHRob3NlIGlmIGl0IGRvZXNuJ3QgYWxy
ZWFkeT8NCg0KLUJyaWFuDQo=
