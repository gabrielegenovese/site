import lustre/attribute
import lustre/element/html
import website/component

type Office {
  Office(city: String, state: String, address: String, office_number: String)
}

const office_sophia =
  Office(
    city: "06900 Sophia-Antipolis",
    state: "France",
    address: "Euclide B, 2000 Rte des Lucioles",
    office_number: "Office 306, Floor 3",
  )

const office_bolo =
  Office(
    city: "40127 Bologna",
    state: "Italy",
    address: "Via Camillo Ranzani, 14/A",
    office_number: "Unnamed Office",
  )

const mail = "gabrigeno@gmail.com"

const matrix = "https://matrix.to/#/@gabrigeno:cappuccino.ovh"

pub fn view() {
  component.text_page("Contact", "Contact me", [
    html.p([attribute.class("contact-lead")], [
      html.text("You can reach me by email at "),
      html.a(
        [
          attribute.class("inline-link"),
          attribute.href("mailto:" <> mail),
        ],
        [html.text(mail)],
      ),
      html.text(" or on Matrix at "),
      html.a(
        [
          attribute.class("inline-link"),
          attribute.href(matrix),
          attribute.target("_blank"),
          attribute.rel("noopener noreferrer"),
        ],
        [html.text("gabrigeno:cappuccino.ovh")],
      ),
      html.text("."),
    ]),
    html.div([attribute.class("contact-grid")], [
      render_office(office_sophia),
      render_office(office_bolo),
    ]),
  ])
}

fn render_office(office: Office) {
  html.article([attribute.class("info-card")], [
    html.h2([attribute.class("info-card__title")], [
      html.text(office.city <> ", " <> office.state),
    ]),
    html.p([attribute.class("info-card__line")], [
      html.text(office.address),
    ]),
    html.p([attribute.class("info-card__line info-card__line--small")], [
      html.text(office.office_number),
    ]),
  ])
}
