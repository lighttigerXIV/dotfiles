use std::{
    error::Error,
    path::PathBuf,
    process::{Command, exit},
};

use colored::Colorize;
use dialoguer::{Input, MultiSelect, Select, console::Style, theme::ColorfulTheme};

#[derive(Debug)]
struct FileChange {
    pub path: String,
    pub code: Code,
}

#[derive(Debug)]
enum Code {
    New,
    Modified,
    Deleted,
    Unknown,
}

#[derive(Debug, PartialEq)]
enum CommitType {
    Feature,
    Update,
    Fix,
    Refactor,
    Custom,
}

impl FileChange {
    fn display(&self) -> String {
        match self.code {
            Code::New => format!("New: {}", self.path).green(),
            Code::Modified => format!("Modified: {}", self.path).yellow(),
            Code::Deleted => format!("Deleted: {}", self.path).red(),
            Code::Unknown => format!("Unknown: {}", self.path).normal(),
        }
        .to_string()
    }
}

fn main() -> Result<(), Box<dyn Error>> {
    loop {
        let changes = get_changes()?;
        let options = vec!["See Changes", "Commit", "Exit"];
        let commit_options = vec!["Feature", "Update", "Fix", "Refactor", "Custom", "Exit"];

        match Select::with_theme(&get_theme())
            .items(&options)
            .default(0)
            .interact()?
        {
            0 => {
                for change in &changes {
                    println!("{}", change.display());
                }

                println!();
            }
            1 => {
                let commit_type = match Select::with_theme(&get_theme())
                    .items(&commit_options)
                    .default(0)
                    .interact()?
                {
                    0 => CommitType::Feature,
                    1 => CommitType::Update,
                    2 => CommitType::Fix,
                    3 => CommitType::Refactor,
                    4 => CommitType::Custom,
                    _ => continue,
                };

                let files: Vec<&str> = changes.iter().map(|change| change.path.as_str()).collect();

                let selected_files_indexes = MultiSelect::with_theme(&get_theme())
                    .with_prompt("Select the files for the commit")
                    .items(&files)
                    .defaults(&vec![true; files.len()])
                    .interact()?;

                let mut scope = String::new();
                let mut info = String::new();

                if commit_type != CommitType::Custom {
                    scope = Input::with_theme(&get_theme())
                        .with_prompt("What's the commit scope?")
                        .interact_text()?;

                    info = Input::with_theme(&get_theme())
                        .with_prompt("Info")
                        .allow_empty(true)
                        .interact_text()?;
                }

                let final_message = match commit_type {
                    CommitType::Feature => {
                        if info.trim().is_empty() {
                            format!("feat({scope})")
                        } else {
                            format!("feat({scope}): {info}")
                        }
                    }
                    CommitType::Update => {
                        if info.trim().is_empty() {
                            format!("update({scope})")
                        } else {
                            format!("update({scope}): {info}")
                        }
                    }
                    CommitType::Fix => {
                        if info.trim().is_empty() {
                            format!("fix({scope})")
                        } else {
                            format!("fix({scope}): {info}")
                        }
                    }
                    CommitType::Refactor => {
                        if info.trim().is_empty() {
                            format!("refact({scope})")
                        } else {
                            format!("refact({scope}): {info}")
                        }
                    }
                    CommitType::Custom => Input::with_theme(&get_theme())
                        .with_prompt("Custom Commit")
                        .interact_text()?,
                };

                let root_path_output = Command::new("git")
                    .args(["rev-parse", "--show-toplevel"])
                    .output()?;

                let root_path_str = String::from_utf8_lossy(&root_path_output.stdout)
                    .trim()
                    .to_string();

                let root_path = PathBuf::from(&root_path_str);

                let selected_changes: Vec<&str> = selected_files_indexes
                    .into_iter()
                    .map(|index| files[index])
                    .collect();

                for change in &selected_changes {
                    Command::new("git")
                        .arg("add")
                        .arg(change)
                        .current_dir(&root_path)
                        .status()?;
                }

                Command::new("git")
                    .args(vec!["commit", "-m", &final_message])
                    .current_dir(&root_path)
                    .status()?;

                Command::new("git")
                    .arg("push")
                    .current_dir(&root_path)
                    .status()?;

                exit(0);
            }
            _ => exit(0),
        }
    }
}

fn get_changes() -> Result<Vec<FileChange>, Box<dyn Error>> {
    let output = Command::new("git")
        .args(["status", "--porcelain"])
        .output()?;

    if !output.status.success() {
        return Ok(vec![]);
    }

    let stdout = String::from_utf8_lossy(&output.stdout);

    let changes: Vec<FileChange> = stdout
        .lines()
        .map(|line| {
            let split: Vec<&str> = line.split_whitespace().collect();
            let (code, path) = split.split_first().unwrap();

            FileChange {
                path: path.join(" ").replace("\"", "").to_owned(),
                code: match code.trim() {
                    "??" => Code::New,
                    "M" | "MM" => Code::Modified,
                    "A" => Code::New,
                    "D" => Code::Deleted,
                    "R" => Code::Modified,
                    "C" => Code::Modified,
                    _ => Code::Unknown,
                },
            }
        })
        .collect();

    Ok(changes)
}

pub fn get_theme() -> ColorfulTheme {
    let mut theme = ColorfulTheme::default();
    theme.active_item_style = Style::new().yellow();
    theme.active_item_prefix = Style::new().yellow().apply_to("".to_string());
    return theme;
}
