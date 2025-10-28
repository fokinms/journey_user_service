#!/bin/sh

if command -v curl >/dev/null 2>&1; then
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/actuator/health)
    if [ "$STATUS" = "200" ]; then
        echo "✅ Application is healthy"
        exit 0
    else
        echo "❌ Application health check failed: HTTP $STATUS"
        exit 1
    fi
else
    echo "⚠️ curl not installed, cannot perform health check"
    exit 1
fi