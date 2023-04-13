#!/usr/bin/env coffee

> nodemailer
  @w5/strbool
  @w5/assign
  @w5/retry
  ./CONF > SMTP MAIL_FROM

< retry (host, to, subject, text, html)=>
  mail = {
      from:
        name: host
        address: MAIL_FROM
      to
      #: 'iuser.link@gmail.com'
      subject
      #: '您好 '+new Date
      text
      #: 'text 天气不错 Hello world?'
      html
      #: '<b>天气不错 html Hello world?</b><h1>'+new Date+'</h1>'
  }

  try
    transporter = nodemailer.createTransport(SMTP)
    await transporter.sendMail(mail)
  finally
    transporter?.close()
  return
