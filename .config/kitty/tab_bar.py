from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData,ExtraData, TabBarData. as_rgb, draw_title

def draw_title(draw_data: DrawData,
               screen: Screen,
               tab: TabBarData,
               before: int,
               max_title_length: int,
               index: int,
               is_last: bool,
               extra_data: ExtraData,
               ) -> int:
    screen.cursor.fg = as_rgb(0xffffff)
    screen.draw("it works")
    return screen.cursor.x
