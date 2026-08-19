# Guía de investigación — Catálogo de Ingenierías (CANAL/SOCIO para CONECTA)

## Contexto comercial (para entender el ángulo)
CONECTA Ingeniería = integrador eléctrico chileno: SCADA, PMU, RTU, protecciones IEC 61850,
DCS SUPCON (representante en Chile), instrumentación y válvulas. NO hace obra gruesa:
subcontrata o se asocia con quien hace la ingeniería/montaje del proyecto.
Buscamos empresas tipo PUMA (Puga Mujica): EPC/EPCM industrial, integradores de control,
montajistas eléctricos/instrumentación, consultoras que especifican I&C.

## REGLAS NO NEGOCIABLES
1. NO inventar nombres, correos, teléfonos, montos, RUT ni facturación. Sin fuente pública
   verificable → escribir "no verificado" y dejar el campo vacío.
2. Cada dato lleva su URL de fuente. Nada suelto. Si no hay fuente, no va.
3. NO quedarse con el gerente general. Priorizar cargos TÉCNICOS que especifican/compran
   control: gerente de proyectos, jefe de ingeniería, jefe I&C/automatización,
   jefe de propuestas/licitaciones, jefe de abastecimiento/compras.
4. Tono técnico B2B. Sin precios inventados, sin promesas.
5. Contactos solo verificados: correo/teléfono desde sitio oficial, LinkedIn, guiaminera.cl,
   direcmin.com, snifa.sma.gob.cl, pertinencia.sea.gob.cl, dequienes.cl, cmfchile.cl,
   diario oficial. El formato @dominio.cl "inferido" debe marcarse explícitamente como
   "formato inferido, a verificar".

## Herramientas disponibles
- Búsqueda web live (AISA gpt-5-search-api), con URLs de fuente reales:
  `python3 ~/conecta-catalogo-ingenierias/research/aisa_search.py "consulta en español"`
  (pide siempre "nombre real + cargo + fuente verificable (URL). No inventes.")
- Extraer contenido de una URL:
  `python3 ~/conecta-catalogo-ingenierias/research/aisa_search.py "resume esta página: URL"`
  o curl para scrapear. Para páginas con Cloudflare usar: `curl -s "https://r.jina.ai/URL" -H "Accept: text/plain"`
- Verificar contactos del sitio oficial (mailto:/tel:):
  ```
  curl -sL "https://empresa.cl/contacto" -A "Mozilla/5.0" -o /tmp/c.html
  grep -oE 'mailto:[a-z0-9._%+-]+@[a-z0-9.-]+' /tmp/c.html | sort -u
  grep -oE 'tel:[0-9+]+' /tmp/c.html | sort -u
  grep -oE 'property="og:description"[^>]*' /tmp/c.html   # suele traer nombre+teléfono juntos
  ```
- LinkedIn: para verificar cargo de una persona. Si no hay perfil real, usar link de búsqueda:
  `https://www.linkedin.com/search/results/people/?keywords=Nombre%20Apellido%20Empresa`

## Esquema JSON de salida (UN archivo por empresa)
Escribir en `~/conecta-catalogo-ingenierias/research/<slug>.json`:
```json
{
  "empresa": "Nombre legal",
  "slug": "nombre-en-min",
  "rubro": "una línea",
  "clasificacion": "CANAL | SOCIO | COMPETIDOR | CLIENTE FINAL",
  "justificacion_angulo": "1 línea: por qué le sirve a CONECTA",
  "quien_es": {
    "descripcion": "...",
    "fundada": "...", "dotacion": "...", "facturacion": "...",
    "matriz_grupo": "...", "rut": "...", "sede": "...",
    "fuentes": ["url"]
  },
  "que_hace": {
    "servicios": ["..."],
    "rol_cadena": "¿EPC completo o subcontrata la especialidad eléctrica/control?",
    "fuentes": ["url"]
  },
  "proyectos": [
    {"proyecto": "...", "cliente": "...", "ubicacion": "...", "monto": "...", "fuente": "url"}
  ],
  "tomadores": [
    {"nombre": "...", "cargo": "...", "tipo": "gerente_proyectos|jefe_ingenieria|jefe_ic|jefe_propuestas|abastecimiento|gerente_general",
     "correo": "...", "telefono": "...", "linkedin": "url", "fuente": "url"}
  ],
  "contacto_corporativo": {
    "direccion": "...", "telefono": "...", "correo": "...", "web": "url", "fuente": "url"
  }
}
```

## Al terminar
1. Escribir el JSON con `write_file`.
2. En tu resumen final: listar qué encontraste verificable y qué quedó como "no verificado".
3. NO inventar. Si AISA se niega a dar contactos privados de una empresa chica, buscarlos
   en el sitio oficial (página de contacto) — ahí suele estar el correo/teléfono real.

Empresas asignadas: ver el goal de tu tarea.
