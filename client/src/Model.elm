module Model exposing (..)

import Uuid
import Hop.Types exposing (Location)
import Random.Pcg exposing (Seed)
import Material

import Route exposing (Route)
import Components.Metric as Metric

type alias Model =
  { metrics : List Metric.Metric
  -- , records : List Record.Record
  , route : Route
  , location : Location
  , mdl : Material.Model
  , currentSeed : Seed
  }

type Msg
  = MetricMsg Uuid.Uuid Metric.Msg
  | AddMetric
  | NavigateTo String
  | Mdl Material.Msg
