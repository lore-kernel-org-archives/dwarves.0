Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0E2C433FE
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 12:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJDMdL (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJDMdK (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 08:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ACF578B5
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664886789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWR8kbtpCC4bNXzlOZSGNJnoAcVZSRrqoBAfwXWHY5E=;
        b=CYdoAnzWpC3SbHGtFHCJf40JhgNljNeRynJpRi6e+7V6BUFi/tVEws4wzXFjvK23PMNuza
        riDbckesDrIEmT7to7ACDhmBP7RaGKzScqwqtHbiAqGaygAVdOD10nxiVNoW+QGVouGSxD
        T0mLeQGcuy5zf/9ZwtyKVJb3CZPoavY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-4j4sJnOuN7-esWkye9qnDw-1; Tue, 04 Oct 2022 08:33:08 -0400
X-MC-Unique: 4j4sJnOuN7-esWkye9qnDw-1
Received: by mail-qt1-f200.google.com with SMTP id b10-20020ac8540a000000b0035ba387b0d1so9217144qtq.15
        for <dwarves@vger.kernel.org>; Tue, 04 Oct 2022 05:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TWR8kbtpCC4bNXzlOZSGNJnoAcVZSRrqoBAfwXWHY5E=;
        b=LOdR222LOB37/CZmcl+YflltdUHEC7D/AnfXzn2BsUviUF6u9JVr9a30lAU/iSMSAN
         2GljsA7i1Bx1slQFiEe+L/su5St8wS8ZuE3KdqRTv7NbeSNPE8/OOTsSnoyH4ZFoif6Y
         +1MP9DU+N9EZhotMDW6F4Cbq9bAHEmSJHDQzcRbE8IeD7NsAIchk6tOuVqb+epSX0hDE
         g6RoIuE75z601MRf6jbYeWXVlwclDwKtTSmZVMYFE/Iro41kuF7PpDbm79I73qtQGGZw
         tAmDqmHgYwCONR+Ftemu4RYHX1cnEnzFoSIIT7ptatTmnNtNzqSnGT5w1zL/wrMgPi7O
         jAeg==
X-Gm-Message-State: ACrzQf0O950TlV+NDai/o8X5PpxjPCjkFJ7FlNw1PiAB5aShJAyQD6i2
        N2pitKj94ucIZGzrCBCp2tcoCFbjkOCvfVBC94KZmm1zc6QRaviD6pg8aXgrOMLGq42oCVmWQvi
        IDBoXjC1E3fcNMTtTpg==
X-Received: by 2002:a05:6214:1d2d:b0:4b1:9503:3c4d with SMTP id f13-20020a0562141d2d00b004b195033c4dmr5941409qvd.88.1664886787592;
        Tue, 04 Oct 2022 05:33:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ufKsg9IIijQyoJf8dCHa8EmgFCG3EKWVEkokSosQeyRbbdwOG3wtJe6FbPzHvG6myapm2xA==
X-Received: by 2002:a05:6214:1d2d:b0:4b1:9503:3c4d with SMTP id f13-20020a0562141d2d00b004b195033c4dmr5941394qvd.88.1664886787401;
        Tue, 04 Oct 2022 05:33:07 -0700 (PDT)
Received: from [192.168.1.18] ([79.123.82.157])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a25cf00b006ce515196a7sm14602377qko.8.2022.10.04.05.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 05:33:07 -0700 (PDT)
Message-ID: <503357c8-39ad-8417-d55c-be6c04fbb27e@redhat.com>
Date:   Tue, 4 Oct 2022 13:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzwkazNc6wNCpQTN@kernel.org>
From:   Nick Clifton <nickc@redhat.com>
In-Reply-To: <YzwkazNc6wNCpQTN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi Arnaldo,

>>   <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problematic TAG

>>   <1><29>: Abbrev Number: 2 (DW_TAG_subprogram)
>>      <2a>   DW_AT_name        : (indirect string, offset: 0x2e): entry_ibpb
>>      <2e>   DW_AT_type        : <0xc>

If it helps the tag is used to tell consumers like GDB that the return
type of specific functions (eg entry_ibpb in the above example) is unknown.

Cheers
   Nick

