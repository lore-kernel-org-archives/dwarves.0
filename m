Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38BB27B33B
	for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088245; cv=none; b=pV2GGRIlGZQbtjG5q7IL+A+25saMMhgsg7nyLSbcnmdy9xUzcldnwMochhDizD3OVML2mXPziGszCg3xic46v2i5jiJ7LWHVW7TRGfY+DAcGEzXHlLX6ZpgXinEZi1FOfKR57SVhSrByQmvQ7BuSmNwHE+IAFfCVLf44T/x0T9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088245; c=relaxed/simple;
	bh=PPvYnQFfQ73AnUC0oRFF/I/KG/4xgToHLM8c+NUW9KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7Qh7EdnUhLVhYL4+3y5MIRfdW2c8N160qrBzdmr5LV7NlbruDatm1mX6DEpVg/9//JtOcg8Fqt8Llzy7mMSdQOvh1r/zfVoH2CJbvxaTNeGqX8CL1nLqs671SqOV70/FosUVLzm8eNDaa32uUtio9etJmYx2RjHyADl9CJ5ar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M17jirHj; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M17jirHj"
Message-ID: <113fe7cd-210c-4c4f-8703-f289010fd049@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766088240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJWs7dH71y+hTKsetOhwbeZpE9paXeOM1specKRWVPc=;
	b=M17jirHjlrJw432LfQw2ENQp2+vaVwBMXOCMQti9IIYJRb9brkYmXeD1WcEPzXEdSRWZ7T
	vOx9isK633UZl4/Ar4G7/E9/w6C01J8nU88uSPidbhEvuIyaU5QdC/T3FIifRqWgH+W6oD
	DrUPmPnZVuLU0oIL7jvcyFv0HRWPXqE=
Date: Thu, 18 Dec 2025 12:03:19 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/8] resolve_btfids: Introduce enum
 btf_id_kind
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bot+bpf-ci@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 arighi@nvidia.com, akpm@linux-foundation.org, andrii@kernel.org,
 morbo@google.com, changwoo@igalia.com, daniel@iogearbox.net,
 void@manifault.com, dolinux.peng@gmail.com, eddyz87@gmail.com,
 haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 corbet@lwn.net, justinstitt@google.com, kpsingh@kernel.org,
 martin.lau@linux.dev, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 nsc@kernel.org, shuah@kernel.org, song@kernel.org, sdf@fomichev.me,
 tj@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org,
 dwarves@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
 martin.lau@kernel.org, clm@meta.com
References: <20251218003314.260269-4-ihor.solodrai@linux.dev>
 <106b6e71bce75b8f12a85f2f99e75129e67af7287f6d81fa912589ece14044f9@mail.kernel.org>
 <d9b9e129-349b-4510-bf33-01b831c2174b@linux.dev>
 <CAEf4BzZXzQ6fZetTA8Trwa_pu7o1AJuMyUuHbW9YXHYGQL-_HA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzZXzQ6fZetTA8Trwa_pu7o1AJuMyUuHbW9YXHYGQL-_HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/18/25 11:58 AM, Andrii Nakryiko wrote:
> On Thu, Dec 18, 2025 at 9:47 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 12/17/25 4:47 PM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>>>> index b4caae1170dd..da8c7d127632 100644
>>>> --- a/tools/bpf/resolve_btfids/main.c
>>>> +++ b/tools/bpf/resolve_btfids/main.c
>>>
>>> [ ... ]
>>>
>>>> @@ -260,22 +279,36 @@ static char *get_id(const char *prefix_end)
>>>>      return id;
>>>>  }
>>>>
>>>> -static struct btf_id *add_set(struct object *obj, char *name, bool is_set8)
>>>> +static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
>>>>  {
>>>> +    int len = strlen(name);
>>>> +    int prefixlen;
>>>> +    char *id;
>>>> +
>>>>      /*
>>>>       * __BTF_ID__set__name
>>>>       * name =    ^
>>>>       * id   =         ^
>>>>       */
>>>> -    char *id = name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__")) - 1;
>>>> -    int len = strlen(name);
>>>> +    switch (kind) {
>>>> +    case BTF_ID_KIND_SET:
>>>> +            prefixlen = sizeof(BTF_SET "__") - 1;
>>>> +            break;
>>>> +    case BTF_ID_KIND_SET8:
>>>> +            prefixlen = sizeof(BTF_SET8 "__") - 1;
>>>> +            break;
>>>> +    default:
>>>> +            pr_err("Unexpected kind %d passed to %s() for symbol %s\n", kind, __func__, name);
>>>> +            return NULL;
>>>> +    }
>>>> +
>>>> +    id = name + prefixlen - 1;
>>>
>>> Is this off by one? The original code computed:
>>>
>>>     id = name + sizeof(BTF_SET "__") - 1
>>>
>>> For BTF_SET ("set"), this gives: name + sizeof("set__") - 1 = name + 6 - 1 = name + 5
>>>
>>> The new code computes:
>>>
>>>     prefixlen = sizeof(BTF_SET "__") - 1 = 6 - 1 = 5
>>>     id = name + prefixlen - 1 = name + 5 - 1 = name + 4
>>>
>>> The -1 appears to be applied twice now, once in the prefixlen assignment and
>>> again when computing id. Should this line be:
>>>
>>>     id = name + prefixlen;
>>
>> Yes, this is an off-by-one bug.
>>
>> Good catch, Opus 4.5. Sonnet 4.5 missed this in v3.
>>
>> This was "harmless", since the names stored in the trees don't affect
>> the output.  The comparison between the names still works, as they all
>> simply got a "_" prefix.  But this only makes the bug sneaky, which is
>> very bad.
>>
>> The suggested fix is meh though, IMO a better one is:
> 
> the bug is not in determining prefix length, but in using it to find
> where id starts in the string, so the fix should be
> 
> id = name + prefixlen;
> 
> prefixlen is calculated correctly, IMO

Aaahh, because the null byte is counted by sizeof, right... I missed that.

> 
>>
>> [...]
>>

