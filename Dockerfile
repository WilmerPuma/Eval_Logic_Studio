# Usamos una imagen base ligera con OpenJDK 17
FROM openjdk:17-jdk-slim

# Configuramos el directorio de trabajo
WORKDIR /app

# Instalamos Maven para la compilación
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Copiamos solo los archivos esenciales para optimizar la construcción de la imagen
COPY pom.xml ./
RUN mvn dependency:go-offline

COPY src ./src

# Compilamos la aplicación con Maven
RUN mvn clean package -DskipTests

# La imagen está diseñada solo para compilación, así que no exponemos puertos ni definimos un ENTRYPOINT

# Mantenemos la imagen lo más mínima posible
CMD ["echo", "Compilación completada. Imagen lista para integración en CI."]

