<field key="{{ .key }}" type="select">
    <option value="true">true</option>
    <option value="false">false</option>
    <default>property</default>
    <default_value>{{ .default }}</default_value>
    <var>      - {{ .var }}=</var>
    <filepath>docker-environment.yml</filepath>
</field>