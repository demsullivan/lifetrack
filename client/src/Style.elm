module Style exposing (..)

import Material.Options exposing (div, css, Property, Style)
import Material.Elevation as Elevation

card : List (Style b)
card =
  [ css "padding" "10px"
  , Elevation.e4
  ]
