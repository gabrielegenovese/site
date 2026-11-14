import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

type Social {
  Social(name: String, url: String)
}

const socials = [
  Social(
    name: "Scholar",
    url: "https://scholar.google.com/citations?user=e9En1Z8AAAAJ",
  ),
  Social(name: "GitHub", url: "https://github.com/gabrielegenovese"),
  Social(name: "Matrix", url: "https://matrix.to/#/@gabrigeno:cappuccino.ovh"),
  Social(name: "Email", url: "mailto:gabrigeno@gmail.com"),
  Social(
    name: "LinkedIn",
    url: "https://www.linkedin.com/in/gabriele-genovese-63702a226/",
  ),
]

pub fn view() -> Element(a) {
  html.footer([attribute.class("site-footer")], [
    html.div([attribute.class("footer-inner")], [
      html.nav(
        [
          attribute.class("social-list"),
          attribute.attribute("aria-label", "Social links"),
        ],
        list.map(socials, fn(social) {
          html.a(
            [
              attribute.class("footer-link"),
              attribute.href(social.url),
              attribute.target("_blank"),
              attribute.rel("noopener noreferrer"),
            ],
            [html.text(social.name)],
          )
        }),
      ),
      html.p([attribute.class("footer-copy")], [
        html.text("© 2026 Gabriele Genovese"),
      ]),
      html.a(
        [
          attribute.class("footer-badge"),
          attribute.href("https://tcs4f.org"),
          attribute.target("_blank"),
          attribute.rel("noopener noreferrer"),
          attribute.title("Theoretical Computer Scientists for Future"),
        ],
        [
          html.img([
            attribute.class("footer-badge-logo footer-badge-logo--light"),
            attribute.src("./images/tcs4f.svg"),
            attribute.alt("Theoretical Computer Scientists for Future"),
          ]),
          html.img([
            attribute.class("footer-badge-logo footer-badge-logo--dark"),
            attribute.src("./images/tcs4f-white.svg"),
            attribute.alt("Theoretical Computer Scientists for Future"),
          ]),
        ],
      ),
    ]),
  ])
}
