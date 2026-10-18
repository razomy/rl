_ primitive
_ primitive
_ structure
_ string
_ time
_ economy
_ security

#
1. Blockchain Networks, Consensus & Cryptography
#

ConsensusMechanism "ProofOfWork" | "ProofOfStake" | "DelegatedProofOfStake" | "ProofOfAuthority" | "ProofOfHistory" | "PBFT" | "Tendermint" | "DAG-Avalanche"
VmEnvironment "EVM" | "SVM-Solana" | "MoveVM" | "CosmWasm" | "CairoVM" | "FuelVM" | "BitcoinScript"

BlockchainNetwork {
  Name            String
  ChainId         Int
  NativeCurrency  CurrencyCode
  Consensus       ConsensusMechanism
  Vm              VmEnvironment
  BlockTimeMs     Int
  IsTestnet       Bool
  RpcEndpoint     Url
  ExplorerUrl     Url
}

WalletAddress HexStr
TxHash        HexStr
BlockHash     HexStr
Wei           Bigint
Gwei          Bigint

#
2. Blocks, Transactions, Gas & Mempool
#

BlockHeader {
  BlockNumber      Int
  BlockHash        BlockHash
  ParentHash       BlockHash
  StateRoot        HexStr
  TransactionsRoot HexStr
  ReceiptsRoot     HexStr
  ProposerAddress  WalletAddress
  Timestamp        Instant
  GasLimit         Int
  GasUsed          Int
  BaseFeePerGas    Wei
}

OnChainTxStatus "MempoolPending" | "IncludedInBlock" | "Finalized" | "Reverted" | "Dropped"

OnChainTransaction {
  Hash                 TxHash
  ChainId              Int
  Nonce                Int
  From                 WalletAddress
  To                   Option(WalletAddress)
  Value                Wei
  InputCalldata        HexStr
  GasLimit             Int
  MaxFeePerGas         Wei
  MaxPriorityFeePerGas Wei
  Signature            DigitalSignature
  Status               OnChainTxStatus
  BlockNumber          Option(Int)
}

Block {
  Header       BlockHeader
  Transactions List(OnChainTransaction)
}

#
3. Smart Contracts & Token Standards (ERC-20, ERC-721, ERC-1155)
#

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

SmartContract {
  Address      WalletAddress
  ChainId      Int
  Bytecode     HexStr
  Abi          List(AbiFunction)
  Deployer     WalletAddress
  DeployedAtTx TxHash
  IsVerified   Bool
  IsProxy      Bool
}

TokenStandard "ERC-20" | "ERC-721" | "ERC-1155" | "ERC-4626" | "SPL-Token" | "BRC-20" | "Jetton"

FungibleToken {
  ContractAddress WalletAddress
  Standard        TokenStandard
  Name            String
  Symbol          String
  Decimals        Range(0, 18) & Int
  TotalSupply     Bigint
}

NftAttribute {
  TraitType String
  Value     String | Float
}

NonFungibleToken {
  ContractAddress WalletAddress
  Standard        "ERC-721" | "ERC-1155"
  TokenId         Bigint
  Owner           WalletAddress
  Creator         WalletAddress
  MetadataUri     String
  ImageUri        String
  Attributes      List(NftAttribute)
  RoyaltyBps      Range(0, 10000) & Int
}

#
4. Decentralized Finance (DeFi): AMM Pools, Lending, Oracles & Bridges
#

AmmCurveType "ConstantProductXYK" | "StableSwapCurve" | "ConcentratedLiquidityV3" | "WeightedBalancer"

LiquidityPool {
  PoolAddress   WalletAddress
  CurveType     AmmCurveType
  TokenA        FungibleToken
  TokenB        FungibleToken
  ReserveA      Float
  ReserveB      Float
  SwapFeeBps    Int
  TotalLpSupply Float
}

LendingPosition {
  User              WalletAddress
  CollateralToken   FungibleToken
  CollateralAmount  Float
  BorrowedToken     FungibleToken
  BorrowedAmount    Float
  LiquidationRatio  Float
  HealthFactor      Float
}

PriceOracleFeed {
  PairSymbol    String
  OracleAddress WalletAddress
  Price         Float
  Decimals      Int
  RoundId       Int
  UpdatedAt     Instant
}

#
5. Decentralized Autonomous Organizations (DAO) & Layer-2 Rollups
#

RollupKind "OptimisticRollup" | "ZkRollup" | "Validium" | "Volition" | "Sidechain"

DaoProposalState "Pending" | "Active" | "Canceled" | "Defeated" | "Succeeded" | "Queued" | "Expired" | "Executed"

DaoProposal {
  ProposalId    Int
  Proposer      WalletAddress
  Title         String
  Description   String
  TargetCalldata List(HexStr)
  ForVotes      Float
  AgainstVotes  Float
  AbstainVotes  Float
  QuorumRequired Float
  State         DaoProposalState
  EndBlock      Int
}

#
6. Web3 Transitions
#

SwapConstantProduct(Pool LiquidityPool, AmountInA Float) [
  AmountOutB ((Pool.ReserveB * AmountInA) / (Pool.ReserveA + AmountInA))
  Pool & {
    ReserveA (Pool.ReserveA + AmountInA)
    ReserveB (Pool.ReserveB - AmountOutB)
  }
]

TransferNft(Nft NonFungibleToken, NewOwner WalletAddress) [
  Nft & { Owner NewOwner }
]

ExecuteDaoProposal(Prop DaoProposal & { State "Succeeded" }) [
  Prop & { State "Executed" }
]
