module Extra(
    loadData,
    loadDataWithoutArgs
)where
 
import System.Environment
import qualified Data.ByteString.Lazy.Char8 as BStr
import Instruction

toNumber :: String -> Integer
toNumber s 
        | s == "W" = 1
        | s == "R" = 0
        | otherwise = read s 

toArrayNumber :: [[BStr.ByteString]] -> [[Integer]]
toArrayNumber x = map (\l -> (map (toNumber . BStr.unpack) l)) x    

loadData :: IO()
loadData = do
        args <- getArgs
        case args of 
          [file] -> do
            x <- (map (BStr.split ' ') . BStr.lines) `fmap` BStr.readFile file
            instructions <- return $ toArrayNumber x
            print (map toInstruction instructions)
          _ -> putStrLn "Para ejecutar usar las siguientes sintaxis \n \t simulator data#.txt <version 1> <modo debug>"

loadDataWithoutArgs :: IO()
loadDataWithoutArgs = do
                   x <- (map (BStr.split ' ') . BStr.lines) `fmap` file
                   instructions <- return $ toArrayNumber x
                   print (map toInstruction instructions)
                      where file = BStr.readFile "data1.txt"