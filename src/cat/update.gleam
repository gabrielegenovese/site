import cat/entity.{
  type Model, type Msg, ApiReturnedCat, Model, UserDecrementedCount,
  UserIncrementedCount,
}
import gleam/dynamic
import lustre/effect
import lustre_http

pub fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg {
    UserIncrementedCount -> #(Model(..model, count: model.count + 1), get_cat())
    UserDecrementedCount -> {
      case model.count {
        0 -> #(model, effect.none())
        _ -> {
          let rest_cat = case model.cats {
            [] -> []
            [_, ..rest] -> rest
          }
          #(Model(count: model.count - 1, cats: rest_cat), effect.none())
        }
      }
    }
    ApiReturnedCat(Ok(cat)) -> #(
      Model(..model, cats: [cat, ..model.cats]),
      effect.none(),
    )
    ApiReturnedCat(Error(_)) -> #(model, effect.none())
  }
}

fn get_cat() -> effect.Effect(Msg) {
  let decoder = dynamic.field("_id", dynamic.string)
  let expect = lustre_http.expect_json(decoder, ApiReturnedCat)

  lustre_http.get("https://cataas.com/cat?json=true", expect)
}
