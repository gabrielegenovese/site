import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/regexp as re
import gleam/result
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import simplifile
import website/component

const propic_src = "./images/propic.jpg"

pub fn view() {
  component.page("About", [
    html.div([attribute.class("page-shell page-top")], [
      html.div([attribute.class("page-content prose-site")], [
        html.div([attribute.class("about-grid")], [
          propic(),
          html.div([attribute.class("about-copy")], [
            html.p([], [
              html.text(
                "I'm a PhD student in Computer Science at the Université Côte d'Azur.",
              ),
            ]),
            html.p([], [
              html.text(
                "My PhD topic is about \"Failure Handling in Multiparty Session Types\".",
              ),
            ]),
            html.p([], [
              html.text(
                "I'm passionate about programming languages and the theory behind distributed computing. This site is self-hosted and created with Gleam.",
              ),
            ]),
          ]),
        ]),
        html.div([], list.append(pubblications(), [schools()])),
      ]),
    ]),
  ])
}

type School {
  School(year: String, name: String, place: String, url: String)
}

const school_entries = [
  School(
    "2024",
    "Lipari Summer School on Abstract Interpretation",
    "Lipari, Italy",
    "https://absint24.liparischool.it/",
  ),
  School(
    "2025",
    "Scottish Programming Languages and Verification Summer School (SPLV)",
    "Edinburgh, Scotland",
    "https://spli.scot/splv/2025-edinburgh",
  ),
  School(
    "2026",
    "Dutch Winter School on Logic and Verification",
    "University of Twente, The Netherlands",
    "https://cyclic-structures.gitlab.io/school2026",
  ),
  School(
    "2026",
    "ICTAC Postgraduate School on Formal Methods for Building Mission-Critical Systems",
    "Bariloche, Argentina",
    "https://ictac2026.github.io/school",
  ),
]

fn schools() {
  html.section([attribute.class("content-section content-section--compact")], [
    html.h2([attribute.class("section-title")], [html.text("Schools")]),
    html.ul(
      [attribute.class("school-list")],
      list.map(school_entries, render_school),
    ),
  ])
}

fn render_school(school: School) -> Element(a) {
  let name = case school.url {
    "" -> html.span([attribute.class("school-name")], [html.text(school.name)])
    url ->
      html.a(
        [
          attribute.class("school-name"),
          attribute.href(url),
          attribute.target("_blank"),
          attribute.rel("noopener noreferrer"),
        ],
        [html.text(school.name)],
      )
  }

  html.li([attribute.class("school-entry")], [
    html.span([attribute.class("school-year")], [html.text(school.year)]),
    html.span([attribute.class("school-body")], [
      name,
      html.span([attribute.class("school-place")], [html.text(school.place)]),
    ]),
  ])
}

fn propic() {
  html.img([
    attribute.id("homepage-profile-picture"),
    attribute.class("profile-pic"),
    attribute.alt("me"),
    attribute.src(propic_src),
  ])
}

fn pubblications() {
  [
    parse_and_create("Papers", "./static/pubs.bib"),
    parse_and_create("Thesis", "./static/tesi.bib"),
  ]
}

type BibEntry {
  BibEntry(
    entry_type: String,
    citation_key: String,
    fields: List(#(String, String)),
  )
}

fn parse_and_create(title: String, filepath: String) {
  let content_maybe = simplifile.read(from: filepath)
  case content_maybe {
    Ok(content) -> {
      let entries = parse_bibtex(content)
      let elements = entries |> list.map(render_entry)

      html.section([attribute.class("content-section")], [
        html.h2([attribute.class("section-title")], [html.text(title)]),
        ..elements
      ])
    }
    Error(_) -> {
      io.println("Didn't find " <> filepath)
      html.div([], [])
    }
  }
}

fn parse_bibtex(content: String) {
  let assert Ok(entry) =
    re.from_string("@([a-zA-Z]+)\\s*\\{\\s*([^,]+)\\s*,([\\s\\S]*?)\\n\\s*\\}")

  let assert Ok(field) =
    re.from_string(
      "([a-zA-Z_]+)\\s*=\\s*(?:\\{((?:[^{}]|\\{[^{}]*\\})*)\\}|\"((?:\\\\\"|[^\"])*\")|([^,\\n]+))\\s*,?",
    )

  re.scan(with: entry, content:)
  |> list.map(fn(entry_match) {
    let sub = entry_match.submatches
    case sub {
      [Some(entry_type), Some(citation_key), Some(fields_block)] -> {
        let fields =
          re.scan(field, fields_block)
          |> list.filter_map(fn(field_match) {
            case field_match.submatches {
              [Some(name), Some(value)] -> Ok(#(name, value))
              _ -> Error(#("", ""))
            }
          })
        BibEntry(entry_type, citation_key, fields)
      }

      _ -> BibEntry("", "", [])
    }
  })
}

fn find_field(entry: BibEntry, filter: String) -> String {
  list.find(entry.fields, fn(elem) {
    let #(key, _) = elem
    key == filter
  })
  |> result.map(fn(elem) {
    let #(_, v) = elem
    v
  })
  |> result.unwrap("")
}

fn render_entry(entry: BibEntry) {
  let title = find_field(entry, "title")
  let coauthors = find_field(entry, "coauthors")
  let year = find_field(entry, "year")
  let conferance = find_field(entry, "conference")
  let venue_url = find_field(entry, "venue_url")
  let pdf = find_field(entry, "pdf")
  let slides = find_field(entry, "slides")
  let poster = find_field(entry, "poster")
  let website = find_field(entry, "website")
  let website_label = case find_field(entry, "website_label") {
    "" -> "Website"
    label -> label
  }

  html.article([attribute.class("bib-entry")], [
    html.h3([attribute.class("bib-title")], [html.text(title)]),
    html.dl([attribute.class("bib-meta")], [
      case coauthors {
        "" -> html.text("")
        _ -> meta_row("Coauthors", coauthors)
      },
      case year {
        "" -> html.text("")
        _ -> meta_row("Year", year)
      },
      case conferance {
        "" -> html.text("")
        _ -> venue_row("Venue", conferance, venue_url)
      },
    ]),
    html.div([attribute.class("bib-links")], [
      resource_link(pdf, "PDF"),
      resource_link(slides, "Slides"),
      resource_link(poster, "Poster"),
      resource_link(website, website_label),
    ]),
  ])
}

fn meta_row(label: String, value: String) -> Element(a) {
  html.div([attribute.class("bib-meta-row")], [
    html.dt([], [html.text(label)]),
    html.dd([], [html.text(value)]),
  ])
}

fn venue_row(label: String, value: String, url: String) -> Element(a) {
  let venue = case url {
    "" -> html.text(value)
    _ ->
      html.a(
        [
          attribute.class("venue-link"),
          attribute.href(url),
          attribute.target("_blank"),
          attribute.rel("noopener noreferrer"),
        ],
        [html.text(value)],
      )
  }

  html.div([attribute.class("bib-meta-row bib-meta-row--venue")], [
    html.dt([], [html.text(label)]),
    html.dd([], [venue]),
  ])
}

fn resource_link(href: String, label: String) -> Element(a) {
  case href {
    "" -> html.text("")
    _ ->
      html.a(
        [
          attribute.class("pill-link"),
          attribute.href(href),
          attribute.target("_blank"),
          attribute.rel("noopener noreferrer"),
        ],
        [html.text(label)],
      )
  }
}
