const express = require('express');
const cookieParser = require('cookie-parser');

const app = express();
app.use(cookieParser());

app.get('/', (req, res) => {
  if (req.cookies.authTokenV1) {
     res.clearCookie('authTokenV1');
     res.cookie('authTokenV2', 'new_token_value', { httpOnly: true });
  }

  // read an existed `authTokenV2` cookie value or legacy cookie `authTokenV1`
  const userToken = req.cookies.authTokenV2;

  if (userToken) {
    msg = 'User is authenticated';
  } else {
    res.cookie('authTokenV2', 'new_token_value', { httpOnly: true });
    msg = 'User is not authenticated, cookie was set';
  }

  console.log(msg);
  res.send(msg);
});

const port = 3000;
app.listen(port, () => {
  console.log("Server v2 listening at http://localhost:3000");
});
