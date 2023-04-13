> _/ENV.js

{MAIL:CONF} = ENV

< MAIL_FROM = CONF.FROM
< SMTP = {
  host: CONF.HOST
  port: +CONF.PORT or 465
  auth:{
    user: CONF.USER or MAIL_FROM
    pass: CONF.PASSWORD
  }
  secure: !!CONF.SECURE
  debug: !!CONF.DEBUG
  logger: !!CONF.LOGGER
}
