# Etapa de compilación con Maven
FROM maven:3.9.2-eclipse-temurin-17 AS builder

WORKDIR /app

# Copiamos configuración para aprovechar la cache en construcción
COPY pom.xml ./
RUN mvn dependency:go-offline

# Copiamos el código fuente y compilamos
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa final solo con el JAR compilado
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Copiamos solo el JAR desde la etapa anterior
COPY --from=builder /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
