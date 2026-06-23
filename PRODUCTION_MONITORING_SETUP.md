# Production Monitoring Setup Guide

This guide covers setting up monitoring for production deployment.

## Current Setup (Already Deployed)
The monitoring stack is already running with:
- Prometheus (port 9090)
- Grafana (port 3001) 
- Node Exporter (port 9100)
- Loki (port 3100)

## Next Steps for Production Monitoring

### 1. Error Tracking Integration

#### Option A: Sentry (Recommended)
```bash
# Install Sentry SDK
npm install @sentry/node

# Add to application
const Sentry = require('@sentry/node');
Sentry.init({ dsn: 'YOUR_SENTRY_DSN' });
```

**Sign up**: https://sentry.io

#### Option B: Rollbar
```bash
npm install rollbar
```

**Sign up**: https://rollbar.com

### 2. Uptime Monitoring

#### Option A: UptimeRobot (Free Tier Available)
1. Sign up at https://uptimerobot.com
2. Add monitored URL
3. Set check interval (5 minutes)
4. Configure alert notifications

#### Option B: Pingdom
1. Sign up at https://pingdom.com
2. Add HTTP check
3. Configure alerts

#### Option C: Health Checks (Built-in)
Your application already has health endpoints:
- http://localhost:8080/health (Java)
- http://localhost:5000/health (Python)
- http://localhost:3000/api/info (Node)

### 3. Logging & Alerting

#### Current Stack (Already Configured)
- Loki: http://localhost:3100
- Grafana: http://localhost:3001

#### Configure Alerts in Grafana
1. Login to Grafana (admin/admin)
2. Navigate to Alerting → Notification channels
3. Add email/Slack/Discord/webhook channels

#### Prometheus Alert Rules
Edit grafana/provisioning/prometheus.yml to add custom alerting rules:
```yaml
groups:
- name: application_alerts
  rules:
  - alert: HighErrorRate
    expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.1
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: High error rate detected
```

### 4. CloudWatch Integration (AWS)

If deploying to AWS, add CloudWatch:
```bash
# Install CloudWatch agent
aws logs create-log-group --log-group-name your-app-logs
```

### 5. Datadog Integration

```bash
# Install Datadog agent
DD_API_KEY=your_api_key bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
```

## Verification Steps

After setup, verify:
1. ✅ Error tracking receiving events
2. ✅ Uptime checks configured
3. ✅ Alerts firing correctly
4. ✅ Logs appearing in Grafana/Loki

## Access Information

- Grafana: http://localhost:3001 (admin/admin)
- Prometheus: http://localhost:9090
- Loki: http://localhost:3100
- Node Exporter: http://localhost:9100/metrics
