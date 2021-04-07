import axios from 'axios';

// const http = axios.create({
//   baseURL: "http://localhost:8080"
// });

export default {

  getCatList() {
    return axios.get('/cats')
  },


}
