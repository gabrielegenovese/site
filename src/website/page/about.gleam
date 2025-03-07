import lustre/attribute.{attribute}
import lustre/element/html
import website/component

const propic_src = "./propic.jpg"

pub fn view() {
  component.text_page("About", "About me", [
    html.div([attribute.class("flex m-2")], [
      propic(),
      html.span([attribute.class("text-2xl font-bold")], [
        html.text("I'm Gabriele Genovese."),
      ]),
    ]),
  ])
}

fn propic() {
  html.img([
    attribute.id("homepage-profile-picture"),
    attribute.class("m-2 w-80 h-80 rounded-full object-cover"),
    attribute.alt(""),
    attribute.src(propic_src),
  ])
}
