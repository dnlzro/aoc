import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Locations {
  Locations(left: List(Int), right: List(Int))
}

pub fn parse(input: String) -> Locations {
  let assert [left, right] =
    input
    |> string.trim
    |> string.split("\n")
    |> list.map(fn(row) {
      string.split(row, " ") |> list.map(int.parse) |> result.values
    })
    |> list.transpose
  Locations(left, right)
}

pub fn pt_1(input: Locations) {
  let Locations(left, right) = input
  list.zip(list.sort(left, int.compare), list.sort(right, int.compare))
  |> list.fold(0, fn(acc, pair) { acc + int.absolute_value(pair.0 - pair.1) })
}

pub fn pt_2(input: Locations) {
  let Locations(left, right) = input
  left
  |> list.map(fn(x) { list.count(right, fn(y) { x == y }) })
  |> list.zip(left)
  |> list.fold(0, fn(acc, pair) { acc + pair.0 * pair.1 })
}
