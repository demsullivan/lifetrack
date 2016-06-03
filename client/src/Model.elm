module Model exposing (..)

type alias Model =
  { metrics : List IndexedMetric
  , metricUid : Int
  }

type alias IndexedMetric = { id : Int, model : Metric.Model }

type Msg
  = Add Metric.MetricType
  | Remove
  | MetricMsg Int Metric.Msg
  
init : Model
init =
  { metrics = []
  , metricUid = 0
  }
