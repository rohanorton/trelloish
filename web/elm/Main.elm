module Main exposing (..)

import Html exposing (text, section, header, Html)


main : Html a
main =
    section []
        [ header [] [ text "Hello!" ]
        , section [] [ text "This is a nice new thing I'm trying" ]
        ]
