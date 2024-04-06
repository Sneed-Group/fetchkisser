#!/bin/bash


use_kissy="false"
# Function to display ASCII art based on the current distro's logo or Tux
display_ascii_art() {
    case "$(uname -s)" in
        Linux)
            case "$(detect_distro)" in
                debian)
                    cat << "DEBIAN"
              KNXX0 0KN              
          WNXK0000000000KXNNN.       
       XXK00000,         O000KKNo    
     XK0000.                l0000X:  
   .X000'                     x000Kk 
  dX00                         :00',.
.l00;             WNN;.Wo       o0K;.
.K0x            N               .00o 
l00           'x                .00K 
l0k           0'                ;00. 
l0o           kd          .     d0:  
l0o           .K;              O0;   
;0K.         .' 0X           kXl     
 00;            .'lNWl  .WWXK        
 :0KN               k,               
  l00d                               
   l00l                              
    '00x                             
      d0N,                           
        dKN:                         
           KXx                       
              .XW                    
                   ,O.     
DEBIAN
                    ;;
                arch)
                    cat << "ARCH"
                      :                      
                     :M:                     
                    'WMM;                    
                   .NMMMW'                   
                  .XMMMMMN.                  
                  KMMMMMMMN.                 
                 xMMMMMMMMMX.                
                o,:KMMMMMMMMX.               
               0MMWkkKWMMMMMMN.              
              0MMMMMMMMMMMMMMMN.             
            .KMMMMMMMMMMMMMMMMMN'            
           .XMMMMMMMMMMMMMMMMMMMW,           
          .NMMMMMMMMMMMMMMMMMMMMMW;          
         ,WMMMMMMMMK:. .:0MMMMMMMMMc         
        :WMMMMMMMMx       oMMMMMMMMMo        
       lMMMMMMMMMK         OMMMMMMMMMx       
      xMMMMMMMMMMo         :MMMMMMXOx0k      
     OMMMMMMMMMMMo         ;MMMMMMMMWO:.     
   .KMMMMMMMMW0ko,         'ok0WMMMMMMMWd.   
  .XMMMMNkl,.                   .,lkNMMMMN'  
 ,WMKx;.                             .;xKMW, 
,x;.                                     .;x,
ARCH
                    ;;
                fedora)
                    cat << "FEDORA"
                   ,kkkkkk;                   
             :OKXNWMMMMMMMMWNXKOl             
          cKNMMMMMMMMMMMMMMMMMMMMNKo          
        xNMMMMMMMMMMMMMMMMMMMMMMMMMMNO        
      ;NMMMMMMMMMMMMMMMMN    dMMMMMMMMNc      
     xMMMMMMMMMMMMMMMM          dMMMMMMMO     
    dMMMMMMMMMMMMMMMM   .0KXKk   lMMMMMMMk    
   'MMMMMMMMMMMMMMMM0   KMMMMM'  .MMMMMMMM;   
   0MMMMMMMMMMMMMMMM0   KMMMMMXkkXMMMMMMMMX   
   MMMMMMMMMMMMMMMMMO   XMMMMMMMMMMMMMMMMMM   
   MMMMMMMMM.      dO       .MMMMMMMMMMMMMM   
   MMMMMMM,    dkkkN0   dkkOXMMMMMMMMMMMMMN   
   MMMMMMc   0WMMMMM0   XMMMMMMMMMMMMMMMMMc   
   MMMMMM.  ,MMMMMMMx   XMMMMMMMMMMMMMMMMK    
   MMMMMMl   dMMMMMW   .MMMMMMMMMMMMMMMMX     
   MMMMMMMd           ,NMMMMMMMMMMMMMMMd      
   MMMMMMMMXO.      xKWMMMMMMMMMMMMMMN        
   MMMMMMMMMMMNXXXNWMMMMMMMMMMMMMMMk          
   lMMMMMMMMMMMMMMMMMMMMMMMMMMMMo             
      WMMMMMMMMMMMMMMMMMMW                    
                                       
FEDORA
                    ;;
                *)
                    cat << "UNIXLIKE"
  kko     'kk, lkkkkkkko    :kk. kkx      .c  
  XXx     'XX; dXX     lKO  cXX.  ;X0;   k    
  XXx     'XX; xXX      XXl cXX.    0KOl'     
  KXk     'XX; xXX      XXx cXX.    :dXKc     
  .XX.    'XX; dXX      XXx cXX.  .x   dXO    
     KkxxxOXX; dXX      XXk cXX. d.      XKl  Like
UNIXLIKE
                    ;;
            esac
            ;;
        *)
            cat << "UNIXLIKE"
  kko     'kk, lkkkkkkko    :kk. kkx      .c  
  XXx     'XX; dXX     lKO  cXX.  ;X0;   k    
  XXx     'XX; xXX      XXl cXX.    0KOl'     
  KXk     'XX; xXX      XXx cXX.    :dXKc     
  .XX.    'XX; dXX      XXx cXX.  .x   dXO    
     KkxxxOXX; dXX      XXk cXX. d.      XKl  Like
