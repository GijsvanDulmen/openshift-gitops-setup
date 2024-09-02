{{- define "tenants.namespaces" -}}
{{- $namespaces := list -}}
{{- range $ns := $.Values.namespaces -}}
{{- $namespaces = append $namespaces (set $ns "namespaceName" (print $.Values.name "-" $ns.name)) -}}
{{- end -}}
{{- range $tpn := $.Values.tenantProvisionedNamespaces -}}
{{- $ns := dict "name" $tpn.name -}}
{{- $namespaces = append $namespaces (dict $ns "namespaceName" (print $.Values.name "-" $ns.name)) -}}
{{- end -}}
{{- $namespaces | toYaml  -}}
{{- end -}}