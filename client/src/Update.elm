module Update exposing (..)

import String
import Hop exposing (makeUrl)
import Hop.Types exposing (Location)
import Navigation
import Material
import Random.Pcg exposing (step)
import Uuid

import Route exposing (routerConfig)
import Model exposing (..)
import Components.Metric as Metric

subscriptions : Model -> Sub Model.Msg
subscriptions model =
  Sub.none

urlUpdate : ( Route.Route, Hop.Types.Location ) -> Model -> (Model, Cmd Msg)
urlUpdate ( route, location ) model =
  ({ model | route = route, location = location}, Cmd.none)

update : Msg -> Model.Model -> (Model.Model, Cmd Msg)
update msg model =
  case msg of
    AddMetric ->
      let
        (uuid, newSeed) =
          step Uuid.uuidGenerator model.currentSeed
      in
        ( { model
          | metrics = model.metrics ++ [Metric.newMetric uuid "" Nothing]
          , currentSeed = newSeed
          }
        , Cmd.none
        )

    MetricMsg id msg' ->
      let
        updateMetric m =
          if m.id == id then (Metric.update msg' m) |> fst else m
      in
        ({model | metrics = List.map updateMetric model.metrics }, Cmd.none)

    NavigateTo path ->
      let
        command =
          makeUrl routerConfig path
            |> Navigation.modifyUrl
      in
        (model, command)

    Mdl msg' ->
      Material.update Mdl msg' model

-- updateMetricHelper : Int -> Metric.Msg -> IndexedMetric -> IndexedMetric
-- updateMetricHelper targetId msg {id, model} =
--   IndexedMetric id (if targetId == id then Metric.update msg model else model)
