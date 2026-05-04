#!/usr/bin/env bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Compiles gbz80 assembly ACE payloads to .hex files"
   echo
   echo "Syntax: "`basename $0`" [-h] <payload.asm>"
   echo "<payload.asm> must be in the same directory as "`basename $0`"."
   echo
   echo "options:"
   echo "h     Print this Help."
   echo
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################

############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
     \?) # Invalid option
         echo "Error: Invalid option"
	 Help
         exit;;
   esac

done

if [ $# -eq 0 ]; then
    echo "No arguments specified."
    echo
    Help
    exit;
fi

file=$1
filename=$(basename "${file%.*}")
path=$(dirname "$(realpath $1)")


# Command 1: Assemble the copied .asm file to create an object file
echo "Assembling.."
./rgbasm -o "${filename}.o" "${filename}.asm"

echo "Linking.."
# Command 2: Link the object file to create a .gb file
./rgblink -x -o "${filename}.gb" "${filename}.o"

# Check if the .gb file was created
if [ -e "${path}/${filename}.gb" ]; then

	# Command 3: Convert the .gb file to a hex file
	echo "Reversing to HEX.."
	./xxd -g 1 -c 1 -ps "${filename}.gb" > "${filename}.hex"

	raw_hex=$(cat "${filename}.hex")
	split_hex=""
	byte_count=1
	IFS=$'\n'
	for byte in $raw_hex; do
		if [ $((byte_count%10)) = 0 ]; then
			split_hex+="${byte}"$'\n'
		else
			split_hex+="${byte} "
		fi
		((byte_count++))
	done
	((byte_count--))
	split_hex+=$'\n\n'"Total Bytes: ${byte_count}"
	
	# Command 4: Output and cleanup
	split_hex="${split_hex%"${split_hex##*[![:space:]]}"}" # Remove trailing space

	printf "${split_hex}" > "${filename}.hex"

	if [ -e "${filename}.o" ]; then rm "${filename}.o"
	fi
	if [ -e "${filename}.gb" ]; then rm "${filename}.gb"
	fi

	xdg-open "${filename}.hex"
fi
