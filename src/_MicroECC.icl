implementation module _MicroECC

import System._Pointer

import code from "uECC.o"

secp160r1 :: !*e -> (!Pointer, !*e)
secp160r1 _ = code {
	ccall uECC_secp160r1 ":p:A"
}

secp192r1 :: !*e -> (!Pointer, !*e)
secp192r1 _ = code {
	ccall uECC_secp192r1 ":p:A"
}

secp224r1 :: !*e -> (!Pointer, !*e)
secp224r1 _ = code {
	ccall uECC_secp224r1 ":p:A"
}

secp256r1 :: !*e -> (!Pointer, !*e)
secp256r1 _ = code {
	ccall uECC_secp256r1 ":p:A"
}

secp256k1 :: !*e -> (!Pointer, !*e)
secp256k1 _ = code {
	ccall uECC_secp256k1 ":p:A"
}

set_rng :: !Pointer !*e -> *e
set_rng _ _ = code {
		ccall uECC_set_rng "p:V:A"
	}

get_rng :: !*e -> (!Pointer, !*e)
get_rng _ = code {
		ccall uECC_get_rng ":p:A"
	}

curve_private_key_size :: !Curve !*e -> (!Int, !*e)
curve_private_key_size _ _ = code {
		ccall uECC_curve_private_key_size "p:I:A"
	}

curve_public_key_size :: !Curve !*e -> (!Int, !*e)
curve_public_key_size _ _ = code {
		ccall uECC_curve_public_key_size "p:I:A"
	}

make_key :: !UInt8_tP !UInt8_tP !Curve !*e -> (!Int, !*e)
make_key _ _ _ _ = code {
		ccall uECC_make_key "ppp:I:A"
	}

shared_secret :: !String !String !UInt8_tP !Curve !*e -> (!Int, !*e)
shared_secret _ _ _ _ _ = code {
		ccall uECC_shared_secret "sspp:I:A"
	}

decompress :: !String !UInt8_tP !Curve !*e -> *e
decompress _ _ _ _ = code {
		ccall uECC_decompress "spp:V:A"
	}

compress :: !String !UInt8_tP !Curve !*e -> *e
compress _ _ _ _ = code {
		ccall uECC_compress "spp:V:A"
	}

valid_public_key :: !String !Curve !*e -> (!Int, !*e)
valid_public_key _ _ _ = code {
		ccall uECC_valid_public_key "sp:I:A"
	}

compute_public_key :: !String !UInt8_tP !Curve !*e -> (!Int, !*e)
compute_public_key _ _ _ _ = code {
		ccall uECC_compute_public_key "spp:I:A"
	}

sign :: !String !String !Int !UInt8_tP !Curve !*e -> (!Int, !*e)
sign _ _ _ _ _ _ = code {
		ccall uECC_sign "ssIpp:I:A"
	}
sign_deterministic :: !String !String !Int !Curve !Pointer !Pointer !*e -> (!Int, !*e)
sign_deterministic _ _ _ _ _ _ _ = code {
		ccall uECC_sign_deterministic "ssIppp:I:A"
	}

verify :: !String !String !Int !String !Curve !*e -> (!Int, !*e)
verify _ _ _ _ _ _ = code {
		ccall uECC_verify "ssIsp:I:A"
	}
