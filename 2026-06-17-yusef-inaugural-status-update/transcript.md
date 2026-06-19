# Intro

Alright, hey everyone!

I'm Yusef and I'll be giving a brief status update on the progress and goals of our group so far.

I'll go over what this group is for, what we already have setup, and then cover a bit about next steps and where we hope this whole thing will go in the future.

# My Journey

*I don't usually like to talk about myself.*

But today I think it's worth it. Because the story of how I got here is actually **the same story that explains why this group exists** — and why I think it matters.

The theme that runs through my entire career is pretty simple. It's *open source technologies.* Every single step forward I've taken has been powered by something free, open, and built by a community.

It all started for me with a gift from my brother - *which was one of the first open hardware platforms ever made*: the classic Arduino Uno. At that time, I had zero programming experience. Zero electronics background. But there was a small book of projects in the box, and I just... started building things. On my own. At home.

And somehow — **that led to my first job.** While I was still an undergraduate. At a startup that basically only existed because of open source tools.

Arduino controlled their front panel. Linux ran their main board. Python powered their entire stack. *And I got that job because I had been tinkering in my spare time.* That's pretty much it.

And from there, I got deep into Linux. I learned Docker. I wrote code that interacted with other open source tools. And I just kept going.

Fast forward to today: I have a Master's degree, over five years of professional experience spanning systems engineering, firmware, and cloud infrastructure. I've had the chance to work across almost **the entire** software-defined technology stack — from tiny, low-level embedded things all the way up to large systems running in the so-called cloud.

*And every single one of those opportunities — my research, and every job offer — came from the same pattern.*

**Actively tinkering with open source stuff.**

But. There was one area I never touched. And one area I think a lot of us in this room maybe have circled but never quite stepped into.

The actual design and implementation of computers themselves.

Until very recently it was actually closed off to almost everyone, including professional engineers.
At school you likely learned an architecture not many real devices are built with, and everything else was locked away behind closed doors.
The barrier was just too high.

**But that is no longer true.**

*RISC-V is here.* And it is opening things up in a bunch of super exciting ways.

---

# RISC-V is already here

RISC-V isn't just a cool idea on paper or an academic implementation. It's already being adopted by universities and by some of the biggest companies in the world.

- NVIDIA has shipped **over one billion RISC-V cores** in their products.
- Meta uses it in their AI chips.
- Tenstorrent, right here in Toronto, is designing their own RISC-V AI chips.
- Every new Google Chromebook ships with a RISC-V core built in for security.
- And adoption is spreading into automotive, embedded systems, and other places that will eventually touch almost every industry.

But the thing is. Even with all of that momentum, even with all of the open source tools available to us...


*hardware is still hard.*

It's much harder to iterate when compared to software. The tooling and workflows still feel like they were designed by dinosaurs. And the knowledge gap is pretty dang real.

---

# Who We Are

**That is exactly why we built RISC-V Ottawa.**

At a high level, RISC-V Ottawa exists to grow and consolidate a local community right here in Ottawa — as a place for engineers, students, and researchers to *learn*, *tinker*, *build*, and ultimately **contribute together** across the full RISC-V stack.

We are very early. Right now, we are essentially **six people, a website, and a Discord server.**

But the interesting thing is...that the first four people who came together to form this group were all from industry.

* We have Alfredo, who has tons of experience setting up tooling and is a fantastic hardware verification engineer working as a consultant with **years** of experience.
* We have Mathieu, who has several years of experience in embedded systems, FPGA design, and has now been transitioning to verification as well
* And we have Mouad, who is a safety-critical embedded and software engineer working on **certified** Type 1 hypervisors that support Intel, ARM, and also RISC-V

And the one thing we all agreed on: RISC-V is growing fast, it's a massive contribution to the open source ecosystem, it's already creeping into nearly every industry imaginable — and most importantly, **for the first time it puts real computer architecture within reach** — something you can get your hands on and go super deep into, no matter how much experience you have.

*That's why we got so excited when the next two people who joined were students.* Because I think students are going to be central to what this group becomes — and I think this group can play a real role in what they become, too.

---

# What the Group is For

So what is this group *actually for?*

We want to be the consistent place where people gather to share projects, get feedback, and learn from each other. And we want **three kinds of value** flowing through this community: the *technical*, the *educational*, and the *social*.

On the technical side — this is where you bring what you're building and get real feedback from people who have actual working experience across verification, firmware, FPGA design, security, and more. This will be working professionals and students, side by side, building with and learning from each other.

On the educational side — I personally want us to produce public learning material, run workshops, organize study groups, and eventually **collaborate directly with universities** here in Ottawa.

And on the social side — just like we're doing tonight — I want us to keep bringing in awesome speakers, keep creating chances to network, and keep making this a place people actually *want* to show up to.

Now, this is obviously A LOT of things to manage and do, so the important thing to note is that we are not going to do all of this at once. *That would be **very** tiring.*

What we'll actually do is weave between these three things as opportunities arise — guided by what the group itself wants to work on. You can dip in and out, take what's useful, and skip what isn't. Showing up should fit around your work, and not compete with it. But all of this is why **your voice here will really matter.** The more people who show up and say "I want to work on X," the more we can actually do. And the more direction we have.

---

# What's in Place

Now, despite this being our very first event, we actually already have quite a lot set up.

We have a website at riscvottawa.ca, with a curated resource index. We're on GitHub at riscv-ottawa. And we have a Discord server.

We've also already started opening real relationships with others in this space. The OpenHW and Eclipse foundations were kind enough to present with us tonight — and we've started conversations with professors at both UOttawa and Carleton about future collaborations.

