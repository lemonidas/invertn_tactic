all: Makefile.coq 
	$(MAKE) -f Makefile.coq 

Makefile.coq: _CoqProject
	$(V)coq_makefile -f _CoqProject -o Makefile.coq

clean:
	rm *.d
	rm *.o 
	rm *.cmi
	rm *.cmo
	rm *.cmxs
	rm *.cmx
	rm -f Makefile.coq
