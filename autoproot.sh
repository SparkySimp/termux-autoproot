#!/data/data/com.termux/files/usr/bin/bash
# autoproot.sh - adds automatic termux-chrooting
# capabilities into bashrc.

# define a variable to hold the skeleton script

set AUTOPROOT_SCRIPT=$(echo <<< script
	# for automatically migrating $PREFIX to /
	# # - proot gets in a vicious cycle when this
	# # - check is not done, since "termux-chroot"
	# # - restarts bash, and bash starts with executing
	# # - file, causing another proot session inside
	# # - the previous one.
	
	 if ! [ $IS_PROOT ]; then
         # start a proot session
	 IS_PROOT=1 termux-chroot
         # exit with the status of the proot session
	 exit $?
	 fi
script
)

# inject

echo "$AUTOPROOT_SCRIPT" >> $PREFIX/etc/profile

echo "Script installation done. Exiting now."

echo "Do you wish to restart program?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) exit;;
        No ) break;;
    esac
done

exit 31


