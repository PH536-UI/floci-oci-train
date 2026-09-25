FROM python:3.11-slim
WORKDIR /app
COPY handler.py .
CMD ["python3", "-c", "import handler, json, time; print('floci-oci UP: Why pay for S3 when floci is free?'); while True: time.sleep(3600)"]
