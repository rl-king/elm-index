# elm-index

Replace `Int` with the taggable `Index a` type.

``` elm
example : List ( Index { example : () }, String )
example =
    Index.indexedMap List.indexedMap
        Tuple.pair
        ["hallo", "hola", "hello"]
```


Make functions that expect an `Int` take an `Index a`.

``` elm
example : Index { example : () } -> Maybe Int
example index =
    Index.withIndex Array.get index <|
        Array.fromList [1, 2, 3]
```


Disambiguate between different indexes.

``` elm
type alias CardIndex =
    Index { card : () }

type alias EditorIndex =
    Index { editor : () }

example : List CardIndex
example =
    Index.range 1 10

example : List EditorIndex
example =
    Index.range 1 10
```
