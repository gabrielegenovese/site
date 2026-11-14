import lustre/attribute.{attribute}
import lustre/element.{type Element}
import lustre/element/html
import website/component/footer
import website/component/header

pub fn head(page: String) -> Element(a) {
  html.head([], [
    html.meta([attribute("charset", "UTF-8")]),
    html.meta([
      attribute("name", "viewport"),
      attribute("content", "width=device-width, initial-scale=1.0"),
    ]),
    html.meta([
      attribute("name", "theme-color"),
      attribute.content("#fcfbf8"),
    ]),
    html.script([attribute.src("./theme.js")], ""),
    html.title([], "Gabriele Genovese " <> page),
    html.link([attribute.href("./style.css"), attribute.rel("stylesheet")]),
    html.link([
      attribute.type_("image/svg+xml"),
      attribute.href("/favicon.svg"),
      attribute.rel("icon"),
    ]),
    html.link([
      attribute("sizes", "48x48"),
      attribute.type_("image/png"),
      attribute.href("/favicon.ico"),
      attribute.rel("alternate icon"),
    ]),
  ])
}

pub fn page(name: String, content: List(Element(a))) -> Element(a) {
  html.html([attribute("lang", "en")], [
    head(name),
    html.body([attribute.class("site-body flex min-h-screen flex-col")], [
      header.view(name),
      html.main([attribute.class("site-main flex-grow")], content),
      footer.view(),
    ]),
  ])
}

pub fn text_page(
  title: String,
  header: String,
  content: List(Element(a)),
) -> Element(a) {
  page(title, [
    html.section([attribute.class("page-hero")], [
      html.div([attribute.class("page-shell")], [
        html.h1([attribute.class("page-title")], [html.text(header)]),
      ]),
    ]),
    html.div([attribute.class("page-shell")], [
      html.div([attribute.class("page-content prose-site")], content),
    ]),
  ])
}
