# clean-micro-ecc

Clean bindings for MicroECC

## How to install
After you have made sure you have a correct `CLEAN_HOME` variable and checked out the submodules, run:

    make install

## Documentation
The [MicroECC.dcl](src/MicroECC.dcl) contains all the functions and is documented.

Direct access to the C library is achieved by [\_MicroECC.dcl](src/_MicroECC.dcl) but this is cumbersome and unsafe and should be avoided

## License
See [LICENSE](LICENSE)

## Author
Mart Lubbers (mart@cs.ru.nl)
