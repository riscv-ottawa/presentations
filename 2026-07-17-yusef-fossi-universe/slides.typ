// RISC-V Ottawa - project status update: A First Step into the FOSSi Universe (Yusef)
//
// Toggle the theme with the `dark` boolean below, then compile from this
// folder:
//     typst compile slides.typ slides.pdf
// Live preview while editing:
//     typst watch slides.typ

#let dark = false // <-- set to false for the light theme

#let theme = if dark {
  (
    paper: rgb("#11141a"),
    surface: rgb("#181c24"),
    cline: rgb("#262b34"),
    ink: rgb("#e6e7eb"),
    mute: rgb("#848a96"),
    accent: rgb("#7c9bc4"),
    accentsoft: rgb("#9ab4d4"),
    warm: rgb("#d9a18d"),
    warmsoft: rgb("#e6b6a3"),
    rust: rgb("#c08070"),
    mark: "images/avatar-square-light.png",
  )
} else {
  (
    paper: rgb("#f7f5f0"),
    surface: rgb("#ffffff"),
    cline: rgb("#e4e0d6"),
    ink: rgb("#1a1c20"),
    mute: rgb("#6a6d75"),
    accent: rgb("#3d5a80"),
    accentsoft: rgb("#4d6e9a"),
    warm: rgb("#b56b54"),
    warmsoft: rgb("#a35d48"),
    rust: rgb("#8c4a3e"),
    mark: "images/avatar-square-dark.png",
  )
}
#let paper = theme.paper
#let surface = theme.surface
#let cline = theme.cline
#let ink = theme.ink
#let mute = theme.mute
#let accent = theme.accent
#let accentsoft = theme.accentsoft
#let warm = theme.warm
#let rust = theme.rust
#let markpath = theme.mark

// ---- page + text setup ------------------------------------------------------
#set page(
  width: 33.867cm,
  height: 19.05cm, // 16:9
  margin: (top: 1.55cm, bottom: 1.4cm, left: 2.2cm, right: 2.2cm),
  fill: paper,
)
#set text(font: "Fira Sans", size: 20pt, fill: ink)
#show link: set text(fill: accent)
#set par(leading: 0.72em, spacing: 0.95em)
#set list(marker: text(fill: rust, size: 0.95em)[▪], spacing: 0.95em, indent: 0.2em)
#show heading: set text(weight: 800)

// ---- brand bits -------------------------------------------------------------
#let wordmark(size: 24pt) = text(size: size, weight: 800, tracking: -0.5pt)[
  RISC#text(fill: rust)[-V] #text(weight: 500, fill: ink)[Ottawa]
]

#let kicker(s) = text(size: 15pt, weight: 700, fill: accent, tracking: 2.5pt)[#upper(s)]

#let card(title, body) = block(
  fill: surface,
  width: 100%,
  inset: 0.75cm,
  radius: 3pt,
  stroke: 0.8pt + cline,
)[
  #if title != none [#text(weight: 800, size: 19pt, fill: accent)[#title] #v(0.25cm)]
  #body
]

// ---- slide scaffolding ------------------------------------------------------
#let footer() = context {
  place(bottom + left, dy: 0.78cm, text(size: 11pt, fill: mute)[#upper("open ISA, open community")])
  place(bottom + right, dy: 0.78cm, text(size: 11pt, fill: mute)[
    #counter(page).display() / #context counter(page).final().first()
  ])
}

#let slide(title: none, body) = {
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    text(size: 30pt, weight: 800)[#title], wordmark(size: 15pt),
  )
  v(0.12cm)
  line(length: 100%, stroke: 0.7pt + cline)
  v(0.55cm)
  body
  footer()
  pagebreak(weak: true)
}

