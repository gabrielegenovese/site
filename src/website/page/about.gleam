import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/regexp as re
import gleam/result
import lustre/attribute
import lustre/element/html
import simplifile
import website/component

const propic_src = "./images/propic.jpg"

pub fn view() {
  component.text_page("About", "About me", [
    html.div([attribute.class("flex flex-col")], [
      html.div(
        [
          attribute.class(
            "max-w-4xl mx-auto flex flex-col md:text-xl sm:text-xl md:flex-row items-center text-center md:text-left",
          ),
        ],
        [
          propic(),
          html.span([attribute.class("text-lg p-3")], [
            html.text(
              "I'm a PhD Student in Computer Science at the Université Côte d'Azur💻.
             My PhD topic is about \"Failure Handling in Multiparty Session Types\".
             Passionate about programming languages and the theory behind distributed computing.
             This site is self-hosted🌐 and created with Gleam💫.",
            ),
          ]),
        ],
      ),
      html.div([attribute.class("flex flex-col")], pubblications()),
    ]),
  ])
}

fn propic() {
  html.img([
    attribute.id("homepage-profile-picture"),
    attribute.class(
      "w-48 aspect-square object-cover rounded-full p-1 m-2 md:mb-0 md:mr-4",
    ),
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

      html.div(
        [
          attribute.attribute(
            "style",
            "
              font-family: 'Inter', sans-serif;
              padding: 2rem 1rem;
              color: #e5e7eb;
            ",
          ),
        ],
        [
          html.h3(
            [
              attribute.attribute(
                "style",
                "
                  font-weight: 700;
                  font-size: 1.4rem;
                  margin-bottom: 1rem;
                  color: #f5f5f5;
                  border-bottom: 2px solid #3b0a7a;
                  display: inline-block;
                  padding-bottom: 0.25rem;
                ",
              ),
            ],
            [html.text(title)],
          ),
          ..elements
        ],
      )
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
  let author = find_field(entry, "author")
  let year = find_field(entry, "year")
  let conferance = find_field(entry, "conference")
  let pdf = find_field(entry, "pdf")
  let slides = find_field(entry, "slides")
  let poster = find_field(entry, "poster")

  html.div(
    [
      attribute.attribute(
        "style",
        "
          border: 1px solid #3b0a7a;
          border-radius: 14px;
          padding: 1.25rem;
          margin: 1rem 0;
          background: linear-gradient(180deg, #0d0d17 0%, #111122 100%);
          box-shadow: 0 4px 10px rgba(0,0,0,0.25);
          transition: transform 0.2s ease, box-shadow 0.2s ease;
        ",
      ),
      attribute.attribute(
        "onmouseover",
        "this.style.transform='translateY(-3px)'; this.style.boxShadow='0 6px 14px rgba(0,0,0,0.4)';",
      ),
      attribute.attribute(
        "onmouseout",
        "this.style.transform=''; this.style.boxShadow='0 4px 10px rgba(0,0,0,0.25)';",
      ),
    ],
    [
      html.h4(
        [
          attribute.attribute(
            "style",
            "
              font-weight: 700;
              font-size: 1.05rem;
              margin-bottom: 0.6rem;
              color: #f0eaff;
            ",
          ),
        ],
        [html.text(title)],
      ),
      html.p(
        [attribute.attribute("style", "margin: 0.3rem 0; color: #d1d5db;")],
        [html.text("Authors: " <> author)],
      ),
      html.p(
        [attribute.attribute("style", "margin: 0.3rem 0; color: #9ca3af;")],
        [html.text("Year: " <> year)],
      ),
      case conferance {
        "" -> html.text("")
        _ ->
          html.p(
            [attribute.attribute("style", "margin: 0.3rem 0; color: #a78bfa;")],
            [html.text("Conference: " <> conferance)],
          )
      },
      // --- Optional section for PDF, Slides, Poster as colored text links ---
      html.div(
        [
          attribute.attribute(
            "style",
            "
              display: flex;
              gap: 0.8rem;
              margin-top: 0.6rem;
              flex-wrap: wrap;
              font-weight: 600;
              font-size: 0.95rem;
            ",
          ),
        ],
        [
          case pdf {
            "" -> html.text("")
            _ ->
              html.a(
                [
                  attribute.href(pdf),
                  attribute.target("_blank"),
                  attribute.attribute(
                    "style",
                    "
                      color: #facc15;
                      text-decoration: none;
                    ",
                  ),
                  attribute.attribute(
                    "onmouseover",
                    "this.style.textDecoration='underline';",
                  ),
                  attribute.attribute(
                    "onmouseout",
                    "this.style.textDecoration='none';",
                  ),
                ],
                [html.text("PDF")],
              )
          },
          case slides {
            "" -> html.text("")
            _ ->
              html.a(
                [
                  attribute.href(slides),
                  attribute.target("_blank"),
                  attribute.attribute(
                    "style",
                    "
                      color: #60a5fa;
                      text-decoration: none;
                    ",
                  ),
                  attribute.attribute(
                    "onmouseover",
                    "this.style.textDecoration='underline';",
                  ),
                  attribute.attribute(
                    "onmouseout",
                    "this.style.textDecoration='none';",
                  ),
                ],
                [html.text("Slides")],
              )
          },
          case poster {
            "" -> html.text("")
            _ ->
              html.a(
                [
                  attribute.href(poster),
                  attribute.target("_blank"),
                  attribute.attribute(
                    "style",
                    "
                      color: #f87171;
                      text-decoration: none;
                    ",
                  ),
                  attribute.attribute(
                    "onmouseover",
                    "this.style.textDecoration='underline';",
                  ),
                  attribute.attribute(
                    "onmouseout",
                    "this.style.textDecoration='none';",
                  ),
                ],
                [html.text("Poster")],
              )
          },
        ],
      ),
    ],
  )
}
