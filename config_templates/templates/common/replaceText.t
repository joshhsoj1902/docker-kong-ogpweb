    <text key="{{ .key }}">
      <default>({{ .field }}:\s*)(.*)</default>
      <var>{{ .field }}: {{ .value }}</var>
      <filepath>docker-config.yml</filepath>
      <options>{{ .options }}</options>
    </text>