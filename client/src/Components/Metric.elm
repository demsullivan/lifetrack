module Components.Metric exposing (Model, Msg, MetricType (MString, MRating, MNumber, MBoolean), update, editView, init, typeToString)
import Html exposing (..)
import Html.Events exposing (onInput)

type MetricType = MString | MRating | MNumber | MBoolean

type alias Model =
  { name : String
  , metricType : MetricType
  }


init : String -> MetricType -> Model
init name type' =
  Model name type'


type Msg = SetName String


update : Msg -> Model -> Model
update msg model =
  case msg of
    SetName newName ->
      { model | name = newName }


editView : Model -> Html Msg
editView model =
  div []
    [ label [] [ text "Metric Name" ]
    , input [ onInput SetName ] []
    ]

typeToString : MetricType -> String
typeToString type' =
  case type' of
    MString ->
      "text"

    MRating ->
      "rating"

    MNumber ->
      "number"

    MBoolean ->
      "checkbox"

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
