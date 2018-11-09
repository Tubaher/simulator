module Frame(
    Frame(..),
    Memory (..),
    toFrame,
    toMemory,    
    initBlockFrame
) where
import qualified Data.ByteString.Lazy.Char8 as BStr


data Frame = Frame {
        idProcess :: Integer,
        idLogicalPage :: Integer,
        referenceBit :: Integer,
        dirtyBit :: Integer
} deriving(Show)

data Memory = Memory {
        frameBlock :: [Frame],
        pageFaults :: Integer,
        readingCounter :: Integer,
        writingCounter :: Integer
} deriving(Show)

toFrame :: [Integer] -> Frame
toFrame l = Frame {idProcess = l!!0, idLogicalPage = l!!1, referenceBit = l!!2, dirtyBit = l!!3}

toMemory :: ([Frame],Integer,Integer,Integer) -> Memory
toMemory (fb,pf,rc,wc) = Memory fb pf rc wc

initBlockFrame :: [Frame]
initBlockFrame = map toFrame (replicate 32 [0,0,0,2])