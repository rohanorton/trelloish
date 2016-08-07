module Main exposing (..)

import Html exposing (button, p, text, div, Html)
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
    = ChangeRoute Routing.Route


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeRoute route ->
            { model | route = route } ! [ Navigation.newUrl <| Routing.pageToURL route ]



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

        MyNumberRoute int ->
            numberRoute int

        NotFoundRoute ->
            notFoundView


homeView : Html Msg
homeView =
    div []
        [ p [] [ text "Hello, from Home :D" ]
        , button (Routing.pageLink ChangeRoute LoginRoute) [ text "Login" ]
        ]


loginView : Html Msg
loginView =
    div []
        [ p [] [ text "You're trying to login. It won't work D:" ]
        , button (Routing.pageLink ChangeRoute HomeRoute) [ text "Go Home" ]
        ]


numberRoute : Int -> Html Msg
numberRoute int =
    let
        nextPage =
            MyNumberRoute <| int + 1
    in
        div []
            [ text <| "You are currently on page " ++ toString int
            , button (Routing.pageLink ChangeRoute nextPage) [ text "Next" ]
            , button (Routing.pageLink ChangeRoute HomeRoute) [ text "Go Home" ]
            ]


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found" ]
