{-# LANGUAGE TemplateHaskell #-}

module Main where

import           Hedgehog
import           Hedgehog.Main
import           Karma

prop_test :: Property
prop_test = property $ do
  doKarmadm === "Karmadm"

main :: IO ()
main = defaultMain [checkParallel $$(discover)]
