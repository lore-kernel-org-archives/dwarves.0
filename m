Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D579C433FE
	for <linux-dwarves@archiver.kernel.org>; Fri,  7 Oct 2022 23:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJGXcn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 7 Oct 2022 19:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJGXcm (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 7 Oct 2022 19:32:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6988A193FA
        for <dwarves@vger.kernel.org>; Fri,  7 Oct 2022 16:32:41 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 297N9vbt019620;
        Fri, 7 Oct 2022 16:32:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=apThrv/MrGhVI8s4qIq8qR+Y+Jyas/irvMI4iXjl4bM=;
 b=LTewGpQO9iA01r3mVh5sXfHeJTh6hT/ehbsGZyajZ5WWcrN4T/vw1zgTlILoNxAL/RB2
 Y6qzoYwbwn5sJgJa/6vvhcwDFrsGvEc2r4dgj7MWFUFrD9mkI2goi/UQP47gCvLySuLk
 IJdTbZf6UI8s1ROf1INlr3ViKgiBwcUCkvc= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by m0089730.ppops.net (PPS) with ESMTPS id 3k2acdf8h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 16:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leLDVkH9xlhVjgOjgfzmpwgqzvn06orrrZ8f/01kccWC4bhv+XRTQ1a1yAJm1c67oXhtAnAPkHu68+5FO3OvLwYEjw/EJKgIqr/xFg8EYfggYeSCHzKscjiCWO6PLZwtkqUnEJq7g8uucXnzpOBuFQx82NRIqumflkfIpYrlrnt7Xrbldu/nRFeV6jHNbJVHIojZVTLbFcwYVTu52KtVr1/gOXXddQAOweLI0lwY8Tp89XB8lAG1qqKNQ1d4x1lxemOr3+eUlBisXzo26AlsFym/df44F5VUfVxc65WUho8oAxQB1Y+2oeD44JfT51kPzvu7k7GXWggB1EyoMlppmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JPV6sjkG0QB5UfLsZrItsDWOGco/701KzClzmRmjtM=;
 b=ORrEQGJ/DrkIav/AnMS80VlcSDhP0tpzh68Siv9UekzAqhbsHT6rUUlXu9DTo+Vyts+zHtYIxGktwfz36uMqkx2nWB9YdlodW8Sst6X1d0QcDcuUq2+M/m+nPyh8EXhzO4KQZf8CTauZozYUzA+cRjNy9jtvxrBh0UAUASQhfOC2y++4ptcwIfmRnVACOp8AK5iOeHEA3PBP9YbcB2X+IEoH/41BwJknA9iadM2YVEckT9+YCPwDtlvAesA7iE1Cnq9GneD/zSxQa8K1sYqvAovsI9qrl0kEdC3BQM5wpzkrHiXZfSS0B2wBfEYgV35qjx0kAqhW2Sfuk1bK6Cv04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4887.namprd15.prod.outlook.com (2603:10b6:806:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 23:32:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 23:32:32 +0000
Message-ID: <a9494a31-21f3-78e0-5324-9bf70b4ae926@meta.com>
Date:   Fri, 7 Oct 2022 16:32:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
From:   Yonghong Song <yhs@fb.com>
Subject: Re: BTF: A fix and more work to do :Re: die__process_unit:
 DW_TAG_label (0xa) @ <0x7b> not handled!
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dwarves@vger.kernel.org, llvm@lists.linux.dev
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
 <YzNKEhM+H/X0xUK3@kernel.org> <YzNWBxJTKDRBNNDa@dev-arch.thelio-3990X>
 <YzRPXVUfjcyQ4Utz@kernel.org> <YzRnfz0sVpX8CzeL@dev-arch.thelio-3990X>
 <YzWSzXKcm6rSWOC5@kernel.org> <YzXy/birngORHLEd@kernel.org>
Content-Language: en-US
In-Reply-To: <YzXy/birngORHLEd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:208:120::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: d3690e7d-be80-43fd-35a6-08daa8bc34be
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: niVBr5OHjFWTBkPBa2J64l68zw4qvZvnpVgIQbxhKk8n1Kpv1CDtjhrPBNO855KB2t9wjLTlnV7+w5Fjd3rv+/peQzN0hpYTYqEH9kOKtD7fD1S27TR/ybHFwjkl91gSZmWrUMBsNph5P9zZz1g5O7lapuk7aiE8YJMS18rsmNMCrc1bKPykcq5J8dYXAQUXcRhqZMZkHHxuQ2agkGaOvU5TzwKXJlupgBIgwpIMr5k8Yw+TJL0RQnh2v0F7GKnKbd/1TwvKQwFpeR2MQkwfNP04QLiu546Q4dGQmD8w3KwS5/H97JyaD0uxCPgQCapQpoNEGko93uiZTOTm1O5N/FMRdyOhVlqFSY2AbhlBTcGurzZeu6ksfJm0EqYumgRYpw5wneFHhJZwsEgShoTcyNJ4CIWevu9OdrZ/4dUXAz/3XI6SeqgwRdwVxSC9Qt9ExWjwm3HvAQt5EYj0wYePRagWt8i21tN1w8MuC/QizZ8TdCnwhmHIa3BCw2lhHS+OmS17AsR7lTA9dT57OfsifFdypSUSvvv02UxD/qcNAHyuo/YmokRoIaRzapXwd0QBbxw+nvlaeRsAu3NylrwGg1TGPQcp3/YPquQmrAveosp+NGBlIz+cWrcO52yFWZ0JeMIbcYCElFSn5iMFhaNSl/CaISptkGaKtChDLdX4IQ6gGi/A7sVNqp+DoMu9/WcJ8SpETptm5V36/KeFYCDbYpFzTQjoSI/ZAf1mlRhheINky6SeQK4x8Uu8X1rLXR5Jl+quk+KFrOBkXBr+h7RpCeMhq1XcIP4N2e+9CYac0VovA1EzPFYCTBTy/m+ykySB4U+S23KBtNTwwQB7rZyvjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(83170400001)(5660300002)(38100700002)(6666004)(31686004)(6486002)(966005)(110136005)(478600001)(2906002)(316002)(6506007)(36756003)(31696002)(186003)(4326008)(66946007)(6512007)(9686003)(66476007)(42882007)(66556008)(8676002)(41300700001)(8936002)(83380400001)(53546011)(101420200003)(21314003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlljRllRLzdKci9mU0FEUm1CQ0p0bmRnWjY3YkZPazhqRHA3eE5MV3VqZGQw?=
 =?utf-8?B?bjZPM3g2QVYzSHIyWk41OHh6UnRiVnZ5bXpTTFMySG15M3JBT3k4ZU9oZVI1?=
 =?utf-8?B?MVlYaElMZlo0UUQxekJTelUvdjZxaXRyWEhrdmFJNTFndC8yTFBpdlRQMUJh?=
 =?utf-8?B?QXpwa2R4ZnMzMlJOdkh2MVVKTWpXVzFWQ0g1R1ZscWhBS3ZRNC83UHJsQ050?=
 =?utf-8?B?Z1l3dWlZODcvcG9KWnFDYkpjV3lKb3V5dmdHakQ5cnk3eE5FUFlaSTBNWUhP?=
 =?utf-8?B?aGl5MTNkSU1sU0NZaU1pRG5JUGdUWXBMU28wc0NPdUJNL2JaK2ozNDRWUnda?=
 =?utf-8?B?R1djdW1JODZsK2g1eWFGcmI4VlBkY1JJSzJIeXk0cHFhREs1c0Fzd1NLQVpY?=
 =?utf-8?B?cTh3UEZmcEExVkVYSnNKa2ppTkFleUQySklHaUorTmhjZDNJcUoxdkFMVzNx?=
 =?utf-8?B?WGtIWTlDeWVZSUt5UVNjNXE3L0FEcUpNRlhqNEhkOGFjRFh3QXRwVVBBYUhW?=
 =?utf-8?B?S2V5Smk0enJuVC9mR0NZckR1aXUxV2hZaWM3dlM4aTZ4N1JvcERKUDFJUVdR?=
 =?utf-8?B?OTdBcU1TcUk1WE5LanA2aW82bWxFRm51Y0E5cXFjVkxTL1lUV2ZEbVFaSU1u?=
 =?utf-8?B?WUMvTml4UVNjZUxaVk9TMzVnenM1azUyMHpOY2c5ZWNyVlMxRS9HTGVzK085?=
 =?utf-8?B?ekQxeXNod0hLTGNjQVpuellSQmw4T0s0YVBYS1cya21VOWxOMTRuUDVpYUdN?=
 =?utf-8?B?NFNBWHhLRWppcUszd0w1cGg4QllsbFRxU21QTXBvZXltK00wc29oMVhneEw1?=
 =?utf-8?B?V243WkorbUI1SHlmcFRTUmg3WGlNNlJVMmVYMFh5RTVqSUlDemMxa3ZyblZo?=
 =?utf-8?B?UWNRVlJ4TElEK1BzMzRBS3lQYUdkekNLYmJaNzREaytoZ2RHTFhMaFoyWWti?=
 =?utf-8?B?MWV3S1JFVmZGQ1I4OHljV1FkeStlSUNPWUsvSStkcXdZS1VvWTQ4Q0pyS2My?=
 =?utf-8?B?YUhZTW85Q3BRVlNUVGhpRW05L2RZUFVSWk4wc1hwSUhDTXNhTzVsTk50MEpZ?=
 =?utf-8?B?K1BFeUZVNHdGdVBzYUJrclViM21PM0Nzd2VrWXc5WnJsL3hibmlUMFdnVTRn?=
 =?utf-8?B?TTZqM1F5VFhIbHNNSW9GVFczTithZ3YwL2huV1Y0R1FoVVVCY1RoUWhDWHJj?=
 =?utf-8?B?aGRHbmxwak9SVDUybVBOZFFKRlNDQlgzTTVmQjgrMjhteFpkYkxkZ2tFZld5?=
 =?utf-8?B?aVRYbUxaUGI1MnBBUTVxdllFWFNaM3JqQmNJcGQ3M0EvcVVRVXc3dzF2SVpP?=
 =?utf-8?B?d0pVdGNYRUczL2s3M0xsdlgxUjhUUVNrYXEwZGxNa3FoUTJDL2lBR2wvWnR3?=
 =?utf-8?B?NGVLMDFqN0VLYTlBUnNGejFrb2piL2xqSnpBQTdsSStUUUllNG5yeTE3NlJ0?=
 =?utf-8?B?M2tFTVZ5ZjNQczNhdzRROTcrcWlBZnNtZDBVU0Z4WmVydVlyOVRQMEdxcThL?=
 =?utf-8?B?NlBXSjV1aHlzOTBQQVNIb2o0NGhkNHVXY1AxS2M3azZiV0tRZ2xVUS9NK3FB?=
 =?utf-8?B?enRwT2JialZENjBQamRXQ2pKMTlDaWsrUmhSS2JUWkdGN2VLQWtuYmRkcGpy?=
 =?utf-8?B?OXh3NkxlSGwvQXcyMkJuSlEzb0pRc2E2MUY1bTFSelFZUG8rQmFlOVJTSW04?=
 =?utf-8?B?bXd0NEZscmxzT0x2R1dCL2M2MUtybXY2TkxEdWJDeEkyNVRDRjUrbVZhbnFN?=
 =?utf-8?B?cUtHaERxaExTbmVJdURqMDNPUGtOd2NiUGN1WERqOThoL2E5Z1lCbk4ra1Nw?=
 =?utf-8?B?Vkp6ZE5kUHdZT0lweVFOU0lJRmRRckF3Z1ZjOHRYU2gzeUxvVjdoeVU1WkFR?=
 =?utf-8?B?KzdPenk5UmJqYTE2d0o3WnFKdGlHTE8vblprbDF6NjZ3dVpKWEl3UmZ4a1I5?=
 =?utf-8?B?WERuY2ZMdW84dUZpWlN2NVk3elgzdkt5MEowRUNiU0M4RFFKeS9laUREZGZy?=
 =?utf-8?B?N0U0RmV4VHYvWG80VDBJWS8raHF6aXhSWFg5bEdjMlgwNTU0NkhqU3lyYmx4?=
 =?utf-8?B?S3hTcTZkdSs4bEFPOWt6U2xreTdrbzJLRWoxOUMzZlRlVnowYUZYUVZNRlhW?=
 =?utf-8?Q?IHprCPBAdGMY9QXTXZVgCAxgK?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3690e7d-be80-43fd-35a6-08daa8bc34be
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 23:32:32.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWB6mLqkXNHFAMa02PP9vXYWooadl2ozHxRfoZ+8PkVg2E4Pe6IzVYzj2bpIM7P/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4887
X-Proofpoint-ORIG-GUID: ETygXZuYuvEZeBrTd1lqw7xCJr6KRPAs
X-Proofpoint-GUID: ETygXZuYuvEZeBrTd1lqw7xCJr6KRPAs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On 9/29/22 12:33 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 29, 2022 at 09:42:53AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Sep 28, 2022 at 08:25:51AM -0700, Nathan Chancellor escreveu:
>>> On Wed, Sep 28, 2022 at 10:42:53AM -0300, Arnaldo Carvalho de Melo wrote:
>>>> Can you please provide the vmlinux file where this takes place?
>>>
>>> Sure thing, it is compressed to save some bandwidth while downloading:
>>>
>>> https://1drv.ms/u/s!AsQNYeB-IEbqnnzsULjM1pXmOlI5?e=qHKjuW
>>
>> So, fixed the case reported, DW_TAG_label outside a DW_TAG_lexblock, on
>> asm DW_TAG_compile_unit DWARF containers, now I noticed that pahole
>> suports encoding BTF_KIND_TAG (18) but not _decoding_ those, so off I go
>> to work on it on btf_loader.c, looking at what btf_encoder.c does.
>>
>> Good that you got me this vmlinux built by clang 15 :-)
>>
>> Now we can BTF encode a vmlinux (-J) using all the CPUs in the system
>> (-j), and then we end up with a kernel with BTF_KIND_TAG that can't be
>> properly grokked by pahole when loading from BTF:
>>
>> ⬢[acme@toolbox pahole]$ pahole -j -J vmlinux-pahole-warnings
>> ⬢[acme@toolbox pahole]$ pahole -F btf vmlinux-pahole-warnings  > pahole-pretty-printed-from-btf
>> BTF: idx: 277, Unknown kind 18
>> BTF: idx: 281, Unknown kind 18
>> BTF: idx: 331, Unknown kind 18
>> BTF: idx: 689, Unknown kind 18
>> BTF: idx: 692, Unknown kind 18
>>
>> For instance:
>>
>> ⬢[acme@toolbox pahole]$ pahole -C __sifields -F btf vmlinux-pahole-warnings
>> BTF: idx: 277, Unknown kind 18
>> BTF: idx: 281, Unknown kind 18
>> BTF: idx: 331, Unknown kind 18
>> BTF: idx: 689, Unknown kind 18
>> <BIG SNIP>
>> BTF: idx: 128403, Unknown kind 18
>> BTF: idx: 128409, Unknown kind 18
>> union __sifields {
>> 	struct {
>> 		__kernel_pid_t     _pid;               /*     0     4 */
>> 		__kernel_uid32_t   _uid;               /*     4     4 */
>> 	} _kill;                                       /*     0     8 */
>> 	struct {
>> 		__kernel_timer_t   _tid;               /*     0     4 */
>> 		int                _overrun;           /*     4     4 */
>> 		sigval_t           _sigval;            /*     8     8 */
>> 		int                _sys_private;       /*    16     4 */
>> 	} _timer;                                      /*     0    24 */
>> 	struct {
>> 		__kernel_pid_t     _pid;               /*     0     4 */
>> 		__kernel_uid32_t   _uid;               /*     4     4 */
>> 		sigval_t           _sigval;            /*     8     8 */
>> 	} _rt;                                         /*     0    16 */
>> 	struct {
>> 		__kernel_pid_t     _pid;               /*     0     4 */
>> 		__kernel_uid32_t   _uid;               /*     4     4 */
>> 		int                _status;            /*     8     4 */
>>
>> 		/* XXX 4 bytes hole, try to pack */
>>
>> 		__kernel_clock_t   _utime;             /*    16     8 */
>> 		__kernel_clock_t   _stime;             /*    24     8 */
>> 	} _sigchld;                                    /*     0    32 */
>> 	struct {
>> 		<ERROR            > _addr;             /*     0     8 */
> 
> So this shares a type with several other fields/variables/whatever and
> then:
> 
>   [  cb57]      member               abbrev: 6
>                 name                 (strx2) "sival_ptr"
>                 type                 (ref4) [  cb62]
>                 decl_file            (data1) siginfo.h (153)
>                 decl_line            (data1) 10
>                 data_member_location (data1) 0
>   [  cb62]    pointer_type         abbrev: 80
>   [  cb63]      lo_user+0x1f80       abbrev: 51
>                 name                 (strx1) "btf_type_tag"
>                 const_value          (strx1) "user"
> 
> 
> This is with eu-readelf from elfutils, binutils readelf gets confused,
> unsure about the equivalent for llvm, lets see:
> 
> llvm-dwarfdump gets:
> 
> 0x0000cb57:     DW_TAG_member
>                    DW_AT_name    ("sival_ptr")
>                    DW_AT_type    (0x0000cb62 "void *")
>                    DW_AT_decl_file       ("/home/nathan/cbl/src/linux/./include/uapi/asm-generic/siginfo.h")
>                    DW_AT_decl_line       (10)
>                    DW_AT_data_member_location    (0x00)
> 
> looks saner, a void pointer, probably with an attribute of btf_type_tag
> (DW_TAG_llvm-something, IIRC):
> 
> 0x0000cb62:   DW_TAG_pointer_type
> 
> 0x0000cb63:     DW_TAG_LLVM_annotation
>                    DW_AT_name    ("btf_type_tag")
>                    DW_AT_const_value     ("user")
> 
> 0x0000cb66:     NULL
> 
> None of these tools seem to be grokking this nicely, Yonghong?

Sorry for late reply. I missed this email.

Yes, btf_type_tag is only supported with llvm. gcc/gnu-tools does not 
support it yet. There is an effort in gcc community to support this.
   https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598038.html
but the progress has been slow recently.


> 
> ⬢[acme@toolbox pahole]$ llvm-dwarfdump --version
> LLVM (http://llvm.org/  ):
>    LLVM version 14.0.0git
>    Optimized build.
>    Default target: x86_64-unknown-linux-gnu
>    Host CPU: znver3
> ⬢[acme@toolbox pahole]$ cat /etc/fedora-release
> Fedora release 36 (Thirty Six)
> ⬢[acme@toolbox pahole]$
> 
> 
> I.e. sival_ptr is a:
> 
> typedef union sigval {
>          int sival_int;
>          void __user *sival_ptr;
> } sigval_t;
> 
> So I would expect that sival_ptr pointed to a void * with an
> intermediate DW_TAG_LLVM_annotation? What is the semantics? How all
> these tools need to grok this?
> 
> - Arnaldo
