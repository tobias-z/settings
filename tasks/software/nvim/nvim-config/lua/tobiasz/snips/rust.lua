local builder = Snip.create_snippet_builder("rust")
local h = builder.helpers

builder.snip(h.snippet(
  "modtest",
  h.fmt(
    [[
#[cfg(test)]
mod test {{
    use super::*;

    {}
}}
        ]],
    {
      h.i(0),
    }
  )
))

builder.snip(h.snippet(
  "testcase",
  h.fmt(
    [[
#[test]
fn {}() {{
    {}
}}
        ]],
    {
      h.i(1),
      h.i(0),
    }
  )
))

builder.build()
