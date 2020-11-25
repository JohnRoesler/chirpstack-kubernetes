#!/usr/bin/env bash

context="your context"
kubectl_path="/usr/local/bin/kubectl" # path to your kubectl executable

$kubectl_path config use-context $context # assumes you have a valid ~/.kube/config file

# assumes you have ENVs set for CA_BUNDLE_PATH, NS_POSTGRESQL_DSN, REDIS_PASSWORD, MQTT_PASSWORD
$kubectl_path delete secret chirpstack-network-server-secrets --ignore-not-found=true --certificate-authority=$CA_BUNDLE_PATH
$kubectl_path create secret generic chirpstack-network-server-secrets --from-literal=POSTGRESQL_DSN=$NS_POSTGRESQL_DSN --from-literal=REDIS_PASSWORD=$REDIS_PASSWORD --from-literal=MQTT_PASSWORD=$MQTT_PASSWORD --certificate-authority=$CA_BUNDLE_PATH

# assumes you have ENVs set for CA_BUNDLE_PATH, JWT_SECRET, AS_POSTGRESQL_DSN, REDIS_PASSWORD, MQTT_PASSWORD
$kubectl_path delete secret chirpstack-application-server-secrets --ignore-not-found=true --certificate-authority=$CA_BUNDLE_PATH
$kubectl_path create secret generic chirpstack-application-server-secrets --from-literal=JWT_SECRET=$JWT_SECRET --from-literal=POSTGRESQL_DSN=$AS_POSTGRESQL_DSN --from-literal=REDIS_PASSWORD=$REDIS_PASSWORD --from-literal=MQTT_PASSWORD=$MQTT_PASSWORD --certificate-authority=$CA_BUNDLE_PATH

# assumes you have ENVs set for CA_BUNDLE_PATH, MQTT_PASSWORD
$kubectl_path delete secret chirpstack-gateway-bridge-secrets --ignore-not-found=true --certificate-authority=$CA_BUNDLE_PATH
$kubectl_path create secret generic chirpstack-gateway-bridge-secrets --from-literal=MQTT_PASSWORD=$MQTT_PASSWORD --certificate-authority=$CA_BUNDLE_PATH
