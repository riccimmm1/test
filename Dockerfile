FROM python:3.11-slim

# Установка Chrome и зависимостей
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    chromium \
    chromium-driver \
    fonts-ipafont \
    libglib2.0-0 \
    libnss3 \
    libx11-6 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    && rm -rf /var/lib/apt/lists/*

# Симлинки для совместимости
RUN ln -s /usr/bin/chromium /usr/bin/chromium-browser

# Рабочая директория
WORKDIR /app

# Копируем зависимости и устанавливаем
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем основной скрипт
COPY alivewater_monitoring.py .

# Точка монтирования для данных
VOLUME /app/data

# Переменные среды
ENV TELEGRAM_TOKEN=""
ENV LOGIN=""
ENV PASSWORD=""

# Команда запуска
CMD ["python", "alivewater_monitoring.py"]
