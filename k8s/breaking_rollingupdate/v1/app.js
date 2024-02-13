const express = require('express');
const cookieParser = require('cookie-parser');

const app = express();
app.use(cookieParser());

app.get('/', (req, res) => {
  // read an existed `authTokenV1` cookie value
  const userToken = req.cookies.authTokenV1;

  if (userToken) {
    msg = 'User is authenticated';
  } else {
    res.cookie('authTokenV1', 'token_value', { httpOnly: true });
    msg = 'User is not authenticated, cookie was set';
  }

  console.log(msg);
  res.send(msg);
});

const port = 8082;
app.listen(port, () => {
  console.log("Server v1 listening");
});
