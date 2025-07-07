### ESTÁGIO 1: Build ###
# Usar uma imagem Python slim como base, que é um bom equilíbrio entre tamanho e funcionalidades.
FROM python:3.12-slim AS builder

# Definir o diretório de trabalho dentro do contêiner
# Isso é onde os comandos subsequentes serão executados.
WORKDIR /app

# Instalar dependências do sistema (se necessário para compilar pacotes Python)
# RUN apt-get update && apt-get install -y build-essential

# Instalar dependências Python
# Primeiro, copie apenas o arquivo de requisitos para aproveitar o cache do Docker.
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copiar o restante do código da aplicação
COPY . .

# Expor a porta em que o Uvicorn será executado(padrão 8000)
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn
# Usar 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
