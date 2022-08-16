SOURCES += \
    $$PWD/os_posix.c \
    $$PWD/os_win32.c \
    $$PWD/netsdk.c \
    $$PWD/os_android.c \
    $$PWD/netsdk_socket.c \
    $$PWD/netsdk_map.c \
    $$PWD/netsdk_message.c \
    $$PWD/netsdk_buffer.c \
    $$PWD/rbtree.c \
    $$PWD/netsdk_mm_internal.c

win32 {
    SOURCES += $$PWD/netudpsdk.c
}


HEADERS += \
    $$PWD/os_api.h \
    $$PWD/netsdk.h \
    $$PWD/netsdk_socket.h \
    $$PWD/netsdk_error.h \
    $$PWD/netsdk_map.h \
    $$PWD/netsdk_message.h \
    $$PWD/netsdk_buffer.h \
    $$PWD/rbtree_augmented.h \
    $$PWD/netsdk_mm_internal.h
win32 {
    HEADERS += $$PWD/netudpsdk.h
}