#{
  v(1fr)
  align(center)[
    #wordmark(size: 30pt)
    #v(0.7cm)
    #text(size: 46pt, weight: 800, tracking: -0.5pt)[A side quest into the FOSSi universe]
    #v(0.1cm)
    #box(width: 8cm)[#line(length: 100%, stroke: 1.4pt + rust)]
    #v(0.5cm)
    #text(size: 22pt, weight: 600)[A RISC-V CPU on a \$20 FPGA using zero proprietary tools]
    #v(0.18cm)
    #text(size: 16pt, fill: mute)[July 2026 · Yusef Karim]
  ]
  v(1fr)
  pagebreak(weak: true)
}

#slide(title: "No money? No problem.")[
  #v(0.1cm)
  #text(size: 20pt)[
    Last month I pitched the *hardware root of trust* (HWRoT) project, and asked if anyone had an *\$8k–16k* FPGA they could lend...*nobody did* #text(fill: mute)[(rude).]
  ]
  #v(0.4cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.2cm,
    align: (center + horizon, center + horizon),
    [
      #link("https://opentitan.org/book/hw/top_earlgrey/doc/datasheet.html")[#image(
        "images/top_earlgrey_block_diagram.svg",
        height: 7.5cm,
      )]
      #link("https://opentitan.org/book/hw/top_earlgrey/doc/datasheet.html")[#text(
        size: 14pt,
        fill: mute,
      )[OpenTitan Earl Grey]]
    ],
    [
      #link("https://github.com/pavona/pavona/blob/main/hw/top_egret/doc/datasheet.md")[#image(
        "images/top_egret_block_diagram.svg",
        height: 7.5cm,
      )]
      #link("https://github.com/pavona/pavona/blob/main/hw/top_egret/doc/datasheet.md")[#text(
        size: 14pt,
        fill: mute,
      )[Pavona Egret]]
    ],
  )
  #v(0.4cm)
  #align(center)[#text(size: 18pt, fill: rust, weight: 700)[
    Turns out the CPU used by both HWRoT reference implementations fits on a \$20 FPGA!
  ]]
]

#slide(title: "The side quest")[
  #v(4cm)
  #align(center)[#text(size: 30pt)[
    Get the *real RISC-V core* used by OpenTitan and Pavona running on the *\$20 FPGA* I had lying around.
  ]]
]

#slide(title: "First, a confession")[
  #v(0.5cm)
  #align(center)[#text(size: 25pt)[
    A month ago I had *never* built anything for an FPGA, and had *never touched* a single
    tool in this talk.
  ]]
  #v(0.5cm)
  #align(center)[#text(size: 17pt, fill: mute)[
    LiteX, Yosys, nextpnr, Apicula, openFPGALoader...all brand new to me.
  ]]
  #v(0.55cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.1cm,
    card("What I had")[
      #set text(size: 17pt)
      An interest in RISC-V, a \$20 board, and a stubborn desire for hands-on experience without waiting for a \$16k board.
    ],
    card("What I did *not* have")[
      #set text(size: 17pt)
      Any idea what a *slang frontend*, a *distributed-RAM regfile*, or the *memory layout* of the Ibex CPU was.
    ],
  )
  #v(0.7cm)
  #align(center)[#text(size: 22pt, fill: rust, weight: 700)[
    This is a beginner's field report. Expect rabbit holes.
  ]]
]

#slide(title: "Latch-Up 2026 - a motivational drug")[
  #v(0.4cm)
  // Face markers. dx/dy are percentages of the photo box: 0% is its left/top edge.
  // Nudge the numbers until each circle lands on the right face.
  // `below: true` flips the label under the circle, for faces near the top edge.
  // Bright red rather than the deck's rust: it has to cut through a busy photo
  // from the back of the room, so it deliberately ignores the theme palette.
  #let markred = rgb("#ff2d2d")
  #let facemark(dx, dy, label, below: false) = place(
    top + left,
    dx: dx,
    dy: dy,
    box(width: 0pt, height: 0pt)[
      #place(center + horizon, circle(radius: 0.5cm, stroke: 2.5pt + markred))
      #place(
        center + horizon,
        dy: if below { 0.85cm } else { -0.85cm },
        box(
          fill: markred,
          inset: (x: 5pt, y: 2.5pt),
          radius: 2pt,
          text(size: 11pt, weight: 700, fill: white)[#label],
        ),
      )
    ],
  )
  #align(center)[
    #box[
      #link("https://fossi-foundation.org/latch-up/2026/latch_up_2026_group_photo.jpg")[#image(
        "images/latch_up_2026.jpg",
        height: 12.5cm,
      )]
      #facemark(10.5%, 14%, "Yusef")
      #facemark(37.5%, 25%, "Mike")
      #facemark(40%, 32%, "Frederic", below: true)
    ]
  ]
]

