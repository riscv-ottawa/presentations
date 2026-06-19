// RISC-V Ottawa - inaugural meeting status update
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
    #image(markpath, height: 5.1cm)
    #v(0.55cm)
    #wordmark(size: 50pt)
    #v(0.05cm)
    #box(width: 6cm)[#line(length: 100%, stroke: 1.4pt + rust)]
    #v(0.5cm)
    #text(size: 23pt, weight: 600)[Community status update]
    #v(0.18cm)
    #text(size: 16pt, fill: mute)[Inaugural meeting · June 17, 2026 · Yusef Karim]
  ]
  v(1fr)
  pagebreak(weak: true)
}

#slide(title: "My journey")[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.1cm,
    align: center,
    image("images/rocket.png", height: 13cm, fit: "contain"),
    image("images/rocket_takeoff.png", height: 13cm, fit: "contain"),
  )
]

#slide(title: "RISC-V is already here")[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.1cm,
    card("Industry")[
      #set text(size: 14pt)
      #set list(spacing: 0.55em)
      #list(
        [*NVIDIA* over 1 billion RISC-V cores shipped in their products],
        [*Meta* RISC-V in their custom AI chips],
        [*Tenstorrent* designing their own RISC-V AI chips in Toronto],
        [*Google* every new Chromebook ships with a RISC-V security core],
        [*Western Digital* RISC-V cores in SSD and HDD controllers],
        [*Espressif* ESP32-C3/C6/H2, everywhere in IoT and maker products],
        [*Alibaba* XuanTie RISC-V cores, widely deployed and open-sourced],
      )
    ],
    card("And spreading fast")[
      #set text(size: 16pt)
      #set list(spacing: 0.65em)
      #list(
        [Automotive],
        [Embedded systems and dev boards],
        [Space and defence],
        [A huge and growing open source research ecosystem],
      )
    ],
  )
  #v(0.5cm)
  #align(center)[#text(fill: rust, size: 17pt, weight: 700)[
    Hardware...is still hard, but the barrier to entry has never been lowered.
  ]]
]

#slide(title: "Who we are")[
  #text(size: 21pt)[
    RISC-V Ottawa exists to *grow* and *consolidate* a *local community* of engineers, researchers, and students in Canada’s capital region to *learn*, *tinker*, *build*, and, ultimately, *contribute* together across the full *RISC-V* stack: ISA specifications, digital design and verification, FPGAs, embedded systems, operating systems, and applications...nothing is off the table.
  ]
  #v(0.55cm)
  #v(0.6cm)
  #align(center)[#text(fill: mute, size: 17pt)[
    Currently about 6 people and a website...
  ]]
]

#slide(title: "What the group is for")[
  #text(size: 20pt)[
    Making individual projects involving RISC-V technologies tractable. Work that is hard to do alone
    becomes doable via shared knowledge, peer review, and eventually hardware/tooling.
  ]
  #v(0.4cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.1cm,
    card("What members might work on")[
      #set text(size: 13pt)
      #set list(spacing: 0.58em)
      #list(
        [Implementation on FPGAs],
        [Verification (UVM, cocotb)],
        [Learning and testing new ideas in simulation (Verilator)],
        [Bring-up and drivers for new RISC-V SBCs],
        [Embedded systems applications (firmware and/or Linux)],
        [Improving support in firmware/RTOS frameworks],
        [Upstream toolchain work (GCC, LLVM, QEMU)],
        [Custom core or ISA extensions],
      )
    ],
    card("What the group provides")[
      #set text(size: 15pt)
      #set list(spacing: 0.58em)
      #list(
        [*Technical*
          #list(
            [Projects sharing, hands-on hardware session, guided hackathons],
          )
        ],
        [*Educational*
          #list(
            [Public training (already started), workshops, study groups, university collaborations],
          )
        ],
        [*Social/professional*
          #list(
            [Networking events, invited speakers],
          )
        ],
      )
    ],
  )
  #v(0.35cm)
  #text(fill: rust, size: 15pt)[
    *Key point:* We will not do this all at once.
    Instead, we will weave between the technical, educational, and social as opportunities rise and according to the interests of the group.
  ]
]


