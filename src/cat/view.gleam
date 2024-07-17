import cat/entity.{
  type Model, type Msg, Model, UserDecrementedCount, UserIncrementedCount,
}

import gleam/int
import gleam/list
import lustre/attribute.{class}
import lustre/element
import lustre/element/html
import lustre/event

pub fn view(model: Model) -> element.Element(Msg) {
  let count = int.to_string(model.count)

  html.div([], [
    html.button([class("m-2"), event.on_click(UserIncrementedCount)], [
      element.text("+"),
    ]),
    element.text(count),
    html.button([class("m-2"), event.on_click(UserDecrementedCount)], [
      element.text("-"),
    ]),
    html.div(
      [],
      list.map(model.cats, fn(cat) {
        html.img([attribute.src("https://cataas.com/cat/" <> cat)])
      }),
    ),
  ])
}
