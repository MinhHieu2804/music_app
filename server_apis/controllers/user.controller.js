const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const { users, Sequelize } = require("../models");
const { Response, Contants } = require("../utils");

const createUser = async (req, res) => {
  try {
    const { username, password, name, email } = req.body;
    const avatarPath = req.file
      ? `/public/images/${req.file.filename}`
      : `/public/images/avatar_default.jpg`;
    const hash_password = bcrypt.hashSync(password, 10);

    const newUser = {
      username,
      password: hash_password,
      name,
      email,
      role: Contants.USER.ROLE.NORMAL,
      image: avatarPath,
    };
    await users.create(newUser);
    const response = new Response(200, "OK! User created.");
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const authenticate = async (req, res) => {
  try {
    const { username, password } = req.body;

    const user = await users.findOne({ where: { username } });

    if (!user) {
      const response = new Response(500, "User not exist!");
      return res.status(500).send(response);
    }

    if (!bcrypt.compareSync(password, user.password)) {
      const response = new Response(
        500,
        "Username or password wrong! Try again."
      );
      return res.status(500).send(response);
    }

    const signData = {
      id: user.id,
      role: user.role,
      username: user.username,
      name: user.name,
      email: user.email,
    };

    const access_token = jwt.sign(signData, process.env.SESSION_SECRET);
    res.status(200).send({ access_token });
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const getAccountInfo = async (req, res) => {
  try {
    const id = req.user_data.id;
    const user = await users.findOne({
      where: { id },
      attributes: ["id", "username", "role", "name", "email"],
    });

    if (!user) {
      const response = new Response(404, "User not exist!");
      return res.status(404).send(response);
    }

    const response = new Response(200, "", user);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

module.exports = {
  createUser,
  authenticate,
  getAccountInfo,
};
