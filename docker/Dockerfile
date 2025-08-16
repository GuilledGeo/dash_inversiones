# docker/Dockerfile

# Imagen base
FROM python:3.10-slim

# Desactiva buffer en logs
ENV PYTHONUNBUFFERED=1

# Crea directorio de trabajo
WORKDIR /app

# Copia los archivos de requisitos
COPY requirements.txt .
COPY requirements-dev.txt .

# Instala dependencias
RUN pip install --upgrade pip \
 && pip install -r requirements.txt \
 && pip install -r requirements-dev.txt

# Copia todo el proyecto al contenedor
COPY . .

# Expone el puerto de la API (cámbialo si usas otro)
EXPOSE 8000

# Comando por defecto: lanzar FastAPI
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]
