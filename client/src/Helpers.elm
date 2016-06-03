module Helpers exposing (IndexedModel)

type alias IndexedModel m =
  { id : Int, model : m }
