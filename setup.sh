install_path=$(pwd)
systemd_name=testmatrix

echo "Removing systemd service if it exists:"
sudo systemctl stop $systemd_name
sudo rm -rf /etc/systemd/system/$systemd_name.*
sudo systemctl daemon-reload
echo "...done"

echo "Creating systemd service:"
sudo cp ./config/$systemd_name.service /etc/systemd/system/
sudo sed -i -e "/\[Service\]/a ExecStart=python3 ${install_path}/runtext.py" /etc/systemd/system/$systemd_name.service
sudo systemctl daemon-reload
sudo systemctl start $systemd_name
sudo systemctl enable $systemd_name
echo "...done"