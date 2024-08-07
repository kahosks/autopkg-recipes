import os
import re

import requests
from autopkglib import Processor, ProcessorError

__all___ = ["LinearWinDownloader"]

class LinearWinDownloader(Processor):
    description = "Downloads the latest version of Linear for Windows."
    input_variables = {
        "download_dir": {
            "required": False,
            "description": "The directory where the file will be downloaded to.",
        },
    }
    output_variables = {
        "filename": {
            "description": "The name of the downloaded file.",
        },
    }

    def get_download_dir(self):
        """Create download dir and return its path."""
        download_dir = self.env.get("download_dir") or os.path.join(
            self.env["RECIPE_CACHE_DIR"], "downloads"
        )
        if not os.path.exists(download_dir):
            try:
                os.makedirs(download_dir)
            except OSError as err:
                raise ProcessorError(f"Can't create {download_dir}: {err.strerror}")
        return download_dir

    def main(self):
        try:
            # Download the files
            URL = "https://desktop.linear.app/windows/nsis/x64"
            response = requests.get(URL, allow_redirects=True)
            response.raise_for_status()  # Raise an error for bad status codes

            # Extract filename from Content-Disposition header
            cd = response.headers.get('content-disposition')
            filename = (re.findall('filename=(.+)', cd))[0].strip('"') if cd else None
            if not filename:
                # Fallback to extracting filename from URL
                filename = URL.split('/')[-1]

            # Ensure the save directory exists
            download_dir = self.get_download_dir()
            os.makedirs(download_dir, exist_ok=True)

            # Save the content to a file
            file_path = os.path.join("source", filename)
            with open(file_path, 'wb') as file:
                file.write(response.content)

            print(f"File downloaded: {filename}")
            self.env["filename"] = filename
        except Exception as err:
            raise ProcessorError(err)

if __name__ == "__main__":
    PROCESSOR = LinearWinDownloader()
    PROCESSOR.execute_shell()