#slide(title: "New to hardware? FOSSi to the rescue!")[
  #v(0.3cm)
  #align(center)[#text(size: 22pt)[
    *Free and Open Source Silicon (FOSSi)*: making the entire stack open.
  ]]
  #v(0.3cm)
  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1cm,
    card("The ISA")[
      #set text(size: 16pt)
      *RISC-V* is an open instruction set anyone can implement.
      #linebreak()
      #linebreak()
    ],
    card("The RTL")[
      #set text(size: 16pt)
      *Ibex* and cores like it are real, production CPUs you can read, change, and build.
    ],
    card("The tools ⭐")[
      #set text(size: 16pt)
      The *FOSSi CAD tools* make synthesis, place & route, and flashing, all open too.
    ],
  )
  #v(0.5cm)
  #align(center)[#text(size: 23pt, fill: rust, weight: 700)[
    Open ISA, open implementations, *open tools*
  ]]
  #v(0.4cm)
  #block(
    fill: surface,
    width: 100%,
    inset: 0.4cm,
    radius: 3pt,
    stroke: (paint: cline, thickness: 0.8pt, dash: "dashed"),
  )[
    #set text(size: 13.5pt, fill: mute)
    #text(weight: 700, fill: warm)[Don't forget about the final boss: the PDK.] Even the fab recipe
    can be open: PDKs like *SkyWater 130* and *IHP 130*, plus shared tape-out programs
    (*TinyTapeout*, the *SSCS Chipathon*, academic MPW shuttles) that put real designs onto real
    silicon. #text(style: "italic")[Not today's side quest, but the same idea one level deeper.]
  ]
]

#slide(title: "What I built")[
  #v(0.2cm)
  #text(size: 21pt)[
    A complete little RISC-V *system-on-chip*, generated by *LiteX*, running on a board
    that costs about as much as a few boxes of Timbits.
  ]
  #v(0.2cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.1cm,
    card("The core")[
      #set text(size: 17pt)
      lowRISC *Ibex*: an *RV32IMC*, machine-mode CPU - PLUS a *UART*,
      memory, and a *Wishbone* bus tying it all together.
    ],
    card("The board · $20")[
      #set text(size: 17pt)
      Sipeed *Tang Nano 9K*: a Gowin *GW1NR-9* FPGA, with *8,640* LUT4s
      to squeeze into.
      #linebreak()
      #linebreak()
    ],
  )
  #v(0.3cm)
  #align(center)[
    #image("images/tang_nano.jpg", height: 4.5cm)
  ]
]

