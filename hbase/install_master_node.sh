script_path=$(cd "$(dirname "$0")" && pwd)
echo "script_path: $script_path"
cd ~
echo "#### installing hbase-2.4.0 in ~/hbase-2.4.0"
wget https://archive.apache.org/dist/hbase/2.4.0/hbase-2.4.0-src.tar.gz || exit
tar -xzf hbase-2.4.0-src.tar.gz || exit
rm hbase-2.4.0-src.tar.gz
cd ~/hbase-2.4.0 && mvn package -DskipTests
cd "$script_path"
pwd
cp ./hbase-env.sh ./hbase-site.xml ./regionservers ~/hbase-2.4.0/conf/ || exit
echo "#### installing hadoop in ~/hadoop_for_hbase/hadoop-3.2.2-src"
mkdir -p ~/hadoop_for_hbase && cd ~/hadoop_for_hbase
wget https://archive.apache.org/dist/hadoop/common/hadoop-3.2.2/hadoop-3.2.2-src.tar.gz || exit
tar -zxf hadoop-3.2.2-src.tar.gz || exit
rm hadoop-3.2.2-src.tar.gz
cd hadoop-3.2.2-src && mvn package -Pdist -DskipTests -Dtar -Dmaven.javadoc.skip=true
cd "$script_path"
cp ./hdfs-site.xml ./core-site.xml ./hadoop-env.sh ~/hadoop_for_hbase/hadoop-3.2.2-src/hadoop-dist/target/hadoop-3.2.2/etc/hadoop/ || exit
cd ~/hadoop_for_hbase/hadoop-3.2.2-src/hadoop-dist/target/hadoop-3.2.2
echo "#### format namenode and start hadoop service"
./bin/hdfs namenode -format || exit
./sbin/start-dfs.sh || exit
sleep 2
jps
