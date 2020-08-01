module Index exposing
    ( Index
    , withIndex
    , withIndex2
    , indexedMap
    , range
    , toInt
    , fromInt
    , toString
    , map
    , compare
    , zero
    , decode
    , encode
    )

{-|


# Definition

@docs Index


# Use

@docs withIndex
@docs withIndex2
@docs indexedMap
@docs range


# Basics

@docs toInt
@docs fromInt
@docs toString
@docs map
@docs compare
@docs zero


# Json

@docs decode
@docs encode

-}

import Json.Decode as Decode
import Json.Encode as Encode


{-| A taggable wrapper around `Int`.

    type alias ExampleIndex =
        Index { example : () }

    example : List String -> List ( ExampleIndex, String )
    example xs =
        Index.indexedMap List.indexedMap Tuple.pair xs

-}
type Index a
    = Index Int


{-| Create an `Index a` from an `Int`.
-}
fromInt : Int -> Index a
fromInt =
    Index


{-| Turn an `Index a` into an `Int`.
-}
toInt : Index a -> Int
toInt (Index a) =
    a


{-| Compare two `Index a`.
-}
compare : Index a -> Index a -> Order
compare (Index a) (Index b) =
    Basics.compare a b


{-| Change the value of an `Index a`.
-}
map : (Int -> Int) -> Index a -> Index a
map f (Index a) =
    Index (f a)


{-| Decode an `Int` to an `Index a`
-}
decode : Decode.Decoder (Index a)
decode =
    Decode.map Index Decode.int


{-| Encode an `Index a` to an `elm/json` `Value` (`number`).
-}
encode : Index a -> Encode.Value
encode =
    Encode.int << toInt


{-| Turn an `Index a` into an `String`.
-}
toString : Index a -> String
toString =
    String.fromInt << toInt


{-| Generate a `List` of `Index a`.
-}
range : Int -> Int -> List (Index a)
range a b =
    List.map Index (List.range a b)


{-| Index zero
-}
zero : Index a
zero =
    Index 0


{-| Turn an `indexedMap` function provided by another package to one that uses `Index a` instead of `Int`.

    list : (Index a -> b -> c) -> List b -> List c
    list =
        Index.indexedMap List.indexedMap

    array : (Index a -> b -> c) -> Array b -> Array c
    array =
        Index.indexedMap Array.indexedMap

    reorderable : (Index a -> b -> c) -> Reorderable b -> Reorderable c
    reorderable =
        Index.indexedMap Reorderable.indexedMap

-}
indexedMap : ((Int -> b -> c) -> d) -> (Index a -> b -> c) -> d
indexedMap f g =
    f (g << Index)


{-| Turn any function that takes an `Int` as its first argument into a function that takes `Index a`.

    arrayGet : Index a -> Array b -> Maybe b
    arrayGet =
        Index.withIndex Array.get

    arraySet : Index a -> b -> Array b -> Array b
    arraySet =
        Index.withIndex Array.set

    reorderable : Index a -> (b -> b) -> Reorderable b -> Reorderable b
    reorderable =
        Index.withIndex Reorderable.update

-}
withIndex : (Int -> b) -> Index a -> b
withIndex f (Index i) =
    f i


{-| Like `withIndex` but with two `Int`s

    reorderable : Index a -> Index a -> Reorderable b -> Reorderable b
    reorderable =
        Index.withIndex2 Reorderable.swap

-}
withIndex2 : (Int -> Int -> b) -> Index a -> Index a -> b
withIndex2 f =
    withIndex << withIndex f
