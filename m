Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3743E495
	for <dwarves@vger.kernel.org>; Tue, 10 Mar 2026 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135526; cv=none; b=h3jho4fZmkvFidk/mX/R4B6uJPnEd1t+nbpWe9qBBCxXiuvFqWLVpkUeqG8bp/6qfobsqOYh9peEzzVNCuupQpgVNTQOeHEkYSEimHmLHNuqnH61qyFdEUwjezKdPVPzhHkvj+aeSyfPqtZ11HqoIY/RsDCfFLRnHfS1abMGQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135526; c=relaxed/simple;
	bh=Xi0Qz+5I5D+8smzRQDG4+dLMtTqXEcmGjDKxQ6opFZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6jlB+9kShs3jPxTDX8af4fxjf823KmdrAZ3qwBdGFxrDtEDmRme0LA2Ty7p71kzSR3ZQaKasI1Crfa1QTGVJ2Uj4kyTGyC+WsQ6+NAGHx9uHJVa1IqzkB2Nb6wEvrYpF84qUWnbCd0PvmTnwEdbuCwNxOoTDWXIuZGbl8NU1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr; spf=pass smtp.mailfrom=geoide.fr; dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b=LEPuPu11; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geoide.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b="LEPuPu11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geoide.fr;
	s=s1-ionos; t=1773135516; x=1773740316; i=d.hourtoulle@geoide.fr;
	bh=Tk9jO4r43yYmyx40B1ksoMvMCAalFRyFAJaXfs3oXUI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LEPuPu11b2pS6ONtSQ/ObkyaQzSyqZ6UTxoRS8NNEaRiojMhHarqed2YuWuEYPJv
	 OeJNkFQhdUlhecnBi03woKv0GKZGNBymgj+7QF+/4qsjjWT+8d73QvdoW3LkDIOAW
	 SUzWUyTdZOtqpoOfsNxT5LSWVuQ0CTsbT0u1m+TH0iTUrgkN039XKHAoE1gCstGC+
	 teZaKxyalrZTXRkErZ5/ExQJ61WiezxgP6j+HQI+CQIT3xYmI9NN6/jcu8QnK9eQm
	 EqDh17/llNGb/HT12fDBDKgWRKlwdNHtNL6iyyIoYCo64PvZTSB0Lb0ZIdHdPEB2m
	 GRPYPGvm45EC/lP5Qw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M26j1-1vxQhh0YMj-00G9Kh; Tue, 10
 Mar 2026 10:38:36 +0100
Message-ID: <19fab29c-0fae-4baa-bd1e-cfb7d7b361e5@geoide.fr>
Date: Tue, 10 Mar 2026 10:38:35 +0100
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pahole: fix discarded-qualifiers for strchr/strstr.
To: Alan Maguire <alan.maguire@oracle.com>, acme@redhat.com
Cc: dwarves@vger.kernel.org, Damien Hourtoulle <damien.hourtoulle@gmail.com>
References: <20260309165220.2974165-1-d.hourtoulle@geoide.fr>
 <49f241d9-8c88-4920-8f54-3e6d5c1fcd09@oracle.com>
