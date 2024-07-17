import lustre_http

pub type Msg {
  UserIncrementedCount
  UserDecrementedCount
  ApiReturnedCat(Result(String, lustre_http.HttpError))
}

pub type Model {
  Model(count: Int, cats: List(String))
}
