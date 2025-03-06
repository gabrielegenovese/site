import lustre/attribute.{attribute}
import lustre/element/html
import website/component

pub fn view() {
  component.text_page("About", "About me", [
    html.span([attribute.class("text-2xl font-bold")], [
      html.text("I'm Gabriele Genovese."),
    ]),
  ])
}
