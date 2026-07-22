use std::error::Error;

use crate::run;

pub fn restart_bluetooth() -> Result<(), Box<dyn Error>> {
    run(vec!["sudo", "systemctl", "restart", "bluetooth"])?;
    Ok(())
}

pub fn restart_network_manager() -> Result<(), Box<dyn Error>> {
    run(vec!["sudo", "systemctl", "restart", "NetworkManager"])?;
    Ok(())
}
