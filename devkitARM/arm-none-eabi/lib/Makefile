include $(DEVKITARM)/base_rules

all:
	$(CC)  -x assembler-with-cpp -marm -c $(CRT)_crt0.s -o$(CRT)_crt0.o
	$(CC)  -x assembler-with-cpp -mthumb -c $(CRT)_crt0.s -o thumb/$(CRT)_crt0.o
