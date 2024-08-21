from ranger.api.commands import Command
import subprocess


class open_in_tmux_pane(Command):
    def execute(self):
        # Get the path of the selected file
        path = self.fm.thisfile.path

        # Write the selected file path to a temporary file
        with open("/tmp/ranger_choice", "w") as f:
            f.write(str(path))
        # Execute the script to open the file in the original pane
        subprocess.run(
            ["zsh -c 'source ~/.zshrc; ranger_open_in_pane'"],
            executable="/bin/zsh",
            shell=True,
        )
