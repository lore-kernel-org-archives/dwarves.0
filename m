From: "Erik Ekman" <yarrick-UYDU3/A3LUY@public.gmane.org>
Subject: Creating ELF function/file size statistics
Date: Mon, 28 Jan 2008 16:31:55 +0100
Message-ID: <f50a3dc50801280731t9916596ke0071a112ea58b0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi

I am doing some developing in C and want to see ELF size per function,
file and directory. Right now I extract the sizes of functions and
fields from objdump and use an ugly sed hack to find the file of each
function/object, and then a python script that does some matching.

I read about the DWARF format and it seems it includes the things I
need. The output from objdump -W and eu-readelf -w shows that
functions and object are tied to a file in some way.

Does any of the existing dwarf programs do this? pdwtags looked as a
best fit from reading the OLS paper. I have not fetched the latest
source yet due to some workplace firewalls. If no tool does this and
it is possible, then I am interested in developing one.

Please cc me, i am not on the list.

/Erik
