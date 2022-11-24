const jwt = require("jsonwebtoken");
const { Response } = require("../utils");

module.exports = (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (authHeader) {
    const token = authHeader.split(" ")[1];

    jwt.verify(token, process.env.SESSION_SECRET, (err, user) => {
      if (err) {
        const response = new Response(403, "403 Forbidden Access is Denied.");
        return res.status(403).send(response);
      }

      req.user_data = user;
      next();
    });
  } else {
    const response = new Response(401, "Not authorized.");
    return res.status(401).send(response);
  }
};
