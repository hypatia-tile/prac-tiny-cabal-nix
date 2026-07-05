module Main where

import Tiny.Greeting
  ( greet
  )

assertEqual :: (Eq a, Show a) => String -> a -> a -> IO ()
assertEqual label expected actual =
  if expected == actual
  then pure ()
  else do
    putStrLn ("FAILED: " <> label)
    putStrLn ("expected: " <> show expected)
    putStrLn ("actual: " <> show actual)
    fail label

main :: IO ()
main = do
  assertEqual
    "greet build a greeting"
    "Hello from Nix."
    (greet "Nix")
