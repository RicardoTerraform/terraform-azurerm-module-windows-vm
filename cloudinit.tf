# Render a part using a `template_file`
data "template_file" "script" {
  template = "${file("${path.module}/scripts/createfolder.ps1")}"
}

# Render a multi-part cloud-init config making use of the part
# above, and other source files
data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.

  part {
    filename = "createfolder.ps1"
    content_type = "text/x-shellscript"
    content      = "${file("${path.module}/scripts/createfolder.ps1")}"
  }

}