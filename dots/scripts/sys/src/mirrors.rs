use std::error::Error;

use crate::run;

pub fn refresh_mirrors() -> Result<(), Box<dyn Error>> {
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
    ])?;

    Ok(())
}

pub fn refresh_keys() -> Result<(), Box<dyn Error>> {
    run(vec!["sudo", "pacman-key", "--refresh-keys"])?;

    Ok(())
}
