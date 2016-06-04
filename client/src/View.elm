module View exposing (..)

import Html exposing (..)
import Html.Attributes
import Html.Events exposing (onClick)
import Html.App as App
import Material.Layout as Layout
import Material.Scheme as Scheme
import Material.Color as Color
import Material.Icon as Icon

import Model exposing (..)
import Route exposing (..)

import Components.Metric as Metric

header : List (Html a)
header =
  [ Layout.row
      []
      [ Layout.title [] [ text "LifeTrak" ]
      , Layout.spacer
      , Layout.navigation []
        [ Icon.i "add"
        , Layout.spacer
        , Icon.i "settings"
        ]
      ]
  ]

layoutView : Model.Model -> Html Msg
layoutView model =
  Layout.render Mdl model.mdl
    [ Layout.fixedHeader
    -- , Layout.fixedDrawer
    , Layout.waterfall True
    ]
    { header = header
    , main = [ div [] [ pageView model ] ]
    , drawer = [ Layout.navigation [] [] ]
    , tabs = ( [], [] )
    }
  |> (\contents ->
      div []
        [ Scheme.topWithScheme Color.Red Color.Teal contents
        , Html.node "script"
           [ Html.Attributes.attribute "src" "assets/highlight.pack.js" ]
           []
        ]
    )

-- view : Model.Model -> Html Msg
-- view model =
--   let
--     remove =
--       button [ onClick Remove ] [ text "Remove Metric" ]
--
--     addString =
--       button [ onClick (Add Metric.MString) ] [ text "Add Metric" ]
--
--     addNumber =
--       button [ onClick (Add Metric.MNumber) ] [ text "Add Number Metric" ]
--
--     metricEditList =
--       List.map (\m -> App.map (MetricMsg m.id) (Metric.editView m.model)) model.metrics
--
--     metricNameList =
--       table []
--         ([ tr [] [
--           td [] [ text "Metric Name" ],
--           td [] [ text "Metric Type" ]
--           ]
--         ] ++ List.map metricRow model.metrics)
--
--   in
--     div []
--       [ div [] [ mainMenu model ]
--       , div [] ([remove, addString, addNumber] ++ metricEditList ++ [metricNameList])
--       , div [] [ pageView model ]
--       ]
--
-- mainMenu : Model.Model -> Html Msg
-- mainMenu model =
--   div []
--     [ button [ onClick ( NavigateTo "" ) ] [ text "Home" ]
--     , button [ onClick ( NavigateTo "metrics" ) ] [ text "Metrics" ]
--     , button [ onClick ( NavigateTo "missing" ) ] [ text "Invalid" ]
--     ]
--
pageView : Model.Model -> Html Msg
pageView model =
  case model.route of
    IndexRoute ->
      text "You are on the index page."

    MetricsRoute ->
      text "You are on the metrics page."

    NotFoundRoute ->
      text "Oops! Page not found."
--
-- metricRow : IndexedMetric -> Html Msg
-- metricRow model =
--   tr []
--     [ td [] [ text model.model.name ]
--     , td [] [ text (Metric.typeToString model.model.metricType) ]
--     ]
