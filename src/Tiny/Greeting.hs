module Tiny.Greeting
  ( greeting
  , greet
  ) where

greeting :: String
greeting = greet "Cabal"

greet :: String -> String
greet name = "Hello from " <> name <> "."
