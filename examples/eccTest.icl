module eccTest

import StdEnv, StdMaybe
import MicroECC

bail msg io w = snd (fclose (io <<< msg) w)

Start w
	# (io, w) = stdio w
	# io = io <<< "Testing ecc\n"
	# (curve, w) = secp160r1 w
	# (mkey, w) = makeKey curve w
	| isNothing mkey = bail "Failed to makeKey 1\n" io w
	# (Just (pub1, pri1)) = mkey
	# (mkey, w) = makeKey curve w
	| isNothing mkey = bail "Failed to makeKey 2\n" io w
	# (Just (pub2, pri2)) = mkey
	# (msec, w) = sharedSecret pub1 pri1 curve w
	| isNothing mkey = bail "Failed to makeSecret 1\n" io w
	# (Just sec1) = msec
	# (msec, w) = sharedSecret pub2 pri2 curve w
	| isNothing mkey = bail "Failed to makeSecret 2\n" io w
	# (Just sec2) = msec
	= bail ("Shared secrets are " +++ toString (sec1 == sec2) +++ " identical\n") io w