#slide(title: "The Ibex core")[
  #v(0.1cm)
  #let cc(title, body) = block(
    fill: surface,
    width: 100%,
    inset: 0.42cm,
    radius: 3pt,
    stroke: 0.8pt + cline,
  )[
    #text(weight: 800, size: 15pt, fill: accent)[#title]
    #v(0.08cm)
    #set text(size: 13pt)
    #body
  ]
  #grid(
    columns: (1.12fr, 1fr),
    column-gutter: 0.9cm,
    align: (center + top, top),
    [
      #link("https://lowrisc.org/wp-content/uploads/2025/12/Ibex-logo-final.png")[#image(
        "images/Ibex-logo.png",
        height: 0.85cm,
      )]
      #v(0.3cm)
      #link("https://ibex-core.readthedocs.io/en/latest/_images/blockdiagram.svg")[#image(
        "images/ibex-block-diagram.svg",
        width: 100%,
      )]
      #v(0.15cm)
      #text(size: 12pt, fill: mute, style: "italic")[The stock Ibex two-stage pipeline.]
    ],
    [
      #stack(
        spacing: 0.35cm,
        cc(
          "Ibex \"small\"",
        )[*RV32IMC*, machine-mode only. Two-stage pipeline, no cache, no branch predictor, no PMP.],
        cc(
          "The one override",
        )[`RegFile=1` #sym.dash swap the flip-flop register file for a *distributed-RAM* one. Everything else is stock `ibex_top.sv`.],
        cc(
          "How it talks",
        )[Ibex speaks *OBI* (shout out OpenHW Foundation); LiteX bridges each bus to *Wishbone*, tying core, RAM, and peripherals together.],
        cc(
          "What's on the bus",
        )[64 KB ROM, 8 KB SRAM, 8 KB main RAM, a *UART*, a *timer*, *GPIO* LEDs, and 4 MB of SPI flash. Two interrupts.],
      )
    ],
  )
  // #v(0.35cm)
  // #align(center)[#text(size: 19pt, fill: rust, weight: 700)[
  //   A production RISC-V core, running out of 8 KB of block RAM.
  // ]]
]

#slide(title: "The open flow")[
  #align(center)[#text(size: 18pt, fill: mute)[
    Every box below is open source, and the Yosys team provides all of them in one download.
  ]]
  #v(0.6cm)
  #let step(name, role) = block(
    fill: surface,
    width: 100%,
    inset: 0.45cm,
    radius: 3pt,
    stroke: 0.8pt + cline,
  )[
    #align(center)[
      #text(weight: 800, size: 17pt, fill: accent)[#name]
      #v(0.12cm)
      #text(size: 13pt, fill: mute)[#role]
    ]
  ]
  #let arr = align(horizon, text(size: 24pt, fill: rust, weight: 800)[#sym.arrow.r])
  #grid(
    columns: (1fr, auto, 1fr, auto, 1fr),
    column-gutter: 0.45cm,
    align: horizon,
    step("LiteX", "generate the SoC + BIOS"),
    arr,
    step("Yosys", "synthesis (+ yosys-slang)"),
    arr,
    step("nextpnr", "place & route"),
  )
  #v(0.55cm)
  #grid(
    columns: (1fr, auto, 1fr, auto, 1fr),
    column-gutter: 0.45cm,
    align: horizon,
    step("Apicula", "pack the bitstream"),
    arr,
    step("openFPGALoader", "flash over JTAG"),
    arr,
    align(center + horizon)[#text(size: 19pt, fill: rust, weight: 800)[real hardware]],
  )
  #v(0.7cm)
  #align(center)[#text(size: 18pt)[
    RISC-V GCC builds the firmware; *LiteX* wires it into a bootable BIOS. No vendor tools anywhere.
  ]]
  #v(0.5cm)
  #align(center)[#text(size: 16pt, fill: rust, weight: 700)[
    All of it from the #link("https://github.com/YosysHQ/oss-cad-suite-build")[OSS CAD Suite], wrapped in one container image.
  ]]
]

#slide(title: "One container, a handful of commands")[
  #v(0.15cm)
  #align(center)[#text(size: 18pt, fill: mute)[
    The *OSS CAD Suite*, plus RISC-V GCC and LiteX, wrapped in one container. No local host installation, no vendor login.
  ]]
  #v(0.5cm)
  #let cmd(c, role) = block(
    fill: surface,
    width: 100%,
    inset: 0.42cm,
    radius: 3pt,
    stroke: 0.8pt + cline,
  )[
    #grid(
      columns: (5.7cm, 1fr),
      column-gutter: 0.6cm,
      align: (left + horizon, left + horizon),
      text(size: 17pt, fill: accent, weight: 700)[#raw(c)], text(size: 15pt, fill: mute)[#role],
    )
  ]
  #stack(
    spacing: 0.4cm,
    cmd("make image", "build the container: toolchain + LiteX"),
    cmd("make soc", "generate, synthesize, and place & route the SoC"),
    cmd("make flash", "load the bitstream and BIOS onto the board"),
    cmd("make run APP=blink_irq", "cross-compile an app and serial-boot it"),
  )
  #v(0.55cm)
  #align(center)[#text(size: 20pt, fill: rust, weight: 700)[
    From an empty checkout to a booting chip, easily and reproducibly.
  ]]
]

