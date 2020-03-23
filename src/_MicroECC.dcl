definition module _MicroECC

from System._Pointer import :: Pointer

:: Curve :== Pointer
:: UInt8_tP :== Pointer

secp160r1 :: !*e -> (!Pointer, !*e)
secp192r1 :: !*e -> (!Pointer, !*e)
secp224r1 :: !*e -> (!Pointer, !*e)
secp256r1 :: !*e -> (!Pointer, !*e)
secp256k1 :: !*e -> (!Pointer, !*e)

set_rng :: !Pointer !*e -> *e
get_rng :: !*e -> (!Pointer, !*e)
curve_private_key_size :: !Curve !*e -> (!Int, !*e)
curve_public_key_size :: !Curve !*e -> (!Int, !*e)
make_key :: !UInt8_tP !UInt8_tP !Curve !*e -> (!Int, !*e)
shared_secret :: !String !String !UInt8_tP !Curve !*e -> (!Int, !*e)
decompress :: !String !UInt8_tP !Curve !*e -> *e
compress :: !String !UInt8_tP !Curve !*e -> *e
valid_public_key :: !String !Curve !*e -> (!Int, !*e)
compute_public_key :: !String !UInt8_tP !Curve !*e -> (!Int, !*e)
sign :: !String !String !Int !UInt8_tP !Curve !*e -> (!Int, !*e)
sign_deterministic :: !String !String !Int !Curve !Pointer !Curve !*e -> (!Int, !*e)
verify :: !String !String !Int !String !Curve !*e -> (!Int, !*e)
