# ETAPA 1: Build com Maven
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app

# Copiar arquivos do projeto
COPY pom.xml .
COPY src ./src
COPY mvnw .
COPY mvnw.cmd .
COPY .mvn ./.mvn

# Dar permissão de execução ao wrapper
RUN chmod +x ./mvnw

# Compilar o projeto
RUN ./mvnw clean package -DskipTests -Dmaven.test.skip=true

# Verificar se o JAR foi criado (debug)
RUN ls -la /app/target/

# ETAPA 2: Runtime
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copiar o JAR compilado (usa wildcard para pegar qualquer .jar)
COPY --from=builder /app/target/*.jar app.jar

# Configurar JVM
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Expor porta
EXPOSE 8080

# Comando de inicialização
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=$PORT -jar /app/app.jar"]
