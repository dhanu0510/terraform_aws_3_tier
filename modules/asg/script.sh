#!/bin/bash
# Update and install Apache
sudo apt update
sudo apt install apache2 -y

# Create an HTML file that includes the private IP using hostname -I
echo "<html><body><h1>Hello from $(hostname -I | awk '{print $1}')</h1></body></html>" | sudo tee /var/www/html/index.html

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2
