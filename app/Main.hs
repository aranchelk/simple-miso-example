{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
module Main where

import           Miso
import           Miso.String  (MisoString, ms)

default (MisoString)

-- | Type synonym for an application model
type Model = MisoString

-- | Sum type for application events
data Action
  = NoOp
  | UpdateText MisoString
  deriving (Show, Eq)

-- | Entry point for a miso application
main :: IO ()
main = startApp App {..}
  where
    initialAction = NoOp          -- initial action to be executed on application load
    model  = ""                   -- initial model
    update = updateModel          -- update function
    view   = viewModel            -- view function
    events = defaultEvents        -- default delegated events
    mountPoint = Nothing          -- mount point for miso on DOM, defaults to body
    subs   = []                   -- empty subscription list

-- | Updates model, optionally introduces side effects
updateModel :: Action -> Model -> Effect Action Model
updateModel NoOp m = noEff m
updateModel (UpdateText x) _ = noEff x

-- | Constructs a virtual DOM from a model
viewModel :: Model -> View Action
viewModel x = div_ []
 [ input_ [ onInput UpdateText, placeholder_ "Empty Goal"] []
 , br_ [] []
 , text (ms x)
 ]
