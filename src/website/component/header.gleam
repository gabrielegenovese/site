import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/element/svg

type PageRoute {
  PageRoute(name: String, url: String)
}

const pages = [
  PageRoute("Contact", "./contact.html"),
  PageRoute("Teaching", "./teaching.html"),
  PageRoute("CV", "/cv.pdf"),
]

pub fn view(page: String) -> Element(a) {
  html.header([attribute.class("site-header")], [
    html.nav([attribute.class("site-nav")], [
      html.a([attribute.class("brand"), attribute.href("./")], [
        html.text("Gabriele Genovese"),
      ]),
      nav_bar(page),
    ]),
  ])
}

fn nav_bar(current_page: String) -> Element(a) {
  let page_items =
    list.map(pages, fn(page) {
      let element = case page.name == current_page {
        True ->
          html.span(
            [
              attribute.class("nav-link is-active"),
              attribute.attribute("aria-current", "page"),
            ],
            [html.text(page.name)],
          )
        False ->
          html.a([attribute.class("nav-link"), attribute.href(page.url)], [
            html.text(page.name),
          ])
      }
      html.li([], [element])
    })

  html.ul(
    [attribute.class("nav-list")],
    list.append(page_items, [theme_toggle()]),
  )
}

fn theme_toggle() -> Element(a) {
  html.li([], [
    html.button(
      [
        attribute.class("theme-toggle"),
        attribute.type_("button"),
        attribute.attribute("aria-label", "Switch to dark theme"),
        attribute.title("Switch to dark theme"),
      ],
      [sun_icon(), moon_icon()],
    ),
  ])
}

fn sun_icon() -> Element(a) {
  svg.svg(
    [
      attribute.class("theme-icon theme-icon--sun"),
      attribute.attribute("viewBox", "0 0 24 24"),
      attribute.attribute("fill", "none"),
      attribute.attribute("stroke", "currentColor"),
      attribute.attribute("stroke-width", "1.5"),
      attribute.attribute("stroke-linecap", "round"),
      attribute.attribute("stroke-linejoin", "round"),
      attribute.attribute("aria-hidden", "true"),
    ],
    [
      svg.circle([
        attribute.attribute("cx", "12"),
        attribute.attribute("cy", "12"),
        attribute.attribute("r", "4"),
      ]),
      svg.path([attribute.attribute("d", "M12 2v2")]),
      svg.path([attribute.attribute("d", "M12 20v2")]),
      svg.path([attribute.attribute("d", "m4.93 4.93 1.41 1.41")]),
      svg.path([attribute.attribute("d", "m17.66 17.66 1.41 1.41")]),
      svg.path([attribute.attribute("d", "M2 12h2")]),
      svg.path([attribute.attribute("d", "M20 12h2")]),
      svg.path([attribute.attribute("d", "m6.34 17.66-1.41 1.41")]),
      svg.path([attribute.attribute("d", "m19.07 4.93-1.41 1.41")]),
    ],
  )
}

fn moon_icon() -> Element(a) {
  svg.svg(
    [
      attribute.class("theme-icon theme-icon--moon"),
      attribute.attribute("viewBox", "0 0 24 24"),
      attribute.attribute("fill", "none"),
      attribute.attribute("stroke", "currentColor"),
      attribute.attribute("stroke-width", "1.5"),
      attribute.attribute("stroke-linecap", "round"),
      attribute.attribute("stroke-linejoin", "round"),
      attribute.attribute("aria-hidden", "true"),
    ],
    [svg.path([attribute.attribute("d", "M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z")])],
  )
}
