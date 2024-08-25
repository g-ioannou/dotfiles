from ranger.api.commands import Command
import subprocess
from ranger.ext.img_display import ImageDisplayer, register_image_displayer
from shlex import quote


@register_image_displayer("wezterm-image-display-method")
class WeztermImageDisplayer(ImageDisplayer):
    def draw(self, path, start_x, start_y, width, height):
        print("\033[%d;%dH" % (start_y, start_x + 1))
        path = quote(path)
        draw_cmd = "wezterm imgcat {} --width {} --height {}".format(
            path, width, height
        )
        subprocess.run(draw_cmd.split(" "))

    def clear(self, start_x, start_y, width, height):
        cleaner = " " * width
        for i in range(height):
            print("\033[%d;%dH" % (start_y + i, start_x + 1))
            print(cleaner)


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
