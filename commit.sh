#!/bin/bash
set -e
cd ~/conecta-catalogo-ingenierias

# Orden: CANAL, SOCIO, CLIENTE FINAL, COMPETIDOR (igual que el generador)
order='{"CANAL":0,"SOCIO":1,"CLIENTE FINAL":2,"COMPETIDOR":3}'

python3 - "$order" <<'PYEOF' > /tmp/commit_list.txt
import json, glob, os, re, sys
order = json.loads(sys.argv[1])
def slugify(s):
    s = s.lower().strip()
    s = re.sub(r'[^a-z0-9]+', '_', s)
    return s.strip('_')
rows = []
for f in glob.glob(os.path.expanduser('~/conecta-catalogo-ingenierias/research/*.json')):
    d = json.load(open(f))
    slug = slugify(d.get('slug') or d['empresa'])
    clas = (d.get('clasificacion') or '').strip().upper()
    key = order.get(clas, 9)
    rows.append((key, d['empresa'], clas, slug, os.path.basename(f)))
rows.sort(key=lambda r: (r[0], r[1]))
for r in rows:
    print(f"{r[4]}\t{r[3]}\t{r[1]}\t{r[2]}")
PYEOF

while IFS=$'\t' read -r json slug empresa clas; do
  git add "research/$json" "ficha_$slug.html"
  git commit -q -m "Ficha $empresa: $clas"
done < /tmp/commit_list.txt

git add index.html build README.md research/GUIA_RESEARCH.md research/aisa_search.py
git commit -q -m "Catálogo completo: index.html + 19 fichas (CANAL/SOCIO/COMPETIDOR)"

echo "=== git log ==="
git log --oneline | head -25
