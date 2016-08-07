module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)
import Html exposing (Attribute, a)
import Html.Events exposing (onWithOptions, defaultOptions)
import Html.Attributes exposing (href, style)
import Json.Decode as Json


type Route
    = HomeRoute
    | MyNumberRoute Int
    | LoginRoute
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format HomeRoute (s "")
        , format LoginRoute (s "login")
        , format MyNumberRoute (s "number" </> int)
        ]


urlParser : Navigation.Location -> Result String Route
urlParser location =
    location.pathname
        |> String.dropLeft 1
        |> String.toLower
        |> parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser urlParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute


pageToURL : Route -> String
pageToURL route =
    case route of
        HomeRoute ->
            "/"

        MyNumberRoute int ->
            "/number/" ++ toString int

        LoginRoute ->
            "/login"

        NotFoundRoute ->
            Debug.crash "Cannot route page that does not exist!"



--


onPreventDefaultClick : msg -> Attribute msg
onPreventDefaultClick message =
    onWithOptions "click" { defaultOptions | preventDefault = True } (Json.succeed message)


pageLink : (Route -> msg) -> Route -> List (Attribute msg)
pageLink pageToMsg page =
    [ style [ "cursor" => "pointer" ]
    , href <| pageToURL page
    , onPreventDefaultClick <| pageToMsg page
    ]



--


(=>) =
    (,)
