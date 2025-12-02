import lustre/attribute
import lustre/element/html
import website/component

type Office {
  Office(city: String, state: String, address: String, office_number: String)
}

const office = Office(
  city: "06900 Sophia-Antipolis",
  state: "France",
  address: "Euclide B, 2000 Rte des Lucioles",
  office_number: "Office 306, Floor 3",
)

const mail = "gabriele.genovese@univ-cotedazur.fr"

const matrix = "https://matrix.to/#/@gabrigeno:cappuccino.ovh"

pub fn view() {
  component.text_page("Contact", "Contact me", [
    html.div([attribute.class("text-md space-y-6")], [
      render_email(),
      render_office(),
    ]),
  ])
}

fn render_email() {
  html.div([], [
    html.text("If you want to reach out to me, you can send an email ✉️ at "),
    html.a(
      [
        attribute.class("text-orange-400 hover:underline"),
        attribute.href("mailto:" <> mail),
      ],
      [html.text(mail)],
    ),
    html.text(" or a message 💬 at my Matrix "),
    html.a(
      [
        attribute.class("text-blue-400 hover:underline"),
        attribute.href(matrix),
      ],
      [html.text("contact")],
    ),
    html.text("."),
  ])
}

fn render_office() {
  html.div(
    [
      attribute.class(
        "border border-indigo-900 rounded-lg p-4 bg-[#0d0d17] shadow-md max-w-lg",
      ),
    ],
    [
      html.h3(
        [
          attribute.class(
            "text-lg font-semibold text-purple-300 border-b border-indigo-800 pb-1 mb-2",
          ),
        ],
        [html.text("🏢 Office Location")],
      ),
      html.p([attribute.class("text-gray-300")], [
        html.text("📍 " <> office.address),
      ]),
      html.p([attribute.class("text-gray-400")], [
        html.text("🌆 " <> office.city <> ", " <> office.state),
      ]),
      html.p([attribute.class("text-gray-400 italic mt-1")], [
        html.text("🔢 " <> office.office_number),
      ]),
    ],
  )
}
