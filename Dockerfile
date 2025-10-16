# Tomcat 이미지 사용
FROM tomcat:9.0-jdk17

# 컨테이너 8080 포트 오픈
EXPOSE 8080

# 기존 웹앱 제거
RUN rm -rf /usr/local/tomcat/webapps/*

# Maven 빌드된 WAR 파일 복사
COPY target/travel-web-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat 실행
CMD ["catalina.sh", "run"]
