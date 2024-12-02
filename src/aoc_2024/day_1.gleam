import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn parse_input(input: String) -> #(List(Int), List(Int)) {
  let assert [left, right] =
    input
    |> string.trim
    |> string.split("\n")
    |> list.map(fn(row) {
      string.split(row, " ") |> list.map(int.parse) |> result.values
    })
    |> list.transpose
  #(left, right)
}

pub fn pt_1(input: String) {
  let #(left, right) = parse_input(input)
  list.zip(list.sort(left, int.compare), list.sort(right, int.compare))
  |> list.fold(0, fn(acc, pair) { acc + int.absolute_value(pair.0 - pair.1) })
}

pub fn pt_2(input: String) {
  let #(left, right) = parse_input(input)
  left
  |> list.map(fn(x) { list.count(right, fn(y) { x == y }) })
  |> list.zip(left)
  |> list.fold(0, fn(acc, pair) { acc + pair.0 * pair.1 })
}
