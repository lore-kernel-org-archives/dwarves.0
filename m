Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1657C433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 14 Dec 2021 17:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhLNRym (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 14 Dec 2021 12:54:42 -0500
Received: from foss.arm.com ([217.140.110.172]:33910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231778AbhLNRym (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 14 Dec 2021 12:54:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9458D6D;
        Tue, 14 Dec 2021 09:54:41 -0800 (PST)
Received: from [10.57.66.99] (unknown [10.57.66.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98C63F5A1;
        Tue, 14 Dec 2021 09:54:40 -0800 (PST)
Subject: Re: [PATCH v2 3/6] fprintf: Print types only once
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
 <20211207173151.2283946-4-douglas.raillard@arm.com>
 <YbikBKrz3HW8QE/X@kernel.org>
From:   Douglas Raillard <douglas.raillard@arm.com>
Message-ID: <3731f762-1508-1a07-d898-712694c05a84@arm.com>
Date:   Tue, 14 Dec 2021 17:54:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbikBKrz3HW8QE/X@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 12/14/21 2:02 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 07, 2021 at 05:31:48PM +0000, Douglas RAILLARD escreveu:
>> From: Douglas Raillard <douglas.raillard@arm.com>
>>
>> Use (struct tag).visited member to track what type has been printed
> 
> This doesn't match the patch, where you ended up using a new tar.printed
> field, have you tried with .visited and ended up finding out .printed
> was needed?
> 

Indeed I forgot to update the commit message. I initially used "visited" but
decided to add a new member instead as "visited" is already used by other tools
for other purposes that should probably not impact printing. We can revert
to "visited" easily if needed.

> - Arnaldo
> 
>> already to avoid printing it twice. This allows producing a valid C
>> header along with --expand_types.
>>
>> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
>> ---
>>   dwarves.h         |  3 ++-
>>   dwarves_fprintf.c | 22 ++++++++++++++++------
>>   pahole.c          | 34 ++++++++++++++++++----------------
>>   3 files changed, 36 insertions(+), 23 deletions(-)
>>
>> diff --git a/dwarves.h b/dwarves.h
>> index 52d162d..fc5b3fa 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -413,6 +413,7 @@ struct tag {
>>   	type_id_t	 type;
>>   	uint16_t	 tag;
>>   	bool		 visited;
>> +	bool		 printed;
>>   	bool		 top_level;
>>   	bool		 has_btf_type_tag;
>>   	uint16_t	 recursivity_level;
>> @@ -1370,7 +1371,7 @@ static inline const char *enumerator__name(const struct enumerator *enumerator)
>>   
>>   void enumeration__delete(struct type *type);
>>   void enumeration__add(struct type *type, struct enumerator *enumerator);
>> -size_t enumeration__fprintf(const struct tag *tag_enum,
>> +size_t enumeration__fprintf(struct tag *tag_enum,
>>   			    const struct conf_fprintf *conf, FILE *fp);
>>   
>>   int dwarves__init(void);
>> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
>> index c5921d7..2c5dce6 100644
>> --- a/dwarves_fprintf.c
>> +++ b/dwarves_fprintf.c
>> @@ -278,8 +278,8 @@ size_t typedef__fprintf(const struct tag *tag, const struct cu *cu,
>>   {
>>   	struct type *type = tag__type(tag);
>>   	const struct conf_fprintf *pconf = conf ?: &conf_fprintf__defaults;
>> -	const struct tag *tag_type;
>> -	const struct tag *ptr_type;
>> +	struct tag *tag_type;
>> +	struct tag *ptr_type;
>>   	char bf[512];
>>   	int is_pointer = 0;
>>   	size_t printed;
>> @@ -394,13 +394,14 @@ out:
>>   	return type->max_tag_name_len;
>>   }
>>   
>> -size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *conf, FILE *fp)
>> +size_t enumeration__fprintf(struct tag *tag, const struct conf_fprintf *conf, FILE *fp)
>>   {
>>   	struct type *type = tag__type(tag);
>>   	struct enumerator *pos;
>>   	int max_entry_name_len = enumeration__max_entry_name_len(type);
>>   	size_t printed = fprintf(fp, "enum%s%s {\n", type__name(type) ? " " : "", type__name(type) ?: "");
>>   	int indent = conf->indent;
>> +	tag->printed = 1;
>>   
>>   	if (indent >= (int)sizeof(tabs))
>>   		indent = sizeof(tabs) - 1;
>> @@ -651,10 +652,14 @@ static size_t type__fprintf(struct tag *type, const struct cu *cu,
>>   	size_t printed = 0;
>>   	int expand_types = conf->expand_types;
>>   	int suppress_offset_comment = conf->suppress_offset_comment;
>> +	bool type_printed;
>>   
>>   	if (type == NULL)
>>   		goto out_type_not_found;
>>   
>> +	type_printed = type->printed;
>> +	type->printed = 1;
>> +
>>   	if (conf->expand_pointers) {
>>   		int nr_indirections = 0;
>>   
>> @@ -794,7 +799,7 @@ print_default:
>>   	case DW_TAG_structure_type:
>>   		ctype = tag__type(type);
>>   
>> -		if (type__name(ctype) != NULL && !expand_types) {
>> +		if (type__name(ctype) != NULL && (!expand_types || type_printed)) {
>>   			printed += fprintf(fp, "%s %-*s %s",
>>   					   (type->tag == DW_TAG_class_type &&
>>   					    !tconf.classes_as_structs) ? "class" : "struct",
>> @@ -813,7 +818,7 @@ print_default:
>>   	case DW_TAG_union_type:
>>   		ctype = tag__type(type);
>>   
>> -		if (type__name(ctype) != NULL && !expand_types) {
>> +		if (type__name(ctype) != NULL && (!expand_types || type_printed)) {
>>   			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name ?: "");
>>   		} else {
>>   			tconf.type_spacing -= 8;
>> @@ -823,7 +828,7 @@ print_default:
>>   	case DW_TAG_enumeration_type:
>>   		ctype = tag__type(type);
>>   
>> -		if (type__name(ctype) != NULL)
>> +		if (type__name(ctype) != NULL || type_printed)
>>   			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name ?: "");
>>   		else
>>   			printed += enumeration__fprintf(type, &tconf, fp);
>> @@ -1000,6 +1005,8 @@ static size_t union__fprintf(struct type *type, const struct cu *cu,
>>   	uint32_t initial_union_cacheline;
>>   	uint32_t cacheline = 0; /* This will only be used if this is the outermost union */
>>   
>> +	type__tag(type)->printed = 1;
>> +
>>   	if (indent >= (int)sizeof(tabs))
>>   		indent = sizeof(tabs) - 1;
>>   
>> @@ -1394,6 +1401,8 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
>>   				 type__name(type) ?: "");
>>   	int indent = cconf.indent;
>>   
>> +	class__tag(class)->printed = 1;
>> +
>>   	if (indent >= (int)sizeof(tabs))
>>   		indent = sizeof(tabs) - 1;
>>   
>> @@ -1856,6 +1865,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
>>   	size_t printed = 0;
>>   	struct conf_fprintf tconf;
>>   	const struct conf_fprintf *pconf = conf;
>> +	tag->printed = 1;
>>   
>>   	if (conf == NULL) {
>>   		tconf = conf_fprintf__defaults;
>> diff --git a/pahole.c b/pahole.c
>> index f3a51cb..42ba110 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -2964,22 +2964,24 @@ out_btf:
>>   			goto dump_it;
>>   		}
>>   
>> -		if (class)
>> -			class__find_holes(tag__class(class));
>> -		if (reorganize) {
>> -			if (class && tag__is_struct(class))
>> -				do_reorg(class, cu);
>> -		} else if (find_containers)
>> -			print_containers(cu, class_id, 0);
>> -		else if (find_pointers_in_structs)
>> -			print_structs_with_pointer_to(cu, class_id);
>> -		else if (class) {
>> -			/*
>> -			 * We don't need to print it for every compile unit
>> -			 * but the previous options need
>> -			 */
>> -			tag__fprintf(class, cu, &conf, stdout);
>> -			putchar('\n');
>> +		if (!class->printed) {
>> +			if (class)
>> +				class__find_holes(tag__class(class));
>> +			if (reorganize) {
>> +				if (class && tag__is_struct(class))
>> +					do_reorg(class, cu);
>> +			} else if (find_containers)
>> +				print_containers(cu, class_id, 0);
>> +			else if (find_pointers_in_structs)
>> +				print_structs_with_pointer_to(cu, class_id);
>> +			else if (class) {
>> +				/*
>> +				 * We don't need to print it for every compile unit
>> +				 * but the previous options need
>> +				 */
>> +				tag__fprintf(class, cu, &conf, stdout);
>> +				putchar('\n');
>> +			}
>>   		}
>>   	}
>>   
>> -- 
>> 2.25.1
> 

