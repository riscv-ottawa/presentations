// Project Craton, announced at RISC-V Ottawa, 30 September 2026.

#let dark = false // <-- set to true for the dark theme

#let have-qr = true
#let have-cover = true
#let have-opening-photos = true

#let theme = if dark {
  (
    paper: rgb("#11141a"),
    cline: rgb("#262b34"),
    ink: rgb("#e6e7eb"),
    mute: rgb("#848a96"),
    accent: rgb("#c08070"),
  )
} else {
  (
    paper: rgb("#f7f5f0"),
    cline: rgb("#e4e0d6"),
    ink: rgb("#1a1c20"),
    mute: rgb("#6a6d75"),
    accent: rgb("#8c4a3e"),
  )
}
#let paper = theme.paper
#let cline = theme.cline
#let ink = theme.ink
#let mute = theme.mute
#let accent = theme.accent

#let milestone-labels = (
  [core simulates],
  [first interrupt],
  [SoC together],
  [software boots],
  [published],
  [hardened],
)

// ---------------------------------------------------------------------------

#set document(
  title: "Project Craton",
  author: "Yusef Karim",
)

#set page(
  width: 33.867cm,
  height: 19.05cm, // 16:9
  margin: (top: 1.55cm, bottom: 1.4cm, left: 2.2cm, right: 2.2cm),
  fill: paper,
)

#set text(
  font: "Fira Sans",
  size: 20pt,
  fill: ink,
  lang: "en",
  region: "ca",
)
#set par(leading: 0.72em, spacing: 0.95em)

// ---------------------------------------------------------------------------
// Brand, matching the RISC-V Ottawa template.
// ---------------------------------------------------------------------------

#let wordmark(size: 24pt) = text(size: size, weight: 800, tracking: -0.5pt)[
  RISC#text(fill: accent)[-V] #text(weight: 500, fill: ink)[Ottawa]
]

#let kicker(s) = text(size: 15pt, weight: 700, fill: accent, tracking: 2.5pt)[#upper(s)]

// ---------------------------------------------------------------------------
// Slide helpers
// ---------------------------------------------------------------------------

#let footer-page-count() = context place(bottom + right, dy: 0.78cm, text(size: 11pt, fill: mute)[
  #counter(page).display() / #context counter(page).final().first()
])

#let footer() = {
  place(bottom + left, dy: 0.78cm, kicker("project craton"))
  footer-page-count()
}

#let slide(title, body) = {
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    block(width: 100%)[
      #set text(size: 26pt, weight: 600, fill: accent, tracking: 0.02em)
      #smallcaps(title)
    ],
    wordmark(size: 15pt),
  )
  v(0.12cm)
  line(length: 100%, stroke: 0.6pt + cline)
  v(0.55cm)
  body
  footer()
  pagebreak(weak: true)
}

#let support(body) = block(above: 1.15em, below: 0pt)[
  #set text(size: 17pt, fill: mute)
  #body
]

#let lead(body) = block(above: 0.2em, below: 0.2em)[
  #set text(size: 34pt, weight: 600, fill: ink)
  #set par(leading: 0.48em)
  #body
]

// Short lines stacked with air between them. The list marker is a terracotta
// tick of rule rather than a bullet, which reads cleaner at this size.
#let points(..items) = block(above: 0.9em, below: 0.4em, {
  set text(size: 25pt)
  stack(spacing: 0.85em, ..items.pos().map(it => grid(
    columns: (16pt, 1fr),
    column-gutter: 14pt,
    align: (left + horizon, left + top),
    box(width: 16pt, line(length: 100%, stroke: 2pt + accent)),
    it,
  )))
})

#let dot(n, size: 30pt, active: false) = box(
  width: size,
  height: size,
  radius: 50%,
  fill: if active { accent } else { paper },
  stroke: 1.2pt + (if active { accent } else { cline }),
  align(center + horizon, text(
    size: size * 0.44,
    weight: 600,
    fill: if active { paper } else { mute },
  )[#n]),
)

#let gate-node(size: 30pt, active: false) = box(
  width: size,
  height: size,
  align(center + horizon, rotate(45deg, reflow: false, box(
    width: size * 0.66,
    height: size * 0.66,
    fill: paper,
    stroke: 1.2pt + (if active { ink } else { cline }),
  ))),
)

#let chain(nodes, dy) = {
  let n = nodes.len()
  block(width: 100%)[
    #place(
      top + left,
      dx: 100% / (2 * n),
      dy: dy,
      line(length: 100% * (n - 1) / n, stroke: 0.8pt + cline),
    )
    #grid(columns: (1fr,) * n, align: center + top, ..nodes)
  ]
}

