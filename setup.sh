echo "Creating python virtual environment:"
venv_directory=testmatrix_venv
python3 -m venv $venv_directory --system-site-packages
source $venv_directory/bin/activate
echo "Virtual environment activated"

echo "Creating systemd service:"
install_path=$(pwd)
systemd_name=testmatrix
sudo cp ./config/testmatrix.service /etc/systemd/system/
sudo sed -i -e "/\[Service\]/a ExecStart=${install_path}/${venv_directory}/bin/python3 ${install_path}/runtext.py" /etc/systemd/system/$systemd_name.service
sudo systemctl daemon-reload
sudo systemctl start $systemd_name
sudo systemctl enable $systemd_name
echo "...done"