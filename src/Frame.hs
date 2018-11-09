module Frame(
    Frame(..),
    Memory (..),
    toFrame,
    toMemory,    
    initBlockFrame,
    initMemory
) where
import qualified Data.ByteString.Lazy.Char8 as BStr


data Frame = Frame {
        idProcess :: Integer,
        idLogicalPage :: Integer,
        referenceBit :: Integer,
        dirtyBit :: Integer
}

instance Show Frame where
        show (Frame id ilp rb db) = "\t[ "++ show id++"\t\t"++show ilp++"\t\t"++show rb++"\t\t"++show db++" ]\n"
       
data Memory = Memory {
        frameBlock :: [Frame],
        pageFaults :: Integer,
        readingCounter :: Integer,
        writingCounter :: Integer
}
showMemory:: Memory -> Integer -> String
showMemory (Memory (x:[]) pf rc wc) counter = show counter++ " " ++ show x
showMemory (Memory (x:xs) pf rc wc) counter = show counter++ " " ++ show x ++ showMemory (Memory xs pf rc wc) (counter+1)

instance Show Memory where
        show memory = showStats ++ "\n" ++ header ++ showMemory memory 0
                where header = "\t  ProcessId \t IdLogicalPage \t ReferenceBit \t DirtyBit\n"
                      showStats = "Page Faults: " ++ show (pageFaults memory) ++ "  Reading: " ++ show (readingCounter memory) ++ "  Writing: " ++ show (writingCounter memory)

toFrame :: [Integer] -> Frame
toFrame l = Frame {idProcess = l!!0, idLogicalPage = l!!1, referenceBit = l!!2, dirtyBit = l!!3}

toMemory :: ([Frame],Integer,Integer,Integer) -> Memory
toMemory (fb,pf,rc,wc) = Memory fb pf rc wc

initBlockFrame :: [Frame]
initBlockFrame = map toFrame (replicate 32 [0,0,0,2])

initMemory :: Memory
initMemory = Memory initBlockFrame 0 0 0