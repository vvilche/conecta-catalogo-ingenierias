# Catálogo de Ingenierías — Canal / Socio CONECTA

Catálogo HTML de empresas de ingeniería y construcción industrial en Chile (tipo PUMA)
que sirven como CANAL o SOCIO para CONECTA Ingeniería (SCADA, PMU, RTU, protecciones
IEC 61850, DCS SUPCON, instrumentación y válvulas).

## Estructura
- `index.html` — grid de tarjetas; cada tarjeta enlaza a su ficha.
- `ficha_<empresa>.html` — ficha con 5 secciones: Quién es · Qué hace · Proyectos/clientes ·
  Tomadores de decisión · Ángulo CONECTA.
- `research/*.json` — datos crudos con fuentes verificables (origen de las fichas).
- `build/generate.py` — regenera index + fichas desde los JSON.

## Reglas de datos
- Nada se inventa: sin fuente pública verificable → campo vacío ("no verificado").
- Cada dato cita su URL de fuente (formato "↳ url").
- Prioridad a cargos TÉCNICOS (no solo gerente general).

## Rebuild
```bash
python3 build/generate.py
```
