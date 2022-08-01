 module Main where
 import Web.Audio
 
 main :: IO ()
 main = do
   webAudio 3000 $ \doc -> do
     send doc $ do
       osc1  <- createOscillator 200 0 Sine -- create an OscillatorNode
       gain1 <- createGain 0.5              -- create a GainNode
 
       connect $ osc1 .|. gain1 .||. eCtx   -- connect these nodes together, and then connect them to the audio context
 
       start osc1 -- make sounds!