import lustre/attribute.{attribute}
import lustre/element/html
import website/component

const mail = "gabriele.genovese2@studio.unibo.it"

pub fn view() {
  component.text_page("Contact", "Contact me", [
    html.text("If you want to reach out to me, you can send me an email at "),
    html.a(
      [attribute.class("text-orange-400"), attribute.href("mailto:" <> mail)],
      [html.text(mail)],
    ),
    html.text("."),
  ])
}
