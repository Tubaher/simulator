module Main where

import System.Environment
import qualified Data.ByteString.Lazy.Char8 as BStr
import Types
type Frame = [Integer]

toNumber :: String -> Integer
toNumber s 
        | s == "W" = 1
        | s == "R" = 0
        | otherwise = read s 

findFrame :: [Integer] -> Integer
findFrame [_,n,_,_] = n `div` (512::Integer)

arrayFrames :: [[Integer]]
arrayFrames  = replicate 32 [0,0,2] -- 2 quiere decir que se incializo la memoria

toArrayNumber :: [[BStr.ByteString]] -> [[Integer]]
toArrayNumber x = map (\l -> (map (toNumber . BStr.unpack) l)) x

changedFrame :: [Integer] -> [Integer] -> [Integer]
changedFrame instruct frame = [idFrame,1, wOr]
                      where wOr = instruct !! 3
                            idFrame = findFrame instruct

getClass :: [Integer] -> Integer
getClass [_,refer,w0r] 
        | (refer == 0 && w0r == 0) = 0
        | (refer == 0 && w0r == 1) = 1
        | (refer == 0 && w0r == 0) = 2
        | (refer == 0 && w0r == 0) = 3

getIdsOfClass :: Integer -> [[Integer]] -> [Integer]
getIdsOfClass _ [] = []
getIdsOfClass clase ([idFrame,reference,w0r]:xs)
        | (getClass [idFrame,reference,w0r] == clase) = idFrame : getIdsOfClass clase xs
        | otherwise = getIdsOfClass clase xs

-- notRecentlyUsed :: [[Integer]] -> [[Integer]]
-- notRecentlyUsed [idFrame,reference,w0r]x  
             

-- mapInstructionArrayToFrameArray :: [[Integer]] -> [[Integer]] -> [[Integer]]
-- mapInstructionArrayToFrameArray instructions frames 
                                                            

main :: IO()
main = do
    args <- getArgs
    case args of 
      [file] -> do
        x <- (map (BStr.split ' ') . BStr.lines) `fmap` BStr.readFile file
        instructions <- return $ toArrayNumber x
        print instructions
      _ -> putStrLn "Wrong number of arguments"