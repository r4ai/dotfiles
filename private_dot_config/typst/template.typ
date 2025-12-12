// Convert a content to a string.
// @see https://github.com/typst/typst/issues/2196
#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
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
    #heading(level: 1, numbering: none, outlined: false)[
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
  let title_str = to-string(title)
  let author_str = to-string(author)
  set document(
    title: if title_str == none { "" } else { title_str },
    author: if author_str == none { "" } else { author_str },
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
  set block(spacing: 2em, above: 2em)
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
      return it // 停止性を保証する
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
      return link(elem.location(), [
        式 $#numbering(elem.numbering, ..counter(math.equation).at(it.element.location()))$
      ])
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

  // Configure table
  show figure.where(kind: table): set figure.caption(position: top)

  // Configure bibliography
  show bibliography: set text(lang: "ja")

  // Display the title, author, and date.
  if title-type == "fullpage" {
    page(numbering: none)[
      #v(1fr)
      #title-component(title: title, author: author, date: date, font: title-font, gap: (48pt, 32pt))
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

// @type: {[key in string]: {label: string, icon: image}}
#let default-callout-types = (
  note: (
    label: "Note",
    icon: image("assets/lucide/icons/info.svg"),
  ),
  warning: (
    label: "Warning",
    icon: image("assets/lucide/icons/octagon-alert.svg"),
  ),
  example: (
    label: "Example",
    icon: image("assets/lucide/icons/list.svg"),
  ),
  quote: (
    label: "Quote",
    icon: image("assets/lucide/icons/quote.svg"),
  ),
  rocket: (
    label: "Rocket",
    icon: image("assets/lucide/icons/rocket.svg"),
  ),
  todo: (
    label: "ToDo",
    icon: image("assets/lucide/icons/circle-check-big.svg"),
  ),
)

#let callouts = state("callouts", default-callout-types)

#let create-callout(key, (label, icon)) = {
  callouts.update(pre => {
    pre.insert(key, (label: label, icon: icon))
    pre
  })
}

// @args type: string e.g. "note"
// @args title: content e.g. "Note"
// @args body: content
#let callout(type, body, title: none) = locate(loc => {
  let callout-types = callouts.at(loc)
  let callout-type = if callout-types.keys().contains(type) {
    callout-types.at(type)
  } else {
    callout-types.at("note")
  }
  let callout-title = if title == none {
    callout-type.label
  } else {
    title
  }

  set image(
    height: 1em,
    width: 1em,
  )

  box(
    stroke: 1pt,
    inset: (left: 1em, right: 1em, top: 1.2em, bottom: 1.2em),
    width: 100%,
    radius: 0.75em,
  )[
    #box(inset: (bottom: 0.25em))[
      #stack(dir: ltr, spacing: 0.5em, callout-type.icon, text(1.05em)[
        #callout-title
      ])
    ] \
    #body
  ]
})
