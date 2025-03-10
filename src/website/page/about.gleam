import lustre/attribute.{attribute}
import lustre/element/html
import website/component

const propic_src = "./images/propic.jpg"

pub fn view() {
  component.text_page("About", "About me", [
    html.div([attribute.class("flex m-2")], [
      propic(),
      html.span([attribute.class("text-lg p-5")], [
        html.text(
          "I'm a Master's student in Computer Science at the University of Bologna.
           Passionate about programming languages and the theory behind computing.
           This site is self-hosted and created with Gleam.",
        ),
      ]),
    ]),
  ])
}

fn propic() {
  html.img([
    attribute.id("homepage-profile-picture"),
    attribute.class("mr-4 w-80 h-36 rounded-full object-cover"),
    attribute.alt(""),
    attribute.src(propic_src),
  ])
}
