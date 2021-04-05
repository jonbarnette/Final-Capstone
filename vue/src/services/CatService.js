import axios from 'axios';

export default {

  getCatList() {
    return axios.get('/cats')
  }


}
