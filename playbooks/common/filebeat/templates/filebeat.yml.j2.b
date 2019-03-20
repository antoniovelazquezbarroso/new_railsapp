######################## Filebeat Configuration ############################

#==========================  Modules configuration ============================
filebeat.modules: {{ filebeat_modules | to_json | default({}) }}

#=========================== Filebeat inputs =============================
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/*.log

#================================ Outputs ======================================

# Configure what output to use when sending the data collected by the beat.

#-------------------------- Elasticsearch output -------------------------------
output.elasticsearch:
  # Boolean flag to enable or disable the output module.
  enabled: true

  # Array of hosts to connect to.
  # Scheme and port can be left out and will be set to the default (http and 9200)
  # In case you specify and additional path, the scheme is required: http://localhost:9200/path
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:9200
  hosts: ["{{ groups['elk'][0] }}:9200"]

#     #----------------------------- Logstash output ---------------------------------
#     output.logstash:
#       # Boolean flag to enable or disable the output module.
#       #enabled: true
#     
#       # The Logstash hosts
#       hosts: ["{{ groups['elk'][0] }}:5044"]

#============================== Dashboards =====================================
# These settings control loading the sample dashboards to the Kibana index. 
setup.dashboards.enabled: true
setup.dashboards.always_kibana: true

#============================== Kibana =====================================
# Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana API.
# This requires a Kibana endpoint configuration.
setup.kibana:
  host: "{{ groups['elk'][0] }}:5601"
  # Use SSL settings for HTTPS. Default is true.
  ssl.enabled: false

#================================ Logging ======================================
logging.to_files: true
logging.files:
  path: /var/log/filebeat
  name: filebeat
  rotateeverybytes: 10485760 # = 10MB
  keepfiles: 7
  permissions: 0600
