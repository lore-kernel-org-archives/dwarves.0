From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add support for filtering classes based on name
Date: Mon, 21 Apr 2008 12:27:54 -0300
Message-ID: <20080421152754.GE12221@ghostprotocols.net>
References: <loom.20080421T141540-204@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <loom.20080421T141540-204-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Rigby <davidr-1LojSYAwM1QXQ3Lr6voeyA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Apr 21, 2008 at 02:22:14PM +0000, Dave Rigby escreveu:
> i,
> 
> While pahole allows you to exclude classes with a specified prefix (using
> --exclude), it doesn't appear to be able to do the opposite - only show
> classes with a specific prefix. I found I needed this for my own use of it,
> so here is a patch to add this functionality. It seems like it could be
> useful for others:
> 
> Thanks

Thanks a lot! May I add a:

Signed-off-by: Dave Rigby <davidr-1LojSYAwM1QXQ3Lr6voeyA@public.gmane.org>

To this commit? What this means is described in the Linux kernel
sources, where this convention was originated:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD

Basically:

<QUOTE SubmittingPatches>
12) Sign your work

To improve tracking of who did what, especially with patches that can
percolate to their final resting place in the kernel through several
layers of maintainers, we've introduced a "sign-off" procedure on
patches that are being emailed around.

The sign-off is a simple line at the end of the explanation for the
patch, which certifies that you wrote it or otherwise have the right to
pass it on as a open-source patch.  The rules are pretty simple: if you
can certify the below:

        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

	(d) I understand and agree that this project and the
            contribution are public and that a record of the contribution
            (including all personal information I submit with it,
            including my sign-off) is maintained indefinitely and may be
            redistributed consistent with this project or the open source
            license(s) involved.

then you just add a line saying

	Signed-off-by: Random J Developer <random-ld4jwAGwUXQYGaZWVHDzw80vGNN6ct63@public.gmane.org>

using your real name (sorry, no pseudonyms or anonymous contributions.)

Some people also put extra tags at the end.  They'll just be ignored for
now, but you can do this to mark internal company procedures or just
point out some special detail about the sign-off.
</QUOTE SubmittingPatches>
 
> Dave Rigby
> 
> 
> diff --git a/pahole.c b/pahole.c
> index 7053471..e16ac2d 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -26,6 +26,9 @@ static uint8_t word_size, original_word_size;
>  static char *class__exclude_prefix;
>  static size_t class__exclude_prefix_len;
>  
> +static char *class__include_prefix;
> +static size_t class__include_prefix_len;
> +
>  static char *cu__exclude_prefix;
>  static size_t cu__exclude_prefix_len;
>  
> @@ -350,6 +353,20 @@ static struct tag *tag__filter(struct tag *tag, 
> struct cu *cu,
>  			return NULL;
>  	}
>  
> +	if (class__include_prefix != NULL) {
> +		if (name == NULL) {
> +			const struct tag *tdef =
> +				cu__find_first_typedef_of_type(cu, tag->id);
> +			if (tdef != NULL)
> +				name = class__name(tag__class(tdef), cu);
> +		}
> +
> +		if (name != NULL && strncmp(class__include_prefix, name,
> +					    class__include_prefix_len) != 0)
> +			return NULL;
> +	}
> +
> +
>  	if (decl_exclude_prefix != NULL &&
>  	    (tag->decl_file == NULL ||
>  	     strncmp(decl_exclude_prefix, tag->decl_file,
> @@ -820,6 +837,12 @@ static const struct argp_option pahole__options[] = {
>  		.doc  = "exclude PREFIXed classes",
>  	},
>  	{
> +		.name = "prefix_filter",
> +		.key  = 'y',
> +		.arg  = "PREFIX",
> +		.doc  = "include PREFIXed classes",
> +	},
> +	{
>  		.name = "cu_exclude",
>  		.key  = 'X',
>  		.arg  = "PREFIX",
> @@ -910,6 +933,9 @@ static error_t pahole__options_parser(int key, char *arg,
>  	case 'x': class__exclude_prefix = arg;
>  		  class__exclude_prefix_len = strlen(class__exclude_prefix);
>  							break;
> +        case 'y': class__include_prefix = arg;
> +                  class__include_prefix_len = strlen(class__include_prefix);
> +                                                        break;
>  	case 'z':
>  		hole_size_ge = atoi(arg);
>  		if (!global_verbose)
> 
> 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dwarves" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
