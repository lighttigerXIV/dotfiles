use std::{error::Error, fs, path::PathBuf, process::Command};

use regex::Regex;

fn remove_bs(input: &str) -> String {
    let re = Regex::new(r"\x1b\[[0-9;]*[mK]").unwrap();
    re.replace_all(input, "").into_owned().replace("\t", "").to_owned()
}

fn main() -> Result<(), Box<dyn Error>>{
    let mode_path = PathBuf::from("/home/lighttigerxiv/.cache/gaming-mode");

    if !mode_path.exists(){
        fs::write(&mode_path, "false")?;
    }

    let gaming_mode: bool = fs::read_to_string(&mode_path)?.parse()?;

    let outputs_result = Command::new("kscreen-doctor").arg("-o").output()?;
    let outputs = remove_bs(&String::from_utf8_lossy(&outputs_result.stdout).to_string());
    let outputs_split: Vec<&str> = outputs.split("\n").collect();

    let mut screen_id = -1;
    let mut gaming_quality_id = -1; 
    let mut work_quality_id = -1; 
    let mut screen_found = false;
    

    for line in outputs_split{
        if line.starts_with("Output:"){
            let line = line.to_string();
            let monitors_split = line.split_whitespace().collect::<Vec<&str>>();

            if monitors_split.get(2).unwrap() == &"HDMI-A-1"{
                screen_id = monitors_split.get(1).unwrap().parse().unwrap();
                screen_found = true;
            }
        }

        if line.starts_with("Modes:") && screen_found{
            let line = line.to_string();
            let modes_split = line.split_whitespace().collect::<Vec<&str>>();

            for mode in modes_split{
                let mode = mode.to_string();
                let mode_split = mode.split(":").collect::<Vec<&str>>();
                let mode_id = mode_split.get(0).unwrap().to_string();
                let resolution = mode_split.get(1).unwrap().to_string();

                if resolution.starts_with("2560x1440@1"){
                    work_quality_id = mode_id.parse().unwrap();
                }

                if resolution.starts_with("1920x1080@1"){
                    gaming_quality_id = mode_id.parse().unwrap();
                }
            }

            break;
        }
    }

    if gaming_mode{
        fs::write(&mode_path, "false")?;
        Command::new("kscreen-doctor").arg(format!("output.{screen_id}.mode.{work_quality_id}")).spawn()?;
        Command::new("notify-send").arg("🧳 Gaming Mode Disabled").spawn()?;
        return Ok(())
    }

    fs::write(&mode_path, "true")?;
    Command::new("kscreen-doctor").arg(format!("output.{screen_id}.mode.{gaming_quality_id}")).spawn()?;
    Command::new("notify-send").arg("🎮 Gaming Mode Enabled").spawn()?;

    Ok(())
}
