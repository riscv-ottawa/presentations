// RISC-V Ottawa - September 2026 panel question sheet
//
// Compile from this folder:
//     typst compile questions.typ questions.pdf
// Live preview while editing:
//     typst watch questions.typ

// ---- palette (matches the RVO deck, light theme) ----------------------------
#let paper = rgb("#f7f5f0")
#let surface = rgb("#ffffff")
#let cline = rgb("#e4e0d6")
#let ink = rgb("#1a1c20")
#let mute = rgb("#6a6d75")
#let accent = rgb("#3d5a80")
#let rust = rgb("#8c4a3e")

// ---- page + text setup ------------------------------------------------------
#set page(
  paper: "us-letter",
  margin: (top: 1.35cm, bottom: 1.35cm, left: 2.0cm, right: 2.0cm),
  fill: paper,
  footer: context [
    #line(length: 100%, stroke: 0.6pt + cline)
    #v(0.15cm)
    #grid(
      columns: (1fr, auto),
      text(size: 9pt, fill: mute)[#upper("open ISA, open community")],
      text(size: 9pt, fill: mute)[#counter(page).display() / #counter(page).final().first()],
    )
  ],
)
#set text(font: "Fira Sans", size: 12pt, fill: ink)
#set par(leading: 0.63em, spacing: 0.85em, justify: false)

// Never let "RISC-V" break across a line; it is hard to read aloud.
#show regex("RISC-V"): it => box(it.text)

#let wordmark(size: 13pt) = text(size: size, weight: 800, tracking: -0.3pt)[
  RISC#text(fill: rust)[-V] #text(weight: 500, fill: ink)[Ottawa]
]

// A category heading: small all-caps label above a rule.
#let category(label, title) = {
  v(0.28cm)
  block(breakable: false, sticky: true)[
    #text(size: 9pt, weight: 700, fill: accent, tracking: 2pt)[#upper(label)]
    #v(-0.22cm)
    #text(size: 15pt, weight: 800)[#title]
    #v(-0.12cm)
    #line(length: 100%, stroke: 0.8pt + rust)
  ]
  v(0.1cm)
}

// A numbered question. `to` is the panelist it is aimed at. `probe` is the
// follow-up to use if the answer comes back thin, printed faded underneath.
#let qcount = counter("q")
#let q(to, note: none, probe: none, body) = {
  qcount.step()
  v(0.15cm)
  block(breakable: false)[
    #grid(
      columns: (0.95cm, 1fr),
      column-gutter: 0pt,
      align: (right + top, left + top),
      [#text(size: 12pt, weight: 800, fill: accent)[#context qcount.display()#h(0.4cm)]],
      [
        #text(size: 10pt, weight: 700, fill: rust)[#upper(to)]
        #v(-0.25cm)
        #body
        #if probe != none [
          #v(0.02cm)
          #text(size: 10.5pt, fill: mute)[#sym.arrow.r #h(0.08cm) #probe]
        ]
        #if note != none [
          #v(0.05cm)
          #text(size: 10pt, fill: mute, style: "italic")[#note]
        ]
      ],
    )
  ]
}

// A planted cross-talk redirect: faded and unnumbered, so it reads as a move
// the moderator makes rather than another question on the list.
#let crosstalk(to, body) = {
  v(0.12cm)
  block(breakable: false)[
    #grid(
      columns: (0.95cm, 1fr),
      column-gutter: 0pt,
      align: (right + top, left + top),
      [#text(size: 12pt, fill: mute)[#sym.arrow.r#h(0.4cm)]],
      [
        #set text(fill: mute)
        #text(size: 9.5pt, weight: 700, tracking: 1.2pt)[#upper("cross-talk · " + to)]
        #v(-0.24cm)
        #text(size: 11pt)[#body]
      ],
    )
  ]
}

// ---- title block ------------------------------------------------------------
#align(center)[
  #wordmark(size: 15pt)
  #v(0.28cm)
  #text(size: 24pt, weight: 800, tracking: -0.4pt)[Panel: RISC-V in 2026]
  #v(-0.1cm)
  #text(size: 16pt, weight: 600, fill: accent)[Where the Ecosystem Stands, and Where Canada Fits]
  #v(0.15cm)
  #box(width: 6cm)[#line(length: 100%, stroke: 1.2pt + rust)]
  #v(0.24cm)
  #text(size: 10pt, fill: mute)[30 September 2026 · Bell Theatre, Carleton University]
]

