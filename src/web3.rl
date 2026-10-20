#
Abstract Blockchain Network, Block, Transaction, Smart Contract, Token, DeFi Pool & DAO
#

WalletAddress HexStr
TxHash        HexStr
BlockHash     HexStr
Wei           Bigint
Gwei          Bigint

BlockchainNetwork {
  Name           String
  ChainId        Int
  NativeCurrency CurrencyCode
  Consensus      ConsensusMechanism
  Vm             VmEnvironment
  BlockTimeMs    Int
  IsTestnet      Bool
  RpcEndpoint    Url
  ExplorerUrl    Url
}

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

FungibleToken {
  ContractAddress WalletAddress
  Standard        TokenStandard
  Name            String
  Symbol          String
  Decimals        Range(0, 18) & Int
  TotalSupply     Bigint
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
  User             WalletAddress
  CollateralToken  FungibleToken
  CollateralAmount Float
  BorrowedToken    FungibleToken
  BorrowedAmount   Float
  LiquidationRatio Float
  HealthFactor     Float
}

PriceOracleFeed {
  PairSymbol    String
  OracleAddress WalletAddress
  Price         Float
  Decimals      Int
  RoundId       Int
  UpdatedAt     Instant
}

DaoProposal {
  ProposalId     Int
  Proposer       WalletAddress
  Title          String
  Description    String
  TargetCalldata List(HexStr)
  ForVotes       Float
  AgainstVotes   Float
  AbstainVotes   Float
  QuorumRequired Float
  State          DaoProposalState
  EndBlock       Int
}
