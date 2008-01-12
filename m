From: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Subject: Re: Changing the word-size was: Re: eat your own dog food?
Date: Sat, 12 Jan 2008 13:08:41 -0500
Message-ID: <1200161321.31540.10.camel@localhost>
References: <1199968968.4438.49.camel@localhost>
	 <20080110133926.GF22437@ghostprotocols.net>
	 <1199973341.4438.56.camel@localhost>
	 <20080110140635.GG22437@ghostprotocols.net>
	 <20080110163959.GJ22437@ghostprotocols.net>
	 <20080110213909.GS22437@ghostprotocols.net>
	 <1200001276.4443.40.camel@localhost>
	 <20080112152109.GA23567@ghostprotocols.net>
	 <20080112155404.GB23567@ghostprotocols.net>
	 <20080112162808.GC23567@ghostprotocols.net>
	 <20080112172856.GD23567@ghostprotocols.net>
Reply-To: hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GB6ytnlN6dqeri56kC8g"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080112172856.GD23567-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org


--=-GB6ytnlN6dqeri56kC8g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2008-12-01 at 15:28 -0200, Arnaldo Carvalho de Melo wrote:

> Now what seems to be the last thing to do is to follow typedefs and find
> unnamed structs, think about spinlock_t, socket_lock_t, etc.
> 

Good stuff Arnaldo - updated local tree. 
I should be able to test later today.

Dont know much about cmake, is it possible to check for elfutils version
and not depend on build_id if version < xxx?
This way i dont have to go out of my way to maintain my own versions of
elf utilities. I have to do the patch you sent earlier manually now. I
will remove it if you will fix cmake.

BTW, while perusing archs i managed i think to gather sufficiently
accurate info (;->) on the different alignments; i got lazy at the end,
but quiet a few are in the attached txt file incase you find them
useful. Double check sparc for example. I think most 64-bit hardware
looks consistent; the funnies are in 32-bit archs.

cheers,
jamal

--=-GB6ytnlN6dqeri56kC8g
Content-Disposition: attachment; filename=eabis
Content-Type: text/plain; name=eabis; charset=us-ascii
Content-Transfer-Encoding: 7bit

		MIPS EABI
			=========

Sizes and alignments
--------------------

	Type		Size (bytes)	Alignment (bytes)

	char		1		1
	short		2		2
	int		4		4
	unsigned	4		4
	long		4		4 (32-bit mode)
			8		8 (64-bit mode)
	long long	8		8
	float		4		4
	double		8		8
	pointers	4		4 (32-bit mode)
			8		8 (64-bit mode)

* alignment within aggregates (structs and unions) is as above, with
  padding added if needed
* aggregates have alignment equal to that of their most aligned
  member
* aggregates have sizes which are a multiple of their alignment

ia32 Sizes and alignments
--------------------

	Type		Size (bytes)	Alignment (bytes)

	char		1		1
	short		2		2
	int		4		4
	unsigned	4		4
	long		4		4 
	long long	8		4
	float		4		4
	double		8		4
	pointers	4		4 

* alignment within aggregates (structs and unions) is as above, with
  padding added if needed
* aggregates have alignment equal to that of their most aligned
  member
* aggregates have sizes which are a multiple of their alignment
  This may result in tail padding.

ia64 Sizes and alignments
--------------------

	Type		Size (bytes)	Alignment (bytes)

	char		1		1
	short		2		2
	int		4		4
	unsigned	4		4
	long		8		8 
	long long	8		8
	float		4		4
	double		8		8
	pointers	8		8 

    * An entire structure or union object shall be aligned on the same 
      boundary as its most strictly aligned member.
    * Each member shall be assigned to the lowest available offset with the 
      appropriate alignment. This may require internal padding, depending 
      on the previous member.
    * A structure's size shall be increased, if necessary, to make it a 
      multiple of the alignment. This may require tail padding, depending 
      on the last member. 

AMD 64
-------


	Type		Size (bytes)	Alignment (bytes)

	char		1		1
	short		2		2
	int		4		4
	unsigned	4		4
	long		4		4 
			8		8 (64-bit mode)
	long long	8		4
			8		8 (64-bit mode)
	float		4		4
	double		8		4
	pointers	4		4 
			8		8 (64-bit mode)

powerpc - 32bit

	Type		Size (bytes)	Alignment (bytes)

	char		1		1
	short		2		2
	int		4		4
	unsigned	4		4
	long	        4		4
	long long	8		8
	float		4		4
	double		8		8
	long double	16		16
	pointers	4		4 

powerpc - 64bit
	Type		Size (bytes)	Alignment (bytes)

	char		1		1
	short		2		2
	int		4		4
	unsigned	4		4
	long	        8		8
	long long	8		8
	int128  	16		16
	float		4		4
	double		8		8
	long double	16		16
	pointers	8		8 


sparc:
	Type		Size (bytes)	Alignment (bytes)

	char		1		1
	short		2		2
	int		4		4
	unsigned	4		4
	long	        4		4
	long long	8		8
	float		4		4
	double		8		8
	long double	16		8
	pointers	4		4 


s390:
------
	Type		Size (bytes)	Alignment (bytes)

	char		1		1
	short		2		2
	int		4		4
	unsigned	4		4
	long	        4		4
	long long	8		8
	float		4		4
	double		8		8
	long double	16		16
	pointers	4		4 

s390-zseries
---------





















--=-GB6ytnlN6dqeri56kC8g--

-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
