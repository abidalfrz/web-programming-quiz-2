FROM maven:3.8.5-openjdk-17-slim AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# ... (bagian atas sama) ...

# --- Stage 2: Runtime Process ---
FROM tomcat:9.0-jdk17-openjdk-slim

RUN rm -rf /usr/local/tomcat/webapps/*

# PERUBAHAN DISINI: Gunakan tanda bintang (*)
# Docker akan mengambil file .war apapun yang ada di folder target
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
