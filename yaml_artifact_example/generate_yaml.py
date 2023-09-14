import sys
from jinja2 import Template

img_tag = sys.argv[1]

with open('my-deployment.yaml', 'r') as template_file:
    template_content = template_file.read()
    template = Template(template_content)

rendered_yaml = template.render({
    'img_tag': img_tag
})

with open(f'my-deployment_{img_tag}.yaml', 'w') as output_file:
    output_file.write(rendered_yaml)

print(rendered_yaml)
