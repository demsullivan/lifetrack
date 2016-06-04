module Model exposing (..)

import Hop.Types exposing (Location)
import Route exposing (Route)
import Material

import Components.Metric as Metric

type alias Model =
  { metrics : List IndexedMetric
  , metricUid : Int
  , route : Route
  , location : Location
  , mdl : Material.Model
  }

type alias IndexedMetric = { id : Int, model : Metric.Model }

type Msg
  = Add Metric.MetricType
  | Remove
  | MetricMsg Int Metric.Msg
  | NavigateTo String
  | Mdl Material.Msg
