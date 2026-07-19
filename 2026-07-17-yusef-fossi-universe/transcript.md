<!--# A side quest into the FOSSi universe
# Speaker transcript · Yusef Karim · July 2026-->

# Intro

Alright, hello again.

So as Paul mentioned at the start, instead of an awesome Q&A panel with industry leaders...you get me. But, before you start throwing tomatoes, I do want to say that I tried my best to make sure you're not getting a _much_ worse deal — particularly because what I'm going to be sharing is actually the **most fun** I've had in awhile playing with tech and I hope this means you all will find it really interesting too.

I'm calling this presentation a "side quest into the free and open source silicon universe."

It grew out of our group's hardware root of trust project — and it _is_ related, _but_ it's really not about the hardware root of trust at all. Instead, it's about a rabbit hole I fell into along the way.

# No money? No problem.

Quick recap for anyone who missed the last meeting. I had mentioned then, that to get everything running outside of simulation and instead on real physical hardware, the hardware root of trust project needed a real FPGA to prototype on, and the development boards they actually target, cost somewhere between _eight_ and _sixteen thousand_ dollars.

And at the end of my pitch, I said, half-jokingly, if anyone's got a spare one lying around...to let me know

Obviously, nobody got back to me.

However, I did have a single _twenty-dollar_ FPGA lying around in a box, and I started to get curious if there was something relevant I could use it for. And it turns out there was!

The CPU sitting at the heart of _both_ of the root-of-trust open source reference designs — OpenTitan's and Pavona's — is a little RISC-V core called **Ibex.** And Ibex is **small**. Small enough that it does not need a sixteen-thousand-dollar board at all. It actually fits on the _twenty-dollar_ one I have.

---

# The side quest

So the side quest was easy.

Take the _real_ RISC-V CPU core that OpenTitan and Pavona actually use, and get it properly running on the _twenty-dollar_ FPGA I had lying around.

That's it. A short and easy quest...or so I thought.

---

# First, a confession

Before I go any further, I'll be honest about my actual prior experience in this area.

So, a month ago, I had _never_ actually built anything for an FPGA.

Additionally, every single tool I'm about to show you — LiteX, Yosys, nextpnr, Apicula, openFPGALoader — I had **never touched** any of them. If you'd asked me what half of them did, I couldn't have told you.

All I had for this quest was my interest in RISC-V, the twenty-dollar FPGA board, and a stubborn desire to get some hands-on experience without waiting around for a sixteen-thousand-dollar FPGA.

I had _no_ idea what a "slang frontend" was, or a "distributed-RAM register file," or what the "memory layout" of the Ibex CPU was. These, are all things I learned _the hard way,_ over the last few weeks tinkering.

So everything from here onward should be treated as a _beginner's field report._
I definitely fell down a lot of rabbit holes.
But, luckily, this turned out to be a super rewarding experience and it's the primary reason why I'm sharing it here with you today.

---

# Latch-Up 2026

Right, so _this photo_. This photo is actually why I became motivated to dive into all of this stuff despite being a "total beginner".

This photo is from an event I went to earlier this year called **Latch-Up** — It is the FOSSi Foundation's open-source silicon conference. There I got to spend a couple of days in a room full of the craziest nerds I have ever met in my life.

The people there were the ones who actually _built_ and still maintain some, if not all, of the tools I'm about to show you today.

And this is also where I met Mike Thompson and Frederic Desbiens for the first time. Who both are leaders in this field, local to Ottawa, and are kind enough to be helping us make this community something really great.

You can see Mike and Frederic in the middle there.

I actually felt like this event was some kind of motivational drug, and I think it somehow unlocked some deep mega nerd trait that was just sitting dormant inside me. It also made me want to get involved and contribute back.

So this whole side quest is basically the _outcome_ from that weekend.

---

# New to hardware? FOSSi to the rescue!

OK, so **FOSSi**.

FOSSi stands for "free and open source silicon".

The primary idea is that the _entire_ stack can be open. Not just the software running on top. But **all of it**, starting at the top and going all the way down to the silicon itself.

So, of course, the instruction set is open — that's RISC-V, the reason we're all in this room here today.

Many of the CPU _designs_ are open — that's cores like the Ibex and OpenHW Foundation cores that you can actually download, read, and change yourself.

And the part that we're really focusing on today, are the **tools**, which somewhat amazingly now also have open source alternatives as well. And this is for everything: synthesis, the place and route, and even the program that flashes the chip. _All of it,_ free. No license server, or huge 30 plus gigabyte downloads requiring login, and nothing gatekeeping you out.

So ya, for someone brand new, this makes a big difference between "I can try this easily _tonight_" and "I can't try it at all."

