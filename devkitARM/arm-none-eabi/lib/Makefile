include $(DEVKITARM)/base_rules

all:
	$(CC)  -x assembler-with-cpp -marm -c $(CRT)_crt0.s -o$(CRT)_crt0.o
	$(CC)  -x assembler-with-cpp -mthumb -c $(CRT)_crt0.s -o thumb/$(CRT)_crt0.o

ds_arm7_vram_crt0:
	$(CC)  -x assembler-with-cpp -marm -c -DVRAM ds_arm7_crt0.s -ods_arm7_vram_crt0.o
	$(CC)  -x assembler-with-cpp -mthumb -c -DVRAM ds_arm7_crt0.s -othumb/ds_arm7_vram_crt0.o

3dsx_crt0:
	$(CC) -march=armv6k -mfloat-abi=hard -c 3dsx_crt0.s -o armv6k/fpu/3dsx_crt0.o

