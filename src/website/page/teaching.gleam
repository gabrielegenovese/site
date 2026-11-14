import gleam/int
import gleam/list
import lustre/attribute
import lustre/element/html
import website/component

pub type Teaching {
  Teaching(
    course: String,
    year: String,
    semester: String,
    hours: Int,
    teacher: String,
    university: String,
  )
}

const teaching = [
  Teaching(
    course: "Fundamentals of Computer Science",
    year: "2026/2027",
    semester: "Spring",
    hours: 40,
    teacher: "Prof. Cinzia Di Giusto",
    university: "Université Côte d'Azur",
  ),
  Teaching(
    course: "Computer Architecture",
    year: "2026/2027",
    semester: "Autumn",
    hours: 30,
    teacher: "Prof. Ivan Lanese",
    university: "University of Bologna",
  ),
  Teaching(
    course: "Model for Concurrency",
    year: "2025/2026",
    semester: "Spring",
    hours: 4,
    teacher: "Prof. Cinzia Di Giusto",
    university: "Université Côte d'Azur",
  ),
  Teaching(
    course: "Operating Systems 2 Laboratory",
    year: "2025/2026",
    semester: "Spring",
    hours: 40,
    teacher: "Prof. Sid Touati",
    university: "Université Côte d'Azur",
  ),
  Teaching(
    course: "Operating Systems",
    year: "2023/2024",
    semester: "Extended",
    hours: 50,
    teacher: "Prof. Renzo Davoli",
    university: "University of Bologna",
  ),
]

pub fn view() {
  component.text_page("Teaching", "Teaching", [
    html.section([attribute.class("content-section")], [
      html.h2([attribute.class("section-title")], [
        html.text("Teaching Assistant"),
      ]),
      html.p([attribute.class("section-lead")], [
        html.text("Courses I supported as a teaching assistant."),
      ]),
      html.div([attribute.class("table-shell")], [
        html.table([attribute.class("data-table")], [
          header(),
          html.tbody([], list.map(teaching, row)),
        ]),
      ]),
    ]),
  ])
}

fn header() {
  html.thead([], [
    html.tr([], [
      th("Course"),
      th("Academic year"),
      th("Semester"),
      th("Hours"),
      th("Instructor"),
      th("University"),
    ]),
  ])
}

fn row(t: Teaching) {
  html.tr([], [
    td(t.course),
    td(t.year),
    td(t.semester),
    td(int.to_string(t.hours)),
    td(t.teacher),
    td(t.university),
  ])
}

fn th(text: String) {
  html.th([], [html.text(text)])
}

fn td(text: String) {
  html.td([], [html.text(text)])
}