#slide(title: "What's in place")[
  #set text(size: 18pt)
  #list(
    [Website: #link("https://riscvottawa.ca")[riscvottawa.ca]
      #list(
        [Curated resource index: #link("https://riscvottawa.ca/resources")[riscvottawa.ca/resources]],
      )
    ],
    [GitHub: #link("https://github.com/riscv-ottawa")[riscv-ottawa]],
    [Discord: #link("https://discord.gg/EfryE4wfk4")[RISC-V Ottawa]],
    [Training material (will discuss later)],
    [We're working on making relationships with others in this area
      #list(
        [*OpenHW* and *Eclipse* foundations, both presented tonight (thank you ❤️)],
        [Actively working on collaborations with *UOttawa* and *Carleton*],
        [Actively communicating with other RISC-V communities, e.g., #link("https://workswithriscv.net/")[*Works with RISC-V*]
          #list(
            [Works with RISC-V is one of the largest "unofficial" RISC-V communities],
            [Similar idea as RVO, but global - we will certainly collaborate in the near future],
          )
        ],
      )
    ],
  )
]

#slide(title: "A metaphor")[
  #align(center)[#image("images/community_garden.png", width: 100%, height: 13cm, fit: "contain")]
]


#slide(title: "Training")[
  #text(size: 26pt, weight: 800)[RISC-V Embedded Systems Training #text(fill: rust)[VEGA edition]]
  #v(0.2cm)
  #text(size: 19pt)[
    Free and open. Bare-metal firmware on the VEGAboard (RV32M1, RI5CY core,
    RV32IMC). Runs on hardware or entirely in Renode.
  ]
  #v(0.55cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.1cm,
    row-gutter: 0.5cm,
    [#text(fill: accent, weight: 800)[1] #h(0.3em) Hello, firmware world #text(fill: mute, size: 15pt)[ — GPIO, linker script, GDB, Renode]],
    [#text(fill: accent, weight: 800)[2] #h(0.3em) Talking to the world #text(fill: mute, size: 15pt)[ — LPUART0, a console REPL, CSR counters]],

    [#text(fill: accent, weight: 800)[3] #h(0.3em) Interrupts and timers #text(fill: mute, size: 15pt)[ — trap model, EVENT_UNIT/INTMUX, LPTMR]],
    [#text(fill: accent, weight: 800)[4] #h(0.3em) 🚧 RTOS / Zephyr #text(fill: mute, size: 15pt)[ — west, devicetree, threads]],
  )
  #v(0.6cm)
  #card(none)[
    #text(size: 21pt, weight: 700)[#link("https://vega.riscvottawa.ca/")[vega.riscvottawa.ca]] #h(1.2em)
    #text(fill: mute)[Discussion and help:] #text(weight: 700, fill: rust)[Discord \#vega-training]
  ]
]

#slide(title: "Live demo: VegaConsole")[
  #text(size: 20pt)[
    A UART REPL with two interrupt sources running alongside it.
    Demonstrates timers, interrupts, and how they decouple background work from the foreground loop.
  ]
  #v(0.45cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.1cm,
    [
      #set list(spacing: 0.7em)
      #list(
        [Heartbeat LED toggled from the LPTMR ISR at 1 Hz; the REPL loop stays in the foreground],
        [`slow` busy-loops 2s: the REPL stalls, the heartbeat keeps blinking],
        [`crash` executes an illegal instruction; the trap handler logs `mcause`/`mepc` and resumes],
        [SW2 button is a second interrupt (direct EVENT_UNIT line, software debounced) that pauses/resumes the heartbeat],
      )
    ],
    block(fill: surface, width: 100%, inset: 0.7cm, radius: 4pt, stroke: 0.8pt + cline)[
      #set text(font: "DejaVu Sans Mono", size: 15pt)
      #text(fill: accent)[vega>] crash \
      about to do something illegal... \
      #text(fill: rust)[trap! cause=2 epc=0x00000abc] \
      ...and back! \
      #text(fill: accent)[vega>] ticks \
      g_ticks=412 (~4 s since boot) \
      #text(fill: accent)[vega>]
    ],
  )
]

