#
Concrete Consensus Mechanisms, VMs, token Standards, aMM Curves & Web3 Transitions
#

ConsensusMechanism "ProofOfWork" | "ProofOfStake" | "DelegatedProofOfStake" | "ProofOfAuthority" | "ProofOfHistory" | "PBFT" | "Tendermint" | "DAG-Avalanche"
VmEnvironment      "EVM" | "SVM-Solana" | "MoveVM" | "CosmWasm" | "CairoVM" | "FuelVM" | "BitcoinScript"

AbiParameter {
  Name         String
  SolidityType String
  Indexed      Bool
}

AbiFunction {
  Name            String
  StateMutability "pure" | "view" | "nonpayable" | "payable"
  Inputs          List(AbiParameter)
  Outputs         List(AbiParameter)
}

TokenStandard "ERC-20" | "ERC-721" | "ERC-1155" | "ERC-4626" | "SPL-Token" | "BRC-20" | "Jetton"

NftAttribute {
  TraitType String
  Value     String | Float
}

AmmCurveType     "ConstantProductXYK" | "StableSwapCurve" | "ConcentratedLiquidityV3" | "WeightedBalancer"
RollupKind       "OptimisticRollup" | "ZkRollup" | "Validium" | "Volition" | "Sidechain"
DaoProposalState "Pending" | "Active" | "Canceled" | "Defeated" | "Succeeded" | "Queued" | "Expired" | "Executed"

SwapConstantProduct(pool LiquidityPool, amountInA Float) [
  AmountOutB ((Pool.ReserveB * AmountInA) / (Pool.ReserveA + AmountInA))
  Pool & {
    ReserveA (Pool.ReserveA + AmountInA)
    ReserveB (Pool.ReserveB - AmountOutB)
  }
]

TransferNft(nft NonFungibleToken, newOwner WalletAddress) [
  Nft & { Owner NewOwner }
]

ExecuteDaoProposal(prop DaoProposal & { State "Succeeded" }) [
  Prop & { State "Executed" }
]
