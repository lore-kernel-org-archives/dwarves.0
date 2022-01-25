Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E4AC433F5
	for <linux-dwarves@archiver.kernel.org>; Tue, 25 Jan 2022 19:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiAYTje (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:39:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57230 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231304AbiAYTiR (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 25 Jan 2022 14:38:17 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20PG8e26029989
        for <dwarves@vger.kernel.org>; Tue, 25 Jan 2022 11:38:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=st/SfojEeS7HJDt0FKQMimV0W3RcCvtKZFAXVYIeCaw=;
 b=hfRBe1cQGi5Rnzl/O9+qNOJ2Qui+FVufHO/8X0yLkGZHwEekDzcWJKQdl91xt4BGyLKb
 GY+XuHPoWMhIa8l5kK4imRl7afnK50aMX+py36NZ0CZFc5p4BtW2b62gLkQ8N9y6maR1
 +bExPVxp/TqCJHJ3hKdi+Ke7XCt3T0GmYGY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtgsv2x0w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Tue, 25 Jan 2022 11:38:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:38:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkGdOWnaF+Xb1MU7ZDGYHttWSl8hzoUCv+71vu54e02bP21jmkW3XY1+i4T06dBG0qmT1ErnARtRKRUrcVGR9llgOLvfrtchbpWoHv+BRH9dcJ0RmxzDhrJuTI/ccQyHcr9f1UopNsCAJKn3YQORFsLYWbjM2v4EM7DO0o/CLNQK6ZCZxZYzxlbmzxRp1yvOluvQMqwePRBHX+GAvPz6Rm/Gxsz1DdZJyjm4q/KsigpM/zmB4zK4g0o2qE8jP155y86+lRpmjwlpKXnpmwKpQcqIkTS1AhHfuaoo8wJOgFiIKmg9aaR+qyUrcn4yJogRbSi2DF/GiOxYoDXgZ3IvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st/SfojEeS7HJDt0FKQMimV0W3RcCvtKZFAXVYIeCaw=;
 b=LJaMPSUuwR+1NqqIrTq+ICR232YRjGhQI593Um4CwkrcZk/p4JcO8ojQkq9oj0hnPK6qG4/zE8uzmwyUfmKFrJUmMb7RsM8cjTJvbTU68BGvSNxRdKiKdD26KLw/0VnDz8VgOQRoi82xL40XQFXr7eV2EFFj6AlcfRGVMM9+Y20eUHtyM0ufjXjcSKeIvavbYUN7U884FPkX1GVfESF5BLMHNu8t2r5xrhctW1cK65/5NARSrJwY1dZ12aLaHOlp7vIIKf3MOK910ztz7+UMSpQDBgBO2dMqYksR15Wmcv0BFwGJ62faW939zCbIPHmp3JMZAtxuVhBld0zc1WvLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BY5PR15MB4290.namprd15.prod.outlook.com (2603:10b6:a03:1f9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 19:38:04 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24%6]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 19:38:04 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Subject: Re: [PATCH dwarves v2 3/3] pahole: Use per-thread btf instances to
 avoid mutex locking.
Thread-Topic: [PATCH dwarves v2 3/3] pahole: Use per-thread btf instances to
 avoid mutex locking.
Thread-Index: AQHYEVdiT8yG7rz/aUOGA9HLHoj45Kxymw6AgAGIWwA=
Date:   Tue, 25 Jan 2022 19:38:04 +0000
Message-ID: <8cbd916060c08243bb9b1b335cbd69c3f961d30a.camel@fb.com>
References: <20220124191858.1601255-1-kuifeng@fb.com>
         <20220124191858.1601255-4-kuifeng@fb.com>
         <CAEf4BzaZSw7kG-ohiff-MDgFMR5BpZB-4VZotO2M2y=tYyooQg@mail.gmail.com>
In-Reply-To: <CAEf4BzaZSw7kG-ohiff-MDgFMR5BpZB-4VZotO2M2y=tYyooQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aec33c48-3ed4-4684-27ce-08d9e03a34da
x-ms-traffictypediagnostic: BY5PR15MB4290:EE_
x-microsoft-antispam-prvs: <BY5PR15MB4290E009FAAD5ED567B86258CC5F9@BY5PR15MB4290.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTXh4TviOFKBrFCfiiIQE83JXhTyPlCYOk3PtkNrrdjePOLyoVn+Hq4cJnIHrPtYC70AicprBMflWyBdtKufvvs0YbkygQUWPCsdwttlB+73Rd5y1ywoRvAjv1OM4r9B33uovJGT+pbYvjU2hgKkKyjbYduj1nBtyQ6EdMQPBLt+bMm+I6U15ZecCx6ysf0mqa3LEyC2KOk7lTwjr6nRh088OJuRBMSQMi6nH1leyF0ACzhHD7leoqX0ZxyomfUNYYm8ef/6ONluMLuhI/5JuAYxM3Fl9z0Py51Us39tkXbspO/sR+SyIrPkwy/XoufCWorYJKQoLoQXb9of5pz8VNQMJ1H6GYXuqwJsf+l6fzexHB49XTAeDC08v3/YBzhjdnyq+NWtf843tkAvlGQdGogm0zc/jfLHJzUqRshiHZ89MlPOsQhUFXYnbyRQb9yfgmiGt4YtawrWS0doe3qIa6suvzTJhLnXWGhHkjIaMTVB3u4ZEpLrZJmgzDDCYRVEJJgOkqEYsqsf/iCCdJ08G0R6zG/p6CeFRxdOYUiD2Sg5M2qBsWJhomqtG1VRQAOeR26WYmFJNd1D88qctZB/F8ENDe+dtytDS3gb29uV3W12hZyQlTS+04NbC+YgLrt5shWKCC7eaE7PqSNsxnRuwN7DKbNirN/P4dUKgx+d/G0Xls/UFTqYOT6KnMWFaRPoxaIVZQWy1PpecLdxUiBGUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2616005)(38100700002)(66946007)(64756008)(76116006)(66556008)(2906002)(66446008)(8676002)(66476007)(8936002)(36756003)(4326008)(5660300002)(54906003)(316002)(86362001)(6506007)(6512007)(38070700005)(71200400001)(6916009)(508600001)(83380400001)(122000001)(53546011)(6486002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHd4MWdzWmk1RHpGUXdYOFVZSHRQVk1FR2dwa0JVWVNQc3pmcGFBUUZDaGFD?=
 =?utf-8?B?ODhJR1lDRm1KU0JEUUllRmhldXdma0ZHSzZkOENRRzlUUURPcWhHZEdiTGVx?=
 =?utf-8?B?cHMxMWI0QUprTzhtSTZVM0dET2N4Z2h6aTVuNVZDMnZjMUFQaG5MY0xpcDBp?=
 =?utf-8?B?aXVjSlIzd3kzYmxoVFRhS2tMM0Zwa2xJUGk0TndUNzFObEtDVzJTRmFXekw1?=
 =?utf-8?B?Z1VXZDVkKy9BR3ZrbW4zTFFxSkhsNFRWdnFGMFhJN1dueWVFNXljUy9EVFd3?=
 =?utf-8?B?S3RJQkpZeTFrVzNjVXZYUVpOV1NwWnB4eU5ETnhXNW9pNEZCZUs4NHFQcGNO?=
 =?utf-8?B?UHdqY1pTQWNiTFFoUUV2Y2RaN00vR25MVzZQVGxnV1dCN2xvOXBqUWNHWGFi?=
 =?utf-8?B?QUE0YUVhNWZZa0h6dDRKbzF5RmgxMUNGVVZCNUlKOXpmOU1PZndsTTg5TG9J?=
 =?utf-8?B?QkRZUHZUQVBDS2o1STVFMVJNQnk3YUhjRUpObXpYOEMrK1pXZVBiaTFjaTdX?=
 =?utf-8?B?TmdhU040QjdDNmZtU0RNNVMxaVJpRXRabmdWK1NnR3oxdXFBQm9CNTFYVWNU?=
 =?utf-8?B?d3JQd1k5WkRUTzJKYWpOVTNmbHNIYlU1YzVhVTdFNjBXR1ErNlZuaFNDNlNY?=
 =?utf-8?B?c2NpckRGaytNVi9uZm8wdnIyT0ZhaUV2bjRaM0dUZ25UWlhnak5FMVVUdDJO?=
 =?utf-8?B?bkhrMEk5SzdWU0trOUxUZ1BOeGwvaWk4K1hEaDBKanFXNUN3aWVIenpZY3RC?=
 =?utf-8?B?NVdLOHpoY21UN1VjdzJDZ09TMTg0RWUyOWt0VEk3a1d1dEFCTnpXcTBRTklB?=
 =?utf-8?B?SytIckZGWER5bjM0K2dtczdqeWJycSs5ckRpM2hOa1RjcEg2dlkyTVVhc0Jr?=
 =?utf-8?B?dWs5dXJYYkNraVZlRk1udytwazhPbWVwZjd5dkVsSlZpeHo4YzR6UFppUk1q?=
 =?utf-8?B?V1F0cHRzKzJoOHZUVFB4bDR0bEdYY2hnaThWc08zYmY4OUpzZ3dVT1daL21x?=
 =?utf-8?B?QVYwaHd5aWorNW1rSGZSaUduQ1dRL3NJQWp6ei9RaEE5SGhwVHc0bjZGczg4?=
 =?utf-8?B?dXR0MVp4b1d3R1E2R2RlRTh0NzF2MjdhU0hmbDVZSW55NEk0MUZac1E3WW5l?=
 =?utf-8?B?V3VJbjRwVS9iQnBGUlFKMFYwYkViOW94VU5WMGlMVzdaTlJWblF5bzJkeEFi?=
 =?utf-8?B?UlFsRS9oTExYdFhNK1Vzb3RNdGc5cCtYSGd1QUtEYWJNVEdORUdMVytJQmg0?=
 =?utf-8?B?ODZuaW00MDB4Z3RNYlhYT3U2RzJoV01zL0pVeFJxbWlmZ29EY2JjdVNZVFBs?=
 =?utf-8?B?VW9PUE9VUjVobVJ3TFhuZWpXRWExWlJacUxXY05GSU0xaDZJampadVZmQk5Q?=
 =?utf-8?B?T2YwSHU3TXowRzNXN3h6NU5sTHljWXhDY3k1dnM0MnJpU3ozVnhsZFdKU1Vq?=
 =?utf-8?B?L1cwSkNXRzhta3ZJKzFSYWFFaWJtRUZWS1JRVEM2NjlrdkdyanNsTGNwRjBO?=
 =?utf-8?B?cTFYN0xrMGZwdDJDNFUwNFl6TS9ReE1QaTkvZ1A5WEQwQUNQb1ZteWUxR2Qr?=
 =?utf-8?B?NzRkY0JlcE9wMDdlL2lYTGRGeFlWNVZsVlNjK1RYV1hnN1BxRjQwMUtlcDZ4?=
 =?utf-8?B?Mi9KdFUyTVpUaEttZ243SDVvREIvTFMxQjRaMW5pZ0QwdnI4Vzc5cWlwdlpW?=
 =?utf-8?B?MXdtM1dqSFd4SG9lTjM2bnV2MU5pTnY2d1c4cHNIZ3RKYW1VQXVHYjNQR3lV?=
 =?utf-8?B?M2pWMVdLaWJucnNMa0RXajhJc2Y3VkVQNVBaU3dsNnVxaW9JVFVMSGpvQ2kw?=
 =?utf-8?B?L2E4aDFKNXpRNnZzczNWU0dvVUxiZkxXRVdReUxuOERnbVpCSitrZHFTREEr?=
 =?utf-8?B?cWhKMHd6Ry9yK3RwNGZNVDBiQldnR2Zaa0VodUtINXA4bGlOWFJBeWlBYW96?=
 =?utf-8?B?RldyU000UEplOUorN3FjTDFqOGZoK2lKeDZzbEV3UktxVkx1NngrWmROQmNl?=
 =?utf-8?B?YmlsK0FPdTlocTlYZWFPekh1ekVUMmFuWlkydTE0SFZCbVR4MTAvUmkraFZt?=
 =?utf-8?B?dnFuWUpITk43bGJKdWJCaWxvNTAxYjJUc0lOdUxac0ZxRnhPMWp0dFlyeWdO?=
 =?utf-8?B?TDFaMnZWOHB3RVJUWGl1TDJZWG5YUjJhMWlVWWFmUElEaFdqSFB3Z2VJVVNu?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B6EE9BBD5BF184E8030A89909B40557@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec33c48-3ed4-4684-27ce-08d9e03a34da
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 19:38:04.8291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iRn+zrTxG7byqfVSgbyKYl6FLBsWc5gMexEadg2xr0TPrwefpbGtCzPEYGIo6NbH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4290
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: BsNtw6Vc-wyA78L1Hx_nySLyGLjjO9DV
X-Proofpoint-GUID: BsNtw6Vc-wyA78L1Hx_nySLyGLjjO9DV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_04,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTI0IGF0IDEyOjEzIC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gTW9uLCBKYW4gMjQsIDIwMjIgYXQgMTE6MTkgQU0gS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IENyZWF0ZSBhbiBpbnN0YW5jZSBvZiBidGYgZm9yIGVh
Y2ggd29ya2VyIHRocmVhZCwgYW5kIGFkZCB0eXBlIGluZm8KPiA+IHRvCj4gPiB0aGUgbG9jYWwg
YnRmIGluc3RhbmNlIGluIHRoZSBzdGVhbC1mdW5jdGlvbiBvZiBwYWhvbGUgd2l0aG91dCBtdXRl
eAo+ID4gYWNxdWlyaW5nLsKgIE9uY2UgZmluaXNoZWQgd2l0aCBhbGwgd29ya2VyIHRocmVhZHMs
IG1lcmdlIGFsbAo+ID4gcGVyLXRocmVhZCBidGYgaW5zdGFuY2VzIHRvIHRoZSBwcmltYXJ5IGJ0
ZiBpbnN0YW5jZS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4KPiA+IC0tLQo+IAo+IEJUVywgSSd2ZSBhbHJlYWR5IHN5bmNlZCB5b3VyIGJ0Zl9f
YWRkX2J0ZigpIG9wdGltaXphdGlvbiB0byBHaXRodWIsCj4gc28geW91IGNhbiBidW1wIHBhaG9s
ZSBsaWJicGYgc3VibW9kdWxlIHJlZmVyZW5jZSBpbiB0aGUgbmV4dAo+IHJldmlzaW9uLiBZb3Un
bGwgZ2V0IGEgYnVuY2ggb2YgZGVwcmVjYXRpb24gd2FybmluZ3MsIHNvIGl0IHdvdWxkIGJlCj4g
Z3JlYXQgdG8gZml4IHRob3NlIGF0IHRoZSBzYW1lIHRpbWUuCgpHb3QgaXQhCgouLi4uLi4gY3V0
IC4uLi4uCj4gPiAKPiA+ICtzdGF0aWMgaW50IHBhaG9sZV90aHJlYWRfZXhpdChzdHJ1Y3QgY29u
Zl9sb2FkICpjb25mLCB2b2lkCj4gPiAqdGhyX2RhdGEpCj4gPiArewo+ID4gKyAgICAgICBzdHJ1
Y3QgdGhyZWFkX2RhdGEgKnRocmVhZCA9IHRocl9kYXRhOwo+ID4gKwo+ID4gKyAgICAgICBpZiAo
dGhyZWFkID09IE5VTEwpCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiArCj4gPiAr
ICAgICAgIC8qCj4gPiArICAgICAgICAqIEhlcmUgd2Ugd2lsbCBjYWxsIGJ0Zl9fZGVkdXAoKSBo
ZXJlIG9uY2Ugd2UgZXh0ZW5kCj4gPiArICAgICAgICAqIGJ0Zl9fZGVkdXAoKS4KPiA+ICsgICAg
ICAgICovCj4gPiArCj4gPiArICAgICAgIHJldHVybiAwOwo+ID4gK30KPiA+ICsKPiA+IAo+IFlv
dSd2ZSBpZ25vcmVkIG15IHF1ZXN0aW9uIGFuZCBzdWdnZXN0aW9uIHRvIG1vdmUgYnRmX19hZGRf
YnRmKCkgaW50bwo+IHBhaG9sZV90aHJlYWRfZXhpdC4gQ2FuIHlvdSBwbGVhc2UgY29tbWVudCBv
biB3aHkgaXQncyBub3QgYSBnb29kCj4gaWRlYSwgaWYgeW91IGluc2lzdCBvbiBub3QgZG9pbmcg
dGhhdD8KClNvcnJ5IGZvciBub3QgcmVwbHlpbmcgZm9yIHRoaXMgcGFydC4KSSB0cmllZCBpdCB5
ZXN0ZXJkYXksIGFuZCBJIGRvbid0IHNlZSBvYnZpb3VzIGltcHJvdmVtZW50LiAgSSBndWVzcyB0
aGUKaW1wcm92ZW1lbnQgaXMgbm90IGJpZyBlbm91Z2ggdG8gYmUgb2JzZXJ2ZWQuCgo+ID4gQEAg
LTI4MTksOCArMjg4Niw4IEBAIHN0YXRpYyBlbnVtIGxvYWRfc3RlYWxfa2luZAo+ID4gcGFob2xl
X3N0ZWFsZXIoc3RydWN0IGN1ICpjdSwKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGJ0Zl9l
bmNvZGUpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0aWMgcHRocmVh
ZF9tdXRleF90IGJ0Zl9sb2NrID0KPiA+IFBUSFJFQURfTVVURVhfSU5JVElBTElaRVI7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnRmX2VuY29kZXIgKmVuY29kZXI7
Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB0aHJlYWRfbXV0ZXhfbG9j
aygmYnRmX2xvY2spOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIEZJWE1FOgo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKgo+ID4gQEAgLTI4MjgsMjEgKzI4OTUsNTUgQEAgc3RhdGlj
IGVudW0gbG9hZF9zdGVhbF9raW5kCj4gPiBwYWhvbGVfc3RlYWxlcihzdHJ1Y3QgY3UgKmN1LAo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBwb2ludCB3ZSdsbCBoYXZlIGN1
LT5lbGYgc2V0dXAuLi4KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFidGZfZW5jb2Rlcikgewo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ0Zl9lbmNvZGVy
ID0gYnRmX2VuY29kZXJfX25ldyhjdSwKPiA+IGRldGFjaGVkX2J0Zl9maWxlbmFtZSwgY29uZl9s
b2FkLT5iYXNlX2J0Ziwgc2tpcF9lbmNvZGluZ19idGZfdmFycywKPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiBidGZfZW5jb2RlX2ZvcmNl
LCBidGZfZ2VuX2Zsb2F0cywgZ2xvYmFsX3ZlcmJvc2UpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB0aHJlYWRfbXV0ZXhfbG9jaygmYnRmX2xvY2sp
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgh
YnRmX2VuY29kZXIpIHsKPiAKPiBhcmUgeW91IHRyeWluZyB0byBtaW5pbWl6ZSBsb2NrIGNvbnRl
bnRpb24gaGVyZSB3aXRoICFidGZfZW5jb2Rlcgo+IGNoZWNrIG91dHNpZGUgYW5kIGluc2lkZSBs
b2NrZWQgYXJlYT8gV2h5PyBJdCBqdXN0IGFkZHMgbW9yZSBjb2RlCj4gbmVzdGluZyBhbmQgdGhp
cyBsb2NraW5nIGNhbid0IGJlIGEgcmVhbCBib3R0bGVuZWNrLiBXZSBhcmUgdGFsa2luZwo+IGFi
b3V0IGEgdmVyeSBmZXcgdGhyZWFkcyBiZWluZyBpbml0aWFsaXplZC4gUGxlYXNlIGtlZXAgaXQg
c2ltcGxlLAo+IGxvY2ssIGNoZWNrICFidGZfZW5jb2RlIGFuZCBnb3RvIHVubG9jaywgaWYgaXQn
cyBhbHJlYWR5IHNldC4KPiBPdGhlcndpc2UgcHJvY2VlZCB0byBpbml0aWFsaXphdGlvbi4KCkdv
dCBpdCEKCi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChidGZfZW5jb2RlciAm
JiB0aHJfZGF0YSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHRocmVhZF9kYXRh
ICp0aHJlYWQgPQo+ID4gKHN0cnVjdCB0aHJlYWRfZGF0YSAqKXRocl9kYXRhOwo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdGhyZWFkLT5lbmNvZGVyID0KPiA+IGJ0Zl9lbmNvZGVyOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGhyZWFkLT5idGYgPQo+ID4gYnRmX2VuY29kZXJfX2J0
ZihidGZfZW5jb2Rlcik7Cj4gCj4gQ2FuIHlvdSBzdW1tYXJpemUgdGhlIHJlbGF0aW9uc2hpcCBi
ZXR3ZWVuIHRocl9kYXRhLCBidGZfZW5jb2RlIGFuZAo+IHRocmVhZC0+ZW5jb2Rlcj8gSSdtIHJl
LXJlYWRpbmcgdGhpcyBjb2RlIChpbmNsdWRpbmcgYGlmICh0aHJfZGF0YSlgCj4gcGllY2UgYmVs
b3cpIG92ZXIgYW5kIG92ZXIgYW5kIGNhbid0IGZpZ3VyZSBvdXQgd2h5IHRoZSBpbml0aWFsaXph
dGlvbgo+IHBhdHRlcm4gaXMgc28gY29tcGxpY2F0ZWQuCgp0aHJfZGF0YSBrZWVwcyBwZXItdGhy
ZWFkIGluZm9ybWF0aW9uIHRvIHdvcmtlciB0aHJlYWRzLiBTbywgZXZlcnkKd29ya2VyIHRocmVh
ZCBoYXMgaXRzIGluc3RhbmNlIHRvIGtlZXAgYW4gZW5jb2Rlci4gVGhlIG1haW4gdGhyZWFkIHVz
ZQpidGZfZW5jb2RlciB0byBlbmNvZGUgQlRGLiB0aHJlYWQtPmVuY29kZXIgaXMgZm9yIGEgd29y
a2VyIHRocmVhZCB0bwphZGQgdHlwZSBpbmZvLiBPbmNlIGZpbmlzaGluZyBhbGwgd29ya2VyIHRo
cmVhZHMsIHRoZSBtYWluIHRocmVhZCB3aWxsCmFkZCB0aGUgYnRmIGluc3RhbmNlcyBvZiB0aHJl
YWQtPmVuY29kZXJzIHRvIHRoZSBidGYgaW5zdGFuY2Ugb2YKYnRmX2VuY29kZXIuIEhvd2V2ZXIs
IEkgcmV1c2UgYnRmX2VuY29kZXIgZm9yIHRoZSBmaXJzdCB3b3JrZXIgdGhyZWFkLAp3aGljaCBy
ZWFjaGVzIHRoaXMgZnVuY3Rpb24gdG8gY3JlYXRlIGJ0Zl9lbmNvZGVyLiBJdCBhdm9pZHMgY29w
eWluZwpkYXRhIGZvciB0aGUgZmlyc3Qgd29ya2VyIHRocmVhZC4KCkRvZXMgaXQgbWFrZSBzZW5z
ZT8gSWYgc28sIEkgd2lsbCBwdXQgdGhlIGV4cGxhbmF0aW9uIGluIHRoZSBjb2RlLgoK
