From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] scncopy: Fix a typo and add "-a" in --help.
Date: Tue, 12 Jan 2010 13:15:52 -0500
Message-ID: <4B4CBC58.2080608@redhat.com>
References: <1263314178-17158-1-git-send-email-pjones@redhat.com> <20100112173701.GA2934@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100112173701.GA2934-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On 01/12/2010 12:37 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 12, 2010 at 11:36:18AM -0500, Peter Jones escreveu:
>> "-s section 0" doesn't really read the same as "-s section0"...
>> ---
>>  scncopy.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/scncopy.c b/scncopy.c
>> index 38aaa9a..067662c 100644
>> --- a/scncopy.c
>> +++ b/scncopy.c
>> @@ -66,7 +66,7 @@ int main(int argc, char *argv[])
>>  			outfile = argv[n];
>>  			continue;
>>  		} else if (!strcmp(argv[n], "-?") || !strcmp(argv[n],"--usage")) {
>> -			printf("usage: pjoc -s section 0 [[-s section1] ... -s sectionN] -o outfile infile\n");
>> +			printf("usage: pjoc [-s section0 [[-s section1] ... -s sectionN] | -a ] -o outfile infile\n");
> 
> Could you please merge these two patches and also replace "pjoc" with
> "scncopy"?

Er, yes ;)

> 
>>  			return 0;
>>  		} else if (n == argc-1) {
>>  			infile = argv[n];
> 
> - Arnaldo


-- 
        Peter

Computers have already beaten communists at chess.  The next thing you
know, they'll be beating humans.
		-- Dale
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