Content-Language: en-US
From: hourtoulle damien <d.hourtoulle@geoide.fr>
In-Reply-To: <49f241d9-8c88-4920-8f54-3e6d5c1fcd09@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XbmbR6HEbutGBsu0E7bglJ30L3BBgMPeoxu+9CWxzCJOCpufd7t
 al08D0zYVrc0CoCgNRnz8REROTOQ39ka1Fvk3qdXIVedqJr6jllTsZO1iNdUgPiYDXS+Azx
 65SgX7YE//Rvdvf8Rf3DikCuVC6BLz92dhqZSW6As4a6LRo4Rwhl9OuLh+Mk4sNTQFwsx/l
 CVeDdkCrpKiSqtapBAAQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LUWHR7d/Li8=;1uask0Ds06uBJlm7TY/sspiZb9o
 LFNHkf5BYz6L9qo3It/g2ug9roPFrEkYTJrT+tU64LSclAGylKbd/6Ihitr7E7zKUCN0qK8TM
 Dd9OTs+PHZN/j8v9hAA2a3e8U3rYXNmci8R/Bu9+VKL6dIXA9JsS16DeZ9+K5mhk5S3pqXHh2
 gCavnCG3o/ExOihGMnkLQsyPvsxDjCEslQki19Cut0uZBYiS5ySZxZw2NaamkTl9eKLXiIpYB
 Xo+ZA4pjOcC+QsoaKiY58Yj/V9yGCpS6Xo+IHWPlRWIU3EfVpEYWMPQQcUeGwPYM70vYRq0NB
 w+FFzf0QjpdLWYjrVBFu3djoby0t7eTE8NGOC6BL1a3eKMYG9/sN6aRESZh5sfIzkNPjubjuI
 pQCOAoxaR9ekBCTeYCA0F5WNnAgl2cdHWA/2Ta4Y7ayIo9lPKWSrW00Q9Cp0TGsZwalD3GfLl
 XIolTgl4pj6RuanM8IGZotkN1htjRRlmtCtChHl2EAzgrD9m72o1rCXKvjVqHbq0TN3q9CZ82
 85w3bsrfcvDOhnQDD++FPPBYMYlq0rvNnVdayEN61XPO+HDZNJs0atp4wQ73HdxpI3qE7TsaI
 C4VmSHwbZGOyf9GAEyQpFxZaj3PS8tRcnYa/4/PJOZ1Kvzim6rx0wyhrn2jyKXJXHDGxV0vq6
 T16A/xCRjhMuylzeuqQ5DxiagqX/mYJXZHNv1+Gi2NbImh5HfsILIE29Y5zJTRrT/7wPmnM+D
 A5c+YY21IKnWbqbV2UYOUFd+TPtnBmimoaRiJUWde2KaIBrjuTepB5d18oShmjgmEh4+HPbjU
 efAL6BBa4d12Wae/F6GHb3KPs+rrA6KFs4wQzHZdDrgs1z7JAPcgmqMFx9qRInio6zr1onYzN
 3+psxIQBbl0W+/AHtTn4exuRqBtB7WTvz0EGdGklN/RpI9n/GXVMsB/bCpiPjHh7JUJkL4EUh
 PKbqW2B0pdGW9+VGIVBtGd//JNEkkzd2krlHCy50ZrDkSFVaQno9bG1IocWOQNE1UQKTIG10X
 SmBUk/qhXqaSBy/jp3OeApMJwNQFb6q0neb96zLQ3CqvZmgvUj/ZeSzrFrM14bllsBKL1ho6n
 mwDBSBcI4KicIsWZrS58rm8Ks7iRaDJong6HiiLlfVd42EP7s194r+mySZ3QX0OiuSYQxz8cF
 ISO/00niewkA00mU+fJJ+4DoEZvqAEEpRnUz2c469KOnXuqdjKZEMyBx6J/cNxZSvtpPnoVo2
 /nZskkvraIePURJSmFQ+sJdAgAKtFr6SrC5EgiSdIOXITBjHZbNe7UaSbZTKqmGv9HBnSe8fX
 eoksrCYF9pfQ3oa4xCb1HXsk4S+gIKPYfIvkiF01sqn8axCqH1rH75L1ZL4yt3HWqioIWSNX5
 406bXoSn8Pc7ch77MAEnQ9N6AeMGNFulUpWjpeUDMGB5MH0C1Hd1Db0yF0YuqyUNbncFiuakF
 KROo6dtWW6FhfS2JZKMXxX1vEHrgSDA/fuU/AmWrSixNFicOE1/eIUI/h0dI9hNfoo1xsFqBQ
 nOHAjxqkrKkw1bYgpwg/9Hu1dBjtpsWSpQR5x8qFot54pjtN5EbIoLIpvcrfrvv5XxqytQfbi
 P8B8Ugx/57Py8bGtN3MGdoO/u6fgO6PD7ChvElkaMIMrMi8x5QGlj5OxcavnxOs5xB7G6id2+
 SEW+YE60JrQSBdCjCADLJt/0L7gnW7Q0cCb0BkJww4LLRDrgIMBOWmtxAaV+F649IyoRxUmoN
 uqa9Ql0YFW+0wZ5S8dKiGnyfhhL3IO5t9TYjCHaeEmOpVOqwBXHJx8ro=

hello sir,
i will do the fix, i have some questions about the project, is it=20
acceptable to use C23 standard ?,=C2=A0 ex: null -> nullptr, constexpr=20
etc..., and i saw some goto , goto statement for control flow is error=20
prone can do a change about it or it's not acceptable ?

