CPM?=cpm
TARGETS=testECDH testECDSA testCompress

.SECONDARY: $(addsuffix .prj,$(TARGETS))

all: $(TARGETS)

%.prj: %.icl
	$(CPM) project $@ create
	$(CPM) project $@ path add $(CLEAN_HOME)/lib/Platform
	$(CPM) project $@ path add ../src

%: %.prj
	$(CPM) project $< build

test: $(TARGETS)
	./testECDH
	./testECDSA
	./testCompress

clean:
	$(RM) -r Clean\ System\ Files $(TARGETS) *.prj