#slide(title: "It works")[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 1.1cm,
    align: (center + top, left + horizon),
    align(center + top)[
      #image("images/ibex_bios_banner.png", height: 13cm)
    ],
    [
      #text(size: 18pt)[It boots. On real hardware, over a serial console:]
      #v(0.3cm)
      #set text(size: 15pt)
      #list(
        [`CPU: Ibex @ 24MHz`],
        [`BIOS CRC passed`],
        [`Memtest OK`],
        [a live `litex>` prompt that answers back],
      )
      #v(0.35cm)
      #text(size: 16pt)[...then it runs my own bare-metal *`blink_irq`* app: a hardware
        timer fires a *periodic interrupt* to toggle an LED, with the same ISR also servicing the UART.]
      #v(0.6cm)
      #text(size: 17pt, fill: rust, weight: 700)[
        Fits in 77% of the LUT4s (6,669 / 8,640)
      ]
    ],
  )
]

#slide(title: "Demo")[
  #v(0.4cm)
  #align(center)[#text(size: 30pt, weight: 800)[Let's boot it.]]
  #v(0.7cm)
  #let cmd(c, role) = block(
    fill: surface,
    width: 100%,
    inset: 0.45cm,
    radius: 3pt,
    stroke: 0.8pt + cline,
  )[
    #grid(
      columns: (9.5cm, 1fr),
      column-gutter: 0.6cm,
      align: (left + horizon, left + horizon),
      text(size: 18pt, fill: accent, weight: 700)[#raw(c)], text(size: 16pt, fill: mute)[#role],
    )
  ]
  #stack(
    spacing: 0.45cm,
    cmd("make serial", "tap reset ⟶ BIOS banner, then a live litex> prompt"),
    cmd("make flash-app APP=blink_irq", "write blink_irq into the board's SPI flash"),
    cmd("make reset", "reload from flash ⟶ a timer IRQ blinks the LED, survives a power cycle"),
  )
]

#slide(title: "New to hardware? Oh boy...")[
  #align(center)[#text(size: 18pt, fill: mute)[
    Every one of these was its own little rabbit hole. #text(style: "italic")[It was #strike[a headache] fun to figure out.]
  ]]
  #v(0.45cm)
  #let g(problem, fix) = block(
    fill: surface,
    width: 100%,
    inset: 0.5cm,
    radius: 3pt,
    stroke: 0.8pt + cline,
  )[
    #set text(size: 17pt)
    #text(fill: warm, weight: 700)[#problem]
    #v(0.12cm)
    #text(fill: accent, weight: 800)[#sym.arrow.r] #fix
  ]
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 0.8cm,
    row-gutter: 1cm,
    g("Register file overflowed the chip at 106%")[a distributed-RAM regfile drops it to about 80%],
    g("On-board HyperRAM: 99.6% memtest corruption")[
      skip it; run from 8 KB of BRAM instead
      #linebreak()#linebreak()
    ],

    g("At 27 MHz the CPU was dead silent")[
      #strike[13.5 MHz works though...still not fully sure why.]
      #linebreak()
      *Mouad* solved this like a boy genius. He found a toolchain bug, *PR coming soon*!
    ],
    g("115200 baud overran the receiver")[
      drop to 9600 and uploads work every time
      #linebreak()#linebreak()#linebreak()
      #linebreak()
    ],
  )
  // Overlay Mouad. Drawn last, so it sits on top of everything on this slide.
  #place(center + horizon, dx: -1.2cm, dy: 1.2cm, image("images/mouad.png", width: 3cm))
]

