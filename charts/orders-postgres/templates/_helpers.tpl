{{/*
Expand the name of the chart.
*/}}
{{- define "orders-postgres.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "orders-postgres.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "orders-postgres.labels" -}}
helm.sh/chart: {{ include "orders-postgres.chart" . }}
{{ include "orders-postgres.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: postgres
app.kubernetes.io/part-of: retail-store
{{- end }}

{{/*
Selector labels
*/}}
{{- define "orders-postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ include "orders-postgres.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "orders-postgres.fullname" -}}
{{- $globalHost := dig "postgres" "host" "" (.Values.global | default dict) }}
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

{{- define "orders-postgres.port" -}}
{{- $globalPort := dig "postgres" "port" "" (.Values.global | default dict) }}
{{- if $globalPort }}
{{- $globalPort }}
{{- else }}
{{- .Values.service.port }}
{{- end }}
{{- end }}