Le 10/03/2026 =C3=A0 09:56, Alan Maguire a =C3=A9crit=C2=A0:
> On 09/03/2026 16:52, d.hourtoulle wrote:
>> From: Damien Hourtoulle <damien.hourtoulle@gmail.com>
>>
>> Glibc 2.43 added C23 const-preserving overloads :
>> https://sourceware.org/glibc/wiki/Release/2.43.
>>
>> For the function prototype__new, fix local variable declaration to use
>> the correct const char* type instead of char*, removing the need to
>> discard the const qualifier.
>>
>> Signed-off-by: Damien Hourtoulle <damien.hourtoulle@gmail.com>
> the changes look good, but there is an existing issue in the code that w=
ould be
> good to solve while you're in the neighbourhood I think. more below..
>
>> ---
>> Changes in v2:
>>   - In type_instance__int_value loop: update sep_mutable instead of sep
>>   - In type__find_type_enum loop: introduce char *cur to iterate throug=
h
>>     the mutable copy, so sep_mutable stays const-correct and is updated
>>     correctly on each iteration
>>
>>   btf_encoder.c |  2 +-
>>   pahole.c      | 33 ++++++++++++++++-----------------
>>   2 files changed, 17 insertions(+), 18 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index aa7cd1c..d36984a 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -1218,7 +1218,7 @@ static bool str_contains_non_fn_suffix(const char=
 *str) {
>>   		".cold",
>>   		".part"
>>   	};
>> -	char *suffix =3D strchr(str, '.');
>> +	const char *suffix =3D strchr(str, '.');
>>   	int i;
>>  =20
>>   	if (!suffix)
>> diff --git a/pahole.c b/pahole.c
>> index 02a0d19..9dfeeb2 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -2483,7 +2483,7 @@ static int64_t type_instance__int_value(struct ty=
pe_instance *instance, const ch
>>   	int byte_offset =3D 0;
>>  =20
>>   	if (!member) {
>> -		char *sep =3D strchr(member_name_orig, '.');
>> +		const char *sep =3D strchr(member_name_orig, '.');
>>  =20
>>   		if (!sep)
>>   			return -1;
>> @@ -2496,8 +2496,8 @@ static int64_t type_instance__int_value(struct ty=
pe_instance *instance, const ch
>>   		char *member_name =3D member_name_alloc;
>>   		struct type *type =3D instance->type;
>>  =20
>> -		sep =3D member_name_alloc + (sep - member_name_orig);
>> -		*sep =3D 0;
>> +		char *sep_mutable =3D member_name_alloc + (sep - member_name_orig); =
 // sep mutable for the copy
>> +		*sep_mutable =3D 0;
>>  =20
>>   		while (1) {
>>   			member =3D type__find_member_by_name(type, member_name);
>> @@ -2510,9 +2510,9 @@ out_free_member_name:
>>   			type =3D tag__type(cu__type(cu, member->tag.type));
>>   			if (type =3D=3D NULL)
>>   				goto out_free_member_name;
>> -			member_name =3D sep + 1;
>> -			sep =3D strchr(member_name, '.');
>> -			if (!sep)
>> +			member_name =3D sep_mutable + 1;
>> +			sep_mutable =3D strchr(member_name, '.');
>> +			if (!sep_mutable)
>>   				break;
>>  =20
>>   		}
>> @@ -2950,7 +2950,7 @@ static struct prototype *prototype__new(const cha=
r *expression)
>>  =20
>>   	strcpy(prototype->name, expression);
>>  =20
>> -	const char *name =3D prototype->name;
>> +	char *name =3D prototype->name;
>>  =20
>>   	prototype->nr_args =3D 0;
>>  =20
>> @@ -2964,10 +2964,9 @@ static struct prototype *prototype__new(const ch=
ar *expression)
>>   	if (args_close =3D=3D NULL)
>>   		goto out_no_closing_parens;
>>  =20
>> +	*args_open++ =3D *args_close =3D '\0';
>>   	char *args =3D args_open;
>>  =20
>> -	*args++ =3D *args_close =3D '\0';
>> -
>>   	while (isspace(*args))
>>   		++args;
>>  =20
>> @@ -3114,7 +3113,7 @@ static int type__find_type_enum(struct type *type=
, struct cu *cu, const char *ty
>>   		return type__add_type_enum(type, te, cu);
>>  =20
>>   	// Now look at a 'virtual enum', i.e. the concatenation of multiple =
enums
>> -	char *sep =3D strchr(type_enum, '+');
>> +	const char *sep =3D strchr(type_enum, '+');
>>  =20
>>   	if (!sep)
>>   		return -1;
>> @@ -3126,13 +3125,13 @@ static int type__find_type_enum(struct type *ty=
pe, struct cu *cu, const char *ty
>>  =20
>>   	int ret =3D -1;
>>  =20
>> -	sep =3D type_enums + (sep - type_enum);
>> +	char *sep_mutable =3D type_enums + (sep - type_enum);
>> +	char *cur =3D type_enums;
>>  =20
>> -	type_enum =3D type_enums;
>> -	*sep =3D '\0';
>> +	*sep_mutable =3D '\0';
>>  =20
>>   	while (1) {
>> -		te =3D cu__find_enumeration_by_name(cu, type_enum, NULL);
>> +		te =3D cu__find_enumeration_by_name(cu, cur, NULL);
>>  =20
>>   		if (!te)
>>   			goto out;
>> @@ -3141,10 +3140,10 @@ static int type__find_type_enum(struct type *ty=
pe, struct cu *cu, const char *ty
>>   		if (ret)
>>   			goto out;
>>  =20
>> -		if (sep =3D=3D NULL)
>> +		if (sep_mutable =3D=3D NULL)
>>   			break;
>> -		type_enum =3D sep + 1;
>> -		sep =3D strchr(type_enum, '+');
>> +		cur =3D sep_mutable + 1;
>> +		sep_mutable =3D strchr(cur, '+');
>>   	}
>>  =20
>>   	ret =3D 0;
> the intent of this loop is to search through a "+" concatenated list of =
enum names, but the problem is
> we never nullify sep_mutable (or sep in the old code) at the end of each=
 loop iteration. so when
> we find the enumeration by name at the top of the second iteration of th=
e while() loop were searching
> with "second+third" rather than "second". So long story short, we need a
> 		sep_mutable =3D '\0';
>
> ...at the end of the while loop I think.
