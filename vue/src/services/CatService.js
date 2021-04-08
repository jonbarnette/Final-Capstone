import axios from 'axios';

// const http = axios.create({
//   baseURL: "http://localhost:8080"
// });

export default {

    getCatList() {
        return axios.get('/cats')
    },

    getCatDetails() {
        return axios.get('/cats/${cat_id}')
    },

    addCat(cat) {
        return axios.post('/cats', cat)
    }


}