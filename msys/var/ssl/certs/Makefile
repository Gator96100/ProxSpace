UTF8 := $(shell locale -c LC_CTYPE -k | grep -q charmap.*UTF-8 && echo -utf8)
SERIAL=0

.PHONY: usage
.SUFFIXES: .key .csr .crt .pem
.PRECIOUS: %.key %.csr %.crt %.pem

usage:
	@echo "This makefile allows you to create:"
	@echo "  o public/private key pairs"
	@echo "  o SSL certificate signing requests (CSRs)"
	@echo "  o self-signed SSL test certificates"
	@echo
	@echo "To create a key pair, run \"make SOMETHING.key\"."
	@echo "To create a CSR, run \"make SOMETHING.csr\"."
	@echo "To create a test certificate, run \"make SOMETHING.crt\"."
	@echo "To create a key and a test certificate in one file, run \"make SOMETHING.pem\"."
	@echo
	@echo "To create a key for use with Apache, run \"make genkey\"."
	@echo "To create a CSR for use with Apache, run \"make certreq\"."
	@echo "To create a test certificate for use with Apache, run \"make testcert\"."
	@echo
	@echo "To create a test certificate with serial number other than zero, add SERIAL=num"
	@echo
	@echo Examples:
	@echo "  make server.key"
	@echo "  make server.csr"
	@echo "  make server.crt"
	@echo "  make stunnel.pem"
	@echo "  make genkey"
	@echo "  make certreq"
	@echo "  make testcert"
	@echo "  make server.crt SERIAL=1"
	@echo "  make stunnel.pem SERIAL=2"
	@echo "  make testcert SERIAL=3"

%.pem:
	umask 77 ; \
	PEM1=`/bin/mktemp /tmp/openssl.XXXXXX` ; \
	PEM2=`/bin/mktemp /tmp/openssl.XXXXXX` ; \
	/usr/bin/openssl req $(UTF8) -newkey rsa:1024 -keyout $$PEM1 -nodes -x509 -days 365 -out $$PEM2 -set_serial $(SERIAL) ; \
	cat $$PEM1 >  $@ ; \
	echo ""    >> $@ ; \
	cat $$PEM2 >> $@ ; \
	$(RM) $$PEM1 $$PEM2

%.key:
	umask 77 ; \
	/usr/bin/openssl genrsa -des3 1024 > $@

%.csr: %.key
	umask 77 ; \
	/usr/bin/openssl req $(UTF8) -new -key $^ -out $@

%.crt: %.key
	umask 77 ; \
	/usr/bin/openssl req $(UTF8) -new -key $^ -x509 -days 365 -out $@ -set_serial $(SERIAL)

TLSROOT=/var/ssl
KEY=$(TLSROOT)/private/localhost.key
CSR=$(TLSROOT)/certs/localhost.csr
CRT=$(TLSROOT)/certs/localhost.crt

genkey: $(KEY)
certreq: $(CSR)
testcert: $(CRT)

$(CSR): $(KEY)
	umask 77 ; \
	/usr/bin/openssl req $(UTF8) -new -key $(KEY) -out $(CSR)

$(CRT): $(KEY)
	umask 77 ; \
	/usr/bin/openssl req $(UTF8) -new -key $(KEY) -x509 -days 365 -out $(CRT) -set_serial $(SERIAL)
