// RISC-V Ottawa - member project pitch: Hardware Root of Trust (Yusef)
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
  place(bottom + left, dy: 0.78cm, text(size: 11pt, fill: mute)[#upper("open ISA, open silicon, open trust")])
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
    #text(size: 50pt, weight: 800, tracking: -0.5pt)[Hardware Root of Trust]
    #v(0.1cm)
    #box(width: 7cm)[#line(length: 100%, stroke: 1.4pt + rust)]
    #v(0.5cm)
    #text(size: 22pt, weight: 600)[The final turtle...]
    #v(0.18cm)
    #text(size: 16pt, fill: mute)[Member project pitch · June 17, 2026 · Yusef Karim]
  ]
  v(1fr)
  pagebreak(weak: true)
}

#slide()[
  #align(center)[
    #image("images/turtles.jpg", height: 13.5cm, fit: "contain")
  ]
]

#slide(title: "What is a root of trust?")[
  #v(0.2cm)
  #text(size: 23pt)[
    The small, trustworthy core the rest of a system's security is built on. It owns
    *secure boot*, *identity keys*, and *attestation*, and everything else trusts it
    implicitly.
  ]
  #v(0.7cm)
  #align(center)[
    #text(size: 22pt, fill: rust, weight: 700)[Security is turtles all the way down.]
    #v(0.15cm)
    #text(size: 20pt, fill: mute)[The root of trust is the final turtle.]
  ]
  #v(0.7cm)
  #text(size: 19pt)[
    It is foundational to every secure device, from a phone to a car to a data-centre
    server.
  ]
  #v(0.35cm)
  #align(center)[#text(size: 20pt, weight: 700)[
    Yet almost every one is a #text(fill: rust)[black box]...you can never knows what's in it or what code it runs.
  ]]
]

#slide(title: "Now it's open, ALL the way down")[
  #text(size: 18pt)[
    #link("https://opentitan.org/")[*OpenTitan*] is the first root of trust open *all the way
    down* #sym.dash to the actual chip design, on *RISC-V*. As of this year it ships in
    production *Google Chromebooks*.
  ]
  #v(0.45cm)
  #let cardc(title, body) = block(
    fill: surface,
    width: 100%,
    inset: 0.5cm,
    radius: 3pt,
    stroke: 0.8pt + cline,
  )[
    #text(weight: 800, size: 17pt, fill: accent)[#title] #v(0.15cm)
    #set text(size: 14pt)
    #body
  ]
  #grid(
    columns: (1.5fr, 1fr),
    column-gutter: 1cm,
    align: (left + horizon, center + horizon),
    grid(
      columns: 1,
      row-gutter: 0.45cm,
      cardc("OpenTitan")[
        Secure boot, key management, attestation, on *RISC-V*. Runs in
        *Verilator* simulation, no hardware required to start.
      ],
      cardc("Pavona")[
        The newer, certification-aligned distribution, adds a *post-quantum*
        crypto stack and a modern key manager.
      ],
    ),
    [
      #image("images/opentitan-chip.jpg", width: 100%, fit: "contain")
      #v(0.25cm)
      #text(size: 13pt, fill: mute, style: "italic")[#link(
        "https://opentitan.org/img/opentitan-chip.jpg",
      )[OpenTitan chip shipping in Chromebooks]]
    ],
  )
  #v(0.45cm)
  #align(center)[#text(size: 18pt, fill: rust, weight: 700)[
    Real security on open RISC-V hardware that we can poke and prod.
  ]]
]



#slide(title: "Why?")[
  #v(0.4cm)
  #text(size: 22pt)[
    I learned about OpenTitan five years ago during my Master's.
  ]
  #v(0.5cm)
  #text(size: 22pt)[
    Then I finished, became a boring software engineer, and never touched it again.
  ]
  #v(0.5cm)
  #text(size: 22pt, fill: rust, weight: 700)[
    I've wanted to come back to it ever since. This group is the excuse.
  ]
  #v(6cm)
  #align(center)[#text(size: 18pt, fill: mute)[
    The tooling is free, the implementation is fully open, and there are *so many things to learn* about.
  ]]
]

