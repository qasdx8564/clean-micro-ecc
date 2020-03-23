implementation module MicroECC

import StdEnv
import StdMaybe
import System._Pointer
import System._Posix
import qualified _MicroECC

:: Curve :== Int

secp160r1 :: !*e -> (Curve, !*e)
secp160r1 w = '_MicroECC'.secp160r1 w

secp192r1 :: !*e -> (Curve, !*e)
secp192r1 w = '_MicroECC'.secp192r1 w

secp224r1 :: !*e -> (Curve, !*e)
secp224r1 w = '_MicroECC'.secp224r1 w

secp256r1 :: !*e -> (Curve, !*e)
secp256r1 w = '_MicroECC'.secp256r1 w

secp256k1 :: !*e -> (Curve, !*e)
secp256k1 w = '_MicroECC'.secp256k1 w

makeKey :: !Curve !*e -> (Maybe (String, String), !*e)
makeKey c w
	# (pubs, w) = '_MicroECC'.curve_public_key_size c w
	# (pris, w) = '_MicroECC'.curve_private_key_size c w
	# (bufpub, w) = mallocSt pubs w
	# (bufpri, w) = mallocSt pris w
	# (ok, w) = '_MicroECC'.make_key bufpub bufpri c w
	| ok == 0 = (Nothing, freeSt bufpub (freeSt bufpri w))
	# (pub, bufpub) = readP (flip derefCharArray pubs) bufpub
	# (pri, bufpri) = readP (flip derefCharArray pris) bufpri
	# w = freeSt bufpub (freeSt bufpri w)
	= (Just (pub, pri), w)

sharedSecret :: !String !String !Curve !*e -> (Maybe String, !*e)
sharedSecret pub pri c w
	# (pris, w) = '_MicroECC'.curve_private_key_size c w
	# (bufsec, w) = mallocSt pris w
	# (ok, w) = '_MicroECC'.shared_secret pub pri bufsec c w
	| ok == 0 = (Nothing, freeSt bufsec w)
	# (sec, bufsec) = readP (flip derefCharArray pris) bufsec
	# w = freeSt bufsec w
	= (Just sec, w)

validPublicKey :: !String !Curve !*e -> (Bool, !*e)
validPublicKey s c w
	# (ok, w) = '_MicroECC'.valid_public_key s c w
	= (ok == 1, w)

computePublicKey :: !String !Curve !*e -> (Maybe String, !*e)
computePublicKey pri c w
	# (pubs, w) = '_MicroECC'.curve_public_key_size c w
	# (bufpub, w) = mallocSt pubs w
	# (ok, w) = '_MicroECC'.compute_public_key pri bufpub c w
	| ok == 0 = (Nothing, freeSt bufpub w)
	# (pub, bufpub) = readP (flip derefCharArray pubs) bufpub
	# w = freeSt bufpub w
	= (Just pub, w)

ECCSign :: !String !String !Curve !*e -> (Maybe String, !*e)
ECCSign pri hash c w
	# (pubs, w) = '_MicroECC'.curve_public_key_size c w
	# (bufsig, w) = mallocSt pubs w
	# (ok, w) = '_MicroECC'.sign pri hash (size hash) bufsig c w
	| ok == 0 = (Nothing, freeSt bufsig w)
	# (sig, bufsig) = readP (flip derefCharArray pubs) bufsig
	# w = freeSt bufsig w
	= (Just sig, w)

verify :: !String !String !String !Curve !*e -> (!Bool, !*e)
verify pub hash sig c w
	# (ok, w) = '_MicroECC'.verify pub hash (size hash) sig c w
	= (ok == 1, w)
