#!/usr/bin/env python3
import re
import sys

path = sys.argv[1]
url = sys.argv[2]
text = open(path, encoding="utf-8").read()
if re.search(r"^SITE_URL=", text, re.M):
    text = re.sub(r"^SITE_URL=.*", f"SITE_URL={url}", text, flags=re.M)
else:
    text = text.rstrip() + f"\nSITE_URL={url}\n"
open(path, "w", encoding="utf-8").write(text)
print("SITE_URL set")