#let spine-full(active: ()) = block(width: 100%, above: 0.6em, below: 1.0em)[
  #chain(
    range(1, 7).map(n => dot(n, active: active.contains(n))) + (gate-node(),),
    15pt,
  )
  #v(0.1em)
  #grid(
    columns: (1fr,) * 7,
    align: center + top,
    gutter: 5pt,
    ..milestone-labels.map(l => text(size: 15pt, fill: mute)[#l]),
    text(size: 15pt, fill: ink, weight: 600)[done],
  )
]

#let spine-strip(active) = box(width: 40%)[
  #chain(
    range(1, 7).map(n => dot(n, size: 15pt, active: active.contains(n))) + (gate-node(size: 15pt),),
    7pt,
  )
]

#let beat(title, active, claim, note) = slide(title)[
  #place(bottom + left, dy: 0.2cm, spine-strip(active))
  #v(0.8em)
  #lead(claim)
  #support(note)
]

#let book-cover(height: 11.6cm) = if have-cover {
  image("images/book-cover.jpg", height: height)
} else {
  box(
    width: height * 2 / 3,
    height: height,
    fill: paper,
    stroke: 0.8pt + cline,
    radius: 2pt,
    align(center + horizon, text(size: 15pt, fill: mute)[
      #align(center)[book cover\ images/book-cover.jpg]
    ]),
  )
}

#let signup-qr(size: 7.6cm) = if have-qr {
  image("images/signup-qr.svg", width: size, height: size)
} else {
  box(
    width: size,
    height: size,
    fill: paper,
    stroke: 0.8pt + ink,
    radius: 2pt,
    align(center + horizon, text(size: 15pt, fill: mute)[QR\ ticket 13]),
  )
}

#let opening-arrow() = box(width: 1.3cm, height: 1cm)[
  #align(center + horizon, text(size: 26pt, fill: accent)[→])
]

#let opening-photo(n, height: 5.5cm) = if have-opening-photos {
  image("images/opening-" + str(n) + ".jpg", height: height)
} else {
  let label = "opening-" + str(n)
  let path = "images/" + label + ".jpg"
  box(
    width: height * 4 / 3,
    height: height,
    fill: paper,
    stroke: 0.8pt + cline,
    radius: 2pt,
    align(center + horizon, text(size: 15pt, fill: mute)[
      #align(center)[#label\ #path]
    ]),
  )
}

#let opening-strip(height: 5.5cm) = grid(
  columns: (auto,) * 5,
  align: center + horizon,
  column-gutter: 0.4cm,
  opening-photo(1, height: height),
  opening-arrow(),
  opening-photo(2, height: height),
  opening-arrow(),
  opening-photo(3, height: height),
)

// ===========================================================================
// 1. Title.
// ===========================================================================

#v(1fr)
#block[
  #set text(size: 54pt, weight: 600, tracking: 0.06em)
  PROJECT CRATON
]
#v(-0.25em)
#line(length: 42%, stroke: 2.5pt + accent)
#v(0.6em)
#block[
  #set text(size: 26pt)
  Ottawa is going to build a microcontroller.
]
#v(1fr)
#block[
  #set text(size: 16pt, fill: mute)
  RISC-V Ottawa, 30 September 2026
]
#pagebreak(weak: true)

// ===========================================================================
// 2. The opening claim.
// ===========================================================================

#v(1fr)
#block[
  #set text(size: 38pt, weight: 600)
  #set par(leading: 0.48em)
  Almost nobody gets to take a design all the way\ to the point a fab could build it.
]
#v(3em)
#block[
  #set text(size: 33pt, weight: 600, fill: accent)
  #set par(leading: 0.48em)
  We are doing it in public, and you could play a part in it.
]
#v(1.2em)
#align(center)[#opening-strip()]
#v(1fr)
#pagebreak(weak: true)

// ===========================================================================
// 3. The motivation.
// ===========================================================================

#slide("Why this is usually hard to do")[
#points(
  [Universities teach the theory, not the flow.],
  [Industry keeps many of the final steps behind NDAs.],
  [The tools used to cost more than a car (maybe even a house).\ The open ones don't.],
)

#support[
  An open-source RISC-V microcontroller, built end to end with open tools (where possible).
  Everything we do is published as we do it.
]
]

// ===========================================================================
// The work.
// ===========================================================================

#slide("Six milestones, and a finish line")[
#spine-full()

