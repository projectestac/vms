#!/usr/bin/env bash

rm /git/odissea/odissea-38-pg.sql
pg_dump -U postgres -h localhost odissea -O -x >> /git/odissea/odissea-38-pg.sql

pushd /dades/data
tar czfp /git/odissea/odisseadata.tar.gz *
popd
