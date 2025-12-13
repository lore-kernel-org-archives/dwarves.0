Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6223E340
	for <dwarves@vger.kernel.org>; Sat, 13 Dec 2025 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765594353; cv=none; b=XzHAFkdZqIhNC+4xKhsIdxrz4jXfdh9YumOM9iRSJMMsPzhHan+eRKAPJK2JAtfBRXeYeyRQ2CRVzlkOOCy9DgTIcikWPfGSpUtVwh8SO7Wj6TqbDIvY0+65AWQ8TOnxhakRlZfXS5SiUF4cTWCH6UnzuhnYSFyrjekh2RGYEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765594353; c=relaxed/simple;
	bh=c4DdOgJc4Vpxs6PMnmslSP7tyBi+CwUSMeFbIRk59uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHcMlwy9eQn3voSmmsIDbBqDJgxvkMqlA77+h1AD2ARwzKZlIIn8rSMxL+m3gDrSkQqlU7bdqCTLjntdWLAZYNSrnLmq2HLA4WwBtwJma4R+7BmpSbUmeIhK7TgSe8rGAcX0YPJHbS20nvvZk+benEhQ/IcvJvxxrVZZlco7HKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6UcTR53; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6UcTR53"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso977365a91.0
        for <dwarves@vger.kernel.org>; Fri, 12 Dec 2025 18:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765594351; x=1766199151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1xekd7jNRvWyejeiz/Mjp08XhFxQMXlao7baAbp6Y8=;
        b=E6UcTR53vYwKKDZobg0hG7DP1axGlUTInb33kDaPVtP6xpiyOX8zAH3gz/Am75XCdL
         JHWfcd82LLstD1PtWziRmMTRWgb7eQrqEfTgWPC/6njF9ZcqST4NsArvC+rvHrFldeh5
         hNozZHa/NShLZOxQZv46jdSxhr94PZmAP/JXil943hSPP6PC7aIKIMe3IauKwug7kPmk
         atyeKxH7Y8594FB5ClAkRCUnghqMGzHVLqTI8/HAyb0L/aATzcAodaPP5y3rhjJWL7hT
         +dBGZOKEAqXvZ2DXjGI5Ea1hmA49kJ3qqK1nyF4QosGm6oLsLO42Wbs8W+AJg8ziKaS5
         7RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765594351; x=1766199151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1xekd7jNRvWyejeiz/Mjp08XhFxQMXlao7baAbp6Y8=;
        b=xQbiZqXspx5MXK5UqNUeFzQo1q2MPayuZoM42KbPyObc/yT2PNH/Owc5gAUvg9OIw3
         C79ekAAr7C1spwqvs8qK+zADRPx12ZjJVEAp7GGMTQmE5jGNfTi6jqJZxpoRls3vDNia
         SQlFGiQXnW8VaIqgeGzT6WHwDvn5U5RZ0d5Krsu9j+JDNPjXcASXxpu4fzxr3GZaIqWg
         5C3EENkh+HAhpJ5zSCtpv3fpq6hdXBR50JgXCAgfPz8B/YI9skYhMWQxuwhBFQUNfLf7
         FIEY6BFaQQFFOVtKhv48dtSlo5Lu1YZ6MN78W1CEwCSvfZwr0p+1qvWamXqm7wZBVhIC
         HWOA==
X-Forwarded-Encrypted: i=1; AJvYcCWzPzT2pjt5fWEe9jVVr/1Fx8iqMjhyPE5WoYhVCencRsIjdA59BYgN+hIhm+XWnt/5cxi/HjkT@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnXF1E049aRwkcGT069sNAjddMZ9azSFupPRDKmxJB5gmek2M
	StNpHQevsqZsNGTCCREoY+UWtJCb0NPW+ALfhxdEFSPYvaJX7eSQLLvm
