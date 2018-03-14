pragma Singleton

import QtQuick 2.9

FontLoader {
    id: _source
    source: "qrc:/AwesomeFontIcon.otf"
    property alias font: _source.name
    readonly property var iconsMap: {
        "500px": "\uf26e",
        "adjust": "\uf042",
        "adn": "\uf170",
        "align_center": "\uf037",
        "align_justify": "\uf039",
        "align_left": "\uf036",
        "align_right": "\uf038",
        "amazon": "\uf270",
        "ambulance": "\uf0f9",
        "american_sign_language_interpreting": "\uf2a3",
        "anchor": "\uf13d",
        "android": "\uf17b",
        "angellist": "\uf209",
        "angle_double_down": "\uf103",
        "angle_double_left": "\uf100",
        "angle_double_right": "\uf101",
        "angle_double_up": "\uf102",
        "angle_down": "\uf107",
        "angle_left": "\uf104",
        "angle_right": "\uf105",
        "angle_up": "\uf106",
        "apple": "\uf179",
        "archive": "\uf187",
        "area_chart": "\uf1fe",
        "arrow_circle_down": "\uf0ab",
        "arrow_circle_left": "\uf0a8",
        "arrow_circle_o_down": "\uf01a",
        "arrow_circle_o_left": "\uf190",
        "arrow_circle_o_right": "\uf18e",
        "arrow_circle_o_up": "\uf01b",
        "arrow_circle_right": "\uf0a9",
        "arrow_circle_up": "\uf0aa",
        "arrow_down": "\uf063",
        "arrow_left": "\uf060",
        "arrow_right": "\uf061",
        "arrow_up": "\uf062",
        "arrows": "\uf047",
        "arrows_alt": "\uf0b2",
        "arrows_h": "\uf07e",
        "arrows_v": "\uf07d",
        "asl_interpreting": "\uf2a3",
        "assistive_listening_systems": "\uf2a2",
        "asterisk": "\uf069",
        "at": "\uf1fa",
        "audio_description": "\uf29e",
        "automobile": "\uf1b9",
        "backward": "\uf04a",
        "balance_scale": "\uf24e",
        "ban": "\uf05e",
        "bank": "\uf19c",
        "bar_chart": "\uf080",
        "bar_chart_o": "\uf080",
        "barcode": "\uf02a",
        "bars": "\uf0c9",
        "battery_0": "\uf244",
        "battery_1": "\uf243",
        "battery_2": "\uf242",
        "battery_3": "\uf241",
        "battery_4": "\uf240",
        "battery_empty": "\uf244",
        "battery_full": "\uf240",
        "battery_half": "\uf242",
        "battery_quarter": "\uf243",
        "battery_three_quarters": "\uf241",
        "bed": "\uf236",
        "beer": "\uf0fc",
        "behance": "\uf1b4",
        "behance_square": "\uf1b5",
        "bell": "\uf0f3",
        "bell_o": "\uf0a2",
        "bell_slash": "\uf1f6",
        "bell_slash_o": "\uf1f7",
        "bicycle": "\uf206",
        "binoculars": "\uf1e5",
        "birthday_cake": "\uf1fd",
        "bitbucket": "\uf171",
        "bitbucket_square": "\uf172",
        "bitcoin": "\uf15a",
        "black_tie": "\uf27e",
        "blind": "\uf29d",
        "bluetooth": "\uf293",
        "bluetooth_b": "\uf294",
        "bold": "\uf032",
        "bolt": "\uf0e7",
        "bomb": "\uf1e2",
        "book": "\uf02d",
        "bookmark": "\uf02e",
        "bookmark_o": "\uf097",
        "braille": "\uf2a1",
        "briefcase": "\uf0b1",
        "btc": "\uf15a",
        "bug": "\uf188",
        "building": "\uf1ad",
        "building_o": "\uf0f7",
        "bullhorn": "\uf0a1",
        "bullseye": "\uf140",
        "bus": "\uf207",
        "buysellads": "\uf20d",
        "cab": "\uf1ba",
        "calculator": "\uf1ec",
        "calendar": "\uf073",
        "calendar_check_o": "\uf274",
        "calendar_minus_o": "\uf272",
        "calendar_o": "\uf133",
        "calendar_plus_o": "\uf271",
        "calendar_times_o": "\uf273",
        "camera": "\uf030",
        "camera_retro": "\uf083",
        "car": "\uf1b9",
        "caret_down": "\uf0d7",
        "caret_left": "\uf0d9",
        "caret_right": "\uf0da",
        "caret_square_o_down": "\uf150",
        "caret_square_o_left": "\uf191",
        "caret_square_o_right": "\uf152",
        "caret_square_o_up": "\uf151",
        "caret_up": "\uf0d8",
        "cart_arrow_down": "\uf218",
        "cart_plus": "\uf217",
        "cc": "\uf20a",
        "cc_amex": "\uf1f3",
        "cc_diners_club": "\uf24c",
        "cc_discover": "\uf1f2",
        "cc_jcb": "\uf24b",
        "cc_mastercard": "\uf1f1",
        "cc_paypal": "\uf1f4",
        "cc_stripe": "\uf1f5",
        "cc_visa": "\uf1f0",
        "certificate": "\uf0a3",
        "chain": "\uf0c1",
        "chain_broken": "\uf127",
        "check": "\uf00c",
        "check_circle": "\uf058",
        "check_circle_o": "\uf05d",
        "check_square": "\uf14a",
        "check_square_o": "\uf046",
        "chevron_circle_down": "\uf13a",
        "chevron_circle_left": "\uf137",
        "chevron_circle_right": "\uf138",
        "chevron_circle_up": "\uf139",
        "chevron_down": "\uf078",
        "chevron_left": "\uf053",
        "chevron_right": "\uf054",
        "chevron_up": "\uf077",
        "child": "\uf1ae",
        "chrome": "\uf268",
        "circle": "\uf111",
        "circle_o": "\uf10c",
        "circle_o_notch": "\uf1ce",
        "circle_thin": "\uf1db",
        "clipboard": "\uf0ea",
        "clock_o": "\uf017",
        "clone": "\uf24d",
        "close": "\uf00d",
        "cloud": "\uf0c2",
        "cloud_download": "\uf0ed",
        "cloud_upload": "\uf0ee",
        "cny": "\uf157",
        "code": "\uf121",
        "code_fork": "\uf126",
        "codepen": "\uf1cb",
        "codiepie": "\uf284",
        "coffee": "\uf0f4",
        "cog": "\uf013",
        "cogs": "\uf085",
        "columns": "\uf0db",
        "comment": "\uf075",
        "comment_o": "\uf0e5",
        "commenting": "\uf27a",
        "commenting_o": "\uf27b",
        "comments": "\uf086",
        "comments_o": "\uf0e6",
        "compass": "\uf14e",
        "compress": "\uf066",
        "connectdevelop": "\uf20e",
        "contao": "\uf26d",
        "copy": "\uf0c5",
        "copyright": "\uf1f9",
        "creative_commons": "\uf25e",
        "credit_card": "\uf09d",
        "credit_card_alt": "\uf283",
        "crop": "\uf125",
        "crosshairs": "\uf05b",
        "css3": "\uf13c",
        "cube": "\uf1b2",
        "cubes": "\uf1b3",
        "cut": "\uf0c4",
        "cutlery": "\uf0f5",
        "dashboard": "\uf0e4",
        "dashcube": "\uf210",
        "database": "\uf1c0",
        "deaf": "\uf2a4",
        "deafness": "\uf2a4",
        "dedent": "\uf03b",
        "delicious": "\uf1a5",
        "desktop": "\uf108",
        "deviantart": "\uf1bd",
        "diamond": "\uf219",
        "digg": "\uf1a6",
        "dollar": "\uf155",
        "dot_circle_o": "\uf192",
        "download": "\uf019",
        "dribbble": "\uf17d",
        "dropbox": "\uf16b",
        "drupal": "\uf1a9",
        "edge": "\uf282",
        "edit": "\uf044",
        "eject": "\uf052",
        "ellipsis_h": "\uf141",
        "ellipsis_v": "\uf142",
        "empire": "\uf1d1",
        "envelope": "\uf0e0",
        "envelope_o": "\uf003",
        "envelope_square": "\uf199",
        "envira": "\uf299",
        "eraser": "\uf12d",
        "eur": "\uf153",
        "euro": "\uf153",
        "exchange": "\uf0ec",
        "exclamation": "\uf12a",
        "exclamation_circle": "\uf06a",
        "exclamation_triangle": "\uf071",
        "expand": "\uf065",
        "expeditedssl": "\uf23e",
        "external_link": "\uf08e",
        "external_link_square": "\uf14c",
        "eye": "\uf06e",
        "eye_slash": "\uf070",
        "eyedropper": "\uf1fb",
        "fa": "\uf2b4",
        "facebook": "\uf09a",
        "facebook_f": "\uf09a",
        "facebook_official": "\uf230",
        "facebook_square": "\uf082",
        "fast_backward": "\uf049",
        "fast_forward": "\uf050",
        "fax": "\uf1ac",
        "feed": "\uf09e",
        "female": "\uf182",
        "fighter_jet": "\uf0fb",
        "file": "\uf15b",
        "file_archive_o": "\uf1c6",
        "file_audio_o": "\uf1c7",
        "file_code_o": "\uf1c9",
        "file_excel_o": "\uf1c3",
        "file_image_o": "\uf1c5",
        "file_movie_o": "\uf1c8",
        "file_o": "\uf016",
        "file_pdf_o": "\uf1c1",
        "file_photo_o": "\uf1c5",
        "file_picture_o": "\uf1c5",
        "file_powerpoint_o": "\uf1c4",
        "file_sound_o": "\uf1c7",
        "file_text": "\uf15c",
        "file_text_o": "\uf0f6",
        "file_video_o": "\uf1c8",
        "file_word_o": "\uf1c2",
        "file_zip_o": "\uf1c6",
        "files_o": "\uf0c5",
        "film": "\uf008",
        "filter": "\uf0b0",
        "fire": "\uf06d",
        "fire_extinguisher": "\uf134",
        "firefox": "\uf269",
        "first_order": "\uf2b0",
        "flag": "\uf024",
        "flag_checkered": "\uf11e",
        "flag_o": "\uf11d",
        "flash": "\uf0e7",
        "flask": "\uf0c3",
        "flickr": "\uf16e",
        "floppy_o": "\uf0c7",
        "folder": "\uf07b",
        "folder_o": "\uf114",
        "folder_open": "\uf07c",
        "folder_open_o": "\uf115",
        "font": "\uf031",
        "font_awesome": "\uf2b4",
        "fonticons": "\uf280",
        "fort_awesome": "\uf286",
        "forumbee": "\uf211",
        "forward": "\uf04e",
        "foursquare": "\uf180",
        "frown_o": "\uf119",
        "futbol_o": "\uf1e3",
        "gamepad": "\uf11b",
        "gavel": "\uf0e3",
        "gbp": "\uf154",
        "ge": "\uf1d1",
        "gear": "\uf013",
        "gears": "\uf085",
        "get_pocket": "\uf265",
        "gg": "\uf260",
        "gg_circle": "\uf261",
        "gift": "\uf06b",
        "git": "\uf1d3",
        "git_square": "\uf1d2",
        "github": "\uf09b",
        "github_alt": "\uf113",
        "github_square": "\uf092",
        "gitlab": "\uf296",
        "gittip": "\uf184",
        "glass": "\uf000",
        "glide": "\uf2a5",
        "glide_g": "\uf2a6",
        "globe": "\uf0ac",
        "google": "\uf1a0",
        "google_plus": "\uf0d5",
        "google_plus_circle": "\uf2b3",
        "google_plus_official": "\uf2b3",
        "google_plus_square": "\uf0d4",
        "google_wallet": "\uf1ee",
        "graduation_cap": "\uf19d",
        "gratipay": "\uf184",
        "group": "\uf0c0",
        "h_square": "\uf0fd",
        "hacker_news": "\uf1d4",
        "hand_grab_o": "\uf255",
        "hand_lizard_o": "\uf258",
        "hand_o_down": "\uf0a7",
        "hand_o_left": "\uf0a5",
        "hand_o_right": "\uf0a4",
        "hand_o_up": "\uf0a6",
        "hand_paper_o": "\uf256",
        "hand_peace_o": "\uf25b",
        "hand_pointer_o": "\uf25a",
        "hand_rock_o": "\uf255",
        "hand_scissors_o": "\uf257",
        "hand_spock_o": "\uf259",
        "hand_stop_o": "\uf256",
        "hard_of_hearing": "\uf2a4",
        "hashtag": "\uf292",
        "hdd_o": "\uf0a0",
        "header": "\uf1dc",
        "headphones": "\uf025",
        "heart": "\uf004",
        "heart_o": "\uf08a",
        "heartbeat": "\uf21e",
        "history": "\uf1da",
        "home": "\uf015",
        "hospital_o": "\uf0f8",
        "hotel": "\uf236",
        "hourglass": "\uf254",
        "hourglass_1": "\uf251",
        "hourglass_2": "\uf252",
        "hourglass_3": "\uf253",
        "hourglass_end": "\uf253",
        "hourglass_half": "\uf252",
        "hourglass_o": "\uf250",
        "hourglass_start": "\uf251",
        "houzz": "\uf27c",
        "html5": "\uf13b",
        "i_cursor": "\uf246",
        "ils": "\uf20b",
        "image": "\uf03e",
        "inbox": "\uf01c",
        "indent": "\uf03c",
        "industry": "\uf275",
        "info": "\uf129",
        "info_circle": "\uf05a",
        "inr": "\uf156",
        "instagram": "\uf16d",
        "institution": "\uf19c",
        "internet_explorer": "\uf26b",
        "ioxhost": "\uf208",
        "italic": "\uf033",
        "joomla": "\uf1aa",
        "jpy": "\uf157",
        "jsfiddle": "\uf1cc",
        "key": "\uf084",
        "keyboard_o": "\uf11c",
        "krw": "\uf159",
        "language": "\uf1ab",
        "laptop": "\uf109",
        "lastfm": "\uf202",
        "lastfm_square": "\uf203",
        "leaf": "\uf06c",
        "leanpub": "\uf212",
        "legal": "\uf0e3",
        "lemon_o": "\uf094",
        "level_down": "\uf149",
        "level_up": "\uf148",
        "life_bouy": "\uf1cd",
        "life_buoy": "\uf1cd",
        "life_ring": "\uf1cd",
        "life_saver": "\uf1cd",
        "lightbulb_o": "\uf0eb",
        "line_chart": "\uf201",
        "link": "\uf0c1",
        "linkedin": "\uf0e1",
        "linkedin_square": "\uf08c",
        "linux": "\uf17c",
        "list": "\uf03a",
        "list_alt": "\uf022",
        "list_ol": "\uf0cb",
        "list_ul": "\uf0ca",
        "location_arrow": "\uf124",
        "lock": "\uf023",
        "long_arrow_down": "\uf175",
        "long_arrow_left": "\uf177",
        "long_arrow_right": "\uf178",
        "long_arrow_up": "\uf176",
        "low_vision": "\uf2a8",
        "magic": "\uf0d0",
        "magnet": "\uf076",
        "mail_forward": "\uf064",
        "mail_reply": "\uf112",
        "mail_reply_all": "\uf122",
        "male": "\uf183",
        "map": "\uf279",
        "map_marker": "\uf041",
        "map_o": "\uf278",
        "map_pin": "\uf276",
        "map_signs": "\uf277",
        "mars": "\uf222",
        "venus_mars": "\uf228",
        "maxcdn": "\uf136",
        "meanpath": "\uf20c",
        "medium": "\uf23a",
        "medkit": "\uf0fa",
        "meh_o": "\uf11a",
        "microphone": "\uf130",
        "microphone_slash": "\uf131",
        "minus": "\uf068",
        "minus_circle": "\uf056",
        "minus_square": "\uf146",
        "minus_square_o": "\uf147",
        "mixcloud": "\uf289",
        "mobile": "\uf10b",
        "mobile_phone": "\uf10b",
        "modx": "\uf285",
        "money": "\uf0d6",
        "moon_o": "\uf186",
        "mortar_board": "\uf19d",
        "motorcycle": "\uf21c",
        "mouse_pointer": "\uf245",
        "music": "\uf001",
        "navicon": "\uf0c9",
        "newspaper_o": "\uf1ea",
        "object_group": "\uf247",
        "object_ungroup": "\uf248",
        "odnoklassniki": "\uf263",
        "odnoklassniki_square": "\uf264",
        "opencart": "\uf23d",
        "openid": "\uf19b",
        "opera": "\uf26a",
        "optin_monster": "\uf23c",
        "outdent": "\uf03b",
        "pagelines": "\uf18c",
        "paint_brush": "\uf1fc",
        "paper_plane": "\uf1d8",
        "paper_plane_o": "\uf1d9",
        "paperclip": "\uf0c6",
        "paragraph": "\uf1dd",
        "paste": "\uf0ea",
        "pause": "\uf04c",
        "pause_circle": "\uf28b",
        "pause_circle_o": "\uf28c",
        "paw": "\uf1b0",
        "paypal": "\uf1ed",
        "pencil": "\uf040",
        "pencil_square": "\uf14b",
        "pencil_square_o": "\uf044",
        "percent": "\uf295",
        "phone": "\uf095",
        "phone_square": "\uf098",
        "photo": "\uf03e",
        "picture_o": "\uf03e",
        "pie_chart": "\uf200",
        "pied_piper": "\uf2ae",
        "pied_piper_alt": "\uf1a8",
        "pied_piper_pp": "\uf1a7",
        "pinterest": "\uf0d2",
        "pinterest_p": "\uf231",
        "pinterest_square": "\uf0d3",
        "plane": "\uf072",
        "play": "\uf04b",
        "play_circle": "\uf144",
        "play_circle_o": "\uf01d",
        "plug": "\uf1e6",
        "plus": "\uf067",
        "plus_circle": "\uf055",
        "plus_square": "\uf0fe",
        "plus_square_o": "\uf196",
        "power_off": "\uf011",
        "print": "\uf02f",
        "product_hunt": "\uf288",
        "puzzle_piece": "\uf12e",
        "qq": "\uf1d6",
        "qrcode": "\uf029",
        "question": "\uf128",
        "question_circle": "\uf059",
        "question_circle_o": "\uf29c",
        "quote_left": "\uf10d",
        "quote_right": "\uf10e",
        "ra": "\uf1d0",
        "random": "\uf074",
        "rebel": "\uf1d0",
        "recycle": "\uf1b8",
        "reddit": "\uf1a1",
        "reddit_alien": "\uf281",
        "reddit_square": "\uf1a2",
        "refresh": "\uf021",
        "registered": "\uf25d",
        "remove": "\uf00d",
        "renren": "\uf18b",
        "reorder": "\uf0c9",
        "repeat": "\uf01e",
        "reply": "\uf112",
        "reply_all": "\uf122",
        "resistance": "\uf1d0",
        "retweet": "\uf079",
        "rmb": "\uf157",
        "road": "\uf018",
        "rocket": "\uf135",
        "rotate_left": "\uf0e2",
        "rotate_right": "\uf01e",
        "rouble": "\uf158",
        "rss": "\uf09e",
        "rss_square": "\uf143",
        "rub": "\uf158",
        "ruble": "\uf158",
        "rupee": "\uf156",
        "safari": "\uf267",
        "save": "\uf0c7",
        "scissors": "\uf0c4",
        "scribd": "\uf28a",
        "search": "\uf002",
        "search_minus": "\uf010",
        "search_plus": "\uf00e",
        "sellsy": "\uf213",
        "send": "\uf1d8",
        "send_o": "\uf1d9",
        "server": "\uf233",
        "share": "\uf064",
        "share_alt": "\uf1e0",
        "share_alt_square": "\uf1e1",
        "share_square": "\uf14d",
        "share_square_o": "\uf045",
        "shekel": "\uf20b",
        "sheqel": "\uf20b",
        "shield": "\uf132",
        "ship": "\uf21a",
        "shirtsinbulk": "\uf214",
        "shopping_bag": "\uf290",
        "shopping_basket": "\uf291",
        "shopping_cart": "\uf07a",
        "sign_in": "\uf090",
        "sign_language": "\uf2a7",
        "sign_out": "\uf08b",
        "signal": "\uf012",
        "signing": "\uf2a7",
        "simplybuilt": "\uf215",
        "sitemap": "\uf0e8",
        "skyatlas": "\uf216",
        "skype": "\uf17e",
        "slack": "\uf198",
        "sliders": "\uf1de",
        "slideshare": "\uf1e7",
        "smile_o": "\uf118",
        "snapchat": "\uf2ab",
        "snapchat_ghost": "\uf2ac",
        "snapchat_square": "\uf2ad",
        "soccer_ball_o": "\uf1e3",
        "sort": "\uf0dc",
        "sort_alpha_asc": "\uf15d",
        "sort_alpha_desc": "\uf15e",
        "sort_amount_asc": "\uf160",
        "sort_amount_desc": "\uf161",
        "sort_asc": "\uf0de",
        "sort_desc": "\uf0dd",
        "sort_down": "\uf0dd",
        "sort_numeric_asc": "\uf162",
        "sort_numeric_desc": "\uf163",
        "sort_up": "\uf0de",
        "soundcloud": "\uf1be",
        "space_shuttle": "\uf197",
        "spinner": "\uf110",
        "spoon": "\uf1b1",
        "spotify": "\uf1bc",
        "square": "\uf0c8",
        "square_o": "\uf096",
        "stack_exchange": "\uf18d",
        "stack_overflow": "\uf16c",
        "star": "\uf005",
        "star_half": "\uf089",
        "star_half_empty": "\uf123",
        "star_half_full": "\uf123",
        "star_half_o": "\uf123",
        "star_o": "\uf006",
        "steam": "\uf1b6",
        "steam_square": "\uf1b7",
        "step_backward": "\uf048",
        "step_forward": "\uf051",
        "stethoscope": "\uf0f1",
        "sticky_note": "\uf249",
        "sticky_note_o": "\uf24a",
        "stop": "\uf04d",
        "stop_circle": "\uf28d",
        "stop_circle_o": "\uf28e",
        "street_view": "\uf21d",
        "strikethrough": "\uf0cc",
        "stumbleupon": "\uf1a4",
        "stumbleupon_circle": "\uf1a3",
        "subscript": "\uf12c",
        "subway": "\uf239",
        "suitcase": "\uf0f2",
        "sun_o": "\uf185",
        "superscript": "\uf12b",
        "support": "\uf1cd",
        "table": "\uf0ce",
        "tablet": "\uf10a",
        "tachometer": "\uf0e4",
        "tag": "\uf02b",
        "tags": "\uf02c",
        "tasks": "\uf0ae",
        "taxi": "\uf1ba",
        "television": "\uf26c",
        "tencent_weibo": "\uf1d5",
        "terminal": "\uf120",
        "text_height": "\uf034",
        "text_width": "\uf035",
        "th": "\uf00a",
        "th_large": "\uf009",
        "th_list": "\uf00b",
        "themeisle": "\uf2b2",
        "thumb_tack": "\uf08d",
        "thumbs_down": "\uf165",
        "thumbs_o_down": "\uf088",
        "thumbs_o_up": "\uf087",
        "thumbs_up": "\uf164",
        "ticket": "\uf145",
        "times": "\uf00d",
        "times_circle": "\uf057",
        "times_circle_o": "\uf05c",
        "tint": "\uf043",
        "toggle_down": "\uf150",
        "toggle_left": "\uf191",
        "toggle_off": "\uf204",
        "toggle_on": "\uf205",
        "toggle_right": "\uf152",
        "toggle_up": "\uf151",
        "trademark": "\uf25c",
        "train": "\uf238",
        "transgender_alt": "\uf225",
        "trash": "\uf1f8",
        "trash_o": "\uf014",
        "tree": "\uf1bb",
        "trello": "\uf181",
        "tripadvisor": "\uf262",
        "trophy": "\uf091",
        "truck": "\uf0d1",
        "try": "\uf195",
        "tty": "\uf1e4",
        "tumblr": "\uf173",
        "tumblr_square": "\uf174",
        "turkish_lira": "\uf195",
        "tv": "\uf26c",
        "twitch": "\uf1e8",
        "twitter": "\uf099",
        "twitter_square": "\uf081",
        "umbrella": "\uf0e9",
        "underline": "\uf0cd",
        "undo": "\uf0e2",
        "universal_access": "\uf29a",
        "university": "\uf19c",
        "unlink": "\uf127",
        "unlock": "\uf09c",
        "unlock_alt": "\uf13e",
        "unsorted": "\uf0dc",
        "upload": "\uf093",
        "usb": "\uf287",
        "usd": "\uf155",
        "user": "\uf007",
        "user_md": "\uf0f0",
        "user_plus": "\uf234",
        "user_secret": "\uf21b",
        "user_times": "\uf235",
        "users": "\uf0c0",
        "venus": "\uf221",
        "viacoin": "\uf237",
        "viadeo": "\uf2a9",
        "viadeo_square": "\uf2aa",
        "video_camera": "\uf03d",
        "vimeo": "\uf27d",
        "vimeo_square": "\uf194",
        "vine": "\uf1ca",
        "vk": "\uf189",
        "volume_control_phone": "\uf2a0",
        "volume_down": "\uf027",
        "volume_off": "\uf026",
        "volume_up": "\uf028",
        "warning": "\uf071",
        "wechat": "\uf1d7",
        "weibo": "\uf18a",
        "weixin": "\uf1d7",
        "whatsapp": "\uf232",
        "wheelchair": "\uf193",
        "wheelchair_alt": "\uf29b",
        "wifi": "\uf1eb",
        "wikipedia_w": "\uf266",
        "windows": "\uf17a",
        "won": "\uf159",
        "wordpress": "\uf19a",
        "wpbeginner": "\uf297",
        "wpforms": "\uf298",
        "wrench": "\uf0ad",
        "xing": "\uf168",
        "xing_square": "\uf169",
        "y_combinator": "\uf23b",
        "y_combinator_square": "\uf1d4",
        "yahoo": "\uf19e",
        "yc": "\uf23b",
        "yc_square": "\uf1d4",
        "yelp": "\uf1e9",
        "yen": "\uf157",
        "yoast": "\uf2b1",
        "youtube": "\uf167",
        "youtube_play": "\uf16a",
        "youtube_square": "\uf166",
    }
}
