output "Acesso" {
  description = "URL para acessar a página Hello World"
  value       = "http://${aws_eip.this.public_ip}"
}
