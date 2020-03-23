definition module MicroECC

from StdMaybe import :: Maybe

:: Curve (:== Int)

/**
 * Generate a specific curve
 */
secp160r1 :: !*e -> (Curve, !*e)
secp192r1 :: !*e -> (Curve, !*e)
secp224r1 :: !*e -> (Curve, !*e)
secp256r1 :: !*e -> (Curve, !*e)
secp256k1 :: !*e -> (Curve, !*e)

/**
 * Create a key (public, private) for a given curve
 * @param curve
 * @param env
 * @result public and private key if successful
 */
makeKey :: !Curve !*e -> (Maybe (String, String), !*e)

/**
 * Compute a shared secret
 * @param public key of the remote party
 * @param your private key
 * @param curve
 * @result secret if successful
 */
sharedSecret :: !String !String !Curve !*e -> (Maybe String, !*e)

/**
 * Unsure whether to implement this:
 */
//decompress :: !UInt8_tP !UInt8_tP !Curve !*e -> *e
//compress :: !UInt8_tP !UInt8_tP !Curve !*e -> *e

/**
 * Verify a public key
 *
 * @param public key
 * @param curve
 * @result public key is valid
 */
validPublicKey :: !String !Curve !*e -> (Bool, !*e)

/**
 * Compute the public key
 * 
 * @param private key
 * @param curve
 * @result public key if successful
 */
computePublicKey :: !String !Curve !*e -> (Maybe String, !*e)

/**
 * Sign given a hash value
 *
 * @param private key
 * @param hash
 * @param curve
 * @result signature if successful
 */
ECCSign :: !String !String !Curve !*e -> (Maybe String, !*e)

/**
 * Unsure whether to implement this:
 */
//sign_deterministic :: !UInt8_tP !UInt8_tP !Int !Curve !Pointer !Curve !*e -> (!Int, !*e)

/**
 * Verify an ECDSA signature
 *
 * @param public key
 * @param hash
 * @param signature
 * @param curve
 * @result signature is valid
 */
verify :: !String !String !String !Curve !*e -> (!Bool, !*e)
