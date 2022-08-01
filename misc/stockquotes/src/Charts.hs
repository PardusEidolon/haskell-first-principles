{-# LANGUAGE RecordWildCards #-}
module Charts (plotChart) where

import Data.Foldable (toList)
import Graphics.Rendering.Chart.Easy hiding (close, label, bars)
import Graphics.Rendering.Chart.Backend.Diagrams

import QuotesData

plotChart :: Foldable t => String -> t QuoteData -> FilePath -> IO ()
plotChart title quotes fname = do
    _ <- renderableToFile fileOptions fname (toRenderable chart)
    return ()
    where
        fileOptions = FileOptions (800,600) SVG loadSansSerifFonts

        (candles , closings, volumes) = unzip3 $
            [(Candle day low open 0 close high, (day, close), (day,[volume])) | QuoteData {..} <- toList quotes]

        chart = slayouts_layouts .~
            [ StackedLayout candlesLayout,
              StackedLayout volumesLayout
            ] $ def
        
        candlesLayout = 
            layout_title .~ title
          $ layout_plots .~ [toPlot $ qline "Close" closings green,
                             toPlot $ candle "candle" candles cyan]
          $ def

        volumesLayout =
            layout_plots .~ [plotBars $ bars "Volume" volumes lightblue]
          $ def

        qline label values colour =
            plot_lines_style .~ lineStyle 1 colour
          $ plot_lines_values .~ [values]
          $ plot_lines_title .~ label
          $ def

        candle label values colour = 
            plot_candle_line_style .~ lineStyle 1 gray
          $ plot_candle_fill .~ True
          $ plot_candle_rise_fill_style .~ fillStyle white
          $ plot_candle_fall_fill_style .~ fillStyle colour
          $ plot_candle_tick_length .~ 0
          $ plot_candle_width .~ 3
          $ plot_candle_values .~ values
          $ plot_candle_title .~ label
          $ def

        bars label values colour =
            plot_bars_titles .~ [label]
          $ plot_bars_values .~ values
          $ plot_bars_item_styles .~ [(fillStyle colour, Nothing)]
          $ plot_bars_spacing .~ (BarsFixWidth 18)
          $ def
        
        fillStyle colour = solidFillStyle (opaque colour)

        lineStyle n colour = 
            line_width .~ n
          $ line_color .~ opaque colour
          $ def