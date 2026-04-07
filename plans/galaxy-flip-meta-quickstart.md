# Galaxy Flip + Meta Ray-Ban Quickstart

## Objetivo
Lograr un MVP funcional de voz + visión con:
- Meta Ray-Ban como sensores
- Galaxy Flip como puente
- VisionClaw Android app
- Gemini Live como cerebro de voz/visión
- OpenClaw en el Mac como motor de acciones

## Estado validado en este Mac
- OpenClaw gateway activo en `http://127.0.0.1:18789`
- Health OK
- Endpoint OpenAI-compatible activo en `/v1/chat/completions`
- Modelo válido para OpenClaw bridge: `openclaw`
- Token actual del gateway está configurado

## Arquitectura correcta
Meta glasses -> Meta View app / Android -> VisionClaw Android -> Gemini Live -> OpenClaw Gateway

## Camino más corto real
1. Probar primero en **Phone mode** (sin lentes)
2. Luego activar **Developer Mode** en Meta View
3. Luego usar **Start Streaming** con las gafas

Esto reduce variables y confirma primero voz + cámara + OpenClaw.

## Requisitos
- Galaxy Flip y Mac mini en el mismo Wi-Fi
- Android Studio instalado en un computador donde compilarás la app Android
- GitHub token clásico con `read:packages`
- Gemini API key
- Meta View app en el Galaxy Flip
- Developer Mode habilitable en Meta View

## Repo local
- `/Users/pabloagent/.openclaw/workspace/VisionClaw`
- Android sample: `/Users/pabloagent/.openclaw/workspace/VisionClaw/samples/CameraAccessAndroid`

## Config OpenClaw para la app
Usar estos valores en `Secrets.kt` o en Settings dentro de la app:

```kotlin
const val openClawHost = "http://Mac.local"
const val openClawPort = 18789
const val openClawGatewayToken = "1318becf025d4780ef2ebf3b6bc91c6ead72f40acc37a1ad"
```

## Ojo importante
Si el sample usa el endpoint OpenAI-compatible de OpenClaw, el modelo correcto es:

```text
openclaw
```

No usar `openai/gpt-5.4` en `/v1/chat/completions` del gateway.

## Android app setup
### 1. GitHub Packages token
En `samples/CameraAccessAndroid/local.properties`:

```properties
github_token=TU_GITHUB_TOKEN
```

### 2. Secrets
Crear desde ejemplo:

`VisionClaw/samples/CameraAccessAndroid/app/src/main/java/com/meta/wearable/dat/externalsampleapps/cameraaccess/Secrets.kt`

basado en `Secrets.kt.example`.

### 3. Valores mínimos en Secrets.kt
- `geminiAPIKey`
- `openClawHost`
- `openClawPort`
- `openClawGatewayToken`

## Orden de prueba
### Fase A — sin gafas
1. Instalar y correr app en Galaxy Flip
2. Tap `Start on Phone`
3. Tap botón AI
4. Confirmar:
   - te oye
   - te responde por voz
   - ve por la cámara del teléfono
   - puede llamar OpenClaw

### Fase B — con gafas
1. Abrir Meta View
2. Habilitar Developer Mode
3. En VisionClaw: `Start Streaming`
4. Tap botón AI
5. Confirmar voz + visión desde gafas

## Si falla
### App no compila
- revisar `github_token`
- verificar acceso a GitHub Packages

### No conecta a OpenClaw
- revisar que ambos equipos estén en mismo Wi-Fi
- cambiar `Mac.local` por hostname/IP LAN real del Mac
- probar `http://<host>:18789/health` desde el teléfono/navegador si hace falta

### Gemini no responde
- revisar `geminiAPIKey`
- revisar permisos de mic/cámara

## Decisión tomada
No seguir por Telegram/WhatsApp/Slack para live.
La ruta prioritaria es:
- Galaxy Flip bridge
- VisionClaw Android
- Meta Ray-Ban después de validar phone mode primero
