module Components.Metric exposing (Metric, Msg, MetricType (MString, MRating, MNumber, MBoolean), newMetric, update, view, editView)
-- import Html exposing (..)
import Html.Events exposing (onInput)
import Html exposing (Html, text, label, input)
import Material.Options as Options
import Material.Options exposing (div, css)
import Material.Elevation as Elevation
import Material.Icon as Icon

import Style
import Uuid

type MetricType = MString | MRating | MNumber | MBoolean

type alias Metric =
  { id : Int
  , name : String
  , metricType : MetricType
  }


newMetric : Int -> String -> Maybe MetricType -> Metric
newMetric id name type' =
    Metric id name (Maybe.withDefault MString type')


type Msg
  = SetNameField String


update : Msg -> Metric -> Metric
update msg model =
  case msg of
    SetNameField newValue ->
      { model | name = newValue }


view : Metric -> Html Msg
view model =
  div Style.card
    [ text model.name
    , metricTypeIcons model
    ]

metricTypeIcons : Metric -> Html Msg
metricTypeIcons model =
  div [ css "float" "right" ]
    (List.map (iconForType model) [MString, MNumber, MRating, MBoolean])


editView : Metric -> Html Msg
editView model =
  div []
    [ label [] [ text "Metric Name" ]
    , input [ onInput SetNameField ] []
    ]

iconForType : Metric -> MetricType -> Html m
iconForType metric type' =
  let
    iconDiv =
      if metric.metricType == type' then
        div [ css "float" "right" ]
      else
        div [ css "float" "right", css "color" "#c0c0c0" ]
  in
    case type' of
      MString ->
        iconDiv [ Icon.i "text_format" ]

      MNumber ->
        iconDiv [ Icon.i "looks_6" ]

      MBoolean ->
        iconDiv [ Icon.i "check_circle" ]

      MRating ->
        iconDiv [ Icon.i "stars" ]

{--
view : (Msg -> m) -> Model -> Html m
view lift model =
  div []
    [ label [] [ text "Metric Name" ]
    , input [ onInput (lift SetName) ] []
    ]

type alias Container c =
  { c | metrics : Indexed Model }

set : Parts.Set (Indexed Model) (Container c)
set x y =
  { y | metrics = x }

render : ( Parts.Msg (Container c) -> m ) -> Parts.Index -> Container c -> Html m
render =
  Parts.create view update .metrics set (init "")

find : Parts.Index -> Parts.Accessors Model (Container c)
find =
  Parts.accessors .metrics set (init "")
--}
