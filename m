From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dwarf_expr: unhandled 0x12 DW_OP_ operation
Date: Fri, 15 Feb 2008 11:49:23 -0200
Message-ID: <20080215134923.GE31602@ghostprotocols.net>
References: <m2wsp68jnl.fsf@gmail.com> <20080215130818.GB31602@ghostprotocols.net> <20080215131136.GC31602@ghostprotocols.net> <20080215133619.GD31602@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080215133619.GD31602-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Fri, Feb 15, 2008 at 11:36:20AM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 15, 2008 at 11:11:36AM -0200, Arnaldo Carvalho de Melo escreveu:
> > struct IL1JetTools : virtual public IAlgTool {
> > public:
> > 
> >         /* struct IAlgTool            <ancestor>; */     /* 4294967295 4 */
> > 
> > <SNIP>
> > 
> > See the offset?
> 
> dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_lit28 DW_OP_minus DW_OP_deref DW_OP_plus 

<SNIP>
 
> So, for the first expression: it takes the value of some register,
> duplicates it on the stack, dereference the top of the stack and put it
> on the stack, puts lit28 on the stack, subtracts the two entries in the
> stack and puts the result on the stack and then dereferences the top of
> the stack and adds the two and puts the result on the stack, that should
> be the end result that will tell where the ancestor class instance is.
> 
> Now to understand what is DW_OP_lit28, perhaps just the value 28? But
> why do we have also DW_OP_const28u? /me reads the DWARF docs...

Dwarf3.pdf page 14:

2.5.1.1 Literal Encodings

The following operations all push a value onto the DWARF stack.

1. DW_OP_lit0, DW_OP_lit1, ..., DW_OP_lit31
    The DW_OP_litn operations encode the unsigned literal values from 0
through 31, inclusive.

2. DW_OP_addr
    The DW_OP_addr operation has a single operand that encodes a machine
address and whose size is the size of an address on the target machine.

3. DW_OP_const1u
    The single operand of the DW_OP_const1u operation provides a 1-byte
unsigned integer constant.

4. DW_OP_const1s
    The single operand of the DW_OP_const1s operation provides a 1-byte
signed integer constant.

5. DW_OP_const2u
    The single operand of the DW_OP_const2u operation provides a 2-byte
unsigned integer constant.

6. DW_OP_const2s
    The single operand of the DW_OP_const2s operation provides a 2-byte
signed integer constant.

<SNIP>

11. DW_OP_constu
    The single operand of the DW_OP_constu operation provides an
unsigned LEB128 integer constant.

12. DW_OP_consts
    The single operand of the DW_OP_consts operation provides a signed
LEB128 integer constant.

<SNIP>

7. DW_OP_deref
   The DW_OP_deref operation pops the top stack entry and treats it as
an address. The value retrieved from that address is pushed. The size of
the data retrieved from the dereferenced address is the size of an address
on the target machine.

So probably the best thing to do is to convert this location expression
to a C like syntax and show it in the offset comment.

- Arnaldo
