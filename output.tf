output "httpd_server_public_ip" {
  value = aws_instance.httpd_server.*.public_ip
}