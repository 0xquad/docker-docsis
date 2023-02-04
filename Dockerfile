FROM alpine AS builder
RUN apk add --no-cache build-base libtool automake autoconf flex bison glib-dev net-snmp-dev
RUN wget -q https://github.com/rlaager/docsis/archive/refs/heads/master.zip && \
    unzip master.zip && rm -f master.zip
WORKDIR /docsis-master
RUN ./autogen.sh && make


FROM alpine
RUN apk add --no-cache net-snmp-dev
COPY --from=builder /docsis-master/src/docsis /usr/local/bin
COPY --from=builder /docsis-master/examples /usr/local/share/docsis
ENTRYPOINT /usr/local/bin/docsis
