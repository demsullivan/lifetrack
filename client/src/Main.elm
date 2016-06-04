module Main exposing (..)
import Navigation
import Hop.Types exposing (Location)

import View
import Update
import Route
import Model exposing (Model, Msg)

init : ( Route.Route, Hop.Types.Location ) -> ( Model, Cmd Model.Msg )
init ( route, location ) =
  ( { metrics = []
    , metricUid = 0
    , route = route
    , location = location
    }
  , Cmd.none
  )

main : Program Never
main =
  Navigation.program Route.urlParser
    { init = init
    , view = View.view
    , update = Update.update
    , urlUpdate = Update.urlUpdate
    , subscriptions = Update.subscriptions
    }
