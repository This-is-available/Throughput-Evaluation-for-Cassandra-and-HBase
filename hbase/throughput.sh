script_path=$(cd "$(dirname "$0")" && pwd)
echo "script_path: $script_path"
~/hbase-2.4.0/bin/start-hbase.sh
sleep 2
echo "#### checking the status of hbase cluster:"
echo "status" | ~/hbase-2.4.0/bin/hbase shell
echo "#### creating test data"
~/hbase-2.4.0/bin/hbase shell ~/YCSB/hbase10/create.txt
echo "#### loading data, check results in the following terminal context"
cd ~/YCSB && python2 bin/ycsb load hbase10 -P workloads/workloada -P large.dat -s -cp ~/hbase/conf -p table=usertable -p columnfamily=family
echo "#### running workloads/workloada, check ~/YCSB/load.dat for detailed result"
cd ~/YCSB && python2 bin/ycsb run hbase10 -P workloads/workloada -P large.dat -s -cp ~/hbase/conf -p table=usertable -p columnfamily=family > load.dat
echo "#### running workload_mixed, check ~/YCSB/hbase_mixed.dat for detailed result"
cd ~/YCSB && python2 bin/ycsb run hbase10 -P "${script_path}/../workload_mixed" -P large.dat -s -cp ~/hbase/conf -p table=usertable -p columnfamily=family > hbase_mixed.dat
# echo "#### running workloads/workload_rdonly, check ~/YCSB/hbase_rdonly.dat for detailed result"
# cd ~/YCSB && python2 bin/ycsb run hbase10 -P workloads/workload_rdonly -P large.dat -s -cp ~/hbase/conf -p table=usertable -p columnfamily=family > hbase_rdonly.dat
# echo "#### running workloads/workload_wronly, check ~/YCSB/hbase_wronly.dat for detailed result"
# cd ~/YCSB && python2 bin/ycsb run hbase10 -P workloads/workload_wronly -P large.dat -s -cp ~/hbase/conf -p table=usertable -p columnfamily=family > hbase_wronly.dat
echo "#### throughput experiments ended"