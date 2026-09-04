{{/*
Expand the name of the chart.
*/}}
{{- define "cart-dynamodb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cart-dynamodb.fullname" -}}
{{- $globalHost := dig "dynamodb" "host" "" (.Values.global | default dict) }}
{{- if $globalHost }}
{{- $globalHost | trunc 63 }}
{{- else if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
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
{{- define "cart-dynamodb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cart-dynamodb.labels" -}}
helm.sh/chart: {{ include "cart-dynamodb.chart" . }}
{{ include "cart-dynamodb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: cart-dynamodb
app.kubernetes.io/part-of: retail-store
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cart-dynamodb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cart-dynamodb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "cart-dynamodb.port" -}}
{{- $globalPort := dig "dynamodb" "port" "" (.Values.global | default dict) }}
{{- if $globalPort }}
{{- $globalPort }}
{{- else }}
{{- .Values.service.port }}
{{- end }}
{{- end }}