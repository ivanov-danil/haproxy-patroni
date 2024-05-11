{{/*
Expand the name of the chart.
*/}}
{{- define "haproxy.name" -}}
{{- default .Chart.Name .Values.haproxy.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "haproxy.fullname" -}}
{{- if .Values.haproxy.fullnameOverride }}
{{- .Values.haproxy.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.haproxy.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "haproxy.names.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "common_labels" }}
app.kubernetes.io/name: {{ include "haproxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: {{ include "haproxy.name" . }}
{{- with .Chart.AppVersion }}
app.kubernetes.io/version: {{ . | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: db
helm.sh/chart: {{ include "haproxy.names.chart" . }}
{{- end }}

{{- define "selector_labels" }}
app.kubernetes.io/name: {{ include "haproxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "probes" }}
livenessProbe:
  failureThreshold: 10
  httpGet:
    path: /
    port: 1936
    scheme: HTTP
  initialDelaySeconds: 60
  periodSeconds: 30
  successThreshold: 1
  timeoutSeconds: 1
readinessProbe:
  failureThreshold: 3
  httpGet:
    path: /
    port: 1936
    scheme: HTTP
  initialDelaySeconds: 10
  periodSeconds: 15
  successThreshold: 1
  timeoutSeconds: 1
{{- end }}
