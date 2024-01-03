~/hbase-2.4.0/bin/hbase-daemon.sh stop master
~/hbase-2.4.0/bin/stop-hbase.sh
~/hadoop_for_hbase/hadoop-3.2.2-src/hadoop-dist/target/hadoop-3.2.2/bin/hdfs dfs -rm -r /hbase
rm -r ~/hbase-2.4.0/dataDir
echo "wait 30s for region server to go down"
sleep 30