FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1
ENV PORT=8080

WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080
CMD ["uvicorn", "myapp.main:app", "--host", "0.0.0.0", "--port", "8080"]