#slide(title: "My main contribution and RISC-V assembly")[
  #v(0.1cm)
  #align(center)[#text(size: 17pt, fill: mute)[
    The code just *never booted*. The fix was simple, but realizing it...took awhile.
  ]]
  #v(0.4cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.0cm,
    card("The wrong offset")[
      #set text(size: 15pt)
      Ibex's hardware reset vector is at `0x80`. The stock crt0 put `_start` at `0x00` and
      pushed the trap table up to `0x100`. On reset the core jumped to `0x80` and landed at
      the *wrong instructions*.
    ],
    card("The missing .norvc")[
      #set text(size: 15pt)
      The vector table also lacked `.norvc`, so its `j` entries could compress to *2 bytes*
      #sym.dash leaving the table *misaligned* under a vectored `mtvec`.
      #linebreak()
      #linebreak()
    ],
  )
  #v(0.4cm)
  #align(center)[#card(none)[
    #set text(size: 16pt)
    #align(center)[Fix: `.option norvc` forces *4-byte* entries, the 32-entry table now spans
      `0x00`#sym.dash`0x7F`, and aligning `_start` right after the table places it right at `0x80`, exactly where
      Ibex resets.]
  ]]
]

#slide(title: "Giving back (as a total beginner)")[
  #v(0.15cm)
  #align(center)[#text(size: 18pt, fill: mute)[
    Two fixes landed *upstream in LiteX*, and the most useful one wasn't code I wrote.
  ]]
  #v(0.45cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.0cm,
    card("Making Ibex build at all")[
      #set text(size: 15pt)
      I filed the issue: stock Yosys can't parse Ibex's SystemVerilog. A maintainer took my proposal and
      wrote a proper *slang* fix #sym.dash but couldn't run it, *no board*.
      #parbreak()
      I tested using my board, and provided two changes that helped finalize the patch.
      #v(0.15cm)
      #text(fill: rust, weight: 700)[Merged: #link("https://github.com/enjoy-digital/litex/pull/2510")[PR \#2510]]
    ],
    card("The reset-vector fix")[
      #set text(size: 15pt)
      The crt0 bug from the last slide #sym.dash tracked down, patched, and sent up. This one
      was mine, end to end.
      #v(3.3cm)
      #text(fill: rust, weight: 700)[
        Merged: #link("https://github.com/enjoy-digital/litex/pull/2487")[PR \#2487]
      ]
    ],
  )
  #v(0.5cm)
  #align(center)[#text(size: 18pt, fill: rust, weight: 700)[
    "I have the weird board and I'll test everything" turns out to be a real contribution.
  ]]
  #v(0.5cm)
  #align(center)[#text(size: 18pt, fill: rust, weight: 700)[
    LiteX developers were very kind and fast to respond, 10/10 would contribute again.
  ]]
]

#{
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    text(size: 38pt, weight: 800)[Where to find it], wordmark(size: 15pt),
  )
  v(0.12cm)
  line(length: 100%, stroke: 0.7pt + cline)
  v(0.5cm)
  text(size: 19pt)[
    If you have a Tang Nano, go try it out!
  ]
  v(0.5cm)
  text(
    size: 26pt,
  )[#text(fill: accent, weight: 800)[Repo] #h(0.4em) #link(
      "https://github.com/riscv-ottawa/ibex-tang-nano-oss-cad",
    )[github.com/riscv-ottawa/ibex-tang-nano-oss-cad]]
  v(0.3cm)
  text(
    size: 26pt,
  )[#text(fill: accent, weight: 800)[Try it] #h(0.4em) Grab a \$20 *Tang Nano 9K* and follow the README, top to bottom.]
  v(0.3cm)
  text(
    size: 26pt,
  )[#text(fill: accent, weight: 800)[Next] #h(0.4em) Point this open flow at something bigger...#linebreak()
    #text(fill: mute)[(small components from a certain root of trust, maybe 👀).]
  ]
  place(bottom + center, dy: 0.4cm)[
    #align(center)[
      #image(markpath, height: 2.2cm)
      #v(0.18cm)
      #text(fill: mute, size: 14pt)[riscvottawa.ca · github.com/riscv-ottawa · discord.gg/EfryE4wfk4]
    ]
  ]
}
