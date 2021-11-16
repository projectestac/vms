#!/usr/bin/env bash

rm /git/odissea/dump/odissea-pg.sql
pg_dump -U postgres -h localhost odissea -O -x >> /git/odissea/dump/odissea-pg.sql

pushd /dades/data
tar czfp /git/odissea/dump/odisseadata.tar.gz *
popd
