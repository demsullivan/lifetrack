module Main exposing (..)
import Navigation

import View
import Update
import Route

import Components.Metric as Metric

main : Program Never
main =
  Navigation.program Route.urlParser
    { init = init
    , view = View.view
    , update = Update.update
    , urlUpdate = Update.urlUpdate
    , subscriptions = Update.subscriptions
    }




-- VIEW
