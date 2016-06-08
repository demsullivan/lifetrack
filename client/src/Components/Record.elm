module Components.Record exposing (..)

import Uuid

type alias Record =
  { id : Uuid.Uuid
  , title : String
  , content : String
  , isEditing : Bool
  }
