INCLUDEPATH += $$PWD


HEADERS += $$PWD/app.h \
    $$PWD/avmerge.h \
    $$PWD/bitstream.h \
    $$PWD/mp3topcm.h \
    $$PWD/pcm2aac.h \
    $$PWD/adpcm.h


SOURCES += $$PWD/avmerge.cpp \
    $$PWD/pcm2aac.cpp \
    $$PWD/bitstream.c \
    $$PWD/mp3topcm.c \
    $$PWD/adpcm.c
