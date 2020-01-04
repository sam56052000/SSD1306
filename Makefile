CC     = gcc
CFLAGS = -I $(IDIR) -g -Wall
IDIR   = inc
SOURCE = src
ODIR   = obj
LDIR   = lib
LIBS   = -lm
BUILDDIR = build
_DEPS  = ssd1306.h
DEPS   = $(patsubst %,$(IDIR)/%,$(_DEPS))
_OBJ   = example.o ssd1306.o ubuntuMono_8pt.o ubuntuMono_16pt.o ubuntuMono_24pt.o ubuntuMono_48pt.o OLED_Print.o
OBJ    = $(patsubst %,$(ODIR)/%,$(_OBJ))

$(ODIR)/%.o: $(SOURCE)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(BUILDDIR)/OrangePI_ssd1306: $(OBJ)
	gcc -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o $(BUILDDIR)/*~ core $(INCDIR)/*~ 

python_module:
	gcc -shared -fPIC \
	$(SOURCE)/OLED_Print.c \
	$(SOURCE)/ssd1306.c \
	$(SOURCE)/ubuntuMono_8pt.c \
	$(SOURCE)/ubuntuMono_16pt.c \
	$(SOURCE)/ubuntuMono_24pt.c \
	$(SOURCE)/ubuntuMono_48pt.c \
	-o $(BUILDDIR)/oled.so $(CFLAGS) $(LIBS)
