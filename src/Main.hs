module Main where


import qualified Frame as Fr
import Extra
import Instruction

searchAndInsert :: Fr.Frame -> [Fr.Frame] -> [Fr.Frame]
searchAndInsert f (x:xs)
      | (Fr.dirtyBit x) == 2 = f:xs
      | otherwise = x:(searchAndInsert f xs)

addFrame :: Fr.Frame -> Fr.Memory -> Fr.Memory
addFrame frame memory = newMemory
      where fb = searchAndInsert frame (Fr.frameBlock memory)
            pf = Fr.pageFaults memory
            rc = Fr.readingCounter memory
            wc = Fr.writingCounter memory
            newMemory = Fr.toMemory (fb,pf,rc,wc)    

changeAtributesMemory:: Integer -> Fr.Memory -> Fr.Memory
changeAtributesMemory dirty memory = newMemory
      where fb = Fr.frameBlock memory
            pf = (Fr.pageFaults memory) + 1
            rc = (Fr.readingCounter memory) + 1
            wc = (Fr.writingCounter memory) + dirty
            newMemory = Fr.toMemory (fb,pf,rc,wc)

etapaUno :: Instruction -> Fr.Memory -> Fr.Memory
etapaUno instruct memory = changeAtributesMemory 0 (addFrame (Fr.toFrame [ip,ilp,r,d]) memory) 
      where ip = idProcess instruct
            ilp = idInstruction instruct
            r = 1
            d = 0

etapaDos :: Instruction -> Fr.Memory -> Fr.Memory
etapaDos instruct memory = changeAtributesMemory d (addFrame (Fr.toFrame [ip,ilp,r,d]) memory) 
      where ip = idProcess instruct
            ilp = idData instruct
            r = 1
            d = writeOrRead instruct

executeInstruction :: Instruction -> Fr.Memory -> Fr.Memory
executeInstruction instruct memory = etapaDos instruct (etapaUno instruct memory)

notRecentlyUsed :: InstructionBlock -> Fr.Memory -> Fr.Memory
notRecentlyUsed (x:[]) memory = executeInstruction x memory
notRecentlyUsed (x:xs) memory = notRecentlyUsed xs (executeInstruction x memory)

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