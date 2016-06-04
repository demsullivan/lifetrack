module Update exposing (..)

import Hop exposing (makeUrl)
import Hop.Types exposing (Location)
import Navigation
import Material

import Route exposing (routerConfig)
import Model exposing (..)
import Components.Metric as Metric

subscriptions : Model -> Sub Model.Msg
subscriptions model =
  Sub.none

urlUpdate : ( Route.Route, Hop.Types.Location ) -> Model -> (Model, Cmd Msg)
urlUpdate ( route, location ) model =
  ({ model | route = route, location = location}, Cmd.none)

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

    NavigateTo path ->
      let
        command =
          makeUrl routerConfig path
            |> Navigation.modifyUrl
      in
        (model, command)

    Mdl msg' ->
      Material.update Mdl msg' model

updateMetricHelper : Int -> Metric.Msg -> IndexedMetric -> IndexedMetric
updateMetricHelper targetId msg {id, model} =
  IndexedMetric id (if targetId == id then Metric.update msg model else model)
