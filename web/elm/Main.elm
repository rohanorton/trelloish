module Main exposing (..)

import Html exposing (text, div, Html)
import Routing exposing (Route(..))
import Navigation


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }



-- Model


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        initialModel currentRoute ! []


type alias Model =
    { route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { route = route
    }



-- UrlUpdate


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( { model | route = currentRoute }, Cmd.none )



-- Update


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- View


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        HomeRoute ->
            homeView

        LoginRoute ->
            loginView

        NotFoundRoute ->
            notFoundView


homeView : Html msg
homeView =
    text "Hello, from Home :D"


loginView : Html msg
loginView =
    text "You're trying to login. It won't work D:"


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found" ]
