module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App

import Model exposing (..)
import Components.Metric as Metric

view : Model -> Html Msg
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
    div [] ([remove, addString, addNumber] ++ metricEditList ++ [metricNameList])

metricRow model =
  tr []
    [ td [] [ text model.model.name ]
    , td [] [ text (Metric.typeToString model.model.metricType) ]
    ]
