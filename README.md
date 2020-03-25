[![Build Status](https://travis-ci.org/dopefishh/clean-micro-ecc.svg?branch=master)](https://travis-ci.org/dopefishh/clean-micro-ecc)

# clean-micro-ecc

Clean bindings for MicroECC

## How to install

After you have made sure you have a correct `CLEAN_HOME` environment variable and checked out the submodules, run:

    make install

## Documentation

The [src/MicroECC.dcl](src/MicroECC.dcl) contains all the functions and is documented.

Direct access to the C library is achieved by [src/\_MicroECC.dcl](src/_MicroECC.dcl) but this is cumbersome, unsafe, and should be avoided

## License

See [LICENSE](LICENSE)

## Author

Mart Lubbers (mart@cs.ru.nl)
