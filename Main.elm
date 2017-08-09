module Main exposing (..)

import Html exposing (Attribute, Html, button, div, input, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias QuestionNumber =
    Int


questionNumber : QuestionNumber
questionNumber =
    0


type alias Model =
    { questions : List Question
    , currentQuestion : Int
    }


type alias Question =
    { id : Int
    , answer : String
    , question : String
    , hint : String
    }


question1 : Question
question1 =
    { question = "This is the first question?"
    , answer = ""
    , hint = "This is a great hint"
    , id = 1
    }


question2 : Question
question2 =
    { question = "This is the second question?"
    , answer = ""
    , hint = "This is a great hint"
    , id = 2
    }


model : Model
model =
    { questions = [ question1, question2 ]
    , currentQuestion = question1.id
    }



-- UPDATE


type Msg
    = UpdateQuestion Int String
    | NextQuestion


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateQuestion id answer ->
            let
                mapFn question =
                    if question.id == id then
                        { question | answer = answer }
                    else
                        question
            in
            { model | questions = List.map mapFn model.questions }

        NextQuestion ->
            { model | currentQuestion = Basics.max (model.currentQuestion + 1) (List.length model.questions) }



-- VIEW


questionView : Question -> Html Msg
questionView question =
    div []
        [ p [] [ text question.question ]
        , input [ placeholder question.hint, onInput (UpdateQuestion question.id) ] []
        , div [] [ text question.answer ]
        , button [ onClick NextQuestion ] [ text "Save" ]
        ]


view : Model -> Html Msg
view model =
    div []
        (List.map questionView (List.filter (\q -> q.id == model.currentQuestion) model.questions))
