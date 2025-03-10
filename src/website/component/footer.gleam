import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

type Social {
  Social(icon: String, name: String, url: String)
}

const socials = [
  Social(
    icon: "github.png",
    name: "Github",
    url: "https://github.com/gabrielegenovese",
  ),
]

pub fn view() -> Element(a) {
  html.footer(
    [attribute.class("bg-gray-800 text-white p-2 flex flex-row")],
    list.map(socials, fn(social) {
      html.a(
        [
          attribute.href(social.url),
          attribute.target("_blank"),
          attribute.class("shrink-0 mx-2 flex-none"),
        ],
        [
          html.img([
            attribute.src("./images/" <> social.icon),
            attribute.alt(social.name),
            attribute.title(social.name),
            attribute.class("w-6"),
          ]),
        ],
      )
    })
      |> list.append([
        html.div([attribute.class("w-64 text-center flex-auto")], [
          html.text("© 2025 Gabriele Genovese"),
          html.text(""),
        ]),
      ]),
  )
}
