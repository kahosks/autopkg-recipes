import os
import subprocess

from autopkglib import Processor, ProcessorError

__all__ = ["IntuneUploader"]

class IntuneUploader(Processor):
    input_variables = {
        "intunewin_path": {
            "required": True,
            "description": "The path to the intunewin file to be uploaded.",
        },
        "powershell_path": {
            "required": True,
            "description": "The path to the powershell executable.",
        },
        "app_name": {
            "required": True,
            "description": "The name of the app to be uploaded.",
        },
        "checking_root_path": {
            "required": True,
            "description": "The path to the installed program for checking.",
        },
        "checking_filefolder": {
            "required": True,
            "description": "The file or folder to be checked for.",
        },
        "install_command": {
            "required": True,
            "description": "The command to be run for installation.",
        },
        "uninstall_command": {
            "required": True,
            "description": "The command to be run for uninstallation.",
        },
        "description": {
            "required": True,
            "description": "The description of the app to be uploaded.",
        },
        "publisher": {
            "required": True,
            "description": "The publisher of the app to be uploaded.",
        },
        "version": {
            "required": True,
            "description": "The version of the app to be uploaded.",
        },
    }
    output_variables = {}

    def main(self):
        try:
            print("Uploading " + self.env.get("intunewin_path"))
            r = subprocess.Popen([
                self.env.get("powershell_path"),
                "IntuneProcessors/intune-add-win32.ps1",
                os.environ["ClientID"],
                os.environ["ClientSecret"],
                os.environ["TenantID"],
                self.env.get("app_name"),
                self.env.get("intunewin_path"),
                self.env.get("checking_root_path"),
                self.env.get("checking_filefolder"),
                self.env.get("install_command"),
                self.env.get("uninstall_command"),
                self.env.get("description"),
                self.env.get("publisher"),
                self.env.get("version"),
                ], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            print(r.stdout.read().decode().strip())
        except Exception as err:
            raise ProcessorError(err)
        
if __name__ == "__main__":
    PROCESSOR = IntuneUploader()
    PROCESSOR.execute_shell()