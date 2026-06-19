# Intro

Alright, hello again.

I'll be pitching a project about security. Or more precisely, about *trust.*

---

# Turtles

Right, so turtles. I first heard about this turtle metaphor in my Master's — I even remember one of my professors bringing it up at some point.

It's from an old story about what holds up the world, where some ancient cultures pictured the Earth sitting on the back of a giant turtle

And then, of course, the next question that eventually came up is: what holds up *that* turtle?

And the answer is: another turtle. And under that one? Another.

**It's turtles all the way down.**

---

# What is a root of trust?

The reason I brought up this story is because every *secure* device you rely on — your phone, your car, the servers your bank runs on — is built in *layers.* And each layer is forced to trust the layer underneath it.

So, it's also turtles. All the way down.

But it obviously can't be turtles *forever.* At the very bottom there has to be one final turtle — one small piece of hardware that everything else trusts completely. It owns the device's identity, its secret keys, and it decides what software is even allowed to run.

*That* is the root of trust. Or what I'm calling, the final turtle.

However, in almost every device today, that final turtle is a **black box.** It's proprietary. It's sealed. And you're just asked to trust it and whatever firmware its running.

---

# Now it's open, all the way down

So a few years ago, that changed. A project called **OpenTitan** built the first root of trust that is open *all the way down* — down to the actual chip design itself. And it runs on RISC-V. And as of this year, it ships in real **Google Chromebooks.**

Additionally, just recently this last month, a new and equally massive project that builds further upon the OpenTitan project itself was released.

This project is called **Pavona** and includes a huge set of additional open source IP components that are fully tested and verified for real tapeout to physical hardware.

The best part of all of this is: you can pull the entire codebase that includes the source of all the hardware and software components, **and** *you can run the whole thing in simulation. On a laptop, with no other physical hardware required.*

---

# Why?

So, I actually had learned about the OpenTitan project five years ago, during my Master's.

Then I finished my Master's - became a boring software engineer - and never touched it again.

But, I've wanted to come back to it ever since. *This group is my excuse.*

I know for a fact that there are *so many* things to learn here and that's really exciting to me.

---

# ...so many things to learn

But yes, there really are **so many** things to learn.

And although I have experience in this field, I'm definitely not going to pretend I understand all of it.

Every single word on this slide is its own rabbit hole.

But to me that's not the scary part. *That's the fun part.*

---

# The path: make it, then break it"

So the rough plan is to go from "what *is* a root of trust" to actually **running and understanding** one in depth.

The OpenTitan and Pavona projects are an absolutely huge pile of concepts, and also a huge set of open hardware blocks and software stacks to dig into.
I'm very interested in learning how they talk to each other.
The actual security concepts underneath.
Also how to drive big simulations of all of it.
And how to write properly secure firmware to run ontop.

So we'll start by booting the real thing in simulation with signed firmware, and then decompose the whole process to learn how the full system works end-to-end.

It will also be fun to try and *break* it. And find out what it can and can't actually guarantee in terms of security.

But like I said, this is a *huge* project to explore. So my goal is to work through it within the group, share everything I learn, and provide deep dives into topics that people might otherwise never get a chance to experience by themselves.

---

# Interested?

I will also organize each subtopic for this project using the same book format I used for the VEGA training.

And I think the subtopics will span basically everything this group already has shown interest in.

So if any of this sounds fun to you, feel free to reach out anytime and join the Discord channel I've created for it.

Oh, and, uh... if anyone happens to have a spare sixteen-thousand-dollar FPGA lying around — *let me know.*

Thanks.
