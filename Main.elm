module Main exposing (..)

import Html exposing (Attribute, Html, button, div, input, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Html.beginnerProgram { model = question1, view = view, update = update }



-- MODEL


type alias QuestionNumber =
    Int


questionNumber : QuestionNumber
questionNumber =
    0


type alias Questions =
    List Question


type alias Question =
    { answer : String
    , question : String
    , hint : String
    }


question1 : Question
question1 =
    { question = "This is the first question?"
    , answer = ""
    , hint = "This is a great hint"
    }


questions : Questions
questions =
    [ question1 ]



-- UPDATE


type Msg
    = Change String


update : Msg -> Question -> Question
update msg question =
    case msg of
        Change newContent ->
            { question | answer = newContent }



-- VIEW


view : Question -> Html Msg
view question =
    div []
        [ p [] [ text question.question ]
        , input [ placeholder question.hint, onInput Change ] []
        , div [] [ text question.answer ]
        , button [ onClick (Change "reset") ] [ text "Save" ]
        ]
