use std::{error::Error, process::Command};

use dialoguer::{FuzzySelect, Input};
use serde::Deserialize;

use crate::{get_theme, run};

#[derive(Deserialize, Debug)]
struct SearchResponse {
    hits: Vec<SearchHit>,
}

#[derive(Deserialize, Debug)]
struct SearchHit {
    pub name: String,
    pub summary: Option<String>,
    pub app_id: String,
}

pub fn update() -> Result<(), Box<dyn Error>> {
    run(vec!["xdg-open", "https://archlinux.org/news/"])?;
    run(vec!["sudo", "pacman", "-Syyu", "--noconfirm"])?;
    run(vec!["sudo", "flatpak", "update", "-y"])?;

    Ok(())
}

pub fn install_package() -> Result<(), Box<dyn Error>> {
    let package: String = Input::with_theme(&get_theme())
        .with_prompt("Package Name")
        .interact_text()?;

    run(vec!["yay", &package])?;

    Ok(())
}

pub async fn install_flatpak_package() -> Result<(), Box<dyn Error>> {
    let app: String = Input::with_theme(&get_theme())
        .with_prompt("Package Name")
        .interact_text()?;

    let client = reqwest::Client::new();
    let body = serde_json::json!({ "query": app });

    let resp: SearchResponse = client
        .post("https://flathub.org/api/v2/search")
        .json(&body)
        .send()
        .await?
        .json()
        .await?;

    let apps = resp.hits;

    let apps_options = apps
        .iter()
        .map(|app| format!("{} - {}", app.name, app.summary.as_deref().unwrap_or("")))
        .collect::<Vec<String>>();

    let option = FuzzySelect::with_theme(&get_theme())
        .with_prompt("Packages:")
        .items(&apps_options)
        .default(0)
        .interact()?;

    let app_id = &apps[option].app_id;

    run(vec!["flatpak", "install", "-y", "flathub", app_id])?;

    Ok(())
}

pub fn uninstall_package() -> Result<(), Box<dyn Error>> {
    let command = Command::new("pacman").arg("-Q").output()?;

    if !command.status.success() {
        return Ok(());
    }

    let output = String::from_utf8_lossy(&command.stdout);

    let packages = output
        .lines()
        .filter_map(|line| line.split_whitespace().next())
        .map(String::from)
        .collect::<Vec<String>>();

    let package_selection = FuzzySelect::with_theme(&get_theme())
        .with_prompt("Select package to uninstall")
        .items(&packages)
        .default(0)
        .interact()?;

    let package = &packages[package_selection];

    run(vec!["sudo", "pacman", "-Rns", package])?;

    Ok(())
}

pub fn uninstall_aur_package() -> Result<(), Box<dyn Error>> {
    let command = Command::new("pacman").arg("-Qm").output()?;

    if !command.status.success() {
        return Ok(());
    }

    let output = String::from_utf8_lossy(&command.stdout);
    let packages = output
        .lines()
        .filter_map(|line| line.split_whitespace().next())
        .map(String::from)
        .collect::<Vec<String>>();

    let package_selection = FuzzySelect::with_theme(&get_theme())
        .with_prompt("Select package to uninstall")
        .items(&packages)
        .default(0)
        .interact()?;

    let package = &packages[package_selection];
    let debug_package = format!("{package}-debug");

    if packages.contains(&debug_package) {
        run(vec!["yay", "-Rns", &package, &debug_package])?;
        return Ok(());
    }

    run(vec!["yay", "-Rns", &package])?;

    Ok(())
}

pub fn uninstall_flatpak() -> Result<(), Box<dyn Error>> {
    let command = Command::new("flatpak")
        .args(["list", "--columns=application"])
        .output()?;

    if !command.status.success() {
        return Ok(());
    }

    let output = String::from_utf8_lossy(&command.stdout);

    let packages: Vec<String> = output.lines().map(|line| line.trim().to_string()).collect();

    let package_selection = FuzzySelect::with_theme(&get_theme())
        .with_prompt("Select Flatpak to uninstall")
        .items(&packages)
        .default(0)
        .interact()?;

    let package = &packages[package_selection];

    run(vec!["flatpak", "uninstall", "-y", package])?;

    Ok(())
}
