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
// #let footer() = context {
//   place(bottom + left, dy: 0.78cm, text(size: 11pt, fill: mute)[#upper("open ISA, open community")])
//   place(bottom + right, dy: 0.78cm, text(size: 11pt, fill: mute)[
//     #counter(page).display() / #context counter(page).final().first()
//   ])
// }

// #let slide(title: none, body) = {
//   grid(
//     columns: (1fr, auto),
//     align: (left + horizon, right + horizon),
//     text(size: 30pt, weight: 800)[#title], wordmark(size: 15pt),
//   )
//   v(0.12cm)
//   line(length: 100%, stroke: 0.7pt + cline)
//   v(0.55cm)
//   body
//   footer()
//   pagebreak(weak: true)
// }

#{
  v(1fr)
  align(center)[
    #image(markpath, height: 5.1cm)
    #v(0.55cm)
    #wordmark(size: 50pt)
    #v(0.05cm)
    #box(width: 6cm)[#line(length: 100%, stroke: 1.4pt + rust)]
    #v(0.5cm)
  ]
  v(1fr)
  pagebreak(weak: true)
}
