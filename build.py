#!/usr/bin/env python3

import os, sys
from pathlib import Path
from distutils.dir_util import copy_tree, remove_tree
import markdown

SUPPORTED_EXTENSIONS = [ ".md" ]

HTML_TEMPLATE = """

<!DOCTYPE html>
<html>

<head>
    <link href="./resources/css/index.css" type="text/css" rel="stylesheet">
<style>
 <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Navbar</title>
    <link rel="stylesheet" type="text/css" 
          href="index.css">
</style>
  <title></title>
</head>

<body>

<h1>Gröbner basis benchmark</h1>

<div class="navbar" id="myNavbar">
        <a href="about.html">About</a>
        <a href="">Systems</a>
        <a href="contribute.html">Contribute</a>
        <a href="logs.html">Logs</a>
        <a href="https://github.com/sumiya11/GroebnerBenchmark">GitHub</a>

        <a href="javascript:void(0);"
           class="icon"
           onclick="toggleMenu()">
            &#9776;
        </a>
    </div>

<script>
    function toggleMenu() {
        let navbar = document.getElementById("myNavbar");
        navbar.className = navbar.className === "navbar" ?
                            "navbar responsive" : "navbar";
    }
</script>
    
<@ @>

</body>
</html>
"""

def read_systems_data(systems_dir: Path) -> dict:
    print(f"Reading systems from: {systems_dir.resolve().absolute()}")
    systems = {}
    for system in os.listdir(systems_dir):
        root = systems_dir / system
        print(f"  Reading {system}")
        systems[system] = {}
        description_filepath = system + SUPPORTED_EXTENSIONS[0]
        with open(root / description_filepath, 'r', encoding='UTF-8') as file:
            description = file.read()
            systems[system]["content"] = description
    return systems            
    
def populate_html(systems: dict) -> str:
    print("Populating index.html")
    body = "<hr>"
    system_names = sorted(list(systems.keys()))
    for system in system_names:
        content = systems[system]["content"]
        content = markdown.markdown(content)
        body = body + "<div class=\"container\">" + content + "</div>" + "\n<hr>\n"
    
    return HTML_TEMPLATE.replace("<@ @>", body)

def write_build(build_dir: Path, systems_dir: Path, sources_dir: Path, html: str):
    print(f"Writing build files to: {build_dir.resolve().absolute()}")
    if os.path.exists(build_dir):
        remove_tree(str(build_dir))
    build_dir.mkdir()
    copy_tree(str(systems_dir), str(build_dir / systems_dir.stem))
    copy_tree(str(sources_dir), str(build_dir))
    with open(build_dir / "index.html", "w", encoding="UTF-8") as output:
        output.write(html)

def main(systems_dir: Path, sources_dir: Path, build_dir: Path):
    systems = read_systems_data(systems_dir)
    html = populate_html(systems)
    write_build(build_dir, systems_dir, sources_dir, html)
        
main(
    systems_dir=Path("systems"),
    sources_dir=Path("website"),
    build_dir=Path("build"),
)
