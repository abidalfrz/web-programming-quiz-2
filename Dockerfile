# Kita tetap pakai Tomcat 9 (Java 17) sebagai base
# (Tomcat 9 di Java 17 masih bisa menjalankan hasil compile Java 21 asalkan settingannya pas,
# atau kalau mau aman kita pakai image Java 21 sekalian)

FROM tomcat:9.0-jdk21

# Bersihkan aplikasi bawaan
RUN rm -rf /usr/local/tomcat/webapps/*

# COPY hasil build yang sudah kamu upload ke GitHub tadi
# Path ini diambil dari hasil 'tree' kamu: target/Expense_Tracker
COPY target/Expense_Tracker/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]