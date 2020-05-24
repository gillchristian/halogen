module Example where

import Prelude

import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Tailwind as T

type State = { count :: Int }

data Action = Increment

component :: forall q i o m. H.Component HH.HTML q i o m
component =
  H.mkComponent
    { initialState: const { count: 0 }
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }

render :: forall m. State -> H.ComponentHTML Action () m
render state =
  HH.div_
    [ HH.p_ [ HH.text $ "You clicked " <> show state.count <> " times" ]
    , HH.button
        [ HP.classes [T.bgBlue300, T.hoverBgBlue700, T.textWhite, T.fontBold, T.py2, T.px2, T.rounded]
        , HE.onClick \_ -> Just Increment ]
        [ HH.text "Click me" ]
    ]

handleAction ∷ forall o m. Action → H.HalogenM State Action () o m Unit
handleAction = case _ of
  Increment ->
    H.modify_ \st -> st { count = st.count + 1 }
