
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
#export ORACLE_HOME=/usr/lib/oracle/12.1/client64
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export ORACLE_BASE=/u01/app/oracle
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib/:$LD_LIBRARY_PATH

#export NLS_LANG=SPANISH_SPAIN.AL32UTF8
export NLS_CHARACTERSET=AL32UTF8
export NLS_NUMERIC_CHARACTERS='.,'
export TNS_ADMIN=$ORACLE_HOME/network/admin


