import cv/entity.{type Model, type Msg, Model}
import cv/update.{update}
import cv/view.{view}
import lustre
import lustre/effect

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) -> #(Model, effect.Effect(Msg)) {
  #(Model(0, []), effect.none())
}
