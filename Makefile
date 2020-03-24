PKGNAME:=MicroECC
LIBNAME:=clean-lib-$(shell echo $(PKGNAME) | tr '[:upper:]' '[:lower:]')
CLEAN_HOME?=/opt/clean

src/Clean\ System\ Files/uECC.o: micro-ecc/uECC.c
	$(LINK.o) -c $< $(LOADLIBES) $(LDLIBS) -o "$@"

cdeps: src/Clean\ System\ Files/uECC.o

%-package: cdeps
	$(RM) -r $*/lib/$(PKGNAME)
	mkdir -p $*/lib/$(PKGNAME)/Clean\ System\ Files
	cp -v src/*.[id]cl $*/lib/$(PKGNAME)
	cp -v src/Clean\ System\ Files/uECC.o $*/lib/$(PKGNAME)/Clean\ System\ Files/

install: $(CLEAN_HOME)-package

package: $(LIBNAME)-package
	tar -cvzf $(LIBNAME).tar.gz $(LIBNAME)
	$(RM) -r $(LIBNAME)

clean:
	$(RM) src/Clean\ System\ Files/uECC.o $(LIBNAME).tar.gz
	$(MAKE) -C examples clean
	$(MAKE) -C tests clean
