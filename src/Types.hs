module Types where

type IdProcess = Integer
type IdLogicalPage = Integer
type ReferenceBit = Integer
type DirtyBit = Integer
type Counter = Integer

type FrameV1 = [IdProcess, IdLogicalPage, ReferenceBit, DirtyBit]
type FrameV2 = [IdProcess, IdLogicalPage1, Counter, DirtyBit]

type MemoryV1 = [FrameV1]
type MemoryV2 = [FrameV2]

type InstructionAdress = Integer
type DataAdress = Integer
type WoR = Integer

type Instruction = [IdProcess, InstructionAdress, DataAdress, WoR]
type InstructionsBlock = [Instruction]