#v(0.5em)
#lead[Each one is a place somebody new could start.]

#support[
  The finish line is a handful of processes that anyone can run, from a clean checkout, on their own machine.
]
]

#beat(
  "First, it runs",
  (1, 2),
)[A RISC-V core simulating on your laptop, and RTL we wrote servicing real interrupts.][
  One container, no license, and no NDA - this is where everyone starts.
]

#beat(
  "Then it is a full System-on-Chip",
  (3, 4, 5),
)[Code we wrote, running on hardware we designed, in the open so anyone can check or use it.][
  Integration is where we'll catch all the real bugs and edge cases, bring-up will be on a board (FPGA initially) you can hold,
  and code + measurement results will be published for others to look and play around with it.
]

#beat(
  "Finally we make it fab(ulous) ready",
  (6,),
)[The design hardened into a layout, and put through a fab's design rule check (DRC) process.][
  Placement, routing, timing and the physical checks, with open tools. The hardest
  part of the industry to get experience in. We'll also work hard to actually get it built in the end.
]

// ===========================================================================
// 8. The offer.
// ===========================================================================

#slide("What you walk away with")[
#points(
  [A complete design taken to the point a fab could build it, this could have your name on the parts you helped build.],
  [SystemVerilog, assertions and coverage, synthesis, place and route, timing closure. All of it in open tools wherever possible.],
  [Work you can show to anyone, committed and version controlled.],
)

#support[
  The simulation and verification flow runs on any machine with a container
  runtime. The physical flow too (you might just need a bigger PC).
  Holding a contributor role will require sustained effort, not a single weekend.
]
]

// ===========================================================================
// 9. The roles.
// ===========================================================================

#slide("The roles. Pick many.")[
#points(
  [RTL design and verification],
  [RISC-V standards research],
  [Developing build systems usable by everyone],
  [Toolchain and compilers],
  [Embedded framework and OS ports],
  [FPGA work],
  [Physical design (RTL to GDSII)],
)
]

// ===========================================================================
// 10. The repository.
// ===========================================================================

#slide("It is open from today")[
#v(0.5em)
#block(above: 0.4em, below: 1.5em)[
  #set text(size: 40pt, weight: 600, fill: ink)
  #link("https://github.com/riscv-ottawa/craton")[github.com/riscv-ottawa/craton]
]

#points(
  [Read the preliminary docs, fork it, provide feedback, get ready for the real work.],
  [License: Solderpad 2.1],
)

#support[
  The repo is barebones for now, but everything we do will be published there as we do it.
]
]

// ===========================================================================
// 11. November.
// ===========================================================================

#slide("What happens next")[
#v(0.8em)
#lead[Work starts in November.]

#v(0.7em)
#points(
  [We'll give a technical talk on what we are actually building, in November's meetup.],
)
]

// ===========================================================================
// 12. The book club, the gate's first door.
// ===========================================================================

#slide("Read it with us")[
#grid(
  columns: (auto, 1fr),
  column-gutter: 1.6cm,
  align: (left + top, left + top),
  book-cover(),
  block[
    #block(above: 0pt, below: 0.6em)[
      #set text(size: 34pt, weight: 600, fill: ink)
      #set par(leading: 0.48em)
      RISC-V System-on-Chip Design
    ]
    #block(above: 0pt, below: 1.1em)[
      #set text(size: 22pt, fill: mute)
      David Harris, James Stine, Rose Thompson, Sarah Harris
    ]
    #points(
      [Book club!!!],
      [We'll read it together, a chapter at a time.],
      [Buy a copy and start reading with us!],
      [First meeting in November.],
    )
    #support[
      Hate books? Too expensive? Next slide!
    ]
  ],
)
]

// ===========================================================================
// 13. The last slide: how to join
// ===========================================================================

#slide("How to join?")[
#grid(
  columns: (1fr, auto),
  column-gutter: 1.4cm,
  align: (left + top, center + top),
  block[
    #lead[Three doors.]
    #support[Enter through at least one of them to join:]
    #v(0.35em)
    #points(
      [Read the book with us.],
      [Join or create another RISC-V Ottawa project.],
      [A non-trivial PR contribution to Craton itself once it's started.],
    )
    #support[
      Scan the QR, fill out the short form.
      Whichever door you are taking, you'll hear from us in November.
    ]
  ],
  block[
    #signup-qr()
    #block(above: 0.7em)[
      #set text(size: 17pt, fill: mute)
      #align(center)[Same code on the front table.]
    ]
  ],
)
]