#v(0.4cm)

#block(
  fill: surface,
  width: 100%,
  inset: (x: 0.7cm, y: 0.5cm),
  radius: 3pt,
  stroke: 0.8pt + cline,
)[
  #set text(size: 11pt)
  #grid(
    columns: (2.1cm, 1fr),
    row-gutter: 0.4cm,
    column-gutter: 0.2cm,
    align: (right + top, left + top),
    text(weight: 700, fill: accent)[Panelists],
    grid(
      columns: (1.12fr, 1fr),
      row-gutter: 0.28cm,
      column-gutter: 0.45cm,
      [Mike Thompson, OpenHW Foundation \ #text(size: 10pt, fill: mute)[hardware and verification]],
      [Arash Ahmadi, Carleton University \ #text(size: 10pt, fill: mute)[academic]],
      [Scott Bambrough, RISCstar \ #text(size: 10pt, fill: mute)[software and product]],
      [Trevor Gamblin, BayLibre \ #text(size: 10pt, fill: mute)[software and toolchains]],
    ),
    text(weight: 700, fill: accent)[Moderator], [Yusef Karim, RISC-V Ottawa],
  )
]

// ---- questions --------------------------------------------------------------
#category("Introductions", "Yusef introduces each panelist, then one question down the line")

#q("All panelists")[
  Where does RISC-V actually show up in a typical day for you?
]

#category("Category 1", "Is RISC-V production-ready?")

#q("Mike", probe: [if it is all sunny, then ask: are there any thorny areas you feel you need to warn people about?])[
  In 2026, which parts of the RISC-V hardware ecosystem are mature, and which
  parts are still rough?
]

// Lack of platform specifications
// RISC-V brought in profiles, which helped a lot
// RISC-V platform support coming, remember Greg Kroah talk
// Is there a question we can have around this?

#q("Trevor", probe: [if it stays high level: the specific thing that broke on you most
recently?])[
  Same question on the software side: where is the RISC-V software stack genuinely
  mature today, and where is it still rough?
]

#crosstalk("Scott")[
  You have heard the hardware answer and the software answer.
  The type of software RISCstar works on is close to hardware.
  Which side causes the most headache for you?
]

#category("Category 2", "When is choosing RISC-V worth it?")

#q("Arash", probe: [how do you compare? what number would you look at?])[
  For a specialized computing task, when is RISC-V the right choice over an alternative
  that already works?
]

//

#q("Scott", probe: [have you seen a team get that call wrong?])[
  From a product perspective, what single factor most often decides whether a RISC-V
  advantage is worth the software and integration investment it demands?
]

#crosstalk("Arash")[
  That is how it goes in a company. In an academic lab, do the factors change?
]

#category("Category 3", "What can Canadian labs and companies sustain together?")

#q("Arash", probe: [and what keeps it alive after the student graduates or the grant ends?])[
  Drawing on what you see in Canadian labs, name one piece of RISC-V work a university
  and an industry partner could usefully tackle together.
]

#crosstalk("Mike")[
  If Arash's team brought that to OpenHW, what makes it usable outside his lab, and what
  needs to be settled first before wide use?
]

#category("Category 4", "Where can someone here start?")

#q("Trevor")[
  For a student or developer with some programming experience, a laptop, and no RISC-V
  hardware, what is one first project or contribution they could realistically finish in
  a month?
]

#q("Mike")[
  For someone who wants to understand how a RISC-V processor actually works, or learn to
  test one, what is one manageable first exercise, and where do they find it?
]

#q("Scott")[
  For an engineer who wants to explore RISC-V at work without committing the company to a
  platform change, what small evaluation would you have them run first?
]

#q("Arash")[
  For an instructor or a research supervisor who wants to introduce RISC-V without
  redesigning a whole course or research program, what is one small thing they could try
  first?
]

// This is a tough one

#crosstalk("all four")[
  If good on time: anyone want to add anything else here on where people can get started? Ten seconds each.
]

#category("Closer", "The gap worth filling")

#q("Mike, then Arash, then open to the rest for final comments", note: [Audience questions follow.])[
  In one or two sentences each: what skill is genuinely scarce in the Canadian RISC-V
  talent pool right now?
]
