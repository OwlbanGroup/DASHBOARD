FROM grafana/grafana:latest

# Set environment variables for Grafana
ENV GF_SECURITY_ADMIN_PASSWORD=admin
ENV GF_USERS_ALLOW_SIGN_UP=false
ENV GF_INSTALL_PLUGINS=grafana-assistant-app,grafana-database-observability-app
ENV GF_METRICS_ENABLED=true

# Create directories for provisioning
RUN mkdir -p /etc/grafana/provisioning/datasources \
    /etc/grafana/provisioning/dashboards \
    /etc/grafana/provisioning/plugins \
    /var/lib/grafana/dashboards

# Copy provisioning files
COPY grafana/provisioning/datasources/datasources.yml /etc/grafana/provisioning/datasources/
COPY grafana/provisioning/dashboards/dashboards.yml /etc/grafana/provisioning/dashboards/
COPY grafana/provisioning/plugins/plugins.yml /etc/grafana/provisioning/plugins/

# Copy dashboard files
COPY dashboard.json /var/lib/grafana/dashboards/

# Copy custom configuration if needed
COPY grafana/grafana.ini /etc/grafana/grafana.ini

# Expose port 3000 (Grafana default)
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:3000/api/health || exit 1

# Start Grafana
CMD ["/run.sh"]
