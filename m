From: Yonghong Song <yhs-b10kYP2dOMg@public.gmane.org>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
Date: Wed, 24 Jun 2020 10:05:41 -0700
Message-ID: <dc0a8fc6-d0be-45ee-be19-9feb1f0d21e8@fb.com>
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <20200624160659.GA20203@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200624160659.GA20203-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lorenz Bauer <lmb-lDpJ742SOEtZroRs9YW3xA@public.gmane.org>
Cc: bpf <bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-team <kernel-team-lDpJ742SOEtZroRs9YW3xA@public.gmane.org>
List-Id: dwarves@vger.kernel.org



On 6/24/20 9:06 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 24, 2020 at 12:05:50PM +0100, Lorenz Bauer escreveu:
>> Hi,
>>
>> If pahole -J is used on an ELF that has BTF info from clang, it
>> produces an invalid
>> output. This is because pahole rewrites the .BTF section (which
>> includes a new string
>> table) but it doesn't touch .BTF.ext at all.
>   
>> To demonstrate, on a recent check out of bpf-next:
>>      $ cp connect4_prog.o connect4_pahole.o
>>      $ pahole -J connect4_pahole.o
>>      $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
>> --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
>>      $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
>> .BTF.ext=btf-ext.bin connect4_prog.o
>>      $ sha1sum *.bin
>>      1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
>>      4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
>>      2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
>>      4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
>>
>> This problem crops up when compiling old kernels like 4.19 which have
>> an extra pahole
>> build step with clang-10.
> 
>   
>> I think a possible fix is to strip .BTF.ext if .BTF is rewritten.
> 
> Agreed.
> 
> Longer term pahole needs to generate the .BTF.ext from DWARF, but then,
> if clang is generating it already, why use pahole -J?
> 
> Does clang do deduplication for multi-object binaries?

No. It does not. clang did not do static linking for bpf objects 
currently but we may do it in the future...

> 
> Also its nice to see that the BTF generated ends up with the same
> sha1sum, cool :-)
>   
>> Best
>> Lorenz
>>
>> -- 
>> Lorenz Bauer  |  Systems Engineer
>> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>>
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__www.cloudflare.com&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=VBET_4Cak79EDDrdr9dfzHXXwBqdhb1fmqug2a7lpPc&s=9Wa1gFDt7uR6HK2w9FgzzLXJ2pMq8Ep0i9IXaaqUnb0&e=
> 
