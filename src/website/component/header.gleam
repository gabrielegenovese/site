import gleam/list
import lustre/attribute.{attribute}
import lustre/element.{type Element, text}
import lustre/element/html

// import lustre/element/svg

type PageRoute {
  PageRoute(name: String, url: String)
}

// const pages = [PageRoute("About", "./about.html"), PageRoute("Contact", "./contact.html")]
const pages = [PageRoute("Contact", "./contact.html")]

pub fn view(page: String) -> Element(a) {
  html.header([attribute.class("bg-blue-700 flex w-full select-none fixed")], [
    html.nav(
      [
        attribute.class(
          "flex h-16 grow items-center justify-between gap-4 px-4 text-white",
        ),
      ],
      [
        html.a([attribute.class("heading"), attribute.href("./")], [
          text("Home"),
        ]),
        nav_bar(page),
      ],
    ),
  ])
}

fn nav_bar(current_page: String) -> Element(a) {
  html.ul(
    [attribute.class("flex")],
    list.map(pages, fn(page) {
      let default_style = "text-xl font-bold p-2 flex-center"
      let element = case page.name == current_page {
        True ->
          html.span(
            [
              attribute.class(
                default_style
                <> " cursor-default text-gray-400 text-xs lg:text-xl",
              ),
            ],
            [element.text(page.name)],
          )
        False ->
          html.a(
            [
              attribute.class(
                default_style
                <> " text-white-300 ease-linear text-xs lg:text-xl",
              ),
              attribute.href(page.url),
            ],
            [element.text(page.name)],
          )
      }
      html.li([], [element])
    }),
  )
}