#let topics = (
  "secure boot",
  "ML-KEM",
  "OTP fuses",
  "attestation",
  "ePMP",
  "Ibex",
  "lifecycle",
  "ASCON",
  "DICE",
  "side-channel analysis",
  "KMAC",
  "ownership transfer",
  "Verilator",
  "root keys",
  "fault injection",
  "ML-DSA",
  "flash scrambling",
  "certificate chains",
  "entropy source",
  "FIPS 140-3",
  "key derivation",
  "SPHINCS+",
  "FPGA bring-up?",
  "measured boot",
  "CSRNG",
  "HMAC",
  "tamper detection",
  "ChipWhisperer",
  "signature verification",
  "SRAM scrambling",
  "Bazel",
  "post-quantum crypto",
  "EDN",
  "fusesoc",
  "AES",
  "threat modeling",
  "DRBG",
  "secure storage",
  "ECIES",
  "provisioning",
  "hardened counters",
  "RSA / ECC",
  "Tock OS",
  "embedded Rust",
  "CDC / RDC",
  "mailboxes",
  "DMA",
  "Sky130",
  "TinyTapeout",
  "tapeout",
  "AST",
  "redundancy",
  "comportable IP",
  "key manager",
  "DV / UVM",
  "firmware update",
  "rollback protection",
  "TPM vs HSM vs SE",
  "memory protection",
  "PKI",
  "TileLink",
)
#let cloudsizes = (13pt, 16pt, 19pt, 14pt, 17pt, 15pt, 12pt, 18pt, 15pt)
#let cloudcols = (ink, accent, rust, accentsoft, mute)

#slide(title: "...so many things to learn")[
  #v(0.5cm)
  #align(center, block(width: 98%, {
    set par(leading: 0.85em, justify: false)
    for (i, t) in topics.enumerate() {
      box(inset: (x: 0.3em, y: 0.1em), text(
        size: cloudsizes.at(calc.rem(i * 4 + 2, cloudsizes.len())),
        fill: cloudcols.at(calc.rem(i * 3 + 1, cloudcols.len())),
        weight: if calc.rem(i, 3) == 0 { 800 } else { 400 },
      )[#t])
      [ ]
    }
  }))
]

#slide(title: "The path: make it, then break it")[
  #align(center)[#text(size: 22pt, weight: 700, fill: accent)[
    understand it #sym.arrow run it #sym.arrow break it
  ]]
  #v(0.4cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.1cm,
    card("Simulation-first")[
      #set text(size: 16pt)
      Build the chip in *Verilator* on a laptop, no FPGA needed.
      // [Secure boot: boot a signed image, then flip one bit and watch it *refuse to boot*],
      // [Key management: derive a device identity and verify its *attestation certificate* off-device],
      // [Run a *Tock* app that performs an attested operation],
    ],
    card("Hardware later, if we can get it")[
      #set text(size: 16pt)
      The supported FPGA boards (CW310/CW340) are *very* expensive (\$8k–16k).
    ],
  )
  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1cm,
    card("Understand")[
      #set text(size: 15pt)
      Secure boot, identity, attestation, key management.
      Subsystem by subsystem.
    ],
    card("Run")[
      #set text(size: 15pt)
      Run it in *Verilator* and test end to end:
      provision, boot, attest, run an owner app.
    ],
    card("Break")[
      #set text(size: 15pt)
      Forge things, poke it in weird ways.
      Figure out what it can and can't do.
    ],
  )
  #v(0.7cm)
  #align(center)[#text(size: 16pt, fill: mute)[
    Side quest: bribe someone to get an FPGA
  ]]
]

// ---- why this group + ask ---------------------------------------------------
#{
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    text(size: 38pt, weight: 800)[Interested?], wordmark(size: 15pt),
  )
  v(0.12cm)
  line(length: 100%, stroke: 0.7pt + cline)
  v(0.5cm)
  // #set par(spacing: 0.7em)
  text(size: 19pt)[
    This ties together many things the group already cares about: *RISC-V*, *simulation*,
    *FPGAs*, *embedded Rust and C*, and *secure firmware*. Hard to do alone, very doable
    together.
  ]
  v(0.4cm)
  text(
    size: 19pt,
  )[#text(fill: accent, weight: 800)[Now] #h(0.4em) Join #text(weight: 700, fill: rust)[Discord \#hwrot]]
  v(0.3cm)
  text(
    size: 19pt,
  )[#text(fill: accent, weight: 800)[Learn more] #h(0.4em) Browse #link("https://opentitan.org/")[opentitan.org] and #link("https://pavona.org/")[pavona.org].]
  v(0.3cm)
  text(
    size: 19pt,
  )[#text(fill: accent, weight: 800)[Help] #h(0.4em) ...if you know anyone who'd lend us a \$16k FPGA, let me know 👀.]
  place(bottom + center, dy: 0.4cm)[
    #align(center)[
      #image(markpath, height: 2.2cm)
      #v(0.18cm)
      #text(fill: mute, size: 14pt)[riscvottawa.ca · github.com/riscv-ottawa · discord.gg/EfryE4wfk4]
    ]
  ]
}
