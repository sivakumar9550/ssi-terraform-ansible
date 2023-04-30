resource "aws_instance" "web_server" {
  count = var.web_want == true ? var.web_count : 0
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = var.instance_type
  key_name      = var.my_key_name
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file(var.local_aws_private_key_path)
    host     = self.public_ip
  }

  tags = {
    Name = "Web_server-${count.index}"
  }  

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
      "cd /var/www/html",
      "sudo chmod 407 index.html",
      "sudo echo '<h1>Hello World from SSI_Siva_Web_Server</h1> <h2>This is Sai Krishna</h2>'  > /var/www/html/index.html",
      "sudo systemctl restart apache2"
    ]

  }  
}
