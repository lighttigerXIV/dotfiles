use std::process::{Command, Stdio, exit};

use dialoguer::{FuzzySelect, Select, console::Style, theme::ColorfulTheme};

fn main() {
    let options = vec![
        "Update",
        "Refresh Mirrors",
        "Refresh GPG Keys",
        "Uninstall Aur Package",
        "Uninstall Flatpak",
        "Exit",
    ];

    let mut theme = ColorfulTheme::default();
    theme.active_item_style = Style::new().yellow();
    theme.active_item_prefix = Style::new().yellow().apply_to(">".to_string());

    let selection = Select::with_theme(&theme)
        .with_prompt("Pick an option")
        .items(&options)
        .default(0)
        .interact()
        .unwrap();

    match selection {
        0 => {
            run(vec!["xdg-open", "https://archlinux.org/news/"]);
            run(vec!["sudo", "pacman", "-Syyu", "--noconfirm"]);
            run(vec!["sudo", "flatpak", "update", "-y"]);
        }
        1 => {
            run(vec![
                "sudo",
                "reflector",
                "--country",
                "PT",
                "--latest",
                "10",
                "--sort",
                "rate",
                "--save",
                "/etc/pacman.d/mirrorlist",
            ]);
        }
        2 => {
            run(vec!["sudo", "pacman-key", "--refresh-keys"]);
        }
        3 => {
            let command = Command::new("pacman").arg("-Qm").output().unwrap();

            if !command.status.success() {
                return;
            }

            let output = String::from_utf8_lossy(&command.stdout);
            let output_lines = output.lines();
            let packages = output_lines
                .map(|line| {
                    return line.split_whitespace().next().unwrap().to_string();
                })
                .collect::<Vec<String>>();

            let package_selection = FuzzySelect::with_theme(&theme)
                .with_prompt("Select package to uninstall")
                .items(&packages)
                .default(0)
                .interact()
                .unwrap();

            let package = packages.get(package_selection).unwrap();
            let debug_package = format!("{package}-debug");

            if packages.contains(&debug_package) {
                run(vec!["yay", "-Rns", &package, &debug_package]);
                return;
            }

            run(vec!["yay", "-Rns", &package]);
        }
        4 => {
            let command = Command::new("flatpak")
                .args(["list", "--columns=application"])
                .output()
                .unwrap();

            if !command.status.success() {
                return;
            }

            let output = String::from_utf8_lossy(&command.stdout);

            let packages: Vec<String> =
                output.lines().map(|line| line.trim().to_string()).collect();

            let package_selection = FuzzySelect::with_theme(&theme)
                .with_prompt("Select Flatpak to uninstall")
                .items(&packages)
                .default(0)
                .interact()
                .unwrap();

            let package = packages.get(package_selection).unwrap();

            run(vec!["flatpak", "uninstall", "-y", package]);
        }
        _ => {
            exit(0);
        }
    }
}

fn run(full_command: Vec<&str>) {
    let main = &full_command.get(0).unwrap();
    let mut args = full_command.clone();

    args.remove(0);

    Command::new(main)
        .args(args)
        .stdin(Stdio::inherit())
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .status()
        .unwrap();
}
