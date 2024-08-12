import re

from autopkglib import Processor, ProcessorError

__all__ = ["LinearVersioner"]

class LinearVersioner(Processor):
    input_variables = {
        "file_name": {
            "required": True,
            "description": "The filename to extract the version from.",
        },
    }
    output_variables = {
        "version": {
            "description": "The version of the installer.",
        },
    }

    def main(self):
        try:
            filename=self.env.get("file_name")
            print(filename)
            match = re.search(r"(?<=Linear Setup ).*(?= - x64\.exe)", filename)
            if match:
                print("Version: " + match.group(0))
                self.env["version"] = match.group(0)
            else:
                raise ProcessorError("Version not found")
        except Exception as err:
            raise ProcessorError(err)
        
if __name__ == "__main__":
    PROCESSOR = LinearVersioner()
    PROCESSOR.execute_shell()