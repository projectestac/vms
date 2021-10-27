#!/usr/bin/env bash

rm /git/alexandria/dump/alexandria-pg.sql
pg_dump -U postgres -h localhost alexandria -O -x >> /git/alexandria/dump/alexandria-pg.sql

pushd /dades/data
rm /git/alexandria/dump/alexandriadata.tar.gz
tar czfp /git/alexandria/dump/alexandriadata.tar.gz *
popd
