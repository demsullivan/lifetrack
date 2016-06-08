module Main exposing (..)
import Navigation
import Hop.Types exposing (Location)
import Material
import Random.Pcg exposing (initialSeed2)

import Components.Metric as Metric
import Components.Metric exposing (MetricType(..))
import View
import Update
import Route
import Model

init : ( Route.Route, Hop.Types.Location ) -> ( Model.Model, Cmd Model.Msg )
init ( route, location ) =
  ( { metrics =
      [
      -- Metric.newMetric 0 "Text Metric" (Just MString)
      -- , Metric.newMetric 1 "Number Metric" (Just MNumber)
      -- , Metric.newMetric 2 "Boolean Metric" (Just MBoolean)
      -- , Metric.newMetric 3 "Rating Metric" (Just MRating)
      ]
    , route = route
    , location = location
    , mdl = Material.model
    , currentSeed = (initialSeed2 227852860 1498709020)
    }
  , Cmd.none
  )

main : Program Never
main =
  Navigation.program Route.urlParser
    { init = init
    , view = View.layoutView
    , update = Update.update
    , urlUpdate = Update.urlUpdate
    , subscriptions = Update.subscriptions
    }
