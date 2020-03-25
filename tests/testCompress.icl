module testCompress

import StdEnv, StdMaybe
import MicroECC
import System._Posix

bail rc msg io w = exit rc (snd (fclose (io <<< msg) w))

testCurve 0 curvefun (io, w) = (io <<< "\n", w)
testCurve i curvefun (io, w)
	#! (ok, io) = fflush io
	| not ok
		= bail 1 "Failed to flush\n" io w
	#! io = io <<< "."
	#! (curve, w) = curvefun w
	#! (mkey, w) = makeKey curve w
	| isNothing mkey
		= bail 1 "Failed to make key\n" io w
	#! (Just (pub, _)) = mkey
	#! (cpub, w) = compress pub curve w
	#! (npub, w) = decompress cpub curve w
	| pub <> npub
		= (testCurve (i-1) curvefun (io <<< "Compression is not transparent!\n", w))
	= testCurve (i-1) curvefun (io, w)

print s = foldr (+++) "" [toString (toInt c) +++ " " \\c<-:s]

Start w
	#! (io, w) = stdio w
	#! io = io <<< "Testing compression and decompression\n"
	#! (io, w) = foldr (testCurve 256) (io, w) [secp160r1, secp192r1, secp224r1, secp256r1, secp256k1]
	= bail 0 "\n" io w
