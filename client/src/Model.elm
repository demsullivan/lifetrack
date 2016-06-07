module Model exposing (..)

import Hop.Types exposing (Location)
import Route exposing (Route)
import Material

import Components.Metric as Metric

type alias Model =
  { metrics : List Metric.Metric
  -- , records : List Record.Record
  , route : Route
  , location : Location
  , mdl : Material.Model
  }

type Msg
  = MetricMsg Int Metric.Msg
  | NavigateTo String
  | Mdl Material.Msg
