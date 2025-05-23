/*output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.app_vpc.id
}

output "public_subnet_1_id" {
  description = "ID of the first public subnet"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "ID of the second public subnet"
  value       = aws_subnet.public_subnet_2.id
}

output "maven_server_public_ip" {
  description = "Public IP of the Maven build EC2 instance"
  value       = aws_instance.maven_server.public_ip
}

output "tomcat_server_public_ip" {
  description = "Public IP of the Tomcat server EC2 instance"
  value       = aws_instance.tomcat_server.public_ip
}

output "tomcat_server_url" {
  description = "URL to access the deployed WAR application on Tomcat"
  value       = "http://${aws_instance.tomcat_server.public_ip}:8080/"
}
*/