# Sistema de Gestión de Vacaciones — API REST

Una API REST completa para gestionar vacaciones de trabajadores en una empresa, construida con **Node.js**, **Express** y **MySQL**.


## Características

- Registrar trabajadores y administradores
- Calcular días de vacaciones disponibles según antigüedad
- Solicitud de vacaciones (por días u horas)
- Aprobación o rechazo por parte del administrador
- Registro histórico de solicitudes

## Tecnologías

- Node.js
- Express.js
- MySQL
- dotenv
- mysql2


## 📦 Instalación

```bash
# 1. Clona el repositorio
git clone https://github.com/Pericena/vacaciones.git
cd vacaciones

# 2. Instala dependencias
npm install

# 3. Configura variables de entorno
cp .env.example .env
# Edita .env con tus credenciales de MySQL

# 4. Ejecuta script SQL (en tu gestor MySQL favorito)
# Usa el archivo database.sql proporcionado

# 5. Inicia el servidor
npm run dev
````

## ⚙️ Variables de entorno (.env)

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_password
DB_NAME=vacaciones_db
PORT=3000
```


## Endpoints API


### 👥 Trabajadores

#### Obtener todos los trabajadores

```http
GET /api/trabajadores
```

**curl**:

```bash
curl -X GET http://localhost:3000/api/trabajadores
```


#### Calcular días disponibles según antigüedad

```http
POST /api/trabajadores/:id/actualizar-dias
```

**curl**:

```bash
curl -X POST http://localhost:3000/api/trabajadores/1/actualizar-dias
```

### Administradores

#### Listar administradores

```http
GET /api/admins
```

**curl**:

```bash
curl -X GET http://localhost:3000/api/admins
```


#### Crear un administrador

```http
POST /api/admins
```

**curl**:

```bash
curl -X POST http://localhost:3000/api/admins \
  -H "Content-Type: application/json" \
  -d '{
    "nombre_completo": "Carlos Pérez",
    "email": "carlos@empresa.com"
  }'
```


### Solicitudes de Vacaciones

#### Ver todas las solicitudes

```http
GET /api/solicitudes
```

**curl**:

```bash
curl -X GET http://localhost:3000/api/solicitudes
```

#### Ver solicitudes por trabajador

```http
GET /api/solicitudes?id_trabajador=1
```

**curl**:

```bash
curl -X GET "http://localhost:3000/api/solicitudes?id_trabajador=1"
```

#### Crear una solicitud de vacaciones

```http
POST /api/solicitudes
```

**curl**:

```bash
curl -X POST http://localhost:3000/api/solicitudes \
  -H "Content-Type: application/json" \
  -d '{
    "id_trabajador": 1,
    "fecha_solicitud": "2025-08-01",
    "fecha_inicio": "2025-08-10",
    "fecha_fin": "2025-08-15",
    "cantidad_dias": 5,
    "tipo_solicitud": "día"
  }'
```

---

#### Aprobar o rechazar una solicitud

```http
PUT /api/solicitudes/:id
```

**curl**:

```bash
curl -X PUT http://localhost:3000/api/solicitudes/1 \
  -H "Content-Type: application/json" \
  -d '{
    "estado": "aprobada",
    "observaciones": "Todo correcto",
    "id_administrador": 1
  }'
```

## Lógica del sistema (explicación simple)

1. **Registrar trabajadores**
2. **Registrar administradores**
3. **Registrar política vacacional** (rango de años → días)
4. **Actualizar días disponibles al trabajador**
5. **Crear solicitud de vacaciones**
6. **Aprobar o rechazar la solicitud**
7. **Actualizar días disponibles si fue aprobada**


## 📝 Autor

Desarrollado por **Luishiño Pericena Choque** — para la gestión de vacaciones de empleados.
