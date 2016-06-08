module Components.Metric exposing (Metric, Msg, MetricType (MString, MRating, MNumber, MBoolean), newMetric, view, update)
-- import Html exposing (..)

import Html.Events exposing (onInput)
import Html exposing (Html, text, label, input)
import Material.Options as Options
import Material.Options exposing (div, css)
import Material.Elevation as Elevation
import Material.Icon as Icon
import Material.Textfield as Textfield
import Material.Button as Button
import Material
import Uuid

import Style

type MetricType = MString | MRating | MNumber | MBoolean

type alias Metric =
  { id : Uuid.Uuid
  , name : String
  , metricType : MetricType
  , isEditing : Bool
  , mdl : Material.Model
  }


newMetric : Uuid.Uuid -> String -> Maybe MetricType -> Metric
newMetric id name type' =
    Metric id name (Maybe.withDefault MString type') True Material.model


type Msg
  = SetName String
  | SetType MetricType
  | ToggleEditing
  | Mdl Material.Msg


update : Msg -> Metric -> (Metric, Cmd Msg)
update msg model =
  case msg of
    SetName newValue ->
      ({ model | name = newValue }, Cmd.none)

    SetType newType ->
      ({ model | metricType = newType }, Cmd.none)

    ToggleEditing ->
      ({model | isEditing = not model.isEditing}, Cmd.none)

    Mdl msg' ->
      Material.update Mdl msg' model


view : Metric -> Html Msg
view model =
  -- div Style.card
  --   [ text model.name
  --   , metricTypeIcons model
  --   ]
  let
    content =
      if model.isEditing then
        (editView model)
      else
        [ text model.name
        , metricTypeIcons model
        ]
  in
    div Style.card content

metricTypeIcons : Metric -> Html Msg
metricTypeIcons model =
  div [ css "float" "right", css "margin-top" (if model.isEditing then "20px" else "0px") ]
    (List.indexedMap (iconForType model) [MString, MNumber, MRating, MBoolean])


editView : Metric -> List (Html Msg)
editView model =
  [ Textfield.render Mdl [0] model.mdl
    [ Textfield.label "Metric name"
    , Textfield.floatingLabel
    , Textfield.onInput SetName
    , css "width" "150px"
    ]
  , Button.render Mdl [4] model.mdl
    [ css "float" "right"
    , css "margin-top" "20px"
    , css "color" "#00ff00"
    , Button.onClick ToggleEditing
    ] [ Icon.i "done" ]
  , metricTypeIcons model
  ]

iconForType : Metric -> Int -> MetricType -> Html Msg
iconForType metric idx type' =
  let
    baseStyle =
      [ css "float" "right"
      , css "padding" "0px"
      , css "min-width" "32px"
      , Button.onClick (SetType type')
      ]

    iconEl =
      if metric.isEditing then Button.render Mdl [idx] metric.mdl else div

    iconDiv =
      if metric.metricType == type' then
        iconEl baseStyle
      else
        iconEl ((css "color" "#c0c0c0") :: baseStyle)
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
