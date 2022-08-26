# https://hub.docker.com/r/dataformco/dataform/tags
FROM dataformco/dataform:2.0.0

# To disable a prompt when running dataform
COPY .dataform /root/.dataform