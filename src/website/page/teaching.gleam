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
    course: "Computer Architecture",
    year: "2026/2027",
    semester: "Autumn",
    hours: 40,
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
    html.div(
      [
        attribute.attribute(
          "style",
          "
            font-family: 'Inter', sans-serif;
            padding: 2rem 1rem;
            color: #e5e7eb;
          ",
        ),
      ],
      [
        html.p(
          [
            attribute.attribute(
              "style",
              "
                max-width: 48rem;
                margin-bottom: 1.5rem;
                color: #d1d5db;
                font-size: 1.05rem;
                line-height: 1.7;
              ",
            ),
          ],
          [
            html.h3(
              [
                attribute.attribute(
                  "style",
                  "
                    font-weight: 700;
                    font-size: 1.05rem;
                    margin-bottom: 0.6rem;
                    color: #f0eaff;
                  ",
                ),
              ],
              [html.text("Teaching Assistant")],
            ),
          ],
        ),

        html.div(
          [
            attribute.attribute(
              "style",
              "
                overflow-x: auto;
                border: 1px solid #3b0a7a;
                border-radius: 14px;
                background: linear-gradient(180deg, #0d0d17 0%, #111122 100%);
                box-shadow: 0 4px 10px rgba(0,0,0,0.25);
              ",
            ),
          ],
          [
            html.table(
              [
                attribute.attribute(
                  "style",
                  "
                    width: 100%;
                    border-collapse: collapse;
                    min-width: 850px;
                  ",
                ),
              ],
              [
                header(),
                html.tbody([], list.map(teaching, row)),
              ],
            ),
          ],
        ),
      ],
    ),
  ])
}

fn header() {
  html.thead([], [
    html.tr(
      [
        attribute.attribute(
          "style",
          "
            background: #18182b;
            border-bottom: 2px solid #3b0a7a;
          ",
        ),
      ],
      [
        th("Course"),
        th("Academic year"),
        th("Semester"),
        th("Hours"),
        th("Instructor"),
        th("University"),
      ],
    ),
  ])
}

fn row(t: Teaching) {
  html.tr(
    [
      attribute.attribute(
        "style",
        "
          border-bottom: 1px solid #23233b;
        ",
      ),
      attribute.attribute("onmouseover", "this.style.background='#18182b';"),
      attribute.attribute("onmouseout", "this.style.background='';"),
    ],
    [
      td(t.course),
      td(t.year),
      td(t.semester),
      td(int.to_string(t.hours)),
      td(t.teacher),
      td(t.university),
    ],
  )
}

fn th(text: String) {
  html.th(
    [
      attribute.attribute(
        "style",
        "
          padding: 1rem;
          text-align: left;
          font-weight: 700;
          color: #f5f5f5;
          white-space: nowrap;
        ",
      ),
    ],
    [html.text(text)],
  )
}

fn td(text: String) {
  html.td(
    [
      attribute.attribute(
        "style",
        "
          padding: 0.9rem 1rem;
          color: #d1d5db;
          vertical-align: top;
        ",
      ),
    ],
    [html.text(text)],
  )
}
