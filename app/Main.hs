module Main where

import Tiny.Greeting
  ( greeting
  )

main :: IO ()
main =
  putStrLn greeting
