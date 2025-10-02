// server.js (modo ESM)
import express from "express";
import cors from "cors";
import pkg from "pg";
const { Pool } = pkg;

const app = express();
app.use(cors());
app.use(express.json());

// Configuración de PostgreSQL
const pool = new Pool({
  user: "postgres.ffeojijdpjqvdckivnat",
  host: "aws-1-eu-central-2.pooler.supabase.com",
  database: "postgres",
  password: "Codesergio38_1",
  port: 5432,
});

app.post("/api/web_info_users_arg", async (req, res) => {
  console.log("POST recibido:", req.body);
  const { nombre, email, telefono, provincia, empresa } = req.body;

  if (!nombre || !email) {
    return res.status(400).json({ error: "Nombre y email son requeridos" });
  }

  try {
    const result = await pool.query(
      `INSERT INTO web_info_users_arg (nombre, email, telefono, provincia, empresa)
       VALUES ($1,$2,$3,$4,$5) RETURNING id`,
      [nombre, email, telefono, provincia, empresa]
    );

    res.json({ ok: true, id: result.rows[0].id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Error guardando en la base de datos" });
  }
});

// Obtener todos los registros de la tabla 'informacion'
app.get("/api/web_info_users_arg", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM web_info_users_arg ORDER BY id ASC");
    res.json(result.rows); // devuelve un array de objetos JSON
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Error al obtener datos" });
  }
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);



app.get("/api/test", (req, res) => {
  res.json({ mensaje: "API funcionando a través de Nginx 🚀" });
});

});
