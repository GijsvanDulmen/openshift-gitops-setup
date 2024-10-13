{{- define "clusters.get-tenants" -}}
{{- $tenants := list -}}
{{- range $path, $_ :=  .Files.Glob (print "tenants/" $.Values.clusterInstance "/**.yaml") -}}
{{- $tenantDefaults := $.Files.Get "tenants/defaults.yaml" | fromYaml }}
{{- $tenantClusterDefaults := $.Files.Get (print "cluster-tenants/" $.Values.clusterInstance ".yaml") | fromYaml  }}
{{- $tenantSpecific := $.Files.Get $path | fromYaml }}
{{- $yamlMerged := merge $tenantSpecific $tenantClusterDefaults $tenantDefaults }}
{{- $tenants = append $tenants $yamlMerged -}}
{{- end -}}
{{- $tenants | toYaml -}}
{{- end -}}
