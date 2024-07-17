import lustre
import lustre/attribute.{style}
import lustre/element/html

pub fn main() {
  let app = lustre.element(html.h1([], [html.text("ciao mond")]))
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
