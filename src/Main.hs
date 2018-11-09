module Main where


import qualified Frame as Fr
import Extra
import Instruction



-- changedFrame :: [Integer] -> [Integer] -> [Integer]
-- changedFrame instruct frame = [idFrame,1, wOr]
--                       where wOr = instruct !! 3
--                             idFrame = findFrame instruct

-- getClass :: [Integer] -> Integer
-- getClass [_,refer,w0r] 
--         | (refer == 0 && w0r == 0) = 0
--         | (refer == 0 && w0r == 1) = 1
--         | (refer == 0 && w0r == 0) = 2
--         | (refer == 0 && w0r == 0) = 3

-- getIdsOfClass :: Integer -> [[Integer]] -> [Integer]
-- getIdsOfClass _ [] = []
-- getIdsOfClass clase ([idFrame,reference,w0r]:xs)
--         | (getClass [idFrame,reference,w0r] == clase) = idFrame : getIdsOfClass clase xs
--         | otherwise = getIdsOfClass clase xs

-- notRecentlyUsed :: [[Integer]] -> [[Integer]]
-- notRecentlyUsed [idFrame,reference,w0r]x  
             

-- mapInstructionArrayToFrameArray :: [[Integer]] -> [[Integer]] -> [[Integer]]
-- mapInstructionArrayToFrameArray instructions frames 

main :: IO()
main = do 
  loadDataWithoutArgs
  -- loadData