And just one last point so you know how far this goes — there's _one more layer,_ past the FPGA related to actual ASIC manufacturing. And this is the actual manufacturing recipe itself, the so-called "process design kit" or **PDK**, which can also be open now. Open PDKs like SkyWater and IHP, and shared tape-out programs — like TinyTapeout, the SSCS Chipathon — provide open source tools and shared services to take your full design and put it on _real, physical_ silicon.

That is not today's story. But it _is_ the same idea, just one level deeper.

But ya, just to mention again: _today_, I'll be focusing on the tools just above that.

---

# What I built

So moving on to what I actually built.

It is a complete little RISC-V "system-on-chip". And what I mean by _complete_, is that it boots like a real computer — with a BIOS and a serial console.

So it's the real Ibex CPU — which is maintained by a non-profit called lowRISC, and actually started life as a core out of ETH Zürich — plus a UART, some memory, and a bus tying it all together. And everything for this was tied together and integrated by a framework called **LiteX**.

Then, all of this is made to target the board shown here: the **Tang Nano 9K**. It's a development board created by a company called Sipeed, with an FPGA chip called the GW1NR designed by a company called Gowin Semiconductor with about _eight thousand_ LUT4 logic cells to squeeze things into. And the board costs about as much as a few boxes of Timbits, like the ones you're eating right now.

---

# The Ibex core

Just taking a minute to focus in on the Ibex core itself, which of course is my favourite thing about this entire project.

What I actually put on the board is the real Ibex, but in its "small" configuration. It's a 32-bit RISC-V CPU that supports the base integer, multiply, plus compressed extensions and runs in machine-mode only. It has a two-stage pipeline, with no cache, and no branch predictor. So this really is _the same core_ that goes into the security chips, just configured with a few features turned off for size.

The Ibex talks over a bus protocol called the open bus interface, or OBI, which I believe is maintained under the OpenHW Foundation...so you can ask Mike about it if you're curious, because I know I will be doing the same at some point too.

But ya, it turns out LiteX quietly bridges that protocol to another bus protocol called Wishbone, which is what ties the core to the RAM and all the other peripherals - like the UART, timer, GPIO, and SPI flash.

To me as a beginner, that bridging was one of those things I didn't even know was _needed_ until noticing LiteX had already magically done it for me.

# The open flow

Alright, so now finally we get to the tools I used.

So the main goal is to get from a hardware description language, like System Verilog, to a chip that actually boots.

And, as you guys know, I like open source...so the goal is to do **everything** here with _no proprietary tools_ at all.

So, the flow shown above is the whole pipeline and the set of tools I used, and they're all open source.

**LiteX** lets you use Python to define and generate an SoC along with some associated firmware.

**Yosys** synthesizes it — with a plugin called yosys-slang to do the SystemVerilog parsing.

**nextpnr** takes and prepares the synthesized code to actually be placed and routed onto the actual fabric of the chip.

**Apicula** then packs that into a bitstream — which is the file that can actually be loaded onto the FPGA itself.

And finally **openFPGALoader** helps you push it onto the board over a protocol called JTAG.

Then also off to the side, you can use RISC-V GCC or clang to compile the firmware, and LiteX will help you send it into the bootable BIOS.

And that's it.

So...this is obviously amazing, because at _no point_ in that entire chain is there a proprietary tool. I didn't need to login to some vendor's page, or connect to a license server, and I of course didn't have to pay anything.

If you want, each one of you can all go download all these tools in 5 minutes, _for free_, when you get home.

---

# One container, a handful of commands

And even better, if you're completely new to all of this like me: you don't even have to install any of it _by-hand_ directly on your computer.

That's because the Yosys team ships that entire open FPGA flow as one single download, called the **OSS CAD Suite.** And I took that, plus RISC-V GCC and LiteX, and wrapped the whole thing into **a single container image.** So one command, `make image`, gets you everything, and, in a sense, nothing at all actually has to land on your own host machine itself.

Additionally, in my project repo I've also provided a set of `make` commands for the whole workflow. So you can run commands like `make soc` to generate, synthesize, and place-and-route the SoC, and use `make flash` to load the bitstream and BIOS onto the board.

All of this makes it pretty easy to get started, so definitely checkout the repo I provide later if you're interested.

---

# It works

And... **it does in fact actually work.**

It boots. On real hardware, and all you need to do is plug the board in via USB.

Once you connect to the board over serial USB, you get a banner like the one I've shown here, which is the little portable BIOS program provided by LiteX.

You can also make it run _your own_ code.

For example, I've got a little bare-metal program called `blink_irq` in the repo, which has a _hardware timer_ that fires an interrupt to toggle an LED, and to keep the serial console alive.

And this program is flashed into the board's own memory, so it comes back on its own after a power cycle.

One other great thing is that this whole setup fits in at about _eighty percent_ of the total space available in the FPGA chip, so there might be a few extra things you could try to fit in there in the future if you really wanted to.

---

# Demo

