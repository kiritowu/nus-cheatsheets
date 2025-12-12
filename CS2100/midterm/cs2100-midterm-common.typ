#import "@preview/boxed-sheet:0.1.0": *
#import "@preview/muchpdf:0.1.0": muchpdf

#set text(font: (
  "Times New Roman",
  "SimSun",
))

#let homepage = link("https://kiritowu.github.io")[kiritowu.github.io]
#let author = "Tien Cheng & Zhao Wu"
#let title = "CS2100 | Midterm Cheat Sheet"

#let cheatsheet-layout = cheatsheet.with(
  title: title,
  homepage: homepage,
  authors: author,
  write-title: true,
  title-align: left,
  title-number: true,
  title-delta: 2pt,
  scaling-size: false,
  font-size: 7pt,
  line-skip: 5.5pt,
  x-margin: 10pt,
  y-margin: 30pt,
  num-columns: 4,
  column-gutter: 2pt,
  numbered-units: false,
)