We've actually already confirmed that our next meetup will be *at* UOttawa, and we are targeting July 15th for the date.
<!--and partnering with the IEEE student branch and the computer engineering department there.-->

We've also been talking with other informal RISC-V communities — one example being "Works with RISC-V," based in Austin, Texas. They run local meetups, monthly livestreams, and have built one of the largest unofficial RISC-V communities in the world. *And their founder is currently working on a public RISC-V compute cluster that he's offered to share with us* — so members here could have access to real RISC-V hardware to build and compile software on.

A few of us, including myself, are also working through the official RISC-V training curriculum to become certified RISC-V ambassadors.

...And the goal with all of this is to ensure we **stay plugged into the global community** and that we're always up-to-date with what's happening.

---

# A Metaphor

Right, so to step back for a second. I wanted to give you a metaphor of what I think this community can become.

You know we have a lot of community gardens here in Ottawa. And their whole purpose is to give people a shared patch of land — a space — where they can grow whatever they want, together.

*I want RISC-V Ottawa to be exactly that. But with more nerds and more computers.*

If we play along with this metaphor: the world our garden exists in is **open source**. Our patch of land is in Ottawa.

The people who join and actively participate are the gardeners. They can grow whatever they want — but they need seeds and tools to do it. That's where communities and organizations like the Eclipse Foundation and OpenHW come in. They tell us what's out there, and what's worth planting.

And then, *gradually*, more and more people come. They work on their own patches. They share what what they're growing. And they learn from each other.

And eventually — we start showing off what we've built. To the universities who are already paying attention. To companies in Ottawa who should be.

For **working professionals**, this is the space to finally build depth in the things there's never been bandwidth for at work. To sit next to people who doing similar things or have similar interests, and to build things you already have in your mind. It'll be a group of peers who are just as deep in this as you are, which to me seems like a rare thing that is hard to find on your own.

**And for students** — you'll learn things you'd otherwise only pick up years into industry, work with tools your professors haven't heard of, and walk away with *real projects* you actually built with a real technical community behind you cheering you on.

*I believe, for both of these groups, and anyone in between, this will be something that will really compounds and help everyone grow*

---

# Training

Alright.

So, the group has already built some training material.

It's called the **RISC-V Embedded Systems Training, VEGA edition.** It's free. It's available online as a website. And it teaches you bare-metal firmware development on the VEGAboard — the same board that was handed out tonight.

Right now it covers: setting up a development environment using containers, the fundamentals of microcontrollers, writing applications, serial communication, and dealing with exceptions and interrupts. It also digs into RISC-V-specific content — some ISA extensions, RISC-V assembly, control and status registers, and trap handling.

There's a chapter on RTOS integration with Zephyr that's still in progress. *Sorry Frederic.* But it's coming.

The important thing is: **you can do this entirely on your own, at home, at your own pace.** If you have the VEGAboard from tonight, you can work through it on real hardware. And if you don't have a board, there's a simulation layer using an open source tool called Renode — so you can still follow along interactively without needing any physical hardware.

It's at **vega.riscvottawa.ca.** Please go check it out.

---

# Live Demo: VegaConsole

Let me show you what this looks like in practice.

What you're about to see is a UART REPL running on the VEGAboard with two interrupt sources running alongside it. There's a heartbeat LED toggled from a timer interrupt at 1 Hz. A button that pauses and resumes that heartbeat. And a `crash` command that deliberately executes an illegal instruction — and shows you exactly how the trap handler catches it, logs the cause, and *keeps going.*

*And this is bare-metal firmware. No operating system. No framework. Just some software talking compiled down to the RISC-V instruction set, talking directly to the hardware.*

---

# Where We're Going

---

# Near-Term

Alright, so in the near term, we're keeping it simple.

**First** — you're about to hear the initial project pitches from members in a few minutes. That's happening today, right after this.

**Second** — we are committing to monthly meetups, with at least one invited speaker each time, project check-ins, and open time for new pitches.

**Third** — our next meetup, tentatively July 15th, will be at UOttawa. We already have someone from the official RISC-V International organization who *may* be willing to give a remote talk about how the ISA specifications and how they actually get written and coordinated.

And finally — there's a textbook I've been watching obsessively: *RISC-V System-on-Chip Design* by Harris. It's the same one Mike mentioned tonight. It has been in my Amazon cart for over a month and the release date keeps getting pushed back. But when it comes out, I want to run a study group through it with this community.

Ah right, so this would be *designing your own RISC-V system on a chip, from scratch, as a group.*

That, to me, would be super exciting.

---

# Long-Term...You Decide

For the long term? *Honestly, you all decide.*

The possibilities are pretty much endless if we actually build this community well.
It could include:

* University collaborations.
* Contributions to pre-existing open source projects.
* New real projects that make it into the world.
* And, of course, many other things that none of us could build alone.

But none of that happens without people showing up.

*So show up.*

---

# Getting Started

Join the Discord.

Pitch a project. Join someone else's project. Read through the training material. And come to the July 15th meetup.

Also, tell your friends and coworkers.

Before I close, I have to say a *huge* thank you to Fatimata.

She has done an awesome job organizing this event and making sure we actually did proper outreach to the right people. Ya, and honestly? **She is the main reason everyone here is actually here tonight.**

And then of course — *thank you.* All of you. For showing up to a meetup of a group that didn't exist a few months ago.
We appreciate it, and it's super exciting to see this many people in the room.

And so my final pitch is this.

There has not been a single place in Ottawa for the people who care about this stuff — and I mean for the professionals, the researchers, and the students

So, that's what this is. It's one big patch of land, for all of us, for the long-term.

**So come and grow with us!**

Thanks.
