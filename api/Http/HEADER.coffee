> @w5/render/str.js:
  ./CONF.js > DEBUG

export default HEADER = {
  'Access-Control-Allow-Headers':'content-type'
  'Access-Control-Allow-Credentials': 'true'
}

if DEBUG
  HEADER['Access-Control-Allow-Private-Network'] = true
