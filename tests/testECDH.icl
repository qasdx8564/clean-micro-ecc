module testECDH

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
	# (mkey, w) = makeKey curve w
	| isNothing mkey
		= bail 1 "Failed to make key\n" io w
	# (Just (pub2, pri2)) = mkey
	# (msec, w) = sharedSecret pub2 pri1 curve w
	| isNothing mkey = bail 1 "Failed to makeSecret 1\n" io w
	# (Just sec1) = msec
	# (msec, w) = sharedSecret pub1 pri2 curve w
	| isNothing mkey = bail 1 "Failed to makeSecret 2\n" io w
	# (Just sec2) = msec
	| sec1 <> sec2
		= (testCurve (i-1) curvefun (io <<< "Shared secrets are not identical!\n", w))
	= testCurve (i-1) curvefun (io, w)

Start w
	# (io, w) = stdio w
	# io = io <<< "Testing 256 random private key pairs\n"
	# (io, w) = foldr (testCurve 256) (io, w) [secp160r1, secp192r1, secp224r1, secp256r1, secp256k1]
	= bail 0 "\n" io w
