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

// @type: {[key in string]: {label: string, icon: image}}
#let default-callout-types = (
  note: (
    label: "Note",
    icon: image.decode("<svg width=\"15\" height=\"15\" viewBox=\"0 0 15 15\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M7.49991 0.876892C3.84222 0.876892 0.877075 3.84204 0.877075 7.49972C0.877075 11.1574 3.84222 14.1226 7.49991 14.1226C11.1576 14.1226 14.1227 11.1574 14.1227 7.49972C14.1227 3.84204 11.1576 0.876892 7.49991 0.876892ZM1.82707 7.49972C1.82707 4.36671 4.36689 1.82689 7.49991 1.82689C10.6329 1.82689 13.1727 4.36671 13.1727 7.49972C13.1727 10.6327 10.6329 13.1726 7.49991 13.1726C4.36689 13.1726 1.82707 10.6327 1.82707 7.49972ZM8.24992 4.49999C8.24992 4.9142 7.91413 5.24999 7.49992 5.24999C7.08571 5.24999 6.74992 4.9142 6.74992 4.49999C6.74992 4.08577 7.08571 3.74999 7.49992 3.74999C7.91413 3.74999 8.24992 4.08577 8.24992 4.49999ZM6.00003 5.99999H6.50003H7.50003C7.77618 5.99999 8.00003 6.22384 8.00003 6.49999V9.99999H8.50003H9.00003V11H8.50003H7.50003H6.50003H6.00003V9.99999H6.50003H7.00003V6.99999H6.50003H6.00003V5.99999Z\" fill=\"currentColor\" fill-rule=\"evenodd\" clip-rule=\"evenodd\"></path></svg>")
  ),
  warning: (
    label: "Warning",
    icon: image.decode("<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"lucide lucide-alert-octagon\"><polygon points=\"7.86 2 16.14 2 22 7.86 22 16.14 16.14 22 7.86 22 2 16.14 2 7.86 7.86 2\"/><line x1=\"12\" x2=\"12\" y1=\"8\" y2=\"12\"/><line x1=\"12\" x2=\"12.01\" y1=\"16\" y2=\"16\"/></svg>")
  ),
  example: (
    label: "Example",
    icon: image.decode("<svg width=\"15\" height=\"15\" viewBox=\"0 0 15 15\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M1.5 5.25C1.91421 5.25 2.25 4.91421 2.25 4.5C2.25 4.08579 1.91421 3.75 1.5 3.75C1.08579 3.75 0.75 4.08579 0.75 4.5C0.75 4.91421 1.08579 5.25 1.5 5.25ZM4 4.5C4 4.22386 4.22386 4 4.5 4H13.5C13.7761 4 14 4.22386 14 4.5C14 4.77614 13.7761 5 13.5 5H4.5C4.22386 5 4 4.77614 4 4.5ZM4.5 7C4.22386 7 4 7.22386 4 7.5C4 7.77614 4.22386 8 4.5 8H13.5C13.7761 8 14 7.77614 14 7.5C14 7.22386 13.7761 7 13.5 7H4.5ZM4.5 10C4.22386 10 4 10.2239 4 10.5C4 10.7761 4.22386 11 4.5 11H13.5C13.7761 11 14 10.7761 14 10.5C14 10.2239 13.7761 10 13.5 10H4.5ZM2.25 7.5C2.25 7.91421 1.91421 8.25 1.5 8.25C1.08579 8.25 0.75 7.91421 0.75 7.5C0.75 7.08579 1.08579 6.75 1.5 6.75C1.91421 6.75 2.25 7.08579 2.25 7.5ZM1.5 11.25C1.91421 11.25 2.25 10.9142 2.25 10.5C2.25 10.0858 1.91421 9.75 1.5 9.75C1.08579 9.75 0.75 10.0858 0.75 10.5C0.75 10.9142 1.08579 11.25 1.5 11.25Z\" fill=\"currentColor\" fill-rule=\"evenodd\" clip-rule=\"evenodd\"></path></svg>")
  ),
  quote: (
    label: "Quote",
    icon: image.decode("<svg width=\"15\" height=\"15\" viewBox=\"0 0 15 15\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M9.42503 3.44136C10.0561 3.23654 10.7837 3.2402 11.3792 3.54623C12.7532 4.25224 13.3477 6.07191 12.7946 8C12.5465 8.8649 12.1102 9.70472 11.1861 10.5524C10.262 11.4 8.98034 11.9 8.38571 11.9C8.17269 11.9 8 11.7321 8 11.525C8 11.3179 8.17644 11.15 8.38571 11.15C9.06497 11.15 9.67189 10.7804 10.3906 10.236C10.9406 9.8193 11.3701 9.28633 11.608 8.82191C12.0628 7.93367 12.0782 6.68174 11.3433 6.34901C10.9904 6.73455 10.5295 6.95946 9.97725 6.95946C8.7773 6.95946 8.0701 5.99412 8.10051 5.12009C8.12957 4.28474 8.66032 3.68954 9.42503 3.44136ZM3.42503 3.44136C4.05614 3.23654 4.78366 3.2402 5.37923 3.54623C6.7532 4.25224 7.34766 6.07191 6.79462 8C6.54654 8.8649 6.11019 9.70472 5.1861 10.5524C4.26201 11.4 2.98034 11.9 2.38571 11.9C2.17269 11.9 2 11.7321 2 11.525C2 11.3179 2.17644 11.15 2.38571 11.15C3.06497 11.15 3.67189 10.7804 4.39058 10.236C4.94065 9.8193 5.37014 9.28633 5.60797 8.82191C6.06282 7.93367 6.07821 6.68174 5.3433 6.34901C4.99037 6.73455 4.52948 6.95946 3.97725 6.95946C2.7773 6.95946 2.0701 5.99412 2.10051 5.12009C2.12957 4.28474 2.66032 3.68954 3.42503 3.44136Z\" fill=\"currentColor\" fill-rule=\"evenodd\" clip-rule=\"evenodd\"></path></svg>")
  ),
  rocket: (
    label: "Rocket",
    icon: image.decode("<svg width=\"15\" height=\"15\" viewBox=\"0 0 15 15\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M6.85357 3.85355L7.65355 3.05353C8.2981 2.40901 9.42858 1.96172 10.552 1.80125C11.1056 1.72217 11.6291 1.71725 12.0564 1.78124C12.4987 1.84748 12.7698 1.97696 12.8965 2.10357C13.0231 2.23018 13.1526 2.50125 13.2188 2.94357C13.2828 3.37086 13.2779 3.89439 13.1988 4.44801C13.0383 5.57139 12.591 6.70188 11.9464 7.34645L7.49999 11.7929L6.35354 10.6465C6.15827 10.4512 5.84169 10.4512 5.64643 10.6465C5.45117 10.8417 5.45117 11.1583 5.64643 11.3536L7.14644 12.8536C7.34171 13.0488 7.65829 13.0488 7.85355 12.8536L8.40073 12.3064L9.57124 14.2572C9.65046 14.3893 9.78608 14.4774 9.9389 14.4963C10.0917 14.5151 10.2447 14.4624 10.3535 14.3536L12.3535 12.3536C12.4648 12.2423 12.5172 12.0851 12.495 11.9293L12.0303 8.67679L12.6536 8.05355C13.509 7.19808 14.0117 5.82855 14.1887 4.58943C14.2784 3.9618 14.2891 3.33847 14.2078 2.79546C14.1287 2.26748 13.9519 1.74482 13.6035 1.39645C13.2552 1.04809 12.7325 0.871332 12.2045 0.792264C11.6615 0.710945 11.0382 0.721644 10.4105 0.8113C9.17143 0.988306 7.80189 1.491 6.94644 2.34642L6.32322 2.96968L3.07071 2.50504C2.91492 2.48278 2.75773 2.53517 2.64645 2.64646L0.646451 4.64645C0.537579 4.75533 0.484938 4.90829 0.50375 5.0611C0.522563 5.21391 0.61073 5.34954 0.742757 5.42876L2.69364 6.59928L2.14646 7.14645C2.0527 7.24022 2.00002 7.3674 2.00002 7.50001C2.00002 7.63261 2.0527 7.75979 2.14646 7.85356L3.64647 9.35356C3.84173 9.54883 4.15831 9.54883 4.35357 9.35356C4.54884 9.1583 4.54884 8.84172 4.35357 8.64646L3.20712 7.50001L3.85357 6.85356L6.85357 3.85355ZM10.0993 13.1936L9.12959 11.5775L11.1464 9.56067L11.4697 11.8232L10.0993 13.1936ZM3.42251 5.87041L5.43935 3.85356L3.17678 3.53034L1.80638 4.90074L3.42251 5.87041ZM2.35356 10.3535C2.54882 10.1583 2.54882 9.8417 2.35356 9.64644C2.1583 9.45118 1.84171 9.45118 1.64645 9.64644L0.646451 10.6464C0.451188 10.8417 0.451188 11.1583 0.646451 11.3535C0.841713 11.5488 1.1583 11.5488 1.35356 11.3535L2.35356 10.3535ZM3.85358 11.8536C4.04884 11.6583 4.04885 11.3417 3.85359 11.1465C3.65833 10.9512 3.34175 10.9512 3.14648 11.1465L1.14645 13.1464C0.95119 13.3417 0.951187 13.6583 1.14645 13.8535C1.34171 14.0488 1.65829 14.0488 1.85355 13.8536L3.85358 11.8536ZM5.35356 13.3535C5.54882 13.1583 5.54882 12.8417 5.35356 12.6464C5.1583 12.4512 4.84171 12.4512 4.64645 12.6464L3.64645 13.6464C3.45119 13.8417 3.45119 14.1583 3.64645 14.3535C3.84171 14.5488 4.1583 14.5488 4.35356 14.3535L5.35356 13.3535ZM9.49997 6.74881C10.1897 6.74881 10.7488 6.1897 10.7488 5.5C10.7488 4.8103 10.1897 4.25118 9.49997 4.25118C8.81026 4.25118 8.25115 4.8103 8.25115 5.5C8.25115 6.1897 8.81026 6.74881 9.49997 6.74881Z\" fill=\"currentColor\" fill-rule=\"evenodd\" clip-rule=\"evenodd\"></path></svg>")
  ),
  todo: (
    label: "ToDo",
    icon: image.decode("<svg width=\"15\" height=\"15\" viewBox=\"0 0 15 15\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M7.49991 0.877045C3.84222 0.877045 0.877075 3.84219 0.877075 7.49988C0.877075 11.1575 3.84222 14.1227 7.49991 14.1227C11.1576 14.1227 14.1227 11.1575 14.1227 7.49988C14.1227 3.84219 11.1576 0.877045 7.49991 0.877045ZM1.82708 7.49988C1.82708 4.36686 4.36689 1.82704 7.49991 1.82704C10.6329 1.82704 13.1727 4.36686 13.1727 7.49988C13.1727 10.6329 10.6329 13.1727 7.49991 13.1727C4.36689 13.1727 1.82708 10.6329 1.82708 7.49988ZM10.1589 5.53774C10.3178 5.31191 10.2636 5.00001 10.0378 4.84109C9.81194 4.68217 9.50004 4.73642 9.34112 4.96225L6.51977 8.97154L5.35681 7.78706C5.16334 7.59002 4.84677 7.58711 4.64973 7.78058C4.45268 7.97404 4.44978 8.29061 4.64325 8.48765L6.22658 10.1003C6.33054 10.2062 6.47617 10.2604 6.62407 10.2483C6.77197 10.2363 6.90686 10.1591 6.99226 10.0377L10.1589 5.53774Z\" fill=\"currentColor\" fill-rule=\"evenodd\" clip-rule=\"evenodd\"></path></svg>")
  )
)

#let callouts = state("callouts", default-callout-types)

#let create-callout(key, (label, icon)) = {
  callouts.update((pre) => {
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
    width: 1em
  )

  box(
    stroke: 1pt,
    inset: (left: 1em, right: 1em, top: 1.2em, bottom: 1.2em),
    width: 100%,
    radius: 0.75em
  )[
    #box(inset: (bottom: 0.25em))[
      #stack(
        dir: ltr,
        spacing: 0.5em,
        callout-type.icon,
        text(1.05em)[
          #callout-title
        ]
      )
    ] \
    #body
  ]
})
