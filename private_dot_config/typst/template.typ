// Convert a content to a string.
// @see https://github.com/typst/typst/issues/2196
#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let default-code-info = (
  caption: none,
  label: none,
  show-line-numbers: false,
  start-line: 1,
  highlight-line: ()
)

#let code-info-state = state("code-info", default-code-info)

#let code-info(
  caption: default-code-info.caption,
  label: default-code-info.label,
  show-line-numbers: default-code-info.show-line-numbers,
  start-line: default-code-info.start-line,
  highlight-line: default-code-info.highlight-line,
) = {
  code-info-state.update((
    caption: caption,
    label: label,
    show-line-numbers: show-line-numbers,
    start-line: start-line,
    highlight-line: highlight-line,
  ))
}

// Display a title, author, and date.
#let report-title(
  title: [タイトル],
  author: [著者],
  date: datetime.today(),
  font: "Noto Serif JP",
  gap: (32pt, 32pt),
) = {
  let leading = 0.8em
  align(center)[
    #heading(level: 1, numbering: none)[
      #set text(font: font, size: 16pt, weight: "regular")
      #set par(leading: leading)
      #title
    ]
    #block(above: gap.at(0))[
      #set text(font: font, size: 12pt, weight: "regular")
      #set par(leading: leading)
      #author
    ]
    #block(above: gap.at(1))[
      #set text(font: font, size: 12pt, weight: "regular")
      #set par(leading: leading)
      #date.display("[year padding:none]年[month padding:none]月[day padding:none]日")
    ]
  ]
}

#let report(
  title: [タイトル],
  author: [著者],
  date: datetime.today(),
  /// title type: "fullpage" | "inpage" | "none"
  title-type: "fullpage",
  title-component: report-title,
  heading-font: "Noto Sans JP",
  body-font: "Noto Serif JP",
  mono-font: "UDEV Gothic NFLG",
  title-font: "Noto Serif JP",
  body,
) = {
  // Configure the pdf document properties.
  set document(
    title: to-string(title),
    author: to-string(author),
    date: date,
  )

  // Configure the page size and margins.
  set page(
    paper: "a4",
    margin: (
      top: 25mm,
      bottom: 30mm,
      left: 25mm,
      right: 25mm,
    ),
    numbering: "1",
  )

  // Configure text appearance
  set par(leading: 1em, justify: true)
  set text(font: body-font, lang: "ja", region: "jp", size: 10pt)
  set heading(numbering: "1.1.1.1.1.  ")
  show par: set block(spacing: 2em, above: 2em)
  show heading: it => [
    #set block(above: 2.5em, below: 1em)
    #set text(font: heading-font, weight: "semibold")
    #it
  ]

  // Configure equation numbering and spacing
  set math.equation(numbering: "(1)")
  show math.equation.where(block: true): it => {
    set block(spacing: 1em)
    if it.numbering == none {
      return it  // 停止性を保証する
    }

    // ラベルがある場合のみ、式に番号を振る
    if it.has("label") {
      it
    } else {
      math.equation(block: true, numbering: none)[#it.body]
      counter(math.equation).update(n => n - 1)
    }
  }
  show math.equation.where(block: false): it => locate(loc => [
    #h(0.25em, weak: true)
    #it
    #h(0.25em, weak: true)
  ])

  // Configure appearance of references
  show ref: it => {
    let elem = it.element
    if (elem == none) {
      return it
    }

    // equation
    if elem.func() == math.equation {
      return link(
        elem.location(),
        [
          式 $#numbering(
            elem.numbering,
            ..counter(math.equation).at(it.element.location())
          )$
        ]
      )
    }

    it
  }

  // Configure lists
  show enum: it => [
    #set enum(indent: 1.5em, body-indent: 0.5em)
    #set block(spacing: 2em)
    #it
  ]
  show list: it => [
    #set list(indent: 1.5em, body-indent: 0.5em)
    #set block(spacing: 2em)
    #it
  ]

  // Configure figures
  show figure: set block(spacing: 2em, above: 2em, below: 2em)

  // Configure Code
  show raw.where(block: true): it => locate(loc => {
    let cur-code-info = code-info-state.at(loc)
    let highlight-line = cur-code-info.highlight-line
    let codeblock-width = 95%

    set text(font: body-font)
    show figure: set block(breakable: true)
    set figure.caption(
      position: top,
      separator:
        if cur-code-info.caption == none { none }
        else { auto },
    )

    show raw.line: it => {
      let showHighlight = type(highlight-line) == int and highlight-line == it.number
      let line = [
        #if cur-code-info.show-line-numbers {
          it.number + cur-code-info.start-line - 1
        }
        #h(1em)
        #it
      ]
      if showHighlight {
        highlight(fill: aqua)[#line]
      } else {
        line
      }
    }

    let code-block = [
      #h(2em)
      #figure(
        kind: raw,
        caption:
          if cur-code-info.caption == none {
            if cur-code-info.label == none { none }
            else { "" }
          } else {
            cur-code-info.caption
          },
        supplement: "コード",
        numbering:
          if cur-code-info.label == none { none }
          else { "1" },
        gap: 1em,
        [
          #set align(left)
          #set par(leading: 0.85em)
          #set text(font: mono-font, size: 9pt)
          #set block(spacing: 1em, above: 1em, below: 1em)
          #line(length: codeblock-width)
          #block(
            inset: (
              left: 0.5em,
              right: 0.5em,
            ),
            breakable: true,
          )[
            #it
          ]
          #line(length: codeblock-width)
        ],
      ) #if cur-code-info.label != none {
        label(cur-code-info.label)
      }
      #h(2em)
    ]

    code-info-state.update(default-code-info)

    code-block
  })
  show raw.where(block: false): set text(size: 9pt)

  // Configure table
  show figure.where(kind: table): set figure.caption(position: top)

  // Configure bibliography
  show bibliography: set text(lang: "ja")

  // Display the title, author, and date.
  if title-type == "fullpage" {
    page(numbering: none)[
      #v(1fr)
      #title-component(
        title: title,
        author: author,
        date: date,
        font: title-font,
        gap: (48pt, 32pt),
      )
      #v(1fr)
    ]
    counter(page).update(1)
  } else if title-type == "inpage" {
    v(48pt)
    title-component(title: title, author: author, date: date, font: title-font)
    v(48pt)
  }

  // Display the paper's contents.
  body
}
