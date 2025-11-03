import lustre/attribute.{attribute}
import lustre/element/html
import website/component

const propic_src = "./images/propic.jpg"

pub fn view() {
  component.text_page("About", "About me", [
    html.div(
      [
        attribute.class(
          "max-w-4xl mx-auto flex flex-col md:text-xl sm:text-xl md:flex-row items-center text-center md:text-left",
        ),
      ],
      [
        propic(),
        html.span([attribute.class("text-lg p-3")], [
          html.text(
            "I'm a PhD Student in Computer Science at the Université Côte d'Azur💻.
             My PhD topic is about \"Failure Handling in Multiparty Session Types\".
             Passionate about programming languages and the theory behind distributed computing.
             This site is self-hosted🌐 and created with Gleam💫.",
          ),
        ]),
      ],
    ),
  ])
}

fn propic() {
  html.img([
    attribute.id("homepage-profile-picture"),
    attribute.class(
      "w-48 aspect-square object-cover rounded-full p-1 m-2 md:mb-0 md:mr-4",
    ),
    attribute.alt("me"),
    attribute.src(propic_src),
  ])
}
