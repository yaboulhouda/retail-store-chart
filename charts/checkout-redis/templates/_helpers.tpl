{{- define "checkout-redis.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: cache
app.kubernetes.io/part-of: retail-store
{{- end -}}

{{- define "checkout-redis.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "checkout-redis.fullname" -}}
{{- $globalHost := dig "redis" "host" "" (.Values.global | default dict) }}
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

{{- define "checkout-redis.port" -}}
{{- $globalPort := dig "redis" "port" "" (.Values.global | default dict) }}
{{- if $globalPort }}
{{- $globalPort }}
{{- else }}
{{- .Values.redis.port }}
{{- end }}
{{- end }}
