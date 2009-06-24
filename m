From: Zack Weinberg <zweinberg-4eJtQOnFJqFBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Formatting "drivers" was Re: Can't persuade pahole to see
 through forward declarations
Date: Tue, 23 Jun 2009 23:40:18 -0700
Message-ID: <20090623234018.61f1ce02@mozilla.com>
References: <20090615172409.6f0f322b@mozilla.com>
	<20090617170217.GB21530@ghostprotocols.net>
	<20090617102506.34aaf8e2@mozilla.com>
	<20090618183634.GE21530@ghostprotocols.net>
	<20090618132820.2eb7371a@mozilla.com>
	<20090618205053.GA4258@ghostprotocols.net>
	<Pine.LNX.4.64.0906240918170.26611@melkinkari.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0906240918170.26611-tOJ5Hk0ALFH+1EwMtL+0ZheBoQapMCRCVQQcQy+6Uvc@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

"Ilpo J=C3=A4rvinen" <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org> wrote:
> On Thu, 18 Jun 2009, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jun 18, 2009 at 01:28:20PM -0700, Zack Weinberg escreveu:
> > >  - You do not have to process C declaration syntax to find the
> > > name of each field.
>=20
> Good point, this is one of the most complex tasks in scripts to get=20
> general case right. Besides typedefs, especially those function
> pointers which appear in return value and arguments make it a task
> too hairy for any sane people, not that I'd say it is
> impossible... :-)

I used to hack gcc.  I know *exactly* how hard it is to parse C
declarations. :-)

I had been doing okay, for the limited thing I am trying to do, with
sed scripts to munge the pahole output into something that could be
relatively easily parsed by a Python script, but then I ran into this
construct:

  struct S {
    ...
    struct T {
      int a;
    } tee[2];
  };

No hint that there are two copies of T embedded in S, here, until it's
far too late to do anything about it (if you're a sed script).

> > >  - There is never missing data; in many cases pahole currently
> > > will omit the offset in its annotation of a full nested structure=
,
> > >    for instance, which is fine for humans but really bad for
> > > machine processing.
> >=20
> > Annoying "simplification", I'll put the offset there explicitely,
> > just worried that Ilpo may be using it in his sed scripts... Ilpo?
>=20
> No, I'm not. I usually try to avoid trusting such things anyway,
> unless I really have to. You just don't parse anything c-like with
> newlines / spaces as significant :-).

I actually have a patch for this one now :-)  I looked harder at my
data set and realized it only happens with unions.  There's also a=20
small typo fix in here, I was getting "classnsThing *" a lot...

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index e3e621f..bbc5dd6 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -319,7 +319,7 @@ static const char *tag__prefix(const struct cu *cu,=
 const uint32_t tag)
 	case DW_TAG_structure_type:
 		return cu->language =3D=3D DW_LANG_C_plus_plus ? "class " :
 							     "struct ";
-	case DW_TAG_class_type:		return "class";
+	case DW_TAG_class_type:		return "class ";
 	case DW_TAG_union_type:		return "union ";
 	case DW_TAG_pointer_type:	return " *";
 	case DW_TAG_reference_type:	return " &";
@@ -679,6 +679,7 @@ static size_t union_member__fprintf(struct class_me=
mber *self,
 				    const struct conf_fprintf *conf, FILE *fp)
 {
 	const size_t size =3D self->byte_size;
+	const size_t offset =3D conf->base_offset;
 	size_t printed =3D type__fprintf(type, cu, s(cu, self->name), conf, f=
p);
=20
 	if ((tag__is_union(type) || tag__is_struct(type) ||
@@ -693,17 +694,17 @@ static size_t union_member__fprintf(struct class_=
member *self,
 			 * '} member_name;' last line of the type printed in the
 			 * above call to type__fprintf.
 			 */
-			printed +=3D fprintf(fp, ";%*s/* %11zd */",
+			printed +=3D fprintf(fp, ";%*s/* %5zd %5zd */",
 					   (conf->type_spacing +
-					    conf->name_spacing - slen - 3), " ", size);
+					    conf->name_spacing - slen - 3), " ", offset, size);
 		}
 	} else {
 		printed +=3D fprintf(fp, ";");
=20
 		if (!conf->suppress_offset_comment) {
 			const int spacing =3D conf->type_spacing + conf->name_spacing - pri=
nted;
-			printed +=3D fprintf(fp, "%*s/* %11zd */",
-					   spacing > 0 ? spacing : 0, " ", size);
+			printed +=3D fprintf(fp, "%*s/* %5zd %5zd */",
+					   spacing > 0 ? spacing : 0, " ", offset, size);
 		}
 	}
=20
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
