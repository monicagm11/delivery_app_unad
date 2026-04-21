// functions/index.js
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

exports.createUser = functions.https.onCall(async (data, context) => {

  const password = Math.random().toString(36).slice(-8) +
        Math.random().toString(36).toUpperCase().slice(-4) + "!1";

  const userRecord = await admin.auth().createUser({
    email: data.email,
    password: password,
    displayName: data.name,
  });
  const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: process.env.GMAIL_USER,
      pass: process.env.GMAIL_PASS,
    },
  });

  await transporter.sendMail({
    to: data.email,
    subject: "Bienvenido a Delivery App",
    html: `<p>Tu contraseña temporal es: <b>${password}</b></p>
           <p>Te recomendamos cambiarla al ingresar.</p>`,
  });

  return {uid: userRecord.uid};
});
