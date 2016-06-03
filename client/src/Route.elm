module Route exposing (..)

import Navigation
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Hop.Matchers exposing (..)

type Route
  = IndexRoute
  | MetricsRoute
  | NotFoundRoute


matchers : List (PathMatcher Route)
matchers =
  [ match1 IndexRoute ""
  , match1 MetricsRoute "/metrics"
  ]


routerConfig : Config Route
routerConfig =
  { hash = False
  , basePath = ""
  , matchers = matchers
  , notFound = NotFoundRoute
  }


urlParser : Navigation.Parser ( Route, Hop.Types.Location )
urlParser =
  Navigation.makeParser ( .href >> matchUrl routerConfig )