UNIXLIKE
            ;;
    esac
}

# Function to detect the current Linux distribution based on package manager
detect_distro() {
    if [ -x "$(command -v dpkg)" ]; then
        echo "debian"
    elif [ -x "$(command -v pacman)" ]; then
        echo "arch"
    elif [ -x "$(command -v dnf)" ] || [ -x "$(command -v rpm-ostree)" ]; then
        echo "fedora"
    else
        echo "unknown"
    fi
}

# Function to display system information
display_system_info() {
    echo "System Information:"
    echo "-------------------"
    echo "Hostname: $(hostname)"
    echo "Kernel: $(uname -r)"
    echo "Processor: $(uname -p)"
    echo "Uptime: $(uptime -p)"
    echo "RAM Total: $(free -m | awk '/^Mem:/{print $2 " MB"}')"
    echo "RAM Free: $(free -m | awk '/^Mem:/{print $4 " MB"}')"
    echo "Shell: $SHELL"
    echo "User: $USER"
    echo "Home Directory: $HOME"
    echo "Terminal: $TERM"
}

# Function to check if the system is Arch Linux
is_arch() {
    if [ "$(detect_distro)" == "arch" ]; then
        echo "Yes"
    else
        echo "No"
    fi
}

# Function to display package manager information
display_package_manager_info() {
    echo ""
    echo "Package Manager:"
    echo "----------------"
    case "$(detect_distro)" in
        debian)
            echo "APT (Debian-based)"
            ;;
        fedora)
            if [ -x "$(command -v dnf)" ]; then
                echo "DNF (Fedora-based)"
            elif [ -x "$(command -v rpm-ostree)" ]; then
                echo "RPM-Ostree (Fedora Silverblue)"
            fi
            ;;
        arch)
            echo "Pacman (Arch Linux)"
            ;;
        *)
            echo "Unknown"
            ;;
    esac
}

# Function to display the script's usage
display_usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -a, --all         Display all information with ASCII art"
    echo "  -NA               Display all information without ASCII art"
    echo "  -bk               Use the sillycat ASCII art"
    echo "  -h, --help        Display this help message"
}

ascii_displayer() {
    if [ "$1" == "true" ]; then
                cat << "ASCII"
⠀⠀⣟⠶⣄⡀⡀            ⣰⠏⣟⠛⠲⢤
⠀⢸⠂⠀⠀⠀⠘⣧⠀⠀⣟⠛⠲⢤⡀⠀⠀⣰⠏⠀⠀⠀⠀⠀⢹⡀
⠀⡿⠀⠀⠀⠀⠀⠈⢷⡀⢻⡀⠀⠀⠙⢦⣰⠏⠀⠀⠀⠀⠀⠀⢸⠀
⠀⡇⠀⠀⠀⠀⠀⠀⢀⣻⠞⠛⠀⠀⠀⠀⠻⠀⠀⠀⠀⠀⠀⠀⢸⠀
⠀⡇⠀⠀⠀⠀⠀⠀⠛⠓⠒⠓⠓⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀
⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀
⠀⢿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⠀⠀⢀⡟⠀
⠀⠘⣇⠀⠘⣿⠋⢹⠛⣿⡇⠀⠀⠀⠀⣿⣿⡇⠀⢳⠉⠀⣠⡾⠁⠀
⣦⣤⣽⣆⢀⡇⠀⢸⡇⣾⡇⠀⠀⠀⠀⣿⣿⡷⠀⢸⡇⠐⠛⠛⣿⠀
⠹⣦⠀⠀⠸⡇⠀⠸⣿⡿⠁⢀⡀⠀⠀⠿⠿⠃⠀⢸⠇⠀⢀⡾⠁⠀
⠀⠈⡿⢠⢶⣡⡄⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⣴⣧⠆⠀⢻⡄⠀⠀
⠀⢸⠃⠀⠘⠉⠀⠀⠀⠠⣄⡴⠲⠶⠴⠃⠀⠀⠀⠉⡀⠀⠀⢻⡄⠀
⠀⠘⠒⠒⠻⢦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⠞⠛⠒⠛⠋⠁⠀
⠀⠀⠀⠀⠀⠀⠸⣟⠓⠒⠂⠀⠀⠀⠀⠀⠈⢷⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠙⣦⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣼⣃⡀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠉⣹⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀
ASCII
    else
    display_ascii_art
    fi
}

# Main function
main() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -bk)
                use_kissy="true"
                ascii_displayer "$use_kissy"
                display_system_info
                #display_package_manager_info
                #echo "Is Arch BTW: $(is_arch)"
                shift
                ;;
            -a | --all)
                ascii_displayer "$use_kissy"
                display_system_info
                display_package_manager_info
                echo "Is Arch BTW: $(is_arch)"
                ;;
            -NA)
                display_system_info
                display_package_manager_info
                echo "Is Arch BTW: $(is_arch)"
                ;;
            -h | --help)
                display_usage
                ;;
            *)
                echo "Error: Invalid option"
                display_usage
                ;;
        esac
        shift
    done


}

# Run the main function
main "$@"
