
#!/bin/bash

# Creado por Darío Pérez (aka M0B)

#Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
	echo -e "\n${redColour}[!]Saliendo...\n${endColour}"
    rm cookies.txt 2>/dev/null
    tput cnorm 2>/dev/null ; exit 1
}

trap ctrl_c INT

#Variables Globales
log_in="https://intranet.upv.es/pls/soalu/est_aute.intraalucomp"
credentials="credentials.txt"
sports="https://intranet.upv.es/pls/soalu/sic_depact.HSemActividades?p_campus=V&p_tipoact=6690&p_codacti=21229&p_vista=intranet&p_idioma=c&p_solo_matricula_sn=&p_anc=filtro_actividad"
groups="groups.txt"

function waiting(){
    echo -e "\n${grayColour}[!] Esperando hasta el sábado a las 09:59 am para reservar${endColour}"
    #Este while se va estar ejecutando hasta que sea sábado 09:59 a.m. entonces llamará a la función booking cada 10 segundos
    while true; do
        sudo timedatectl set-timezone Europe/Madrid > /dev/null 2>&1
	if [ "$(date +\%A)" = "sábado" ] || [ "$(date +\%A)" = "Saturday" ] && [ "$(date +\%H:%M)" = "09:59" ]; then
			for ((i = 1; i <= 8; i++)); do
				booking
				sleep 15
			done
        fi
        sleep 60
    done
}

function hour(){
	echo -ne "\n${grayColour}[$(date | awk '{print $4}')] ${endColour}"
}
function booking(){
sudo timedatectl set-timezone Europe/Madrid > /dev/null 2>&1
    if [ -e "$credentials" ] && [ -e "$groups" ]; then
        while IFS=' ' read -r alias _ dni _ password && IFS=' ' read -r line <&3; do
            hour ; echo -e "${blueColour}[*] Realizando reservas para $alias ...${endColour}"
            curl -X POST "$log_in" -d "dni=$dni&clau=$password" -c "${alias}_cookies.txt" > /dev/null 2>&1

            IFS=' ' read -ra numbers <<< "$line"
            for number in "${numbers[@]}"; do
                hour ; echo -e "\t${yellowColour}[!] Reservando grupo $number ...${endColour}"
                book_url="https://intranet.upv.es/pls/soalu/""$(curl -s -X GET "$sports" -b "${alias}_cookies.txt" | grep -e "MUS0$number" | awk '{print $3}' | sed 's/href="//g; s/"//g')"
                curl -s -X GET "$book_url" -b "${alias}_cookies.txt" > /dev/null 2>&1
                book_confirmation_url=$(curl -s -X GET "$sports" -b "${alias}_cookies.txt" | grep -e "MUS0$number")
                if [[ "$book_confirmation_url" == *"inscrito"* ]]; then
                    hour ; echo -e "\t${greenColour}[+] ¡Grupo $number reservado con éxito! ${endColour}"
                else
                    hour ; echo -e "\t${redColour}[!] Fallo al realizar la reserva del grupo $number  ${endColour}"
                fi
            done
            rm "${alias}_cookies.txt" 2>/dev/null
        done < "$credentials" 3< "$groups"
    else
        echo -e "\n${redColour}[!] El archivo $credentials o $groups no existe${endColour}"
        ctrl_c
    fi
}

tput civis 2>/dev/null
if [ -e "$credentials" ]; then
	while IFS=' ' read -r alias _ dni _ password; do
  		try_login=$(curl -X POST "$log_in" -d "dni=$dni&clau=$password" -v 2>&1)
    	if [[ "$try_login" == *"Alumnado"* ]]; then
    		echo -e "\n${greenColour}[+] Login de $alias Correcto \n${endColour}"
        	sleep 1 
    	else
        	echo -e "\n${redColour}[!] Login de $alias Incorrecto ${endColour}"
			ctrl_c
    	fi
	done < "$credentials"
	sleep 2 ; clear 
	waiting
else
	echo -e "\n${redColour}[!] El archivo $credentials no existe${endColour}"
    ctrl_c
fi

