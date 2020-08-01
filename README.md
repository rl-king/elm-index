# elm-index

Tag `Index a`.

``` elm
-- With an anonymous record.
type alias RecordIndex =
    Index { record : () }

-- You could use some type you already have.
type BlockContent
    = Text String
    | Image String

type alias BlockIndex =
    Index BlockContent

-- Or, if you've got just one Index.
type alias Index =
    Index ()

```

Replace `Int` with the `Index a` type.

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
