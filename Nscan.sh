#!/bin/bash

# Function to display header
display_header() {
    clear
    echo "============================================="
    echo "           Penetration Testing Toolkit       "
    echo "============================================="
    echo
}

# Prompt for the user's name
display_header
echo "What is your Name?"
read name
echo "Welcome Back, $name!"
sleep 1

# Main menu
while true; do
    display_header
    echo "Which tools do you want to use?"
    echo " 1) Nmap for network scan"
    echo " 2) Nikto for web server scanning"
    echo " 3) Amass for subdomain enumeration"
    echo " 4) Exit"
    read -p "Please enter your choice (1-4): " choice

    case $choice in
        1)
            # Nmap options
            while true; do
                display_header
                echo "Nmap Scanning Options:"
                echo " 1) Detect services and versions (-sV)"
                echo " 2) Aggressive scan (-A)"
                echo " 3) OS detection (-O)"
                echo " 4) Scan specific ports (-p)"
                echo " 5) Scan all ports (-p-)"
                echo " 6) Ping scan (-sn)"
                echo " 7) TCP connect scan (-sT)"
                echo " 8) UDP scan (-sU)"
                echo " 9) Save output to file (-oN)"
                echo "10) Custom Nmap command"
                echo "11) Back to main menu"
                read -p "Please enter your choice (1-11): " nmap_choice

                case $nmap_choice in
                    1|2|3|4|5|6|7|8)
                        read -p "Enter the target IP or hostname: " target
                        output_file="nmap_output_$(date +%Y%m%d_%H%M%S).txt"
                        
                        case $nmap_choice in
                            1)
                                echo "Running Nmap to detect services and versions on $target..."
                                nmap -sV "$target" | tee "$output_file"
                                ;;
                            2)
                                echo "Running aggressive scan on $target..."
                                nmap -A "$target" | tee "$output_file"
                                ;;
                            3)
                                echo "Running OS detection on $target..."
                                nmap -O "$target" | tee "$output_file"
                                ;;
                            4)
                                read -p "Enter the specific ports to scan (e.g., 22,80,443): " ports
                                echo "Running Nmap to scan specific ports on $target..."
                                nmap -p "$ports" "$target" | tee "$output_file"
                                ;;
                            5)
                                echo "Running Nmap to scan all ports on $target..."
                                nmap -p- "$target" | tee "$output_file"
                                ;;
                            6)
                                echo "Running ping scan on $target..."
                                nmap -sn "$target" | tee "$output_file"
                                ;;
                            7)
                                echo "Running TCP connect scan on $target..."
                                nmap -sT "$target" | tee "$output_file"
                                ;;
                            8)
                                echo "Running UDP scan on $target..."
                                nmap -sU "$target" | tee "$output_file"
                                ;;
                        esac
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    9)
                        read -p "Enter the target IP or hostname: " target
                        read -p "Enter output filename: " output_file
                        echo "Running default Nmap scan with output to file..."
                        nmap -sV -O "$target" -oN "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    10)
                        read -p "Enter the target IP or hostname: " target
                        read -p "Enter your custom Nmap command (without target): " custom_cmd
                        output_file="nmap_custom_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running custom Nmap command: nmap $custom_cmd $target..."
                        nmap $custom_cmd "$target" | tee "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    11)
                        break
                        ;;
                    *)
                        echo "Invalid choice. Please try again."
                        sleep 1
                        ;;
                esac
            done
            ;;
        2)
            # Nikto options
            while true; do
                display_header
                echo "Nikto Web Server Scanning Options:"
                echo " 1) Basic scan"
                echo " 2) Scan with port specification"
                echo " 3) Scan with SSL"
                echo " 4) Scan with authentication"
                echo " 5) Scan with specific plugins"
                echo " 6) Scan with evasion techniques"
                echo " 7) Save output to file"
                echo " 8) Custom Nikto command"
                echo " 9) Back to main menu"
                read -p "Please enter your choice (1-9): " nikto_choice

                case $nikto_choice in
                    1)
                        read -p "Enter the target URL (e.g., http://example.com): " target
                        output_file="nikto_basic_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running basic Nikto scan on $target..."
                        nikto -h "$target" | tee "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    2)
                        read -p "Enter the target URL: " target
                        read -p "Enter port number: " port
                        output_file="nikto_port_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Nikto scan on $target port $port..."
                        nikto -h "$target" -p "$port" | tee "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    3)
                        read -p "Enter the target URL (https://): " target
                        output_file="nikto_ssl_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Nikto SSL scan on $target..."
                        nikto -h "$target" -ssl | tee "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    4)
                        read -p "Enter the target URL: " target
                        read -p "Enter username: " user
                        read -s -p "Enter password: " pass
                        echo
                        output_file="nikto_auth_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Nikto scan with authentication on $target..."
                        nikto -h "$target" -id "$user:$pass" | tee "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    5)
                        read -p "Enter the target URL: " target
                        read -p "Enter plugins to use (e.g., 'apacheusers'): " plugins
                        output_file="nikto_plugins_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Nikto scan with plugins on $target..."
                        nikto -h "$target" -Plugins "$plugins" | tee "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    6)
                        read -p "Enter the target URL: " target
                        echo "Evasion techniques:"
                        echo "1) Random URI encoding"
                        echo "2) Directory self-reference"
                        echo "3) Premature URL ending"
                        echo "4) Use TAB as request spacer"
                        echo "5) Use random headers"
                        read -p "Select evasion technique (1-5): " evade_tech
                        output_file="nikto_evade_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Nikto scan with evasion on $target..."
                        nikto -h "$target" -evasion "$evade_tech" | tee "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    7)
                        read -p "Enter the target URL: " target
                        read -p "Enter output filename: " output_file
                        echo "Running Nikto scan with output to file..."
                        nikto -h "$target" -output "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    8)
                        read -p "Enter the target URL: " target
                        read -p "Enter your custom Nikto command (without -h and target): " custom_cmd
                        output_file="nikto_custom_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running custom Nikto command: nikto -h $target $custom_cmd..."
                        nikto -h "$target" $custom_cmd | tee "$output_file"
                        echo "Scan completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    9)
                        break
                        ;;
                    *)
                        echo "Invalid choice. Please try again."
                        sleep 1
                        ;;
                esac
            done
            ;;
        3)
            # Amass options
            while true; do
                display_header
                echo "Amass Subdomain Enumeration Options:"
                echo " 1) Basic passive enumeration"
                echo " 2) Active enumeration (DNS brute-forcing)"
                echo " 3) Enumeration with wordlist"
                echo " 4) Enumeration with ASN"
                echo " 5) Enumeration with IP ranges"
                echo " 6) Save output to file"
                echo " 7) Custom Amass command"
                echo " 8) Back to main menu"
                read -p "Please enter your choice (1-8): " amass_choice

                case $amass_choice in
                    1)
                        read -p "Enter the domain for subdomain enumeration: " domain
                        output_file="amass_passive_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Amass passive enumeration on $domain..."
                        amass enum -passive -d "$domain" | tee "$output_file"
                        echo "Enumeration completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    2)
                        read -p "Enter the domain for subdomain enumeration: " domain
                        output_file="amass_active_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Amass active enumeration on $domain..."
                        amass enum -active -d "$domain" | tee "$output_file"
                        echo "Enumeration completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    3)
                        read -p "Enter the domain for subdomain enumeration: " domain
                        read -p "Enter path to wordlist file: " wordlist
                        output_file="amass_wordlist_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Amass enumeration with wordlist on $domain..."
                        amass enum -d "$domain" -w "$wordlist" | tee "$output_file"
                        echo "Enumeration completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    4)
                        read -p "Enter the domain for subdomain enumeration: " domain
                        read -p "Enter ASN number (e.g., ASN12345): " asn
                        output_file="amass_asn_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Amass enumeration with ASN on $domain..."
                        amass enum -d "$domain" -asn "$asn" | tee "$output_file"
                        echo "Enumeration completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    5)
                        read -p "Enter the domain for subdomain enumeration: " domain
                        read -p "Enter IP range (e.g., 192.168.1.0/24): " ip_range
                        output_file="amass_iprange_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running Amass enumeration with IP range on $domain..."
                        amass enum -d "$domain" -ip -cidr "$ip_range" | tee "$output_file"
                        echo "Enumeration completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    6)
                        read -p "Enter the domain for subdomain enumeration: " domain
                        read -p "Enter output filename: " output_file
                        echo "Running Amass enumeration with output to file..."
                        amass enum -d "$domain" -o "$output_file"
                        echo "Enumeration completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    7)
                        read -p "Enter the domain for subdomain enumeration: " domain
                        read -p "Enter your custom Amass command (without -d and domain): " custom_cmd
                        output_file="amass_custom_$(date +%Y%m%d_%H%M%S).txt"
                        echo "Running custom Amass command: amass enum -d $domain $custom_cmd..."
                        amass enum -d "$domain" $custom_cmd | tee "$output_file"
                        echo "Enumeration completed. Results saved to $output_file"
                        read -p "Press [Enter] to continue..."
                        ;;
                    8)
                        break
                        ;;
                    *)
                        echo "Invalid choice. Please try again."
                        sleep 1
                        ;;
                esac
            done
            ;;
        4)
            echo "Exiting the script. Goodbye, $name!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            sleep 1
            ;;
    esac
done
