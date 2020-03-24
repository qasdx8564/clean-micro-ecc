module testECDSA

import StdEnv, StdMaybe
import MicroECC
import System._Posix

bail rc msg io w = exit rc (snd (fclose (io <<< msg) w))

testCurve 0 curvefun (io, w) = (io <<< "\n", w)
testCurve i curvefun (io, w)
	# (ok, io) = fflush io
	| not ok
		= bail 1 "Failed to flush\n" io w
	# io = io <<< "."
	# (curve, w) = curvefun w
	# (mkey, w) = makeKey curve w
	| isNothing mkey
		= bail 1 "Failed to make key\n" io w
	# (Just (pub1, pri1)) = mkey
	# hash = pub1
	# (msig, w) = ECCSign pri1 hash curve w
	| isNothing msig
		= bail 1 "Failed to make the signature\n" io w
	# (Just sig) = msig
	# (ok, w) = verify pub1 hash sig curve w
	| not ok
		= bail 1 "Failed to verify hash\n" io w
	= testCurve (i-1) curvefun (io, w)

Start w
	# (io, w) = stdio w
	# io = io <<< "Testing 256 random private key pairs\n"
	# (io, w) = foldr (testCurve 256) (io, w) [secp160r1, secp192r1, secp224r1, secp256r1, secp256k1]
	= bail 0 "\n" io w
