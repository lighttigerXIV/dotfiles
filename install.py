import os
from pathlib import Path
import subprocess
import json5
import sys

current_dir = os.path.dirname(os.path.abspath(__file__))
venv_dir = Path(current_dir) / "venv"
configs_dir = Path(current_dir) / "configs"
packages_dir = Path(current_dir) / "packages"

install_dots = True
install_packages = True
install_flatpaks = True
run_commands = True

args = sys.argv
if len(args) > 1:
    command = args[1]
    
    install_dots = command == "dots"
    install_packages = command == "packages"
    install_flatpaks = command == "flatpaks"
    run_commands = command == "commands"


def install_package(package):
    process = subprocess.run(f"yay -S {package} --noconfirm", shell=True, capture_output=True, text=True)

    if process.returncode != 0:
        print(process.stderr)

def install_flatpak(package):
    process = subprocess.run(f"flatpak install -y flathub {package}", shell=True, capture_output=True, text=True)

    if process.returncode != 0:
        print(process.stderr)

def run_command(command):
    subprocess.run(command, shell=True, text=True)

# Run Stow Commands
if install_dots:
    for dir in configs_dir.iterdir():
        name = dir.name
        print(f"🫂 Symlinking {name}")
        subprocess.run(f"stow {name} -t ~", shell=True, cwd=configs_dir)


packages_list = []
flatpaks_list = []
commands_list = []


# Install Packages
for root, dirs, files in os.walk(packages_dir):
    for file in files:
        path = Path(os.path.join(root, file))
        with path.open("r") as file:
            content = json5.load(file)

            if "packages" in content:
                for package in content["packages"]:
                    packages_list.append(package)

            if "flatpaks" in content:
                for flatpak in content["flatpaks"]:
                    flatpaks_list.append(flatpak)

            if "commands" in content:
                for command in content["commands"]:
                    commands_list.append(command)

if install_packages:
    for package in packages_list:
        print(f"📁 Installing {package}")
        install_package(package)

if install_flatpaks:
    for flatpak in flatpaks_list:
        print(f"🏪 Installing {flatpak}")
        install_flatpak(flatpak)

if run_commands:
    for command in commands_list:
        print(f"👓 Running command {command}")
        run_command(command)

print("✅ Everything installed successfully")