use std::{
    error::Error,
    process::{Command, Stdio, exit},
};

use dialoguer::{Select, console::Style, theme::ColorfulTheme};

use crate::{
    debug::{restart_bluetooth, restart_network_manager},
    mirrors::{refresh_keys, refresh_mirrors},
    packages::{
        install_flatpak_package, install_package, uninstall_aur_package, uninstall_flatpak,
        uninstall_package, update,
    },
};
mod debug;
mod mirrors;
mod packages;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    let options = vec!["Packages", "Mirrors", "Debug", "Exit"];

    let packages_options = vec![
        "Update",
        "Install Package",
        "Install Flatpak",
        "Uninstall Package",
        "Uninstall AUR Package",
        "Uninstall Flatpak",
        "Exit",
    ];

    let mirrors_options = vec!["Update Mirrors", "Update Keys", "Exit"];

    let debug_options = vec!["Restart Bluetooth", "Restart Network Manager", "Exit"];

    match Select::with_theme(&get_theme())
        .items(&options)
        .default(0)
        .interact()?
    {
        0 => match Select::with_theme(&get_theme())
            .items(packages_options)
            .default(0)
            .interact()?
        {
            0 => update()?,
            1 => install_package()?,
            2 => install_flatpak_package().await?,
            3 => uninstall_package()?,
            4 => uninstall_aur_package()?,
            5 => uninstall_flatpak()?,
            _ => exit(0),
        },

        1 => match Select::with_theme(&get_theme())
            .items(mirrors_options)
            .default(0)
            .interact()?
        {
            0 => refresh_mirrors()?,
            1 => refresh_keys()?,
            _ => exit(0),
        },

        2 => match Select::with_theme(&get_theme())
            .items(debug_options)
            .default(0)
            .interact()?
        {
            0 => restart_bluetooth()?,
            1 => restart_network_manager()?,
            _ => exit(0),
        },
        _ => exit(0),
    }

    Ok(())
}

pub fn get_theme() -> ColorfulTheme {
    let mut theme = ColorfulTheme::default();
    theme.active_item_style = Style::new().yellow();
    theme.active_item_prefix = Style::new().yellow().apply_to("".to_string());
    return theme;
}

pub fn run(full_command: Vec<&str>) -> Result<(), Box<dyn Error>> {
    let (main, args) = full_command.split_first().unwrap();

    Command::new(main)
        .args(args)
        .stdin(Stdio::inherit())
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .status()?;

    Ok(())
}
