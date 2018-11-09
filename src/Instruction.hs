module Instruction(
        toInstruction
) where

data Instruction = Instruction {
        idProcess :: Integer,
        idInstruction :: Integer,
        idData :: Integer,
        writeOrRead :: Integer
} deriving(Show)

type InstructionBlock = [Instruction]

toInstruction :: [Integer] -> Instruction
toInstruction l = Instruction {idProcess = l!!0, idInstruction = l!!1 `div` (512::Integer), idData = l!!2 `div` (512::Integer), writeOrRead = l!!3}






