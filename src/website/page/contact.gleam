import lustre/attribute.{attribute}
import lustre/element/html
import website/component

const mail = "gabriele.genovese2@studio.unibo.it"

pub fn view() {
  component.text_page("Contact", "Contact me", [
    html.div([attribute.class("text-md")], [
      html.text("If you want to reach out to me, you can send an email at "),
      html.a(
        [attribute.class("text-orange-400"), attribute.href("mailto:" <> mail)],
        [html.text(mail)],
      ),
      html.text(" or a message to "),
      html.a(
        [
          attribute.class("text-blue-400"),
          attribute.href("https://matrix.to/#/@gabrigeno:cappuccino.ovh"),
        ],
        [html.text("matrix")],
      ),
      html.text("."),
    ]),
  ])
}
