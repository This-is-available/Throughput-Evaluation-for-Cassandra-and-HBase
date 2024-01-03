cd ~
wget https://archive.apache.org/dist/cassandra/3.11.5/apache-cassandra-3.11.5-src.tar.gz && tar -zxf apache-cassandra-3.11.5-src.tar.gz && rm apache-cassandra-3.11.5-src.tar.gz
git clone https://github.com/OrderLab/YCSB.git && cd ~/YCSB && git checkout -b 0.12.0-dh origin/0.12.0-dh
cd ~/apache-cassandra-3.11.5-src && ant