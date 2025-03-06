import lustre/element/html
import website/component

pub fn view() {
  component.text_page("Home", "Hiiii! I'm Gabriele Genovese", [
    html.text("I am master student in Computer Science."),
  ])
}
