use std::process::{Command, Stdio, exit};

use dialoguer::{Select, console::Style, theme::ColorfulTheme};

fn main() {
    let options = vec!["Update", "Refresh Mirrors", "Refresh GPG Keys", "Exit"];

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