[**LIVE DEMO.** Open the console and tap reset → banner comes up, land at the `litex>` prompt. Serial-boot the echo app, type at it, watch it echo back. Then `make flash-app APP=blink_irq` → `make reset`: it reloads from flash and a timer interrupt blinks the LED on its own, surviving a power cycle. Narrate as you go; keep it moving.]

---

# New to hardware? Oh boy...

So, that was all sunshine and rainbows.

But now it's time to talk about _all_ the things that did _not_ work.

Every one of these was its own little rabbit hole.

So to start, the register file in its default form overflowed space on the FPGA. So I had to swap it with the distributed-RAM option, which thankfully allowed the whole design to fit with space to spare.

Next, the default on-board RAM led to corruption of almost every single byte of memory, so eventually I just, uh, stopped using it and switched to an available alternative called block RAM.

There was also an issue with using higher serial speeds, so after some trial-and-error I just settled on using 9600 baud.

Then finally, the board has a twenty-seven megahertz crystal on it, and twenty-seven is what LiteX defaults to. However, I could never get it working with speeds higher than thirteen-point-five megahertz, everything would just stop working completely when I used higher values.

I actually never figured out the clock speed issue. *But* earlier this week, I shared my slides with Mouad...and he randomly messaged me later saying he thinks he has figured out the clock issue.

I'm pretty sure Mouad is new to LiteX like me too, so I was absolutely shocked when he told me his guess.

It turns out LiteX was never telling the nextpnr "place-and-route" tool what clock we were actually targeting. So nextpnr fell back on its default guess, which turned out to be _twelve_ megahertz. And nextpnr would just happily hand you the bitstream even when you gave it a frequency that would fail the necessary timing requirements. The fix Mouad proposed ended up just being a handful of lines to work out the real proper frequency and then pass it through.

And this actually works! So Mouad and I are now going to work together to get his first contribution into LiteX, which will solve this issue for anyone using this board in the future as well. Which is AMAZING.

---

# My main contribution and RISC-V assembly

OK, so these are my slides, so I of course didn't want to end with giving _Mouad_ the final word.

Instead, I'm going to make you all listen to one of the main contributions _I_ made and was actually able to get merged upstream.

Jokes aside, this change is actually the most RISC-V related one and it's why I wanted to give a bit more detail on it.

The symptom was a little bit _maddening._ Where, after I had the core actually on the FPGA, the code I uploaded would just **never boot.** There was no obvious crash or error. The board would just power up and sit there doing nothing.

The solution required realizing that the Ibex CPU doesn't actually start at address zero on reset — it actually starts at offset _0x80._

The problem was that the boot code provided by the LiteX repo put the reset entry point, which is the very first instruction, right at _zero_. So on power-up the core would jump to 0x80, then land in what was essentially dead code.

And there was a _second_ problem hiding alongside this. The vector table — which is just the list of locations the CPU jumps to when an interrupt fires — was missing one directive. This was the `norvc` directive. And without it, jump entries are allowed to be compressed instructions, which are just two bytes instead of four. If this happened, the whole vector table could become _misaligned_ and cause all sorts of problems.

The fix, was again just a few lines.

I just had to force full four-byte jump entries, move the thirty-two-entry table to the start, and then place the reset entry point exactly where the Ibex CPU jumps to on reset.

And here's a fun little detail I really liked about this. Thirty-two entries, at four bytes each, is a hundred and twenty-eight bytes. And a hundred and twenty-eight...is _0x80._ So once you force the entries to stop compressing, the table ends _exactly_ where Ibex resets. The reset entry point just falls into place right behind it.

This was my first contribution to LiteX, and I was able to file the issue, write the fix, and test it on the real board I have here. So now no one going forward will run into this issue themselves.

---

# Giving back

OK, almost last slide.

The last thing I wanted to focus on is that, a month ago, I had _never touched any of this_ — and despite that, I ended up with a couple of fixes merged upstream into LiteX. There is even another PR that was created by the LiteX developers based on my findings, and it has actually spawned a fairly big redesign for some improvements in the backend of LiteX and the way it parses SystemVerilog files.

Another thing to mention is that the LiteX developers were actually really kind and fast to respond to the issues and PRs I made. For the backend changes I just mentioned, the LiteX developers actually made the PR, and then **I** helped test their changes because they didn't have a good enough setup on their end. So just being able to test and give them feedback was a contribution in itself.

So, ya, ten out of ten for the LiteX developers. I definitely will contribute again, and I hope this talk made the people here interested in FPGAs curious and want to get involved too.

The obvious takeaway is that you don't need to be an expert to get involved. And...that of course, RISC-V Ottawa is here to help you if you are interested in this stuff.

---

# Where to find it

So, yup, everything I talked about is on the RISC-V Ottawa GitHub.

So go play with it if you are interested.

Thanks.

# Questions

So, we have left some time for questions. So I'm happy to answer anything you got.
