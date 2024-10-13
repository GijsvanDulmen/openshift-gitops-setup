{{- define "clusters.get-tenants" -}}
{{- $tenants := list -}}
{{- range $path, $_ :=  .Files.Glob (print "config/" $.Values.clusterType "/" $.Values.clusterInstance "/tenants/**/values.yaml") -}}
{{- $tenantDefaults := $.Files.Get "config/tenant-defaults.yaml" | fromYaml }}
{{- $tenantClusterDefaults := $.Files.Get (print "config/" $.Values.clusterType "/" $.Values.clusterInstance "/tenants/values.yaml") | fromYaml  }}
{{- $tenantSpecific := $.Files.Get $path | fromYaml }}
{{- $yamlMerged := merge $tenantSpecific $tenantClusterDefaults $tenantDefaults }}
{{- $tenants = append $tenants $yamlMerged -}}
{{- end -}}
{{- $tenants | toYaml -}}
{{- end -}}
