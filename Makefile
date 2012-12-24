.POSIX:

CC=musl-gcc
CFLAGS+=-D_BSD_SOURCE -D_XOPEN_SOURCE=600 -I. -I./rpc -DRPC_OFFSET=0
OBJS=clnt.o ops.o rpc.o svc_clnt_common.o svc.o xdr.o
SOOBJS=clnt.lo ops.lo rpc.lo svc_clnt_common.lo svc.lo xdr.lo
PREFIX?=/usr/local
INCDIR?=${PREFIX}/include/drpc
LIBDIR?=${PREFIX}/lib
SYSLIBDIR?=${LIBDIR}


all:	libdrpc.a libdrpc.so 

install: inst-sh inst-static insthdr

insthdr:
	[ -d ${DESTDIR}${INCDIR}/ ] || mkdir -p ${DESTDIR}${INCDIR}/
	cp -R ./rpc/ ${DESTDIR}${INCDIR}/

inst-static: libdrpc.a
	[ -d ${DESTDIR}${LIBDIR}/ ] || mkdir -p ${DESTDIR}${LIBDIR}/
	cp libdrpc.a ${DESTDIR}${LIBDIR}/
	
inst-sh: libdrpc.so
	[ -d ${DESTDIR}${SYSLIBDIR}/ ] || mkdir -p ${DESTDIR}${SYSLIBDIR}/
	cp -P libdrpc.so* ${DESTDIR}${SYSLIBDIR}/
	
libdrpc.a: ${OBJS}
	ar rc  $@ ${OBJS}
	
.c.o:
	${CC} ${CFLAGS} -c $<

libdrpc.so: ${SOOBJS}
	${CC} -shared -Wl,-soname,$@.0 -o $@.0 ${SOOBJS}
	ln -s $@.0 $@

%.lo: %.c
	${CC} ${CFLAGS} -fPIC -c -o $@ $<

clobber:
	rm -f *.o *.lo

clean:	clobber
	rm -f *.a *.so*

