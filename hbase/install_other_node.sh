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
cp ./hbase-env.sh ./hbase-site.xml ./regionservers ~/hbase-2.4.0/conf/