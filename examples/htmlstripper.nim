
#[
So you get HTML like this:

```<div class="_7sjd"><i class="_7sjb img sp_BqX-Srs8YcK sx_b851c2"><u>messages</u></i></div><div class="_1d6j _7sjd fsm fwn fcg"><div class="_6a">Messages</div></div><div class="_1d6k _7sjd"><span class="_51lp _5ugf _5ugh" id="u_fetchstream_1_6">1</span></div></a></div><div class="_1d6i"><a href="/ads/growth/aymt/homepage/panel/redirect/?data=%7B%22selected_object_id%22%3A1550952275230845%2C%22is_collapsed%22%3A0%2C%22object_ids%22%3A%5B1550952275230845%5D%2C%22section%22%3A%22Header+Section%22%2C%22clicked_target%22%3A%22Selected+Page+Notifications+Count%22%2C%22event%22%3A%22click%22%7D&amp;redirect_url=%2Fistrolid%2Fmanager%2F"><div class="_7sjd"><i class="_7sjb img sp_MHk6M-gfm5c sx_d38e37"><u>globe-americas</u></i></div><div class="_1d6j _7sjd fsm fwn fcg"><div class="_6a">Notifications</div></div><div class="_1d6k _7sjd"><span class="_51lp _51lr _5ugf _5ugh" id="u_fetchstream_1_7">20+</span></div></a></div>```

Its almost always best to just strip out all HTML tags and get this:

```
   messages     Messages    1         globe-americas     Notifications    20+
```

Then it becomes trivial to regex for message count and notification count.

]#



import re

var s = """<div class="_7sjd"><i class="_7sjb img sp_BqX-Srs8YcK sx_b851c2"><u>messages</u></i></div><div class="_1d6j _7sjd fsm fwn fcg"><div class="_6a">Messages</div></div><div class="_1d6k _7sjd"><span class="_51lp _5ugf _5ugh" id="u_fetchstream_1_6">1</span></div></a></div><div class="_1d6i"><a href="/ads/growth/aymt/homepage/panel/redirect/?data=%7B%22selected_object_id%22%3A1550952275230845%2C%22is_collapsed%22%3A0%2C%22object_ids%22%3A%5B1550952275230845%5D%2C%22section%22%3A%22Header+Section%22%2C%22clicked_target%22%3A%22Selected+Page+Notifications+Count%22%2C%22event%22%3A%22click%22%7D&amp;redirect_url=%2Fistrolid%2Fmanager%2F"><div class="_7sjd"><i class="_7sjb img sp_MHk6M-gfm5c sx_d38e37"><u>globe-americas</u></i></div><div class="_1d6j _7sjd fsm fwn fcg"><div class="_6a">Notifications</div></div><div class="_1d6k _7sjd"><span class="_51lp _51lr _5ugf _5ugh" id="u_fetchstream_1_7">20+</span></div></a></div>"""

s = re.replace(s, re"<[^>]*>", " ")

echo s

echo findAll(s, re"Messages\s*\d*")
echo findAll(s, re"Notifications\s*\d*")
