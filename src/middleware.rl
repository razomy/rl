#
Cryptography Operations, auth Middleware & Account Classification
#

HashAlgorithm   "sha256" | "sha512" | "sha3-256" | "blake3" | "argon2id" | "bcrypt" | "scrypt" | "pbkdf2"
CipherAlgorithm "aes-256-gcm" | "aes-128-gcm" | "chacha20-poly1305" | "xchacha20-poly1305" | "rsa-oaep"
SignatureScheme "ed25519" | "ecdsa-secp256k1" | "ecdsa-p256" | "rsa-pss" | "bls12-381" | "ml-dsa-dilithium"

Crypto {
  Hash(data String, alg HashAlgorithm)                    [ (Data, Alg) . native_crypto_hash ]
  VerifyHash(data String, hash String)                    [ (Data, Hash) . native_crypto_verify ]
  Hmac(key String, data String)                           [ (Key, Data) . native_crypto_hmac ]
  Encrypt(key String, plain String, alg CipherAlgorithm)  [ (Key, Plain, Alg) . native_crypto_encrypt ]
  Decrypt(key String, cipher String, alg CipherAlgorithm) [ (Key, Cipher, Alg) . native_crypto_decrypt ]
  RandomBytes(count Int)                                  [ Count . native_crypto_random_bytes ]
  RandomUuid()                                            [ native_crypto_uuid ]
}

AuthMiddleware(Req) [
  Req.Headers . Map.Get("Authorization") . {
    Some [ Req & { AuthUser (Value . Db.FindUserByToken) } ]
    None [ Unauthorized { Reason "Missing Authorization Header" } ]
  }
]

ClassifyAccount(Account) [
  Account . {
    Manager [ "Dashboard: {Name}" . Shell.Log ]
    Adult   [ "Adult account: {Name}" . Shell.Log ]
    Minor   [ "Child account: {Name}" . Shell.Log ]
    _       [ "Unknown profile" . Shell.Log ]
  }
]

ClientAccount {
  AccountId String
  Name      String
  IsAdult   Bool
}

MigrateUser(u User) [
  ClientAccount {
    AccountId Id
    IsAdult   (Age >= 18)
  }
]
