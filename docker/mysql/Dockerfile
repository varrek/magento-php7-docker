FROM mysql:5.6

RUN /bin/bash -c "/usr/bin/mysqld_safe &" && \
  sleep 5 && \
  mysql -u root -p123456 -e "CREATE DATABASE magenew" && \
  mysql -u root magenew < ../dump/