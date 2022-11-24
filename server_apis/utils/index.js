class Response {
  constructor(statusCode, message = "", data = {}) {
    this.status = statusCode;
    this.message = message;
    this.data = data;
  }
}

const Contants = {
  USER: {
    ROLE: {
      ADMIN: -1,
      NORMAL: 1,
    },
  },
};

module.exports = { Response, Contants };