X-Gm-Gg: AY/fxX5UdlR+Hpmv2oTfQHEmJFHgy3YIYPJdE6/rgStc7UWve5OkECpjWcMnlLVP+oS
	LY/Cv08BT+axnhW+EDAEAFBdLkPTo7akcqOyc+3/16S33QYEaZaAjDnUV7nc/T8o3qlqKhxIwk3
	7WomDLA1CmUiSoLAriWmnJXFmv5UCoJa53V7xza/JzWvpxrd7X1bJbXZGPt5mLGccUD8fNF/HXV
	0cVrMupwMGO7ofqeqFH40ictAkVFFFwFXso5tJuv1GsX4dndSjVqjPz7TrR6C7/YxoG1uxTNTqG
	/P6ON+hcviAIYBlP00oRzdWw+Aa8pZw5YEtuTk+yJmZxvv238Q2FPY0os9NVhtauvZPMhJkdRuS
	605J+cRGS+INt3FRCc2gJqjvDHf2QDANRXG9UotJxGXEXbBxSK0/rCQqSMLRC+AvvLHgIp9fdE5
	et6+Hw411pfoU9ITdvz49Gr5Y/t1tqmNLzZ4cqn3RJ5r5v3WOL/WepicWpl+0=
X-Google-Smtp-Source: AGHT+IH+NhW6YC3uwIelwrTgwRfZUi4wpFc/C9iTv1mkfJzZ9vTbO6xofyNxjPpW9k8p4n3ujswBng==
X-Received: by 2002:a17:90b:580f:b0:343:3898:e7c9 with SMTP id 98e67ed59e1d1-34a925f4a0fmr6595372a91.2.1765594350793;
        Fri, 12 Dec 2025 18:52:30 -0800 (PST)
Received: from [10.200.5.118] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c206cf429sm6528080a12.0.2025.12.12.18.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 18:52:30 -0800 (PST)
Message-ID: <64a618b5-d14a-496e-8295-60e495098a7c@gmail.com>
Date: Sat, 13 Dec 2025 02:52:24 +0000
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, ttreyer@meta.com
References: <20251210203243.814529-1-alan.maguire@oracle.com>
 <20251210203243.814529-2-alan.maguire@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251210203243.814529-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/25 20:32, Alan Maguire wrote:
> BTF kind layouts provide information to parse BTF kinds. By separating
> parsing BTF from using all the information it provides, we allow BTF
> to encode new features even if they cannot be used by readers. This
> will be helpful in particular for cases where older tools are used
> to parse newer BTF with kinds the older tools do not recognize;
> the BTF can still be parsed in such cases using kind layout.
>
> The intent is to support encoding of kind layouts optionally so that
> tools like pahole can add this information. For each kind, we record
>
> - length of singular element following struct btf_type
> - length of each of the btf_vlen() elements following
>
> The ideas here were discussed at [1], [2]; hence
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>
> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
> ---
>   include/uapi/linux/btf.h       | 10 ++++++++++
>   tools/include/uapi/linux/btf.h | 10 ++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 266d4ffa6c07..64dd681274f4 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -8,6 +8,14 @@
>   #define BTF_MAGIC	0xeB9F
>   #define BTF_VERSION	1
>   
> +/* kind layout section consists of a struct btf_kind_layout for each known
> + * kind at BTF encoding time.
> + */
We switched to kernel style comments in the new code:
/*
  * comment
  */

instead of
/* comment
  */
> +struct btf_kind_layout {
> +	__u8 info_sz;		/* size of singular element after btf_type */
> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
> +};
> +
>   struct btf_header {
>   	__u16	magic;
>   	__u8	version;
> @@ -19,6 +27,8 @@ struct btf_header {
>   	__u32	type_len;	/* length of type section	*/
>   	__u32	str_off;	/* offset of string section	*/
>   	__u32	str_len;	/* length of string section	*/
> +	__u32	kind_layout_off;/* offset of kind layout section */
> +	__u32	kind_layout_len;/* length of kind layout section */
>   };
>   
>   /* Max # of type identifier */
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 266d4ffa6c07..64dd681274f4 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -8,6 +8,14 @@
>   #define BTF_MAGIC	0xeB9F
>   #define BTF_VERSION	1
>   
> +/* kind layout section consists of a struct btf_kind_layout for each known
> + * kind at BTF encoding time.
> + */
> +struct btf_kind_layout {
> +	__u8 info_sz;		/* size of singular element after btf_type */
> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
> +};
> +
>   struct btf_header {
>   	__u16	magic;
>   	__u8	version;
> @@ -19,6 +27,8 @@ struct btf_header {
>   	__u32	type_len;	/* length of type section	*/
>   	__u32	str_off;	/* offset of string section	*/
>   	__u32	str_len;	/* length of string section	*/
> +	__u32	kind_layout_off;/* offset of kind layout section */
> +	__u32	kind_layout_len;/* length of kind layout section */
>   };
>   
>   /* Max # of type identifier */

