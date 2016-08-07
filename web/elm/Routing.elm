module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)


type Route
    = HomeRoute
    | LoginRoute
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format HomeRoute (s "")
        , format LoginRoute (s "login")
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
