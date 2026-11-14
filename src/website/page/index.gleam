import lustre/element/html
import website/component

pub fn view() {
  component.text_page("Home", "Hiii! I'm Gabriele Genovese", [
    html.p([], [html.text("I am a PhD student in Computer Science.")]),
  ])
}