#{
  v(1fr)
  align(center)[
    #text(size: 52pt, weight: 800)[Where we're going]
    #v(0.4cm)
    #box(width: 7cm)[#line(length: 100%, stroke: 1.4pt + rust)]
  ]
  v(1fr)
  footer()
  pagebreak(weak: true)
}

#slide(title: "Near-term")[
  #list(
    [#strong[Member projects begin]: the first pitches are up next],
    [#strong[Monthly meetup]: ideally at least one invited speaker (hardware or software), project check-ins, new pitches],
    [#strong[Study groups] eventually...whenever #link("https://pages.hmc.edu/harris/ddca/rvsocd.html")[RISC-V System-on-Chip Design] comes out],
  )
  #v(0.7cm)
  #grid(
    columns: (auto, auto, auto),
    column-gutter: 0.9cm,
    align: center,
    card(none)[#align(center)[
        #text(size: 24pt, weight: 800)[Jul 15]
        #linebreak()
        #text(size: 16pt)[(tentative)]
        #linebreak()
        #text(fill: mute, size: 15pt)[meetup #sym.hash 2]
      ]
    ],
    card(none)[#align(center)[
        #text(size: 24pt, weight: 800)[Aug 19]
        #linebreak()
        #text(size: 16pt)[(tentative)]
        #linebreak()
        #text(fill: mute, size: 15pt)[meetup #sym.hash 3]
      ]
    ],
    card(none)[#align(center)[
        #text(size: 24pt, weight: 800)[Sep 16]
        #linebreak()
        #text(size: 16pt)[(tentative)]
        #linebreak()
        #text(fill: mute, size: 15pt)[meetup #sym.hash 4]
      ]
    ],
  )
]

#slide(title: "Long-term...you decide!")[
  #align(center)[#image("images/recruitment_poster.png", width: 100%, height: 13cm, fit: "contain")]
]

#{
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    text(size: 38pt, weight: 800)[Getting started], wordmark(size: 15pt),
  )
  v(0.12cm)
  line(length: 100%, stroke: 0.7pt + cline)
  v(0.7cm)
  grid(
    columns: (1.25fr, 0.75fr),
    column-gutter: 1.2cm,
    [
      #set par(spacing: 0.7em)
      #text(
        size: 20pt,
      )[#text(fill: accent, weight: 800)[Now] #h(0.4em) Discord, #text(weight: 700, fill: rust)[scan the QR -->]]
      #v(0.45cm)
      #text(
        size: 20pt,
      )[#text(fill: accent, weight: 800)[Summer] #h(0.4em) Pitch your own project, join current projects, read the training, next meetup July 15]
      #v(0.45cm)
      #text(
        size: 20pt,
      )[#text(fill: accent, weight: 800)[Help run it] #h(0.4em) Organizers, a venue, sponsors, university contacts, tell your boss]
    ],
    block(fill: surface, width: 100%, inset: 0.7cm, radius: 3pt, stroke: 0.8pt + cline)[
      #align(center)[
        // Drop a QR PNG here if you have one:
        #image("images/discord-qr.svg", height: 6cm)
        #v(0.25cm)
        #text(size: 15pt, weight: 700)[discord.gg/EfryE4wfk4]
      ]
    ],
  )
  v(1fr)
  align(center)[
    #image(markpath, height: 2.7cm)
    #v(0.2cm)
    #text(fill: mute, size: 15pt)[riscvottawa.ca · github.com/riscv-ottawa · discord.gg/EfryE4wfk4]
  ]
  v(0.3cm)
}
