data "template_file" "script" {
  for_each = toset(var.vm_custom_data_script)

  template = file("${path.module}/scripts/${each.key}")
  #template = file("./${each.key}")
}
