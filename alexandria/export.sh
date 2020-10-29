#!/usr/bin/env bash

rm /git/alexandria/alexandria-38-pg.sql
pg_dump -U postgres -h localhost alexandria -O -x >> /git/alexandria/alexandria-38-pg.sql

pushd /dades/data
tar czfp /git/alexandria/alexandriadata.tar.gz *
popd
