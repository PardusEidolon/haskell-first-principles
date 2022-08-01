import qualified Data.ByteString.Builder as B
import qualified Data.ByteString.Lazy as B
import Data.Foldable
import Data.List
import System.Process
import Text.Printf

type Pulse = Float

type Seconds = Float

type Samples = Float

type Hz = Float

type Semitones = Float

type Beats = Float

outputFilePath :: FilePath
outputFilePath = "output.bin"

volume :: Float
volume = 0.5

sampleRate :: Samples
sampleRate = 48000.0

pitchStandard :: Hz
pitchStandard = 440.0

bpm :: Beats
bpm = 120.0

beatDuration :: Seconds
beatDuration = 60.0 / bpm

f :: Semitones -> Hz
f n = pitchStandard * (2 ** (1.0 / 12.0)) ** n

note :: Semitones -> Beats -> [Pulse]
note n beats = freq (f n) (beats * beatDuration)

freq :: Hz -> Seconds -> [Pulse]
freq hz duration =
  map (* volume) $ zipWith3 (\x y z -> x * y * z) release attack output
  where
    step = (hz * 2 * pi) / sampleRate
    attack :: [Pulse]
    attack = map (min 1.0) [0.0, 0.001 ..]
    release :: [Pulse]
    release = reverse $ take (length output) attack
    output :: [Pulse]
    output = map sin $ map (* step) [0.0 .. sampleRate * duration]

wave :: [Pulse]
wave =
  concat
    [ note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.5,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.5,
      note 5 0.25,
      note 5 0.25,
      note 5 0.25,
      note 5 0.25,
      note 5 0.25,
      note 5 0.25,
      note 5 0.5,
      note 3 0.25,
      note 3 0.25,
      note 3 0.25,
      note 3 0.25,
      note 3 0.25,
      note 3 0.25,
      note 3 0.5,
      note (-2) 0.5,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.5,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.25,
      note 0 0.5
    ]

save :: FilePath -> IO ()
save filePath = B.writeFile filePath $ B.toLazyByteString $ fold $ map B.floatLE wave

play :: IO ()
play = do
  save outputFilePath
  _ <- runCommand $ printf "ffplay -showmode 1 -f f32le -ar %f %s" sampleRate outputFilePath
  return ()