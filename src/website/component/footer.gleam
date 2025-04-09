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
  Social(
    icon: "matrix.png",
    name: "Matrix",
    url: "https://matrix.to/#/@gabrigeno:cappuccino.ovh",
  ),
  Social(
    icon: "mail.png",
    name: "Mail",
    url: "mailto:gabriele.genovese2@studio.unibo.it",
  ),
  Social(
    icon: "linkedin.png",
    name: "Linkedin",
    url: "https://www.linkedin.com/in/gabriele-genovese-63702a226/",
  ),
]

pub fn view() -> Element(a) {
  html.footer(
    [
      attribute.class(
        "bg-gray-800 text-white p-2 max-w-6xl mx-auto flex flex-col items-center md:flex-row 
              md:justify-between relative text-center w-full",
      ),
    ],
    [
      html.div(
        [
          attribute.class(
            "p-2 flex space-x-4 md:mb-0 md:absolute md:left-0 md:top-1/2 
                md:-translate-y-1/2",
          ),
        ],
        list.map(socials, fn(social) {
          html.a(
            [
              attribute.href(social.url),
              attribute.target("_blank"),
              // attribute.class("shrink-0 mx-2 flex-none"),
            ],
            [
              html.img([
                attribute.src("./images/" <> social.icon),
                attribute.alt(social.name),
                attribute.title(social.name),
                attribute.class("h-6 w-6 rounded-full object-cover"),
              ]),
            ],
          )
        }),
      ),
      html.div([attribute.class("flex text-md w-full justify-center")], [
        html.text("© 2025 Gabriele Genovese"),
        html.text(""),
      ]),
    ],
  )
}
