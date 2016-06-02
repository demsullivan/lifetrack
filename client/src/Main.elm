import Html exposing (..)
import Html.App as App
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (placeholder, value)
import Dict exposing (Dict)

-- import Helpers exposing (IndexedModel)
import Components.Metric as Metric

main : Program Never
main =
  App.program
    { init = (init, Cmd.none)
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }


-- MODEL


{-- type alias Model =
  { metrics : Indexed Metric.Model
  , metricsFirst : Int
  , metricsLast : Int
  }
--}

type alias Model =
  { metrics : List IndexedMetric
  , metricUid : Int
  }

type alias IndexedMetric = { id : Int, model : Metric.Model }

init : Model
init =
  { metrics = []
  , metricUid = 0
  }


-- UPDATE


type Msg
  = Add Metric.MetricType
  | Remove
  | MetricMsg Int Metric.Msg


{--
resetMetric : Int -> Model -> Model
resetMetric k model =
  .reset (Metric.find [k]) model
--}

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Add type' ->
      ( { model
          | metrics = model.metrics ++ [ IndexedMetric model.metricUid (Metric.init "" type') ]
          , metricUid = model.metricUid + 1
        }
      , Cmd.none
      )

    Remove ->
      ( { model
          | metrics = List.drop 1 model.metrics
        }
      , Cmd.none
      )

    MetricMsg id msg' ->
      ( { model | metrics = List.map (updateMetricHelper id msg') model.metrics }
      , Cmd.none
      )


updateMetricHelper targetId msg {id, model} =
  IndexedMetric id (if targetId == id then Metric.update msg model else model)

-- VIEW


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
