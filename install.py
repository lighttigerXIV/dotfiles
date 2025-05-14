import os
from pathlib import Path
import subprocess

current_dir = os.path.dirname(os.path.abspath(__file__))
configs_dir = Path(current_dir) / "configs"

for dir in configs_dir.iterdir():
    name = dir.name
    print(f"🫂 Symlinking {name}")
    subprocess.run(f"stow {name} -t ~", shell=True, cwd=configs_dir)


print("✅ Done")

