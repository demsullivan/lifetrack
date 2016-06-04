module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App

import Model exposing (..)
import Route exposing (..)

import Components.Metric as Metric

view : Model.Model -> Html Msg
view model =
  let
    remove =
      button [ onClick Remove ] [ text "Remove Metric" ]

    addString =
      button [ onClick (Add Metric.MString) ] [ text "Add Metric" ]

    addNumber =
      button [ onClick (Add Metric.MNumber) ] [ text "Add Number Metric" ]

    metricEditList =
      List.map (\m -> App.map (MetricMsg m.id) (Metric.editView m.model)) model.metrics

    metricNameList =
      table []
        ([ tr [] [
          td [] [ text "Metric Name" ],
          td [] [ text "Metric Type" ]
          ]
        ] ++ List.map metricRow model.metrics)

  in
    div []
      [ div [] [ mainMenu model ]
      , div [] ([remove, addString, addNumber] ++ metricEditList ++ [metricNameList])
      , div [] [ pageView model ]
      ]

mainMenu : Model.Model -> Html Msg
mainMenu model =
  div []
    [ button [ onClick ( NavigateTo "" ) ] [ text "Home" ]
    , button [ onClick ( NavigateTo "metrics" ) ] [ text "Metrics" ]
    , button [ onClick ( NavigateTo "missing" ) ] [ text "Invalid" ]
    ]
    
pageView : Model.Model -> Html Msg
pageView model =
  case model.route of
    IndexRoute ->
      text "You are on the index page."

    MetricsRoute ->
      text "You are on the metrics page."

    NotFoundRoute ->
      text "Oops! Page not found."

metricRow : IndexedMetric -> Html Msg
metricRow model =
  tr []
    [ td [] [ text model.model.name ]
    , td [] [ text (Metric.typeToString model.model.metricType) ]
    ]
