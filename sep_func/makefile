program: main.o area.o
	ld -m elf_i386 $^ -o $@

main.o: main.s
	as --32 $^ -o $@ -gstabs

area.o: area.s
	as --32 $^ -o $@ -gstabs

.PHONY: clean
clean:
	rm  *.o program
