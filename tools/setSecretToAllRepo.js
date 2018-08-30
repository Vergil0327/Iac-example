const axios = require('axios')
const cmd = require('node-cmd')

axios.get('http://192.168.1.143:10078/api/v1/orgs/RELAJET/repos')
  .then(response => {
    response.data.forEach(({ full_name: fullName }) => {
      console.log(`
      Run command: drone secret add --repository ${fullName} --image plugins/webhook --name webhook_urls --value http://192.168.1.143:8080/hooks/HLWwFExHw6LF882Wb/5EeNLW4BWFPqYetEu75AxiKrARPLLWCiZK3K3fF88jZA37Hw`)
      cmd.run(`drone secret add --repository ${fullName} --image plugins/webhook --name webhook_urls --value http://192.168.1.143:8080/hooks/HLWwFExHw6LF882Wb/5EeNLW4BWFPqYetEu75AxiKrARPLLWCiZK3K3fF88jZA37Hw`)
    })
    process.exit(0);
  })